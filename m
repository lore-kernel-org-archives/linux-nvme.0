Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C67D6B6DA
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 21:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W2MI4ZG4DKI6pU2RHBmoIzZE8LNeRrT05BK3Jbwi6UQ=; b=jTOWCRcYJSM+zpjZk+5F+INGfS
	zbGUVefByqDu7rtg4mjsVMCcxEVyU47rtbPijavS13f9iFLLIEwbuIJzWpookvQBdjHSjYzIUU4tg
	2Z6DcdGAwbDKJWaW41XncZOw/ED6ZHuVI7iPslYtdwoz8uSA6iNJiXt+BFJbw13w/YXIVjCsEDib8
	ifV8LW3DSlbbit7Ws5znLpdw4P8FrGCNaPSeUYAe2wtVt60bdaApbAiYAVP0iTkrQGS2lBwzpe5pQ
	S3aXh3jyMinWv1DY5JOZvXYnV2mfXIlX3UjWNMskhtm6ks2/MvniDn9tOwVGEPz6DXPVtjkcu8aPY
	2M7KDQLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6Fwc-00000001mpC-0IPh;
	Wed, 30 Oct 2024 21:09:34 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6FwZ-00000001mol-07gH
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 21:09:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 84F3DA43414;
	Wed, 30 Oct 2024 21:07:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A5AC4CECE;
	Wed, 30 Oct 2024 21:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730322569;
	bh=NBQ38qs+AbyE0Vr5iDj8caZDO5/MYkzq0hD2+YnFywI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DAKgH6Pmk7D2XBp3rQzuXx0gmeaTve7/Q+dbQ3Anyg2ljqQvRnSqbacrTvbXsN5ou
	 G8Fy8GdyHdrOacMUD2zMcHK37+gABPdJQGK2G/IWs5WhA4GRqbtM1Ns39tPviPAUCG
	 UTsIBn5/d6xL267h9o1ECYi7+hqDK5lg0UVxm6czQgLXVjp9IhV3NNbPrErHeEYNsT
	 hvxg4BlgiQ/CzplHAPDdiljSmVNrlRtXAZUimsNWCyZOl72QdmWE/5ETP0yc2xp3Ty
	 MvW5EpmRDHStTsQrPev91kCO7hV9wdC4WP/F+aLzDNHfCuKb1kegKtFtE+T2b9PQ++
	 BJArTVNMCczvQ==
Date: Wed, 30 Oct 2024 15:09:26 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	asml.silence@gmail.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
	jack@suse.cz, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	gost.dev@samsung.com, vishak.g@samsung.com, anuj1072538@gmail.com,
	Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH v6 06/10] io_uring/rw: add support to send metadata along
 with read/write
Message-ID: <ZyKghoCwbOjAxXMz@kbusch-mbp.dhcp.thefacebook.com>
References: <20241030180112.4635-1-joshi.k@samsung.com>
 <CGME20241030181013epcas5p2762403c83e29c81ec34b2a7755154245@epcas5p2.samsung.com>
 <20241030180112.4635-7-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030180112.4635-7-joshi.k@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_140931_156261_8A9740E5 
X-CRM114-Status: GOOD (  16.36  )
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

On Wed, Oct 30, 2024 at 11:31:08PM +0530, Kanchan Joshi wrote:
> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
> index 024745283783..48dcca125db3 100644
> --- a/include/uapi/linux/io_uring.h
> +++ b/include/uapi/linux/io_uring.h
> @@ -105,6 +105,22 @@ struct io_uring_sqe {
>  		 */
>  		__u8	cmd[0];
>  	};
> +	/*
> +	 * If the ring is initialized with IORING_SETUP_SQE128, then
> +	 * this field is starting offset for 64 bytes of data. For meta io
> +	 * this contains 'struct io_uring_meta_pi'
> +	 */
> +	__u8	big_sqe[0];
> +};
> +
> +/* this is placed in SQE128 */
> +struct io_uring_meta_pi {
> +	__u16		pi_flags;
> +	__u16		app_tag;
> +	__u32		len;
> +	__u64		addr;
> +	__u64		seed;
> +	__u64		rsvd[2];
>  };

On the previous version, I was more questioning if it aligns with what
Pavel was trying to do here. I didn't quite get it, so I was more
confused than saying it should be this way now.

But I personally think this path makes sense. I would set it up just a
little differently for extended sqe's so that the PI overlays a more
generic struct that other opcodes might find a way to use later.
Something like:

struct io_uring_sqe_ext {
	union {
		__u32	rsvd0[8];
		struct {
			__u16		pi_flags;
			__u16		app_tag;
			__u32		len;
			__u64		addr;
			__u64		seed;
		} rw_pi;
	};
	__u32	rsvd1[8];
};
  
> @@ -3902,6 +3903,9 @@ static int __init io_uring_init(void)
>  	/* top 8bits are for internal use */
>  	BUILD_BUG_ON((IORING_URING_CMD_MASK & 0xff000000) != 0);
>  
> +	BUILD_BUG_ON(sizeof(struct io_uring_meta_pi) >
> +		     sizeof(struct io_uring_sqe));

Then this check would become:

	BUILD_BUG_ON(sizeof(struct io_uring_sqe_ext) != sizeof(struct io_uring_sqe));

