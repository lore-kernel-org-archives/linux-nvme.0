Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 975E1D35167
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2026 10:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LxUECgEO6ttm7zpXcOL8CD/edUxV6Oq9ECWEvx8EWqk=; b=NiPQYID5LUi3kZ5DO1BJStUAHX
	jg6faNcG9UkjRrk3H1fUB7XuUWpTCrAtKlHkCAJHXK+7bjwUj4cTNzCxV5SHuVnAgjCLc8f0eHr8b
	V16zi5H4O5MY5ATl/EBLg0YtMkdKP/OaVFV8lYG8ZIYuiv4ytlORfo6w928rO9faxV6Wkpmf7UoMm
	DeKPu3mfdwh/h65JMS2zyzgOhcrf3bp7QAjwewjt9DR95p4Q/fdAU6maplrzOqHQ/RyzYRKIaTQKb
	W8Ar9BoDPb2yvdoumapYf5ePwShRLxaYB1lQ8wqXMg18+8NHOcaHMZCj7EXzzrQkF4zO5i2/5T7OP
	oHCjdMRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7scC-0000000EULm-1JAG;
	Wed, 01 Apr 2026 10:16:00 +0000
Received: from mail-westus3azon11010038.outbound.protection.outlook.com ([52.101.201.38] helo=PH7PR06CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7sc9-0000000EULC-2fd2
	for linux-nvme@lists.infradead.org;
	Wed, 01 Apr 2026 10:15:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XOoSLisNDwITgmKLQ+u9KInd9YStX8WK24mz7SQFLMfvPbzzlfvndi0MdJ/YaQIHKAOPuX/bFSnmLxp32QhBIo+TcjNL2kq/bxZUq92WoiHIJ2Pp79jj9tzESPDvb4YyT3+7/lEuJ9Ko2y0nMaCDUk5qqQ6ZuonvUtkOQoRGUpCvA6BTLhMuNe1fvBJw1CHuC/GDmMl4gndN+CppIMgq9D/TOIr82Fz6LSCEd9vaSYvpxLxqKuq6tyIZ0YwcpzrqIAvYcsNJD9AJ4jCW0mt6Uuh3kVQLVjPLL4hIc3vLnCIRnswDAV8+LLaNysVHLmerFHV0jRgyysX87FcmM1r52w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxUECgEO6ttm7zpXcOL8CD/edUxV6Oq9ECWEvx8EWqk=;
 b=KufEDh3Pea4bDmKbzDQTX2v1eptdyscpWMfpScNZjJWcPa22mPd9dfKBb9rw1lHbpgz+HLfJJc/4pl7uEJnJdZmRVHBNI4iTYSogGwGYnWP3p2te2kCiAS+Kb7JJcEqGWLf1KOuFvjbWSFwrWtRZDN1ZqstNm7MfRztrVpbc9OvRxeR/WQFpKtwVeTWsyBH7A0Saz2ocqga+P20QRt11j8aRIDkDOD35MtSkvKmYW9gbPsRa6H7HcTsbxUWmbYk6XRCsqucJdCO3jJADYN3BXkYVySPAr7nDhnHtZsc2Fme8KCNkDJ2kDmEVdY4Pfu13MnHB35Y2pq92n1eg6TYpMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxUECgEO6ttm7zpXcOL8CD/edUxV6Oq9ECWEvx8EWqk=;
 b=fDIxaP9wbdY8FwZm2fuvLP54AH1sZY+n9MEAqizDa/wx5zud0be4Dz/g4trgJkBjPF5/7WfB8TpxFsf6xITED8al/876/uEtgFxZ22j9E3dt1sx/3zGBqMioUS1esqtg3Rv6QZn62XLq8UYmIDexRBMCaXBToWO3LHUThO4U+6F3IRnf2JuEcFPEmBKgTk/WSfqSNm4ZrV9dAUs4jWV3QOiycubdviO4tpWcXREhUzic3bolEjWKHzZkSfVVGY57G82LI5RiAGODPNxKLqWRv7jnAuwBcwWuCsrQ4QdSaHda3iWOpyROa59CPudYkVu/vg4Lj71o9nZ6PmZku2paGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB9517.namprd12.prod.outlook.com (2603:10b6:610:27f::13)
 by SJ2PR12MB8954.namprd12.prod.outlook.com (2603:10b6:a03:541::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 10:15:51 +0000
Received: from CH2PR12MB9517.namprd12.prod.outlook.com
 ([fe80::2be8:2dfc:4d86:cfd3]) by CH2PR12MB9517.namprd12.prod.outlook.com
 ([fe80::2be8:2dfc:4d86:cfd3%6]) with mapi id 15.20.9769.015; Wed, 1 Apr 2026
 10:15:49 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: smalin@nvidia.com,
	linux-kernel@vger.kernel.org,
	Aurelien Aptel <aaptel@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH] nvmet: introduce new mdts configuration entry
Date: Wed,  1 Apr 2026 10:13:55 +0000
Message-ID: <20260401101355.163294-1-aaptel@nvidia.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0432.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::18) To CH2PR12MB9517.namprd12.prod.outlook.com
 (2603:10b6:610:27f::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB9517:EE_|SJ2PR12MB8954:EE_
X-MS-Office365-Filtering-Correlation-Id: a138a939-2ff0-43f1-8ca6-08de8fd7a5a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3wfwa2HyAsq86bFA6pztdcr/ZIMYRkFh1v7OtplGBkijflzS1QhTy7QRhRe9VM3GMAvvF2/XGXb6SXl734Vcxw+i0WTafegCD8ZiJoS3u5S6XXYYGUylez14Yl1Yg7bU8AyTcc26sBgnvkiJtlVc0zRylxDLOmv410XCo6GBTvr+5jjwIIv3Jppyp1RyBxwFdwG8fGYv6K5KUa4UoogjYUUm6vCnY5QUsC1p4PqCjdBmrPy4+QXSRnNcokM1/DbCVieSvMs7djYVs+vC8tCr7TgPR4M2OuvbOTn8lpZH+aazugHOyb/5ymQ750htOZMwGQSM2OTqwu3iYWpoR87kf7IH4NKghWLAogynuYoC/mrA60aubgcvcoqP/FRN0gKElR2jD2UotZ6TJmf+h8ulNmVtDEVnZD10lJGl9GA2MGiGIpzz72811Ge5vTJYpX7a9SPVbO4lDNqYlDl2AYVXotHJuedOxN8t2UrxCL4W/SWOG8KU67TF8OsHiolraRloryFiXoBMKkSrLce6rv1bCOXpVZac3E8gfARo84FWbYHW6DstPbMD4Cp+5Wdk/GE/chjgjHoh9FJieDdPM/cHR3eNr0WMT5Xb7qMlqr7Ti3jz1h8k/pMZ13/0ria4jhTVZ0oJG2fBoteBQbfD8tnu7wre19KdMhjrPbJ9VL9Pzrma+xtFtaqlDLSoV7uchUpAbO+XdJxeAXtZ9racVce2eBd8dZXydn2Qz6GpZWunfAk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB9517.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I7KJjj7gYXESG151vtZ56iP1Vm4QBLkWV3bFOKL2OW00x8fDdBSsWyHDbJlg?=
 =?us-ascii?Q?XUsfsBoZ5tprrDcweqdXt+LrfgLf2iGKUvpXNwU7ROveJxkCdCt844Ue9AoE?=
 =?us-ascii?Q?pnfCAFnYhsrRWkT2mGOJ1uGhe9k5ra9ntFftHZ8W3eZF3BKFxtI80jVk6OVp?=
 =?us-ascii?Q?Ko6uGo49Vsph36XTDkR0ouihw88fLzqyImfIe9HUJtssyW6MIn39E7IOXGE9?=
 =?us-ascii?Q?lAnpNDHYYg+e9v5KqaIH/aw4WYHv9tcdNOYF92bzXsaHzU1kcQy6Hbn+Lyuf?=
 =?us-ascii?Q?hqboumtCbq112auXHqGIozJeyBG+srpIOTUdxq23cuACPPnd0T0m4epnmRga?=
 =?us-ascii?Q?WWD90A7E6g+pzI6eMIzdtYysAR5LnNlDb5k17WvVR+uAQL/2lrdeiDJcK/kE?=
 =?us-ascii?Q?l2ioKW3loqUjz1ZaRyDLEjv4LRdR/TtKLIE6a273peDMhfCT2lC6qhpxjPfQ?=
 =?us-ascii?Q?SqOOK3H2kzkRIUFFA6TDM0VjoyHEPrSUTucJqfSuBwBn7pZCFokIS3/op5l4?=
 =?us-ascii?Q?bp1MktD4Q2/rw11RfiyPGxHWCdYNFxqtPl91MeOktLOBIZbE6bIMp6hi+AL1?=
 =?us-ascii?Q?YkEFZs9H1Tbo8AqrokamGaAPMiC6Twj2MEGgfeHd1c7cDl1jaeO3qP+Zn/B3?=
 =?us-ascii?Q?qQa+2jC6MRgsV+fHI7BL6ske6Hp4NGHV8aVIApXIobtAtVSh2JbdW4PGeaZ3?=
 =?us-ascii?Q?GZ8O3ddnERp9IQDiLuWMqJ1uKkzw7dcfJGAVrwrDJZdoZfcmjs3O3GMIKsO5?=
 =?us-ascii?Q?uhv3UnzH5K1v5RymJAjPy8WR8BcnPnL3U1Cn7hFFGnDmOGkynYxtFkGdiaBV?=
 =?us-ascii?Q?gvzZXEgafP4CDambFveevQiMNa/IUpFS6uAwS2ZPFea1ax4QD1uRqCpPTnRg?=
 =?us-ascii?Q?UTWuZtXX5OJk5UfyGvbTJOxEsqeRW8EqcJ31N4VxJK5TagpAYF/s2b6KJk9q?=
 =?us-ascii?Q?4tU9LvVC/H4NXbYP1IwWxe/tTWt114m1vmQv6VpNJemSaM2N0Sq40Xdizoc8?=
 =?us-ascii?Q?LJcpnMSrpilP3yD9P0t99z33MWNDWhcbrESkzLyCczEWOpIlstW4aIeSI+s5?=
 =?us-ascii?Q?xstGqWKMU20lpHOGneDRqYzukWlmduzon66oupLuGxGdfgNh5d3Z/wNGxPtL?=
 =?us-ascii?Q?dNTjze+Mt7//gFw10W4JwcDMcckAslZEa5mWwh84dEHXNn3TdEWDBi6g8/21?=
 =?us-ascii?Q?7uXpfXlWuaB3xVYYjtQe4aT4LVF2Va78mmgumSevEMA+IzG+Zl9UqTFwCeH+?=
 =?us-ascii?Q?BbeiaU5a2jq/oikS4HdT+SG5m0jfhnz9YXcfMYbqHSrwnuN5YJnSeGCkkjry?=
 =?us-ascii?Q?MeJT32wBRu07YIt4spYGKmPLPbP82BqT2OwNZ017+SPjakGXwG5VDFLpVrSZ?=
 =?us-ascii?Q?kETHLD19wrbJ230UQzskNGsW8UCgqoAmun+9EvhjTDLXyhUHPDeXjGqeq9pp?=
 =?us-ascii?Q?aUUznpd8S7oEFz5hAuX2f+BEVINqgKuFfO9wge+6OyoqOwTbQjSzkbHvYjla?=
 =?us-ascii?Q?XKGUwusz2RimWPg+5BISau2CITWcvguBXUrpr3fC6fcgXpBE/6OBPx8JUiIA?=
 =?us-ascii?Q?HyIn8Zbqo4EwyNSB0F5rxm5GnxB+x0Sh7xhsCua14douwqRZCTsdmbG5S0W+?=
 =?us-ascii?Q?vpYpfoGI5+B6cx8OD0B7wM/cXg4BsXThn1/9KXAzYwfNcTSydkaOmt11aUGw?=
 =?us-ascii?Q?ubwdJ9JU3V22gevJr08ARAy2ANhkN74U/8CrpS24vJ/YNbni?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a138a939-2ff0-43f1-8ca6-08de8fd7a5a6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 10:15:49.4503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cc4DTmI8QVw1nM5J8R/OHoN4uKfKoODZPHjysYntgblidW5iRWOfWIrsiyl+x6093AlVkqD2buiSnwy+5nzlow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8954
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260401_031557_681414_C1135D0C 
X-CRM114-Status: GOOD (  17.75  )
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

Using this port configuration, one will be able to set the Maximum Data
Transfer Size (MDTS) for any controller that will be associated to the
configured port.

The default value stayed 0 (no limit) but each transport will be able to
set its own values before enabling the port.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
---
 drivers/nvme/target/admin-cmd.c |  7 +++----
 drivers/nvme/target/configfs.c  | 27 +++++++++++++++++++++++++++
 drivers/nvme/target/core.c      |  8 ++++++++
 drivers/nvme/target/nvmet.h     |  2 ++
 4 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index ca5b08ce1211..057ac62f6f63 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -687,11 +687,10 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	id->cmic = NVME_CTRL_CMIC_MULTI_PORT | NVME_CTRL_CMIC_MULTI_CTRL |
 		NVME_CTRL_CMIC_ANA;
 
-	/* Limit MDTS according to transport capability */
+	/* Limit MDTS according to port config or transport capability */
+	id->mdts = req->port->mdts;
 	if (ctrl->ops->get_mdts)
-		id->mdts = ctrl->ops->get_mdts(ctrl);
-	else
-		id->mdts = 0;
+		id->mdts = min_not_zero(ctrl->ops->get_mdts(ctrl), id->mdts);
 
 	id->cntlid = cpu_to_le16(ctrl->cntlid);
 	id->ver = cpu_to_le32(ctrl->subsys->ver);
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 3088e044dbcb..63d72fbf4d9d 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -302,6 +302,31 @@ static ssize_t nvmet_param_max_queue_size_store(struct config_item *item,
 
 CONFIGFS_ATTR(nvmet_, param_max_queue_size);
 
+static ssize_t nvmet_param_mdts_show(struct config_item *item, char *page)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+
+	return snprintf(page, PAGE_SIZE, "%d\n", port->mdts);
+}
+
+static ssize_t nvmet_param_mdts_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+	int ret;
+
+	if (nvmet_is_port_enabled(port, __func__))
+		return -EACCES;
+	ret = kstrtoint(page, 0, &port->mdts);
+	if (ret) {
+		pr_err("Invalid value '%s' for mdts\n", page);
+		return -EINVAL;
+	}
+	return count;
+}
+
+CONFIGFS_ATTR(nvmet_, param_mdts);
+
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 static ssize_t nvmet_param_pi_enable_show(struct config_item *item,
 		char *page)
