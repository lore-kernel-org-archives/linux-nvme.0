Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2761C32771
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 20:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bpRGk4qMxf60ieydKnGhP8nkC8PSH0RviD05UoZuS6o=; b=E5y0Kav3knPEjX53T3zpeeXiif
	rRsS3GcouWPZf68t89yZvrnwE/LQd4JOY4VaMMFne9IxYWOilGiFqlzHSE8/TdecfkPhNtAhSMiTW
	v/5UzCDy+1XBbvyVfQ2HvQD84LYf0AsKjP8UYC1G96/wF6jBn7ks3aFGjzMSBRGk1T3OsoDt187tY
	u2/E9USuy7Y9SV5p5UktNdJwGru9wVLU4jqQRd/389779rgkaF7ZlP8AHY3KlBkyin2eFnLukRTm7
	q1Bn1VaiiqVvpwg0Q/DwbllXQ4yrvPKO0QPHzZIAqbGXYmssWpsL5u5+V0PhG+66nBXgzlQFZaO73
	IK+poGRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oddLI-000G8H-K7; Wed, 28 Sep 2022 20:07:40 +0000
Received: from mail-ej1-f49.google.com ([209.85.218.49])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oddLC-000G6T-SW
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 20:07:36 +0000
Received: by mail-ej1-f49.google.com with SMTP id sd10so29446106ejc.2
        for <linux-nvme@lists.infradead.org>; Wed, 28 Sep 2022 13:07:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=bpRGk4qMxf60ieydKnGhP8nkC8PSH0RviD05UoZuS6o=;
        b=yHismtALHLaHXS+QZXCoiWLcwOBmuWA4lYGp6ZHJcL3JrWy0ThyVJhZ+BecFlK/kDz
         lfmJ3TZ5oYvZVatheszKSvybuCBEU/jLg5F6MBzpP30/PTCdKnuyIFCnI7WZo7rS5OiP
         hHLuw3208lAc1XjDPlP5IvGahaJRjJuTKO4WU605V21D3CMw3mTUDDM3sVTmCX4EJChQ
         T/2pqb4r3cqGPN4uvHIJ+bryadAvmuedU80onrbXpK3oZF0pPfJTKkKmLELbjJIb3/SC
         hWaKa88CLqmsDqGBlf5nC27IO6D4583SJFCfZ0OgIOPlcSsO/Lly2kWYUpRtp1+2lyl2
         NOkQ==
X-Gm-Message-State: ACrzQf0/mDXNgFHBrE6yNCCD+j8gCCU6PWIJf8mBjHZ1KUN4iJF+wFGI
	P3q9Qh5H0PrOdE/YAB3K/jyUzZ24GkE=
X-Google-Smtp-Source: AMsMyM6IcSgfsZ8AhguABL92viJD86UdUGA3uh7aqDX1Pf9ygC4TsfSu4wXtJ7BvKQxSKwOoC/ltZA==
X-Received: by 2002:a17:906:6086:b0:731:3970:48d0 with SMTP id t6-20020a170906608600b00731397048d0mr28996856ejj.16.1664395652921;
        Wed, 28 Sep 2022 13:07:32 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id ku5-20020a170907788500b007828150a2f1sm24506ejc.36.2022.09.28.13.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 13:07:32 -0700 (PDT)
Message-ID: <68abbe17-a54d-cad3-f6c5-a01838fd3324@grimberg.me>
Date: Wed, 28 Sep 2022 23:07:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvme-multipath: fix possible hang in live ns resize with
 ANA access
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Hannes Reinecke <hare@suse.de>, Yogev Cohen <yogev@lightbitslabs.com>
References: <20220928135816.132213-1-sagi@grimberg.me>
 <20220928171446.GA16939@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220928171446.GA16939@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_130734_965437_DE668EF3 
X-CRM114-Status: GOOD (  12.75  )
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



On 9/28/22 20:14, Christoph Hellwig wrote:
> On Wed, Sep 28, 2022 at 04:58:16PM +0300, Sagi Grimberg wrote:
>> When we revalidate paths as part of ns size change (as of commit e7d65803e2bb),
> 
> Nit: a bunch of overly long lines in this patch description.

I'll clean it up.

>> I was easily capable to reproduce this regression with a small debug patch to nvmet
> 
> Having this patch in the mail won't make git-am very happy..

I'll remove it, was trying to avoid writing a cover-letter because
I'm lazy...

