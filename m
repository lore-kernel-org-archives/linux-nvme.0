From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 21 May 2019 12:54:53 +0300
Subject: [PATCH RFC] nvme: Common subsys and controller instances IDA
In-Reply-To: <yq17eaqbg4c.fsf@oracle.com>
References: <20190515213351.22190-1-keith.busch@intel.com>
 <20190516064651.GA30234@lst.de>
 <1f0e7049-c926-98e0-3624-0d24eb45cd87@suse.de>
 <20190516144452.GB23372@localhost.localdomain> <yq17eaqbg4c.fsf@oracle.com>
Message-ID: <040beeb5-d328-d5b0-f165-51bbd40f4c23@mellanox.com>

Hi Martin,

On 5/16/2019 5:58 PM, Martin K. Petersen wrote:
> Keith,
>
>>> to keep in line with the other symlinks in /dev/disk/by-id/ The
>>> controller symlinks don't really fall into this category, though; we
>>> could create a 'nvme' subdirectory (much like MD does), and create
>>> symlinks in there.
>> Cool, I would also like to see persistent char dev names, but I wasn't
>> sure where they'd go. If we can make our own 'nvme' subdirectory,
>> that'd be great.
> Should be fine. As long as /dev/disk stays intact.
>
> It would be really nice to have a clear indication of
> subsys/controller/namespace relationships. So much confusion as a result
> of the current approach...

you can use the nvme-cli. e.g (2 subsystems with 2 ns each exposed from 
target side):

Host

========

[root at server50 ~]# nvme list-subsys
nvme-subsys0 - NQN=testsubsystem_0
\
 ?+- nvme0 rdma traddr=11.212.140.146 trsvcid=4420
nvme-subsys1 - NQN=testsubsystem_1
\
 ?+- nvme1 rdma traddr=11.212.140.146 trsvcid=4421


[root at server50 ~]# nvme list-ns /dev/nvme0
[?? 0]:0x1
[?? 1]:0x2
[root at server50 ~]#
[root at server50 ~]# nvme list-ns /dev/nvme1
[?? 0]:0x1
[?? 1]:0x2


maybe we can improve it and print also the namespace during the "nvme 
list-subsys" command.

something like:

[root at server50 ~]# nvme list-subsys
nvme-subsys0 - NQN=testsubsystem_0
\
 ?+- nvme0 rdma traddr=11.212.140.146 trsvcid=4420

 ?\

 ? +- nvme0n1 SN=cf8bbff661502c51 Model=Linux

 ? +- nvme0n2 SN=cf8bbff661502c51 Model=Linux


and we'll get subsys/ctrl/ns relations in 1 cmd.

thoughts ?