@@ -1996,6 +2021,7 @@ static struct configfs_attribute *nvmet_port_attrs[] = {
 	&nvmet_attr_addr_tsas,
 	&nvmet_attr_param_inline_data_size,
 	&nvmet_attr_param_max_queue_size,
+	&nvmet_attr_param_mdts,
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 	&nvmet_attr_param_pi_enable,
 #endif
@@ -2054,6 +2080,7 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
 	INIT_LIST_HEAD(&port->referrals);
 	port->inline_data_size = -1;	/* < 0 == let the transport choose */
 	port->max_queue_size = -1;	/* < 0 == let the transport choose */
+	port->mdts = -1;		/* < 0 == let the transport choose */
 
 	port->disc_addr.trtype = NVMF_TRTYPE_MAX;
 	port->disc_addr.portid = cpu_to_le16(portid);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 9238e13bd480..779d8a130619 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -370,6 +370,14 @@ int nvmet_enable_port(struct nvmet_port *port)
 					       NVMET_MIN_QUEUE_SIZE,
 					       NVMET_MAX_QUEUE_SIZE);
 
+	/*
+	 * If the transport didn't set the mdts properly, then clamp it to the
+	 * target limits. Also set default values in case the transport didn't
+	 * set it at all.
+	 */
+	if (port->mdts < 0 || port->mdts > NVMET_MAX_MDTS)
+		port->mdts = 0;
+
 	port->enabled = true;
 	port->tr_ops = ops;
 	return 0;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 319d6a5e9cf0..90ca10cd9438 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -214,6 +214,7 @@ struct nvmet_port {
 	bool				enabled;
 	int				inline_data_size;
 	int				max_queue_size;
+	int				mdts;
 	const struct nvmet_fabrics_ops	*tr_ops;
 	bool				pi_enable;
 };
@@ -671,6 +672,7 @@ void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
 #define NVMET_MAX_QUEUE_SIZE	1024
 #define NVMET_NR_QUEUES		128
 #define NVMET_MAX_CMD(ctrl)	(NVME_CAP_MQES(ctrl->cap) + 1)
+#define NVMET_MAX_MDTS		255
 
 /*
  * Nice round number that makes a list of nsids fit into a page.
-- 
2.51.0


