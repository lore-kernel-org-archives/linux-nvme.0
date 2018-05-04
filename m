From: keith.busch@linux.intel.com (Keith Busch)
Date: Fri, 4 May 2018 14:05:56 -0600
Subject: BLKZEROOUT ioctl and WriteZero opcode
In-Reply-To: <CAPrnrPDEdOFKxuZNQo_BhY8Nf2MfcB=DgbzDEDV7JHx5_+-gnQ@mail.gmail.com>
References: <CAPrnrPDEdOFKxuZNQo_BhY8Nf2MfcB=DgbzDEDV7JHx5_+-gnQ@mail.gmail.com>
Message-ID: <20180504200556.GA20686@localhost.localdomain>

On Thu, May 03, 2018@06:15:54PM +0300, ???? ?? ??? wrote:
> There is an ioctl command BLKZEROOUT that accepts range (lba + number
> of block to zero)
> 
> Suppose:
> Block device is an nvme device (e.g. /dev/nvme0nX)
> Device does support the WriteZeroes opcode.
> 
> If so, does the kernel make use of the WriteZeroes opcode in the
> implementation of BLKZEROOUT ?
> Same question for BLKDISCARD.

The NVMe driver supports BLKDISACRD if the device supports the DSM
command.

The NVMe driver at the moment doesn't support the NVME Writes Zeroes
command. We had it briefly, but apparently broke Linus' machine; never
did figure out why. Relevent link:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cdb98c2698b4af287925abcba4d77d92af82a0c3

For devices that claim discard determinisitcally returns 0's on reads,
the driver will map the user BLKZEROOUT request to the DSM command
rather than NVMe Write Zeroes.

For testing NVMe Write Zeroes, the nvme passthrough ioctl may still
be used.
