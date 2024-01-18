Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D82A8C4707B
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jan 2024 05:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Atu3XZCMuYPgP33h/OlWAREEv5vw8V3KRnsBG0hksH8=; b=MQalyZcVdplMjuoJYALMH2YNSm
	tEH/GrNkVdZsvq3eTs004Mh8QVwzd5E16AISwS/Tdk5kSg9XV+o0c0c/qGgqe3j/Qh29ah9tsaf1M
	zYesZtQf6RLRsHqPK/W3EFXO4qgcIm7HDExOLmS9+z+Fm+a5301NR0ExZ19ZIlOl0OMfrdF15Zrve
	JvKWOXghKjnzg61cMERMqlZJoXSpLy17Txd4rqDQ/HIyBI6yK/MwYc6iMVGLfkVtpa+7Bw69eZUOh
	7rgkyGFEkbKC34c60JkuX5IGdY7afpmi6pEvPz3lEj74TYg3zV2pZVGtTaebWzLiueCoxj4bRNbaO
	waiipLVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQL59-001iT4-1W;
	Thu, 18 Jan 2024 05:36:51 +0000
Received: from mail-dm6nam12on2073.outbound.protection.outlook.com ([40.107.243.73] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQL55-001iSL-2j
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jan 2024 05:36:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHxKRg0eCM7sjaGiO6v0wVbmavdZ1Vcv8uCrvOXC9E6SMLnEJkKvoP85EclvUAbpVZG1ZaUFFKAt5RbuF1ona5SsqZxip11QFgkxntmD1PYP0cqhRcpQOCxhzo/FLYZaVMZXherIY8oHsW/1GdX97X4AO6hq1LM/RBQAL3Idng/Hvk3DOhHYdJXvUFNsLndfxW/7ZQsvl7EL1o6G2xWOpi28bRGxE8cZRoXOaNeFUArde4lZKdycuIR9+CaWlJS65C0XS0SRufaHz1FpQrwzBP30cSeHjnPD27lctWNd6FXm8OkkEJEr27Caendm29pPnbhotUcnKXNbGwJ6xBZ6Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Atu3XZCMuYPgP33h/OlWAREEv5vw8V3KRnsBG0hksH8=;
 b=OkhSCc2i/KksRQrV21nqGV3I6HZu8EgAP+emgHWg+14N8FhZlwuL224Ygw0uiSH/YsJXvCRrPv5TBsI7UJhXOn9QbMMmHR+0Hd6rB6zDhZjFSdFG/i1B0NANt9PtJkAWxjB1OUkl9QTDMFI0gnjWWCmL34wiWsVTmt1i4JZVfO1uJ0dDrqhUh1Mh2dqp6H9yOJ+orqJCBA4JXuTcwQtDzSqSftJGT/aCRJ/SEwzA97J+HePNJnRFqpuxkAVTNbxWRvI9vU/aLF60fc9EUHgkX7Rf4CREIRE0TNPSnFS7WLZ+Fl/899sVNXwf+oV4jZY1rHxit91+fHtY8oHIDaBAqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Atu3XZCMuYPgP33h/OlWAREEv5vw8V3KRnsBG0hksH8=;
 b=h7nQJ2EzO+D/GOzNE173gorqTETNRWjw+RiInnnoA5k/Gwdqo9/e2UF5S5T3yzCOT3sRk004eGZIEquzSHVaPXQngVWoqz9R+y4PqQsBs2lx+DvHDu31m4x2Qrgb0N6GaNxziLYS3LQL3g9SbOU7VoN/3c0MjpnOqCazrllJIahXi7R3865pauSqpThOSyxAxt636gcUzd484R3ErdUnhQXqc0Sx8JXmxOfl6At0heBIFLzvrpd6UMAC8vCRi7UBAUkoK/f14N4N+yDyA7GPRkFPi5w2Sia9DcodqNRG49NlME0FsJn66WkVAnrjONZr9kjyp9XndwIBhal4/4vfKg==
Received: from SA1P222CA0112.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::25)
 by LV8PR12MB9205.namprd12.prod.outlook.com (2603:10b6:408:191::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 05:36:23 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:806:3c5:cafe::73) by SA1P222CA0112.outlook.office365.com
 (2603:10b6:806:3c5::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 05:36:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 05:36:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 17 Jan
 2024 21:36:10 -0800
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 17 Jan
 2024 21:36:09 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 1/2] nvme: add module description to stop warnings
