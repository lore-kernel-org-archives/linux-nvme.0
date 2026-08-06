Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87649C56208
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2026 16:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UpSZxsO2+OojqlTHRs9iVFREpITIpLS70LTpaRzcVr8=; b=bhEzOgLDYksp0aw2Fe3d9dbPB2
	bT/esdsQtYCRText0/wFKV9lHzEynZKsil5maeZXI66yJpwN8GSheko44yPRUU7TO+jea7u1hsTK2
	tHh4CuY1NJBQDYjmUSZB+3z0jBp1TypU9znR5ycbgX3oIODQ2OJXWtSUxc9UfIZCz70kL9+hgoA7E
	c84VmBfUtLzQILNw4AxtYW8WZcKYZMmb/0YdoWLmzVwvwrGKvhuy0LIUBjn53Q+pj9hkPzPjZd9eg
	3oCD2iiH33sRZEmaiyms17d2AxtQbj1/kbHEPeTU/X51jT3LviHG7O1c3R+vawdYQZ2IwvfGQjfUR
	kFMZbbGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1ws1It-00000006FxR-3Voq;
	Thu, 06 Aug 2026 16:50:47 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1ws1Ir-00000006FvU-0H7S
	for linux-nvme@lists.infradead.org;
	Thu, 06 Aug 2026 16:50:46 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2cc73e322dbso28431665ad.1
        for <linux-nvme@lists.infradead.org>; Thu, 06 Aug 2026 09:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786035043; x=1786639843; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UpSZxsO2+OojqlTHRs9iVFREpITIpLS70LTpaRzcVr8=;
        b=B1MiSxaPBrkL0Go7jwBgRzVuZfJqpyMYbOPAUknSi8ciVNsEB6s/zpe/bc8lm6xTtV
         S0+IsPfkLjIXPXko0sevl8cPNiwOxANp7pKXe/dFw2UUMruhgzuFz07mOKS41I5XVmeo
         lDjbkr+G/kreOEjO6WM5cCND4E3WmNihY+QoM238GYBqeacV/yMx7z0KwB7RjbWnHyqu
         gKtqIUoWBsmBEHV1rwqIRIh7M70MiELddRp69BKtx6V2syiUE829yWUWdm34ZCenChyS
         XjfQarU78Rle2s5M9XTPw/05RKalMu3EB1mrBdKNRo2x5GYY9QdpI+hGLiHjHgShgt5D
         6yxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786035043; x=1786639843;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UpSZxsO2+OojqlTHRs9iVFREpITIpLS70LTpaRzcVr8=;
        b=INN2s80CM3oLBTkpHuQfJJO8IcKfOOm60xnHfTEw/QRtbuPiXOH2JY+ZZ2ChydIxNX
         T5PLCVUo4uUhgYzopMg/ubCHkmNYnY6/eFwx6iKlBMAEROmfLWDSb9x/Q1fAOxMf7KLi
         6JH9KE4vGbbxZIwSkzEMrY6h0mExbemZVEJuPYIH35JsCn20CqnJIgl/7L1Lt2PGCx0S
         St6nA4/tRWgpcxXmdBPPwF5zBWnFnL/srSGZ2uyUuq9NnPegMqyyMThYzoMP8xuT1sLz
         URro809O/+E2zVtL5+0gIFaVEybmhFA6ON+BTwnYHY3dTHiWYPP18LsJlUyqF9y1ikib
         uRPw==
X-Forwarded-Encrypted: i=1; AHgh+RpJXxQUbr22urWEQBoa34RFxdFRYu5kvQuMrrEaLTBK/pezbX0IPE9NHY5o4ABB2gx3EdaCfD32yZnN@lists.infradead.org
X-Gm-Message-State: AOJu0YwVjUPyn78SPLq/m/PH6w6xQp9jAw0hUsjMB4mSEIlnqrIgzKJO
	fNreplGkcJjXy8NzynVbtWsULoXTwY/IAZgvhqcghVv2uMm02fzrIBL3
