Return-Path: <SRS0=/SuC=JR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CEAC433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 09:09:52 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 210936101E
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 09:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 210936101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3IJugzEtbFYRBSPfOFYHWcYuJLfAOZ7IAgwH3xSWNvc=; b=PF3lbLAxXVbtnA1iTgs6F8zHk
	R4B4jvSoLpQlZsQgcmLiFtyHvtvXWSIoR0eSMmcWzj8Q0nEYnaTx1MlQCl/K9/o/Ri6flUbHFiSKj
	0vq7xs8Fubdk4xVQt7/O4Xev1qN+NauuzTLn9Owxj7l+Q+ovxwSf/S3sW+pXR6xD9e6oMkjNg71Qz
	U9xSz3lIbLyMai1nbJxpRzDAtLv5Ob/Lp4WoeE2bXekjqkVZ7tfF6xPiz89oO8rCllZfW30cFCTAw
	7SxwdKLevPV4BpRfCrgCcWnavio9VCZKYap8EUjMcTYj4/hp7U8PTdmESl03k0c753u3ln1puy+l8
	h4FoS0m4A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYmNt-00Bfsu-9r; Tue, 20 Apr 2021 09:09:29 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYmNj-00Bfs1-MX
 for linux-nvme@desiato.infradead.org; Tue, 20 Apr 2021 09:09:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
 :Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=5JKqgOl02YgFiKa6Lj85sZcvI4OxA3qtAHlAIvlpkN4=; b=MmlH48GV+riNraqUUS15DZuanq
 E03Wc8cFd82AoNCR1OlQRCb3XeNtSWK7ioW1eQX71FBWJvmdKP9NBk81lWwnpElzS16O/AThX2b1i
 K+k0Xluozio8f/+1MBADYdOqnNKlT2ss50df9MVGmPKJ7DXOi6+igddT+Ib5YR8oTlBIHdWhiFxMH
 OZX+U/j4FN2AeOh4bmiVF2sFyVEPCX3Wp5jvBrzIVzbqnvaRjqlyhQ8V2PDToPLCT4HAbfRtYoXv2
 qd8woez6xJ89kdh75HzoIaftChrkhzzUZt6ypFZ7a5R2TJykQHo+9uJaiD5XkedccRZiG+lAqiouI
 bTCxgBmA==;
