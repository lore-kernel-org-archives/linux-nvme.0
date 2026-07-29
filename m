Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2898C54F55
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 15:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZDJk27gz63Bjx+XAUOCj+oZxhX4eQ8qfTG8bNQ0cMfY=; b=IaI59CO9WjvXy8M/RTfSCY1AXE
	JEvtS5Om2Uj6J6sjymYm+5FM2Fx673wnQ9uvHPp4HpgCZQcpRevNfkdwwuIgz4s6uycL4L5TrGb/z
	HhGbE0vCV/+iToM9NVEPWAqKwAnbuiTiJrxoDI+eyK4xLPLEceLMU8fQBG4wwXqKMTdSxBPEI/H6i
	soukc/5NmCXyZzfgI2CCHbYM7rddgAgg+y+lv1T85XS/Ymdjnmf7ZQeFNO4J3z6/Vn7IJNVaSzJrF
	sOmcnWHxyet+CWverxmgYrpnI8Tkl5Pzz8LFBczZrnSSsF4tcDXOaBCbwxZTs9SVr66QFF0MGAFA1
	GNTe3TeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp5mP-00000008KRZ-32ay;
	Wed, 29 Jul 2026 15:01:09 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp4NZ-000000086zC-0UkI
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jul 2026 13:31:27 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260729133113epoutp04b5debdf4466253b43b409d3729b7b7c3~GxeE8JkzI2969929699epoutp04I
	for <linux-nvme@lists.infradead.org>; Wed, 29 Jul 2026 13:31:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260729133113epoutp04b5debdf4466253b43b409d3729b7b7c3~GxeE8JkzI2969929699epoutp04I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1785331873;
	bh=ZDJk27gz63Bjx+XAUOCj+oZxhX4eQ8qfTG8bNQ0cMfY=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=a/vx3sBpS/twRkYi1yYleTFghokVhPFGbyJBTuoA0tnB3E+P8eDvzp6JfzVf3SEz3
	 X42C0s/dWsZL55ZqOZKs8UOHQgWrNJJT7qY9tQd+sBH5Uh+TAM8gFdOCvbZR5Gdzow
	 w4HlYs4R0lC4adNXeJEodErFhPZUbOhGLjE6zSqQ=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260729133112epcas5p3bd1d18bb66b0f8808d9cacfabc76c032~GxeENHPUg2902429024epcas5p3H;
	Wed, 29 Jul 2026 13:31:12 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.94]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4h9CsC4dk9z6B9m5; Wed, 29 Jul
	2026 13:31:11 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260729133110epcas5p4c215a866cd371ec48e2608765dc26ad9~GxeCj-bm90481504815epcas5p4d;
	Wed, 29 Jul 2026 13:31:10 +0000 (GMT)
Received: from [107.122.10.194] (unknown [107.122.10.194]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260729133105epsmtip2d312a27a0649b2d7cf4807b11b2517f0~Gxd95g22x2496024960epsmtip2k;
	Wed, 29 Jul 2026 13:31:05 +0000 (GMT)
Message-ID: <73317bf9-f7df-43f9-abc2-daa25a675485@samsung.com>
Date: Wed, 29 Jul 2026 19:01:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/14] io_uring/rsrc: extend buffer update
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
In-Reply-To: <633d33d8e278999f55126794fce948343403494a.1785274111.git.asml.silence@gmail.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260729133110epcas5p4c215a866cd371ec48e2608765dc26ad9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260728213008epcas5p418dfc10b7ef786e162ade86d14430475
References: <cover.1785274111.git.asml.silence@gmail.com>
	<CGME20260728213008epcas5p418dfc10b7ef786e162ade86d14430475@epcas5p4.samsung.com>
	<633d33d8e278999f55126794fce948343403494a.1785274111.git.asml.silence@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_063125_490895_FD10F8D9 
X-CRM114-Status: GOOD (  13.39  )
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
> @@ -882,8 +894,13 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
>   	struct io_imu_folio_data data;
>   	bool coalesced = false;
>   
> -	if (!uaddr) {
> -		if (size)
> +	if (desc->type >= __IO_REGBUF_TYPE_MAX)
> +		return ERR_PTR(-EINVAL);
> +	if (!mem_is_zero(&desc->__resv, sizeof(desc->__resv)))
> +		return ERR_PTR(-EINVAL);

desc->flags  isn't validated here, unlike __resv. nonzero flags should 
be rejected too?

> +
> +	if (desc->type == IO_REGBUF_TYPE_EMPTY) {
> +		if (uaddr || size)
>   			return ERR_PTR(-EFAULT);
>   		/* remove the buffer without installing a new one */
>   		return NULL;


