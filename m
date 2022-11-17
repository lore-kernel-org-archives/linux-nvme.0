Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0461DC4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Nov 2022 03:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QaK54uyZGNz4G0zUXd6PbyziM7AbUeyYyTjA7tul5uQ=; b=czq/ZGamV/MZEX5j6fxLZaaLmE
	XVuOFLXVc3qKeyXB15ktAqmfANxdtzyPH+Qe0D7dnic805MeyFEB/r0YDzfk3iZYLIsue58Jp/bgO
	QlBVFvv8HBXvTTkoEnHubG2qYh0Uf0F46Z83hpOTW+LoHR3nk0Grxd6TVMrU3NZpn/oRLuKVNW8zx
	649fhSHR14tWZM8Uw8CVoUqpnEa1jOd8LrhMKIzTMqJFm9vMvC8b5erYJRWYKeg6zhCzyVXVip77z
	tTMDm2cta+6FeWSJ95bDHLRySnfGrxFVK1z4ZHHaKp8YjmTm9X0wor4zM7e1Sc1TO/P+/VdOHwQFN
	eHmdyT6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovVuQ-009v11-3N; Thu, 17 Nov 2022 03:49:50 +0000
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovVuM-009uya-Oa
	for linux-nvme@lists.infradead.org; Thu, 17 Nov 2022 03:49:48 +0000
Received: by mail-pj1-x1035.google.com with SMTP id w3-20020a17090a460300b00218524e8877so3955574pjg.1
        for <linux-nvme@lists.infradead.org>; Wed, 16 Nov 2022 19:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QaK54uyZGNz4G0zUXd6PbyziM7AbUeyYyTjA7tul5uQ=;
        b=rlguJZ6YVEKexScq9hNSJF7UR5AAqZdKe4qkETPU94L9KGtaZZsASRpgDjxX0eIwL6
         O0/xY1vpA1B1mOXeOytkbhiNb+jwFZQWvqCebLfA4tKa66P26VE5PY5vaFiHsq5pbZYt
         UcxavQ2opaMhRkqheQ2K1vrydiCvTvn1v16jAZBnymm/CavEvREYNPzmEhdDqtVH8l+4
         eXXCsD5lbXzRyghlEp+B9PRKGgyZi8m17wDLUayaCVhtglgADDOgeR0ZbMoe2dc/xxci
         TKDEnU96nc5Ta+QkWUhO+XIGvSuNeDiGum4Pp6/7DzodqJb4k40JJEt9dwxSGynxtIGy
         OZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QaK54uyZGNz4G0zUXd6PbyziM7AbUeyYyTjA7tul5uQ=;
        b=KP5Ei+ctPO99lOOm6huRyrtjnzeOcUlHzzDs+WmTbqJktc8UeXw0GxsKK2mIsX5P4S
         YTeu9Gs0NNRF0ETQiqAILRXgyXUlppnKtVybnbnahJFgqKQC+MKeRILLECsrIdOnsR7F
         vyiMJ9Ltmen5gmS2Qw8DQdktXB2D/pY1WGKARBXpREqqynubeVkJduPSEHraGZX69JZA
         UfF6aSlE2ESJl/keiIWXQlJn/muNun/xn5YulXZt5zHilxZnfd4exDv7tkG26ir4Tr2q
         lCAmeoS3u2rBWA0ksSPoGtAHvEh+hKRzHZBxP6i8b7PFmE/+GN+l182cj2JdfJpL1IgU
         o+GA==
X-Gm-Message-State: ANoB5pl0VdPPY7kXd6BlBZI+CcEOuk722608WqmUYcJlplXDPbng9kdQ
	H8ywmP5rtueDfaLFEPRtfRWGxw==
X-Google-Smtp-Source: AA0mqf4sRFY2tIbwEwrh8G2gDheRPpQiuc8t5Li/oamz5LROtyky6n6kKyeU6rnln5jZUJcyCA3CxQ==
X-Received: by 2002:a17:902:d2cc:b0:186:8431:ece3 with SMTP id n12-20020a170902d2cc00b001868431ece3mr1075776plc.8.1668656983700;
        Wed, 16 Nov 2022 19:49:43 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id q3-20020a170902a3c300b0017a018221e2sm13052354plb.70.2022.11.16.19.49.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 19:49:43 -0800 (PST)
Message-ID: <256d34ff-3979-9780-4426-6d913a3a9707@kernel.dk>
Date: Wed, 16 Nov 2022 20:49:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: block dangerous passthrough operation
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
References: <20221116130104.2186334-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221116130104.2186334-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_194947_053278_13F305A2 
X-CRM114-Status: GOOD (  14.44  )
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

On 11/16/22 6:01 AM, Christoph Hellwig wrote:
> Hi all,
> 
> I recently had to debug some testing code that tried to send fabrics
> commands and caused a major havoc.  This series adds checks for various
> very low-level passthrough commands that have no business sent by anyone
> but the driver itself.  The list might now be complete, so discussion
> is welcome.

Honestly, I think this is a mess, and it's exactly why I didn't like
going down this path to begin with. I'm assuming that last 'now' above
should be a 'not'? This approach is not going to be maintainable.

-- 
Jens Axboe



