From: keith.busch@intel.com (Keith Busch)
Date: Wed, 25 Jun 2014 09:47:06 -0600 (MDT)
Subject: NVM Express Format
In-Reply-To: <8838223D960CB945AFF93D316204C6369D8F16@CFWEX01.americas.cray.com>
References: <8838223D960CB945AFF93D316204C6369D8F16@CFWEX01.americas.cray.com>
Message-ID: <alpine.LRH.2.03.1406250940180.4699@AMR>

On Wed, 25 Jun 2014, Ian Ziemba wrote:
> I am curious about how to issue a scsi format command to a PCIe SSD. I have
> the NVM Express Linux drivers loaded onto my system. I have tried using the
> Linux command "sg_format" but that does not work. Is there a NVM Express
> command that will accomplish this? If so, how would I go about using this
> command? My goal is to be able to have a method of purging the SSD in order
> to run performance tests on the drive.

sg_format should work, otherwise it's a bug. Can you tell me what you're
running and what happens in your test?

If you want to go with a native nvme-express option instead of using scsi,
I have some example programs at

http://git.infradead.org/users/kbusch/nvme-user.git

Assuming your kernel's uapi headers are installed, it should compile
all the programs without issue, and there's an "nvme_format" that will
use the nvme passthrough to issue a format.

> My system is running OpenSUSE 11 SP13. The Linux kernel version is at 3.16.
>
> I am new to NVM Express so any thoughts or insight will be appreciated.
>
> Thanks,
>
> Ian Ziemba
> I/O Engineer Intern
> Storage and Data Management
> Cray Inc.
