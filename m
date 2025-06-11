Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4675BC71136
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jun 2025 19:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TY2DnmJAjRapSRYV/ncNE2zouegsL58+IauvSxHqi2s=; b=OU4+qOf2xcmURae+x+6AsEFIBf
	wF2Jo9h+9USS12gTwY+G/NoQPZEYEAuJ1YbOJkYR8Z8dnDB58MIP6ZrtmZUw3aDwWddMey5emCFCM
	9UlnkAWYF7KDDzBqjjQ3nBymr0O8jCNkzdFfXXfWUZn3AR2CfVoN31Ry2pETNHa3Nl7Pj6mNvtBq0
	JiFPpjWoZCDPtxPxiqHODE1QdyPDryZLx5+/gtRN0YebRiu2t1Fv7PzYU7AFOCLrhUDU5E/fAH7cv
	GwJvZMDVmiu/lsGplSYZx/EYOAH3l2JBuyv2fAltczfVZTa86RxMSjBXYodBFEfowY+Bm7pKxF+ea
	O2Q6NkkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPRWU-0000000B1K4-3R66;
	Wed, 11 Jun 2025 19:54:10 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPN1Z-0000000AKJ9-289t
	for linux-nvme@lists.infradead.org;
	Wed, 11 Jun 2025 15:05:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 763A45C24D9;
	Wed, 11 Jun 2025 15:03:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF97EC4CEE3;
	Wed, 11 Jun 2025 15:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749654355;
	bh=nXn//9wEDz612qpwUp8e5GEyUKA50kkwM4h/bE6ZsuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q09gTN7JEA9p4RLFDHZ4C0xd3qOt0xR+cuu6CEvOs3oeO1rgndK/SFluuYHxpBwiL
	 pcrJUktzodkyPGdCmioD3Pn+DGNwZw7t8x7x2D0qcxhP98WSlrEXXDrl7ncRliIhTv
	 i4B1LttaTfBZZFx7yGC/ufWAgQofppsA7SN8MiAQIPngifAuoyFFbczwovXdJeehdI
	 4OJt2ThjrKPM/ptQuox2H9n/ZSCCZ39v0wavG5UYR+eo8fL5G9z0B1cJtSFNF0XXL9
	 lNIgvxMVexROrysgq8wf/C4BYLcPSK2fCrvofoN4KX+z/6+s8eFIPH4pHF4mqI6jr0
	 gYUgZDM+G7c/Q==
Date: Wed, 11 Jun 2025 08:05:55 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de,
	tytso@mit.edu, john.g.garry@oracle.com, bmarzins@redhat.com,
	chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com,
	brauner@kernel.org, martin.petersen@oracle.com, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH 07/10] fs: introduce FALLOC_FL_WRITE_ZEROES to fallocate
Message-ID: <20250611150555.GB6134@frogsfrogsfrogs>
References: <20250604020850.1304633-1-yi.zhang@huaweicloud.com>
 <20250604020850.1304633-8-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604020850.1304633-8-yi.zhang@huaweicloud.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250611_080557_627277_9598C2E8 
X-CRM114-Status: GOOD (  39.11  )
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

[cc linux-api about a fallocate uapi change]

