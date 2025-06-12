Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A8A4C61CE8
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Jun 2025 19:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UM7JrM5zxDNNfveu7N1+46WxeUzQQu6akD8APoC8O9A=; b=kM263bJjXIM28+kkrqA36OEfPI
	ttTzF0DqVOgd0Kkx/zf7gVcX8yx5phxHOtzk7jRO5yRrpsyj8T2vRIy+W1rrbMPQJhmwfYdIDIiL1
	lYTCZFu2oojsbHkMUp8YW+TEjOKm1n6NbqzSqZvMhfQPVusXP6V1QtdN3iD7UifE2alQU/HLbnhqI
	WT2vaHto+oTXqX2IleufHGVxYtHcMR7sSOonqT1c+k5aD/CWInsvAWUdiTgh4AfJA90QvoM5IhB+a
	1b67TicWivLEuN/BeA4ndA6Oz6YT0BUHGz3J6+ihZUVlGfP/iUiRp2krzFCk+0/FXL7V+wm9PhNdY
	YHs2GAXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPnqM-0000000EIb9-2WgE;
	Thu, 12 Jun 2025 19:44:10 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPjT3-0000000Dj1E-0J5D
	for linux-nvme@lists.infradead.org;
	Thu, 12 Jun 2025 15:03:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 13B52A51DAC;
	Thu, 12 Jun 2025 15:03:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65BDC4CEEB;
	Thu, 12 Jun 2025 15:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749740627;
	bh=ONyFbl7eR0QXU3CRaThaUkea18g1Bd2HJqzSu8H2F5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m74s/H9bViol79YmIelbep7cXyzEw47hdktzg1MN6vCsg0S24VQ/KqSDwpigubKeE
	 i41PpwJYbao8dKkGyE2Qqe80rDBt1KLstr08lFXyM7NrBpY5+1GLMitIsyHPH9pCI1
	 RYqA94+q4srgJ820hmzPT2j5D4utw51hYyphDzfmQ9/qugstzZiKxhOn3D8GrAvQ8j
	 X4Jo/C2BGR8LyZw47KY7cK2I3lFCTccQP4dr8up2k8RWnzpbNifNYM9Yn3+F7UHZR0
	 qapgcqmD42kiSJv9F9eFn76HvvhT8koJ4G37SFjrSwz0usnG0i9ighP1aKYvjTYnul
	 8U9pYzGL/Kbhg==
Date: Thu, 12 Jun 2025 08:03:47 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	john.g.garry@oracle.com, bmarzins@redhat.com, chaitanyak@nvidia.com,
	shinichiro.kawasaki@wdc.com, brauner@kernel.org,
	martin.petersen@oracle.com, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 01/10] block: introduce BLK_FEAT_WRITE_ZEROES_UNMAP to
 queue limits features
Message-ID: <20250612150347.GK6138@frogsfrogsfrogs>
References: <20250604020850.1304633-1-yi.zhang@huaweicloud.com>
 <20250604020850.1304633-2-yi.zhang@huaweicloud.com>
 <20250611060900.GA4613@lst.de>
 <343f7f06-9bf6-442f-8e77-0a774203ec3f@huaweicloud.com>
 <20250612044744.GA12828@lst.de>
 <41c21e20-5439-4157-ad73-6f133df42d28@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41c21e20-5439-4157-ad73-6f133df42d28@huaweicloud.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250612_080349_172229_5092DE57 
X-CRM114-Status: GOOD (  18.58  )
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

On Thu, Jun 12, 2025 at 07:20:45PM +0800, Zhang Yi wrote:
> On 2025/6/12 12:47, Christoph Hellwig wrote:
> > On Wed, Jun 11, 2025 at 03:31:21PM +0800, Zhang Yi wrote:
> >>>> +/* supports unmap write zeroes command */
> >>>> +#define BLK_FEAT_WRITE_ZEROES_UNMAP	((__force blk_features_t)(1u << 17))
> >>>
> >>>
> >>> Should this be exposed through sysfs as a read-only value?
> >>
> >> Uh, are you suggesting adding another sysfs interface to expose
> >> this feature?
> > 
> > That was the idea.  Or do we have another way to report this capability?
> > 
> 
> Exposing this feature looks useful, but I think adding a new interface
> might be somewhat redundant, and it's also difficult to name the new
> interface. What about extend this interface to include 3 types? When
> read, it exposes the following:
> 
>  - none     : the device doesn't support BLK_FEAT_WRITE_ZEROES_UNMAP.
>  - enabled  : the device supports BLK_FEAT_WRITE_ZEROES_UNMAP, but the
>               BLK_FLAG_WRITE_ZEROES_UNMAP_DISABLED is not set.
>  - disabled : the device supports BLK_FEAT_WRITE_ZEROES_UNMAP, and the
>               BLK_FLAG_WRITE_ZEROES_UNMAP_DISABLED is set.
> 
> Users can write '0' and '1' to disable and enable this operation if it
> is not 'none', thoughts?

Perhaps it should reuse the enumeration pattern elsewhere in sysfs?
For example,

# cat /sys/block/sda/queue/scheduler
none [mq-deadline]
# echo none > /sys/block/sda/queue/scheduler
# cat /sys/block/sda/queue/scheduler
[none] mq-deadline

(Annoying that this seems to be opencoded wherever it appears...)

--D

> Best regards,
> Yi.
> 
> 

