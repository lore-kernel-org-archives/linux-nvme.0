Return-Path: <SRS0=dHSS=OF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC3DC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 13:54:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EBAC610E9
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 13:54:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1EBAC610E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=oJd2OXEbB8CkE/q1KhQy1ZaEwGZAXfTpMEweXvyWehw=; b=x+1Hh3leoB9AV8TCBTmVpCQecB
	fK0ZHFQUX6LrPsiQJTUh+FHkssuwuC8jR0sTrdRFNSRhwQ97FTe/6SQpnAq34MCxpZm1/wDMObfUv
	+e1PcjSbxYAdE9UXuyYBIJ0olMukLZbT4gTsSbm/VrnrKqCmOPifF0LE6NvFJ3OowhcQWxP6ImG6E
	aGaFBMfi00aJ3ZhHip49yN72ikEZPrGjmWRs7YzXc2Eb7pXn0jUlTPHDobXeicY3DfK0hakLPI6e4
	rGSpAqMT+3LHoBL2dU/PsGoEiE/L9owbkAsuoPaI4J4g9HsYXGp+CLUj7af1MhBs+wWDbk4peO3MA
	FL2ilw0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQVMa-009EMD-6C; Wed, 15 Sep 2021 13:54:12 +0000
Received: from mail-io1-xd2c.google.com ([2607:f8b0:4864:20::d2c])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQVMU-009EKu-As
 for linux-nvme@lists.infradead.org; Wed, 15 Sep 2021 13:54:10 +0000
Received: by mail-io1-xd2c.google.com with SMTP id g9so3492777ioq.11
 for <linux-nvme@lists.infradead.org>; Wed, 15 Sep 2021 06:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7/Q4nZ9EOUpJt4n1PFYQUwazd+gd9harjBRnthmgWbM=;
 b=TlIQZb60vkuXEduYXWNxHT3rCTopsdtbEw/5Hf0armaQEorx0w+ki/iFDu5531ftnQ
 Sgc8tBR/DJjlAULRlDWxfMQXStPz4Slwk5PhVL5Q7zfjHUmpWs6IXmwwE7Tu56Vuo5Om
 TzqmZJ6O17uPp6nCurJcla7K1Ydn8jNvrE2drAD/iOtkITDL7etUYHxnd1ExlYypJFc2
 BLbRgJ60ArY3ulHY+29EKOPgfMH4tBcPWgHD6ZberiOlGBa8VC625BCTSRCRqFvl4IZl
 gXRs1MSWrcl7BaS5QWu1Y/4/aYDsYZzF+bAbeM/+w5/42Og9R8w/bUpPA9oy+bgktkNI
 oExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7/Q4nZ9EOUpJt4n1PFYQUwazd+gd9harjBRnthmgWbM=;
 b=WvwrHe06VASxi2YWpTBg1FvlSXOA9Wf5mx9yjT5i2lUeFzsgXp5bDiNDDNp1EjLD8U
 kIDTuWAQDyE96/IBxwy+FnJehrYc2QGBmN63SSSz/ryf1fzBU581LCbRi/N7kvdPGPbA
 oje21eqU0I9fsAZ6Gy2LPlNO2uIJ3JfZS94ZRYMwqcY7oi6yRaOisBP+iQz73RSV9lox
 D9BoYQz/pKMl51+/5tVGHk0I1l6BmFv/M8P/WVOor4vh+vgUQ8uWPLu8Ui2dXJp6gctN
 oVC6vCZlJQN9FOC6QwrYH57bJX8aPzleLoj8hov74Q4RJan7ktZdBHgKCPptGOKVLV6v
 Sk/Q==
X-Gm-Message-State: AOAM533rWEQOHIGsxRWGeXBoCY3MDlYteOB8AYt+4enzazAIwYbe7i1d
 Sw5seZR6JWwp9owcGY8lzhVPvxAZ/hEZnw==
X-Google-Smtp-Source: ABdhPJxlB2dTVJHinqtET2J+SWBAp94tlra5zu4ou1r8Apg3HVCKOzfE6ppnsu1diR1sTvCsJWsZYw==
X-Received: by 2002:a05:6638:3813:: with SMTP id
 i19mr124026jav.16.1631714044718; 
 Wed, 15 Sep 2021 06:54:04 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
 by smtp.gmail.com with ESMTPSA id w3sm1881ilc.23.2021.09.15.06.54.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Sep 2021 06:54:04 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for Linux 5.15
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YUH6AxwHYm+FN1Au@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f4eb130b-1110-bab9-7794-e1ad91443ef0@kernel.dk>
Date: Wed, 15 Sep 2021 07:54:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YUH6AxwHYm+FN1Au@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210915_065406_492352_35EB371B 
X-CRM114-Status: GOOD (  11.68  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/15/21 7:49 AM, Christoph Hellwig wrote:
> The following changes since commit 67f3b2f822b7e71cfc9b42dbd9f3144fa2933e0b:
> 
>   blk-mq: avoid to iterate over stale request (2021-09-12 19:32:43 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.15-2021-09-15

Pulled, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
