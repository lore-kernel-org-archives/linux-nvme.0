Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF92EB8FAF
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Sep 2023 11:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KwlzK9SkwhyGMNdY8ffnINM2B9sPombX/cxmxIbMrjg=; b=W8/a8RGWZcGRq7V0VBBkjaQxqn
	Kstfy8z2LR07K1ySaDnFUNXbHHVgZdTudvXiWwS/AawC2uHUqfqzw1timgHqZBLDD3xchma6djlnH
	QBuCmIb3esQCmio5+Ui5XxxKmgtMNiCKDyR7/phHGqVTAx9+Dm7Mko12XwycLO3mTaWK93eZZmbMZ
	xZ1aS1MwT5RpIDr49K8PwwVh924eN36NvP3gdh4YbhUObKccZx1mjdM+l0jN5ibFtYU/5fBw5ClGA
	WAzhAy5odGzWwhsZ/9aVIJrsgmrGjJ9m6mBr2zbTOnyWiWtFqBprRDx16E5PkV1o58nD/XL1VJa5u
	ng9tJ6IA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qdqlS-008n3U-0p;
	Wed, 06 Sep 2023 11:32:06 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qdqlQ-008n1L-0X
	for linux-nvme@bombadil.infradead.org;
	Wed, 06 Sep 2023 11:32:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Sender:Reply-To:Content-ID:Content-Description;
	bh=KwlzK9SkwhyGMNdY8ffnINM2B9sPombX/cxmxIbMrjg=; b=MvrZGPjfrUhGOVtsEfmXWiWq7+
	ASiVaUNQ4XvSlg2Fy/QABwQYrQoMBWl4jFhdHFgxbVkGUkeLIq6oh/Owplc6Ta3PEjcy6uYdWwWGD
	VtRCCpnf4u570NVKsgrbrZguMYbPz2eTlrL3R6uEnDb8ppzAf186J0WGo29MBgwuqxv75ev4uXUvx
	bEHZ/LHKiFrYsYAm9p9bIBfGp528hD+WnB5W2/s4pL+51XV6FuwLxiagBlz74p7pDhlgF4nrhXsNc
	lyriZIlfZMKsvfL19xeiV/eb78g1ZQm6jCIwZDtzZF9YK6Dgxh3KYG9jqczswDDzDRxeKXC9AzeW8
	SZKxQFKg==;
