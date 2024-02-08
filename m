Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211B6C48260
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Feb 2024 18:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sdH/0G2IBsoyHFVG72lmJAQbtMWReZVvbZcO5tSlp90=; b=Sa2EcXYHh/lt7rdzwpl85zQ3tK
	bYnJJsUWfuoJDDe+bbw0AMOdIudtkc3iaZY87rRe1ncV8U5iO/dkIzcTZxzsgtQI+2vh6idN/OaZF
	lkIPtKaivIL68KxziwRkaF0MyqrX/WzqxDM2O0ABB4TPWnwUh+iSYdrprYoNaWybx+9gGotXfxOK3
	ghebWs6jmazKUDu989Ze2fG4htZNQclhALfdPkJ9SzBQfgfacNzKxjeRFbV490olwZwWcpqdLFmJo
	2EiXZub5e+VHR6A9xwh6W9VTiIWMJRH4NsXjFoZ+9Th2fphX044I8PfUecFCtbqMHIhS5TbvXUvw7
	WePBQIvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rY993-0000000EcEB-3A2T;
	Thu, 08 Feb 2024 18:29:09 +0000
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rY990-0000000EcDH-261f
	for linux-nvme@lists.infradead.org;
	Thu, 08 Feb 2024 18:29:08 +0000
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-7c427cba7a0so849439f.0
        for <linux-nvme@lists.infradead.org>; Thu, 08 Feb 2024 10:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707416944; x=1708021744; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sdH/0G2IBsoyHFVG72lmJAQbtMWReZVvbZcO5tSlp90=;
        b=KKSTqumc/n1oZ9UcTQ1JRqZJrdkuedqUzT7ObglbjEXH6OhVS1vCr7y+0nfUO3Zb7Z
         89g46fgM0+13DJjhkK4KigYRwBq5yyuakY/xazrPJWyJHEWPRxh9mU6BngVhzZCu8Xwb
         mPZP8PqJI8wCo79aVsHKslKB0kdDmulckM+vzv5P8aiLKCAMajMnM3U/4VCHMTgT8AXg
         aWOhCawcYawkxxQkJg0OKQxb6/zCBFoJkRa9pDFliNwcdXmsVH+thAPkJkWTEjWz0SnF
         nzRTU1FYvhwXvlrPx2i8uWEec8OM8OhK+rW5poiT5aSe0cBgHwnhoCmMECIolxka25tx
         boFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707416944; x=1708021744;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sdH/0G2IBsoyHFVG72lmJAQbtMWReZVvbZcO5tSlp90=;
        b=ezO+7b9D1ES50b6nYQzEHr2W3Hvj6xDXCkHIgEAsMjw4yJUrbYudhPKnVnrdc5SqdB
         /b9CwnpzPjLyZ7IRaPrINFlZHPoszYwNARQUlRrdKmN5OKuon4fF42OiPSDADFNSlNAT
         5ORuJIfWxMq/2/HG5xOYmMf1T6aUTRPMGBxzJmdkoedKLZlzrtrkZcI8AQqdTQM7ANUw
         eE2FRQRbj2muliIZjIRW45K3L3tXTkJ0hDw1OVLWt0ai2151MR3R0i+b7Dbib2XqowaB
         AVXKApEYNCTDEMl+VKfFjox1COq97urfSGgR5eeEYZYg2ospkQykMOxOCgDbwGKCj/Vi
         nPSg==
X-Gm-Message-State: AOJu0YzACT8tYUb4VtUYk1YvzVQUWRiCn48aS8S6puloir5kD7ED+WNZ
	CJAvotpvI2it8ru0Z8WqZ+ylzTzAOG5x2nUhpuaMd/osd/FfzMTOo6BNsw9fqxw=
X-Google-Smtp-Source: AGHT+IFqbHKf7cPgN0X5em6Y1kLI0jRdWM7LS6AskmauYhPDzg044dyEHURNZu9F1Y7+7Tm9RVMQGw==
X-Received: by 2002:a05:6e02:1aaa:b0:363:c82e:57d9 with SMTP id l10-20020a056e021aaa00b00363c82e57d9mr400409ilv.3.1707416944662;
        Thu, 08 Feb 2024 10:29:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXzAEdoSY3xPHBtUIFtqk0AMLZNS/0tU/vP7IrLxCoF2IMjRgUWH/yFmcDfQni+nFr/eFuIU5THZwqUdU7TgRKXHPa4agxcOCe6OHMu59HSHyYotixnXTGtVSyzooAQ9IiwBWwiFHMbNIcanB7wUtREgCoWJMROdq9FILPpwnHa7fGaNPx1OXx/kq6YZq+GaWSGBtEQUzZGigGp04JxFy0bFpsKi26UEnYqW8wXAZwBozpiDMVNxBliRd+yXDODJ6kFTcvhS/MGL+UVXejhIwaxv7g/K3jsqBoB0GP/D4B47BcvoY5qOpwc3dMopGaIN3AAjWftPuDgVJYjCauTwR+NKRxy9glzYFl05LYoDNqycUoJAfbfP/uNpwRfv1vz/rT8rEzT8ijbJeWC3IbFBA1xc+nBLyGqwmKdWvg=
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id c7-20020a02a607000000b004712aee5509sm976989jam.134.2024.02.08.10.29.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 10:29:04 -0800 (PST)
Message-ID: <78eae4a6-cec6-43e9-ae91-4bcce3831cbf@kernel.dk>
Date: Thu, 8 Feb 2024 11:29:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: atomic queue limits updates v3
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Damien Le Moal <dlemoal@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, virtualization@lists.linux.dev
References: <20240131130400.625836-1-hch@lst.de>
 <20240201071027.GA17571@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240201071027.GA17571@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240208_102906_793092_38360681 
X-CRM114-Status: UNSURE (   9.35  )
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

On 2/1/24 12:10 AM, Christoph Hellwig wrote:
> I don't want to spam the list with a full resend again, but I've
> updated the branch here:
> 
>    git://git.infradead.org/users/hch/block.git blk-limits-base
> 
>    http://git.infradead.org/?p=users/hch/block.git;a=shortlog;h=refs/heads/blk-limits-base
> 
> with the bisection hazard found by Keith and the various review tags.

Can you send a v4 so we can get it applied?

-- 
Jens Axboe



