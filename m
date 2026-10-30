Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561F1606A31C
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Oct 2026 19:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=DouW0Xqt;
	dkim=pass (1024-bit key, unprotected) header.d=seagate.com header.i=@seagate.com header.a=rsa-sha256 header.s=stxiport header.b=SY1wsPI5;
	dkim=pass (1024-bit key, unprotected) header.d=seagate.com header.i=@seagate.com header.a=rsa-sha256 header.s=selector1 header.b=LDBGJNqS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=HehpalulkoLTK0sY1HL/24WpXJbf1QKekOImofgn6DU=; b=DouW0XqtEHltNLB4ZDGbi7tgo0
	5ph7RImUOZ4lEd2/Eznm6v4qi1/tLo2AJoVbrtzNbOV9uvvKnrRHzxLzNX5G+6TeH8UsCwMHNUMRQ
	FXbmdpAeCYyGKpo7Ca7/jxcnLX2ihb1guroao9KBqVw/sUD0lppwbzfhU8BzHrvB6bmwCowNCZI5N
	5yl/JBhKLLeX380kJGplCLAwVV4/sG3tcdZEmYg1vKBHpBtjUcrTxp0Pfgpd2kGZ1o6p0ysFY3RBE
	AZC5Y5iiGlPengUCHwYBT/8Eqai42eklJ2NZmiS6lwZscs3yCD4OPbPv9/Fx1FxU8YiiSeHBowaLL
	c2e8I3sA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMs8T-0000000CTtU-1o9m;
	Fri, 30 Oct 2026 19:19:33 +0000
Received: from esa.hc4959-67.iphmx.com ([216.71.153.94])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMs8Q-0000000CTsq-01M2
	for linux-nvme@lists.infradead.org;
	Fri, 30 Oct 2026 19:19:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
  t=1793387970; x=1824923970;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HehpalulkoLTK0sY1HL/24WpXJbf1QKekOImofgn6DU=;
  b=SY1wsPI5xYHu0xE6FW5UMqCORg7x7Q3TMGwh85kD44F1i2Ji1/wbgEoe
   hqNRDOMj+3LauuTJ+jvnSz7FhZ8gwrncnvOkZkmyVp+GImEzxFGYiQJzW
   oBp93ma65qbLLk/RKPO5ggCK6pZ7k2JpaVF1+wRG4qv56ttAuT5oAogux
   I=;
X-CSE-ConnectionGUID: DkI5pGJMRFK1U3OfbEazPQ==
X-CSE-MsgGUID: WyXQWFZXT5eacJdLuD7pmQ==
Received: from mail-bl0pr07cu00103.outbound.protection.outlook.com (HELO BL0PR07CU001.outbound.protection.outlook.com) ([40.93.4.3])
  by ob1.hc4959-67.iphmx.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 30 Oct 2026 12:19:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7V3u6L3sT7fkPgjvPuD6IHZU9usSdyUHADaBJGXHmLel9bBvM1msamJd51ezX5TUzjLj1hYnXRjSoVRx9yG8MJSzoEd3JiOnoafbbg+wYeNXSkcf/PBA89KRG5cvzcueLL2GV+r9AcawvlrG/a51nZ+WSRwKR5tc86FzrasCvP/8g5Kb6628Lenl82mih6Hz/dOE43a9ruNqKZXH10LEQERC0zl92+WFe5cnVAnPcVdt7yaAyoCbGr3dNK6p0IDS93FRHnRlgCktw0ArphSm+cJKQB/nbUppkwb4TMs/RLPe2mMrM7/ZIJwM3x/7vTBMMt/KJbdHlSPAZioqR7DAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HehpalulkoLTK0sY1HL/24WpXJbf1QKekOImofgn6DU=;
 b=bG3T6n3IRou9naQiHHjUTtw93Yi22fj/QWWgcz7l2erQtJt1nQsaw/JKBV2fNa5vMnhU6w2WlXLv2Aqvx7a9NDcBIPZu625af1kyoTFqmGUvjfKDTREZkn/qO7L/KgFWObdtbcVTUC52O4zkPsRaPr4dxbH9UQCQWPyHYx7Z/efmehlyMo4EIe1AyogWlSYO3Wja4L3i9h9lFTUFG1kNkc7kKCW/mNgAYj3dmGxB21sth5WIZFj3QDZZxkdaVfuW2tgMcOTMEzPcWEOyRcT2/u2FU0ctveRmGWoZNC+SOVBPBjmLY1WXUfROORfBqx79YYJP4ZdXMW6dxR9YVLaubA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 134.204.222.52) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=seagate.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=seagate.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HehpalulkoLTK0sY1HL/24WpXJbf1QKekOImofgn6DU=;
 b=LDBGJNqStftMCPj/sKXHnS5+QzMFGcpKGGQBkJ1xBc3wgJcO44qHrjsYF0uVKX+a7nHu3rvVM9iLN0sczdtNlL9nA+z2VE55jOaOja2OhDugzdKXVNMwkWMhHU1CVV1FJrd060nTqokOacafWJ7VyH/LuJdvmhJiBNeW4YOSZ2U=
