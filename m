Return-Path: <SRS0=jeJI=MB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1750CC07E99
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jul 2021 06:38:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FB93613B4
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jul 2021 06:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB93613B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MbljS8IiICJC1JTkARzUyx0O/gPtpe9aEM6nSvnSwNU=; b=tLBoqc4HM8YV2a
	x8QloqYpVXYooiePaoCOHkQAG/F6C+CEvQIBwLXb7rcIDFd6p264PG4lMH7Sm8VAT3CtLYBN3D3NA
	dzbho3LeNlzGghwSudzzQMu0oyA64c35BALBs0GTza+TIVboP7+vjk7RBJdkdxiwfNWCFnJWtuz8I
	vp2LSoO/ySARvPuNTXdGWYAp7fV3GihDOTrKLR2/1iZVcqUxblZrAYGAbhntSsZCtBcqmIGgLkl+g
	wQyFwCHuoBQvjzdo+Iy8nz0ZRg/FwtGlZ/lyyNjyeYe20S0/AmhbZqZg0dfa39c4lYTP2buus8Mc/
	mFu7ACrfl3dKY8i+foEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m1k92-000tqC-2x; Fri, 09 Jul 2021 06:37:52 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m1k8y-000tos-VI
 for linux-nvme@lists.infradead.org; Fri, 09 Jul 2021 06:37:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1CC2D68C4E; Fri,  9 Jul 2021 08:37:41 +0200 (CEST)
Date: Fri, 9 Jul 2021 08:37:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 0/4] nvme: protect against possible request
 reference after completion
Message-ID: <20210709063740.GA15955@lst.de>
References: <20210519174340.1144806-1-sagi@grimberg.me>
 <777a99bc-b7e3-ce39-cd98-ab1196aebb2e@grimberg.me>
 <20210616170411.GA921268@dhcp-10-100-145-180.wdc.com>
 <5c0766d9-9507-b0c7-4917-4b936fd7a197@grimberg.me>
 <20210701115123.ir7huzzpifhsk7cz@beryllium.lan>
 <20210701115220.GA12095@lst.de>
 <20210708100243.ibmntolineesakyj@beryllium.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210708100243.ibmntolineesakyj@beryllium.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210708_233749_349856_E1E6E549 
X-CRM114-Status: GOOD (  12.28  )
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

On Thu, Jul 08, 2021 at 12:02:43PM +0200, Daniel Wagner wrote:
> On Thu, Jul 01, 2021 at 01:52:20PM +0200, Christoph Hellwig wrote:
> > I think this can go in as soon as we open the nvme-5.15 branch.
> 
> nvme-5.15 or nvme-5.14?

5.15.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
