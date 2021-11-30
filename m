Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD804C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Nov 2021 16:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jnG4oOYy/aHlA8N7+l3UPvW372CgOwQoydrAixZ3Gx4=; b=p0ZMP8A8nqmSvoiqSVGoCcMKZC
	ookTif4eV/B4Z1GoPuzcrXLtOsXWao6fMMqY1RzXHByOlPN+LJxXsoTGrn3LgFzvz1iUoh6rmUFsK
	iBYWyRczMe8k9zB2NOyrFNfSTpTkJv92/DVvccG83eIY7ZaCLuvuNEPpjkKQFGDa4P3k8gS73Z+H2
	h8Tc5T+LOxqDu7jvdv5D+8AZLb5rRbJeRdsjmphoZN+HYc1SSjPfc5MEX6gOwKhQf2BF7wyRflmw3
	2vTpsPgYaqvLUQoEgqiEwesQk7mrI7Ll9OSMKwRG4HCPXzNkasQeq/wj8H60HxcRoHJvjE18E6wOR
	RlEm5zbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ms5md-0067Uf-Sw; Tue, 30 Nov 2021 16:15:07 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ms5ma-0067Su-IP
 for linux-nvme@lists.infradead.org; Tue, 30 Nov 2021 16:15:06 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 9B849CE1410;
 Tue, 30 Nov 2021 16:14:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8D0C53FC7;
 Tue, 30 Nov 2021 16:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638288896;
 bh=aUaSMhdWrHqktLgQiG701ykItdolQH0Syl3mKum8Bkk=;
 h=From:To:Cc:Subject:Date:From;
 b=j4BcKVzReDTRP1kQqXpxF3W2fct0pvJUfcfiswFF72Xls2rmT9koTIr3L9a3Z5A62
 YrckvLO0dIS6TeTqlvXbDl+F6CJpM1i6eHR8y/OK8C8KZr7rMjWmoSMPSFM1jSJtk8
 qxDSPFP5oO1S9d0bEYyfl3SWwtHLMcKYzeqTlwBSQ8SSkHFkB8IQ3UjUYEHVIlP3x4
 1ssUBwfgot5t6FE5IaZwDtUWCKs63c8L6OnpzoIrSomCfEZTiosreEvRxz+VQOICp+
 +WXR+QnRYcYHS79F4B+LIW6TYozncNVu6FQtkMp5vo0A6rE6jx5RtG2qgoumc9b8h7
 xqRKLMGKjHhbg==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	hch@lst.de
Cc: Keith Busch <kbusch@kernel.org>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCHv3] nvme: disable namespace access for unsupported metadata
Date: Tue, 30 Nov 2021 08:14:54 -0800
Message-Id: <20211130161454.3835061-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211130_081504_850169_E0F4B24B 
X-CRM114-Status: GOOD (  15.47  )
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

The only fabrics target that supports metadata handling through the
separate integrity buffer is RDMA. It is currently usable only if the
size is 8B per block and formatted for protection information. If an
rdma target were to export a namespace with a different format (ex:
4k+64B), the driver will not be able to submit valid read/write commands
for that namespace.

Suppress setting the metadata feature in the namespace so that the
gendisk capacity will be set to 0. This will prevent read/write access
through the block stack, but will continue to allow ioctl passthrough
commands.

Cc: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v2->v3:

  Retain support for the EXT_LBAS features for ioctl passthrough use.
  The namespace format is usable through that interface since user space
  provides a virtually contiguous buffer with the metadata already spliced
  in.

 drivers/nvme/host/core.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f82c098b1a61..8ea3f3d3a279 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1749,9 +1749,20 @@ static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
 		 */
 		if (WARN_ON_ONCE(!(id->flbas & NVME_NS_FLBAS_META_EXT)))
 			return -EINVAL;
-		if (ctrl->max_integrity_segments)
-			ns->features |=
-				(NVME_NS_METADATA_SUPPORTED | NVME_NS_EXT_LBAS);
+
+		ns->features |= NVME_NS_EXT_LBAS;
+
+		/*
+		 * The current fabrics transport drivers support namespace
+		 * metadata formats only if nvme_ns_has_pi() returns true.
+		 * Suppress support for all other formats so the namespace will
+		 * have a 0 capacity and not be usable through the block stack.
+		 *
+		 * Note, this check will need to be modified if any drivers
+		 * gain the ability to use other metadata formats.
+		 */
+		if (ctrl->max_integrity_segments && nvme_ns_has_pi(ns))
+			ns->features |= NVME_NS_METADATA_SUPPORTED;
 	} else {
 		/*
 		 * For PCIe controllers, we can't easily remap the separate
-- 
2.25.4


