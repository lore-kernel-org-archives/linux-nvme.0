Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB76C6379F
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Jan 2023 15:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wmbxu9QzJMmmZBzKslA8lQz8oh0zDqhN+rGZ7BboM5s=; b=eAF//nMy6RgFDH8r37jUINwAWY
	9QiK2zJQLXvN2f9kPJKcfvgTpJfszZQK1gGRswxMHtslpyL/cSQndQF2KSbyCP1Zr7zrsBV3FbKt+
	/TUI6xOkIPCONV2+VpwN6CK4dJFEusma15rwKbZC62VElG/fIsG8quoou0cHSLMyfgeASxHukcir8
	9r64UGR12upX9bMTDTA2mZ9caaX5Kc43Jbu6im+YMXm10rV/OkDGaksvzeGzzfnadxs/pjRIoI8dX
	/o5rtkn2Cb5brHn1H9P2QcJd3ScK6yv8/lcIlatn5qBYkQpLIBG5oPGpEf4jdxP+5hha2RvWuHqm3
	alHoct+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHo5D-00EtPv-DQ; Tue, 17 Jan 2023 15:41:07 +0000
Received: from mail-bn7nam10on2089.outbound.protection.outlook.com ([40.107.92.89] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHo1m-00Es2e-EG
	for linux-nvme@lists.infradead.org; Tue, 17 Jan 2023 15:37:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VqztnjXHsaLavXqbxJ+vDf7dCHveQEkbk7r187W64yeMftnWZ/+yx+ndQND1He1Q1GT1avd+jvhwrUXoyxDhUMKCeGy8nvE2K9qxpHHW+9FDDC7LQLDudFkEaE6FKZxNfSyGXrlQpGVt1tVA68Fo+4afNNcik27+Z/OFVmQfD3tJiTXb5gh+ZDdILWy9Ac+OGbQEZwODc2aLt9mRHnNTlFDeEel0EG9EDy9ALTV1kIRaeYSHp6I0mA2aTNBQeIp8ZnLwdt/s1u3wQxdIQ2tLqtGyyr1j9cctBvyxeA6pvgImhqJxWORbKfgOUbk8NzaCyg2CJTTKITCAGhrMdfXhYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wmbxu9QzJMmmZBzKslA8lQz8oh0zDqhN+rGZ7BboM5s=;
 b=Uj0tiPFcl6wu+kF6fIkKQQyhQo5VdEbNRjkwPtBqyRYB5MTXkyRh19DeEs2+FDxhB4m9k1twRklgPbaE5ZargCnCFbLgMDFXfZqp6kMihroatvJIrd3F2pOVfvBg52Ygbd09X4fzaGpu5jHpFnTvMpMvNjB2fvO8AlrYdC0k1m46r4//cm5+pg5NGalg4ozmVeGoyd88EMVUlUHBZf1DN/FE9muLPlvRDfv7nf9LfhBZwS4gD2kPeC4smBVmFxcM5Ic6ZBiY4nY8FkAifBNXkb2ZCjro8EQP5D9Kvbt4RmKhXq5oh+iEsAijlRKsqwFCSxxA+6uF8+MuV4sa5pL4/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wmbxu9QzJMmmZBzKslA8lQz8oh0zDqhN+rGZ7BboM5s=;
 b=Ndswb+FnZuFkq9QjZdndfKb51HYQqFEPfX4KBj4qXnP0f+VdIBG74+4z+5vbXeYFQ19syg5uil9smg13+ZWHLb8ZaUe4F9Ukwai41RCnt9dZuIPlVFv82CEYC/Gvu0ZpoiqhUSbVZYDBOQqXO+PKaPWleYkrA0AB+rU0fau7IEp1ZuO/sCI+ciSio0CAOc5LxBicc/THmtBaMyz8GLJjK7LQzoJT8XTmkwFul5oImai7UyfDHo3S5scjh0Hd2fzHd5wgWPK9+ckZ4ro56S6ypO9wP72s3S88PcMa7KgSu8BSD/zAXJm/wsD/Cvsbt2rFL9Hk1uVpbtQu63YCNzudWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by BL0PR12MB4914.namprd12.prod.outlook.com (2603:10b6:208:1c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Tue, 17 Jan
 2023 15:37:30 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::6d66:a4bb:4018:3c70]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::6d66:a4bb:4018:3c70%8]) with mapi id 15.20.6002.013; Tue, 17 Jan 2023
 15:37:30 +0000
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
Cc: Or Gerlitz <ogerlitz@nvidia.com>,
	Aurelien Aptel <aaptel@nvidia.com>,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	yorayz@nvidia.com,
	borisp@nvidia.com
