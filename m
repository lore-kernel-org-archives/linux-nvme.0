Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37340C43334
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jul 2022 09:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tMvH8Q+jpfya7kWNqzxT/Z5oPcAHgRJscaW3+dhZA6E=; b=qVI0svKGprFGM51RrdxoKYqEoQ
	7apAA3xTYvE4/dmH+RHVJWlAD0ue1HeO7vlRyO4fDZOKejIpeG8kauo7fCFL/egbzBf2wEGGGr+kC
	Zl5puWXDMukKW8dwYI0SzPYrN9cdXBmWmPs7OZb1/R4bnhKLBGNyVFwsUGcn74zOUCH4I56HDZh/3
	f65fsqsHUNdzDoxeLg4VKuD8JI1ynggtBjOGKmXEvr+urqenqFUnyZCNitsrfs396C+Jlx9j7k56y
	SRaqOyhXh3LsIfIiAZ1ACumy+pHUoMvxqQ+LH+E+fqfz5TV+sgzi7eACQHLJazKHLlCQ5bbiwembn
	o1VdWP3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEpFh-001y2A-8g; Fri, 22 Jul 2022 09:47:21 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEpFf-001y1X-Qv; Fri, 22 Jul 2022 09:47:19 +0000
Date: Fri, 22 Jul 2022 02:47:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: consider also host_iface when checking ip options
Message-ID: <YtpyJ8GHH9CcbLVK@infradead.org>
References: <20220721174414.28294-1-dwagner@suse.de>
 <YtosZB0mt7qTG3eG@infradead.org>
 <20220722085839.cttrthaw5ctp5xgu@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722085839.cttrthaw5ctp5xgu@carbon>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Jul 22, 2022 at 10:58:39AM +0200, Daniel Wagner wrote:
> On Thu, Jul 21, 2022 at 09:49:40PM -0700, Christoph Hellwig wrote:
> > Thanks,
> > 
> > applied to nvme-5.20.
> 
> Argh, forgot to test the non host_iface case. We need to test for a null
> host_iface pointer. Do want a follow up on this patch or do you drop it?

Please send an incremental patch that I can fold in.

