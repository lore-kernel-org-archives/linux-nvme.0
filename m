Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5022C433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Oct 2022 08:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpqODx8a3PsndcMwJK2Hg/wSakdBFskh21+hmURKro=; b=vrFD01/eKoRCcrbJrwtd3lwbDV
	2Z7Mjs9cdyUWKi+z+PHUK0/cp2/NpSD1C3P81leT14iHesRDKwBOMFt6LuxEEc7099z39GKBilH7P
	s/UWcDWu+PR+d0vI/W657twonPuMzFr1ZktKG4de0xkb0FIkfEExibqkTwKyjMjPyNvQKdK5BkEOn
	YhzvLha0forSNipGg93HdK1vyJVxuAZE78jeB4hvJZaNbrQk4MqEh1jMOKXZzbwFadIvHRo+aCtFq
	zhKB0Smg81olkLZVeZyNDeAx4eKz9KNE6grCj/Nnmz7Gu/DgS5drrTEWbOeKt1Pv6h9IVX1b83oEQ
	b2WDMAWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ojG79-00E6If-JC; Fri, 14 Oct 2022 08:32:19 +0000
Received: from mail-psaapc01olkn2063.outbound.protection.outlook.com ([40.92.52.63] helo=APC01-PSA-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ojG76-00E6Ga-Qw
	for linux-nvme@lists.infradead.org; Fri, 14 Oct 2022 08:32:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmznMz0R5qYoAHUbZIEbCFBM2nmB2r/VQJToUEMarAa68KH+M65pDi0uuZagJeU6XEIydaQK7tDiWNd9YmpBi93k6fQgzm+gNEpjZcALo2eNmPorQJQJNsD+7q3Uu4qhSm2nkGrRz6wVH2qTW5I4FttSrZqGrRkB2+s/xbLM1YbnnNEzAeeXfe+HpsUV7IL+BapazDE+/pRdv1YHWCPy4bzjjx356gRjHoDA27qE73RvMJxa8tvtA4cpAV8u44TpYl/2RomuKFG8MWJLrwrHKTL6J3dZArlMEHybNZQcnGK/OLzqHgto1y1IQ0Ic2m/KC/KN+pyYHMk7aroEwqibQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWpqODx8a3PsndcMwJK2Hg/wSakdBFskh21+hmURKro=;
 b=BDAFN31VmF45aQDQnmZZkGfzG6e4d1uxSKiZTTIEQCbhDYNSfHxAz/6JC9qSOASZU2ggruEWxpfywHrSt8hJ+GEhTr/HR3Ezgoeq4GdehVqz4TAeOPgEzCII4OLulgsPbRnGsVuoHrpS9fs2r8VlZzaHytNayNRFhQx1iZOLDXIvgPKmDz/MGq9uFxoa+y7R3fzc6jb088tI14Q139afU+cB50jG33kEmvmjI+2x2ZGru79Y/9wGQczHxgAqJ9ICk+RF7P2Zp5GdPQHdXvpwDq4Zv3tbR3sWGo3xFRNX2GNllHCmG45yr4r0F4G9KsyWXjocmpC75I7QTVS3dGE07Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWpqODx8a3PsndcMwJK2Hg/wSakdBFskh21+hmURKro=;
 b=YjRLGxXxgoiy4naP/0KgpiVqHJIRAoY5tP7YB15G6xh+Yq6kczYZK3lKYtacDD3SbbYuBpnXFoD0EjxYsyn4/u5lOYB8cQHHqNwhj4z3xqe9ShJJpW+MaK7l8kmP2ZFGDAkgt1ZUQT3CRO4OTSrRqQZm/QTYUwkAGfRvnx/kwrUFWWE/HEzk1w7XheIrpoqjHbRDbMK6VKgGOpw2x+jocJ+0Qk7+vYnGG4XBMQgoYwedhkMeKz09aWb3n4oI7vwKPl2VL78mknsqY5EOJLgu1ptXA7tDn2XATbR02HCmRHjKCGEW1GfbwiJUKAhBkVlbAxuUdNenoVW9wmnRrH0KRw==
Received: from TYAPR03MB3085.apcprd03.prod.outlook.com (2603:1096:404:1d::10)
 by PSAPR03MB5398.apcprd03.prod.outlook.com (2603:1096:301:43::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.22; Fri, 14 Oct
 2022 08:32:06 +0000
Received: from TYAPR03MB3085.apcprd03.prod.outlook.com
 ([fe80::3e1b:cc07:6f81:d850]) by TYAPR03MB3085.apcprd03.prod.outlook.com
 ([fe80::3e1b:cc07:6f81:d850%6]) with mapi id 15.20.5676.007; Fri, 14 Oct 2022
 08:32:05 +0000
From: Ken Lin <ken_lin5@hotmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: michael.jao@quanta.corp-partner.google.com,
	derekhuang@google.com,
	chi-jen.chen@quanta.corp-partner.google.com,
	dianders@chromium.org,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@fb.com>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 1/1] nvme-pci: disable write zeros support on WD SSDs
Date: Fri, 14 Oct 2022 16:30:57 +0800
Message-ID:  <TYAPR03MB3085DD9F15177F126E9DF7C6AE249@TYAPR03MB3085.apcprd03.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221014083058.1451914-1-ken_lin5@hotmail.com>
References: <20221014083058.1451914-1-ken_lin5@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [4wzVApcEQhO3366baQxtt3FbKqLGyWVz]
X-ClientProxiedBy: TYWP286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::7) To TYAPR03MB3085.apcprd03.prod.outlook.com
 (2603:1096:404:1d::10)
