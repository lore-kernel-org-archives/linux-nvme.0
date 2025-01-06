Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F54E77188
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2025 07:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4rl9KHySj3ZDolZtbZyRvzfd+noFgeNcCTBe6j083DM=; b=y8UzDCFAyUlWAx3D0EDLKzx7rh
	JU/IlWuJmZZbWf0dCRGeGj4WQEiSkwX2ZQAV20+5KvmOgP3LTkAc3UbRkXX/Y0rpqVM627oquk6pL
	I6V1oRQ/0NIlkzJ/WI1Nus92AAZxNDhMUvI0HGkWGTsnebjSu7kVlY1ZWLQJIqmbMUnt7AheIRQ/U
	TYX1UAY3GA+O8BkP3lnI0wVuGZl3W+SZNuXKrDFinW6j41Mrzvc5jqnxRSoCMtNXPcbnSdRvcijls
	2UjMUBJSq7l09iGWNuzssQy3hsLFOBNznznWYduUR0owhcvWYamPoMv+6cLYUZC0BmB4fkxU9lEAp
	3QATQqjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUhRZ-00000000ORz-45OI;
	Mon, 06 Jan 2025 07:22:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUhQZ-00000000OFZ-3ftS
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jan 2025 07:21:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3E30868BFE; Mon,  6 Jan 2025 08:21:17 +0100 (CET)
Date: Mon, 6 Jan 2025 08:21:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Niklas Cassel <cassel@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Oliver Sang <oliver.sang@intel.com>,
	oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
	Damien Le Moal <dlemoal@kernel.org>, linux-btrfs@vger.kernel.org,
	linux-aio@kvack.org
Subject: Re: [linus:master] [block]  e70c301fae: stress-ng.aiol.ops_per_sec
 49.6% regression
Message-ID: <20250106072116.GD16723@lst.de>
References: <202412122112.ca47bcec-lkp@intel.com> <20241213143224.GA16111@lst.de> <20241217045527.GA16091@lst.de> <Z2EgW8/WNfzZ28mn@xsang-OptiPlex-9020> <20241217065614.GA19113@lst.de> <Z3ZhNYHKZPMpv8Cz@ryzen> <20250103064925.GB27984@lst.de> <Z3epOlVGDBqj72xC@ryzen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3epOlVGDBqj72xC@ryzen>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250105_232132_059594_78C41306 
X-CRM114-Status: GOOD (  12.19  )
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

On Fri, Jan 03, 2025 at 10:09:14AM +0100, Niklas Cassel wrote:
> One thing that came to mind.
> Some distros (e.g. Fedora and openSUSE) ship with an udev rule that sets
> the I/O scheduler to BFQ for single-queue HDDs.
> 
> It could very well be the I/O scheduler that reorders.
> 
> Oliver, which I/O scheduler are you using?
> $ cat /sys/block/sdb/queue/scheduler 
> none mq-deadline kyber [bfq]

I tried cfq as well and there is no reordering with our without various
file systems in the mix.  I've also tried forcing the rotational
attribute on and off just for an extra variation.


