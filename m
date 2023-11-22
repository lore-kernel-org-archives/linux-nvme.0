Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A721C61D9B
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Nov 2023 13:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5o1URdbYBAcJuHz3gCX22gLpro0Oy/3zc34J3syKFz8=; b=PFQiwAQYPUnfEDJX2LjAVabKI1
	K0WC3LGnlJSkFxZWbfk9MQpbbHLX9cOkM4Rs9/xTTEMd6p9yGgaxydHFygm7ZOIU9BBQ8TDdtpUst
	kTYJdmPudONEMpg+XXK0jwBIKPg9OMqLVBjhFJs2NEZqcslt0vEzErb5HXNVoNWBOxlYeGRcgJqef
	dJMKkVU8X5UToiPPSc7axzpmZLi3vPFoTH8ehflUY8VttZkDL6Kk679g1Ib4K4Ry7+01ikJWHkVDV
	GPcYGPxo9Zv2yuEpIfgmCuMJ5plhDn12IIIUKsW7USR4mPgdkpP4v5MzSvuEnMPIBPBdcwaVwvG85
	Hs29uH9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5nbd-001zgO-3A;
	Wed, 22 Nov 2023 13:49:29 +0000
Received: from mail-dm6nam10on2061c.outbound.protection.outlook.com ([2a01:111:f400:7e88::61c] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5nbb-001zbT-1p
	for linux-nvme@lists.infradead.org;
	Wed, 22 Nov 2023 13:49:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2wBvr2Oa0FrPeOjWvGID2029Af2aW1VjNVG8KCJqM5cxMLWJGl+GWGR2ZkttGsHvoGM0qEMfO8qVrCOsXsjINSKON1zJvOchN/PwlmDHrLv88tUz0MWQmE52CWRLUfjJnktKBiqR+JLQ/C9NoVR95OFnRLnKvWhIR2s0FBWRGK13YUvioS0zR/+Gr6/eH+rt4PsBvtAlOCf54zT6oEvA2xMJlQArT7P9/0vqunswIb5Kyie4qTHkUlD6nTq0Qj5Spbo8feviNiTEJk3uZ76YWp0JEjojyPCVjs0gcayYdhNylNvc5JFvcnVcKXxgIgdWZev0eV5yXRWYKESEpmJZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5o1URdbYBAcJuHz3gCX22gLpro0Oy/3zc34J3syKFz8=;
 b=etdE//X6YL1KU0VuQmIkXT2K4bovdMMtrp1Y9BU8bS5PQuyWFnTU3laEFQdx8OkLiYJvxmQJbROyVWdywKDvHzZP3t7CyySQu8Ni7Nfvcb34ELW2xYdZkh1y6biQEMHbAY0eu84ka9juUSCH5/GvEl/F2RtJL+sTFq0uJi6k0fDxnQ8d+144jnB6/5HXs6bt/kBtTyFoSn6fENPV2eZcTSnhfgAljj13Vi5wKtPoWN31uqO2ntUf5aPdFfHClO0YBKS8d1ZalCz4wifF8lWbq9nHUy6AxTHNVR7E+i/ajV3fVam67VRVWzumTktrFL8yfM6g5IpZRr8Br6rYKrpMlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5o1URdbYBAcJuHz3gCX22gLpro0Oy/3zc34J3syKFz8=;
 b=ezMhVsPcXe9/5EsBI9AKq76ZluNFEf1VeA3XQqeWH8ACbaAlQTJnEsNS1VjfqsmM6V9/EIgFhnMykcOymzxsDbXqPYB8VwawB0hZb3NdlZMWtGBUI6W3+99ooprOVdzNDTdQI2aaV0cwaNJohppCgqn/3RR/+FV7duR1SVZfYDfzob2gNhXQUIaS+MvU1wlOCbhHeNd9kt5mxv7n9a/BpE0kTdO7y+85126FSrbZOEakFo2l7xnjreh1wVOl8ak6PRztyYQPm0PdId+VTG41HZgthpH39ns2X/E/Lb9NmmTulayU+cc2+1bpxje/AAqihmKciXHbJxVmArZ8dtT6Nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by LV2PR12MB5800.namprd12.prod.outlook.com (2603:10b6:408:178::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 13:49:19 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7002.028; Wed, 22 Nov 2023
 13:49:19 +0000
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
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com
Subject: [PATCH v20 08/20] nvme-tcp: Deal with netdevice DOWN events
Date: Wed, 22 Nov 2023 13:48:21 +0000
Message-Id: <20231122134833.20825-9-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122134833.20825-1-aaptel@nvidia.com>
References: <20231122134833.20825-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0047.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::35) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|LV2PR12MB5800:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aa80c16-6b5f-467e-d95c-08dbeb61d37c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D15dYJEElTKCTy+SFKlmEqYhfq6my5FVkBLodTyjgBnWYPUWfK3USU/LMc/InCUm8zP8pcegcaUKGKWtmNuD0TJBE/ypEm0DdIEus/LGut+lsVKEbLMAPvX5zI958zJgKFT/+bK6xy70qAz870U/bIubobGmqwn42wS8hGTF7o7UL2Si53xdsWKTGJ8EnUM8jh3g2pNxTROVIiaR89bC0ip3LNm5Z4iEJgs2cHllm+6wKRs9u6i0nFXMiPsmbVLuqus3bBj7yqEBdJ+b+VcITVi98rMDWddoUBBrAHG8bPb0ikNXbhzIrCrdoGBvRZQJk6qFexKD87YeYZ20l5twZy2dBIzeHqj2zNqwrjUI1b6gG0836ireOPqgCxm16Z9wkkcTHvudbCcILPZxLwCQGiWtoJO8s2zNxsiq1W/UNFT4nnb2HruLkeNjNIJY+t12VdDUHYYuhZ+QfbxQBJu+5OWrUikUJG9BfnOmWFnPsLb0JQiUQifNup/4nPFkYkoOOh9fcvnsyEOsaSgo+ty9iV+dmV5e6Iiq8Bz2LnlYIll7FMy07qX7jgvCV5ndW/dh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(66556008)(66476007)(66946007)(2616005)(38100700002)(36756003)(86362001)(26005)(83380400001)(1076003)(6506007)(6512007)(107886003)(6666004)(7416002)(6486002)(478600001)(2906002)(316002)(5660300002)(8676002)(8936002)(4326008)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aUZ0PYoakBPugKIdEr4hTpAUyR4N0/WPLsTOFwlrPBPox/L8fcDRLtYDrMGP?=
 =?us-ascii?Q?cu/OJPH/ZBr5ZzaBmO2KYstvI/1aHNQSdqID2ZhpueUKPbwxA6bBUi1fScnJ?=
 =?us-ascii?Q?CGtIG7jAluy44JgPfWuoqUgwue3ZnMkoifGfCpULWbxE16mZaJixcuahEZ5l?=
 =?us-ascii?Q?X7IBDrlhMKCzo3UX1FtpDNZoCH2WZd5TXfooe5ffsJu5Wsuy0i+9EgH+9qFZ?=
 =?us-ascii?Q?jrmSvprG1p2ORvymG1k/m/ecj5CnXwV5lHE9r43QJFhveGfmfRcngNzinCIp?=
 =?us-ascii?Q?Sq+5E2qKaXSASRb6BFzvBCwhmAnswPUaOy21BDdCVdpoUQDBgzsE0oQBbaQH?=
 =?us-ascii?Q?mEeW/vB+tozYewvUfnbJQA1It9KFdtFW66CdsYWArGWSQuQm5I8/9U2P1dxW?=
 =?us-ascii?Q?0hYDZYe7akrD1sw0eoZS5JtkhsqLtJpMncahDXKhss9a/4I+svyX1FsVAitM?=
 =?us-ascii?Q?YqO3bUXodRypXA6CvshaU5WbwKtG9zzTZDxcWd5OXTfQ19PnxkSh7KGILKa8?=
 =?us-ascii?Q?TbJRWVj3QC06YxEc+uIGGgeIZHeldjcCVvFUmpaJGu82PfxvRc2/07gUn762?=
 =?us-ascii?Q?Aj3sYZggt6GxpEEo+Y8EMoNnnqxlPLN8Z2c58YOEwLS88n7lqaeDbEcbobyQ?=
 =?us-ascii?Q?87la6TCcDUftOEgBhSyOnECXiKVtTsRp9859SRjZ5Ytvhwk1/XKuZO1Ve54K?=
 =?us-ascii?Q?0CeIxH1lVIXQ5wDPZwH9JrPUMkvreCiPXQItCnrr/b7jYV4tniGSGfH0vqNI?=
 =?us-ascii?Q?ldsxtvYWFbP4ZUOQq6+Dck2d0TmejghqVIvTOxLkjpubj7o1o4lzCb9mUTUO?=
 =?us-ascii?Q?1RYjaAB4Hxlng1T0G2Vz7CP7A8x+tGzp8K96mU0Qp/V5wRI1HrJ6SC1sxG+n?=
 =?us-ascii?Q?qh0H18SYiz60swV5B+30NZe3MKrU5poMNZCMmv4Skwq3OLQSL64HPV+jBwtf?=
 =?us-ascii?Q?sLl9byTfelGXawyWp2WR90xxY2AfkYZB2m28Gwh5j1K5plhXx9w31AzKvEEy?=
 =?us-ascii?Q?GytM+3ZHnpCrvY3Zv9w7IrlLHwGFoWdlCQjhG5JeIIqMcRyMzQzNmQ3/GR4u?=
 =?us-ascii?Q?HJY5WW5bDvBnEstdaTxZR4aKLZim9VFiVSJnVUeDrG4/904NFNgg9m0fGaud?=
 =?us-ascii?Q?ddr1yKDt5Xz+OoFoOm/LsVCcBiYjNisG6VXWNl+lvlS/HoQAHKPrShIAIoy4?=
 =?us-ascii?Q?+KIi/eUAuO2QK02pfOYQCWThG4TUwI47glgv1BEHiKl4PwRcDORHybHAvqMp?=
 =?us-ascii?Q?8xq7Teou9CmYXdOOm7yIDvspt1UI3J70j3UEGJ6LNurq4Dajdn0J/BLp34kl?=
 =?us-ascii?Q?L5zmcAseAbCDL2+/DfoF15J61ioBawcTnFdwIb69onUj0DLUbtVU9saMosuj?=
 =?us-ascii?Q?STbdOODkSm+llcWr0o6eKCuCu/hWPmSDPHzScmO+flVws/KbgM61fmFeAIJB?=
 =?us-ascii?Q?JcX1byk0PwC3SG9QMWWfj+BMGFnf7+618VtkMnnRBTk9IjvtPEIzQIy2rx6U?=
 =?us-ascii?Q?9pehGdr7UHdQ6bw+3KkJZkzKXmw23BUwh068zz1sraUti1qoa1obKxI0zmyi?=
 =?us-ascii?Q?wkjbDvgZm+yALKLY5T9/ZjNHP52TqszuDdTukx2o?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa80c16-6b5f-467e-d95c-08dbeb61d37c
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 13:49:19.7593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g1GwsXcdRm9/BvUz3x4LhfNDkgHXgurNMpcB9Lhyix3URTrcQBLSbGt5iWKer/pUV27vRwJZt7budqlLoaBM0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231122_054927_608565_C69BEB4D 
X-CRM114-Status: GOOD (  19.34  )
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

For ddp setup/teardown and resync, the offloading logic
uses HW resources at the NIC driver such as SQ and CQ.

These resources are destroyed when the netdevice does down
and hence we must stop using them before the NIC driver
destroys them.

Use netdevice notifier for that matter -- offloaded connections
are stopped before the stack continues to call the NIC driver
close ndo.

We use the existing recovery flow which has the advantage
of resuming the offload once the connection is re-set.

This also buys us proper handling for the UNREGISTER event
b/c our offloading starts in the UP state, and down is always
there between up to unregister.

Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 5537f04a62fd..8c98bfcb061a 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -234,6 +234,7 @@ struct nvme_tcp_ctrl {
 
 static LIST_HEAD(nvme_tcp_ctrl_list);
 static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
+static struct notifier_block nvme_tcp_netdevice_nb;
 static struct workqueue_struct *nvme_tcp_wq;
 static const struct blk_mq_ops nvme_tcp_mq_ops;
 static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
@@ -3179,6 +3180,32 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 	return ERR_PTR(ret);
 }
 
+static int nvme_tcp_netdev_event(struct notifier_block *this,
+				 unsigned long event, void *ptr)
+{
+#ifdef CONFIG_ULP_DDP
+	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
+	struct nvme_tcp_ctrl *ctrl;
+
+	switch (event) {
+	case NETDEV_GOING_DOWN:
+		mutex_lock(&nvme_tcp_ctrl_mutex);
+		list_for_each_entry(ctrl, &nvme_tcp_ctrl_list, list) {
+			if (ndev == ctrl->ddp_netdev)
+				nvme_tcp_error_recovery(&ctrl->ctrl);
+		}
+		mutex_unlock(&nvme_tcp_ctrl_mutex);
+		flush_workqueue(nvme_reset_wq);
+		/*
+		 * The associated controllers teardown has completed,
+		 * ddp contexts were also torn down so we should be
+		 * safe to continue...
+		 */
+	}
+#endif
+	return NOTIFY_DONE;
+}
+
 static struct nvmf_transport_ops nvme_tcp_transport = {
 	.name		= "tcp",
 	.module		= THIS_MODULE,
@@ -3194,6 +3221,8 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 
 static int __init nvme_tcp_init_module(void)
 {
+	int ret;
+
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_hdr) != 8);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_cmd_pdu) != 72);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_data_pdu) != 24);
@@ -3208,8 +3237,19 @@ static int __init nvme_tcp_init_module(void)
 	if (!nvme_tcp_wq)
 		return -ENOMEM;
 
+	nvme_tcp_netdevice_nb.notifier_call = nvme_tcp_netdev_event;
+	ret = register_netdevice_notifier(&nvme_tcp_netdevice_nb);
+	if (ret) {
+		pr_err("failed to register netdev notifier\n");
+		goto out_free_workqueue;
+	}
+
 	nvmf_register_transport(&nvme_tcp_transport);
 	return 0;
+
+out_free_workqueue:
+	destroy_workqueue(nvme_tcp_wq);
+	return ret;
 }
 
 static void __exit nvme_tcp_cleanup_module(void)
@@ -3217,6 +3257,7 @@ static void __exit nvme_tcp_cleanup_module(void)
 	struct nvme_tcp_ctrl *ctrl;
 
 	nvmf_unregister_transport(&nvme_tcp_transport);
+	unregister_netdevice_notifier(&nvme_tcp_netdevice_nb);
 
 	mutex_lock(&nvme_tcp_ctrl_mutex);
 	list_for_each_entry(ctrl, &nvme_tcp_ctrl_list, list)
-- 
2.34.1


