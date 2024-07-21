Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4F2C3DA61
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Jul 2024 11:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jRTNVA0hrrTGGlNMnedMlTjxgz8134922UjhxbdxbXI=; b=O47zGt8I/3caELnyXHvVkHoUx5
	L5L410gKTAWhDLMYDzG1MnojcQ66nNcJQfzfNRemYX4CXwC2GXKmwK7CAwZXpqNv3qrtdDJpONazI
	XsJ0ZYVzKRc0XLKYFnQeIbPlGGlDGYz3SkSO77jT9mlpGVMLTp3XICMaWj2X68dZsOj96DN6BkqAC
	mNk7y1PuzWNxoBGKKO8t5Zk/m58TCP1063GF0qHkIoTej+WJ7mfL4yWtar930l0wwGEtI1p8dc1SH
	GCslkz1ZlcVmDqjZSXAuEHkCzdbeMfup76LPrKe5kTSKg7J6zfieZHxadyOzwRhNzKRaIQ20MxzfJ
	abZgMOTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVUM2-00000006gdB-0PE4;
	Sun, 21 Jul 2024 11:03:50 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVULz-00000006gce-3JB6
	for linux-nvme@lists.infradead.org;
	Sun, 21 Jul 2024 11:03:49 +0000
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-426593b99daso2986535e9.1
        for <linux-nvme@lists.infradead.org>; Sun, 21 Jul 2024 04:03:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721559826; x=1722164626;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jRTNVA0hrrTGGlNMnedMlTjxgz8134922UjhxbdxbXI=;
        b=sVpj/16xy12sgCH9S0fQB7t9RNKH98THMDbOtZmq7INsmgA7cfi96P+1/tJm9iFneO
         2qVhPCDUfQuFVzA4498PSBLsChz3bZYl6C9bU+IHWiPdphxIkCnhYd2k6miDPkkaLQvX
         Y2v/AelbIQzaAgWfWOtRe8hxxaM9akGNzyrQSLPIMBeGs5gxNE1PQNz4AYZEJJ0MXdNs
         C4J3v2eaNro29m7nNAdCVBcnd8bEOLRoGjt4+3qFqvTFEwZknDdLVfO+hxh8D3hjRVBI
         HH2F3gM3+QwzMuATQ9Up06j2LVXWAIsKcVY0cP73+ZbhH9HFsfiqjlZGkwWMKqVCzqqq
         bStQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuMwNzt9b4W+gqGKlahnM1nyZc1+eveqHBsmJSmbsWNpbL5xkYp6RJWP2aPjmtr4Vd/vsbob6rkJTQxqFyH5UJTquYP7oWtyO3bubM1UY=
X-Gm-Message-State: AOJu0YwZihScILFassHmP+bshYeLOVz1V/e8fmMkB5Ka+DDjAZDDaY40
	aOd/eZSPe1BmjAJQB6YhVsJVz+ALnLBJ1fEFowxj6imKVZBDv+D1
X-Google-Smtp-Source: AGHT+IHBdD8Pzny25jyW1tkHaPWCBvyiMEds++6BdmSyMQpzQ0KW5gFznV0rwpP85kwO4sgqmwwf8w==
X-Received: by 2002:a05:600c:3542:b0:425:6962:4253 with SMTP id 5b1f17b1804b1-427daa683eamr20436505e9.4.1721559825450;
        Sun, 21 Jul 2024 04:03:45 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d292077dsm115652825e9.0.2024.07.21.04.03.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jul 2024 04:03:44 -0700 (PDT)
Message-ID: <196a9f11-ba97-4c9c-9815-0ddd0cb50808@grimberg.me>
Date: Sun, 21 Jul 2024 14:03:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] nvmet: use unbound_wq for RDMA and TCP by default
To: Ping Gan <jacky_gam_2001@163.com>, hare@suse.de, hch@lst.de,
 kch@nvidia.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com
References: <20240719091959.17163-1-jacky_gam_2001@163.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240719091959.17163-1-jacky_gam_2001@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240721_040347_863888_331AF88A 
X-CRM114-Status: UNSURE (   9.70  )
X-CRM114-Notice: Please train this message.
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




On 19/07/2024 12:19, Ping Gan wrote:
> When running nvmf on SMP platform, current nvme target's RDMA and
> TCP use bounded workqueue to handle IO, but when there is other high
> workload on the system(eg: kubernetes), the competition between the
> bounded kworker and other workload is very radical. To decrease the
> resource race of OS among them, this patchset will switch to unbounded
> workqueue for nvmet-rdma and nvmet-tcp; besides that, it can also
> get some performance improvement. And this patchset bases on previous
> discussion from below session.
>
> https://lore.kernel.org/lkml/20240719084953.8050-1-jacky_gam_2001@163.com/

Hold your horses.

This cannot be just switched without a thorough testing and actual 
justification/proof of
a benefit beyond just a narrow use-case brought initially by Ping Gan.

If the ask is to universally use an unbound workqueue, please provide 
detailed
benchmarking convincing us that this makes sense.

