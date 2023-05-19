Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B109C77B7A
	for <linux-nvme@archiver.kernel.org>; Fri, 19 May 2023 09:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=v0JPqB1CPTnTV3rikDGHrGucnqihIqMBpDx/CcQNyfY=; b=TRNvyFXmSymJZJJEstNRuIocoD
	Cu46bQgHLETmkRVQRFqSSf/0ZvAvb/1Y5SYeyoHPXc7guH0uxLWfAv2ssH0xsgTTct10rxCngZado
	RDK8w02+I5Ja1bC02VsDN0dPOkE3c6mbo3E7ZwaR5wMfZ250XmqKGKY94GhTpwkcXCBlhrc/LOkzM
	pvKEfIy3LthFsRNkwrnT8XcJhhlfp8fYmDUJUbVc+2ncCuX11Ra1/tuZ+wt8GsUdnlIqgwJk69XSi
	k8BmCBiTeZBQdKDqwkoGQWUY4fRQ9V3BBMkJXjRKLZfZiOhLYBI2gS8ZVQ4tuK0JbmpG4aSf7myBC
	pVwl4q0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzwbr-00Fl0Q-0V;
	Fri, 19 May 2023 09:41:15 +0000
Received: from mail-bn7nam10on2060d.outbound.protection.outlook.com ([2a01:111:f400:7e8a::60d] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzwbo-00FkyY-2P
	for linux-nvme@lists.infradead.org;
	Fri, 19 May 2023 09:41:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cajmsnqo+PKVQu+eq+6uF+gK6EWuEsh245W39OskRsdikMaLpwNjriFCsm85pdVRO+PgH6Pk5gKGGST7MwrAu6/e0LLHpCdxEbJBND+p7edpVKLHyqF8kkJ9e+Jwprckn85duRBiCWIEKInZkwA9+vL3bo1CKfm+DnqmnBNfcLTme/vTwu0SBxGlUeL52a/t1CX9fXx5X3rCeXtBi7tAQTkMrTpt6mtRSyvHXNEXdZQ6XMitQuPC7df8bu52T7xDWkAIoRv44o9hR4xTlM7FNBynYwPhILyu6EN5rmwxvPCcxlYuv1ABjtatoaBVkMlObOOuFU25V8dizwOzkLqfOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0JPqB1CPTnTV3rikDGHrGucnqihIqMBpDx/CcQNyfY=;
 b=moCjm50ivxPJFTDemi5YRSKYKhSvH1ELpF3+DWTxFOgXwO2FFPkhLwlULimMu8YXNus9ASc7lx2FITGY2yXqCqJmo5KTDBMRr0yxUTacivrf2H7p4NBGd9kWJu8zsMYhGfeyhUJ17mjJY+HQIAARUAxQqGTDcV8rai36GMDe41VakDOl6TlnRasox27m6WU9Oc/+CfKGnqbQjXv8S1O+ioTAXCAEqpF2mWAjBd7yz1EclNLjSUyjIyAGy9SB4ILqpys4fYZcULgLZbePHXOcGdxpdWJNmPuhVOBGPz3PhB+Cz88I1NdxBbSbl5HOTa5+M/1+O7HkjIReiTz1pT04zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=suse.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0JPqB1CPTnTV3rikDGHrGucnqihIqMBpDx/CcQNyfY=;
 b=Byv8JVbTIIoAYJd45/ht5YjFeKgYWCUF7bQ7+6hpt3N+2/E3kvvzeuxF0X5usZp7oQqfkMgCrQQInjsik6FJ9jUAibcVigLMGnS+qb7n/Tt8Q+0s6aplD5O2+4Fk2l5ovldG6vVRPaTNKFWu0/CUIUAWG+8LJK3FYvCAwBbPCj5nn+et6nA8LgBP0y4/UPZpzDnyJhrptjkdNamVTYjNumbMRu6qbYIQO+YPhyb4zPj92WFUHAdkAoOKDrdHWL6kjJRo9gbntav6tltx0GyC7zkWXKWnz+0nHZUR81AlPi502FXsK1TYndibjFdlV5WO3q4mxLSP6ue4arQ9mPpopQ==
Received: from DM5PR08CA0041.namprd08.prod.outlook.com (2603:10b6:4:60::30) by
 CY5PR12MB6129.namprd12.prod.outlook.com (2603:10b6:930:27::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.19; Fri, 19 May 2023 09:41:09 +0000
Received: from DS1PEPF0000E645.namprd02.prod.outlook.com
 (2603:10b6:4:60:cafe::c0) by DM5PR08CA0041.outlook.office365.com
 (2603:10b6:4:60::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21 via Frontend
 Transport; Fri, 19 May 2023 09:41:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0000E645.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.9 via Frontend Transport; Fri, 19 May 2023 09:41:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 19 May 2023
 02:41:00 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 19 May
 2023 02:40:59 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <hare@suse.de>, <james.smart@broadcom.com>
CC: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 1/2] nvmet-auth: remove unnecessary break after goto
Date: Fri, 19 May 2023 02:40:51 -0700
Message-ID: <20230519094052.48575-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E645:EE_|CY5PR12MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: 3789ff6f-fbde-4b6d-4f50-08db584d2d35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	CGC16TXPnsSBO8PXNvmoRW1KLLRaBFUDbv1eG2azqiRh8wgltopWgpEPjAgn7CO7xZjoNO8jG5E0695bTxb7ptPrGwtzkITCdIvLBMA0k+qbUSMVIx1rt0Qn/xNcu0DXwVhdjTP7Mi1bKvbBxY9nFcVpoI0rsjeBneHm/ZBBkS+BJFYo4P/N2uk7LLy4nBV1rNY4uMJEwDZH1EtDcULgCHxl1d9Ug30MZ/o13KN91nNfabhOKhnVnC45teNZ/iARxDvYVpzPAwBaeNlQwrC4nxyJ4nGR/Bzq5IWQg8GR0ohZvIjrjAtbZsX4zJ2SbGkPl3lAMg1r1MgX8fVCllOrK1xp0B00utHZjgfDGiCy52ykxD91Vbb4UujTvlY0EUW4lTlajKQ4hUYS2+F6EmTjfpeNmsfc7cEkfIcaCZB5aJ/NSY+iKYfCPnHdZY9Ls//SvNpiDS+kHTl+JfITZhpHrdJeoRfuo/gTui7hW3Bx/KRExYfB+/LmIn/6poIZWXGfRqKLLFjleNOwdlg1ph0aAJCkKRBtqs/woGRjP6Nl4zW09U0VBWMhmPBTM0kx3C49ZCyIY9TLTgoKOMUg8LsRgPvN1ivTleYrXkGXu/cVsljFAP8zgxSZ48w0Ex/UmZUdTpPVrW4vvTMFST+V7zFVJF33bWtF//K0k3gWGL9fOVAFECxSrf8iXtEGpYqHXU0NXR0Tr50vfffpHoSk+ZcjvpeJsCE4lMt0q3ic3Nh6SFEivzungUohEeqh2prSHG/J
X-Forefront-Antispam-Report: 	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199021)(46966006)(40470700004)(36840700001)(1076003)(40460700003)(107886003)(26005)(36860700001)(83380400001)(426003)(40480700001)(47076005)(336012)(2616005)(36756003)(7636003)(82310400005)(82740400003)(16526019)(186003)(356005)(110136005)(54906003)(478600001)(2906002)(8936002)(8676002)(316002)(41300700001)(5660300002)(4326008)(70206006)(70586007)(6666004)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 09:41:09.5845
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3789ff6f-fbde-4b6d-4f50-08db584d2d35
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	DS1PEPF0000E645.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6129
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230519_024112_786943_B05FF948 
X-CRM114-Status: UNSURE (   8.92  )
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

Remove dead break after goto.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/fabrics-cmd-auth.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 7970a7640e58..6c9a1ce6068d 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -295,13 +295,11 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 			status = 0;
 		}
 		goto done_kfree;
-		break;
 	case NVME_AUTH_DHCHAP_MESSAGE_SUCCESS2:
 		req->sq->authenticated = true;
 		pr_debug("%s: ctrl %d qid %d ctrl authenticated\n",
 			 __func__, ctrl->cntlid, req->sq->qid);
 		goto done_kfree;
-		break;
 	case NVME_AUTH_DHCHAP_MESSAGE_FAILURE2:
 		status = nvmet_auth_failure2(d);
 		if (status) {
@@ -312,7 +310,6 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 			status = 0;
 		}
 		goto done_kfree;
-		break;
 	default:
 		req->sq->dhchap_status =
 			NVME_AUTH_DHCHAP_FAILURE_INCORRECT_MESSAGE;
@@ -320,7 +317,6 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 			NVME_AUTH_DHCHAP_MESSAGE_FAILURE2;
 		req->sq->authenticated = false;
 		goto done_kfree;
-		break;
 	}
 done_failure1:
 	req->sq->dhchap_status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_MESSAGE;
-- 
2.40.0


