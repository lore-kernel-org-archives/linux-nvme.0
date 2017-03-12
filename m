From: vladimirn@mellanox.com (Vladimir Neyelov)
Date: Sun, 12 Mar 2017 12:33:45 +0000
Subject: Unexpected issues with 2 NVME initiators using the same target
In-Reply-To: <fbd647dd-3a16-8155-107d-f98e8326cc63@mellanox.com>
References: <08131a05-1f56-ef61-990a-7fff04eea095@gmail.com>
 <de1a559a-bf24-0d73-5fc7-148d6cd4d4e0@grimberg.me>
 <1848296658.37025722.1487782361271.JavaMail.zimbra@redhat.com>
 <1554c1d1-6bf4-9ca2-12d4-a0125d8c5715@gmail.com>
 <DE927C68B458BE418D582EC97927A92854655137@ORSMSX112.amr.corp.intel.com>
 <3eb5814f-14cb-2b94-adf8-335d4b2eb7e9@grimberg.me>
 <26912d0c-578f-26e9-490d-94fc95bdf259@mellanox.com>
 <16c4bd86-fd63-f230-40bc-f52cb106e11b@grimberg.me>
 <fbd647dd-3a16-8155-107d-f98e8326cc63@mellanox.com>
Message-ID: <AM4PR0501MB278621363209E177A738D75FCB220@AM4PR0501MB2786.eurprd05.prod.outlook.com>

Hi,
I tested performance regression with/without patch of Max.
I user to servers of HP.

Initiator:												
CPUs: 48												
CPU: Intel(R) Xeon(R) CPU E5-2690 v3 @ 2.60GHz												
Hardware: ConnectX-4 												
Interface : Infiniband	Ethernet											
Kernel: 3.10.0-327.el7.x86_64												
OFED:	MLNX_OFED_LINUX-4.0-1.5.6.0:											
OS: RHEL 7.2												
Tunning commands:												
modprobe ib_iser always_register=N												
for i in `ls sd*`;do echo 2 > /sys/block/$i/queue/nomerges;done												
for i in `ls sd*`;do echo 0 > /sys/block/$i/queue/add_random ;done												
for i in `ls sd*`;do echo 1 > /sys/block/$i/queue/rq_affinity;done												
for i in `ls sd*`;do echo noop > /sys/block/$i/queue/scheduler;done												
echo performance > /sys/devices/system/cpu/cpu[0-9]*/cpufreq/scaling_governor												
service irqbalance stop												
set_irq_affinity.sh ens4f0												
												
												
Target:												
Hardware: ConnectX-4 												
CPUs: 48												
CPU: Intel(R) Xeon(R) CPU E5-2690 v3 @ 2.60GHz												
Interface : Infiniband												
												
OS: RHEL 7.2												
Kernel: 3.10.0-327.el7.x86_64												
Tunning commands:												
service irqbalance stop												
set_irq_affinity.sh ens4f0												
Target type LIO												
												
Command:												
fio --rw=write -bs=4K --numjobs=3 --iodepth=128 --runtime=60 --time_based --size=300k --loops=1 --ioengine=libaio --direct=1 --invalidate=1 --fsync_on_close=1 --randrepeat=1 --norandommap --group_reporting --exitall `cat disks`

Results:

Patched  by patch of Max (block 4K):

allways reg          Y                N
write              1902K            1923.3K
read               1315K            2009K 

Original  OFED code (block 4K)     

allways reg          Y                N
write              1947K           1982K
read               1273K           1978K												

Thanks,
Vladimir

-----Original Message-----
From: Max Gurtovoy 
Sent: Tuesday, March 7, 2017 11:28 AM
To: Sagi Grimberg <sagi at grimberg.me>; Gruher, Joseph R <joseph.r.gruher at intel.com>; shahar.salzman <shahar.salzman at gmail.com>; Laurence Oberman <loberman at redhat.com>; Riches Jr, Robert M <robert.m.riches.jr at intel.com>
Cc: linux-rdma at vger.kernel.org; linux-nvme at lists.infradead.org; Robert LeBlanc <robert at leblancnet.us>; Vladimir Neyelov <vladimirn at mellanox.com>
Subject: Re: Unexpected issues with 2 NVME initiators using the same target

Hi,

Shahar/Joseph, what is your link layer conf (IB/Eth) ?
In eth case, have you configured some PFC ? if not, can you try it ?
I suspect that this is the root cause and it might help you avoiding this case, meanwhile we're looking for for the best solution.

Adding Vladimir that will run iSER on his performance setup with the new fencing patch (not an NVMEoF related issue).
We can run also NVMEoF later on if needed.

Max.

On 3/6/2017 1:28 PM, Sagi Grimberg wrote:
>> Hi Sagi,
>>
>> I think we need to add fence to the UMR wqe.
>>
>> so lets try this one:
>>
>> diff --git a/drivers/infiniband/hw/mlx5/qp.c 
>> b/drivers/infiniband/hw/mlx5/qp.c index ad8a263..c38c4fa 100644
>> --- a/drivers/infiniband/hw/mlx5/qp.c
>> +++ b/drivers/infiniband/hw/mlx5/qp.c
>> @@ -3737,8 +3737,7 @@ static void dump_wqe(struct mlx5_ib_qp *qp, int 
>> idx, int size_16)
>>
>>  static u8 get_fence(u8 fence, struct ib_send_wr *wr)  {
>> -       if (unlikely(wr->opcode == IB_WR_LOCAL_INV &&
>> -                    wr->send_flags & IB_SEND_FENCE))
>> +       if (wr->opcode == IB_WR_LOCAL_INV || wr->opcode == 
>> + IB_WR_REG_MR)
>>                 return MLX5_FENCE_MODE_STRONG_ORDERING;
>>
>>         if (unlikely(fence)) {
>
> This will kill performance, isn't there another fix that can be 
> applied just for retransmission flow?
>
>> Couldn't repro that case but I run some initial tests in my Lab (with 
>> my patch above) - not performace servers:
>>
>> Initiator with 24 CPUs (2 threads/core, 6 cores/socket, 2 sockets), 
>> Connect IB (same driver mlx5_ib), kernel 4.10.0, fio test with 24 
>> jobs and 128 iodepth.
>> register_always=N
>>
>> Target - 1 subsystem with 1 ns (null_blk)
>>
>> bs   read (without/with patch)   write (without/with patch)
>> --- --------------------------  ---------------------------
>> 512     1019k / 1008k                 1004k / 992k
>> 1k      1021k / 1013k                 1002k / 991k
>> 4k      1030k / 1022k                 978k  / 969k
>>
>> CPU usage is 100% for both cases in the initiator side.
>> haven't seen difference with bs = 16k.
>> No so big drop like we would expect,
>
> Obviously you won't see a drop without registering memory for small IO 
> (register_always=N), this would bypass registration altogether... 
> Please retest with register_always=Y.
