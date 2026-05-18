Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF06CD4F52
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2026 10:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AC3DsS6WkhVfH7c3CTSyK//O8EcqzwniBI6lGRkZZsU=; b=OFEFcxyQhYPNnb6UUlepmu5zdH
	U9x2/CNkYGTflhFmhulqmWFX/ocia3rAUhogujyk+z5OLWGTJ9VAs5lCN6q9q7qgQIwVtrcJNU1tP
	goF6O7iLze95uYRe4Yp/nOif4QXQWBtTcLPJanuTcIg/gA/WK9Z90+E7+VQnRBoCIzEA35JYJ8ljp
	mZ5u5zaW27hahs+h8J+t4mATX8oD+A/QxqnK/s9Hv/G9BzKG6YpNaXvpMtPVJ99XiuCJ4/tuixR4a
	Y5gcqbLL8GYiV2GGmeLTPVuVfUPyE/NtknuyERWoF3+89sLD3hvIzZ1oG7tGw50IwXuHrMQ36PMgX
	b5YukQAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOv3t-0000000FBMT-0cOt;
	Mon, 18 May 2026 10:19:01 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOv3m-0000000FBKg-3lJl
	for linux-nvme@lists.infradead.org;
	Mon, 18 May 2026 10:18:59 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260518101848epoutp01d1370f91c311823eca4df7b7ef8fc7ec~woZhZZU3f1787317873epoutp01k
	for <linux-nvme@lists.infradead.org>; Mon, 18 May 2026 10:18:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260518101848epoutp01d1370f91c311823eca4df7b7ef8fc7ec~woZhZZU3f1787317873epoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1779099528;
	bh=AC3DsS6WkhVfH7c3CTSyK//O8EcqzwniBI6lGRkZZsU=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=M7Kg9NpCTyjhzTAkh1MwSRgs5/P7S501/GIoFtAn6lEi40YFO6YeTmJvjiBJsYfuT
	 cyGRuQdbiPFba9oGrBcUKjerwuYQBcoLaAKH26vVLRH2+t5m+eIiZ77C2OnKt0eZbY
	 Zgrmscd2h/eSY58icf0lFirCCxs7zerVsiW7C4F0=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260518101847epcas5p20c363dbebbd73fd72a0354d8a15e55fd~woZg4Vhra2884028840epcas5p2m;
	Mon, 18 May 2026 10:18:47 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.89]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4gJv0Q6lJTz6B9m5; Mon, 18 May
	2026 10:18:46 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260518101846epcas5p3ae97aef88bd9239a92120368958a4a6e~woZfgA5GW2694926949epcas5p3z;
	Mon, 18 May 2026 10:18:46 +0000 (GMT)
Received: from [107.122.10.194] (unknown [107.122.10.194]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260518101843epsmtip16d0504c0f9985d04573419140d5cc9af~woZcw0Yjg1875218752epsmtip1S;
	Mon, 18 May 2026 10:18:43 +0000 (GMT)
Message-ID: <f9e04625-50c6-4fa9-8b12-76496e29f10c@samsung.com>
Date: Mon, 18 May 2026 15:48:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] nvme-pci: implement dma_token backed requests
To: Pavel Begunkov <asml.silence@gmail.com>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Sagi
	Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, Nitesh
	Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, Jason
	Gunthorpe <jgg@nvidia.com>
Content-Language: en-US
From: Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>
In-Reply-To: <50ed7240-d8d3-4816-bcc9-ce8adbbbf841@gmail.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260518101846epcas5p3ae97aef88bd9239a92120368958a4a6e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260518092930epcas5p30d3b49f26efa5969ddcdb15351a886f3
References: <cover.1777475843.git.asml.silence@gmail.com>
	<5cecb1157ab784f9f303a91449fdf11b03aa6002.1777475843.git.asml.silence@gmail.com>
	<20260513083817.GC6461@lst.de>
	<CGME20260518092930epcas5p30d3b49f26efa5969ddcdb15351a886f3@epcas5p3.samsung.com>
	<50ed7240-d8d3-4816-bcc9-ce8adbbbf841@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260518_031855_613858_1CB9F2E4 
X-CRM114-Status: GOOD (  26.97  )
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

On 5/18/2026 2:59 PM, Pavel Begunkov wrote:
>> FYI, I really want SGL support before this get merged, but ignoring that
>> for now:
> 
> I was hoping to let Samsung guys to send a follow up they already have,
> but I'll ask them to have about taking it into this patch set.

