Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A12D58D5C
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2024 14:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mwycz/MiAZLiFKmS9hGPG2W/0xImNpvKNhmHBM//itM=; b=qQ8TS5lr7bRq4iFfDc0vvKdo0I
	es2Nd3TjyQGi+SNNGOpQDulKK7cOgNkop7g2qgpK0PJXi2CiR3nGEYRMPEGJNpFZcu/s4HdmRN+5w
	1qV28SAqM3z3AB3Sjr9odkd28Uoxx5mKYq37Qd//q3RSlVXRH9rRfAmQo/2GJVxDnUzM81L13l5kK
	oINUJTektg0dA3nx8k+MWMZI0pKlZ2AZAX/KKZi/QNLxiwDxTmtHpUiRGxlnzYBl5U2LPr9P0vq3l
	MvjsG56d7e/41yICLUYAoymyXsxdzJd3fmnVTC8i/JASUBGObL/DD0ENYjyrv/EMgRrfZbtFCNuE6
	5e0PWgGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFaWz-00000008MXf-1VU0;
	Mon, 25 Nov 2024 14:57:41 +0000
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFaWs-00000008MX6-2QJ7
	for linux-nvme@lists.infradead.org;
	Mon, 25 Nov 2024 14:57:35 +0000
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-a9ec267b879so681849266b.2
        for <linux-nvme@lists.infradead.org>; Mon, 25 Nov 2024 06:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732546652; x=1733151452; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mwycz/MiAZLiFKmS9hGPG2W/0xImNpvKNhmHBM//itM=;
        b=TsKCtmfmST5DkZooxk3o5Zv0hRg/Mxu122SDAi/oWfFx8WSl6SUwUIa44zaRhCOZWU
         fJZ82rSrlnYABIw2Ol4h81QayPzSS27JYpAl+xZtas5Wmw9gh4Kq0wBXs3rlWKuHqObv
         Vvnk6Rzb2Oq+nUUjI5Lji8ciaBSNgeOs60QSme67TWA3p98vUPc3JTkdYdURckyJLqCQ
         bYvEIUekBkaXzguBFADspSKTNnrOg75eE7NWxBYvCNq/7WzI5xKbdX/J3PfHWx2WzIpS
         qzUzWnHtcLuyMO/UNQvhEk6cu66iE0EVAf55aR/kllqvgumLzRVI4kbTj5mabUrfTeCS
         ovug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732546652; x=1733151452;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mwycz/MiAZLiFKmS9hGPG2W/0xImNpvKNhmHBM//itM=;
        b=m3sonw0ahwlPhyqtb0lTvzFdt9hYSzx0RahnBAm7BSjy2Qtl/f6FTQTXdfDFDQ45Ya
         gN92mPUZB9MeMB+8cKm+9tCuf/t+6LywmghkiSFuTkHifAVIdLr8VDWcvgzo0GU56QFr
         yiDwEP5QTWDprAtnvQNp9QvAOHz1YkEyGPkOIzqPvpAc8/tCkLidZorgyadQCWB8IFLD
         idEjdlPNHqc1UsKPhElkg4JD+dh+3T4K3WBexiiOxEtFp1gYtMOJeJOoitW8WRZsm1OZ
         rTSk01+bKFrrsSOS5HoK5aT7QMzM31F4hOUdUf1SSd45WqcEuLgptXlfHuaK8qQ9KDIw
         nnDg==
X-Forwarded-Encrypted: i=1; AJvYcCXy7F1Ry8jw2nOFK5XW42WR1QRqvJhk/rdKu6864NbIRdH++P/+73rT0cgJgJamwyaDFhDLSlnL2l0l@lists.infradead.org
X-Gm-Message-State: AOJu0YzpDL9yZFYpLNY3NCnaTcEtPZ5C8MPqisRmpdY77TfAbXspyzSM
	CJbe52KmbFsM0oyU/QlHcVZlM9ORXolVwi3wc2tJCruwGarvU04/
