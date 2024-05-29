Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0086C25B7C
	for <linux-nvme@archiver.kernel.org>; Wed, 29 May 2024 16:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gd7nQKUUtIw7iklO6cuQnQF5rbTmRc72tk68WjZE1JU=; b=PWkPyXPpArKLyVb1Ll2F4Lqk66
	7Y/b8mdMpVlRbS7m2kuUr0ZPiyMZtDxGqZx9GfACC7uA50TFXhu5vB7flDx7k919NAO39nEp7Dk3M
	+AVd9/LyzkKDAouxjTqDUaaI8ogb/A1y1JEGKfLN+ddBnCbBcZOwoNyemmWJGBedA4MfnFaAhe38G
	m/r26gPYTwqreZIiI+oDNxUMz3BI9I6tmtlNIT22uqT5PEUGY43tnApUktuu0QkIpWpwrY0U5xKGw
	eKGqBY54d+lLWYey3kiKBnldsjefOKO5Ozj/Aic2FJr09Nw+bWwGefDzE79KB3/jzWGjVuIXzQ+PF
	HPofbneg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCLzP-00000004ruM-1uYu;
	Wed, 29 May 2024 16:17:23 +0000
Received: from mail-mw2nam10on20610.outbound.protection.outlook.com ([2a01:111:f403:2412::610] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCLzM-00000004rtM-2yQA
	for linux-nvme@lists.infradead.org;
	Wed, 29 May 2024 16:17:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHKiV1QSKqUyy0HfHZ0yFvmZZYq0DqXXQfKISzG7cwrv3yUNjADTbMD3sbcGaMiNdFpCDaPnrHi18TQdNoaEdYGgixtipMVD/CpJq9pgESZDldG05qSHmzsLGRT9VhwbsqWOf1lmIIG0mVIyC65UHIKtwcsebRS/D47kR3SjJylx2jI8G5Zb8DS/fraNMg1oql6+MIHfp/Y79fcoYUR6bEmsPS2Jb86p4XlE5/nPvw95ZQcRKsntyfHuikh6qo8XJHrPnti0yzHTjnWyL2RDceEujhaHftbRjh5uNvsNn3EOP7/6/kW8eS1gubU0ETCoaDZFePkJV2nRzPT3MC2wqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gd7nQKUUtIw7iklO6cuQnQF5rbTmRc72tk68WjZE1JU=;
 b=kXBqDIdgPmpQ0MO2deG3PSCLUlAz3E75E7zVIEp7KTjjLPznhHSUdM6simzjxDxQ8PuBs48NSZF6ERIFyGG/KiF3YVyBQQ6xebeigVsEaNFTBd8K5BA3VVQ4bOerMjDPSOZmK5uw15ai9a5k2dH/AWAYZbif/VG5l0AqemO0fOzdCJvY6xNrlwxSbd5hWGYhjWwW7v0ZdBCzbV135g4OC/Y4U4Cow1Z2FTFGodYvRXf+/zoYRJtc0z4jtewdBM+peV6qgjVHUeElOG/SNHZxUWd+bDwNrVK9SEAivdZXHepzWLOfmQFy5yqX4j0cktbOyblrmyIm5csAnnOWYdGynw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gd7nQKUUtIw7iklO6cuQnQF5rbTmRc72tk68WjZE1JU=;
 b=RYKZoCnQFvXxcIJBy7t0EeYckNHBiHrr2mj/yw9adVkO9JEoGweLKk5/zZBgBJbo8Nyw+oyuzdqXKhsv8JnlbkHimZwRe2doFPkAg8YAH9BKR5Lh9z55nFJZ0GVxTYY9qpyinFR+4sWQVLKpMFDtgHYbBqb63ETVzKbcffqfhcQApIyClkkXjzxQB9aNMpowJCBdadFmQb3dUx70k7mcsDCJ15mKyae95Y7A0FR2MoXtK2JIwQHfmyGDa6UesMRSo7VNuNCCNuixdCwGhACsYj/V96VRVnXydH/TZzRHP+wdzxYSA8Rl3kNR5MEmk16kvbzbC9nZZpbfgOUjR0xMvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SJ2PR12MB7799.namprd12.prod.outlook.com (2603:10b6:a03:4d3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Wed, 29 May
 2024 16:02:03 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee%6]) with mapi id 15.20.7633.018; Wed, 29 May 2024
 16:02:03 +0000
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
Subject: [PATCH v25 11/20] net/mlx5e: Refactor ico sq polling to get budget
Date: Wed, 29 May 2024 16:00:44 +0000
Message-Id: <20240529160053.111531-12-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529160053.111531-1-aaptel@nvidia.com>
References: <20240529160053.111531-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0014.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::26) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|SJ2PR12MB7799:EE_
X-MS-Office365-Filtering-Correlation-Id: ee8f644b-a108-4a05-a4c2-08dc7ff8abd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ogClQ+u1eEWnqXXh/ijzWXJaQawHOB8OavEfSaceucDOtZcqOl8HtkDJ7RNv?=
 =?us-ascii?Q?HQLJT4609UKBdhklQh6oitsneJ9no9vYItN5nXOjEcpMo1HIWkk19Fr+Tubp?=
 =?us-ascii?Q?Dc/799NnVXCA6pr13sxmscO1DEiYoWxtlEQn1Whcht1mJpC8r4XZ+kEdx7bA?=
 =?us-ascii?Q?M5vlKfGglMt9KMeJdA0Qt1r18BCLKHkY9wdvYl3hhwnaQKiuOiRU6w7SdZsY?=
 =?us-ascii?Q?sSfZaVYYsFzEclYm8YVtkDP7/wTqZqBQwpf+90qx4r4k9R6yBVGCn/wt6CHB?=
 =?us-ascii?Q?OvM0ByNCgHKMgJQ6gmCwwr3qWDF84+khcLXhDvBAcDIjan/WqjlcT43xcBXD?=
 =?us-ascii?Q?57E6AkY9EeNRHBRJ3RyrJt3P7OIscx7I8h+SzdMPR8qi1zAIg3WvDg9I+MVt?=
 =?us-ascii?Q?nURRbqrI12iUFwvAdxo4PKJeSmA91EuIx370JER6YDJIQjgiIpj6jO3DQy5E?=
 =?us-ascii?Q?5ihSKiUpTmo2+WHF9YvipPNroNWOotzfaK6CLi0U1TQWfEq1QpS/+sRsZo0W?=
 =?us-ascii?Q?wHSTjd4st+t+Vr9aPK94iQhlf0lkuu7ghWp6nFzuzvXjSI+LCsmfAYn2+I8Z?=
 =?us-ascii?Q?f4JsZZQ4Lawmq+CqyDGdrNL9k38BiEf2dh+K9y4ETvUOBMfQ1+OZ4fs3gxuH?=
 =?us-ascii?Q?yzpI6lUG49A6ArksGMYc7XB4snLbO7RwiwlaUzy6ze/mf3v51EnncwkGM7qz?=
 =?us-ascii?Q?48nZGsV1eb7hZDbSSUmAllt4VodnB+OrXm7duUwWG/TwnfzAiXozWLLQCn39?=
 =?us-ascii?Q?P0w8uTM37VnD09ro5wwW4lYVkJgPkYlmRVbP/DL9xF/FO95/VExR6WtE9sTp?=
 =?us-ascii?Q?gwcxAN5rZacK44cmcOrX59GyL2a0YRQv1b6ANs2vlM2DPqBLcdvVLsi2spVq?=
 =?us-ascii?Q?jwf8jAbe4OdPnZvuhpa2FovvdZoYWC3nCqCNv3800pI3bAm/1Tckez2oge7J?=
 =?us-ascii?Q?RQKJ6PdNB1zu5Yz77zvkgDEJdKwT1r8bffEaGw07+/TmkLwqzU2gHrQfkSDK?=
 =?us-ascii?Q?pZj5q+tZRmcOL+6AuGVlcCs5z+CL6YhgaahLIQcaOOrPFK+GMuE7Z9I9fBwN?=
 =?us-ascii?Q?OnY+0RgMVZ0aul05nGhRWVzgf+SGi8hzJlQqSWz8JXnh87T3Lym25C+OEMaq?=
 =?us-ascii?Q?41MQUCcmj+WxODBcXRZiI3z37FCDNYcFcskuQcUppKD9WJq2/perOWLW4Bv0?=
 =?us-ascii?Q?nQCSosjtJPbdFD5UCHjgRrMyzFvsapkCZ30UvtpjNdRmyOb/nkLtVJt9j/3j?=
 =?us-ascii?Q?Pz3XlpA1fbJ1MArpL1YdO1NwBMZ8+dXOgy5MKi04AQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U4IfutKhD3MKHg8M5zLUYB4CB490fDv7Z7IKNjhQf/4lkXQqOEYEGxj9A+6R?=
 =?us-ascii?Q?E3Uu0HRfvlvqpwDO2IoMzD9Fc1SNb90aEnakonADMDRW4FyhBYIXqJnDAUbE?=
 =?us-ascii?Q?R3JSsEJibr3AC166m1go+az8iFSMmnfJxKyYPYBKpqDvCvoQxE6BFnnuQyfQ?=
 =?us-ascii?Q?n0jw3vFnxed54xULjGlYWeMge16bHPhQe1ZA/WRs2DRQgEmvffG2KIcKqJOU?=
 =?us-ascii?Q?Fu7c62j8dIkL75pgsbMn1Ip+Bwin8NyG9qymDQSdoEwSrH59Q7iy2QjH95FU?=
 =?us-ascii?Q?Wda3GisZ+KK8JK6jhbLy51tmi0NadVQKp02ChdjHBvYbukg1gqHphaFFly73?=
 =?us-ascii?Q?Y0aWvJyBp2vICy9N1ZP69FkgmeNUgiHyoZZkmMCznweGmSgR5XP4b9LdsrDf?=
 =?us-ascii?Q?khY5UXBzuQvjm/d8j2uRBRmFxjpIlktoPuuMCoq/jfOqodns97xp7z6Kz5Sc?=
 =?us-ascii?Q?M35MZv8M4piuq36+XdPUKztQdU7gkjAYRC98KyYhxazjK8/qHLD4vJdDETVF?=
 =?us-ascii?Q?CinP1fsZJpm0T+R1kLyX51X2fALOPBwm3aP7q6cqSnSAYFHx3+HuSoOCfRnd?=
 =?us-ascii?Q?HZXMkIuFMD8VDk3x9JRLCNg8UZRzUF4zDhz+fAjeI8mo+zw8SGvP2mpZ0kxo?=
 =?us-ascii?Q?TZjuZHviinF0k+6UONesPIkFDDaAjzFRAgJOvl7Gwwqsb0KhMPpR5cKgsXVY?=
 =?us-ascii?Q?2fLpGB9LZKvlpAY0i5yE9uMMtdfJzau/UCyyQtgq4LbffwbMu/bNwxLTR6qy?=
 =?us-ascii?Q?XdiRNd/bskWN2z8LfzTV38uvJElX9hZqA+m0ZCsd7uqG9umHa9JwslzT/2ps?=
 =?us-ascii?Q?URuXY+yvu1BOOkfrNZSgXOvmHILQUARfppgFfOlGwuwOWn/kDKD29IG5TtPA?=
 =?us-ascii?Q?r+dovKZTcAJk4k1s5nH9LPvBxcayPmD2QxC1t7NKdbu9PtyQL7m0+Ibo+FlC?=
 =?us-ascii?Q?bUOR70NlA91cRnISeZ8fHViJR0t87OookE3ex7h2n/PjB/L+RI1kVds/ZhN6?=
 =?us-ascii?Q?uBy+O2qrOM0CPudsssmXfN805SINSc10mj7uYQWC4ZDaJ40gnLr5gUb5cOdp?=
 =?us-ascii?Q?kbx3I+MUykz7pUzmdrfH3ofcGWO8NAL6XvkoB+Y63VYvtJpRnYkFcK8q+Hhc?=
 =?us-ascii?Q?edL0VpJBt83HcjBuCNLJduFtxqQKL6txtU61+q4BtNaEobvyVOttTXi50cEA?=
 =?us-ascii?Q?hDO0BG1jo5xggjN3lLOBBLH1wWxiRoo+1AiIVBwvWNkLss36StkFG8+ayq5j?=
 =?us-ascii?Q?BKRDNe4wcqHgDHx3GeDPcdMtqflc7DAJ4IA7OZqZzkr6s6vZLNIVn7atXiku?=
 =?us-ascii?Q?pzCwwe45FjaoZNpX9KD4lS936JKgzeDGNEB8pt7ftYCkaEDOm3P8+cjbKQGE?=
 =?us-ascii?Q?LeI+W+3KcTRttINASGKf8tS9fxHXPaTeCR3g+ypSC3WhfUaHw3eX3zgp0XNJ?=
 =?us-ascii?Q?VlSUoxAcP4q4NYqoSBo/5/MXzE3wyPc4cYTsyyfRXmnGTqSvNccXz/ke1AFJ?=
 =?us-ascii?Q?wBA019HakNPV1lWosTl8PD4RwLWPjCm/4rdVdUTLtarHiHLz42IjqSAo+JhF?=
 =?us-ascii?Q?NV05mprNZuRSaHtl69Xh4f0QKCEyYYoshtByBWKz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee8f644b-a108-4a05-a4c2-08dc7ff8abd3
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 16:01:59.2996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9gUMtre7BJfbLnmdQ+bkK5SsBoadGjDevELGCyH5Tonz1VhgTYVRqVgVhxsI2BtC0Qhr/3L/WtmYTHoOtID/yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7799
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240529_091720_760979_B0D86FDC 
X-CRM114-Status: GOOD (  16.47  )
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

