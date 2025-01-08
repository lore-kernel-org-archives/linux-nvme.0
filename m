Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F6BE77199
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2025 15:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PxDXBix9Vkf9rlHacss1vKZYtKq6qzLG9Usz7Z81wHQ=; b=FssAg/mAz0cnTh/89Pjffoyc4L
	gViZCmQRkIA36Fd8CZrQ0N5dheHAf7EhMBcVxeXpHok4oKclt9KYXXQ0530f/sGKkDYljtJbf3x2l
	WX6t05HhwZsbhxIVkiaNePetJadTid71h3NpQclG+/75j1yRpdY0u1XYH98dD+K1Z0GWRjrPSZ3jw
	IuosMsD1IBuyUhqTQc5Jw3srfbD9+6GFqdXD8WfZ6mYUDrcxhA0U100MYMkIb/AuymA+qYDxUlU5b
	q8prplXpcKR6uuqrxoTRGUxYMI3AfZiI2VON+hyym4LgHiXy1aPkwlwAinlEMeTmHQDX4nZRDiI5f
	KVZPNmTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVXze-00000008yHg-2WND;
	Wed, 08 Jan 2025 15:29:14 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVXzc-00000008yGo-4665
	for linux-nvme@lists.infradead.org;
	Wed, 08 Jan 2025 15:29:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F1EFA68BFE; Wed,  8 Jan 2025 16:29:08 +0100 (CET)
Date: Wed, 8 Jan 2025 16:29:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, nbd@other.debian.org,
	linux-scsi@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH 05/10] block: fix queue freeze vs limits lock order in
 sysfs store methods
Message-ID: <20250108152908.GB24792@lst.de>
References: <20250108092520.1325324-1-hch@lst.de> <20250108092520.1325324-6-hch@lst.de> <Z35Vl6ob0zLH_Kh-@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z35Vl6ob0zLH_Kh-@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_072913_158942_172ACEE1 
X-CRM114-Status: GOOD (  12.85  )
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

On Wed, Jan 08, 2025 at 06:38:15PM +0800, Ming Lei wrote:
> Looks fine, but now ->store_limit() is called without holding
> ->sysfs_lock, maybe it should be documented.

Ok, I had this in my own commit log, but it got lost when I stole
Damien's much better one instead :)

I assume you're fine with just documenting it in the commit log?


