Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C917C3DA6E
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jan 2024 04:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iBwoAicExF+qQNwrDX0EtSMmKPNPDg1MNl0DqnlHviY=; b=y2xsgTTteouaVibQwMOuDD6bvA
	FsPFuAuX1DpyVV9gf0mxeV3L51wv48fpPJVkeEkPudUEMWlir7VevzgoPPbWS2MCWxyh50lSSaHbI
	kKW7PLaMGOtFcj+EX4SGlgwgIYw23aiBv3Hx780SZn1sF2FjA2bdflqMq8pw7RrTXdN3IrIKl5f2/
	3Uf44dbr2VXWZu6Uh/hU4mE0GT1NdqfX0ui3MKBrosMebGoASZh7Ha4YsjiI7F4uxE3zUcbNrX3/k
	y3QcyLNd2wcnebxtUFtdtvXmqUPlTbeLcjQTe8NSgbKaeDEIZKniCX8/ljsTZjIVeS5CkZEFhUpDB
	BN8AU/aA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNQL0-00AIgD-2g;
	Wed, 10 Jan 2024 04:37:10 +0000
Received: from mail-co1nam11on20601.outbound.protection.outlook.com ([2a01:111:f403:2416::601] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNQKx-00AIfB-0g
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jan 2024 04:37:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKwbgTkIl+Mg+YQg8LnfUKzZ5Q/Id0rvMnlZsPennU+rekpNGNDBlcPVp+jgJ+zRsqIHoS1iHZvjdRPXcPyqgHW0BmjuYzE6VW7gukie1mf6RDsrBOSAJAqF3+rRIjleA6OJi4pUddIA5ghcbLW57Rix2mgnhIovWh5Z/jhMlq/xqH5dGMlKxmleUT2dmDKo8u/VpGkurMvvFpYOHtuWJ734ruV9CpoW06cMf7pWrISF263VvnG1BfdT7UenoYwA/Sn1lGs1CvvVE70L6Fhw7/MKgC2yUkfV99jTWwn3AbtOH8jhf8giY3V7YGwxEAnV/T/CJ1pm9XTcnbtVsPFmGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBwoAicExF+qQNwrDX0EtSMmKPNPDg1MNl0DqnlHviY=;
 b=YqRQNWhS8CzeLYln1APd1RUcg9qfHu57R2ns00QJRFYnbvV1YuQtp762o7RFbE/58CkcBaJUdtuLwdUiSVbG8SHMlH+4KWsnAGJ7ULsLdCw3iPb1rcFm62z8+uwPrwwLFt/le+oRgVm5WKg6NFieMJTSP7rJPac5iPF97Q/eT+wsnYJ3TbxLGQMEqZIfL0kwScnGyU/BtMXkjKRs+WwYjqHnb5VkVzC0hJ4J0GVEyU9ezWXuC5SkGFi8yXuNFDT1nE8emRD5nciRCeKgyXFF1/R4te0V7j5rfmUDPsS30Km9TFNx8sLi1T4RvvgyWDQkkLK/eLmaSV2WPqbD2wXnxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBwoAicExF+qQNwrDX0EtSMmKPNPDg1MNl0DqnlHviY=;
 b=Z8q/9Dm7ePQYUh5hcBEuuCUfOfxhlW0tgVTPm3CKR04uI6VwdqgAg7KhgR2vJWnBtQYaI34st9fcHkTrkGUQtExnKTffHi8laJ47SwMdK1eKhl7nNsV+UhPUSeCaKNkjkIXcTmN97s68E9IkYquQp9t3NC9191jPWICstR4wYFrYAkcPYHhBYbMKDvpDN1qKdYRLCt8IhDR+UUQYFnOmQRefgKQsIhPNmXS4PqYS+Xv4TF89p689t5Tgt8sXPcaE9jeyyPAxEBxSqC0cjUeNOff+9KnESC6jUh2OeCfI219qbviE+A0XuMCI7m0q/hYpP3XrMlNVQskQnMJAk5LIUg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA1PR12MB6994.namprd12.prod.outlook.com (2603:10b6:806:24d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 04:36:57 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762%7]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 04:36:57 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, Keith Busch <kbusch@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvmet: support reservation feature
Thread-Topic: [PATCH] nvmet: support reservation feature
Thread-Index: AQHaQvTSXskgE/5Yd0+gQaBkM/K2mbDRtPqAgACstgCAABWvgA==
Date: Wed, 10 Jan 2024 04:36:57 +0000
Message-ID: <a1e024e0-5218-4f94-ae31-05ba30bf77a9@nvidia.com>
References: <20240109121008.15925-1-kanie@linux.alibaba.com>
 <ZZ1713_D7MojvHUu@kbusch-mbp>
 <a56b996e-8d38-42e9-914c-8877182c5cc0@linux.alibaba.com>
In-Reply-To: <a56b996e-8d38-42e9-914c-8877182c5cc0@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA1PR12MB6994:EE_
x-ms-office365-filtering-correlation-id: 1c84da79-a69e-463d-3c2c-08dc1195c790
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ApZc2+OYwF+ZuTjiKTVl6wbIiLLfsUBkpFzOGM5AeCSsolOKYkJkXvsR81ErJ+XS+49XQXIx62OPZElxR3xohT/abKMoRKaGSQnp3JznCzCFHCRl5CqjlP3qLEFA14FtLNEDHCrrj3/21AYag/oZ5QIoUDX832OTzc2sRAYj+V8gg20s67TMzV8sWebRR1Zji1vKUuFMFm6XV7Fm6pWCcbFs0sx8GRO/b0US/TNIPQhcM80Quj4E1P4NHM1hTyXAQbgGv1Z4RBqskpx+cF8fQCKsmZJ9wyvhF9germASOVAnXbcGolQNuh+dycEA76uFvHl7DydjzKIJqxRgjscg1b8ORo0RsgDGCrB8gd+wCvUyTYJRYSDwj7GRbCsQtVMTTvPUpABVBJE6dqtiwdxy6ENA2Zsx46jDdlNzpyb7aRARm7VIgSUyDaBJcmUvVi5+h45r2eM4Cuf98pkQrcmSzpvgTEAhRKoGXHREraS7xbf3FgvTHn5NXCaewDCpcseKBwuWU5k6E8IFz6UIMays851nqobclUwiSWxQRHsj05tUcDLTF+kUuFS7FbWU3eS6aac3nt91lHTl2C7ligoyWovEWMDOqlYUvwmN7Pu3ZwXW73NvQs7ZV2Ivhbe/znJhOZLvkT/litJ3L1Vt+YlizilS1gNQ6dTvotqkDhUGNjCxDTf9Ox+p8xuRu7k5ct/oaojGyMm0RkT0Bjn/YMyQ9aUhqt/EZ1dmjpdY6Yr43lY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(136003)(366004)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(66476007)(31686004)(66946007)(66556008)(66446008)(64756008)(6916009)(66899024)(4744005)(53546011)(5660300002)(2906002)(316002)(8936002)(8676002)(54906003)(4326008)(76116006)(41300700001)(91956017)(38100700002)(6486002)(38070700009)(2616005)(31696002)(36756003)(86362001)(966005)(71200400001)(26005)(6506007)(122000001)(478600001)(6512007)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b21PT3djYnJ6SStKZW8zb21SUFRIN3pmczg2T3lEWWFDd3FqaTV3RWU0VW5N?=
 =?utf-8?B?dWd6U2Z4YmdCY0ZGcTdJYURadHJyb25FUlpTdjYrUWhhRE1aMUFDeVBrbjF6?=
 =?utf-8?B?Qkl2SjlodzNzQ2pWSjhDekdNLzR6ZE9FYTQzeXhsYUd3N2tibVp6bnZtVzZy?=
 =?utf-8?B?YysrbGpLZCs3Snovaml5Y1hkYk16SGorazJiakN2MWpuY2h6TGJsa3JLOVVi?=
 =?utf-8?B?bHBEUVpTZnhwZ2dlbkhFek0zNDJEZVZqaDFoeFV0RUNpQ1FieDdQUW5xeWxw?=
 =?utf-8?B?NGFnUEZCTjlzUU90K3R5SWpmbk56cFZRS2IvN3dMT1BRQllrSG1xQWdld1V5?=
 =?utf-8?B?NlNWeVFDaG82Y0pvUm5BRkxCRVIwdXdtZG8ybVB4UUgrYkxUZkJnNXNDTW0x?=
 =?utf-8?B?d200NmJobHNsdFBPc2tjdXRjOGhzT1dDSXdRR3BPam05QzBJU0FNRCtxRFp0?=
 =?utf-8?B?cUVMZEdiclBIU3lKdVlvQUhXNlZmSUZTRzJzZCtpK0N4VVlyOERIbW1ad1Y0?=
 =?utf-8?B?QlJhSXMzRkYraVZIUjV1WnhDbUJ4dGpXTFRsaEoxYVplZm4zTWhLRWRKaU9o?=
 =?utf-8?B?YjRyd1Q3aEFtRnQ2REVpVm1uSzliald1TTFnV08xZHp3YTUzMjNYUTdYZ3BC?=
 =?utf-8?B?Zm1PK2NYYkVuRHV3aUdEU2VRY1JUWGl0QWJjOXpUa0VUL1FvWWh6WTUzVGVO?=
 =?utf-8?B?RDdrYXp0VERvWGNBc2pDdndwUEovZUxncGI2RjdvclZrMUNXS05aZE10cXZJ?=
 =?utf-8?B?elQ4QXdxUmFDWThRdEIyQnFTcWU0aXNMYkZRWjlMR3F5RUNNcVZybWxKZTQr?=
 =?utf-8?B?c3NXRUFseWlia0ZnWDUzeHZlU3RLT1o4TWVMQXR6Q2s1OTM4RDZYSE1ndTAy?=
 =?utf-8?B?RTd4d21GVE9XZlFlTlpmMzI3MTh5R0tCcTF3UTZmUFE2TEIwdDhacVVWelZh?=
 =?utf-8?B?bktLMTFHbTQzYWI3Y1RzeDcrQTlMM2pZZDZldEFSNTAwcUZpTkQ4WDNudnk2?=
 =?utf-8?B?V1Q2bm43a0JIajlpaEhiTjlpTWZubFFJU0lOOFRHcng4NHVVWkJpYk5pZ3Bi?=
 =?utf-8?B?YnB2bmtiWTZGK2szM0hvd25RNGRod2V3dEJROW1mU2VRcTNGbzc5VXBXOFg4?=
 =?utf-8?B?a3crNkloOUFpcm5kQUhVNXFZd2ZrRUV0VTRYdmd4MmNsMmdCNlRTQjROci9F?=
 =?utf-8?B?SjU5elh6cGNEcUF4U2FFcExQakNWdTdzellTTEZpY2JYZmZndHBCOXErc3lw?=
 =?utf-8?B?MHhOZlFKTzhMWXk3aXpoeExSN3VSNGwyYlNrVlhKU3JUN2pBQlhSZGRzZmRX?=
 =?utf-8?B?Q0pUQlc3TkhmTjZXWGJDaUNHeW5GaC9xRy8xNjZ2YWQ1dW1hQXdxZFcrSEdV?=
 =?utf-8?B?NXlpZUw1VTRhdC9OS2hSdTBVQlFXVWdneU1rZWsvK2Rhb2MySm5WRWlCZ3V6?=
 =?utf-8?B?Y3FKYnA3UjQxbi9DRm80VGNESFlCYWxmRHRrRmkzZUVoM1ZOUDFkQytrTjI5?=
 =?utf-8?B?aUF4dEhlbUZ6Tm1mUEg4eEFvdFpZVDRHdTZiK2xrM0g3RlEzUW5iY2ozMkhJ?=
 =?utf-8?B?YnorWWJDWjdTYjhHNzFFcjVmUENmOUJNUmh2VUErVUk5Q0dLQzJydVdta0h3?=
 =?utf-8?B?LzFrZXA5NnVlTDd3RjZuQXJMWjNhRWFUdXYrVVYrNmR2ZlduZ1ZwNWdBdC9X?=
 =?utf-8?B?Y2lyL2o2c3RYdFJNYW5TQ0IrbjJJK2dYZDlYN05WaitDVXg2SCs0TnZ2TCsr?=
 =?utf-8?B?SXBySjRtM01WNjBYQ2g3ZHRXN3l0bG5CRnpyMnczRXlRekhaSk5tZVpYcVUy?=
 =?utf-8?B?NkVtalBXT2R1TWdNaHBseDR2MUxib29NUC9iWVA4NW9WUU85VExJTHJnbjJw?=
 =?utf-8?B?SU5VTzRqQXczNzc2aEFpeXg3ajMrOG40UkZLQXZyTGQraDRhd3VZWjZXQXNK?=
 =?utf-8?B?Y0dUamhvbjJtYTFESDVWbDNxT2FSL25zcUhMU1orT0JkaHp4Ull5MU42VnpY?=
 =?utf-8?B?TVZJU05zaUkwaDhXTERpeTN3emhlbTFtZjdJM0phbzhZT3MrUEF6MnZ2bTF4?=
 =?utf-8?B?azZVbGE2NXVQb1VlUFAxUmZ5cmM0TU9mQkcwYnp0M1JpY3pjRXBrOS94OUVZ?=
 =?utf-8?Q?/n24Afntxd1zgEpj9kCBcd3pu?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E7933B0DB01EA4DB915BF88EBA2C83A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c84da79-a69e-463d-3c2c-08dc1195c790
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 04:36:57.5073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ityIOFoL6m3CYGzRw2gyG66U5ULi02HdL5HCUkH+Zbgr9tTt5XPhEFtjRqWP819ZKpjK3xRj/4y8bq6/i9W7OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6994
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240109_203707_255709_A02B8C7D 
X-CRM114-Status: GOOD (  12.02  )
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

T24gMS85LzI0IDE5OjE5LCBHdWl4aW4gTGl1IHdyb3RlOg0KPg0KPiDlnKggMjAyNC8xLzEwIDAx
OjAxLCBLZWl0aCBCdXNjaCDlhpnpgZM6DQo+PiBPbiBUdWUsIEphbiAwOSwgMjAyNCBhdCAwODox
MDowOFBNICswODAwLCBHdWl4aW4gTGl1IHdyb3RlOg0KPj4+IFRoaXMgcGF0Y2ggaW1wbGVtZW50
cyB0aGUgcmVzZXJ2YXRpb24gZmVhdHVyZSwgaW5jbHVkZXM6DQo+Pj4gMS4gcmVzZXJ2YXRpb24g
cmVnaXN0ZXIocmVnaXN0ZXIsIHVucmVnaXN0ZXIgYW5kIHJlcGxhY2UpLg0KPj4+IDIuIHJlc2Vy
dmF0aW9uIGFjcXVpcmUoYWNxdWlyZSwgcHJlZW1wdCwgcHJlZW1wdCBhbmQgYWJvcnQpLg0KPj4+
IDMuIHJlc2VydmF0aW9uIHJlbGVhc2UocmVsZWFzZSBhbmQgY2xlYXIpLg0KPj4+IDQuIHJlc2Vy
dmF0aW9uIHJlcG9ydC4NCj4+Pg0KPj4+IEFuZCBhbHNvIG1ha2UgcmVzZXJ2YXRpb24gY29uZmln
dXJhYmxlLCBvbmUgY2FuIHNldCBucyB0byBzdXBwb3J0DQo+Pj4gcmVzZXJ2YXRpb24gYmVmb3Jl
IGVuYWJsZSBucy4gVGhlIGRlZmF1bHQgb2YgcmVzdl9lbmFibGUgaXMgZmFsc2UuDQo+Pj4NCj4+
PiBTaWduZWQtb2ZmLWJ5OiBHdWl4aW4gTGl1PGthbmllQGxpbnV4LmFsaWJhYmEuY29tPg0KPj4+
IC0tLQ0KPj4+IEhpIGd1eXMsDQo+Pj4gwqDCoMKgwqAgSSd2ZSBpbXBsZW1lbnRlZCB0aGUgTlZN
ZSByZXNlcnZhdGlvbiBmZWF0dXJlLiBQbGVhc2UgcmV2aWV3IA0KPj4+IGl0LCBhbGwNCj4+PiBj
b21tZW50cyBhcmUgd2VsY29tZS4NCj4+IFdoeT8gSWYgeW91IGhhdmUgYSByZWFsIHVzZSBjYXNl
LCBsZXQncyBhZGQgYSBibGt0ZXN0IGV4YW1wbGUgYWRkZWQgdG8NCj4+IHRoYXQgcHJvamVjdC4N
Cj4gT0ssIEkgd2lsbCByZXNlYXJjaCB0aGUgYmxrdGVzdHMsIGFuZCBhZGQgc29tZSB0ZXN0cy4N
Cg0KSGVyZSBpcyBpdCA6LSBodHRwczovL2dpdGh1Yi5jb20vb3NhbmRvdi9ibGt0ZXN0cw0KDQpQ
bGVhc2UgQ0MgbWUgYW5kIFNoaW4naWNoaXJvIEthd2FzYWtpIDxzaGluaWNoaXJvLmthd2FzYWtp
QHdkYy5jb20+DQp3aGVuIHlvdSBzZW5kIHRlc3RzLg0KDQotY2sNCg0KDQo=

