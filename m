Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D4EEC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Dec 2021 07:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=37maKeT2i1m7Kf+PGc8/Vyk8YeqM8uem87N4pNNtnD0=; b=f/sSUglHRLJoP3FQPK6NtR0gWM
	4vk6XaEbzp89bFW3pVZWOusUsGqHXILES3ppFF2p2ja6UooVL0mjzHdtBWtPJ7K0oQleUzvDyl3cw
	Lr3RHtZTZvyZJ19YGy0bFQXO/pk0Ee5wgQQSfYSZqNrgQRo8GyZyHMTPWbl9UFWHlnV6o71WvIE3s
	OW6ns58+H7yJp2Lgt0Fdqk6jNB7oGhTGRPySkv3X3Jz3jxvnNjhPBYvKf6VD52IYloTGay3g2iuB5
	h6tuaktvH6/0l91U2I9kFmsfqrbfUYd9zhU9TtsmrUoYgCjSYXo/6GM6f4ahumrquDMWyokcCcsOj
	0kU8zh5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mwg7L-008Abw-6M; Mon, 13 Dec 2021 07:51:27 +0000
Received: from mail-sn1anam02on2063.outbound.protection.outlook.com
 ([40.107.96.63] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwg7J-008AbH-3P
 for linux-nvme@lists.infradead.org; Mon, 13 Dec 2021 07:51:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JboLYeTCZB/ZjJmSsjagmrBpDsuZZ7pJ7rEO6RiOgFuJw03mle3ogbN1+QbFUWlhVOOGpOFI87cx6YmjSiryYs6Dxxg/o1k/5fZcMGXKt11vVLA0qoygKxwt/7kk6INjWJYbKB8wdS4wvee38hmSyZeb8jLRBDNL2V2MjRB3D/exaIEFKC/Bqy8C0x/sA3KhwZTDm96tM0xw5KuByEwmc0Aoj4N1HyeIU1Zs/aDrr93jl4MwvSP8ZZMEgxYLxCo5PJpJj6POLhpeRQkYaXPvxcjINCux0wjpAV0ceBb7BuFOngqCUzJB7LYwuXIPh7bbhwWN7n/0oETR+1eyN8c90g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37maKeT2i1m7Kf+PGc8/Vyk8YeqM8uem87N4pNNtnD0=;
 b=NFjEVVVCL53IRGQocrdlScK+pi1UOttaqxau+hfVpj+GIwgYfQOC/rm9cjtjQJ4JWZmY8jjLKmBNISJqtQ6QrwXSLI4lxTY0iag74gHIvC1htlvbPUFIuxPjByiSMl9gWqa8dGTte0sr06ku0uXRAPuVUsvDBZLbOMwbkzcRyGB+HgW9Haq9rCcjbP3BZolKiSJGirslN3dJ2ZNV3D48hx2cbRBI3rpd1n2UfDaN71SAcv1KFM5Dfgz/+XKM4zQh0zlpxPNQqPeWOXoyvGdPsaQNezJwyV6g3JvbfZBxIIwqbGTEoA3fLVn6TjF0JR8NgSemJOIMVN/53QccJH5Xkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37maKeT2i1m7Kf+PGc8/Vyk8YeqM8uem87N4pNNtnD0=;
 b=Cf9gLjJ6T8N24upe6jBiddcz8ey+I6+cQtGWM88Obj5SRFvQDyh5/K9wkXhLRe8/0uXMjWVXyrYO5rZ8w5mygizIQznae947I/ehIZ9VuR+VrS5qP/WnByVKaa2bzloLHwcDzHl7zUUCrfPYhXNGdK6sfVck5ceeSDb6WMoAdj13hxm01gs6xBrXQ4OxyF/Idz1Ll1gJl1O/dcagruaoBQSaJ5EbOfK7SXhSrLrwKPapi0+v/Q8z7cz/3TPWpOPSxn3iG1b+v7sSyTx3IzuSbgdMyKdarBfFHYkgGllt2+KQo1sFlKuJ13jvJTKKHoD/G22v8TXICKl77ea175vdOw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW3PR12MB4361.namprd12.prod.outlook.com (2603:10b6:303:5a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 07:51:23 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e%7]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 07:51:23 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "wenxiong@linux.ibm.com" <wenxiong@linux.ibm.com>
CC: "keith.busch@wdc.com" <keith.busch@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hare@suse.de" <hare@suse.de>, "wenxiong@us.ibm.com" <wenxiong@us.ibm.com>
Subject: Re: [PATCH V2 2/5] nvme-cli: Adds event number in persistent event
 entries
Thread-Topic: [PATCH V2 2/5] nvme-cli: Adds event number in persistent event
 entries
Thread-Index: AQHX3KnsE9myQ1+JgkKvVlQuas3CPawwMx0A
Date: Mon, 13 Dec 2021 07:51:23 +0000
Message-ID: <83e3dba6-9e85-9dda-0c30-6209a1a104ea@nvidia.com>
References: <1637254648-19500-1-git-send-email-wenxiong@linux.ibm.com>
 <1637254648-19500-3-git-send-email-wenxiong@linux.ibm.com>
In-Reply-To: <1637254648-19500-3-git-send-email-wenxiong@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d47949a7-1f89-45e9-0851-08d9be0d5bd5
x-ms-traffictypediagnostic: MW3PR12MB4361:EE_
x-microsoft-antispam-prvs: <MW3PR12MB4361352C21C257B90F949303A3749@MW3PR12MB4361.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:124;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LRr7i9aqFx62ucTVHf0P46o5rev+qyaoFf++ioBuEa9JHDl/hckYTV+zR/OCG0oXtHQYqRvRqITHWUM5gETiB6z5RwIhyfHAMxqMq/0OB05BuhOO1obuR9/3HkyFJEJgxD3vDHuUrveLFCE71iu4sUALxl1RaNaVknzzB76yEA9+2shSXvA/sJuNvJuuBKUjzGsaeVSaDlHheftlMdnOju4JI2Tn+TOEbJhftdlj2l56XxOEKsZaxkKs1+rmXyBVqDWsv99OnlUwZNI5/v3K4Ue0qSHeGrdyGqxTQ889XZP63JkngjrrhNuXjJcn9PuU8JX0Kju9zDmyubEJgJWLIcWb4oQQFjSawjttNI3uFb7gWWKso9LcU4xL9Z/y5FyovqaIYootuSH3WsCdXMXycLvAktuIZKrTlEmcVPF0G3Ksx1+bO/LhI4QM9q2N+Rzd/sVBi4m9q5gf4LAUDjZXLu7oAqMW/YmQVzkybKFlfYjfPKGaa8NMR6WMHG80Xvo6eWht+dzlJLOdmm98GoUjNItG5MKGGBK8sUsDj78uyUothARryvPTRLw0hCIjVSsG7aCm+H7pPT6wMDZSiWuGyDK/Bk/MLtxbc+OvrqKKAAHNBaD//vaPBAndJEAeJV0XBgD10QeIcEK7vJ2v3gctvES5ZA2SDz8Bzn8XxX/vVvK//qeEJ412b0ZzE4LJOhwVHgH3Qo4XNQyIW5DDdC99gZ/h/S7upb+nhcuiIEep7rcCzTxdbjqsi1+0xM1X9PqAiXZEQZrh/DWILwIeJpvkDQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(6916009)(38100700002)(6512007)(8936002)(54906003)(6486002)(508600001)(316002)(4744005)(31696002)(8676002)(66476007)(66556008)(31686004)(122000001)(53546011)(71200400001)(2906002)(6506007)(38070700005)(86362001)(36756003)(76116006)(64756008)(66946007)(5660300002)(4326008)(66446008)(91956017)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1FjZVltY3hVWURLR0VEcDY2THVnOVpIdUMwQnNWb1NoeEdnWS93UnVQNkNM?=
 =?utf-8?B?enhwUkNYVlNDUDB5SG9WRktCY3B1anltVXJrblA1bkxHTWtLN0V4Q0VFQzZV?=
 =?utf-8?B?VXRkVkRmS2VCTmFUK0E2STFSbFFRWmwvbmd4VkRyRExqRjNoSEQ3eTdWWnVN?=
 =?utf-8?B?VjkzWXYxM2FFL1RYWDZUOXdveVV0ZFVlSnlSTUFJWXlnL2tYS2E5OWllLzZz?=
 =?utf-8?B?RXdRb2RyekNrY0ZOMmgvN01LSmExVEc4WldhRGpuSm5ranFVUFo3K2haZXRk?=
 =?utf-8?B?ZXdZSkhHa1J5WnZzUXM5YmpKUDFQQjk4cS9PR0dIUWp2UXB6UndTNzd1VGJL?=
 =?utf-8?B?bklTeWcyNW9rQXIzd1ErM0oyMXNuSGUxdlZoSk1HYytDaE5HKzlOSWJlZGE2?=
 =?utf-8?B?Yk9Zd1dGUW9uTDdkSkVmUHFHdnlPZjFUU2ZnNnZnVUR5UExCbHZrUy9pQi82?=
 =?utf-8?B?cWcxc1RwVjdrek03dWJuWnRMc09IZVhYeG5BemoxRmt3cVVZSURzK1duN05O?=
 =?utf-8?B?aVpDbkVkTVU2ZE0zS1ltZG96OXpiTS9zdklZUjZza2EvdGpKaEhLb1ZxcXVU?=
 =?utf-8?B?cTVSYkRPNzJOMkxiRGVON2hSQm5WemNiY1BqNkJlMmhlVEkyQUtqc3RwcHda?=
 =?utf-8?B?WG9JQnUxNWxhalM2MU9DSm1YOVNlS1dHSVI0eDkwZm4wa21vc3hDSXBqSmJP?=
 =?utf-8?B?TlBMQ2E0cmg2UlcyWEFkUTdzVlFBNE5oRXFDTit2WFpXTTN5QkFid2pRNTRk?=
 =?utf-8?B?eUVZblNMbzZReE94enA0Y3U2QkI2blZLb0U5UWsxaXVoSkRPMUJUOXdLemJP?=
 =?utf-8?B?Q09FUGlqMTkzc2dTaW1scm1qNTNsbEJ3R2VHeEJWQnprV2E1cDJvdzFBMFJ3?=
 =?utf-8?B?ejl3S0k4TGR0SmxnNGVsK2NjVkZLMm1IUjVBVTdwSW5hRDBhTERoSjVIZTRN?=
 =?utf-8?B?QUhkYWxQc3JRWDVFRUQ3ZFJOdXdWZVBzWWFnQnhUQndPVXl4cjF2eGQzTHBG?=
 =?utf-8?B?c210NmplYitYU09sQ3JZdVhqUGxSRHFnU3FuVkIrcStGcTdEMFd3bEgzTGNM?=
 =?utf-8?B?U1NtWXk5dU52Sll0RERrTXZBcld0VXIyT0dkMWxaOWI1cmVEelFpeThBRUdZ?=
 =?utf-8?B?Mndxb3dhYXZUYzlsT3hCcjQ4L1VQSEdiejVsSGJBV3hSdExDb1ZJdTVsNUEx?=
 =?utf-8?B?VnJzSHl5WUV2NnRQdEgrVUttaFlQMFFDei9yRy8yb0lzSmo1TjNXMnljbEtF?=
 =?utf-8?B?bm82QWlqdWd4d3ovb2QyZmxSU1Y2U2Q2MVpxd2tIa3h0eFlVdjAxaTZzNjZ0?=
 =?utf-8?B?NHgvVFYzWG54M3cyT1F2dDkvTzRPRnNUbitmNGlOZ3U5NzlUdWd0dFRTanMv?=
 =?utf-8?B?ck9Sb0dPK0M2MlRGaXdlWUN4R3J2bG5Kekg0T2ZXbTN6NXduU00zczVzbVV4?=
 =?utf-8?B?WFd5UndrRC9JSkdiVmEzYmJxWnNvU092M05JMUdkTnhXcmNtMFVrQjZ6dEla?=
 =?utf-8?B?bjVQY0FtbmtqNWxHci9CUGsvL3JRMWhsRTJSalQ3UEpLUkVOd3AzcXkyR1Vm?=
 =?utf-8?B?SmQ0VWhnNUwyb3hYU2ZaL3M3bkFEdjZKeHhHdEF5MFlVRktpc3RyeGNtMzQ0?=
 =?utf-8?B?ZGVJTjUrWGhZUE1YZEZsTmdLRm03VzhWOFJpbDhLMkVBNFZqVFlEQmNXQnFR?=
 =?utf-8?B?bzZHRmVUdlZjMlh1emxxa3BWUVRrWGNueU1wTmVNUVhoa1FveGcyS1NOeDV1?=
 =?utf-8?B?NGQvUSt5Q1BqbXkwSnpiLyt4MkZKK2Q1TnZ5L3hoelpwaDNmY3RHNVphVVZv?=
 =?utf-8?B?WVhwTVp1SkFoM005S3d1eHVkUzJNaFdKd1NRTUdjd3BFZXUrRTFMUnlxazFh?=
 =?utf-8?B?TDFnaHljM0NPMmFpLy9zcU01L1EzRDhXdXdnSUtVVVhTcWd3YytOMHBzTFpE?=
 =?utf-8?B?ZWhmeDRBZEVQSk81dWtCZko0aGJBT09jREwxd3NSWWFlY2U3Ynd1bkh2KzU1?=
 =?utf-8?B?NTJwWS9lY1I0ME5UaEVqdWpLVEdJa3BNUGhoME5oVTdBK2owaHRzVktqOHpl?=
 =?utf-8?B?TmRId0RnZHVGMW14b05RSTg5anlPVytnT3VUaTQ1cC9tbDZ2bjcvRzZxeU9k?=
 =?utf-8?B?VHozTmFMOVFtQWN6STJVcVBMTzd4ZVh0THNLMUVnLzMrN0RuN3ZBVWlRNXFt?=
 =?utf-8?Q?3+dpOhUbsyRR2nmmH2JuBVw4IIQRrtPYr4XU8Dqp3aPd?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8355B2D29AABB641AF3F40DE15305A63@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d47949a7-1f89-45e9-0851-08d9be0d5bd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 07:51:23.2666 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KquYSHz8VVu7VREoNPiIO5JNUbg/BvRYx10J/zRzBcHNSuyHi/qw1zHyA+pCRoWW8YNl1m4hqRH0kDVZqll8JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4361
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211212_235125_173784_BDC84D11 
X-CRM114-Status: UNSURE (   7.11  )
X-CRM114-Notice: Please train this message.
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

T24gMTEvMTgvMjEgODo1NyBBTSwgd2VueGlvbmdAbGludXguaWJtLmNvbSB3cm90ZToNCj4gRXh0
ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4g
DQo+IA0KPiBGcm9tOiBXZW4gWGlvbmcgPHdlbnhpb25nQGxpbnV4LmlibS5jb20+DQo+IA0KPiBQ
ZXJzaXN0ZW50IEV2ZW50IEVudHJpZXM6DQo+IEV2ZW50IE51bWJlcjogMA0KPiBFdmVudCBUeXBl
OiBTTUFSVC9IZWFsdGggTG9nIFNuYXBzaG90IEV2ZW50KDB4MSkNCj4gRXZlbnQgVHlwZSBSZXZp
c2lvbjogMQ0KPiBFdmVudCBIZWFkZXIgTGVuZ3RoOiAyMQ0KPiBDb250cm9sbGVyIElkZW50aWZp
ZXI6IDY2DQo+IEV2ZW50IFRpbWVzdGFtcDogNDQzOTINCj4gDQoNClBsZWFzZSByZSB3cml0ZSBh
Ym92ZSBjb21taXQgbG9nIGFuZCByZXNlbmQuDQoNCg==

