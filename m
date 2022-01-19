Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696D5C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jan 2022 07:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2D2lttzLiFtIzm3cMyYCrkryXl7NphJKjFywqvQXz2k=; b=OFI1hxg+yhmcNnRa08JYVCY7p8
	Yph00xdk9LzvYIp/ww8dowWfHbmqCtIIOEcNkPdj5Vzp8vIouOJ0rrQjtfOJqYeYK8ymV79p8qPE5
	IdckSHCOuBEMDLXRLrvdIDphlnBZmH0eAXfFbRUzC4pVgYvqAVirU3mIIcS7UeEBq/JaxOGgpSAHp
	jqwoR5aSeucLsLPbwTPyomgStgLm5g6rnQd966l/9QMkK34O3Ouqd/bBpoGI+3RAtZWSegFF77n0I
	WwTkRxZ2R6NKg4QVx1GBLm0YnzG8MDMwVSE8q3+XygyIu0MKQOUr+tUv05C905yG9jHykSjp7LEgW
	30xJpLRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nA5jP-004FYo-1r; Wed, 19 Jan 2022 07:50:11 +0000
Received: from mail-bn7nam10on2057.outbound.protection.outlook.com
 ([40.107.92.57] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nA5jL-004FXc-Kw
 for linux-nvme@lists.infradead.org; Wed, 19 Jan 2022 07:50:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXB7jwAwfNfqJzh/Vh1vAM4s0ns3lvvcT87pIfuoOdulk6CgzDCwCsA/NlWPB4eMkRVdUxYTnP2p7tHio9diKTk8auFHzfOucPbWL9XCgEC7yMeD7IEJDamhzcPzzObX+O7KtT7wGV3We9mxJP92lqQb0Wkv+ZWKF5vr/0kpxp/MWgVV3C4O3sam2PrBbiBQIHjwK0IrGMvfqvbRwcpW0chwlLUc2qw0ax3W75pmfGlyHDBuFIKK0QUoTwpJ/iDCCv0lkc1XeAwyLFrcofYFCJDk4Ip8+vURG9Hf2npbco1AfecMS9dbuzz2XcOaE+p+w54nORFfmsedG/iTS4qKdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2D2lttzLiFtIzm3cMyYCrkryXl7NphJKjFywqvQXz2k=;
 b=N61nUU2t0P6yIL2JzXA01lSGpCjaX4HEKfU1zayGUYdCV8nY8qXiQeacE0etafDkQpgRRNqnSvqo+GU29kUmxrelCQuE+2jEVE7tJTLWrOP4nPMKNDUUelv2vvMhyf9v7LcT+0/AfVo9y6MHbEKBBdVYmoSbeNAP4WA2bbXuzabDqEGL9FQxa+1sGcBJNzplqLdIIkcBrd9ViL+mdyhoSMhjL9i5Kd0gc7qmgPh7xy2xcm1+CTq0pF729LoPtBq/pSKF0FZQ2csWd/wza4LCLaaz0qewVM0+VMsGqN3I5JtAvVPdCJgFMVJKa/kEH7nw8e4fA4UPCGyqgDP5Lb27+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2D2lttzLiFtIzm3cMyYCrkryXl7NphJKjFywqvQXz2k=;
 b=Jf1Ltcc8hDWmA8GMsQdnwx6wzGOqiVP/EkCz3UBX2cxD76cxxxieiklyx5k1/btAeKtHCKirx8leHFBb2XMzgp9YIl+OR78meDLWQDRL+rZFQCgwrILScxJ40g+P7P3vKC5VprVBfVo/D2migsq58KIXDBZksbLdVtrkp5dhSQ+ofDD/WU3wcS7/WxjQktH5vxLgf2aUw+Z/PatT82BveX6SSzd0Cg7RuoIpC/ulNfpIZoEWKa6RmpRtBf3TKjiyxk1sUYckL5WPYiiEg/UUxPAQ/chBLsMQ0g+dnfzmflo2QivDdBvU3kg7Zc714/QsAt7mv1vtQM9TQO6w4Xp9vw==
Received: from DM5PR1401CA0005.namprd14.prod.outlook.com (2603:10b6:4:4a::15)
 by MWHPR12MB1341.namprd12.prod.outlook.com (2603:10b6:300:11::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Wed, 19 Jan
 2022 07:50:03 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4a:cafe::cc) by DM5PR1401CA0005.outlook.office365.com
 (2603:10b6:4:4a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7 via Frontend
 Transport; Wed, 19 Jan 2022 07:50:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4909.7 via Frontend Transport; Wed, 19 Jan 2022 07:50:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Wed, 19 Jan 2022 07:50:02 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Tue, 18 Jan 2022
 23:50:01 -0800
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <kbusch@kernel.org>, <sagi@grimberg.me>, Chaitanya Kulkarni
 <kch@nvidia.com>
Subject: [PATCH] nvme-core: remove unnecessary semicolon
Date: Tue, 18 Jan 2022 23:49:54 -0800
Message-ID: <20220119074954.13531-1-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75c73368-7f1a-4051-2faf-08d9db204d2d
X-MS-TrafficTypeDiagnostic: MWHPR12MB1341:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1341BC4564DB35E0870C7D28A3599@MWHPR12MB1341.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zkbnvMGtyJXxAS2wABWmtdRWpAyT2BCsGMV4Kr0y4Xq1ZGpG6WdUAjcaWhvShPE7a+dfqy7Pz/XpFLGaPmBhF2PMHxrMn5/yni/HQgzSz6nLAssU20DpP7B+hAfyqDvfisALL86mxJyaiiSMRv//rDxVyI+DC+8sj3iZopilVwJ43h4RtPVos4xHVzGVVXlahUZpVryQiiUouoDM3TxQMAoQYFRqQO79XCVHmWaVuGr7BeRSIsL+Cy0d7HRpOfdbGzn84WKAwFopJRgYEbqMYMGEJDCFgV0pGXz0KOSiuDpCUa0w2vUcbk2wTfdmFavDX1WCnoiD813XbCx40uPaDbKZmt9e4rnINKvuC/ORSWBKY2/NHiYnrpj21sJIM6oDEF6dNp2lbKhkkg76gYBYmX4Rl4F1FXI5NQqwV6TZ67LKgJgngiY2C6/RH/lwSkhR9Iuen8ydMesm4bJRp1A7jOUzkUCbUWupTjVGXGWfsBPW0TeHDLR1zQHMbDfKGEq4i6AWKsa4FCEM44Yq+jnklFzqqxUbMZ1wt3ZoYpEztgP3nqQ7/fTSEZvXNYEJrIpO69D56xcUvcVdprqGRDJhh+nSC2rlZZ4I0fqtstVJMwE1DTgwjHU0tEdvEZBE2SAdPFuz6OtJd4QEtKN5giqb2ViVuSkvSZ8PTOugXWPJz/LC7RPo8rFEGfagb1O9hkmCX7LRJ0gAMyKL2nQOfI6jKaC4scv60GJPf70aO7sIglsH650MUwONALrshV2/f7B4ZVx/3+pC//El27/i25pAuJ/5/2l3icsOKwBAmjMYiIQ=
X-Forefront-Antispam-Report: CIP:12.22.5.236; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(336012)(2906002)(26005)(186003)(1076003)(7696005)(4744005)(2616005)(70206006)(508600001)(70586007)(6666004)(6916009)(426003)(8936002)(47076005)(81166007)(83380400001)(107886003)(40460700001)(86362001)(4326008)(36860700001)(8676002)(356005)(54906003)(316002)(5660300002)(82310400004)(16526019)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 07:50:02.8785 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c73368-7f1a-4051-2faf-08d9db204d2d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.236];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1341
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220118_235007_734421_945FB1BD 
X-CRM114-Status: GOOD (  10.79  )
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

From: Chaitanya Kulkarni <kch@nvidia.com>

It is not a good practice to have a semicolon at the end of the
function definition. Remove it from nvme_pr_type().

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4fc794d9c2f4..1759538b36fc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1967,7 +1967,7 @@ static char nvme_pr_type(enum pr_type type)
 	default:
 		return 0;
 	}
-};
+}
 
 static int nvme_send_ns_head_pr_command(struct block_device *bdev,
 		struct nvme_command *c, u8 data[16])
-- 
2.29.0


