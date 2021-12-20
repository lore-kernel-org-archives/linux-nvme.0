Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341BBC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Dec 2021 20:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qNXUg0IfQbj19mJiT1+n91vqkuVNfQmpeeYXgjIoWiA=; b=zs8CwitWuq+gR0tUHBQYcPWBUu
	bbiRT2LUYYWq3qAnRAVihxfNCibF9pPA+klizxAnHT9PS+QKMOWfCdwSn1OHtlT5mbQpSfIWradd/
	t24AQ3uwXBu3S46ToBT+WrDvShqBefOVJCtbI/HUjU4Ng+xY0JCT6aoKDpR3vySnOXS7GgkRyHxQR
	71LC5wN5Yo4gSR7Gg46sGVKdcvXSocZNWvLSs5zEmdOEE5xfdrZtdngUMvxTTlrR4srVIRRE6o3Be
	06OyJPOM/QuCJF7XOSDjS3nmj2vxiKbDgEKu2l3CIo7AhWJ0jAIhjLfHdYE6a/zZx0h40AWYSQDZM
	GJnXyumQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mzPYx-004Kvg-Pl; Mon, 20 Dec 2021 20:47:15 +0000
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mzPYu-004Kuz-Jj
 for linux-nvme@lists.infradead.org; Mon, 20 Dec 2021 20:47:14 +0000
Received: by mail-io1-xd30.google.com with SMTP id x10so14994727ioj.9
 for <linux-nvme@lists.infradead.org>; Mon, 20 Dec 2021 12:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qNXUg0IfQbj19mJiT1+n91vqkuVNfQmpeeYXgjIoWiA=;
 b=w7rz2QalTZB629dgoN1DCNPMZeaLyDBc70YfmObjXHYrSvSeH02ssDRIZt/9WRraCL
 14JaZDn4ScDIBOa9b7vu1WITbPA9h1BpH70BDscZl8L/zjG7q7EhoebiViFg4SVd/cAo
 yoisOyWyXm05fYAxx6DOBJDOCzJyCMuVX3Km50hFLG6hBVHLrRE9Ru/iMiCLvhorDuDf
 gjYbkl7YyLukCETWpsSfEeSaH3xVcOxpYRKAglP8pNhv2rJAkwUgJe/EgtLC/FlO9foU
 B8GaxwBYu8Iqvls6xCGduF3NWIzeP/7K6D6h2MiZwSjtKcJDncHJFUpExqXsmX3sbadL
 +Gtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qNXUg0IfQbj19mJiT1+n91vqkuVNfQmpeeYXgjIoWiA=;
 b=lG4dinGLc5SlBcBASTKH3JmAlO3rLTb9Ev/tHiUf9pAdF1oGT/ruvPh/aec3cpUa6c
 /9yxUJbQE/FldRia6WByJYIPI6vTK/OKJ1qA7ujy6XurpBoe5PCuflqqnMrid7TwuYuG
 xykv5UdgjX4QUH2h3CL0VmzDO6bCEOVZxUKO+4i8c5e3JVPPOAy7Bf0FvOvIhkYGqqZH
 0nYshU96XR1JAvQD3h+sTi32NOA9h8AhaiTpFgdfiRUGnhfzoKTX48K2VhIzRraLhawH
 FaA6fnDdBLOvsGl2zQtDiIe0l46Leoru6RJLSpJHSW+4PP6bwV2EFG6m3FgcAwRd1TYb
 uihA==
X-Gm-Message-State: AOAM532Z0VxXOsqq7jAiyLskWbrZwRspyelbzVyoHfcC/NuC95TZ8jtE
 nT1t6YaFuNnuEfl7yL8kivjyri4PxYCY2Q==
X-Google-Smtp-Source: ABdhPJyE3gxmyTH3C6HTFpoq34rinqH8Nwm8ha+8iEhXJvQo75/ye4EHGtAFJ0oE5xZZQlTlWGudzw==
X-Received: by 2002:a05:6638:130f:: with SMTP id
 r15mr4039264jad.184.1640033230746; 
 Mon, 20 Dec 2021 12:47:10 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id x11sm9679477iop.55.2021.12.20.12.47.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Dec 2021 12:47:10 -0800 (PST)
Subject: Re: [PATCH 1/4] block: add mq_ops->queue_rqs hook
To: Keith Busch <kbusch@kernel.org>
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20211215162421.14896-1-axboe@kernel.dk>
 <20211215162421.14896-2-axboe@kernel.dk>
 <20211220203649.GA4170598@dhcp-10-100-145-180.wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <61c5c2b7-422a-fad6-cbc0-5d8278759bae@kernel.dk>
Date: Mon, 20 Dec 2021 13:47:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211220203649.GA4170598@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211220_124712_706550_6C925C6B 
X-CRM114-Status: GOOD (  18.88  )
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

On 12/20/21 1:36 PM, Keith Busch wrote:
> On Wed, Dec 15, 2021 at 09:24:18AM -0700, Jens Axboe wrote:
>> +		/*
>> +		 * Peek first request and see if we have a ->queue_rqs() hook.
>> +		 * If we do, we can dispatch the whole plug list in one go. We
>> +		 * already know at this point that all requests belong to the
>> +		 * same queue, caller must ensure that's the case.
>> +		 *
>> +		 * Since we pass off the full list to the driver at this point,
>> +		 * we do not increment the active request count for the queue.
>> +		 * Bypass shared tags for now because of that.
>> +		 */
>> +		if (q->mq_ops->queue_rqs &&
>> +		    !(rq->mq_hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)) {
>> +			blk_mq_run_dispatch_ops(q,
>> +				q->mq_ops->queue_rqs(&plug->mq_list));
> 
> I think we still need to verify the queue isn't quiesced within
> blk_mq_run_dispatch_ops()'s rcu protected area, prior to calling
> .queue_rqs(). Something like below. Or is this supposed to be the
> low-level drivers responsibility now?

Yes, that seems very reasonable, and I'd much rather do that than punt it
to the driver. Care to send it as a real patch?

-- 
Jens Axboe


