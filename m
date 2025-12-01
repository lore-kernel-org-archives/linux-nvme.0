Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B09D7D116F1
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Dec 2025 19:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2JWxJbOofoBM/+VVtNq/4gaPlvGNVnbgA53eVeG52eA=; b=LNj9gO/3+sdZf37s7Ixd6N9Ord
	YoNTbIVoO0uYiEU7IZ80KWOktVad0Ug55u43om2iKBOQVjbhqIAaM0znZm590COTdq5LSdIl3y2up
	rEblM6AOBufd9t4sbXhdChBYb+AXKHLASnizb0ntSWjd5N3RO+GVgo5AR/N2d/ECdp2C06IAt+WJ/
	T2TDB7aVqe8c0aGUm4Y+l23q0A0O4iQ5zbbNXpV6QDtfCGEsOKyaFT3GH3OaaKWJzaNkUAOnqMAgf
	1ZtxLPaInLrh7oVf4xRc53aY+jy3zT/Q666MUzSm5An/qHVyUYrOsBA6yqxlLmPkKfrA01nFXuGeh
	6mBy1M2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQ9oB-00000004TFy-2a0M;
	Mon, 01 Dec 2025 19:43:39 +0000
Received: from out30-86.freemail.mail.aliyun.com ([115.124.30.86])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQ9o8-00000004TF8-1eGI
	for linux-nvme@lists.infradead.org;
	Mon, 01 Dec 2025 19:43:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=aliyun.com; s=s1024;
	t=1764618210; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=2JWxJbOofoBM/+VVtNq/4gaPlvGNVnbgA53eVeG52eA=;
	b=OBMDfyLW4Bh8H3N+yAdLPvp2hZ0zObtH/k+9C/7bQ4DLSRdl0cAuXQrOm3ap6Esc6dbd1wha2d8FQZuz98Ul1o+ulS2/1F0S9pQ89tac9eUpHKKSfZVt3L8wBNicjAl2caioFp/8PI9R83+aKFvmfLOkcQzZGEO79csRTck/RGU=
Received: from aliyun.com(mailfrom:ekorenevsky@aliyun.com fp:SMTPD_---0WttVQ--_1764618205 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Dec 2025 03:43:27 +0800
Date: Mon, 1 Dec 2025 22:43:23 +0300
From: Eugene Korenevsky <ekorenevsky@aliyun.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] nvme: nvme_identify_ns_descs: prevent oob
Message-ID: <aS3v2_VcV8IwsT6g@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251201_114337_031481_AF7B36DD 
X-CRM114-Status: GOOD (  12.63  )
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

Fix this issue by checking (header size + .nidl) against
remaining buffer length.

Also small minor related fix: `pos` should be unsigned size_t,
not signed int.

Signed-off-by: Eugene Korenevsky <ekorenevsky@aliyun.com>
---
v1->v2:
 * Simplification: do not touch nvme_process_ns_desc()
 * Update commit description
v2->v3:
 * Even more simplification
 * Replace while with do-while as first pre-loop condition
   check is pointless
 * Change `pos` type: int -> size_t
 * Update commit description
---
 drivers/nvme/host/core.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f1f719351f3f..73263545e3cd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1538,8 +1538,10 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl,
 {
 	struct nvme_command c = { };
 	bool csi_seen = false;
-	int status, pos, len;
+	int status, len;
+	size_t pos;
 	void *data;
+	struct nvme_ns_id_desc *cur;
 
 	if (ctrl->vs < NVME_VS(1, 3, 0) && !nvme_multi_css(ctrl))
 		return 0;
@@ -1563,18 +1565,23 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl,
 		goto free_data;
 	}
 
-	for (pos = 0; pos < NVME_IDENTIFY_DATA_SIZE; pos += len) {
-		struct nvme_ns_id_desc *cur = data + pos;
+	pos = 0;
+	do {
+		cur = data + pos;
 
 		if (cur->nidl == 0)
 			break;
+		/* check ns id desc does not exceed remaining buffer by size */
+		if (cur->nidl + sizeof(*cur) > NVME_IDENTIFY_DATA_SIZE - pos)
+			break;
 
 		len = nvme_process_ns_desc(ctrl, &info->ids, cur, &csi_seen);
 		if (len < 0)
 			break;
 
-		len += sizeof(*cur);
-	}
+		pos += sizeof(*cur);
+		pos += len;
+	} while (pos < NVME_IDENTIFY_DATA_SIZE - sizeof(*cur));
 
 	if (nvme_multi_css(ctrl) && !csi_seen) {
 		dev_warn(ctrl->device, "Command set not reported for nsid:%d\n",
-- 
2.47.3


