import { pgTable, serial, text } from 'drizzle-orm/pg-core'

export const agents = pgTable('agents', {
  id: serial('id').primaryKey(),
  name: text('name').notNull(),
})

