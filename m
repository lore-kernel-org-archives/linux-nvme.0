Return-Path: <SRS0=dfbP=KU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E08C4708A
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 15:41:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59057613E6
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 15:41:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59057613E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nCwaw1JWj5IvD/Hsk/XqY04no6RLqSprWomERrINURQ=; b=LeHxh1iN6loKb1
	k2D5vdicdanVuJO24hkqgZtW+Qtvcc9dJabTyFr96DG6z714qt54/Ki+D1uxQJG0L1BOiBob32cKD
	qTS6Ni4xcvpvOkQVWW8IrvVn71YU+mA+piPlOG2wQTkLPca47Gr5VClkmVT7tS5S73ZQ4jhIYP4kz
	H17VzuMWQMhZEqc4s8L2TZQrqKkNuoXZK4LAgZeknIno/dvJvblzV5q57wy7hmLxhY9Id3sEjLmVq
	E/phlNKv5Y9rFPedYRqclHm2fKD1Jh4ey2I++5mXgTMi5W6SX9z7XvhXDiN3y/I3mAa/lv/4ln6Jr
	pd6NGs8l2cw6u1/Y7V/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llZBH-0065N5-3U; Tue, 25 May 2021 15:41:19 +0000
Received: from mail-dm6nam10on2066.outbound.protection.outlook.com
 ([40.107.93.66] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llYpW-005vO6-Fd
 for linux-nvme@lists.infradead.org; Tue, 25 May 2021 15:18:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MB4PNOwz2LK7/+7WCSK+wXPDZlAvog+4ZUDj6LVM/UFcomLPd2M+TRThqFarenAuDWmdaHV/7Gcqn1+64xoAhCUubr7QHebRrC+kImjtjg+hsEZvC3O5LhSqjSs0Y+X4qcE0fKKQEmvxJA+qYY0pmzL0W3jgKxlh4EDGpF2UWJUrJaOd8hlcEfmNg+JDJLSQQJpIQTiTTz5I6pMVAHvK69UMkRm0LepcaOC4fU31+9S3XuUAAWMR1DJT0y571EKWV6mH73eI1SfgccSkrt5ZcEkmhSFo8+dphx69vdUd+A7uhaaBvzjlpN3WRXnUnzkeNR3UU4FMNBsS5KGusGbSfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypJunUxSUBkIFOnpUYwAQw+xvhbnW0a86wXF3pR2cjo=;
 b=QPIpRbFzsCdJmU47WD5U+YeNDC4IqKXC42Of5TmzwK5Wwp8iDS0HakXL2Fwu2G+fRvbbzInrg6OjTgC6QDWUKYF5nC22DktCWVNpoOblSvReJBucgMAeujNG9uN+8pzgFxjOqkOIwNyIg4u0m7qNUb4yWGyJ0Pv8HvMpf2KhL2aSW07ubXx1RoGW5CgRfupf0f9o/kdg0MkK5cNh4+CODDCSvhJUS3pUFJRJGDlf6Q8cWtLmoRYe1paURVGC8obD4l8zzn3uL0u4hRCiVEXcFVV9ILg/oX/qKr1XA88BJJxu0H9u7uWUnXwwjDIHtMkxkpTvWK7Wgpi12ACed/LZLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypJunUxSUBkIFOnpUYwAQw+xvhbnW0a86wXF3pR2cjo=;
 b=whNI2DuP50uhVb3ZtfGI2L9KQIdJsEnMLmqnvSzhTly1ZL1QSkQc9pysWV1/gzdJr6LEdOr0j3ynKUs3eGNgZ9f4NJP7TQEJATVrVqOWGz+rJNp4EqvEhib5mYbO20ESBgOpRAPFlMPmTM3lP6Izet7pXLAKhpIqCObDk/ahAco=
Received: from BYAPR12MB2693.namprd12.prod.outlook.com (2603:10b6:a03:6a::33)
 by BY5PR12MB4243.namprd12.prod.outlook.com (2603:10b6:a03:20f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.25; Tue, 25 May
 2021 15:18:47 +0000
Received: from BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6]) by BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6%3]) with mapi id 15.20.4150.026; Tue, 25 May 2021
 15:18:46 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: Christoph Hellwig <hch@lst.de>
CC: Hans de Goede <hdegoede@redhat.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Liang, Prike" <Prike.Liang@amd.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "S-k, Shyam-sundar"
 <Shyam-sundar.S-k@amd.com>
Subject: RE: [PATCH] nvme-pci: set some AMD PCIe downstream storage device to
 D3 for s2idle
Thread-Topic: [PATCH] nvme-pci: set some AMD PCIe downstream storage device to
 D3 for s2idle
