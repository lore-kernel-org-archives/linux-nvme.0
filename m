Return-Path: <SRS0=3q+x=HZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4808CC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 06:07:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA1CA64E4D
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 06:07:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1CA64E4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=OgW1/gwo0Rp6l57Y5qPf87+dkIkNBd6OGS7x91t94VE=; b=ElS++Kp73nmT3cFvjEU0+TM9J
	lmuSYoXBAchcchM6fjnM86KImpyAyKA1G63lnsohp1vrfYraC8hiG1O7+MBTkKSFtc6Z5YoGvUdlr
	wWM5Zo4Fj+bqOFLREvpJcjY8D1vCZ65Doa8K4I1IJJE0lEm9Cpa/N4Qq+pEE7VlnpFTfA/lISC/ET
	2ql6/FD2cBJKTJGcRMPwRK7q1s8P1MTNXW0+mc9C0LksNxEJrsij4BmmmmAklknCk7Qt+wW2eRqzk
	Yp0mBjCk0NEna+GBISESJ6NS9QtMfhv4UCYoFpHJmVNfHjETHiTQsFS24RcW+5kVVWqIQD7PYfpKX
	BEyQcjgMA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEQqg-0005pv-Jt; Tue, 23 Feb 2021 06:07:06 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEQqd-0005pB-3L
 for linux-nvme@lists.infradead.org; Tue, 23 Feb 2021 06:07:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1614060423; x=1645596423;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=3ZLLX+QrtTlI+KQp9goXhtEIC4UA1VRYQh0s9T1i3Z4=;
 b=dt9gYf1YttXrgcl/pnScyfDniupF3s9STJMZ4inRuTR4ivxCzspEauOY
 EgMKLD7vwiJqGMRuTo5X9NBpFnaXruLbRtfR/jfNOAUtc4CsY1mlggQ0Q
 wyCa8K+GDi71mZ0ajbRL9pI7X6r+FMhk6QSPZ/GBAW8UEb54ys2skiyxR
 igYc5L0fM4wzwXd09aZtSc2s1FqHgPSng/HCkkk4fgowa0CwjjAL33ZWK
 Y/aRI4zi8YXM3lUj4wvEsXdzPVyEOf1gymGmxPkzxMxEqE9nW7aNSXf+Y
 D/AowpEJBePXre2BqouAVAwZ8FPPZRFJsE3VpgAt68JOIXNsnvDgYEN/w g==;
IronPort-SDR: TqohG0LIBeVw/CnChJeBjxHLxDt2JmG+0igKbWLGl8VPpWH3Z7gv0K5egecOyKQUp9RFrrou6j
 UKdvXKDzDQrmXxJTTVJOFEHUPY8ymGcrGuVcXhsOSFxIPLENMT/O3FsL6jo9RWjgzztYtYqe8w
 y6WLv4bFrXZNRV6p6M+CGZ3GsH/FGvpX1VsORgScseITBgAMB4zIyxhgU88NrM/t0QNHykQgob
 hPmUtwJ5cly4QqH73ZSbfLfOk1WCS7RZoE5GQbsYxdIMYn0V7k/dnrQN+GoXlHIXdAXuJ0E6dt
 pko=
X-IronPort-AV: E=Sophos;i="5.81,199,1610380800"; d="scan'208";a="160575043"
Received: from mail-bl2nam02lp2057.outbound.protection.outlook.com (HELO
 NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.57])
 by ob1.hgst.iphmx.com with ESMTP; 23 Feb 2021 14:06:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TT4qRI5ZI5PPL/13uPNVSYPy1J7/73SNmAbfnzJoSvqrOCHuhKjFTHagxm7/8JaJlh8hhgQGDL3w0jk7Xbqu+wcIRS+P4L0naz3WE874DiDaNVsGlEmyP+oLe/poW5HW37aXoygsUJ90DNjY5/zxaCYcS3AS1KlOlQHfnldbY1RVLnZxsuAGWcqES94WEI2p1CDtkvIbwDse/+mb+BxAgkBAJqyuDB809ZPtw3sXxl3kDB/6EIJrJHqsnO57YjkXkgp2lATTYbqnEg2Qm1qbWQbY5CiXBQ7b6ph4/yGZgfwXc195fyHc7+nQbiaht6k+1DIO6dd1pcf2eci7Ms7qvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oou70nIHEmVb2RnOSGXrm0KzSXYMS+5ZtZsjXwsUtDk=;
 b=cPQ/HkKy8wr86rQHNC/Jd1itF84GFLQOd/vd/CfwljMB7vEDQFWdH2x9NYpdAumCRBLxFgtcXpT290V+/G8fGnrp3YZMXOHWHQiPFHfOOfvE7ga1a8w1yCgSY15vjgedq6fRAF+Brv8WJ05O+Ilm/Dl13R9LnG9Jug9v2sioavVGB9vNOV61bjhWqDX/qhnhEDgL1ggbW6/NnS321L8EO+4VIcKiCkVQ5t1uZZGbNakE7swHnErKcfNigvzQxtyGyDU/f0AAqeB2UiSWgRMy4kPeifcjacCChEovw8oa9In3LQT6eKkVtS3Z43L0Q5ZXOSW3nddJsYeOyg+prWqHEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oou70nIHEmVb2RnOSGXrm0KzSXYMS+5ZtZsjXwsUtDk=;
 b=OO4yIpi6PgdA1yR7UkF5pqFgt06FGPBHLQU+J3ou4vSmBUP7leHQTvw/UYcwJiUiTaer6gZmCxL2E7ZBvCtH/Y//NgK5MN96iCaMdBrnA6wZe0V7z3Xjewz11c9pNy2Ofk0jIyHIlMgUO61nHlCETARHUXGWaygiQ+QNAteoULg=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4421.namprd04.prod.outlook.com (2603:10b6:a02:fa::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Tue, 23 Feb
 2021 06:06:57 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 06:06:57 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "George, Martin" <Martin.George@netapp.com>
