Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBAE4C47258
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 23:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0T+4n/Y1nEjj/Sf9Zb21jN/3DOKKALC3qaf00pt/eHQ=; b=IcB8fcAumzt8Z7QKZ07YWZrWGm
	hFi40j/nYDVzwvHxjCRbN7CZonkktCCRDG/2LN/hUjLZGfnOJA+l5gbqL7c536tk8j/7vyrufBoF+
	PiwSrsuOzTsOrauX0AvmdTBtY7QUB2SCOLfVZSnwWFseVDLNTRouX2lx0FZIvprCbPtqCrXVAVLzL
	VCj9tGjFYlmXf5H4yXYK0791y+j3bSD/pq9FjL71upYF+amgrT2GPMQ5PrqVgLDhmZpr5d0NtKQR7
	pCR/XVb2Tkjc/fCyePfxuh54dSXbaYIrRT2ElQd4xnq+qCUbGsFAbcXT+6q4YhjsRAVPfzTrHP8qs
	CxJbCCZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVJas-00000005m74-2woK;
	Wed, 31 Jan 2024 23:02:10 +0000
Received: from mail-dm3nam02on20601.outbound.protection.outlook.com ([2a01:111:f403:2405::601] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVJaq-00000005m6g-0NJD
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 23:02:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gyeUeUgSl5+0i0PY3kSYIOA9UpUb9duHN1+6FEXS1yUmxxAo2TwBjpEb3eo9kj8w6zVbjCbuwQjTsG8V47oekKyvFEv+58jxcXPEkvKFkunz16bVTmOa4Av9fVdl9ErBELkQPfYgsM8L4YLNsac6ah6xDkYfE9Hz/UBCQObkuNfuysSoV90Awte6+5VIEgIeVIlZUtMXVKIz/yXeLRfkP7WFvj3Hs/W74zprUby/UfhTIrIIhOAhB5mAQi9gEIno+f0TGqyercGadtYWlh6nhw/3mM2H28xAH41Oik+08Uyj84kToBryJ+u9i0e14cP7PouFN+es2Dte+M/OmGKvZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0T+4n/Y1nEjj/Sf9Zb21jN/3DOKKALC3qaf00pt/eHQ=;
 b=DDQ0pmuKdfxCfAESah5OUl9zPm7SmPEmxRRKB0SqHxTB1t8uh7jxpU1kWCTIzBmM8Fj0BZdTope3wt8L4i2z8D1lBvHtXa7utxXtiFWkEZLtbrWO39Rulj6Mdrl113+lmJ/nYz/w0OGahyxCJ8XmaNX4sIdQbE4VFvg1QW67XcZ4mnP80T1OKtNu7cfbuWVrluKHtEWXfLEyLOMzvZxxoLvIkyU1fXVePm4ySAXOHnX/t3Z0P9j6StsZG6kR7LrlLuGWeafzP1Z+dFJl82WfWRsJWB/Xqv1YeSEDWB8JXhRKDbwNlWkRsOaPaKUIaluLDdoldnliqIKHeBMwtHoLCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=suse.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0T+4n/Y1nEjj/Sf9Zb21jN/3DOKKALC3qaf00pt/eHQ=;
 b=I/0FSDff/xpKBqDDGynxzO7acdq06BIXeeNzxvjUZpXZlgBNwofRh72arbkm+kEg59MDj48cWA2OCCkSxJVPbDJHb2hSkEAN+npOT3vgvySj5E16UTeB8TqcP/aXGLCTKJ2Cm87zutnvDEiCWJCKLPEAEmpfGbBu2bRPtpFtcMcZI7bJ0E0I7Rs1zFpPN0zod+GhWDv/5ADcibbvoPklvR3PFfWaNhbAJsHfKQF3r1o/2oOP4kRaaPHUyHiqB62A5pQ3ZCTygOzistWYH+29rvuA/QO1hgypmoh6fCieWU97ZcZPzmQyOFM/62pbSjs1dAmIr1UT8hzkvN1qyvcc+w==
Received: from BN9PR03CA0970.namprd03.prod.outlook.com (2603:10b6:408:109::15)
 by MW4PR12MB7119.namprd12.prod.outlook.com (2603:10b6:303:220::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 23:02:03 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:109:cafe::ae) by BN9PR03CA0970.outlook.office365.com
 (2603:10b6:408:109::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22 via Frontend
 Transport; Wed, 31 Jan 2024 23:02:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Wed, 31 Jan 2024 23:02:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 31 Jan
 2024 15:01:47 -0800
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 31 Jan
 2024 15:01:46 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <hare@suse.de>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V2] nvme-common: add module description
Date: Wed, 31 Jan 2024 15:01:38 -0800
Message-ID: <20240131230138.7343-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|MW4PR12MB7119:EE_
X-MS-Office365-Filtering-Correlation-Id: f90f872d-bc7b-46ae-961c-08dc22b0a2f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LRf5z5nMiDg/yNTyOCdOYPpvfIR5tYtueLsZIfrcbm8qrRZLY6wQHlcL+as4Q4p6SnTG3ZKMSoyvSv7l5bdC71Y3N8J+SdHuxvTkEIg4JnUU2DjcLjaO7TJ7VSA5bD9ruDL9y2yZxqQ2MdZiZeprrDKJMXd7ShEd9WQqc/lI6MZKNYxiKSeZgo8RBes0YWgaMX10oZqKZDYkR6FsKqpcy4GLS6VjA24BvlijkCUis2UZexaNNzdbWQckk/h+0JF+CIFRaV+hHg0oVJ+j+bghdZXUy/iOJU6XRWdoB++2PCgErwZFxy5DYv2TSu0G6dDUfdpiSjoX/4X3oL2vSBS3bpjkjJ1v3y3JIScglhlCLxXzzZSrd3sdgBvkeHsGkawK0VNwWWwWdKU1YaNhoe+v/ZHzN3fKl8BGQl554LqnZ7aq4jp5fIfFUbpRNs0g/nTlxEmuiTyHofTlmxhCqg8MvcMJ9hpidFCHbNuE6RD7WTfoIQChBv+zp3yZ3fFusZQQVsQ2m7Lljtv90jtXe8NLPyF3vvGj0O2yNYMN8WulVNL0Fe7iwFJ+SP31llCPgfgHSlw3xbHwS6eHpx3sCKhZvFcLKl3FoUZ8nm2/kjyIiIPzQstIJveq5/uke0d5uG3P6hkW0YuR5x5RYCKTEjoL+IbfW4/qqriE31orKQ7oqEJAN4jGo9j/w10iemvcK9gb3nCpnVk5CWdcPJ4LBY7A7xwqSeiLSBTnk2Qz4/4gO/iT1ManD9NptpmlLDGRfO0bmQKbgJ3ALVuuUp05sSXLXvQDf9zsCITw/bTDCjCV34w=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(230173577357003)(230273577357003)(64100799003)(1800799012)(186009)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(70586007)(54906003)(70206006)(47076005)(6916009)(478600001)(8676002)(6666004)(316002)(7696005)(8936002)(4326008)(1076003)(336012)(2616005)(426003)(2906002)(83380400001)(5660300002)(26005)(107886003)(82740400003)(36860700001)(16526019)(7636003)(356005)(40460700003)(36756003)(40480700001)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 23:02:02.1394
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f90f872d-bc7b-46ae-961c-08dc22b0a2f6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7119
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_150208_153128_013BE3F9 
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

Add MODULE_DESCRIPTION() in order to remove warnings & get clean build:-

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/common/nvme-auth.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/common/nvme-keyring.o

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---

V2:-

Remove TLS from module description string for keyring.c (Sagi).

 drivers/nvme/common/auth.c    | 1 +
 drivers/nvme/common/keyring.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index a23ab5c968b9..b707e6b7d263 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -471,4 +471,5 @@ int nvme_auth_generate_key(u8 *secret, struct nvme_dhchap_key **ret_key)
 }
 EXPORT_SYMBOL_GPL(nvme_auth_generate_key);
 
+MODULE_DESCRIPTION("NVMe Authentication framework");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
index a5c0431c101c..394c3948e339 100644
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -181,5 +181,6 @@ static void __exit nvme_keyring_exit(void)
 
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Hannes Reinecke <hare@suse.de>");
+MODULE_DESCRIPTION("NVMe Keyring implementation");
 module_init(nvme_keyring_init);
 module_exit(nvme_keyring_exit);
-- 
2.40.0


