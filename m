Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A906C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jul 2022 23:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iR/lsQvGQxvW3D3auQPBu+3bojifxJTmH0jtsqF7UuA=; b=qucz709uSyB7/PPgg3kcuxclF4
	1QTt8ujl+kLOsO5AaBkPQZcoHwVJYzbpxy478MtA9PzslWXpPhvIa9SOKZjuXkXoEBISN+VRb/r1Q
	GhJex72yRJmobQRqhBBVzWzkdf8GG50/94m/VbZS2A2q6Aydjz8h+vUlMn3GxnmoqDwebTDJ2QIT5
	etRFHGl2Onq9yyl3t6hzwlyXlw3sCbC7qJq6zQqVbm5rVT4/2zSE0Q79nD0NvjgxOg8IAxph4xvFc
	UNHeyibY9yJ9/AEzk8rFL6R0gi1j2qlVS55pYK0Au6DADTjjjTCASml0nrP+LQ4aS5LUvavdp3Qpy
	uYzJkeJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDZvf-002XGs-ON; Mon, 18 Jul 2022 23:13:31 +0000
Received: from mail-dm6nam11on2047.outbound.protection.outlook.com ([40.107.223.47] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDZvd-002XBF-I0
	for linux-nvme@lists.infradead.org; Mon, 18 Jul 2022 23:13:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BM7bu54pyuXK3Psd5XtkEnpw7jTTnrmzP1hboxds9BlZsEugwd8c9cqrLXhzmtaDylTsjYg2yQGv7yT5EZhym/VLUgJv9g4GQYtv/WNts1ClvVQ2+ibZk08db3uLmJhJBAyaxumD7S5v9w5pZYjtppoIn/jiNdmwfdi2QWkU7FVySpnbJ9VrBoazBSh4YHssYZkjtVOW3oYxyxJ/+sAg9mN3FlSQUqPjIThZGbM3aAC8CUmMSCClbgrLQHat77qCuovX441NSpChb4OlTTi0rqX8aYXuz2/po1nyQX4w+csPgqkG+1M75dO3dm8ymEPpiWuFR6AqqSlELW7VUl3k0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iR/lsQvGQxvW3D3auQPBu+3bojifxJTmH0jtsqF7UuA=;
 b=nMe6drCoq1UpzhMMRbZR9baD/52sjTVRGhHz7toWaehjiQ+NJZC/JdN9FR9ht+01XyjIAF1zUqen7x3/xqFc5PR4qFKYsRqSpYy6Ue3+lKq951Tn8TrtScXd4TNhW1LN5b+mIBa3K6+POfdxKn+ab5VjtaK/FMcYbzTdK4fplBCs7TW+IIYwtOitm5hCkHx45mQEEUzNscnahLoaIjpGEQpVjJO17V6p5UfS7aQrJOV4ki1fHXTBAuE8QNCkkfNEEKg8fk9Vg4WS542oM/h9ZhQpFRX526jSB/hrck6ISk4GQ0u3/eGEg+YrZgvZQYX8dt21xBzLpKIYvMDqVhrOjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iR/lsQvGQxvW3D3auQPBu+3bojifxJTmH0jtsqF7UuA=;
 b=PvfLeskIPLzDReZFpnAhJrlKhq1uPhDxO+FIdj2gNnq5yb4eogFhTqkHu+BTaP14xXVPBYFIuwgndgt7Q/kWRnTjfYYNq2rSa+UIAqJTFOkBnOl61kk/dCukENamAXJ8K1c5ZpyRF4jp1VwtVPr2N8y5Ks06KI5EBYsBg2zmoVjFErrwmjydKwY4+eCKvfGJ/BCK+wCX16L/v+x4TwAmdTdHY0eSU7B0FlJY5BOlbzeTxWdBsJDcEmcUF0gGFeHvA6pODjwM/KCv34hZH2BSwR8Gyjoold3EjeTVYjS8kJe72QTVKv5AhJ2m5+cFBYvBSSfpzbgmZ5LSt5Bm81Ps+w==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BN8PR12MB3299.namprd12.prod.outlook.com (2603:10b6:408:9a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.22; Mon, 18 Jul
 2022 23:13:23 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::d01a:8f50:460:512]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::d01a:8f50:460:512%5]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 23:13:23 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Dan Carpenter <dan.carpenter@oracle.com>, "hare@suse.de" <hare@suse.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [bug report] nvmet: implement basic In-Band Authentication
