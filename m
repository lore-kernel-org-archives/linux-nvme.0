Return-Path: <SRS0=dfbP=KU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01958C2B9F8
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 14:06:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8A5A613AD
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 14:06:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A5A613AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dcBz3VboCRxEQOpERJr4peBAjqPhw9KtKPQYclz8Fys=; b=GmL4/MdYVXc2zl
	uq4ZKUIA+Xhez22B6QEGXRyDxnm8bIvGYP7x6DgG+ZFjACcnzglPwmTCrIRj1NzFJGy0pMh9rYjLd
	AzRxVqZcKx5Pb8OaF0jKqwp5ANTpUoU7PtwRVFuslwBjmD/tM63Xum876Ydwy7Zq/KBtayKgY/Ozk
	YgdRbOBtD+wVJrMOgxB1/I5nkK6gSuViNKJFX/X4s/yoLMGXJbuHqum21CVyRBGOklHnxvLAcJbhY
	OCicJj59RMPvGDpOMbZuhUD2FtCqGvQcXVPY1TflrKTwlNzlOmEoBS64TodMJWjPZDoeP801ldlM8
	4J3VSUykIVl4+po9HXqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llXhJ-005XrH-Em; Tue, 25 May 2021 14:06:17 +0000
Received: from mail-bn8nam12on2068.outbound.protection.outlook.com
 ([40.107.237.68] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llXhF-005XoQ-IL
 for linux-nvme@lists.infradead.org; Tue, 25 May 2021 14:06:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TaUDXislfgCVsRFSxqtJLtRpvvILBfwWjGnK3A0Mm2fg1exeDN/kbAQjuKovM0GTHu1MOGGpYdPrDAnPN+/kR4kZmegfE6dtXuGQ7eKNRMt8seMunobAGX03T2qcC7FrRRPWxKYuEGCuQTTMTDfbon+RDoWeqNivRFa0LujdonZ0u53dU8y44NBNsyL8qD/jvhb0Km3seLYyxXUh2e61aSRmmw+Oqmmut2i7ql2eIFoY1Z48fwgHwk9YW23593EotR7ZP/zWLathOh5O5CibejLLdMBqCRX5VvCBbo1V07dd+OJMylaJUcYk9q4i5vOMpKNWN1ZkRI+PIavGmE7QYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMYD6XmXMQNvbWzOnzGGTk/VvsEBFiYgdoGBbQA3TYA=;
 b=jsU5iIUFB60J3t7TTQ6lf/bQIw78KLyvyqgZ6JHTJ0YBHjmnkd251kHEoaPh65S1dxS8nFCf1p/5UYiJL73j8V8sQg7xaUS6tSVrrmCQj3NG90MtBuZWRgPvt37bz5/Ftv/i34orHI9MzmX5/WhW7F3vimRxGcQ41zpQccij6yaQZDcW6X1RX9Dv7O3+PebZwLAorzwK0N7KQ6mxF0qQZaR16UbDSj1YG1GkBMaYYQbmmZ9Vg+ShUTjvM9oRslPb0s+JaE1ggik5P8LRsIbVr0G0oZf8UBmUK6rVtPK2ATbAkfGzunaSYI84zl/EC0bQokXM3CywVypanE44Jod4AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMYD6XmXMQNvbWzOnzGGTk/VvsEBFiYgdoGBbQA3TYA=;
 b=xOZQNqJXl5jY3XrO+rknjXdqia4GK8zp89oQQoXN7SHlu+uQO8j/uifD74zRrqD3V+8oc7ILqFfe4g1iOPEQaX8Xoy6DRIg1LHIoZ9igye0z38AJh/SyS0jzrcw1k3sagBkJvqpYof9gQgvwwpT/k70v4XAcAkFfOGWcmLCUPSE=
Received: from BYAPR12MB2693.namprd12.prod.outlook.com (2603:10b6:a03:6a::33)
 by BY5PR12MB4917.namprd12.prod.outlook.com (2603:10b6:a03:1d1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Tue, 25 May
 2021 14:06:10 +0000
Received: from BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6]) by BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6%3]) with mapi id 15.20.4150.026; Tue, 25 May 2021
 14:06:10 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: Hans de Goede <hdegoede@redhat.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, Christoph Hellwig <hch@lst.de>, "Liang, Prike"
 <Prike.Liang@amd.com>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "S-k, Shyam-sundar"
 <Shyam-sundar.S-k@amd.com>
