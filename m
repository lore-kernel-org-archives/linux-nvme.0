Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2520CE77188
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Dec 2024 14:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fwaa/EgDeMA9up2TWsDbHlLa7APuFdygjy4wgwg8iAg=; b=Dc657pBBSalm6TwIEf02tmXRre
	jZQU4csAi0mUDqdi3QhBBUt0mwrA++fKUvQ4Y6TkgPsQ+hhhLDDl6yER2XyBAfKAAjr98ZfrVe34w
	6u1HMHjq2gyX0vfDxT7+StrUMu8hUz65OXldDR2ZoxTLy0UPltGM5IdosbHLwNmzh/VcqyqDszI/q
	in9K5JgbdaavhtlpqbidC1W2i3FtSpMiLUhSpyP1ELJaXnlHQsHyrCYx6ykb2AxykrJVMzFvr4YZu
	53IORA/Fn4/ymAmskkoV7VCvy5yTRtsDB5EUn/Js3TamEVelT8Qsd+WmPWd0Vde5XsZJzPpLwbBfB
	1+9BfxLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNuwt-0000000GpGE-419D;
	Wed, 18 Dec 2024 14:22:51 +0000
Received: from mail-io1-xd29.google.com ([2607:f8b0:4864:20::d29])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNuwl-0000000GpEL-3dzL
	for linux-nvme@lists.infradead.org;
	Wed, 18 Dec 2024 14:22:45 +0000
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-844e06e5d11so189149339f.0
        for <linux-nvme@lists.infradead.org>; Wed, 18 Dec 2024 06:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734531762; x=1735136562; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fwaa/EgDeMA9up2TWsDbHlLa7APuFdygjy4wgwg8iAg=;
        b=X5oKfKH2JjcEUwa5TaiRp2X+p/uQW+UcmapNPJSolnsA8jWSa5EY2j4MaqKV/GvAbJ
         RroKtQKEKffhmFZE+XTXSD1vzF4tn8W5ct11XwyMZijSuR4xmM7tTbSDvwgSYR/+OhK2
         kDep+/ZrcbebfFyXJARU7yab1PhpHp658FwV9vGieqyjcy3ADGZFSYn5Hc2XsLa2C49G
         3AFb/22Sbpy1AE0g+uv9Whwe/CzbzRNAt3wwZnB0svCfQjuiyCDvyrpwvI9WASFomk41
         /F+4sxq9ZDr0pKc95AYE5dFvKqUTnc/GeKYWVZwLVo4xHg3lixzQqhGIp747QuRZV46o
         cAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734531762; x=1735136562;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fwaa/EgDeMA9up2TWsDbHlLa7APuFdygjy4wgwg8iAg=;
        b=VXttbcNvxrHezTVmYHFhixm4XLUXBrOm1Bt/InqYNNKsifXaNkLaVm9KgB0fZcb+RV
         lJnViPg71qKd9Ra1yejqnc1MBA9BivkGvjuNOyY/YlUlreH33tr9RDyrSLlzop7+HNBn
         E9fUw26RFqWIUCpAZP9Wa92kyV4nhybGEIGHGDf3+c9PWUQzf3b/JZMpll6sUuqvhers
         KQAbYbyQzRqnnbJzZesK8iz6W3KYsxmln0+8Jkr04sNI5ruccU66SBZZJmyorvALTdhQ
         UAaznywvJHRCzLOkefYvw49ASBxA2W3A7odMLCaOpRSDJiK9meizqfNb3q+k40GLo3dU
         P7sA==
X-Forwarded-Encrypted: i=1; AJvYcCUHzQC9KFl4izUo8SzSmzG0ydLhwaoPiSFeof9eC8UPe/uJKwOZchH4uZ7aKEBu0flalenwLEZyui9x@lists.infradead.org
X-Gm-Message-State: AOJu0YydKcVo+wd/c6LsNhXE+FH4S2mfYMKV5PL1meRGY5ZyPSg3lE92
	KvBZq75ymuWh2An3rVMiWh6zc863OJKfqaP1oyBg0GstjhVYay66DKx5UyGj+UU=
X-Gm-Gg: ASbGncsYcSHmSzo2sRqNzwDeM02hkh1L81ifn0R2oFMEXDMpCZK2ocng2QeXonGoOxH
	7fCt8bixaQMJSAyOILYaDcEm+pa6hybQAPDPblp5P9QEsFTKW2HPdQ+a8+myqnuTG0Ch57xrM7i
	q5TY6PXXPlhEiMWmMgWs941rKwtyOO899D8H7VpLDBPNQUhCNrCV1q5DAvO++htRD/xPrsqSmvU
	V8Ad0TO/QmBUZmDaKSn058WaG9mMgv2ep4aU4kctHPQnBc=
X-Google-Smtp-Source: AGHT+IG89IFUUyc3IF//BxitryJKyat/xuxYfF6x/T3Q0v8wGvopf45eNMGXg+AVFNkeeO+fDQ1W/A==
X-Received: by 2002:a05:6602:14d1:b0:847:51e2:eac with SMTP id ca18e2360f4ac-8475855c0b2mr288106139f.7.1734531762581;
        Wed, 18 Dec 2024 06:22:42 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-844f62583ebsm231384539f.11.2024.12.18.06.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 06:22:41 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: hch@lst.de, hare@suse.de, kbusch@kernel.org, sagi@grimberg.me, 
 linux-nvme@lists.infradead.org, willy@infradead.org, dave@stgolabs.net, 
 david@fromorbit.com, djwong@kernel.org, 
 Luis Chamberlain <mcgrof@kernel.org>
Cc: john.g.garry@oracle.com, ritesh.list@gmail.com, 
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-mm@kvack.org, linux-block@vger.kernel.org, gost.dev@samsung.com, 
 p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
In-Reply-To: <20241218020212.3657139-1-mcgrof@kernel.org>
References: <20241218020212.3657139-1-mcgrof@kernel.org>
Subject: Re: [PATCH 0/2] block size limit cleanups
Message-Id: <173453176105.594208.15853494245370355166.b4-ty@kernel.dk>
Date: Wed, 18 Dec 2024 07:22:41 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241218_062244_117534_E169A523 
X-CRM114-Status: UNSURE (   7.17  )
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


On Tue, 17 Dec 2024 18:02:10 -0800, Luis Chamberlain wrote:
> This spins off two change which introduces no functional changes from the
> bs > ps block device patch series [0]. These are just cleanups.
> 
> [0] https://lkml.kernel.org/r/20241214031050.1337920-1-mcgrof@kernel.org
> 
> Luis Chamberlain (2):
>   block/bdev: use helper for max block size check
>   nvme: use blk_validate_block_size() for max LBA check
> 
> [...]

Applied, thanks!

[1/2] block/bdev: use helper for max block size check
      commit: 26fff8a4432ffd03409346b7dae1e1a2c5318b7c
[2/2] nvme: use blk_validate_block_size() for max LBA check
      commit: 51588b1b77b65cd0fb3440f78f37bef7178a2715

Best regards,
-- 
Jens Axboe




