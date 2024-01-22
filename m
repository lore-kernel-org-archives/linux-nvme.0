Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6440EC47DAF
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jan 2024 15:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6fyEbKGsLm1NBGOnlZR+ixb+gWl92xhfbRXmpCFWgKQ=; b=lnQFWt61Oplp6q3dJhAPZXaPfV
	WcA2nIT41hKyapULCuh9LmD45kuICT9kVA5yHVs2MMbmcSv8Y37IptSMJ6ye9oYkoFGxEsKbADa7v
	OzRRi62ssD2kS2NuGnHjasiMK7VE0tNO08d9R61dI3uqywl7+uAUrXMMGILFhiYw+rwVNOB0ybgWH
	2JuFdcerB5d8sWqrsm+Q8mmtz6FmVFAKmapYIpj1QraIND2awyzBQEylbsoNSmltnZey0Z57ChRmE
	z5LvseOFUaO4J3HszjD0jXjf5S8wmt0yRvUsw0+35Ia2G+tMVyPTd+hNWWp6SbVPUGOD2iCF14VPK
	A8B7DJiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRwJh-00CkRK-1k;
	Mon, 22 Jan 2024 15:34:29 +0000
Received: from mail-dm6nam12on2056.outbound.protection.outlook.com ([40.107.243.56] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rRwJe-00CkPV-0r
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jan 2024 15:34:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWhVt+l/D0rpAYveh4p7xSERwgRdoMTq2Lw0ot1AOB7QulOScsKy75SojZdi76FEhDHVBYZYPkvS9RpKn/fI2frO6EKyEIN6rfOcShHKdIRXKS6OxSsX9MOpq/au99fmN4030Ofpd6alAPnP6HOIq24n0y93k15BofVjrJwzSYN1RVJ3QEIrRATZVg3OqVW9atAgE/sEWWM2IVWbjhoidlmDniLkGzXB3QPMMWOAafXKZduG5PJptWGRClYPXHqZ5UBex+uw0naIZr6a9m5hHWiS0VJ5eTZ0Fel67eytmOLXo1CyjnYNpzOIScyquyf/uzH0yBdfgYPh81/QGUKcnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fyEbKGsLm1NBGOnlZR+ixb+gWl92xhfbRXmpCFWgKQ=;
 b=FF6gbO1ioKO+DO7gRk9+IPKYwprC9+0HD+EHdvDxxZbFoAcDdtp15O6myxWF4TOydXHazs011WRFwiYFaKjFZdW9jpPwsrqcZBvB/jTsfi8wja6X2Ca2K02qDgdreMd+LYQeDoj7tfvzoWM72G5Q6DilNlf1L6rW4uDawnn55c2ZlJ5pJjSZlvbWBvH+Ik4NFodI+IpJe8YftL0t9Y0sEuphMGfsSWH+312Ic69D7/2423pftBxJaSuuT+iNxYVJZXF4YvKBG9hi8W4KDOKa/f/Rh0R0lYKELof1d9dr0aKBHkHRmFTBRAp7LA9IU+jcdFZ2sM/dMC24OuUO/ftUTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fyEbKGsLm1NBGOnlZR+ixb+gWl92xhfbRXmpCFWgKQ=;
 b=mSmezsCEYB5RQj89A9V+A1WUV2YzHyA1F40vP23ObCQ/MbDxWLrmP925Y7JxhMQzTa3ZzXy2L1M1XUxCo00ZytY7tfdSM9WKThxizenKo2t0At6xyI/O0sdiAJApGz4yc53iTcClst4Qz26wN1MWhBfWha1lyYtRsgKQYnhmh70gE2cVF1SpR4oAUTI0pOU8LjSlbXABVxwXbH/iJbl64SYtf7hD2uDPpjXaXV/RUKo53xfA3Js88sPSKiU8x+nOQR/kZaGjI6twclzKHZEpeSmtXcSNOe71Z/Oeals0Yilr6i9+OmARV+P5PanSB+pzKOVibaVjRg4VZUzG8EYO0Q==
Received: from SJ2PR07CA0017.namprd07.prod.outlook.com (2603:10b6:a03:505::17)
 by CH2PR12MB5019.namprd12.prod.outlook.com (2603:10b6:610:6a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 15:34:03 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::da) by SJ2PR07CA0017.outlook.office365.com
 (2603:10b6:a03:505::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32 via Frontend
 Transport; Mon, 22 Jan 2024 15:34:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Mon, 22 Jan 2024 15:34:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 22 Jan
 2024 07:33:47 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 22 Jan
 2024 07:33:47 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 22 Jan 2024 07:33:44 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, <dwagner@suse.de>
CC: <oren@nvidia.com>, <israelr@nvidia.com>, <oevron@nvidia.com>
Subject: [PATCH libnvme] libnvme: Add disallow_pi to connect cmd
Date: Mon, 22 Jan 2024 17:33:41 +0200
Message-ID: <20240122153341.20757-2-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20240122153341.20757-1-mgurtovoy@nvidia.com>
References: <20240122153341.20757-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|CH2PR12MB5019:EE_
X-MS-Office365-Filtering-Correlation-Id: 29a9ae0a-6678-4c8d-5fd5-08dc1b5f9007
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fYGLR+Vkh3wlBL3xh3Tg5StELe4dANbL6dwRO7g2BQWAwBe6KHSrxtBTOoSv6AtA/Bkqd/X84D4M+DqSnaBqmYEgGhQ+S5N9W1xvwxelZzgm+um6gjL5ceJdfyCHoWLTkw0BcODXK+4rNp96c7wGZUb6yYcAXzr/0SHC226CCdCdp/2tEyz7mLyAGi/TNk3EVhmVLo4fYrwzbmXCdCtPaOSEB3W0c/WUxvZPiFzNh5hnqT4F5ZG6WDSXSEJP4MeovYOM64d6yWWTJKNU3sCNfVVWkA5dSGnYzw3NjNjWoyy9HIO4mh4IZXbx/IubmZO+eoVrUOZ0qQ6N4KdxqGrRTA0q3mjBQqpG+KTqFmK8G+dk+YFcU6opaLZWJFV2+4EJJbVjWoMPRWIMTwogVZHWy1xRjBLu9dDaxAxR0NDom9ZipP/fQB6WCF+4nW8Ai66QUPW47XUO3t+ULToIzeMqlHvYQ0tBG+IgfbUPu9cQqQFA4waP+VzgcLbKBLxPY/XfsaFjIg3HKjbm5byFPzAF/nbj6TzsjIBDy2WaK0lW91LxeTmGDNfgkb3KFlxGLPYT+Ok9834o7nAUyLfdm4DK0zjvW2fK5hJiugn/ra7oJMTBJvszdDxXJWjn5m8uvfJw1TlZ0mgsbhVjuckPsX5RwPOBmnAR3SL3VIwqxLUlFILUyKBUh8KTMnPUMoJRRCaopLh6VaNsgivvIyKKA71hdchTzILjeOBf4dyMxHV7ojTcXCmeZdLPIJp618GlqxrQ
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(396003)(136003)(230922051799003)(451199024)(186009)(82310400011)(64100799003)(1800799012)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(336012)(107886003)(26005)(36860700001)(1076003)(426003)(7636003)(2616005)(6666004)(356005)(86362001)(82740400003)(36756003)(41300700001)(2906002)(4326008)(8936002)(8676002)(83380400001)(47076005)(5660300002)(70586007)(316002)(478600001)(54906003)(110136005)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 15:34:03.1075
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a9ae0a-6678-4c8d-5fd5-08dc1b5f9007
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5019
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240122_073426_307239_5ED9B409 
X-CRM114-Status: GOOD (  15.10  )
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

From: Israel Rukshin <israelr@nvidia.com>

Add 'disallow_pi' to 'connect' command, so users can disallow
metadata support to save resources.

Signed-off-by: Israel Rukshin <israelr@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---

This patch is complementary to NVMe Kernel series:
"Enforce uniform metadata settings for ns head"

---
 libnvme/nvme.i     | 4 ++++
 src/nvme/fabrics.c | 8 +++++++-
 src/nvme/fabrics.h | 2 ++
 src/nvme/json.c    | 4 ++++
 src/nvme/private.h | 1 +
 5 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/libnvme/nvme.i b/libnvme/nvme.i
index eb94cac..7945971 100644
--- a/libnvme/nvme.i
+++ b/libnvme/nvme.i
@@ -199,6 +199,10 @@ PyObject *hostid_from_file();
 			temp.data_digest = PyObject_IsTrue(value) ? true : false;
 			continue;
 		}
+		if (!PyUnicode_CompareWithASCIIString(key, "disallow_pi")) {
+			temp.disallow_pi = PyObject_IsTrue(value) ? true : false;
+			continue;
+		}
 	}
 	$1 = &temp;
 };
