Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19EB7C5B572
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2026 18:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=woRBEeCuMp7hyrBJ2Q40BtYs80iQwOB8q8GOznjCNqM=; b=JqafuoN7amsayC7lQWjnkmiCFA
	NYj7+J5lg/D0Vg+jGQuSixT45xJAr++ipuHGR4yE7+ct8G5s1BwXs/k8XWY8R22m2w7kAxQrAryOv
	ECVIA1KKxk5deTqOjf39nwsDSF6yl8syV4wzgYyFmiztuwV4l6wHdAfZHCawDOnpZmbHXq3gN0SIY
	kfsYEe31eAcJrkBb4xAOAiBBHG9IPCgyfLeAUxce+kWC6hWvNVGAJTU7C2TcvuWfk5XYmmBDqs1qa
	HIIi12glfR9BwqtELJlJ2IQZAxiwHcu3tn4LQdt/4Z8KNcoVRYJyt6PpLAhqM0dR9s3sQus/vwOSg
	44tJrOUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuDSt-0000000GlBT-3GKd;
	Wed, 12 Aug 2026 18:14:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuDSr-0000000Gl9A-28Ze
	for linux-nvme@lists.infradead.org;
	Wed, 12 Aug 2026 18:14:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786558448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=woRBEeCuMp7hyrBJ2Q40BtYs80iQwOB8q8GOznjCNqM=;
	b=ChuHLNwIQ0uBD5WlsoxdcZuuCnunwOR3LMLlthQwrPZ7Ic0KwIFGy7wTqBsffSwop7H6LY
	biy+ubsoJqqh+iQNZGv5yX8V5633XhxP62IwmFYPeUB9T5LgrrOQH0jXvMPWVLioQ7Kt7j
	86tAB2j/5xrVvcudbLsdgADeJFlih4s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-5lW4P-fXMsK4jTInPoZ6QA-1; Wed,
 12 Aug 2026 14:14:01 -0400
X-MC-Unique: 5lW4P-fXMsK4jTInPoZ6QA-1
X-Mimecast-MFC-AGG-ID: 5lW4P-fXMsK4jTInPoZ6QA_1786558437
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 380B81800747;
	Wed, 12 Aug 2026 18:13:57 +0000 (UTC)
Received: from jtaubepe-thinkpadx1carbongen12.ibmlowe.csb (unknown [10.22.88.181])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 777AB18005BC;
	Wed, 12 Aug 2026 18:13:51 +0000 (UTC)
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
Subject: [PATCH 08/13] scsi: scsi_transport_fc: user support for clearing NVME_CTRL_MARGINAL
Date: Wed, 12 Aug 2026 14:12:55 -0400
Message-ID: <20260812181300.3712426-9-jtaubepe@redhat.com>
In-Reply-To: <20260812181300.3712426-1-jtaubepe@redhat.com>
References: <20260812181300.3712426-1-jtaubepe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: UOVjce8f2ZC1sXjIWmaArGDoaeFC_8H1-8rrmeVQ8rQ_1786558437
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_111409_634707_3FE24561 
X-CRM114-Status: GOOD (  18.20  )
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

From: John Meneghini <jmeneghi@redhat.com>

Refactor and fc_rport_set_marginal_state smp safe by holding
`shost->host_lock` around all `rport->port_state` accesses.

Call nvme_fc_modify_rport_fpin_state() when FC_PORTSTATE_MARGINAL is set
or cleared.  This allows the user to quickly set or clear the
NVME_CTRL_MARGINAL state from sysfs.

E.g.:

 echo "Marginal" > /sys/class/fc_remote_ports/rport-13:0-5/port_state
 echo "Online" > /sys/class/fc_remote_ports/rport-13:0-5/port_state

Note: nvme_fc_modify_rport_fpin_state() will only affect rports that
      have FC_PORT_ROLE_NVME_TARGET set.

Signed-off-by: John Meneghini <jmeneghi@redhat.com>
---
V10 -> V11:
 - No change
---
 drivers/scsi/scsi_transport_fc.c | 42 +++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transport_fc.c
index df1edf3c23fa..af309a7bdc22 100644
--- a/drivers/scsi/scsi_transport_fc.c
+++ b/drivers/scsi/scsi_transport_fc.c
@@ -1251,34 +1251,58 @@ static ssize_t fc_rport_set_marginal_state(struct device *dev,
 						const char *buf, size_t count)
 {
 	struct fc_rport *rport = transport_class_to_rport(dev);
+	struct Scsi_Host *shost = rport_to_shost(rport);
+	struct fc_internal *i = to_fc_internal(shost->transportt);
 	enum fc_port_state port_state;
 	int ret = 0;
+	unsigned long flags;
 
 	ret = get_fc_port_state_match(buf, &port_state);
 	if (ret)
 		return -EINVAL;
-	if (port_state == FC_PORTSTATE_MARGINAL) {
+
+	spin_lock_irqsave(shost->host_lock, flags);
+
+	switch (port_state) {
+	case FC_PORTSTATE_MARGINAL:
 		/*
 		 * Change the state to Marginal only if the
 		 * current rport state is Online
 		 * Allow only Online->Marginal
 		 */
-		if (rport->port_state == FC_PORTSTATE_ONLINE)
+		if (rport->port_state == FC_PORTSTATE_ONLINE) {
 			rport->port_state = port_state;
-		else if (port_state != rport->port_state)
-			return -EINVAL;
-	} else if (port_state == FC_PORTSTATE_ONLINE) {
+			spin_unlock_irqrestore(shost->host_lock, flags);
+			if (i->f->set_rport_marginal)
+				i->f->set_rport_marginal(rport, true);
+			return count;
+		}
+		break;
+
+	case FC_PORTSTATE_ONLINE:
 		/*
 		 * Change the state to Online only if the
 		 * current rport state is Marginal
 		 * Allow only Marginal->Online
 		 */
-		if (rport->port_state == FC_PORTSTATE_MARGINAL)
+		if (rport->port_state == FC_PORTSTATE_MARGINAL) {
 			rport->port_state = port_state;
-		else if (port_state != rport->port_state)
-			return -EINVAL;
-	} else
+			spin_unlock_irqrestore(shost->host_lock, flags);
+			if (i->f->set_rport_marginal)
+				i->f->set_rport_marginal(rport, false);
+			return count;
+		}
+		break;
+	default:
+		break;
+	}
+
+	if (port_state != rport->port_state) {
+		spin_unlock_irqrestore(shost->host_lock, flags);
 		return -EINVAL;
+	}
+
+	spin_unlock_irqrestore(shost->host_lock, flags);
 	return count;
 }
 
-- 
2.54.0


