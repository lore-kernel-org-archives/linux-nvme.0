Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05379C74A5B
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Mar 2023 10:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IFyIYRlC15Vrh9IklArjhMxa/P4NEVq5n9LuDztMq9E=; b=qzsUGslJtM8V8aKk74ZGQXLE9z
	4CaqvvkrGN+M0OEoFx/cDotxO8E6s+GKmXfeIoVj+a3HbOeMtqJCzM1E+Zbspf+y2E/8x0dPXmCfW
	0Jt8ribW+FvivYQq+xRj/dpiw7l0FtVTfZa8BAoX74ZhaHOxUXmWG1QoSX4cLVDVtbfyQ36yL+ahj
	WlS73S4CxpadetsU+bZtzXMBHRNfMOeN6gxddht/LuSNL4tyCdM78kWK4PCB4mq0L5s7CqHN2wfkj
	rvEPjl+qizd7ZpO2MIPBJ6l1qYD2KSYRNLyw+T+bbLTTip9jCT3ASVP8MX+ZlH6IsMAmE9iEElp5b
	YpX0/WVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peZPc-00C4fX-2J;
	Tue, 21 Mar 2023 10:40:17 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peZPZ-00C4en-19
	for linux-nvme@lists.infradead.org;
	Tue, 21 Mar 2023 10:40:14 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5000E21A8F;
	Tue, 21 Mar 2023 10:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1679395210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IFyIYRlC15Vrh9IklArjhMxa/P4NEVq5n9LuDztMq9E=;
	b=auIeb6U0smXjOO3x2Q1zWSuHR0Fg8EuU+xSMjKfYQg7V2tXXbUgdRxqr2kzByNVu074aOd
	dHFRQUtKuxQPJxUAUm9wTprHBArYHalw9USQ/wZA83wvL+RktRrCY/ZRkF0AUblzo2Fuuf
	ZaMVsXxCNP9isYlfIwKQT2NhwDO1SWo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1679395210;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IFyIYRlC15Vrh9IklArjhMxa/P4NEVq5n9LuDztMq9E=;
	b=04pmjVPhrWTukTkTVMvzU9hxj3UgGOX9/EOCZaMiQXNSBG63GvKCqH+UunZ8wyLxabLD0J
	GeyIfW21V2Rd83Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4157213440;
	Tue, 21 Mar 2023 10:40:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Po7vD4qJGWSfNQAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 21 Mar 2023 10:40:10 +0000
Date: Tue, 21 Mar 2023 11:40:09 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>,
	"Belanger, Martin" <Martin.Belanger@dell.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme-tcp: kernel NULL pointer dereference, address:
 0000000000000034
Message-ID: <20230321104009.nltadi6zs6iz66h4@carbon>
References: <6232d774-bc94-fae8-bab9-7151fde4f719@grimberg.me>
 <ZBNPs3ukEpbm/NSn@kbusch-mbp.dhcp.thefacebook.com>
 <bd0c1ec4-edd2-4225-c4d7-b091bde26494@grimberg.me>
 <20230321082308.n6ed7ieu5jdb2gj4@carbon>
 <20230321084917.s5xqklrttauxilnx@carbon>
 <a3d023ca-ca00-8207-2f89-fad23eddd58a@grimberg.me>
 <20230321090913.gwuvyuw76ha62hgb@carbon>
 <4c4b93b7-891d-cd5f-e4f2-50c242c799ce@grimberg.me>
 <20230321092556.7m3etb25jnd4sfj6@carbon>
 <316be6c1-0d90-0ea8-f9cf-1ec0086877a3@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <316be6c1-0d90-0ea8-f9cf-1ec0086877a3@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_034013_544413_0E144E1A 
X-CRM114-Status: GOOD (  10.82  )
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

On Tue, Mar 21, 2023 at 11:37:05AM +0200, Sagi Grimberg wrote:
> admin_tagset.nr_maps = 1 (only the default map, no read, no poll)

Indeed, that would be to easy.

I've just triggered a crash where we are passing in a non-null bio. Some
more annotation. This time I am printing from blk_rq_is_poll() and
we see that that is also the case where we have a valid bio but
want to use the poll context:


[   53.663613] rq ffff888107190000 mq_hctx ffff888106244000 type 0 bio ffff88810da4ec00
[   53.665190] nvme nvme1: q ffff888119c40000 rq ffff888124da0000 bio ffff88810da4e600
[   53.665230] rq ffff888124da0000 mq_hctx ffff888106241800 type 0 bio ffff88810da4e600
[   53.666293] nvme nvme1: q ffff888119c40000 rq ffff888106c40000 bio ffff88810da4e100
[   53.669844] rq ffff888106c40000 mq_hctx ffff888106247800 type 2 bio ffff88810da4e100
[   53.670682] general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN NOPTI
[   53.670689] KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
[   53.670694] CPU: 6 PID: 6410 Comm: nvme Tainted: G        W          6.3.0-rc1+ #10 5490073fe695e8e1be1b11c57a398a463ed2e52d
[   53.670701] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
[   53.670705] RIP: 0010:blk_poll+0x31/0x350
[   53.677417] Code: 57 41 56 41 55 41 54 53 48 83 ec 18 41 89 cd 49 89 f6 48 89 fd 48 b9 00 00 00 00 00 fc ff df 48 8d 5a 34 48 89 d8 48 c1 e8 03 <8a> 04 08 84 c0 0f 85 ea 02 00 00 44 8b 23 45 31 ff 41 83 fc ff 0f
[   53.677422] RSP: 0018:ffff88810642f710 EFLAGS: 00010207
[   53.677429] RAX: 0000000000000006 RBX: 0000000000000034 RCX: dffffc0000000000
[   53.677433] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888119c40000
[   53.677436] RBP: ffff888119c40000 R08: dffffc0000000000 R09: ffffed103e33e0f2
[   53.677440] R10: ffffed103e33e0f2 R11: 1ffff1103e33e0f1 R12: 1ffff11020d88002
[   53.677443] R13: 0000000000000000 R14: 0000000000000000 R15: ffff88810642f7c0
[   53.677447] FS:  00007fd70718a780(0000) GS:ffff8881f1800000(0000) knlGS:0000000000000000
[   53.677451] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   53.677455] CR2: 00007f25a1c176f8 CR3: 00000001048b6003 CR4: 0000000000170ee0
[   53.677462] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   53.677465] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   53.677469] Call Trace:
[   53.677472]  <TASK>
[   53.677476]  ? blk_rq_poll+0x40/0x60
[   53.691431]  blk_execute_rq+0x418/0x640
[   53.691445]  ? blk_rq_is_poll+0x170/0x170
[   53.691454]  ? complete+0x2c/0x1e0
[   53.691469]  __nvme_submit_sync_cmd+0x3eb/0x750 [nvme_core 3b8f33cff2a9cda33de352373714dd43a47c79c4]
[   53.694428]  nvmf_connect_io_queue+0x30d/0x5e0 [nvme_fabrics a56b21f9a9f011a785bd0916f38d0deca6de166d]
[   53.694449]  ? nvmf_log_connect_error+0x470/0x470 [nvme_fabrics a56b21f9a9f011a785bd0916f38d0deca6de166d]
[   53.694466]  ? blk_set_default_limits+0x195/0x4d0
[   53.694474]  ? blk_alloc_queue+0x3a4/0x460
[   53.694483]  nvme_tcp_start_queue+0x30/0x360 [nvme_tcp 8413e4e242b091568613e66c1cbb42a8845a3aa7]

