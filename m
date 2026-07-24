Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F611C531FA
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2026 15:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tApCYbmoflSbwJ8GmSfc8QLLcqki2mDSjkVeHAarplM=; b=iT3DWWzivdQgzg1QjMBaRanVv9
	yvduh49PAwDFXQl9FCpTbeiOKqz0FKbH+LeZjpIdrsA+ru2xqfM9N33twKk8uwi+b0Pmxiu713T1e
	MVwQADCR8LojaLnj1MUksf+ZeS1788zENigXE8DwDPjye55InYBz/5M8qO3RmycKbXBufBtZmpE7e
	UuGDjFgXPUCSos/ab7+F0yOnbHrIuhWknGt27S6+68XpH9l9X+w0jJktWi9CKWpPhIyVPa1PLYuSZ
	DwUjYcXiCxKq9/kzTc8pdF+H0frT6jp6Us4Q1p4kizx0k+b4aiIEjB6522oEUUvVqgKFQj6BthgX8
	N03MZiqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnHy8-0000000Gjvm-2cFp;
	Fri, 24 Jul 2026 15:37:48 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnHy7-0000000Gjvf-0IIY
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jul 2026 15:37:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 732304137E;
	Fri, 24 Jul 2026 15:37:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 336681F000E9;
	Fri, 24 Jul 2026 15:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784907466;
	bh=tApCYbmoflSbwJ8GmSfc8QLLcqki2mDSjkVeHAarplM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JNbaiDIi333V78oi5T3v1qagu/o0ogNtXK2A346gGm8rCuTtqGqS0/adXrUGG7FC6
	 P1Vx7UvITCDG1zyIPsL7yJzTMsA3gyYB+qzYcBEetJXuJm1IfnIGu2HxiVNtroWkTE
	 ZDDQJGoHSHt3upME6l/iSE25/2ba1jPHj0Rvej0uFx9DGTS7oHIUso3jLnfTpY4eFo
	 zrdRDpx6uQpdw1yX+//V/L2x50rsJ59nlBAI39izr/Z0I76oir1VuNDRKZf4C1P0/T
	 zG5ZsQVC7LH/afX+laVNSZmBHr9qMDiLNtXprOe1P5cx4CtGGKxHf/sAEWD25EcVNH
	 TWgdihgU0mi5Q==
Date: Fri, 24 Jul 2026 09:37:42 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.garry@linux.dev>
Cc: John Garry <john.g.garry@oracle.com>, Christoph Hellwig <hch@lst.de>,
	sagi@grimberg.me, axboe@fb.com, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH RFC] nvme-multipath: fix diskstats for partitions
Message-ID: <amOGxr3rxvDflHLv@kbusch-mbp>
References: <20260721114553.1657841-1-john.g.garry@oracle.com>
 <20260724050152.GA3680@lst.de>
 <987782a9-e12a-4098-b438-a54a5765c2ae@oracle.com>
 <amNegPEvRX99EvPN@kbusch-mbp>
 <f76e9466-4b66-4a32-a491-728e24d34052@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f76e9466-4b66-4a32-a491-728e24d34052@linux.dev>
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

On Fri, Jul 24, 2026 at 04:29:08PM +0100, John Garry wrote:
> On 7/24/26 13:45, Keith Busch wrote:
> > Can we just thread through partitions for the bio's block_device instead
> > of assuming part0? I know the hidden path devices skip partition
> > scanning, but maybe if we let it happen, then those will have the same
> > partition setup as the head gendisk. Then we can go right to the
> > disk->part_tbl for what we provide to bio_set_dev() for both submission
> > and failover, and everything should work out from there.
> 
> I guess that we would just scan through the per-path gendisk->part_tbl and
> match somehow to lookup the partition. Maybe vs start address of
> bio->bi_bdev. Or is there a simpler (and quicker) way?
> 

This is the idea, assuming we can get the partition tables of the head
and path disks to be aligned:

---
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -543,7 +543,10 @@ static void nvme_ns_head_submit_bio(struct bio *bio)
        srcu_idx = srcu_read_lock(&head->srcu);
        ns = nvme_find_path(head);
        if (likely(ns)) {
-               bio_set_dev(bio, ns->disk->part0);
+               struct block_device *bdev;
+
+               bdev = xa_load(&ns->disk->part_tbl, bdev_partno(bio->bi_bdev));
+               bio_set_dev(bio, bdev);
                /*
                 * Use BIO_REMAPPED to skip bio_check_eod() when this bio
                 * enters submit_bio_noacct() for the per-path device. The EOD
--