diff --git a/src/nvme/fabrics.c b/src/nvme/fabrics.c
index 4e042d8..d666b39 100644
--- a/src/nvme/fabrics.c
+++ b/src/nvme/fabrics.c
@@ -204,6 +204,7 @@ static const struct nvme_fabric_options default_supported_options = {
 	.ctrl_loss_tmo = true,
 	.data_digest = true,
 	.disable_sqflow = true,
+	.disallow_pi = true,
 	.discovery = true,
 	.duplicate_connect = true,
 	.fast_io_fail_tmo = true,
@@ -260,6 +261,7 @@ static struct nvme_fabrics_config *merge_config(nvme_ctrl_t c,
 	MERGE_CFG_OPTION(ctrl_cfg, cfg, hdr_digest, false);
 	MERGE_CFG_OPTION(ctrl_cfg, cfg, data_digest, false);
 	MERGE_CFG_OPTION(ctrl_cfg, cfg, tls, false);
+	MERGE_CFG_OPTION(ctrl_cfg, cfg, disallow_pi, false);
 
 	return ctrl_cfg;
 }
@@ -289,6 +291,7 @@ void nvmf_update_config(nvme_ctrl_t c, const struct nvme_fabrics_config *cfg)
 	UPDATE_CFG_OPTION(ctrl_cfg, cfg, hdr_digest, false);
 	UPDATE_CFG_OPTION(ctrl_cfg, cfg, data_digest, false);
 	UPDATE_CFG_OPTION(ctrl_cfg, cfg, tls, false);
+	UPDATE_CFG_OPTION(ctrl_cfg, cfg, disallow_pi, false);
 }
 
 static int __add_bool_argument(char **argstr, char *tok, bool arg)
