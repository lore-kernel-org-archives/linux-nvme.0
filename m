Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF12AC7EE2E
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Jun 2023 07:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/PzqaUj0KXpeFHmG191C5TSVlWT5uRyMYPWCV87ahZA=; b=2WcnPe7r69sBWlniZAaJOptcKO
	8w1g0O159yFlKETpJ2cxcFHX3sQYJYh3yGElpmOMBKWflgpJOLZNYdkS//5UtY1UV+oII92MZI2K0
	9jPh7WaTv+TPhMISkGnTceSySDTU9CNlKSXm0J4lExsWYT8pWnPLw7kv/x4EGNJhRO+20Wq4y6mtp
	o9e8KzpkBWnaSUnKZJ4wP/jQXaQF9MOfJZpdXlq57CQicyDjX+S9ePo+C5jPA4icEjEaS6ORm4Xkc
	ra8AB6mfxKnoaZGe9fKJU6zC3WqwG+58QUN9dBK/XIIH4xGUba1IlY1jyo033oYB5NhCDE60y56rz
	cfZVBnkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q79f2-008L09-0N;
	Thu, 08 Jun 2023 07:02:20 +0000
Received: from mail-lj1-f172.google.com ([209.85.208.172])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q79ez-008KzL-2H
	for linux-nvme@lists.infradead.org;
	Thu, 08 Jun 2023 07:02:18 +0000
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2b07762d292so80501fa.0
        for <linux-nvme@lists.infradead.org>; Thu, 08 Jun 2023 00:02:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686207734; x=1688799734;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/PzqaUj0KXpeFHmG191C5TSVlWT5uRyMYPWCV87ahZA=;
        b=jxXvFQa3NPTMcKOCYJY3WB5P1NyqVpG2KLo4HtKcH+cBRYapJWPVcB996VWSIXrcPf
         r4sYNa5w8P5GX0RFUCMaRrS5KkYp9MnYiZyPwEiMLbrb++zP5/JhOuhy/kN3Fc5DJ7Ui
         FOGTcEaN664Ad9DTvu8kF1TSOqOn1nxBdCK4PztiJAW+c9OVDL9GfHD0aL9gxCZZ7l1o
         o1qf1r0RbzSY3/ubjyfp/WGCivUc42zlACbNgOGiMiVQreMOzW4lMrDNw/ljfCIooxRO
         P3/iz4Fe7Dm87HpVrXLs6VAeAYg2QrsonUPM9lWVvONh/s95s7eQVKPFyhYQk8GdWP6Q
         UeGA==
X-Gm-Message-State: AC+VfDyV98l+I4UFYhwfYvqvvezVmBl3O9IetYLy8AGoPLJIcTjVSM5w
	FNnEcu5WAW8n39i4G7Q8Nq482tTZJSM=
X-Google-Smtp-Source: ACHHUZ65kYOvk0CqwJ1Fv5xn4y5s1ltKIpaTjXavcDBxzalHcMzR9C5rPPp9MiAStDiOOEEd6BsIHA==
X-Received: by 2002:a2e:b639:0:b0:2b1:b741:7500 with SMTP id s25-20020a2eb639000000b002b1b7417500mr1405140ljn.1.1686207734102;
        Thu, 08 Jun 2023 00:02:14 -0700 (PDT)
Received: from [10.100.102.14] (46-117-190-200.bb.netvision.net.il. [46.117.190.200])
        by smtp.gmail.com with ESMTPSA id k26-20020a2e241a000000b002ad8fc8dda6sm118013ljk.17.2023.06.08.00.02.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 00:02:13 -0700 (PDT)
Message-ID: <ba51ceb0-a257-392e-837d-f0899b6c6fd8@grimberg.me>
Date: Thu, 8 Jun 2023 10:02:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] nvme: print disposition on err req completion
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 Amit.Engel@Dell.com, kbusch@kernel.org
References: <20230605064933.46933-1-kch@nvidia.com>
 <20230607050059.GA19879@lst.de>
 <a8f3f9eb-7267-219e-f6cc-f36c0ca56080@grimberg.me>
 <20230608055320.GA11784@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230608055320.GA11784@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230608_000217_746865_0CC767EC 
X-CRM114-Status: GOOD (  11.10  )
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


>>> Hmm, not sure this is the right way to approach it.  I'd rather
>>> redo how the trace points work by having a class and the ondividual
>>> tracepoints in nvme_end_req/nvme_retry_req/nvme_failover_req.
>>
>> :)
>>
>> This was the original proposal (posted as a question to the list),
>> and I proposed this approach. You don't like it?
> 
>   1) the different dispostitions are really very different events,
>      lumping them up does make tracing harder because you need to
>      manually filter every time

True.

>   2) I really don't like exposing the disposition enum outside of core.c

Don't think its much of an issue. But in any event I agree with having
different classes for easier tracing.

