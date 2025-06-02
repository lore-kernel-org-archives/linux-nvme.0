Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06E5C54FB3
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Jun 2025 06:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tUYNoeQV/6VkGezRCFWGxhm0vyaEEw5eB25mLYONoEQ=; b=J7hZBEuiKTzUfGIBYpidgNsuoU
	ErhJgtRZ91/c8h3H9U1j6AU8haPaeOBjE6wmEttwYRMo4Ch44ZadaSSU8hgMFWVYkaxXDA8WEwsIe
	TCykt/ygQOF3s3iVZyCXpVfBSdeOZ+KwLrisEYKRy01t0D5FBZl36NDZyBhGEtwviy1yhwfSkH73R
	YMMSvUORuFNKazhgxiTZCvI9ZY+TiIDxurTtbYOTcDCg8GIiKmAavx9oG/tRDu3xNx9WtrQVDfbxj
	63n7UYAzhOBcWjmlDVnh5ewFIGBxew2Yb/q+xZLATIdrrkn4I68G6n7G3+vLEnFVx5XxFsgnk3mR6
	Xc4JM75w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uLyqp-00000006qyR-21B6;
	Mon, 02 Jun 2025 06:40:51 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uLypg-00000006qsr-02Wb
	for linux-nvme@lists.infradead.org;
	Mon, 02 Jun 2025 06:39:41 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 954531F45B;
	Mon,  2 Jun 2025 06:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1748846378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tUYNoeQV/6VkGezRCFWGxhm0vyaEEw5eB25mLYONoEQ=;
	b=DLz2uTamX/b9IYN7ESHGFcbgdsq1EMAdHbuxbqU93YZC9b1EcP+AlI9sm/lWedakpHUBaR
	70j96/PWn4h0Yh+EqjmGwPANBnEwHXnOZsS++F6QIOmIwTQ3sfjm0xf19pQwLNPcSFR+27
	P8RhTTMBOLnEF7d4sgqEi8UHsvEe4jM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1748846378;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tUYNoeQV/6VkGezRCFWGxhm0vyaEEw5eB25mLYONoEQ=;
	b=7Amcod51FWIrb6BFugml6uwjIhbcYZi8YZNJGOgngEIE+f63iBTLGQ32v1AufqQDT57JdF
	vdWqHHe4HSP50qAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DLz2uTam;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7Amcod51
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1748846378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tUYNoeQV/6VkGezRCFWGxhm0vyaEEw5eB25mLYONoEQ=;
	b=DLz2uTamX/b9IYN7ESHGFcbgdsq1EMAdHbuxbqU93YZC9b1EcP+AlI9sm/lWedakpHUBaR
	70j96/PWn4h0Yh+EqjmGwPANBnEwHXnOZsS++F6QIOmIwTQ3sfjm0xf19pQwLNPcSFR+27
	P8RhTTMBOLnEF7d4sgqEi8UHsvEe4jM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1748846378;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tUYNoeQV/6VkGezRCFWGxhm0vyaEEw5eB25mLYONoEQ=;
	b=7Amcod51FWIrb6BFugml6uwjIhbcYZi8YZNJGOgngEIE+f63iBTLGQ32v1AufqQDT57JdF
	vdWqHHe4HSP50qAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58E1E136C7;
	Mon,  2 Jun 2025 06:39:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id p0utEypHPWj6SgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 02 Jun 2025 06:39:38 +0000
Message-ID: <28041877-817c-4f13-94d3-75fb45625dc4@suse.de>
Date: Mon, 2 Jun 2025 08:39:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme-tcp: remove tag set when second admin queue
 config fails
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@infradead.org>
References: <20250602043522.55787-1-shinichiro.kawasaki@wdc.com>
 <20250602043522.55787-3-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250602043522.55787-3-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 954531F45B
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:9498, ipnet:::/1, country:IN];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250601_233940_199304_1D687ADA 
X-CRM114-Status: GOOD (  24.08  )
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

On 6/2/25 06:35, Shin'ichiro Kawasaki wrote:
> Commit 104d0e2f6222 ("nvme-fabrics: reset admin connection for secure
> concatenation") modified nvme_tcp_setup_ctrl() to call
> nvme_tcp_configure_admin_queue() twice. The first call prepares for
> DH-CHAP negotitation, and the second call is required for secure
> concatenation. However, this change triggered BUG KASAN slab-use-after-
> free in blk_mq_queue_tag_busy_iter(). This BUG can be recreated by
> repeating the blktests test case nvme/063 a few times [1].
> 
> When the BUG happens, nvme_tcp_create_ctrl() fails in the call chain
> below:
> 
> nvme_tcp_create_ctrl()
>   nvme_tcp_alloc_ctrl() new=true             ... Alloc nvme_tcp_ctrl and admin_tag_set
>   nvme_tcp_setup_ctrl() new=true
>    nvme_tcp_configure_admin_queue() new=true ... Succeed
>     nvme_alloc_admin_tag_set()               ... Alloc the tag set for admin_tag_set
>    nvme_stop_keep_alive()
>    nvme_tcp_teardown_admin_queue() remove=false
>    nvme_tcp_configure_admin_queue() new=false
>     nvme_tcp_alloc_admin_queue()             ... Fail, but do not call nvme_remove_admin_tag_set()
>   nvme_uninit_ctrl()
>   nvme_put_ctrl()                            ... Free up the nvme_tcp_ctrl and admin_tag_set
> 
> The first call of nvme_tcp_configure_admin_queue() succeeds with
> new=true argument. The second call fails with new=false argument. This
> second call does not call nvme_remove_admin_tag_set() on failure, due to
> the new=false argument. Then the admin tag set is not removed. However,
> nvme_tcp_create_ctrl() assumes that nvme_tcp_setup_ctrl() would call
> nvme_remove_admin_tag_set(). Then it frees up struct nvme_tcp_ctrl which
> has admin_tag_set field. Later on, the timeout handler accesses the
> admin_tag_set field and causes the BUG KASAN slab-use-after-free.
> 
> To not leave the admin tag set, call nvme_remove_admin_tag_set() when
> the second nvme_tcp_configure_admin_queue() call fails. Do not return
> from nvme_tcp_setup_ctrl() on failure. Instead, jump to "destroy_admin"
> go-to label to call nvme_tcp_teardown_admin_queue() which calls
> nvme_remove_admin_tag_set().
> 
> Fixes: 104d0e2f6222 ("nvme-fabrics: reset admin connection for secure concatenation")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/linux-nvme/6mhxskdlbo6fk6hotsffvwriauurqky33dfb3s44mqtr5dsxmf@gywwmnyh3twm/ [1]
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>   drivers/nvme/host/tcp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 14b9d67329b3..85acb4c9c977 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2350,7 +2350,7 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
>   		nvme_tcp_teardown_admin_queue(ctrl, false);
>   		ret = nvme_tcp_configure_admin_queue(ctrl, false);
>   		if (ret)
> -			return ret;
> +			goto destroy_admin;
>   	}
>   
>   	if (ctrl->icdoff) {

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