Subject: [PATCH v9 14/25] net/mlx5e: Refactor ico sq polling to get budget
Date: Tue, 17 Jan 2023 17:35:24 +0200
Message-Id: <20230117153535.1945554-15-aaptel@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230117153535.1945554-1-aaptel@nvidia.com>
References: <20230117153535.1945554-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0491.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::16) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|BL0PR12MB4914:EE_
X-MS-Office365-Filtering-Correlation-Id: 6df8aaec-eb07-4b01-0d23-08daf8a0be3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	nYOGaXR0oHx0EpsbNseYbIuNpHz+ShutVAPx5N8TOTFVpFtoUC1m4yTNze+M2wPjgFc5fZJUPE0z/ScPB6izDRxB4mAbqcFsdmgywKqir3n/lkITN3qgIBLY46HncYIJimdREruOsaZXHySnFXjasq/CaZEtF/iiKhmjc6v5X0DscuKs8Y0JkX0Z/JctwX+jpx7msL5gWAkh6PIoOH7f5k9JcXCwFcWCLdz7RUOPDGGrINx+nMBFa/UDSmpbEQFONKo83LwYDaRhYzOCyOGWf0+EhDcpGOeH9EglSOKTSmrMrMzfUGzGUJLrrs5TSRTYwWWnifgaXPodnQDn3jqMLCY4Cu4ZVjhf54tIaGqlWLktLNkKF9YAoeGY257/Ei2rPqEou9YVsormPkwVAUO007dPAOfwfkRrX0XD29rwuqllJBFTZUJGX2yTCMjsrslTi4+eNwmHtdxBPG7DM2G4zpvZ/MRsoVlv3m1Ob/cmort9aEpLR/qvyoSDalmKjBjBDDY6RreSiGxxX4d6ZBJDpYZUGiZEvT6nOPgoSEq8eyeMxOjmteQKT52Zriuir010SPgxKeobMQJeW4n0tKpuKoCyr5B041HDDisO6AUpXm+Vdh0bNZwQ9YNKb0Qe2k58ydUqDeLSFPJryVE2BTJx8w==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199015)(83380400001)(54906003)(6512007)(6486002)(36756003)(478600001)(186003)(38100700002)(2616005)(86362001)(1076003)(41300700001)(2906002)(107886003)(26005)(6506007)(6666004)(66556008)(8936002)(8676002)(66476007)(4326008)(66946007)(7416002)(316002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?SdBJ9zP/5iriZXqWo3uB9Ojk3XU2GgAZlMh90iN1nJMfn0EGXcybJ/D3O6Xk?=
 =?us-ascii?Q?gv/6WEwIZ/pr9oZzlf9dB5PPokn1tziwekcth/X5jueaU9v9yj78D/2FJ5LS?=
 =?us-ascii?Q?ySnvkgw/VFy9OnNEnZqALLwHLp8Jccx8uAY6AzBSzAVu/KiHHstAHtaSgxPL?=
 =?us-ascii?Q?U02OAsbhGJhz2fJQduyvcCC+dhJ9CnYkoyJHFDyuwAriqLWK0rhfb3ZFJKm+?=
 =?us-ascii?Q?myKbZ0Y/J4VTE2OmeqaOFkV36iqqHjMx3L2l4vYY1PgpYB4YLud+x3nzUwg9?=
 =?us-ascii?Q?zTjOuH7cXYw5eZ66IHxDFazVzyJpjQIzz7O2qNA5/DHJKxy1QRdKRLU28MaB?=
 =?us-ascii?Q?2Lg+GI1UHfF1fAhKVUySxtuuJrdrSXzEnWFasZM+E4WwhyPPcW2mQf96WoEp?=
 =?us-ascii?Q?Rfep+2jNAPwSRH4hADI/MzMrkIXWpZeO9TI4rOR4OQlvpVLsJnXKwhyi3/yQ?=
 =?us-ascii?Q?MUCQMKygKFQUlQxnhG/u99sW9T+uGFJPpFuqWf3bY+MN423gHyDW9noV2ZOy?=
 =?us-ascii?Q?9nbDwUGvfcmsgT40r/gkwiuOAs2L4PQS5nJcbaLGIAjN+5hWKyst3ntRjcjK?=
 =?us-ascii?Q?JYbeoDcdFhxezJjwwS58ntS7kRYE+y392wWld49RAaRiKxpodtVWBuKOSbzP?=
 =?us-ascii?Q?sPujIhv1XDYUUUjU0Iwl6garqzggaFkKCWB4i02/bg5WFOtpSIf8YKlXzOq+?=
 =?us-ascii?Q?x9gjoibRdbMAOqGodWLlBrNQaAhO3yoxFPcOfpNAXPuqtvORfCJmOE98XI0D?=
 =?us-ascii?Q?Fo22nRmDEGi0djgsfBjONxX5IAkT1eruw3RouE1vsxqhwZ07BhIln833thXK?=
 =?us-ascii?Q?Pght8nk1K8R7bAxosKtnOMdszHPhnWzHOZGC4XpJk6Q03OGP1f2jO/XF9spM?=
 =?us-ascii?Q?HpDm7HYzHPDcuIkqj7JSAArlJ3MAFcSmPxEKfrULDDKnV+rriSlNxsiGnaPq?=
 =?us-ascii?Q?xrRgYJk6EuMeOC0kWeCTOms117FwUQSK9dZgOPWAgxHGzm0Cc2Lk420IEVyg?=
 =?us-ascii?Q?2UPb9z7IIzyP/+YPi8hDdb/W8L+sRiaEMroGZn1PXSrxj/T8o7urbEC6aGxw?=
 =?us-ascii?Q?qgWSGgNHpnf4UzggSnPGTtReLc4PjPZcVzbkQSEAI6eS/yR2TfKkHuXrNhZs?=
 =?us-ascii?Q?SVtvfn88uR+5f83TfTSvfGWuEQ8LZ8ejq92nxOKZRTkLAPUxC3P/hPw5FPl3?=
 =?us-ascii?Q?q2nMBkeXSJsRg09LYur3fbqjgiePaXrnlFqXPkVE3wfyN38AgVn72cbN4oPJ?=
 =?us-ascii?Q?RofJ7K7Ze0h8nPSfET0qAdW+Ngm++HaUnEBIpqK6brLBakjPsuIQ8EsBAbzL?=
 =?us-ascii?Q?w5DGhY/08PgEANS/fLPndalGzPjnta2qSb7wYWkXIuvzp+botiubF50eIul8?=
 =?us-ascii?Q?19so1T4cUloEkH3+brnrKKbGa4Ala9AX7AsfqfZtu207YpZFIAy2Tf8VWisb?=
 =?us-ascii?Q?wGVuB4BDdJtDJ1C+B4fP8pCuAzxqk4JFj4JG/z9QDsZ/H9HXia19hi2W6v2V?=
 =?us-ascii?Q?6+QSZ8BCfoAj7uyW0BHZZaSvaM6CCB3Ky7DyBqKGgd6+qGkgxnFjzfOR7752?=
 =?us-ascii?Q?9Qt7uYA+mpcn1avUIqi4F2NdjlssvcZ6LrmR6jVq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df8aaec-eb07-4b01-0d23-08daf8a0be3d
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 15:37:29.8036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vT+BZcY+Qdos0UFw4ICTAV99pCfJwFFx6jfD4VOwFN+BiinkwvmYpVbDL//ckaiglyBj1e4sIGZzQ2huG84UQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4914
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230117_073734_532036_02EDCD59 
X-CRM114-Status: GOOD (  13.57  )
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
index 853f312cd757..a7799cee9918 100644
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
index 3df455f6b168..51167f000383 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -916,7 +916,7 @@ static void mlx5e_handle_shampo_hd_umr(struct mlx5e_shampo_umr umr,
 	shampo->ci = (shampo->ci + umr.len) & (shampo->hd_per_wq - 1);
 }
 
-int mlx5e_poll_ico_cq(struct mlx5e_cq *cq)
+int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget)
 {
 	struct mlx5e_icosq *sq = container_of(cq, struct mlx5e_icosq, cq);
 	struct mlx5_cqe64 *cqe;
@@ -991,7 +991,7 @@ int mlx5e_poll_ico_cq(struct mlx5e_cq *cq)
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


