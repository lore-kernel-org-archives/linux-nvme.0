Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229AFC433E9
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 18:18:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA7FE64E70
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 18:18:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA7FE64E70
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZbiuoDm0c7iOcjCWCKKrjLg2+nhq5TSlkOeH5PHLq6o=; b=bpbLZvh76ac2Ld5TP01Gr4Two
	IikOY8JIICeOhEyme5rewXx2ZX42cOc3/zueY3kB0KocOP7yqVAX4T+BYWp+1hnZ82CNxNyrIsaOD
	e/3CjupPtJhJUjM+0XXKWGX3mLUyuflQppiav1W2UCTziBoQAdQYLLM0pHKvECYsWtZhyIzW7nfnz
	i1j7pjEdaKFm6C3WuTdaD/ZrWKP3msPMDpZqNqhbTUNJsO+gt6cK1V+ySP8eIMVGSqUCczMYBfgON
	YsRcY/PEdhwHXJu0PTk4NwlbDfuG0RUrpK5bSvhh9zM+ihRuo4qG+jtS9STDnNWWYSifYpXAljMHX
	NFmdCa5zA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5Brt-0000af-UM; Thu, 28 Jan 2021 18:18:09 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5Brq-0000Zp-Tz
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 18:18:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4681768AFE; Thu, 28 Jan 2021 19:18:05 +0100 (CET)
Date: Thu, 28 Jan 2021 19:18:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 3/3] Adding device_dma_parameters->offset_preserve_mask
 to NVMe driver.
Message-ID: <20210128181804.GC11790@lst.de>
References: <20210128003829.1892018-1-jxgao@google.com>
 <20210128003829.1892018-4-jxgao@google.com>
 <0550ca25-1389-ffc2-e738-8127ceb1712f@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0550ca25-1389-ffc2-e738-8127ceb1712f@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_131807_078621_20EE7259 
X-CRM114-Status: GOOD (  14.92  )
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
Cc: axboe@fb.com, heikki.krogerus@linux.intel.com, sagi@grimberg.me,
 saravanak@google.com, konrad.wilk@oracle.com, marcorr@google.com,
 gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com,
 linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com,
 kbusch@kernel.org, bgolaszewski@baylibre.com, iommu@lists.linux-foundation.org,
 jroedel@suse.de, linux-nvme@lists.infradead.org, erdemaktas@google.com,
 dan.j.williams@intel.com, Jianxiong Gao <jxgao@google.com>, hch@lst.de,
 m.szyprowski@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jan 28, 2021 at 06:00:58PM +0000, Robin Murphy wrote:
> If it were possible for this to fail, you might leak the DMA mapping here. 
> However if dev->dma_parms somehow disappeared since a dozen lines above 
> then I think you've got far bigger problems anyway.
>
> That said, do you really need to keep toggling this back and forth all the 
> time? Even if the device does make other mappings elsewhere that don't 
> necessarily need the same strict alignment, would it be significantly 
> harmful just to set it once at probe and leave it in place anyway?

Yes, we should kept it set all the time.  While some NVMe devices have
the optional to use SGLs that do not have this limitation, I have
absolutely no sympathy for anyone running NVMe with swiotlb as that
means their system imposes an addressing limitation.  We need to make
sure it does not corrupt data, but we're not going to make any effort
to optimize for such a degenerated setup.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
