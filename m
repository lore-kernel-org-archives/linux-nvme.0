Return-Path: <SRS0=DeHG=HD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFFDC433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 05:42:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53D7C64E29
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 05:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D7C64E29
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nENUwIuhUD50wRhvFXFfRnGhY/ZJ+kXAwGmp1ku6WK4=; b=xZxkIm2mWq+88Qga0BSCqfWX3
	TsG1UcR3j1hZXKFPyHJU/l1yGsnroOAIhAVrKlgIUchKMN5KS7hZDnRV8ZI36N4J30LSWss6addns
	a8Xf5UqhK0lOsSvcqqOSZlgn/L8m50eYb3SObGokB7Mf7S4T0z17dN4IMgiXNHv3+RIjOpKfxqqbf
	ajhhVnh2A0y6CqDST5ZKXhMf0fXxWaG4cJa6uFIPaEFf59aRJSyon0Rentif5zvA4wNR9iGtt9D5n
	qLYdbu7EwPh/Lcm3g/DM/hlZ3zHF0HEZxLICRPNjPkQyKpNAsvDp9a3cU1R83eOO0GPFtd+ChSMUe
	DuLLl0AsQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6Rz6-000556-MW; Mon, 01 Feb 2021 05:42:48 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6Rz1-00052m-Vq
 for linux-nvme@lists.infradead.org; Mon, 01 Feb 2021 05:42:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612159243; x=1643695243;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=622s1k8h3rZaxUl+ImtLrqjV0H+uclrC8JFnzWr06EQ=;
 b=I5hIDFJVRa6fDyPwhenNDIrW+ruIQnO0hbuqR0v8fnHLxJKHByj6P5Q3
 LkqD5EXjk0RXQsRwZ09PlRIiXKxzVsXu6K+kMV1+iK2ktFGYg79VoyWOj
 Bq8ZPN1MqiJa2QuMo3mYBSgOgKz6n4jIH8TAmccEH7jw2UNTGzpSOahm7
 YKO+vjXE9rAROI4qwDF9BLhp2M8dP5veRW/y/LR89A/CAN6D448WW19vW
 BEbeyvUCwxlIloEBL9Qaz5nLuLMHLo9V7Q06MtLI+ACegnqvss4DLXt8o
 R/27GyDgUTe2+nc4anirEV6t/tjAvuPlIxuif6uE+cAC7M/o1G1LM+YcN g==;
IronPort-SDR: aKU1hfZZ8x9pc8TXntVhN5QGJjoZCcVXtDItr8DSPq7gYPtaqM2JJE3fH0yZdhmHQ7Lo+YNdAt
 jM5zwrzA+7v+3G6LQVPHq80skSHpbF8VG+F1AArOcdJonqA2UjGHGTd6oIpi+m3LR8/b+ghdC/
 uG+0Lw9pCdVUIcHcj/GWalpoG4sy0gtwqQrhkLhuzpAl0ni7QQJcmheC8HD6K7q5IJTqYfXvxd
 aFlGFsCz+4uzMQYCuE4Jibgr8ep6fM1yv6uBONBrLx147gzlDPq46g84UiaysF1THvS00BcvG7
 BD4=
X-IronPort-AV: E=Sophos;i="5.79,391,1602518400"; d="scan'208";a="262851321"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2021 14:00:40 +0800
IronPort-SDR: KjKtuf4AiWwGRGf1QHUVfRyHnU4pWxYD+mZN2uR5z5ld/DeFAsRlPTZgToOeaUHgrFQH/NwDry
 Rx9fvlXdkEEsY5+ZBxmnlvd+sqWuI9h52x1H2PaGdXpUD8QVeBK3/w2J6mIuqq/TmZhmkr3J5+
 dg+xTA8gU7ho0TggNcnS6zS8h/P0YfpXrPBaZVgqdvj4LGhABS1yBKIKzkf0C19688A0zf7AMF
 U13DSDYnz2CWrIrvpSgvZOS13zq05J8MTkvP/Acrx9azfNn1+/+fS3V5TXNq1wZh6FpxarM+zL
 IvUExPI2mYxhzl6mnffje7Qx
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2021 21:24:51 -0800
IronPort-SDR: MzCR+u+l0ZYYTOwQjCjm4LUQQDRB7A/u7P9r6tinNeLfdqzTjChiLiSxRLDfzPNt41wC1yTFjK
 nqRZR7IQRTA4oLBxhK0WNAfPpgQULJxxbbDy6hMfnzXrgNYEhVUgMAa7VMAHDlmTyvh4OaATvN
 a9yTWWtFNcyHpy1bX2SeEnp+eQ9zPN0glZ3pSA/rzHsukptQdWIf4DcLaHahUl0/pku91TQ6Cb
 N4szZosAAIdZK9kssm1+QPGjVq2qbxNNm1cRQlmYLCRE6P2648kK2J7wyBwKE9kn5fge4cnHxp
 Eqs=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 31 Jan 2021 21:42:42 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 08/10] nvmet: use invalid cmd opcode helper
Date: Sun, 31 Jan 2021 21:41:36 -0800
Message-Id: <20210201054138.34324-9-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210201054138.34324-1-chaitanya.kulkarni@wdc.com>
References: <20210201054138.34324-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_004244_221323_6C8C0ECB 
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In the NVMeOF block device backend, file backend, and passthru backend
we reject and report the commands if opcode is not handled.

Use the previously introduced helper in the passthru backend to make the
error message uniform.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/passthru.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index cbc88acdd233..3b22f4a868f4 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -494,7 +494,7 @@ u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
 		return nvmet_setup_passthru_command(req);
 	default:
 		/* Reject commands not in the allowlist above */
-		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+		return nvmet_report_invalid_opcode(req);
 	}
 }
 
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
