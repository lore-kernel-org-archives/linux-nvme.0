Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97681C61DA4
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Feb 2023 13:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u8hQlm38ob57LZCfpyEknEa7+Pk/gayTbza+DuQqxvA=; b=dUTYR56+8IkR6IejvxzgeRnbjN
	NvNIN/19PFoc2Hmb4qPyN8S+oa1Mlw79xaPuJVKOeYjIznv2yeTGL3VdMQtvD0DFMnxLoJyBG5dq5
	x3zoa+upm3UQHaKkeO3vetgHOX43OP4l/vROH4HcorT/V492K0zVQZTpv017YinktOOqBoQYdQmeH
	C2JbEvC6QKQ/BY1dbxO7Cul/kPryZRThMsVpwn2pE2m2wbvEkX1ak1Ix9ChtmHmlX1jJsnetnW0Wq
	1rydwt8ND6xNYiCCtGqKyQuKvDygMHirdftAVZPIsP72cq4EgrX53OrNjFW96iH94wXIuHVhq9VX9
	PTe0e1VA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNw8S-00236m-6o; Fri, 03 Feb 2023 13:29:48 +0000
Received: from mail-mw2nam10on20625.outbound.protection.outlook.com ([2a01:111:f400:7e89::625] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNw7E-0022Z6-Iy
	for linux-nvme@lists.infradead.org; Fri, 03 Feb 2023 13:28:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KI0u7NiHJD8NOsks3pHW9WDI8J+DcEs7snSbanKh5J3hV6TpDYDz7OtzBwkWcx/D/ujcWY7GV+M4Vq/LM8ejlJY6EX+HcrML2fDlfmr8wnatycFDgmgp1nbbgKp7wJYFTdBG7HkW4FkqdrVLNmUNX+fGitHmb0UQ9ezcvEBeu2lLp5lVyMVXNcVIQlKePZTp90z/2PBGtO7pnR9KuJ0ky1qI3TiiXQ5fB/EZLYI3UEqEr49PDhnzmRfflpi61Tts7z0ug1dah0576C3SQRH8CNzd9ilkb6ResRjv3TQnqAZf7ehpQWmPEKIYCG24mK/30WKTVWUkMxOPr1O54bbvWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8hQlm38ob57LZCfpyEknEa7+Pk/gayTbza+DuQqxvA=;
 b=T+x+X6fuKJrayLWRGlIwTWtP9j1uQXetJ7lAIulE8A6403ObY6dSa9zo/I6am972g5LDlVVc5Plm4Uvv1DPSsEx61sVp9cl8mWSYvjVqUIl86c6xsb8IqDrznRfJXztt7MReX4HFLkEhTJlI8NTJvk5txZ9LeWbL1dnAJQH3xz56Hv0t+lmQXYpEP/LE71Us6Xp7F+8mcalgSU/XYzLjXEWk65NKo1gwx+CZFSuAYH3zCX7oTlFXUwNK/J290a/gcqEPugPouHjKNgH9Re1ZM2v8XOVCJPWKNmcxieiOSDGcHEegtrQsXtAKBVq23kMXSHOAADn4DAqfn7Ll5Hj+ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8hQlm38ob57LZCfpyEknEa7+Pk/gayTbza+DuQqxvA=;
 b=UmdLWUmwOJ0dSD9Td68mCjsAJyA8IErX0URogifIxEt/KtlR0DmUwEqKLxpn02G6Hcyj9tIkMDjHoCypAEd9JaqlaEvZ4CPWnDSdaKmeueCTkSe2oGZrQwmXQpblQKbSYu9vV2aLjn3HfBrxMcA+h1aRzu3f3vDydxnOE6V6h6Im8lZJYzeHoJTZt34JpFnIsO7UXlwL5oJiLr/TD/FvJIK6lSxgr9Chv9P6Yq6PD4uXE1TEtDF66HENeFLUpk/7I2JxgK1RhMyuQYmuBMSNiWon0e47b8yaGE45hpcqDXcwU3ydynR/hGFPteQjJic+e7Pa5ZrpLfLxN6SwWEvQZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by MW3PR12MB4476.namprd12.prod.outlook.com (2603:10b6:303:2d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Fri, 3 Feb
 2023 13:28:27 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::9fd9:dadc:4d8a:2d84]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::9fd9:dadc:4d8a:2d84%4]) with mapi id 15.20.6064.027; Fri, 3 Feb 2023
 13:28:27 +0000
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
Subject: [PATCH v11 10/25] nvme-tcp: Deal with netdevice DOWN events
Date: Fri,  3 Feb 2023 15:26:50 +0200
Message-Id: <20230203132705.627232-11-aaptel@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230203132705.627232-1-aaptel@nvidia.com>
References: <20230203132705.627232-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0379.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::31) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|MW3PR12MB4476:EE_
X-MS-Office365-Filtering-Correlation-Id: 68c2161e-3a52-4098-4b2d-08db05ea889c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	kVfXP8gw3sqCvXzmg96Mq5RxshWSvGo3eEjAS87Hgn6agWt7FjNt9Ug8041a37gaG4F9kzboQlK1P6zNqlPSO/9gZclIPLwnInBgjna+XsL7TszROe+HdZnnszEGcm0HwoURNtQH59HGgYwVr8ivNwN/CfZ2wk6qfPrYhOm8HWPy8qg6e6oGD1aIN8qKghjdmL4CYBixcFOtoVVAr9Oxc0EyyUGOGzUtmMbPcvjHS8yearHsyClQShvw+7+EIZvitqvu+AZ1UXDdmUopk0uw4AFLXDT8FdmLpSHffoBsCE9UAWt0X33BBSlu4POqORrpqjc5Hq1vi+4MsQ91kxUr32YP481/+TI37fBH+roBj+KRUEWKS7nFH0GtEebVY47NjxcVSjr2sIkyMOYJu6GgFOu5P1UzyQkPjBKkHkPjyUnaIbmYFtLWlC2ihF/qFWf7VeJc2fE4nvOFkUi5Kun4sxJxX0loXsobh0yqkVdJq9b6Pi2ipe7xqPTmQ8FYZlN/BUllHu2/p97DZQJQt/dBn571fhB3GTyFgP0g4IFD8uPAAzel7bbllE7eSthgPYk15PZ/Z7iWaTe1lTMQ/0/IlEBcLd4xDr7GLv51G5H8KfEVExqRAFIiI9zcRqjMcjEHoLsOgR59or5CinsQlWYSQQ==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(346002)(396003)(136003)(366004)(451199018)(186003)(6512007)(38100700002)(1076003)(6506007)(83380400001)(36756003)(2906002)(26005)(7416002)(478600001)(6666004)(6486002)(107886003)(86362001)(41300700001)(66476007)(66556008)(8676002)(2616005)(316002)(4326008)(66946007)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?AlVH2UMGDVig7KAdr2Iol43y4VAx8rUPYe6UhCeAjYJYkaAL2Pggyw+wu9iL?=
 =?us-ascii?Q?lcfF1x94rx23jGjiKVs3s0tG2CtQ4syfTaXJz3ss0x6gZCzofyHQt61SzJpQ?=
 =?us-ascii?Q?OLujcHPuuM032JHiycjjDUxNJkvTlXaJam7BhhG8XoUtn7tTmMAyFsrZdQnw?=
 =?us-ascii?Q?t+dQMMxsd38+LNXRq3tAQZZq1iVrwpbyvrP8uwECx3C+OCDBFkeP6tsq7w7y?=
 =?us-ascii?Q?FJ2a8CMX4ACMHM3EkFZ3GP6Ik1kqnlMae0P+n/xU7Jf4OEtxCH1HLPFc3mh2?=
 =?us-ascii?Q?Nl+saexHo7VRqN0K4ib9oVeauA4EHAUEetLPZ6iMD+mBftcykxhZGUFF+IdV?=
 =?us-ascii?Q?7FRLrIOJlGVmsDnQy3FzjatsHRGdZmUM7gnyxiWFB6YD7ZxlQIuqsgjy+ohQ?=
 =?us-ascii?Q?RRUKknqlP6RLGD0EgCJHJQjdPIhruGHKNwp+VTukwGsDgE3t/BhSpPI60nUc?=
 =?us-ascii?Q?Mw1KneQ4GQfvcslNT92SEaOBPgjn7UkOXN6flH7rQwkuSPLTtK2IqspXJUyt?=
 =?us-ascii?Q?3iHH7fgLMa3sRmrA+C0YNMU6eZ6vDFwL8o/KwjlUslTBhgWzr9m0LG//0e7S?=
 =?us-ascii?Q?bCe2Mewbc8G5idBn6bCgMcSL0IKhBwMqgX287U5JOXSLhdbJnOq5Xw0uhYtl?=
 =?us-ascii?Q?/Ej3tiUUIQoUxjUOcQkHjwvwlys7lQceRaug21n4d2rhtj6fHJo3lS+buAe9?=
 =?us-ascii?Q?bqca02k0kwZIGFvQ5IW46qQodeBbHpkEnTB0rlrhV1qV6sGXjSmL+Qv+QjBQ?=
 =?us-ascii?Q?YvsDFyXFhL11yeVp1HXSfu0VTaZD9GHc9bYppZw9pYr81vknEh/ek2iaFHJX?=
 =?us-ascii?Q?yiazwJAy7zQQ5KYM5M47S/2RqMUJm9z64rbpzTHRbrOmfHzSVS4KX2NMJd9o?=
 =?us-ascii?Q?RJPvwXTOdFaG8T24AfM/wnrQS4DHZ2kAlGUZlUcrEMY+sSp2NmQvyoFbsPx8?=
 =?us-ascii?Q?Itnrp8C+KwWh4geCt0c7ztuo96j5FrqIAm1ACfxYVX+QZgBiJiKVYz9t4iKd?=
 =?us-ascii?Q?2XhbMUbnj88FAkXG/ShuPcUm0sQAyYXhN+4ioEl2Q1nhApW7IwhfnNuy3UwY?=
 =?us-ascii?Q?aZbJ/pJfcx2PIP+4pwjAtjbqcXBYj4vWlE9HKmoxotxr8GAabK7jdihdXAAD?=
 =?us-ascii?Q?W+L6T2EV2h/ZdFOk5qtIIu1Sc5gREa+8b9io7etxzhRDqaNBbtXoKWVrWIZp?=
 =?us-ascii?Q?byX5z4tBBbeI5WgPsEEhG3zCY9rrGRBcDcAyA5b+7IFTVPFPtNKZN5Vaq3nl?=
 =?us-ascii?Q?lY9rfDIJiMc5PQ4xVS34/0zreTOM5o/PykG18UkB+ie8OX8t3BwmWlhd5M1d?=
 =?us-ascii?Q?getTA637siXap2P/fGUFk4S55xKJ87EjRpXL9Z7IoszmoXZpQODT5uBZKg/p?=
 =?us-ascii?Q?jLn4eZwqZYcpf+k6L+KT7PwFm5gNMqQMTafmt7fDE802ZZCqtLbD5xViyLZe?=
 =?us-ascii?Q?zWmRuyHQdpbGJSSNgXf8BiXraHtP5avhzjgM93mX8bRGa3p4ayp2XN4yvC7G?=
 =?us-ascii?Q?fLgk3NUhzb6dgRdTnahg7vb89clG/RGBdAbfHAuW0vxApwkSZExkQyY6+L3N?=
 =?us-ascii?Q?BruXv9t1yUAOMOet72Y5pvMUux0GJ8BcB5+1Ly0C?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c2161e-3a52-4098-4b2d-08db05ea889c
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 13:28:27.6737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2FW/FXjvcxMxij4vZZTOkHe/aI7My6h2Rtne6YPtYHMoUOcWWkGV4Mw8TxkLGH49qxOG99NFC3z6o0hYLcl1nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4476
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230203_052832_691647_CBD5FCE2 
X-CRM114-Status: GOOD (  18.19  )
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
---
 drivers/nvme/host/tcp.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 7e3feb694e46..732f7636a6fc 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -204,6 +204,7 @@ struct nvme_tcp_ctrl {
 
 static LIST_HEAD(nvme_tcp_ctrl_list);
 static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
+static struct notifier_block nvme_tcp_netdevice_nb;
 static struct workqueue_struct *nvme_tcp_wq;
 static const struct blk_mq_ops nvme_tcp_mq_ops;
 static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
@@ -3129,6 +3130,31 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 	return ERR_PTR(ret);
 }
 
