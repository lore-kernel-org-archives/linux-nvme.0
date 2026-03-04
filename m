Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2711BEF8FEE
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2026 15:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IASyuc0Lpge3rc62OXbMLlxfZBYEvI2PXKwc7sE+pIg=; b=fe8VJAwXRqTN/jOg+S8bV79V8R
	ZjPUs67DAnYmwBzsEx7HcS9uV9g62z80jBoHAMMmTDS4CNpcVL6MBr5SFZz1bg7erdyECQWDxmptR
	LGEpd88hO8A/cOU63BiqSuXEj7C2Yp3xt259O8dOTm6ypoFWUbXGW2G5dnJrZuriLWs7TG/HfxAeO
	8VaLPlimuq/m8Q3cd76u8q1cxmG31N84yMUSr+jpnbWptz5tV40u7Tboi/MhitRE1FOmRbJihicHX
	Ifrk/fZlME0kZh1Rg4Cd60VNgdCEEOhyiOINngP+3dmaXRuRzhTyJDfMZflKmUhs7mchxQlDakD3E
	uTZoGsqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxnxS-0000000HWpj-0AxF;
	Wed, 04 Mar 2026 15:16:18 +0000
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxnxP-0000000HWp9-0gMr
	for linux-nvme@lists.infradead.org;
	Wed, 04 Mar 2026 15:16:16 +0000
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-46394090d2fso2483681b6e.3
        for <linux-nvme@lists.infradead.org>; Wed, 04 Mar 2026 07:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772637374; x=1773242174; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IASyuc0Lpge3rc62OXbMLlxfZBYEvI2PXKwc7sE+pIg=;
        b=h6zUwY6PJanacrXvTdjKV88evVmF4SQPVxEN6raM0d02jgy0WFhO5tn4EJjD9hPmm9
         y9mKxTxiEu1wIvVnZ1UxD09YhtFvKWx3AXPIN9yT14Z8O7bEnrD/ONehU5k+YjewtSQP
         tard079lyV7yJ3YBTb7rqFWNBWPBNnHvlouFSiY9VTWnPVZBKKfo1Wu4Nu4lrifAxZ3K
         aMgfeW9BHXdwlkBkDyJgQohaPFwJR8K+DYHirnhmW4l6taD/pj02WZhAS6wkHCFHy/mT
         lFKW3yWYhCLdDciYFrwfwJT9sSXBKE9PbMWF2nTGM3MXp0sofX3UUDORgAAmnR+fKoAI
         sgIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772637374; x=1773242174;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IASyuc0Lpge3rc62OXbMLlxfZBYEvI2PXKwc7sE+pIg=;
        b=Vx7zmZaEL2N/slcMgtqwdZ+ZbcCdSeDV+q8jTNYf2fOanPbpJyNB2wCNnU6CsLyesY
         IfNsAACmP4UH5yrho0h0/AbhiKN3Vq1On0zUVU2/hD4Kd29yPspMz55nDruPmpSB2m2c
         eTJk8h90oTFIwQueokQwbXIop+cHfwy9vdaKl/g395AaJnHznK3LV//kFMeLE+Og228G
         kvmlsvFJLUTyMBqHoRFWrbktSvIPSwZB4ZIJ7g4jWIZyUP9GO6nCy3usrQyODycVG7y4
         aniFP1XFO6RhJul1Ye/3i6l6bngx3pi7dj7QRh0l2QZzB7paFSEdGGpAqSx4OE57pk+R
         VHVw==
X-Gm-Message-State: AOJu0YwLUOWQDfW3EThQEN8JXxsH/YpDtu5HF1L9wTBFd5i+EsxDYUxR
	6BE4oZIBQv4GJeeFywklEAwFPOJupKisT8ItQkBNB33Hkn43k4OaeISaMrZySYKQHh8=
X-Gm-Gg: ATEYQzxKvzKL/+KX8pmMwvPen0x4C1FWAZVaPN4I8Q5eBFEev0rISyT9EaK1rOrSghb
	3rD0USDCFGOdLrLE3xNGjJoJjz947Hj9t9l4O/8jupIaLRmeNWeBKq0KoWPDVBHv1DOM+vjnReY
	XgSYymYk0OndbXD704cylhhqQVz8k/5c+0h2v5GIDhLAFqNYyF3DDgZzJ4A0i3iQ98vs9Pw4OP+
	VFlrICrAfPyh8i2LPoTWd2VdazVNJEmgEP6Bi23gZeuIcaqVNxUf7/brEBRgu5YyYnVXC45AWuq
	Uqn9RH6/JAkkP+Y++pdCkDfO/f9pxsbaJbv9JPuOPiCUDJn4sZ/JomPdaPDIVoa5L4eGXgOw8Y6
	lSOq2vHoeZLcNWEfrjXUoi596ofX3qj+mjqgyaHSKYuOX+XS/Aw+ZljZk27XHq7XDEQ8Arfa4Cy
	ko7Ih02ezC+pINoTG1aZ7dlNVPVhi+Tc8P6ECv3qzw3Wh7UNDUmX0IrkLNOXYLFCudfPlTesccw
	cYY/bn+PlaR5qYluy0G
X-Received: by 2002:a05:6808:c1e6:b0:45f:21a:4995 with SMTP id 5614622812f47-4651ab7db1dmr1169015b6e.23.1772637373601;
        Wed, 04 Mar 2026 07:16:13 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb4028cdsm11778565b6e.9.2026.03.04.07.16.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 07:16:08 -0800 (PST)
Message-ID: <c8f1f6cb-efa4-4422-b697-949e15004861@kernel.dk>
Date: Wed, 4 Mar 2026 08:16:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 7.0
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
References: <aahLbUJOav9p1mfx@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aahLbUJOav9p1mfx@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260304_071615_462777_F32186FC 
X-CRM114-Status: GOOD (  11.91  )
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

On 3/4/26 8:10 AM, Keith Busch wrote:
> The following changes since commit 91e1c1bcf0f2376f40ac859cf17d0a64a605e662:
> 
>   block, nvme: remove unused dma_iova_state function parameter (2026-01-13 07:23:39 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-7.0-2026-03-04
> 
> for you to fetch changes up to c3320153769f05fd7fe9d840cb555dd3080ae424:
> 
>   nvme: fix memory allocation in nvme_pr_read_keys() (2026-03-04 06:53:41 -0800)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 7.0
> 
>  - Improve quirk visibility and configurability (Maurizio)
>  - Fix runtime user modification to queue setup (Keith)
>  - Fix multipath leak on try_module_get failure (Keith)
>  - Ignore ambiguous spec definitions for better atomics support (John)
>  - Fix admin queue leak on controller reset (Ming)
>  - Fix large allocation in persistent reservation read keys (Sungwoo Kim)
>  - Fix fcloop callback handling (Justin)
>  - Securely free DHCHAP secrets (Daniel)
>  - Various cleanups and typo fixes (John, Wilfred)

Pulled, thanks.

-- 
Jens Axboe


