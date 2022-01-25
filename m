Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39272C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Jan 2022 15:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oDv+oF75RVNxbmwcxTT24YHQfaxGy9jobEwIakEFbaw=; b=LUUDcHhsxrVFfJxt0kOObZB02u
	wewJm45Itg+1La1pV5yFObfdVmYmwVzFXhpLKCDRVIXzSpvYMDDPrZGxJL82ziyBW7b+ZCIkozO5H
	DFu/WA8MH+EH2SHlsK8zxEzYfCsxhrkYtGupytl6xWqgFa1EUMZMCQYOTNN9RADQWV/6UEQBorjak
	wrxUcczgsop7QTxqcx30KA7P3h6YEkR62ewP06F3sK2kIrqYfmWJPWEMw9tA9sjapdTiRlM+pmMEe
	4emdpWju7fPWb3oTYLge1ic4bTVXsG0btZY9jBrr3XH+ALXTmhZTXvC5tGhI7MtOh+MkuCVw7Hvw+
	rS8vYdzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nCNJU-008Ef2-GM; Tue, 25 Jan 2022 15:00:52 +0000
Received: from mail-mw2nam10olkn2079.outbound.protection.outlook.com
 ([40.92.42.79] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nCNJ0-008EVu-AF
 for linux-nvme@lists.infradead.org; Tue, 25 Jan 2022 15:00:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4q5oHgR3g147Qo2k8WufkyxNU+zAgGgP9GoetWy/eZczOoMBVT41T0Xei6E1F/a67TJ0AbA2ASVxSnJJz1j2GSpXPaywp+w2oN6amgZfuvnZb0GkykwSgUIMwV66DFvZtj37y0tx9S1gfqNWPVbrXMNJHmXidLanBd7MllxAt9csnQu34+7Gzys+uA9jrRz5+F8vol9Dn3PTme9tJnrBs3QhI5tlzDHcWeXMKB7jWUkjlUTfeYJ5YavfPnWCuz475monoXBJznBKUxZWmOrw6hjw0wdDzy1exIqU5NAWaTqjQ8NuY45OoVcbUHCSz5L63ziCzo+K7D3JS71EkYUpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDv+oF75RVNxbmwcxTT24YHQfaxGy9jobEwIakEFbaw=;
 b=EJR0WrFtVrHVnRY+tn1ddZNSJ3Knab6OaelAJulE9mR06BHHFZZT1cLteO9iSq8Jr3Y0hPiOxXmyltkt5UFni8m99eENBT6sLNRp15nzlFHvMR5FoBhfxfp66SMz24DUMjssHkdK767ox6QRdJiMIT35JDnYh9rzq2SIlMke0i5nXS2SiTG0Mxi5Z8pXEXkioDv3VrLBjBFTfMA/qrhEe/vaPDl//YfrrzpwwoLm1d82dHGN5Ymo/Pave3gvER81Q5QBNX+q6brZ57AGU5vT6rJSWHZ5VsrVhJcvxlzQa2MCJ+FwlJlZT/BTMJ4rVpNr6GaVfdQt2HNJ8acEy60Mgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDv+oF75RVNxbmwcxTT24YHQfaxGy9jobEwIakEFbaw=;
 b=Y+Ipga21Crfg26rhORlyGHdoVc2o0oS8qTx/wKCGXxwnYLL7rQKFjOdZxT6hJblOP3JwGKK2epedHwz0f0tPPTJRq4y1Y0VYXKdf4S3mc2SNhgV5NJZVXZFteIxjjMfHxXITAvtIiuVIIq70n/gFvCnikdn/uTbJW5OXHb0iHM5EHTr86ElGRLDUeKmAX6cV1jTyHY9HeNnrAqO7xCAXexlfW3nUqTDAzNQ0u7NzpSQBcVF6Lbshmvfipd2RVnyJinaZxQBdh32xJHmcj26S2W//fom3/AhEzo5fOOvQofTUII6TCsTUGAkAaIOk6a8Py3URSK+f4iMhJd4m1mEjMg==
Received: from BL0PR13MB4291.namprd13.prod.outlook.com (2603:10b6:208:8e::12)
 by MN2PR13MB2590.namprd13.prod.outlook.com (2603:10b6:208:ea::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.8; Tue, 25 Jan
 2022 15:00:18 +0000
Received: from BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::8078:8a78:bc1d:43f1]) by BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::8078:8a78:bc1d:43f1%4]) with mapi id 15.20.4930.015; Tue, 25 Jan 2022
 15:00:18 +0000
