Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E09FDFD8FCB
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 15:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fh/BRgK+T7eC9T2ehAY0izrSqKZdt+/PlceBGBix9PI=; b=JcMd7Kcd2wWiW8hPpdn7vca717
	8beuPwgrdlL45g0HrWURWBAJxGCEf/czJiCIKEWdJhADc5Tgkn+UPmi2SHZ3KPvFgJcpjE2DHPcXh
	L5N/azT5GciRQEKOiWPrzfDKK4EYF8iereORzZGoe+Q8XHGK7LGRSWwvuBIr+ZLXra2TRHb0LXXfs
	uOG4iwm2BCoB7Jho2OHi4kQF0OnW6B+4jasXF43T4TbjKqOzgy7AR97KpQ3S6xzYn/dmrTCMbDMvh
	zhcyMAu6cyBk0kMXGnilz5oJvficloM9Hbbhv13p6yLroWK6bdsDaH2eGeIvMVYYsqN+mWq+b149U
	HECMDR1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvdMT-00000006WBW-3uS6;
	Thu, 26 Feb 2026 15:33:09 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvdMQ-00000006WB5-3W79
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 15:33:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7775068C4E; Thu, 26 Feb 2026 16:32:58 +0100 (CET)
Date: Thu, 26 Feb 2026 16:32:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, wagi@monom.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH V2 1/2] block: move bio queue-transition flag fixups
 into blk_steal_bios()
Message-ID: <20260226153258.GA31398@lst.de>
References: <20260226031243.87200-1-kch@nvidia.com> <20260226031243.87200-2-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226031243.87200-2-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_073307_043550_D7A2AE24 
X-CRM114-Status: GOOD (  12.37  )
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

On Wed, Feb 25, 2026 at 07:12:42PM -0800, Chaitanya Kulkarni wrote:
> blk_steal_bios() transfers bios from a request to a bio_list when the
> request is requeued to a different queue. The NVMe multipath failover
> path (nvme_failover_req) currently open-codes clearing of REQ_POLLED,
> bi_cookie, and REQ_NOWAIT on each bio before calling blk_steal_bios().
> 
> Move these fixups into blk_steal_bios() itself so that any caller
> automatically gets correct flag state when bios cross queue boundaries.
> Simplify nvme_failover_req() accordingly.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


