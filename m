Return-Path: <SRS0=LUST=DN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3916DC4363D
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 23:31:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDACF2087E
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 23:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kv7ESXqB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PWnB6y8K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDACF2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Nhy+9DMpLEFx/5H6kPYvaiAl1+qZ3GyYmrPvnyw3sVA=; b=kv7ESXqB4sdETQ3DroO29fUZj
	rKRPh2/9DhrInGB4JbcR7O1CrWeF6+Amefu7x/9BxzOwa39w1zSykR+xD07AzFlADQNYPpPGKszBy
	bMfxF8ayxqMDVDbnB5zRmhjtlE7JsrYpq0xgPyNnqxobACimD4PJNVd7CUQtnlJOn+Gzkmc2r2zRC
	mn1pdDpzcuLYkZl6EX6Q4hon4ivSOj7gjXLqXcG/GtXVFqPy+z0+64Pob8GZJJnCcZe9fRHzb8XDK
	kxclfWuw/vF/5fdcrSDuGqhm4+b4ycdj15pEO4UPCqaj88ATfP4QBUhGC97fjnQoK5Dlys2tTlOBG
	qbTXxg+Zg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPwQh-0006Iv-Tb; Tue, 06 Oct 2020 23:31:36 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPwQf-0006I4-DP
 for linux-nvme@lists.infradead.org; Tue, 06 Oct 2020 23:31:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1602027094; x=1633563094;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=q5WXvs3z9ecZanIMl1UPlJsiUfz1vShtEXrU31jkH5M=;
 b=PWnB6y8K5TABbafAACxXd9TAf6qWIzItGzx9tNgPkjDQT3vub/tlOabQ
 L49iI1xXNqIlKGx+HHHaYTRl3+fEJdF2SGsi5PaC+xXqjYyyGhQCG0rbi
 /CnmoWBPbdM8JVPsuiVrP023OHJBkdyzE6gT23M/8/JLAlK864iivPAv1
 5iu2zFg051H0NT3w4yhn+00IPbUh6lY7SOX7jhlyTbg0+iAiEDZ7ohC8q
 TSAJJziYm2zPUEfLkwy8Kcz/R9EHtvIr6UsHLAzMAadYhR9togdVKLfKL
 b7gSKXqTKF/Tuw+YNffZ94vpbpYtlVtUmeWqczR9wimVCCPTlZU4cagpt A==;
IronPort-SDR: Ql9/HDCTmxfHRf5squGeDFjegMLQidnQBKg4FJMxKW2DsVMMXIe+svLt4oLmVe0UxOzhtHCLRt
 k816UJz9akNXeDQsz+Ac4/ZO+Oquy/DHIoVwYkFZG89GtJuntzT9DpARxyO/HFgb4TGrV/B9Qh
 IZnBsWwwHZo9MTDGtdhWKuP+d3EkO8kjgX7Smy5Ymi+AP37bm2m7i7FzUh3wNhn9vLJG5ya1E2
 92xIHBE3E02sIuW57uKnBniiKS2pr7Of+zojoV4KvXTzy8YVMAqI2sjfaDa2CoqUIoWQbh+Nvu
 oHE=
X-IronPort-AV: E=Sophos;i="5.77,344,1596470400"; d="scan'208";a="149277857"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2020 07:31:33 +0800
IronPort-SDR: TwpHm5vjQMLTaIOgycAT3mMTw5Z9X1v0odA20N4rrkPbqAmysqte4t6KlHWoo0nDMrKx6LwDri
 fH//dYZR6wBg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2020 16:18:17 -0700
IronPort-SDR: usJtLl4BtU+ZES6k9oUj/nk4Hbi3T6yDIHLekJdTKBm4w4zpWpVwO6ca4GF6ssctCKMrTu5Dfw
 b/pj71ZDxLSw==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 06 Oct 2020 16:31:33 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V4 4/7] nvmet: set default timeout for passthru requests
Date: Tue,  6 Oct 2020 16:30:46 -0700
Message-Id: <20201006233049.55458-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201006233049.55458-1-chaitanya.kulkarni@wdc.com>
References: <20201006233049.55458-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201006_193133_598818_BDC9388D 
X-CRM114-Status: GOOD (  12.79  )
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

In nvmet_passthru_execute_cmd() we don't set the default timeout values
for passthru requests. Use the default values ro set the passthru
request timeout.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/passthru.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 56c571052216..9f9ab5665dd2 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -242,6 +242,8 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 		goto out_put_ns;
 	}
 
+	rq->timeout = q->queuedata ? NVME_IO_TIMEOUT : ADMIN_TIMEOUT;
+
 	if (req->sg_cnt) {
 		ret = nvmet_passthru_map_sg(req, rq);
 		if (unlikely(ret)) {
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
