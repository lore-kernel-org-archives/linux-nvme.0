From: daniel.mcleran@intel.com (Dan McLeran)
Date: Wed, 25 Jun 2014 09:34:28 -0600 (Mountain Daylight Time)
Subject: NVM Express Format
In-Reply-To: <8838223D960CB945AFF93D316204C6369D8F16@CFWEX01.americas.cray.com>
References: <8838223D960CB945AFF93D316204C6369D8F16@CFWEX01.americas.cray.com>
Message-ID: <alpine.WNT.2.00.1406250931580.28120@DMCLERAN-DESK.amr.corp.intel.com>

If you just want to get the disk formatted for testing
just use fdisk to partition the drive followed by 
mkfs.ext4 or whatever file system you want to use.

On my system:

fdisk /dev/nvme0n1

create a partition

mkfs.ext4 /dev/nvme0n1p1

works like a charm.

On Wed, 25 Jun 2014, Ian Ziemba wrote:

> Hi,
>
> I am curious about how to issue a scsi format command to a PCIe SSD. I have the NVM Express Linux drivers loaded onto my system. I have tried using the Linux command "sg_format" but that does not work. Is there a NVM Express command that will accomplish this? If so, how would I go about using this command? My goal is to be able to have a method of purging the SSD in order to run performance tests on the drive.
>
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
>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>
