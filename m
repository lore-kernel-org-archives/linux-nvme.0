Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F54C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Feb 2022 21:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z44ADW6e7xTpu7oLktxjLYgq6NA2RaEU6yHsndWzJn4=; b=wXiI804svb6DkSMNgifrPqiPIw
	nNA3+Bjj75UgGdoxJcA7MggUnrbdxvWPM9cro1oj+0OOIWPfxWuxiPXB4EZ7bOD6KodmCJAqcyeTC
	LiAEzMBWypNUnGq6OQ2rPsF6h3IuKyORmn/Y2a7sG0xTtT5ZD6uFlPtBb4UG8bFrMSjNxnxn2MkAl
	cVmBIGDBCt7JgSFIp0JdfIg2/XGMdkNfdzQ6I2M1SC7iQQE7XpZtzKhVPfr3HSRvS16KWwVqFDb2s
	DDDPgMYBr7OvRC4p13pXEpOzOOwyQsTQIOp9N+u7pD++vWuimZEwmROYPvQjvXEyJlHM4Onp6fMcb
	Nhxqhcrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFjV8-002umD-Nb; Thu, 03 Feb 2022 21:18:46 +0000
Received: from mail-mw2nam08olkn2080b.outbound.protection.outlook.com
 ([2a01:111:f400:7e8c::80b]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFjUu-002ujK-Dd
 for linux-nvme@lists.infradead.org; Thu, 03 Feb 2022 21:18:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUEhzn57geh878WCaVFuiDUIFLUvnsAAeZ3miSODCmHcFp3vTzrBjxrp+x1n7IKPLqSmqCEGEyOiSnG2Ns8hsqEJDj2hdNITlaXVzsuHaEVKFFCE2GnovvsvgqPctcIwqrVSSj8hS/60umE9TKwUaXxqCHF+6wAN7N2usNnqW93hEKjjSdmTLwVAv+fGlufzUA9I8QuZb+rmunaxUC6ahjh+4CsRxy6XT2efa+xTsdCBS41O5M4bII1+oJUuIV1VXktZOUCET7haJGKJ/N/ut2QtgLB3HoRMIUzWBOx9KQlPNVfSfy27Mv18iA0/WtfYvjaBGF0CgaE/rHk4CW8jmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z44ADW6e7xTpu7oLktxjLYgq6NA2RaEU6yHsndWzJn4=;
 b=U1yVwtjVMWKhfrxKdtKsqpg1G4An+SXlG8WmEOmm4uFvkyUHtQFNUGdExwUnYrWrwcPBqRYKl4eF1Whn/xn7dMrG3Ubs9haZqCsB37f9cgijvR5xKSntkJMJXZlT0yZaX+gzAO9Kr/4jD5OyUNXuM0vnC57rxIhPPEGtIb3tz07/tf8nxCggeuG6Jd8I2c5GBBN590maDQyQrzOP3DuZOhvyftSLGooTHf8QmAcxpidIpZLNux6cfD5QJkycZGRp1owwpntB3AOLK2zkQK1DSUlD+pXjXqa5t0kOVVk+OPst5/JCGbNW/KCEA7ID2QXQ9d2v4KarJ8WMYTtIJZLM7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z44ADW6e7xTpu7oLktxjLYgq6NA2RaEU6yHsndWzJn4=;
 b=Qb5paajAyzZ6admoJW3eDH5S8cIIbALrIX7RRlqHHhHBUk5PC71cjPvD6vzrr7cTASZqtgfiDskxralia++BFY1YVjLw2N4oc/oeZ4Mn38KvEcfHfmBFya8W3NqNsHrd3TLa8A3o5dnmSLGW0EUCPyWjVvulWEJ3Iczv1ocg8tSeKP59S4UFIqAPqS8ah6cdOG7NtzPCOuh+j361/aA42SMM4jg6m4ZRnuvPMZNj9ZPEJF3jeaoKHmVWjlVYJzvcNdTgk3yCi7wwmTsu1Ex6R6CuZtyuGAYOki4WGe7c6jRtyodbPmI4pvFVAYalaoBxI5yma9/DRbKYEZZYxJRiAQ==
Received: from BL0PR13MB4291.namprd13.prod.outlook.com (2603:10b6:208:8e::12)
 by MW4PR13MB5410.namprd13.prod.outlook.com (2603:10b6:303:180::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.6; Thu, 3 Feb
 2022 21:18:29 +0000
Received: from BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::7c29:86b7:2695:b71e]) by BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::7c29:86b7:2695:b71e%4]) with mapi id 15.20.4951.012; Thu, 3 Feb 2022
 21:18:29 +0000
