'use client'

import { Song } from '@/app.types'
import { SongItem } from '@/components/SongItem'
import useOnPlay from '@/hooks/useOnPlay'

type Props = {
  songs: Song[]
}

export const PageContent = ({ songs }: Props) => {
  const onPlay = useOnPlay(songs)

  if (!songs?.length) {
    return <div className="mt-4 text-neutral-400">No songs available.</div>
  }

  return (
    <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 2xl:grid-cols-8 gap-4 mt-4">
      {songs?.map((song) => (
        <SongItem key={song.id} onClick={(id) => onPlay(id)} data={song} />
      ))}
    </div>
  )
}
