Return-Path: <SRS0=5twQ=XA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1155EC43331
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 16:11:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A73E520825
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 16:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TbJvjwfR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A73E520825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y6hik8XgSdU1G/8p1l8e0nMK2eSiHUpR4ufpAfaGJdo=; b=TbJvjwfRk85gt6
	c3Ds4jdxed6TpdPt2/NY5GQ/oXUP1lvnSwQMlT1fPcuR7EBKTgFRV3V9v8064ax7Z/ijy79ydP7ir
	/4hY7gKW9ylurQIioQJsgluAfPQojP/TcHH6sQrUzaIuCcrcN1bdN0ZiF8udJyPUptL312QDwmYpO
	pSXoZkEy1v5AQR5urBkvNKOl1yIo9ePmRcLkaEJ1oDZQoLmm/aEBeTpaInU74KPZW0f/RcrKfLDSC
	EbYpGHHCn9Tw37jDfHhQEIEmLqF034N9fCCCYdb+3CLfHsV1eH4luhPjD+27RTKZIzV7v3Yo5Cy4S
	1pBtqIdus/IDFHzckDbA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5uMJ-0007KA-E4; Thu, 05 Sep 2019 16:11:43 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5uMG-0007JV-K6
 for linux-nvme@lists.infradead.org; Thu, 05 Sep 2019 16:11:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0B01668B05; Thu,  5 Sep 2019 18:11:35 +0200 (CEST)
Date: Thu, 5 Sep 2019 18:11:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: Restore device naming sanity
Message-ID: <20190905161134.GA22363@lst.de>
References: <20190904173159.22921-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190904173159.22921-1-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190905_091140_811814_2DB426EB 
X-CRM114-Status: UNSURE (   9.86  )
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
Cc: Hannes Reinecke <hare@suse.com>, Sagi Grimberg <sagi@grimberg.me>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Logan Gunthorpe <logang@deltatee.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Sep 04, 2019 at 11:31:59AM -0600, Keith Busch wrote:
> The namespace names must be unique for the lifetime of the subsystem.
> This was accomplished by using their parent subsystems' instances which
> was independent of the controllers connected to that subsystem.
> 
> The consequence of that naming scheme meant that name prefixes given to
> namespaces may match a controller from an unrelated subsystem. This has
> understandbly invited confusion when examining device nodes.
> 
> Ensure the namespace's subsystem instance never clashes with a
> controller instance of another subsystem by transferring the instance
> ownership to parent subsystem from the first controller discovered in
> that subsystem.

Sanitity sounds a little exaggerated.  The nvme naming isn't really
that different except that the block devices uses number where say
scsi uses letters.  So maybe tone down that claim a bit, but otherwise
the patch looks fine.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
