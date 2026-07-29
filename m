Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08BDCC54F52
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 11:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YCW02Jxoo99jpNlsyhoDkdRYpwZg1zR6VRHvl0BIrE8=; b=LXaf8NnptsI3AL8Y8RVcqGBGF/
	25yjdk6Em2ZGJ0KS24IPGJEpobKFi5aT3mtYA5LAC7Vs47vW+jWOWXQPgBjgIHBmOiiXH0nRJ/Sn8
	TPP/5EkzpwKfgBbCuBoLCgfIlgJPA4Z3cjXSgmKLALBfnzvvlLsySefcAvJ4dPJsLfwFZtUj6uHQl
	fkclWKJYVKk9PBMgE9JLL6SprSsKjeDI7ELSPxUVqChPmaSZXXZQPybRhdeuNN/7pd1vyM3zx15AW
	/qNMcR+xFST3Faz1+BAU97pUKHdaSlHtiLEQPoHxB7a/ZrjcFYyB34w1uAUBIBwg3fsH2v897JsjU
	Agn3K7+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp24r-00000007fzD-0EGE;
	Wed, 29 Jul 2026 11:03:57 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp1Oa-00000007Wcj-0I2Q
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jul 2026 10:20:22 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260729102004epoutp04a6403b75b5e06d6cf3e472c8420bbbbc~Gu3LiDozw0592505925epoutp04P;
	Wed, 29 Jul 2026 10:20:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260729102004epoutp04a6403b75b5e06d6cf3e472c8420bbbbc~Gu3LiDozw0592505925epoutp04P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1785320404;
	bh=YCW02Jxoo99jpNlsyhoDkdRYpwZg1zR6VRHvl0BIrE8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=eDWsTaNmgcGwi1kazmv+E5CPogPPPr6vL2mmbeB1RfWehFQsKfcAB9zpXj77o3NNE
	 kIQwZVVXiHqiLsmtO/MXIpcWlp7GBSIvMnTfb59L4HkAZ30XCSg0iNP74B6djfVWXE
	 knTC/ZRw43C2ERbPsPMwRyLELRQ8MHVxrQnA+IW0=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260729102004epcas5p2561f4970a332635bb0bcb22dc8aab55d~Gu3LO-Erh0974809748epcas5p2K;
	Wed, 29 Jul 2026 10:20:04 +0000 (GMT)
