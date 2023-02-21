Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B57C6379F
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Feb 2023 23:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kxYAOATXwwZXmQtvACIiPy5oHqnMX7B0skEyunTy3sc=; b=kNAlwKXvjHxI0sZgiRoWhyLQ34
	OS4eREpuZQtRfV8CtxGAzAAb5566/rxYQe8XvY5uCNFimKLGAC3nDh28zdVR0JlYKECXJDinLjV95
	JCEQtQ+Kr4fn1zJQnQqq/dTO9zF/xFev6GvXeYLzGUIiCKYQRYPa1jc6OwudzSx581+lxBpcADprE
	QWcVd/yRXfXxFTvP1e9v3a+koUZmAQW4vJwflYxx/dnf75H0hlNvfULDnZ94G2+2dcb6iJV9GJVN7
	B7QprFZybuPK4zKYyoIfMkVfAzp367C8czM4/Ona4EOL08SlUZX2wlKnYTykw25cgyEW66fKZMlsh
	RMUMzLJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUcWv-00ABP7-KR; Tue, 21 Feb 2023 23:58:41 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUcWt-00ABOd-2H
	for linux-nvme@lists.infradead.org; Tue, 21 Feb 2023 23:58:40 +0000
Received: by mail-pl1-x636.google.com with SMTP id u14so2983763ple.7
        for <linux-nvme@lists.infradead.org>; Tue, 21 Feb 2023 15:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kxYAOATXwwZXmQtvACIiPy5oHqnMX7B0skEyunTy3sc=;
        b=krz8Bxnd4wTi4x00bBO2/hpMchfNH9zO6RksOyW+dvhOTP4LwgUeuf3wcCzBhNUoXv
         wX//Zkp2SgLgo7E1lg4+lbHLvCIW+dh5LMG57emv4k50kgBb+XjTnCOjNsqvarXLzxRK
         X0c8WhZ2llrIaWtbwiDSLZZ+rNvMt90REjZlOZMTWzmnt2VpyQ80ns+ZZNAj+sVcHDXo
         bivCzWv/gye/6++lIUXKbjMletWViBEdT9LC8uQoER4tdg8BOr4m72UmbF8Pt1NT6c09
         M86wNR3tDFHhGzTfJ+YyhCoAHi0JK7D63GKOpWnB84asedBh5JuUZU8eZC9gLYtRNRYG
         kVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxYAOATXwwZXmQtvACIiPy5oHqnMX7B0skEyunTy3sc=;
        b=MWq2+uWNnJXUq9DI4MXkFS/E3CFFe9fLOpqNVnpOLwzYsYobpeR/V6ED83Md/Upc66
         LfDbLmwN37esWEuBjr5jrXxyJFP32wULsQqkxxnHRzq3nBGIrHF5IIyld3Egs8VtF9hN
         E7s0vnGT8FMgLX1og8PtE6n7FR/1SihDe67aO3ewFRSh8t2qbeif2sgQ+QwD7bnwn5D6
         T7EjIfjIDSU+2mCgOSpBUK4qWxkPGDfMgpZll9HP/pB74w1WKAUeQ92tnCodHmB6jsS1
         1Kn71LdOroqCtz+B+4dHV7OH/T+t7TfNb6F0VWJM4WL6vl1r67WAqDNw7A0QEk8SKV2M
         ABXQ==
X-Gm-Message-State: AO0yUKUjrK9QMEoOZgpNQejPfD9LKtkWDQ8nDSW9j6pmK0I9hHUAitjY
	0upxrG7uiFSbN9PjD7jqeLY=
X-Google-Smtp-Source: AK7set8mA8AovJsVEgiRILnqsy5kyIIpZuG+CasVxypbtihvOZT+c/1ugL7OC3W+zb8/8oWG2s3pAA==
X-Received: by 2002:a17:903:28c4:b0:19b:c3e:6e61 with SMTP id kv4-20020a17090328c400b0019b0c3e6e61mr7453237plb.68.1677023916448;
        Tue, 21 Feb 2023 15:58:36 -0800 (PST)
Received: from minwoo-desktop ([1.237.94.73])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902dad000b00189ac5a2340sm6126741plx.124.2023.02.21.15.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 15:58:36 -0800 (PST)
Date: Wed, 22 Feb 2023 08:58:28 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, bvanassche@acm.org,
	hare@suse.de, ming.lei@redhat.com, damien.lemoal@opensource.wdc.com,
	anuj20.g@samsung.com, joshi.k@samsung.com, nitheshshetty@gmail.com,
	gost.dev@samsung.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v7 2/8] block: Add copy offload support infrastructure
Message-ID: <Y/VapDeE98+A6/G2@minwoo-desktop>
References: <20230220105336.3810-1-nj.shetty@samsung.com>
 <CGME20230220105441epcas5p49ffde763aae06db301804175e85f9472@epcas5p4.samsung.com>
 <20230220105336.3810-3-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230220105336.3810-3-nj.shetty@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230221_155839_164027_E1A10DB7 
X-CRM114-Status: GOOD (  13.88  )
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

> +/*
> + * @bdev_in:	source block device
> + * @pos_in:	source offset
> + * @bdev_out:	destination block device
> + * @pos_out:	destination offset

@len is missing here.

> + * @end_io:	end_io function to be called on completion of copy operation,
> + *		for synchronous operation this should be NULL
> + * @private:	end_io function will be called with this private data, should be
> + *		NULL, if operation is synchronous in nature
> + * @gfp_mask:   memory allocation flags (for bio_alloc)
> + *
> + * Returns the length of bytes copied or a negative error value
> + *
> + * Description:
> + *	Copy source offset from source block device to destination block
> + *	device. length of a source range cannot be zero. Max total length of
> + *	copy is limited to MAX_COPY_TOTAL_LENGTH
> + */
> +int blkdev_issue_copy(struct block_device *bdev_in, loff_t pos_in,
> +		      struct block_device *bdev_out, loff_t pos_out, size_t len,
> +		      cio_iodone_t end_io, void *private, gfp_t gfp_mask)

