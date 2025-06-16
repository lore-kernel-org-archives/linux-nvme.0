Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F430C71136
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Jun 2025 05:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oYsNZoedjhL2xuhtetofNyjG+AFFt8T3lcOued8u9t8=; b=NcMiVXt84qO5lyFBnOF/KZAHVu
	N7nFVjGigBbKjZ6/fCbosiqNruk6s47kYy/9vxldBf1hXNlUIA8HG8PhJse0/+NUVGNZcRhPHlGVb
	KBz+Cag/HDoCxEwJ2bXHZWSaLrIYopLmGwbWQShCw3tvrVlt0+0bmegd3V8x6RZnz59KN7hQzON0v
	xog+BsokCrJ9G4LyeihK+OAAV5XpcesgvfQN5H78g0zsCeO275Y31s/Eg1rzTWG/WZVYqk6PGnr+5
	i1IRQk+uzYMorJgpqxOcQTKvmcX6kjAj33VHdVfZutGFFEH5nia13wMQ1mgMA/C7un9Xor3dBPTDG
	qNvS3Lrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR2Ym-00000003RU7-3seh;
	Mon, 16 Jun 2025 05:39:08 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR2Yk-00000003RTl-2OBd
	for linux-nvme@lists.infradead.org;
	Mon, 16 Jun 2025 05:39:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2C15E68BFE; Mon, 16 Jun 2025 07:39:02 +0200 (CEST)
Date: Mon, 16 Jun 2025 07:39:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	tytso@mit.edu, john.g.garry@oracle.com, bmarzins@redhat.com,
	chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com,
	brauner@kernel.org, martin.petersen@oracle.com, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 01/10] block: introduce BLK_FEAT_WRITE_ZEROES_UNMAP to
 queue limits features
Message-ID: <20250616053901.GA1533@lst.de>
References: <20250604020850.1304633-2-yi.zhang@huaweicloud.com> <20250611060900.GA4613@lst.de> <343f7f06-9bf6-442f-8e77-0a774203ec3f@huaweicloud.com> <20250612044744.GA12828@lst.de> <41c21e20-5439-4157-ad73-6f133df42d28@huaweicloud.com> <20250612150347.GK6138@frogsfrogsfrogs> <3569a77f-1f38-4764-b1e3-d0075775c7bb@huaweicloud.com> <20250613055630.GA9119@lst.de> <20250613145433.GF6134@frogsfrogsfrogs> <3d749264-6fdd-458f-a3a8-35d2320193b3@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d749264-6fdd-458f-a3a8-35d2320193b3@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250615_223906_750986_E95559F3 
X-CRM114-Status: GOOD (  18.20  )
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

On Sat, Jun 14, 2025 at 12:48:26PM +0800, Zhang Yi wrote:
> >> Maybe we should redo this similar to the other hardware/software interfaces
> >> and have a hw_ limit that is exposed by the driver and re-only in
> >> sysfs, and then the user configurable one without _hw.  Setting it to
> >> zero disables the feature.
> > 
> > Yeah, that fits the /sys/block/foo/queue model better.
> > 
> 
> OK, well. Please let me confirm, are you both suggesting adding
> max_hw_write_zeores_unmap_sectors and max_write_zeroes_unmap_sectors to
> the queue_limits instead of adding BLK_FEAT_WRITE_ZEROES_UNMAP to the
> queue_limits->features. Something like the following.

Yes.

> Besides, we should also rename max_write_zeroes_sectors to
> max_hw_write_zeroes_sectors since it is a hardware limitation reported
> by the driver.  If the device supports unmap write zeroes,
> max_hw_write_zeores_unmap_sectors should be equal to
> max_hw_write_zeroes_sectors, otherwise it should be 0.

We've only done the hw names when we allow and overwrite or cap based
on other values.  So far we've not done any of that to
max_write_zeroes_sectors.


