Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD58C072A2
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Nov 2023 22:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wSmJ1rKl9+66cXGDzTtx0Z/XPW1S31KQC7ggjhXmWJ4=; b=rrU266RTa9PiKu6LtyAIEM6FaJ
	cxTpAQNXTOUlbIPFQDace2se7Mdc1NA9cKFB95vg6/jwRYUrEjGOOv11xdsrwkvKRIqMTrn8a7mit
	xuVlgYXV7N4IhfYMhnUdOp78V9TBwSff+nj1wHxBCQlZ+YQNk/AleSgQ23H1+hgwSRGueVMDjfYWG
	zqECRdOWfLC00V0hA/0GStiEw8cSQScSal7q5zGVqh7IeCMJFQ3JXzOPTojIBcjd+sNeyDqmVbYaY
	MrLFpsDdXhvXw4AD+63mcAxyw3c0O4zK1X6reZctpHOknyJrTVyNCwMz8QheWoRCRRYzDCQUrH49k
	YUoHcpkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r47nT-007Vmm-0l;
	Fri, 17 Nov 2023 22:58:47 +0000
Received: from mail-mw2nam12on20607.outbound.protection.outlook.com ([2a01:111:f400:fe5a::607] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r47nP-007VmL-1L
	for linux-nvme@lists.infradead.org;
	Fri, 17 Nov 2023 22:58:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3TCK54ChDemBxkpGNObwwQur8RSGrjvzvzMkiwnzDVNJUeGTED40bHu3po4uVA6bVnySt2ye+IEkTfIjytgjyQbfD3tvFt++hjcFeJTkyfOdfgubCkMDJJUGp66OyEyunBVDwQ6seOlGXOuzsOamz5oDV2jfNr7JaFf2NGo0HCwWMiMz5CH3KwL05k05LckD3M0FCL1d20Khyj6AqCMbsK0YnVQsdemdKAf+3AV1DBMOwPPbBaqkR9x4Fkp2bXfD4iz4JRl3W9nDNn2ItGIrw9i81rDOZ7o3uZxf7f+9H7lbHtaoRrXYzox5X8XDBA9iWIyvzcXaMw31p94PsKUQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSmJ1rKl9+66cXGDzTtx0Z/XPW1S31KQC7ggjhXmWJ4=;
 b=XqKLovj+kXI/IGuRGSyFU266OYWij1Wrlo5cRMQfUq1D8IGew5Die2m3Qvm98CxQ/0b4O/YUlDtcazcCvltfSDME+0s6KGukOWNR94lUMU27hR8fWUB4OMxbFs0weafZkUBcmEelXCi7WcQHpIPfYCcWa8JkWtGW5wP//OaX9Lv5ZsYgF8N1C9iOuouWXfG7qle0P2M8PyQR2b6L0dwc0yE3Ixfo3LFERTbRSjJ77siXtsWgArXb8ApH+HnWC3A7/uUXLsuU8j7QdGAmqqF3e7VjXUbp/87Yd+ijnHwRGUrGp/B/pmwwOI0yXzdrfijRqfYMe3XBgPalieosI0E68g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSmJ1rKl9+66cXGDzTtx0Z/XPW1S31KQC7ggjhXmWJ4=;
 b=R4JCpT/zG6iXVP6j960gCaCd39wy4J0KcPUbbMCEwU2mMJqNUh+M91umwkor5QxPY38n1iIdvMZLITy+RKA3Q/daEqI0P/mfdkhRudTm5OnHWGXzl2bG3KgGbQN+ORin/ZdLUcszttaAbJAEcrc58HJdgjYb8s+CdOj3zAAphIMQVLb/yrNsbyBvw8v0uzCTAjMuVg7WRDvBdS3nDtkIcQ/D9LqrVsMNOVAliVcWWG6O/V14JcgKMwe8ExyEMPBpPf0ti1HaH/gcVlGBieQJTxCxz/m5+/En/6OK9Rza0em1iwNkjXik51qJeMNlIL/7npBX/mXjLxjiQNcyou7mZw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA0PR12MB4511.namprd12.prod.outlook.com (2603:10b6:806:95::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Fri, 17 Nov
 2023 22:58:33 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762%7]) with mapi id 15.20.7002.021; Fri, 17 Nov 2023
 22:58:33 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"kbusch@kernel.org" <kbusch@kernel.org>
CC: "zahavi.alon@gmail.com" <zahavi.alon@gmail.com>, "csander@purestorage.com"
	<csander@purestorage.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2] nvmet: nul-terminate the NQNs passed in the connect
 command
Thread-Topic: [PATCH v2] nvmet: nul-terminate the NQNs passed in the connect
 command