From: Martin Belanger <nitram_67@hotmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hare@suse.de, axboe@fb.com, hch@lst.de,
 sagi@grimberg.me, gregkh@linuxfoundation.org, rafael@kernel.org,
 charles_rose@dell.com, stuart_hayes@dell.com,
 Martin Belanger <martin.belanger@dell.com>,
 Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCHv2 1/3] nvme: send uevent on connection up
Date: Thu,  3 Feb 2022 16:17:46 -0500
Message-ID: <BL0PR13MB429126376C597E0C3999F6999C289@BL0PR13MB4291.namprd13.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220203211748.27542-1-nitram_67@hotmail.com>
References: <20220203211748.27542-1-nitram_67@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [kK4GWYFFdBiCz+S9Vq1YDoH6ZB+K0QwZ]
X-ClientProxiedBy: SA9PR13CA0143.namprd13.prod.outlook.com
 (2603:10b6:806:27::28) To BL0PR13MB4291.namprd13.prod.outlook.com
 (2603:10b6:208:8e::12)
X-Microsoft-Original-Message-ID: <20220203211748.27542-2-nitram_67@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c41cf5f8-9927-4cf3-8b97-08d9e75ab90d
X-MS-TrafficTypeDiagnostic: MW4PR13MB5410:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VJV/gRu4gqylsgTHA6DcmYrgjG/WzpJek5ClEss6ONEkYxLs3Glle2t0wTZs4USUYwAt0Eu7lkMY+VPFtEdILfs5r1J1hxmH2gfJfO3R7OS+prmVUc0DKC4v52tH3cZKr5yLVD5n/PzgN5QSgHVAMRZUu/gHDTv2fchqazuM8bgTlwdBUjx7vcl28dMsE3OHpSe83SkTVkzg84QbhwuXYm/FE9hVXC50EJjegfl/sJYRHA8Ia8ncLnnbbCCaplcUhxm9le/HV7QyNzDa+fsTg+eQ+oxZwyYctUwxGfMH+C9JMiLseWF8aW1thuCGKHrZHs2EaEqgn7QGNlS4wNTRb5P81pv3/p6zzfn3dgHlXdbGcJ2eHEKNXVNpOgZgpm+e4Pc++nEz7kIcbomFshsHffZItAC3HfRDPnvyn73a7ZDEXUrZontaY07hF5jO5KhHWN84Uil97pvLSo2/CJQ22jFkyL/cK/VH9LZO18vnyp88ezP6LMaPYmyRGIAs0tvJ/Z6HKhTjO5wq9V+stcl0k5oDzkV8mJuVV2A7wuJCBDIms5MMLV6x/PwW5aEJ8Tfjm38FmE1HJjfddhPwASC1ag==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ng4GJh5USyst3FLIuElWZYR230/1PfRiG1cgxfK743ItkWSkq2kenCkh/EMl?=
 =?us-ascii?Q?EUQhD71gaaqVdftA4qHiEnwa8hqyiKFPCBb2ZrQhQt6aX+l1dYOEeUyGN725?=
 =?us-ascii?Q?F8OMBCjt1Ian+Y5jKzdkvaGWH5moe9AO2f1xqtZj6J1t2djcaV6AzBbfcu9k?=
 =?us-ascii?Q?2rdS5xhJ8dB7TBhLF1uqjYEAXIliG+w8p2/jgFS2ifIKwh4XX8OpAO7vKdVK?=
 =?us-ascii?Q?yn9rmkEdtBdKPGHBE7XAxMhLb/4ZRCSQvF/EA4rDyJRlpFldWqUL9qf6JIOP?=
 =?us-ascii?Q?iGgUAhq3bN7lhKcNJVoFE5Aneklw1Vee0vZ4XKfoc+BvLBjeKdl+8DZm89xH?=
 =?us-ascii?Q?YjvmlCs1goY0Do5TpVu6tmWEUiepRVWl7VSedzZzexUdRE2KXw+QoUMiIFgp?=
 =?us-ascii?Q?sYYxV78Uln++Pu+951pBkQboEAEUKPMU12YmJt7GfmJXBt+pc3fsec8wmiKW?=
 =?us-ascii?Q?iTCUwDENElqg+LX0PZl0kc6E3Q1OI4acBKS3k02GHh8Y5ICVqxYrmtNyu7mE?=
 =?us-ascii?Q?JfkDxRNj/8SprX2Rd425oqbQC5A3ByYwi13v+lnWQAsX7Bk+odSDM54F3qv+?=
 =?us-ascii?Q?ZUYD3q0vMpBh7hrDJTgz/qAD+9/Fvo/AgJCwsgHdd0nu5fUJVzo2wZ9uYnaV?=
 =?us-ascii?Q?O1E8RVJLOiV3kWwzl+JUXbDPfvPnUJOC8rLaC/8C6Vu215qKBbNdP8ceTmFV?=
 =?us-ascii?Q?S9O9pzrLkuJ9gs4ziajOypUBzcEG2jLQ0iFynBYMNF3u9Ax1CzT+yQnLP2Dv?=
 =?us-ascii?Q?mo2cdbHxxM39c87ftrJa8nPNLMv0cbCnuWy12rQjs+DoviLC+dm3QsflVLRP?=
 =?us-ascii?Q?WrgH6CG1FaaPcQeIwKbjcFujYnkN/lkGmq9c88zPLhGSOKaljovw8/zrjm6x?=
 =?us-ascii?Q?tzxL/qt49PVx6ngUz6JO8foK5tzEIMjPkCNLEz/76DnhDm/trglYi1WJ3w2L?=
 =?us-ascii?Q?Qj7v8HMbOVpOkSjWjLQ4TA=3D=3D?=
