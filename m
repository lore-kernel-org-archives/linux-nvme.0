Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87262C001DC
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jul 2023 13:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7lrmCC0HwvEPSQq4RuysImkZk6ogosfB94MGK7eCfJM=; b=EC/cXzmYLB5AMQmcbaqXARLNJ0
	5T6DUAq9eyaJ17hRU0JQFBM1qFtknVORuW7Ca8msslfZlRYQDujeZG3EmB/xUNKgZgk0WF86v/GLK
	EFLWwgXYtjeyl2sSZyuKAkys7+nfnQyKd1UHpqzsTcRhl3XV2r/lCgKyxUg+ynv32M8yYSRfEzZoF
	qkBZ9S5WPSfkbf+V/IYLGKGL+tT+vx8h6DWEfkCUd8oRIB/mvkIJ4YBrHF1sBfYfDpDqaStKwsgpO
	nv+KZ6DYq8F0gp67w8rZZQVtt/tKBRW6rv7h0SS4lbOVlG9AVQsvPLPcbYq/FuK+eHTXGTefZrdtQ
	5znTTL0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOeLO-00AVNj-2e;
	Wed, 26 Jul 2023 13:14:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOeLM-00AVLp-1o
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jul 2023 13:14:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3365968AFE; Wed, 26 Jul 2023 15:14:09 +0200 (CEST)
Date: Wed, 26 Jul 2023 15:14:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Pratyush Yadav <ptyadav@amazon.de>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: do not set the NUMA node of device if it has
 none
Message-ID: <20230726131408.GA15909@lst.de>
References: <20230725110622.129361-1-ptyadav@amazon.de> <ZL/dphk/MJMRskX8@kbusch-mbp.dhcp.thefacebook.com> <50a125da-95c8-3b9b-543a-016c165c745d@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50a125da-95c8-3b9b-543a-016c165c745d@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230726_061420_765900_BA3CB22D 
X-CRM114-Status: GOOD (  19.46  )
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

On Wed, Jul 26, 2023 at 10:58:36AM +0300, Sagi Grimberg wrote:
>>> For example, AWS EC2's i3.16xlarge instance does not expose NUMA
>>> information for the NVMe devices. This means all NVMe devices have
>>> NUMA_NO_NODE by default. Without this patch, random 4k read performance
>>> measured via fio on CPUs from node 1 (around 165k IOPS) is almost 50%
>>> less than CPUs from node 0 (around 315k IOPS). With this patch, CPUs on
>>> both nodes get similar performance (around 315k IOPS).
>>
>> irqbalance doesn't work with this driver though: the interrupts are
>> managed by the kernel. Is there some other reason to explain the perf
>> difference?
>
> Maybe its because the numa_node goes to the tagset which allocates
> stuff based on that numa-node ?

Yeah, the only explanation I could come up with is that without this
the allocations gets spread, and that somehow helps.  All of this
is a little obscure, but so is the NVMe practice of setting the node id
to first_memory_node, which no other driver does.  I'd really like to
understand what's going on here first.  After that this patch probably
is the right thing, I'd just like to understand why.

