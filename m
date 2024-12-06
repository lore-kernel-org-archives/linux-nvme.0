Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B81E77173
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Dec 2024 22:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aqSWgHfWMagd/tVBxU1j+3PESQendeFXQhXEUWomWZI=; b=5DFTsb7gR2N9ObVjav7jaZR4dL
	oz7UiEvj7HkKn+4e+Zl/wf+bUhl0iPCHAMiuvGL/cLK+q1X1y4Pd+IL418ny7PbgmzU0sNdlS3HMO
	TJVWQFgqNfwro5wtK1LnHyVczYPY5JPODCTJIORxZynmuX1Gz7fwTJwTiIG74CbIqVl/+J7BF0ASh
	14BF2MzHmXLEc1bYtVHvWFOOLeoGrEHW8tZfg9mbvh3src2o7kE2yK82UDELIS4Fl+L9fqig2GTSR
	7fRT6D7+NWtRFA+uKwl9enkLLO7BJG+mTv1EBlPlkmsQuXBwMjaRaMVFZmN2/RgiO46DIwQtS2/tm
	hV2JO1xQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJgpy-00000002vE3-10UY;
	Fri, 06 Dec 2024 22:30:14 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJgpv-00000002vAj-26ck
	for linux-nvme@lists.infradead.org;
	Fri, 06 Dec 2024 22:30:12 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6LhGi2032186
	for <linux-nvme@lists.infradead.org>; Fri, 6 Dec 2024 14:30:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=aqSWgHfWMagd/tVBxU1j+3PESQendeFXQhXEUWomWZI=; b=gYnhswA1+H38
	ugYgp+URBUCGzng6y530sWfperj8kLMDF61UGl2Y2sGpxhi7jiYxm6DXqMPuNDCM
	L32f6DphDJIga1k18wLBvpsEGO0IGzv10fv8S0HBJt7+1Zucej+qpqoUKEy8ZLff
	wOWmDAQ6diipxzXW5I32SSCNmbmBNJYcGJX0BBP8SuEIOpCyDUGmoS6sVuuJCWUW
	i1GxZ0yCehtBZALtXuvTD0GUSQM+QGHG8qq9wqA/xQ05885tImEVwUlDmTLa6nVA
	vH9VBpkm2wCdwTRVVH2yu4JqUxHk/fs5FVMLUGY8tpzGoD0pFBh9jK25YIcGgeg1
	f9bfgv4bmA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43bx1gn0e3-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 06 Dec 2024 14:30:10 -0800 (PST)
Received: from twshared3815.08.ash9.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 6 Dec 2024 22:29:58 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 496AA15B8CB85; Fri,  6 Dec 2024 14:18:27 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
        <io-uring@vger.kernel.org>
CC: <sagi@grimberg.me>, <asml.silence@gmail.com>, <anuj20.g@samsung.com>,
        <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv12 08/12] nvme: add a nvme_get_log_lsi helper
Date: Fri, 6 Dec 2024 14:17:57 -0800
Message-ID: <20241206221801.790690-9-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241206221801.790690-1-kbusch@meta.com>
References: <20241206221801.790690-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ibiVMq7d0FN61Nw_xyS-cdmnGoDbQLxd
X-Proofpoint-GUID: ibiVMq7d0FN61Nw_xyS-cdmnGoDbQLxd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241206_143011_673598_59F9882E 
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

From: Christoph Hellwig <hch@lst.de>

For log pages that need to pass in a LSI value, while at the same time
not touching all the existing nvme_get_log callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 571d4106d256d..36c44be98e38c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -150,6 +150,8 @@ static void nvme_remove_invalid_namespaces(struct nvm=
e_ctrl *ctrl,
 					   unsigned nsid);
 static void nvme_update_keep_alive(struct nvme_ctrl *ctrl,
 				   struct nvme_command *cmd);
+static int nvme_get_log_lsi(struct nvme_ctrl *ctrl, u32 nsid, u8 log_pag=
e,
+		u8 lsp, u8 csi, void *log, size_t size, u64 offset, u16 lsi);
=20
 void nvme_queue_scan(struct nvme_ctrl *ctrl)
 {
@@ -3074,8 +3076,8 @@ static int nvme_init_subsystem(struct nvme_ctrl *ct=
rl, struct nvme_id_ctrl *id)
 	return ret;
 }
=20
-int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, =
u8 csi,
-		void *log, size_t size, u64 offset)
+static int nvme_get_log_lsi(struct nvme_ctrl *ctrl, u32 nsid, u8 log_pag=
e,
+		u8 lsp, u8 csi, void *log, size_t size, u64 offset, u16 lsi)
 {
 	struct nvme_command c =3D { };
 	u32 dwlen =3D nvme_bytes_to_numd(size);
@@ -3089,10 +3091,18 @@ int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid=
, u8 log_page, u8 lsp, u8 csi,
 	c.get_log_page.lpol =3D cpu_to_le32(lower_32_bits(offset));
 	c.get_log_page.lpou =3D cpu_to_le32(upper_32_bits(offset));
 	c.get_log_page.csi =3D csi;
+	c.get_log_page.lsi =3D cpu_to_le16(lsi);
=20
 	return nvme_submit_sync_cmd(ctrl->admin_q, &c, log, size);
 }
=20
+int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, =
u8 csi,
+		void *log, size_t size, u64 offset)
+{
+	return nvme_get_log_lsi(ctrl, nsid, log_page, lsp, csi, log, size,
+			offset, 0);
+}
+
 static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,
 				struct nvme_effects_log **log)
 {
--=20
2.43.5


