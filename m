Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30579C54F51
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 15:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DFEWI+h+ujBl3AuAySkQO2sTC26NrP8SbkAb+UIr3F0=; b=qNHpMhW4WgIQ1JAtUttPPou9dY
	D9Urs3NPVf/CE8I4WVEGopHJqZ9rVTzYgQSfwt/cgT+lHHLeHcaU7q2xTKZMI1mTfq5HQibBKCdgh
	TIXqVM/ZwTo/jcpPdnVRuSdzirCNl/kFi5VjtllDG0MwkrYlAfhQ++YA8/sWe1jugf2uIK5z0LEsf
	4hMMDRgUUxaaedR/n2c2oxUfU7K0Hqzj/eMWxSVj+LoOHkHS/51w+YBi5bTYC6Sux2IY4YosSI3GE
	lIqziRccXucqcMga5O6bWb6IISAMMWDQzMtT5y5LAkKNgPAWB4blapQWSZHdnJkXrzcHAnMOUPrrL
	CpyYQgOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp5mP-00000008KRQ-2Yn4;
	Wed, 29 Jul 2026 15:01:09 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp4NR-000000086yh-3q81
	for linux-nvme@bombadil.infradead.org;
	Wed, 29 Jul 2026 13:31:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=DFEWI+h+ujBl3AuAySkQO2sTC26NrP8SbkAb+UIr3F0=; b=KcFIFvwXv/D9A2DE28/tclKLCO
	Gns+vVFQaS75O1oWlMwjUqpfnNkzs9KHoOguGcTotU0mL6AHaaTpXGdRFz6eRtAMR7QFVfz6JBIvA
	8A3sxxc7iu0GodmhaDCJhkd1FUlhtiLkJD6LQXCFGKATF3/weEAP2vdaZ3W6WrAurcP6K2Rkthpwk
	YzrypN1lJ6ZuMS+n1C7QyhOZWNnWPAK8AVKT90NL9K7s2nqlMzGiyiv0Nlg38vADnVfj2KjlGpYOh
	JZoRrqlDXRJbpOWeg0jVTaO/ilc9d0mkTeAlUy8A4i/yKCpjMEvDwWasBFWWkMINY5hary8YSOxCa
	4ULBqSSw==;
Received: from mailout1.samsung.com ([203.254.224.24])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wp4NJ-00000005qpR-1df0
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jul 2026 13:31:16 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260729133056epoutp01045ced0b94c7f0e836baa01c569108c0~Gxd1RYM7w1818818188epoutp01W
	for <linux-nvme@lists.infradead.org>; Wed, 29 Jul 2026 13:30:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260729133056epoutp01045ced0b94c7f0e836baa01c569108c0~Gxd1RYM7w1818818188epoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1785331856;
	bh=DFEWI+h+ujBl3AuAySkQO2sTC26NrP8SbkAb+UIr3F0=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=HsWwrPXXRrp/O6gwT2CU2W6MRSa3y4QEz2T9FZg7HvlUguP/w914PJzUXRCbt5/7G
	 UKefM+7DXd9/6vIbCBl2WSX95poBvNMbvIoBPakrN0cJpiKKqEpLUvoNlCcwEX/r3P
	 ccFIxzAri1rej6D74bRxn/e3Nag1sqkfn5YWR2k4=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260729133055epcas5p1ffb351ee3ef2c6b1de5218d34cae5f2c~Gxdz91yo90832108321epcas5p1C;
	Wed, 29 Jul 2026 13:30:55 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.88]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4h9Crt1xWTz6B9m4; Wed, 29 Jul
	2026 13:30:54 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20260729133052epcas5p21fab8c8ffc58e9b13b267e5af8bbbb63~Gxdx2A4v01143011430epcas5p21;
	Wed, 29 Jul 2026 13:30:52 +0000 (GMT)
Received: from [107.122.10.194] (unknown [107.122.10.194]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260729133048epsmtip16941ede4dcd7309490d22dae2d039c4d~GxdtThzIP1847018470epsmtip1c;
	Wed, 29 Jul 2026 13:30:47 +0000 (GMT)
Message-ID: <583fdfb2-5368-467f-a388-6d388859c995@samsung.com>
Date: Wed, 29 Jul 2026 19:00:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/14] io_uring/rsrc: add dmabuf backed registered
 buffers
To: Pavel Begunkov <asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi
	Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	<brauner@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Sumit
	Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?=
	<christian.koenig@amd.com>, Nitesh Shetty <nj.shetty@samsung.com>, Kanchan
	Joshi <joshi.k@samsung.com>, Jason Gunthorpe <jgg@nvidia.com>, Damien Le
	Moal <dlemoal@kernel.org>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer
	<snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, Benjamin
	Marzinski <bmarzins@redhat.com>, David Sterba <dsterba@suse.com>, Ilya
	Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev,
	nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org,
	ceph-devel@vger.kernel.org
