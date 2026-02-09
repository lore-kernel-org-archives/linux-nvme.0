Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37FAE7E0C7
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Feb 2026 11:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3wbG3Hwlnnt7XslslOQ5Ajzf6jd6ChHMQtwpqlWp/yk=; b=QFNQZn9Z9iFAZyzM5CzU5L85na
	G8ZoRMEuVim78PgVQOI6m/j2+JU5cFS4y1JnuWBE8XXr7adUESjoF42MoPIIo0YzZ98R+R5BYsksi
	CjZhqFVFdsHVmq5ePkzodKsjBwRKmrgZdy7RizQm90Cf4t2UQQVuwmKCflpmic6KHPMuEl0Osq96L
	9uyHeTgZsHj3XFGNPhbMR+3xYrBz8axZ7iHlMn6MKoCtn8khDUhj/AIekcLCAk4ijesTl3TZIsuM3
	VbXZnTnRoQsm2F6HeNMSiH7qCNFOVdnw1fOMBic/tHANeEVM28kRtfVX9USlh72EvWyjPEVj4oWgo
	s3D4oHbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpPEk-0000000FHZp-3jvH;
	Mon, 09 Feb 2026 11:15:26 +0000
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpPEj-0000000FHZL-0HCf
	for linux-nvme@lists.infradead.org;
	Mon, 09 Feb 2026 11:15:26 +0000
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-436e87589e8so1095647f8f.3
        for <linux-nvme@lists.infradead.org>; Mon, 09 Feb 2026 03:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770635723; x=1771240523; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3wbG3Hwlnnt7XslslOQ5Ajzf6jd6ChHMQtwpqlWp/yk=;
        b=CW8j69dh0o5imRHD3nfZZZcbCBqPx9S83qajT+prWGMm/bBRrhOaNWoKN0vcwq6EK0
         Td77B2kV+WptWaCcv26zqBnIvjo94g3v6u2BXxwNm0rXsHxljGUIz64bz2S71baEdrBN
         DS3HhOC8QJPdn5suUtzZiQ7Yf6MEpMjdhqaFySh+Xh14DHkJ6EwxbUltv4FZSY5U9qdW
         hZv9scUNVV12/gG/XFE+fzFamM0CFX8pGRqf31UYuMPyxphY0tzn7RymKDCwXhtnw6cn
         Uz+5HuezF+/RJ5aQV5ydJpKGShst/InnjfPKh6xwo2xErMTvI2PUy3RMpjPuvMLxeevG
         JRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770635723; x=1771240523;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3wbG3Hwlnnt7XslslOQ5Ajzf6jd6ChHMQtwpqlWp/yk=;
        b=A5HioqRMntR6tjJntbzm4K968Wo36yvN5vOEIYmu9TwrwFjq+7WoFt2tfEjOHlmlVt
         fq8YQsRDjbBW+x57T8SBzDb7VpAQxYc8JRJwkXm+YbLK6i/wY/Nz4HGwGyRwSk+p78zT
         Wv3g5YLHAeytKyFzvVFTzLpRGDHUMQUyTo06do01A5JGgrdKB8J1PvkkbZ1uoOXnXeEc
         UOhcNylRZdLgN8aokAozUm17wBvZeipUHHkwoQ6hMHpqjZLl8Lz/aJtQf1Hx2S0fPShn
         GqH/4cscXfZJJmKaR79zTkGKuPMm8kEYYm3n0KhAEkd8wqPdTpFgkNR/CwSEysF1kkxi
         1Elw==
X-Forwarded-Encrypted: i=1; AJvYcCU5KoMClEGSYvQHPJ8McG/DiIbRhfpSrs8vxpWc1s9OgED7EjyiqozApjTkH9QbiU6uPdy8J6vdPMaQ@lists.infradead.org
X-Gm-Message-State: AOJu0YwVabyGR7nFPpvAkP944RZdF755NyiWlvgsEpo6s1CiVhscx5m3
	tJ2dDzx/PE7u8b1csg6tJUuwoKs27UbNv5LcTg8DoM8/DGOFG2RV9pLO
