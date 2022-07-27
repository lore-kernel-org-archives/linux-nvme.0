Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55898C04A68
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jul 2022 21:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uXWce9ptda4mZi21RiFOnOdoTwaMvXtzYDbMLFuILaY=; b=rXfYCIqBIQEPlnx+xEhScbQbG0
	IEs8J8X1DW+yeHtU/n63kELoA7l11xQD0EbkIsDaHih12hyByrE/y9C71A8YTxxHvV/ty74Fw+uB6
	ufqhFMQs8kprqez7P1azTkXN36eSaTGDL5bjUo92XhuI0uM3k0tqrJ4pC2zQLj7wFvsAwYs1lLe8y
	HRQb58eGdIxes5uPNyXbyYD+tgwGl5VqoPZHC8COWlOSDcNaq/ecZGtwHVEMd554xgFxyPlFFF332
	+PK+XwqVxw5xdbSNULgAgR+DyoRogrx4hSvj9ywrx42sA8Ti0DNYpB7xQk1U3oUnOyUHrHWS6w+Fo
	jgS6jscg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGozQ-000j91-Qh; Wed, 27 Jul 2022 21:54:48 +0000
Received: from mail-dm6nam11on2057.outbound.protection.outlook.com ([40.107.223.57] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGozN-000j7Q-Kq
	for linux-nvme@lists.infradead.org; Wed, 27 Jul 2022 21:54:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrV2ju4P3yBAb3TriY+LA52Hi4umUaX0Klym2hgVrNp8Cr0aVrkKsJP6rH/WABQ41GeaVdDgHd5SXEoF1l1Ys3BYi759HIC0qWBZEKS7N6Gqun2E75vDQHbfFKNVhzIGx0ctqI3942DnIAxKHSxviDggTS8ViYbVsldbbmqFz0eHcGX444a9mVgxqUkQyoqYj+oR8+59iPEWpGXpcTa6dcLF9L861rbhqdZaTDS4dmSZRXS1wmkhx0thdWjQV9w+zcKDRGsUlkHvnSgyG4vL1i+1h9lVqnXWU4ogvHbhcOCANPUKJItrqIOIT0KSZuZhzF5pmh/Qphha/LwUv+qh1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXWce9ptda4mZi21RiFOnOdoTwaMvXtzYDbMLFuILaY=;
 b=b2WgEWmpw8pRJjqvchSVM1VTEesdblT9GcwIuFmeE7XBWdLG0szsMyBDsR/iSYZXg/P0zwbcUFwPzt+RazcjWjHDy3V7qLD06cUUeU8XIy+hEuS11MyFqCFuWeh/zuOekkHnHcGwmuGm/bLU4f5xpd8fi2x1cLUzpak//48v9CKG26k4Aoof622z6YiaDxtRgn7Rxn9S7zs3CffQ7X//4im750f6lHsAxtQtt9Tfk90pxiRWtNF26YHAof8AFgw1pCwmNOF11+ECR2pwY7Z9zMT3Pgh12UTEu9c5W+Vx2WI+MaeguCL7N5sl3tEeDzsT3t6ShzmqJXOm8dCzIaV9/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXWce9ptda4mZi21RiFOnOdoTwaMvXtzYDbMLFuILaY=;
 b=ZBUyVbm9vjdRhMHrSvtX+C5KVlJB5FaYW3reOAmqW2HInsWMFMkgAr1cVK6SAW4vzVfDwhmJtacHQF+ldDx5vmiJe7kaQsQyWMpgWEjg5WkZn8C4CczM8Kf9vhnefngWXfK696GIBlGJjxGzOeu5DM5tZPIdub8LYBoYgjuErGKGAlQNZ5geE2Wge95AiVnrMOFqI2idqHfu8BGCiw3jfg9Rk0nkqYxh42ZdWfx1kEYAhqRGV62kG83IoahvwllbfYXZGOClghzLWNdx5w38sbvFGBlsM8op/s1maQdqpioqi98u6bQV+2mpSo/SlfV2BGab8GSRYQf8BCQm8lJSig==
Received: from MW4PR04CA0296.namprd04.prod.outlook.com (2603:10b6:303:89::31)
 by CH0PR12MB5124.namprd12.prod.outlook.com (2603:10b6:610:bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Wed, 27 Jul
 2022 21:54:42 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::6e) by MW4PR04CA0296.outlook.office365.com
 (2603:10b6:303:89::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24 via Frontend
 Transport; Wed, 27 Jul 2022 21:54:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5482.10 via Frontend Transport; Wed, 27 Jul 2022 21:54:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 27 Jul
 2022 21:54:35 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 27 Jul
 2022 14:54:34 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <kbusch@kernel.org>, Chaitanya Kulkarni
	<kch@nvidia.com>
Subject: [PATCH] nvme: add ctrl state machine pdf creator
Date: Wed, 27 Jul 2022 14:54:24 -0700
Message-ID: <20220727215424.5252-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 371a7e51-d56b-4865-7d24-08da701a9c2d
X-MS-TrafficTypeDiagnostic: CH0PR12MB5124:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	og05B4SJqoqeYIAdWjLM7P7wTrsELq+nNU7xn3oQKVzXicsdkaHPA48OqTox5RCFVef4ijpz55iF5dCfAq94WnNw8m6qpWdGoZQ13KPT1TgFlW+C3liC+nq7viIncIPKqTepkgi69xFGDX8C1RphB3a09YGPnoJPoZXxD9XtCNx0sIARKeqimzebYAVQwLiaZ3GUJkgjz2PpC/vY+KF0xDjaPPuN04a4uDT4uJVpQn2O7aROzHPDVnx+XrIPjSmYQTETupJ+pEoJm9QpFg6lRECUJCq8TqZB2sf5ZaaPeyWbXo+i8ywEXg8sh/dTBLLmkkLs87Pf1LVPCVjwHAapkg/ci1XoKsb+wOPsmNngeSatEFGYJApOyUQNXX1iVt4MA63sq1XMrYvrwNo0yyMwwYFe3TnCRGSDy3OE92hQbfWrqJwNwwPpvVjhxC+aYqkqFybxseLwZWCqCa7EmnNltgzVnxQBGxOK3rQ72Cjo0/KlA4ayFJUyJFfNARHSh3l5UWSeQHWLZ95So5Qyloi8EHlkIkylwFsX/xPWt+tZ/NlQkiOLoOxZu33Olr2DJ2ICchH0bG9BrjNeGEMN9oZ0fNvlbPBV1fLnHdralgSceK4O2H4KZHjKDP2gmRLnMguDEYbO8ro5XlgQ6RZk8gM8zb0gBPq+ErgW6i2DkDScu6V7dh/iWMWbIMExw9GT3BjEInBRdxZko5phhyPejsJlf7NpW8QKcMhJ/7Lx7SCJPAvWNixQmR6Wnjn6TCI3ddNA7DYUsJqM5e145FQDAOr+a4aMS8qudcBwqJYU4qhOy9q8brr30nBE27f5R2QbxXVwflXEcYACpxZhsrN+T38oTQ==
X-Forefront-Antispam-Report: 	CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(39860400002)(376002)(136003)(36840700001)(40470700004)(46966006)(8936002)(5660300002)(70586007)(40480700001)(4326008)(82310400005)(40460700003)(186003)(16526019)(2906002)(8676002)(36860700001)(70206006)(36756003)(81166007)(356005)(316002)(82740400003)(54906003)(6916009)(2616005)(26005)(336012)(47076005)(426003)(41300700001)(107886003)(478600001)(7696005)(1076003)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 21:54:41.6940
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 371a7e51-d56b-4865-7d24-08da701a9c2d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5124
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220727_145446_263056_54339A76 
X-CRM114-Status: GOOD (  11.71  )
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

It is not always easy to read the NVMe Host controller state machine
quickly written in C when debugging the code for various transports.

This adds a simple dot based state machine for the host controller that
creates pdf. The resulting pdf is easier to understand and process.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 .../nvme/host-ctrl-state-machine/Makefile     |  4 +++
 .../ctrl-state-machine.dot                    | 27 +++++++++++++++++++
 2 files changed, 31 insertions(+)
 create mode 100644 Documentation/nvme/host-ctrl-state-machine/Makefile
 create mode 100644 Documentation/nvme/host-ctrl-state-machine/ctrl-state-machine.dot

diff --git a/Documentation/nvme/host-ctrl-state-machine/Makefile b/Documentation/nvme/host-ctrl-state-machine/Makefile
new file mode 100644
index 000000000000..916ce24b1b2f
--- /dev/null
+++ b/Documentation/nvme/host-ctrl-state-machine/Makefile
@@ -0,0 +1,4 @@
+all:
+	dot -Tps ctrl-state-machine.dot -o ctrl-state-machine.pdf
+clean:
+	rm -fr ctrl-state-machine.pdf
diff --git a/Documentation/nvme/host-ctrl-state-machine/ctrl-state-machine.dot b/Documentation/nvme/host-ctrl-state-machine/ctrl-state-machine.dot
new file mode 100644
index 000000000000..9c277112c5df
--- /dev/null
+++ b/Documentation/nvme/host-ctrl-state-machine/ctrl-state-machine.dot
@@ -0,0 +1,27 @@
+/*
+ * NVMe Host Controller State transition diagram
+ * dot -Tps nvme-ctrl-state-machine.dot -o nvme-ctrl-state-machine.pdf
+ */
+digraph NVMe_Controller_State_Machine {
+NEW -> LIVE
+NEW -> CONNECTING
+NEW -> RESETTING
+CONNECTING -> LIVE
+CONNECTING -> DELETING
+LIVE -> RESETTING
+LIVE -> DELETING
+RESETTING -> CONNECTING
+RESETTING -> DELETING
+RESETTING -> LIVE
+DEAD -> DELETING_NOIO
+DELETING -> DELETING_NOIO
+DELETING -> DEAD
+
+NEW [shape=polygon,sides=5,peripheries=3,color=lightblue,style=filled]
+LIVE [color=green,style=filled]
+CONNECTING [color=yellow,style=filled]
+RESETTING [color=lightyellow,style=filled]
+DELETING [color=pink,style=filled]
+DEAD [color=red,style=filled]
+DELETING_NOIO [shape=polygon,sides=5,peripheries=3,color=maroon,style=filled]
+}
-- 
2.29.0


