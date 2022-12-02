Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D4CC4321E
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Dec 2022 15:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fvjTMOyNuaCPSVSDCNmIubGuYYHsGY9CEszqPeygnwc=; b=gMBA019X3mtMPOEA6bZ0SqV3Wm
	ZVXfBTdoU37xvx+HFTucRf7iDs0xdcP+5nxjQvw3gdtz2BGfOWVamf9BI/qXPF5ParVACxy4GJCDU
	drl0lnqKdaNwqq8kLpE/RFbxZtQm4aUkLtfbGrwO9aRIr+GS4PwmZvoMW8GOgBrZttzV7tFnvmNtV
	CvVr79agBjWNIqvLELDYdlUThTsIMVA83HefDaZWiEuXzcK6CiFFc2Hzu5NlHPcK9s6uTlomjF/Lb
	7K7S/jkUhnElN/MLp0SndmwV/z/osRxdN6LCE9aGoLXdi67v30hGAoDC7F5c2WAHWWKMFKFG/17zL
	alwXiOdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p17Xw-00Gxjf-Ew; Fri, 02 Dec 2022 15:01:48 +0000
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p17Xr-00Gxg6-S9
	for linux-nvme@lists.infradead.org; Fri, 02 Dec 2022 15:01:46 +0000
Received: by mail-io1-xd2f.google.com with SMTP id p83so3218742iod.2
        for <linux-nvme@lists.infradead.org>; Fri, 02 Dec 2022 07:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fvjTMOyNuaCPSVSDCNmIubGuYYHsGY9CEszqPeygnwc=;
        b=wla0kadSjr3B4tsPMvuCvhSc/5oDIAU5YBoZVemownGeRODRAo5cg0ix2AKfN5qiV1
         KyX9aFGrLk2ZkHq5w6QbfPfmFj0RLEMePGkE9jEV7eJvUiUgrVXc9OsoF7wTE9RKb4rL
         Oi+CoaK5VPSs4HO1a99uNV3Oq/1rqZExa4KOO7Tmui2N7dP20ENMr0GIaT46pHRex4Cs
         JikOIqUT6Tg4CY1yNWRTqj5J5UwRp8t0Mryg6R0eq7jB274gwW2eBi/AXs1NEdh+COS7
         /2Z/p3jhYGOHmKzqZi4ghrlB1uU8+6UhgkutK03AvfALnGD84lPVMxX98wR0OD/Qv/JC
         CfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fvjTMOyNuaCPSVSDCNmIubGuYYHsGY9CEszqPeygnwc=;
        b=ti6F6Nyi+iSJe4GOnX+/SOQKbEJOEin02qvYS6X6dUF6jy11/EdYl3gJtsd0tPleqK
         6W0Jhyuv76J6+7eFVlJP+rJrRqqHqmolC5HrkltJmMjI9Q8IsCuyWoKxQm+ip3Xi+dxs
         H+I9b6lUVOHJSl1BQZI4SZBC7DnObyIxpz0x0cd27c5ZHSFy9zzHZxEf+1YoPG4G4AgS
         17S6oaCLi9lbNdhNqpChVXKjtJWsI8nh9YmwCxBThlZhgRFkeNHtiqYnIS89EbhQtvMv
         TF1E7BCaDrzUuOpGdUULbArp6Piln6QlvgX4Ps14xn17DkqizlnM0lJIUmhWIpVpr7dZ
         SgZQ==
X-Gm-Message-State: ANoB5plSmf81kTnYrnOKqflys45K+QpBv6QwwNNpG9fOVse029JMGO8r
	mJSqhYly0iZloQZUR+v9h1AF2Q==
X-Google-Smtp-Source: AA0mqf5a671VSyIDmTgcKym5stNFDUHr4aBdr3vqO2Wk/Y18m++AgU9SmckzfzOrXeNuoYdtbkALEA==
X-Received: by 2002:a02:cc2a:0:b0:372:bf99:b645 with SMTP id o10-20020a02cc2a000000b00372bf99b645mr25646876jap.278.1669993299098;
        Fri, 02 Dec 2022 07:01:39 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id k84-20020a6bba57000000b006dfe5556e41sm1159490iof.40.2022.12.02.07.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 07:01:38 -0800 (PST)
Message-ID: <4e7153d5-3493-5663-a183-873445d7a8e6@kernel.dk>
Date: Fri, 2 Dec 2022 08:01:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [GIT PULL] nvme fixes for Linux 6.1
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <Y4nG6f7QDhcmbldD@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y4nG6f7QDhcmbldD@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221202_070143_928971_43B9D082 
X-CRM114-Status: GOOD (  12.71  )
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

On 12/2/22 2:35 AM, Christoph Hellwig wrote:
> The following changes since commit 7d4a93176e0142ce16d23c849a47d5b00b856296:
> 
>   ublk_drv: don't forward io commands in reserve order (2022-11-23 20:36:57 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.1-2022-01-02
> 
> for you to fetch changes up to 899d2a05dc14733cfba6224083c6b0dd5a738590:
> 
>   nvme: fix SRCU protection of nvme_ns_head list (2022-11-30 14:37:46 +0100)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.1
> 
>  - fix SRCU protection of nvme_ns_head list (Caleb Sander)
>  - clear the prp2 field when not used (Lei Rao)
> 
> ----------------------------------------------------------------

Pulled, thanks.

-- 
Jens Axboe



