Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC39C369D5
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 13:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YqXVyyxnuwcD1BIG99/aSq9M/jNFiAFkfCwzRkuTtlE=; b=ayhkuGnmsmHzHHlCx8aQ93VZgI
	AyQws59GPPAWW8aTFyVml1sSGY91eeBVJL8LxImlHNee8x7vdkDssJ4KyJAW2S82/GoSQBE9F1ifL
	OxQRpkRd2a7Dpk03RCknGUfWpfjXrY0+Nj/5fJHnS9QmJFE4BVAtwbgF5pIClgQvOdmKNF7flFEGg
	EK0GL5LMecQRWKmHplvWdxghh/nALjXEtEOSGoS6dZiF8DLnNUKIZWIPEV3fFN4V5PNNc6TgsT7tE
	6d2N4n0E6lvGzzxtWbV1GLJnAQs5VKvVsMyuIo/j/U5tYF1dJD2BAudlR41WSl5wr0uMDlbIadziO
	EulreIFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7wwm-0000000EFG9-29Dd;
	Thu, 24 Apr 2025 13:49:00 +0000
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7vgg-0000000E2Wk-3fsG
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 12:28:20 +0000
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-3d81ea55725so2920785ab.1
        for <linux-nvme@lists.infradead.org>; Thu, 24 Apr 2025 05:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745497698; x=1746102498; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YqXVyyxnuwcD1BIG99/aSq9M/jNFiAFkfCwzRkuTtlE=;
        b=ml4Q/IyGjdlVEghrllLyGRCjxKfXJmgXBM60fIzJ9UuMFCxpdg9FSgBP/yn9PYOXUA
         BzPbsXau1r+eBsQojeBDyPQNEynvAHBVrwLZkpygYanlzctXGL1DGgBSTSTTJ5wBhIjx
         I4J4xjonLgSYqEBkPscdXRPFtN/AOvSmXphHVqFMemNT/NbKobY2pXKvgifFf1NUDU6j
         H5lMmG9i2KvjggqSPdOmpmPq9ja/Hn645CRp6299SMjRYb2mAPJCihQgn3q2F0humLme
         S69EFqCzp6gpJFWFjeXP2+KKVHGtg/H/eVlr0v/eUtqDsrrXYmShP5bdqJqnwUYzecNA
         PL5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745497698; x=1746102498;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YqXVyyxnuwcD1BIG99/aSq9M/jNFiAFkfCwzRkuTtlE=;
        b=DcfH0JB6kprItbl/khGlR0gbspNb1Bg9VGEeyvu0PYtx68ZFVBsIeISLCRpa8aoekH
         aeyskAqdtbdjkSay2Set5U9dwvXE02S4aCIlMscuUSqzj+1zrjFDx0L5zrKgRcVDIoTX
         eNyAg1RLEhdGArbnsvPFmEXtS4fskDerVymoNsqbYhPoU94sGgKwSw2L60GgWkLg2FaO
         hp+uOHTxIWwqocC5C6/GArbNJ+zxMfoj1Hzd9D5sFMthrR+YT/ZoVl/SI1eZFcJym9Gj
         A7GJjk/gyscRnaEO0cK0E32imrwIUrOpY4vkx/1pOlnDdZT2G4soaxfSVcgjYhAEiHPf
         st/w==
X-Forwarded-Encrypted: i=1; AJvYcCVq5Kv7oPOc8tXwJkZbMjhihvJp5gC7rhtXaLaTDxg91Y3NRRdJ7kCRJxFOaepQ+oBS0XFZ1qoPTvjy@lists.infradead.org
X-Gm-Message-State: AOJu0Yw/cunLz9zNinC6O2CWEbvAoczJtjSVXUDC/QcTxxZ2Q/UAWI2b
	mohacOJ3fHqBfaSaPRJLBZsddD4cSu9WlkuSE6X1ExndA7gj16cOodEdxVYVUQg=
X-Gm-Gg: ASbGncvhctpqykr+M9FPXZ17i1z+vTcUn0eWMJJ5wbk9jR5Nf5gPEV3aMDBq5CfyxEg
	QgTTGhWb0QMps079Fwt5mJtnrk0sgFImuvupVqL/sodAoS3tu4QC/3HDKArlsIXAP5O5w/d/SDN
	ONYVyza7XIBSE8+ZN3z/flsJLN2VZMywLHX7h/1CVaQ48Zn/RKXMeccBAUwiiKmESKfzgztzsYL
	qjtnUrk64l+tKb1DBaVQc/ZJ7+dz7aJ+MZx4tGR2KbL9SHgz/kUDseCv25tro8zVnlifHme9S8f
	hI3tsVPzlsXSDcIiTDs66yKhuxZiGP2ezCY8QQ==
X-Google-Smtp-Source: AGHT+IG1bJLMbknqw2vpRhpLjNKOGnQXUnkNLIjQIrHWKNvSaX55zTaj96I5pBS/AwFgSDAJr+z7eA==
X-Received: by 2002:a05:6e02:19cf:b0:3d1:97dc:2f93 with SMTP id e9e14a558f8ab-3d93041ad0bmr23964145ab.20.1745497697784;
        Thu, 24 Apr 2025 05:28:17 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f824a40ab1sm256606173.40.2025.04.24.05.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 05:28:17 -0700 (PDT)
Message-ID: <faf4ed42-1842-469b-b052-c88a8324ef3b@kernel.dk>
Date: Thu, 24 Apr 2025 06:28:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 6.15
To: hch@infradead.org
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
References: <aAofJOcb2NzkXsP9@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aAofJOcb2NzkXsP9@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_052819_120596_7C8AB370 
X-CRM114-Status: UNSURE (   9.20  )
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

On 4/24/25 5:23 AM, hch@infradead.org wrote:
> The following changes since commit 81dd1feb19c7a812e51fa6e2f988f4def5e6ae39:
> 
>   Merge tag 'nvme-6.15-2025-04-17' of git://git.infradead.org/nvme into block-6.15 (2025-04-17 06:18:49 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.15-2025-04-24
> 
> for you to fetch changes up to 3d7aa0c7b4e96cd460826d932e44710cdeb3378b:
> 
>   nvmet: fix out-of-bounds access in nvmet_enable_port (2025-04-22 09:50:28 +0200)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.15
> 
>  - fix an out-of-bounds access in nvmet_enable_port (Richard Weinberger)

Pulled, thanks.

-- 
Jens Axboe


