Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D76C54EE9
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Sep 2022 16:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AHzsAGjrfzExLtUIkkMIf5pyZu28Ap6CebPWSCI4h60=; b=wG5v7/NKAcvxnSFLp38QPIk0PO
	ty1UzglBR9SJkR2+s99vh/uMIltBQ2ycKhiDyTjUl/P0qNFZs6ocE0snaKb/BQxcSDl69U3UuXhGl
	+6upiA5jscxWz4CeFB4/GcjN7GkdQ/ZWlt0MPxcD83ajwdsX7obi0q8597PDU0DfyUl9MFU+wKDS8
	1thG4B0KPgC1xsjeL3pFKBi2S//SggJCC1VSjFSheJ4e1J7yJQ4/lVqyhcNQtMHkyB1cZKqn0X061
	4hsy3mumZsG1CyL/1b32dsdM6DFBqiod8FnuTmdbs9HVKJpgAIzLmLemKxMOPxfynQYHPXA4nXZtg
	bUDt999g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVxb3-007c0d-PY; Wed, 07 Sep 2022 16:08:13 +0000
Received: from mail-dm6nam11on2083.outbound.protection.outlook.com ([40.107.223.83] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVxWK-007Z9c-Pj
	for linux-nvme@lists.infradead.org; Wed, 07 Sep 2022 16:03:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aybpTz4dwUqZIgOwXI1yVK0H87n0lM9dtsHKe8xiSkGfQIOXow6WTHF+FjdYVR0KnBDXIgvOo5BgK1UzjAao0PpZ9Xcl0VMg42GhwvETlE4PfLtjxbN3JXbOFlkim7t50saJNF8vKAWA4502hT1wyEaagmpVWDHpHI88bgh+LYznojZbtbVW8cncgEUv3nQVCWf7TV8zjAJESfvCASaKGVFAIkrMJL0f5zXFsZwbu0ZiOaxJR4CojWMPdz+0DE0u+u1E5Y/FAr4vQlbPYscRZ9bCKtcczjeB5x0QMJ7fP43cRWxH0dMrohW3IEfJmiufXFZCulg+ExUEYK7hzsjzmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHzsAGjrfzExLtUIkkMIf5pyZu28Ap6CebPWSCI4h60=;
 b=mTSpiq6+iBeqyEo/r0LPpYDql8dxqHo7M0gP0QZdbB5+gJathcWh7x/8IzxOQjN6msGsxwgprcCW+aEIlrC8GmcGLheuWKQFjv5TFA8AoiyCvoGl9xKgO4bHXMSYmGaB1SFxwq4MMMJkFsFChcF61cnRR66ym3bmN5+zgYD85AzELXOUYX2yyDYRuaHsdwiYQTv4d6d/pD4tKgwppByzQg3ITqUPN7m/4ltkuBSpM5o6DawxeU/FG8+132vGwBQ7kHS7szI7dKWVdZNg1L65+g1C0QDsNOA7wluavgzF1yRR/EVWBpFSFUYNxIDHGbuYXoRNdv+A31IFOSzpVaMxUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHzsAGjrfzExLtUIkkMIf5pyZu28Ap6CebPWSCI4h60=;
 b=fYxac7fpL23ErLCkmw6HQWNdb+kr7pGxlVKDiVR2EW7S7W4AlbL5SY6EJ8HG0OCX6fJMV6ja2UyE37RiUEgoqP+gpcff0lNKK45u856/9MkLZYVw+azDWDso5iDyUFKcjEEgrIiRzRxc17QnThnIXoYb8ZJRBti3fw+j9Eve5k9WFeJn2P7p4EYKsbC2lAUTmeAufkV/Lwt0rYhw3ElSp7SooOPrq0u5LKf7u53bGty/TAYyc0FttIm7rdPKGOIZo6jMoPRLy/bMdexQlZ+oZW9g9ix7kipFhPNloVRqngXIUCLBphW4trklc//GsT8GeWCdU9rjlBAUxnf3P/8gdA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Wed, 7 Sep
 2022 16:03:15 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c04:1bde:6484:efd2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c04:1bde:6484:efd2%4]) with mapi id 15.20.5612.014; Wed, 7 Sep 2022
 16:03:15 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Varun Prakash <varun@chelsio.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] nvmet-tcp: handle ICReq PDU received in NVMET_TCP_Q_LIVE
 state
Thread-Topic: [PATCH] nvmet-tcp: handle ICReq PDU received in NVMET_TCP_Q_LIVE
 state
