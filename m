Return-Path: <SRS0=dfbP=KU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B690C4707F
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 21:51:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA64361284
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 21:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA64361284
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zHkD5LDS9EATqGkAiQVrI1LnCS5kyYUYczB/ZKtj2DY=; b=I8HqJUPV2aTuur
	HlTr/h7ZcmVcd9+4h1+tIVEzJTSU6CyBXUgRWsvJZr/o7sEPCKasaMnw8/kMkklcKrsZodLWmQkHn
	ZA6Lgxktka1NzFU4taZsBJOqO+mMzK9OH8lvjnauGkxDGHsqysIw5epQj8SoL/wjJb+lZ3Glvspir
	4KdeEj8R3jCwJ4URbfZSmNjTpllxm8BLnD7sCHxLEjvaU6xM4zOeqmb6UaO3+pqNxbY208xseMdyB
	0IR/7J3i0uwualgZphh7y2aTMbsCFugn74uhem4y5LaF4IFGmRfL2WKTpXWni0nKGBdfxZ5ja+FQK
	jDpZFtUXFqQ53CzLzt+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llexg-008aQy-KQ; Tue, 25 May 2021 21:51:40 +0000
Received: from mail-co1nam11on2056.outbound.protection.outlook.com
 ([40.107.220.56] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llexd-008aOj-Bi
 for linux-nvme@lists.infradead.org; Tue, 25 May 2021 21:51:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UxCAwuzMuoH+dQ/H8bCJaehgagbgIHbCNE1RNUP6etliNOxQ1Gz98ksLCbIP/HtCBJ693NR6QuissTsu+32vCK84MQgBzk0tRuwUbfFDvWWgTvNBF7jTYrnGJLEvYQ3290+XwwCeuUHymfpZmmStXTmGOrxquOkYvhOdzpFkE+lh/NnXJVrIcj9OmT/T8V72dkDiQxzew2H1pSc4t5Efiq2X4kp9VZh9qvbw148w1lDv9KZpMLlQYE2mfUET5Ta5uhcNL2qsvkLp3obTwgRFWx7Ie1RTDGH0ohPYzbfN5/hSuVS6X5rPMpiuWOTkeY1XIz4lDn1JMIGvkfI2L2eZiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VamaEsK9ArBU7I5HL2ehItRHW+gHc+kXNOcB55NuUUI=;
 b=CxnjY0cWz+AK0OFqKOWrrdGe00i3kz4n5k+Eo0aSpGWQMxkBDGvpSM6K+MZmThuum2GPkY7hW9KQZGEG8DvbnkihwNiVCEdFyOcsCVraMkBLyUuifhibLqlxJ4nd0xA7clofsYCWttVuemxb9EfepTuLqMEr9IjL3VTsBZkPSnMHyj9u/FrlT6TpW2DYbfJQhCT+Fhd5fbcHL4kb7467ocNYUIidQNL2KdP5kCL5ZKOaeNXmEFKmsdU+JiX7a6wXGpV4W6Vqp0gB02rij0A0PdhRQrm12LsmL64j53WK2slAPV92/H2+FJkBZwW0JsF8/x6038VWDA8UkdrMz4qsLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VamaEsK9ArBU7I5HL2ehItRHW+gHc+kXNOcB55NuUUI=;
 b=gs1+2HeDDm1HO8fof4f/wPUwlPdtSwF/jmkKyMBPs6jWXNYlmGWYSca/VFRQLUMWuLH18c3dXDWvsraYGnIYqqc8IYJwj62bqBo5hbzKTVnedyh4JJawPIYy5BrkhaZqmP+pT5uBFy33q7R/oVSH0VJxS9wJQJcEvUiMiCgoxkk=
Received: from BYAPR12MB2693.namprd12.prod.outlook.com (2603:10b6:a03:6a::33)
 by BYAPR12MB3496.namprd12.prod.outlook.com (2603:10b6:a03:d8::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Tue, 25 May
 2021 21:51:31 +0000
Received: from BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6]) by BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6%3]) with mapi id 15.20.4150.026; Tue, 25 May 2021
 21:51:30 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: Keith Busch <kbusch@kernel.org>
