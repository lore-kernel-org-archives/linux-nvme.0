Return-Path: <SRS0=jy92=BI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29311C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 04:39:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED6372070B
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 04:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="djY3lmvU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED6372070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=75lOPhiuTc2jEWh1pHy67cM2M6zy1O0VJWmb8EHKKls=; b=djY3lmvUYJ6PfmzORqYKEiVyp
	n2A5mFEzKfXtXrHG8XgRx4G4xOo4/zUzscP/6SxHSwwGuEaxhxBlE5XMQMUXeEjHSuV9N8dRAzMS+
	JOYNQ7DfLRS18VBGjX4zRr90hFHV4xKQHnaI/Jiq/dhs3p5mcMQSg3AH6Qs/MBDBkhDvzKaUfesFQ
	bd2L8iyqFT5rv7LGOXNmtGMqRDNxyzjQ+2E9rdh6JeA3kPfOV/VlbU1s+lalAR6O73cI9WVnmBiYH
	QiYNp+K9ST3Mv6/cWv/568mm/Ql2UiVWXrlPb2ZaVImpLHW2uFDKls/j3Nk6gjAnW+kwG/cJnhlyM
	t0JWLUr4Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0dsR-0000Os-FS; Wed, 29 Jul 2020 04:39:39 +0000
Received: from mail-pj1-f66.google.com ([209.85.216.66])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0dsP-0000Mv-4w
 for linux-nvme@lists.infradead.org; Wed, 29 Jul 2020 04:39:38 +0000
Received: by mail-pj1-f66.google.com with SMTP id gc9so1296725pjb.2
 for <linux-nvme@lists.infradead.org>; Tue, 28 Jul 2020 21:39:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gxYDx5pEjBGzNAcO5iDUs2RLckxHaGp4SDZYoJL4RCw=;
 b=tMa2Ii4syQehmQs++/92F7s5huv7uREzg6sN7mt/fRXj8k446wIAh9ok4SGx19ZXyx
 T2w5pHIzHUeDUYg+YCEXGq2khRZfUF02aJRSEQyR2JZBQgUIgFHhFO9eTF3DYIRrDBmG
 1E7s85jcVAVkF5cRjokVJUMMJiT+AbrF/u4oeeZGhZvWcdMApzlubI3+2tgpS+H3aIIs
 gOccFl6BuBHUO9Jtdk+6T/3uZlzCvJFaLd1xO4ZAvQpUG2IO0LAqILmMvOUOp4AHIdnd
 NtClC+8ja63piwqLc8huZzTY5cU/WUM3ws/BPq9gBPrHPCmm1tlaAZDDzu+m9l75j4/b
 dHbA==
X-Gm-Message-State: AOAM532IJ34VY8l5srg7Ths2dMrWQn7WTjkRD9QzT/561Pa7jVMCaft1
 0a6stGUiI3FdqI1wsaLArHYDShO9
X-Google-Smtp-Source: ABdhPJzc2rtDbQsrUdjJI5UzJe9jQNDalJTCdqHt5SpuvftO1Z5yMbStZKmT86T0g9skTgfSuzygqw==
X-Received: by 2002:a17:90a:6946:: with SMTP id
 j6mr6810696pjm.223.1595997576341; 
 Tue, 28 Jul 2020 21:39:36 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:fcc5:69d8:6e20:4fd1?
 ([2601:647:4802:9070:fcc5:69d8:6e20:4fd1])
 by smtp.gmail.com with ESMTPSA id o26sm616394pfp.219.2020.07.28.21.39.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2020 21:39:35 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
To: Keith Busch <kbusch@kernel.org>
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-2-sagi@grimberg.me> <20200728071859.GA21629@lst.de>
 <20200728091633.GB1326626@T590>
 <b1e7c2c5-dad5-778c-f397-6530766a0150@grimberg.me>
 <20200728135436.GP9247@paulmck-ThinkPad-P72>
 <d1ba2009-130a-d423-1389-c7af72e25a6a@grimberg.me>
 <20200729003124.GT9247@paulmck-ThinkPad-P72>
 <07c90cf1-bb6f-a343-b0bf-4c91b9acb431@grimberg.me>
 <20200729005942.GA2729664@dhcp-10-100-145-180.wdl.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2f17c8ed-99f6-c71c-edd1-fd96481f432c@grimberg.me>
Date: Tue, 28 Jul 2020 21:39:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200729005942.GA2729664@dhcp-10-100-145-180.wdl.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200729_003937_206109_599A29C3 
X-CRM114-Status: GOOD (  17.36  )
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
Cc: Jens Axboe <axboe@kernel.dk>, paulmck@kernel.org,
 linux-nvme@lists.infradead.org, Ming Lei <ming.lei@redhat.com>,
 linux-block@vger.kernel.org, Chao Leng <lengchao@huawei.com>,
 Ming Lin <mlin@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>>> Dynamically allocating each one is possible but not very scalable.
>>>>
>>>> The question is if there is some way, we can do this with on-stack
>>>> or a single on-heap rcu_head or equivalent that can achieve the same
>>>> effect.
>>>
>>> If the hctx structures are guaranteed to stay put, you could count
>>> them and then do a single allocation of an array of rcu_head structures
>>> (or some larger structure containing an rcu_head structure, if needed).
>>> You could then sequence through this array, consuming one rcu_head per
>>> hctx as you processed it.  Once all the callbacks had been invoked,
>>> it would be safe to free the array.
>>>
>>> Sounds too simple, though.  So what am I missing?
>>
>> We don't want higher-order allocations...
> 
> So:
> 
>    (1) We don't want to embed the struct in the hctx because we allocate
>    so many of them that this is non-negligable to add for something we
>    typically never use.
> 
>    (2) We don't want to allocate dynamically because it's potentially
>    huge.
> 
> As long as we're using srcu for blocking hctx's, I think it's "pick your
> poison".
> 
> Alternatively, Ming's percpu_ref patch(*) may be worth a look.
> 
>   * https://www.spinics.net/lists/linux-block/msg56976.html1
I'm not opposed to having this. Will require some more testing
as this affects pretty much every driver out there..

If we are going with a lightweight percpu_ref, can we just do
it also for non-blocking hctx and have a single code-path?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
