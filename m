Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C31EE49A0
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Aug 2023 11:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8gFL3mbNSpBV7cc8RYiA1jx8oMftJ+Hu3N/9joNazsU=; b=WRIrKOPL7sYXM+hjh0UmOvHIBt
	xhw+xRb3vtlEg+/URyHpSbgswTMiLaEhqPvXALQ0mUFBgezAZMZwGXiQZmSaPfpHKW/p1yDVKu+YZ
	CcAjY+3wemXgd9A70PN/ss7CWrEwZ/sxrjNvhXOxsLtEVxOwW0JczaFJj66bNFTXsSkCRp//YLDaa
	LkTpu0qvqFvYo61lh7Nygg2koY3WJ9duTl9YX65gP0ynG8wwR2U6lqz/qGjVhXEqzWhN6LKc22IOC
	knAkO7iCNog62MzNqV5ha1PJRSRLV9tu6A76CgWbD87z7kgY5xPMrOhpFB+NwS78JSqGiyob0jTF5
	P1Kj26tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qYmGB-000Sec-3B;
	Wed, 23 Aug 2023 11:42:51 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qYmG9-000Sdw-0W
	for linux-nvme@lists.infradead.org;
	Wed, 23 Aug 2023 11:42:50 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 24E5520798;
	Wed, 23 Aug 2023 11:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692790964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=8gFL3mbNSpBV7cc8RYiA1jx8oMftJ+Hu3N/9joNazsU=;
	b=jGpQ6asUbztfZj2UJPP1AmFaxCsx1as5ySl5K06EVfow4OrDBz7HNel+oSfx+RHEWkfusZ
	eA0Hh0CEnt3KvK6t+9JBp8MJ7UQMlRHsMungtUee8s2CX9v1TMugbu9XtcFXQAHw2dV96w
	Fj3Hc2umrpxM61eqoiHOrO9nswIsaXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692790964;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=8gFL3mbNSpBV7cc8RYiA1jx8oMftJ+Hu3N/9joNazsU=;
	b=rSRjsqxF/Gyq2vqeq2aSUCjial8I6Rd4Tq4c21mCGWJ7z5VHyA0Posc755+w5cguQJXxyk
	ENjd2vXp+tImt+Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 160F713458;
	Wed, 23 Aug 2023 11:42:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id BnInBbTw5WQnOgAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 23 Aug 2023 11:42:44 +0000
Date: Wed, 23 Aug 2023 13:43:00 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Michael Liang <mliang@purestorage.com>
Cc: Caleb Sander <csander@purestorage.com>, 
	James Smart <jsmart2021@gmail.com>, Keith Busch <kbusch@kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: nvme-fc: waiting in invalid context bug
Message-ID: <bmiwwkdm6nitkorgtrcu52zemtbxw7ho476iv3nyoeekjsx5ua@6xqzoocfhmle>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230823_044249_359513_EC05E1A0 
X-CRM114-Status: UNSURE (   6.84  )
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

While I am working on fc support in blktest I run into bug report below.

If I read this correct ee6fdc5055e9 ("nvme-fc: fix race between error
recovery and creating association") is introducing this bug.

 =============================
 [ BUG: Invalid wait context ]
 6.5.0-rc2+ #16 Tainted: G        W
 -----------------------------
 kworker/u8:5/105 is trying to lock:
 ffff8881127d4748 (&ctrl->namespaces_rwsem){++++}-{3:3}, at: nvme_kick_requeue_lists+0x31/0x1d0 [nvme_core]
 other info that might help us debug this:
 context-{4:4}
 3 locks held by kworker/u8:5/105:
  #0: ffff8881182cd148 ((wq_completion)nvme-wq){+.+.}-{0:0}, at: process_one_work+0x7a6/0x1180
  #1: ffff888110fa7d20 ((work_completion)(&(&ctrl->connect_work)->work)){+.+.}-{0:0}, at: process_one_work+0x7e9/0x1180
  #2: ffff8881127d4018 (&ctrl->lock#2){....}-{2:2}, at: nvme_fc_connect_ctrl_work+0x1715/0x1be0 [nvme_fc]
 stack backtrace:
 CPU: 1 PID: 105 Comm: kworker/u8:5 Tainted: G        W          6.5.0-rc2+ #16 4796ef1f1e7efc9e14ac22d8802d2575bb3a3aef
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 2/2/2022
 Workqueue: nvme-wq nvme_fc_connect_ctrl_work [nvme_fc]
 Call Trace:
  <TASK>
  dump_stack_lvl+0x5b/0x80
  __lock_acquire+0x17e8/0x7e70
  ? mark_lock+0x94/0x350
  ? verify_lock_unused+0x150/0x150
  ? verify_lock_unused+0x150/0x150
  ? lock_acquire+0x16d/0x410
  ? process_one_work+0x1180/0x1180
  ? lock_release+0x2aa/0xd30
  ? __cfi_lock_release+0x10/0x10
  ? start_flush_work+0x553/0x610
  lock_acquire+0x16d/0x410
  ? nvme_kick_requeue_lists+0x31/0x1d0 [nvme_core af1437cccf764f8f599077b8e0f169b94f7f9966]
  ? __cfi_lock_acquire+0x10/0x10
  ? __wake_up+0x120/0x200
  ? lock_release+0x2aa/0xd30
  ? nvme_kick_requeue_lists+0x31/0x1d0 [nvme_core af1437cccf764f8f599077b8e0f169b94f7f9966]
  down_read+0xa7/0xa10
  ? nvme_kick_requeue_lists+0x31/0x1d0 [nvme_core af1437cccf764f8f599077b8e0f169b94f7f9966]
  ? try_to_grab_pending+0x86/0x480
  ? __cfi_down_read+0x10/0x10
  ? __cancel_work_timer+0x3a1/0x480
  ? _raw_spin_unlock_irqrestore+0x24/0x50
  ? cancel_work_sync+0x20/0x20
  ? __cfi_lock_release+0x10/0x10
  nvme_kick_requeue_lists+0x31/0x1d0 [nvme_core af1437cccf764f8f599077b8e0f169b94f7f9966]
  nvme_change_ctrl_state+0x208/0x2e0 [nvme_core af1437cccf764f8f599077b8e0f169b94f7f9966]
  nvme_fc_connect_ctrl_work+0x17a4/0x1be0 [nvme_fc 40247846cbe6ec64af4ae5bef38fd58d34ff3bbd]
  process_one_work+0x89c/0x1180
  ? rescuer_thread+0x1150/0x1150
  ? do_raw_spin_trylock+0xc9/0x1f0
  ? lock_acquired+0x310/0x9b0
  ? worker_thread+0xd5e/0x1260
  worker_thread+0x91e/0x1260
  kthread+0x25d/0x2f0
  ? __cfi_worker_thread+0x10/0x10
  ? __cfi_kthread+0x10/0x10
  ret_from_fork+0x41/0x70
  ? __cfi_kthread+0x10/0x10
  ret_from_fork_asm+0x1b/0x30
 RIP: 0000:0x0
 Code: Unable to access opcode bytes at 0xffffffffffffffd6.
 RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX: 0000000000000000
 RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
 RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
 R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
  </TASK>

