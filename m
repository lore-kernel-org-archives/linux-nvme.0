Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D50AC04A95
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 17:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jh9eWU+9mrNPTUe7n2XDSMVIRIH621BbaH57pHKSEXs=; b=M87MJg5e5Yqo0eaM6M37th0GZS
	eKl5+RU2CENk3lIAou2qHT1SoeCEC+QQ+nb/POcqwR5hVEIjLg4+JYz43GQim6VO7LaoCbI/wpbeq
	pSGtEOjxn1ANBpU35MeSYuqU64JcfEwrBdwvVWNW/ofTRvPPjrOpLNeeSr6FEoaCNebaPINxAEH7W
	7l4YNJI3zaY6Hfj9iQSab4zN09O7a2lbiSybe9JuL8Cdfh3Ic99404Xh3R3KeluO18oVbDmf/Lken
	HmhR3N5aD1JFJYQ0xe9eXAItijYewYZJg+GPU8LiuHvxQPaSdMBRHvY9Hjy8kWA/VmnJxlheLT8QB
	ywq4QHPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odaea-00HIt0-A9; Wed, 28 Sep 2022 17:15:24 +0000
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odadJ-00HIFi-8A
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 17:14:06 +0000
Received: by mail-pf1-x434.google.com with SMTP id v186so13066266pfv.11
        for <linux-nvme@lists.infradead.org>; Wed, 28 Sep 2022 10:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Jh9eWU+9mrNPTUe7n2XDSMVIRIH621BbaH57pHKSEXs=;
        b=3Nj5sGfJC5OZ+q27cw8BCANNclJB+ZB6bpdkm0S8AToOBzztoE5ImkablpCURsuzrq
         /fYxz6jW+JpH5aRgRNQs3cmH44csQAVO8CLm2JPEi/mazDyTM0BrYUkbADqcA4a2LhJ9
         BcLyLJ1nmkny3Jm7e7+R5yixm9GidJXtaP28nV3df01XhmodUJbmEpdMNRTpNZ332AX1
         2XLPhhabFe4/IplPKgI2z3aEeLfr03cbO74Htkr97cRuEisTsVOa5vIhcmJblT4rlEDi
         d7Jh0OU57NpZGN3hbwaAYc4NF8HLwX1nNyTFlk5hZvCmA7KMRRkxWPzS/8unPOJnHnmp
         iqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Jh9eWU+9mrNPTUe7n2XDSMVIRIH621BbaH57pHKSEXs=;
        b=Oxj1IzLOPdQysP1mfKyBCFtI1VAKdX0WbSWWzxp5vh28uASiW/k/BAHn1AqywqVm3n
         YwWz0iUfVuwCgY/M3XAU1pDSfEz9IycqfQXEsTqyDSpuU9TV6vyCZOGsBiZQ1veTzeLj
         YCMPjyInvx6cL9Y+OR/vbvl50eMZ6CQ37B64PBFkcD+bHVXLKXH/b+ylT0XI0Cqbpm2m
         dQzRKJ3iuq9/a0lUaMlSk6zGcbbxLolQSpLUIqY3a9oK2tTNMszTQ1S7PonFWikpT1Uq
         j2Qvl8O1RwUXHft8Pv72SseqS1Ex0ymYPPq5IbKacRQGVRmKbHp1lQvgQJxLWmqfoA91
         NJjw==
X-Gm-Message-State: ACrzQf3R3/NKAKcrp2Y32dNSBj/MBeIdQ1+Lm3xMNbeoDxLLCBKBIQ2h
	2M/k/uQUqVrNTcuFpVTbdxtW0g==
X-Google-Smtp-Source: AMsMyM4zbU4SElkthmZkTBUuJaxlh8Sy1/OordHUQuJRkxmz/OEs8JHug8428/xBMIys5ppAdQHYnA==
X-Received: by 2002:a05:6a02:28b:b0:439:19d6:fad5 with SMTP id bk11-20020a056a02028b00b0043919d6fad5mr31000289pgb.591.1664385244344;
        Wed, 28 Sep 2022 10:14:04 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x30-20020aa79a5e000000b0053e468a78a8sm4216177pfj.158.2022.09.28.10.14.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 10:14:04 -0700 (PDT)
Message-ID: <bdce48ab-6227-a54b-de3c-7a43ed3e0309@kernel.dk>
Date: Wed, 28 Sep 2022 11:14:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [GIT PULL] second round of nvme updates for Linux 6.1
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <YzR/6HNJeGTDkxSQ@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YzR/6HNJeGTDkxSQ@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_101405_335714_ACD30A75 
X-CRM114-Status: UNSURE (   9.96  )
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

On 9/28/22 11:10 AM, Christoph Hellwig wrote:
> The following changes since commit 99e603874366be1115b40ecbc0e25847186d84ea:
> 
>   blk-cgroup: pass a gendisk to the blkg allocation helpers (2022-09-26 19:17:28 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.1-2022-09-28

Pulled, thanks.

-- 
Jens Axboe



