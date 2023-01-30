Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E30A2C54EAA
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jan 2023 11:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2UAzjisEE3/MROtLR3pIeYCOeebayD+ep8nKK24m0Uk=; b=xPQYtNm2C0csE9NBKPFToK0ZKp
	bLibIQNd4jxilyrdnsakSOPiqwslGdtmfr2pMHMCB1fIR4FsA5h5uQHrUTNE537kz24jGyeZk5z/V
	YIUZaA1s+Cvdb5B4/KGQPXNXxDDx8n48YVj1DbGEukJTkpZ+izHrhLzk+KWwrmRlbp8bFDnB7nPFP
	TPdFhNRDXiy7SYhn75L/tAr3q+6q+Au42r3vosH8AujkKSCzapLTvj3wuUTBzViXBJQPbxiJk6sOw
	Fw6G7X9tpT5poCLmKiM7ZAHgucjwBsQVz9qkVXvDOMRR8VWgU53tRfxRVahcM+l8BhrMuXFCN+1oS
	ETQFHgHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMS1p-003FJC-7k; Mon, 30 Jan 2023 11:08:49 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMS18-003FIN-Jb
	for linux-nvme@lists.infradead.org; Mon, 30 Jan 2023 11:08:08 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 86A0C219E7;
	Mon, 30 Jan 2023 11:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1675076883; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=2UAzjisEE3/MROtLR3pIeYCOeebayD+ep8nKK24m0Uk=;
	b=g724gI9GE8yye5nqW4RngmRLogdAIXBL8ABbVeRUh2+E7opcvru+De1eQ3prlmAjOyo0dd
	TZsndtIhYYfMPjKXmf3PnVYRCurayREzLhh/Q4vkLxTS+YzSDgTH/Nan25JVykCSg1ZNWp
	rU+cTLSu4rFd0zFUBeULNaNG4OYqlCs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1675076883;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=2UAzjisEE3/MROtLR3pIeYCOeebayD+ep8nKK24m0Uk=;
	b=3r3nI59+IapqbYoMxEHS9xSQRP7yrCgynw8NaS3djB3AXUb4oIntuMLIGC3foNm0S1XyhX
	dXVarP8qIBaMUhAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7720613A06;
	Mon, 30 Jan 2023 11:08:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id w/95HBOl12NrGwAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 30 Jan 2023 11:08:03 +0000
Date: Mon, 30 Jan 2023 12:08:02 +0100
From: Daniel Wagner <dwagner@suse.de>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: nvme-6.3: blktests nvme/45 lockdep warning
Message-ID: <20230130110802.paafkiipmitwtnwr@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230130_030806_808532_08902F18 
X-CRM114-Status: UNSURE (   7.05  )
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

Hi,

while trying to get a baseline run with blktest against the current nvme-6.3
branch I got a lockdep warning. I haven't really looked into it yet. I
as that Shinichiro has fixed a bunch of those in v5.19. Thought this one
looks slightly different.

 ============================================
 WARNING: possible recursive locking detected
 6.2.0-rc4+ #1 Not tainted
 --------------------------------------------
 kworker/u16:7/69 is trying to acquire lock:
 ffff902d52e65548 ((wq_completion)nvme-wq){+.+.}-{0:0}, at: start_flush_work+0x2c5/0x380

 but task is already holding lock:
 ffff902d52e65548 ((wq_completion)nvme-wq){+.+.}-{0:0}, at: process_one_work+0x210/0x410

 other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock((wq_completion)nvme-wq);
   lock((wq_completion)nvme-wq);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

 3 locks held by kworker/u16:7/69:
  #0: ffff902d52e65548 ((wq_completion)nvme-wq){+.+.}-{0:0}, at: process_one_work+0x210/0x410
  #1: ffffa9d34028fe68 ((work_completion)(&ctrl->dhchap_auth_work)){+.+.}-{0:0}, at: process_one_work+0x236/0x410
  #2: ffffffffa0d768e0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x30

 stack backtrace:
 CPU: 0 PID: 69 Comm: kworker/u16:7 Not tainted 6.2.0-rc4+ #1 c9afca57e89c2aa3234427c2cd6cd4dd2984ae8c
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
 Workqueue: nvme-wq nvme_ctrl_auth_work [nvme_core]
 Call Trace:
  <TASK>
  dump_stack_lvl+0x5a/0x80
  validate_chain+0x1e02/0x2730
  ? lockdep_unlock+0x51/0xc0
  ? stack_trace_save+0x48/0x70
  ? lockdep_unlock+0x51/0xc0
  ? validate_chain+0x7c8/0x2730
  ? __lock_acquire+0x8f7/0xbc0
  __lock_acquire+0x8f7/0xbc0
  ? lock_is_held_type+0x8b/0x110
  lock_acquire+0xb0/0x180
  ? start_flush_work+0x2c5/0x380
  ? lock_release+0xf7/0x400
  start_flush_work+0x2e5/0x380
  ? start_flush_work+0x2c5/0x380
  __flush_work+0x79/0xc0
  ? start_flush_work+0x380/0x380
  nvme_ctrl_auth_work+0x7e/0x240 [nvme_core d5def95a27d83838db4779d3aac9ae3cccc50795]
  process_one_work+0x26a/0x410
  worker_thread+0x21d/0x490
  ? _raw_spin_unlock_irqrestore+0x32/0x50
  ? rcu_lock_release+0x20/0x20
  kthread+0xe1/0x100
  ? kthread_blkcg+0x30/0x30
  ret_from_fork+0x1f/0x30
  </TASK>

Thanks,
Daniel

