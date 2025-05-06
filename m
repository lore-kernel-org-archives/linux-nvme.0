Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD91FC3ABC7
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 19:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+UIhTrBO/Tp06kXJNTGYoGqNi8PMv0yucomgql3BQrY=; b=CP8ojZSnnN3xH97SMS6Q8SXMhz
	sBaxg/adwR/hWDfXdV4V7nheJ31CXHyn+bLLj/rpGBV5cLwYjtJjbGUd4M68qjv1gQg44Jz8AmcR2
	Ytbtg2hIwWdGlcPKFgnhoeue4EwM1se9rFCKxzrrLDeFBG21zZvRJuSBgdcuZw747nsA8PrrLN9Qr
	EJLRrHsZt2sR2mps/Kt+K3n3nbN92PelHp8KYrMRi9W09U63xjIjr3x3Sz7B/YvgyOCtlxfmbPS3y
	TQXeIjj/T/JhY76hvfOvGtdQWmkaU5sN+InLv+HS5dSeTFBznlF/LMPNEPb9mDJRwJqA3bQBJTWXN
	QXwSIm+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCOMm-0000000DHMX-2XDG;
	Tue, 06 May 2025 19:54:12 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCKKK-0000000CW5s-2YCK
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 15:35:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id D3D5CA4D5ED;
	Tue,  6 May 2025 15:35:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424BFC4CEEB;
	Tue,  6 May 2025 15:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746545723;
	bh=m38VROMlYenRZOQYcEXXSZPRsOLA4LoZ0zexgEKdFiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=buumZL18pSvtphkQPtFgVEtXHoK2CE25rR8qPDCGC5dpdemNKekiBMaaLUdpWe3Xx
	 VRvEhKRPqJgbyT+vfeXvwh9+paX+WUAsZM78NGwaMBQRVTClcpcdkikaiWBuT+L9ao
	 FUc/oIFwkNR7siIqjUfLKdAdNcMeUNNwfCttq/3DiIJ3/MWdibtpNfqdrHRATzyneC
	 C3NgO6Hb/f6Aa6Lk8vTdcISDBDHnABuG4GX89p+ChxpdUzshR/f+5a1BuxzfWXcUZh
	 WWLp+BpRvM0iPrH7gRtJ4SzI3ucFpJjEQ7FbUtx/4mmBeP4rPnvcGW7+Mx9lxKisDs
	 5SwjZDMz97VOg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 3/5] nvme-fc: nvme_fc_fpin_rcv() callback
Date: Tue,  6 May 2025 17:35:05 +0200
Message-Id: <20250506153507.83094-4-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250506153507.83094-1-hare@kernel.org>
References: <20250506153507.83094-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_083524_792009_6908A19B 
X-CRM114-Status: GOOD (  16.44  )
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

Add a callback nvme_fc_fpin_rcv() to evaluate the FPIN LI TLV
information and set the 'marginal' path status for all affected
rports.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/fc.c         | 95 ++++++++++++++++++++++++++++++++++
 include/linux/nvme-fc-driver.h |  3 ++
 2 files changed, 98 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index df7900885060..475a636d1f7d 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3717,6 +3717,101 @@ static struct nvmf_transport_ops nvme_fc_transport = {
 	.create_ctrl	= nvme_fc_create_ctrl,
 };
 
