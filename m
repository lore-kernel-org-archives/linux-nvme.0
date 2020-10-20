Return-Path: <SRS0=uU0g=D3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B93EC433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 08:22:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1A092222F
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 08:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YWgcZYnM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1A092222F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/Va4vDb5Pm/NtoeYdezbBKoxYoYneeQmgLJRqz95FOg=; b=YWgcZYnMqSll9igGC6AzocPZp
	r8o2Gnim3JGKxtmVs8HcGUnDoUlJl3Lt0MBdb8poDqVIC/cn1HF5q/dbKv1/mMJF81WBzlXngAfzX
	u8kPl0ccZux8BwEjWZGmIpzwOaI0c3ddtEoreJQ/9mypklUWBRTGldZJ5dh+IRG5RUwOnwh8nAmVC
	a3uVM9Dx+AZO+XhBr8XnVAx8WXIrTDsfAHknPa5lBGzuTYD0I8P641pCr3uVixGKP3qC1dbOcHMxu
	XbRr1e9JzEywa/wFfaV2Fco0T3fdA/q6/4z/9vO6u9tVZoWfGL+221C8XNGqm+pCyOnZXLxZtORDH
	FzleN8Kyg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kUmun-0007K4-JO; Tue, 20 Oct 2020 08:22:41 +0000
Received: from mail-pl1-f196.google.com ([209.85.214.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUmum-0007Ji-3r
 for linux-nvme@lists.infradead.org; Tue, 20 Oct 2020 08:22:40 +0000
Received: by mail-pl1-f196.google.com with SMTP id d23so630438pll.7
 for <linux-nvme@lists.infradead.org>; Tue, 20 Oct 2020 01:22:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=z31PekHkikHiJQVMvh1NI0ltaYFmyA4L7i7/yCoq8Z4=;
 b=IEsQCaOkBKpj1HlgStLSsRyj/0CQXqFtXgKXcoA+5MQ/VogGzbP32x0ZAu5NPcybKF
 VZ5/J3W4ze/8YTGLF3Y0D2EZmKg9MMW3D/p0YdXLB6YG2R3ppXGIbbL658EyK8AqhnyQ
 MKe4/LZb7TJX3X8wlpRaFVUTWKanJ5hNSJECm4mpOq+MPNBKiS11GI14k6bOHz5MajmA
 TF1asUruwJllBFSF/8VC1oHkXNbhk9jz8BcVgJDyChVMPqCtDWvgFXSZbrPvaweUMbjA
 SW1P7QxnjS4/2mnj47Kxa3Km3GO0n+UXYojeeqap6avy+pgwlCLlPaDEVy8M8wrryP4i
 GESw==
X-Gm-Message-State: AOAM5329JWDgJTcQx49EbcdWofdPV88PV8p0+r6oLXRnTghdR9SXp8fp
 8FF1vcTmeE2WFRcf9/yHGqw=
X-Google-Smtp-Source: ABdhPJxgZVv9VTdKqBXu1WudiTmukKHl2TxiHFUwWrW/u5XoiIlvfk6nrU73rt02bGs8Tgh7gZQ9kw==
X-Received: by 2002:a17:90a:1b6f:: with SMTP id
 q102mr1830848pjq.10.1603182158896; 
 Tue, 20 Oct 2020 01:22:38 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:104e:47d9:f0fe:a697?
 ([2601:647:4802:9070:104e:47d9:f0fe:a697])
 by smtp.gmail.com with ESMTPSA id p188sm1237449pgp.65.2020.10.20.01.22.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2020 01:22:38 -0700 (PDT)
Subject: Re: [PATCH 0/1] nvmet: allow user to set req alloc flag
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20201020014417.3604-1-chaitanya.kulkarni@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <74e2bc85-3752-08fe-4f2c-07130ab4411d@grimberg.me>
Date: Tue, 20 Oct 2020 01:22:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201020014417.3604-1-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201020_042240_165819_AAC8E794 
X-CRM114-Status: GOOD (  18.95  )
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
Cc: logang@deltatee.com, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Hi,
> 
> When using NVMeOF target in the passthru mode we allocate the request
> with BLK_MQ_REQ_NOWAIT flag. This allocates the request in the following
> manner :-
> 
> nvme_alloc_request()
>   blk_mq_alloc_rquest()
>    blk_mq_queue_enter()
>     if (flag & BLK_MQ_REQ_NOWAIT)
>    	return -EBUSY; <-- return if busy.
> 
> On the NVMe controller which I've the fio random write workload running
> parallel on 32 namespaces with higher queue depth results in I/O error,
> where blk_mq_queue_enter() returning -EBUSY as shown above. This problem
> is not easy to reproduce but occurs once in a while with following error
> (See 1 for detailed log) :-
> 
> test1: (groupid=0, jobs=32): err= 5
> (file:io_u.c:1744, func=io_u error, error=Input/output error):
> 
> When the flag BLK_MQ_REQ_NOWAIT is removed from the allocation the
> workload doen't result in the error.
> 
> This patch fixes the problem with the request allocation by adding
> a new configfs attribute so that user can optionally decide whether
> to use BLK_MQ_REQ_NOWAIT or not. We retain the default behavior by
> using BLK_MQ_REQ_NOWAIT when creating the nvmet passthru subsystem.

Why should we ever set REQ_NOWAIT at all? Nothing prevents the
host(s) queue depth from exceeding the controller queue depth...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
