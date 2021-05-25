Return-Path: <SRS0=dfbP=KU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC832C47084
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 13:46:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95ACD61404
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 13:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95ACD61404
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZlUzt4hFJXHb7Za9wEQZwTEXtz8kWQTJjpMOizTZKEc=; b=JSQOJDFY8cl0PO
	9m0nx+5nRveqgAP2FlIZtzCFb3mokBDYONA7yibF9sPkMIDNmVg9136eznvxrnXITeiHvCo+aeUa9
	bUlB6+GljhZRss+XCBnhf1PObIm8UJqLPEG1LfW8uix8JlS9bZbK3GDfvNrH3ZaiAvWhn0KSDJ66k
	ezRFL26AxWy6Y9wBzsSUmGkvL02zNzWPyGEcv9KxRhTKEk/dyP5JeEHlvwVpcunWXIHzGMLQ+7lyv
	5Q3aGx5EZkfACLPw+/azYG2SOdAaj2FCR/HXez9OjTyeyKOjvgG4+KHUZtmAFO6R6pJof0wq15/4C
	w5hJ0Qt/+HGJmsJxYZCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llXOG-005Qfw-J0; Tue, 25 May 2021 13:46:36 +0000
Received: from mail-bn8nam12on2047.outbound.protection.outlook.com
 ([40.107.237.47] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llXHX-005OC1-TW
 for linux-nvme@lists.infradead.org; Tue, 25 May 2021 13:39:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UkJF3mHU64q/24o5esc5p5qiLK0QujpBPyQunc7Hfg+H/Iz4MyggyGObAuYvYJc4TzH/5SyFpV6svXyzK9HXRkrRGcG4aTuUg/wbcM4FyQqTSA549Sx/WJuo0ju+nEY9wGm1huOpv2oqG01qmVBu28+20hZkDZHXHBnArgm4+NqEFojqo7ULP7N+QxiGXjfOMZHdPlwCTTu7wGkJBntndBjrRPN9In9xK6mFx1jro5XeKSUeU0pM7yU8mMB+HwNa6OZMXSGDFNaZMb+sQKk5ZDpdcBotXevHIMkHz4tluQjW/gYpLuSVvCyppsfQZh53rRlPt9Y88cxvy6LvJ7mDdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEzTDfhOnDPiRKREcM8R6dwAqVlEYbvhBMoVj6Pi94w=;
 b=oCng3I+eQDK7Vu0YuRpBHRIXGLYmrmTgb65krbHINE4ovL9AIqvjUs8shLzI7CSZUjT/t86YTrxkgSv1cW7Q3PNG4TKcmBIYXovKZAzjfZe2BhL7VOG4o0CmTB46Qcje9Eoog2NnHflXikV8fYI/4YQuMJ+I0nV4Pwyv52fgn7GM3d7ewyvnu2jbCrbjEnzZSJQopQlbpYPKDLJ1YjGk/HptflbEiCQlyMe8ZxOnbC6xFBvGEiIaZiou1fheXG3u5aGmQdyHR7cL69NlSkLINv4vRuK0m411kQOAtt+vffOZOwpZ2UFfMp2cpxkERdTMa5JPasci0XI60cvdXzCWrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEzTDfhOnDPiRKREcM8R6dwAqVlEYbvhBMoVj6Pi94w=;
 b=q1zGv8EvT4QA5LHAvZqSlemFrcHAVTrZ5IXW25LgIwCIdEO3NCemj0lW3mP46dijn0nxM3L1xxMsGr8IxRCb5y/0sJeKcpkN+bbvzwW2QsePdKtbtavkrwNWrBxJZd0ha9qvWHuc/fNCyGH1uz5OR2r2QJU+dMN1blv9up603ms=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4013.namprd12.prod.outlook.com (2603:10b6:208:163::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Tue, 25 May
 2021 13:39:30 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::116c:b06f:9a20:ebf5]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::116c:b06f:9a20:ebf5%4]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 13:39:30 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Christoph Hellwig <hch@lst.de>, "Liang, Prike" <Prike.Liang@amd.com>, Hans
 de Goede <hdegoede@redhat.com>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "S-k, Shyam-sundar"
 <Shyam-sundar.S-k@amd.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: RE: [PATCH] nvme-pci: set some AMD PCIe downstream storage device to
 D3 for s2idle
