Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D19C74A5B
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Mar 2023 08:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k+HsVhP5q/5AIGU5oYLTCyPpXA4MdFJvzsNcm1IPAkU=; b=Imk5dPfyYC6vyD6Av6JWE3tMjr
	f8tC0AtnFmqNS6I2h7IOgFp9lIH10iNp43JGpXhOxleybz3GROUDlf9yOVs/A7lJFoC516ZJkzcPK
	ZwxpC33Jk1+joIGBN60bZe9egak1cO/gmDE4IxkZWPWx/9pxzRw5+Fkh37ka0lXY70by+nWdarw8B
	2jGX1pDphNVLtaWjHPgiGheVQt6/WUIUvHaEXBMM8uQojUdmnM5VGahE65jWhlsH9zSBKeBHsB02f
	+UQwLK5ZfbAeX7n7apsKZDskEPk+aM+zIWo6nsfbB1LwAT7D2nrht81dRRsDZzFAemRJtlXW9qCmo
	e8EbffmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peXH0-00Bf7J-34;
	Tue, 21 Mar 2023 08:23:14 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peXGy-00Bf6H-14
	for linux-nvme@lists.infradead.org;
	Tue, 21 Mar 2023 08:23:13 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4E47A219E8;
	Tue, 21 Mar 2023 08:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1679386989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k+HsVhP5q/5AIGU5oYLTCyPpXA4MdFJvzsNcm1IPAkU=;
	b=YKHnSz3d0ZdJuPUN32yiYzuMhrCjwpABHvlS/diFk6mUM6fYKxOZ1R3sip8d+MZ+OcV3Ol
	Cr47L91+H9/3Pcwovnym3Wh4Gjsn6ecsxQ4gx5QL421E4Z3CaUCmGzVNIQdJLgT9p3X6Jc
	ItN41AmN72GhzNjER7wNgigJbqC9Ruk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1679386989;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k+HsVhP5q/5AIGU5oYLTCyPpXA4MdFJvzsNcm1IPAkU=;
	b=IWOD2aNNqwJ2mYyrfB9DsmhqZctdKJ3APOp3FjHQ6p1+TNevAqVS58CMJvIj4hHO12l+P8
	zLehjs78V51ylTDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3ED2E13440;
	Tue, 21 Mar 2023 08:23:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 65k8D21pGWS3RQAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 21 Mar 2023 08:23:09 +0000
Date: Tue, 21 Mar 2023 09:23:08 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>,
	"Belanger, Martin" <Martin.Belanger@dell.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme-tcp: kernel NULL pointer dereference, address:
 0000000000000034
Message-ID: <20230321082308.n6ed7ieu5jdb2gj4@carbon>
References: <SJ0PR19MB4544EF06560DC1D2B9D1BD09F2BF9@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <ZBJFnEY664s1Hm/E@kbusch-mbp.dhcp.thefacebook.com>
 <32741f55-f5aa-cd59-351c-df87ee2b2818@grimberg.me>
 <ZBMz1FUB3qJGKXeW@kbusch-mbp.dhcp.thefacebook.com>
 <6232d774-bc94-fae8-bab9-7151fde4f719@grimberg.me>
 <ZBNPs3ukEpbm/NSn@kbusch-mbp.dhcp.thefacebook.com>
 <bd0c1ec4-edd2-4225-c4d7-b091bde26494@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd0c1ec4-edd2-4225-c4d7-b091bde26494@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_012312_520691_101810FF 
X-CRM114-Status: UNSURE (   8.64  )
X-CRM114-Notice: Please train this message.
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Mar 19, 2023 at 03:10:40PM +0200, Sagi Grimberg wrote:
> Thoughts?

