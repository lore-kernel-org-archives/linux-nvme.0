Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC17C7EE22
	for <linux-nvme@archiver.kernel.org>; Thu, 11 May 2023 16:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NVL5U3qoQ5AM3O6rfdgSj4W/rIXynQonScOvH4jffFc=; b=RwCs23ygOEn2guwIbOZGG56T6y
	/FXPtqm/aca8Ljd3al+SDPZWIHmFRINbIbqqfrBbDxwLIsEvxA/GQBtzEVKH4/enwiQTZHObetxZQ
	VrINmSZDgctLgUOGT78B4fYAskYPbyRnv1uUra29y/BvbjFPs2zo6VmtvARBZbyFTcSidalyAIp4M
	FBnh5DPp3h6d76YZ0PZVAQylXiICCRyhOqQXhN5jG8TY7KImKI08RTB2vdcrj8KJKfeeRBnd/nOzs
	Oe27b3YoUSM7gGvOnvZNYJ7SAFHLbssjnr571Ai/tev9scphO1YQdCHDqoG3z/o5yC7q3zLBwZocQ
	m2jAp+3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1px9ZW-009Quv-0l;
	Thu, 11 May 2023 16:55:18 +0000
Received: from mail-dm6nam12on2061f.outbound.protection.outlook.com ([2a01:111:f400:fe59::61f] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1px9ZT-009QtC-0e
	for linux-nvme@lists.infradead.org;
	Thu, 11 May 2023 16:55:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P07NUfcawOhts+0TjprUq3bSvpBTVGzXWd/wrSND07SpMwlCIotUibXIVw0gA0cmFn7YuCwqXtL0+DjKKx0/JHtyJLR7u+0gU8QVppmzFW9a+q36tK+i+0Of28YtVi91JtBU/mCIQFwDXwxxdrr96ZDv12ZankOe2QUd0GupBTcfdBtLG8tYeQEF/3wuxufaUO0qRfZADrz5mVtCVTvE/PBtAdqDMNRnKEyNxOogNz0m/07M0gp0z0oRYXatn1oi2pmfKjNZl8H6nKc/mD42aiHPFY8ATnvGz9vKVI6CJlCbfxQUKgMxps+HM4ru2M3rvRy9hMqeNcctGW6DU/mYcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVL5U3qoQ5AM3O6rfdgSj4W/rIXynQonScOvH4jffFc=;
 b=Cw4xL9TyScICz0N9gFfh66QSHcyBpTHIAi0Vn1EPFr85YRg/nZYXdZ63OONKpMDJWt9b9mcOmas0pDHgxLhCHvnZY9C6OhRP+mOJ47yOI5xzDSPjSIcFt6VdV5fRToUkAZE6hPLO3yQ41KfbP8jLvGNHRrGMXQskSQydiGlco9/hL39WhVfn1KTvx+w5eDIegXwaki86OPHz7Nsk7r+DIMLSwGHFl+ZDfWwMizH0P3bSNvKXcmU5Z3WSruIaKduGZJkU4fDZx1Yjt17yV5s3oynWUGeaLcmpG9OE1T4o0BAvnmGUHrHHunNLpG8F0uP49EnlmGvcK2PClAGSQhqxOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVL5U3qoQ5AM3O6rfdgSj4W/rIXynQonScOvH4jffFc=;
 b=FzWW/m3efMA4DijpBSFfNHWW4DHcRedDuoAfol6BYwS6qbs5StVE0ra5AKXo370BfmxyKExsNh5jJ3ycX/W42IrRH+EBCqAwGlq3bCTzcDvuDIltStVtNmmI0Jctz27iCZqgQ90/8bqZcXQ2e1m60hGRuX5sQ/xeHVxxLMOmRZgcNWPMzR+J4DIhbvVqF42y2+mcoGPFAt1d9mi3I9vuwd7f4/v5BZnyVLdad+hP/mA0BNLPmzaX0NYW3VN/vuIr4YauDTfuTAtYxtaH8lE1HiZZr15gvD9S9fWxFRnM1h9HxuxLcCXN/TMaONFciUoYi6+0KBoZ4Qmt3FuezBlJOw==
Received: from BN8PR04CA0012.namprd04.prod.outlook.com (2603:10b6:408:70::25)
 by CH3PR12MB8933.namprd12.prod.outlook.com (2603:10b6:610:17a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Thu, 11 May
 2023 16:55:06 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::70) by BN8PR04CA0012.outlook.office365.com
 (2603:10b6:408:70::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.22 via Frontend
 Transport; Thu, 11 May 2023 16:55:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.23 via Frontend Transport; Thu, 11 May 2023 16:55:06 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 11 May 2023
 09:54:54 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 11 May
 2023 09:54:54 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 11 May 2023 09:54:51 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <hch@lst.de>, <sagi@grimberg.me>, <kbusch@kernel.org>,
	<linux-nvme@lists.infradead.org>
CC: <hare@suse.de>, <axboe@kernel.dk>, <oren@nvidia.com>,
	<ngottlieb@nvidia.com>, <israelr@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH v2 3/3] nvme-fabrics: prevent overriding of existing host
Date: Thu, 11 May 2023 19:54:41 +0300
Message-ID: <20230511165441.30005-4-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20230511165441.30005-1-mgurtovoy@nvidia.com>
References: <20230511165441.30005-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT004:EE_|CH3PR12MB8933:EE_
X-MS-Office365-Filtering-Correlation-Id: f91420a5-3e60-4856-a225-08db524078e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	gLvEm7RCsCE1Z73xROsfyGsVdgX+eqPBqY70pkVQ0KxvZbeYOv+mqdBJnCrzzPTv6aaJIDd7+AFWnRpmsUv4WJHwLVPSB/DGfAfqfPp32OAgsTRXU2zPNm5G/EDgiRjCvxh898LihIbA+3G+O9R3Ws34ZxwErEIDXVrgW4fMknlq5TBrHawrtMTfDR9Mz9xf6VY8v17PimalCePGuho4Csh3oSV/Ryl9tpdn+RC97ZSCIfCJTdoNvMMertWIrD4unqSzkEsHXF49G95NNVu6mYgg6DKvTyOCjfDac049Pbo+9T8vth/ZVCfnVq2o4FeTJAPtKczmeKR4cmDrgm8b4FtWXOlxt2ra4iQLqVDP4H5R0ljAE4F7lw/l0COr42v9OHZQO72jgi8KP8aiV9fXeCFbNyrrPiDwW2Zgq8AJPGWmyw6oAa5NvpjpRz2mOJ5nnTrW5jH2Lv59XxvM83HVgiYg+tP5Y2jMbPsETfuLxph9If1M1FhSNwzDJDDZJId3AVDFREMxK5LBbrHUflmnfQymJQU20xv+gy0XS7YfHTGC2gENuu5mSYc/Qd115eDak/EwdMzOozf1Diil9uYvjexEp9SFhwSEnAAGDYAgo4fT+wqy0qjl1LcT7N29TKSl8xMGyzfPGoerSTZhUbMxks/S1H7wo41eZNy5Y410zcEtILE6YyvvYUFltcH0x4Hu6VYx+yO2zKGi/md1dm6Nmw==
X-Forefront-Antispam-Report: 	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199021)(46966006)(36840700001)(40470700004)(36860700001)(83380400001)(478600001)(26005)(70586007)(70206006)(47076005)(6666004)(2616005)(316002)(426003)(110136005)(186003)(1076003)(107886003)(4326008)(54906003)(2906002)(86362001)(40460700003)(8676002)(82310400005)(36756003)(336012)(41300700001)(356005)(7636003)(40480700001)(82740400003)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 16:55:06.0816
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f91420a5-3e60-4856-a225-08db524078e4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8933
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230511_095515_246956_F9C3B7A9 
X-CRM114-Status: GOOD (  21.39  )
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

