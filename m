Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7785C7EE24
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Jun 2023 06:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wTkciDZIbHfzOiCFPpS7yaXOsrcnKyPIga9jHBR8JPU=; b=21N7ZXfK6ybJNymHKdQARO9adK
	FajTx3OeH2o4I1EKJI4Sv88cIsu4QprgYJDoswPbuENyDe5qgjrkSzsNBo9M4Ewt+SyTf307lpWkJ
	Mg34N2qhrptxdlhsP4Yrn457PkgycKLHHXhBqnIDXNjpRiSFeQaE0w0c16WFhoYN7JoVvr8y10WNT
	IhqpAUKMFVVMTqPZ3MM6D5GPLg8eF8KIareWbXn2FY2DsDcaA/+lssfngvEltIe3W8kx2lfpvy+LH
	k5//pB0QCXgjwXjtlyjEUCHiN7+nZZedoWpQdnWQTCcwdNrS2Wah3uWzJuKXrbrYEwelBj1zQ9uqF
	02yv5t8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4yaB-005vYG-0Z;
	Fri, 02 Jun 2023 06:48:19 +0000
Received: from mail-bn7nam10on2062f.outbound.protection.outlook.com ([2a01:111:f400:7e8a::62f] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4ya7-005vWu-2w
	for linux-nvme@lists.infradead.org;
	Fri, 02 Jun 2023 06:48:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dC3l0HVhRn+Tnd3nN0nFggx5zqFIDk8FzOLak2tJy9aM6t4YbcPaOT6YCamat0NK/GmBpNjFUrOuEwG7zYqSOLdPlebUFGxeMiO7C5qU71Ubtixb1JwD1tU/Cd2JPIoTiu7arEFltg5fqMLdKsD2x80fgbFZaqo0+9ZCf84HyFAT+RYbMRmIAYrjV20GDmaPxCO6JOEBTTgXpr2GKX7Q/WpM1T2vkHUPPg/tvY1Hdf56o+BUr+ZpefVrqusGbdASA/c3RCP+kQflvZff9ey0U8tBkdov+UMcn1TEYVcSxpyHP8BJiE5V62SIg57219sF6PAvEpcmDTrZlMwtcmQAWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTkciDZIbHfzOiCFPpS7yaXOsrcnKyPIga9jHBR8JPU=;
 b=Nn75PvK5Pl4V4hs2umiFxXkI76fxQJTCqMqmsq7C04DEPzC0/Ufd1dN0oFSotwwobpDdX4vPAyIoM4IfIyfYun/0WZE7Ow57sgW5qTAfsSVj8A0QKO/D7hC+EWDCWRFTGBds+dKzwM0OIGCYUgSMIddqCfJ2KaW/6yzWC5MTnMm2O4i+Fy+LjuNFDe+QfkD5W+XaHRrry9r9+yLMnfIc0qQ7rZHn8revv54Yk0RJs5GUtVfClAzvoiH5bhf46pHMCryD36SVSX/1GaO1Gj9LKkxO21wecacOTmMNykPbJU7R2FEOAWP+5R0+zcaAi5DWv4gHU6VGk/buaLbZREU0VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTkciDZIbHfzOiCFPpS7yaXOsrcnKyPIga9jHBR8JPU=;
 b=tdnfy5fZDeYrDidPwdGJon4WVuunPpqhpkaOnc8kHKfBvMbpuY49qMGRXpNZ1AjBZlJOXRhJiKS+I00nUl7/0Tj0uSQ+NjvVzhn3o8XjorG4piGuy+LnKdPwMDkdAtbATIFGgrigRqiLG1fOM/FObTMYaQlm3V+ocmRHTDifOFpuPDgdCy5+zQ0Od1i74P2LkdrjniAsPey8oFTHalmX/Rfwy69DfQZnfyXenajiUcCAjubx6374kyRe+0iR087ANAYXgVUW9JiZojvGxDriAPQHKOHnJZzo6NW1kOYBX8bqodd3mh84NNDMboM0WTmM57gsgFehnPY14KRSnbknbw==
Received: from BN1PR12CA0006.namprd12.prod.outlook.com (2603:10b6:408:e1::11)
 by BY5PR12MB4100.namprd12.prod.outlook.com (2603:10b6:a03:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24; Fri, 2 Jun
 2023 06:47:58 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::fb) by BN1PR12CA0006.outlook.office365.com
 (2603:10b6:408:e1::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24 via Frontend
 Transport; Fri, 2 Jun 2023 06:47:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.26 via Frontend Transport; Fri, 2 Jun 2023 06:47:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 1 Jun 2023
 23:47:49 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 1 Jun 2023
 23:47:48 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>
Subject: [PATCH] nvme-fabrics: open code __nvmf_host_find()
Date: Thu, 1 Jun 2023 23:47:42 -0700
Message-ID: <20230602064742.56298-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT064:EE_|BY5PR12MB4100:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b09209b-d4e4-4556-4745-08db63354d33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g/30zAcqb+7lzZKuGElapr79BVB4D5zeTwAEYdTOJcmw8OJ0kPctfls9GtA2OB1092sn5CUaW3EuwHmBHl4O9xpicY0MnNyk2X9113p1WfkH8Xn5EFAoObBrJ6cN7H/JZh9y1vB9vEG98twI8AvlGSVGlW8nU7tEzPf5tsTvxz2NoH5NhS3wTwWKZwJLjYrlu2pKme18QSoFyva6PbxrL2hBBsr8Xn5JAqbXKNd1uZrNKC45ePA9gRo8x7k1U0ZAqsN22SqSbhjuyY8sZWWf+BYTpr4TVpuDcTB4AYvsm4tdHLRyIjq0CesHDuKga3vSgbJJfEqPOs+YDoyjE8MjUeZANTWxJyrY6FvNTTUF00+NNlBOKE89wX2Azn5/B6qDZ1zJGDYFxOWRF18PW08TmnjGLrkaP6mzMFPJsysj9mpi0S4vaEKAyxrQ1UMHgpXlzE7FVPxSWHhpn9ZOUbYE2MYn7d9AfGQceeHzpJYrK+DcLXtEUP25C7CPcQNlaGTGhuIFP57QvopGJ003O0YZKLDVkJAj4zSRjX5d6WhH4ZbdDY66Sm60saLEK129QAmlCr+93lP7cImclzbXW7ao2L2XTdNx6AVd2UKJJYwjkHmcMJ3aUf7mXjyePXDc8kBl0j+9xvn8IUUkjF/eca7XfbaexCthBDq3ZuDABMjYxzYUBdz5B1Q3C+6o5iGeKvESL/GkE+e2UnexVTIo+7GQ27d2DiRMcwXTlJz+Mcl1NXVCEM6CxC9f8A5/odJlwgB1
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(107886003)(1076003)(26005)(4326008)(7636003)(356005)(47076005)(82740400003)(40480700001)(41300700001)(83380400001)(316002)(36860700001)(70206006)(70586007)(478600001)(6916009)(16526019)(36756003)(7696005)(6666004)(8936002)(2906002)(40460700003)(8676002)(5660300002)(186003)(54906003)(336012)(2616005)(426003)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 06:47:58.0805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b09209b-d4e4-4556-4745-08db63354d33
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4100
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230601_234816_008648_9E33DA57 
X-CRM114-Status: GOOD (  17.73  )
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

There is no point in maintaining a separate funciton __nvmf_host_find()
that has only one caller nvmf_host_add() especially when caller and
callee both are small enough to merge.

Due to this we are actually repeating the error handling code in both
callee and caller for no reason that can be avoided, but instead we have
to read both function to establish the correctness along with additional
lockdep warning check due to involved locking.

Just open code __nvmf_host_find() in nvme_host_alloc() with appropriate
comment that removes repeated error checks in the callee/caller and
lockdep check that is needed for the nvmf_hosts_mutex involvement,
diffstats :-

 drivers/nvme/host/fabrics.c | 75 +++++++++++++------------------------
 1 file changed, 27 insertions(+), 48 deletions(-)

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
Hi,

This is generated on the top of posted fix :
[PATCH] nvme-fabrics: error out to unlock the mutex

-ck

 drivers/nvme/host/fabrics.c | 75 +++++++++++++------------------------
 1 file changed, 27 insertions(+), 48 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index c4345d1d98aa..8175d49f2909 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -21,48 +21,6 @@ static DEFINE_MUTEX(nvmf_hosts_mutex);
 
 static struct nvmf_host *nvmf_default_host;
 
-/**
- * __nvmf_host_find() - Find a matching to a previously created host
- * @hostnqn: Host NQN to match
- * @id: Host ID to match
- *
- * We have defined a host as how it is perceived by the target.
- * Therefore, we don't allow different Host NQNs with the same Host ID.
- * Similarly, we do not allow the usage of the same Host NQN with different
- * Host IDs. This will maintain unambiguous host identification.
- *
- * Return: Returns host pointer on success, NULL in case of no match or
- *         ERR_PTR(-EINVAL) in case of error match.
- */
-static struct nvmf_host *__nvmf_host_find(const char *hostnqn, uuid_t *id)
-{
-	struct nvmf_host *host;
-
-	lockdep_assert_held(&nvmf_hosts_mutex);
-
-	list_for_each_entry(host, &nvmf_hosts, list) {
-		bool same_hostnqn = !strcmp(host->nqn, hostnqn);
-		bool same_hostid = uuid_equal(&host->id, id);
-
-		if (same_hostnqn && same_hostid)
-			return host;
-
-		if (same_hostnqn) {
-			pr_err("found same hostnqn %s but different hostid %pUb\n",
-			       hostnqn, id);
-			return ERR_PTR(-EINVAL);
-		}
-		if (same_hostid) {
-			pr_err("found same hostid %pUb but different hostnqn %s\n",
-			       id, hostnqn);
-			return ERR_PTR(-EINVAL);
-
-		}
-	}
-
-	return NULL;
-}
-
 static struct nvmf_host *nvmf_host_alloc(const char *hostnqn, uuid_t *id)
 {
 	struct nvmf_host *host;
@@ -83,12 +41,33 @@ static struct nvmf_host *nvmf_host_add(const char *hostnqn, uuid_t *id)
 	struct nvmf_host *host;
 
 	mutex_lock(&nvmf_hosts_mutex);
-	host = __nvmf_host_find(hostnqn, id);
-	if (IS_ERR(host)) {
-		goto out_unlock;
-	} else if (host) {
-		kref_get(&host->ref);
-		goto out_unlock;
+
+	/*
+	 * We have defined a host as how it is perceived by the target.
+	 * Therefore, we don't allow different Host NQNs with the same Host ID.
+	 * Similarly, we do not allow the usage of the same Host NQN with
+	 * different Host IDs. This'll maintain unambiguous host identification.
+	 */
+	list_for_each_entry(host, &nvmf_hosts, list) {
+		bool same_hostnqn = !strcmp(host->nqn, hostnqn);
+		bool same_hostid = uuid_equal(&host->id, id);
+
+		if (same_hostnqn && same_hostid) {
+			kref_get(&host->ref);
+			goto out_unlock;
+		}
+		if (same_hostnqn) {
+			pr_err("found same hostnqn %s but different hostid %pUb\n",
+			       hostnqn, id);
+			host = ERR_PTR(-EINVAL);
+			goto out_unlock;
+		}
+		if (same_hostid) {
+			pr_err("found same hostid %pUb but different hostnqn %s\n",
+			       id, hostnqn);
+			host = ERR_PTR(-EINVAL);
+			goto out_unlock;
+		}
 	}
 
 	host = nvmf_host_alloc(hostnqn, id);
-- 
2.40.0


