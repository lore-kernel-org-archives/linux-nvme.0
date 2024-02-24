Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41DDDC48BF6
	for <linux-nvme@archiver.kernel.org>; Sat, 24 Feb 2024 18:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Subject:Cc:To:
	From:Message-Id:Date:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=luI5LH6pYhZC/Cdk0BZ+N4QrEkQKug3aTK3kXTF38gg=; b=d3zvVcaPJD4Lx5
	dVE7Fb5F9szQFkOH5r0uXrxxmmughDvBRGEPv7DpZ8DtFYmojgDAn9DjfUWVg7WyPuwZLhAw6SDh7
	NufnpJ4PSIjHEExwOSnhh620CvM+Ux5jLzchVw9YR41Qp60nu/AKlvDqBEc3Vy72NU0T6Le8uIZqX
	NVoQbzMszOhf7LBl8qK01xchfXRsxlXWRL5qtPEhDUQzzgy9hO45DoK/JfB/U80IxdOgALo9HYxy9
	qGi57c7kH0pkEKsZt9/7OZyK+xxIVkaXVl1NQBAhpzXb0KIXfWm3/SpHH5X3ju1y1OnaApcijmv3E
	P3x0PRepYrWjL/SXog/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdx3G-0000000DS3f-05Dc;
	Sat, 24 Feb 2024 18:47:10 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdx3D-0000000DS2P-1fAY
	for linux-nvme@lists.infradead.org;
	Sat, 24 Feb 2024 18:47:08 +0000
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6e47a104c2eso1197227b3a.2
        for <linux-nvme@lists.infradead.org>; Sat, 24 Feb 2024 10:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708800424; x=1709405224; darn=lists.infradead.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=luI5LH6pYhZC/Cdk0BZ+N4QrEkQKug3aTK3kXTF38gg=;
        b=Fa+EFifYeC4UdSNOt4kradd78zSNbW02l4K7E+TZom3F4hrxds2JB8gfDCc4G6Oy1w
         ZFMiRrPv92Hz3rxVCPCcx73sMrBCpfxLzKIbXjM5TDzPIMIH5qVvSLOmzV4MIc8Fa8wX
         a9JYpDfxqbqivKjTP/DTyDdh6jkmdY8AX3ereYGQ7zWGTZ4/FD/CkRn1lNudE/j2tol/
         c+8Un97n2pNOhMnBFzp0b0W2lCsEfqCXQDIspjl/cG2Hl2MG8F6WxLlzj31nE0RST1zj
         gykWJkRZS4GZp5eARRCyTnRsS8UFq50gFHTYaWA9ykircBbzkYYDmZmgGUyEjAKNm/bF
         G2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708800424; x=1709405224;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=luI5LH6pYhZC/Cdk0BZ+N4QrEkQKug3aTK3kXTF38gg=;
        b=IfFkWXBpYbVi6JAAXMZVvClWpZ4aCK6FSlkqk2LpZLbZ0lqRzPQwylgOLDPu/1cDca
         Ta9ikRWM4f+p+le3wvk4uQgw4WzV++eqAT2dY9LB+QkpuIFomz/0GCUhwgdSvEOcBGzp
         MbeEi/G/grs8yPj4BFWmnxPGCvb0PoGG5qq/iQ9N3/b4JGctuP5BuJDhuCzUiCQzqBtQ
         pJsjYCp1sb2KvAjNq1ow7xJk+UwUxSxZBSDSuFH1tDD6OWW/IEFzmMAHl5vE6puEZ3QA
         uF6Dr7Y4vLeeTFw0wJLb1O4zuH86Y2w+CW52gQ9FIeQRN3WYpIYz0vk2lg3+rqyMHfrM
         cxXw==
X-Forwarded-Encrypted: i=1; AJvYcCXWb3LFkRtafxK+IOm8p6DqlkCQL+o5YyD6M0JFgmmvTtyJUV4xsCd6ERZBfzGCq1YkIz8WGKdCeAc4XYLmKi2ZDSSzQwtYBmtfHio8xRk=
X-Gm-Message-State: AOJu0Yx0ZXLc5aoOPQ/2o4AlNMn8g0vUXxXwNrm1EczUjeK+Mlr6X7qh
	pavBFLLbaKRB7glyAPd9VHX52QSoWd2zHlA9m88iDH4Q1mwjQkD5
