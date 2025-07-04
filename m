Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFAC7C83F0B
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Jul 2025 11:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WqQvHf6Q2n/POHTFOr6br66Fle3gLETdysZgl6RXctg=; b=Fxoi6AF37K64TxCxaZUOtWCkUw
	vo57J0rbTyoK6lIhIAAf089xE4WLmghh+ill7oMWAZ8/yZ58N+lBxwv7HAh/1LgJ/Jenevp7eAUQ4
	TnLE6zQjxbNqVMxuKiqiTZaRZht5AJ6qmcBQQERNaMCSDLzK6ef23fXPbRN0u7kIeABHzyJPD5AP+
	sygN8jrSKqHV0C4WD4V6fNE7QoQJPEzTNSMO3bA8GX32+15zJZQHGlOoPCjHlNsE+MEK7bo1hQIVO
	CZHpgUPIsRo/4bWv1zDMeuW5HhZd0g8qrbdnpKnrC4fwOCWKT1Hq+SWh46JDWiGZ/Hy3iT1iyO20v
	8GGzTSzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXeUB-0000000EC2P-1eLA;
	Fri, 04 Jul 2025 11:21:43 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXbxh-0000000Dlef-1EkW
	for linux-nvme@lists.infradead.org;
	Fri, 04 Jul 2025 08:40:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A42FD61466;
	Fri,  4 Jul 2025 08:40:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11EA7C4CEF0;
	Fri,  4 Jul 2025 08:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751618400;
	bh=FHas3OLzhcWmJla/w9SVAWfRsC/N5brO1Le2ihalCNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VLpy79R3WoowQ0dde0FpFT1YyHsXsurqva+SkoBcww5fjPVnQMcwqe87L2wtjyLYi
	 kRKqWJIQ81p4a1f0xNgpRmdmn+OPlPkQk/4+3lz4NrJRi0wbmnDt4pjvgXFACOvZxO
	 qU9E5LKN5/hna1bw+wpVR2YB99mwlJCTB2beguJ1mHivp02SKA4At/U4wBW5k3iT/Q
	 u3HMCjJxxvd2r71zcnuKhwU/Z06IvtD7wFREJ9CXS/1miJCbu6oYZeK5DrvOvTrTgE
	 IHzvXhhXfrV+PFyTdnHzAjREeo0FCEO0Q5nKDCaILrTwFadudwtNVY/apMjWmKyCd5
	 QDeadiD91wJeA==
Date: Fri, 4 Jul 2025 10:39:53 +0200
From: Christian Brauner <brauner@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de, 
	tytso@mit.edu, djwong@kernel.org, john.g.garry@oracle.com, bmarzins@redhat.com, 
	chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com, martin.petersen@oracle.com, 
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com, 
	yangerkun@huawei.com, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH v2 0/9] fallocate: introduce FALLOC_FL_WRITE_ZEROES flag
Message-ID: <20250704-gemein-addieren-62ad4d210c70@brauner>
References: <20250619111806.3546162-1-yi.zhang@huaweicloud.com>
 <20250623-woanders-allabendlich-f87ae2d9c704@brauner>
 <99010bfd-c968-49c7-b62b-c72b38722c1b@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <99010bfd-c968-49c7-b62b-c72b38722c1b@huaweicloud.com>
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

On Thu, Jul 03, 2025 at 11:35:41AM +0800, Zhang Yi wrote:
> On 2025/6/23 18:46, Christian Brauner wrote:
> > On Thu, 19 Jun 2025 19:17:57 +0800, Zhang Yi wrote:
> >> From: Zhang Yi <yi.zhang@huawei.com>
> >>
> >> Changes since v1:
> >>  - Rebase codes on 6.16-rc2.
> >>  - Use max_{hw|user}_wzeroes_unmap_sectors queue limits instead of
> >>    BLK_FEAT_WRITE_ZEROES_UNMAP feature to represent the status of the
> >>    unmap write zeroes operation as Christoph and Darrick suggested. This
> >>    redoes the first 5 patches, so remove all the reviewed-by tags,
> >>    please review them again.
> >>  - Simplify the description of FALLOC_FL_WRITE_ZEROES in patch 06 as
> >>    Darrick suggested.
> >>  - Revise the check order of FALLOC_FL_WRITE_ZEROES in patch 08 as
> >>    Christoph suggested.
> >> Changes since RFC v4:
> >>  - Rebase codes on 6.16-rc1.
> >>  - Add a new queue_limit flag, and change the write_zeroes_unmap sysfs
> >>    interface to RW mode. User can disable the unmap write zeroes
> >>    operation by writing '0' to it when the operation is slow.
> >>  - Modify the documentation of write_zeroes_unmap sysfs interface as
> >>    Martin suggested.
> >>  - Remove the statx interface.
> >>  - Make the bdev and ext4 don't allow to submit FALLOC_FL_WRITE_ZEROES
> >>    if the block device does not enable the unmap write zeroes operation,
> >>    it should return -EOPNOTSUPP.
> >> Changes sicne RFC v3:
> >>  - Rebase codes on 6.15-rc2.
> >>  - Add a note in patch 1 to indicate that the unmap write zeros command
> >>    is not always guaranteed as Christoph suggested.
> >>  - Rename bdev_unmap_write_zeroes() helper and move it to patch 1 as
> >>    Christoph suggested.
> >>  - Introduce a new statx attribute flag STATX_ATTR_WRITE_ZEROES_UNMAP as
> >>    Christoph and Christian suggested.
> >>  - Exchange the order of the two patches that modified
> >>    blkdev_fallocate() as Christoph suggested.
> >> Changes since RFC v2:
> >>  - Rebase codes on next-20250314.
> >>  - Add support for nvme multipath.
> >>  - Add support for NVMeT with block device backing.
> >>  - Clear FALLOC_FL_WRITE_ZEROES if dm clear
> >>    limits->max_write_zeroes_sectors.
> >>  - Complement the counterpart userspace tools(util-linux and xfs_io)
> >>    and tests(blktests and xfstests), please see below for details.
> >> Changes since RFC v1:
> >>  - Switch to add a new write zeroes operation, FALLOC_FL_WRITE_ZEROES,
> >>    in fallocate, instead of just adding a supported flag to
> >>    FALLOC_FL_ZERO_RANGE.
> >>  - Introduce a new flag BLK_FEAT_WRITE_ZEROES_UNMAP to the block
> >>    device's queue limit features, and implement it on SCSI sd driver,
> >>    NVMe SSD driver and dm driver.
> >>  - Implement FALLOC_FL_WRITE_ZEROES on both the ext4 filesystem and
> >>    block device (bdev).
> >>
> >> [...]
> > 
> > If needed, the branch can be declared stable and thus be used as base
> > for other work.
> > 
> > ---
> > 
> > Applied to the vfs-6.17.fallocate branch of the vfs/vfs.git tree.
> > Patches in the vfs-6.17.fallocate branch should appear in linux-next soon.
> > 
> > Please report any outstanding bugs that were missed during review in a
> > new review to the original patch series allowing us to drop it.
> > 
> > It's encouraged to provide Acked-bys and Reviewed-bys even though the
> > patch has now been applied. If possible patch trailers will be updated.
> > 
> > Note that commit hashes shown below are subject to change due to rebase,
> > trailer updates or similar. If in doubt, please check the listed branch.
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> > branch: vfs-6.17.fallocate
> 
> Hi Christian,
> 
> I noticed that this patch series doesn't appear to be merged into this
> branch. Just wondering if it might have been missed?

Dammit, my script missed to push the branch. Fixed now. Thanks for
checking!

