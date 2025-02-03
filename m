Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDFDDC02193
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Feb 2025 06:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GimvSIbf7+ZmiHyp5wVIojv9PT4u3FtvM6Er3EqVvvk=; b=EhxvAjN4M8YdWE+OKx3V+LMKw/
	oT7dK0KtSEUOq39z0a3mP5IWVzm0+/LAfy3snYzlJ1ENYWeRFEaTlL7ST9pR4jDjaXyjU56YpZ1ey
	R2vyNr0OMeVBbek8IpFrF/l9HH07+47kiasNtetEZIpRScIrY1iwjWIahgqrfKRbPHvPLsnXaB+VJ
	9I1tNf7lri0v3yWW53YYOWqaC/P+AuJBL70lUwW3vwm1k9wHjhddQY0e/NHSzyQuy9iDzbBM+kxSX
	B5fpKPHCL7as115xHTu2uAgi3B0frUS0cUnsAXQzfjb81gS3tC/t8Wapzr4V8Y5Ia3AcYpXWfFvH+
	6ztTA6rQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1teq9a-0000000EfI5-3iop;
	Mon, 03 Feb 2025 06:41:54 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1teq9Y-0000000EfHj-2ra8
	for linux-nvme@lists.infradead.org;
	Mon, 03 Feb 2025 06:41:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8656267373; Mon,  3 Feb 2025 07:41:46 +0100 (CET)
Date: Mon, 3 Feb 2025 07:41:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	pmenzel@molgen.mpg.de
Subject: Re: [RFC PATCH] nvme: replace lazy sgl warn with informational
 message
Message-ID: <20250203064146.GB16864@lst.de>
References: <20250130175131.3613423-1-kbusch@meta.com> <20250131074828.GA16628@lst.de> <676bf767-44fc-4930-905c-292360d9c8b5@grimberg.me> <Z50OZsVUvKQHvorh@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z50OZsVUvKQHvorh@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250202_224152_867652_67C1DF25 
X-CRM114-Status: GOOD (  17.88  )
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

On Fri, Jan 31, 2025 at 10:54:46AM -0700, Keith Busch wrote:
> I thought this patch could remove the message because it tells you
> upfront what you'll get if you use the passthrough interface. The
> existing message tells you what you're getting once you actually try to
> use it, so they felt a bit redundant.
> 
> > I agree, I'd keep the warn_once messages.
> 
> Okay. The problem with the message is that it's a new warn, but nothing
> has really changed as far as what the driver supports, so having it at
> the "warn" level caused some alarm. Any concern if it's an info_once
> instead? I just want to avoid repeat explanations on its implications;
> I've experienced several offlist discussions about it already.

Well, we do want to warn, right?  To make sure all the current
administratative uses of passthrough switch the sysfs interfaces we
added over time.

