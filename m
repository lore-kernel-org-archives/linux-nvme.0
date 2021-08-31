Return-Path: <SRS0=iyK+=NW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915F0C432BE
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Aug 2021 13:31:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 406E360234
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Aug 2021 13:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 406E360234
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=primelogic.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Xq0Fbdkvf9MdVBcf92m2lPnemqLqqRbSCdplbJgzdic=; b=B1vJsnhE8Gj1wQ
	kYzCspO+pc5AGOISE9o7omeNyNdpJFWWi9oPM3rwA3rMNw0y91DI9KI1nH9Is86iBwFSz8ud0S/8m
	wquSKnso34bfW+9ZR9oSw3XnHN8qjx0AyChc8QspjZ9nrZB3egimsimERlNa4Aif48Jj37mhcyH7v
	6e6vNxpEQC8IX3tmjpHuC4Y5/BU1JfVpfy0km3+St8we0zJnL66sLba69t0nEU7o3O6SRVt7GhDen
	EFbgkcgMOc0QkPuG/ouwsp3p32V61qq5wsWjpEi5U+1nRPNGidXyHBaD8LLc0PuKsFky/xCbdedGj
	Gm10laJwzJH4Pss8YV3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mL3rC-002KJH-R6; Tue, 31 Aug 2021 13:31:18 +0000