Subject: RE: [PATCH] nvme-pci: set some AMD PCIe downstream storage device to
 D3 for s2idle
Thread-Topic: [PATCH] nvme-pci: set some AMD PCIe downstream storage device to
 D3 for s2idle
Thread-Index: AQHXURCj33ZwIr9nkEeZsNaCQKwCY6rzujiAgAB6bICAAAQggIAAAH8Q
Date: Tue, 25 May 2021 14:06:09 +0000
Message-ID: <BYAPR12MB26937AE0D027A84934F7D81AE2259@BYAPR12MB2693.namprd12.prod.outlook.com>
References: <1621910939-24831-1-git-send-email-Prike.Liang@amd.com>
 <20210525062119.GA12561@lst.de>
 <MN2PR12MB4488679A3F04ECF3B8415975F7259@MN2PR12MB4488.namprd12.prod.outlook.com>
 <cd94fd56-7ce2-e431-4a4d-6c42e5b7a9a5@redhat.com>
In-Reply-To: <cd94fd56-7ce2-e431-4a4d-6c42e5b7a9a5@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-05-25T14:06:08Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=3f61a908-c0ca-4271-b352-03ebaa1a5ba6;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2600:1700:70:f700:a1e7:c926:724c:a49a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b06ba208-b499-426d-a650-08d91f863f71
x-ms-traffictypediagnostic: BY5PR12MB4917:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4917D2A9F06AF8AC6A8A50F8E2259@BY5PR12MB4917.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TuBHul3GjRPE/KnzeQA9CLBvl03Kml0VKwg8whFvYacJtb7l1eLNyvnGVcEr5sD3JnOYd35OJrmlxgyI6JLSmw2qAK/ZzOWXVF/FB7BZTBhyQWgc3xMNKJDFJD8qLAwssrjKY88FBSvEk19M/KSX0LJ1J+jZUGoh9wHxDOgsXyg/vtCt5UiRG9rfRLLpqwLbdw1AYDTsgu/k86glnGwTxoXPYaN7yERXdozoimtnv9sfasGWIabtNd8LLZmojtblVUdWT7TMfR29oybbkuGeAPJFVNnXDA8Hd0y8WL6ohSCAFcdXkvz3bXYCmFzh1SED/slKvsNF67jJHya2p+mWQexgD60ERhVHEdQJ+/MN0+4unHuf9o6sc9yaYKbioJKyiHfSWLWneIiK44vXbElqxlszW40hmrH4W0uDCkPpYWx9eD2tyjHL0469tQ8L7373aUHVYdc1ewDDPqwVrAFOXK6jz1zNHdPqQ+s9DToNamr3CDYuZBFJKlvIxQ3VP7GgXfyoSI7NGa7l+bF03x8vqSAg2DoMm0n8ou7Qe4sNwrswi5RYSqKMDPZeG2wmpINbI/weKiUwYYQ7e55j4sIWD+6wpJl1JqfdsKmFsiC507k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2693.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(136003)(39850400004)(376002)(8676002)(8936002)(55016002)(66946007)(76116006)(64756008)(186003)(478600001)(66476007)(9686003)(66556008)(66446008)(6636002)(38100700002)(86362001)(6506007)(2906002)(110136005)(54906003)(83380400001)(33656002)(4326008)(316002)(71200400001)(52536014)(5660300002)(7696005)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?a1ZLNEFlaWIzczRKSTROT0dTUkZZck0rbHVKMlR3UG82bnMwZ0VEUnVkMEdY?=
 =?utf-8?B?N2duZjVMZGVLVDVxaU43Y01vUVVwL3dYeW91RUZMUnRQNHJHaVNocGZ3Q2tq?=
 =?utf-8?B?WWZUR3A3MCtXRWJCUFR0SlRBQkZ1TEZsQW9uR3NsY3ZhVjNCR2VqUi9kNjUv?=
 =?utf-8?B?U0Rub1R4MTZpVmRyNUE0YVJuOEFjZElVUGpzclRBTW03SnEyTllLQ2E2b0p4?=
 =?utf-8?B?TzQzSWlwL1haZVdwdEJnd0ZJK3hUc090Zit5VnA5UWUzTGEwSnZ6RndJU0pa?=
 =?utf-8?B?dTFaemw0R2pLKzlCakpvOTViMmwwS2tkckJ0Zjk1eEtVWnQ2VlpjQTNiajBh?=
 =?utf-8?B?eUhsVkprOExTZWRHSm1xdEM0UHJaUGR5L1VmUzB4VzJxbVBHOWhGTW9BKzA5?=
 =?utf-8?B?ZHZ5QXZFbzM4bEt3VDN0ZmptdXpvODBUNWFPYUNCR3JRbGVaL0JEUXY3QlpJ?=
 =?utf-8?B?eUJ5Q0hNWEZrOWlRWUdxNThMclI5UFZPTmFKNUIzUXYrQzNIdlA4TnZpRTZR?=
 =?utf-8?B?UVZMK3M1VW10aUNIWEdobGx0N0xtVXRSSkZDVWdDVmhaa1M0a2ZlZXh3YVBG?=
 =?utf-8?B?UlJPK3FyTUV3L1BrUFBnKzhLUkFhMHYrY290N0h4ZzNHOEtQUWpyK2NVcUh4?=
 =?utf-8?B?dWtKK0l5ZHpTa1ZEcUtUdFZlVnVKekh5WEU4bk9jejRZL3g2YlhlcmJJeDg3?=
 =?utf-8?B?USt2K1V5aFdqR05sQTgxNXNTZ2ttME9IU21EbDZZQzBzbXNRNUhta0orSlp1?=
 =?utf-8?B?RnNYbmlPTFRlTWpzWnJWZ3RiU1I2dUhzdE5wMUw0OFpjaEZ5eUdRNWZDcEVJ?=
 =?utf-8?B?dUdDeWhVK204eWZoak1NRWV6YWRIMm9ya1VyL3hKN3Y2VjFUOHZsc2U0WmVw?=
 =?utf-8?B?WUVQRW9oR3pkOCtBZ0cxa0ZCMGRIL2NOODBMKzdhbVRubnNYbE1Kb1E0UkNn?=
 =?utf-8?B?SmlHYWZ6dHp2TTl4Z04wRFFnblJkSGdFcit6d3pxcFRZQjNZZCtVUzBUZEI3?=
 =?utf-8?B?TTljT1cxQmkvd2dKT1pjc0tuYmZnMlBmVm00a281bjh4RFdMS1FTbFkzZlU4?=
 =?utf-8?B?NE5pekFHRlM1OHU3QlREdlkwdXNDUjVhbCtkejB0bkthVVhIalRzdVlhdUlm?=
 =?utf-8?B?cW4wZllaUmR0MmRTV3gyOWtNYnMxcTFqNWNrNlNTcXpYdmFuK0k5aUxNekQv?=
 =?utf-8?B?bnIxV3NkWUhkV2kvWXp5VjF6SVZHc2dHNk1CeHZZQWdoWkdEcFY4cmR2U0Rq?=
 =?utf-8?B?bG5NMWU2NkN2NFBiYklVTGZZL1UvZGZ1bWYzZVV4Nlo3K2psZks5VGplVXpC?=
 =?utf-8?B?ZWZsUiswdUM5U1ZPVDlrd3AzM0RCY3RiSTJkdGFLaWNPc2V4SDdybjdSL0Uy?=
 =?utf-8?B?bWVNV0ExdE91aEVCUkZuK3ZhK3pwVER6dWg5YnhEZnhZN1lQZHZjY21wRjRP?=
 =?utf-8?B?T2pkMThEY3VIVUpINjNhZ3FUNkkvN1FvZ1Y5SGN5QTFjbktVOWdlTmNtK1c5?=
 =?utf-8?B?REpYWnM4TTFtSlhqbnlNOUtvWHBBVENuQlhPVDNXWDllalZQUGZ2eU1OdlJy?=
 =?utf-8?B?M3NxZXhwaWV2K2poYTliNUU3L09HVUtVYkY0SVMyQkdBdERVWnRiemhEa2hY?=
 =?utf-8?B?cDY1WVNwQUZYS0MrbHpTM0xGWDB3ODdPV21nN241NTlhZE95VFIrcDFab0Nl?=
 =?utf-8?B?SE5XRUVEeUl0Zk1hU1FQcFdSMWVNd1Y2YXJvS0JmMVBVV1dNWVJ0dnpyQ2Q3?=
 =?utf-8?B?c3JPVlRmbTBxK0xRSTUwS0JHQzByRnBuUEczcHNpNWJOWnV0VWhYL2xDYzVy?=
 =?utf-8?B?cU5vdlB3L2dRZjhadmdQS2J1cUg3czRrOVNueXhpRmtHMHBuQWdZSkIvVHB3?=
 =?utf-8?Q?TDrEdBT4hKqlX?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2693.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b06ba208-b499-426d-a650-08d91f863f71
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 14:06:09.8158 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aWxRDGcv8iQr/2z32htUNOTv4z8VwPRj0kL/XhBu6bwUXjgHV2a1dg9DTKK5CeV2+mmQc7oVGdNbq8K+MJdi4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4917
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210525_070613_656470_2F7B0778 
X-CRM114-Status: GOOD (  36.05  )
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

