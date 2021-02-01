Return-Path: <SRS0=DeHG=HD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA722C433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 05:42:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77A2964E29
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 05:42:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77A2964E29
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DLpS8SZgkOFI0DyJS55WBApkdYo+ka+9dEF2/01d11w=; b=tloGorq6lprXsyZQZi/b7poBZ
	2XYcxvUWU5kcETfsyhLFa/6mMNcT6Z30UuTE3SchCbPk+vxswxscW+egD9miDjdzvKdihrMjyV4iO
	bxFt/piO6fCqDQjw7ips3ovX9IeOF4RuYAYc4WbdxMBGv8vq4hZw1ewg96FuI+C9ag5kQDyn6euhN
	nZJkx84DFf+Xi60qcmBCuC0fH9eILpWX5jMzBf9REfOwVU2dZru4sYmZUx0p8U07e5SB4oXrTTt6Q
	YyeHJ7Zu0wgPhAzNKxVRhK2QN4GprcE30h+gUK3COIM4kUn+0LEzjaXA3U83gAEZP00SpJRYKRjxK
	lqz1MSCBA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6RyM-0004pa-If; Mon, 01 Feb 2021 05:42:02 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6RyJ-0004oo-Oe
 for linux-nvme@lists.infradead.org; Mon, 01 Feb 2021 05:42:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612158120; x=1643694120;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5+5/hi1vN+t44Jh7NMvunUMUJcfXLPcqoMfcYjLn1M0=;
 b=brWsXekMpmVXRtXBTiVVs1t55a7Bmm5f86/IhmYG/fMkFRFlRWwJa6PF
 diqsY0D2C9UGW8hzocCMozVyYZjF6OHbHXpBI93kZPBGDOkV0YCcFBGK6
 6lu10WfWqZVyMu4I5ZKk3alFgCQ+HnUB0W8y4ClqLEk6y3rc6G5st6ymK
 htdbKokHVoItUKvi3q7X9RV8nCmR+2Wxnb3aOybG+gRQX2QjN3OPgvsBP
 Im3/s7b+2coS7WLTB5Xhzr1FnM5WYDy/JXwVDeZlxCKXikuEmQGSuw9N0
 bD5ugmcq0OcN9uLEadJc7SN+yQl0+u3cRTGMVgCrNCDeSCQmhF1OR6OTM g==;
IronPort-SDR: 32UrX3uD2WOKPR+RYvQW2S4TM7M7xhIB5YVdzX4oozkMMiJF/5Gjx78MIZkq6VG2BZKTAnnh4Z
 n6nfRFjBD7e7Tp9lnY39DpfA8QcAEU2WddPv3XpHi/00qIKFgqBtunl4vSvVc6X4kFmbkiESTO
 pSlQCJokVFybFo3Oy3yJUFXKtPNrcqlH+EA1H//JE+PHJhI4My3N5M1Q2vs3o+x6AbE3wV+p4F
 AAWREofq1NXwuHm59/iNyd/IUV8cAEaqWQ0ePPuAEQgt5JILLB4FB2I9n/bxcAk1MCc/cYLlJl
 Kl4=
X-IronPort-AV: E=Sophos;i="5.79,391,1602518400"; d="scan'208";a="159967692"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2021 13:41:59 +0800
IronPort-SDR: ND7k0w+zsQJQkWlXmrRzGNWtQ7MkL96ciTKA4HF1hx/bOciXd+eUqTQSQeWGNyfzel90M5V0cc
 gfGN7wMUt+3vWUxjzV7KC7aYegxw1JOcMYmcGYZnH6ZMuy1thx5suxUe/cVY8IK101qxrD71QC
 IxAeZuajw4LiuwBN/iGyauiYlXeWwTOIST9LsfbgEfCiBpDnCGBPohcZ7nFWKg1vyLkMthgpVU
 yQgy00yCEEwfg7t9q6SWoElC0RVRl3ZXBi9lp63DXANeUQql9/U54PxAw/hyWYRFGoeKdJnQc4
 wRcL/Qpa5tEQqMcNoel323Ip
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2021 21:24:09 -0800
IronPort-SDR: /iR50/W8I8m7znlUEzN27NWa8mX0TyeDO65/nSzjZc+dLvv1QwNm1Npq13zzQbRyPsduyAo3qe
 K819c3rqIv1s5N9c50S5Tba3LoujfnpD3rdTsO6irR9+miotuQZWOjLfkWOrwnMiJYdcZPPRRO
 B8dm2GibKQvsB1EXQ/UfdYOHUGCFtgF8XU+r20EVJlPT8rKImdEl3wkS/dzzRAubH2DETXD/G2
 vw2HyieSHlavSXWcNMfmSmf25IsOrQ6MZRJhAHg8lGvT01MifR3Dc3RX0BgrpLlXeslZJulTqo
 i0Y=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 31 Jan 2021 21:42:00 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 02/10] nvmet: return uniform error for invalid ns
Date: Sun, 31 Jan 2021 21:41:30 -0800
Message-Id: <20210201054138.34324-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210201054138.34324-1-chaitanya.kulkarni@wdc.com>
References: <20210201054138.34324-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_004200_007276_6F9041BE 
X-CRM114-Status: GOOD (  15.01  )
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

For nvmet_find_namespace() error case we have inconsistent error code
mapping in the function nvmet_get_smart_log_nsid(),
nvmet_execute_identify_ns() and nvmet_set_feat_write_protect().

There is no point in retrying for the invalid namesapce from the host
side. Set the error code to the NVME_SC_INVALID_NS | NVME_SC_DNR which
matches what we have in nvmet_execute_identify_desclist().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 8cc7bb25d10d..ee3121b447fe 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -82,7 +82,7 @@ static u16 nvmet_get_smart_log_nsid(struct nvmet_req *req,
 		pr_err("Could not find namespace id : %d\n",
 				le32_to_cpu(req->cmd->get_log_page.nsid));
 		req->error_loc = offsetof(struct nvme_rw_command, nsid);
-		return NVME_SC_INVALID_NS;
+		return NVME_SC_INVALID_NS | NVME_SC_DNR;
 	}
 
 	/* we don't have the right data for file backed ns */
@@ -478,7 +478,7 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 
 	req->ns = nvmet_find_namespace(ctrl, req->cmd->identify.nsid);
 	if (!req->ns) {
-		status = NVME_SC_INVALID_NS;
+		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
 		/*
 		 * According to spec : If the specified namespace is
 		 * an unallocated NSID then the controller returns a zero filled
@@ -703,6 +703,7 @@ static u16 nvmet_set_feat_write_protect(struct nvmet_req *req)
 	req->ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->rw.nsid);
 	if (unlikely(!req->ns)) {
 		req->error_loc = offsetof(struct nvme_common_command, nsid);
+		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
 		return status;
 	}
 
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
