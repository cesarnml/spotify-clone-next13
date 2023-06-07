'use client'

import { Song } from '@/app.types'
import { useLoadImage } from '@/hooks/useLoadImage'
import Image from 'next/image'

type Props = {
  data: Song
  onClick: (id: string) => void
}

export const SongItem = ({ data, onClick }: Props) => {
  const imagePath = useLoadImage(data)

  return (
    <div
      className="relative group flex flex-col items-center justify-center rounded-md overflow-hidden gap-4 bg-neutral-400/5 cursor-pointer hover:bg-neutral-400/10 transition p-3"
      onClick={() => {
        onClick(data.id)
      }}
    >
      <div className="relative aspect-square w-full h-full rounded-md overflow-hidden">
        <Image className="object-cover" src={imagePath ?? '/images/liked.png'} alt="album" fill />
      </div>
    </div>
  )
}
