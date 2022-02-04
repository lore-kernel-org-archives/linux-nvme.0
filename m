Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C73AC433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Feb 2022 02:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ydFvNs7dsxEPIshrQg/O1O6PJx7s+GCflEiUqoNQKdY=; b=nfQvjKJdp/0jYZ19F8wYCqbrpc
	OP2YXrJx0Hxl71/NVqXMjK2180y9E+CANEk5DI6vg63t40Gx/AG/tycyYosF54U84JOu25iceoVC+
	xmyccuUe+33DBBTe5/U1X8yB88/oF8Zm4NIC5TPc9r5yBqMo19sbY5+93BiZ+Kp9sfgzczqnb/R9V
	606G0zkJGGWNMAlb72fesU7EJ8lWlm51YoP6Ru9hzKZZlx9VMAdIiAnnhmrDfF8syAn1fWT99e3js
	1htzzJmbcAbow8qk2j6bwHmvsN4GHB296vewT7r/MdfcaMhU5GFEYtRtJJ8iTa09w/VuaS+LNhYMv
	0ImROCjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFoFY-003GpL-BM; Fri, 04 Feb 2022 02:23:00 +0000
Received: from mail-dm6nam10on2089.outbound.protection.outlook.com
 ([40.107.93.89] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFoFW-003Goy-8M
 for linux-nvme@lists.infradead.org; Fri, 04 Feb 2022 02:22:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhoyMaI/6Cx96GTvnZxfBhXN9hlyouvjt9K+RO8cFXRvF93pizYohjMa0hDGAmIaFXSm8EIaUkHBIpUlbAOVo4SStseaGp4OmAA87ifPEML8VfP9UEgE3jx8XnNWg0ktOMiiutorLybIfZL68wtisDzEekM3ETt9HuG9wIGRJKNp0gEWbEN1oK8E+80RlDOMb8Y8H2djpgw+wIFaPYLW8VdlrxKSapbjrcjcfpt0YOWHPIpaO9mk8GeyTCo4fOCZRMvjjGpVl1oHc4xak+uxHhxV0DoHLfw05r/jn7URUY7uQjLFycp5oHYja8wAEtKttXwMNFeunmD6FHRKQloFJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydFvNs7dsxEPIshrQg/O1O6PJx7s+GCflEiUqoNQKdY=;
 b=Fa9M4iHGrAI9l1hkedO3hQamfq8fcczVP5pbRkCiPhWUG7MIE1tqvq0XkrLu2dsd0B2w3y877oG2zwCbvbcfa+b0NdEixF7dtOEBZdwlv17ednLfV9c+2DoSSfeTFaY2hRV8KH5hWhFijMGKOI0c/hHWBJUAGEcbAXviqS7p7xSvS+/Q7l/ID0hRCiqj9Z+6wyQF+6qUGjHwr0dK9Z3a9jnWUa1UIAhkNoszwb5XNCTH1pPP/bHkeXdD2ZdWsu0Ct406D+rjKfue+MPnu+5u0KO9BuEtx9JCbgqjckY4JbT95unFcNoMnORbDerU1wASOVccJvH2NIygEJYYnFRERQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydFvNs7dsxEPIshrQg/O1O6PJx7s+GCflEiUqoNQKdY=;
 b=hPwwsXzSMygNGNY0M4Xxr97QNj/mIRnpWM4tiiGHWhuJ1adC5iZNILU/EE2WH3akIlnPKM5HbeQasv5SoHJaWJUzo6YU43q81mGCNzS/9QLO63L55gzN956RGUUOsfNILMP/aDoPemZwPQvqjzLLNledYV4Xkbb07dj//2aHtdzvtv9PuXaZeH2kBbJJ1eJhgoxWU3H9KyM8YIZKWiFOHstA4bbgLYV/dxtgC0H5n7f59DcFepsqlmrck+P6ZAZ9wKmI1WHTPCZY3yJvJbu4ZEmSR2ZsvCPkLNBIg/0XLbREaEavH03L64ziMaLSnuLjeRXOnUJ/C8fAu9d7z1nTyA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY4PR1201MB0247.namprd12.prod.outlook.com (2603:10b6:910:1b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Fri, 4 Feb
 2022 02:22:54 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%5]) with mapi id 15.20.4951.014; Fri, 4 Feb 2022
 02:22:54 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Martin Belanger <nitram_67@hotmail.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "hare@suse.de" <hare@suse.de>,
 "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me"
 <sagi@grimberg.me>, "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>, "rafael@kernel.org" <rafael@kernel.org>,
 "charles_rose@dell.com" <charles_rose@dell.com>, "stuart_hayes@dell.com"
 <stuart_hayes@dell.com>, Martin Belanger <martin.belanger@dell.com>