> > Any ideas on how to handle this at that platform level?  We need to select the
> NVME_QUIRK_SIMPLE_SUSPEND flag on certain AMD platforms.  This is a
> platform firmware requirement.  It's not an NVME specific requirement, it's not
> a PCIe specific requirement, it's a platform specific requirement.  DMI matching
> doesn't really make sense because it affects all AMD platforms of a certain
> generation.
> 
> Honestly I can understand that Christoph is a bit unhappy about this, but
> the nvme driver seems like the right place for this to me and it is
> already doing DMI based quirking for 1 specific Lenovo model, I don't
> see why that would be ok, but a CPU-id based check would not be ok.
> 

Yes - that was my point mentioned in the previous thread that led to this 
patch.

> Both are ugly, yet both are unfortunately sometimes necessary.
> 
> Reading Christoph's reply a second time though, I believe that what
> Christoph is trying to say, that this seems to be related to some
> special suspend demands stemming from using the pci-e root ports
> from the CPU, if instead the NVME device where situated behind
> some pci-e switch, then the link to that switch would need to
> power-down for the CPU's deep-sleep demands to be met, so this
> really should be a (probably new?) flag on the pci-e parent of the
> NVME device and then the nvme/host/pci.c code would set the
> NVME_QUIRK_SIMPLE_SUSPEND flag based on the flag on its pci-e
> parent, rather then having the CPU-id check inside the nvme code.
> 
> IOW I believe what Christoph is suggesting is the following:
> 
> 1. Add some new flag (or some-such) to pci-e ports/links inside
> Linux to signal the requirement for the link to be turned off
> during suspend (or whatever the requirement actually is).
> 
> 2. Make the drivers/pci code set that flag on the pci-e root
> ports of the AMD CPUs which need this (based on the CPU-id as
> done in the original patch).
> 
> 3. Have the nvme/host/pci.c code would set the
> NVME_QUIRK_SIMPLE_SUSPEND flag based on the new pci-e port/link
> flag.

