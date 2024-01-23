Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 999A8C47258
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 22:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FQhkmC4Ct/tdFdTzr3HNNHGv51Kg7FfCnw/gm7FO7FA=; b=r06ek29ZMOhKEf4+gsaqzjxW61
	XR1mQcTXlx5sbaF6LIcC2uuF6jKMl+MgbXUJB0VKGesLEF6C0v+7NK9jBH2L9W8UhGmnt8Hq7RDsC
	WzyPtszg+gV90j110Y///qcurQswpaULua5K+2youVNMwITsRzwzj6gXdGV9AUYwYNFCY7gz6vP4Z
	njuXjsfsXuin/jutRhdCYkuHgip9FDvpKOFjCgPNBRRp9EaNxpqi8YbLR5cN/igAWsxg1S6RBXK2B
	t1jdx8s9yBq62cyEX+3of/pRQiWyhsxOtpRXAERrIhko9lRui5QQCS2BrGD5cy2hoRBSO2dNw+n6x
	JHLeXhAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSP2H-000d7B-0b;
	Tue, 23 Jan 2024 22:14:25 +0000
Received: from mail-dm6nam10on20615.outbound.protection.outlook.com ([2a01:111:f400:7e88::615] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSP2E-000d6c-2J
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 22:14:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1R19OZH61LNQJS2zCEtg0hfXdzzpy7dv+RnqHi5VU0KcVC5MzUCYT3mULY5cuEuF5Nfp6IegHx5KdR6tPRSSPRVCXNz5ZQEQeV5Mbs2NwqD4zGSAFt10RXtUd05zf2CnW6a4UziNJjkrTdl8vSU6zRwiJcw8Nh3S/L7fShMJVZ0zw7+/UTWk8NiKmF0A5Fvz3wVv7++g+SNOColb5ZoMI63SeU60Qws86OvwLLKNMOyAFamsTPCmqYR1hlle/MBphNxtPjGLnj1+aPo6yUBb9NKA42/lJhKZQOh544ajH9RFYvN/NuNFt1y6nV+DnH5+ddkgW7B4gx3ZY4INI2+Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQhkmC4Ct/tdFdTzr3HNNHGv51Kg7FfCnw/gm7FO7FA=;
 b=fsQX0uS/9kCnJQWT6dCo4efPJ50N65HYE/oYrZ/vEvHCgbL/RjExxUwYozd/sfZQTpsMTWibjfc0QGI8REGNmZPvYtvu2GA7CHEgHnr5zI6Sj6PCEj3vS414+WAPL48ZQmPnG15zAuluxUD7zQsU7dUNyM6rvp61w44NQAyLxkiFeto/NY1m5Bt+o8/2Pu6U0aPSwSlwhd9YM7Lm3ODWTX9Du1WzNrrO3TENx+sl4ibe9GXkXbpbLjHZYIWHGWrINIDwoJXTStYkVz3X5CtXDC6TKwptsGQXu9jOlhp3D3aV/II/tpQiQ/wq3BzEC3LCburziRi8NLDFDpwCIZo7DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQhkmC4Ct/tdFdTzr3HNNHGv51Kg7FfCnw/gm7FO7FA=;
 b=jWK0rTGxRvDrmw6FOy8afcMbEytmllFj1opVVpKOiTPAZdWvstVsWt7D6dkmna6AcHsr/R6CM482o2jakFcJUQcsy14sqtfQm5EnxtIv07gDViyLTure0dcwwTqMBzZaNlzgR/gE8D67HabtsKxFj1AcouLxesqD+AlFAsQQql/1DyWPOxdQb07ezldHOPfMd6TX7WyXJEo743dcvXbNqAjD5e+wIYbicxTr6jor5Lchrl4IB24jPcATQSOS7At0L61ImN/QFhbfnH69nnUU+9E8/oja5HBWJ96hKhPVUHuJK5FoLMNdwzdirVEwDszdMKgcVZT9GBiearplZqm9PQ==
Received: from MW4PR03CA0076.namprd03.prod.outlook.com (2603:10b6:303:b6::21)
 by SA1PR12MB8859.namprd12.prod.outlook.com (2603:10b6:806:37c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.36; Tue, 23 Jan
 2024 22:14:11 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:303:b6:cafe::df) by MW4PR03CA0076.outlook.office365.com
 (2603:10b6:303:b6::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Tue, 23 Jan 2024 22:14:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Tue, 23 Jan 2024 22:14:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 23 Jan
 2024 14:13:50 -0800
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 23 Jan
 2024 14:13:49 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <james.smart@broadcom.com>,
	<sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V2 1/2] nvme: add module description to stop warnings
Date: Tue, 23 Jan 2024 14:13:40 -0800
Message-ID: <20240123221341.7902-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|SA1PR12MB8859:EE_
X-MS-Office365-Filtering-Correlation-Id: f78adc32-eb83-40f4-e65f-08dc1c60a02f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UO5pUxtpJoVXZBps/Z1bLmdR3I+sWg/D7mbQvJw22ulf7Mz3cfewxULBhiNc8z0ktGZD9rb/BB5YghAqRYvHRebGyx/tUtoXgMiv/hCQzZIwxVraPsjTVpEv5zNk3fEDl/PFBw96VEJXAviNNBMEuwyIo9GbXwKbSE+Fr7iDZREt07EBqq70rwVk8VBh95zBbX60ywMBhzIrH15hSOupAxyKb0tOz45u54fWicNmdHmcUxXfofw0Ih1yLdUWLE0hq/WlJPruOTTGG7Nd67TsKpFUoh1dTEmXtwgVR0Zy94JczQCkeJ5MzfmtrSMNx7ZorfigU8DU9X89rCgRlbHIcwtlNsrBX56AxX384ErAFaQzn50WTRZ5lRXuMRyfsVsK69lkyp63TMCAef+MO58ZBzuAhzMXY+T50rb44+5yL17tdUEqnUkSJcCOwDSNmq+4o46kn79AGWJrmDnXwnqyUhNT2dcCG5ZRu4ukNrzMu2SbyTfEupcuJmiPgc75tMgXabptj7HCI7uljz05KUNo3ZxF8VvDLwE64abe7tiNUIjSeruF4+wKVOiR/ZY3N1nX6WEKcYHF/+ukUCTqzEjspUf4lbkYU9/oV/1uFICV7vbScnn75OQxTfg0oGKP1eHU7PlFYbxIlJe93ZwR3choyNb6QWJtQf/MzdO+ogh26vexlHHN2wZ6NcPVc5++08G8bnrc6AIg9zCvQbC3u3lk1apjtOM1l/x1hqfkB5njbSNmkaJx0XpI+/SnpncmIgYxcMHYQWgt8IdM8nGuWPp3yhqLykpB/Fw3dG5ednSPoVs=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39860400002)(346002)(396003)(230173577357003)(230922051799003)(230273577357003)(451199024)(186009)(82310400011)(1800799012)(64100799003)(40470700004)(36840700001)(46966006)(356005)(82740400003)(36756003)(40460700003)(40480700001)(426003)(107886003)(83380400001)(336012)(1076003)(2616005)(26005)(16526019)(316002)(8936002)(70586007)(70206006)(8676002)(54906003)(478600001)(6666004)(7696005)(36860700001)(47076005)(7636003)(2906002)(41300700001)(5660300002)(4326008)(6916009);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 22:14:10.8293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f78adc32-eb83-40f4-e65f-08dc1c60a02f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8859
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_141422_796140_4893EF26 
X-CRM114-Status: UNSURE (   8.17  )
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

