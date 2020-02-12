Return-Path: <SRS0=S8v+=4A=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F7DC352A4
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Feb 2020 20:27:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53FEC2465D
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Feb 2020 20:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VkchqkAC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53FEC2465D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NjRi5TR4CzJKZoFLu5WWAPUDzhrUQnEfERwOalohUxE=; b=VkchqkACd0GRoA
	69PFnbW2Nm0YzG3VacDhZu51fe4Rp1e42e7yKTdE510+PozlZNF0yGFLVL1K6vn4FWZVhAZLBwxYy
	cnM0VXXiKeB5mfDXlMUkPQ6cQL0q6PXN0GgcUel/BiIQ4YP1M7T3/kymjbHj9fkFvdY9A+86uHroc
	id2QG8i6gr+UOkl6d7iZDUv4OISVRLwb1aUO8zVMzWSbtKSkcbbNllRmrDb4gsrajfrC+7tjjqKDw
	omFgfwqdjcCTct7LuKcElpZWZLUkbA5bcV6F+iXQYDYoAhJrfDJYJMr7H8BK8BJd9a6EkPYvk36cN
	uYvXK/nW0ZNc2qtvKg+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j1yb4-00007i-KH; Wed, 12 Feb 2020 20:26:58 +0000
Received: from mga04.intel.com ([192.55.52.120])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1yb2-00006x-7w
 for linux-nvme@lists.infradead.org; Wed, 12 Feb 2020 20:26:57 +0000
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Feb 2020 12:26:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,434,1574150400"; d="scan'208";a="281331541"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by FMSMGA003.fm.intel.com with ESMTP; 12 Feb 2020 12:26:48 -0800
Received: from andy by smile with local (Exim 4.93)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1j1yaw-000zxH-8M; Wed, 12 Feb 2020 22:26:50 +0200
Date: Wed, 12 Feb 2020 22:26:50 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v1 1/2] nvme-pci: Use single IRQ vector for old Apple
 models
Message-ID: <20200212202650.GV10400@smile.fi.intel.com>
References: <20200212103220.80680-1-andriy.shevchenko@linux.intel.com>
 <20200212173709.GA5708@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200212173709.GA5708@lst.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200212_122656_293887_D10726D6 
X-CRM114-Status: GOOD (  12.86  )
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
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Leif Liddy <leif.liddy@gmail.com>, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Feb 12, 2020 at 06:37:09PM +0100, Christoph Hellwig wrote:
> On Wed, Feb 12, 2020 at 12:32:18PM +0200, Andy Shevchenko wrote:
> > People reported that old Apple machines are not working properly
> > if the non-first IRQ vector is in use.
> > 
> > Set quirk for that models to limit IRQ to use first vector only.
> > 
> > Based on original patch by GitHub user npx001.
> 
> Shouldn't that be a reported by?  And do we have a real name / email
> address?

If I would know who is behind that...
I'll post a link to this patch to ask people test / tag it.

> The patch itself looks fine.

Thanks for review.

-- 
With Best Regards,
Andy Shevchenko



_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
