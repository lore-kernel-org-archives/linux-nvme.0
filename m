Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD68C5DF67
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2026 06:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t/QJWPw35/AAixeiEIeMqbhqMVLL51SJWl0xi9TgVBg=; b=LBuf6SWu9N56v8U1liHm9l961n
	2f56GLCYB7G85Td83bi9J4a0Zpl6NWIQxfeQCFDcfSJ8Q8ZDzf3c6CI8rXESbUGpXnHCXymciGYYu
	ZjG1G1T5lfJFyCj5//xf1Qcp4vSaQa4TII1J4P3nohbP3wJv8ex11eWzquDUxI/qFXtVuTSAtVFUz
	Tx9wnDi/ug8ctowgMCLo8yC9NIGjO2qvONyKMWtltrnJ99cMm0xzGvSvgDeU6zEa3MiDLNTVaAGgz
	aYLeizHzTAVYuMCy89HZho4jWdEXRNny7kEgs1oqGifYKs+AEVl75iHhQ19mrMcVgB2tyd1fB5c3i
	acz1W7CQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwCvN-00000007NKJ-03i6;
	Tue, 18 Aug 2026 06:03:49 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwCvE-00000007NEv-3hP9
	for linux-nvme@lists.infradead.org;
	Tue, 18 Aug 2026 06:03:47 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260818060333epoutp028a8e4ede71e0621649a0114fdf0910a9~M0Q7QAW-82204522045epoutp02s
	for <linux-nvme@lists.infradead.org>; Tue, 18 Aug 2026 06:03:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260818060333epoutp028a8e4ede71e0621649a0114fdf0910a9~M0Q7QAW-82204522045epoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1787033013;
	bh=t/QJWPw35/AAixeiEIeMqbhqMVLL51SJWl0xi9TgVBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KKuI5Ufi+t8uE5lP7ksoRku3qQbsMnH1ybwkCUX3T2wT46TLB0uyzWKAcRRFG2s/X
	 3xUGUbS7Yq34KyiPAdbilqrRLYtgaEbU9f68aMXUEkgKkw0GcNAcftlAmbUurjLoD8
	 NePnAavUoNHAyGltP3hdxyF7Y/2Dq1mecTFnKUe4=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260818060333epcas5p2d05ef339aa8474c4bd21b8c65869c265~M0Q7Ab3yD1455214552epcas5p2S;
	Tue, 18 Aug 2026 06:03:33 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.91]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4hPJzS3Szfz6B9m6; Tue, 18 Aug
	2026 06:03:32 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260818060331epcas5p4bc873288ed9b92b5e2c4546e5ceaa053~M0Q5ov2lz0738707387epcas5p41;
	Tue, 18 Aug 2026 06:03:31 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260818060330epsmtip1c009161652358f26a4b0372790b0d21d~M0Q4dL0lV3115631156epsmtip1F;
	Tue, 18 Aug 2026 06:03:30 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: kbusch@kernel.org, hch@lst.de, harimishal1@gmail.com, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, gregkh@linuxfoundation.org,
	gost.dev@samsung.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH v2 1/2] nvme: set ns->head in nvme_alloc_ns_head
Date: Tue, 18 Aug 2026 11:32:52 +0530
Message-Id: <20260818060253.4104-2-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260818060253.4104-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260818060331epcas5p4bc873288ed9b92b5e2c4546e5ceaa053
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260818060331epcas5p4bc873288ed9b92b5e2c4546e5ceaa053
References: <20260818060253.4104-1-joshi.k@samsung.com>
	<CGME20260818060331epcas5p4bc873288ed9b92b5e2c4546e5ceaa053@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260817_230343_028984_0746E868 
X-CRM114-Status: GOOD (  14.23  )
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

so that it becomes possible to submit non-admin commands.
This is a prep patch with no functional changes.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1322c678f4eb..a2e0abf0ea8a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4001,10 +4001,11 @@ static void nvme_add_ns_cdev(struct nvme_ns *ns)
 	set_bit(NVME_NS_CDEV_LIVE, &ns->flags);
 }
 
-static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
+static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ns *ns,
 		struct nvme_ns_info *info)
-	__must_hold(&ctrl->subsys->lock)
+	__must_hold(&ns->ctrl->subsys->lock)
 {
+	struct nvme_ctrl *ctrl = ns->ctrl;
 	struct nvme_ns_head *head;
 	size_t size = sizeof(*head);
 	int ret = -ENOMEM;
@@ -4032,6 +4033,7 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 	ratelimit_state_init(&head->rs_nuse, 5 * HZ, 1);
 	ratelimit_set_flags(&head->rs_nuse, RATELIMIT_MSG_ON_RELEASE);
 	kref_init(&head->ref);
+	ns->head = head;
 
 	if (head->ids.csi) {
 		ret = nvme_get_effects_log(ctrl, head->ids.csi, &head->effects);
@@ -4055,6 +4057,7 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 	ida_free(&ctrl->subsys->ns_ida, head->instance);
 out_free_head:
 	kfree(head);
+	ns->head = NULL;
 out:
 	if (ret > 0)
 		ret = blk_status_to_errno(nvme_error_status(ret));
@@ -4141,7 +4144,7 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 				info->nsid);
 			goto out_unlock;
 		}
-		head = nvme_alloc_ns_head(ctrl, info);
+		head = nvme_alloc_ns_head(ns, info);
 		if (IS_ERR(head)) {
 			ret = PTR_ERR(head);
 			goto out_unlock;
-- 
2.25.1


