Return-Path: <SRS0=Onny=7V=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6472C433E1
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jun 2020 23:43:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E9AA20659
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jun 2020 23:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RBDYnKUn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8CP6XXg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E9AA20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tnEnpSI42cnOh5TVtiSx7M2h8sEslKGq+ERJ42fMHNE=; b=RBDYnKUnsBfw2z
	IzECxEW4/fa+8SVJe/rDXblVJaZ2t/AO/ySzHTkcps9ltd39AQR5o2a2Lg3dMZ6QFVmTLyLGqiEf+
	UrO7PT9+P68a08xso/a+YaCdBkBXBqpewEjAVDY310XUttZ7h21bM0bKP3/Sis+6ieW725DDatADf
	aWe/jraU6IGgqrD2BxAZjwmzBanp7WS/ipP2hd2OpI52wPXeRudb2ivQssbiue0TCQLxZG691jSDE
	XPgO4eA4hCVs0AMY2r3oQw6q8QaFqBAj2egTosvkzpvHtzGE3G374JfZzyLYUX+7cnr0hRHDSKx29
	HDCvtQTpnWPjrD/JbvnQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jiRQf-0005h4-DX; Mon, 08 Jun 2020 23:43:45 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jiR4v-00015I-9G
 for linux-nvme@lists.infradead.org; Mon, 08 Jun 2020 23:21:25 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B4F9220870;
 Mon,  8 Jun 2020 23:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591658476;
 bh=K2YU//ZLvZNkYLg+KDV0DbTG8YJHfFJJ2wGbc+BUzfo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=E8CP6XXgfABEKi+amc5HQ0aPpAED47zxRxwx/CUrToeG5qFxpil4yulOI2E6Aqr23
 50+i9alodR3OYF1mVkKzqArTBfpKYOUlkUL4/fl9/Uvn9I0L8XqTbATv5wwQzN/M7q
 0tOAXyhSFPSmvqhiRrv7BgEYmF3GVyM4Phh+FyBk=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 113/175] nvme: refine the Qemu Identify CNS quirk
Date: Mon,  8 Jun 2020 19:17:46 -0400
Message-Id: <20200608231848.3366970-113-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231848.3366970-1-sashal@kernel.org>
References: <20200608231848.3366970-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200608_162117_362484_C8278738 
X-CRM114-Status: GOOD (  13.96  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit b9a5c3d4c34d8bd9fd75f7f28d18a57cb68da237 ]

Add a helper to check if we can use Identify CNS values > 1, and refine
the Qemu quirk to not apply to reported versions larger than 1.1, as the
Qemu implementation had been fixed by then.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f0e0af3aa714..d4b388793f40 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1032,6 +1032,19 @@ void nvme_stop_keep_alive(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_stop_keep_alive);
 
+/*
+ * In NVMe 1.0 the CNS field was just a binary controller or namespace
+ * flag, thus sending any new CNS opcodes has a big chance of not working.
+ * Qemu unfortunately had that bug after reporting a 1.1 version compliance
+ * (but not for any later version).
+ */
+static bool nvme_ctrl_limited_cns(struct nvme_ctrl *ctrl)
+{
+	if (ctrl->quirks & NVME_QUIRK_IDENTIFY_CNS)
+		return ctrl->vs < NVME_VS(1, 2, 0);
+	return ctrl->vs < NVME_VS(1, 1, 0);
+}
+
 static int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
 {
 	struct nvme_command c = { };
@@ -3740,8 +3753,7 @@ static void nvme_scan_work(struct work_struct *work)
 
 	mutex_lock(&ctrl->scan_lock);
 	nn = le32_to_cpu(id->nn);
-	if (ctrl->vs >= NVME_VS(1, 1, 0) &&
-	    !(ctrl->quirks & NVME_QUIRK_IDENTIFY_CNS)) {
+	if (!nvme_ctrl_limited_cns(ctrl)) {
 		if (!nvme_scan_ns_list(ctrl, nn))
 			goto out_free_id;
 	}
-- 
2.25.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
