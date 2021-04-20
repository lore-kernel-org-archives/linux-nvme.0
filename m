Return-Path: <SRS0=/SuC=JR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF2AC433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 09:09:52 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 211EF611F2
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 09:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 211EF611F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7Q2T7zzFyjGdB+uDBFuxM/PzN9xEJXKJ+z//Z/i3G9I=; b=jSe0zjMUedSrERbFc36H3GlhyG
	Vl64N8raxRLUrV28ZA47Tq4y8eyg749xMw7YyPEs5y38+2kO4Mq1JFbqEozkGIvJp8RcYskeHO4DH
	zrwIx//EP9csMoqLrx+e95Ix3k4z042EzWiXa9EwpcemWkWKBnHT6dM+Zvjxn6LyBn3k6P4LNTCtN
	LFCglb9DxJebNs3s63YWNhlQdkh36YCJ950DWDC1zJu06jJ5KaOxDcFNDTtwlkdECPNESFimdkSEI
	K2HJh9e/DcntamfOLEXIRRgO3Zb4YNXPBaRl88RvZ7KfGQ2KPn7VHbtLGBTvJ0CXikUV0m2MsVnkf
	MU7Mpnpg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYmNi-00Bfrw-Ec; Tue, 20 Apr 2021 09:09:18 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYmNg-00Bfrn-3N
 for linux-nvme@desiato.infradead.org; Tue, 20 Apr 2021 09:09:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:
 Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
 Sender:Reply-To:Content-ID:Content-Description:In-Reply-To:References;
 bh=eAk4wEGLiI1ihlPxv85o5ciOKGtFQup1iqRKItAW93Y=; b=fD4RcFhulG4Ap81zR2+HExMrF1
 uMTU6WhFRIRA2EIkSnm1XGtXo67y8i+jKKlPBpFq1YezDKmjeKIswG3l8EaNkf2ajmfYcq+gy+TDF
 TN4mSAFihVNVuBcrGh14LL9a0oosiVvBGqx/BqzM/UYNbdL7R2fzDKSVSFnFkV/TtS5Ig9dOw/dSU
 ydcnjkZTfnOF2GpkCVLlBqH6QXFlPBznK9MWhzfgEg23QWtThvjp+oEycPe/UrSvIxhNpoNfQ3IBC
 0McjMIZ/2LlxG9+0xyUykpx9xwU9++B1VCUHtgSsN2JtRFvC5FdUaOmNu5+hsorGnGu22cG4cpQcR
 Lpl43w2w==;
