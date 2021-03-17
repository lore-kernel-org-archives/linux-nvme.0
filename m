Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB74C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 06:59:29 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BFDC64F89
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 06:59:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BFDC64F89
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ISP5WPH9QMWm9Tm3A0NxBeWt7JFLuXvs9wCuUIYb708=; b=bialUeW/5I93/uz02VVQQmouw
	TsTj6lJHkQkw4l66lEwc7OLPPisdE7Ulu4uQhzew7tndMmzOEgsxgQfMuAgk/PucLHW2JUcRkTS6A
	/dG8vdI6ztXuWnsJikdAykPx6xkze4IBJ/wrXc4l6TLcTrsolGXkHaqJEJMbGvZ9nUPHnCYC7ln9w
	vnZyYd6WQxNegmuUqghw2cmNaM7hfdOEInM0hH40xot7JLGTeJaNFOVnl3t5Prs3VqVI9XaNljpKA
	5z0apZjkQRL2e551L7fCr0DJe/w1/YjQPPIcQIzb66SbXRpKoQ2+rcqTw5H5DJPs6CcaWQMprDXub
	BL6rfoQAw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMQ9I-002d8q-36; Wed, 17 Mar 2021 06:59:20 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMQ9B-002d72-35
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 06:59:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D190668BEB; Wed, 17 Mar 2021 07:59:10 +0100 (CET)
Date: Wed, 17 Mar 2021 07:59:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chao Leng <lengchao@huawei.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH 0/3 rfc] Fix nvme-tcp and nvme-rdma controller reset hangs
Message-ID: <20210317065910.GC14498@lst.de>
References: <20210315222714.378417-1-sagi@grimberg.me>
 <1b2ccda9-5789-e73a-f0c9-2dd40f320203@grimberg.me>
 <20210316204204.GA23332@redsun51.ssa.fujisawa.hgst.com>
 <59f7a030-ea33-5c31-3c18-197c5a12e982@grimberg.me>
 <17b15849-f0f3-af61-113f-0eb717e96f0f@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <17b15849-f0f3-af61-113f-0eb717e96f0f@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_065913_669619_CBEC3726 
X-CRM114-Status: GOOD (  13.72  )
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

On Wed, Mar 17, 2021 at 10:55:57AM +0800, Chao Leng wrote:
>>> Will it work if nvme mpath used request NOWAIT flag for its submit_bio()
>>> call, and add the bio to the requeue_list if blk_queue_enter() fails? I
>>> think that looks like another way to resolve the deadlock, but we need
>>> the block layer to return a failed status to the original caller.

Yes, I think BLK_MQ_REQ_NOWAIT makes total sense here.  dm-mpath also
uses it for its request allocation for similar reasons.

>>
>> But who would kick the requeue list? and that would make near-tag-exhaust performance stink...

The multipath code would have to kick the list.  We could also try to
split into two flags, one that affects blk_queue_enter and one that
affects the tag allocation.

> moving nvme_start_freeze from nvme_rdma_teardown_io_queues to nvme_rdma_configure_io_queues can fix it.
> It can also avoid I/O hang long time if reconnection failed.

Can you explain how we'd still ensure that no new commands get queued
during teardown using that scheme?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
