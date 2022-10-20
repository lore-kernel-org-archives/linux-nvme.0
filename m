Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD4CAC4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Oct 2022 10:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PfcX2zgT1CSyH1NWo+o80pvZyWKbGNaMs6fnkBT1rBA=; b=o/+HRH7Kmt+UGekAXeQEd5/djR
	1I/2yadmq7UFRAjOn+U5WTOvoYY0T9N2t/qIAqAMje28Tobz6bOtntvpwDFgV97FNxqQOq/lGtNuK
	pOwJtfJK+ZNW0HCAsGu58yOIDxIIyWMvGaTFGamdrBYgwa4Qw7ACnXnDCicvTrg24Tdxzs2qz+fob
	Fyr98WvZqtfwSwNuJM8+YCiX09SUOUyWxP/PTUPpTjA2xVzRR/JKKSpEx8p+ukfM4aULmH9uhWTzk
	B0OKJvvN5D7BTgZeTMH5ygeCq1saYZXA9RdIgOpE9Vp5VSNjWV9SnNuIgWOCDEHiszzBzfbA3c2i2
	X6gKGcjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olTCY-00Dpkz-H4; Thu, 20 Oct 2022 10:55:02 +0000
Received: from mail-co1nam11on2055.outbound.protection.outlook.com ([40.107.220.55] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olSez-00DTX2-CL
	for linux-nvme@lists.infradead.org; Thu, 20 Oct 2022 10:20:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZH+FqJ0v9MM5+4lPDdZ2ZhabrD4KDikytDMDxZgAtGWYylXYydSvAum6w3/6Z2s7LK5XBTVMaTK1BYb7Vx5bQ83sPVkO/AB4Lu9d8SRfFOFpJ+2P7afd1Kx0O85aSicNqofOcbGVBJvk8X0GgzxTSLvJSgcXudpjgaGRock4/5gkNiF8OGVFBZXzVVJ3mw6XHYGVNQMqkuFTV6MtPF0Ln+AmFsSk6ojlG39dHdLW9YQ5xn322B6vqfqBOuvhtA/55DvOn89Let2R8HhIgs+eVcDVPrH5p0CxqpOJaqpeUPJj9QwTRVuE1qa9zSXDYy0ABc5zAqhyEvtGmBSMUxVU5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PfcX2zgT1CSyH1NWo+o80pvZyWKbGNaMs6fnkBT1rBA=;
 b=lIOO9oGtMd7VHTy8XgxvvIatXk78z+35R3jcRvu2g4zVCaki+Eh/IJ1SkK5kDPsRdxXK33iy2xbmqsz1Hf3gSPUn5rZMfPTLrNH51rZCzOTbYPKJ+FT9Odr+R1/g2TGjz9lzhSPuNtH07hCNcC6kSwzTbmbgo4zddE3Gh3nHQ3FyJMBciIFkI2f6c2iNhqrmhZSf11qbXR5hDSRUqH69Eb0R4t0f1pUFq3CSXlc8c/KpQjBtn1CxY6Ay/lc5sByvZO8xTmj76VzxPPDkMoCChfGBEzq8lmlCRJDoyLgf+VL+fsR7h5cU3Yui4eKt+5P7nAAIoOvA/ojyD9CSQXXOwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfcX2zgT1CSyH1NWo+o80pvZyWKbGNaMs6fnkBT1rBA=;
 b=VzjyjidkZlxLu1gXor4UPPjwdGbkd3IE4K1mf/lBKxv6fVVc8iRYirJTMBzKujcpAzDRxiogGPaTuZvoyxAwe9OcZO8+3d4RqNwHLvFjc/PXcR8/5uzACSZyitoT3mOAMDBW4ik4XTOGY4iT9+ubE6YEEHsyXTEDMPZQL8o7jyxPfuKwgZ4bxAzdg294lFuJO/ZLP49+cTZUjmxi9e9I4tchPrCqxITWU3kgWSxW7YEfZfMnxiMCe0+PziKv0rcvbX0wYqvqxoP/YOi7Rodva3aIjyeE1fTKCIB+xl0zQ/xZ7duY5s5zJ93BSFVAP7ypD/ZscTvbH7/wxbuvS5X+JQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DM4PR12MB5133.namprd12.prod.outlook.com (2603:10b6:5:390::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Thu, 20 Oct
 2022 10:20:10 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::b8be:60e9:7ad8:c088]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::b8be:60e9:7ad8:c088%3]) with mapi id 15.20.5723.033; Thu, 20 Oct 2022
 10:20:10 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com
Cc: smalin@nvidia.com,
	aaptel@nvidia.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	aurelien.aptel@gmail.com,
	malin1024@gmail.com
