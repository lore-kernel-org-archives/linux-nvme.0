Return-Path: <SRS0=ETB4=CR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D778AC43461
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2020 08:54:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 891142166E
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2020 08:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DGvFU2KZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 891142166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2l3FGz0lOE+pJ0sEsZYlpBvv+Fp0YP2PZtx5YcIcOW0=; b=DGvFU2KZoKKGs5cfLtHQ9evNn
	NPjKR39qvREtNUTVcLapezaZ2+blURKvonPOm3XbVa75LAsC7Zoejmm4dhQ/f8RKR731N1Mt9Pv0N
	YI8U92QGcHBSgm+XlVgmkCqg8ZIUwYWSNeSOAij+5lESbYVWXLb81KWIQELIDc3CEX9x/XzQa1zXU
	1SW+nmG8GEOm1JNQXpyXHbxzE/82WtiIASw/y/juBG4a21brHklFzDmYMWfci6XjC86g5W3kcj7ah
	3GUpv3c+6Y+SpL+e8wngWnfafPWRVsBu36oDy6J+TVGcGNvg8SugUNWUpoASUIsmKDbqho6r2Z/Og
	3SHUuEShA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kFZOp-0002fA-81; Tue, 08 Sep 2020 08:54:47 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kFZOm-0002eO-Em
 for linux-nvme@lists.infradead.org; Tue, 08 Sep 2020 08:54:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id ECC9168AFE; Tue,  8 Sep 2020 10:54:42 +0200 (CEST)
Date: Tue, 8 Sep 2020 10:54:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH 3/3] nvme-core: fix nvme module ref count Oops
Message-ID: <20200908085442.GD17413@lst.de>
References: <20200904023929.5320-1-chaitanya.kulkarni@wdc.com>
 <20200904023929.5320-4-chaitanya.kulkarni@wdc.com>
 <8c075e3a-d461-7d58-7c02-5ce81cfff6b9@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8c075e3a-d461-7d58-7c02-5ce81cfff6b9@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200908_045444_703423_26025CFA 
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
Cc: kbusch@kernel.org, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Sep 04, 2020 at 09:57:02AM -0600, Logan Gunthorpe wrote:
> I'd probably just fold these changes into the previous patch. When we
> get a reference to the controller we must also get a reference to the
> transport module. So no sense getting the different references in
> different patches.

Yes, that sounds sensible.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
