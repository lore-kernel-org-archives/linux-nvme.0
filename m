Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D7CC7115B
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Jun 2025 05:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ipEsyYyk71k2C4j1LNOEHkyKYSiaoyutZyoqccIJItY=; b=uc/LMPG7V/08+XNYcCqcK95/YH
	HabXE63+f9pwiZaiHv62ivHgHb5EoIJjdqbT/1zSyqUs0XjeQGc3BJ3scLSdLrOLtSbTk2JKJ3Kt1
	w1Nt8cFZ0WU35tzdS5jITO/pRBUUyieaYOzpNkKr+SCWmshmgjXRn+rezIXsc+NQMNNHS7+cy87AN
	hoou3Bli99TJVvB7i68GOMc+kFx1gs6GVo30l0wyCVscz7yMofIkA2jY5VSQ7PsmTtbMI7OOt9D9r
	8Pcv4CCpa8Bi/luYrDXe5hWUAdb9pzxH0wI06Jpn4SZ3ouy0tHPKkD0iisnUFi1+N30IxG5hsvg9F
	NPvrCPlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTZnc-00000001czc-3sfd;
	Mon, 23 Jun 2025 05:32:56 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTZnb-00000001cyp-0xeg;
	Mon, 23 Jun 2025 05:32:55 +0000
Date: Sun, 22 Jun 2025 22:32:55 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: vincent.fu@samsung.com, jack@suse.cz, anuj1072538@gmail.com,
	axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org,
	hch@infradead.org, martin.petersen@oracle.com, ebiggers@kernel.org,
	adilger@dilger.ca, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, joshi.k@samsung.com,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	gost.dev@samsung.com
Subject: Re: [PATCH for-next v4 4/4] fs: add ioctl to query metadata and
 protection info capabilities
Message-ID: <aFjnBxZ8dAehH0Xr@infradead.org>
References: <20250618055153.48823-1-anuj20.g@samsung.com>
 <CGME20250618055220epcas5p3e806eb6636542bb344c1a08cb9d9fd0f@epcas5p3.samsung.com>
 <20250618055153.48823-5-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618055153.48823-5-anuj20.g@samsung.com>
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

On Wed, Jun 18, 2025 at 11:21:53AM +0530, Anuj Gupta wrote:
> +/*
> + * struct logical_block_metadata_cap - Logical block metadata capability

No real need to duplicate the struct name here.

> + * If the device does not support metadata, all the fields will be zero.
> + * Applications must check lbmd_flags to determine whether metadata is supported or not.

Overly long line.

> + */
> +struct logical_block_metadata_cap {
> +	/* Bitmask of logical block metadata capability flags */
> +	__u32	lbmd_flags;
> +	/* The amount of data described by each unit of logical block metadata */

Loit sof overly long lines, please reformat these as block comments.

> +	__u16	lbmd_interval;
> +	/* Size in bytes of the logical block metadata associated with each interval */
> +	__u8	lbmd_size;
> +	/* Size in bytes of the opaque block tag associated with each interval */
> +	__u8	lbmd_opaque_size;



> +	/* Offset in bytes of the opaque block tag within the logical block metadata */
>
> +	__u8	lbmd_opaque_offset;
> +	/* Size in bytes of the T10 PI tuple associated with each interval */
> +	__u8	lbmd_pi_size;
> +	/* Offset in bytes of T10 PI tuple within the logical block metadata */
> +	__u8	lbmd_pi_offset;
> +	/* T10 PI guard tag type */
> +	__u8	lbmd_guard_tag_type;
> +	/* Size in bytes of the T10 PI application tag */
> +	__u8	lbmd_app_tag_size;
> +	/* Size in bytes of the T10 PI reference tag */
> +	__u8	lbmd_ref_tag_size;
> +	/* Size in bytes of the T10 PI storage tag */
> +	__u8	lbmd_storage_tag_size;
> +};

This leaves a byte of padding at the end, leaving to issues with
compiler alignments and potentially leaking uninitialized stack data.