+static int nvme_tcp_netdev_event(struct notifier_block *this,
+				 unsigned long event, void *ptr)
+{
+	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
+	struct nvme_tcp_ctrl *ctrl;
+
+	switch (event) {
+	case NETDEV_GOING_DOWN:
+		mutex_lock(&nvme_tcp_ctrl_mutex);
+		list_for_each_entry(ctrl, &nvme_tcp_ctrl_list, list) {
+			if (ndev != ctrl->offloading_netdev)
+				continue;
+			nvme_tcp_error_recovery(&ctrl->ctrl);
+		}
+		mutex_unlock(&nvme_tcp_ctrl_mutex);
+		flush_workqueue(nvme_reset_wq);
+		/*
+		 * The associated controllers teardown has completed,
+		 * ddp contexts were also torn down so we should be
+		 * safe to continue...
+		 */
+	}
+	return NOTIFY_DONE;
+}
+
 static struct nvmf_transport_ops nvme_tcp_transport = {
 	.name		= "tcp",
 	.module		= THIS_MODULE,
@@ -3143,13 +3169,26 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 
 static int __init nvme_tcp_init_module(void)
 {
+	int ret;
+
 	nvme_tcp_wq = alloc_workqueue("nvme_tcp_wq",
 			WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
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
@@ -3157,6 +3196,7 @@ static void __exit nvme_tcp_cleanup_module(void)
 	struct nvme_tcp_ctrl *ctrl;
 
 	nvmf_unregister_transport(&nvme_tcp_transport);
+	unregister_netdevice_notifier(&nvme_tcp_netdevice_nb);
 
 	mutex_lock(&nvme_tcp_ctrl_mutex);
 	list_for_each_entry(ctrl, &nvme_tcp_ctrl_list, list)
-- 
2.31.1


