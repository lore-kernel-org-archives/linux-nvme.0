Return-Path: <SRS0=/SuC=JR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C5CC433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 09:10:20 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E39E6101E
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 09:10:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E39E6101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zWR04/3t/7jt5ytnpWYQVwibSkyDejFjrtKx8YCpJI0=; b=Lv1IlaNMBai3nGQatNKDPvELD
	030GVS/xCYPq1Dt/nOA1wtdKWzBcr6qrGpUBq+WatpcRDtz99NP4gPYrdO2yra6A5qVDELN6G9gP+
	XkVbWaz7CCyRcRiehT4p8k4i7SPw6zk6izdgwpq6y19i/MNvjjymGDnu9dpJIeA4NUM8PhtY04dPd
	fM+aTENJYu8Jair781G3DqXKdKrkDAaOZCO1/og97wD6rytUSObGzyxlJOzkTKEAA4RvCm6PA6QCP
	PQXRR0Y83OF1bzOUFF0Mb+rThcSLQ7VI4pxadCBhXu9/g0vRWVNYPVRqhMH1KUt9JGms2nENJKSfD
	O04elsUmA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYmOO-00Bfw4-4p; Tue, 20 Apr 2021 09:10:00 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYmNn-00Bfsc-Bx
 for linux-nvme@desiato.infradead.org; Tue, 20 Apr 2021 09:09:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
 :Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=uiVrWsE7liEhPQwA+g5noGV8dcR1nepdzOfdLcJZPOM=; b=5B6gMfc5n6UzOawc3cqO+68s+k
 nYTZptOH4ZVMjuq5v1/LRjdkO4XW0Tq1u5hMQk+1woO6n2g2TRDztJgbsNCUYyNfSf7ZJvxGk6xjF
 iORM0ruokktJ47iQBZNb/cbvIUv0T0KYrK0au+/O3lFVZr7vrqzIGRs9unswyLmVlGesc7QtkVePm
 mr72H9QHh6zxQDmC7RDhhm2xVFe0roUynLnyR5lIoBeUrdtfaGM/+jN2CK5b1wD7hZIWp4RErFAbd
 VDnnHpwlquVBvtVVaoAd9ISZBirMM8DddcWpvOHK9ej8yjhvjQ4zNA7Ys76aKfTMEyHZ/Bjujl847
 XerHkRQQ==;
