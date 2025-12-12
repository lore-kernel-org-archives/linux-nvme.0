Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C522FD4921D
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Dec 2025 12:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0MYIqEU+bfn7QmwobWbuwolTxN6vEjwiA9gUNqYU9m0=; b=eVu9LmS0TR71ExmSFDbZ0fnJ13
	SxX1/jiCc8jZvAuoal1qh8Cj38+DV+YVWticS13Q79z6UKVyGK/ArUkfnRCtXmOkgp3nvor7ydIBk
	6Tv+AzvsvYtOWNW8/pHGiMtY/W9Ht0Ap/v4q1prIct9JY2MUZZE/pWqkH58EWZbXnD3N3OeQOMEuD
	eKe73BS1wJMaUOsq4P458w6ysJTFAZfZx4zeCdOSCoqC/cVzmMC1FL6oKCHzm0JuYKsUUkgYvRXd0
	dQx2U5fOXd9txoNHSaZSzni3DrxZ+gvEu4oKIndiHJ7Ad5h3A+pNnV6g+x6wwH8SjUTTQYnWm90Pu
	fTrhXArQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vU24x-00000000VyL-3zto;
	Fri, 12 Dec 2025 12:16:59 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vU24v-00000000Vxz-2fS8
	for linux-nvme@lists.infradead.org;
	Fri, 12 Dec 2025 12:16:58 +0000
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47a80d4a065so8395525e9.2
        for <linux-nvme@lists.infradead.org>; Fri, 12 Dec 2025 04:16:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765541816; x=1766146616;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0MYIqEU+bfn7QmwobWbuwolTxN6vEjwiA9gUNqYU9m0=;
        b=j5by2sfrvXXBbESGuAPw8uX8RR8dl1uhYiiJDkX3m+MLmRdpgZijd//93lWOeINl9U
         LZXyg8HUeyNXji2KbYBUgYy+SbbLo8R96yuIFBLF19u3BWvx4pD/n26HHsR/Urn6WAWi
         5UbyMn9L4fK1QEDXMzbiuYU5KygqUOAP36ccRBS0SDHKUVBAljKq6yGqfXS3XuMHiaCk
         lG5L1r/nnPj+4LWjzvRidFKHe3lkPN50wEF8L0Tm60TKDrSysqs3yhBcHRvKi/ligjRp
         CsGrMtI3yQvD3REB0sgayE9YUAREHvIPqxPDrvrwKvZ+Gg0tshp1ezSC0z/b/HA/XtLm
         XEpw==
X-Forwarded-Encrypted: i=1; AJvYcCUkHrUSKqZ/N2TvqB1NCSb+ip/WpHxRpZJy/fEKXhCq8Deg2D2udawH+kTNxKkGpdklDYyaDpvd82vl@lists.infradead.org
X-Gm-Message-State: AOJu0Yw3bd0Q/uHo6miS+7P5SK1gQA8HU6xOh4oI+ibS2JzQHUkELtMw
	q9zy/DXoQhFsJlfpCqAOMmuB21Ebmh7SKCEBckDgfSZSmGFmAXZh4lGo
X-Gm-Gg: AY/fxX4S7B9CiYa4xrMDrPi9mwyWB9FtDdu4mVoq+hblAVJoE/8X87Vi5ksexeKY5Ua
	BPWgzWBBLxqH7YOKXsyh7il75TbGMWuZNMAKxCtW8WShFonSidjT13XuJ6Ep2zNde0G/1Ubq2k3
	zRPWUr5TgOc7/7K+H6AfJBz9rqMg1+MqJw5CfBmH/HaeLKg5IW5akOl+Mz+9HyXythlgjpo4+Rf
	BKHaGwz6ZDQmdPzzlk/Z4cC+jYQtxfOz9oq6c8pMT2b5PQIGXeY8Rajlhd56vDC5gMDdQeGwDUN
	2RNOI2hBE5E4cQneJuO4mxxcxeSpoNdncUiV9pXBgvjUtxydHvCOVeYc2Y72spDV3px49oRkFrU
	cSUHrIbkwS3mokzrPl16cUjE5olq7gtjT/gsokF7fbJNGR6d2FLeLu3z8Z3ujXPoxZ5l8FozHFm
	/MLYgD6ytyDOxGpOEueOnRDWsbwQWR3a1X5YPSedrfjpDJxA==
X-Google-Smtp-Source: AGHT+IE4UyL/SOxsKwqv2QBoO9fK4yb9eOIOLpdbtmk8N2moITAoFTWNRGosEZdZpGwk9D3xL1fyVA==
X-Received: by 2002:a05:600c:4451:b0:477:7b16:5f9f with SMTP id 5b1f17b1804b1-47a8f9145c1mr17793205e9.31.1765541815630;
        Fri, 12 Dec 2025 04:16:55 -0800 (PST)
Received: from [10.100.102.74] (89-138-78-197.bb.netvision.net.il. [89.138.78.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f4c3f2esm10622325e9.9.2025.12.12.04.16.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Dec 2025 04:16:55 -0800 (PST)
Message-ID: <f8b6826f-3c73-4b80-9e47-5ab0d08fe0fe@grimberg.me>
Date: Fri, 12 Dec 2025 14:16:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv5 1/7] block: expose
 blk_stat_{enable,disable}_accounting() to drivers
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: hare@suse.de, hch@lst.de, kbusch@kernel.org, dwagner@suse.de,
 axboe@kernel.dk, kanie@linux.alibaba.com, gjoyce@ibm.com
References: <20251105103347.86059-1-nilay@linux.ibm.com>
 <20251105103347.86059-2-nilay@linux.ibm.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20251105103347.86059-2-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251212_041657_683516_BBAA9ABF 
X-CRM114-Status: UNSURE (   5.45  )
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



On 05/11/2025 12:33, Nilay Shroff wrote:
> The functions blk_stat_enable_accounting() and
> blk_stat_disable_accounting() are currently exported, but their
> prototypes are only defined in a private header. Move these prototypes
> into a common header so that block drivers can directly use these APIs.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

