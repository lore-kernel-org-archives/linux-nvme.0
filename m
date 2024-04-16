Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE4CC4345F
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Apr 2024 06:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Isgs3lcmsfl+7x4WEfM2wR9qUhpvPvrq4MazIXxGfOY=; b=Ttq3KylWGZxL2RhGZJk/wOe25L
	ZNrihT39NwUw/3JJpXkndzOyM44o+GV4KEIA1R75Nm4oviE78+Zi1lwDvcQ+Clhw6Z54j3Cav/qwI
	mcr9yfSF/R0oUP1ro9oA3QIqPpBu6skCkGFXUNjpuJNVGMfM9In1J8TBGHgnKSEG9gcA/ctazslFy
	xkgmYVSTD4vzv2jGqFWdWHorkZ6jn0Gz8QGMghohpWJN3r7+f7h+pnSXPuy8sIBn14e0FPpqojFTy
	6EOXn6qwSI3pn++/SGcLPPOwZxFI2hi9Yq1++FxrFHbupfITBfzJXwhoitLoVwN1CkI9hyxys0Ijr
	z+NAA4xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwcNl-0000000B5oa-0jaq;
	Tue, 16 Apr 2024 06:33:29 +0000
Received: from mail-dm6nam12on20601.outbound.protection.outlook.com ([2a01:111:f403:2417::601] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwcNi-0000000B5nO-17Fy
	for linux-nvme@lists.infradead.org;
	Tue, 16 Apr 2024 06:33:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OL6bH8ER5sYesUtP5diJ6RxmoqYQA/4zFa9AEDXAZJB7DGxKdmAN0DcCkz+RnuZSwXmkZzXwoXHB5qi4+vj+qsxQqUcN9ioo0TtWBhEXGGGcZF1M6HkZ4A9isKbww+XRGQtJ+VVIH8xN4cc0Hu0MiZ6ElaiKslJyj9lfy/nQkysEDi1uYhuUBwiJZIddrMxVRudQowt7mYLVa5C3pKjgx2Z3n/arDebv5OdldOIrYCUO+4qJusJ8GF5MfR5RNbIAHSN5KiK3yGo2sfMn4XMkEX+8JiZHHeQml8IuUnuhFqAqaRr4aiANWOT49vWPiD71MQwIlUixKcwCOUoCpTKTHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Isgs3lcmsfl+7x4WEfM2wR9qUhpvPvrq4MazIXxGfOY=;
 b=eHVtpZqdgZjLY8GNJhGjIIULNA2Nc9GKsVCC+2/m6YKeJ/NoL6bxrAfH60jOSe+OdVyTvzR1r8eVH9uOyTpP8+2+iEYT321mYVSTZDBd1FtaSVsoe5rMxH3Bx2lyq8o9wYG+uHpz8QWnxC7W2Nsi0g9an/p80eQE/uWFJsjCu7cbD/KioT3SttATvbMd/AUY7mRND0r//ZHBnDRpFjx/U5ulEQjhbB66bKlus/kkVo4PGghgIJAj/xqcN6DucB6L36piyrg3Gjfha4rrJHbBJBwOshZfPHepOL91iX32xGJGcORcV9WvCRQereWYZdSbJRNPaMro2tA1I8P/MNwIzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Isgs3lcmsfl+7x4WEfM2wR9qUhpvPvrq4MazIXxGfOY=;
 b=fuyWxbTXWWyYs/6iRZ/cC/Nw9ov7XzKYDK/fBBegSg55WUa/xf9jjhUiCbZB0yFsbtORLU2rho9jTH8ar+k3Lecz5fk2gO4g8Uct//JrMLwqJFZ7NB/5O6iIxnmo4ifmehuRucMO2xrsmIXr/WIMXdyTi9kZpbnkr1s8lcwaVvVwH6EpBFGi7kZ4Um13w8DMi1lAv3BU6Xzl8hOlqVYI060W3dblQzNiaZmYEbEbjOCdCRSAU6imlAUSZ12cO5bx4UUtQ4IByiV7pe9kynYnxzbOEC0siDQYVnwNWAV156NQ+2IRYTNlF+LLB5jiMfIGoD7514i0iKHJsalQdYluZA==
Received: from BL1PR13CA0308.namprd13.prod.outlook.com (2603:10b6:208:2c1::13)
 by PH7PR12MB6858.namprd12.prod.outlook.com (2603:10b6:510:1b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 06:33:21 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:2c1:cafe::1a) by BL1PR13CA0308.outlook.office365.com
 (2603:10b6:208:2c1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.19 via Frontend
 Transport; Tue, 16 Apr 2024 06:33:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 16 Apr 2024 06:33:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 15 Apr
 2024 23:33:04 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 15 Apr
 2024 23:33:03 -0700
Received: from rsws46.mtr.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 15 Apr 2024 23:33:02 -0700
From: Israel Rukshin <israelr@nvidia.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Linux-nvme
	<linux-nvme@lists.infradead.org>, Sagi Grimberg <sagi@grimberg.me>,
	"Christoph Hellwig" <hch@lst.de>
CC: Israel Rukshin <israelr@nvidia.com>
Subject: [PATCH] libnvme: Introduce nvmf_hostid_generate function
Date: Tue, 16 Apr 2024 06:32:56 +0000
Message-ID: <1713249176-7837-2-git-send-email-israelr@nvidia.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1713249176-7837-1-git-send-email-israelr@nvidia.com>
References: <1713249176-7837-1-git-send-email-israelr@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|PH7PR12MB6858:EE_
X-MS-Office365-Filtering-Correlation-Id: 37fae035-e924-404e-cec0-08dc5ddf1c17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eGc98VP+o3J+gY1q3qAFjx3zatAzYb4vgs/aKzE2TmaZB5DcDZfvBgTCPZnWdWEiP5A8IM4qgIrWoFRuzKXW312jVSU2hBpRBckTsUE44A9kW6wq9+1/xVJOmg51o1NVuGrOZRXFwoOWmhp2rugyYgI5IfTj6oqc5v4Bn7RIdGV3p9DBhbfDMn38d2YrfpfHSA3+mJFZZ8gNbPSBABsiW5WzAKnn/jeegHrrz38Ljk+0GeBo8Yph8S6LVuLJgntqkdvFHl2MhbN5OITg/1Svyrtm5hv4EutyivSQ45jD7BNlhSQOoiqSByqsaQ74b9zYkmoxxIQ2v3MwvnyckU6WgBEMU09eCvemPGB8BJDpp4dWX84jZmtm6MUqjoRzurvTvbSP4QRY0Z8zLZBSz9kdlPjuXLd3EjzBreUvIADFX8ydKC/YtG4JKDoI2wn/3++gn61l/L1vR3BgeSJ6s8PRel3SoH57B4+rLFjS5TOc4VAba86GerywnjNblA62pXTUluZok4SQFnmtDgul5rpAHu6OYvCFExojfMLD3gY3EuPshatc0XYQgx8xfsgQ3GhrLlUJ4FQTjQwcPTCV2JY7X1ZnynJLA/cRa3lmvl49pGSIhBfoJgR+Av3s25tSexWg9zrcaiLidcxmBbSuL33wjQgibQK4MmEFd5NUaBRjs7IijGSE5Z25NIDgNFGUnGPVBPGz97VE1JTtjRj0DPf2VrM4e3tWnV0ytD8W04ceTpW1nCUzUMX0aY9KM8V0gQx1
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 06:33:20.8305
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37fae035-e924-404e-cec0-08dc5ddf1c17
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6858
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240415_233326_335249_7195D73B 
X-CRM114-Status: GOOD (  15.24  )
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

The function generates a machine specific host identifier. This is
useful when the host ID can't be derived from an NQN that doesn't
contain a UUID.
Also, add an host identifier parameter to nvmf_hostnqn_generate(),
to explicitly set UUID when it is not NULL.

Signed-off-by: Israel Rukshin <israelr@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 src/libnvme.map    |  1 +
 src/nvme/fabrics.c | 24 +++++++++++++++++-------
 src/nvme/fabrics.h | 19 ++++++++++++++++---
 src/nvme/tree.c    |  2 +-
 4 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/src/libnvme.map b/src/libnvme.map
index 8710c41f..787cd6c0 100644
--- a/src/libnvme.map
+++ b/src/libnvme.map
@@ -10,6 +10,7 @@ LIBNVME_1.9 {
 		nvme_submit_passthru64;
 		nvme_update_key;
 		nvme_ctrl_get_cntlid;
+		nvmf_hostid_generate;
 };
 
 LIBNVME_1_8 {
diff --git a/src/nvme/fabrics.c b/src/nvme/fabrics.c
index 6738e9dc..684b2daf 100644
--- a/src/nvme/fabrics.c
+++ b/src/nvme/fabrics.c
@@ -1342,27 +1342,37 @@ static int uuid_from_dmi(char *system_uuid)
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
+char *nvmf_hostnqn_generate(char *hostid)
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
 }
 
 static char *nvmf_read_file(const char *f, int len)
diff --git a/src/nvme/fabrics.h b/src/nvme/fabrics.h
index 4ebeb35e..bedef9a4 100644
--- a/src/nvme/fabrics.h
+++ b/src/nvme/fabrics.h
@@ -252,10 +252,23 @@ struct nvmf_discovery_log *nvmf_get_discovery_wargs(struct nvme_get_discovery_ar
 
 /**
  * nvmf_hostnqn_generate() - Generate a machine specific host nqn
- * Returns: An nvm namespace qualified name string based on the machine
- * identifier, or NULL if not successful.
+ * @hostid:		Host identifier
+ *
+ * If @hostid is NULL, the function generates it based on the machine
+ * identifier.
+ *
+ * Return: On success, an NVMe Qualified Name for host identification. This
+ * name is based on the given host identifier. On failure, NULL.
+ */
+char *nvmf_hostnqn_generate(char *hostid);
+
+/**
+ * nvmf_hostid_generate() - Generate a machine specific host identifier
+ *
+ * Return: On success, an identifier string based on the machine identifier to
+ * be used as NVMe Host Identifier, or NULL on failure.
  */
-char *nvmf_hostnqn_generate();
+char *nvmf_hostid_generate();
 
 /**
  * nvmf_hostnqn_from_file() - Reads the host nvm qualified name from the config
diff --git a/src/nvme/tree.c b/src/nvme/tree.c
index 2218d5a8..b2b83bbb 100644
--- a/src/nvme/tree.c
+++ b/src/nvme/tree.c
@@ -125,7 +125,7 @@ nvme_host_t nvme_default_host(nvme_root_t r)
 
 	hostnqn = nvmf_hostnqn_from_file();
 	if (!hostnqn)
-		hostnqn = nvmf_hostnqn_generate();
+		hostnqn = nvmf_hostnqn_generate(NULL);
 	hostid = nvmf_hostid_from_file();
 
 	h = nvme_lookup_host(r, hostnqn, hostid);
-- 
2.18.2


