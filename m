Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80985C4829B
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Feb 2024 04:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=b3NTCQKTG5PLOeSuzz1AObdr/kBhsMrR7+soV4UlQjs=; b=gxFBC+QAKXRWGPFffvdHCaFKNh
	Q6xJwpP2a4rHOwFPo/2sFnzgzRZ4KmYhb4RoZcg99uiK3u+vKRMkF0O4RbEotbcI7X/M6xMok9/xO
	l8ZscJaX61RUEpFzw0TzgLK+QsnOsS92RJmZC814nJo6r42B9vch0O8wZvKinJ0eww0QYIGustwu7
	aVIvrT6lM+2m34fLCfE1+oawCDGIJdxfKxGeM3mEOkyFhbubbqh6HnlK1PvOPPCywAhJRBcCYqdPc
	B+usIZj65xE0F4oNkOpK4mY32YTdUF/koYbRdfVltS9F56no+3qVr57rIwU/jBVOjkqSNNcFt7DLo
	MYZqpToQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZNuT-00000004IWC-0cnm;
	Mon, 12 Feb 2024 04:27:13 +0000
Received: from mail-mw2nam12on20601.outbound.protection.outlook.com ([2a01:111:f403:200a::601] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZNuQ-00000004IVg-3H0U
	for linux-nvme@lists.infradead.org;
	Mon, 12 Feb 2024 04:27:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHisCrK9d8reWYAoFSaSNFjSaIvnPmNXc9k4G8vqmtQtKdVgJZu0aSBfVil40iedKt+DKVdSiiZACds67xjZ1cCcYY8R+Zqw+DPzqnc6RLvAj9V3DdgfzG3Bco2hhsr0FneYheZRAWuqo63IV11yFflNXQsEFruTdur1gWpoqyoGcI0ur9QIY6FZre0qUTyMjB5CbwzC/HYT3dnHx99S+gk1KAaG/D4GyXWJ3hY054yDNUFa7F/vjRxV/Dbgtjf+AFeYptpgrkmBZBNJ07b6doMGWqPkdwBZK5UXTNrYVnK5/UI26VJKmMePkLEB1cvMavrk0xENvYAybbNmYbYISw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3NTCQKTG5PLOeSuzz1AObdr/kBhsMrR7+soV4UlQjs=;
 b=J/5Pkoa8aLq+Etd5rSMBcvXgdLr968RanBGgcWx3TxACrksdHvYKDY452QQlkLiDRBaw2sWRevyTzg1znHSVIA0i5H8SNrpsWOFWmypBz+vh868NJ7BT3uQ8nZRkg3qXQiCIuoLlzhiggg8zmH9s2Kp1/KI4uDmzFDQ6njGwqDFzirwBk/McQQEbGD/OMBTtYQRVXGfaRNixlwFFvY9mU/OBdyYZJNpJOuj+JZc3fg1XgEdQFUrGi7Afoo2eJAaqSgWASkhzHWWW5MSTJt+8OgBXphaCCMLEpfYvhK/7MIFJYtym/GqBzevlEAZ99+ELPscTB4wEE6uPhi2ZI1CRzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3NTCQKTG5PLOeSuzz1AObdr/kBhsMrR7+soV4UlQjs=;
 b=CRnIaY2fV0Uj/fpftc4+KTSjJOOiJKeSW3aBlo3+/eNPbEV9biqTJrocV91jlniQyWAMD40G5pcYBVgw+OXE4OMuo2J7kW1gjG1v6uNKZrgF+8FUMYQovPjf8ntfoJ6UXAwKtCcqafvk/OWxrGVFvgS0E4QUPun/l2D3ozYpjb1aJda9cdMLwehMGqBnErR3W/5OAC4Xp78exRva5YABbie3WxXSOE+hojRu3SccoaZQBFAZ/DjKhCJS6mMNdYOiiIWDWHpIJUrfpqyCGYBSztpX/+0Pij5bbQgtLFkClsjmbh7f319Q8aouiJjbE07JfnnAeaDgaoR+QunnGbYpOA==
Received: from SJ0PR03CA0056.namprd03.prod.outlook.com (2603:10b6:a03:33e::31)
 by SJ1PR12MB6196.namprd12.prod.outlook.com (2603:10b6:a03:456::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 12 Feb
 2024 04:26:56 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::5b) by SJ0PR03CA0056.outlook.office365.com
 (2603:10b6:a03:33e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35 via Frontend
 Transport; Mon, 12 Feb 2024 04:26:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Mon, 12 Feb 2024 04:26:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 11 Feb
 2024 20:26:47 -0800
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Sun, 11 Feb
 2024 20:26:47 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>
Subject: [PATCH 1/2] nvme-core: add ctrl state transition debug helper
Date: Sun, 11 Feb 2024 20:26:40 -0800
Message-ID: <20240212042641.227821-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|SJ1PR12MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: de890bba-1a45-4178-b629-08dc2b82d8dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2w8qi26OSR5XUFH9CWaADjO+AhtbWQSOI0FT6i0U5CpKG3OEfZ/NgasXqyjjCpA2J7gpDf8hW6tXwY8X3RxVcYZaocnw567qbUhRSRGRjs/yp/xCeYdtAQAg50uaEBbQYu6lAQXcYTmN5YVt9bn0NVaqs2+LDbGrccReDhlc0ddZvw75YtSgkX0yfSGyLwFVXDs9sWaK52MUH5Op0e6PWta/0IUVpYQtKK4tB7sirNIDTvugq70Y0xnoXKofd6Lsh3oCEgTLLGioHt5avA0YaSWgUvzPHAOnwocLm5uGqGjnyKdHW7b5HiulWw4cPXlWrl7z3rjxV5j4aJ2KEuQmzaIK5lY9J7QcHgNyQov3i7RUHF9bUQ9C2Q7409V2w8OALOtFqY5l7mTbfPpN5VWHqxz0poljnE25sUhhRrD5hwj0KX0kFBvxP5kp1To3CBO5LuAehH3kK0C9JCHV9OUzmO5cPHmihOjyto+cLUWUQSPO0ZXqHKP45CiJf6Raf6Epv3JKUCJGf8wp5Q6jpdFrxEcbHtIao/KMDkZpxepw6GB3XRXQ9l+p53oWPWi2KQ1nIwUGazTAG/FTLyTGLGdbPj17A89cZJq5T21ChEZ87/o=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(82310400011)(1800799012)(186009)(64100799003)(451199024)(40470700004)(36840700001)(46966006)(66899024)(41300700001)(2906002)(4326008)(5660300002)(7636003)(82740400003)(36756003)(356005)(83380400001)(16526019)(54906003)(107886003)(26005)(6666004)(8676002)(70206006)(426003)(8936002)(336012)(478600001)(2616005)(316002)(7696005)(70586007)(6916009)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 04:26:56.3697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de890bba-1a45-4178-b629-08dc2b82d8dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6196
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240211_202710_891843_1E01DDEB 
X-CRM114-Status: GOOD (  10.52  )
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

NVMe controller state machine has total 7 states and 13 state transition
arcs. Debugging NVMeOF problems in the field is not straight-froward,
since it involves complex combination of connect/reconnect/kato/timeout
handlers etc scenarios.
We already have a helper in sysfs.c that reads the controller state, but
one has to constantly read the state in order understand the complete
state transition which is very inconvenient.

It is often helpful to know full state transition of controller when
dealing with NVMeOF issues at the time of analyzing the trace.

Add a helper that allows us to decode and print each controller state
transition :-

blktests (master) # dmesg -c | grep nvme_change_ctrl_state
blktests (master) # nvme_trtype=tcp ./check nvme/048
nvme/048 (Test queue count changes on reconnect)             [passed]
    runtime  6.264s  ...  5.240s
blktests (master) # dmesg -c | grep nvme_change_ctrl_state
[17080.988689] nvme nvme0: nvme_change_ctrl_state new -> connecting
[17081.006623] nvme nvme0: nvme_change_ctrl_state connecting -> live
[17081.038313] nvme nvme0: nvme_change_ctrl_state live -> resetting
[17081.040730] nvme nvme0: nvme_change_ctrl_state resetting -> connecting
[17083.056750] nvme nvme0: nvme_change_ctrl_state connecting -> live
[17083.075906] nvme nvme0: nvme_change_ctrl_state live -> resetting
[17083.076112] nvme nvme0: nvme_change_ctrl_state resetting -> connecting
[17085.105270] nvme nvme0: nvme_change_ctrl_state connecting -> live
[17086.126484] nvme nvme0: nvme_change_ctrl_state live -> deleting
[17086.126506] nvme nvme0: nvme_change_ctrl_state deleting -> deleting (no IO)
blktests (master) #

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---

 drivers/nvme/host/core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 20c0c141fcc0..daeb2409f989 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -544,6 +544,21 @@ void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_cancel_admin_tagset);
 
+static const char *nvme_ctrl_state_str(enum nvme_ctrl_state st)
+{
+	static const char *const str[] = {
+		[NVME_CTRL_NEW]			= "new",
+		[NVME_CTRL_LIVE]		= "live",
+		[NVME_CTRL_RESETTING]		= "resetting",
+		[NVME_CTRL_CONNECTING]		= "connecting",
+		[NVME_CTRL_DELETING]		= "deleting",
+		[NVME_CTRL_DELETING_NOIO]	= "deleting (no IO)",
+		[NVME_CTRL_DEAD]		= "dead",
+	};
+
+	return st < ARRAY_SIZE(str) && str[st] ? str[st] : "unknown state";
+}
+
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		enum nvme_ctrl_state new_state)
 {
@@ -621,6 +636,9 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 	}
 
 	if (changed) {
+		dev_dbg(ctrl->device, "%s %s -> %s\n", __func__,
+			nvme_ctrl_state_str(old_state),
+			nvme_ctrl_state_str(new_state));
 		WRITE_ONCE(ctrl->state, new_state);
 		wake_up_all(&ctrl->state_wq);
 	}
-- 
2.40.0


