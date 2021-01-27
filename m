Return-Path: <SRS0=3Lap=G6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26D5C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jan 2021 17:09:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5FA064D99
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jan 2021 17:09:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5FA064D99
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uHXy71UjTfP79SzW0EWlJJfoec43atQZlBQUAqunxSU=; b=r7vb3vKP6g3GKxfnx4GIFLQ97
	U3Tm9TJPvaD6vdsBRGxkANVnx6WqEjIq+RqXoe8BiynPRF2ymj/pOCgfuc+8X5u/YGLrs7CbRuRF4
	V0NlDh8dsPCTOiwREWOC/UxGV4jTReSNA1DJNR0rir+K9ReJOFmCF4+nyocBZ8IcPzXVYlDGW+noT
	UWRiPV4DwUqx2epLUzEH/tbvXObkpmiMJ3XRM+Afd7zl0jMRRcf2a5Y8kOSvxG4EdIM8jxfb4WoTw
	3cMSE7UhbP7n9DG3XIyMcOGRlyA+exhjVTgpxQzL/xdJPYNq6HE1BFR07SOBwloKPvkJ/F1jjNOgV
	PIO5oDzzw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4oJs-0001wa-Ik; Wed, 27 Jan 2021 17:09:28 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4oJq-0001w2-BL
 for linux-nvme@lists.infradead.org; Wed, 27 Jan 2021 17:09:27 +0000
Received: by mail-pl1-x62c.google.com with SMTP id b17so1389731plz.6
 for <linux-nvme@lists.infradead.org>; Wed, 27 Jan 2021 09:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=YJFirqRxiABeTbLcOq0B8ivyDH34hEqL7q64G4hhzdg=;
 b=h9IX9k3+eev4VaJViLYLKESa7QZAI00kQQQYISQE1RxG0GynS5RHaXfkH0rek1dJ4a
 vEX8Uju8YcYl5fUqZqulrC5lONPMZDBu5bjvlQGBTZbzNhjgPjnzXt+ORkyT4LpUU9mT
 szeHTd7Ml53Vbh723gEHf5AW6zefm2cBW84PY83vEitWC/wjWg4AVGoDR06AkRQiENUQ
 BVrsB36k4HTs9a3AcJVBegsMz7bFIMwBd9tHNPQxHXSgMychugDktQAifnnf6U+oRLeK
 fSdTs1xGy4RQHmNZmKKHbRT9uN/fNIfdhobqRBStFHUsH6zq1iuzjcucb94WWe/IeYwJ
 fiRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YJFirqRxiABeTbLcOq0B8ivyDH34hEqL7q64G4hhzdg=;
 b=kwx/PI1Em5oEc4XdtCZZUCV6xqBmKbr9UErQMwbDZr9Jt0jJ3TzD6NhwdVZ0cOo9u8
 OOyuglxhAQMFPqd/o0xoEYkNHups7mi0KnAL2X9BfpMEeP5jB3eTLNBwkJyHZMZD/mgM
 nGlTsg1yJcQM3lQhZM0IEo84Hmz6BvXUdGTkOV/9pgRX0Gb2HIEYK/wTSYKeL7A4uPWN
 hGRl0yEMoquURqgTgNOHdz9n+qS36MXgW2F6D+cBt5YLLDh7hxFqLEBQmfeaHEbh11ir
 RgSktNV/5MseSDt+YfE7RdZTQaeTTY9uIJyLO0xgs9mq/E5yaml038YAsZFl00Rl1T5w
 luXg==
X-Gm-Message-State: AOAM530a+w+E+tkAqgh4LZlAMg5qOxW+WpAszbE7a0eVPrbxoyb0uCuY
 sdD6FWEoEStbNrnjiSADtfoN/A==
X-Google-Smtp-Source: ABdhPJwQ1UoM9BVwq5PjAvq/C7WXKMZZ89ZliJF81kJm3qxWSKohWAlTNJumniZHSaRUJbV+ZgAybA==
X-Received: by 2002:a17:902:c40c:b029:dc:9bc9:b98d with SMTP id
 k12-20020a170902c40cb02900dc9bc9b98dmr12292977plk.19.1611767362370; 
 Wed, 27 Jan 2021 09:09:22 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
 by smtp.gmail.com with ESMTPSA id
 101sm2628493pjo.38.2021.01.27.09.09.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Jan 2021 09:09:21 -0800 (PST)
Subject: Re: [PATCH] nvme-core: check bdev value for NULL
To: Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
References: <20210127053738.4922-1-chaitanya.kulkarni@wdc.com>
 <20210127071344.GA21223@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <683a593e-a5f2-0e09-2ad1-c2527946b253@kernel.dk>
Date: Wed, 27 Jan 2021 10:09:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210127071344.GA21223@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210127_120926_459775_AFEE9461 
X-CRM114-Status: GOOD (  12.02  )
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
Cc: linux-block@vger.kernel.org, kbusch@kernel.org,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/27/21 12:13 AM, Christoph Hellwig wrote:
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Jens, can you pick this up as it fixes an issue I introduced in
> for-5.12/block?

I can, I'll add the fixes tag too.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
