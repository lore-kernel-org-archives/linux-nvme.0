Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDC8C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 21:13:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73E9D23436
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 21:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73E9D23436
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Q8m5ygU3tEwLnupS+ReEVLwd6n1//iGM8HzSKqEUw+U=; b=ALXqjANwy0R/mkDh5BQzC/Dfu
	ahqLatwK339WrwhZWv9x00x8ii2/hHP+T3K/9QCT9dGPe4fuZ9NR/zkZ7LWaUGHP21moBQTB4W1sg
	q4mzBTD5tAmiB76CDGSWDqdRdsklBIuTLM6zRNG8oGu1c9wMzG5skRnVGb18b6/X7m59Zq1hOrfvb
	p/z1y2xVVxpXLSmKPsmaMlEvIYDJ0R5I3BJSpw50Jfdoyi+FToLUpxCITYlbU4OwOmL9zF7BH7KAi
	JchOEiwF8sFex41VkgvV9mLPfDR/e9m9aGpDVRoWeEx0qNgO5yRgVzqjwQlWGeEzWOj/tNpgbjbPe
	4Ynv+GZBQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l09vc-00042b-TM; Thu, 14 Jan 2021 21:13:12 +0000
Received: from mail-pl1-f182.google.com ([209.85.214.182])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l09va-00041y-NV
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 21:13:11 +0000
Received: by mail-pl1-f182.google.com with SMTP id x12so3555278plr.10
 for <linux-nvme@lists.infradead.org>; Thu, 14 Jan 2021 13:13:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lILcV9lGpcYwLH/f4hE5iJYnR0RUSWFbyKBcHaYumrw=;
 b=TjAqc/Zs+4ApF84nMQIfCBMOQY04sl5mtCMuuxMSm9FVKRDdxi7cwbx0Juf+aYfJku
 0YQ2+IUOsEAuXUGALePltF4N5n9pnwUqK1GP5NP1e23u0ZrrcbadaPjvF0IvlfgYx3Yd
 Un0wL+2Ct1QLGu5I8XzZlhw5a4luYOqhOPDmZI3ki0bzNnrb1ghJcQL3CLfPvc7++dDV
 FJZJTQanP1tuc/20Exg0TiW+DVSCCPqcHhhm8Z38zyWz+eTV5iawygo1YTUApsF8rYVQ
 +BiJQSaFTPQDngTM4nQqT8rYawu4dfn8gPFXBQ+4KGXPtp+Zu74jY18WkgNG4aFbvQpZ
 LkIQ==
X-Gm-Message-State: AOAM533RJjAu+zqYsDbgYPWBN3SXmXABVnb40DQgimGapEuxFYZuCqBg
 OBn0kqAkOVoj9yc1Nlfy/AQ=
X-Google-Smtp-Source: ABdhPJysZe9vATAenDzmAiexF6dizEPR9KSIE1x4wusHm6L+J7Q9GDs5sT7yBXsyS2sYDwbSJi4wOw==
X-Received: by 2002:a17:90a:4689:: with SMTP id
 z9mr6953932pjf.87.1610658789665; 
 Thu, 14 Jan 2021 13:13:09 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:9240:50d6:cd00:1b14?
 ([2600:1700:65a0:78e0:9240:50d6:cd00:1b14])
 by smtp.gmail.com with ESMTPSA id 186sm6067519pfx.100.2021.01.14.13.13.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Jan 2021 13:13:08 -0800 (PST)
Subject: Re: [PATCH] nvme: reject the ns when the block size is smaller than a
 sector
To: Christoph Hellwig <hch@lst.de>
References: <20210113160621.98615-1-fengli@smartx.com>
 <SN4PR0401MB35985C08E5FFCDF0F5817A9D9BA90@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <87698545-de26-c0ca-01e9-4dc2ddcacc80@grimberg.me>
 <20210114174311.GB31188@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <74a92460-d681-8ec6-9df1-e33a5530160a@grimberg.me>
Date: Thu, 14 Jan 2021 13:13:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210114174311.GB31188@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_161310_785899_BFDA8DCC 
X-CRM114-Status: GOOD (  13.82  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "lifeng1519@gmail.com" <lifeng1519@gmail.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 Jens Axboe <axboe@fb.com>, Li Feng <fengli@smartx.com>,
 Keith Busch <kbusch@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> But this only catches a physical block size < 512 for NVMe, not any other block device.
>>>
>>> Please fix it for the general case in blk_queue_physical_block_size().
>>
>> We actually call that later and would probably be better to check here..
> 
> We had a series for that a short while ago that got lost.

What was it called?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