Thread-Index: AQHXURCj33ZwIr9nkEeZsNaCQKwCY6rzujiAgAB6bICAAAQggIAAAH8QgAAFuYCAAAaCsA==
Date: Tue, 25 May 2021 15:18:46 +0000
Message-ID: <BYAPR12MB26939EE6323113FA9C43E875E2259@BYAPR12MB2693.namprd12.prod.outlook.com>
References: <1621910939-24831-1-git-send-email-Prike.Liang@amd.com>
 <20210525062119.GA12561@lst.de>
 <MN2PR12MB4488679A3F04ECF3B8415975F7259@MN2PR12MB4488.namprd12.prod.outlook.com>
 <cd94fd56-7ce2-e431-4a4d-6c42e5b7a9a5@redhat.com>
 <BYAPR12MB26937AE0D027A84934F7D81AE2259@BYAPR12MB2693.namprd12.prod.outlook.com>
 <20210525141631.GA12576@lst.de>
In-Reply-To: <20210525141631.GA12576@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-05-25T15:18:44Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=bb087b2d-3799-4bc0-84f5-3fb192c561bd;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2600:1700:70:f700:a1e7:c926:724c:a49a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28e9d70d-e3e2-44ab-aa03-08d91f906452
x-ms-traffictypediagnostic: BY5PR12MB4243:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4243C636F99785E5FD544900E2259@BY5PR12MB4243.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X49NKAzFk3qpVb0rnbT1GBtyixptLGbuhi8nXfh9q7GOwmr2LR+8h7LKyn5O4Jco/JgqapC5OIuIBpoDMxy2riSKUKkG2FUMujjTSH5+9Vt15Tm5gA/s0YJobnL0RFdnvxXSqA5BG+ab621iouPD/l+CVYei2kzCZgSyhEbFxADP4NyYkORc0GEb0V56ZNjy9m3DBtIOXvW0P7gZ+bLbrLO8Id7Fru/NPODGW/BNui60v3o0+I+o8GRPZOC8gD+wKtzapDDlwX2NoWNsKZr5jBZIkTTd34bk8eE5Xc9mbeAaqmrl8riIxDqB+2pksm8hRPhvlB6WqvZ5v/VJCOgJkmPyaHKoi4g1aG2II97LUArU3xM4DojSPGFKlN0p19jQRncZVw5fjOG3AFj3moWIKcoz+oVSPZrC9GJe3pRudWpsg8NIyA2lNtbzA4qeBWXTEYQbm3Oek/NZD56TOM8hPcxmUYmAoaGiB3Y/jZW73nZzB/R7uyj7Oxcs+DTByYYjUcj4fgynG8GTNVGiCYbn9m0geiq7G2N3hdNckJJxT84J1zrXkKwGfxPucrEObtY+19LK7eSS+FZlzrSm2uwajY/WIUEOL22k+vgfQ00cM7ldqmFeMBK0oITYq5fHHK6Y0jhbzEJ03dSmD+VhsGg7/AUlPqNwE+mHMMT89i+q5r9NGkBcYuV9TrT9aPjaelLwdsutZcoxAynw44Qv+cRUmetFiWls9G6aHBkoXoUNRSk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2693.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(9686003)(7696005)(83380400001)(66946007)(6506007)(478600001)(76116006)(38100700002)(5660300002)(54906003)(52536014)(86362001)(66476007)(966005)(64756008)(66556008)(66446008)(8676002)(33656002)(55016002)(316002)(45080400002)(6916009)(8936002)(2906002)(71200400001)(186003)(4326008)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?t1whXQYy7mg/DoJC7ToHnwyvLIjq1NKvjFBDG87ev7NVXVQFJ/oH1Oo2+U24?=
 =?us-ascii?Q?AEYgIFAPQXhqMqUlMNYXvl/9c6BdtgAm7r7Hg9CsVuKaHI7q3+FiztkHM4mS?=
 =?us-ascii?Q?qfVXfu0QFpVyE64S3EQJENQhAAurqiJvhlhOdEatuVX7cAVsRVwSq9eBWLWN?=
 =?us-ascii?Q?sid6WQdpcZ6tj4P2DhuEaN6eHU2K+GcPHVbdJb91w5d5cXqdls/3JyWdNtUU?=
 =?us-ascii?Q?ZdXBiRw2xFmlPFu44UkjhnAqWZFhzFCdav0sFW3j3inaTnzSj6MmFvAAT+Bw?=
 =?us-ascii?Q?94f6fCdmmsaSXrTEqOL0Ueo5S783KvsTdFFPpnfvg6kaogFNcGqpjBEGs7R9?=
 =?us-ascii?Q?VPQH5UrcDTMwxCbfMA7l7wP3c6dURvbBh04sOil5WDWNUBrhwKtiSIj3K1ve?=
 =?us-ascii?Q?KhSSNPgE5XdnWbgy0ynW+rJmxq0R/6EN0ZnyuDoo/YDsHO9WsRjN8pumwD2b?=
 =?us-ascii?Q?uhYcel/T4b/f4ryhWVIyXRlbvZoELUZ1URR6FvOTuJexmMJ6ydqFnlAHMwjX?=
 =?us-ascii?Q?cRsgfJICAKbvfW8nDw9G6dyw2QAzITQ20KBjX7d4kRgzdbeChCKJfI1zr7Ou?=
 =?us-ascii?Q?D/gmsYUklB2rHCTkw8/ouHMwJei7G4INEWePmdSTz4Fgji6bc68SBG4dks1m?=
 =?us-ascii?Q?mtySwhL5GQQw+wHrtU6HoPMRL++/NBypCW9ThuHuo48ul4yjLVwFpk1MFyHJ?=
 =?us-ascii?Q?FBV7Iqs7uXUd7jHTZ8EFihjkUQU0vmEEderAyU2KUQOj7lvHroVN9giJZnct?=
 =?us-ascii?Q?ZBZ/Iuae4CBw9LPPtJjEDZkWzlnUoSy1Iv05TyWFJiTrJmMeFdOp6DbxD2jr?=
 =?us-ascii?Q?aHGCoj+7B/SXh5sOumy5BCbV+Zah+WQwZVReHNqM9l2ayWYXOnDaam7v9dPM?=
 =?us-ascii?Q?dlayXv3jfGjdGUmieqIUKLLzIJ/juTbCGjhA3VKAJ+FV9UHpFwlOkKA4s4gg?=
 =?us-ascii?Q?DJP1IZZjfamv0pl7eB7XIqTsW2C0zC7zzVs9cXSEC4YLoW0sq2INK2aRMbyL?=
 =?us-ascii?Q?t+LZHpcyv10LH/kyJAFFFZRZgnz2QnWkvohxN560tCzcbQzklNm8zsqwsO19?=
 =?us-ascii?Q?KsbXSgnyHiBboiJByJRv8feHqGC2Ju094Siv6TUf6urEeOXpT0R3dPtXX2uE?=
 =?us-ascii?Q?qVz5nF19NOxSxjiAdQx8tX9CBJuI7S1QdAs/pJQUBmNwkN3q3wuZnHAxKi/o?=
 =?us-ascii?Q?Z0ZUXCu8aTjFHc4e/bqg36iISxWTN3WF0P6FfMHJrl2A16BF5bRdSpkHRjIo?=
 =?us-ascii?Q?lrZO2gYnaPPsiCj0Z/JjFGUHnpe5z8jbnj5YhYw9d/aBfd1jPqJDjQV+5lPb?=
 =?us-ascii?Q?wqa/UiSw8dg9gCs7D0WynHGfEuvGpWcrRiZMlarEPEan/qKmkEmETqObpj+x?=
 =?us-ascii?Q?1u82MqGTzkndlFkiQ8nA4Yr8Ey+c?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2693.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e9d70d-e3e2-44ab-aa03-08d91f906452
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 15:18:46.6377 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lp5lPq7M5OWi4NIbx72YB68LgF8kJxaxUArsPmtijrqeuS7gRLRbC6BBEtyp03nEqA1FNjZWBXZI0a1e/IPPOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4243
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210525_081850_706316_C09195AC 
X-CRM114-Status: GOOD (  23.40  )
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

