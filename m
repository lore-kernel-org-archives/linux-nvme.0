Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23296C2BD09
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jul 2024 14:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tuAuOWWq7Ypd3+TNjH6EnR9sPDzWyBmNQbO4eRp3kDg=; b=TPihZO8DbBWI4kSYQk/dOx3RXl
	Kjww8Rx192/dlDxPHVN4ePVRnX40ddQfngbn41jMQsaHEDAjX4Yh2dVx9T4iO/Isxrq8wslLuEs7/
	5k1zfRSKDM7ltFVIdB3mbM8vI3rJpMAA4JANw/zUpLe13Radzfp6D1kwc0KBtn0wUjfwzSK2j5c22
	Y9sFd97hlSt2R8YQZFs7v32VwXTBouNrTZ4CRuEkMcMbNF/r9xMvcvWEfyDXZpYIr2YZZqTNgSScO
	qJBKnSUMZLJc4lC39nJcUGkbAd4vsa3PniGiQwrzECrfnC2iYjqLyCmmt997aMfk2sQhPc2RGconN
	g7+DgH6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP0pp-0000000ARzk-1P8s;
	Wed, 03 Jul 2024 14:19:49 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP0po-0000000ARzM-10sy
	for linux-nvme@bombadil.infradead.org;
	Wed, 03 Jul 2024 14:19:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=tuAuOWWq7Ypd3+TNjH6EnR9sPDzWyBmNQbO4eRp3kDg=; b=AQfDclOcFmjZ/GEn+/7mQ2m+Z9
	k+hSK4b5784frofJiu0peREhlEmwvmqsEIkA6R4qZJfw+JAhpHaVyWRpMFtItshPiLotcDSEzy+2G
	NMKTiJHP581yonUeRwizHZb0dvT/mEVOMQoeOkEu/VpPEsAmaxkuW5zJqwUltAP39C25jWCAOx9Ct
	Y8XuL9YIwXyPTPs8ItpD3O5d7lEQusipyf7MRGmXa7d1rzk69ihJv6crWGG+MBwbwMejpHgE4DR1p
	j0aD26MQVHY75nm/zuTzZZSoLbA0tBXESebHr5+BaOUHDqiO2Hf09LzOQFuxiayCen0VxbIejU6Z6
	Ge7cy3uw==;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP0pk-0000000A430-0jCI
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jul 2024 14:19:47 +0000
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4247102da30so4581125e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 03 Jul 2024 07:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720016381; x=1720621181;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tuAuOWWq7Ypd3+TNjH6EnR9sPDzWyBmNQbO4eRp3kDg=;
        b=uM+nwfaZxyrl4LD8MM/t/gqBCSIVOVtVP4fsq4ueS95zI7s6N1G3n9/4Eyp1FVr2Gc
         1RR2+9rCxpvL09yAgH6x1QctZpjv8gthOOFJyEPbWYaE8JeUZUiseCvnCuuA70/qm93+
         YZF8HCsoOmIHcUSbhI0t+QPZ5aiVLCUgNsL6eMMOV/KLiC0ApMGLC2EdI9XLoVOdIMmf
         XY+nD1Hu9HocdtjGNh487VckAp1p+Yz5JlGM/L5YK2s5Hd/wBnbs9j4at23aDqVCWRrW
         t8LFhZ7ReEF/mmspUQ3AHFGv/MZ6+dzYkz/7JwkQx4OmTEAM/a6WAaQn9oYxDonlG77T
         jBsA==
X-Forwarded-Encrypted: i=1; AJvYcCXVoEgKhn4EhHlaLsDFqexfvEPSgW/ICmRI2OB9SISdoPe3YmBXregWt7huTj0N28sakwhVcpM4DXrtUM3rAoy9CNcFs/nSbNUD1Ubyx2E=
X-Gm-Message-State: AOJu0YyCgLX+a0HTftToZ6SXMwzpIV52j9IoMgHWWHDha2NQrK9zEWuL
	1AdY3DjeTZYL5FHUfOIH02djbP63JnjpwKZL11LPtvt/70DoEnDyyypaxdyV
X-Google-Smtp-Source: AGHT+IFQGV+wcFHsdE8oEBFM7pnROWViuM2CIlfHrNKRnRYO6Pt0ln3NxzTCrJD2U57CAZcnUJ4WJg==
X-Received: by 2002:a05:600c:19c9:b0:424:a74b:32d3 with SMTP id 5b1f17b1804b1-4257a010c08mr86718835e9.0.1720016381332;
        Wed, 03 Jul 2024 07:19:41 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b09a32asm243906515e9.31.2024.07.03.07.19.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 07:19:40 -0700 (PDT)
Message-ID: <b6702586-12c4-4390-9085-2cc6d9fbb462@grimberg.me>
Date: Wed, 3 Jul 2024 17:19:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] nvme-tcp: align I/O cpu with blk-mq mapping
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20240703135021.34143-1-hare@kernel.org>
 <20240703135021.34143-3-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240703135021.34143-3-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_151945_296289_F150671E 
X-CRM114-Status: GOOD (  12.64  )
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



On 03/07/2024 16:50, Hannes Reinecke wrote:
> When 'wq_unbound' is selected we should select the
> the first CPU from a given blk-mq hctx mapping to queue
> the tcp workqueue item. With this we can instruct the
> workqueue code to keep the I/O affinity and avoid
> a performance penalty.

wq_unbound is designed to keep io_cpu to be UNBOUND, my recollection
was the the person introducing it was trying to make the io_cpu always be
on a specific NUMA node, or a subset of cpus within a numa node. So he uses
that and tinkers with wq cpumask via sysfs.

I don't see why you are tying this to wq_unbound in the first place.

>
> One should switch to 'cpu' workqueue affinity to
> get full advantage of this by issuing:
>
> echo cpu > /sys/devices/virtual/workqueue/nvme_tcp_wq_*/affinity_scope

Quantify improvement please.

