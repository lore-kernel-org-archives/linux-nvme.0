Return-Path: <SRS0=IkIX=PG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC73C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 01:19:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B89E60E09
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 01:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1B89E60E09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/Ss6rRSBafTIyy3JhG9gpWccPlEHBJC6ZWuBmCdlDp0=; b=jf5Hw+f9jPrc21qHzlbwgwk50E
	EEO4o2j2tNZGMS0NGnzvMi9qLd1rQdc08ymVYOXE2hF7XkV8mGQKE6FuES/o5/bLYB09KZkblQXVX
	EKSGP0b6ubZlWHS5XFjLosywA/JKDWqaVp7fNQ0nRSrupbOyRMQAb41YgT5P4jpdHEeVQO6PeFF5o
	tgFAgNQMj1qvsDS5M1GXTcNhbMyhLgmXpTj5euhl3D9YdIxP8n/IYYbE17myCNMyO1lRNFCNAQXKc
	B33HvLQRkvTtnJo1dSnAB+9/6vUBANTa30XgG/BotK9uza9/MTInPVz52uNavoBLLksLGJxSlrUpX
	LpAxsPMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcHJ9-00Dcij-KB; Mon, 18 Oct 2021 01:19:19 +0000
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcHJ6-00Dcgs-Bu
 for linux-nvme@lists.infradead.org; Mon, 18 Oct 2021 01:19:18 +0000
Received: by mail-io1-xd36.google.com with SMTP id n7so14422717iod.0
 for <linux-nvme@lists.infradead.org>; Sun, 17 Oct 2021 18:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/Ss6rRSBafTIyy3JhG9gpWccPlEHBJC6ZWuBmCdlDp0=;
 b=Xrvkrt26FJkelTeTryGVQXkGgmwphAIS0XbuvXrHExwVfeZ1NSjegp/rkUYOKtCN4I
 IoO/SgnPZnSa9wN5y018mZFcoY1oTJsMYeWv4krUryHKxi6YItVdaWH4GnRlL808LhSc
 WEou4qvAXRdUHtoAh7ODDawwJzo67nqpGgaJIFFlNJgAx4sDmYJB7v2+JA3FYoKU3CPQ
 i2O7l5L9j+81NB6SKnHw6xuDk7g91oVx951lRYVxNBP04vQVce5qDpHjh8I2GZTovBe3
 mMqao8t3Abe0WrFqYWQAm087iJxbdobeecCjK7vkB3hICmRH+e+O93+Mm3ES3NYjLSUj
 t/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/Ss6rRSBafTIyy3JhG9gpWccPlEHBJC6ZWuBmCdlDp0=;
 b=WzP+FT5EbDt4OM88ys2Lbuut17ulzmjtjkirVPFE8jKjVXSA0eXOrPvyETvYRv/ZxX
 z9CiXbikoZeSsIHZ81hTQRsLfBImnmmheN1t9dZCfsuO2NbEVegyNIXkrBPycSpF7WZT
 ccsWtDafi7RHF8JXjZWmxe04lXmbkV3i5JVZ8NIu9o43cu/khz87/RYk4+Dm2xfLXngz
 7bMPsj0mgFLsJFtChp/Fi7pCGI1gmCR7uNrXY4d6ak/N5f4eJc8TP20aWdIfoZj+P1mu
 IaoIoX535RGtga3x8KD9iEYyIiSSkX0m4llI7gttOwP+U8PEaapJdzZJQmpeVGFMZlmB
 99vw==
X-Gm-Message-State: AOAM532nZDxCyGNjt6LJpdi1gCIPf9AtXD6No/0BsUeJQ5x//1WS8hPk
 PAKCzJBeooYfp4xiE20wCVqIBQ==
X-Google-Smtp-Source: ABdhPJz46apwwR3fPj7comOfIeu5CLlqxArnD7r0hvgNjTJBUvusbXLbDOJ2jDqFbZ4E1gktMYuLIA==
X-Received: by 2002:a02:858c:: with SMTP id d12mr16836425jai.110.1634519954760; 
 Sun, 17 Oct 2021 18:19:14 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
 by smtp.gmail.com with ESMTPSA id i8sm1167604ilm.10.2021.10.17.18.19.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 Oct 2021 18:19:14 -0700 (PDT)
Subject: Re: [PATCH V4 0/6] blk-mq: support concurrent queue quiescing
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, Sagi Grimberg
 <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Bart Van Assche <bvanassche@acm.org>, Yu Kuai <yukuai3@huawei.com>
References: <20211014081710.1871747-1-ming.lei@redhat.com>
 <20211014121145.GB15198@lst.de> <YWzIazr+VjY9MNCv@T590>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <bd75e597-ab35-2a88-c2a7-e4e5365bf0ef@kernel.dk>
Date: Sun, 17 Oct 2021 19:19:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YWzIazr+VjY9MNCv@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211017_181916_536060_292402D0 
X-CRM114-Status: GOOD (  17.11  )
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

On 10/17/21 7:05 PM, Ming Lei wrote:
> On Thu, Oct 14, 2021 at 02:11:45PM +0200, Christoph Hellwig wrote:
>> Except for the nitpick just noted this looks fine to me:
>>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>
>> I plan to apply at least 1-5 to the nvme tree with that nitpick fixed
>> up locally.
>>
>> Jens: do you want me to take the last patch through the nvme tree as
>> well?
> 
> Hello Jens & Christoph,
> 
> Any chance to make it in v5.16?

Yep, I'll take a look at this in the morning. Rebasing the block tree
anyway, I'll let you know if we need any changes here.

-- 
Jens Axboe


