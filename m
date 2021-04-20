Return-Path: <SRS0=/SuC=JR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974E4C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 09:10:14 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C158B6135F
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 09:10:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C158B6135F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CY68Htqn6W4bHQKSAPNBqKno5mPyzmXbOPy6uigc6y8=; b=gaI3AoxuaR2f645P5bjalqBha
	0+X2R5TqeaA5/iH4Wn1EM5Ld9iwQ85x2PoqQDYu9VhhDZNHgdv8eWeQ+4reHH3uWs5hLIaDoJt8Ow
	QckCGlGz/EEgQChU30GYd91pwrgDat/ECAGnoeKhlkiRln36gcHNm7iqJGFszUMSenPWUeQxReQQT
	lq6O2fn4ALFrR/HkEJwcCMu1SoD0lGfjG5nZBYBSqvTrFDYm72TaM4YH3+zeOkmIcUMaDRL1auI/A
	mwtWrfeeULLO4DbJl2wrucHp0y758gla1EEqkbY62jmOgAPLNk/YakW7/2zJwQMfujUA3gtFoNXjj
	c6INnsgMQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYmO9-00BfuH-W7; Tue, 20 Apr 2021 09:09:46 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYmNl-00BfsH-GC
 for linux-nvme@desiato.infradead.org; Tue, 20 Apr 2021 09:09:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
 :Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=QKFPvD6PNAmVNcmWIdmPAESvqUib85imph0UGS0ShZ8=; b=og4z/vCfHXlv+ncjwU5V7/0h7N
 KtuhxLuXjPkzyfEqwW8uovoLNR2B7i+J1KRp+6Wok5D5Wap0yv9lSHyP1ZdfQ5GtbcVgQeTZfKrJr
 Ui90gR/VROlLlqR9t4hdnM5Oe+Y/ayKZ2kZ0QcINv/DxHq8vCCs77HuyFIpbE/cvMopgf6Ulc47ge
 d89VH2051LvUh1EutTLbI6zlhzZdbUp8KcXMWGDuVe5bn9wn/ZwZFick3SQ5aW171Eh9QRqwMFUjv
 pEQJMF73l1EjWr05wC9//EZ8F8cwz3dN9I09XVE0xeDUPI5TFxK2ETXN0gQqT6SHdS0c//udwPbU2
 Y0oYvtTA==;
