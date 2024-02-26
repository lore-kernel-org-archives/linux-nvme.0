Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC43C48BF6
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Feb 2024 10:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+z8wMnzPavk/1Nl7S74dMvFZjo6rNjYWvDdN4ki5SsA=; b=AJ7wdBDa1brshNjG1XGzDCpPe2
	jCvrLLkgSUk1PwPo2YwqG3fpCZbDIH85L6ZlXh6qAgAyt64WFn/rNh5hP3zRSa+FS414NXoGwJDDK
	PRxvcVqFsLRId8OzsOW9+E+/owQmnwLKSpvzFOe0aMTX/3qBgypnhqyes1wGz5VbkLRR7FIbFveBO
	Fj4awui6BNYDKIaTpjdnOI+XZnuhCetoSpaqO50pcfot/ePmzDCfR5Bovv1bQdKxQ08UEsGGltmv0
	6Zag6z0MiIT4VxsOWfKq4/KsnEF0lRwYjb1zPKLzYMk9AZY1SP5oJIY1armXK2IeAeEJtciovlU3F
	SkjGRkHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reYLS-000000006c5-2IkQ;
	Mon, 26 Feb 2024 10:36:26 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reYLN-000000006Zq-21xS
	for linux-nvme@lists.infradead.org;
	Mon, 26 Feb 2024 10:36:25 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 24AFB1F8C4;
	Mon, 26 Feb 2024 10:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708943780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+z8wMnzPavk/1Nl7S74dMvFZjo6rNjYWvDdN4ki5SsA=;
	b=Trov8OoHhEuKfdVjESd/T/nvAs2QMbPHIsKY9Kj0BAM37r4aCnfQBcVOqzNl51JTl+aHJi
	MfhlEaytTKlKFYwml45+zeS2asplgfYd+qwJrq44gtwLpXZAlgGDpRyRp9o1mIDhZ9Xdrx
	cU/4/wCQhyVBtZzRhcTfcaX+dkojZrs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708943780;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+z8wMnzPavk/1Nl7S74dMvFZjo6rNjYWvDdN4ki5SsA=;
	b=JAAwrRXtGM6otVQAdphvYjYgNL6RzhDSDtVMgTIvoiPtbbDgUW0IaCt/8kaJ/1dwAbxOjg
	JGUUrSeWWlnajdCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708943780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+z8wMnzPavk/1Nl7S74dMvFZjo6rNjYWvDdN4ki5SsA=;
	b=Trov8OoHhEuKfdVjESd/T/nvAs2QMbPHIsKY9Kj0BAM37r4aCnfQBcVOqzNl51JTl+aHJi
	MfhlEaytTKlKFYwml45+zeS2asplgfYd+qwJrq44gtwLpXZAlgGDpRyRp9o1mIDhZ9Xdrx
	cU/4/wCQhyVBtZzRhcTfcaX+dkojZrs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708943780;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+z8wMnzPavk/1Nl7S74dMvFZjo6rNjYWvDdN4ki5SsA=;
	b=JAAwrRXtGM6otVQAdphvYjYgNL6RzhDSDtVMgTIvoiPtbbDgUW0IaCt/8kaJ/1dwAbxOjg
	JGUUrSeWWlnajdCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 118E51329E;
	Mon, 26 Feb 2024 10:36:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id qSDNAqRp3GVEJAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 26 Feb 2024 10:36:20 +0000
Date: Mon, 26 Feb 2024 11:36:19 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv2] nvme: authentication error are always non-retryable
Message-ID: <dx2l57pk5mncqduqu7l36grz4uwlu4k6wcb6gfwaiqxt66itja@rl7kb3ittvb4>
References: <20240226080628.21220-1-hare@kernel.org>
 <g3rnirwykldnoved2rojfkf3xrhkv4hai46m3b45kt4tzxpvyx@gqhr3v2l33ea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <g3rnirwykldnoved2rojfkf3xrhkv4hai46m3b45kt4tzxpvyx@gqhr3v2l33ea>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240226_023621_710780_B72CAEE6 
X-CRM114-Status: GOOD (  12.40  )
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

On Mon, Feb 26, 2024 at 11:24:35AM +0100, Daniel Wagner wrote:
> On Mon, Feb 26, 2024 at 09:06:28AM +0100, Hannes Reinecke wrote:
> > Any authentication errors which are generated internally are always
> > non-retryable, so set the DNR bit to ensure they are not retried.
> > 
> > Signed-off-by: Hannes Reinecke <hare@suse.de>
> 
> Tested-by: Daniel Wagner <dwagner@suse.de>

Well, I called it success too early.

