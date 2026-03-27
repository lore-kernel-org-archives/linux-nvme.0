Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B71E610F284A
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Mar 2026 16:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H9GFXOTTQRvv0nghuEiNO8YJ3uPaE3Oho7HffD+VqBA=; b=vFlUrBidUUUt+FMT+ObpsCk8Df
	drnmGdvyf3FYrEBsvzkxZ7idsmTnTCyOuLkf7cZKc/a7KEyy+ZTy2QjBd7mapUmjGTvIC2G8++3de
	E5pyfyoosapBvuDsomQKUZcW3ccc5H/W7rVzKezr2Q/wn2DPpR3INTdegjikPSIunDrCNzRbYIPqM
	3j2mZ752yRrFBlVquG4cPM5v374qRDckWJoGPFVZN6fqqvZ3H504HsUsRL9OlJFM6IRfYvRDs0fHg
	54EwMnaPZSWgBRwGKR7AtXKU3/S5z+8DcpelYmde9hiD85LBey8zWWDx/Wv6/PqYzUzDiu+rK/2b7
	+hg3Ay/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w69xY-00000007lWK-1BgA;
	Fri, 27 Mar 2026 16:22:56 +0000
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w69xV-00000007lVK-0B0h
	for linux-nvme@lists.infradead.org;
	Fri, 27 Mar 2026 16:22:54 +0000
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-7d8b2703f37so2061436a34.1
        for <linux-nvme@lists.infradead.org>; Fri, 27 Mar 2026 09:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774628571; x=1775233371; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H9GFXOTTQRvv0nghuEiNO8YJ3uPaE3Oho7HffD+VqBA=;
        b=Y0p1YJzKq8GtrqXnS2uZ4cA8kBakwero2ZGKkOar0bBBhZDb2nvZz42nJMZKnpDGzI
         9/vHc7NJr7vyM7Hm0n/anKJa6n1iI+/8jgkuWS30nH4ULn4SSEDeR4RYT0fuCo+g37j5
         OVNaQgNhwfZj2ZosCNVXRH/MPY2hi/50PE/DJ8wYck7SycUP7rM8YUDVcUcC/QXluhD7
         WR3JSuCTVLlBkbc2H4jI68vkHgcmT3MTfXslfsWsBv+CXsusm3dBRrryXaUB54npHBGh
         MGclDP07UFf7X3AVNBAgfNFn/OvcfQWaXOmOF2x0x7NYrowG2aDw3R6ReNavlRgsmWxc
         DtNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774628571; x=1775233371;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H9GFXOTTQRvv0nghuEiNO8YJ3uPaE3Oho7HffD+VqBA=;
        b=RcZptr2V4gVqAZY6hsALVsKD9uy+SNI1yi0Fbi6Z7mSgMwlvwfizwgnEhDmOHbau8Z
         CoYHPydkFRoVZiGgMEmmjtefHlcD7SqxfKR0LkFDSOd00AUkQNfUlmm2PSmQrgYlIsiE
         3ztlP+zd439NuYExzKTEYPEt8lWX5siNu/Jkvv6EO+PO+oEES/nFiVj2TMnd9QjNw+82
         mEODfZCMR0hxpOrIRRKeSc3riQTYP6HLuZJS/nTq3YF3pxjaubSndXSv8pmP5Grb+Sd/
         BOotr2gGF4H6pxblSH0aE15g7MuJhqgmesLg3P+9CkBPEgWbVm9xfeXWZt+5M5sUVqV3
         /A2w==
X-Forwarded-Encrypted: i=1; AJvYcCWkSrBYDc6kUvoo3MAI9TKfFDm7Y9vsghxGTHDT4uqg6+p8x/I4I+hDDRJoCEUD8j2VOebQZwRPcyYJ@lists.infradead.org
X-Gm-Message-State: AOJu0YzIVNbHKQah84cqNGBfQIwYzpGiAl+CAJAsp5O610qLdg3W4IpB
	atthWPtdLaK/isrRIybKpsRvSaLkuTKWVQeZM5+p8I9yMKfiFEplkM3RZ8xnpem+nq4=
X-Gm-Gg: ATEYQzz5ZRPDuSi/b1SjHz55V1QxyKrq44FgS+ocQz6e6pAfMtZ+CoWjtvD7w33ztLv
	XvqgCQE69S4Oe33pq71Q8VhMuS4Iy8SRRp+pCJjY1+Sj5wonvBCTrg4HnBZAkVwqWy8xhL7jni+
	lpJa/aTvoU/cR5PGDgiGmOJ0giCfZR4xqdTNLOXtWDwZPBwSWrCRDoM9IUvVDkxIX65qSYN4u1/
	x/67Cvh36MrDcyIdHpVOtEvuoyOe5/2przGud9MsY4zgpXr00RGzf/GHpLuMy68ASCl5Drf+YG4
	JLOs92wu0Vs4R0qZtjmuCoeNGi3DVjKB9lp0mVFumkP70hXDUWp5Jy1LGcFwx1NQH7rZYk+9tX3
	YRa9+I6hpXV1gSobzTyFPAje0PMnSGtvF7lyCy/XkgIdESkEdKSuBCYSoF+8LEMxkmGl9Px4KO5
	8AgoJaKcOI1Y41uLOzRZyHTi/9miSEWAAcUcl5cT/qq7vegwQ4IMKTE6T6ZE4uglvrTml+wSEjU
	GgY8RLwzs63I5TxNF4=
X-Received: by 2002:a05:6830:2107:b0:7d7:4618:f7c6 with SMTP id 46e09a7af769-7d9faf7c61amr1937037a34.29.1774628571449;
        Fri, 27 Mar 2026 09:22:51 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d9e7264e10sm5834735a34.23.2026.03.27.09.22.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 09:22:50 -0700 (PDT)
Message-ID: <8262c10a-b0fe-4560-98b6-b28b6bc807ba@kernel.dk>
Date: Fri, 27 Mar 2026 10:22:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme updates for Linux 7.1
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
References: <acaX0TREWsWBDyWp@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <acaX0TREWsWBDyWp@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260327_092253_333209_E9842E33 
X-CRM114-Status: GOOD (  10.12  )
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

On 3/27/26 8:44 AM, Keith Busch wrote:
> The following changes since commit 67807fbaf12719fca46a622d759484652b79c7c3:
> 
>   block: fix bio_alloc_bioset slowpath GFP handling (2026-03-23 07:58:32 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-7.1-2026-03-27
> 
> for you to fetch changes up to 886f35201591ded7958e16fe3750871d3ca0bcdf:
> 
>   nvme-loop: do not cancel I/O and admin tagset during ctrl reset/shutdown (2026-03-27 07:35:06 -0700)
> 
> ----------------------------------------------------------------
> nvme updates for Linux 7.1
> 
>  - Fabrics authentication updates (Eric, Alistar)
>  - Enanced block queue limits support (Caleb)
>  - Workqueue usage updates (Marco)
>  - A new write zeroes device quirk (Robert)
>  - Tagset cleanup fix for loop device (Nilay)

Pulled, thanks.

-- 
Jens Axboe


