Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB67C53219
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 15:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GoC91kED98vuJAvVTLdEFxjWPhyWXTYJuu42/1RW6zQ=; b=zdTUp04vnJE2e7huEAVDjEX7Ta
	vfV7Za7zPKFG1PTA7mCXQKxirG8NTDrplV+RCifPtl/vgyK/vmWk0UaqGt5E3YpBanUAbkjWaoNIM
	YtTxZWHc37p7dRserjp7YN2Rm4X+R74685Sg/Yay3yeA4aAt+tmdbeRro8p6vp0gV1mkdljhvr8tU
	G0SbZwdlFylJs/2P1lTQ/CXKAUl81mf4B/xVRC+RYxTfAb3bgFiGlo6ItslKW1xsG9c2q4FqmlPWL
	tv8FXszP19B4ooFZd+WJOMXflqISpKQzH0EAkJsm36bC2nTG6Ky5M9Cxb5ptKaVQslCgWBFkraCGx
	L2qK3SXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp5mQ-00000008KSg-00iy;
	Wed, 29 Jul 2026 15:01:10 +0000
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp4ZW-00000008APn-0ZjM
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jul 2026 13:43:47 +0000
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-6984169c126so1590647a12.1
        for <linux-nvme@lists.infradead.org>; Wed, 29 Jul 2026 06:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785332624; x=1785937424; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GoC91kED98vuJAvVTLdEFxjWPhyWXTYJuu42/1RW6zQ=;
        b=AlczRHn3EFOMylHWBy7XaTrpnX15nft+/HkXXewrdJ6Fs24iFs9iGTpXsopD6Olb7J
         TA12ZtwrOUP/OO9jPyJZyW+/Io6kQdDQWWNB/Zj5EDc02Slx5cTdzLKDqh+RDov5dup0
         xK9BYkDG6KmH4OBOsBi+7Dz+sW/Cc8VARPihDxlvcoc7Xv0lq2wpyA583Lzbu3NWohQo
         0EGexdVF7s3Hklt6u81he3dGy7G5FFm2zEIFUaVDSZOLTMf0tbZgmKRcv4mxCwVgAIrs
         xVeMTYDLUIRPyiTeS2XfXJBts7Weyekx2iq3Xi2e6CuZ8n4G89AXP5w6htr48FU9ZH/E
         AoeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785332624; x=1785937424;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GoC91kED98vuJAvVTLdEFxjWPhyWXTYJuu42/1RW6zQ=;
        b=E/lbYBIGanxdUdIG+VVNs7XgiAbo9F1Il2eS/l3n+j/yJ6bi26FAFpB/YKiaR8LS9C
         GFU65d0PUyD7GNvbvEq+up6AY0oUgStdAUnk7d7knZLP5I5a8K6Hx8cYM8RrBVrNhW/F
         m1cR6OUDt1dOwnIsZNwZLFyj4DfFbbKLz2glNV9efglsdKAT8e/7rjlPTWUDu7Ulwy6h
         okt0WFRaZ1CD9M3D1o96IyQSmPOJ7RyydWgG4ywVJ3hIAeD0DTqtcNzZGeowWco8R2jI
         hzY6gYBKlNA85MPYxnMdYLMZj2DQ/QK6NNm5PHedTZXxVnjG6uep17/Xn4nU4V/WbDvb
         eSRg==
X-Forwarded-Encrypted: i=1; AHgh+RoFkGKEoMvXADhDHQdMFcLF7o6HSk0OpLn6l8onQJrXiSlTHBSDgKxfy4doJez3CRwm3olQ4TLCgPGX@lists.infradead.org
X-Gm-Message-State: AOJu0YwjKEjTsS42DU1jMspmNf5WSUveaDV3ZNLk+URmoe5zdKY8XfD9
	tyC1Yf0+eJRe8qu+yKJqQW/uzXWT/L8QbICK8AuQ07TUWi1ykSY9NkM0
X-Gm-Gg: AR+sD10wOhhXtRSJpwW7+6LXo1MwZE+PD3Ui8KHXoJKSP8urfoYBykYefN47zUBpBcN
	YqNEUbfN3mW1I1x6lar1u/7bI8mfx2qLpSKHfzYXlvoHT0dH/js/sWBRZIOC9hkOwW3qNlHwF45
	gwRDR+LW1DFBKxsp7HbEs2d6Fea+d1IwdWU8HiPhf55D3hlcTkg+f0SW7/WBetkpuJZD1i1xWaq
	b3fB9bTryoF7gaR8uCjuULsOe/hz17fzFZRwsaMT9Bqwj+zxai3hPwoB36J7cTZMs+wHVUJeDcM
	b1ysjn2yevrN5V3r2hQ82M+HW6qA2+iKq0DrIw6yGf/FqjN2lr7QKY4Oq8nb16fmqCF1t6EhqgW
	UTyBXzbfebLWuNX0VjYrqPdNIQjrnLaGPOGJ5LP8YQBkEW2LVdj2sbtG60Dv9ad/fFGUZMNALGF
	zZh2KngClLT4OY1QXXN8wq9iDiiewI83bmiNymDK0w74UJgfaEbCknEplWCLSx80kylvKDEBnJg
	0hQvpfXu9M88oB1XQGU5VhBcames6xxUlUZfJnatEo5pCjDjOKWtzdH+k8VuLLIZc6T/s6mW4eD
	gfoWbup+Vg2eeFzcv4U=
X-Received: by 2002:a05:6402:24c8:b0:697:ecb4:b86c with SMTP id 4fb4d7f45d1cf-6a034a0b240mr2761963a12.2.1785332624180;
        Wed, 29 Jul 2026 06:43:44 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:640])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a050c49fb5sm868560a12.14.2026.07.29.06.43.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 06:43:43 -0700 (PDT)