I had done patches on top of v3 adding SGL support and PRP list reuse
optimization for the dmabuf path.
Branch: https://github.com/SamsungDS/linux/commits/rw-dmabuf-v3-nvme-opt/

Also pasting the SGL patch here for quick reference:

Subject: [PATCH 1/2] nvme-pci: add sgl support for dmabuf path

Handle dmabuf-backed requests through the SGL setup path too.
Use the cached dmabuf sg_table and keep PRP fallback where allowed.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
  drivers/nvme/host/pci.c | 194 +++++++++++++++++++++++++++++++++++++++-
  1 file changed, 193 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0a49c94dd675..31e37ab8769b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1270,6 +1270,14 @@ static void nvme_pci_sgl_set_data(struct 
nvme_sgl_desc *sge,
         sge->type = NVME_SGL_FMT_DATA_DESC << 4;
  }

+static void nvme_pci_sgl_set_data_addr(struct nvme_sgl_desc *sge,
+               dma_addr_t addr, u32 len)
+{
+       sge->addr = cpu_to_le64(addr);
+       sge->length = cpu_to_le32(len);
+       sge->type = NVME_SGL_FMT_DATA_DESC << 4;
+}
+
  static void nvme_pci_sgl_set_seg(struct nvme_sgl_desc *sge,
                 dma_addr_t dma_addr, int entries)
  {
@@ -1321,6 +1329,176 @@ static blk_status_t 
nvme_pci_setup_data_sgl(struct request *req,
         return iter->status;
  }

+static unsigned int nvme_pci_dmabuf_sgl_nents(struct request *req,
+               dma_addr_t *first_dma, u32 *first_len)
+{
+       struct bio *bio = req->bio;
+       struct nvme_dmabuf_map *map;
+       struct scatterlist *sg;
+       unsigned long tmp;
+       size_t offset = bio->bi_iter.bi_bvec_done;
+       size_t remaining = blk_rq_payload_bytes(req);
+       dma_addr_t last_end = 0;
+       unsigned int nents = 0;
+       dma_addr_t dma = 0;
+       u32 len = 0;
+       bool have = false;
+
+       map = container_of(bio->dmabuf_map, struct nvme_dmabuf_map, base);
+
+       for_each_sgtable_dma_sg(map->sgt, sg, tmp) {
+               size_t sg_len = sg_dma_len(sg);
+               dma_addr_t addr = sg_dma_address(sg);
+
+               if (!remaining)
+                       break;
+               if (offset >= sg_len) {
+                       offset -= sg_len;
+                       continue;
+               }
+
+               addr += offset;
+               sg_len -= offset;
+               offset = 0;
+
+               while (sg_len && remaining) {
+                       u32 chunk = min_t(size_t, remaining, sg_len);
+
+                       if (!have || last_end != addr) {
+                               nents++;
+                               if (nents == 1) {
+                                       dma = addr;
+                                       len = chunk;
+                               }
+                       } else if (nents == 1) {
+                               len += chunk;
+                       }
+
+                       have = true;
+                       last_end = addr + chunk;
+                       addr += chunk;
+                       sg_len -= chunk;
+                       remaining -= chunk;
+               }
+       }
+
+       if (unlikely(remaining))
+               return 0;
+
+       *first_dma = dma;
+       *first_len = len;
+       return nents;
+}
+
+static unsigned int nvme_pci_dmabuf_avg_seg_size(struct request *req)
+{
+       dma_addr_t first_dma;
+       u32 first_len;
+       unsigned int nseg;
+
+       nseg = nvme_pci_dmabuf_sgl_nents(req, &first_dma, &first_len);
+       if (!nseg)
+               return 0;
+       return DIV_ROUND_UP(blk_rq_payload_bytes(req), nseg);
+}
+
+static blk_status_t nvme_rq_setup_dmabuf_sgl(struct request *req,
+                                            struct nvme_queue *nvmeq)
+{
+       struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+       struct bio *bio = req->bio;
+       struct nvme_dmabuf_map *map;
+       size_t length = blk_rq_payload_bytes(req);
+       struct nvme_sgl_desc *sg_list = NULL;
+       dma_addr_t sgl_dma = 0, first_dma, last_end = 0;
+       unsigned int entries, mapped = 0;
+       unsigned long tmp;
+       struct scatterlist *sg;
+       size_t offset, remaining;
+       u32 first_len;
+       bool have = false;
+
+       map = container_of(bio->dmabuf_map, struct nvme_dmabuf_map, base);
+
+       entries = nvme_pci_dmabuf_sgl_nents(req, &first_dma, &first_len);
+       if (!entries)
+               return BLK_STS_IOERR;
+       if (entries > NVME_MAX_SEGS)
+               return BLK_STS_AGAIN;
+
+       iod->cmd.common.flags = NVME_CMD_SGL_METABUF;
+       iod->total_len = length;
+
+       nvme_sync_dma(nvmeq->dev, req, false);
+
+       if (entries == 1) {
+               nvme_pci_sgl_set_data_addr(&iod->cmd.common.dptr.sgl, 
first_dma,
+                                          first_len);
+               return BLK_STS_OK;
+       }
+
+       if (entries <= NVME_SMALL_POOL_SIZE / sizeof(*sg_list))
+               iod->flags |= IOD_SMALL_DESCRIPTOR;
+
+       sg_list = dma_pool_alloc(nvme_dma_pool(nvmeq, iod), GFP_ATOMIC,
+                                &sgl_dma);
+       if (!sg_list)
+               return BLK_STS_RESOURCE;
+       iod->descriptors[iod->nr_descriptors++] = sg_list;
+
+       offset = bio->bi_iter.bi_bvec_done;
+       remaining = length;
+
+       for_each_sgtable_dma_sg(map->sgt, sg, tmp) {
+               size_t sg_len = sg_dma_len(sg);
+               dma_addr_t addr = sg_dma_address(sg);
+
+               if (!remaining)
+                       break;
+               if (offset >= sg_len) {
+                       offset -= sg_len;
+                       continue;
+               }
+
+               addr += offset;
+               sg_len -= offset;
+               offset = 0;
+
+               while (sg_len && remaining) {
+                       u32 chunk = min_t(size_t, remaining, sg_len);
+
+                       if (have && last_end == addr) {
+                               u32 old = le32_to_cpu(sg_list[mapped - 
1].length);
+
+                               sg_list[mapped - 1].length =
+                                       cpu_to_le32(old + chunk);
+                       } else {
+                               if (WARN_ON_ONCE(mapped == entries))
+                                       goto err_free;
+ 
nvme_pci_sgl_set_data_addr(&sg_list[mapped++],
+                                                          addr, chunk);
+                       }
+
+                       have = true;
+                       last_end = addr + chunk;
+                       addr += chunk;
+                       sg_len -= chunk;
+                       remaining -= chunk;
+               }
+       }
+
+       if (unlikely(remaining))
+               goto err_free;
+
+       nvme_pci_sgl_set_seg(&iod->cmd.common.dptr.sgl, sgl_dma, mapped);
+       return BLK_STS_OK;
+
+err_free:
+       iod->nr_descriptors--;
+       dma_pool_free(nvme_dma_pool(nvmeq, iod), sg_list, sgl_dma);
+       return BLK_STS_IOERR;
+}
+
  static blk_status_t nvme_pci_setup_data_simple(struct request *req,
                 enum nvme_use_sgl use_sgl)
  {
@@ -1369,8 +1547,22 @@ static blk_status_t nvme_map_data(struct request 
*req)
         struct blk_dma_iter iter;
         blk_status_t ret;

-       if (nvme_rq_is_dmabuf_attached(req))
+       if (nvme_rq_is_dmabuf_attached(req)) {
+               if (use_sgl == SGL_FORCED) {
+                       ret = nvme_rq_setup_dmabuf_sgl(req, nvmeq);
+                       /* Regular path doesn't fall back if SGLs are 
forced. */
+                       return ret == BLK_STS_AGAIN ? BLK_STS_IOERR : ret;
+               }
+
+               if (use_sgl == SGL_SUPPORTED && sgl_threshold &&
+                   nvme_pci_dmabuf_avg_seg_size(req) >= sgl_threshold) {
+                       ret = nvme_rq_setup_dmabuf_sgl(req, nvmeq);
+                       if (ret != BLK_STS_AGAIN)
+                               return ret;
+               }
+
                 return nvme_rq_setup_dmabuf_map(req, nvmeq);
+       }

         /*
          * Try to skip the DMA iterator for single segment requests, as 
that
--
2.43.0


