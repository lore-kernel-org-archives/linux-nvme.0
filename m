Return-Path: <SRS0=tyJo=4G=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FB5C34031
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Feb 2020 21:43:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADD2A206E2
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Feb 2020 21:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p4trZpR3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OZFHbHyg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADD2A206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wegHutWpfuTwgEiMceSUlVv4juGcrnIE/n6yg2KTNIA=; b=p4trZpR36xopT9
	RgRdsgz5Z2pJ5K6gd4oaKqJ0JVuvYSLU2bdkfaDDV8QF4nB/3IS4KgYcn5oNJavm3WCUrNBiYiPWr
	0QInm4duvPUTairzFCBgN9PzBzU51sdv9irkb+JoIxzUkTMKRIK60tUCrSxV9t6+ZGprvzF52SB6u
	H9Z7M7eFJ6JxzUEZS09YlvEJFZRWuLj2Ha+tQBx9FH2iIF/Woz2s9IA9S501PE3NrH0L9Zyw1avuZ
	JReWRGdDlCZ6u5vAXaM9JykkrTZPFvkDeBLB51Lx/UKXVTBPGYGZ22gJPtxnUnKnb6z3O6gJTsQo3
	UY/cF43DuFNLkzUsqJCw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j4Aeo-000573-Fx; Tue, 18 Feb 2020 21:43:54 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j4Aek-00051t-M8
 for linux-nvme@lists.infradead.org; Tue, 18 Feb 2020 21:43:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1582062230; x=1613598230;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PdG4uEKAoMp23zw1+Q2SXlG2zv1uLm77dknlCexFhSc=;
 b=OZFHbHygHX7Jjxcppddehr7Kk6gMi3OwtwKo5Sl0FPkv9k+n09C396gC
 zFr+T60Tb5UaoZsiNfPBjI8q/RBJifGtU84DBWBuKXN88ozsarBuIYri9
 frWaQyNyyNLyL6lXmwzL76r6goD8rHNJKDtIe/winTocE3Ov/7B6iOjXQ
 Rda3HRpCIa7GDJYXEUn3qIrtpnKbPw2LjtqVGi1fsu49MljdoyYcxWYeH
 jQeI+8FihddOVQhq5eAweekgGylm3Yzr+5KGKypEq6EW8AGlRhNW+UnRj
 yXCDdlzlG7OQBVED7ckog4Thwi2M+ysZtEi3NI0oKSbFjDoMyQFP5xh0W A==;
IronPort-SDR: /5dFhTtNfSDt8z2N7gvDck9muDf9y2J39t8kUflx/ts9V8OkmUo++Hv+6bFh+7WFE2hGeGfQ3P
 VNmNEqsWttpqgOqepomf07Qsb6Iy60a5REbKnyZfGGaqo/M4/oIwuyaKV3lZOoLTsYjc+DkvWn
 3N/tlkaFFFHvV5ndanvGLmTJcvTbzBMecDtbmaBGh2pZpoRCxBeSofoD4HQlg+WuOfqUbLgLIg
 0YjIs4Qa6cIoODvFk+jCL4NegmpT8J9T3duZ7p5wp2lGYkuDB0TUD8f5G+L4z4ki39yZi2YLg7
 umY=
X-IronPort-AV: E=Sophos;i="5.70,458,1574092800"; d="scan'208";a="131570913"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 19 Feb 2020 05:43:46 +0800
IronPort-SDR: VhiBTcC/+E9tCQ8ftIaAmT0PuVUhZehrvhri9xlRT5MxxO+tMDQqVnjN4zSjff5NNc6aBILLYu
 zJhPoZubuV0s/htnUqlZcrs5oBvOGSdS5MaGflC6Twp4ydd5um8Xhp97VldmpIQm0W451BB+h4
 t21/3LDKncWYoucwKRvslixJhTls+FgUOXj4ELvVUZWVI9r+D3MeIkkU/FtM7UtkQ5O/aBSVMp
 IE1B5xgYaQsGIobq2BIwA6eQ328T4sCH8qvggvULMYLKv7Ep/J/RAFgQcVFWj14wasnklrFKWL
 rhi84ir3wjBTJ9w7EZLdVmve
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2020 13:36:24 -0800
IronPort-SDR: jhz016RcCU3EftTqFvldKvJ+VQgN19EjA3KSfJNTRZ+ScWmJe2f7SpLTgyKGuCBPychQGgXdE/
 2ybJbTVuN7gDpcTPKFBcghB/+IMEqxwrWZ5a5+jXRLhtOq9u6hkrLy4f7eHB9FiClX8QB/QqjF
 P/gvsV4P0t4JRibFQv8yRumabwQmlC7Q8fb/5qw41wKTY5AoYjo2NIlE7tbkwC0fAmrLoodZG8
 oiXzRQuebrbcwvC0zy3kCb0j2uM5mwMECoCPemlcNKga3ObZ+nwyYNDm6X0j1LWtkGZEP1d7tU
 Nks=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 18 Feb 2020 13:43:45 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 1/4] nvmet: use nvmet_feat_data_len consistently
Date: Tue, 18 Feb 2020 13:43:35 -0800
Message-Id: <20200218214338.25088-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200218214338.25088-1-chaitanya.kulkarni@wdc.com>
References: <20200218214338.25088-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200218_134350_815700_B311491D 
X-CRM114-Status: GOOD (  13.19  )
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
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This is a preparation patch which makes admin-cmd.c to use newly added
nvmet_feat_data_len() helper consistently in nvmet_execute_set_features
and nvmet_execute_get_features when checking the data length.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 19f949570625..f6374cd5e938 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -735,7 +735,7 @@ static void nvmet_execute_set_features(struct nvmet_req *req)
 	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
 	u16 status = 0;
 
-	if (!nvmet_check_data_len(req, 0))
+	if (!nvmet_check_data_len(req, nvmet_feat_data_len(req, cdw10)))
 		return;
 
 	switch (cdw10 & 0xff) {
-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
