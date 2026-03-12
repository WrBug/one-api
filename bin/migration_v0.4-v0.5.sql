-- Add system_prompt_mode column to channels table
-- 0 = replace existing system prompt (default, original behavior)
-- 1 = append channel's system prompt to the beginning of existing system prompt

ALTER TABLE channels ADD COLUMN IF NOT EXISTS system_prompt_mode INTEGER NOT NULL DEFAULT 0;
