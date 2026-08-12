Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBAD0C5CFEB
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2026 18:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H0zxaeAVSjXTNhTujVd3ws3OMZKb9NKMAq0h549TWrQ=; b=UbxM8EG/7n+pyoBuusjoe/K3Iy
	4LMtv67j56YKcRlhaPsFcZbiuVIPdhLQYFJu5RHOxmoG4gO6oaw94X5KEw7dy0bTtKF9WPtiL6hl4
	uQxMG9Z39RDWLfbwZn+wd2yd3mj1/K25kR8Q22nQjN7RX9LqLNBk7qid1mv9bnSmOcuJd7Z55tWGC
	6dXslU7zj+iJNE/RG9m6Uqm/hTQIv2ko3OK0ufH/41cbP5Pf8kvC1tfkWbgj+07NdCRdjH66vGlS2
	eyUGc5XBfmVF6VT03iu0ayRbNNQm6VWgsnUzYBpLTi+Y/Oz7axN0sTrWwqs69rbXTh1XMzCBIRxBM
	84lm+PDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuDTE-0000000GlR7-0XLG;
	Wed, 12 Aug 2026 18:14:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuDTC-0000000GlOz-0mjz
	for linux-nvme@lists.infradead.org;
	Wed, 12 Aug 2026 18:14:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786558469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H0zxaeAVSjXTNhTujVd3ws3OMZKb9NKMAq0h549TWrQ=;
	b=gpnjy3QGU38J5MwNt+xfaT7hzIbmWcaCTQ8xBWqykSu+TbMLexW0HOolXIgZpslHh4hFQ1
	cV9qwrZtQHfJb2e63PRdqhQP6KRJ0hGgRFNlTguW97znh539d6OOlxhFYFkT54MLQWUVUd
	1F8uZVo6tK1XCyNn6WSwDf/+SvUcQNo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-5ZS0RTWTP72E3Tbr9Bx9aA-1; Wed,
 12 Aug 2026 14:14:17 -0400
X-MC-Unique: 5ZS0RTWTP72E3Tbr9Bx9aA-1
X-Mimecast-MFC-AGG-ID: 5ZS0RTWTP72E3Tbr9Bx9aA_1786558453
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E13F18002F8;
	Wed, 12 Aug 2026 18:14:13 +0000 (UTC)
Received: from jtaubepe-thinkpadx1carbongen12.ibmlowe.csb (unknown [10.22.88.181])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 17B07180034C;
	Wed, 12 Aug 2026 18:14:07 +0000 (UTC)
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
Subject: [PATCH 11/13] scsi: lpfc: enable FPIN notification for NVMe
Date: Wed, 12 Aug 2026 14:12:58 -0400
Message-ID: <20260812181300.3712426-12-jtaubepe@redhat.com>
In-Reply-To: <20260812181300.3712426-1-jtaubepe@redhat.com>
References: <20260812181300.3712426-1-jtaubepe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: e3Lxv6WgKOXo371eWiist9zwS4BPG9Xh4GAivoDG9s8_1786558453
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_111430_305307_72C0B15B 
X-CRM114-Status: GOOD (  12.80  )
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
V10 -> V11
 - Rewrite
---
 drivers/scsi/lpfc/lpfc_attr.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index f4e8164b94ab..d54899cceed9 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -7134,6 +7134,30 @@ lpfc_set_rport_loss_tmo(struct fc_rport *rport, uint32_t timeout)
 #endif
 }
 
+static void
+lpfc_set_rport_marginal(struct fc_rport *rport, bool marginal)
+{
+	struct lpfc_rport_data *rdata = rport->dd_data;
+	struct lpfc_nodelist *ndlp = rdata->pnode;
+	struct lpfc_nvme_rport *nrport = NULL;
+
+	/* Break early if NVME_FC is not enabled */
+	if (!IS_ENABLED(CONFIG_NVME_FC))
+		return;
+
+	if (!ndlp) {
+		dev_info(&rport->dev, "Cannot find remote node to ");
+		dev_info(&rport->dev, "set rport marginal, port_id x%x\n",
+			 rport->port_id);
+		return;
+	}
+
+	nrport = lpfc_ndlp_get_nrport(ndlp);
+
+	if (nrport && nrport->remoteport)
+		nvme_fc_set_remoteport_fpin(nrport->remoteport, marginal);
+}
+
 /*
  * lpfc_rport_show_function - Return rport target information
  *
@@ -7244,6 +7268,8 @@ struct fc_function_template lpfc_transport_functions = {
 	.set_rport_dev_loss_tmo = lpfc_set_rport_loss_tmo,
 	.show_rport_dev_loss_tmo = 1,
 
+	.set_rport_marginal = lpfc_set_rport_marginal,
+
 	.get_starget_port_id  = lpfc_get_starget_port_id,
 	.show_starget_port_id = 1,
 
@@ -7315,6 +7341,8 @@ struct fc_function_template lpfc_vport_transport_functions = {
 	.set_rport_dev_loss_tmo = lpfc_set_rport_loss_tmo,
 	.show_rport_dev_loss_tmo = 1,
 
+	.set_rport_marginal = lpfc_set_rport_marginal,
+
 	.get_starget_port_id  = lpfc_get_starget_port_id,
 	.show_starget_port_id = 1,
 
-- 
2.54.0