Subject: Re: [PATCH] fabrics: ensure zero kato for non-persistent controllers
Thread-Topic: [PATCH] fabrics: ensure zero kato for non-persistent controllers
Thread-Index: AQHXBdyzrQ9+U2AxaESwhDaryUEDkA==
Date: Tue, 23 Feb 2021 06:06:57 +0000
Message-ID: <BYAPR04MB4965AD8096D8F313B2BFF74C86809@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210218095422.5696-1-marting@netapp.com>
 <cb89029d362a3cd61504012351f56731cec9c6fe.camel@netapp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: netapp.com; dkim=none (message not signed)
 header.d=none;netapp.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 81816ea3-c1bf-4ac5-5eeb-08d8d7c139f4
x-ms-traffictypediagnostic: BYAPR04MB4421:
x-microsoft-antispam-prvs: <BYAPR04MB4421571AC5EFBCEC9E6BBD3086809@BYAPR04MB4421.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gnol4HKVVjlLLn4OSY8JDEgAjNbgT/luFNaQhu+HZLIqcW/p0SOUuW1OKS1JPs+GPeYQB4dTAA9mBOJ5VhIIqwOvdmNRggDTaq7mEKk1j5WBxds15wiIrCg4ySvNO21yBlOL8jcq3H1v+Cq8nqXPssIqbqQTVHw0L5upINQWIqZhOgqAbl49+VEyS7cWnCoRBFSuoD3kDhjDnqocx9lnJq+Jr9ON9f9YT6KNFTScJgwTGtvlWM61crUQhP7YOCyFrLpSdHjtKCfESqzEvQbMWIXS/1YyhJ6ttaJFlgabROYGAXzQNUsfW46n8m6Re3jgFiuB4TtbQee6N0dIZLbQW+doUm5iJu7SyZuGZ3vr4OGiDDMde2+plsG6uilcLoFtBijIB1xJmtwAqbcq3eJDVL9IZseaa6qbMG7pFgx52+Gi0Os/q12mWnR4UG2W5PfwrH+qynPn7LBGdJ1b7X77bLl2bWpsBvchpvrNxa7XqPuxrF7Q4l/Krmdro7mI8VpHGmPwOWKnH8dSgedDRHZnddg6zHRw1FCzvCi1d6a2HqbRKWuKr5tQnpvy1hYxPUQJqr+cV/1tqDIZUg91z7lPrREV8gDG3cESQksIkDZtCBg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(396003)(376002)(136003)(966005)(52536014)(71200400001)(6506007)(64756008)(186003)(9686003)(6916009)(478600001)(4326008)(66446008)(55016002)(66556008)(76116006)(66476007)(33656002)(7696005)(66946007)(86362001)(2906002)(26005)(8936002)(53546011)(5660300002)(316002)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?bfPfFOjd0/eVH06gfF9GB2557HrhHYsohGHmkx+mfYOTZeik4iw/AIiMgShh?=
 =?us-ascii?Q?ZPi5VAUxR9XSwNGy3wK/gHEyryfeEbW3ZMWxt/rAEgpNP7F22vpWN4ZRIYrh?=
 =?us-ascii?Q?Ou6xKH9jBH1KfbpWm2H6wMXiZuZxDJYHGfj2gqiEPPuPOZMG6kXsuSWRA3Gv?=
 =?us-ascii?Q?QPf1uKujhLwYw+qMsqgSC6SclyPr3zmeJor2Dk/2edvmoH6zsQ/0oeWxT3J7?=
 =?us-ascii?Q?uzjdMbeYNvw0Msgrbn/MdMu7UJ1haWZu0A50nmDmqy7796KjukFK7g9/TjSZ?=
 =?us-ascii?Q?p8HfzPHOHLkmVNxmhKSmxhG7AM4jrpKIN25bL6cdZ6jA2k6Q0/sjBNgLFGj/?=
 =?us-ascii?Q?0LzITOWod+8FEkPq1LVXde3ayWoyaimgD5fW9PoJQj0VdnmOwYgkQDB/F5jt?=
 =?us-ascii?Q?T5RiVRfYQ4D6Bzwm17S+wEbDfp9n3S9DgqKorAMj9COomLAHzy1I8WdAiAz4?=
 =?us-ascii?Q?3jUN3LOw805dqR/R23FM/mrI7gljT0+oI5Xy2haF5FGZWl6TVB315/ASg2sI?=
 =?us-ascii?Q?A95ad2OVHhfiYIvVO6IHwneeknZtpw2nOdSO1by3xmoYgoMgDmlzvixQo/AY?=
 =?us-ascii?Q?2mlx9cx4UUieZMAzI/LvziLlQhPFtgs1eXE+0iP8B6XRX/MfpObJhQq81SUR?=
 =?us-ascii?Q?UaOfrxg/cQ9hJ673i1OgY75/I6TbnAV1NzEl54q0grbyil61mjNvvaEwbD0m?=
 =?us-ascii?Q?yNSPZKe/EDXez5tHXKk/BpIx+2DOFRtA26QA75xO2KxgpFHpi5PfzNP/yLNh?=
 =?us-ascii?Q?1CnhRncejfQWiZnZam0Q9CKyPD91puI6yK2q5ZZk4kppMbxLX6A8OKX3U1WV?=
 =?us-ascii?Q?SgtC6WxqMdVKTmOMrIZ+Xrv2ZPJPR5zkeIpXHhl5XdaP5CnG279Ys48pqMLG?=
 =?us-ascii?Q?ko8bK+I0X6UP4GBvikC8EPtwEMhaap5m53wmwaK6ZhKoRK2xn4N/sUXWf8zR?=
 =?us-ascii?Q?1WeoF0sQ2TwqMYEWLFIu3jHCyrG23YmFl3JKVdnalvqeRiBruaQaNPU38zse?=
 =?us-ascii?Q?s0ekApHEWmNE2+RoBrXFkYXeNAuUHZ0eKw/1/X73bDg616VdSMhQbsI3MZyK?=
 =?us-ascii?Q?KxvRGaxzwVNoI6Gd40w4FhKwblHJ690uGuE2MCl6MqSprpjsZGwkGqVlR73M?=
 =?us-ascii?Q?qoGNgij8g0bUeD+Ytel1qK2KOdog01s7foBEcBTKuy/LJJOlXCSvpddTBS9M?=
 =?us-ascii?Q?kj6Fim+2sd6mRmPe4zu5CInyQRaNtSzM3XPZEs0Bnoj1M1LAnUWVHB6Bek1W?=
 =?us-ascii?Q?3j/IJj2xGMDAJaxelDJvCuapGESYSCy8TLmFVSR7UnRn0UbsYVJ120ZraGTP?=
 =?us-ascii?Q?2TxYF0bGUV056PMQwsweFDFw?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81816ea3-c1bf-4ac5-5eeb-08d8d7c139f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2021 06:06:57.3331 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SrDIDeANdCPwqJ2+uVG/B6ZUGcXpNgXbhZ7ZNn1W04duyAqwMz32ASYax2yCzRsJpbGcEhOqy9mABYBpWRSxxVOGeFdmptaQbIFRCfWbL70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4421
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210223_010703_500643_77E0352A 
X-CRM114-Status: GOOD (  15.14  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/22/21 21:47, George, Martin wrote:
> Ping?
>
> On Thu, 2021-02-18 at 15:24 +0530, Martin George wrote:
>> Along with ensuring a non-zero kato is passed to a
>> persistent discovery controller, also ensure a zero
>> kato is passed to a non-persistent discovery controller.
>>
>> Signed-off-by: Martin George <marting@netapp.com>
>> ---
>>  fabrics.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/fabrics.c b/fabrics.c
>> index 1880a5d..ed15e08 100644
>> --- a/fabrics.c
>> +++ b/fabrics.c
>> @@ -1399,6 +1399,8 @@ static int discover_from_conf_file(const char
>> *desc, char *argstr,
>>
>>                 if (cfg.persistent && !cfg.keep_alive_tmo)
>>                         cfg.keep_alive_tmo = NVMF_DEF_DISC_TMO;
>> +               else if (!cfg.persistent && (cfg.keep_alive_tmo > 0))
>> +                       cfg.keep_alive_tmo = 0;
>>
>>                 if (traddr_is_hostname(&cfg)) {
>>                         ret = hostname2traddr(&cfg);
>> @@ -1474,6 +1476,8 @@ int fabrics_discover(const char *desc, int
>> argc, char **argv, bool connect)
>>         } else {
>>                 if (cfg.persistent && !cfg.keep_alive_tmo)
>>                         cfg.keep_alive_tmo = NVMF_DEF_DISC_TMO;
>> +               else if (!cfg.persistent && (cfg.keep_alive_tmo > 0))
>> +                       cfg.keep_alive_tmo = 0;
>>
>>                 if (traddr_is_hostname(&cfg)) {
>>                         ret = hostname2traddr(&cfg);
Is that if else if ladder code is repeated ? if so can you please add a
helper ?
unless there is a reason for keeping the duplicate code.
Also can we remove () for (cfg.keep_alive_tmo > 0) condition ?
>> --
>> 2.30.0
>>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
