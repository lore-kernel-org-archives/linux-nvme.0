From: tom.leiming@gmail.com (Ming Lei)
Date: Tue, 16 Jul 2019 15:12:06 +0800
Subject: nvme-5.3 ssd performance regression
In-Reply-To: <798a3907573b910fbb102036afe3dfc1405fb353.camel@kernel.crashing.org>
References: <798a3907573b910fbb102036afe3dfc1405fb353.camel@kernel.crashing.org>
Message-ID: <CACVXFVP8w3mzQ8XVgeif=Nq3kyiZopS0XDB+-c2x5CcT9V3djA@mail.gmail.com>

On Tue, Jul 16, 2019 at 9:05 AM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> Hi !
>
> Something I noticed while testing those patches for the Apple drives.
>
> With 5.2.0 (and those patches):
>
> [benh at mini ~]$ sudo hdparm -tf /dev/nvme0n1
>
> /dev/nvme0n1:
>  HDIO_DRIVE_CMD(identify) failed: Inappropriate ioctl for device
>  Timing buffered disk reads: 5960 MB in  3.00 seconds = 1986.22 MB/sec
>
> (The numbers are reasonably stable accross multiple runs)
>
> With nvme-5.3 (and those patches & the ctrl->opts NULL fix)
>
> [benh at mini linux]$ sudo hdparm -tf /dev/nvme0n1
>
> /dev/nvme0n1:
>  HDIO_DRIVE_CMD(identify) failed: Inappropriate ioctl for device
>  Timing buffered disk reads: 4520 MB in  3.00 seconds = 1506.63 MB/sec
> [benh at mini linux]$ sudo hdparm -tf /dev/nvme0n1
>
> Here too, the numbers are quite stable during a given boot but
> interestingly they seem to change from boot to boot, I also observed
> 1700 MB/s for example. It's a rather major regression.
>
> The .config is identical in both cases (an x86_64-defconfig with a
> small tweak or two, I removed more drivers mostly and made nvme a
> module)
>
> In both cases the io scheduler is mq-deadline. The device has a single
> IO queue.

It should be caused by the following commit, and that patch uses
single mapping size to limit max hw sectors, and looks that way
is wrong. For example, on qemu, max_hw_sectors is decreased to
512. You can try to revert the patch and see if it makes a difference.

I feel we might need the max segment size limit too.

commit 7637de311bd2124b298a072852448b940d8a34b9
Author: Christoph Hellwig <hch at lst.de>
Date:   Wed Jul 3 09:54:44 2019 -0700

    nvme-pci: limit max_hw_sectors based on the DMA max mapping size



Thanks,
Ming Lei
