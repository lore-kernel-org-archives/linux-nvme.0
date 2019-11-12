Return-Path: <SRS0=/X2o=ZE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4654C43331
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 01:44:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DD39206C3
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 01:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LEW34KuL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD39206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=E5MxXVBFvFI1DNdjf+hJevYuNLT8+rWTyhhIGZW0l7M=; b=LEW34KuLBoPSwwdBjhbkG6NXG
	19oXlcdisFFCA4PBBZqsvv+keOwu278cX/k9P1tylXGOpmh5wts06r4YY0HXy0lfh3hF9xnjxhxV4
	G5HLIa9FjlLH2OxGtNALueCqrlLx7NeKJHvfgwIWPj069rtktpP9lxgQzC4dAKI9Xx7x1PT6WRFDW
	epOwBkGMKd51Nh70NBFxmXgWnp/iZs8yrIENVWcX6XjaiDBaGopnvpJt0u/fz0cOKu+DniRK0IITE
	ZOo4/isi2WMLYsyhF1hBhSCDzeBslqBXJ+w0/T2D3UXWA8SAn6KM+RJQi/ssmv6DMM9kQZYeA3Wyt
	HEeyO4KzQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iULEB-0002HI-7R; Tue, 12 Nov 2019 01:44:19 +0000
Received: from mail-wr1-f67.google.com ([209.85.221.67])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iULE7-0002Ga-Vi
 for linux-nvme@lists.infradead.org; Tue, 12 Nov 2019 01:44:17 +0000
Received: by mail-wr1-f67.google.com with SMTP id f2so16661328wrs.11
 for <linux-nvme@lists.infradead.org>; Mon, 11 Nov 2019 17:44:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FnR1OfjMkvomHpsfYTv4f9qGcytTYQ79VSP+wy6+s3M=;
 b=oyihYsC3/m4NZnLpzDeODD6Uz3UB4e8ffJh32jhgwrbRfKZzzO33yebi5sHgmhp+v/
 d5W+8t3dyYtFn6B9BVrCXgllZRM6nlezvoom3j3zdKbajmNDDCp6jeGpLGr/k25Pk/pb
 Dc66ZYRP/RaHndf/o01ioH6a3zmqCy4dDHVhSEuLv4QQ0e/dcyQAJGTub0lOS3O9Yari
 OJ53TMa7/yPbzNJGMXaRAnsRTdnWdMLaFEHXlJpSv7h0NvH9q7KAh3DussZ+ocikifVW
 IzEe2ZjUXKsMUltzOhqtjRHVZM+zh87nYt+zfnXx/q9FK6/m9gqWgZtKXBpmAumTkGy0
 mEzQ==
X-Gm-Message-State: APjAAAVIrv9bHmQMtzV+xg772CYuo7130EYKJ6rc+j3PDBD/WzEUJp3T
 9hpV8vOmECgsl98biuOo7DA=
X-Google-Smtp-Source: APXvYqyldpV6NTyEpd88ncGkCgfks4N7qnuThSQIz7pmTfe0gpdZ9hItEx1uQ4833bAUxMl+I9oFig==
X-Received: by 2002:adf:fe0e:: with SMTP id n14mr24315116wrr.72.1573523054102; 
 Mon, 11 Nov 2019 17:44:14 -0800 (PST)
Received: from [192.168.1.114]
 (162-195-240-247.lightspeed.sntcca.sbcglobal.net. [162.195.240.247])
 by smtp.gmail.com with ESMTPSA id t12sm16304973wrx.93.2019.11.11.17.44.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 Nov 2019 17:44:13 -0800 (PST)
Subject: Re: [PATCH 2/2] nvme-pci: poll IO after batch submission for
 multi-mapping queue
To: Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org
References: <20191108035508.26395-1-ming.lei@redhat.com>
 <20191108035508.26395-3-ming.lei@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <82fb330e-a507-999a-69f3-947f13bbaae1@grimberg.me>
Date: Mon, 11 Nov 2019 17:44:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191108035508.26395-3-ming.lei@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191111_174416_022877_36BF1740 
X-CRM114-Status: GOOD (  18.65  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Long Li <longli@microsoft.com>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> f9dde187fa92("nvme-pci: remove cq check after submission") removes
> cq check after submission, this change actually causes performance
> regression on some NVMe drive in which single nvmeq handles requests
> originated from more than one blk-mq sw queues(call it multi-mapping
> queue).
> 
> Actually polling IO after submission can handle IO more efficiently,
> especially for multi-mapping queue:
> 
> 1) the poll itself is very cheap, and lockless check on cq is enough,
> see nvme_cqe_pending(). Especially the check can be done after batch
> submission is done.
> 
> 2) when IO completion is observed via the poll in submission, the requst
> may be completed without interrupt involved, or the interrupt handler
> overload can be decreased.
> 
> 3) when single sw queue is submiting IOs to this hw queue, if IOs completion
> is observed via this poll, the IO can be completed locally, which is
> cheaper than remote completion.
> 
> Follows test result done on Azure L80sv2 guest with NVMe drive(
> Microsoft Corporation Device b111). This guest has 80 CPUs and 10
> numa nodes, and each NVMe drive supports 8 hw queues.

I think that the cpu lockup is a different problem, and we should
separate this patch from that problem..

> 
> 1) test script:
> fio --bs=4k --ioengine=libaio --iodepth=64 --filename=/dev/nvme0n1 \
> 	--iodepth_batch_submit=16 --iodepth_batch_complete_min=16 \
> 	--direct=1 --runtime=30 --numjobs=1 --rw=randread \
> 	--name=test --group_reporting --gtod_reduce=1
> 
> 2) test result:
>       | v5.3       | v5.3 with this patchset
> -------------------------------------------
> IOPS | 130K       | 424K
> 
> Given IO is handled more efficiently in this way, the original report
> of CPU lockup[1] on Hyper-V can't be observed any more after this patch
> is applied. This issue is usually triggered when running IO from all
> CPUs concurrently.
> 

This is just adding code that we already removed but in a more
convoluted way...

The correct place that should optimize the polling is aio/io_uring and
not the driver locally IMO. Adding blk_poll to aio_getevents like
io_uring would be a lot better I think..

> I also run test on Optane(32 hw queues) in big machine(96 cores, 2 numa
> nodes), small improvement is observed on running the above fio over two
> NVMe drive with batch 1.

Given that you add shared lock and atomic ops in the data path you are
bound to hurt some latency oriented workloads in some way..

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