CC: Hans de Goede <hdegoede@redhat.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, Christoph Hellwig <hch@lst.de>, "Liang, Prike"
 <Prike.Liang@amd.com>, "axboe@fb.com" <axboe@fb.com>, "sagi@grimberg.me"
 <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "S-k, Shyam-sundar"
 <Shyam-sundar.S-k@amd.com>
Subject: RE: [PATCH] nvme-pci: set some AMD PCIe downstream storage device to
 D3 for s2idle
Thread-Topic: [PATCH] nvme-pci: set some AMD PCIe downstream storage device to
 D3 for s2idle
Thread-Index: AQHXURCj33ZwIr9nkEeZsNaCQKwCY6rzujiAgAB6bICAAAQggIAAAH8QgABleYCAAADcEIAABiqAgAAUzKA=
Date: Tue, 25 May 2021 21:51:30 +0000
Message-ID: <BYAPR12MB2693CDB4A7CE687DFF5E3998E2259@BYAPR12MB2693.namprd12.prod.outlook.com>
References: <1621910939-24831-1-git-send-email-Prike.Liang@amd.com>
 <20210525062119.GA12561@lst.de>
 <MN2PR12MB4488679A3F04ECF3B8415975F7259@MN2PR12MB4488.namprd12.prod.outlook.com>
 <cd94fd56-7ce2-e431-4a4d-6c42e5b7a9a5@redhat.com>
 <BYAPR12MB26937AE0D027A84934F7D81AE2259@BYAPR12MB2693.namprd12.prod.outlook.com>
 <20210525195913.GB3704707@dhcp-10-100-145-180.wdc.com>
 <BYAPR12MB269360B4259CA2699A031AE5E2259@BYAPR12MB2693.namprd12.prod.outlook.com>
 <20210525202421.GC3704707@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20210525202421.GC3704707@dhcp-10-100-145-180.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-05-25T21:51:29Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=9f98419d-6ed5-4eea-b342-6a3f4debf4c3;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2600:1700:70:f700:a1e7:c926:724c:a49a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79452f83-d5b7-431e-7e7b-08d91fc7419f
