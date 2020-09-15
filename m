Return-Path: <SRS0=GAdO=CY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10641C43461
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 05:51:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2493206C9
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 05:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SRKA0GMQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2493206C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aTwBzwzOggJQlEn5Xi+3IvxWaWQY/ULa/ayBzGYmmDU=; b=SRKA0GMQ99/lUYK5BEsRojQf+
	07sRmmoosTUrkVyJAvZnYEJGGFvWMxkAwV32CRgCJ388qUGx0tYVD4yUrUKsNEi86au5VtvJEmeUe
	ZWdhHEzNqFoGkM2Y7IVh3b3orgAnajq3f5bhruEkmlNYq5cILNbKcv9R0aWPu50xvL9e/zjoJ22Vf
	cqKWLlNzO0oPt7EumlLmEAeif+j9at/34vkWnWWaHM/PzKSkPKepXHU7WHo0eszXBID5LWbV71Pqz
	ddJHWmdoCQfF7AajwCA1tkFfxiRaJ/d6omF1mvCFITcc1mKJ8E+7RKG9ydMKSKRbQtNetauWNXR19
	/jGM1fUXA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kI3rr-0003d8-Ak; Tue, 15 Sep 2020 05:51:03 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kI3rm-0003cR-S9
 for linux-nvme@lists.infradead.org; Tue, 15 Sep 2020 05:50:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 47FEF6736F; Tue, 15 Sep 2020 07:50:56 +0200 (CEST)
Date: Tue, 15 Sep 2020 07:50:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] nvme-pci: Move enumeration by class to be last in
 the table
Message-ID: <20200915055056.GA18367@lst.de>
References: <20200818083530.18983-1-andriy.shevchenko@linux.intel.com>
 <20200914153322.GK3956970@smile.fi.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200914153322.GK3956970@smile.fi.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200915_015059_083821_C2AC0B87 
X-CRM114-Status: GOOD (  14.27  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Sep 14, 2020 at 06:33:22PM +0300, Andy Shevchenko wrote:
> On Tue, Aug 18, 2020 at 11:35:30AM +0300, Andy Shevchenko wrote:
> > It's unusual that we have enumeration by class in the middle of the table.
> > It might potentially be problematic in the future if we add another entry
> > after it.
> > 
> > So, move class matching entry to be the last in the ID table.
> 
> Is it good enough?

Yes.  This is in my for-5.10 queue, which just hasn't been pushed out
yet.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