X-Microsoft-Original-Message-ID:  <20221014162956.1.I03357816df3d182ee791a7cd804742110f347bb0@changeid>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAPR03MB3085:EE_|PSAPR03MB5398:EE_
X-MS-Office365-Filtering-Correlation-Id: 9339d024-23bf-4f4f-2d71-08daadbe936b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	UU95ZgazOPcseHi5zNXDYV0W5CKPoi5bn2SIWySXgpauy7uDCAI7kSsHwsmbzYozL4T9Yl5CajvCcgq5cZAaMTMZgs2G5lrXn1sxO18dHwDEKOiQYulguHKXfdkjVNOFKlae/JWLdDGbclH0B/CbMX3SrCmXOMkJ4H8wlgZrPpuTiQdVVwGyyQV79JcoET9o0sI1FVAQbSH1bjw3pFMbHRGhL/DvQnoTzmV8IjbXy7kYlhunOwgwjiZAk62jzylHHRCtYB1veYBh4aMtpx5NDqFBqRmH7QU9WGWOT6axHOQChquTlRDhTH0p8IfmIdvb26PlDHNboo617I/n3imaIwbwFNCoh15exZqTND3sr6dv89EyVGp/OvqEm/JjwOeF/vi6T6XV1hBiGD8eM2pgpn22hqvUQp9UV1de1+9fxSL3d51MJCl3KixwLDv1aBcRC4n7Z6gL/zEn3Db874TlHPCrrHAbkkqIazl96MwLqZhmAH9aQY34jd0l5P3uapGtRjIIJsy8o9GDcLaupVtPkilppKwgF5X5mLzg/T/bO33mHfYkXweUdcr6UmCn8Fg+H9BF8o3JPw+mbUGyO86l17oxZXar6OHLjUXrhV0OR1fbHhHEaYcoR6K+qF8aISbeG4nT/1I58OFqez8zuSIXwg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?96tIu4XaQsXjUarMGZiSVx5U9Uufd+fxklZXZf2jO9cFfQTgLUhmUQZlWMky?=
 =?us-ascii?Q?le6UlOxvO1z2OB8pqmVGNS9dAxC5dsZR8WyHYeEUM0auw6LT0WN56XdzQDDl?=
 =?us-ascii?Q?4Kc1cZj1mWAX6LnRMiOARSYUMgV1hu5DoXUhbaSs7Igk5xd000WIeTrW390b?=
 =?us-ascii?Q?3HNXVrE2dp0X8ZjTJQrOtAb8te3qXxG2syJZMD1UKhCmCL8UC9Km9SNNf7qr?=
 =?us-ascii?Q?kHb7fZ/j/7aqWA1LAykNAkiXTIDGfNOWnQPr5W9lRubMg0I4P2gGmc6qlxId?=
 =?us-ascii?Q?cerHpSpCCLAlr+iqEoqnDI8x5Uif7Sq8yCQR074XGH4wZ7Sz6rhseHpERY0D?=
 =?us-ascii?Q?FAzFdlPa3ugWO6wKSrFIauKquyTpc4jwhPCV6ecaRsBb6EsTgKeF0PsRSX75?=
 =?us-ascii?Q?HYhSJmrsrGqagiC8/TwwSpZKh4nS82127StXNcOEOIVOtJW82UGAza/GY4uq?=
 =?us-ascii?Q?GcRJCsLGwiADrsTnxIp18BrxWlhZ2lKcxG2VE/QIzfDmvixo5caRgc4jNguU?=
 =?us-ascii?Q?bD/VfhMRXlsoornP+ag5cmYSvtCQUWhkIs7h850ZUVSzSXdymyukX/ZwPZxD?=
 =?us-ascii?Q?0nOwayj+K1HJK0Q6UPiYeOikmUKNwFbjnrmweQ0i3S+8ZU4AT9tDwXcAgG/J?=
 =?us-ascii?Q?zpTaVT48EEXKDFgmHXpikQCf6aO1/pJv+BluoJmT1RA3DKIikaS/AgqsaedQ?=
 =?us-ascii?Q?/q5iLbO7zkeAqC92NSl6U4XB/Xn6gTspD+jU+y314fsgRS4StqIQIs1mWanW?=
 =?us-ascii?Q?QFb4rRnpbw4PIhbiUflTHuRycWgYvCSQmjhTTZriNMXanrlIq3vslrInHVn7?=
 =?us-ascii?Q?sqruPbSV4MJjSZq4lhai77Z8jQ375juzGOvKSdACs4c3q8Ji8IJW/3m0PuIM?=
 =?us-ascii?Q?hAwf9F3LT0dodDEDjLbSGIid7w/+IAlplh9JZGWWpZADEman3/1kAFizxo6Z?=
 =?us-ascii?Q?Laq3VqjKIRVoEYQAad5onbYCCZJB0F/oDZz1ekZ8wZvKsYwKfpUz9HtgBZ7P?=
 =?us-ascii?Q?hW+YoQeS3QgyMlYUwF2Nuaj+DuB359GjXPs7jTiDJaxwZF2jC0j5QupqoGn4?=
 =?us-ascii?Q?JxLnTVmvvkzQti/Yh+bAQ+LjUpfSv69xsa901eXOMLyIcpP+PdhIEv6xEhUQ?=
 =?us-ascii?Q?IWZTvAPc6LUoOqp/MUFdMQVlrbpjUeVuR0tjyVomtHFPX7Jnosdn8gtF82Lb?=
 =?us-ascii?Q?0VuA2TVqXAXerAsUzAXB/W2QnUuUFYWhtQOc7i4bmaGOFs0DQAneVs8rUbSR?=
 =?us-ascii?Q?CI8Zo9mUnnVMDaqqsiT0I7BoA8A7GRlsL+yE6yRfpA=3D=3D?=
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c0b75.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9339d024-23bf-4f4f-2d71-08daadbe936b
X-MS-Exchange-CrossTenant-AuthSource: TYAPR03MB3085.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 08:32:05.8606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5398
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221014_013216_893533_AB38EA16 
X-CRM114-Status: GOOD (  10.55  )
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

Like commit 5611ec2b9814 ("nvme-pci: prevent SK hynix PC400 from using
Write Zeroes command"), Western Digital has the same issue:
[ 6305.633887] blk_update_request: operation not supported error,
dev nvme0n1, sector 340812032 op 0x9:(WRITE_ZEROES)
flags 0x0 phys_seg 0 prio class 0

So also disable Write Zeroes command on Western Digital.

Signed-off-by: Ken Lin <ken_lin5@hotmail.com>
---

 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3a1c37f32f30..5c1b812a3c2b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3517,6 +3517,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0xc0a9, 0x540a),   /* Crucial P2 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x15b7, 0x501e),   /* Sandisk 2280 NVMe SSD  */
+		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0061),
 		.driver_data = NVME_QUIRK_DMA_ADDRESS_BITS_48, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0065),
-- 
2.25.1


