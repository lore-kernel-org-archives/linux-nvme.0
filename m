Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C347A606A33C
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 16:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ISdHP7CQ;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=atRW3Zru;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=zfOEnjXA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=FixADKgbVOGXVyy2SsnJfi/e9OWk3UakRXlJZ09PJsA=; b=ISdHP7CQgEC1HjLHvZYuT/ow/R
	h+ShFU8FNZZErc4lp8OUD4HB7Bkt625C3pMKqZL0EoIn8O/PrEFPggsqWa2b9ZzcVORngLvBqDb0i
	ffrdslrrFboStR0GeCmkcci2N5zRlTfRlz2bYHAtZGyKCNYJQUmSTUyHUJwewCKgx4JhDnbkK6sjw
	rV+jbGA6NIwRctDKzDKWx8j9ct5HqbqQ/zl0hjuI7tIOzh/db+Cnj4zkPzLj7YDChseq06d3Wkm9c
	gaEE36MN+JFMTxoixynzyoWrOw9TioddcBEvl7fVvOZa5nwymjycUng8tavN5J4Ji3EA6/xnD6wfh
	GQuTh/Tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOHWJ-00000003AAV-151S;
	Tue, 03 Nov 2026 16:37:59 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOHWD-00000003A45-17Bl
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 16:37:57 +0000
Date: Tue, 3 Nov 2026 17:37:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793723870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FixADKgbVOGXVyy2SsnJfi/e9OWk3UakRXlJZ09PJsA=;
	b=atRW3Zru1162usoPNm4G3VNsF00yxh5DxTWu1Pkse7bR5Qk38dmYmpYCSAHarrpa+hUThY
	2aEY4K6aa/+lwSSulZPs+6ag6I31p85pk7WWKgBZsmOV/YWahLdhBfFlC4M30/rR80Mws+
	xd5dhU94ff59mFBWeLpZzLRZ5r1oSpYBZOF7JS6woeHdd+Ll4TTz8JiftlzBr5CzgpYjK8
	j8ekaSAeO+cfjGPZ6GZMlVIb8OrzxLIz+KJBWsYK00imInfHgn/8jjfqRxRBeiAWlbPlFH
	gbbNXb4UEeV4mcgPYK3jLa/xGjiX5lRpngEs5/fT43do3V78Dlm7t8RQE4PfPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793723870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FixADKgbVOGXVyy2SsnJfi/e9OWk3UakRXlJZ09PJsA=;
	b=zfOEnjXAvUZr3mHiG4/sRWWMJ4KK5ZDQzf5cGwVOYUf2xc9Ue7J68eQMpKx8+LEOtfeWH+
	vWHH9kRTzEofa/Dw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Ming Lei <ming.lei@redhat.com>,
	Surabhi Gogte <sgogte@purestorage.com>,
	Hannes Reinecke <hare@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Maurizio Lombardi <mlombard@redhat.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] blk-mq: use a housekeeping CPU for passthrough
 requests on isolated hctxs
Message-ID: <20261103163748.qDpZjKj8@linutronix.de>
References: <20261103-nvme-fabrics-isolcpu-v2-1-95ec70d58254@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103-nvme-fabrics-isolcpu-v2-1-95ec70d58254@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_083753_484887_5BEF0FF1 
X-CRM114-Status: GOOD (  13.32  )
X-Spam-Score: -2.8 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-03 15:57:22 [+0100], Daniel Wagner wrote:
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -717,6 +717,25 @@ struct request *blk_mq_alloc_request(struct request_queue *q, blk_opf_t opf,
>  }
>  EXPORT_SYMBOL(blk_mq_alloc_request);
>  
> +/*
> + * Return an online CPU which is neither isolated from the scheduler domains
> + * nor from managed interrupts, or nr_cpu_ids if there is none.
> + */
> +static unsigned int blk_mq_housekeeping_cpu(void)
> +{
> +	unsigned int cpu;
> +
> +	rcu_read_lock();
> +	for_each_online_cpu(cpu) {
> +		if (!cpu_is_isolated(cpu) &&
> +		    housekeeping_test_cpu(cpu, HK_TYPE_MANAGED_IRQ))
> +			break;
> +	}

What about
	guard(rcu);
	for_each_cpu_and(cpu, cpu_online_mask, housekeeping_cpumask(HK_TYPE_MANAGED_IRQ)) {
		if (!cpu_is_isolated(cpu)
			break;
	}

this ends up with one less function call ;)

> +	rcu_read_unlock();
> +
> +	return cpu;
> +}
> +
>  struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
>  	blk_opf_t opf, blk_mq_req_flags_t flags, unsigned int hctx_idx)
>  {

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

