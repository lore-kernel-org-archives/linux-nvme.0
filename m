Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFB9C7115B
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Jun 2025 17:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Oaks/0jSVI/AymMABPEdKfpIHanqGaQ44YoIiGNmMKU=; b=sLhMDk3IbVr1DcJGTSEir2ktZG
	EKfYqoTFCu4kbt45OaXidGTMMOvRSlIuztx7xh9RfmAbEULx5sh3hMSubjnYP6h2XIoeprlEp3NsK
	+BfYBifPKwmNDECpKGJCy+uIpWcyGpqY+HQ+CRIAMQ7kQBa35ra2QK2EI6U12vY4puzpvh0ZiI1l7
	HnL0GuXC6MlGUh3KaOcf7z589dpDGml+iy+BOQKddha0aMKcds76yMTf530LiBzEFwyQGdoHXoh82
	LTN42YOv5Tmogcj6bHgTMqqfn4XN2jksOm0HyGOlh0KAIyc+Mb/dvyn83uTbKl87kZnTYRWDPDcD0
	5MXsNRtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSg0L-0000000GJVI-3TnP;
	Fri, 20 Jun 2025 17:58:21 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSg0J-0000000GJU1-0oE0
	for linux-nvme@lists.infradead.org;
	Fri, 20 Jun 2025 17:58:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750442298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Oaks/0jSVI/AymMABPEdKfpIHanqGaQ44YoIiGNmMKU=;
	b=JjdWJZLUvJ3SR6saYrSzSyfk+6+1LylpQoTlKJWIfM/TtDY7h3kLtmr6IpyQEBqRP440oy
	ayhOwssjPOKjnarUBosh0y54Op0EHzmIzKEnuaD6+wuBMFD58HKqUF6h7DEYSuH4Emo07z
	IAjsbtQ2ezs2Lu3Hw5E78G98EkqBWcA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-OEjh7aPJPCqJA52Bfqb9uw-1; Fri,
 20 Jun 2025 13:58:11 -0400
X-MC-Unique: OEjh7aPJPCqJA52Bfqb9uw-1
X-Mimecast-MFC-AGG-ID: OEjh7aPJPCqJA52Bfqb9uw_1750442289
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8BE70195608B;
	Fri, 20 Jun 2025 17:58:09 +0000 (UTC)
Received: from bgurney-thinkpadp1gen5.remote.csb (unknown [10.22.80.187])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA05318002B5;
	Fri, 20 Jun 2025 17:58:06 +0000 (UTC)
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
Subject: [PATCH v6 5/6] qla2xxx: enable FPIN notification for NVMe
Date: Fri, 20 Jun 2025 13:58:00 -0400
Message-ID: <20250620175800.34769-1-bgurney@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250620_105819_307082_58890C2B 
X-CRM114-Status: UNSURE (   7.58  )
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