Subject: Re: [PATCHv2 2/3] nvme: Add device_update_groups()
Thread-Topic: [PATCHv2 2/3] nvme: Add device_update_groups()
Thread-Index: AQHYGUP8rNFjtEBvTkGzLwB685XHLqyCqbGA
Date: Fri, 4 Feb 2022 02:22:54 +0000
Message-ID: <125a7200-3797-3ff2-f8e5-2c3e0b90a594@nvidia.com>
References: <20220203211748.27542-1-nitram_67@hotmail.com>
 <BL0PR13MB42916EA4483338B4BD37BA3E9C289@BL0PR13MB4291.namprd13.prod.outlook.com>
In-Reply-To: <BL0PR13MB42916EA4483338B4BD37BA3E9C289@BL0PR13MB4291.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c094282f-9b6a-4fd5-755b-08d9e785405c
x-ms-traffictypediagnostic: CY4PR1201MB0247:EE_
x-microsoft-antispam-prvs: <CY4PR1201MB02476E2E7B0101FD49EC54EEA3299@CY4PR1201MB0247.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fdwQUVSyaiwA5BddFhAAhV4XtQCUnU8w1AotIeKa234cxBpOSKSt8Nx2UIc3tqEP942LgjzztqpFuoXDyVFbTunyrgfPxTb9cgtMlLMsFJ7hdXiW9s3g7dzE2W84tAMNANPHZTWYgVf1iOrQ4OG6nOoX2ki0slOWhViE6wgJKo7k34f1Wut7wVx534kmgGA/z/Qm0GMh2O4RUY130y8l2mFSK/ibipmJ36sVyG86LMHNZIcS7bJjsY6Z1Ze3jdPT7ndueAzz80XS/Fxylc1+vPfEV61FzRgeR8Gtg1RCFrpq4VZEQ1ETy5PWyp7ouSv8RNQtXN1ZjEYOTRiLz/4aH0bd53jOmBnGi6RT8Wmg9Kd/MpVRnVfDGeSgEyq4dtje4TNS7AH6lLAUsqNPb9SrMcJuTXZb72SiqJ+9wQpAPfd74y1sPDSmk40AWw5zwM9EKf7JD7W5TrPTBCB55lR1uh02idR6QYOdM9xus62fBnbbcR0lRGWhXeWvXoPFp5LT+OcpsvkFnSHhVWB2/UmRGYfI3AMsJ/yA+pBAEfURmHLXsj+8OGIs7dulh4nUuJhtbtHHSxFSELH68V5JGA5a06kb25F8J8fdLSwNVg+pQpZhX8e/HRZrDWEexGjp5/ekxHoSfbape5nF421OTFENn33Di4rs4Y+xg3JN+Ic61kI2MAw0umgvgTBKndvXlR5MnQEGANvt4rt/ZhKY3gxiVETKiNsfCw2DXQ1rLX4kLTNqIAhfDHiZT51S3vMGA0+30hTdhEDmmERjOwqP7TUNQQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(76116006)(6506007)(66946007)(2906002)(8936002)(66446008)(2616005)(66476007)(8676002)(38070700005)(66556008)(31696002)(64756008)(91956017)(36756003)(4326008)(86362001)(316002)(508600001)(31686004)(83380400001)(53546011)(110136005)(5660300002)(38100700002)(186003)(6486002)(6512007)(71200400001)(122000001)(54906003)(7416002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFhLbE5BcHhSUlJQdGxWZWJnY2VMTFlmWUVjdHFQYUhXeUVqeTV5NFF2akZN?=
 =?utf-8?B?QXVQdUp1YmlReWlESzhvM21saWxVQlB5eWtjK1NZcm9URjBsYmpkbkM5K0dy?=
 =?utf-8?B?aUczbm4yT1hvOUZlR0dwdVNZVWw2Q0d5c1NtUkppbFFmSDVvVjd6MmNMWWZF?=
 =?utf-8?B?N1NLN0M4WjF5eENFd1I0cUJlM1VESWcvM2ZZOG9nT2VCM0pCbWhyKzFlR0pm?=
 =?utf-8?B?WEdOYWR0TEluSUhwRm8vY2VQYmdWZFVObUhVYVFMbEtXVXhhaGZlRkNOMjd5?=
 =?utf-8?B?Tytpak1FODMwNlZXTVpOS1FocTUwZUUrWDRpTXJoRllDUmx0a3U1M2dXdnRy?=
 =?utf-8?B?bEwyY2VxYm14YldkdkdtOG1IM3JockdTcHhXQzhSTHFvT0pBTzNYNmkyRFRm?=
 =?utf-8?B?dXF3bzQramVXc1I3V0c4ODdsVTRGMklVdUhMZ1htejFPUFFwWGdoYkw4THdS?=
 =?utf-8?B?ZjkxSDBGbUdtRk9TRkZEczZwWUdJbStrZU9mUUg2K09XaGEzSFFVTEhkeXRJ?=
 =?utf-8?B?V3ExSzFBMVhuUzlyNWhnT1FQSGtSSmpPK3ZaZG8wa1ZFL1RPUGlVelF3K1V6?=
 =?utf-8?B?SEw4clZTdHc5cGN0cEliSmNhQjFteG1zbW1DMEh0SzhkL09JMWpweU03Z05J?=
 =?utf-8?B?N2VpMGpoVjFlaUZjSFZWRkpHdVBFZDdaUlZrSDNPTXc0YmhUTlg2WCtzVDFj?=
 =?utf-8?B?ZWhyMXVUNTI3Vjhva3pZRExuZkZnRWI4enJ1aXpGTjY4ZDc2eDljM1JEcjNl?=
 =?utf-8?B?bmJhSmhQSmt3eW9CeFVERWJKUmdSSm9UM1NZc1Zwekd5eGNnMnNrN3ByVTZo?=
 =?utf-8?B?cThNQ0Z2WjV4Wjc2d3ZOUG5RT1lNR0dhTm9xZXEyM2VHWk96NDY2Mlo2cXJs?=
 =?utf-8?B?dkxqSjVtSEQwSUVzMGNpaW9GYVJxQWhReERuMzY5MnZDbFNWMm50bU9xUWgz?=
 =?utf-8?B?QS9mV011ZXh3a2laREU4N2VNVWg3RUtobVh6QmhvbDduWEN3T3JWTkd5aERP?=
 =?utf-8?B?RlF0enc4Nit3eWRsN3ZyL1ByVEd5M3IvZHRoTkNod3V6S0JJNVJoN0JnZWxk?=
 =?utf-8?B?ZWdMd2R0MkVuUWZTckZsZ0pDKzhQU0hxWVdFRTJtcytpcDh4M0FLa3VYdEJr?=
 =?utf-8?B?UUFiN3h2Rm1FRTN1dGlWYnp1a1g5bk5lM3RhYWVYNzV1ZkZZUHRXM1A0M2w3?=
 =?utf-8?B?M1BoenVzTDNwNEJ1QURmeE8xOEJZTnNoeEF0blZ3YkV5M3NWc2lzM0tsSk1B?=
 =?utf-8?B?K1RNRXZ0MHI1bHN5UkZyWTFWazduNThkK0o0SXQ4MmRNclY0bzFmZVp3R0Fo?=
 =?utf-8?B?V2xJWk1CTzR0ZnlZaFJiaWhhSS84TXplckZHR3NRV000MWlieERXdWNCWHMw?=
 =?utf-8?B?dHVZM2VhUEM3cVJKT2RQVnV6VDZIQ0YwVEV6T2NXVThEREZ0YjVVTTYvM3dF?=
 =?utf-8?B?Q0RpeXRIOUZ5aEQ1d0V3OEkzL3dnelUremZEREhpMVVWNXRuN2ozTkxNdmI2?=
 =?utf-8?B?WVFZeDJrNmpMbW1uMDNCVEQ1QW83eHAxN3REZDVLZVpIaG40V3pBd0JPa1dD?=
 =?utf-8?B?R0RBQ3JNcFBsUE5MOFRlR1o1ZzQwZmk3aGhiSFdPM1JFTGxMenpWUHFzNVZ4?=
 =?utf-8?B?WEZNblBjeHBYMWJEZmF4VFREZnliUlljZ0hwZHFSemRRc2pNV2t1L0xOWlpZ?=
 =?utf-8?B?WGVjMU56N1FsMGxwQmlsTTVuVVE4eG9xQnlYdy9lUTdnd0JaaUM1aStxQ3d5?=
 =?utf-8?B?dDA1bUpCWTdCTDFHdk90UGhrOER3ZHhvSUhhOXJZc1p5VHNMTUh6RHg1R3Vt?=
 =?utf-8?B?anRvcElSWHNYZitqdkk3OGFlRkR6WnBsb2RialJuRDR6d2JRMDZpQ3czTjRx?=
 =?utf-8?B?V3l3Q0ZhR2tQL1gycW40WjVkZlI0YUlIWXc0SVlhOGduTDJndElsc2xGbk9H?=
 =?utf-8?B?ejh1MDZGeTlZaHFHN2U1cmVsYjZWUFpJYWt4T01Md3VyN2szWGV4bnlLZjVF?=
 =?utf-8?B?bk5keDVzejRkYm5RYUVSRHJqZjRLbzdMQ1NGcGdXcUJSK3ZBMmNrNDNIM2Jt?=
 =?utf-8?B?OWJuaHFkY2NpYTNhaE4rbko0UjB3bHplNnpIcTR5Q0ZIZjhQT0RjczFXMEM0?=
 =?utf-8?B?aGpWWUNmaTdSQ2x3ZFV2SW9hTGk2bVA0YTNDbFdlMC90UnM3M2VBMDZsNEVU?=
 =?utf-8?B?cTNMcWNYRVJCZW5jQWd5TzlxWjZKMS8zMzhOd3B0YVFBb0NGSmxKNE81dkU0?=
 =?utf-8?B?dkRNRktzazcvN0VIZXE0K01ITGJRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <05DA7D1F27C7304F85C707DF8C456E99@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c094282f-9b6a-4fd5-755b-08d9e785405c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2022 02:22:54.5009 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ieJHMmW3Smc61llOlBd9m0h8ZD05xQU7aGGZ3ijKtjVskFl7rKlnQDWh3o9a53YuZGrgCctapfnBfBjj74wAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0247
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220203_182258_330389_B22BBA49 
X-CRM114-Status: GOOD (  20.20  )
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

T24gMi8zLzIyIDEzOjE3LCBNYXJ0aW4gQmVsYW5nZXIgd3JvdGU6DQo+IEZyb206IE1hcnRpbiBC
ZWxhbmdlciA8bWFydGluLmJlbGFuZ2VyQGRlbGwuY29tPg0KPiANCj4gVGhpcyBpcyB1c2VkIHRv
IHVwZGF0ZSB0aGUgc3lzZnMgZ3JvdXBzIGFmdGVyIGRldmljZSBvYmplY3RzIGFyZSBmdWxseQ0K
PiBpbml0aWFsaXplZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hcnRpbiBCZWxhbmdlciA8bWFy
dGluLmJlbGFuZ2VyQGRlbGwuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL2Jhc2UvY29yZS5jICAg
IHwgMjggKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgIGluY2x1ZGUvbGludXgvZGV2
aWNlLmggfCAgMSArDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9iYXNlL2NvcmUuYyBiL2RyaXZlcnMvYmFzZS9jb3JlLmMN
Cj4gaW5kZXggM2Q2NDMwZWIwYzZhLi4wYjVmNmQ1ZDI0NTkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvYmFzZS9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy9iYXNlL2NvcmUuYw0KPiBAQCAtNDQ3Myw2
ICs0NDczLDM0IEBAIGludCBkZXZpY2VfY2hhbmdlX293bmVyKHN0cnVjdCBkZXZpY2UgKmRldiwg
a3VpZF90IGt1aWQsIGtnaWRfdCBrZ2lkKQ0KPiAgIH0NCj4gICBFWFBPUlRfU1lNQk9MX0dQTChk
ZXZpY2VfY2hhbmdlX293bmVyKTsNCj4gICANCj4gKy8qKg0KPiArICogZGV2aWNlX3VwZGF0ZV9n
cm91cHMgLSB1cGRhdGUgdGhlIHN5c2ZzIGdyb3Vwcw0KPiArICogQGRldjogZGV2aWNlLg0KPiAr
ICoNCj4gKyAqIFJldHVybnMgMCBvbiBzdWNjZXNzIG9yIGVycm9yIGNvZGUgb24gZmFpbHVyZS4N
Cj4gKyAqLw0KPiAraW50IGRldmljZV91cGRhdGVfZ3JvdXBzKHN0cnVjdCBkZXZpY2UgKmRldikN
Cj4gK3sNCj4gKwlzdHJ1Y3QgY2xhc3MgKmNsYXNzID0gZGV2LT5jbGFzczsNCj4gKwljb25zdCBz
dHJ1Y3QgZGV2aWNlX3R5cGUgKnR5cGUgPSBkZXYtPnR5cGU7DQo+ICsJaW50IGVycm9yOw0KPiAr
DQoNCmNvbnNpZGVyIGZvbGxvd2luZywgY2FuIGJlIGRvbmUgYXQgdGhlIHRpbWUgb2YgYXBwbHlp
bmcgcGF0Y2ggOi0NCgljb25zdCBzdHJ1Y3QgZGV2aWNlX3R5cGUgKnR5cGUgPSBkZXYtPnR5cGU7
DQoJc3RydWN0IGNsYXNzICpjbGFzcyA9IGRldi0+Y2xhc3M7DQoJaW50IGVycm9yOw0KDQo+ICsJ
aWYgKGNsYXNzKSB7DQo+ICsJCWVycm9yID0gc3lzZnNfdXBkYXRlX2dyb3VwcygmZGV2LT5rb2Jq
LCBjbGFzcy0+ZGV2X2dyb3Vwcyk7DQo+ICsJCWlmIChlcnJvcikNCj4gKwkJCXJldHVybiBlcnJv
cjsNCj4gKwl9DQo+ICsNCj4gKwlpZiAodHlwZSkgew0KPiArCQllcnJvciA9IHN5c2ZzX3VwZGF0
ZV9ncm91cHMoJmRldi0+a29iaiwgdHlwZS0+Z3JvdXBzKTsNCj4gKwkJaWYgKGVycm9yKQ0KPiAr
CQkJcmV0dXJuIGVycm9yOw0KPiArCX0NCj4gKw0KPiArCXJldHVybiBzeXNmc191cGRhdGVfZ3Jv
dXBzKCZkZXYtPmtvYmosIGRldi0+Z3JvdXBzKTsNCj4gK30NCj4gK0VYUE9SVF9TWU1CT0xfR1BM
KGRldmljZV91cGRhdGVfZ3JvdXBzKTsNCj4gKw0KPiAgIC8qKg0KPiAgICAqIGRldmljZV9zaHV0
ZG93biAtIGNhbGwgLT5zaHV0ZG93bigpIG9uIGVhY2ggZGV2aWNlIHRvIHNodXRkb3duLg0KPiAg
ICAqLw0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9kZXZpY2UuaCBiL2luY2x1ZGUvbGlu
dXgvZGV2aWNlLmgNCj4gaW5kZXggOTM0NTk3MjRkY2RlLi5hNjIzNzkwMTczY2UgMTAwNjQ0DQo+
IC0tLSBhL2luY2x1ZGUvbGludXgvZGV2aWNlLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9kZXZp
Y2UuaA0KPiBAQCAtODQxLDYgKzg0MSw3IEBAIGludCBkZXZpY2VfcmVuYW1lKHN0cnVjdCBkZXZp
Y2UgKmRldiwgY29uc3QgY2hhciAqbmV3X25hbWUpOw0KPiAgIGludCBkZXZpY2VfbW92ZShzdHJ1
Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2UgKm5ld19wYXJlbnQsDQo+ICAgCQllbnVtIGRw
bV9vcmRlciBkcG1fb3JkZXIpOw0KPiAgIGludCBkZXZpY2VfY2hhbmdlX293bmVyKHN0cnVjdCBk
ZXZpY2UgKmRldiwga3VpZF90IGt1aWQsIGtnaWRfdCBrZ2lkKTsNCj4gK2ludCBkZXZpY2VfdXBk
YXRlX2dyb3VwcyhzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiAgIGNvbnN0IGNoYXIgKmRldmljZV9n
ZXRfZGV2bm9kZShzdHJ1Y3QgZGV2aWNlICpkZXYsIHVtb2RlX3QgKm1vZGUsIGt1aWRfdCAqdWlk
LA0KPiAgIAkJCSAgICAgICBrZ2lkX3QgKmdpZCwgY29uc3QgY2hhciAqKnRtcCk7DQo+ICAgaW50
IGRldmljZV9pc19kZXBlbmRlbnQoc3RydWN0IGRldmljZSAqZGV2LCB2b2lkICp0YXJnZXQpOw0K
PiANCg==

