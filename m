Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 949FEEB64DA
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jul 2023 16:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VDFji7ZSja+g0pa5F1amy5BI7kyjyiwids4F1LjKljE=; b=NKQyuCIbh7rvgF2zOSmojA6Skv
	Bsw1BQ4T/Y0/dK7IBGJxR45Idds/tkIMhLzF5WkRGupDjRlETxbTCPm2PWmlIgo6qdDrIIntIuRC9
	y6R0HaQPuc0k0Ejq97I4LONhqYIiosUa/juw/rWq8YP+/eI7/+lQoQxYeQsaLHiPB/ezAeLiZwQur
	wg9HBoEL3AT8fku4LgXfoY2mueQSO13RQon2JKJE9Buhz9fIrEw9LcOg+7KEqqnhql5Z12UVFiQqH
	Pnuc7fns1PTDInUSB4MPlnCnU5wAOGyGZOXbXSxpuucRcu6/0O7YRUOJCWpUStaqDBZeYvwrLd+cK
	aky7qRnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJcXc-000Wfd-0n;
	Wed, 12 Jul 2023 16:18:12 +0000
Received: from mail-bn8nam12on20620.outbound.protection.outlook.com ([2a01:111:f400:fe5b::620] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJcXR-000VK2-1j
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jul 2023 16:18:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ik1HBSS+rd4JYZLVSOPLJMrRKjJHPUqMwLZWGMm3W8D7P7VPn9jSnoEP89m4n+o39eNicHhJbL26X7ka5ACsXoxTRlAXLwyYsX53UFy37yWvXKd11bJKSX4gZTYy3W5eyGPLbaeWy4THKAVAgKcF8SurJYJAdpJ6GdbnAtytoBgT2DXij8JvfttdLQVt6YwC2dW4RmfhSGVPFFB4TGBJgN/U03N8bLVajyLTH6KG6N+ZKyeqdYokrzH9jseN+xgu070teeIENRINfs1ikvCDNTZTyDccn9XEIrE2PsVptRQQBoGwoPedV6+J/3LuGuScdzvNSMOH3h/m3fMSV0KQaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDFji7ZSja+g0pa5F1amy5BI7kyjyiwids4F1LjKljE=;
 b=OWpVz+epRWAe5SGpWfekBaRnb/W1nCVwegYEvdhwPeOOD4kpOWTXgn3a2dB6vHbbKdJs18lwe+0HU1wjpnt9MzNSKeJAXu3iUxLw2C5JcPihiKv3atojY7ZoYJE7BrcK90e4I5MQm+w+QbrVRfuk5ftAruMQs6+b0tCyRkeOVa46OUX2xjmONEin7a1/MpDpaEvVZfW7zDfHbrLmQYSDdGghyL3G2X60UDQxFpYJjPfk9NfEel7hUkcSxi6IiBp90xR1mlABMzK63e+u4PNSHIokpzIngjuJUj+P5PuSEyadnd2vhc+6FOAcVikSMkL6k2aEELEmAUHSU6IIS0V4Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDFji7ZSja+g0pa5F1amy5BI7kyjyiwids4F1LjKljE=;
 b=otdcP7vo5B3jVoHmFd47vGjxDQRTPHODhj5lqrr4lci+ypUa0REktOtHosaQsqYte7LGrWrp/9uIa3iZkMh6NN2cegHxwGHcSX9+ygDu1gJ6dKsn545HOB9f9418VgYyWvnxob8aPXA6myIvARhgy7HnTxcm1FsUpj/QnrYgwa2aLlFn/ws19dzf/uMjjflMyB7qo+4SUrC2So4uNfWdL25oeIufzyX3MntYAdPD7h7BqaTFB+h7FfEybKhOZtvZ3tlUam3IFaWnrKsB/7EJ5IhSOPcu1shHE6A2JogEXsuPDYWxg0i0qo9BpdXkcbrW/aUeXAY6MRJR1N4pIMBUQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH7PR12MB7212.namprd12.prod.outlook.com (2603:10b6:510:207::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 16:17:30 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3f6a:7977:dcd4:9ad1]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3f6a:7977:dcd4:9ad1%4]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 16:17:30 +0000
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
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com
Subject: [PATCH v12 11/26] nvme-tcp: Add modparam to control the ULP offload enablement
Date: Wed, 12 Jul 2023 16:14:58 +0000
Message-Id: <20230712161513.134860-12-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712161513.134860-1-aaptel@nvidia.com>
References: <20230712161513.134860-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0008.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::20) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH7PR12MB7212:EE_
X-MS-Office365-Filtering-Correlation-Id: 33ec3428-2cbb-43c1-6896-08db82f37dff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JfSYm3Z+LzuhB5f/kz+DugkeQpF2GuQtl0s3qfoeJxtEmxKkplOz/GvGrZb2q1rgXyh2jQvb7upbXPMOWRTLtwFF7SVXzyjDkFYxx0YSoY39EXsdFMIEF5C+D0O1pUAAXqAUGCD+iglYiYDwuTY2N4nbjZyx9qwx1yQgGRahdxCbC5W3katd83nlbinIbVYIR4IgNVjV1johzRaL5c44MUjyBsdBXQFJycz9UQ6+IVBM+fV+gUDwBeFdFJrx+IBCsFJeJjWJiIOhXPbiavlG4eQQ8WhajGWyvHonIfnFrmygxRetVItLJ2x7eICw7PRuNB8PCiA4PwmER+Jj5+XxSakJaSJSMlqAxRZXsAxCgMiHvk4jVQddWJjtdkatLhtsp6uM4Ib4OgPSrB8dSFi2X08NfOi8B+XEYgFrzKX7pfWYjPeu7CSGJn82banAdgMydWjdMFCkSu0IYbonBHPLvmfKdhQ193cUxC1SJruNpEQzAUIQdlm60Ex3IXEuWfyTElxd0xfr+XhedxWI5p8BUSeLiKhsYCAe2iV4SCG9GDHCkS7Km+5pcK2oSvGB+3yY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199021)(186003)(2616005)(86362001)(66476007)(66946007)(66556008)(316002)(83380400001)(107886003)(4326008)(6512007)(1076003)(26005)(6506007)(478600001)(2906002)(6486002)(36756003)(6666004)(38100700002)(41300700001)(7416002)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AvNEpHg7ADK0YX2NoF276lSH/0WVBy5U37nDPbcrgTyJRblzPS6aNFNuljvQ?=
 =?us-ascii?Q?xb73RQ/RZHgVoc6E6AuSSVDXxJok8jjhYQNoll102b+0yGrqn3Guz4CKZjHq?=
 =?us-ascii?Q?ZRFh+FW4IrKJ2Qq8x2AaLogMvVoNRP2L6fLpPIDRmx5pLwKsPxiuaNc4KRFD?=
 =?us-ascii?Q?IITtJIsQWcFnVSvr9rGr+AQyZ3kzF2H5rCZR9R/aafWqgQFSY9xmYeaH8Jaa?=
 =?us-ascii?Q?lNFPD9/odtktYxeVbJ1jjjLxsNVk/TRlwqMKi/OEJ3y44p77+8FCE8YJONdG?=
 =?us-ascii?Q?lH4TLSLaMs1YWvPuMT8pm/0KWFD0pp89MBKKb2os6+cduFJUZdQ+EYw2PxZ6?=
 =?us-ascii?Q?Dmx8qFLhVxFcrxhEytxIbdjeu8mNOOBNEdQImlE0/oFYU6Pn9GShG/6PocVe?=
 =?us-ascii?Q?aAPlwhVSaSfIu+uvxRGniZ4R9sa1smz1doEyrUtA/ZDOCRE69qmcTm3wklcy?=
 =?us-ascii?Q?bG7MdC0tsfmG7OwDC/HRE2xaBarWpsp5j6vyS815+3vPa4kQ9c06mIrnJuqQ?=
 =?us-ascii?Q?0yTTj4jjkalzcnAZeot9rxAWgNLNtwS+OV5pBIz3O+SJ6zI0Vz3dHa5Z8K6m?=
 =?us-ascii?Q?Uhv6hvwpNSKtKtJOSZHJY+qCOrXxvy5RIgheqV/JPw+eQw+auWlz98Jo5QpB?=
 =?us-ascii?Q?ZhfRwW6WvO0TsGDQNRpFI3MjKqQ2srawmHgWgZyMfZ2bJU8APjsIDGOHZOlp?=
 =?us-ascii?Q?vbCF0ybAx0+2GJlAtO1qSEoIldH5WGvrbAXBqFlQZEJotFKYNSkQwKhuxSXo?=
 =?us-ascii?Q?wO9yC09HHy9wOtFLqLk74C6BKUml5CFGlII1IA2COpaDjf2qovypCJ+N8Upg?=
 =?us-ascii?Q?K9TF/I7h8qkON+JxEuAy70x8mq2u57k8sYBl5FaEWOFawQAufOrGwSKZXF9b?=
 =?us-ascii?Q?+ov/ezgU4aIglLztl5tYa8MeFAeOxgYqLvxuhesfV11pGURi752CYrmaY2EW?=
 =?us-ascii?Q?xmYdLLmpN1z5cFkiLa4+94++SQFrWHLy1ZbNEzp5T+RlCyOQM1B2g0HsV/VZ?=
 =?us-ascii?Q?QZ3Iu1NoGWTpmewi1x+r7JtSG0aNg2XHJFCY1TF7UgZGLs/kjY7B0U3nUX12?=
 =?us-ascii?Q?keZveWHE/4WlxjgzQRG5saSSF38GQM2LcFnoRIX7FPiHIbuVKKuVPI5mD3Mj?=
 =?us-ascii?Q?xs4/W5s2AhpYHqv9Sl+K3juvfRwFotd2x3AOSu/yzLTWGOn9kLaz8GI/LY6M?=
 =?us-ascii?Q?fnT10hRa2GuEbCjkSrt8/ptGSywxduCLFrBttUbc22B2llk01JZ/mz6s1SoP?=
 =?us-ascii?Q?hS1vXmLuxYLf0Onh/cc2tHmcTb5GnzFaX6zk8l5ZkSizHVkriyG8Jd4sfkfr?=
 =?us-ascii?Q?T/wIPMpP8qPFHiG9l3vC5/h70oLCdeUdGhcTtd3P9cL+kLfVQHav012hvqNK?=
 =?us-ascii?Q?2Jw584/ToUAIRUVDw7HGm4X9DgCs4HhSVxlOfa6/MAeXGUcjAB/hUPLCF119?=
 =?us-ascii?Q?U+KSbOBBGeSEhvdGeoUrZy4RPUEoT6esVlLqMMkSMwZUnOPv6Rd2MkLClUR+?=
 =?us-ascii?Q?kdKdFJidVzAWsOGA9zWPfz8d7Cdf3FjkQX9bTGbkZsuGJFJwq4bNXW4RQYWR?=
 =?us-ascii?Q?wkxIfJP+UfpXoGPy90QlDU4M+UYDQDcPhMEjjFYa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ec3428-2cbb-43c1-6896-08db82f37dff
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 16:17:30.7724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: svkPIJ+OIc4lJBWtpLQAVzJ7wBANQ0eFYh44SHVpxxglxUzld4M8UyljTxw9AoHGHkAwVU1/0pXcCijKg8vPZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7212
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230712_091801_610086_365C35C6 
X-CRM114-Status: GOOD (  11.98  )
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

