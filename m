From: hare@suse.de (Hannes Reinecke)
Date: Wed, 26 Jun 2019 07:34:13 +0200
Subject: [PATCH 2/2] nvme: flush scan_work when resetting controller
In-Reply-To: <960997d6-9ce3-5730-00e6-5b2639502eaa@grimberg.me>
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
 <ff13e243-da8f-f04c-d31b-f7c46d3a4375@suse.de>
 <960997d6-9ce3-5730-00e6-5b2639502eaa@grimberg.me>
Message-ID: <04a61807-ed2c-c91a-6eeb-c3df864fedc4@suse.de>

On 6/25/19 11:50 PM, Sagi Grimberg wrote:
> 
>>>>>>> That's what I thought initially, too, but it turned out to be not
>>>>>>> sufficient.
>>>>>>
>>>>>> Not sufficient because it hangs? or panics?
>>>>>>
>>>> It hangs, and we're seeing a warning:
>>>>
>>>> kernel: [67088.344034] WARNING: CPU: 4 PID: 25020 at
>>>> ../lib/percpu-refcount.c:334 percpu_ref_kill_and_confirm+0x7a/0xa0
>>>> [ .. ]
>>>> kernel: [67088.344106] Call Trace:
>>>> kernel: [67088.344112]? blk_freeze_queue_start+0x2a/0x40
>>>> kernel: [67088.344114]? blk_freeze_queue+0xe/0x40
>>>> kernel: [67088.344118]? nvme_update_disk_info+0x36/0x260 [nvme_core]
>>>> kernel: [67088.344122]? __nvme_revalidate_disk+0xca/0xf0 [nvme_core]
>>>> kernel: [67088.344125]? nvme_revalidate_disk+0xa6/0x120 [nvme_core]
>>>> kernel: [67088.344127]? ? blk_mq_get_tag+0xa3/0x220
>>>> kernel: [67088.344130]? revalidate_disk+0x23/0xc0
>>>> kernel: [67088.344133]? nvme_validate_ns+0x43/0x830 [nvme_core]
>>>> kernel: [67088.344137]? ? wake_up_q+0x70/0x70
>>>> kernel: [67088.344139]? ? blk_mq_free_request+0x12a/0x160
>>>> kernel: [67088.344142]? ? __nvme_submit_sync_cmd+0x73/0xe0 [nvme_core]
>>>> kernel: [67088.344145]? nvme_scan_work+0x2b3/0x350 [nvme_core]
>>>> kernel: [67088.344149]? process_one_work+0x1da/0x400
>>>>
>>>> ??From which I've inferred that we're still running a scan in 
>>>> parallel to
>>>> reset, and that the scan thread is calling 'blk_freeze_queue()' on a
>>>> queue which is already torn down.
>>>
>>>
>>> Where is the scan triggered from? there is no scan call from the reset
>>> path.
>>>
>> It's triggered from AEN, being received around the same time when reset
>> triggers.
>> There's actually a change that the AEN handling itself triggered the
>> reset, but I haven't be able to decipher that from the crash dump.
>>
>>> Is there a namespace removal or something else that triggers AEN
>>> to make this happen?
>>>
>>> What exactly is the scenario?
>>
>> The scenario is multiple storage failover on NetApp OnTAP while I/O is
>> running.
> 
> Hannes,
> 
> I'm still not convinced that the transports need to flush the scan work
> on resets.
> 
> Does the below help as an alternative:
> -- 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 024fb219de17..074bcb1e797a 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1665,6 +1665,10 @@ static void __nvme_revalidate_disk(struct gendisk 
> *disk, struct nvme_id_ns *id)
>  ?{
>  ??????? struct nvme_ns *ns = disk->private_data;
> 
> +?????? /* if ns is removing we cannot mangle with the request queue */
> +?????? if (test_bit(NVME_NS_REMOVING, &ns->flags))
> +?????????????? return;
> +
>  ??????? /*
>  ???????? * If identify namespace failed, use default 512 byte block 
> size so
>  ???????? * block layer can use before failing read/write for 0 capacity.
> -- 

Hmm. Not sure if that is sufficient, though.
We do issue several I/O in the course of nvme_revalidate_disk(), and as 
we're running fully asynchronous here the disk might be removed at any 
given time. Cf the above stack trace; we're getting an error for the 
_second_ I/O (nvme_identify_ns is issuing I/O, too, but went through 
without errors).
So if we were to go that route we'd need to protect each and every I/O 
with that test.
Which then would be similar to my patch, only the 'resetting' state 
check replaced by the 'removing' check.

Cheers,

Hanne
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare at suse.de                              +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
