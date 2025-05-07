Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E27AC3ABC0
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 12:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9nC50pNuNTggIdpwXQMCwB+7h8gIG2eHeTp3Is9xv9E=; b=At17g3PbnN2nhSCp0il+r/UlA7
	nuALp+K+5HERTtpTkUV0jAmCPTV8iA9GnEqVtep5zsoSHo5zDAtG0jPUt/3zLnlAkTVbjP2weW6U2
	abxvDPz85zc4xjkA8+6N0HukuFBQnAra5keuO5LYQXkHqYPen0TxgNMAK4tZpTHPDcLKdS7pXUyIn
	sTuhNGMkGLHeuBtO+VDGj9mtLCJh2u5iJSOYXQDvm+Dz0GXzBkKQoVrsO02N63dgP82kS4FxMmSwW
	+1yb0BveTUivYz5U8yqLnrkVuEKpu8MrjY69Z5qbx+PTLaixGc9skiIiB93MQcpeJb0pWOzrBrWu1
	iUq0EExA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdoW-0000000FNTn-363n;
	Wed, 07 May 2025 12:23:52 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdoV-0000000FNRw-1IGF
	for linux-nvme@bombadil.infradead.org;
	Wed, 07 May 2025 12:23:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description;
	bh=9nC50pNuNTggIdpwXQMCwB+7h8gIG2eHeTp3Is9xv9E=; b=aIQhOi2ZE3jPK2SfRzahVdK4qw
	A8DfCbZn3A3okK0JAMH7xJGPRucw6/kZIc9Q0CKoExf9WRzh3Ka9nJEAYkB4f60Pe57TO/eYZJz1G
	vBHDHRfeIxXp36gMSFWwu+A+X7byHiv2ddg17M9g5EV3flI+rV5+A+X6uaTa0a2uy8W2em/l/QQwQ
	xsWinPjYj4LIhYkTzMuvw2ZdV1Y+aVmd+mQLa3xYQnEBGqv/9lmYtrOXmvAwAjH76/emGvPww32tm
	3Af0TQ4WJNes+8U4iLd5ZXHv5CACNoZla4KbnRHGRlkpxMkKykKYqzY6qh3YwGt+KejRl9T9QhLKt
	DWOzVYFw==;
Received: from nyc.source.kernel.org ([147.75.193.91])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uCdoS-0000000Fq9p-0q63
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 12:23:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 088DEA4D78B;
	Wed,  7 May 2025 12:23:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43838C4CEEB;
	Wed,  7 May 2025 12:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746620622;
	bh=/cLfvZPaGaKqTv5rGWJ2lfAMdaEHdJl7YqBZZkkNksw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WGa0vt5OBWRnroe+ljbi0hm8kLENjCa2GQPPN7XKp6V0BBiTF19H8tqSTfh7CRZWx
	 WYwWCcxEoZFuKpoSoHFB3DiCJv5RpwKtdJhYkcI+6Qegd1ByKOw+obuvZudtLGOAgI
	 X53WtNr2YSdLCJOJEqZzwnphYNQKQOOlPJvhBjcc8eai8x2bZAraNjQg69wMo3QNuT
	 Dk5HDEdUHsH1C9pxYmD8WectqcO5UycNxlEFm+mbo9tEkV7Fz2qt0azC8FwABN3vYb
	 g3ORnXhOrzHXDdZ9TdsndFHh5Ab0vT0DRhb5UdOEkrOc93TlniHwGAsX0jTn0HTMqs
	 d7nNqEdUw4MAA==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 07 May 2025 14:23:10 +0200
Subject: [PATCH v6 14/14] nvme-fc: do not reference lsrsp after failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-nvmet-fcloop-v6-14-ca02e16fb018@kernel.org>
References: <20250507-nvmet-fcloop-v6-0-ca02e16fb018@kernel.org>
In-Reply-To: <20250507-nvmet-fcloop-v6-0-ca02e16fb018@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_132348_416644_446F4208 
X-CRM114-Status: GOOD (  13.16  )
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


