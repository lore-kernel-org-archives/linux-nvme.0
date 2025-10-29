Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9181DCCF9EB
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Oct 2025 09:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TdX//1i3AGFErU/TEDddgO93eB4Q2X3yYIWZbw0tqrc=; b=Xd+bwZEG9u7k7AYZX7d2RrgYyi
	9oWfV3B/2WAP2B8ADIBBGaZNmk3NlB2hWnVFgkcSniMGurXmOHgVUUYSAefJ3LQtAgcHj0z8OyvCI
	cSM5UCPqWvr6/SBS1FewvQLyP9THgwVeYy/AsTFn0wdnIFMwo4TJKvF/pOys+QViFMt3kdT1EEAGU
	dKlO+FL8Gq5mLAKYSgBImaC1Dx559/x+HgaeGfnYrflceT8/nTQyWjGwYrVyzRz9wPT/FzGXf2RUT
	4at6m8ppodW7X4LwGQ8j9JyGMltv3/RXXEps7OCgwaKTAmINBTzS+v7oI6bkUHzlSWzO56XN4dc22
	bOigyhwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE2ff-00000000XCx-3fJG;
	Wed, 29 Oct 2025 09:40:47 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE2fe-00000000XBn-00rN
	for linux-nvme@lists.infradead.org;
	Wed, 29 Oct 2025 09:40:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 35803227A8E; Wed, 29 Oct 2025 10:40:42 +0100 (CET)
Date: Wed, 29 Oct 2025 10:40:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hare@suse.de, kbusch@kernel.org,
	hch@lst.de, sagi@grimberg.me, dwagner@suse.de, axboe@kernel.dk,
	gjoyce@ibm.com
Subject: Re: [RFC PATCHv3 2/6] nvme-multipath: add support for adaptive I/O
 policy
Message-ID: <20251029094040.GC1066@lst.de>
References: <20251027092949.961287-1-nilay@linux.ibm.com> <20251027092949.961287-3-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027092949.961287-3-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251029_024046_178709_BE7FA1B6 
X-CRM114-Status: GOOD (  12.36  )
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

On Mon, Oct 27, 2025 at 02:59:36PM +0530, Nilay Shroff wrote:
> This commit introduces a new I/O policy named "adaptive". Users can
> configure it by writing "adaptive" to "/sys/class/nvme-subsystem/nvme-
> subsystemX/iopolicy"
> 
> The adaptive policy dynamically distributes I/O based on measured
> completion latency. The main idea is to calculate latency for each path,
> derive a weight, and then proportionally forward I/O according to those
> weights.

This really sounds like a lot of overhead, and really smells of all
that horrible old-school FC SAN thinking we've been carefully trying
to avoid in nvme.

What's the point here?

