Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E5DC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Nov 2021 08:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dFlmsx4l8XMmzwuLyo7+RV1Nm98/Vf5IdRPvuupcFnU=; b=wa7vEOr+WygZPkkjnDPj3R88wl
	SmBwXK2jFhYFDLtZHOTabESEXP3Zc12+Qzp5ns6i6ObZFf/UqBFOqLm9pqeA9HdBKkbo5tclxJ0kK
	WKbuCf341BOeVfX/MVMrGU22BAfxAcc4vkLjaJ3iTj0sxNjB12dNpPfLSrqlKsN81a3mEYwHJm6ac
	XwZoc2zpQrZv3RJCJ8itmXatSVVCqEQXUhICyrJ07B9TCjl8Mf+Q78V1jSCc2XvEipHs3OTPkN6EY
	A9kGRnLKhNvLWCs+ACgx41aZ2JHtf/Mogg/oaESh1qWLexxw9OD8/DLfVAJAu7VGjaXzt/uh5iLiO
	Wxb4EOng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpRHL-001Jhn-4Q; Tue, 23 Nov 2021 08:35:51 +0000
Received: from mail-dm6nam10on2083.outbound.protection.outlook.com
 ([40.107.93.83] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpRHI-001Jgg-R3
 for linux-nvme@lists.infradead.org; Tue, 23 Nov 2021 08:35:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSmMjZ33Q72RahNSvZFf1hRGP2rjujeGyRQQ/DrmdlRuPdMS9cCX79agG9m1IA9QHohGduow7QbDatQRWUmMXmIRNVH8f7oaJ0RJESxIFo/eDRXD2H0F7edXr/h4gJV3T4935NEurqj+5zUeJxDYcik5JpWoIGw1X1/Um+NwEB3b/k7KrWqZkoR2xm//yOG31Pm5uMprsC8as8kT8UPACK/3ZZgj+JmD+6FRP0fZNmwdevDyHtFsfG/0RgCGHuM7Pj0eXXL9f0TlhbjfciiHc6Q5XmMixz9eGw0kCe3c+2tisLn3wzs2qIsjZXGgguMgQStoocWlTcFBRoogFWJQbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFlmsx4l8XMmzwuLyo7+RV1Nm98/Vf5IdRPvuupcFnU=;
 b=ilIO/CJzA2oDdNau0PK2Mm0b3mr6NFy6Tm+PsXpSo6v8mTZDq1DkBUfrXQsu+OZ47/YRP/6+tFq5mWtIp5U9+QKZQtCX7jdiFNk/1/EPjDaZ+4Dmpcxd3ycw5yugK6d+j5KnWhWSiA++MzWKm+BaaZOBIXtRlPdhht3jJt165iJc8Z4MmIA1O9/3I3Uhi1+N/yQsc5AqBSs6shEdC4W4RAX7TjlJTLs5gVEBFFiw8RfxOJKltIwFsGQa8naJh+PdSqS2yBW/SQ0mQah027dX5A23SXpoNgVZ8hnIUMzGpyqch4STaIWbHqBnSyclJwc4CQrUNu/GCLnQ+l7reJtxAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFlmsx4l8XMmzwuLyo7+RV1Nm98/Vf5IdRPvuupcFnU=;
 b=li49jzctFJctLYTDJX1Zz3AAQBDejrhQBQFWemSBs33ALUUBEDFp/vOcKw35XMYUWPPm3BZP6HyeC8yhfbTF1SAS3u3pLKPo2RibFdBAOWEjjiog9CIMia9BsJeSc+5jzha1PHRDRSpUcnwVvrn/TChzB+2B9jMooF1jRdoPzq3oZNkNTtZoD0An4uCKns3pGYCSkVabFBP5wRsKjNRKHtjCFwsYXJlFF2ZRveuXbG4hxFdQlkXhDlyTVHkiDjJgAhKhRb63wWdqp8WORerNBJmAjDr3PJGmWF8DZVCZ+Da9WkoW6+tDJTyGzyaMcwH8PyAdGmx1Vjv+x36ZiejWpw==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by BL0PR12MB4707.namprd12.prod.outlook.com (2603:10b6:208:8a::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 23 Nov
 2021 08:35:41 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::6dd2:d494:d47f:5221]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::6dd2:d494:d47f:5221%7]) with mapi id 15.20.4713.026; Tue, 23 Nov 2021
 08:35:41 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Maurizio Lombardi <mlombard@redhat.com>, Chaitanya Kulkarni
 <chaitanyak@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH] nvmet: use IOCB_NOWAIT only if the filesystem supports it.
