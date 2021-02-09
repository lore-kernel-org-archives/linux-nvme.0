Return-Path: <SRS0=1rws=HL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F218C433DB
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 05:38:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97C3464D5D
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 05:38:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97C3464D5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:From:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=QXMupFP7pgEXgk2jh5EvGYG+/aQzTaq61XHlYlnGOrc=; b=tZJ2JAZnIJard69/wEwYunUNIp
	CXTGQN20AG2ggU/9s0MRkJ5aotWMjJSpLQLF5Xf7iYwS4mBNEBrWnRcnb20P9nwaSzxYl3+gj6aUw
	OhtQTQ13zsgiCWje4plMjcw5/aKxKCEjm5YvH0mW1ph0TjmC71umKwwqtSIBvDarj37V3wRIQB2oh
	zO3PATScm2SHYEkQCbCDyRedAWErVpdogzJyf3VK/wAD+lFCslA+fh3U59VF4rlqtn+74Y0Ct3STs
	xfVyVqasXIhmuFcohFC9s2vJI+GYo5dVQczhszUITnFAl0WZXhfPfRX98bLx0rIvzmT1T76nFNXpP
	tVka+LJQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9Lj3-00039b-A3; Tue, 09 Feb 2021 05:38:13 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9Lj0-000391-2y
 for linux-nvme@lists.infradead.org; Tue, 09 Feb 2021 05:38:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612849089; x=1644385089;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=A+Q6uBJ8Mzf3byvFG55KGK2WLKfQr8z6NrPJONULyVA=;
 b=DE2o71rsbOKcNxedvPeyttXFeY9FlSU9EkfWriDU1Y7A66Vc2txwFsh/
 yEPcofzw5u7uyEBIJADoqHKiZ6xAkGbWvrVYk6iO1WIwa6rv9nHAvv7Y2
 +sn+Vf733Bv64qW4US7mYrtKvTKWQCKP+e6Iu8eTjkTwlzRdlDG238txw
 DQZpB6I/ka2zbfhB4tVC+Hn6gij9aYjeS+CmL7uWAZSTaixEpR0d4ukjs
 +THnyLgdqCFJ4Gp7KYXP90niCiZSSHADzzfEsjiMGYu4JfIQzRBUTXTtc
 Fys5FpsizgcsTv+pygOgfRzhODddBfcTn9MjMStrDbenKCfQDicIXjS// g==;
IronPort-SDR: fdj2ur3a8mfHE83N0wVC98KcXQWHmAOj512AdXvuH5J25B7ZEqLHtj2M4g4tPNpZTLYkeieDz9
 jG1p4jjs3Ekk9UqJ38h1ne+sxQyGfP3KaIkxA9MCuHCUlXBPYSghZj4LO3Q+3hqm4TT4RaWtIb
 CaEaBUFa6Duq6figGM9j24k5RAmIbuWU2VYjm/G3UB6FBUUhw/5gXj+logF8hmZWhDoFPrYJcu
 B5IbDN+HC4iECeLQqv00014vueUUpDrwmMBlmISZcdzeAcKtTptQvgQXjNbzVObp0Fu4bxH8Ca
 MS4=
