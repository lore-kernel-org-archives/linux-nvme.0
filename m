Return-Path: <SRS0=H+rW=EL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D5DC00A89
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2020 04:51:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3DE92087D
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2020 04:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FbmDnN0W";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Nhl21OvG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3DE92087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CHsoQpjG5/hOE+/PNIO/9mCpmKZ4YA+rTVlL8HCjNCA=; b=FbmDnN0WDDTjYqio/Dwxe3+cU
	dImmsUpsa79nS/5xU7sNBHT71lye8wEzCi7+l0zskPncMbX0A0u2avp2lSos+CIfwpZpLZ90dKi6v
	hUasuh26iAkbLYInJ9NlXKzhV2zAxQLeb5QaLFk3fxIUpPVep0j8uTeKTug3adxBs9UNfmDrN8F+p
	Bc3BPRx9tHJ/C0B1Xu2QHPvlB4sSs7S03pqtluYjAMnu6y9RJn3KCRDUVul5Zg3bRI8NjJcH0zcFm
	VCfPNxyJL3631U/4DaI9vzm2Rw0YoIUhzz6RpznZkMeTBzeIAc9AZ+vuxbl5B+ptv0crjARgRTxzK
	PChYTwfkw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kaXEM-0000Ui-Uh; Thu, 05 Nov 2020 04:50:38 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kaW6c-000145-GU
 for linux-nvme@merlin.infradead.org; Thu, 05 Nov 2020 03:38:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=DMmVnKg5lcMx/U+3fBrz0ItQqCAEHHoJH8sViy+fckA=; b=Nhl21OvGyxzge3a5TaWMc95v3z
 r1slZ232KMmoolU7vGcx7W1BTrNm2Q4lJkFwh0iS00EIG1Wo7YP1tWTFvrg0QV2J93zDvEsPRH39M
 NtaSQNhUSu2sLN7zp0++N37Ez7NE6K95vPfoG1mDwYuS1vm6j0JwJZ0/4iU1QmsRnA4Vi12u1Lquo
 yh+tCy/MGL261l4URu70DiK0WsBEMEu4ZQXjM8XCf1YS/zr2f4X5zHZid+VOmgGz+hrzPQSjUdx8I
 SYwlmlOgVNw5ZacKDJ5TNOc2Z4+4i2yrRtpF4LMoFwxnpngbLO4JzkwRvrdGdcY3K/eq7+TuzKC1o
 DD2e0MyQ==;
Received: from mail-wr1-f67.google.com ([209.85.221.67])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kaR5Z-0006Y2-9W
 for linux-nvme@lists.infradead.org; Wed, 04 Nov 2020 22:17:11 +0000
Received: by mail-wr1-f67.google.com with SMTP id b8so173094wrn.0
 for <linux-nvme@lists.infradead.org>; Wed, 04 Nov 2020 14:17:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DMmVnKg5lcMx/U+3fBrz0ItQqCAEHHoJH8sViy+fckA=;
 b=ESowirNt2CXe3oB4u0X8Tvk1QF20QSyjWSRUC17nh8KwzrSH1APoIUhpzCMIXTAi2m
 zkTrtWjnTgss4akR7zkTK5U9LowRC2pmfqYy4bNIjYv7JK8BO/oBVKjY1GXqMP9jGSY6
 mUwWkm6DQyLHhDCz66JSEI//ZZelKFkp6FFbo0DI2F6ac4EoqlwBoWzFe+itMXIUgEk7
 D/zvPvv4X3mZox1dPnhQ3nmoptbqO3GYXK36oU/iZW8KQNEfPelQLx1JhdgdIRdxJdNt
 fY2AJRPYh5uHBmYaPCt18cOoGTsGzxASbFFh/1wS8ZKsqTCavvjYgILGiOF147Ezt3Rh
 jfyg==
X-Gm-Message-State: AOAM5337yeXcn+8vXu49aa+U1MYd+e7+w6J8BqDG/IewUQr+G7m9mH4x
 cucybjaXu0gtHqLFMljeuWs=
X-Google-Smtp-Source: ABdhPJy4uQ/K80wzncBktPiKMvFF34SybDDucigxlyhb+q8NyD8p0JesEg++t+baOphjougIeTpjeg==
X-Received: by 2002:adf:c101:: with SMTP id r1mr121463wre.87.1604528228280;
 Wed, 04 Nov 2020 14:17:08 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:f032:e586:d54c:b9cb?
 ([2601:647:4802:9070:f032:e586:d54c:b9cb])
 by smtp.gmail.com with ESMTPSA id v12sm4768524wro.72.2020.11.04.14.17.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2020 14:17:07 -0800 (PST)
Subject: Re: [PATCH V6 5/5] nvme: centralize setting req end_io_data
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20201104203736.62745-1-chaitanya.kulkarni@wdc.com>
 <20201104203736.62745-6-chaitanya.kulkarni@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <66b805e8-9efe-8f47-b10a-1a8dd6505720@grimberg.me>
Date: Wed, 4 Nov 2020 14:17:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201104203736.62745-6-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201104_221709_597349_B01D00DC 
X-CRM114-Status: GOOD (  11.95  )
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
Cc: kbusch@kernel.org, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> The host side code allocates the request in several places using
> nvme_alloc_request() and initialises the allocated request->end_io_data,
> which repeats the code and will have duplicate code in the future.
> 
> Add an end_io_data request parameter which initializes the block
> layer request in nvme_alloc_request(), update the respective callers
> and remove the duplicate code.

There are less callers that actually put something there so not sure
if this is an improvement.. The alloc signature is getting kinda bloated
now...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
