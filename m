Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F836C76195
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Mar 2023 05:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1W2Fo/Z2aCaXTJAoTwyLzOfNMwAMgAPnDhqJGL/Huxo=; b=BmWVl4I39WlWnbqKovT9b4NfLo
	gQUvjPjATout+LIRU1HUmqtRyhasX2SMd8E+1os+8R+8GghbfoEJfcWgPIdNJDDAU5cWkYTVofwSN
	gCwDopMJvugij4d4jgeURAWP1IrcWzwkNtc9/ISfmcbaWRJNtcHo2R2HQH9WVz75CDUXmHn3j/if5
	7NCDYAo3HYHv6zBZq2FAA39NrZmkhqNh7Eo5nWiQI4xqykQMaQDYrduHm8gNtcJfG24Tjdi7RFrLi
	crcLploKuiJFsYOXQDQ5FldkoDZj0voreumaDkebSWrUC6gDBE3N4x1PdWlWocA2+1Lj9edB2Cip7
	lSwIYTTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgfYq-009plC-0z;
	Mon, 27 Mar 2023 05:38:28 +0000
Received: from mail-dm3nam02on20610.outbound.protection.outlook.com ([2a01:111:f400:7e83::610] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgfYo-009pkU-0S
	for linux-nvme@lists.infradead.org;
	Mon, 27 Mar 2023 05:38:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wmx2e3f0sDkUOQQd362b8+0Lr8zk8jE8N7i1Ja1CkO7n+Q2CmMqa6Bg7qwwM5XW/5zXdjr64L5Q0R87CHtIbtgK/l8hyHodXxIsWdIkvLWviTMzK8NB1ZLpDieqYGI0Q7rHctCjLU+eKB9k9HoBVeB0iRWJQDKxVcc9/Gbf4viWbpXQNt9fm952272FbrQAitCRk/r9+ZRniUMiS93JbK21IbJF54zxhmVWWH+poKQlikGYUEmw+DZ7Dlo1JOwMpi3jq7Y0rBy4Wj3fX0oh+QNjcYUXfnSogvUb0rt8cIqh/nfqPt33yIbRRcLEJzPEYMN1pNXANSw9/WM/zUWrt9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1W2Fo/Z2aCaXTJAoTwyLzOfNMwAMgAPnDhqJGL/Huxo=;
 b=G3Qax/ZXRVujjyomK2CxQC9jnf1tDID1Li8QtRKcCFZOKg0BmJRN9SRuA7avm8JrK13rLzvq13pkR/k5Zm9lfd5tQp8UqdRJvAuBHq08ouWdDpPX/DAFaZMzzR0CLMcVL9Xk/GWu6tvRtSd0BlIeY8WM6MftEW9/JIkIvIvCgEkBWCx+uB0+2V+u3Mv5R1+lXBtDYCpSfcdL/y8YGN90iKvCgY970T12XY+AOBOJB0bVBkBDOY8qRFlviw9E14JmF/xJ+M59Q+bDSfBp82d/m1PdJ0xE3GUvGGFb/BbjWjdtkA00L/G8yUnrieg27zXVnDQnJqL7Sm56aCfal8Bbvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1W2Fo/Z2aCaXTJAoTwyLzOfNMwAMgAPnDhqJGL/Huxo=;
 b=bjPFk1wXurgQhFn0SKis4gMjzK+qu/zkDedlzpRcC5vj9f6nEw1YfGOafVn7QP3AweLko3QIJJGx3n+fmEMxOUaXkqEjE4X0UEFcxw8z5GofNjPZROTxTHEAsjSE+QCWWe79MTxk06F1TirzRutd2pspMgGwO63m0WDcOMex3W1jpRoK1JjQ9HHZWQxvkPIUPsQxVmp3pKl+nnkbBt+vV+h568OphUUAr9/rCt3zIUmew5OCc6jvOZYqUcaEnbGQXDh8YARSCLuh5IRDw3UVJVT3oL5oKJyPfGXV4zZ/7qa1hwoPnh/1XEiLdFgKBnLbSsyVlx8H+dTzkuXardgTDA==
Received: from CY5P221CA0061.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:4::36) by
 PH8PR12MB7422.namprd12.prod.outlook.com (2603:10b6:510:22a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Mon, 27 Mar
 2023 05:38:22 +0000
Received: from CY4PEPF0000C973.namprd02.prod.outlook.com
 (2603:10b6:930:4:cafe::3b) by CY5P221CA0061.outlook.office365.com
 (2603:10b6:930:4::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41 via Frontend
 Transport; Mon, 27 Mar 2023 05:38:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000C973.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Mon, 27 Mar 2023 05:38:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 26 Mar 2023
 22:38:13 -0700
Received: from dev.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 26 Mar
 2023 22:38:12 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>
Subject: [PATCH 2/2] nvmet-tcp: validate idle poll modparam value
Date: Sun, 26 Mar 2023 22:37:24 -0700
Message-ID: <20230327053724.62363-3-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20230327053724.62363-1-kch@nvidia.com>
References: <20230327053724.62363-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C973:EE_|PH8PR12MB7422:EE_
X-MS-Office365-Filtering-Correlation-Id: f8cac9da-6b98-4fcc-f24e-08db2e857a69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	iRFHf/VOmhZCM+pxh8uGIG21m7xANdqYamFlxwl3GfN88mUS2qqOSNRasJjY99Q5Djr91Uzc5YF3k5TyWmu4lKFQJLuSpP0SHNhzB/qFsH8QoTDW7LgujTUI2x2304U4jCpGoHKDX8EMOsiBrBrHDufFkHuY9gWA08J1fCATQOrwpUxEjhNDUz1PzfV/9ruc9FgH8BQ1JfzBYs+Y4GIq9kYYR2YbI/NzfGiwiMq46rHHK/5EQPWMEqqEHf6ERd54+/fOsOSwTF5W55jtNG2ZFGI7CByYQNA6BKWvKGJKqNWap77EjaZAwNOFpFzCz1PIvOzoaQPAJ+upGwwbFEarejLhYOEZFgZ/UaI56r+iiNUcZe1te7ymLFds9g3pPUpj5nzvE9hooNsU8uV8qnH13p5EtLOJRgcS1jlNDdQjaukliK6S5ChVqt021v3ChnNYATVDuQ91G0cuI3bUeU3F+6Y65KsI4YRTDD2Cm678/KRNqotAyuagH9vEe2g+Hr9l6X+GgJuEDP/HGTZ6JS2Ma9W0xnP8zPhJDhC2+DWYGJcIg1FAYM5kGUhcd7law8sR/zr/+Bf0xtsQuC4tvkryxFwi6oErvrQ/1DNwn3H7/v8I7miBc6l4baMLjNsvU9xAf/VsEg1Qq4CigvpYhvGBBYcwrcdGzaLEjf6FO2GXF6B5rZ/Pv8HIyZX3albB7Km5bHsMvzFgah15o9uDu7Z81/7q4Bct+H33yoWLZTR2NCB2Iel0htGlQOKt8BwCqOLZ
X-Forefront-Antispam-Report: 	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(82740400003)(36860700001)(41300700001)(36756003)(47076005)(40480700001)(356005)(16526019)(336012)(426003)(186003)(7636003)(2616005)(83380400001)(70206006)(478600001)(8676002)(316002)(8936002)(6916009)(7696005)(40460700003)(2906002)(107886003)(70586007)(26005)(5660300002)(82310400005)(4326008)(6666004)(54906003)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 05:38:22.0786
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8cac9da-6b98-4fcc-f24e-08db2e857a69
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	CY4PEPF0000C973.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7422
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230326_223826_180170_A396E759 
X-CRM114-Status: UNSURE (   9.40  )
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

The module parameter idle_poll_period_usecs is passed to the function
usecs_to_jiffies() which has following prototype and expect
idle_poll_period_usecs arg type to be unsigned int:-

unsigned long usecs_to_jiffies(const unsigned int u);

Use similar module parameter validation callback as previous patch.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/tcp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 85ffcc8d0f99..ed98df72c76b 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -61,9 +61,10 @@ MODULE_PARM_DESC(so_priority, "nvmet tcp socket optimize priority: Default 0");
  * using advanced interrupt moderation techniques.
  */
 static int idle_poll_period_usecs;
-module_param(idle_poll_period_usecs, int, 0644);
+device_param_cb(idle_poll_period_usecs, &set_param_ops,
+		&idle_poll_period_usecs, 0644);
 MODULE_PARM_DESC(idle_poll_period_usecs,
-		"nvmet tcp io_work poll till idle time period in usecs");
+		"nvmet tcp io_work poll till idle time period in usecs: Default 0");
 
 #define NVMET_TCP_RECV_BUDGET		8
 #define NVMET_TCP_SEND_BUDGET		8
-- 
2.29.0


