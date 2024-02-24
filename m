Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D09C48BF6
	for <linux-nvme@archiver.kernel.org>; Sat, 24 Feb 2024 18:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Subject:Cc:To:
	From:Message-Id:Date:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=wnu+Meyv/9BP7YNzzpJcTuolqRDU8rmnNUjfmWPj+9A=; b=aFP1hM6VgyYxyw
	BiCEENL6ocJgzfPftkHDbCAQH+i+/D4G9UIRuTh5DI0MqLnUpe+jNpvQBPO2yLa1ElAxmYa3S4TVH
	xspKjkagITPnutqGMTGg+zFyuro5pwuncOV2Dxw1q3cTR8OT5a0y5MD1UtSClaTnRjIEDPirBNiJh
	4DdGWfKpRab+nvAiOedFDHH4/15aZ8W7WKEY3aYesOoJ8/Z6x9zpOHf7ss3oIlwxpFETRxQCBN3IM
	F+dQcmxE/EyUB0I6QOZeO6NN2qxV0cc8qyof9ywnBTb/c4hmFWsBy7zSDFgbmcg53n56uiXFdocZu
	6bn6j5dDN12nbTSmeDHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdwZf-0000000DPQh-0J6o;
	Sat, 24 Feb 2024 18:16:35 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdwZc-0000000DPQ1-0RqT
	for linux-nvme@lists.infradead.org;
	Sat, 24 Feb 2024 18:16:33 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d911c2103aso8764305ad.0
        for <linux-nvme@lists.infradead.org>; Sat, 24 Feb 2024 10:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708798589; x=1709403389; darn=lists.infradead.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wnu+Meyv/9BP7YNzzpJcTuolqRDU8rmnNUjfmWPj+9A=;
        b=b/EU91eMyc2dTeHciweobzLJaEZeEaVMMzy319/NpiizAEDDH12FLv0Zl9LhRES46N
         fk+V6V6N45K49fWvTvVPV5OEUJrSghbFZl4lBPpWx/FXWQIhLieR7zI48zOHIaLFo87z
         8AhLoTGX+xoHR1siZ0rcRDtCqTOAL/5iqTg14IeMHI3CpQ+0gHl6fXejqOaXSKlzTkWs
         I9HqowwTKLJ3FFEt2Eau720ADyOWvaNZrKzg0DvdpABHYZSLrwv4MnSzm+Tc8RitZ8LJ
         V4tnlC8GzgCepJm74+oJdtARSLuI3U0i8knRSkiDxmlR4EvqmB6C7rt3ibabbVfXndH0
         DJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708798589; x=1709403389;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wnu+Meyv/9BP7YNzzpJcTuolqRDU8rmnNUjfmWPj+9A=;
        b=Y5UbAh4c67HB1HRwJRw3Pp7mM/zMOmE3czayrq677Z08ivailFvhnk9lh5cXqjGGVV
         RvAtQVX4xAzFzTBS3KqRhvIRJVO6OzXCt9YsEr5D1Zk2VaxiDNtCYW4HKdim9JngHswL
         DAnYcOCw/LlQH3JQC9UMCi6fLOJgyvKJi6QaZa19mpKo7YLx2ZdVKqACLGI0H3lrgwaj
         EL93PNyrcwpLr3L7kA/9mFKidrCZjDV7wPE7BAC0h/TxgvuEpjK1T0D7HvSAuHiaMuaK
         xdXUb9D9TJjzTiX9DOuhqNKMK+Tvt9/R+aw3NEWlKKSVnMH9motT+YmmNAB/d18t6hld
         koRA==
X-Forwarded-Encrypted: i=1; AJvYcCXubZotdfXVrJTUEYZXvu99165oAQ/7iHvoZJcIS8Rz5h85hLsFRf2JsUJR43TnlIW1nxHHSGrWcDj/cBhuEW4zeYFsb60vVV5DycG82EM=
X-Gm-Message-State: AOJu0YwW75WYgRgPZNgbxZVdt7kE7E2TE4TdvOt+rSRR6rMyq6eHDJ58
	hWr5Za1spCpxZ8HI5kigGtuNgHXu1t6vQ3M01NUeatOlq7sKRfDN
