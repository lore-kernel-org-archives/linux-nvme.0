Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A4A4C4345F
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Apr 2024 06:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=c6PKkpESH0lHzU/6f2nBA2A9kq1EVOGRThpPjzU1Ipc=; b=g4GGizx0MujxmJNO5/OEyTxSqt
	NG28LiwMSdbSdLsSa2iJas+LElKMrQFM/ztFmCpZ30YNqQrIxelDlrtPHE2MPbmikJRg+f1FN4dRd
	Ywph/+a7KKh/g/Yadwhm+bFWPyLGLORxOo8GUxR2QcyOIa6eAt4gKa1BhgYntGAE20QuIdyHgYvWc
	93sn6JMLI+JTP9Nsvq5wXkQdb3aFdrCWhu/AxgVYInElQ6dTdmfJPAESF7m/wl4IvzvRh9r0+goPq
	v5jmnYDGwRt1w5HAWBJ7+NwIV6v6rL6LMjOkgrF72vaCwb8KuhT4wTv/+BHTLzWSxgDioLnnVG5wR
	74lhspnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwcNj-0000000B5o1-1wum;
	Tue, 16 Apr 2024 06:33:27 +0000
Received: from mail-dm6nam10on20620.outbound.protection.outlook.com ([2a01:111:f400:7e88::620] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwcNf-0000000B5mw-1IlU
	for linux-nvme@lists.infradead.org;
	Tue, 16 Apr 2024 06:33:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBpAu6tskivbXNRuf9o8IalKexEqzLhNjVDKdiJ9GK9Q7IujDulyMT8RIcFRVwsFSpLevbNqOUq9jo949742yWXmFDZURZ9JUpGJtxQkS9qU/5PjKfgurQnV4hRHAZrGlfD7XyEcFVZYQvg7uuKL/JCZxGVLGF9zlsFAF1K2D9pL23TZH6cPf2tCcbG8eu4AnnRseODhm9LFFvoIuh9W8kV/JA9m8eDkLa46R+C8ANC8Jd87yAp8eTrtHegrgap8kHsugN+M5dJENqqdcEFdJR7uFj26XDkGCtlVf2+lbswucL+snxjBk1Q8dAbXtAFod8UnB+nd62dml7o/tQBZsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6PKkpESH0lHzU/6f2nBA2A9kq1EVOGRThpPjzU1Ipc=;
 b=UdRCkF3EwAEGAVkuyDpgWWggeqLXDbGQH6QMoApx/4rIeIqE72vIKRZusyJ4mMUcG/0V47wCEcqCEP/jPPIU3IXEj8rgFgbGI2Fiux1ujxDXh6ZHlnuG1ZdbxLD2d70BMXZk4BIom3yTXr9MYFZZUqkjqwkCYVOK2yaejyfCsfhyWiz2/M7GwwaZ3WDV6b7R4OgzvVQKeIoOBmXDPstZrtxOteKCdzaWVdlWXVCpvMFVQq2Rdg1/D/XfukZct7A8MMoLKdPSyK5xp5ghKFKwjEw9NbixdmFcq/UFuwiaL9TUIFeyRLQWOJDYY3IOzAY7K9mCC6sXwHBTwUwzd7SOMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6PKkpESH0lHzU/6f2nBA2A9kq1EVOGRThpPjzU1Ipc=;
 b=pJCRFzjZo2y67KCrI5GKUOrHo47AtUrsc8xnzeRXpqq8/jFOJDpLfV6XvOuWqCeIwEZWTO0v33TarlmaV4qw2f8mEy0WadywTOA/Qq2We1cXg0Ofy3ZNXoJgSjT99Jh1W6ATpQXtnD71v3N25SU7Vk6TioD4vnAJeslSovg2V93jZnwEQomL4RlmsovF50DEzxaDtixV1xVRnDKS1P0AYdhwu46cDhKc4/ZQHIf8m6M5Q2wbaMd0kWoqsCi62DedbCs8DY60DxcCCaqp+3idz/zbmb7LN4Jd8cLMj2o/wrZeOjRL7Tnkdjw1bE6rXEoluIhnj91nJ6LSxJQGoIZyKQ==
Received: from BN9PR03CA0513.namprd03.prod.outlook.com (2603:10b6:408:131::8)
 by MN0PR12MB6056.namprd12.prod.outlook.com (2603:10b6:208:3cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 06:33:17 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:131:cafe::1a) by BN9PR03CA0513.outlook.office365.com
 (2603:10b6:408:131::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.31 via Frontend
 Transport; Tue, 16 Apr 2024 06:33:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 16 Apr 2024 06:33:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 15 Apr
 2024 23:33:02 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 15 Apr
 2024 23:33:01 -0700
Received: from rsws46.mtr.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 15 Apr 2024 23:33:00 -0700
From: Israel Rukshin <israelr@nvidia.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Linux-nvme
	<linux-nvme@lists.infradead.org>, Sagi Grimberg <sagi@grimberg.me>,
	"Christoph Hellwig" <hch@lst.de>
CC: Israel Rukshin <israelr@nvidia.com>
Subject: [PATCH] fabrics: Always pass hostid and hostnqn
Date: Tue, 16 Apr 2024 06:32:55 +0000
Message-ID: <1713249176-7837-1-git-send-email-israelr@nvidia.com>
X-Mailer: git-send-email 1.8.4.3
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|MN0PR12MB6056:EE_
X-MS-Office365-Filtering-Correlation-Id: a006a91d-cc15-4435-0806-08dc5ddf19c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RSvnwvptys/LjXb0IFDBBsI+MHQZioytVAgFTWibaedIMW7Th3Xrw0VIPMJQgE9ERfkTem2AO4N3ymUXHVqjxgD/nSxxx5uM8Gw7MBv9ubn2di7+YoIqTPAPySvRH+spJHvtl+cuF8U0Wj6uPBwNIcW6c9QQCIbjox4shscta5FDcgSkr+m1ZgWpiTwVZ2T362MFzxPiETlY6GFRLuSwbO0J4a3bcKlK5iUBjVu9d33YqrZ16bPEXA0vbKaxk8hb8dmIohwGfSCadsAR/uK2UWJe6zd7ltWnzQOGgz2wjdMRsAFWNk+5wPLzq7fsdjpRJJPVWcc7tfPhH34fIrJewNIsF3cdvNz3+tu6Wp4kdj1piremDkZD4rMAclz8mujUZG2NZqetw1BFpCjrAx2+GWeOyzQ1xlPfzekv9DxfPFlYLKsoDFTc9IxMLE00U1k1WiodNN0SiOEAHWDM4ozDbGSFW3WO7l77ghHMU7t6jx7pDGzkdPZI2FA6Na10OemYpesZMdhIvf7xeKwCvVbbOjrcEgZ787Q0F0sXJ01guEsu6foZxK3lv9tDg4TkVjJSaRt859Ltds7zkkhUCTMKArmBLPjTYKckLGfDD8eXgC6JUmfzQnaSTKs73qVJx/R7Fs+aVW6RxppdWh9jE9cqzF2/zwGt3dIJNiD7P5c1LFwElPowJ5sYsM7mrkPPoRIQ3phJ13OI3UKyJi6z4Dxkuc0yBWJ641q9uu5jRGULAg5hQqGEpnCaoVUW0Irt6Q+G
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 06:33:16.9366
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a006a91d-cc15-4435-0806-08dc5ddf19c8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6056
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240415_233323_470608_68FD5CC0 
X-CRM114-Status: GOOD (  16.93  )
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
    Use the new function nvmf_hostid_generate() when NQN doesn't
    have UUID and use nvmf_hostnqn_generate(hostid) to generate
    hostnqn from hostid.
 4. If user provided none - generate them both. Before this commit,
    nvme cli didn't do it.

Signed-off-by: Israel Rukshin <israelr@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 fabrics.c | 74 ++++++++++++++++++++++++++++++-------------------------
 nvme.c    |  4 +--
 2 files changed, 43 insertions(+), 35 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index e081d963..ee15b8bc 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -643,20 +643,9 @@ char *nvmf_hostid_from_hostnqn(const char *hostnqn)
 
 void nvmf_check_hostid_and_hostnqn(const char *hostid, const char *hostnqn, unsigned int verbose)
 {
-	char *hostid_from_file, *hostid_from_hostnqn;
+	char *hostid_from_hostnqn;
 
-	if (!hostid)
-		return;
-
-	hostid_from_file = nvmf_hostid_from_file();
-	if (hostid_from_file && strcmp(hostid_from_file, hostid)) {
-		if (verbose)
-			fprintf(stderr,
-				"warning: use generated hostid instead of hostid file\n");
-		free(hostid_from_file);
-	}
-
-	if (!hostnqn)
+	if (!hostnqn || !hostid)
 		return;
 
 	hostid_from_hostnqn = nvmf_hostid_from_hostnqn(hostnqn);
@@ -668,6 +657,28 @@ void nvmf_check_hostid_and_hostnqn(const char *hostid, const char *hostnqn, unsi
 	}
 }
 
+void nvmf_set_hostid_and_hostnqn(char **hostid, char **hostnqn)
+{
+	if (!*hostid)
+		*hostid = nvmf_hostid_from_file();
+	if (!*hostnqn)
+		*hostnqn = nvmf_hostnqn_from_file();
+
+	if (!*hostid) {
+		if (*hostnqn) {
+			*hostid = nvmf_hostid_from_hostnqn(*hostnqn);
+			if (!*hostid)
+				*hostid = nvmf_hostid_generate();
+		} else {
+			*hostid = nvmf_hostid_generate();
+			*hostnqn = nvmf_hostnqn_generate(*hostid);
+		}
+	}
+
+	if (!*hostnqn)
+		*hostnqn = nvmf_hostnqn_generate(*hostid);
+}
+
 int nvmf_discover(const char *desc, int argc, char **argv, bool connect)
 {
 	char *subsysnqn = NVME_DISC_SUBSYS_NAME;
@@ -747,16 +758,13 @@ int nvmf_discover(const char *desc, int argc, char **argv, bool connect)
 
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
@@ -906,6 +914,7 @@ int nvmf_connect(const char *desc, int argc, char **argv)
 	enum nvme_print_flags flags;
 	struct nvme_fabrics_config cfg = { 0 };
 	char *format = "normal";
+	char *hostnqn_arg, *hostid_arg;
 
 
 	NVMF_ARGS(opts, cfg,
@@ -973,16 +982,15 @@ int nvmf_connect(const char *desc, int argc, char **argv)
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
diff --git a/nvme.c b/nvme.c
index 096d43c9..9f4a179d 100644
--- a/nvme.c
+++ b/nvme.c
@@ -8899,7 +8899,7 @@ static int gen_hostnqn_cmd(int argc, char **argv, struct command *command, struc
 {
 	char *hostnqn;
 
-	hostnqn = nvmf_hostnqn_generate();
+	hostnqn = nvmf_hostnqn_generate(NULL);
 	if (!hostnqn) {
 		nvme_show_error("\"%s\" not supported. Install lib uuid and rebuild.",
 				command->name);
@@ -8916,7 +8916,7 @@ static int show_hostnqn_cmd(int argc, char **argv, struct command *command, stru
 
 	hostnqn = nvmf_hostnqn_from_file();
 	if (!hostnqn)
-		hostnqn =  nvmf_hostnqn_generate();
+		hostnqn =  nvmf_hostnqn_generate(NULL);
 
 	if (!hostnqn) {
 		nvme_show_error("hostnqn is not available -- use nvme gen-hostnqn");
-- 
2.18.2


