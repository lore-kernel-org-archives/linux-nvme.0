From: kevin@umd.edu (Kevin M. Hildebrand)
Date: Wed, 22 Nov 2017 15:09:19 -0500
Subject: NVMe array support
In-Reply-To: <329VkVTTB6304S04.1511378401@web04.cms.usa.net>
References: <CAJmU7Q=P0cnSU1U0nVu3Tk8_kAajVEra1OWUPxCt8ZD3Qio9cA@mail.gmail.com>
 <329VkVTTB6304S04.1511378401@web04.cms.usa.net>
Message-ID: <CAJmU7Qkx34J6CG89NUP8UM7faY9swm23+2n4j12O2x5C+o+Feg@mail.gmail.com>

You're using linux MD raid?  Have you been able to get good
performance with something other than "fio -direct"?

I have a RAID 0 with eight elements (see below for details).

Running fio on an individual drive in direct mode gives me okay
performance for that drive- around 1.8-1.9GB/s seq write.
Running fio on an individual drive in buffered mode gives me wildly
variable performance according to fio, but iostat shows similar rates
to the drive, around 1.8-1.9GB/s.

Running fio to the array in direct mode gives me performance for the
array at around 12GB/s, which is reasonable, and approximately what
I'd expect.
Running fio to the array in buffered mode also gives varied
performance according to fio, but iostat shows write rates to the
array at around 2GB/s, barely better than a single drive.

If I put a filesystem (ext4, for example, though I've also tried
others...) on top of the array and run fio with multiple files and
multiple threads, I get slightly better performance in buffered mode,
but nowhere near the 12-14GB/s I'm looking for.  Playing with CPU
affinity helps a little too, but still nowhere near what I need.

Running fdt or gridftp or other actual applications I am able to get
no better than around 2GB/s, which again is around the speed of a
single drive.

Thanks,
Kevin

# mdadm --detail /dev/md0
/dev/md0:
           Version : 1.2
     Creation Time : Wed Nov 22 14:57:35 2017
        Raid Level : raid0
        Array Size : 12501458944 (11922.32 GiB 12801.49 GB)
      Raid Devices : 8
     Total Devices : 8
       Persistence : Superblock is persistent

       Update Time : Wed Nov 22 14:57:35 2017
             State : clean
    Active Devices : 8
   Working Devices : 8
    Failed Devices : 0
     Spare Devices : 0

        Chunk Size : 512K

Consistency Policy : none

              Name : XXX
              UUID : 2a2234a4:78d2bbb2:9e1b3031:022b3315
            Events : 0

    Number   Major   Minor   RaidDevice State
       0     259        2        0      active sync   /dev/nvme0n1
       1     259        7        1      active sync   /dev/nvme1n1
       2     259        5        2      active sync   /dev/nvme2n1
       3     259        1        3      active sync   /dev/nvme3n1
       4     259        4        4      active sync   /dev/nvme4n1
       5     259        3        5      active sync   /dev/nvme5n1
       6     259        0        6      active sync   /dev/nvme6n1
       7     259        6        7      active sync   /dev/nvme7n1



On Wed, Nov 22, 2017@2:20 PM, Joshua Mora <joshua_mora@usa.net> wrote:
> Hi Kevin.
> I did, they are great.
> I get to max them out for both reads and writes.
> I have used the ones of 1.6TB (so ~3.4GB/s seq read and ~2.2GB/s seq writes
> with 128k record length). You don't need large iodepth.
> I tested for instance RAID 10 with 4 drives and tested surprise removal when
> I was doing writes.
> Using AMD EPYC based platform, leveraging the many PCIE lanes that it has.
> You want to use 1 core for every 2 NVMEs to max them out for large record
> length.
> You will need more cores for 4k record length.
>
> Joshua
>
>
> ------ Original Message ------
> Received: 11:57 AM CST, 11/22/2017
> From: "Kevin M. Hildebrand" <kevin at umd.edu>
> To: linux-nvme at lists.infradead.org
> Subject: NVMe array support
>
>
> I've got eight Samsung PM1725a NVMe drives I'm trying to combine into
> an array to be able to aggregate the performance of having multiple
> drives. My initial experiments have yielded abysmal performance in
> most cases. I've tried creating RAID 0 arrays with MD raid, ZFS, and
> a few others and most of the time I'm getting somewhere around the
> performance of a single drive, even though I've got more than one.
> The only way I can get decent performance is when writing to the array
> in direct mode (O_DIRECT). I've been using fio, fdt, and dd for
> running tests. Has anyone successfully created software arrays of
> NVMe drives and been able to get usable performance from them? The
> drives are all in a DELL R940 server, which has 4 Skylake CPUs, and
> all of the drives are connected to a single CPU, with full PCI
> bandwidth.
>
> Sorry if this isn't the right place to send this message, I'm having a
> hard time finding anyone that's doing this.
>
> If anyone's doing this successfully, I'd love to hear more about your
> configuration.
>
> Thanks!
> Kevin
>
> --
> Kevin Hildebrand
> University of Maryland
> Division of IT
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>
>
