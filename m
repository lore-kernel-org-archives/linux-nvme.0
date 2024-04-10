Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F34D0CD11C2
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Apr 2024 22:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+0GBmcwTyMhAOkoLxmQrxueXW3lGrGIZ8d1OHjV7ylM=; b=MRwSeaTGkSP8hIPL6WYmWmVttt
	BbodDjLGTAgUArlGONBwPjoHapaPpNkoF6MtJsp4U46Swt8Maajw5wkQdQsGBCtNyd1soNvCcvfDZ
	8ut6G/j2gppGCL/sHkKBEuhz/40oAxgvQXuOLnznwMrJr6uSPDBT6IPPrQpb6TsfMwN24WKAHw1o4
	M9FVGCf0U+0Y9pNRp6eZaQJxTUj1CcuAO7CUvLtU7eq+s/F5gvTH4LnsKHIVnHah7QoYJGPtetgK7
	epVFmQDzjXLUDE8DsyZiPIVLkFmfQAQkyXnGgZyg3Gdx7l1bZR6Tz/EZQxl2NidTvcW+8bM2UcOXq
	LrNDtXVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rugp9-00000009KkK-0kfE;
	Wed, 10 Apr 2024 22:53:47 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rugp4-00000009KiJ-11gu;
	Wed, 10 Apr 2024 22:53:42 +0000
Date: Wed, 10 Apr 2024 15:53:41 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com,
	linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
	io-uring@vger.kernel.org, nilay@linux.ibm.com,
	ritesh.list@gmail.com, willy@infradead.org
Subject: Re: [PATCH v6 02/10] block: Call blkdev_dio_unaligned() from
 blkdev_direct_IO()
Message-ID: <ZhcYddRtAoMghtvr@bombadil.infradead.org>
References: <20240326133813.3224593-1-john.g.garry@oracle.com>
 <20240326133813.3224593-3-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326133813.3224593-3-john.g.garry@oracle.com>
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

On Tue, Mar 26, 2024 at 01:38:05PM +0000, John Garry wrote:
> blkdev_dio_unaligned() is called from __blkdev_direct_IO(),
> __blkdev_direct_IO_simple(), and __blkdev_direct_IO_async(), and all these
> are only called from blkdev_direct_IO().
> 
> Move the blkdev_dio_unaligned() call to the common callsite,
> blkdev_direct_IO().
> 
> Pass those functions the bdev pointer from blkdev_direct_IO() as it is non-
> trivial to calculate.
> 
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

I think this patch should just be sent separately already and not part
of this series.

  Luis

