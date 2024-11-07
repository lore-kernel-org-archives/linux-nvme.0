Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0EF0D5D696
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 22:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bm7ibeqstmEcA5eOTi0gF/ZvnGd+OvKq5Op4/quU6Xc=; b=dS0PswBX8NU3ntle5iFN1B+L6S
	Am5cCqqK/A9IWWZu35Rrmx083UUZsFiU+Hu2NoTrRH5K4HkfHu2oLGVg5ZA3CCGaQoyccpOkRfkGf
	3i0LbOUZZGh/Hfi3ctMz1CCG6dgS3ekMDxugzv4PskZuLnNa7Nj3dyPMcIb9/K8SqWTSdayZd3/Xr
	UwpzaRdlQM8AdHFuRD92u9/uzJsxTCu+sWC0g1YU7fJhXTnddzhXvGieHBmtietQ57lBy3cIqo0SE
	jXHB46YxoLRMPj0ydh/5KE9unIwB5nYCHPWB202CAlcqDlLl+DKeSAKEHQ0QwQQD2ZOUqqheioYL6
	kcZxv6TQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9BCD-00000008ZYZ-1ZRO;
	Thu, 07 Nov 2024 22:41:45 +0000
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9B5x-00000008YV3-1D17
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 22:35:19 +0000
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-71850708dc9so1115246a34.0
        for <linux-nvme@lists.infradead.org>; Thu, 07 Nov 2024 14:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731018916; x=1731623716; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bm7ibeqstmEcA5eOTi0gF/ZvnGd+OvKq5Op4/quU6Xc=;
        b=oM60bGWZttn61zanuPlMmEI5djGCpHr28lB4UEuJaYCXH81xpF3hBXJnkdrWCg0Vsx
         snBV7VfgZQZKfcauyTVUa/qfogdNCyBykkZ89uo4NQDi7M0tALzaAeqU36VjB8Z1k5CU
         tORcW7aINzZKu02NnZaGBV3bNdlapdgynlLeyD+T7T/StOyPnrXUxETJT0LoQchPKf8R
         Glsj9UyvcpBkydJAWoVheNCrgja0X56lqXUw2ScnRkj14cHSXJkwqc9F9AFjHgdJAhRs
         Wyql1x7gSd0ydc1KsRoR72KK8AA8npdnVlCQIlYAQOAWqb0Vm8XtYOzbvcgNVCbNUYvZ
         1tew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731018916; x=1731623716;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bm7ibeqstmEcA5eOTi0gF/ZvnGd+OvKq5Op4/quU6Xc=;
        b=gsmrA8lj1y85e/VETOKdCQZozU7s20QsDV8Niq2aSP6Mkk/OGOt/0+/dN31imkeEJJ
         jktzlllKZkrUK7Cr7xFWvDii4Ahk3LJN9A6zuoEXHu2Xb3FGYyXxegwDNbyF9YBp3IgH
         tvFShkx7q/L9TcDMkNobP0UqiyQ54N5pM06uoaxxHDhdG6z2p4HbPyGEq9qX7dJQj3vu
         JIKa2jEr8corsoZXAsSH7WzWJrzRusbiIYv6Y+lBvMlAcEYOIdLF7wtniqCYXyQ+jMsY
         ALjZ/h6hUHYXs2naMsd8NI5tueeecRvI8P2f4dVTp69NvEvQxhJh2iPfKTrrgHD1VC89
         hYQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnPSVx6+gVNuA1VtQNUntcHNZfg9CVqmJfQV2dLb+wxLQl4g3YdtVFfkIQQJa4ucgLB3fZUSJTXifM@lists.infradead.org
X-Gm-Message-State: AOJu0Yw7uLlKZkfE7xHVFTnUHMv6IzNpF2AZCsER3q0Q3BFazIibd2d+
	1UhkcAsr+IXcFDfWCiAeo9nSpVTlmjG2wgPPjyn2peuDEVe6pXUchic8MdHZcCw=
X-Google-Smtp-Source: AGHT+IGgriZZOL2MwwQHyXNmxP+/rXldRyNEbZu1L+A9ytDXvav22m77BTbEFTSlZj5iIAblyvh/ZQ==
X-Received: by 2002:a05:6830:2a8f:b0:719:cc74:dfd9 with SMTP id 46e09a7af769-71a1c1cfed3mr946578a34.3.1731018915967;
        Thu, 07 Nov 2024 14:35:15 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a1083630bsm488503a34.34.2024.11.07.14.35.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 14:35:15 -0800 (PST)
Message-ID: <bfc380c1-c198-4a41-97f7-f286e3692879@kernel.dk>
Date: Thu, 7 Nov 2024 15:35:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: max_hw_zone_append_sectos fixes
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20241105154817.459638-1-hch@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241105154817.459638-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_143517_381317_AF312938 
X-CRM114-Status: GOOD (  11.00  )
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

On 11/5/24 8:48 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series has a fix and a cleanup for the max_hw_zone_append_sectors
> change.
> 
> Diffstat:
>  block/blk-settings.c          |    2 +-
>  drivers/nvme/host/multipath.c |    2 --
>  2 files changed, 1 insertion(+), 3 deletions(-)

Given the recent revert, will you respin the parts that makes sense?

-- 
Jens Axboe