X-OriginatorOrg: sct-15-20-4778-2-msonline-outlook-da780.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c41cf5f8-9927-4cf3-8b97-08d9e75ab90d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4291.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 21:18:29.3631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR13MB5410
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220203_131832_490105_3B8D401B 
X-CRM114-Status: GOOD (  12.11  )
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

From: Martin Belanger <martin.belanger@dell.com>

When connectivity with a controller is lost, the driver will keep
trying to reconnect once every 10 sec. When connection is restored,
user-space apps need to be informed so that they can take proper
action. For example, TP8010 introduces the DIM PDU, which is used to
register with a discovery controller (DC). The DIM PDU is sent from
user-space.  The DIM PDU must be sent every time a connection is
established with a DC. Therefore, the kernel must tell user-space apps
when connection is restored so that registration can happen.

The uevent sent is a "change" uevent with environmental data
set to: "NVME_EVENT=connected".

Signed-off-by: Martin Belanger <martin.belanger@dell.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dd18861f77c0..b5e452aa3c0e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4229,6 +4229,13 @@ static int nvme_class_uevent(struct device *dev, struct kobj_uevent_env *env)
 	return ret;
 }
 
+static void nvme_change_uevent(struct nvme_ctrl *ctrl, char *envdata)
+{
+	char *envp[2] = { envdata, NULL };
+
+	kobject_uevent_env(&ctrl->device->kobj, KOBJ_CHANGE, envp);
+}
+
 static void nvme_aen_uevent(struct nvme_ctrl *ctrl)
 {
 	char *envp[2] = { NULL, NULL };
@@ -4396,6 +4403,8 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
 		nvme_queue_scan(ctrl);
 		nvme_start_queues(ctrl);
 	}
+
+	nvme_change_uevent(ctrl, "NVME_EVENT=connected");
 }
 EXPORT_SYMBOL_GPL(nvme_start_ctrl);
 
-- 
2.34.1


