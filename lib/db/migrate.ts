import { migrate } from 'drizzle-orm/node-postgres/migrator'
import { db } from './index'

async function runMigrations() {
  try {
    await migrate(db, { migrationsFolder: './drizzle' })
    console.log('✅ Migration complete!')
  } catch (err) {
    console.error('❌ Migration failed:', err)
    process.exit(1)
  }
}

runMigrations()

