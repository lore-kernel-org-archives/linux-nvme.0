Return-Path: <SRS0=IcOG=JL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2552BC433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Apr 2021 02:20:11 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52CAB610E8
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Apr 2021 02:20:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52CAB610E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nFO8g5zmsj7O2DFJB2Jzglpn7w33YyfszSRuEnjPRtE=; b=AKoE/2CcaPofANtUycftbKSBZ
	0VSQdsAbVJcOIFFPT9BnNX3mss7/OLoEjxFOsHMq9lq1Lpvq6rbaaey+B+gJguUpXJRqAsoF+T/yN
	5t1gRsT7CygoF47HBbCzqxa1dy/7hgFIclXAg8EghPy1sRXYwmvJYXfurK9I3rd1cjaWOqS4guaZ9
	egxDrAT0jehk9OASMFhIbCSBauAp7dFNE1Ro7eWAfB3J2qaCY1yEvSNHbKCqLxLHBUFYpDF8zrCD2
	QAR5ZTFkKWFwJOd6p4uPEjbvpvk8t7ko6xulhG+e7rYc3qrKAYOvyCvCczoI2DHwrIWd4tUl9MSwE
	bv2qwXWAA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lWV8A-00B9VF-1k; Wed, 14 Apr 2021 02:19:50 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWV7t-00B9S6-9P
 for linux-nvme@desiato.infradead.org; Wed, 14 Apr 2021 02:19:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:Content-Type:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=eDJLbHPz4FknAPNEquUiwyE7zt+v0K60WCCqM3pC8As=; b=mj+449TbNsbaq0LlnlyERNDZjH
 8HVvO88u0X0zr+HwkSDDNNlIBVzbDvXzaJnCR0GaP7gOCrrfBZ+MAiAvQ9GnyfthRR8Idlxtq6QEe
 jziG5zW7LTGV1GYFj+p4hA9+pCrwF/6T0PjmOoPihDLtWGmVOmPjB4vVvBg4Q1gvKb0B9nypPM11y
 OsqRQTP4b6zwc6FLkcGmASsPxw8mEY6/Bc3nyEwsA28y6wUtyG4Swi5DmCX7tQwMakSooKAjnkmiv
 yRtlz/oEm7/c8BwEFb9YtZXsQhdrMCO9vprDH5jd8vVde0TVhQ/jy0jTuH0776m6uOHic3AvnPbXU
 2VQJbH4g==;
Received: from mail-mw2nam12on2052.outbound.protection.outlook.com
 ([40.107.244.52] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWV7q-007RFe-Ph
 for linux-nvme@lists.infradead.org; Wed, 14 Apr 2021 02:19:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3EkyBX6mYB2BY9Y96koQilS6zcJzWw0KOtNwGJvqhJQQHxSKCjCwgS8G1Su57cbvuDDAqyB8QnTbr9u5hFHMGkF2X3hvznFy3L5wsd/fnNI7aZpXZHjjiahvKSc5GAHMc3GzNd4gRXISh9n/wKrM6T3M21U/H/rRvxOBWgSX9lotJlhK+yRGS7QqX9EmNJ3GcCou54RMJlYTRyW3VO4yKyG29O/qkHimB0xwcn55mg6SOVM7zaj+M52aD5k/sKCrtKnYcngaTO9uFuKLw08f3TYKQGzi4AMhGy/oRyI3/EdH3s6u2o2/DOZYXENH0mkY0BQimgorE6Cx1FsMIYRFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDJLbHPz4FknAPNEquUiwyE7zt+v0K60WCCqM3pC8As=;
 b=k49HGxqvpUAcwLvdeArrgPV1AxSK/Cne3/C9CqarioAga3/VTObf/ocCLwcX3+9277Ubl0CtkNkdVhPsydtHt14E62oaEckjrgJ3G3lscWFrxxKjSQ3wEBtva9o/RFT13hlj4cfnnTalM+Fh7zCdC3fW1u0fEYN0y7FEYZZlsSOkc7POAItE84W9sDlUlRfnXa8AWZnqL19GVn3XPxkwk1uE3r3dAW89LRLVdd0VG9gyMb8djaL4qcjQW8on3aYha0wls/zVnKz6a2JMvFsXuRi0m0iz9kICXmszZist5wkpTW/B8M+zJmvJh7b6a16HXhgSdLiLzAwDNr9tu4cv6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDJLbHPz4FknAPNEquUiwyE7zt+v0K60WCCqM3pC8As=;
 b=AB91yUIqRhoenftzFguO2PV11EcZ4m0tYwkxbRKWqFRrTvr2tzAuOakM3jx72kKCcl6cFLBTj45hTwlY52+qDgdua6IAGQG+0wJBKIlDG+KHGN9dR644Iok3dHK4FFUbA10sqiDC5FcAAtE+adYVwrFhYAafBZS/O3P+Z0fSxfE=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=amd.com;
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BYAPR12MB2600.namprd12.prod.outlook.com (2603:10b6:a03:69::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Wed, 14 Apr
 2021 02:19:27 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::5870:fcd6:b13a:c49c]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::5870:fcd6:b13a:c49c%5]) with mapi id 15.20.4020.022; Wed, 14 Apr 2021
 02:19:27 +0000
