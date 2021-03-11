Return-Path: <SRS0=tknV=IJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9A2C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 06:27:59 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6231B61583
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 06:27:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6231B61583
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=Ri5LCl1NtCa8Ew3SLj4rQqrJVikeAh1OXRwLqUcuNTw=; b=kvHClenLDP2xf+yHZ6kH/1zH0
	zHMElsZMu8WZ/eOxxZXrD14sybwDHZuISElmDbdmzudTHbJhxbmjFs2Rpe5IduDG3IqyzqY4zaR8s
	/76uXzJrJVsrfOnZrZPWduVftraslBd32JSLBlWqNCcC1E6aNiqbOyF28rdN3Lk17A3TrGAiYn8I9
	mnEjkQdeEAkFW2BHuLozVOwTg+beGLGEO8wliH656NdJtFzEglPBy0nTAO7trrZYEDoRlc0qoER0I
	sq0AyO3jO6bVMWl1BjkbhXlkgI5F3p15wZYBS9ilwRNsVieuGu39iRHacNYo4zXq8Lb+WWwpxfemx
	27PX1KYEQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKEnP-008UTY-Lm; Thu, 11 Mar 2021 06:27:43 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKEil-008SvE-09
 for linux-nvme@lists.infradead.org; Thu, 11 Mar 2021 06:23:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615443774; x=1646979774;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=HZK/xiqS3mu6C1nrr/Vk7TjOz/kaYi8Nn4vkc+di9q0=;
 b=EKaSx7vnSoWipg1g6/CDFMGjhuGCMHRIuKXww9BX4VPk4Rd9deBl7bND
 w+I3F5yE6PbipYoit22qLEPMUTmqQn89aav1RAaOybAOFF1at0wzUxYSV
 1cNtJz4YTYK81IkcjCjbL2J4ilprbPBuAogXTe4uC0vyYOGTJXDoYA8l9
 TACIhV4lsQdgmWDeZ+T/84QD+t7xtPdUp7qLnmlKdtCNgSFWDtXWaw+BO
 2rRjKsCuyzh0Pi1Evsy2yb5irZQjlMnju0KiZOX4+8wDh8xNLaLdCFqld
 05kdxIvjsMmJCYPtRgF1zHpfi/Qa4eRT5PB1waUc9w8BOHSA5IyU15Olh w==;
IronPort-SDR: sAQhbCRgUOmogxwhE4ulYNrO6M+CzKxP9cEMLrhluZhS5L/pguOP2LmvAebHM1qEgVCO6E5Ohq
 FkCJteZKl0z97NUo+cDnqYvaz07EJTM3UZKnezX7LutPvGPBbzu+pouFgSKQX+27wQd9RRNbQj
 ThxGa+f5Ie4YdeoKyuWh40/x3F2eg7QWLK8WXUIPovT1OkOkosTorydiuQztDkDwu2wanlaQ8z
 zAsUYLhza/znBkvmH33LcYM3LV0/sNOSDL0XOEadauaOBfr8zKgD0/52d1Xjb4vQx8KPnjSkkf
 u24=
