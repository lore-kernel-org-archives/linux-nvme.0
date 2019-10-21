Return-Path: <SRS0=hg6U=YO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40513CA9EAB
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Oct 2019 03:44:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1257A21928
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Oct 2019 03:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iAaxWz8p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1257A21928
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KbgWQRIJLmsapM2yYWzp5cdmPWlsLvP4Cag+wOZ2B8o=; b=iAaxWz8pGxTJHy
	ZhjOq1zWizn4RPZ6JPCgwIEtJoYIpg9gExrL8NMHnbDF7+IPvmLwSBA2hqMv2yMIoEUU9HuuJ6Ps/
	7ZkMAA6GSc7DWxhLANvuuCw1LruuS9/o+doYAfmGJZBcesrW2dU9+mKRxgnltjXtEALTzbqMdY7L/
	UWT/qfZJglaKahgQ9Ki8BFz/ar9aVJZWwUsHifaDY3r1srb9bIsSOCNESypdvNg4CRChtIn7OI/5X
	vy1ujY93+3cCOpoh3/rDGKrFQnIPcDjK7tAFzU8lcc0i9PfYHPtNXUgCUQlsF2hWVLwL+9YCOLNpY
	71iowol5QHCC23rM8pdg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iMOcI-0006gZ-SL; Mon, 21 Oct 2019 03:44:22 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iMOcG-0006fQ-Kx
 for linux-nvme@lists.infradead.org; Mon, 21 Oct 2019 03:44:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 25A0568BE1; Mon, 21 Oct 2019 05:44:15 +0200 (CEST)
Date: Mon, 21 Oct 2019 05:44:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH 1/2 v2] nvme: Cleanup and rename nvme_block_nr()
Message-ID: <20191021034414.GA11888@lst.de>
References: <20191021034004.11063-1-damien.lemoal@wdc.com>
 <20191021034004.11063-2-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191021034004.11063-2-damien.lemoal@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191020_204420_837870_E3B9BC7C 
X-CRM114-Status: UNSURE (   8.09  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Oct 21, 2019 at 12:40:03PM +0900, Damien Le Moal wrote:
> Rename nvme_block_nr() to nvme_sect_to_lba() and use SECTOR_SHIFT
> instead of its hard coded value 9. Also add a comment to decribe this
> helper.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
