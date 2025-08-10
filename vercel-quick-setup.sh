#!/bin/bash

# MVM Studio Vercel Deployment Script
# هذا السكريبت لنشر MVM Studio على Vercel

echo "🚀 بدء نشر MVM Studio على Vercel..."

# التحقق من وجود Node.js
if ! command -v node &> /dev/null; then
    echo "❌ Node.js غير مثبت. يرجى تثبيته أولاً."
    exit 1
fi

# التحقق من وجود npm
if ! command -v npm &> /dev/null; then
    echo "❌ npm غير مثبت. يرجى تثبيته أولاً."
    exit 1
fi

# التحقق من وجود Vercel CLI
if ! command -v vercel &> /dev/null; then
    echo "📦 تثبيت Vercel CLI..."
    npm install -g vercel
fi

# بناء التطبيق
echo "🏗️  بناء التطبيق..."
npm run build

if [ $? -ne 0 ]; then
    echo "❌ فشل بناء التطبيق. يرجى التحقق من الأخطاء."
    exit 1
fi

echo "✅ تم بناء التطبيق بنجاح!"

# إنشاء ملف vercel.json إذا لم يكن موجوداً
if [ ! -f "vercel.json" ]; then
    echo "📝 إنشاء ملف vercel.json..."
    cat > vercel.json << 'EOF'
{
  "version": 2,
  "builds": [
    {
      "src": "package.json",
      "use": "@vercel/next"
    }
  ],
  "routes": [
    {
      "src": "/(.*)",
      "dest": "/$1"
    }
  ],
  "env": {
    "NODE_ENV": "production"
  }
}
EOF
    echo "✅ تم إنشاء ملف vercel.json"
fi

# تسجيل الدخول إلى Vercel
echo "🔐 تسجيل الدخول إلى Vercel..."
vercel login

# النشر الأولي
echo "🚀 نشر التطبيق على Vercel..."
vercel

# نشر للإنتاج
echo "🌐 نشر التطبيق للإنتاج..."
vercel --prod

echo ""
echo "✅ تم النشر بنجاح!"
echo ""
echo "📋 الخطوات التالية:"
echo "   1. اذهب إلى vercel.com واختر مشروعك"
echo "   2. اذهب إلى Settings > Domains"
echo "   3. أضف نطاقك (yourdomain.com)"
echo "   4. في GoDaddy DNS، أضف:"
echo "      Type: A"
echo "      Name: @"
echo "      Value: 76.76.21.21"
echo "      TTL: 1 Hour"
echo "   5. انتظر 24-48 ساعة لتحديث DNS"
echo ""
echo "🎉 مبروك! MVM Studio الآن يعمل على Vercel!"
echo ""
echo "📞 إذا واجهت مشاكل:"
echo "   - تحقق من سجلات DNS في GoDaddy"
echo "   - تأكد من إعدادات النطاق في Vercel"
echo "   - انتظر حتى يتم تحديث DNS"
echo ""
echo "🔗 روابط مفيدة:"
echo "   - Vercel Dashboard: https://vercel.com/dashboard"
echo "   - Vercel Docs: https://vercel.com/docs"
echo "   - GoDaddy DNS: https://dcc.godaddy.com"
