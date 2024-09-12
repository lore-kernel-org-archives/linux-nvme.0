Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C6CEEB575
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 09:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oKxKJLQdJ1aMNIh9j7vZeEFKXS2wLNPuTMb/0QwZfi0=; b=gnWGGYNE8Xi4lNrrt5gAHab47Y
	grPuU8zoB4o1wYfskS0x0pPCU79GrFDUwQFWwtKXtaU6GesWj/jCH+yC3oiu3cghgP3I9cx5D3DWg
	OkkpPAzSr6NclX7xxp/qYhqh8gddTAHCjGGrMdeESHvAf7/tTTRfHRQZHepNKtBVP6fiCzWWJiuNH
	sJhdAlRq6fysBKBPhWTiMcsUUybO+u0P9LE+vb90OxMtwsWN0l/pgXOTCNHmMFrIf+Qy9g1zP1NdZ
	PqQBC5r9AD97LHH1Pk/BV7GooCZy9+oF0Mr5yB3rvcNsS2BiuyFBORG4SOd3j3SIsO4G/ICB4FQMr
	q/3RpkPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sogGt-0000000CZ9I-1RH8;
	Thu, 12 Sep 2024 09:37:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sogGr-0000000CZ7S-1LjZ
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 09:37:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4E541227AAF; Thu, 12 Sep 2024 11:37:39 +0200 (CEST)
Date: Thu, 12 Sep 2024 11:37:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/3] nvme-multipath: fixup typo when clearing DISK_LIVE
Message-ID: <20240912093738.GA13465@lst.de>
References: <20240911124610.81615-1-hare@kernel.org> <20240911124610.81615-2-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911124610.81615-2-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_023749_523255_48BA623A 
X-CRM114-Status: GOOD (  12.23  )
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

On Wed, Sep 11, 2024 at 02:46:08PM +0200, Hannes Reinecke wrote:
> NVME_NSHEAD_DISK_LIVE is a flag for 'struct nvme_ns_head', not
> 'struct nvme_ns'.

Can you please add a description on how this was, the affects and
the fixes tag?  Between Sagi and me we've probably asked for this
half a dozen times now.


