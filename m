From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 28 Mar 2017 11:38:05 +0300
Subject: Unexpected issues with 2 NVME initiators using the same target
In-Reply-To: <DE927C68B458BE418D582EC97927A92855044196@ORSMSX113.amr.corp.intel.com>
References: <08131a05-1f56-ef61-990a-7fff04eea095@gmail.com>
 <de1a559a-bf24-0d73-5fc7-148d6cd4d4e0@grimberg.me>
 <1848296658.37025722.1487782361271.JavaMail.zimbra@redhat.com>
 <1554c1d1-6bf4-9ca2-12d4-a0125d8c5715@gmail.com>
 <DE927C68B458BE418D582EC97927A92854655137@ORSMSX112.amr.corp.intel.com>
 <3eb5814f-14cb-2b94-adf8-335d4b2eb7e9@grimberg.me>
 <26912d0c-578f-26e9-490d-94fc95bdf259@mellanox.com>
 <DE927C68B458BE418D582EC97927A92855031724@ORSMSX113.amr.corp.intel.com>
 <809f87ab-b787-9d40-5840-07500d12e81a@mellanox.com>
 <DE927C68B458BE418D582EC97927A928550391C2@ORSMSX113.amr.corp.intel.com>
 <DE927C68B458BE418D582EC97927A928550419FA@ORSMSX113.amr.corp.intel.com>
 <eecc1346-978a-4eeb-86a7-18b9cb547947@mellanox.com>
 <DE927C68B458BE418D582EC97927A92855044196@ORSMSX113.amr.corp.intel.com>
Message-ID: <d2e97c35-ae6e-183c-480f-99190dbef46b@mellanox.com>



