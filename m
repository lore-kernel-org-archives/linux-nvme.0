Return-Path: <SRS0=7k1C=KV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1C6C47082
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 18:31:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1BE8613AB
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 18:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1BE8613AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dbBrfUUmXv1V1Y83w/rUx+Ys8D5Ed1yOdISWExUL1kw=; b=4C3HdQFCh6yvgI
	gO464mde4pkGQsbN5z2EdIa9nU9GuK/6aiGOsFdstIoALONCORaXm1DC1P/Xqt5lCz+mLTuBSdo07
	XzN/bjaIZ2DBv1+NZaJPmeykVHYWdh094n6fpprcvy1yBvBWXD7CcXVAceO40Uuw4IcdPcITyaHO2
	FvhPqtQKDbGCF7RS0IwHzuGKR+WdJRScMjmrH0uyYUBHvs5VtPr92iKTYrnYvHywo8Wnh2ZG0k9x+
	qCf5TUWMxu6Ouwpyi6oKYP2eroMhKU6x/ylLYmg3seOSsI6Ua7YdCkE77ESzG27T1hJ9qdvPqeABN
	XOwBt5IfYcis7lXkSZqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llyJN-00GXg4-I0; Wed, 26 May 2021 18:31:21 +0000
Received: from mail-co1nam11on2079.outbound.protection.outlook.com
 ([40.107.220.79] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llxOG-00G8lv-OL
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 17:32:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9tzfBptS+RDZuhSPWrguqewS3uUKXzMInEULTDUCEyaV6ZXYYzMp19toNJoBHZxSpRoDlCjtHBaj0Nmgt9U5Mkbe0lXwSISc+NnoFqB3pobT1B/RHVGuOeQnlvkPYmzusalhU54aqrQ1/iq2W1kfQUfyMrIbBuJ+/7EiNbjoKDGJkmt6gVdpBLBhNFn77ajgeTfH+GlSXnk/S4HT3enGSgHCscAWi8fFKZzGoSN2A+FIfIoY3waLTOOOmPJW53vsxrIpDbhUYFXiTclMDS+rfW4obh0MffRhf020MQCVVHT5tQ32WCTZzCBCE7TtpNDENpfBfQCvNqYhzJp2c+eCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuqGAdANEFpZTmpbIvfaXi/hfBy9IfI699wY2HxYiSQ=;
 b=NnuB98WR8+k7gCOn4LPAqvfc9x0FMl3GVw1laqFXictRM6BjEiSRiPda+g9tcYeiZLOPZ1zlxW1V/OQrkNG4oa5aBwUymSHixrnfiBY5giZKFPDd1vBjVGI36OVwlBucw+pxQHz13puGEALZSnuhnQn9rW6nxUixkPYwsoQcCrB2AseVvUWzE4bHTYO8ZweTjhjpdy77y94OLYcalBv6aAeXFW6XW88E1hHSejrOfGe92lYrsh/CvkL8DepnDkZjU2qdQ/TzLhUNJCYL/b0pyFL5JNUWL6TKk2C8XDZ69V2TtIQYs6QfY5XzPjOUXm5nUyJwZZ4GoOYcMj4xZt1RbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuqGAdANEFpZTmpbIvfaXi/hfBy9IfI699wY2HxYiSQ=;
 b=IMsS4OLEHscqHIH4n4RonBVB2GemVzKQKyU/IglOnXqejJP/FXkSC8HhLh5FV89osej6hbvk4BsHDIwps5l7PIyVb16U9YrK6BptTVFovJ1B4EsFKjzbSk92P0MjjgmJyQqCy7yQoprLOXUmvzD6lXqGPECULnWKkgH3ojdPaNs=
Received: from BYAPR12MB2693.namprd12.prod.outlook.com (2603:10b6:a03:6a::33)
 by BY5PR12MB4819.namprd12.prod.outlook.com (2603:10b6:a03:1fd::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 26 May
 2021 17:32:16 +0000
Received: from BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6]) by BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6%3]) with mapi id 15.20.4150.026; Wed, 26 May 2021
 17:32:16 +0000
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
Thread-Index: AQHXURCj33ZwIr9nkEeZsNaCQKwCY6rzujiAgAB6bICAAAQggIAAAH8QgAAFuYCAAAaCsIABMVKAgABimACAAAKygIAAIsowgAAH2YCAAAEGsA==
Date: Wed, 26 May 2021 17:32:16 +0000
Message-ID: <BYAPR12MB2693A58486D71B6B4AB6B8CEE2249@BYAPR12MB2693.namprd12.prod.outlook.com>
References: <1621910939-24831-1-git-send-email-Prike.Liang@amd.com>
 <5734923.lOV4Wx5bFT@kreacher>
 <BYAPR12MB2693CC654BD9AC2409AA556AE2249@BYAPR12MB2693.namprd12.prod.outlook.com>
 <2603488.mvXUDI8C0e@kreacher>
