Return-Path: <SRS0=dfbP=KU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC8CC2B9F8
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 12:11:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9E8861284
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 12:11:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9E8861284
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ic/NeGp2tZbtUk/4iV7jK9jsr+rS/ywKPoxLuVc5mow=; b=pw4d+8ifunRSnJ
	qhFTTodUF1XtFrfRzv97yxIlDcDWLx0YdhUp/mj2BqoE20TGbrDBUWua4eEDOPuEoZExKNacQgE1R
	pv/ayiWfwO3rB8OgmLzUw9tkjgdn5IHaGmUea1I8bBjvzZrsrHiExcTUIABt8fkXGzUSMRqJcVX0F
	8S3eWoKrCq/QpC0SYLTWu97NfeQpWWyzoPqOohLCGGKN7fIVGNP+loeR9jGfWvvJH7M9ydSV8P794
	701cla9cR3n9geDyx43WvX8vle36ErB2AhPlxgaCA7VRx/Aeuir5MxbP/qlE/dAaB/mv9eG6zEo7i
	TJ/w3Q8KTiX7m/BTGhzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llVuH-004vXS-2P; Tue, 25 May 2021 12:11:33 +0000
Received: from mail-dm3nam07on2089.outbound.protection.outlook.com
 ([40.107.95.89] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llVuD-004vW0-Ta
 for linux-nvme@lists.infradead.org; Tue, 25 May 2021 12:11:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PD3+KIwFfpnBensBT7f7pGidN2UH3T6qa2X1zwOhS4VnWT3WjaqqFD6Srs6dU+HFKGas00G9Ub5Zw3xVXmVBkvq4HiKM9JlxFZFN+gtKdC9SdU5qqaKBW1Bs5FOdHu6ZBhsRP6uIq4fKRfNvHmO7xs3If+6oJzZf5QysfwpHsE3qJURo0xjsIU0IDQ9lTSk0pUS8qX6yoDQtLR3l9cdU2z8OLfTjbMH2Yi9U88/X4hByqh0hwNuHAtgc47F0SRfgoebYyxSlehlJrkPxfzAbdXXNIswhZe6uD3c26zc9ef3r+Emz75IKdRE88C61GjfzxZpfZcQ1mRQPSogAC317IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPTHa3CCWHNboWGu2MAPmLyldHrtG3rC3Kiv4NiPm/I=;
 b=mOdjG7zS6pzH3y0RIm1sZusE5L1Kl2YWTcuWIsiqiAFl8tPrYNsayG3ZP9M7Q2I9aRJTkF0Mow/Ru6NIG4aelwSEtMrmBdfHZwY9wla2/GbyBeUVleRwB38eULl/idUxKZxRs0lpmK7S0ixNgmqcy23EYL+oxhCK5Zqt4mCCjR2TX79TG+5yHxZSCWYCCo9wZAfBWFtAWCY7Dd/ZdOLuYpkYsNQtuTIGVOQdpP+RnP75Hhawtzr5P19ag2cQDZwIZDcK0efeDiakxBYKhaV6VDxBMMkO4AkkjYF0m5TMZcj1C56UraMTN3DElews0lvk3I3Gdt5aH9hYHvL4YUYqKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPTHa3CCWHNboWGu2MAPmLyldHrtG3rC3Kiv4NiPm/I=;
 b=y94NoCvjV3PRCW0RbBchQdbZSLqImo/rCmW3jAVTUG4xMsgIw31NbmribSpOGSZWUkUzSwue1cNwW8v5MM9gm5qPt0B/EveIWx3fi/Rb9LORO6dCYKDIsQqqgUGl13DlthUBZ9F1thZOp1bquuMFBmzkcN0LWUspxLlKtjLIEqw=
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BYAPR12MB2919.namprd12.prod.outlook.com (2603:10b6:a03:12c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Tue, 25 May
 2021 12:11:25 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::ac06:4fe4:c52f:bdd7]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::ac06:4fe4:c52f:bdd7%7]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 12:11:25 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Christoph Hellwig <hch@lst.de>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: RE: [PATCH] nvme-pci: set some AMD PCIe downstream storage device to
 D3 for s2idle
Thread-Topic: [PATCH] nvme-pci: set some AMD PCIe downstream storage device to
 D3 for s2idle
Thread-Index: AQHXURCjUDSwyQ2dl0qNhWMXuiDPGarzujiAgABgJfA=
Date: Tue, 25 May 2021 12:11:25 +0000
Message-ID: <BYAPR12MB32388D6D92DF64035651D900FB259@BYAPR12MB3238.namprd12.prod.outlook.com>
References: <1621910939-24831-1-git-send-email-Prike.Liang@amd.com>
 <20210525062119.GA12561@lst.de>