Thread-Index: AQHYwKN0G87EypInG06+vvRfpY1+gq3UJWWA
Date: Wed, 7 Sep 2022 16:03:15 +0000
Message-ID: <91de007a-e860-faff-9e86-4166bad7885c@nvidia.com>
References: <20220904213518.4532-1-varun@chelsio.com>
In-Reply-To: <20220904213518.4532-1-varun@chelsio.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM6PR12MB4516:EE_
x-ms-office365-filtering-correlation-id: e0dc013f-0eaa-4f40-1616-08da90ea7932
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  MQZMGuoJEcg7bHI+IRpBx/8IIXyKNilLqX+w+OYaPKaofIiHboWhhyNsXcz27OhxG16nNcGjWmuZ5Es+l6d35lfBk8eDaTXsYympExwFgLtLrlP6V8mq4B78DRC/gWTCLvMEjNPWo4QwFp1sS1zrozEe4ISPVNjoSqEJPvttLgLGf27XGabdgYdpToTT6MftKovC3e2jYJ34iqtmHKewNMwVt1kL8DNgytLSzbxm8fBaZe+HFgG7U2OqrCAPkKculiXFCVmIdo7+Zvjt4YQ96cGNNkQd7aH3/VpGgypfgH/GBcdLk/A3GgcZXsL6JtlzfnKSnmw6LO6o2Oy9N8HigyBpfMySp0t2n6vccYBO63ak3AF6ePui4jus4F8aWyTGHaX8Y8rB2pj8Y26yA8Umxbv3RqJOl5QEgpNKw24ZMe2SHoO2cuKsk+mwe3Bq4Yu3890lP9SP507aROoRuKYRE9oHE/6T0K228LlPTFNRTNs3DtJy8mkgttESYYSrxrv7Fo4oX9V58OcjX5NO2ND7viCA6rlzqQM0xhpXChX+v7kDnMWmSpxCwbYMkHn56R+qR2q4FaQ1pIPAq77+qK988C0sndDS1JrHudfHOZpzffRE+EWqhRE9/P2nDt44H1QqmeVMSSQ8+4XYo8hZ9MJ6GCBQwiDrM9x2zZjhx43frxyRu5jdr5tOPjn1cP59oPuNV8Ay6RXdm9FTzNVNPtB2dI+Wid4PXeKy5BGX6L81WOaw+M/ADsiEy/dQSAHGoRNhX5AQU3HbanGTenas27i+PbwOId7Wkm2KiwMkdmCtnZRejaNPtxbZdj7ljI6nLf1NDR7IjFksPoArVLuqT1YKJg==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(38070700005)(38100700002)(122000001)(54906003)(66446008)(64756008)(66556008)(8676002)(76116006)(4326008)(66476007)(66946007)(6916009)(91956017)(316002)(2906002)(2616005)(5660300002)(186003)(8936002)(478600001)(6486002)(71200400001)(6506007)(558084003)(53546011)(86362001)(6512007)(41300700001)(31686004)(36756003)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?K0xmOGpJSEUrdmZUeXNsdzZUMXA5ai8wSHpwa3QrR0t6ck1kNGNYaHhwTmJZ?=
 =?utf-8?B?d25LVGxqUzYxWlArMlNjMVpKYTB3WEh2MVkvUm9QYzFuWURORWVtSjJ3MTVC?=
 =?utf-8?B?cnI5OEdlLzgzYmNYNnZtRUg1Q1BVZU1lMTNoVjNUQVFkcVIxR0I0Nm5MWHQ3?=
 =?utf-8?B?aVVIMnc1MFpYWHlETWdJV05VUjJrMWFTMHJpWnRwZ0Zna3JpNDVqdWdINkZ4?=
 =?utf-8?B?RVRMdFpBNE9VMHp6bmpVNXVkdjEzNnVnT3UxOTAzSmxIYzVvckZ3cjRMcnhT?=
 =?utf-8?B?bTc1dndsUzdUZ0RkTHp5MnRpT3lRMVVWMjk1c2ZxdFc4NmZjeUFrTlVsN2N0?=
 =?utf-8?B?T0FLMGtNa0VMOCtPTVFhWVRGVmxXVkVWK3RvWDhKdkp4NHhSWlFFWmRPamxx?=
 =?utf-8?B?RVRXTkx6YXY2SUhKL0VHTTkvR05GaFhmbytickVQTkZJYk15Q1ZiWGlVTlFR?=
 =?utf-8?B?RjVkQzlIOWcrVlFvZnphMWs0M0txR0pMdmwwaVZRV1Z2ZVdPMGM5QlBQSnhk?=
 =?utf-8?B?SWt3YlFKQ2JsdGVGR2kvcG14c3Jqb3BPdndYTVd3YkdjVjJTSktYTmR0QndG?=
 =?utf-8?B?NDVhalRIYmh3ajFLbHpMQzlRYktPRVpEaUxPaFl4b2xOTHgxTXZlQWRUdUVk?=
 =?utf-8?B?NUdVMkFwaVRnRTBFcmRTTWhlZkZRSy9PYS94ZUhGMHZBanI3cEpxaUhrbUda?=
 =?utf-8?B?T2JGZm5SNjRjRFV4UXlQUkRCZ3l5RGorQ09rVTZ5ZjBKNFh4amZZM1RmcjR6?=
 =?utf-8?B?eURwK1M4K09lUXBrYVhwQ3RFeDNqaEhEV1JXM0kyNnVsaEVMN3EyS09xUkZI?=
 =?utf-8?B?UkFKWEJ0RjhCc2cxRFduZlBsUTFpdFBscnBXcHordkJ5UFlkSXV1UFl3OFJ6?=
 =?utf-8?B?VlRHOXZEN1lTZzZ1TEtCQzRTWkVlaFptRENFOU1zVHdKN3BpVStIYVQ3a001?=
 =?utf-8?B?YzRDdjZDZExZZStJVG81Q1k3OEdoT1J1MkFFTzdJaXVOV0wxWVNNeFJHeGNU?=
 =?utf-8?B?cFRlOTBBSFA3c05nd3RDTzE5cC9DMkwxVXdjREVLa2lLcmoxcC9CVHFtTDNs?=
 =?utf-8?B?aVhnUk9ITXJIUUlQVUxjMTNkeURYbHRVZWs1RCs5d1BvVWtjT1pndmxYZVhK?=
 =?utf-8?B?TVl4cmFhc1lJbEVTajMyNmtjQ3ovUjFIdHlRcks2UHFXT0FuU1ljenlleks0?=
 =?utf-8?B?TXROVFNIMjZrNEcxQktKamU4eXQyNWxaV3NjOW9iYXBsanRTVm1aVlJURXBH?=
 =?utf-8?B?L2p5ZGE2ZXJuM3RxKzhPMUpmcU1ONTZmbVdKTXBDTk9ZSUNxMjBFVm1KQ3BM?=
 =?utf-8?B?a1hHZi8zSGV2WE1TR1IzNkM4ZmN1dmRYTnhtR2NTWnBqZ1dERTVlWldhbGJj?=
 =?utf-8?B?OStQcUp2NkJ3b1R3Y3YwTkI0NGpCWDZHbTljbnlJMFFBMitldXo2eVZwK3Uv?=
 =?utf-8?B?OG9jSWRFcldrNE1LWE5NdERxL3VQd1lCVk1pL1ExakNzM21HL09UYUtLV0hh?=
 =?utf-8?B?Z1lQaWlXcmJBRmFHODd0VlIrSFF0NkZEaWpaTUg5QjRjMVF0c1g4Um1EUWFK?=
 =?utf-8?B?U3p3S1czcU1aMFFlb0NNakJ1WXV1cEd0VGJXdWlsSWVaRXVRbXNIa2RTOWJ5?=
 =?utf-8?B?blRBSVVHWnFTK0FiWURPZmxtMGRSNXdkb0ZoaWU4RzZiWlFPY3NaODRTcDIw?=
 =?utf-8?B?a0xzakJJSElJMjdUeFVsbzB2ajkxNlZmWjdpN3hYVms3NmE3UEFlejM1QTVy?=
 =?utf-8?B?YVBmaXNNSVlNQlBRVlRURmRCbS9qSXkvam9YV3liUWtiTnVqbXlMcCt6dWw0?=
 =?utf-8?B?MmFxbllnWFFhQlFBSG5Wc0ZIV0hSRzBWZUlsVzZTYmZrL00rOVBDcmVDMys0?=
 =?utf-8?B?YTErM25YcGZmMlhwN1ZxSy9pcTB0R1FlN2hNTytKbis2M2pwRU9pUEU0ejNt?=
 =?utf-8?B?Y0pkTTJ0cHBJRU1qcUwzSXAzNUx0MCtEQTFUMFRKVUI4NWNadUhPWU9kOEhq?=
 =?utf-8?B?RkFuK2x4czQwTWxVZ1JFYUJaU2tHbXZLWkVYVDdYT2ZRbHJHVkpnTmM2Nlp4?=
 =?utf-8?B?Z08xQS96dEhFYi9jOUQzbm9LaWY3Y1pVY1VKNXZzRm5SazlOTjhYT0J2NWhS?=
 =?utf-8?B?N1RwbTA3b3JITFR3VVhpMG9VVFFlK2MvK0lKZzNPVHZUWFNsYm54MFdrOGlE?=
 =?utf-8?B?YVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A43A82D69E6985479B990C63FD508FB1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0dc013f-0eaa-4f40-1616-08da90ea7932
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 16:03:15.6262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pjnWmx9JOgsmS2pBZeh6wc8r2CDP1HFdpxOyf7D5vjPHS48rW48z+neuFD7kM8N3ulsnI1X3UHYTiWeJITUbBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4516
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220907_090320_887652_6B6EC0DF 
X-CRM114-Status: UNSURE (   8.39  )
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

T24gOS80LzIyIDE0OjM1LCBWYXJ1biBQcmFrYXNoIHdyb3RlOg0KPiBJZiB0YXJnZXQgcmVjZWl2
ZXMgSUNSZXEgUERVIGluIHF1ZXVlIHN0YXRlIE5WTUVUX1RDUF9RX0xJVkUNCj4gdGhlbiBjYWxs
IG52bWV0X3RjcF9mYXRhbF9lcnJvcigpIGFuZCByZXR1cm4gLUVQUk9UTy4NCj4gDQoNCkNhbiB5
b3UgcGxlYXNlIHN0YXRlIHRoZSBkZXRhaWxlZCBzY2VuYXJpbyBpbiB0aGUgY29tbWl0IGxvZyA/
DQoNCi1jaw0KDQo=

