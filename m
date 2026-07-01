Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3CE4C43602
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2026 00:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jOOtecLqD0R7CdDpj0H3KdlYFaX4fxtWmcH8rs2oYIU=; b=HtXT4DBFNck2RcLghP3g1H58nr
	9bn8zEL9pUqcWFF7YbTr5iYlpO+4tgghfjL3ykO/ghz1jit/tkP0gNGzoaFOmIMD0Nac3n+iBw6zn
	SVtoyvkiRLZQl7a+Z4TN1UwrYVNCt5KJY1Zmxerl8ib23GgWC26pTKU83ntY+gYltEs0B2E5Q50kl
	H38ZSi2qap0mRLN0t91eOGRIUTZUtGXQl8NZwMOXwdW2Xrj+wrXDhMJQ5zNtIC2+JxwxJ4a2RSDFm
	C8w++kNfmz9UAzzuwFy+1+uaAMskROlM4DJTOs5ixdfIytEANespBhfQ70VgWg4uOYNquR0mmujUv
	WwXhTZlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wf5Yk-00000003JEt-05y2;
	Thu, 02 Jul 2026 00:45:42 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wf5Yg-00000003JDu-1G42
	for linux-nvme@lists.infradead.org;
	Thu, 02 Jul 2026 00:45:40 +0000
X-UUID: 556a72ec75af11f1aa26b74ffac11d73-20260702
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:c3190929-0e4a-4483-8297-93c88a011dd2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:9ab831db4cf89a682a1860e92e92404e,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|865|898,TC:nil,Content:0|15|50
	,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 556a72ec75af11f1aa26b74ffac11d73-20260702
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 345100844; Thu, 02 Jul 2026 08:45:33 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, hare@suse.de, linux-kernel@vger.kernel.org, liuxixin@kylinos.cn
Subject: [PATCH v1 1/1] nvme-auth: use crypto_memneq for DH-HMAC-CHAP response comparison
Date: Wed, 1 Jul 2026 14:30:00 +0800
Message-ID: <0001.nvme-auth-memneq.1781751816.git.liuxixin@kylinos.cn>
In-Reply-To: <cover.nvme-auth-memneq.1781751816.git.liuxixin@kylinos.cn>
References: <cover.nvme-auth-memneq.1781751816.git.liuxixin@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: patches/scripts/send-local.py
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260701_174538_638572_30643061 
X-CRM114-Status: GOOD (  11.07  )
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

DH-HMAC-CHAP authentication compares HMAC response digests with memcmp().
Standard memcmp() may stop at the first differing byte, which can leak
timing information to a remote attacker and allow incremental recovery
of the expected digest.

Use crypto_memneq() for constant-time comparison on both the host path
that validates the controller Success1 response and the target path that
validates the host Reply digest.  Other memcmp() uses in the NVMe auth
code (e.g. fixed string prefix checks) are not security-sensitive and
are left unchanged.

Signed-off-by: Xixin Liu <liuxixin@kylinos.cn>
---
 drivers/nvme/host/auth.c                 | 3 ++-
 drivers/nvme/target/fabrics-cmd-auth.c   | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 111111111111..222222222222 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -8,6 +8,7 @@
 #include <linux/prandom.h>
 #include <linux/unaligned.h>
 #include <crypto/dh.h>
+#include <crypto/utils.h>
 #include "nvme.h"
 #include "fabrics.h"
 #include <linux/nvme-auth.h>
@@ -361,7 +362,7 @@ static int nvme_auth_process_dhchap_success1(struct nvme_ctrl *ctrl,
 		return 0;
 
 	/* Validate controller response */
-	if (memcmp(chap->response, data->rval, data->hl)) {
+	if (crypto_memneq(chap->response, data->rval, data->hl)) {
 		dev_dbg(ctrl->device, "%s: qid %d ctrl response %*ph\n",
 			__func__, chap->qid, (int)chap->hash_len, data->rval);
 		dev_dbg(ctrl->device, "%s: qid %d host response %*ph\n",
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 333333333333..444444444444 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -8,6 +8,7 @@
 #include <linux/random.h>
 #include <linux/nvme-auth.h>
 #include <crypto/kpp.h>
+#include <crypto/utils.h>
 #include "nvmet.h"
 
 static void nvmet_auth_expired_work(struct work_struct *work)
@@ -177,7 +178,7 @@ static u16 nvmet_auth_reply(struct nvmet_req *req,
 		return NVME_AUTH_DHCHAP_FAILURE_FAILED;
 	}
 
-	if (memcmp(data->rval, response, data->hl)) {
+	if (crypto_memneq(data->rval, response, data->hl)) {
 		pr_info("ctrl %d qid %d host response mismatch\n",
 			ctrl->cntlid, req->sq->qid);
 		pr_debug("ctrl %d qid %d rval %*ph\n",
-- 
2.43.0


