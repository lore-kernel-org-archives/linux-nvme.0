Return-Path: <SRS0=+gr8=AS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A137C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jul 2020 00:21:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03BBC206F6
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jul 2020 00:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QdtwgwUi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="or4BC1YE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03BBC206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z34QRlrjqEXitScOe8zCHnhQ09RoJaqOlHGePscFSg0=; b=QdtwgwUiORQaJBxMwA8Ogpz04
	0LdZSIaYiXrFH7v4saIJBB1+cJbaB+ctUPks4GLcmlQB63KuHhc90fwZxXSiOn2aliSsPSp6J6NY4
	ymZZp+8Q4uJIohddMa4SJnXhl57Noec8RuOiFg4sRONLKbNSAa92iivPmDkN8gC2KglgUlirKOrGK
	TwaH7sCXJ18o0I65asB8SyyiSUOCRGYCtFujRURdFXFtwRp6XQ/Ga9TN3LvQqMPAEqwcHQMEa2giM
	U/GcY6+NJ/uZpsoYx6+UELWf/trhXqpObOKLnK3cZUMU8GcJyPruMaJXnAbTvshOH11jTcBptWrQT
	yJQQwwVew==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jsbMx-0001h2-5g; Tue, 07 Jul 2020 00:21:55 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jsbMu-0001fy-EW
 for linux-nvme@lists.infradead.org; Tue, 07 Jul 2020 00:21:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594081312; x=1625617312;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RIRD2TaRaRTVygddi25KwGO4OnsCArNDaOFBRT2Z3BY=;
 b=or4BC1YEnuhwpdYUILTU2yaZ3dEQ2PTHpOMFEVDlnWHIit7kBVvgGpIG
 mV1Zk/EgY7YhWbJaQtmCXNsj5nE5yj/hRJAb4IOk3CkRpw5jOFddNNh7/
 hyIByrhKPVMxPgLwmJ5e2mzY7wUdXCbsBBGJLZbxffLU63/+zjW2hCXnc
 rA8lv1qxK4UP2+r75f4N/3Vw3UgIH48WPPkRw+PPMREZ/C2ZPl0bvPTpK
 JEGb1jexMjKHH6vnxD/cuACRx8CA7dnzt7OZ27dlzSqrxodETo+H8nFLH
 eAnqSFNmvNIggkpDUi7VBNU6PreLz1cVQycBFHQq6wYsSXWywFHEHOsKl w==;
IronPort-SDR: ERQMifMezMbl8BOcA2Qurqo27GV4uFHb8P+CRsXS/wdsR9YF1AgKZB3c7h8lNwYHob/a64pb6w
 MXsIXYiJ9I5T50x6fcY3iUl01b8viq6F6A1xFdd9aSuntERu/Wte6s6HqKuITs1nXKmRpub+X4
 Ah3yzaXo/IEShtAwl8KR7JtmAkcy0SyjNvKKFvJemeMmyyOCVgYemwM582bi5ZwfpwT3VLxTLb
 shxLq7ymeGPy9Sjwb47pf+VV+Cf9EcuCWuCKIQMAQ6yl0UYUQIO0xAbW4M6tDPvxbYZAsaK0hp
 Mu4=
X-IronPort-AV: E=Sophos;i="5.75,321,1589212800"; d="scan'208";a="251010521"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2020 08:21:51 +0800
IronPort-SDR: IAFsK984ePn1rExbzHcBPHdPVxA+Drf0rX4IiiA80R9HeC/WXjJDAfyGBe10wGIoiCQE6oChH+
 xkmQtIkgBgyDJInSwK6+tdZVJbCvDOS1k=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2020 17:10:32 -0700
IronPort-SDR: LMlRTUtnfRYtDxgliLsAjz57FQFYE8DVg4IQbCVvFp8x2FmV/e5AN9zfz65RT5PGEuukPzE9KI
 ju2Gg6ECmLkg==
