Return-Path: <SRS0=p1db=LY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13445C11F65
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jun 2021 18:59:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8D37613DF
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jun 2021 18:59:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8D37613DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cHAtORczqRXG9gIz3db7OUq21zJnSf80rOTVHAWgHpM=; b=GZtGvVIwVbBMkVfVK4FOR8aFuS
	tUiZQWImYz8sChUuZiEU03pGJOhYb6URFMkqXZ3APoG+6uttaP2QjGqjaZ6z3qPmFmnZnRBeQHQYh
	UGzdZkAM7J32qBW+qiWALc9nsoxVB7x07ml7rSC9AZSVg6YzGoUTvEYAd2GLnxSTh2Um4pUaCM3hd
	4EiQiB/Ehlta+xN5165qQaZy1zM2KnYQFO2BsFQEyoxcQylnXvmFT5NMYQ6w1DHmYlztkByZH7OW6
	l3OinsmlTWIE8Q8DWkFXgXJXgb2nnY6/UJRlY+QR9mdBSWV3EC+y5NBrK0jB33GudKpKik9CQyKeA
	mEuzDGag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lyfQy-00F3tm-PU; Wed, 30 Jun 2021 18:59:40 +0000
Received: from mail-pg1-f177.google.com ([209.85.215.177])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lyfQt-00F3sU-Tw
 for linux-nvme@lists.infradead.org; Wed, 30 Jun 2021 18:59:37 +0000
Received: by mail-pg1-f177.google.com with SMTP id w15so3234886pgk.13
 for <linux-nvme@lists.infradead.org>; Wed, 30 Jun 2021 11:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0Wi/OHievHiEkbKZk39MUJJHz8CqqbZiqlSseobXU1M=;
 b=i9kK+0b02kchmv9sgx2IavN8DzAzUxe/9a6QSWioMO8JsMuUwDw38ZaHqZ0KxCLnbw
 yL69JYnXUPuG6Bqo49bocxlSLM/p2AzUXbFxBGVFaGinBBTAAb5HzNti1hToIYRndP+d
 c1Rdk/0MryIMNDSpWF3Wyx0scy0cmuU4ZQdf3MgCzxz2wVr2HurnLHSGhl1K4Jy+xAx7
 PfN8q6UN4X5MteXYMDjZjeVnE/rGIwELLHL6SJ41zJxogBQ3bLS+JOVM+SUXEb55lRjw
 5nr76Lfn96LjyTtKx1QJbusjElUioD0xBhAGF/BlKmO5sowGBEVwW99KO/eABdKRLxUn
 ZtHw==
X-Gm-Message-State: AOAM533GOBOFDxgpNvMKPklcderAXVr59niv82jFD/hMRfM7HmChmynk
 l3HoD2Vu2xk5pKvW4NCUU7w=
X-Google-Smtp-Source: ABdhPJy5tD0xCLQMXKqgVzsGUSIoGa7yBsH1MnAew8zlYGkpf2YhN3yoWG+sZC4S96FcwF5kZZ03gw==
X-Received: by 2002:a63:b0b:: with SMTP id 11mr35524933pgl.341.1625079575156; 
 Wed, 30 Jun 2021 11:59:35 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:8e5:b428:30c3:f97b?
 ([2601:647:4802:9070:8e5:b428:30c3:f97b])
 by smtp.gmail.com with ESMTPSA id c24sm22501230pfd.167.2021.06.30.11.59.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jun 2021 11:59:34 -0700 (PDT)
Subject: Re: [PATCH 0/2] blk-mq: fix blk_mq_alloc_request_hctx
To: Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Daniel Wagner <dwagner@suse.de>, Wen Xiong <wenxiong@us.ibm.com>,
 John Garry <john.garry@huawei.com>
References: <20210629074951.1981284-1-ming.lei@redhat.com>
 <5f304121-38ce-034b-2d17-93d136c77fe6@suse.de> <YNwug8n7qGL5uXfo@T590>
 <c1de513a-5477-9d1d-0ddc-24e9166cc717@suse.de> <YNw/DcxIIMeg/2VK@T590>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e106f9c4-35c3-b2da-cdd8-3c4dff8234d6@grimberg.me>
Date: Wed, 30 Jun 2021 11:59:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNw/DcxIIMeg/2VK@T590>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210630_115936_049990_B4BD9A2E 
X-CRM114-Status: GOOD (  14.33  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>>> Shouldn't we rather modify the tagset to only refer to the current online
>>>> CPUs _only_, thereby never submit a connect request for hctx with only
>>>> offline CPUs?
>>>
>>> Then you may setup very less io queues, and performance may suffer even
>>> though lots of CPUs become online later.
>>> ;
>> Only if we stay with the reduced number of I/O queues. Which is not what I'm
>> proposing; I'd rather prefer to connect and disconnect queues from the cpu
>> hotplug handler. For starters we could even trigger a reset once the first
>> cpu within a hctx is onlined.
> 
> Yeah, that need one big/complicated patchset, but not see any advantages
> over this simple approach.

I tend to agree with Ming here.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
