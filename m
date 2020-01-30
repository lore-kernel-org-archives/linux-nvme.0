Return-Path: <SRS0=3CeD=3T=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF088C2D0DB
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jan 2020 18:27:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2E8F20661
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jan 2020 18:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LeLH0MwM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E8F20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7aoiniYu7SJ2zIlc/F/c5TYQ5YBEw+vkvhz+WwIH5Kg=; b=LeLH0MwMQ4tBbt
	hu9Ei5DdnGcgZsFRA7igHDdUorkB99bl1Qq/4turmmzfKc5lLjGqLV0XcG3VEVpabzEj4MAs/u/SD
	oNUsKByrYYIGxdQQevklUruEwNmpH5f4Zb/yjD7tOLJqM0aCr5LK7SpXKNyKNmRy+DD/FtCmWpxdj
	51hgFf0BEQeC/eM0ZWb4ot+kroCwGaw5sIHx3GssjYp8heCNSz5lCxFZ2QKEQ8xt3otcGDfa0bUBA
	ppFg+x9XJqDR0znDCT+BUOsnltWrxtR7sZaLmvCUK9Vm2dJZayvYEmDpnLlqLFgJs1VW/cs2ttOsq
	QqlVGBOZ2t8+k+K6xOzQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ixEWt-00047G-Jw; Thu, 30 Jan 2020 18:27:03 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1ixEWs-00046I-FQ; Thu, 30 Jan 2020 18:27:02 +0000
Date: Thu, 30 Jan 2020 10:27:02 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v2 1/1] nvme: clear io tags when freeing tagset
Message-ID: <20200130182702.GA7002@infradead.org>
References: <20200123201947.4482-1-edmund.nadolski@intel.com>
 <20200123201947.4482-2-edmund.nadolski@intel.com>
 <20200130145335.GA8412@infradead.org>
 <20200130174732.GA7915@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200130174732.GA7915@redsun51.ssa.fujisawa.hgst.com>
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
Cc: Christoph Hellwig <hch@infradead.org>,
 Edmund Nadolski <edmund.nadolski@intel.com>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Jan 31, 2020 at 02:47:32AM +0900, Keith Busch wrote:
> On Thu, Jan 30, 2020 at 06:53:35AM -0800, Christoph Hellwig wrote:
> > +static inline struct blk_mq_tags *nvme_queue_tagset(struct nvme_queue *nvmeq)
> > +{
> > +	if (!nvmeq->qid)
> > +		return nvmeq->dev->admin_tagset.tags[0];
> > +	return nvmeq->dev->tagset.tags[nvmeq->qid - 1];
> > +}
> 
> It's been this way for so long, I thought we cached the address of the
> tags in the nvmeq using it to avoid this more complex lookip, so I told
> Ed not do the above. But the original commit doing this was to remove
> relying on a specific hctx to reach the tags, so it's nothing to do with
> any observed performance change ... And this makes struct nvme_queue
> smaller too, so all the better.

Also I just noticed in rdma, tcp and loop we actually already have this
helper and no tags pointer.  And it might have been my code originally.
I'll post a formal patch soon.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
