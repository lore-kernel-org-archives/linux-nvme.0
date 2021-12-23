Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A032CC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Dec 2021 10:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Sq5FTZdZCuJGAIiKXu3zLR9CZVx0uxX1AdIquLrEsgI=; b=oT0oPa1bPIo9C6FKMZc4KmpnHa
	8/h/CGX7KZK6QeplShdtN51lDYkoRcUOJTBu6Ed1v/csGlmTvEmIXQLFxU3tl0w4ijd3rvcnOCKy9
	UDzDIk/9ozg9OS1oqjMJ1EvdjpQlMMOhjD6PFUEatiIQy0IjCC3ComF3F2O8fwCaiolAcv1dFINaQ
	mtbSlfsw29NWSl//e5EW+nR4kkIbmcFcv33Q4Zf2HMYDG6y/0NpZ3K1tWcRG0/zslUVE+1HVfwQTg
	J9osQLrqTvF3dCnmKashD46XIx3hGrJgUfuehP5dHPo4WBhk3jiBUwslqOoXrhRkbZ6X3fuOda8sq
	+1siMijg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n0LDR-00CTw7-HK; Thu, 23 Dec 2021 10:20:53 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1n0LDP-00CTvx-SJ; Thu, 23 Dec 2021 10:20:51 +0000
Date: Thu, 23 Dec 2021 02:20:51 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Geliang Tang <geliang.tang@suse.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: drop unused variable ctrl in nvme_setup_cmd
Message-ID: <YcRNg6xJBiIYuPAH@infradead.org>
References: <2dba156053da8242f12ae218b938bc98880e896b.1640165300.git.geliang.tang@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dba156053da8242f12ae218b938bc98880e896b.1640165300.git.geliang.tang@suse.com>
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

Thanks,

applied.

