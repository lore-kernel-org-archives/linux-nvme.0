Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE2EC54E90
	for <linux-nvme@archiver.kernel.org>; Thu, 22 May 2025 13:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rtT6KLq9HxZlzAqUdQx6rMNDXcYQ56MDN/QxpYiv4xI=; b=aPrNWf9moxj451hzoh/AbaXLo0
	traJFy6LqoYvK12wQraY+f8BwKURTr5oWhg5YZ9drZrb+M0jJx6pp/FhORzeGlJDnn4mILgMn+8Me
	sK2dPGOFBG/tS6HIHh6v70mVWo9oRCSkHEVGgiKfrPCHDt0umT57va2GIftk35lIDjLHf2SQZISVn
	pU/aa/SS4EAZCWX/hinedPZ88wbS2JxCxv3AE/lltza0bdh9IsfOppat7cXXnzZGgNP12blNRVzhq
	m/fKYc/cXlfwC47CRIPwLT9qLmqO3nKaQs502JWjBQ8UDRWsMB5vD0khtpipGSW1iChpNUMxbJA+g
	nK0c1H3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uI6Nn-00000001B84-0ddN;
	Thu, 22 May 2025 13:54:51 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uI6Nk-00000001B7g-3L6t
	for linux-nvme@lists.infradead.org;
	Thu, 22 May 2025 13:54:50 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 199AC216E4;
	Thu, 22 May 2025 13:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747922087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rtT6KLq9HxZlzAqUdQx6rMNDXcYQ56MDN/QxpYiv4xI=;
	b=jAuN7PhxZEjd2qTBYfaMg82C3xFJ7V8qkZQE9Y6bATsLdgg2k1XvNgsGdWmKwJfHazu9LR
	QmRtqziuusbFJhaeDuxzpYJQojBTXD1WlFL07Caj6KZsiD5rUzqDEOCiCnuFYk2M21yp2D
	8FSq7uVq+04Nnn06b0luKi/74bEVXAc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747922087;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rtT6KLq9HxZlzAqUdQx6rMNDXcYQ56MDN/QxpYiv4xI=;
	b=5xO5nyWP2a22NgLOJJIQnRSpo8Qj+i7Vs/jy089FB0q3UtXj3r18wbvGMpyTnOzeOUFtcw
	UQtpc36K1FA3NnCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747922087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rtT6KLq9HxZlzAqUdQx6rMNDXcYQ56MDN/QxpYiv4xI=;
	b=jAuN7PhxZEjd2qTBYfaMg82C3xFJ7V8qkZQE9Y6bATsLdgg2k1XvNgsGdWmKwJfHazu9LR
	QmRtqziuusbFJhaeDuxzpYJQojBTXD1WlFL07Caj6KZsiD5rUzqDEOCiCnuFYk2M21yp2D
	8FSq7uVq+04Nnn06b0luKi/74bEVXAc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747922087;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rtT6KLq9HxZlzAqUdQx6rMNDXcYQ56MDN/QxpYiv4xI=;
	b=5xO5nyWP2a22NgLOJJIQnRSpo8Qj+i7Vs/jy089FB0q3UtXj3r18wbvGMpyTnOzeOUFtcw
	UQtpc36K1FA3NnCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED420137B8;
	Thu, 22 May 2025 13:54:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OTOhOKYsL2jQCwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 22 May 2025 13:54:46 +0000
Message-ID: <7aab2c6c-4cd8-4f23-b61b-153f6e9c2ce7@suse.de>
Date: Thu, 22 May 2025 15:54:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] nvme: add support for copy offload
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-4-kbusch@meta.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250521223107.709131-4-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.30 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250522_065448_981606_793CDC08 
X-CRM114-Status: GOOD (  17.10  )
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

On 5/22/25 00:31, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Register the nvme namespace copy capablities with the request_queue
> limits and implement support for the REQ_OP_COPY operation.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/host/core.c | 61 ++++++++++++++++++++++++++++++++++++++++
>   include/linux/nvme.h     | 42 ++++++++++++++++++++++++++-
>   2 files changed, 102 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f69a232a000ac..3134fe85b1abc 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -888,6 +888,52 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
>   	return BLK_STS_OK;
>   }
>   
> +static inline blk_status_t nvme_setup_copy(struct nvme_ns *ns,
> +		struct request *req, struct nvme_command *cmnd)
> +{
> +	struct nvme_copy_range *range;
> +	struct req_iterator iter;
> +	struct bio_vec bvec;
> +	u16 control = 0;
> +	int i = 0;
> +
> +	static const size_t alloc_size = sizeof(*range) * NVME_COPY_MAX_RANGES;
> +
> +	if (WARN_ON_ONCE(blk_rq_nr_phys_segments(req) >= NVME_COPY_MAX_RANGES))
> +		return BLK_STS_IOERR;
> +
> +	range = kzalloc(alloc_size, GFP_ATOMIC | __GFP_NOWARN);
> +	if (!range)
> +		return BLK_STS_RESOURCE;
> +
> +	if (req->cmd_flags & REQ_FUA)
> +	        control |= NVME_RW_FUA;
> +	if (req->cmd_flags & REQ_FAILFAST_DEV)
> +	        control |= NVME_RW_LR;

FAILFAST_DEV? Is that even set anywhere?

Otherwise looks ok.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