When first connecting a target using the "default" host parameters,
setting the hostid from the command line during a subsequent connection
establishment would override the "default" hostid parameter. This would
cause an existing connection that is already using the host definitions
to lose its hostid.

To address this issue, the code has been modified to allow only 1:1
mapping between hostnqn and hostid. This will maintain unambiguous host
identification. Any non 1:1 mapping will be rejected during connection
establishment.

Tested-by: Noam Gottlieb <ngottlieb@nvidia.com>
Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---

changes from v1:
- address comments from Christoph
- allow only 1:1 mapping between hostnqn and hostid
- add error prints in case we fail a connection for user to understand
  the reason of the failure

---
 drivers/nvme/host/fabrics.c | 98 ++++++++++++++++++++++++++-----------
 1 file changed, 70 insertions(+), 28 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 0c0172bdc4dc..f8e47c7d6188 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -21,35 +21,77 @@ static DEFINE_MUTEX(nvmf_hosts_mutex);
 
 static struct nvmf_host *nvmf_default_host;
 
-static struct nvmf_host *__nvmf_host_find(const char *hostnqn)
+/**
+ * __nvmf_host_find() - Find a matching to a previously created host
+ * @hostnqn: Host NQN to match
+ * @id: Host ID to match
+ *
+ * We have defined a host as how it is perceived by the target.
+ * Therefore, we don't allow different Host NQNs with the same Host ID.
+ * Similarly, we do not allow the usage of the same Host NQN with different
+ * Host IDs. This will maintain unambiguous host identification.
+ *
+ * Return: Returns host pointer on success, NULL in case of no match or
+ *         ERR_PTR(-EINVAL) in case of error match.
+ */
+static struct nvmf_host *__nvmf_host_find(const char *hostnqn, uuid_t *id)
 {
 	struct nvmf_host *host;
 
+	lockdep_assert_held(&nvmf_hosts_mutex);
+
 	list_for_each_entry(host, &nvmf_hosts, list) {
-		if (!strcmp(host->nqn, hostnqn))
-			return host;
+		if (!strcmp(host->nqn, hostnqn)) {
+			if (uuid_equal(&host->id, id)) {
+				// same hostnqn and hostid
+				return host;
+			} else {
+				pr_err("found same hostnqn %s but different hostid %pUb\n",
+				       hostnqn, id);
+				return ERR_PTR(-EINVAL);
+			}
+		} else if (uuid_equal(&host->id, id)) {
+			// same hostid but different hostnqn
+			pr_err("found same hostid %pUb but different hostnqn %s\n",
+			        id, hostnqn);
+			return ERR_PTR(-EINVAL);
+		}
 	}
 
 	return NULL;
 }
 