X-Google-Smtp-Source: AGHT+IE2zmchSNyxHArKwWkAWiCM6Fohd8BpReCrvkrKeVbpuW6I59xIUvFAqm+1+7Zh24+ke9Ca/A==
X-Received: by 2002:a05:6a00:5d:b0:6e5:6d2:234b with SMTP id i29-20020a056a00005d00b006e506d2234bmr524354pfk.0.1708800424044;
        Sat, 24 Feb 2024 10:47:04 -0800 (PST)
Received: from dw-tp ([171.76.80.106])
        by smtp.gmail.com with ESMTPSA id r7-20020aa78b87000000b006e48b04d8c0sm1386455pfd.64.2024.02.24.10.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 10:47:03 -0800 (PST)
Date: Sun, 25 Feb 2024 00:16:55 +0530
Message-Id: <87o7c51yzk.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com, jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com, linux-aio@kvack.org, linux-btrfs@vger.kernel.org, io-uring@vger.kernel.org, nilay@linux.ibm.com, Prasad Singamsetty <prasad.singamsetty@oracle.com>, John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v4 04/11] fs: Add initial atomic write support info to statx
In-Reply-To: <20240219130109.341523-5-john.g.garry@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240224_104707_465302_DCBB06A2 
X-CRM114-Status: GOOD (  29.04  )
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

John Garry <john.g.garry@oracle.com> writes:

> From: Prasad Singamsetty <prasad.singamsetty@oracle.com>
>
> Extend statx system call to return additional info for atomic write support
> support for a file.
>
> Helper function generic_fill_statx_atomic_writes() can be used by FSes to
> fill in the relevant statx fields.
>
> Signed-off-by: Prasad Singamsetty <prasad.singamsetty@oracle.com>
> #jpg: relocate bdev support to another patch

