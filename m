Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA25BC54E58
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Mar 2024 17:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gq5sq3eEUkwss41YZLzfNrhH7LCNCgxX+RYiFv0aHlk=; b=eV46v+kSR3o6+y9gaAtYvOtoHK
	t6qrBcGxysV5wrZOYLIFPKW+CiXVAuW/cJLXQJwXoyP1gBuayuNay2kAhuRLX2Y3SU3+V0fHLdKqu
	Wm4C0EAknyWl7kDLSA3LExxUZ8w1lrD7TyIuDVRDUkEj/jFzaunjIMf+L4iRVjoV0+XLSuDIcOpHV
	AZJRb6M1/4ArGROBuvB1PZFCp9KQ6pD5+XxQrgtI/NtlxcoAUq2GeSDimv0LGfXJdJqMSEaejowFj
	94TK1xv3RZV+QkWWaRXVGUJQTP/CrtZhUBBVgC9yKMM6CCnS2hKDKl/XzVhrHlUX+Rqa+9rSpQrUM
	4bfZWkjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjjZN-00000002Xf9-2t3B;
	Mon, 11 Mar 2024 17:36:13 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjjZH-00000002Xbm-1TGH
	for linux-nvme@lists.infradead.org;
	Mon, 11 Mar 2024 17:36:11 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 700CD5C9AE;
	Mon, 11 Mar 2024 17:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710178562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gq5sq3eEUkwss41YZLzfNrhH7LCNCgxX+RYiFv0aHlk=;
	b=zcqJzsQXNITaHDD9AY/TMxytUnfysQh1ws2hSNZaoSJvH/NtvCQKVzOalmtd2SfaUsUzTG
	sazpcagPWK7+zN6V5E2gE7ajnqcs9PcEzJ4tv5JPVy4HojPwLZZAhuvNE//o+kk7osHObl
	A8Jkaz7G01Il4hOiGKQ8tPbO2VA/oXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710178562;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gq5sq3eEUkwss41YZLzfNrhH7LCNCgxX+RYiFv0aHlk=;
	b=PbXgNj4pSWVTPTIoQSp1Dtn/qWdgGzCwxrvLcejoCnqrgOpEQOg5ntQT2KlDE7EWVnpc10
	57PDoq5iX6osjMDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710178562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gq5sq3eEUkwss41YZLzfNrhH7LCNCgxX+RYiFv0aHlk=;
	b=zcqJzsQXNITaHDD9AY/TMxytUnfysQh1ws2hSNZaoSJvH/NtvCQKVzOalmtd2SfaUsUzTG
	sazpcagPWK7+zN6V5E2gE7ajnqcs9PcEzJ4tv5JPVy4HojPwLZZAhuvNE//o+kk7osHObl
	A8Jkaz7G01Il4hOiGKQ8tPbO2VA/oXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710178562;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gq5sq3eEUkwss41YZLzfNrhH7LCNCgxX+RYiFv0aHlk=;
	b=PbXgNj4pSWVTPTIoQSp1Dtn/qWdgGzCwxrvLcejoCnqrgOpEQOg5ntQT2KlDE7EWVnpc10
	57PDoq5iX6osjMDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D0BC1395F;
	Mon, 11 Mar 2024 17:36:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fqSmFgJB72WELAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 11 Mar 2024 17:36:02 +0000
Date: Mon, 11 Mar 2024 18:36:01 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: James Smart <james.smart@broadcom.com>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] nvme-fabrics: introduce ref counting for
 nvmf_ctrl_options
Message-ID: <3xjjwq56sldxrr3dmcxmzhqjebctrowmfpr3istfqmnitlvpv4@mzjixl3jjnbi>
References: <20240221132404.6311-1-dwagner@suse.de>
 <20240221132404.6311-4-dwagner@suse.de>
 <342cf4cf-ad14-4fd0-bcab-fe5fcecf4c0a@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342cf4cf-ad14-4fd0-bcab-fe5fcecf4c0a@grimberg.me>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240311_103607_762134_F69723DC 
X-CRM114-Status: GOOD (  18.98  )
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

On Thu, Mar 07, 2024 at 12:27:43PM +0200, Sagi Grimberg wrote:
> Why do we need a refcount for an object that has the same exact lifetime
> as the ctrl itself? It just feels like unneeded complication.

My claim the UAF is also possible with the current code is not correct.
Or at least not easy to reproduce. I've re-tested a lot and I couldn't
reproduce it.

Though, the UAF is very simple to reproduce with the sync connect patch
applied (nvme-fc: wait for initial connect attempt to finish) together
with Hannes' patch (nvme: authentication error are always
non-retryable):

In this case, the initial connect fails and the resources are removed,
while we are waiting in

+       if (!opts->connect_async) {
+               enum nvme_ctrl_state state;
+
+               wait_for_completion(&ctrl->connect_completion);
+               state = nvme_ctrl_state(&ctrl->ctrl);
+               nvme_fc_ctrl_put(ctrl);
+
+               if (state != NVME_CTRL_LIVE) {
+                       /* Cleanup is handled by the connect state machine */
+                       return ERR_PTR(-EIO);
+               }
+       }

