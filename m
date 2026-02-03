Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E4CE87843
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Feb 2026 15:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:Date:From:Content-Type:In-Reply-To:Mime-Version:
	Message-Id:Cc:Subject:To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yRm0AfD8FqdoUSzSJzEzAAd2+IJNR3iC/JtgLxWY/FM=; b=ZgglC2qsQVGwjIgiQe0T3Ri6o0
	1hoe1WF3TyfSW06qUL919bJbrx7jCTRrE7jD3rLkTTxaT5LbloCpgzutB2lUqop3EbFa8hhyBnaFs
	PzZ5IvMqOIUxa0Cg/Krewbey9B9XfdykyPfmWd3cDH0dmhvUjgY9EnlX6de75xQHDZz7Xw6ZOt9zC
	Ur1WmwC44DRlLRr/E4RYpQybOuR7sLPpdG2BDujjvMNmtiuyb7GzXTXE+hcIgeCbBJmUp1Y8dJuaj
	HwLAipNDZYWTEoVPBGEIjbMBgsL8oaXcwke2KWkkiE1DFhUkSb+iWQpqkenXHRT4FchEkgnb8OZhO
	xTZBo3VA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnIjS-00000006s6a-36eF;
	Tue, 03 Feb 2026 15:54:26 +0000
Received: from sg-1-33.ptr.blmpb.com ([118.26.132.33])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnIjO-00000006s5v-3k5y
	for linux-nvme@lists.infradead.org;
	Tue, 03 Feb 2026 15:54:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1770134050;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=yRm0AfD8FqdoUSzSJzEzAAd2+IJNR3iC/JtgLxWY/FM=;
 b=gsrElGTRYhGmacJpveeYOEoVxG3QU0aiNztstOt47oS3lOc2kAN2v0d0C/l7vfltyzemFt
 X2bcyuvmHITRoRVwacpD6fpet2TMU0NUMG/lbo7JbHkGY0mVv6M5jFcOmioscPa8XUH91L
 X3/Upi0YTtmcpfjH0i0igNDVjv/cGmal7H23t6He3X1G49Wc+sT6t68yPZJmB/3fB7UJfJ
 6p4S575IIXCUl9NtE7JwLwY0/oCi04PtpAJwC8kam6pWF6gNi0eK/FB/e4paZ/zHoOQv7k
 CZh/fAWHvU1gvsexUQe3588egQzvAyDhRSJmvRg3GAHSaDK374skhHs3QBbsQw==
To: "Yi Zhang" <yi.zhang@redhat.com>, 
	"linux-block" <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Subject: Re: [bug report] WARNING: block/blk-mq-debugfs.c:620 at debugfs_create_files.isra.0+0x54/0x60, CPU#220: kworker/u1036:7/70421
User-Agent: Mozilla Thunderbird
Cc: "Shinichiro Kawasaki" <shinichiro.kawasaki@wdc.com>, 
	"Ming Lei" <ming.lei@redhat.com>, "Jens Axboe" <axboe@kernel.dk>, 
	<yukuai@fnnas.com>
