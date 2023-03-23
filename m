Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3126C6FD1F
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 03:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hWgT++S0RV7+hrqmcSigocrngI7ckLPvSuZpNFOZQX0=; b=OdkJP3DeZ5Hm07pTAk29Ti6viQ
	NRLfi8iNRh1zEFLzqUZbS2HLMXVEnmZ5JKp2qY0qr67Pi4RLJiGcM4zFVQbnFOdOr7R6WTlDCpl+x
	Yhe8v+AfhWXCozZMwLwIUqxH+SFw3B0lL0bGcbNSu0jq1ZjvpYaLq3Zu//cKlEyloXuSCg0ubJ6rl
	aMDp03J37EYtoUJ3nO74LL+W/dCa08Nt6usJxjcAgriPQQc83pAuaV1OmEeYbg1kLaQlpBgXeanyx
	2kW8hp2K3iJ+6YjuVG60Zjxrl7X5GnjRirjvS7I3u2x1PflkKJjN3G/OAr1bShEnvN6vhOAn5FvWK
	P+fxprHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfBlf-000e0e-2J;
	Thu, 23 Mar 2023 03:37:35 +0000
Received: from mail-bn7nam10on20600.outbound.protection.outlook.com ([2a01:111:f400:7e8a::600] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfBlc-000dyQ-28
	for linux-nvme@lists.infradead.org;
	Thu, 23 Mar 2023 03:37:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPOSaTBEC4RBbCxvAxnC7PCUbYMX969xm+2f9cAsorunbAaKDBj8yxVzNuIJHROntf3hojPr+UwS9TVKmFm8MVjqYXXVl2aoFlwS7uf1Dj7lM7cgXeyzJP9T+FD2KFWoe+cA5CTnVhP4ZGEtDe1BW2d4PTe36sQS44HCeTpJHrrGdolGGxpuXO5TxoSbAAzFJKcNIUo16RYHWScs2dt4HgEwFFz/hPwjTkYEk/Nt+b3eLdkePUL0jh17EfTUdcp9dE1Veb4LJxyKVKHIvyrjV+0ZJDAt9D2FT0sBz18HX+8/x76qrgL8SlBmYHuA9TVyrldbP+r8nId4AwG0o9e9pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWgT++S0RV7+hrqmcSigocrngI7ckLPvSuZpNFOZQX0=;
 b=VXqCHOJPL4IbON/q22skTUnAOlqrAYEGp0E+nJymiKfifZxEL/lnWMEooMSzi6RM0sA86TWC20EAEjmEKstdDBcROyy9+GfnLWIUpZlzsWbenMGSM6LIGxfKRhxTfCCd2qC9ahgvfOm0oFruDDUcq004XyDYfWO9PxwN+Hl0QL+G80hnVk0Xk7/xS1wa7yOwAekxl0JBDnkBWLGry6jg9G/jEX/TGrp/aoUW0UB3M7ETtq585r19u078Bk6MJ1ZWBGRMkDFAEEaW1bHcAU5QUz3Oq/rR0sPu74jPRKFmjnGSsWph71f7FQhAWYOiwqFm//9Ta3/UzmMpo3ljzMj9ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWgT++S0RV7+hrqmcSigocrngI7ckLPvSuZpNFOZQX0=;
 b=gNoUIkwClmUcxOWgInreojodHfYNMmG7nQwWweY/KTdVSCYh6vlVK0Jz1T1K2KQP8fbExhZLlcj5+AE17Pbj1Y02M1xO7NfApSUY6Qgeg221rC6GYj8m+G+j//s4fsi5RnT6IwSxFJLKIHLlNvR1uIJ7vvbZqnAVCSIDYUpYEP3ogtQamRhJTTgoxDQ0rEIaucuBx9Gm3WTHU6e4OGi21MAfI6gjT9VTZRnYaOnKQpe/Bl1pdDFW9/R4WKvSaTxn2odiMuaezLJBGV4oikxpx/HA/Leyv0Fgn+PNJY0oq5jtU/BYFG/kSugAF9HjxPPvUYuacUlejz3PcItR8B9NOw==
Received: from DM6PR10CA0024.namprd10.prod.outlook.com (2603:10b6:5:60::37) by
 SA1PR12MB7293.namprd12.prod.outlook.com (2603:10b6:806:2b9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Thu, 23 Mar 2023 03:37:26 +0000
Received: from DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::9) by DM6PR10CA0024.outlook.office365.com
 (2603:10b6:5:60::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 03:37:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT079.mail.protection.outlook.com (10.13.173.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 03:37:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 22 Mar 2023
 20:37:17 -0700
Received: from zion.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 22 Mar
 2023 20:37:16 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 3/9] nvme-core: remvoe extra line at end of function
Date: Wed, 22 Mar 2023 20:36:30 -0700
Message-ID: <20230323033636.812758-4-kch@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230323033636.812758-1-kch@nvidia.com>
References: <20230323033636.812758-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT079:EE_|SA1PR12MB7293:EE_
X-MS-Office365-Filtering-Correlation-Id: 68cb15a0-63fc-4bc2-8332-08db2b4febad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	vvNznW/jVji/gu4gQurXzp/xpuk4mP2XTf7y3WqmmqXN3EdRAsSUemYOAo/BsfnyO1ACitVq/r3mPACUj4lvJUgloeBAF7NvEKC7RI7xJiB3O+1bMur3Qhr5vJk2cVivOf9Q23uJeOQvRdr14vvlWhFt5+oqLfLIczH49BB0ES9WCyUE7Jw6BxsVmFX+2Zc6KYD9GcYySAqgeVKb7A6ky/0JaVJlBU+N6VH6kE7H0eU3PVeHpVZl9khrSCUWZHERUbxDHjw2pktcgtHcrJe/+TgkIpff8f0t+Rmy2b/KxEloCEogQAHm+Bd2HJY1E2bn5vLCHgyX20hL8TO5OpR7srEvhtdg6AJvwMtFu4OAhhuXG1NskIhFEYVQ1w4lDUFkJToM64XSKvs+66dPv0AhuJvsFM/Vqt7XXuA1Y9c4Wh/WaIy1oeVycJ4lm509QaEUVKh32xt66pDnCz6U4Ph1nPmwfJcgmZp8PiRWPryj8QDB5a1EaOQbb3sfWkEIXIcpI9qI6c34muHksgRnu4qyDILSBCvx5t7UiGrcNqJ19Qn320SdRWyXqG++WTcYLmzFGUo+hBR9nDKKDHSv6uuD6mQw6WAfShqNVB4xoIUhCXbpTBdKHNzaRZ54duWdmYZ2LYrmx1VTu/KZr8lFhRlllzJongzqgtHA6KP0eG5mSF+lVWoEscYivdPQ4wkdh67Q5ow6+iH0yy18XCa1qNMRKH9kHPJ/SWX6dOkZBPk9n8CL7XOfY+Mq97zPlVP6NW/G
X-Forefront-Antispam-Report: 	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199018)(46966006)(36840700001)(40470700004)(36860700001)(82310400005)(2616005)(16526019)(1076003)(26005)(6666004)(107886003)(336012)(426003)(4744005)(356005)(47076005)(36756003)(82740400003)(2906002)(7696005)(7636003)(5660300002)(8936002)(41300700001)(83380400001)(40460700003)(478600001)(40480700001)(186003)(54906003)(6916009)(316002)(8676002)(70586007)(70206006)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 03:37:25.7922
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68cb15a0-63fc-4bc2-8332-08db2b4febad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7293
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_203732_701701_5EDBC239 
X-CRM114-Status: UNSURE (   9.29  )
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

Remove the extra line at the end of the function.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ce516553b517..c2fb7a0eba3d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4496,7 +4496,6 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 
 	list_for_each_entry_safe(ns, next, &rm_list, list)
 		nvme_ns_remove(ns);
-
 }
 
 static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
-- 
2.29.0