Thread-Topic: [PATCH] nvme-pci: set some AMD PCIe downstream storage device to
 D3 for s2idle
Thread-Index: AQHXURCjLivNyY/YxESi16LnrA/EWqrzujiAgAB4RtA=
Date: Tue, 25 May 2021 13:39:29 +0000
Message-ID: <MN2PR12MB4488679A3F04ECF3B8415975F7259@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <1621910939-24831-1-git-send-email-Prike.Liang@amd.com>
 <20210525062119.GA12561@lst.de>
In-Reply-To: <20210525062119.GA12561@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-05-25T13:39:25Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=28e4ae25-a473-472b-9980-c484bdecb03e;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.11.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12fff3cd-dfa8-4c6d-9910-08d91f8285d8
x-ms-traffictypediagnostic: MN2PR12MB4013:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB40139CF5E001E02E6F376AF2F7259@MN2PR12MB4013.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:669;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9N2phVKBm+lyL4A/D3KOm3whW/IwMnNgbUhcif1Hu2BFeuWQ5Fe47QYuW0r8jDWPIo5prsy6kA9CV3rwgWC2w/2K0DlRfeI12wnnChOxpOUxR2rX8FdF8wKkLvd0BdNo/ZOBEFHoyi3FKzOjIps+OsXO4w/mryuwb2lEcljtbIoNKvKBHMn835TQUmjPcUU+gnbSuCAyWYbP5D7xH4BO6b4egaA/sy0LpZqD6n1zbPRv522rAqQuuiim1J7EJMFpeCkAHuioJGeWCxce5qFs+ly9aLI4mscpoLKVN6sZ+TxceKLZvv4sSppJdgoGD1apzsIcDachyNLkwaXrAsLrGORiyItwWY4PYOQZzhK6w38yIVDYipoXAMu5BvYLQMeUJEZvmZu4Bcvb26OEBes2djWrblkAApROEzo+Mefeqk/P4SVPyDk9wpjT2P5Q1RCTrkwpuulbQ2byqOdbsIeDVoegY/BTamv731UYrfHa+zWbsmjRhOv0SYm91QlRGeMgrCvY+cjqf2fKOtrdjySRlQiUhqQF7fCl8ChfiOPStAXHOdQkZOfE74D73DbxfoNJmmuJw8cmFQRghSmf8kbbHenKuJ+6I+x6/8RMej/6L4Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(26005)(6506007)(53546011)(478600001)(4326008)(186003)(2906002)(76116006)(110136005)(52536014)(54906003)(7696005)(5660300002)(9686003)(8936002)(83380400001)(38100700002)(122000001)(316002)(66556008)(33656002)(66476007)(8676002)(66446008)(64756008)(86362001)(66946007)(71200400001)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?NERX/aimt2SXBvOb44Hha4kcZ67Tv26DoVHjyFFxEduTj9rlimaU5ObG1EIi?=
 =?us-ascii?Q?m7qpAaw1CpwiJCjf422VaYmD6RrPZqkYSs5XAOefW55sHg5enbicewDCQSCv?=
 =?us-ascii?Q?LnevmpYcywEwWvxgDmYJzdtp5H8HEupyU+5fTk2ROlOv7+IzX4DpJtT02OVS?=
 =?us-ascii?Q?tTjJIkky29z+nZevgjtmfjqbvfCAM9sQIgq1sgKPmDvaFMp65Fh5OZUvdfxb?=
 =?us-ascii?Q?+vKQXFNYqSftT3+VJ64ZmJTuVNFh8fvqWXx5At9ZyvtAx/Owm4tavFaF3tan?=
 =?us-ascii?Q?kqFuwDaCvHSfIS0ZRQCMpDKRWS6J2fm5WSAPcUGEOvcDsvM2O66erumaeU0i?=
 =?us-ascii?Q?Io4ssj57N3lOyOTDWojtvfmz7ttSeF0a3QynGgbVstiKMh9nQZivh+inwG0h?=
 =?us-ascii?Q?c9ghQ2Kbd0h/BFJe8yUiUHVrey7aQK+khCS0vWeonCPVZBOxYwmSyafHxvdX?=
 =?us-ascii?Q?oLPWHp4zSiYkTfA5ieTsSRHSXlbju1N6s/lphe15CZbAvvaUt2+aJlgvM6YX?=
 =?us-ascii?Q?Dv6/a2034ad3hAdWxMR52SYIlX84nPOFOFtG7BrmTFdZsbYF+rpEFWL1W+cL?=
 =?us-ascii?Q?WP7ne0axsJ6TM3aF+N2TUQeYf1LJRKfJ5gbnfqKEkR9gk8EobtirP1Pm2z/q?=
 =?us-ascii?Q?dCecfvqGIf+LGQPUH11t0tWjbcZnaq65LtLThCMmp1SY7qynp1cemOWyehs5?=
 =?us-ascii?Q?vVj6+Vim1lJ0rtECKKFA+iWzFYMXA6cikLGbsSf8LTd2qEqDbVrJjpPyNWc4?=
 =?us-ascii?Q?O5AFIOgtz0Q2P8s0UI0Qb2qrEsfRdwQvyH1Ps46kGoClflR3KWuzq9WOMFrK?=
 =?us-ascii?Q?xC7S/9iNseCKrphvO+tKYuJTZN87gKzTJTFndJrZc4cAMq94MgWmG8mn7b57?=
 =?us-ascii?Q?7YOkBq4d/MUn/gK/kBa8KtRxVYT9ug4i3Fee9zH5puchsjmKc16CbwTrMXJk?=
 =?us-ascii?Q?0HT7ZtXoHX9ItXU4jt32FFDBYGBgy+IHqGdwI3TMWx/GEeZf2VVK5r11U0vS?=
 =?us-ascii?Q?vWkK6e8F49taU5TEJbxRHjHU7PjwuGvP0I7qgGZHq7k5M99usj3gia7aTh25?=
 =?us-ascii?Q?+uywGN5VRaJoQD211Llx/oqugBbeWRZYWCrDbWVJcWFVU8iMjTfuL/fKx7oY?=
 =?us-ascii?Q?t72FkrTA67ZKmmpLdpOWMl+RF/WDHVAWBSvyZjY1e7o+tW2uPfigO26gyY1v?=
 =?us-ascii?Q?QO73hX2SvYydLDZ3PH3v1PMibYn/AVXVK5LwSbgNio88+7PFMqBWWPwX+Lwe?=
 =?us-ascii?Q?sUfYl7b4g7ADZNfWIkM6TcSjMP92n0d6uidpY2NWaD8Ju/arxC5pelafsbNx?=
 =?us-ascii?Q?8tvQRmQisC9t1oDe2ve+KAhW?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12fff3cd-dfa8-4c6d-9910-08d91f8285d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 13:39:29.9020 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lEtmyj7A08UgDcTlmrMH9ki5/egWWE0U8ixG/KuD8tamhzolAHwxycAMMH+nofiURa7BK0S0bvrsOgCTCGrXKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4013
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210525_063940_122585_AD69962F 
X-CRM114-Status: GOOD (  17.94  )
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

> -----Original Message-----
> From: Christoph Hellwig <hch@lst.de>
> Sent: Tuesday, May 25, 2021 2:21 AM
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
> > +	X86_MATCH_VENDOR_FAM_MODEL(AMD, 25, 80, NULL),
> /*Cezanne*/
> > +	X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 96, NULL),
> /*Renoir*/
> > +	X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 104,
> NULL),/*Lucienne*/
> > +	{}
> > +};
> > +#endif
> 
> This is completely unacceptable.  The NVMe driver could not care less what
> CPU we on.  We need information from the PCI or power managment core
> on how broken the power management of the root port is, not this kind of
> crap in a low-level driver, with potentially many more needing the same kind
> of quirk in the future.

Hans,

Any ideas on how to handle this at that platform level?  We need to select the NVME_QUIRK_SIMPLE_SUSPEND flag on certain AMD platforms.  This is a platform firmware requirement.  It's not an NVME specific requirement, it's not a PCIe specific requirement, it's a platform specific requirement.  DMI matching doesn't really make sense because it affects all AMD platforms of a certain generation.

Thanks,

Alex

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
