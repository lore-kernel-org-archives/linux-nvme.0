Return-Path: <SRS0=GAdO=CY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2622C43461
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 21:42:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 908F42078E
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 21:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0hhiK5LZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ty77L9mh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 908F42078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OpcAY5dWXm+POIvnFR+xfD5f+PlqyZCWjThwxuRyQzI=; b=0hhiK5LZ5Kodg2pndWeQMIbyr
	zdqApJCfU9bKkQYxvOgMcsh9qOPehnBCciY7+qF0/UJ8ezr1HPqETduFp1g1ILlnG+c6zOaLO1IJ6
	iAr5WjDXZVIc474eS/u/6m+mZ7SOjxC6z8b3jNG1saPkHzRr14OJch/qD2MRkPESa/u0rCRQETuU1
	Uzo/NDsl+EZ9vLQI2mIgMDF7M4ghOBl51KRr1s28NGoMfCaPeOJkmYzQA2rJVhMLyEQ0Yh6Hxar6C
	t+oRocDRHVAZYi9Xa7QfrEZ5ovGvG6CrYdddbfTC01sdYMBYww8v2OlYklP2Q/nKC27L5m9TOKtiH
	6814+EWuA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIIib-0000Wh-54; Tue, 15 Sep 2020 21:42:29 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIIiZ-0000W1-36
 for linux-nvme@lists.infradead.org; Tue, 15 Sep 2020 21:42:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600206147; x=1631742147;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KFXHM4I6gASqr2APPCZY1hAJPu+DP5UuPRpsle6GtC4=;
 b=Ty77L9mhwm0ULivEmAGgzYl2r+j/IXgpxGdGjsFF5gB/AIl7y3dRbj+Y
 20xyMPVFQQJUM/BR1HjRyaLgRGWGeuToVVqdqHts7mSbG+751P4od5v+B
 OBpjlLDNPniEXvG58A2PI8ljUJy3sGuwDoD72l01B+RGisJ2TsbkPLV0p
 amaJVTheYPeU5+NA7O/IqEtZUrC9vsghuJUwApl7ys7jFBUedz6zDlCZG
 On5sL4+iTEFafL3fewdy7glmIyrJ/cLoqxPiFUknHiMc5x2IEazXsbIQa
 MNb95el1SyqH+vZVqMWwBfVjnRxUkHpl/wvfB/Hxdl/D7neeEvcIJQ5vk A==;
IronPort-SDR: fogJUw/W6TAhJ9UiBpI6znDDlKdKNzERY+L721J+8v2wn0B4EpopPvzFY8xmOxtTsmBIG8I0sI
 5rEC3lz9gspgo4rsXyQv6rml6el4JsBtKtx0ShGT8e8mFsmkJmM0Tfvjic8QCK0B0bLPikF9HT
 cmo1O9ti8wwAo3Qx9To75EzjuxxdUv5AyX6CWZ64uElJaS3zHvlIK+6yiKD10en/eFifMirHuG
 Slxdye3nLZ6KYgZAyrd8986IBBCVNl2bMtOVVYWnV1n6USpiClxh38YB3NVhclts7HzRu7Fzqr
 ak0=
X-IronPort-AV: E=Sophos;i="5.76,430,1592841600"; d="scan'208";a="151828286"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2020 05:42:26 +0800
IronPort-SDR: smhAxupPS2GhpTXxbX/W/9eJOQogyG2kwy2iSUU48RNJaWF2N9CAxya7Z2DKeTfhyr1NQNyZDJ
 2CtSr5knjTVA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2020 14:29:35 -0700
IronPort-SDR: ElGC+4BgLo6d/+XoS9ePQRDJMRvE5Yn/l2ZdrxpjC7OYV7B5kuoO0hrMZ2KZQ0ou7V9dvPW99I
 l+s2BbPexQQw==
WDCIronportException: Internal
Received: from zns.labspan.wdc.com (HELO zns.sc.wdc.com) ([10.6.137.48])
 by uls-op-cesaip02.wdc.com with ESMTP; 15 Sep 2020 14:42:25 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [RFC PATCH 1/1] nvmet: add passthru ZNS support
Date: Tue, 15 Sep 2020 14:42:12 -0700
Message-Id: <20200915214212.14868-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200915214212.14868-1-chaitanya.kulkarni@wdc.com>
References: <20200915214212.14868-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200915_174227_301961_2B5C1260 
X-CRM114-Status: GOOD (  11.28  )
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
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de,
 matias.bjorling@wdc.com, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In the default passthru implementation NVMeOF target passthru ctrl is
not capable of handling Zoned Namespaces (ZNS).

Update the nvmet_parse_pasthru_admin_cmd() to allow
NVME_ID_CNS_CS_CTRL/NVME_CIS_ZNS and NVME_ID_CNS_CS_NS/NVME_CIS_ZNS.

With this addition NVMeOF Passthru allows Zoned Namespaces.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/passthru.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 8bd7f656e240..f19fe319ed90 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -456,10 +456,26 @@ u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
 			req->execute = nvmet_passthru_execute_cmd;
 			req->p.use_workqueue = true;
 			return NVME_SC_SUCCESS;
+		case NVME_ID_CNS_CS_CTRL:
+			switch (req->cmd->identify.csi) {
+			case NVME_CSI_ZNS:
+				req->execute = nvmet_passthru_execute_cmd;
+				req->p.use_workqueue = true;
+				return NVME_SC_SUCCESS;
+			}
+			return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 		case NVME_ID_CNS_NS:
 			req->execute = nvmet_passthru_execute_cmd;
 			req->p.use_workqueue = true;
 			return NVME_SC_SUCCESS;
+		case NVME_ID_CNS_CS_NS:
+			switch (req->cmd->identify.csi) {
+			case NVME_CSI_ZNS:
+				req->execute = nvmet_passthru_execute_cmd;
+				req->p.use_workqueue = true;
+				return NVME_SC_SUCCESS;
+			}
+			return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 		default:
 			return nvmet_setup_passthru_command(req);
 		}
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
