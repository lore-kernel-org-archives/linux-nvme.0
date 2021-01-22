Return-Path: <SRS0=yPeo=GZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D822C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jan 2021 03:16:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D774623884
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jan 2021 03:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D774623884
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=OhuBOB1oRRFsFtCOlD17dggHd47CBgaHgSK34oj1Iio=; b=oEdFdt5eURPXhlqvPIrl0kjXI
	Z6i/1KYHu2YN7XC1Xmbx13avsVga+OOMAs8GkkG20KOyLSq1tMpbXmn/oCxbafEAOP3sgImr07EzE
	sihCAFgcvCsMzj9kAycZx78elOgxSByeM3iqEYpILIqC1D0Qw2FbdghUPOq7RalXu/Jlh7qiAlonl
	crUpiDnGFDaeiVDcXuzz7TepO3plYdpINBnTmK631jRCNfCuSfKGHzfP4A5V+qDIe4v1UJtqqfJ/e
	rzIG4kfSn9ufV3v8mq2p8x8pAKAGwO2jL5jy9dZ1ugaQqQ4uNh7xhNKDPT1yncD864DtVzgttEUyW
	6fLb/NjBA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2mvr-00029v-8B; Fri, 22 Jan 2021 03:16:19 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2mvn-000297-Mz
 for linux-nvme@lists.infradead.org; Fri, 22 Jan 2021 03:16:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1611285375; x=1642821375;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=zoiNkJCl+qT1JZnmulB4X9wOWqkzsQ6itlHlPUsvLhM=;
 b=YLIPqqHssxnsNtKVF+DQ80Uo81qJL69RKvACQ0bsatZLXWFtUbgFVgAp
 caPAc7+SaFOMdqjHHlWRld/6ov5Tn5O7eUfymJbiw/L719eYIhMmVizOj
 OnjGbCG1IHVTIsOLUxEvRRH7VIAJvTfq6iOFA2MYZwDiIjYuPj2YI747x
 2rEG1IFOQHhvhDiU9bEr65T1hNLnOmcemlOh6UWd5jnuvtrflnpSzkCfW
 7hRejCtLu5Rjq8TcUiL6CASYevtLC2xa7MnlLouvXjqGcni/ai1Xbodyj
 RTrZJ1UG+9qPs9ZKaDHP5H8t/jIeOyYGCc3/SIRTOdSlDMs3tJL1Px7kT Q==;
IronPort-SDR: gg14o2Av25CtVF3MRZ7WkkfF2iZStR6nUG+IOnPonZBzOEDgzT+9MLJ/W5V+sW3QWGBdAdrWw5
 Yv2j0Ha9B5rpsEl+Ucug0TRFeESJhrakCvrMEBnHY9soM6p7BhbHplTlcmLfZIfCDaUwvf/7Kd
 OarizNK2914O6kFXtl0NLbyPI/yeVsNCHUImZVpM3bNSguEB/cK+MJjhM/T8kvRqTpgeIt30tu
 ytkXmkzuOutK1Ffn8kaq2adn5J3cXRwerMAP8qy3Buzubx7eYNzwl76b/5NuUT0xaBWtDAxTjR
 KU8=
X-IronPort-AV: E=Sophos;i="5.79,365,1602518400"; d="scan'208";a="158046820"
Received: from mail-bn8nam11lp2175.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.175])
 by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 11:16:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z30js1Ux25OcqHYXxRm4V+vZm/y6uKQQOetZXmLE2fbJMcKe8yLYQW4ONjarYdeTze2TaZrIiOkYrDVZ27VoirO2lLFGr/suDmYnqEMM4HcbDfz8y6MNu78hZ3SsY+gtRDaO7ikaudRd4qsPvTjlxS0GF+6toJZlE+6glySlpclTQ8Hp7WhvO1rnTiy37QJgEbVYZr3VMravpPt0Y8hSINIbowN6qUD5iuWm3u7feR/J1YbUVlkrGxtEIN2ktMkKoIEabOAfBiKUpMbzjoXC7mVrAg1XDSo/NPejl49ju3vzgOUhynfkUd7uuGQxc8pbuaLKID1iuVUSonx2XHk8qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1Ac3dMgxOKuzzuBJEAIfd6LFyCPFuRAEWU5296oWko=;
 b=JFG6A761Wlo4PKcfohbrKWufzM/3Tj/XBV2/LJb1x6XY9KdrGJ5hFkEHyLgKk+fzGCnCWpMRmLdeJz9b/KvHaZdMldXImc3NrDT/X420ErlVG8U0hhSa5CrCYzeui5mtnCpBqimCnSXtPeH/pH7L3xhA2m5jBRg2HCYmfWPjHPZJWwpruZRVFCPANkQXmXEa/J8kXMh7MxF2K3vG54FH9Q1rpWU/NGJ6aFoDFAk0ph8Ie39MeSOI1NbCJKxVqaN7DR7OJyhkSrRV3bf3w7IMKd7pRBI1x+/znezgYejIIWEPJVC6xfG6u2YqtOKWskoMDrdmCfmKbhR1Uif02jAyFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1Ac3dMgxOKuzzuBJEAIfd6LFyCPFuRAEWU5296oWko=;
 b=xZrceGcFZ1cwSnubW9Rw1FWZem4kvmCmikkTUaCHSCeppq//F3MZukl0vYRyoHjya2HcUN3VeWSGtAn6Lcodmk74hnSHs10vYEXpPo8DY6P/IVs816VJCtRcOHzoWTm8AVwRlOQZriGaKtcbpsiE2j4rzlE80c9i0dTa/9U626s=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3782.namprd04.prod.outlook.com (2603:10b6:a02:ad::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Fri, 22 Jan
 2021 03:16:09 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a%6]) with mapi id 15.20.3742.014; Fri, 22 Jan 2021
 03:16:09 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "chapman6235@comcast.net" <chapman6235@comcast.net>
