Return-Path: <SRS0=/X2o=ZE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E49C43331
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 21:36:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2564D2084E
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 21:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TKSXd/wC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYuSmGGF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2564D2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Olw00Kkr1vPff1SwvZWILQcppBmuvqqBt24OwIqoZvk=; b=TKSXd/wCe++Psj
	VAqJ2bNNz5lzv5UJPdlovbzxlK+PWWSRTQXrMgYREdieRWogomQ7focqp9orOxWzEQvXjDtoHaAqW
	qZa1Beh9sVjf+cfcz348qdTKHgJ134RdgJD+0mzlPx2yf01raMyxcKx5WftaJ2P6xv4+/9IKOUll+
	cBvnTHo9ok1M1zjon3fZ7XJiOHanG5L14ImnbOU573oNPdXBsLwZdAkPv4oZQEz7AC0tpxeKCMwE4
	k84q2krf+FdQccngZNkeIP/dJUIN+I9oQsA01Ce/pXuPHyWHiQoQ0wyfDlWQoVJNwBJeevSl0B28M
	zkJjhYhVaKSblC27yrIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iUdqL-000796-Vs; Tue, 12 Nov 2019 21:36:57 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iUdqI-00078g-Dd
 for linux-nvme@lists.infradead.org; Tue, 12 Nov 2019 21:36:55 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8F99B20674;
 Tue, 12 Nov 2019 21:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1573594613;
 bh=KT2GjEt3BEczXBeaCO4w7FFghD60f6gHZa3tcZVioL4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nYuSmGGFUaa3cYvTQ9FUyYs149ix8UO8LpOWE0oEtD/E5wkiNIckGQ1EQR3nqg3lE
 4/F/vhPtHcCwjXeTn+Mcn+7UUTNmmz/bRNNyf//HsKgm/LUnXylYs8Q4t5pBP48Fur
 DXVV4MYso9rOhEnJJlHJOJNdpuM+ajrX51ytvRm4=
Date: Wed, 13 Nov 2019 06:36:46 +0900
From: Keith Busch <kbusch@kernel.org>
To: Long Li <longli@microsoft.com>
Subject: Re: [PATCH 2/2] nvme-pci: poll IO after batch submission for
 multi-mapping queue
Message-ID: <20191112213646.GA1964@redsun51.ssa.fujisawa.hgst.com>
References: <20191108035508.26395-1-ming.lei@redhat.com>
 <20191108035508.26395-3-ming.lei@redhat.com>
 <20191111204446.GA26028@lst.de>
 <CY4PR21MB0741004E62F9C50B8EF7DA9ECE770@CY4PR21MB0741.namprd21.prod.outlook.com>
 <20191112023920.GD15079@ming.t460p>
 <CY4PR21MB0741BB1F48C64613BF6E45F6CE770@CY4PR21MB0741.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CY4PR21MB0741BB1F48C64613BF6E45F6CE770@CY4PR21MB0741.namprd21.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191112_133654_481584_7516E924 
X-CRM114-Status: GOOD (  15.94  )
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
Cc: Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Nov 12, 2019 at 09:20:27PM +0000, Long Li wrote:
> >Subject: Re: [PATCH 2/2] nvme-pci: poll IO after batch submission for multi-
> >mapping queue
> >
> >On Tue, Nov 12, 2019 at 12:33:50AM +0000, Long Li wrote:
> >> >From: Christoph Hellwig <hch@lst.de>
> >> >Sent: Monday, November 11, 2019 12:45 PM
> >> >To: Ming Lei <ming.lei@redhat.com>
> >> >Cc: linux-nvme@lists.infradead.org; Keith Busch <kbusch@kernel.org>;
> >> >Jens Axboe <axboe@fb.com>; Christoph Hellwig <hch@lst.de>; Sagi
> >> >Grimberg <sagi@grimberg.me>; Long Li <longli@microsoft.com>
> >> >Subject: Re: [PATCH 2/2] nvme-pci: poll IO after batch submission for
> >> >multi- mapping queue
> >> >
> >> >On Fri, Nov 08, 2019 at 11:55:08AM +0800, Ming Lei wrote:
> >> >> f9dde187fa92("nvme-pci: remove cq check after submission") removes
> >> >> cq check after submission, this change actually causes performance
> >> >> regression on some NVMe drive in which single nvmeq handles
> >> >> requests originated from more than one blk-mq sw queues(call it
> >> >> multi-mapping queue).
> >> >
> >> >> Follows test result done on Azure L80sv2 guest with NVMe drive(
> >> >> Microsoft Corporation Device b111). This guest has 80 CPUs and 10
> >> >> numa nodes, and each NVMe drive supports 8 hw queues.
> >> >
> >> >Have you actually seen this on a real nvme drive as well?
> >> >
> >> >Note that it is kinda silly to limit queues like that in VMs, so I
> >> >really don't think we should optimize the driver for this particular case.
> >>
> >> I tested on an Azure L80s_v2 VM with newer Samsung P983 NVMe SSD
> >(with 32 hardware queues). Tests also showed soft lockup when 32 queues
> >are shared by 80 CPUs.
> >>
> >
> >BTW, do you see if this simple change makes a difference?
> 
> Yes, I can confirm the patch fixed lockup on this VM configuration.  There is also no performance regression.

What if you just use threaded interrupts with the path that scheduels
the bottom-half on any CPU in the mask? Does that resolve lockup?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
