Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B97B7FA373D
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Oct 2022 08:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=If+BR3beW/bUPHayhPWU6Zv0DihuqS9c5fJ43WEt/YQ=; b=UzQeeH72ruchgBqHrOKU7FtJ86
	N3d88DEOKATMmHNS33vMuxXRYdmNEczRFY6M2C1An8VN7hiIrlncxF8OyejgmbBMutuMcN6QmYZ5u
	1BTR63Mn3PU8fJLnr8YLVpEm6bIp5ijoUhb4VhX7+RZR7O3js6gWacY+mtTFguchmX5yaDNSaOVTV
	ra9T7IJs4RZP91xTT9jJEBEpn9PNgMRFj5dPX9nLEQT5iGFzJmFdqqCrmksqjon8sV7tShoEfE8ez
	/tJ8VQb03F+JzA3AWp6SQCYTlxj7uvu4k3eybYawE1GeNpYPlvfk+f6KElnYOjaowO1iBo23g7XFD
	DZM5nH3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1op3HG-00E0Hg-Qo; Sun, 30 Oct 2022 08:02:42 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1op3HD-00E0EO-K1
	for linux-nvme@lists.infradead.org; Sun, 30 Oct 2022 08:02:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4C53268AA6; Sun, 30 Oct 2022 09:02:36 +0100 (CET)
Date: Sun, 30 Oct 2022 09:02:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Joel Granados <j.granados@samsung.com>, sagi@grimberg.me, hch@lst.de,
	linux-nvme@lists.infradead.org, gost.dev@samsung.com,
	joshi.k@samsung.com, javier.gonz@samsung.com, p.raghav@samsung.com
Subject: Re: [RFC 1/3] nvme: Return -ENOMEM when kzalloc fails
Message-ID: <20221030080236.GG4214@lst.de>
References: <20221027155724.1161670-1-j.granados@samsung.com> <CGME20221027160108eucas1p223383fc27ba0a27a38f7b768c562a1ed@eucas1p2.samsung.com> <20221027155724.1161670-2-j.granados@samsung.com> <Y1qxUXuqDHYi+LO+@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1qxUXuqDHYi+LO+@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221030_010239_828362_636A4807 
X-CRM114-Status: GOOD (  13.71  )
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

On Thu, Oct 27, 2022 at 10:26:57AM -0600, Keith Busch wrote:
> On Thu, Oct 27, 2022 at 05:57:22PM +0200, Joel Granados wrote:
> > In nvme_init_non_mdts_limits function we were returning 0 when kzalloc
> > failed. This patch corrects this behavior and return -ENOMEM
> > Fixes: 5befc7c26e5a ("nvme: implement non-mdts command limits")
> 
> I'm pretty sure I had this returning 0 on purpose. We can proceed
> without this optional structure.

Well, we could.  But I don't think it really is a good idea.  Why I think
failing major resource allocation (e.g. HMB) and just continuing limited,
doing that for these tiny kmallocs that the kernel basically never fails
tends to create a lot of confusion and hard to test code pathes.

