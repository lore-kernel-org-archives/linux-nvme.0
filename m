Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 977F5C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 18:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rrWzGclQpCT+UTKJBtp9aDASkFdXr2rU41s6ZLakBkk=; b=Opb7k6/nyCC2giyOYhyw1ogrzQ
	Lvg8t9AU4MwOjYxhmtGu5L7xqyj2zDUx08A53n3ueJ/v1FFtrdXjTIF5QGxoTa9PW2vkmiUM/66rE
	R/B0wEGgrYWwtl8w/+C2UCjUR9dLIdBSzskYpWWW4tbYoQGMo1ONmI4163cdH08rDFQd1lYbEm6jj
	8E+5IKa9qQcQHLu2shcH5TK4TEkmKTsAkXdiTU9LldGZqxlNAiISgSHHa1WA2I+mqNoBXaamD2j1C
	BbHIEwW6rIRHE5Bdj7FcXLWASZ++rZWUA7l8ly9+TExwk1ukBCmYnLhkHVMunY2n3wNddgmQ/OW+v
	JdQEx2Jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nS0cc-009xuu-3m; Wed, 09 Mar 2022 18:01:14 +0000
Received: from mail-mw2nam08on20613.outbound.protection.outlook.com
 ([2a01:111:f400:7e8c::613]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nS0a1-009wnc-9E
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 17:58:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ToX7B5f3ONOZmV1uU7GHltuiB+eu3wk0Keq1YzkHL6+wOFegUTj0b1YOTH1fUnfQszx7jxlEmpPZcwlbEcfYvCz0MEJsfTxzgDa0itNPBSjqnIqSzYsoHrhUTgiaSvNXzRVe/0mZ5F4KKD0fggUF4asApGxxi+l5HVeXlgud6CNVVsvCpsIBggASlFDuQafLJk8UCuF54DHMKcSyyFYDxJJrXDkOS4n1URrayPRQBUachMS0hagnebOgHJ7Fqd1iR4Bul3JgnXtXCsuhykN57TNnUHkTekULTfHggGtkUsWcyBVd/rway0FWP+QqDU3UPn3q1sN6vSFLkQtyyIcsgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrWzGclQpCT+UTKJBtp9aDASkFdXr2rU41s6ZLakBkk=;
 b=MbfYEZRsxTFv3bGsCQg619TJtx6+FpqgXCKZndbThpSHITqvnZypRHNGQQuFn+kjquK3FeXHRWc3AWaw7hkRflz0Cz8GZ+51dQFoEtxUGWKvKqhG4EIWcJ16gWhoH1pVfgHzpIz8bBquWQ4qDxDZEdrN30R1GFJUg2khCHeatfhlvJpBssIYrlNKCobZ72ORj5jhkmRI2kpf9nak4HvS8nTMoV3C1mJkgSJXhNsPuWmKlCHfaudcUyP/JUElAOA5UPGjl8XsVNzTNdVzroqlBP1DeraisJ0aym4eBH0J6pvZEbG2f2LSFhSL3YkxWDfIP8W54p0CvB3R/XxJAqHoaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrWzGclQpCT+UTKJBtp9aDASkFdXr2rU41s6ZLakBkk=;
 b=SsgkncXIYiJueZ4bY1roZ9bq1bT45J421NBdDkBZmNadxoZU6WeGW4SV+4/KjcYl41WURKoA4uV1ERJq1KeV+a3YidYI1q1RssHx1szCL5SAf5QrXGtEBLTcHOAKKxZC9je985ffFf+NJnfy88JF6h3N98hJUqVlZEeHaSFRC/s9NQCsiGEfjFhx2HbyYJFXylu++AkBYZlO3De358Fb8qrEVcQElZcro9Vzvf6eSpHcZiN75CtZe7mDkIX5KmmHjiC3V2a2BZQzqR+lxX3N1AvAP8DmFcWAw3+KOjq1+nr8IehRxkSNS2dMKqWP0Kvs8DH1kjiZQLAbPnK6jBiC3A==
Received: from BN6PR13CA0063.namprd13.prod.outlook.com (2603:10b6:404:11::25)
 by MN2PR12MB4238.namprd12.prod.outlook.com (2603:10b6:208:199::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 17:43:29 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:11:cafe::53) by BN6PR13CA0063.outlook.office365.com
 (2603:10b6:404:11::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.7 via Frontend
 Transport; Wed, 9 Mar 2022 17:43:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5038.14 via Frontend Transport; Wed, 9 Mar 2022 17:43:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Wed, 9 Mar 2022 17:43:28 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Wed, 9 Mar 2022
 09:43:27 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 1/2] nvmet: open code nvmet_get_feat_async_event()
Date: Wed, 9 Mar 2022 09:43:07 -0800
Message-ID: <20220309174308.41832-2-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220309174308.41832-1-kch@nvidia.com>
References: <20220309174308.41832-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb113a52-ba98-47c0-941b-08da01f4524f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4238:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB42385C49397F8561F775EE0AA30A9@MN2PR12MB4238.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PxnX3x9dTF2RSx6vzfXpi3OBJk5EevkCJjE7gpjY4TeOAcBzCfzYtvH5jxhDcR3Cx9H31fHPg+39ae0AhN6YkBLm3Tkr983myN/OPELns0a5xRhZCMEY8FX7nGh40gE2h+4/IqLRreUQsWnacGtRB4jD6VKy3eZzdRzA/q6ej/tiUfA8kmQ+6yfpgOuKEaUonJRZSJf7z98feonAAD2HcQcC0eEbhfMqKFXGR8/s5TuwRVRT/c9K8vmOknj7QpDwxgNz3NAwtdb0/EFpM9SHd1F5/BF3STmsPOmGphmayf8hEBIOMiCDnyfSdurCium8aHg+bHJOM5mR3v0sPEQTnWMrBo0WT3Go64RQRTwsNQNscwPPrOtr9YG23CRADptgk/JhjdBeZvCgUhCVnAwsyUC4KtFTnjeiOGYPINgFqDbBFsOkY8522ddbHWBVmbeLchMWr+wyIFfYz4I/iuwwDEaIUHMFp2fq03mSb2ps251FF8Qp4/rQUNU+FsmVqNVejO2o7/0k6zRPNaE4ytQrQwR8UZh/jQvt/LDIo6a3qhDauxsUrJkoTcGsM7HAfjAhuw1g88Wb7Ov8ABocMvmcx5v5JOitQ5xBVsJfpYNMB6WF1/TY0sklEWRMnZJYJq7oPjfLef/mYe8bNzvh2ML0JpIp+bw6GWZqzKtJPI9z0ObhprsfpdiTMBkyNf/lbMePo2SDtNvebN+m62Hl+aclbw==
X-Forefront-Antispam-Report: CIP:12.22.5.238; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(2906002)(426003)(336012)(40460700003)(26005)(186003)(316002)(2616005)(54906003)(6916009)(1076003)(107886003)(36860700001)(81166007)(16526019)(356005)(83380400001)(70586007)(8676002)(70206006)(4326008)(508600001)(82310400004)(47076005)(36756003)(5660300002)(8936002)(6666004)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 17:43:28.9066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb113a52-ba98-47c0-941b-08da01f4524f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.238];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4238
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220309_095833_372194_142B2E33 
X-CRM114-Status: UNSURE (   8.16  )
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

Just like we have open coded NVME_FEAT_HOST_ID handling, open code one
liner function nvmet_get_feat_async_event() for NVME_FEAT_ASYNC_EVENT.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/admin-cmd.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 6fb24746de06..e034ced953a3 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -894,11 +894,6 @@ void nvmet_get_feat_kato(struct nvmet_req *req)
 	nvmet_set_result(req, req->sq->ctrl->kato * 1000);
 }
 
-void nvmet_get_feat_async_event(struct nvmet_req *req)
-{
-	nvmet_set_result(req, READ_ONCE(req->sq->ctrl->aen_enabled));
-}
-
 void nvmet_execute_get_features(struct nvmet_req *req)
 {
 	struct nvmet_subsys *subsys = nvmet_req_subsys(req);
@@ -931,7 +926,7 @@ void nvmet_execute_get_features(struct nvmet_req *req)
 		break;
 #endif
 	case NVME_FEAT_ASYNC_EVENT:
-		nvmet_get_feat_async_event(req);
+		nvmet_set_result(req, READ_ONCE(req->sq->ctrl->aen_enabled));
 		break;
 	case NVME_FEAT_VOLATILE_WC:
 		nvmet_set_result(req, 1);
-- 
2.29.0


