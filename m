From: swise@opengridcomputing.com (Steve Wise)
Date: Mon, 16 Jul 2018 10:11:22 -0500
Subject: nvme-rdma and rdma comp vector affinity problem
In-Reply-To: <c3faccbe-a3ac-96ac-00f9-1dd5997b5510@grimberg.me>
References: <bf6b909e-b3b9-cc77-2837-c65302f7c22c@opengridcomputing.com>
 <984d4c8e-16b9-d459-e4b9-bf1703b4c226@opengridcomputing.com>
 <c3faccbe-a3ac-96ac-00f9-1dd5997b5510@grimberg.me>
Message-ID: <7660a6bf-1fac-e430-91e5-7cd92c2a7123@opengridcomputing.com>



On 7/16/2018 1:51 AM, Sagi Grimberg wrote:
>
>> Hey Sagi and Christoph,
>>
>> Do you all have any thoughts on this?? It seems like a bug in nvme-rdma
>> or the blk-mq code.?? I can debug it further, if we agree this does look
>> like a bug...
>
> It is a bug... blk-mq tells expects us to skip unmapped queues but
> we fail the controller altogether...
>
> I assume managed affinity would have take care of linearization for us..
>
> Does this quick untested patch work?

Hey Sagi,

I can connect now with your patch, but perhaps these errors shouldn't be
logged?? Also, It apparently connect 9 IO queues.? I think it should
have connected only 8, right?

Log showing the iw_cxgb4 vector affinity ( 16 comp vectors configured to
only use cpus in the same numa node - cpus 8-15):

[? 810.387762] iw_cxgb4: comp_vector 0, irq 217 mask 0x100
[? 810.393543] iw_cxgb4: comp_vector 1, irq 218 mask 0x200
[? 810.399229] iw_cxgb4: comp_vector 2, irq 219 mask 0x400
[? 810.404902] iw_cxgb4: comp_vector 3, irq 220 mask 0x800
[? 810.410584] iw_cxgb4: comp_vector 4, irq 221 mask 0x1000
[? 810.416333] iw_cxgb4: comp_vector 5, irq 222 mask 0x2000
[? 810.422085] iw_cxgb4: comp_vector 6, irq 223 mask 0x4000
[? 810.427827] iw_cxgb4: comp_vector 7, irq 224 mask 0x8000
[? 810.433564] iw_cxgb4: comp_vector 8, irq 225 mask 0x100
[? 810.439212] iw_cxgb4: comp_vector 9, irq 226 mask 0x200
[? 810.444851] iw_cxgb4: comp_vector 10, irq 227 mask 0x400
[? 810.450570] iw_cxgb4: comp_vector 11, irq 228 mask 0x800
[? 810.456271] iw_cxgb4: comp_vector 12, irq 229 mask 0x1000
[? 810.462057] iw_cxgb4: comp_vector 13, irq 230 mask 0x2000
[? 810.467841] iw_cxgb4: comp_vector 14, irq 231 mask 0x4000
[? 810.473606] iw_cxgb4: comp_vector 15, irq 232 mask 0x8000

Log showing the nvme queue setup (attempting 16 IO Queues and thus
trying all 16 comp vectors):

[? 810.839135] nvme nvme0: Connect command failed, error wo/DNR bit: -16402
[? 810.846531] nvme nvme0: failed to connect queue: 2 ret=-18
[? 810.853330] nvme nvme0: Connect command failed, error wo/DNR bit: -16402
[? 810.860698] nvme nvme0: failed to connect queue: 3 ret=-18
[? 810.867502] nvme nvme0: Connect command failed, error wo/DNR bit: -16402
[? 810.874834] nvme nvme0: failed to connect queue: 4 ret=-18
[? 810.881579] nvme nvme0: Connect command failed, error wo/DNR bit: -16402
[? 810.888883] nvme nvme0: failed to connect queue: 5 ret=-18
[? 810.895617] nvme nvme0: Connect command failed, error wo/DNR bit: -16402
[? 810.902908] nvme nvme0: failed to connect queue: 6 ret=-18
[? 810.909650] nvme nvme0: Connect command failed, error wo/DNR bit: -16402
[? 810.916936] nvme nvme0: failed to connect queue: 7 ret=-18
[? 810.923655] nvme nvme0: Connect command failed, error wo/DNR bit: -16402
[? 810.930924] nvme nvme0: failed to connect queue: 8 ret=-18
[? 810.937818] nvme nvme0: connected 9 I/O queues.
[? 810.942902] nvme nvme0: new ctrl: NQN "nvme-nullb0", addr 172.16.2.1:4420

[root at stevo1 linux]# nvme list
Node???????????? SN??????????????????
Model??????????????????????????????????? Namespace
Usage????????????????????? Format?????????? FW Rev
---------------- --------------------
---------------------------------------- ---------
-------------------------- ---------------- --------
/dev/nvme0n1???? db56fecfd36969df????
Linux??????????????????????????????????? 1?????????? 1.07? GB /?? 1.07?
GB??? 512?? B +? 0 B?? 4.18.0-r
[root at stevo1 linux]#