X-IronPort-AV: E=Sophos;i="5.81,239,1610380800"; d="scan'208";a="166387753"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
 by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2021 14:22:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UlMMmju0yhBkPXj+6++zLE5rGwAwCzEE99afyU2wj2myFWmjbEvtxVP/h014SElr5nMDGC2Dj8YK/VpxAsNUbig2CPPYCxT9wpNbEejl8RZl1TSTxRtbfLRjRXlhaO3skWwG4IGD9TdZTl9FFpIoYAmG8BknTA7gwY+uGKiZs2hsUVaC6fhLXbKphI8yef2HwBP/JoOnyYFOvC4pe6B5472IeFXnrChZZ3JkzAcYQig5CtaSkKfcrH/J/yJGpT0b8JDbF98qkBMT4T/oodSpchCpoL3cH8KgmMsP4cvflO7PaA/2LZa3s6BDqwJyRmmVZ5mSS6AR2aikjarX2KoKWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1c6R8/uVRWYYi8AL95C2QkzO3u+wTLTtF+kNy+fcIc=;
 b=E7q3VfqjJO63CjBLshw4V9Fdw6B9DujzRjyR9v3I5Oz88MNziVP+pHfg/DXbQDofaICxmNE2NoidWVlUckOwckjFW9H87tG6/BTifZm13h+sAIM/Zgg74uw9GHiDnKOpPiyEi0P+/XeizsFdlu1h8NT+4TVGn3sxwa9G05rXE/Po/nPjxTNHAUoMpCtyMF2CWCFGlQHUq7y5b96NfM4G4oULLqpBnaitYBT826+UGShuB9B2XCUYgglNROLZF58K+o+sDjqOhKwR4hYnHV27gd0L8FUhzwqoeesbf44D1VD8uqmvR7rJ2QQEJ/zmnKBBf0zMrNZpL08oOaJXr5Oy7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1c6R8/uVRWYYi8AL95C2QkzO3u+wTLTtF+kNy+fcIc=;
 b=uLLuoNThpM/FVm8u1nqxf1sc02IVmt1WRydGXw9i6gUSbFrg9alxZFPl/rbECC3JikoqyYPxqB6cWuNdLaHBGHACifEFGlUM2Tqd5DBZ/O9kHoI8h61ns2mm1fup5SwSko8RpDzCtw+gTrv0SeD7Y7ysJbjTASDYMPvLupv/Fu8=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3957.namprd04.prod.outlook.com (2603:10b6:a02:af::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 11 Mar
 2021 06:22:50 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3890.038; Thu, 11 Mar 2021
 06:22:50 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "hch@lst.de" <hch@lst.de>
CC: Damien Le Moal <Damien.LeMoal@wdc.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH V11 4/4] nvme: add comments to nvme_zns_alloc_report_buffer
Thread-Topic: [PATCH V11 4/4] nvme: add comments to
 nvme_zns_alloc_report_buffer
Thread-Index: AQHXFjCXtI+x3gK1YkqYWEcfPCeoKQ==
Date: Thu, 11 Mar 2021 06:22:50 +0000
Message-ID: <BYAPR04MB4965A57A768260FE98B3320F86909@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210311043908.26146-1-chaitanya.kulkarni@wdc.com>
 <20210311043908.26146-5-chaitanya.kulkarni@wdc.com>
 <BL0PR04MB6514516766FD5F343D4415AEE7909@BL0PR04MB6514.namprd04.prod.outlook.com>
 <BYAPR04MB49658642053EC41432FCD9CC86909@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20210311062210.GA3889@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 94a5005c-1c56-4828-d33b-08d8e4561893
