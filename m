Return-Path: <SRS0=/NUg=KW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22C0C4707F
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 14:28:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AFB5611CD
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 14:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AFB5611CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=OzRPTN69iTkNmPr1Zh/6RRVSLqURBnsEpDVuQaykD08=; b=QIN+RB84bt2Yxc
	JUoXWodw26DNViX+zq8nhTumuh8DcPUrH3nbWLQG9LJNMxiVzqfkJZ8ZhCcLyk4JEKu59aKfoFfSf
	pBjvVM4j8pxGm6CZ9HvBeSQmfAyvgr345NOPoALcShlHLyDkYrBVV59ek79Mkj4v/joCyceP83TeC
	BrxwA8+oXILWYiyHI3oinR+BQxPecRq2EspwKpYrK1720CLResQ7kVtAea7SeSiA5W2Lqic4juh53
	N2wIRIrNSUWkwse1rvTEItnu+OM1WQ18Qg8BVZFh3svNXoQeI20S/TrlsD5GnHMvbZK4bOsDk0Uv/
	ILl+ldTf1GkL8hovFeEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lmGzG-006mvn-FW; Thu, 27 May 2021 14:27:51 +0000
Received: from mail-bn8nam12on2083.outbound.protection.outlook.com
 ([40.107.237.83] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmGYQ-006W0I-O7
 for linux-nvme@lists.infradead.org; Thu, 27 May 2021 14:00:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXgfIhiac7199rRAjj9mn4HW9AF+8rqR60AaUv8JQXuc8/pt2/Qgnk5j7NEGXHdMkWi5Whlk2lIx2U6GRwHlzZUkN8wRKGY8LOa0RgS+L2fyLjvntdz5GvO+xhZF6cchE2HXkDUafPkv9eae8momznOdyTKoCcOgtJc+c0RXid1O68Bb0hv6z4joFEUNJUCaCXQRdRaU25sp0phUrCAtcmOOZy8V3e18bQRUgQhnqGbIBy9XVROkBfw8gxxxOpcb8pZEynlfsk0xr0sE0G90QCdQW5ygMnz7doYYe+H/XFVGzswtLnAl7ptXEjFP4clu49z1GySItTqL9gzVJQs+ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0e0TrX8f5iKlX9jlOmJzMfl4cMukZCi+TE46V48ESzw=;
 b=nCOQsDkfEbPbwDZ1ufZ9nla86PgmczWGtv0fCj04Q8iCw+rTSRElRa7Kdh9iCOkTEyXYs052rlEdcByDaNKgDrqI0K43DRX2x955kvgM4i1cQHw2St2E8s8QATVXzgBpO6lItQuPYiIt9DB8P1bFXL9CKZaBTzsprAUyRb6AGXh+qA+ohclymuRAQp8ibV7ilXZVcPfuq8Pa6tRm8dotuyy3SGArbuleNXhEO7INqvJrvgkLmLb4gu4pyZZDes46RX8KZ8WKP+hCpI7/V0q8WtzMQgCmAo/TybJf9w5KNjbLV1+noNNxE/wK2HO3OdR8k3bAEHk6nvdYyTpm+zy1vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0e0TrX8f5iKlX9jlOmJzMfl4cMukZCi+TE46V48ESzw=;
 b=BBKUdRfpDsZ6XhZTe64wFRhNW7Ss3zCnbUKwNOu+rx/q+APoQl+e43vVTsn5nSgZEqZHkew/l6juIBxy0z3/1D0v8mFUf81d3r142G90DUxQyVYvUZMB/5isGsT0lsqU5XhtKe2vkSbO5iAL/JXKDbsZAuYtPxlEAttDDP0+/Us=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2693.namprd12.prod.outlook.com (2603:10b6:a03:6a::33)
 by BY5PR12MB4065.namprd12.prod.outlook.com (2603:10b6:a03:202::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Thu, 27 May
 2021 14:00:00 +0000
Received: from BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6]) by BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6%3]) with mapi id 15.20.4150.026; Thu, 27 May 2021
 14:00:00 +0000
From: Mario Limonciello <mario.limonciello@amd.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
 Mario Limonciello <mario.limonciello@amd.com>,
 Prike Liang <Prike.Liang@amd.com>, rrangel@chromium.org,
 david.e.box@linux.intel.com, Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>
Subject: [PATCH v2] nvme: Look for StorageD3Enable on companion ACPI device
 instead
