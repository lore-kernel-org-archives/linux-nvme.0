Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 770C3C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jan 2022 16:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=csYv2eGYMgv6cwXUVwW/KfngP5S08FScbtL0GURosE8=; b=ax4UP3tFZT2NxiS8zQV57yvCBn
	JQ9uMaxYhZdcuaXHsA2qWegI+sWptapsMaXTlUrhMQdKKhFEdpz/Z4VP44JQkwMMsCg59UkOWlIkg
	o7/n0tVj37tWdXWcm740rqXLsJyZGuBt/3rOQgJf7lZWUgT72NWJjT6lAb7VVPbjgYFJPV/Mrx8yu
	uiC5swQM37i2v+zuYADWz8W0yFC8yjHNcx/lq5QxfVsblPGWqtoALvAuOrMsLMUOJV5f7lnLKCVJV
	I4AZBth0R4UR4stiyxcWbzRBQx/1huJt8kNWl2i3zL2Hj4hbWPB82fnafJChEv+DW6hGd5Uit5/xf
	yepB4a0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nD7DO-00GM1L-8U; Thu, 27 Jan 2022 16:01:38 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nD7DL-00GM0Y-MN
 for linux-nvme@lists.infradead.org; Thu, 27 Jan 2022 16:01:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id E436168AA6; Thu, 27 Jan 2022 17:01:29 +0100 (CET)
Date: Thu, 27 Jan 2022 17:01:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Pankaj Raghav <pankydev8@gmail.com>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: Use pci_iomap instead of ioremap
Message-ID: <20220127160129.GA21421@lst.de>
References: <CGME20220121143539eucas1p20202376f83b0b499143c18b1434ff000@eucas1p2.samsung.com>
 <20220121143533.164928-1-p.raghav@samsung.com>
 <20220126163306.GB31892@lst.de> <20220127130541.qxb6vk5lhoaa4ivl@quentin>
 <20220127144508.GA20196@lst.de>
 <af495f19-b060-42bb-f22c-430dd79b98c0@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af495f19-b060-42bb-f22c-430dd79b98c0@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220127_080135_907909_EBBA8713 
X-CRM114-Status: GOOD (  12.92  )
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

On Thu, Jan 27, 2022 at 09:26:28PM +0530, Pankaj Raghav wrote:
> `ioremap` has a comment to prefer pci_iomap if the area we are trying 
> to map is a PCI BAR. Does it makes sense then to have a comment in 
> the nvme pci driver as to why ioremap is preferred over pci_iomap?

I don't think that comment is correct.  pci_iomap is not a replacement
for ioremap, but an interface that helps drivers that need to
transparently deal with MMIO and Port I/O - something that is mostly
of historic interest these days.

