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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B907DC47089
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 02:38:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61EF2613C7
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 02:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61EF2613C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=dn4WAyBmwPMAvTgb0jodWr1jwji9Ooa2oMGLkLwFTmM=; b=dy36QrHYzX9KCW
	EWOOcF3AbgAP/k89MGkrv5ziU3wgPVQ4oVUpxCkuFDdJgYI88l8+YT2QWKHKeF+QtOzPSPuBhysxG
	72QTRHVV5d80MvWtzhhQFdVnjWWZC5AaBNWd/tQkT/brLVneaFXzB5u4XdN6d2TY4G61eVCn1MVGS
	SDd4uuYj08HRg+RBsmrkLUBS+t4XE6u9FIHQgJqbdCt8yzxfRM7/ban6gJSVtNCQzqj9vM/J7F6Pn
	oXgrtF5wB5Ct/mnEJoWL2m1ejRdHCNH8BPl0QgzuYLRFJWtGm7oDJ2MEJ2aGnXBc8vRZ9hCZb769T
	G889J+Sa6yNAcd5AefEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lm5um-001pso-MK; Thu, 27 May 2021 02:38:28 +0000
Received: from mail-bn8nam12on2073.outbound.protection.outlook.com
 ([40.107.237.73] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lm5ui-001pr2-JJ
 for linux-nvme@lists.infradead.org; Thu, 27 May 2021 02:38:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jINscIYCiiJ06Pcqthrvgjfc9Yp7p3bLxt6xc2+jjT/rqVIjIjr9grfknkoVTAfJiH4yeKUoO/9cPMIJXpq3zAEJFNwgyHr85LtZsG5JlaHZKugrKC+T1clJIPtbNVKNmdhZ3sB+Hahvho+roszTX/WBq9dWzbsiZkQA+dxmcgvkn1sRzHvuUn3xwyosrsyP2MQS37oR/LcimNdncrd8wWo/D5aGgZD4+GyZF7UPDXrKA8qRJKGOacX0JTMwz1KSZkPujxbw9C4SleeCG1WyPOyJtuaDHcFLUFlOIG8TzNf+UWBOf8d5PFOUguoZ6KVUlMkfl5HXa46yfaunRynXbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnLzfsS+p1FYS4Isy4mSUelAG+PofxdA6qCeJzrQ10A=;
 b=I+ge4Kse3g9YFOtKcj7fgYOhf76wKBDGW5gcW4e2Jrb/iPQaIl2bHBGjc7o6f9AJAZfPpxJqnTwLjWLO89mVu5daxUj83Xj93CuexZ1bfXhRXiqu8tE/1018WCO6hnMNw1C7h/yt1P8+vNxcBIpUHQmzpB/rgL00d8etZY0klz7dI69l4EXrYIRqzJAaM6xeBJJpaVPu2OhCXUZi64U3/YUbGOwaNDVJY51TbVtE/UGsYQMGVPBxdARo1S2OtogcNELHDJsgSx8nYT3hra1LBHzRsUaEwlAuPcCv4MsUb1Hob93XBCVFqzp6muVYwlVU28sd5MnPw/1C3zyN3KA9FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnLzfsS+p1FYS4Isy4mSUelAG+PofxdA6qCeJzrQ10A=;
 b=RxVw7egVtY1ng5sggoa68guVMViZ7YVDxruGxsjGbRFIGieuKxns2w3n3maq/iPQ9VLaqFJ0EtPT3oi2qM1KWuZk3yFlbvgWY8lPx3eV1EFZbcYMPsu/ctAIWQYVcqFQ3tNe/pxx/o9K0Ttv4HmzWlWWEJ5RdtmXgu2kIeo9LqA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2693.namprd12.prod.outlook.com (2603:10b6:a03:6a::33)
 by BY5PR12MB4870.namprd12.prod.outlook.com (2603:10b6:a03:1de::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Thu, 27 May
 2021 02:38:21 +0000
Received: from BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6]) by BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6%3]) with mapi id 15.20.4150.026; Thu, 27 May 2021
 02:38:21 +0000
From: Mario Limonciello <mario.limonciello@amd.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
 Mario Limonciello <mario.limonciello@amd.com>,
 Prike Liang <Prike.Liang@amd.com>,
 Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>,
 Hans de Goede <hdegoede@redhat.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] nvme: Look for StorageD3Enable on the actual acpi device as
 well as root port
