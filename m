Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC8AE7719C
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jan 2025 09:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HM59L0LqLr8BY+Ah3bEi1w8vlkuX/M02gI8v5b6K9Xc=; b=QOu8syZo5/zQ9zcIDVbh/VKFj5
	ApNnvhBpjfcC/ZxFwJeP9+jngtgRtfbFGki0HzEjSnAP+RBRPDEpYUrR3JIlAm9mEkkG42G52fLLM
	InB8mIbhXPfpi52KZOurbG61qUzJttdcDPmOJ4/gtigEFsFR0o+2RMzVdvinbRI17z1iekpX2N+Ww
	DqGL8WF+thMnSeT5MD0TxMAYvMJi+SctClGS7RxwUs6f+ek/VC9v7OxVh9GvSDk+cz4uKQso/eYVV
	4MjeKo1yVWeC8jwlkRNgcOgiKOfye5MgtrBAuDABhZcsfIb+K7vgmAi1lgt2e/7J5s4bZ1gHqkAYh
	D4moRN/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWBAj-0000000EfOb-17H6;
	Fri, 10 Jan 2025 09:19:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWBAd-0000000EfMY-1quw
	for linux-nvme@lists.infradead.org;
	Fri, 10 Jan 2025 09:19:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2C6A268BFE; Fri, 10 Jan 2025 10:19:00 +0100 (CET)
Date: Fri, 10 Jan 2025 10:18:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>, Ming Lei <ming.lei@redhat.com>,
	Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, nbd@other.debian.org,
	linux-scsi@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 05/11] block: add a store_limit operations for sysfs
 entries
Message-ID: <20250110091859.GA8373@lst.de>
References: <20250110054726.1499538-1-hch@lst.de> <20250110054726.1499538-6-hch@lst.de> <e7177a33-aebd-4828-87b0-f790b4fb1306@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7177a33-aebd-4828-87b0-f790b4fb1306@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_011911_623019_8EAACA98 
X-CRM114-Status: GOOD (  15.23  )
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

On Fri, Jan 10, 2025 at 09:15:09AM +0000, John Garry wrote:
>> +	int (*store_limit)(struct gendisk *disk, const char *page,
>
> I don't really see why this returns an int, while the queue features 
> callback methods return a ssize_t. I know that the res variable in 
> queue_attr_store() gets mixed with an int for updating the queue limits, 
> but I don't see that as a reason to use int here.

The normal store methods have the annoying calling convention where
they return the parsed string length on success.  ->store_limits uses
the simpler and harder to get wrong convention of returning 0 on
success.


