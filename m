Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39BD1C7EE2A
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Jun 2025 15:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c/bkRqK8NAvWHq4Cw69JTp0ceULHBK86bpIhKanOsjI=; b=dIe5UGKjmIbZ5Xm+raXtNcJ60Q
	7jla99vzFhoUeDvrCWjC769h/89VDUo9CQMv8gcDh0iu1LSMLmlVomqzBi6MFQIL9GOG06I5QwX1D
	WbqmoUgZvMeFH+JgJjeMkOVecXCk1JweefSeVPrV3QPSS8ZWyyzO4qr50PjBbedMWrmlksSpAzEOz
	50ht011Mrbc1CsOjdaj/UaHQO+ysfu1Zby5a7pQFej2pYGPNIRxDABYYHR2HyfopCxl8cAeWpExdh
	hTcg2xayCS4afPd2C+j/lSGVUuCM6RCaPVm1DmWvSRjjW1BxOod8Q4hCJSSK9ylE2u0gbAImkAjJK
	b74+BtFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVAvB-0000000F4IG-2POj;
	Fri, 27 Jun 2025 15:23:21 +0000
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVAhl-0000000F10v-3aiO
	for linux-nvme@lists.infradead.org;
	Fri, 27 Jun 2025 15:09:31 +0000
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-60bfcada295so3745521a12.1
        for <linux-nvme@lists.infradead.org>; Fri, 27 Jun 2025 08:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751036968; x=1751641768; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/bkRqK8NAvWHq4Cw69JTp0ceULHBK86bpIhKanOsjI=;
        b=IWsbfY+BF71lxQWm4+uIOmsN6CAdhSZ9aV+WyVNSX5n1+uYVuyz6GJtrmKTRrdxPVd
         TEVmhZum7CEt8psKgmf7Cn4Qhv9XaO3iq0a3LYmdBdE7iaQRhIiwnJ1cANOQGq2a/rQk
         iUfUfwolniX0gQnN2qtA7wySzpdYOry1p6GxCQqjk4JEHQfjZrxWUZrAxix+RqOWGdmX
         EDVg8rnzj3jrK+H3nhOmXDt6ceue5Hqta75fDSJ74F99yKJVRyOdSkOJXDZ3UGfNlWB5
         m5l+Yi/jH/gL3wCRjQjG6KzX3JvjoPV0PDe4I59m7CjksXUV4upeXCMGJUx+VjTknPVy
         9g8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751036968; x=1751641768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/bkRqK8NAvWHq4Cw69JTp0ceULHBK86bpIhKanOsjI=;
        b=ZD2kDWZ084fnYg5nLdSmUy2Vl9r11ApeC91HfJNShWm7oTmXCD7ZKOKNH+ft/4pMsb
         lLKraxghk91Obx+bvD1uRU6FXG1phnt3RZReAbYgebNsbWdx+vYDeaOBY+m21XnQuQCO
         3ajCTblz1EZT1lEjUNhdn5bY3zgY6ODvbF5tLA5b0OzqGr8q4/bDm8QhIkUA8PqH02sj
         ulxd0YvxDLeGssuRfMyyxT4Id8s+vKcoYwx4oyP0KoID2g1dtnDN+nM1FpTXqPWgC+tQ
         5JKMazLYyO+vVAEo8IRSh6vHDWTbzcHKDMmU/U20yV8iyO9EGWq/SjfbTn+/b8PVDnTN
         QVZw==
X-Forwarded-Encrypted: i=1; AJvYcCWXmTXWfzGBLviexBIZvZl+sKAbKR7N1GIYQAvZalbKeypMsYhy7c+XoOa6C41DsJv6c1WF07hjBz5i@lists.infradead.org
X-Gm-Message-State: AOJu0YwGr/T4WDhgIatb69MwuzSuiFmlxHoRgsIfgqdRzpdvQzZiZXpW
	cn4+3ax8yIT5/dyKXHEN8ut7dpJEAR+MnLwp99cTaZr9HrMWZKJDQf4T
X-Gm-Gg: ASbGncuWB7Et8Xz+rAOFCif8ztaRxf8rpnR4Ma1dshnSN3Wd8MtgTq7DQb6y9HXdQxq
	t3zqrW7DXjcllNUPx8prCK9WjvAxtC60dz+kJZiFKjlU2Z7ZE86s80Oy0QD4uZBLXGnH4hNSBnA
	neNoRnIBl9Kjp5VcU+zck0UZZzNpZC50S9KNYylw9YQTi45MAw8bp+prHRNmN8DqY9wWLiyA8/u
	ICiknK7o7zsbcHFmMsPWs1HaWQKdoiCQIM8cb8DD7+dV8gPj4aCdF9J9rsHSQd9/ua5+lpaj5ek
	NU5ma6jmGS0h9JGR9ntKDr2DD6DeXRDP4z1QZJEE16pGVz310FXERdq0EEOEs2LhrY3YU9jCfYF
	h
