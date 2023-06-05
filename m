Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7452C7EE24
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jun 2023 07:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uHlwcUoVghZY+A+hlQT1MVF9SPGCfhGhmgmgdv1OjYQ=; b=gJq60AoRTUUXlZIZELd+vkB4wW
	XCWKXI/gkN62vrV+u/3Kc/LrRFZ+JSd5HP03iMYDJ30u2Kc6oNF9fE2YatR7/Ol7vy9LGbLzNI/ew
	jK5eSM07IF5YbSBdWO/Gcc2InWR9mbJAigg+elZ10/wJgSusA/a+Pndau9/Cp4GlgcFTZqhFq9E2T
	WNzNDgcrc7DzMgxNlvKBMpmgLGmLnFCHBSS3X38jEXFwmzMAF5tmZV1+SqDSFScR/pFDI/ZeyFqFt
	GXEEIIbxW5yDR34BBaVIX/4d9mx40nN5pOIfDX1hN+dpgGCxPSUDXoC1BjcfqoDOJVdKE6gd5ABVg
	cOsip0ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q64DE-00ETWv-1o;
	Mon, 05 Jun 2023 07:01:08 +0000
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com ([2a01:111:f400:7eae::600] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q64DB-00ETVh-17
	for linux-nvme@lists.infradead.org;
	Mon, 05 Jun 2023 07:01:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THLGIAXFFxb2cNUAflZyVsaRs0ImMsYbE6O6mQMD0xWIK4kv4bD5/sticXycPhpGM3XwKrIJZi8zmupdB+XICsIBWYzHtqVXEDEFmkdXuOO7pIGdPH+k6z3M5yQz3R1uCaS1zb5RsOm8zfWsDPHsgDiuFsq9oGVQSiEP6XkOKIn3+mKDaDCa71Fh58TA/2EmREmKZh1KB7TdUx0oXaMBb+wGMK/Gpgvc5/GL5UjgkBe5w49fEfVV3J9OyR5LyS7oDYWRezPUhzdjWFvIGuIC66Dj6iIg/ha+K4fRuQkDnHk2is2qheyLR9feWhx1BEhRkH3oQZdB6bR0MaxeuvCtTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHlwcUoVghZY+A+hlQT1MVF9SPGCfhGhmgmgdv1OjYQ=;
 b=A8S8UFfQvo98RTjKn4w8fRve6g/S4egPB29uN0Tif8IU5BwtMePqO97e0UuL+n7BZq/r2jVslqtc0kUPm/uNw02J/5k84oRii8bkfNrc6HuxtlCUQJQgcgKqFQ0T1oVk0OuiFavcLY7no4FgsgVqcinsUohc31pru9sKoErVMaLk1r5+GhdsoGCALMQeToTEjqVgCqD5UEgGQSFTfJY54unM7Am5YwhR39g8PbUCZQ09/ckFHbncSkizDYru78RiEE4n0ADLwkpgVLm7X+xaWPZvYwxGoTuZqkS30S+z0iI8a21AslhVlH7cff0OYZyoggXR1ighaNVKggZPHJUP1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=suse.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHlwcUoVghZY+A+hlQT1MVF9SPGCfhGhmgmgdv1OjYQ=;
 b=q64Ln3AoqR+JmSXKWSzmh5yCmfvE74nDNKxuesp+3jR85PUuHbGOUG3mAIlNqY4SlsdfLA5vYlovmOFFNQLpIp0IWZMixKdwvRibf9tYmxR+BBLmH+NWLBCcK1xnE/qNFyh01NnTdt2WRPjTrHqEPvT8Z0hamMB+hu8b1y2yfftpqOOwbewcB8X2tNvdYVXAlA+yAW2+FLwS1G+1CQw9iSMCTJF7F6cFBnJUValQ9Sj0wlscuWNNkHxu1+LL3vYo5pzO45txBwrJhOPWFcyU2mdVq0rrXOHrB+OE9rC8t8rrRZe2l3wNj75mcVCSmaEwdt9gOi4gvY4rnTTRv2uo6Q==
Received: from BN9PR03CA0089.namprd03.prod.outlook.com (2603:10b6:408:fc::34)
 by CY8PR12MB7729.namprd12.prod.outlook.com (2603:10b6:930:84::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 06:45:43 +0000
Received: from BN8NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::b2) by BN9PR03CA0089.outlook.office365.com
 (2603:10b6:408:fc::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32 via Frontend
 Transport; Mon, 5 Jun 2023 06:45:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT106.mail.protection.outlook.com (10.13.177.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.32 via Frontend Transport; Mon, 5 Jun 2023 06:45:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 4 Jun 2023
 23:45:29 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 4 Jun 2023
 23:45:28 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <hare@suse.de>
CC: <hch@lst.de>, <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
	<kbusch@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V2 4/4] nvmet-auth: use correct type for status variable
Date: Sun, 4 Jun 2023 23:44:34 -0700
Message-ID: <20230605064434.45233-5-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230605064434.45233-1-kch@nvidia.com>
References: <20230605064434.45233-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT106:EE_|CY8PR12MB7729:EE_
X-MS-Office365-Filtering-Correlation-Id: be421370-702f-476e-c037-08db65907c0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UYFXxZ3yFVabTAlbkY9xTvU/28Rv76/JwCdZ1N8H8QcswwgIyNps82VlEVyiRNjCayDPzLZwuSHRonTpNJi98Gu9Xs0HjSANKUIo6RZb7JKhsCEqXv6zvHxI8dG4J9jzTWmpXu9pAuRZfoyhGAnVz9ciqfkky6R0mH0U28s7Pz4oxTlFf9/9aKOZ/MHXHaH3TK2hT+TpUqgKuX0AclHNO97bxxIRn9qW3slvbQapoaXU1/0uL+2dkKIgGjQlOcbsk1xV5g5CW8IWc6snPaOb9fZ2mm1/KodZi42QwyFqBE1ScCQb8EpMrPP9jTil8tQyekwEb2eCsu5TczSXQcjiwP3VrmwZSxhPOHL8USHeF2Zi14NfLQXEdm7Yab3E4JnlsAyNyRlQ2dJMvoPj0WSzWLRNl3h06FLWqodeIFSjrXTSy2SaIFSLU9RCyiv4it4udjYT/QN78Uwn0YokUHVMh9PxbRJQQ/oZ093+fHHFrXkR10DuOXhFTClw1w1Q5+mk/HcGui0g9CWtu0NXX76w7BCVv3wteAFTKUZKZVGF+jwUngA5O8mNE87MSAg87iOlsUDuk9XRIMoVw8mYV8UzJSIPLj/t+zqjleEj+XF7SNJV1VmdTGWJSueMeTsOJc4NUZ0cyN2Sx+2aNUgvNxLpnjXGoKqwcgVwL+SIJlPvTuVYPnWfYqYMNpmmPEGRlHi7dSC8TKuJ5WGO7T6PQFkkYgxoRHSBNnNCiLWoN09IlnEPRcdsOxZlCLpIt56oENkv
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(1076003)(107886003)(2616005)(41300700001)(7696005)(426003)(336012)(6666004)(47076005)(36860700001)(26005)(186003)(16526019)(83380400001)(40460700003)(478600001)(40480700001)(54906003)(4326008)(6916009)(82310400005)(82740400003)(7636003)(356005)(70206006)(70586007)(316002)(8936002)(8676002)(5660300002)(2906002)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 06:45:43.2023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be421370-702f-476e-c037-08db65907c0b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7729
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230605_000105_386956_F57A41D0 
X-CRM114-Status: UNSURE (   9.15  )
X-CRM114-Notice: Please train this message.
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

In structructure nvmet_sq dhchap_step member is responsible to hold
following values :-

        NVME_AUTH_DHCHAP_FAILURE_FAILED                 = 0x01,
        NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE             = 0x02,
        NVME_AUTH_DHCHAP_FAILURE_CONCAT_MISMATCH        = 0x03,
        NVME_AUTH_DHCHAP_FAILURE_HASH_UNUSABLE          = 0x04,
        NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE       = 0x05,
        NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD      = 0x06,
        NVME_AUTH_DHCHAP_FAILURE_INCORRECT_MESSAGE      = 0x07,

These values can never be negative, hence change int type of
dhchap_step to u16 in the nvmet_sq declaration.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/nvmet.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 6cf723bc664e..66d8673c3ebf 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -113,7 +113,7 @@ struct nvmet_sq {
 	struct delayed_work	auth_expired_work;
 	u16			dhchap_tid;
 	u16			dhchap_status;
-	int			dhchap_step;
+	u16			dhchap_step;
 	u8			*dhchap_c1;
 	u8			*dhchap_c2;
 	u32			dhchap_s1;
-- 
2.40.0


