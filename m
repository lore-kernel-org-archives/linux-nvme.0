Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 014CEC47DD9
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Feb 2024 13:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aBC8ZaRFywYPFjYCo1zZdOWucFVJu46ZFINHRhoYfrA=; b=fB1qLbS4OT6QBhfYtVlRJaLPZc
	61C1zVvrPlFnkL4ze6gJW81sLJ/oc2ZYq5tCw/VoJC/uaIGwywNsG1VFc367moJqB7zZTNnrtf/am
	t3dO4dcRzleNO1hc/DP1z37JRv+i3AR5dlgivPAcCXwuRcvTiiVTXU5BR2mPp+yGnI4z6A+H24PVf
	fyWdUaVU34hAb71H4Y5e4nCx1r2L4Nxha9VFl9vK1AnwTK5gDJRKmEX33LdieJIdk9N3qNfLN8Yfs
	BcCLDbAZ4GadgeOvEyemuBzFUeFZV6pca0N+qzbHxZLHwXZ1d65F4GXL86antb4LcY+WYnFv8nHe5
	km9PIzMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfJY6-00000009MDm-19cp;
	Wed, 28 Feb 2024 13:00:38 +0000
Received: from mail-dm6nam12on2063.outbound.protection.outlook.com ([40.107.243.63] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfJXi-00000009LZF-2h3S
	for linux-nvme@lists.infradead.org;
	Wed, 28 Feb 2024 13:00:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhoZQhOkSdW6SseIyLh91B1B/UQ3LWf/SOn4DwqU1xOQjLHLeDreo9qnb0zeqzaKpsU97Sn+E12P0+r9FTkPtIZQdWB+e0iFNmBrqfSEgrfna2QE4HyEed6nUNefdYM7EKUHLkzk2dOaZJzNar/v5eVXTD54mvVdd4E5wxWi4rG9bEQF2anOWrGq5wCKRmA5Muvn+xzNXpnMbJsGmKJtEGrFoXkCpLPpSPBTmdVbBPGcDUeqoKInE/VE5Cdvai3MP+NrLcFp3bChYGDEcXeheEzX4XTkb8cMCVckfzO6koA9B6wonkIgi0rUinpf46AbjN8M2F1NYT++0fjoEVScRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aBC8ZaRFywYPFjYCo1zZdOWucFVJu46ZFINHRhoYfrA=;
 b=AgEWG7v4kFi0gAn14AaTZDz8vi7n1+J4fcIQcLosRllbDKSEzOM5lzFovzcwMaz+Vp6sKWuIKn3I14SO8FnP3kuJRvS+Ihxj01rAfWIMhwqczzPHXv1EYY8JKw8wF7PIE4NN9+Myg5XZYgTyb/hT7bt3PZQW7yF1S9EfzP83Q6g38fJpR7l+arKiEANaBwY7KEyaWu2mdpY3CZghxYB8UQM3VAIcoPy7QTKKhWTNI1LPZENlL93QwciL2Hx9rhy30DNxjMWzHqtihXaRCplftEGB7wxMfOrHHAgOQj0GFpKHzMZcgW7tJjz0npfG+LYAHyT780i/HAC4DNoUxOr+6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBC8ZaRFywYPFjYCo1zZdOWucFVJu46ZFINHRhoYfrA=;
 b=RFfKvQECUrbsZlktNX+cYUyu4kw3xDpwOY0oshWixVEAZfDIOgmy5eTy7f16GV0r+MX6ueHm1GPR2x74V7NDH+nN3zkaJFmL1uSrMhqwvwkahVHjl0VSeVWFH69BcFFcYICK0usUMjD9iOD6KCUABPwotbVpMMbZipNCQeSE2u4a3JInMxuqEJvI11hG4qdtZV8hVi1Au9QcMwd1ALMfwWNyNHkesfAYCx1rQGdFD3J5pFlt4+GAec6TVw+q0EqRboLzFyOZDSeDLxpUf8hNNK0CAPl1Q3qelVlF98VsMvzxRpYshkJMPNtquFwqvEgxrB0R8/WCaWln8Y0rFcnvDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SA3PR12MB7859.namprd12.prod.outlook.com (2603:10b6:806:305::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 12:59:12 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463%3]) with mapi id 15.20.7316.032; Wed, 28 Feb 2024
 12:59:12 +0000
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
Cc: aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com
Subject: [PATCH v23 17/20] net/mlx5e: NVMEoTCP, ddp setup and resync
Date: Wed, 28 Feb 2024 12:57:30 +0000
Message-Id: <20240228125733.299384-18-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228125733.299384-1-aaptel@nvidia.com>
References: <20240228125733.299384-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0398.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::16) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|SA3PR12MB7859:EE_
X-MS-Office365-Filtering-Correlation-Id: 669e4728-3754-4670-6159-08dc385d0f39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sSUqU4mN0IiTxUP7di5vT9qRRyVkYnPDx07uLEvYJxTm7NKku1oESJaZCK3HFM6r5mF5CKW0Dg0ANMhaz35YAukoJb/bwXCYJeb1aryK9w2SOS4HvoMOz1belZ/CEHdKCsclS010TXsdEWpdzjdsT1nPtq8Fmmcq1O9ZCOM/87UxfofrShLJ15E/Ck+85UmVz5uK71BLPIxH7cnrn1lznOmQBv9rU22W2c1+ybSZIApvKNXadI4mTc6Xf2WTpKZIwaL3OIM5b2RJz9cnzg4zW37JfObFNHAcNa2CGknObLumIXSnpPbNSnc3fSsT1t2I0w05uzjfYjtiOdG0KDlf88ISQXcwXIQRXdwVaSqqAt34ExHjoGn6vSXtZHH0lnDX5Jkda1ABMuN3q6vz1UDMKvF2u3RGYjQBQbgCvWCpq1TpmyaiZ1nSN826sYuYnh8b5MXFCwB6HSwHLRZxKs1Q6Jl0hpbPkb7PC1BvENjcDLNWv2iWjMm9LIMUveiGk33YB1fZKOGKr9Xn53zIfUucjtWcuBwzHFvvjNwSlw2BUJpZb8vfpzNQ9gKGleicPKL124EDy37OWFJjof0ihSzoEiGwzG6rUGbA61KTtfMyhFLduOr9SRarXgsxMTzT60Bb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DBahtDjPnC7Vat/JydQ2RSGOPp8b7yBxH0cXmR8mURXhIsiRlElMDVVzm+wR?=
 =?us-ascii?Q?0O2ws0m3npZpT6WV0wmYqPKXzPds1egRUdqGGBFvLX9clvLNfS2wsDO5avhQ?=
 =?us-ascii?Q?5jfcnMTFDB/OSFsjbh8LqRSDAsMY8Zz5WQ7OFjEJzA5Qp2YfhMIHcLGyJ9ph?=
 =?us-ascii?Q?IcEKDSIU1LncS3/un38LwVmblg0Ae5ZnYgI8eMbvEiFXu8hKvEBrkaGhYneO?=
 =?us-ascii?Q?kLJLby8St33bz7vuMUp5G2LcyuawK+RXoaK4I6GaYlavtkfu1JZw5Pc0uP00?=
 =?us-ascii?Q?lZ7GMtQHK2tYwde5SPqq1uRlVB63g54QuoXUC3xmOkTOJi/+FqpdZFALN0GI?=
 =?us-ascii?Q?riz8i0LBsFGGawrdWo7jkQAa2PlAHB+1CylEx/BpHDRasVPZD0qEHGihtXSy?=
 =?us-ascii?Q?QhR8L0+BIv8gADanldh7W0Ik63IeM1WNKKEWVV2xya4A9wyTDTOea5Ol3S2D?=
 =?us-ascii?Q?/xNDfLB0RjTbMXMuqE9o7mOcVl1wiHPzr7AlUqqRhkan+3CPuMN8r+Sem6ko?=
 =?us-ascii?Q?ejJKN7MwZQb5bWbfTPUU8dVuAryrc+TQxk9MmwsyfkRfvFj1lOeL7TbpdvpN?=
 =?us-ascii?Q?Pdd3N0IjTjmJ9O9rndbapcLp01eZkSO09QOS6qtrJbcRW0kxoedkXF9O9zG5?=
 =?us-ascii?Q?JlmDq2ZQ62OWFAmoUhMJle2EeH+aDzw3yxmKjA+00xf8cyAr17EBYw5VCXY0?=
 =?us-ascii?Q?nH2WFAh5hVPAW1CgZ+OaYD/h9drrcRC23Iy8mO0VdaSITNsl0vPYkjIf6WWg?=
 =?us-ascii?Q?dRVaFCUIioSbIDfVhQDUoOk871PNcgdzLHXG9xGLvYs4KttcfFLv4j5IFiqj?=
 =?us-ascii?Q?n16yXgqjl2y6EkMkrs+BtDO02usWBtu96b2IyI+YkV9sREsI3hboGdJKZCdr?=
 =?us-ascii?Q?6+Q7JFPkKrzEoOZ6GbCGuiKa30B5TwvqGW5JQeNKYXEqmF0ZG4mMwjl9D/7g?=
 =?us-ascii?Q?2YfYG2/s2e3jWCIP+JIBnG8p3jiwgHzH9Lkb3oyj4ltc7Qj4PiFZ+nMjHe6H?=
 =?us-ascii?Q?11DodtT7A+ZFQUNCDdAEME2GznS4aDnr5B+5HopemTJgkXs04tyLbQuWuQX2?=
 =?us-ascii?Q?cjiovvr26agfclmZ8/EJO6YlFjWmQEsTiV4vZI9EdaacOLHp/YQjLIH1kPJa?=
 =?us-ascii?Q?7rJ2OactGolXGTVjOXzJiMPOr3L4/OF/Abpbdw1AsDpYji4nBgpJ1ZXXHOM4?=
 =?us-ascii?Q?wXhN72C4ei4u6QbQC119gRo5H3+3bVdXkBN/bgRV+4xv+qqZhDIPfwE/UXty?=
 =?us-ascii?Q?FSReQUkIuTWMsV8LtAXeyw6OLQURLkMyrqsySZrzo7nOJuR5qy8VP+SOZaMn?=
 =?us-ascii?Q?aqSzRT3nATH94MFXbVh/juSSVYEe50y47FVTC6NnykxsXIK5jVzjLYEal70n?=
 =?us-ascii?Q?zc4fpd+7umHw26a15Miq2OFQzr/rFViU2xga7bV9HmayCsqFd8vO1Z2QtDgs?=
 =?us-ascii?Q?AkezMo2w+2Nm8X6qaJxa2EujlaFVUiIJGziFEjSqZt64zRR3eMN2Ahmx66g8?=
 =?us-ascii?Q?y9P/BDMHAQ4DiPfYF+XtfspUegY0pKG3SzdkkmbYHFVKw3IyU9+29MGGdwu5?=
 =?us-ascii?Q?wneQBvF1R5uDBWWfVUgW5WmKwHXLrauN5pi2zW15?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 669e4728-3754-4670-6159-08dc385d0f39
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 12:59:11.9495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mu1Qx81F0td34bsQGJ5rsZJ/dOK1SOyf+roSNj7clRKYvGVHZHH+i3pyK14Jb+kqZXiSEUeNjhMZGCmVDJf5Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7859
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240228_050014_829485_2DA4DA87 
X-CRM114-Status: GOOD (  25.16  )
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

