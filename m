Return-Path: <SRS0=YD4V=6H=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A881DC54FD0
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Apr 2020 05:54:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CC182075A
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Apr 2020 05:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fwdAIK1K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CC182075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Wrg16jWvRpsia4uJYz9ONsYWhHhMKO8hX7w9E288Dnk=; b=fwdAIK1KmlI9Yb
	RFrJSb8HyKkbcdI6kvvVTfnESnnvXJ0zAVkviyoZp6EGlcHSgAfFhXnl0N/Gxke9VfGJ77As31OaN
	b11955tStXbpv0s5UIhb5ASZs3zBstTAeAKE9LbyIV3LIKSlWDSVAjwivhJBTpf6s0qHarxDOauxy
	LPgxZ+PvjtiyH4lt/3RXw4fsSSzK0mvbNKbjcAGN3xzcSNuaGMR70DZ03WdSZesmRzc/Vy1NpKckh
	rHPsRAs6spZLIC6irDTbpVhqLBEXcKTuG/Mv37WgSxJc85Bst1SgvaNP+TJvMj4cU729q6h/rXZ+N
	mDIEgJx07+KstfiVVvfQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jRUp1-0007AA-Uf; Thu, 23 Apr 2020 05:54:51 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jRUoz-000798-Uf
 for linux-nvme@lists.infradead.org; Thu, 23 Apr 2020 05:54:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 111CB227A81; Thu, 23 Apr 2020 07:54:48 +0200 (CEST)
Date: Thu, 23 Apr 2020 07:54:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 05/17] nvme-fabrics: Allow user enabling
 metadata/T10-PI support
Message-ID: <20200423055447.GB9486@lst.de>
References: <20200327171545.98970-1-maxg@mellanox.com>
 <20200327171545.98970-7-maxg@mellanox.com> <20200421151747.GA10837@lst.de>
 <54c05d2d-2ea5-bf58-455f-91efa085aa9b@mellanox.com>
 <70f40e49-d9d7-68fe-6a63-a73fabcd146d@gmail.com>
 <172c1860-bebe-04b2-a9ab-2c03c7cfbf18@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <172c1860-bebe-04b2-a9ab-2c03c7cfbf18@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200422_225450_135709_3752FE42 
X-CRM114-Status: GOOD (  11.28  )
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
Cc: axboe@kernel.dk, James Smart <jsmart2021@gmail.com>, sagi@grimberg.me,
 martin.petersen@oracle.com, shlomin@mellanox.com, linux-rdma@vger.kernel.org,
 israelr@mellanox.com, vladimirk@mellanox.com, linux-nvme@lists.infradead.org,
 idanb@mellanox.com, jgg@mellanox.com, oren@mellanox.com, kbusch@kernel.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Apr 23, 2020 at 01:39:26AM +0300, Max Gurtovoy wrote:
> it's a bit late for me now so I probably wrote non standard sentence above.
>
> BUT what I meant to say is I would like to give the user an option to 
> decide whether use E2E protection or not (of course a controller can 
> control protected and non-protected namespaces :) )

I don't really have a problem with an opt-out, but I'd like to apply it
consistently over all transports.

>
> AFAIK, there is no option to format a ns in NVMf (at least for RDMA there 
> is only 1 lbaf exposed by the target) so i'm not sure how exactly this will 
> work.

The NVMe protocol Format NVM support is independent of the transport.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
