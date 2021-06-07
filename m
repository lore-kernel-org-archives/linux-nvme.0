Return-Path: <SRS0=yMBa=LB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FEEC47082
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 09:43:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0E5B60C40
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 09:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E5B60C40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LZdaL32ElzbCRAnoBZkjAd5z40gVfOH7NXNfeM6E/BY=; b=T/BkLiIJqO8If4
	5dvZJuWWc/UapL64BeT63Yf8e4Ck2BHMCXPim/z5jOEHVsFKgYSGYcepDhxHVz1ez/hNr0n1bFSBA
	DdRtlz0alyvQ7/5cfCunEnYKcwWqm1vFW8TUejw4RTiL8qzZSmHnMc11p0wSo6Ry1Ho7MxT5b0ZCG
	nQI71fmliPjP9r3xhdEcD0aQMqpRXHVsnESzDvL3U4Zv9EFOhzmDnlF2xlUFxlosHQKI5CO6z6rAg
	1XNv3RpffKtxNfEQTRG5Ueol6zubJYXEw7zb8mCM7OHBm1dsL0zmp9IUaYYhDyPIsk7PAQwwYlWPQ
	wKtYOV3MSHzpW48BGmMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqBn1-002gCZ-Ad; Mon, 07 Jun 2021 09:43:23 +0000
