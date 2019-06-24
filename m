From: james.smart@broadcom.com (James Smart)
Date: Mon, 24 Jun 2019 11:51:45 -0700
Subject: [PATCH 2/2] nvme: flush scan_work when resetting controller
In-Reply-To: <2a6168f3-37f6-1acf-2e89-48a3b9cac8e1@grimberg.me>
References: <20190618101025.78840-1-hare@suse.de>
 <20190618101025.78840-3-hare@suse.de>
 <36c093c6-9fea-aa2f-affe-70957e0c5b1b@grimberg.me>
 <681a1c11-7d11-6e28-bc64-b14bef22c144@suse.com>
 <fe550375-fc5d-ff19-c303-6671b8713df6@grimberg.me>
 <d64a5902-139e-4119-ec75-3394e0b129f9@suse.de>
 <d84bf42f-c9fe-6af4-58cc-14195ddff931@grimberg.me>
 <68599577-450a-ade1-451c-f310e5094317@grimberg.me>
 <66f3dd84-77cd-fc45-025c-4082cf3df7ec@suse.de>
 <2a6168f3-37f6-1acf-2e89-48a3b9cac8e1@grimberg.me>
Message-ID: <1bda7d1a-19f9-8a79-51cc-e5428d226d88@broadcom.com>



On 6/24/2019 11:08 AM, Sagi Grimberg wrote:
>
>>>>> That's what I thought initially, too, but it turned out to be not
>>>>> sufficient.
>>>>
>>>> Not sufficient because it hangs? or panics?
>>>>
>> It hangs, and we're seeing a warning:
>>
>> kernel: [67088.344034] WARNING: CPU: 4 PID: 25020 at
>> ../lib/percpu-refcount.c:334 percpu_ref_kill_and_confirm+0x7a/0xa0
>> [ .. ]
>> kernel: [67088.344106] Call Trace:
>> kernel: [67088.344112]? blk_freeze_queue_start+0x2a/0x40
>> kernel: [67088.344114]? blk_freeze_queue+0xe/0x40
>> kernel: [67088.344118]? nvme_update_disk_info+0x36/0x260 [nvme_core]
>> kernel: [67088.344122]? __nvme_revalidate_disk+0xca/0xf0 [nvme_core]
>> kernel: [67088.344125]? nvme_revalidate_disk+0xa6/0x120 [nvme_core]
>> kernel: [67088.344127]? ? blk_mq_get_tag+0xa3/0x220
>> kernel: [67088.344130]? revalidate_disk+0x23/0xc0
>> kernel: [67088.344133]? nvme_validate_ns+0x43/0x830 [nvme_core]
>> kernel: [67088.344137]? ? wake_up_q+0x70/0x70
>> kernel: [67088.344139]? ? blk_mq_free_request+0x12a/0x160
>> kernel: [67088.344142]? ? __nvme_submit_sync_cmd+0x73/0xe0 [nvme_core]
>> kernel: [67088.344145]? nvme_scan_work+0x2b3/0x350 [nvme_core]
>> kernel: [67088.344149]? process_one_work+0x1da/0x400
>>
>> ?From which I've inferred that we're still running a scan in parallel to
>> reset, and that the scan thread is calling 'blk_freeze_queue()' on a
>> queue which is already torn down.
>
>
> Where is the scan triggered from? there is no scan call from the reset
> path.
>
> Is there a namespace removal or something else that triggers AEN
> to make this happen?
>
> What exactly is the scenario?

I believe this is from quick link bounce or logout/login testing on FC.

The loss of connectivity to the subsystem causes a reset to be done on 
the controller. Re-login causes the transport to send a discovery scan 
-or- the reconnect timer will fire, causing the controller to reconnect 
and issue the scan.

These resets and reconnects are right on the heels of each other - thus 
scan may not be finished before the reset occurs.? Reset will complete, 
as the ios it knows about are cleaned up.

-- james