On 3/27/2017 6:39 PM, Gruher, Joseph R wrote:
>
>
>> On 3/24/2017 9:30 PM, Gruher, Joseph R wrote:
>>>>>>> From: Max Gurtovoy [mailto:maxg at mellanox.com]
>>>>>>>
>>>>>>> I think we need to add fence to the UMR wqe.
>>>>>>>
>>>>>>> diff --git a/drivers/infiniband/hw/mlx5/qp.c
>>>>>>> b/drivers/infiniband/hw/mlx5/qp.c index ad8a263..c38c4fa 100644
>>>>>>> --- a/drivers/infiniband/hw/mlx5/qp.c
>>>>>>> +++ b/drivers/infiniband/hw/mlx5/qp.c
>>>>>>> @@ -3737,8 +3737,7 @@ static void dump_wqe(struct mlx5_ib_qp *qp,
>>>>>>> int idx, int size_16)
>>>>>>>
>>>>>>>   static u8 get_fence(u8 fence, struct ib_send_wr *wr)
>>>>>>>   {
>>>>>>> -       if (unlikely(wr->opcode == IB_WR_LOCAL_INV &&
>>>>>>> -                    wr->send_flags & IB_SEND_FENCE))
>>>>>>> +       if (wr->opcode == IB_WR_LOCAL_INV || wr->opcode ==
>>>>>>> + IB_WR_REG_MR)
>>>>>>>                  return MLX5_FENCE_MODE_STRONG_ORDERING;
>>>>>>>
>>>>>>>          if (unlikely(fence)) {
>>>>>>>
>>>>>>> Joseph,
>>>>>>> please update after trying the 2 patches (seperatly) + perf numbers.
>>>>>>>
>>>>>>> I'll take it internally and run some more tests with stronger
>>>>>>> servers using
>>>>>>> ConnectX4 NICs.
>>>>>>>
>>>>>>> These patches are only for testing and not for submission yet. If
>>>>>>> we find them good enought for upstream then we need to distinguish
>>>>>>> between ConnexcX4/IB and ConnectX5 (we probably won't see it there).
>>>>>>
>>>>>> Hi Max-
>>>>>>
>>>>>> Our testing on this patch looks good, failures seem completely
>>>>>> alleviated.  We
>>>>> are not really detecting any performance impact to small block read
>>>>> workloads.  Data below uses 50Gb CX4 initiator and target and FIO to
>>>>> generate load.  Each disk runs 4KB random reads with 4 jobs and
>>>>> queue depth
>>>> 32 per job.
>>>>> Initiator uses 16 IO queues per attached subsystem.  We tested with
>>>>> 2
>>>>> P3520 disks attached, and again with 7 disks attached.
>>>>>>
>>>>>> 				IOPS		Latency (usec)
>>>>>> 4.10-RC8	2 disks		545,695		466.0
>>>>>> With Patch	2 disks		587,663		432.8
>>>>>> 4.10-RC8	7 disks		1,074,311	829.5
>>>>>> With Patch	7 disks		1,080,099	825.4
>>>>>
>>>>> Very nice.
>>>>> We also run testing on null devices in our labs on iSER/NVMf (show
>>>>> better the network/transport layer performance) and the impact was
>>>> Atolerable.
>>>>>
>>>>>>
>>>>>> You mention these patches are only for testing.  How do we get to
>>>>>> something
>>>>> which can be submitted to upstream?
>>>>>
>>>>> Yes, we need to be careful and not put the strong_fence if it's not a must.
>>>>> I'll be out for the upcoming week, but I'll ask our mlx5 maintainers
>>>>> to prepare a suitable patch and check some other applications
>>>>> performance numbers.
>>>>> Thanks for the testing, you can use this patch meanwhile till we
>>>>> push the formal solution.
>>>>
>>>> With additional testing on this patch we are now encountering what
>>>> seems to be a new failure.  It takes hours of testing to reproduce
>>>> but we've been able to reproduce on 2 out of 2 overnight runs of
>>>> continuous testing.  I cannot say conclusively the failure is due to
>>>> the patch, as we cannot run this exact configuration without the
>>>> patch, but I can say we did not see this failure mode in previous
>>>> testing.  Either the patch induced the new failure mode, or perhaps
>>>> this problem was always present and was just exposed by adding the patch.
>> We will continue trying to characterize the failure.
>>>>
>>>> I've attached a couple dmesg logs of two different reproductions.
>>>> The t01 files are the target system and the i03 files are the
>>>> initiator system.  Failure seems to start with a sequence like below on the
>> target.  Thoughts?
>>>>
>>>> [38875.102023] nvmet: ctrl 1 keep-alive timer (15 seconds) expired!
>>>> [38875.108750] nvmet: ctrl 1 fatal error occurred!
>>>> [39028.696921] INFO: task kworker/7:3:10534 blocked for more than 120
>>>> seconds.
>>>> [39028.704813]       Not tainted 4.10.0-rc8patch-2-get-fence #5
>>>> [39028.711147] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>>>> disables this message.
>>>> [39028.719900] kworker/7:3     D    0 10534      2 0x00000000
>>>> [39028.719908] Workqueue: events nvmet_rdma_release_queue_work
>>>> [nvmet_rdma] [39028.719909] Call Trace:
>>>> [39028.719914]  __schedule+0x233/0x6f0 [39028.719918]  ?
>>>> sched_clock+0x9/0x10 [39028.719919]  schedule+0x36/0x80
>>>> [39028.719921]  schedule_timeout+0x22a/0x3f0 [39028.719924]  ?
>>>> vprintk_emit+0x312/0x4a0 [39028.719927]  ?
>>>> __kfifo_to_user_r+0xb0/0xb0 [39028.719929]
>> wait_for_completion+0xb4/0x140 [39028.719930]  ?
>>>> wake_up_q+0x80/0x80 [39028.719933]  nvmet_sq_destroy+0x41/0xf0
>>>> [nvmet] [39028.719935]  nvmet_rdma_free_queue+0x28/0xa0
>> [nvmet_rdma]
>>>> [39028.719936]  nvmet_rdma_release_queue_work+0x25/0x50
>> [nvmet_rdma]
>>>> [39028.719939]  process_one_work+0x1fc/0x4b0 [39028.719940]
>>>> worker_thread+0x4b/0x500 [39028.719942]  kthread+0x101/0x140
>>>> [39028.719943]  ? process_one_work+0x4b0/0x4b0 [39028.719945]  ?
>>>> kthread_create_on_node+0x60/0x60 [39028.719946]
>>>> ret_from_fork+0x2c/0x40
>>>
>>> Hey folks.  Apologies if this message comes through twice, but when I
>> originally sent it the list flagged it as too large due to the dmesg log
>> attachments, and then a coworker just told me they never saw it, so I don't
>> think it made it through on the first attempt.
>>>
>>> Please see last note above and dmesg example attached - after more
>> extensive testing with Max's patch we are still able to produce cqe dump errors
>> (at a much lower frequency) as well as a new failure mode involving a crash
>> dump.
>>>
>>
>> Hi Joseph,
>>
>> you mentioned that you saw the cqe dump with my patch but I can't find it in
>> the attached dmesg. I only see some hang wait_for_completion. can you share
>> the initiator log (since the fix was done in initiator side).
>>
>> Max.
>
> Hey Max, sure, here are both the initiator and target side dmesg logs for two test runs.  The logs tagged i03 are the initiator and t01 is the target.  We weren't aware fix was only for initiator side.

The fix is for the initiator but it's ok that you patched the target.

   We've been applying the patch to both sides and trying to get an 
overall clean run.  As you say, no errors are directly observed on the 
initiator end, we do see disconnects/reconnects and various timeouts (I 
am assuming these are due to the errors on the target end).

are you running simple fio to 16 different devices (each device is 
different subsystem with 1 ns on the target ?) ?

can you try 1 subsystem with 16 ns ?

what is the workload that cause the dump error ?

   At the target end, each log does have an instance of "dump error 
cqe", plus stack traces and other obvious problems.
>

you are getting "remote access error" for some unclear reason.
need to find why.
The reason should be found in the initiator but I only see IO error and 
reconnects there. My guess is that some IO tmo is expired and aborted 
(and the target doesn't really abort the cmd) and after some time the 
target finaly try to access some invalid resource.

what is the CPU utilization in the target side with your load ?

I think this is different issue now...

Max.
