Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA73AC61CE2
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2026 11:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WWSYgIW4ka0UQaanzdI2Lxq21oB+4Fm0CxVer+mx5T4=; b=Wlcz2BPLm1JaVExlktqsgVhWvy
	Wb78VLeBESyn4xZEnJUiAC1cRA6GTmNCJzvXZIFsZInA2isNWPmt0yrbrssH6GEXQcIsNDlJOpu8Z
	ZZjS5+jkqTLGQqOZbTn4I5a8eTCSlZgG5LJj+RBQ0HTlCgsaINtUPwoYW0zQfbld7rzGDtOfu5x+T
	Q3pVpFOWhANTcGo6YLy416VQO8NaniZkA3/w+/nEUtRE2JuDqm0iw+44q8IfyrqHu/3ZfvPqrl1+0
	9DGy706sTU8ELYkVbRCksT1oH3wpyVvOpXkVWv63qgyNNS2zfvTDkhieaHx/nc6SZOv061FWDgMGk
	AMxRo4RA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyStb-0000000GW06-47qf;
	Mon, 24 Aug 2026 11:31:19 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyStX-0000000GVwL-44f1
	for linux-nvme@lists.infradead.org;
	Mon, 24 Aug 2026 11:31:17 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CBCD61F44E;
	Mon, 24 Aug 2026 11:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787571067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WWSYgIW4ka0UQaanzdI2Lxq21oB+4Fm0CxVer+mx5T4=;
	b=Qb6s0wJiVWryzatppHVsRfv5GMJIH3QXc+yGtVY7Fkz1+COwQQqv6O4g2CR7wzNrTcuMdv
	L7l0vd1yrvV9Cv3Sd7lKALZYWf8lU6qtdwNxJrK03ZdcqsWVOmL2YMeOvNudKZgHgiSDn9
	CIA+JmWZqQ4aUTJ11nfoNXNTvahyvOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787571067;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WWSYgIW4ka0UQaanzdI2Lxq21oB+4Fm0CxVer+mx5T4=;
	b=9zmw4Z0KfoBXyqIWed7ZOSJfgwWRfjd/ravtdHwE0O3whX2GfXwMV9AFI2xqE1iGpdKJQ6
	6Q2xS2WjukZwrQBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787571063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WWSYgIW4ka0UQaanzdI2Lxq21oB+4Fm0CxVer+mx5T4=;
	b=B/+rzO4B9nH6yG/SuTmrppfFMbhp0aDu4ZnAvTmEZf51uecahb9lHb2V+/6tZcdKQocmeC
	42/CJZUVRkgjW+zNPpM+T1mcAH2rZWsnTOuU64dlJZiA5aVb3rpSIclW2l+PHhm4cpUPRS
	gAsIM2GkyFLJUTnDH7hxh6hviTnmmlU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787571063;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WWSYgIW4ka0UQaanzdI2Lxq21oB+4Fm0CxVer+mx5T4=;
	b=x9KxtqdrloMdiTdh2Nu57jt+vqbxxgnGDzdp3BpxxN+e9t8hSnaQVwEbmtz6HERHKKtxDF
	4quHNvn99N/rQuAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A19FF13331;
	Mon, 24 Aug 2026 11:31:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id omE2JncrjGqpYwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 24 Aug 2026 11:31:03 +0000
Message-ID: <0caab195-5dfa-4caf-aebd-f658cde1482f@suse.de>
Date: Mon, 24 Aug 2026 13:31:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] nvme-mpath: No need to protect req->bio with
 requeue_lock
To: sagi@grimberg.me, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Daniel Wagner <dwagner@suse.de>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20260823084903.193188-1-sagi@grimberg.me>
 <20260823084903.193188-2-sagi@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260823084903.193188-2-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.976];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,grimberg.me:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260824_043116_356873_722F7695 
X-CRM114-Status: GOOD (  13.94  )
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

On 8/23/26 10:48 AM, Sagi Grimberg wrote:
> requeue_lock protects the retry_list, no need to hold it while
> iterating request bios.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/multipath.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 9b9a657fa330..b5501217303c 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -164,9 +164,10 @@ void nvme_failover_req(struct request *req)
>   		queue_work(nvme_wq, &ns->ctrl->ana_work);
>   	}
>   
> -	spin_lock_irqsave(&ns->head->requeue_lock, flags);
>   	for (bio = req->bio; bio; bio = bio->bi_next)
>   		bio_set_dev(bio, ns->head->disk->part0);
> +
> +	spin_lock_irqsave(&ns->head->requeue_lock, flags);
>   	blk_steal_bios(&ns->head->requeue_list, req);
>   	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
>   
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

