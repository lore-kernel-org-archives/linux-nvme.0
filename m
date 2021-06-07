Return-Path: <SRS0=yMBa=LB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADECC47082
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 09:39:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE6EC61107
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 09:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE6EC61107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=J7oJX3azTR3hjIp9D4maHGMlZTKRMcc7S86GO7Z0CBc=; b=KlfJC+xVUYDnCJ
	TKxAYKjX1Vkoz/Au9seh6QlqfdUAj4uYP4XocmLjMs/Qf6NkazoIJlwaR22e/TxGSL9tLUAE+oxCF
	pRLe/Hf4GI/4c/AAXbZfZ1USsaEIqiiolk3MUAz8noK+RYiirSQv6QggLtZoeLJ8KiXMie5WnyEDS
	f/b3HBTkhA0nq6Wayqbd8YLYoUyOG8ktz/UKpQ9JAtO1xS0qJT4rzg8S+7UPiXgJsdgTF5nDMiMP6
	pR/tyAaHKSaKow1abcu+LgRKEcB8jWeKZp4S2FdquwYdsOb/GJsjvCAIdCUsjRA1giDQSEgLr4HZJ
	kG4r4VRf0UKEXeypoNPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqBiw-002f24-TQ; Mon, 07 Jun 2021 09:39:11 +0000
