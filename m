Return-Path: <SRS0=wRjJ=FE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AA9C64E7B
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Nov 2020 03:30:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8B9C20663
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Nov 2020 03:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="wRie+k1V";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mCOi4pH6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8B9C20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QmZbNxz276iLlLPnV5+LNvJULN4MWuYMQCDbJpiL+8k=; b=wRie+k1VM8PlvaNJhtIZ2OudC
	DW+5oF4delH0+C3oD037gSaRZfYbymVW4ErF+OODJ4zxfWY9D6fjHhKfOSPUs9JcX4EKCncsq85Ux
	JqT56cHY/Kri5v3KJdf8Y5mAegTfoG2U/UAw8GRx+SRFx/3lMKlo/iIgB6k27+15aRugy8a/x9VMb
	LCYzDg71GBathH6SsAaV8d34UAblpPsekkKya8yNZi5EV4eiW0jk2tw4pyjuVqFbEFwNpauR+/sFh
	ADBSfFKDTDXSk1aMki4nVgMqJ3BTtvXNpK5Pil+s6AA44J8SDNEUl3FIE6+P29jaZ7zWu3dOVNhXW
	5m/NeZjWQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kjZtV-0000x9-T2; Mon, 30 Nov 2020 03:30:29 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjZt7-0000mp-Sx
 for linux-nvme@lists.infradead.org; Mon, 30 Nov 2020 03:30:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606707005; x=1638243005;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hUhzJ651cVoNvniIQeg3wff/FCoz1DE77FDFCSJt0Zk=;
 b=mCOi4pH6tl+0u6GEnhSJhDKbTUfDXMFTpUSthKOupulwRUQQwSMsqY1i
 xzaL2CyUVNCKN8ldgbUdQmii24Z6zmQDOvTSLJBRjMlOg/Kl7kYBmm/3F
 /51NdQho88AsfntPRhXu28+E6otBR4Ommwf4gjcjG61JgUCQM3iuGKWas
 VLYn4A/45Q2Ry25dvd/mfAVJ+CTF5ms/SayqgcMZI1+oBZD6/GqZhqF+c
 KU5iajPm2yAxYMyJpBVANXjv6P7MZ59ezOY4XFG/ZrbUiZ83cN4/eiUi3
 msCXRxNIN8A+KcSDQgnCO22d18tjAiz7Xvzct1TCFah4f5kHGaWjoUIHt g==;
IronPort-SDR: P0VgomKrSb4SDmaUXAjnn/DTAPYq8EzeRUgJhWBb57pwU+LZTTmDzD2VjVhIYbZfEx+weBD/Z0
 ZgQUHo1MuMLZkPhRKUylFmMgJh8dqpOm0c82lsDw5lKQHbiHMAadTWQ/j5q5QzR4DjTydFXd3Q
 ruQN6gY3L0COfSOR4PtbNnXW9z4E6N9QW83L2OD5R2V5d3792RbsEnVbdInYjLbLwu3LjI8NcA
 aSc66vNEzmXDzGIpTEJFY4fIXoGKBlnKsObjOxA+GWVp4+Pqb9gWEtDN4ArI5teuzeNL7v9J4e
 0UM=
X-IronPort-AV: E=Sophos;i="5.78,379,1599494400"; d="scan'208";a="153844141"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2020 11:30:04 +0800
IronPort-SDR: cEwmU/6GvNAlZTYSH5fZo/i5gLNYRsiJ2lMhRPiGjgYAluFy1T1Ys9FX5EEEfQxIWJkFpS0d9C
 B6zuLepkLctipTGP/GRsZ5o4Eni5NjFIk=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2020 19:15:41 -0800
IronPort-SDR: EqveP7U1iUJ9hEUH58pnDm3xDHLqLsQBe/x3lVQjWWaHN8ixfBGO2/LGRJPuSwUIw0LlcpCFMM
 nHFUoGOxmQaw==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 29 Nov 2020 19:30:04 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V2 7/9] nvmet: add zns cmd effects to support zbdev
Date: Sun, 29 Nov 2020 19:29:07 -0800
Message-Id: <20201130032909.40638-8-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201130032909.40638-1-chaitanya.kulkarni@wdc.com>
References: <20201130032909.40638-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201129_223006_202472_21901DD0 
X-CRM114-Status: GOOD (  12.39  )
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
Cc: damien.lemoal@wdc.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Update the target side command effects logs with support for
ZNS commands for zbdev.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index cd368cbe3855..0099275951da 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -191,6 +191,8 @@ static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
 	log->iocs[nvme_cmd_dsm]			= cpu_to_le32(1 << 0);
 	log->iocs[nvme_cmd_write_zeroes]	= cpu_to_le32(1 << 0);
 
+	nvmet_zns_add_cmd_effects(log);
+
 	status = nvmet_copy_to_sgl(req, 0, log, sizeof(*log));
 
 	kfree(log);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
