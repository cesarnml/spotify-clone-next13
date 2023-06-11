import { Song } from '@/app.types'
import { Database } from '@/db.types'
import { createServerComponentClient } from '@supabase/auth-helpers-nextjs'
import { cookies } from 'next/headers'

const getSongById = async (id: string): Promise<Song | null> => {
  const supabase = createServerComponentClient<Database>({
    cookies,
  })

  const { data, error } = await supabase.from('songs').select('*').eq('id', id).single()

  if (error) {
    console.log(error.message)
  }

  return data
}

export default getSongById