Message-Id: <d6205ddd-3822-4358-aabf-9fff4d0070f0@fnnas.com>
Mime-Version: 1.0
Received: from [192.168.1.104] ([39.182.0.137]) by smtp.feishu.cn with ESMTPS; Tue, 03 Feb 2026 23:54:07 +0800
In-Reply-To: <CAHj4cs9gNKEYAPagD9JADfO5UH+OiCr4P7OO2wjpfOYeM-RV=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+269821a20+e879f7+lists.infradead.org+yukuai@fnnas.com>
From: "Yu Kuai" <yukuai@fnnas.com>
Date: Tue, 3 Feb 2026 23:54:05 +0800
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
References: <CAHj4cs9gNKEYAPagD9JADfO5UH+OiCr4P7OO2wjpfOYeM-RV=A@mail.gmail.com>
X-Original-From: Yu Kuai <yukuai@fnnas.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260203_075423_753260_E8F9D1C1 
X-CRM114-Status: GOOD (  10.70  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Reply-To: yukuai@fnnas.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

=E5=9C=A8 2026/2/3 20:28, Yi Zhang =E5=86=99=E9=81=93:
> Hello
>
> CKI reported the following failure today. Seems it was introduced from
> the recently blk-mq-debugfs update, please help check and let me know
> if you need any testing/info.
>
> Reproducer: blktests nvme/tcp nvme/005
> Commit message: Merge branch 'for-7.0/block' into for-next
>
> dmesg:
> [  951.319384] run blktests nvme/005 at 2026-02-02 17:59:35
> [  951.346116] loop0: detected capacity change from 0 to 2097152
> [  951.356428] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [  951.370823] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
> [  951.397438] nvmet: Created nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
> [  951.412081] nvme nvme0: creating 128 I/O queues.
> [  951.425914] nvme nvme0: mapped 128/0/0 default/read/poll queues.
> [  951.467027] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
> 127.0.0.1:4420, hostnqn:
> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
> [  951.784608] nvmet: Created nvm controller 2 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
> [  951.798920] nvme nvme0: creating 128 I/O queues.
> [  951.871600] nvme nvme0: mapped 128/0/0 default/read/poll queues.

Thanks for the test!

Looks like this is because blk_mq_update_nr_hw_queues() is called with queu=
e
already frozen from nvme-tcp, nvme-rdma, nvme-apple:

nvme_start_freeze()
blk_mq_update_nr_hw_queues()
nvme_unfreeze()

And recent commit add a WARN_ON() check for this. This looks fine, but I'm =
not
quite sure if it's ok to remove the freeze queue before blk_mq_update_nr_hw=
_queues().

> [  951.880680] ------------[ cut here ]------------
> [  951.885309] WARNING: block/blk-mq-debugfs.c:620 at
> debugfs_create_files.isra.0+0x54/0x60, CPU#220: kworker/u1036:7/70421
> [  951.896190] Modules linked in: nvmet_tcp nvmet nvme_tcp
> nvme_fabrics nvme nvme_core nvme_keyring nvme_auth rtrs_core rdma_cm
> iw_cm ib_cm hkdf nbd loop mlx5_ib ib_uverbs macsec sunrpc ib_core
> mlx5_fwctl fwctl rfkill vfat fat amd_atl intel_rapl_msr
> intel_rapl_common amd64_edac edac_mce_amd jc42 kvm_amd ee1004 joydev
> wmi_bmof mlx5_core kvm irqbypass mlxfw rapl psample tls ptdma ipmi_si
> ipmi_devintf pcspkr ipmi_msghandler acpi_cpufreq i2c_piix4 k10temp
> i2c_smbus fuse nfnetlink zram lz4hc_compress lz4_compress xfs ast
> i2c_algo_bit ghash_clmulni_intel wmi sp5100_tco i2c_dev [last
> unloaded: nvmet]
> [  951.948577] CPU: 220 UID: 0 PID: 70421 Comm: kworker/u1036:7 Not
> tainted 6.19.0-rc7 #1 PREEMPT(lazy)
> [  951.957814] Hardware name: AMD Corporation DAYTONA_X/DAYTONA_X,
> BIOS RYM100GA 01/13/2025
> [  951.965941] Workqueue: nvme-reset-wq nvme_reset_ctrl_work [nvme_tcp]
> [  951.972321] RIP: 0010:debugfs_create_files.isra.0+0x54/0x60
> [  951.977911] Code: 48 89 d9 4d 89 e0 48 89 ea 49 c7 c1 20 20 73 9a
> 48 83 c3 28 e8 bd 57 d9 ff 48 8b 3b 48 85 ff 75 db 5b 5d 41 5c e9 f7
> b6 51 ff <0f> 0b eb be 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90
> 90 90
> [  951.996673] RSP: 0018:ffffd137f8ee3c90 EFLAGS: 00010202
> [  952.001919] RAX: ffff8e3a49aa6c00 RBX: ffffffff9a731e00 RCX: ffffffff9=
a731e00
> [  952.009070] RDX: ffff8e3a831ab000 RSI: ffff8e3a49aa6c00 RDI: 000000000=
0000001
> [  952.016227] RBP: ffff8e3a49aa6c00 R08: 0000000000000064 R09: 000000000=
0000000
> [  952.023396] R10: ffff8e3a1c6a2540 R11: 0000000000000000 R12: ffff8e3a8=
31ab000
> [  952.030607] R13: ffff8e3a64c03620 R14: ffffd137f8ee3d38 R15: ffff8e3a8=
c43e400
> [  952.037815] FS:  0000000000000000(0000) GS:ffff8e5601f7b000(0000)
> knlGS:0000000000000000
> [  952.045946] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  952.051708] CR2: 00007f310853ef58 CR3: 00000037aac2e003 CR4: 000000000=
0f70ef0
> [  952.058856] PKRU: 55555554
> [  952.061579] Call Trace:
> [  952.064048]  <TASK>
> [  952.066159]  blk_mq_debugfs_register_hctx+0x97/0x150
> [  952.071136]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  952.075945]  blk_mq_debugfs_register_hctxs+0x4e/0x70
> [  952.080924]  __blk_mq_update_nr_hw_queues+0x218/0x390
> [  952.085991]  blk_mq_update_nr_hw_queues+0x39/0x50
> [  952.090714]  nvme_tcp_configure_io_queues.cold+0x1ac/0x35e [nvme_tcp]
> [  952.097175]  nvme_tcp_setup_ctrl+0xab/0x250 [nvme_tcp]
> [  952.102327]  ? nvme_change_ctrl_state+0x135/0x1b0 [nvme_core]
> [  952.108090]  nvme_reset_ctrl_work+0x9a/0xd0 [nvme_tcp]
> [  952.113246]  process_one_work+0x18d/0x340
> [  952.117266]  worker_thread+0x256/0x3a0
> [  952.121030]  ? __pfx_worker_thread+0x10/0x10
> [  952.125320]  kthread+0xfc/0x240
> [  952.128481]  ? __pfx_kthread+0x10/0x10
> [  952.132245]  ? __pfx_kthread+0x10/0x10
> [  952.136009]  ret_from_fork+0x126/0x190
> [  952.139773]  ? __pfx_kthread+0x10/0x10
> [  952.143539]  ret_from_fork_asm+0x1a/0x30
> [  952.147484]  </TASK>
> [  952.149687] ---[ end trace 0000000000000000 ]---
> [  952.167930] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
> [  952.195424] block nvme0n1: no available path - failing I/O
> [  952.200938] block nvme0n1: no available path - failing I/O
> [  952.206483] buffer_io_error: 439 callbacks suppressed
> [  952.206486] Buffer I/O error on dev nvme0n1, logical block 262142,
> async page read
>
>
>
--=20
Thansk,
Kuai

