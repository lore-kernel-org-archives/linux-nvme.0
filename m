Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D514C3ABBE
	for <linux-nvme@archiver.kernel.org>; Thu,  8 May 2025 05:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WCTvKZSBHa8S9R7cBQlIwOeNgh/Xc528tBjLhoJ1TPQ=; b=mAJjAqz5STc3rBioN98s4ubKUZ
	0fChe8M5zjS/7LLcupSsuvdkILbZCMPxwA18ABykY7JXaDMuzOob5CjxrL7r5IRH/3jj+cKRXXiQY
	lhm+Gyqtvv2zXl5uhV5MonaiRWwfS0GjmGstKZHqcqsvZKDQ/VbS7Lvn9cAGjfsSUzD4UfX1yIavF
	7j0aJAab7aXI9Zd6lwSFE8ld2LoKErmqOxl7JHwTS67rJg7KwGNsDOEGm9vaB2AxRWArDF6LWBfBT
	4hkJxU2O5pAzpH8GL4iS6vPww2rOCGHSilkEwR7l60uScbeVekJifR9oIxGhVqBjnnktg06jDWXSN
	18ytcfQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCtOS-0000000HJjQ-2Yxe;
	Thu, 08 May 2025 05:02:00 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCtOP-0000000HJgy-0m2b
	for linux-nvme@lists.infradead.org;
	Thu, 08 May 2025 05:01:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7F69868B05; Thu,  8 May 2025 07:01:47 +0200 (CEST)
Date: Thu, 8 May 2025 07:01:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	tytso@mit.edu, john.g.garry@oracle.com, bmarzins@redhat.com,
	chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com,
	brauner@kernel.org, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC PATCH v4 07/11] fs: statx add write zeroes unmap attribute
Message-ID: <20250508050147.GA26916@lst.de>
References: <20250421021509.2366003-1-yi.zhang@huaweicloud.com> <20250421021509.2366003-8-yi.zhang@huaweicloud.com> <20250505132208.GA22182@lst.de> <20250505142945.GJ1035866@frogsfrogsfrogs> <c7d8d0c3-7efa-4ee6-b518-f8b09ec87b73@huaweicloud.com> <20250506043907.GA27061@lst.de> <64c8b62a-83ba-45be-a83e-62b6ad8d6f22@huaweicloud.com> <20250506121102.GA21905@lst.de> <a39a6612-89ac-4255-b737-37c7d16b3185@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a39a6612-89ac-4255-b737-37c7d16b3185@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_220157_503780_6CA19E2C 
X-CRM114-Status: GOOD (  30.09  )
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

On Wed, May 07, 2025 at 03:33:23PM +0800, Zhang Yi wrote:
> On 2025/5/6 20:11, Christoph Hellwig wrote:
> > On Tue, May 06, 2025 at 07:16:56PM +0800, Zhang Yi wrote:
> >> Sorry, but I don't understand your suggestion. The
> >> STATX_ATTR_WRITE_ZEROES_UNMAP attribute only indicate whether the bdev
> >> and the block device that under the specified file support unmap write
> >> zeroes commoand. It does not reflect whether the bdev and the
> >> filesystems support FALLOC_FL_WRITE_ZEROES. The implementation of
> >> FALLOC_FL_WRITE_ZEROES doesn't fully rely on the unmap write zeroes
> >> commoand now, users simply refer to this attribute flag to determine
> >> whether to use FALLOC_FL_WRITE_ZEROES when preallocating a file.
> >> So, STATX_ATTR_WRITE_ZEROES_UNMAP and FALLOC_FL_WRITE_ZEROES doesn't
> >> have strong relations, why do you suggested to put this into the ext4
> >> and bdev patches that adding FALLOC_FL_WRITE_ZEROES?
> > 
> > So what is the point of STATX_ATTR_WRITE_ZEROES_UNMAP?
> 
> My idea is not to strictly limiting the use of FALLOC_FL_WRITE_ZEROES to
> only bdev or files where bdev_unmap_write_zeroes() returns true. In
> other words, STATX_ATTR_WRITE_ZEROES_UNMAP and FALLOC_FL_WRITE_ZEROES
> are not consistent, they are two independent features. Even if some
> devices STATX_ATTR_WRITE_ZEROES_UNMAP are not set, users should still be
> allowed to call fallcoate(FALLOC_FL_WRITE_ZEROES). This is because some
> devices and drivers currently cannot reliably ascertain whether they
> support the unmap write zero command; however, certain devices, such as
> specific cloud storage devices, do support it. Users of these devices
> may also wish to use FALLOC_FL_WRITE_ZEROES to expedite the zeroing
> process.

What are those "cloud storage devices" where you set it reliably,
i.e.g what drivers?

> Therefore, I think that the current point of
> STATX_ATTR_WRITE_ZEROES_UNMAP (possibly STATX_WRITE_ZEROES_UNMAP) should
> be to just indicate whether a bdev or file supports the unmap write zero
> command (i.e., whether bdev_unmap_write_zeroes() returns true). If we
> use standard SCSI and NVMe storage devices, and the
> STATX_ATTR_WRITE_ZEROES_UNMAP attribute is set, users can be assured
> that FALLOC_FL_WRITE_ZEROES is fast and can choose to use
> fallocate(FALLOC_FL_WRITE_ZEROES) immediately.

That's breaking the abstracton again.  An attribute must say something
about the specific file, not about some underlying semi-related feature.

> Would you prefer to make STATX_ATTR_WRITE_ZEROES_UNMAP and
> FALLOC_FL_WRITE_ZEROES consistent, which means
> fallcoate(FALLOC_FL_WRITE_ZEROES) will return -EOPNOTSUPP if the block
> device doesn't set STATX_ATTR_WRITE_ZEROES_UNMAP ?

Not sure where the block device comes from here, both of these operate
on a file.

> If so, I'd suggested we need to:
> 1) Remove STATX_ATTR_WRITE_ZEROES_UNMAP since users can check the
>    existence by calling fallocate(FALLOC_FL_WRITE_ZEROES) directly, this
>    statx flag seems useless.

Yes, that was my inital thought.

> 2) Make the BLK_FEAT_WRITE_ZEROES_UNMAP sysfs interface to RW, allowing
>    users to adjust the block device's support state according to the
>    real situation.

No, it's a feature and not a flag.


