Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61971C05027
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Jan 2023 16:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VhBgPUr6NhBchARfJJusmljB/iUDGmqHRoK2+5/OBmo=; b=s1V5lkXqxn61X4dLmiHxFKATLX
	wtu/9CHgQGA/R5pCJEgUcS7dqZINbdNqyxsiJ3uxppx5UKKXMorbGj3EUAzfKDL9FwvNybaHv5AXm
	Wb4a97ToX0ZrTyXutlJJGCmwkbC3uIcO/UmKsTAp+wEKqy8wAjU/D8/22/Nfw2xsKGfGaI/t1lq0L
	poUEYywYJR+4lddcUGcToNBbFvj7UYg8UOl4YIz055pLQ3CMYIuUyAwlD+lAwN8TZPsaaXI0EQ2gJ
	xT8kfp1T0Lb+5GjSkn/54HTgcUjhQweSrHUtneNyyfoI7jYF5icYpliWDYXpAxzrYLL+cI5whNISi
	Gj16gNbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pL51E-00BjTa-HO; Thu, 26 Jan 2023 16:22:32 +0000
Received: from mail-mw2nam12on20628.outbound.protection.outlook.com ([2a01:111:f400:fe5a::628] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pL50w-00BjHX-6K
	for linux-nvme@lists.infradead.org; Thu, 26 Jan 2023 16:22:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXO6aUR/bBj7C4BLL5H+D7xDBVJwbdqhW8+tBg/OWo5xtSZy3GpmA2kws+5YeXQ7AiBWpb8+ElyLv6dUuGcLx/+es1+BYmTpq6BNQZdxtR57j+39lyYm3GOCjyrEPD4el5WDMACaawKF9JclERBDA3B4hB5CpJVt0ZNr+T53TeD3raM2r4/8vxawFBb7b7dAN22ymkPxBnYDLMIqfBh425e/UOswoyAXxUI9FxjLqzPSmOLpQVC8MuQd0oUF6iIuCdD3FJWHvawwkkiNuVljpa03x85cMbKVTBlA+Kz564jX7XRhgnJH2xZFa3JTgfyRGp63fW8ZhC1TxaDFbJqXaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhBgPUr6NhBchARfJJusmljB/iUDGmqHRoK2+5/OBmo=;
 b=Gy3Le6WaRewrwqzj3xFhufP2zUvJ4E2WjjSU7bywIt1f8C9RjV/rjKEKoQRvnH7mX4m9ViH21SsCfu8GLpDncNDk05poIjJGwoYi7XoR3WFc8CYHrT7qqLv5+3AA92f8DtJh9bJC8eXDf/Fq5jkKfcRxnYCrhmBXzDPKK0pCiS0W7W6+UXVH4KuzrdT1NPs4Zv9yYTvQzwlqYpp31PtCrLaLuDIZSzZLZ5duy8qNI2rSE3XGgFc6CpBc3ZoIsTNAXVOCv2xn+6aD1bc/sFlg4EVfXt6wCKR3R5+lh5ONqJdwnC04VnOOqXzZf47o3UDAtXNQ4nSEQ0mq0WYgIidadQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhBgPUr6NhBchARfJJusmljB/iUDGmqHRoK2+5/OBmo=;
 b=FsKjtYOh3uprv4OBhXuzm+cSLSW2ngdYC9TYP5vo18iL8s5BJ3uVFGPIdQ/qs5Z2F25O78R3z+vjPXcKYZGCgQ4fs/qUMujT7W3DdHQHgZ0ERY47DVxVASZlmc2sVonOx/qeGLcT0uj67C2TTNxdeNv1oCd7ZnohKc/nC3JuzUw9Ub6flmFVo7qR9/RttiqcWAujqCb8XIjHvbiou3neKXbgbOnXbSMDqy6nH+4nesDB7G9gzkszhJKD1mVR7XqS0MNccyKBYGROQCxxilzomQBUOF41Ml/OZ5btl9c+qHrdLscsvsBhsKxUmPuuLck/hO8hiOkBQ8mB69sPdWwFYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SJ0PR12MB5422.namprd12.prod.outlook.com (2603:10b6:a03:3ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Thu, 26 Jan
 2023 16:22:11 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::9fd9:dadc:4d8a:2d84]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::9fd9:dadc:4d8a:2d84%6]) with mapi id 15.20.6043.022; Thu, 26 Jan 2023
 16:22:11 +0000
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
Subject: [PATCH v10 04/25] Documentation: document netlink ULP_DDP_GET/SET messages
Date: Thu, 26 Jan 2023 18:21:15 +0200
Message-Id: <20230126162136.13003-5-aaptel@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230126162136.13003-1-aaptel@nvidia.com>
References: <20230126162136.13003-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0047.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::35) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|SJ0PR12MB5422:EE_
X-MS-Office365-Filtering-Correlation-Id: ce76556f-be73-48ac-8731-08daffb97a87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	UYYXYZzykXHJf+SZSNZogXAnIqLvO4cSdoay2hl+qo+d3gUFlTO9kZXmjJfVPpil1LvfoJ841QUtXAz4SFKLEwTpnNa5kFskPm4yorNu9uAO2TqZK3VSbGD5AS5uRoObmCBlYrD02+4GgRDHdKe1NVwM+Bi5DWyHgXeisEbLtivEIM/zNl+nde0bn+YeKH/i/q0REnMoCp8RDb2/EPqCkjKRjd3h2KRFwSTUmNq71fkhlWndPHW77uUfS3C/nXDx+JH8SOoPDc/HZBiMkCJUAVQjASIkHQURqxUSlgurUfQZMlHuM00PSGk6jK+hQFBxCM8R+5+I6nCAitsbKGI+ln6BUN4bOoniOT7wtRenTfdGAT2xW7pqRaO6T4e9bj6LDEyeBPby8bAv8kPUSaVkorAh+pM68wi47s5HmzqjtJIFYOrYpmUBOMUyt3EfgUfE9EDURopHuQegIG2bJQ/WtYzbFPRz9+aOwfU4hYStLysJBL28DNOXxgOQXCaMbL95qFILEitlFURfFgc3y1ndlgDTLFOfkAwEOQaJxBKJdorVUJTNdcaj5qLfTV/+ib80s4TLaOUerBnkasETq9mdQ/NmONH6jYkqzOI2ZTHr2rFVD+YKSY6glaqgyg1kJeWElRfQi9oE71XG4suJLqd6mw==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(451199018)(316002)(38100700002)(41300700001)(15650500001)(8676002)(66556008)(66946007)(66476007)(4326008)(5660300002)(7416002)(36756003)(86362001)(8936002)(2906002)(6506007)(1076003)(26005)(6512007)(186003)(478600001)(6486002)(83380400001)(107886003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?tBpmlHN4xCLXuPByCMD6WdjCqGA+0sDW3RJjHZ3mUHulIVYlEdtrcgWpqsk6?=
 =?us-ascii?Q?FASAeC1L34S4GXd6bg06lePxVFmnMS9raeYMkFbHOLVYs3gizb9uVH+Nwocc?=
 =?us-ascii?Q?8G+wXerZlZwEXPlIXDEZQNGZB5jRhH8vDruTzT3BcLxXjpQMnxOWCh4OPNM5?=
 =?us-ascii?Q?orTthVAvVjBrgjBXAVnQcLZi7kHQJJidrdlETniyR1DzxgPM6tCUB7Fnotyl?=
 =?us-ascii?Q?+XKLl16smSo0gHL5/tcmtKY7aJNxLxDAOtqAWel+aUlwwDB5Dc7MD34Rnnoi?=
 =?us-ascii?Q?ioxiNk8bCfP6mBoz/P9+p9wQvxmFAiRajERrqMvJ9kkzM4L1Pp/pnF/0K+D7?=
 =?us-ascii?Q?4M9yTvHQ8Yod5RIXYMvTU/OATPxnL0tiG2+qsfAsPZPcBFNLgIXWTh+B2WV1?=
 =?us-ascii?Q?ruI01CdgLZTk7pkBOzwWLfPzqrdG3KdMxH0/i1k2BDhZhpluOVPANv+m7r8Y?=
 =?us-ascii?Q?4wm4DJNs22oK87PfpyFRL0TVnZHKuZvy1N7QKhaM3M+k3byMPcpFXR/hxw5t?=
 =?us-ascii?Q?ylknYTvGeX2wUaZ49kkyMSOTC0OhSQPPxWjhySPRMqPOwbjXo3skYGW9TDa1?=
 =?us-ascii?Q?SehITTPyrFF9Hr9d5NgLu4F9nfEb6dY2agCaxruXAJlCfnP5/mzWmgMZ/At6?=
 =?us-ascii?Q?N85qVyW77JqMqh8gh9qEHw8Y8azv6JgW2r1og9i9L4wB8L7Vq86yLHL/u11h?=
 =?us-ascii?Q?UO88VQ4XznlhlMDE+KPRf1CLEaoG5lRK29/0VvIOyG6IvzDCtsXwg5kkAlz8?=
 =?us-ascii?Q?wlIV7B3GGg3Nke6IbhyRcSJJnG3rNNcXTxqWaO5qHsnRgC9SiqKv3Edfw/Oa?=
 =?us-ascii?Q?RwbaPSchwEUgkMe4byd5ekVkoQlwEP9wVdm7KtU7Au9ZwGk3cX69QP+FPO8R?=
 =?us-ascii?Q?gbTLsSe9zxdYmxBGr4y3FSsP6AY4yBdmxMTw6cdjo5ATSEHn1rTcwJAV+x+j?=
 =?us-ascii?Q?Ms9q+l6E5rPsIk0ynVRqiVnnlsCyOxK+JLQDFRkYIfOZyofF++isyTYKLLX5?=
 =?us-ascii?Q?dOh82c+sGFEanbdh55EEJProSlNKNRGCg4G3KNYfjzyQRpna6ulIoMPWYedz?=
 =?us-ascii?Q?DIxzgCQPT3X/N2xlltgRKh99N16Ab9Zcd4mtwOa1cPZp8KRiu/PWNVFzYIrW?=
 =?us-ascii?Q?QGg7EKG0cXm1SIaG9hfyLJWgws/a/zZ30HnlTOT3wMJjd0T8PvsinRa5xyKU?=
 =?us-ascii?Q?Hr6S60xwIY+BK4It1QHtLHhg390Zuf/D/zo14dmyoCj1JVFPzEAhvJXpWprI?=
 =?us-ascii?Q?ldzdqvpuO8SJRoXXt3vFjTmFe/SxIVb0/97PtIJHWzaYufjPTPqQnijQsTN/?=
 =?us-ascii?Q?MosENyIvDJhhzo+1/D8xc/0PEzTeS76tQvE1QlxE+fU7rcFNAWAZotQc6is0?=
 =?us-ascii?Q?foc1W9qiOnjGUDkdmp/gdkmIMvEQQokmIQqRoyaW/YRfbsDITimkyzrrBBXh?=
 =?us-ascii?Q?6g6xZXKDFX6+fJKMTOR6FV8QE08uWHDp9KD7DpA8Bmt/LKFZFzaBAFswVL5Y?=
 =?us-ascii?Q?TYNzrdGiK4IJ4QGRijlc4SW6oRj83heCf1/uSap9fTOfVRhPv0bRk+6fFi4y?=
 =?us-ascii?Q?fX9VQwPx7wko9QPIiHXjsIzi1Yndxc3kSPTgQI7e?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce76556f-be73-48ac-8731-08daffb97a87
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 16:22:11.7643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O1hafs8NBGkT+mwIY1R//B5/FJRRrKpf4qRaQWigOoyG5ojEXhGyNBI1ARJd3i1jvsoX/u15A56paN9/QauhAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5422
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230126_082214_292177_A351B58B 
X-CRM114-Status: GOOD (  16.10  )
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

Add detailed documentation about:
- ETHTOOL_MSG_ULP_DDP_GET and ETHTOOL_MSG_ULP_DDP_SET netlink messages
- ETH_SS_ULP_DDP_CAPS and ETH_SS_ULP_DDP_STATS stringsets

ETHTOOL_MSG_ULP_DDP_GET/SET messages are used to configure ULP DDP
capabilities and retrieve ULP DDP statistics.

Both statistics and capabilities names can be retrieved dynamically
from the kernel via string sets (no need to hardcode them and keep
them in sync in ethtool).

Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
---
 Documentation/networking/ethtool-netlink.rst | 91 ++++++++++++++++++++
 Documentation/networking/statistics.rst      |  1 +
 2 files changed, 92 insertions(+)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 1626e863eec9..11120697911e 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -225,6 +225,8 @@ Userspace to kernel:
   ``ETHTOOL_MSG_RSS_GET``               get RSS settings
   ``ETHTOOL_MSG_MM_GET``                get MAC merge layer state
   ``ETHTOOL_MSG_MM_SET``                set MAC merge layer parameters
+  ``ETHTOOL_MSG_ULP_DDP_GET``           get ULP DDP capabilities and stats
+  ``ETHTOOL_MSG_ULP_DDP_SET``           set ULP DDP capabilities
   ===================================== =================================
 
 Kernel to userspace:
@@ -268,6 +270,8 @@ Kernel to userspace:
   ``ETHTOOL_MSG_PSE_GET_REPLY``            PSE parameters
   ``ETHTOOL_MSG_RSS_GET_REPLY``            RSS settings
   ``ETHTOOL_MSG_MM_GET_REPLY``             MAC merge layer status
+  ``ETHTOOL_MSG_ULP_DDP_GET_REPLY``        ULP DDP capabilities and stats
+  ``ETHTOOL_MSG_ULP_DDP_SET_REPLY``        optional reply to ULP_DDP_SET
   ======================================== =================================
 
 ``GET`` requests are sent by userspace applications to retrieve device
@@ -1973,6 +1977,93 @@ The attributes are propagated to the driver through the following structure:
 .. kernel-doc:: include/linux/ethtool.h
     :identifiers: ethtool_mm_cfg
 
+ULP_DDP_GET
+===========
+
+Get ULP DDP capabilities for the interface and optional driver-defined stats.
+
+Request contents:
+
+  ====================================  ======  ==========================
+  ``ETHTOOL_A_ULP_DDP_HEADER``          nested  request header
+  ====================================  ======  ==========================
+
+Kernel response contents:
+
+  ====================================  ======  ==========================
+  ``ETHTOOL_A_ULP_DDP_HEADER``          nested  reply header
+  ``ETHTOOL_A_ULP_DDP_HW``              bitset  dev->ulp_ddp_caps.hw
+  ``ETHTOOL_A_ULP_DDP_ACTIVE``          bitset  dev->ulp_ddp_caps.active
+  ``ETHTOOL_A_ULP_DDP_STATS``           nested  ULP DDP statistics
+  ====================================  ======  ==========================
+
+
+* If ``ETHTOOL_FLAG_COMPACT_BITSETS`` was set in
+  ``ETHTOOL_A_HEADER_FLAG``, the bitsets of the reply are in compact
+  form. In that form, the names for the individual bits can be retrieved
+  via the ``ETH_SS_ULP_DDP_CAPS`` string set.
+* ``ETHTOOL_A_ULP_DDP_STATS`` contains statistics which
+  are only reported if ``ETHTOOL_FLAG_STATS`` was set in
+  ``ETHTOOL_A_HEADER_FLAGS``.
+
+ULP DDP statistics content:
+
+  =====================================================  ===  ===============
+  ``ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_SK_ADD``         u64  sockets successfully prepared for offloading
+  ``ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_SK_ADD_FAIL``    u64  sockets that failed to be prepared for offloading
+  ``ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_SK_DEL``         u64  sockets where offloading has been removed
+  ``ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_DDP_SETUP``      u64  PDUs successfully prepared for Direct Data Placement
+  ``ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_DDP_SETUP_FAIL`` u64  PDUs that failed DDP preparation
+  ``ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_DDP_TEARDOWN``   u64  PDUs done with DDP
+  ``ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_DROP``           u64  PDUs dropped
+  ``ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_RESYNC``         u64  resync
+  ``ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_PACKETS``        u64  offloaded PDUs
+  ``ETHTOOL_A_ULP_DDP_STATS_RX_NVMEOTCP_BYTES``          u64  offloaded bytes
+  =====================================================  ===  ===============
+
+The names of each statistics are global. They can be retrieved via the
+``ETH_SS_ULP_DDP_STATS`` string set.
+
+ULP_DDP_SET
+===========
+
+Request to set ULP DDP capabilities for the interface.
+
+Request contents:
+
+  ====================================  ======  ==========================
+  ``ETHTOOL_A_ULP_DDP_HEADER``          nested  request header
+  ``ETHTOOL_A_ULP_DDP_WANTED``          bitset  requested capabilities
+  ====================================  ======  ==========================
+
+Kernel response contents:
+
+  ====================================  ======  ==========================
+  ``ETHTOOL_A_ULP_DDP_HEADER``          nested  reply header
+  ``ETHTOOL_A_ULP_DDP_WANTED``          bitset  diff wanted vs. results
+  ``ETHTOOL_A_ULP_DDP_ACTIVE``          bitset  diff old vs. new active
+  ====================================  ======  ==========================
+
+Request contains only one bitset which can be either value/mask pair
+(request to change specific capabilities and leave the rest) or only a
+value (request to set the complete capabilities provided literally).
+
+Requests are subject to sanity checks by drivers so an optional kernel
+reply (can be suppressed by ``ETHTOOL_FLAG_OMIT_REPLY`` flag in
+request header) informs client about the actual
+results.
+
+* ``ETHTOOL_A_ULP_DDP_WANTED`` reports the difference between client
+  request and actual result: mask consists of bits which differ between
+  requested capability and result (dev->ulp_ddp_caps.active after the
+  operation), value consists of values of these bits in the request
+  (i.e. negated values from resulting capabilities).
+* ``ETHTOOL_A_ULP_DDP_ACTIVE`` reports the difference between old and
+  new dev->ulp_ddp_caps.active: mask consists of bits which have
+  changed, values are their values in new dev->ulp_ddp_caps.active
+  (after the operation).
+
+
 Request translation
 ===================
 
diff --git a/Documentation/networking/statistics.rst b/Documentation/networking/statistics.rst
index 551b3cc29a41..9997c5e8d34e 100644
--- a/Documentation/networking/statistics.rst
+++ b/Documentation/networking/statistics.rst
@@ -172,6 +172,7 @@ statistics are supported in the following commands:
   - `ETHTOOL_MSG_PAUSE_GET`
   - `ETHTOOL_MSG_FEC_GET`
   - `ETHTOOL_MSG_MM_GET`
+  - `ETHTOOL_MSG_ULP_DDP_GET`
 
 debugfs
 -------
-- 
2.31.1


