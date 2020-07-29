Return-Path: <SRS0=jy92=BI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313CCC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 19:10:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 078542075D
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 19:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YN/Qdffa";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="coWKfw7k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 078542075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-Id:Date:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vOvFuHai6/fDvdmIlcBpFnDTbPty3D0dM9PHmkhcoFo=; b=YN/Qdffa63zAOBm+x98unYGc0G
	WGD64RMSo8od+lg/XB5OjpTRBXH+bnd4zv+L06At6mlVQKc158OWjHsmrmdi5s17Gff/TS6V5gYOC
	g7R8GEwHDA1+CDO03G64VihDrEfN48Yn/zum54NNUFXXcJ6/QdBFUw4eJF8fK4YJEIDzU0MlbSQRh
	a1+Ptpa9E7Zt9UyxZYx1BWMQ6B6LmC8u3wJaZzLAWIh379MPRx8UzLpvOyQLnA3EAXIMEDEXns4Bl
	mcRyUdWFXEJDauGJG4sA7/Ezo1XYdEmuEPIav7bgt6YEQmaUCrgFHHdVXM4GVj3i92vVqE/QAH993
	qHoYwVAw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0rT5-0003w0-E2; Wed, 29 Jul 2020 19:10:23 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0rT3-0003uO-EF
 for linux-nvme@lists.infradead.org; Wed, 29 Jul 2020 19:10:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ytNmU6XECJ6mse7dyEPBYBvTEidvGF6L8NfDouGCEKo=; b=coWKfw7kgDX6kPpKypL29C8i6c
 2UjCxfqsiR6FV8nDg6idbi7pN84McLwfQFl6SPR6ihkO7AGoiosPTcetEGznhcvc7eB+yP/VZU9TW
 gDRGwiioVibCBct9ai45bsHWxT77Bsx4fBZ5ZYKZmwzJva1pOffp1X2wY0WrX2tNzaQDHqDVLY8be
 fILaR3F8/UFrkDNddHzsIf3dtDF863P+5iIpKBABTygGcYhu1+5ZcRceDSEET3LIeqWs1u+nl9t6j
 cR4J8t1hSdW3dxBV1Y0d3TzaI5m5x7TH4LsV8ghmc8BxNYdzR31VwpAvHqo9mXHmV3SXXIZdYA0/W
 4NQloHhw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1k0rSz-0007XN-DQ; Wed, 29 Jul 2020 13:10:18 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1k0rSt-0001B4-12; Wed, 29 Jul 2020 13:10:11 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Date: Wed, 29 Jul 2020 13:10:09 -0600
Message-Id: <20200729191009.4485-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 hch@lst.de, sagi@grimberg.me, kbusch@kernel.org, axboe@fb.com,
 Chaitanya.Kulkarni@wdc.com, maxg@mellanox.com, sbates@raithlin.com,
 logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH] nvmet-passthru: Reject commands with non-sgl flags set
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200729_151021_519427_8DB882CD 
X-CRM114-Status: GOOD (  12.26  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>,
 Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Any command with a non-SGL flag set (like fuse flags) should be
rejected.

Fixes: c1fef73f793b ("nvmet: add passthru code to process commands")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---

Note: this patch may be squashed with the patch noted in the fixes
tag, currently in nvme-5.9.

 drivers/nvme/target/passthru.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 89d91dc999a6..f69c3ac82e58 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -326,6 +326,10 @@ static u16 nvmet_setup_passthru_command(struct nvmet_req *req)

 u16 nvmet_parse_passthru_io_cmd(struct nvmet_req *req)
 {
+	/* Reject any commands with non-sgl flags set (ie. fused commands) */
+	if (req->cmd->common.flags & ~NVME_CMD_SGL_ALL)
+		return NVME_SC_INVALID_FIELD;
+
 	switch (req->cmd->common.opcode) {
 	case nvme_cmd_resv_register:
 	case nvme_cmd_resv_report:
@@ -396,6 +400,10 @@ static u16 nvmet_passthru_get_set_features(struct nvmet_req *req)

 u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
 {
+	/* Reject any commands with non-sgl flags set (ie. fused commands) */
+	if (req->cmd->common.flags & ~NVME_CMD_SGL_ALL)
+		return NVME_SC_INVALID_FIELD;
+
 	/*
 	 * Passthru all vendor specific commands
 	 */

base-commit: b6cec06d19d90db5dbcc50034fb33983f6259b8b
--
2.20.1

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
