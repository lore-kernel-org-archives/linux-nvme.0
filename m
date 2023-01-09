Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F26C54EBE
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Jan 2023 13:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W0PXvlx7XDWdFv2p/lC26w2sChP9Q33lvxW84tc6t4Y=; b=I5wl02zyWvPZUnkTvHCLzZPD1O
	Djo7L0jhuHHFDg1/vmKvaIURKi4Fo6pRgCQ6Tk8gS18KTygL4u8zRBLAtEnbZt1nEPuxyD2WfBHvO
	d3xGuXc9zwPEfXRuY6Fj0uXsvnF5PUPzA8sdvG9cjYzOB6gzEt1P/44SLhWiAvAtx9NH+7Y7mq8NA
	50yZdww+OUatNJ0O8vY4ss1cUmIhkGARJpXUOfwnrU3WRNLRXV+aEveWjJVd98Bnq6GJ8/rXGcIar
	MIxOOgRLE/kBtkx7lc6dbePtJXH2peE2FP5mGmSyh0VjEcWUdRmqIajBaoa0I7gHCN76CTr2gMfQL
	kenIpnqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEsLs-001edC-Vd; Mon, 09 Jan 2023 13:38:13 +0000
Received: from mail-dm6nam10on2069.outbound.protection.outlook.com ([40.107.93.69] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEsGp-001cJv-Mj
	for linux-nvme@lists.infradead.org; Mon, 09 Jan 2023 13:33:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/LJaGRRQEeI9skvXOSKD7HeiCtJuZXuWFSiStAFnEWpOTHG0kRYN713gTPJXOzvQUGUdmpbh+Em1WzwBmIwr03TWv7ZVXBtm+EZIx7jRxtb5yqZ09ccHZRIKIhcjbFRQVEt5yzgWOH3tYcYSbSp/o8YAyHY419ON68j+9/jiiCFmz71RxPIZUfLUNC/wuobgws10fZ0bgL00lqqQZAT4KAzS2+GiHP3NxorzDUC+SxAvKaWlmclT5DmK2mLbIgEYCXi76vnsjN2a1hq8GEk/oIb2ySyMlTH0yE7KbCMNrQY6AQUQ2CzPAZ/XwvZYBfQs5XK6sqhuArdUMKQgzOgpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0PXvlx7XDWdFv2p/lC26w2sChP9Q33lvxW84tc6t4Y=;
 b=hfgbN/A+X+Fco+GiDRnWHlAKRjO7KWxY/0aIde0Ez++FXqQG8MoblXcBMjc9fAk71l+taeLnTlJIImomR3RHKEX8awEM3hf2Um8tVA7PPUbbE22qrx3TScvynqLeIUn2/pUxv8oAmmsaNwTv+CBPdnP14jP4yD+1dzz/2h3Degj/RDDFHxkGF9b9rAPcNxxTTMlYbcJVczyGOjbnK7kDdr38oLPFgjwltACNjI4rzRMCkhvk41BsDNvP5UqwGnym+ZMt+ANdMvUFIJjo9OnG9gm6mvIUeQuwBEFN8LlQZqYO/fWTYZgRU7nBddwhJWA7FsF9gJJw/GA9Lz+0gRAIGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0PXvlx7XDWdFv2p/lC26w2sChP9Q33lvxW84tc6t4Y=;
 b=eLj3Okdwenah0/92kc0RewnvRk0wRdGNCPliQHaJ4vmdAXKn0mEuhYbwJF6h2/9oNXDyUCx/enMTpUuXdlJO/wKiKsjprmq6TwuNH2GXrdNPLP/dVwkftzIssI2o7kKGMls3Dnfish520d1QkzCmothqRDJWAOdKv9/y8nlkrwWeVFpQjXORDEtkWOHtNKAM+hQ9R2U98em/6YARI9GuOCG+9jElk5qo0WHHqa9qsFAN5ha+MnlcXcp/fgQYc41W65jCSU3mcQLUH+q+4Rk2b7tnwn6DtB+IDEnoj1mH3+txEoauO3cHga3xpuIoK2BvK7ffJHtvzqqCw0vnXqSkow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DM4PR12MB5056.namprd12.prod.outlook.com (2603:10b6:5:38b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 13:32:55 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::6d66:a4bb:4018:3c70]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::6d66:a4bb:4018:3c70%6]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 13:32:54 +0000
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
Subject: [PATCH v8 14/25] net/mlx5e: Refactor ico sq polling to get budget
Date: Mon,  9 Jan 2023 15:31:05 +0200
Message-Id: <20230109133116.20801-15-aaptel@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230109133116.20801-1-aaptel@nvidia.com>
References: <20230109133116.20801-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::6) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DM4PR12MB5056:EE_
X-MS-Office365-Filtering-Correlation-Id: afec3707-8060-42fe-ff4d-08daf246039d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	RWcJ0fI+iGIdaC+/TK4PhTtezQn20GDcd0IdQ+R60oV7S3IK8o9deJaksHth4oBi6O5EYYs9awiIUn4P9kD+gC6xF9EFbfG/92LkjLqFQXyMK141a8OlhKinWYYRnZsaaLJo/GKDaHlN5MwlzSd4vRY/vVZXIm4laAR+pS/tL9ZisByTPyqv+ZRO0ypKHWl/sFsEF9RlTm5iE+i1Frw4qN00aPhO4bNfWzr28+xKOuw4wocKCG+pOMsUM6D59bVtQrDPSUszOT8HAycJgp7popNAlDOZT0d2euyocoT/+uqfoaL8XDwVAD7bSVTuDfwRmtAiqjkhLpFkyTxfv1nINHqptt96NsaRT07XtzwXDF0sBnx+W9GHOfqd24R2hXvkuuGbQQwRTgxgF4iS447IT/TepKx2W7tZsWV/cq88Q/OUpuLmg2xGalZIE3uGg2glNgwXtadzPgIogaBBmlBkIUwJPMBMmPHnJHS6KbLrnsFdfR1ORftaVcafgjzWuoch41GBO8C4Vku5G7UBFiu3EHM75UuUxtmdNJ3wQ/cPkiEt1PDFLBBNFhXGM4QG6koh1Z0jQZ9p9QvJW4vk6fKYVWpkfL5RIDJqBUuR8ouOf8QSe7FAeVrJY21lbX15MxXgX4H/3Sh2/0F7GooTju+f3w==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199015)(2906002)(83380400001)(54906003)(1076003)(2616005)(66476007)(7416002)(66556008)(5660300002)(66946007)(6666004)(107886003)(26005)(186003)(36756003)(8936002)(6506007)(6512007)(478600001)(38100700002)(8676002)(41300700001)(6486002)(86362001)(4326008)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?QRzMg4fgtQMB8e4S5lKfcVRH2R4kYWhMg2yc/E9ppJ+wFYwYWekOABZfna0w?=
 =?us-ascii?Q?sQohOqrmJsAGxHr9331BGgemAXhmZf20ZnuNn0f9Oh5mUsw8iOfEPRcFCtG9?=
 =?us-ascii?Q?whG3PEITfZBkpt30VL9Ib3e+1bus+iJtGGdONDjnzmhwIMVJ0GAACaHpaKVk?=
 =?us-ascii?Q?da4iZIx8x8Qu1mb764/hs1cGpvWUJ1kuy2FGHuMmQA/h/Fk7/D1EYAf6LSDy?=
 =?us-ascii?Q?O1Xcj5usuDRYFsjZ0s1KQhp12tO1d2jZHKBL1+oAIH1XbJlKDRwE4VsjcQ5y?=
 =?us-ascii?Q?+lW0A5B0+oszN3xPF//wv0+xe6bl1SUvH9OCJFkS3mfLhUQ72BpyWwSst9Ue?=
 =?us-ascii?Q?02MGbV9ceD8f6v3H08QqTzuPHvx9ViZfMifNLLLbcT9SbXCew6lXltBd1K9L?=
 =?us-ascii?Q?Xp8qyIVox/6zbStxJD/5lZsv71am4jX181j+NaJntOM5rVbOaOf6A5EJhaJ+?=
 =?us-ascii?Q?MX435iWqSr/p/hMgEmx9cyjRx1dSHa0prjiWlJpva8LSvbsP/7Hpl9kig57U?=
 =?us-ascii?Q?4sqRjppCc5kLM5vHqxCbfbjQ1o63f0MM+Qm3JVXISK35I/3AAGKBGqRskwxi?=
 =?us-ascii?Q?XdEY5huA8GTfvB+mzlAwCsUN+mvp+uaYJFBq9bY1pS3EahUPaNEJPcpvff44?=
 =?us-ascii?Q?YkP56Ix7NszDekC8bpM52xd4qCZ64HT964STvwpK/v4lOSlH8I5i2QTbvwhk?=
 =?us-ascii?Q?qPwK3D7s5y5I4r96cT37rAH0rS3MdlNbevm0AnVEWNLkPhKnwvTSlZYfuxEK?=
 =?us-ascii?Q?A6IvoZPrYt/ep9r8SSiKcNgP/IIqPLSVaL+JQNaBLPHL2027noOIPQnhyR7b?=
 =?us-ascii?Q?mKHHxc1TvjEqAdBjfL6hzqtT4XgzXXM93t6IeSlVWDeq1BiiLn0X6pLinIaO?=
 =?us-ascii?Q?M/P0ibrghtP+5qBSOsDsWDYRFWly6UiWxXtMboFCiTSPDzPo7lHLEy1qUfN3?=
 =?us-ascii?Q?mAx9Due1f8F9rzux+8MgjdvyEa5QA14h5sFyG1/ChnClBstI331aHli982YY?=
 =?us-ascii?Q?jGltz6lTwV0R0z+RhPym5btY8diGwoXkUZ20wi0NFb9f7Ad4P7fqpDizzgeg?=
 =?us-ascii?Q?GBx6ihWNop/QS1Qj+29Nokc1XpChMBDv8S63ccZTKkAnVRve75V6BSzEqs9X?=
 =?us-ascii?Q?eSNxTY8X3hVRHqEJumxvmv1ONpbzE6+QwdUa3U0ziO/w9hDXGCvC8v62q6Dd?=
 =?us-ascii?Q?D8PPBeoXWnSdX8/WNpfK/8LzzZ6SXU6BytQkXjEKyZgYqmCFCdt7dMItQQs0?=
 =?us-ascii?Q?eaU/KRI8e/eDhQT/SvZFUiPfoGdnFg9IP0YWNoRC7JTzlvEIVz0sKeXfQOmF?=
 =?us-ascii?Q?9HZ40xtr9Vp6KFAEPqXwAEAaSITzw/Eh8pK5VD4EyuYjkKCueEVClzGTz1ZQ?=
 =?us-ascii?Q?RMOPyiapfTJQ34EKy8hgb2nc3LGkEgX3jD9lyJb+DCHEQi8oOq0Zct5Ya8qs?=
 =?us-ascii?Q?00EKZMJCVUgrWFbQ6NcCfPKL4YH6wJf2no8vJ8KX3S4oJFYI+kTkLYdyd5bD?=
 =?us-ascii?Q?9B1+3I5o16yZzak8zylTrHhQISIf1XGNva1Xb/y+OK1byRZ8Kqt5Y79ZiKI6?=
 =?us-ascii?Q?/zhx/5VBvEoRC3urV1/x+9FbieWy67Gc0Ap4nQ1P?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afec3707-8060-42fe-ff4d-08daf246039d
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 13:32:54.9290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JiIDUG8EcK8o6Ytqh59CkslFrQ2Bqx1mMz8DLTWu0DlwOm8ozNFMJbHa9ygftlZpMEeaD2IrwfV65wGJDqrzcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5056
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230109_053259_990185_9AD3A53B 
X-CRM114-Status: GOOD (  13.65  )
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
index c8820ab22169..7bf69e35af18 100644
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


