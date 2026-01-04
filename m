Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA478C2A069
	for <linux-nvme@archiver.kernel.org>; Sun,  4 Jan 2026 21:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=daXsAWuw3CezWGchWWVZ+gi3L1ayf/lBLGdEjsaYwUA=; b=iWS4anuR/Yr5mNpYGhgm8qH8Ib
	9Nb0J4uIDHRMOmmoLmQzk4sss62bXFYjyY34MdQpmqkCCirFIk/5n4BECRM3/AxOs8z3EXBe8zd71
	8gZIAkJZ2luHuPZ2Q1awmDs6f2o38Fb8VV3U/QZ8gWu0pxvCnZD+rs0CPXbWd/VXPyg0pyds/fHos
	1wGvenJMxLxVrPMW2KXrVTIzKXZ2oLdbZZf2mYJ/k+uj8SSKX6tk+vVw9LHlcw18Gx8FMfKh+Tye3
	NyVwFA/ijc7amSUZlKINjG0BvynHGcbDutk5WZs0+lz0NJkCa6UWS7AufLAmTYRE0jdVkGifNmLeq
	e1EgIhyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcVSE-0000000ASf1-2ecu;
	Sun, 04 Jan 2026 21:16:02 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcVS9-0000000ASeV-1VRW
	for linux-nvme@lists.infradead.org;
	Sun, 04 Jan 2026 21:15:59 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47bdbc90dcaso85426775e9.1
        for <linux-nvme@lists.infradead.org>; Sun, 04 Jan 2026 13:15:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767561355; x=1768166155;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=daXsAWuw3CezWGchWWVZ+gi3L1ayf/lBLGdEjsaYwUA=;
        b=tw+RGtQFrkjIhoJNhhTZlTGp7Ev3PUOCf6sk8awDsYFgyyfJ2Fz48bFOu1E7pZ8N9+
         nUONqZHW5lB1/1jxua73nPuLDEDN3b/yFYstO/hCS4r2hdQ+rOty6C8cFD9cEaD4eWA0
         j+TwEWqxzierJTAZu7cGFcgo4Bk6c0Vd8Ckus3lqoQtfiyJt4Fmweyd+7+/meqelG5lj
         fmTKvTD1FS3kS0lQsqbr20beuvojdroEjo9zszdExHqZVkbdHYl/3MWhtPkDAtoRU3d0
         qTcB1KRJv6hN6gHV3mouZef4gHcLqXxaQtuny+43VhmYBLHaw6BhWw9Skx3oJuZwjtSu
         2wpg==
X-Forwarded-Encrypted: i=1; AJvYcCU+Bs9oFT1xwCQZWB8Gv3tO9Glg0mtHlfuCuaP8JiRWggeHTI9MYlVUIQzmBUmlsood41kEeQm9SMlI@lists.infradead.org
X-Gm-Message-State: AOJu0YzdIES/UnIjUflZDYhZH8weRKXQoltTw8pc9evKVkUrSIUQEuHV
	fx+2a+86ahqlEjT/QglPvR/3j+wjP5gbFkBelUYulBzxKmv/RS6d/VaH
X-Gm-Gg: AY/fxX4bTo6LDitVjHK1ZH0tJRJJBojvlNrcWOBGENwimxEskJpS5q40eeapLEK7eyS
	eorv3WSJabjL/xcvYUxdeM9jdxQhDJBS05zp19XtmphwNCFuxGJPL9v6suWFmbNquYhxxW4Mpvt
	SgJU+WDIsbnNIcYHmJhGHD99D/p4VDf3J16lTU25xYIwSp3XfXcxE9F8RQ4qXJwQF5Yyf/yx9kC
	zjlvXYKCC7SA4jyJK5JPHfzcmJz5lgmuQQ964jxfAF92CK7f6UooPNlCs1oyS8wMN3nmj8f/kRF
	lVTUngvjcBPcI5bE93TgGvJpJBHXFaN4vRp07RIEAejTcZgDysecOhGV67fwcWuUnsbR5QCF4Co
	URJXdIQdPGJdv96932y5XJXwFRITHJYXQ+ijN/nVU8tQrp4kcpNjK36Dk/PCp94v6iJsORn69ue
	vZfJzKhQeBwwUVGNZ72UQU2kApK1d6GXNi4MLJ0t9Vxi/c/f8xRwhxSw==
X-Google-Smtp-Source: AGHT+IEP+hsUfWylG/sWIOgHL0+7XuPA3aGh+EMyQJjqq/ekSSRpH7T9d0ZX6DEh3VlI0WyQEbVgag==
X-Received: by 2002:a05:600c:c1c8:10b0:47d:403c:e5a0 with SMTP id 5b1f17b1804b1-47d403ce6e0mr342730905e9.12.1767561355367;
        Sun, 04 Jan 2026 13:15:55 -0800 (PST)
Received: from [10.100.102.74] (89-138-76-94.bb.netvision.net.il. [89.138.76.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4325b6bfe88sm88962379f8f.19.2026.01.04.13.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jan 2026 13:15:54 -0800 (PST)
Message-ID: <14098277-cbcf-4397-bf72-f9cf1613789b@grimberg.me>
Date: Sun, 4 Jan 2026 23:15:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 09/14] nvme: Implement cross-controller reset
 completion
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>, John Meneghini
 <jmeneghi@redhat.com>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
 <20251126021250.2583630-10-mkhalfella@purestorage.com>
 <9ac9b7c8-139f-48f9-bfd2-bfd03506abf0@grimberg.me>
 <20251231235136.GQ3864520-mkhalfella@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20251231235136.GQ3864520-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260104_131558_250840_03F75D27 
X-CRM114-Status: UNSURE (   9.40  )
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



On 01/01/2026 1:51, Mohamed Khalfella wrote:
> On Sat 2025-12-27 12:24:17 +0200, Sagi Grimberg wrote:
>>> +	log = kmalloc(sizeof(*log), GFP_KERNEL);
>>> +	if (!log)
>>> +		return;
>>> +
>>> +	ret = nvme_get_log(ctrl, 0, NVME_LOG_CCR, 0x01,
>>> +			   0x00, log, sizeof(*log), 0);
>>> +	if (ret)
>>> +		goto out;
>>> +
>>> +	spin_lock_irqsave(&ctrl->lock, flags);
>>> +	for (i = 0; i < le16_to_cpu(log->ne); i++) {
>>> +		entry = &log->entries[i];
>>> +		if (entry->ccrs == 0)	/* skip in progress entries */
>>> +			continue;
>> What does ccrs stand for?
> Cross-Controller Reset Status
>
> 0x00 -> In Progress
> 0x01 -> Success
> 0x02 -> Failed
> 0x03 - 0xff -> Reserved

Let's add it as a proper enumeration please.


