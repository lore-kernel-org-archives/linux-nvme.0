Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F26CD4F54
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2026 15:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rI7C+harLEOD3D+1WLwk6qnbQEE4eF1dnIlCrjDmQFY=; b=l6CksyqxwumDo/1BvAKLxCR5vv
	DrNlqnXh8l5dmRQhtjHdhtNc2dLznJtKD6ip4KKoEvvsisEzKxHLsX9QFCieAqmH2KTJMcjcqpMiS
	2LxiY5ZTFEEOyUZbgMX8DeNIatb7G37/awR7+/z8OOFwEojBTr954syQvymWYWJYIx4GUGeAw6G/b
	EVmeAA1zeDF67OcR8aMV2gHTEAJ0odQ9HTp5fDDqkV2hMWnJe4Cr8j+qpzCiSPiwhxiP8z6jSHOwU
	uQEjjQ2bGo12Oocp67URAwd8Fo2ClYgJyjyJOHRCVL/fm+8e06ALH2JOZdGyzRWVIFOrlfD7Xy0vQ
	v7XvCkIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wScm9-00000005vmw-2i2r;
	Thu, 28 May 2026 15:36:01 +0000
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wScm6-00000005vm5-2Ep1
	for linux-nvme@lists.infradead.org;
	Thu, 28 May 2026 15:36:00 +0000
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-7dcd17e19b6so7278347a34.1
        for <linux-nvme@lists.infradead.org>; Thu, 28 May 2026 08:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779982557; x=1780587357; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rI7C+harLEOD3D+1WLwk6qnbQEE4eF1dnIlCrjDmQFY=;
        b=WrQDIKMzW6/QlxSUcJQhft604yWa3lXosmwZUHT4P8S5JwOd9tFKlia8rJSEKHGmBV
         zCbvygvkL/TzcdP5tKsHcHOMPOvhPoW9FLD7eoB9kpJHLBETpAKaAl+gW/iIRmSBbdmB
         PBBo1HpSnsFPfs3ICj8bnl5iDaNtycwJxSLF839aljM3b7mO0npojBpcYod+7ogt9hXg
         1BsGmPa08hjYvVLmQgHysIe42Z/ax/+TWu6ITtrpFmq4XKZUDUZhVmwaq74DuVFpAHcb
         gBq+3YYPVnXs2fvXJ6QCLK0gfaCIqdzIH9rVbZUAkwy6JKP1PM3uau/9sP2OlknzRNk7
         qfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779982557; x=1780587357;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rI7C+harLEOD3D+1WLwk6qnbQEE4eF1dnIlCrjDmQFY=;
        b=Y2Lk62IHYtjCpHsGMl1/Yx40m3uZhnpIMHzn4USDGb0oKyLTFsLBQTbz7M0ArjBCoK
         SptcYjo4G8JmtvMzZ0CZfQLar+4UHk4PThHzJ/v601vK2exx1DutbJaKC2UvSUi6FQD1
         MhapHejhVYFsEaePSh+B19AOsaIRp4E8DzJhWH4zwiOxF9myK0r8guHD77R08/2sHXiJ
         dCZTwJvTQ20aPDuPmFcNaFYXmO3vHFShQerg+UzAyuzNBg/Nis+o1tAt+LXqS9WhHHFh
         5RQrll9GVrEJpZ0D4mF5wulsvwe/vfDnVXoa6pCFB5dfQmAay0WoqWA9vWXAuu+TkeQm
         4QOw==
X-Forwarded-Encrypted: i=1; AFNElJ9FobT4rxFTyatLiHuI0HR4YVVtMCnGBD11tYdVy1gLLtrP4JdJpz3a6cZk8vWcwzYBzdY+VTNaqPJf@lists.infradead.org
X-Gm-Message-State: AOJu0YwsHZT8GEyXhZ2x8N/s38/tPmVQHVicpT/5VCZHSTDAs/So+czE
	KgE7X/+9UeLuyuWCVJQ95mqLkQlfN3tzQjzMk0F6m7/2tekYy6j0EWMD6+LL3vNeJLqK4KJj0Qy
	VK9Dc
X-Gm-Gg: Acq92OHtafsO0IRcYtwlqUHQdJWw+xpuqbz3PWCpt/yTtDXKxuXWIJ2EIWZJcZSEl4Q
	JPbeS+65CnzlGaIiZCF4WwzVQ3mCfsy+ZjYpM55CNfxahAvyEn7Tm9QRMtV+OTkK8+h0t1MzQQZ
	Fc2mCP8Kxh9PPIFNzuHHiVdjnXvhqxL3g99hW1MFTg0+ZIw3UQ+mjRPVavKo9l5OJm1UCWCgycp
	6I85oeLqLV2ehAT0UaIS1GPPjLTwc6XKi58nnKC8aqQ5uLBJsias9CIu92Lmr2uHPeQBiXZ1hpy
	1Fu5oTpo7+wwKkK4tsa5JDLfyFvNW0Jjq3It7LN5It4Q/qXsCTOlkiU7+lh5xHmceud5onyLnNw
	YpYWs1NvNDDol4LIRti7x0ktldke9bQp0tLBPACS8TqliWYCJ9wh4aOW6ym2JhfeXBg1hTsJ43Q
	J/3UkwlmGLgOur4AAjL7R21pSofjiegEzbB6bfz6Bk+zSgB2UZVLqKTGmp0VugyyRehb6t35EEY
	oOyT+mrpLwrqg==
X-Received: by 2002:a05:6820:809:b0:69d:ead4:3300 with SMTP id 006d021491bc7-69dead44438mr3221680eaf.48.1779982557410;
        Thu, 28 May 2026 08:35:57 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b63976202sm17548732fac.12.2026.05.28.08.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 08:35:56 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Keith Busch <kbusch@meta.com>
Cc: hch@lst.de, Keith Busch <kbusch@kernel.org>
In-Reply-To: <20260528010041.1533124-1-kbusch@meta.com>
References: <20260528010041.1533124-1-kbusch@meta.com>
Subject: Re: [PATCHv3 0/2] block, nvme: enable passthrough iostats
Message-Id: <177998255663.134892.12620757795008304893.b4-ty@b4>
Date: Thu, 28 May 2026 09:35:56 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260528_083558_823406_54854237 
X-CRM114-Status: UNSURE (   7.03  )
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


On Wed, 27 May 2026 18:00:39 -0700, Keith Busch wrote:
> v2->v3:
> 
>   Added kerneldoc for the exported API
> 
>   Added code comment for the passthrough safety
> 
>   Added reviews.
> 
> [...]

Applied, thanks!

[1/2] block: export passthrough stats enabled
      commit: b7f40ab50190e2500c3c297d15e00040dca47feb
[2/2] nvme: add support multipath passthrough iostats
      commit: 7d6eb455ecf0f95c54257ae372ac1272cff834e3

Best regards,
-- 
Jens Axboe