Received: from mail-dm3nam07on2042.outbound.protection.outlook.com
 ([40.107.95.42] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYmNa-00BxNG-SV
 for linux-nvme@lists.infradead.org; Tue, 20 Apr 2021 09:09:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUpe140xx5vGNeWjd/5/t/5ZQQLxa6NQW/qcbZIt+XI29SeYJ9gj1dgWMLZAxGhq4C6lNY/WKfTVBWoi4cuGJnktMLPZ0C/tR5OGyjEf9KKWNgcgVWpGrW3swC9EtkjRzT4euAUN6T4gLJEHeaXNm9iSi2wDy3N2RhTcVVugkf+wE6KdEkRk5e2qNJNzXj0afcdWHQ5p9/5hCd7iD4APcDhg5v96XwNo0egeAB/WZA8JU1TrU0cZnwXa0tGmEbZ9o98HyEzUB2yxDTRqmo2otxxbPJuwx96G/RktaadIo5SeTnzIm7PzxfF63+BUMC7kgpDAg4t6/8qZqs+CV8i9Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAk4wEGLiI1ihlPxv85o5ciOKGtFQup1iqRKItAW93Y=;
 b=du0EptzOaftPHQXiJZsBcCICB3ZjgGxaM5S6XpZPT9iduoMG2Ml4bUuShpn4eHGA3wPbGU56mdwcn+FYHJTkC4pNNY3u8WvteYm/1Wu54xNfdVV/d4obfeS/Bf2871JWaq724HnC+cELWos8B6T4wE3Iy+mfhrx9yBaARr+6sbnuhxJjL2NLK3MkQ4LLAfl/NrNzTFsOiyIf7yqr87NVVHdvh+RaA2s/65UkjklH2Ur307ffMwBFeeWIjYeMSWtVkcZA6hS0O7N9LTizW1sFqoAOirbT/CW0hxH5s0W9jgrYRY/kuJ03ka932/1rC9c/+IooYCZnGgtteeGurqonOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAk4wEGLiI1ihlPxv85o5ciOKGtFQup1iqRKItAW93Y=;
 b=hOGiaFKJX04UHUeZwWjTJgAJC5NdFTivqQnyJyC97avXcDT+TWvy5cTc+Uddq6alfjlp45EXlVvtuZUL1KzcAwMWP86kIL9Cx99j0eSrmMDVCW5O6ZjDo62gf/pVAMrbP9MRe7VA7H5M0DXtDREgs1A3KmZ6Kkt5qRQYfhaRj5pp5zkbileBuPICQD90t+ue7qU89hPISsC9pKZAZN1n7qBbCbTX1E/TlpqoqN0b2zsEfFHqxXn+O/41I4VYO8q4uK10DU/ZS5agSd4OQeWB22YpECjXMp1RKfQ9gXDsIdWTYvW3L0UtX2YYG1qAyjcoH/J+e/6qzW/qNx0LMnJMEw==
Received: from DM3PR08CA0006.namprd08.prod.outlook.com (2603:10b6:0:52::16) by
 SN1PR12MB2479.namprd12.prod.outlook.com (2603:10b6:802:29::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16; Tue, 20 Apr 2021 09:09:07 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:52:cafe::5d) by DM3PR08CA0006.outlook.office365.com
 (2603:10b6:0:52::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Tue, 20 Apr 2021 09:09:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4042.16 via Frontend Transport; Tue, 20 Apr 2021 09:09:06 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Apr
 2021 09:09:06 +0000
Received: from r-nvmx02.mtr.labs.mlnx (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Apr 2021 09:09:04 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <kbusch@kernel.org>, 
 <hch@lst.de>, <chaitanya.kulkarni@wdc.com>
CC: <oren@nvidia.com>, <ngottlieb@nvidia.com>, <mgurtovoy@nvidia.com>
Subject: [PATCH 1/4] nvmet: change sn size and check validity
Date: Tue, 20 Apr 2021 09:09:00 +0000
Message-ID: <20210420090903.595664-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58b3acf2-208c-4762-cd63-08d903dbf3b5
X-MS-TrafficTypeDiagnostic: SN1PR12MB2479:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2479247E5524761E8B821D69DE489@SN1PR12MB2479.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ixJiP1wtsbTShEx/Ichbl1XhUUdTO1CRpqWaEhvcFqjpVr0J1FMgiP/GFY/iiq6bE/gYNiEGCMLUv3UR5RMRa5icUhMjaniyvIcwESz//iuHTuWpXs7WQabwewT+2BrtT6+FqG0HpKs1HFbWnRCictw+0L0WIigr+42fNJt2FdWdj/QYUJRCdbnF2hHFcrjxYLo2qr/IkCEGWIzWdwLZYIlmalPBKFySNiNmRqhyL24gd8PLcjbsZ8VRF3QC4klPEJlTI5SKeHEOMSGRYH6CWNXi84DOu+kTdNDGL2MQro0QWXV47tuMTG0T/DoTkN69LSVSGjoHTMNa/vezB/o2BfTshx5YQb4h+m3hlu/ofYn6PI4pyAYPX+C414JsH+jf4HLxetRARPManijNxFrN7MKI8VTHLRIeTC4MJw9ARXX6ySnE8nrlc0pmOGz3Bj05vwIoZ4xSoM2Ag1dsivtFLCUSas4j/xRfHnDPfa6OI1hPSiPEyYnztKOm82fGpDTuzd324IH8X3W/S+z/hW2lovjgSvOoGwlDvTwsXoPUxtF9DhgihWQrAFNODhGTS+hqY+cIwVe9pNQ/YNkiznuEKuDoHs/sv2sPrTCpcLwoD77HgzF6l4vOlpywd+ZCy3aq4f6ZSj8XzlsqbApLf6UpIBth3xX+2kWxQjWTBkJKaRo=
X-Forefront-Antispam-Report: CIP:216.228.112.36; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid05.nvidia.com; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(376002)(346002)(46966006)(36840700001)(336012)(478600001)(8936002)(426003)(2616005)(2906002)(36860700001)(26005)(4326008)(86362001)(6666004)(186003)(70206006)(70586007)(316002)(5660300002)(107886003)(82310400003)(47076005)(83380400001)(7636003)(356005)(54906003)(82740400003)(110136005)(8676002)(1076003)(36756003)(36906005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 09:09:06.9995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b3acf2-208c-4762-cd63-08d903dbf3b5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.36];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2479
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210420_020911_138829_9E1B605C 
X-CRM114-Status: GOOD (  14.31  )
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

Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Noam Gottlieb <ngottlieb@nvidia.com>
---
 drivers/nvme/target/admin-cmd.c |  4 +---
 drivers/nvme/target/configfs.c  | 36 ++++++++++++++++++++++++---------
 drivers/nvme/target/core.c      |  4 +++-
 drivers/nvme/target/discovery.c |  4 +---
 drivers/nvme/target/nvmet.h     |  3 ++-
 5 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index d2a26ff3f7b3..91eb7562a88a 100644
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
index 65a0cf99f557..576540fdba73 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1030,24 +1030,46 @@ static ssize_t nvmet_subsys_attr_version_store(struct config_item *item,
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
+	struct nvmet_subsys *subsys;
+	int pos, len;
+
+	subsys = to_subsys(item);
+	len = strcspn(page, "\n");
 
-	if (sscanf(page, "%llx\n", &serial) != 1)
+	if (len == 0 || len > NVMET_SN_MAX_SIZE) {
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
@@ -1128,12 +1150,6 @@ static ssize_t nvmet_subsys_attr_model_show(struct config_item *item,
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
index adbede9ab7f3..3efd48b0a34e 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1482,6 +1482,7 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 		enum nvme_subsys_type type)
 {
 	struct nvmet_subsys *subsys;
+	char serial[NVMET_SN_MAX_SIZE / 2];
 
 	subsys = kzalloc(sizeof(*subsys), GFP_KERNEL);
 	if (!subsys)
@@ -1489,7 +1490,8 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 
 	subsys->ver = NVMET_DEFAULT_VS;
 	/* generate a random serial number as our controllers are ephemeral: */
-	get_random_bytes(&subsys->serial, sizeof(subsys->serial));
+	get_random_bytes(&serial, sizeof(serial));
+	bin2hex(subsys->serial, &serial, sizeof(serial));
 
 	switch (type) {
 	case NVME_NQN_NVME:
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index 4845d12e374a..f39946615fd6 100644
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
index 5566ed403576..53999bd259ed 100644
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
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
