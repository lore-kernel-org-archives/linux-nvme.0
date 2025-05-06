Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA97AC3ABAC
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 06:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vpgd9RB5ExlEroFftZdzgVYO9I5SFyn8WBB3qyka8mM=; b=PgVLTA1qJDLURKK2u05CVA9SCX
	W2kmE7CvresRjOsFix9nXyYzZgwBDYDg+n+IHia1l5JNWjHoigM4Uni4CIH8Bcu6LLIXSd1Sfkhdv
	t64LZi/SIFBCafxh8sRhau4X77q/nr9oylvOtw1XCLRBtRn5saYCq23na6Qu1/Pf9ba0ipAynciD7
	nSv4vS/ZqKM7rsgZnYhxztINlBDjHdLuuv2W0aLYevuiTwssNnPEzARyhjYnGZUOzBaJCKAy4XJHJ
	8g1rN9l6uawXCxbYmuHv+OMsYKpWqZIK46i0Ebld3j9VO/VqDX4+evQHntFDa1wjIsQFRCrWMrtLT
	7eV9+bAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCBgi-0000000AeVV-0bJe;
	Tue, 06 May 2025 06:21:56 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCAzB-0000000ATjr-1UGX
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 05:36:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E774C4A032;
	Tue,  6 May 2025 05:36:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C383C4CEF0;
	Tue,  6 May 2025 05:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746509815;
	bh=UVuy9ogA8kbxN31PqG2ogdS080rmyL1HXX6AhQqmcnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mhuoWC9yPuKYxQ/EmkpumPF/OMvdDEn0ZOt2eABGZszCs9GkLyi3ecQepcp2rWj/x
	 wFKiLMD3llXUiNqheph9fmutbUvp3ABiPKvR6+j1/C3PnAJzXDM0BdYyV1SDKFuLf1
	 ZX2RmwkYj0NY6RH+uwkKQ1DKSHuSkgC0VcbFKJjIg+n7IvWIPRMOysPxQ75BmHqenI
	 W0G8v7YRjGEbcDmHpgb0BZRTxDak8ZW06Hry5zqz3ryzlYvOIJed3YsBz12nLEwRBK
	 A8zmixdDoSmYbAbxCdbncqfsxOh5dHZhi3XnWaubezymoQZXz8VMHQCTnTsrFBqRCl
	 IkccwrvcUqMcQ==
Date: Mon, 5 May 2025 22:36:54 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	john.g.garry@oracle.com, bmarzins@redhat.com, chaitanyak@nvidia.com,
	shinichiro.kawasaki@wdc.com, brauner@kernel.org,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: Re: [RFC PATCH v4 07/11] fs: statx add write zeroes unmap attribute
Message-ID: <20250506053654.GA25700@frogsfrogsfrogs>
References: <20250421021509.2366003-1-yi.zhang@huaweicloud.com>
 <20250421021509.2366003-8-yi.zhang@huaweicloud.com>
 <20250505132208.GA22182@lst.de>
 <20250505142945.GJ1035866@frogsfrogsfrogs>
 <20250506050239.GA27687@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506050239.GA27687@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250505_223657_411737_4A61ECA4 
X-CRM114-Status: GOOD (  22.98  )
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

On Tue, May 06, 2025 at 07:02:39AM +0200, Christoph Hellwig wrote:
> On Mon, May 05, 2025 at 07:29:45AM -0700, Darrick J. Wong wrote:
> > attributes_mask contains attribute flags known to the filesystem,
> > whereas attributes contains flags actually set on the file.
> > "known_attributes" would have been a better name, but that's water under
> > the bridge. :P
> 
> Oooh.  I think I was very confused at what this patch does, and what
> it does seems confused as well.
> 
> The patch adds a new flag to the STATX_ATTR_* namespace, which
> historically was used for persistent on-disk flags like immutable,
> not the STATX_* namespace where I assumed it, and which has no
> support mask.  Which seems really odd for a pure kernel feature.
> Then again it seems to follow STATX_ATTR_WRITE_ATOMIC which seems
> just as wrongly place unless I'm missing something?

I think STATX_* (i.e. not STATX_ATTR_*) flags have two purposes: 1) to
declare that specific fields in struct statx actually have meaning, most
notably in scenarios where zeroes are valid field contents; and 2) if
filling out the field is expensive, userspace can elect not to have it
filled by leaving the bit unset.  I don't know how userspace is supposed
to figure out which fields are expensive.

STATX_ATTR_* are supposed to be reflect persistent inode state.  I think
STATX_ATTR_WRITE_ATOMIC is a (now unremovable) artifact of the era when
we were going to have a new iflag and feature bit for all the new
forcealign functionality.  For XFS it's not necessary anymore because we
always have software fallback and the statx::atomic_write_* fields being
nonzero is sufficient to detect the functionality.

(I'm confused about the whole premise of /this/ patch -- it's a "fast
zeroing" fallocate flag that causes the *device* to unmap, so that the
filesystem can preallocate and avoid unwritten extent conversions?
What happens if the block device is thinp and it runs out of space?
That seems antithetical to fallocate...)

--D

