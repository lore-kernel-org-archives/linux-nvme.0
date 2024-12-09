Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F82E7717D
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2024 13:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=otDC6QBMtg6Enmmae50k3HhCoEox04pTO6aFgh6BTKE=; b=dXqtYgtnKxQOQG
	iRZhEM+UgSA6DSdDEvjTI2dfmD86N3jXap6tHyAI7IwNAe34iDERcHbVnU1O+gIMCukqiMwMDh6Qh
	6bDqFRtCNDf1dov4dHbm90fTbHNFgf7D9ZePITFFerN6c0fNJuhBn9JkVCv36IhooOydWccEfOrWB
	dSmv/BpvMzvOLOed3+ORqmVfevwVko6pzxwhe+RBlPLbEcsg1zwldt9vFtX+jr2vCX6MnXo38gTaA
	Xd/v/ZMIlFEJfteSdT/lCQzgMzlcFeV3HRRog10S8ef2bF0IJp/cPbVEbd6Sw0Z6iggdFUyufUSxB
	7uF4OYfhrmZjPXiNXWog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKdTG-00000007rzP-0I3N;
	Mon, 09 Dec 2024 13:06:42 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKdAP-00000007mGu-3Hr6
	for linux-nvme@lists.infradead.org;
	Mon, 09 Dec 2024 12:47:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 738585C542B;
	Mon,  9 Dec 2024 12:46:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45D1C4CED1;
	Mon,  9 Dec 2024 12:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733748432;
	bh=rx/satrX6NOMI1d5jJfnZ/jJL/Cz4Bcc5+zr+o7LYjg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NotqBDAOEAuflm1ByoRUQUMkQM/GR5PEXG1GbWl9lNsG0DIFVBHwfaazKgSacNw4a
	 wi5+hewIptbshNnRaZhmnynUnN0rpfF6DqppylKvadwlmXOXqz9noLoUK5Y9LnMA1N
	 47lK5kmBGwNhJD2HUkfxZv6rabxYgt2JDHykOrpbGX30Q05yj8ghVba89TGniHAY4N
	 Vzi3q6IhLb3BBiSKT4vp3Opg412GKpzwG6fYq48H44n8KsYhkQW+XgBawLdsOkMCK/
	 tT5rkDDV4NB6MCRX5cDBqtns+HPgK2hZZvJueRZrTeg0y0S8YmB4xCPzZ2STvG78Cj
	 2VtKXmLdQi8QA==
Date: Mon, 9 Dec 2024 13:47:06 +0100
From: Christian Brauner <brauner@kernel.org>
To: Keith Busch <kbusch@meta.com>, axboe@kernel.dk
Cc: hch@lst.de, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org, 
	sagi@grimberg.me, asml.silence@gmail.com, anuj20.g@samsung.com, 
	joshi.k@samsung.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv12 01/12] fs: add write stream information to statx
Message-ID: <20241209-ruhezeit-stachelschwein-c49556b975e6@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241206221801.790690-2-kbusch@meta.com>
 <20241206221801.790690-3-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241209_044713_909625_A26A01EF 
X-CRM114-Status: GOOD (  23.03  )
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

On Fri, Dec 06, 2024 at 02:17:50PM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Add new statx field to report the maximum number of write streams
> supported and the granularity for them.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> [hch: rename hint to stream, add granularity]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/stat.c                 | 2 ++
>  include/linux/stat.h      | 2 ++
>  include/uapi/linux/stat.h | 7 +++++--
>  3 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/stat.c b/fs/stat.c
> index 0870e969a8a0b..00e4598b1ff25 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -729,6 +729,8 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
>  	tmp.stx_atomic_write_unit_min = stat->atomic_write_unit_min;
>  	tmp.stx_atomic_write_unit_max = stat->atomic_write_unit_max;
>  	tmp.stx_atomic_write_segments_max = stat->atomic_write_segments_max;
> +	tmp.stx_write_stream_granularity = stat->write_stream_granularity;
> +	tmp.stx_write_stream_max = stat->write_stream_max;
>  
>  	return copy_to_user(buffer, &tmp, sizeof(tmp)) ? -EFAULT : 0;
>  }
> diff --git a/include/linux/stat.h b/include/linux/stat.h
> index 3d900c86981c5..36d4dfb291abd 100644
> --- a/include/linux/stat.h
> +++ b/include/linux/stat.h
> @@ -57,6 +57,8 @@ struct kstat {
>  	u32		atomic_write_unit_min;
>  	u32		atomic_write_unit_max;
>  	u32		atomic_write_segments_max;
> +	u32		write_stream_granularity;
> +	u16		write_stream_max;
>  };
>  
>  /* These definitions are internal to the kernel for now. Mainly used by nfsd. */
> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> index 887a252864416..547c62a1a3a7c 100644
> --- a/include/uapi/linux/stat.h
> +++ b/include/uapi/linux/stat.h
> @@ -132,9 +132,11 @@ struct statx {
>  	__u32	stx_atomic_write_unit_max;	/* Max atomic write unit in bytes */
>  	/* 0xb0 */
>  	__u32   stx_atomic_write_segments_max;	/* Max atomic write segment count */
> -	__u32   __spare1[1];
> +	__u32   stx_write_stream_granularity;
>  	/* 0xb8 */
> -	__u64	__spare3[9];	/* Spare space for future expansion */
> +	__u16   stx_write_stream_max;
> +	__u16	__sparse2[3];
> +	__u64	__spare3[8];	/* Spare space for future expansion */
>  	/* 0x100 */
>  };

Once you're ready to merge, let me know so I can give you a stable
branch with the fs changes.

>  
> @@ -164,6 +166,7 @@ struct statx {
>  #define STATX_MNT_ID_UNIQUE	0x00004000U	/* Want/got extended stx_mount_id */
>  #define STATX_SUBVOL		0x00008000U	/* Want/got stx_subvol */
>  #define STATX_WRITE_ATOMIC	0x00010000U	/* Want/got atomic_write_* fields */
> +#define STATX_WRITE_STREAM	0x00020000U	/* Want/got write_stream_* */
>  
>  #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
>  
> -- 
> 2.43.5
> 

On Fri, Dec 06, 2024 at 02:17:51PM -0800, Keith Busch wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> Prepare for io_uring passthrough of write streams. The write stream
> field in the kiocb structure fits into an existing 2-byte hole, so its
> size is not changed.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  include/linux/fs.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 2cc3d45da7b01..26940c451f319 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -373,6 +373,7 @@ struct kiocb {
>  	void			*private;
>  	int			ki_flags;
>  	u16			ki_ioprio; /* See linux/ioprio.h */
> +	u8			ki_write_stream;
>  	union {
>  		/*
>  		 * Only used for async buffered reads, where it denotes the
> -- 
> 2.43.5
> 

