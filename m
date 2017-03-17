From: maxg@mellanox.com (Max Gurtovoy)
Date: Fri, 17 Mar 2017 21:49:50 +0200
Subject: Unexpected issues with 2 NVME initiators using the same target
In-Reply-To: <DE927C68B458BE418D582EC97927A92855031724@ORSMSX113.amr.corp.intel.com>
References: <08131a05-1f56-ef61-990a-7fff04eea095@gmail.com>
 <de1a559a-bf24-0d73-5fc7-148d6cd4d4e0@grimberg.me>
 <1848296658.37025722.1487782361271.JavaMail.zimbra@redhat.com>
 <1554c1d1-6bf4-9ca2-12d4-a0125d8c5715@gmail.com>
 <DE927C68B458BE418D582EC97927A92854655137@ORSMSX112.amr.corp.intel.com>
 <3eb5814f-14cb-2b94-adf8-335d4b2eb7e9@grimberg.me>
 <26912d0c-578f-26e9-490d-94fc95bdf259@mellanox.com>
 <DE927C68B458BE418D582EC97927A92855031724@ORSMSX113.amr.corp.intel.com>
Message-ID: <809f87ab-b787-9d40-5840-07500d12e81a@mellanox.com>



On 3/17/2017 8:37 PM, Gruher, Joseph R wrote:
>
>
>> -----Original Message-----
>> From: Max Gurtovoy [mailto:maxg at mellanox.com]
>>
>> I think we need to add fence to the UMR wqe.
>>
>> diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
>> index ad8a263..c38c4fa 100644
>> --- a/drivers/infiniband/hw/mlx5/qp.c
>> +++ b/drivers/infiniband/hw/mlx5/qp.c
>> @@ -3737,8 +3737,7 @@ static void dump_wqe(struct mlx5_ib_qp *qp, int idx,
>> int size_16)
>>
>>   static u8 get_fence(u8 fence, struct ib_send_wr *wr)
>>   {
>> -       if (unlikely(wr->opcode == IB_WR_LOCAL_INV &&
>> -                    wr->send_flags & IB_SEND_FENCE))
>> +       if (wr->opcode == IB_WR_LOCAL_INV || wr->opcode == IB_WR_REG_MR)
>>                  return MLX5_FENCE_MODE_STRONG_ORDERING;
>>
>>          if (unlikely(fence)) {
>>
>> Joseph,
>> please update after trying the 2 patches (seperatly) + perf numbers.
>>
>> I'll take it internally and run some more tests with stronger servers using
>> ConnectX4 NICs.
>>
>> These patches are only for testing and not for submission yet. If we find them
>> good enought for upstream then we need to distinguish between ConnexcX4/IB
>> and ConnectX5 (we probably won't see it there).
>
> Hi Max-
>
> Our testing on this patch looks good, failures seem completely alleviated.  We are not really detecting any performance impact to small block read workloads.  Data below uses 50Gb CX4 initiator and target and FIO to generate load.  Each disk runs 4KB random reads with 4 jobs and queue depth 32 per job.  Initiator uses 16 IO queues per attached subsystem.  We tested with 2 P3520 disks attached, and again with 7 disks attached.
>
> 				IOPS		Latency (usec)
> 4.10-RC8	2 disks		545,695		466.0
> With Patch	2 disks		587,663		432.8
> 4.10-RC8	7 disks		1,074,311	829.5
> With Patch	7 disks		1,080,099	825.4

Very nice.
We also run testing on null devices in our labs on iSER/NVMf (show 
better the network/transport layer performance) and the impact was 
Atolerable.

>
> You mention these patches are only for testing.  How do we get to something which can be submitted to upstream?

Yes, we need to be careful and not put the strong_fence if it's not a must.
I'll be out for the upcoming week, but I'll ask our mlx5 maintainers to 
prepare a suitable patch and check some other applications performance 
numbers.
Thanks for the testing, you can use this patch meanwhile till we push 
the formal solution.

>
> Thanks!
>
