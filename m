Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8CE6C00140
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Aug 2022 18:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HUTpav1HH48yXGM6QnN8K6Evfdqblp2xX/wB6uqW568=; b=rEzFhYhsiFWjoj3vV0MX30sbHZ
	galfeEbFmyrcwE8cgKaZ8HGlvVC7D+9nMBjJ5nzp8zowidiVsgBQFkCAaWYjGlvsTKM2VxGzkO8FB
	tGIBGobta/UfvXYJhW+YpqlkSJGuG3JYsQsjKUCYQzqt4vGWarZq+uGWJcXcVVsOO3jkCr7ARyYYb
	5VyWsyX5movrr0beixdYRpSfBxXyfoDcf9Jq/gUinjbjrUBlt54v2Oxp5WFJyYVOqAdNFUkDmMwh4
	eHk5dZt6tom0EAkjwKabrNeEw6VnZcFdStOwd0+afxhNWHo5Ro0GPPKrawetNKB1xQ6iTWKQgSUXI
	0zjvdcmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMZIQ-00C2Zx-VC; Fri, 12 Aug 2022 18:22:10 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMZIO-00C2Xu-EI
	for linux-nvme@lists.infradead.org; Fri, 12 Aug 2022 18:22:10 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27CF7VN2023170
	for <linux-nvme@lists.infradead.org>; Fri, 12 Aug 2022 11:22:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=HUTpav1HH48yXGM6QnN8K6Evfdqblp2xX/wB6uqW568=;
 b=ntGgaHsdAQZkiaaX02j/unbKL3wwMcUXwgqQOYA3ajGYh01OL4DJaGMLARaNnBKo0qyF
 SVIrauBQJBNiDlBoNhZ95xq61YR7qcPz+06PHgbgYPaJBckYWortgviQ6lNjsXSBkmJk
 w5o1g8iX+JCda02waOEpZ/KvKLh6na5z+t8= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hw9qfp052-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 12 Aug 2022 11:22:02 -0700
Received: from twshared14818.18.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 12 Aug 2022 11:21:59 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 626E17494167; Fri, 12 Aug 2022 11:21:48 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jonathan Derrick
	<Jonathan.Derrick@solidigm.com>
Subject: [PATCH] nvme: don't flush scan work with non-idle request
Date: Fri, 12 Aug 2022 11:21:47 -0700
Message-ID: <20220812182147.1564958-1-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: LKb7dsVhuyoQf27HU_nSJl9i_lpH58Hw
X-Proofpoint-ORIG-GUID: LKb7dsVhuyoQf27HU_nSJl9i_lpH58Hw
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_10,2022-08-11_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220812_112208_643857_23167CF3 
X-CRM114-Status: GOOD (  20.19  )
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

From: Keith Busch <kbusch@kernel.org>

If a reset occurs after the scan work attempts to issue a command, the
reset may quisce the admin queue, which blocks the scan work's command
from dispatching. The scan work will not be able to complete while the
queue is quiesced.

Meanwhile, the reset work will cancel all outstanding admin tags and
wait until all requests have transitioned to idle, which includes the
passthrough request. But the passthrough request won't be set to idle
until after the scan_work flushes, so we're deadlocked.

Fix this by moving the flush_work after the request has been freed.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D216354
Reported-by: Jonathan Derrick <Jonathan.Derrick@solidigm.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c  |  5 ++---
 drivers/nvme/host/ioctl.c | 12 ++++++++++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index af367b22871b..1143f625e195 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1121,12 +1121,11 @@ static void nvme_passthru_end(struct nvme_ctrl *ctr=
l, u32 effects,
 		nvme_remove_invalid_namespaces(ctrl, NVME_NSID_ALL);
 		mutex_unlock(&ctrl->scan_lock);
 	}
+
 	if (effects & NVME_CMD_EFFECTS_CCC)
 		nvme_init_ctrl_finish(ctrl);
-	if (effects & (NVME_CMD_EFFECTS_NIC | NVME_CMD_EFFECTS_NCC)) {
+	if (effects & (NVME_CMD_EFFECTS_NIC | NVME_CMD_EFFECTS_NCC))
 		nvme_queue_scan(ctrl);
-		flush_work(&ctrl->scan_work);
-	}
=20
 	switch (cmd->common.opcode) {
 	case nvme_admin_set_features:
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 27614bee7380..97febd5f41a3 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -136,9 +136,11 @@ static int nvme_submit_user_cmd(struct request_queue *=
q,
 		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
 		u32 meta_seed, u64 *result, unsigned timeout, bool vec)
 {
+	struct nvme_ctrl *ctrl;
 	struct request *req;
 	void *meta =3D NULL;
 	struct bio *bio;
+	u32 effects;
 	int ret;
=20
 	req =3D nvme_alloc_user_request(q, cmd, ubuffer, bufflen, meta_buffer,
@@ -147,6 +149,8 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 		return PTR_ERR(req);
=20
 	bio =3D req->bio;
+	ctrl =3D nvme_req(req)->ctrl;
+	effects =3D nvme_command_effects(ctrl, q->queuedata, cmd->common.opcode);
=20
 	ret =3D nvme_execute_passthru_rq(req);
=20
@@ -158,6 +162,14 @@ static int nvme_submit_user_cmd(struct request_queue *=
q,
 	if (bio)
 		blk_rq_unmap_user(bio);
 	blk_mq_free_request(req);
+
+	/*
+	 * Ensure the namespace inventory is up-to-date before returning if
+	 * this command can change it.
+	 */
+	if (ret >=3D 0 && effects & (NVME_CMD_EFFECTS_NIC | NVME_CMD_EFFECTS_NCC))
+		flush_work(&ctrl->scan_work);
+
 	return ret;
 }
=20
--=20
2.30.2