From: Martin Belanger <nitram_67@hotmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hare@suse.de, axboe@fb.com, hch@lst.de,
 sagi@grimberg.me, Martin Belanger <martin.belanger@dell.com>
Subject: [PATCH 1/4] nvme-fabrics: add discovery controller type
Date: Tue, 25 Jan 2022 09:59:53 -0500
Message-ID: <BL0PR13MB4291022C56E35D6F93500AF79C5F9@BL0PR13MB4291.namprd13.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220125145956.14746-1-nitram_67@hotmail.com>
References: <20220125145956.14746-1-nitram_67@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [BSmv5m4ZXL4Oz+tPL4RQbefI1IacbZYv]
X-ClientProxiedBy: SA0PR11CA0170.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::25) To BL0PR13MB4291.namprd13.prod.outlook.com
 (2603:10b6:208:8e::12)
X-Microsoft-Original-Message-ID: <20220125145956.14746-2-nitram_67@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90b3f953-31f7-423e-b00a-08d9e01366ce
X-MS-TrafficTypeDiagnostic: MN2PR13MB2590:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1GZawd6uVYp8ALUrZmgsFsKRtt6v3+rFsTkUOxatkcg2lwFnc9BlKJmpGjr89veF99ICiLcneHncUKWU1jxVWWMDqBYftwt4bWO+f5w5GGQz4NZWe/4Mkzn3P5hoMeuqS+3Ltpa+ycYP4v+6hWz77werbxRY/j4TK3td2CGtIc8MWs+HNnr1PHZC99rUp+CQRAYkqc8l8TXhanBy9MZCC9HcrxLCVG7YWG90kDmctWH0jcg0+Li0XOLdMB7+r5eP9OQHJoPQL5KKV9YbiXEfydIAlbxh62C7HCpg23KCjmUKSdg/8NBDY0e2rs6WRVBBxJIPHJnWbkbGwqOoLD84MhMtB+FRVHflUnLMLzK9eDYmFVP6j1lbHk3OhfPJcBdU3P5RHLPxyXk96xy9XxxfT9QxFuSl8noQ81bIvwDPuyysD+HKh/xC1O5QAnkgreWCAaZ/kJ1RwTGCLX+jIA4YIHRifqKNqNQR04S+JocLB0VqOvu/hKA9AjDTr7jyzAdrspzkTB72Gl2RrgZkwRLa22DXMsV10SrgMJZVT9IOdpDzMUoJJZHhy+gKzmTWiSgI
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2v+8tbuvdLsAZ+jXFMU22/rvTlRnX2sPRnBbW1mpRhvhdmN9hwSjtUodtsXu?=
 =?us-ascii?Q?6pYwCZYvQGm9oKv1nUC3rhq7bOni4x1/alLOvoFEwRfkZ59oAbifu8wU0OkV?=
 =?us-ascii?Q?BVkiyRa9v1JHXH9weaq77FvQvHZ0Hw324e6h5nveExxVpCRrR1jKQSDf3M/l?=
 =?us-ascii?Q?ut8XbaLZoq8e/U+4dWfA+PiM9eYyq9C9VSAdB/4rBX56zio/Gt9ath/e+wLa?=
 =?us-ascii?Q?VoYVDJKU9BhHUE5hG0I9/bkZCxEJGK+y3JI39in26TeNAD16/oAtQqqKn6Ja?=
 =?us-ascii?Q?GJGWgPp1MjY3jGOADQ/9KS7BAxbj3CaiDP4UlQxcv0kGDTMV+WnryxYfZO8n?=
 =?us-ascii?Q?I8lF8v+t49ZbQztyKM/4WiLWLb8dDKC/7YApgL4lKeN62pP7mL2As9bCtZej?=
 =?us-ascii?Q?sg3UsGVMIUk31+3T0m2nOEpMwvyEfS2NR+41BvNQ3pznN3VhmPQianXQF3Pu?=
 =?us-ascii?Q?4iWRPHVcCGkphKCzE8Ip9AtkssPWdB2O02WAhlhHXUajmTYt3LanCK20QTQB?=
 =?us-ascii?Q?/NfPwG9dz2R5VBd+ewKLtiMn0N4cUe4cGermHKnk4I9TsnpdDXrrmISa5ijp?=
 =?us-ascii?Q?9+3tm9ULsCiqKHeZiYpaScGlUfULkxicDOXV0Ahyna9wAnj9HQEllMSrHYx3?=
 =?us-ascii?Q?dYoeVyc1nm15uIDEV1mS61zvjB/HKePZ9mB5+8rq1nEYPl0BGg9PY5RnDGIp?=
 =?us-ascii?Q?PswJOWiRbvqaY2C5++ihTpXSu9AHHAhBd1CoGNnQSbp1+m+3oK/GAjntlueL?=
 =?us-ascii?Q?JSCYHcPEaj4e0I3DIa4h1Wk8/kMJm+WRABOfE0gCh+9nJxGyVDro+Fp+dCft?=
 =?us-ascii?Q?sRlxdkZ1RsAQJaeGqGcXmAvBM34I6dNEa46dJABnEBzfVD88QuhuBKaNL6g8?=
 =?us-ascii?Q?CdBgtEVytlVh0hpfy7kTR1dro7fi4mRPGq20Lh97YNu2KqEBdUSTjFLPoKP/?=
 =?us-ascii?Q?3P/B8qGPqh+oxBadfXAC5Q=3D=3D?=
