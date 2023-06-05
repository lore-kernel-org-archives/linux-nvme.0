Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA482C77B73
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jun 2023 09:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Tp10a4xn+XvaE6//emhvn5KyUe8ztEzDLRiQntHLPqI=; b=Ba+5DMEudFpOWePpdMVXx5Bn9e
	J4YO6TQiNL3/+OSZRHN/7OErbW6pNMCZwUHfJfCaQ620BPU0llpyElTxin4r/pVLIPtGeHIJaR5H1
	kw/0n8dTICuamvPkobmxEa0rcNiqf5sHV8JhoExC6jUf4HLU/mfeamZjwdkMCV08hn9w91oLy0NIs
	VuSjXomRxcv2VjCQKTobXuqJtKqMFdYbjxZxd50ggcTQlqqIAK0omsC5UPIGwwPZ2iFKpk1HtkZEy
	NIMcYZVRDkZGyuauSYG6nl2OZdeaYe6Ng2B48MQN5EbgCMox64Us/FRWVOmaDRNJx7uWzOkGTrR34
	HhJuyuew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q66Nz-00EpAs-1h;
	Mon, 05 Jun 2023 09:20:23 +0000
Received: from mail-bn7nam10on2062e.outbound.protection.outlook.com ([2a01:111:f400:7e8a::62e] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q66Nv-00Ep8I-3B
	for linux-nvme@lists.infradead.org;
	Mon, 05 Jun 2023 09:20:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7Oh9goNrg2eGFZdvUlSxnM14hoxDhAsO8DKjX1J21wct7L/6DRH5U6dKnD9e8Q/vQNjcPDVjwbr9o/0Wypasam6cAniiLDgws3rBRoR2jpo9TGJh+mB5nKMo0Zxiqb7mfk4WQ+XDf/VIPiuLp3CIAby1S948MyKR2T6HYfda0aRn3gb/4ojJIfk+689yMZpsQI76tlI5kroGx2vqSMi4acBlRh/K1IHGLkZbX+/SqMYbhREaM+A8udXHnBJdIfDuZuqFhnNyiBGpE2G3JHaeE05pRvrzpJcZfzoHDVFGhpnwtUwiS0j3yGXR26vSPscAS8UJhZn77EaNz8ERjqqRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tp10a4xn+XvaE6//emhvn5KyUe8ztEzDLRiQntHLPqI=;
 b=ECC30smRMoT91VmX4Qj7CfLFWJQSSFdj4aQWIPDAuXIR2aiZWTClYj9UElH0M1hl6L8oBBmpu+1kPfxrJ5zsOzQ5jsDecAHskUuhbhF0EQHKV5dCT/e4FIDyq0XXBm92+qayhHIzn+EGJPbsl8+lPhMVMSSmiS8II+QTsnwlpN6pB6ppyaYJPULG/h0X/muSbiYwDULfSfyPIIDID/KAw7ohCA2yAbko+h7hIuT0BdgHXXGDEphYIo0VXLBP6ZJbLF3xnjbolSG+MOEDvcUaHQv5HgkS+5D7JxBYGYNSjGLdhxN7svGQXT2xy+AS3zUJ5FYCy71cP8Oeg9ipk8e0WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=suse.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tp10a4xn+XvaE6//emhvn5KyUe8ztEzDLRiQntHLPqI=;
 b=diwhKh3xGZBVx8+octbJP16FEjXfDQr/X5mZnPKorAy+xRua39H7oI73G6c8XFGMBR4P28UOUAYyKZvfAR3HotdJC7s+dzthX2AHnCKfUCw6FUNIUK3IQh7uXeCKhwaf9xFd2qEuDgTuSR8tA9tzB3N/oy2bI6dYUWzVdWuItkqIOpcBSfM2/fWyv9nVm049uG8rulaAsyxBzY2p3wHbCZNf5Gj26Idui3H+KpeyE8ZxJK+oqMt1U3Ma0YwpsdVpo4P9ndbpS2+Yyj4qESHnIKB5QZYUp/oqAB1h9bsAY5GvD+S46Da/FpB3wjCXwOx/3ogDm64Q7z5WX+qWAJo95A==
Received: from MW4PR04CA0077.namprd04.prod.outlook.com (2603:10b6:303:6b::22)
 by BY5PR12MB4097.namprd12.prod.outlook.com (2603:10b6:a03:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 09:20:14 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::58) by MW4PR04CA0077.outlook.office365.com
 (2603:10b6:303:6b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Mon, 5 Jun 2023 09:20:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.32 via Frontend Transport; Mon, 5 Jun 2023 09:20:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 5 Jun 2023
 02:20:02 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 5 Jun 2023
 02:20:02 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <hare@suse.de>
CC: <hch@lst.de>, <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
	<kbusch@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V3 3/3] nvmet-auth: use correct type for status variable
Date: Mon, 5 Jun 2023 02:19:20 -0700
Message-ID: <20230605091920.34253-4-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230605091920.34253-1-kch@nvidia.com>
References: <20230605091920.34253-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT050:EE_|BY5PR12MB4097:EE_
X-MS-Office365-Filtering-Correlation-Id: a01ee12d-762b-4959-5d40-08db65a611b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L4mn++tS+nCJkEjAcEsEjvYeEYGKctSAJCWI7gkT1EEt7zsKhTvgPgdaApt0WJNSUD72ea8jMDlmJP2qwXHZVdS1zn8OCvE7tKNOwv5nTIKFe1yumJJ8Bh7mNN9U3p4G+TIrfpKZKbifvCGt9etH9aO9r1xW2A8KYKF5g3ZwB7a6wSnMAPqGRKiSkjFnsP15HbQtAYBfLvnWvSrMAtQ63tvIEES5IlIa61BQdh5jQtJsiPxNKVfuoSFgDnnTnav0FQxXbzBhLUlz2ce3LREFnLp4nIdrErgQmb/Es5MIUvDdLhrfMICMFy1D1FrkaOWWL+2FuJ8iESEAidPV6XHQlj55Qnvl6lJ77zYNT36FkAlIpYO7p031JUce1ptwsurZgy7cfKB3T1j0IJl2QyLBoPiR8xilqEG0EtvQqBoQsMETgJ5fom8Bh7PpY3rxPN72uZZJ6pUzR0bWQ/Wgp5JDiLfXPKK6mG/TBqr2kTANWu7Bxd933PCmMqJYKPpLQN3iAHnyrGewT3rXlIFWVTREm4wXsUAuot5d8vDPuW8gGlK06ZtYbwLBrWXg72sLiTcMH1h2hDX8kQchF0fQVrk8v0633SjCbAWbHlK4Z4ECmAkqNBrUrJrSKF2btqgY7Jvpm4Q9sjqCghLS1iUFlbFbaTYdm3xoQaDynMZrt2I2v5jHMD6vuOdmllsxTuvFKT7Ik0WbxG49qjSKZel1W0pdIF/92IdXvrvcb//gzCKkfIdCD867fav4/W7VkIBvqgEx
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(39850400004)(396003)(451199021)(46966006)(40470700004)(36840700001)(107886003)(16526019)(1076003)(26005)(186003)(2616005)(426003)(336012)(83380400001)(47076005)(36756003)(6666004)(82310400005)(36860700001)(7696005)(2906002)(8676002)(8936002)(40480700001)(82740400003)(54906003)(478600001)(5660300002)(6916009)(4326008)(40460700003)(316002)(41300700001)(356005)(7636003)(70586007)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 09:20:13.7595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a01ee12d-762b-4959-5d40-08db65a611b3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4097
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230605_022020_030978_FFB15156 
X-CRM114-Status: UNSURE (   9.53  )
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

The dhchap_step member of structure nvmet_sq holds the following values:

        NVME_AUTH_DHCHAP_FAILURE_FAILED                 = 0x01,
        NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE             = 0x02,
        NVME_AUTH_DHCHAP_FAILURE_CONCAT_MISMATCH        = 0x03,
        NVME_AUTH_DHCHAP_FAILURE_HASH_UNUSABLE          = 0x04,
        NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE       = 0x05,
        NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD      = 0x06,
        NVME_AUTH_DHCHAP_FAILURE_INCORRECT_MESSAGE      = 0x07,

These values can never be negative, hence change int type of
dhchap_step to u16 in the nvmet_sq struct.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/nvmet.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 6cf723bc664e..66d8673c3ebf 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -113,7 +113,7 @@ struct nvmet_sq {
 	struct delayed_work	auth_expired_work;
 	u16			dhchap_tid;
 	u16			dhchap_status;
-	int			dhchap_step;
+	u16			dhchap_step;
 	u8			*dhchap_c1;
 	u8			*dhchap_c2;
 	u32			dhchap_s1;
-- 
2.40.0


