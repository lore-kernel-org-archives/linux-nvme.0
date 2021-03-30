Return-Path: <SRS0=nD3g=I4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1E2C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 23:02:15 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8221261987
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 23:02:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8221261987
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OM3viOs8WP4xEN6pWR06Sz5t1+st13s1ccM5In0XkBk=; b=SmYtezu6VyBfDDlzFYt027F36
	jq3vlx5YFhWv9M/oOmiINOn2Z2aFMlF75xS1C+tWzAMyDsVN2+RwGfzsElqFHH2kSeHAvC5g4UUOW
	ykJ923J/XEhcIyTzDxhcKOZQtVGv3NkQ2X6xE1hid2o+6OZDo2zlSBewlzr4mG1IlTzRWl5sUY3Sb
	VBpgkWvPw11zJRDuLLShbWWOhtGV2vN59zoVaOcSvP2JbJH0iAtdlfziX9GJqmrDrUj50D1xaSkIr
	g0OIYa5rnPzqMg3E8yCA0NXh9rjNRT52YEdy2n9Zgf9tFHck8xHaAWpfiJgrWrygl8BZn11mIwfig
	/wH6Qynfw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRNN0-0053qr-Iz; Tue, 30 Mar 2021 23:01:58 +0000
Received: from mail-bn8nam08on2046.outbound.protection.outlook.com
 ([40.107.100.46] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRNMY-0053mf-KJ
 for linux-nvme@lists.infradead.org; Tue, 30 Mar 2021 23:01:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAtAkKfyCqgx4PIY3VsN+tsbQMpGa7/n1ZwFLFAvnKmuQBXZWvauA7tl0KEB6Nz0IWZTWrDaKRVsBQEjjrSjmkMMca0KMcWX8CfIIGzJnH3WqS1l+1Ist4N6OcM/wVZyHopk+Xy6nA6C20pLBenc4XK6Ze9Sm2EAwl9XRyWSCw74KZPmcc/bNiSjlcR1fENnzvmM7IXBCffrVbzfqbvCWRhAt10Kv9lgxiBd77NG6tQeQ+UtiSYxOXE4SZOfeEGctRHJPms3JVrhPQsWmO1cnTTXwrZO3VtaojFVB4DcS9hydfsEkeYsuDrIPnrvmsbhWxV5PuAV0OP1+OLY5winKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oBOaOFxEdkJt9bex9Ouht/8pSDoG6hZcPVV00Q1s0Q=;
 b=oTxXguTc4VoQxpRKVXM694QkuEmYKxc+C2hWc93WCetf0nUQliTGO+o3bg/P3rBgHj72Gn4Orz3l4qILl8OaZeF8btyN0hwN6Gksn3aHZxlJlr3ymUV8S+vXoryXD2pQzY5htm9GGf3I/BY7epRQcKzaieyDVWa8fkaLv+0hvVbyu0nmciSqqb5iz97ZsYeJj3xdL2LKmVu2mHIr9xNbqzbKmVjgAIMp/5yLEDOeT67gQA7gfSUprWGCjV1fdFlAFidgwozUuiYBfc/mKrmVE80tNfYy1VTzo4Bupytr++JvhYVTHWgvTasTZkS7tFLlbnEMyRI9JUW4FPF161yRQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oBOaOFxEdkJt9bex9Ouht/8pSDoG6hZcPVV00Q1s0Q=;
 b=sjtGhcJtKTfXfe4mhe/FC6iq26BcgjuPYTxLjx6bzTv5df2TPKBTWGUfSxodG/SU9V3UZZh6mov4vChT/z+WlvQWHSQt8bLhOoBtuI2QZvuEVwum5DXCQ3bHE4HxScDeKVmRH2FwpsrOp8AtcJ81eOrHQcHVfZHcl+ttKxzPs5CTkZwgDE2Y1n0gBWGpoWa1Scev+pHSOO/2c7aLCVcQos8lqcrO86X5JZHjImr+J6/j7xA43WnUZaxAmHusJbXdGWUVGjVub6xpNoGaep+qBnu4tbIFmfyZSb46MIOcyDsPf4J3ORvXTxDNxEE0Y3svv1oy3rLaZ8sRINFKalweXQ==
Received: from MW4PR04CA0170.namprd04.prod.outlook.com (2603:10b6:303:85::25)
 by BYAPR12MB3255.namprd12.prod.outlook.com (2603:10b6:a03:12e::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.30; Tue, 30 Mar
 2021 23:01:27 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::68) by MW4PR04CA0170.outlook.office365.com
 (2603:10b6:303:85::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29 via Frontend
 Transport; Tue, 30 Mar 2021 23:01:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3955.18 via Frontend Transport; Tue, 30 Mar 2021 23:01:26 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 30 Mar
 2021 23:01:26 +0000
Received: from r-nvmx02.mtr.labs.mlnx (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 30 Mar 2021 23:01:24 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <kbusch@kernel.org>, 
 <hch@lst.de>, <chaitanya.kulkarni@wdc.com>, <jsmart2021@gmail.com>
CC: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 2/2] nvme-fc: check sgl supported by target
Date: Tue, 30 Mar 2021 23:01:20 +0000
Message-ID: <20210330230120.268671-2-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210330230120.268671-1-mgurtovoy@nvidia.com>
References: <20210330230120.268671-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6651fa7d-13c3-419b-93aa-08d8f3cfbf39
X-MS-TrafficTypeDiagnostic: BYAPR12MB3255:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3255164D968EC043826AE0FBDE7D9@BYAPR12MB3255.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f+y+/04f8pimcbVEM0u3TSOvlDp7Ro9H9VB4XO5vizYxSlefeRH+qOxshF7vbR5zy5mMaz5qPd10Mhny1GMISZYGPoOuNgOh21G8DEKZJ+eCN/tgpRpsI5nEjFHg61yoDvzna82rXD8UxAV0XriWPfsSF5uqdQDgLWKgnLE3wCznApaJzk5C4JIoBra4KsuiLhk9h5yL3xR9Een9+QmqGGcxImmZQvhg38sSuMSAlD2usLEKvmCsWmhPtI8OeK4JUu3BEvwvjtypxHRJ/Z1BnetxKmIIjAHGEYoKkHO6HrN502mRvSj4yMvgIZFiad/XSqTmqeTdcoXVuX6eqhoyWCOqFnoC9Bl0wDCkTfZMPoyFtv7VgwxbRJ+QkkDtzNI8gISG4QSR3+cIHJrTwzEwaTSBlw7fwDmhLXxCx3cizx5i/zK9GCvCLEinQ0D0v1d3IVzXPBFJq1/f9dLOdIA93vwhmM71MqfGfJtQxJOmO/w/E4N4MUaJ4aJsVOV+HfJJ4JxcEmwl+P70QG7XWmUKNDMo2gjm33kgq0Pk091mm1+mnrhk97rXNkR2f86PCMaT9yuagVLfb3hGycR1I0HstCDXCYb+pKEhg6xWVyKNSbUoybDzOZM6HTt/LllEP7t8ulcmSIfcTHCoze0xxD35NmFKQP+P4UXO/Gx8XBhZFH8=
X-Forefront-Antispam-Report: CIP:216.228.112.35; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid02.nvidia.com; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(36840700001)(46966006)(86362001)(4744005)(107886003)(70206006)(70586007)(4326008)(8676002)(478600001)(7636003)(336012)(186003)(426003)(316002)(2616005)(2906002)(82740400003)(83380400001)(356005)(8936002)(82310400003)(36906005)(110136005)(47076005)(5660300002)(1076003)(26005)(36860700001)(36756003)(6666004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 23:01:26.3817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6651fa7d-13c3-419b-93aa-08d8f3cfbf39
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.35];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3255
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_000136_291267_4F475C06 
X-CRM114-Status: UNSURE (   9.23  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SGLs support is mandatory for NVMe/tcp, make sure that the target is
aligned to the specification.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/fc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 6ffa8de2a0d7..03032d9b0573 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3100,6 +3100,11 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 	}
 
 	/* FC-NVME supports normal SGL Data Block Descriptors */
+	if (!(ctrl->ctrl.sgls & ((1 << 0) | (1 << 1)))) {
+		dev_err(ctrl->ctrl.device,
+			"Mandatory sgls are not supported!\n");
+		goto out_disconnect_admin_queue;
+	}
 
 	if (opts->queue_size > ctrl->ctrl.maxcmd) {
 		/* warn if maxcmd is lower than queue_size */
-- 
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
