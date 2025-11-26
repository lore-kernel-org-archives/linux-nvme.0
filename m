Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C8EFD1118E
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Nov 2025 20:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ot7woekyNWuumg2uCxzEjyg/N5dw0o6ojbbsxWfAufk=; b=rJ0DuUbeFReGLWi6ASP2Cc8QNu
	poG71G6npdWIQ8IoytKL4LpyjfyFv4gJ26nJ9oglqwILyaqpWt7kUkMi12DTA4y/nETwCXmCfwbdM
	SvmEeWvJr1YvJL8gM2ai3o6cPlN+feAtS3nP6DdBN/8A0abYxhb1Ib+c6dtf8An2L2gYqYLNbCED8
	OddjPhkvY//y3luGTtAEaHCOwkJicOYmY1lZ3tguGZKsWSHSOy3EquB0KbV1LHUvunaJ8JhqNc9XX
	iV8ksJu4Bz2SNr5+83TDZO0JtiDvBz/zVJ3Lvl5EsgZ9YzK8TbpAcRwCcqxL2CAojPU6RG/DhAjEo
	XN95yQSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOM6v-0000000FcGa-2T1q;
	Wed, 26 Nov 2025 20:27:33 +0000
Received: from out30-84.freemail.mail.aliyun.com ([115.124.30.84])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOM6t-0000000FcG1-0OCq
	for linux-nvme@lists.infradead.org;
	Wed, 26 Nov 2025 20:27:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=aliyun.com; s=s1024;
	t=1764188847; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=ot7woekyNWuumg2uCxzEjyg/N5dw0o6ojbbsxWfAufk=;
	b=WrGJiWlrrrWy8hEKao5vQfn4lb2Wz0deqHy4806hCUIftbYpEXEJUU8qruXwVxXhGkrHaiS8FR5qT84LDs5Ysj8vlQOAKYzPN6am6c+lZw/T3206mgGgNlfGUxSVZRVsECUXwQizsH0pxlIHitleINMJsCQllKGQqX7luAm9u50=
Received: from aliyun.com(mailfrom:ekorenevsky@aliyun.com fp:SMTPD_---0WtU51Xe_1764188843 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 27 Nov 2025 04:27:25 +0800
Date: Wed, 26 Nov 2025 23:27:21 +0300
From: Eugene Korenevsky <ekorenevsky@aliyun.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nvme: nvme_identify_ns_descs: prevent oob
Message-ID: <aSdiqVR-o6yNav6I@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251126_122731_296839_5E6801CD 
X-CRM114-Status: GOOD (  12.57  )
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

Fix this issue by making nvme_process_id_decs() function aware of
remaining buffer size.

Also simplify nvme_process_id_decs(): replace copy-pasted `case`
branches with table lookup.

Signed-off-by: Eugene Korenevsky <ekorenevsky@aliyun.com>
---
 drivers/nvme/host/core.c | 80 ++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 41 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f1f719351f3f..2d1a4b9882ca 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1481,52 +1481,45 @@ static int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
 	return error;
 }
 
+struct ns_id_info {
+	__u8 nidl;
+	char *name;
+};
+
+#define NS_ID_INFO(nidt) \
+	[nidt] = {nidt##_LEN, #nidt}
+
+static const struct ns_id_info niis[] = {
+	NS_ID_INFO(NVME_NIDT_EUI64),
+	NS_ID_INFO(NVME_NIDT_NGUID),
+	NS_ID_INFO(NVME_NIDT_UUID),
+	NS_ID_INFO(NVME_NIDT_CSI),
+};
+
 static int nvme_process_ns_desc(struct nvme_ctrl *ctrl, struct nvme_ns_ids *ids,
-		struct nvme_ns_id_desc *cur, bool *csi_seen)
+				struct nvme_ns_id_desc *cur, int remain,
+				bool *csi_seen)
 {
-	const char *warn_str = "ctrl returned bogus length:";
-	void *data = cur;
+	const char *warn_fmt = "ctrl returned bogus ns id: %u %u %d %s";
+	const struct ns_id_info *nii;
 
 	switch (cur->nidt) {
+	case NVME_NIDT_CSI:
+		*csi_seen = true;
+		fallthrough;
 	case NVME_NIDT_EUI64:
-		if (cur->nidl != NVME_NIDT_EUI64_LEN) {
-			dev_warn(ctrl->device, "%s %d for NVME_NIDT_EUI64\n",
-				 warn_str, cur->nidl);
-			return -1;
-		}
-		if (ctrl->quirks & NVME_QUIRK_BOGUS_NID)
-			return NVME_NIDT_EUI64_LEN;
-		memcpy(ids->eui64, data + sizeof(*cur), NVME_NIDT_EUI64_LEN);
-		return NVME_NIDT_EUI64_LEN;
 	case NVME_NIDT_NGUID:
-		if (cur->nidl != NVME_NIDT_NGUID_LEN) {
-			dev_warn(ctrl->device, "%s %d for NVME_NIDT_NGUID\n",
-				 warn_str, cur->nidl);
-			return -1;
-		}
-		if (ctrl->quirks & NVME_QUIRK_BOGUS_NID)
-			return NVME_NIDT_NGUID_LEN;
-		memcpy(ids->nguid, data + sizeof(*cur), NVME_NIDT_NGUID_LEN);
-		return NVME_NIDT_NGUID_LEN;
 	case NVME_NIDT_UUID:
-		if (cur->nidl != NVME_NIDT_UUID_LEN) {
-			dev_warn(ctrl->device, "%s %d for NVME_NIDT_UUID\n",
-				 warn_str, cur->nidl);
+		nii = &niis[cur->nidt];
+		if (cur->nidl != nii->nidl || remain < nii->nidl) {
+			dev_warn(ctrl->device, warn_fmt,
+				 cur->nidl, nii->nidl, remain, nii->name);
 			return -1;
 		}
 		if (ctrl->quirks & NVME_QUIRK_BOGUS_NID)
-			return NVME_NIDT_UUID_LEN;
-		uuid_copy(&ids->uuid, data + sizeof(*cur));
-		return NVME_NIDT_UUID_LEN;
-	case NVME_NIDT_CSI:
-		if (cur->nidl != NVME_NIDT_CSI_LEN) {
-			dev_warn(ctrl->device, "%s %d for NVME_NIDT_CSI\n",
-				 warn_str, cur->nidl);
-			return -1;
-		}
-		memcpy(&ids->csi, data + sizeof(*cur), NVME_NIDT_CSI_LEN);
-		*csi_seen = true;
-		return NVME_NIDT_CSI_LEN;
+			return nii->nidl;
+		memcpy(&ids->csi, cur + 1, nii->nidl);
+		return nii->nidl;
 	default:
 		/* Skip unknown types */
 		return cur->nidl;
@@ -1538,7 +1531,8 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl,
 {
 	struct nvme_command c = { };
 	bool csi_seen = false;
-	int status, pos, len;
+	int status, len, remain;
+	struct nvme_ns_id_desc *cur;
 	void *data;
 
 	if (ctrl->vs < NVME_VS(1, 3, 0) && !nvme_multi_css(ctrl))
@@ -1563,17 +1557,21 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl,
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
 
-		len = nvme_process_ns_desc(ctrl, &info->ids, cur, &csi_seen);
+		len = nvme_process_ns_desc(ctrl, &info->ids,
+					   cur, remain - sizeof(*cur),
+					   &csi_seen);
 		if (len < 0)
 			break;
 
 		len += sizeof(*cur);
+		remain -= len;
+		cur += len;
 	}
 
 	if (nvme_multi_css(ctrl) && !csi_seen) {
-- 
2.47.3


