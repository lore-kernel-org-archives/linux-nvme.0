Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D41DEC25B78
	for <linux-nvme@archiver.kernel.org>; Sat, 25 May 2024 23:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Crh6RjgT+TcJb1jq4rCjRtTqJLBvMRyCXUhpelsfOKA=; b=Zm8FUkVijZvEaHNZUnvnRZ6syz
	DFw6PcJRkIGTzJZwS+gxEY9zQSHwoSORA92Ya2V4cfeCP3e9ibjGdHoSkN+vidClfDzZ8O8N6eLUN
	cc/J0DIKtTX4htkt3TOFNCikoR2s27rklXaf2EH7CBW8ywsmJTYG5Gql/Ddhpgtx7L9fL5KeyeOFC
	exs/WGSjVloptgAlm0tNkjbT0byqTXlvDVpn3SnZ9OaAzkE6OdJOBo2opQg+0NK9wYdJt2uvKsRQZ
	0/lJosEhBauPtemv+0+jgtlVIe1QMDOBPAhPrG561wsravFzmpBUFifVzU7ymghXnmYzJYcGVqeDL
	qjH2Eeaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sB0Wc-0000000BqHc-1hwe;
	Sat, 25 May 2024 23:10:06 +0000
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sB0W5-0000000BpyE-3Vh7
	for linux-nvme@lists.infradead.org;
	Sat, 25 May 2024 23:09:43 +0000
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-6818e31e5baso1711002a12.1
        for <linux-nvme@lists.infradead.org>; Sat, 25 May 2024 16:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1716678571; x=1717283371; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Crh6RjgT+TcJb1jq4rCjRtTqJLBvMRyCXUhpelsfOKA=;
        b=Iu+zGpAgCEi24dbTHqPPar7ru0o5UlzCG/VRFMqGV3bRXSqn3J9MUbC/W321hShGQn
         QmXgGtZf3Kh08P8BZv+QnElEaL2iwPJDM24V3O9NchcXvz0ShFL8y/y7bI3r82iZf7ZW
         ettsGVnvWmf49Gav22c5rggj4G8lhysw/MFgXpD+3H27hiCJIhW3Ak0tWl5QltkTgeAk
         C/LEOf5/ujylVVO9e/QAlSoclgesJuXqYb1zLv+SPMI1u0HX7gKcgthCt5hmkrUEjBf2
         uYEfFxeoJbFXoW8iOisFYP/T8oFhY6RSGQc/nhnMorCLJdZyR+2B+8mNbmD7KhkaO5dE
         yQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716678571; x=1717283371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Crh6RjgT+TcJb1jq4rCjRtTqJLBvMRyCXUhpelsfOKA=;
        b=ZqgbVv9qZa7uJL5/TyRej4Nfx2zUNHeqwtEXDhsjAVQDpW/YMSoHM4jFI0jc+Z7an+
         AaG7UjufXdtmo7LPg1BHUAlKYNmwhNzdY0aCaITFQIS4PalFXICSj8DsyZhaxHPhyj31
         JKNaq1Lx17qC9YMvASkt/iqfsWEhT3lXYSZ8hQ0BVnPnVfuo3K8gkYmGyYHVF5AU0Vtr
         QmbV+KMUhE4kNZvqHiVuo0kCoBjdcTn2fCvoGCjRaihWGwUFKE8vN0rwpa4G+8MStEua
         iSfWvGbHDVGk76UDuJB3QxSdlZXHt7s2z552DXK39UnylPodb4yAeYQ3K2yn/YgY3U4g
         x63g==
X-Forwarded-Encrypted: i=1; AJvYcCXuX7tD+M13L/05y25wx/zmP6Rs8fJCFHsxlUXUUFTqXCcIhY7zEXvyx57L2b1VAdWnG0fWpNUlgVtZXUJIdd+1P5a5IEA9EjWXCPXzZgA=
X-Gm-Message-State: AOJu0YxHdy/QrkmfDdg0EenJPqgOCuguRkTLnVgMcXn+6GL4wpCcea6N
	8hyJifh2mrfmkt9rE28OVZfbciGqjJ7MUrgiRDGxRowQkGJrWWCD2ILozK4MUpU=
