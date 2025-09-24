Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A45ACAC5A5
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Sep 2025 20:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4zV3EOPoC5NmF6oLqbGitS01Xc2cNDymRhNJUDmgCWw=; b=jXhBQ1svxgNjidYBrTLbZk62Uy
	tp3d88QzRTtPF9+nRLhDJyccjb2DADibHcDdLIinEFIvfT25DmW5OFowK7hFqibMKHX/x/EH1EJth
	dsWYAfJ8qvyLCun40vOtoSfPhEirrCYwXyYvJuodItJ0iMLWtHUNZPt1CIoO5Ihc9sUpmCTKZejzM
	j4WT5aAQ0LuHzXcDlcftvLa3rQipWJQCtOknHvKMutFIGqeyJ6V9FFu7DsDqoXyBaP2inmVcHbK6x
	MrzDKcGOCKi+h2OUOoXguAd5xahf3kQpkVdnDeSxpOcIPGfPTuYFpEloG/X/oXXzsumCT1qjl955/
	9tdhFYeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1W4c-00000003SOB-0lkd;
	Wed, 24 Sep 2025 20:26:46 +0000
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1W4a-00000003SL0-0z0z
	for linux-nvme@lists.infradead.org;
	Wed, 24 Sep 2025 20:26:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xkbWIlmbADCOoR5h8AXkNB3wKvFMYqCo+4QL/pyfFP7/a3645mDSpqGANhq1CL0FSskQKi6Q9t/9eleFZKKXt8Oa6yNKZojBEIYlAadlAYL413Z/V4tWsjk8exwOOv9jjj6sQU/n6hbEcqxkWpvMPLH3UdXW8f4SxzA5UIZzdUNt3FuvrZcXpJEwWKNFhRllBVfYkBRuVtuaYEkmb+WZTllXyanTtMY6Im0LA944y4rkB/Yj5OjFn6taYhOltXIlSr1/C4DCJvJMtis7hqnju8Ndaz+nNDKG9UwFQYaYR+aJ+RFcNpkyZJ2nvIONz2vAEySQ6YODwzaYkJz2ESwQ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zV3EOPoC5NmF6oLqbGitS01Xc2cNDymRhNJUDmgCWw=;
 b=UBQvQTxHhjCKe+Tnr+WUYYnCg8qOgqsgwsPazgs643MfEzpEDa1hTmQKm6yohRFlKmKu2xqN2jSsN2AZobnBnpqddfif9Eu2nMbW5uLmIA49gecsyp4iIjOWoYJkCzpTC0tXJF88tGIbO+JqmjwvrWtf7lJ2TCIphy09uU18cfUIdA7iUegqB6sMqbIaPwk/e91Tdz9QorajdcHPmNP8o9lhgIhY0H+fXcU/uN0dbr0njs2SvLtIuGKWnd+VoqjldNYH61cVDlIbc77mmWTXBFRUGkaUOasD+4pmxXZ4O0xus3xYnZHEmAiFdu3jzj7g7ClhTGOSuEeGxZ9ft4vJ/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zV3EOPoC5NmF6oLqbGitS01Xc2cNDymRhNJUDmgCWw=;
 b=lBRzE6WPkwmep8SSZgIdx72GFQY8leJaSa1VpjWUt7oSP2RuzWq7hN0OnG6fcSm0A1iiVEifVsqYO2w8nkq88yS5Aqgu0w82dZn9ribz23P6R+Ehkgv+tAIG8NKUc1A5U+xW0RlZ08mWDhAP2HwTUyBiRGkQjsVfi62nlZi8qUOQ6cDCXJHbXtuDPg88iPiBEPkguJT/Pvf00D0yoZupYdC4oFj99FUUqkS3JMEI7J/SXf4Xx60yeN5r5r1VuOGiY646F04fKhSVgI2nT8fdkqPC+c/Ko+fSX33nVonpRMbKLsM2y4LNQsbOROFGAs5EArEC5eP1JVWhcc2YSMvF6Q==
