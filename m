Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98899C2BD09
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jun 2024 16:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rjrKlExd4divXvAAaer3HfpSdM6ai62oPvCZVb2bC30=; b=24K2FNm6CM/GEiPYCEBdU02KLV
	T17BS4gLQH7ZvKviB3B3+uojM9u87n+047Wc8rVOlunMrcOpwb880pksQ8GnJhNmYgkfqGWv3xEsF
	pZlxZFwEmKwwjkD8QgqI4hR0zlQiBw1J3WNdNYGCgG6sUQk6FGnVLiBPJKg+r2Fkqn4BWuiwDqslU
	KsPG62Z6qmqIEVmA3XNFDHa+QcbhGFE1Sitjl+L5J2U4ON7k9VE01Lvu49N6/IdSC3Rpjm1T+kZPu
	LlMQ5iaVNhroE0uoXHGinriUk7e9n8GW3utEcg1z7tKncgVFxGUVGfisa6zZNlV2cKAtaw8sZL47h
	i1boQ/qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLmFO-0000000HQXy-0aWx;
	Mon, 24 Jun 2024 16:08:50 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLmFL-0000000HQRV-0ZtJ
	for linux-nvme@lists.infradead.org;
	Mon, 24 Jun 2024 16:08:49 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OERjZD021260
	for <linux-nvme@lists.infradead.org>; Mon, 24 Jun 2024 09:08:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=s2048-2021-q4; bh=rjr
	KlExd4divXvAAaer3HfpSdM6ai62oPvCZVb2bC30=; b=XqOvcFdiPl8CmGGx3Xm
	MZVzedARAeiFbgFdPm5Ghc9AuDVARWUxKRaiiYHhFEQhHGHYkPoKDqn1qv4A5dDN
	IJ5SaFI0cOkFwqkG+uie5hHwU7peMROeS5Az9aUQac4dUx6JMzNwv75iXyV1sgzp
	2VaRjSrP4AioiPgNeL17y1ffaXYTm/hNMEAKP8Et+wYhqC9m5jwViXyM78FB0mZj
	E6dnvIj+8AfxvNlusyBv0trNj3chxCpznyfxSQSfgDBeyPHkBol+h59G48Ylb2AF
	dcpwWpiiZAcBxVpsvyy6+dAJL3hdkQHVgdgP2vEzVmX+RLmDud6l2+nMim1i/LPt
	6ig==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3yy60ht4rc-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 24 Jun 2024 09:08:03 -0700 (PDT)
Received: from twshared12618.05.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Mon, 24 Jun 2024 16:08:02 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 013FAFD055A6; Mon, 24 Jun 2024 09:07:56 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <hch@lst.de>, <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
CC: Keith Busch <kbusch@kernel.org>, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH] nvme-pci: let platform handle subsystem reset fallout
Date: Mon, 24 Jun 2024 09:07:56 -0700
Message-ID: <20240624160756.1978565-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: AUmQWjVf0mqskcGLzhxpjHZKurxdWGez
X-Proofpoint-ORIG-GUID: AUmQWjVf0mqskcGLzhxpjHZKurxdWGez
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_13,2024-06-24_01,2024-05-17_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240624_090847_391846_4DEC0F59 
X-CRM114-Status: GOOD (  17.12  )
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

From: Keith Busch <kbusch@kernel.org>

Scheduling reset_work after a nvme subsystem reset is expected to fail,
but this also prevents potential handling the platform may provide from
successfully recovering the link without re-enumeration. Provide a pci
specific operation that safely initiates a subsystem reset, and instead
of scheduling reset work, read back the status register to trigger a
pcie read error.

Reported-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/nvme.h |  3 +++
 drivers/nvme/host/pci.c  | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 68b400f9c42d5..f581cb61a34d2 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -551,6 +551,7 @@ struct nvme_ctrl_ops {
 	int (*reg_read64)(struct nvme_ctrl *ctrl, u32 off, u64 *val);
 	void (*free_ctrl)(struct nvme_ctrl *ctrl);
 	void (*submit_async_event)(struct nvme_ctrl *ctrl);
+	int (*subsystem_reset)(struct nvme_ctrl *ctrl);
 	void (*delete_ctrl)(struct nvme_ctrl *ctrl);
 	void (*stop_ctrl)(struct nvme_ctrl *ctrl);
 	int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
@@ -653,6 +654,8 @@ static inline int nvme_reset_subsystem(struct nvme_ct=
rl *ctrl)
=20
 	if (!ctrl->subsystem)
 		return -ENOTTY;
+	if (ctrl->ops->subsystem_reset)
+		return ctrl->ops->subsystem_reset(ctrl);
 	if (!nvme_wait_reset(ctrl))
 		return -EBUSY;
=20
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 102a9fb0c65ff..4465e06c5583b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1143,6 +1143,37 @@ static void nvme_pci_submit_async_event(struct nvm=
e_ctrl *ctrl)
 	spin_unlock(&nvmeq->sq_lock);
 }
=20
+static int nvme_pci_subsystem_reset(struct nvme_ctrl *ctrl)
+{
+	struct nvme_dev *dev =3D to_nvme_dev(ctrl);
+	int ret =3D 0;
+
+	/*
+	 * Taking the shutdown_lock ensures the iomap is not being altered by
+	 * reset_work. Holding this lock before the RESETTING state change, if
+	 * successful, also ensures nvme_remove won't be able to proceed to
+	 * iounmap until we're done.
+	 */
+	mutex_lock(&dev->shutdown_lock);
+	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING)) {
+		ret =3D -EBUSY;
+		goto unlock;
+	}
+
+	if (!dev->bar_mapped_size) {
+		ret =3D -ENODEV;
+		goto unlock;
+	}
+
+	writel(0x4E564D65, dev->bar + NVME_REG_NSSR);
+
+	/* Read back to trigger platform error handling, if any */
+	readl(dev->bar + NVME_REG_CSTS);
+unlock:
+	mutex_unlock(&dev->shutdown_lock);
+	return ret;
+}
+
 static int adapter_delete_queue(struct nvme_dev *dev, u8 opcode, u16 id)
 {
 	struct nvme_command c =3D { };
@@ -2859,6 +2890,7 @@ static const struct nvme_ctrl_ops nvme_pci_ctrl_ops=
 =3D {
 	.reg_read64		=3D nvme_pci_reg_read64,
 	.free_ctrl		=3D nvme_pci_free_ctrl,
 	.submit_async_event	=3D nvme_pci_submit_async_event,
+	.subsystem_reset	=3D nvme_pci_subsystem_reset,
 	.get_address		=3D nvme_pci_get_address,
 	.print_device_info	=3D nvme_pci_print_device_info,
 	.supports_pci_p2pdma	=3D nvme_pci_supports_pci_p2pdma,
--=20
2.43.0


