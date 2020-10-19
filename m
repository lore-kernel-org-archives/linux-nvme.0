Return-Path: <SRS0=Xx51=D2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0D5C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2020 22:04:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F365A2237B
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2020 22:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tO2LemG4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="HlysC5d/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F365A2237B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-Id:Date:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=E7uVf3LIgTiAO1b8MEiAtxzsAhE0kQR/s1xTFhn4+8E=; b=tO2LemG4dHMCuVE1e8tPN+iie8
	8FjPVGK0ntYy+88CdWyGX2ijWPPsx8Q2sBaTb1xM5SnRsCiqi/G0QruT+nB9CeNBuirBXUaPp+MHn
	hsiso57Qm9F5qZE/DOmvVzzUPXNNem8QMtZStIzDBbAp8Oyw+o0fnCRMZ5KlPeBmESJjt1Pck+hfG
	AzXK1amOsjNvMjoZboMcKLddYjBVGAivhtyOeNrtSGocqnqJE00UFFR3v5UUxemmbRtsbGk6UPjOb
	Dhm1Yq5KSbgBfRN/YssdchQ/3uB9i2KOyfC/2sFlNaclq5sJ3sLIwwFqG9Eb2FP/wxbhFvKeiyErZ
	BxOfpmKA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kUdGQ-0003Eg-Cy; Mon, 19 Oct 2020 22:04:22 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUdGL-0003E0-24
 for linux-nvme@lists.infradead.org; Mon, 19 Oct 2020 22:04:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xiVQsV5x/3Vkr7c2iXAI/AmHUSoDsvYtmOLGl1oS8ek=; b=HlysC5d/oFgR53bl5EAR8KQpdU
 v1He7Fe8YfLQsuepE8ZJcoL3cEPTvxzsuXjWfQ1JPiR30NgkZfPZrFCyWvdEZKPgarXD41GYPYV3z
 KCQ39X4jxddd+K9FBOY1ctmJvE4Hi0ikYXZRTABvhQOEk4F/ymtGuMGj/6rrwsqwp344TRH1G4JtZ
 6t3yGYgo9OAvghHtliN7dRKS4N6nxZtWawzqLJ7y1a29WDxyaTVPU2gbLEMv+Z/OkLliXsnxF3BEw
 bTn/lThuu0hP9Qj7mC6+X5Z5/ZVDKLuACE/i1Ojvju+mk1EQVpNhGjVLl7+v7ieaoJjF/AnfL5rlm
 b5+ISucg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1kUdGH-00063b-KB; Mon, 19 Oct 2020 16:04:15 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1kUdGD-00058d-Na; Mon, 19 Oct 2020 16:04:09 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-nvme@lists.infradead.org
Date: Mon, 19 Oct 2020 16:04:05 -0600
Message-Id: <20201019220406.19708-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, logang@deltatee.com,
 hch@lst.de, sagi@grimberg.me, chaitanya.kulkarni@wdc.com, mgurtovoy@nvidia.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v3 1/2] nvmet-passthru: Limit mdts by BIO_MAX_PAGES
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201019_180417_120186_017FF855 
X-CRM114-Status: GOOD (  15.11  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, Logan Gunthorpe <logang@deltatee.com>,
 Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

nvmet_passthru_map_sg() only supports mapping a single BIO, not a chain
so the effective maximum transfer should also be limitted by BIO_MAX_PAGES
(presently this works out to 1MB).

For PCI passthru devices the max_sectors would typically be more limitting
than BIO_MAX_PAGES, but this may not be true for all passthru devices.

Fixes: c1fef73f793b ("nvmet: add passthru code to process commands")
Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>
---

v3: Added PG_TO_SECTOR constant which uses SECTOR_SHIFT (per Max)

 drivers/nvme/target/passthru.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index dacfa7435d0b..ed6b0586173e 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -22,11 +22,12 @@ static DEFINE_XARRAY(passthru_subsystems);

 static u16 nvmet_passthru_override_id_ctrl(struct nvmet_req *req)
 {
+	const int PG_TO_SECTOR = PAGE_SHIFT - SECTOR_SHIFT;
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvme_ctrl *pctrl = ctrl->subsys->passthru_ctrl;
 	u16 status = NVME_SC_SUCCESS;
 	struct nvme_id_ctrl *id;
-	u32 max_hw_sectors;
+	int max_hw_sectors;
 	int page_shift;

 	id = kzalloc(sizeof(*id), GFP_KERNEL);
@@ -45,9 +46,16 @@ static u16 nvmet_passthru_override_id_ctrl(struct nvmet_req *req)
 	 * which depends on the host's memory fragementation. To solve this,
 	 * ensure mdts is limited to the pages equal to the number of segments.
 	 */
-	max_hw_sectors = min_not_zero(pctrl->max_segments << (PAGE_SHIFT - 9),
+	max_hw_sectors = min_not_zero(pctrl->max_segments << PG_TO_SECTOR,
 				      pctrl->max_hw_sectors);

+	/*
+	 * nvmet_passthru_map_sg is limitted to using a single bio so limit
+	 * the mdts based on BIO_MAX_PAGES as well
+	 */
+	max_hw_sectors = min_not_zero(BIO_MAX_PAGES << PG_TO_SECTOR,
+				      max_hw_sectors);
+
 	page_shift = NVME_CAP_MPSMIN(ctrl->cap) + 12;

 	id->mdts = ilog2(max_hw_sectors) + 9 - page_shift;

base-commit: bbf5c979011a099af5dc76498918ed7df445635b
--
2.20.1

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
