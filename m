From: james.smart@broadcom.com (James Smart)
Date: Tue, 12 Jun 2018 13:45:12 -0700
Subject: [BUG REPORT] crash in nvme-fcloop
In-Reply-To: <20180525115605.fbsf45jypmzjfxix@linux-x5ow.site>
References: <20180525115605.fbsf45jypmzjfxix@linux-x5ow.site>
Message-ID: <4cbd4238-2942-2091-08da-1bde896c957e@broadcom.com>



On 5/25/2018 4:56 AM, Johannes Thumshirn wrote:
> Hey James et al,
>
> I'm experiencing a bug with Linus' current master (HEAD ==
> b50694381cfc22dce3a60a291cdae294a5e5777c) and nvme-fcloop.ko.
>
> It's trivially reproduced (please find the reproducer below) and
> manifests in several ways:
>
> Either I get stuck in an endless loop of:
> [   19.577145] nvme_fcloop: fcloop_exit: Failed deleting target port
> [   19.577788] nvme_fcloop: fcloop_exit: Failed deleting remote port
>
> Or it panics with the following trace (there are actually multiple
> panics interleaved:
> [  493.722109] BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
> [  493.722395] nvme nvme1: NVME-FC{1}: controller connectivity lost. Awaiting Reconnect
> [  493.724065] PGD 0 P4D 0
> [  493.726673] Oops: 0000 [#1] SMP PTI
> [  493.727524] nvme_fcloop: fcloop_exit: Failed deleting target port
> [  493.727545] Modules linked in: loop nvme_fcloop(-) nvme_fc nvme_fabrics nvmet_fc nvmet nvme_core
> [  493.729109] nvme_fcloop: fcloop_exit: Failed deleting remote port
> [  493.731249] CPU: 4 PID: 277 Comm: kworker/4:1 Not tainted 4.17.0-rc6+ #890
> [  493.731251] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.0.0-prebuilt.qemu-project.org 04/01/2014
> [  493.731258] Workqueue: events fcloop_tgt_lsrqst_done_work [nvme_fcloop]
> [  493.732778] nvme_fcloop: fcloop_exit: Failed deleting target port
> [  493.734456] RIP: 0010:fcloop_tgt_lsrqst_done_work+0x10/0x30 [nvme_fcloop]
> [  493.734458] RSP: 0018:ffffabaa00ae3e78 EFLAGS: 00010286
> [  493.736990] nvme_fcloop: fcloop_exit: Failed deleting remote port
> [  493.740252] RAX: ffff89ebf86f42a8 RBX: ffff89ebf86f42a8 RCX: ffff89ebfb3202a0
> [  493.740253] RDX: 0000000000000000 RSI: ffff89ebf86f42a8 RDI: ffff89ebf86f4200
> [  493.740254] RBP: ffff89ebf9eac000 R08: 0000000000000000 R09: 0000000000000001
> [  493.740255] R10: 0000000000000001 R11: 0000000000000001 R12: ffff89ebfb320280
> [  493.740256] R13: ffff89ebfb323f00 R14: 0000000000000000 R15: 0ffff89ebfb323f0
> [  493.740258] FS:  0000000000000000(0000) GS:ffff89ebfb300000(0000) knlGS:0000000000000000
> [  493.740259] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  493.740260] CR2: 0000000000000008 CR3: 000000010340a000 CR4: 00000000000006e0
> [  493.740264] Call Trace:
> [  493.741114] nvme_fcloop: fcloop_exit: Failed deleting target port
> [  493.742039]  process_one_work+0x147/0x350
> [  493.742052]  worker_thread+0x47/0x3d0
> [  493.742748] nvme_fcloop: fcloop_exit: Failed deleting remote port
> [  493.743571]  kthread+0xf8/0x130
> [  493.743575]  ? rescuer_thread+0x2e0/0x2e0
> [  493.744544] nvme_fcloop: fcloop_exit: Failed deleting target port
> [  493.745503]  ? kthread_bind+0x10/0x10
> [  493.745508]  ret_from_fork+0x35/0x40
> [  493.745510] Code:
> [  493.746484] nvme_fcloop: fcloop_exit: Failed deleting remote port
> [  493.747431] 48 89 39 31 c0 c3 0f 1f 44
> [  493.748400] nvme_fcloop: fcloop_exit: Failed deleting target port
> [  493.749478] 00 00 0f 1f 44 00 00 f3 c3 66 0f 1f 84 00 00 00 00
> [  493.751108] nvme_fcloop: fcloop_exit: Failed deleting remote port
> [  493.752086] 00 0f 1f 44 00 00 48 89 f8
> [  493.752431] nvme_fcloop: fcloop_exit: Failed deleting target port
> [  493.753242] 48 8b 7f f8 48 8b 50 f0 <48> 83 7a 08 00 74
> [  493.753792] nvme_fcloop: fcloop_exit: Failed deleting remote port
> [  493.753794] nvme_fcloop: fcloop_exit: Failed deleting target port
> [  493.754294] 0c 8b 70 48 48 8b 47 38 e9 bd 0f 59 c5
> [  493.755124] nvme_fcloop: fcloop_exit: Failed deleting remote port
> [  493.755547] f3
> [  493.756098] nvme_fcloop: fcloop_exit: Failed deleting target port
> [  493.756909] c3
> [  493.757412] nvme_fcloop: fcloop_exit: Failed deleting remote port
> [  493.758181] nvme_fcloop: fcloop_exit: Failed deleting target port
> [  493.758993] RIP: fcloop_tgt_lsrqst_done_work+0x10/0x30 [nvme_fcloop] RSP: ffffabaa00ae3e78
> [  493.759101] (NULL device *): queue 0 connect admin queue failed (-111).
> [  493.759516] nvme_fcloop: fcloop_exit: Failed deleting remote port
> [  493.760325] CR2: 0000000000000008
> [  493.760327] ---[ end trace 3dea94f519a24d5e ]---

yes - removing the targetport doesn't work to well right now. A few 
things are missing.


>
> I really tried to fix the bug myself but I'm kinda lost in the maze
> currently.
>
> Any help is really appreciated here.

ok. I'll look into it. give me a little time to do so.

-- james