Received: from mail-dm6nam12on2055.outbound.protection.outlook.com
 ([40.107.243.55] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYmNg-00BxNW-HY
 for linux-nvme@lists.infradead.org; Tue, 20 Apr 2021 09:09:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/kUf9T22BP90zHJJJyqv4OahWR6AqRGzRLoUqjnmKgY81zQqZm9DQc9snrfxA8LyF4nnWIAhL5gSgv14+4PcvMMKrqxHqGzyOYOWwMyb4TeNoCU5vgUlq6oGEkkXglzALKDNCqckkEAmWxazJEWHY/+HVhPlJcFohu9OcHUmjsU59f99YFxPoIh/N1vDFLzM45sA1qUKBd6lGe4dbJ5tRx4POd+jfX72FwQ3WVEsvBG2ZCQeEwILDW9+UsgfeWGjGoTU46j75FOkP2BqkTNLsL5ZqgqjKk0bZo14wikiAQsfZjNjug4KIHWEbL8k/KtezzFF3Ec2rJQz4N646dsZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKFPvD6PNAmVNcmWIdmPAESvqUib85imph0UGS0ShZ8=;
 b=geZ0aoGAqgm7mu3sMnflvaBQoJlXtQ6UG1x0kOJ35YIJC3N1HmWguOWv5daGkmcgAyYKLt6T/Rna16RKhXjktW3I7bo2/Hvvo9tZu5bOq7e5wWkKoDrZ4fNGgB+Yi6Doo40TEJhCULrxtWZ7oaTADqTQMc8jRB/JDoZYTrpzaPtHTi5UFvjgwefasF2oO804thrLRggWI4BhNyqKCSOfAUbzC6OCp7tM2tBhelonobFTnVTXifFMKHdJ/LfJ9cz6+0knJNxq+FADq6Yy4o9U3+dy7RZWgZ1fRZ2NsNb+lsScotSKh4eD+22lW7E+1xOo8QZ41bqP6aC4O4gP5PKLUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKFPvD6PNAmVNcmWIdmPAESvqUib85imph0UGS0ShZ8=;
 b=VbQPIWnK4IXbR4cjX8cI7uQcBDRgRWAQ/bXJ24o5g9nwanwBub4pcx8qGgm/qixiaDTODmq9+BlFpukdFpZ+OkJ6UBzk+0H0CaLPC+KmAzJ+SSRBjt6ty4AZUpLpbGl2GCjk27R9KX1yc2iSnU1YyeTFOBvGDwLyr6tdJGUFGKhw65jnDdMX7xFyxPI5LwK0A5uc0VhE3oA9jdf+7bhoBu0+57T9FXiNutP0L/Q4IRWcGZl2R3IeEwcjjV2c+GXCJsdJVDp89ReBszquK7li1ViaDm4PPMJa/ActpjiIn4KTU7BzlJ3Dvw3asupsxhDhY87zR+5SytYQNi9yCHS+8Q==
Received: from BN6PR18CA0007.namprd18.prod.outlook.com (2603:10b6:404:121::17)
 by MN2PR12MB2992.namprd12.prod.outlook.com (2603:10b6:208:d2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.24; Tue, 20 Apr
 2021 09:09:12 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:121:cafe::2a) by BN6PR18CA0007.outlook.office365.com
 (2603:10b6:404:121::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Tue, 20 Apr 2021 09:09:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4042.16 via Frontend Transport; Tue, 20 Apr 2021 09:09:11 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Apr
 2021 02:09:11 -0700
Received: from r-nvmx02.mtr.labs.mlnx (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Apr 2021 09:09:09 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <kbusch@kernel.org>, 
 <hch@lst.de>, <chaitanya.kulkarni@wdc.com>
CC: <oren@nvidia.com>, <ngottlieb@nvidia.com>, <mgurtovoy@nvidia.com>
Subject: [PATCH 3/4] nvmet: allow mn change if subsys not discovered
Date: Tue, 20 Apr 2021 09:09:02 +0000
Message-ID: <20210420090903.595664-3-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210420090903.595664-1-mgurtovoy@nvidia.com>
References: <20210420090903.595664-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32cc5fa2-c6b0-4b98-b734-08d903dbf6a3
X-MS-TrafficTypeDiagnostic: MN2PR12MB2992:
X-Microsoft-Antispam-PRVS: <MN2PR12MB2992174EBC9A8090DC70EBA6DE489@MN2PR12MB2992.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 66blPy3x9Bxsg4ETnpxRzSYK2Z3C0UHHBkAS35yELP173ixURNQPizsBX+6fqZMjK8naNrOAyiS5fY4QvQE9eBzUs8NiKTdF+rH5LG7wjmVAxE7ft/sx/svx8w1FadDXkezy8ykbMd37WEhqIiKs8tnZlLu6QF7ALkdHpoKcdsd7VyqJhd2SkXXaP4J/sWJvMg4SqschkyPZGXSJDL0anPW/5fYCcJ/3/kLUjGj7W+Ue2lygn2trR/n2bp5yrdV4BVRVVeUNyDO/QgXR9t2C4fRJVzwMBupChVSYbgct0JRoFf3uWDSnGGJTR7vK+7sTpieKHT4fPwpUSfhxZXZE9bUqfXx+/GGFP/nEaJO9qMNrcIW2J9eaYYupy86M+875E+7kzT69XW/3MUTzDPzxO+gr4LPDeLowHY3/qUzOnQyqkp52ZNGuV5wDj82n8B2IsWEWuZAknRD9coIH5DKZZMAsPOBunsQ2PWmSMnefhytq6v+75YmXX8kVnsyAEmqx4uNuoc0ZNVAZZ6DCZYGPN5hKAy4Y2SFziKhvR5hq2HiwU0WFfmVWUPW3huUUBrykIp3AuZq5sLCiXMBRfFXvKbQH28Ekf5jMzstYytGgNXKj1E1yQeF2I5TXbB9QFK7f58MPCUmPRIo80wAccxbk5IPF2RD+GENSmxeAg+krJsM=
X-Forefront-Antispam-Report: CIP:216.228.112.32; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid01.nvidia.com; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(46966006)(36840700001)(82740400003)(7636003)(54906003)(8676002)(82310400003)(83380400001)(6666004)(186003)(356005)(8936002)(36860700001)(86362001)(2616005)(110136005)(26005)(4326008)(316002)(1076003)(426003)(2906002)(107886003)(5660300002)(36756003)(478600001)(336012)(70586007)(47076005)(70206006);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 09:09:11.8552 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32cc5fa2-c6b0-4b98-b734-08d903dbf6a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.32];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2992
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210420_020916_613899_808EDCB4 
X-CRM114-Status: GOOD (  17.40  )
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

Currently, once the subsystem's model_number is set for the first time
there is no way to change it. However, as long as no connection was
established to nvmf target, there is no reason for such restriction and
we should allow to change the subsystem's model_number as many times as
needed.

In addition, in order to simplfy the changes and make the model number
flow more similar to the rest of the attributes in the Identify
Controller data structure, we set a default value for the model number
at the initiation of the subsystem.

Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Noam Gottlieb <ngottlieb@nvidia.com>
---
 drivers/nvme/target/admin-cmd.c | 26 --------------------------
 drivers/nvme/target/configfs.c  | 10 ++--------
 drivers/nvme/target/core.c      | 21 +++++++++++++++++----
 drivers/nvme/target/discovery.c |  4 ++--
 4 files changed, 21 insertions(+), 40 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 712e09f8158b..954de0d813d6 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -313,22 +313,6 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
 }
 
-static u16 nvmet_set_model_number(struct nvmet_subsys *subsys)
-{
-	u16 status = 0;
-
-	mutex_lock(&subsys->lock);
-	if (!subsys->model_number) {
-		subsys->model_number =
-			kstrdup(NVMET_DEFAULT_CTRL_MODEL, GFP_KERNEL);
-		if (!subsys->model_number)
-			status = NVME_SC_INTERNAL;
-	}
-	mutex_unlock(&subsys->lock);
-
-	return status;
-}
-
 static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
@@ -343,16 +327,6 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 		mutex_unlock(&subsys->lock);
 	}
 
