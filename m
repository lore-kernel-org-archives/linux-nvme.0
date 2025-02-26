Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16072C021BC
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 18:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=biH7XCUT6E5FYLKiqpu2pEHDVd+rxQ2PZbZY6AKgZ90=; b=fLZdDJ/XVFALIYMgnAnDeRKsLZ
	9ghJdD7kzZXKao16d06xCp80DJtz2Eo0vesBNv8cLTgAwAErb/uU9Au2B4hwPkCgDBNJBAz1t+oxg
	J4YcfFBQn6MhXzlQbf2q0ZYm/82RY/zEEDfioQUk5BBZ3k7Vv37UOLPe62AlagEPcA9NMiev+p6rO
	oglKa4zxHKfHf+krnYBbcwti9RvymtJCMJGl0oN2BBtAFCBPzqqZhdFYeADgBPX3HdNkmung0LSjs
	+2O5h9uJmnDeVNMvhem3DGDQc0NitBlry/aIRLtl8gIV83qWBrHqIVgoPPTLH9zppUNrSPdbJwQ6S
	OaxWvN4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnMQD-000000050MT-2a0b;
	Wed, 26 Feb 2025 18:46:17 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnMQB-000000050Jg-1rnL
	for linux-nvme@lists.infradead.org;
	Wed, 26 Feb 2025 18:46:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0753C5C74AB;
	Wed, 26 Feb 2025 18:45:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E094C4CEEA;
	Wed, 26 Feb 2025 18:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740595574;
	bh=iDy1ce3F7we4lX8jz/NaLXQ09ocgZ3E0UyfAPaBRnbY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JuRWl+/B4WCzstTtkvZLf/I4aJgPAooSP+pIq/dult31l3mOr3LI3736wiOjChTdq
	 JUQk0dJetQe5iz+C8zio3dQ4qJrMnSxj5uhkF4W9RA9jO3jAxgOFzgMO+DXq3+Nqla
	 GoB/iQFHxdqMmw+m7bqCNMGa9b6ZrMe7BVPzkYqekE8NlPVRWEhWAYyQLfaXeVvnB4
	 afL/E2fit8ogJ2Skj0p0JnPGRy7MAW3BfN5JmCN0BKhC/29Af/A0xAxcqnNaJsqdQw
	 jz4rYFH1KuXern7S9vZxxAzgMVUuC6tETY01DTeBUtG7Og5TlstW2LFXaBsU5C5EFt
	 qR5Yn49exu86g==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 26 Feb 2025 19:45:59 +0100
Subject: [PATCH 07/11] nvmet-fc: update tgtport ref per assoc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-nvmet-fcloop-v1-7-c0bd83d43e6a@kernel.org>
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
In-Reply-To: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250226_104615_544008_0DE88B01 
X-CRM114-Status: UNSURE (   9.20  )
X-CRM114-Notice: Please train this message.
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

We need to take for each unique association a reference.
nvmet_fc_alloc_hostport for each newly created association.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 3ef4beacde3257147a59321e8f13451326302de0..b807b4c05cac7fe4764df3df76f8fa50f4bab6ba 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1157,6 +1157,7 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 		goto out_ida;
 
 	assoc->tgtport = tgtport;
+	nvmet_fc_tgtport_get(tgtport);
 	assoc->a_id = idx;
 	INIT_LIST_HEAD(&assoc->a_list);
 	kref_init(&assoc->ref);
@@ -1258,6 +1259,8 @@ nvmet_fc_delete_target_assoc(struct nvmet_fc_tgt_assoc *assoc)
 	dev_info(tgtport->dev,
 		"{%d:%d} Association deleted\n",
 		tgtport->fc_target_port.port_num, assoc->a_id);
+
+	nvmet_fc_tgtport_put(tgtport);
 }
 
 static struct nvmet_fc_tgt_assoc *

-- 
2.48.1


