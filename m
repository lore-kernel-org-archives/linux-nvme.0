From: sunad.s@samsung.com (Sunad Bhandary S)
Date: Tue, 11 Nov 2014 15:07:39 +0000 (GMT)
Subject: System hang issue during hibernation resume due to del_gendisk
Message-ID: <908627706.204341415718459019.JavaMail.weblogic@epmlwas06b>

Hi Keith,

While I was working with NVMe devices I came across a system hang issue. The following are the steps to reproduce the issue:

1) Mounted a NVMe device with  Linux NVMe Driver and EXT3 file format .
2) Put the device to hibernate state using pm-hibernate
3) Remove the NVMe device.
4) Resume from hibernation
The system hangs up with a blank screen and the only option is to force reboot.

I suspect this to be a issue with the call of del_gendisk. If i make the call to del_gendisk in the cleanup path in the free_namespaces function the system resumes without any issues for the same scenario.

Also the issue is not observed in EXT4 file format. 

The issue seems to be the same as discussed here https://groups.google.com/forum/#!topic/fa.linux.kernel/aHbwSyQdADY . I am keen to know if this issue has been fixed in the latest kernel versions and if it is safe to call del_gendisk when
the userspace is frozen in the latest kernel versions.

Regards,
Sunad
