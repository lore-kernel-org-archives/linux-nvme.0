Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5374C3ABBF
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 21:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PuuMuLVFYvj0X/T8c2k7Ig4rqNUs0SDawt5SWn5frdE=; b=2LWDHAU8sawhuFPW27NLkvTMP2
	5T4K6oy4FjVacIHui1bw5D3a7DR5LvaG7w3siF79ZrZjk8bxN8IVKPUtUN88pQs1XDAaj5QmV+Xxp
	WO9fDHBevRWJERmZqvznhzL0jcUBP6rrrMVks2a6nQLI4Z4SkVPgY79oz+s2L+aTzEqEBsD4VmaFe
	1swjkk55P9CszAkK2Xwono9B3gr42d2GFbHsmUnVpiXyAKM8ir1Bn4+/K1cgqYXN75J/YpRJYnfwf
	fg1cMfPOm8sO906hEogmB8PKDwA2Kmh4tQhnPuLp6WoAbvqBqe6YNIh3MPOxtjNPiLx7k2e7OrNH7
	C0h1fw0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uClvZ-0000000Gkha-2o8s;
	Wed, 07 May 2025 21:03:41 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uClv7-0000000Gkb6-0B7u
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 21:03:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 59B11629D8;
	Wed,  7 May 2025 21:03:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59BAC4CEE2;
	Wed,  7 May 2025 21:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746651792;
	bh=cnPOQ8rH8mGEWg2SZAMmFPn+K66GqaSykHvHWUjRJFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ou5UvFB7TRZFqaxnYiEakdi8Tv4V4TzoEj9Wbs7Q232VF867LOvRSZU+HZuD0Bq29
	 6CsCTPAn0pECDaosSJX8x976KW3ktLd9AEIM0HbZDqa6j9FdJY0JVbrPH5Nv3bO1hF
	 iIRu+OKZ1opelRfc+PFgGG2aRNfJhh4De1IHrOez/LdSHTTOSeQKEui3LTnMMeRTT9
	 W+5W3K5rrPfVhLUgD3gPmbJZPXu0JaLwoj23F/peyg6pNFb6IhrHsA/7+Eet9shIt4
	 Sng0fra5pNs4VfCOHaFQ+hSm5RXYO+syELa8jv0hYssg/oKu0kM6h7bFr8uzfaXdN3
	 ajieBlH8ExtxQ==
Date: Wed, 7 May 2025 14:03:10 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	john.g.garry@oracle.com, bmarzins@redhat.com, chaitanyak@nvidia.com,
	shinichiro.kawasaki@wdc.com, brauner@kernel.org,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: Re: [RFC PATCH v4 07/11] fs: statx add write zeroes unmap attribute
Message-ID: <20250507210310.GG25675@frogsfrogsfrogs>
References: <20250421021509.2366003-1-yi.zhang@huaweicloud.com>
 <20250421021509.2366003-8-yi.zhang@huaweicloud.com>
 <20250505132208.GA22182@lst.de>
 <20250505142945.GJ1035866@frogsfrogsfrogs>
 <c7d8d0c3-7efa-4ee6-b518-f8b09ec87b73@huaweicloud.com>
 <20250506043907.GA27061@lst.de>
 <64c8b62a-83ba-45be-a83e-62b6ad8d6f22@huaweicloud.com>
 <20250506121102.GA21905@lst.de>
 <a39a6612-89ac-4255-b737-37c7d16b3185@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a39a6612-89ac-4255-b737-37c7d16b3185@huaweicloud.com>
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
> 
> Therefore, I think that the current point of
> STATX_ATTR_WRITE_ZEROES_UNMAP (possibly STATX_WRITE_ZEROES_UNMAP) should
> be to just indicate whether a bdev or file supports the unmap write zero
> command (i.e., whether bdev_unmap_write_zeroes() returns true). If we
> use standard SCSI and NVMe storage devices, and the
> STATX_ATTR_WRITE_ZEROES_UNMAP attribute is set, users can be assured
> that FALLOC_FL_WRITE_ZEROES is fast and can choose to use
> fallocate(FALLOC_FL_WRITE_ZEROES) immediately.
> 
> Would you prefer to make STATX_ATTR_WRITE_ZEROES_UNMAP and
> FALLOC_FL_WRITE_ZEROES consistent, which means
> fallcoate(FALLOC_FL_WRITE_ZEROES) will return -EOPNOTSUPP if the block
> device doesn't set STATX_ATTR_WRITE_ZEROES_UNMAP ?
> 
> If so, I'd suggested we need to:
> 1) Remove STATX_ATTR_WRITE_ZEROES_UNMAP since users can check the
>    existence by calling fallocate(FALLOC_FL_WRITE_ZEROES) directly, this
>    statx flag seems useless.
> 2) Make the BLK_FEAT_WRITE_ZEROES_UNMAP sysfs interface to RW, allowing
>    users to adjust the block device's support state according to the
>    real situation.

Sounds fine to me... ;)

--D

> Thanks,
> Yi.
> 
> 

