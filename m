Return-Path: <SRS0=EEJI=JD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C07C433ED
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Apr 2021 07:17:46 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DE07601FF
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Apr 2021 07:17:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE07601FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Hm9tvkI000B/bTkwt1+vP8IpAYpy0qFcWo/ZNwPWyII=; b=YsEH/OEPpwxA1cPzvaHIu66dO
	Qsb4hbKguXvFmj4mMfm7ZLDtu0F6gqojuhvxqNHmPzk4DvZZMrp8K1si4ibLvLkfCfRoycfJFtoU2
	5HS/xV5vcHXnl9xA8GkfxD+CJM4NFMAOuPCOgPRVrVYhRvzzEQuFAZnCys2bRaVCgQLsTvPsSE9kF
	TL45q+KJXohKisPiiyoQJaqp0RyyGAX1TzQSXiSLUzsolAvLth1J55ixRLzstjLZpLmd7YTN1BzWu
	D5ErYr/zLUI92I5AcVrC4/CCEDuoXIcStqUpeRTB2pxTSLvE5ytrhWhzLVKDzXJzoo1BbrLkKNcd2
	hbScwy75Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lTfxz-001kHp-GN; Tue, 06 Apr 2021 07:17:39 +0000
Received: from mail-bn7nam10on2078.outbound.protection.outlook.com
 ([40.107.92.78] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lTfxv-001kGT-61
 for linux-nvme@lists.infradead.org; Tue, 06 Apr 2021 07:17:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2RD7nCj0/7z37H8TtYu0t+G8JiYGuvYp3YHccNLbDZxSFheSPq2escmKgb+/eq28w7zSlfRtRc3b7EDFguuSSmnjXOU/xReuGLGp+cgSBKZjkzLCMIUaId9GhPFV6bN8IvzN+698cSawsu/PLw0MQ0Yx22GJ4Z4j5V2YpZNLZS6n6UBHPX2xW+LKGsc9Af4OsjI8eVri6j+70NfLYYkHREGgnMBZgIVrdwM80cg+ydm+v7pLFWV5vTtJReFJfotmFhf+Gntiik5Z9UD5SuqClhpKVQCoMbTPrRTvmXloJtJ0CiNPIs516bO96J/s0wdlASZL6FChi+mohfeoXHErA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1BrrtTWMOBynHwrGBJadJZv2TVyt44hdICb/lHLaPk=;
 b=Apq6o7j3zDq0YokSBRlNL7Q6drs4bTadBZxZsKNE65th3PuYD3iA1Q17n1Hqon3PLj6w7p2XtXNWNCHS2xctYqr+YlGUTsWogH82WCtheU04EZ+BmjxqG9V6pJF22g7DIeH9TZou36EyfSSUrXqdE2ne8YzLlYe8yRD2N8mwE0ce8kapy3JQTOZMbGjJcij0ved3JkAZMl0PBz7u72z0B3CFU0QyLggQUO6SSm309VyEGl6FqwIMt789Va2XhxcIn3rs+5EcIA41OKjRlEMWDqlFk+BmWHFmDIZ2GhOAXkAnN2w+12EkQBIr/oXUn0c6Do8FMYs/9C/P1EE/BrTF8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1BrrtTWMOBynHwrGBJadJZv2TVyt44hdICb/lHLaPk=;
 b=czpwernG0Sm+xCxYK5UWhdLWoLdpsclr2iqvVHxcJAus3ruvBzh1Ye9RnWzx5t2Zqz4NQyUbsenI9qlyxbzuoJNEft9Bes5H0/5T46r4J3rWG0fqfpDTw0i0FIi0RnDm9p6f6pRXU4PHNi5lUYMuG2FH6qyRHtAOwg+KXJO/Qjs=
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Tue, 6 Apr
 2021 07:17:30 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::5870:fcd6:b13a:c49c]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::5870:fcd6:b13a:c49c%5]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 07:17:30 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, Keith Busch
 <kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me"
 <sagi@grimberg.me>, "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v2] nvme: put some AMD PCIE downstream NVME device to
 simple suspend/resume path
Thread-Topic: [PATCH v2] nvme: put some AMD PCIE downstream NVME device to
 simple suspend/resume path
Thread-Index: AQHXJiww8yAELa3I40uYp87vDTMXuqqnHEwg
Date: Tue, 6 Apr 2021 07:17:30 +0000
Message-ID: <BYAPR12MB323843C917E3DD8B78F5B89BFB769@BYAPR12MB3238.namprd12.prod.outlook.com>
References: <1617194885-459-1-git-send-email-Prike.Liang@amd.com>
 <BYAPR04MB4965506223DD3DE08DA3CC22867C9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <BYAPR12MB3238BBBED21B92C3BA69B682FB7B9@BYAPR12MB3238.namprd12.prod.outlook.com>
 <20210401015112.GB28381@redsun51.ssa.fujisawa.hgst.com>
 <DM6PR04MB49722AA7EB8BC1BE985FCC15867B9@DM6PR04MB4972.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB49722AA7EB8BC1BE985FCC15867B9@DM6PR04MB4972.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=5214b098-dc77-4a29-b937-9e3a8c03979a;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-06T07:13:47Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2616a830-6a5f-4314-1b28-08d8f8cc0a99
