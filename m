Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA211C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jul 2022 08:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IMbD90s21HdnddiL42xIyv27c0/QtqF4u8JsID8zNs0=; b=tt1IOzeZadRmbxYPtZS2aE2nLL
	0xOLl7KjGvyr0NUMiIrZU+gytVuiVCQeasviZnWOD7LuZ0BAKUp+H5g6cuXNgpT6UT0S9hnmYDGZh
	QEpqOpQxcnizVUOBaynXxdeWs85Ay8NG55R0BI+7AHFucyR2wWc/W1pkxNF2lK5tklpkE5WEHoy0v
	ZFoaceuCeDACQ1ub9zg+F3pI9nn4urJPd16Yc0cTiQ3PvkrYz5ThWGtiVsi5W19hF9gA84ub/BRBH
	3IhLA6uaH5GD/TlSGj9MwJTjawBTqnnFP9Iml52oqohIySfWltZNKTODrjI9UTDw3il79BhJPoDYy
	6P8M/cNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBXMT-001UCv-QU; Wed, 13 Jul 2022 08:04:45 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBXMK-001U2K-IW
	for linux-nvme@lists.infradead.org; Wed, 13 Jul 2022 08:04:37 +0000
Received: by mail-wm1-f44.google.com with SMTP id j29-20020a05600c1c1d00b003a2fdafdefbso168942wms.2
        for <linux-nvme@lists.infradead.org>; Wed, 13 Jul 2022 01:04:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IMbD90s21HdnddiL42xIyv27c0/QtqF4u8JsID8zNs0=;
        b=E1sgrmrcIsXqQ4ScB8Rpj6qjkxErvS3S37ep8o7sCuySa2U29I0bP12vybJS94+u8K
         RBeKprtRbITP78oht3inKNnWjsccFqYSsKzyT+AAKEULWsZpVlSTovhHj8CnrOi5BYUU
         UlkqxpragEJ+6HvlpGmpb/APAe+40A0rnEM/kAdS1vGhS6F9XbxQlOr6GHJguG1ZPGIH
         UBLaOr221ozlLRQAaKrTeFl+B+kXHBkshvDjhK+c1m90brSiZIL+vgAj4SVfCN8kBCwC
         QbQ0U9U2F8X5fAH+JVcR5SYwjuV2PmdT+bt1hAShXevY/ryevwcabWAeu8HYqaV8y4yr
         V/WQ==
X-Gm-Message-State: AJIora8amgblIkiRaylAyxKWicZk6YFFZ6LR1LF1Yq9y7fHhqbDGz4BH
	YdmFXgmOIOed7SZoRBWnGPA=
X-Google-Smtp-Source: AGRyM1vwsh7bKCpn2lTmbIQEoG/5T6EX7m8IACBWbztC+wbdRF/oK3yyKEfzXUu/Co8455P2m9GISw==
X-Received: by 2002:a05:600c:3545:b0:3a2:f3e3:c382 with SMTP id i5-20020a05600c354500b003a2f3e3c382mr2774942wmq.142.1657699473799;
        Wed, 13 Jul 2022 01:04:33 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id n187-20020a1c27c4000000b003a199ed4f44sm1566011wmn.27.2022.07.13.01.04.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 01:04:33 -0700 (PDT)
Message-ID: <24f0a3e6-aa53-8c69-71b7-d66289a63eae@grimberg.me>
Date: Wed, 13 Jul 2022 11:04:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH for-next 4/4] nvme-multipath: add multipathing for
 uring-passthrough commands
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, kbusch@kernel.org, axboe@kernel.dk,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, asml.silence@gmail.com, joshiiitr@gmail.com,
 anuj20.g@samsung.com, gost.dev@samsung.com
References: <20220711110155.649153-1-joshi.k@samsung.com>
 <CGME20220711110827epcas5p3fd81f142f55ca3048abc38a9ef0d0089@epcas5p3.samsung.com>
 <20220711110155.649153-5-joshi.k@samsung.com> <20220712065250.GA6574@lst.de>
 <436c8875-5a99-4328-80ac-6a5aef7f16f4@grimberg.me>
 <20220713053633.GA13135@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220713053633.GA13135@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220713_010436_660977_C448CA82 
X-CRM114-Status: GOOD (  16.41  )
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


>> I think the difference from scsi-generic and controller nvme passthru is
>> that this is a mpath device node (or mpath chardev). This is why I think
>> that users would expect that it would have equivalent multipath
>> capabilities (i.e. failover).
> 
> How is that different from /dev/sg?

/dev/sg it is not a multipath device.

Maybe the solution is to just not expose a /dev/ng for the mpath device
node, but only for bottom namespaces. Then it would be completely
equivalent to scsi-generic devices.

It just creates an unexpected mix of semantics of best-effort
multipathing with just path selection, but no requeue/failover...

>> In general, I think that uring passthru as an alternative I/O interface
>> and as such needs to be able to failover. If this is not expected from
>> the interface, then why are we exposing a chardev for the mpath device
>> node? why not only the bottom namespaces?
> 
> The failover will happen when you retry, but we leave that retry to
> userspace.  There even is the uevent to tell userspace when a new
> path is up.

If the user needs to do the retry, discover and understand namespace
paths, ANA states, controller states, etc. Why does the user need a
mpath chardev at all?

The user basically needs to understand everything including indirectly
path selection for the I/O. IMO it is cleaner for the user to just have 
the bottom devices and do the path selection directly.