WDCIronportException: Internal
Received: from ioprio.labspan.wdc.com (HELO ioprio.sc.wdc.com) ([10.6.139.89])
 by uls-op-cesaip02.wdc.com with ESMTP; 06 Jul 2020 17:21:52 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: hch@lst.de, james.smart@broadcom.com, kbusch@kernel.org, sagi@grimberg.me
Subject: [RFC PATCH 1/5] nvme-pci: reduce blk_rq_nr_phys_segments calls
Date: Mon,  6 Jul 2020 16:15:20 -0700
Message-Id: <20200706231524.16831-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200706231524.16831-1-chaitanya.kulkarni@wdc.com>
References: <20200706231524.16831-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200706_202152_735146_A1310ED6 
X-CRM114-Status: GOOD (  12.87  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In the fast patch blk_rq_nr_phys_segments() is called multiple times
nvme_queue_rq()(1), nvme_map_data()(2) and nvme_pci_use_sgl()(1). The
function blk_rq_nr_phys_segments() adds a if check for special payload.
The same check gets repeated number of time we call the function in the
fast path.

In order to minimize repetitive check in the fast path this patch
reduces the number of calls to one in the parent function
nvme_queue_rq() after we call the nvme_setup_cmd() so that we have the
right nseg count (with write-zeroes using discard quirk) and adjust the
code in submission path.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/pci.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c283e8dbfb86..07ac28d7d66c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -495,10 +495,10 @@ static void **nvme_pci_iod_list(struct request *req)
 	return (void **)(iod->sg + blk_rq_nr_phys_segments(req));
 }
 
-static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req)
+static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req,
+		unsigned short nseg)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	int nseg = blk_rq_nr_phys_segments(req);
 	unsigned int avg_seg_size;
 
 	if (nseg == 0)
@@ -787,13 +787,13 @@ static blk_status_t nvme_setup_sgl_simple(struct nvme_dev *dev,
 }
 
 static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
-		struct nvme_command *cmnd)
+		struct nvme_command *cmnd, unsigned short nseg)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	blk_status_t ret = BLK_STS_RESOURCE;
 	int nr_mapped;
 
-	if (blk_rq_nr_phys_segments(req) == 1) {
+	if (nseg == 1) {
 		struct bio_vec bv = req_bvec(req);
 
 		if (!is_pci_p2pdma_page(bv.bv_page)) {
@@ -812,7 +812,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 	iod->sg = mempool_alloc(dev->iod_mempool, GFP_ATOMIC);
 	if (!iod->sg)
 		return BLK_STS_RESOURCE;
-	sg_init_table(iod->sg, blk_rq_nr_phys_segments(req));
+	sg_init_table(iod->sg, nseg);
 	iod->nents = blk_rq_map_sg(req->q, req, iod->sg);
 	if (!iod->nents)
 		goto out;
@@ -826,7 +826,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 	if (!nr_mapped)
 		goto out;
 
-	iod->use_sgl = nvme_pci_use_sgls(dev, req);
+	iod->use_sgl = nvme_pci_use_sgls(dev, req, nseg);
 	if (iod->use_sgl)
 		ret = nvme_pci_setup_sgls(dev, req, &cmnd->rw, nr_mapped);
 	else
@@ -860,6 +860,7 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct nvme_queue *nvmeq = hctx->driver_data;
 	struct nvme_dev *dev = nvmeq->dev;
 	struct request *req = bd->rq;
+	unsigned short nseg;
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct nvme_command cmnd;
 	blk_status_t ret;
@@ -879,8 +880,9 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (ret)
 		return ret;
 
-	if (blk_rq_nr_phys_segments(req)) {
-		ret = nvme_map_data(dev, req, &cmnd);
+	nseg = blk_rq_nr_phys_segments(req);
+	if (nseg) {
+		ret = nvme_map_data(dev, req, &cmnd, nseg);
 		if (ret)
 			goto out_free_cmd;
 	}
-- 
2.22.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
