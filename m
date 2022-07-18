Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D77DAC43334
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jul 2022 23:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HyWaODrZH7YOBsOTsE7blpA24HsUmWBGjuBHAyv0g0M=; b=ERU1lb3/FCdw2thoCqoVKeEC3X
	Q5gZIBNez2A5pqR2Z/6XTZ4NlfNcpQP7jT7K6pE63r9O3e2zVMYgFWaMqxHII83eejTJyTPZ9XgPu
	oxUDvpoUTH0fUQxNl/1TUuOtjnBPL5v97ji5Zc3aeOlE6PzGjGMZKKKtuBZMlx3pD53KIA7P+JlqF
	uINgOdF6KeYr9dO161qhxWPGCEBtB9GHAm82pYSBZzNKvX8HvJ5azyOJts8q3KhKWinTlx6YRgiBi
	e7YDSfBcnlL9AOq8lSP5N2DsHz+1aMe5CuQSVLIei0asKJs+2RsQgorJJNj44cyq/wLAtXS8vm7w/
	5YcvtvYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDZvL-002WtU-9O; Mon, 18 Jul 2022 23:13:11 +0000
Received: from mail-bn8nam12on2068.outbound.protection.outlook.com ([40.107.237.68] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDZvI-002Wpi-Dn
	for linux-nvme@lists.infradead.org; Mon, 18 Jul 2022 23:13:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTlpNcBhyGpNV9UvByVJbNpUsPxwu+RZJvkrGEvADQ8+coSBU9oC90zP4SU96h7e48jlxlEaW6uaknIRm8xYreTqiDX2GZcsxKxSIScm8sxvuELUCRD9Vt3R09llcagl0wGVIB4ebTzj4TAxOESPWOlIPt8fPeFpx6WBwf+F2HO+A/yT78AkDIFDaWHouKHx9idy1Ne6SZVHpmYH1HlnnYQWbgJbXbAqosuZ/EoqH4egPDjU57ArJAU/Zo4sOKXcybqJ3VwfXFiHpjBVbrkalaMiGX+H73c7DenDX4Sz8EzwDVtRiPB5WsT9BGGzLVz7FuRb+F3yZL6S4f78c1iOeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HyWaODrZH7YOBsOTsE7blpA24HsUmWBGjuBHAyv0g0M=;
 b=UFSa8WCMXDbkvtEqNmLS9Kcs+gXRjSagXoEznPqjgRgWF5doFg0DN9s5efTqTYRzEWgcgKY7dmR0DeO4Q31ECRFD2kX4LwsgRenBBBx8qsDUuTE+zdNM2ZkNXdsWs/okM4fxQ0PeRHse2I5JbVsDR9eXt08BVnohAYXwZYokPLoLyji+JaOFKng76Ya/vAfTk7jktYhKmZCnMl+gqKVeUhk4oifonfW1fiUr0jiidgEJq0te/CmwW3NUEgK47mnurmeSL+o53QjcgTJCD9PlasrKNpbIx7Own/T7KUIX31nnmZOfjznjlmK4l1TZaMrUkMtnOP49+BwMYEfuLoPz4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyWaODrZH7YOBsOTsE7blpA24HsUmWBGjuBHAyv0g0M=;
 b=POcIZ7Ymdph9UScoA9s+ylzf1T4q5gxB3fU5yH0KTLDmlUdX0Z0oIf91NSvEZJNr49WJ86BxMJGGwHvzR6dSA5ovUJ7lHTI99mn4oAMo4lvAn3P8ZhGoAokSrX3Ns56VIhZ1Skwdlbo2EeGKpw07Wtgp+Kyt1/f86NhBnVbjM2Nu3BmXyU539uq3ADA5lR2zgaPMuXriTwWE27NkowhJwk/gZCgZRTXv/Dlirg1kfCFKnfTJdwj0PSnSvwTNjELRprtww/oP7Jr8yxuFQX+rzCPWfbUzyWXVU3d0PZEGMAer+g2UZnKbLe+4goxnaRHp4oZTq6eh5PUB/DhzgrCZkw==
Received: from BN9PR03CA0486.namprd03.prod.outlook.com (2603:10b6:408:130::11)
 by MN2PR12MB4061.namprd12.prod.outlook.com (2603:10b6:208:19a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Mon, 18 Jul
 2022 23:13:03 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::1e) by BN9PR03CA0486.outlook.office365.com
 (2603:10b6:408:130::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.22 via Frontend
 Transport; Mon, 18 Jul 2022 23:13:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5438.12 via Frontend Transport; Mon, 18 Jul 2022 23:13:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 18 Jul
 2022 23:13:02 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 18 Jul
 2022 16:13:01 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <hare@suse.de>
CC: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 2/2] nvmet: fix return value check in auth receive
Date: Mon, 18 Jul 2022 16:12:33 -0700
Message-ID: <20220718231233.3886-3-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220718231233.3886-1-kch@nvidia.com>
References: <20220718231233.3886-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c474ecc2-d775-4761-2f8e-08da69131104
X-MS-TrafficTypeDiagnostic: MN2PR12MB4061:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	b4ThXNmuF1TUsX8wejfSOn9bjF2vCqQED0TR6SoSRAMgP6z4mKam74mgMvsrL07PI4UfLv6u0XiNwBwEHH7A3+bBYXR3KFtLA7QUJ1WM2Y3Fusm2issq3CciVfF5bIz7AD3gYgr2rHC+Qz8qmX7xCa3NFweUSzX7Y9pWp54SmTUeHTb8nuJreTYxoO/su13Fx9jDbHoY1Fiu6rdW8yNuKKvbY4+7NZHEH173CGSdzUZbt2z/c8lk9EF3PzvXCULMIOurR8QK9jyzDo3k2/L0bFxLe2mlhFOHN1Hqk0rUKNS0EgvZEpWbIo5ZGbQSK+z1+ahROVFBuYhn+QaJzpHFNAdi9TdyG8QnS+J9kjtYhGb+WP47EoCKO/M59uLz0LNhbRslEJNUE7iYpc+u3CpQjFlSTjAjaJOtwvvRwswl2ka8rtsJybWFFJp5ExvYWOilaAk2NyeX9C8VMizOX4oao0qYFd6lMO4dhQShqczQz8ANd14UlZ940G+ZvbJSYFsAPCo30hAgKL7u34rSZuIOzR3/yBgv2PyQo2DiiFgjoeydImZC3AvMEbsFcrr8VqaGgpE8D4/i65VoTU4Zt0yChQkxes3fZgvPC3Uowb7omW03lZkNJ1aW8gSuz4NrElBxBv01vnpU5lBz+YlqztzJ4tp4OcGgNMAo3RaTj1oghWf1PH64tKu4jCWZHzacRGChEEZQSOpw64KnIlxlTeBmJZcvsBjjsCijpO3YWJqwEa056oMEe+MJrZmuLShNge7yFW/W1gaxKfv95xFPtqMATRw1CIjfIylLw1LPe3CLEG3E0BuaCZZpp6wFPqV7r7k5Gmf4XHAAtGMySMxQGKi7Qw==
X-Forefront-Antispam-Report: 	CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(136003)(39860400002)(376002)(36840700001)(40470700004)(46966006)(426003)(1076003)(83380400001)(16526019)(2616005)(336012)(7696005)(478600001)(70586007)(186003)(26005)(47076005)(70206006)(356005)(41300700001)(82740400003)(36860700001)(6666004)(8936002)(2906002)(81166007)(6916009)(5660300002)(36756003)(40480700001)(82310400005)(8676002)(4326008)(316002)(40460700003)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 23:13:03.5409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c474ecc2-d775-4761-2f8e-08da69131104
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4061
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220718_161308_486497_ECF9DE50 
X-CRM114-Status: GOOD (  11.79  )
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

nvmet_auth_challenge() return type is int and currently it uses status
variable that is of type u16 in nvmet_execute_auth_receive().

Catch the return value of nvmet_auth_challenge() into int and set the
NVME_SC_INTERNAL as status variable before we jump to error.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/fabrics-cmd-auth.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index f1c9c2f51afb..45056e204dde 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -486,8 +486,9 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
 		 ctrl->cntlid, req->sq->qid, req->sq->dhchap_step);
 	switch (req->sq->dhchap_step) {
 	case NVME_AUTH_DHCHAP_MESSAGE_CHALLENGE:
-		status = nvmet_auth_challenge(req, d, al);
-		if (status < 0) {
+		int ret = nvmet_auth_challenge(req, d, al);
+
+		if (ret < 0) {
 			pr_warn("ctrl %d qid %d: challenge error (%d)\n",
 				ctrl->cntlid, req->sq->qid, status);
 			status = NVME_SC_INTERNAL;
-- 
2.29.0