x-ms-traffictypediagnostic: BYAPR12MB3496:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB34965D281815E30585809D7DE2259@BYAPR12MB3496.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fEa9wnsBz9yRjaGF54SpVLrZZgohS8oyQHWZA3d0IlDg1FR/GO9+/5yQC6BYM32MSUJVIfYA7E7BUlbaE86OLoqRar4eYE0ys4sxkQh3TrdRWrNgpxrzQYFDLjvAYAS/rVsnTdDgNAYmlmBEMsXslc/PG9Z9jGeemC3UdceRk7y8kt8p9N9t4zLnu+3g1RuCuOt8Sf/vke2CeUwtzhujmWBHHZAbpVOnAbXXIZ8qLqUzcVX72duS8YkXUn/CdpzAMAz7eL37SO2CDYbpECVDY4PUQqFn7t3hnSpgQ+JNcdLskckulbAmzkyH07K2wzZz+BD3crbtjtdwtoaC1XxXOlLgb8YqKNE4TIKJml5yJly0XoEbw2pdZSVyAbBz7oAlDk3zSjyXg7R/ddJW5petR9Wz6gbFAfjNabLQFPdCLIh/qoAK3mn/F/ngCIj2L4LC5VeU1yS5jngBlog5BsiRBHI5++gH22d+rbgyFHaKiIKqsOJ2X0bzNRs0m5wKIr2w43RNk9k5/gWAEBNj0d2b77IPMyI/dJNjuwFrj8xs1Oi3bMCtqSoHTaM/co/9tGHXR1Y90kUM3dujJm6/24czz+SbSL6YcQf/jpRupfGKAmA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2693.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(186003)(66446008)(66476007)(64756008)(66556008)(33656002)(66946007)(52536014)(86362001)(8676002)(8936002)(6506007)(53546011)(5660300002)(9686003)(122000001)(38100700002)(4326008)(316002)(55016002)(6916009)(76116006)(83380400001)(2906002)(478600001)(71200400001)(7696005)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?7LDUswFEipVAoTK3N4J0dOXw1+CSN69LHsTI4k4hYqynU/X+fWBI4vSU1iI3?=
 =?us-ascii?Q?SESoJFeYEeSYk01XZOEk6FKg7iMcvM/ychGxu6bcUoOfHj/nBzuOlhMb9bl/?=
 =?us-ascii?Q?sXitWHTJop8tucDVfeAyqgLo5vblPsWAdsl9spRXBDTjVoHoVSI0jHjA6Aif?=
 =?us-ascii?Q?lmaSjon57NNiqTfZdVyqu5aKbUBMSPpJLDIOUv4wt6HI8yOz9Sv2QFP2oNZ3?=
 =?us-ascii?Q?57v96UrvKiRmKMSy78WHtio3ICrIiMMIDkY1bBwR2jbp5hyxoCNbYOt2MHyl?=
 =?us-ascii?Q?bozmC5HqjdDwCfJ2ikBPHgnBk4N0p+sxb58i0dFByDi9sdWspQl1MUkQMb7k?=
 =?us-ascii?Q?yxzbs57rY0YW1Lxb4fu6oXpBsVcmyeDzjssjFBbb4GxAUZPpzVYJWTpErBLY?=
 =?us-ascii?Q?wfib20/oSP+WSLX7qbmK5GZ2kAyScYolZDOd2b8J9vZP8jOi+vv+O93deUmb?=
 =?us-ascii?Q?p5o8MU8Nu6jxqPYIoG2pGSuIJzL+DCLYxQ4L3dhpcHdOAs3rPPlLMQjBU6+Q?=
 =?us-ascii?Q?2wG0V/nH4xt9+sT7HbGXkX+yX7GJLFQDllKCfp2idzd0cAtjI0BX9lSHN8Z3?=
 =?us-ascii?Q?d2L/b7yTm3KipNuTjwH4QMZRoy4KB62Idg2ptl0GOLNscjOBb6P4q6OlGdeg?=
 =?us-ascii?Q?UFg2widxELBymMXYekthP9Y2Ec40LsgrXE89BhI3q+op/l1JCiJzNjONnGpv?=
 =?us-ascii?Q?vknVKvEg3uoFiY8VgAC/WhqTeHimylZUaboXLnHMfCaTtatFFaSlh4vU93Z9?=
 =?us-ascii?Q?Za+MKYtrttA1hXyEHJbgbBlG7C16zh2DRdOh6thB0KOiHrwa9ymcoQOeUesB?=
 =?us-ascii?Q?ATCu1IeJCYfMX3cqmnLcVc14mwWSvlJwMziZMUdAZdDzCuMEYRSledfEjcgk?=
 =?us-ascii?Q?I6ypkRaThSXvGIW/7U/HMMLR4pyCdipDtYHC6h66tr85nPknwKM6EHIx4Ijw?=
 =?us-ascii?Q?l+gSgQWbnMN5FuIeBOJmrGpMlIwsMH2la9uTzcrRnl06nY3kdRobTWxiKm3+?=
 =?us-ascii?Q?VATpgAjz82/mkRJMcrBScMqzFm47zqtvcNpqT8/Dn9kYOcgpfzfm4ioedx9U?=
 =?us-ascii?Q?qjwAw8emk4VS9vq+SWwv+CDO7E/vCM2wigE+A/Wt4GoFF+yI+6y8UaRb+Djw?=
 =?us-ascii?Q?zx4wHY8R5XChplWvEdrFgvCDMxhov9YcpYURKYrfMR3W/kHo6EPMYysoFaOu?=
 =?us-ascii?Q?gfYMaQjxZXdCcviQXpW4I/XOSCNf6TFxmnYkn2zI+fve/AK/+oOg3O09y5zQ?=
 =?us-ascii?Q?wzSUsb63MCp2npnMDeZ6Tx+CEzeIZvTw8L/cBjRqT1H1xvP3alDSfegQvNwF?=
 =?us-ascii?Q?J4KGgLILjTlRiSwJyJCo/EimYf7Nn5vimDS2X3mp5OdQhEhJbc0c2+HCw6Yt?=
 =?us-ascii?Q?PngQj/O1Xf5kXgAzZGDya+L+oHLo?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2693.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79452f83-d5b7-431e-7e7b-08d91fc7419f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 21:51:30.8860 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LJYAjf0gBGc14tTRvwy5RVLGhWFcA9wcevOugm5wPH9uHkqjIRTglbx28dZoh1wU06DD6t1tYTX1kCM1lmUhPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3496
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210525_145137_427510_0B16CC72 
X-CRM114-Status: GOOD (  28.84  )
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
> From: Keith Busch <kbusch@kernel.org>
> Sent: Tuesday, May 25, 2021 15:24
> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: Hans de Goede <hdegoede@redhat.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Christoph Hellwig <hch@lst.de>; Liang, Prike
> <Prike.Liang@amd.com>; axboe@fb.com; sagi@grimberg.me; linux-
> nvme@lists.infradead.org; S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>
> Subject: Re: [PATCH] nvme-pci: set some AMD PCIe downstream storage device
> to D3 for s2idle
> 
> On Tue, May 25, 2021 at 08:09:02PM +0000, Limonciello, Mario wrote:
> > [Public]
> >
> > > On Tue, May 25, 2021 at 02:06:09PM +0000, Limonciello, Mario wrote:
> > > > "Then the NVMe device will be shutdown by SMU firmware in the s2idle
> > > entry
> > > > and then will lost the NVMe power context during s2idle resume. Finally,
> > > > the NVMe command queue request will be processed abnormally and
> > > result
> > > > in access timeout"
> > >
> > > The nvme driver explicitly checks pm_set_suspend_via_firmware() in order
> > > to know if firmware may manipulate our device after completing the idle
> > > suspend. That is returning false here, yet firmware will do something
> > > anyway.
> >
> > pm_set_suspend_via_firmware is not set during s2idle - from
> drivers/acpi/sleep.c
> > it means ACPI S3 or ACPI S4 and thus pm_suspend_via_firmware however
> would
> > not be used.
> >
> > Overloading this definition on these AMD platforms to solve this NVME
> problem
> > would have unintended consequences.  Just glancing through the kernel I
> notice
> > the following drivers make use of that for decisions, which I would suspect to
> be
> > problematic:
> >
> > * cros_ec/gsmi (on any AMD chromebook, EC might receive wrong event and
> logging wrong)
> > * tpm
> > * i8042
> > * amdgpu (would break DPM_FLAG_SMART_SUSPEND)
> 
> Would it be less problematic if we check pm_suspend_no_platform()
> instead? According to the kernel-doc, that returns 'true' when
> firmware will not touch our device's power state, so it should return
> 'false' in order to be accurate here.
> 

At least at a glance to me this does more accurately reflect what you're
wanting to accomplish.

> Note, this is always set for PM_SUSPEND_TO_IDLE, so we'd still need a
> quirk to override it on this platform, but maybe this check doesn't
> have the same clashes for you like pm_suspend_via_firmware?

The thing affected by it are ACPI EC and pci/pci-driver.c that skips bus
mastering PM.  I think we'll have to have a look whether or not that causes
problems for wakeup and downstream devices.

Another way we could consider to go about it to try to get all those other
drivers that were clashing to use pm_suspend_no_platform instead.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
