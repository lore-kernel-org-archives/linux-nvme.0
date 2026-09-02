Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 782EDC624D4
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2026 20:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XMYZkkfvLk4oMTmC0tcijBigxpVsXAU2YnaVB3q+VDM=; b=aajiY5ISqhnje9jXpd3dG0zjH+
	3usxmjeOKgeqSQowzyhRr5GZ69i87lcr9y0gm6HHwRXwwEHAxkLhr9J96moNOr0o567AshbYSr38F
	8b9AZxy63aPt7+6FP7pHES+2Y1zXk74rg1qS+XtUz9X0RoRf8JZkf8QDzhN1QHHsM2dzv1zMKDEmQ
	25M8+nOg7SlynKJxORy2Beg+bqmIIV91DILUKhAE1wwbKrn8oW9boDm5sPqWSReoUNOt4oesrdjzI
	i1WwUAHd0jnA18sg5yb6voxoktyKPRY/4xmZZLxlrc5YL7ZScUybGX767rfAqcX5KHfTkdH2rXrn1
	yjfDXFPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1rE6-0000000FoXY-089N;
	Wed, 02 Sep 2026 20:06:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1rE2-0000000FoVR-0qcF
	for linux-nvme@lists.infradead.org;
	Wed, 02 Sep 2026 20:06:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788379585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XMYZkkfvLk4oMTmC0tcijBigxpVsXAU2YnaVB3q+VDM=;
	b=hH6lAXGcdTHiiad7QakxLxNsqB7ckUGQ9cH6MD3lwf1ZRSzvi5y3oHPgvtRU4IYBjvUCBt
	kNzJ6qZzCqjF83wt4OnEMOHj7Kodopyj+/VYe/bkv+6XHQEKNNf0Fb0EN+BknkhuFT38Bd
	jP5RqPwVXnqTIw1hNQN4hFOT8uq3hl4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-119-Oa_6jVWVNQewd7r_--03mw-1; Wed,
 02 Sep 2026 16:06:19 -0400
X-MC-Unique: Oa_6jVWVNQewd7r_--03mw-1
X-Mimecast-MFC-AGG-ID: Oa_6jVWVNQewd7r_--03mw_1788379575
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 691F9192DD55;
	Wed,  2 Sep 2026 20:06:15 +0000 (UTC)
Received: from jtaubepe-thinkpadx1carbongen12.ibmlowe.csb (unknown [10.17.16.153])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B12581955F02;
	Wed,  2 Sep 2026 20:06:11 +0000 (UTC)
From: Jesse Taube <jtaubepe@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: linux-scsi@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Nilesh Javali <njavali@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	Hannes Reinecke <hare@suse.de>,
	Jesse Taube <jtaubepe@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	John Meneghini <jmeneghi@redhat.com>,
	Bryan Gurney <bgurney@redhat.com>,
	Chris Leech <cleech@redhat.com>,
	"Ewan D . Milne" <emilne@redhat.com>,
	shinichiro.kawasaki@wdc.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH v2 6/7] nvme-fc: add nvme_fc_set_remoteport_fpin()
Date: Wed,  2 Sep 2026 16:05:46 -0400
Message-ID: <20260902200547.184734-7-jtaubepe@redhat.com>
In-Reply-To: <20260902200547.184734-1-jtaubepe@redhat.com>
References: <20260902200547.184734-1-jtaubepe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: b3xZYJ686BtD3ewsJDb7BvO9n0D83xqqNmMiCHOQjMw_1788379575
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_130626_316375_D41F317F 
X-CRM114-Status: GOOD (  14.02  )
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

Add nvme_fc_set_remoteport_fpin() and supporting functions. This
function is called by the SCSI FC transport and driver layer to set or
clear the 'marginal' path status for a specific rport.

Co-developed-by: Hannes Reinecke <hare@kernel.org>
Signed-off-by: Hannes Reinecke <hare@kernel.org>
Signed-off-by: John Meneghini <jmeneghi@redhat.com>
Signed-off-by: Jesse Taube <jtaubepe@redhat.com>
---
V10 -> V1:
 - Remove nvme_fc_modify_rport_fpin_state
 - Use struct nvme_fc_remote_port instead of wwpn and wwnn
V1 -> V2:
 - Use nvme_ctrl_assign_marginal over set/clear_bit
---
 drivers/nvme/host/fc.c         | 13 +++++++++++++
 include/linux/nvme-fc-driver.h |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 7886c0dcc626..c4810d048b87 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -895,6 +895,19 @@ nvme_fc_set_remoteport_devloss(struct nvme_fc_remote_port *portptr,
 }
 EXPORT_SYMBOL_GPL(nvme_fc_set_remoteport_devloss);
 
+void
+nvme_fc_set_remoteport_fpin(struct nvme_fc_remote_port *portptr, bool marginal)
+{
+	struct nvme_fc_rport *rport = remoteport_to_rport(portptr);
+	struct nvme_fc_ctrl *ctrl;
+	unsigned long flags;
+
+	spin_lock_irqsave(&rport->lock, flags);
+	list_for_each_entry(ctrl, &rport->ctrl_list, ctrl_list)
+		nvme_ctrl_assign_marginal(&ctrl->ctrl, marginal);
+	spin_unlock_irqrestore(&rport->lock, flags);
+}
+EXPORT_SYMBOL_GPL(nvme_fc_set_remoteport_fpin);
 
 /* *********************** FC-NVME DMA Handling **************************** */
 
diff --git a/include/linux/nvme-fc-driver.h b/include/linux/nvme-fc-driver.h
index 9f6acadfe0c8..95d79386d126 100644
--- a/include/linux/nvme-fc-driver.h
+++ b/include/linux/nvme-fc-driver.h
@@ -536,6 +536,8 @@ void nvme_fc_rescan_remoteport(struct nvme_fc_remote_port *remoteport);
 int nvme_fc_set_remoteport_devloss(struct nvme_fc_remote_port *remoteport,
 			u32 dev_loss_tmo);
 
+void nvme_fc_set_remoteport_fpin(struct nvme_fc_remote_port *portptr, bool marginal);
+
 /*
  * Routine called to pass a NVME-FC LS request, received by the lldd,
  * to the nvme-fc transport.
-- 
2.55.0


