Return-Path: <SRS0=+tAy=ON=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B27C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Sep 2021 10:18:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1F0B60EFF
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Sep 2021 10:18:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E1F0B60EFF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=QPmjW2vucSUOEQBkEzWu+MXBzZF+Gx62pnegbcmIIUI=; b=zRGVMZCL7kxWR1
	nUgTJTN9qHfb0kd17oKAMUH53G+JzFHKjSLRMHqxpCKAhqmR2s3541tLvNPTvGN9kOJQqJ3uy1V68
	I+n/cQ8nIG8+M9DM5T4nj/s73K3AVL27Y3slXG+CEVzTNE2X6tXrdJoXbrlNhWlryR/FNTeIEYZb1
	dW9zewdqiJrxYQVUGNaCNMXY8gWd/Y8VCDKOhgojtcVAxCepLSuYOlGL8KiAbbvYLc/C0cuUWuw/u
	SylLNYQttqolqMhWNqqldRDRRgNl3Y6I810WM/rIEwbEaHl/w52w3jstQwpMo//CI4EsKLwfbPcQ8
	yId1jiSbYMwdukovGvCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mTLne-00At08-KI; Thu, 23 Sep 2021 10:17:54 +0000
Received: from mail-dm6nam10on2052.outbound.protection.outlook.com
 ([40.107.93.52] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mTLnb-00Aszn-I9
 for linux-nvme@lists.infradead.org; Thu, 23 Sep 2021 10:17:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JgaK5wOd757sY9wEvy2IB12Mvl7I2KFuNqaOWUAvkBGl6sF4C7SCMYjICNVbPnBJpM3GfGHAkwP/Dh48nU5jZNguB6tmnfVocvib7sY6gKrze2yNnOoR3S0P3Z6OcfRzbCqt28xOy1d7Q9uG5qeYWk3hRoGFRqtSSo8wCjTq3ZUY7O9aQjlr39wl7l3u6o1Xo8dhGO2d+ddBMrFUWSwD27MESzyhhxTB+xfDpW5nRkfj2AvsONksp2kxSVDi1zRV2luT5vHTTBBi9rEkHWbqDrEzyvGdRf2vpWSBhPdrp8u3km0MLdgnGyu0tt/9gdv3F63cagWsmapd0TXoWqLXNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=3URZozo8edaVO4879mInRd0Ozuncq49pCRlce0y0/bI=;
 b=IvOKTTBUoFrM4Hditmi8eC4ELc5qbVstAwA9npPbY3rRcyDpwMyVgEoQ9XPgKeNild3jfZJ+Iiv4X9hIzoSoI1ZVzgI1Lb8zKHgkXTDNUxvXjPi0DT15vQ0FdEAds5Wcqp98J6wZJBt6dNJSjb+SOJHgDNm2QmuxQJzxzkhCVDIWqDMrNszNTM6p+0MeXRVkhs4S0EwmV8DuDkLidvo73iFY89HP35tHECCa8elkf0H+wqgnd+xMm9YhMVMhnQSDlzU2L6p1duq4htWplaF+FuDqprI8BvABzKV94nscT2QVUESKF2lF0QF9PxgCopGdIZtPvPMoXdugzljBuEBN/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3URZozo8edaVO4879mInRd0Ozuncq49pCRlce0y0/bI=;
 b=Vd/XXqJI6f2NRiFTa/kPsK0jhhw/YQC+Bht1Xve5F8fiob+fZtLRRDpHgxPlTzefPD2G0Uoex2LVLpL1YOgH74CBpqKFeHjteQpTPoA+Tag/ine8zL3JDuyY6L4Ffwjnjy3O2FbVp0UKvrJtuL1RkvwPU3GhdnVEnJQu1olb54GHpbh4JNDhJGRC0qwNfYtnt9ytPUaGmVoLV0nh27OBaLHIcIxgQiAv+ynXTnshlWpU8R5ss2AYjg7zCFRiWmFf3GNKzj9m7PZRT9U50Rxq9HGh7j/j14e6Mt0w1hv9DMn+UdAvY0pNSS9YhVl43oxtyE8jeNjco/DDyp3XbyLqAw==
Received: from DS7PR03CA0056.namprd03.prod.outlook.com (2603:10b6:5:3b5::31)
 by BL0PR12MB5011.namprd12.prod.outlook.com (2603:10b6:208:1c9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 23 Sep
 2021 10:17:48 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::79) by DS7PR03CA0056.outlook.office365.com
 (2603:10b6:5:3b5::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend
 Transport; Thu, 23 Sep 2021 10:17:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 10:17:48 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 23 Sep
 2021 10:17:47 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 23 Sep
 2021 10:17:47 +0000
Received: from r-arch-stor02.mtr.labs.mlnx (172.20.187.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 23 Sep 2021 10:17:45 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <kbusch@kernel.org>,
 <sagi@grimberg.me>, <chaitanyak@nvidia.com>
CC: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 1/2] nvmet: use macro definition for setting nmic value
Date: Thu, 23 Sep 2021 13:17:43 +0300
Message-ID: <20210923101744.4204-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f6e6590-2dc1-40e0-4aa9-08d97e7b6494
X-MS-TrafficTypeDiagnostic: BL0PR12MB5011:
X-Microsoft-Antispam-PRVS: <BL0PR12MB501131C6ABB4ACA1DC13579BDEA39@BL0PR12MB5011.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kgOg57g5h1qi+XQD5iJ4ayTXZgt+WZTOPyVYAIBKcDxik7lUZN8R71C/6Ze67JR7vFR+0MWDtgXgxrFlQALDVHt+uTWy/01LRsDKOYzc2mqxmgE81SptCi9Dmm+G5OQRHdEWvw1CnTdlORIvCy0MpIBaa8kbbTZ5BOhw/G93YgyQKAx1+HPqkJ5/eaFrH7s5oT1ElVfMAFA2EsSC0mXaUUWF1svHvezQE2eFmiZmGgeavNs9C8xt41XdhseVVQ/WS7Jcj+43fdK5xK5YjoEW5w2qUPfFAWHLJLAjnIHIrBtXuk62kqsdcLjFn0GShesugJVNGakBgxmaO0bdMSSLEmDntD1OfeEW6RulQBRMDB5p6XRhKF0TiGl5IFJuf1D27/VQJMdLVMhPOGYMKQBaJlA9E3v72CWr2zCLoHMDM7KOL7LRvrtoYB9+TFYkVpAd7x7CmpkeAUtWQAqSLpQQdtgA4WBDc9tthCXVVFOu8IoJW7B38TQ51aX4y4FGV3qpvCDM8AvngvE1YGavrUy1C4dcViVxjtRhm4rQbXvvwNLrazXJQx8GAWrjPTonPu4sPNOF0h61gCArK3eBTutxSNZHC2E4AmkK8/xzmDGw5lZ5u2hU+z0AgsDItdJtxzY4mfVBxHh7JmW9+8lKYPT5GYHDezOHRhEqmBUkAvBG4+eMunJKMEaA0VqSy1mmXV3yVnwl1l0+hgD59OqlB6WwjA==
X-Forefront-Antispam-Report: CIP:216.228.112.35; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid02.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(70586007)(107886003)(36906005)(316002)(70206006)(5660300002)(6636002)(8936002)(4326008)(110136005)(4744005)(36860700001)(186003)(356005)(36756003)(47076005)(508600001)(426003)(8676002)(1076003)(26005)(2616005)(86362001)(7636003)(336012)(83380400001)(82310400003)(2906002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 10:17:48.1953 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6e6590-2dc1-40e0-4aa9-08d97e7b6494
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.35];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5011
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210923_031751_843908_6A1BDBBC 
X-CRM114-Status: UNSURE (   8.98  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This makes the code more readable.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/target/admin-cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index aa6d84d8848e..4ee9fe134697 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -536,7 +536,7 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 	 * Our namespace might always be shared.  Not just with other
 	 * controllers, but also with any other user of the block device.
 	 */
-	id->nmic = (1 << 0);
+	id->nmic = NVME_NS_NMIC_SHARED;
 	id->anagrpid = cpu_to_le32(req->ns->anagrpid);
 
 	memcpy(&id->nguid, &req->ns->nguid, sizeof(id->nguid));
-- 
2.18.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
