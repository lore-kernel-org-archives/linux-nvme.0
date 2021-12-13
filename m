Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B46FC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Dec 2021 08:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jCRvBv1UAMx+cg7fZy2ZOMjQ7HD9TRv2iKD/EHIQgP0=; b=h8/E3QxlSB5adickcJHKqMdnGV
	tcSTLIxxdB2LItr7J1m2uKJTtmXF6Uzxu7udo+SdZzpY7ZOQxjgdeWVDRJmKqmjfNOJnOg4tCBv3/
	A1TkCMA28R49v3cTvKbv7N1pvg6rIL0ExPF5JPUS3mIJxxhH1Np/V3q32T/zN1kMz727zl4ihsrqB
	NHuUaRM4BcvP06rxwoBsrZSUoU/tgFfLGHa833nonPzdSqmB7xwRTqVccTbrjuNeeMv5rRpfesClZ
	DjXEwC/sldoU+1gvyI4z8tkzuKGE7kKsmNx6Se+U1XP/01pp3CdIAe0M3DYdkdxz+ORprGDLmA6pM
	Q8ShBjJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mwgRc-008Fct-Dk; Mon, 13 Dec 2021 08:12:24 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwgRZ-008Fba-Hn
 for linux-nvme@lists.infradead.org; Mon, 13 Dec 2021 08:12:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 12BAD68BFE; Mon, 13 Dec 2021 09:12:18 +0100 (CET)
Date: Mon, 13 Dec 2021 09:12:17 +0100
From: "hch@lst.de" <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Alan Adamson <alan.adamson@oracle.com>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/1] nvme: Add verbose error logging
Message-ID: <20211213081217.GA21297@lst.de>
References: <20211209173213.14249-1-alan.adamson@oracle.com>
 <20211209173213.14249-2-alan.adamson@oracle.com>
 <fc8f5858-3bea-675b-003f-b59059bd5e5a@nvidia.com>
 <yq1mtl8qxc4.fsf@ca-mkp.ca.oracle.com>
 <20211210165648.GB3856533@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210165648.GB3856533@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211213_001221_772947_1DCAD7E7 
X-CRM114-Status: GOOD (  13.07  )
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

On Fri, Dec 10, 2021 at 08:56:48AM -0800, Keith Busch wrote:
> I'm not sure having it be a new Kconfig option is a good idea since it
> requires a recompile to enable/disable. Could this be toggled with a
> static_key instead so we may disable/enable verbose logging at runtime?

We need to think about module size.  NVMe is not only used in big
enterprise setups but also in deeply embedded scenarious these days.

I'm also not really convince of the usefulness (but also not strictly
againt it), but if we support it it needs to be conditional.

