Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E39CFD64E
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jan 2026 15:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iHrOk5pTLZ1ba+WyDkJheiozsIQm18H+fz3+gza/bUU=; b=Tb04+Z1KM867SlSO9LdozOEFsy
	vGOZpNsKhFtKwyVQzdTIwK+/Eeb1PJvPYBbuK0ldAXEi56AjnlwlfBmJ/mW7AFL5GcGIoEWHj9ew/
	ojdnJbsRReNZLmf8axD1OBCnyqU1pZ8PgZv8Kb4BY9KyNdCfCqInh03acBhZnlLT7m+V6+JK67xHh
	CCqgkkERPjsxWmO7Z49p1onWu7EPP049H5n3BJ3lI6CPdUgqW5a/Ix7Ytd2A9PtuXUsyclBrYXBTx
	r3dF0Hl8is9QOZsl17wORAw5Zr7rMPNBoM6qxId26ic5++CFtYJhmLeNV+4KzPClb1U0DFBdNP2KR
	is0tF8zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdVEk-0000000F9mD-1ZHP;
	Wed, 07 Jan 2026 15:14:14 +0000
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdVEg-0000000F9ln-1dkd
	for linux-nvme@lists.infradead.org;
	Wed, 07 Jan 2026 15:14:12 +0000
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-3e37ad3d95aso1396733fac.3
        for <linux-nvme@lists.infradead.org>; Wed, 07 Jan 2026 07:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1767798848; x=1768403648; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iHrOk5pTLZ1ba+WyDkJheiozsIQm18H+fz3+gza/bUU=;
        b=EYWh+VvMpcQ8otjhauhFxuC00v2e3BpfCOaW3GlYj5i+TRiZ80C47Zvgzwpqj+VNiP
         +0cQjkN8FRCf07+evpyFLv00vNZ5jfxO/8tROZDiJEoDYXleqerpB4mPHuAfE1dR8kcr
         WOxELYuj1sQQmH6Q5ekMTa4JCjBog8J3zGl9yUGX/y/OhnaDesUcpOroPCBi7IISls4Z
         eXb/sI3BHrP3WyPX8Xb9V+cBSySneZWvL0frB3n03OpmvOSCTTBG6dc12alipL5mvzil
         L+s5cP8/CCBjg4fhsAGHkMiIyXFLteebIjWdLGnxFXdPAAGw+wouFhrAKQNUyQPphaQm
         dW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767798848; x=1768403648;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iHrOk5pTLZ1ba+WyDkJheiozsIQm18H+fz3+gza/bUU=;
        b=Xldz67SgZjgY0Raoow0lcc+rcyGRfp8jO/N5KS7FRCEbQcvaB0VTnBUJvzIvXv4/MY
         tlPSZXADxhE3A0g5EMTfoqNfW3Q4uuVT+5DkTHTqyUM3QqumRRjM3aZOl0q0SEtnXC2M
         xkrJKthaQC666AHnrbbFY/rKaJGeiOmOr095Gxq09CILzbRePUZ3Xby4dpGQepy4iFip
         cOqnRKJDQUBs+4ZUHE88qgn4dxqNTHsX0dwjf6+TdpNuwRtvifTDz0LJUBcbblf2/F78
         E5lHPp1d0o/7n0o9yZl87WBgIp4Q5138BEgps+4PDx87v1S7ra0DE32agKF0i6bGRneJ
         ZhkA==
X-Forwarded-Encrypted: i=1; AJvYcCWPYhBtrGnoP7DNgzuldA0G65VDtEVYE+cXvLMJcAySQ69e+mmMC5+llJ265I5FeYrzSggUYBD/76Qp@lists.infradead.org
X-Gm-Message-State: AOJu0YxaQehf2N1O1411n64XmGl97nBgxeEF17veu0/JWqpIH/mAygyc
	55kGWuQ+12pdq0QeqpgDLbcYw2nnxO6C8hDqBPwDFTKYnHQPk3vNSlwiwgXtWk/K4sM=
X-Gm-Gg: AY/fxX7F/tR5XXw1oU9FDpt2hEz+8r0YSlsaPnPy5EKOIHsFRGnI7QgKZn9K+O6fSZW
	Va26oiQXlDvEsCtFaIftLT9hi/XIB35jUSIYyRiBfbEBBqhbOeP0PwknJY8umGqj+9nyl99qAp+
	W/wLBD1t95Ca4QXDU/cAcNDsb+PxZuhCizVbbGT+57yvH0u9rlIXn4sKrsPVK/YomDYrpVkDihK
	i3HV3Ap/smWHOXYDuTzHGFWBvRbIg4XIVZJLcftWGcKuFO4UF2VXd/ni6DgmDyKpg7gk5ImzG1Z
	Wth5w5yIQ6JyuYH3RfIKMFWtNt6gjb22jGHz3hzA+A4UjT+2fP8DT4t6Ie9Y3ubioJL6L5UaK5G
	v48uz1/L+I38vZWy1340UR3Oltpr/ll7x6EcFwgoeWQLKqO1DjoTTJkAwXmCBe4sERN8iUASdNt
	DqhAPrwis=
X-Google-Smtp-Source: AGHT+IEtjhWlYouyE4XkQvwKD94ryb7c45pcHTTeNQaFFsJpBA1F8X/afZoaesQ/QaKwTWR22oJquQ==
X-Received: by 2002:a4a:d4d5:0:b0:65e:e522:bf18 with SMTP id 006d021491bc7-65f54ed790bmr819778eaf.4.1767798848467;
        Wed, 07 Jan 2026 07:14:08 -0800 (PST)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa5161468sm3336356fac.22.2026.01.07.07.14.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 07:14:07 -0800 (PST)
Message-ID: <71e382f7-d6af-4ed6-bc90-4534e4d99792@kernel.dk>
Date: Wed, 7 Jan 2026 08:14:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] block: Generalize physical entry definition
To: Keith Busch <kbusch@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20251217-nvme-phys-types-v3-0-f27fd1608f48@nvidia.com>
 <20260104151517.GA563680@unreal>
 <258e49de-7af3-4a35-852a-8f26fcb7ddbd@kernel.dk>
 <aV4ZcuXFjN_Eit6v@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aV4ZcuXFjN_Eit6v@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260107_071410_435218_51C58DB7 
X-CRM114-Status: GOOD (  14.75  )
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

On 1/7/26 1:29 AM, Keith Busch wrote:
> On Tue, Jan 06, 2026 at 05:46:21AM -0700, Jens Axboe wrote:
>> On 1/4/26 8:15 AM, Leon Romanovsky wrote:
>>> On Wed, Dec 17, 2025 at 11:41:22AM +0200, Leon Romanovsky wrote:
>>>> Jens,
>>>>
>>>> I would like to ask you to put these patches on some shared branch based
>>>> on v6.19-rcX tag, so I will be able to reuse this general type in VFIO
>>>> and DMABUF code.
>>>
>>> Jens,
>>>
>>> Can we please progress with this simple series?
>>
>> If Keith/Christoph are happy with it?
> 
> Yes, I'm happy with this. Sorry for the delay, I'm still abroad and
> encountered some issues when I should have been holidaying (nothing
> serious, just bad luck), so it's a slow start to the year for me so far.
> 
> Acked-by: Keith Busch <kbusch@kernel.org>

OK good, thanks for taking a look. It's all queued up since yesterday.

-- 
Jens Axboe


