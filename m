From: rlnelson@google.com (Rob Nelson)
Date: Wed, 27 Aug 2014 11:01:05 -0700
Subject: Slower operations with NVMe and MD
Message-ID: <CALu-fzszdzo116Ma7-grG0pfhB8L7QUUMinooy-RF5tqw8m+OA@mail.gmail.com>

Hi All,

I noticed the discard slowiness issue when running an md configuration
[1] on top of 4 nvme namespaces (md device is around 3Tb). E.g.

$ time blkdiscard /dev/md0
real 48m47.502s
user 0m0.000s
sys 0m1.352s

What I discovered was the nvme device was only getting md chunksize
discard request sizes (default is 512K). I'm guessing this is due to
nomerging within in the block layer? Of course when I run blkdiscard
/dev/nvme0n1, I see discard sizes around 200M.  Any ideas on how I can
speed this up? I'm willing to send out a patch but I'm just not sure
what's the exact problem here.

Thanks!

[1] mdadm --create --verbose /dev/md0 --level=stripe --raid-devices=4
/dev/nvme0n[1-4]

-- 
cheers, Rob