In-Reply-To: <2603488.mvXUDI8C0e@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-05-26T17:32:14Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=2582a7c2-9afe-4792-b690-3ed1e91aedf8;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2600:1700:70:f700:a1e7:c926:724c:a49a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c8ee165-08a1-480c-0d83-08d9206c3500
x-ms-traffictypediagnostic: BY5PR12MB4819:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4819ECA24B6EE4C2178BDEF5E2249@BY5PR12MB4819.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r1DFlua6Rka4yOuocYKZIulevHEVtzY/aCb0/PGxH6n93w2ldsEtd20buJbgd9z52Wb6Fm+ZQEQCgyxSEzc+Jr0uknm40SA9L02j6g3wbqum0aWtX+KXZ0KMvC5tgteDeTs8cINy7RwIfMrcbcc0fTltmuuaZ0P1TBrlfJTJ9UeqGhy/zQRR6HTN4DheCWyLr698mPgbWzWIwMa+jbor/KU9daB2FHyEKK6x83Oeurbqt8qjBzBVqOlK3xNkeDxowiJq7QfF5wLzg5UaDdo7gMjdO11VE/AdATgBnqlznO4CNjb9HT1PCQrviEnvdXoppJL5sJxumNMide3SYTuOxV9mQxuvD07uvgZ6Smic+js30j52oeg9QPJWXar0NLr29rf8IGwKaoZmw6hx2Ca8T+cw/4e3bS8iDjf4z1dmsyOfg8FY4wEZ0f7cIwUxQkA3NDo+o6tNZ94PTH3SnoaQ5wcH9p9VeBk8QPTeyoIEyg9iQrHyzEoG+PK4sNa/qPlFMHd4ZL24vA4Gy/yh8mC5uCsPJmUi3zB0wV8edI0uP5pruacIQINAtEWIXOLVk+OurUedIaUSebLZZSaGfuBpFAuVt8kC1uIS9UaYBMiEP9Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2693.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(64756008)(66476007)(66446008)(66556008)(66946007)(76116006)(6506007)(316002)(9686003)(83380400001)(52536014)(110136005)(8936002)(86362001)(54906003)(55016002)(4326008)(8676002)(478600001)(122000001)(5660300002)(2906002)(33656002)(38100700002)(71200400001)(7696005)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?UnlXRExYNWU3MkJqOTc1RFo1NkcrTmdmUmtyRXVUM0QyQi80c2h6dGlmdExW?=
 =?utf-8?B?Y0M1QUp6ei9FdkxCcEdETVptcWlFbnlaWUg3SC8vdjQ3Z216ODUrQ0ppaFZM?=
 =?utf-8?B?dTVVRnVkUGtqVHJoTmUzODZ2VXF3MEdFM0FKQ1RkdmVYY3JmRmFYZGVJVnVW?=
 =?utf-8?B?bVlaU1JsSGh6aGpWMXpZMFdXcWdPNHQxV01lV2hXL0QwYWx0citJdGY1aXN0?=
 =?utf-8?B?ZWhqUHl4R2N2dzk0YzI4a0hjbjM4VjNkWFRvcDg5czIvMFVkb2tsUXJjUnBL?=
 =?utf-8?B?MVJsZ0U5YXVheXd6OGdqbll0NlJXdGNuTWFwWHU3VXhkaXo4aXBKVERSTTNa?=
 =?utf-8?B?NG55VXpwcjBQTG9QdUJFbC9QZlZlakFId1FqdmRJczRHTmVadTBiS2R4ZmZy?=
 =?utf-8?B?VFAxY3kwdjdEL1J3L1h6NU1GMHdWT2JiSHNqaktpaGlqaUxXck55MlVnZnBX?=
 =?utf-8?B?VDVPajFLd2FtYlg1c0R2Znc1MUM3R0NqN0RZbi82aERxUVc2ckFaQThIcTh4?=
 =?utf-8?B?eFc1ZDBTLzhEaEtvdU1FL1NObHR3MXR0Zk9DL3VGSDVGZWQ4ODAzS05Kbkg3?=
 =?utf-8?B?Z0FBU241UW5KcHZRaWc1andyanY2bGFMc3dBT3pyTlZQcmNPVFo1ZktkMjZM?=
 =?utf-8?B?dW53WDIwTjhhNUJCNTZ2dXJla1VDUjNwRUtmb3ZQT1J4Y0VOU0ZQNU9NNis4?=
 =?utf-8?B?cnhwTm5NUUNBZmhXdDFJTURPeUlVZytZN3RRUGJTejhXNHBtcHAzMjZpckJu?=
 =?utf-8?B?b1doS2R2VEtoYit2dUxLdWt0V3orcnFuVlRpdkUrSnBlbCtaTVVjaDFiOEFO?=
 =?utf-8?B?VTRBbzQ2MHdnRnZaYjB2TjMwbjVpWStycWIySFRKUm5RSUJaSUhNUDI4REZ1?=
 =?utf-8?B?a2d6V2ZHUlZLaGhOY0xQT2tQS1U0YjllT2hvRDVUU3ZIM251YmNna0hJNlZx?=
 =?utf-8?B?UXYvU1hZd3g2R1UzYU5QQjRjb0x1NTdlb3BWemljalVXdXEyZzQ3c0VPRDlt?=
 =?utf-8?B?N1dhV3l3VGJDcUhpR2lZSkhzMmY5YVlYaVBCL1A4SHI0dk43WlV5M050bVVQ?=
 =?utf-8?B?K3VuWTRKMDlvRDk1cDhBcERxUFZ1aWdoTy9teVF3MG5ZQlhNOTVORTVBN1c0?=
 =?utf-8?B?MjkwTFVySTRxUlFCYVU4MU80Uk1PK0V0cW9EaFBFaU5tVzB1MGd1MW8vS3p4?=
 =?utf-8?B?bFl6VUpqNnlZbkl2SU1NU3lBamZpL1VrTmNhYjVISmpWSFh3UmhnWWQwQmlM?=
 =?utf-8?B?TWJDaVNqa1NCSGRld3kveFhUS1ZocmxIQkhLeVlBKzhxVURIUysveml6aHRY?=
 =?utf-8?B?NlltSmduV3YzbnZweS8wS0ppbkI2WGVWL2FwejhjRkFWTmNaTFRVNDVaMERl?=
 =?utf-8?B?SExxNW5XRUNBcW5tSDcyK3I4Vk5YZ1dSaWlBeTMrcC9yQzV5VGdpbWJuREdU?=
 =?utf-8?B?UUcrR3pEbGJGMDhLSTZBRUJkNHN1dmIzVjdSanRmMUIxaEtHcUpsd0kyV2Y3?=
 =?utf-8?B?a3UxMTR5K0NLMDZMRG5xaDZiUytiWXVYQXlwWlVVMlgvTG16SEZMNkRIZEVV?=
 =?utf-8?B?WXdCMnF4VGFxQVYzbEx3YklyVXBKaFl1RVhnMS9CWTVYU1M4aDVZZzdJRzJo?=
 =?utf-8?B?ZjlYNUpYL2ZsUkxsZEJPNk85OHNjbnkyd2NCODJoSEo4UzRVZHN0NXB4SzJx?=
 =?utf-8?B?R3RaMU9BY3ZRbnUxdWtBWk53M1Z2MGRxc3NhVFdJclFKZHVCTUFUKy9pdUE2?=
 =?utf-8?B?VW05MnZ2YzNzK3RBSUh6RzEzVkRxNUs5V0tqNlUwbFo0VzQvY2RDYjN4ZFRB?=
 =?utf-8?B?YkhUSmpDR3hxU3diVDcyOTAzNlBaNXpTTXREOFV5NTZyRkpJMy9xbjFOMnJM?=
 =?utf-8?Q?3ZNpgAoTimceN?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2693.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8ee165-08a1-480c-0d83-08d9206c3500
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 17:32:16.5639 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 69ebADr1RK+LPWnBIXoHinup5W+qmx41CVuMp4OHjPJxXXQ5h2yL7m4+P/ChyQQlriJahP1ydOad1QhcM8a/+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4819
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210526_103221_146922_AC2CDF06 
X-CRM114-Status: GOOD (  24.45  )
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

[AMD Official Use Only]

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
