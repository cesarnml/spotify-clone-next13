import { Song } from '@/app.types'
import { Database } from '@/db.types'
import { useSupabaseClient } from '@supabase/auth-helpers-react'

const useLoadSongUrl = (song: Song) => {
  const supabaseClient = useSupabaseClient<Database>()

  if (!song || !song.song_path) {
    return ''
  }

  const { data: songData } = supabaseClient.storage.from('songs').getPublicUrl(song.song_path)

  return songData.publicUrl
}

export default useLoadSongUrl
