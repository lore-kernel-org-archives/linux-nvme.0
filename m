Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A676C77B61
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Apr 2023 08:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UeZc3LD7w5njb/GXcNtbXJDRwtfRJui20wVWzx6MyMc=; b=D4RhFUwpb4uzaD1GndIpJtVxg+
	xUHGd/bPVJptpnu9X4fTvG10xdZdwgFFUB9ez7CWZYvB9X8csPV7luwMZhzw/2XuFr2Bwzogmvl3M
	QiA3KGFhuGoUdpaSerBnrsPl+PK2mOceBJJCfVD6Sf+i9uWyLLJ9aycay7wacqQ2s0RgGfER4l2Vv
	8k7uM6BVedT3Iy/IvAHRBnHtnClBCHoVogGEYk54EelC/vemkjLSVRzVgEOHqlYrrTnGPohueMI8C
	eu8oRxyjE4F4zGJBq25esBZZ0d90eASKCzqb8wCsh/i9Ik1xROqFiU9nI1Axn28yhfgYUVg3hGoQv
	46Opc4VQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1prwaY-005kyE-2B;
	Thu, 27 Apr 2023 08:02:50 +0000
Received: from mail-dm6nam10on20610.outbound.protection.outlook.com ([2a01:111:f400:7e88::610] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1prwaT-005kw2-0h
	for linux-nvme@lists.infradead.org;
	Thu, 27 Apr 2023 08:02:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QlD7AcbCumtnq+VlUErTbwzDrA/nzTzUu2iJDQndFMKdY6bNxReq3/QcFfbwn37eawTq+v9Uv9rcnOKowSFzmlS3D+iTox1rRSd09gxHJo3FAFCEpWLNvdIwv54fGNNCToEwRBiyois2hBJNsJIQgJhmBZ97kXGFVvNdGE9zbS/8pIdCYBaP1XhPvtTb2+ppS6wSCRTwv0uo9gkyJKxvdytyiPKDwjLScV+oVIyuvP228brnNWzkaFhn+SEvbbK+4eFDaHeuDkwfylOJ9BEifHC01WsZwj+vdNJIt4cuIh7AJlxz4o1x43QzaqYI88Usjii4Yz9AoZwtUv1kmhq6og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UeZc3LD7w5njb/GXcNtbXJDRwtfRJui20wVWzx6MyMc=;
 b=X93IJyIPQTQmmhc7Rsk73zIQFAbfufuVLhyuHKUTCx5OJFMrpm6Y8t/Dq0AvbZD0ZpouKfplcFZTWY7eAHIj8axBWxN0eeMGh4PP5AlN0VUXkTVnPZJ3Rw0qPU5zqV2OoQfAAPOItjxSs5DY1JfFnXKYfCaUU/hwvB1S6aWCvYrHjG9ACYr+UrS30eznu/KNo9qeGr/MDKJrzuiSg5VD5olqDZ9XxbtF7pPuK2FUyIeqRQ08d69t9mauW4OY5Gd5CBHezMJur9nYh5Kj4uJDUuWsMe7F8PQQ2jR9twVM4Hy5fczn1Qf9YuFal7tD5y+V2BGFa8Tcv4VHgrnl/3vI5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=suse.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UeZc3LD7w5njb/GXcNtbXJDRwtfRJui20wVWzx6MyMc=;
 b=axbuxK12/2ZN2KXeiTRSUwi3zrtt/vpmalrz9l3JtxEl9LiaSb6UbF4Pxyu4s3qC8atHbEXg/B3LKWzjF/5thiQ0grSMn2AnrGDYqUQDbyx6WS8hWGpf1pFus545L9mljNWdCa7iF8t59K7rLDyk86EO/cJbmGN/qf6iq0V0cW+XkqYqO0MPboznBZ5PyyPT0iY3AK4+ZtZEPgrqUZwJezWWuIMJqjxQhbDxf1hG2w3v0VFGOej/GmjT87fE+EoH7gzjFIrdrXQ2sRr2G9GSP8hsDQ0Fz2DhMLUgH50hu+uwdoGPtiHQRRKlsDGgw+VcS+6Tg+/qlAX57A6dQU+AiQ==
Received: from MW4PR04CA0095.namprd04.prod.outlook.com (2603:10b6:303:83::10)
 by DM6PR12MB4188.namprd12.prod.outlook.com (2603:10b6:5:215::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20; Thu, 27 Apr
 2023 08:02:40 +0000
Received: from CO1NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83::4) by MW4PR04CA0095.outlook.office365.com
 (2603:10b6:303:83::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22 via Frontend
 Transport; Thu, 27 Apr 2023 08:02:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT073.mail.protection.outlook.com (10.13.174.196) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.22 via Frontend Transport; Thu, 27 Apr 2023 08:02:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Apr 2023
 01:02:26 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 27 Apr
 2023 01:02:26 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <hare@suse.de>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [RFC PATCH 1/2] nvme-core: factor out common code into helper
Date: Thu, 27 Apr 2023 01:02:06 -0700
Message-ID: <20230427080207.17249-2-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230427080207.17249-1-kch@nvidia.com>
References: <20230427080207.17249-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT073:EE_|DM6PR12MB4188:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a879ab7-653c-43fd-f490-08db46f5c60e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	IMrI5fiiJ0cxiIUsoiFAKGt9Vf/7q/UDVjNf+9O/6+I+lcgArkBft/laPY83C6+gLF0iqlxMSebN+luAFNdCteaSfyymLcfjZAFnrFMy3P2p5jljddinLgjYm1hfLDnvK6i67dufA3LFhbhAJEOwHZztkqubFKFpYSIXvlnxqkef5ioLJInDALYE/mf3znRQrKKemKtqzWBlwBpW7miyC4AF04NVYIEoHU02htlqRdxCFNnz1Rrt7xFtFfwHgzd1w43SlnNrgryRLhUlL7kT214ZTZuIj9f5oYDxmzcNHNeJeiYuDQH+YuZlKhL3P39IiS2P562U4wXm5QKQidJYmZ4o7nwni2XbLDsawa2nQc+8NxbBQqwJYaqj/3VtI3T2uHW6ZWdsIrt+1BKmbrtIoBawUvyOQvnrA3vRk9b2OhKnRnNktoGdwcCDPKQ/+HPAUPC+scC9NWHQg/TAv9c7M91WrKfdBO2HiCWw/sVIpZe2k7a71h0admd3u3GICgfd/Sbw6viaNyBckdQ+r7JqiX2LmNEOr78Rmb6PlTDbD8W8Xf6w0yJsfz4sz8sxWGbuzZ4Ejze98A2z6V4xZ6n8f+FAw01MfH6s1ttJHPi0hewC0LvjbfUGMxgvWZefC59ZbujSrin9rmlzHGH/qCNHxk1RRaUPbosK1ROEXz1/LOhKSTQxvMNAy55n3rk0tcCgRlhTaGwh1DrThTUsykOzLQRqihDmkpLa9Igbqwh+hKk=
X-Forefront-Antispam-Report: 	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199021)(46966006)(36840700001)(40470700004)(2616005)(336012)(426003)(107886003)(83380400001)(36860700001)(47076005)(40460700003)(186003)(16526019)(40480700001)(70586007)(6916009)(4326008)(7636003)(8676002)(8936002)(2906002)(70206006)(82740400003)(5660300002)(316002)(41300700001)(26005)(1076003)(356005)(34020700004)(478600001)(82310400005)(7696005)(6666004)(54906003)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 08:02:40.5764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a879ab7-653c-43fd-f490-08db46f5c60e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	CO1NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4188
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230427_010245_253149_B770D074 
X-CRM114-Status: GOOD (  12.08  )
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

nvme_ctrl_dhchap_secrete_store() & nvme_ctrl_dhchap_ctrl_secret store()
share common code. Instead of repeating code into two functions factor
out into helper function.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c | 85 +++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 54 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 44408c0c1762..171ae1f2197a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3779,6 +3779,7 @@ static ssize_t dctype_show(struct device *dev,
 static DEVICE_ATTR_RO(dctype);
 
 #ifdef CONFIG_NVME_AUTH
+
 static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
@@ -3790,41 +3791,40 @@ static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
 	return sysfs_emit(buf, "%s\n", opts->dhchap_secret);
 }
 
-static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t nvme_dhchap_secret_store_common(struct nvme_ctrl *ctrl,
+		char **dhchap_secret, struct nvme_dhchap_key **orig_key,
+		const char *buf, size_t count)
 {
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-	struct nvmf_ctrl_options *opts = ctrl->opts;
-	char *dhchap_secret;
+	char *new_dhchap_secret;
 
-	if (!ctrl->opts->dhchap_secret)
+	if (*dhchap_secret)
 		return -EINVAL;
 	if (count < 7)
 		return -EINVAL;
 	if (memcmp(buf, "DHHC-1:", 7))
 		return -EINVAL;
 
-	dhchap_secret = kzalloc(count + 1, GFP_KERNEL);
-	if (!dhchap_secret)
+	new_dhchap_secret = kzalloc(count + 1, GFP_KERNEL);
+	if (!new_dhchap_secret)
 		return -ENOMEM;
-	memcpy(dhchap_secret, buf, count);
+	memcpy(new_dhchap_secret, buf, count);
 	nvme_auth_stop(ctrl);
-	if (strcmp(dhchap_secret, opts->dhchap_secret)) {
-		struct nvme_dhchap_key *key, *host_key;
+	if (strcmp(new_dhchap_secret, *dhchap_secret)) {
+		struct nvme_dhchap_key *new_key, *prev_host_key;
 		int ret;
 
-		ret = nvme_auth_generate_key(dhchap_secret, &key);
+		ret = nvme_auth_generate_key(new_dhchap_secret, &new_key);
 		if (ret) {
-			kfree(dhchap_secret);
+			kfree(new_dhchap_secret);
 			return ret;
 		}
-		kfree(opts->dhchap_secret);
-		opts->dhchap_secret = dhchap_secret;
-		host_key = ctrl->host_key;
+		kfree(*dhchap_secret);
+		*dhchap_secret = new_dhchap_secret;
+		prev_host_key = *orig_key;
 		mutex_lock(&ctrl->dhchap_auth_mutex);
-		ctrl->host_key = key;
+		*orig_key = new_key;
 		mutex_unlock(&ctrl->dhchap_auth_mutex);
-		nvme_auth_free_key(host_key);
+		nvme_auth_free_key(prev_host_key);
 	}
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
@@ -3832,6 +3832,16 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 
 	return count;
 }
+
+static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return nvme_dhchap_secret_store_common(ctrl, &ctrl->opts->dhchap_secret,
+			&ctrl->host_key, buf, count);
+}
+
 static DEVICE_ATTR(dhchap_secret, S_IRUGO | S_IWUSR,
 	nvme_ctrl_dhchap_secret_show, nvme_ctrl_dhchap_secret_store);
 
@@ -3850,43 +3860,10 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-	struct nvmf_ctrl_options *opts = ctrl->opts;
-	char *dhchap_secret;
 
-	if (!ctrl->opts->dhchap_ctrl_secret)
-		return -EINVAL;
-	if (count < 7)
-		return -EINVAL;
-	if (memcmp(buf, "DHHC-1:", 7))
-		return -EINVAL;
-
-	dhchap_secret = kzalloc(count + 1, GFP_KERNEL);
-	if (!dhchap_secret)
-		return -ENOMEM;
-	memcpy(dhchap_secret, buf, count);
-	nvme_auth_stop(ctrl);
-	if (strcmp(dhchap_secret, opts->dhchap_ctrl_secret)) {
-		struct nvme_dhchap_key *key, *ctrl_key;
-		int ret;
-
-		ret = nvme_auth_generate_key(dhchap_secret, &key);
-		if (ret) {
-			kfree(dhchap_secret);
-			return ret;
-		}
-		kfree(opts->dhchap_ctrl_secret);
-		opts->dhchap_ctrl_secret = dhchap_secret;
-		ctrl_key = ctrl->ctrl_key;
-		mutex_lock(&ctrl->dhchap_auth_mutex);
-		ctrl->ctrl_key = key;
-		mutex_unlock(&ctrl->dhchap_auth_mutex);
-		nvme_auth_free_key(ctrl_key);
-	}
-	/* Start re-authentication */
-	dev_info(ctrl->device, "re-authenticating controller\n");
-	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
-
-	return count;
+	return nvme_dhchap_secret_store_common(ctrl,
+			&ctrl->opts->dhchap_ctrl_secret, &ctrl->ctrl_key, buf,
+			count);
 }
 static DEVICE_ATTR(dhchap_ctrl_secret, S_IRUGO | S_IWUSR,
 	nvme_ctrl_dhchap_ctrl_secret_show, nvme_ctrl_dhchap_ctrl_secret_store);
-- 
2.40.0


