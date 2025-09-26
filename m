Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E94ACAC5B0
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Sep 2025 00:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zTzFVbjHXVsknsPRHOXOTqtlNnLilGwJ/YF3mbRhYig=; b=k9dohqRut8qH7GLGaey7U6XJ+C
	GCPu4QRcdL1LfZkx6mXDZBxSXXb5geElTQJQwXk4dKfU29+trdzoNRIJFaIALzL+23jEpGdF7ZPRm
	8C1NFwQm9LJu7Swjokj2gVpeDW3YwerozKszCmP3oMVXSdIVAg7jAuRvGuHhQvgzo8oNeKZStSdwE
	MZUDWgY5HaMySmExrTgekL8NG2KS2n1FpF6GDMZYk9ZWj/ikQK8TfsYamjxiCH5gqdFKkRy9fwdQc
	1uzYdoWyJfNavnd7nRTkfFsjZnWvYmNX5U+8goshsGrzNO4ccoBsUnH7e5g4hE+X9Qkg5Y6vwTq6I
	PhDvsL7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1vv4-0000000EApt-244X;
	Fri, 26 Sep 2025 00:02:38 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1vv1-0000000EAmZ-3g07
	for linux-nvme@lists.infradead.org;
	Fri, 26 Sep 2025 00:02:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758844955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zTzFVbjHXVsknsPRHOXOTqtlNnLilGwJ/YF3mbRhYig=;
	b=P+hefbqtuNX27JwWu3fQvUVpVi6YdKiqeqDfMjnrGT38eE81R0G9oKfEYhAIzoTwjzZdOQ
	qS6zMyFGUFWIovzNPQridThFgW5O0cXij23OWIDHrcEdlTvx+RcYbI1HaaZqVjBwbBB1nj
	KkD+X/YgDdIaFdYf1OxXE+7kP4PV/n0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-LmOT7VcBOS6eBMhgP8PJOA-1; Thu,
 25 Sep 2025 20:02:30 -0400
X-MC-Unique: LmOT7VcBOS6eBMhgP8PJOA-1
X-Mimecast-MFC-AGG-ID: LmOT7VcBOS6eBMhgP8PJOA_1758844948
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5627C180057F;
	Fri, 26 Sep 2025 00:02:28 +0000 (UTC)
Received: from jmeneghi-thinkpadp1gen7.rmtusnh.csb (unknown [10.22.81.200])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6CB051800579;
	Fri, 26 Sep 2025 00:02:25 +0000 (UTC)
From: John Meneghini <jmeneghi@redhat.com>
To: hare@suse.de,
	kbusch@kernel.org,
	martin.petersen@oracle.com,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Cc: bgurney@redhat.com,
	axboe@kernel.dk,
	emilne@redhat.com,
	gustavoars@kernel.org,
	hch@lst.de,
	james.smart@broadcom.com,
	jmeneghi@redhat.com,
	kees@kernel.org,
	linux-hardening@vger.kernel.org,
	njavali@marvell.com,
	sagi@grimberg.me
Subject: [PATCH v10 06/11] nvme-fc: add nvme_fc_modify_rport_fpin_state()
Date: Thu, 25 Sep 2025 20:01:55 -0400
Message-ID: <20250926000200.837025-7-jmeneghi@redhat.com>
In-Reply-To: <20250926000200.837025-1-jmeneghi@redhat.com>
References: <20250926000200.837025-1-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250925_170235_987450_DED5D9AE 
X-CRM114-Status: GOOD (  13.62  )
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

Add nvme_fc_modify_rport_fpin_state() and supporting functions. This
function is called by the SCSI FC transport and driver layer to set or
clear the 'marginal' path status for a specific rport.

Co-developed-by: Hannes Reinecke <hare@kernel.org>
Signed-off-by: Hannes Reinecke <hare@kernel.org>
Tested-by: Bryan Gurney <bgurney@redhat.com>
Signed-off-by: John Meneghini <jmeneghi@redhat.com>
---
 drivers/nvme/host/fc.c         | 76 ++++++++++++++++++++++++++++++++++
 include/linux/nvme-fc-driver.h |  2 +
 2 files changed, 78 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 5091927c2176..87bfe34b4d52 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3730,6 +3730,82 @@ static struct nvmf_transport_ops nvme_fc_transport = {
 	.create_ctrl	= nvme_fc_create_ctrl,
 };
 
