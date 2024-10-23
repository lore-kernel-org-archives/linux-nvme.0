Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8CBCF5395
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2024 14:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=az/JV+WAy+eDBxs3ipKPxvBpZWAr3fsOFoQYoni+ztM=; b=pxs5LVy84oQ+DKlCnAlc8cXQzj
	5ZU1zy4BOdpy/dbWXkdzsinZHGDGBisK7Y2A6hTPAr4MzwbKfgYuEwsrooGsSfeyELObYC7Q7dM++
	MmDNKmjIfhZfHelsHWs7ObRU1h4zUlkQg7l/1PZ9+4HthuRnv5wW3cUu+GvWEzg7S+/Wm0hJQb82D
	uAiZRBTyABe0hRkLPAPDOp+QZcWIQMfjbKBQy8zwGPDslPoxPhdR7pMKXfCiZxAznuODtwe2oygmq
	7gXEFL5G0a/RcnIyDraXNpibaS3yH1TXJUq+HlHQ7jjjLvu2DczFBnPAzvQ2+5j+g9tP8a2K50QNe
	kG/Xpalw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3cNU-0000000EhXb-3epl;
	Wed, 23 Oct 2024 14:30:24 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3cNR-0000000EhWH-3Cke
	for linux-nvme@lists.infradead.org;
	Wed, 23 Oct 2024 14:30:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 756465C5EE2;
	Wed, 23 Oct 2024 14:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB465C4CEC6;
	Wed, 23 Oct 2024 14:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693820;
	bh=9oHXuF+qIh9hDTSdG20YAN13vLBeCWBtn9oCkmaRlQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lp3LDBJyxKwh0YroagZ8LLjHCZrTKZGxjECg0xrHbDhV0loYw4H2f1SHpCnQNLA42
	 Vizr95Oo69xavSPHQO/mmR11751WTUJt32JAsMC3DPnEAshNku4sJ/yYKh67GJ014P
	 RpXtzcgfFV27OSYI1Vn2byyYatGrkkJd590f9iwle94HvqjvOYQn4iK3Hf05PCfHNL
	 vlSWvzrUc+NAGMkNPzjL7KgHRfQQbm66kwKe5qJfgjxe34EjlaWUcV3+q2llxhbGjM
	 Eq1yzQFNkTXv4oR+t9FZJfwoqx9g0Jas6Z1KSC8VlGxm60B1aV8+ZgbJZjj/Msrgoe
	 i+tUFa12KA+Cw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.11 04/30] nvmet-passthru: clear EUID/NGUID/UUID while using loop target
Date: Wed, 23 Oct 2024 10:29:29 -0400
Message-ID: <20241023143012.2980728-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143012.2980728-1-sashal@kernel.org>
References: <20241023143012.2980728-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.5
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_073021_918168_C783399A 
X-CRM114-Status: GOOD (  14.97  )
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

From: Nilay Shroff <nilay@linux.ibm.com>

[ Upstream commit e38dad438fc08162e20c600ae899e9e60688f72e ]

When nvme passthru is configured using loop target, the clear_ids
attribute is, by default, set to true. This attribute would ensure that
EUID/NGUID/UUID is cleared for the loop passthru target.

The newer NVMe disk supporting the NVMe spec 1.3 or higher, typically,
implements the support for "Namespace Identification Descriptor list"
command. This command when issued from host returns EUID/NGUID/UUID
assigned to the inquired namespace. Not clearing these values, while
using nvme passthru using loop target, would result in NVMe host driver
rejecting the namespace. This check was implemented in the commit
2079f41ec6ff ("nvme: check that EUI/GUID/UUID are globally unique").

The fix implemented in this commit ensure that when host issues ns-id
descriptor list command, the EUID/NGUID/UUID are cleared by passthru
target. In fact, the function nvmet_passthru_override_id_descs() which
clears those unique ids already exits, so we just need to ensure that
ns-id descriptor list command falls through the corretc code path. And
while we're at it, we also combines the three passthru admin command
cases together which shares the same code.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/passthru.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 24d0e2418d2e6..0f9b280c438d9 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -535,10 +535,6 @@ u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
 		break;
 	case nvme_admin_identify:
 		switch (req->cmd->identify.cns) {
-		case NVME_ID_CNS_CTRL:
-			req->execute = nvmet_passthru_execute_cmd;
-			req->p.use_workqueue = true;
-			return NVME_SC_SUCCESS;
 		case NVME_ID_CNS_CS_CTRL:
 			switch (req->cmd->identify.csi) {
 			case NVME_CSI_ZNS:
@@ -547,7 +543,9 @@ u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
 				return NVME_SC_SUCCESS;
 			}
 			return NVME_SC_INVALID_OPCODE | NVME_STATUS_DNR;
+		case NVME_ID_CNS_CTRL:
 		case NVME_ID_CNS_NS:
+		case NVME_ID_CNS_NS_DESC_LIST:
 			req->execute = nvmet_passthru_execute_cmd;
 			req->p.use_workqueue = true;
 			return NVME_SC_SUCCESS;
-- 
2.43.0