Received: from epcpadp1new (unknown [182.195.40.141]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4h97cg6qpPz6B9mB; Wed, 29 Jul
	2026 10:20:03 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20260729101729epcas5p22470163e142ebd0396fde02f3ab2532b~Gu07MoEUA0811408114epcas5p2g;
	Wed, 29 Jul 2026 10:17:29 +0000 (GMT)
Received: from [107.122.10.194] (unknown [107.122.10.194]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260729101724epsmtip20bd2616b77b7372e21c910f8cdc4cc60~Gu02psnJC1532915329epsmtip2D;
	Wed, 29 Jul 2026 10:17:24 +0000 (GMT)
Message-ID: <81412691.21785320403945.JavaMail.epsvc@epcpadp1new>
Date: Wed, 29 Jul 2026 15:47:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/14] nvme-pci: add SGL support for the dmabuf path
To: Christoph Hellwig <hch@lst.de>, Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Sagi
	Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Nitesh Shetty
	<nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, Tushar Gohad
	<tushar.gohad@intel.com>, William Power <william.power@intel.com>, Phil
	Cayton <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, Damien Le
	Moal <dlemoal@kernel.org>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer
	<snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, Benjamin
	Marzinski <bmarzins@redhat.com>, Vishal Verma <vishal.l.verma@intel.com>,
	David Sterba <dsterba@suse.com>, Ilya Dryomov <idryomov@gmail.com>,
	dm-devel@lists.linux.dev, nvdimm@lists.linux.dev,
	linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org, cpgs@samsung.com
Content-Language: en-US
From: Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>
In-Reply-To: <20260729072117.GI9534@lst.de>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260729101729epcas5p22470163e142ebd0396fde02f3ab2532b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20260729072126epcas5p3ad4422a45f1274b71f15dec8bf487fcc
References: <cover.1785274111.git.asml.silence@gmail.com>
	<5c2e9c3bdd3e87c0c9a6e4395ea199002b83fd36.1785274111.git.asml.silence@gmail.com>
	<CGME20260729072126epcas5p3ad4422a45f1274b71f15dec8bf487fcc@epcas5p3.samsung.com>
	<20260729072117.GI9534@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_032016_761020_E72F72C0 
X-CRM114-Status: GOOD (  27.41  )
X-Mailman-Approved-At: Wed, 29 Jul 2026 04:03:55 -0700
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

>> +static void nvme_pci_sgl_set_data_addr(struct nvme_sgl_desc *sge,
>> +				       dma_addr_t addr, u32 len)
>> +{
>> +	sge->addr = cpu_to_le64(addr);
>> +	sge->length = cpu_to_le32(len);
>> +	sge->type = NVME_SGL_FMT_DATA_DESC << 4;
>> +}
>> +
>>   static void nvme_pci_sgl_set_data(struct nvme_sgl_desc *sge,
>>   		struct blk_dma_iter *iter)
>>   {
>> -	sge->addr = cpu_to_le64(iter->addr);
>> -	sge->length = cpu_to_le32(iter->len);
>> -	sge->type = NVME_SGL_FMT_DATA_DESC << 4;
>> +	nvme_pci_sgl_set_data_addr(sge, iter->addr, iter->len);
>>   }
> 
> The naming is a bit confusing (and me passing the iter to
> nvme_pci_sgl_set_data is probably at faul for that).  So maybe
> spin out a prep patch to rename the old nvme_pci_sgl_set_data
> to nvme_pci_dma_iter_set_sgl or so, and then add the new one
> as nvme_pci_sgl_set_data (as before the dma_iter conversion).
>

Thanks for the detailed review! Will split the rename into a prep patch.

>>
>> +static unsigned int nvme_pci_dmabuf_sgl_nents(struct request *req,
>> +					      dma_addr_t *first_dma,
>> +					      u32 *first_len)
> 
> This is a really good example why the aligning to the opening braces
> produces totally unreadble code..
> 
> But I also don't understand what the use case for this function
> is to start with.  struct sg_table tells us how many segments
> exist on the DMA side in the nents member, which should be just
> fine for the SGL threshold calculation.

sg_table->nents covers the entire exported buffer (<=1GiB), while a
request only covers a subrange[bi_offset, bi_offset+payload). Using
nents would overcount the request's segments.

> 
>> +{
>> +	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>> +	struct bio *bio = req->bio;
>> +	struct nvme_dmabuf_map *map = to_nvme_dmabuf_map(bio->bi_dmabuf_map);
>> +	size_t length = blk_rq_payload_bytes(req);
>> +	struct nvme_sgl_desc *sg_list = NULL;
>> +	dma_addr_t sgl_dma = 0, last_end = 0;
>> +	unsigned int mapped = 0;
>> +	unsigned long tmp;
>> +	struct scatterlist *sg;
>> +	size_t offset, remaining;
>> +	bool have = false;
>> +
>> +	if (!entries)
>> +		return BLK_STS_IOERR;
>> +	if (entries > NVME_MAX_SEGS)
>> +		return BLK_STS_AGAIN;
> 
> Given that the block layer enforced data in rw/command and the
> max_segments limit, why do we need the extra check here?

A dmabuf bio reports nsegs=1 (bio_split_io_at) to the block layer, so 
max_segments isn't enforced against the SG entries actually spanned by 
the request. Hence the explicit check.

> 
>> +			continue;
>> +		}
>> +
>> +		addr += offset;
>> +		sg_len -= offset;
>> +		offset = 0;
>> +
>> +		while (sg_len && remaining) {
> 
> These can't be false on the first iteration, so maybe turn this into
> a do {} while loop?

Will do.

> 
>> +			u32 chunk = min_t(size_t, remaining, sg_len);
>> +
>> +			if (have && last_end == addr) {
>> +				u32 old = le32_to_cpu(sg_list[mapped - 1].length);
>> +
>> +				sg_list[mapped - 1].length = cpu_to_le32(old + chunk);
> 
> Overly long line.
> 
>> +			} else {
>> +				if (WARN_ON_ONCE(mapped == entries))
>> +					goto err_free;
>> +				nvme_pci_sgl_set_data_addr(&sg_list[mapped++],
>> +							   addr, chunk);
>> +			}
> 
> Why do we need this merging?  dma_map_sg should have already done
> any interesting merging, or am I missing something?

Will drop it.