Subject: [PATCH v6 14/23] net/mlx5e: Refactor doorbell function to allow avoiding a completion
Date: Thu, 20 Oct 2022 13:18:29 +0300
Message-Id: <20221020101838.2712846-15-aaptel@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221020101838.2712846-1-aaptel@nvidia.com>
References: <20221020101838.2712846-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0549.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::18) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DM4PR12MB5133:EE_
X-MS-Office365-Filtering-Correlation-Id: 43ae19f4-3785-4d1a-cf74-08dab284ab62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	KJ3R7EiBurJHqTB373DaGG8G1mFRDZwnIvcM/4brUO8pEwmpe9BE5CmuH412rCOuhSkVJ0metgm/51/d2GLolcBBbut6QtvX8LfMOR60/AnmP5qZqMM5w7b4X/wSeUA3zto/XU9gElBuuwd+HnN8GclRkDAiWmv/h6W32KBmnFy2dd94bFoMCkCsU+vePR5G0dBa9JnJ11N76pDPMOphI4lF39LZqcU73ZTj5ubV2j/D2tHdF7Zne0kQp+bmJjdD37xPjocT9KAypJA/Xnli2KJIQXCrium1dkVa9bKlhH6wuViSkE9SikzZyb5vyH2c0yKdS37UBS1Tg1IGMerYpZwWhwERhlemwbiZsdSMf1S0n6ZyTyXLFvfB1+oV92N3cY6VjV22r88WSNzesUF9xTilEbaDjsnHmUPYqmn66tm9KGxbIaL+c8FP3H4NWWsksRNQK/TllLCvwCJcna5bYvRpII3R0Oqc4kGQrIMt+2iPmztwRISaqf0KTQRQTYw0sGoGq6tTJBXCbrV44p8+TlRYfFyctbz3bW3EdJJ1/5i2SPTqBmwZU2ieWjtrSkjQwltSm/u/Ley5b8mwrSl2+u5E0jlDeDD9YFN5PUDSkcwklM2UuE4RuP2Nn8MJovNPK53KDGQ2UIZbjUD8ysq1WyOBYBP9x939WD+eaJvwpY0CBK91r7xoBxtPpduwi4d1Tx7tiA5im0exRwt0zLAFKZT6xmri3VjZdF6ljN4wYoPcf9KJn5n9kraMkgyc14Ip
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199015)(6506007)(6512007)(26005)(4326008)(86362001)(2906002)(921005)(8936002)(7416002)(5660300002)(36756003)(41300700001)(66476007)(8676002)(66556008)(38100700002)(83380400001)(66946007)(316002)(6486002)(6636002)(186003)(2616005)(1076003)(6666004)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?YKn2K+CIQlSUKorz9hTazofZ08VjjGvWGl2yV0anLPOvIkzPhG75tpfml2uB?=
 =?us-ascii?Q?UjcKy04ukmTQNDn0DdHnmBAqZCggWyaQtJPy9qlYWNhCL/hO/vqFt/cwYYsA?=
 =?us-ascii?Q?pmtZ4Nfy2W3Jc+nbVHx4P4/wGDJ2+vMj6NakWRCyfva+YDNn5oBo0liQKr1I?=
 =?us-ascii?Q?lnN6Q2fQ6tUQpjLTlD4EGvbO74ihp+T222FSraqpW88afyzDHPx4vkz67Zfk?=
 =?us-ascii?Q?sDGtxJRG1AiQSrdugBstlHW/f7hXBCKQ6TraQY3y54t1Xaw9j6XZcibnYFb3?=
 =?us-ascii?Q?RsfSzmCaCcXbiw86XKjF9rxR/Y98W4csx1NCKHkpK/39WYy9hoUXXBzT70eK?=
 =?us-ascii?Q?wvfgz/W/mYX8wkUrKUYxKGCd+oldFqnlJ4kuTLXR2MFwJObaf0+PmUhmt8r1?=
 =?us-ascii?Q?Pi/ZVRotgiF+Xa5djNE9XNiIRBPA0vVik0zxtwhf5fYfux+XLlWovfULSm0J?=
 =?us-ascii?Q?Y96+Aiz0z/SlCjAqHpX1chYqdWMgaguUMrsCZuWYWMDUGj/dXFJ3OUTbAp4H?=
 =?us-ascii?Q?NIqLAYM8/hcAq/vifPPfVmcDfGaH2tH/UWay02uwUOx+Is0UC52b0QdmBbEi?=
 =?us-ascii?Q?PRQI6nsjizEyQ9RKuN11hSrqP8RtXvkl744NXBfK3lyV+2crsCM4il9MTNJZ?=
 =?us-ascii?Q?y8ONISnAIfEu/SJUYavDt2/ym/wQ1sO+NIeDQqwMayL/b2jryup1ly6/vkmN?=
 =?us-ascii?Q?hF5XpXQiV25fQV4LO/+7LTb6/Yg/FO+jdzODIeZHPy2kmgb0STHaKDsqbemE?=
 =?us-ascii?Q?uw7O8F83yXpXjPHZn+EkdrHj0rBRk3JgOr4jTzU73FbxUS4P/AWBSxVF9uPi?=
 =?us-ascii?Q?XAZPaGfq4hQl3LmAkR9ir4JAyjwro6o+4NjKt83vvdHrOgQKpfUDoQnOYwFq?=
 =?us-ascii?Q?IZEzhneFE7hgXVfMo82Avwo3A2JshOLORodj4FgN0ioaCvvzWfDk84ZPaz2x?=
 =?us-ascii?Q?QBQpyl0499fv/nJpgPo6RA92S2WNEPUK54YlP3HubAxQMCvZ5t1vUSojGuYz?=
 =?us-ascii?Q?/rmqqJA2d72Ml5taZySIOSZAy7D5IeaXXxcKDGSxDh5FpcltXHE69DnOf1QU?=
 =?us-ascii?Q?iqNHVTt/c8pnNf/YdmAriR7EybRB1MsETfQxe042wvba9OzxsUPMsJCwq5oX?=
 =?us-ascii?Q?aanOUmJxRDdFN23v1zfrKeDds4sqzbJMjXh7XZep/bFWkXl24JbreNvY90/k?=
 =?us-ascii?Q?qcxJuP5rwshc0XPRcX0vkrvthwDs+1xia0Knf3tfTQpKURuFljsn1giQoDC0?=
 =?us-ascii?Q?r7EG6epeIP8f6P5P+AqtABz67qgnWKjeTt3HKxPoV2K6Nm3QAkfs0bWMvlzt?=
 =?us-ascii?Q?tIKKHvyDeGxPoV+kfmaVIjDN+9RoluWpK2zOuF6ItL17V+i1Ekodf6tPZXmh?=
 =?us-ascii?Q?ZO74QtAqTQVB7FyLIm1aszfWzSoDNroO7RwQj27PI7s9bA7XsWIAZbo3d6JN?=
 =?us-ascii?Q?wZAEvV0ikMe/JZmi9+TO+3zyaEjsnevjZF0bYqfIMFu8EpE6/yLEpkX/5TOS?=
 =?us-ascii?Q?1ypGnuYxGUsE3CD5vFaJl/C3vEjBjX6qcbgvzxeOeUCoKqt3GU6o6rPaTRpE?=
 =?us-ascii?Q?ckcpXFnmHlQXcBI2DQ5Ry/BW5C4juYQXqiaha2gj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ae19f4-3785-4d1a-cf74-08dab284ab62
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 10:20:10.7778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HQ8Vdd1+VMCNSmWLPEsOEGUmXqtvXO5qVMxTymkfWpjMpyQC34FzBi38mlbwnQHkVh3KAMYt1gRn0CygScu4fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5133
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_032021_466952_3155C5D6 
X-CRM114-Status: GOOD (  10.11  )
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

