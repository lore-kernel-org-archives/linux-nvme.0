Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD919C77B7C
	for <linux-nvme@archiver.kernel.org>; Wed, 10 May 2023 18:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bDxY6ckEmMbWL3Z68I7wjTaxXsKvEU+5ajtSNupr30g=; b=LcFgHTI6P0idlsNKh3FuI85Yj/
	Z1Wh6Ydop+lVk1jQyvxhtkrClsfdmd5yStGMa6b8BGSg7VTtI7gGV2SsfYBqooXvJAhaV+6Z0ZjoM
	bbg1M7WLz5vmQqwpftYPzYsbPRNkuDTK7lZhYaWwgdgTMcpeJvhT7CmORLGHywQ6WH0aZZ78p33ay
	SHRGlh0MGFvCtZvIN0pARoQLJgdOtQyAmGu59Xl81gyBdJRjZnDlQHSOwKShxkJY8oQjIxcWKwVlg
	inMp2w1LgeIxOV+I2CPr4GzFmPNkVJfEg2rzlIPMWCmVCl3WkaocmCERvdbR8YmWL5wYzJd9hrL1o
	5u+rTn2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwo9a-006hrO-2B;
	Wed, 10 May 2023 18:03:06 +0000
Received: from mail-dm3nam02on20615.outbound.protection.outlook.com ([2a01:111:f400:7e83::615] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwo9X-006hqK-1b
	for linux-nvme@lists.infradead.org;
	Wed, 10 May 2023 18:03:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7sAeu/LHBHbHjbs9MC0yyINas7uv+/E/ZI9flwpZntnoIZN63PpNOk10X8ZixZdKDygaJBue+3bOJX58SMtZEox8vjrlcPRj3BQ+yJ1Mtd6uoVLllasrI+QIJgcAaqC9sdZ+tQHvcl8WWwv9f1ic6S1YR1+DLDT9FbQW2I6RNmfIZNcYP2+nPP65swtqLmWdzkeAi5nIZ2NDL8na/O0rAaZgAcMvoRgKeSrUr4CYg5gofhrC+KUPTuU5PzFL7l+i1FzRtgTus143RLA4aa2BKfpRmsM7iU4C53m6KCFY877Heqd5tSCYWLAm8mBmTCZzOmuBcYRX7DvxY0BKzm/fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDxY6ckEmMbWL3Z68I7wjTaxXsKvEU+5ajtSNupr30g=;
 b=MDnBdM8VyrUGvJ/A6TshtahoI/+yiNmscQTkBW1vdmPGyV7NID2Ab2nSOwEUf0u/3pByitZveRxasVifv4itho4oBge6qzQJdELh5r6BiC0KmDR5ydRlhST2pEvt4YOg2uwPRlLw+9fAN1uzwAd0i3AOwFehfjeS8v6Mp4HNbvkc6sVBeMwmuYDiWdcsogi/8mrF4b/U5MeO8Mv50Yut0ePLXr7ge1G5NvYAakp0BfI6vKTMJhQjgpxfDVzAOsQys3rt/u94axI7QfvHbjeIDhgAV+wKsuzob8+DHu4GYUvyAZfShCWRBc0rDqK0YS5HapoiquTv+uiZtu9VZszGDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDxY6ckEmMbWL3Z68I7wjTaxXsKvEU+5ajtSNupr30g=;
 b=oM63kGkgTos9eQK77sriIkaDriyvMV8/NPejRhfYBITTdHwDdr0d3L5bjgT147eVfqjqXfC8yaOz3bqmMinstKzbbvsCjkLhHgyBnP9FE5nwMajTVAAtwoTOGqoU0zQkaFb7JC/nlLINCK+e33WZK0kCLelIIcwbzukiM/mvLJswA9pfsgJmUjZEOOynAxzGD3WWmc/fagovm9oV6OyVTecUONUa2KDv91IB7JiD2Axc5RkUx0hufjT9avZDdguq4axvz1ooyk1WI8sy2sNV5wabRhVeD+yT/4ErNG0OrhKnqWrrWMtNy7WBl7ojsJ79OxJTlnbn0++EwsLKkGI5bw==
Received: from MW4PR04CA0237.namprd04.prod.outlook.com (2603:10b6:303:87::32)
 by SN7PR12MB8817.namprd12.prod.outlook.com (2603:10b6:806:347::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.19; Wed, 10 May
 2023 18:02:59 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::8b) by MW4PR04CA0237.outlook.office365.com
 (2603:10b6:303:87::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Wed, 10 May 2023 18:02:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 18:02:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 10 May 2023
 11:02:44 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 10 May
 2023 11:02:44 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 10 May 2023 11:02:41 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <hch@lst.de>, <sagi@grimberg.me>, <kbusch@kernel.org>,
	<linux-nvme@lists.infradead.org>
CC: <hare@suse.de>, <axboe@kernel.dk>, <oren@nvidia.com>,
	<ngottlieb@nvidia.com>, <israelr@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH 3/3] nvme-fabrics: prevent overriding of existing host
Date: Wed, 10 May 2023 21:02:31 +0300
Message-ID: <20230510180231.18865-4-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20230510180231.18865-1-mgurtovoy@nvidia.com>
References: <20230510180231.18865-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT015:EE_|SN7PR12MB8817:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e4373d7-5d2c-442a-7bd1-08db5180c9db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	jkvpLg0DomnFpfEtPm0p011on2M9XbT+QkV/Pa0bfoWRm3NcsVfeUTcNtMMjvAqRdYwUg7zZzNmCGQGIYl59GND5aJDeGlzLFXFUT6Hg/WkrXvfsQPkZ5CjSOpL08R3k2/T7rQw71h2d2xvSmToagkXo5rCwxGKIiukdqpfgtCkyjp43ZYgySD/Dl9d87zqIiXW+Aq+nKLSwFeE8cot+6FtFDVhuq7jos6RgSajbe1cZSHJDoqTciX7cCZA2hnj95GnU4qPFw5AFlwQT8g86n9foZNkvF4E8dKV7b9JE1MJbHF1ryZlO5+QbtZ6T4jw8jlz9I9iOj6j0KIYxJvCE47aTHmbTyKiHVDLWUYYbKdGvIId/doVdm6r8Yut7TAQa/qkMtj1oU7y6OiwmYcE/kADzWH7HPHUDGqelqqrbOkLUo0XsBpyRQl3JUiHoOui6vc57NM+qZDyCx7JKWiQLC+QPT/QWdcIMEhWuSVjTL2fPtAjDaoi0R/SOhNtrkPN/y1Ja+xldf8TSoikY/KSf4X/uxnsBxRpyFSIMQIcY3zpceHFbGub6jrK2y4oq8l0Lk4rhft7N8FqqwyF63LQNOYv9Es+3EdjiqXY4CpT3HwY/N7NOhb5AEd9NoKF/9lmVWMTLYZ63H78KNBRlbAVXEj329hcor9l1TTjJ5Ab9EG5G95+UBuCBNzgFN+Hf31imVcoVbbGaYHh3xFKmI+xI76v9APgcFrGauBlmyXzJrQu9QPTDJsi4LkzRC2qWzOfu
X-Forefront-Antispam-Report: 	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(46966006)(40470700004)(36840700001)(82310400005)(1076003)(26005)(186003)(107886003)(426003)(2616005)(47076005)(36860700001)(83380400001)(40480700001)(336012)(36756003)(40460700003)(6666004)(356005)(7636003)(70586007)(70206006)(316002)(2906002)(4326008)(5660300002)(41300700001)(8936002)(8676002)(86362001)(82740400003)(54906003)(110136005)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 18:02:58.6387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e4373d7-5d2c-442a-7bd1-08db5180c9db
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8817
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230510_110303_542279_D8790E61 
X-CRM114-Status: GOOD (  18.78  )
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

To address this issue, the code has been modified to assign a new host
structure if hostid is given as input during the connect command.


Tested-by: Noam Gottlieb <ngottlieb@nvidia.com>
Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/fabrics.c | 88 +++++++++++++++++++++++++------------
 1 file changed, 60 insertions(+), 28 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index d11db06d293b..7aca456e94ec 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -21,35 +21,67 @@ static DEFINE_MUTEX(nvmf_hosts_mutex);
 
 static struct nvmf_host *nvmf_default_host;
 
-static struct nvmf_host *__nvmf_host_find(const char *hostnqn)
+/**
+ * __nvmf_host_find() - Find a matching to a previously created host
+ * @hostnqn: Host NQN to match
+ * @id: Host ID to match
+ *
+ * We defined a host as seen by the target, thus we must not use different
+ * Host NQNs with the same Host ID. We do allow having same Host NQN with
+ * different Host IDs.
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
+		if (uuid_equal(&host->id, id)) {
+			if (!strcmp(host->nqn, hostnqn))
+				return host;
+			else
+				return ERR_PTR(-EINVAL);
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
@@ -60,16 +92,17 @@ static struct nvmf_host *nvmf_host_add(const char *hostnqn)
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
@@ -634,6 +667,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	size_t nqnlen  = 0;
 	int ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO;
 	uuid_t hostid;
+	char hostnqn[NVMF_NQN_SIZE];
 
 	/* Set defaults */
 	opts->queue_size = NVMF_DEF_QUEUE_SIZE;
@@ -650,7 +684,9 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	if (!options)
 		return -ENOMEM;
 
-	uuid_gen(&hostid);
+	/* use default host if not given by user space */
+	uuid_copy(&hostid, &nvmf_default_host->id);
+	strscpy(hostnqn, nvmf_default_host->nqn, NVMF_NQN_SIZE);
 
 	while ((p = strsep(&o, ",\n")) != NULL) {
 		if (!*p)
@@ -796,12 +832,8 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
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
@@ -958,13 +990,13 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
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