X-Gm-Gg: ASbGnctIkhQ/ELf0a+/aH2/6SPCxucAfphRAVSZ+aysx4OvzqYDY53oCk4rfeDrLnYh
	BvKqVHxmm2wRNFORixVOyRHo6K7nw4gU7/Ui9/DYaHlG4qzEoO9uyxZoZNkuP1t7+A+17nDiemC
	VOq10E6TAETyd122dVw8/StnS50+q0HUbTsD794hr1XbujQKBaLPQ/cfMbqSXhI1BExaF5sSRPH
	fTYIId5BvnavzkxwQ2d7hApo/xXZS5ceX+dF4hy79qQlbsBIUX7i8hZaahiVg==
X-Google-Smtp-Source: AGHT+IEzNyoWXmldDRbK4hugvlNPC35UUFsvEms5CLemQoA8167zZU/Ipeyzrkp+FtvQyJR2Aj95nA==
X-Received: by 2002:a17:906:3194:b0:aa5:28af:f0e with SMTP id a640c23a62f3a-aa528af0f4amr1066397166b.15.1732546651154;
        Mon, 25 Nov 2024 06:57:31 -0800 (PST)
Received: from [192.168.42.132] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52fd20sm473799366b.111.2024.11.25.06.57.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 06:57:30 -0800 (PST)
Message-ID: <a28b46a0-9eb5-45db-80ec-93fdc0eec35e@gmail.com>
Date: Mon, 25 Nov 2024 14:58:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 06/10] io_uring: introduce attributes for read/write
 and PI support
To: Anuj Gupta <anuj20.g@samsung.com>, axboe@kernel.dk, hch@lst.de,
 kbusch@kernel.org, martin.petersen@oracle.com, anuj1072538@gmail.com,
 brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, gost.dev@samsung.com,
 linux-scsi@vger.kernel.org, vishak.g@samsung.com,
 linux-fsdevel@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
References: <20241125070633.8042-1-anuj20.g@samsung.com>
 <CGME20241125071502epcas5p46c373574219a958b565f20732797893f@epcas5p4.samsung.com>
 <20241125070633.8042-7-anuj20.g@samsung.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20241125070633.8042-7-anuj20.g@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241125_065734_626682_BA0DD6A2 
X-CRM114-Status: GOOD (  29.98  )
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

On 11/25/24 07:06, Anuj Gupta wrote:
> Add the ability to pass additional attributes along with read/write.
> Application can populate attribute type and attibute specific information
> in 'struct io_uring_attr' and pass its address using the SQE field:
> 	__u64	attr_ptr;
> 
> Along with setting a mask indicating attributes being passed:
> 	__u64	attr_type_mask;
> 
> Overall 64 attributes are allowed and currently one attribute
> 'ATTR_TYPE_PI' is supported.
> 
> With PI attribute, userspace can pass following information:
> - flags: integrity check flags IO_INTEGRITY_CHK_{GUARD/APPTAG/REFTAG}
> - len: length of PI/metadata buffer
> - addr: address of metadata buffer
> - seed: seed value for reftag remapping
> - app_tag: application defined 16b value

The API and io_uring parts look good, I'll ask to address the
ATTR_TYPE comment below, the rest are nits, which that can be
ignored and/or delayed.

> Process this information to prepare uio_meta_descriptor and pass it down
> using kiocb->private.

I'm not sure using ->private is a good thing, but I assume it
was discussed, so I'll leave it to Jens and other folks.


