From: daniel.mcleran@intel.com (Dan McLeran)
Date: Wed, 25 Jun 2014 09:47:05 -0600 (Mountain Daylight Time)
Subject: NVM Express Format
In-Reply-To: <8838223D960CB945AFF93D316204C6369D8F16@CFWEX01.americas.cray.com>
References: <8838223D960CB945AFF93D316204C6369D8F16@CFWEX01.americas.cray.com>
Message-ID: <alpine.WNT.2.00.1406250944010.18696@DMCLERAN-DESK.amr.corp.intel.com>

FYI, if this is a device which has never before been formatted then you 
would need to send down MODE_SELECT before FORMAT_UNIT if you want to do 
this via SCSI. I've never done it this way so I don't know exactly what to 
do.

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