Thread-Index: AQHaGVgHt7i2QY7E2kCMQMDad28zObB/IH4A
Date: Fri, 17 Nov 2023 22:58:33 +0000
Message-ID: <2f988019-df73-43e6-923b-7645a7ec3079@nvidia.com>
References: <20231117131336.126505-1-hch@lst.de>
In-Reply-To: <20231117131336.126505-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA0PR12MB4511:EE_
x-ms-office365-filtering-correlation-id: 2197124a-b078-483d-7891-08dbe7c0b99a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l2jM0sIwHGYZzrr/CfzkhkhcNAD2CJuWOZWdiCZiL1x5056DicuQmTGuODfvKpKqyYfKEdBO0WCVb9PPK5A0CkuvEkUlGMnLk8wAe257nSBqpyKAtYQiFOmet+lTV7OlpgnJWaNakeHZanXJUrqrFpDHuVhqh+a/mZE6acrFlBNnDYWJAQhQNobk9F/ICfOvHbjjSUuQa8tsz4mgtRmAxlaefYCef2ybxeL7CdDvV0x3TEeTtdeW8X+yv9ApvZ7N04502bvbxLKU79SUbA+FE/fBfDrAxfiaFlB6wcNbOIGq3LD4+MlCCsS5ChzfTpT7mXEQgHzF32ptgxzo9jgWGR6ZBozL8ystLShidutoLpll4sompM6Bcs/N9AFiXYzqgOl0LPSvlibKv7fiNHz+K/7u5jzbcSGET4wH4zRKu1kS31i2oRRH9T7MjxN61Qn0pbI7KYaDbnAmF3bSaukhMefBcCZo71/gcbhYg9e6br/t4XxuYOy7Ny8WDHTxHNMA/3M9nfMFwGqIbMYATe9R/VUqWXKSWf/zoB5o21BF6hUM+IGzeg//gHu+G229Q9Z09AXoXEwh3xUToxwWOBzKTJDLzCI+M0yDLa+IeebwPLxnJPhGoSP8Z/w9SK20xYSzpJ1kfTg74WAe4AE/r4eA1UDhwHn6Q1eGd5PpLRREWgFcWgT0nbwAlhmeYYpD6F3a
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(136003)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(8936002)(4326008)(8676002)(38100700002)(86362001)(5660300002)(71200400001)(2616005)(76116006)(66946007)(66556008)(66476007)(478600001)(316002)(31696002)(31686004)(122000001)(4744005)(2906002)(64756008)(66446008)(54906003)(41300700001)(110136005)(36756003)(6486002)(91956017)(6512007)(53546011)(38070700009)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjZUVGdDaWdqL0MxZ0FXQ0NCR2lUdm5FejVSSXUyaGR2bjNSdnl6aGpvV29p?=
 =?utf-8?B?MG9QcmJZNWFmSXlTMUFLMzY3bU9wUkNYdU5zUFVreGtEWi91cHdycFRBcGhl?=
 =?utf-8?B?TEhNQndGMm1XTnkrNi90NnE1M25rM0d6aldSRnFkK1dxTnBzRXFrWWRNTlQ1?=
 =?utf-8?B?emhYTjI1WjNBaW41TzFKZ0VpeXNwczd1UWp6YTZuSTV3N29LdjBLbnNhUDJv?=
 =?utf-8?B?My9hN1FxZ2JJR2ZUZHk3L1A3Y0VocnQvNFRKN2I0QXdvelZheWdxS2EzOXIv?=
 =?utf-8?B?cVB6SlFQTDV5R0puS2M0QXZvMUZPS0VCaDZyR05JTEpXVXBLcGVzelRFak9U?=
 =?utf-8?B?VGFzWlVDY25DR1liWEpsWnVHNVNDRmVRQlN1c3JrcXFWdi9lcC9BTmFrYlkr?=
 =?utf-8?B?VklseWNYNUNuZmVlY25VbS9IeFRhbCtsdS9maVpUbG5wSVMzeDU5dWE4OHZ6?=
 =?utf-8?B?SzU5L0xncTUzQjNQVlFRNXcyQ2hNWHR2eHY0bm5YWHZRT1psOHVacWtVQ0JL?=
 =?utf-8?B?UUFrL1o1ZG4wV3BLMHVMTTlNMU9zUFpMdmdEWXVSTEcxYlZ3bzd2dDkzTlRM?=
 =?utf-8?B?THA5TTRYemx3VkFFczJWMnVzaWc5ZFN0UFV1N2c3ZFgwRjNNRUgzK3ZucEtr?=
 =?utf-8?B?eE9wejhNZDhyMmkxMXFRdXl2eGpEcS9VME5jQ2s3MTBPeU5tdnF5RHE3WFA1?=
 =?utf-8?B?alNHOTI3bC8rY2N2bkZydFBhcGJ6cWFaWVlzWHVEVFJmeHBIUGlZSXFZejUy?=
 =?utf-8?B?TENYc3RTazdDWHRpQkZlcDR5N3JIL1g4VWtpQ0wyZ1Yzd1FYU1JRdWErbklm?=
 =?utf-8?B?U3YvU0NkcVFpalJjaGdCbVFlRnpFSENaT2kwT1NRK0VwOENranlrckUyOFM0?=
 =?utf-8?B?Tk56UlFNcGlLY3I2NC9KUDIzd1F3L0R6Yk9nZzNibVhnTG5xUmNNYmk3dS9R?=
 =?utf-8?B?QmdOTU1lcFYrV2tKcjVmeUJmN3FRZWF2azJNUjhDZnAybEM2MXE3ZzJsL25I?=
 =?utf-8?B?ZnViclNPczM1RC8rU29DTHRMMlRWOXc1U0R0a0ZwS3RsMUJOQlBSdVowOXg3?=
 =?utf-8?B?L0RiVTVabWdsUy9aQng0RkR4UXdoK09DaU92WFVBR29venh2M0NnME1rNFps?=
 =?utf-8?B?MHoxbkRnTC9MTk5BUW9mYlBaeEIzY3BMTm16cUdxVWtvQnVCczhPdDZmN3F1?=
 =?utf-8?B?ZUd2d051QU1VVGhsNEhQWHJqVXZHTjFqREVQY3Y2WitwYVhqUVBuOVdVRmhZ?=
 =?utf-8?B?VkF4VWc3NmZCYUtjTGw3TjBaa1AwOVNqaHFUU3B1KzZGSS9kWmZuZUNtMXdI?=
 =?utf-8?B?WGdDOEFoM1dPTkhjRktwbzFpMlFBa25MTmFNZ3VUQ2tFdVpHaW0zVlV4YU5P?=
 =?utf-8?B?dDZsbmNFYlQyZFg5VnRXQ1JJTWZCWm1rUGdsLy8vNVRzVk1RSFNudnpoRGJW?=
 =?utf-8?B?V0c0eUV5Skx6alBBczFFTFB5dFdoblYzS2U2RFhLcXR1MURZazhCbVVBUjZj?=
 =?utf-8?B?YzJpTWNZVW5HMXlsYTNrV3Z0V1BzKzg1MHo4eW1uS2I5L2pldmN4SlpZRkhY?=
 =?utf-8?B?bWRTTG11MXIzeDJYOGZtU0hEeFY5dkUxMXdJRW9kV0ZHbWNxcUYwQUo4LzNw?=
 =?utf-8?B?ait3WFE4Q2xrcGExV1VQY2ZpTXc1MWZBelpjaGdlMWhNMGZucW5PYkQyeEFC?=
 =?utf-8?B?eDJncjlPOC9XZ29pNUVMTkt3S0NWUGRPTkVtTXR1Uk9vZWVzYUhndC9IQzZy?=
 =?utf-8?B?cXU2UncrMzJCRDhYTWxlRGNrSGNjMWZvOWZvNUZJT29xQWF2U294REY5YlBH?=
 =?utf-8?B?WXRoZGI1WHlBeGVKYW5qRVNUckc4RUMzRGRqVGFJa1NmRHJZQUJMdGYvVnor?=
 =?utf-8?B?UnRaZFVqNVZEY0Q2SlJaY0tmTUp3YUtTZkJqUTNQMkdaSFF0c2FoZnNBQnZW?=
 =?utf-8?B?Vk5hY0Q5OFoydjVZQ3BwdWE1YXdib1JvMVNEMVZhK21QTWN3cktWT1BUSDJW?=
 =?utf-8?B?THNZSEc2WW53V09OTGxsOFR2cU1MUU5IREFNM2taTlBDMlRlNTRJUm5pSWd4?=
 =?utf-8?B?ZG1BVWpzSDdWUWlsSXBTZlpEOEhmQ2lkV1lZZGJpRFpoaTMxZmM4RzBJQ1Ry?=
 =?utf-8?B?RUh3UFVjZmdndjNHTHlvVVlidmNTNE9SV2Vhd0hpanltam9vS28yNHk4emFN?=
 =?utf-8?Q?wbTerfbjYcDNi1AvT/P8zywZvzo6+kDw/nJ9nalfunMK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0363F934752F1745BAA51C6A43AC450F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2197124a-b078-483d-7891-08dbe7c0b99a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2023 22:58:33.6160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NkZ9awjy0+SALDK0OB1wYHCsfcfoW0Lg0it32zJCmTu2SPefrkiwPjBS8q/z9GCbQQMZVgOfuDxgJEXsA78zMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4511
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231117_145843_687692_5ADCC745 
X-CRM114-Status: UNSURE (   9.92  )
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

T24gMTEvMTcvMjAyMyA1OjEzIEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gVGhlIGhv
c3QgYW5kIHN1YnN5c3RlbSBOUU5zIGFyZSBwYXNzZWQgaW4gdGhlIGNvbm5lY3QgY29tbWFuZCBw
YXlsb2FkIGFuZA0KPiBpbnRlcnByZXRlZCBhcyBudWwtdGVybWluYXRlZCBzdHJpbmdzLiAgRW5z
dXJlIHRoZXkgYWN0dWFsbHkgYXJlDQo+IG51bC10ZXJtaW5hdGVkIGJlZm9yZSB1c2luZyB0aGVt
Lg0KPiANCj4gRml4ZXM6IGEwN2I0OTcwZjQ2NCAibnZtZXQ6IGFkZCBhIGdlbmVyaWMgTlZNZSB0
YXJnZXQiKQ0KPiBSZXBvcnRlZC1ieTogQWxvbiBaYWhhdmkgPHphaGF2aS5hbG9uQGdtYWlsLmNv
bT4NCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IC0t
LQ0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0K
LWNrDQoNCg0K