Received: from mail-bn8nam12on2058.outbound.protection.outlook.com
 ([40.107.237.58] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYmNi-00BxO0-5G
 for linux-nvme@lists.infradead.org; Tue, 20 Apr 2021 09:09:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W18pVq/N8MGGzDMDjqpcPLamswNr16aOL6mmIUsUdJ/6n5Ihdu3obzHbfKHvKfEANXVrcxUu7+zPDMRrJnZIRUff+1Wu5PlDrzW10V4kq0UjTY6h8GjXLD4hLYyQln7jx8/Bv3YJCGxN7zE8DPq/yZJmPJT9i2+bzF86pZlCqt+xag8fKD9nHQSwPPU4yTrQ3QESdTmbXYle20nyPoz1UPxSYh4J/Bjr3DPEeEMJVmkUs0VH9Ecp8VsH5IGONcKUuOr4MBgIl080M/J/PyzkjQ3aZgokqMuvWoyncbMIbFCeWzKKTWxaOE7wM+jUCHZZRAuELox4PeV9atXnz+saFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiVrWsE7liEhPQwA+g5noGV8dcR1nepdzOfdLcJZPOM=;
 b=GJc2cFTeWxnw5aGrN1WjM/eH0Zm4Vc6o65W3aUnhNrKBn04XYz+uNkRHovHpAYOO8GnP55dxhL0Rud/8qTYnPpR/kqRU/lz5d/MEdoNWUDxn3C0eP9u8fM7gr2by1DSbIh2cHQu8p3Jq70vrOXSICQ6bigLvrHQN12IzbcckCY0a4ohnufVxKnaTDTekl5QxiYjFNjC1GvjXiHjvoFd0k9WMdn/ENUexi4fcIH5eH6IzDwwZZ0Uv7WjArJtPnaW/vrnXwQ7/OiIxF14Uei1VGvbjyS2NkShw+faVkSPnMAZivXoI2Z1039h28RgxdKJi0mj6A6TmfGcaJcLv3JFSyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiVrWsE7liEhPQwA+g5noGV8dcR1nepdzOfdLcJZPOM=;
 b=maazkUw7T/KR6LvfoUog3qJVcZYpyD9X8j1jxZEn6ncmajk0fjM3GxiftrDLVVdlLPtKqSHJc2IvEwaz3b/nBw68su/Ag8JYjFi+DMPEF1Gou4HvApin47acy1+0WqbwR/9w/J6cFiLujYTl4VKeB9T2zXRnJzPPBQJPpo6OQ9fvcDsR8c/0pA4S4su0JzZGDhsB7MGJrLjb2s9bD05ht2t2EZN+bD5TKFYu0vKIs4XVD7aAcg3D38yW6edGQ8TZOmXBQUuJsy2sQFHSApv9W32OJMBUrhgc3NEuSQMZ40lqTGqJP4WNCB8W9Wwvy3NNmZtPufyVcaO5j1AaAkr4/g==
Received: from DM6PR07CA0064.namprd07.prod.outlook.com (2603:10b6:5:74::41) by
 DM6PR12MB3001.namprd12.prod.outlook.com (2603:10b6:5:116::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16; Tue, 20 Apr 2021 09:09:15 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::82) by DM6PR07CA0064.outlook.office365.com
 (2603:10b6:5:74::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Tue, 20 Apr 2021 09:09:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4042.16 via Frontend Transport; Tue, 20 Apr 2021 09:09:14 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Apr
 2021 09:09:13 +0000
Received: from r-nvmx02.mtr.labs.mlnx (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Apr 2021 09:09:11 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <kbusch@kernel.org>, 
 <hch@lst.de>, <chaitanya.kulkarni@wdc.com>
CC: <oren@nvidia.com>, <ngottlieb@nvidia.com>, <mgurtovoy@nvidia.com>
Subject: [PATCH 4/4] nvmet: make ver stable once connection established
Date: Tue, 20 Apr 2021 09:09:03 +0000
Message-ID: <20210420090903.595664-4-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210420090903.595664-1-mgurtovoy@nvidia.com>
References: <20210420090903.595664-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76f89a06-ffa4-4241-eb43-08d903dbf7e8
X-MS-TrafficTypeDiagnostic: DM6PR12MB3001:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3001CF9E79FB68EC52E0D461DE489@DM6PR12MB3001.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 76DuqriAtjtkYYT74xRtmR4K+bcgowXsJY+0mStOQ8bYEEjmTwjf6GifjQtlFondzSXEFl/NwG4X1HTfDn1PqHib/36e4BBdlzxnzt/xrBxH5+GC/kqmc3MGStu3H/kG9OoPBYCjC+bsVIGxWLZfzfKlbJfoHhkbMvCYXuNiHzjKuM6L/aDIUzuf0g7oDuG3dN6k7O2Y+jLwcKxtKouRCFyWiHkN+EW0LEY+lESTu02TyHqQPQqVYIeeXteyp/ItWgjQ0tAt7FFse8qHk3jH9GfbdKqeKVr4QwUmel6SEJo1GpQS41FIEf2XoSzjWFzcxjBn5gbXwzmH0/3BfX2t/A49g/ixCtN8C26yDjNNekbeAi4K4A9ggEyBTlFk4MeO2Zq2sW0yg49sC5dM0mHVeiiqich814sn62oN/TvNJS8sGpwktw06ajCaae+Z3JkA7eidgVhycNLPcIingZbyVOW+8pjpuvQrhQHMmptm9jNGJcyjHLQT2FyJX8izGnXzJLTd/9XOSZyszjRb5JAewkuJi6fCEzCKPanO0e3K3SJIsuerCUy2Hbn4NEKsmkD54Gy21wpPhzONqgSwjHpUHJZv83v7ilYQWKHgHba43LFIs5O/pDC1Be2m/tLu31+UPagrGb2InOj62ExlQaMO5A==
X-Forefront-Antispam-Report: CIP:216.228.112.36; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid05.nvidia.com; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(46966006)(36840700001)(7636003)(2616005)(70206006)(426003)(54906003)(1076003)(70586007)(82740400003)(36906005)(478600001)(8936002)(107886003)(2906002)(316002)(86362001)(336012)(36756003)(5660300002)(26005)(82310400003)(8676002)(36860700001)(83380400001)(186003)(6666004)(4326008)(110136005)(356005)(47076005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 09:09:14.0544 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f89a06-ffa4-4241-eb43-08d903dbf7e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.36];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3001
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210420_020918_225408_5F851AB1 
X-CRM114-Status: GOOD (  11.54  )
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

From: Noam Gottlieb <ngottlieb@nvidia.com>

Once some host has connected to the nvmf target, make sure that the
version number is stable and cannot be changed.

Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Noam Gottlieb <ngottlieb@nvidia.com>
---
 drivers/nvme/target/configfs.c | 36 +++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 61a9a52da30d..2c7aebd4d529 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1007,13 +1007,26 @@ static ssize_t nvmet_subsys_attr_version_show(struct config_item *item,
 			NVME_MINOR(subsys->ver));
 }
 
-static ssize_t nvmet_subsys_attr_version_store(struct config_item *item,
-					       const char *page, size_t count)
+static ssize_t
+nvmet_subsys_attr_version_store_locked(struct nvmet_subsys *subsys,
+		const char *page, size_t count)
 {
-	struct nvmet_subsys *subsys = to_subsys(item);
 	int major, minor, tertiary = 0;
 	int ret;
 
+	if (subsys->subsys_discovered) {
+		if (NVME_TERTIARY(subsys->ver))
+			pr_err("Can't set version number. %llu.%llu.%llu is already assigned\n",
+			       NVME_MAJOR(subsys->ver),
+			       NVME_MINOR(subsys->ver),
+			       NVME_TERTIARY(subsys->ver));
+		else
+			pr_err("Can't set version number. %llu.%llu is already assigned\n",
+			       NVME_MAJOR(subsys->ver),
+			       NVME_MINOR(subsys->ver));
+		return -EINVAL;
+	}
+
 	/* passthru subsystems use the underlying controller's version */
 	if (nvmet_passthru_ctrl(subsys))
 		return -EINVAL;
@@ -1022,12 +1035,25 @@ static ssize_t nvmet_subsys_attr_version_store(struct config_item *item,
 	if (ret != 2 && ret != 3)
 		return -EINVAL;
 
-	down_write(&nvmet_config_sem);
 	subsys->ver = NVME_VS(major, minor, tertiary);
-	up_write(&nvmet_config_sem);
 
 	return count;
 }
+
+static ssize_t nvmet_subsys_attr_version_store(struct config_item *item,
+					       const char *page, size_t count)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+	int ret;
+
+	down_write(&nvmet_config_sem);
+	mutex_lock(&subsys->lock);
+	ret = nvmet_subsys_attr_version_store_locked(subsys, page, count);
+	mutex_unlock(&subsys->lock);
+	up_write(&nvmet_config_sem);
+
+	return ret;
+}
 CONFIGFS_ATTR(nvmet_subsys_, attr_version);
 
 /* See Section 1.5 of NVMe 1.4 */
-- 
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
