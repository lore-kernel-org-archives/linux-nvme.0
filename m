Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A6DC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jun 2022 08:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xb+nR7ZyV5GYi6hzSifY7kIYgtfIWJyHqfnPqsweW3M=; b=2Rtzi4nHfD6PjUjNq/b8f2mJF9
	vfECA4J7u0LGFQPZVs/ELZ0+J8V+18tzjwBOU/Ark7pbB7h1fYwbP2mV6qJttwkGYCTQDSLKcD8p/
	ZgZCVvGRbL7msNBDF/Nod8LkwcRPz8iBmvvTgYTikrSTtAwKVuU/LO/oJaqK2FlU+LNbsbMzO0zJf
	ekLkn3CQnxYt1UztsrhnzT3q/PxIjT9jWPpJUfPzFWthIuHrvMu18n5rFsfz/TNbDkisMv61PYiMb
	573nX4D+F5VjlvYLviLWLVIQVkiGV06oJbVMkx406ZMBtnIG55V4P8iJde0lPOkX8nJIcL7ECejLk
	2mzpCROA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3vXS-009Cyn-0i; Wed, 22 Jun 2022 08:16:38 +0000
Received: from mail-bn8nam11on2080.outbound.protection.outlook.com ([40.107.236.80] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3vXP-009CxO-C0
	for linux-nvme@lists.infradead.org; Wed, 22 Jun 2022 08:16:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpPDSJgCHvM2Gbkbc0lDRKeZ8Ht75i3T1FlYzVH2khHM1gFReRkEzpjt7gvivtfY23brbStK77+E6Vk7N9f07OGwFuP/+UDI6LYNENa2lrY/GeRcInSzVPof1ogr+n/U+8LmXFdQatCkZTIwc4fbLJo6VHYpN/bK66QItzrnEixSwsaicRDP0fGBKdnjVZTsaklWMlSHf8N/UHTpuN65ogjyoLFOg8P+elC9Co/Hs1JuV3k7fB2FoNSxhTcCPM6507GXocIHNFNKzLMYHDq2O8i9XA4JbjLdLTdI9WvesdfIOz+jd4jyHU7IjixfF/f6OfHsXUV1Ep3dSGwSis555Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xb+nR7ZyV5GYi6hzSifY7kIYgtfIWJyHqfnPqsweW3M=;
 b=O88f1zYlqYzn6ifbJzGIoy2coJ/PdygCizblQoLCZrkA4CkxFDH4X6jhQG05SCprjh8LKh7D6isMnjsiXK4ln/d4Qeg58zizPlF2Wov3Cx8PWt/SvMlpZ9x4Te9B11+uYSsaVavEPeudIZBKlzyUFPtxlcVnJw5s6FKjSl9W5MvtQgRSYygZuUZL7sJf5EIW7uDNuPYOM2Xsp5bH//fNBVI6DahwrbxBQW4joLb4IsNyq9YTpDU7U1mR93xziHfDnUHNykotRkL52JZyFSldrYDQWmIfgrDBctVZNFtJ5FDd/JZ/BFJuecHZjQFiW09mxarx+lnfpYw+aAOTJg+hKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xb+nR7ZyV5GYi6hzSifY7kIYgtfIWJyHqfnPqsweW3M=;
 b=ZeSuO3V9EZvEqDWUWM8OMzsJtczpFq94pTFqU0/TzlWrJzqPS6IBmwyTxbDn46HxyJrUXWcHK0uMF64B/aZHFwRfL9XIJ7XBIivuGZojc+NldmtrxoH37DQglgbpJqi4FlK0zNktxkn09xmKHC0U3Ksz9aw+UAFKjY9cyantmNu19aLgrPyD2vhslNxxjb0rLLDE9dMI1cNySQZ5cNgO5AdvZZ/u0TeIYFmyE7BjX/m0JlVyatALiUWZrKmdooW986juZYVybLS7VaIbxRPyW6Hc6tVFD3DP70JuwC8e0q+c8HB+ZusfWZ35bk336VvaHRz74cGQFqN3jrM6ePFzXg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BYAPR12MB3015.namprd12.prod.outlook.com (2603:10b6:a03:df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Wed, 22 Jun
 2022 08:16:30 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e%7]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 08:16:30 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>, Joel Granados <j.granados@samsung.com>
CC: "hch@lst.de" <hch@lst.de>, "gost.dev@samsung.com" <gost.dev@samsung.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"joshi.k@samsung.com" <joshi.k@samsung.com>
Subject: Re: [PATCH v3] nvme: Fix CRMS masks for TP4084 - Time-to-ready
Thread-Topic: [PATCH v3] nvme: Fix CRMS masks for TP4084 - Time-to-ready
Thread-Index: AQHYhT2xTrWJx0wTI0qdB2jFwGNuVK1aBcKAgAEQgwA=
Date: Wed, 22 Jun 2022 08:16:30 +0000
Message-ID: <d6f49776-369d-6047-f3ff-697b46db4704@nvidia.com>
References:  <CGME20220621070724eucas1p186a9c118c37b140e60c2d1f8cacf636a@eucas1p1.samsung.com>
 <20220621070500.1381155-1-j.granados@samsung.com>
 <YrHrRUcn5kwu2d9V@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <YrHrRUcn5kwu2d9V@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a6077092-caf5-4034-7b6e-08da54278331
x-ms-traffictypediagnostic: BYAPR12MB3015:EE_
x-microsoft-antispam-prvs:  <BYAPR12MB301500034174F00C82A3CC4DA3B29@BYAPR12MB3015.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  pqeXZSOlh/nGJf9B6aIfxOxr/2WZa6VoNn6rdfAFLU7meAzALjPeARPSkjPsuUemY69sXf/5weWYczFsjeWESrdT7serDcAkhBLWehGvrDopMULLOQiXCct3Waiw2DQaWI5iugBaJaGZMZy27meArMn3FLGypRP8cTAXC2dP3AV5TqCwMRM9Rh4LKk73cQRmtR9uK2S+EHetZd4S19dD6/z7MeAXPm6stCLjnp/s7CDkcGRrNHJ73wMAOfvtgttWOj+trrIPvGJSSpv0n4RjqpbEqE+e2WJ586bIIF9W152AvbYTKsitHMLbt/tKFF0uUcHZ1jxQGODiJeHgKXi+fWVBx2W+1LXHCgZS0mUDYY1fAkaf1ibZncw5XNau52UqeRgYsxHpbgjBgG2+085Fg02W1npXnH5rVg7qwEsre/qGhUtqvhAev2lDK02yE8+Et8ACT83jHeLujVImX9AXzH2HHL2LPq2h9cjfIrts17L83t6t03X0EVTHXUXNWlb92MsI9/vvdE2b3I6/gBfjNSeHd7k7e011p+VBk3SOCGSSlL9i57XmtdA1q1Xt/wK//wTzDuQS95FjwzXRaPGQEFxuMCBon8g4tYGJkcwdu9WCsaJ9mh91q589Tc59VJGhfsO0U0fQRFGdiE2/BDPd6rQLXebQwotHTu/tAtZJ1qAiplSMuYXB05+UwG28sLVqLecdeSFv4Mu8stHIU7RMLa97u8RgGU0/sLeR77iMbaSu6f+oUzSzDoZSgvGEE15TUHTwaKvKn3mqgZOOa1MYL1CFeXMZCUFAbxW5nnI5MaB+70DyI/IQlPtu50y4DSS1Xb1GdvxNEMV+bc6FhYXeEQ==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(53546011)(186003)(41300700001)(2616005)(38100700002)(122000001)(38070700005)(6512007)(8936002)(6506007)(31696002)(86362001)(66946007)(64756008)(110136005)(5660300002)(4744005)(8676002)(4326008)(66446008)(6486002)(66476007)(31686004)(91956017)(71200400001)(478600001)(54906003)(316002)(76116006)(83380400001)(2906002)(36756003)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?M1ovTnJ2NDFDQVBTdW1oNDlBSzRDa283ekFuS3JIRzJFRnhaNncwTldKWE1P?=
 =?utf-8?B?Yi9uWTBmcnI4bjhmMDZMOG9oK3RPT0JlUUlTdzZJNEEydEZsOHkyZkxJNGgv?=
 =?utf-8?B?VTlJakJYd0ZBZllTRGdqUitSdllCZWRmZkxSM1BiSlRIQzJrSzFTZDNmenk3?=
 =?utf-8?B?SFU2WXA1bzFLbGJtUTJxNE85dHd4THIxRGlKYWJVNGRyV3VSQU96YjdLcHla?=
 =?utf-8?B?cWk0VVVMU1RnMXdIQTNiQ0IwWDdMbjZxYXA4bk9VUDltb2tSUDkyV0NDTG5K?=
 =?utf-8?B?NjhJNzhQMEM2NHJNSjN1aW5MRU9RQXgwUzE0YnFSaDNYVkljdjJxWnJscnc0?=
 =?utf-8?B?Vm9SOE1KanZ4REllQytSSWJNTCtmWVE1eldKODVDc0ZnaXB5UUhuWjhudjNK?=
 =?utf-8?B?UnR6TTR5ZWVPbFNwOVhHTVRYaHZQUUR0WHkwdHUxSFhVTXNKTkZLNThlSzNk?=
 =?utf-8?B?d0RaUlo3VmNLMWp2TTNiQUx1WjByWmNqSGhoVmZFbEw0SmN5L2x5RElGenlr?=
 =?utf-8?B?V2JDL3c1cERvRjRtQkd1QlY1Z0NMZEZuaXhsQjZ6RFRlNzJXb2pVWGY5TDgv?=
 =?utf-8?B?WFNsL210b1VXOGpzVDRhblp5djgyeXQ2Y051Z251RzZuQ0ltTDF4aVJxYkdU?=
 =?utf-8?B?TnNnK0c4YmlkTXZlMFA1QStvODVodlk0VjZoVUJQS1g5akxMQWcyNWZMZHBF?=
 =?utf-8?B?ZDZtTXhPUlVKaTNSeUF5eFZHTk02eG9ZQmNaK2oxb3hqYWxFc29JMzRpRC94?=
 =?utf-8?B?TlFuUWVoV2Uwa0thZDJncnFPdHZBZGo2VzM1ajRoVGk1R1gxWHdYcENaZ1Ns?=
 =?utf-8?B?SGtmTEcwdjIxOFRUR1gyWmc4eWtPbnhQTzJJWnJCNnZIeWxUYTlpbFkrUlUy?=
 =?utf-8?B?cGRlQ054N0lzOHJnSDUrVXdPbXVYVlBmTmhNQzRQU0g4ZVJoam56RWRDN3lL?=
 =?utf-8?B?eXRhSlFoanJuYmFKT3Vwa2JsVTY4akVDS1dEMWQ0Q29OeXRMOW1idVRtQ0Vm?=
 =?utf-8?B?Uk00ZUpoYnBuSjBnREhMbGg4RlFoRlJoM2kyNHJrendDSmM3THJGK1NkQjIz?=
 =?utf-8?B?NVkvRlQvOHdmWFRxWnNHeXNWbVdqL1pSUU5HODRicElaL2JjU0pFMDMwY3hx?=
 =?utf-8?B?bm1MTFhoYUpjVUNHNi85NHdyRGk5WFZjN0k1YklhWDJQd002dnJDOXRiWTRj?=
 =?utf-8?B?RlZ2ZHYwajJCZFRFR3UyNHhMc2tCMDFtVTgzOW03K0xmdS9rSzY4aDNCZDJT?=
 =?utf-8?B?ZGVtNUNuOW5ETEwrYlVwcmZlZlI4clNHVXRXTmFGNE1sazhsNFJOTGd2eGRp?=
 =?utf-8?B?WjRrSkM0a2lEUEdub2MxSUlUUHU4K244clJKZWNnZXdsdTkwWER1RnVTdlhl?=
 =?utf-8?B?dFhsYXdpVUlKV2NjdWp4djJmaVZwUU51WjVQclVEK0Vhc3BXY3c4NFkrNlVW?=
 =?utf-8?B?eTFTYndYSmpWbkFHcitrSVVmcDhEQ2xlcHZjRWU0TTNCYUNBUmlRSXBPazMr?=
 =?utf-8?B?Y0NEbVkzYTM4V1RZaUk0OUZBWVUveUNob0tKdDQvMnZDSkk4RUZRRmhHSkMx?=
 =?utf-8?B?Z0pvcklGNUt6cnIrYW43bXp3UWJnQUNQRy9LZW1TcE5OSGNFeXpWT0xFRllS?=
 =?utf-8?B?blB1Sjc0K3QrakpTR29LbXFvZ2dpVGZsN1JhaU1sVGRXeXRnbGp6UkxsMEp5?=
 =?utf-8?B?RE82MEF2b3BwZmFTSjNXbHJmV2ZXOHIxSEwwZHluUmx4WU85U0pGd2RMOFFj?=
 =?utf-8?B?ajA1SWkzSWZDVWdDeEZyMjVOVGZBQTlzN2JsYVlPS0NZTFpQN29WZm9zcXUx?=
 =?utf-8?B?RGwwVTZXdkQyRmtPRjgwbGU1MURva0RMZFJkUlhHQ2I5THZlVm8vSHlvL2FQ?=
 =?utf-8?B?aVY5S1RsVm9XaUpqUzkyQ2VmZ2pzSFRXdVpyMUxhcGxWWUx2YVhxeHJiSUlw?=
 =?utf-8?B?NTlvRlgwY1JHY0JuNVVtWnVETzBQRnY5SEcxckhyMXNLQmp1aVVoMVZhUmUw?=
 =?utf-8?B?UDk4eHIyZk1PT3V4Ry9oa05yWkFXTWRWRjZVejZrc1A2QjEvanhROXIxemFX?=
 =?utf-8?B?Y3RnZDY0QkZLQjYrZS8vSytiMmQ1ellSV2tUT0psQ2hVOE8rd01SOVF6L1Ex?=
 =?utf-8?B?RGlwdUFPUXFZWG5ESXdxMGFlbDk5U0VVdmU3OUgzYzZ4dHdiRVcxR05CQWlH?=
 =?utf-8?Q?6yV3o34+qTviDsJ675CZP4LeV4uJGG4UAdKmkSqFFhua?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D902B1FFBFFB14E8E31997F36FB0490@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6077092-caf5-4034-7b6e-08da54278331
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2022 08:16:30.7706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RDfDaMs9TIMd2dP0f4cog+hgVmwOVO0gXiDx2EEWW10ZhvEBWir2EKmmdxfHj2GtCw7HWPHtS788M8/NoHkeTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3015
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220622_011635_644536_A3B1782E 
X-CRM114-Status: GOOD (  10.25  )
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

T24gNi8yMS8yMDIyIDk6MDEgQU0sIEtlaXRoIEJ1c2NoIHdyb3RlOg0KPiBPbiBUdWUsIEp1biAy
MSwgMjAyMiBhdCAwOTowNTowMEFNICswMjAwLCBKb2VsIEdyYW5hZG9zIHdyb3RlOg0KPj4gQWRq
dXN0IHRoZSB2YWx1ZXMgb2YgTlZNRV9DQVBfQ1JNU19DUklNUyBhbmQgTlZNRV9DQVBfQ1JNU19D
UldNUyBtYXNrcyBhcw0KPj4gdGhleSBhcmUgZGlmZmVyZW50IGZyb20gdGhlIG9uZXMgaW4gVFA0
MDg0IC0gVGltZS10by1yZWFkeS4NCj4+DQo+PiBGaXhlczogMzU0MjAxYzUzZTYxICgibnZtZTog
YWRkIHN1cHBvcnQgZm9yIFRQNDA4NCAtIFRpbWUtdG8tUmVhZHkgRW5oYW5jZW1lbnRzIikuDQo+
Pg0KPj4gU2lnbmVkLW9mZi1ieTogSm9lbCBHcmFuYWRvcyA8ai5ncmFuYWRvc0BzYW1zdW5nLmNv
bT4NCj4gDQo+IExvb2tzIGdvb2QuDQo+IA0KPiBSZXZpZXdlZC1ieTogS2VpdGggQnVzY2ggPGti
dXNjaEBrZXJuZWwub3JnPg0KPiANCg0KVGhpcyBzZWVtcyB0byBhZGRyZXNzIHByZXZpb3VzIGNv
bW1lbnRzIHdpdGggcmVhcnJhbmdpbmcgdGhlIGVudW0NCnZhbHVlcyBpbiBpbmNyZWFzaW5nIG9y
ZGVyLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4N
Cg0KLWNrDQoNCg0K

