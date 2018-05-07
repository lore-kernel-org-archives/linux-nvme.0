From: bdeyal@gmail.com (Eyal BenDavid)
Date: Mon, 7 May 2018 15:17:56 +0300
Subject: BLKZEROOUT ioctl and WriteZero opcode
In-Reply-To: <20180504200556.GA20686@localhost.localdomain>
References: <CAPrnrPDEdOFKxuZNQo_BhY8Nf2MfcB=DgbzDEDV7JHx5_+-gnQ@mail.gmail.com>
 <20180504200556.GA20686@localhost.localdomain>
Message-ID: <CAPrnrPA9nSSghkHnSRKdxE=+qBEZZ3Rg1c3KcxZhpEwh19EYNQ@mail.gmail.com>

Thanks Keith,

So:
BLKZEROOUT is not implemented by NVME passthru + Write Zeroes (for now).
BLKZEROOUT Is implemented by DSM provided the device guarantees 0's
are returned after "Unmap"
In order to to zero out a range, NVMe passthru with Write Zeroes
opcode must be used.

Is it correct?

Thanks,
Eyal


On Fri, May 4, 2018 at 11:05 PM, Keith Busch
<keith.busch@linux.intel.com> wrote:
> On Thu, May 03, 2018@06:15:54PM +0300, ???? ?? ??? wrote:
>> There is an ioctl command BLKZEROOUT that accepts range (lba + number
>> of block to zero)
>>
>> Suppose:
>> Block device is an nvme device (e.g. /dev/nvme0nX)
>> Device does support the WriteZeroes opcode.
>>
>> If so, does the kernel make use of the WriteZeroes opcode in the
>> implementation of BLKZEROOUT ?
>> Same question for BLKDISCARD.
>
> The NVMe driver supports BLKDISACRD if the device supports the DSM
> command.
>
> The NVMe driver at the moment doesn't support the NVME Writes Zeroes
> command. We had it briefly, but apparently broke Linus' machine; never
> did figure out why. Relevent link:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cdb98c2698b4af287925abcba4d77d92af82a0c3
>
> For devices that claim discard determinisitcally returns 0's on reads,
> the driver will map the user BLKZEROOUT request to the DSM command
> rather than NVMe Write Zeroes.
>
> For testing NVMe Write Zeroes, the nvme passthrough ioctl may still
> be used.