^^^ miss maybe?
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/stat.c                 | 34 ++++++++++++++++++++++++++++++++++
>  include/linux/fs.h        |  3 +++
>  include/linux/stat.h      |  3 +++
>  include/uapi/linux/stat.h |  9 ++++++++-
>  4 files changed, 48 insertions(+), 1 deletion(-)
>
> diff --git a/fs/stat.c b/fs/stat.c
> index 77cdc69eb422..522787a4ab6a 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -89,6 +89,37 @@ void generic_fill_statx_attr(struct inode *inode, struct kstat *stat)
>  }
>  EXPORT_SYMBOL(generic_fill_statx_attr);
>  
> +/**
> + * generic_fill_statx_atomic_writes - Fill in the atomic writes statx attributes
> + * @stat:	Where to fill in the attribute flags
> + * @unit_min:	Minimum supported atomic write length
+ * @unit_min:	Minimum supported atomic write length in bytes


> + * @unit_max:	Maximum supported atomic write length
+ * @unit_max:	Maximum supported atomic write length in bytes

mentioning unit of the length might be useful here.

> + *
> + * Fill in the STATX{_ATTR}_WRITE_ATOMIC flags in the kstat structure from
> + * atomic write unit_min and unit_max values.
> + */
> +void generic_fill_statx_atomic_writes(struct kstat *stat,
> +				      unsigned int unit_min,

This (unit_min) can still go above in the same line.

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

Please log info about this in commit message about where this limit came
from? Is it since we only support ubuf (which IIUC, only supports 1
segment)? Later when we will add support for iovec, this limit can be
lifted?

> +
> +		/* Confirm atomic writes are actually supported */
> +		stat->attributes |= STATX_ATTR_WRITE_ATOMIC;
> +	}
> +}
> +EXPORT_SYMBOL(generic_fill_statx_atomic_writes);
> +
>  /**
>   * vfs_getattr_nosec - getattr without security checks
>   * @path: file to get attributes from
> @@ -658,6 +689,9 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
>  	tmp.stx_mnt_id = stat->mnt_id;
>  	tmp.stx_dio_mem_align = stat->dio_mem_align;
>  	tmp.stx_dio_offset_align = stat->dio_offset_align;
> +	tmp.stx_atomic_write_unit_min = stat->atomic_write_unit_min;
> +	tmp.stx_atomic_write_unit_max = stat->atomic_write_unit_max;
> +	tmp.stx_atomic_write_segments_max = stat->atomic_write_segments_max;
>  
>  	return copy_to_user(buffer, &tmp, sizeof(tmp)) ? -EFAULT : 0;
>  }
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 7271640fd600..531140a7e27a 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3167,6 +3167,9 @@ extern const struct inode_operations page_symlink_inode_operations;
>  extern void kfree_link(void *);
>  void generic_fillattr(struct mnt_idmap *, u32, struct inode *, struct kstat *);
>  void generic_fill_statx_attr(struct inode *inode, struct kstat *stat);
> +void generic_fill_statx_atomic_writes(struct kstat *stat,
> +				      unsigned int unit_min,
> +				      unsigned int unit_max);

We can make 80 col. width even with unit_min in the same first line as of *stat.


>  extern int vfs_getattr_nosec(const struct path *, struct kstat *, u32, unsigned int);
>  extern int vfs_getattr(const struct path *, struct kstat *, u32, unsigned int);
>  void __inode_add_bytes(struct inode *inode, loff_t bytes);
> diff --git a/include/linux/stat.h b/include/linux/stat.h
> index 52150570d37a..2c5e2b8c6559 100644
> --- a/include/linux/stat.h
> +++ b/include/linux/stat.h
> @@ -53,6 +53,9 @@ struct kstat {
>  	u32		dio_mem_align;
>  	u32		dio_offset_align;
>  	u64		change_cookie;
> +	u32		atomic_write_unit_min;
> +	u32		atomic_write_unit_max;
> +	u32		atomic_write_segments_max;
>  };
>  
>  /* These definitions are internal to the kernel for now. Mainly used by nfsd. */
> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> index 2f2ee82d5517..c0e8e10d1de6 100644
> --- a/include/uapi/linux/stat.h
> +++ b/include/uapi/linux/stat.h
> @@ -127,7 +127,12 @@ struct statx {
>  	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
>  	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O */
>  	/* 0xa0 */
> -	__u64	__spare3[12];	/* Spare space for future expansion */
> +	__u32	stx_atomic_write_unit_min;
> +	__u32	stx_atomic_write_unit_max;
> +	__u32   stx_atomic_write_segments_max;

Let's add one liner for each of these fields similar to how it was done
for others?

/* Minimum supported atomic write length in bytes */
/* Maximum supported atomic write length in bytes */
/* Maximum no. of segments (iovecs?) supported for atomic write */


> +	__u32   __spare1;
> +	/* 0xb0 */
> +	__u64	__spare3[10];	/* Spare space for future expansion */
>  	/* 0x100 */
>  };
>  
> @@ -155,6 +160,7 @@ struct statx {
>  #define STATX_MNT_ID		0x00001000U	/* Got stx_mnt_id */
>  #define STATX_DIOALIGN		0x00002000U	/* Want/got direct I/O alignment info */
>  #define STATX_MNT_ID_UNIQUE	0x00004000U	/* Want/got extended stx_mount_id */
> +#define STATX_WRITE_ATOMIC	0x00008000U	/* Want/got atomic_write_* fields */
>  
>  #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
>  
> @@ -190,6 +196,7 @@ struct statx {
>  #define STATX_ATTR_MOUNT_ROOT		0x00002000 /* Root of a mount */
>  #define STATX_ATTR_VERITY		0x00100000 /* [I] Verity protected file */
>  #define STATX_ATTR_DAX			0x00200000 /* File is currently in DAX state */
> +#define STATX_ATTR_WRITE_ATOMIC		0x00400000 /* File supports atomic write operations */
>  
>  
>  #endif /* _UAPI_LINUX_STAT_H */
> -- 
> 2.31.1