X-Gm-Gg: AZuq6aKFT3qH5zIvr14bdkHaK/aIDr1X70ho7yX4KTeSmyKWy5boRr0dWEhYjySXlF/
	Ak8ic7YR/LSEo6wyN3v5SHxvvWZYRtX/X3Gz3EVSxkLJCVpRfGIPd/A6lLRzD4Df/YSPykSGATP
	eoFrAh44BCTDsmO5u9KL0xiU0Hqjf3yrSwqSmjGD5VzqxxjZhJKTLuRzrM3ofUAM/11mvepsGj/
	wgpSxZ6LvEqYOcimvyepL5RCWRARMfFbVPTPw+VieupQhF1hoNNye4M5uDvVIsBTpOtqXx02VIB
	H7p3ok4/0GaZ3RxQvI4/Ig0mLi/J6ybk2SuGBhNOMt7st/6F5ucArmSV3IGoiYFF5vMDR+yuAsr
	5aTvF3No5Dz+VaDbmuTFU6urrzlLQJJ+mq4WdymuFKeh3mCfJNmkfzhUtJwsn5H0pxD1BVDxUkG
	wh4JdIksSnGwgaVH3lxyY4n/fSEAlEXUE6FrsQPP8YT3rYnnI6/pC3B/ocr1v5k1I469Q+IBGEC
	5i9gutB5dUG3W0CVsrvuNmKtpr7nkbSf86q8LWtsa+UbKc=
X-Received: by 2002:a05:6000:2209:b0:435:9241:37b4 with SMTP id ffacd0b85a97d-4362938ffe3mr19185555f8f.53.1770635723028;
        Mon, 09 Feb 2026 03:15:23 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:9b67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4376806626fsm12638100f8f.37.2026.02.09.03.15.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 03:15:22 -0800 (PST)
Message-ID: <76299bc2-4871-4571-bef6-9886ee0d2c5f@gmail.com>
Date: Mon, 9 Feb 2026 11:15:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] dmabuf backed read/write
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: linux-block@vger.kernel.org, io-uring <io-uring@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
References: <4796d2f7-5300-4884-bd2e-3fcc7fdd7cea@gmail.com>
 <CGME20260204153051epcas5p1c2efd01ef32883680fed2541f9fca6c2@epcas5p1.samsung.com>
 <20260204152634.gyybb2axszwpewrk@green245.gost>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260204152634.gyybb2axszwpewrk@green245.gost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260209_031525_128269_6AA2C938 
X-CRM114-Status: GOOD (  19.67  )
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

On 2/4/26 15:26, Nitesh Shetty wrote:
> On 03/02/26 02:29PM, Pavel Begunkov wrote:
>> Good day everyone,
>>
>> dma-buf is a powerful abstraction for managing buffers and DMA mappings,
>> and there is growing interest in extending it to the read/write path to
>> enable device-to-device transfers without bouncing data through system
>> memory. I was encouraged to submit it to LSF/MM/BPF as that might be
>> useful to mull over details and what capabilities and features people
>> may need.
>>
>> The proposal consists of two parts. The first is a small in-kernel
>> framework that allows a dma-buf to be registered against a given file
>> and returns an object representing a DMA mapping. The actual mapping
>> creation is delegated to the target subsystem (e.g. NVMe). This
>> abstraction centralises request accounting, mapping management, dynamic
>> recreation, etc. The resulting mapping object is passed through the I/O
>> stack via a new iov_iter type.
>>
>> As for the user API, a dma-buf is installed as an io_uring registered
>> buffer for a specific file. Once registered, the buffer can be used by
>> read / write io_uring requests as normal. io_uring will enforce that the
>> buffer is only used with "compatible files", which is for now restricted
>> to the target registration file, but will be expanded in the future.
>> Notably, io_uring is a consumer of the framework rather than a
>> dependency, and the infrastructure can be reused.
>>
> We have been following the series, its interesting from couple of angles,
> - IOPS wise we see a major improvement especially for IOMMU
> - Series provides a way to do p2pdma to accelerator memory
> 
> Here are few topics which I am looking into specifically,
> - Right now the series uses a PRP list. We need a good way to keep the
>    sg_table info around and decide on‑the‑fly whether to expose the buffer
>    as a PRP list or an SG list, depending on the I/O size.
> - Possibility of futher optimization for new type of iov iter to reduce
>    per IO cost

There is a bunch of improvements that we can have on the NVMe driver
side, just take a look what Keith was doing in his series ([2] in the
first email in the thread), that looked very exciting (I dropped it for
simplicity). I was planning to take a closer look at optimising the driver
part after, but if someone wants to take it off my hands, it'll definitely
be welcome!

-- 
Pavel Begunkov


