Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AECE5C7EE23
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jun 2023 08:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jiNKJV2U0JuPdGHcdxz8h2NmHG+Qsl5zJZWpMQwbpMU=; b=oqCsiNdqDjtzD+aWYZhp77+yq0
	HJKEoQR6axyQlFcVbubvWWGuIrWcJ1kqFfH6EPvZ0IBEpa4ZiipUqp7ONFRpar8ErY0y2aD+tXvle
	Dyd807h8hvtlxZnV3lJh3PBeROkfooz6a1adOCwJKex6iUSGBzBpJ/n5d/i7apvQICRuU3BD9vfrq
	7bZzlBGZcbafxzy0OxCnOHmILmmORuRz7nKHbB7J4fhfCx7XkDKe1X1FS8TTiJxvQXNnRfx/SCrLs
	5lzMgGolHIqJc9mDpY1R6vFqn1WhSKv89fb6znk7e755u9Qo2yPphxyhpm2T5LeLHYu1HlL+tcusm
	a/72fnqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q65AC-00EeUk-0C;
	Mon, 05 Jun 2023 08:02:04 +0000
Received: from mail-mw2nam10on20610.outbound.protection.outlook.com ([2a01:111:f400:7e89::610] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q65A9-00EeTp-0U
	for linux-nvme@lists.infradead.org;
	Mon, 05 Jun 2023 08:02:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhU/CeBFBx5htW9K1n+z30wNqxbNAZ0F7nwfffTnFHhNE24vZKLxhnUVfCdOo4PjCfGvZznD+zD53YpkISYRGVKXecAn8hLti3UWZUNm3ebNNTV1aBKSaAlBqXbALPPWFnercRkHeXRha2IkFT0gMt08cXlDlmg/UK6tfKziCKz+rhfa0qOCzHlofkRhGN9BgajQg4rdg6VqrxZNabXKLBM7NH+gjZmAciJ/AqrL1XtJGJz49XEyGQy6kQKjZ640FvQoJgsUXAD4zKJqDbkN0XGC7eHPL4UNhiZo//N1BoJwP0/xYUNQOmQ4NNpHLanEa0V6sTmdzFl2CGC4GdJmuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jiNKJV2U0JuPdGHcdxz8h2NmHG+Qsl5zJZWpMQwbpMU=;
 b=nKV753gpdW0oE539VTeTBFDp4Ij5Ti6qb+UGKaRuIZM0ej3pn8+jFYzJsC+VHxlBaBSRNjmt6ZrYKQ+VtSvEK23OobXySvGRXJQGmS9/t9p0Xfj6nJgq66r7QiMlQ32D7NllamsUTghdBDUwUNwTtEBMNReTbGv4N+8X5kGYwp890aP1ZVQrLh56nt8UQ/ydsFKN3JphLNdVeyixMSBXsIbStLKZ0dqq1jHPzmAsFuCxK4LMJ1YBJBKshMjG3rM34C1jSU0fuwVFcb120H2vxEMIbA5ZV3PwfgR5w9uzwBtAv6U/hUwESdktEKS49Acx8IDW+m6+59AHJZknT0IK3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jiNKJV2U0JuPdGHcdxz8h2NmHG+Qsl5zJZWpMQwbpMU=;
 b=pIniLyR7++BSpOVPsPQcG/rymI9QNfcQQ14BsiIVS3XpXOgnZc0V7NDKS/m9h+kCqYDSdOrrM4/8KA2TqekWzZQIgBB8P8uNzX5KykxuLK+6Eu2U4em6+XDsFEq4rkxGh95xrHaD6CtvVL1VSQZneB1QjUP4AIBSqv4Sax+34vWDiwxYsILpnJaOS8qhcxboCf+/FnGOcdbAyR9PWjqlH85ETTG61cS4VYkKCF6NNWiR/WObXKzvR6K2dBULCQfx3kKlpgwA2Y8qeEoxluH6FPIeCl82NgEiXIPOXQbiLHgN1eC4PDcnzwEj6t7onNaI1GuPlct1JV5Ii45stdZQdQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN2PR12MB4374.namprd12.prod.outlook.com (2603:10b6:208:266::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.27; Mon, 5 Jun
 2023 08:01:53 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 08:01:52 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V2 2/2] nvme-core: use macro defination to define dev attr
Thread-Topic: [PATCH V2 2/2] nvme-core: use macro defination to define dev
 attr
Thread-Index: AQHZl3o9+BUBgW8i2E+XNuw9lRJKnq971xwAgAAB6AA=
Date: Mon, 5 Jun 2023 08:01:52 +0000
Message-ID: <84e8a7be-51e1-e743-97cd-71eea2d40da6@nvidia.com>
References: <20230605065125.47563-1-kch@nvidia.com>
 <20230605065125.47563-3-kch@nvidia.com>
 <5dcb4c76-0d97-78d6-d383-7f92e7eb4467@suse.de>
In-Reply-To: <5dcb4c76-0d97-78d6-d383-7f92e7eb4467@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|MN2PR12MB4374:EE_
x-ms-office365-filtering-correlation-id: 31538d62-7fbf-4000-797b-08db659b1fb8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yyax0K0XRS5tzfIjtK4K/nnoQW3PWOmJUwZ1FgdcxdOoZV316HE5+TA3eZNrISnO9FHMPWvmBuLGxWmaVgduuJ1jtg5Q4uFwHZrfmwJZ6gDkQfp3yoMj1kaWwWSZdB4Aw9k1YC9mE6t8YmR+vACzU/GhrFGNDvDnnzZjMYMayDQSaP+4cVBFGS1v0gQWfoSwLe9eAmWQpetkefRo7sX+DNObu2Qu+EAKMmeN4Opaej3SVZkXaT60siJ06PM5Zh8j17ue20FCAwLk6SAEB4R9nfSRhrkivLNzeUHf6AszX2KCDQPJDpw5V4bvFT0RatuuV+BDZqnCKS8CxYl8q+EQaPt05ODCKYGqNUEWI74VYx5gl72A43jvRzBCORrl0eyGXtd8h4qbsbnNz9HhAaGKBcY9RIJNtaAZ47ixmeu/N8uwaCjQneNRavMgwU18AgZQeuqZJpDinGK5d0HMEBaCa6G5nke5C4DVRr+qIeEF57Y0cgFPFf7FyQYw/W80JXXvM1rHbU/H7NZtlKUv8a7/oyk+ZgloIUsdErh6JARTqvTR7bZioLzwgnGAfGteROo9W5RvNWRzrMxRWhE6HsiHjJVf0x5gr7aruPEUYqX3Qe3wzURNa5XLZwsSuq+JQved+R9Tp3sDCwVPXo1BSaKIeac9+tuHyO1f+cUMc7XphrGxAJ5Aew6kBzFGOmoFUkbR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(451199021)(8936002)(8676002)(31686004)(5660300002)(54906003)(110136005)(71200400001)(36756003)(41300700001)(2906002)(66946007)(91956017)(76116006)(4326008)(66476007)(66446008)(64756008)(316002)(66556008)(478600001)(6486002)(86362001)(31696002)(122000001)(2616005)(186003)(38100700002)(38070700005)(53546011)(83380400001)(26005)(6512007)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OG9lRzV5UklQcllVY2Y0L0lmY0paNm1uNHhUd21WQmtucTFZbWJQMEVKTXVr?=
 =?utf-8?B?ejNFQ1hCOXRNdWhxcDdwNzhqVVFRcitzV0h6VDU3UVE3MldLTkxaOW9vNzBZ?=
 =?utf-8?B?TTN4WVpVb1RqQUlxeGNYbTUzejQrd1Q5aDN6UmJXTWVDSVJUTEhyb1BlR1ZB?=
 =?utf-8?B?eHBTekRDUFpVeVVSa05mdEQvTUE1ZTFhRGhOemZwQ0laeDFqQzJReXpBRHA4?=
 =?utf-8?B?bE5NVytQajJaSFR6RXNUZUlVSUZjQW55OGZRL0VlLzVKbXdIdnFjTE1hWjBs?=
 =?utf-8?B?ZHZieHhvNmcyVEJxeUR2U3BWY1NPb3U2cldZdGxaRVdMOGRKRGlZcndOQzJv?=
 =?utf-8?B?OVVRVldKNUJYek4vSnpyZXBvUFhWUFVJQlVwWDIvU0NLVkZiRTBIbFQvMlFM?=
 =?utf-8?B?TGxyYlhJNWliczZnbkdPZlFlZTRJMTNjd0txSGNqcVpsZFd3NUE3R3VlRXhO?=
 =?utf-8?B?U3dmMkF6M0IrZHY0QURia2c2bUNQdS9HQUUyQjc3YnZKNFVEYVRmbzdnUVln?=
 =?utf-8?B?RDVyOWpFNGZlRlRsR2IzblErZXA5Zi9NenEySFpiK2UvbmpNc1lqelRTcW5R?=
 =?utf-8?B?emp2K0JuZ3RnU25uNkpvQ3ZQOTdaZmRBNU9BRGRoZWo4YWdnSytmVUZrZkw5?=
 =?utf-8?B?ZEM2RGxEOVI5clRJRldHT3FSNlROU3lnUzQwUk5EMGZDUFBVTUJ3clgyRXI0?=
 =?utf-8?B?SmdKVnErYTJyYXVSdUtjWklLejFUR1pYMzhKYm9oeFNGL0JGRi80OGtJbHRW?=
 =?utf-8?B?c2prU3MyVjNLcnRhZG5sNjFQc2tYL3FtYkRzTmYxcmRqeDlOY3JNRGVnRDJi?=
 =?utf-8?B?YXZjbnJTdk1CVENQc1NwL2c3clUvUVVuMDRoQk1Ld1FxYlRMUDdweU9mSzUw?=
 =?utf-8?B?ZjBXWWl3aVh1OEw2MnB3YUt5cFB2TnJsQzlDU1QyU2xGNmNJK24wMXZudGtK?=
 =?utf-8?B?aGtlKzVIalIwYmhaQVRaZGpsbWRGdWJKZTM0NitiK0cyQU5RUjRCRVJvQUIv?=
 =?utf-8?B?MmQ3MkVkakRvQ282YjMwVGFnRzdSTHMyUjRBYWhmRE1XU2YyZFVQKzlFVnhQ?=
 =?utf-8?B?YzdtcC9vL3A1WEp5MUdHa1F1WUttNW1QS0xYZWN3Z2EzVGViZlJ4NFptVHI5?=
 =?utf-8?B?bFZNZHNud3RxUWx5eXFWRlh4d2VYQ3pXYUpWQ3dDSjRDTlR5SGE4TTlNWUJW?=
 =?utf-8?B?L0RVUEZMazBDU3hENm13bnAwak5nRHlkVlp3VnJ2ZkZFdWM4am12Sy9sK3cy?=
 =?utf-8?B?NWZPQXdPR2JMMExvY2RNQTZSOWJPalNMTzI1d21hVjZCUE5iWVpOTTdFM091?=
 =?utf-8?B?RWVUWXdicXBWOUR3S0toeGVSeEZDREU5WEY2cWh3bkgvZkFVQkN2di94S2N2?=
 =?utf-8?B?UnVmaC8yaTZVQ01OWUZqcEpSbE9kZVViSlBKRDZZaHpncHFWdkMxUXZYTGF1?=
 =?utf-8?B?NS9CWmJxTnVuV3Bob2dvTHhqamw1OVlzcHRucFpJdHB5NldBRXpGTi9CamFw?=
 =?utf-8?B?WmZrcDc1OGhuQkJESk1KYVZpak9SZEtwRUh0Z3JJVnRCL2lOWHBqeS9pSmZX?=
 =?utf-8?B?RjZwRFJQeWtFaHE0dHZWWXFMQXcxRm5qWEVJMllmdERIL2tiRHJDSnEyN21I?=
 =?utf-8?B?dzlmQ0NhcWxKSEF4YzNMMWV6cFZyWGZJcXY1TDdGSGowMWlwRkVnMXN6bEVU?=
 =?utf-8?B?YmJkREgrNUU1UGdQRGYwZjl2MzNFaUJPMUE3Nzh4d3BpR2dIc2dlTHdqOWt3?=
 =?utf-8?B?ZjZRbXJyd3YrUzBGTVd2Z09hbkExOWR0dlMvd3BhNmttSHJYTGwrWjM4d1B4?=
 =?utf-8?B?MmcrckNGcnJyN0RoUkcxSW9HT0swNjJGRForNnRNY1FWS3hFRWNONlY2NEZH?=
 =?utf-8?B?WmVSb2pySWNlZmRMdmhvMmErWXg1bEZZUS9vNEl1ZW9ZMjdDUjk2QUR5a2cy?=
 =?utf-8?B?Z295QWw0YmI4ZTJaTzhLenBTRjc3Y2Z5T0JsbGVCTzdpUU82Y1k0cllKMDRw?=
 =?utf-8?B?ZXFIR2FPWlVoKy9NNTFJdy9lQ2o0Z2UzNHFFZm1UZmN5U0Q4ZlA0OW1JcWp1?=
 =?utf-8?B?TWlONzNzMlhTMDRCQmlGZ1c2di9UUG9VRkl0Wm10YTViMG9zNXFCU0FXb0dn?=
 =?utf-8?Q?gHMXsgNyrOQs1f5V1ru90M2PV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <11051E858865F644B8CA5822C6125487@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31538d62-7fbf-4000-797b-08db659b1fb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 08:01:52.9476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KG1A22i3cgznyZ84g23XJdkM+nXSBRzCf1gPnjJl0Qbk/KzW4zQgaxr4OKak+zt9Ml6Xl92hFsRpZ6D/2yLnjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4374
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230605_010201_245203_AAD29E92 
X-CRM114-Status: GOOD (  13.51  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNi81LzIzIDAwOjU1LCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6DQo+IE9uIDYvNS8yMyAwODo1
MSwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPj4gSW5zYXRlZCBvZiBkdXBsaWNhdGluZyB0
aGUgY29kZSBmb3IgZGhjaGFwX3NlY3JldCAmIGRoY2hhcF9jdHJsX3NlY3JldCwNCj4+IGRlZmlu
ZSBhIG1hY3JvIHRvIHJlZ2lzdGVyIGRldmljZSBhdHRyaWJ1dGUgdG8gY3JlYXRlIGRldmljZSBh
dHRyaWJ1dGUNCj4+IHRoYXQgd2lsbCBhbHNvIGRlZmluZSBzdG9yZSBhbmQgc2hvdyBoZWxwZXJz
Lg0KPj4NCj4+IE5vdGUgdGhhdCB0aGlzIGlzIG5vdCBuZXdseSBpbnZlbnRlZCBidXQgZm9sbG93
ZWQgdGhlIHNhbWUgZm9ybWF0DQo+PiBwcmVhc2VudCBpbiBibG9jayBsYXllciBhbmQgbnZtZSBz
b3VyY2UgY29kZS4NCj4+IG52bWVfc2hvd19zdHJfZnVuY3Rpb24vbnZtZV9zaG93X2ludF9mdW5j
dGlvbi8NCj4+IG52bWVfc3Vic3lzX3Nob3dfc3RyX2Z1bmN0aW9uLyBudWxsYl9kZXZpY2VfIyNO
QU1FIyNfc2hvdy8NCj4+IG51bGxiX2RldmljZV8jI05BTUUjI19zdG9yZS9MT09QX0FUVFJfUk8N
Cj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29t
Pg0KPj4gLS0tDQo+PiDCoCBkcml2ZXJzL252bWUvaG9zdC9zeXNmcy5jIHwgNjcgKysrKysrKysr
KysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMjUg
aW5zZXJ0aW9ucygrKSwgNDIgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbnZtZS9ob3N0L3N5c2ZzLmMgYi9kcml2ZXJzL252bWUvaG9zdC9zeXNmcy5jDQo+PiBpbmRl
eCA5OGJlY2I3YTc0NTMuLmZmNzJiY2ZiMGZmOCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbnZt
ZS9ob3N0L3N5c2ZzLmMNCj4+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L3N5c2ZzLmMNCj4+IEBA
IC00MDcsMTcgKzQwNyw2IEBAIHN0YXRpYyBzc2l6ZV90IGRjdHlwZV9zaG93KHN0cnVjdCBkZXZp
Y2UgKmRldiwNCj4+IMKgIHN0YXRpYyBERVZJQ0VfQVRUUl9STyhkY3R5cGUpOw0KPj4gwqAgwqAg
I2lmZGVmIENPTkZJR19OVk1FX0FVVEgNCj4+IC1zdGF0aWMgc3NpemVfdCBudm1lX2N0cmxfZGhj
aGFwX3NlY3JldF9zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwNCj4+IC3CoMKgwqDCoMKgwqDCoCBz
dHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwgY2hhciAqYnVmKQ0KPj4gLXsNCj4+IC3CoMKg
wqAgc3RydWN0IG52bWVfY3RybCAqY3RybCA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPj4gLcKg
wqDCoCBzdHJ1Y3QgbnZtZl9jdHJsX29wdGlvbnMgKm9wdHMgPSBjdHJsLT5vcHRzOw0KPj4gLQ0K
Pj4gLcKgwqDCoCBpZiAoIW9wdHMtPmRoY2hhcF9zZWNyZXQpDQo+PiAtwqDCoMKgwqDCoMKgwqAg
cmV0dXJuIHN5c2ZzX2VtaXQoYnVmLCAibm9uZVxuIik7DQo+PiAtwqDCoMKgIHJldHVybiBzeXNm
c19lbWl0KGJ1ZiwgIiVzXG4iLCBvcHRzLT5kaGNoYXBfc2VjcmV0KTsNCj4+IC19DQo+PiAtDQo+
PiDCoCBzdGF0aWMgc3NpemVfdCBudm1lX2RoY2hhcF9zZWNyZXRfc3RvcmVfY29tbW9uKHN0cnVj
dCBudm1lX2N0cmwgKmN0cmwsDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgY29uc3QgY2hhciAqYnVm
LCBzaXplX3QgY291bnQsIGJvb2wgY3RybF9zZWNyZXQpDQo+PiDCoCB7DQo+PiBAQCAtNDcyLDM4
ICs0NjEsMzIgQEAgc3RhdGljIHNzaXplX3QgDQo+PiBudm1lX2RoY2hhcF9zZWNyZXRfc3RvcmVf
Y29tbW9uKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwsDQo+PiDCoMKgwqDCoMKgIHJldHVybiBjb3Vu
dDsNCj4+IMKgIH0NCj4+IMKgIC1zdGF0aWMgc3NpemVfdCBudm1lX2N0cmxfZGhjaGFwX3NlY3Jl
dF9zdG9yZShzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+PiAtwqDCoMKgwqDCoMKgwqAgc3RydWN0IGRl
dmljZV9hdHRyaWJ1dGUgKmF0dHIsIGNvbnN0IGNoYXIgKmJ1Ziwgc2l6ZV90IGNvdW50KQ0KPj4g
LXsNCj4+IC3CoMKgwqAgc3RydWN0IG52bWVfY3RybCAqY3RybCA9IGRldl9nZXRfZHJ2ZGF0YShk
ZXYpOw0KPj4gLQ0KPj4gLcKgwqDCoCByZXR1cm4gbnZtZV9kaGNoYXBfc2VjcmV0X3N0b3JlX2Nv
bW1vbihjdHJsLCBidWYsIGNvdW50LCBmYWxzZSk7DQo+PiAtfQ0KPj4gLQ0KPj4gLXN0YXRpYyBE
RVZJQ0VfQVRUUihkaGNoYXBfc2VjcmV0LCBTX0lSVUdPIHwgU19JV1VTUiwNCj4+IC3CoMKgwqAg
bnZtZV9jdHJsX2RoY2hhcF9zZWNyZXRfc2hvdywgbnZtZV9jdHJsX2RoY2hhcF9zZWNyZXRfc3Rv
cmUpOw0KPj4gLQ0KPj4gLXN0YXRpYyBzc2l6ZV90IG52bWVfY3RybF9kaGNoYXBfY3RybF9zZWNy
ZXRfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+PiAtwqDCoMKgwqDCoMKgwqAgc3RydWN0IGRl
dmljZV9hdHRyaWJ1dGUgKmF0dHIsIGNoYXIgKmJ1ZikNCj4+IC17DQo+PiAtwqDCoMKgIHN0cnVj
dCBudm1lX2N0cmwgKmN0cmwgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4+IC3CoMKgwqAgc3Ry
dWN0IG52bWZfY3RybF9vcHRpb25zICpvcHRzID0gY3RybC0+b3B0czsNCj4+IC0NCj4+IC3CoMKg
wqAgaWYgKCFvcHRzLT5kaGNoYXBfY3RybF9zZWNyZXQpDQo+PiAtwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIHN5c2ZzX2VtaXQoYnVmLCAibm9uZVxuIik7DQo+PiAtwqDCoMKgIHJldHVybiBzeXNmc19l
bWl0KGJ1ZiwgIiVzXG4iLCBvcHRzLT5kaGNoYXBfY3RybF9zZWNyZXQpOw0KPj4gLX0NCj4+IC0N
Cj4+IC1zdGF0aWMgc3NpemVfdCBudm1lX2N0cmxfZGhjaGFwX2N0cmxfc2VjcmV0X3N0b3JlKHN0
cnVjdCBkZXZpY2UgKmRldiwNCj4+IC3CoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgZGV2aWNlX2F0dHJp
YnV0ZSAqYXR0ciwgY29uc3QgY2hhciAqYnVmLCBzaXplX3QgY291bnQpDQo+PiAtew0KPj4gLcKg
wqDCoCBzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+PiAt
DQo+PiAtwqDCoMKgIHJldHVybiBudm1lX2RoY2hhcF9zZWNyZXRfc3RvcmVfY29tbW9uKGN0cmws
IGJ1ZiwgY291bnQsIGZhbHNlKTsNCj4+IC19DQo+PiArI2RlZmluZSBOVk1FX0FVVEhfREVWSUNF
X0FUVFIoTkFNRSwgY3MpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXA0K
Pj4gK3N0YXRpYyBzc2l6ZV90IG52bWVfY3RybF8jI05BTUUjI19zaG93KHN0cnVjdCBkZXZpY2Ug
KmRldizCoMKgwqDCoMKgwqDCoCBcDQo+PiArwqDCoMKgwqDCoMKgwqAgc3RydWN0IGRldmljZV9h
dHRyaWJ1dGUgKmF0dHIsIGNoYXIgKmJ1ZinCoMKgwqDCoMKgwqDCoCBcDQo+PiAre8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgXA0KPj4gK8KgwqDCoCBzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsID0gZGV2X2dldF9kcnZk
YXRhKGRldik7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcDQo+PiArwqDCoMKgIHN0cnVjdCBudm1m
X2N0cmxfb3B0aW9ucyAqb3B0cyA9IGN0cmwtPm9wdHM7IFwNCj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwN
Cj4+ICvCoMKgwqAgaWYgKCFvcHRzLT5OQU1FKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgXA0KPj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiBzeXNmc19lbWl0
KGJ1ZiwgIm5vbmVcbiIpO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXA0KPj4gK8KgwqDCoCByZXR1
cm4gc3lzZnNfZW1pdChidWYsICIlc1xuIiwgb3B0cy0+TkFNRSk7wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBcDQo+PiArfcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXA0KPj4gK3N0
YXRpYyBzc2l6ZV90IG52bWVfY3RybF8jI05BTUUjI19zdG9yZShzdHJ1Y3QgZGV2aWNlICpkZXYs
wqDCoMKgwqDCoMKgwqAgXA0KPj4gK8KgwqDCoMKgwqDCoMKgIHN0cnVjdCBkZXZpY2VfYXR0cmli
dXRlICphdHRyLCBjb25zdCBjaGFyICpidWYsIFwNCj4+ICvCoMKgwqDCoMKgwqDCoCBzaXplX3Qg
Y291bnQpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcDQo+
PiAre8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgXA0KPj4gK8KgwqDCoCBzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsID0g
ZGV2X2dldF9kcnZkYXRhKGRldik7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcDQo+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBcDQo+PiArwqDCoMKgIHJldHVybiBudm1lX2RoY2hhcF9zZWNyZXRfc3RvcmVfY29t
bW9uKGN0cmwsIGJ1ZiwgY291bnQsIGNzKTvCoMKgwqAgXA0KPj4gK33CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwN
Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIFwNCj4+ICtzdGF0aWMgREVWSUNFX0FUVFIoTkFNRSwgU19JUlVH
TyB8IFNfSVdVU1IswqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwNCj4+ICvCoMKgwqAg
bnZtZV9jdHJsXyMjTkFNRSMjX3Nob3csIG52bWVfY3RybF8jI05BTUUjI19zdG9yZSk7IFwNCj4+
IMKgIC1zdGF0aWMgREVWSUNFX0FUVFIoZGhjaGFwX2N0cmxfc2VjcmV0LCBTX0lSVUdPIHwgU19J
V1VTUiwNCj4+IC3CoMKgwqAgbnZtZV9jdHJsX2RoY2hhcF9jdHJsX3NlY3JldF9zaG93LCANCj4+
IG52bWVfY3RybF9kaGNoYXBfY3RybF9zZWNyZXRfc3RvcmUpOw0KPj4gK05WTUVfQVVUSF9ERVZJ
Q0VfQVRUUihkaGNoYXBfc2VjcmV0LCBmYWxzZSk7DQo+PiArTlZNRV9BVVRIX0RFVklDRV9BVFRS
KGRoY2hhcF9jdHJsX3NlY3JldCwgdHJ1ZSk7DQo+PiDCoCAjZW5kaWYNCj4+IMKgIMKgIHN0YXRp
YyBzdHJ1Y3QgYXR0cmlidXRlICpudm1lX2Rldl9hdHRyc1tdID0gew0KPg0KPiBJcyBpdCByZWFs
bHkgd29ydGh3aGlsZT8NCj4gVGhlc2UgYXJlIGp1c3QgdHdvIHN5c2ZzIGF0dHJpYnV0ZXMgd2hp
Y2ggYXJlIGdlbmVyYWxpemVkIHRoYXQgd2F5LCANCj4gYW5kIGl0J3MgYWRkaW5nIHF1aXRlIHNv
bWUgYm9pbGVycGxhdGUgY29kZSB0byBtYWtlIGl0IHdvcmsuDQo+DQo+IFBsdXMgSSdsbCBwbGFu
IHRvIHJld3JpdGUgYXV0aGVudGljYXRpb24ga2V5IGhhbmRsaW5nIHRvIGxldmVyYWdlIA0KPiBp
bi1rZXJuZWwga2V5cmluZ3Mgb25jZSB0aGUgVExTIHN0dWZmIGhhcyBiZWVuIGFjY2VwdGVkLg0K
Pg0KPiBTbyBJJ2QgcmF0aGVyIG5vdCBoYXZlIHRoaXMgb25lLiBCdXQgbWlnaHQgYmUgY29udmlu
Y2VkIGlmIHNvbWVvbmUgaGFzIA0KPiBhIG1vcmUgY29tcGVsbGluZyByZWFzb24uDQo+DQo+IENo
ZWVycywNCj4NCj4gSGFubmVzDQoNCmxldCdzIGRyb3AgdGhpcyB0aGVuLCBhbmQgbWVyZ2UgZmly
c3Qgb25lIC4uLg0KDQotY2sNCg0KDQo=

