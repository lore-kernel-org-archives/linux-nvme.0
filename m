Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C692C77B7F
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Jun 2025 22:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Oaks/0jSVI/AymMABPEdKfpIHanqGaQ44YoIiGNmMKU=; b=1RPXXQQBlJjwDK1hm5wiFPo034
	7hoDwtYv1itU5CP/DssOfyHmUgBREB8HA6jobJKpbjS7ZM+/m5QHgFlIJ7XhK77TXvLae/ohmfIIJ
	Lff/42qTTJnSLfGRlS+EF0VvFRFVqrV4sw4QVAhQT/t92YB64g/OnoQ20c9b8ps3Q8NlJRIJK+W1A
	20Tgw1X4mNDfMgKkMVmGn2UBN9/CQDEHpizxtxpumpvXFviVry1f+mQkbzRJfhJunJ/ghnW98E/Ip
	aCVLfHnZjD2k7KJAHDbjfohg1zrrWRzK6APC0pIqx8T91jP63wHALlNtC0jAtcDnaKVN3HIbdtoFB
	Eo25HmFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUBuD-00000006xLs-43vI;
	Tue, 24 Jun 2025 22:14:17 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUABY-00000006krt-3LUr
	for linux-nvme@lists.infradead.org;
	Tue, 24 Jun 2025 20:24:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750796643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oaks/0jSVI/AymMABPEdKfpIHanqGaQ44YoIiGNmMKU=;
	b=HiEfLhUE2N4YusSOVOJcuDXfErFRlbd2f0cTp1hFJYRqhYOBbjc0XkacU82arI/EB860fq
	5UgV6/8c05Fr+CcPdD6hsgXbb9l+cJNZk9IUi0au/Zq5KPxQjbd75EM2YagTv/dq4jIKXp
	4O+7WWu4ajiSv0ZbV3f85joxYom88eY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-aLQqzPXbMI-Zz69Sjz0ThQ-1; Tue,
 24 Jun 2025 16:23:58 -0400
X-MC-Unique: aLQqzPXbMI-Zz69Sjz0ThQ-1
X-Mimecast-MFC-AGG-ID: aLQqzPXbMI-Zz69Sjz0ThQ_1750796636
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 89A06180028B;
	Tue, 24 Jun 2025 20:23:56 +0000 (UTC)
Received: from bgurney-thinkpadp1gen5.remote.csb (unknown [10.45.226.95])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 62186180035E;
	Tue, 24 Jun 2025 20:23:51 +0000 (UTC)
From: Bryan Gurney <bgurney@redhat.com>
To: linux-nvme@lists.infradead.org,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk
Cc: james.smart@broadcom.com,
	dick.kennedy@broadcom.com,
	njavali@marvell.com,
	linux-scsi@vger.kernel.org,
	hare@suse.de,
	bgurney@redhat.com,
	jmeneghi@redhat.com
Subject: [PATCH v7 5/6] qla2xxx: enable FPIN notification for NVMe
Date: Tue, 24 Jun 2025 16:20:19 -0400
Message-ID: <20250624202020.42612-6-bgurney@redhat.com>
In-Reply-To: <20250624202020.42612-1-bgurney@redhat.com>
References: <20250624202020.42612-1-bgurney@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250624_132404_908109_1E8E23B2 
X-CRM114-Status: UNSURE (   8.32  )
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

From: Hannes Reinecke <hare@kernel.org>

Call 'nvme_fc_fpin_rcv()' to enable FPIN notifications for NVMe.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/scsi/qla2xxx/qla_isr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index fe98c76e9be3..cfe7afc905b4 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -46,6 +46,9 @@ qla27xx_process_purex_fpin(struct scsi_qla_host *vha, struct purex_item *item)
 		       pkt, pkt_size);
 
 	fc_host_fpin_rcv(vha->host, pkt_size, (char *)pkt, 0);
+#if (IS_ENABLED(CONFIG_NVME_FC))
+	nvme_fc_fpin_rcv(vha->nvme_local_port, pkt_size, (char *)pkt);
+#endif
 }
 
 const char *const port_state_str[] = {
-- 
2.49.0