NVMEoTCP offload uses buffer registration for every NVME request to perform
direct data placement. This is achieved by creating a NIC HW mapping
between the CCID (command capsule ID) to the set of buffers that compose
the request. The registration is implemented via MKEY for which we do
fast/async mapping using KLM UMR WQE.

The buffer registration takes place when the ULP calls the ddp_setup op
which is done before they send their corresponding request to the other
side (e.g nvmf target). We don't wait for the completion of the
registration before returning back to the ulp. The reason being that
the HW mapping should be in place fast enough vs the RTT it would take
for the request to be responded. If this doesn't happen, some IO may not
be ddp-offloaded, but that doesn't stop the overall offloading session.

When the offloading HW gets out of sync with the protocol session, a
hardware/software handshake takes place to resync. The ddp_resync op is the
part of the handshake where the SW confirms to the HW that a indeed they
identified correctly a PDU header at a certain TCP sequence number. This
allows the HW to resume the offload.

The 1st part of the handshake is when the HW identifies such sequence
number in an arriving packet. A special mark is made on the completion
(cqe) and then the mlx5 driver invokes the ddp resync_request callback
advertised by the ULP in the ddp context - this is in downstream patch.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 146 +++++++++++++++++-
 1 file changed, 144 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
index 38d87a3e2931..dd9c28d60fd3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
@@ -684,19 +684,156 @@ mlx5e_nvmeotcp_queue_teardown(struct net_device *netdev,
 	mlx5e_nvmeotcp_put_queue(queue);
 }
 
