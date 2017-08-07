From: keith.busch@intel.com (Keith Busch)
Date: Sun, 6 Aug 2017 23:17:40 -0400
Subject: NVME card works on kernel 3.19.8 but not on 4.19.31
In-Reply-To: <CAGSHeY0H82iiKtYDiAmqdH_C6PytitvfkrmgYmQVcFnnmVWhmA@mail.gmail.com>
References: <CAGSHeY0H82iiKtYDiAmqdH_C6PytitvfkrmgYmQVcFnnmVWhmA@mail.gmail.com>
Message-ID: <20170807031740.GC842@localhost.localdomain>

On Fri, Aug 04, 2017@06:04:23PM -0700, Yogi Wannabe wrote:
> Hi,
> 
> Our NVME card works fine on Centos 7.3 with kernel 3.19.8. But with
> Centos 7.3 and kernel 4.19.31 the driver
> 
> 1. detects the board
> 2. creates I/O submission and completion queues
> 3. sends identify cmd to retrive controller information
> 4. /dev/nvme0 node is created.
> 
> However, /dev/nvme0n1 is not created and the drive does not show up in
> /proc/partitions. Two things we have observed are that
> 
> 1. identify cmd to retrive namespace information is not called
> 2. BLK_DEV_NVME_SCSI is not set in .config file on the running kernel
> 
> Any clues on what could be going wrong?

I'm not actually sure what kernel you're using since 4.19 doesn't exist
yet. I'll assume that was just a typo.

Usually that would mean the drive failed to create IO queues, or it simply
doesn't have any namespaces. If the problem is the former, you should see
a message in the kernel log/dmesg that says "Could not set queue count".

If you don't see any error messages, could you attach the identify
command data? As long as /dev/nvme0 was created, you should be able to
get that information from the shell with nvme-cli. The command to run is
'nvme id-ctrl /dev/nvme0'.

I think Centos 7.3 makes nvme-cli available as a package, so you may be
able to can get it with 'yum install nvme-cli'. Otherwise, you can get
the source from here:

  https://github.com/linux-nvme/nvme-cli
