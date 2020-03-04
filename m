Return-Path: <SRS0=Ayoq=4V=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A28C3F2D1
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2020 16:32:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 059C62146E
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2020 16:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FbczPhIc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 059C62146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4ddpW+Nf4t0qLBb/RTmkQqqz1ec2SeO7HrsfVveGN08=; b=FbczPhIcNGDHmQ
	EcEboyXITQvU9kRxOEyrq1rcuciynv/MPg6FsiXAKdQzfVemS3Pwc5MdqRrSkwbqoFFBimUa5Agmb
	RQOlEASV4qozUBllN6zYLcIvrzsZ7jl/8tweS7/AkcJVzqzCPAZYuDuc66GPsZ6DI9uQVCC/1JyUj
	5mKjGvVtPQLMTjoEcXr0dS/jd2twbkYzxv7tkYngQF9FDa31AtRG4g0LXtib5vqDez0itbY1Ry0HB
	SZhm2JKYA+yROmgR9SKZ+9U8cinkXAGevXVk98n+BByALY42iLrrTfZA9PGm8UhBKjfANxqpA9eBY
	ejjPaixIWVTioJIlOPag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j9Wwh-0000w6-Oy; Wed, 04 Mar 2020 16:32:31 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j9WwY-0000lO-Jm
 for linux-nvme@lists.infradead.org; Wed, 04 Mar 2020 16:32:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7ECF068B20; Wed,  4 Mar 2020 17:32:20 +0100 (CET)
Date: Wed, 4 Mar 2020 17:32:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 3/3] nvmet-rdma: allocate RW ctxs according to mdts
Message-ID: <20200304163220.GC11846@lst.de>
References: <20200304153935.101063-1-maxg@mellanox.com>
 <20200304153935.101063-3-maxg@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200304153935.101063-3-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200304_083222_844819_89A84BDD 
X-CRM114-Status: UNSURE (   8.01  )
X-CRM114-Notice: Please train this message.
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
Cc: sagi@grimberg.me, Chaitanya.Kulkarni@wdc.com, bharat@chelsio.com,
 nirranjan@chelsio.com, linux-nvme@lists.infradead.org, krishna2@chelsio.com,
 jgg@mellanox.com, kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Mar 04, 2020 at 05:39:35PM +0200, Max Gurtovoy wrote:
> Current nvmet-rdma code allocates MR pool budget based on queue size,
> assuming both host and target use the same "max_pages_per_mr" count.
> After limiting the mdts value for RDMA controllers, we know the factor
> of maximum MR's per IO operation. Thus, make sure MR pool will be
> sufficient for the required IO depth and IO size.
> 
> That is, say host's SQ size is 100, then the MR pool budget allocated
> currently at target will also be 100 MRs. But 100 IO WRITE Requests
> with 256 sg_count(IO size above 1MB) require 200 MRs when target's
> "max_pages_per_mr" is 128.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
