Return-Path: <SRS0=BJyz=JK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E201C433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Apr 2021 13:36:03 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A92B60551
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Apr 2021 13:36:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A92B60551
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BTTOu9IsnPBrxsZe7e2cC/LWtamwZMmm+Lls1mV7ziA=; b=VoF/jAJ6WFnYPYIRTOM9FCwDW
	RmO1kaAcRW6Lw+53PthvumCYPuLS8PQv2UIArnsV5krcEthMCglKyG0f4XuCUhXuKvYaU1bNuaegl
	LjduPonxq629T+MYFvWhsk+tZUgMUzgCs565PpiKPxi67gqHJc+FJnBxjWzI0trs8U04fHuWe/Fvw
	v5yOmqmD9h094LVUqZhJKLSZbjdyI4gBPoA+hw95d3S4bPqGE33jGIf3JipLeGK/xn0B+LCKSJZmD
	UyenT6eA9j0baDQX7oG6nhFv5ksY0+GiVuJZjwvBZuIvcJzCrM2kzEuVM5udr2jSvzM69PsJE0fSO
	UGiYBquNQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lWJCQ-009OSw-Fn; Tue, 13 Apr 2021 13:35:26 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWJCK-009OQf-KW
 for linux-nvme@desiato.infradead.org; Tue, 13 Apr 2021 13:35:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Zfbw9gRsTtELynvxyNAEvq2nBbfpo0wqll31vRo4UIY=; b=o39NUhEmWgtRt0Prujg40WWEB3
 zdj3HM0EJ6/d/OYrwlMZZTWAO6PHzh6T3J12GJMbN9asbn3rKsx7Z8YqWzNthWt1T4ZXEVwPs2sLa
 1+eb6EYxl23ueyO7Fn2p2UWu3xiUOIfO4xrneOI2AdQmO5GF/ePuKjNpHK7NvHtLbWAldFGB390ms
 za0jMpKg37V8cH0w9fyLf+DOcArj7DsK1/4jfhYr4ICvh2hzmUuuyTTf9FPm+DVWZJXhGXbt9Rbzi
 ZiibqH2SwX879MWG5mgwUFzYDJA2V8mzVlWWtZXyr1fRx6nEvRczmaj4vT038MX5j/nu4HlSNMJSs
 C4ljDcbg==;
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWJCG-0073xR-4D
 for linux-nvme@lists.infradead.org; Tue, 13 Apr 2021 13:35:19 +0000
Received: by mail-qk1-x730.google.com with SMTP id 7so17784862qka.7
 for <linux-nvme@lists.infradead.org>; Tue, 13 Apr 2021 06:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Zfbw9gRsTtELynvxyNAEvq2nBbfpo0wqll31vRo4UIY=;
 b=b0oYKHlwg3DVnNlrX19vgF08ocSUeXKRplR4zI9kNg/+QFmHOkEaQ45C+Bka4BGtRU
 nS6j+oD0IZR2wNBP5Kl7ZbNf5ysHGe2Om74gIlnFlifoW+qNgf4GirF1CX0gdKirRE15
 F07N2G043zt6/RHcPv1YPdrDadvJyv6gZwTA71WTCbNfZwRxTP8TjGIcyFSlrhux2d8w
 q08ekYVYdLjq0TZkpUpZksRMyFWmwNI7GKQ0P6tgb0RCx0ZGkB0kBniSZOd1Yu3udTjW
 Je5SAn0sjRPf+DWtZ5BPChvwVUo0SQWOVNdOlzDTIG458DJhG8wqQ+nm85VmTR3Lwwna
 793Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Zfbw9gRsTtELynvxyNAEvq2nBbfpo0wqll31vRo4UIY=;
 b=EZC22FPBguW6sVZ9mvqsHTn5z9y76spbm3ia0E2yHy3Ttn7TnydVIPfEyNVIwkeBTg
 FpUJJLCb0pGR+r3KBRgFUTi7A7T4Xcyqczz2xHWbEcGj5ONeg7Plqbzwl9/FnQILFZla
 lcTBc1xrKzr8YvVw1iJdlyUr6KkSDQ7p8o4ZDd0C87K+jIXDsV8T6GvUe5OFUIcaY0+Z
 T5q5GrONHyUY6G9fnK5eYhlKNzc5L61vW2zPp8bRVdFtxcjSt7mB5FGQnRtRw9E+I4Sb
 TuRIGEMabw/eRUZcqzWHgC7z8q5Wwb64NED8iiql41IS78mXGt9fEPaotBwjEi644S8Q
 fK5g==
X-Gm-Message-State: AOAM530B9hUWR4KTN9lieONoQ6FcCvKFiFsFOLvQSTDmtye1ryIF/ywB
 08194yMc9eKP6HU5G60qv17UYg==
X-Google-Smtp-Source: ABdhPJzDi2mBhgIzlclzCM/9ug0hJZy9iB8qu8lhsne5b1NzQuskLTgGU2S9RKNz3qvq4jdQwxWauw==
X-Received: by 2002:a05:620a:1650:: with SMTP id
 c16mr32116871qko.477.1618320913824; 
 Tue, 13 Apr 2021 06:35:13 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.115.133])
 by smtp.gmail.com with ESMTPSA id 14sm10064746qkf.119.2021.04.13.06.35.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Apr 2021 06:35:12 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1lWJCC-005HJi-1A; Tue, 13 Apr 2021 10:35:12 -0300
Date: Tue, 13 Apr 2021 10:35:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Steve Wise <swise@opengridcomputing.com>,
 Leon Romanovsky <leon@kernel.org>, Potnuri Bharat Teja <bharat@chelsio.com>
Subject: Re: [PATCH] nvme: Drop WQ_MEM_RECLAIM flag from core workqueues
Message-ID: <20210413133512.GH227011@ziepe.ca>
References: <20210412122330.5166-1-dwagner@suse.de>
 <20210412123149.GE227011@ziepe.ca>
 <20210412124909.olui5hfhceakt4u4@beryllium.lan>
 <20210412130402.GF227011@ziepe.ca>
 <20210413085404.tzam5lprtspwcek4@beryllium.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210413085404.tzam5lprtspwcek4@beryllium.lan>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210413_063516_186194_B266E56D 
X-CRM114-Status: GOOD (  12.15  )
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

On Tue, Apr 13, 2021 at 10:54:04AM +0200, Daniel Wagner wrote:

> Hmm, I am struggling with your last statement. If a worker does an
> allocation it might block. I understand this is something which a worker
> in a WQ_MEM_RECLAIM context is not allowed to do.
> 
> My aim is still to get rid of the warning triggered by the rdma
> code.

The WQ_MEM_RECLAIM is placed on a workqueue not because of what is
*inside* the work, but because of what is *waiting* on the work.

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
