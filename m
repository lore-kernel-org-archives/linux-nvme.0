Return-Path: <SRS0=yMBa=LB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A7CC47082
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 09:41:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 070F361107
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 09:41:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 070F361107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YPvYqZg600rCRKBSFh61UzAam7tggF6dknBUSUg8VAg=; b=YDKHTyU3OHWAp2
	oHrA6T+ImrXUHPwj/IajYo+g5MAddAgKk7yy+1nrhTh8W0Hpsm5KuW3N0JiJwOpQreBwrQH+5gbdg
	6qvsNYIG2xwhg/7tZjBtQmba5THxVexe+PzfSP6I7k2Mh0OsU/DYVff9FZlvw61P5G9pWftbENBBP
	eMWWvzDeLPAhzaiweNeE/ZQNC53UhjuSnw8NHTMoSviYSfcxK9uS4ENBSOQ5oNmd/YIQqx8TFWg6X
	1+jrIBh0S2l4tJp6X7xV+JJFGbL1EUGlkOh6fdUQHvBZpMvhxUGJoUWy18P8WTVvnzS6Gy3cZ8w//
	vb7qtVzWJTo/rkw8McNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqBkf-002fYL-0K; Mon, 07 Jun 2021 09:40:57 +0000
Received: from mail-mw2nam12on2068.outbound.protection.outlook.com
 ([40.107.244.68] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqBTr-002Z7k-UK
 for linux-nvme@lists.infradead.org; Mon, 07 Jun 2021 09:23:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5fWEGf8M5ONaWD8f7RnrBAQsS5uLUi7N+mMPLQvJ4FHHKG/edWwU6a29qI3HYJghtjsowyDXU/9CaBDwe60cZE0/zLM7dNs95UVRzmAkss+ZKKKw5JywfTLp8yKpcb9uxKR8wh2dNj42bjcx5tbbYFeW86r0WpxiKxQKicUA9T0D2Cy7MBfWDn3gkegbjXlOW1EcjjfAyq7qCYyJx74zXtTvR9qiKVjWeWI5mpLjLkDlzmwcWiE1uLIZPygGy/p+LDMk82lymee4c/Qyrq5ptbpoX5gIabCrF18kz78QPIpLRjy77ipZcVyyTUC6IoTj4PkCN0zQO3yTLgYYiGl3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMCBk0n1VhZ+6KPZq1Jh6baw80Ul2BxWJvoF4C75luM=;
 b=NaamGSpIUHE3fjAXCTApVcZd/W025F+oyk6SJZD+621aKqET3gdl8ehge7f5Rvi1+suLAfCE6f6ZC0qtDHBvRg1++pi/spTO72YWq02IKLqq2OmnnO7J65+o8j5sGfAZUNGFdWXZw2qMkchEU2MpL9Q728F3ueTBVeLnSGH6uc1qQo46DlBcaby4ccNwykoI0+BdHFu99CNx+W+4J2KcjVQgfVGl6XWBEDWuOu5udJiEdL+St7S/jzqNWrxD8DUHelAqL50dSOhnvM+SAldcnhCw+3XKSyawA6fMFhf+iwq7fdvZoKfSKZomTW81PWODFYRiyOpgEKVaN0YYhrVgdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMCBk0n1VhZ+6KPZq1Jh6baw80Ul2BxWJvoF4C75luM=;
 b=sFbCcQEPHnOUqMzffzk77Tak2tJ5Rj53Ojzahc0D7UvUf+7plzehoP4NUeM65Nk/t6f8bSPqecuK63yEuA5Eo4Vo6HnoF8ISZ1bVNmfrdF7WTa/4Oj60Kw0r2QSjSI4MuN0HBngd2SZt1cOSGh2fHVBFrAfwWUUJHQmfLs4nC4o6RxiUoPsxVlvNl9STsStsccQHzHO4Dqsux3wIG5IUXw57wuxwQMfjXAiWfy6mhIeQXxvJYSP72YFtOc27IBM3BJzQJLltipN1V3fQgFNzte29o786n072fhOMLRNAy+Tuj814A8FJqFSex2ciTGNzl/7lQXY7RaQz7o1Nhtxppg==
Received: from BN9PR03CA0809.namprd03.prod.outlook.com (2603:10b6:408:13f::34)
 by MN2PR12MB4223.namprd12.prod.outlook.com (2603:10b6:208:1d3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Mon, 7 Jun
 2021 09:23:31 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::59) by BN9PR03CA0809.outlook.office365.com
 (2603:10b6:408:13f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20 via Frontend
 Transport; Mon, 7 Jun 2021 09:23:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 09:23:31 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 7 Jun
 2021 09:23:30 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 7 Jun
 2021 09:23:30 +0000
Received: from r-nvmx02.mtr.labs.mlnx (172.20.187.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 7 Jun 2021 09:23:27 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <kbusch@kernel.org>, 
 <hch@lst.de>, <chaitanya.kulkarni@wdc.com>
CC: <ngottlieb@nvidia.com>, <oren@nvidia.com>, Max Gurtovoy
 <mgurtovoy@nvidia.com>
Subject: [PATCH v2 2/4] nvmet: make sn stable once connection was established
Date: Mon, 7 Jun 2021 12:23:22 +0300
Message-ID: <20210607092324.1031046-2-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607092324.1031046-1-mgurtovoy@nvidia.com>
References: <20210607092324.1031046-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f212de1c-91c8-4016-a1e9-08d92995eab4
X-MS-TrafficTypeDiagnostic: MN2PR12MB4223:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4223AD31B6AB78CEA9A919EDDE389@MN2PR12MB4223.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xiRiL2zYvohjklZp0XBgG08/vPJagmg4I/bNfjJljupQ7rjeH57b33/sIsQ5GuJDN2YTew9U4/Qmi73dJKLRppdIe80q9zPtWsw/RP4XOq1C9PJ2S+q84iwFG7U9eDTTo+Mqvx5MWjWTdaOLkHidUE9TCIfEwu9rSPTOLcFPNw5EPhkriKqPgw506+c78c6/feT57zsjMS0dQjjPcRd9y6MvQ9adpxWPHyvFhPcRrwB556MjV6avnbeHkrH4AeIo5DBgw5CfUsT6Gaf4cJXL1hp5yXuw2okeT4r2c9ztQFX0CETt7o4kl/n66nOgieuwPSKYaGWsq7w49cV3TecpinsaWRnmrQTsauULaPB06/BpF2mRnJG1s4uEv76c7O2rtQOuYwzkriVJOLutU7Y4zeMLXPvNWjEfMr478gkgqoUgxtFA9Sq8t29c48zngs5IwD+k1vE6Rulasotc/wlU/ylmSpQcddAsWxERHM92gD3dNmXTLWW5NjV8c5ZvU9GSBns9tV7XoL9Z6kZ+QGqwCuVYPaxRXngMT0JcRIzbmYC971MMRiN5jnTjeJnvC6Q2mxEBVn1Ka/jYB30bc9/BXIsykwEYi/7qNQWTNo0fTWUdPAZMcQINhBW47mqD6yrGVWgGbYvGLEFsR6QqrV4F74iPapbSyx9bC26NCTrao84=
X-Forefront-Antispam-Report: CIP:216.228.112.35; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid02.nvidia.com; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(36840700001)(46966006)(186003)(26005)(2616005)(426003)(82310400003)(8676002)(70206006)(70586007)(110136005)(316002)(36756003)(2906002)(54906003)(8936002)(4326008)(47076005)(478600001)(6666004)(1076003)(356005)(107886003)(82740400003)(5660300002)(7636003)(86362001)(83380400001)(36860700001)(336012)(36906005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 09:23:31.0870 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f212de1c-91c8-4016-a1e9-08d92995eab4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.35];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4223
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210607_022336_139640_4F2557EA 
X-CRM114-Status: GOOD (  12.94  )
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

Once some host has connected to the target, make sure that the serial
number is stable and cannot be changed.

Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Noam Gottlieb <ngottlieb@nvidia.com>
---
 drivers/nvme/target/admin-cmd.c |  6 ++++++
 drivers/nvme/target/configfs.c  | 27 ++++++++++++++++++++++-----
 drivers/nvme/target/nvmet.h     |  1 +
 3 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 9c73dbfb8228..5f15c3285a5b 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -337,6 +337,12 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	u32 cmd_capsule_size;
 	u16 status = 0;
 
+	if (!subsys->subsys_discovered) {
+		mutex_lock(&subsys->lock);
+		subsys->subsys_discovered = true;
+		mutex_unlock(&subsys->lock);
+	}
+
 	/*
 	 * If there is no model number yet, set it now.  It will then remain
 	 * stable for the life time of the subsystem.
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 027b28aaf7cd..a13da86fb374 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1044,12 +1044,18 @@ static ssize_t nvmet_subsys_attr_serial_show(struct config_item *item,
 	return snprintf(page, PAGE_SIZE, "%s\n", subsys->serial);
 }
 
-static ssize_t nvmet_subsys_attr_serial_store(struct config_item *item,
-					      const char *page, size_t count)
+static ssize_t
+nvmet_subsys_attr_serial_store_locked(struct nvmet_subsys *subsys,
+		const char *page, size_t count)
 {
-	struct nvmet_subsys *subsys = to_subsys(item);
 	int pos, len = strcspn(page, "\n");
 
+	if (subsys->subsys_discovered) {
+		pr_err("Can't set serial number. %s is already assigned\n",
+		       subsys->serial);
+		return -EINVAL;
+	}
+
 	if (!len || len > NVMET_SN_MAX_SIZE) {
 		pr_err("Serial Number can not be empty or exceed %d Bytes\n",
 		       NVMET_SN_MAX_SIZE);
@@ -1063,13 +1069,24 @@ static ssize_t nvmet_subsys_attr_serial_store(struct config_item *item,
 		}
 	}
 
+	memcpy_and_pad(subsys->serial, NVMET_SN_MAX_SIZE, page, len, ' ');
+
+	return count;
+}
+
+static ssize_t nvmet_subsys_attr_serial_store(struct config_item *item,
+					      const char *page, size_t count)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+	ssize_t ret;
+
 	down_write(&nvmet_config_sem);
 	mutex_lock(&subsys->lock);
-	memcpy_and_pad(subsys->serial, NVMET_SN_MAX_SIZE, page, len, ' ');
+	ret = nvmet_subsys_attr_serial_store_locked(subsys, page, count);
 	mutex_unlock(&subsys->lock);
 	up_write(&nvmet_config_sem);
 
-	return count;
+	return ret;
 }
 CONFIGFS_ATTR(nvmet_subsys_, attr_serial);
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 0ae809ca428c..bd0a0b91d843 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -231,6 +231,7 @@ struct nvmet_subsys {
 
 	u64			ver;
 	char			serial[NVMET_SN_MAX_SIZE];
+	bool			subsys_discovered;
 	char			*subsysnqn;
 	bool			pi_support;
 
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
