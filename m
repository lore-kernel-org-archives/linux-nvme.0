Return-Path: <SRS0=nD3g=I4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B4DC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 23:01:55 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A50D161987
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 23:01:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A50D161987
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6w5HepSpSjZ6GcURw8Yz8KJT37Vl1Yjmgs0gilm36y8=; b=khfns3upGkFRHxsujU7fIAMnji
	apTi9PIkoWguoMTcidtxUA98oE8Bep6KiOc+18mtjTKZW03Ia2x71+NaKSbNCjrKFRs0bcgQSYdMj
	k1ZDsu+VQwE0xeF6niSsy+QwhbTSp3qjURJFs4oiqKUV2UREyafFA6oCMP1p4b3YJoLZDEUWssf6x
	sp+gRMpZ9xSetSnFamy6iOrwUZVaIRUAk1RrF9LrT/B36vYgs9t5t86RcJmQUmysAuQavctZQTrnh
	eNFjBQWaZv2WFvhmnp1OumOTTcaHx37CTEm3mdAVqVIiz5Xc4uSzjaShFk4c4I1Lefm2peZmJ7mKK
	E9rVQhlg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRNMi-0053o3-71; Tue, 30 Mar 2021 23:01:40 +0000
Received: from mail-dm6nam10on2055.outbound.protection.outlook.com
 ([40.107.93.55] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRNMW-0053ld-Op
 for linux-nvme@lists.infradead.org; Tue, 30 Mar 2021 23:01:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYUJhJGLHCUxGjT5KzazLRrxi1icyxgRGxKVwxh7bFL03GjSL+yNYCnopRVGWZqZsyMIomoSgLkEyc6gH14rP9icszbRlkK9owOQ/Kacxqrt7C/GkGttIaN8ID6KljFzflHR1Qk71sbCXV2pq/m8eWQSGUSzWVxI67GsyoVitvLuRIyRg9h4O6TxHSkQSD9larJ51KMzTiqAoc6sJHc+iS+vNFnYMHQZV5bBo3QtxkhUpUC6vT5gKkwEja8rDwj6ONvPpD68IVD06d5BZNfQtmwReQFpoqtl96UIjhBHv+6jTJt0JgtqmG7zyLFr4F+jPCTiZHZj8FK92Qsoahr5+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZM1IoY6cVayN46/doXvn1UcDtQPo+sBC5c1YoOY4gww=;
 b=JqewXso5moGylnz0k5DI7OsTcall9mK6d4AzBkHvbMpRMGc+gzi6i/fcgUAwawcNmF30Md40swVM4clJD5VWmXVgFNIeKg+FAn6WWlHn/wGR7tijsXzMdIkxC6h/5am+/Qzj2iq+D9dkVHBFn0x+Cbp4M99o/ydw9SXJdu5cICGOgwPQvG9cw+N/psry2HaUautf+Ee4eLc42vOUtAhk/0CYoU4ms6j0746pkzvFxhW3zMNawJR+pGPT2s6U+5FH8j0Kdqa785TlZ4JK7hor4yCJ60x9dL3zh6iXuvOA1KrWxG5NMapoBS3iNwzwrh0DJhx2Xx0J9LRhSbOlYC3KTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZM1IoY6cVayN46/doXvn1UcDtQPo+sBC5c1YoOY4gww=;
 b=pWQj6623KjgPriIS+mQJASouIarj7XyblP+fVXb/nA3wAKvEt1Jy8xZvSuo1SG13BNP0bF8xPHsK4TlY15fYBgcxJwgJugcKneUiNPXFTBupoqpXWu9GrJcjPB/TvpvoNH1aRAigRXCi8RvKA32KG6AXYtAQCt/KE6Tq8yHUUE5W/9PATyvyXyHHr6GAVdxaAcP1oN9g5NYFmt9jwp9IjNeXML0DgVNs5TG5hUYcDpULSv+nQtMAtTg27BM15fXYbSGVcEC3vh4tp0UacP/PhsqzQ6sfTfMy33ZB1b6ZgzNaYjV8RxzWnsdPKHtEPTPTlBlcJDcChXJ+6XqfX5+UTg==
Received: from CO2PR04CA0167.namprd04.prod.outlook.com (2603:10b6:104:4::21)
 by SJ0PR12MB5488.namprd12.prod.outlook.com (2603:10b6:a03:3ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Tue, 30 Mar
 2021 23:01:24 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:4:cafe::f5) by CO2PR04CA0167.outlook.office365.com
 (2603:10b6:104:4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend
 Transport; Tue, 30 Mar 2021 23:01:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3955.18 via Frontend Transport; Tue, 30 Mar 2021 23:01:23 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 30 Mar
 2021 23:01:23 +0000
Received: from r-nvmx02.mtr.labs.mlnx (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 30 Mar 2021 23:01:21 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <kbusch@kernel.org>, 
 <hch@lst.de>, <chaitanya.kulkarni@wdc.com>, <jsmart2021@gmail.com>
CC: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 1/2] nvme-tcp: check sgl supported by target
Date: Tue, 30 Mar 2021 23:01:19 +0000
Message-ID: <20210330230120.268671-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73041b4d-eef4-45fd-3a2a-08d8f3cfbdb8
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5488:
X-Microsoft-Antispam-PRVS: <SJ0PR12MB54882AC69FD6090E62B49288DE7D9@SJ0PR12MB5488.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:913;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q35/x1bUXM2ri4ZtqvXH5Nvt2YKYpvQdbGUMD9RanXYzpMaJpE+CDQvzo+asnopEKAMd1NWnG+ux6EwwSJMdcvmRtqjo02LCgcMfW/d1T9Uql3fRNFR8O9BOAS24K1ifC8+xvyx7PAYh84+idqou0E2Ns0XfY0lkeMPOS7F3zlFyYZMHynyKISzpb9RVTx+zE5IX0MG631mgCEKXHubI6ek3yIGhGE70GBLkW0esbxFtmrypKWqVKqtlvLaD4do+P8Sn6DUQqANBgb3aMbSzXahNtJahGqrmD4wD+ZtOK5N3SQBszdMjH+DPlzcmZsys/uj3BGXVfiqNUZXoalf41UvPPdTSRBpu9/0EQkphgL2tPJDzmpr8l54WCohLppJzxvYdBX1ZY8iPAwmdBZgsJ5HTSmYYjZJVoQYbMkQ4MI4KHUUn54hZckWer+InvBuhfAHf3Bv5xwl3X4NyEmI6aT32ta8u4zyFwGLSan165z+9G0/qRIgnPgAsk2LDStgf4a/zy+Lvs9rE2gt2ThT4yDrcmg4KvtiL8c6O+WKhMqhGVdRv/F7tUYzFpFnt0sOpceifYz8jd233yvbB2ZRreloZURgsalVrUkI7Ftb4MlQUl3yOt4AGLtPJqJhgfEb4CdZ5DYsZg5cNSRo9BIK/Mmz20hMZvn38j3bs2Hkr1hs=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(136003)(346002)(46966006)(36840700001)(426003)(336012)(5660300002)(36906005)(70206006)(70586007)(47076005)(4744005)(110136005)(8936002)(186003)(316002)(478600001)(7636003)(82310400003)(107886003)(4326008)(2616005)(2906002)(36756003)(82740400003)(36860700001)(86362001)(26005)(1076003)(83380400001)(8676002)(356005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 23:01:23.8622 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73041b4d-eef4-45fd-3a2a-08d8f3cfbdb8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5488
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_000129_805777_7C6F0AE7 
X-CRM114-Status: UNSURE (   8.57  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SGLs support is mandatory for NVMe/tcp, make sure that the target is
aligned to the specification.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/tcp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index a0f00cb8f9f3..e5fbb921165e 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1973,6 +1973,11 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 		goto destroy_admin;
 	}
 
+	if (!(ctrl->sgls & ((1 << 0) | (1 << 1)))) {
+		dev_err(ctrl->device, "Mandatory sgls are not supported!\n");
+		goto destroy_admin;
+	}
+
 	if (opts->queue_size > ctrl->sqsize + 1)
 		dev_warn(ctrl->device,
 			"queue_size %zu > ctrl sqsize %u, clamping down\n",
-- 
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
