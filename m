Return-Path: <SRS0=HgeD=FF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965B4C64E7A
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 04:15:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15C6020725
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 04:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hFkZaaaJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WpGcXEu6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15C6020725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/1WytQkJcQbwSHBb+bj43DakB+PRBzfpTQYqhiOjXpY=; b=hFkZaaaJQNieQZPhrx6ioh7aG
	adNuHGCk4A8F9q1Q9bHAgZoR0SaC0LqJ4wAVE882/nVJ3rMVBuSElIF+0q3MRMSnW90NRowLc1vZ4
	B7gY9RAmG0+Su0e7thXUn1e2hLxf1twkWL4523CxcnOOGAwZwAvtItSSlWKVoK64DT0tWaljgFKuH
	XL+vaxIg/ezifkOwIU3bhoDKN6933CwVCg6PWqgVI8GEJSs8vpzGX0EGdMlgXi99iMqWhTTqpPAP3
	aoYcI2HlvMJt06TZAupUiW2LaOJrysvEsWABaXZ1NBe+pfN4BUxcv3sKensS5kNh3YYVLYhkAdz4Z
	JP2iUzuQA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kjx4L-0008SZ-W3; Tue, 01 Dec 2020 04:15:14 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjx4J-0008RV-F8
 for linux-nvme@lists.infradead.org; Tue, 01 Dec 2020 04:15:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606796111; x=1638332111;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=m/bvl+lK7ll6HRYiQ0kG1ndR5SFePuzrxfzuz5g9atQ=;
 b=WpGcXEu6PAypQqSjyGqrpWHWBeLfjK0em3OoD62UOQCe80Q67ZlGR6DD
 sXn+rHdbhDZ+EgNm7ths/nb8o9nAPoUoQsffHHXmZmR7KJCDetn5n+j41
 mH6O4KAe1QXMQS0mXY58hxGNJmbAb0bXISz9wxRGo3va5x35SVe8zfWuP
 4E8A5VYcqzPYj+P5E8tNm4csjjUR274UrI4bnCIU+9SYRfOIP+quex+U/
 /plahdfNRHGumXDQcJRr5BcMujhakjDP2rDjNvbWW0KOOZDpdQ3XDbuJl
 We+48Fej3yMO0oWjglPxSryR6JWoeMcTmCsvfKhkCTukJO8RE5OF+lUOr g==;
IronPort-SDR: 6Fgwqj4Tfx/k0FhBbfRbjh5DDyZSMlX6WayNSSUea5grfqyWOQspx7PTnSC8/sRBrsuZ5cuFmm
 m0ZQo8aoXZEx4S6N19CxRkHTVrrDImZe6PD4q+c39G2c7ZZ8sZwauPWpQGxMM2A1t53SqmhiJf
 GBdgUNmwSw4A7QKJOdWArHTBYjIkRLicYuxD+gyP1lpl4tKYTS0wiqwzMwL8ULScPztF0+5NPM
 6AhmNcChjLHSdepppzm2TTC/0PYWOgZkGCzSgzzj8XIceTDWv4Tt8m4WQw8YBcFvKXVFfoF8Se
 ips=
X-IronPort-AV: E=Sophos;i="5.78,383,1599494400"; d="scan'208";a="153948697"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 01 Dec 2020 12:15:10 +0800
IronPort-SDR: 96/5pF6UCGl/2yFPrt7pjUhDVMLmjkT8uplWz4q/R7hDYgW9awykSObYj1xKGXHBroMs1bvoTn
 Qf8ikrLLYWCD1b9YI1ToJRGmcrhQsk/Qo=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Nov 2020 19:59:23 -0800
IronPort-SDR: lTm+QtIHs4AZ5pzzJM/3sLQrBkSC4brkGHWf+hZR2x8+VWNdXZgumZWRj6AQH6VdoUpas9u0yH
 RDvNCidrDHlQ==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 30 Nov 2020 20:15:11 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V3 6/9] nvmet: add cns-cs-ns in id-ctrl for ZNS bdev
Date: Mon, 30 Nov 2020 20:14:13 -0800
Message-Id: <20201201041416.16293-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201201041416.16293-1-chaitanya.kulkarni@wdc.com>
References: <20201201041416.16293-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201130_231511_658137_05B3473B 
X-CRM114-Status: GOOD (  12.70  )
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
Cc: damien.lemoal@wdc.com, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Update the nvmet_execute_identify() such that it can now handle
NVME_ID_CNS_CS_NS when identify.cis is set to ZNS. This allows
host to identify the ns with ZNS capabilities.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index e7d2b96cda6b..cd368cbe3855 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -648,6 +648,10 @@ static void nvmet_execute_identify(struct nvmet_req *req)
 	switch (req->cmd->identify.cns) {
 	case NVME_ID_CNS_NS:
 		return nvmet_execute_identify_ns(req);
+	case NVME_ID_CNS_CS_NS:
+		if (req->cmd->identify.csi == NVME_CSI_ZNS)
+			return nvmet_execute_identify_cns_cs_ns(req);
+		break;
 	case NVME_ID_CNS_CTRL:
 		return nvmet_execute_identify_ctrl(req);
 	case NVME_ID_CNS_CS_CTRL:
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