This opens up the race window. While we are waiting here for the
completion, the ctrl entry in sysfs is still reachable. Unfortunately,
we also fire an uevent which starts another instance of nvme-cli. And
the new instance of nvme-cli iterates over sysfs and reads the already
freed options object.

 run blktests nvme/041 at 2024-03-11 18:13:38
 nvmet: adding nsid 1 to subsystem blktests-subsystem-1
 nvme nvme0: NVME-FC{0}: create association : host wwpn 0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN "blktests-subsystem-1"
 (NULL device *): {0:0} Association created
 [8167] nvmet: ctrl 1 start keep-alive timer for 5 secs
 [8167] nvmet: check nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
 [8167] nvmet: nvmet_setup_dhgroup: ctrl 1 selecting dhgroup 0
 [8167] nvmet: nvmet_setup_auth: using hash none key fb 28 d3 79 af 04 ba 36 95 3b e5 89 6c bf 42 90 4a dd dd 1b d4 e8 ba ce b2 7c 16 d4 01 7d 4f 20
 nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349 with DH-HMAC-CHAP.
 nvme nvme0: qid 0: no key
 nvme nvme0: qid 0: authentication setup failed
 nvme nvme0: NVME-FC{0}: create_assoc failed, assoc_id f2139b60a42c0000 ret 16785
 nvme nvme0: NVME-FC{0}: reset: Reconnect attempt failed (16785)
 nvme nvme0: NVME-FC{0}: reconnect failure
 nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
 ==================================================================
 BUG: KASAN: slab-use-after-free in nvme_class_uevent+0xb9/0x1a0 [nvme_core]
 Read of size 8 at addr ffff888107229698 by task systemd-journal/578

 CPU: 1 PID: 578 Comm: systemd-journal Tainted: G        W          6.8.0-rc6+ #43 106200e85ab1e5c3399a68beb80cc63ca4823f3a
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 02/02/2022
 Call Trace:
  <TASK>
  dump_stack_lvl+0x5b/0x80
  print_report+0x163/0x800
  ? __virt_addr_valid+0x2f3/0x340
  ? nvme_class_uevent+0xb9/0x1a0 [nvme_core a5a8fc3d48e3ec2a76ff6521d70aebe532cfd700]
  kasan_report+0xd0/0x110
  ? nvme_class_uevent+0xb9/0x1a0 [nvme_core a5a8fc3d48e3ec2a76ff6521d70aebe532cfd700]
  nvme_class_uevent+0xb9/0x1a0 [nvme_core a5a8fc3d48e3ec2a76ff6521d70aebe532cfd700]
  dev_uevent+0x374/0x640
  uevent_show+0x187/0x2a0
  dev_attr_show+0x5f/0xb0
  sysfs_kf_seq_show+0x2a8/0x3f0
  ? __cfi_dev_attr_show+0x10/0x10
  seq_read_iter+0x3f1/0xc00
  vfs_read+0x6cf/0x960
  ksys_read+0xd7/0x1a0
  do_syscall_64+0xb1/0x180
  ? do_syscall_64+0xc0/0x180
  entry_SYSCALL_64_after_hwframe+0x6e/0x76
 RIP: 0033:0x7f4297b0a3dc
 Code: ec 28 48 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 97 18 f8 ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 34 44 89 c7 48 89 44 24 08 e8 fd

 RSP: 002b:00007ffd945ec430 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
 RAX: ffffffffffffffda RBX: 0000564732197e60 RCX: 00007f4297b0a3dc
 RDX: 0000000000001008 RSI: 0000564732197e60 RDI: 000000000000001a
 RBP: 000000000000001a R08: 0000000000000000 R09: 0000000000000001
 R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000001007
 R13: 0000000000001008 R14: ffffffffffffffff R15: 0000000000000002
  </TASK>

 Allocated by task 31249 on cpu 0 at 5508.645525s:
  kasan_save_track+0x2c/0x90
  __kasan_kmalloc+0x89/0xa0
  kmalloc_trace+0x1f3/0x3c0
  nvmf_dev_write+0x15c/0x2990 [nvme_fabrics]
  vfs_write+0x1cd/0xb60
  ksys_write+0xd7/0x1a0
  do_syscall_64+0xb1/0x180
  entry_SYSCALL_64_after_hwframe+0x6e/0x76

 Freed by task 31249 on cpu 2 at 5508.686805s:
  kasan_save_track+0x2c/0x90
  kasan_save_free_info+0x4a/0x60
  poison_slab_object+0x108/0x180
  __kasan_slab_free+0x33/0x80
  kfree+0x119/0x310
  nvmf_dev_write+0x23e0/0x2990 [nvme_fabrics]
  vfs_write+0x1cd/0xb60
  ksys_write+0xd7/0x1a0
  do_syscall_64+0xb1/0x180
  entry_SYSCALL_64_after_hwframe+0x6e/0x76

 The buggy address belongs to the object at ffff888107229680
  which belongs to the cache kmalloc-192 of size 192
 The buggy address is located 24 bytes inside of
  freed 192-byte region [ffff888107229680, ffff888107229740)

 The buggy address belongs to the physical page:
 page:0000000070cf556f refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x107228
 head:0000000070cf556f order:1 entire_mapcount:0 nr_pages_mapped:0 pincount:0
 flags: 0x17ffffc0000840(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
 page_type: 0xffffffff()
 raw: 0017ffffc0000840 ffff888100042c00 ffffea0004363500 dead000000000004
 raw: 0000000000000000 00000000001c001c 00000001ffffffff 0000000000000000
 page dumped because: kasan: bad access detected

 Memory state around the buggy address:
  ffff888107229580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc
  ffff888107229600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 >ffff888107229680: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                             ^
  ffff888107229700: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
  ffff888107229780: fc fc fc fc fa fb fb fb fb fb fb fb fb fb fb fb
 ==================================================================