X-Google-Smtp-Source: AGHT+IHCVUiFLokvtiYXB1dtfmvpRS0CvWWt48eLG5ozzTOt4+Wf1x/l5tuZe3MRXqZDGA9jBYw9NA==
X-Received: by 2002:a17:906:794e:b0:ae3:4f57:2110 with SMTP id a640c23a62f3a-ae35017b2cfmr334590966b.54.1751036967930;
        Fri, 27 Jun 2025 08:09:27 -0700 (PDT)
Received: from 127.0.0.1localhost ([148.252.147.145])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c014fbsm135802866b.86.2025.06.27.08.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 08:09:27 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: linux-fsdevel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	David Wei <dw@davidwei.uk>,
	Vishal Verma <vishal1.verma@intel.com>,
	asml.silence@gmail.com
Subject: [RFC 06/12] nvme-pci: add support for user passed dma vectors
Date: Fri, 27 Jun 2025 16:10:33 +0100
Message-ID: <0803e60c420ad80570abd736a1549fffaeb6435d.1751035820.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1751035820.git.asml.silence@gmail.com>
References: <cover.1751035820.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250627_080929_916452_F8073DF6 
X-CRM114-Status: GOOD (  18.32  )
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

Implement ->get_dma_device blk-mq callback and add BIO_DMAVEC handling.
If the drivers see BIO_DMAVEC, instead of mapping pages, it'll directly
populate the prp list with the provided dma addresses.

Suggested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/nvme/host/pci.c | 158 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8ff12e415cb5..44a6366f2d9a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -637,11 +637,59 @@ static void nvme_free_descriptors(struct nvme_queue *nvmeq, struct request *req)
 	}
 }
 
