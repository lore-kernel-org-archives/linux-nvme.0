Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE235C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Apr 2022 15:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4jE3CEGM8v2tVNgg4hENzjHqkqHZ7c2EqAe6vujh7Pc=; b=I8ILiRoqJvqFv2s2xtg3HCE+rs
	kXzz6WeoulcAIsL+t5RDwADnl9fL/Qw0WYH1XfwNK9i5vi91TiSkZXw/w2hTwOmlQnmND4ApeDe5Q
	d1fKe6MVKudAp7FbTjjkPentT8+OHa7yrXEI3aIp8O1zLXCy0flYQcgSN3dNsps01g2/Un6QgM1Cn
	VCOW3uFZ8ed2yxrHsm0mma+3l8NThIc4NC26hTclai3rA5dEam3rpdHKqWCYWmE8Q5re2H6gdvvL8
	lGICu4YxdE9ZlLEpCFznS04XqG5a8UlI+759PKPZ8u1XWc/7RfmA1v8OtrRZTiJ3aRp4wV4s4iweL
	BoDRzGJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nefGg-001fQL-MN; Wed, 13 Apr 2022 15:50:54 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nefGd-001fPa-SL
 for linux-nvme@lists.infradead.org; Wed, 13 Apr 2022 15:50:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 22FD468BEB; Wed, 13 Apr 2022 17:50:48 +0200 (CEST)
Date: Wed, 13 Apr 2022 17:50:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Klaus Jensen <its@irrelevant.dk>
Cc: Christoph Hellwig <hch@lst.de>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Luis Chamberlain <mcgrof@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 3/3] nvme-pci: disable namespace identifiers for Qemu
 controllers
Message-ID: <20220413155047.GA28740@lst.de>
References: <20220413044905.376785-1-hch@lst.de>
 <20220413044905.376785-4-hch@lst.de> <YlZ8j70shRKv/tif@x1-carbon>
 <YlaMjz7SoctkLzYo@apples> <20220413153432.GA27146@lst.de>
 <YlbxCdgPaVUykcqx@apples>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlbxCdgPaVUykcqx@apples>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220413_085052_099764_2FD29234 
X-CRM114-Status: GOOD (  13.72  )
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

On Wed, Apr 13, 2022 at 05:49:29PM +0200, Klaus Jensen wrote:
> This means that the 'use-intel-id' compatibility parameter may cause a
> 5.2 nvme device to present itself with the Intel PCI vendor/device id,
> either because the user explicitly set it, or because the machine is
> launched using a pre-5.2 machine type (i.e. `-machine pc-q35-5.1`),
> which you would normally do if you want launch an existing VM on a new
> version of QEMU.

But if it presents an old machine it also shouldn't support a new
identify call, right?

