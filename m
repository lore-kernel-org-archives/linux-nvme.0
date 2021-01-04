Return-Path: <SRS0=JqC7=GH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5C3C433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jan 2021 22:48:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D1202072E
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jan 2021 22:48:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D1202072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ieltkVfB6R3V8DSyzoHmq+jINpHwkZ/cANt2CH5CUXc=; b=VrLvAnI8lqO+5cfk7ks5bqiUz
	5VbZ7kY27tRVFAIsA9q6TM/+hA5mFIbKSiRSo6A7GCgsZN7wtkbloEujggykN5mgfU0Df/mHmt4vx
	Bg6BXif4V0t1e7ZFwPUbCJIZeQrQsWwZZowrWEddvao4zshsEhHZRCMo0TOa9eySQ9ZqglZhWMM0l
	2REaN3SY8+4q5F+iVo8olX/XiVtCWEZYTOZ8QCjaJzpjXdtqzIG39zGJXPdvSmK4+2AD/BEG6QgyK
	3IDHNyOyu7b7/5PUhT6OQEd5pUevbwzAhA5XBajlgDdSsr8eRBV02YHIZ7RvMbAr6CliN1NdVsbB9
	eD+N2PeMQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kwYe5-0008GD-CP; Mon, 04 Jan 2021 22:48:13 +0000
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kwYe3-0008FI-0n
 for linux-nvme@lists.infradead.org; Mon, 04 Jan 2021 22:48:12 +0000
Received: by mail-pg1-x530.google.com with SMTP id p18so20002272pgm.11
 for <linux-nvme@lists.infradead.org>; Mon, 04 Jan 2021 14:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osandov-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=PX8oIefqvj4m1fhpk9Yk9JUCrGXiZ2uLTZFm+izHPPY=;
 b=0rt7rPP+kKHC1piUsixUzA//djUz0Ithh88VD2BqrZD21S5ZvvNYxTKvWe7eWbxwG4
 F2fWxaYLPM5AcTR5BBH+bqNrqzbbTJJ0vakcjrH3hu0iaQ0DVz2SR1NTLIq3LvZPD0zk
 YJxYGyDYT3nqZ2vfeQ9Khbzr3ytKz0jN52BDJu2rTZaHSjANuv6DI18MyAzmYhQn6RFZ
 uBoIZLA4Cac1Q93CkOvjbGaJXNUOqbL39679ocg9FIUaF3lrQ1N6AvIGk2idRZKxBifR
 qviEwVkZxLHVyyM9RE8PKVkWCxdEj86tN8TJE6XwWs5zb0mkMQ1D7d0dwixNMvtRb5gS
 n5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PX8oIefqvj4m1fhpk9Yk9JUCrGXiZ2uLTZFm+izHPPY=;
 b=G/sEwoilCqvXqo+TrdZ0HJbubhkefJQgP3kMIwhWRzZkmGZzB7cYMlSMlh7Wp3RlP2
 YET+v9KhRniXxDPdDOMTYSZs8tso6HmGgMYkFsiJ58KJZEbbxQwjPSTIqBZbmlXEgpdv
 MF6KEe5pIK5Xo/iohLFO02Ur24kWjqGE0wADY6UuVsxa+Imtsw4R4dkzbIs9bE9a5WRH
 vShXxKNoHW4GubTasIwUChj4/5uqee2e1jdlxWDX6LY1FPJaBVMt2DBCje+Qky4b6GCt
 mODZBGtML4bpXjLU/yXR2tPpA0omerBG6l1HjZMsf1+i92Hv9xue4Fw62LExOwEt1DMV
 5fzQ==
X-Gm-Message-State: AOAM531PkypAlaWjsX06cSd3+0Q87I2KCT2q+bDmBI4alGxefTlbyp5Q
 g0dsZRG4xEXgTXH5BPCuBWvxfqunLTDSJw==
X-Google-Smtp-Source: ABdhPJwBqdvld0GKkrUPUR1ElNVtH9R3UVxLEQyURWe2sbn/u9CTfRcc9RmOazFvzHaE2TgZVBzW1A==
X-Received: by 2002:a65:6450:: with SMTP id s16mr47468761pgv.71.1609800487145; 
 Mon, 04 Jan 2021 14:48:07 -0800 (PST)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:a87e])
 by smtp.gmail.com with ESMTPSA id n28sm56139005pfq.61.2021.01.04.14.48.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Jan 2021 14:48:05 -0800 (PST)
Date: Mon, 4 Jan 2021 14:48:04 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH V3 blktests 0/5] nvmeof-mp/srp/nvme-rdma misc fix and
 enhancement
Message-ID: <X/ObJB4Ixh8gplT7@relinquished.localdomain>
References: <20201126083532.27509-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201126083532.27509-1-yi.zhang@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210104_174811_248625_272200D2 
X-CRM114-Status: GOOD (  18.06  )
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
Cc: linux-block@vger.kernel.org, bvanassche@acm.org,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Nov 26, 2020 at 04:35:27PM +0800, Yi Zhang wrote:
> Hi
> 
> This patch series addressed some failures when I run nvmeof-mp/srp
> test and also add suport to use siw for nvme-rdma/nvmeof-mp/srp  testing
> from cmdline, like this:
> 
> $ use_siw=1 nvme-trtype=rdma ./check nvme
> $ use_siw=1 ./check nvmeof-mp
> $ use_siw-1 ./check srp
> 
> V3:
> Use sed to output the scheduler from sysfs directly in patch 3
> 
> V2:
> Update the ib_srpt module path in patch 1, avoid to use ls
> Update the SKIP_REASON in patch 2
> Introduce get_scheduler_list, fix nvmeof-mp/012 and srp/012 in patch 3
> Typo fix in patch 4
> 
> Yi Zhang (5):
>   tests/srp/rc: update the ib_srpt module name
>   tests/nvmeof-mp/rc: run nvmeof-mp tests if we set multipath=N
>   nvmeof-mp/012, srp/012: fix the scheduler list
>   common/rc: _have_iproute2 fix for "ip -V" change
>   common/multipath-over-rdma: allow to set use_siw
> 
>  common/multipath-over-rdma | 13 ++++++++++++-
>  common/rc                  |  2 +-
>  tests/nvmeof-mp/012        | 10 ++++++----
>  tests/nvmeof-mp/rc         |  8 +++++---
>  tests/srp/012              | 10 ++++++----
>  tests/srp/rc               |  4 ++--
>  6 files changed, 32 insertions(+), 15 deletions(-)

Applied, thanks!

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
