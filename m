Return-Path: <SRS0=IF7s=7D=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC7EC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 21 May 2020 15:42:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B7B4207D8
	for <linux-nvme@archiver.kernel.org>; Thu, 21 May 2020 15:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JC7N6jmU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjZJbxG0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B7B4207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4Xn8nXZZa1k54pAbahsN3F+fdYBEshLfQvlI3+/l2cM=; b=JC7N6jmUhWZ2R1
	vC02MwG/eEM+lQExkMgXAXO5i3fa8UcnDpDp2pzu5km2c5feGYLoc3xamPWgL7YWmPP54o/b3LYZE
	hB7N9vRr2ZCDXfLeuDXAfS7FS3xrOleBaoZ2g3mbvEIBviqflrV5eGJp1XPnHexBbm5HZGBmrAJFw
	Ixe3Ce7lOYwg7pmphwezwqsuwPWbFZ+SeqLGl88jjmS9l7U5uFAqwrFVHg/P5ju2/jE1pfxs8cswO
	Da4Byq7BxXovAKJy63dFQrVRlbkmot5vJQVApUZITpT9ITHUQ9P9Kep8tQLz8BMVclXLhE8y7jgt4
	YQ3ybV+FHKf2EeeRyFuQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jbnKX-0000ge-KW; Thu, 21 May 2020 15:41:57 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbnKU-0000cW-Ml
 for linux-nvme@lists.infradead.org; Thu, 21 May 2020 15:41:56 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4EBAB207D8;
 Thu, 21 May 2020 15:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590075713;
 bh=3GwKu64PQ8nTAFNb7XTaapllDt5wm8Hyy47W1HZksKo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YjZJbxG0Plt+zCUuPoazv2HxdOEVtQY/qwasOcdR56hhyMu0K/kxe8InHx/Q81BEj
 5lFWAD4D5uVW8C1vd6QGJEZHDwTGF6QExdVSFfcQbLLpF674JsH48bLr0kzGSfzcg9
 BQaervkqGX9YvwoizUOPOOgahjDUDMhF+LKZ1tYA=
Date: Thu, 21 May 2020 08:41:51 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: set dma alignment to qword
Message-ID: <20200521154151.GB3269657@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200521022253.3268324-1-kbusch@kernel.org>
 <77425d7c-e8b8-b012-b1b3-c083b0b3af3c@grimberg.me>
 <20200521152820.GA3269657@dhcp-10-100-145-180.wdl.wdc.com>
 <20200521152929.GA18535@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200521152929.GA18535@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200521_084154_810245_2B3A7861 
X-CRM114-Status: GOOD (  15.45  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, May 21, 2020 at 05:29:29PM +0200, Christoph Hellwig wrote:
> On Thu, May 21, 2020 at 08:28:20AM -0700, Keith Busch wrote:
> > On Wed, May 20, 2020 at 11:05:51PM -0700, Sagi Grimberg wrote:
> > > 
> > > > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > > > index 805d289e6cd9..ba860efd250d 100644
> > > > --- a/drivers/nvme/host/core.c
> > > > +++ b/drivers/nvme/host/core.c
> > > > @@ -2283,6 +2283,7 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
> > > >   		blk_queue_max_segments(q, min_t(u32, max_segments, USHRT_MAX));
> > > >   	}
> > > >   	blk_queue_virt_boundary(q, ctrl->page_size - 1);
> > > > +	blk_queue_dma_alignment(q, 7);
> > > 
> > > Shouldn't be an issue for rdma/tcp, think that it should also be OK for
> > > FC as well but not sure.
> > 
> > Okay, just to be safe, I'll make this a nvme_ctrl_ops callback.
> 
> No callbacks please, especially without users.  If FC needs an override
> we should just add a field to struct nvme_ctrl.

Well, pci would be a user. But if you're okay with having the driver
default to this alignment, would you consider taking this original patch,
or do you want confirmation from FC developers on whether or not this
is safe?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
