Return-Path: <SRS0=7k1C=KV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A97C47088
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 18:36:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 071BB610A6
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 18:36:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 071BB610A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=epalRrsWTz8QjIaeBAIQ3S+nvQq2aUC5eyKCicpcZ3o=; b=E1sZvt5G8jZLQ7
	+dSLVJ+RrxowMfY89dh9uQVr1PJlyXAd/BX9xOLj5AEmlQVEwej6q/71qmz7CTnqaCP2JzhbbnUFV
	BGiYKQTLGxFO7iOSV5x1BlQdFuxTSbD5aDLDW/NZnYOiveO6RLPuAdpFLNjn1vraWsOotc5q8XpS+
	TLwkEcyDfRQcIeQTCcD5OdlqkJtuquumk6tX++R4qf836wjgyf52SoQ21Nsigrk5127wUqz/uH/Ug
	1hvJfoKw8Wxo1q5cpgRPYTgjPuBHHwAKULp0+zFMzT/bdACO5TAfDvXKhOeYNvugamfj1Cm59S6xj
	3F5w3X5/TK1cuTRkWl6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llyOI-00GZhb-7A; Wed, 26 May 2021 18:36:26 +0000
Received: from mail-mw2nam12on2052.outbound.protection.outlook.com
 ([40.107.244.52] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llxXh-00GCi4-9r
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 17:42:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJ/RLOf8MPHkk0vTECDSargv/6XLfR5XXSUsuOoH4ucodJqZwkpQ/TA+IKwJuv7GT3fv+3m2CHOS5rgNXn43EyPYQz9rd8zyWhaynX92elgaNYeu1dsYESnB95DNYPa54rlq6YHFrO1Pdhm0TmNaZdX64Krtt+m1FlFgiPd7ISa4foXa9XEfzlv0jUtwmdl5Xi8ceeTeb6rOrU/WYTECXvD/Nzu52o1P/UKFJFBpIXniEGrh8ZxPxVfP3m5J7GfgRCI4k9Sa45htXdQ3CXqXkiMCo3xnUuWxmP7q0/6QT6p5+XZdq2PYmZHXLwCayh7Nf1+2sqwNGfGGpML629cEtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8D0T8/ZAU0wtSMUUuPFES13YoZJ0P7xVNR+4j+oVaY0=;
 b=mP0wJ7TaS8Vlg3z89yFfcjCZla2YmEh+9e2W4sh6EUzXvdXEgKJez1glI7bfYDcCd+F0h/FDNkIjd5fPl8NwtYDG0JCHXFdRE9zIQ30Hg8YuptJ5iTxmVT58UFGqmJL+kurwwyfxecFRRkuFFziKhKV7lR2nCSnhwFgKcT7EFKA8/p9zaXOkO/fPDBxF/ekpF5WwvaFafXap9HkO3yzfYwYFc+6AggYqzNXLQeNZoFDpKHk4lBdVgvscqbCod6Gcinxy/BMBRSHvN9BCAMg+N+ottVCFuOX93cgoEhQIjcWY0I9p5MLIG2O4FfqZJjYYYYMWZMy4P5EbsHbd9B9fXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8D0T8/ZAU0wtSMUUuPFES13YoZJ0P7xVNR+4j+oVaY0=;
 b=5XlcPOKKD5tQL5q9TZipy9ZqloerHwrm86QVWp8+/MlzULwV1LIgdt/v1SwdrtFuVb4BpjG/rrYJfEmqzLSpUumap79K67fO6cbOb7emJLy6NJGSiBQcG4EdMSE/WjFdAcDnA0skkehslC1kq+zHjVSpSoW9C2E8/z2Axa1hszU=
Received: from BYAPR12MB2693.namprd12.prod.outlook.com (2603:10b6:a03:6a::33)
 by BY5PR12MB3764.namprd12.prod.outlook.com (2603:10b6:a03:1ac::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 26 May
 2021 17:42:02 +0000
Received: from BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6]) by BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6%3]) with mapi id 15.20.4150.026; Wed, 26 May 2021
 17:42:02 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Hans de Goede
 <hdegoede@redhat.com>, Keith Busch <kbusch@kernel.org>
