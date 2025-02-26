Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C6FC021B8
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 18:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3+rsq3ngWpbLQRdj2wfJFpMBZqcklBb39iIz+S/dGv0=; b=Ar82PZbc1/9UmR5UBCbLE8hkt6
	C+KcbrE8u4y1oCg4jopayGN8UwBBAXGeyYJEHHMw/q9gsCbzufBkwEs+O4C2M7wagsbzmjdDSRnsv
	6lJr+/IxdRdK0F/vHCqEyeyRRac+FIcdUMLrvvTKiwXYmHpmX/hhiwpN1zTQD/9J3519BmqhagH+l
	7eHKLuCgjOH2do2yc+BDC7AO3hIFVmeXsFUWhjJ5tpundZKtK8YayryWln34GJWIw8hNQHgKGJ1YM
	DqmTnH5gKhY88o5XYErtbr0RaPNH24F0Ag1oH+ZjFnaiceOR5+/AvZ1kWcNVDeu0BS2OOljCot5xg
	+2ndcBJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnMRz-000000051bL-0egF;
	Wed, 26 Feb 2025 18:48:07 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnMQI-000000050Su-3hZ5
	for linux-nvme@lists.infradead.org;
	Wed, 26 Feb 2025 18:46:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 690735C74B1;
	Wed, 26 Feb 2025 18:45:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C11ECC4CEE8;
	Wed, 26 Feb 2025 18:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740595582;
	bh=rKfUqV+Xi/1+X0Vimi9wbQfzTnlJ+u0a0ho6TF13EkE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dIpJWPYN6CHZZptVdcsD2pZ41EWeSTLFgSyV5iXq5a+ohjP0UR2Rk1VT2JHkX5cvp
	 WvZ2fqvEYZwauwSHi1reMtRwCfTJhVHHeaaESf0y2yn3q8NKibHNshJ1oh9/e/oNYR
	 j+Gq1dpNmoNSQtNieLWOermSpCbqc5F0Qi4udAlkkzEIOSNenPI3SvamNTxJPbRXAY
	 y2AGj/TK0VVtWW5laMlp5k21b6HeBBFEhktE/cUKN7womc5TqlpxbvTg4tiaX6jecM
	 noH5rWDtKvmGq7ZKVo8yjAFQTpZ/13doaNSYTDbYHLbn0ocOmuMybsp64TxvTIk9Mp
	 kohx1p/H6I5rw==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 26 Feb 2025 19:46:02 +0100
Subject: [PATCH 10/11] nvmet-fc: inline nvmet_fc_delete_assoc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-nvmet-fcloop-v1-10-c0bd83d43e6a@kernel.org>
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
In-Reply-To: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250226_104622_995639_6C0CC540 
X-CRM114-Status: GOOD (  10.28  )
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

There is only one user for this helper function, just inline it.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fc.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index a5f7cb18ac9f49e41626e1c9a031c3cc830af9ba..fcf191aa1c6bf73e7fb84213bbb7eb76a486734f 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1077,13 +1077,6 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 	return newhost;
 }
 
-static void
-nvmet_fc_delete_assoc(struct nvmet_fc_tgt_assoc *assoc)
-{
-	nvmet_fc_delete_target_assoc(assoc);
-	nvmet_fc_tgt_a_put(assoc);
-}
-
 static void
 nvmet_fc_delete_assoc_work(struct work_struct *work)
 {
@@ -1091,7 +1084,8 @@ nvmet_fc_delete_assoc_work(struct work_struct *work)
 		container_of(work, struct nvmet_fc_tgt_assoc, del_work);
 	struct nvmet_fc_tgtport *tgtport = assoc->tgtport;
 
-	nvmet_fc_delete_assoc(assoc);
+	nvmet_fc_delete_target_assoc(assoc);
+	nvmet_fc_tgt_a_put(assoc);
 	nvmet_fc_tgtport_put(tgtport);
 }
 

-- 
2.48.1