On Wed, Jun 04, 2025 at 10:08:47AM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> With the development of flash-based storage devices, we can quickly
> write zeros to SSDs using the WRITE_ZERO command if the devices do not
> actually write physical zeroes to the media. Therefore, we can use this
> command to quickly preallocate a real all-zero file with written
> extents. This approach should be beneficial for subsequent pure
> overwriting within this file, as it can save on block allocation and,
> consequently, significant metadata changes, which should greatly improve
> overwrite performance on certain filesystems.
> 
> Therefore, introduce a new operation FALLOC_FL_WRITE_ZEROES to
> fallocate. This flag is used to convert a specified range of a file to
> zeros by issuing a zeroing operation. Blocks should be allocated for the
> regions that span holes in the file, and the entire range is converted
> to written extents. If the underlying device supports the actual offload
> write zeroes command, the process of zeroing out operation can be
> accelerated. If it does not, we currently don't prevent the file system
> from writing actual zeros to the device. This provides users with a new
> method to quickly generate a zeroed file, users no longer need to write
> zero data to create a file with written extents.
> 
> Users can determine whether a disk supports the unmap write zeroes
> operation through querying this sysfs interface:
> 
>     /sys/block/<disk>/queue/write_zeroes_unmap
> 
> Finally, this flag cannot be specified in conjunction with the
> FALLOC_FL_KEEP_SIZE since allocating written extents beyond file EOF is
> not permitted. In addition, filesystems that always require out-of-place
> writes should not support this flag since they still need to allocated
> new blocks during subsequent overwrites.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/open.c                   |  1 +
>  include/linux/falloc.h      |  3 ++-
>  include/uapi/linux/falloc.h | 18 ++++++++++++++++++
>  3 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/open.c b/fs/open.c
> index 7828234a7caa..b777e11e5522 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -281,6 +281,7 @@ int vfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>  		break;
>  	case FALLOC_FL_COLLAPSE_RANGE:
>  	case FALLOC_FL_INSERT_RANGE:
> +	case FALLOC_FL_WRITE_ZEROES:
>  		if (mode & FALLOC_FL_KEEP_SIZE)
>  			return -EOPNOTSUPP;
>  		break;
> diff --git a/include/linux/falloc.h b/include/linux/falloc.h
> index 3f49f3df6af5..7c38c6b76b60 100644
> --- a/include/linux/falloc.h
> +++ b/include/linux/falloc.h
> @@ -36,7 +36,8 @@ struct space_resv {
>  				 FALLOC_FL_COLLAPSE_RANGE |	\
>  				 FALLOC_FL_ZERO_RANGE |		\
>  				 FALLOC_FL_INSERT_RANGE |	\
> -				 FALLOC_FL_UNSHARE_RANGE)
> +				 FALLOC_FL_UNSHARE_RANGE |	\
> +				 FALLOC_FL_WRITE_ZEROES)
>  
>  /* on ia32 l_start is on a 32-bit boundary */
>  #if defined(CONFIG_X86_64)
> diff --git a/include/uapi/linux/falloc.h b/include/uapi/linux/falloc.h
> index 5810371ed72b..265aae7ff8c1 100644
> --- a/include/uapi/linux/falloc.h
> +++ b/include/uapi/linux/falloc.h
> @@ -78,4 +78,22 @@
>   */
>  #define FALLOC_FL_UNSHARE_RANGE		0x40
>  
> +/*
> + * FALLOC_FL_WRITE_ZEROES is used to convert a specified range of a file to
> + * zeros by issuing a zeroing operation. Blocks should be allocated for the
> + * regions that span holes in the file, and the entire range is converted to
> + * written extents.

I think you could simplify this a bit by talking only about the end
state after a successful call:

"FALLOC_FL_WRITE_ZEROES zeroes a specified file range in such a way that
subsequent writes to that range do not require further changes to file
mapping metadata."

Note that we don't say how the filesystem gets to this goal.  Presumably
the first implementations will send a zeroing operation to the block
device during allocation and the fs will create written mappings, but
there are other ways to get there -- a filesystem could maintain a pool
of pre-zeroed space and hand those out; or it could zero space on
freeing and mounting such that all new mappings can be created as
written even without the block device zeroing operation.

Or you could be running on some carefully engineered system where you
know the storage will always be zeroed at allocation time due to some
other aspect of the system design, e.g. a single-use throwaway cloud vm
where you allocate to the end of the disk and reboot the node.

> + *                  This flag is beneficial for subsequent pure overwriting
> + * within this range, as it can save on block allocation and, consequently,
> + * significant metadata changes. Therefore, filesystems that always require
> + * out-of-place writes should not support this flag.
> + *
> + * Different filesystems may implement different limitations on the
> + * granularity of the zeroing operation. Most will preferably be accelerated
> + * by submitting write zeroes command if the backing storage supports, which
> + * may not physically write zeros to the media.
> + *
> + * This flag cannot be specified in conjunction with the FALLOC_FL_KEEP_SIZE.
> + */
> +#define FALLOC_FL_WRITE_ZEROES		0x80

The rest of the writeup seems fine to me.

--D

> +
>  #endif /* _UAPI_FALLOC_H_ */
> -- 
> 2.46.1
> 
> 

