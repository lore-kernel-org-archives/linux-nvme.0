Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D693C77B75
	for <linux-nvme@archiver.kernel.org>; Fri, 19 May 2023 09:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4cN+vQoLKgoBU4Oxf4wN146MJEn7vxCR4icitxaFnMQ=; b=GCGEZKA+b3AJeIAXjIviJkRlmd
	JEa5/NHXE0bQzcKQj9Z3bWdt7OxxR7l+Bg+5B52LrScd/4iq9OwdHNTuw5YJSX76IZ7dFe5jy7Jid
	Vc0jXsN1OhWbSRbeLEXPzgdwmhQBKYWuA1I7WDbKA9vQEdwURO111t9sl8V6oABKxKqdCmxujwT5B
	ZMBvZiZl1EsqEJpB0mrUXAzxCRy2+eRj/JUKYEh0FHcxK2WmJNWz+3XaICG+PrndfuzEyHu7B1k1d
	1hCF/65gRDh1kaEEdz8hGspIKrx4TC7EGTD72z4ZjpveGjrGjzpB/66//eN4inMXly7TjhvUjlKeA
	0ZrQl+Yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzwc1-00Fl78-2i;
	Fri, 19 May 2023 09:41:25 +0000
Received: from mail-bn8nam04on20621.outbound.protection.outlook.com ([2a01:111:f400:7e8d::621] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzwbz-00Fl3r-02
	for linux-nvme@lists.infradead.org;
	Fri, 19 May 2023 09:41:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2iD4R234fZJQv1iMfwmkkj4+EqTkkhbvzBKIgKLcgxBCQYJODHzEUKQepviW5P2NP7sY2EmAFtDOxozh6JtPUJTnFcEb/z4R3vK078Br6STMu75UFayqx96o0btQSxQp97hysIR+UdxyFJ23oLBCj3GG864bU9rfUO+LlRqjdO85yBKjnXs1jrBewXkkUonV3OP2dFYKsJepgpu7bzbl4mGqRnohNx94s+RocbzBKHccwDAr2Y755IoBCQ6hIfOPtuWgSrsrQt0grAXCLt0MkFBbcQuy4bgD3HmWMxcbzO780jNoREx920Ueh0rP97qQh4dHcmXNN1FwrHlI3jlVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cN+vQoLKgoBU4Oxf4wN146MJEn7vxCR4icitxaFnMQ=;
 b=iInnL4Ee8mxPK9GmM3/sL125qJihY1lAPEN8la9k0FYZefNOpJGgLxYRPM+Yjxf/pprYNkMle/c9reOCXQVMznECG/WOTmTQ6g5vwDlLit8fnxTWL2sPrJjIdryqad9jziFp065U702SvGjLeSp5k4YfmeF+FC9ouAYNerNRBbs0My1hhxKhVGT9lrftnNwKWAckaUniVGX0wpp1iCCwTQekQdU81ItCpyNemFI1hYLffHnCBkcjbICAl5ieSAzY1W1qTaeOkejt6pTCYHUn8YHs1VVuQJz9+8KZ/nIwCjYNHbuureyJkl3NPJlvFvV38LDTpnfkqe/QfjS8jSz8Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=suse.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cN+vQoLKgoBU4Oxf4wN146MJEn7vxCR4icitxaFnMQ=;
 b=LH14pGkVIUP41QEgVgk/e1wOe9EFbbgsCJI9G46Am/79KsoJ52H3fSI3irA8KOESck+K4H0lg1HgRgi33sdffYbQfqcwJCtLfX7ASanOOFKpw9Rwo10lvW8y4FNwEBh6UtoyA5RHKN2ZpjFSmm6UJ4ZTE5oi7L0IJkherEb3+iziMqSksZsI24O22OYw6sdvKzS8nAJPfZHtzNrjYHHcYq/b/HMLz+FOnQWfQvOvxxuLLVpvnStAa4sN462qIJE+U/mhtTxdxQ2iaGFMNGeOeJ1vaHdIxfEC/cCOn4k6dH6WR27ZaXLlrFG6nmS9VmR0gWMi4RYUyFvRu7y2mdoNHA==
Received: from DM6PR03CA0076.namprd03.prod.outlook.com (2603:10b6:5:333::9) by
 SA0PR12MB7089.namprd12.prod.outlook.com (2603:10b6:806:2d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 09:41:19 +0000
Received: from DS1PEPF0000E644.namprd02.prod.outlook.com
 (2603:10b6:5:333:cafe::b8) by DM6PR03CA0076.outlook.office365.com
 (2603:10b6:5:333::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21 via Frontend
 Transport; Fri, 19 May 2023 09:41:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0000E644.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.7 via Frontend Transport; Fri, 19 May 2023 09:41:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 19 May 2023
 02:41:11 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 19 May
 2023 02:41:10 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <hare@suse.de>, <james.smart@broadcom.com>
CC: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 2/2] nvme-fcloop: no need to return from void function
Date: Fri, 19 May 2023 02:40:52 -0700
Message-ID: <20230519094052.48575-2-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230519094052.48575-1-kch@nvidia.com>
References: <20230519094052.48575-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E644:EE_|SA0PR12MB7089:EE_
X-MS-Office365-Filtering-Correlation-Id: c1464cf6-ace6-4451-b062-08db584d330c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	50sNfzBymiiDJ60z5rQmlooSfgJn5usQKnxbKvHdcZiVv9C9ZDEwl5RTc7PVt2WswYpsz5jmzsMXG++z+L7ua9tW0A700twlrwmwsaJnGdkl29PT0X8/uJGTKgtshw00CrvvmeipMu7/46UTE5IuNtCvw1wq3DNOkq/9ESIxfthLEO0yRGnMbsUkdxNauWSiYpw3iDY4xs4CHI+yiqeRdYidlLM/J73O6pRHHULMiBLsqdSFEBvQnzGY/LPcUP2pD6VwnDl8hvivZt+U3bHCB5+eFX9mgSMU/aZj4LtawcejbEUAdOKSMGHChZVHCQpml46DQPKKPD0Q1oIXpdryhbVjYQ6DKQ9ksNQd2zbhvAXT4cRCWcWw0CXFxo5oDFm8dTXDkOMHLr3EP6iaFwv/9SOiQv3IJDWFXrZOMnqOwKWvZ+S35wVVOG4MWGWqs7pXEXgFvexxpl8KjfX+1kJna6VmEeh3U0BgiKY8BWqw219XxLjXO7LZLfyMEHC7J2S/i/R91L/mJl3xSPF++a7MiUwqyOHDgmW6b75/h4QXBAncBh+P5Rz3QYfLlWjBi9xIVx5ynoF2wdzgsgOF+qqB0wJbsM6c04nU7dT85wUp0S4uYjJ9jPGYf+xtno5lztWrl258eBI6URiekwss7Wf8YipuI0FVPFI3IhCmqe3gRRXFOGeIel/YmS8cP9LCI3qqm0n1yvxjjLsww4356HzALyavBDobbxT7tj3euXmzA7q1S4NvWoJwZFZzdcPUsgYh
X-Forefront-Antispam-Report: 	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(40460700003)(4326008)(70206006)(70586007)(110136005)(54906003)(316002)(36756003)(478600001)(47076005)(83380400001)(426003)(26005)(2616005)(36860700001)(186003)(16526019)(107886003)(1076003)(336012)(5660300002)(8936002)(8676002)(7696005)(4744005)(2906002)(6666004)(40480700001)(82310400005)(356005)(41300700001)(7636003)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 09:41:19.3846
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1464cf6-ace6-4451-b062-08db584d330c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	DS1PEPF0000E644.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7089
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230519_024123_053841_ECAB4180 
X-CRM114-Status: UNSURE (   8.84  )
X-CRM114-Notice: Please train this message.
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

Remove return at the end of void function.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/fcloop.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index e940a7d37a9d..1ab3d900f2bf 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -645,8 +645,6 @@ fcloop_fcp_recv_work(struct work_struct *work)
 	}
 	if (ret)
 		fcloop_call_host_done(fcpreq, tfcp_req, ret);
-
-	return;
 }
 
 static void
-- 
2.40.0