CC: Christoph Hellwig <hch@lst.de>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Liang, Prike" <Prike.Liang@amd.com>,
 "axboe@fb.com" <axboe@fb.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "S-k,
 Shyam-sundar" <Shyam-sundar.S-k@amd.com>
Subject: RE: [PATCH] nvme-pci: set some AMD PCIe downstream storage device to
 D3 for s2idle
Thread-Topic: [PATCH] nvme-pci: set some AMD PCIe downstream storage device to
 D3 for s2idle
Thread-Index: AQHXURCj33ZwIr9nkEeZsNaCQKwCY6rzujiAgAB6bICAAAQggIAAAH8QgAAFuYCAAAaCsIABMVKAgABimACAAAKygIAAIsowgAAH2YCAAAPg4A==
Date: Wed, 26 May 2021 17:42:02 +0000
Message-ID: <BYAPR12MB2693325EF411E524EC5B5465E2249@BYAPR12MB2693.namprd12.prod.outlook.com>
References: <1621910939-24831-1-git-send-email-Prike.Liang@amd.com>
 <5734923.lOV4Wx5bFT@kreacher>
 <BYAPR12MB2693CC654BD9AC2409AA556AE2249@BYAPR12MB2693.namprd12.prod.outlook.com>
 <2603488.mvXUDI8C0e@kreacher>