X-Google-Smtp-Source: AGHT+IEhIRn378wt+gFfTyZVVHdy0OnAOhjAUqJcKoAdAEpOzjhracPgpW4cwIY9SoPSruGG3Ym2nQ==
X-Received: by 2002:a17:902:d891:b0:1dc:6fec:15d8 with SMTP id b17-20020a170902d89100b001dc6fec15d8mr2875267plz.47.1708798589107;
        Sat, 24 Feb 2024 10:16:29 -0800 (PST)
Received: from dw-tp ([171.76.80.106])
        by smtp.gmail.com with ESMTPSA id ci7-20020a17090afc8700b0029996fd70e2sm1511031pjb.45.2024.02.24.10.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 10:16:28 -0800 (PST)
Date: Sat, 24 Feb 2024 23:46:19 +0530
Message-Id: <87v86d20ek.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com, jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com, linux-aio@kvack.org, linux-btrfs@vger.kernel.org, io-uring@vger.kernel.org, nilay@linux.ibm.com, Prasad Singamsetty <prasad.singamsetty@oracle.com>, John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v4 03/11] fs: Initial atomic write support
In-Reply-To: <20240219130109.341523-4-john.g.garry@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240224_101632_178318_2C9A4631 
X-CRM114-Status: GOOD (  38.29  )
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
> An atomic write is a write issued with torn-write protection, meaning
> that for a power failure or any other hardware failure, all or none of the
> data from the write will be stored, but never a mix of old and new data.
>
> Userspace may add flag RWF_ATOMIC to pwritev2() to indicate that the
> write is to be issued with torn-write prevention, according to special
> alignment and length rules.
>
> For any syscall interface utilizing struct iocb, add IOCB_ATOMIC for
> iocb->ki_flags field to indicate the same.
>
> A call to statx will give the relevant atomic write info for a file:
> - atomic_write_unit_min
> - atomic_write_unit_max
> - atomic_write_segments_max
>
> Both min and max values must be a power-of-2.
>
> Applications can avail of atomic write feature by ensuring that the total
> length of a write is a power-of-2 in size and also sized between
> atomic_write_unit_min and atomic_write_unit_max, inclusive. Applications
> must ensure that the write is at a naturally-aligned offset in the file
> wrt the total write length. The value in atomic_write_segments_max
> indicates the upper limit for IOV_ITER iovcnt.
>
> Add file mode flag FMODE_CAN_ATOMIC_WRITE, so files which do not have the
> flag set will have RWF_ATOMIC rejected and not just ignored.
>
> Add a type argument to kiocb_set_rw_flags() to allows reads which have
> RWF_ATOMIC set to be rejected.
>
> Helper function atomic_write_valid() can be used by FSes to verify
> compliant writes.
>
> Signed-off-by: Prasad Singamsetty <prasad.singamsetty@oracle.com>
> #jpg: merge into single patch and much rewrite

^^^ this might be a miss I guess.

> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/aio.c                |  8 ++++----
>  fs/btrfs/ioctl.c        |  2 +-
>  fs/read_write.c         |  2 +-
>  include/linux/fs.h      | 36 +++++++++++++++++++++++++++++++++++-
>  include/uapi/linux/fs.h |  5 ++++-
>  io_uring/rw.c           |  4 ++--
>  6 files changed, 47 insertions(+), 10 deletions(-)
>
> diff --git a/fs/aio.c b/fs/aio.c
> index bb2ff48991f3..21bcbc076fd0 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -1502,7 +1502,7 @@ static void aio_complete_rw(struct kiocb *kiocb, long res)
>  	iocb_put(iocb);
>  }
>  
> -static int aio_prep_rw(struct kiocb *req, const struct iocb *iocb)
> +static int aio_prep_rw(struct kiocb *req, const struct iocb *iocb, int type)

maybe rw_type?

