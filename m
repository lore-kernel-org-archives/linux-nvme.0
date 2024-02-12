Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 577A0C4829B
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Feb 2024 04:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nD4SkBF7D/xEgtdIwWOogo6t4HnR8hHO+XmRC7YXXyA=; b=cLyGH+aVyC3bXUtrOqumZQDb+R
	RKs6ZxOJZ1UWyB8yavkMYHR6gjpLlofhnUBjW5kTu5E+LGQGv8vPITUwm1Ymz/D0Pev0018JaB5cK
	qwQ7lENNl+qyZ6h8Al88Eiz63IrxEDd0Ng3a/furrVNDocV36UdB2CWIkzaIOn665i1NWhoPGp8go
	z1Et+6hOkVUN13Xq6QlkE0QMZ9dOFcgrC35EeRJ5jg+JW/A0ZsoHBB8m0udoo0zz1MO6xohKgBlEz
	xfAsA76GLplkcG/UvewOa/wc4oC3ic6ZKoeZwyIcq6wTOtR+fAVrG4wFUj6LHyy+JMjjXsYKT3cjg
	XG9I+oaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZNuY-00000004IXF-3Zax;
	Mon, 12 Feb 2024 04:27:18 +0000
Received: from mail-bn8nam12on20601.outbound.protection.outlook.com ([2a01:111:f403:2418::601] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZNuW-00000004IWW-1JJo
	for linux-nvme@lists.infradead.org;
	Mon, 12 Feb 2024 04:27:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZob88YhrKRFRJkHSmsSKndmlg1q78FZNFx3oy0YpUNciIfaicqaSNTSD+6tvSJVeWX5I3cCOAsPBEFeRPMpJnolx9YPdBEx8OIQCt22KG12tPxMhdxrsjWPygA47+UbqhMGp/lWYXX8r+GSXTvfPla7Pz5jqQp7caoeLyG9KQqPnocBZrruZ2xOZWg2k0M0YstPqt1ZEnWO4zB1Y49cJ637EJjBIOcBKgNQhmR4LZ9T6FrMYjEXRfzyRuOgtMbcd74EIT+E07jZXUSnjT6H4bPjquKKGAh6GA5NVXPAuWC6e5d4WSau+8B0IigVAXdiRc7/5S2mvuPnPhJSghncRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nD4SkBF7D/xEgtdIwWOogo6t4HnR8hHO+XmRC7YXXyA=;
 b=YY0ybDcSQVpZi621DT15ZkVYJQV2Eyx9i84DJytK59ZRUPpvaCXwnOJmz6sOUwsq7mghXRQksHH0lJ4+VAG33stp9CuPzIZUNVUQIC88z9/RMyYuHZ1h1uB6ivlriuctwly3S1SJIkfY2x7//hRJoaWXid4JY7QaLyw75K6jQKuZP1OcHHw/GaIQcTUAsByjRUZUlSeMgPvEVowTITmgrxzWw/F75kmefi8KjPb0OuFS+o89DSZ4f2/+40g5g9MI0ucRiYrUW9ZXYeJM2BTeco3mVnHLxfesDc/ziPlAMEPnlunnsIdaL7WabsJ8HuEMyAc6rArApq2dWu9dUFDgDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nD4SkBF7D/xEgtdIwWOogo6t4HnR8hHO+XmRC7YXXyA=;
 b=Paj+APSa0ZlqppJmHb4LWI3J68sjrAyiPAttawQ8ffSzsLZVKA5B5mUYRWVdw0B/2QYsOm4xwXG030ahZUgYsN7lGYwOmqA1GBfEmUKUHY+qZZB0hpJJ9I+8874j5hMv0ZHCo86aXbwmRxnxIlNI99KrOz3DyxnckFfMEcUVcsXlzGboBLdKCSsuzSUzCKZIee0GipEjiuqIHfvUdmxdaj5GBSPJvl+sY2WhsT2b2BF1mBCDwq61EOEjFnAhZYoYxg5oQfvP5T0iYqkaYTs7fkH8d1kA726g4EI9DBJxudfjiyFJ+rKSGQpQNEoin9eSZ9+aMBWv1w02CYOFbPLTxQ==
Received: from SJ0PR03CA0115.namprd03.prod.outlook.com (2603:10b6:a03:333::30)
 by CH3PR12MB9251.namprd12.prod.outlook.com (2603:10b6:610:1bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.23; Mon, 12 Feb
 2024 04:27:06 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::25) by SJ0PR03CA0115.outlook.office365.com
 (2603:10b6:a03:333::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.38 via Frontend
 Transport; Mon, 12 Feb 2024 04:27:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Mon, 12 Feb 2024 04:27:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 11 Feb
 2024 20:26:59 -0800
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Sun, 11 Feb
 2024 20:26:58 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>
Subject: [PATCH 2/2] nvme: export and use previously added helper
Date: Sun, 11 Feb 2024 20:26:41 -0800
Message-ID: <20240212042641.227821-2-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20240212042641.227821-1-kch@nvidia.com>
References: <20240212042641.227821-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|CH3PR12MB9251:EE_
X-MS-Office365-Filtering-Correlation-Id: 360c85f2-1278-4b78-5b75-08dc2b82dec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GOoka8E5eToOqSUVjTeIhmQbrdi2jYtjY+gnLimspWGTBuktOBZ65TJdAYeJ4ZPFn1mHfgjJqHS9/DG2y3mx9ydEb/OEVz4IoiY8H/3T78lq4kfPd5Fj4Ec2+bYmoHVj5LEfCC3czvJCoUE6Mw03Ftj7foWNJYt8Ctir8wA45Sx+XICCSTimiqMQ3f8o/DccKMoGl1q9micvbszgZvPxEel7FbcBClwJZrVlF/lJO+Sw/flhZubaA9UdhlS3Vs6L+BjbKrvWU13tWX1RK86e6b0Ixp0En+xuvBz/zr0EKS9omaCZoejrooboY2cWZsG06dZl9FcVKImWyhsmqGg4LUxPp4crDkGSmibwyUYFEcJuqm0SbuBVlfAHwHwEm6RUH5JEFwLUxxPngPeXWcE6+1zvzCjbqMRGVDT5EgUkLpt18Hlca8bDNNJG2VBmaou7oPynHf6Yn6nhhUIzA+guU/vl1wkq97QJfO9NLDU12wiDVWuSMluZ7nWVszlDfJZIZReAlQWW8nj6ipqviEgght+KAcoTMsbQxqxiUixM14kf6nbI7giyy/rY0ovPQAYQFAaS5wY1FQTuJUyePBYXmJUJqiqTeZNLQ3V+oO9Yx00=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799012)(40470700004)(36840700001)(46966006)(2906002)(426003)(1076003)(2616005)(41300700001)(107886003)(336012)(478600001)(16526019)(8936002)(26005)(4326008)(5660300002)(6916009)(54906003)(70586007)(8676002)(70206006)(83380400001)(36756003)(7696005)(6666004)(316002)(7636003)(356005)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 04:27:06.2296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 360c85f2-1278-4b78-5b75-08dc2b82dec4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9251
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240211_202716_378850_AC981DB3 
X-CRM114-Status: GOOD (  10.14  )
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

Export nvme_ctrl_state_str() and use it in the host/sysfs.c:
nvme_sysfs_show_state().

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c  |  2 +-
 drivers/nvme/host/nvme.h  |  1 +
 drivers/nvme/host/sysfs.c | 16 ++--------------
 3 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index daeb2409f989..acde9e377c00 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -544,7 +544,7 @@ void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_cancel_admin_tagset);
 
