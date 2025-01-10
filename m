Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A26E77188
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jan 2025 09:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mx3R+4Y4b07XTyiJw93ocRKEAlHKvHhzgMc1cCd71qs=; b=AcxxtPUaNAi5k/uIDBOCbtDRTY
	L55vh3Wo6emw1UKCfzz5JMrVUiG+VekB0SJNAJ9i3J/GLWIVX0TIaJdKId6t2poomKAT47eAb3g1g
	EGniLomXxwcmx0IBgrNHNeNl4kvP4h1GekqZvLqacbIZBoEqV2Y+ZQZiHl7ApFWyb07JNaH6E9SgM
	Pq28dYWruwS6VN9cNVw/wY90QUrvMop+an2JaJ0kfp+XPWvXXpqv8MSxLE8PyetTzRg/fmO8w2t50
	SduifejIqUsFOe9xncmzCvxtGSG7QedMLSeqoVLH6Hg4PVkoel5M/8bCw0ZlOsaEup1ps0ECPdLRt
	o56OS8xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWBRs-0000000EkxM-0r8J;
	Fri, 10 Jan 2025 09:37:00 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWBOI-0000000Ek1p-0nBQ
	for linux-nvme@lists.infradead.org;
	Fri, 10 Jan 2025 09:33:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B95E868BFE; Fri, 10 Jan 2025 10:33:11 +0100 (CET)
Date: Fri, 10 Jan 2025 10:33:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>, Ming Lei <ming.lei@redhat.com>,
	Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, nbd@other.debian.org,
	linux-scsi@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 06/11] block: fix queue freeze vs limits lock order in
 sysfs store methods
Message-ID: <20250110093311.GA9083@lst.de>
References: <20250109055810.1402918-1-hch@lst.de> <20250109055810.1402918-7-hch@lst.de> <8cfe7690-0101-42e7-ba97-6c6b717c4706@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8cfe7690-0101-42e7-ba97-6c6b717c4706@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_013318_365663_FAECF808 
X-CRM114-Status: GOOD (  16.19  )
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

On Thu, Jan 09, 2025 at 01:07:47PM +0000, John Garry wrote:
> Do you mean that the sysfs_lock could be removed in future? I would have 
> thought that queue limits lock could be used for the same thing, but I am 
> probably failing to see some lock nesting/ordering issues...

More or less.  Think about it: what does it even try to protect?

Readіng/writing sysfs files vs itself and file removal it serialized by
sysfs/kernfs internally.

Any information tweaked in sysfs usually also has other places that can
modify it.  So we'll need a lock independent of sysfs for that anyway.
A big part, buy by far all of that is covered by limits_lock.

Serializing creating/removing sysfs attribues is supposed to be
serialized using sysfs_dir_lock, although that needs a careful audit.

It's also used to serialize a few debugfs things, but we'll need to look
carefully for what exactly and switch that over to debugfs_mutex or
something new.

And then there's a bunch of misc cruft that also needs a careful look.

