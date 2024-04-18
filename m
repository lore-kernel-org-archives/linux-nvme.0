Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B17C4345F
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Apr 2024 14:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WmV0yeGvQIb0kiDn7yUuVmhjes1UawIL1yvOWsYajNg=; b=sZiwQg8OeQb2i3BeAIAKpYl55I
	Nepz9zqrVzTLKRCqHSF/ekiJwykoKBnKf/Mlaq9X3+aDPQvFI/p9+LV15PSF4vwjbxTr5vlK94n8/
	Nm/EoGkS6bqhK5MJUI8CM8CH2XJC6Yf3+pqmWxLK6w7nb32U15BTSKMaI0MF7XX42YpcbkhQ1ICR4
	xjN18DuGD1/AAiL46a5/xLwCxCXmyYWifP/lTEbSCAwlRXsKDYKa/M+K82NWw/UOvUraSPK3yLzJ7
	QUONmBLR7jSDCsZ6mCKarzgXn5gRt8KqQjiECBdy9IYJYTf2FM/oUUuY0+p4jKYT8DWTCO7bLucE7
	HZjA6IPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxShl-00000002bzz-2XIq;
	Thu, 18 Apr 2024 14:25:37 +0000
Received: from mail-dm6nam10on2060b.outbound.protection.outlook.com ([2a01:111:f400:7e88::60b] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxShi-00000002bxS-1V3X
	for linux-nvme@lists.infradead.org;
	Thu, 18 Apr 2024 14:25:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKHEPXYcPcOjBdTEPceSkRbpX4wXyzcD2dI3E38yj6bhOdySQCD4BmJJ6mKN+oK99Zvo8V+aHDokggfpMOef8MDoPbLLTlWRQ5GZ3M724nfsR3bb4tT9mnt7A7iegxI3VSBUnMPNNbwIKj2Acri3lQp7yRR5NCO03UEcDHeRemUkZ3H/9pwhXsemzXZA104a13wNHG871AKJgmf+4OTiTMqT1MMrHGdEfeat6Oce43gvwY0g+nW9fNitp4rIry7soAY3yNFp9smmbjBIbkr62zeQfpRWrMcbvnDEs3O6uWM0CIsJyRcch0tgWXbqiDTLpSXw27A4qozzPvDvor6OIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmV0yeGvQIb0kiDn7yUuVmhjes1UawIL1yvOWsYajNg=;
 b=MSHg3bLoqYdLTixn7LVf19H3JNiL2Se7z86KRUWnJlp/0MHEcMvrVvgfm0LbeEFrHnJdlfTjF44vvh1baZqFdn08Q4u7UWA+Gzu+tmw8c7jM5tOgynOSxPog7mUnU2iQ2oFw81htMpjX3fUim7y1mh8U1AVJVonGOYeX7Z41CQ85PgN5NVi4tY4M3EKTb5pR7R9awpeiQ6vwY84a0HFnUWLsnIT8w9wvrMJJJyD7j1CtTnXo3cEwvR+iRg2GAMk11qkB7vsdpRZvIKfBBTi3MX2CymT1n71Tl4mDluTsfyYISji9y99UTH5mrEXhkBg8UDV5aj0/+bCy1FkIONr/fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmV0yeGvQIb0kiDn7yUuVmhjes1UawIL1yvOWsYajNg=;
 b=a/Y8QmfRqwGK16OrlGW2AeyN51FbAFht22Y24n+Uj+RQaY6/EWkgpGBs8+7EiZ9C0nruoWbboHxlD0aUr4NjXMIhYxfBlbyS+KH0/rsDjLeOkj0znAyMVvbmvHuMvsU8S9qVCi2fgpTfO9pd+pKbCA+wmts4GmlKMUdMmAoF1y/NIXE0EMbrSg+Mb7deq7ywe/uNIhR+e6Yw6Cp8aks9dspY7CKCDHEvJceXmfhWT4KwECbrQb1NMMswrYMBzhY4b0lqrrhlSB2d3pZhlDBQtqtV7j0oAqwNkX62Efzc8eUEfQWOkUTZ2aQuCLQRBBsCMq2XMY4en10sDpOW8xK/lw==
Received: from BYAPR05CA0108.namprd05.prod.outlook.com (2603:10b6:a03:e0::49)
 by LV3PR12MB9120.namprd12.prod.outlook.com (2603:10b6:408:1a3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 14:25:08 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:e0:cafe::c) by BYAPR05CA0108.outlook.office365.com
 (2603:10b6:a03:e0::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.12 via Frontend
 Transport; Thu, 18 Apr 2024 14:25:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 14:25:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Apr
 2024 07:24:52 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Apr
 2024 07:24:52 -0700
Received: from rsws46.mtr.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 18 Apr 2024 07:24:51 -0700
From: Israel Rukshin <israelr@nvidia.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Linux-nvme
	<linux-nvme@lists.infradead.org>, Sagi Grimberg <sagi@grimberg.me>,
	"Christoph Hellwig" <hch@lst.de>
CC: Israel Rukshin <israelr@nvidia.com>
Subject: [PATCH V2] fabrics: Always pass hostid and hostnqn
Date: Thu, 18 Apr 2024 14:24:36 +0000
Message-ID: <1713450277-20323-1-git-send-email-israelr@nvidia.com>
X-Mailer: git-send-email 1.8.4.3
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|LV3PR12MB9120:EE_
X-MS-Office365-Filtering-Correlation-Id: 54da9fd2-0933-4689-1c4a-08dc5fb358d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hBBsMS0+pTgmO25xMxYWcojoR1QOnmvHk5Dajcig2o4HjgogsR4lTXnzafNZAuo6mR6T07S4mYgPfaOZyMKbndqs1tNpKRVJj7P/3AmHGYUz+XJeBVfk1GWH0+jLBxMkrJIEaaU7ezFSOQAE9BELNaBDKuVkG18DU2WuRVr4jwn/OOHKsh2gohnNqCGc2Bi/iJ3B0gKKE/fhuRYO/mEGqLpFw+N48GU0ilypibOXgKu9fsZ0InizDULcxdyKUxBSGuAuBcEJc84tDESEQX0sdpiYp+QFmzz0ZKCBCqIKBkxpbVxhixn9NpkBLz3oUDNQve7cM9DQ5wSCBthUIMeLpvKYbRrYCl7ci666Ijocu6VBzeDmNuvxX1xBMDwkoNTeeDu1qJO9rDeA5NmkdbU1LDCX9Dzo1podxbtAKyc3KyDbhCNogzV9Fd45+Gjvfjcb7m3pom3/ThS1dQyaTPN/mBRRvRnHhdL86nJy6WfTghiuAmK83Jeuhb1yabSMK4HluG74TYlqOZCEKzS0V41bC4LldrZ9OL+4qo+JotNjZAQCNUye8lxRyunE2PLiOhUAwkhcNuV+B5fSX7i68MWByCyJPfaiJbTTosuQTxHyzHvM8+QQY/MwQ6YhFKtNnvrwhZnJF/C/8/gPoi8hIO64j23XZeetw70IaXL9Nf8KpzPs84aHtxrZMsHghiK3v/DhQWFDL4FOV8az/VaX9MTB2KVBf5vWg/WhDBuA/wEP1b0Ysf30+qnl+jwIGQBpQqgt
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 14:25:07.2704
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54da9fd2-0933-4689-1c4a-08dc5fb358d8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9120
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240418_072534_514747_0F80BEAB 
X-CRM114-Status: GOOD (  16.13  )
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

After the kernel commit ae8bd606e09b ("nvme-fabrics: prevent overriding
of existing host"), kernel ensures hostid and hostnqn maintain 1:1
mapping. This makes 'nvme discover' and 'nvme connect' commands fail
when providing only hostid or only hostnqn. This issue happens when
the user only enters NQN which doesn't contain UUID, so the generation
of the hostid fails.

There are few more issues that this commit is fixing:
 - When the user provides hostid and NQN, the hostid is overridden
   by generating it from the NQN.
 - hostid is generated from the NQN file instead of the NQN that
   the user enters at the command line.
 - The warning "use generated hostid instead of hostid file" is
   wrong when the user provides hostid via the command line.

The commit fixes those issues by doing the following logic:
 1. If user provided both via command line - pass them as-is
 2. If user doesn't enter them via command line - try to get
    them from files.
 3. If one of them is not provided - generate it from the other.
    Use the new functions nvmf_hostid_generate() when NQN doesn't
    have UUID and use nvmf_hostnqn_generate_from_hostid(hostid) to
    generate hostnqn from hostid.
 4. If user provided none - generate them both. Before this commit,
    nvme cli didn't do it.

Signed-off-by: Israel Rukshin <israelr@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---

Changes from v1:
 - Fix comments of Daniel Wagner and update commit message accordingly.
   Use nvmf_hostnqn_generate_from_hostid() and use local variables
   at nvmf_set_hostid_and_hostnqn().

 fabrics.c | 78 ++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 46 insertions(+), 32 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index 871c20ed..0b70d290 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -643,20 +643,9 @@ char *nvmf_hostid_from_hostnqn(const char *hostnqn)
 
 void nvmf_check_hostid_and_hostnqn(const char *hostid, const char *hostnqn, unsigned int verbose)
 {
-	_cleanup_free_ char *hostid_from_file = NULL;
 	_cleanup_free_ char *hostid_from_hostnqn = NULL;
 
-	if (!hostid)
-		return;
-
-	hostid_from_file = nvmf_hostid_from_file();
-	if (hostid_from_file && strcmp(hostid_from_file, hostid)) {
-		if (verbose)
-			fprintf(stderr,
-				"warning: use generated hostid instead of hostid file\n");
-	}
-
-	if (!hostnqn)
+	if (!hostnqn || !hostid)
 		return;
 
 	hostid_from_hostnqn = nvmf_hostid_from_hostnqn(hostnqn);
@@ -667,6 +656,34 @@ void nvmf_check_hostid_and_hostnqn(const char *hostid, const char *hostnqn, unsi
 	}
 }
 
+void nvmf_set_hostid_and_hostnqn(char **hostid, char **hostnqn)
+{
+	char *hid = *hostid;
+	char *hnqn = *hostnqn;
+
+	if (!hid)
+		hid = nvmf_hostid_from_file();
+	if (!hnqn)
+		hnqn = nvmf_hostnqn_from_file();
+
+	if (!hid) {
+		if (hnqn) {
+			hid = nvmf_hostid_from_hostnqn(hnqn);
+			if (!hid)
+				hid = nvmf_hostid_generate();
+		} else {
+			hid = nvmf_hostid_generate();
+			hnqn = nvmf_hostnqn_generate_from_hostid(hid);
+		}
+	}
+
+	if (!hnqn)
+		hnqn = nvmf_hostnqn_generate_from_hostid(hid);
+
+	*hostid = hid;
+	*hostnqn = hnqn;
+}
+
 int nvmf_discover(const char *desc, int argc, char **argv, bool connect)
 {
 	char *subsysnqn = NVME_DISC_SUBSYS_NAME;
@@ -746,16 +763,13 @@ int nvmf_discover(const char *desc, int argc, char **argv, bool connect)
 
 	hostnqn_arg = hostnqn;
 	hostid_arg = hostid;
-	if (!hostnqn)
-		hostnqn = hnqn = nvmf_hostnqn_from_file();
-	if (!hostnqn) {
-		hostnqn = hnqn = nvmf_hostnqn_generate();
-		hostid = hid = nvmf_hostid_from_hostnqn(hostnqn);
-	}
-	if (!hostid)
-		hostid = hid = nvmf_hostid_from_file();
-	if (!hostid && hostnqn)
-		hostid = hid = nvmf_hostid_from_hostnqn(hostnqn);
+
+	nvmf_set_hostid_and_hostnqn(&hostid, &hostnqn);
+	if (!hostid_arg)
+		hid = hostid;
+	if (!hostnqn_arg)
+		hnqn = hostnqn;
+
 	nvmf_check_hostid_and_hostnqn(hostid, hostnqn, verbose);
 	h = nvme_lookup_host(r, hostnqn, hostid);
 	if (!h) {
@@ -905,6 +919,7 @@ int nvmf_connect(const char *desc, int argc, char **argv)
 	enum nvme_print_flags flags;
 	struct nvme_fabrics_config cfg = { 0 };
 	char *format = "normal";
+	char *hostnqn_arg, *hostid_arg;
 
 
 	NVMF_ARGS(opts, cfg,
@@ -972,16 +987,15 @@ int nvmf_connect(const char *desc, int argc, char **argv)
 	nvme_read_config(r, config_file);
 	nvme_read_volatile_config(r);
 
-	if (!hostnqn)
-		hostnqn = hnqn = nvmf_hostnqn_from_file();
-	if (!hostnqn) {
-		hostnqn = hnqn = nvmf_hostnqn_generate();
-		hostid = hid = nvmf_hostid_from_hostnqn(hostnqn);
-	}
-	if (!hostid)
-		hostid = hid = nvmf_hostid_from_file();
-	if (!hostid && hostnqn)
-		hostid = hid = nvmf_hostid_from_hostnqn(hostnqn);
+	hostnqn_arg = hostnqn;
+	hostid_arg = hostid;
+
+	nvmf_set_hostid_and_hostnqn(&hostid, &hostnqn);
+	if (!hostid_arg)
+		hid = hostid;
+	if (!hostnqn_arg)
+		hnqn = hostnqn;
+
 	nvmf_check_hostid_and_hostnqn(hostid, hostnqn, verbose);
 	h = nvme_lookup_host(r, hostnqn, hostid);
 	if (!h) {
-- 
2.18.2


