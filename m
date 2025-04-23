Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F56C369D1
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Apr 2025 13:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9nC50pNuNTggIdpwXQMCwB+7h8gIG2eHeTp3Is9xv9E=; b=tqRG28Yi2koO5f5v4PIDubWSIK
	p1YmJOhVrADpEvSBIoKFEkRKFpOS/B01dXRfJCby4IqnNQnheFuaoZELxWgvfkpLEuOK5XFQVgXwG
	gC126+N5nYibsno46KebnMY37TcMrlWmSS0BJ0UZ5+1XBdsW11Q5mTDFOwP7sjQP5TQi/NXttXkwp
	6mRnkkvoXvGsKrj4BRXJgPBNSdz17Ecy1tuYP7TCmLu4GSzlRHQ28WN2NNZAriju8Mc2J5/t6iL9a
	4AlD8Fxvh8aP2AWUNogwFEeHaKA/U4e32fntwsYSBJ0L1p/pDX7rOfg1kBaTcmuafsXRKiTKK8azp
	xvLnhvMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7aXX-0000000Ai2L-2lsx;
	Wed, 23 Apr 2025 13:53:27 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7a3c-0000000Aaqa-377v
	for linux-nvme@lists.infradead.org;
	Wed, 23 Apr 2025 13:22:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id C8861A4CF25;
	Wed, 23 Apr 2025 13:17:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C349C4CEE2;
	Wed, 23 Apr 2025 13:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745414551;
	bh=/cLfvZPaGaKqTv5rGWJ2lfAMdaEHdJl7YqBZZkkNksw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TLImKzZ/tQWXbn4ODEiwVugd6vBNT48iqotSK9rMkKp8Debxfj5BAEh5JBOCl4PP3
	 JRqRyITxPTX4JUmrEqhZUZ61fl0wrDdLGvEifWBUCzZZFiWb0aVrNNYKq5wjr6yImo
	 UjZyn9xXa/m8FhGH87jXr3Pu8ZQ9Hzrr5DR8Zo9WmHivVkuOITZ5Z63aSGW4fu87kT
	 3xKwkpuZAsn8OGsn3DJbZrGseIHXH0dZAUH4IitrxODWQb5mkqZq9UJRT4k3nufm0C
	 kCT8EgypF24kVtPnYLLEMaAByPw4/fnXdKTF+9vf0XqKQDT8ExixZJe5k1IeCxBprt
	 jzy79wc0wEyyQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 23 Apr 2025 15:21:57 +0200
Subject: [PATCH v5 14/14] nvme-fc: do not reference lsrsp after failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-nvmet-fcloop-v5-14-3d7f968728a5@kernel.org>
References: <20250423-nvmet-fcloop-v5-0-3d7f968728a5@kernel.org>
In-Reply-To: <20250423-nvmet-fcloop-v5-0-3d7f968728a5@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_062232_850347_FE7187A9 
X-CRM114-Status: GOOD (  12.78  )
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
index 2257c3c96dd2da11097d2d0d4a5bb8ece1bebc6a..fdafa3e9e66fa9b8954209efa14d3b207cb8653c 100644
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
2.49.0


