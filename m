Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4462EC4167B
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Dec 2023 17:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BktNjHFjemNWjJqyO1vrvfeQvswJyrLMtxzduolr0H0=; b=LphyZZ+clyLsV4lHtU1H6nD4x+
	vy26vajomqRsuQjA9ywSzd8FJCnqlUiry/yX5u+ZFLaXvcgKh49y1wAHADvgscnzfHUJ7KQT+MPzO
	BTPMa0efibOMVEifiD8HIHSKJ/JmTFi4EiHx8jPk6hMpUx250j18IU1pDXdP7vpG8BwRDesjC0vDt
	9gFiFEnD1tK/HGdt71LpPIwZRw/i2NWgWltfQPcCIFWp4ur6uzqtF4KMKlPCClm0f9sPE7hMTYJ/j
	siXCG2H/564bHtEOujtugka5fQAkVu9D6WYAuHdSnrN4Q7JiuVrdnWB9c5R+6iEzj5V+ir4U21ffx
	W8S9/eWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rBIDt-00DXnS-2J;
	Thu, 07 Dec 2023 17:31:41 +0000
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rBIDp-00DXmv-2v
	for linux-nvme@lists.infradead.org;
	Thu, 07 Dec 2023 17:31:40 +0000
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-35d7341be5cso1168965ab.1
        for <linux-nvme@lists.infradead.org>; Thu, 07 Dec 2023 09:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701970294; x=1702575094; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BktNjHFjemNWjJqyO1vrvfeQvswJyrLMtxzduolr0H0=;
        b=RRaF1dhzB80yIob7VJGMO10hv1+uyo6BazLS1o38yzTFd/Yx9MudHAy7X3JjEF1L0Y
         R9RLTRw8S5zc9a95aZFvPJkgnh3cT0g4vEWb2xIBQXSRi186psMH4Bmyn4okPGxVjvUR
         L+5yacLc2W4XBXBuU7GBmB3zYXwWJERZGJGDwQ+tAA+y35VjYMFPKT9sS1DCKu4eOWnR
         TW7oknnhAw82/QoU0xn0gFeUoo5OVfaVaoNjYFi7rWJrKEc2yFOjBKVU9DPz5h8fwJV9
         FNHWYbcAKdFQNnPLMRWShaDUDPtNez4H1sIn3uYzy3foLwkLAllFhxLy1XoB8mi9DfTO
         919Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701970294; x=1702575094;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BktNjHFjemNWjJqyO1vrvfeQvswJyrLMtxzduolr0H0=;
        b=By8XNogKrBk7eAhM27Y8PG1/NFirq2uB/RgRmU7Y4TLwFGjqgcLKQqTgU2L2L+sVmU
         fDaO6CSJe2bWPPTvshhD2KnabGBu79VG4986p17oWkQNKbZrcEIjlHfWaYUjO4W0i37a
         UMk9pQ9zYO+mq2P3RRfhDirfUG490wc2EjqXVjcDZZZhhIWCLDezdoTo3iaBa5wG5XvS
         5QMaNivAqRhXtp5Kn5FDpgqpbziN6JlpvhI6DieCdhpBFic74sJJxpA9b58aORTZh6az
         Gse9NnEGNF+IUygCPEAjORKxS10UUGUZNWSinFb+qnctuvaM66Q22FdRaE3Nrtdn2hK2
         zEpQ==
X-Gm-Message-State: AOJu0YxxR2htzXqekv2moi2TW0oe3PmL6RlROdxf/OnsYbKGVJGn6RYN
	b/xlAci0TrjDf5B82YysdHUB3g==
X-Google-Smtp-Source: AGHT+IHHX3Wq837j6DEzBXjmguNwiZIzt3R2MAV/0o5chb4ByyugUCdnCJacUEv2AjYylo8L9IM59Q==
X-Received: by 2002:a5d:8715:0:b0:7b4:520c:de0b with SMTP id u21-20020a5d8715000000b007b4520cde0bmr5932379iom.1.1701970294375;
        Thu, 07 Dec 2023 09:31:34 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id i4-20020a05663815c400b004690ef0e41esm40093jat.52.2023.12.07.09.31.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 09:31:33 -0800 (PST)
Message-ID: <1384befb-2e3f-4f79-a58d-9c7a1b791d78@kernel.dk>
Date: Thu, 7 Dec 2023 10:31:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 6.7
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
References: <ZXH7obrwhriIrzdg@kbusch-mbp>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZXH7obrwhriIrzdg@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231207_093138_160762_EF9ED319 
X-CRM114-Status: UNSURE (   9.38  )
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

On 12/7/23 10:06 AM, Keith Busch wrote:
> The following changes since commit a134cd8dfb8cdfd8f019a7ec2ad5cb8e855f0245:
> 
>   Merge tag 'md-fixes-20231201-1' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-6.7 (2023-12-01 18:37:24 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.7-2023-12-7
> 
> for you to fetch changes up to 107b4e063d78c300b21e2d5291b1aa94c514ea5b:
> 
>   nvme-pci: Add sleep quirk for Kingston drives (2023-12-07 08:53:20 -0800)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.7
> 
>  - Proper nvme ctrl state setting (Keith)
>  - Passthrough command optimization (Keith)
>  - Spectre fix (Nitesh)
>  - Kconfig clarifications (Shin'ichiro)
>  - Frozen state deadlock fix (Bitao)
>  - Power setting quirk (Georg)

Pulled, thanks.

-- 
Jens Axboe


