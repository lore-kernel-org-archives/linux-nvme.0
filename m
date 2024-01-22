Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF72C47DDB
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jan 2024 14:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OGLrQ3pfwZQXd0fYsrssv6HEmCIA+yH0QdEkCAeRPD8=; b=YGmPxp3BDY60ABadozl0rH4fkn
	NlMicBLuQ8aoPn+cMZxAowCd3ivd+E0V0xbmdJKc9RNR0ljLk+PqRE3D0GUypvfW3jkICtUQ/GB+0
	xUOckcpc28dJdwPa+27QhZ1rzihwOhAI29wCPjpTwa/1cFzeYYr1cFnjk7Adhy9rrRBHvsOqPR8WC
	XACpA1tI3AK9sWVWXU+ibEVSGgPEYPG0RDSykru1MVpd4Z+G+/9GJ1syluiZpKteHCreS3aDfQj2Y
	96avl2nTWfNeCVza+p/q9ks6pLjfjj11rcaDe1T3SaMND++J/vdz4LL4599yAwEl2OTcpQJ5ATWE8
	viuLAyKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRvkE-00CVpn-2W;
	Mon, 22 Jan 2024 14:57:50 +0000
Received: from mail-mw2nam12on2079.outbound.protection.outlook.com ([40.107.244.79] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rRvk9-00CVkv-11
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jan 2024 14:57:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ICepIxM5m8eKWhm6w9QOzDCD8vii1OS7ShIH/abqylfxuieNwAR9MSLp8YZ7k5jkMiNklLfcHYnZ5UwCWzIHiA9s5JxArealvOJ3pmsX8FsYBvvJDF0FzQ2tJ9heTodkodNkf4A9sJA7aqTDvD93YnjXF8YhU2MwFE9x4PLoAHsW1Okc7Z1gSOEru9apZIOcTEvCB5XJKAA6jC0avsiCUbBDQ9CSvB/d6taHwbuy9Z2s/EfKWZw/poBl8vdkkLsdugFrd5jp7Cu8cJzrK+MJVtRuBnFzfOLu0/OhKWD+1Gq5CbnBg7NgByMMah25fqlwvt/rzhLmyvo4fTicZNO/AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OGLrQ3pfwZQXd0fYsrssv6HEmCIA+yH0QdEkCAeRPD8=;
 b=kFWXpSaig6nINRFI8H+FsCQs11zTo4jCTqpvFYHhzMnmYen9KN1lB4xa/nZarGumD2c3fDp2zMY2KCO422fkA2CQ6CR3Uu6LoSeyPGvd0GMGjG3JebGHQ/q7Pm7zc8hMTUiR3fvHjFCgmvfpVSdSTiO5L3dIhae3y16XAVhje/fc2F9UTt6yj4R1bfRyyoEg6OjHE+/vjj9wGSOjyaZX/ISLzn9u5W8aTAnEZ6vvK/DaO/lxiKytvDvh5QBJNRSjxpbZiTcVxebjnhD4JsApW5j52Gk6vTgV9uUqENCE+3GVh8mYs+P0qR23qnOG7/nCwYjmfqy3mLjESSBfhhWZPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGLrQ3pfwZQXd0fYsrssv6HEmCIA+yH0QdEkCAeRPD8=;
 b=a6qrCTqBanVvLadiSyeUFtg0S7ouMcQiHOazgGcXwLK27H0vLMrwcOnRlKKXABJfBnocMQbcb1Sn/3wi3VvUb4gnewsugq8V1y3sMtFW9M9KivulyRerNqyV0NeECIk/kB6ZM+dVpigXbO/51n/ihlhPbea/ou7uHn3NO/XBMKrcL5xbnE/p/hf9HTlXOk8A7QLnWOGvX2T2DXM3Zo6cQrKEW+71Llc5CjsJiMX5gmJl19Tr2f7F9Ve3aySZmmHCdUR+XwQ37skTKRyHvykuTF+pmGZxm7m/0dWyUY4tW4VlP0gFoRe4i9JWTjmM3NGRJuPfsi9PsGo14ORowy0sgQ==
Received: from CY5PR15CA0095.namprd15.prod.outlook.com (2603:10b6:930:7::17)
 by DS7PR12MB6024.namprd12.prod.outlook.com (2603:10b6:8:84::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 14:57:33 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:7:cafe::f1) by CY5PR15CA0095.outlook.office365.com
 (2603:10b6:930:7::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32 via Frontend
 Transport; Mon, 22 Jan 2024 14:57:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Mon, 22 Jan 2024 14:57:33 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 22 Jan
 2024 06:57:11 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 22 Jan 2024 06:57:11 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 22 Jan 2024 06:57:08 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>
CC: <oren@nvidia.com>, <israelr@nvidia.com>, <dwagner@suse.de>,
	<oevron@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 3/8] nvme: allocate a new namespace if validation fail
Date: Mon, 22 Jan 2024 16:56:54 +0200
Message-ID: <20240122145659.5574-4-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20240122145659.5574-1-mgurtovoy@nvidia.com>
References: <20240122145659.5574-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|DS7PR12MB6024:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f13f3ea-0cfa-4b89-1df1-08dc1b5a76d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +XH8xhkia7RhASm1kpsGfFkIpsLn+BaciE67OTSLUlBHKw22XYIuQHFy/yuwIXkYFJdRy6I/i23vUEw14yEkGyOJtX78rYM1365oPudvV2VGjBHM1ZaUVlKIo0NFPdo/QZj4/qS5TJyztvw/uDWelGpdD/Ri8X23r9cBbCR1CbOKOFRBxEWA70suVFe/Hlaour6S8p2/FQQGBa5i4yiUX3Eq9D9GkB9vi0v4M6NRIlGhAllBy5dh3cp7Lh5lYTrv1+buAjrTGb/mKXFBo8cOEgV8GhmO7xnOLer1yAu8ZE1hcOZ0SDJRZDmXrUikW6XvdR0TBu2ki3N2JNqcrKUTWd2zdob3LCq1kQlY31ObnK2RjilS2UnXcNzCFRMOl2ae5KXzvDE+HfqMjMqdzBrW+NOZrDYZ7nFEmfdRI1r5KXcT5EY03FLpalv8/rVEBeX+MwstYhHhGcX97aGeze7ULU7ZbCk7+nOaHf1DD91E8iea+dMw3Z2QzhR3ZptVccxpDJRGP5i9u+Mg52+bxztAMFIA9vjSXUmyg1ET85yCTIorCIJv1t7RqGE3W2UFR/cJ9gbT5wpFR0S/y+tw1auz1iLQDjYkoz4p7r+J/CyWJ4No9CizQE+k3lm4uWps7/Phj/XlDlKJ8De3zYAIQqiF7QyZuO6Hib3ZX3q05xW0aJSIvTPUj4U1Pmy+Thm9Oe9vu33TmLtEt80ge4wm8/aelNqMZTtO8NUqyYdbVEa8p/v3hxIfwIdWeCAuuRu0pWeH
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(1800799012)(186009)(82310400011)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(8676002)(8936002)(5660300002)(36756003)(2906002)(40480700001)(40460700003)(4326008)(316002)(54906003)(86362001)(36860700001)(41300700001)(110136005)(70206006)(70586007)(47076005)(82740400003)(356005)(7636003)(426003)(336012)(83380400001)(1076003)(26005)(107886003)(2616005)(478600001)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 14:57:33.3293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f13f3ea-0cfa-4b89-1df1-08dc1b5a76d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6024
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240122_065745_370749_04692A36 
X-CRM114-Status: GOOD (  15.64  )
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

Namespace validation can fail in case some of the namespace identifiers
were changed. In this case, we will give up and remove the namespace.
Add a mechanism to retry the allocation of a new namespace instance that
will be setup according to the new namespace identifiers.

Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/core.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9d46acf5b6cb..4fd3612b7570 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3857,7 +3857,14 @@ static void nvme_ns_remove_by_nsid(struct nvme_ctrl *ctrl, u32 nsid)
 	}
 }
 
