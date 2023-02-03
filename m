Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862D4C05027
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Feb 2023 13:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0C6GkE3Lz0IqQ+uCV6ZVObWbeoChvn99JVeLgHMwcDw=; b=vjPru4D1q3Qd89Gxea9hfR2G4k
	oXNJsbMOWujqQVq1JvUWFaMExJnQ/S/uHxlvFjy47qeVL0qs/62PEsG9bf96LP9n3ckOumRSRb9XQ
	KjbkZ/6m4ipSpY5bEexd8+3Hdi97NCv6XTgJe4JsvK7X+FVDcsLhtCDZremer0+fIZJsgB6DSNswI
	Jp9NuGTXbqu09dVCuGy6pcItmlK7L1cJAESMljNaONULRxVLJWYFZ6KevCA/X7Tr6+E4c/wfWJwfK
	U1e3YKTLEUzZ/7A1Fg5CgCDgwh11SttQH/oMGRKzt2MWVYCD9vzuj2bBNVuQY46Tw8VxD5PmPITga
	v59ymMag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNwB9-00248K-Np; Fri, 03 Feb 2023 13:32:35 +0000
Received: from mail-co1nam11on20621.outbound.protection.outlook.com ([2a01:111:f400:7eab::621] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNw7f-0022jE-Pl
	for linux-nvme@lists.infradead.org; Fri, 03 Feb 2023 13:29:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGETHERM2JuqMcd7Cki2AhJegnpo3om6u1TQjkwNtr5Rt6rvN7ahptI66pjaPj1jaslF3OU9vcQLpVWSrTt3GXdRAwfnqREEPOadHfwnPnRhC6+sBsGz3NLZXtHIyzelSzi/SrO+fZINrHJsNz3/vUprspF1VvQ3iwk157tY5oaqU5tx0qjMBzPPUvouF2Xd1pefdi5O4b8RpeQkKgsAStOQKOGCI1XAg5QJRwiYa6HZr4kRXOsrUG7BF+c9H7c6rTcAf36QnnSkQqhL4EirOXySMGUeaGdQkvJyyVsmdOhrE9E5YFJAcwYCzruQtr6HAJ4DwJL7zkiPzG2J4RcOdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0C6GkE3Lz0IqQ+uCV6ZVObWbeoChvn99JVeLgHMwcDw=;
 b=bifJfU8SIBPBZgtMnL2rU/9KIyGkZFLZt+t+/nhG4M9dcyShlP5IbYNJBtnp4naSoFmpg0EvdpcI7VWdk4EJH7XXFsMTz3Pz49XdSFL9Lh5Q8KsCEYqsI3Y/hjXzdMZKg5j+ap0/mKowGOumPFbmPCWphkSeoiAdiXZxsafeTgddDHb28oqz41sDaYxHGakQ1bBOKkQKlyMcH9RajjFGIH2X+h3xHNYaJEPxEFm8fCRavJgSMmagMrK9nAc9GTByw0XJu48pAXMKxon9oaBhZ8fcu6v+3+UponqkliqHdsHCr4HXDq76TEg6Wss8MJJ/VDmnZhezMK17DKL67sD4Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0C6GkE3Lz0IqQ+uCV6ZVObWbeoChvn99JVeLgHMwcDw=;
 b=Lx9ACCL/coN20LJ1xVHcOj0h6oEyoSZ7PYbb/4+jW2QeplQI/7xHsnfUX8Ztlbo9jnsMopCLqAN3HEmQS+H3pdCapaoCj551peri5NybNDjNJSiJk8oncgd860I0OBYNLzX5AdO2paeE5Fg30njLtPM0TWj9V8qD+HPxWIC50nKZ2FlTHYvm9cUISGmNcGBTu2U7HzuYadO3YVGBhkTgaZsQ0E43ocldWbAN7bnZuo6/r0IxIczTfIDicDlh4nAovRnpjGBEEKGPytF2C2ljx96+nvMqvYE36URux50Y3YifXHgse3aZFY6Oi8gZIA7ZI49C+Tm/tT+3i8HHhSfxCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by MW3PR12MB4476.namprd12.prod.outlook.com (2603:10b6:303:2d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Fri, 3 Feb
 2023 13:28:55 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::9fd9:dadc:4d8a:2d84]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::9fd9:dadc:4d8a:2d84%4]) with mapi id 15.20.6064.027; Fri, 3 Feb 2023
 13:28:55 +0000
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
Cc: Aurelien Aptel <aaptel@nvidia.com>,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com
Subject: [PATCH v11 14/25] net/mlx5e: Refactor ico sq polling to get budget
Date: Fri,  3 Feb 2023 15:26:54 +0200
Message-Id: <20230203132705.627232-15-aaptel@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230203132705.627232-1-aaptel@nvidia.com>
References: <20230203132705.627232-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR05CA0010.eurprd05.prod.outlook.com
 (2603:10a6:20b:2e::23) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|MW3PR12MB4476:EE_