In-Reply-To: <2603488.mvXUDI8C0e@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-05-26T17:42:00Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=2b2e6378-9fe1-4220-81bd-c7f9133a5aab;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2600:1700:70:f700:a1e7:c926:724c:a49a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55a6c4a7-f230-4d50-785e-08d9206d9209
x-ms-traffictypediagnostic: BY5PR12MB3764:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB3764FC9084B17E7C3B0C0C7CE2249@BY5PR12MB3764.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NApmipObO20I3WuOVLygzEDq9Czv/W3UOfB6mScPyFk48StQsrgRrYdbJIwO2SS//DVwgKbZyyG2yB7h9FHR5jh6PdpgFnnaEubUrH0RgFEeY8GHzrs+V06fxuKLy9Chd/iEWhakxHN83zQY/1TE866ckTjYR8af+LlluJ9dwnlZwT7MxHxJEnNKk/DYC1LeW6w6zmPJn6+OTMKJgqAFlaU+glvhtcLDFEgDjp6dZ0iyntYFR4s1OErNGSIcEy8ACTRnIC0Lb5ZmCwPGcrqReleu14LTytA/NnsKcHzlnMBCRJ8OsVEoBc8opZlOZlO6RHLldWjZ6B7Lg7uhpoVKqO7V4rEhplyvRCBQ3ve+wd1mviJFB1hQuGYnZXEtYw58bpmLvhDM9+qeuEiWA0rhsKOkUwwwIfLDFkzntHsGrswoivLCF5vVLja1dUNfanfzmQdHozA3j94wZ+rhfrPxc9bz/c84Sve5z1MQY0B2sM2vbHYK4RFSzUNCDTs2allBtkhq9nSc+aK5pbiawEjIS4oP3Bb7IcegA8cgXoiF1Ykp8lnZ5uRU+zG5uY4Y1+8kZJzgfpbw+SyqM9uCaxXXCNxDB1PmS4BeNEvWup3rVVU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2693.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(316002)(54906003)(6506007)(7696005)(110136005)(53546011)(8936002)(122000001)(38100700002)(2906002)(33656002)(83380400001)(71200400001)(8676002)(4326008)(76116006)(66476007)(66946007)(64756008)(66446008)(66556008)(5660300002)(478600001)(9686003)(52536014)(55016002)(86362001)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?K2tKcGUwWEhic21JZG1EZWRlNURodEk2K2xQdVhuSXdUNEUreTJNcmdxbUZ5?=
 =?utf-8?B?NGpZa2x3blZQdldqZFQ0S05NOENFS1hUZy84ZXBHaDlKbklyT3VEUkt1Y0l1?=
 =?utf-8?B?Z2I0ZDZzU05rVnpxVHp6elVQb0ZpV2xqZXdvd0JvVUNobG5zblQxcUhPV3ll?=
 =?utf-8?B?dzBlZ0I2TmxCUVhTaDVFVGYvNHp2T2dkVk9lejNuTU5DTnBiVTZZaEhuRE90?=
 =?utf-8?B?Zkh4L0VPR0txQXpic3dyZ1JIODRudnBIYlJPMVNadFBzY2gxZTlEM3dXNjlI?=
 =?utf-8?B?Wkg5YzFYWkIrVHJKK0doVkZ3dG95ZzJORjVBSXlMRGQ2cGRBREd5Z05HOHBm?=
 =?utf-8?B?TnhMZDk0M2Zld1lqaGtxOEZ4NFI1a0dLbnhMY3dObTM3a1lLYXlBSTl5NDJr?=
 =?utf-8?B?dSs5aWJwTmdiT2tHR0RDbU5acGY3ZEdqRG9DSHFnN1F3WWFxcndJNFN2UlZt?=
 =?utf-8?B?UktFNWJVYWpiR1g0Y0s3RVBFZHZuU1o2UXV4VjN1MEMwOUdwTGhhYXBvMGpG?=
 =?utf-8?B?TUtjU0lJWUliVEdIQUZRWkJ4T01VRFErNFR1Qmc0SXdHNlZNQTRIMndwUTk2?=
 =?utf-8?B?SzB3TGU1N1ZhbFg4Q2taZThmcDhCTms4cTFuVC9YRFU2YUljK2Fad3BnZE9E?=
 =?utf-8?B?RktBcFlmcWtpQjh6Q3BFeU5yN0k4YUpyVmdzbm90UjlDSlB6Y3FmS0RaUHBj?=
 =?utf-8?B?bWxCVlRwMVFrM2pWWC9qOE91aEdhTnVHWWw3RG8wM1ozckZFKzB5aGtSd1My?=
 =?utf-8?B?OWZPNEdZRnFURWxwMHh3ZDZyMmNmSmoyOEt0amZQUC9nbkN3MC9ONldWd2d4?=
 =?utf-8?B?VkVaM3ZFSWpPa2VHcmNTdDVGOVE1a2tydG1qQ3JlR1kxTzZTTStHQ0MzVFJs?=
 =?utf-8?B?R1FiZ0JHSVh1eTdTeVZIUzQyMHFhRzZwL1pPU3pPQzdJQUpRR2JiR3hvQ2tr?=
 =?utf-8?B?TFVFWDBLYnkrN2JmM2tPWVFXOGcxRExBaCsyR0pnR29yTGtwUGdmY2FvMThZ?=
 =?utf-8?B?dzExQ0pyeWJkR2NxMm9acEw5dFFGQjJDQXNGcDZQMmpwRUR3b3BXcC80NWFp?=
 =?utf-8?B?b3VQNXlicG1qN0JoalFiTUdxa051RlFyL2piVHpJbGdMWWFaM1V2N2dnQmJk?=
 =?utf-8?B?Und5aU01d0JRV2ZvMmt4S3oydmZMYTR3TXUvZklKV2VZS1pQNGJ6OW5SVE9j?=
 =?utf-8?B?QnZzWEo2cmo5VkZqZmozeXlXM2dZMytmSVk4bWNuaFNYSGpVNyt4SDdYcnl5?=
 =?utf-8?B?dVprbUdpOWFnSkNVZjllclhuS01JTXZoSnZIeVF5cU1jN2V6bVVyYzV3U3Iw?=
 =?utf-8?B?MFFXYmJaV3JsZ1IvZlYrNkg4Z09KQ1ZIMllIRFdsVjdENG5mL21rVWRwVzNG?=
 =?utf-8?B?Y2poc212SDFhZDRpRmhQMzA2R0NyZlVUQ3ErcFRQTnBvNnkvZGtRZzQreDhw?=
 =?utf-8?B?UnA3dWcwaHJsMFJVSTR0eGJjVzQ2aEM2bVIrcTd3UG5Dd2FGejUzRjV2R3ln?=
 =?utf-8?B?WjRReFBmWkFFWkpWSGdtMm5wdEdwbDN6REtCYWhidXNhRWozcldudmVDWU5B?=
 =?utf-8?B?KzdIcmtlVnl4ZGI0VUxLSWY3YzBTYkhxeHZNNGMwMnZXMzVjLzlKQjAyR1Nr?=
 =?utf-8?B?QS94N0FiVEgrdTRPT0ZXV2gweHFYUGI2Ynh0UklvNTR1MlVEMzFkcmlSZ0ZH?=
 =?utf-8?B?RlBFNXh4aHFrbkhRSmt3MGRUNTFwbzdGaG5qbU9saklSRjdVemwzWjJIUDhj?=
 =?utf-8?B?cVk4ZVJWeFlNZFQ0ZkRzMTFUQmFDc0FycnVLOXJkNmlxOXllN3MvYVBXOU5z?=
 =?utf-8?B?bFp0cStrbHp6SDd1RnM5UUIzV1NvQjQyRzRPd2RMMlNWOFJSWEU1Y3VYWXZC?=
 =?utf-8?Q?fXwN+HQ3khVDH?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2693.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a6c4a7-f230-4d50-785e-08d9206d9209
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 17:42:02.1445 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L1fl5//A8SUQrxaHXkvHNmlqbQ1kbg/37UUFHaaMIHDwnDotM0XLJ4h34W8udbg1ocguSrIPAAYUlUEl9QSDkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3764
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210526_104205_384249_63865F4A 
X-CRM114-Status: GOOD (  32.69  )
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

