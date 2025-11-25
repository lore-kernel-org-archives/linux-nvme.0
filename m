Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DAFCD0E6D1
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Nov 2025 12:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=siB9qFjab8fX+nGosH2txh4HIYoNVo3aqhU42WS03o0=; b=kgFCAcszns3p9p6YVtLYF03nel
	ftu+vJiA7I7unIr1jxp0MPV49T3JJEwIkmtFT8f8zdmWLvlDwKYDD924zzBYyLihfMad3JD1JW3EP
	VkkfAMXoXG20xvseQGkZM665fJAO8O0LNdUD97m5ScpQSQF9zchtHFo9l9iVhuipA5vJk85teQvjZ
	mNb+5O+hX1qpM+YBM/w1sGqAq1H8RdKGraoBEQswLeEclgzmx1O0Y9y4FZ509iC4mAEFT2EsfnUID
	KnzMYSYIwJV4fr93fjlz5qZ4vP6WiMZNTwuXsjPt5/SYW61rfGOzHSu5vSFjosp8S5NFrt357JjlN
	b0j6Lt3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNsGI-0000000DHze-2yb2;
	Tue, 25 Nov 2025 12:35:14 +0000
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNsGF-0000000DHya-2w9J
	for linux-nvme@lists.infradead.org;
	Tue, 25 Nov 2025 12:35:13 +0000
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-47790b080e4so29023725e9.3
        for <linux-nvme@lists.infradead.org>; Tue, 25 Nov 2025 04:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764074109; x=1764678909; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=siB9qFjab8fX+nGosH2txh4HIYoNVo3aqhU42WS03o0=;
        b=O239Yc5eBubAokhG62GlUV/iFcpdIzd6pWnEzOlK8d3VvXNDWadbkhmJNeck6WULf2
         zPM/dbMQnDibXHk9O1uQIfJnzCYP5xhQYGRscXVQBoBdAbzyJowyk+hl8Pbb9T6Km4QD
         ea30NRVl4+aUc0tlLoMIpJY+jBJIgNMPLKVKjfbuJGTudUdyoQiJkoWhk4pcwN3EnhEA
         k5GU2bTJyNDRc6PL32RbpDMl/xV3xAQ2FWnNqEvir81QOaa6T5A7L9mzxf2vEiGrMD5H
         WflhEwr1Hrlj3tScRrgEefAYRqCy5cv0jk83yCXnbUsEDPxiWa0PcoW/rR1Xbr6gyAh4
         4ssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764074109; x=1764678909;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=siB9qFjab8fX+nGosH2txh4HIYoNVo3aqhU42WS03o0=;
        b=E5/hWw2LoyUiNAb9ZsTY5gOnwToVtKjOw+aVDh6JR++oqMdEDZiEgflMH2+bPcXf2V
         IJIUx6DfFIfN5KPuCVrk7BnWdoYV1edUnY4d7AO6zDtGJoVKwKwGvYyjNwL0nznRt8ct
         D17nMOQM7yTvREgAGFwyja3F/nYWR7svBFA8KqU5Xxi/ODYPVGRUFMfe+oRVA6lvt9HB
         LIYyzU2Sw0jMBv2mU1DZK7svybrDbPVcwY/UrgAVheTiAw8MRQ40ng3lFEiElnjEoYS8
         ZrDvgXWJnLQMAJgB+dx+UXCh8X6fk2VXzxdsrsIiWKXLcQf09H9JtxXDVT2TCgKbarMX
         nCpg==
X-Forwarded-Encrypted: i=1; AJvYcCWxM0YgFIKjmR8prbBM71G9qECF+ab6cDlR3sVyP1BJLLs3mpyNHIchdFfaIuySgxk7WaXaAmgExo2t@lists.infradead.org
X-Gm-Message-State: AOJu0YyxRAVKD0ZSFvvF2QVsphHqUgVVyggcpNYpKLeX873sADi8wgRc
	G/YztT6pCpr7cfOB4XjACdMH+sYHjZVVMGN8UuFHmT7ZZeEV31gqrdRI
X-Gm-Gg: ASbGnctOkfjzFaPI0VQfOs7KvdrvwplXYhdMCFhn9BCGpt2YfPu9zM0gCQ5xUxCgHJx
	5CziVE2lvdQm63iCMhvi0yGy/aNyw5cQ1yaBjF6PRJRIcyt9eFbrA5yhs8DgwqatpC+phGBhb82
	hAUjUq9mSX+NoNL/QyRa2gAgLEML4giD/42inim+1xMmRTCnM9NvB9S+NvsflBHVwl+YQlYTops
	CGVaBrdwdwZJNsU7J4QhtFhN7xHIDZ6oNgQ5GT3CtqLXkeGA4PDb2c1tv8bj7jIxAYtrsIworqW
	1MtieqrG/DIwd0cU5qBnPKCxomWmBy68cAj1OBcAd3BckAPtUJOce2ZqceMyYjw4b2BonYS/xeJ
	uuYX1nkg78MZtaht70jKOAu20PZRnFr3rcn9TvcY0ABM1OlDjh/w2krR52JTLm0rRoJ9kMpOZsZ
	FPa3MAUSPAWsCWSPjW815GQDpQT+YYY08XvifA0dZm+/QOoYb3p9Sn0PBsZGos2Q==
X-Google-Smtp-Source: AGHT+IGiAByXWX/VuXJ575rRIj6bTeEbAlnebab6FY0vB4jAmRqS6rohlKvvoUgeChvVCplBX1c2lg==
X-Received: by 2002:a05:600c:1d1b:b0:477:9671:3a42 with SMTP id 5b1f17b1804b1-477c1133e4bmr159739175e9.35.1764074109236;
        Tue, 25 Nov 2025 04:35:09 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb919bsm33941871f8f.34.2025.11.25.04.35.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 04:35:08 -0800 (PST)
Message-ID: <1f8b5e97-1f3c-46f8-8328-449c159b7d66@gmail.com>
Date: Tue, 25 Nov 2025 12:35:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 00/11] Add dmabuf read/write via io_uring
To: Anuj gupta <anuj1072538@gmail.com>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org,
 Vishal Verma <vishal1.verma@intel.com>, tushar.gohad@intel.com,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
References: <cover.1763725387.git.asml.silence@gmail.com>
 <CACzX3Au7PW2zFFLmtNgW10wq+Kp-bp66GXUVCUCfS4VvK3tDYw@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CACzX3Au7PW2zFFLmtNgW10wq+Kp-bp66GXUVCUCfS4VvK3tDYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_043511_778609_D595EC05 
X-CRM114-Status: GOOD (  11.92  )
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

On 11/24/25 13:35, Anuj gupta wrote:
> This series significantly reduces the IOMMU/DMA overhead for I/O,
> particularly when the IOMMU is configured in STRICT or LAZY mode. I
> modified t/io_uring in fio to exercise this path and tested with an
> Intel Optane device. On my setup, I see the following improvement:
> 
> - STRICT: before = 570 KIOPS, after = 5.01 MIOPS
> - LAZY: before = 1.93 MIOPS, after = 5.01 MIOPS
> - PASSTHROUGH: before = 5.01 MIOPS, after = 5.01 MIOPS
> 
> The STRICT/LAZY numbers clearly show the benefit of avoiding per-I/O
> dma_map/dma_unmap and reusing the pre-mapped DMA addresses.

Thanks for giving it a run. Looks indeed promising, and I believe
that was the main use case Keith was pursuing. I'll fix up the
build problems for v3

-- 
Pavel Begunkov


