Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42FB5C54E71
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Mar 2024 07:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I4v29aKMMgooEUFreswbP0jPD0lEYdMgfPb+VPT0b7A=; b=kNRFQxLfhAi/CmpCi5nirKodyf
	6Qm+bCHZw2UpxUlTu5T3NQm8aLnB1RwTHmesB/oM26Cp7IzyshiZTI5ATXkfaQVvcl7MbCgNAVXGy
	tYVJEKitoZnb66JrO1GrhwfDj5ojL7Z9duRzIjEbpH/hZOfZU6TzoS1306TehPyKLABkaO9ZA5GW3
	QHNio2BkY0ubKxN+QCwgAqTPUsrJBAWf3+QxMVo6RF6FOyVPv6cj7Z7kmRhe//fbkg+jTNRJxxT8B
	p0qGghbYVGIzZYm67myxVVV9ybAn2lttMDWQTjXAKnL3kV0nEzuyPf5Pn7b892Hg0fLBBKR3CofMf
	HB4A5Wig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnYwe-000000067d3-0gv9;
	Fri, 22 Mar 2024 07:04:04 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnYwR-000000067SU-37sy
	for linux-nvme@lists.infradead.org;
	Fri, 22 Mar 2024 07:03:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D1B2C61363;
	Fri, 22 Mar 2024 07:03:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417BFC433A6;
	Fri, 22 Mar 2024 07:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711091030;
	bh=PEWaThEupxgYHKtsY6bAZlncKC1OCnp3PXDkPVcwYFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eRNv71XX09I7qrxWS+0bI0MTWM8qiEo1njQ15YLPABmEAIdHOcFCbqEFr5fQOkQ1L
	 yJ8fI4uCZMoeUj9iUKLYaSk4Xiw3e9OWFgPBuQ9Q/AdNLdF/0Krpyv4ELH4aytsxPo
	 eYb8HDE/djse3Ts5k+K3xiTjJfzeD6Rq/zBU/M4cy0ZUUDyy0LFae3uR7dN7wkMyL6
	 IFwmUvsx8IITq7r40h5EMU0Z/6D5pssbuDtz4lBDXBzyHlbj5zxNf11n6zlrsYuKQh
	 Kuh6LLFeWppsgwp184dUNWjbw03x8z1hR5gyaMiKrEZ7r8vE+RmcSIDD5Y780vLQuw
	 TY/WDuM2VWmlw==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 7/8] lpfc_nvmet: implement 'host_traddr'
Date: Fri, 22 Mar 2024 08:03:32 +0100
Message-Id: <20240322070333.3820-8-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240322070333.3820-1-hare@kernel.org>
References: <20240322070333.3820-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240322_000352_020081_BFAEC894 
X-CRM114-Status: GOOD (  10.53  )
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


