Return-Path: <SRS0=Ap99=CK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BD7C433E7
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 17:21:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DA832087D
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 17:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HoezeHVY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DA832087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QOHY+vobNApLAITFhsqO84w7ZZl+l5rm+HJNz+npe/I=; b=HoezeHVY7FAPFhp//SlaYhk7O
	V8p2ig65ubwo5fcmDkq0zcaTeEOGczcNsWmzMHLolkNvKymdjgBwbRwm5560pNoxApJ1Xz5qoGn6p
	MWlzvmVadbsKs56GHZo66JKMLgcswW8uvr95JfLLRQ/lci/gGjLbNDQqaUQrRjjHPXCGZnxzo2/C9
	qEUsB/0IhKdd2/FZmq7wAM9rXEx5G+53aT3g78pF++Me+lxTO6dVblqHqLngFEx3n6T9zXuNfIRrj
	PKnuXnCBme6pNoMRo8x2kmMMLjytaDYxAfI+NxIydkc/k9DvuXoGvmjtZoN3j6XLiIr3THqhao5+H
	3nDLu9pow==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kD9y4-0004dS-Nj; Tue, 01 Sep 2020 17:21:12 +0000
Received: from mail-pg1-f194.google.com ([209.85.215.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kD9y2-0004cp-0S
 for linux-nvme@lists.infradead.org; Tue, 01 Sep 2020 17:21:10 +0000
Received: by mail-pg1-f194.google.com with SMTP id p37so1032374pgl.3
 for <linux-nvme@lists.infradead.org>; Tue, 01 Sep 2020 10:21:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QcZoWUQqi5MQYyFBPO6ck3Q9dU0kHRSoBBqiZpu8FkY=;
 b=NsD0AxPj1+a/lmmXIS9o55BiTHujaE/4/9c+8IOi7QP387sZb8VS3ukzi/gaBGYsng
 QTMOJ1E3652FbHxlHQLwgi71NqxqK1iIzkqdL3ag9cg5s8mLeTsoy3vJoqI0VmUK21bD
 VJNziI55GLr+FTHY9jeztKMxpqmziUKFCSgn6GCyA3Dm0iE2O6oLgtB4UpsQ4jdCzOhs
 Z0lVG6IXwRQl25A2tBmdm+qpcpSHRnlOlMUmobRe2nDqrcDNEyAExAE4X2I0qKQXTqUV
 pU2rS4hlAwwuTvLGePtpihUONPCxjLkUMcsfePgL4Q8Nece1pEhhLxIDIwJDlOPszg2R
 bvZQ==
X-Gm-Message-State: AOAM531aBtUdO1Ub+EkPnEYGOrD/AEGzkYSYV84aZ3EXqpJ1t/D6yHO2
 LJaBMaSWwNVK5ckiVBTPexw0wpn5qJvFgw==
X-Google-Smtp-Source: ABdhPJxHaN4NxVXpqbmn8jpqYr2M3ocm1BXojlMTSAT4uqAoKGbmQ6NRccaExgUrZ06XZaEgZd5zLg==
X-Received: by 2002:a62:5e04:: with SMTP id s4mr2862684pfb.67.1598980867468;
 Tue, 01 Sep 2020 10:21:07 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:61c1:4660:c489:2347?
 ([2601:647:4802:9070:61c1:4660:c489:2347])
 by smtp.gmail.com with ESMTPSA id p17sm2517262pfn.147.2020.09.01.10.21.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 10:21:06 -0700 (PDT)
Subject: Re: [PATCH V2 01/12] nvme-core: annotate nvme_alloc_request()
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
References: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
 <20200831222707.35611-2-chaitanya.kulkarni@wdc.com>
 <20200901015659.GA4398@VM20190228-100.tbsite.net>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <74008ef5-f54f-ab08-011e-0ff271b1f33a@grimberg.me>
Date: Tue, 1 Sep 2020 10:21:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901015659.GA4398@VM20190228-100.tbsite.net>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200901_132110_077998_7CD668B6 
X-CRM114-Status: GOOD (  14.99  )
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
Cc: kbusch@kernel.org, logang@deltatee.com, hch@lst.de,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 5702a3843746..a62fdcbfd1cc 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -508,7 +508,7 @@ struct request *nvme_alloc_request(struct request_queue *q,
>>   	unsigned op = nvme_is_write(cmd) ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN;
>>   	struct request *req;
>>   
>> -	if (qid == NVME_QID_ANY) {
>> +	if (unlikely(qid == NVME_QID_ANY)) {
> 
>  From your commit message, this should be likely(), right?
> 
>>   		req = blk_mq_alloc_request(q, op, flags);
>>   	} else {
>>   		req = blk_mq_alloc_request_hctx(q, op, flags,

Chaitanya, can you check the objdump that the change actually
resulted in a different machine code, I've seen patches of this
sort lately where this annotation didn't change anything at all.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
