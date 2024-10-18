Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF92D3C528
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Oct 2024 06:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jRbyrh0emkn3PCn7Sp6Y+fmB2AWP1Y6F5J5cmvTafCo=; b=4AvvrNd6qj3EHuVu3BTLbTG2Ws
	/y6cv7vys+FCn1Ctv5Nf6TOUZeDP3bbtmE9aXcy0uF2BVCMiq2nSNOKNNRue1YTXQpVNuhNT8UU6l
	86sRh+g2TA8ORznybdJef8Y5vnvNMIXL7c2PWW9sqrTLi7JTmJz3M+yuY3tO8glVzZfaOa7IejsGA
	Dmzp9co+srvv6xpXnV95rR/KSXh+bJXgCrmEmmGZWzzzNO/Xb8m8ELSMkjvV2bBCuWoENbp9j4c7M
	haoK1kPrYlIxPPLwUr23SyKSFscRFycfNM3Y3biPnbPHZauXQzZw5y25JlDv3G/7S/GhexcFLWH/9
	Gc3i4ijA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1g4r-0000000H57n-1e2C;
	Fri, 18 Oct 2024 06:03:09 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1g3b-0000000H4vz-34gC
	for linux-nvme@lists.infradead.org;
	Fri, 18 Oct 2024 06:01:58 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F21BB1FD95;
	Fri, 18 Oct 2024 06:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729231310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jRbyrh0emkn3PCn7Sp6Y+fmB2AWP1Y6F5J5cmvTafCo=;
	b=srfCAdV5596BQwIfyBC2Rit9YPCLT1PxObrkQw/2/GDfL00m+Vq21QbVn7qPRRQ9Jc5jz0
	DeNu+f4ilo6kzcxbUQEICzMnAlnzIlEQaTk+yM1E2eRAuZr9o9TP0zpKyTymXSbrvyP7DQ
	DY5kifjafBKWXG2XREzhv3jAFnPPgcw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729231310;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jRbyrh0emkn3PCn7Sp6Y+fmB2AWP1Y6F5J5cmvTafCo=;
	b=wgx3cIE0+5mwOO5Jl8A4NDjWb6rhFq5GK3D14td4Vj0UP4qnTEjJF+WHF3cv+pRSNH2Lle
	5nRYRNgwJguiRXAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729231310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jRbyrh0emkn3PCn7Sp6Y+fmB2AWP1Y6F5J5cmvTafCo=;
	b=srfCAdV5596BQwIfyBC2Rit9YPCLT1PxObrkQw/2/GDfL00m+Vq21QbVn7qPRRQ9Jc5jz0
	DeNu+f4ilo6kzcxbUQEICzMnAlnzIlEQaTk+yM1E2eRAuZr9o9TP0zpKyTymXSbrvyP7DQ
	DY5kifjafBKWXG2XREzhv3jAFnPPgcw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729231310;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jRbyrh0emkn3PCn7Sp6Y+fmB2AWP1Y6F5J5cmvTafCo=;
	b=wgx3cIE0+5mwOO5Jl8A4NDjWb6rhFq5GK3D14td4Vj0UP4qnTEjJF+WHF3cv+pRSNH2Lle
	5nRYRNgwJguiRXAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9667413680;
	Fri, 18 Oct 2024 06:01:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 718lI835EWeWHAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 18 Oct 2024 06:01:49 +0000
Message-ID: <92c52cda-3075-4aff-ab91-9cf6206522b8@suse.de>
Date: Fri, 18 Oct 2024 08:01:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv8 3/6] block: introduce max_write_hints queue limit
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
 io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, joshi.k@samsung.com,
 javier.gonz@samsung.com, Keith Busch <kbusch@kernel.org>
References: <20241017160937.2283225-1-kbusch@meta.com>
 <20241017160937.2283225-4-kbusch@meta.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20241017160937.2283225-4-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_230151_966667_83B6E136 
X-CRM114-Status: UNSURE (   8.42  )
X-CRM114-Notice: Please train this message.
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

On 10/17/24 18:09, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Drivers with hardware that support write hints need a way to export how
> many are available so applications can generically query this.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   Documentation/ABI/stable/sysfs-block |  7 +++++++
>   block/blk-settings.c                 |  3 +++
>   block/blk-sysfs.c                    |  3 +++
>   block/fops.c                         |  2 ++
>   include/linux/blkdev.h               | 12 ++++++++++++
>   5 files changed, 27 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