Content-Language: en-US
From: Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>
In-Reply-To: <26dcd0ae5c87a3ada5710b14b6894ef343cec6fe.1785274111.git.asml.silence@gmail.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260729133052epcas5p21fab8c8ffc58e9b13b267e5af8bbbb63
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260728213020epcas5p1721e72ba5544abf0b61482da005120d9
References: <cover.1785274111.git.asml.silence@gmail.com>
	<CGME20260728213020epcas5p1721e72ba5544abf0b61482da005120d9@epcas5p1.samsung.com>
	<26dcd0ae5c87a3ada5710b14b6894ef343cec6fe.1785274111.git.asml.silence@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_143112_628030_5FE1966B 
X-CRM114-Status: GOOD (  17.46  )
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

On 7/29/2026 2:59 AM, Pavel Begunkov wrote:
> +static struct io_rsrc_node *io_register_dmabuf(struct io_ring_ctx *ctx,
> +						struct io_uring_regbuf_desc *desc)
> +{
> +	struct io_rsrc_node *node = NULL;
> +	struct io_mapped_ubuf *imu = NULL;
> +	struct io_regbuf_dma *regbuf = NULL;
> +	struct file *target_file = NULL;
> +	struct dma_buf *dmabuf = NULL;
> +	int ret;
> +
> +	if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
> +		return ERR_PTR(-EOPNOTSUPP);
> +	if (ctx->flags & IORING_SETUP_IOPOLL)
> +		return ERR_PTR(-EOPNOTSUPP);
> +	if (desc->uaddr || desc->size)
> +		return ERR_PTR(-EINVAL);
> +
> +	ret = -ENOMEM;
> +	node = io_rsrc_node_alloc(ctx, IORING_RSRC_BUFFER);
> +	if (!node)
> +		return ERR_PTR(-ENOMEM);
> +	imu = io_alloc_imu(ctx, 0);
> +	if (!imu)
> +		goto err;
> +	regbuf = kzalloc(sizeof(*regbuf), GFP_KERNEL);
> +	if (!regbuf)
> +		goto err;
> +
> +	ret = -EBADF;
> +	target_file = fget(desc->target_fd);
> +	if (!target_file)
> +		goto err;
> +
> +	dmabuf = dma_buf_get(desc->dmabuf_fd);
> +	if (IS_ERR(dmabuf)) {
> +		ret = PTR_ERR(dmabuf);
> +		dmabuf = NULL;
> +		goto err;
> +	}
> +	if (dmabuf->size > SZ_1G) {
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	ret = dma_buf_io_ctx_create(target_file, &regbuf->ctx, dmabuf,
> +				    DMA_BIDIRECTIONAL);
> +	if (ret)
> +		goto err;
> +
> +	regbuf->target_file = target_file;
> +	imu->nr_bvecs = 1;

There is no bvec backing a dmabuf imu - should this be 0?

> +	imu->ubuf = 0;
> +	imu->len = dmabuf->size;
> +	imu->folio_shift = 0;
> +	imu->release = io_release_reg_dmabuf;
> +	imu->priv = regbuf;
> +	imu->flags = IO_REGBUF_F_DMABUF;
> +	imu->dir = IO_IMU_DEST | IO_IMU_SOURCE;
> +	refcount_set(&imu->refs, 1);
> +	node->buf = imu;
> +	dma_buf_put(dmabuf);
> +	return node;
> +err:
> +	kfree(regbuf);
> +	if (imu)
> +		io_free_imu(ctx, imu);
> +	if (node)
> +		io_cache_free(&ctx->node_cache, node);
> +	if (target_file)
> +		fput(target_file);
> +	if (dmabuf)
> +		dma_buf_put(dmabuf);
> +	return ERR_PTR(ret);
> +}
> +
> +

nit: extra newline here

> +static int io_import_dmabuf(struct io_kiocb *req,
> +			   int ddir, struct iov_iter *iter,
> +			   struct io_mapped_ubuf *imu,
> +			   size_t len, size_t offset,
> +			   unsigned issue_flags)
> +{
> +	struct io_regbuf_dma *db = imu->priv;
> +	struct dma_buf_io_map *map;
> +
> +	if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
> +		return -EOPNOTSUPP;
> +	if (!len)
> +		return -EFAULT;
> +	if (req->file != db->target_file)
> +		return -EBADF;
> +
> +	if (req->flags & REQ_F_DROP_DMABUF) {
> +		map = req->dmabuf_map;
> +		goto init_iter;
> +	}

O_DIRECT is checked only during registration; we should recheck
(file->f_flags & O_DIRECT) per request.


