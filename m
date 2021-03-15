Return-Path: <SRS0=15CP=IN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50624C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 14:56:55 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC2C864E76
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 14:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC2C864E76
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HEwsFWQ7WaBr8pbcXgWFREM2kNNFzqk+92fguka08PI=; b=kIcOBwT8qv6uReqtUrR4RIJjMb
	pAtZ9gFu8sC/ZTgj/My5vQoMPdi+piSTvFo0l1BQ7jvNdaHVYFDg0ZxTOOkP7k7msLD+4VXNXLfAh
	CV+OJNgozyn9r1hPGHttjIBxX53/E1YRRTdte6tMcKkmQb09gHsVOYgJnCNpmzcubuQkScHsIWS3Y
	obwQUgWuKr6oCcocrZjnolIVkGYD3N0WfeXPJJtMEJUh7RmcO3Q7hY/U+JbO9Kh+vkV+raT9KK4aL
	TOwsgSnCHNNZjHEn6UfD+dk3TRHX1+E1ffQRHownSNvkDAkXhD72Oya0a70vv0i54EzP08RZVr0OR
	5AReohqA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lLoe1-00GD5b-NZ; Mon, 15 Mar 2021 14:56:33 +0000
Received: from mail-co1nam11on2089.outbound.protection.outlook.com
 ([40.107.220.89] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLodu-00GD3U-Av
 for linux-nvme@lists.infradead.org; Mon, 15 Mar 2021 14:56:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fs8uE9SavXq2ITT8tq1x+0AgqnlCMtoJ+w+PVOu7ww1nTb+bfLTZFvK9vDr+xfgpWyoV82OLOLWJZ/zHUcYFEXJuDZf+FcIQMCl00trMNJXONM/HsTqN+jxN/pP8TTbowz0sLjE3AYErR/iSoh1EZDbIjIPRl244dBFSkdryqFxXsGEk502fb8duN20BBlxz7cHvSb+qw044HGdnZ2hJwZS6zPmS1WTlMoVBG0B2jYqYtLQ+/1c0Fq3y9OVw6WDsKS2hudlxWzrPjtr3ZeUDH98LBeuipsrNy0e4i+8kkHP/UTLJ5pIv4DQE5JgyYnP9n7O15Owk8Fc6te3PKl3q3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9IVyL63r5Byxa4F9GrnUIB5gdC78NpJPAREYAydVho=;
 b=aY5bG03GytnRFzN2sntp5vBDVhB8a5yubVPUmymz0/G4qAqoR3Y+SYHsYfS5e0GqCkU323wecw4cYsFhCATuOeNGSMkOa8fkaJFfiJuuUs/G9Sv2VrY62nrjpEqsz3KjqkcswfP59y8R+xx25LffE7klOIR3wwK83bpFxKOLmqrX4tzuxeBCxmnsB9zC3ajetAXtduaYX7pjDx7fv7y6zOjhrXVY/9H4YoZwnXFo04+NohfkAOTqe4GfpCMR0kJ3D6fNyOMLTBUgbsIGxWJNraVBbSxTxw5/uV0RwMv8K3nmXBPbyc8BgXrTSRiNT3Z6eH6smWlKrso11JghgKx27Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9IVyL63r5Byxa4F9GrnUIB5gdC78NpJPAREYAydVho=;
 b=IQ7+KiFurhk8f11qhn7fJ0oFZRukSXzfbPq1fkH068dYrN45rVY4MGaob8NadrgADTaqk0mVl6OsYU3fdTjixh+QkhQPNOTmnnPQDYwBvHmhHI7yfSkh+gLzeFRL1/qdOFFRPkHIvuYtBWcDsrDCcf1hI6gozhrhUSl0RHi9ohLHRKd9VVDM1yq/rXUDhLteGFLGNirdJjomLWMj5G9Sje/TIlzGG2gFTAu7asabVy0HqjwFqYho7s8hyFoIAZrxL7WJVYYmxTAVRFC7tfH1sMJCRQQD+Nm6TB3LRHnVUHzjzs5w9x5IwVkqcM9JuftGxxqQx3Biuf6/hmPovUPM+A==
Received: from BN6PR19CA0050.namprd19.prod.outlook.com (2603:10b6:404:e3::12)
 by BN6PR1201MB0132.namprd12.prod.outlook.com (2603:10b6:405:4d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 14:56:18 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:e3:cafe::b6) by BN6PR19CA0050.outlook.office365.com
 (2603:10b6:404:e3::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32 via Frontend
 Transport; Mon, 15 Mar 2021 14:56:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3933.31 via Frontend Transport; Mon, 15 Mar 2021 14:56:18 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 15 Mar
 2021 14:56:18 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 15 Mar
 2021 14:56:17 +0000
Received: from r-nvmx02.mtr.labs.mlnx (172.20.145.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 15 Mar 2021 14:56:15 +0000
From: <ngottlieb@nvidia.com>
To: <mgurtovoy@nvidia.com>, <sagi@grimberg.me>, <hch@lst.de>,
 <kbusch@kernel.org>, <chaitanya.kulkarni@wdc.com>,
 <linux-nvme@lists.infradead.org>
CC: Noam Gottlieb <ngottlieb@nvidia.com>
Subject: [PATCH 1/1] nvmet: do not allow model_number exceed 40 bytes
Date: Mon, 15 Mar 2021 14:56:11 +0000
Message-ID: <20210315145611.155972-1-ngottlieb@nvidia.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83fefaff-782e-4d6e-a223-08d8e7c27d80
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0132:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB01329231EF12E9C3B26B1885CC6C9@BN6PR1201MB0132.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +gx9MjoVW636zvEkltJTWU7/zOYGZNADFd+UKoGFTchEV0FbN6qOBjZ2MtFGqRmlurAyFJkMnxMYhHVPPEPMz7mkTINTB0LnOtli5cBAtTYPVfQf/swDHAUD2AuIg+YuzxXBjH591RCCDH3I6KREF9tY7A9C4fqpa4M0G8ZNEmU0nBUh9QD6ijHRI5h6Lzmq28+U6V9JvtFZl885m2btzGGBR31iY9oOvw7CEj5puhGNIbh2VQQlok9stjDu+YTaT7Qtefp0lSv7pBgMIf03S+Dcsuf8Hu85/lWSeTK2AJgpWFPR0b4n4XJxqOaKAGCyYbySTeb0WTjUZx+J/cJ5r1X+/6J4OcGjKEBgGJps8FKupPiG/NniLc+qguaMEi28ihBSSpzP6iGPVsUrnkiP0AMx8QCuArju1EdR24Nw3Y5V8gZGnjNQ5es2EinfrPSB2faj2R/h5sPecjPS01sXWJ9aD1+WJMvfMG7cgI1UdtCt62tPdkhWss9UXP5RXyeq3C/AKfPAdFzqwE9xytgFiq4vTeZIPs2ZaU5Q3kcrXvafp6eBDhqUla/LIs7Wo0+mubXyrSfJkXmvOLS7rzF71Bf8B+HWNZxoCWjSxP9tClkx7XdJS/X0vIX+6RM8AycHqkCKV1/yR40fJGQVgySsanODKXmHY0tKoWRcEWrf5Qr5FjE3yKOTC3ghouFNJzXO
X-Forefront-Antispam-Report: CIP:216.228.112.36; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid05.nvidia.com; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(46966006)(36840700001)(1076003)(2616005)(70586007)(6666004)(110136005)(356005)(336012)(426003)(47076005)(36906005)(70206006)(8936002)(5660300002)(34020700004)(7636003)(82310400003)(4326008)(36756003)(86362001)(2876002)(478600001)(107886003)(83380400001)(26005)(2906002)(316002)(8676002)(82740400003)(186003)(36860700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 14:56:18.6459 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83fefaff-782e-4d6e-a223-08d8e7c27d80
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.36];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0132
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210315_145626_924842_8BAB7B74 
X-CRM114-Status: GOOD (  10.04  )
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

From: Noam Gottlieb <ngottlieb@nvidia.com>

According to the NVM specifications, the model number size should be
40 bytes (bytes 63:24 of the Identify Controller data structure).
Therefore, any attempt to store a value into model_number which
exceeds 40 bytes should return an error.

Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Noam Gottlieb <ngottlieb@nvidia.com>
---
 drivers/nvme/target/configfs.c | 6 ++++++
 drivers/nvme/target/nvmet.h    | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 635a7cb45d0b..40c8980387a6 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1150,6 +1150,12 @@ static ssize_t nvmet_subsys_attr_model_store(struct config_item *item,
 	if (!len)
 		return -EINVAL;
 
+	if (len > NVMET_MN_MAX_SIZE) {
+		pr_err("Model nubmer size can not exceed %d Bytes\n",
+		       NVMET_MN_MAX_SIZE);
+		return -EINVAL;
+	}
+
 	for (pos = 0; pos < len; pos++) {
 		if (!nvmet_is_ascii(page[pos]))
 			return -EINVAL;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index cdfa537b1c0a..6871dd2884f9 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -27,6 +27,7 @@
 #define NVMET_ERROR_LOG_SLOTS		128
 #define NVMET_NO_ERROR_LOC		((u16)-1)
 #define NVMET_DEFAULT_CTRL_MODEL	"Linux"
+#define NVMET_MN_MAX_SIZE		40
 
 /*
  * Supported optional AENs:
-- 
2.18.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