From: Prike Liang <Prike.Liang@amd.com>
To: linux-nvme@lists.infradead.org, kbusch@kernel.org,
 Chaitanya.Kulkarni@wdc.com, gregkh@linuxfoundation.org, hch@infradead.org
Cc: stable@vger.kernel.org, Shyam-sundar.S-k@amd.com,
 Alexander.Deucher@amd.com, Prike Liang <Prike.Liang@amd.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 2/2] nvme-pci: add AMD PCIe quirk for suspend/resume
Date: Wed, 14 Apr 2021 10:18:14 +0800
Message-Id: <1618366694-14092-2-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1618366694-14092-1-git-send-email-Prike.Liang@amd.com>
References: <1618366694-14092-1-git-send-email-Prike.Liang@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR03CA0053.apcprd03.prod.outlook.com
 (2603:1096:202:17::23) To BYAPR12MB3238.namprd12.prod.outlook.com
 (2603:10b6:a03:13b::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from prike.amd.com (180.167.199.189) by
 HK2PR03CA0053.apcprd03.prod.outlook.com (2603:1096:202:17::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.4042.6 via Frontend Transport; Wed, 14 Apr 2021 02:19:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c921e9b-ea81-480b-ee9d-08d8feebba36
X-MS-TrafficTypeDiagnostic: BYAPR12MB2600:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2600023F3F481C41A31C1364FB4E9@BYAPR12MB2600.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1N70bft35xyt5NpjDTmlK56XeyisPsFbStj9XnYTbuXTR+N53LKlzd+MIoGFAtcMQWicuoahEt7KXUXya98rClKkzyHSaKl75aPFuRybudDsc7ZXSRlz+eLXYhJqQGaKPZiswzZGSS7pf/j5dKDjsIvTGdiGXAO+XnfE66l9YGYtEII/7SBMVy0R/nwABtK749abERqLeca0x+E6tXoViwasCMazTSso9+WMzkGHisMUYU8rjDI2uvvmU3LHGI6WCvwYzgXQ2DWZLoCs9FJSWQM2Jp8GynNqHHL2Qea79BspkHv/4Ty5V0IYsgLlSVvZmDK7ZWFSuHnNE8y1znR1GyEpIEILwfvxiCVItCNMi2bWYLppNPWnBieaYG4rTtyWlnHmiCR8l7Qc8S+Dl2BCr3HovZc2alqf38mbF1ONhuWgwqO7TFBKhhEXXfc+U3OyT/DnGw+sbBqjkb1EvBhp/MctQwZsQkhe5rxRK72v+SnBlty5GnnX0X5BNAUyzln6JkjznOyJFEVvqd4gt3rJRTRMDJyztEHddReWRAgLnV8VY/arv/qJpSUh6ACLuN8Ey9n9j5BUt5U0MbkQuOp2POWgFBZQKWbf3efqCqD1Kh7QSMtq8wxqAzaLSQLzs+/Y3rip81fvMPnnBUah6aYHk0iQrGQvcmINvisJf1iCPfg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(4326008)(6486002)(54906003)(5660300002)(38100700002)(26005)(83380400001)(36756003)(52116002)(186003)(66946007)(2906002)(16526019)(38350700002)(86362001)(478600001)(66556008)(8676002)(15650500001)(7696005)(6666004)(956004)(316002)(8936002)(66476007)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qsyWw3x5Tx2jmk2I9SY6+k99pAyNHTw+kQ53lApAKI0RRWg7XMaL3AxeP1kM?=
 =?us-ascii?Q?XlQTy2tuAFmlxoarxYaYpnZmcd7xE/ZCeBz26ZvutwmzcSJrpXX1RVi9bE6E?=
 =?us-ascii?Q?JJqudh2TSQS/BSMxRBZvbt1VHgmjcFqb9yjl8kA0XfM14TMHFo0QbSwNtcom?=
 =?us-ascii?Q?igoX2LV5gwimjc1yngwfwdtWMRZbK/GR6KnSBr2GJo4yWNmks+6YuQu5ymqd?=
 =?us-ascii?Q?iXXfzHVmKeSPhhrJeGvD2G1pTRqyVfz4FTQT+4LfHrLmIq93bCv1N3CM9pK8?=
 =?us-ascii?Q?wBM2IXHy9Mc8/D2PZGFK4s3A33pUkeAqm6A564xx9yq4Vu2VVir7hry5vrQg?=
 =?us-ascii?Q?Gt3Msm15lVZagoSnQR/IeYf29QZmRym3ku2Oy60pPVnmkRQvUkaEmwyY3Jo6?=
 =?us-ascii?Q?Bic+CBlPnAuCgcyBQl0QZgg2uBEeYlJEfQAzIUMK1VAFvwLWOq+NCbkV6C1Z?=
 =?us-ascii?Q?ZZ49Aa8PCPVCuxzsSkowrwes4C301bwZ/jNPhgAhGcVip78XAJ60Z5TBj1wS?=
 =?us-ascii?Q?pGtVF4WOJ2LX4BzWV4/1Nsjh9YJ1iHFXc7uMcTAjYSCwZz7tnmYDcBRn100k?=
 =?us-ascii?Q?mh+m7NRKOIg7yinzPIQLeVMpArYCPCBlIwtsL0dtf3wa1IwgWNwMjbOPVl1R?=
 =?us-ascii?Q?h+olno2vMj7eUPkjq6RMiCbjgPqflcrhyVkvq9vaNgAVT5s2WEGiCPhao0zY?=
 =?us-ascii?Q?4/c5WOrsdhREQ9z14aE/lmBpXppyC/fh1gi1zcWZvC2/vzJfEZJ2QNkNoVWg?=
 =?us-ascii?Q?a7iuj6I7XUllBwEoXSe237n79PYG2nyv/g1Tum3H50ofL/AZnLfNo7GkC9sN?=
 =?us-ascii?Q?s9pQ3kj82RprBGsxU6ylRDL2IJ3gzcGf3D6XGbfRnqFo0fHwW2y2NPogtjWC?=
 =?us-ascii?Q?NjDt15ICXlWSNsLeMs8NuwWJdsjsPXCm62w33jp5was9a1zFAoX7prhBLXeL?=
 =?us-ascii?Q?+H9NBSmM0fXMy12LgS4LNZIQK6FFeADGIQcCCX1RNSYGYuNlh0PSUhvqvXYE?=
 =?us-ascii?Q?uH6NqGokrvOIFCaiQRcxu6lHsU5O2tGSHHsXufv1G93L6Na+CvvPs1ax9/SI?=
 =?us-ascii?Q?zSUwO6KK8uWB4eRtzmkimceiUoPrspLfI/XVnis6Uv0u/mdHiOxKM0tEeLsM?=
 =?us-ascii?Q?sh0fLpqFAqlzZpbvbpu2Qn86Hs3fKeVoJ00i9cnBoZk2hyebwSD6Th8O8FRo?=
 =?us-ascii?Q?+ZTYTordpiig7hYE7/RYAtmAU3yT8WeAwJ3UoSGmAXf5Khg5tSecRi0/wJKR?=
 =?us-ascii?Q?RX+rCodHx8wBPaBjq8EgTzq+9OfgQQXZ6bs2YHRaJ4e9TbaIttNCyc+9IuVE?=
 =?us-ascii?Q?iBFXdY3/Gl0APlX5MqzcWcYg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c921e9b-ea81-480b-ee9d-08d8feebba36
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 02:19:27.0585 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZYmRB8YQRGCHEZ89kLxiWmq4dVVesyQ985gpLr3c2Gqq26sRXHVmTRpVaMMmdTXD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2600
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210413_191930_856415_09983772 
X-CRM114-Status: GOOD (  11.56  )
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

The NVME device pluged in some AMD PCIE root port will resume timeout
from s2idle which caused by NVME power CFG lost in the SMU FW restore.
This issue can be workaround by using PCIe power set with simple
suspend/resume process path instead of APST. In the onwards ASIC will
try do the NVME shutdown save and restore in the BIOS and still need
PCIe power setting to resume from RTD3 for s2idle.

Update the nvme_acpi_storage_d3() _with previously added quirk.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
[ck: split patches for nvme and pcie]
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: <stable@vger.kernel.org> # 5.11+
---
 drivers/nvme/host/pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6bad4d4..dd46d9e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2832,6 +2832,7 @@ static bool nvme_acpi_storage_d3(struct pci_dev *dev)
 {
 	struct acpi_device *adev;
 	struct pci_dev *root;
+	struct pci_dev *rdev;
 	acpi_handle handle;
 	acpi_status status;
 	u8 val;
@@ -2845,6 +2846,10 @@ static bool nvme_acpi_storage_d3(struct pci_dev *dev)
 	if (!root)
 		return false;
 
+	rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
+	if (rdev->dev_flags & PCI_DEV_FLAGS_AMD_NVME_SIMPLE_SUSPEND)
+		return NVME_QUIRK_SIMPLE_SUSPEND;
+
 	adev = ACPI_COMPANION(&root->dev);
 	if (!adev)
 		return false;
-- 
2.7.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
