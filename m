Return-Path: <SRS0=li1X=BB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEC2C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jul 2020 16:13:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1669120787
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jul 2020 16:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="xgGhGK8a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1669120787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ebOOco9cVGpUO0xIarsysBPZorhA1K969uj1QJKgqTA=; b=xgGhGK8aKaUUkthAqhvdK7Pw2
	uDy5ad8v4GczvURvV4vaAwP3E+yqQ40J9cBixoNFYz9gPjTOn6YL2/KTYheinlyejcuhIspWRWv1R
	7d/WyGgl3HcHNxm1pCaGg8XcJfcXGiaXOw0G/FFcgZ6DS0gFkEwxk+az34MDRT6MeXMjNxGRUNYDr
	lF94aTKBYYem14u8v9YGbjiug2OaoBuCTQFrDi/MqLyonRd25wJ0/LMuKkK7nWi9SrJ7FM3g95lF+
	YfQgmOCoJTRtKscSlMt2BaQlmTElX/DuQ73FPuyu1+sv9na1XIYFtpEszOoPbDKM1JIWRe/QcjsAw
	FWlGa6L8g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jyHNA-0006Ak-PL; Wed, 22 Jul 2020 16:13:36 +0000
Received: from mail-pj1-f66.google.com ([209.85.216.66])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jyHN8-00069z-I3
 for linux-nvme@lists.infradead.org; Wed, 22 Jul 2020 16:13:35 +0000
Received: by mail-pj1-f66.google.com with SMTP id b92so1630005pjc.4
 for <linux-nvme@lists.infradead.org>; Wed, 22 Jul 2020 09:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IyJ8kGqgn+MxQT5/dtSQDb8NujN8bUWS1ItjLniGFWI=;
 b=bXM8npI9dsltYvfR5QJpsaZ6MbeK5Q4y9/z6VLZuBh2cx/RTcaCWOXmMQEOoH6To9w
 UBPAJhiNC5gni8GixBCWrfJZNgm2cOJ6b0w3h+usLPYnOt9QhQbtelobGC/6V89qhh0j
 D6yro3KgB+sLiJRbOdN9yO80yHB3L70I62lG4IqBuq/XeWToJN6VKonxEHaceBeT4mLR
 Q3FmV5yoODT30plFSyjCvtHrwQ9P51ggf2nh7IVqA3yXMKuQHQFyMmbm8IaG3E43BmYj
 itp7tlRVRmdaeJVLD4lVeeRv+opYzPufxS8F/NhQ+heo+/dWzcRo/tM1wJ21Ug914J47
 MDQQ==
X-Gm-Message-State: AOAM532YGbbM8RI3kGX0mF+1RNPtQixeicWz8QAX6N1ezey//4zUZEZD
 aM8o7cntzDbpX+WkzSHN77nIETmK
X-Google-Smtp-Source: ABdhPJx4yyfoFhUvS+vxRHr1hfkVe9XGTWCAY7Jn9pfhrbU1oXq7ruEZQFe8tW9eqHYFf8Uzy+rEuQ==
X-Received: by 2002:a17:902:8f83:: with SMTP id
 z3mr185123plo.162.1595434411875; 
 Wed, 22 Jul 2020 09:13:31 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:45ba:2951:1398:d100?
 ([2601:647:4802:9070:45ba:2951:1398:d100])
 by smtp.gmail.com with ESMTPSA id r204sm43775pfc.134.2020.07.22.09.13.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2020 09:13:30 -0700 (PDT)
Subject: Re: [PATCH] nvme-core: reduce io pause time when fail over
To: Keith Busch <kbusch@kernel.org>, Chao Leng <lengchao@huawei.com>
References: <20200722093633.31347-1-lengchao@huawei.com>
 <20200722160054.GA1363519@dhcp-10-100-145-180.wdl.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <973d6470-05e8-8be4-2c8b-3162f37a971e@grimberg.me>
Date: Wed, 22 Jul 2020 09:13:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722160054.GA1363519@dhcp-10-100-145-180.wdl.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200722_121334_614121_C41869B2 
X-CRM114-Status: GOOD (  14.18  )
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
Cc: axboe@fb.com, hch@lst.de, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> To reduce io pause time, nvme_stop_queues use
>> blk_mq_quiesce_queue_nowait to quiesce the queue, nvme_stop_queues wait
>> all ongoing dispatches completed after all queues has been quiesced.
> 
> The comment above blk_mq_quiesce_queue_nowait() wants to remove this
> function. I'm not sure we should be introducing more users if that's the
> case.
> 
> Using synchronize_rcu() at the end may be looking to much into blk-mq's
> internal quiesce implementation. It happens to be the right thing to do
> for non-blocking hctx, so this patch assumes that will be true for any
> nvme request_queue.

nvme-tcp became a block hctx since we optimize to do network sends from
inside queue_rq. So this should either split into two functions or
nvme-core needs to look into BLK_MQ_F_BLOCKING and do the right thing.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