Currently the doorbell function always asks for completion to be generated.

Refactor things such that all existing call sites are untouched and no
branching is added. This is done using inner function which can be invoked
directly in cases completion is not desired (as done in downstream patch).

No functional change here.

Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index 30c456bfc1c8..101b7630b046 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -211,10 +211,10 @@ static inline u16 mlx5e_icosq_get_next_pi(struct mlx5e_icosq *sq, u16 size)
 }
 
 static inline void
-mlx5e_notify_hw(struct mlx5_wq_cyc *wq, u16 pc, void __iomem *uar_map,
-		struct mlx5_wqe_ctrl_seg *ctrl)
+__mlx5e_notify_hw(struct mlx5_wq_cyc *wq, u16 pc, void __iomem *uar_map,
+		  struct mlx5_wqe_ctrl_seg *ctrl, u8 cq_update)
 {
-	ctrl->fm_ce_se |= MLX5_WQE_CTRL_CQ_UPDATE;
+	ctrl->fm_ce_se |= cq_update;
 	/* ensure wqe is visible to device before updating doorbell record */
 	dma_wmb();
 
@@ -228,6 +228,13 @@ mlx5e_notify_hw(struct mlx5_wq_cyc *wq, u16 pc, void __iomem *uar_map,
 	mlx5_write64((__be32 *)ctrl, uar_map);
 }
 
+static inline void
+mlx5e_notify_hw(struct mlx5_wq_cyc *wq, u16 pc, void __iomem *uar_map,
+		struct mlx5_wqe_ctrl_seg *ctrl)
+{
+	__mlx5e_notify_hw(wq, pc, uar_map, ctrl, MLX5_WQE_CTRL_CQ_UPDATE);
+}
+
 static inline void mlx5e_cq_arm(struct mlx5e_cq *cq)
 {
 	struct mlx5_core_cq *mcq;
-- 
2.31.1


