Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C53C28CF5
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jan 2022 17:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5H4q/5wuZ/HSUBt98EJVk8mC0gGkByrAcb5hTvcl970=; b=hc/mEFZT+ymlR9EW+DUptX9Yj7
	9t5DWHa7sWf8oarIMu3gXOiak3spClY4s/Kt/b5sxv0FKOPiTq2u3olZeOjIwxF4eW9ZYPiKHlcSp
	NdZc3O2BAWGY+FatmAXTjInIf8xnf7/tfVZmj0BaTLmQeTbKpyLHC2UZ9ljp8DVmX6ZEiuoUggPC0
	mcvx6UkX+CyYijUt+IpTnlHQNVbdpyoDsqoiCgNzcSs4oNC1LoPGUj5i1kDYmfgTZSrdtwhF/PZkR
	3Ejp9hyLkT9ZCJnSScI2D9sN0/u0RoFXA8ecvUDv0HL5GJfhAwt/rWxrtZIZDInqelzRVqeDJCDMN
	hqgAWGag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nCmIO-00D4vb-C4; Wed, 26 Jan 2022 17:41:24 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nCm4C-00CzdS-Dm
 for linux-nvme@lists.infradead.org; Wed, 26 Jan 2022 17:26:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6B0B868AFE; Wed, 26 Jan 2022 18:26:38 +0100 (CET)
Date: Wed, 26 Jan 2022 18:26:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Pankaj Raghav <p.raghav@samsung.com>,
 Pankaj Raghav <pankydev8@gmail.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: Use pci_iomap instead of ioremap
Message-ID: <20220126172638.GA32649@lst.de>
References: <CGME20220121143539eucas1p20202376f83b0b499143c18b1434ff000@eucas1p2.samsung.com>
 <20220121143533.164928-1-p.raghav@samsung.com>
 <20220126163306.GB31892@lst.de>
 <20220126172204.GE1885300@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126172204.GE1885300@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220126_092644_656709_FEC7EF89 
X-CRM114-Status: GOOD (  16.05  )
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

On Wed, Jan 26, 2022 at 09:22:04AM -0800, Keith Busch wrote:
> On Wed, Jan 26, 2022 at 05:33:06PM +0100, Christoph Hellwig wrote:
> > pci_iomap goes with the ioread/iowrite accessors which we absolutely
> > do not want in nvme.
> 
> It looks like the action pci_iomap() uses is based on the
> pci_resource_flags(), and should call the same "ioremap()" function we
> currently use.

Yes.  But the rule is: use ioremap when you use read*/write*, and use
pci_iomap when using ioread/iowrite.  But they should never be mixed.

