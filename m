Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EEC2C83F22
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jul 2025 15:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=fwZylXI3okQLUPc6hDhgW0pAde1Fdy0aaEfskXcST5o=; b=GMpd668vGasJQ8CEJR05OdJt6b
	/I5umL1PtaBgVuRiqDnoAW/EN73uAxjBWf48+pYUjVMOePhYHujVW3L7ikoIYiKRz8s8zRTUYFtmY
	wuamzan1I0gzxLd3mS/sSMvZNTPyjzErGpoFKf5qJ0niI163fvGucsdoPblxm5fULGdQDKqLYXUYa
	I5aE/ubAwDZS1j7nV9uEI+e6cnUtcHxrTnUA25Wf4/zwHksc0PWes0bfNEARpKTnl5WJbjbdpNE8j
	as5RGzlwdnxDmcKQGONEtmKX3uOHq0Vmy3nY/G9Hh1YsRN56XwQI+MXEk5M0Gt+PpL/P2leTXpUiE
	BfXk+wgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc4K7-0000000868S-2yZm;
	Wed, 16 Jul 2025 15:45:35 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc4K3-0000000867K-1YUG
	for linux-nvme@lists.infradead.org;
	Wed, 16 Jul 2025 15:45:34 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250716154523epoutp01d6ebd3f4a45b91ecb6f7857f9021218f~SxdUNskYd1118411184epoutp018
	for <linux-nvme@lists.infradead.org>; Wed, 16 Jul 2025 15:45:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250716154523epoutp01d6ebd3f4a45b91ecb6f7857f9021218f~SxdUNskYd1118411184epoutp018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1752680723;
	bh=fwZylXI3okQLUPc6hDhgW0pAde1Fdy0aaEfskXcST5o=;
	h=From:To:Cc:Subject:Date:References:From;
	b=rGH/tMlKxUQDDwEIcHnGd/v9Wb4iY1dqZAEmIHeL2O51bbRlFLlIoOkV8/T2IcfHy
	 RQn+95HbUV7R597l8LUVw48xg3NnOgOm5IFPCR3CXlJE53CUm5J6W7QrSQyw9HscBU
	 /2qKjuDrgbjZbjSmW18/zwH2yKCWUKFHo6CQ6EXQ=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250716154523epcas5p4d26b403c6818ea6318e916cf1ff9334a~SxdTwbaQv1705917059epcas5p4n;
	Wed, 16 Jul 2025 15:45:23 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.89]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4bj0kV2s42z3hhT4; Wed, 16 Jul
	2025 15:45:22 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250716134010epcas5p1c7ca7bcc7addf12c4cab2e4aefb7e020~Svv_y4uST0313803138epcas5p1N;
	Wed, 16 Jul 2025 13:40:10 +0000 (GMT)
Received: from green245.samsungds.net (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250716134009epsmtip288b7b68c230c6fe662e014dd030f526b~Svv9xDfc31999519995epsmtip23;
	Wed, 16 Jul 2025 13:40:09 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: gost.dev@samsung.com, nitheshshetty@gmail.com, Nitesh Shetty
	<nj.shetty@samsung.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] nvmet: Add support for FDP in fabrics passthru path
Date: Wed, 16 Jul 2025 19:09:44 +0530
Message-Id: <20250716133944.1384388-1-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250716134010epcas5p1c7ca7bcc7addf12c4cab2e4aefb7e020
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250716134010epcas5p1c7ca7bcc7addf12c4cab2e4aefb7e020
References: <CGME20250716134010epcas5p1c7ca7bcc7addf12c4cab2e4aefb7e020@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250716_084532_691914_4D98E928 
X-CRM114-Status: GOOD (  14.99  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add support for admin_get_feature FDP(0x1d) feature id, thus enabling
FDP at the initiator side for the target controller and namespaces
attached to it.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 drivers/nvme/target/passthru.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index b7515c53829b..0fd49f9f6542 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -533,6 +533,8 @@ u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
 		case NVME_FEAT_HOST_ID:
 			req->execute = nvmet_execute_get_features;
 			return NVME_SC_SUCCESS;
+		case NVME_FEAT_FDP:
+			return nvmet_setup_passthru_command(req);
 		default:
 			return nvmet_passthru_get_set_features(req);
 		}

base-commit: 347e9f5043c89695b01e66b3ed111755afcf1911
-- 
2.43.0


