Return-Path: <SRS0=mLmp=GQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0018C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 22:06:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7273923370
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 22:06:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7273923370
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=DDskIEF80rZdtk2Ejq4xt8o9o
	xihXoljhTMvqTOKK8xnXgCocE3jDIF6YovpRVKHbcfuHEIdGk5q4c0XB2o+rFCj+5nag0yD0Tvv0V
	PlP/0MoDP4Zl8cX1ZEOO5YBv3VKk5R2qVunIZGQkDCcITgLPpBAHvjiv4648N4we0tLON884qlXPv
	0dUe2B7V7RAA3F7gP5ZC4k56z8+kyJqIwLaeoYsIgW+NmZmQJw/tHt4fdy0DaKPjdtSbrxPAlrcuK
	sKDWNrtjWINdUf5A6V6JYDvjhJIUwkPUhMp5qhrRZHTof9Rh2wUIt8hjVIZD3vUxcXIXhNyrvF1se
	FgYTWwvaw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzoHN-0006rL-3L; Wed, 13 Jan 2021 22:06:13 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzoHL-0006qh-9B
 for linux-nvme@lists.infradead.org; Wed, 13 Jan 2021 22:06:12 +0000
Received: by mail-wr1-f53.google.com with SMTP id q18so3760123wrn.1
 for <linux-nvme@lists.infradead.org>; Wed, 13 Jan 2021 14:06:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=SQaHADjDsxAev1wvRSHw6SRTB1Ok7ZbHDjxT93CjhAEy7c7udejXo3vIj3y6Uc3c93
 R1CNDJTDztc2zNZBk4d6rO/haJN42tHhyW5CZYSvdKATDFsJG+eIZkeXfMZp23FbkKGj
 xkaq9WR6jS3S3Pqb9bHWrLclYliXiRmh02wYH4sAzew9aMDcOu5Kk0itVz3TsTojPM1a
 2dVBv4YDR8HwbzgVz+/mbvYNEEQ9AvNLM2OgRKo4D9KE+BaHyyWw64pL+WyVDg2NFqBD
 p9kyzzxwhHeY1mGjdwqlW8zSN+PUP5hLpuHeNcQdIYRdV8YpBNy95RPzE1h6I23pFScL
 O9DQ==
X-Gm-Message-State: AOAM53329x9bP3zEbHSanBKYfrtCMZWrhiOzPb0n3RMgXFvvoMoR1q/A
 dWTGGxsganbM1llT0eL9q6g=
X-Google-Smtp-Source: ABdhPJyD3jrHimUhqZvPtUjhtDUz1EGKvvBx2I6U0Twn7oTfzmso3JnkYCV1sT7mnb92P5p9NAFb4w==
X-Received: by 2002:adf:a29d:: with SMTP id s29mr4584378wra.272.1610575569907; 
 Wed, 13 Jan 2021 14:06:09 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e70c:620a:4d8a:b988?
 ([2601:647:4802:9070:e70c:620a:4d8a:b988])
 by smtp.gmail.com with ESMTPSA id b19sm4599262wmj.37.2021.01.13.14.06.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Jan 2021 14:06:09 -0800 (PST)
Subject: Re: [V3 3/4] nvmet: remove extra variable in id-desclist
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20210112211410.24742-1-chaitanya.kulkarni@wdc.com>
 <20210112211410.24742-4-chaitanya.kulkarni@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0c1f5c5d-5cf1-4ae6-cbc2-0e221b11cf2a@grimberg.me>
Date: Wed, 13 Jan 2021 14:06:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210112211410.24742-4-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_170611_356220_90CA11F1 
X-CRM114-Status: UNSURE (   9.14  )
X-CRM114-Notice: Please train this message.
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
