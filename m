Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281A5E77188
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Jan 2025 23:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kgeH5i6c77Vi9SpAO/v5YLgEyKLxn1Fxqx52BoKaQUE=; b=bYL9RHI2Z6UVVpnneud4dDiUlV
	JIbajhthglUN/QWUE04rxkoUQofyTe0LADrSAFMRWIXXz98LYmxvla/ToQ4S4bbG9/ZfBatf1MTVU
	onv7C4BRIYTkHN6vjz55h92jSriqnBYeCAcsjZBlCH1jrZgNiOuP3ZSxSK3DluF050KB392HUV7hW
	YQUkbyykiXOOKMMGFNQAya+8kVkTp8WZpMFmE+GYXgROOT8eCUIIAHzElTYkNDghe1MyL/iLcxb6+
	LcYF4+f3P+hR5laf0ZFXsMDb495KygMcou4rxff71bd3DHsJdcAenq9aXOVecv61z3jg3kU+6wCN9
	yIjXIsag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tX7Vb-00000003dls-1yzR;
	Sun, 12 Jan 2025 23:36:43 +0000
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tX7VY-00000003dlQ-19VR
	for linux-nvme@lists.infradead.org;
	Sun, 12 Jan 2025 23:36:42 +0000
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-84f1ea04c64so263779939f.3
        for <linux-nvme@lists.infradead.org>; Sun, 12 Jan 2025 15:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736724999; x=1737329799; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kgeH5i6c77Vi9SpAO/v5YLgEyKLxn1Fxqx52BoKaQUE=;
        b=hJU8aR4/eEGPuKpQi1qsr73VHQvrV/fOzNrT7i9k6a3Uz1ozU5bO9Yic0u8TAoyBNo
         RoUE7/9MI2Jyep49twMY8s5B8xFxuShfck+yhX86puVrKF+siugKjaubDT6N0WJHg/yM
         qHwSQBuwMD0UFfXLa8s3BWWfF79s+GsafADrx5WT6jjZwCznVnxisbX4D2e0gpXDVBQa
         LL/k/CQXLV6U/mA/UPbEbSxfZez2WxQBKMyrIRg1wwB8ai42Erciz/9/xHNXFEOIXs2c
         d05Mx3H2YTBCoSIqrd84w0DSlIo+c3nuXwfg6W/CBMvZeDg4qDk8RJGdaVfHXsVrx/9U
         yO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736724999; x=1737329799;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kgeH5i6c77Vi9SpAO/v5YLgEyKLxn1Fxqx52BoKaQUE=;
        b=SD/Me7KRvj+h3wcDG7gBJRPfgCbWmlrcvdTgk0F+JESdurkUXB7z/yPHDSN00vcQcv
         gpH2MkIw3UN0zGphVrphB81n3bNCL3ILZIaO0Dc8d2Vck044IYmN/a9ysc5aHGUva9M6
         q5sOKY9t2rBSiHyerOaliDEvdOCsVYDooOnhzUuGoS4QnaW9CWfZCYEBOve3dZ85O/tI
         lESWeUwLpEuy0yfdNEB2hkGl6tyF/PcYGa2OB00tzEmNJMwS17qOvx6vhtUTYsIUrXwi
         U/P8JKXIsEPM9hSQSpTk90wPHEt8+3rWCElPFcG1W++yIbvTQVDJHstcj5XvrHBpUEeN
         epCA==
X-Forwarded-Encrypted: i=1; AJvYcCVf24OGQg+ltofEsRg1IliCw92vDSvRK4bnr6A7mp03Ys0ejp+ciGVlLKROSDjJZjSg1Khb/u51JX04@lists.infradead.org
X-Gm-Message-State: AOJu0YxpibU5pZEMD9TVQndnHhvVYu02dsKleNNZkTROG1rS9IQuyRpT
	rX/bKS1oOccgppg/xcjI89Pc4zLfOSF6bZg/hua5Dysv0f3bLCblG5dEagBjMTg=
X-Gm-Gg: ASbGncvSCCOkYPHFKBrbszeRPW9sNXgLYpr1gN9obBcwmxhP8lsKzhORuXjov4qd2lT
	wTMejbijWu/kP6p+wQEjy1DAZA4lVuVzOfySn7lDZG2UytwupRnHG68t+F1r7MBIaeo7Ylzqckn
	DTpCvrNBW3Yn0hqMVVPFy+O0IdH/+oDSI/jJWvj6bSNGYDwi+7Pg4pBw6tZh0NTozvAsOaV6+nA
	ngNaXruOCg6bD6Rer2s7odNHeqNXRKx0zeBaQ30Af2taRtCdSdZzw==
X-Google-Smtp-Source: AGHT+IH7BQYpbyqdFV6WdVsVuiymgCOLuUDj2KP/ZUmJCMj8AUPoyk4/MqHyUci9xwjOXo5HRgyRQQ==
X-Received: by 2002:a05:6e02:1a4b:b0:3a7:96f3:bb3c with SMTP id e9e14a558f8ab-3ce3a86b0dbmr133818965ab.2.1736724998712;
        Sun, 12 Jan 2025 15:36:38 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea1b5f839dsm2396163173.6.2025.01.12.15.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jan 2025 15:36:38 -0800 (PST)
Message-ID: <baf1e3a1-255e-4ed3-b1ad-910f481da3a0@kernel.dk>
Date: Sun, 12 Jan 2025 16:36:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme updates for 6.14 (resend)
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
References: <Z4RAuMknJQo-nheX@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z4RAuMknJQo-nheX@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250112_153640_585579_487AB8AB 
X-CRM114-Status: GOOD (  12.81  )
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

On 1/12/25 3:22 PM, Keith Busch wrote:
> Please drop the previous pull and use this one instead. This fixes the
> reported linux-next failures (missing sign-off and semi-colon build
> warning) and drops the secure concatenation series due to build
> failures with that series.
> 
> The following changes since commit 844b8cdc681612ff24df62cdefddeab5772fadf1:
> 
>   nbd: don't allow reconnect after disconnect (2025-01-06 07:38:20 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.14-2025-01-12
> 
> for you to fetch changes up to 4a324970fabad503260973cd588609f3a26baab9:
> 
>   nvme-pci: use correct size to free the hmb buffer (2025-01-12 14:11:29 -0800)
> 
> ----------------------------------------------------------------
> nvme updates for Linux 6.14
> 
>  - Target support for PCI-Endpoint transport (Damien)
>  - TCP IO queue spreading fixes (Sagi, Chaitanya)
>  - Target handling for "limited retry" flags (Guixen)
>  - Poll type fix (Yongsoo)
>  - Xarray storage error handling (Keisuke)
>  - Host memory buffer free size fix on error (Francis)

Re-pulled, thanks.

-- 
Jens Axboe


