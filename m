Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC23CD11DD
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Mar 2024 12:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I4v29aKMMgooEUFreswbP0jPD0lEYdMgfPb+VPT0b7A=; b=qUv6D3vguz9pkdBFOdPETH8BcV
	4q5mqRV3GyTS2as2bi4YRMOvg/f8ky4s3zZm7vySoBI8JMV0hHyJgAuiYZw2Dk/qAfloGOk6+EOng
	ACO6BJgHY/cmw7gy0A2cU5xXHqLrpuxcfSuceA+tE4krTOFsT5TegZuKrgxcfqEnIJIBZTMHc6BZ6
	9nwGJAsN4r7OiHypP2dGTnCQ0fctNfo/XaTTi92lJSNy9kzeYN85LwFUjmImO33jMshYdoAbg7M7w
	FwDTAZ88WVGHQr4HWqDBU0/FfgKhC+5snDgrXYTD+5vUubI9p4kycztHF/l4Na3FyA+6pU63rewn1
	aZiRknfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp5XO-00000004Nhf-2Fi8;
	Tue, 26 Mar 2024 12:04:18 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp5XB-00000004NXI-1Yia
	for linux-nvme@lists.infradead.org;
	Tue, 26 Mar 2024 12:04:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4984760D2F;
	Tue, 26 Mar 2024 12:04:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2CCAC433C7;
	Tue, 26 Mar 2024 12:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711454644;
	bh=PEWaThEupxgYHKtsY6bAZlncKC1OCnp3PXDkPVcwYFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cMSw8N4FAZ8Jxn8FZT7hJ153tTLro9AZMlXD2h9AFicLrLGs1DbDUGqPaNm4KMjAe
	 sVylOKtQJymhlAm0MpdCoGvS2pvlyZM0QEvqQsfPqPF3ErSWhB22XkZPDOHaFDupNV
	 +UbRcQ0a6n5nTFAumiHDb684xCJzU48eR7Wtuk2ljN0uX3hZrtGmdRkbT9tPHDhDqQ
	 JR4knFLFliv9TqvRPrC5PNeayz+4Y1zC/SOIMq1DVbFpq/B+NvNA/De+R0TfKz5e+p
	 SIoRNYIqoHdxiXYJdScbWtzV61I2T072qeRGm/1laQaHefYeHitUiN7f/43BIDvKz5
	 Z9vGP4akN5x7g==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 7/7] lpfc_nvmet: implement 'host_traddr'
Date: Tue, 26 Mar 2024 13:03:42 +0100
Message-Id: <20240326120342.105740-8-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240326120342.105740-1-hare@kernel.org>
References: <20240326120342.105740-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_050405_770720_8BE8FC6A 
X-CRM114-Status: UNSURE (   9.87  )
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

Implement the 'host_traddr' callback to display the host transport
address for nvmet debugfs.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/scsi/lpfc/lpfc_nvmet.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index 425328d9c2d8..a315ab03f721 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -1363,6 +1363,16 @@ lpfc_nvmet_ls_abort(struct nvmet_fc_target_port *targetport,
 		atomic_inc(&lpfc_nvmet->xmt_ls_abort);
 }
 
+static int
+lpfc_nvmet_host_traddr(void *hosthandle, u64 *wwnn, u64 *wwpn)
+{
+	struct lpfc_nodelist *ndlp = hosthandle;
+
+	*wwnn = wwn_to_u64(ndlp->nlp_nodename.u.wwn);
+	*wwpn = wwn_to_u64(ndlp->nlp_portname.u.wwn);
+	return 0;
+}
+
 static void
 lpfc_nvmet_host_release(void *hosthandle)
 {
@@ -1413,6 +1423,7 @@ static struct nvmet_fc_target_template lpfc_tgttemplate = {
 	.ls_req         = lpfc_nvmet_ls_req,
 	.ls_abort       = lpfc_nvmet_ls_abort,
 	.host_release   = lpfc_nvmet_host_release,
+	.host_traddr    = lpfc_nvmet_host_traddr,
 
 	.max_hw_queues  = 1,
 	.max_sgl_segments = LPFC_NVMET_DEFAULT_SEGS,
-- 
2.35.3