Received: from CH0PR03CA0444.namprd03.prod.outlook.com (2603:10b6:610:10e::12)
 by BL3PR20MB4972.namprd20.prod.outlook.com (2603:10b6:208:3b7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 19:19:21 +0000
Received: from BN3PEPF00022BC6.namprd05.prod.outlook.com
 (2603:10b6:610:10e:cafe::80) by CH0PR03CA0444.outlook.office365.com
 (2603:10b6:610:10e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.10 via Frontend Transport; Fri,
 30 Oct 2026 19:19:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 134.204.222.52) smtp.mailfrom=seagate.com; dkim=none (message not
 signed) header.d=none;dmarc=fail action=oreject header.from=seagate.com;
Received: from lcopzesaa001.seagate.com (134.204.222.52) by
 BN3PEPF00022BC6.mail.protection.outlook.com (10.167.248.219) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 19:19:20 +0000
X-CSE-ConnectionGUID: qh1zy6bpRlKNKQA3XEFVxw==
X-CSE-MsgGUID: 7Fjy0X08QUKOlVUVza7s8g==
Received: from lcopiesaa01a.seagate.com ([10.230.120.56])
  by lcopzesaa001.seagate.com with ESMTP; 30 Oct 2026 12:22:01 -0700
X-CSE-ConnectionGUID: E7pRxbH4RS2WFQkpuKIr0g==
X-CSE-MsgGUID: WtBeoHltTEOgtW7m8lh5rA==
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2047095"
STX-Internal-Secure-Mailhost: TRUE
Received: from col-l721190pt001.colo.seagate.com ([10.230.88.101])
  by lcopiesaa01a.seagate.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 12:19:20 -0700
From: James Fantin-Hardesty <james.fantin-hardesty@seagate.com>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	linux-kernel@vger.kernel.org,
	James Fantin-Hardesty <james.fantin-hardesty@seagate.com>
Subject: [PATCH] nvmet: fix arbitration burst field mask
Date: Fri, 30 Oct 2026 13:18:53 -0600
Message-ID: <20261030191853.1777683-1-james.fantin-hardesty@seagate.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC6:EE_|BL3PR20MB4972:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2e8e46ab-a515-415d-fa3c-08df36bab31e
STX-Hosted-IronPort-Oubound: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|11063799006|56012099006|261009223027099003|261021123027099003|261021121427099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4sh03zco/gJyv7oQdfYkUJI5W8fcabVjlaAHcLC0F0ykK8By5ziqOBYnIQCHx8HrDgpfYTH6pzIcN319Nro3hkvLWGtaG3jDtw6wvcRwGJhGA2eZMQNWZaN3pLW87UMZTsNC3Yb+XnlBrmfwmUqmckxpFiaNGFgPiXl0J2qgVkKuvgLFDOT1ypIBE+ZttcNAiPdtEQ7LTagMSlWEWJCnJWSkWpJfxJNLw6rL7zFsuPBe2VM11cACEPExlTHFeSovSwtLCXhwOnxBlsyIlgkg+9x+G/zhg1IWvM9GfFrDSnEsJY0/cHppyEEw6Uz7Ww+tkenPoP2cAaLms7bK5WRIRLCJLryJ6g8QG+AHHYD2+3myJqBaihPpJ5ov8j7QEXvpRJtTBwE8XSQYHJPNB3h7Q0iRC4y56k1lemxZltJkwt87MZqMXzE8624WA3f/ZPKmc6BZ0KibAeW68Ao4C5Idb4FCSLl/7FlNUASZceuLeegECzPmHy27Q4FnZrBio2ZS07s4eQ6DI3xJY4X7085s+5ukIDyYbhnE0IFxr9JIMDc1KH9tHNOuyRo1heiGDOFkZ0HkdAlk/EdbXrBzDOAZjRvH9KhwIvcuvqTG/oJV6I7Yke4g5kLsY8zwxd+VvP+xhi/gnAo3/7CW8pU6kkuGLkSEZ+gTFiWgjzbDJkMFQ+ejrGy2M4xSHjnfZ5IAnVKGaRxRlgD2/3txRdDHYuP/jw==
X-Forefront-Antispam-Report: CIP:134.204.222.52;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:lcopzesaa001.seagate.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(11063799006)(56012099006)(261009223027099003)(261021123027099003)(261021121427099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uq4XJPUuA4086a19X0huoW8wvc3DjGlEm+4IpCGEYflN+btqrtNtZjSs+Dg8GSKmScRzMusPgRPdV0tEs7w2imgAhwvf2ZuR3A+J/DxRd9ydwVNHaO+2lgDzQ/NDLyAn1e5FqcNeT4yVUtjOnEOYn6YNSDqgNB9CTXhwObutJ2zq7U7dhGM31XrSd+OyKsCer9anSQzWPBwlqzg/4hY2f3Kxyi3QsTqNHumwas8NsqvPxxyEFRgA/t0mlGv2XwW6lrUB2lVk5rdJLNNYHIJxek2ja51L3JXRUNLt8qf2Wsfpg713qA2Eg1JpKUhn7BMJmumna7Cemb1qguUQRcjtywLO9+Kh8/c9DBBk4Qe5/Z8cXqM00qLI0V4g6D6InSpye5G1j9G3xk5Kz31EBUnqZzWtyVEIVg/e7Jf7u0WOoTOdZA+H0Pz21QVhmcRROp71
X-Exchange-RoutingPolicyChecked: WTn3DXxXcc9jEsceSveFBVmWflnSuIo3OCKGrESqltGpz7yGk9D17aNYsawoZgif+7cCldiiqAsU1hPRDlkTn+vpGAL93iL7oK3Q0GuQojkIe/0ybpVKzUAbmAwUiBDzcL1ihQ3PbkZDiJfGWfDxj7XOuVkGJDPA3/yga87bNuRISRX+m3v0EBU09czHotKRa299hgAeKDXgP2a1pqCg9TU3f41j3ySM3eJ51LbSd+bW/8JsDUevaYiqm2LfgDmC+0iOrTgREFcAd2vIpU2wdAzfiqBR2MOrAJqpFnYv1hp54XRxnREF96yWmemQowgUDYRpbpe2TjujfkF2PZIkEw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: g7djGyfuJIuSS0Zt/2t0pft8YcnENHGkPlmfc01BVBVm4xW5kiGyzcHorPKakQQzVt0LNncEvPnTBjjFLXn9rOYVUYOwMiDTXQjbgVorVeInIgYzYHxo0HkQU+if8pmIyKJVVVL0vERUoZbmX/83IZuYc9t8F3lakTM7l6xJtI849X0nsUc5CDY0STiBM3fN8LkOVnFA1wSowQYg1pEIQ2lJ8Ls7XebMPJVkX2YhfULkBZIFq0JY9RsKpwMnykSMfxaU/tSwxCPWJQSHKCkZ3JQclk80H6QpJKbwmgPMfxaGUmWxevlwWENP8zUjpNJeAGYpqNt82wXwFW3B7Zr4kwHyV9aAeBGfOmyAmIcU/8A1RauVRt85FKFhtqKAVYKRTdz+lToIx6915y5BzKjqFuUJlq3eiR3HzqyIfuAJA0TlLec0stu+8bwHu7ZceQXt6GjwoD52HUTEwAsLTjjNYpAQvUPyQAdQ4Zv1vHmNIclpaNb9DOkgMjq+SoiyL0Ana67PuSI6X5nOTrk77nHSttS6DkblVAqATAy0/sjngS84guRPwhvdOGwYbkLbHJr9FGclmnonO57/6oDBRtCNmb631Vq+ehx0g7izBbzTnTQNPy/o+auM5M/EU7skE8vI
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 19:19:20.4979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e8e46ab-a515-415d-fa3c-08df36bab31e
X-MS-Exchange-CrossTenant-Id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d466216a-c643-434a-9c2e-057448c17cbe;Ip=[134.204.222.52];Helo=[lcopzesaa001.seagate.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR20MB4972
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261030_121930_530807_5B08BC1B 
X-CRM114-Status: GOOD (  11.29  )
X-Spam-Score: -4.4 (----)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Arbitration Burst (AB) field of the Arbitration feature is
CDW11 bits 2:0 (NVMe Base Specification 2.1, Feature 01h), but
nvmet incorrectly masks it with 0x3. Use 0x7 for both set and get.

Fixes: a0ed77d4c9a7 ("nvmet: Implement arbitration feature support")
Signed-off-by: James Fantin-Hardesty <james.fantin-hardesty@seagate.com>
---
 drivers/nvme/target/admin-cmd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 26028be8fe4d..6cb59a4f233c 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -1326,7 +1326,7 @@ static u16 nvmet_set_feat_arbitration(struct nvmet_req *req)
 		.hpw = (cdw11 >> 24) & 0xff,
 		.mpw = (cdw11 >> 16) & 0xff,
 		.lpw = (cdw11 >> 8) & 0xff,
-		.ab = cdw11 & 0x3,
+		.ab = cdw11 & 0x7,
 	};
 
 	if (!ctrl->ops->set_feature) {
@@ -1481,7 +1481,7 @@ static u16 nvmet_get_feat_arbitration(struct nvmet_req *req)
 			 ((u32)arb.hpw << 24) |
 			 ((u32)arb.mpw << 16) |
 			 ((u32)arb.lpw << 8) |
-			 (arb.ab & 0x3));
+			 (arb.ab & 0x7));
 
 	return NVME_SC_SUCCESS;
 }
-- 
2.56.0


