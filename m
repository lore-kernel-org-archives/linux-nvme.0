Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5079C54FB3
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Jun 2025 15:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qQaaIEI8ItFOZIs3PZ5RfVnjzCiGTvFmH28GhwrolwU=; b=Au+rTtQeAZ5tLgYxgg2PlRJt7n
	+ZmRnF1h4UyGpigZFIooEh/b/LvMnIAebOLri61qnjahLA9yfMiCTNw4gAJSsmciK+LmzPJrjmZQg
	+4Fk1kQnSHa2pGyTynEtk6ApLlHrTGEW4kxYM+bqQOBm+WEq1cfXneFwjI5gfeeONGjK2JZZzi/pn
	/u9nF0dKaNn6kw1Gt83kNIvTdk3BUbUrbk+yJR3uZtGlmvGYY53+qvGcgK17B4F2zfN0KBB/OVJTW
	eJ5j7SQa0LJWUP5Gct2NX5R+HwE5r5gJpPst+Phk7q/pEjOjFiGgLHMwRhLYTCabKkD73d+gwClVu
	dzJy4L7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uM6ml-00000007iQo-06ZN;
	Mon, 02 Jun 2025 15:09:11 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uM6ke-00000007iCb-3NXo
	for linux-nvme@lists.infradead.org;
	Mon, 02 Jun 2025 15:07:02 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A17772125E;
	Mon,  2 Jun 2025 15:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1748876816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qQaaIEI8ItFOZIs3PZ5RfVnjzCiGTvFmH28GhwrolwU=;
	b=eNAfqxpIUAtTlg63ak3K5bCSNt++FxLTYYRVjeXJJu6tYYdIx7Ii9h+tjMkZ1fHYls0Avr
	ZDjzRApri3rGnpsnqobNOa/zGnnoZRKq4EKbQetYBE/BVyGBLjZJEOdH1yyMvUdGnahIR+
	M+X02d4ylFA50O3nJICOrQq8VVev++Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1748876816;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qQaaIEI8ItFOZIs3PZ5RfVnjzCiGTvFmH28GhwrolwU=;
	b=u+l7DnnJRA++hI23PG8E6DQeNbzlMeb4POuqHzvpgaGJuRC61iup8j54jhMfcFWzB77bf+
	bG0kP0eiYb0AKwAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eNAfqxpI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=u+l7DnnJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1748876816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qQaaIEI8ItFOZIs3PZ5RfVnjzCiGTvFmH28GhwrolwU=;
	b=eNAfqxpIUAtTlg63ak3K5bCSNt++FxLTYYRVjeXJJu6tYYdIx7Ii9h+tjMkZ1fHYls0Avr
	ZDjzRApri3rGnpsnqobNOa/zGnnoZRKq4EKbQetYBE/BVyGBLjZJEOdH1yyMvUdGnahIR+
	M+X02d4ylFA50O3nJICOrQq8VVev++Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1748876816;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qQaaIEI8ItFOZIs3PZ5RfVnjzCiGTvFmH28GhwrolwU=;
	b=u+l7DnnJRA++hI23PG8E6DQeNbzlMeb4POuqHzvpgaGJuRC61iup8j54jhMfcFWzB77bf+
	bG0kP0eiYb0AKwAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 786F413A63;
	Mon,  2 Jun 2025 15:06:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /83TGhC+PWiBYwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 02 Jun 2025 15:06:56 +0000
Date: Mon, 2 Jun 2025 17:06:55 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
	wagi@kernel.org, james.smart@broadcom.com
Subject: Re: [bug report] kmemleak osberved during blktests nvme/fc test
Message-ID: <c24e6e78-1f9e-4dfa-9a25-e977ecc42c48@flourine.local>
References: <CAHj4cs-xRh5ozy9=GLRBCgo5LhWfRRc6HQWkgHp7YmJ8rZqd8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHj4cs-xRh5ozy9=GLRBCgo5LhWfRRc6HQWkgHp7YmJ8rZqd8g@mail.gmail.com>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: A17772125E
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250602_080701_136595_DC7ABEC2 
X-CRM114-Status: GOOD (  19.20  )
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

On Sat, May 31, 2025 at 10:08:40AM +0800, Yi Zhang wrote:
> Hello
> I found the following kmemleak issue during blktests nvme/fc with the
> latest linux-block/for-next, please help check it and let me know if you
> need any test/info for it, thanks.

I've tried to reproduce the kmemleaks by enabling
CONFIG_DEBUG_KMEMLEAK and

echo scan > /sys/kernel/debug/kmemleak
echo check > /sys/kernel/debug/kmemleak