+static struct nvme_fc_rport *nvme_fc_rport_from_wwpn(struct nvme_fc_lport *lport,
+		u64 rport_wwpn)
+{
+	struct nvme_fc_rport *rport;
+	unsigned long flags;
+
+	spin_lock_irqsave(&nvme_fc_lock, flags);
+	list_for_each_entry(rport, &lport->endp_list, endp_list) {
+		if (!nvme_fc_rport_get(rport))
+			continue;
+		if (rport->remoteport.port_name == rport_wwpn &&
+		    rport->remoteport.port_role & FC_PORT_ROLE_NVME_TARGET) {
+			spin_unlock_irqrestore(&nvme_fc_lock, flags);
+			return rport;
+		}
+		nvme_fc_rport_put(rport);
+	}
+	spin_unlock_irqrestore(&nvme_fc_lock, flags);
+	return NULL;
+}
+
+static struct nvme_fc_lport *
+nvme_fc_lport_from_wwpn(u64 wwpn)
+{
+	struct nvme_fc_lport *lport;
+	unsigned long flags;
+
+	spin_lock_irqsave(&nvme_fc_lock, flags);
+	list_for_each_entry(lport, &nvme_fc_lport_list, port_list) {
+		if (lport->localport.port_name == wwpn &&
+		    lport->localport.port_state == FC_OBJSTATE_ONLINE) {
+			if (nvme_fc_lport_get(lport)) {
+				spin_unlock_irqrestore(&nvme_fc_lock, flags);
+				return lport;
+			}
+		}
+	}
+	spin_unlock_irqrestore(&nvme_fc_lock, flags);
+	return NULL;
+}
+
+static void
+nvme_fc_fpin_set_state(struct nvme_fc_lport *lport, u64 wwpn, bool marginal)
+{
+	struct nvme_fc_rport *rport;
+	struct nvme_fc_ctrl *ctrl;
+
+	rport = nvme_fc_rport_from_wwpn(lport, wwpn);
+	if (!rport)
+		return;
+
+	spin_lock_irq(&rport->lock);
+	list_for_each_entry(ctrl, &rport->ctrl_list, ctrl_list) {
+		if (marginal)
+			set_bit(NVME_CTRL_MARGINAL, &ctrl->ctrl.flags);
+		else
+			clear_bit(NVME_CTRL_MARGINAL, &ctrl->ctrl.flags);
+	}
+	spin_unlock_irq(&rport->lock);
+	nvme_fc_rport_put(rport);
+}
+
+void
+nvme_fc_modify_rport_fpin_state(u64 local_wwpn, u64 remote_wwpn, bool marginal)
+{
+	struct nvme_fc_lport *lport;
+
+	lport = nvme_fc_lport_from_wwpn(local_wwpn);
+	if (!lport)
+		return;
+
+	nvme_fc_fpin_set_state(lport, remote_wwpn, marginal);
+	nvme_fc_lport_put(lport);
+}
+EXPORT_SYMBOL_GPL(nvme_fc_modify_rport_fpin_state);
+
 /* Arbitrary successive failures max. With lots of subsystems could be high */
 #define DISCOVERY_MAX_FAIL	20
 
diff --git a/include/linux/nvme-fc-driver.h b/include/linux/nvme-fc-driver.h
index 9f6acadfe0c8..b026e6312f85 100644
--- a/include/linux/nvme-fc-driver.h
+++ b/include/linux/nvme-fc-driver.h
@@ -536,6 +536,8 @@ void nvme_fc_rescan_remoteport(struct nvme_fc_remote_port *remoteport);
 int nvme_fc_set_remoteport_devloss(struct nvme_fc_remote_port *remoteport,
 			u32 dev_loss_tmo);
 
+void nvme_fc_modify_rport_fpin_state(u64 local_wwpn, u64 remote_wwpn, bool marginal);
+
 /*
  * Routine called to pass a NVME-FC LS request, received by the lldd,
  * to the nvme-fc transport.
-- 
2.51.0


