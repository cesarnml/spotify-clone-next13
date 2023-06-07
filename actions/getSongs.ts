import { Song } from '@/app.types'
import { Database } from '@/db.types'
import { createServerComponentClient } from '@supabase/auth-helpers-nextjs'
import { cookies } from 'next/dist/client/components/headers'

export const getSongs = async (): Promise<Song[] | null> => {
  const supabase = createServerComponentClient<Database>({
    cookies,
  })

  const { data, error } = await supabase
    .from('songs')
    .select('*')
    .order('created_at', { ascending: false })

  if (error) {
    console.log(error)
  }

  return data
}
