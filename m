Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40397C54FB3
	for <linux-nvme@archiver.kernel.org>; Mon, 26 May 2025 07:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W4ltFSnYtcmQM2s5dP37H/ZtZvSDduZDl5oBWnTsNCM=; b=Umcr6Z8nXUGHKrfMJeBKhqTEen
	frf8tqaPos6CybHtfunSg3cY+cWWk/xK8n18w2BnbplIfdrHcw+hChR7olto+Km2yYccTNMytKUDS
	AW0k2tREQQVl7ESaRxppkj40ILGExZWk9rGn6nzpI8vpBUCbwOvjnIoP9exy9EiPx4zRi/55ybY8y
	IIRWKUe5xXGA+XHSqt394d/YL+A1PmokFQ6Tp9hotmcJ+TQpqjdpjnpr3ykyWWdPudM3AeR5YdxAM
	I4+IpAFJxM3+iDuWZBZvI0R+W9wpno8JczcR78Z4irfRIujYOVjcUYwtFCQIlG6hD0Ajs0TaVvLmH
	fOeljDlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJRzk-00000008FxM-33qO;
	Mon, 26 May 2025 07:11:36 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJRxZ-00000008Fog-1f2i;
	Mon, 26 May 2025 07:09:21 +0000
Date: Mon, 26 May 2025 00:09:21 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Avinash M N <Avinash.M.N@sandisk.com>,
	Jeffrey Lien <Jeff.Lien@sandisk.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Rahul Jain <Rahul.Jain@sandisk.com>
Subject: Re: NVMe CLI Invalid PRP Entry Status Failures
Message-ID: <aDQToX9eVtNF39G6@infradead.org>
References: <MW3PR16MB3897F0E659B34877C4D5197CF391A@MW3PR16MB3897.namprd16.prod.outlook.com>
 <MW3PR16MB38975C2057D1EF440FBD60B0F390A@MW3PR16MB3897.namprd16.prod.outlook.com>
 <aCX3offAfe1k0_KE@kbusch-mbp>
 <LV3PR16MB606775F391112B2DADF64463B590A@LV3PR16MB6067.namprd16.prod.outlook.com>
 <aCcwqhakl4JhrI2o@kbusch-mbp>
 <LV3PR16MB6067E928D739DCB65F31FE46B593A@LV3PR16MB6067.namprd16.prod.outlook.com>
 <aCdOtYYT8f3lL8zJ@kbusch-mbp>
 <F3C3A106-E0AF-4598-9E80-6F10A457F202@sandisk.com>
 <aDHXCFeQSlQjjnmU@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDHXCFeQSlQjjnmU@kbusch-mbp>
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

On Sat, May 24, 2025 at 08:26:17AM -0600, Keith Busch wrote:
> > There is no issue if nvme-cli sends a transfer length of up to 128K.
> > Anything more than 128K is failed as ENINVAL. I guess this is coming
> > from the limitation of BIO_MAX_VECS as 256. Since this was working on
> > older kernels, did anything change in this regard?
> 
> Well, it's passing a virtually contiguous address, so if we assume your
> page size is 4k, 256 vectors would allow up to 1MB without a problem.
> 
> But the NVMe pci driver has its own limit of 128 vectors, so 512k is the
> largest you can safely go before you need to increase the size of pages
> via hugetlbfs.
> 
> But you say you're doing something smaller than 512k, and your device's
> MDTS is bigger than that, so what else is limiting here your transfer
> size here? Do you have some udev rule that is reducing the size of your
> max sectors value?
> 
> Check the value of /sys/block/nvmeXnY/queue/max_sectors_kb
> 
> See if it matches /sys/block/nvmeXnY/queue/max_hw_sectors_kb

bio_split_rw_at doesn't look at max_sectors unless that is passed
in as the argument.

It would be good to just throw in debug printks to see which splitting
decision in bio_split_rw_at triggers, including checking the exact
condition in bvec_split_segs.