X-MS-Office365-Filtering-Correlation-Id: 35f472dd-1178-430b-188b-08db05ea9954
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	NHcK/rdzfw+0nTRE4l+FQ8C1j9P/owffDUrfIg7LRq+novis1IcdRfhKRFd+USA1TPH9+JWSdHeq7pNTZ0e/W9lMw1IyERB51+oueFan6Gy2MYzI2lgA3KZz+rUWruo1uOBmAVS2aoC/j8FzCFIkklQvURm4GSOWdFvm7Eq8Fh2Cs4+/GcxR5y0lN973Pr39QcJGc+2ZE06dMMGOyiCE7xWF5frC+SlPX3hdfCGEsSCJYSplZPpaAtDk+QZ4rGC7b/gMqFB320a493F1rQOd0aXAitVCib6RKbn72Ksv5v9okBKPuuXXTyReTiRg4qlBWtowfYrgUBl1+g1sXJRfs7pZZ7WxkhOddrQzUKw2mFKrk72zIHFZw2IJFJHw+mTUxtYvGUrCIyJi2HnGZO2KvlFrNOZssB/1fIo0JfGyB775yUZvkE0mWtxYMI8WbTQDIh2YQ96lHOmBBjW79+ijSfibtqTpQEUxSVpAgCB4TpRXk6bXbduRwJSQoy9W5d6r5QdJ52xKHMeLyw4fXE76B2FNg4zL+VXKQHcaKgz1AmPy7WqcW/2b3+2jnwI640aB9Dj4iMAuPRo5GCOF8mTZHdy+Cn312iLWJ+QfSdlfh20/zFeLpJnvtrSmm3xQLaiMVqVK/0SwUjGq0HyUWbtb3Q==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(346002)(396003)(136003)(366004)(451199018)(186003)(6512007)(38100700002)(1076003)(6506007)(83380400001)(36756003)(2906002)(26005)(7416002)(478600001)(6486002)(107886003)(86362001)(41300700001)(66476007)(66556008)(8676002)(2616005)(316002)(4326008)(66946007)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?sXrKhZ6CrMM2/5Wxt+9MuuObkp7PQSCxjxlO+3cW4vPl8gE5BXcw3PylYsBI?=
 =?us-ascii?Q?5bcmiboqzQJRBHh9CJ7nkoslZdboR/JI0cEGiiCp+clie8MdIm2MgG8ctgpk?=
 =?us-ascii?Q?SX9VzoAzstd6IvbC02mRxxyBL4ajFLMU+j9BxiBV2OtX0B7J/WRHAd566Mkm?=
 =?us-ascii?Q?FwwycxcvX/jRf6bEfLKFsgVOwL/PZCLEXl4v6IE31gcMkve5pAVU+k8wflz7?=
 =?us-ascii?Q?1+3qEHdA+L+tnfFolWlVdqvZiZwwRysgif2DsSz7op1bNHnGju/boXPgnnK3?=
 =?us-ascii?Q?IzaD8KbB/sBklfuaDR/o6+ctfIkA7OrR2rqtbobhxZI8wDefVSutT92KZnlT?=
 =?us-ascii?Q?ZWnsXJpe3/v3ZuRwQ9cQBmur8vSHypUmz+5nez24ETTsMuQG6MX2YXBGE0Ze?=
 =?us-ascii?Q?4faJoHHwAyw14aDQHLYRgbY/QJJR3s3rPi9kFEI4EZyzspNOG7qweeh4zvnW?=
 =?us-ascii?Q?edUKwrmqFmuJA9fwpfkhN31H9QoYTG1wn4ljephLoZ8sjFaBWdvXQfRRVy2a?=
 =?us-ascii?Q?Vhrny67k8qtxxQkT3VLG3Zyl6nXbzaMBonBUFYLhS89kq0LdpBvvTWukplYr?=
 =?us-ascii?Q?wfEhUStLZH275EkTj/JgzFISAD8CLGcRg+SK+tTuFqxXMh6uLp81VfQISbkv?=
 =?us-ascii?Q?kdqHLLAuSWE2I6+2mFOCLCEf/n0nFx+ZJUMm/pzAIpKMD7LoIDWGvVYfWsmm?=
 =?us-ascii?Q?Ux5T5q6JheuuwoB6jkd9jsHYwtSDKIaYu27np2Ns27iejyN2p9I91ERmTU23?=
 =?us-ascii?Q?VOrk7xZdSeekrFAqT7SUmbSf/6GuBzBw3Gc/8W/LYMxwyZCer61f9f1uhNNy?=
 =?us-ascii?Q?3zWb7BO4i8FTJI4MVK9GUaIITJx0Mq50KfFGFqeoRwgzas8TMF5jEn0FBBve?=
 =?us-ascii?Q?aNKLxd623OlC4ZPLgLTocUXoseCzxt53okwSld7eZ4w0BSP2QOBIDRWmwNhC?=
 =?us-ascii?Q?FmDNkXEOIj+d9VP9K4GQQQAdQ6sZBcPZyPQTg3/Q/TyrdmyKBI2JJc5DYs/9?=
 =?us-ascii?Q?ofyhN7/uAPLBGxlWM3hJXgoBVaRSbaFSEPpV1As1SsAZBbPOmV7Xzz9yO6mX?=
 =?us-ascii?Q?kOxITHdVzU9aPimXPU5+nsdR9NPak0I1AeAh9ePtq+k64IeQkSOFiVX/7KYL?=
 =?us-ascii?Q?COPXukHdfbFjZrGnCHjs1EMA6cz030s2s0WtnO5bK4mD5Op11XrP76yyXhgI?=
 =?us-ascii?Q?3IFAYD87DTvS8uvnfJhxnKsbZf4iALguSw/37RbFnvXYeEeWIe2wgrt96k94?=
 =?us-ascii?Q?y8+ea2gnF36CyH+mS6E5Y+FQ8kHE5qv3Lb2arQo0lGN7YC7xLw804jnnGyUv?=
 =?us-ascii?Q?zwkp7Gl33Mwd/wE9Bk869si9cEpiwraKN5SlANoTOMkHJhfO2mRNsuPytrwl?=
 =?us-ascii?Q?UDDVjLtDMrZ6RLAfuWjAJh2UBXmZo1bvhwY0HUOuGus5PQGEIQm7EDN0SZIp?=
 =?us-ascii?Q?GjdbvPSplC0DdhYjaqQB4YVQFD2ce1B5Eo8K4XlNwA5sHJ8UmizpauXu7wSc?=
 =?us-ascii?Q?/KFrxrbMV+1KMc4tUL1ornwW6EUw+JGIrOpK8kgTPt5fnN4JWQZ3qWPfp7G6?=
 =?us-ascii?Q?F2uTpS4aAMQ3t5a+8FF8O85JaQKz4U0qEGmLGhUc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f472dd-1178-430b-188b-08db05ea9954
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 13:28:55.7374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ssbc769OShu1MP73pEEoY+apUkdN7Y0c2HfgyCqXCCRDlifAZWb0WyQXzvfbacq/8BGECkgPXukaAIYlJ2XpvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4476
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230203_052859_911262_A9E42771 
X-CRM114-Status: GOOD (  13.39  )
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

