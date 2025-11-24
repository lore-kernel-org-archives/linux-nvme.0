Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EAECCFD317
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Nov 2025 10:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PZmYLnLQ3asVZ/8bqI2cB6EFCqS8NnTnnIvEwnDLMB8=; b=iIrheRLeKWKKk3nZbhvL4bovre
	H86D9YBAooqniV8swCkQDBN0oXMcJLmIDfHMjdn5Q/2gOkWJH5sH0CZYjcpXXgTjIzxssGa5KrsGD
	FhOleyAHVE0sV7ta3dcEId98xzsWuzqWcU7uZxtrF7xf3s+FqeBYoDOhd+0T3LJtMWXXouoCYRhp/
	uGSgS2LqQGeZbpj3JVuiYwHpDuettCCQkDP1FoJ8LyajX7ap1oi6QcaFkppDUS0riN+q/oAv1Q2sy
	bdyA/5uF9SNStMpVlJ6QhyoOh+fKhkHZvUOe7elaPwkdxmuo8PArDV2q523xENsSzoJQyFDYZq0hj
	bfQrxELg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNTlz-0000000BQIR-484V;
	Mon, 24 Nov 2025 10:26:20 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNTlw-0000000BQHK-40xm
	for linux-nvme@lists.infradead.org;
	Mon, 24 Nov 2025 10:26:18 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ABB1822083;
	Mon, 24 Nov 2025 10:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763979973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PZmYLnLQ3asVZ/8bqI2cB6EFCqS8NnTnnIvEwnDLMB8=;
	b=BTkpZ6HlKL1VBtVGwa6L1/LmSHwvAhbPjDPyRwoK4jEAvimLvGCslwOOAj2fNBkcbgR64W
	AYqeh15vUWLYvYfxWt8p+T6gQWVC/7Ma6d96z38rk/8DgvsrWpP3uL5TKVfts2u/Y0g4Tn
	Lhr61JBBdXcE+5BoWcFEZWTL27LoWA4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763979973;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PZmYLnLQ3asVZ/8bqI2cB6EFCqS8NnTnnIvEwnDLMB8=;
	b=NKORgtOmUvpqUlyEvq9XdgABAj0UJqXRVUybEDPzZiKONeTVMABna4fEKh6CJPbwEBjOlt
	VmXwln6GEADSxABg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BTkpZ6Hl;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NKORgtOm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763979973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PZmYLnLQ3asVZ/8bqI2cB6EFCqS8NnTnnIvEwnDLMB8=;
	b=BTkpZ6HlKL1VBtVGwa6L1/LmSHwvAhbPjDPyRwoK4jEAvimLvGCslwOOAj2fNBkcbgR64W
	AYqeh15vUWLYvYfxWt8p+T6gQWVC/7Ma6d96z38rk/8DgvsrWpP3uL5TKVfts2u/Y0g4Tn
	Lhr61JBBdXcE+5BoWcFEZWTL27LoWA4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763979973;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PZmYLnLQ3asVZ/8bqI2cB6EFCqS8NnTnnIvEwnDLMB8=;
	b=NKORgtOmUvpqUlyEvq9XdgABAj0UJqXRVUybEDPzZiKONeTVMABna4fEKh6CJPbwEBjOlt
	VmXwln6GEADSxABg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 47CAD3EA61;
	Mon, 24 Nov 2025 10:26:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kMQjEMUyJGmlIwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 24 Nov 2025 10:26:13 +0000
Date: Mon, 24 Nov 2025 11:26:08 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Justin Tee <justintee8345@gmail.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, jsmart2021@gmail.com, justin.tee@broadcom.com, 
	Daniel Wagner <wagi@kernel.org>
Subject: Re: [PATCH 1/1] nvme-fabrics: add ENOKEY to no retry criteria for
 authentication failures
Message-ID: <de42309a-8103-457c-a150-402488b36ede@flourine.local>
References: <20251117184343.97605-1-justintee8345@gmail.com>
 <c2b9fb9c-440d-4e41-b4e8-7428fcf9c2ca@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2b9fb9c-440d-4e41-b4e8-7428fcf9c2ca@suse.de>
X-Rspamd-Queue-Id: ABB1822083
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lists.infradead.org,vger.kernel.org,broadcom.com,kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim]
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251124_022617_140245_280FDAFE 
X-CRM114-Status: GOOD (  15.11  )
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

Hi Justin,

Sorry for the late response. I was on vacation.

On Tue, Nov 18, 2025 at 08:01:10AM +0100, Hannes Reinecke wrote:
> On 11/17/25 19:43, Justin Tee wrote:
> > With authentication, in addition to EKEYREJECTED there is also no point in
> > retrying reconnects when status is ENOKEY.  Thus, add -ENOKEY as another
> > criteria to determine when to stop retries.
> > 
> > Cc: Daniel Wagner <wagi@kernel.org>
> > Cc: Hannes Reinecke <hare@suse.de>
> > Closes: https://lore.kernel.org/linux-nvme/20250829-nvme-fc-sync-v3-0-d69c87e63aee@kernel.org/
> > Signed-off-by: Justin Tee <justintee8345@gmail.com>

The patch itself is okay, nothing against it. But it wont close the bug
report. blktests nvme/041 just passes because we don't check the return
code from 'nvme connect' yet. I wanted to add this for a while, time to
do it.

Furthermore, the test now races with the kernel. If the worker thread in
the kernel is delayed, the 'nvme disconnect' might still see a controller:

     Test authenticated connection
    -disconnected 1 controller(s)
    +disconnected 0 controller(s)

Anyway, I am fine with this change just without the 'Closes' tag.

Tested-by: Daniel Wagner <wagi@kernel.org>
Reviewed-by: Daniel Wagner <wagi@kernel.org>

