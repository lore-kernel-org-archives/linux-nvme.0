Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B35AC05027
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Feb 2023 08:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IhXXTAf0gDjWtGTo7u11toecIXdlZrcdx2k6ygAwHjI=; b=GeMJxtTyENWIoFSLeXVh87mT9p
	XbSkpUHdRJ917CkvqR3jNITsZX1P43fA5pkGG7h8P63y/R4WEMJZArtaxaT9aNVPrU1fRJFL/liyH
	hQDAf+5JUA5xGDe5e2dq6aRAull9ehG6NUrDvOWqIDzDHqJs3A95sUtku6j6+DZDGaNHpnro/40la
	3k74K0TuhlK8J0U0BjFWkqmZ93D30APsLZO3FQU/RH3M5dGC+Gyd88zKUNZt49zAUlot7EQ3Al6na
	r0yaPcxulJ+nk7FxgvnW3vBDX6YnJ8ux4hFGj2seWelvZ7WpG+RR7qTpYo11A/8i8CXz2NdRIUGwS
	ojtgziBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pN8C3-00AkZw-5X; Wed, 01 Feb 2023 08:10:11 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pN8Bz-00AkZ5-47
	for linux-nvme@lists.infradead.org; Wed, 01 Feb 2023 08:10:08 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2C4DE33977;
	Wed,  1 Feb 2023 08:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1675239004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IhXXTAf0gDjWtGTo7u11toecIXdlZrcdx2k6ygAwHjI=;
	b=u57kahL+EDCRljvg5Ss386/KInrJoS9j9c6YjDI92S4eTkwtD/00aAOGMb7XgKl2IWiRu1
	8rY7HHiI1+Kuc+Mm066egKjM/YjsV4xSyEtiiTIUog1bGeYAoP9w88oOGMTGFMzbYvSHti
	c+V5k3x7K9NXo7ZnqI7ckY8NujFoGcU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1675239004;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IhXXTAf0gDjWtGTo7u11toecIXdlZrcdx2k6ygAwHjI=;
	b=Sdk/KUhoHkJ9BLKJpB0Un+VGjU+xSgbzMekHMFewoBXI3wQXVGa/NzIMUOsMNaBpq6Wd2p
	e8Gxw/qCOefRDbDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1E7AF13A10;
	Wed,  1 Feb 2023 08:10:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id RuBtB1we2mP9PgAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 01 Feb 2023 08:10:04 +0000
Date: Wed, 1 Feb 2023 09:10:03 +0100
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <jsmart2021@gmail.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: nvme-6.3: blktests nvme/003 null pointer for fc transport
Message-ID: <20230201081003.a6l22z3rnl6snkds@carbon.lan>
References: <20230130111532.ez63iip4qxrh42ga@carbon.lan>
 <40b14fe4-7d7f-b4ee-b058-d0d39b9fa6d4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40b14fe4-7d7f-b4ee-b058-d0d39b9fa6d4@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230201_001007_338275_AB8EFBEF 
X-CRM114-Status: GOOD (  17.31  )
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