Thread-Topic: [bug report] nvmet: implement basic In-Band Authentication
Thread-Index: AQHYmqiEGUd2gvmI9UKGBLFaXwoYjq2EwqOA
Date: Mon, 18 Jul 2022 23:13:23 +0000
Message-ID: <4b7f6cf5-117c-81d0-17cf-952f4e84d1b3@nvidia.com>
References: <YtVctvOUthLBZeir@kili>
In-Reply-To: <YtVctvOUthLBZeir@kili>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8d8f0c7-91d0-48d6-4df9-08da69131cea
x-ms-traffictypediagnostic: BN8PR12MB3299:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  MZHddwg5tE+1rfAa/XHI3O7EwnqMCaIIRqwlwr1XJnzcHBLCfAUnIydx1Ni/gAznTKYan5M9CjJxc5ydFCVKhdnsEWvfh5yaHMQenVyREaLHWkUVTb9Hhz9zHQ3J2ohpQSjsCKvIn+4T4sb9YohcdRQAJODOuRlw9Tc6wk0X8/Cnx2sC53eiii2d5ZUTjf6y2Nmq7XysSnM8SJFeU4M00cp6YLAvEHZ91wvXDHmDdP/BbM79dOZjA6TryQ4kNuCB65R0efgpPI/CscgjoH4U/Q72AvnWFmVJHK6jZhrY1M9/jC85yp8/Zjef/D7kjxzNt+wCxgDVupGjWoV87ofmjKeWqvC/xx2Iw5tCp5BoQbhI9Z+Nc7zF57prjwoCzROEfoLFsH9RkC2fiBG3svPc3FqRvIhz6L1eCobITHkGYjF2WL1P/XgCXnFlts25MWyif4uE2gzMEvl6KVA6sd+dMdroFDNZl3g4LXZ+sizIX7FmNquifyCjwZ+Y1Imx1TMpdJv03iq8w1/MytQA+JNMFj3MNQmkKV+xfWHAxfL2g+yz/s9g1xqF6TtWiwOKUS9TnF9s0KFktZGHWXfjE0/gCp91EWzlA7vO0Fr6QwxPEm/K6LAwHpNLnfybVyO7Kc7vpp0UZg+35STJwUjcgupwuwSnR9IaGQ07O4Vq24xs14+mnjvCKICepuAa7j3qQL9q2alUhiVymVNAT0R0HKezZyCU0uueM0e8tX292+o9wgFFZz4mdD+bzMjvsWOTJf+WCpSSHdkUbNXPMPO8necAx3ekLRK+JZbOGFX0WV35LviEfVB3d3mAodeNKexCoptX8bVm6hpY4NLsJen9vfStt1CvHaoU10H6Hwfrf4wmPIZ2Iq1S0R7pINHcIgCuNcMh
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(66556008)(2616005)(76116006)(66946007)(66476007)(6512007)(478600001)(64756008)(66446008)(4326008)(186003)(8676002)(83380400001)(31686004)(53546011)(41300700001)(36756003)(6486002)(8936002)(6506007)(38070700005)(122000001)(4744005)(5660300002)(2906002)(71200400001)(91956017)(38100700002)(110136005)(86362001)(31696002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?Q3lpRVNCQmY3NWY3L2tKbW5lMEhJK0FLd3dHanhMU01lWFZUSmZyNE5LS3hp?=
 =?utf-8?B?aXozenBPc242bXZOVm5QMWduempORHVPRE5yVnI5MFVXQnJPR1Y2V2VVQ0Fz?=
 =?utf-8?B?OGxSc0hsTjBXaWFCKzRhZ3ZYY0dVOVpiTDh5SkpiS3EvUHpHVjJ5Y1ZOOGpV?=
 =?utf-8?B?YUlzWE5HdjNaaTIzWXZyZzlTYXhzWGJXVm42MDNaeEJncmJxVlI1SVdWWkRn?=
 =?utf-8?B?ZWxMRmJzellMMmkwamJZVENFM29SV2lYSysxY2Yyd1htam90Nks5WFpxVjJq?=
 =?utf-8?B?U2NEWUhTSG55RVJoaXN3cmh6MW83aWlGdmltWUdFWEJtSUdPc1VyTExkT2Ew?=
 =?utf-8?B?KzErZFhtTTVsZ3p2VkpnZXdjM0xUZkdxSXBxYis5aFg4RzBPakZBZXhOYktV?=
 =?utf-8?B?SnBsdDB4Uy90THlVcXlWbGZNMWloVjk3T0p5UkErOVRTTVdaeWFISDBJSTRq?=
 =?utf-8?B?eGdBWXhncUNTSndWaVdaYWFBeWUwMURnUmY2TFhWd0NnSCtVZWN3bEFxSklj?=
 =?utf-8?B?VXlTejRlVUtGNExEcG9QR1lWb21YUEhTYU00R0xkSEN2WHY4Vk9RZy9oYXYv?=
 =?utf-8?B?WEJFbXNBektxbzE4MVljMGlNT01tVTZQazZwbGZiRkp1L2JjRUcvUGRzaGI3?=
 =?utf-8?B?cHZwVjdoeCsrekV0SlZJNGhmN1J4dE42YlVmOVEvcVVwYXMzUkd4WHNXcUt2?=
 =?utf-8?B?ZnI2cjNGK1Exb3JmdzZVVTEweUFadmRocUQvaVpnbWl1Y1ZFS3dHU3dJZm1C?=
 =?utf-8?B?UE5WUVhzN0NRQXBDVlFodTBEcFp0RndDRUFvYVIvKzNGRm51eld5TFdkRllq?=
 =?utf-8?B?RHUvUUVxbmh4WWZnVUZGRkJoTkVOOUc4UjZHb3NjMXVSS0ZFSmh0cXNTc3Zh?=
 =?utf-8?B?cjJXN1crdTZZczlxbERSeVpDMDd1QnlNV1owV0l4WXIrR0J3WjEzajBwRVdM?=
 =?utf-8?B?MmVaR2hTYnV3aFVoajc4S2NsVjZQV2dCS2VIL04wNnhvUVBqRjFyUGNyUmxB?=
 =?utf-8?B?bzNCTDcyZDBzd1dlUGNDQlhlUEE4Y1hkeDVyajVHbUg5VzVIbFQrajB4LzM3?=
 =?utf-8?B?ZlNlMkJvSG5meFVtdWx5VWRvbzI2dWQrRDhqOXNhYmhWK2pIUWFiaUx3aytO?=
 =?utf-8?B?NWwwdEk0WEJCNytrSDNYdDlrNzNnWHhEUlhBYWxETEwzZ2dNNFlLejJINHVW?=
 =?utf-8?B?d295UjNrRHkwczNxUlIrcVg1REVWY3Y2cVVnc3VYOThva3BrQjQ0YlU2Ympw?=
 =?utf-8?B?V1pLUTN4bHRhTDVPNzdSM09rKy92Umg4TERsWVRMNWExV1l6L2RkejkwOHlo?=
 =?utf-8?B?aktFTUV1K29uQlB1VDhqUzFDOW1QN0o2NWZ1NzNSdFpOY0N3U043TXRRZDJD?=
 =?utf-8?B?MTlXTXgwbmhHc3c3dFhjWHBHWWM2SURzcDQ2eEsySTdYRGlDazZvME1ZSllI?=
 =?utf-8?B?NzVUVndmMFB4K2pnWlVsazRzNmF0dlV3QkFvdDFMTXNWbUVabGsxRmVid1gz?=
 =?utf-8?B?a0tZd0RxVFhMc3Z6aWJDMDhQY0Frd1hSWnZEcW13bVdpTm9VTGZmT3A1UlNv?=
 =?utf-8?B?bmxxYm5nZkx3YUFGREwxY1RYUHFXY3pXN3lXOUlYaEl2cHVPMUNxelNHVTVZ?=
 =?utf-8?B?M1YrcTg3Zy9Rc2k4TEJYNEh4VDFnNHIrSDdNU3M5di9rOXhMT1lhWUxPYm9l?=
 =?utf-8?B?Qi8wUEhDWE1WczgzS2ZhVm9EdnpJK2Vnb05JUXVld2MwTTdrcnk5ZnJQMUFP?=
 =?utf-8?B?VlY1WG9udEFGdGlHcU9MTnlyVndSQnc1VFlEekJrYWt6T0s2dllZS0JjNmpU?=
 =?utf-8?B?ODlIM21XWmRYb1V6ZkJPMWFjci9KajR5OFA4S1J6WS9UM1BEZ0pSWVdKVDFZ?=
 =?utf-8?B?VU11bTBqVkxSZDdrd1IrUTROTTNBMjFqNmVjcldBSXdwWmpDZCt2TXorRDB1?=
 =?utf-8?B?U3Z3NnBmSGF4K3NlQzZWdkwwK3Q4NVd4T2FUSGJBS2hRM1R1Zjljdm9kaDlp?=
 =?utf-8?B?L0tmRTdsTWNxRVNyUmlzYU1KdXc5cmc1RWZJbndvRGw2MjBOV1dWV1FDWTRG?=
 =?utf-8?B?ald3VWR6Y3RlUGFVcjM0WmFiVkdQQkxzQUIxd2FhejgwQ1lOMkk0bmIzTzBm?=
 =?utf-8?B?Mi9wMUlNZTI4WUtRYzVxdUM2Wm1aNWVFdWp2MWRTaFVPcXVOY3V6dnQwOWpj?=
 =?utf-8?Q?TQONxh9+5OcICsc93PrYydPnTkTR/3JGlsaCc/6wmaDO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D73283FEEBB5454DB0F3FBBCDC251CCB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d8f0c7-91d0-48d6-4df9-08da69131cea
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 23:13:23.6602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4wJOAhMfR/vjPm+vqIeOqsjM9tbrw7UpYgvzbeF+H5ODSSxa03KHLRxn6LnGZ/o+6i8sFjlZ/9T+Queqrz5jEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3299
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220718_161329_618987_5EAAFF80 
X-CRM114-Status: UNSURE (   8.09  )
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

T24gNy8xOC8yMiAwNjoxNCwgRGFuIENhcnBlbnRlciB3cm90ZToNCj4gSGVsbG8gSGFubmVzIFJl
aW5lY2tlLA0KPiANCj4gVGhlIHBhdGNoIGIyODFiZWM3NTk0NjogIm52bWV0OiBpbXBsZW1lbnQg
YmFzaWMgSW4tQmFuZA0KPiBBdXRoZW50aWNhdGlvbiIgZnJvbSBKdW4gMjcsIDIwMjIsIGxlYWRz
IHRvIHRoZSBmb2xsb3dpbmcgU21hdGNoDQo+IHN0YXRpYyBjaGVja2VyIHdhcm5pbmc6DQo+IA0K
PiAgICAgIGRyaXZlcnMvbnZtZS90YXJnZXQvZmFicmljcy1jbWQtYXV0aC5jOjI1MSBudm1ldF9l
eGVjdXRlX2F1dGhfc2VuZCgpDQo+ICAgICAgd2FybjogaW1wb3NzaWJsZSBjb25kaXRpb24gJyhz
dGF0dXMgPCAwKSA9PiAoMC11MTZtYXggPCAwKScNCj4gDQo+ICAgICAgZHJpdmVycy9udm1lL3Rh
cmdldC9mYWJyaWNzLWNtZC1hdXRoLmM6NDg4IG52bWV0X2V4ZWN1dGVfYXV0aF9yZWNlaXZlKCkN
Cj4gICAgICB3YXJuOiBpbXBvc3NpYmxlIGNvbmRpdGlvbiAnKHN0YXR1cyA8IDApID0+ICgwLXUx
Nm1heCA8IDApJw0KPiANCg0KdGhhbmtzIGZvciByZXBvcnRpbmcgdGhpcywgSSd2ZSBzZW50IG91
dCBhIGZpeC4NCg0KLWNrDQoNCg0K

