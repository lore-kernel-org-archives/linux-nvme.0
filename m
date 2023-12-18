Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE708C35274
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Dec 2023 14:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/jjBsrYRAddTbQkFQfTX1XQ2G9N0xboaukV6pMBgTX0=; b=NdSV2WhlslNpQxUxts5yDZvo3h
	uIgt5lAibuvA+RaE15dZBfkxjQaZJpqcFs/q+B3hra3oHFX5i5UO0vRoIVGB450krL0u0ctRSK7CB
	WNv9j/7KFEjXYORZOSbOwy0BgmwdjNdnR9PhvYNrUMqdzGXr1agsFP4DtIO2Fqjxl5iRca97PQ7Dh
	zwcQQRsX1sGFfLf9e1Xqx+dXoGWTrRgIqwEk8nRU0+8pCbUExRKbtKU8cks143i9xphNZ7bFucfeF
	UbMMo5E3yWflESQEdCOBYxJkn3FqkxNZwbcEkEx0u5y59u2q1UrGdkaD4U3ufivQPIX4Ist1UdwhR
	TzPESWxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFEgH-00B3OL-20;
	Mon, 18 Dec 2023 14:33:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFEgE-00B3No-22
	for linux-nvme@lists.infradead.org;
	Mon, 18 Dec 2023 14:33:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DE8E168AFE; Mon, 18 Dec 2023 15:33:09 +0100 (CET)
Date: Mon, 18 Dec 2023 15:33:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 3/5] block: remove support for the host aware zone model
Message-ID: <20231218143309.GA16810@lst.de>
References: <20231217165359.604246-1-hch@lst.de> <20231217165359.604246-4-hch@lst.de> <09f1adfe-90b5-445c-b7f6-ae4fc7a9666a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09f1adfe-90b5-445c-b7f6-ae4fc7a9666a@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_063314_815070_BF3DD312 
X-CRM114-Status: GOOD (  13.97  )
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

On Mon, Dec 18, 2023 at 06:48:43PM +0900, Damien Le Moal wrote:
> > -	if (devip->zmodel == BLK_ZONED_HA)
> > -		arr[4] = 1 << 4;	/* zoned field = 01b */
> 
> I think we should keep everything related to HA in scsi debug as that is an easy
> way to test the block layer and scsi. no ?

Yes.