On Tue, Jan 31, 2023 at 03:27:20PM -0800, James Smart wrote:
> On 1/30/2023 3:15 AM, Daniel Wagner wrote:
> > Hi,
> > 
> > Hannes added support to blktest to enable the FC transport for it. And as result
> > blktests is able to crash the kernel. Haven't startet to look into it yet.
> > 
> >   run blktests nvme/003 at 2023-01-30 12:08:28
> >   nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> >   BUG: kernel NULL pointer dereference, address: 0000000000000010
> >   #PF: supervisor read access in kernel mode
> >   #PF: error_code(0x0000) - not-present page
> >   PGD 0 P4D 0
> >   Oops: 0000 [#1] PREEMPT SMP NOPTI
> >   CPU: 3 PID: 14200 Comm: nvme Not tainted 6.2.0-rc4+ #1 c9afca57e89c2aa3234427c2cd6cd4dd2984ae8c
> >   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
> >   RIP: 0010:nvme_alloc_admin_tag_set+0x38/0x120 [nvme_core]
> 
> bingo...
> 
> The cleanup patch "nvme-fc: use the tagset alloc/free helpers" introduced
> it.
> 
> See the fix patch "nvme-fc: Fix initialization order" about 10 days ago that
> corrects it.

Good call! This is problem is gone. Now I am running into the next problem:


run blktests nvme/003 at 2023-02-01 09:01:58
nvmet: adding nsid 1 to subsystem blktests-subsystem-1
debugfs: Directory 'nvme0' with parent '/' already present!
nvme0: failed to create debugfs attr
nvme nvme0: NVME-FC{0}: create association : host wwpn 0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN "nqn.2014-08.org.nvmexpress.discovery"
(NULL device *): {0:0} Association created
nvmet: creating discovery controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:2cd2c43b-a90a-45c1-a8cd-86b33ab273b5.
nvme nvme0: NVME-FC{0}: controller connect complete
nvme nvme0: NVME-FC{0}: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
nvme nvme1: NVME-FC{1}: create association : host wwpn 0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN "blktests-subsystem-1"
(NULL device *): {0:1} Association created
nvmet: creating nvm controller 2 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:2cd2c43b-a90a-45c1-a8cd-86b33ab273b5.
nvme nvme1: NVME-FC{1}: controller connect complete
nvme nvme1: NVME-FC{1}: new ctrl: NQN "blktests-subsystem-1"
nvme nvme0: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
nvme nvme1: rescanning namespaces.
(NULL device *): {0:0} Association deleted
(NULL device *): {0:0} Association freed
(NULL device *): Disconnect LS failed: No Association
nvme nvme1: NVME-FC{1}: io failed due to lldd error 6
nvme nvme1: NVME-FC{1}: transport association event: transport detected io error
nvme nvme1: NVME-FC{1}: resetting controller
debugfs: Directory 'nvme0' with parent '/' already present!
nvme0: failed to create debugfs attr
nvme nvme0: NVME-FC{0}: create association : host wwpn 0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN "nqn.2014-08.org.nvmexpress.discovery"
(NULL device *): {0:0} Association created
nvmet: connect request for invalid subsystem nqn.2014-08.org.nvmexpress.discovery!
nvme nvme0: Connect Invalid Data Parameter, subsysnqn "nqn.2014-08.org.nvmexpress.discovery"
nvme nvme0: NVME-FC{0}: reset: Reconnect attempt failed (16770)
nvme nvme0: NVME-FC{0}: reconnect failure
nvme nvme0: NVME-FC{0}: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
nvme nvme0: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
nvme nvme1: NVME-FC{1}: create association : host wwpn 0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN "blktests-subsystem-1"
(NULL device *): {0:2} Association created
nvmet: connect request for invalid subsystem blktests-subsystem-1!
nvme nvme1: Connect Invalid Data Parameter, subsysnqn "blktests-subsystem-1"
nvme nvme1: NVME-FC{1}: reset: Reconnect attempt failed (16770)
nvme nvme1: NVME-FC{1}: reconnect failure
nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
(NULL device *): {0:1} Association deleted
(NULL device *): {0:1} Association freed
(NULL device *): Disconnect LS failed: No Association
(NULL device *): {0:0} Association deleted
(NULL device *): {0:0} Association freed
(NULL device *): Disconnect LS failed: No Association
(NULL device *): {0:2} Association deleted
(NULL device *): {0:2} Association freed
===========================================
WARNING: possible recursive locking detected
6.2.0-rc4+ #1 Not tainted
--------------------------------------------
kworker/3:13/21736 is trying to acquire lock:
ffff93fe60e251e8 ((work_completion)(&tport->ls_work)){+.+.}-{0:0}, at: __flush_work+0x38/0xc0

but task is already holding lock:
ffffa693c1a4fe68 ((work_completion)(&tport->ls_work)){+.+.}-{0:0}, at: process_one_work+0x236/0x410

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock((work_completion)(&tport->ls_work));
  lock((work_completion)(&tport->ls_work));

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by kworker/3:13/21736:
 #0: ffff93fe9882ff48 ((wq_completion)nvmet-wq){+.+.}-{0:0}, at: process_one_work+0x210/0x410
 #1: ffffa693c1a4fe68 ((work_completion)(&tport->ls_work)){+.+.}-{0:0}, at: process_one_work+0x236/0x410

stack backtrace:
CPU: 3 PID: 21736 Comm: kworker/3:13 Not tainted 6.2.0-rc4+ #1 c9afca57e89c2aa3234427c2cd6cd4dd2984ae8c
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
Workqueue: nvmet-wq fcloop_tport_lsrqst_work [nvme_fcloop]
Call Trace:
 <TASK>
 dump_stack_lvl+0x5a/0x80
 validate_chain+0x1e02/0x2730
 ? lockdep_unlock+0x51/0xc0
 ? lockdep_unlock+0x51/0xc0
 ? validate_chain+0x7c8/0x2730
 ? validate_chain+0x7c8/0x2730
 ? lock_release+0xf7/0x400
 ? __lock_acquire+0x8f7/0xbc0
 ? lock_is_held_type+0x8b/0x110
 __lock_acquire+0x8f7/0xbc0
 ? lock_is_held_type+0x8b/0x110
 lock_acquire+0xb0/0x180
 ? __flush_work+0x38/0xc0
 ? lock_is_held_type+0x8b/0x110
 __flush_work+0x57/0xc0
 ? __flush_work+0x38/0xc0
 ? lockdep_hardirqs_on_prepare+0x16e/0x220
 ? _raw_spin_unlock_irqrestore+0x32/0x50
 ? __free_pages_ok+0x289/0x4a0
 fcloop_targetport_delete+0x15/0xa0 [nvme_fcloop 2f0f07bf6746e7b4ec6dff8d226e919dac60e0f1]
 nvmet_fc_tgtport_put+0x132/0x190 [nvmet_fc cec46c808c67bf2a4fefe925da2828f0b3f2334a]
 nvmet_fc_disconnect_assoc_done+0x7c/0xa0 [nvmet_fc cec46c808c67bf2a4fefe925da2828f0b3f2334a]
 fcloop_tport_lsrqst_work+0x6c/0xa0 [nvme_fcloop 2f0f07bf6746e7b4ec6dff8d226e919dac60e0f1]
 process_one_work+0x26a/0x410
 worker_thread+0x21d/0x490
 ? rcu_lock_release+0x20/0x20
 kthread+0xe1/0x100
 ? kthread_blkcg+0x30/0x30
 ret_from_fork+0x1f/0x30
 </TASK>
nvme_fcloop: fcloop_exit: Failed deleting target port
nvme_fcloop: fcloop_exit: Failed deleting remote port
nvme_fcloop: fcloop_exit: Failed deleting target port
nvme_fcloop: fcloop_exit: Failed deleting remote port
nvme_fcloop: fcloop_exit: Failed deleting target port
nvme_fcloop: fcloop_exit: Failed deleting remote port


The last last to message never stop.