Date: Thu, 27 May 2021 08:59:41 -0500
Message-Id: <20210527135941.7634-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [76.251.167.31]
X-ClientProxiedBy: SN2PR01CA0062.prod.exchangelabs.com (2603:10b6:800::30) To
 BYAPR12MB2693.namprd12.prod.outlook.com
 (2603:10b6:a03:6a::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AUS-LX-MLIMONCI.amd.com (76.251.167.31) by
 SN2PR01CA0062.prod.exchangelabs.com (2603:10b6:800::30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Thu, 27 May 2021 13:59:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1663ac1-19dd-4643-2896-08d92117b7e3
X-MS-TrafficTypeDiagnostic: BY5PR12MB4065:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB406502AE621A032B64B142FDE2239@BY5PR12MB4065.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bfdCPHpxDaNdZ7AOfwCsEiLYgsyyovoBDnwca1prrOHLC8J6+eCnCDYOvlUAls0IlXRI1AWQT2QB/7H75GJnNRf0+PcfQASULUIDlhR4z21A0SV1J1Hx8Ka9NjlTR+YYHqNWm9bigwbweRRzlOsf/QPsr52o+Hbdm/O3fzb2PJuWtM1Gi8wJm4FyjLkmvezDsF8gQG4VIe0Ub3/E5P4rI1Nxh3Uk9SSpfSs5z0QC5x+VAunrVDZ4wLdk65/1Vb2Fn+PQSAkrF0iMH2k4YQnAq2fzngj6UWF1HF1F6GVBZuUPVPWEEKg4RLU19SArw0DKizIITTAo9bzGWAQws1/+QoHVLgqI95lkHdoMUunzCIjnVel/gzkyZDUscbf8Iq+cRftlnNKNkmfsCHaHtxR2zInND9ln0xv1dI40bfO8KghWTukrhXb4wBoxLc009vfemXg3TI2PR9TKaqgcx0wX1KuFlWlH86kFdk8Zc83ziZNBtHla0c+nawdJ6ZkQXUwDndybq+nUsduRQhTmE1kQO1UwmypHaYL7aK+oOKfQZ/aPRKaRJK/+NxLsBe4Blb958gdsW5j5AdGVeCNpBBEcC8Tl93vGiNdjTZErlOqnEycCknbcDEvY6YpliYZRXYd2pgCncaH5xwnE4a3quchyT/TIimyFyyy+pYdWOBX+ndVFt7bEkk8mUaGf7m3uMlIMbW4SqOI6BjL6D10NwkcWIaufGY0r9TXCRETPWC/EPdenWKmUSl9FF/I8psYp6yqKH7gmv6I/P9iUK+ODsICJbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2693.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(26005)(966005)(7696005)(52116002)(478600001)(6486002)(86362001)(6666004)(186003)(16526019)(2906002)(36756003)(83380400001)(54906003)(110136005)(316002)(4326008)(44832011)(2616005)(8676002)(956004)(8936002)(5660300002)(66946007)(38350700002)(1076003)(38100700002)(66476007)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?TpubD+w5vE8e7e8TkWWyGm7ZIy5asWybfHVraJCxRrvvg570O2QDP5VisqvZ?=
 =?us-ascii?Q?fGMNZjB/FKDHBNsEiBa62qjfpKf7DoOLkorw+0KTyavocfZhe7zCBRJK1HNT?=
 =?us-ascii?Q?HLA4w9Au6g6FpxtbB6BI4ZyWW5C9yXQWUFbIhGNHmgYctuNmrLjeK5v93OJI?=
 =?us-ascii?Q?4a/XEzjE52Xo0NrI24Uobzc7KSbtT3KCTr0G6YKT5UwL1JoZS0J0gCEMkA68?=
 =?us-ascii?Q?Pfm4+gvxSefQpKQkPaovAMUBDxZ+yeh7Flh8jwIFS1rXGtuXY3ExU/XLzCRQ?=
 =?us-ascii?Q?3rWlFwI6pg0q+62rd25LgopEpk3vFkB/ipyFuywr8J263vzaF5VftJwEi9dQ?=
 =?us-ascii?Q?Bqs8+ebFpFgbk/jRXlKXe4IOK27/wMs2Z3mDLR3V94PKTJ33bM/26j+0X8hw?=
 =?us-ascii?Q?UoF0THVO+dhExId20Wjm5KnZSJVrdYfNDze0uUVdViz+nMuB0ATzcuJ2t2dG?=
 =?us-ascii?Q?FtzqwedPHtW4nm081dTm19p96lJ9cZAdWgQOfpDb+1vscOI2WFAkbE4BYoOT?=
 =?us-ascii?Q?BASEc5pswx8t02V1yqVMRyCyQ2gUGjaVGyxVvj41XZqZsXgqESs/lM2A8Hpm?=
 =?us-ascii?Q?4QJ+Bn8G4XjUWPKhswepvzyTVkf48fsdF2WgccLNOmHt4gSXlGfFDwmifp11?=
 =?us-ascii?Q?3BdmEzOtrooPhFhDIYpw/gZtpyuBVmVwZEan6sOIjwucMltPgiYjbKmw2hz+?=
 =?us-ascii?Q?EiPGk+3N7m3W6UtdZME4izU1W+CL869Q3gz/4f10FCN01JFXgO+OapAM5i+r?=
 =?us-ascii?Q?OBxmY2Um63HKYGwr4x4C65Et0xZxTy5G0Fj9ir5kk4bYFNdDObaP+3eJhK6d?=
 =?us-ascii?Q?cnV+XlZfDON0JNIpq0XPS59mR4NGBNmAtgCA/pUNQ1tMYAW8+Ma/tAVoo5f1?=
 =?us-ascii?Q?yIoxiAf9yyw9aydhSc5EeHpHuslac13IaJ16b5nnmkWS39KlHbDe6fGZ3o/n?=
 =?us-ascii?Q?+pT6EKi32LWCmtJ8K4X+CxNMO9bu1O0i65ZmCcTa6/Z8X7I377HdsWfPS4wb?=
 =?us-ascii?Q?cwr1/ghQAqkcNbP9ROrH4g3GjUecnPdKsemewIQHjODAV8GDA6DQ3yUwUPIP?=
 =?us-ascii?Q?H5scG4JdOp48zidTi2h1YZpplv4LaNsXxEGndoGP4QczkZXFug/4ko4IcrhG?=
 =?us-ascii?Q?jAQxlsS+sAbOoaNe35CgmV4P5af9bsa8y6CDi6dgL8xq5LdE3w6RC6x0iYzs?=
 =?us-ascii?Q?pSKW5LzkZfDg0zR/5zWX+2+R8x6UxJM4IWicZBD7Tl/I322lpDSL9UbqIXK+?=
 =?us-ascii?Q?hO3ZA2xDvRUtJpyyU8YeVSv7WzJNl1R98NjwJUASN8Z1rpFVhZ1WqFs+SM36?=
 =?us-ascii?Q?ddnr96rXxJgIGNh2FXCwOoTA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1663ac1-19dd-4643-2896-08d92117b7e3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2693.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 14:00:00.4716 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cSmJJ3pSKPCebocAxganFNys58rAdwrBlKxOHG1vjX20H3asymyGpE7fDyKM9Fa37z0QvIsEEImK4QdUbCIzkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4065
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210527_070006_894658_7B1B444C 
X-CRM114-Status: GOOD (  14.51  )
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

The documentation around the StorageD3Enable property hints that it
should be made on the PCI device.  This is where AMD systems set
the property and it's required for S0i3 support.

So rather than look for nodes of the root port only present on Intel
systems, switch to the companion ACPI device for all systems.
David Box from Intel indicated this should work on Intel as well.

Link: https://lore.kernel.org/linux-nvme/YK6gmAWqaRmvpJXb@google.com/T/#m900552229fa455867ee29c33b854845fce80ba70
Link: https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro
Suggested-by: Prike Liang <Prike.Liang@amd.com>
CC: rrangel@chromium.org
CC: david.e.box@linux.intel.com
CC: Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
CC: Alexander Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/nvme/host/pci.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

Changes from v1 to v2:
 * Drop the old PXSX/PEGP logic instead of supplement to it
 * Add references to other discussions on this topic

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a29b170701fc..d4eef8caa4cc 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2832,9 +2832,6 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 static bool nvme_acpi_storage_d3(struct pci_dev *dev)
 {
 	struct acpi_device *adev;
-	struct pci_dev *root;
-	acpi_handle handle;
-	acpi_status status;
 	u8 val;
 
 	/*
@@ -2842,28 +2839,10 @@ static bool nvme_acpi_storage_d3(struct pci_dev *dev)
 	 * must use D3 to support deep platform power savings during
 	 * suspend-to-idle.
 	 */
-	root = pcie_find_root_port(dev);
-	if (!root)
-		return false;
 
-	adev = ACPI_COMPANION(&root->dev);
+	adev = ACPI_COMPANION(&dev->dev);
 	if (!adev)
 		return false;
-
-	/*
-	 * The property is defined in the PXSX device for South complex ports
-	 * and in the PEGP device for North complex ports.
-	 */
-	status = acpi_get_handle(adev->handle, "PXSX", &handle);
-	if (ACPI_FAILURE(status)) {
-		status = acpi_get_handle(adev->handle, "PEGP", &handle);
-		if (ACPI_FAILURE(status))
-			return false;
-	}
-
-	if (acpi_bus_get_device(handle, &adev))
-		return false;
-
 	if (fwnode_property_read_u8(acpi_fwnode_handle(adev), "StorageD3Enable",
 			&val))
 		return false;
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