In-Reply-To: <20210525062119.GA12561@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=ce97db6e-a9ca-4215-9309-880e0dd79a51;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-05-25T12:05:37Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=amd.com;
x-originating-ip: [139.226.130.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c83570bb-08bd-4605-dec6-08d91f763812
x-ms-traffictypediagnostic: BYAPR12MB2919:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2919D3D4B07B2F4FBD21C9A5FB259@BYAPR12MB2919.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fk0kvVCowdUS27Zjbo5g0LGAM3n6r43w+jGIfsrQRiBxZmNE025Reeg7c5PovBuDhaWPEpk6/TkZ5hgBatZexT5ZtIGuVO5Xbpf5I4NSLh3/xNGWn7cTKZlu79/O1iqchrw+e57DXGtpuoAUHKudKuEeF6wnLz8iGImQbTo5UjTp/Ezk3qlud6oTgaO6LoZ/orvttVEXHPxhTfwBP6hhbyljUqM3xxV2hLHPMkIjf9COQU4G7gyKV/I6sqMmq8HganXJHCW61VQ3/O9F/FTj7YoGCQGGMKSTzW7oMCwxBvAEJfOTV0T4fh8Qkt7ivOszEewMRoI+uJ9WCsDJiMayxzNv/Xc/Ez8Uus+2ImyYoGp8XelcFKeTIvNuegfKmKasX5GtPJ3uYkODJ0uGwvKVA/wzuLd9pQpUxWKMZjPeL/Ze/22sAutv4DtkQwfwABkf0PZiQkIRAUh7mQUAIL0wfEYJbwKlOlRrTqStwLKd8ncO3LcoeIMCX5nx8WVBDmlRFMEwtMZDgwJ4Lo3O5/Cft4+UwoZoFqmPv3svEEf5+WOl2cPxR1Dxf9IqtnclIGcGCGEI5iRNtff7ZnjQsopRctZ87Cswiedn3kaLkQmvDnU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(316002)(54906003)(7696005)(9686003)(186003)(6916009)(26005)(52536014)(33656002)(5660300002)(71200400001)(55016002)(38100700002)(6506007)(8676002)(76116006)(66476007)(64756008)(83380400001)(4326008)(66556008)(478600001)(8936002)(53546011)(122000001)(86362001)(66946007)(2906002)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?bbni4Qcf6LYO79c8HgCwaXrIRHWGsVZ0seJoOo7N1VaHCGmeeTCGAyrFL3Wv?=
 =?us-ascii?Q?iHyjfiPbNmadjnYOegnVxj9MLHolSyAvFcXAYcS/rG+GDnk8vDovWhdacxG0?=
 =?us-ascii?Q?LafiFl+I0G7COBqaywBfk0+DA6BsPAFnGmTnF/6+vw8RTRt9lW4qem7p4IvF?=
 =?us-ascii?Q?dJqVq+HbPpitJEod0GgjwyUxhCT8HfhE1U1bQjwvZbqBL5n5v72TDu/NHLwP?=
 =?us-ascii?Q?D2xbs4iBotef09m3sGJVwhyMENedoDtruG5HSnAWMCBCL4SBmmdJJpnMH3sU?=
 =?us-ascii?Q?47KUyJuLGPu5+rph2+/nhEeuU4P2+Y89pLWjF5pY9jo646BY5lVNvRWsBjPd?=
 =?us-ascii?Q?qasgV2GoDlZCtqI9lySgFJFOY+YgW6rW8RnxEGMbVZRl7x44P59pkZQVTsfb?=
 =?us-ascii?Q?rWSj+6GffHviztgqyHYjIj/7iq0D6oUpEykQWVjR37m26f7dHLjQI9MQQokQ?=
 =?us-ascii?Q?glSeGYBFrsowFJu1cRKjaqcI+m3bwpPXXWnNa+b6GTHsuXYhdr1C+trYBi5J?=
 =?us-ascii?Q?bclWQGhL695FSk1go9MwjaflSWY79/kHifm4t0Ry3bRKsbVq/ErdKA+m3Hc/?=
 =?us-ascii?Q?Wbd7W0Dm3ZHagZ27yv3Rw68qcFUm5za0AAW11nsjHxUx7xio4Vra1MrECaKo?=
 =?us-ascii?Q?h5Mafm2R14JnuBGAjGlBcOIkTGl9Qjv9/oFcOiOg7eKGRD923OMU+oIob5uc?=
 =?us-ascii?Q?ly8fhGw6agTmQ3Pem+2nTwpq713K8e7peZEiCgeVufEPJIV1ikk6W22L7/Gw?=
 =?us-ascii?Q?KylIzUp1nU9xnzg5CWPQd91Twm4bECj0sQsSs98Qe3khFuOJRq10AU8fJUgH?=
 =?us-ascii?Q?HyyH+WD4QcwbdDGbeVyR4gHxd169AepBe//AXKXkfY4TIY8YsTjKR8Tofar0?=
 =?us-ascii?Q?wvlAnnea/XHOcIHKONkNhFazCvK7/OneammERzWMCO/VnIxsDjM0AbSD21wp?=
 =?us-ascii?Q?VVJZz6cKUmr0Pt0Zu9VgTP7NZjjUkFp5SWvuRg5i9YP5k3js9Na7KreDwF+T?=
 =?us-ascii?Q?5N3DEuwP/JtzCyQXt4fOwSVAAD1N4rmwzwya8FtXVErq7lS7HX7wPLiaO6/u?=
 =?us-ascii?Q?dAkhNdcBDNltiKDRwR5lqAgY3EJ8Q1MHdasYWyDSbWeDj9MXOr/8SUcVmLvY?=
 =?us-ascii?Q?l/tBVmCUygRcPvMKdt9pz0fmQswozgy7kzPI7gtBq+huMBoqSumz/XlfEv1Z?=
 =?us-ascii?Q?kvmsCgbrAzhAMjYn2iFa73c8L/pgDYzxayWCO640Gub1uon4YNSWkwPjRyB4?=
 =?us-ascii?Q?1GY/ACDB33TxO4fbF/eRKQkTGdv1wjuIhMlu9dzSp3gpJaz07txLG6QPtEgW?=
 =?us-ascii?Q?60+I6U1/gjNgNUPnl9c9dq1P?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c83570bb-08bd-4605-dec6-08d91f763812
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 12:11:25.5119 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KrjCdqTyfSosS1LXOPvjDxSiGKAErVJCz6+RTsKpMiLWv575jZ6Mbv7NTTq+CEmF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2919
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210525_051130_188528_B80F8577 
X-CRM114-Status: GOOD (  21.87  )
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

[Public]

> -----Original Message-----
> From: Christoph Hellwig <hch@lst.de>
> Sent: Tuesday, May 25, 2021 2:21 PM
> To: Liang, Prike <Prike.Liang@amd.com>
> Cc: kbusch@kernel.org; axboe@fb.com; hch@lst.de; sagi@grimberg.me;
> linux-nvme@lists.infradead.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; S-k, Shyam-sundar <Shyam-sundar.S-
> k@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>
> Subject: Re: [PATCH] nvme-pci: set some AMD PCIe downstream storage
> device to D3 for s2idle
>
> On Tue, May 25, 2021 at 10:48:59AM +0800, Prike Liang wrote:
> > +#ifdef CONFIG_X86
> > +#include <asm/cpu_device_id.h>
> > +#endif
> >
> >  #include "trace.h"
> >  #include "nvme.h"
> > @@ -2828,6 +2831,16 @@ static unsigned long
> > check_vendor_combination_bug(struct pci_dev *pdev)  }
> >
> >  #ifdef CONFIG_ACPI
> > +
> > +#ifdef CONFIG_X86
> > +static const struct x86_cpu_id storage_d3_cpu_ids[] = {
> > +   X86_MATCH_VENDOR_FAM_MODEL(AMD, 25, 80, NULL),
> /*Cezanne*/
> > +   X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 96, NULL), /*Renoir*/
> > +   X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 104,
> NULL),/*Lucienne*/
> > +   {}
> > +};
> > +#endif
>
> This is completely unacceptable.  The NVMe driver could not care less what
> CPU we on.  We need information from the PCI or power managment core
> on how broken the power management of the root port is, not this kind of
> crap in a low-level driver, with potentially many more needing the same kind
> of quirk in the future.
This solution NAK is reasonable from software decouple perspective. As to this issue
seems only take care the NVMe D3 support during s2idle and the StorageD3Enable property
is defined for this purpose. How about approach this issue directly like as following fix?

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6bad4d4..8d89c84 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2856,8 +2856,15 @@ static bool nvme_acpi_storage_d3(struct pci_dev *dev)
        status = acpi_get_handle(adev->handle, "PXSX", &handle);
        if (ACPI_FAILURE(status)) {
                status = acpi_get_handle(adev->handle, "PEGP", &handle);
-               if (ACPI_FAILURE(status))
-                       return false;
+               if (ACPI_FAILURE(status)) {
+                       /*
+                        * In order to support NVMe D3 during s2idle, the property of AMD platform
+                        * is defined in the GPP6.NVME device.
+                        */
+                       status = acpi_get_handle(adev->handle, "\\_SB.PCI0.GPP6.NVME", &handle);
+                       if (ACPI_FAILURE(status))
+                               return false;
+               }
        }




_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
