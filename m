Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7117C4345F
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Apr 2024 02:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gshL5VErzbjakS8e+qBqHmTJsN64ditgJhl4k4BPO/4=; b=IlwdPTzFVA8ws406txchNP2aW1
	/7kPggHPoKB6cRZk6zvp9YU6zho/40IN4rDgTF/+aPbWS1ZKOn2Hi1mwVTETzh6Tap2SFsozFkYFE
	fIi6X0h0ZCl/po1CdDkQdEbBt/jHYiskHs4W838jst4MgmULghfLPw19T588afHQzLT+IIqOBMm33
	5Fq79+OBF4Q109vx8/gfSqQaDmdRKvqpAq38LlQsI/Z4GjNwV3qYtr0BI+fq7+fB46QpCyT4DfcU7
	Z2vnzyQ6a0CAwjE3ONeljfzEcvqBEHphR/X64LzqLQN0tZx9lyiXbV5n2azsrFGScJqLtGbwM+kL/
	2kGpIDgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwYn2-0000000AZOL-2wZd;
	Tue, 16 Apr 2024 02:43:20 +0000
Received: from mail-bn7nam10on20600.outbound.protection.outlook.com ([2a01:111:f403:2009::600] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwYmy-0000000AZNo-49z5
	for linux-nvme@lists.infradead.org;
	Tue, 16 Apr 2024 02:43:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cghvgk0Uv6pCIOQHRM7Jpf3ePbDKADthQmOmaxl68ePX292Wu7bPHwdn/H7fQ0c/nL5N8C4Hbu9DJIHonqk34ReLsFOpLhU7ZN9K7GxYOhVUEwETd84ka4Q7G1ghmapWO2GQRArpuE0Sj5SOegln3+z3d+iF6VtpfuwEJrSE+ohlvbZ87dHahCO0B1IUtMPEw47LBIIlr8cnifBch7REp3s2fJnQehXZag2jv/P9YRk26Dwromd1L1528XIFwvAZ47vkUdyTSYB4BJjelw3lt6Fu9GxrkMJgItxXO/JSBZWWpAAuAec1bmT7V+8s6tM7xEtOHeywYGg5m2Ef2ZC/2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gshL5VErzbjakS8e+qBqHmTJsN64ditgJhl4k4BPO/4=;
 b=KnqyjP4NQ//GXd8PNgsa+mKAkICyeW02yEXg16jKl7odIQu/5fFP+TUBmTS3Gxbr6mE9GmJCioBn1e2/BvFYQQJfQuKNUe1l8NCR8470rpdH7GdF+Gssn1KQONQOfgLhEfESHQsp2brI18tnoDBrWEBNVR344Q9C8PEav9a00x6IcH0rxZtZ68AwDPuGJZz5BYCKbbqApFj63Zuf1DpdB57vfkQUvE7hWmuUVtftylBjx5JFUJFQFF02SVVNy9d7I4ajogBwqCW/s6hUCWdv807EAbFLlnQsXc74NJz5AukuvqJ572RP8XIjDkIJukxXUpnWrZNnhte6XfeqodvE0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gshL5VErzbjakS8e+qBqHmTJsN64ditgJhl4k4BPO/4=;
 b=uiyIflx0EP29O4MpWK4JYeYJl98grmmRRjytyWI7oGS0e1bU1c1/BEp7Aaenyg9RiyapoV6DuaeJoiJXkmFdi28Y9joNOc5ntvcye7VeYVoGnm526OZh8GchBm8a9VNY7/Cw8b1IrQziy1MPdI39J/ofp0m3l+zFs4VTefQ3IlOFzo09D3TLbmao8JH+E6lXNqfkVBJWp9qEPQdm56I3I2AfyklJW9F7Cqj+fWkv9eesOIL0DEm/B0rNFIJxHsrypqvZvFzyx9/+Fn0molXbp0Ou+qv4Ea1LL1LHe+9DqyzM37CSXeojA7a66QgEKquDKL2KODgpVXZmdIfvPl4GQg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by LV3PR12MB9119.namprd12.prod.outlook.com (2603:10b6:408:1a2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 02:43:12 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 02:43:12 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "soni.ankit@samsung.com"
	<soni.ankit@samsung.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"sathya.m@samsung.com" <sathya.m@samsung.com>, "d.palani@samsung.com"
	<d.palani@samsung.com>, "axboe@fb.com" <axboe@fb.com>,
	"prakash.bv@samsung.com" <prakash.bv@samsung.com>, "anshul@samsung.com"
	<anshul@samsung.com>, "ankitvvsoni@gmail.com" <ankitvvsoni@gmail.com>,
	"hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>
Subject: Re: [PATCH 1/1] nvme-tcp: check for invalid request
Thread-Topic: [PATCH 1/1] nvme-tcp: check for invalid request
Thread-Index: AQHaiZ7v2UvIF0O8oEqUttaMg+bPJrFeNt2AgAwFigA=
Date: Tue, 16 Apr 2024 02:43:12 +0000
Message-ID: <2941218d-48bb-4f0f-a166-cdfe8547491e@nvidia.com>
References: <CGME20240408102150epcas5p2d5b4c3460fca7fe58520254a2466271b@epcas5p2.samsung.com>
 <20240408045328.542327-1-soni.ankit@samsung.com>
 <516a90cb-c03f-4474-8456-056bb3bd87fc@grimberg.me>
In-Reply-To: <516a90cb-c03f-4474-8456-056bb3bd87fc@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|LV3PR12MB9119:EE_
x-ms-office365-filtering-correlation-id: 7a4ef507-6a4f-4d29-80c6-08dc5dbef58c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qt071uxXqf2gr3VfB7Tz3d2hxAgRgHBsIP3/BA7JoWHNeC7CdCvTVzw7ZuwAL+GlOSCSnkPnKUTndB8lNf6AJ+wa7fQqP02Lqt/HTuPSCSI1yv8ZEpfs9IqBlzepHJ37EX8l/SyAdd5JBXkD1bJPZ+5ckJOeuDFL317uA+JAP00ZlbaBMqwEFS1YqpLblVOv64e6Rc5EtfSUVRhYxg1iHrV316mbqlwyb660DMpXEqn1vSkr1atfWTwMpNmSstISUF6mrs9YuFcY7kM7ANkHmNCafElIAaR2QurYQyBXluUFo7igzdFPw6vo+fnP/PHX8RyhjpJFG4Qy90cfIt7xGr3FgAEc9AYkX2h/qwU0sXpHiYgw2FXHw5c/hcOiN7sp/MiZ/ZGDLV6ONscG36pdqzqAqxVhgA36br4yEiA+CVxdEs8tV50xYroz35B3uIuv9eiIHmwAcBwt5oSbBjbur0KNswXJN7jQtshnpsYGonV3SjZYafkFkJomj5vqoouXbxKUTA9Nyf4E67sjICRiX8BJBi9XwnJUm7dywJGgofRlhmtHqTyQqSzbps97pHB8p0vPUe58J4iUXdgaYxzB2CeAFuBcWxXoF7/1f9OwwCFlCtxOkM88pQPJqjwORcsNdfDymk2PEL/DRHz+mTSE8Iv5/4ItqN+Z7QeB5qNgiAC33xnousY86Ow9glq8CaTdLA5LDpKzVUkzAmqoeagwTmlnadacws+B2Nc45Q1D3u8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUlERE9xbmE1Y0kvS2lWT2JGTy92MHJFTkM0bmpUc3BBOTNOd1dpZVdRVWlB?=
 =?utf-8?B?UWY5dG05Ti9OYTdqZEdpNnNQNUl4S3orU3BNOCtQZkgwU2VKamJFVXJzYnhE?=
 =?utf-8?B?R3h6d1RmOUZvZldZN1lWeHdiRFFLaUhkVEFXbU9xNjNLY0N3WExwUWpXWjNj?=
 =?utf-8?B?a3JPaTNGRSt0djA3MDN4aHd3Y1FyQytCNS82OGZrR3hhcmlDdlhxdk9qczlP?=
 =?utf-8?B?VDVXajhlaXdLU01NOFczRS9EVG1tMUpDN2pRQUNvNnNlbjBjbUU5VE1PQmd5?=
 =?utf-8?B?Y1JGUmttTGhKUnhHb2VlV0lWZEVtSGNheGRsS04zWWFzMUszTHpzNC9tbkpi?=
 =?utf-8?B?bmYzN0xHQTZqRmdVdWJGUEg4VTJJVFF3cktZak9uWnFJLzlqSTFaUzdOTkFn?=
 =?utf-8?B?R3Z3RGpqY3FlUmZJYWRXejlHL3FIc3BkMzUzR01TK203WmZUMmo4aEJPMzdR?=
 =?utf-8?B?MnovUWV4L251WHl1WEtqRCtvSGRlZFJtT2hVakFOZnRBL1oyT1dqUlp0SjM0?=
 =?utf-8?B?U0ZtakNCUlJVbmxJYXlNenUyb0tsdXczdWdPaUxFaVlvbGQyT2hDamNETnlm?=
 =?utf-8?B?b1NhRGd2TkxUVnBuVmIyQXlTYi9XdFh3WEdqNFBJVU1VT1hpVi9GQTVCNmw0?=
 =?utf-8?B?MWpMYUJFRVVIRGx1M3dHS1B2cWMyeHdsNFpubjUvSWpkejB0cFBMZlE5bkZh?=
 =?utf-8?B?OTNWKzVWSkR2enkyd2dsMWJtZEQ0SWk3Z0piYmpMeTVxbU1GV0R6bm5XQTlE?=
 =?utf-8?B?Y0hoTEtaZEY5ZWhab3pzV0hvdWtKcE5seEs1MVBTcmN1V2lTMTB4RllrZzg1?=
 =?utf-8?B?S3dGTVE4TGtNQTdiVmFrYjVnWFZvR3g1RzRwUHh1anlSRkVQQi91L0tmSWhI?=
 =?utf-8?B?SmtZMEd0dWd4b0M1RVQ0OUkyQzNnY3Y3eFRrOWMzUDBEb2VJTjVGL3MwRlRY?=
 =?utf-8?B?b1hBUWRwZXhzcklBWmZnRU1nQjlsSWNjV2lDN2JoWm5hWS9mTUVBMEY5M1BF?=
 =?utf-8?B?b2JEbGdNTzF2VXBFK0tYNThHTmlDT1M0Q2tNTStJLzBkOWNWK2xkekRiZy9q?=
 =?utf-8?B?bkJBUUZheExyL3M4YVFSczBVODhXWEZ0RFFPTUZhMXhPcGRlaUdNVUdIQ1ky?=
 =?utf-8?B?SVV6VFR5bkhha2RLRGMzNURqTHZ2bENYd283OVc4T1hORkpEZGhGZlpuQm4y?=
 =?utf-8?B?Tmx2MTJpN1NyZGNIUExhNEFFMVl5T0QzdUw0YWxuMW8yWVhnSk9raTVlUVcw?=
 =?utf-8?B?NlRTeGtCRk55YXdFT0s0UlN3bUxpbjJ6bWZWOEh1dUNrRGlsRnZtWCtIVC9F?=
 =?utf-8?B?eVRDc1Bab2xHZU1BOGdIY2U3NW5OdWJ2S3hxaHV3aWQ0WUtFclBHQnZ1YkNu?=
 =?utf-8?B?enBMazczY1ZKVWIxY2J3ZlU0Qzd3TmhJSHVwaS9Rd1lpMXBoemt2ckl6MHhq?=
 =?utf-8?B?YW8rWGtHZXNJM0hhMTdtV2RpaVRGbXRab0toVnE2NmJNRitTbEl6R2wyenR1?=
 =?utf-8?B?aVhwRGxCOG5USlBLcTgzZVNRejlBdFBCSUl1WUxHakJiSHJoMTdkb2xNL2RG?=
 =?utf-8?B?VlBqZHhsQ01Oc2RUaCttYk9uUktsUExqaUlqcG1XVXhTTnFXanJCK2s3ZXhE?=
 =?utf-8?B?aCt1YXlBclliS1NoQlZSU24wemt6eUpITGREZ3YxTUhHcGhnb0I0VUdDTjNB?=
 =?utf-8?B?ZkQrNWdYb2lyajYvam1NOTBGVlpsS1hsRURVSmFvNjh0ck5EblRiQkhrd09I?=
 =?utf-8?B?NnJNOW9uMDFieXowVG83R3FCNUtmSTNFRTlMeTVScC95R1d5Rlp4YzZCam1v?=
 =?utf-8?B?U2IwczBRUytPTllnUm1Vd2V0RmFvZTVZemJpdjhDcVp2dWRaZGdpQmttTzJz?=
 =?utf-8?B?MzlJWXluRTR1QWlteXFQWXAxYVlWZXIwOVh1ektWcDN3Qk9kUHRTNGhNSm5h?=
 =?utf-8?B?YzYxZW05V1h0bFVWckgzZUNmNDhxTlM3Z1l5VGhnbU00V2E4MEQ5NURIZ2J6?=
 =?utf-8?B?aXZiQ0tsQWVubUY0UFYyYUNsblBYY0F5NERrT1BHNEVleDRVYkZhZmIvY1p6?=
 =?utf-8?B?am90U2JTWFZVZDg1L3dUMWtwdVNlRVlWZjBPWjdvTURpMld3eVNLY1pBMzZs?=
 =?utf-8?B?eXYvMjh4NCt2emcyZTZ4VWFZdTlobmlCVzFEaFFCUmhHZ2xDQVJvbm1MNWNo?=
 =?utf-8?Q?r9g84gSN4upzKNhN8yGaJ5aye4juNoMMwYX0TNpbMfoF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5D3F3F103E273439A45B545AEFF04CE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a4ef507-6a4f-4d29-80c6-08dc5dbef58c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 02:43:12.3932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VWGv4ZEhqwzepfGCzSxh9JfSFFY3jcza2THi/3T83TTwQs+iBY5N07vTcWfwBK/Gh1frFIbvv9P/3AjRLT1VAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9119
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240415_194317_186168_F925F687 
X-CRM114-Status: UNSURE (   9.47  )
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

T24gNC84LzI0IDA0OjA4LCBTYWdpIEdyaW1iZXJnIHdyb3RlOg0KPg0KPg0KPiBPbiAwOC8wNC8y
MDI0IDc6NTMsIHNvbmkuYW5raXRAc2Ftc3VuZy5jb20gd3JvdGU6DQo+PiBGcm9tOiBBbmtpdCBT
b25pIDxzb25pLmFua2l0QHNhbXN1bmcuY29tPg0KPj4NCj4+IFRoZSBibGtfbXFfdGFnX3RvX3Jx
KCkgcmV0dXJucyBOVUxMIGZvciBpbnZhbGlkIHRhZy4NCj4+IEFkZGVkIGNoZWNrIGNvbmRpdGlv
biB0byBwcmV2ZW50IE5VTEwgUG9pbnRlciBkZXJlZmVybmVjZS4NCj4NCj4gRG9lcyB0aGlzIGZp
eCBhbiBhY3R1YWwgYnVnPyBPciBhIHRoZW9yZXRpYyBvbmU/DQoNCmlmIGl0IGRvZXMgZml4IGFj
dHVhbCBidWcgdGhlbiB3aHkgbm90IGFkZCBhIGJsa3Rlc3QgYXMgSSBkb24nDQp0aGluayB3ZSBo
YXZlIHRoaXMgY29uZGl0aW9uIGNvdmVyZWQgYmVjYXVzZSB3ZSBub3cgdHJpZ2dlcmluZw0KZXJy
b3IgcGF0aCwgdW5sZXNzIEknbSBtaXNzaW5nIHNvbWV0aGluZyAuLi4NCg0KLWNrDQoNCg0K

