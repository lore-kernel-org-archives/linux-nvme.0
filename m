Return-Path: <SRS0=ANVZ=BC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE47C433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jul 2020 23:57:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D89A207C4
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jul 2020 23:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="yBeNKVko";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="c352sntr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D89A207C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EJgKE1FZRFnb+ZJ9bhlL/xW0t8dFAQvWl6QhB0uNaLA=; b=yBeNKVkoEpEufrfsKOXAc//xw
	FquEYmVSubT82wtzVi5GT4hjq3l1SKblo3gqgr3QbcRkDNxlpVeprGlj2d/r3MbVsIsjkxItNn+CS
	9fJMoe+vZyR+mtLp8qOQIwgNMfT3mAfMBrTEz/yiHnHzCU45OtjWmnHDsyCox3FhFOMyvQ+mIr4Eu
	VXBHpVJeb+75vAGJ5PDtQu7QRXsk4vaSkrjVJ+A5+OxZBt2zZQQnzdKI3JCEywsxwjALtFOoXVTWs
	A6oECpHKVeEpKE7pctzDenMwcssoxRUr3OQ/MvZO5ri9VR4Vy5bNODgX1dHdOUuS2/Y5ZctzYu7gR
	HpFlAjjMw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jyl5K-0002Mq-UT; Thu, 23 Jul 2020 23:57:11 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jyl5I-0002MS-FA
 for linux-nvme@lists.infradead.org; Thu, 23 Jul 2020 23:57:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kXG1guziPwIYrpzSzCLjsIrryt9IyvyBxogem/H9bU0=; b=c352sntrqnuMrYoBLBDBf0ZPMc
 g/77OXBDeCIgEPcXK2drRsmeq+/QiMa2/CjR5npSp3q8D5vFnpyda/Mb1t/Mz3UEd+KlyOIrSFbCN
 qfbgcgynzZjdGcau2Ae0HPT6M46b3UEKOrtYGkMhyoIWNyFOJHGt7weDhU/Qp0YEghf8X7/QUUyHV
 PVEJikgxDpmW8UZ1O4CB61ZJglNCqGXoqbPR9liqg6Dyr7TlIromDqQfZkqPMtZIPZJkMNMTIMliA
 znsy2DmIIeS+G4jh8aXq1G1lTWtG1cjKbv6dVPGyBTNqutMniazLQaE8VnvPsDjGchmyErgd8ppFF
 yRXxJmag==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1jyl5B-0006oV-RA; Thu, 23 Jul 2020 17:57:03 -0600
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200722233219.117326-1-sagi@grimberg.me>
 <20200722233219.117326-3-sagi@grimberg.me>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <770b71ff-b3d9-886d-3455-cfae217c45c8@deltatee.com>
Date: Thu, 23 Jul 2020 17:56:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722233219.117326-3-sagi@grimberg.me>
Content-Language: en-US
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: james.smart@broadcom.com, anton@lightbitslabs.com,
 kbusch@kernel.org, hch@lst.de, linux-nvme@lists.infradead.org,
 sagi@grimberg.me
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v3 2/2] nvme-core: fix deadlock in disconnect during
 scan_work and/or ana_work
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200723_195708_594885_9097517E 
X-CRM114-Status: GOOD (  14.01  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Anton Eidelman <anton@lightbitslabs.com>,
 James Smart <james.smart@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 2020-07-22 5:32 p.m., Sagi Grimberg wrote:
> A deadlock happens in the following scenario with multipath:
> 1) scan_work(nvme0) detects a new nsid while nvme0
>     is an optimized path to it, path nvme1 happens to be
>     inaccessible.
> 
> 2) Before scan_work is complete nvme0 disconnect is initiated
>     nvme_delete_ctrl_sync() sets nvme0 state to NVME_CTRL_DELETING
> 
> 3) scan_work(1) attempts to submit IO,
>     but nvme_path_is_optimized() observes nvme0 is not LIVE.
>     Since nvme1 is a possible path IO is requeued and scan_work hangs.
> 
[snip]
> 
> Fixes: 0d0b660f214d ("nvme: add ANA support")
> Reported-by: Anton Eidelman <anton@lightbitslabs.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
I just tested nvme-5.9 and, after bisecting, found that this commit is
hanging the nvme/031 test in blktests[1]. The test just rapidly creates,
connects and destroys nvmet subsystems. The dmesg trace is below but I
haven't really dug into root cause.