Received: from mail-am6eur05on2104.outbound.protection.outlook.com
 ([40.107.22.104] helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mL3qs-002KIe-AJ
 for linux-nvme@lists.infradead.org; Tue, 31 Aug 2021 13:31:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQTNtodLV5ox8I2poz8a7dc8VLIl2xS4qRrZIe7I3i4+P+HUTdUYUBjnNylgGPXYb0tobnT1x9sVVU8zbauA0bF8GkRwWm9mXxJNt6zHXX60qcW4gAN5HQgGzoXJN19WzwS88GLHKAx6Vj+kR5bOi8RxUO84kwfFjgti8CR7KxR4SsPpx36H32roM17tuOrg0g9blWhja+cpmGE0AI0LL8hpbVw7Me2vvPk+7w3zR2CbnyHjtDXsnS8VlFaTYXjNcq0tXdSJUwA1fYgxvJAqiC6OlPLH8uW5AYZlyg6RRJCKNI5HkT5v8hv5RGz8qx0bvOL/wwc8sZn0jkDbaRwO0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d80f/k2DMkkzZd2ihUWJHYsWKkfTaQLqQquZgnaM/ZQ=;
 b=JlEvC7z+S/U07eInByEhK2n42eVV5cTrptmeZOlMAJxlL4Tmrl3rpfKeGYzWeOrMmHjsB48JOZd8GGmv48RZ5U1w+/PbhWrMumayvvjJg08DD6qc+fUDlEXixs06qvQCoc3vfYP1p0DH5OkEncfEs/JIczwhMkxBu4iyG1D8b4aGJgBK7/EWlpdcVVkVJ4PTmOhStI6biphu9Y3FkW99+k61RL1F8zt/1Am8ckkf7aKLzw0boG5OVui+FgdVj69tQvQJdJLgcJ+0g8+71D45KCvFGXWUhf6gf1CjQ4XCA8LL11jy6hwa80q0tKBiHOUCdY3mD4AwDVhrljiP41G6Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=primelogic.nl; dmarc=pass action=none
 header.from=primelogic.nl; dkim=pass header.d=primelogic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=primelogicnl.onmicrosoft.com; s=selector1-primelogicnl-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d80f/k2DMkkzZd2ihUWJHYsWKkfTaQLqQquZgnaM/ZQ=;
 b=F/LxQzFAHIZ534aALtmB4V4/GGI9/Y6YQ1448uCQTBYyL2HvZIcgaRz3DkI7mqlgBJL3kzYzXPRx31rrcy/YlOaWaAaXo+fK4+uCC2/LTnXlaDw3eRd85EZ2FJaPl0DDgfa+FBIuhjv3x6XKlMdQ3PLaBKU3SfsnCU3O35VZdL4=
Received: from AM0PR03MB4211.eurprd03.prod.outlook.com (2603:10a6:208:c1::28)
 by AM0PR03MB4339.eurprd03.prod.outlook.com (2603:10a6:208:d0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18; Tue, 31 Aug
 2021 13:30:51 +0000
Received: from AM0PR03MB4211.eurprd03.prod.outlook.com
 ([fe80::4d63:671e:2943:5086]) by AM0PR03MB4211.eurprd03.prod.outlook.com
 ([fe80::4d63:671e:2943:5086%5]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 13:30:51 +0000
From: Mark Ruijter <mruijter@primelogic.nl>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: nvme-tcp crashes the system when overloading the backend device.
Thread-Topic: nvme-tcp crashes the system when overloading the backend device.
Thread-Index: AQHXnmxqX1Auh6AUnUypwfeIAEtsRA==
Date: Tue, 31 Aug 2021 13:30:51 +0000
Message-ID: <1A17C9D4-327C-45D6-B7BB-D69AEB169BBD@primelogic.nl>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=primelogic.nl;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25fbe059-2fc2-4238-72c7-08d96c838d5b
x-ms-traffictypediagnostic: AM0PR03MB4339:
x-microsoft-antispam-prvs: <AM0PR03MB4339C20F0D526201129BBF8ED1CC9@AM0PR03MB4339.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u3xW34dNoQwIP3nVQHcTlngl0BT3WnQ57KzdnO2XOEbHLMn0IVWzB5ARC4sN9Z99uUTIjQbNOrXGihGBCHk5zWPwrYBiEcJ7Fdwre4seQpoxu/A2mOFXrrlxg6zMSxaX80HvhoDRSJC5NtymUGNDBArSRxtVskI+JXVsAT7YZzp6VD0HBVxAl89DEscf2BN7JRBHTuEHGWCOaQwzI19os1CFVo0N7GKKRYVRibLvVHxikYAafyCKjrjMWGNkZlcjMkKEbinLAbJyvQCA9b+r43JaUXH8J7m02ucZreKZenPkgXCy8JBgfL76ULKqRMXSBNcGcr5dcrd3JhjTOJA38npXSRsUu8MInQm/efFO+wadUpH8FTV+pmuuu6VhBsTbn2c7ZxzehpkSiHWM/8MnamC4pRbmC7h/0oyynQLfiH8h3bfgEQb/rr05H/BnKURfgxg9+2dqO8iozVtafU2dPaJ0meLiJGX35BRotgiZcIfXlwn8KjTRK67gioEpT0Bz1E1MJG5Skt0aTp99PHFdX0MJHr713hfy9OU3u6ooazrQ4Zwzr2kvTB30e+jBfO1L/NGQEwbUIKt2ZyO3mZVNl9rwSslToSPpwT+/xmxXjM36jdJfZR8sOBEMike+vxCW5nh2a1V+sUK0pT3AcUAOcySZAGkRmQe2aaOjFhKXBEttEoK6BaLMjTclRcdyrFPmulgNjBWJkqDIFzDb2oN0VkxU0uFYLGIbClWTcZkBUBY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR03MB4211.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(346002)(366004)(376002)(39830400003)(136003)(8936002)(33656002)(5660300002)(316002)(38100700002)(186003)(86362001)(71200400001)(2616005)(6486002)(6512007)(6506007)(8676002)(508600001)(38070700005)(66446008)(64756008)(36756003)(76116006)(2906002)(66476007)(66946007)(66556008)(26005)(122000001)(83380400001)(6916009)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXVzRlFQOWw0eE5jQWtXZ2tWQ0p6WHJKdnNLVGtxVjFvdS9FWnUzM01ESFVJ?=
 =?utf-8?B?bVRFc2JkUVg4Qk1QUE0zREFVMUVITm9FUVJ2aWJZZHRkTEErMktvUFdkM3h0?=
 =?utf-8?B?eVFiRHliQjlLcURFait2Z0wvRzlQOGkzS0xkdU1Ub3k3UTFZYW5xeFBDSytB?=
 =?utf-8?B?eTV2U1dQS2lXUVBaQjFraWFkeVBUNmppYUlxcE9pZGpXd3RYMTNrUmhGSkYz?=
 =?utf-8?B?SElRejFMWEl6TjQ4QUVaOExRQTJLcHhhdUM0ZGV6dmpXVEppa0xFa3A0OGpX?=
 =?utf-8?B?c3RJZm13VHVrbmk2RTV4Z1ljRVpaaUpxWjd5c3NBUU5nZk91K1NMNGlsQkNX?=
 =?utf-8?B?N3hEOHhlWG0yVUduK2xDb3R1dGhXRHd4ODlkaHI2RkhzZ3dQdm5WUGU4ZTZY?=
 =?utf-8?B?RG9IY1IwamRrZXJZT0Z1MTA3cTZMbGdEWGtuNVNRa2dXd1g5bk9QYktOYkpP?=
 =?utf-8?B?Z2lyVGlvK0plTEY3b3dSY2phelkwb2tTUk5kVnBQK0NrNTE3a09CMlJwdm1D?=
 =?utf-8?B?VURjandSdU4yMVdra3ZaczlhOEppdXNVK29ManhMUlNWK3hEcGFLZHJoRkhn?=
 =?utf-8?B?TDRlZjBLVGFpalVuWFRYK2hEYUhvV3ZxSnBHV1BOQUZ4YmVBbGVaUzB5czNT?=
 =?utf-8?B?NGZ0cncwSGdQSFdGb0xBdlIvMFQzYVNTdzVMSjlKRHNTOVY5ZklIcGE4dEZv?=
 =?utf-8?B?Q05qdmlSSllBSWxYUGc4TFN3NkErYnJHaHpZakNHTDNsbVh1d1UrSGFXYnM2?=
 =?utf-8?B?VTB3cDMwSC81TEs2TE42N3JsTXB1ZG5iZFloT1Noc3MwRHZyUnZJcVFlZHRW?=
 =?utf-8?B?U1Z4c2tFeU1CS0xNMVcza2dWTElCN3ByMzEycjQ1cjcxZlRmYnZ4d0h5c0w3?=
 =?utf-8?B?bzF4UEFrdEVFUzdwSytISGRMclBnNytnS1psVG5UNFRSZ1Y1K3NQQWdWUjBU?=
 =?utf-8?B?Qlpud210enRWNFBFRXdqTE1kTnRBV2taQzNPSWFDZUxncXFJUG9PY3AyK1Rl?=
 =?utf-8?B?SDhHVktXYWxrcU44c1RZQjhnaHovUGVZTW9RWVArWURxMm9mZFljbmdnbEdU?=
 =?utf-8?B?MGlMODJiTlZWazJvOXdxY1d0TFRjNEs5bVhKSUxoaUJhbXBGZ2NDbHpSYVUv?=
 =?utf-8?B?aHhpOG1lZytBWEZwbFJNNFRoWlgrcHI1YlJrNlFsT0JCTGdMMHBJVlZWUnJt?=
 =?utf-8?B?blR5bWJQeS9Fem8zTlF3cGxkLzJ2Y3NuMXVWT25aMFROV2h4NGhVdmkzWCtW?=
 =?utf-8?B?K05Yc004Zys4dHYzbWFnbmUwL3dMdEV1YlYzTU5XQXE4SDRJMUhLQURCMjcz?=
 =?utf-8?B?SXAvRXJiZGsrcDd0WWErWU1La0U0QnRLZkxoVlR5MDBoUmorTU5kVWk0RC9m?=
 =?utf-8?B?d0d2SzBsMVpzUjZXUVA5dEo5QzlmQWRlVTFXSi9hK21rRERNU01GaW5SQldX?=
 =?utf-8?B?UXBnYU1YcWxTMXdYZlhnOUdycnQ0R2tWWDIrclBsa3o5NEdGY1JOb1U1MzlM?=
 =?utf-8?B?WHN2ZXZWZGZWRUowSXF0bUI3MHkxVjFEaHJmRVBISlhPMS8xZ25yVGxNMFBB?=
 =?utf-8?B?b3piWTdOTTdiQW9rV1pjc1RJZStEdFRQVVhVZVgzaVBVN2J5cEJwUTZHb3Zy?=
 =?utf-8?B?UzFNRFNPRFVHeDluNkZiSXdzMmVaWTZ2V2RaRi9oL1lMbGwvaVhwZmJxL1No?=
 =?utf-8?B?QldzUnlTeS95T3BneFFQTWMzUnZ0TTVyTUFwOTNsMlAxdkl5elBXR1NMakJj?=
 =?utf-8?Q?vR5eKT1gAXcnubLZR0x/SVVOk0qn+/oGbmwtHaa?=
x-ms-exchange-transport-forked: True
Content-ID: <03B01FE188098C41BA04136306C5054A@eurprd03.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: primelogic.nl
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR03MB4211.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25fbe059-2fc2-4238-72c7-08d96c838d5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2021 13:30:51.5963 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e6f00f2a-c615-4e27-aa0e-cb78655623c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6/YnBDiQUso5hECOQ7Yluata4M6vdojsmouE93GomClkmBd5NQ9xPy/CnchOozlF5rcyIV2ual6onYyHffFtRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB4339
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210831_063058_455875_22D3FFCA 
X-CRM114-Status: GOOD (  10.49  )
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

Hi all,

I can consistently crash a system when I sufficiently overload the nvme-tcp target.
The easiest way to reproduce the problem is by creating a raid5.

While this R5 is resyncing export it with the nvmet-tcp target driver and start a high queue-depth 4K random fio workload from the initiator.
At some point the target system will start logging these messages:
[ 2865.725069] nvmet: ctrl 238 keep-alive timer (15 seconds) expired!
[ 2865.725072] nvmet: ctrl 236 keep-alive timer (15 seconds) expired!
[ 2865.725075] nvmet: ctrl 238 fatal error occurred!
[ 2865.725076] nvmet: ctrl 236 fatal error occurred!
[ 2865.725080] nvmet: ctrl 237 keep-alive timer (15 seconds) expired!
[ 2865.725083] nvmet: ctrl 237 fatal error occurred!
[ 2865.725087] nvmet: ctrl 235 keep-alive timer (15 seconds) expired!
[ 2865.725094] nvmet: ctrl 235 fatal error occurred!

Even when you stop all IO from the initiator some of the nvmet_tcp_wq workers will keep running forever.
The workload shown with "top" never returns to the normal idle level.

root      5669  1.1  0.0      0     0 ?        D<   03:39   0:09 [kworker/22:2H+nvmet_tcp_wq]
root      5670  0.8  0.0      0     0 ?        D<   03:39   0:06 [kworker/55:2H+nvmet_tcp_wq]
root      5676  0.2  0.0      0     0 ?        D<   03:39   0:01 [kworker/29:2H+nvmet_tcp_wq]
root      5677 12.2  0.0      0     0 ?        D<   03:39   1:35 [kworker/59:2H+nvmet_tcp_wq]
root      5679  5.7  0.0      0     0 ?        D<   03:39   0:44 [kworker/27:2H+nvmet_tcp_wq]
root      5680  2.9  0.0      0     0 ?        I<   03:39   0:23 [kworker/57:2H-nvmet_tcp_wq]
root      5681  1.0  0.0      0     0 ?        D<   03:39   0:08 [kworker/60:2H+nvmet_tcp_wq]
root      5682  0.5  0.0      0     0 ?        D<   03:39   0:04 [kworker/18:2H+nvmet_tcp_wq]
root      5683  5.8  0.0      0     0 ?        D<   03:39   0:45 [kworker/54:2H+nvmet_tcp_wq]

The number of running nvmet_tcp_wq will keep increasing once you hit the problem:

gold:/var/crash/2021-08-26-08:38 # ps ax | grep nvmet_tcp_wq | tail -3
41114 ?        D<     0:00 [kworker/25:21H+nvmet_tcp_wq]
41152 ?        D<     0:00 [kworker/54:25H+nvmet_tcp_wq]

gold:/var/crash/2021-08-26-08:38 # ps ax | grep nvme | grep wq | wc -l
500
gold:/var/crash/2021-08-26-08:38 # ps ax | grep nvme | grep wq | wc -l
502
gold:/var/crash/2021-08-26-08:38 # ps ax | grep nvmet_tcp_wq | wc -l
503
gold:/var/crash/2021-08-26-08:38 # ps ax | grep nvmet_tcp_wq | wc -l
505
gold:/var/crash/2021-08-26-08:38 # ps ax | grep nvmet_tcp_wq | wc -l
506
gold:/var/crash/2021-08-26-08:38 # ps ax | grep nvmet_tcp_wq | wc -l
511
gold:/var/crash/2021-08-26-08:38 # ps ax | grep nvmet_tcp_wq | wc -l
661

Eventually the system runs out of resources.
At some point the system will reach a workload of 2000+ and crash.

So far, I have been unable to determine why the number of nvmet_tcp_wq keeps increasing.
It must be because the current failed worker gets replaced by a new worker without the old being terminated.

Thanks,

Mark Ruijter




_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
