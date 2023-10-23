Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7143CDB474
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Oct 2023 05:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+X64syAvrTNIFLlthj9yTwL70YwqGj+KjZYJu6EluWs=; b=BJVu8DFz1mzqCir8lVkFkN+zCt
	gicl+Z21jbE5tHJiphU7vyIu0qtrLvwbIIHwoSgFGQuCjdbY5nUZ6/jmn6fRH3DX3VmcotiT0w00M
	eNr1rL8gZYL6WEBgsvEJXshGf6/HYNNC7cKWnSYoZQPpGToA+XdoSp2amuM2Aag0n2thCXBsRZIzE
	4aHYo4paxJ3hk/yHg1Hnj+lZjZfkP3W90Ujb/fDrWh//cX17+YOr32WfMAh+FsZDqNY4efGw9yUv9
	cUhbCNZXEpL5Q0fIkHzsla2laen6UZvzn75wisFjEKs+fDjwJ7yOmIsFFwtsjbPkrqedLcA3nPeAC
	+m4JWMtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qunkL-006UGm-2E;
	Mon, 23 Oct 2023 05:45:01 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qunkJ-006UG4-0A
	for linux-nvme@lists.infradead.org;
	Mon, 23 Oct 2023 05:45:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5205168AA6; Mon, 23 Oct 2023 07:44:56 +0200 (CEST)
Date: Mon, 23 Oct 2023 07:44:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	gost.dev@samsung.com, vincentfu@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] nvme: remove unprivileged passthrough support
Message-ID: <20231023054456.GB11272@lst.de>
References: <CGME20231016061151epcas5p1a0e18162b362ffbea754157e99f88995@epcas5p1.samsung.com> <20231016060519.231880-1-joshi.k@samsung.com> <ZS2D4VixIYfMQMwg@kbusch-mbp.dhcp.thefacebook.com> <ZTBNfDzxD3D8loMm@kbusch-mbp> <20231019050411.GA14044@lst.de> <ZTKN7f7kzydfiwb2@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTKN7f7kzydfiwb2@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231022_224459_238636_E9C6A564 
X-CRM114-Status: GOOD (  14.26  )
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

On Fri, Oct 20, 2023 at 08:25:49AM -0600, Keith Busch wrote:
> Jens repeated what he told me offline on this thread here, and dropped
> the pull request that contained this patch:
> 
>   https://lists.infradead.org/pipermail/linux-nvme/2023-October/042684.html
> 
> BTW, don't you still need someone with root access to change the
> permissions on the device handle in order for an unpriveledged user to
> reach this hole? It's not open access by default, you still have to
> opt-in.

Yes, you need someone with root access to change the device node
persmissions.  But we allowed that under the assumption it is safe
to do so, which it turns out it is not.