x-ms-traffictypediagnostic: BYAPR04MB3957:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB39578A19801A944391925D4686909@BYAPR04MB3957.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m3OaZeEklsbp2eU2M4xHX0ksShAWyZL98ls830swf6nx3qrsWofLfgojOLZznTnAw+UystcW5h1PAgZYIyz9hEStc/dI89aNh49SACloChXyKfw/478coLA1aXKFqQl+5f+ds70cmuRvD8pkbHEZkmZ6Zd37ZtHyzT41iB4RES/5ZCWk7rVcAN0qhbz9chVXfvXvHQefNnTjOL1+jGNn+7EhaDnghqTXEmude7aqHt/3ZF0KegH3H7nHXcN1ODksGjttwW645+BAxX/3p6CYICQc3F7aGh84ygbQQ0LllmACXpMHbxIW2Znc3qfpLzJF06EFgZzfYfdUZOyfqMxl+XewSxPU1DCt5vFshDbB0RIAfWUPkyVjeFn/Ae73e920g24gKF4yNztdKcZYMoBLEfbVZc58g22tln1mSl7JBT2LS15MEDKZr1eBuniTOYffgLZFzG+2ZY8tmDDDhOckIp8zcKihygQxDFR3BHVnDcnYYmZraS+q6ZrfcPhKjde3+zNPrpvHsLCB3dhgSsrdfA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(6506007)(8936002)(2906002)(8676002)(66476007)(64756008)(5660300002)(66556008)(66946007)(186003)(52536014)(91956017)(76116006)(71200400001)(55016002)(6916009)(53546011)(316002)(33656002)(9686003)(86362001)(4326008)(54906003)(7696005)(26005)(66446008)(4744005)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?hVpXHoslwrKvqAKDWVBQAc2k3EqQf7AG3xSajsm0CsTQ9+ZxbmRwdO1Cshei?=
 =?us-ascii?Q?bMExTwk9Ut6UvJNkWBDGwdHbTai9B8BqHo/0FTXPbOgbZBKB3gmhXh7dKwa7?=
 =?us-ascii?Q?TDuxG9mhZfd2KIPG1fIeMrSu3FpuoqCQKoFhqTB8fsl2a/iPY68F0/gO0z3l?=
 =?us-ascii?Q?eQNArwC7Vy/+bYfOxo4VBshY39QHBzAOlyyyUb7nHUpw0On6R9YOcTEVbgDZ?=
 =?us-ascii?Q?/1cT0QlMZPREM65XyZN0sZ0A92ESc4V8k3w0mvHQKk/1I6BIQzrF1EHZpCsA?=
 =?us-ascii?Q?9+8GkSd1TeDXG5mwSqd1RMQf1mYxHSsMZyw4BFcPgjxVVyDVM524RzP6yOub?=
 =?us-ascii?Q?s7H93oc0FFzj8usA1jHJ/U1e972nyUEbk7m4lP4E7GHnraksfAIxMyNPWhMU?=
 =?us-ascii?Q?77NA5IiQ2M7PgXoOOatlYvaK68Yia26+RJI97TipdnupcYLIq2IOsjUDK11E?=
 =?us-ascii?Q?YswMBWOJrSzSXg4Y0HB+I22ihiqyGpV0aDNJYTJo0sswwpMbaioC/1cKm5Wf?=
 =?us-ascii?Q?X679r2X3YFrUwgiklCeVt34MV9bj8r9kiMbAtYW4yUkMJ9JvXSGpFc9u0KlD?=
 =?us-ascii?Q?HpxsoSQgnF0D4FTEJUOXWs7WhNVoHXrJLv5owoGedlsyjAU5xpm+cc5Lhytu?=
 =?us-ascii?Q?Cv+PuQqjlu6yCQbfboYGqjHs60lLO2kaX4nk7NGY4GvslL5YPyxrfF4d2srm?=
 =?us-ascii?Q?CfnOY0k9Bc0fheLgw4KneClX5ITvN+lBygdwRfln4zBgbyIKqv5D3Ynth99N?=
 =?us-ascii?Q?roOjsMHNm4flTAKaqwUX+vbkdpNXc5TXdVEkfIAvZNSeEqE+Z4fC+xjlo3iC?=
 =?us-ascii?Q?z+Hhdx8XfCsIuavHstIzFSsEfQFfuCtt8XgQYynp6UmG7Vj+CaoqXi958kfk?=
 =?us-ascii?Q?IuNF1RehNRK7xKpL5QMc5NArFfAqeM7tb0tswUd+bJj4ddgTQVPqKqqcoeld?=
 =?us-ascii?Q?Uh+6ZkrEOC/nRG3oqJqNoSBlwnZZVaI7nC0dm9WXkKKTdmXg7iWBnHn1uckV?=
 =?us-ascii?Q?TMliNjI8isDEkD4fHXB4gmbQaRsMnZuJkDn96FuTuywLSvqI8SdTPX+w1AlM?=
 =?us-ascii?Q?9AZtkmDqpfiDIbJ6ABbocinI4w9tSHY1ikeDnRSkNsmD+juvDf9X8/F1wmpI?=
 =?us-ascii?Q?qSmOz1N/ERQU+s0MHWH2j00UdT5i/1qSs9ua7KBIki9Vy0JiSLW4FOPIQ4rF?=
 =?us-ascii?Q?5LKlSe82bkJwHv5P3yUQASGiB6QUrRwjKFCsKlMupB6Hkxkq17AqExEzZK/g?=
 =?us-ascii?Q?eub7hSO5XDCN1KrZrJ5oVEyoGalKBAHPXWh1WRomIccHGiXqGOihMSbnkcIB?=
 =?us-ascii?Q?yGJbT6rQxz0oaQbLCX7s1MnB?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a5005c-1c56-4828-d33b-08d8e4561893
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2021 06:22:50.2307 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kbEYxkEFOsklYT3lOtzXHFt8a8WigeTGDGxzTybXM9pbE2YH8xKAA8m4hOgNzmEV0346K3WFGJNdAiERFaWjqip+Se13P67X74gZRndDROM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3957
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210311_062256_166801_5BEE97F5 
X-CRM114-Status: GOOD (  11.71  )
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

On 3/10/21 22:22, hch@lst.de wrote:
> On Thu, Mar 11, 2021 at 05:36:53AM +0000, Chaitanya Kulkarni wrote:
>>> This seems unused. And not really useful anyway since if this function is being
>>> called, it should be clear already that at least one zone can be reported, that
>>> is, the report start sector is below capacity.
>> Okay will remove the comment V12.
> Please just resend this patch individually.  It isn't really related
> to the rest.
>

Okay.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
