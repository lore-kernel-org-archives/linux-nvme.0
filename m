Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C4DC27C75
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 17:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8SRt+69rZERIMH5luSM3/A2HTfJLQVNOydoDukUqqaw=; b=H46ubQq0EXk5CPC8BGRO7hq7A2
	iMx4lgN414dmdD2/6kfv8iEwrrBb+cA8vml6Y4kDrB7SSvg7D0H3HPPhaO4Hk4JmrtZMVklSB+jAf
	+xmA6BL/3YsQtyKBV5aTun7eKmkOzePBjLoq85BaF5o2rumz3pKbIOhkNHllUpGwofvkGeJEvJKc8
	p4wmgF9zHgXSpwqT2ezGgMfQiED8LEWlRlC74rfnXSvM0X8/dMqeygkMhta/K1DbrNMiwHce86HIY
	KSniPR9o2t0DfvJiZvEyT1wJSwLp0yJ8xL/1XxeuGBEahnFbqU+5vxqlMgDVealMxoYUL5a1hEoDw
	/FwxOHEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH5Ex-00000009fBG-1Fpp;
	Tue, 11 Jun 2024 17:24:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH5Es-00000009f7f-1Dgp
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jun 2024 17:24:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AAAE868BEB; Tue, 11 Jun 2024 19:24:48 +0200 (CEST)
Date: Tue, 11 Jun 2024 19:24:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, sagi@grimberg.me,
	Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Subject: Re: [PATCH] nvme: fix namespace removal list
Message-ID: <20240611172448.GA13680@lst.de>
References: <20240611152055.2317197-1-kbusch@meta.com> <20240611163955.GA12787@lst.de> <ZmiHvDaI11gu8K4I@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmiHvDaI11gu8K4I@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_102454_549057_B0324BFD 
X-CRM114-Status: GOOD (  22.50  )
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

On Tue, Jun 11, 2024 at 11:22:04AM -0600, Keith Busch wrote:
> > Is this actually valid for a (S)RCU protected list?  If the entry gets
> > added to the new list before the grace period has completed, we could
> > trick a concurrent traversal into following the new list unless I'm
> > mistaken (although chances I'm mistaken on RCU corner cases aren't that
> > low..).
> 
> Good call, you are absolutely right that a sync should happen between
> the del and the add for readers to consistently iterate this list.
> 
> I might be able to weasel out of this though: our namespace list is
> sorted, and this function wants to append everything from this element
> all the way to the end to the "rm_list": a reader should get the same
> result either way, whether if it was torn at this element or the move
> happened without the reader seeing it.
> 
> Now if there was a way to rcu split the list so we don't have to do it
> element by element...

Isn't that exactly what the list_splice helpers do?  We'd just need to
do that exactly once at the cutoff point and not once per namespace.