From: Or Gerlitz <ogerlitz@nvidia.com>

The mlx5e driver uses ICO SQs for internal control operations which
are not visible to the network stack, such as UMR mapping for striding
RQ (MPWQ) and etc more cases.

The upcoming nvmeotcp offload uses ico sq for umr mapping as part of the
offload. As a pre-step for nvmeotcp ico sqs which have their own napi and
need to comply with budget, add the budget as parameter to the polling of
cqs related to ico sqs.

The polling already stops after a limit is reached, so just have the
caller to provide this limit as the budget.

No functional change here.

Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c   | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index c10c6ab2e7bc..92a71d1a7605 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -62,7 +62,7 @@ void mlx5e_trigger_irq(struct mlx5e_icosq *sq);
 void mlx5e_completion_event(struct mlx5_core_cq *mcq, struct mlx5_eqe *eqe);
 void mlx5e_cq_error_event(struct mlx5_core_cq *mcq, enum mlx5_event event);
 int mlx5e_napi_poll(struct napi_struct *napi, int budget);
-int mlx5e_poll_ico_cq(struct mlx5e_cq *cq);
+int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget);
 
 /* RX */
 void mlx5e_page_dma_unmap(struct mlx5e_rq *rq, struct page *page);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index a9473a51edc1..d3fc3724a39f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -913,7 +913,7 @@ static void mlx5e_handle_shampo_hd_umr(struct mlx5e_shampo_umr umr,
 	shampo->ci = (shampo->ci + umr.len) & (shampo->hd_per_wq - 1);
 }
 
-int mlx5e_poll_ico_cq(struct mlx5e_cq *cq)
+int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget)
 {
 	struct mlx5e_icosq *sq = container_of(cq, struct mlx5e_icosq, cq);
 	struct mlx5_cqe64 *cqe;
@@ -988,7 +988,7 @@ int mlx5e_poll_ico_cq(struct mlx5e_cq *cq)
 						 wi->wqe_type);
 			}
 		} while (!last_wqe);
-	} while ((++i < MLX5E_TX_CQ_POLL_BUDGET) && (cqe = mlx5_cqwq_get_cqe(&cq->wq)));
+	} while ((++i < budget) && (cqe = mlx5_cqwq_get_cqe(&cq->wq)));
 
 	sq->cc = sqcc;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
index 9a458a5d9853..9ddacb5e1bf4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
@@ -176,8 +176,8 @@ int mlx5e_napi_poll(struct napi_struct *napi, int budget)
 		busy |= work_done == budget;
 	}
 
-	mlx5e_poll_ico_cq(&c->icosq.cq);
-	if (mlx5e_poll_ico_cq(&c->async_icosq.cq))
+	mlx5e_poll_ico_cq(&c->icosq.cq, MLX5E_TX_CQ_POLL_BUDGET);
+	if (mlx5e_poll_ico_cq(&c->async_icosq.cq, MLX5E_TX_CQ_POLL_BUDGET))
 		/* Don't clear the flag if nothing was polled to prevent
 		 * queueing more WQEs and overflowing the async ICOSQ.
 		 */
-- 
2.31.1


