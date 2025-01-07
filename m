Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2CEE77197
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2025 13:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kYNpoilx7wSK1OmAquEjOwqVDywqYi5WQfbhG3p32fg=; b=vvBZJ+jVO8Hx1flyIERIHQJJlQ
	/5o/8M3KTzthuvzYJOSzI84eElBOBAuE963Qv2s09z0DNYjxlrbqjzaHtrtSfP1wjvAfnE5dFH2Jl
	QO2Q5nSP5h/8LDaZOZMScDhf4X9IP1u1kkQJss6a3JhRuKtNTj781tNd7bUrGr4xL1LhHuQqSAZTx
	vYB0NsS9blLF64zyD+j6Sqc/FSeAhdnuzQNgV95h3vkDHFBvZDNZ+566STKMJBkuztqV3w1KgOP1u
	FiItAu7vREWBagk+y0b9AmiQT5Rr8hVe4yXLZxXoeTXfh64s9+gs4Un932+XiG9AKZdKRfr0/Lsqp
	AAFJd9Mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tV9xT-000000053fx-2JAe;
	Tue, 07 Jan 2025 13:49:23 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tV9xQ-000000053fD-3fd1
	for linux-nvme@lists.infradead.org;
	Tue, 07 Jan 2025 13:49:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 92DC968D05; Tue,  7 Jan 2025 14:49:14 +0100 (CET)
Date: Tue, 7 Jan 2025 14:49:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	nbd@other.debian.org, linux-scsi@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH 4/8] block: add a store_limit operations for sysfs
 entries
Message-ID: <20250107134913.GA22046@lst.de>
References: <20250107063120.1011593-1-hch@lst.de> <20250107063120.1011593-5-hch@lst.de> <Z3zXANbFk6GBZg_z@fedora> <ae6b7727-64d6-4d9e-9bf5-951e38d8a768@linux.ibm.com> <Z30AsQq89_lcstNl@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z30AsQq89_lcstNl@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_054921_051669_2E811EAF 
X-CRM114-Status: GOOD (  12.55  )
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

On Tue, Jan 07, 2025 at 06:25:20PM +0800, Ming Lei wrote:
> __blk_mq_update_nr_hw_queues() freezes queue before acquiring ->syfs_lock too.
> 
> So yes, it is a mess wrt. order between ->sysfs_lock and freezing queue.

Let's sort out the current freeze vs limits lock issue first.  Next step
is to kill sysfs_lock in it's current form.