Message-ID: <0df2f832-e8a8-4fdd-a5b6-e08657c2891f@gmail.com>
Date: Wed, 29 Jul 2026 14:43:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/14] io_uring/rsrc: add dmabuf backed registered
 buffers
To: Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>, Jens Axboe
 <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Damien Le Moal <dlemoal@kernel.org>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, David Sterba <dsterba@suse.com>,
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org
References: <cover.1785274111.git.asml.silence@gmail.com>
 <CGME20260728213020epcas5p1721e72ba5544abf0b61482da005120d9@epcas5p1.samsung.com>
 <26dcd0ae5c87a3ada5710b14b6894ef343cec6fe.1785274111.git.asml.silence@gmail.com>
 <583fdfb2-5368-467f-a388-6d388859c995@samsung.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <583fdfb2-5368-467f-a388-6d388859c995@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_064346_205541_9DF4360E 
X-CRM114-Status: GOOD (  17.12  )
X-Mailman-Approved-At: Wed, 29 Jul 2026 08:01:06 -0700
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

On 7/29/26 14:30, Anuj Gupta/Anuj Gupta wrote:
> On 7/29/2026 2:59 AM, Pavel Begunkov wrote:
>> +static struct io_rsrc_node *io_register_dmabuf(struct io_ring_ctx *ctx,
>> +						struct io_uring_regbuf_desc *desc)
>> +{
>> +	struct io_rsrc_node *node = NULL;
>> +	struct io_mapped_ubuf *imu = NULL;
>> +	struct io_regbuf_dma *regbuf = NULL;
>> +	struct file *target_file = NULL;
>> +	struct dma_buf *dmabuf = NULL;
>> +	int ret;
>> +
>> +	if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
>> +		return ERR_PTR(-EOPNOTSUPP);
>> +	if (ctx->flags & IORING_SETUP_IOPOLL)
>> +		return ERR_PTR(-EOPNOTSUPP);
>> +	if (desc->uaddr || desc->size)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	ret = -ENOMEM;
>> +	node = io_rsrc_node_alloc(ctx, IORING_RSRC_BUFFER);
>> +	if (!node)
>> +		return ERR_PTR(-ENOMEM);
>> +	imu = io_alloc_imu(ctx, 0);
>> +	if (!imu)
>> +		goto err;
>> +	regbuf = kzalloc(sizeof(*regbuf), GFP_KERNEL);
>> +	if (!regbuf)
>> +		goto err;
>> +
>> +	ret = -EBADF;
>> +	target_file = fget(desc->target_fd);
>> +	if (!target_file)
>> +		goto err;
>> +
>> +	dmabuf = dma_buf_get(desc->dmabuf_fd);
>> +	if (IS_ERR(dmabuf)) {
>> +		ret = PTR_ERR(dmabuf);
>> +		dmabuf = NULL;
>> +		goto err;
>> +	}
>> +	if (dmabuf->size > SZ_1G) {
>> +		ret = -EINVAL;
>> +		goto err;
>> +	}
>> +
>> +	ret = dma_buf_io_ctx_create(target_file, &regbuf->ctx, dmabuf,
>> +				    DMA_BIDIRECTIONAL);
>> +	if (ret)
>> +		goto err;
>> +
>> +	regbuf->target_file = target_file;
>> +	imu->nr_bvecs = 1;
> 
> There is no bvec backing a dmabuf imu - should this be 0?

Doesn't really matter as it's not used. It's 1 to say that
it's just 1 contig segment, but I can just zero it to avoid
confusion.

> 
>> +	imu->ubuf = 0;
>> +	imu->len = dmabuf->size;
>> +	imu->folio_shift = 0;
>> +	imu->release = io_release_reg_dmabuf;
>> +	imu->priv = regbuf;
>> +	imu->flags = IO_REGBUF_F_DMABUF;
>> +	imu->dir = IO_IMU_DEST | IO_IMU_SOURCE;
>> +	refcount_set(&imu->refs, 1);
>> +	node->buf = imu;
>> +	dma_buf_put(dmabuf);
>> +	return node;
>> +err:
>> +	kfree(regbuf);
>> +	if (imu)
>> +		io_free_imu(ctx, imu);
>> +	if (node)
>> +		io_cache_free(&ctx->node_cache, node);
>> +	if (target_file)
>> +		fput(target_file);
>> +	if (dmabuf)
>> +		dma_buf_put(dmabuf);
>> +	return ERR_PTR(ret);
>> +}
>> +
>> +
> 
> nit: extra newline here
> 
>> +static int io_import_dmabuf(struct io_kiocb *req,
>> +			   int ddir, struct iov_iter *iter,
>> +			   struct io_mapped_ubuf *imu,
>> +			   size_t len, size_t offset,
>> +			   unsigned issue_flags)
>> +{
>> +	struct io_regbuf_dma *db = imu->priv;
>> +	struct dma_buf_io_map *map;
>> +
>> +	if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
>> +		return -EOPNOTSUPP;
>> +	if (!len)
>> +		return -EFAULT;
>> +	if (req->file != db->target_file)
>> +		return -EBADF;
>> +
>> +	if (req->flags & REQ_F_DROP_DMABUF) {
>> +		map = req->dmabuf_map;
>> +		goto init_iter;
>> +	}
> 
> O_DIRECT is checked only during registration; we should recheck
> (file->f_flags & O_DIRECT) per request.

Nobody should be able to clear O_DIRECT, unless I missed something?
And fwiw, io_uring wouldn't be the right place to do it.

-- 
Pavel Begunkov


