Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62565E77188
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2025 08:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T83KRiEu82veThnEerB9H/dDoRCbB//01QfLLyiGYbo=; b=MJz3xen9l4owKDZQetXtazgi+i
	k0XLgZC4J8v+TJogvCewcHXmbizS2dW+AlIA9vYOYnRGHkTmYcRYbjV4dubRDSEKCbMnIoksqfjJF
	kkmUh4Hxymltv7XNZsFLiLrT/NX6hq3sLH4t5ChR3HDmuYE74MIoGzrzHz7dOxvy6DCDgEW14+ONL
	G6kjxl6S2ftIFj18ymYlpACLOTSuTl/xGw/kFL+4zX085ynwLQ3jOgl5MG6Y/9wqITjGA48pWKY/I
	4KDfy5h9N2DTHuyx+WbdZXOLOz8Abz3MCHX+Ogr3w9eYALMUkOryxDwjJUssO6wC/UxpsvmybvzFV
	Afe5VMgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUiQD-00000000V6t-07as;
	Mon, 06 Jan 2025 08:25:13 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUiQB-00000000V5g-0beL
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jan 2025 08:25:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 55A3868CFE; Mon,  6 Jan 2025 09:25:01 +0100 (CET)
Date: Mon, 6 Jan 2025 09:25:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Ming Lei <ming.lei@redhat.com>, Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH 1/3] block: Fix sysfs queue freeze and limits lock order
Message-ID: <20250106082500.GA18408@lst.de>
References: <20250104132522.247376-1-dlemoal@kernel.org> <20250104132522.247376-2-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250104132522.247376-2-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_002511_321203_A80981DC 
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

Did you find an exploit on my development laptop to find what I'm
working on? :)

I've got the same patch sitting here locally together with a few other
cleanups from before the holidays.  But the problem I rant into and
why I didn't finish it, is that is that the lock order doesn't work
for __blk_mq_update_nr_hw_queues which freezes at a very high level
and then does a queue limits update.  Now the whole changing of the
poll flag there look a bit questionable anyway and I was going to
look into how we could fix this, probably by retiring that flag either
just for blk-mq devices where the information can be derived from the
tagset or entirely.  I'll try to get to it ASAP.