but I don't get any reports. I've used 3bc1b5c03cbd ("Merge branch
'io_uring-6.16' into for-next")

> unreferenced object 0xffff88816cd58400 (size 192):
>   comm "check", pid 24201, jiffies 4302692431
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 01 00 00 aa 00 11 00 10  ................
>     01 00 00 aa 00 11 00 20 b8 84 d5 6c 81 88 ff ff  ....... ...l....
>   backtrace (crc 9556a114):
>     __kmalloc_noprof+0x442/0x5e0
>     trace_raw_output_nvmet_req_init+0x3b3/0x450 [nvmet]

So that would be something in nvmet_req_init:

   trace_nvmet_req_init(req, req->cmd);

though I can't spot it.

>     fcloop_fcp_copy_data+0x6b5/0x770 [nvme_fcloop]
>     kernfs_fop_write_iter+0x357/0x530

this looks really strange. No idea how we can end up from
kernfd_fop_write_iter to fcloop_fcp_copy_data.

>     vfs_write+0x9bc/0xf60
>     ksys_write+0xf3/0x1d0
>     do_syscall_64+0x8c/0x3d0
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e


> unreferenced object 0xffff888224353800 (size 1024):
>   comm "check", pid 24479, jiffies 4302692654
>   hex dump (first 32 bytes):
>     00 00 00 00 60 00 00 00 01 00 00 ab 00 11 00 10  ....`...........
>     01 00 00 ab 00 11 00 20 00 84 d5 6c 81 88 ff ff  ....... ...l....
>   backtrace (crc 9aae07c2):
>     __kmalloc_noprof+0x442/0x5e0
>     nvmet_ns_device_uuid_store+0x4c/0xf0 [nvmet]
>     0xffffffffc33aca5a
>     kernfs_fop_write_iter+0x357/0x530
>     vfs_write+0x9bc/0xf60
>     ksys_write+0xf3/0x1d0
>     do_syscall_64+0x8c/0x3d0
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e


I don't see any allocation happening in nvmet_ns_device_uuid_store, the
code is just parsing the string into a fixed sized buffer.

> unreferenced object 0xffff88811e90ed00 (size 64):
>   comm "kworker/u67:8", pid 24542, jiffies 4303041902
>   hex dump (first 32 bytes):
>     00 38 35 24 82 88 ff ff 08 8d 53 40 81 88 ff ff  .85$......S@....
>     00 a8 8f e1 82 88 ff ff 00 19 5f b3 82 88 ff ff  .........._.....
>   backtrace (crc 45d8e045):
>     __kmalloc_cache_noprof+0x411/0x4e0
>     nvmet_ns_device_path_store+0x12/0x180 [nvmet]
>     fcloop_create_remote_port+0x5d3/0x640 [nvme_fcloop]
>     nvme_fc_handle_ls_rqst_work+0x77c/0xfe0 [nvme_fc]
>     nvme_fc_fcpio_done+0x715/0xfb0 [nvme_fc]
>     __nvme_fc_send_ls_req+0x750/0x1010 [nvme_fc]
>     process_one_work+0x8cd/0x1950
>     worker_thread+0x58d/0xcf0
>     kthread+0x3d8/0x7a0
>     ret_from_fork+0x406/0x510
>     ret_from_fork_asm+0x1a/0x30

nvmet_ns_device_patch_store is not called from
fcloop_create_remote_port.

> unreferenced object 0xffff88846c4ac700 (size 128):
>   comm "kworker/u65:101", pid 4587, jiffies 4296544937
>   hex dump (first 32 bytes):
>     01 00 00 00 00 00 00 20 00 00 00 01 00 00 00 08  ....... ........
>     05 00 00 00 00 00 00 00 00 00 00 02 00 00 00 08  ................
>   backtrace (crc d98f69c0):
>     __kmalloc_cache_noprof+0x411/0x4e0
>     nvme_fc_rcv_ls_req+0x370/0x1080 [nvme_fc]
>     fcloop_t2h_ls_req+0x173/0x3f0 [nvme_fcloop]
>     __nvmet_fc_send_ls_req.constprop.0+0x5dc/0xee0 [nvmet_fc]
>     nvmet_fc_target_assoc_free+0x675/0xab0 [nvmet_fc]
>     nvmet_fc_delete_assoc_work+0x300/0x400 [nvmet_fc]
>     process_one_work+0x8cd/0x1950
>     worker_thread+0x58d/0xcf0
>     kthread+0x3d8/0x7a0
>     ret_from_fork+0x406/0x510
>     ret_from_fork_asm+0x1a/0x30

This stack trace looks more reasonable and I thought I fixed this one
already. I'll double check.

> unreferenced object 0xffff888454806400 (size 192):
>   comm "check", pid 2795, jiffies 4295104867
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 01 00 00 aa 00 11 00 10  ................
>     01 00 00 aa 00 11 00 20 b8 64 80 54 84 88 ff ff  ....... .d.T....
>   backtrace (crc 47ccaf54):
>     __kmalloc_noprof+0x442/0x5e0
>     nvme_fc_register_localport+0x453/0x1440 [nvme_fc]
>     fcloop_create_local_port+0x265/0x520 [nvme_fcloop]
>     kernfs_fop_write_iter+0x357/0x530
>     vfs_write+0x9bc/0xf60
>     ksys_write+0xf3/0x1d0
>     do_syscall_64+0x8c/0x3d0
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e

This looks like a localport is leaked and it should be fairly simple to
reproduce it for me...

> unreferenced object 0xffff8883f6377800 (size 1024):
>   comm "check", pid 3079, jiffies 4295105085
>   hex dump (first 32 bytes):
>     00 00 00 00 60 00 00 00 01 00 00 ab 00 11 00 10  ....`...........
>     01 00 00 ab 00 11 00 20 00 64 80 54 84 88 ff ff  ....... .d.T....
>   backtrace (crc 8e00bf47):
>     __kmalloc_noprof+0x442/0x5e0
>     nvme_fc_register_remoteport+0x2ec/0x1360 [nvme_fc]
>     fcloop_create_remote_port+0x19a/0x640 [nvme_fcloop]
>     kernfs_fop_write_iter+0x357/0x530
>     vfs_write+0x9bc/0xf60
>     ksys_write+0xf3/0x1d0
>     do_syscall_64+0x8c/0x3d0
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e

Same here.

Can you share a bit more how to you test for mem leaks?

Thanks,
Daniel

