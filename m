Return-Path: <SRS0=TApw=HT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AA0C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Feb 2021 00:12:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5689B64DFF
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Feb 2021 00:12:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5689B64DFF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Mm7Uf1UxIag8EpuUqixXlE9XWxRPguu7Gw+uwxuDsck=; b=HL0EgHltlQuUPwAk72wAUVHDt
	QabXizfzJYkbtAA3P24N/dHYtagcVGZYIj/MZUroVyg243gVIklO4sK9My4iH7OTtuEd3lETYiBma
	hXpaiW326cu8Annm1rPRfkjIfyQY2ztAtwCRu9MQvglih0zG3RE1e/dOyUe9sNUO0Atr0ynCrTHEZ
	Y7AN9U/slqi1O/kG1XMip0RqddBRdBmvgQu2L+FbL7NX08zoiwrBY9tuhM+BkVm/BxaDVNvpQ/q4k
	ar7MOp8tLYrmxwwkai4jKAQvF+OmP82lLZVnXZD17H7LGtdKEwmDYHytkK1RL4bx0MRbZRqFPOqKH
	nd1dG1eGg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lCARg-0007v7-5s; Wed, 17 Feb 2021 00:11:56 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCARY-0007rB-MA
 for linux-nvme@lists.infradead.org; Wed, 17 Feb 2021 00:11:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1613520708; x=1645056708;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=296BdbQTDVzcuQpiuiGARqKyLetSS1/HK4UCp4o1i5g=;
 b=QlBCTfToBONT/LecrBHQ4dDI6uCAlJy5Sm5VmzUeqfDGJLiYKufFVrTJ
 HGCxt8YeU2sraDn7+8X6NYd0cyAfJnj73ZXI7KW1YRAdmZKH5L+GKpnCB
 V7sNGR4t3h5zUq5nnwwnR9ttjFb9olsmDt6edoWG4MVm18B5IYpxCqpHx
 adB7nbPjojrsJFGEdi0pGUBe+P6THTK9aRlYg7EAqdCoTSkE5V5I7J+Y2
 uO8uGG3ZNHkA3GGLv486YMsIYZF+o7BoDnmHG8PNB9dpBVY0BzTygHAuF
 K06GBpdsDktwW4xIwTem13GT7n34R1vy37iVR870u8r/vnRvgfnR0u8Eh g==;
IronPort-SDR: RuKIHdoIGAQzE3qyguR0lFyPTjOVB9gwXT078Ve7P+CmX/uYkPkBVDYafP8mIhhh/ac93BZDtu
 hlX3K/O+gfJDsTMntDkWh75LxO4ogGATleMbGl0GXHlci06BmIrv8BsFs/uHcuu/BxAXOygVeO
 fSTYR14k5RnX9TWxKO1OQ87gcRYa9p+19RWttu1WwCIN6A3A/LN21nnOaLRJFbfolWA4L8JBQX
 0sGdhmAFPA0GezSNR1E6NiFT1K56N6MHdv1oLtWSF5Fq3FpLmQO/H0NW+E7JIYBN3MyMcHtxpE
 ODQ=
X-IronPort-AV: E=Sophos;i="5.81,184,1610380800"; d="scan'208";a="164590074"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2021 08:11:46 +0800
IronPort-SDR: PryVGSddMBzRFlyN0KjbpH+aWisOiXefLW6xjoNCQcPHZr5nuEeVgb2EiRIHSzq7xY+AWCi2FM
 mwOAKfkgA2Jspl3tEIyUYzGfPe/JLp1T3+eXtMZ2dN3OU9m0iJCq1TIKqEp3EJEfGygphNH2Gy
 /My4xcmx23qwalbDYX5/XaZ653RCpm8weB1kYqSp6Fw+YGzQ3eCb7YqO1dPTNkftQWQKB/CxYW
 tkqvye/CVuMxbcUD0r/IbhwokalL0ghcZur3xufzf7QHe62yFJrRNGCEXyWBr6CynXmWZ1EtvV
 TvUVlHHjNRnoOfiIfHsdUmEt
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2021 15:55:18 -0800
IronPort-SDR: lTc3CrOrjYfszc+yEgJJIAE4Ak08/1M+v8MRC+Hywf/WlIgSmprEdYi0C7d0U7Z9dGJ10AbooM
 uNcnZXKzoueVhkB/qh9FJDfuG1DPU6raUkRuqAdB/JGD6VRhWBLb2VNOFwU1HKKJeY1bruXhNZ
 X3n5jdiksc15+jYRjHizvjBhLJkEFjUnnnqLVEXplxndIz5czXNBjFC7bCD/1WtlFivbJXIVsc
 Amg0UGcHZdARh5i1M52Tdgy0zX7QH0mj+OsTeFweRWQ/GG8TmQqIAgjTxLsyF90YtPTOWxvQzO
 ix4=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 16 Feb 2021 16:11:47 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 10/14] nvme-core: remove one liner wrappers for streams
Date: Tue, 16 Feb 2021 16:10:28 -0800
Message-Id: <20210217001032.25741-11-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210217001032.25741-1-chaitanya.kulkarni@wdc.com>
References: <20210217001032.25741-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210216_191148_936011_163C19FF 
X-CRM114-Status: GOOD (  13.12  )
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
Cc: kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The functions nvme_[enable|disable]_streams() are just one line wrapper
to the nvme_toggel_streams(). Also, there is only one call exist for
them.

Instead of maintaining one liners, rename original function
nvme_toggle_streams() -> nvme_ctrl_allow_streams() and pass the boolean
value to the function to enable/disable streams. While we are at it
remove the memset() call and zero initialize the structure just like in
nvme_identify_ctrl().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b43557ebc564..139cbeb11c7d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -686,11 +686,9 @@ static struct request *nvme_alloc_request_qid(struct request_queue *q,
 	return req;
 }
 
-static int nvme_toggle_streams(struct nvme_ctrl *ctrl, bool enable)
+static int nvme_ctrl_allow_streams(struct nvme_ctrl *ctrl, bool enable)
 {
-	struct nvme_command c;
-
-	memset(&c, 0, sizeof(c));
+	struct nvme_command c = { };
 
 	c.directive.opcode = nvme_admin_directive_send;
 	c.directive.nsid = cpu_to_le32(NVME_NSID_ALL);
@@ -702,16 +700,6 @@ static int nvme_toggle_streams(struct nvme_ctrl *ctrl, bool enable)
 	return nvme_submit_sync_cmd(ctrl->admin_q, &c, NULL, 0);
 }
 
-static int nvme_disable_streams(struct nvme_ctrl *ctrl)
-{
-	return nvme_toggle_streams(ctrl, false);
-}
-
-static int nvme_enable_streams(struct nvme_ctrl *ctrl)
-{
-	return nvme_toggle_streams(ctrl, true);
-}
-
 static int nvme_get_stream_params(struct nvme_ctrl *ctrl,
 				  struct streams_directive_params *s, u32 nsid)
 {
@@ -739,7 +727,7 @@ static int nvme_configure_directives(struct nvme_ctrl *ctrl)
 	if (!streams)
 		return 0;
 
-	ret = nvme_enable_streams(ctrl);
+	ret = nvme_ctrl_allow_streams(ctrl, true);
 	if (ret)
 		return ret;
 
@@ -759,7 +747,7 @@ static int nvme_configure_directives(struct nvme_ctrl *ctrl)
 	return 0;
 
 out_disable_stream:
-	nvme_disable_streams(ctrl);
+	nvme_ctrl_allow_streams(ctrl, false);
 	return ret;
 }
 
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
