Return-Path: <SRS0=uUcO=BE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B60C433E1
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Jul 2020 17:35:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9ACB20656
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Jul 2020 17:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="2VLEhRcW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9ACB20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3/FDSlL1NkAL73+vfSIhONZi+9SArtezP3bFIn8h6FE=; b=2VLEhRcW0+P4ELwrHtZuc61BQ
	96V5pDYmd8j/5lwDz5TMV3nrautmKMF5OOee3CWiY38EPS1FFgn/t7jl46TW8bEuk2+O6cTP550OJ
	Y5INp21NWolfhNwlOWyEVHrpJlWFuFv8LmZnUvAwMtOg+h/HWkOnKHfp74exc5kG9rvNuiOoOfhAG
	01LhiBW7tC0ejq0ZC4u+t1RpU02Ko7JB9bOCn04Qfjam9OUPswGn9BYlz9G7J2gaYATv8z1Iwoc+U
	O/i5q5xkp++JUSYoWDjCtXYVN9fjlrBmZheHLEqsUpwuJJF4GmE5mK3zUfCVNM49y/FzevJnoQg35
	DBeAIqu8Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jzO4u-0007dS-L5; Sat, 25 Jul 2020 17:35:20 +0000
Received: from mail-pg1-f195.google.com ([209.85.215.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jzO4o-0007co-Ro
 for linux-nvme@lists.infradead.org; Sat, 25 Jul 2020 17:35:16 +0000
Received: by mail-pg1-f195.google.com with SMTP id z5so7121149pgb.6
 for <linux-nvme@lists.infradead.org>; Sat, 25 Jul 2020 10:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Db08YAVlpCXXLXfH8R/aB6J6E3I9+q0LfXhTe9cfO4A=;
 b=azcAJMRdz9D4vu+FRhoRZr4G/jJdE2jdwptn6Y2U/DSU5MtHsn5L6/3+V5C9pu9vfI
 izGTyVpnQRhQeB3VMfg0qaQmizfRaEiLNo+gnazAawVgkEVK7YWV9coqGzYIjMiYA3rC
 j1CzUDpvpuKOW80SWc8AvsyvRmIiMQx0y4RZySJbjBx3bzhviIabgQ1Vr9HIrPo+C7+9
 RJC1bCQbMuKNarh8hu/J+GDsFZd7/VDwjP1i0zs+RKQemXBeZZpfwAWKUwfzdRHEgkpP
 jl7nopv/Az6EOl2NgvqG5Wm2+xbbVGgAUQWgY4Fjue5OC0kwST/sSwSzrJMtslOnxgMg
 Wiig==
X-Gm-Message-State: AOAM532H2raB2Gcw1fYnS+845Oxja872rmz58auOR9JMReIW9lQPZSBg
 KlBixKVqF++1bAyedLC6+to=
X-Google-Smtp-Source: ABdhPJyUr4KQAZoKO9UDOh6MaaEFyf6pmzcRxMSxMuBBapkuz6uiqX0HN2/4aG7KW04qnnzwiqZ2Eg==
X-Received: by 2002:a62:2546:: with SMTP id l67mr14386200pfl.154.1595698503956; 
 Sat, 25 Jul 2020 10:35:03 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:c428:8d39:30dd:38a5?
 ([2601:647:4802:9070:c428:8d39:30dd:38a5])
 by smtp.gmail.com with ESMTPSA id a23sm58614pfg.32.2020.07.25.10.35.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jul 2020 10:35:03 -0700 (PDT)
Subject: Re: [PATCH rfc v2 1/4] blk-mq: add async quiesce interface for
 blocking hw queues
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200724230604.34625-1-sagi@grimberg.me>
 <20200724230604.34625-2-sagi@grimberg.me>
 <c3aaceca-7429-20a8-54f9-158123b3be74@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2e921c98-b125-1d4c-a63a-ea5f30c55e69@grimberg.me>
Date: Sat, 25 Jul 2020 10:35:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c3aaceca-7429-20a8-54f9-158123b3be74@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200725_133514_938041_4AD3AE3D 
X-CRM114-Status: GOOD (  10.74  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Looks great. One suggest: srcu provide the batch sync mechanism,
> it may be more generic. Weakness: for the same srcu, concurrent batch
> waiting is not supported. The code just for TINY_SRCU:

Doesn't make sense to me...

But what I was thinking is not to do this only for blocking queues, we
can easily use call_rcu for non-blocking queues as well..

i.e.
--
void blk_mq_quiesce_queue_async(struct request_queue *q)
{
         struct blk_mq_hw_ctx *hctx;
         unsigned int i;

         blk_mq_quiesce_queue_nowait(q);

         queue_for_each_hw_ctx(q, hctx, i) {
                 init_completion(&hctx->rcu_sync.completion);
                 init_rcu_head(&hctx->rcu_sync.head);
                 if (hctx->flags & BLK_MQ_F_BLOCKING)
                         call_srcu(hctx->srcu, &hctx->rcu_sync.head,
                                 wakeme_after_rcu);
                 else
                         call_rcu(hctx->srcu, &hctx->rcu_sync.head,
                                 wakeme_after_rcu);
         }
}
EXPORT_SYMBOL_GPL(blk_mq_quiesce_blocking_queue_async);

void blk_mq_quiesce_queue_async_wait(struct request_queue *q)
{
         struct blk_mq_hw_ctx *hctx;
         unsigned int i;

         queue_for_each_hw_ctx(q, hctx, i) {
                 wait_for_completion(&hctx->rcu_sync.completion);
                 destroy_rcu_head(&hctx->rcu_sync.head);
         }
}
EXPORT_SYMBOL_GPL(blk_mq_quiesce_blocking_queue_async_wait);
--

And then in nvme we always use that...

Thoughts?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
