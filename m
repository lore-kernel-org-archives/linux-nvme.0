Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA63EC28B28
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Mar 2025 10:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k7YylIFTiJdvWUOdjxLJrbOEOWc1ZokwU+ylT2xouHQ=; b=LcG3wX76iEE5T+cjHs5sHpXVqY
	NHfy5/0B5zD6fVk6tFw6r3TzCmDSF5gf+biIQG8yzjMvNuxzqlMVXsMyJSM4MbAHKMJ7BHniTvl0u
	7alAtvCMWBxH/2GPoMwqdxTADA3BoPBl5Ws6BmDKukHgtT5w4BCEL5ZGGC8PR19jIuh8jykqN4zj7
	7/I0/eDenzgAZasUBk8YiC+105RylH7iBfeI80MCi4efjlaPrGydYkZYPfHzLbQ/MIQNpGDD1MPS2
	c7A5jGftEy+aaV1Gwho+AmQdPr2PvY9qaUm2Xizjhm/Eqx+nPw3kZVaj7v/wORFtaozcq4NcMe4SI
	McNdMtLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuUND-00000005YJJ-3ntA;
	Tue, 18 Mar 2025 10:40:39 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuUN9-00000005YCi-43Q7
	for linux-nvme@lists.infradead.org;
	Tue, 18 Mar 2025 10:40:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id AD097A48F38;
	Tue, 18 Mar 2025 10:35:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E68C4CEF3;
	Tue, 18 Mar 2025 10:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294435;
	bh=/92ooGbeabbacagz1kQIT/ubrVZ4C6yUg1CR20B0YxQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SL/03HPGNwlREGydN6Z0gKEfEMj5caRwP1rBEclgoam34Ou/2MN+ovavtWppGa4oL
	 NGuHQ7etSy8n/WCOBXceAezPSFtBzQTwhGBahEqXxCByiI/u28YRPnHmPu8BUX6Rrj
	 I9mXlBqa6tOkD59bQVibquaAlNuCBEMPugXKY6fzMjeWi6tYDxq2ruaTQ5tn4GEvxV
	 vz20RX/z9D6PgGwbOyNhYm/+DcBWosMf/jQvmUNbJVmsYNnhPGIUyVBnnWDUPNVON4
	 VMg8y/gNxSzITAQsj6m2cy0bpwEcvX5Tizm9RxRqTo2rmAnC27FlpLRyp2YL2GAHvX
	 NZPVAA8BdKYVw==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 18 Mar 2025 11:40:07 +0100
Subject: [PATCH v3 13/18] nvmet-fc: update tgtport ref per assoc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-nvmet-fcloop-v3-13-05fec0fc02f6@kernel.org>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
In-Reply-To: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_034036_086969_79CB263F 
X-CRM114-Status: UNSURE (   9.25  )
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

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 20ea3acd7a5ff6f7c27b55b8c00f22b2a0768b7b..8b14947906948c8b4914932837b4ec90921b419d 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1139,6 +1139,7 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 		goto out_ida;
 
 	assoc->tgtport = tgtport;
+	nvmet_fc_tgtport_get(tgtport);
 	assoc->a_id = idx;
 	INIT_LIST_HEAD(&assoc->a_list);
 	kref_init(&assoc->ref);
@@ -1238,6 +1239,8 @@ nvmet_fc_delete_target_assoc(struct nvmet_fc_tgt_assoc *assoc)
 
 	pr_info("{%d:%d}: Association deleted\n",
 		tgtport->fc_target_port.port_num, assoc->a_id);
+
+	nvmet_fc_tgtport_put(tgtport);
 }
 
 static struct nvmet_fc_tgt_assoc *

-- 
2.48.1


