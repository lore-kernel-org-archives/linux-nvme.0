Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25AA5CD1292
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Apr 2024 22:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BdWWKfy1sBES+njCUFCe6uvHTcfI8Vhkg1gV5AVrYTE=; b=P90djZL4yxldpJ46tt3zwe46GI
	UI+mUITTTSkr1GShuiPDifW6u6q2XfZ/6QGfl5y6b5xeSbW63lEqqYaMKllcNWfi6FNJ+mRzaUJCJ
	wgpuC5BXaTJOLF/oTko/9ppTx4gxbauVyNBSZDbLi8O6xXZvO05nu/vYslqrMY+MztrmzGGAVArYN
	w+k5sJVIJ4BW+pb7OuGNuW1y5lNeNlIx9vykFElXCkZS4n9o/coHErX7Vcm/WWfHnZaIDMnAqGA2I
	9tt67BrL2yjy//zTMPrs9tgKu9GTZRHwI84jmQ06JipJi08GCr5ihzypRj48ZkkFbAWjTA8BY/nPZ
	E9+SDeug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtatP-0000000DdUv-0IxF;
	Sun, 07 Apr 2024 22:21:39 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtatL-0000000DdU9-1Htg
	for linux-nvme@lists.infradead.org;
	Sun, 07 Apr 2024 22:21:36 +0000
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-34560201517so193322f8f.1
        for <linux-nvme@lists.infradead.org>; Sun, 07 Apr 2024 15:21:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712528493; x=1713133293;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BdWWKfy1sBES+njCUFCe6uvHTcfI8Vhkg1gV5AVrYTE=;
        b=XmRWYda23Hk3OX3eXVaSxBkBcUlrarIrlN9H4Zr/0hlpYLp7928f4rPdQ/xlYFb70t
         o21mw+R2tbOGid2wpufp2J3WC4b6Aiv/M2A5rov5WqHjLNzp8xwi+ZYMqLsLni0TCHH/
         EOddzJXSSTg4JXPZXMyRHtXowmEJXKa+Alt2I8l+bA+eBgQAZRS0aczh8UVs4LHogLu2
         onUUkd0uIiQNYv77KAVAg5+azOOxfWGUI22G27ipP7PG+FsfMg99S+Pdv13ChqwwDi2w
         A3QaanoM47us6NyHOV3Kf5jS/RWGXU7vcyI8DUmneSPvo7Wdw19p0Wgbb2PbZbZDtSht
         ZoKw==
X-Gm-Message-State: AOJu0YyQPGKPyLGj3ChqOa5Zjmbd4HWe4YfgBnBDRFFJReZgc9czAImY
	alJX5l6WT7odGUWUX277cdvg2zq7UbFwyoruBSgBg2z+2VFzViYT
X-Google-Smtp-Source: AGHT+IEj7K1D6DUtOtvrn42Q3upnCYQ72/noTp1nXGbopYW0ZY0mSdk54qaK0Jw2BZ8P3Z5sI6AkXQ==
X-Received: by 2002:a05:600c:1c01:b0:416:2b27:8134 with SMTP id j1-20020a05600c1c0100b004162b278134mr5486715wms.2.1712528493561;
        Sun, 07 Apr 2024 15:21:33 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id x15-20020a5d490f000000b003439b45ca08sm7434254wrq.17.2024.04.07.15.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 15:21:33 -0700 (PDT)
Message-ID: <1efd49da-5f4a-4602-85c0-fa957aa95565@grimberg.me>
Date: Mon, 8 Apr 2024 01:21:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v24 00/20] nvme-tcp receive offloads
To: Jakub Kicinski <kuba@kernel.org>, Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org, hch@lst.de,
 kbusch@kernel.org, axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net,
 aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
 ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
 galshalom@nvidia.com, mgurtovoy@nvidia.com, edumazet@google.com
References: <20240404123717.11857-1-aaptel@nvidia.com>
 <20240405224504.4cb620de@kernel.org>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240405224504.4cb620de@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240407_152135_390839_CCD8DEE8 
X-CRM114-Status: GOOD (  14.42  )
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



On 06/04/2024 8:45, Jakub Kicinski wrote:
> Doesn't apply, again, unfortunately.
>
> On Thu,  4 Apr 2024 12:36:57 +0000 Aurelien Aptel wrote:
>> Testing
>> =======
>> This series was tested on ConnectX-7 HW using various configurations
>> of IO sizes, queue depths, MTUs, and with both the SPDK and kernel NVMe-TCP
>> targets.
> About testing, what do you have in terms of a testing setup?
> As you said this is similar to the TLS offload:
>
>> Note:
>> These offloads are similar in nature to the packet-based NIC TLS offloads,
>> which are already upstream (see net/tls/tls_device.c).
>> You can read more about TLS offload here:
>> https://www.kernel.org/doc/html/latest/networking/tls-offload.html
> and our experience trying to maintain and extend the very much used SW
> kernel TLS implementation in presence of the device offload is mixed :(
> We can't test it, we break it, get CVEs for it :( In all fairness

Especially when nvme-tcp can also run on tls, but that is incompatible with
this offload at the moment (I've told the nvidia folks that I do not expect
this incompatibility to be permanent).

> the inline offload is probably not as bad as the crypto accelerator
> path, but still it breaks. So assuming that this gets all the necessary
> acks can we expect you to plug some testing into the netdev CI so that
> we see whether any incoming change is breaking this offload?

Agree, also given that there is an effort to extend blktests to run on
real controllers, perhaps we should add a few tests there as well?

