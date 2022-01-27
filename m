Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 957EDC4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jan 2022 14:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nufSrwL15MrvUCkMicuxtYvOnzdhi1HhIq1mow0XcDw=; b=hawRmbnqL9d1YNyMv9VKiea3Jj
	9z3DvNTxQrk4ZFkP6Q88+7xDjVme7qERMS7nHp/NET+QMfSL8QCkLxK+/fT12deFleMYQer/e52lF
	dDSHm3B7EH1VjzrGYkcVEnnSRs1u104y1DTU8qGldFLCbdpoPvSAGltZpmhhxExu61cyFgKyb47oA
	kSX92urYTtya8zgRq+SEvsW8SAa+9UXbuUatK6p+RYtxdvDjeDgvHlwwSoa/wodwFExZs8WnGUovq
	B9EjUopVNZNWP64wsy+N/Yj6v7NsdstwXNF3xHrQzI7J/9K8Sk+FeHO5ru1wzl01Ydd5otL0Ve8FJ
	fLCLjSKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nD61U-00G7Am-Vz; Thu, 27 Jan 2022 14:45:17 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nD61S-00G79p-A3
 for linux-nvme@lists.infradead.org; Thu, 27 Jan 2022 14:45:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6B09568AA6; Thu, 27 Jan 2022 15:45:09 +0100 (CET)
Date: Thu, 27 Jan 2022 15:45:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Pankaj Raghav <pankydev8@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Pankaj Raghav <p.raghav@samsung.com>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: Use pci_iomap instead of ioremap
Message-ID: <20220127144508.GA20196@lst.de>
References: <CGME20220121143539eucas1p20202376f83b0b499143c18b1434ff000@eucas1p2.samsung.com>
 <20220121143533.164928-1-p.raghav@samsung.com>
 <20220126163306.GB31892@lst.de> <20220127130541.qxb6vk5lhoaa4ivl@quentin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127130541.qxb6vk5lhoaa4ivl@quentin>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220127_064514_529295_82B6584C 
X-CRM114-Status: GOOD (  15.09  )
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

On Thu, Jan 27, 2022 at 06:35:41PM +0530, Pankaj Raghav wrote:
> On Wed, Jan 26, 2022 at 05:33:06PM +0100, Christoph Hellwig wrote:
> > pci_iomap goes with the ioread/iowrite accessors which we absolutely
> > do not want in nvme.
> Is it because of ioread/iowrite has a conditional check everytime we do
> a read/write with IO_COND? Or is there any other reason?

Yes, ioread* and iowrite* are more expensive.  And nvme doesn't support
port I/O anyway so there is no point.

