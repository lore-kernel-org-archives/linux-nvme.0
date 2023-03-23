Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37DAC76196
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 03:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=57WHjwrf/c52o/jJv17tzXRzQ1gCYQpQuujgtKsyieE=; b=Rl8NiVuEUVKTjhXozAJbB07vM4
	EzB5aLQ5JnbmBIffxxsf2zz7PelIbtf5LlhsWfQi4/WgQxsMQgX6CLYhZBmeNfitDhL1lJuL0WFrZ
	s5HENVXmcXE/DK3ZVpxmaqSs79UbWq+OdLuWQAWCUm1LtWKHR/3v6tmLQ0jtfqeTeSsbxYWh56nRO
	tdBUP6l7vlVOme5gpT7nLygzrMGsMd1il+nRIQVjyp4EZB2xfFD+lzLtBRlOzd8Nv53AZWkoY7zIE
	JF5HIGd8D1H/9sfnE3T0iY/2Q2nTfq8uQO2xjPrPhGVOxJj2eTuUeoNqqRZ/CoqDud90CQ/3pKj7z
	p7ecpghg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfBm0-000e9e-0K;
	Thu, 23 Mar 2023 03:37:56 +0000
Received: from mail-bn7nam10on2061f.outbound.protection.outlook.com ([2a01:111:f400:7e8a::61f] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfBlw-000e5Z-2U
	for linux-nvme@lists.infradead.org;
	Thu, 23 Mar 2023 03:37:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/f+e+4VdvlcKpjgeS6f8Zr77lraDywz/h7Hb//2kEKOGfxP2laoaHOqgoYkAG1+yTfbdUrsqgH2i5OiX91rbKRw8GrPpUVeHP9/VJVspTMKlRw8RrxO6BumoAkvnZhEOZ0UL5IIhKFABgf9dA2ZlwqTu/jANN/h34xA3ewJAULg7HTRj6utGEn/eI9nQ/v6WDBs4Vzlm1opGSWUeGzio+HG3Nf3mCp7of2c7HXsx78QCSAg5Gi7IIv3Axi8sXkH7e4NxDr7VirfzVIKYxcxThdRTjSbrv1U8TpmHzCxCGsBwrShQzDbq1wARK98b77L0pX50YnQktA6ePi0AFD7ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57WHjwrf/c52o/jJv17tzXRzQ1gCYQpQuujgtKsyieE=;
 b=HZ4ZPsftyQ/faNRTRHkTTbcBaOEmBBXo2/Nkrxb8EggpDUTSg5ADtWtpvQgmdcMCKeaoxybjz2I7/1JkDjYZ3UqHIheheDdQMd103IGOierDRdoQZeetOhuiGzm/TGRvjWhxrFRBWWFW1q3QpznoO+Eqx3evNpDP4HNi2KjGZ9njJsWk/UottfIQQsiWB+VtAMwBcSBLjhX5hLNlAtw8naPpxtzRzZmwqof8uGqBSKhJBBx49JldQ08DBacwK8Uc8XJwCxaxRy4RjV5WwsnYKMsnVYq1Wpe+cQc76KeVPgOg4Xn2O0GwosSU0emec3ldCc9XiIrN0uNQdNdAUHg73Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57WHjwrf/c52o/jJv17tzXRzQ1gCYQpQuujgtKsyieE=;
 b=S0muOCCjRepIkS16TY+8vFpAdpeVaPxU6BQMULayCDVuCalFshubuEY49fX6BYazL+E8QATfyISP0FXQYFBFWhQV8v5i9iulcka6C899p1sxr8XZVmY8lAnI64b4TUIJYqOgv5tHmgrI+VcoEKLGrhsXnFmcLYH5CyUlieJ4UonXPcohGOnaXv0ILqRahic+CSgq9WpKOKIT+v9AMwtfNvmbFJfJg4Og0vvO/HBC7G6UBTxf+nXjMrYpOaG7NC+ODKSgBrddg5Qq3lb/9Zoifx+3BzcXasHnzlw3WyHpBrGs41thoPWK2GmLubM2myqaI80ysztQ64r435MGvpSvTQ==
Received: from DS7PR03CA0330.namprd03.prod.outlook.com (2603:10b6:8:2b::22) by
 SA1PR12MB7125.namprd12.prod.outlook.com (2603:10b6:806:29f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 03:37:46 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::ad) by DS7PR03CA0330.outlook.office365.com
 (2603:10b6:8:2b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 03:37:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.21 via Frontend Transport; Thu, 23 Mar 2023 03:37:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 22 Mar 2023
 20:37:39 -0700
Received: from zion.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 22 Mar
 2023 20:37:39 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 5/9] nvme-core: use normal pattern
Date: Wed, 22 Mar 2023 20:36:32 -0700
Message-ID: <20230323033636.812758-6-kch@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230323033636.812758-1-kch@nvidia.com>
References: <20230323033636.812758-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT011:EE_|SA1PR12MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: 01e1625e-3210-476a-6147-08db2b4ff7d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	xD6PG63zFgZYoo58DJWw5K3uF/wcXHgMNN0MjCQy9nnE6XvT+Fi7cRhwC7tw2K/BMk35V2n6evc+ork5Lohb6W/MTM7lAPBEdRAQLT9rjTRvQtcLs1O2YFTKQNHWKECRviTMJ/KiI9rqcpQ+eRFbOJl/m+GCAQXG5AmbJPXD6E8F6D3kJ5DlzG3PEBBkSP6ICzKzADJ5siT6oBCqfpn7j6E1tqXd2n5M1ERqbhN5+cTjTAemlrOWkuin/OtTmNmV4i0PPq6iS0y89wVllrpyLUPyZp29BiCO0+xHVv0tF1ARvnBYPWirbthuHcmMxVv03Xlm1MMnzUauh49JOGJUtvGMwwMre308YwaZvJxKUL+LpMKDzau2ZmPHFXXIb4+As52vZPII+I0e6EieZ5CpJawTzrhKgtQa2iF33rtw4LCfYNBeqKK9ltnzkjhL6R2nyxAhZF457RtjNickGx/tlTKFcoaGCGVifApN0/n75yJ6DDYfsYmdFOGBWsgKi3xIiCqvcfAiUqaae64fC/yfqDgieMuZk40sdVhsN0AaMMUfpgMqCat72Ji7P+ETBxhZWJEeQqLQRwGVJ1iq2nO07LnA/uY3MW/L9rkgV3ikWOSmSFYvdYgCZFFvgrCVgGIPt6EhDekfEPPBnN5oDwdALztpCSTkZ70WkYizT8DVirbZ3KkzFkNlwApUBzZ7f1slxLZH9rKcqTfYT7VzocbmvZVvpKttdeGyElwcNVCr1ioK59inuRJh4Qlk3Vw4rhau
X-Forefront-Antispam-Report: 	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199018)(36840700001)(46966006)(40470700004)(47076005)(54906003)(316002)(70586007)(4326008)(6916009)(70206006)(8676002)(6666004)(107886003)(41300700001)(7696005)(1076003)(26005)(186003)(8936002)(16526019)(478600001)(5660300002)(2906002)(40480700001)(2616005)(426003)(336012)(40460700003)(83380400001)(36756003)(356005)(36860700001)(82740400003)(7636003)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 03:37:46.1796
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e1625e-3210-476a-6147-08db2b4ff7d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7125
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_203753_106305_7C64022C 
X-CRM114-Status: GOOD (  10.76  )
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

Although return is allowed in the switch ... case when function is
returing void, it creates confusion for future code which is desirable
pattern to use for switch ... case. Repalce return in the switch with
break that is standard pattern for the switch ... case.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a380938f5a06..3eb2299a81fc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -403,13 +403,13 @@ void nvme_complete_rq(struct request *req)
 	switch (nvme_decide_disposition(req)) {
 	case COMPLETE:
 		nvme_end_req(req);
-		return;
+		break;
 	case RETRY:
 		nvme_retry_req(req);
-		return;
+		break;
 	case FAILOVER:
 		nvme_failover_req(req);
-		return;
+		break;
 	case AUTHENTICATE:
 #ifdef CONFIG_NVME_AUTH
 		queue_work(nvme_wq, &ctrl->dhchap_auth_work);
@@ -417,7 +417,7 @@ void nvme_complete_rq(struct request *req)
 #else
 		nvme_end_req(req);
 #endif
-		return;
+		break;
 	}
 }
 EXPORT_SYMBOL_GPL(nvme_complete_rq);
-- 
2.29.0


