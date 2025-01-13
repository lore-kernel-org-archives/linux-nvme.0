Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE9B3E7719E
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jan 2025 07:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xnfZg9j1x8q2YZgngnPcpJ8AvSw0jeapwElcDEV5W84=; b=xEut8o03HbAEXoPJlP0K2sL/H5
	s2FB5pcpVShZTUIVj0TZ0Y3qsOX+5sq9wJ4uhEYEBaKmSLYDDgvEcuwDqFc7MODjEhbZQ3gpC4eya
	CD8r/TPx1rMYuaNraOT9gfFLkM8AHxEvTzKexoJFgUZcGfDNjdM5f6z9HyygEocjsRAcEq4d5vP8F
	puQ8/S0jOdabtZPxJIAmL8o3DuNDbo1C/XZWqj8g5kNq78i2q50jtnL5nOCD2+qoXzVkLTkMW8rA8
	2LB6psxIfCz5sqoWHVplO2KWOV3ZPIJEfnKt0AK1l/RHaddYVFhrPWw/e0ZsezefB0ftfoOXhP5st
	Q0tUz1JQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXEoT-00000004F1m-0j3m;
	Mon, 13 Jan 2025 07:24:41 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXEoQ-00000004F0f-3Vw3
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jan 2025 07:24:40 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 359AA1F381;
	Mon, 13 Jan 2025 07:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736753077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xnfZg9j1x8q2YZgngnPcpJ8AvSw0jeapwElcDEV5W84=;
	b=j+vgPO3mm5LlOOT0hPo2ZDSf39Z3I1ScmYH07C9zDmLvJTI8rFEvE53ngtebG0dsltsBwK
	GuP8jNZ5HXkjYqwBIexE6WW133+iDFw/oenXFD6SfRAfFUiGs2THw2d+cqjElkP/Lx6z4h
	ZEXkrnALVsuKxEGjiagwLK8kbqAHZfg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736753077;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xnfZg9j1x8q2YZgngnPcpJ8AvSw0jeapwElcDEV5W84=;
	b=AkTMaSqT0P7Dekm0vOtBeZTfcofRT2wWngoanFAa1vV6XN+4xm6ubfkxahfZL1mSBbCRSD
	4R/TFwTO7b3VCHBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=j+vgPO3m;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=AkTMaSqT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736753077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xnfZg9j1x8q2YZgngnPcpJ8AvSw0jeapwElcDEV5W84=;
	b=j+vgPO3mm5LlOOT0hPo2ZDSf39Z3I1ScmYH07C9zDmLvJTI8rFEvE53ngtebG0dsltsBwK
	GuP8jNZ5HXkjYqwBIexE6WW133+iDFw/oenXFD6SfRAfFUiGs2THw2d+cqjElkP/Lx6z4h
	ZEXkrnALVsuKxEGjiagwLK8kbqAHZfg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736753077;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xnfZg9j1x8q2YZgngnPcpJ8AvSw0jeapwElcDEV5W84=;
	b=AkTMaSqT0P7Dekm0vOtBeZTfcofRT2wWngoanFAa1vV6XN+4xm6ubfkxahfZL1mSBbCRSD
	4R/TFwTO7b3VCHBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B063513310;
	Mon, 13 Jan 2025 07:24:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WBkqJ7S/hGcpLgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 13 Jan 2025 07:24:36 +0000
Message-ID: <d3f26d2e-8533-4cf9-a422-16a46a3981d3@suse.de>
Date: Mon, 13 Jan 2025 08:24:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] block: add a store_limit operations for sysfs
 entries
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, nbd@other.debian.org,
 linux-scsi@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
References: <20250108092520.1325324-1-hch@lst.de>
 <20250108092520.1325324-5-hch@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250108092520.1325324-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 359AA1F381
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,lst.de:email,suse.de:dkim,suse.de:mid,suse.de:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,lst.de:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250112_232439_043855_5D426723 
X-CRM114-Status: GOOD (  13.50  )
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

On 1/8/25 10:25, Christoph Hellwig wrote:
> De-duplicate the code for updating queue limits by adding a store_limit
> method that allows having common code handle the actual queue limits
> update.
> 
> Note that this is a pure refactoring patch and does not address the
> existing freeze vs limits lock order problem in the refactored code,
> which will be addressed next.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   block/blk-sysfs.c | 128 ++++++++++++++++++++++------------------------
>   1 file changed, 61 insertions(+), 67 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

