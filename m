Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E272C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 18:56:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2888A20774
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 18:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WWyaCUHp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bO07f0pZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2888A20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Ls/7DUXBFLC6tmmnvUCkjKak+zaGlebF+oKRDFDN8YA=; b=WWyaCUHpah33TFLzJsF6CYwV0
	vTN3Q9V/7rRx8ll9N13gc3IvSHnATz2LxT4Rl3hOcI4RDTxpGvfqIMakcOmtTRB97lZXWb2ma3Lbu
	q3w9PLDqjsAseEBoEw2robVQpPckx/aN48P2O92Ra63KSBjiAjX0f3CZ3hyXxUzRpZEIqdMk1pedU
	A01lJAqhf6gj4S98MATAJHnUoCqy42e8s98IL7DCaX4vBuyMrs69ClbOqNxivY1xXejtA5r3oQXgr
	MBox/OhgKZXuanoR4KW9XU1UlqudDMLZsP5ppmbWMuSJ+xrsl+5JqjbXQIwO5NqVDSK537n5cvZod
	n/JsIRkRw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5Cy7-0007Kz-H6; Mon, 10 Aug 2020 18:56:23 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5Cy4-0007JQ-JP
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 18:56:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597085785; x=1628621785;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JEc2rrJWU3CNzixzZowH6KKuyCOUMHbc11Hx1S5lwFM=;
 b=bO07f0pZNkcq5Evh4l7YHCkMzCT1aGyM4ajihhx5nZa0MgY0x3QM7+P4
 dD+qj/Lj9UnMlNH1SH2jHGC/rZ7Vq+8v7HvK7wJN+oWlkD5HKCx8AE7Jr
 LMPBJKjdwbvLZJj5paTfN11nq1VsdZOshzjXF3QqyTaFq4nO+shac5yFH
 +p63lPsHGAfV0Fy2ilAGdVKiFIsIqZt0IaUNyO8ksH8/TY5hIol0rtl+j
 oY2A64O2Qmp+2/vKrdIJNoru7ORmHfyjLiCWyRSMQ3NH8JmP0GKKU46Z0
 5+Q3fFNVzuBi5yxVJ9qSGZ6IrjvxKu/6cZrybQ49x0TU+ZDgIEdJmCs8N A==;
IronPort-SDR: HczeRSUo1eWcqlkQBWgrE5Qckf+ed2TLM+e5jCtusIZAKfYFqgCkkdgFRrZ/NkD16f7nMXCiMT
 i7SgdSMgdysl7vHgyBTCtXSQDHdwuojTsvnn6K+Lnr/E1k1MUXjGP2Ce71ik5ed4+Jh4alN5Lm
 0K7RlcRUzCj+UoYD5ZaG8LAJqAz6hRVpWbnge9DqIXJ5NIlZMZ0b/Kk/8rc5obDjTQfu9oRPDv
 Y1xOKHV+FezsSctil2ZZnHZ7FZKSspKE320x2WHA8iSCuSY2xFC8z5SmBsY49eSe31wcpdQmtk
 QjY=
X-IronPort-AV: E=Sophos;i="5.75,458,1589212800"; d="scan'208";a="247732533"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2020 02:56:24 +0800
IronPort-SDR: RbFlj1pijk4YLcU+wkE89PbySqhmJmPG3bsxNvxnAg4T2ph4l+gpvohW70gChVLpUjSS9hf0jL
 owZhlmjBVg3g==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2020 11:44:13 -0700
IronPort-SDR: OKj96Y8zgsphiPmzKa9/a7WDudYg8FfMMfg12qVz13uXmoU7vZ6dUTpU7ooE9sfgJMTj1MNDwA
 pyH9ToFsTYAw==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 10 Aug 2020 11:56:20 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 10/14] nvmet: prep patch for pt ctrl put wrapper
Date: Mon, 10 Aug 2020 11:54:52 -0700
Message-Id: <20200810185456.7713-11-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_145620_770809_BF6DADB0 
X-CRM114-Status: GOOD (  13.70  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This is a preparation patch to cnetralize the passthru put controller
action. Next patch actully fixes the bug in passthru code which needs
this helper to avoid the duplication of the code.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/passthru.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index a703f3f14b35..32f4951a1df7 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -486,6 +486,11 @@ u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
 	}
 }
 
+static void nvme_pt_put_ctrl(struct nvme_ctrl *ctrl)
+{
+	nvme_put_ctrl(ctrl);
+}
+
 int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 {
 	struct nvme_ctrl *ctrl;
@@ -536,7 +541,7 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 	return 0;
 
 out_put_ctrl:
-	nvme_put_ctrl(ctrl);
+	nvme_pt_put_ctrl(ctrl);
 out_unlock:
 	mutex_unlock(&subsys->lock);
 	return ret;
@@ -546,7 +551,7 @@ static void __nvmet_passthru_ctrl_disable(struct nvmet_subsys *subsys)
 {
 	if (subsys->passthru_ctrl) {
 		xa_erase(&passthru_subsystems, subsys->passthru_ctrl->cntlid);
-		nvme_put_ctrl(subsys->passthru_ctrl);
+		nvme_pt_put_ctrl(subsys->passthru_ctrl);
 	}
 	subsys->passthru_ctrl = NULL;
 	subsys->ver = NVMET_DEFAULT_VS;
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
