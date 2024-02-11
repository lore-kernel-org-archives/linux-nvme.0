Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1798C4829A
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Feb 2024 01:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cTXguOTjJerySqdWUq92kmpC9t38SvtAN4PfFY1LcRc=; b=eLABtSJW4UPtYdmvs23SAOvFFw
	FuKFLPTDJ7VYHC4YEivz0PyFH9IpN1PtYU4Ml7VNr1DI2mH8hRDPeE/LAX0fk8z8znt//MfDGPKUI
	azgxrf4ek1ZMwtULpueE7ARj1AJJ3OhhJn0IwWxYd+aZ7+wVsUikydluaWHGElBkOjmx30gD40VdO
	gotwUdIExJvhmAZnyBJQVUjv14aRS8jKTCuIobLLdBWLMuVSlp/CfDHLB24NuQV3yR1iJUjqoHKG8
	0TCmvGmlDtpwdckIxKVih9WnRUemCHbQ9vZJvr+vFHvKolt4AI8Fv7iXkphASqexJ1JE/PCftHQR9
	usNejPQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZLNi-00000003zhc-0KFF;
	Mon, 12 Feb 2024 01:45:14 +0000
Received: from mail-mw2nam10on20601.outbound.protection.outlook.com ([2a01:111:f403:2412::601] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZJR2-00000003Wkl-3k5J
	for linux-nvme@lists.infradead.org;
	Sun, 11 Feb 2024 23:40:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gnx7mLeXbu5HKAus5EtUWH99Ld0HAy+aLBzF6O2wnG3mQSiXPxiXGLgkLJr3Yq1B9QBsBa/f47Lx2cR287e5J8R+AuShybm71nICt81Q7whVmswbuKTDaaWwe0u6lHJI9IiUbt2jRHdBiac7RIrtnCPJHaUFtdY3gHQ7g+kpE+GzsEVJ7cBi/6BzMIWTa2PMksb/q8kKlM98m+5fEk3zmqc52c0byxhvACitGFuKV/RhUMvE94WxTkXPG1kMhew86LUFuMqXXTsBJupkTChMjUmBY2MCkKOK1cDCrdJzSdQ3RXvQ7Q56ryM6o9XA2Zfrv0Z/8BJXn/wgaTfzCXacCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTXguOTjJerySqdWUq92kmpC9t38SvtAN4PfFY1LcRc=;
 b=S2hqYCJ/4R1LJJAxPDLVZOVTUm586md/OJRA42Brar1YJajZjIyKnru6nbqjP+xuMvJfvxT1sjpFpkEyY7Y8D58fj4zpH+iwKJazSlqFMnN85XciBs0Q3N6CczQUEo/NkCIG0+K2x+magYS2V/r4rO2+lLbllYd3QoCwH5FEwNM3mG0lvAp5MCYaUe9t90j9LDOx/HxcsE39QHvkSwm95MdnYzSI+2ojLMopZiDTolH71Sz8bPRXUatWoC4nFjs5wwR/JtbBPWgcxjOLAecSkBiWUkWWzOvlbzixgTqk2MJUyCMmtzinp8d894EcHJR4qB/iuNjQU6SGSbqCr30rDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTXguOTjJerySqdWUq92kmpC9t38SvtAN4PfFY1LcRc=;
 b=mmr3AvLcagMjCmc4pyE87QlhC2Az8uJsdr+mrNjXtnH4ir15EO8ZaiYn9nwyh876R06ZSSgOKP4cT6qOiNpFRjbqY5qsx9zVFKz6BM3StqJtHTsh32LVYp6w7XRVLZANQJWxrLrDwnjlbElgVGIbaqfldNFLqhCfuL0dAyaZwsbPGsqBvhkmlA0IBdKldOdvj0E4ahTVFJXhqZlDuAHo9wIaRVkWWD4pqZeSNmMQIW/zSV6MKvhLsht7sIDyu+aez0WOPDSO3upyWnQIe3KhDDxrbIXOkAmCSA30RczgWByb3c+7cauGaOedYexsxcw2Jb+N4N8016w1YFKZBa6cdw==
Received: from BYAPR07CA0081.namprd07.prod.outlook.com (2603:10b6:a03:12b::22)
 by MN0PR12MB6128.namprd12.prod.outlook.com (2603:10b6:208:3c4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.24; Sun, 11 Feb
 2024 23:40:17 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:a03:12b:cafe::73) by BYAPR07CA0081.outlook.office365.com
 (2603:10b6:a03:12b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.38 via Frontend
 Transport; Sun, 11 Feb 2024 23:40:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Sun, 11 Feb 2024 23:40:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 11 Feb
 2024 15:40:03 -0800
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Sun, 11 Feb
 2024 15:40:02 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>
Subject: [PATCH] nvmet: nvmet.h configfs helper cleanup
Date: Sun, 11 Feb 2024 15:39:49 -0800
Message-ID: <20240211233949.18219-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|MN0PR12MB6128:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a55ede7-e80b-45cf-b4b1-08dc2b5acd03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nubInXUodwmINLz6S2YVoCR6D6PmVucufIbfaSW1TmjeOkaPPcP2QbchsnMxCrseYBnWWEG1/mt/q3LHcrNuX2JYgfFRWlLbsLUvTWf6YkQQ7bXMVltPiTvrjWFyRijigyzNpJWFKit3nsQDe2KigVjh7cOgpNbtI6l8JAvb4csjUJRZG0ErZCz1bXehWCmrzCOX+z5PUe+6EE0D0dbOrDCnkNOlMjYLXpyvmw06X10fSyCh7B3BLf34aZhxV+/5nqbywP98/qLbsb9gWnVD3F6Muo/XJfgvrBByb/DLi1iTQ2vgA8C6RFOpVhp8lRyZg69K7ZkTffo658RNHtjFN1e2oXotJCQhYl271VobfxhctiRdpSXUZqvj2pyr0w7U5YdKe4SiscECkytvN3lq9eWVut4Sn2rbHkP4wzMeue3w6mWkhu6/R7IM10ggb2mZrRtDRhNklQ4lFUHq6FZlYzH0j8JUWyjwubN8RkXRpkaEAojQ0ztkcw54NqY4TqNEMMEIbWTA0k4jyKb5WPXnHR3L4ecdlM9krguySvw1iQyC6KKcZ3kbsj+orFUGDQzmxXR7QkJjWSZL+z+wJ/B/9sY5UKx0eH90gXNixf20iSE=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(82310400011)(1800799012)(451199024)(64100799003)(186009)(46966006)(40470700004)(36840700001)(41300700001)(7696005)(6666004)(478600001)(2906002)(54906003)(70586007)(70206006)(5660300002)(336012)(1076003)(426003)(16526019)(26005)(107886003)(2616005)(36756003)(4326008)(316002)(6916009)(8936002)(8676002)(82740400003)(7636003)(356005)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2024 23:40:16.4984
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a55ede7-e80b-45cf-b4b1-08dc2b5acd03
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6128
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240211_154033_001263_AB6074F4 
X-CRM114-Status: UNSURE (   9.93  )
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

Functions to_nvmet_ns(), to_ana_group(), to_subsys(), to_host() and
namespaces_to_subsys() are only used in target/configfs.c, move it 
to the appropriate file instead of bloating common header.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/configfs.c | 28 ++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h    | 28 ----------------------------
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 2482a0db2504..a4307cbf9cf7 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -49,6 +49,34 @@ static const struct nvmet_type_name_map nvmet_addr_family[] = {
 	{ NVMF_ADDR_FAMILY_LOOP,	"loop" },
 };
 
+static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)
+{
+	return container_of(to_config_group(item), struct nvmet_ns, group);
+}
+
+static inline struct nvmet_ana_group *to_ana_group(struct config_item *item)
+{
+	return container_of(to_config_group(item), struct nvmet_ana_group,
+			group);
+}
+
+static inline struct nvmet_subsys *to_subsys(struct config_item *item)
+{
+	return container_of(to_config_group(item), struct nvmet_subsys, group);
+}
+
+static inline struct nvmet_subsys *namespaces_to_subsys(
+		struct config_item *item)
+{
+	return container_of(to_config_group(item), struct nvmet_subsys,
+			namespaces_group);
+}
+
+static inline struct nvmet_host *to_host(struct config_item *item)
+{
+	return container_of(to_config_group(item), struct nvmet_host, group);
+}
+
 static bool nvmet_is_port_enabled(struct nvmet_port *p, const char *caller)
 {
 	if (p->enabled)
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 6c8acebe1a1a..ad8d1f096349 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -87,11 +87,6 @@ struct nvmet_ns {
 	u8			csi;
 };
 
-static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)
-{
-	return container_of(to_config_group(item), struct nvmet_ns, group);
-}
-
 static inline struct device *nvmet_ns_dev(struct nvmet_ns *ns)
 {
 	return ns->bdev ? disk_to_dev(ns->bdev->bd_disk) : NULL;
@@ -132,12 +127,6 @@ struct nvmet_ana_group {
 	u32			grpid;
 };
 
-static inline struct nvmet_ana_group *to_ana_group(struct config_item *item)
-{
-	return container_of(to_config_group(item), struct nvmet_ana_group,
-			group);
-}
-
 /**
  * struct nvmet_port -	Common structure to keep port
  *				information for the target.
@@ -293,18 +282,6 @@ struct nvmet_subsys {
 #endif /* CONFIG_BLK_DEV_ZONED */
 };
 
-static inline struct nvmet_subsys *to_subsys(struct config_item *item)
-{
-	return container_of(to_config_group(item), struct nvmet_subsys, group);
-}
-
-static inline struct nvmet_subsys *namespaces_to_subsys(
-		struct config_item *item)
-{
-	return container_of(to_config_group(item), struct nvmet_subsys,
-			namespaces_group);
-}
-
 struct nvmet_host {
 	struct config_group	group;
 	u8			*dhchap_secret;
@@ -315,11 +292,6 @@ struct nvmet_host {
 	u8			dhchap_dhgroup_id;
 };
 
-static inline struct nvmet_host *to_host(struct config_item *item)
-{
-	return container_of(to_config_group(item), struct nvmet_host, group);
-}
-
 static inline char *nvmet_host_name(struct nvmet_host *host)
 {
 	return config_item_name(&host->group.cg_item);
-- 
2.40.0