Received: from mail-bn7nam10on2040.outbound.protection.outlook.com
 ([40.107.92.40] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqBTu-002Z8s-WE
 for linux-nvme@lists.infradead.org; Mon, 07 Jun 2021 09:23:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c09/fLvDRp8uD/JseA+r2RrZmQ88kGPDLwL+byHqm+rsPaQ5zSdZoiCQ5CCl+Ulh8VQcof1gWfEdnlwhiqDzEx1s8kAv1K97bEQ3zjv+rao4BLjmAG1lphOIh94wdGuwUQAg29Ie5L8cXIOc3ufd+C5u2hC0FORg61HowC+SVlwg9jD6mItP4mYRf+yd26iV2u9bcVH5pInyZkoAmwhu+dMewn4yb9q9dNRGEksC/CmGJz6Ops8AY6+d5Rp6hSeVkeqw/9QxXbQ3kC+NoiEfh/gopMSgY3WLMlnOcIUDaoJYhovMerpUdPnuzokLr/r3nBS1D3tfylsoxa368L8GYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MH3SCq+pOREmKDSibBGXjBI3fniskHGR/MK9rk2oIUs=;
 b=NLAsRr8Nf5/5HtE3KnMwEhbyigfFYyYP2EVBw5Hher0k7yFs/eNp4SZQauS+ilv6cIpNc2xQ3iQeFzB/cn+3WNeQT26jo/gHtpmW9FJ6eXrHXEetxfCs+bXBXuOI3xGdIh0z2yLKrgLOt0+gbzE1gtrE8Yzo5l+KDfjwamDsyJ4QX+nSuwv0RecsQPU/byEJ6YqInjWy61y3fiL4b7jpGTtmT6gsUbY9G7ZgjUfLzwCScWyu7HBf+1Mvu8Ay0MiZRqrPRlSGtAjsZVbNYPWVewk2G/DlqL41EdQn4GlMab3O+x4V98ApxLjBCfDRTK8NTkkyGcMv5LwPFR6UF8NFMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MH3SCq+pOREmKDSibBGXjBI3fniskHGR/MK9rk2oIUs=;
 b=nv8O5kHNXExqTSe/Tue2hOHQag4xR8cl2VbshfN4T6ox3MD91dl9vUtTN25ku5wwyHCmeqmzgRjCHuY0CchVqdOYlc83nDQhQFEz0nDihKB2WKMMvIq4QRi0cpDtSeXKvJRp2hFDTExnaScZr2QjHQZw6udWQT70BEd6Ese3pv50X7TbNdtIUdTRtycWnQ+oOsJRaFLfgeC7zLom0DEMDpb96xXaEO3Xa8FNKnUscH2cOdTltMKos9S8j7fc1cmpBYjvGd1U44zrq20HhOZOqZSKNdnMhHjazQ4SowSGqDnuYKqtdxZKDejwHrTwjl3ekAWe3yDrAi2jfRU4adWrJw==
Received: from BN6PR1101CA0005.namprd11.prod.outlook.com
 (2603:10b6:405:4a::15) by BN6PR12MB1810.namprd12.prod.outlook.com
 (2603:10b6:404:107::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Mon, 7 Jun
 2021 09:23:36 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4a:cafe::29) by BN6PR1101CA0005.outlook.office365.com
 (2603:10b6:405:4a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20 via Frontend
 Transport; Mon, 7 Jun 2021 09:23:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 09:23:35 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 7 Jun
 2021 09:23:35 +0000
Received: from r-nvmx02.mtr.labs.mlnx (172.20.187.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 7 Jun 2021 09:23:32 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <kbusch@kernel.org>, 
 <hch@lst.de>, <chaitanya.kulkarni@wdc.com>
CC: <ngottlieb@nvidia.com>, <oren@nvidia.com>, Max Gurtovoy
 <mgurtovoy@nvidia.com>
Subject: [PATCH 4/4] nvmet: make ver stable once connection established
Date: Mon, 7 Jun 2021 12:23:24 +0300
Message-ID: <20210607092324.1031046-4-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607092324.1031046-1-mgurtovoy@nvidia.com>
References: <20210607092324.1031046-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd7e360c-0375-42d7-b172-08d92995ed78
X-MS-TrafficTypeDiagnostic: BN6PR12MB1810:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1810BAF0AC8C0A1BBE0871F5DE389@BN6PR12MB1810.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BfzGwXNk02HyZUihf501wA225U7YoivJow8njjRQaSascMu5JeAe4K16XkqbbonOr9aAbN5Z1rlB7MViQ2EPcNMPN086fFoD4XLbcgmdvVzfXzS/6+u+5TiiOX1YNni8PA78yitWtGRlBDEwBzrK7NrOV7ByhdId/OjS8uN+UxVCu0Axk89Df1DEHpCdGzwWFbCqFhu/+dE9JiJiHwkVomj5FoqaROeGx3XmV5Bmz3zxlW37Ejy2oQLskw44NQ5lKW0pRXiZIXisCUR8gGD31PXaD14EAc92TVmj0KnKdbaPhkAGxmxfluA0QLXTPnEMglxxzgv/IJYrldJJT744T4vlrJFP9x5wUlZie0nk2XghNTk6ryhPn4sQlIqcFgZEEpD6cJZQtGH5/RyUGiQ+C/azh7R9DN8w+kFf+8T7vo5R6THt3oxDOJQuX9URkeVa1tZIvaqdJQFaLXD0Xlien7YdBRtkb9sCDgHj2Y2oK0VDrz1sAX5JvlczW80bciJ5PpZXn29aaHV9j6vNeaQjKmmZlemEcDoUpW6PwUoVdflJIU8rFFJiAHCvYFz5Dyln+Sww4s47iKvNLrmxegjRD996U+WdvHGXtg+N5veFQJJ+pJpmYD7nUpv2BtL/CACqrZcxXI5eig9uufgRU7HnrA==
X-Forefront-Antispam-Report: CIP:216.228.112.35; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid04.nvidia.com; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(46966006)(36840700001)(6666004)(70586007)(70206006)(110136005)(1076003)(36756003)(83380400001)(316002)(5660300002)(107886003)(36906005)(2906002)(82310400003)(478600001)(186003)(26005)(82740400003)(8676002)(54906003)(8936002)(2616005)(36860700001)(426003)(86362001)(336012)(47076005)(7636003)(4326008)(356005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 09:23:35.8642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd7e360c-0375-42d7-b172-08d92995ed78
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.35];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1810
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210607_022339_100818_E77B684F 
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

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Noam Gottlieb <ngottlieb@nvidia.com>
---

changes from v1: changing "ret" to ssize_t (from Chaitanya)

---
 drivers/nvme/target/configfs.c | 36 +++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 9ef8708b92c6..273555127188 100644
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
+	ssize_t ret;
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
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
