Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15B8C531C9
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2026 12:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jKoTH6YhZJCES8wfkiGycJx9zg314LQ4knJp5Pqi5KY=; b=syhJi+ZPdX/Uenkl/g1BFUO2sb
	ilO6WCJozBDJxcDz0XwuCXWZXVcEez2nHaG5vogW9y0t1moiI1N2yHY0W1CuLd2pyasewhTtFhMab
	Sdof/7AVY5HFI5sbm1AW23XzFX2Jw1Ki/nMjwI/wHWdMEokokLgo5ZtAHj1JCggSGF/sQmSOEtfMU
	piRZz6qwtuD9CiIdvQbC6D1IM3eRIuFoBZDb1MJM186ZPSdNRPLiXBxml7XiccWETilZcZRk4e9sP
	dzsJUw+QJF8z8Vl5wtKUzIZYk77bQqFEGpd/2dO9FnN18IomqDEiBOCCJCiCFGNNhGs/WrYjvaymk
	cSWeWuRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnDoY-0000000GFBo-0RyR;
	Fri, 24 Jul 2026 11:11:38 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnDoU-0000000GF7Q-1DFK
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jul 2026 11:11:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7EC3460A82;
	Fri, 24 Jul 2026 11:11:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC5DDC5383A;
	Fri, 24 Jul 2026 11:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784891492;
	bh=DCUAfDxEseZk6ZmmVcrtbVNMa1iqDO1q+qOvgJZt55w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HI15W8z9H2F/ItIkgJzoiEQ2O5YH3W5nyujbrAmdQE4/I/3MgSjwSAit88cw1tEOr
	 8FB5FsST/OWB/XH8aNqK76B5kxAw8UiWlKzlp6HtGFyEzesyuReCQ757DSlNwUeKCy
	 mxU61txk+cHVlV5BIqh2Bh+QXroNhUk8ABnlftoQgrfuUSK71wiBQNevdkdbXJxr6X
	 2+dZzKoqdQMHko6omwh5o6A3adTvpMWDGltSmAwM4kLvTKjuFJwgEclwRFf1RN8zZN
	 aA4KH4Oejma+BYBgVDeqAAqjQaw1W5+LMDq4zO7h8lRE6ps6v/H+IN5wM2x1dUgQn3
	 avR7lUVxS3Grg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D22C531F9;
	Fri, 24 Jul 2026 11:11:32 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Fri, 24 Jul 2026 13:11:04 +0200
Subject: [PATCH RFC v2 10/14] nvme: Pin a ctrl ref to every CDQ
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-jag-cdq-lkml-v2-10-659a7449e849@kernel.org>
References: <20260724-jag-cdq-lkml-v2-0-659a7449e849@kernel.org>
In-Reply-To: <20260724-jag-cdq-lkml-v2-0-659a7449e849@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2007;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=DCUAfDxEseZk6ZmmVcrtbVNMa1iqDO1q+qOvgJZt55w=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGpjSF69HTOAZxtOOJS4e3Kf5yJRhPvY7UVMU
 E3e6K8IECOrbYkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJqY0heAAoJELqXzVK3
 lkFPR+oL/iwl4Zmoe0nvHf9iQioW99Y9emfyJqBLzf61u2qRPuNce3fo9FMLlJoIjugVUpeiwQ7
 iqfw9mfKGkgl7bEpt2xT2VDwdvly9QbmFd90pevNlhv3jbAK2VH3XOuB4HVm3BhbIvkvpa5OE8o
 IOz4tjHFTN3y8K0MErx03GXxi1ERGWPtTC72S2egNte+1mztCRcc+CnUN1UDeXweD2nuaKCgdPu
 bzi9AomZq1JBPlXUDCx3s/BPWSDdZ/t1WvSrFUucagCeIasbSQK1RGD5N97yUxXA6qIZ5kds6aa
 vs0KwLOzlPSFLxJAPg7M4RRWodw18ecSjBDoJcLeESwZ+RM8ONj8MUFVDQyfrwtFRDQwoyOChSM
 W6MUNsa/E/dNDGGA9u3QFhYZ55deAt62+nyXtAowbQNt8aWLfR83fjzQblU2DBpNNOKcBtsMg/Y
 7JXA6WfjwaDtgE66VSlRmavOJCQ0DLkOSomyUU6iq4XrLFOiZAV+7Ej39vOxyAyexQBdwt/kUh5
 8g=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239
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

Make sure that the migration manager controller pointed by the CDQ does
not get freed unless all CDQs are terminated by user space.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 drivers/nvme/host/cdq.h | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/cdq.h b/drivers/nvme/host/cdq.h
index aa9469af0c7ef08b9f8ebf93e468c7f892aee4b1..a8c714ab5fada4325463013c2ffb23a117cd8423 100644
--- a/drivers/nvme/host/cdq.h
+++ b/drivers/nvme/host/cdq.h
@@ -29,7 +29,7 @@ struct nvme_cdq_chunk {
 
 struct cdq_nvme_queue {
 	u16 id;
-	struct nvme_ctrl *ctrl;
+	struct nvme_ctrl *ctrl; // this is kref'ed for the life of the CDQ
 	u32 size_nbyte;
 	u16 mc_id; // migratable controller id
 
@@ -49,11 +49,20 @@ struct cdq_nvme_queue {
 	struct kref ref;
 };
 
-/* Must not touch cdq->ctrl: Ctrl may have been freed */
-static inline void nvme_free_cdq(struct kref *ref)
-{
-	kfree(container_of(ref, struct cdq_nvme_queue, ref));
-}
+/*
+ * nvme_free_cdq:
+ *    - Is called with the cdq struct has no more krefs.
+ *    - Will free (cdq) and decrease ctrl kref.
+ */
+void nvme_free_cdq(struct kref *ref);
+/* nvme_cdq_delete:
+ *    - Sends a nvme delete cmd to the controller
+ *    - removes (cdq) from controller xarray
+ *    - frees the backing CDQ mem
+ *    - Calls nvme_free_cdq if there are no more refs
+ */
+void nvme_delete_cdq(struct cdq_nvme_queue *cdq);
+int nvme_create_cdq(struct nvme_ctrl *ctrl, const u32 entry_nr, const u16 mc_id);
 
 static inline void nvme_cdq_get(struct cdq_nvme_queue *cdq)
 {
@@ -65,8 +74,6 @@ static inline void nvme_cdq_put(struct cdq_nvme_queue *cdq)
 	kref_put(&cdq->ref, nvme_free_cdq);
 }
 
-void nvme_delete_cdq(struct cdq_nvme_queue *cdq);
-int nvme_create_cdq(struct nvme_ctrl *ctrl, const u32 entry_nr, const u16 mc_id);
 void nvme_delete_cdqs_host(struct nvme_ctrl *ctrl);
 void nvme_free_cdqs(struct nvme_ctrl *ctrl);
 

-- 
2.50.1



