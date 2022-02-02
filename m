Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7002C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Feb 2022 07:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UZlT8n0Q/9JsjsHXY61m9hR2dO2jYUs6RYAAyANKPmU=; b=g7FA6cJAH9dbXFWgacFhtZddGf
	fmkpeHugvQelIlD1h7F+9182+ZLjSdxda6SKP/LCGORGkU0HChBRKS3s5VQ9ZBVcKBNrGw0QaksOS
	n2+4f8bheopQWM1TWSlQJrWWtvmf+nhQnkzw3AmSpj3CimcGrcOhR0IDJOqzHWvenF2oMpOEOIVvh
	9JeoAb4K0K7W7T8vteWsBnR18s+KnoFxP8RX4HbsRXVvshXJzmvnmndNy6NkQa0D5Z6EXEO/pyIAC
	KEkzmhZLvqs5OuaHWid4oYjZwATL/5ocTBiW1S9w+NGtw0u+KLFpf+QpIaIB4SNwOT/7E84deSHqh
	GGhiABdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFATt-00EU7R-Ld; Wed, 02 Feb 2022 07:55:09 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFATr-00EU6W-4p
 for linux-nvme@lists.infradead.org; Wed, 02 Feb 2022 07:55:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 40B9367373; Wed,  2 Feb 2022 08:55:03 +0100 (CET)
Date: Wed, 2 Feb 2022 08:55:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
 Rafael Wysocki <rafael.j.wysocki@intel.com>,
 Vidya Sagar <vidyas@nvidia.com>
Subject: Re: [PATCH] nvme/pci: default to simple suspend
Message-ID: <20220202075502.GA18474@lst.de>
References: <20220201165006.3074615-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201165006.3074615-1-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220201_235507_367559_DC79A4D7 
X-CRM114-Status: GOOD (  15.22  )
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

On Tue, Feb 01, 2022 at 08:50:06AM -0800, Keith Busch wrote:
> There is no complete set of attributes a driver can check to know if
> nvme power management is the correct thing to do in a runtime suspend
> situation. Every attempt so far to optimize idle power consumption and
> resume latency for a particular platform just leads to regressions
> elsewhere.
> 
> Default to the simple shutdown since it is the historically safest
> option, and provide a user parameter to override it if the user knows
> it's safe to use for their platform.

Sigh.  The platforms really should be asking for a explicit D3cold if
they need one..

