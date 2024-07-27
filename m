Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B5AC3DA61
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Jul 2024 19:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DlMdTsmUFokqx/Eb09JUvpNkJPryOUF+V7nVexJI/YA=; b=3eO3dOIkSrFjgpswi5LHJDdFwd
	Km0rqOeE5m8xwaeB25vDpwbi9UxVHq6C1Mf6nF0hzGOAIZzjScf8wPSsBcWUg5ZIZ5RUNvXAkKEDt
	c3I1fdek9hXu0W8umRcpmPKAHATVadPBjAildYRtWu8rO3xAxk7msOUcg8ZodfEOsbY3AzNuWT/na
	acAKXyfHA6H2wmtbVH29hIwI8XMvqp8Kmasws4st/PhBcGWS1qT24ZZYrzjO1QiantqtdEJoExNya
	v4qaZUK+Xdqv88rymQM+YfSoypOnmz9XG24kKq5p3hf6SyZzcc1Om6aew+gS+kfJDQgrX2pVqtjAl
	lIyx7uQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXnDM-00000007Aw8-1Eag;
	Sat, 27 Jul 2024 19:36:24 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXnDF-00000007Avb-3nZF
	for linux-nvme@lists.infradead.org;
	Sat, 27 Jul 2024 19:36:19 +0000
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-36874fa319cso75242f8f.3
        for <linux-nvme@lists.infradead.org>; Sat, 27 Jul 2024 12:36:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722108975; x=1722713775;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DlMdTsmUFokqx/Eb09JUvpNkJPryOUF+V7nVexJI/YA=;
        b=AQuNZkWzOgUNp2qu7LGlsHzVkBCzLPOUYg6/es1GCZtZuviOKgHGo5wnAK8PhtUmib
         +GqVSaiTiwJbpXkvfSwWMqZ3LxKUzFfbegpozSoRROPgOrwR2mwF1w1jIOKvux+PEohv
         z70vVYys75ZbXv+7+4R/W8fyC0tAgxvH025Zhjy+wIgPh/dIVZbFZkclCueiY/3XqIsy
         V9+oTsISHDfjyZcM5Z8N99fywn00OCqr9RFccY35JE8mYq08Aacpq0k9PYcrbQUzJdpr
         DHUpRvjkNVc9UoHVTgyQA4cXALa/zH3YMVtayz9z1MjdUUtkM9ZcYtTw59znMaKUAfFP
         YjEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV1laLj7DQp+e9+ZW81GQbMSe1ryosxyvEXRvovXyB5b0/DQ2ey9GOYn8zQy/uRclh1skHw2WkSJYOmIJXdFHsnT/IpxfJhjnFmud66cY=
X-Gm-Message-State: AOJu0YwrobZ2qak7fY7Z6T7iQiGtYQteEPcM7J9X+BJNonLWX6n+a+gD
	55zEG+edej+tnZfgluce/J2RMl7Ysj1PFzo4GFLqAZcrX7O3Vc9P
X-Google-Smtp-Source: AGHT+IFSxo0NeI4SAM2zvcQLJljvk9476RSvfduNYJLjNUHAzz8CxVLDNaymo6Jb2pnYEb9C+0RwKw==
X-Received: by 2002:a05:600c:3b87:b0:426:5f08:542b with SMTP id 5b1f17b1804b1-428053c9c55mr42902505e9.0.1722108975225;
        Sat, 27 Jul 2024 12:36:15 -0700 (PDT)
Received: from [10.100.102.74] (89-138-69-172.bb.netvision.net.il. [89.138.69.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427fb7bdfa0sm153589165e9.14.2024.07.27.12.36.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jul 2024 12:36:14 -0700 (PDT)
Message-ID: <b3592bca-015f-451e-b689-8db820cbc7a6@grimberg.me>
Date: Sat, 27 Jul 2024 22:36:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] nvmet: use unbound_wq for RDMA and TCP by default
To: Ping Gan <jacky_gam_2001@163.com>, hare@suse.de, hch@lst.de
Cc: ping.gan@dell.com, kch@nvidia.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <196a9f11-ba97-4c9c-9815-0ddd0cb50808@grimberg.me>
 <20240726023407.70799-1-jacky_gam_2001@163.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240726023407.70799-1-jacky_gam_2001@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240727_123617_984428_084585FB 
X-CRM114-Status: GOOD (  12.56  )
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




On 26/07/2024 5:34, Ping Gan wrote:
>> On 19/07/2024 12:19, Ping Gan wrote:
>>> When running nvmf on SMP platform, current nvme target's RDMA and
>>> TCP use bounded workqueue to handle IO, but when there is other high
>>> workload on the system(eg: kubernetes), the competition between the
>>> bounded kworker and other workload is very radical. To decrease the
>>> resource race of OS among them, this patchset will switch to
>>> unbounded
>>> workqueue for nvmet-rdma and nvmet-tcp; besides that, it can also
>>> get some performance improvement. And this patchset bases on previous
>>> discussion from below session.
>>>
>>> https://lore.kernel.org/lkml/20240719084953.8050-1-jacky_gam_2001@163.com/
>> Hold your horses.
>>
>> This cannot be just switched without a thorough testing and actual
>> justification/proof of
>> a benefit beyond just a narrow use-case brought initially by Ping Gan.
>>
>> If the ask is to universally use an unbound workqueue, please provide
>> detailed
>> benchmarking convincing us that this makes sense.
> So you think we should not do a radical change for the narrow usecase
> but
> keep the parameter to enable it in previous version patch, right?

What I'm saying is that if you want to change the default, please provide
justification in the form of benchmarks that support the change. This
benchmarks should include both throughput, iops and latency measurements
and without the cpu-set constraints you presented originally.

