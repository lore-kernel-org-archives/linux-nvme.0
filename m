Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6273C28B28
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Mar 2025 10:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dFHc5ZE0KgPdfTFM+ZLG4EdfV/xt71kGXqdRN2aftwk=; b=kF+fkP4pR0hi6ELsuJPxr79Hhh
	HNWjrI2OVG4O3RJZieMDHy842byiNRtQL2wtfDMf70Ee1S6rUT4sbmlNoeOs8C5itlR4h/ABSDM7o
	LiR17QyFVzPdWROs7w/wKMU5cLnWuUEkkvJ4JQhoo92eKQGxxbIH6IYq3i4ZOWIBz5PN9hz3cTvJu
	eLCR8q3Y4ZfEjr95eD8ZGra9DUngMVK9elKfFv5l0X6XfAtTQkoMStAnVBSL3QzIzJYQJ66NRuTsJ
	N2aO43URYXiXc23BxS2UzV34siFJuH/vSG/pQPmQ/REbCxGgIlSFolUkQzVzt+WzJXv/4ldegiVKi
	Ye7spqlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuUNU-00000005Ygm-0Cy4;
	Tue, 18 Mar 2025 10:40:56 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuUNM-00000005YVO-2b3F
	for linux-nvme@lists.infradead.org;
	Tue, 18 Mar 2025 10:40:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 4A2D5A48F44;
	Tue, 18 Mar 2025 10:35:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B7FC4AF09;
	Tue, 18 Mar 2025 10:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294447;
	bh=qZceJnRtvOAv9rMro0CCwHgopDRbxFnO5xByz8l5QYM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oDAXeKKyx/GcWKE1PYi2a00cQWzBDgZAaLfOy93Pa69FN1H54ugiwAl5+Ja52XHn2
	 k54kM1r/OD7hediKoPE+s1tQKg8xItGlSbLEDrsTqo01eXsJ2Sq+QrGXa24qesl0mF
	 DV6cY2Zyo9Yu2XkQhrfLq39tvHbsgKhPpmPKKE7OKBgKLTzButZ+UJ1IFm3pkJgJ98
	 fXJRwni8G42CHvKUjd6Bcu1aWqvGlgz+FExYZf/zMk+4+4jR0K2vIDYYbf5SlTptVm
	 KBRC9xJE+qSNJbWI2g7Ak0aU4zR1dfosXVq0FOlK2lQ6zMgBNsrFHMpcnKigRUl8RN
	 emCIe2STozCsg==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 18 Mar 2025 11:40:12 +0100
Subject: [PATCH v3 18/18] nvme-fc: do not reference lsrsp after failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-nvmet-fcloop-v3-18-05fec0fc02f6@kernel.org>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
In-Reply-To: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_034048_776432_E3D9772E 
X-CRM114-Status: GOOD (  13.14  )
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

The lsrsp object is maintained by the LLDD. The lifetime of the lsrsp
object is implicit. Because there is no explicit cleanup/free call into
the LLDD, it is not safe to assume after xml_rsp_fails, that the lsrsp
is still valid. The LLDD could have freed the object already.

With the recent changes how fcloop tracks the resources, this is the
case. Thus don't access lsrsp after xml_rsp_fails.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/fc.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index b9929a5a7f4e3f3a03953379aceb90f0c1a0b561..2c32ba9ee688d7a683bbbf8fc57a5f9b32b2ab8d 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1410,9 +1410,8 @@ nvme_fc_xmt_disconnect_assoc(struct nvme_fc_ctrl *ctrl)
 }
 
 static void
-nvme_fc_xmt_ls_rsp_done(struct nvmefc_ls_rsp *lsrsp)
+nvme_fc_xmt_ls_rsp_free(struct nvmefc_ls_rcv_op *lsop)
 {
-	struct nvmefc_ls_rcv_op *lsop = lsrsp->nvme_fc_private;
 	struct nvme_fc_rport *rport = lsop->rport;
 	struct nvme_fc_lport *lport = rport->lport;
 	unsigned long flags;
@@ -1433,6 +1432,14 @@ nvme_fc_xmt_ls_rsp_done(struct nvmefc_ls_rsp *lsrsp)
 	nvme_fc_rport_put(rport);
 }
 
+static void
+nvme_fc_xmt_ls_rsp_done(struct nvmefc_ls_rsp *lsrsp)
+{
+	struct nvmefc_ls_rcv_op *lsop = lsrsp->nvme_fc_private;
+
+	nvme_fc_xmt_ls_rsp_free(lsop);
+}
+
 static void
 nvme_fc_xmt_ls_rsp(struct nvmefc_ls_rcv_op *lsop)
 {
@@ -1450,7 +1457,7 @@ nvme_fc_xmt_ls_rsp(struct nvmefc_ls_rcv_op *lsop)
 		dev_warn(lport->dev,
 			"LLDD rejected LS RSP xmt: LS %d status %d\n",
 			w0->ls_cmd, ret);
-		nvme_fc_xmt_ls_rsp_done(lsop->lsrsp);
+		nvme_fc_xmt_ls_rsp_free(lsop);
 		return;
 	}
 }

-- 
2.48.1