Now other tests are starting to fail, e.g. nvme/044 for loop and fc is
looping now:

loop:
[   67.481520] nvmet: ctrl 1 fatal error occurred!
[   67.484296] nvme nvme0: qid 0: authentication failed, error -111
[   67.531033] [1538] nvmet: ctrl 1 stop keep-alive
[   67.532903] ==================================================================
[   67.534283] BUG: KASAN: double-free in nvme_loop_create_ctrl+0x87c/0xbe0 [nvme_loop]
[   67.535591] Free of addr ffff888101b1c000 by task nvme/1538

[   67.536454] CPU: 0 PID: 1538 Comm: nvme Tainted: G        W          6.8.0-rc3+ #39 3d0b6128d1ea3c6026a2c1de70ba6c7dc10623c3
[   67.538326] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 2/2/2022
[   67.538326] Call Trace:
[   67.538326]  <TASK>
[   67.538326]  dump_stack_lvl+0x5b/0x80
[   67.538326]  print_report+0x163/0x800
[   67.538326]  ? __virt_addr_valid+0x2f3/0x340
[   67.538326]  ? nvme_loop_create_ctrl+0x87c/0xbe0 [nvme_loop e19ff72683e84a1bbd49637ed7792592f1a14d32]
[   67.538326]  kasan_report_invalid_free+0xa7/0xe0
[   67.538326]  ? nvme_loop_create_ctrl+0x87c/0xbe0 [nvme_loop e19ff72683e84a1bbd49637ed7792592f1a14d32]
[   67.538326]  ? nvme_loop_create_ctrl+0x87c/0xbe0 [nvme_loop e19ff72683e84a1bbd49637ed7792592f1a14d32]
[   67.538326]  poison_slab_object+0x11c/0x180
[   67.538326]  __kasan_slab_free+0x33/0x80
[   67.538326]  ? nvme_loop_create_ctrl+0x87c/0xbe0 [nvme_loop e19ff72683e84a1bbd49637ed7792592f1a14d32]
[   67.538326]  kfree+0x119/0x310
[   67.538326]  nvme_loop_create_ctrl+0x87c/0xbe0 [nvme_loop e19ff72683e84a1bbd49637ed7792592f1a14d32]
[   67.554302]  nvmf_dev_write+0x22ff/0x2ae0 [nvme_fabrics cd628fee4abd75b95095eaf559203a0a73425269]
[   67.554302]  ? common_file_perm+0x14e/0x210
[   67.554302]  vfs_write+0x1cd/0xb60
[   67.554302]  ? kasan_quarantine_put+0xb4/0x1c0
[   67.554302]  ? kmem_cache_free+0x11e/0x2e0
[   67.554302]  ksys_write+0xd7/0x1a0
[   67.554302]  do_syscall_64+0xb1/0x180
[   67.554302]  ? syscall_exit_to_user_mode+0x24d/0x350
[   67.554302]  ? do_syscall_64+0xc0/0x180
[   67.554302]  ? kmem_cache_free+0x11e/0x2e0
[   67.554302]  ? syscall_exit_to_user_mode+0x24d/0x350
[   67.554302]  ? do_syscall_64+0xc0/0x180
[   67.554302]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[   67.554302] RIP: 0033:0x7fc80410afd4
[   67.554302] Code: 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 90 90 80 3d 55 ea 0e 00 00 74 13 b8 01 00 00
 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 48 83 ec 28 48 89 54 24 18 48
[   67.554302] RSP: 002b:00007ffd31d002c8 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[   67.554302] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc80410afd4
[   67.574292] RDX: 0000000000000149 RSI: 0000000001bee310 RDI: 0000000000000003
[   67.574292] RBP: 0000000000000000 R08: 0000000000000149 R09: 0000000001bee310
[   67.574292] R10: 00007fc80400b2a8 R11: 0000000000000202 R12: 0000000000000000
[   67.574292] R13: 0000000000000000 R14: 00007fc8047cd000 R15: 00000000005659f8
[   67.579476]  </TASK>


fc:
[ 1215.072441] nvme nvme6: qid 0: authentication failed, error -111
[ 1215.074837] nvme nvme6: NVME-FC{0}: create_assoc failed, assoc_id 157f1b1ef3270000 ret -111
[ 1215.077495] nvme_fc: __nvme_fc_send_ls_req:1123      get 3 rport 0000000063a0d5d0
[ 1215.079555] nvme nvme6: NVME-FC{0}: reset: Reconnect attempt failed (-111)
[ 1215.081383] nvme_fc: nvme_fc_reconnect_or_delete:3356 ctrl 000000005d843865 status -111