-static const char *nvme_ctrl_state_str(enum nvme_ctrl_state st)
+const char *nvme_ctrl_state_str(enum nvme_ctrl_state st)
 {
 	static const char *const str[] = {
 		[NVME_CTRL_NEW]			= "new",
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 3ca486fe927c..3584c3861d6c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1094,6 +1094,7 @@ void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
 struct nvme_ctrl *nvme_ctrl_from_file(struct file *file);
 struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid);
 void nvme_put_ns(struct nvme_ns *ns);
+const char *nvme_ctrl_state_str(enum nvme_ctrl_state st);
 
 static inline bool nvme_multi_css(struct nvme_ctrl *ctrl)
 {
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index f2832f70e7e0..a067feaba5ae 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -368,21 +368,9 @@ static ssize_t nvme_sysfs_show_state(struct device *dev,
 				     char *buf)
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-	unsigned state = (unsigned)nvme_ctrl_state(ctrl);
-	static const char *const state_name[] = {
-		[NVME_CTRL_NEW]		= "new",
-		[NVME_CTRL_LIVE]	= "live",
-		[NVME_CTRL_RESETTING]	= "resetting",
-		[NVME_CTRL_CONNECTING]	= "connecting",
-		[NVME_CTRL_DELETING]	= "deleting",
-		[NVME_CTRL_DELETING_NOIO]= "deleting (no IO)",
-		[NVME_CTRL_DEAD]	= "dead",
-	};
-
-	if (state < ARRAY_SIZE(state_name) && state_name[state])
-		return sysfs_emit(buf, "%s\n", state_name[state]);
 
-	return sysfs_emit(buf, "unknown state\n");
+	return sysfs_emit(buf, "%s\n",
+			  nvme_ctrl_state_str(nvme_ctrl_state(ctrl)));
 }
 
 static DEVICE_ATTR(state, S_IRUGO, nvme_sysfs_show_state, NULL);
-- 
2.40.0


