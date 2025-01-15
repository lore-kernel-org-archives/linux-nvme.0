Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC13C02180
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jan 2025 22:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TmHk9ku7HsIAIqngNhPvX2MlnH/qThmCu/mj7763gkU=; b=pGpcD+fTtgzGqVM/kFv8/1mmuK
	R8NXFxY7+p/PKdR649mqyOGmsrck3/xIfN3TE0hbsZ3GlfIVI8B0y0Bbwh/77TiXdgS2x5Y9+cnm1
	OdyDmsu1zwgsYxjmlGTaUkflRab+AGZ3lOFer9Hl1gte1885ELR8EJt2SOn2cm8O4f4or4MAz6dsn
	cTvAhBv/yq1hUNhbiQEEFfR3CWnZbYcI6lGctb4thu5flOg9YXdZXjCXl7u1/JVZJbPCxETFIqL/7
	FS/RUAi1Ww6RoCHAcuV0/T7ip36jSzEBB0Zk+XeTaE24r6xZPdIXicDFV3LntzKE9Jb/t0GMUvGbF
	5DvTX90w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYBy9-0000000DFz2-3pf6;
	Wed, 15 Jan 2025 22:34:37 +0000
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYBy7-0000000DFyL-2PPg
	for linux-nvme@lists.infradead.org;
	Wed, 15 Jan 2025 22:34:36 +0000
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-844e61f3902so26572439f.0
        for <linux-nvme@lists.infradead.org>; Wed, 15 Jan 2025 14:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736980474; x=1737585274; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TmHk9ku7HsIAIqngNhPvX2MlnH/qThmCu/mj7763gkU=;
        b=3UED0mCXy7PBz11+dtI2tI3BgqrM3Vts7algzagEMGRM0Bho2SdAz7Kn46gie0KSvG
         xSfudVp/uTERosldMUa0TPX9Lc99kGbsD8Oyvzs7oSDoZMxLCsBwSNvxxISA+E++dOvd
         ItZL18IWa3cuj6VLAZUuWVfT0Bu13t5aX+ME9Rqdx+TB4dUO/q48jJ/k9AOJJcJFwjiR
         xJs3Cejxcoj/6fXWMwXhSddAYu0CGTLfDidgigEb+qUqFPUFGyVGaF59i0DSYI3eJQ1T
         FHEltSzt3OJ8NlWXlD+24pHC6wNUFvfx6BPOW//pBlspTCKz5oFMhIQg62NP1oXXFqAd
         7j9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736980474; x=1737585274;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TmHk9ku7HsIAIqngNhPvX2MlnH/qThmCu/mj7763gkU=;
        b=W+YFqargSosEelV+sRS6HTTlAEMI84Yo4+8r02fpinKzHnaHSjKVIfw41xCLNWXj/V
         KZ9QEnaUTh/c4FnmU5k3wRL0bt7i+gtQcM+LzV/c9URDuM91ngbSYuTkNDaHVDnV3KFI
         +irZLJLEiLyojxu4PD20pbFnHlLs1D8hciX0kk6iL/7fhesilUOSZnBh58BtyrZ8eblr
         +LjheAF89vu68lz12pm5iDJ48BIhqd2tgU942ZhZDC1hyOUgn43+BNNbdnh+rP3GIGOr
         XOaRNCgOFI2DujVNYYTcTUjg4BfIcO4Eq/7P2v9UfpKSmLaJtWihEvG9Vmy9WmmIhexP
         5KwA==
X-Forwarded-Encrypted: i=1; AJvYcCW2qR9S0+YtbjZPLqJURGSeGl4nvXR6B6xlScZmCuM6taHMYL9wcnP8hqKPNaSaJRohobwlmzeeBoVw@lists.infradead.org
X-Gm-Message-State: AOJu0YzyKJF6iY0o6398e+La81YclNEiZ88j36ptDTpOpbcYCUL0JFGm
	H0sgJ9j7lx87Ac+tcymuZcJec6xCN52NSCk3JQeV1VPGsCTMvTdanFJA3gYxwJE=
X-Gm-Gg: ASbGncvyQkY35W9J73jw3v/QElcDaCz+6hgn2UiBiZe99QNXp8defhHe51vDK898ZfD
	FKiptJpLu29tT7/0EaAOXqEvHqmT2Pv0r7cLgTyUoeZ539JxP+Njoto3wzSPBBDEMLbVfsVLyuv
	y5JS7rgl817XeIRGnaHw+qzvSUewqUXya3dpK2unVxnsL+v89QE8BDfGliRRGcwa+wohvh0Du65
	vm9S23oO150hwkqc7JOC/oYYymMB0upbFhtOzwHhAK3EftxLqPvjQ==
X-Google-Smtp-Source: AGHT+IH1Yt1wmWE7dGk5VvlpuI6GAcJqQoMsb86eISyxIBLrUYCXqALU8XwrGYsTd6Jc9CI3OtXIFQ==
X-Received: by 2002:a05:6602:3817:b0:844:e06e:53c5 with SMTP id ca18e2360f4ac-84ce00d4878mr2830432339f.8.1736980474617;
        Wed, 15 Jan 2025 14:34:34 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-84d4fb52d34sm418073239f.26.2025.01.15.14.34.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 14:34:33 -0800 (PST)
Message-ID: <24cb1ed2-583b-4dd2-98d4-29b7cfb72df4@kernel.dk>
Date: Wed, 15 Jan 2025 15:34:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] nvmet: fix compilation errors
To: Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, sagi@grimberg.me, dlemoal@kernel.org, bvanassche@acm.org
References: <20250115221703.62861-1-kch@nvidia.com>
 <6ca7f59b-f232-4bf0-984e-a4439e22b9ba@kernel.dk>
 <Z4g3z8GWgoCQd8Kh@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z4g3z8GWgoCQd8Kh@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250115_143435_619223_ED139267 
X-CRM114-Status: GOOD (  11.10  )
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

On 1/15/25 3:33 PM, Keith Busch wrote:
> On Wed, Jan 15, 2025 at 03:22:05PM -0700, Jens Axboe wrote:
>> What is this against? There's been no changes in the nvme tree since I
>> pulled it, and it doesn't apply here at all to my for-6.14/block branch.
> 
> It looks like its against the merge result of the secure concatenation
> series, which as you know has been withdrawn. So this patch isn't
> necessary.

OK, so that makes a lot more sense. In other words, it's not a problem
at all right now.

-- 
Jens Axboe