X-Gm-Gg: AR+sD101eUYjVYcKyRR7oHrIgM4LkDY1SdY+vb3J+2zod6I20plm8naPxD/n9l+9dg/
	PEmb7xREhsFAp6s48n8n/fsxb5JvE9d7g8Kjy4OHi4cA7XdhyySpRtj7OTjnxJQy+AGVftY8EEj
	tiSj32NLN5O3zgQTRa67ag3CRG2bOanP9vKVBMaQISLRws8PkrpqwzaLf5phmmcoD+6f9bUyCiy
	ELHOMDwHEl+KXzdoxRQbURyrNNld4XpHHAB4PSqoFgJy1V122KPO7tAG8oSwZnoxK/CmnteB4We
	haKiqlONo0t5Z+1QdlysASei3dObqyC0mf684DZGYVGiHMTdXEyWcr4vliJP4CmqC2XfI7IJNFX
	t/Moqlmk6y6IVdFEVM/g22nuNuVrBNYVxMouiM+GDFPclExwYnl/LUjv5KvSXFfs8t11TiaTe1D
	qIcE3vPVoYZhMbsSHohIKJArFqk4VRp+BD/yxZz4ijhDJx5m7Do0KXhfoj6TdSLXmxUgTd
X-Received: by 2002:a17:903:2ac5:b0:2c9:b8b7:5d27 with SMTP id d9443c01a7336-2d0ca712d8fmr201739305ad.1.1786035042793;
        Thu, 06 Aug 2026 09:50:42 -0700 (PDT)
Received: from [192.168.1.113] ([223.122.38.120])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa4ec8c7sm34434975ad.80.2026.08.06.09.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 09:50:42 -0700 (PDT)
Message-ID: <0ea8c38b-0230-4ef3-acac-e43208d7c9b2@gmail.com>
Date: Fri, 7 Aug 2026 00:50:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Apple NVMe fixes for macOS 15+ firmware / M4 support
Content-Language: en-MW
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
 Neal Gompa <neal@gompa.dev>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Arnd Bergmann <arnd@arndb.de>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260806-b4-nvme-fwabi-v1-0-bde19ce8db04@kernel.org>
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <20260806-b4-nvme-fwabi-v1-0-bde19ce8db04@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260806_095045_119344_E59C1290 
X-CRM114-Status: GOOD (  20.43  )
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



Sven Peter 於 2026/8/6 晚上11:27 寫道:
> Hi,
> 
> This series fixes a bunch of bugs that were working fine with M1/M2 NVMe
> controllers with older firmware but are now starting to bite us.
> With macOS 15 a new firmware is installed for the controller and both
> XNU and the controller are a bit more strict now. This firmware is
> required once we add M4 support.
> 
> The first patch fixes a panic that can happen when the controller fails
> to initialize, which now happens for the first time with the new
> firmware. The other fixes then make it work again.

For the whole series:

Tested-by: Nick Chan <towinchenmi@gmail.com> # pre-M1 controllers

> 
> Best,
> 
> Sven
> 
> Signed-off-by: Sven Peter <sven@kernel.org>
> ---
> Sven Peter (6):
>       nvme-apple: Destroy the admin queue on removal
>       nvme-apple: Don't set a DMA direction for commands without a data transfer
>       nvme-apple: Never set the opcode in the NVMMU TCB
>       nvme: Add a quirk for page aligned admin queue buffers
>       nvme-apple: Require page aligned buffers on the admin queue
>       nvme-apple: Drop the PRP null check chicken bit
> 
>  drivers/nvme/host/apple.c | 32 +++++++++++++++-----------------
>  drivers/nvme/host/core.c  |  5 ++++-
>  drivers/nvme/host/nvme.h  |  7 +++++++
>  3 files changed, 26 insertions(+), 18 deletions(-)
> ---
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> change-id: 20260806-b4-nvme-fwabi-000386148b21
> 
> Best regards,
> --  
> Sven Peter <sven@kernel.org>
> 
> 
> 


