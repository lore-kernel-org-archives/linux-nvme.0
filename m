Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C4FDC54798
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Feb 2024 14:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Subject:Cc:To:
	From:Message-Id:Date:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=JpmlBduLOtP9Y7HibP2DDg1Ww/fxHjaBUbZW8bb6d/A=; b=KLgUXX990ul7k8
	Yf/NsyBYG/K/LcT34NL96N3YlQT3LzFS0n5pJTHiHFpXajGjlcBh+KWjfHpSMvQBdyiMcLMPqbJrA
	Or1umJGLCLQ2jkCkmcU7RcwznKOzsc89yeTi5s1T0+v9lx5e7LrD0HxIQzajEbMEoywzP8J273Akw
	VltZx//4IYjdMZyY72NFb1pTq6n9VdHkPtNA/5PCET2WzvwbYaVa27k2S7tzEGQGcPkYSzcou2nFO
	frPhEspEXMcZAsGcgz0UZz+WVc5TBe0mBUpotTx5HbbowW8KOLf2xXTQ4Noerg3zNwIVvKuhewrJw
	oMcMkENJoQT9DAfLNNYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reFls-0000000F6FU-1ZSG;
	Sun, 25 Feb 2024 14:46:28 +0000
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reFlo-0000000F6ES-411p
	for linux-nvme@lists.infradead.org;
	Sun, 25 Feb 2024 14:46:26 +0000
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-5a027fda5aeso1289609eaf.1
        for <linux-nvme@lists.infradead.org>; Sun, 25 Feb 2024 06:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708872384; x=1709477184; darn=lists.infradead.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JpmlBduLOtP9Y7HibP2DDg1Ww/fxHjaBUbZW8bb6d/A=;
        b=F5u7UbUpxKMqdsD7fNVQPLDYmRFMkDJthDKft90LWIL98LdV0MCfpMNSFEwRbSK8RU
         qglQT2GJCxpVjwGr+PPMbufizTaPL7pLJjwE9GeyhvvlsG94+zEIOCyuBV4AcPtaCLn5
         9W+QcSFlaP1YhOqVs/N2FN38Q0UKBtN1U6TOkvZcZLnwmqKuO40z3Y7K4ZDQmABmiMcW
         9VHe65JdxmaW0BlPwd+ogmcWsyQslEKqUXqfyY8DZ9Y/t5slxcjEcNidFwknNg18/awK
         rsXozwuR4hvfVUb0hw3yalu5fk64Q84o9YuEld6EXXbTn4hVB/NKHCmqr7mpkUrjCUfd
         8deQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708872384; x=1709477184;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JpmlBduLOtP9Y7HibP2DDg1Ww/fxHjaBUbZW8bb6d/A=;
        b=pExJaSUieK3Blw4ZXBSUyebTNR1nsEdSv041Q2dvUTCoH/NP+zHagARB1iNMXhDJ69
         28tzwRtl41kzsVLWuLPvoM4AvBJ3u5K45GtYwC51w33vVnhpwN85zYA4hORiGaVoDcNw
         A95Dp0/1M99/NKDOa+hZaLFMX5zQFbBIxo6sozwnRqqKhLnkHg9JnaJtCdqPoz3Qz8wL
         Ccw7Qf7L98FR8fcE+a/xw2CH2HuYrBB2CqC9WIxaEwMYSr3glyKPGt+TWjw5uilv3zVF
         wQ4sPwINdVQCVd4XHpbo87Ujn5srnYUwz0Wqc50C1sHILSdzf0hfZKwPtrw9L3vVD5mN
         KY5w==
X-Forwarded-Encrypted: i=1; AJvYcCVUWIkO74X5gVocmxwFtxsTuTKL0AWGkntFFIqDz6+Jpc0XN/RH4GvvEml+ZohW6O2uQ+HfxSs5RIsluOFdx73CERJ372NNpQ6TCZWecPo=
X-Gm-Message-State: AOJu0Ywz34tLsByVviISsP0U4NR4W+GKDtOzsFLBO7GHoKSbsBnYU8nI
	nX2J7UH8XJRsErtvggrUmi/71XM8TiRq4SX+wlw2HOl9ypCyWHwDFjw9ZEPu
X-Google-Smtp-Source: AGHT+IHH2tg/cZwys6nguaiuLttBdJz9HIEFZ+uxlzW8VtX1+VRUmvRpyYwrqwFLixwGrsBZ7zvQBA==
X-Received: by 2002:a05:6358:7e81:b0:179:272e:54c6 with SMTP id o1-20020a0563587e8100b00179272e54c6mr5299313rwn.25.1708872383543;
        Sun, 25 Feb 2024 06:46:23 -0800 (PST)
Received: from dw-tp ([171.76.80.106])
        by smtp.gmail.com with ESMTPSA id d8-20020a056a0010c800b006e4762b5f3bsm2476163pfu.172.2024.02.25.06.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 06:46:22 -0800 (PST)
Date: Sun, 25 Feb 2024 20:16:15 +0530
Message-Id: <87cysk1u14.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com, jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com, linux-aio@kvack.org, linux-btrfs@vger.kernel.org, io-uring@vger.kernel.org, nilay@linux.ibm.com, John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v4 07/11] block: Add fops atomic write support
In-Reply-To: <20240219130109.341523-8-john.g.garry@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240225_064625_027936_C337FB17 
X-CRM114-Status: GOOD (  25.87  )
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