Received: from CH2PR19CA0004.namprd19.prod.outlook.com (2603:10b6:610:4d::14)
 by SN7PR12MB7323.namprd12.prod.outlook.com (2603:10b6:806:29a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 20:26:34 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::cf) by CH2PR19CA0004.outlook.office365.com
 (2603:10b6:610:4d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Wed,
 24 Sep 2025 20:26:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 20:26:34 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 24 Sep
 2025 13:26:18 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 24 Sep 2025 13:26:18 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 24 Sep 2025 13:26:16 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <hch@lst.de>, <linux-nvme@lists.infradead.org>, <kbusch@kernel.org>,
	<sagi@grimberg.me>, <kch@nvidia.com>
CC: <dwagner@suse.de>, <israelr@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH 4/4] nvmet: prevent vid/ssvid changes for discovered subsystems
Date: Wed, 24 Sep 2025 23:26:04 +0300
Message-ID: <20250924202604.7201-5-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20250924202604.7201-1-mgurtovoy@nvidia.com>
References: <20250924202604.7201-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|SN7PR12MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: 836557f8-d2ca-42c5-eb41-08ddfba8a7bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Nw5deBR9ngfwT4RAGdyNnQw+hW9WhAq7kHW2J4/a+gT5gaUZeTkAJUsUNLoE?=
 =?us-ascii?Q?LIKjxW0A3OO9uAufL1b5lu6qzURqTogZhFyJSrMJrSsEh8nk7mq3DPqL8ceF?=
 =?us-ascii?Q?I0esUGL0HiTttcRT+vuGUD4jobD9thQ13wyYFMVb4cXyB7BHA/XJBEDePwKN?=
 =?us-ascii?Q?k9tc6KYn0eSUbk1ZMGI0mFOC2rsmdACYGStuU4OOMiYmdqDcPdxElHfTm9q2?=
 =?us-ascii?Q?vzf0tE7P47Kn/6x2Q7Rwi6zFNhd7WIu4ypSn27D63dab/g3Ni9hPhPWYnIyC?=
 =?us-ascii?Q?j7DyVTJkQ0VsqveROZh8WrxO3EgLuVZRy+INCTp+SYs6aK3LYP0dgbo/zUXT?=
 =?us-ascii?Q?Vy3AE8uslN7wSaANPp1AuqXuOBbrm2ERM2l3ScLyodMtk9/OgkiM5H3ZBpUy?=
 =?us-ascii?Q?QFINNq9hInXeqaYue53Jb86Fu/hdmVNql3trgcRnOVRyNcMQsVNssgnVnGc1?=
 =?us-ascii?Q?LsYilDPvaAtJ2ue6tFsfxcXD3GFRA5JXqKQDoDTyUHB7efY0U9TwDXDmo/lx?=
 =?us-ascii?Q?VilhYkI+ex2OlSyGN7YQSCV2SbQ+lfeNIgp/dS8OSOVqPM+Jergq6OdxBBKy?=
 =?us-ascii?Q?eJlHryTYWnhGVugQg22GhU9FKFsxzZE9qOjYf7kMEgjJqEorjCMdIaqld+On?=
 =?us-ascii?Q?BSbXmvpKhNNCm9Qe1xjrbCxCB8Ezb3y+5sulAfJt+AScSXnH0p9H6cGEKzXU?=
 =?us-ascii?Q?1UFOjovS0f2ubcCtp2v9TZoHPOW1o1XCXWkMpOnHLp4/RY1tFJ3cD5wz+inj?=
 =?us-ascii?Q?6EXipz7nyOnmWxzht3TuTuChWiXb/UTYwvZohnzSvea0gOdgoTyh+ciSc0Tj?=
 =?us-ascii?Q?eY+bLpclziNWWVZIU2MKrzU3hNvqG7IRgmokeZCYE5OuExojrQQc26nRyb0D?=
 =?us-ascii?Q?qkNWNhnBX2wFQdwmrudkQeMsydDZCNpV5imFnPHVywsakVEo1UVe7xw6M/lB?=
 =?us-ascii?Q?Wckr8f+GfOndsRhpGSVi256eX13qfwwBZCiBOC+mfC0Xb3TggO5KlkfIj1IU?=
 =?us-ascii?Q?3CrdXZzmSMYwa4EeNDJUSyqUohyFGgC5WPs0IiTPEqfVy8uQvW9WrwBCZdtY?=
 =?us-ascii?Q?nInB2j0A68RZx+/lTjnjdC6ngFtJWaqtoIW8rmv2XO/Njuog5g7NnOP0O2pF?=
 =?us-ascii?Q?TJ6n7Oo9RgAHoRsMNUWsKU3Ws7J+ZvlrZEvIvfT6ILdEZ8quNAKmJoPposkg?=
 =?us-ascii?Q?3ABv2OBl5E0jUprYUb6CqKZ+n0DrAHjIf9zLUU8jI01m6NhZ8y4biAb69BaX?=
 =?us-ascii?Q?X2hhBR9ZdIYx/8/vc6/u2SvXNEsW6rWpktGZKateX++nG5dyFUXlh5ZdaKx0?=
 =?us-ascii?Q?0gLgVr2nV2mNZfsVPAxfsisV8KRYTPIQqk5FMDTDC8RIXOlOTgN36fjb45ST?=
 =?us-ascii?Q?eAKYkC+DcQGqP0mx01dXlyYD89IMeuqj3QRnpxBU+jL1soCaI4O7wmldM4Ia?=
 =?us-ascii?Q?Dlkk0TooKxVyVFJKZHlvf21oID3bOG9x22YiJekgQh8hOW89TgTCa0RMAnyc?=
 =?us-ascii?Q?BSGyf/+HRrGzQKGNe1r1cJGUCHG3b/VNFsZW?=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 20:26:34.1552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 836557f8-d2ca-42c5-eb41-08ddfba8a7bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7323
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250924_132644_278610_EA8290B1 
X-CRM114-Status: GOOD (  10.85  )
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