Subject: Re: Problem with SPCC 256GB NVMe 1.3 drive - refcount_t: underflow;
 use-after-free.
Thread-Topic: Problem with SPCC 256GB NVMe 1.3 drive - refcount_t: underflow; 
 use-after-free.
Thread-Index: AQHW7QO5MtNnJXjl5ka4VClzrgzGFg==
Date: Fri, 22 Jan 2021 03:16:09 +0000
Message-ID: <BYAPR04MB4965342B52D5C3C6D8A7892D86A00@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <f50bc59c-db11-bb44-55be-7b9db1119872@comcast.net>
 <BYAPR04MB49659C0F0F0E11D166B31E0586A40@BYAPR04MB4965.namprd04.prod.outlook.com>
 <a4c75497-d170-1e0f-8608-282231ff3a8e@comcast.net>
 <BYAPR04MB496542BEF594F0380F7D41CF86A20@BYAPR04MB4965.namprd04.prod.outlook.com>
 <df46d7ce-ce70-1f43-0efd-7153761bcff0@comcast.net>
 <20210121124459.GA156577@localhost.localdomain>
 <c48abecf-8e4f-b76a-c751-1a0d239c99b3@comcast.net>
 <BYAPR04MB4965404638B4C43DBA577D1686A00@BYAPR04MB4965.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: comcast.net; dkim=none (message not signed)
 header.d=none;comcast.net; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2600:1700:31ee:290:475:2d41:83ae:3ed5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a81751b9-ce81-4637-1181-08d8be8410b4
