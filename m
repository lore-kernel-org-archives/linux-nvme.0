Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49315C27C53
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jun 2024 08:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l1tjxy+P7CgtVuVrdFR+IsmUtqzTJSIiioRuJ4C47FE=; b=stoGpisXJpsRrBop4JwQEkbhRk
	zhqR+YJwT5rCUJfSYJM3QHqYbvgt6fXhM9kaMh310EYw1w7zuYrvQ1duntp89JB0aGdCReeH62ek5
	9Va5bcG//jwngXlWJjbdFa0gCVQItd3tk5G9Gdaac9yTnbReFhLGp7suFxR1IJi6ocPwwhrgENfZE
	qc7X0J1Z5VtJLKBxUIiOAOv8LZ2qYVne+32sFdT7sMQLCouROUPGsCd0J2dbsQAezlvp3uM7Zi3Si
	1lOLd4bK/KoMXvAlVmHAdMQ1qNgcqQvXtj1pinmN2PVFrbDgTujV/jRorB5BupzO8RKKs0IHg0r8W
	OBtKBeQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJr8t-00000000Thl-2Ay5;
	Wed, 19 Jun 2024 08:58:11 +0000
Received: from mail-ed1-f41.google.com ([209.85.208.41])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJr8m-00000000Tgc-1Qyr
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jun 2024 08:58:09 +0000
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57d1594f3a6so35869a12.2
        for <linux-nvme@lists.infradead.org>; Wed, 19 Jun 2024 01:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718787480; x=1719392280;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l1tjxy+P7CgtVuVrdFR+IsmUtqzTJSIiioRuJ4C47FE=;
        b=H1PJj3nPswOU1SHoclJnSYD2o4wjDf35JjfhGpj05wW5JOjsCSt/RUCUu3y2ArzfMs
         EVmTWtSMdAcf5BOdR1DASMmsMkrNEGDqdiD+Tu/lOdzkjKRr56rUGx7oTgAqP49jxmjB
         PF4lG7dD66T+0D39zKKafQx03wgPv2FSDWL4QNnBeDNMaju4SMRFwFYhsK6GKho2jgc7
         StcwvidxKOwmNyEGyWAyT4HQYs5w9/dDsKFOPkRYACxRrHDUKPZN9AEfNmClMzpOan8p
         HLzFTyAePne2TT2c1frgJl2zQdPGq23eCFQM7AW1WJhZUi0ncWUIEOjKi91kyGEQ8Kpx
         IKKg==
X-Forwarded-Encrypted: i=1; AJvYcCXFjccBrjPocjJzf6XBfwLCHFCSI9NjFWrPE766XKOzGHyECNROYw3rrLAXXCnkubHJ4jb6yvgEZBW1pfoo86O4VShLQTCiyyRr7psEzw0=
X-Gm-Message-State: AOJu0YxsAq7gcIk4q2lSgeU/G22TPkbDAxXu/n5bl7POMSrMxfxq5Gdj
	+c1eEYMxYmU99TvVJxpjtfn3u9YpNB+hePo2JlIabWMollbLS7Rf
X-Google-Smtp-Source: AGHT+IGJPcWUVsU8+xjPKDQh5kCCfRM2/CnadLyhTBb6wuqzuD11QDadNQ+ZstvBU0UjEqKW7W+t1g==
X-Received: by 2002:a50:c35e:0:b0:57c:6895:1de9 with SMTP id 4fb4d7f45d1cf-57d07ee6006mr870774a12.4.1718787480097;
        Wed, 19 Jun 2024 01:58:00 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72da785sm8200734a12.28.2024.06.19.01.57.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 01:57:59 -0700 (PDT)
Message-ID: <e8d5e591-0f19-4cc8-b7a4-9d6a5687b019@grimberg.me>
Date: Wed, 19 Jun 2024 11:57:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-tcp: align I/O cpu with blk-mq mapping
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240618120345.64761-1-hare@kernel.org>
 <20240619053015.GB29159@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240619053015.GB29159@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240619_015805_019683_A5089952 
X-CRM114-Status: GOOD (  12.74  )
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



On 19/06/2024 8:30, Christoph Hellwig wrote:
> On Tue, Jun 18, 2024 at 02:03:45PM +0200, Hannes Reinecke wrote:
>> Add a new module parameter 'wq_affinity' to spread the I/O
>> over all cpus within the blk-mq hctx mapping for the queue.
>> This avoids bouncing I/O between cpus when we have less
>> hardware queues than cpus.
> What is the benefit when setting it?  What is the downside?  Why do you
> think it needs to be conditional?

Not entirely sure.

Hannes,

Can you please show what is the hctx<->cpu mappings before/after this
patch? Please use different queue counts so we can see the pattern.

Can you please show any performance comparisons for low and high
queue counts?

I'm not entirely clear what exactly "spreads I/O over all CPUs" mean.
Every nvme-tcp queue has an io context that does network sends and receives
(unless it goes within .queue_rq() context when possible). Does this 
somehow mean
that now a queue io context will run from multiple cpus at the same time?