-	/*
-	 * If there is no model number yet, set it now.  It will then remain
-	 * stable for the life time of the subsystem.
-	 */
-	if (!subsys->model_number) {
-		status = nvmet_set_model_number(subsys);
-		if (status)
-			goto out;
-	}
-
 	id = kzalloc(sizeof(*id), GFP_KERNEL);
 	if (!id) {
 		status = NVME_SC_INTERNAL;
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 7040d92bb31a..61a9a52da30d 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1156,14 +1156,8 @@ static ssize_t nvmet_subsys_attr_model_show(struct config_item *item,
 					    char *page)
 {
 	struct nvmet_subsys *subsys = to_subsys(item);
-	int ret;
-
-	mutex_lock(&subsys->lock);
-	ret = snprintf(page, PAGE_SIZE, "%s\n", subsys->model_number ?
-			subsys->model_number : NVMET_DEFAULT_CTRL_MODEL);
-	mutex_unlock(&subsys->lock);
 
-	return ret;
+	return snprintf(page, PAGE_SIZE, "%s\n", subsys->model_number);
 }
 
 static ssize_t nvmet_subsys_attr_model_store_locked(struct nvmet_subsys *subsys,
@@ -1171,7 +1165,7 @@ static ssize_t nvmet_subsys_attr_model_store_locked(struct nvmet_subsys *subsys,
 {
 	int pos = 0, len;
 
-	if (subsys->model_number) {
+	if (subsys->subsys_discovered) {
 		pr_err("Can't set model number. %s is already assigned\n",
 		       subsys->model_number);
 		return -EINVAL;
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 3efd48b0a34e..84e9a4b261b3 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1483,6 +1483,7 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 {
 	struct nvmet_subsys *subsys;
 	char serial[NVMET_SN_MAX_SIZE / 2];
+	int ret;
 
 	subsys = kzalloc(sizeof(*subsys), GFP_KERNEL);
 	if (!subsys)
@@ -1493,6 +1494,12 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 	get_random_bytes(&serial, sizeof(serial));
 	bin2hex(subsys->serial, &serial, sizeof(serial));
 
+	subsys->model_number = kstrdup(NVMET_DEFAULT_CTRL_MODEL, GFP_KERNEL);
+	if (!subsys->model_number) {
+		ret = -ENOMEM;
+		goto free_subsys;
+	}
+
 	switch (type) {
 	case NVME_NQN_NVME:
 		subsys->max_qid = NVMET_NR_QUEUES;
@@ -1502,15 +1509,15 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 		break;
 	default:
 		pr_err("%s: Unknown Subsystem type - %d\n", __func__, type);
-		kfree(subsys);
-		return ERR_PTR(-EINVAL);
+		ret = -EINVAL;
+		goto free_mn;
 	}
 	subsys->type = type;
 	subsys->subsysnqn = kstrndup(subsysnqn, NVMF_NQN_SIZE,
 			GFP_KERNEL);
 	if (!subsys->subsysnqn) {
-		kfree(subsys);
-		return ERR_PTR(-ENOMEM);
+		ret = -ENOMEM;
+		goto free_mn;
 	}
 	subsys->cntlid_min = NVME_CNTLID_MIN;
 	subsys->cntlid_max = NVME_CNTLID_MAX;
@@ -1522,6 +1529,12 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 	INIT_LIST_HEAD(&subsys->hosts);
 
 	return subsys;
+
+free_mn:
+	kfree(subsys->model_number);
+free_subsys:
+	kfree(subsys);
+	return ERR_PTR(ret);
 }
 
 static void nvmet_subsys_free(struct kref *ref)
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index f39946615fd6..6689bd27d629 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -244,7 +244,6 @@ static void nvmet_execute_disc_identify(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvme_id_ctrl *id;
-	const char model[] = "Linux";
 	u16 status = 0;
 
 	if (!nvmet_check_transfer_len(req, NVME_IDENTIFY_DATA_SIZE))
@@ -264,7 +263,8 @@ static void nvmet_execute_disc_identify(struct nvmet_req *req)
 
 	memcpy(id->sn, ctrl->subsys->serial, NVMET_SN_MAX_SIZE);
 	memset(id->fr, ' ', sizeof(id->fr));
-	memcpy_and_pad(id->mn, sizeof(id->mn), model, sizeof(model) - 1, ' ');
+	memcpy_and_pad(id->mn, sizeof(id->mn), ctrl->subsys->model_number,
+		       strlen(ctrl->subsys->model_number), ' ');
 	memcpy_and_pad(id->fr, sizeof(id->fr),
 		       UTS_RELEASE, strlen(UTS_RELEASE), ' ');
 
-- 
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