x-ms-traffictypediagnostic: BYAPR04MB3782:
x-microsoft-antispam-prvs: <BYAPR04MB3782ACEAD169633B436B38C886A00@BYAPR04MB3782.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jjCO5XYXn0+DzvJDs4rxmarxEPod20yfgLcSP9O+C196oektDYqSpNfe15G3ztQkugQc1PbSxRboOhZHIUeoW5+TuwQi20I/9jR45W2PHtUVn5DWjSGV0awEIl2se3yWGSr7zTkPc4OI/U7fcYBkNB4gifs37f/b3iZUjj2ok3HDr9KloXMlLzUCDJQrlx+ac8cH+we02XNZzuW94uODzdicenBBSTOoAR/CiB6ktz9cwQia/zSSP7bruppaDQdBUcJQO1+o1C5Ib6xOPFadQ3DqJvOdZN7Vki8u2q1OWquq3+P8AxJYhgluDM6HeW0ocQwrMvEzlN5qWNIz9iE1Jc5uyuAYWtUFfQrKYhoNIsvnW/inqEfjU4GOTWsVLiaWHgAJp9WdEcil/E45ej/iWQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(316002)(66476007)(478600001)(186003)(8936002)(86362001)(9686003)(53546011)(6506007)(4326008)(33656002)(55016002)(66946007)(76116006)(66446008)(64756008)(7696005)(2906002)(52536014)(71200400001)(8676002)(66556008)(5660300002)(6916009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?iAg/RgAVEYQjoa9DCBkQbYDi7lg31jmlupZiHrWvKpH9U7eddcgjJ30UDybz?=
 =?us-ascii?Q?lGIjW6T6CmdbCRwDs3IRtzqfWdMQtaH+ZeBFV9rBqrMqE1sG2B9C62jQ8zck?=
 =?us-ascii?Q?TgqWSv3MAt/7lq1+1uXJ4M2UY1h4pwZ0DcVf0gYolAR0dT7FdNNxAh7TGYGa?=
 =?us-ascii?Q?aQGrUpaw+tugzvSMpyzdI3j+JXJlUBayrdIcZjxNa7WWcAdwvsGitLBO2oqx?=
 =?us-ascii?Q?e3I5cLkWn0+6Nx3L/29n/2EXxpqHOXgQMPw2JMx3UjA4eqU0PUZu6RMq6SrD?=
 =?us-ascii?Q?nqHYWsyAo/RmtqXW4fS+jBWjKZ1iazqqfAfbBPrEYYkPmLpEVd/Gg9Az9djK?=
 =?us-ascii?Q?DKNvx4JutCaO0Ak3a26h7F2Hem1v1UsHN2lc5mCDjk7bngfsBgjo40yYsGZ4?=
 =?us-ascii?Q?MLo7N71S1PXONmxua86FZbQZjjG6BFeuJzfo7AlBGsjHGSs2ZSHubYVTtpHG?=
 =?us-ascii?Q?xUZFh9DEZBEKjJvbvQ0ZJ266qI2eCIJx/0jaVx9j71ibQKc50dxK9pqzkio4?=
 =?us-ascii?Q?rQ0tuDzjSlEOjDaJq5vZARV6Jm/RXpfBubY58+XpBQHB5mSnuabDi67bcVNB?=
 =?us-ascii?Q?swhIUfEG0J2HbWjQ6i66e6q6oG1Vosj45AS7PLUYwEsM0/bVC963SatTX+1R?=
 =?us-ascii?Q?1CK9JkAbVIL1elRJUTjL3Y+VHkTzMNdfNbpQ+g0WElCyO6ev2r987aWVatav?=
 =?us-ascii?Q?64LjsF4CXQ0hl4uxatdrO64CmqboGVH4A/pBlWAnM7+OJRbjuxLVngKUT/MF?=
 =?us-ascii?Q?Ze8Yj36+FAC4NfBE9XE8x31YX7Ir0hgNoGdX1r/sIsr8fc4Rq4o1yeamF6gu?=
 =?us-ascii?Q?ofClJA+StEnwLjWVkAqdat3WnOPaqCNwF+hD3rmnz8Nu5fJ5Q9Vz4gpzwVJw?=
 =?us-ascii?Q?rcCu0v0LLmglJKju2qLpFubTotmG1PEy+n5isvr4DUIy5MLFxDqogyvL8TZA?=
 =?us-ascii?Q?sWJoeoGTSkGwmI4+QEOeDEBjTmXJkStrg1jJG0w7TBcfK7wxiMSN7nCWCWel?=
 =?us-ascii?Q?gOzctIHFaBlb85tO7Bf2WBR2jy1UCT7bYQ8Lp7ZkJYjFBmh4lk9d6fNQEp6a?=
 =?us-ascii?Q?WID29h54?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a81751b9-ce81-4637-1181-08d8be8410b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2021 03:16:09.7458 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Doab20tcYxAlgAlTCc5IXc5tQt0u/5tuUmIC5SVAcPcpCRC5F5nxWeCAVUiDmxi9GcBL+63FZ7aiF/6ItxzUHsbmY8krE68MD/R5UwZh25w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3782
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210121_221615_986713_76C5C198 
X-CRM114-Status: GOOD (  17.68  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/21/21 6:57 PM, Chaitanya Kulkarni wrote:
> Bradley,
>
> On 1/21/21 6:54 PM, Bradley Chapman wrote:
>> I compiled the kernel from the above git tree, rebooted and attempted to 
>> mount the filesystem on the NVMe drive. This is what the kernel put into 
>> the dmesg when I attempted to list the contents of the filesystem root, 
>> create an inode for a zero-byte file and then unmount the filesystem.
>>
>> Brad
> Did you get a chance to see my response to your previous email ?
>
You can try following patch with some modification :-

From e162a2e91e4895ceac6f80042a87c4ba6a4fbbf5 Mon Sep 17 00:00:00 2001
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Thu, 21 Jan 2021 19:05:13 -0800
Subject: [PATCH] nvme-pci: add device quirk wip

This is work in progress patch which is based on nvme-5.12
HEAD : b116d37fc0f5 nvmet: add lba to sect conversion helpers

Replace <YOUR DEVICE'S VENDOR ID> and <YOUR DEVICE's DEVICE ID> with
actual values sysfs entries in patch below before you apply the patch :-

cat  /sys/bus/pci/devices/<your device id>/device
cat  /sys/bus/pci/devices/<your device id>/vendor

This patch is not tested at all.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 25456d02eddb..c5b43bcf57b0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3228,6 +3228,8 @@ static const struct pci_device_id nvme_id_table[] = {
         .driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
     { PCI_DEVICE(0x15b7, 0x2001),   /*  Sandisk Skyhawk */
         .driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+    { PCI_DEVICE(<YOUR DEVICE's VENDOR ID>, <YOUR DEVICE's DEVICE ID>),
+        .driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
     { PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001),
         .driver_data = NVME_QUIRK_SINGLE_VECTOR },
     { PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
-- 
2.22.1




_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
