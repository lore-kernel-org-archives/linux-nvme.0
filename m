From: asrivastava014@gmail.com (Ankur Srivastava)
Date: Wed, 12 Apr 2017 14:58:05 +0530
Subject: [NVMeF]: Multipathing setup for NVMeF
Message-ID: <CAJvSebub-HnRnCpE-z2aTxmkrJLTo7=c9FoBncgJ+BZ_PUYsMQ@mail.gmail.com>

Hi All,

I am working on NVMe over fabric and want to experiment the
Multipathing support for the same.

Setup Info:
RHEL 7.2 with Kernel 4.9.3


[root at localhost ~]# nvme list
Node             SN                   Model
               Namespace Usage                      Format
FW Rev
---------------- --------------------
---------------------------------------- ---------
-------------------------- ---------------- --------
/dev/nvme0n1     30501b622ed15184     Linux
        10        268.44  GB / 268.44  GB    512   B +  0 B   4.9.3
/dev/nvme1n1     ef730272d9be107c      Linux
         10        268.44  GB / 268.44  GB    512   B +  0 B   4.9.3


[root at localhost ~]# ps ax | grep multipath
1272 ?        SLl    0:00 /sbin/multipathd


I have connected my Initiator to both the ports of Ethernet
Adapter(Target) to get 2 IO Paths, from the above data "/dev/nvme0n1"
is path 1 and "/dev/nvme1n1" is path 2 for the same namespace.

Note: I am using Null Block device on the Target Side.

But still the multipath is showing an error ie no path to Host for All
the NVMe Drives mapped on the Initiator. Does multipathd supports NVMe
over Fabric ??
Or what I am missing from configuration side ??

Thanks in advance!!


BR~
Ankur
