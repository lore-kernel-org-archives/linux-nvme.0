Return-Path: <SRS0=LsNR=P3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5FBC433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Nov 2021 14:49:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC67E61359
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Nov 2021 14:49:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EC67E61359
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4YKgVHM+496uT13kQRystv/Z3anjEmDXX/6ybeiHQys=; b=BjA7/A4TcAnLeoDM/ouLsMHJCA
	K8KvldJxchV7Kcru9qMzxAq3zaQBNDUR+iCRKV4gOOdeOqA/PuNoBQRPNOpv0rYMnCoGO37NFY3kP
	wfM9c41mow0ncg1AdzBdUeJhZ9utQIjuGXi7B4Hy47paL4c2gSudk4wXIAfl9wSfHmtUj20KhGY40
	y/V/UoG2E/SWeJdHd+4ERLb9sYvWTgPh9Ex5ze/exEyKZB50Cd+TBjoruGmX57oWplqwM3gcJZ9j5
	x4doNUC2RF9HtCBgt0Frfua/pi5VqYI5cS4euYhtOvNRjBGun4AqRtgor05lgYLX2TS7AFGznepVx
	3xM5Qx0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mk5xF-00GiNE-PE; Mon, 08 Nov 2021 14:49:01 +0000
Received: from mail-bn7nam10on2063.outbound.protection.outlook.com
 ([40.107.92.63] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mk5vs-00Gi0v-GB
 for linux-nvme@lists.infradead.org; Mon, 08 Nov 2021 14:47:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJq27P80P5rqqxSFCWYgjTxJ5wZcbCFXazI8ygcRukyd6JKP/tUYUkpBbguzJcojOwQFQ2HjTDVBmljEG65Aclu36UlyQyagNr454EPPyUvgvF7Yn/PS2FXZQdxyg3H915uYFU3OCLTQfeTERRlC0ZZycm1Jqp9Z/73zKZnwmOMfxSYSJZAkk+WDh6GERbGBrH7NB3SS1JCsKQO/+/xumZ1bunuUBR7pF9WdLHBoThgYCs3jei0xFXJl4mWjGdIaVDK1G94LbrvCcS0MBsuJCOThWGgpKVllXAHD5cdH2frcelpny3yR9vP09V1COEm6pmCkCso6GgUi/74RxFjZzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4YKgVHM+496uT13kQRystv/Z3anjEmDXX/6ybeiHQys=;
 b=m83dKvoVKiSeNyIJ0h7GyGOvWFjAv6l7Biy5C52I+Wm2sE9Wg8RvjBbKXePjslcTERkkAMyJvXFc4Pu3VxiLejEurhiU7ku3xnpSP0wIYK6FAV0LtQwGivScgxonto7/RDUvQA8tqDkGOvc5JCkXGpZjF527ddahgJIVkQwpbhMAXIqUkTQMwpN3KjjL0XRLvqWJbxrFk/XFUHszOn063Bf3GB0Cu2DeTUuqfArlmuD7lBjpTsRZv+PROFrjltWL6noq/b/WVT+P21qsMtqSyO7IWWThINoFX9l5Mba1iF4Ie0uTjsTKzI8plcUjxP1dJReaHQIcrwLDtdP2SjdNAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YKgVHM+496uT13kQRystv/Z3anjEmDXX/6ybeiHQys=;
 b=Cw7DnXQKzeDRQAqYrtIPkE294wKyDVvE1Ppw8toVNFgJxi49GielKDXDPMDYCXoqdLB8sJ3ApitjlMROR6BB47xt1JwgNYbXBh4bTkpnxBe2T9hmXyflhu9pMEZ4MfBbnW3jCTyDYwo55VlMohkpHA3d/W+vSbvrJa2/SEJ18y1DBsn2C4lassV4EXRrjxc6zTcTJfiBDs+b2tNVINuk04+mJ9XChIXcP2KAmVhf1qLGi5P6PCUT7Cm21M89oGzC61Js+7EBl9gTvgC8deaqDx3UfRlcrqju2MdZ/lbkixhk0t8awds6SWwPakC44PGrAuOQ+XDZ8bZ2FuzOL9KRBA==
Received: from DM6PR10CA0035.namprd10.prod.outlook.com (2603:10b6:5:60::48) by
 DM5PR1201MB0155.namprd12.prod.outlook.com (2603:10b6:4:55::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.10; Mon, 8 Nov 2021 14:47:27 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::10) by DM6PR10CA0035.outlook.office365.com
 (2603:10b6:5:60::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Mon, 8 Nov 2021 14:47:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4669.10 via Frontend Transport; Mon, 8 Nov 2021 14:47:26 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 8 Nov
 2021 14:47:26 +0000
Received: from r-arch-stor02.mtr.labs.mlnx (172.20.187.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 8 Nov 2021 14:47:23 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <kbusch@kernel.org>,
 <sagi@grimberg.me>
CC: <chaitanyak@nvidia.com>, <oren@nvidia.com>, <benishay@nvidia.com>,
 <borisp@nvidia.com>, <aviadye@nvidia.com>, <idanb@nvidia.com>,
 <jsmart2021@gmail.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 4/4] nvme-fc: add command id quirk for FC controllers
Date: Mon, 8 Nov 2021 16:47:03 +0200
Message-ID: <20211108144703.7971-7-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20211108144703.7971-1-mgurtovoy@nvidia.com>
References: <20211108144703.7971-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb02b1ce-e267-4f69-71c4-08d9a2c6aeae
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0155:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0155BDB653E25492336ADD55DE919@DM5PR1201MB0155.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G4j6qLxCiC/csBN+3EArcV1PY9N2ymOxauOzzaPy118cRy/MF3QktD+XCZf3787vjOGE01m/NJZmCVqsg8SOVDapKlrvruJxvSDR6WM2ZDiyaWXLwSWkVYqjnbBqyekNyKDPnORTe1upRtb6A4ekvdemySmFe0lxMEkES+fOTqbB2Trz/kPYIiVXchvXt0uHpmnmGLHKot7IXQuhXys6aByEY5TMViRg1qcQcg77DsgfSJs9rSxCRwiR8E6/E/z/3IT+r/zztO9rijPFy9fXbEZ+Cs2lWZbKGtK10zNfRGr7kVgHpHJBjnobm9bHNmCuGcIeJ6Jm/xKXRYcXT0E/lTeOulgu0cx4PMuT8eZOSklg1vwiuHRMUlqKFbTrvAxiec0gNAy6qY0VkpdMeVIzuotn1MZvhzD6+ns1ch44FbYwLCXgDhnTeXkqQjfUstM2jI0NCiTTm2RFRzoKczw8WspYwHPLZXxdv/Eudtr1DFWhDqam2YLokOyyR+m6TpSpzcRZyW8KJTseurF7e6d5FzcciFxJ8QE8/3x+TMNRUHzbsIULYNPrMW1deWGu+NVlw1TNEaBz49n0Y+qbLTuDy2JtzkDWfhIG2YcSPIiRGc2u7owo/dbSnHvYX8UVng2WXezWel/dbZ3G5Rl6RM+OL//vEZB0XV4djrg14xpboDpWs34PPwPdB42ByTqxYZInyR6JXR7lHM9FFRJM4wS6/w==
X-Forefront-Antispam-Report: CIP:216.228.112.36; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid05.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(70586007)(316002)(47076005)(36860700001)(1076003)(186003)(82310400003)(26005)(54906003)(6666004)(336012)(110136005)(70206006)(426003)(36756003)(36906005)(2616005)(107886003)(4326008)(8676002)(5660300002)(83380400001)(508600001)(2906002)(86362001)(8936002)(7636003)(356005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 14:47:26.6488 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb02b1ce-e267-4f69-71c4-08d9a2c6aeae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.36];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0155
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211108_064736_562648_BAEF6BF6 
X-CRM114-Status: UNSURE (   9.88  )
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

Enable NVME_QUIRK_SKIP_CID_GEN quirk if "--skip-cid-gen" flag was
set by the user during the connect command for FC transport.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/fc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index be9892894849..919313aaa902 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3453,6 +3453,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	struct nvme_fc_ctrl *ctrl;
 	unsigned long flags;
 	int ret, idx, ctrl_loss_tmo;
+	unsigned long quirks = 0;
 
 	if (!(rport->remoteport.port_role &
 	    (FC_PORT_ROLE_NVME_DISCOVERY | FC_PORT_ROLE_NVME_TARGET))) {
@@ -3568,7 +3569,10 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	 * Defer this to the connect path.
 	 */
 
-	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_fc_ctrl_ops, 0);
+	if (opts->skip_cid_gen)
+		quirks |= NVME_QUIRK_SKIP_CID_GEN;
+
+	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_fc_ctrl_ops, quirks);
 	if (ret)
 		goto out_cleanup_admin_q;
 
-- 
2.18.1


