Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E43C4345F
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Apr 2024 14:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Nkdd/EPhRh8WLdpqbqmRGN4qd6cjazotMvts1ilvBc=; b=ZEQTfL4TYVaas+b2R+QVsWDrMD
	7hVZH1dnaYKAMExsm/wcFrX0HakHay3Uv8P12ANWLo/odSeU1CyLHtM/Gm+RXdQdkK/B704uXgpac
	TOdTUFHNiT98TMLqx5rHAR7mpwIyoQKjTE0HAPB8g3JwU7fohAK70/P+IYMNcQUuzEeDfLHtRTc3/
	/pKtrO6SS0YeokNd7BteTqARPZZIvJP1VDr0UwZk4+IB3gcIGWHO+nnMn2AIDbwXFHFJ68bhLWEir
	pQal2HqpdSMZlB5UkBtLks/h8YBgVepUxVX8NtcQRKZRnox0iKN5mfy/qEG9/GBABaq3Fog/rNqjE
	3TyIY+rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxShc-00000002bwy-1WFr;
	Thu, 18 Apr 2024 14:25:28 +0000
Received: from mail-dm3nam02on20601.outbound.protection.outlook.com ([2a01:111:f403:2405::601] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxShY-00000002bur-1Ky4
	for linux-nvme@lists.infradead.org;
	Thu, 18 Apr 2024 14:25:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6o6ArdjZ3e/FgbEu80u8RohQO4cRCdHqiu9H9fPBgKY3a9psr9M8E/uJP+VgrWaW5qMyD618SmvsVvGNKqrkiOFRd8yuwlWiOBLLOb6pmk0zFdcf7Ct4HTBY/PwWqHdrce7bGN9QGJtoxH2NlVLSkwqztaFyKGTxvdt37nj5FFyjZ8CAleMMXFgoWmvXvBiPPNW2+/YG2XV5jp5U0md7rBYkn3t4CQquvIC8+o7OqW2Vt1Ew7Iua7TXZzT9in+owv5NgxLOh7n8uAkT6N/cpXYF45alLqHBFljsPfLrSkoeZSETF3GUGTAsjAC44kkOslyvZxKhPeiEY6Kr/eiW4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Nkdd/EPhRh8WLdpqbqmRGN4qd6cjazotMvts1ilvBc=;
 b=dBA3QJB2ibweuiCRTOmWhcbktmpffGSe8DoxOCfrmLn0eeeJO9qIvs6had/81aEJjyocd38oIl6uB82tz3bu0Y4S80D03MYkOrTzc9VPnkGiQISE5e5GxETcm/9oPSlowafVZr6cbzXv9bvOF45wXrzjKA9ZvjpgYEBZOZpk0OlSw2yxMsguNqnhfaUEK8SFTrMLM5ZELHc94m7XzY1bXeBPrx2HcmItdRen/wouAnnZ0dzb3CpT3iR1xCqr5uD7nuMCPDl/UB4WiFHSgrxmoR8/r9OoB+1akhlZ4vpsw2vk2ZFvAnj08H2QQj7+PsxGOCuPztKajrlDOGml3LCH8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Nkdd/EPhRh8WLdpqbqmRGN4qd6cjazotMvts1ilvBc=;
 b=GyG3YKZKYqWqCHsUEe8HC8DoGa6LOfdrr9tcsVynHzKA9LfPYLFEZpLX8y9suUcKb5yEgg6jXIx9mmIT3Fw2x1ltVFGcltjwZrZlSdvfE7VzIia5OlxmQjo+D8IzsfMaWb1NBiIY61Hj6YVsXC/wuh9YF+O/WQ5FsbCebL2zUNfAAlucLo0AoHyzW6XWZCjAQ+Q3fpO9JhY6UObvNd5TSq5DL/uhwtpK37k/WE51S8gomLId5f6BCS+h6KBdmzxbsGpeznVD8QqPsLalwJBcDXtIFDCB/U75MF5LLdztMd5LLf47AF5KMP1TdRaZyDAtYChtY6ohNEXd8FEHECPJbg==
Received: from SJ0PR03CA0217.namprd03.prod.outlook.com (2603:10b6:a03:39f::12)
 by CH3PR12MB8258.namprd12.prod.outlook.com (2603:10b6:610:128::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 14:25:11 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::23) by SJ0PR03CA0217.outlook.office365.com
 (2603:10b6:a03:39f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 18 Apr 2024 14:25:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 14:25:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Apr
 2024 07:24:54 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Apr
 2024 07:24:54 -0700
Received: from rsws46.mtr.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 18 Apr 2024 07:24:52 -0700
From: Israel Rukshin <israelr@nvidia.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Linux-nvme
	<linux-nvme@lists.infradead.org>, Sagi Grimberg <sagi@grimberg.me>,
	"Christoph Hellwig" <hch@lst.de>
CC: Israel Rukshin <israelr@nvidia.com>
Subject: [PATCH V2] libnvme: Introduce functions to generate host identifier and host NQN
Date: Thu, 18 Apr 2024 14:24:37 +0000
Message-ID: <1713450277-20323-2-git-send-email-israelr@nvidia.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1713450277-20323-1-git-send-email-israelr@nvidia.com>
References: <1713450277-20323-1-git-send-email-israelr@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|CH3PR12MB8258:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a0434e6-4dc1-4fcb-1b8d-08dc5fb35b22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2jAJzjJrkMzV9qTM96OYG60PuLY6ivsWk9Jis9KODkMTAwPrAE5Ka04jLOZ+n4V38CO6sapSL3BWrIvtkPAloSM3W5IkH1OqmuHbYGw6XTd3wniWOVW2kPFA5+ZpkPUp31vxSiG9ziyyzq/LEc4K89PMPc1Lu6kV1XshgQyB3baQijSIdIKzDcEZbEtoYMnHy2y1hbZIVyJzdjpkcHC2KHvXyBxyHCPYiPCRC+hYIG8CQHGz9bqKzOiL3R8nuy2sMcUTUb5FKN3NHaynJ4q87hShSdovJVDodN/9oZDPOtjynt2D/iT9E6lEF3GKJchjNP4Zt1h3LMdKozfddgwukIQg2Po6E4QDQ4pCQdeLxnPvDs3ySmmukwGXA2eK1MxGKyqIGYDRaQfLIMnmDhHbkYrX8UW5VdtN2PqmdHDy6CDaOIE3KfUAtc7Tppt8OQZsmMwpEfTV58mlnvypH2Ca73Q2qtg4/d4kci2jUhiEMt3XxbqM0+nhUJs2z7Vskq1vufSr4mP8do23J8nvDbdT7WZzBspN6LIsxperItnAvFuoULji3xwc4+YFzbtP6kDBKxXGBIccL868axjt/V2myaeER2QcXlevCBeXNaDHlTWQKt37THa8sBXXlM/BqVJR2g8UpAg0KEZrDemxA0R8XeI7OW/fHGFKxYY6SgpDbJFYcWPGt5iA0vgJ3Ndo1GLcn6f/sMVVHhWPCmcTipjne5i/LsGQ9DSjYGCjKwqRhdWkJA7RUV/yQi3vMC5OsmKB
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 14:25:11.1108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a0434e6-4dc1-4fcb-1b8d-08dc5fb35b22
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8258
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240418_072524_429579_73BBFDA2 
X-CRM114-Status: GOOD (  14.41  )
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

The nvmf_hostid_generate() function generates a machine specific
host identifier. This is useful when the host ID can't be derived
from an NQN that doesn't contain a UUID.
Also, add nvmf_hostnqn_generate_from_hostid() to explicitly set UUID
when hostid is not NULL.

Signed-off-by: Israel Rukshin <israelr@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---

Changes from v1:
 - Fix comment of Daniel Wagner and update commit message accordingly.
   Introduce nvmf_hostnqn_generate_from_hostid().

 src/libnvme.map    |  2 ++
 src/nvme/fabrics.c | 29 ++++++++++++++++++++++-------
 src/nvme/fabrics.h | 21 +++++++++++++++++++++
 3 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/src/libnvme.map b/src/libnvme.map
index 8710c41f..451ca73c 100644
--- a/src/libnvme.map
+++ b/src/libnvme.map
@@ -10,6 +10,8 @@ LIBNVME_1.9 {
 		nvme_submit_passthru64;
 		nvme_update_key;
 		nvme_ctrl_get_cntlid;
+		nvmf_hostid_generate;
+		nvmf_hostnqn_generate_from_hostid;
 };
 
 LIBNVME_1_8 {
diff --git a/src/nvme/fabrics.c b/src/nvme/fabrics.c
index 6738e9dc..d653775b 100644
--- a/src/nvme/fabrics.c
+++ b/src/nvme/fabrics.c
@@ -1342,27 +1342,42 @@ static int uuid_from_dmi(char *system_uuid)
 	return ret;
 }
 
-char *nvmf_hostnqn_generate()
+char *nvmf_hostid_generate()
 {
-	char *hostnqn;
 	int ret;
 	char uuid_str[NVME_UUID_LEN_STRING];
 	unsigned char uuid[NVME_UUID_LEN];
 
 	ret = uuid_from_dmi(uuid_str);
-	if (ret < 0) {
+	if (ret < 0)
 		ret = uuid_from_device_tree(uuid_str);
-	}
 	if (ret < 0) {
 		if (nvme_uuid_random(uuid) < 0)
 			memset(uuid, 0, NVME_UUID_LEN);
 		nvme_uuid_to_string(uuid, uuid_str);
 	}
 
-	if (asprintf(&hostnqn, "nqn.2014-08.org.nvmexpress:uuid:%s", uuid_str) < 0)
-		return NULL;
+	return strdup(uuid_str);
+}
+
+char *nvmf_hostnqn_generate_from_hostid(char *hostid)
+{
+	char *hid = NULL;
+	char *hostnqn;
+	int ret;
+
+	if (!hostid)
+		hostid = hid = nvmf_hostid_generate();
+
+	ret = asprintf(&hostnqn, "nqn.2014-08.org.nvmexpress:uuid:%s", hostid);
+	free(hid);
 
-	return hostnqn;
+	return (ret < 0) ? NULL : hostnqn;
+}
+
+char *nvmf_hostnqn_generate()
+{
+	return nvmf_hostnqn_generate_from_hostid(NULL);
 }
 
 static char *nvmf_read_file(const char *f, int len)
diff --git a/src/nvme/fabrics.h b/src/nvme/fabrics.h
index 4ebeb35e..9dc13754 100644
--- a/src/nvme/fabrics.h
+++ b/src/nvme/fabrics.h
@@ -257,6 +257,27 @@ struct nvmf_discovery_log *nvmf_get_discovery_wargs(struct nvme_get_discovery_ar
  */
 char *nvmf_hostnqn_generate();
 
+/**
+ * nvmf_hostnqn_generate_from_hostid() - Generate a host nqn from host
+ *					 identifier
+ * @hostid:		Host identifier
+ *
+ * If @hostid is NULL, the function generates it based on the machine
+ * identifier.
+ *
+ * Return: On success, an NVMe Qualified Name for host identification. This
+ * name is based on the given host identifier. On failure, NULL.
+ */
+char *nvmf_hostnqn_generate_from_hostid(char *hostid);
+
+/**
+ * nvmf_hostid_generate() - Generate a machine specific host identifier
+ *
+ * Return: On success, an identifier string based on the machine identifier to
+ * be used as NVMe Host Identifier, or NULL on failure.
+ */
+char *nvmf_hostid_generate();
+
 /**
  * nvmf_hostnqn_from_file() - Reads the host nvm qualified name from the config
  *			      default location
-- 
2.18.2


