Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38742606A31B
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 13:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fTGFULY9;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=g+7+oq+z;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=+ZZIGH9Q;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=kKIhYFFi;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Oyw+mZjm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ox+bhn7Jg/aSf/Rk5mAqhJWh6JHW/vMSzNfMKq10fvc=; b=fTGFULY9dQxi0T47RloB8FCvhR
	vwGKhAyx4j41ILzSPaWjL5OXnANd78vjOcCWxdkdWs+c8yQJXvHf0iNarWP2WEkPLz7NJmH8BmzsF
	Yw5YLfGo/pWd6oCKOUzDJdN9mq/xH5uDy6boPs0s8OwtL8fexuy346Hd466zKN+VE0a3LzGyWpL/v
	16sOpxkbPXiOaC4r1sMfp9zAI6dCuY/NBcoO6+wsaDZ8Q0XJL/SHQtGtAHyAEEdAbm1MMz4JV0Up9
	6CU4NqoVYHV08CMzcYwqByKw0Y6oQ+FHT+W/YBlS+fIY2ePwgPaJx/oyJP8OkdCp+1NfZBHH47rE7
	PHhBsG/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xObSZ-00000005WfX-2GHH;
	Wed, 04 Nov 2026 13:55:27 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xObSW-00000005WeJ-3jtt
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 13:55:26 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DDA7A21F40;
	Wed,  4 Nov 2026 13:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793800523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ox+bhn7Jg/aSf/Rk5mAqhJWh6JHW/vMSzNfMKq10fvc=;
	b=g+7+oq+z2fmofcWJbqOyxcehuL9T7r1jM8M+03fJGNye5ShtsUgga3c3Z6zLqv2kJuGlQL
	o/V82VFTlqb4e5uVjiw3EHWdam4osB9u8wTrnSh/lA3vbAgyIigDS4QAVyZaHCRAGfqN1I
	c/dnrimfplkP+G872brfLnkee3eyAQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793800523;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ox+bhn7Jg/aSf/Rk5mAqhJWh6JHW/vMSzNfMKq10fvc=;
	b=+ZZIGH9Q1o3YNMPPdJGRJt093msotP0PNM+cCvrYyThalSI586BRZY39koR/r2dI1/rLno
	+zyuO45bxcxTGkCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kKIhYFFi;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Oyw+mZjm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793800522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ox+bhn7Jg/aSf/Rk5mAqhJWh6JHW/vMSzNfMKq10fvc=;
	b=kKIhYFFigbToyokityTBtMiJyC25Hofd9/jNjMafdsy1ntuqbix0xrJ3OJlr0R3BJPNEMn
	Tcm//dVMHLl0xAxnd9SVKpqWwTpwhx6kaZzdW1nZ+FO/Ae054IzWvsaK+EoLZ1/WBEP7bq
	s7skMLOX8PHWAKmIFrRCOi5Y9+70IfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793800522;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ox+bhn7Jg/aSf/Rk5mAqhJWh6JHW/vMSzNfMKq10fvc=;
	b=Oyw+mZjmeD491sYVYvoTFsdkca4bI1cgpph6yuyZRSIRWiDGNNb+SC8ZtrkNXv6Lc2+jAm
	5gNTxAti8sVqXcCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 91586134A5;
	Wed,  4 Nov 2026 13:55:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bUJhGko562rOSgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 04 Nov 2026 13:55:22 +0000
Date: Wed, 4 Nov 2026 14:55:17 +0100
From: Daniel Wagner <dwagner@suse.de>
To: sashiko-reviews@lists.linux.dev
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] blk-mq: use a housekeeping CPU for passthrough
 requests on isolated hctxs
Message-ID: <245df9e0-bed4-4288-aa26-777d8495aaed@flourine.local>
References: <20261103-nvme-fabrics-isolcpu-v2-1-95ec70d58254@suse.de>
 <sashiko-outbox-195610@kernel.org>
 <623dff5b-f2ff-4ab5-a6c7-196f5b203919@flourine.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <623dff5b-f2ff-4ab5-a6c7-196f5b203919@flourine.local>
X-Spamd-Result: default: False [-13.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -13.51
X-Spam-Level: 
X-Rspamd-Queue-Id: DDA7A21F40
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_055525_085526_24AD21F6 
X-CRM114-Status: GOOD (  18.70  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026 at 11:22:40AM +0100, Daniel Wagner wrote:
> On Tue, Nov 03, 2026 at 03:22:29PM +0000, sashiko-bot@kernel.org wrote:
> > Should this check !blk_mq_hctx_has_online_cpu(data.hctx, nr_cpu_ids) (or
> > ensure blk_mq_map_swqueue() sets BLK_MQ_S_INACTIVE when an hctx has no
> > online CPUs mapped)?
> 
> Yes, this is correct. I'll extend the patch and add this to the commit message:
> 
>     When all mapped CPUs are offline at queue setup, BLK_MQ_S_INACTIVE is
>     not set, as only the CPU offline callback sets it. The
>     blk_mq_hctx_has_online_cpu test catches this case. It uses the queue
>     map, so it also finds online isolated CPUs.
> 
>     When the last mapped CPU goes offline, the CPU offline callback sets
>     BLK_MQ_S_INACTIVE while the CPU is still in cpu_online_mask, so
>     blk_mq_hctx_has_online_cpu still finds it. The BLK_MQ_S_INACTIVE test
>     catches this case.

I have to correct myself. Allocating on a hardware context with only
offline CPUs is intended, so the patch shouldn't add the check.

blk-mq maps all possible CPUs to the hardware contexts since
20e4d8139319 ("blk-mq: simplify queue mapping & schedule with each
possisble CPU"). While CPUs are offline, a hardware context can end up
with only offline CPUs. blk_mq_alloc_request_hctx() then fails the
Connect command with -EXDEV, and connecting a fabrics controller fails,
for example when booted with maxcpus=4 on an 8-CPU machine. The queue is
still needed once the CPUs come online.

I wrote a blktest for this (nvme/080). It fails on current upstream.
With the patch the connect works, and I/O from the CPUs goes through
that queue after they come online. Hardware contexts whose last CPU
went offline are inactive and still fail.

v3 keeps the v2 code and adds this case to the commit message, with a
second Fixes tag for 20e4d8139319.

