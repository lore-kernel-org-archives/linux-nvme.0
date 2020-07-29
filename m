Return-Path: <SRS0=jy92=BI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E51C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 04:35:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18C432070B
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 04:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TksmkGRH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18C432070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=TksmkGRHb1UkdDssL3fFjTjv0
	T2Q5mOaN85CgYCHxT4YjebHBUsyLruqVKFycqkPseQyBV5XecfKi7ArGC0zFycigQeHgiymBmFjNG
	8OFa9I0qMfrCbSkxEGUVnvOzr4lwwYljpYXaVEEYrFcp5swIv8co4/mrLCEwDbDpej/RK5V0hVoXU
	yxGhtwzhaiHuHKcquYpadXcxXlcygN5uh+Itqovmqau7P9RB3vmiq3U4RjjLt9rTZPP1kauOfgc+3
	DSlTYHEJoCRmJ5EvExP3KjwgDjeW6fclG5g6DS7rT6PyF9dqgMCQ5gppfAv24vQorYfgNl5Ab9w5Z
	P+YvVnD/w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0dom-0008LG-GJ; Wed, 29 Jul 2020 04:35:52 +0000
Received: from mail-pg1-f194.google.com ([209.85.215.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0dok-0008Ko-5E
 for linux-nvme@lists.infradead.org; Wed, 29 Jul 2020 04:35:50 +0000
Received: by mail-pg1-f194.google.com with SMTP id t6so13603820pgq.1
 for <linux-nvme@lists.infradead.org>; Tue, 28 Jul 2020 21:35:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=oFdSpxDaXkK6P5Kyvvd7tMyoyaP7vFNcALUgD1aEiR5Qi11R70gt42/D8fX5IeaYng
 vLgHA7bCGSjMJ/WVBJLc+wXx2FoeCE+IJd5qr0Ioipf/aWPbxzhj2dkeQlMfYWkUSzm8
 0Ajkw9ZVmnxx6dFmyCjhz2IG/hv1FHqWwax3AwKMTLkurBOapfqtBotmD8xjXJngGGxX
 tvrmIIgppHMZSd7DHuhW01CdjxXn2Aw3FkcU5oD25mKkCO/oyF7dLdBHuVZW8BNyQia/
 JA1qhfh78WiK87AkeZ1QYumMzmdleVUwfEo2Q5vCMapMhxB6d+qANfUsS5VaxYlUxnN9
 Q1AA==
X-Gm-Message-State: AOAM53012KyuyEy18MKKJQm16mezeGzGezDbMt5+ZehnswAo4XPIgcgz
 Wo398XH7S8lB86IWIRQSuAB67dez
X-Google-Smtp-Source: ABdhPJyB54HoT64E7nowIQfsLb3LHPAqpwYsDRjYUG/7OFDzwQgbmZnljiX6xEq7HPKeiwX5R977dA==
X-Received: by 2002:a63:fd44:: with SMTP id m4mr27022512pgj.160.1595997348972; 
 Tue, 28 Jul 2020 21:35:48 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:fcc5:69d8:6e20:4fd1?
 ([2601:647:4802:9070:fcc5:69d8:6e20:4fd1])
 by smtp.gmail.com with ESMTPSA id m20sm646337pgn.62.2020.07.28.21.35.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2020 21:35:48 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvme-loop: remove extra variable in create ctrl
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20200729023648.38677-1-chaitanya.kulkarni@wdc.com>
 <20200729023648.38677-3-chaitanya.kulkarni@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e45e796c-ecd8-089a-1c3b-5ac50d7cae01@grimberg.me>
Date: Tue, 28 Jul 2020 21:35:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200729023648.38677-3-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200729_003550_222957_0F8C39CC 
X-CRM114-Status: GOOD (  10.71  )
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
Cc: hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
