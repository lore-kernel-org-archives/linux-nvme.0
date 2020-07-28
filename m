Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB44C433E3
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 00:13:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75A9020786
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 00:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LoqwDpar"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75A9020786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=F6Gdffsn+ZTNE6mqcpVf2//OKRCsGLRz44Em+UF8IKI=; b=LoqwDparbyaKGiA0RCyVvYh+M
	IhWhto41aEWACTnOMOfl6bh3hxplQiy/3zhwSpXzIRFR00KHQxQS/O/IWkm5wbEg3wPE2aa8d5YeR
	Ssa7fnMULQmZ8426lOUaNm7HdRj6avTmJfU8+bO5KZ0U6GcxwG/ywILJ/qJ8WPm0JNz0wt2uHpwBt
	FeCompFO69EIdhzCWnxUMpDpSJHfnrNXvtqMEXf2sXDWVbygGOAkcIMQFu/xQ7KLni6UoA98bEAf5
	1CSl0fqkTseXA+d1KINQHMlKtGoNcEtDdwRg16nMqOJv0UKOZye8Zhm8+5sX4MZeYUcPgcWKTbYjx
	rqH6P09bA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0DEm-0006L4-Tt; Tue, 28 Jul 2020 00:12:56 +0000
Received: from mail-pj1-f65.google.com ([209.85.216.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0DEj-0006Kf-Nw
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 00:12:55 +0000
Received: by mail-pj1-f65.google.com with SMTP id o22so10522864pjw.2
 for <linux-nvme@lists.infradead.org>; Mon, 27 Jul 2020 17:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LfVP1kKblrSBABZwodiPANe16VZ1uWUWSsP7qtO4DEA=;
 b=s75iju62SiGI7bUBmdgf4KA5X408TMSZs8833x1QM7kW5ud6uzRpK7KR2HMmy/2iTz
 X+fDagSNTjPkrQEZYqafiU/ehk1RTwLqY/y1ryH7CGF+KH0h1Nq4+r28aeB/WIHL+rhZ
 TojV4HtdNFEyauxF1dpkW15oH+nwrWjjFP5Lqdk7pJUdJ8k9MQ3gUr+wR5IY+dkGZiuF
 eXzykJxW2CBC6pn08SpYFLWBp/ZKfFXziTofJOpE6DKdSR2luXQ14nXP9fItxaF67oFR
 KXYggyO1LE65NRwZMIb3qUQl7wRmetIWMBPYVaobuM+AFGb6wRvfoXB2ETKoQjQFfZNH
 w0lQ==
X-Gm-Message-State: AOAM531EzzlpR3gJIAFLW6wc+SaZ7OhX2ixuMRN7rD+n0xnUJoVbYPi5
 HqW82xrrWAAIwBT5VJt6XhA=
X-Google-Smtp-Source: ABdhPJzHhR5439Dn4jhOGcw1RPSH9qal5fvG+CP0DRNjI6vTJgIuwRww1QwIiCaEezccXido6gBBnw==
X-Received: by 2002:a17:90a:a68:: with SMTP id
 o95mr1687505pjo.148.1595895172505; 
 Mon, 27 Jul 2020 17:12:52 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5d7d:f206:b163:f30b?
 ([2601:647:4802:9070:5d7d:f206:b163:f30b])
 by smtp.gmail.com with ESMTPSA id j5sm15230788pgi.42.2020.07.27.17.12.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2020 17:12:51 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
To: Keith Busch <kbusch@kernel.org>
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-2-sagi@grimberg.me>
 <20200727233241.GA797782@dhcp-10-100-145-180.wdl.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <376f8e3d-a8db-9810-0e5b-a022696a893f@grimberg.me>
Date: Mon, 27 Jul 2020 17:12:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727233241.GA797782@dhcp-10-100-145-180.wdl.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200727_201253_798657_74A2C393 
X-CRM114-Status: GOOD (  13.78  )
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
 Ming Lin <mlin@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> +static void blk_mq_quiesce_blocking_queue_async_wait(struct request_queue *q)
>> +{
>> +	struct blk_mq_hw_ctx *hctx;
>> +	unsigned int i;
>> +
>> +	queue_for_each_hw_ctx(q, hctx, i) {
>> +		WARN_ON_ONCE(!(hctx->flags & BLK_MQ_F_BLOCKING));
>> +		if (!hctx->rcu_sync) {
>> +			synchronize_srcu(hctx->srcu);
>> +			continue;
>> +		}
>> +		wait_for_completion(&hctx->rcu_sync->completion);
>> +		destroy_rcu_head(&hctx->rcu_sync->head);
> 
> Leaking rcu_sync, and not clearing it across quiesce contexts. Needs:
> 
> 		kfree(hctx->rcu_sync);
> 		hctx->rcu_sync = NULL;

Good catch, will wait for some more review and submit a v6.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
