Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82924C27C75
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jun 2024 14:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ABD+LT0o8LnPHcYZSXs2MrPxadO4r+QqHvWZGp1tmZw=; b=VxG1NREvZzGZjAwwD+eCvSkyrB
	Fj9hcY0UdW7pvEaWBRMNJe7QYIqOLCpbxThbQbfTtGcswMG/m6Nh5JU1dkq5UYj53sy+V/0JFgaG9
	ujibwzQ+DzOABgxNSR28C9GpHDD4emyVqPIGWZc/I93rhTBFafgEmUjlhY2Rhcm3cpiUhgHx3+7vv
	hSowHl5yk8GS80/Z5AAA7UnFiUIk1y2LIDMIbhlLVqVPqL0/X933DgS3mCDM5wBderKG8UvinZQBS
	Jmbul+Slw5e5JdWhwfwlMDZoGNW+nroQnWyFqMS9+b6YaBS0chcQXhtFA8eBKmV/sV0LMs98k8VkY
	ejrG2E5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHl6O-0000000GsfB-21uj;
	Thu, 13 Jun 2024 14:06:56 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHUzN-0000000E6HC-3jwT
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jun 2024 20:54:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 59DD0CE22D5;
	Wed, 12 Jun 2024 20:54:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84FBC4AF49;
	Wed, 12 Jun 2024 20:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718225674;
	bh=tVILRNA+10i0hkRlIosgMNPqnHFXimug2joZuxy2YOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gxrF7MM2z/1SfSzr34rFnbmtOilWN+UeGZ8ImffgHGY+OhlEfVW6JYpUxuBPyVKG7
	 aeVuxyoSIZ8qUjXxwU75rxdiXJ8LHD3mlo3JtyVhbMCfLygoeDcGb4VQhzaI+bzRrP
	 K8IVMlII/kxMi1wWF31ok9wO3s07nTjdiVpEUtUeODjpo0jIg3cphCVv4dOQeOeQMc
	 4R/as280MGUrbk3OfNRR1aloN9IVBFaAEjaSGybqZS3QhRWC45sjfz+wZE3i5HE2lO
	 gwWl14Nn1BmZ5xtAG5SYeDP3MESNrtbe78j/1YpnmHQqIgLSfGv3AW5+g5Sqo3pSVj
	 mXKci5CJ1cozQ==
Date: Wed, 12 Jun 2024 13:54:33 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com,
	linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
	io-uring@vger.kernel.org, nilay@linux.ibm.com,
	ritesh.list@gmail.com, willy@infradead.org, agk@redhat.com,
	snitzer@kernel.org, mpatocka@redhat.com, dm-devel@lists.linux.dev,
	hare@suse.de, Prasad Singamsetty <prasad.singamsetty@oracle.com>
Subject: Re: [PATCH v8 04/10] fs: Add initial atomic write support info to
 statx
Message-ID: <20240612205433.GC2764780@frogsfrogsfrogs>
References: <20240610104329.3555488-1-john.g.garry@oracle.com>
 <20240610104329.3555488-5-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610104329.3555488-5-john.g.garry@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240612_135438_707329_DED63D8F 
X-CRM114-Status: GOOD (  28.61  )
X-Mailman-Approved-At: Thu, 13 Jun 2024 07:06:53 -0700
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

