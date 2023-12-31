Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD568C46CD2
	for <linux-nvme@archiver.kernel.org>; Sun, 31 Dec 2023 00:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HC+ZZ/7kh5fsh+ps8dhRqrolwZeMH8UcY95aA1c5tWs=; b=2mKLJ+EYW+NO3meGr7DkCa4Rns
	9kKeXtS5YlQLEImOYlOZiRA7mjdyORxVoQGiFQxZt0Ftds48nuOCxu/9/IBhEPkwRzVBTdLrmh5GC
	1UqzzFysipDoIQKvU832eVeg5Mx7lSBZyq+6pbnuwlkK2S/i1xXC4UnNSR2UxE9R7P03ymw4fAVxG
	ig7lMecqv2l17MQ2xYFAPF/s0KbsPL8tjy2YBl48fu6Tog8a6eZPokPgXeJ9EOOt7+o9WlAf3Afh6
	2RKxvi7MZ9Wegnxx+QeVQmGjFqcLrsG5tAEGhA2Iwms/UsqQLH8NhpfB56emj8gMPezKX+lHhfgtx
	GcQrn6BA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rJk4r-003fzU-2W;
	Sun, 31 Dec 2023 00:53:17 +0000
Received: from mail-co1nam11on20601.outbound.protection.outlook.com ([2a01:111:f403:2416::601] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rJk4m-003fy2-0R
	for linux-nvme@lists.infradead.org;
	Sun, 31 Dec 2023 00:53:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYdhRvnA1vLRZMHcptkxgYLIB7/78r6NDL//fajYU9eqzvaykpjQvm68Fw0Vaaw42K6GvcuYkNlgzI+2YTBPb7Yt+5kwO9IJdBxRbCVsI9YtDllYqELEOczUqCPaEZb+zaMV13ncfsEyYEu4LWcGD+l6rNxQtUXRPiv1CMTzIm4oTHLPbcEXTNbqV5JtEXquxCr10d8Jpiu8hFNhnJ6aojfTYT0xpY+Zih1O+72PEZh3peOk+pEPwt2FCEt8cQ2VaFNat1kyU2ejq2u4C6N3k0kN99GIZ5aMTrWyR7n+jgTp1innuYT3qPpEPY0eAzWFxe5iayLuiUGrqh8TCZxXHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HC+ZZ/7kh5fsh+ps8dhRqrolwZeMH8UcY95aA1c5tWs=;
 b=Nkq+shpLQ7KAGzlWPVapXh8y2CpFf0bIeBUQAD2zRQgCanvsm+6nWexBeutH6T38C+Ko6WfoUIBjFjJCdeiEqpOmCdAmOS2wAdG4yNvxLC1DV6UWXxVzMo8HBuLt7/N3LtGe1Z83GvyroFAeHcpj0HN+d3HQ0jOvpxPVT5wecItwLWGNVGtE+iqtJcRTuGUgzg/MnRNZ/hnmnAM7WKHGIvsoQqAkEfhZ2N+86pFh4eev3SOWzlzVInu9TysNOuBhJDR9l2JjCYBb+uEirjNjtwWJRemo33n7F393hq1hgoE0okigc49nl8SVTu+eC7VeEC4b2S/GOwLlyeRK/jjWRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HC+ZZ/7kh5fsh+ps8dhRqrolwZeMH8UcY95aA1c5tWs=;
 b=kfyHif/AD1/k2L2Mb25sH7IpI+JAFhvP67vevGbbEcshU2fW2O1n0zU8GT1UiSHWxkHt5EK+FhQIw+Fs7STn9UxwpHQGsh7pYA7JsOPJ7Gl2hAcP0UWWXT4FKkgZwYzaGvQ6Xhm6/a5wc4mWfzVT1h/MZZXy2zT4OUsMHYxAUj+4EJYbUkfckwS0itpPEYA0nIcH9Kr5aTKt0C5BHKBmaLnMZ1OEW602fcuMdL+FfDVoeI1OMHSE5LVZjbY4XwugQWy4c0x8BeDtiRMgdxkhDcoVB5AJhkchwgPpp7cralKdmaDYluh6iVzzi8Od/fDl7UYiANWEgIE9l1AUIaamKw==
Received: from SJ0PR05CA0133.namprd05.prod.outlook.com (2603:10b6:a03:33d::18)
 by PH0PR12MB7093.namprd12.prod.outlook.com (2603:10b6:510:21d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.23; Sun, 31 Dec
 2023 00:52:57 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:a03:33d:cafe::d4) by SJ0PR05CA0133.outlook.office365.com
 (2603:10b6:a03:33d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.8 via Frontend
 Transport; Sun, 31 Dec 2023 00:52:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Sun, 31 Dec 2023 00:52:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 30 Dec
 2023 16:52:55 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 30 Dec
 2023 16:52:55 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Sat, 30 Dec 2023 16:52:52 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>
CC: <kanie@linux.alibaba.com>, <oren@nvidia.com>, <israelr@nvidia.com>,
	<kch@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 01/10] nvme: remove unused definition
Date: Sun, 31 Dec 2023 02:52:40 +0200
Message-ID: <20231231005249.18294-2-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20231231005249.18294-1-mgurtovoy@nvidia.com>
References: <20231231005249.18294-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|PH0PR12MB7093:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f5ad0be-a988-46a5-031d-08dc099ad465
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BIVtziApfPWD3FJdAxwDPzQd40e+bGo5tHb+mNU5xiXic8O1X1fSLRJ9vk9jbDHCcEEZdvd9UsGYYCqTMlfccl/AUN1NLvQGF3P0Du01/9iZZycOQ6SdozdsTY+ZalYLfnUeDnHJFsfTyv0TFrjNe2uUerx79M1MiYq50pR4Q+NpXbFx03SqSodR60G2RJd81A1NDBlosERzZqLBSNbp6XhesisRLQHw7wySAZz8af/5Hbopu6ZECAAaH77zbgs2hQAUwRIEdKLfM7eg3MYl5fxdOImHH0OJUVa4t2rthsPc+0fLkJRh0X8CgtcQBI+vYSmXEAkQyG1l1arKm20fAMbvTIykP1Ss+971lTywsbLdf5DzhwcXt7DDbTvot44gXChRzU/UP7TpoDB2C1UvgIbSp42DNJz7eYA0ngT1Ef6fLuONLXJtpdzV1RWVKTHn7SG0EGXsh2dLklD/m5x4MCvXLuQWbA1DNpWpfp4h94lcdR5Tf9b4ZBTRuMyU/7bMgUkFJYUKrbo5nPLtuuwIx1Q+u3k0MTepIoDqk/7A2G0Zl9HAPHZCazb8HhmP/GxZroZenXRuwIxNxyFG4S48i9kmwgRamTUbXARYhdonfeVmhRZV886LVRoDjVOa5pVnUuSV6Wlga0mfjVk1LoFbPjVKFJFtMi3Qxw1Kv37j7e/7LAHKHlUVjXUGYVguRBb58IQsRDTUS96wv+KX/kfzgGzQtLkkHu/AnY9RnjunXwtJ9zGDnUG0eLDxyqscg3nc
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(82310400011)(186009)(46966006)(36840700001)(40470700004)(82740400003)(7636003)(356005)(36756003)(40460700003)(40480700001)(86362001)(6666004)(336012)(426003)(478600001)(83380400001)(47076005)(4326008)(36860700001)(70586007)(70206006)(1076003)(26005)(107886003)(316002)(54906003)(110136005)(8936002)(8676002)(2616005)(41300700001)(2906002)(4744005)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2023 00:52:57.1208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f5ad0be-a988-46a5-031d-08dc099ad465
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7093
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231230_165312_174562_C7760A46 
X-CRM114-Status: UNSURE (   7.99  )
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

There is no users for NVMF_AUTH_HASH_LEN macro.

Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 include/linux/nvme.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 44325c068b6a..462c21e0e417 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -20,7 +20,6 @@
 #define NVMF_TRSVCID_SIZE	32
 #define NVMF_TRADDR_SIZE	256
 #define NVMF_TSAS_SIZE		256
-#define NVMF_AUTH_HASH_LEN	64
 
 #define NVME_DISC_SUBSYS_NAME	"nqn.2014-08.org.nvmexpress.discovery"
 
-- 
2.18.1


