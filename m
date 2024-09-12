Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF0DEE6453
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 06:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9OuexuUi9RyPcJz+XVDeQiH8hx9SKCRAkqUYcyV+ws4=; b=jKXjYHW6+boW7k9WDTqBk/VyUM
	DmxF8tyEm8RBukB9lae12mvXsU7vbCkYE11neeCZj1zcfFiyQ2ousWQzUhIUKX+/8dpLe4Ka1DbvS
	8RmbhfE8Qxgmch3ebeZfo87Br2MjxP/8Hi+tM4pfNPcIedcuTMqKBuzbatmUIC7lNnjqgCJpkMPob
	yXiK7Ja8kuLv72uvaXQImL9wg4i1gAxIqdZ2aC37Pdstg31ruUEjjTLaUF3DZvvPFU1j87uPwABo9
	KRbAMI4aX2vyR0BPBWlMir7XM+elr+GLaUMDrfcaMSkMuEfH4+s+fa3htK68RXohLEwYrfsWmxB4X
	nRoGZKTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sodYd-0000000C3MS-1lcD;
	Thu, 12 Sep 2024 06:43:59 +0000
Received: from mta-04.yadro.com ([89.207.88.248])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sodYW-0000000C3It-1722
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 06:43:55 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 06912C0004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1726123429; bh=9OuexuUi9RyPcJz+XVDeQiH8hx9SKCRAkqUYcyV+ws4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=WIebqcPN4MhSK9B9rpbf2zLp/BSFtqOT6NvCSZIbEkpLhyGoVJsyfU110qqxfy97z
	 mPjr+m7LLnPvzJQndI+aTUO4F4Zj4qOVVUrDXbtcaTKiKORmsELYckDf693PWMIsQE
	 /8xrLFdZwcRAfyD6sJyWQiIjsBVVr5AGEkwIWarFVEkAK/9jioSv1Kjtpkblj4kW+I
	 J6kv4tZZkGcSawJL+FJfJDbWzjPK0zF/ZLfM/F7MvAsT9WTQA9O1LUu9HJxDlpex22
	 Sia5Jfdq776tSGkqmxPhfn5CtYV+2M6H+O/Obzne1gH/m1/niHS76Lul7WcLfi7Ned
	 KdvI9/cBFWFWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1726123429; bh=9OuexuUi9RyPcJz+XVDeQiH8hx9SKCRAkqUYcyV+ws4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=LJjJG81P7gwGuKR8jf6yWg2ANGFb9HcwBduh6jGbuljunnGvtdSEyLpvYcqoHJ2Zt
	 ETRMdUmYyt28f1/KGuC+xVMeUUz9kytxd7c+8hOGaXNr4ZJNl4cans6EeZYtiFyhNP
	 pF9CEj5EzKMFKNoxelGWxH0WgAH+ePwaepfZWFm1PPjaGoW4H65eQjcN5/2g+riFln
	 +GhIqPKyMnadybKQ2/q4ThnkLLWJquN9A2uTdfWzSxZpHj3CpwaBNcr98Vf/sNcI5S
	 dWR3EEc/Cz3EutmgmIwqfSLePADNUcrE8RM8Cohe/GfqZGwPPM48KZmnQPkfLMpc9a
	 nKhM2noYXbP7w==
From: Dmitry Bogdanov <d.bogdanov@yadro.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, James Smart <james.smart@broadcom.com>
CC: <linux-nvme@lists.infradead.org>, <linux@yadro.com>, Dmitry Bogdanov
	<d.bogdanov@yadro.com>
Subject: [PATCH 1/7] nvmet: add support of Compare command
Date: Thu, 12 Sep 2024 09:42:53 +0300
Message-ID: <20240912064259.5228-2-d.bogdanov@yadro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240912064259.5228-1-d.bogdanov@yadro.com>
References: <20240912064259.5228-1-d.bogdanov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-Exch-05.corp.yadro.com (172.17.10.109) To
 T-EXCH-09.corp.yadro.com (172.17.11.59)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_234353_047349_BEB87C8E 
X-CRM114-Status: GOOD (  18.55  )
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

Report that Compare command is supported.
Make a common function for comparision of datas from the command and
from the backstore.

Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
---
 drivers/nvme/target/admin-cmd.c |  4 ++-
 drivers/nvme/target/core.c      | 55 +++++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h     |  2 ++
 3 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index d64480f01f4a..e555b9efebfb 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -176,6 +176,7 @@ static void nvmet_get_cmd_effects_nvm(struct nvme_effects_log *log)
 	log->iocs[nvme_cmd_read] =
 	log->iocs[nvme_cmd_flush] =
 	log->iocs[nvme_cmd_dsm]	=