X-IronPort-AV: E=Sophos;i="5.81,164,1610380800"; d="scan'208";a="159510835"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
 by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2021 13:38:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OT1AQtAW7wgyK9BwJgtvSsgxrJYaoQQ6WX8QnFUR7MU0Jy6vrEI5YOovywYfj+iBNHurIIBf6Bh01Q8kUWjPnnY1FIzvKJDZMmdgx0LwYC2/vm4lJLfc2/oZ9fckLw2k9rQfKW44BLzVkfsspETMqnTV6jUrpGvwTeMnoSqP3QQirFSocZbdNs1i88noDZ2MisZRNjTeITJz1NYtD71I4sCAXGuAy8Rm7fHOzcFNJxH3h/Hw3wa4/BZN0712nVWuJP5wjrpWIRnRfdhQvhwylWyRXVq6SZbiSKdQgKHhiFc6Q0DaT2+Bg8Tf++Gf7LFIdaYXSUVL//Pday0OfvOLBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ox8GeY8aIiXp7AR8kD3lbb7bOyB2KoKorvXklKVUzZQ=;
 b=iec5VL4bRSyB1mYlfULzlZJjwNGgk0Zk4jZjozCOatgHZTCfm9U7DQnaRtglCSvcYpg3wRaGcB/GjBJtzW3RhwnaBTLf4KEZQHxdGRCiPgGqOHpqKSF8WSG0ia4xWc5z7pxLK1VMVui5uheFe/dsAKj0Hobi3eE346H2/UHpWsEcdmy0iA7CiwxcIkOS1h+6GOvJa0CumLBL28d73DXaBuIBF7weMvQ7/qcvYyMuEhpIhY6nrYoT+aD+kjTgurI6Fz6zHqG80n0rMJreIRNVEL9QZNc1mjdgDfNgOt1uD8+ksPCloNAE7RLYT188MIODjMBgwGExA8Uf8N2nZPQSWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ox8GeY8aIiXp7AR8kD3lbb7bOyB2KoKorvXklKVUzZQ=;
 b=C1uVUVb1BAIx4cAHUkIGQaRiiVyBB0Xz+DRUz+O44ERp7idOj8et2Ca+55ig44KchbXIPcjHdsJYk1XnkTTIRqI2jk2uDMB4dj7wiTBKio2RFiLRY2aHLRoo55xGyRNBOx0++I4Qm/K83p/xDCCKGmsPPZv/7JilkhpVmi81SjQ=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6690.namprd04.prod.outlook.com (2603:10b6:a03:22c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Tue, 9 Feb
 2021 05:38:04 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3825.027; Tue, 9 Feb 2021
 05:38:04 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Gopal Tiwari <gtiwari@redhat.com>, "hch@lst.de" <hch@lst.de>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-pci: prevent SK Hynix PE8000 from using Write Zeroes
 command
Thread-Topic: [PATCH] nvme-pci: prevent SK Hynix PE8000 from using Write
 Zeroes command
Thread-Index: AQHW/qFWhMgmVmIHi0+62c2Fpd6hig==
Date: Tue, 9 Feb 2021 05:38:03 +0000
Message-ID: <BYAPR04MB4965000F7E15116893D6D1BD868E9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210209045902.72345-1-gtiwari@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d40a1898-c622-46c4-a520-08d8ccbcdf0f
x-ms-traffictypediagnostic: BY5PR04MB6690:
x-microsoft-antispam-prvs: <BY5PR04MB6690264728078D0064627633868E9@BY5PR04MB6690.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8CKkHONj05d8XIvcBytJ+erLJsJX0yQxgtXp+DQ4Kkf4/B2smBbiozKgbnFHjHKHudycn905vgG7VaaHi7u+3TVuWaxSCCCT20L7qPouPtBF9HthDAGWN66MUhIi9gfunYsMPjlMcBu6+qje7epw7AZWgIj5msLgkYjE+VfCgXXFX+BepV/dkyC+qR4jvenoLpJL9LNNIRmAEx3UiNEWuCIdYY+lMcGS+G4NadZGIgVgRmsf6iX5AUPq9pq1ndCDw5YN84aZ+ciVyvP+9BuBhDocw+0vcup1yb3SQ8ZeXIc5j8jZDDoG3OLjxlqdV1gZt6mReuJyJ0v5EnXCkSCQNBjZY1Ln4Odc6ZTY5+Wz028sWF2uJg0H2M+5KdRTpYJz3UznLgbpGkLHb4ko1DwNN72MTol/2UdanB2g289BN6fh6ancD/W43teKXR2JmuTasUfzf6rWP3JgS4+vOAV5z5Tll4vNvthRJRyHQHsUXHKQ5spSKjLFThzBdYqjC/9IFKLj2Y7W7HhDqNNPDydlgQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(66476007)(66556008)(316002)(66446008)(71200400001)(64756008)(9686003)(83380400001)(478600001)(33656002)(86362001)(6506007)(186003)(76116006)(5660300002)(66946007)(26005)(2906002)(55016002)(110136005)(52536014)(8936002)(8676002)(53546011)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?w/aFW3cRIajQMjN++8bXsEL2StuByzYskiqh6mGz4MG+3hr2riHj6toapSKr?=
 =?us-ascii?Q?jDEI/pH95Chp9URJUjoTacILB5HxGeLngrztHdwgCsZ0Gj/QiAQUdYhK5xb/?=
 =?us-ascii?Q?GsZI/WBdxq5ZwQYE27COqphTA+s5MAN6RuoTI204pWIfX7CAeugu6zHQl+ue?=
 =?us-ascii?Q?daEB5uCEzo7gnFnjuE8aQXJ49NlDDGm2QEBDMUzss6qzEzx4wcDr2fJVo5HQ?=
 =?us-ascii?Q?aUcXJR6yFTTDxYAR0ka67TwVxlUonkjbtaBmWzhqiAtj3CcAAAnc8w0iwW2s?=
 =?us-ascii?Q?l/BJIs190JbTGTpqaKGncAjYKA958/4bjWG/o2UG8v+MUlK1eM0ceB1CHgAo?=
 =?us-ascii?Q?FrH6By7tMA0r9TVx5gs1gIhWbcEUd8+02QUluFzvRXFZ0FdJatVYybDd9UMF?=
 =?us-ascii?Q?9tclIUHar1aquT771/xAmvN8Ro4GnyjT620VUwOkilpuwAq/bpEvlQzFVCZL?=
 =?us-ascii?Q?fpwRxv6U/4nyv8j1VVALDfwBDSz+nooaI+zJ9nJOt+/gz9IUGpXIQLyyy2w0?=
 =?us-ascii?Q?rOSl98Wz5kFn8/YOVcAkdLygw2uF5Dcq+po9+mwWpBeIC+deiBeDTl54fxng?=
 =?us-ascii?Q?5+zbI/6q3dtLVOpF3jW+mFvLn69APrlLqCy6Rlq7ZeRipWlaFCK2f0rxtKag?=
 =?us-ascii?Q?aTbz0PvzEwteC/+tf7yxRYLFRieM0N7rER+HJNvsDzSOh2EGEDwsnBI1Nfip?=
 =?us-ascii?Q?nlruoA9r9XPlJ231VYRYh8JHRjBPO7f4avzlhwWTingjncqJFBi9VZ65oYNk?=
 =?us-ascii?Q?buy/0t3leYYc7bzh60Pltb1fOlA30LJNZflsO1S14eKdVzm2/RwYoJD76sLp?=
 =?us-ascii?Q?QvOuI+wiufy+Zk3cYInGJFfFQoJ651dXniVrakL19vplGkFCbzVPk7ieHHJI?=
 =?us-ascii?Q?lStR0ll1HvNbVViQOs1yFgFODJllqOYqUJbhbUn7OHZgpiNDd7AFUMemNvWn?=
 =?us-ascii?Q?cxSpXmaC9BFooir2W0oYXCSvvMN2IYIU05ofR5ruVnvJQwb+LCu/pLJtduu1?=
 =?us-ascii?Q?i0mGgHViHT2YRvmCWqO90wEiYMw4WyI207Hs+CCgviLiie77z2Tgt2RXox+0?=
 =?us-ascii?Q?UpnfFqcCA5j076Ued4ztlyX+jECohJmvUu7eQqd0qCDnxq/fPGTM3idK8Mi6?=
 =?us-ascii?Q?QD/rV/Epsxp4GzB7ecR1v7ODjITBTjQ3osUaaMD52EW6bbss3K5ZFtwf3Ueu?=
 =?us-ascii?Q?j1oP0jlWmTJc31wGk8k3wTNrbVKGRDfCtloakchgSWPBa9tQps+fOIXOnGQo?=
 =?us-ascii?Q?x7nIWMpljxZEFiHUZe2wZNAlQzFVt6CDsBAnRCbqnrj0HS7cowXtM+U83JdS?=
 =?us-ascii?Q?Q9G5Tgocuc/0+oFzvcD7MhgK?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d40a1898-c622-46c4-a520-08d8ccbcdf0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2021 05:38:04.0088 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IWEi7vM6AM/eR+Wm+HaOQmShrKaKGYl7xC3uSo8qFgps5oDmTqva+BeuZtlq5e/gUrwNIZjh6dsOUlx+TVpzsypG/BECzk9llV/CRmPhLso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6690
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210209_003810_678837_1B3E6125 
X-CRM114-Status: GOOD (  12.87  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Gopal,

On 2/8/21 21:06, Gopal Tiwari wrote:
> For SK Hynix PE8000 WriteZerocommands exceed typical I/O MDTS
> (Maximum Data Transfer Size) supported by the hardware. Which
> intern fail and generate following erros :
>
> nvme nvme0: I/O 0 QID 96 timeout, aborting
> nvme nvme0: Abort status: 0x371
> nvme nvme0: Shutdown timeout set to 15 seconds
> nvme nvme0: 128/0/0 default/read/poll queues
> nvme nvme0: I/O 0 QID 96 timeout, disable controller
> nvme nvme0: I/O 0 QID 0 timeout, disable controller
> nvme nvme0: Device shutdown incomplete; abort shutdown
> nvme nvme0: failed to mark controller live state
> nvme nvme0: Removing after probe failure status: -19
>
> Firmware unable to complete any outstanding commands
> due to lack of resources, therefore placing NVMe drive
> in a condition that is unable to further process WriteZerocommands.
>
> fixing by disabling Write zeroes.

Please consider following commit log, can be used at the time applying the
patch:-

For SK Hynix PE8000 NVMe Write Zeroes Command exceed typical I/O MDTS
(Maximum Data Transfer Size) supported by the hardware. That intern
fail and generate following errors :

nvme nvme0: I/O 0 QID 96 timeout, aborting
nvme nvme0: Abort status: 0x371
nvme nvme0: Shutdown timeout set to 15 seconds
nvme nvme0: 128/0/0 default/read/poll queues
nvme nvme0: I/O 0 QID 96 timeout, disable controller
nvme nvme0: I/O 0 QID 0 timeout, disable controller
nvme nvme0: Device shutdown incomplete; abort shutdown
nvme nvme0: failed to mark controller live state
nvme nvme0: Removing after probe failure status: -19

Firmware is unable to complete any outstanding commands due to lack of
resources, therefore placing NVMe drive in a condition that is unable to
further process write-zeores
command.                                                                 

Add NVME_QUIRK_DISABLE_WRITE_ZEROES quirk for SK Hynix PE8000 that fixes
the problem.


With the modified commit log, looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