+static struct nvme_fc_rport *nvme_fc_rport_from_wwpn(struct nvme_fc_lport *lport,
+		u64 rport_wwpn)
+{
+	struct nvme_fc_rport *rport;
+
+	list_for_each_entry(rport, &lport->endp_list, endp_list) {
+		if (!nvme_fc_rport_get(rport))
+			continue;
+		if (rport->remoteport.port_name == rport_wwpn &&
+		    rport->remoteport.port_role & FC_PORT_ROLE_NVME_TARGET)
+			return rport;
+		nvme_fc_rport_put(rport);
+	}
+	return NULL;
+}
+
+static void
+nvme_fc_fpin_li_lport_update(struct nvme_fc_lport *lport, struct fc_fn_li_desc *li)
+{
+	unsigned int i, pname_count = be32_to_cpu(li->pname_count);
+	u64 attached_wwpn = be64_to_cpu(li->attached_wwpn);
+	struct nvme_fc_rport *attached_rport;
+
+	for (i = 0; i < pname_count; i++) {
+		struct nvme_fc_rport *rport;
+		u64 wwpn = be64_to_cpu(li->pname_list[i]);
+
+		rport = nvme_fc_rport_from_wwpn(lport, wwpn);
+		if (!rport)
+			continue;
+		if (wwpn != attached_wwpn) {
+			struct nvme_fc_ctrl *ctrl;
+
+			spin_lock_irq(&rport->lock);
+			list_for_each_entry(ctrl, &rport->ctrl_list, ctrl_list)
+				set_bit(NVME_CTRL_MARGINAL, &ctrl->ctrl.flags);
+			spin_unlock_irq(&rport->lock);
+		}
+		nvme_fc_rport_put(rport);
+	}
+
+	attached_rport = nvme_fc_rport_from_wwpn(lport, attached_wwpn);
+	if (attached_rport) {
+		struct nvme_fc_ctrl *ctrl;
+
+		spin_lock_irq(&attached_rport->lock);
+		list_for_each_entry(ctrl, &attached_rport->ctrl_list, ctrl_list)
+			set_bit(NVME_CTRL_MARGINAL, &ctrl->ctrl.flags);
+		spin_unlock_irq(&attached_rport->lock);
+		nvme_fc_rport_put(attached_rport);
+	}
+}
+
+/**
+ * fc_host_fpin_rcv() - Process a received FPIN.
+ * @localport:		local port the FPIN was received on
+ * @fpin_len:		length of FPIN payload, in bytes
+ * @fpin_buf:		pointer to FPIN payload
+ * Notes:
+ *	This routine assumes no locks are held on entry.
+ */
+void
+nvme_fc_fpin_rcv(struct nvme_fc_local_port *localport,
+		 u32 fpin_len, char *fpin_buf)
+{
+	struct nvme_fc_lport *lport;
+	struct fc_els_fpin *fpin = (struct fc_els_fpin *)fpin_buf;
+	union fc_tlv_desc *tlv;
+	u32 bytes_remain;
+	u32 dtag;
+
+	if (!localport)
+		return;
+	lport = localport_to_lport(localport);
+	tlv = &fpin->fpin_desc[0];
+	bytes_remain = fpin_len - offsetof(struct fc_els_fpin, fpin_desc);
+	bytes_remain = min_t(u32, bytes_remain, be32_to_cpu(fpin->desc_len));
+
+	while (bytes_remain >= FC_TLV_DESC_HDR_SZ &&
+	       bytes_remain >= FC_TLV_DESC_SZ_FROM_LENGTH(tlv)) {
+		dtag = be32_to_cpu(tlv->hdr.desc_tag);
+		switch (dtag) {
+		case ELS_DTAG_LNK_INTEGRITY:
+			nvme_fc_fpin_li_lport_update(lport, &tlv->li);
+			break;
+		default:
+			break;
+		}
+
+		bytes_remain -= FC_TLV_DESC_SZ_FROM_LENGTH(tlv);
+		tlv = fc_tlv_next_desc(tlv);
+	}
+}
+EXPORT_SYMBOL(nvme_fc_fpin_rcv);
+
 /* Arbitrary successive failures max. With lots of subsystems could be high */
 #define DISCOVERY_MAX_FAIL	20
 
diff --git a/include/linux/nvme-fc-driver.h b/include/linux/nvme-fc-driver.h
index 9f6acadfe0c8..bcd3b1e5a256 100644
--- a/include/linux/nvme-fc-driver.h
+++ b/include/linux/nvme-fc-driver.h
@@ -536,6 +536,9 @@ void nvme_fc_rescan_remoteport(struct nvme_fc_remote_port *remoteport);
 int nvme_fc_set_remoteport_devloss(struct nvme_fc_remote_port *remoteport,
 			u32 dev_loss_tmo);
 
+void nvme_fc_fpin_rcv(struct nvme_fc_local_port *localport,
+		      u32 fpin_len, char *fpin_buf);
+
 /*
  * Routine called to pass a NVME-FC LS request, received by the lldd,
  * to the nvme-fc transport.
-- 
2.35.3