x-ms-traffictypediagnostic: BYAPR12MB2840:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB28400B1E91EDFB882BCDA9CCFB769@BYAPR12MB2840.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: COY3HbVb+IAorgYZOLunvp2HvtmQ8ZR5m3nL+0dJTv5RD7rRAxzdZNjVzmnETkA4Xh1d72AfOxUmpq8q0AYY2Q++oscdLdydGsOTsrhEgNzAT8VoMUnDMNP0AYoMW66e3B/FCXg0sWJyc6JUWiDFxlutQsAUQ4Zwvet5cyc4x/rYATATYV4AZQ3H+SvtSdVQSBZ96Twg77Rh18KMNkXHQgcvrC6Ezy+qXhLa9eXbjBQ3wooXnf+FTacFFDxbqW9F/sUeiAWOiQtm53/SUurKakAwupNJTLruE33j4dpnazKO07Vlx9swi2TTy4sLMseWquy783P2Mj5IeQmKOR4+M47gVyR/PlDWliE1vu/lbyhNrSAleWLd8nrhXjRb+xWI/q6HX+aNTtfzhL+PJPdhxxYttyWzIfHbAK2VCkSwxcc1eUxzqAjO+0ou+hnpsvfOMyTAWyrRvmhZJpMxw3D8q8oGyIY/QgEIbCjeLPKAJDCAUPjtkNjvJ3oSlmkn1797oXe6u7mCOYoyFf3a7LoQBmRnq0on9Ykv2NQEdfRwDkY7Xuou3MNYGjtSreKk2VU7E0jo7Eer0VYQ4PkRCkYvBT8YWZ1+ePLkAcWUfh4S+5ypDjK+qcRYwp1hMdLP/Tf2v2/H39P7Lp56aT8LmMsfpqoduCTnH7Htv+gUs96ltLM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(2906002)(38100700001)(9686003)(8936002)(66556008)(54906003)(186003)(76116006)(5660300002)(33656002)(52536014)(478600001)(66476007)(66446008)(71200400001)(6506007)(86362001)(64756008)(55016002)(110136005)(66946007)(316002)(26005)(7696005)(8676002)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?oXzi0Irtwu7ZIgG7JvXtrRMqndCOYKVFwjOoEQ89qEhjxFaHTCg/oYQijJIy?=
 =?us-ascii?Q?Xf168MJIW06/agPKTbMBIPi5vnsSfQh2JQqyqGoYGJu5DR3RJCQVGNKrkoF0?=
 =?us-ascii?Q?t/r4S/F0lk9JMmIec8w2wG0gFWvMU6BuVTDGnJzXe2lGSowJDpTEy79LunZe?=
 =?us-ascii?Q?v5p34sTTu4Ug9rTeSjtrv+TJA0KXkL3FPrsjbMvpMc7brZqp/zplq30RjUi8?=
 =?us-ascii?Q?trLKQvXYgPWwRaJerDlc+8O1+FzpIi2+PLwKMSGiRF9uOypzzL3s52YJIoIo?=
 =?us-ascii?Q?eeOt9vvGoiTfKfpnX+l0wobU2n2eH8QozgEsqDW9evOy+InKFtf3WriTCzFO?=
 =?us-ascii?Q?azofudR109pegAI5oLHbsviMbBKpylQxGxmlcQGFrgz4dkJDjDWy5VmN0GmZ?=
 =?us-ascii?Q?I69lnPTHYkkBR7Gvu2jFypSOFY8+n21dHc8FVU2sP7Lb8g9cFr5Pt25Kjmxs?=
 =?us-ascii?Q?vaERPJGWrXtU9WuTMUtcCyPj6W6qJB4Tj5fFAyCFNP961ofJRPprrgdIJVJj?=
 =?us-ascii?Q?IQKiUDMIU1Fo3EH2luI2G7+kWzi86dvVQK4jeL6vN1Ey0YZgmhTH64Ml+lak?=
 =?us-ascii?Q?zTxFKQVzkePhdTLSX+AO5ozyC6MrUMEvZ7uXybfEfFDp2G0LuWC3BPSGekAq?=
 =?us-ascii?Q?HqOZ+41odpovYQyvQbGPlJG3tVyPDW00TTZBGv0rGgKkE/Th6q6FfR3hpXmY?=
 =?us-ascii?Q?uh0mJFe3GE1stoMw5GpsMLhvEJqIUrwOQgv/ZOTDwcOXRmzQ73QL56WxulTO?=
 =?us-ascii?Q?jGDUsGsMubBfdAiAHsaW8jaNRP3QK9lRaYso7zJGRbgl3j4bXFWgKZemCBGl?=
 =?us-ascii?Q?/IoBZqTZu2JN70M89Gzq3zO3pKRKpK19obL+eUoTRNlJ0gl9ckg/deqpfVAc?=
 =?us-ascii?Q?/l+ilaQwH1RXQnDELP9aRnrRtX6N8xZ1s2ZbDoivuXjIm0ZXyNiBosRvAVli?=
 =?us-ascii?Q?MpTUpsD98KWtENHACK6OZAfiZ+KHM+qBQ8alEC8d0BRr714UiNALLGPUoJrx?=
 =?us-ascii?Q?plvTl6txbfrxgZXnDpMSKMM/fEpSnCYcd6Sw97k4dZPQ911RNnQ3G7zSwTSQ?=
 =?us-ascii?Q?AkZ/wyAv1JrGCgHlkNQoGqP6LWLCvYbcmuDxHv+Kb2GTyg/C4kMYLnAQvHy7?=
 =?us-ascii?Q?8ZkxMHk8cWm0qx0UnokN1KzPLjZ2xDloLe9chPqUoZQ9e9I1D/HVAYYnZQIw?=
 =?us-ascii?Q?jgkNL3dh2h/90ElyYbuP23YAQBdJeDp7p+9Qyc+fJMnUKqGTz2pHxG7wmY/q?=
 =?us-ascii?Q?SCA6QFSU1tKdfCKMGjkAFZ/v7dXwoDifwScmC93qL5dowydHY9ZpydpVkR+z?=
 =?us-ascii?Q?2QH647XgUkFYaso/CBKUOXXc?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2616a830-6a5f-4314-1b28-08d8f8cc0a99
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2021 07:17:30.5349 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cAKby/ypxRwjsbXHkofqPiqFvZY3/LJIRvCvgHcJcfWUpFswxoowjqzVhK15yxiY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2840
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210406_081735_375816_CF580C60 
X-CRM114-Status: GOOD (  21.02  )
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

