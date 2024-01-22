Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F55BC47DD9
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jan 2024 14:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=y6FUhxXg/Ibj3J2cyUZiPQ2KH/GykR8blTgMr3f+4OQ=; b=Y2asaixkUicyTnMYCDoAmrcdeZ
	3oHuQyqiKCgT6h5utKfR8Anu9x/pjDIT1LWV2Juwp+SVa6Fd+uTPHZt+6CmYPDJhmFfdnT+BcpQqC
	RdO7hAf6emM/lEgNpiac5omKU/+N4MQTNNs3e2lVqqhX+3CjVdoshxZZHrSZoelZVO4Y7uMU9Ytn+
	04zHogukhKl6zgjIwEo3ZrrKsKP/u0v2VhybicwPe0bma6WJzMH6di43rXIT62MWuGxOH+fPsl8Ud
	UH8f1Q/H6acgCipdlHYWfBeBZJc2TRkEuv3iynXHp8x8Nw8QRppwISY0MEwgN+A3WdSqjeWaT5Mu8
	uuqwK5/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRvk7-00CVl4-3B;
	Mon, 22 Jan 2024 14:57:44 +0000
Received: from mail-bn1nam02on20600.outbound.protection.outlook.com ([2a01:111:f403:2407::600] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rRvk1-00CVgD-2b
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jan 2024 14:57:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPVGvVWbSzUCesD+k3KZH2Qw3wTDQ4ok13wAYxNKiJW+lZCvJApYWI2/JqtTwB1tvS3AF6nRWppXctq7ds4eiI7niekkv2uNlThtbJeJPZa0cXCDbUWnO6c4m4zasitvnIUMEMkIxVmfIvQ9+Y7pBJ9a4U7LONHRpcsNFjl/jlaMccXFfdnJN2oBOYEAacsocUb8U8eI0iB58SwUrKy1xwK99KAHUZHpL3fPwccA2iaa8O2Ue8OTY2dDeNe28XnWbzB4txe+/Ty4+4ri9Hc8Dh3bx0taXYE1dg09aS0E8GDzpbCyV199P8a2zymtrZMqfkONkyUPSh+h7YXNw7FBCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6FUhxXg/Ibj3J2cyUZiPQ2KH/GykR8blTgMr3f+4OQ=;
 b=S6cmNAV81fnoa6zSez5oqlVE1EJm7rxpJWs0KjVp7xTBmVskCR4jWnv7NuKdYHV5Ca/xQEtTfbRDhT9XjhLMgmSNt2gj+/vuf7uQhDRD7UfORMgR3XsDaMMzPe7rMxiRYUh36i2AVB2gIJeTvI3DErajkof8nyf7kebM+gFRTPtmvYsXM2FNU+Vxv1JEgkU5SY7zA/PVSvkawnwC7QM/gbszw8EVYrOfgWMDU7Wbd/Aabp4j7krlBDBCVTwDkJx6y1rKlEnD1b2rJ+DakASDO0bsV5ONoUrIDfUpfdloOqnPR9qN8DqvsAKGQQmI5q0Wb89oI8RbSxyQm+1czeaPUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6FUhxXg/Ibj3J2cyUZiPQ2KH/GykR8blTgMr3f+4OQ=;
 b=o8hfPKk5C7lKEUjqKQHc6zWhi/9fesqk6BpnOKXAzV1QkAKJVHADUrD7Kl1HNJBQglcPlMdGFuW69LnComP845eP++UnK8Dw3s0sg+ki3v/IhsGs14anbjT7zHCPOcdDunPwq8aRwMFDamMNMVsF39q9t7mhRdFEA3TplH1vuwBW77QH/Sz8qz4XePmqQnAdD59KRohoPq6rI2e3Lpl4sV8705MH7K53hi62c20Z3jfRPH6dvLe+4y9xeQ5nCrTq8k/mD2XTQy/OTJSWY3YwwyEPaATGHyASJit83urZmKLBVwok5lKJ76WQkHCVvKiwfsWmoqON38ecZBjCxWKkRg==
Received: from SA0PR11CA0061.namprd11.prod.outlook.com (2603:10b6:806:d2::6)
 by CH3PR12MB7498.namprd12.prod.outlook.com (2603:10b6:610:143::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 14:57:26 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:d2:cafe::94) by SA0PR11CA0061.outlook.office365.com
 (2603:10b6:806:d2::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16 via Frontend
 Transport; Mon, 22 Jan 2024 14:57:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Mon, 22 Jan 2024 14:57:26 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 22 Jan
 2024 06:57:03 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 22 Jan 2024 06:57:02 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 22 Jan 2024 06:57:00 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>
CC: <oren@nvidia.com>, <israelr@nvidia.com>, <dwagner@suse.de>,
	<oevron@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v1 0/8] Enforce uniform metadata settings for ns head
Date: Mon, 22 Jan 2024 16:56:51 +0200
Message-ID: <20240122145659.5574-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|CH3PR12MB7498:EE_
X-MS-Office365-Filtering-Correlation-Id: e96baf92-46b3-4d0f-63f2-08dc1b5a727b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rQWUmGtAl0qFDLPycRKzRvj45drLmVCLd9r98GAyQ0C2nD4+z5t38eC7CWiE9N8nS3bP8vAkOg5hI2uxXmL2MYni/T3eBnJJrZEA59/H4ID/0ejSp8k/91A79wthSyXIVSBOk2m3Wg/A+9qvCoui3QBrrTIeIZwB4GY7SexmIx9hNRL2ogAohlo7FZ3XNzS9iAQrdQvC9+Lj4ObtIerPyKKbLKeNy1YtLoOlFNdNfqeEYmjLcA7Wme/nd9sNNf3fncNCblwwd1Muq1LD3EVJX3T6VRHhFsWJwFclRNmRutEZs1ysTUOAcoeNx8cUYm0kCO5TIWKJ8D9kXrHlVMf6B3ZHosaADCZH9wKAO9PLv7k05gBLgekvvfpA2mp1FmrazQkovODm06mj+OdLjn8AJkoG/4+X98Dx2/o1Ha/3ejFUgrikdSj08TDoEcWRnqsH4gS30/nW8sKXQ/03qJ2ZhLkIkR540qSMAHTvTkX1DuOxYVJ8GgXCqQAgEDJDNNP1fbBicwizpP9AFiype1W6hjJEI3D3rOqeN7YRQw57T+zcpvZG6t/FedpHXwgCU5yWnTMkvdpx3GOn5rMkzbbv0irv/kaGJV/uY1bc/yJkg9eTPsPJZZxDRE8jMRbt93l9WSTP8KTwVh7azsoB2U8J3BDFjtBZITkZg31NfifgisUfwHSUQ38cQ/XP1js68BFt8sDQLFCCkqROUh3AtRBepT+O/t8kDtqikA2MXGpikM1JkuGTsXgZU2d1jaHseHsm
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(346002)(396003)(230922051799003)(451199024)(82310400011)(186009)(1800799012)(64100799003)(46966006)(40470700004)(36840700001)(2616005)(5660300002)(336012)(6666004)(426003)(82740400003)(7636003)(356005)(47076005)(83380400001)(40460700003)(1076003)(36860700001)(40480700001)(107886003)(26005)(478600001)(70206006)(4326008)(70586007)(316002)(86362001)(54906003)(8936002)(8676002)(36756003)(2906002)(110136005)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 14:57:26.0057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e96baf92-46b3-4d0f-63f2-08dc1b5a727b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7498
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240122_065737_851182_75EB5DBD 
X-CRM114-Status: GOOD (  13.66  )
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

Hi Christoph/Sagi/Keith,
This patch series uniforms the namespace and it's head metadata
capabilities and definitions. It fixes a situation where a namespace
with metadata caps is exosed to a host controller without metadata
offload support via one port and to a host controller with metadata
offload support via second port. In this case, we will create separate
ns_head and won't use nvme-multipath unbrella for these namespaces.

We've also developed patches that allows the user to have a more
flexible control on the metadata offload enablement for a specific
controller (this control is using new nvmecli flag that is introduced in
a separate series).
For example:
"nvme connect --disallow_pi --transport=rdma --traddr=10.0.1.1 --trsvcid=4420 --nqn=test-nvme"

We also handle the case where the metadata capabilities of the target
were changed for a namespaces during the lifecycle of the controller.
In this case we will remove the namespace from the ns_head and will try
to create a new one (this will create a new ns_head as well).

While we're here we fixed also the transfer length calculation in case
the block layer doesn't generate/verify metadata (in this case only the HW
will do it so the new calculated transfer length value on the wire should be
written in the CC.SGL length).

This series is based on nvme-6.8 branch with 2 fixes added manually:
1. nvme-core: fix a memory leak in nvme_ns_info_from_identify() [from Maurizio Lombardi]
2. nvme: check for valid nvme_identify_ns() before using it [from  Ewan D. Milne]

Israel Rukshin (3):
  nvme-rdma: Fix transfer length when write_generate/read_verify are 0
  nvme-fabrics: add option to disallow T10-PI offload
  nvme-rdma: enable user to disallow T10-PI offload

Max Gurtovoy (4):
  nvme: use Independent ID-NS only for unknown cmd sets
  nvme: set uniform metadata settings for ns head
  nvme: allocate a new namespace if validation fail
  nvme: add nvme_queue_scan_sync helper

Ori Evron (1):
  nvme: sync the namespace scanning during ctrl start

 drivers/nvme/host/core.c    | 430 +++++++++++++++++++++++-------------
 drivers/nvme/host/fabrics.c |   7 +
 drivers/nvme/host/fabrics.h |   3 +
 drivers/nvme/host/rdma.c    |  18 +-
 4 files changed, 295 insertions(+), 163 deletions(-)

-- 
2.18.1


