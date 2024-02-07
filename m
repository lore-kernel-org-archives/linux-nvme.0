Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFBEDC4828D
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 21:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8Tnh4Is48iwE9PmrNTFQ6knjrNqoCkeTA5Gd+sna1P8=; b=IwN4QWEtqUX5d2E3sTzxtOn3as
	9YC3lXy9nl8w5pMCHmOBTv/kbo84KYPyz8+XLR5+W37R4VbMq33VmfmDeQ0UQG64SQdLWekN3blX+
	8Nk7rLgfGxMlDGKIVpLvY6ii3VRKAxd+OqXgUQvAMY/JUKm3vODwGZzhh73IPPPRt7zis2KzwPsuI
	xFjGSIx9N/Qqtwi8TS3RD4A/JsiEI0U9kND78GH2M0ibBiBBe5u2oeO+pYvIMAS5++lWQ8KpYhMuw
	WUZHp78INm/Kb9n3RkdTXuF0zZgkGHkYqdS+f/46y6hYWuJNGejCxvjQ855MRbRXmZjyO3iEE4OvW
	BydQhmYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpPe-0000000Brql-0KgI;
	Wed, 07 Feb 2024 21:24:58 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpPZ-0000000Brnf-3bwY
	for linux-nvme@bombadil.infradead.org;
	Wed, 07 Feb 2024 21:24:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=8Tnh4Is48iwE9PmrNTFQ6knjrNqoCkeTA5Gd+sna1P8=; b=Nj+ooCf+OL8J+2BLKZ9U6+sgwf
	pz7OBmOBzPSa0Puahs0tScPyF84U7iT4uu6efXZv/ALR5AcqgmmHW7q5kWCbnmJTjL++fDcn2fQNR
	SttskCkL6MMq04G6wWzYA0dHz4NUuqs2H++U5z/2JsqmZZTU4HZwkpGymouSLJVMZXCvB59jGf76D
	4pCep9Lw2lvxOLX4CNd2kFRLoA6JEcBqsRGpWY9sBTQYURtGSYOm/sCiagSjcGmICPHEHex2hZsRx
	M8Fj1YC1J7YRTPTz7eqL4XaCYbhMWEKmD0qfuVQno0/mCCIywajVu3n6sW+oAWq08Rkvd1CZWpvx6
	w4JaN0+A==;
Received: from sin.source.kernel.org ([145.40.73.55])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpPV-0000000D7vd-3e5l
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 21:24:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 88A80CE1B21;
	Wed,  7 Feb 2024 21:24:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818F2C43390;
	Wed,  7 Feb 2024 21:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341084;
	bh=EVJw3/SXfuBf5v9qJgE4yM7WLbNBIMe7pkiV9lhnVaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n4IzZHGNDkeuOQgwV4QTX7FA0tFvpaokB2r7ujRb1IJ+euPMmq5iaPZ11rmTRflBH
	 WBhITDKT/UVSnpnmU0QC604YjbKCYyFjJcRyKUXk04NM8IGtPaKQAqFXAqRPaFCtvG
	 OFgPvbjU7APZ/F9yTZU4kVWfCl+Neq1k30e95HzusXR1yTjsCf/Smx+VC7mtVcOchq
	 rrtbzcSFQ6BfrT9jnn925MZGj0AiUavE3AQaSz5vqDm1KcjQ6jdqI/M2e2aBxz6m43
	 CJK2wH2gLbFt9i+JxGN+4F7DY80tnZC12PUmSXUmf5NWMqJ2sgaGKTyb3bX2l+sZbh
	 TaTpwPsKJoDRQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <dwagner@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 33/38] nvmet-fc: avoid deadlock on delete association path
Date: Wed,  7 Feb 2024 16:23:19 -0500
Message-ID: <20240207212337.2351-33-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212337.2351-1-sashal@kernel.org>
References: <20240207212337.2351-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_212450_793686_FB966EB9 
X-CRM114-Status: GOOD (  12.27  )
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

From: Daniel Wagner <dwagner@suse.de>

[ Upstream commit 710c69dbaccdac312e32931abcb8499c1525d397 ]

When deleting an association the shutdown path is deadlocking because we
try to flush the nvmet_wq nested. Avoid this by deadlock by deferring
the put work into its own work item.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/fc.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index b4b2631eb530..36cae038eb04 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -111,6 +111,8 @@ struct nvmet_fc_tgtport {
 	struct nvmet_fc_port_entry	*pe;
 	struct kref			ref;
 	u32				max_sg_cnt;
+
+	struct work_struct		put_work;
 };
 
 struct nvmet_fc_port_entry {
@@ -248,6 +250,13 @@ static int nvmet_fc_tgt_a_get(struct nvmet_fc_tgt_assoc *assoc);
 static void nvmet_fc_tgt_q_put(struct nvmet_fc_tgt_queue *queue);
 static int nvmet_fc_tgt_q_get(struct nvmet_fc_tgt_queue *queue);
 static void nvmet_fc_tgtport_put(struct nvmet_fc_tgtport *tgtport);
+static void nvmet_fc_put_tgtport_work(struct work_struct *work)
+{
+	struct nvmet_fc_tgtport *tgtport =
+		container_of(work, struct nvmet_fc_tgtport, put_work);
+
+	nvmet_fc_tgtport_put(tgtport);
+}
 static int nvmet_fc_tgtport_get(struct nvmet_fc_tgtport *tgtport);
 static void nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
 					struct nvmet_fc_fcp_iod *fod);
@@ -359,7 +368,7 @@ __nvmet_fc_finish_ls_req(struct nvmet_fc_ls_req_op *lsop)
 
 	if (!lsop->req_queued) {
 		spin_unlock_irqrestore(&tgtport->lock, flags);
-		goto out_puttgtport;
+		goto out_putwork;
 	}
 
 	list_del(&lsop->lsreq_list);
@@ -372,8 +381,8 @@ __nvmet_fc_finish_ls_req(struct nvmet_fc_ls_req_op *lsop)
 				  (lsreq->rqstlen + lsreq->rsplen),
 				  DMA_BIDIRECTIONAL);
 
-out_puttgtport:
-	nvmet_fc_tgtport_put(tgtport);
+out_putwork:
+	queue_work(nvmet_wq, &tgtport->put_work);
 }
 
 static int
@@ -1404,6 +1413,7 @@ nvmet_fc_register_targetport(struct nvmet_fc_port_info *pinfo,
 	kref_init(&newrec->ref);
 	ida_init(&newrec->assoc_cnt);
 	newrec->max_sg_cnt = template->max_sgl_segments;
+	INIT_WORK(&newrec->put_work, nvmet_fc_put_tgtport_work);
 
 	ret = nvmet_fc_alloc_ls_iodlist(newrec);
 	if (ret) {
-- 
2.43.0


