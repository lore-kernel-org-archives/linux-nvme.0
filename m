Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F064FC433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jun 2022 01:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GNKeu/RNp6Zi4BIJHN/l/jxzQUeuLEfEgRDzXGEkF8Q=; b=dtyZtYKviXyjhObdqmvjaomZ3w
	XRX1KfEjzUOAjjM9x7G5N2YApk5pLbKf4XrSv1P8E6HpwkWTJkcl8diz4DWvwu4qf9pGHmI33kRrc
	Vgz9KBpzaXKX8TesC7wC20lg5g54pOutwuWzhNNxvco9KUP28VvIPNGp97h/Sk8Ok/6AN1kJFppJu
	Ba8zvN4kxCiWAis9kCR93yqNyRnmrqK7bdP0YvqiBAQS/5JoFSD83/EfS+HTM8JHCJgOCf6MhrfHN
	KIHlIq61J529sPXiSJdUhh88mKlEJaY3TC2LdT7wWNp2IIoyZLKJoAE77T+gtmR0GGWxT8hvZcGaN
	cVuN2HqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyNqY-003y7q-Ro; Tue, 07 Jun 2022 01:17:26 +0000
Received: from mail-bn7nam10on20629.outbound.protection.outlook.com ([2a01:111:f400:7e8a::629] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyNqU-003y6o-No
	for linux-nvme@lists.infradead.org; Tue, 07 Jun 2022 01:17:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kd1U4Anj/XRcRf86K28fuMCgJV6tfN2/c3VN0aNCGxeIL1SyTCqfUs0QPZTpxdipmwlMUNJpLTgBJ0/I0rVSAHLfOCfNW1skFcj9JoXJeaCtaEf/sjThtmprwJkFpL6lTqeih2jFkQw9UojK3irJDMvubwNwCQ2hYJ76F3Shilc7eGmfj71TGMcz96Mb+fugEDgtVm33QEQpgc0ke9gpcM+iFgQ8hg0VU8W8FRKLb1IC+KvhHq+ukZvV66qdCNO3thHIaMk9xqXAv1dIoY3zFi+D10NFpvcKO6GxoYmmXLk5cq0zBPdKcGET2tainpWf6let/kKjh1UHks2DrvW22Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNKeu/RNp6Zi4BIJHN/l/jxzQUeuLEfEgRDzXGEkF8Q=;
 b=fo2UJyR99+AMVOLwqhWLr9kg5gzgJKFezP0e3/i2VlzBXEf/PsnrKp+MjcDAOsxVNuA8aKiRTDdkAi5tAaYeJY/u3sO3tHOeFAWg3Sx3anE4ayXgRDpWg3V9TltuACxXbcxX9QS+JRhOUAlkaNVG4MCMJQaRtd8RiWyey92fI+abB5uuuLJEnrJUxF7fRPK2Zq+/d302LswodrFraC/ooIkZEAysSnPTDm9+qpYsOy2hHnkkgIL+yXdwRMA7DhjKfd8FIOmj+P39LGSlNvRViO/JNw5b/9+72OlwmaYo3sN51PfNENjmVAPL3OD9zpjTW3Laj/3OOjDzoKw/n1obbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNKeu/RNp6Zi4BIJHN/l/jxzQUeuLEfEgRDzXGEkF8Q=;
 b=g92IKHu1HhQqRyFGF3DOxEMJXY4ry1kNjqEB1vSTaYPi1F2DrpyZJeqZVKwLelgMzLgWc1pbrFSRKHLjfk6tYdp0Y0R3ul7Vi/xFa9Y3gy+0t/X2Iiu/lndNbixer8JTSVa/MWY57qRstquts7/r+uEdPdHD2TIQblsKiOUIuZjLphYbfTMy7vrYl94pOZXXMMUqi2PaALw67OHcy1MOsqj1s99QXPp/d9qymo8biTMmFAuP6KyRBBNAZ/HvO4k4pF7f4l384tNalQG3VdlORRjaOntwzPGpBVF9IpIrkqRm98N27OxfI4tAWlRia230EFxW0586FC+m6Bycm3Dpwg==
Received: from MW4P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::13)
 by DM6PR12MB2809.namprd12.prod.outlook.com (2603:10b6:5:4a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Tue, 7 Jun
 2022 01:17:17 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::4e) by MW4P220CA0008.outlook.office365.com
 (2603:10b6:303:115::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Tue, 7 Jun 2022 01:17:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5314.12 via Frontend Transport; Tue, 7 Jun 2022 01:17:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 7 Jun
 2022 01:17:16 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 6 Jun 2022
 18:17:15 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 2/6] nvme-core: fix qid param blk_mq_alloc_request_hctx