X-Google-Smtp-Source: AGHT+IGYciyTBhNiI5PZlCjyMDogB+ANQNNWDCUuYjIsBj+L8eTBYhs5xE8S13XEF72yE6eBkoNGvg==
X-Received: by 2002:a17:902:d50b:b0:1f4:768b:445e with SMTP id d9443c01a7336-1f4768b4768mr21943575ad.24.1716678570642;
        Sat, 25 May 2024 16:09:30 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9afba1sm34658165ad.246.2024.05.25.16.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 May 2024 16:09:30 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sB0Vz-00AUvI-1V;
	Sun, 26 May 2024 09:09:27 +1000
Date: Sun, 26 May 2024 09:09:27 +1000
From: Dave Chinner <david@fromorbit.com>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	martin.petersen@oracle.com, bvanassche@acm.org, hare@suse.de,
	damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
	joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 06/12] fs, block: copy_file_range for def_blk_ops for
 direct block device
Message-ID: <ZlJvp47RSFKkbwRJ@dread.disaster.area>
References: <20240520102033.9361-1-nj.shetty@samsung.com>
 <CGME20240520102929epcas5p2f4456f6fa0005d90769615eb2c2bf273@epcas5p2.samsung.com>
 <20240520102033.9361-7-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520102033.9361-7-nj.shetty@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240525_160934_141528_8266768A 
X-CRM114-Status: GOOD (  23.32  )
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

On Mon, May 20, 2024 at 03:50:19PM +0530, Nitesh Shetty wrote:
> For direct block device opened with O_DIRECT, use blkdev_copy_offload to
> issue device copy offload, or use splice_copy_file_range in case
> device copy offload capability is absent or the device files are not open
> with O_DIRECT.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> ---
>  block/fops.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/block/fops.c b/block/fops.c
> index 376265935714..5a4bba4f43aa 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -17,6 +17,7 @@
>  #include <linux/fs.h>
>  #include <linux/iomap.h>
>  #include <linux/module.h>
> +#include <linux/splice.h>
>  #include "blk.h"
>  
>  static inline struct inode *bdev_file_inode(struct file *file)
> @@ -754,6 +755,30 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  	return ret;
>  }
>  
> +static ssize_t blkdev_copy_file_range(struct file *file_in, loff_t pos_in,
> +				      struct file *file_out, loff_t pos_out,
> +				      size_t len, unsigned int flags)
> +{
> +	struct block_device *in_bdev = I_BDEV(bdev_file_inode(file_in));
> +	struct block_device *out_bdev = I_BDEV(bdev_file_inode(file_out));
> +	ssize_t copied = 0;
> +
> +	if ((in_bdev == out_bdev) && bdev_max_copy_sectors(in_bdev) &&
> +	    (file_in->f_iocb_flags & IOCB_DIRECT) &&
> +	    (file_out->f_iocb_flags & IOCB_DIRECT)) {
> +		copied = blkdev_copy_offload(in_bdev, pos_in, pos_out, len,
> +					     NULL, NULL, GFP_KERNEL);
> +		if (copied < 0)
> +			copied = 0;
> +	} else {
> +		copied = splice_copy_file_range(file_in, pos_in + copied,
> +						 file_out, pos_out + copied,
> +						 len - copied);
> +	}

This should not fall back to a page cache copy.

We keep being told by application developers that if the fast
hardware/filesystem offload fails, then an error should be returned
so the application can determine what the fallback operation should
be.

It may well be that the application falls back to "copy through the
page cache", but that is an application policy choice, not a
something the kernel offload driver should be making mandatory.

Userspace has to handle copy offload failure anyway, so they a
fallback path regardless of whether copy_file_range() works on block
devices or not...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