X-OriginatorOrg: sct-15-20-4778-2-msonline-outlook-da780.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 90b3f953-31f7-423e-b00a-08d9e01366ce
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4291.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 15:00:18.8769 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB2590
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220125_070022_386373_D3B0368A 
X-CRM114-Status: GOOD (  12.61  )
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

From: Martin Belanger <martin.belanger@dell.com>

TP8010 introduces the Central Discovery Controller (CDC). To
differentiate between a CDC and a DDC (Direct DC), the identify
response now carries a DCTYPE (Discovery Controller Type) field.

Signed-off-by: Martin Belanger <martin.belanger@dell.com>
---
 drivers/nvme/host/core.c |  3 +++
 drivers/nvme/host/nvme.h |  2 ++
 include/linux/nvme.h     | 10 +++++++++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4fc794d9c2f4..cd34b92e8e9d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2978,6 +2978,7 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ctrl->kas = le16_to_cpu(id->kas);
 	ctrl->max_namespaces = le32_to_cpu(id->mnan);
 	ctrl->ctratt = le32_to_cpu(id->ctratt);
+	ctrl->dctype = id->dctype;
 
 	if (id->rtd3e) {
 		/* us -> s */
@@ -3335,6 +3336,7 @@ nvme_show_int_function(numa_node);
 nvme_show_int_function(queue_count);
 nvme_show_int_function(sqsize);
 nvme_show_int_function(kato);
+nvme_show_int_function(dctype);
 
 static ssize_t nvme_sysfs_delete(struct device *dev,
 				struct device_attribute *attr, const char *buf,
@@ -3533,6 +3535,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_reconnect_delay.attr,
 	&dev_attr_fast_io_fail_tmo.attr,
 	&dev_attr_kato.attr,
+	&dev_attr_dctype.attr,
 	NULL
 };
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index fe224016418e..f8b60f7346fd 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -349,6 +349,8 @@ struct nvme_ctrl {
 	unsigned long discard_page_busy;
 
 	struct nvme_fault_inject fault_inject;
+
+	enum nvme_dctype dctype;
 };
 
 enum nvme_iopolicy {
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 855dd9b3e84b..82567d493c51 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -240,6 +240,12 @@ enum nvme_ctrl_attr {
 	NVME_CTRL_ATTR_TBKAS		= (1 << 6),
 };
 
+enum nvme_dctype {
+	NVME_DCTYPE_NOT_REPORTED = 0,
+	NVME_DCTYPE_DDC = 1,
+	NVME_DCTYPE_CDC = 2,
+};
+
 struct nvme_id_ctrl {
 	__le16			vid;
 	__le16			ssvid;
@@ -320,7 +326,9 @@ struct nvme_id_ctrl {
 	__le16			icdoff;
 	__u8			ctrattr;
 	__u8			msdbd;
-	__u8			rsvd1804[244];
+	__le16			ofcs;
+	__u8			dctype;
+	__u8			rsvd1807[241];
 	struct nvme_id_power_state	psd[32];
 	__u8			vs[1024];
 };
-- 
2.34.1