Thread-Topic: [PATCH] nvmet: use IOCB_NOWAIT only if the filesystem supports
 it.
Thread-Index: AQHX34jp7ERPBjPdpUC0t4aV+wlJ/qwQyx8A
Date: Tue, 23 Nov 2021 08:35:40 +0000
Message-ID: <8dbc5da0-682a-4c9c-cb45-390026c77104@nvidia.com>
References: <20211122100827.290117-1-mlombard@redhat.com>
In-Reply-To: <20211122100827.290117-1-mlombard@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b751aeb-396d-439b-575d-08d9ae5c3bb3
x-ms-traffictypediagnostic: BL0PR12MB4707:
x-microsoft-antispam-prvs: <BL0PR12MB470724B51ECA4C3F442B5026A3609@BL0PR12MB4707.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jFJZyoy2dPHzfwT45LnKoN72X/Yz6+dIYI/Nh57n2pxUUEK19S/t+15dsySCNeZDfGUQ7msW6+3R8kqGiNhj4ANpV+PUu9ouOpIB5xKPKSAdANqGzi3o+XLOgFhACaZaEMHUrVc/ixU4G3BwKHM0z3wT3tlGWPBamV1FmPYRyB49klb62L45F7v7lVGS31JqCbStEZmWqd5a1MoPNEtJvaFMQoX1YQ2/IVxjYltdjDOKcyBhkox/VqEaFmt7/XLPI1mQX8+aYTdS7BhAXVq1RxLgrPPU/EZbpmbk4otGs7Dq1IcbrqZL9w7Ubj63wjo1epyrscc2AYLo6yuD/5ndXi0CVhah93K0psXNb212p4zpsbva2JcBTDURrvdRvTj+z3cNMg0uj6Of2PjBZbth0ZJa/xdv1NNbFsvHwbnWrYujBKobhgs7cmOOOS5PJiQTTrVFr2dxXGKMZChmtsCBsxeyOoyUKfbpk3hZJ0/6QQgTQVNAt6stGVE+iNDONT6YlIpw/lywigUzm86nuy/PS4ALUbfyYlesMM6dR8U2FpN4LSRVVwMfxeBayRPM2ZHR4EGa0GR3o9vpHvZEnOHU/h2jxzo56KuAmowKeHYrKWh5fGjFJZRtOX4Rr3/l2HP2XKkqEJziePnJuAqw8Drmr+m/5R7GWQz8sH25Z8VsYP4o66NWSdE/8UiWgDYLRmESc2aUbKBcIKoSi7aotvMnql1gLsOgWMHqYpWF5YwYqp3yaVJe4gZAfUOeITOUYRpaFCpPOEMfG2pMOFOzdwsOuw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(91956017)(76116006)(122000001)(2906002)(66946007)(36756003)(110136005)(54906003)(8676002)(38100700002)(6512007)(186003)(66556008)(64756008)(66446008)(4326008)(31696002)(83380400001)(66476007)(316002)(86362001)(31686004)(5660300002)(4744005)(2616005)(71200400001)(6486002)(53546011)(6506007)(38070700005)(8936002)(508600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzVoeEZMTS9ZVWtNK05ER1pYWGsvRkNkSmdMNHRsbUtNanRtdmlPMmptTTlQ?=
 =?utf-8?B?clN1QldBbjBVMnhwVnU3U1BJcURSdUxreTIrTXd6ZXlNTTkwRi81S3V3bHFL?=
 =?utf-8?B?TzlibE1pL1NuYU9jdno4NTlGblBndzZJWmYzSTArekZ2c2xUdEloOFRoVW5S?=
 =?utf-8?B?dUQxZHN0UTJrLzRNZWxZTXMvZkluZ0tJSnhkMHp4L3NvWWVEVUFrclppM0ll?=
 =?utf-8?B?L2dsNjBKNTJHVkRvbVdkY1FhRkEyY3lYbGZoMFVrbTVrYy9PTGpRWVBlT1RS?=
 =?utf-8?B?T3pTU05zd1hLNzh3dnRLTHFMNWtob0VXNWYwNFRKR3o4c1kvd0c0Ui9ZTEdt?=
 =?utf-8?B?NFdCbGZteHpOZW56QkFob2g2dnovNW5lR0h1TDZiTVRTTGVtSFM3UElPUUI0?=
 =?utf-8?B?QStzWlVFLzRVNlA2RExaQTJ4dUpjaHF4QjcxcFhOclFEcE1KVSs2VXVYZU1y?=
 =?utf-8?B?cjNEc2M3cHhaVnpPbXg1aFdDTmgyZG5NSzJZSzBvN0pyekpOaElSWnpVR284?=
 =?utf-8?B?dkxPck13YTJmMDFvQ2k0aTlRbkZLd0puV3hFaW1WQ20rVGlSQlRtd0MxYjQz?=
 =?utf-8?B?ZW9tSHNVejVTa0YweC9zZDZEOHhlTHkvV2xHMlFVdSswWUJyRHdZOUlleUNu?=
 =?utf-8?B?T3hKU29kM29qWFR2UE1qNDJQckZXRW04TGFGUFlJTUR2N2dpY0w1eXVTT1Nh?=
 =?utf-8?B?ZTFIU1NxUjc2TkttcUZTOWhjOUF5N0xZdjZPV2RZWkwzV2sxaUVjRnNnWkFD?=
 =?utf-8?B?WEVpNXUwN09OaGtTbldhOVlHOVV5V3R5RHhuc3ZHVmVBYVBLVFRCc0JQMGR1?=
 =?utf-8?B?cG9uZURTcEJiMEcrL3NIelpXZXNNcHB3YUl6MWZQYXk3bmMyT2syMVVzMk9x?=
 =?utf-8?B?YTNzbTBmTHJ4dHFURTJzSnR3Tmk1LzZodVhTS0NZcVZibXhENUh2VGw3NXBl?=
 =?utf-8?B?ZkRLdE1KMlJFbGw3L0lwbVRIWSt5L3BxeTlNSG9uLzRCZm5wakE1VTVPYzNs?=
 =?utf-8?B?eU9TWWZwdk5kTjJLNDhpaEEzZVNEZTVkWFphWHBVSVNZTExPVXM0K0VnNnd1?=
 =?utf-8?B?dEU4dmhYWC8xZFZJOUQyTlF0dHpyT3hXODFDb1hkMGNsaVJ4RGMvWjhOOWFz?=
 =?utf-8?B?QWVFTGFnUW0rYTVJLzIzSDdpRGhaNTJwNnMwVUExZ0JEdmNTWkhQTGEvK0p4?=
 =?utf-8?B?VWhuRGJnNUlldExONHpncHRPenpidC8wWDE5NWVmc094N1Qzd1l6VjdzRGg0?=
 =?utf-8?B?Q2orSTVzRlRqRndaREJPdFJVWGJEM0xHTGJNRlNaNStFQ3VpMG80bXBUcDAz?=
 =?utf-8?B?eDlEbmZYY3FGc3ozK1FCT2M0elRQZU1TL1FDdnV5cHRrTHhXcHRjaUNZRHgv?=
 =?utf-8?B?NFE1WFRRMm5SbmM1cTJ2OFRUS2pJenhVeDVEQkJCKzB1WjZDRkRxTU5SUklL?=
 =?utf-8?B?RFBwOHVvVDB0Y0ZKU2tXZ1pPenpVTzRGenZ1OW1tZFVLQWFhRE5aTFVBandt?=
 =?utf-8?B?MFRqdFdZencyd2FlMzFqWlJ3T2JoQnhuRzhLU1h5UG9sNVpaenduMVZYOGFv?=
 =?utf-8?B?b2hRbHdqUEduS3BoOWlkNVIvUm9JK0c1UUl2ZDhFWXdFMldPajFuRkRvUU5C?=
 =?utf-8?B?Mm9PcXpNL0RqeWFmelVXWVQvUW40NTdFQUw5aFhEMThhVzRnbGlmYUp4OW41?=
 =?utf-8?B?S2wzOWliL2xGeXc5bHFBUk9qUWQyYkZUc2tSaU5BWHhtaVhMVzdaeFZzb1l0?=
 =?utf-8?B?Y2ZrS1IvRlpia01TeU4yRTZWdzdsU3pHazlmaU1QVjFnS2dweXp4NDF1dmZL?=
 =?utf-8?B?bjRPTEtQZjIvUVBoTW9Oa1UzUFdKek0rdSthbHJpWWQ4akRIRG9RR0syQXE2?=
 =?utf-8?B?SytZRk1NcUFIcDRVK1ZFYWpBTitwdzJwR3ZodHhta0kvY1ZzVEo4Z3dHYTRp?=
 =?utf-8?B?RVVkT1JhcFF1bXN6Z0t4VExONzVucHhhcVk4d252U0hSenNUd1FxUld5S1ow?=
 =?utf-8?B?K2VIQm1TL1FsWFpMQTA1aHU0bnFSeVZDUEM4MDFWYkEvdzBWODNaSzd3RU9O?=
 =?utf-8?B?TTJ2bUkvNGd5K015NzJLZnYwRW5HYUtzVEh1WHY1cHZKR0FhbFNPdGZnT3RZ?=
 =?utf-8?B?bmdLREEvU1JINCs2eWRDYTN3azR6S0l4ODZPSFRJNlAvVkE3QTJMUXlKMVJV?=
 =?utf-8?Q?as/NA6yBjWtPINwhjz3aP5Z/PBdE6XkFdzN6TJJiWSp7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A4D982204E278479BDF3D47F6B4E7E2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b751aeb-396d-439b-575d-08d9ae5c3bb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2021 08:35:41.0179 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mtjd4H4/IXIWy89VwWt2Rz933wrf0Ug81BMrT0YHqK5GrxghRwzjRZ/V4lgX3wY1Dt2ZnziBn0BAJoks8dpvQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4707
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211123_003548_982490_A28402F0 
X-CRM114-Status: UNSURE (   9.59  )
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

T24gMTEvMjIvMjEgMDI6MDgsIE1hdXJpemlvIExvbWJhcmRpIHdyb3RlOg0KPiBFeHRlcm5hbCBl
bWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+
IFN1Ym1pdCBJL08gcmVxdWVzdHMgd2l0aCB0aGUgSU9DQl9OT1dBSVQgZmxhZyBzZXQgb25seSBp
Zg0KPiB0aGUgdW5kZXJseWluZyBmaWxlc3lzdGVtIHN1cHBvcnRzIGl0Lg0KPiANCj4gRml4ZXM6
IDUwYTkwOWRiMzZmMiAoIm52bWV0OiB1c2UgSU9DQl9OT1dBSVQgZm9yIGZpbGUtbnMgYnVmZmVy
ZWQgSS9PIikNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hdXJpemlvIExvbWJhcmRpIDxtbG9tYmFy
ZEByZWRoYXQuY29tPg0KPiAtLS0NCg0KV2l0aCBTYWdpJ3MgY29tbWVudCwgbG9va3MgZ29vZC4N
Cg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCg0K

