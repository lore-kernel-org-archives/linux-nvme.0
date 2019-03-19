From: oulijun@huawei.com (oulijun)
Date: Tue, 19 Mar 2019 09:40:28 +0800
Subject: =?UTF-8?Q?Re:_=e3=80=90Question_for_nvme-rdma_calltrace=e3=80=91?=
In-Reply-To: <20190318142418.GB23430@localhost.localdomain>
References: <0546F6C37BCE5843B1A9A6517ACC82B625C01FB5@dggema523-mbx.china.huawei.com>
 <20190318142418.GB23430@localhost.localdomain>
Message-ID: <b984627e-379c-8dd0-7856-2bcd49d92af1@huawei.com>

? 2019/3/18 22:24, Keith Busch ??:
> Replying in plain text so the mailing list can accept it, and CC'ing Sagi.
ok
>
> Before looking deep into this, do you experience the same NULL dereference
> on an unmodified kernel? The below indicates you've changed something.
>
No. I only add some prints for tracing the location. The kernel is unmodified.
> On Mon, Mar 18, 2019@04:00:24AM -0700, oulijun wrote:
>> Hi, Guys
>>
>>    I am testing the nvme-rdma based on hip08 used 5.0-rc1.
>>
>> The test environment as follows:
>>
>> The target use 25G CX5 with x86, the os is rh7.2;
>>
>> The host use hip08 RoCE port, the kernel is 5.0-rc1;
>>
>> The target configured , the host run the as flows:
>>
>> ./nvme discover -t rdma -a 192.168.55.101 -s 4420
>> ./nvme connect -t rdma -n nvme-x86 -a 192.168.55.101 -s 4420 -k 30000
>>
>> The discover is ok and the connect is failed and happen calltrace:
>>
>> However, I am use the latest nvme driver from the linux kernel instead of the
>> nvme directory, the connect is ok.
>>
>> So, I think that the nvme have a bugs in 5.0-rc1.
>>
>> What do you think?
>>  
>>
>> [ 8528.160811] [blk_mq_map_queue_type, 94] q = 0000000062a15dbc!
>> [ 8528.166545] [blk_mq_map_queue_type, 95] type = 0, cpu = 63!
>> [ 8528.172105] [blk_mq_map_queue_type, 96] q->tag_set = 00000000ae6390cf
>> [ 8528.178533] [blk_mq_map_queue_type, 97] q->tag_set->map[0].mq_map[63] = 63
>> [ 8528.185393] [blk_mq_init_cpu_queues, 2364]point!
>> [ 8528.190002] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000198
>> [ 8528.198772] Mem abort info:
>> [ 8528.201552]   ESR = 0x96000006
>> [ 8528.204594]   Exception class = DABT (current EL), IL = 32 bits
>> [ 8528.210500]   SET = 0, FnV = 0
>> [ 8528.213543]   EA = 0, S1PTW = 0
>> [ 8528.216671] Data abort info:
>> [ 8528.219537]   ISV = 0, ISS = 0x00000006
>> [ 8528.223359]   CM = 0, WnR = 0
>> [ 8528.226315] user pgtable: 4k pages, 48-bit VAs, pgdp = 00000000db52c1b3
>> [ 8528.232916] [0000000000000198] pgd=0000002f88db6003, pud=0000002f88dba003, pmd=0000000000000000
>> [ 8528.241602] Internal error: Oops: 96000006 [#1] PREEMPT SMP
>> [ 8528.247160] Modules linked in: nvme_rdma(O) nvme_fabrics(O) nvme_core(O) hns_roce_hw_v2(O) hns_roce(O) hclge(O) hns3(O) hnae3(O) 
>> [ 8528.258713] CPU: 41 PID: 4463 Comm: nvme Tainted: G           O      5.0.0-rc1-g3248607-dirty #7
>> [ 8528.267482] Hardware name: Huawei TaiShan 2280 V2/BC82AMDA, BIOS TA BIOS 2280-A CS V2.15.01 03/02/2019
>> [ 8528.276772] pstate: 20400009 (nzCv daif +PAN -UAO)
>> [ 8528.281552] pc : blk_mq_init_allocated_queue+0x618/0x6f8
>> [ 8528.286850] lr : blk_mq_init_allocated_queue+0x60c/0x6f8
>> [ 8528.292146] sp : ffff00006e80bab0
>> [ 8528.295447] x29: ffff00006e80bab0 x28: 0000000000000001
>> [ 8528.300744] x27: 0000000000000000 x26: 000000000000003f
>> [ 8528.306042] x25: ffff000011035b20 x24: ffff0000118a5000
>> [ 8528.311339] x23: ffff0000118a5000 x22: ffff000011510000
>> [ 8528.316636] x21: ffff000011035000 x20: ffff802f601ab008
>> [ 8528.321933] x19: ffff802f5a970000 x18: ffffffffffffffff
>> [ 8528.327230] x17: 00000000daef63d8 x16: 000000007598d26b
>> [ 8528.332527] x15: ffff0000118a56c8 x14: ffff0000ee80b807
>> [ 8528.337824] x13: ffff00006e80b815 x12: ffff0000118c4000
>> [ 8528.343120] x11: 0000000005f5e0ff x10: ffff0000118a5b40
>> [ 8528.348417] x9 : 00000000ffffffd0 x8 : ffff0000106a8c88
>> [ 8528.353714] x7 : 6575715f7570635f x6 : 000000000001186a
>> [ 8528.359011] x5 : ffffa02fa9e84480 x4 : ffff000011a22428
>> [ 8528.364308] x3 : 00000000ffffffff x2 : f4e0675246e53b00
>> [ 8528.369605] x1 : 0000000000000000 x0 : 000000000000003f
>> [ 8528.374903] Process nvme (pid: 4463, stack limit = 0x00000000650e57f7)
>> [ 8528.381415] Call trace:
>> [ 8528.383848]  blk_mq_init_allocated_queue+0x618/0x6f8
>> [ 8528.388798]  blk_mq_init_queue+0xa0/0xc8
>> [ 8528.392709]  nvme_rdma_setup_ctrl+0x548/0x908 [nvme_rdma]
>> [ 8528.398093]  nvme_rdma_create_ctrl+0x2a4/0x3c8 [nvme_rdma]
>> [ 8528.403565]  nvmf_dev_write+0x8d8/0xa8c [nvme_fabrics]
>> [ 8528.408689]  __vfs_write+0x30/0x180
>> [ 8528.412163]  vfs_write+0xa4/0x1b0
>> [ 8528.415463]  ksys_write+0x60/0xd8
>> [ 8528.418764]  __arm64_sys_write+0x18/0x20
>> [ 8528.422673]  el0_svc_common+0x60/0x100
>> [ 8528.426408]  el0_svc_handler+0x2c/0x80
>> [ 8528.430143]  el0_svc+0x8/0xc
>> [ 8528.433010] Code: 97f33393 b94077a0 7100041f 54fff949 (b9419b60)
>> [ 8528.439089] ---[ end trace 349a4af402f08e34 ]---
>>
>> Segmentation fault
>>
>>
>> Thanks
>>
>> Lijun Ou
>>
> .
>