Received: from mail-co1nam11on2044.outbound.protection.outlook.com
 ([40.107.220.44] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqBTq-002Z5r-7P
 for linux-nvme@lists.infradead.org; Mon, 07 Jun 2021 09:23:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fpyHIUh4t4vQw8pDZOSpFE7aZ/9MTr0AeWyFCS7griSoM7G0CecXaQOlziMmAgHYvOnSGmjixOBSyP2u37IkjVpZ0LA+8aZZA2zmnHEEmUzpjswCcZRhx5RBahgiTBVECmAbuDe70wniXTIV1JCVtmr+iXggPTXrSHOAN+QL3DAYPiNuXiAN0AA1Ihom5dazT1WBspn2pFF7CdF9aL8rBOrxOjJK6ymTPTKxRrs0g08GpryWETzyQ0JcKzWmxkYyIgtKDrWrVnyDs1IPn7f/BVVqYw8z1QDCHCeeSWzK6VtzRg4uu8JTyL8AjhCLQZSHcqTlVpqzU01U81/tlVPm4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qn8Lf1Hct/WA529SGpXVawhEYAb0bkVkcSsX7tsyv+w=;
 b=gO49+E2Hoz1beTQRTp0I0vNL/VcRS1QSe6JnnM+kvedUnedw+hqGSQLflKifnw/oYXnmLtN1JZYokRpOF96C7+FePyoa8BHft1RNi39mh1qVuEjocDisuasGBvbKM8tCykPwCtSp9IlpqpPbvP1FsQlvkFbOiTlRbcph3bzImzO75deeydez/6Z5uCdYG6F7wo2dkXvQBBKWMy7E/2HYObwZqMejM7hC5rrN4MgHvzfX6Y6JQ4yczr6paPsbZMJeFfuYYxvn8S6OGsv8//Ak7TNvB8/g9nOx8jE1mrhLs0RY46RUyNobOIH4r9w0rgtrrwWAxrFpDS5H2C1O95MUEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qn8Lf1Hct/WA529SGpXVawhEYAb0bkVkcSsX7tsyv+w=;
 b=S1ndlrQ6eyWvqzANsPCMwx4QXEPavzseq94Ct07NU5uM/09WWOyszMbKbGgfrh8UeNhDjvvCp/iTBSwAnG/rUdk0lK1xUXOBfcP6im3SmGzilUs7rJ/uof/gkNfulqrWeJpgakSIkOiFV/8007vtu/UvGzxS9VC4EldWVB2wR89GR88T51hS0x+8li2EvR4CFI+my4tqUrQhI7QF8JHj4Y0P4P9sGUmWGvzbR+EhwaSf2F+si1KFEwFCmtc3ADgoaCMQS6mU/kT/6Bt1lOo4qUexR7opy4QfY5jBUKpc4hITpmpZZZXIB2UF7kD8AeO07FyoSmOwuMsJvoY7rM4gnQ==
Received: from DM5PR06CA0077.namprd06.prod.outlook.com (2603:10b6:3:4::15) by
 MW3PR12MB4588.namprd12.prod.outlook.com (2603:10b6:303:2e::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.23; Mon, 7 Jun 2021 09:23:28 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::c8) by DM5PR06CA0077.outlook.office365.com
 (2603:10b6:3:4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend
 Transport; Mon, 7 Jun 2021 09:23:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 09:23:28 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 7 Jun
 2021 09:23:28 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 7 Jun
 2021 09:23:27 +0000
Received: from r-nvmx02.mtr.labs.mlnx (172.20.187.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 7 Jun 2021 09:23:25 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <kbusch@kernel.org>, 
 <hch@lst.de>, <chaitanya.kulkarni@wdc.com>
CC: <ngottlieb@nvidia.com>, <oren@nvidia.com>, Max Gurtovoy
 <mgurtovoy@nvidia.com>
Subject: [PATCH v2 1/4] nvmet: change sn size and check validity
Date: Mon, 7 Jun 2021 12:23:21 +0300
Message-ID: <20210607092324.1031046-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23af1f98-4e47-478e-e0f9-08d92995e8ed
X-MS-TrafficTypeDiagnostic: MW3PR12MB4588:
X-Microsoft-Antispam-PRVS: <MW3PR12MB458890A348DC9577BFE5F6A7DE389@MW3PR12MB4588.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B5er7UAB/Zje9tMAq0h3+FIPM08K1Cvvrb9TLIMOhezd1abw6ckjTQzcsNymBRvlwIYXwu2TF1zCU3D6FqeSsydLKDHSNwJ8yQda/v8zZkFvJsFNjVfdnOTJlnTQt3zFKu4chg6SwxzhJo8L1sIB6vsYpANnmIHIsdfy+4eqpl+iyzvebvy66U1HyoQGm/Wudz+xHIdx1MUbbWT3AnSw72flROpUHygYVrrwYb5LrlIpFtMIvlvnDLWgAj/fL7+jhARZDU/41F+X4GNe7m5GawsxdMXda1GErMECd3syPw/ClBob//myIVowy9EbpQRPv2CGyy1d3u02qYmTstxNLztgggqsJWsKM8mbv9qSVfulsJbCpF5Sg/jjWDHfEC2Lm0Uau8vL8UZPEA7kdq8UxKA8w+eL+/EN1+fJwUmThwUeMeBtyg7yGJ3HSYpCiJ+HH+WQTfG2jackGyd9SDMZa9/ucRTSpoYNtq1zZ4dN1y192fDzYgbj3nrE9wpMamVuaBFR7YSZQFcNU5bm3mELK9IlOiby4c2R+aOFtvJkuJs+Kscok5ltVnWUZ9A0XLuHa1vD4vJMaspqT6OGbHmqAISfX+Hlf9m0gzJqyRHQfCTMjjRvMhU1J9RXeZw2RGzye1SGkY+26Se1rpyDvOVI1wecRTsyHIyvKEDGOITgzNQ=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(46966006)(36840700001)(107886003)(8676002)(70586007)(2616005)(1076003)(336012)(86362001)(82310400003)(8936002)(36906005)(70206006)(316002)(7636003)(36860700001)(2906002)(36756003)(26005)(356005)(4326008)(5660300002)(54906003)(426003)(6666004)(110136005)(47076005)(82740400003)(186003)(83380400001)(478600001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 09:23:28.3337 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23af1f98-4e47-478e-e0f9-08d92995e8ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4588
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210607_022334_578882_DC6E82FC 
X-CRM114-Status: GOOD (  14.54  )
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

According to the NVM specification, the serial_number should be 20 bytes
(bytes 23:04 of the Identify Controller data structure), and should
contain only ASCII characters.

In accordance, the serial_number size is changed to 20 bytes and before
any attempt to store a new value in serial_number we check that the
input is valid - i.e. contains only ASCII characters, is not empty and
does not exceed 20 bytes.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Noam Gottlieb <ngottlieb@nvidia.com>
---

changes from v1: minor nits from Chaitanya

---
 drivers/nvme/target/admin-cmd.c |  4 +---
 drivers/nvme/target/configfs.c  | 33 +++++++++++++++++++++++----------
 drivers/nvme/target/core.c      |  4 +++-
 drivers/nvme/target/discovery.c |  4 +---
 drivers/nvme/target/nvmet.h     |  3 ++-
 5 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index dcd49a72f2f3..9c73dbfb8228 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -357,9 +357,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	id->vid = 0;
 	id->ssvid = 0;
 
-	memset(id->sn, ' ', sizeof(id->sn));
-	bin2hex(id->sn, &ctrl->subsys->serial,
-		min(sizeof(ctrl->subsys->serial), sizeof(id->sn) / 2));
+	memcpy(id->sn, ctrl->subsys->serial, NVMET_SN_MAX_SIZE);
 	memcpy_and_pad(id->mn, sizeof(id->mn), subsys->model_number,
 		       strlen(subsys->model_number), ' ');
 	memcpy_and_pad(id->fr, sizeof(id->fr),
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 65a0cf99f557..027b28aaf7cd 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1030,24 +1030,43 @@ static ssize_t nvmet_subsys_attr_version_store(struct config_item *item,
 }
 CONFIGFS_ATTR(nvmet_subsys_, attr_version);
 
+/* See Section 1.5 of NVMe 1.4 */
+static bool nvmet_is_ascii(const char c)
+{
+	return c >= 0x20 && c <= 0x7e;
+}
+
 static ssize_t nvmet_subsys_attr_serial_show(struct config_item *item,
 					     char *page)
 {
 	struct nvmet_subsys *subsys = to_subsys(item);
 
-	return snprintf(page, PAGE_SIZE, "%llx\n", subsys->serial);
+	return snprintf(page, PAGE_SIZE, "%s\n", subsys->serial);
 }
 
 static ssize_t nvmet_subsys_attr_serial_store(struct config_item *item,
 					      const char *page, size_t count)
 {
-	u64 serial;
+	struct nvmet_subsys *subsys = to_subsys(item);
+	int pos, len = strcspn(page, "\n");
 
-	if (sscanf(page, "%llx\n", &serial) != 1)
+	if (!len || len > NVMET_SN_MAX_SIZE) {
+		pr_err("Serial Number can not be empty or exceed %d Bytes\n",
+		       NVMET_SN_MAX_SIZE);
 		return -EINVAL;
+	}
+
+	for (pos = 0; pos < len; pos++) {
+		if (!nvmet_is_ascii(page[pos])) {
+			pr_err("Serial Number must contain only ASCII strings\n");
+			return -EINVAL;
+		}
+	}
 
 	down_write(&nvmet_config_sem);
-	to_subsys(item)->serial = serial;
+	mutex_lock(&subsys->lock);
+	memcpy_and_pad(subsys->serial, NVMET_SN_MAX_SIZE, page, len, ' ');
+	mutex_unlock(&subsys->lock);
 	up_write(&nvmet_config_sem);
 
 	return count;
@@ -1128,12 +1147,6 @@ static ssize_t nvmet_subsys_attr_model_show(struct config_item *item,
 	return ret;
 }
 
-/* See Section 1.5 of NVMe 1.4 */
-static bool nvmet_is_ascii(const char c)
-{
-	return c >= 0x20 && c <= 0x7e;
-}
-
 static ssize_t nvmet_subsys_attr_model_store_locked(struct nvmet_subsys *subsys,
 		const char *page, size_t count)
 {
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 4ae4bea6625d..213a0c2af4f7 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1493,6 +1493,7 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 		enum nvme_subsys_type type)
 {
 	struct nvmet_subsys *subsys;
+	char serial[NVMET_SN_MAX_SIZE / 2];
 
 	subsys = kzalloc(sizeof(*subsys), GFP_KERNEL);
 	if (!subsys)
@@ -1500,7 +1501,8 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 
 	subsys->ver = NVMET_DEFAULT_VS;
 	/* generate a random serial number as our controllers are ephemeral: */
-	get_random_bytes(&subsys->serial, sizeof(subsys->serial));
+	get_random_bytes(&serial, sizeof(serial));
+	bin2hex(subsys->serial, &serial, sizeof(serial));
 
 	switch (type) {
 	case NVME_NQN_NVME:
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index fc3645fc2c24..b7fdad13094a 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -262,9 +262,7 @@ static void nvmet_execute_disc_identify(struct nvmet_req *req)
 		goto out;
 	}
 
-	memset(id->sn, ' ', sizeof(id->sn));
-	bin2hex(id->sn, &ctrl->subsys->serial,
-		min(sizeof(ctrl->subsys->serial), sizeof(id->sn) / 2));
+	memcpy(id->sn, ctrl->subsys->serial, NVMET_SN_MAX_SIZE);
 	memset(id->fr, ' ', sizeof(id->fr));
 	memcpy_and_pad(id->mn, sizeof(id->mn), model, sizeof(model) - 1, ' ');
 	memcpy_and_pad(id->fr, sizeof(id->fr),
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index d69a409515d6..0ae809ca428c 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -28,6 +28,7 @@
 #define NVMET_NO_ERROR_LOC		((u16)-1)
 #define NVMET_DEFAULT_CTRL_MODEL	"Linux"
 #define NVMET_MN_MAX_SIZE		40
+#define NVMET_SN_MAX_SIZE		20
 
 /*
  * Supported optional AENs:
@@ -229,7 +230,7 @@ struct nvmet_subsys {
 	u16			max_qid;
 
 	u64			ver;
-	u64			serial;
+	char			serial[NVMET_SN_MAX_SIZE];
 	char			*subsysnqn;
 	bool			pi_support;
 
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