[AMD Public Use]

> > This header is not appropriate for public list communication.
>
> Yes please remove this from next patches.
[Prike]  Yeah, the header should be replaced to public info.
>
> >>>> +static const struct pci_device_id pcie_ids[] = { {
> >>>> +PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_PCIE_ID_RN) }, {
> >>>> +PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_PCIE_ID_CZN) }, { } };
> >>>> +
> >>> why new global pci_device_id array is needed ?
> >>>
> >> [Prike] This pci_device_id  array contains the platform root complex DID
> which need shutdown the NVME in this armed platform for s2idle.
> > I think Chaitanya is just suggesting you move this declaration to the
> > scope that uses it.
> >
>
[Prike]  Thanks proposal and that's sound good to move the reference PCI ID table into the caller scope directly.

> Yes, something like this on the top of your patch totally untested :-
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c index
> fa81cea41f48..8b2f619eabab 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -42,9 +42,6 @@
>  #define NVME_MAX_KB_SZ 4096
>  #define NVME_MAX_SEGS  127
>
> -#define AMD_PCIE_ID_CZN 0x1630
> -#define AMD_PCIE_ID_RN AMD_PCIE_ID_CZN
> -
>  static int use_threaded_interrupts;
>  module_param(use_threaded_interrupts, int, 0);
>
> @@ -73,12 +70,6 @@ static unsigned int io_queue_depth = 1024;
> module_param_cb(io_queue_depth, &io_queue_depth_ops,
> &io_queue_depth, 0644);  MODULE_PARM_DESC(io_queue_depth, "set io
> queue depth, should >= 2");
>
> -static const struct pci_device_id pcie_ids[] = {
> -       { PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_PCIE_ID_RN) },
> -       { PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_PCIE_ID_CZN) },
> -       { }
> -};
> -
>  static int io_queue_count_set(const char *val, const struct kernel_param *kp)
> {
>         unsigned int n;
> @@ -2835,6 +2826,10 @@ static unsigned long
> check_vendor_combination_bug(struct pci_dev *pdev)  }
>
>  #ifdef CONFIG_ACPI
> +
> +#define AMD_PCIE_ID_CZN 0x1630
> +#define AMD_PCIE_ID_RN AMD_PCIE_ID_CZN
> +
>  static bool nvme_acpi_storage_d3(struct pci_dev *dev)  {
>         struct acpi_device *adev;
> @@ -2843,6 +2838,12 @@ static bool nvme_acpi_storage_d3(struct pci_dev
> *dev)
>         acpi_handle handle;
>         acpi_status status;
>         u8 val;
> +       const struct pci_device_id pcie_ids[] = {
> +               { PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_PCIE_ID_RN) },
> +               { PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_PCIE_ID_CZN) },
> +               { }
> +       };
> +
>
>         /*
>          * Look for _DSD property specifying that the storage device on the port


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
