Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB43E77173
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Dec 2024 22:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=885q4w1E275nZID7YwFrzIPpvQxYrUJuHVeBYMPoQ1s=; b=Sln/xRXMNupCwNQIdQYjD42Hc8
	JO6xe8YHn/VvPcJjzE7n0W7t4j+7oyt6va1xtxKejQV5cYrfvflfNtiomLnwR+E1iyG1WH4ktgDqd
	ooILrYFGNsSrfU3XYGNTcRwUZFvmalotF5eMj4UuX0nypbf/KfFvUHJHUGzurU9zqg3fgS2FvvuQO
	RihfC7iWV8BLryYzEIJf/xv04mAkuFgB+J0uy2/JvKCv+HR6hck2piI62PhLl43HFoSqZcxvDAxa7
	HiibwO9sKQavGXw9IZekxI1h3Mspn6iBbQA/zFPgDNi3BaJw648RjVatnUlNcZ+oV3vQwj1QXVIm2
	qPS14ICQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJgw9-00000002w5h-2gFP;
	Fri, 06 Dec 2024 22:36:37 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJgw7-00000002w51-0zwN
	for linux-nvme@lists.infradead.org;
	Fri, 06 Dec 2024 22:36:36 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6MaRT2002274
	for <linux-nvme@lists.infradead.org>; Fri, 6 Dec 2024 14:36:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=885q4w1E275nZID7YwFrzIPpvQxYrUJuHVeBYMPoQ1s=; b=SEW/b3uoyR/S
	5uRPc7klboFCNYbnRyDEMBquoHx86w2IdhP8H7B5PI+LcwNX5xm0CbQi0bXDBLfO
	xPjBRhcnhig8EktkfuWyhHCXADM3Em261jktOhOt0kaQY9cO17FJRwj8KLBfaoSg
	nkzLPNgpySFVi66VWzfSXUqx+mlVePnZRVO2XFG3G97BFnXIzZhSPThqFv+YKoXV
	2YY+600epmpXF3TtXjnlXjyfzlYsOoUo4u4uw+oDN7AGDcfkPjK7KBIQRooOs20M
	PZcPVlt86O5NmZLYU+jvlycqOzEAaIQw/ZHGPYr7FYE+bZucu9bNMI1I+pQm8CRA
	/lAxPVGg8A==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43c8kv8nyk-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 06 Dec 2024 14:36:33 -0800 (PST)
Received: from twshared7122.08.ash9.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 6 Dec 2024 22:35:50 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 5591415B8CB87; Fri,  6 Dec 2024 14:18:27 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
        <io-uring@vger.kernel.org>
CC: <sagi@grimberg.me>, <asml.silence@gmail.com>, <anuj20.g@samsung.com>,
        <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv12 09/12] nvme: pass a void pointer to nvme_get/set_features for the result
Date: Fri, 6 Dec 2024 14:17:58 -0800
Message-ID: <20241206221801.790690-10-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241206221801.790690-1-kbusch@meta.com>
References: <20241206221801.790690-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: inMMDFFY8gSuU4HyIsgY9kDlCbnpoBuI
X-Proofpoint-ORIG-GUID: inMMDFFY8gSuU4HyIsgY9kDlCbnpoBuI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241206_143635_416889_3D0C3729 
X-CRM114-Status: GOOD (  10.95  )
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

That allows passing in structures instead of the u32 result, and thus
reduce the amount of bit shifting and masking required to parse the
result.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 4 ++--
 drivers/nvme/host/nvme.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 36c44be98e38c..c2a3585a3fa59 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1678,7 +1678,7 @@ static int nvme_features(struct nvme_ctrl *dev, u8 =
op, unsigned int fid,
=20
 int nvme_set_features(struct nvme_ctrl *dev, unsigned int fid,
 		      unsigned int dword11, void *buffer, size_t buflen,
-		      u32 *result)
+		      void *result)
 {
 	return nvme_features(dev, nvme_admin_set_features, fid, dword11, buffer=
,
 			     buflen, result);
@@ -1687,7 +1687,7 @@ EXPORT_SYMBOL_GPL(nvme_set_features);
=20
 int nvme_get_features(struct nvme_ctrl *dev, unsigned int fid,
 		      unsigned int dword11, void *buffer, size_t buflen,
-		      u32 *result)
+		      void *result)
 {
 	return nvme_features(dev, nvme_admin_get_features, fid, dword11, buffer=
,
 			     buflen, result);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 611b02c8a8b37..c1995d89ffdb8 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -890,10 +890,10 @@ int __nvme_submit_sync_cmd(struct request_queue *q,=
 struct nvme_command *cmd,
 		int qid, nvme_submit_flags_t flags);
 int nvme_set_features(struct nvme_ctrl *dev, unsigned int fid,
 		      unsigned int dword11, void *buffer, size_t buflen,
-		      u32 *result);
+		      void *result);
 int nvme_get_features(struct nvme_ctrl *dev, unsigned int fid,
 		      unsigned int dword11, void *buffer, size_t buflen,
-		      u32 *result);
+		      void *result);
 int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count);
 void nvme_stop_keep_alive(struct nvme_ctrl *ctrl);
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
--=20
2.43.5


