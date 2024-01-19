Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF0EC4725D
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jan 2024 21:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HMqalDxMtWXRWw8mRuYXoI3Qq2FQfasx9rH0LZ2RkwY=; b=O2Wa+Jwkx7klEWJf2ayjSFv7nS
	90h57JAEMlXplizRUI0Y1MtiY0qyMdfZwMtw9+nptvzdqKJEL30pY5YiRJn0MXRoO2WGdiWwhVYlm
	SlyZh6FpjRYYBjlkAGh39cr1c3m1a/FUL9BbnLMU6yP4Br9roZftG7v/AYZk05rRraeHnu2s23Dk3
	PWfibIt134p0556QRag1K95fmEuAE7Oji+t8Y/3MgVtECSCyPbaAUWQ2/zUz7+eFx7SgHwhVcBssy
	llO79oeYVdsqqU139XYUt/7ycIwMCrK/JKkpXR6DNRAYSlwCrXqzbUFbquCATbfWqDlvnAF4g82oU
	1EmTN3wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQwJe-006d2R-28;
	Fri, 19 Jan 2024 21:22:18 +0000
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQwJZ-006d1k-2v
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jan 2024 21:22:17 +0000
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-3608ec05dc2so610685ab.1
        for <linux-nvme@lists.infradead.org>; Fri, 19 Jan 2024 13:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705699326; x=1706304126; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HMqalDxMtWXRWw8mRuYXoI3Qq2FQfasx9rH0LZ2RkwY=;
        b=eCHikuGBp7lrBia2VCRqjPb03o9+D7OgNxfi6y1VdvBrhh6olaQ2/DCMer4/zJHLJ/
         zQklIA5BuCQ+CJu8j+jn3/Zi7DqGRKYkfbFQ1g1on6jE35jPJmhQm3/BDDLy9CVdGZIN
         IaRzexBQK9gPWIKBkf5MhBCNhaXerWFU81ZsJIfCvxCQRibcMGWlFLoPPdvbbE2eSXJy
         CrJ1EGWPgvIsxO4H/cPROeQ3pvNPrVOcH4/0J5I0uk22dt8TYKYyEIodNwZUHGPojxsf
         QAhDTTG3NuXWCs0fWQKFFhmebTgTpAkPPCGRltVruj9W26Ow8Gf7JYiJiBDTPP9RhVwR
         UQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705699326; x=1706304126;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HMqalDxMtWXRWw8mRuYXoI3Qq2FQfasx9rH0LZ2RkwY=;
        b=HoCfGqzylXAsdoGrDhhsBQRa6O+jjYVjRXXQFGTlUQ+yJUKR24sU3bbV0+5xS7cVaH
         pEGxjT6sJ2ayEr6788B8HLY93PKrdZlog87QgIZOjZ4oEOwGIr0whKR4xsBA0NWyIErJ
         Jl0FPOikFQtB8GQRVR5mdFgdcpRcFkKjfHBJaQNUxIMiXLINOpXCnLsrbuVgPQ11aa8g
         FDS3fyOTWjopiZARboaWP4xGyG8Cjcl1RHiH1Edix/mzvNsIWgfC8a6KA0MGvaQU39le
         A2/YS0rJ1E6Bx8925N7ol3655xt8oKNG5gwRiBS9eh+RGudLmXDOfZsBaVsMOw1MP36I
         ESoQ==
X-Gm-Message-State: AOJu0Yw6o0/cGHEBj+YYRNE6RC+cwFHvEQaWtH0Iiqksju4J8MFOQ45V
	wtqjVqntKjO4TinzHskTaabtJ6tF2KtJcGeaHl3VyoP2GE683LvWT7nlhwKOcP8=
X-Google-Smtp-Source: AGHT+IETOhplWLP41h6xBUC+m/7v+gFVgoTG0pk5jIAa7NUtVmlGHwni76xjxsx+S3umlrFezQ54QQ==
X-Received: by 2002:a05:6e02:1ca2:b0:35e:6ae2:a4b7 with SMTP id x2-20020a056e021ca200b0035e6ae2a4b7mr941831ill.2.1705699325824;
        Fri, 19 Jan 2024 13:22:05 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t11-20020a92c0cb000000b003606dc5804asm5634663ilf.65.2024.01.19.13.22.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 13:22:05 -0800 (PST)
Message-ID: <c8f441c2-d662-43fc-9e8e-fc847428dbaa@kernel.dk>
Date: Fri, 19 Jan 2024 14:22:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] I/O timeouts and system freezes on Kingston A2000 NVME with
 BCACHEFS
Content-Language: en-US
To: Mia Kanashi <chad@redpilled.dev>,
 Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <54fcc150f287216593b19271f443bf13@redpilled.dev>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <54fcc150f287216593b19271f443bf13@redpilled.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240119_132214_956245_D3130E61 
X-CRM114-Status: GOOD (  27.39  )
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

On 1/19/24 5:25 AM, Mia Kanashi wrote:
> This issue was originally reported here: https://github.com/koverstreet/bcachefs/issues/628
> 
> Transferring large amounts of files to the bcachefs from the btrfs
> causes I/O timeouts and freezes the whole system. This doesn't seem to
> be related to the btrfs, but rather to the heavy I/O on the drive, as
> it happens without btrfs being mounted. Transferring the files to the
> HDD, and then from it to the bcachefs on the NVME sometimes doesn't
> make the problem occur. The problem only happens on the bcachefs, not
> on btrfs or ext4. It doesn't happen on the HDD, I can't test with
> other NVME drives sadly. The behaviour when it is frozen is like this:
> all drive accesses can't process, when not cached in ram, so every app
> that is loaded in the ram, continues to function, but at the moment it
> tries to access the drive it freezes, until the drive is reset and
> those abort status messages appear in the dmesg, after that system is
> unfrozen for a moment, if you keep copying the files then the problem
> reoccurs once again.
> 
> This drive is known to have problems with the power management in the
> past:
> https://wiki.archlinux.org/title/Solid_state_drive/NVMe#Troubleshooting
> But those problems where since fixed with kernel workarounds /
> firmware updates. This issue is may be related, perhaps bcachefs does
> something different from the other filesystems, and workarounds don't
> apply, which causes the bug to occur only on it. It may be a problem
> in the nvme subsystem, or just some edge case in the bcachefs too, who
> knows. I tried to disable ASPM and setting latency to 0 like was
> suggested, it didn't fix the problem, so I don't know. If this is
> indeed related to that specific drive it would be hard to reproduce.

From a quick look, looks like a broken drive/firmware. It is suspicious
that all failed IO is 256 blocks. You could try and limit the transfer
size and see if that helps:

# echo 64 > /sys/block/nvme0n1/queue/max_sectors_kb

Or maybe the transfer size is just a red herring, who knows. The error
code seems wonky:

> [  185.384762] nvme0n1: I/O Cmd(0x2) @ LBA 105272408, 256 blocks, I/O Error (sct 0x3 / sc 0x71)

-- 
Jens Axboe