Add MODULE_DESCRIPTION() in order to remove warnings & get clean build:-

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/host/nvme-core.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/host/nvme.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/host/nvme-fabrics.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/host/nvme-rdma.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/host/nvme-fc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/host/nvme-tcp.o

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---

V2: Update description text. (Sagi)

---
 drivers/nvme/host/core.c    | 1 +
 drivers/nvme/host/fabrics.c | 1 +
 drivers/nvme/host/fc.c      | 1 +
 drivers/nvme/host/pci.c     | 1 +
 drivers/nvme/host/rdma.c    | 1 +
 drivers/nvme/host/tcp.c     | 1 +
 6 files changed, 6 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 85ab0fcf9e88..0810be0d1154 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4851,5 +4851,6 @@ static void __exit nvme_core_exit(void)
 
 MODULE_LICENSE("GPL");
 MODULE_VERSION("1.0");
+MODULE_DESCRIPTION("NVMe host core framework");
 module_init(nvme_core_init);
 module_exit(nvme_core_exit);
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index b5752a77ad98..373ed08e6b92 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -1488,6 +1488,7 @@ static void __exit nvmf_exit(void)
 }
 
 MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("NVMe host fabrics library");
 
 module_init(nvmf_init);
 module_exit(nvmf_exit);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 16847a316421..e2308119f8f0 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -4004,4 +4004,5 @@ static void __exit nvme_fc_exit_module(void)
 module_init(nvme_fc_init_module);
 module_exit(nvme_fc_exit_module);
 
+MODULE_DESCRIPTION("NVMe host FC transport driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c1d6357ec98a..25eb72779541 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3543,5 +3543,6 @@ static void __exit nvme_exit(void)
 MODULE_AUTHOR("Matthew Wilcox <willy@linux.intel.com>");
 MODULE_LICENSE("GPL");
 MODULE_VERSION("1.0");
+MODULE_DESCRIPTION("NVMe host PCIe transport driver");
 module_init(nvme_init);
 module_exit(nvme_exit);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 11dde0d83044..0f48ead986ec 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2400,4 +2400,5 @@ static void __exit nvme_rdma_cleanup_module(void)
 module_init(nvme_rdma_init_module);
 module_exit(nvme_rdma_cleanup_module);
 
+MODULE_DESCRIPTION("NVMe host RDMA transport driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d058d990532b..4393cf244025 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2826,4 +2826,5 @@ static void __exit nvme_tcp_cleanup_module(void)
 module_init(nvme_tcp_init_module);
 module_exit(nvme_tcp_cleanup_module);
 
+MODULE_DESCRIPTION("NVMe host TCP transport driver");
 MODULE_LICENSE("GPL v2");
-- 
2.40.0


