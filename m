Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8487CEE49A4
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Aug 2023 15:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+YAVYYrNOzV3VJ/1kyMjLXjkap5AgYG/HNPB/prT8Ik=; b=jXVMra6OSPNYGMQdKuRRQoTbQE
	w/y3y3SC1MPltBLh9MFUoywJZBYJdlre8gSDxh4/m6jtCHz9etoCzYLNY19m2+zWJB+slR7fK2vMO
	8bTQdOGvlxN9cAk1eyCdTrAB3LgNlkK+o3KX/AyX3IDyTuyDkhR0tlJ28fQQEigiCZbWd/hOtgl25
	u/YUcuqTKJcmdHL16Ig1sTqPrsdeHirydGU3okeTBInpWmlefxP9VmkBTXWAJD3ZjWjhpsNDVBtes
	zfEcWa8+hpWej/2smuYWtus3ITmf+TPMICt2sz/3L6wF+PFItN92e7vwzeoXmD2IBY1ZDFMjMyNOi
	PFREXuvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qYSx6-00GIVZ-2X;
	Tue, 22 Aug 2023 15:05:52 +0000
Received: from mail-dm6nam12on2061e.outbound.protection.outlook.com ([2a01:111:f400:fe59::61e] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qYSx3-00GIP5-2N
	for linux-nvme@lists.infradead.org;
	Tue, 22 Aug 2023 15:05:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWQ5+vlYjyQIFkYAE+xqib9AiqUX+JpzhkyrN34L9mmmy0pRc8K/4nWMcGz2AfjnNSe+kudrRYQFgUcgncSa0DXa//oq8mBtrQYze3DS809duT8/BqKryKWDsRi7uPkDI4Gqbab0QxSAa1bgU1S5NzNAgVvBBLibdqaPqCxAXw94L7561GWFv+jYeGtkYOYh/rC6GubL3gOOFg96Jtwitoh8Re8/cyKcH5ZwTcHG6PbbCFPIzu0Bz/2/MgibzQLkwmf9JKnz/Z2zgpkmVM5eBcTZo0neyxNkOMvJxXdJJapnFnKCf5RuQe42aNyObq5jsY9hKXavveD6h69MtulFzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YAVYYrNOzV3VJ/1kyMjLXjkap5AgYG/HNPB/prT8Ik=;
 b=lqFvZkFG+RWJs9BRW96+M6sZHw6lS+X/Zw/VYGLkHJUmFUnoIri/7k6AiZlwYtoFbZCSCOkqhRstKrnWsppAcJTFBclMAKRXMJmumAgXEeiaEoHD8cvQnEXGpRmayv2YLjax+Ep6zfhRGWBEmCJEZorki2pPux+/I4WlkF27/HKO5lPhy0YfTtIXQRkUxaKjC5m1tux/zi/zbjsp1CYbuMVv4kDlLXzUTfJSYTlEl/M4eyiJbtY2Dazl1Ymcum6DF9l1kpCkHrhO34KfO3L/fXCpy7DyndcSvUtZcwYirFUnSEtQ/oy4TgAVlDyPnnGgPsA8+sFVAJAe5mYn/uDF+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YAVYYrNOzV3VJ/1kyMjLXjkap5AgYG/HNPB/prT8Ik=;
 b=Ju8khgWZAgkAvhKxuYK5AGVI43Fmrj5MA49asr6C2T5X088wcT6fx1nrm1rQP4rg/r2AqqmaNciZ0oQaFojluo/jolnZgRoL4lkVlJaharh21grEOwkTvN2q+a7ILB1OEIN/LI/GKw8p2Uw2uzVhst/tRrxhaHKisqEC2LmqESHbdbRzIpondtaDFhc5Nn06YJpYl9DaO9lf79hbjP1gtmkmc9Mh1KPxpXnycdJ4T4kXvO5R9VSdzQkQb46a0i3KQ3ze06PtzFaa4J3hVPZGqcnuhaoJYYFCKMt+Q3ze/Bo9pYHAHcoBUDh53y8oY14l1BXBzA3uz4hxfh1/b522Sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 15:05:45 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 15:05:44 +0000
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
Subject: [PATCH v13 10/24] nvme-tcp: Deal with netdevice DOWN events
Date: Tue, 22 Aug 2023 15:04:11 +0000
Message-Id: <20230822150425.3390-11-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822150425.3390-1-aaptel@nvidia.com>
References: <20230822150425.3390-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::19) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|BY5PR12MB4322:EE_
X-MS-Office365-Filtering-Correlation-Id: 295e75f8-d1ff-4512-75a8-08dba321425e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gnl9VRBY47XKRq08uTSa14MhV4VbMjRM2z/50+5KH2aLk84b+66WI1M5TGbP6GzCnZYvZCJRhET9XWqBadTLITvSUCTVQp3xh1kLiqwxWr4W/1l3M3V6HG7GKVXMwdAMgmFwo3sYEB1N0SmVdwwVehaPVxCcGN7jXL9f8ux5NgWiUFoeQ1kz+MPIOuLvJ6WmZcvD1Sh6lxX+YpjlVovoK7NfTDAOHOX1U5NXMfDWtRTr0vUh6yTGxSLhY4fXX05dESmVw/9NTNY3XmAhMiXBMcjPXGyFh1vxbOxcx4vzAgdR5nf0MCF5laLIcVY+2SdXtXN2yJ9fNUHQNZd7jdiykmicXep8bRhmD5P3Hrd57QuzhY28XJiIYf20pV9GBa02Dg40r6eqTcXat1eVrmmI6bSZqRddu7p6CjBMUn6qjDaVnHuFOobaJ+gqYL9Hl/+E3NUTXtoOzUujMwFAkVvkJr+llf4Mde6egCxtYJfdLtshoQVfpFFvP3JFTseWH7PR6GVZ0CNNlRaqXEZ6UjE8f6qGok6nzNDs8L/uHyxGPGunQLb97iLgW58nyrYKlwvE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(186009)(1800799009)(451199024)(66556008)(66476007)(6512007)(316002)(2616005)(8676002)(8936002)(4326008)(107886003)(41300700001)(36756003)(1076003)(478600001)(6666004)(66946007)(38100700002)(6506007)(6486002)(83380400001)(2906002)(7416002)(5660300002)(86362001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B5+bfqRehSuqbOtiVc54qxkLsi4V3I1/1JOAn5dHIz+OwBoboLEo8aqyLGiI?=
 =?us-ascii?Q?9YrXQb208g3N6vfvT9hQg60Z+JpQ9sV0ox4Q645vcDLZobK+AhDYJwBTvk5h?=
 =?us-ascii?Q?oEVDCjN1AtPxFGW7yB/norOMsh5ZG18CfAOJa6S/vmTL4jiaHGPteFVjGCtM?=
 =?us-ascii?Q?lHW+BelXZx4fhzmJgRd7VHlUqBDIv+nx9X9ayDf2uZANVw9TY8atC5dvMggn?=
 =?us-ascii?Q?wA0nig/tjzbUP99hENNl4y5OjfONX0N3kRMkTpXtcBTNmLvuLXV7WmvxoFv5?=
 =?us-ascii?Q?xOCYHoQmZ3Vr0cbG+IMHuVjGp6x5T0NFEmeZ1zPeVvrOW/w0BDSHvmEWScUC?=
 =?us-ascii?Q?JBoMkG0SwzduQB4CX5x9y0VtclakI8mFrxi9PNd9R55DtlMqv43sp30/LFpU?=
 =?us-ascii?Q?l9KxGETzDEJl5N8JPjPbXl83CAGKu6qM+GnhqiwyEyRhqfOI/5pmyhVNGy01?=
 =?us-ascii?Q?Bz67qh7tahXMpT/yz/7cw8S2VFrMNDC1Oye3eGtUn8f+qLJXhJ5DWn5jVurd?=
 =?us-ascii?Q?bOY/xRPFAzDN6JR+TdqK3IFWKH1AIqFYTRggfZ+tfgpWr9ZiQqLcVbLAY+O6?=
 =?us-ascii?Q?IrICI2Yac3utxHnLwUU1fcJ/MXeMSA8XFgJ+RlWbQ35c73uz5WWAT40OFs4Q?=
 =?us-ascii?Q?ybWohj6K9EdLoN5CgqD22o/d2z/HfcMrNNTWO6c2hiWd1aKHYZjeMarSiS8+?=
 =?us-ascii?Q?3q3GKbNJ6a/mhOyWwsrtH1u9AYxoL1y1Z9iTcrY5gaO3ub6kQ5e6RBLGd178?=
 =?us-ascii?Q?HjfT9B7tlhxDdgVUE9oyVSu3mUdb46dUBft5OO2JFvh6khCMuDyEXfigf1WM?=
 =?us-ascii?Q?OmiamBWfbOfS7wpxZ1+IiiQpLdcV5W2uH/jSdxxHZzaLw9T9KCCcvh7K1V0/?=
 =?us-ascii?Q?Cz6Wg31F450sbyRiS8QTpqCdLg7K8VcWaapYaIWpTpzMeR38myDflQu0Qf30?=
 =?us-ascii?Q?ydzmwLDVtNdHha8RrMK2UzTER7Yi2DaPPgwdjMqjVkT0Pp0VFMdKQvd3wLkA?=
 =?us-ascii?Q?DlaWOzXznRZYyRjF1N8MHSensOAIYczNIIERA3YHYDHsDNjNkY6Hgyd1pcPu?=
 =?us-ascii?Q?NzIvh+0yNwhv0zuCH1ySFEFxaiCIdP56KKDleQiAfoOr/g4wfFzBQ9WSyH/c?=
 =?us-ascii?Q?zL4HMQ+vno/uPpm5XJJnrBGxq604git48qyMYKIFhMVljhwq1S5Qs3p4sfZ5?=
 =?us-ascii?Q?X0xECMDi1kbbNIkRp3KAtNQwlUXrObOJZ8IraX33+fuVGwtdByyDEacFJIUi?=
 =?us-ascii?Q?L9pyCeIlitKrxTLgngCoazl/846jKVZxp9C1BW+QDXS3GIxDEg+q3JvndmUW?=
 =?us-ascii?Q?6B9M605pNBS/n5Rox9TqtuACtMt9ImbrkUijYFOvGMsvh6IxCWOaNEtbavtF?=
 =?us-ascii?Q?BhMMdgT/zTn6v6Y+WaIPS/UU0tpsBzYWZhm24LT3tO+u0hFDZ6f0Eo0Qnc/i?=
 =?us-ascii?Q?aHgzx5DXOzvGwfVetbUv4eBwr5lqsSze259QK+P9Sxe7+uh1HQMzQi7CGKY9?=
 =?us-ascii?Q?f5SzKlteKpcizLlumFa5lrAwMnbLL41wI9/fpgvlyhGXS/2GdyRDklnD57WE?=
 =?us-ascii?Q?zQj05mQBXWwPlJJXt8OePE1PgcD6BUleAgKfVYeE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 295e75f8-d1ff-4512-75a8-08dba321425e
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 15:05:44.8508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yNcORiQMtA3ZBNUe1zqwB5TBLU74WJkIgcDLaK1B179tOHSvXftsh1cfkQhnAneea3SQBZS0aWx6PoRxkhlvjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4322
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230822_080549_785052_52E6AC1B 
X-CRM114-Status: GOOD (  19.40  )
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
index 9253cc826571..b187cd36e016 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -234,6 +234,7 @@ struct nvme_tcp_ctrl {
 
 static LIST_HEAD(nvme_tcp_ctrl_list);
 static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
+static struct notifier_block nvme_tcp_netdevice_nb;
 static struct workqueue_struct *nvme_tcp_wq;
 static const struct blk_mq_ops nvme_tcp_mq_ops;
 static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
@@ -3155,6 +3156,32 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
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
@@ -3170,6 +3197,8 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 
 static int __init nvme_tcp_init_module(void)
 {
+	int ret;
+
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_hdr) != 8);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_cmd_pdu) != 72);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_data_pdu) != 24);
@@ -3184,8 +3213,19 @@ static int __init nvme_tcp_init_module(void)
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
@@ -3193,6 +3233,7 @@ static void __exit nvme_tcp_cleanup_module(void)
 	struct nvme_tcp_ctrl *ctrl;
 
 	nvmf_unregister_transport(&nvme_tcp_transport);
+	unregister_netdevice_notifier(&nvme_tcp_netdevice_nb);
 
 	mutex_lock(&nvme_tcp_ctrl_mutex);
 	list_for_each_entry(ctrl, &nvme_tcp_ctrl_list, list)
-- 
2.34.1


