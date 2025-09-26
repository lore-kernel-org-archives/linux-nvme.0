Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A64CAC5B5
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Sep 2025 00:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ws26F9biBfjuf7lTm2SRTxzsPRrWTjIZqRfSJ7Y8Itk=; b=pKoa2BX2n8QjFSGc9i+H5fQq71
	Yz2d85mNZOmrU5h240fNfI92tQ4XfwMaC5ShGFCzWfqsP4KPw+jbvzYCDqJXeX5Z08/N2s9lx7mbZ
	IVKHdDO0Hlk0NB4ccX7Wu78Qcwhm3H7Wr2XLAPFqlUIxDhpUFMTKUaH69f/cUnSx2MjPv5GE2BphD
	twegsNLK/CsYINdgSBTn0KSgRmr81h955GvmBRiqYRXN2Mz94FH7AU1GH5wseGOfB2JtEmNCtF3XV
	ZjIVpa39ccPNyzjv3RZxI4PEDAgCcDRLSnZ8qvPdU1xBMH/OX3bK4gECOhFNc/8PinmsVcOEHPD9D
	CdibVFWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1vus-0000000EAcI-206E;
	Fri, 26 Sep 2025 00:02:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1vuq-0000000EAax-0JJu
	for linux-nvme@lists.infradead.org;
	Fri, 26 Sep 2025 00:02:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758844943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ws26F9biBfjuf7lTm2SRTxzsPRrWTjIZqRfSJ7Y8Itk=;
	b=caoOivsNQ8jw0lKAfjOvYDtCBRMHMosZquCt+opBH9nEYlwaug/sqRcsvIrGYO6KWjgIhM
	FtazCmJ+Hj/s5B7nPm13C4CpwKJYvCYIXDbjIf/eh4Gv67poXSzcN98BKGYtqIMeZh/xAx
	B7QrQEBWnD4UKM9vZ9VkK0lRLUgyhN8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-d_XrHAsvPSmTvLZqE5fu6Q-1; Thu,
 25 Sep 2025 20:02:16 -0400
X-MC-Unique: d_XrHAsvPSmTvLZqE5fu6Q-1
X-Mimecast-MFC-AGG-ID: d_XrHAsvPSmTvLZqE5fu6Q_1758844934
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C26C1956095;
	Fri, 26 Sep 2025 00:02:14 +0000 (UTC)
Received: from jmeneghi-thinkpadp1gen7.rmtusnh.csb (unknown [10.22.81.200])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C4824180035E;
	Fri, 26 Sep 2025 00:02:10 +0000 (UTC)
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
Subject: [PATCH v10 02/11] nvme: add NVME_CTRL_MARGINAL flag
Date: Thu, 25 Sep 2025 20:01:51 -0400
Message-ID: <20250926000200.837025-3-jmeneghi@redhat.com>
In-Reply-To: <20250926000200.837025-1-jmeneghi@redhat.com>
References: <20250926000200.837025-1-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250925_170224_186777_07064AF9 
X-CRM114-Status: UNSURE (   9.84  )
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

From: Bryan Gurney <bgurney@redhat.com>

Add a new controller flag, NVME_CTRL_MARGINAL, to help multipath I/O
policies to react to a path that is set to a "marginal" state.

The flag is cleared on controller reset, which is often the case when
faulty cabling or transceiver hardware is replaced.

Signed-off-by: Bryan Gurney <bgurney@redhat.com>
---
 drivers/nvme/host/core.c | 1 +
 drivers/nvme/host/nvme.h | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index edfe7a267a4b..d505acd0ebf7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5074,6 +5074,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	WRITE_ONCE(ctrl->state, NVME_CTRL_NEW);
 	ctrl->passthru_err_log_enabled = false;
 	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
+	clear_bit(NVME_CTRL_MARGINAL, &ctrl->flags);
 	spin_lock_init(&ctrl->lock);
 	mutex_init(&ctrl->namespaces_lock);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index cfd2b5b90b91..d71e6668f11c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -275,6 +275,7 @@ enum nvme_ctrl_flags {
 	NVME_CTRL_SKIP_ID_CNS_CS	= 4,
 	NVME_CTRL_DIRTY_CAPABILITY	= 5,
 	NVME_CTRL_FROZEN		= 6,
+	NVME_CTRL_MARGINAL		= 7,
 };
 
 struct nvme_ctrl {
@@ -417,6 +418,11 @@ static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
 	return READ_ONCE(ctrl->state);
 }
 
+static inline bool nvme_ctrl_is_marginal(struct nvme_ctrl *ctrl)
+{
+	return test_bit(NVME_CTRL_MARGINAL, &ctrl->flags);
+}
+
 enum nvme_iopolicy {
 	NVME_IOPOLICY_NUMA,
 	NVME_IOPOLICY_RR,
-- 
2.51.0