Received: from mail-dm6nam10on20602.outbound.protection.outlook.com ([2a01:111:f400:7e88::602] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qdqlH-001505-2v
	for linux-nvme@lists.infradead.org;
	Wed, 06 Sep 2023 11:32:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CCByb7c9AyuS+fXvNDqfPicelB/rt72FMmiWpWe5lUBVktU+mN0htXMlrBwloJfhsoBBWiXlKt3c+hENqQSJBQfMWERLfPSYo9RH9KQhjmb2HhU2kBS6Oj8K4LbCoGMiPmK0Pmc7EuY6PweWj7MPGuFS6RyCkUYSk54bT5WEhSB+WfnLyREX6D0Ie5t38xgNVbVQRb7KA1JmDM9M1IwC4HhMsBshi++nQ12lfgNGPo5TXmHDcmrVgA9njb+DPt7/V2RgJBhavruSnZB9lvQIjjfnrtchJU6/BQN2fK459CFh5ovX6hCvMS2PILjoanMq2QPKBx7BB+v8Ar2nAtUjGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwlzK9SkwhyGMNdY8ffnINM2B9sPombX/cxmxIbMrjg=;
 b=DLPP34hX+dh8fPdEG811xr9cxWwlxTE9WaiGoB/ngZcGqM5oua/hDhQGtcMVR4AAh/LCEkdsVh7Vcbb0Vjdtg5EY1/by9/3YSRdlQNspSQM7P0sWEpxzaZFZ7jStNPH1L/1vte0MjZ3iJSVcSHhtgg84kOnFIB7IJt0SU8mDIujVu4NX99YUnr9kg4SWIbmpHabwpX6/NPcvUhLV0WN056VpaYpfdR4sgK3ttfJO5i5GYm1X5BsvSfvo1petv7e7TS/41/LGhpZtaW7Y2cZLRmSBoJgiyz5x5RmEpQaX06y1iA20IWB5nlUhQMhcTHs2DYzLQc2t2pvBJJpDh7SHow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwlzK9SkwhyGMNdY8ffnINM2B9sPombX/cxmxIbMrjg=;
 b=tAX1B0/n+0Ba5QeQ7jeSaDWIYpFlqOsVPCXHPgueTEiQ1ofFOTCQm1mahRkISz8AfxFOTqfjgv3PtZNSNW91HJml1u2WYQxnvBno7XA6JwAlbfG+2IvMSPLk59f86/+yFD0p+vNyOy13NRRsV60zG0lwx9ZcYDAPIKbMaiF0e8S58j6h6tVeeAaAPbWdjG7LLrCckeXFzpMMAdOmh04rb4uSbMZv9RopdOnW/60XF5TXobvidtg0AafKlvb2G79f+Qew9ESSx6HYeQPK8FOjvib06UCd3xBqNgkKLyU/M2tQyP8cfKyy+eBg7zbrI0Kt5pHxJswmIfGFNTZnJPYIww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DM4PR12MB6325.namprd12.prod.outlook.com (2603:10b6:8:a4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 11:31:52 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 11:31:52 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: Ben Ben-Ishay <benishay@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com
Subject: [PATCH v14 12/20] net/mlx5: Add NVMEoTCP caps, HW bits, 128B CQE and enumerations
Date: Wed,  6 Sep 2023 11:30:10 +0000
Message-Id: <20230906113018.2856-13-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906113018.2856-1-aaptel@nvidia.com>
References: <20230906113018.2856-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0054.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::14) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DM4PR12MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f60fb6c-dc46-47a2-120e-08dbaeccddee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7eBQsg9NlA9wIOcGxkpu5X6u6j9aXnxtMmnCZgBZ1F9CUqDJMLrFfB/OnUnnV9hX7sAZkBN1EXXkfrvE9IMDAGn+4FDiPC3IC87DkYHg1EXJ20Gbsw5BkuxIPJbjCAqhjXWDMqcfJiA/F/IKIDZlMgHj6CGSTf8CSdQPRmFrHvazl+9NSBkQ5kFnXkFLiN2w1YPqTenY7VeJf6rPaZ4X3trlKxLuEErZbgwBnQrxwVdMUFELRsaKGfZXwjnZFONwqwEAehKDzmJ8dECtpZROStb4umwu5v4xZxpqcDVrcgbt1jiNIT00Ac6Y+o0k+nn8wr780OoEHoQA5CAl85zxsqvAvsMI3KMfFQGsck+aO6k/er0RlTRns+c7+bJWs82vH4XAYuoo3zgABWv7YtTcOH9zHzR/PkLo1H5p6ykdKDN/uc8QBGwL45uhAnRv+oKg6hjJHA4mMX3ISqFU3veo4ByN9siz2aBX0F1lSvOUwr67/kMNeeOKt7jdesXN2pbGQ8UOh3swyAt3Cc2V2J0fg4WrQg9NzZciCBosyh2rXQ0iINNFlOOzXgu+CLJL9vPc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(366004)(376002)(396003)(1800799009)(186009)(451199024)(6486002)(6666004)(6506007)(36756003)(86362001)(38100700002)(107886003)(1076003)(2616005)(2906002)(26005)(6512007)(83380400001)(478600001)(41300700001)(8936002)(8676002)(4326008)(5660300002)(7416002)(316002)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3DrFnETkKGKMlll3LMytPSPoo4xVqwgFmH3BT9gmS9ncbsJWCXTvd7QM9QCL?=
 =?us-ascii?Q?gHGTDiMYIEN1uErxa2o6L3qn9uaas1lVmAOphj/NJciCmLQm9foNzhn2+zem?=
 =?us-ascii?Q?QeE1WhA50BdYyX1COnWs58pzzlKfguCaO/j2p/3Rtawk19a7kBWLEyqejRQA?=
 =?us-ascii?Q?jSNA9N9QJLjadIkrhZUxU74AYVmT9q5YZJ58FpGMLpXgCq52rnEF6IV14LAq?=
 =?us-ascii?Q?CzVyiwZNw1wZ2PIdEhN4lWUCg8jpa/R2TrDsZNZd2aPs7qAPVgwSpqrLMORd?=
 =?us-ascii?Q?GRzvtz/+cILhCm/ky7FHKdW+v2hIhI9/2CydH/wTJisw9V/dRInw8nPtUyMj?=
 =?us-ascii?Q?JH8ayBDquqrrawsL6LOXv6FdIhpll0J7wfPrcuf9Q+ZOiIntq0BiK49qYUtL?=
 =?us-ascii?Q?+/5j5Cjz4I4m8EgU0FkhhC8l9JdCT3Q7uxEO/BwtExk/tSTwSaCBiJf4DkGT?=
 =?us-ascii?Q?uNWGWqN/lxa38scmDz8V579vMNtXyL8tvFxPrkmT5xTOxvtvFq+lHkPTCkqe?=
 =?us-ascii?Q?GEG6PmJnGuX7/EV23NhdQMcvfKhmW+WDSFcwrnMBKv7P8Mb+saYO75SZphh5?=
 =?us-ascii?Q?rMOh9jw8CcmeWJa32DIwWXQqAPlMPI0AlQqOjOmoTzceIePPnbxVYAwXG3C2?=
 =?us-ascii?Q?SknLsFU2mFpq7j+UAn32OKJ8p4HMDy8VbQYde+HC7TRdjGhtGwTkWLfmwR8W?=
 =?us-ascii?Q?m0M4LBOtZ/l6MhqN7eEhy4rotLuaftlUPkHLQ7Bh1dFlKdlhn9o4OP/sJYNq?=
 =?us-ascii?Q?KptxX6PkRdu8H5sfyUFnpCDVN/UURadX0yK6gRVHy7q+g0FfL5tgOLHqz2tg?=
 =?us-ascii?Q?pIuvYIEt0w8Ad9nfpvyG+9QLI+R2/kbg+oqQubjTwWLASMNWK3hilnb08dlI?=
 =?us-ascii?Q?zSzKm2Uxk670QKAad+E1++ODPwB+Pckk0ogLWCuqElT3EyAlFMFle8b+E+Bf?=
 =?us-ascii?Q?OrJGm+maJ21h9HTvBcOC74DZmcqnASwtBWFDNRJ0wSVCr7rDK94Ut+qsG43K?=
 =?us-ascii?Q?ri9hPiQ/4BEHXQ6ZBDU0J7f5zgCFSDMaly1M347QNhA/vChd67b9DezT6U5Y?=
 =?us-ascii?Q?6mKmvVZvgiwti1a9l54kLPeyH2JTVpJP1cEXHDB5BxuGT2h7Ybrto25ij6Cs?=
 =?us-ascii?Q?MXc183S5n5OJ9QEdztPuGVJp/GCrSzy/JfgnLabP6q84gGpZHFUM0Mh3//cx?=
 =?us-ascii?Q?dhztUmaZ0PKgI2LNRdFQwDX5ktsWIdyLxHKNYoe9ZzSPacqv1bTljSpDGC1S?=
 =?us-ascii?Q?vKDX8KpiBLDbiLbTtjLqHkTK8WwnpW/noZvIGGlRqD9TYK307+VJTdemcxgl?=
 =?us-ascii?Q?VToIQWCodsG+9XOAdzOF+nwybRiyQlRrm7ItMnVH5vOqHjDGmIzIR2CDHPmK?=
 =?us-ascii?Q?0aJoyntzBd9qw6nzfLARgw+w4nCJxbUcu/mouw4GocNejG94A0oY5I8lcgUj?=
 =?us-ascii?Q?C9hSHuDzIm3O/kmqu3iplz5t8jku+Q0QSh4F7a5UOdX6PpaQC1E1IC25Gtwf?=
 =?us-ascii?Q?lsmoVbEotQcLt9f7SWpWqPF1HiIQ0KfIEOXoqT1PU+xygxK1iX05A8xsY7/q?=
 =?us-ascii?Q?AI48RgJsAVa0I7eMnubWpQXWVG5c1kDkoXsIZt+6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f60fb6c-dc46-47a2-120e-08dbaeccddee
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 11:31:52.4800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AijCPFXBQ4/rirErcV7H5q6zJ80QklbeymSvvjpnaWeJQ3AcmJO4ubOpvfSKulEzC2HHkn2pwb4EMJUJvl1NIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6325
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230906_123159_459428_863B59F2 
X-CRM114-Status: GOOD (  15.54  )
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

From: Ben Ben-Ishay <benishay@nvidia.com>

Add the necessary infrastructure for NVMEoTCP offload:
- Create mlx5_cqe128 structure for NVMEoTCP offload.
  The new structure consist from the regular mlx5_cqe64 +
  NVMEoTCP data information for offloaded packets.
- Add nvmetcp field to mlx5_cqe64, this field define the type
  of the data that the additional NVMEoTCP part represents.
- Add nvmeotcp_zero_copy_en + nvmeotcp_crc_en bit
  to the TIR, for identify NVMEoTCP offload flow
  and tag_buffer_id that will be used by the
  connected nvmeotcp_queues.
- Add new capability to HCA_CAP that represents the
  NVMEoTCP offload ability.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fw.c |  6 ++
 include/linux/mlx5/device.h                  | 51 ++++++++++++-
 include/linux/mlx5/mlx5_ifc.h                | 75 ++++++++++++++++++--
 include/linux/mlx5/qp.h                      |  1 +
 4 files changed, 128 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw.c b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
index 58f4c0d0fafa..f1745f69337b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
@@ -280,6 +280,12 @@ int mlx5_query_hca_caps(struct mlx5_core_dev *dev)
 			return err;
 	}
 