> 
> I think what we're all missing here is that the concept of requring devices
> to go to D3 for suspend to idle is a higher level concept.  

Ah.. so your argument being we should keep it a higher level concept in Linux
kernel too.  IOW maybe even nvme_acpi_storage_d3 shouldn't be living 
in drivers/nvme/host/pci.c, but somewhere else more acpi platform oriented.

>AFAIK this
> comes from this microsoft document:
> 
> https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro
> 
> and spread from there.  Note that this document explicitly mentions AHCI
> in addition to NVMe.  It also has some issues that I can spot:
> 
>  - PCIe slots are not specific to storage device, so this really needs to
>    apply to all devices

I don't disagree here but I'll point out that on the Windows side that page
mentions that there is also:
1) A "global" registry key option
2) A hardcoded allowlist

>  - it generall is a rather bad idea to start with as each shutdown not
>    only causes media progam/erase cycles, but also is not very power
>    efficient.
> 
> So what we need is a way for a driver to figure out if for a given
> device it should shut down the device fully or just do something that
> is efficient for saving as much as possible power.  That can be either
> in form of a flag 

So how about a publishing a notification chain that a platform driver can
optionally pick up and set that flag when the device is probed?  Coming
back to my idea to throw this in amd-pmc, that could also potentially
mean moving out the Lenovo DMI quirk and let something like
thinkpad-acpi behave as a notifier and handle it too.

Hans, would appreciate your thoughts here.

> or by splitting the suspend method in different ones
> for different use cases.  Platform-specific code (right now for Intel
> and AMD) can then make sure drivers do get the right requests instead of
> hardcoding platform information in every driver that wants to be able
> to implement intelligent suspend behavior.

This seems like a gross assumption though that evicting the quirks into a
central place that every driver needs to behave the same.  AMD's case is
specific to NVME, particularly because APST will be used otherwise.
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
