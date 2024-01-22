Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 096BDC47DD9
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jan 2024 15:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7A8sXNSpT7zBDPsf1S2L3xZJwtKpRKQhSAiTojNV4Ks=; b=K7V0mLxyviLKH2jjdmKJ3JZFI7
	IfmuQPxNWN1v4nUhFe30bp3gWCkTv1ZjHPaJNPwDI454RyZhOfJEcdTDjGD0XxP8K5BI7wzizVFE1
	AjqdbNivDxJ1a5F/dN+CGnKL3KbmK75RsuAXVfpQLcJ5CnqKeRm89h1MeSSCoPJf6ReTWAbVIQRV5
	WnbkiakKjKZ89FSLuL4/K8MibV9gPMy/J1T+s2g7u/8GFl68j3IrTy0j+3D9EAO0y1USL7WlH9nOq
	6D2vQ8XuTfbNB2GJCV6knfMZsgg6VjPl2FU186tvJbMhRiMf0FGiOaydA6oQisXY2QKjuGAq0LqsC
	fQ9jmQuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRvzz-00CdpL-1g;
	Mon, 22 Jan 2024 15:14:07 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rRvzw-00CdkI-2N
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jan 2024 15:14:06 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5050E22213;
	Mon, 22 Jan 2024 15:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705936440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7A8sXNSpT7zBDPsf1S2L3xZJwtKpRKQhSAiTojNV4Ks=;
	b=PgwptaVAgbEknht2ZJ9LMpFe34G/8gY7bKOohaHD9Gr88gbmrFxZwKhkSHtsKEqFRq6Qej
	OLcHccegyeRDLeZSVfrv+ZQ6iO5M7mnhuba63pgMQsLsdTrn48fBx9nuBhzPLPWYB2sRIu
	xpEYoZLkmijXJ0f589qakbHgQevTLR0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705936440;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7A8sXNSpT7zBDPsf1S2L3xZJwtKpRKQhSAiTojNV4Ks=;
	b=Odo3M8BdiNKSpWnpmRm4eD1kHRlMwqM9Bnc6S379QfuPuEhAg93jPLaHB6J0ITpcHk6eat
	p6WdGb0tV7HerXAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705936440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7A8sXNSpT7zBDPsf1S2L3xZJwtKpRKQhSAiTojNV4Ks=;
	b=PgwptaVAgbEknht2ZJ9LMpFe34G/8gY7bKOohaHD9Gr88gbmrFxZwKhkSHtsKEqFRq6Qej
	OLcHccegyeRDLeZSVfrv+ZQ6iO5M7mnhuba63pgMQsLsdTrn48fBx9nuBhzPLPWYB2sRIu
	xpEYoZLkmijXJ0f589qakbHgQevTLR0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705936440;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7A8sXNSpT7zBDPsf1S2L3xZJwtKpRKQhSAiTojNV4Ks=;
	b=Odo3M8BdiNKSpWnpmRm4eD1kHRlMwqM9Bnc6S379QfuPuEhAg93jPLaHB6J0ITpcHk6eat
	p6WdGb0tV7HerXAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D3E8136A4;
	Mon, 22 Jan 2024 15:14:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +uuCDTiGrmUWZQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 22 Jan 2024 15:14:00 +0000
Date: Mon, 22 Jan 2024 16:13:59 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, oren@nvidia.com, israelr@nvidia.com, oevron@nvidia.com
Subject: Re: [PATCH 7/8] nvme-fabrics: add option to disallow T10-PI offload
Message-ID: <6gx7xdmm54po74oihiazqsdk4sln4h7754f5qx5lc7rxdhy4of@wip6kfi7yktr>
References: <20240122145659.5574-1-mgurtovoy@nvidia.com>
 <20240122145659.5574-8-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122145659.5574-8-mgurtovoy@nvidia.com>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PgwptaVA;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Odo3M8Bd
X-Spamd-Result: default: False [0.19 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5050E22213
X-Spamd-Bar: /
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240122_071404_935492_DBF491E5 
X-CRM114-Status: GOOD (  10.01  )
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

On Mon, Jan 22, 2024 at 04:56:58PM +0200, Max Gurtovoy wrote:
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -673,6 +673,9 @@ static const match_table_t opt_tokens = {
>  #endif
>  #ifdef CONFIG_NVME_TCP_TLS
>  	{ NVMF_OPT_TLS,			"tls"			},
> +#endif
> +#ifdef CONFIG_BLK_DEV_INTEGRITY
> +	{ NVMF_OPT_DISALLOW_PI,		"disallow_pi"		},

What about 'enable_pi' instead of the inverted boolean logic?