Additionnaly, we move the mdev pointer directly on the icosq structure.
This provides better separation between channels to ICO SQs for use-cases
where they are not tightly coupled (such as the upcoming nvmeotcp code).

No functional change here.

Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h             | 1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h        | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c        | 5 ++---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c          | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c        | 4 ++--
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index e85fb71bf0b4..b02df4b15c97 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -559,6 +559,7 @@ struct mlx5e_icosq {
 	/* control path */
 	struct mlx5_wq_ctrl        wq_ctrl;
 	struct mlx5e_channel      *channel;
+	struct mlx5_core_dev      *mdev;
 
 	struct work_struct         recover_work;
 } ____cacheline_aligned_in_smp;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
index 25d751eba99b..b45497e6ab1a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
@@ -46,7 +46,7 @@ static int mlx5e_query_rq_state(struct mlx5_core_dev *dev, u32 rqn, u8 *state)
 
 static int mlx5e_wait_for_icosq_flush(struct mlx5e_icosq *icosq)
 {
-	struct mlx5_core_dev *dev = icosq->channel->mdev;
+	struct mlx5_core_dev *dev = icosq->mdev;
 	unsigned long exp_time;
 
 	exp_time = jiffies + msecs_to_jiffies(mlx5_tout_ms(dev, FLUSH_ON_ERROR));
@@ -91,7 +91,7 @@ static int mlx5e_rx_reporter_err_icosq_cqe_recover(void *ctx)
 	rq = &icosq->channel->rq;
 	if (test_bit(MLX5E_RQ_STATE_ENABLED, &icosq->channel->xskrq.state))
 		xskrq = &icosq->channel->xskrq;
-	mdev = icosq->channel->mdev;
+	mdev = icosq->mdev;
 	dev = icosq->channel->netdev;
 	err = mlx5_core_query_sq_state(mdev, icosq->sqn, &state);
 	if (err) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index 879d698b6119..cdd7fbf218ae 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -62,7 +62,7 @@ void mlx5e_trigger_irq(struct mlx5e_icosq *sq);
 void mlx5e_completion_event(struct mlx5_core_cq *mcq, struct mlx5_eqe *eqe);
 void mlx5e_cq_error_event(struct mlx5_core_cq *mcq, enum mlx5_event event);
 int mlx5e_napi_poll(struct napi_struct *napi, int budget);
-int mlx5e_poll_ico_cq(struct mlx5e_cq *cq);
+int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget);
 
 /* RX */
 INDIRECT_CALLABLE_DECLARE(bool mlx5e_post_rx_wqes(struct mlx5e_rq *rq));
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index b758bc72ac36..a29b8b6bd2ac 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1520,6 +1520,7 @@ static int mlx5e_alloc_icosq(struct mlx5e_channel *c,
 	int err;
 
 	sq->channel   = c;
+	sq->mdev      = mdev;
 	sq->uar_map   = mdev->mlx5e_res.hw_objs.bfreg.map;
 	sq->reserved_room = param->stop_room;
 
@@ -1978,11 +1979,9 @@ void mlx5e_deactivate_icosq(struct mlx5e_icosq *icosq)
 
 static void mlx5e_close_icosq(struct mlx5e_icosq *sq)
 {
-	struct mlx5e_channel *c = sq->channel;
-
 	if (sq->ktls_resync)
 		mlx5e_ktls_rx_resync_destroy_resp_list(sq->ktls_resync);
-	mlx5e_destroy_sq(c->mdev, sq->sqn);
+	mlx5e_destroy_sq(sq->mdev, sq->sqn);
 	mlx5e_free_icosq_descs(sq);
 	mlx5e_free_icosq(sq);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index b5333da20e8a..47bc37292bc3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -993,7 +993,7 @@ static void mlx5e_handle_shampo_hd_umr(struct mlx5e_shampo_umr umr,
 	shampo->ci = (shampo->ci + umr.len) & (shampo->hd_per_wq - 1);
 }
 
-int mlx5e_poll_ico_cq(struct mlx5e_cq *cq)
+int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget)
 {
 	struct mlx5e_icosq *sq = container_of(cq, struct mlx5e_icosq, cq);
 	struct mlx5_cqe64 *cqe;
@@ -1068,7 +1068,7 @@ int mlx5e_poll_ico_cq(struct mlx5e_cq *cq)
 						 wi->wqe_type);
 			}
 		} while (!last_wqe);
-	} while ((++i < MLX5E_TX_CQ_POLL_BUDGET) && (cqe = mlx5_cqwq_get_cqe(&cq->wq)));
+	} while ((++i < budget) && (cqe = mlx5_cqwq_get_cqe(&cq->wq)));
 
 	sq->cc = sqcc;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
index 5873fde65c2e..d8563110a273 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
@@ -178,8 +178,8 @@ int mlx5e_napi_poll(struct napi_struct *napi, int budget)
 
 	busy |= work_done == budget;
 
-	mlx5e_poll_ico_cq(&c->icosq.cq);
-	if (mlx5e_poll_ico_cq(&c->async_icosq.cq))
+	mlx5e_poll_ico_cq(&c->icosq.cq, MLX5E_TX_CQ_POLL_BUDGET);
+	if (mlx5e_poll_ico_cq(&c->async_icosq.cq, MLX5E_TX_CQ_POLL_BUDGET))
 		/* Don't clear the flag if nothing was polled to prevent
 		 * queueing more WQEs and overflowing the async ICOSQ.
 		 */
-- 
2.34.1


