Return-Path: <SRS0=sXsN=I6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E85BC433ED
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Apr 2021 08:39:26 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A202F60190
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Apr 2021 08:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A202F60190
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/4SKaWnBbbNxUnrYf7bq++U8sxcgWXoYTHAs/K6KhzI=; b=cDUHvXAGfW1VRDQBheDhVu6Y2b
	cYtJTr+Z/Vm3MAbcF9qZNwegZHvQQMOoXANWOS2brgZe+ADF9bwgjUIMEY/AM1OL6gskyfG5lIfGo
	0mQhHjW1KdIzplxvRWnlmyfZxeWPt8c0x83FsgRYWKkZs4VS9ganInr1vhE50UH8wHJg1LJLW7GYf
	sYsicaiwdUJta/zKPHlYk7QJ1BhPjpcKiSkgBUEjuVQE9LUraY1DWkw0NNhm+ETgmoVMFaLFrNBV1
	9+G5IseJSoUuhSeS7viJ32ktgvDXiZNXMRKLPFx4+nM0REESvhENWhfsRkRpbaf6TuIeyP4ly3aM9
	iCzebRWA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRsr2-008yRO-MR; Thu, 01 Apr 2021 08:39:04 +0000
Received: from mail-bn7nam10on2086.outbound.protection.outlook.com
 ([40.107.92.86] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRsqx-008yPy-6n
 for linux-nvme@lists.infradead.org; Thu, 01 Apr 2021 08:39:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eptJ/1nqEhDPe8c8MKEwZk6OGg9MHBZIJ7wbnDW9WsNNvxBd+sSLEfzelzZsCFJYJJkscFg0mbNWEQ/to1DVvdXDLR6nGLcPYR3bdX1qdY799b47GxPZ7XJRQeiu7bHh/SvP8gGmHb/8XhZbIxYnfohM0WXAyyNN2aC3N+o5z6a6SO/huRXpgOYLMPExQN+mVncerQYExT8YWjEHImZS+byZgTmqDdYuVCKuGWbUOdvex35TwT1MH/9q+nTuhLVZUlffSqz8rP9NJE509mS1oXmy1ejBcDRfR2yPjhiNkBmgqaK8KtLbwkhlKP9TkUa4c/o9FcNggztEsguFfHsk2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49zizlh+nGKD6nf8Ha/6X144/eQNlXP7DEnMpsfgnW4=;
 b=eEier0q2D3yLVReoep+slCeaRusD1bwNkvKCPVP1skwZmxyB9ilLZdssAeh1QpZDOnJWGA2typ9nytBUlGgbxgmbKnS5tzAMIJFdKozbSswKZzics01YzfuGus3Nxl3ifvULv7hnMRpe8pse5DUl5IAaknSWtZMJQGTD1AQmJkAYbhH0RVvx3hRiMbR5P0UkHpMdwHMPz77Oo3G8Jf9Lr2ajeIFQzc/Gfy+yk6T019HV7YZKSYTayHSbmdPZ63L90lChcjZZ8ZkQ4O7pRzoDxh2QC+q5WxSWpysL7QIJBipQvpc2IGDygrWHQ3viAJOPwrkO9rd2VqVjlVyY6+HohQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49zizlh+nGKD6nf8Ha/6X144/eQNlXP7DEnMpsfgnW4=;
 b=oYW8KjIDPjnZUnl6kmX5S97LSfr6mF+Y8cw6NeUAHE0lzfCZKo8n9CJl5ZLLtiVMYVwHYCVgZeelFeZvITiZm1zxuz5yBHqKbkGuUcLX1WSilKHn4/xaNywVFd+pueyN/zEVIiN6NhgPOdt+h7aeVnr7MrLAD1/TZvf+l6HehXoESjCXTBzWfwVa8WProWhlWeEkyBw4DQHtg2cpuYO89FkUoKmoDIWVAH4p/k0X0szqveb8av56u6eiUywJdhBR3R8Hq9RYD2JBOVwK1WkrDwl6+/8D8ZoK6YQ30Z1UgSYv2Zkhnk8Xqxc3XLEcEzewtd8yVxkoOhG+52Jg9hiThA==
Received: from MWHPR2201CA0051.namprd22.prod.outlook.com
 (2603:10b6:301:16::25) by CY4PR12MB1351.namprd12.prod.outlook.com
 (2603:10b6:903:36::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 1 Apr
 2021 08:38:55 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:16:cafe::45) by MWHPR2201CA0051.outlook.office365.com
 (2603:10b6:301:16::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28 via Frontend
 Transport; Thu, 1 Apr 2021 08:38:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3999.28 via Frontend Transport; Thu, 1 Apr 2021 08:38:53 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 1 Apr
 2021 08:38:52 +0000
Received: from r-nvmx02.mtr.labs.mlnx (172.20.145.6) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 1 Apr 2021 01:38:50 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <kbusch@kernel.org>, 
 <hch@lst.de>, <chaitanya.kulkarni@wdc.com>
CC: <oren@nvidia.com>, <erezsc@nvidia.com>, <israelr@nvidia.com>,
 <nitzanc@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [nvmecli: PATCH 1/1] nvme: add NVIDIA plugin for NVMe SNAP controllers
Date: Thu, 1 Apr 2021 08:38:49 +0000
Message-ID: <20210401083849.322571-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21c4e2a9-386d-4dc3-605c-08d8f4e994c5
X-MS-TrafficTypeDiagnostic: CY4PR12MB1351:
X-Microsoft-Antispam-PRVS: <CY4PR12MB13519FA50722EC33D0298F8DDE7B9@CY4PR12MB1351.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1F5se9iQCctw+rE3Xyh/O/NUZMHv5PEe58pdY7bkk/iXgivf1dZWrNLu9jW2jQTh1ofuyOdaFZQqm4iCQxTrGizGM1TWPmAb41FIQ9mFhvn7ocacYqig5+A2fcIF5A17WWCQWlQ1KHNP+Ui52eRcHno+QtFE8Iozv7419LFcoj46Zb2l17KY0afSwpG540SM+qJ+dM5CrCEM8gLXHK8n4u61dxnFHJl4DtGbR7yZOEtzVOEH+HxD4x148/SoPZb8LCOYaHOux/NXjffp2zHfsjTMN1YtfNC7DI0+JNtUyVTjVSYSFaa/qyhuixPLY32S80OGmpjHN/IswlEBtqvQe8x4L1gsTJWz1VaaFQWXxR27qeG4jwgMQGD6nSOMB+yAxiWEYbicb/PjxFdAAr45Yx3lgOwrf8oFujbPu6I5UJpTFHIuDtxEPXoGSEL20Ys0XnT0g4V1kX54/0pPJz5ZsRHMpHobHu8Qka355v6p16JevMvq/uJGssiLLDLMRb1OQhzOHmcrPY4smAICpuLHk6aKXUmSnEzzzcFcRnluV9+UjhcunxFIvQDe80fxQxDpX42g+8DjCndlmUbUgjYIyECqtEggCWDHa+iueIx4lxd+U9dkiPC93hggQpFXyAPmGQXBYrGEr9Nemwf55+hu36GBVO8n6W/5zjOI15zJ0XlHr9uAkga7Xc19OyK68CtOH3+gpQiwlPRBiS8L2BezDCfmy2mb5bB4tIzPCnx9ER4=
X-Forefront-Antispam-Report: CIP:216.228.112.36; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid05.nvidia.com; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(39860400002)(346002)(46966006)(36840700001)(8676002)(2616005)(2906002)(36756003)(54906003)(82310400003)(7636003)(82740400003)(8936002)(4326008)(316002)(426003)(336012)(26005)(36860700001)(107886003)(86362001)(83380400001)(356005)(70586007)(966005)(186003)(36906005)(478600001)(70206006)(1076003)(47076005)(110136005)(5660300002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 08:38:53.2296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c4e2a9-386d-4dc3-605c-08d8f4e994c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.36];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1351
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210401_093859_614979_3C274D56 
X-CRM114-Status: GOOD (  12.34  )
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

SNAP technology is supported on NVIDIA Mellanox BlueField DPU family
and combines a unique hardware-accelerated virtualization of NVMe
devices with the advanced networking and programmability capabilities of
the BlueField SmartNIC.
Add initial vendor specific parsing for id-ctrl command of NVMe SNAP
controllers.

For more info: https://www.mellanox.com/products/software/nvme-snap

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 Makefile                     |  3 +-
 plugins/nvidia/nvidia-nvme.c | 59 ++++++++++++++++++++++++++++++++++++
 plugins/nvidia/nvidia-nvme.h | 17 +++++++++++
 3 files changed, 78 insertions(+), 1 deletion(-)
 create mode 100644 plugins/nvidia/nvidia-nvme.c
 create mode 100644 plugins/nvidia/nvidia-nvme.h

diff --git a/Makefile b/Makefile
index 3ea17b5..5fcb3dc 100644
--- a/Makefile
+++ b/Makefile
@@ -81,7 +81,8 @@ PLUGIN_OBJS :=					\
 	plugins/dera/dera-nvme.o 		\
 	plugins/scaleflux/sfx-nvme.o		\
 	plugins/transcend/transcend-nvme.o	\
-	plugins/zns/zns.o
+	plugins/zns/zns.o			\
+	plugins/nvidia/nvidia-nvme.o
 
 nvme: nvme.c nvme.h $(OBJS) $(PLUGIN_OBJS) $(UTIL_OBJS) NVME-VERSION-FILE
 	$(QUIET_CC)$(CC) $(CPPFLAGS) $(CFLAGS) $(INC) $< -o $(NVME) $(OBJS) $(PLUGIN_OBJS) $(UTIL_OBJS) $(LDFLAGS)
diff --git a/plugins/nvidia/nvidia-nvme.c b/plugins/nvidia/nvidia-nvme.c
new file mode 100644
index 0000000..9942901
--- /dev/null
+++ b/plugins/nvidia/nvidia-nvme.c
@@ -0,0 +1,59 @@
+#include <fcntl.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <inttypes.h>
+
+#include "linux/nvme_ioctl.h"
+
+#include "common.h"
+#include "nvme.h"
+#include "nvme-print.h"
+#include "nvme-ioctl.h"
+#include "json.h"
+#include "plugin.h"
+
+#include "argconfig.h"
+#include "suffix.h"
+
+#define CREATE_CMD
+#include "nvidia-nvme.h"
+
+struct nvme_vu_id_ctrl_field {
+	__u16		json_rpc_2_0_mjr;
+	__u16		json_rpc_2_0_mnr;
+	__u16		json_rpc_2_0_ter;
+	__u8		reserved0[1018];
+};
+
+static void json_nvidia_id_ctrl(struct nvme_vu_id_ctrl_field *id,
+		char *json_rpc_2_0_ver, struct json_object *root)
+{
+	json_object_add_value_string(root, "json_rpc_2_0_ver",
+				     json_rpc_2_0_ver);
+}
+
+static void nvidia_id_ctrl(__u8 *vs, struct json_object *root)
+{
+	struct nvme_vu_id_ctrl_field *id = (struct nvme_vu_id_ctrl_field *)vs;
+	char json_rpc_2_0_ver[16] = { 0 };
+
+	snprintf(json_rpc_2_0_ver, sizeof(json_rpc_2_0_ver), "0x%04x%04x%04x",
+		 le16_to_cpu(id->json_rpc_2_0_mjr),
+		 le16_to_cpu(id->json_rpc_2_0_mnr),
+		 le16_to_cpu(id->json_rpc_2_0_ter));
+
+	if (root) {
+		json_nvidia_id_ctrl(id, json_rpc_2_0_ver, root);
+		return;
+	}
+
+	printf("json_rpc_2_0_ver : %s\n", json_rpc_2_0_ver);
+}
+
+static int id_ctrl(int argc, char **argv, struct command *cmd,
+		struct plugin *plugin)
+{
+	return __id_ctrl(argc, argv, cmd, plugin, nvidia_id_ctrl);
+}
diff --git a/plugins/nvidia/nvidia-nvme.h b/plugins/nvidia/nvidia-nvme.h
new file mode 100644
index 0000000..bf562b9
--- /dev/null
+++ b/plugins/nvidia/nvidia-nvme.h
@@ -0,0 +1,17 @@
+#undef CMD_INC_FILE
+#define CMD_INC_FILE plugins/nvidia/nvidia-nvme
+
+#if !defined(NVIDIA_NVME) || defined(CMD_HEADER_MULTI_READ)
+#define NVIDIA_NVME
+
+#include "cmd.h"
+
+PLUGIN(NAME("nvidia", "NVIDIA vendor specific extensions"),
+	COMMAND_LIST(
+		ENTRY("id-ctrl", "Send NVMe Identify Controller", id_ctrl)
+	)
+);
+
+#endif
+
+#include "define_cmd.h"
-- 
2.18.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
