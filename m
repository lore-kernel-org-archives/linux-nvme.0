Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8CA0C0218F
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jan 2025 08:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bJ5xQ/mn3EzBsDRArs0Sip6IwwrJ6iK8tDkVD74bq3g=; b=Sd/L+Lfggp3REce16hBs+abxup
	srVd1BE+u6QLr97DitPvf7F7DH34nwF9bLBh/uIQUdd1uI5NKr9eeWp702eSIxG6UyqbowrrQw6Yt
	4CWN62bVHBUEy7d1q3kNlRbvegixHgwv5aIoLBbYKnYYzd27VWW5vgV9wd4ow3aSLcmF48JXE/0DI
	NlFBIRUN1XANdAIevBupwfxLkVan7LO9my41Cy5ctB+B5m27Ks0PIPnQWJGOBe7FkScv94SQ4aXMU
	obT6bwdrn1+iGvu8ljjw0L+o6oicZnpoApWOeTROO3QOx5/kWrCuIhNLKIzWhT7pVolNv6qs2PGWu
	cckhJdjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdmDu-0000000ABds-0buE;
	Fri, 31 Jan 2025 08:17:58 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdmDr-0000000ABcu-1qJ3
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jan 2025 08:17:56 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-436281c8a38so11779605e9.3
        for <linux-nvme@lists.infradead.org>; Fri, 31 Jan 2025 00:17:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738311474; x=1738916274;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bJ5xQ/mn3EzBsDRArs0Sip6IwwrJ6iK8tDkVD74bq3g=;
        b=m/VjRVBYqVSQJNKyWVabzwM/yTn1xBGj3W3Jp+lzEiVuqDuljECVYr9rkPQQIOvr54
         fWTqYoJiCM+Zie9hjUg2/lg5AdHi7XTScX5nDy7Chh8b4XyO105bR+sD3/UyBG3xsUr0
         gpdMDQfVS/AEKDhWxEjC9iDdJakxT6VWNmOQUNBiHn23uPIfuhF1C9fIjDZ87dPH1OUp
         AiZhuvi+XHWhjFTGIbbKP8z89J1l1jkq/fs2vH2tUL04g9lM9mqdBOHWw/3CqXAo6e20
         WjVvuFedtx5UaT2ugF6TX+snnOqoKS3+GgQKo6i7tkBuFKwz73k+HkotcceT6QCZk1SY
         wBpQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6ET8Da8w2oQrdWxxqF1b6UFmrLGZjybyfeYCKSUEVY1SpefhZt38496X1ZbE5GNoYF5eEMPLg97PQ@lists.infradead.org
X-Gm-Message-State: AOJu0YyDFKebLWhpFNjxZdIm7D2WUGWiUleDqD5+NDd4/4nda0qXXSaa
	Jralx+L/V4PY+uQyA7XhCmibr05Uae4L0vn8BKD74LlLXt9Oy78q9Cd/KA==
X-Gm-Gg: ASbGncsqx70t6e0f8A4/s+hF27DUPYOpMMlFsbK1Bym1Bmh5G9DTGL5xagSVuk/iYXC
	+zoJp58cjJY4eyTSAaa6f8+a6HWPrgygp14P7Yi3hmgpMxbfxfNTXFe+rJBkpPzNQ8CyV6ioIOa
	jGnh3tbgbG7/yC4ReEJoBrnWUaqN/c2baEw2FbltiI7YQTR2QraExxHg6YqVBOjOVgs0jX3ZkCf
	p2pQ38VH8XEMjI8bxaIKIA1MiZ0ISx0XRP9oJGzq2p8hQIE8/cH2fJCfkBqmpBPS2RGUkXYBq3d
	Mr9r2UmZj1Pu8r0hd4c9bKQuhHjvzPribvifI5vHwfHkOadODOs=
X-Google-Smtp-Source: AGHT+IHt8z0FBaTbpVd1y4exMfBzC2khsgmPpxisfZRKbf2sHVTWaItJ22sUGLdMrgq/4jpyX88zJg==
X-Received: by 2002:a05:6000:2c5:b0:385:fa26:f0d8 with SMTP id ffacd0b85a97d-38c519496a3mr8931868f8f.8.1738311473606;
        Fri, 31 Jan 2025 00:17:53 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-149.bb.netvision.net.il. [89.138.75.149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c1b595asm4023039f8f.66.2025.01.31.00.17.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2025 00:17:53 -0800 (PST)
Message-ID: <9c5e44fe-39e4-424a-9cfa-846026445db5@grimberg.me>
Date: Fri, 31 Jan 2025 10:17:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: make nvme_tls_attrs_group static
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, hare@suse.de, Keith Busch <kbusch@kernel.org>
References: <20250128152512.771115-1-kbusch@meta.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250128152512.771115-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250131_001755_480676_00346431 
X-CRM114-Status: UNSURE (   6.34  )
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




On 28/01/2025 17:25, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
>
> To suppress the compiler "warning: symbol 'nvme_tls_attrs_group' was not
> declared. Should it be static?"
>
> Fixes:
missing ^

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

