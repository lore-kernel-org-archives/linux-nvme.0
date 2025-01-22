Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D908CC02181
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jan 2025 14:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4T3qMB3p192/9An4EUsb+Y7Fd1CD+APVQ4t+BP4qggc=; b=urKRmK2tQfmPF4hyacq7OadbXU
	hhWwr6ckRR2yG2y/Tt/uRlHiBBUsQeyS0e77YEn98wkaQIK8v1A08ZRCPUTy7QFNFHGDArMjgcQM5
	xE3bpzCEPS1DzAA2wKtatjuBI2Nc+tb8zai2k/LRCRj7MTu/0U3+Jc0UMFDW3yrDKuhDSxAw1vHXC
	oBbln+V7pQzsO5nE3cP+0PFRfCgYKwhrzvoXO+N4bVbLnF9kgGjpmiQwW08G4/6GjF+2yY/OE9tLG
	nlz//nS5QWWuIR6cOFtGASf+3kZriMyS+eejo/bOLVMnwB8U3aNZEMWEf/qpnb9h1ABsiEhsvuO24
	cefl5NyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tac9J-0000000AUi2-0EJm;
	Wed, 22 Jan 2025 14:56:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tac9C-0000000AUgw-3uvw
	for linux-nvme@lists.infradead.org;
	Wed, 22 Jan 2025 14:56:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737557761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4T3qMB3p192/9An4EUsb+Y7Fd1CD+APVQ4t+BP4qggc=;
	b=Xld7OqjB1Pr4fCBMN1KmU2nmqwwLtZWrm3NsW2IHLJXyMLDkmbGrKwRujOwSUy9HtRkeYU
	SA/oMWqF4MpVnZMWipKKc9va8cAhFTUYfBRczlAEd9RVcxrwdUuUTkalv+vF4QBPq4ONkH
	RvdLam1gilU1jSY2+MOCPHaMYz1SBrM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-lu-iapc-NXGD3Dq1XX7vBg-1; Wed,
 22 Jan 2025 09:54:23 -0500
X-MC-Unique: lu-iapc-NXGD3Dq1XX7vBg-1
X-Mimecast-MFC-AGG-ID: lu-iapc-NXGD3Dq1XX7vBg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 27F3B1956051;
	Wed, 22 Jan 2025 14:54:22 +0000 (UTC)
Received: from bgurney-thinkpadp1gen5.remote.csb (unknown [10.22.89.88])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7642119560AA;
	Wed, 22 Jan 2025 14:54:21 +0000 (UTC)
From: Bryan Gurney <bgurney@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de,
	Bryan Gurney <bgurney@redhat.com>
Subject: [PATCH nvme-cli] nvme: set eds to true if controller supports 128 bit hostid
Date: Wed, 22 Jan 2025 09:54:12 -0500
Message-ID: <20250122145412.16709-1-bgurney@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HV7UbuGA8gmSVoVxUsLgR62Gq8ac15FTAvjj9grGMv8_1737557662
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250122_065603_044710_032FC2BF 
X-CRM114-Status: GOOD (  12.98  )
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

A controller that uses a 128-bit Host Identifier may result in the
"nvme resv-report" command failing with a "Host Identifier Inconsistent
Format" error that suggests the "simultaneous use of 64-bit and
128-bit Host Identifier values on different controllers".

This error can be avoided if the "--eds" option is used, to request
the extended data structure.  However, the controller's ctratt
value indicates whether the Host Identifier is 64 bits or 128 bits.
Therefore, check the ctratt flag, and set eds to true if the
controller indicates a 128-bit Host Identifier.

Signed-off-by: Bryan Gurney <bgurney@redhat.com>
---
 nvme.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/nvme.c b/nvme.c
index a65873b2..2ed4ee92 100644
--- a/nvme.c
+++ b/nvme.c
@@ -7740,6 +7740,7 @@ static int resv_report(int argc, char **argv, struct command *cmd, struct plugin
 	const char *eds = "request extended data structure";
 
 	_cleanup_free_ struct nvme_resv_status *status = NULL;
+	_cleanup_free_ struct nvme_id_ctrl *ctrl = NULL;
 	_cleanup_nvme_dev_ struct nvme_dev *dev = NULL;
 	nvme_print_flags_t flags;
 	int err, size;
@@ -7792,6 +7793,19 @@ static int resv_report(int argc, char **argv, struct command *cmd, struct plugin
 
 	size = (cfg.numd + 1) << 2;
 
+	ctrl = nvme_alloc(sizeof(*ctrl));
+	if (!ctrl)
+		return -ENOMEM;
+
+	err = nvme_cli_identify_ctrl(dev, ctrl);
+	if (err) {
+		nvme_show_error("identify-ctrl: %s", nvme_strerror(errno));
+		return -errno;
+	}
+
+	if (ctrl->ctratt & NVME_CTRL_CTRATT_128_ID)
+		cfg.eds = true;
+
 	status = nvme_alloc(size);
 	if (!status)
 		return -ENOMEM;
-- 
2.47.0