Add ulp_offload module parameter to the nvme-tcp module to control
ULP offload at the NVMe-TCP layer.

Turn ULP offload off be default, regardless of the NIC driver support.

Overall, in order to enable ULP offload:
- nvme-tcp ulp_offload modparam must be set to 1
- netdev->ulp_ddp_caps.active must have ULP_DDP_C_NVME_TCP and/or
  ULP_DDP_C_NVME_TCP_DDGST_RX capabilities flag set.

Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
---
 drivers/nvme/host/tcp.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index e68e5da3df76..e560bdf3a023 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -49,6 +49,16 @@ MODULE_PARM_DESC(tls_handshake_timeout,
 		 "nvme TLS handshake timeout in seconds (default 10)");
 #endif
 
+#ifdef CONFIG_ULP_DDP
+/* NVMeTCP direct data placement and data digest offload will not
+ * happen if this parameter false (default), regardless of what the
+ * underlying netdev capabilities are.
+ */
+static bool ulp_offload;
+module_param(ulp_offload, bool, 0644);
+MODULE_PARM_DESC(ulp_offload, "Enable or disable NVMeTCP ULP support");
+#endif
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 /* lockdep can detect a circular dependency of the form
  *   sk_lock -> mmap_lock (page fault) -> fs locks -> sk_lock
@@ -350,7 +360,7 @@ static bool nvme_tcp_ddp_query_limits(struct net_device *netdev,
 static inline bool is_netdev_ulp_offload_active(struct net_device *netdev,
 						struct nvme_tcp_queue *queue)
 {
-	if (!netdev || !queue)
+	if (!ulp_offload || !netdev || !queue)
 		return false;
 
 	/* If we cannot query the netdev limitations, do not offload */
-- 
2.34.1