Disallow updates to the vendor_id and subsys_vendor_id attributes via
configfs after a subsystem has been discovered. This prevents invalid
configuration.
These attributes can now only be set on non-discovered subsystems,
ensuring consistent configuration state.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/target/configfs.c | 50 +++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index ac12326e036c..dab10825ca0b 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1439,18 +1439,38 @@ static ssize_t nvmet_subsys_attr_vendor_id_show(struct config_item *item,
 	return snprintf(page, PAGE_SIZE, "0x%x\n", to_subsys(item)->vendor_id);
 }
 
+static ssize_t
+nvmet_subsys_attr_vendor_id_store_locked(struct nvmet_subsys *subsys,
+		u16 vid, size_t count)
+{
+	if (subsys->subsys_discovered) {
+		pr_err("Can't set vendor id. %u is already assigned\n",
+		       subsys->vendor_id);
+		return -EINVAL;
+	}
+
+	subsys->vendor_id = vid;
+
+	return count;
+}
+
 static ssize_t nvmet_subsys_attr_vendor_id_store(struct config_item *item,
 		const char *page, size_t count)
 {
+	struct nvmet_subsys *subsys = to_subsys(item);
 	u16 vid;
+	ssize_t ret;
 
 	if (kstrtou16(page, 0, &vid))
 		return -EINVAL;
 
 	down_write(&nvmet_config_sem);
-	to_subsys(item)->vendor_id = vid;
+	mutex_lock(&subsys->lock);
+	ret = nvmet_subsys_attr_vendor_id_store_locked(subsys, vid, count);
+	mutex_unlock(&subsys->lock);
 	up_write(&nvmet_config_sem);
-	return count;
+
+	return ret;
 }
 CONFIGFS_ATTR(nvmet_subsys_, attr_vendor_id);
 
@@ -1461,18 +1481,40 @@ static ssize_t nvmet_subsys_attr_subsys_vendor_id_show(struct config_item *item,
 			to_subsys(item)->subsys_vendor_id);
 }
 
+static ssize_t
+nvmet_subsys_attr_subsys_vendor_id_store_locked(struct nvmet_subsys *subsys,
+		u16 ssvid, size_t count)
+{
+	if (subsys->subsys_discovered) {
+		pr_err("Can't set subsystem vendor id. %u is already assigned\n",
+		       subsys->subsys_vendor_id);
+		return -EINVAL;
+	}
+
+	subsys->subsys_vendor_id = ssvid;
+
+	return count;
+}
+
 static ssize_t nvmet_subsys_attr_subsys_vendor_id_store(struct config_item *item,
 		const char *page, size_t count)
 {
+	struct nvmet_subsys *subsys = to_subsys(item);
 	u16 ssvid;
+	ssize_t ret;
 
 	if (kstrtou16(page, 0, &ssvid))
 		return -EINVAL;
 
 	down_write(&nvmet_config_sem);
-	to_subsys(item)->subsys_vendor_id = ssvid;
+	mutex_lock(&subsys->lock);
+	ret = nvmet_subsys_attr_subsys_vendor_id_store_locked(subsys,
+							      ssvid,
+							      count);
+	mutex_unlock(&subsys->lock);
 	up_write(&nvmet_config_sem);
-	return count;
+
+	return ret;
 }
 CONFIGFS_ATTR(nvmet_subsys_, attr_subsys_vendor_id);
 
-- 
2.18.1