-static struct nvmf_host *nvmf_host_add(const char *hostnqn)
+static struct nvmf_host *nvmf_host_alloc(const char *hostnqn, uuid_t *id)
+{
+	struct nvmf_host *host;
+
+	host = kmalloc(sizeof(*host), GFP_KERNEL);
+	if (!host)
+		return NULL;
+
+	kref_init(&host->ref);
+	uuid_copy(&host->id, id);
+	strscpy(host->nqn, hostnqn, NVMF_NQN_SIZE);
+
+	return host;
+}
+
+static struct nvmf_host *nvmf_host_add(const char *hostnqn, uuid_t *id)
 {
 	struct nvmf_host *host;
 
 	mutex_lock(&nvmf_hosts_mutex);
-	host = __nvmf_host_find(hostnqn);
-	if (host) {
+	host = __nvmf_host_find(hostnqn, id);
+	if (IS_ERR(host)) {
+		goto out_unlock;
+	} else if (host) {
 		kref_get(&host->ref);
 		goto out_unlock;
 	}
 
-	host = kmalloc(sizeof(*host), GFP_KERNEL);
+	host = nvmf_host_alloc(hostnqn, id);
 	if (!host)
-		goto out_unlock;
-
-	kref_init(&host->ref);
-	strscpy(host->nqn, hostnqn, NVMF_NQN_SIZE);
+		return ERR_PTR(-ENOMEM);
 
 	list_add_tail(&host->list, &nvmf_hosts);
 out_unlock:
@@ -60,16 +102,17 @@ static struct nvmf_host *nvmf_host_add(const char *hostnqn)
 static struct nvmf_host *nvmf_host_default(void)
 {
 	struct nvmf_host *host;
+	char nqn[NVMF_NQN_SIZE];
+	uuid_t id;
 
-	host = kmalloc(sizeof(*host), GFP_KERNEL);
+	uuid_gen(&id);
+	snprintf(nqn, NVMF_NQN_SIZE,
+		"nqn.2014-08.org.nvmexpress:uuid:%pUb", &id);
+
+	host = nvmf_host_alloc(nqn, &id);
 	if (!host)
 		return NULL;
 
-	kref_init(&host->ref);
-	uuid_gen(&host->id);
-	snprintf(host->nqn, NVMF_NQN_SIZE,
-		"nqn.2014-08.org.nvmexpress:uuid:%pUb", &host->id);
-
 	mutex_lock(&nvmf_hosts_mutex);
 	list_add_tail(&host->list, &nvmf_hosts);
 	mutex_unlock(&nvmf_hosts_mutex);
@@ -633,6 +676,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	size_t nqnlen  = 0;
 	int ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO;
 	uuid_t hostid;
+	char hostnqn[NVMF_NQN_SIZE];
 
 	/* Set defaults */
 	opts->queue_size = NVMF_DEF_QUEUE_SIZE;
@@ -649,7 +693,9 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	if (!options)
 		return -ENOMEM;
 
-	uuid_gen(&hostid);
+	/* use default host if not given by user space */
+	uuid_copy(&hostid, &nvmf_default_host->id);
+	strscpy(hostnqn, nvmf_default_host->nqn, NVMF_NQN_SIZE);
 
 	while ((p = strsep(&o, ",\n")) != NULL) {
 		if (!*p)
@@ -795,12 +841,8 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 				ret = -EINVAL;
 				goto out;
 			}
-			opts->host = nvmf_host_add(p);
+			strscpy(hostnqn, p, NVMF_NQN_SIZE);
 			kfree(p);
-			if (!opts->host) {
-				ret = -ENOMEM;
-				goto out;
-			}
 			break;
 		case NVMF_OPT_RECONNECT_DELAY:
 			if (match_int(args, &token)) {
@@ -957,13 +999,13 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 				opts->fast_io_fail_tmo, ctrl_loss_tmo);
 	}
 
-	if (!opts->host) {
-		kref_get(&nvmf_default_host->ref);
-		opts->host = nvmf_default_host;
+	opts->host = nvmf_host_add(hostnqn, &hostid);
+	if (IS_ERR(opts->host)) {
+		ret = PTR_ERR(opts->host);
+		opts->host = NULL;
+		goto out;
 	}
 
-	uuid_copy(&opts->host->id, &hostid);
-
 out:
 	kfree(options);
 	return ret;
-- 
2.18.1


