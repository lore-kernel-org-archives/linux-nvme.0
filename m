Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6DDC433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jul 2022 13:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kDKZ8YvaL2KXsRQV7l1v/UiH8lBy6+iuboXXrI/FfmY=; b=ccNde+KkFTZhkzk4McyICnvLAR
	oP1suPRVB5/Q/+g4DwDTCrxlym2yVeagt0SAU13sZZi8BKMpbgh687jxBv1k/W1W3xUt3IlQZ+tK6
	f02OEq1YF5fPTWTAFoRbxoBgpQQf5FuHF8y994Hq/8qcfpffTLXMy4h9Y5v6gaPKeGWB6VmI+aOK5
	MxUWbAVlWsSpeJK5/eVj6UzWtxiAOS5XnqvMfm5TJB4hR0jz+qZzw0qzznp8b9uRdZh4rY8na6PrO
	DTDCPHF55CZ4+vsKO9Qcpo51Rt7eZaoXfLR4o69xrkXIGDn394t3CZWA16pHBiwvqVVyqyg6Yl4OT
	H3DpnScQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8LiI-0090iN-53; Mon, 04 Jul 2022 13:02:06 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8LiE-0090fH-Q3
	for linux-nvme@lists.infradead.org; Mon, 04 Jul 2022 13:02:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 35AC368AA6; Mon,  4 Jul 2022 15:01:53 +0200 (CEST)
Date: Mon, 4 Jul 2022 15:01:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	"dm-devel@redhat.com" <dm-devel@redhat.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 01/17] block: remove a superflous ifdef in blkdev.h
Message-ID: <20220704130153.GA23752@lst.de>
References: <20220704124500.155247-1-hch@lst.de> <20220704124500.155247-2-hch@lst.de> <PH0PR04MB741671715E7F16D5335002509BBE9@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB741671715E7F16D5335002509BBE9@PH0PR04MB7416.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220704_060203_031602_F337819E 
X-CRM114-Status: GOOD (  11.66  )
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

On Mon, Jul 04, 2022 at 12:58:40PM +0000, Johannes Thumshirn wrote:
> > -#ifdef CONFIG_BLK_DEV_ZONED
> > -
> >  /* Helper to convert BLK_ZONE_ZONE_XXX to its string format XXX */
> >  const char *blk_zone_cond_str(enum blk_zone_cond zone_cond);
> >  
> 
> Won't this break tracing in null_blk, which uses blk_zone_cond_str()?

How could removing an ifdef and exposing a prototype unconditionally
in a header break tracing?