On Mon, Jun 10, 2024 at 10:43:23AM +0000, John Garry wrote:
> From: Prasad Singamsetty <prasad.singamsetty@oracle.com>
> 
> Extend statx system call to return additional info for atomic write support
> support for a file.
> 
> Helper function generic_fill_statx_atomic_writes() can be used by FSes to
> fill in the relevant statx fields. For now atomic_write_segments_max will
> always be 1, otherwise some rules would need to be imposed on iovec length
> and alignment, which we don't want now.
> 
> Signed-off-by: Prasad Singamsetty <prasad.singamsetty@oracle.com>
> jpg: relocate bdev support to another patch
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Looks fine to me, assuming there's a manpage update lurking somewhere?
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/stat.c                 | 34 ++++++++++++++++++++++++++++++++++
>  include/linux/fs.h        |  3 +++
>  include/linux/stat.h      |  3 +++
>  include/uapi/linux/stat.h | 12 ++++++++++--
>  4 files changed, 50 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/stat.c b/fs/stat.c
> index 70bd3e888cfa..72d0e6357b91 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -89,6 +89,37 @@ void generic_fill_statx_attr(struct inode *inode, struct kstat *stat)
>  }
>  EXPORT_SYMBOL(generic_fill_statx_attr);
>  
> +/**
> + * generic_fill_statx_atomic_writes - Fill in atomic writes statx attributes
> + * @stat:	Where to fill in the attribute flags
> + * @unit_min:	Minimum supported atomic write length in bytes
> + * @unit_max:	Maximum supported atomic write length in bytes
> + *
> + * Fill in the STATX{_ATTR}_WRITE_ATOMIC flags in the kstat structure from
> + * atomic write unit_min and unit_max values.
> + */
> +void generic_fill_statx_atomic_writes(struct kstat *stat,
> +				      unsigned int unit_min,
> +				      unsigned int unit_max)
> +{
> +	/* Confirm that the request type is known */
> +	stat->result_mask |= STATX_WRITE_ATOMIC;
> +
> +	/* Confirm that the file attribute type is known */
> +	stat->attributes_mask |= STATX_ATTR_WRITE_ATOMIC;
> +
> +	if (unit_min) {
> +		stat->atomic_write_unit_min = unit_min;
> +		stat->atomic_write_unit_max = unit_max;
> +		/* Initially only allow 1x segment */
> +		stat->atomic_write_segments_max = 1;
> +
> +		/* Confirm atomic writes are actually supported */
> +		stat->attributes |= STATX_ATTR_WRITE_ATOMIC;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(generic_fill_statx_atomic_writes);
> +
>  /**
>   * vfs_getattr_nosec - getattr without security checks
>   * @path: file to get attributes from
> @@ -659,6 +690,9 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
>  	tmp.stx_dio_mem_align = stat->dio_mem_align;
>  	tmp.stx_dio_offset_align = stat->dio_offset_align;
>  	tmp.stx_subvol = stat->subvol;
> +	tmp.stx_atomic_write_unit_min = stat->atomic_write_unit_min;
> +	tmp.stx_atomic_write_unit_max = stat->atomic_write_unit_max;
> +	tmp.stx_atomic_write_segments_max = stat->atomic_write_segments_max;
>  
>  	return copy_to_user(buffer, &tmp, sizeof(tmp)) ? -EFAULT : 0;
>  }
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index e049414bef7d..db26b4a70c62 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3235,6 +3235,9 @@ extern const struct inode_operations page_symlink_inode_operations;
>  extern void kfree_link(void *);
>  void generic_fillattr(struct mnt_idmap *, u32, struct inode *, struct kstat *);
>  void generic_fill_statx_attr(struct inode *inode, struct kstat *stat);
> +void generic_fill_statx_atomic_writes(struct kstat *stat,
> +				      unsigned int unit_min,
> +				      unsigned int unit_max);
>  extern int vfs_getattr_nosec(const struct path *, struct kstat *, u32, unsigned int);
>  extern int vfs_getattr(const struct path *, struct kstat *, u32, unsigned int);
>  void __inode_add_bytes(struct inode *inode, loff_t bytes);
> diff --git a/include/linux/stat.h b/include/linux/stat.h
> index bf92441dbad2..3d900c86981c 100644
> --- a/include/linux/stat.h
> +++ b/include/linux/stat.h
> @@ -54,6 +54,9 @@ struct kstat {
>  	u32		dio_offset_align;
>  	u64		change_cookie;
>  	u64		subvol;
> +	u32		atomic_write_unit_min;
> +	u32		atomic_write_unit_max;
> +	u32		atomic_write_segments_max;
>  };
>  
>  /* These definitions are internal to the kernel for now. Mainly used by nfsd. */
> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> index 67626d535316..887a25286441 100644
> --- a/include/uapi/linux/stat.h
> +++ b/include/uapi/linux/stat.h
> @@ -126,9 +126,15 @@ struct statx {
>  	__u64	stx_mnt_id;
>  	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
>  	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O */
> -	__u64	stx_subvol;	/* Subvolume identifier */
>  	/* 0xa0 */
> -	__u64	__spare3[11];	/* Spare space for future expansion */
> +	__u64	stx_subvol;	/* Subvolume identifier */
> +	__u32	stx_atomic_write_unit_min;	/* Min atomic write unit in bytes */
> +	__u32	stx_atomic_write_unit_max;	/* Max atomic write unit in bytes */
> +	/* 0xb0 */
> +	__u32   stx_atomic_write_segments_max;	/* Max atomic write segment count */
> +	__u32   __spare1[1];
> +	/* 0xb8 */
> +	__u64	__spare3[9];	/* Spare space for future expansion */
>  	/* 0x100 */
>  };
>  
> @@ -157,6 +163,7 @@ struct statx {
>  #define STATX_DIOALIGN		0x00002000U	/* Want/got direct I/O alignment info */
>  #define STATX_MNT_ID_UNIQUE	0x00004000U	/* Want/got extended stx_mount_id */
>  #define STATX_SUBVOL		0x00008000U	/* Want/got stx_subvol */
> +#define STATX_WRITE_ATOMIC	0x00010000U	/* Want/got atomic_write_* fields */
>  
>  #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
>  
> @@ -192,6 +199,7 @@ struct statx {
>  #define STATX_ATTR_MOUNT_ROOT		0x00002000 /* Root of a mount */
>  #define STATX_ATTR_VERITY		0x00100000 /* [I] Verity protected file */
>  #define STATX_ATTR_DAX			0x00200000 /* File is currently in DAX state */
> +#define STATX_ATTR_WRITE_ATOMIC		0x00400000 /* File supports atomic write operations */
>  
>  
>  #endif /* _UAPI_LINUX_STAT_H */
> -- 
> 2.31.1
> 
> 

