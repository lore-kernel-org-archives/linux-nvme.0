Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA690C4829A
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Feb 2024 07:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fAQlgV8fgq1W+SrRYIxqRrCGQUaB2U6zfDZIg373aXs=; b=J334L7aW/x2VA0wz3VxbQ1COlA
	T7/cOA/gJIyxjLuCvz6M1qDI+4CBsEIiOJtDAGeqrQgx4NwJhKFAq8YgYRKw51WtUy2lHc4mrfwJV
	Y83IJNvQHYf0qXjy+CKvkHVw3lUN9olcwOYlAs+oBFf5CfD8N7NfCqgc1TQ3XyfrxAJeBFLEvPkXZ
	HoD0yOCbmd67h9a8EDXLgxQ3b05NjFL5awbuMfqceA/gGn5AnQp3L9eHM89GpTelC1kJBUJzC032z
	xgGw6wg1+UUrs5iPXYYE8gzVhBYyO1aNo3iKkfKGfXGPYulBYe9LqrH8GHGI/1K78jW5sXcknnhEf
	DDZEFslA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZngv-00000008JzM-0cO5;
	Tue, 13 Feb 2024 07:58:57 +0000
Received: from mail-dm6nam11on20600.outbound.protection.outlook.com ([2a01:111:f403:2415::600] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZngs-00000008Jyu-06JZ
	for linux-nvme@lists.infradead.org;
	Tue, 13 Feb 2024 07:58:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHzC34aVnY6VnUKm9f8Cr25aGk/q2fbQQMLYjXALx9iuZtWOjPTAqUnSuMeGt28pQ27A1+zvP4kEEen5diQDChL52I/kX7FISimSfRLeFIi9kUOFUiD7hskjYhg1H3aSF4/lHyHjn6izk+quIpBq3ccRDWejhqBiJKTsNT4isFA3ebRlLDUL//ThUzrWGn078W4Vt7ZC+r3UDt65aLXhkD3dqQUoCULfn5wcvW3b2wMtpRNaAzJ1ojSshz/5yd6/GYYH6/aozkoPuIYyWCayI5NhBQB6C8dH0/pNHyDNq6vSoFQ4+BnH0gl6yespnJRJZwvGKSGNXmEoTxazNxNOkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAQlgV8fgq1W+SrRYIxqRrCGQUaB2U6zfDZIg373aXs=;
 b=cs4vurTnSJi3k0AgFJfg0MDZnPf++y8jH0hD9H8i6X8DuFaTVbPdFSXzUimBA94PxulGOoy0EbsTx6UwCPIiEjaZisq9L9HxXcEE5XgrR6o0ML4h2jUuB167TfRmR0fcamyR6RsrU2yI3n2botPVj7edzBLsq6Vi2rrUQSMApPu7zGpVZ79PZxsbB4SPmcEVxub5yg83IeKTHTmqZW08ay98Q3AJFhs9LOeqWCa018pMUlYYO8dueTPOhdaD0hqZXgFfChx8q91B5k/GqVSD+B0t3iNPKbMG+6omrXfrR+obtvS2O8RAxeZ2kieRtRfCgYQR1j1nss93d9oBV0yW7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAQlgV8fgq1W+SrRYIxqRrCGQUaB2U6zfDZIg373aXs=;
 b=QJughPXbKQPy9o0rBb+6dgXwy3xcqLXZS+GeLsm24oxcGZgB3lDj3m0cKdJOAZVETGRkBG5j1dcXv2EwyNQQsBunNSMBqcXdV9k8zCPvo1Z66k+O8CTYCaYVHrgeHRUen/U/xpfG7AO8w6TPpW7zgPRDeBu8sVUOzETvV3qnMZyYqdpmXQA1iRtlt+LqG3lRa1u4vIKZEbobWICr+6Vm9D5fnE1mjg2bX7PNmwehJpTIDUad2UqfQkEHQozt6xzdCMIMRXxBZaSby+VelXvSQ5vsAaueyOUSg0Kmf/IPaeD0SG/Tn1h0jx6tThIjb6ir4V2nrOoALOVpLu/EsqUSLw==
Received: from CH0PR03CA0384.namprd03.prod.outlook.com (2603:10b6:610:119::26)
 by DM4PR12MB8452.namprd12.prod.outlook.com (2603:10b6:8:184::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Tue, 13 Feb
 2024 07:58:44 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:119:cafe::c4) by CH0PR03CA0384.outlook.office365.com
 (2603:10b6:610:119::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Tue, 13 Feb 2024 07:58:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Tue, 13 Feb 2024 07:58:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 12 Feb
 2024 23:58:31 -0800
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 12 Feb
 2024 23:58:31 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>
Subject: [PATCH V2] nvmet: remove superfluous initialization
Date: Mon, 12 Feb 2024 23:58:24 -0800
Message-ID: <20240213075824.29789-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|DM4PR12MB8452:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b9ac609-7401-4903-5a9e-08dc2c6999f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a5fVJMZxEDibqZs92UhEvldN3uWhAVlXiCjSq3tvcuUNL3jGRq0uX2uUQRBvSCr4nXrw5q0p9Hjy/N/3wfsADyjp5KgMiVJ8eY9OFTcuLJ5MsDf89AWrmh4tyMhmFq1Qgk+eVOGbnvqeyiYiMcJBdGE4U2/kt5t/mj1JzNOkZBIJfZkcZLPBB29KLBZI039uj6Xv3V5Fp1A/BymwBunlqlkwxdbcEvqEQEq+KQMtSJ0Op30rdw++Db6DwsIwfExTtuMeK0oSdMSqj9/nW4lYzFfnmz6mRVaHUyj3oH7rhJeZsUeiZjxljvwOjz71apPZpQrzZwsb4lIobsiPUzeMtn64+/SvHrTisuVZ4g1XKhQebQZQNXaw5fWFXxqdvA0EsHHJFjFc2Ogg4yg7186zgHduXhsfKafBSVRpyed3Jb0cQLagG/m8Ty9kddTMY/Q+1kfpjUHriEfNYSFPec8upZwRuMTnxP1foKbwGXS/dqyvSq+n8A9C9J1X90aGvHrWPVm8Wz7TFvr5iDBa8uF6EQ6K02Cv0nhX0lljtbZrsIihGTi4AO2HEHOpEnSHdPk4xIlT9xHC489U7/wo852uTCdanmmpARVKGdjlDVKFnYc=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(136003)(39860400002)(346002)(230922051799003)(82310400011)(451199024)(186009)(64100799003)(1800799012)(36840700001)(46966006)(40470700004)(107886003)(83380400001)(426003)(16526019)(26005)(356005)(82740400003)(7636003)(336012)(4326008)(5660300002)(6916009)(41300700001)(8936002)(8676002)(70206006)(70586007)(478600001)(2906002)(7696005)(1076003)(6666004)(316002)(54906003)(36756003)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 07:58:44.4190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b9ac609-7401-4903-5a9e-08dc2c6999f2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8452
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240212_235854_089814_0E6830E0 
X-CRM114-Status: UNSURE (   9.33  )
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

Remove superfluous initialization of status variable in
nvmet_execute_admin_connect() and nvmet_execute_io_connect(), since it
will get overwritten by nvmet_copy_from_sgl().

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---

V2:- fix commit log and subject line (Christoph)

 drivers/nvme/target/fabrics-cmd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index d8da840a1c0e..9964ffe347d2 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -209,7 +209,7 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 	struct nvmf_connect_command *c = &req->cmd->connect;
 	struct nvmf_connect_data *d;
 	struct nvmet_ctrl *ctrl = NULL;
-	u16 status = 0;
+	u16 status;
 	int ret;
 
 	if (!nvmet_check_transfer_len(req, sizeof(struct nvmf_connect_data)))
@@ -290,7 +290,7 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 	struct nvmf_connect_data *d;
 	struct nvmet_ctrl *ctrl;
 	u16 qid = le16_to_cpu(c->qid);
-	u16 status = 0;
+	u16 status;
 
 	if (!nvmet_check_transfer_len(req, sizeof(struct nvmf_connect_data)))
 		return;
-- 
2.40.0


