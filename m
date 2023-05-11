Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9CDEC7EE22
	for <linux-nvme@archiver.kernel.org>; Thu, 11 May 2023 16:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wuZ757CUqTbrRjmQWzXuaMto+fP0AUo8iHNOh8jTTFY=; b=3+yccT/VDVWTkR/lnjo0Vq1/1D
	hI1AKkJc9iRFQ74i5iXEfwQ14ehMnYLnvEN3zZ/MMtyMNcyrwIvIRYAbVGoe1tbcyoGgsC6T7G6iX
	yJTwNKASUThhk2SjXyeFLClq4Ei251ddliRV7oYOXWsUHEiVRTdhUmDV7D0QJtRf15sD8qLvLcxhQ
	kEnu+LJtuPLqfpVpk4pqxuaZ9zjxyABEpBucrmyey4+TdSFMWUFU4z/GebkH1sB+lKc3ZFswZOThF
	m6j+OpNaymrVGpnIH7UvQ9WAU9ilExACowfcK8yqjinVBonxkNey6L7YKxr2xoTEl5czqc7w1KXKh
	gR16WnCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1px9ZP-009QsJ-1y;
	Thu, 11 May 2023 16:55:11 +0000
Received: from mail-mw2nam12on2060d.outbound.protection.outlook.com ([2a01:111:f400:fe5a::60d] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1px9ZM-009QrS-38
	for linux-nvme@lists.infradead.org;
	Thu, 11 May 2023 16:55:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dn9Gw0zn7dW3u4LLK/ONP+qcubsXjPKu9NCJbYbi1zDkiE+DBJ9dLbbflsZ+7jiKNQZqbXbJ4DD+eZUtfxA2T2gCszjnx6ALda6kghV6KiCltUVtOpyYMiQDl45ioYAbmwsAFyIxVK7+B9PkbUDBs5sDbqmP/FnGKdI7IrXjaiZQlRAT6O+oXvka7eDZ7Mw/d47YzYEGPJv6M2iCNkhewDBli62uFukhFJ1CaC7KiY7znqWWU/4P+v6phY6vF2k66Qxn/txeg+MUHG87PYgMxCn+co9+296J1wxsFx8siSN4iqsc2z0gww4/09NzOWKPA5DG3fXkdeBqbIimBgiSgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wuZ757CUqTbrRjmQWzXuaMto+fP0AUo8iHNOh8jTTFY=;
 b=MoOg9PYU4mPVrCpAqmXtjqXoNgoA01vYZ/xxFhPT3vw74wYCOwdxDO4LkYaAiidgD0TeeCJPHuLglFBAD9AxEtRtlFIe6CWFlsVDk0bGro1WcXzHHSB2RtGm2Ns8QpiLGSSHBAzxJn/CVBe1gHZdIvJbQGo0+Z8C9/ExHSpnfCFcOHaxuoo/BcbyaH4JSuTNskb3LlmCrVeKg0cxQTjDAWzcX/oBVfgkYpxoqW1trfPQtjVrgPo01z2uDieZUQvOnFpTQl8v7L55wpkg9TkVRdKKlKUS9UxPlu5VBYLMI6vhh3KUs+yVynO0s72gwuoVYNkMFjQ4g9+bS9VtXX+jog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wuZ757CUqTbrRjmQWzXuaMto+fP0AUo8iHNOh8jTTFY=;
 b=RYQnOQlNbwyFdeJMapEjpk/F6KqxEjCi10C/lAdZNbLUgT4KScEmLDLUwT4GCNZTgYiUegrWk9a5uDEOG/+saBPDUSjyiFptpUPbsECmFuP/9iQ+8sTof8v94peilAU6qGViPG1TyPBnjVU2UkVom0q1caSR3ORCVRCVv6rRk+Zs5yl5/ebtY9tZWCcwSMCgQ8YUzqHLyZDsMR/CdDTLpZ1LKRCgDe1v1El508PctNnPI1M0RsoIaaL6Im2qq0dz8yPY0LAXQhPpkvPStGtHnwkGEN6pg1zITJLRkaD0USEJyNRTaPbu1rd4gQL9Cz6w+AH2OVF/WJ8BpuHj9V+Jew==
Received: from MW4PR03CA0086.namprd03.prod.outlook.com (2603:10b6:303:b6::31)
 by MW3PR12MB4348.namprd12.prod.outlook.com (2603:10b6:303:5f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Thu, 11 May
 2023 16:55:03 +0000
Received: from CO1NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::33) by MW4PR03CA0086.outlook.office365.com
 (2603:10b6:303:b6::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.22 via Frontend
 Transport; Thu, 11 May 2023 16:55:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT101.mail.protection.outlook.com (10.13.175.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.22 via Frontend Transport; Thu, 11 May 2023 16:55:02 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 11 May 2023
 09:54:51 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 11 May
 2023 09:54:50 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 11 May 2023 09:54:48 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <hch@lst.de>, <sagi@grimberg.me>, <kbusch@kernel.org>,
	<linux-nvme@lists.infradead.org>
CC: <hare@suse.de>, <axboe@kernel.dk>, <oren@nvidia.com>,
	<ngottlieb@nvidia.com>, <israelr@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH v2 2/3] nvme-fabrics: check hostid using uuid_equal
Date: Thu, 11 May 2023 19:54:40 +0300
Message-ID: <20230511165441.30005-3-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20230511165441.30005-1-mgurtovoy@nvidia.com>
References: <20230511165441.30005-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT101:EE_|MW3PR12MB4348:EE_
X-MS-Office365-Filtering-Correlation-Id: 55202879-0e72-4079-f647-08db524076d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	m8ktTjwlkEFUOlBucZBfKjj06XiK1A/evWvCMJQEFlVbxrpC2UCjpCBgxW68GNrDRB75OvFdFYM3TVYdUYJHevFTBCy8t5BREPtf8uOugMntIrSqyfDtKI99Bh34R5Ca1H8G5K6FYXsdO49+sG23HN+WXtoav+vWQmL21vZKsQf9NjGIDRh8/oCWP13Gf02jky/WAm+8RVFPPWJkIBnNDSlV2ysx0V4oSpeWrsNDnjLIsiGSd/F0m9asRuVy8WBTJyly3gL0XwHlwfZwUN/PSaMozNxFbuK8FAzVIvHcIdW/Kr0s08ADRn89TN2XH5Y68vht2CEi2stAtuiMCno3w+iguTIqaBPlvZSnrLMARRuG5rD5Usz6JHkPMtLgin3eU6wD18Bxyt34zGJPKEp+8oilz2v46xubAUvNJGzPg8NZmIjORt7I5wTDZ/g5xpZY48CXaiJfSD7KD8GdfnNBJGCXTuOaFlf4lS5Tr+RgIDHkVM+xoFJ0F819z1QYzUGd0BxsMWsBlMOINscTXKOZrmUE7sodvba48MvJaMfJB8zgPYP9qVUmMf7MGoia/8Q6ml4XJnEKESYA7dXzndVZ10kgeig0kaouK5VmNRCaD/Nnny0FNhUtnxpmRuZH9Zk0neNUghjMeARHDLgI+tReb6JMV5bgaW7/Ca8VFSnZjzJreErjDEQ5dvMkKx3QIG2ukMFk5n0xBBcsVyCOLhvJWLEv7ylcVDmbqNcj3Xyn7ZwfLu1cHWBRV1nRWcGBYQi4
X-Forefront-Antispam-Report: 	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199021)(40470700004)(36840700001)(46966006)(82310400005)(356005)(86362001)(7636003)(40460700003)(40480700001)(107886003)(36756003)(1076003)(26005)(2616005)(336012)(186003)(426003)(5660300002)(6666004)(70206006)(70586007)(8936002)(4326008)(8676002)(41300700001)(478600001)(316002)(110136005)(54906003)(4744005)(2906002)(82740400003)(36860700001)(47076005)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 16:55:02.6572
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55202879-0e72-4079-f647-08db524076d2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	CO1NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4348
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230511_095509_064951_77B1C51D 
X-CRM114-Status: UNSURE (   9.06  )
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

Use a dedicated function to match uuids instead of duplicating it.

Tested-by: Noam Gottlieb <ngottlieb@nvidia.com>
Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---

changes from v1:
- address comments from Christoph

---
 drivers/nvme/host/fabrics.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index dcac3df8a5f7..862bc4e5e3d9 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -181,7 +181,7 @@ nvmf_ctlr_matches_baseopts(struct nvme_ctrl *ctrl,
 	    ctrl->state == NVME_CTRL_DEAD ||
 	    strcmp(opts->subsysnqn, ctrl->opts->subsysnqn) ||
 	    strcmp(opts->host->nqn, ctrl->opts->host->nqn) ||
-	    memcmp(&opts->host->id, &ctrl->opts->host->id, sizeof(uuid_t)))
+	    !uuid_equal(&opts->host->id, &ctrl->opts->host->id))
 		return false;
 
 	return true;
-- 
2.18.1