+static bool
+mlx5e_nvmeotcp_validate_small_sgl_suffix(struct scatterlist *sg, int sg_len, int mtu)
+{
+	int i, hole_size, hole_len, chunk_size = 0;
+
+	for (i = 1; i < sg_len; i++)
+		chunk_size += sg_dma_len(&sg[i]);
+
+	if (chunk_size >= mtu)
+		return true;
+
+	hole_size = mtu - chunk_size - 1;
+	hole_len = DIV_ROUND_UP(hole_size, PAGE_SIZE);
+
+	if (sg_len + hole_len > MAX_SKB_FRAGS)
+		return false;
+
+	return true;
+}
+
+static bool
+mlx5e_nvmeotcp_validate_big_sgl_suffix(struct scatterlist *sg, int sg_len, int mtu)
+{
+	int i, j, last_elem, window_idx, window_size = MAX_SKB_FRAGS - 1;
+	int chunk_size = 0;
+
+	last_elem = sg_len - window_size;
+	window_idx = window_size;
+
+	for (j = 1; j < window_size; j++)
+		chunk_size += sg_dma_len(&sg[j]);
+
+	for (i = 1; i <= last_elem; i++, window_idx++) {
+		chunk_size += sg_dma_len(&sg[window_idx]);
+		if (chunk_size < mtu - 1)
+			return false;
+
+		chunk_size -= sg_dma_len(&sg[i]);
+	}
+
+	return true;
+}
+
+/* This function makes sure that the middle/suffix of a PDU SGL meets the
+ * restriction of MAX_SKB_FRAGS. There are two cases here:
+ * 1. sg_len < MAX_SKB_FRAGS - the extreme case here is a packet that consists
+ * of one byte from the first SG element + the rest of the SGL and the remaining
+ * space of the packet will be scattered to the WQE and will be pointed by
+ * SKB frags.
+ * 2. sg_len => MAX_SKB_FRAGS - the extreme case here is a packet that consists
+ * of one byte from middle SG element + 15 continuous SG elements + one byte
+ * from a sequential SG element or the rest of the packet.
+ */
+static bool
+mlx5e_nvmeotcp_validate_sgl_suffix(struct scatterlist *sg, int sg_len, int mtu)
+{
+	int ret;
+
+	if (sg_len < MAX_SKB_FRAGS)
+		ret = mlx5e_nvmeotcp_validate_small_sgl_suffix(sg, sg_len, mtu);
+	else
+		ret = mlx5e_nvmeotcp_validate_big_sgl_suffix(sg, sg_len, mtu);
+
+	return ret;
+}
+
+static bool
+mlx5e_nvmeotcp_validate_sgl_prefix(struct scatterlist *sg, int sg_len, int mtu)
+{
+	int i, hole_size, hole_len, tmp_len, chunk_size = 0;
+
+	tmp_len = min_t(int, sg_len, MAX_SKB_FRAGS);
+
+	for (i = 0; i < tmp_len; i++)
+		chunk_size += sg_dma_len(&sg[i]);
+
+	if (chunk_size >= mtu)
+		return true;
+
+	hole_size = mtu - chunk_size;
+	hole_len = DIV_ROUND_UP(hole_size, PAGE_SIZE);
+
+	if (tmp_len + hole_len > MAX_SKB_FRAGS)
+		return false;
+
+	return true;
+}
+
+/* This function is responsible to ensure that a PDU could be offloaded.
+ * PDU is offloaded by building a non-linear SKB such that each SGL element is
+ * placed in frag, thus this function should ensure that all packets that
+ * represent part of the PDU won't exaggerate from MAX_SKB_FRAGS SGL.
+ * In addition NVMEoTCP offload has one PDU offload for packet restriction.
+ * Packet could start with a new PDU and then we should check that the prefix
+ * of the PDU meets the requirement or a packet can start in the middle of SG
+ * element and then we should check that the suffix of PDU meets the requirement.
+ */
+static bool
+mlx5e_nvmeotcp_validate_sgl(struct scatterlist *sg, int sg_len, int mtu)
+{
+	int max_hole_frags;
+
+	max_hole_frags = DIV_ROUND_UP(mtu, PAGE_SIZE);
+	if (sg_len + max_hole_frags <= MAX_SKB_FRAGS)
+		return true;
+
+	if (!mlx5e_nvmeotcp_validate_sgl_prefix(sg, sg_len, mtu) ||
+	    !mlx5e_nvmeotcp_validate_sgl_suffix(sg, sg_len, mtu))
+		return false;
+
+	return true;
+}
+
 static int
 mlx5e_nvmeotcp_ddp_setup(struct net_device *netdev,
 			 struct sock *sk,
 			 struct ulp_ddp_io *ddp)
 {
+	struct scatterlist *sg = ddp->sg_table.sgl;
+	struct mlx5e_nvmeotcp_queue_entry *nvqt;
 	struct mlx5e_nvmeotcp_queue *queue;
+	struct mlx5_core_dev *mdev;
+	int i, size = 0, count = 0;
 
 	queue = container_of(ulp_ddp_get_ctx(sk),
 			     struct mlx5e_nvmeotcp_queue, ulp_ddp_ctx);
+	mdev = queue->priv->mdev;
+	count = dma_map_sg(mdev->device, ddp->sg_table.sgl, ddp->nents,
+			   DMA_FROM_DEVICE);
+
+	if (count <= 0)
+		return -EINVAL;
 
-	/* Placeholder - map_sg and initializing the count */
+	if (WARN_ON(count > mlx5e_get_max_sgl(mdev)))
+		return -ENOSPC;
+
+	if (!mlx5e_nvmeotcp_validate_sgl(sg, count, READ_ONCE(netdev->mtu)))
+		return -EOPNOTSUPP;
+
+	for (i = 0; i < count; i++)
+		size += sg_dma_len(&sg[i]);
+
+	nvqt = &queue->ccid_table[ddp->command_id];
+	nvqt->size = size;
+	nvqt->ddp = ddp;
+	nvqt->sgl = sg;
+	nvqt->ccid_gen++;
+	nvqt->sgl_length = count;
+	mlx5e_nvmeotcp_post_klm_wqe(queue, KLM_UMR, ddp->command_id, count);
 
-	mlx5e_nvmeotcp_post_klm_wqe(queue, KLM_UMR, ddp->command_id, 0);
 	return 0;
 }
 
@@ -719,6 +856,11 @@ static void
 mlx5e_nvmeotcp_ddp_resync(struct net_device *netdev,
 			  struct sock *sk, u32 seq)
 {
+	struct mlx5e_nvmeotcp_queue *queue =
+		container_of(ulp_ddp_get_ctx(sk), struct mlx5e_nvmeotcp_queue, ulp_ddp_ctx);
+
+	queue->after_resync_cqe = 1;
+	mlx5e_nvmeotcp_rx_post_static_params_wqe(queue, seq);
 }
 
 struct mlx5e_nvmeotcp_queue *
-- 
2.34.1


