Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D49BC5DF81
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2026 15:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ffBOKEKNK2zE/AdeOHswU7p/ciCVik4hb7hFosru5zE=; b=xhVRyhJeg9cTk4hmzKcYtXI2mj
	WQXAjYfQEn2x6hFKDMAeQTyCCqRxfj/hC7lxsoRNH8bblixt5sABi1+5sUP8lKJRvG9nmpm2TqEjL
	u4u83nU7BneNuYLmlqLjg8GTBfHXcIPOtqheaP+bOL298NuPoYC54neOKPmWmpFlvC6A31MlzJGFt
	CDRqd6vjOQYOs5y0jVZaD6IUAAO0KdR1iDsCw1CTB7gSj7IP5FBVs3UdArcU/PWmyNBQY6O26Sd/s
	AGlz9Gka3tH9VKryRdJdQ/2j79N06qTEY5Wvl0ruvXumat+llrdvqol9vSLfdNanLYvFLshznkGq/
	N8zWhb1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wx4s6-0000000Bpcs-2Cs2;
	Thu, 20 Aug 2026 15:40:02 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wx4s4-0000000Bpb2-2IHh
	for linux-nvme@lists.infradead.org;
	Thu, 20 Aug 2026 15:40:01 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EAF8785190;
	Thu, 20 Aug 2026 15:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787240393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ffBOKEKNK2zE/AdeOHswU7p/ciCVik4hb7hFosru5zE=;
	b=KgFicBmI5RD6wz14arlOexF15NQD7OM+oOZdIQgLMAoE4Jm9X1GzJ7sjDmL3QEBSEb4lpD
	vFSc8zkAq/KZKZ4ZXVaHjgWTjUpbDxSxnlSr0FY42nCw55Xg4lgiI4CGJhzQ5haCcVFTWG
	sYJOGm40syH/SfcsK32pGiRpnGP37Ck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787240393;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ffBOKEKNK2zE/AdeOHswU7p/ciCVik4hb7hFosru5zE=;
	b=sICa6p0IkiCs7fTwHixgwE9qOPTytUmbIVibGPWFaKIto4aoIVcoL9839jmbHTbBZhlls2
	c28sICnX64tQgoBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XemB9Hpb;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Gkafu4fR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787240389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ffBOKEKNK2zE/AdeOHswU7p/ciCVik4hb7hFosru5zE=;
	b=XemB9HpbANyJ7C7YPb9XmtotAxsqim7EJX7e7ox+MDELXWYuF+PlxOaUFAFh4RbAL6nCH6
	mINF/TBKQaOB+bdy8hHsaGr2Na4uk41zkQP7b39neZmAjBIEjlZwCJ+cPBj6giqAubPs9O
	LYqJllgRdGEWAv948f9BrZWGAn22cIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787240389;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ffBOKEKNK2zE/AdeOHswU7p/ciCVik4hb7hFosru5zE=;
	b=Gkafu4fRBUo4D3ilVX5AsoFE4+ROVT8B2LJeaUwGqXvS7bTrBiQos+AKBWzWbHG3RnBZm3
	MdiIDkvnkcVWknBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D713D27A8;
	Thu, 20 Aug 2026 15:39:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7ybfMsQfh2raNAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 20 Aug 2026 15:39:48 +0000
Date: Thu, 20 Aug 2026 17:39:48 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Saravanan D <saravanand@crusoe.ai>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de, 
	sagi@grimberg.me, axboe@kernel.dk, linux-kernel@vger.kernel.org, 
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH v2] nvme-tcp: pin io_cpu to submitter cpu
Message-ID: <ab3300bc-1ac6-4235-a0e6-350e001e91f6@flourine.local>
References: <20260820083634.71689-1-saravanand@crusoe.ai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820083634.71689-1-saravanand@crusoe.ai>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: EAF8785190
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260820_084000_734058_CACFC756 
X-CRM114-Status: GOOD (  13.04  )
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

On Thu, Aug 20, 2026 at 01:36:34AM -0700, Saravanan D wrote:
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index fd5abd04e080..26f8703744de 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -695,6 +695,7 @@ static const match_table_t opt_tokens = {
>  	{ NVMF_OPT_NR_WRITE_QUEUES,	"nr_write_queues=%d"	},
>  	{ NVMF_OPT_NR_POLL_QUEUES,	"nr_poll_queues=%d"	},
>  	{ NVMF_OPT_TOS,			"tos=%d"		},
> +	{ NVMF_OPT_IO_CPU_ADOPT,	"io_cpu_adopt"		},
>  #ifdef CONFIG_NVME_TCP_TLS
>  	{ NVMF_OPT_KEYRING,		"keyring=%d"		},
>  	{ NVMF_OPT_TLS_KEY,		"tls_key=%d"		},
> @@ -951,6 +952,9 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>  		case NVMF_OPT_DATA_DIGEST:
>  			opts->data_digest = true;
>  			break;
> +		case NVMF_OPT_IO_CPU_ADOPT:
> +			opts->io_cpu_adopt = true;
> +			break;

FWIW, from past experience if this gets accepted, it is most likely not
the last policy controlling knob which is needed. I see this somewhat
orthogonal to io_policy options. Thus my question should this user
interface be just a bool or should we have something more future proof
here?

