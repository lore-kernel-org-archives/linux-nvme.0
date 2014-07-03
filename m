From: indraneel.m@samsung.com (Indraneel Mukherjee)
Date: Thu, 03 Jul 2014 18:33:06 +0530
Subject: NVM Express Format
In-Reply-To: <alpine.LRH.2.03.1406250940180.4699@AMR>
References: <8838223D960CB945AFF93D316204C6369D8F16@CFWEX01.americas.cray.com>
 <alpine.LRH.2.03.1406250940180.4699@AMR>
Message-ID: <04ac01cf96bf$2cf2e6f0$86d8b4d0$@samsung.com>

> -----Original Message-----
> From: Linux-nvme [mailto:linux-nvme-bounces at lists.infradead.org] On Behalf
> Of Keith Busch
> Sent: Wednesday, June 25, 2014 9:17 PM
> To: Ian Ziemba
> Cc: linux-nvme at lists.infradead.org
> Subject: Re: NVM Express Format
> 
> On Wed, 25 Jun 2014, Ian Ziemba wrote:
> > I am curious about how to issue a scsi format command to a PCIe SSD. I
> > have the NVM Express Linux drivers loaded onto my system. I have tried
> > using the Linux command "sg_format" but that does not work. Is there a
> > NVM Express command that will accomplish this? If so, how would I go
> > about using this command? My goal is to be able to have a method of
> > purging the SSD in order to run performance tests on the drive.
> 
> sg_format should work, otherwise it's a bug. Can you tell me what you're
> running and what happens in your test?

sg_format does not appear to work with the NVMe driver. Reason being that
before doing the actual format, 
sg_format issues a MODE_SENSE with Page Code 0x1 to get info like current
Num Of Blocks, Block Size
and Write Protect setting for the SCSI disk in question.
The driver does not have implementation for Page Code 1 as the current
SCSI-NVMe translation spec(Rev 1.2) 
does NOT support Page Code 0x1 (Read-Write Error Recovery mode page).
The driver cannot be faulted for this.

> 
> If you want to go with a native nvme-express option instead of using scsi,
I have
> some example programs at
> 
> http://git.infradead.org/users/kbusch/nvme-user.git
> 
> Assuming your kernel's uapi headers are installed, it should compile all
the
> programs without issue, and there's an "nvme_format" that will use the
nvme
> passthrough to issue a format.
> 
> > My system is running OpenSUSE 11 SP13. The Linux kernel version is at
3.16.
> >
> > I am new to NVM Express so any thoughts or insight will be appreciated.
> >
> > Thanks,
> >
> > Ian Ziemba
> > I/O Engineer Intern
> > Storage and Data Management
> > Cray Inc.
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
