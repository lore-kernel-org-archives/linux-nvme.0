Return-Path: <SRS0=Q2qb=ZS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A16C432C0
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Nov 2019 16:22:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64444207DD
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Nov 2019 16:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lwgtuK08"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64444207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=es1BD9IUAfbwCbif/71uB7k4AK3Uvs9JSyI75T4W4ys=; b=lwgtuK08NJfgLK
	h82FxOhiha6lgQwdtUqlXkYq3++jMk1JxfxKdCvQB6FB6SrGWM12PiGO5LwDBfxiFWTb/osQMdmbr
	3HeKzsBVChXbEcS/KzxRubSguqml0G8+ADxnYf4BBvLZsg6DwOiR65pSr0xZfsZdtvM0tGiKvulGL
	kRIeDPgnGh/Nw4rsy46Js0dYnhCWmoN1u/IYtYckr8D/ePqR2EsUBwj8Zr+dFoOIdCPD+0V5d7tqv
	K72m0VqmxdlWdkMGPtVDHUMpT5CTgrP/8hdsK43PI9W3yeq6fEXlunk+KaeuoedxOPPpTGckUv436
	CqkxzkH0SbtXobbrQI3w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iZdbU-00012s-2G; Tue, 26 Nov 2019 16:22:16 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iZdbQ-00012M-LA
 for linux-nvme@lists.infradead.org; Tue, 26 Nov 2019 16:22:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id AB43068C4E; Tue, 26 Nov 2019 17:22:06 +0100 (CET)
Date: Tue, 26 Nov 2019 17:22:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme: always treat DNR status as no-retryable
Message-ID: <20191126162206.GB7562@lst.de>
References: <20191126133749.72267-1-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191126133749.72267-1-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191126_082212_847111_B32DE39A 
X-CRM114-Status: GOOD (  10.17  )
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
Cc: Keith Busch <keith.busch@intel.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Nov 26, 2019 at 02:37:49PM +0100, Hannes Reinecke wrote:
> If the DNR bit is set in the command status we should not retry
> the command, irrespective of what the actual status is.
> So map it directly to BLK_STS_TARGET to inform upper layers to
> not retry the command, not even on another path.

We've been there before, have we?  What is your use case.  I.e.
what part of the kernel is retrying what command that you don't
want to be retried?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
