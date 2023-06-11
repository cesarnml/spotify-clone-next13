import { createServerComponentClient } from '@supabase/auth-helpers-nextjs'
import { cookies } from 'next/headers'

import { Song } from '@/app.types'
import { Database } from '@/db.types'
import { getSongs } from './getSongs'

const getSongsByTitle = async (search: string): Promise<Song[]> => {
  const supabase = createServerComponentClient<Database>({
    cookies,
  })

  if (!search) {
    const allSongs = await getSongs()
    return allSongs ?? []
  }

  const { data, error } = await supabase
    .from('songs')
    .select('*')
    .or(`title.ilike.%${search}%, author.ilike.%${search}%`)
    .order('created_at', { ascending: false })

  if (error) {
    console.log(error.message)
  }

  return data ?? []
}

export default getSongsByTitle
