Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB7C5C369C2
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Apr 2025 12:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bCVyYVrtKOBFzuIw/BRxSXJq2vJQsJUFfVx+zDaigBY=; b=hjIq2s2h+3CeF5+Ma0GKUH4Do5
	l0tFSUDSaaHwD3jltaBmrIYtJU/zfvEvxNm9+9BF/Ei6c+9jN1C4u0xURj2jH8sgKIqdQ0XRiTxzw
	AwW/0D7VjaiKJNB/fOKHg6ltxYP/VylasjbSu16HePr1AqMZHcWqm1g5FHme7Ubyc64GafZcBzdxi
	uDoUpUyLWUAyMzLFJLRedj5j58DP4fl5xclr79SVQSwrr01VVFc0bjTbIuHqxVQSHE5nChby50jZv
	rt7HA9VXuSqYWCezPwX/5Je76KzAZwqftbi29OJ7Re+83xvvT9GLHg15d2Ky6cQ9n+MJRwNwf5rFp
	eqS/he+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5OTM-0000000Cyye-1mIY;
	Thu, 17 Apr 2025 12:36:04 +0000
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5ODH-0000000Cuci-3GsR
	for linux-nvme@lists.infradead.org;
	Thu, 17 Apr 2025 12:19:29 +0000
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-8616b7ad03bso11492939f.0
        for <linux-nvme@lists.infradead.org>; Thu, 17 Apr 2025 05:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744892366; x=1745497166; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bCVyYVrtKOBFzuIw/BRxSXJq2vJQsJUFfVx+zDaigBY=;
        b=RMMFb+cNE6Og/paW91kVT3Pnxjb6K0S+Dy4u6/T+ixr2fiPzaiF4vNVjM3termI3Gl
         K9EgXbq2U3dhpqyyzqNpTOgJNFqhsjncCjqj8oaYu0XTNMbPx/nmp+zIKWY5/0LgkDgj
         RC7Vlzt/4CVk+K/WqAmWw4ija5a+fnnVjSeh7nTxnU6ZNB8kjOsjwbSlIAeplVFaqHyW
         905w9Zphqo9rAGawx/jmbvAHMTb3kwaZF6mXXONh8SaFxIJNRXw+2VYaoCsEwHEX32x7
         VCRnACiNwSATA2GFCAg4qhCrEcvQ7wajtLAyq7Tw/sCqaItp0RayAhUVABXB8UrZuDEz
         KDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744892366; x=1745497166;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bCVyYVrtKOBFzuIw/BRxSXJq2vJQsJUFfVx+zDaigBY=;
        b=SJpH0sqnkqOm7dIuU2RU/Sj87bm04yiA7vm+QnG8DyC2RTuQUSlD76wU5nyscn7wNW
         L6GOjmApr/Ld1DFDa9GiUVrSmloiO20vQv7yHM4GvpT7dPDj+SpKMz20Hhi9tgUr78yT
         Km6g1NfYPGhFqgRwfSO+CkqoFVAN3SkzyZShPU3cMnl1mj2TexoxAN0Tck7tQTml5ZGS
         wPl28tJy17KvUEPKqvrWxpwxkSMwkPWSUAR6PVnBCu8CYQHt746hpr/+OHgZ6oLDahL8
         eBSljJiugMtiho45Vv8J0jaj18iNov99HJBoU8ReEdgMsHbRhTTAt00Dykrr7DcNBP0h
         drnw==
X-Forwarded-Encrypted: i=1; AJvYcCXBjDN0eRdXMc1/YIhIg3cr0Jz1P9gobGLo6afYpw6HtEv4Oy0ymfJLmYJdugRkh/j8hnma7qYR8nAS@lists.infradead.org
X-Gm-Message-State: AOJu0YyFiZKJux8Y/ml8LDAwCfAVW2ODIZuiYY57dFHo1n27VApX/4B5
	rKKfboR6SptqbLrK1HH2g3A4VEHsDdQrQRDCAwodYdjYgs6OCy6wNoZj8Dk/CTM=
X-Gm-Gg: ASbGncuMNk6l9pbFn4fXqiSAb6lOQycuuLZEymmUnoPe7EoXZkry1g7LLOE7wyzX2BN
	SGMLoej17K+484kzacH16lSQoT5Sid0tE1ZmSF6+zAxWVvhvfo9CAR/Cja1QtMR9gyOixL84Eqn
	UU8nVlDPumP6cfLzCOaM1P9jcsmpOUMXdynaQgdeZTZzBwah90LdwmrPLIJtujIgEtOV8TSnG8S
	uruu5PX6D6X+jjuFliLAROOxUF7/iMbMoNm01VJ/cUtMvAnDcsaWsON3KqB4un5LhqEyu91pyy0
	c5Z9ztatABr45+BaCGyRFNN9pKF9B7ZlAUvTkHLpuIG9e0mv
X-Google-Smtp-Source: AGHT+IFxN2fVUF8+aXwwbC3OrT+G4BayntFAvihGJjXPkvu6KzSNQ0SIqbg1CP/sS7JBnPH5xE1/vQ==
X-Received: by 2002:a05:6602:4006:b0:855:cca0:ed2c with SMTP id ca18e2360f4ac-861c57bc69emr600785439f.10.1744892366322;
        Thu, 17 Apr 2025 05:19:26 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505d16679sm4193000173.35.2025.04.17.05.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 05:19:25 -0700 (PDT)
Message-ID: <b84e959c-c8a9-4f73-aaad-5b905117e3af@kernel.dk>
Date: Thu, 17 Apr 2025 06:19:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 6.15
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
References: <aACj5pg7dLAsfZ1u@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aACj5pg7dLAsfZ1u@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250417_051927_954254_6B4ABECE 
X-CRM114-Status: GOOD (  12.08  )
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

On 4/17/25 12:47 AM, Christoph Hellwig wrote:
> The following changes since commit 0b7a4817756c7906d0a8112c953ce88d7cd8d4c6:
> 
>   ublk: don't suggest CONFIG_BLK_DEV_UBLK=Y (2025-04-15 18:59:33 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.15-2025-04-17
> 
> for you to fetch changes up to ad91308d3bdeb9d90ef4a400f379ce461f0fb6a7:
> 
>   nvmet: pci-epf: cleanup link state management (2025-04-16 07:37:37 +0200)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.15
> 
>  - fix scan failure for non-ANA multipath controllers (Hannes Reinecke)
>  - fix multipath sysfs links creation for some cases (Hannes Reinecke)
>  - PCIe endpoint fixes (Damien Le Moal)
>  - use NULL instead of 0 in the auth code (Damien Le Moal)

Pulled, thanks.

-- 
Jens Axboe