@@ -637,7 +640,9 @@ static int build_options(nvme_host_t h, nvme_ctrl_t c, char **argstr)
 	    (!strcmp(transport, "tcp") &&
 	     add_bool_argument(r, argstr, data_digest, cfg->data_digest)) ||
 	    (!strcmp(transport, "tcp") &&
-	     add_bool_argument(r, argstr, tls, cfg->tls))) {
+	     add_bool_argument(r, argstr, tls, cfg->tls)) ||
+	    (!strcmp(transport, "rdma") &&
+	     add_bool_argument(r, argstr, disallow_pi, cfg->disallow_pi))) {
 		free(*argstr);
 		return -1;
 	}
@@ -710,6 +715,7 @@ static  int __nvmf_supported_options(nvme_root_t r)
 		parse_option(r, v, dhchap_ctrl_secret);
 		parse_option(r, v, dhchap_secret);
 		parse_option(r, v, disable_sqflow);
+		parse_option(r, v, disallow_pi);
 		parse_option(r, v, discovery);
 		parse_option(r, v, duplicate_connect);
 		parse_option(r, v, fast_io_fail_tmo);
diff --git a/src/nvme/fabrics.h b/src/nvme/fabrics.h
index 3664a85..a6518df 100644
--- a/src/nvme/fabrics.h
+++ b/src/nvme/fabrics.h
@@ -42,6 +42,7 @@
  * @hdr_digest:		Generate/verify header digest (TCP)
  * @data_digest:	Generate/verify data digest (TCP)
  * @tls:		Start TLS on the connection (TCP)
+ * @disallow_pi:	Disallow metadata (T10-PI) offload support
  */
 struct nvme_fabrics_config {
 	char *host_traddr;
@@ -63,6 +64,7 @@ struct nvme_fabrics_config {
 	bool hdr_digest;
 	bool data_digest;
 	bool tls;
+	bool disallow_pi;
 };
 
 /**
diff --git a/src/nvme/json.c b/src/nvme/json.c
index 4d0f987..bfffd49 100644
--- a/src/nvme/json.c
+++ b/src/nvme/json.c
@@ -60,6 +60,8 @@ static void json_update_attributes(nvme_ctrl_t c,
 					data_digest, val_obj);
 		JSON_UPDATE_BOOL_OPTION(cfg, key_str,
 					tls, val_obj);
+		JSON_UPDATE_BOOL_OPTION(cfg, key_str,
+					disallow_pi, val_obj);
 		if (!strcmp("persistent", key_str) &&
 		    !nvme_ctrl_is_persistent(c))
 			nvme_ctrl_set_persistent(c, true);
@@ -325,6 +327,7 @@ static void json_update_port(struct json_object *ctrl_array, nvme_ctrl_t c)
 	JSON_BOOL_OPTION(cfg, port_obj, hdr_digest);
 	JSON_BOOL_OPTION(cfg, port_obj, data_digest);
 	JSON_BOOL_OPTION(cfg, port_obj, tls);
+	JSON_BOOL_OPTION(cfg, port_obj, disallow_pi);
 	if (nvme_ctrl_is_persistent(c))
 		json_object_object_add(port_obj, "persistent",
 				       json_object_new_boolean(true));
@@ -501,6 +504,7 @@ static void json_dump_ctrl(struct json_object *ctrl_array, nvme_ctrl_t c)
 	JSON_BOOL_OPTION(cfg, ctrl_obj, hdr_digest);
 	JSON_BOOL_OPTION(cfg, ctrl_obj, data_digest);
 	JSON_BOOL_OPTION(cfg, ctrl_obj, tls);
+	JSON_BOOL_OPTION(cfg, ctrl_obj, disallow_pi);
 	if (nvme_ctrl_is_persistent(c))
 		json_object_object_add(ctrl_obj, "persistent",
 				       json_object_new_boolean(true));
diff --git a/src/nvme/private.h b/src/nvme/private.h
index ee9d738..9ba2909 100644
--- a/src/nvme/private.h
+++ b/src/nvme/private.h
@@ -130,6 +130,7 @@ struct nvme_fabric_options {
 	bool dhchap_ctrl_secret;
 	bool dhchap_secret;
 	bool disable_sqflow;
+	bool disallow_pi;
 	bool discovery;
 	bool duplicate_connect;
 	bool fast_io_fail_tmo;
-- 
2.18.2