+	if (MLX5_CAP_GEN(dev, nvmeotcp)) {
+		err = mlx5_core_get_caps(dev, MLX5_CAP_DEV_NVMEOTCP);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index d7191c046c3e..aea67ac33691 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -264,6 +264,7 @@ enum {
 enum {
 	MLX5_MKEY_MASK_LEN		= 1ull << 0,
 	MLX5_MKEY_MASK_PAGE_SIZE	= 1ull << 1,
+	MLX5_MKEY_MASK_XLT_OCT_SIZE     = 1ull << 2,
 	MLX5_MKEY_MASK_START_ADDR	= 1ull << 6,
 	MLX5_MKEY_MASK_PD		= 1ull << 7,
 	MLX5_MKEY_MASK_EN_RINVAL	= 1ull << 8,
@@ -795,7 +796,11 @@ struct mlx5_err_cqe {
 
 struct mlx5_cqe64 {
 	u8		tls_outer_l3_tunneled;
-	u8		rsvd0;
+	u8		rsvd16bit:4;
+	u8		nvmeotcp_zc:1;
+	u8		nvmeotcp_ddgst:1;
+	u8		nvmeotcp_resync:1;
+	u8		rsvd23bit:1;
 	__be16		wqe_id;
 	union {
 		struct {
@@ -844,6 +849,19 @@ struct mlx5_cqe64 {
 	u8		op_own;
 };
 
+struct mlx5e_cqe128 {
+	__be16 cclen;
+	__be16 hlen;
+	union {
+		__be32 resync_tcp_sn;
+		__be32 ccoff;
+	};
+	__be16 ccid;
+	__be16 rsvd8;
+	u8 rsvd12[52];
+	struct mlx5_cqe64 cqe64;
+};
+
 struct mlx5_mini_cqe8 {
 	union {
 		__be32 rx_hash_result;
@@ -879,6 +897,28 @@ enum {
 
 #define MLX5_MINI_CQE_ARRAY_SIZE 8
 
+static inline bool cqe_is_nvmeotcp_resync(struct mlx5_cqe64 *cqe)
+{
+	return cqe->nvmeotcp_resync;
+}
+
+static inline bool cqe_is_nvmeotcp_crcvalid(struct mlx5_cqe64 *cqe)
+{
+	return cqe->nvmeotcp_ddgst;
+}
+
+static inline bool cqe_is_nvmeotcp_zc(struct mlx5_cqe64 *cqe)
+{
+	return cqe->nvmeotcp_zc;
+}
+
+/* check if cqe is zc or crc or resync */
+static inline bool cqe_is_nvmeotcp(struct mlx5_cqe64 *cqe)
+{
+	return cqe_is_nvmeotcp_zc(cqe) || cqe_is_nvmeotcp_crcvalid(cqe) ||
+	       cqe_is_nvmeotcp_resync(cqe);
+}
+
 static inline u8 mlx5_get_cqe_format(struct mlx5_cqe64 *cqe)
 {
 	return (cqe->op_own >> 2) & 0x3;
@@ -1219,6 +1259,7 @@ enum mlx5_cap_type {
 	MLX5_CAP_VDPA_EMULATION = 0x13,
 	MLX5_CAP_DEV_EVENT = 0x14,
 	MLX5_CAP_IPSEC,
+	MLX5_CAP_DEV_NVMEOTCP = 0x19,
 	MLX5_CAP_CRYPTO = 0x1a,
 	MLX5_CAP_MACSEC = 0x1f,
 	MLX5_CAP_GENERAL_2 = 0x20,
@@ -1426,6 +1467,14 @@ enum mlx5_qcam_feature_groups {
 #define MLX5_CAP_MACSEC(mdev, cap)\
 	MLX5_GET(macsec_cap, (mdev)->caps.hca[MLX5_CAP_MACSEC]->cur, cap)
 
+#define MLX5_CAP_DEV_NVMEOTCP(mdev, cap)\
+	MLX5_GET(nvmeotcp_cap, \
+		 (mdev)->caps.hca[MLX5_CAP_DEV_NVMEOTCP]->cur, cap)
+
+#define MLX5_CAP64_DEV_NVMEOTCP(mdev, cap)\
+	MLX5_GET64(nvmeotcp_cap, \
+		   (mdev)->caps.hca[MLX5_CAP_DEV_NVMEOTCP]->cur, cap)
+
 enum {
 	MLX5_CMD_STAT_OK			= 0x0,
 	MLX5_CMD_STAT_INT_ERR			= 0x1,
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 058abd75728d..182385a7ea5a 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1455,6 +1455,20 @@ enum {
 	MLX5_STEERING_FORMAT_CONNECTX_7   = 2,
 };
 
+struct mlx5_ifc_nvmeotcp_cap_bits {
+	u8    zerocopy[0x1];
+	u8    crc_rx[0x1];
+	u8    crc_tx[0x1];
+	u8    reserved_at_3[0x15];
+	u8    version[0x8];
+
+	u8    reserved_at_20[0x13];
+	u8    log_max_nvmeotcp_tag_buffer_table[0x5];
+	u8    reserved_at_38[0x3];
+	u8    log_max_nvmeotcp_tag_buffer_size[0x5];
+	u8    reserved_at_40[0x7c0];
+};
+
 struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         reserved_at_0[0x10];
 	u8         shared_object_to_user_object_allowed[0x1];
@@ -1479,7 +1493,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         event_cap[0x1];
 	u8         reserved_at_91[0x2];
 	u8         isolate_vl_tc_new[0x1];
-	u8         reserved_at_94[0x4];
+	u8         reserved_at_94[0x2];
+	u8         nvmeotcp[0x1];
+	u8         reserved_at_97[0x1];
 	u8         prio_tag_required[0x1];
 	u8         reserved_at_99[0x2];
 	u8         log_max_qp[0x5];
@@ -3454,6 +3470,7 @@ union mlx5_ifc_hca_cap_union_bits {
 	struct mlx5_ifc_macsec_cap_bits macsec_cap;
 	struct mlx5_ifc_crypto_cap_bits crypto_cap;
 	struct mlx5_ifc_ipsec_cap_bits ipsec_cap;
+	struct mlx5_ifc_nvmeotcp_cap_bits nvmeotcp_cap;
 	u8         reserved_at_0[0x8000];
 };
 
@@ -3706,7 +3723,9 @@ struct mlx5_ifc_tirc_bits {
 
 	u8         disp_type[0x4];
 	u8         tls_en[0x1];
-	u8         reserved_at_25[0x1b];
+	u8         nvmeotcp_zero_copy_en[0x1];
+	u8         nvmeotcp_crc_en[0x1];
+	u8         reserved_at_27[0x19];
 
 	u8         reserved_at_40[0x40];
 
@@ -3737,7 +3756,8 @@ struct mlx5_ifc_tirc_bits {
 
 	struct mlx5_ifc_rx_hash_field_select_bits rx_hash_field_selector_inner;
 
-	u8         reserved_at_2c0[0x4c0];
+	u8         nvmeotcp_tag_buffer_table_id[0x20];
+	u8         reserved_at_2e0[0x4a0];
 };
 
 enum {
@@ -11907,6 +11927,7 @@ enum {
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_ENCRYPTION_KEY = BIT_ULL(0xc),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_IPSEC = BIT_ULL(0x13),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_SAMPLER = BIT_ULL(0x20),
+	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_NVMEOTCP_TAG_BUFFER_TABLE = BIT_ULL(0x21),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_FLOW_METER_ASO = BIT_ULL(0x24),
 };
 
@@ -11914,6 +11935,7 @@ enum {
 	MLX5_GENERAL_OBJECT_TYPES_ENCRYPTION_KEY = 0xc,
 	MLX5_GENERAL_OBJECT_TYPES_IPSEC = 0x13,
 	MLX5_GENERAL_OBJECT_TYPES_SAMPLER = 0x20,
+	MLX5_GENERAL_OBJECT_TYPES_NVMEOTCP_TAG_BUFFER_TABLE = 0x21,
 	MLX5_GENERAL_OBJECT_TYPES_FLOW_METER_ASO = 0x24,
 	MLX5_GENERAL_OBJECT_TYPES_MACSEC = 0x27,
 	MLX5_GENERAL_OBJECT_TYPES_INT_KEK = 0x47,
@@ -12279,6 +12301,20 @@ struct mlx5_ifc_query_sampler_obj_out_bits {
 	struct mlx5_ifc_sampler_obj_bits sampler_object;
 };
 
+struct mlx5_ifc_nvmeotcp_tag_buf_table_obj_bits {
+	u8    modify_field_select[0x40];
+
+	u8    reserved_at_40[0x20];
+
+	u8    reserved_at_60[0x1b];
+	u8    log_tag_buffer_table_size[0x5];
+};
+
+struct mlx5_ifc_create_nvmeotcp_tag_buf_table_in_bits {
+	struct mlx5_ifc_general_obj_in_cmd_hdr_bits general_obj_in_cmd_hdr;
+	struct mlx5_ifc_nvmeotcp_tag_buf_table_obj_bits nvmeotcp_tag_buf_table_obj;
+};
+
 enum {
 	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_KEY_SIZE_128 = 0x0,
 	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_KEY_SIZE_256 = 0x1,
@@ -12292,6 +12328,13 @@ enum {
 
 enum {
 	MLX5_TRANSPORT_STATIC_PARAMS_ACC_TYPE_TLS               = 0x1,
+	MLX5_TRANSPORT_STATIC_PARAMS_ACC_TYPE_NVMETCP           = 0x2,
+	MLX5_TRANSPORT_STATIC_PARAMS_ACC_TYPE_NVMETCP_WITH_TLS  = 0x3,
+};
+
+enum {
+	MLX5_TRANSPORT_STATIC_PARAMS_TI_INITIATOR  = 0x0,
+	MLX5_TRANSPORT_STATIC_PARAMS_TI_TARGET     = 0x1,
 };
 
 struct mlx5_ifc_transport_static_params_bits {
@@ -12314,7 +12357,20 @@ struct mlx5_ifc_transport_static_params_bits {
 	u8         reserved_at_100[0x8];
 	u8         dek_index[0x18];
 
-	u8         reserved_at_120[0xe0];
+	u8         reserved_at_120[0x14];
+
+	u8         cccid_ttag[0x1];
+	u8         ti[0x1];
+	u8         zero_copy_en[0x1];
+	u8         ddgst_offload_en[0x1];
+	u8         hdgst_offload_en[0x1];
+	u8         ddgst_en[0x1];
+	u8         hddgst_en[0x1];
+	u8         pda[0x5];
+
+	u8         nvme_resync_tcp_sn[0x20];
+
+	u8         reserved_at_160[0xa0];
 };
 
 struct mlx5_ifc_tls_progress_params_bits {
@@ -12553,4 +12609,15 @@ struct mlx5_ifc_modify_page_track_obj_in_bits {
 	struct mlx5_ifc_page_track_bits obj_context;
 };
 
+struct mlx5_ifc_nvmeotcp_progress_params_bits {
+	u8    next_pdu_tcp_sn[0x20];
+
+	u8    hw_resync_tcp_sn[0x20];
+
+	u8    pdu_tracker_state[0x2];
+	u8    offloading_state[0x2];
+	u8    reserved_at_44[0xc];
+	u8    cccid_ttag[0x10];
+};
+
 #endif /* MLX5_IFC_H */
diff --git a/include/linux/mlx5/qp.h b/include/linux/mlx5/qp.h
index bd53cf4be7bd..b72f08efe6de 100644
--- a/include/linux/mlx5/qp.h
+++ b/include/linux/mlx5/qp.h
@@ -227,6 +227,7 @@ struct mlx5_wqe_ctrl_seg {
 #define MLX5_WQE_CTRL_OPCODE_MASK 0xff
 #define MLX5_WQE_CTRL_WQE_INDEX_MASK 0x00ffff00
 #define MLX5_WQE_CTRL_WQE_INDEX_SHIFT 8
+#define MLX5_WQE_CTRL_TIR_TIS_INDEX_SHIFT 8
 
 enum {
 	MLX5_ETH_WQE_L3_INNER_CSUM      = 1 << 4,
-- 
2.34.1


