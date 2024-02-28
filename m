Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75608C5478C
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Feb 2024 15:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UBkrPrG8UItm1RjlenMy2WAYh6IiSxPhUc4LOLGGj0Q=; b=Brtr7Th+smCfdqWqw/n4ADCQh8
	xgUi8e46Ffo7almN9Pv4kOwgrNboRb47gd/kpqcfvQ9Rlk/6pYJ7IbMcIs/GHVXDSEmKU4V220REV
	5jkKVkyuFirVjvBBEaQDCHTiUBFNts/vl9o/QydupQL4hvLCFm1hybHETSl/17VzkUsa+bPld2I+G
	zx+vLpfRj2rfJtIsgYuC3T6Syvj248pcX/o3HAdi3Ib3mQ8hShIyN6K1ateETbL/XyoG5jlZKlxxk
	McoK+Ca7iE6Au2pqTWCF0jMZqdcwYSM2WpiOV9Pr4wAqdbkTFRxEVKRpMn2106kyTMv9RBBEI57sV
	8jRImPmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfLfy-00000009rBk-2xJu;
	Wed, 28 Feb 2024 15:16:54 +0000
Received: from mail-dm6nam12on20601.outbound.protection.outlook.com ([2a01:111:f403:2417::601] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfJWe-00000009LEB-16Zt
	for linux-nvme@lists.infradead.org;
	Wed, 28 Feb 2024 12:59:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMm2j/tSl4TgTwa5BaXs4kni3BRmP66JWE8UBOz/NmJdqtIMTp3eyCqwCmgTxok9BpCaluDmphMPRE49iUclGGbXa2rxUr8o6hKjXBvluFka2l6eySKcnvCoAK1tinDmCBfWoaUAsygTBw7+r0GUS+Yi6VhYmFmeKQ7lPzPgVt+d26Qx2EdCMeVOUOMRHtZZq1uqbt3YpxO4p4JaSVDuRvq9svrY5AwEzBUK0fTwf98LsCUZnsNt/QQhwQzKmVg8kcoatlr7j03vKXlqP3gyINaEv6D1CcnS56oaLMYItD5bCgVNf7Xgx5nDxq38+XzxMb8kofOoWPf99TD3eKrPiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBkrPrG8UItm1RjlenMy2WAYh6IiSxPhUc4LOLGGj0Q=;
 b=K6Vu7vqS0akhx48Ej1xFKNB985L9dzqga+vKQEBY9WWUdIcOvVQ3p5byL9A2KjGmMKk8r42gFWifENqIyfiuRY6WzItKR/W+uAPjQ+6FHr/I/Y+EX1UiVdddOjjxAT/wetC0NgPWj3jFRcYRdChCqmaH9XsAkk3WcxOF6zJfbzVDNzhbmYuNeNg2Wvl9Kkkp9OgaQIXwCkZ8JQI7l9sJDKnkfCKRsck7A3JU3X/FhDf0+MQV9aJLaNaukPldqXXbFhap+tvKizOcwPoR3H9+epjHSfpvtCcuH6fk0Pfy1n54vsUqNklwTPvc9rhIEdYGdys2fQYa+IMSzflo2Br34Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBkrPrG8UItm1RjlenMy2WAYh6IiSxPhUc4LOLGGj0Q=;
 b=eEjcKXaFT+1qRZ9S04038EdtapWVCavGtLdebbnf+vwki42elZI0Jnnex7m9gsHowz3ty4TChwYpvm2bjhCRgOlaNU9dFPNu53wNCKdemOXI12+L7Y5vHPW8dartELty6Cr3ana2UTOB3fhhYo7De2FjAFydR6jwQEZ32sQNRA9fWBDaBBW2dM2/pgE0p/x1WfIyD4zy/+aj7CrXJIUTMXazdUdeWMXCSIpIxNJtssTuqSZzG96av2eF2Ew6rTWmcd342xVFBhH+jmKpK0phBnWEuu/zMMw5BBQBJvDh6fWPrQO17QIp81Y4DzT9daQM1Lni7H5eGiYD3j5/VKjOVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SA3PR12MB7859.namprd12.prod.outlook.com (2603:10b6:806:305::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 12:58:48 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463%3]) with mapi id 15.20.7316.032; Wed, 28 Feb 2024
 12:58:48 +0000
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
Subject: [PATCH v23 12/20] net/mlx5: Add NVMEoTCP caps, HW bits, 128B CQE and enumerations
Date: Wed, 28 Feb 2024 12:57:25 +0000
Message-Id: <20240228125733.299384-13-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228125733.299384-1-aaptel@nvidia.com>
References: <20240228125733.299384-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::12) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|SA3PR12MB7859:EE_
X-MS-Office365-Filtering-Correlation-Id: be6504f5-15ab-41f2-4423-08dc385d0120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eV0F7lpFlbhBG8TUkftpNPvgVqttrOligHleZvTnBDjmh79ukslLhGbh1t5Tw63wydQODIHRtX2KGilCCTGID/S/GXwE42qAvaL0+/QhRVKKf1rG+mPRgK7U1D8gTaftCv9AgW4pqo52qxgDZVjLLJEqEugmgy7dRko86r8nl1PfGlzESaRJT/VBDHVTAzVP21fLE/3/Sn7oMD5kbn0YdWdnQBsUxRJWKkgtjZC1yZvRLExfEzDtz1O2Wix4QtU1Plle7n7mCfmkCX5UkfL1Yef41XCRhw78q9WNf5EKhPWN2lmv54IV0RzIRMXflfIe4zAK692SbatknUtvlhn5dWZxKQeYpm4AChHtzNqMD2WoYbAavFcHFgStzlO77Gq8eHZ3iI5bTaCfzEGY5bMpo+qiMB+XIJ/snblNQxIm+C0k6K3LgrVVe4A9XKGTz4d2JjLY9FHeZg5virLt5leAYeSKMyrHTielXsW7jX1WKUA7hUfj7s5wXcrqMT3oPzRX07deGSnSPtz1OoBJfSDRJXJEow0L2PUpePosQBFKcOHuE1QKkXh/HNNbCfajQUlkqKz7yt1U8ki4JBO+1KvpcElzgz4IzYFSTM4IzHPNCYbot7Y1pgVbf1QhOc3kq40n
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PcrCQVgNL0ykNBb9WpzWYLg3FOzbv007HbrBOmd3ZSkMxkYzLxdMgATnLCGk?=
 =?us-ascii?Q?NOflLAfxzPsITMQ/xpm18XDUKupAxfku24UJNzYt4UrGCXgcoDBSsGzrj6p+?=
 =?us-ascii?Q?EiJIycRJ+xDrvqRcMTLczNxO+nZifQBOjdlMuEUh5WtIL4yEJr6F87Cg3YHb?=
 =?us-ascii?Q?vfhOl0v4PAosoy3c5fgEJ43XguerF7If5ZiON9fXmfhraySXsb+8py24YsH6?=
 =?us-ascii?Q?pljRXpUp3QMwduPOYTV4FvIJX3nvNczeSRjIyZo0S6ihrVVCTZKdiSmMAKBk?=
 =?us-ascii?Q?zIo65TK/AQr/Jsr7NfdeG52sbFgOJYrVDBoltNRYIdGY1gkDxj4hnrDrIuLp?=
 =?us-ascii?Q?S73nXQ+F7CWl+wqfc4g5R1WWcbdgCSkdGp0rGepGYZ5c0T2WyPjhsBxpb0Jx?=
 =?us-ascii?Q?7DyjOab/VVm2xEiSfJsVYfVjAy1AX5ranWuHIs0t/TRK6apxEKUz8z3kfZHr?=
 =?us-ascii?Q?af9lDf9vyjLY0msN8RF3461/Wl+q47+0ksX8jM+vB/1bVrnSNDdyQFhK1BC1?=
 =?us-ascii?Q?k16pXGvbuRuB30z7csFKbSqBu7GFFCtRDdGUl/5xENqS0sBVnmkhohuddr6B?=
 =?us-ascii?Q?+PMD/IR4S65lMfNYHe/8cyYvwRHPlMjs19B+XqohtUraei8KDENqd3O+WV89?=
 =?us-ascii?Q?WBDrMRwEWXM4OYX7HRAxu7gbKsgFS0M5y0I75MhY0pxvuy0Hf3LRH6lnNNdv?=
 =?us-ascii?Q?AJjSXhdWdJLIsHU61/IqMS30Hu981XJ1skViEmp9VD3pHo5oOJDkBPCrq/A8?=
 =?us-ascii?Q?yFRRUGbwe5PdVbDOvMc3Xo45MQFWIPUXrRipdvR3WUVo+UcSjz4QPVhMBnQN?=
 =?us-ascii?Q?wOwIjrV4rXLZK/ZuC/6qgMV9u8T9C4PoYUVI/rWWXrdva7VNVMzN+w0cUVU1?=
 =?us-ascii?Q?CXNRKq2XUnoU7NHShRY6b/Q7fr74QzpMh8ESRJNi/UBcfbHQo0l4e2pgJ7VZ?=
 =?us-ascii?Q?ZTuamrUVo+3ymWFFQ+QI1/WenxLA7KbPjJheaf5I85hiwe62BiI4Qfuasias?=
 =?us-ascii?Q?Eiot7Vaem+EWrKQqD4pwgX9vmPewnMBt92zZKpi2shq6rRiFkywAAURY2GHz?=
 =?us-ascii?Q?fkedPC7kiX4kLuxK0QtDXUZUeFqhWtmyTFb1PfhGOBbaBBtAtXCy60Vnp9Ds?=
 =?us-ascii?Q?59O/e1mzRPEzMHR+opEqZrR0+k5u/Mumm2v1wqKr9QZToH9pUV+9tgC0/qOT?=
 =?us-ascii?Q?luGALnbxlKwRbNl7pNZDFGsiHj0daQQMEJPduRylhDFlUS24cTYcz3g897RG?=
 =?us-ascii?Q?K0M1Ked5zLaP3TCCgqwHKIInitIDmObhNsTVw2g75Ah4I7TwO2A1GdIL7lTu?=
 =?us-ascii?Q?X31boIIhgk3Ps+U7WdzAD3KWvnTAPqaaPh8+umt0/7bBcACE1BbQddT2Tx9l?=
 =?us-ascii?Q?mMwPT/EEAFVGiK9IYFtke5hVGu0ZPiAeHOkfy8u5Yqr9L3yH7pcmBy48TQ7N?=
 =?us-ascii?Q?Ink+aDl+eGGkLlwaE5Hr8zqrnTgWce1XerEEEBjSXRKMj+aIxVozh5n6Xpk6?=
 =?us-ascii?Q?1Ul4YQJBzKwCZ+gvmCb30wyzXghsMXbOYw6Vqz6eloYni/ALac7UNWeSniTp?=
 =?us-ascii?Q?uME595qdml4VoBvM3tLm/CC1edhFWL8VxtKcoL8a?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be6504f5-15ab-41f2-4423-08dc385d0120
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 12:58:48.2865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJOFfa6s2KvM1Gc1iU3YsTMfAjCIJJTxml84Fu+BOfHzDhU+OjWm64DiVPqYgYf6HDC8ugMeU1ugAVqHdx/h8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7859
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240228_045908_861672_ABDB2315 
X-CRM114-Status: GOOD (  15.56  )
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
index e7faf7e73ca4..b76aafa679f6 100644
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
index 66783d63ab97..99cea3707bbc 100644
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
@@ -798,7 +799,11 @@ struct mlx5_err_cqe {
 
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
@@ -847,6 +852,19 @@ struct mlx5_cqe64 {
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
@@ -882,6 +900,28 @@ enum {
 
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
@@ -1222,6 +1262,7 @@ enum mlx5_cap_type {
 	MLX5_CAP_VDPA_EMULATION = 0x13,
 	MLX5_CAP_DEV_EVENT = 0x14,
 	MLX5_CAP_IPSEC,
+	MLX5_CAP_DEV_NVMEOTCP = 0x19,
 	MLX5_CAP_CRYPTO = 0x1a,
 	MLX5_CAP_MACSEC = 0x1f,
 	MLX5_CAP_GENERAL_2 = 0x20,
@@ -1429,6 +1470,14 @@ enum mlx5_qcam_feature_groups {
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
index 3ae272948dda..193e56ee9265 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1468,6 +1468,20 @@ enum {
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
@@ -1492,7 +1506,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
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
@@ -3494,6 +3510,7 @@ union mlx5_ifc_hca_cap_union_bits {
 	struct mlx5_ifc_macsec_cap_bits macsec_cap;
 	struct mlx5_ifc_crypto_cap_bits crypto_cap;
 	struct mlx5_ifc_ipsec_cap_bits ipsec_cap;
+	struct mlx5_ifc_nvmeotcp_cap_bits nvmeotcp_cap;
 	u8         reserved_at_0[0x8000];
 };
 
@@ -3746,7 +3763,9 @@ struct mlx5_ifc_tirc_bits {
 
 	u8         disp_type[0x4];
 	u8         tls_en[0x1];
-	u8         reserved_at_25[0x1b];
+	u8         nvmeotcp_zero_copy_en[0x1];
+	u8         nvmeotcp_crc_en[0x1];
+	u8         reserved_at_27[0x19];
 
 	u8         reserved_at_40[0x40];
 
@@ -3777,7 +3796,8 @@ struct mlx5_ifc_tirc_bits {
 
 	struct mlx5_ifc_rx_hash_field_select_bits rx_hash_field_selector_inner;
 
-	u8         reserved_at_2c0[0x4c0];
+	u8         nvmeotcp_tag_buffer_table_id[0x20];
+	u8         reserved_at_2e0[0x4a0];
 };
 
 enum {
@@ -12018,6 +12038,7 @@ enum {
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_ENCRYPTION_KEY = BIT_ULL(0xc),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_IPSEC = BIT_ULL(0x13),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_SAMPLER = BIT_ULL(0x20),
+	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_NVMEOTCP_TAG_BUFFER_TABLE = BIT_ULL(0x21),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_FLOW_METER_ASO = BIT_ULL(0x24),
 };
 
@@ -12025,6 +12046,7 @@ enum {
 	MLX5_GENERAL_OBJECT_TYPES_ENCRYPTION_KEY = 0xc,
 	MLX5_GENERAL_OBJECT_TYPES_IPSEC = 0x13,
 	MLX5_GENERAL_OBJECT_TYPES_SAMPLER = 0x20,
+	MLX5_GENERAL_OBJECT_TYPES_NVMEOTCP_TAG_BUFFER_TABLE = 0x21,
 	MLX5_GENERAL_OBJECT_TYPES_FLOW_METER_ASO = 0x24,
 	MLX5_GENERAL_OBJECT_TYPES_MACSEC = 0x27,
 	MLX5_GENERAL_OBJECT_TYPES_INT_KEK = 0x47,
@@ -12398,6 +12420,20 @@ struct mlx5_ifc_query_sampler_obj_out_bits {
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
@@ -12411,6 +12447,13 @@ enum {
 
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
@@ -12433,7 +12476,20 @@ struct mlx5_ifc_transport_static_params_bits {
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
@@ -12740,4 +12796,15 @@ struct mlx5_ifc_msees_reg_bits {
 	u8         reserved_at_80[0x180];
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