It still crashes in the same way with both patches from this
disucssion applied.

 nvme nvme1: mapped 8/0/2 default/read/poll queues.
 general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN NOPTI
 KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
 CPU: 5 PID: 16617 Comm: nvme Kdump: loaded Tainted: G        W          6.3.0-rc1+ #9 d97c09c311a99b3c39b25760658850e8f66ae67b
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
 RIP: 0010:blk_poll+0x31/0x350
 Code: 57 41 56 41 55 41 54 53 48 83 ec 18 41 89 cd 49 89 f6 48 89 fd 48 b9 00 00 00 00 00 fc ff df 48 8d 5a 34 48 89 d8 48 c1 e8 03 <8a> 04 08 84 c0 0f 85 ea 02 00 00 44 8b 23 45 31 ff 4

 RSP: 0018:ffff888114dbf670 EFLAGS: 00010207
 RAX: 0000000000000006 RBX: 0000000000000034 RCX: dffffc0000000000
 RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8881182f56e0
 RBP: ffff8881182f56e0 R08: dffffc0000000000 R09: fffffbfff3803f46
 R10: fffffbfff3803f46 R11: 1ffffffff3803f45 R12: ffff888132860018
 R13: 0000000000000000 R14: 0000000000000000 R15: ffff888114dbf700
 FS:  00007efde0867780(0000) GS:ffff8881f1400000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000556f0b5af810 CR3: 0000000105c9a005 CR4: 0000000000170ee0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  <TASK>
  ? __init_swait_queue_head+0xab/0x140
  blk_execute_rq+0x388/0x590
  ? blk_rq_is_poll+0xb0/0xb0
  ? complete+0x2c/0x1e0
  ? blk_rq_map_kern+0x5e0/0x790
  __nvme_submit_sync_cmd+0x31c/0x6a0 [nvme_core 355464cf83c3fcaf7cde9c80e64f0ce3bbc1f5e0]
  nvmf_connect_io_queue+0x30d/0x5e0 [nvme_fabrics a56b21f9a9f011a785bd0916f38d0deca6de166d]
  ? nvmf_log_connect_error+0x470/0x470 [nvme_fabrics a56b21f9a9f011a785bd0916f38d0deca6de166d]
  ? blk_set_default_limits+0x195/0x4d0
  ? blk_alloc_queue+0x3a4/0x460
  nvme_tcp_start_queue+0x30/0x360 [nvme_tcp 8413e4e242b091568613e66c1cbb42a8845a3aa7]
  nvme_tcp_setup_ctrl+0xc03/0x1690 [nvme_tcp 8413e4e242b091568613e66c1cbb42a8845a3aa7]
  ? nvme_reset_ctrl_work+0xf0/0xf0 [nvme_tcp 8413e4e242b091568613e66c1cbb42a8845a3aa7]
  ? _raw_spin_unlock_irqrestore+0x32/0x50
  ? nvme_change_ctrl_state+0xec/0x2d0 [nvme_core 355464cf83c3fcaf7cde9c80e64f0ce3bbc1f5e0]
  nvme_tcp_create_ctrl+0x71e/0xa80 [nvme_tcp 8413e4e242b091568613e66c1cbb42a8845a3aa7]
  nvmf_dev_write+0x498/0x790 [nvme_fabrics a56b21f9a9f011a785bd0916f38d0deca6de166d]
  vfs_write+0x1fc/0xaa0
  ? n_tty_read+0x1250/0x1250
  ? file_end_write+0x1a0/0x1a0
  ? vfs_write+0x57f/0xaa0
  ? file_end_write+0x1a0/0x1a0
  ? __fdget_pos+0x51/0x250
  ksys_write+0x128/0x210
  ? __ia32_sys_read+0x80/0x80
  ? syscall_enter_from_user_mode+0x2e/0x1c0
  do_syscall_64+0x60/0x90
  ? do_syscall_64+0x6e/0x90
  ? do_user_addr_fault+0x747/0x8e0
  entry_SYSCALL_64_after_hwframe+0x63/0xcd
 RIP: 0033:0x7efddf706af3

