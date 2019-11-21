Return-Path: <SRS0=O3HW=ZN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C2AC432C3
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Nov 2019 15:45:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4F5C206B6
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Nov 2019 15:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZHOsWTDX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1o6GU7a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4F5C206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o5tzv9CZq9uHgNxirONo+Ad6iRu1Qs5LO/8ayUI7oho=; b=ZHOsWTDX0MYny7
	GdlAFejykDZl5cAkLFOfCrahgxH/OCzp+88h3PHnmtBGR9UP8DKGK3Y92j6q0wd8HfM2tN5fZwGmA
	tiIEIDJpwY1Zw9/vCV62JS8iEA0xonCyltK8Q1rmfPWfPRtG20/KFwWHs0tkPs+yGVURUNv0wwyGm
	WILZnrH9VREENyJSDTWdY5ImvF4lqKOrYA4oNclOzkx06uNJ7v7FOpEbrbV/13Lz1kYth6KByDDsy
	nrqjUGEYwHQ6zYERN4SL8bFJDgn7jnQheVicL1gXsry6ERwsk0Svmd/MfwjXrb2YlJkvWWc+qnu3r
	X4zlklT68wnxGv6CUIgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iXoeI-0005k6-1U; Thu, 21 Nov 2019 15:45:38 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iXoeF-0005jX-Lv
 for linux-nvme@lists.infradead.org; Thu, 21 Nov 2019 15:45:36 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E31A52068E;
 Thu, 21 Nov 2019 15:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1574351134;
 bh=SkbZx1j9Lynw1nQMhhbfOW4JlWM8JMvQF0Shajv7Eg8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=X1o6GU7apf2xbaEKtr0RkO6faiwPGhvj1I27jCgk7UHvK66o1Uds5al/BSIjaQBsu
 oOGf7K/OfJJx4PjoNqHIaMgyAT9yB8aw096iGVLu8bg4tLhFsvxg8R/3HuvWc2oyTu
 +qa4Y9jiwOm9W4a1/MRabxSolBDoO95Zppg2TPG4=
Date: Fri, 22 Nov 2019 00:45:31 +0900
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH V3 0/2] nvme-pci: check CQ after batch submission for
 Microsoft device
Message-ID: <20191121154531.GB17852@redsun51.ssa.fujisawa.hgst.com>
References: <20191114025917.24634-1-ming.lei@redhat.com>
 <20191121031154.GJ24548@ming.t460p> <20191121061431.GA22886@lst.de>
 <20191121074643.GB4755@ming.t460p>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191121074643.GB4755@ming.t460p>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191121_074535_741131_945C0B90 
X-CRM114-Status: GOOD (  11.75  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Long Li <longli@microsoft.com>,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Nadolski Edmund <edmund.nadolski@intel.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Nov 21, 2019 at 03:46:43PM +0800, Ming Lei wrote:
> On Thu, Nov 21, 2019 at 07:14:31AM +0100, Christoph Hellwig wrote:
> > On Thu, Nov 21, 2019 at 11:11:54AM +0800, Ming Lei wrote:
> > > Hi Guys,
> > > 
> > > Ping...
> > 
> > I think everyone has told you that it is an invasive horrible hack
> > that papers of the underlying problem(s).  I'm not sure what more
> > we can do here.
> 
> The problem is that the NVMe driver applies aggressive interrupt
> coalescing clearly, that can be addressed exactly by this approach.

Can this default coalescing setting be turned off with a "set feature"
command?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