>  {
>  	int ret;
>  
> @@ -1528,7 +1528,7 @@ static int aio_prep_rw(struct kiocb *req, const struct iocb *iocb)
>  	} else
>  		req->ki_ioprio = get_current_ioprio();
>  
> -	ret = kiocb_set_rw_flags(req, iocb->aio_rw_flags);
> +	ret = kiocb_set_rw_flags(req, iocb->aio_rw_flags, type);
>  	if (unlikely(ret))
>  		return ret;
>  
> @@ -1580,7 +1580,7 @@ static int aio_read(struct kiocb *req, const struct iocb *iocb,
>  	struct file *file;
>  	int ret;
>  
> -	ret = aio_prep_rw(req, iocb);
> +	ret = aio_prep_rw(req, iocb, READ);
>  	if (ret)
>  		return ret;
>  	file = req->ki_filp;
> @@ -1607,7 +1607,7 @@ static int aio_write(struct kiocb *req, const struct iocb *iocb,
>  	struct file *file;
>  	int ret;
>  
> -	ret = aio_prep_rw(req, iocb);
> +	ret = aio_prep_rw(req, iocb, WRITE);
>  	if (ret)
>  		return ret;
>  	file = req->ki_filp;
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index ac3316e0d11c..455f06d94b11 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -4555,7 +4555,7 @@ static int btrfs_ioctl_encoded_write(struct file *file, void __user *argp, bool
>  		goto out_iov;
>  
>  	init_sync_kiocb(&kiocb, file);
> -	ret = kiocb_set_rw_flags(&kiocb, 0);
> +	ret = kiocb_set_rw_flags(&kiocb, 0, WRITE);
>  	if (ret)
>  		goto out_iov;
>  	kiocb.ki_pos = pos;
> diff --git a/fs/read_write.c b/fs/read_write.c
> index d4c036e82b6c..a7dc1819192d 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -730,7 +730,7 @@ static ssize_t do_iter_readv_writev(struct file *filp, struct iov_iter *iter,
>  	ssize_t ret;
>  
>  	init_sync_kiocb(&kiocb, filp);
> -	ret = kiocb_set_rw_flags(&kiocb, flags);
> +	ret = kiocb_set_rw_flags(&kiocb, flags, type);
>  	if (ret)
>  		return ret;
>  	kiocb.ki_pos = (ppos ? *ppos : 0);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 023f37c60709..7271640fd600 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -43,6 +43,7 @@
>  #include <linux/cred.h>
>  #include <linux/mnt_idmapping.h>
>  #include <linux/slab.h>
> +#include <linux/uio.h>
>  
>  #include <asm/byteorder.h>
>  #include <uapi/linux/fs.h>
> @@ -119,6 +120,10 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
>  #define FMODE_PWRITE		((__force fmode_t)0x10)
>  /* File is opened for execution with sys_execve / sys_uselib */
>  #define FMODE_EXEC		((__force fmode_t)0x20)
> +
> +/* File supports atomic writes */
> +#define FMODE_CAN_ATOMIC_WRITE	((__force fmode_t)0x40)
> +
>  /* 32bit hashes as llseek() offset (for directories) */
>  #define FMODE_32BITHASH         ((__force fmode_t)0x200)
>  /* 64bit hashes as llseek() offset (for directories) */
> @@ -328,6 +333,7 @@ enum rw_hint {
>  #define IOCB_SYNC		(__force int) RWF_SYNC
>  #define IOCB_NOWAIT		(__force int) RWF_NOWAIT
>  #define IOCB_APPEND		(__force int) RWF_APPEND
> +#define IOCB_ATOMIC		(__force int) RWF_ATOMIC
>  

You might also want to add this definition in here too

#define TRACE_IOCB_STRINGS \
<...>
<...>
{ IOCB_ATOMIC, "ATOMIC" }


>  /* non-RWF related bits - start at 16 */
>  #define IOCB_EVENTFD		(1 << 16)
> @@ -3321,7 +3327,7 @@ static inline int iocb_flags(struct file *file)
>  	return res;
>  }
>  
> -static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
> +static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags, int type)

maybe rw_type? 

>  {
>  	int kiocb_flags = 0;
>  
> @@ -3338,6 +3344,12 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
>  			return -EOPNOTSUPP;
>  		kiocb_flags |= IOCB_NOIO;
>  	}
> +	if (flags & RWF_ATOMIC) {
> +		if (type == READ)
> +			return -EOPNOTSUPP;
> +		if (!(ki->ki_filp->f_mode & FMODE_CAN_ATOMIC_WRITE))
> +			return -EOPNOTSUPP;
> +	}
>  	kiocb_flags |= (__force int) (flags & RWF_SUPPORTED);
>  	if (flags & RWF_SYNC)
>  		kiocb_flags |= IOCB_DSYNC;
> @@ -3523,4 +3535,26 @@ extern int vfs_fadvise(struct file *file, loff_t offset, loff_t len,
>  extern int generic_fadvise(struct file *file, loff_t offset, loff_t len,
>  			   int advice);
>  
> +static inline bool atomic_write_valid(loff_t pos, struct iov_iter *iter,
> +			   unsigned int unit_min, unsigned int unit_max)
> +{
> +	size_t len = iov_iter_count(iter);
> +
> +	if (!iter_is_ubuf(iter))
> +		return false;

There is no mention about this limitation in the commit message of this
patch. Maybe it will be good to capture why this limitation to only
support ubuf and/or any plans to lift this restriction in future
in the commit message?


> +
> +	if (len == unit_min || len == unit_max) {
> +		/* ok if exactly min or max */
> +	} else if (len < unit_min || len > unit_max) {
> +		return false;
> +	} else if (!is_power_of_2(len)) {
> +		return false;
> +	}

Checking for len == unit_min || len == unit_max is redundant when
unit_min and unit_max are already power of 2.


> +
> +	if (pos & (len - 1))
> +		return false;
> +
> +	return true;
> +}
> +
>  #endif /* _LINUX_FS_H */
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 48ad69f7722e..a0975ae81e64 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -301,9 +301,12 @@ typedef int __bitwise __kernel_rwf_t;
>  /* per-IO O_APPEND */
>  #define RWF_APPEND	((__force __kernel_rwf_t)0x00000010)
>  
> +/* Atomic Write */
> +#define RWF_ATOMIC	((__force __kernel_rwf_t)0x00000040)
> +
>  /* mask of flags supported by the kernel */
>  #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
> -			 RWF_APPEND)
> +			 RWF_APPEND | RWF_ATOMIC)
>  
>  /* Pagemap ioctl */
>  #define PAGEMAP_SCAN	_IOWR('f', 16, struct pm_scan_arg)
> diff --git a/io_uring/rw.c b/io_uring/rw.c
> index d5e79d9bdc71..f8c022301cf4 100644
> --- a/io_uring/rw.c
> +++ b/io_uring/rw.c
> @@ -719,7 +719,7 @@ static int io_rw_init_file(struct io_kiocb *req, fmode_t mode)
>  	struct kiocb *kiocb = &rw->kiocb;
>  	struct io_ring_ctx *ctx = req->ctx;
>  	struct file *file = req->file;
> -	int ret;
> +	int ret, type = (mode == FMODE_WRITE) ? WRITE : READ;
>  
>  	if (unlikely(!file || !(file->f_mode & mode)))
>  		return -EBADF;
> @@ -728,7 +728,7 @@ static int io_rw_init_file(struct io_kiocb *req, fmode_t mode)
>  		req->flags |= io_file_get_flags(file);
>  
>  	kiocb->ki_flags = file->f_iocb_flags;
> -	ret = kiocb_set_rw_flags(kiocb, rw->flags);
> +	ret = kiocb_set_rw_flags(kiocb, rw->flags, type);
>  	if (unlikely(ret))
>  		return ret;
>  	kiocb->ki_flags |= IOCB_ALLOC_CACHE;
> -- 
> 2.31.1

