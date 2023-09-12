Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C305CA0ECA
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Sep 2023 10:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9SeRurJDyKfEy7JoaTW7sxb2/1v75sWjYNEQ6Kye2qs=; b=tye43pRFRXokNcFYalDM7EgjCD
	z96KEoDMN5b8257Q59/z7/g5GoON7lA54CbI8s2KfmC0jTAavC/TbnYJz2oOzcAuRjUgP1oLMFZzS
	HivCyX5ITUQKpDTs0SgRNldZIodbOFk+8P28OjdgHXnnDHsOT9jYktoF+SdE8h+9pC/clZk33lxB+
	KE28ilMBmcMZb5v4q5G0c8nXwdk4ZAa9RAPHlbyB6+s5YTlxEHdmBownjyXIJUnFvcicU7ZehDDj5
	AI7vdzuZok7UuchK6D9Gr4G/f4ZlGMf3XgXDte9cJMD7Nl09ToxutgYmniW1umSSdU2vD/R3FX6Fk
	/6IHCoQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qg0Ch-002pfx-2W;
	Tue, 12 Sep 2023 10:01:07 +0000
Received: from mail-dm6nam11on20608.outbound.protection.outlook.com ([2a01:111:f400:7eaa::608] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qg0Cb-002pci-3C
	for linux-nvme@lists.infradead.org;
	Tue, 12 Sep 2023 10:01:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OiBKCVq3lFoNOB4VM4fxz/ZXSWje2vJfcMWH7TIKn90ujXx1UvKCpdCgZ8vLSWHhDNYfOOJY7sIDK/GbeU/BA/ES2J7sT3LltnG9jK0MRkIhWDMdAOflfJ4AVTjAgxFpHxFbFfRN4qvWUUQ9krHHaLojcCMkuzEnAiIKkVqQ3PM2SgjBNhC6AwqeCS+720FnQdethSULk3sIugWd/RdvI16RUsGzEBRbDaSBlJzxfZPkX+7y3mquTcuNwnJ4IuPocDqiGxdzulhKNe2VP3qy0slZt6C7IMuo4dXWkGG3fzyr6NBZ44NFH9vdAg1Jmibh1zPmS/vdcclm5l9Q0nQ+/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9SeRurJDyKfEy7JoaTW7sxb2/1v75sWjYNEQ6Kye2qs=;
 b=ZhodeuGYoE8/5Pa5Oiy3Ll4CO6yl4o8bIBLnUa3vfmEr6kmsAOzrjgg3zUl3cRxmXbMw9EJDHFQ1eFmZXxJQq9sELmKYYkrXGl6FTqdu9bH+UqEuACJBKpCmJYZCBlEneo0ajAB36S9c/itLCnLLDLqRtOWyLgtBYbEy0ge1SPqz6Q2eJBVwU+8f+ir3f38CWD1bNQLPOsVs9zFZM1VAwXrcGGFIDVp2F22QvLXjVjxhTGtZtCo44XOnV5U4DyhAxcb8SCxuQSEd0poK4evJIuk+bvWedK3mXKiOuE6AiLOl5sqovC27Cb1sCTnllaTSrQ+EJywllqoMJIc0V5U/DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9SeRurJDyKfEy7JoaTW7sxb2/1v75sWjYNEQ6Kye2qs=;
 b=bWdftuecBvmo36zvWY0wc1+4+JVpfkOmvGJzWu9jhe/reYVCfmf6e1R/jnSbts4R0VZ6NQLws2Gzf41Svq19r5J7NWWOphLkmF+098w83xVnYgjYwwH/CRXS3wABIovJKqwQXImrBqEenJYHdenyZFGRADUMfayuDklDJYFdX0qfZbZxLQHEgrtIi32Ax21W4aiE1/06s6F+QVvYP5dl+3ev5g8Q9/XQhQVRmRo6kGhlXLvLpyM/FTJ5y3ZzS7gEpFgKXd6SMjoRfELNrQWm8FpCQwuIhxJV4RCG+bJ6ePaj6ofidkbw3Md/pnyYZNkxlJIRuC/a0hUhxXgZ9DQNzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6069.namprd12.prod.outlook.com (2603:10b6:8:9f::13) by
 BN9PR12MB5034.namprd12.prod.outlook.com (2603:10b6:408:104::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 10:00:58 +0000
Received: from DS7PR12MB6069.namprd12.prod.outlook.com
 ([fe80::8ce3:c3f6:fc3a:addb]) by DS7PR12MB6069.namprd12.prod.outlook.com
 ([fe80::8ce3:c3f6:fc3a:addb%5]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 10:00:58 +0000
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
Subject: [PATCH v15 08/20] nvme-tcp: Deal with netdevice DOWN events
Date: Tue, 12 Sep 2023 09:59:37 +0000
Message-Id: <20230912095949.5474-9-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912095949.5474-1-aaptel@nvidia.com>
References: <20230912095949.5474-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0110.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::20) To DS7PR12MB6069.namprd12.prod.outlook.com
 (2603:10b6:8:9f::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6069:EE_|BN9PR12MB5034:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a8f539d-5aee-47b2-e6fa-08dbb3772956
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DqGGJ3jgna/78ffAXNQmpr/tiw+m1Nkwmuf/gY7zkeXMUZMYOT72d/KR5ui7uhTtFTjNuHKsr2719YTIQ6mnPDuxJunuh3NSjuv0LKM5vB8N0YyrqyknpY4ADcU+TDp9M1Hn3t4L82qx1y6A/TNQMs390eFs6ZopykRVvis7NxAxnQT78Ls4EKAM3ys1ZU9UMR+AUVcnGYmxz/G65SmaBv09cmW4jaLMhtemQJ3DLwO0oze98L8RpOx2SOW0TpQDEHf/f+xuolckByALhV8mOYcnBAd4ipFkIwGY6RxSL5pWe9pSDPb1DPk2Zo0dOhKYF1KmLkfkHDThouZTSkmXYVlAmkcFFyuoGdHEVbAN7m5KNEZigR0dDZlmj/tlGiya/PfPOmY+V2/zt2wYxSoCjizKPF7DVj7bYXWiKbj0JFoY648N6JoX8c0QRSCK6RgWHteWSNy+/1B9xHkV79+esYYcirEO/z1zDhbL7qP5ZcFOh9kRbpOzs5+ZQc3s6PgZtabM6FdW85hdLGRD7YxOgtEckZb6s+Ba9d5TRjguRlDTz1DyeLK7O6klebI07FPn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6069.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(376002)(136003)(396003)(1800799009)(186009)(451199024)(1076003)(26005)(107886003)(86362001)(83380400001)(2616005)(6486002)(6506007)(2906002)(6666004)(7416002)(6512007)(38100700002)(36756003)(478600001)(4326008)(5660300002)(8676002)(8936002)(66476007)(66556008)(316002)(66946007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TVUKGto+vnY0Nap5BObGjMolHJQ8eaeO8xg80ibS4LwtOyS5YgQiayAvxiqp?=
 =?us-ascii?Q?WKC1BD/FCo/OB1Ev7FC9/Rnnn2E1Xf0VEguL8FIPKxMmJC38nnx8RgdcnEoK?=
 =?us-ascii?Q?sHpDrqxUx1DQ5OPSHJLci0022xR7AtsQldjssSbcfKo3Qc1aIoPcXA0mwMlm?=
 =?us-ascii?Q?lz/pNUJ5GF7T332g0FEa/iX2cWqqpRkSu9Ngz2CFncFnxIdJlZGCTDksn0hF?=
 =?us-ascii?Q?qChq21JrAI1+DMLhMg21k36pErxlY5GD5ZQVUOzGINnAU8/vIF11BVHMn+hl?=
 =?us-ascii?Q?uUWRdl1au4G3pT5p5VIbEl3DvGLhS3fvbclpKbqEqOZDvhYmSJ7LN/qNHKlH?=
 =?us-ascii?Q?nNqwBNZ4tqPWQ4RKqdYGiHtEr7dEls1yjgNHZJRa3NZpDgsCGwLfXgdMkM/4?=
 =?us-ascii?Q?uifm7wqJzT3LvtxO56Os2nzp1ER/i9Ts8B5NsAtkFwrtOpgF6YwKBQPDtxzz?=
 =?us-ascii?Q?zWPpiwNKFq/4paIntSbShzVQYcSH6/ksYwHXB9xtKWNW3w6384qJNsCuDVkX?=
 =?us-ascii?Q?0XQ79SgHajF3wOoajjF5i6JG2XzQnQpkwJNLRYVwgKZ4LwCYAYf8V9JZh9WI?=
 =?us-ascii?Q?H1FKPCTHQotwhuYspT7RYRWZ7AvSsNjLbQldXH8CJs525mVNhJXYTgojtOch?=
 =?us-ascii?Q?vbmp49/324EwV2A3fcq4VFYopkDEze3bF0kGJS0Q6o3zCwz+DdE5UDmRU8vz?=
 =?us-ascii?Q?WcAp+qyq5f55P6ERESiTpjOtgtrsMQrfeFPX13XkzvRmPjPYtrXqDGStsL+O?=
 =?us-ascii?Q?UhG/e3PUIZb3FAbnVWnDnMfgvGf4SuRW+PTbQGgggIqO4AZVOU0EwCittp1y?=
 =?us-ascii?Q?fxK0XaMSovHwcSeb3eO+pLWXJkumjcHKd1oOPkzVCom7hdRAv0qL2Ol/81mx?=
 =?us-ascii?Q?9IJu1ZNX8kovjzZV2f/DE6TJ00t77gbiZObxB2kl1HvoWbYlDpwxI+ztTYhJ?=
 =?us-ascii?Q?0k++GeyiIHbPZJHKOity9owmzecUr/gOPqCkQgLTfnM9yVDlqyLuZuZvPyym?=
 =?us-ascii?Q?1mE6jQKqQHOM3ciqTIZ09JxW557FXfw8DEVtCj2fRfDNt+H2xHvPn9SawXHz?=
 =?us-ascii?Q?5Mh5cpRGDgphc0PSd3PXsXXlDhDF+Sadq86rxyy1l2e61wINkn3bDnsGnqt2?=
 =?us-ascii?Q?gGbq0SA7bxCEOfz9VijwAzLIpeiRJJQCQly6A3eNYqat2fjBoKFDkaE/t/ZL?=
 =?us-ascii?Q?grOcpVuXq3rUo5fVjJSGKbG8NYsLqQQcB4I2uLVwEW51T+U9ydUyfujkLauz?=
 =?us-ascii?Q?GRLCZ3dRI8jJI+MtjIZz2Q1Svv4uSGHLBT6ulmgsnSG7Eq3crUHFr6NrTHRJ?=
 =?us-ascii?Q?M6pZossBj2lY7qzsdpRnmrVyiHHuXWIzLMnaCvmzs9fq72EMg44P1GWyOY6z?=
 =?us-ascii?Q?fvlUrg4siekZVUTwSdVb5HdrHsR9PTuTSNLp/shNbDU+njc8xPEuaOYE+Iwp?=
 =?us-ascii?Q?wN30lyB4x+dzujgPV8UoW8N+84dVxn5pZ4GExPO2gnEZY7EEmkNUkZmUP3EB?=
 =?us-ascii?Q?UaG8PZ77O8iKH1ZoZ0ogtbztJqyICTEC61mSVk4VulN5wkAor7y9gcIsbB4E?=
 =?us-ascii?Q?KyazLO0xWKeMqjYL0Ot1sjkVXFtreCFWv9M/HXR/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8f539d-5aee-47b2-e6fa-08dbb3772956
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6069.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 10:00:58.0411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hwrF9lx0JLLKp/W69zc1tDvxxBRmdmMos7QGX7fI2bNlTmNdgMkUUbBGnCj3rAQ/DcAVHTjtD1OfDh63EqKe8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5034
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_030104_696535_AA50A4BD 
X-CRM114-Status: GOOD (  19.49  )
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
index 6c7edbb78354..7f2e92d07fa3 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -216,6 +216,7 @@ struct nvme_tcp_ctrl {
 
 static LIST_HEAD(nvme_tcp_ctrl_list);
 static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
+static struct notifier_block nvme_tcp_netdevice_nb;
 static struct workqueue_struct *nvme_tcp_wq;
 static const struct blk_mq_ops nvme_tcp_mq_ops;
 static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
@@ -2996,6 +2997,32 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
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
@@ -3010,6 +3037,8 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 
 static int __init nvme_tcp_init_module(void)
 {
+	int ret;
+
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_hdr) != 8);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_cmd_pdu) != 72);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_data_pdu) != 24);
@@ -3024,8 +3053,19 @@ static int __init nvme_tcp_init_module(void)
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
@@ -3033,6 +3073,7 @@ static void __exit nvme_tcp_cleanup_module(void)
 	struct nvme_tcp_ctrl *ctrl;
 
 	nvmf_unregister_transport(&nvme_tcp_transport);
+	unregister_netdevice_notifier(&nvme_tcp_netdevice_nb);
 
 	mutex_lock(&nvme_tcp_ctrl_mutex);
 	list_for_each_entry(ctrl, &nvme_tcp_ctrl_list, list)
-- 
2.34.1


