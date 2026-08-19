Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE3D4C5DF6D
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2026 09:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i/y9+dOnndnjIHiXMUHVgHbSYPnxKacLGXCklZeVVBk=; b=P72C57cXTmokiNcvoFtDyogkbv
	e9eqp3t5CQVrkpRUWKho/L7xFtCrTSAaE2LXSVFwBAF5HU6/YVs+Lh5E0/B/e7ssnHcs/Q7t2gyV3
	/OJEu2cMauEyW6162ER8ceiBpH/567V0O3rLNNBljM40EAWVSy/49o7KfcAAAB3u0JujYpJlot827
	Vgj1iEryk3mbVVWQ+FxGvj3Z4fXLsn+faEDKlKxnEuq/IHyLLrhDRb6uyBkIo9fBZ1UsMyzD+zLtb
	dge7Is6IKN/UMYwvBm/CRqUyCnK72qc3ygK+vAPSEk58uo8xHddYKfb9X58JH62rEtbYZnvNCRA9r
	CgPJsCxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwcAM-00000009MML-3aZT;
	Wed, 19 Aug 2026 09:00:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwcAK-00000009MLq-1kSx
	for linux-nvme@lists.infradead.org;
	Wed, 19 Aug 2026 09:00:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0A5C668C7B; Wed, 19 Aug 2026 11:00:51 +0200 (CEST)
Date: Wed, 19 Aug 2026 11:00:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	John Garry <john.garry@linux.dev>
Subject: Re: [PATCH RFC v2 1/2] block: scan partitions for hidden disks
Message-ID: <20260819090050.GA9267@lst.de>
References: <20260818120854.3151628-1-john.g.garry@oracle.com> <20260818120854.3151628-2-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818120854.3151628-2-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260819_020056_651090_998AFA5D 
X-CRM114-Status: GOOD (  14.18  )
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

On Tue, Aug 18, 2026 at 12:08:53PM +0000, John Garry wrote:
> From: John Garry <john.garry@linux.dev>
> 
> If a disk is hidden (GENHD_FL_HIDDEN flags set), we currently do not scan
> the disk partition table.
> 
> GENHD_FL_HIDDEN is used in NVMe multipath support to hide the per-path
> disk.

It also is used for giving a handle to NVMe devices that we can't support
as block devices and for which we only want a handle to issue passthrough
commands.  For those attempting a partition scan is rather suboptimal.

As is in general doing an extra scan per controller when we know it must
give the same results.  Wouldn't it make more sense to just propagate
the partition table from the ns_head to each individual path?


