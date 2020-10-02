Return-Path: <SRS0=oqNq=DJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A92C4727E
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Oct 2020 01:28:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7D8720848
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Oct 2020 01:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dmCFSPHc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xMJQ47fD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7D8720848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=M7ubyo7+a35lhoYA/9Ic919+R2ysC2KBYQu2NT5tXmA=; b=dmCFSPHcQtmjiyIdH2KIUdkla
	TEllYVfUx6Q5oL6sc1yJa5Xr69azmQEATebDOg2Je/0935xMdnVxLgfiJNEdRonDGRs1qAcMgfEqs
	WozkFWlDCPgDBoGBE+hC7m0o3yXb+qfZGpMl2yX76O2j5IkAOV/0etO3HQROA37tth5ERBXO5BA90
	Q0Qe5u15o5v92tOqu7mrDtBVcb/r2ToNPcV5UKv+U7rEjaFBQYfb1VcTC94c1Fg2u0rTicGI/rhJq
	5QfKD/OcUJBa+YuTZmjCIbeqUClgDLZzCf3noauEd9r27MaNlAYEJ/AzbcAGO9E7E1Af23AStGjgS
	jxcKlvg0g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kO9rq-0000y6-Hi; Fri, 02 Oct 2020 01:28:14 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kO9rn-0000xP-EA
 for linux-nvme@lists.infradead.org; Fri, 02 Oct 2020 01:28:12 +0000
Received: by mail-pf1-x442.google.com with SMTP id l126so76969pfd.5
 for <linux-nvme@lists.infradead.org>; Thu, 01 Oct 2020 18:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=i49beg2TUcxlSmAmpEnMzD9aInnD0fnuYKI/AnJhgbE=;
 b=xMJQ47fDFDHqQa476XcpKAZXW7TuVWgvZW/QmHcAqIuIV9DFSbAX7elelGWEA/G4aX
 0UnWntItvp/GDW1fAGXNRlpurLCpNL5zedDqrGYI4NIZGfSGPh5g2byO4WCkXTikRQBH
 f/PfDKhHOm6HGp8xBUm2NQLkJu7sS8jwyKOpTRBN2npTR+/UwGR5Fu9BNXvE94hwPILb
 Cq6YpCYma90tIC9HKbxtX+YyCnbbOGVUecsie8ED3ZvkRvI3CIl9RKSt79nqpeEV6i3J
 H8ZQPo6+6oEQw3S8eTFVmE1Eh0Atu1iq4y3B6rHUzxXiCqT9XfOKZEfKFg6+Yegy+neP
 xOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=i49beg2TUcxlSmAmpEnMzD9aInnD0fnuYKI/AnJhgbE=;
 b=sHljJ3v/V9yCDcFG/3iDjgxrtYfsIZpb1VXfTkYstOoZEy5FtQp+1F2je+TF2bAGHa
 3ZnB+xZxpQynD9lD1EgkAVnxakvqYlCSA+uuiui3q/SVrcCU3hMSYKjf1eoRY2vS2uum
 xX1Pe5frjf6lCVh0/DmGR0Si5mtyeO5p+jfqyjvhf/91s4hT2OfRR2TES12k7td8gxEB
 ed1C2lGFieUcnp/rIVn4NE4xtx7LJ3V6z9GsCAM0VtwfQRZcpmM6iMDHCD48SxY4ftOs
 AwzTsn49VbhvYkrp7YWUI63HxBoPC8YbNS+2TZLZSJWPCQAw/IpWlgHjofyiQ6wjp4gD
 RAOw==
X-Gm-Message-State: AOAM531zJWgbvNXgvEWGvKcziU1LQMs/HwhLfGovGKQzw8kuhDRtpmYi
 HkXNPNrz/qfHYzVwi95sMQfF6bBPzXG9Cf4J
X-Google-Smtp-Source: ABdhPJx4J9xNU2tN+51Poiudt5CAv0U+oeVjUvc0hIUy4PR0CzIyI8s7265jfYspdpKb4EBcKmIdgA==
X-Received: by 2002:aa7:8ec7:0:b029:13e:d13d:a080 with SMTP id
 b7-20020aa78ec70000b029013ed13da080mr10086938pfr.23.1601602087508; 
 Thu, 01 Oct 2020 18:28:07 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
 by smtp.gmail.com with ESMTPSA id w203sm7729589pfc.97.2020.10.01.18.28.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2020 18:28:06 -0700 (PDT)
Subject: Re: [PATCH blk-next 0/2] Delete the get_vector_affinity leftovers
To: Leon Romanovsky <leonro@nvidia.com>, Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Keith Busch <kbusch@kernel.org>
References: <20200929091358.421086-1-leon@kernel.org>
 <20201001050101.GT3094@unreal>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <063a6648-a8bc-cefd-ced8-573d78a9cb8d@kernel.dk>
Date: Thu, 1 Oct 2020 19:28:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201001050101.GT3094@unreal>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201001_212811_518374_71BAB9EC 
X-CRM114-Status: GOOD (  15.22  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/30/20 11:01 PM, Leon Romanovsky wrote:
> On Tue, Sep 29, 2020 at 12:13:56PM +0300, Leon Romanovsky wrote:
>> From: Leon Romanovsky <leonro@nvidia.com>
>>
>> There are no drivers that implement .get_vector_affinity(), so delete
>> the RDMA function and simplify block code.
>>
>> Thanks
>>
>> P.S. Probably it should go through block tree.
>>
>> Leon Romanovsky (2):
>>   blk-mq-rdma: Delete not-used multi-queue RDMA map queue code
>>   RDMA/core: Delete not-implemented get_vector_affinity
> 
> Jens, Keith
> 
> How can we progress here?

I'd really like for the nvme side to sign off on this first.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
