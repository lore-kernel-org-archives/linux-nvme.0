Return-Path: <SRS0=yMBa=LB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4C3C4743E
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 00:38:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EF3B61245
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 00:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EF3B61245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fif+G4BZKG2VORGA298UiSJMazGxn0vCCmxUaInEKXY=; b=o/4cZLLsQ2qPaJ
	SS4r74+HT+R1Yxjk1egWp5DHY0WUyl/Tz69qNHZ7iiE5ZFwA0XPNPhoxw5TIOG/katSvg6N4b1DD8
	0FIpHu3aZeYc1KlPQLnPlSVQXuYg/eWmzWrJBJU460T1cEp5xY+OYSoEfA8Y+tPX2NaFwpvoLBLor
	L+SJ7ubWyN0Ayr70b0R6YRYYoi1OT/7nRYgaPWzXFOjdYYNtmmxAiNyS8UoLM+WFIUl2iTXPFZ6Ly
	JQvsELtkzItlt4JH/9PD7m3v84fe/0qE2x7wzBCDirP5nsk709685AAkWYYhTjlBGrYeDSQJ51fC8
	KgppEqaEveQXr6X8YXLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lq3Gw-0016Gm-2p; Mon, 07 Jun 2021 00:37:42 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lq3GZ-0016Ec-Fe
 for linux-nvme@lists.infradead.org; Mon, 07 Jun 2021 00:37:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623026238; x=1654562238;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CmSXfAbvNgP0ckuuopVjDi+42DAbvELaM/3jpvtyU5c=;
 b=nQoBR24ptxollnvNMDrxDdgjcPIRKzwm7DJStMzUp37izPi2G5wNrSKC
 TC5kgKMDvvKVtfrZVZJLi1THRjbjVbo/zDx6rn+FPm99nPr0JUQF0dS/I
 Iif0+8Cz3HF2hon3/T2ELJynvRweoGyJGhYI9NOREf4M1kG7M1Uh49D/r
 8Qhex9E+RT/CvFRdGIWOHxngYXhMK7A5mIkItTuuvjCHjBVPTweGmg93W
 qCxZ21VR+1kHuMsVTZLFIiW/9/l4eHOVtEZUSOOIkSB6gk2JChGapht7y
 gMeU/GdF8z8mInUCDrRAp8gZOeMmU9f3dTJuCWxRgTxtHzGaKARW9LDwJ g==;
IronPort-SDR: QcrDImvhG9iyRrKe4Zttsd2Ys6MqT0AIxlNOv37ZkjwduyBK2nmm2xDecybx+Ar/Yg4y5eFhAk
 b26QABgdTm+7oASzP1kXq1RTaYfpYnTk6ncn7zPF+nUkht3Z2cyo84wAdaFRfQBPq3irlZTeTK
 rwhLGxyY+yOjelHvVItIpdG0mSaBxHWSNosAC4E6+BaHItG4I14WmNgE/VwYGrZ1eT5Xk4Kfe/
 zZEQNJJZ3oqtAKjaS+TxiriQq2Xg/fHToOvdoLw4P3V7BNsGDeD/rJn36YX4zFcxEBQZ4R/0gf
 Wu4=
X-IronPort-AV: E=Sophos;i="5.83,254,1616428800"; d="scan'208";a="175720818"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2021 08:37:15 +0800
IronPort-SDR: z3GJBPq9SXU9+kGVZS7J4KljzsAZOIikX58wph+j0WvPq4GVA2oPqZpEKBLRmfwxtEAIk+R010
 mWdrKvO39AtT3mgeTidCFwaoT6NGZSBV+2N/Opua9xbWgX9AKwxr1Zn02ZCcROOsShg2hbRDRV
 GxiHg/6E4iWSdZxgkg355tm9GWbkQuVeWoYZ0JCAt4tsPQSndLhkTmbmM9+Z9z8XbNQHlw/2c0
 hZtSAwBeGZvXBVK0ZHfPlxI3dKXlGGpOAe+8E8hE1LcVWvM0pIZPieL/TzH0HLT9D0anDunsz3
 Kt+S3YLgD//+lH2nljPKOt8i
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2021 17:14:59 -0700
IronPort-SDR: o+rO/ASym+6lvqPxR8nqP//tPBO67Cek18SBRz8jly88yR5kOQ4VpyL7SszwDfbnrjZnwEfC40
 nmnS+zX7o4o658SNIuIxvXIQh8DxXWEfr+FXQow0EkaWP/nc0GAgeRTqTJiIPf48bgLtScg1LN
 2Cu9PSsK9Jboet/9ThnPU3bJ67nYKYtUvRdJMU/rbBNHhRadpfOGXGzAxaPMCNT+YcY6Bz9U5B
 WJGQ/VJkUIw6IOgGMj0AY3QcEYk07XCEBLQ00jb6GFjxNaMxinOWw3aMPCu6NZ5+tDSqV86Ldt
 XWM=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 06 Jun 2021 17:37:16 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: james.smart@broadcom.com, kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 1/5] nvme: use helper to remove duplicate code
Date: Sun,  6 Jun 2021 17:37:01 -0700
Message-Id: <20210607003705.21784-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210607003705.21784-1-chaitanya.kulkarni@wdc.com>
References: <20210607003705.21784-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210606_173719_550680_BB0EB7CD 
X-CRM114-Status: GOOD (  12.58  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add a helper nvme_validate_passthru_nsid() to validate the nsid that
removes the nsid validation and error message print code from
nvme_user_cmd() and nvme_user_cmd64().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/ioctl.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 2e7780ea0354..d93928d1e5bd 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -177,6 +177,20 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 			metadata, meta_len, lower_32_bits(io.slba), NULL, 0);
 }
 
+static bool nvme_validate_passthru_nsid(struct nvme_ctrl *ctrl,
+					struct nvme_ns *ns, __u32 nsid)
+{
+	if (ns && nsid != ns->head->ns_id) {
+		dev_err(ctrl->device,
+			"%s: nsid (%u) in cmd does not match nsid (%u)"
+			"of namespace\n",
+			current->comm, nsid, ns->head->ns_id);
+		return false;
+	}
+
+	return true;
+}
+
 static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			struct nvme_passthru_cmd __user *ucmd)
 {
@@ -192,12 +206,8 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		return -EFAULT;
 	if (cmd.flags)
 		return -EINVAL;
-	if (ns && cmd.nsid != ns->head->ns_id) {
-		dev_err(ctrl->device,
-			"%s: nsid (%u) in cmd does not match nsid (%u) of namespace\n",
-			current->comm, cmd.nsid, ns->head->ns_id);
+	if (!nvme_validate_passthru_nsid(ctrl, ns, cmd.nsid))
 		return -EINVAL;
-	}
 
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = cmd.opcode;
@@ -242,12 +252,8 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		return -EFAULT;
 	if (cmd.flags)
 		return -EINVAL;
-	if (ns && cmd.nsid != ns->head->ns_id) {
-		dev_err(ctrl->device,
-			"%s: nsid (%u) in cmd does not match nsid (%u) of namespace\n",
-			current->comm, cmd.nsid, ns->head->ns_id);
+	if (!nvme_validate_passthru_nsid(ctrl, ns, cmd.nsid))
 		return -EINVAL;
-	}
 
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = cmd.opcode;
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
