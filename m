Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38723C54E64
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 06:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bB2CI9Hl4hXS1LHnxKg5x0dbsZtwYsDW9poMe+lwcDk=; b=VRSXsovz506hl48PNeuHOGHIzP
	VdWS/bUudcqllA4gmbxbtwkQ3zkCV7+6uRmYpWytSIY+tC5Pk9edfNbtGHmoQpLNkvvSogIru64AD
	D9QQWXNzXj8Ygh+aiYOImvU/gSkQGfLGweSr6eEHdGr31xmIAzOCN4Q+04XibIoiwuz9hMXsIWu+n
	Doo1eh6B+Rs10cW2jsB0Cqvyh/8nNyj2ly0MZrk5at4N+6s0WsKOWftSy8V0L1FA2vmt7H3Aznk3u
	PsLdbOTS8pvn6ArnXBSlC3Xfg9saRc/KXV6CB+f2pUQA+QDc5I2x3vw3NNiTAJHonxNVyLcpvC6go
	aOghDGhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpiru-0000000Ce5q-3D0H;
	Thu, 28 Mar 2024 06:04:06 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpirr-0000000Ce4P-2Dtw
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 06:04:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9CEE668B05; Thu, 28 Mar 2024 07:03:57 +0100 (CET)
Date: Thu, 28 Mar 2024 07:03:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v3 09/30] block: Pre-allocate zone write plugs
Message-ID: <20240328060357.GA16819@lst.de>
References: <20240328004409.594888-1-dlemoal@kernel.org> <20240328004409.594888-10-dlemoal@kernel.org> <20240328043016.GA13701@lst.de> <714d0cbc-be4d-4aa9-b200-73c6caaa1d18@kernel.org> <20240328054652.GA16237@lst.de> <7d8f3ec4-c416-445f-92db-7d2b60726821@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d8f3ec4-c416-445f-92db-7d2b60726821@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_230404_084929_57538EF6 
X-CRM114-Status: GOOD (  14.08  )
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

On Thu, Mar 28, 2024 at 03:02:54PM +0900, Damien Le Moal wrote:
> But that is the problem: "checking the zone number again" means referencing the
> plug struct again from the lookup context while the last ref drop context is
> freeing the plug. That race can be lost by the lookup context and lead to
> referencing freed memory. So your solution would be OK for pre-allocated plugs
> only.

Not if it is done in the Rcu critical section.

> For kmalloc-ed() plugs, we still need the rcu grace period for free. So we
> can only optimize for the pre-allocated plugs...

Yes, bt it can use kfree_rcu which doesn't need the rcu_head in the
zwplug.