-static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_info *info)
+/*
+ * Validate the namespace according to the updated namespace info.
+ * Remove the namespace from the controller in case of a mismatch with previous
+ * identifiers.
+ *
+ * Returns true if namespace was removed, false otherwise.
+ */
+static bool nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_info *info)
 {
 	int ret = NVME_SC_INVALID_NS | NVME_SC_DNR;
 
@@ -3886,10 +3893,13 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_info *info)
 	 * Only remove the namespace if we got a fatal error back from the
 	 * device, otherwise ignore the error and just move on.
 	 *
-	 * TODO: we should probably schedule a delayed retry here.
+	 * Caller should probably retry namespace allocation.
 	 */
-	if (ret > 0 && (ret & NVME_SC_DNR))
+	if (ret > 0 && (ret & NVME_SC_DNR)) {
 		nvme_ns_remove(ns);
+		return true;
+	}
+	return false;
 }
 
 static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
@@ -3930,8 +3940,10 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 	ns = nvme_find_get_ns(ctrl, nsid);
 	if (ns) {
-		nvme_validate_ns(ns, &info);
+		bool removed = nvme_validate_ns(ns, &info);
 		nvme_put_ns(ns);
+		if (removed)
+			nvme_alloc_ns(ctrl, &info);
 	} else {
 		nvme_alloc_ns(ctrl, &info);
 	}
-- 
2.18.1


