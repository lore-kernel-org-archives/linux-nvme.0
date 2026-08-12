Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 231A7C5CFEB
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2026 18:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o8Vm2d0HmZn6yHF6SDZo37n0cyZKJwfRhArj8eZSh5c=; b=WcI75934iKrrOq1mv+11R1VHyW
	8kaC+847fwcPoXBxdJ9RLJe2K6UHAE/I+h/5LRzSDweR2av3Y9tsByPIvlQR6ZUqqe7y6QyyffljX
	v2AHFf1716Mfjvi+AMaxwyLLHMu6QsDeF0f2PMm5hykjl/lCezBjK0GSJ2jPN2f2zgWdvDgKYMWdK
	9w4he9s7zmV1rKq6XOZ91URDrdCtUQ2+zLVGFiahAhHGS6c9asRKaOcIcNtWnDlvN0YNB4ddxYNlq
	db0H0h6ii0NWsp1xE1k3jwmRwkmTusSuM52Fggp/o47e66arujwRH6eJ5SCyBWW6lt5PTftJGanu3
	gABPvUkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuDTA-0000000GlNu-1wrZ;
	Wed, 12 Aug 2026 18:14:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuDT7-0000000GlJy-1IE1
	for linux-nvme@lists.infradead.org;
	Wed, 12 Aug 2026 18:14:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786558464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o8Vm2d0HmZn6yHF6SDZo37n0cyZKJwfRhArj8eZSh5c=;
	b=QxIEVClSNX06tv5OkHueYyfLdOIuECvccn1v3ABkEpK67Kg2as2XHGei/y/70kC3EILteP
	ckQp1hyUlgthIk/R4E1wYKCkVKwazi6s+uuEUooXKN6yTrvLzhqP2TinhqycrDC1r5mRa5
	DVJeBtHFZvX2fCS3ta4LPJ34Ysew6BM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642--1tVOwXyPkSB9oZ3Oq5F1g-1; Wed,
 12 Aug 2026 14:14:19 -0400
X-MC-Unique: -1tVOwXyPkSB9oZ3Oq5F1g-1
X-Mimecast-MFC-AGG-ID: -1tVOwXyPkSB9oZ3Oq5F1g_1786558448
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BE4961954B01;
	Wed, 12 Aug 2026 18:14:07 +0000 (UTC)
Received: from jtaubepe-thinkpadx1carbongen12.ibmlowe.csb (unknown [10.22.88.181])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 69AFA18005BB;
	Wed, 12 Aug 2026 18:14:02 +0000 (UTC)
From: Jesse Taube <jtaubepe@redhat.com>
To: linux-scsi@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
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
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 10/13] scsi: qla2xxx: enable FPIN notification for NVMe
Date: Wed, 12 Aug 2026 14:12:57 -0400
Message-ID: <20260812181300.3712426-11-jtaubepe@redhat.com>
In-Reply-To: <20260812181300.3712426-1-jtaubepe@redhat.com>
References: <20260812181300.3712426-1-jtaubepe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: GCwVOyftT0E2GR4K_2G8PGrJcZXBb7-P5YiFSzaXgMQ_1786558448
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_111425_434083_305E0A92 
X-CRM114-Status: GOOD (  11.55  )
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

Implement set_rport_marginal callback using
nvme_fc_set_remoteport_fpin() to enable FPIN notifications for NVMe.

Signed-off-by: Jesse Taube <jtaubepe@redhat.com>
---
V10 -> V11:
 - Rewrite
---
 drivers/scsi/qla2xxx/qla_attr.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_attr.c b/drivers/scsi/qla2xxx/qla_attr.c
index a4ca22024ede..92db7d584eeb 100644
--- a/drivers/scsi/qla2xxx/qla_attr.c
+++ b/drivers/scsi/qla2xxx/qla_attr.c
@@ -2789,6 +2789,15 @@ qla2x00_set_rport_loss_tmo(struct fc_rport *rport, uint32_t timeout)
 					       rport->dev_loss_tmo);
 }
 
+static inline void
+qla2x00_set_rport_marginal(struct fc_rport *rport, bool marginal)
+{
+	fc_port_t *fcport = *(fc_port_t **)rport->dd_data;
+
+	if (IS_ENABLED(CONFIG_NVME_FC) && fcport && fcport->nvme_remote_port)
+		nvme_fc_set_remoteport_fpin(fcport->nvme_remote_port, marginal);
+}
+
 static void
 qla2x00_dev_loss_tmo_callbk(struct fc_rport *rport)
 {
@@ -3379,6 +3388,8 @@ struct fc_function_template qla2xxx_transport_functions = {
 	.set_rport_dev_loss_tmo = qla2x00_set_rport_loss_tmo,
 	.show_rport_dev_loss_tmo = 1,
 
+	.set_rport_marginal = qla2x00_set_rport_marginal,
+
 	.issue_fc_host_lip = qla2x00_issue_lip,
 	.dev_loss_tmo_callbk = qla2x00_dev_loss_tmo_callbk,
 	.terminate_rport_io = qla2x00_terminate_rport_io,
@@ -3427,6 +3438,8 @@ struct fc_function_template qla2xxx_transport_vport_functions = {
 	.set_rport_dev_loss_tmo = qla2x00_set_rport_loss_tmo,
 	.show_rport_dev_loss_tmo = 1,
 
+	.set_rport_marginal = qla2x00_set_rport_marginal,
+
 	.issue_fc_host_lip = qla2x00_issue_lip,
 	.dev_loss_tmo_callbk = qla2x00_dev_loss_tmo_callbk,
 	.terminate_rport_io = qla2x00_terminate_rport_io,
-- 
2.54.0


