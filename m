Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0DF8CD4851
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2026 08:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gfLTO8Rhkjdn7LrUGFJNFr57aBpcEvPYYgebdbP6/iY=; b=rXfzOseRNJgS0QKD3lgnCpF8Xr
	j+EPGY0F4zyHnXGIloFWxuuewkmC2TaZevefeWAB9/COysyhCZaZZ0ZHL1OgKY+X5lsK0mq8692/A
	b6cP78WbaPsdkvHo+AZoRDGOgaItCKddbgdiq124E4LLyk/BG0ojiQcuZY1xY5V+r/NdTTNLYZNgo
	zrlHZ4QJPzSmcs2J+EQTvt60dtqfldb6O6sBnZMM3z3TfO/WqVEjZOWo31a3dP3kHPNXDW88hd0Eo
	2Von8W6VqSkB816G9DNUbWkKCycwqvuX9892WHjOUN5KTxa/etMwyHGePGglUUnv+dsixC4s0QW8X
	MrdNekfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPGC7-00000000l1E-0UGf;
	Tue, 19 May 2026 08:52:55 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPGC3-00000000kz2-3itX
	for linux-nvme@lists.infradead.org;
	Tue, 19 May 2026 08:52:53 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 030245D9CE;
	Tue, 19 May 2026 08:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779180770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gfLTO8Rhkjdn7LrUGFJNFr57aBpcEvPYYgebdbP6/iY=;
	b=NSTkip/GqH0QfeqQZzW/otu2HgXCjJ9pVBVPY6YuzXr2MJgze/rjdTARvYDC3UPsIBRDU4
	p/9DzhDCPpkuUPSKLN32doBRX9PQwPQVP9wpi0CF5FjRdfrBQ1y22cwqaji5qH52TZcNfh
	bZdAYcxI8w8gPEEJUQ0PyUQyzuZTG2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779180770;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gfLTO8Rhkjdn7LrUGFJNFr57aBpcEvPYYgebdbP6/iY=;
	b=GXDezm3wBezw3HYb58sjUQoavRiij5sf0WuJ/2W6irVLhNuxika5QV7whXSsigp7XkhuEO
	kXPZxZBoPwwuwnDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779180770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gfLTO8Rhkjdn7LrUGFJNFr57aBpcEvPYYgebdbP6/iY=;
	b=NSTkip/GqH0QfeqQZzW/otu2HgXCjJ9pVBVPY6YuzXr2MJgze/rjdTARvYDC3UPsIBRDU4
	p/9DzhDCPpkuUPSKLN32doBRX9PQwPQVP9wpi0CF5FjRdfrBQ1y22cwqaji5qH52TZcNfh
	bZdAYcxI8w8gPEEJUQ0PyUQyzuZTG2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779180770;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gfLTO8Rhkjdn7LrUGFJNFr57aBpcEvPYYgebdbP6/iY=;
	b=GXDezm3wBezw3HYb58sjUQoavRiij5sf0WuJ/2W6irVLhNuxika5QV7whXSsigp7XkhuEO
	kXPZxZBoPwwuwnDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE7F9593A8;
	Tue, 19 May 2026 08:52:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EZKqMeEkDGo0JgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 19 May 2026 08:52:49 +0000
Message-ID: <9776f677-df3d-4258-90af-ea464f8cfca8@suse.de>
Date: Tue, 19 May 2026 10:52:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 7/7] nvme-core: warn on allocating admin tag set with
 existing queue
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: mheyne@amazon.de, emilne@redhat.com, jmeneghi@redhat.com,
 linux-nvme@lists.infradead.org, dwagner@suse.de, mlombard@arkamax.eu,
 mkhalfella@purestorage.com, chaitanyak@nvidia.com, hare@kernel.org,
 hch@lst.de
References: <20260514083255.41109-1-mlombard@redhat.com>
 <20260514083255.41109-8-mlombard@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260514083255.41109-8-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid,lst.de:email,grimberg.me:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260519_015252_079563_DCF8FDD0 
X-CRM114-Status: GOOD (  20.53  )
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

On 5/14/26 10:32, Maurizio Lombardi wrote:
> Currently, nvme_alloc_admin_tag_set() silently drops and releases
> the existing admin_q if it called on a controller that already
> had one (e.g., during a controller reset).
> 
> However, transport drivers should not be reallocating the admin tag
> set and queue during a reset. Dropping the old queue and allocating
> a new one destroys user-configured timeouts and may race against
> nvme_admin_timeout_store()
> 
> Since all transport drivers are now expected to preserve the admin queue
> across resets, calling nvme_alloc_admin_tag_set() when ctrl->admin_q
> is already populated is a bug.
> 
> Remove the silent cleanup and replace it with a WARN_ON_ONCE() to
> explicitly catch any transport drivers that violate this lifecycle rule
> 
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>   drivers/nvme/host/core.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index e6bb1f5e9657..f23a957c6e8f 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4893,12 +4893,7 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
>   	if (ret)
>   		return ret;
>   
> -	/*
> -	 * If a previous admin queue exists (e.g., from before a reset),
> -	 * put it now before allocating a new one to avoid orphaning it.
> -	 */
> -	if (ctrl->admin_q)
> -		blk_put_queue(ctrl->admin_q);
> +	WARN_ON_ONCE(ctrl->admin_q);
>   
>   	ctrl->admin_q = blk_mq_alloc_queue(set, NULL, NULL);
>   	if (IS_ERR(ctrl->admin_q)) {

Why don't you return an error here?
The WARN_ON() now introduces a memory leak (at best); I'd rather
not do that here as we can easily recover here.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