Date: Wed, 17 Jan 2024 21:36:01 -0800
Message-ID: <20240118053602.215765-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|LV8PR12MB9205:EE_
X-MS-Office365-Filtering-Correlation-Id: 45ad3824-58e4-4a23-2a92-08dc17e76816
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fWyvt81f4hHTr1dSy8AgaKvoBa22yXy2WB1jedU7NfdwNtdEFrozWNlfG9S49CKmC/RgbjrHqtWR53uVzRSXEtvY/86ILRtddZxFaXNpDCpIgc3aXRVs22+tH08tiA/qD3nAdLNN1JL0FHnqIekeeDT6+fhzRbzzSq7HDKOcej9o5fWCRYCb2bJ4SjvX3NDYi/awZ7C/DFUGgECNZ0svSJXfS0YTqwWOYIjo0qcHTUMSc4Hx7LC/lMOwBBbr6AjalZhaBiutdW1uwdoNLzcAz8G6YO3vS5O98Ar4HrREjcldFd2CSOxJpWawW3sqqddI2b7BKFkn/K9YQx1CEUXAbGL7gl+k5QjAk2611lx9gHEon+qvH6tJTq/HPs5CWzsG8haK2rPAX7pKhcuWSJXBzN4t5ji8LCtHRT0/xWJRFhalFVX3HtBAlFmKghtvakPk6F5j2PIzaKohUZMhDzNER9rtPuVqpEhyp0+uVFdhyJIsBdVWszcMuNuVONCZnN7oxqKqZ9Qk7C+i8eQ7IzGDnRNQKXwH8EwZnLI0THcK5/TjLB2AhUgruySBX6Ggcx6zY7yTMF2hPJCCytKFAgTyyWiBMdKu4l7Fw8hvm1cm+y/7DlvctfFHqG31swaIBPHjjV9dMAs0p/VcS3gNtXP9WbxJ9n1KUXm8hSuop1xl6NR45726pv+hgThCs7h7X5LMEqvICOx9nr3GQMFlIdPE0U7NuG7DU8oP39nMWypDsieT2uvI4fizeYEahWyfMwX/jXH2sZpAjWY2NcYhh5Rm2A==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230173577357003)(230273577357003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(82310400011)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(47076005)(83380400001)(316002)(70586007)(6916009)(54906003)(478600001)(6666004)(2616005)(70206006)(107886003)(26005)(16526019)(7696005)(4326008)(426003)(8936002)(336012)(1076003)(8676002)(82740400003)(5660300002)(2906002)(356005)(36756003)(36860700001)(7636003)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 05:36:22.9685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ad3824-58e4-4a23-2a92-08dc17e76816
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9205
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_213647_923039_B1B791D1 
X-CRM114-Status: UNSURE (   8.69  )
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
 drivers/nvme/host/core.c    | 1 +
 drivers/nvme/host/fabrics.c | 1 +
 drivers/nvme/host/fc.c      | 1 +
 drivers/nvme/host/pci.c     | 1 +
 drivers/nvme/host/rdma.c    | 1 +
 drivers/nvme/host/tcp.c     | 1 +
 6 files changed, 6 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8971af7fcb2b..fa14e16731c0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4856,5 +4856,6 @@ static void __exit nvme_core_exit(void)
 
 MODULE_LICENSE("GPL");
 MODULE_VERSION("1.0");
+MODULE_DESCRIPTION("Essential NVMe Host core functionality");
 module_init(nvme_core_init);
 module_exit(nvme_core_exit);
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index aa88606a44c4..ed2fd0a0d688 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -1488,6 +1488,7 @@ static void __exit nvmf_exit(void)
 }
 
 MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Essential NVMeOF Host core functionality");
 
 module_init(nvmf_init);
 module_exit(nvmf_exit);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 05c3159d42e9..522319a4d6f2 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -4015,4 +4015,5 @@ static void __exit nvme_fc_exit_module(void)
 module_init(nvme_fc_init_module);
 module_exit(nvme_fc_exit_module);
 
+MODULE_DESCRIPTION("NVMeOF Host FC transport");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 46d3897b8986..9801dbe09dad 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3529,5 +3529,6 @@ static void __exit nvme_exit(void)
 MODULE_AUTHOR("Matthew Wilcox <willy@linux.intel.com>");
 MODULE_LICENSE("GPL");
 MODULE_VERSION("1.0");
+MODULE_DESCRIPTION("NVMe PCIe transport");
 module_init(nvme_init);
 module_exit(nvme_exit);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 2e77c0f25f71..d93c863d036d 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2395,4 +2395,5 @@ static void __exit nvme_rdma_cleanup_module(void)
 module_init(nvme_rdma_init_module);
 module_exit(nvme_rdma_cleanup_module);
 
+MODULE_DESCRIPTION("NVMeOF Host RDMA transport");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index b234f0674aeb..016a3b7c0791 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2819,4 +2819,5 @@ static void __exit nvme_tcp_cleanup_module(void)
 module_init(nvme_tcp_init_module);
 module_exit(nvme_tcp_cleanup_module);
 
+MODULE_DESCRIPTION("NVMeOF Host TCP transport");
 MODULE_LICENSE("GPL v2");
-- 
2.40.0