[resend without AMD official use tags; sorry my email client likes to change this constantly]

> -----Original Message-----
> From: Rafael J. Wysocki <rjw@rjwysocki.net>
> Sent: Wednesday, May 26, 2021 12:28
> To: Hans de Goede <hdegoede@redhat.com>; Keith Busch
> <kbusch@kernel.org>; Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: Christoph Hellwig <hch@lst.de>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Liang, Prike <Prike.Liang@amd.com>;
> axboe@fb.com; sagi@grimberg.me; linux-nvme@lists.infradead.org; S-k,
> Shyam-sundar <Shyam-sundar.S-k@amd.com>
> Subject: Re: [PATCH] nvme-pci: set some AMD PCIe downstream storage device
> to D3 for s2idle
> 
> On Wednesday, May 26, 2021 7:02:08 PM CEST Limonciello, Mario wrote:
> > [Public]
> >
> >
> > > >
> > > > For context, here's the summary from my understanding:
> > > >
> > > > We (linux-nvme) received a bug report that a platform fails to resume
> > > > after idle suspend due to mismatched behavior with the nvme driver.
> > > >
> > > > When suspending, the nvme driver checks pm_suspend_via_firmware(). If
> > > > false, the driver assumes platform firmware will not alter our device's
> > > > power state after the kernel completes its suspend process.
> > > >
> > > > But this platform's SMU firmware will remove power from the device.
> > >
> > > How exactly does it do that?
> >
> > It's running as a result of a platform driver notifying it to run (amd-pmc).
> 
> I guess this happens in one of the amd-pmc driver's system-wide suspend
> callbacks.  Which one?

IIRC it should be caused by:
.suspend_noirq

> 
> > >
> > > In particular, how does it get a chance to run?
> > >
> > > > Since the driver believed that wouldn't happen, the driver did not
> > > > prepare the device for this powerloss event.
> > > >
> > > > It seems that the kernel's assumptions around pm_suspend_via_firmware()
> > > > and pm_suspend_no_platform() may not accurately reflect what the
> > > > platform's firmware actually does.
> > >
> > > Note that this is not about whether or not AML will remove power from
> devices.
> > >
> > > It is about passing control entirely to the platform firmware at the end of the
> > > suspend transition.
> > >
> > > If instead the kernel executes AML that happens to remove power from
> some
> > > devices, that is a totally different case which should not be confused with
> > > the above.
> > >
> > > > I do not know of a better way to detect if the platform will remove power,
> > > > so I'm looking at quirks to suppress PM_SUSPEND_FLAG_NO_PLATFORM
> for
> > > > this platform. I'm hoping there's a better option, though :)
> > >
> > > Honestly, I'm not sure about the clear understanding of what's really going
> on
> > > here.
> > >
> > >
> >
> > We'll discuss internally and come back with a different proposal.
> > Thanks all for your feedback.
> >
> 
> OK
> 
> 
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