+static void nvme_sync_dma(struct nvme_dev *nvme_dev, struct request *req,
+			  enum dma_data_direction dir)
+{
+	bool for_cpu = dir == DMA_FROM_DEVICE;
+	struct device *dev = nvme_dev->dev;
+	struct bio *bio = req->bio;
+	int offset, length;
+	struct dmavec *dmav;
+
+	if (!dma_dev_need_sync(dev))
+		return;
+
+	offset = bio->bi_iter.bi_bvec_done;
+	length = blk_rq_payload_bytes(req);
+	dmav = &bio->bi_dmavec[bio->bi_iter.bi_idx];
+
+	while (length) {
+		u64 dma_addr = dmav->addr + offset;
+		int dma_len = min(dmav->len - offset, length);
+
+		if (for_cpu)
+			__dma_sync_single_for_cpu(dev, dma_addr, dma_len, dir);
+		else
+			__dma_sync_single_for_device(dev, dma_addr,
+						     dma_len, dir);
+
+		length -= dma_len;
+	}
+}
+
+static void nvme_unmap_premapped_data(struct nvme_dev *dev,
+				      struct nvme_queue *nvmeq,
+				      struct request *req)
+{
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+
+	if (rq_data_dir(req) == READ)
+		nvme_sync_dma(dev, req, DMA_FROM_DEVICE);
+
+	if (!iod->dma_len)
+		nvme_free_descriptors(nvmeq, req);
+}
+
 static void nvme_unmap_data(struct nvme_dev *dev, struct nvme_queue *nvmeq,
 			    struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 
+	if (req->bio && bio_flagged(req->bio, BIO_DMAVEC)) {
+		nvme_unmap_premapped_data(dev, nvmeq, req);
+		return;
+	}
+
 	if (iod->dma_len) {
 		dma_unmap_page(dev->dev, iod->first_dma, iod->dma_len,
 			       rq_dma_dir(req));
@@ -846,6 +894,104 @@ static blk_status_t nvme_setup_sgl_simple(struct nvme_dev *dev,
 	return BLK_STS_OK;
 }
 
+static blk_status_t nvme_dma_premapped(struct nvme_dev *dev, struct request *req,
+				   struct nvme_queue *nvmeq,
+				   struct nvme_rw_command *cmnd)
+{
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	int length = blk_rq_payload_bytes(req);
+	u64 dma_addr, first_dma_addr;
+	struct bio *bio = req->bio;
+	int dma_len, offset;
+	struct dmavec *dmav;
+	dma_addr_t prp_dma;
+	__le64 *prp_list;
+	int i;
+
+	if (rq_data_dir(req) == WRITE)
+		nvme_sync_dma(dev, req, DMA_TO_DEVICE);
+
+	offset = bio->bi_iter.bi_bvec_done;
+	dmav = &bio->bi_dmavec[bio->bi_iter.bi_idx];
+	dma_addr = dmav->addr + offset;
+	dma_len = dmav->len - offset;
+	first_dma_addr = dma_addr;
+	offset = dma_addr & (NVME_CTRL_PAGE_SIZE - 1);
+
+	length -= (NVME_CTRL_PAGE_SIZE - offset);
+	if (length <= 0) {
+		iod->first_dma = 0;
+		goto done;
+	}
+
+	dma_len -= (NVME_CTRL_PAGE_SIZE - offset);
+	if (dma_len) {
+		dma_addr += (NVME_CTRL_PAGE_SIZE - offset);
+	} else {
+		dmav++;
+		dma_addr = dmav->addr;
+		dma_len = dmav->len;
+	}
+
+	if (length <= NVME_CTRL_PAGE_SIZE) {
+		iod->first_dma = dma_addr;
+		goto done;
+	}
+
+	if (DIV_ROUND_UP(length, NVME_CTRL_PAGE_SIZE) <=
+	    NVME_SMALL_POOL_SIZE / sizeof(__le64))
+		iod->flags |= IOD_SMALL_DESCRIPTOR;
+
+	prp_list = dma_pool_alloc(nvme_dma_pool(nvmeq, iod), GFP_ATOMIC,
+			&prp_dma);
+	if (!prp_list)
+		return BLK_STS_RESOURCE;
+
+	iod->descriptors[iod->nr_descriptors++] = prp_list;
+	iod->first_dma = prp_dma;
+	i = 0;
+	for (;;) {
+		if (i == NVME_CTRL_PAGE_SIZE >> 3) {
+			__le64 *old_prp_list = prp_list;
+
+			prp_list = dma_pool_alloc(nvmeq->descriptor_pools.large,
+					GFP_ATOMIC, &prp_dma);
+			if (!prp_list)
+				goto free_prps;
+			iod->descriptors[iod->nr_descriptors++] = prp_list;
+			prp_list[0] = old_prp_list[i - 1];
+			old_prp_list[i - 1] = cpu_to_le64(prp_dma);
+			i = 1;
+		}
+
+		prp_list[i++] = cpu_to_le64(dma_addr);
+		dma_len -= NVME_CTRL_PAGE_SIZE;
+		dma_addr += NVME_CTRL_PAGE_SIZE;
+		length -= NVME_CTRL_PAGE_SIZE;
+		if (length <= 0)
+			break;
+		if (dma_len > 0)
+			continue;
+		if (unlikely(dma_len < 0))
+			goto bad_sgl;
+		dmav++;
+		dma_addr = dmav->addr;
+		dma_len = dmav->len;
+	}
+done:
+	cmnd->dptr.prp1 = cpu_to_le64(first_dma_addr);
+	cmnd->dptr.prp2 = cpu_to_le64(iod->first_dma);
+	return BLK_STS_OK;
+free_prps:
+	nvme_free_descriptors(nvmeq, req);
+	return BLK_STS_RESOURCE;
+bad_sgl:
+	WARN(DO_ONCE(nvme_print_sgl, iod->sgt.sgl, iod->sgt.nents),
+			"Invalid SGL for payload:%d nents:%d\n",
+			blk_rq_payload_bytes(req), iod->sgt.nents);
+	return BLK_STS_IOERR;
+}
+
 static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		struct nvme_command *cmnd)
 {
@@ -854,6 +1000,9 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 	blk_status_t ret = BLK_STS_RESOURCE;
 	int rc;
 
+	if (req->bio && bio_flagged(req->bio, BIO_DMAVEC))
+		return nvme_dma_premapped(dev, req, nvmeq, &cmnd->rw);
+
 	if (blk_rq_nr_phys_segments(req) == 1) {
 		struct bio_vec bv = req_bvec(req);
 
@@ -1874,6 +2023,14 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
 	return result;
 }
 
+static struct device *nvme_pci_get_dma_device(struct request_queue *q)
+{
+	struct nvme_ns *ns = q->queuedata;
+	struct nvme_dev *dev = to_nvme_dev(ns->ctrl);
+
+	return dev->dev;
+}
+
 static const struct blk_mq_ops nvme_mq_admin_ops = {
 	.queue_rq	= nvme_queue_rq,
 	.complete	= nvme_pci_complete_rq,
@@ -1892,6 +2049,7 @@ static const struct blk_mq_ops nvme_mq_ops = {
 	.map_queues	= nvme_pci_map_queues,
 	.timeout	= nvme_timeout,
 	.poll		= nvme_poll,
+	.get_dma_device = nvme_pci_get_dma_device,
 };
 
 static void nvme_dev_remove_admin(struct nvme_dev *dev)
-- 
2.49.0


