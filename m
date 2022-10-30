Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472CEC38A02
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Oct 2022 09:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j2EQ9gIFWiY3mf3Sd1JKje9JAkKrlqcbGefqYBTugCQ=; b=nT6eCESkcidwBGten+fIW/2VH6
	teOUqtjI9xq31UDcALIVLfg/Gr9wFu7uOoTUXBAmWEU/ePPtOnA5jDzyuWhq/VyF/DD9nEMkMcfVy
	o7PMuQgoblV+gGUgvejxdFq2IFNx3gDUNUnBtxeznLlL9N8OabMw6vG1OgeR8X5THcNoSACPPEFNn
	kqoMXfBqejHyPVyniADDjtV87ok7OfB5X6fH3d0smTDIJjCIKtRjffQ6yejsvOlaVoehtn1xWLB8A
	YFYIQLtDYZezc27BIlkHEkeOVw4MVU2hzX3thfQZAPUgNnuneubC5OLN4OO5Njcy8i8e07Z391pmT
	piNBDT+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1op4Ru-00EiM0-4O; Sun, 30 Oct 2022 09:17:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1op4Rr-00EiJW-Py
	for linux-nvme@lists.infradead.org; Sun, 30 Oct 2022 09:17:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4C24C68AA6; Sun, 30 Oct 2022 10:17:39 +0100 (CET)
Date: Sun, 30 Oct 2022 10:17:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Chao Leng <lengchao@huawei.com>,
	Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 02/17] nvme-pci: refactor the tagset handling in
 nvme_reset_work
Message-ID: <20221030091739.GA5643@lst.de>
References: <20221025144020.260458-1-hch@lst.de> <20221025144020.260458-3-hch@lst.de> <cafdc008-9d07-758a-bb66-1ca62b0baa50@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cafdc008-9d07-758a-bb66-1ca62b0baa50@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221030_021744_007767_68CC4B9E 
X-CRM114-Status: GOOD (  16.49  )
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

On Wed, Oct 26, 2022 at 03:46:09PM +0300, Sagi Grimberg wrote:
> This is clearer, but what I think would be even cleaner, is if we simply
> move the whole first time to a different probe_work and treat it like it
> is instead of relying on resources existence as a state indicators
> (tagset/admin_q). The shared portion can move to helpers.

I started playing with that a bit on my flight home this week.
I think the right thing is to do away with the scheduled work for probe
entirely and set the PROBE_PREFER_ASYNCHRONOUS flag in the driver, and
that should also really help with probe error handling.  But that's
another fairly big set of changes over this already quite big series
so I'd prefer to do it separately.

