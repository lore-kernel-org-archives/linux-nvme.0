Return-Path: <SRS0=Gy4h=HM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA16C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 05:49:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84BE164DE1
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 05:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84BE164DE1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oc/K2uNxmMtQfh9IOeJQSlLxFsW9+1Yvt427Hh4/RCQ=; b=YSszdTejLeiofTS8+nQUjLZAf
	NTMUOutbRLxt+v38iEqr0Gn8X75UsqVUXt/qcQ+CMzhuNoDG9V+NKExkVR9mLAuP3pVAFK/rFo2/U
	vSiZxBKdK+JFtPcCyOx7SY7+UHZyhIpDdQulVf1iySNHFTbGzcIr7vlv/c+jKAo4hQ8/XhXqUuKcF
	/pSplfHAnNLux60RzTrGyujIWzCWWy0doXX+9mERFpPtvGaLIMsCAoNqVmdJdfBvbJ+emnt8gUf4j
	Aw9FXfvJHyC3Jjtr1V0DVbJzrcB6rM3pjRuq9+22SolKMXB3yhznp12Suc/4cNDdUinjnBX+x/btX
	UhuUASIGA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9iNZ-0007D4-Jf; Wed, 10 Feb 2021 05:49:33 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9iNU-0007An-3Q
 for linux-nvme@lists.infradead.org; Wed, 10 Feb 2021 05:49:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612936168; x=1644472168;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OJAynS3Kv/UlTyycM5j8QungtTUtwyaJ38ZPqHX5QPA=;
 b=fgK2Cn3au3liJD31SBLA5cVVcysYrgnAmqmFuW02ZJQ7lhe3LFo6Yzf5
 w4i5G8CXk80XH3H84vIxatcMiSYB9vUhOWmTuTnJhtUw9gSYnO1fg7kVt
 Df/Cf/RlfbL611ydVROyzQcNUuNGG+m0GlVZOWc+aKzpLkdp2S58+pLjk
 2ZKg0PoSbTYU1NTTEx0ZRk3l6oXlZS5reVdiO/Z27GcSNMS6E1qrd9CR/
 E1Cz4lULhAUKtXhPRKDXV1B6ipXsG6SA39KdhKLufHmw0rcg0ooLx2vc8
 ZQrJydocA6jjMvuxdZR99bn9ES8o2p7vmG+XUAWPmhymteUOUkd9Jsfn4 w==;
IronPort-SDR: +0ulxzXXRHp0v24FFlm1jxiG/GwCTIyhMEn+pBPaDWqip0q3VP65S02TPZ1zUOBm8YBvSeFKK9
 Jrj/O0qVUqG5W2544js1EueHKxovQrpF0JYkw2ilF5sBl1l7I628P8AmpgwQGdIYQJ6a/v+URr
 JqZJ/oauJgMZsAnCDujJYOHhYr6/LzFCPhHe/5wE3aEOAAmy4jgy+DRvmChIbZIVcJmSovGEe6
 c81sWukSZ1X9Ky0cBs5v+S/6Wz8G1sKNjr8wzDylbfiVeKv05QkMtZ5zXqJGawh0wqG1EIceur
 wuM=
X-IronPort-AV: E=Sophos;i="5.81,167,1610380800"; d="scan'208";a="159609319"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2021 13:49:27 +0800
IronPort-SDR: hNE2DrZKGcPQTTgnNPCPvwz96FpwKOJ8/jwKOkmzVRbBXQCMs1UWInNbyivTbDymLDzMJHyDIt
 Y4GpjbIoKI0XfVv+oKfa6HHDAuCaHNK+kpEQ0RMkbZznA8u2QqEMfKqJMWnpQiuhcwOpF7oreo
 Vd3RoFDupHjPD1u065nzUbDxJGH2jT+QQjuNXYHkITn3OV5J5roBqfCcE1yC5WlaxCiPr8YyTO
 5dM6qSf7WHK2ED0t805hDgcuwx+sZSdmQogHC5z+hdprC+rMmWFYHb+aBOP+oL5/XqsbYL/FKw
 10qTYXCzuKGNTWr1FunWRSeW
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2021 21:31:19 -0800
IronPort-SDR: SV1KCzU5sAWZDHhq5GjQOl3iwgfKZJ9d9zaS74U7DP62ynTf+BqPLvLAEOnRDwfSgNVglzIL5F
 /bg6J1ra2RN3QUj7P77hc7LRGV++hT8o5zR4fnvIKJ32XXn2jAlh1RfWf3BrWzIbcJwgeTK6gI
 tiAN6HnoIzw3rqeBSb6rY+tqOUwi8P6GZMhR44Ut1ZdC6SRw5PofIdAVxXDCa8PRddvfoXmAer
 wDFvEZmTxaPbYnPZutmMHTV/SYgZ7m6GBTPP0IB3ljVWxPgAF0PtL8YYrFagKx3zEZ5iOtbQCO
 j5g=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Feb 2021 21:49:26 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V3 11/11] nvmet: remove else at the end of the function
Date: Tue,  9 Feb 2021 21:48:02 -0800
Message-Id: <20210210054802.34269-12-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210210054802.34269-1-chaitanya.kulkarni@wdc.com>
References: <20210210054802.34269-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210210_004928_305712_B82C4AE5 
X-CRM114-Status: GOOD (  12.95  )
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

The function nvmet_parse_io_cmd() returns value from
nvmet_file_parse_io_cmd() or nvmet_bdev_parse_io_cmd() based on which
backend is set for the request. Remove the else and just return the
value from nvmet_bdev_parse_io_cmd().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 32221f98f1cc..1d5516272530 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -882,8 +882,8 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 
 	if (req->ns->file)
 		return nvmet_file_parse_io_cmd(req);
-	else
-		return nvmet_bdev_parse_io_cmd(req);
+
+	return nvmet_bdev_parse_io_cmd(req);
 }
 
 bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
