Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E770AC433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 08:46:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4F4D20836
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 08:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sXlZhL6L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4F4D20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=P7N438rjZAPOi18kkFvG7eP/xyq3KsfwSpcxMucy4ME=; b=sXlZhL6LVYMX8es+i/TpJ3m3a
	/miKWevlaX9JLktpWyy80B+sLMnao3H6I8bSBbKxGbsS1pqlbS1C+zTAkqzgJg/nzIG9GKX0n4pA1
	Yd8uEmUyNDyN6dSQwBRYKQXJHkSSUWIQhFmwJNNfbTwNR0EQX004wlXGhN20KgB95CAxfrESe+xYx
	5Cm+B3lNaM8vtzootetMcV8pLuOrXHe6/HMMGPX/XHMLc++7N3K9YUftJQiAkRU/6ohk+06pGOo49
	9vUebeVtGb6FBLfBNyjkiNgRh+g+ZKuJPbgZ6OybGuZ2MNv0NFcVKNQwLHMT9atdDRct/49iJNzYI
	EaXtBjOSw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jo13G-0004Bz-37; Wed, 24 Jun 2020 08:46:38 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jo13E-0004BY-4E
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 08:46:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 161B668B02; Wed, 24 Jun 2020 10:46:34 +0200 (CEST)
Date: Wed, 24 Jun 2020 10:46:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 3/3] nvme-rdma: assign completion vector correctly
Message-ID: <20200624084633.GA24240@lst.de>
References: <20200623145525.1586-1-maxg@mellanox.com>
 <20200623145525.1586-4-maxg@mellanox.com>
 <20200623152236.GA3072004@mellanox.com>
 <543adcc9-fda0-abb2-c37a-fb961d65c5cd@grimberg.me>
 <ec6b1a89-0cc0-1378-6d29-29b9d255c7f5@mellanox.com>
 <20200624083743.GA23529@lst.de>
 <0e102b77-79bb-0dc6-48e7-10cc3aefc9a8@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0e102b77-79bb-0dc6-48e7-10cc3aefc9a8@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
Cc: yaminf@mellanox.com, Sagi Grimberg <sagi@grimberg.me>, idanb@mellanox.com,
 israelr@mellanox.com, linux-nvme@lists.infradead.org, shlomin@mellanox.com,
 Jason Gunthorpe <jgg@nvidia.com>, kbusch@kernel.org, ogerlitz@mellanox.com,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jun 24, 2020 at 11:44:06AM +0300, Max Gurtovoy wrote:
>> I don't think 1+2 are 5.8 material, so please just resend 3 standalone
>> for now, and then resend 1+2 once I've merged it and rebased nvme-5.9
>> on top of nvme-5.8.
>
> Ok. Actually 1+2 were aimed to be merged to 5.8 but created a conflict 
> between Jason's and Jens's trees.
>
> If we go this way it means we can't push new features to RDMA and use it in 
> NVMf in the same cycle.
>
> Jason,
>
> can we push iSER CQ sharing to kernel-5.8 ?

We're not going to merge new features in nvme after -rc2.  For cross
subsystem coordination either everything needs to go in through one
tree if possible, or we'll need shared branches.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
