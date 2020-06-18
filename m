Return-Path: <SRS0=0To6=77=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A397C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 17:11:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2C892080D
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 17:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d/1E1XBI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2C892080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WIuBqPk9kNcfOpoA4oYc3eaaFwEwlo17WECnnd3DYgE=; b=d/1E1XBIUa0T/o
	GJ4qf2TjNULA2qyfuYn+dlYig4FQVIyNSajRzzGUhOHguMqf+m2RaNisyvKTs1DJ5ur+nqz+PDPI7
	Tkfiv/FXzcMYW9mUfhLMWFKGGOr6+vhCYKfix2itIEUBBKOoCg3+1GIGS6uiHik+tvfb3Zt4ncSOM
	Qu1KxRz53yNcB80goKCr5FngmYnIatCygSq/yMKxMrIeg0Iumj6jTkwDa9Zw1uC9sjx5htxeuq2XQ
	S5/TKqnWfgv3XdI2BGw5qkZpy6EKOH6gJMvmTBPcYxuhz5tNAsvNSaPtAUx7JAPoWLLrZiLelEjC5
	hnvH3rjSmfQkltrDYKCw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jly4e-0002FI-G3; Thu, 18 Jun 2020 17:11:36 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jly4b-0002E6-Q2
 for linux-nvme@lists.infradead.org; Thu, 18 Jun 2020 17:11:35 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E99FBAFA7;
 Thu, 18 Jun 2020 17:11:25 +0000 (UTC)
Date: Thu, 18 Jun 2020 19:11:24 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Niklas Cassel <niklas.cassel@wdc.com>
Subject: Re: [PATCH 1/2] nvme: remove workarounds for gcc bug wrt unnamed
 fields in initializers
Message-ID: <20200618171124.tfowb2ejv3bnvxr4@beryllium.lan>
References: <20200618143241.1056800-1-niklas.cassel@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200618143241.1056800-1-niklas.cassel@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200618_101133_987648_6FD312EE 
X-CRM114-Status: GOOD (  10.07  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jun 18, 2020 at 04:32:40PM +0200, Niklas Cassel wrote:
> If, for some reason, we want to allow builds with gcc < 4.6.0
> even though the minimum gcc version is now 4.8.0,

Just one thing to watch out: the stable trees are still using
older version of gcc. Note sure how relevant this is though.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
