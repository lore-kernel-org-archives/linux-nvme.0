Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BC9C3A5A7
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 08:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zdN++vmfUljaSyfmU+/EF0xsROA5eNG1bp/xmIUUip0=; b=jAkT0rXX5wV0G5EfujCkb+xZI5
	6e5chpaJMKI2hloj8TcwdUdlR7NpAuVyGu9wdhZLrDDkIQcdyzdOeVYmLiQwPDIugTz/ZWQ86fpPL
	AFLUR0VZ+mwHhtNSTyaPE1JdLh7Yn0Ux+iiPAKVbQjE4OF/jml2o/Ov21XWsA0WINPYEyCZLq6TU7
	fNJ4eGDwd5c5UOsA26Lc6g3e+RGoi08tRpPySL/mQdicY/zwN1QXyHGp8L9WVIYzPl4ElWMgodOj4
	NybCM8x7IJsFyISJRrQ/gKheA9Yt0MiCPl4eXIkVs02mZm4BFY6+NibCu8t5OSMFw0KExVbgE9zqB
	lGaWaNbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2TJi-004ppy-VA; Tue, 06 Dec 2022 08:28:42 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2TJR-004pcz-AB
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 08:28:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9443568C4E; Tue,  6 Dec 2022 09:28:21 +0100 (CET)
Date: Tue, 6 Dec 2022 09:28:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Joel Granados <j.granados@samsung.com>, hch@lst.de,
	chaitanyak@nvidia.com, sagi@grimberg.me, p.raghav@samsung.com,
	javier.gonz@samsung.com, joshi.k@samsung.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v5 1/1] nvme : Add ctrl id to allowed passthru commands
Message-ID: <20221206082821.GA8917@lst.de>
References: <20221205142746.1026912-1-j.granados@samsung.com> <CGME20221205143143eucas1p2c4044196a8ff0cb9b563f99d2a5183ce@eucas1p2.samsung.com> <20221205142746.1026912-2-j.granados@samsung.com> <Y44PtQ1uWtbBhx4X@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y44PtQ1uWtbBhx4X@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_002825_529356_3D727FE9 
X-CRM114-Status: GOOD (  10.20  )
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

On Mon, Dec 05, 2022 at 03:35:17PM +0000, Keith Busch wrote:
> I initially thought just open the entire nvme_identify_controller
> opcode, but this looks good to me.

But that's not an opcode.  The opcode is identify, and then everything
else is multiplexed by the CNS value, even if the names of the
different CNS values sound like there might be another sub grouping.

