Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34AB5C48BF8
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Feb 2024 22:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bl5GKAX3dlaK9635suuwAaWFkidsg1LZ0Wt1MsG+2JM=; b=NQcOiFRdDf0lsC6rYEeqvXcwKr
	LKVIZ/D5Kj2K0/T2EaaMgCVgu9IEezVwTVS8BZyWhUwUMcdk0HGYys8XIW4DZfWjJHV7bKBL4BS4A
	6reD9ugTBOSQ9tUxDk2gyGXfTRF1RsY3/+j9zDQncsnuk0ni2smvcF+lHeN+uYiipQA6xsY22g1Qt
	uz92YPSOnSlnr+7dV+eyUn97SZOKqu8yc3qobkVdqlnsRgiVt17WZGaSvTwBR/88x9s0+q9rt2s6e
	l1NfQApLrJaRWvvbt1EeTeX6x47HOYtC8wvdZWpNfTT0AXungxt29/55X7P7KT9vC/ab6I+efRvs4
	b8AocFxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcC83-0000000CNoy-1FRu;
	Mon, 19 Feb 2024 22:28:51 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcC80-0000000CNjr-1EV3
	for linux-nvme@lists.infradead.org;
	Mon, 19 Feb 2024 22:28:49 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1d746856d85so28280525ad.0
        for <linux-nvme@lists.infradead.org>; Mon, 19 Feb 2024 14:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1708381727; x=1708986527; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bl5GKAX3dlaK9635suuwAaWFkidsg1LZ0Wt1MsG+2JM=;
        b=wILdl9v8Xr89c/EVsdgBA3Dsx5pHTU39kxFSXm0gWMT9F/TEA72Cfb+NMsnyfWEYfD
         BEBoYlJ9yLwZwyT4BkzHA7n+MRvdwRKEHOoxvidmPpDn9WCcW5qNn2OXf2/LNibCuhsE
         0WmeAFsTc56NeymDRaBtdGfe3ELNgl2B2iZfucMQ3Fz6B/3AJ22rBqQ6jyeScAbvOj61
         LgJiIi8bgUzA7KsjgPFulOKNqw6kgovCEQOkUB23xqS09Te9jKh7BnACYNy4HxClPYCY
         ruwuVMsKno3Wr0FPKUvyOU8nJcv7G+PQTB0mI/Iy+DQXu6TmVicFVnSeF3fyjPQ2HH7E
         CRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708381727; x=1708986527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bl5GKAX3dlaK9635suuwAaWFkidsg1LZ0Wt1MsG+2JM=;
        b=wjlV7HHMJBWJ6pW8cd9Gh98yC0WbyXtXsWwPEgDJsuK3PKRhpxke7UOBqGvcSoiSju
         jBelcbJTPE5OLjmhKy0UIkzGEsM7jog3ibrxUVYFa4bH/ZbE+wQ7xxz2McpmFS8tIzLG
         mKBo5y0LnUM+tNx3xEGjmaJTQC2QoWBWeaCu/HXkpZ6iG2ntHJiyNBtM3dZq/0u6+OvG
         tQ0WSHUk7L4oBk3aJuW5Wt0RgajX07i03yWzIpBne6B/73r90+bLhjh8/jqE1jJYQ8QY
         FJgXY19+orVLr1Zbi6xiNcTxeEGq472rY+xiB15pRtlqvEhv9Lfmi3dJLIr7r0ox1Jk8
         12pA==
X-Forwarded-Encrypted: i=1; AJvYcCXcMrG8eWJVu6ugfsd72Yg/JA8bc+ipZHUblKM/TdkZybEpHPNRSHdN22dEsBMnfTKZUeczuzoiTymvQsQwXO7eL3RGE1fFmsYWW7WjldM=
X-Gm-Message-State: AOJu0YwYam39kNSHVZqEIvfmUy70D3sVh+zZQbKVPA2nZtLTArCAYZzG
	GRWbl1+kdJnJR6Oa4mDnBR2RHV01xJGFDkgAQw63HdX1uCLD8e+Xe2cPf3dDbUY=
X-Google-Smtp-Source: AGHT+IHlEqzTbeqGZugXvJDuwYCJATCsRA1NiGwC9reCuuiCgxtV1VeURbikH3d/YTo82RrU7aljog==
X-Received: by 2002:a17:902:cecf:b0:1db:d66e:cd15 with SMTP id d15-20020a170902cecf00b001dbd66ecd15mr6464817plg.59.1708381727050;
        Mon, 19 Feb 2024 14:28:47 -0800 (PST)
Received: from dread.disaster.area (pa49-181-247-196.pa.nsw.optusnet.com.au. [49.181.247.196])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902d04400b001d949e663d5sm4933240pll.31.2024.02.19.14.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 14:28:46 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rcC7v-008o4I-26;
	Tue, 20 Feb 2024 09:28:43 +1100
Date: Tue, 20 Feb 2024 09:28:43 +1100
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com,
	linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
	io-uring@vger.kernel.org, nilay@linux.ibm.com,
	ritesh.list@gmail.com,
	Prasad Singamsetty <prasad.singamsetty@oracle.com>
Subject: Re: [PATCH v4 04/11] fs: Add initial atomic write support info to
 statx
Message-ID: <ZdPWGwntYMvstbpc@dread.disaster.area>
References: <20240219130109.341523-1-john.g.garry@oracle.com>
 <20240219130109.341523-5-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219130109.341523-5-john.g.garry@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240219_142848_585716_8138C5DE 
X-CRM114-Status: GOOD (  23.24  )
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

On Mon, Feb 19, 2024 at 01:01:02PM +0000, John Garry wrote:
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
> + * @unit_max:	Maximum supported atomic write length
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
> +EXPORT_SYMBOL(generic_fill_statx_atomic_writes);

What units are these in? Nothing in the patch or commit description
tells us....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

