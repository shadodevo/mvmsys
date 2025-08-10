# Environment Variables Setup

This document explains the environment variables used in the WorkSuite application.

## Environment Files

### 1. `.env` - Main Environment File
This is the primary environment file used by the application. It contains all the necessary configuration variables.

### 2. `.env.example` - Example File
A template file that shows all available environment variables. This file should be committed to version control as a reference.

### 3. `.env.local` - Local Development
For local development settings. This file should NOT be committed to version control.

### 4. `.env.production` - Production Settings
For production environment settings. This file should NOT be committed to version control.

## Required Environment Variables

### Database Configuration
- `DATABASE_URL`: Database connection string
  - Development: `file:./dev.db` (SQLite)
  - Production: `postgresql://username:password@localhost:5432/worksuite_prod`

### Application Configuration
- `NODE_ENV`: Environment (`development` or `production`)
- `NEXTAUTH_SECRET`: Secret key for NextAuth.js
- `NEXTAUTH_URL`: Application URL

### Essential API Keys
- `OPENAI_API_KEY`: OpenAI API key for AI features
- `STRIPE_PUBLISHABLE_KEY`: Stripe publishable key for payments
- `STRIPE_SECRET_KEY`: Stripe secret key for payments

### Email Configuration
- `EMAIL_SERVER_HOST`: SMTP server host
- `EMAIL_SERVER_PORT`: SMTP server port
- `EMAIL_SERVER_USER`: SMTP username
- `EMAIL_SERVER_PASSWORD`: SMTP password
- `EMAIL_FROM`: Default from email address

## Optional Environment Variables

### Cloud Storage (AWS S3)
- `AWS_ACCESS_KEY_ID`: AWS access key
- `AWS_SECRET_ACCESS_KEY`: AWS secret key
- `AWS_REGION`: AWS region
- `AWS_S3_BUCKET`: S3 bucket name

### Communication
- `TWILIO_ACCOUNT_SID`: Twilio account SID
- `TWILIO_AUTH_TOKEN`: Twilio auth token
- `TWILIO_PHONE_NUMBER`: Twilio phone number

### Monitoring & Analytics
- `GOOGLE_ANALYTICS_ID`: Google Analytics tracking ID
- `SENTRY_DSN`: Sentry DSN for error tracking

### Security
- `CORS_ORIGIN`: Allowed CORS origins
- `JWT_SECRET`: JWT secret key
- `SESSION_SECRET`: Session secret key

### Performance
- `REDIS_URL`: Redis connection string for caching
- `ENABLE_COMPRESSION`: Enable response compression
- `ENABLE_CACHING`: Enable caching

## Setup Instructions

### 1. For Local Development

1. Copy the example file:
   ```bash
   cp .env.example .env.local
   ```

2. Edit `.env.local` with your local settings:
   ```bash
   # Database
   DATABASE_URL="file:./dev.db"
   
   # Application
   NODE_ENV="development"
   NEXTAUTH_SECRET="dev-secret-key"
   NEXTAUTH_URL="http://localhost:3000"
   
   # Email (optional for development)
   EMAIL_SERVER_HOST="smtp.gmail.com"
   EMAIL_SERVER_PORT="587"
   EMAIL_SERVER_USER="your-email@gmail.com"
   EMAIL_SERVER_PASSWORD="your-app-password"
   ```

3. Install dependencies and run:
   ```bash
   npm install
   npm run dev
   ```

### 2. For Production

1. Copy the example file:
   ```bash
   cp .env.example .env.production
   ```

2. Edit `.env.production` with production settings:
   ```bash
   # Database
   DATABASE_URL="postgresql://user:pass@localhost:5432/worksuite_prod"
   
   # Application
   NODE_ENV="production"
   NEXTAUTH_SECRET="generate-strong-secret"
   NEXTAUTH_URL="https://yourdomain.com"
   
   # Required API Keys
   OPENAI_API_KEY="your-openai-key"
   STRIPE_PUBLISHABLE_KEY="pk_live_..."
   STRIPE_SECRET_KEY="sk_live_..."
   ```

3. Deploy your application with the production environment file.

## Security Best Practices

### 1. Never Commit Sensitive Data
- `.env.local` and `.env.production` should NEVER be committed to version control
- Use `.env.example` as a template only

### 2. Use Strong Secrets
Generate strong random secrets for:
- `NEXTAUTH_SECRET`
- `JWT_SECRET`
- `SESSION_SECRET`
- `WEBHOOK_SECRET`

You can generate secrets using:
```bash
# Generate a random secret
openssl rand -base64 32
```

### 3. Environment-Specific Settings
- Development: More permissive settings for debugging
- Production: Strict security settings and optimizations

### 4. API Key Management
- Use different API keys for development and production
- Regularly rotate API keys in production
- Use environment-specific API keys when possible

## Common Issues

### 1. Database Connection Errors
- Ensure `DATABASE_URL` is correct
- Check if database server is running
- Verify database credentials

### 2. Email Not Working
- Verify SMTP settings
- Check if app passwords are enabled (for Gmail)
- Ensure correct port number

### 3. API Key Errors
- Verify API keys are correct and active
- Check if API keys have proper permissions
- Ensure billing is enabled for paid services

### 4. Build Errors
- Ensure all required environment variables are set
- Check for syntax errors in environment files
- Verify file encoding (should be UTF-8)

## Testing Environment Variables

You can test if environment variables are loaded correctly by:

1. Creating a test API route:
   ```javascript
   // src/app/api/env/route.ts
   export function GET() {
     return Response.json({
       databaseUrl: process.env.DATABASE_URL,
       nodeEnv: process.env.NODE_ENV,
       // Add other variables to test
     })
   }
   ```

2. Accessing `/api/env` in your browser

## Environment Variables Reference

| Variable | Description | Default | Required |
|----------|-------------|---------|----------|
| `DATABASE_URL` | Database connection string | - | Yes |
| `NODE_ENV` | Environment | `development` | Yes |
| `NEXTAUTH_SECRET` | NextAuth secret | - | Yes |
| `NEXTAUTH_URL` | Application URL | - | Yes |
| `OPENAI_API_KEY` | OpenAI API key | - | Yes |
| `STRIPE_PUBLISHABLE_KEY` | Stripe publishable key | - | Yes |
| `STRIPE_SECRET_KEY` | Stripe secret key | - | Yes |
| `EMAIL_SERVER_HOST` | SMTP host | - | No |
| `EMAIL_SERVER_PORT` | SMTP port | `587` | No |
| `REDIS_URL` | Redis URL | - | No |
| `AWS_ACCESS_KEY_ID` | AWS access key | - | No |
| `AWS_SECRET_ACCESS_KEY` | AWS secret key | - | No |
| `GOOGLE_ANALYTICS_ID` | Google Analytics ID | - | No |
| `SENTRY_DSN` | Sentry DSN | - | No |
| `DEBUG` | Debug mode | `false` | No |
| `TIMEZONE` | Application timezone | `UTC` | No |
| `DEFAULT_PAGE_SIZE` | Default pagination size | `20` | No |
| `MAX_FILE_SIZE` | Max file upload size | `10485760` | No |

For a complete list, refer to `.env.example`.