Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9257C433E3
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 03:25:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78F20207CD
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 03:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="xfQg5Mt6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78F20207CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NP9L04aAJoeSXK/l533JwrmAv4EIs9JXbYYXgvg/YNE=; b=xfQg5Mt6vlqQGn0ISUIkk3jX4
	2i5aqTiXcwPoZssmcIh+b4QqNU+CRI5mHPmoux6fjpRwxdyjyjBmJScdyCY3DSQrmVhWyf6f3Qh8J
	VIzgK5AxWVCoAvOyYcLVDIjiNcAbRYjdk/JVWyLhcx0VJAK4kcNlU/EjXUEa0Kg0pQ4BXetSB2Jth
	qicbTXQycXCNgBc9VUz2CaGC3yW6XvLuQ8TFBr1SSZHlYFtkmury05c1C2+Im+Tx/ckmmtC+C0COD
	7wWf88rLomqfIVtrmtOjWTH5VM6hyG97QrADXBcVViVQIHyH6+4ds4DRkN/oBmN/zuxYNkaY5iJgl
	JR5IABcpQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0GFK-0002hs-Jm; Tue, 28 Jul 2020 03:25:42 +0000
Received: from mail-wr1-f67.google.com ([209.85.221.67])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0GFH-0002hC-PP
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 03:25:40 +0000
Received: by mail-wr1-f67.google.com with SMTP id y3so16790623wrl.4
 for <linux-nvme@lists.infradead.org>; Mon, 27 Jul 2020 20:25:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=U/kGwtuYOiekxizlErsTnqhYTOEp56sdiJdDnuI594A=;
 b=ay0Mkp7ywvXemkZiH18prksa1vHGyIcc7i4qS+P3l3X1SuAx2GNNpIT3ukwu/A/bFq
 uiFqk2N1JjTlT8Zk0FqOFi/RMtlCG8C2zZMWnbAeddO1loK9MVjFOgd2QuBxb7maHI6R
 OkNmNHArpTcm1NI42FNH7pHW/A/9+r8hnZAqzzr+hHM47+WfXMrEiF8SntjCvSVnbj7z
 qNBg8eB499aAFbbclJPCcfPNPsmxH6duhFgnqbbhXYqGLmYg5xvM/IOsvpTjwN7Gfb09
 VOYE++gpLsHOBUWQzNkjZRIKADlr9jh4XjMY1FYg4CrIuLfd7Jbwiew/NJDRR+ennGhT
 fx4w==
X-Gm-Message-State: AOAM5319rGrEX+/w057Gx0OBLyCJzNrhRYdTbHnQawxr3ZfyH6JwyjmG
 Yj2sWP+EhGCZdqhg4qtAvorIojG/
X-Google-Smtp-Source: ABdhPJwaDO671D7E8IsibFT67dC+QkKRci0izpvrkXdlCCFDd5282KbIVLCZuy8n8QOVjjECWOBq1Q==
X-Received: by 2002:a5d:6cd0:: with SMTP id c16mr23319265wrc.121.1595906738224; 
 Mon, 27 Jul 2020 20:25:38 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5d7d:f206:b163:f30b?
 ([2601:647:4802:9070:5d7d:f206:b163:f30b])
 by smtp.gmail.com with ESMTPSA id k1sm6582519wrw.91.2020.07.27.20.25.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2020 20:25:37 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
To: Ming Lei <ming.lei@redhat.com>
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-2-sagi@grimberg.me> <20200728014038.GA1305646@T590>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <65634c0a-4f40-ddba-2dbd-6902b902abeb@grimberg.me>
Date: Mon, 27 Jul 2020 20:25:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728014038.GA1305646@T590>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200727_232539_860337_C80F880A 
X-CRM114-Status: GOOD (  22.48  )
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Chao Leng <lengchao@huawei.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lin <mlin@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> drivers that have shared tagsets may need to quiesce potentially a lot
>> of request queues that all share a single tagset (e.g. nvme). Add an interface
>> to quiesce all the queues on a given tagset. This interface is useful because
>> it can speedup the quiesce by doing it in parallel.
>>
>> For tagsets that have BLK_MQ_F_BLOCKING set, we use call_srcu to all hctxs
>> in parallel such that all of them wait for the same rcu elapsed period with
>> a per-hctx heap allocated rcu_synchronize. for tagsets that don't have
>> BLK_MQ_F_BLOCKING set, we simply call a single synchronize_rcu as this is
>> sufficient.
>>
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>>   block/blk-mq.c         | 66 ++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/blk-mq.h |  4 +++
>>   2 files changed, 70 insertions(+)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index abcf590f6238..c37e37354330 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -209,6 +209,42 @@ void blk_mq_quiesce_queue_nowait(struct request_queue *q)
>>   }
>>   EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
>>   
>> +static void blk_mq_quiesce_blocking_queue_async(struct request_queue *q)
>> +{
>> +	struct blk_mq_hw_ctx *hctx;
>> +	unsigned int i;
>> +
>> +	blk_mq_quiesce_queue_nowait(q);
>> +
>> +	queue_for_each_hw_ctx(q, hctx, i) {
>> +		WARN_ON_ONCE(!(hctx->flags & BLK_MQ_F_BLOCKING));
>> +		hctx->rcu_sync = kmalloc(sizeof(*hctx->rcu_sync), GFP_KERNEL);
>> +		if (!hctx->rcu_sync)
>> +			continue;
> 
> This approach of quiesce/unquiesce tagset is good abstraction.

I'm thinking I don't want to use this interface, it quiesce the
connect_q hctxs as well and then I need to unquiesce them which is
awkward...

> Just one more thing, please allocate a rcu_sync array because hctx is supposed
> to not store scratch stuff.

Sorry, I object to any interface that returns back the rcu_sync
allocation. Its just awkward. really..

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
