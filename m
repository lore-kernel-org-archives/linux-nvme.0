Return-Path: <SRS0=q3TM=63=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F13C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2020 18:19:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 021052065C
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2020 18:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RmcayqT/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 021052065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bYLlvkjh+ux/8xScoLZxj3FofsWgVJtDSkwOBMnAFZ4=; b=RmcayqT/mhyPA6
	4nNdC7vC6KKOolSBiAL14Bp5Nx61EV68Ayr031tJepk86IRqyXE0WmwiUb+taVA+XIJCQW9a8KBzN
	7TQRL2zT9qOj0Qo3pXzBUTKs6wJeI/QK6I1L/IJo+rcVQykEdeC72q+Rz43ryZxHQjUEj9Whd0Iy2
	puY4CyNoZs4rt1Nsbv6igZHkisvh5QLz4HIP+GAt8YH4UmBMipaHHiM0VE76rVEsXTEE1HeonwHQU
	tPQXVA1rxr8eYedTfRrkdC5zoKKS7N7UrRDqL3Cp9rR1FV1mxviKLNjAABH1jPbDacpEqhrbh0SI0
	08JGIRNH+53ImthXNfIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jYvyH-0006hD-3p; Wed, 13 May 2020 18:19:09 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYvyE-0006gi-6q
 for linux-nvme@lists.infradead.org; Wed, 13 May 2020 18:19:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5FEFF68B05; Wed, 13 May 2020 20:19:00 +0200 (CEST)
Date: Wed, 13 May 2020 20:18:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH 03/16] nvme: introduce NVME_NS_METADATA_SUPPORTED flag
Message-ID: <20200513181859.GA29596@lst.de>
References: <20200504155755.221125-1-maxg@mellanox.com>
 <20200504155755.221125-4-maxg@mellanox.com>
 <e21354ca-a7bb-cf2d-d427-c8410c797a49@broadcom.com>
 <71c7458e-81cd-7200-2e1b-3563cdddd5ad@mellanox.com>
 <62322680-afeb-142e-c10b-b4f2d4c419a3@broadcom.com>
 <1b03c314-2e57-5135-6875-a2d37ecf5e20@mellanox.com>
 <cca0ab45-7dde-c461-b20f-d44f58a8a117@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cca0ab45-7dde-c461-b20f-d44f58a8a117@broadcom.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200513_111906_400245_961B01E0 
X-CRM114-Status: UNSURE (   6.67  )
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
Cc: axboe@kernel.dk, jsmart2021@gmail.com, sagi@grimberg.me,
 martin.petersen@oracle.com, idanb@mellanox.com, israelr@mellanox.com,
 vladimirk@mellanox.com, linux-nvme@lists.infradead.org, shlomin@mellanox.com,
 oren@mellanox.com, kbusch@kernel.org, Max Gurtovoy <maxg@mellanox.com>,
 nitzanc@mellanox.com, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, May 11, 2020 at 04:50:09PM -0700, James Smart wrote:
> Lets move on. I've been a little short of time. I should review the meatier 
> patch, patch 6, tomorrow sometime.

Can you get to it?  I'd like to pick this series up in the next days.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