> PI attribute is supported only for direct IO.
> 
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> ---
>   include/uapi/linux/io_uring.h | 31 +++++++++++++
>   io_uring/io_uring.c           |  2 +
>   io_uring/rw.c                 | 82 ++++++++++++++++++++++++++++++++++-
>   io_uring/rw.h                 | 14 +++++-
>   4 files changed, 126 insertions(+), 3 deletions(-)
> 
> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
> index aac9a4f8fa9a..bf28d49583ad 100644
> --- a/include/uapi/linux/io_uring.h
> +++ b/include/uapi/linux/io_uring.h
> @@ -98,6 +98,10 @@ struct io_uring_sqe {
>   			__u64	addr3;
>   			__u64	__pad2[1];
>   		};
> +		struct {
> +			__u64	attr_ptr; /* pointer to attribute information */
> +			__u64	attr_type_mask; /* bit mask of attributes */
> +		};
>   		__u64	optval;
>   		/*
>   		 * If the ring is initialized with IORING_SETUP_SQE128, then
> @@ -107,6 +111,33 @@ struct io_uring_sqe {
>   	};
>   };
>   
> +
> +/* Attributes to be passed with read/write */
> +enum io_uring_attr_type {
> +	ATTR_TYPE_PI,
> +	/* max supported attributes */
> +	ATTR_TYPE_LAST = 64,

ATTR_TYPE sounds too generic, too easy to get a symbol collision
including with user space code.

Some options: IORING_ATTR_TYPE_PI, IORING_RW_ATTR_TYPE_PI.
If it's not supposed to be io_uring specific can be
IO_RW_ATTR_TYPE_PI

> +};
> +
> +/* sqe->attr_type_mask flags */
> +#define ATTR_FLAG_PI	(1U << ATTR_TYPE_PI)
> +/* PI attribute information */
> +struct io_uring_attr_pi {
> +		__u16	flags;
> +		__u16	app_tag;
> +		__u32	len;
> +		__u64	addr;
> +		__u64	seed;
> +		__u64	rsvd;
> +};
> +
> +/* attribute information along with type */
> +struct io_uring_attr {
> +	enum io_uring_attr_type	attr_type;

I'm not against it, but adding a type field to each attribute is not
strictly needed, you can already derive where each attr placed purely
from the mask. Are there some upsides? But again I'm not against it.

> +	/* type specific struct here */
> +	struct io_uring_attr_pi	pi;
> +};
> +
>   /*
>    * If sqe->file_index is set to this for opcodes that instantiate a new
>    * direct descriptor (like openat/openat2/accept), then io_uring will allocate
> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
> index c3a7d0197636..02291ea679fb 100644
> --- a/io_uring/io_uring.c
> +++ b/io_uring/io_uring.c
> @@ -3889,6 +3889,8 @@ static int __init io_uring_init(void)
>   	BUILD_BUG_SQE_ELEM(46, __u16,  __pad3[0]);
>   	BUILD_BUG_SQE_ELEM(48, __u64,  addr3);
>   	BUILD_BUG_SQE_ELEM_SIZE(48, 0, cmd);
> +	BUILD_BUG_SQE_ELEM(48, __u64, attr_ptr);
> +	BUILD_BUG_SQE_ELEM(56, __u64, attr_type_mask);
>   	BUILD_BUG_SQE_ELEM(56, __u64,  __pad2);
>   
>   	BUILD_BUG_ON(sizeof(struct io_uring_files_update) !=
> diff --git a/io_uring/rw.c b/io_uring/rw.c
> index 0bcb83e4ce3c..71bfb74fef96 100644
> --- a/io_uring/rw.c
> +++ b/io_uring/rw.c
> @@ -257,11 +257,54 @@ static int io_prep_rw_setup(struct io_kiocb *req, int ddir, bool do_import)
>   	return 0;
>   }
...
> @@ -902,6 +976,8 @@ static int __io_read(struct io_kiocb *req, unsigned int issue_flags)
>   	 * manually if we need to.
>   	 */
>   	iov_iter_restore(&io->iter, &io->iter_state);
> +	if (kiocb->ki_flags & IOCB_HAS_METADATA)
> +		io_meta_restore(io);

That can be turned into a helper, but that can be done as a follow up.

I'd also add a IOCB_HAS_METADATA into or around of
io_rw_should_retry(). You're relying on O_DIRECT checks, but that
sounds a bit fragile in the long run.

-- 
Pavel Begunkov

