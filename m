Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B3AC77B7F
	for <linux-nvme@archiver.kernel.org>; Fri, 12 May 2023 15:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MOpBXBCa3Z9Uj1nRtED4EIMC34Ya3u6V63oL0BYSJR0=; b=DDAQDY7i6zD7t2lYWncU93mqZt
	xSiurZEKh4mQ51WAfSm5oEeX+5mBl/3MZbdiTo0khSZ6GOGtVnP0zmjRlyTIsgkJ1HfvE2CGgIVsC
	qIeXwVlUJcm2G/QzHPcMGWLB1nCXqyrQf25dlJIupuICoQlE9Hv6VbDi1VzW3hjvHty4sQ7zKpozV
	nEQhRRDJofu8N9+Qa2088mk0Ta7NmAo3EV2Ng6pEoAM3YpjHE4QTWB9kiTEcM7Uu8+Oje8+vAmn5E
	Gk5WnZzT4YuviYl4cxzjI8Ij9aASM5by8/uC8ufgLh004vWi6K1h+pWJnJ8cBkxcxz8sokxg/WK1h
	iLcSattw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pxUue-00COgl-0u;
	Fri, 12 May 2023 15:42:32 +0000
Received: from mail-bn8nam12on20616.outbound.protection.outlook.com ([2a01:111:f400:fe5b::616] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pxUuc-00COe1-10
	for linux-nvme@lists.infradead.org;
	Fri, 12 May 2023 15:42:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrPltEwzlRv7cFTHFNwI1wybr89mECgrFXi3ToGoyDkHMCRvFb/oqZ9JOkNP8qxnEpb5X6fbMaqvn6S8o7JwlP1CE7SZwF+6PSU3ojAm1zCnzcBJktveeV21RWPMxVVEQqN7DRY2UMg4eGeoC0744h1EVp5v/yIwhk8T2bg2g42m94Anhnxg3xrz0m1T3KL31BIjJT7j1dki22E/nmNuCe3oroniDhZsnJkpD0gr6pVXZkspfhj5qhiSzb4rDSZBY0p1vd5KeFM0WK5EgeALGZs2b525Tn25os8jcnQNqqzpK4w0woxr3yAfcVM9n8R25qj4Sz17mTzMN5YMeW3kVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOpBXBCa3Z9Uj1nRtED4EIMC34Ya3u6V63oL0BYSJR0=;
 b=loIakassrirCmB1ORGwU+OW3eqjqiNDk6nDxhiCjEETgddJXvWfsF+2cg7JIk8UkQxkJmihDK2EYtoyAo+2gy8+B3XUkRtk3Q7f1ww0nff5d0P27JENmiYxw3d1x2HAgx0wEFQ1gLW6wdAXlGr7kuDQZwkyyGlddKgBtQKBj5DZaq3rv4fPiSJpIf3o+KSeNZxEQaTFpXYPOnFd1uR0XnjL4/8xmVTXsk1biXNob0KSGfZJaLz7VANqMiDa9qL+v2xAzniwuxeLsU0Ot4qbY3X1z3WFo7tgBiWILGQX9e7r5IdT4keIj8XI3y8GWrzY/+K1fS8uQloAeNe4itBcHqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOpBXBCa3Z9Uj1nRtED4EIMC34Ya3u6V63oL0BYSJR0=;
 b=eRs+Id7wxkROT58hFv//UqtOpAKcwm1cAEGwOklwPCYyrPFxwiNqlm6sBh5tEXGytW2bmyLbjCPKJJ0ZO0ppvC3CMqla0LvU4025LvFbT6gp1yq7+29wyBINGjB6rrPPVccNhSkm8mAdlhGyJes2JoagJgzQF0PvwchYgGWKFkYSk/bv78icQLM5XyTxCQP0F0lQlOeXZl/fvXcv9/ZH/cSkPS8XhVsCTwcZNwHR9k/kVR4PZNqghXie/yxhn9R01Klxy/m3sAOyZiahbfeTt485YzeUjUCYjksXiuRLGmcwhkSrldKiMrhxo1QLZsvdIlFDj327U82+fRuigvy2sw==
Received: from BLAPR05CA0004.namprd05.prod.outlook.com (2603:10b6:208:36e::8)
 by PH0PR12MB8152.namprd12.prod.outlook.com (2603:10b6:510:292::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Fri, 12 May
 2023 15:42:23 +0000
Received: from BL02EPF000145B8.namprd05.prod.outlook.com
 (2603:10b6:208:36e:cafe::1b) by BLAPR05CA0004.outlook.office365.com
 (2603:10b6:208:36e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.9 via Frontend
 Transport; Fri, 12 May 2023 15:42:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF000145B8.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.11 via Frontend Transport; Fri, 12 May 2023 15:42:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 12 May 2023
 08:42:09 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 12 May
 2023 08:42:09 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 12 May 2023 08:42:06 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <hch@lst.de>, <sagi@grimberg.me>, <kbusch@kernel.org>,
	<linux-nvme@lists.infradead.org>
CC: <hare@suse.de>, <axboe@kernel.dk>, <oren@nvidia.com>,
	<ngottlieb@nvidia.com>, <israelr@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH v3 3/3] nvme-fabrics: prevent overriding of existing host
Date: Fri, 12 May 2023 18:41:55 +0300
Message-ID: <20230512154155.38694-4-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20230512154155.38694-1-mgurtovoy@nvidia.com>
References: <20230512154155.38694-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145B8:EE_|PH0PR12MB8152:EE_
X-MS-Office365-Filtering-Correlation-Id: 3282fe9b-e1a9-4ebd-9592-08db52ff7ad9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	DYNONO8w728FMi81c3094EFLGoT4YhuOlo9F/j+ywLNoi+DpfkNut6l3s+SC/tBz00R45gG5IZffc+3nZMgUgbFIsc4Tg6MesWEoLsY9UjfVMF4wRZF6Rt0udYeMNc46ZiNMnM6mBuqkMdsviqpeXdiv3kYu4HI2Eq7CDP+PA9aIdldgMrErnZdOu84YOStSHUF+B5QWiUHd+Lq/UMC7MFk1ysj6OELKe2c8pJNKXHpjBF1MyGAmYNAv5tn9OikLWaedaEhQDicj6Ymg/U7VfiUbAixyFvxrn9oRZD74utfVc388XA7NW368+FEEiaUsM9ASza0eVCrkInELM6oW37/uwX53ulgR3PNdxn87KYqt4YLiIR1VY+hNYAEluSQDLy0/sMAnfSXwMmR7VamDPhe1HJaQJnaMABEf6s4Y+4dviV69Z/NRwVi58wlvyqwSreUK2mnbBo0SLWuhwWLvF8ghGYTfaRKvRODktVBwxVGEMT3yq9heEUE7ltUyOWuq9Gt0qSimuGXZ5L0n5epHChlJpWMKG/yFjeO27W4BHC2djNO/3AZSizOAhDdfEiA9VqkCCYKpBTqGtkX5vNklmO3uauimtbydjlOJutfb5eAUBg2EjsA16Fr9tXwY3iW1yQHgLCztZmfWP90hx+UPj1QHFljTfHF7YOOShtpOVr8BUS18W0OqpiTbKC1MD139bFu7CwNtgWlyI2m6eopIUw==
X-Forefront-Antispam-Report: 	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199021)(40470700004)(46966006)(36840700001)(336012)(186003)(2616005)(40460700003)(83380400001)(426003)(82310400005)(36756003)(36860700001)(86362001)(40480700001)(7636003)(356005)(82740400003)(47076005)(2906002)(316002)(41300700001)(54906003)(107886003)(110136005)(5660300002)(70586007)(70206006)(1076003)(8676002)(478600001)(6666004)(8936002)(4326008)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 15:42:23.2556
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3282fe9b-e1a9-4ebd-9592-08db52ff7ad9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	BL02EPF000145B8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8152
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230512_084230_354464_DA32B667 
X-CRM114-Status: GOOD (  21.62  )
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

changes from v2:
- structured the code and removed comments that redundant now

changes from v1:
- address comments from Christoph
- allow only 1:1 mapping between hostnqn and hostid
- add error prints in case we fail a connection for user to understand
  the reason of the failure

---
 drivers/nvme/host/fabrics.c | 98 +++++++++++++++++++++++++++----------
 1 file changed, 71 insertions(+), 27 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 0c0172bdc4dc..fc069c41260e 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -21,35 +21,79 @@ static DEFINE_MUTEX(nvmf_hosts_mutex);
 
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
+		bool same_hostnqn = !strcmp(host->nqn, hostnqn);
+		bool same_hostid = uuid_equal(&host->id, id);
+
+		if (same_hostnqn && same_hostid)
 			return host;
+
+		if (same_hostnqn) {
+			pr_err("found same hostnqn %s but different hostid %pUb\n",
+			       hostnqn, id);
+			return ERR_PTR(-EINVAL);
+		}
+		if (same_hostid) {
+			pr_err("found same hostid %pUb but different hostnqn %s\n",
+			       id, hostnqn);
+			return ERR_PTR(-EINVAL);
+
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
@@ -60,16 +104,17 @@ static struct nvmf_host *nvmf_host_add(const char *hostnqn)
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
@@ -633,6 +678,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	size_t nqnlen  = 0;
 	int ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO;
 	uuid_t hostid;
+	char hostnqn[NVMF_NQN_SIZE];
 
 	/* Set defaults */
 	opts->queue_size = NVMF_DEF_QUEUE_SIZE;
@@ -649,7 +695,9 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	if (!options)
 		return -ENOMEM;
 
-	uuid_gen(&hostid);
+	/* use default host if not given by user space */
+	uuid_copy(&hostid, &nvmf_default_host->id);
+	strscpy(hostnqn, nvmf_default_host->nqn, NVMF_NQN_SIZE);
 
 	while ((p = strsep(&o, ",\n")) != NULL) {
 		if (!*p)
@@ -795,12 +843,8 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
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
@@ -957,13 +1001,13 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
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