+	log->iocs[nvme_cmd_compare] =
 		cpu_to_le32(NVME_CMD_EFFECTS_CSUPP);
 	log->iocs[nvme_cmd_write] =
 	log->iocs[nvme_cmd_write_zeroes] =
@@ -433,7 +434,8 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	id->nn = cpu_to_le32(NVMET_MAX_NAMESPACES);
 	id->mnan = cpu_to_le32(NVMET_MAX_NAMESPACES);
 	id->oncs = cpu_to_le16(NVME_CTRL_ONCS_DSM |
-			NVME_CTRL_ONCS_WRITE_ZEROES);
+			NVME_CTRL_ONCS_WRITE_ZEROES |
+			NVME_CTRL_ONCS_COMPARE);
 
 	/* XXX: don't report vwc if the underlying device is write through */
 	id->vwc = NVME_CTRL_VWC_PRESENT;
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index ed2424f8a396..b3194d66f7dc 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -751,6 +751,59 @@ static void nvmet_set_error(struct nvmet_req *req, u16 status)
 	req->cqe->status |= cpu_to_le16(1 << 14);
 }
 
+int nvmet_compare_sg(struct nvmet_req *req)
+{
+	unsigned int data_len = nvmet_rw_data_len(req);
+	unsigned int offset = 0;
+	struct scatterlist *sg;
+	unsigned int len;
+	u8 *datap = NULL;
+	u8 *buf = NULL;
+	int ret = 0;
+	int i;
+
+	buf = kmalloc(data_len, GFP_ATOMIC);
+	if (!buf)
+		return NVME_SC_INTERNAL;
+
+	/* Copy READ data to the buffer */
+	ret = nvmet_copy_from_sgl(req, 0, buf, data_len);
+	if (ret)
+		goto error;
+
+	/* Compare on-disk data with the data provided by the initiator */
+	for_each_sg(req->cmp_sg, sg, req->sg_cnt, i) {
+		datap = kmap_atomic(sg_page(sg));
+		if (!datap) {
+			ret = NVME_SC_INTERNAL;
+			goto error;
+		}
+
+		len = min_t(unsigned int, sg->length, data_len);
+
+		if (memcmp(datap, buf + offset, len) != 0) {
+			ret = NVME_SC_COMPARE_FAILED;
+			goto error;
+		}
+
+		kunmap_atomic(datap);
+
+		offset += len;
+		if (offset == data_len)
+			break;
+	}
+
+	kfree(buf);
+
+	return 0;
+error:
+	if (datap)
+		kunmap_atomic(datap);
+
+	kfree(buf);
+	return ret;
+}
+
 static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
 {
 	struct nvmet_ns *ns = req->ns;
@@ -887,6 +940,7 @@ static inline u16 nvmet_io_cmd_check_access(struct nvmet_req *req)
 		switch (req->cmd->common.opcode) {
 		case nvme_cmd_read:
 		case nvme_cmd_flush:
+		case nvme_cmd_compare:
 			break;
 		default:
 			return NVME_SC_NS_WRITE_PROTECTED;
@@ -953,6 +1007,7 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	req->sq = sq;
 	req->ops = ops;
 	req->sg = NULL;
+	req->cmp_sg = NULL;
 	req->metadata_sg = NULL;
 	req->sg_cnt = 0;
 	req->metadata_sg_cnt = 0;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 190f55e6d753..8a26b8b4dc63 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -373,6 +373,7 @@ struct nvmet_req {
 	struct nvmet_ns		*ns;
 	struct scatterlist	*sg;
 	struct scatterlist	*metadata_sg;
+	struct scatterlist	*cmp_sg;
 	struct bio_vec		inline_bvec[NVMET_MAX_INLINE_BIOVEC];
 	union {
 		struct {
@@ -602,6 +603,7 @@ void nvmet_bdev_ns_revalidate(struct nvmet_ns *ns);
 void nvmet_file_ns_revalidate(struct nvmet_ns *ns);
 bool nvmet_ns_revalidate(struct nvmet_ns *ns);
 u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts);
+int nvmet_compare_sg(struct nvmet_req *req);
 
 bool nvmet_bdev_zns_enable(struct nvmet_ns *ns);
 void nvmet_execute_identify_ctrl_zns(struct nvmet_req *req);
-- 
2.25.1


