From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 28 Mar 2017 17:14:59 +0300
Subject: BUG report: Invalid cross-device link while connecting with
 various nr-io-queues
In-Reply-To: <89604d8a-78e4-a754-7fd8-b5b1eedc38bd@grimberg.me>
References: <910e6625-1256-a6b4-68d3-c946f2b71aaf@mellanox.com>
 <89604d8a-78e4-a754-7fd8-b5b1eedc38bd@grimberg.me>
Message-ID: <82753ff4-77c1-5c78-ab07-85868a58fbb0@mellanox.com>



On 3/28/2017 1:32 PM, Sagi Grimberg wrote:
> ...
>
>> [1102928.407720] nvme nvme0: failed to connect i/o queue: -18
>> [1102928.720957] nvme_rdma_find_get_device: enabling unsafe global rkey
>> [1102928.777948] nvme nvme0: creating 14 I/O queues.
>> [1102929.102588] nvme nvme0: Connect command failed, error wo/DNR bit:
>> -16402
>> [1102929.109029] nvme nvme0: failed to connect i/o queue: -18
>> [1102929.422299] nvme_rdma_find_get_device: enabling unsafe global rkey
>> [1102929.479662] nvme nvme0: creating 15 I/O queues.
>> [1102929.828792] nvme nvme0: Connect command failed, error wo/DNR bit:
>> -16402
>> [1102929.835232] nvme nvme0: failed to connect i/o queue: -18
>>
>>
>> have someone saw it before ?
>
> I haven't, can you share what the target is logging?
>
> This is strange because we get to an unknown connect error code...

yes, for example nr-io-queues=20:

Mar 28 17:13:01 rsws34 kernel: nvmet: creating controller 1 for 
subsystem testsubsystem for NQN 
nqn.2014-08.org.nvmexpress:NVMf:uuid:db143cd0-c0e5-4e8b-881a-abffc96192aa.
Mar 28 17:13:02 rsws34 kernel: nvmet: adding queue 1 to ctrl 1.
Mar 28 17:13:02 rsws34 kernel: nvmet: adding queue 2 to ctrl 1.
Mar 28 17:13:02 rsws34 kernel: nvmet_rdma: freeing queue 1
Mar 28 17:13:02 rsws34 kernel: nvmet_rdma: freeing queue 2
Mar 28 17:13:02 rsws34 kernel: nvmet_rdma: freeing queue 3
Mar 28 17:13:02 rsws34 kernel: nvmet_rdma: freeing queue 4
Mar 28 17:13:02 rsws34 kernel: nvmet_rdma: freeing queue 5
Mar 28 17:13:02 rsws34 kernel: nvmet_rdma: freeing queue 6
Mar 28 17:13:02 rsws34 kernel: nvmet_rdma: freeing queue 7
Mar 28 17:13:02 rsws34 kernel: nvmet_rdma: freeing queue 8
Mar 28 17:13:02 rsws34 kernel: nvmet_rdma: freeing queue 9
Mar 28 17:13:02 rsws34 kernel: nvmet_rdma: freeing queue 10
Mar 28 17:13:02 rsws34 kernel: nvmet_rdma: freeing queue 11
Mar 28 17:13:02 rsws34 kernel: nvmet_rdma: freeing queue 12
Mar 28 17:13:02 rsws34 kernel: nvmet_rdma: freeing queue 13
Mar 28 17:13:02 rsws34 kernel: nvmet_rdma: freeing queue 14
Mar 28 17:13:02 rsws34 kernel: nvmet_rdma: freeing queue 15
Mar 28 17:13:02 rsws34 kernel: nvmet_rdma: freeing queue 16
Mar 28 17:13:02 rsws34 kernel: nvmet_rdma: freeing queue 17
Mar 28 17:13:02 rsws34 kernel: nvmet_rdma: freeing queue 18
Mar 28 17:13:02 rsws34 kernel: nvmet_rdma: freeing queue 19
Mar 28 17:13:02 rsws34 kernel: nvmet_rdma: freeing queue 20
Mar 28 17:13:02 rsws34 kernel: nvmet_rdma: freeing queue 0

Thanks,
Max.
