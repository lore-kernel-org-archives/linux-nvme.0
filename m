Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B84D7C5B572
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2026 18:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bZZCou7soQ7pIrWDtdlJ11V2SfEEEN4ySA1ofNj1hNQ=; b=Zj0hykn2c+6wRB8r1I3LI94n7f
	7jl84z2MVA4AQJ0eTgxfwk82x7x2iMVzq5FuG9uFqljan2WnRWgNpmT/3Six8b6PvhhD/mRGNWqjB
	DvkvVb+yq9ieuIK2EV42CPxXGn4420ufZP9xEidH9N32+szJZxfNaIYtxrmnPJTbaDIDWl1m5qIVe
	VeCknnrPRpnUUIXGqKlKCYQ6t10fH8JMYeeBULuDDJGQZFqTX6sZWT/DZkvPSEZ8EzPlt87L4nB7z
	o4zD+/RYigIJgq2hWD+5gcP/aLK29iqNo/8rwIevR1nFlRR1Na/M6LTZuP1tvq+D+NjCYJMqyx5TP
	CyhxZu1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuDT7-0000000GlKC-0Ayw;
	Wed, 12 Aug 2026 18:14:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuDT3-0000000GlHP-1yXG
	for linux-nvme@lists.infradead.org;
	Wed, 12 Aug 2026 18:14:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786558460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bZZCou7soQ7pIrWDtdlJ11V2SfEEEN4ySA1ofNj1hNQ=;
	b=fTl6AeZ1cTVHqUo63kYugJSNvKkBY5EMxwTO3p5Uzw4FnvBVwCnkelcNqdfLp5Z7dEnuUp
	Bnd6hiY2z6Mz/Dd8xduVD+SGt6urweoX2o9DZNky0WPm0dQ9rg24OXNfy505bwUDT2HEH7
	2NGFX4LXGv+AafwdXrj4vlEriJCh4eI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-yAMZESISO2Ks1x7xS93MgQ-1; Wed,
 12 Aug 2026 14:14:09 -0400
X-MC-Unique: yAMZESISO2Ks1x7xS93MgQ-1
X-Mimecast-MFC-AGG-ID: yAMZESISO2Ks1x7xS93MgQ_1786558442
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 22DBE195605E;
	Wed, 12 Aug 2026 18:14:02 +0000 (UTC)
Received: from jtaubepe-thinkpadx1carbongen12.ibmlowe.csb (unknown [10.22.88.181])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 724E9180034F;
	Wed, 12 Aug 2026 18:13:57 +0000 (UTC)
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
	linux-block@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 09/13] nvme-fc: add nvme_fc_set_remoteport_fpin()
Date: Wed, 12 Aug 2026 14:12:56 -0400
Message-ID: <20260812181300.3712426-10-jtaubepe@redhat.com>
In-Reply-To: <20260812181300.3712426-1-jtaubepe@redhat.com>
References: <20260812181300.3712426-1-jtaubepe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: nnC8WrAefLjk20qCqdHiB-HPEXOk2nirrIcm0cVjCig_1786558442
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_111421_589285_18D7C8AA 
X-CRM114-Status: GOOD (  13.59  )
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
V10 -> V11:
 - Remove nvme_fc_modify_rport_fpin_state
 - Use struct nvme_fc_remote_port instead of wwpn and wwnn
---
 drivers/nvme/host/fc.c         | 16 ++++++++++++++++
 include/linux/nvme-fc-driver.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index d2ca65f70a0c..4acf23ea8aea 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -895,6 +895,22 @@ nvme_fc_set_remoteport_devloss(struct nvme_fc_remote_port *portptr,
 }
 EXPORT_SYMBOL_GPL(nvme_fc_set_remoteport_devloss);
 
+void
+nvme_fc_set_remoteport_fpin(struct nvme_fc_remote_port *portptr, bool marginal)
+{
+	struct nvme_fc_rport *rport = remoteport_to_rport(portptr);
+	struct nvme_fc_ctrl *ctrl;
+
+	spin_lock_irq(&rport->lock);
+	list_for_each_entry(ctrl, &rport->ctrl_list, ctrl_list) {
+		if (marginal)
+			set_bit(NVME_CTRL_MARGINAL, &ctrl->ctrl.flags);
+		else
+			clear_bit(NVME_CTRL_MARGINAL, &ctrl->ctrl.flags);
+	}
+	spin_unlock_irq(&rport->lock);
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
2.54.0