Date: Wed, 26 May 2021 21:38:07 -0500
Message-Id: <20210527023807.19255-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: SN7PR04CA0085.namprd04.prod.outlook.com
 (2603:10b6:806:121::30) To BYAPR12MB2693.namprd12.prod.outlook.com
 (2603:10b6:a03:6a::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AUS-LX-MLIMONCI.amd.com (165.204.77.11) by
 SN7PR04CA0085.namprd04.prod.outlook.com (2603:10b6:806:121::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Thu, 27 May 2021 02:38:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36c9e92d-701f-4629-386c-08d920b87e1f
X-MS-TrafficTypeDiagnostic: BY5PR12MB4870:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4870B220543C72978CFD96A5E2239@BY5PR12MB4870.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qNj5B8sqUVe1SviH6jICm3CrM8nmOUF9Vk68o0mdRE7ur7JxUI0yUYN4Ubl/ex/dsFOovUZ5q/KzJkCEKGhGh3wKHoMwWOEm4zKP9aE/tn31WkrM91VcE3AOW4cE2p6vkjC7zozIhNbE94jkG3jnOVJ+h4nevQuMJEGf/I3VS5P+DEvYVARKLiT9CYkdilforz0A85vN11qPjdmRIWF1JmBGLyTKJSLp4g/eTu3ayufD9zAVQ/sbuBA/IzaOzjohHdMbHA0TJ6qSOeC/xzVpPYuO2RaI1PVE5tWjVU7K8XkZNei+nS4FRLGN9fIxL1cDt1knr1VDs2DW83sDBdN7+AqjYNA3wAnudk62k0SeS25asdzFmUoQezkC37d421qlHjk/SkXEfqP11qOyKopTeaZKnjVJ79OOmOjRxO7wYOj8FhcZXo7JlaJ+oF2lG5CWQbXM77ik3OT+nSvPoGhGaeUh5WNySOa+5t0j+OQgH0GTYuXZcdk9iYClz03UV0m7kzg/XaNmL6d7quN3KYl7qs1SU7NHV86kdXhqOfqPv0eR5EHV5dElE9DKwSzvZ7n3CWTlWUqGW9lNTVloAOISVWIsGa3Biuop0p5Nkju5LYhuoRf6MUFYpf1nI6LWdp/tTsK6wMpmy/FwYf6rUFIz04Ijw4V/Wfy9LPJISVa3CXBaEqLlP0i+m4Y2N2prQvvjXlw7L0tVm3zLv/grBYll3LGcGcBKV7Q1yg6Id11pBmOn1PGLJkxls2oIbaG1vf38mWybE1hoIG8kojHTzk6mZpUr4jhhdPfn2ClOsasFiRo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2693.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(186003)(6486002)(86362001)(956004)(2616005)(16526019)(478600001)(36756003)(966005)(66556008)(83380400001)(66946007)(66476007)(44832011)(38350700002)(38100700002)(7696005)(8676002)(52116002)(54906003)(2906002)(6666004)(110136005)(316002)(1076003)(26005)(5660300002)(8936002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?N3fsg400qO6rb2jzs8lUTxTQY344PqFlizFK9PcXTl1gR7QbSObdMTG1hcLu?=
 =?us-ascii?Q?Q0RZxWLC7Y5a8EV/qgcODah6hW0r/dxsptNRhdmN7LOLS06nOM7fJ+9BrknA?=
 =?us-ascii?Q?ux6/ypvNbIt2iQjDz6VOeHUOnNdD/cdGXDbT0BePPl6DhcIGIwdGy1AQd2NU?=
 =?us-ascii?Q?WzA09qLGhVagaTpOx5cNEwvHCIdnWlBoXAGOGP5wENzeE63zSzXVyZWfHF1q?=
 =?us-ascii?Q?LH323nLcL5k+9nqe9NfW+HJ5TaVfmPVwMVaSUhicfha5jzbBTHMkomlEGUfk?=
 =?us-ascii?Q?Gc3K+FP+XkrRyrPEVtp6EoRESGa0t+pIhwteHIw0QQRZeAw+0bcVQyfsNiYr?=
 =?us-ascii?Q?S4teLdNdr6ldF69Y7INQSZc2dso/QMIu5o0luU4t+9yEBYiYesoKndWkOO2n?=
 =?us-ascii?Q?RRu4eT/AvrEh+aSjwB4FBZbhKgjZqTMeawLEtb/5f69ynYfNGUJIq3a+paMG?=
 =?us-ascii?Q?/sfOKk+mbp/xZlbfZ5iuwBOXdqFErCBik7PcHH2C6cGcxRA42J9IB9jWNu/N?=
 =?us-ascii?Q?qX/74oNMy+d+IZP4NzhMgYZeyrYxeYSzyifIhtQXKRZ6c8Frq+1btakOQo0L?=
 =?us-ascii?Q?b7ysedv1i2Dw7Kcl1Gdln5jAQXrwTJx25591TEfNkLe/zDRnX0tIX33hVB8V?=
 =?us-ascii?Q?RT6D7V/oHY1Ug5W1eo+lSDbhaMwpsebeSlepdNTJNKDo/ASZcnVl+2dPmGH5?=
 =?us-ascii?Q?86KrCF7IoyaBzA5r37Tu/E4f9e9lK8ZSvaIes6csJh3QRS9FgHFNMV0SCFFr?=
 =?us-ascii?Q?ZMsHYoKPnYsF8auh+4CvHkdxnr/znV83KN3PrtvZUxixEgm2uY7C7E/7jhU2?=
 =?us-ascii?Q?s4dZlZipsGq8/Mdegv0bisMGX9CjGCQ98mYqcsUQrdMVqfAtI31Z1oew1gHZ?=
 =?us-ascii?Q?VyyTeRHzRoxuO+vaui/9QXH0ibOfxrJ45hUIxIgQ2ERR97SlQ/KjvZi5emJ1?=
 =?us-ascii?Q?dRualpXYMSxDBXGaDBMbvSfiGVEkDok5w9G0tn2P6Iadb352LwdjDXyRmo0c?=
 =?us-ascii?Q?GcSB6TBPfIum6SIhAh3u+pawKF++jxLUPi7TaQpEE7vOfXJA05DGmW7iTkwy?=
 =?us-ascii?Q?994dYv9Vdvr8eMc3umgTzGGICjhEX4Um/2D2DQlTYU+tMrBmV23H79fK0AtN?=
 =?us-ascii?Q?APtaE+lh7S3s4dVT/Zmo/hCHJKaCSqEb1BHwO4OUKQl9fGIgYS977TCDQr+/?=
 =?us-ascii?Q?r8DrwfUoVVJ2RzCcwX8VF5JMp4AOkP3GdjI7R+++BqumyLC5xRpOtt4TgtUp?=
 =?us-ascii?Q?HjB1LcivXeQaQ/ZktHXYS/DjyHwSOzPaoJuRnpx42/eJ9Xg0+6JbYupfPDOd?=
 =?us-ascii?Q?In4Upe+ce0zgQmIu649K+b7x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c9e92d-701f-4629-386c-08d920b87e1f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2693.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 02:38:21.2681 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VFRaVp+zGj+hSFutfxvU64R/MYb5+6DKMtKjAgf4d0oIkqAp17TlEsFX2c3fs0N1KfLlLlAtfJFvfR9aotK2wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4870
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210526_193824_969835_8B675B59 
X-CRM114-Status: GOOD (  16.16  )
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

The documentation around the StorageD3Enable property wasn't prescriptive
on which device in the hierarchy should contain it.

The existing logic was intended for usage on Intel-based systems where the
root port contained the StorageD3Enable property.

On AMD systems the StorageD3Enable property is directly on the device
itself.

Link: https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro
Suggested-by: Prike Liang <Prike.Liang@amd.com>
CC: Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
CC: Alexander Deucher <Alexander.Deucher@amd.com>
CC: Hans de Goede <hdegoede@redhat.com>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/nvme/host/pci.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a29b170701fc..4b7dd0cecd01 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2842,6 +2842,19 @@ static bool nvme_acpi_storage_d3(struct pci_dev *dev)
 	 * must use D3 to support deep platform power savings during
 	 * suspend-to-idle.
 	 */
+
+	/* First check the device itself for this property */
+	adev = ACPI_COMPANION(&dev->dev);
+	if (adev) {
+		fwnode_property_read_u8(acpi_fwnode_handle(adev), "StorageD3Enable", &val);
+		if (val == 1)
+			return true;
+	}
+
+	/*
+	 * For Intel systems the property is defined in the PXSX device for South
+	 * complex ports and in the PEGP device for North complex ports.
+	 */
 	root = pcie_find_root_port(dev);
 	if (!root)
 		return false;
@@ -2850,10 +2863,6 @@ static bool nvme_acpi_storage_d3(struct pci_dev *dev)
 	if (!adev)
 		return false;
 
-	/*
-	 * The property is defined in the PXSX device for South complex ports
-	 * and in the PEGP device for North complex ports.
-	 */
 	status = acpi_get_handle(adev->handle, "PXSX", &handle);
 	if (ACPI_FAILURE(status)) {
 		status = acpi_get_handle(adev->handle, "PEGP", &handle);
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