> Support atomic writes by submitting a single BIO with the REQ_ATOMIC set.
>
> It must be ensured that the atomic write adheres to its rules, like
> naturally aligned offset, so call blkdev_dio_invalid() ->
> blkdev_atomic_write_valid() [with renaming blkdev_dio_unaligned() to
> blkdev_dio_invalid()] for this purpose.
>
> In blkdev_direct_IO(), if the nr_pages exceeds BIO_MAX_VECS, then we cannot
> produce a single BIO, so error in this case.

BIO_MAX_VECS is 256. So around 1MB limit with 4k pagesize. 
Any mention of why this limit for now? Is it due to code complexity that
we only support a single bio? 
As I see it, you have still enabled req merging in block layer for
atomic requests. So it can essentially submit bio chains to the device
driver? So why not support this case for user to submit a req. larger
than 1 MB? 

>
> Finally set FMODE_CAN_ATOMIC_WRITE when the bdev can support atomic writes
> and the associated file flag is for O_DIRECT.
>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  block/fops.c | 31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/block/fops.c b/block/fops.c
> index 28382b4d097a..563189c2fc5a 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -34,13 +34,27 @@ static blk_opf_t dio_bio_write_op(struct kiocb *iocb)
>  	return opf;
>  }
>  
> -static bool blkdev_dio_unaligned(struct block_device *bdev, loff_t pos,
> -			      struct iov_iter *iter)
> +static bool blkdev_atomic_write_valid(struct block_device *bdev, loff_t pos,
> +				      struct iov_iter *iter)
>  {
> +	struct request_queue *q = bdev_get_queue(bdev);
> +	unsigned int min_bytes = queue_atomic_write_unit_min_bytes(q);
> +	unsigned int max_bytes = queue_atomic_write_unit_max_bytes(q);
> +
> +	return atomic_write_valid(pos, iter, min_bytes, max_bytes);

generic_atomic_write_valid() would be better for this function. However,
I have any commented about this in some previous

> +}
> +
> +static bool blkdev_dio_invalid(struct block_device *bdev, loff_t pos,
> +				struct iov_iter *iter, bool atomic_write)

bool "is_atomic" or "is_atomic_write" perhaps? 
we anyway know that we only support atomic writes and RWF_ATOMIC
operation is made -EOPNOTSUPP for reads in kiocb_set_rw_flags().
So we may as well make it "is_atomic" for bools.

> +{
> +	if (atomic_write && !blkdev_atomic_write_valid(bdev, pos, iter))
> +		return true;
> +
>  	return pos & (bdev_logical_block_size(bdev) - 1) ||
>  		!bdev_iter_is_aligned(bdev, iter);
>  }
>  
> +
>  #define DIO_INLINE_BIO_VECS 4
>  
>  static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
> @@ -71,6 +85,8 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
>  	}
>  	bio.bi_iter.bi_sector = pos >> SECTOR_SHIFT;
>  	bio.bi_ioprio = iocb->ki_ioprio;
> +	if (iocb->ki_flags & IOCB_ATOMIC)
> +		bio.bi_opf |= REQ_ATOMIC;
>  
>  	ret = bio_iov_iter_get_pages(&bio, iter);
>  	if (unlikely(ret))
> @@ -341,6 +357,9 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
>  		task_io_account_write(bio->bi_iter.bi_size);
>  	}
>  
> +	if (iocb->ki_flags & IOCB_ATOMIC)
> +		bio->bi_opf |= REQ_ATOMIC;
> +
>  	if (iocb->ki_flags & IOCB_NOWAIT)
>  		bio->bi_opf |= REQ_NOWAIT;
>  
> @@ -357,13 +376,14 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
>  static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>  {
>  	struct block_device *bdev = I_BDEV(iocb->ki_filp->f_mapping->host);
> +	bool atomic_write = iocb->ki_flags & IOCB_ATOMIC;

ditto, bool is_atomic perhaps?

>  	loff_t pos = iocb->ki_pos;
>  	unsigned int nr_pages;
>  
>  	if (!iov_iter_count(iter))
>  		return 0;
>  
> -	if (blkdev_dio_unaligned(bdev, pos, iter))
> +	if (blkdev_dio_invalid(bdev, pos, iter, atomic_write))
>  		return -EINVAL;
>  
>  	nr_pages = bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS + 1);
> @@ -371,6 +391,8 @@ static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>  		if (is_sync_kiocb(iocb))
>  			return __blkdev_direct_IO_simple(iocb, iter, nr_pages);
>  		return __blkdev_direct_IO_async(iocb, iter, nr_pages);
> +	} else if (atomic_write) {
> +		return -EINVAL;
>  	}
>  	return __blkdev_direct_IO(iocb, iter, bio_max_segs(nr_pages));
>  }
> @@ -616,6 +638,9 @@ static int blkdev_open(struct inode *inode, struct file *filp)
>  	if (bdev_nowait(handle->bdev))
>  		filp->f_mode |= FMODE_NOWAIT;
>  
> +	if (bdev_can_atomic_write(handle->bdev) && filp->f_flags & O_DIRECT)
> +		filp->f_mode |= FMODE_CAN_ATOMIC_WRITE;
> +
>  	filp->f_mapping = handle->bdev->bd_inode->i_mapping;
>  	filp->f_wb_err = filemap_sample_wb_err(filp->f_mapping);
>  	filp->private_data = handle;
> -- 
> 2.31.1