Actually that's what was proposed in earlier patch series, but Bjorn
wasn't happy with introducing a new quirk just for it, especially with it
being an issue stemming from a particular silicon generation only and was
pushing that it should be included in NVME driver directly.

> 
> Christoph have I understood correctly that this is more or less
> what you are asking for ?
> 
> Note I don't know it this actually makes sense, because I don't
> know all the details here. I believe that AMD is in the best
> position to decide if this makes sense or not.
> 

The back story here is that it's nothing to do with PCIe or NVME, but
an issue with what happens with the SMU in the SOC.

Quoting an earlier version commit message:

"Then the NVMe device will be shutdown by SMU firmware in the s2idle entry
and then will lost the NVMe power context during s2idle resume. Finally,
the NVMe command queue request will be processed abnormally and result
in access timeout"

Which I think begs the question - how about if we keep the quirks list and logic
outside of NVME and also outside of PCI but instead in an AMD owned platform
driver?  Something like this:

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a29b170701fc..ea3c8772cb11 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2837,6 +2837,12 @@ static bool nvme_acpi_storage_d3(struct pci_dev *dev)
        acpi_status status;
        u8 val;

+       /* Some AMD platforms need to use D3 due to SMU behavior */
+#if IS_REACHABLE(CONFIG_AMD_PMC)
+       if (amd_pmc_should_use_d3())
+               return true;
+#endif
+
        /*
         * Look for _DSD property specifying that the storage device on the port
         * must use D3 to support deep platform power savings during
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
