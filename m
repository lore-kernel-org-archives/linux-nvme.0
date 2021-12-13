Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7602BC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Dec 2021 07:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A2SNzW9EC06LJHakX6EuSQxDWatMOK+aA56nmS9QPhQ=; b=JQFPVBa937NyzMxflxUegaa/2A
	1sft+NA7dB/QCDDNiPc50NHNLgoscRZsjKgj+aVjw9/SDVhSNlt5jUT3bvk0ST0LohPpDzpgW9p4S
	Kxd+K+BTFYRMhtfOdXH3F+63wN6jSur2MEXdQ89F0GfBlQTh+wjflcX9BjxUpCv1fSrrjR47pRJ5J
	OdLERu78cq5cg/TwXIBqJmkbZkxRIj4orx4KhtgdOV4uCmSOhZzB71BDKMwxszeNhOf5ldXfJuXl7
	UhVIwMN9kvFCd5msnAODPz0kB7xCxLZ752Ez/L4VT/IBppCVi4EYilNrBwybc92X3S8XJiwxCrd6+
	Ur08vFjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mwfUp-00820e-CO; Mon, 13 Dec 2021 07:11:39 +0000
Received: from mail-co1nam11on2056.outbound.protection.outlook.com
 ([40.107.220.56] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwfUm-0081zb-H1
 for linux-nvme@lists.infradead.org; Mon, 13 Dec 2021 07:11:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUstyVhZN4U4WPJhy2VnpHaOx/BcBrcb1FUNVpdLJ4YePETcUN4uC6LWO5FGja7jUmXZUnAuAhsx6THzhmsluH9YquexFPObjv2bgh0T14pRjnPxp7K5wzYqvILaroQKIEKFG21TojeHiol8vexi7btjMBB/xoE34ZL+vXStgtM9iKgwI5cMq5LaRrBRRsZxH/Fi/MtUD7ENJmAI27nQiJfIC3/6gN0Orir0AHu+R6rNJddtXDwJ0HBvqMlT7/uS/YQW9Oei+aSXeZp6GbAgVn4o22gA+YRjVG3LNUVIVkl/JgA4oWYanxcmnPDy5knNhjJvyFHqyNkpJjjrSqSlUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2SNzW9EC06LJHakX6EuSQxDWatMOK+aA56nmS9QPhQ=;
 b=hqHBCeXI5gw8Uc67oeHWG9xjAT8aNGAMeY+ejwiGuz39PhU8SzswuckTrrE2BBjuE2yFQHY5AQuM1eFzC77TZpZ+5H4kUULcCJYipvIWOu/20F6Io+YhjKRO4B3ZlhMkdUC/Ldp2K6+Vaz3U7pcPAGBOLkg4uhxAV/g8bN2u0fKZIt481LHhqFA4UEts7yBY2D6GpFj9QqGPWrO1QNNFRmkLbJZLm+yu5yHFyTIoetR+TfuVCNTM78ZaW8Pkfj2n05+CZk1g01NrDm7DtlfC7hhAxm2MFFXY1PuO8O+FcbWSxqdz9AlYOqfmHtzwSitc6fbapADDH/w0aPeZN9K05Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2SNzW9EC06LJHakX6EuSQxDWatMOK+aA56nmS9QPhQ=;
 b=TUdxOAOyBZ490f8XU4NrSr+8qicJWPxfBhCuaEp2zb/gPJ/JWFqrmq3Et+geNNhIh0YPoB0A8YvrUAEBw28UIX8GoDJRAZGkb5XYwCSmyU2jkeaphT24uEUsWoLsf+XYAJHTeMciJsNFPHJ7P95j0V8aU4FjcBoEWgO45xIFTO6rfF/Fhzv8hmVJcT8W33X683UlHZkOdI6vazAvKxjp+gTnOfgWhuEu+m+Qok939lgWjY++l2jLg6OOq7qfHOOD4mM77ioq3uQ2oosmWJ3C0d0kXP93RqpbGqI6yd120MImAFcKSXCFV/9yeS76rr1dvI5m4EIZj8WRM8KErYGxeg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR1201MB2559.namprd12.prod.outlook.com (2603:10b6:300:e0::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 07:11:33 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e%7]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 07:11:33 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@suse.de>
CC: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: add 'iopolicy' module parameter
Thread-Topic: [PATCH] nvme: add 'iopolicy' module parameter
Thread-Index: AQHX7cgs7e8QGCoIUUmmCY7IUfhLdKwwBcCA
Date: Mon, 13 Dec 2021 07:11:33 +0000
Message-ID: <d7b6075e-99b4-45fc-d71f-81d348ad59ab@nvidia.com>
References: <20211210131444.120946-1-hare@suse.de>
In-Reply-To: <20211210131444.120946-1-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a08bdf2-da72-4e1b-a24b-08d9be07cb60
x-ms-traffictypediagnostic: MWHPR1201MB2559:EE_
x-microsoft-antispam-prvs: <MWHPR1201MB255937E65F8B7F3F137B077AA3749@MWHPR1201MB2559.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vPbi4U8o17QZU1SCL2meX59Voo31Emv+hQn4pB89M9bcR16kP+JVR4EZvMhau1+rTOGYs297DjBWxO0y2k1qVKOVz1x0O93S1BKS/KdRdx5ZiB0nQ/Zh4qZFUcFZCcFNtn2stvA7erNPT91TRMIBQ1B1elBUCkBuYgabOHbjGzY6ij+x4dGk9JGSaO364w2VfYU9/SoqRqjmVZG/HAfjbPmqeIaJEQ2TDmBma2zQFn3SePiSHytcoAOMb80uVeJS9DFxLaN0luA75MWHti7k3+odDZSokkKCxld59qXT8qpJodBGRfQ+Cd2IlmBvG7k09Evi9kFCk5MPo00iCnHink3lHiGPAcFzGq3c+ZGXyFtpy6D72ewq9hGhA1itqreaePfGun7A91rjQzf4WXzbRhvqM9hAYFL1iLsomJC0yiIJuNrLrMFUM6/qtbkjUGP7OH7asTzPcbBToa9AW7ekmQkjSqRrWw4sX/b9ppSu/9gzi4/FLlR4czUD4pj00w4Qjruk63V77pSldaU149YPqcg36fMkMU7tc01syeWyqCdmZoUlfFuVRPRsPdEGBaonB7kgZ1HlfzEq8S7kcoOSUVFcKWlGFmfaKaKkolkzOKEgeBWHQghjpymQ7gOwMpuJgaXqtpDsj/xjYuofiFM67FbIZme8kz0Yns5GPh2Fb5QHhaUzmXWfBjIF2b+zt62bkB+hAI5EbdNFo5QCIazO+R7qX84eBNKaIqMg/iv57gKYeo8xlS82sjcxHodOiWSjK87pvnpgfCqh7Oy72k2kmg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(316002)(66446008)(64756008)(66556008)(54906003)(6916009)(38070700005)(31686004)(91956017)(66946007)(71200400001)(4744005)(4326008)(76116006)(83380400001)(8936002)(66476007)(5660300002)(53546011)(6506007)(6486002)(8676002)(508600001)(122000001)(36756003)(38100700002)(2906002)(86362001)(31696002)(6512007)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2MzYlZiWnh3cnNyM0hSa3pUaG5YVmp3QlBhN1JubFlBR1E1aU1Zc3FEb0Ir?=
 =?utf-8?B?Tk9oMDQyUmVLenBpYmZ5RFJTc0J2eGxxaUtsblI0bkxNTUtJQUZUVzBtbkVH?=
 =?utf-8?B?MzFlYzg4Q0gzbUFLa0R3ZXRTUWZ1VDdqYmFCcWtRQjhDSVB0aE9UYXc5Znln?=
 =?utf-8?B?Ukt5NnJNSDBBYVd0UlVpMWVkdDA3YXFwR0k3Y2EvZEUwVGFobDBQVE4wSHVz?=
 =?utf-8?B?SXhVQmlRUVc1cFd6R1E0S1BtNFBNZnB3Rm5pajU3WGNmTHRkTjd4NC9OZ3hr?=
 =?utf-8?B?L1Z3R2tZY0grb2t1QklhSnFaN0dDZVZRemhyL21POTBDU3N3ckFsTnR0YzEw?=
 =?utf-8?B?WnBENGpSOE42YkNBbVJEd2d5by9PZDFKbHFhVGpVQUZkTnhybVlqalNnYkZY?=
 =?utf-8?B?MkVvNHJrS2ltOGFzaHJ1bkpwSnF4c2QzcndnMHFmaTh0cUxreUxoUEl1OENQ?=
 =?utf-8?B?dXJsZXF2NC90K0V5Q1JBTGtvakFBVEY3TWxhaUlwYzdBbXllU2FvNDVXZk9y?=
 =?utf-8?B?WDVzeitmNWtoUkxWdTh2NTJvS3c0NktuUW1WQnNrYUsrYzJUL0hsdU5aTEF2?=
 =?utf-8?B?Uk1jYjJ6TjVZR0RweE5EUkFLbHM0UEY0MjRnbVdlMTI0aGh0Vlh2ZlhRS2ty?=
 =?utf-8?B?MjR5aU1NWm85N0tOWWVFUEJxN0JOeEtsMytkdWhWdWJqRG5xTW8rcnZNWkM2?=
 =?utf-8?B?UGxLZDF5N016MkxvaEtpUWhkUHZsUjNoUGR6WWEvRDFiT0xnQVJ6d2xIcjJV?=
 =?utf-8?B?OW9pVHBPM3NkZUpFWHArcmZZM3JaNjRYOTFiZjVNNGtlbHNzNHJ4Z01pNnZl?=
 =?utf-8?B?dHBFZTBidGpFMjg5aFFDMkU3a3VSejZuK0tGUUd2WVU1a3hhRjJTNXhVb0pS?=
 =?utf-8?B?MUJsZ3kxQW92eGU3d29NSlAwTDR3NEZWMkV6c01RSkhFdDhGQXFvU3habURk?=
 =?utf-8?B?NEZlUS9UMk1LYVVtVWs5VFJIUi9wbFd3U0Nrc0lZQnBPdmxhVE51dXNMc1ZT?=
 =?utf-8?B?SzhmR0IyeE10SjZDUkl1MFFGdXRoOUxFVEhZdG1HUjZpYVZMdm1UWnZMM24x?=
 =?utf-8?B?dHNvcEplM1owYUYwclNYUzRFMVdtR2ZCVHhyVkNWS0J6ZzdBMm1rQzRUcW05?=
 =?utf-8?B?K2Y5M0RLU0ZwaDVUQkE0M3FWeklKMHMvK3d2MjNtcDVwd1dHNjlROExXb25I?=
 =?utf-8?B?WlJPQS9XQ2twemkvbU55NlM0eHZ2NTk5LzZwM3VNRHpyUHRpVkppdlhMQnNo?=
 =?utf-8?B?R25uVGh1VmZ2M0EzcnNzSGhsYUJ0bE1Kd0NHN0ZRMjZmVUZOQ21RdGJlV1dP?=
 =?utf-8?B?ako2aDRMWnNEVkllRWhEekx6YWF4dkJ1eFIvZmt5N09xRjhxZzdZMUxkZG9Z?=
 =?utf-8?B?N0hWMnF3N2dWZU1qcWk0eHNscFZBaVpuc1RIcnh0Q0QxWXg1eU1ZV1dsT25I?=
 =?utf-8?B?QnJsb3pGM3BFZ1NnbXpja1R6RjU5VmZaZ0tHVDA4eUFYdHovMWlEUklIdy9T?=
 =?utf-8?B?b0FjN1QwR3ZoME9UVi9Zd082dmptT244RnBrRFBjd1lyTnV4dWhrSkZiZFhj?=
 =?utf-8?B?dmNlTDlKUEErczJiMjgxcVp0cWZPZWgwaGZFOStpZ2o0VFpOckd0VlZwOVNL?=
 =?utf-8?B?UVo4eVVVYXQzVGFzTldEZEs2Qmo5TXpyeituUWd4OHo3dVBadXVkY1R1SUor?=
 =?utf-8?B?cHBpa3BqOTluQ0NmWm5yaDZwK1hCKzBiUW1CbURTTU5ndlY1YitZenloM2Fw?=
 =?utf-8?B?UmZQTEx3TlhkUnBhblpXSmR0ank1ZVJhTVY2UjhwMmF3UllQMFhZc0JoWHpY?=
 =?utf-8?B?T2tLOXlSL1dFUnFubXpqek1lWnlJTjVsODBLeVFOY1VWbHV0bytONXZTVDlO?=
 =?utf-8?B?N2toRjdScm9ycHRZWUZwZ3c1Z2lPWG1VMkFrWURPYUVKbHhCRVI3bnE0WWpW?=
 =?utf-8?B?NkVJWnpqS2szS0JVbXNzY25xdDZpekpjaFN1RXEvVXh2RC84WWdFd2lpNDJJ?=
 =?utf-8?B?NGZCQmF5Mjg1K0V5ei9BeXIvWW04bVlmTGNqWVBHdjVYcEpmZmdINml6ZVR2?=
 =?utf-8?B?NDZpUE4xSHQ3MUlUOVRvaXZTSkJqejBxRHF1Q3BhdktTK3VNWW1Kci8xaDln?=
 =?utf-8?B?YVgrVGlNZTYzclhXYlNMTkdjQTRxQzQxSEtkaFpUYnpWRlRBMktvblRXbm9o?=
 =?utf-8?Q?IjD/c7q4pB4LI0zfGPBA/OlLXm52Wglq3XFO5zK/hrNK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <404F93092284E74E9252CA452EED2537@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a08bdf2-da72-4e1b-a24b-08d9be07cb60
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 07:11:33.4512 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zHqEWWPff5p28rXnjSRDxtvzUsyV9XECHuOxcHWGS+f3ZrliQ3d5d3QxrzV0boGUXh7XMP8R0ISMUw9z4pyL1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2559
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211212_231136_598497_697C72A7 
X-CRM114-Status: GOOD (  13.26  )
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

T24gMTIvMTAvMjEgNToxNCBBTSwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOg0KPiBXaGlsZSB0aGUg
J2lvcG9saWN5JyBzeXNmcyBhdHRyaWJ1dGUgY2FuIGJlIHNldCBhdCBydW50aW1lLCBtb3N0DQo+
IHN0b3JhZ2UgYXJyYXlzIHByZWZlciB0byB1c2UgdGhlICdyb3VuZC1yb2JpbicgaW9wb2xpY3kg
cGVyIGRlZmF1bHQuDQo+IFdlIGNhbiB1c2UgdWRldiBydWxlcyB0byBzZXQgdGhpcywgYnV0IGlz
IGdldHRpbmcgcmF0aGVyIHVud2llbGR5DQo+IGZvciByZWJyYW5kZWQgYXJyYXlzIGFzIHdlIHdv
dWxkIGhhdmUgdG8gdXBkYXRlIHRoZSB1ZGV2IHJ1bGVzDQo+IGFueXRpbWUgYSBuZXcgYXJyYXkg
c2hvd3MgdXAsIGxlYWRpbmcgdG8gdGhlIHNhbWUgbWVzcyB3ZSBjdXJyZW50bHkNCj4gaGF2ZSBp
biBtdWx0aXBhdGhkIGZvciBjb25maWd1cmluZyB0aGUgUkRBQyBhcnJheXMuDQo+IA0KPiBIZW5j
ZSB0aGlzIHBhdGNoIGFkZHMgYSBtb2R1bGUgcGFyYW1ldGVyICdpb3BvbGljeScgdG8gYWxsb3cg
dGhlDQo+IGFkbWluIHRvIHN3aXRjaCB0aGUgZGVmYXVsdCwgYW5kIHRvIGRvIGF3YXkgd2l0aCB0
aGUgbmVlZCBmb3IgYQ0KPiB1ZGV2IHJ1bGUgaGVyZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEhh
bm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPg0KDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2Vk
LWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQo=

