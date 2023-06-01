Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05862C7EE23
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Jun 2023 17:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bDgdTuu4WDZ3DDFEWqi23tuC20GeCZLnVJvc19YGZr0=; b=A/nuT9GKHpPRXXRF7KBUhDAK1d
	utguaecw8cpKlu/pwSGrHERFSF31At0FkwFXePUtsjlcgGj4iFkIk6nIFjpIBTfOjEnr39jSLLLsx
	wvbCxJSLZ7fUCGRymJyOjlbf3R+p9cd25uqFe077WHidRsdI4jNqhQNLogfF7fpd7CtQ/3NkPe2tT
	Ml8dGJY9q5UwmyEjvlGN9QOKcStmh/B3c1Js5PZjSHA1E8aRsnHUIGoaIdGnlhrAo6mhuxqpO14bA
	urKNlHTowGhzdmmcWsxLIup+S4FFdWZQWjLFSrGvzAbJB/sI0Zc0J/7YBtIsISB0NwmzMjrWymPvT
	zO+81sMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4lrh-004NQj-0o;
	Thu, 01 Jun 2023 17:13:33 +0000
Received: from mail-io1-xd2c.google.com ([2607:f8b0:4864:20::d2c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4lrd-004NPF-2j
	for linux-nvme@lists.infradead.org;
	Thu, 01 Jun 2023 17:13:32 +0000
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7748ca56133so659139f.0
        for <linux-nvme@lists.infradead.org>; Thu, 01 Jun 2023 10:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1685639608; x=1688231608;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bDgdTuu4WDZ3DDFEWqi23tuC20GeCZLnVJvc19YGZr0=;
        b=JljusotaPzV0ppgarLnaxdpyFWMXnVzXIO3D05E6Gb8csTwgZOUJkzkX1i81GQtSD5
         7Gzu9m8OKA4gjegYWf1LMDlihaDbkyEKOOP4oGWYu2S8BNnN01ZDi+vF4r81EA9C0vW6
         4mSulnLe6+QKte9oEy5hzb1oXuFjXmGkJrA4/bB3+qyhLvMVV8qeXugkF8R+JJcMizl2
         jaKGL/HHEzvPxU1jmRRf5S4Ur2EYbAlnypXj40l1CANEkoyj5bNetS1c7RHBBgUsIepF
         nXxi+jCBG8uuJYOs8m6tY78mm7i/ekLqdIg1RO91ls4f3NAKYWYgTJdAd2Pg0Wqq6ngf
         OW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685639608; x=1688231608;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bDgdTuu4WDZ3DDFEWqi23tuC20GeCZLnVJvc19YGZr0=;
        b=c0wnkfoeAp8QibHOeBPiYBJXcSX/D8V7uWDIdDWtW/cOgVF1e0n42xftWXACKaw4sV
         IQB35LqiVeiIXhRzC+WezZhl7iE9ArlXNfS6Y0yodEPDbfsSCZ1MN9W1tZMAx/ygVqSn
         F5vdkgBHTkxpl2C77DPu7e3K/po8/1ndjXU6NKSmXOSm1xwfLLf0WkD+cdN6E27Hm7GV
         oz6uCpNXNatljO+OIFTQAMvhD5IAxt6d2eiSQ9wsXJqRBPbJOCdDWINzvxLHt1QtPjjg
         wwK5oANFQ0zr6UA/7RZnq/NeLn1+VLXgOcw1IWMy8aEg6PWiJFBVxNlYgBzfd12Sze7x
         WMnA==
X-Gm-Message-State: AC+VfDxQfJvi5LhfvFYIgHSowAq5ug+sFAEAPF6Wdel4QZWbFQXUmI0U
	hhWR1djflc2vj6cWigdUwsWZ/cYZePsrVhugWeg=
X-Google-Smtp-Source: ACHHUZ4Yrxq2vIRcdW//fNfgXD/CnAw5L+VXgVfnwCYFB5jkb598xAtNtlOnLmX9OSBfQiDmztAlEg==
X-Received: by 2002:a6b:5f1d:0:b0:774:9499:6590 with SMTP id t29-20020a6b5f1d000000b0077494996590mr4497102iob.2.1685639608040;
        Thu, 01 Jun 2023 10:13:28 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id bg6-20020a0566383c4600b004167a9e0ff3sm2385047jab.61.2023.06.01.10.13.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 10:13:27 -0700 (PDT)
Message-ID: <b0721f7f-2b70-6fd1-18b8-587c32397d88@kernel.dk>
Date: Thu, 1 Jun 2023 11:13:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [GIT PULL] nvme fixes for 6.4
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <ZHjCOA0gUfIiYOLy@kbusch-mbp.dhcp.thefacebook.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZHjCOA0gUfIiYOLy@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230601_101330_102964_4E36E3FD 
X-CRM114-Status: GOOD (  11.53  )
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

On 6/1/23 10:07 AM, Keith Busch wrote:
> The following changes since commit a3a9d63dcd15535e7fdf4c7c1b32bfaed762973a:
> 
>   NVMe: Add MAXIO 1602 to bogus nid list. (2023-05-26 08:21:50 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.4-2023-06-01
> 
> for you to fetch changes up to 856303797724d28f1d65b702f0eadcee1ea7abf5:
> 
>   nvme: fix the name of Zone Append for verbose logging (2023-05-31 09:21:26 -0700)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.4
> 
>  - Fixes for spurious Keep Alive timeouts (Uday)
>  - Fix command type check for passthrough actions (Min)
>  - Fix nvme command name for error logging (Christoph)

Pulled, thanks.

-- 
Jens Axboe



