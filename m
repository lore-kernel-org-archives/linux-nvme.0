Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652A6C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 15:57:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33DEA2053B
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 15:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D4Jihvwr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33DEA2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=F0i421HRC4D21xJFhIzAHEVOgXBZYQ5g99zmHm8AM4Q=; b=D4Jihvwryj3peYAjSN3FxYmIO
	yv/eXOtmig7+uxcjRywgrDy2nnJ8R48PlZ5tc05/LEHx9G+1Gkrgv1RTTAwvgZXaE0UFdNzzRj42e
	dSs8y7VPg0s/AiArG8HbR6z0UOUy4TLFprHBwlnnEjCDwLBZ3ujy81DrK092Lpg01wLBCYTElo15U
	RF27ggVf09UkHjmNII//kiPDpsJH8gpoHfwUdMaxq+QrxNl5BZ9937RZkyYYWC5XTmkrYXjF+IvgF
	x2Ip0Pz59/cUzzIyWvaLwQPMSJb49V0mmG6y48L8PodLGJv+Boaifq/6NCRyx1VaJagFz5cPu9isU
	gLtzow4qQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0Rys-0008Cn-5d; Tue, 28 Jul 2020 15:57:30 +0000
Received: from mail-pl1-f193.google.com ([209.85.214.193])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0Ryp-0008CK-MU
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 15:57:28 +0000
Received: by mail-pl1-f193.google.com with SMTP id t6so10097434plo.3
 for <linux-nvme@lists.infradead.org>; Tue, 28 Jul 2020 08:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DvbENJ/8Uz8+l605Ukq2ToCOWGl/cHtSbvZ4+mP9aCg=;
 b=kzCyA1p/TsInGCDIucoHhb/qyyCK+O8V36PK7DheR8UfAgrZ8KQYVMJlOwAa7GGqYf
 ann9PnaOWQ2YGQEniBBs9p+Kn69gG9Dw/+Iv40YCPGMnxs3BMcrJLfrRm79xBF9TuAf8
 7qhezoTjiCzQqGtO8VLiAKJD6CPtDZp4h5y6CnfU4EUxiFKNtbyipQ04F+mkdoJIcQPI
 P8NL/lqlHEhJX9pFHUwwDrNgWt5tm35SiPmAwgLJaHEJo2/RPe5DtmGDQfl9p81MbybQ
 VVCuJfcRtN71rqvM51fV2BNjE5zdgkaM1tRgzloMH1fm8tuBhRL06bsq6CkBFoqGlDd4
 XMfw==
X-Gm-Message-State: AOAM533ydapl+1coEaA/VmmTGir+GQHkAeyE0548HXf8rAg0S3L9Uunj
 HL3AE/juT15862uj7n6tCto=
X-Google-Smtp-Source: ABdhPJwoDYkg8Vzi5epkT6iuxcDY1Ih0KLtIEGN05xmTwkgEsDYUAwyFJ94TYPqK2HMa95ap8utQoQ==
X-Received: by 2002:a17:90a:dd44:: with SMTP id
 u4mr4837290pjv.203.1595951846262; 
 Tue, 28 Jul 2020 08:57:26 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:541c:8b1b:5ac:35fe?
 ([2601:647:4802:9070:541c:8b1b:5ac:35fe])
 by smtp.gmail.com with ESMTPSA id f93sm3579112pjk.56.2020.07.28.08.57.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2020 08:57:25 -0700 (PDT)
Subject: Re: [PATCH 1/2] nvme-tcp: fix controller reset hang during traffic
To: Christoph Hellwig <hch@lst.de>
References: <20200724221013.28828-1-sagi@grimberg.me>
 <20200728104959.GA29442@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8ef59b19-c2a4-df0f-4f41-e9779aff7334@grimberg.me>
Date: Tue, 28 Jul 2020 08:57:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728104959.GA29442@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200728_115727_749677_760C7680 
X-CRM114-Status: GOOD (  15.66  )
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
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> commit fe35ec58f0d3 ("block: update hctx map when use multiple maps")
>> exposed an issue where we may hang trying to wait for queue freeze
>> during I/O. We call blk_mq_update_nr_hw_queues which in case of multiple
>> queue maps (which we have now for default/read/poll) is attempting to
>> freeze the queue. However we never started queue freeze when starting the
>> reset, which means that we have inflight pending requests that entered the
>> queue that we will not complete once the queue is quiesced.
>>
>> So start a freeze before we quiesce the queue, and unfreeze the queue
>> after we successfully connected the I/O queues (and make sure to call
>> blk_mq_update_nr_hw_queues only after we are sure that the queue was
>> already frozen).
>>
>> This follows to how the pci driver handles resets.
>>
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> 
> Applied to nvme-5.9.  I've also addeda fixes tag.

It doesn't fix a regression caused by this commit, but rather exposed
by this commit. I agree that its good to have it for stable.

Thanks

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