Date: Mon, 6 Jun 2022 18:16:43 -0700
Message-ID: <20220607011647.24105-3-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220607011647.24105-1-kch@nvidia.com>
References: <20220607011647.24105-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 848a166d-2809-4e14-1a02-08da4823766b
X-MS-TrafficTypeDiagnostic: DM6PR12MB2809:EE_
X-Microsoft-Antispam-PRVS: 	<DM6PR12MB2809676AF587ADB97ACEDEB0A3A59@DM6PR12MB2809.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	eeFYrUpWDQlLYeHROj2iqtDpFgpRx0OxCoREq9FS7oRtjnT3dLK/VRGGbkFFriYRpp60T1lKUhKZXS25naUQe81b1A3+RKBKBD1I/EtVu44Lt2F8hkgwev4/ZFG5BYxqfKXLogxOM1klBm9qYOR8s82ZQsPkkMjplkfxzqSDAKiS30xzxm3JXtd06J2iavm+t0xLUt8RvuXyLPh0Us3ClKmFP5VIiCOeVr66irRvvMAge4rE3X9VfWktaSHcL6Pg96mCj2QvHQUl7wtKZkNAYFls13dtwFSbWHJ6gbHr/u1/aXqMAl+WEsCp1EtPzSWV1f5v/HAEm+vnVV06rhOL+fyuYHudrCIuRvPthPSV197tnVy42h8xan8cN2S88bOHJXbxWGO+A9HqQxCe8ZrRdovM3OBKSdya9IcLQ5J2HpvgEb+iDP/PDzcRCLLOim8EmneZH4S2YtgWAwkI1JgmXQKgr438gFYPJN+H+WEY7nEPQ7Ca7mL/NuijYpYE6ZAFubjPC47VhvkPZMsShwnj1EmC9037pGvbDkmrnsSsOgM4d7OYalzpehOcaSBWkPK8p9nGn+oJZE+JJwsBJJuik/L9BOx9Vp3PQMf1IinndYFctn5xS5Z5qoN+XouY6GQagS+RESp3AUnbSScgi4ZtVgECStooOOgJBhC3KZ1iGZgHRl2f72UTCKPQix+w7+wZhjyLPSg/fC5lg2dOIBB6ag==
X-Forefront-Antispam-Report: 	CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(4326008)(316002)(8676002)(356005)(2906002)(5660300002)(40460700003)(70586007)(8936002)(70206006)(81166007)(26005)(47076005)(336012)(426003)(1076003)(107886003)(186003)(16526019)(508600001)(6666004)(7696005)(2616005)(54906003)(6916009)(82310400005)(36860700001)(83380400001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 01:17:17.3038
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 848a166d-2809-4e14-1a02-08da4823766b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2809
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220606_181722_815110_DF734986 
X-CRM114-Status: GOOD (  12.52  )
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

Only caller of the __nvme_submit_sync_cmd() with qid value not equal to
NVME_QID_ANY is nvmf_connect_io_queues(), where qid value is alway set
to > 0.

[1] __nvme_submit_sync_cmd() callers with  qid parameter from :-

        Caller                  |   qid parameter
------------------------------------------------------
* nvme_fc_connect_io_queues()   |
   nvmf_connect_io_queue()      |      qid > 0
* nvme_rdma_start_io_queues()   |
   nvme_rdma_start_queue()      |
    nvmf_connect_io_queues()    |      qid > 0
* nvme_tcp_start_io_queues()    |
   nvme_tcp_start_queue()       |
    nvmf_connect_io_queues()    |      qid > 0
* nvme_loop_connect_io_queues() |
   nvmf_connect_io_queues()     |      qid > 0

When qid value of the function parameter __nvme_submit_sync_cmd() is > 0
from above callers, we use blk_mq_alloc_request_hctx(), where we pass
last parameter as 0 if qid functional parameter value is set to 0 with
conditional operators, see 1002 :-

991 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 992                 union nvme_result *result, void *buffer, unsigned bufflen,
 993                 int qid, int at_head, blk_mq_req_flags_t flags)
 994 {
 995         struct request *req;
 996         int ret;
 997
 998         if (qid == NVME_QID_ANY)
 999                 req = blk_mq_alloc_request(q, nvme_req_op(cmd), flags);
1000         else
1001                 req = blk_mq_alloc_request_hctx(q, nvme_req_op(cmd), flags,
1002                                                 qid ? qid - 1 : 0);
1003

But qid function parameter value of the __nvme_submit_sync_cmd() will
never be 0 from above caller list see [1], and all the other callers of
__nvme_submit_sync_cmd() use NVME_QID_ANY as qid value :-
1. nvme_submit_sync_cmd()
2. nvme_features()
3. nvme_sec_submit()
4. nvmf_reg_read32()
5. nvmf_reg_read64()
6. nvmf_ref_write32()
7. nvmf_connect_admin_queue()

Remove the conditional operator to pass the qid as 0 in the call to
blk_mq_alloc_requst_hctx().

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f46b0d37f45d..36943e245acf 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -999,7 +999,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		req = blk_mq_alloc_request(q, nvme_req_op(cmd), flags);
 	else
 		req = blk_mq_alloc_request_hctx(q, nvme_req_op(cmd), flags,
-						qid ? qid - 1 : 0);
+						qid - 1);
 
 	if (IS_ERR(req))
 		return PTR_ERR(req);
-- 
2.29.0


