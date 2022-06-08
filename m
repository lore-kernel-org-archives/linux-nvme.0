Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD0FCC43334
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jun 2022 07:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TU/PaQO6x0+EfJTk5MS/tGZi64TMVwDyuVmsnlwu6V4=; b=KrGu/P/JNUjIiGn3XPAGFMBwo8
	F5HbcgZ3IpBQUSqWpQaiWGSVMLjWUSopcDc0t8yalad+B+ZbaINbbHG2eb86jB2ALCqB8hdXex48f
	F2qXUQDv9lffSJMX5tiZagLKuY9+3K6iJ4HZRHdLJTggLaBFc0g4jowDspML1hoQDeP58asVdUXrJ
	Gq3ZYHltK9nLUVvrWNBnFJC9MjzuVOcU2bz1lIqaZXWid+jpmYK2q6HI/BbmJrjhn6DRbY8CP4ZcS
	ID/Bd/T4U0OLitWVjA7p8NbQhM5Y7ude3n0DxeJ/fNaAR6lyoTcRjEOQUfojrZiZgDv/Ot9y+z2Ra
	vxRa4WrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyqR7-00BkBS-2M; Wed, 08 Jun 2022 07:49:05 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyqR4-00Bk8o-Ie
	for linux-nvme@lists.infradead.org; Wed, 08 Jun 2022 07:49:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 87A7B68AA6; Wed,  8 Jun 2022 09:48:56 +0200 (CEST)
Date: Wed, 8 Jun 2022 09:48:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Klaus Jensen <its@irrelevant.dk>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Message-ID: <20220608074856.GA13027@lst.de>
References: <YlB1E/p1uqpl3HiN@bombadil.infradead.org> <20220411050533.GB13927@lst.de> <20220411055455.GA14480@lst.de> <C85067CB-3909-4B62-A86D-467827EBF96E@oracle.com> <20220420073641.GA6859@lst.de> <26796ED5-859F-4844-B1D1-7C2FF5126E40@oracle.com> <Yp5z8b4ec5tFt9qk@kbusch-mbp.dhcp.thefacebook.com> <84C629F5-BCDC-45FE-88F0-83DCDA06B93E@oracle.com> <Yp54fw/FRQ6KhP0V@kbusch-mbp.dhcp.thefacebook.com> <1FC6870F-6BCA-4C9B-8F90-C14469A542AE@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1FC6870F-6BCA-4C9B-8F90-C14469A542AE@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220608_004902_802104_D3E589CE 
X-CRM114-Status: GOOD (  12.70  )
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

On Mon, Jun 06, 2022 at 11:11:22PM +0000, Alan Adamson wrote:
> nvme_global_check_duplicate_ids() fails when the id’s are the same.  They are kinda
> shared namespaces and we can set nmic on the loop target, but the pcie target is
> unaware of it being shared.

Yeah, we'd have to change cmic and nmic reporting for the underlying
device (which doesn't have to be PCIe) exported through the target when
the loop driver is used.

