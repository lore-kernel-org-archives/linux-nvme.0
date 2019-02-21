From: osmithde@cisco.com (Oliver Smith-Denny)
Date: Thu, 21 Feb 2019 15:16:58 -0800
Subject: [PATCH] nvmet-fc: Bring Disconnect into compliance with FC-NVME
 spec
In-Reply-To: <2cd0c5e9-845a-2122-e2a1-7ef3f96ce33f@cisco.com>
References: <20190205173902.17947-1-jsmart2021@gmail.com>
 <20190220221454.GA31450@osmithde-lnx.cisco.com>
 <2fc8ae0b-2773-87e1-a319-55e251b3f7d7@gmail.com>
 <2cd0c5e9-845a-2122-e2a1-7ef3f96ce33f@cisco.com>
Message-ID: <7721fbe9-cb21-5197-2c9d-f6786e082696@cisco.com>

On 02/21/2019 10:45 AM, Oliver Smith-Denny wrote:> I have been testing 
with these changes and have been getting one
> warning (kernel/workqueue.c:3028) when the discovery controller gets
> NVMe_Disconnect. I also have been trying some error injection (not
> sending the occasional response from the target LLDD for write data)
> and getting blocked tasks for > 120 seconds, with the following call
> trace (this is after getting NVMe_Disconnect for the data controller):
> 
> INFO: task kworker/27:2:35310 blocked for more than 120 seconds.
> Tainted: G??????? W? O????? 5.0.0-rc7-next-20190220+ #1
>  ?kworker/27:2??? D??? 0 35310????? 2 0x80000080
> Workqueue: events nvmet_fc_handle_ls_rqst_work [nvmet_fc]
> Call Trace:
> __schedule+0x2ab/0x880
> ? complete+0x4d/0x60
> schedule+0x36/0x70
> schedule_timeout+0x1dc/0x300
> complete+0x4d/0x60
> nvmet_destroy_namespace+0x20/0x20 [nvmet]
> wait_for_completion+0x121/0x180
> wake_up_q+0x80/0x80
> nvmet_sq_destroy+0x4f/0xf0 [nvmet]
> nvmet_fc_delete_target_assoc+0x2fd/0x3f0 [nvmet_fc]
> nvmet_fc_handle_ls_rqst_work+0x6ad/0xa40 [nvmet_fc]
> process_one_work+0x179/0x3a0
> worker_thread+0x4f/0x3e0
> kthread+0x105/0x140
> ? max_active_store+0x80/0x80
> ? kthread_bind+0x20/0x20
> ret_from_fork+0x35/0x40

I tried running the vanilla 5.0-rc7 kernel and I did not see
either the warning or the blocked tasked (but that makes sense because 
the vanilla kernel doesn't delete controllers with the current logic on 
NVME_Disconnect).

I then readded your patch to the kernel and I see both the warning and 
blocked task. I also added some printks. From what I can see for the
above blocked task, after NVMe_Disconnect comes in to the target
(expected, the initiator has sent ABTS for a write that never
completed, then it sends NVMe_Disconnect), nvmet gets stuck
deleting I/O queues. In my setup, there are 80 I/O queues.
On queue 14 (after deleting 80 - 15), nvmet hangs in nvmet_sq_destroy()
doing wait_for_completion(&sq->free_done);

20 seconds pass and the nvmet keep-alive timer expires (I believe 
because the initiator has sent the NVMe_Disconnect and so stops
sending keep alives to that controller). At this point, the process
to delete the association starts happening a second time. It picks up
at queue 14, retrying it. This time, the nvmet_sq_destroy() finishes, 
but the queue is not freed (as two references remain). The remaining
I/O queues and the admin queue are then destroyed. After this the above
call trace is dumped.

The warning I have less information about. Here is the call trace printed:
WARNING: CPU: 8 PID: 53 at kernel/workqueue.c:3028 
__flush_work.isra.31+0x1a2/0x1b0
RIP: 0010:__flush_work.isra.31+0x1a2/0x1b0
Code: fb 66 0f 1f 44 00 00 31 c0 eb aa 4c 89 e7 c6 07 00 0f 1f 40 00 fb 
66 0f 1f 44 00 00 31 c0 eb 95 e8 63 01 fe ff 0f 0b 90 eb 8b <0f> 0b 31 
c0 eb 85 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 55 48 89
RSP: 0018:ffffc90006747be8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888c03830148 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff888c03830148
RBP: ffffc90006747c58 R08: 0000000000000006 R09: 0000000000000006
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: ffffc90006747c88 R15: ffff888c0c105ac0
FS:  0000000000000000(0000) GS:ffff888c10a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb4fe290000 CR3: 000000000220e003 CR4: 00000000007606e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
? del_timer+0x59/0x80
__cancel_work_timer+0x10e/0x190
? pcpu_free_area+0x1da/0x2b0
cancel_work_sync+0x10/0x20
nvmet_ctrl_free+0x112/0x1b0 [nvmet]
nvmet_sq_destroy+0x8a/0xf0 [nvmet]
nvmet_fc_delete_target_assoc+0x2fd/0x3f0 [nvmet_fc]
nmet_fc_handle_ls_rqst_work+0x6ba/0xa40 [nvmet_fc]
process_one_work+0x179/0x3a0
worker_thread+0x4f/0x3e0
kthread+0x105/0x140
? max_active_store+0x80/0x80
? kthread_bind+0x20/0x20
ret_from_fork+0x35/0x40
---[ end trace b209b06283b18e21 ]---

I am still investigating the possibility that the LLDD is
doing something poorly (it is in bringup, so I wouldn't
be surprised in the slightest :) but from what I can tell
something is unhappy in the delete_assoc path. Thoughts from
your end? I am also happy to wait until you have completed
your spec review and test with the full changeset. Let me
know what I can do to help debug. I will continue looking
on my end.

Thanks,
Oliver
