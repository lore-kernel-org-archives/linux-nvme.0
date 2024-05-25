Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A45DC25B78
	for <linux-nvme@archiver.kernel.org>; Sat, 25 May 2024 23:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gic6Wo3zjudyzI0BAjsVaWRrn7WVkv86SSZTvDO7XFs=; b=2rl1WyXqXsSJRiZ+x99uoGd0mx
	bUOGN7Tpdbb1DRjBJV9FWWGdOJiw0YQuRDoKmcPJLUasFVqg017uTFUs/uRKybvCwALNFkZBM8vA4
	NArEOHGvZvFLrKfnQoHfffFuBEv7NGl/W+Qh6NIKqaLpH1sIDNIKUHjqU9Prlt7mAfMlpKRn6C74m
	AB0thdczMVd4at+Hr/XV22zmYc6qkT40KrflEqjFj3KIOWxk7SY5HamViL/6FVX4iFDutkzAeQfZ+
	vXo64iKpe2cwJgDwKwcToWfpz3X7+ulI7jfwl31Wgj1Y4xLKWLhc3YCPyHMmlMr6MXj7BCMcZgSdz
	kTf7WGjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sB0Pe-0000000BokN-0uLf;
	Sat, 25 May 2024 23:02:54 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sB0PW-0000000Bojw-1LrR
	for linux-nvme@lists.infradead.org;
	Sat, 25 May 2024 23:02:47 +0000
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6f6911d16b4so4940492b3a.3
        for <linux-nvme@lists.infradead.org>; Sat, 25 May 2024 16:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1716678163; x=1717282963; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gic6Wo3zjudyzI0BAjsVaWRrn7WVkv86SSZTvDO7XFs=;
        b=u2BnStqYoYCDDq6vCPa1vHt74UwGqqZwh1VSekB0bh40Ai8kVsGsE4c64EvaUHhzys
         7N6PG+FeZgpTMwwGT8bq18E7btwpXkH5WVhF5Tpop05WMazGhmd8gG5wgPLwAhUeLLeD
         hKIsQc8kskSO6fd72RwToTiDuZcEdCuu1bvPOrv/hlt3Kt4g+Lal8SD8yT31cI/L6FHm
         I5kale5pbAuYVH2cqrVpi/cwCQuTWc4CYS9RfWAKg3ayoHAZDGipE2nOY+p9aetD3QdI
         RpSxGJNk3mXerR1VdJWoYtem7l9JHNYvKbYH84ea6YnoDtaEk7rzfIovyf6tvtL0dohw
         xCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716678163; x=1717282963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gic6Wo3zjudyzI0BAjsVaWRrn7WVkv86SSZTvDO7XFs=;
        b=Kq3TIJj0JfW7TUIjg7ZIAUeoF+kOCRfCO2SB7Te8lUb/jkKGDjeb1JAIFe1PjpKJ90
         vLnRSg6S5nj2KDlhF4CrMHmhH97VKzSj1SXVl2p29mIrzuoqf3riaJ0Looi9HvGv6qxe
         sMFxXtuAaHSgMqIYL39lZr/b7E3gXaD7ULsIDbvFOzP+lhjrt0CMxQEvkMO5BBHIsYtg
         NtWOajM5rNW+Rq5rzTCAri6I7rg/lkoIzHNduiGmviPk46cYQ7vsIin3diIe9GI3HVsX
         XnH4R6SRoTvysW1VI83xxSzvO9aXKnjLmwj22vjl3jQCj8wKqefhF0dMiql3La9lKyt8
         KeEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNbUwJ/TZ1OMxATH6hx3JP1nfHfNMnsZT+oNgZwuxvew9v+vhKGp1dq3hmMgrhySL0MlcQWGkFB3NiR9Gg/Sevi7USCCzS5m+RYBSLPrU=
X-Gm-Message-State: AOJu0YzdasU26kz05dndlwZn77W5zUYXObnPS1W22z9Unz/cY21Zh5NO
	Tg9EGCPU90NsNDx5HP5LexkBaU0lVPWYV5Lo1LzR8ZFO4pt34UbGJnzq5E8+ykitAlC3ln67zMY
	t
X-Google-Smtp-Source: AGHT+IHkIK468Us7w5racBBbD0k32HWYTGqS9h3qKLyIaPSGj5Sg+dT6eM4UpYv8VhDI97pWq3omsw==
X-Received: by 2002:a05:6a00:4405:b0:6f8:caf2:8f4f with SMTP id d2e1a72fcca58-6f8f45d2624mr6450954b3a.33.1716678162585;
        Sat, 25 May 2024 16:02:42 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fcbeaaa3sm2831749b3a.103.2024.05.25.16.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 May 2024 16:02:42 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sB0PP-00AUdG-2E;
	Sun, 26 May 2024 09:02:39 +1000
Date: Sun, 26 May 2024 09:02:39 +1000
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
Subject: Re: [PATCH v20 05/12] fs/read_write: Enable copy_file_range for
 block device.
Message-ID: <ZlJuDxhMEpJxKQHV@dread.disaster.area>
References: <20240520102033.9361-1-nj.shetty@samsung.com>
 <CGME20240520102917epcas5p1bda532309b9174bf2702081f6f58daf7@epcas5p1.samsung.com>
 <20240520102033.9361-6-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520102033.9361-6-nj.shetty@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240525_160246_395670_1725028E 
X-CRM114-Status: GOOD (  22.70  )
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

On Mon, May 20, 2024 at 03:50:18PM +0530, Nitesh Shetty wrote:
> From: Anuj Gupta <anuj20.g@samsung.com>
> 
> This is a prep patch. Allow copy_file_range to work for block devices.
> Relaxing generic_copy_file_checks allows us to reuse the existing infra,
> instead of adding a new user interface for block copy offload.
> Change generic_copy_file_checks to use ->f_mapping->host for both inode_in
> and inode_out. Allow block device in generic_file_rw_checks.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> ---
>  fs/read_write.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index ef6339391351..31645ca5ed58 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1413,8 +1413,8 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
>  				    struct file *file_out, loff_t pos_out,
>  				    size_t *req_count, unsigned int flags)
>  {
> -	struct inode *inode_in = file_inode(file_in);
> -	struct inode *inode_out = file_inode(file_out);
> +	struct inode *inode_in = file_in->f_mapping->host;
> +	struct inode *inode_out = file_out->f_mapping->host;
>  	uint64_t count = *req_count;
>  	loff_t size_in;
>  	int ret;

Ok, so this changes from file->f_inode to file->mapping->host. No
doubt this is because of how bdev inode mappings are munged.
However, the first code that is run here is:

	ret = generic_file_rw_checks(file_in, file_out);

and that function still uses file_inode().

Hence there checks:

> @@ -1726,7 +1726,9 @@ int generic_file_rw_checks(struct file *file_in, struct file *file_out)
>  	/* Don't copy dirs, pipes, sockets... */
>  	if (S_ISDIR(inode_in->i_mode) || S_ISDIR(inode_out->i_mode))
>  		return -EISDIR;
> -	if (!S_ISREG(inode_in->i_mode) || !S_ISREG(inode_out->i_mode))
> +	if (!S_ISREG(inode_in->i_mode) && !S_ISBLK(inode_in->i_mode))
> +		return -EINVAL;
> +	if ((inode_in->i_mode & S_IFMT) != (inode_out->i_mode & S_IFMT))
>  		return -EINVAL;

.... are being done on different inodes to the rest of
generic_copy_file_checks() when block devices are used.

Is this correct? If so, this needs a pair of comments (one for each
function) to explain why the specific inode used for these functions
is correct for block devices....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