Received: from mail-bn8nam11on2048.outbound.protection.outlook.com
 ([40.107.236.48] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYmNe-00BxNU-OF
 for linux-nvme@lists.infradead.org; Tue, 20 Apr 2021 09:09:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BY8G+r8dS1/o7yhuiinnMFLU5ABpR8VaHHNn1JjyETs6K5y+mmTsXQT8uciMKc+licJAzHSThglloRi//4dd8v8unJHLUnWeM/VI9BT14nlJmdJpBxK/jRRjgTLVGRXv5YMzqCOIv7WFH6xWNTmeNcFaKjvYtVcLUezPdmcZCd/JeReKfb8refxh4Kn3Q+V01gsHuJDLiLbF5jNfterX0ovUXWzcOxvr+62uv4YQ0ftScnT5fxUiXVih0A352naQ+Vfq6MMzU3RZjaM2WyZNbdldhZt5QW8xF2VEc7Vn1k90VjIaJCtdb2OBlpw7xCTJiCVBz8G+pNjKRrJuvrGAHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JKqgOl02YgFiKa6Lj85sZcvI4OxA3qtAHlAIvlpkN4=;
 b=lhYpkP6n6lmSXWlK6cyOBAui4MHxR3mpmZD3qP5laLgqzlFbOrDTAJq9PjA6YvH+cmPPxWJyCERgDeSrczQqw3TCxPxnT/LYiVRpcCbcItpabq2cWtxuwpto3azyhA7nHV3rtdix5aeq8XUVJMkQlVfH6ykRVyNQHBED0+VQsIuvjyDmY+w7eCxETGLI7N3TLh6MPDGQFuOBKGmVxuwMgDhmLGqqOepR+znAZ80aI6DgEPL95NCUDaKJmKQ6GDOsiPp0p3zF3i5+S2YTiMWUH7hcD4v2qTzmhfTlKlcUDOaNSXIsNcJW1/hm3E86GIxbOGVS08AyGGdo2XsaEz1Dkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JKqgOl02YgFiKa6Lj85sZcvI4OxA3qtAHlAIvlpkN4=;
 b=QL8mXanz+IvXa9iL45wqlmpRXOcaLyG0ijATKiAX+3c0Y3GKvL8NmjHsT23nLHUqvinjWcFze0v2hUJx4tBtpMKrczD1TInaJ6DXhNP9SfcW+IzOBKS9KIY/+l8hLMcZC6M8fAP3Kz2GBtYDLZjZjTuzHRvuLeBJbpqWH2NiaRwQ5vIgq840Plch3uKFM3fjJYoe4Mc16RowtEMkiT7tuKEhJ1aFlqZVaqPZpasA9yKOL1Piws02F/maVcg1Fz5HCndB8rggt52EFQ8GcYmXpXa5wngOwXo65a6/I7qz5eyZlRR/Qd7y5vhX3tJ0IS1XNWtSDsCs0WUlyMso0Am0aA==
Received: from DM6PR03CA0072.namprd03.prod.outlook.com (2603:10b6:5:100::49)
 by DM6PR12MB3866.namprd12.prod.outlook.com (2603:10b6:5:1c6::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Tue, 20 Apr
 2021 09:09:10 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::d4) by DM6PR03CA0072.outlook.office365.com
 (2603:10b6:5:100::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Tue, 20 Apr 2021 09:09:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4042.16 via Frontend Transport; Tue, 20 Apr 2021 09:09:09 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Apr
 2021 09:09:08 +0000
Received: from r-nvmx02.mtr.labs.mlnx (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Apr 2021 09:09:06 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <kbusch@kernel.org>, 
 <hch@lst.de>, <chaitanya.kulkarni@wdc.com>
CC: <oren@nvidia.com>, <ngottlieb@nvidia.com>, <mgurtovoy@nvidia.com>
Subject: [PATCH 2/4] nvmet: make sn stable once connection was established
Date: Tue, 20 Apr 2021 09:09:01 +0000
Message-ID: <20210420090903.595664-2-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210420090903.595664-1-mgurtovoy@nvidia.com>
References: <20210420090903.595664-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 672aac64-ea8f-480f-6eac-08d903dbf519
X-MS-TrafficTypeDiagnostic: DM6PR12MB3866:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3866C473901B86129F863085DE489@DM6PR12MB3866.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G3N/q3YCcUlq2mukoMgx3LG80hS/I6MMeG6Uam67UN2GN75V1pB67YnQdP93O1SO9WLbL1nECEIaSu5K838ecG54BuX1HKlLlPncbOeNKabtGobuMkO+7gMpBjE6sLx588MU8VsPUhN31AoJMOV+aqu9yVYMEonsLCiveNE8bPEmZ4ifBhf9NtVNy8nL1b4Jni9yOF/fu9v9GsNK33GifbOzuLjYt8TdAeozJ7TvuanJFoiafNmkMBgGMBKDOn9UuF+q/ASL5mzODw/z8Rpt/xWhrm4Rp334IPMjq77bffftCQ2T/sYvoG0PdQMANBhNBsIsvhPl0qhVm+XNrcaA33mL6BEaJDRIXvwXgXaTgKjUaGBAzG2WrbT+IX0X7t0jvmS3yeRh855YxvmtqhZLVTHMpOB4zhKZ6tOwPxWdYZHZQhZ7sd89zzwks1UhJuebovbmm1ptdMcvWHAHSz0DMkqs45NwjQY3xj4f3h6kUb7WUjysmZ9ZKKKO51tkFhRB1ejqYHhwMI7d2kaZvkG/sii/ZO5sLuH187zQbl7NjlmCdH/TQxBCh7cjuJgcGmfnEDtAVaeq607tsK26CpKzpStbiu2oZmn1juC1CUjEhCjzWdlEr1AlqNirR0Uv/AMNWFgpQwpua00DnCd0l4XXcyn7tP8Be4aekkqKs32xVL4=
X-Forefront-Antispam-Report: CIP:216.228.112.36; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid05.nvidia.com; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(46966006)(36840700001)(70586007)(110136005)(36906005)(4326008)(70206006)(7636003)(426003)(83380400001)(36756003)(5660300002)(6666004)(54906003)(86362001)(478600001)(47076005)(2616005)(8676002)(82740400003)(1076003)(336012)(82310400003)(26005)(186003)(36860700001)(316002)(2906002)(356005)(107886003)(8936002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 09:09:09.3262 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 672aac64-ea8f-480f-6eac-08d903dbf519
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.36];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3866
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210420_020914_816702_CC62F5CE 
X-CRM114-Status: GOOD (  13.54  )
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

Once some host has connected to the target, make sure that the serial
number is stable and cannot be changed.

Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Noam Gottlieb <ngottlieb@nvidia.com>
---
 drivers/nvme/target/admin-cmd.c |  6 ++++++
 drivers/nvme/target/configfs.c  | 28 ++++++++++++++++++++++------
 drivers/nvme/target/nvmet.h     |  1 +
 3 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 91eb7562a88a..712e09f8158b 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -337,6 +337,12 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	u32 cmd_capsule_size;
 	u16 status = 0;
 
+	if (!subsys->subsys_discovered) {
+		mutex_lock(&subsys->lock);
+		subsys->subsys_discovered = true;
+		mutex_unlock(&subsys->lock);
+	}
+
 	/*
 	 * If there is no model number yet, set it now.  It will then remain
 	 * stable for the life time of the subsystem.
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 576540fdba73..7040d92bb31a 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1044,13 +1044,18 @@ static ssize_t nvmet_subsys_attr_serial_show(struct config_item *item,
 	return snprintf(page, PAGE_SIZE, "%s\n", subsys->serial);
 }
 
-static ssize_t nvmet_subsys_attr_serial_store(struct config_item *item,
-					      const char *page, size_t count)
+static ssize_t
+nvmet_subsys_attr_serial_store_locked(struct nvmet_subsys *subsys,
+		const char *page, size_t count)
 {
-	struct nvmet_subsys *subsys;
 	int pos, len;
 
-	subsys = to_subsys(item);
+	if (subsys->subsys_discovered) {
+		pr_err("Can't set serial number. %s is already assigned\n",
+		       subsys->serial);
+		return -EINVAL;
+	}
+
 	len = strcspn(page, "\n");
 
 	if (len == 0 || len > NVMET_SN_MAX_SIZE) {
@@ -1066,13 +1071,24 @@ static ssize_t nvmet_subsys_attr_serial_store(struct config_item *item,
 		}
 	}
 
+	memcpy_and_pad(subsys->serial, NVMET_SN_MAX_SIZE, page, len, ' ');
+
+	return count;
+}
+
+static ssize_t nvmet_subsys_attr_serial_store(struct config_item *item,
+					      const char *page, size_t count)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+	ssize_t ret;
+
 	down_write(&nvmet_config_sem);
 	mutex_lock(&subsys->lock);
-	memcpy_and_pad(subsys->serial, NVMET_SN_MAX_SIZE, page, len, ' ');
+	ret = nvmet_subsys_attr_serial_store_locked(subsys, page, count);
 	mutex_unlock(&subsys->lock);
 	up_write(&nvmet_config_sem);
 
-	return count;
+	return ret;
 }
 CONFIGFS_ATTR(nvmet_subsys_, attr_serial);
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 53999bd259ed..7a47ca00fb03 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -231,6 +231,7 @@ struct nvmet_subsys {
 
 	u64			ver;
 	char			serial[NVMET_SN_MAX_SIZE];
+	bool			subsys_discovered;
 	char			*subsysnqn;
 	bool			pi_support;
 
-- 
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
