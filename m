From: vedant@lath.in (Vedant Lath)
Date: Wed, 11 Nov 2015 02:46:19 +0530
Subject: nvme: controller resets
In-Reply-To: <3dda89a86dbd6c8ede4057884c43170c@localhost>
References: <33aa688b8da3f41960d36e66aa1703d8@localhost>
 <20151110155110.GA31697@localhost.localdomain>
 <3dda89a86dbd6c8ede4057884c43170c@localhost>
Message-ID: <CAKajsGMkdckHbYyb8XY=ByYsHF0=-cNA2o5RnTN0XKVSopyiDQ@mail.gmail.com>

> Starting the kernel with nr_cpus=1 didn't change anything although race
> conditions are probably still possible due to async signalling or
> interrupts.
>
>
> The only thing that might still explain something: 'nvme show-regs'
> suffers from the same problems with readq. If for any reason other
> userspace tools work in a similar way to read the controller's
> capabilities, it has to fail.
>
> But I know of no reason why, e.g. mkfs.btrfs should do somehting like
> that.

I was able to run mkfs.btrfs successfully two times (without strace).
Once with btrfs-progs v3.17 and second time with btrfs-progs v4.3.
However my third attempt produced a similar error as yours. So your
successful runs with mkfs.btrfs might not have been related to strace
but might be the nature of this intermittent error.

partprobe always resulted in a crash for me.

I tried nvme-cli to get the error log but that was empty.

> $ sudo ./nvme get-feature /dev/nvme0 -f 0x07 -H
> get-feature: 0x07 (Number of Queues), Current value: 00000000
>         Number of IO Completion Queues Allocated (NCQA): 1
>         Number of IO Submission Queues Allocated (NSQA): 1

Does this mean the SSD supports only one queue? But all features from
0x00 to 0x0B return 0 so I'm not sure how if that value is legitimate.

Could you please check if the firmware version of your SSD is the same
as mine? I have posted details given by nvme-cli at
http://pastebin.ubuntu.com/13049434/ .
