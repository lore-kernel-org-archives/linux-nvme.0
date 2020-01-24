Return-Path: <SRS0=TgIa=3N=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD35C2D0DB
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jan 2020 18:55:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97D6C2075D
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jan 2020 18:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pIXexam1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eb141/gt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D6C2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z/kGNOfvV1eqMSiszsqtjN6V4KH8U8nkOHIHnW0cUe8=; b=pIXexam1X8GFam
	fEtDwBPaa0Pq4yGEJ4tsgNaWxBQ26V6+s/QZtVVfIc4Ix1u989XAoT0L+aDCNQtcxDhvxnGF28ZqN
	Zyb2A36DpKJcOJUBpQ0jocWdHEzOLInLUt54db0eJLXWswWRvv8sKMtzlBpC3n5F7Tacfnmtsl8+F
	/MRDVDkuKMCxRrvLKfaAPOHXO9PXx6ML5P6D4m6ffdAdUlnQEbBIcY0tRwtaQq3rYLhMxzyIKdoGH
	xSZ38WbQYxmIjPgoHMEXp/qrJZKdIZMZknCGIvz5CeYb+jwumLZhmrvmP6tVD26nrtFu4HpK1goCB
	HsGoborgXq/Km4lIyv5Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iv47a-0005c1-2r; Fri, 24 Jan 2020 18:55:58 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iv47W-0005bY-Rr
 for linux-nvme@lists.infradead.org; Fri, 24 Jan 2020 18:55:55 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BBD142071E;
 Fri, 24 Jan 2020 18:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579892154;
 bh=VF/P1XLyPeJ9789Simk5B+Mim1fdd2St/+v4QH4gK9c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Eb141/gtVZLzgGBVjX1CHO46c0DULQwJIjpKw/BHcr7x0Oxvfs8LNz6bv5NKzYuXN
 p3n2Oj8ecnpG8LFU6HC+p6+PqhR3DjvGhWN6d6QtyPn4jTXwFt5W2v/7BzUwztauEd
 kJYZp1OhsdPVPSQn8GWapgU0bk54+g23r0UnjL78=
Date: Sat, 25 Jan 2020 03:55:47 +0900
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvmet: fix dsm failure when payload does not match sgl
 descriptor
Message-ID: <20200124185547.GC19243@redsun51.ssa.fujisawa.hgst.com>
References: <20200124173942.2744-1-sagi@grimberg.me>
 <20200124182855.GA19243@redsun51.ssa.fujisawa.hgst.com>
 <bf79cb37-41c1-b604-3e3a-64fbe51ee105@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bf79cb37-41c1-b604-3e3a-64fbe51ee105@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200124_105554_920209_A538453F 
X-CRM114-Status: GOOD (  12.87  )
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
Cc: Dakshaja Uppalapati <dakshaja@chelsio.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Jan 24, 2020 at 10:35:18AM -0800, Sagi Grimberg wrote:
> 
> > > The host is allowed to pass the controller an sgl describing a buffer
> > > that is larger than the dsm payload itself, allow it when executing
> > > dsm.
> > > 
> > > Reported-by: Dakshaja Uppalapati <dakshaja@chelsio.com>
> > > Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> > 
> > Thanks, applied for 5.6.
> 
> Thanks Keith, this needs to be also in 5.5 as there the regression
> was introduced, maybe add a tag on the commit?

Oh, is there an appropriate fixes tag? At this late point, though, I think
we should let stable pick it up in the 5.6 merge. Maybe we can sneak it
in if there's an rc8.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
