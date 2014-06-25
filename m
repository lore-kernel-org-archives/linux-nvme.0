From: iziemba@cray.com (Ian Ziemba)
Date: Wed, 25 Jun 2014 14:58:42 +0000
Subject: NVM Express Format
Message-ID: <8838223D960CB945AFF93D316204C6369D8F16@CFWEX01.americas.cray.com>

Hi,

I am curious about how to issue a scsi format command to a PCIe SSD. I have the NVM Express Linux drivers loaded onto my system. I have tried using the Linux command "sg_format" but that does not work. Is there a NVM Express command that will accomplish this? If so, how would I go about using this command? My goal is to be able to have a method of purging the SSD in order to run performance tests on the drive.

My system is running OpenSUSE 11 SP13. The Linux kernel version is at 3.16.

I am new to NVM Express so any thoughts or insight will be appreciated.

Thanks,

Ian Ziemba
I/O Engineer Intern
Storage and Data Management
Cray Inc.
