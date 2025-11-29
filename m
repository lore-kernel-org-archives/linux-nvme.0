Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E60CFD2F6
	for <linux-nvme@archiver.kernel.org>; Sat, 29 Nov 2025 20:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=u8DRDLd/Oqd4RgJtj49lXSTClvbtmSA2vS6r0uPhCaM=; b=r5pnXU2isPiqyE1CTEa1fKkKAW
	LOdoQvXgMV40LQ8RhFBlPNdvmD5wrv9QFiUDsWZ9tIrbEg7ZXNOvSVXV16fkYlSytZKC84fm6N7Tz
	CufOF2LVGJM/I/IRZaw6vHRh5OzvK2Duwr91eR/p9ouPbXZGXMdESbWLjJjjAiixjCAnwzX+aOGnI
	8+7EpVY2BlF+SWyFqZkzl0gdzgKWAF5ImNG3mgsEGBjolA6muGSXNT1vZBjpBiW1hGyLQfyINW6+T
	ILI3vxznAGc6uGqUePUt7aIdQLRzgG2cDNI8MyvazIiCZs7yfTEgRwRry0q/SOR9fSbSCMBAH+1X/
	cVLBN9Cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPRAU-00000001m2n-3KWw;
	Sat, 29 Nov 2025 20:03:42 +0000
Received: from out30-77.freemail.mail.aliyun.com ([115.124.30.77])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPRAR-00000001m2R-1Gug
	for linux-nvme@lists.infradead.org;
	Sat, 29 Nov 2025 20:03:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=aliyun.com; s=s1024;
	t=1764446617; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=u8DRDLd/Oqd4RgJtj49lXSTClvbtmSA2vS6r0uPhCaM=;
	b=ZPI3Fxb510xQ+yh9+sFmIA3uhj0Gd7sBqwIxsgfrWRi3ixkdcnV0nRMt60RSxEDaaAJQ2H4GS2lIukKOSF7+241mdVFWZv2BP0jk4lbmsPLCJcwYxpIKAy2Zs7LqUMv8iuHsDzCH9m4RPFm4mQF9K32dfiCz1YjUF3fMMWyvy4k=
Received: from aliyun.com(mailfrom:ekorenevsky@aliyun.com fp:SMTPD_---0WtgOLk1_1764446604 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 30 Nov 2025 04:03:32 +0800
Date: Sat, 29 Nov 2025 23:03:05 +0300
From: Eugene Korenevsky <ekorenevsky@aliyun.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] nvme: nvme_identify_ns_descs: prevent oob
Message-ID: <aStReVPqMORJssLT@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251129_120339_500412_3237F2C7 
X-CRM114-Status: GOOD (  10.78  )
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

Broken or malicious controller can send invalid ns id.
Out-of-band memory access may occur if remaining buffer size
is less than .nidl (ns id length) field of `struct nvme_ns_id_desc`

Fix this issue by counting remaining buffer length and checking
.nidl against it.

Signed-off-by: Eugene Korenevsky <ekorenevsky@aliyun.com>
---
v1->v2:
 * Simplification: do not touch nvme_process_ns_desc()
 * Update commit description
---
 drivers/nvme/host/core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f1f719351f3f..62143f256a63 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1538,7 +1538,8 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl,
 {
 	struct nvme_command c = { };
 	bool csi_seen = false;
-	int status, pos, len;
+	int status, len, remain;
+	struct nvme_ns_id_desc *cur;
 	void *data;
 
 	if (ctrl->vs < NVME_VS(1, 3, 0) && !nvme_multi_css(ctrl))
@@ -1563,17 +1564,21 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl,
 		goto free_data;
 	}
 
-	for (pos = 0; pos < NVME_IDENTIFY_DATA_SIZE; pos += len) {
-		struct nvme_ns_id_desc *cur = data + pos;
-
+	remain = NVME_IDENTIFY_DATA_SIZE;
+	cur = data;
+	while (remain >= sizeof(*cur)) {
 		if (cur->nidl == 0)
 			break;
+		if (sizeof(*cur) + cur->nidl > remain)
+			break;
 
 		len = nvme_process_ns_desc(ctrl, &info->ids, cur, &csi_seen);
 		if (len < 0)
 			break;
 
 		len += sizeof(*cur);
+		remain -= len;
+		cur += len;
 	}
 
 	if (nvme_multi_css(ctrl) && !csi_seen) {
-- 
2.47.3


