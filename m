Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBAA5C77B61
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Apr 2023 08:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6d/jQdcUAddiNhZ1u0RrcMbvW3L/zQUGNZ+5EkxHmlo=; b=wZLi7ZCW1pHXqOCp7QB1swm2Nl
	svFQm0K+G6+IfL7+vwEJuDzXmtOTV1DecwpAVxodrYaH8hJEWIfP3WcQWv9b8Q/bjISgxzCfdPJ+T
	P8ENG1W/bfOZnf3mK4XaP69CEjSUp8mib6Ljaj2qNOWAjRqVY3oAov0KF6p6oQ/wjZtBjzqhA3Nft
	4qhw8+aCmAtzHccxcAq1702F5I4oDokTSgh6wwRi3cXornYX6BgctBZtukWeGPev6+jT8QF2lR6Wp
	hHMp0znxwOm/+x1IqL0Q3M6D5y2wDslbSPRN/25ml69oGjnLyvEXh0gFlDC5a4ej1yRyXewOWBSIB
	g5JnI7FA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1prwdO-005lda-1g;
	Thu, 27 Apr 2023 08:05:46 +0000
Received: from mail-dm6nam04on20615.outbound.protection.outlook.com ([2a01:111:f400:7e8b::615] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1prwdM-005lZH-0r
	for linux-nvme@lists.infradead.org;
	Thu, 27 Apr 2023 08:05:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdE6ZMplUd/IP+y9i/bbi7bg8Xq/AwGX6qtedKbKOBeITfpAD9sjeWhHDLsJKoE8UUKLaR2EAKLK3JS/oRo7JD/PewDaWiHotk9LhrjY7BiM/e0xFVXYNcFdgOJbOAKLffFXQxg2utNi+zmYoqgJX+RxukFgMVVmOGlP58Gl/IOuD6RVMdZG4UE3zqV4vXe9YJHeA22/JMpmL1LQo0Hn5+v0/i0TEp9/WpApke9RtytwLTjOynSghzv+Sr9w26hQsFR/ghtHIEsVnHSI/azZFvz3G6RD+38f8YvX3gyQIaiQyW0b26lu3sTopNQtv6SufYxCMi8GtRgL7e6UtDvyzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6d/jQdcUAddiNhZ1u0RrcMbvW3L/zQUGNZ+5EkxHmlo=;
 b=g2Feu9HmoPTTZ86OMGY1qg8nxdqjrJQIT4kcQJ8N4zEw9wxcKA9EMG/NYluN6/Tj7cIqqAUM+ghaChdOXBBxVm4YpLeY3+f2UgLkD4SrDG+8Yl8cbCGFyoo2M30Zo152mCX9XHVtiu8CTaNKj5+mc9spc+kDnoxjh8yfCNJlcWYIAFnc+CLB7yhDR613YDHbQVetYs5vdA9FDlTE75TWzoqBtU8Hk8dW635CZv5C/79d/vLLfijy0l/11x908B3blisUXIc4hIg/JBznWnYwkxEfiX+N2ygMdo6ZTFcjsy5j4gPRGhbZiDe+BgAGg45c+/wB7thJ/7EqH4xKYh6q/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=suse.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6d/jQdcUAddiNhZ1u0RrcMbvW3L/zQUGNZ+5EkxHmlo=;
 b=coTS2FnbbWH/uhsUu/krOLSGRUwByVpJ/SW4Roakx1RvxjYYaH0LWA8foSYXcXeyUPu6dcEof0wzBN3RiGbQVWPTW/zLQ1s+LK4WNfaHZ4tHdXTqPHlwR8wF139KHlnBiIKEnR+1JgIPhjUB6TMXvCYNCjR+uHnAUhz2FkgZsrfw8KPeM8lqqHHxsjF/V1zLNoidbSA/WI5hzKngDLs/FDI/n4HNvyzJSXi/VoEAza8F54e47YvRJl8/AMZtWXYJVbTVQ7nMGLhdI3F8H7GV57ldeVeD2/CuLnIIfJkySYZ1K1m2NJNySLUCAL4HWlzleIKzj2LYCM+HPmGOiRH0/Q==
Received: from BL0PR02CA0078.namprd02.prod.outlook.com (2603:10b6:208:51::19)
 by BY5PR12MB5510.namprd12.prod.outlook.com (2603:10b6:a03:1d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 08:05:29 +0000
Received: from BL02EPF0000C409.namprd05.prod.outlook.com
 (2603:10b6:208:51:cafe::d8) by BL0PR02CA0078.outlook.office365.com
 (2603:10b6:208:51::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21 via Frontend
 Transport; Thu, 27 Apr 2023 08:05:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0000C409.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.16 via Frontend Transport; Thu, 27 Apr 2023 08:05:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Apr 2023
 01:05:15 -0700
Received: from dev.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 27 Apr
 2023 01:05:14 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <hare@suse.de>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 2/2] nvme-core: fix memory leak in dhchap_ctrl_secret
Date: Thu, 27 Apr 2023 01:04:56 -0700
Message-ID: <20230427080456.18232-2-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230427080456.18232-1-kch@nvidia.com>
References: <20230427080456.18232-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C409:EE_|BY5PR12MB5510:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b6a1d9b-286c-4a4a-1473-08db46f62a58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	ImHY1x1wOZzP3wq1VRGAM5HJX+L5w6R2YK/NHex68e/e83NrfoN+AGEL5/VNTtMGI/LkHqY0jy08RXzrtHpyWSXPn5Q4LJ+SVGqeNGNildOQ7jPTC50iGUI/w9qznuDextVVG/CRcwa/Tocop1bxOI/J+dPKSzC8L4CLRGxVdjm2SdG1FqxfL7I+/hu4GkbrJNoRuXRi/66BjqzF5NyzaHYdzRRsOJ6qPJR3LGBwzNe5XqT66uE0p0vgHXyAG1NfXkJbwblPb4Q+Sf0P0R6Rpurb0op/si9CgMDrPqQgUMjZctxzHHgY/Gl9jq/BqjJzHY0d0N/9FSROLNu+r4rTLCchI2GU5Kx4KWXe5Jz8ehOpNvciaZsD2O6N9b8HY/KuQ6k38PMJkuoiziJRnK5iTceeS7wkx7pSfNIg+d3qug7uEtMHIIlVJxEUJmJa8xBYDcUpTMZeywFo3wwKePDQ+Uej10otXq8Nqxa6l0OXcUraIuJb9VJw5cDiUBsc1wihjc+lTZV8eLO3zueXa8EIyxY4OX6XvuEa96lhhfz1JoQ+UGRPQf/NVk/PDkAR5p9q7ea9WhU06+obBir4yHjl/BKqAG78iN2yutJkEjKxILHY2crReJyUX/KBGBegOl7wrm+HlyAz/cT8a5WopRbyvxNBux/VSCwUjUtAlNpDK4sBfVVi7XN0pzecC3HHleo8AfNUe2nP7nrSdgpk0xzsEsAs0jkk0Vn0PeI5X7+E+AU=
X-Forefront-Antispam-Report: 	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199021)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(6916009)(4326008)(70586007)(70206006)(478600001)(54906003)(356005)(82740400003)(8676002)(8936002)(7636003)(5660300002)(41300700001)(316002)(2616005)(16526019)(47076005)(336012)(426003)(186003)(83380400001)(36860700001)(6666004)(7696005)(107886003)(1076003)(26005)(36756003)(82310400005)(4744005)(2906002)(219293001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 08:05:28.7496
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b6a1d9b-286c-4a4a-1473-08db46f62a58
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	BL02EPF0000C409.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5510
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230427_010544_307319_988DEFF0 
X-CRM114-Status: GOOD (  10.15  )
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

Free dhchap_secret in nvme_ctrl_dhchap_ctrl_secret_store() before we
return when nvme_auth_generate_key() returns error.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5a9d97c0c0c1..44408c0c1762 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3870,8 +3870,10 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 		int ret;
 
 		ret = nvme_auth_generate_key(dhchap_secret, &key);
-		if (ret)
+		if (ret) {
+			kfree(dhchap_secret);
 			return ret;
+		}
 		kfree(opts->dhchap_ctrl_secret);
 		opts->dhchap_ctrl_secret = dhchap_secret;
 		ctrl_key = ctrl->ctrl_key;
-- 
2.40.0