Thanks,

Logan


[1] https://github.com/osandov/blktests/blob/master/tests/nvme/031

--

[  191.715456] run blktests nvme/031 at 2020-07-23 17:50:47
[  191.839255] nvmet: adding nsid 1 to subsystem blktests-subsystem-0
[  191.870671] nvmet: creating controller 1 for subsystem
blktests-subsystem-0 for NQN
nqn.2014-08.org.nvmexpress:uuid:951e55c4-2f33-4c8f-95f0-7983d9c2e9a4.
[  191.876700] nvme nvme3: creating 4 I/O queues.
[  191.880849] nvme nvme3: new ctrl: "blktests-subsystem-0"
[  191.892297] nvme nvme3: Removing ctrl: NQN "blktests-subsystem-0"
[  222.173354] nvmet: ctrl 1 keep-alive timer (15 seconds) expired!
[  222.174547] nvmet: ctrl 1 fatal error occurred!
[  364.000818] INFO: task kworker/u9:1:137 blocked for more than 120
seconds.
[  364.002018]       Not tainted
5.8.0-rc4-eid-vmlocalyes-dbg-01041-g97e9bb2b27bc #1442
[  364.003069] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  364.004127] kworker/u9:1    D    0   137      2 0x00004000
[  364.004924] Workqueue: nvme-wq nvme_scan_work
[  364.005670] Call Trace:
[  364.006096]  __schedule+0x56b/0xcd0
[  364.006692]  ? __sched_text_start+0x8/0x8
[  364.007376]  ? mark_held_locks+0x86/0xb0
[  364.008050]  schedule+0x80/0x140
[  364.008610]  io_schedule+0x21/0x50
[  364.009131]  wait_on_page_bit_common+0x222/0x730
[  364.009772]  ? page_cache_free_page.isra.43+0x1f0/0x1f0
[  364.010499]  ? find_get_pages_range_tag+0x680/0x680
[  364.011156]  do_read_cache_page+0x697/0xb20
[  364.011715]  ? blkdev_get+0xe8/0x260
[  364.012199]  ? nvme_validate_ns+0x818/0x1020
[  364.012828]  ? process_one_work+0x66b/0xb70
[  364.013393]  ? generic_file_read_iter+0x1f0/0x1f0
[  364.014026]  ? create_object+0x46f/0x4f0
[  364.014556]  ? mark_held_locks+0x86/0xb0
[  364.015143]  read_cache_page+0x3a/0x50
[  364.015651]  read_part_sector+0x74/0x253
[  364.016178]  read_lba+0x1da/0x340
[  364.016630]  ? ultrix_partition+0x430/0x430
[  364.017270]  ? efi_partition+0x324/0xac3
[  364.017817]  ? kasan_kmalloc+0x9/0x10
[  364.018322]  ? kmem_cache_alloc_trace+0x11f/0x290
[  364.018982]  efi_partition+0x342/0xac3
[  364.019488]  ? widen_string+0x190/0x190
[  364.020010]  ? is_gpt_valid.part.5+0x630/0x630
[  364.020600]  ? format_decode+0xd6/0x5c0
[  364.021191]  ? enable_ptr_key_workfn+0x30/0x30
[  364.021802]  ? hex_string+0x2e0/0x2e0
[  364.022325]  ? memcpy+0x4d/0x60
[  364.022752]  ? vsnprintf+0x66f/0x8e0
[  364.023238]  ? pointer+0x5b0/0x5b0
[  364.023705]  ? add_part+0x1b0/0x1b0
[  364.024176]  ? vsprintf+0x20/0x20
[  364.024634]  ? is_gpt_valid.part.5+0x630/0x630
[  364.025287]  blk_add_partitions+0x1f1/0x650
[  364.025856]  bdev_disk_changed+0xd8/0x190
[  364.026398]  __blkdev_get+0x812/0xa50
[  364.026896]  ? __blkdev_put+0x400/0x400
[  364.027411]  ? bdget+0x1b8/0x1d0
[  364.027848]  ? blkdev_fsync+0x70/0x70
[  364.028345]  blkdev_get+0xe8/0x260
[  364.028837]  __device_add_disk+0x597/0x850
[  364.029396]  ? blk_alloc_devt+0x1d0/0x1d0
[  364.029934]  ? kobject_uevent_env+0xce/0xa90
[  364.030513]  ? __kasan_check_write+0x14/0x20
[  364.031087]  device_add_disk+0x13/0x20
[  364.031591]  nvme_mpath_set_live+0x1c7/0x1d0
[  364.032161]  ? nvme_ana_work+0x40/0x40
[  364.032666]  nvme_update_ns_ana_state+0x7f/0x90
[  364.033303]  nvme_mpath_add_disk+0x216/0x240
[  364.033878]  ? nvme_mpath_stop+0x40/0x40
[  364.034416]  nvme_validate_ns+0x818/0x1020
[  364.034973]  ? nvme_dev_ioctl+0x1e0/0x1e0
[  364.035510]  ? __blk_mq_free_request+0xf3/0x130
[  364.036119]  ? blk_mq_free_request+0x1ea/0x250
[  364.036721]  ? __nvme_submit_sync_cmd+0x186/0x310
[  364.037376]  ? kasan_unpoison_shadow+0x35/0x50
[  364.037975]  ? __kasan_kmalloc.constprop.14+0xc1/0xd0
[  364.038649]  ? nvme_scan_work+0x167/0x3d4
[  364.039194]  nvme_scan_work+0x259/0x3d4
[  364.039715]  ? nvme_fw_act_work+0x220/0x220
[  364.040274]  ? process_one_work+0x590/0xb70
[  364.040864]  ? lock_is_held_type+0xba/0xf0
[  364.041422]  ? rcu_read_lock_bh_held+0xc0/0xc0
[  364.042016]  ? trace_hardirqs_on+0x2d/0x120
[  364.042581]  process_one_work+0x66b/0xb70
[  364.043117]  ? worker_thread+0x146/0x6c0
[  364.043650]  ? pwq_dec_nr_in_flight+0x130/0x130
[  364.044258]  ? lockdep_hardirqs_off+0x64/0xa0
[  364.045005]  worker_thread+0x6e/0x6c0
[  364.045510]  ? __kasan_check_read+0x11/0x20
[  364.046077]  ? process_one_work+0xb70/0xb70
[  364.046639]  kthread+0x1e7/0x210
[  364.047079]  ? kthread_create_on_node+0xc0/0xc0
[  364.047689]  ret_from_fork+0x22/0x30
[  364.048195] INFO: task nvme:536 blocked for more than 120 seconds.
[  364.049045]       Not tainted
5.8.0-rc4-eid-vmlocalyes-dbg-01041-g97e9bb2b27bc #1442
[  364.050068] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  364.051098] nvme            D    0   536    507 0x00000000
[  364.051827] Call Trace:
[  364.052167]  __schedule+0x56b/0xcd0
[  364.052644]  ? __sched_text_start+0x8/0x8
[  364.053208]  ? do_raw_spin_lock+0x11e/0x1e0
[  364.053773]  ? lock_is_held_type+0xba/0xf0
[  364.054328]  schedule+0x80/0x140
[  364.054768]  schedule_preempt_disabled+0xe/0x10
[  364.055372]  __mutex_lock+0x6cf/0xba0
[  364.055863]  ? __flush_work+0x4a2/0x5b0
[  364.056379]  ? nvme_mpath_clear_ctrl_paths+0x2f/0xb0
[  364.057065]  ? mutex_trylock+0x190/0x190
[  364.057596]  ? __flush_work+0x508/0x5b0
[  364.058116]  ? mark_held_locks+0x86/0xb0
[  364.058646]  ? lockdep_hardirqs_on+0x71/0xf0
[  364.059216]  ? __cancel_work_timer+0x11e/0x2d0
[  364.059815]  mutex_lock_nested+0x1b/0x20
[  364.060340]  ? mod_delayed_work_on+0x120/0x120
[  364.060957]  ? mutex_lock_nested+0x1b/0x20
[  364.061508]  nvme_mpath_clear_ctrl_paths+0x2f/0xb0
[  364.062152]  nvme_remove_namespaces+0x8a/0x230
[  364.062746]  ? lockdep_hardirqs_on+0x71/0xf0
[  364.063320]  ? nvme_remove_invalid_namespaces+0x240/0x240
[  364.064046]  nvme_do_delete_ctrl+0x6f/0xa6
[  364.064596]  nvme_sysfs_delete.cold.97+0x8/0xd
[  364.065218]  dev_attr_store+0x3f/0x60
[  364.065715]  ? component_bind_all.cold.15+0xb5/0xb5
[  364.066365]  sysfs_kf_write+0x89/0xb0
[  364.066860]  ? sysfs_file_ops+0xa0/0xa0
[  364.067375]  kernfs_fop_write+0x155/0x250
[  364.067917]  __vfs_write+0x50/0xa0
[  364.068378]  vfs_write+0xf9/0x280
[  364.068855]  ksys_write+0xcc/0x170
[  364.069319]  ? __ia32_sys_read+0x50/0x50
[  364.069850]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  364.070548]  __x64_sys_write+0x43/0x50
[  364.071054]  do_syscall_64+0x60/0xf0
[  364.071537]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  364.072211] RIP: 0033:0x7f75321d9504
[  364.072691] Code: Bad RIP value.
[  364.073151] RSP: 002b:00007ffef4c2c168 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[  364.074152] RAX: ffffffffffffffda RBX: 0000000000000004 RCX:
00007f75321d9504
[  364.075155] RDX: 0000000000000001 RSI: 0000558c5cba8e4e RDI:
0000000000000004
[  364.076094] RBP: 0000000000000000 R08: 0000000000000001 R09:
0000558c5dff0460
[  364.077060] R10: 0000000000000000 R11: 0000000000000246 R12:
0000558c5dff0500
[  364.078063] R13: 00007ffef4c2d888 R14: 0000000000000020 R15:
0000000000000003
[  364.079017]
[  364.079017] Showing all locks held in the system:
[  364.079838] 1 lock held by khungtaskd/35:
[  364.080375]  #0: ffffffff97758de0 (rcu_read_lock){....}-{1:2}, at:
debug_show_all_locks+0x33/0x1cb
[  364.081587] 4 locks held by kworker/u9:1/137:
[  364.082169]  #0: ffff888128b93938
((wq_completion)nvme-wq){+.+.}-{0:0}, at: process_one_work+0x590/0xb70
[  364.083417]  #1: ffff888129d1fde0
((work_completion)(&ctrl->scan_work)){+.+.}-{0:0}, at:
process_one_work+0x590/0xb70
[  364.084835]  #2: ffff888272634550 (&ctrl->scan_lock){+.+.}-{3:3}, at:
nvme_scan_work+0x101/0x3d4
[  364.085992]  #3: ffff888116852600 (&bdev->bd_mutex){+.+.}-{3:3}, at:
__blkdev_get+0x103/0xa50
[  364.087115] 2 locks held by kworker/1:1H/193:
[  364.087697] 1 lock held by in:imklog/313:
[  364.088231]  #0: ffff8881209228f0 (&f->f_pos_lock){+.+.}-{3:3}, at:
__fdget_pos+0x7e/0x80
[  364.089338] 4 locks held by nvme/536:
[  364.089832]  #0: ffff888127312448 (sb_writers#4){.+.+}-{0:0}, at:
vfs_write+0x251/0x280
[  364.090884]  #1: ffff88812270b488 (&of->mutex){+.+.}-{3:3}, at:
kernfs_fop_write+0xf5/0x250
[  364.091981]  #2: ffff888270cd5748 (kn->active#185){++++}-{0:0}, at:
kernfs_remove_self+0x1a5/0x230
[  364.093181]  #3: ffff888272634550 (&ctrl->scan_lock){+.+.}-{3:3}, at:
nvme_mpath_clear_ctrl_paths+0x2f/0xb0
[  364.094461]
[  364.094672] =============================================
[  364.094672]


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
