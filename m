Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9D6C4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Oct 2022 06:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pwT2KXY/wGwZ1s/hzF2oWy6XQ1PJfg+yHoJqPEx0UAE=; b=y3ogZOdqzU2FSZ/DODa7AjFgz/
	b2mF0CwV905t+8b62//rmWcqlOTiVsJ4y2pz5DHZzMn9fVezVjO12Me2smAweSNi5hwUYMtxRygwb
	C1hl2Nzpc2tVO1mVzJSF8Y1IixWBQec2v7901dKZhTJh2wMxqft/puuEXNGZMjsyMXtRYxj3Y2FDS
	C3tosiD5+pOLSV44JsK4o/4nEapVLIns0juqoH0RfHEyhOKYjVpQUQByKZQLLi7h6FI8wHCOFoPTo
	AJk7aEyRx5yBm8pN8X0WakRKSeO2f/znxY0/WC3QN0sfl3coa/549cyuLf+ADyHX5ZxWEx6YnxMoh
	VtR9Bgfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ollr0-005mOm-Ql; Fri, 21 Oct 2022 06:50:02 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ollqx-005mKw-8B
	for linux-nvme@lists.infradead.org; Fri, 21 Oct 2022 06:50:00 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 98B0F218B1;
	Fri, 21 Oct 2022 06:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666334995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pwT2KXY/wGwZ1s/hzF2oWy6XQ1PJfg+yHoJqPEx0UAE=;
	b=KUOlbHpaITkk99sZiNtKYnzl3bIR9zWYrI2gwtWNzAcqRRwpu+e90/RNQZG6Xtnxsgn+MP
	Y6IFuV9gYoX8pVM7rIIGxQf2gOTM8fdufNbJjQtVBLQTs1khdYwEQw9nA8pzx5NxetivOy
	jd4AuoMAVlwmTcubmfeOe5EpaONbRso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666334995;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pwT2KXY/wGwZ1s/hzF2oWy6XQ1PJfg+yHoJqPEx0UAE=;
	b=fDDPyhMlXGc8UUhPwIhYQKuSg7SSxtrbHSN+upF+ufu01EdVR6EayEBnLfPMuM6OaT0ZmV
	+tf4yGSkvHl9TNCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5E05E1331A;
	Fri, 21 Oct 2022 06:49:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id pZ8tFhNBUmM5HgAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 21 Oct 2022 06:49:55 +0000
Message-ID: <3298d857-f30b-6dbe-33b2-177a8ff104b0@suse.de>
Date: Fri, 21 Oct 2022 08:49:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/8] blk-mq: skip non-mq queues in blk_mq_quiesce_queue
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-3-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20221020105608.1581940-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_234959_454128_E934CA37 
X-CRM114-Status: GOOD (  17.38  )
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

On 10/20/22 12:56, Christoph Hellwig wrote:
> For submit_bio based queues there is no (S)RCU critical section during
> I/O submission and thus nothing to wait for in blk_mq_wait_quiesce_done,
> so skip doing any synchronization.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-mq.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 33292c01875d5..df967c8af9fee 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -280,7 +280,9 @@ EXPORT_SYMBOL_GPL(blk_mq_wait_quiesce_done);
>   void blk_mq_quiesce_queue(struct request_queue *q)
>   {
>   	blk_mq_quiesce_queue_nowait(q);
> -	blk_mq_wait_quiesce_done(q);
> +	/* nothing to wait for non-mq queues */
> +	if (queue_is_mq(q))
> +		blk_mq_wait_quiesce_done(q);
>   }
>   EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
>   
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


