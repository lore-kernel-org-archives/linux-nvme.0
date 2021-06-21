Return-Path: <SRS0=I4H8=LP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46931C49EA4
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jun 2021 16:19:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D53C61206
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jun 2021 16:19:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D53C61206
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=aKwz1oC7jx3cZcCiBLqPjlzQXp4ZLj+swq61N9qnhVg=; b=lao3H6NjJ3vOlcBGDwK3kBvq3c
	on8U9qrreEBeZDeaRKKK6bFOnow0BnUuDn9quB6Vk4XaC4xj4ae55VlW3kuisCTQGkz1mBHNiGY64
	0FtrC1LZiaNloXORnzFLW74AAmHtUCdGSNbVLG7aon4S0cxBmt8/JX/0pKYzdUlxd/wCfypW5wgR7
	6XMcgAcKMU/zuKbuo7adjq6DIV1bah9lyJKV6uMLHZW/ioZN1h4WYrg/Wd6mGjtcVBpoWeDbieJLw
	r6rj75N9OPcS206zJAzr2/vhQHTyMWlJp68d5QdE9BOva4Mjh5FZepXjpV+FPDSE9BzXDPTyptNZT
	N4GRjtsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lvMdy-0044ha-I0; Mon, 21 Jun 2021 16:19:26 +0000
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lvMdv-0044g3-9Q
 for linux-nvme@lists.infradead.org; Mon, 21 Jun 2021 16:19:24 +0000
Received: by mail-io1-xd34.google.com with SMTP id o5so14696430iob.4
 for <linux-nvme@lists.infradead.org>; Mon, 21 Jun 2021 09:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=z9+Gvg2pRJYO5llO566zQRKc7nz5rMA8G1k23ZlB+94=;
 b=fmydy7npLuHF5pK6l+BlfTxY3DyROpOv1ZsydfzI71tBKUpTEeIDttn5ZnZq76k1wx
 mM6K5sixeGwQZHlPz6VvgI0K/cxBp6ZClcdfIz4GfvPZljhh06ad5ZS7K2LVSmhJd1hI
 YQgjuEEX9Rnd+iLJDRnGJyreJUVq+6bRkRgbUpWisDLyHFTQ9ssDSGmC2lmRd5pMGdOF
 h1B/5xHOfEbbwYNyCEVpx2fbLd/2BGhQ9nmqQnUYJlqeJF7MlD8raP4wSjg8FukbjndT
 C9lic9PKF3FqML+ieO1zyG4pamD5XtP3E0206hr7pof9R7KNROj7ZTx/Mgh8TREEYwen
 OZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=z9+Gvg2pRJYO5llO566zQRKc7nz5rMA8G1k23ZlB+94=;
 b=KI0iPS/POVp1S0TFuLQI1mgA4uQPa3zvYdZZbw5QkHVUtKlA/vwYrGAIXDKK4lNrw0
 0OSNkCTfVyZHXSNJa7mZw0q4lqAiJ2YH3VO20EuorjuqX4RjGcuxSIwOur1gdnk5nuyy
 a09/8xJbyOQZfXJLlnUFwgkhWD3h+MW7FxJPjHOEplLnLd9jfA2nW/NF/vRT9LD9SuDe
 nxN548RTP8bfo/sbzhJextdValnd+1ykmzihZo4P7dVQUFCTRD6AyE6A7K6CY1Yq7vAC
 qRvfCLgXLmptUQ0q+XJeCzj0KGJhLYPxsrpxIXIn5fPlsHGpIgfSLqCP8NhzXcLZuj+k
 w8rg==
X-Gm-Message-State: AOAM533CrXpUACQfahyMrRamdMxzEMtLiSZCAtEvfIdkzcP3pIfQmFxp
 cQN09Z3USfiVajn7J71tqVSJ7Q==
X-Google-Smtp-Source: ABdhPJwepO4EBRuO+NZFOye2PdHKKMs0GZ0tTzCdwFiQId69VvBAz9fgepNfprv4ifiEkot6HHDhRw==
X-Received: by 2002:a6b:8e97:: with SMTP id
 q145mr19979737iod.144.1624292361493; 
 Mon, 21 Jun 2021 09:19:21 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id q8sm283573iot.30.2021.06.21.09.19.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Jun 2021 09:19:21 -0700 (PDT)
Subject: Re: [PATCH] nvme: add comment to not use kobj_to_dev()
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
References: <20210621030940.22286-1-chaitanya.kulkarni@wdc.com>
 <20210621053251.GA4360@lst.de>
 <20210621161743.GB1268033@dhcp-10-100-145-180.wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9ca39a1d-2b66-9a4c-fee0-960ab858b9c2@kernel.dk>
Date: Mon, 21 Jun 2021 10:19:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210621161743.GB1268033@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210621_091923_465227_15185A68 
X-CRM114-Status: GOOD (  16.58  )
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

On 6/21/21 10:17 AM, Keith Busch wrote:
> On Mon, Jun 21, 2021 at 07:32:51AM +0200, Christoph Hellwig wrote:
>> On Sun, Jun 20, 2021 at 08:09:40PM -0700, Chaitanya Kulkarni wrote:
>>> Add a comment in nvme_ns_id_attrs_are_visible() and
>>> nvme_dev_attrs_are_visible() not to replace container_of() with
>>> kobj_to_dev(). Since use of kobj_to_dev() makes code harder to read.
>>>
>>> Suggested-by: Keith Busch <kbusch@kernel.org>
>>> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
>>
>> Err, no.  This code is completely obvious as is, and if people keep
>> sending these stupid patches we need to start blacklisting them.
> 
> People will continue to send these patches as long as
> scripts/coccinelle/api/kobj_to_dev.cocci keeps warning about it.

How about we remove that rule then? FWIW, I totally agree with
conversions like this being harmful, container_of() is perfectly
readable, and the kobj_to_dev() is one of those things you always have
to cscope in to see wtf it is.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
