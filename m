From: osmithde@cisco.com (Oliver Smith-Denny)
Date: Wed, 27 Feb 2019 12:25:18 -0800
Subject: [PATCH] nvmet-fc: Bring Disconnect into compliance with FC-NVME
 spec
In-Reply-To: <9da8e308-aa16-25bb-3bf0-e3cef3e28ab8@broadcom.com>
References: <20190205173902.17947-1-jsmart2021@gmail.com>
 <20190220221454.GA31450@osmithde-lnx.cisco.com>
 <2fc8ae0b-2773-87e1-a319-55e251b3f7d7@gmail.com>
 <2cd0c5e9-845a-2122-e2a1-7ef3f96ce33f@cisco.com>
 <7721fbe9-cb21-5197-2c9d-f6786e082696@cisco.com>
 <9da8e308-aa16-25bb-3bf0-e3cef3e28ab8@broadcom.com>
Message-ID: <0137994b-8bd7-dd98-14c1-ce6ddb63b5e5@cisco.com>

On 02/26/2019 01:53 PM, James Smart wrote:
> On 2/21/2019 3:16 PM, Oliver Smith-Denny wrote:
>> On 02/21/2019 10:45 AM, Oliver Smith-Denny wrote:
>>>
>>> INFO: task kworker/27:2:35310 blocked for more than 120 seconds.
>>> Tainted: G??????? W? O????? 5.0.0-rc7-next-20190220+ #1
>>> ??kworker/27:2??? D??? 0 35310????? 2 0x80000080
>>> Workqueue: events nvmet_fc_handle_ls_rqst_work [nvmet_fc]
>>> Call Trace:
>>> __schedule+0x2ab/0x880
>>> ? complete+0x4d/0x60
>>> schedule+0x36/0x70
>>> schedule_timeout+0x1dc/0x300
>>> complete+0x4d/0x60
>>> nvmet_destroy_namespace+0x20/0x20 [nvmet]
>>> wait_for_completion+0x121/0x180
>>> wake_up_q+0x80/0x80
>>> nvmet_sq_destroy+0x4f/0xf0 [nvmet]
>>> nvmet_fc_delete_target_assoc+0x2fd/0x3f0 [nvmet_fc]
>>> nvmet_fc_handle_ls_rqst_work+0x6ad/0xa40 [nvmet_fc]
>>> process_one_work+0x179/0x3a0
>>> worker_thread+0x4f/0x3e0
>>> kthread+0x105/0x140
>>> ? max_active_store+0x80/0x80
>>> ? kthread_bind+0x20/0x20
>>> ret_from_fork+0x35/0x40
> 
> I took at look at the two patches, and the one had missed at ! check on 
> scheduling the work. Thus it resulted in an extra put being done, thus 
> it would be released too soon.
> 
> Try with this v2 patch and let me know.

I ran the same tests with the 5.0.0-rc7 kernel with the diconnect
patch and the v2 patch of the targetport assoc_list patch applied.

When I ran normal traffic (no dropping of write responses), I still saw
the warning (see below) happen when the discovery controller got
deleted. I took the host offline to trigger a keep alive failure
in the controller, which successfully deleted the data controller.

WARNING: CPU: 30 PID: 403 at kernel/workqueue.c:3028 
__flush_work.isra.31+0x1a2/0x1b0
Workqueue: events nvmet_fc_handle_ls_rqst_work [nvmet_fc]
RIP: 0010:__flush_work.isra.31+0x1a2/0x1b0
Code: fb 66 0f 1f 44 00 00 31 c0 eb aa 4c 89 e7 c6 07 00 0f 1f 40 00 fb 
66 0f 1f 44 00 00 31 c0 eb 95 e8 63 01 fe ff 0f 0b 90 eb 8b <0f> 0b 31 
c0 eb 85 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 55 48 89
RSP: 0018:ffffc90008edbbe8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888bf150c148 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff888bf150c148
RBP: ffffc90008edbc58 R08: 0000000000002a15 R09: 0000000000002a15
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: ffffc90008edbc88 R15: ffff888c07b90000
FS:  0000000000000000(0000) GS:ffff888c10c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd491f52140 CR3: 000000000220e004 CR4: 00000000007606e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000000400
PKRU: 55555554
Call Trace:
? del_timer+0x59/0x80
__cancel_work_timer+0x10e/0x190
cancel_work_sync+0x10/0x20
nvmet_ctrl_free+0x112/0x1b0 [nvmet]
nvmet_sq_destroy+0xdb/0x140 [nvmet]
nvmet_fc_delete_target_assoc+0x2f2/0x370 [nvmet_fc]
nvmet_fc_handle_ls_rqst_work+0x6b8/0xa20 [nvmet_fc]
process_one_work+0x179/0x3a0
worker_thread+0x4f/0x3e0
kthread+0x105/0x140
? max_active_store+0x80/0x80
? kthread_bind+0x20/0x20
ret_from_fork+0x35/0x40
---[ end trace 5d3c8b3548a4fb95 ]---

When I ran traffic with dropping the occasional write response, I again
the above warning when the discovery controller gets NVMe_Disconnect.
After the host sent ABTS and NVMe_Disconnect to the data controller,
I saw the same hung task as before (slightly different call trace,
shown below, the original is quoted above).

It occurred in the same spot, as the controller got hung up in
nvmet_sq_destroy, doing wait_for_completion(&sq->free_done);
I see the below call trace ~10 times in dmesg.

INFO: task kworker/30:1:403 blocked for more than 120 seconds.
kworker/30:1    D    0   403      2 0x80000000
Workqueue: events nvmet_fc_handle_ls_rqst_work [nvmet_fc]
Call Trace:
__schedule+0x2ab/0x880
schedule+0x36/0x70
schedule_timeout+0x1dc/0x300
wait_for_completion+0x121/0x180
? wake_up_q+0x80/0x80
nvmet_sq_destroy+0x84/0x140 [nvmet]
nvmet_fc_delete_target_assoc+0x2f2/0x370 [nvmet_fc]
nvmet_fc_handle_ls_rqst_work+0x6b8/0xa20 [nvmet_fc]
process_one_work+0x179/0x3a0
worker_thread+0x4f/0x3e0
kthread+0x105/0x140
? max_active_store+0x80/0x80
? kthread_bind+0x20/0x20
ret_from_fork+0x35/0x40

Thanks again for your help in looking into this. Let me
know if there are other patches I should apply or other
things to test.

Thanks,
Oliver
