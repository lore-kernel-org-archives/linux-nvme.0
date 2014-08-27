From: keith.busch@intel.com (Keith Busch)
Date: Wed, 27 Aug 2014 12:55:17 -0600 (MDT)
Subject: Slower operations with NVMe and MD
In-Reply-To: <CALu-fzszdzo116Ma7-grG0pfhB8L7QUUMinooy-RF5tqw8m+OA@mail.gmail.com>
References: <CALu-fzszdzo116Ma7-grG0pfhB8L7QUUMinooy-RF5tqw8m+OA@mail.gmail.com>
Message-ID: <alpine.LRH.2.03.1408271246050.4696@AMR>

On Wed, 27 Aug 2014, Rob Nelson wrote:
> I noticed the discard slowiness issue when running an md configuration
> [1] on top of 4 nvme namespaces (md device is around 3Tb). E.g.
>
> $ time blkdiscard /dev/md0
> real 48m47.502s
> user 0m0.000s
> sys 0m1.352s
>
> What I discovered was the nvme device was only getting md chunksize
> discard request sizes (default is 512K). I'm guessing this is due to
> nomerging within in the block layer? Of course when I run blkdiscard
> /dev/nvme0n1, I see discard sizes around 200M.  Any ideas on how I can
> speed this up? I'm willing to send out a patch but I'm just not sure
> what's the exact problem here.

Hi Rob,

Since we're a bio-based driver, we don't get the benefits of merging. Maybe
this is something for the blk-mq nvme driver.

In md, the max discard sectors is set to the chunk size:

 	blk_queue_max_discard_sectors(mddev->queue, mddev->chunk_sectors);

The nvme driver is just going to issue these commands as it receives them,
so I'm not sure what we can do from there to speed it up.  Maybe we can
change md instead with larger discard sector count and have it split
requests accordingly. ?
