Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6977EC4828D
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Feb 2024 22:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8O4Fa0wdX3NsG9Nc96TgGPnCzDdS3g41RCeXIfu9/vA=; b=DtAuwHUkkUb6HB3Fe0kLWpLDvU
	Pz/x8RGUzHqaon7AdmWEQKjZabZIBv1refL/+l5HHK0kdAtODhPSS+g5xQ0BcJjhGX+cRZL17ikmC
	wxc0XQ+9FvN/9PmvIQJLYp7pecTEvxyqOIaY0xWVYm1RGBW8lCvoFuR9onpj67J09gnnrHNutKYPS
	M29dB84pZzeBlUGlFFRUwGWEj1glaH0OehFM3C8+pHtwJkwWJiFMgDTSKpj+mOzLEBE5rF2QpnWsj
	rzPoJ+7VfkwN0fJHJZbMG8Ye/AzXpOPhGKQErV8FrU8W1xldRK+EFMeC+EFZFbGN4LuZ8856L5g7P
	v6MjORVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXUJ6-000000097cE-1Sfz;
	Tue, 06 Feb 2024 22:52:48 +0000
Received: from mail-dm6nam11on2060c.outbound.protection.outlook.com ([2a01:111:f400:7eaa::60c] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXUJ3-000000097av-1o7J
	for linux-nvme@lists.infradead.org;
	Tue, 06 Feb 2024 22:52:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZF5u2KKBDgf3gmuJoGZVJKwtTVGY+W4hHmsZabEHfd7sgGvsYr3ZBd1b6PDvt4qDObkJHO4nT5TQp99+2j5gp6T6jzMltcomDgK22580t1RXVTjm/Iw2SkohSm0oxQhgt2ett4kr59l8cAOMOaHirf/bfB/lKGR21ReyiE+5tWZ8DIPvBGchk9dOMSn+PNI6BBGEvpzcpXRA5WAzL+Cp3F6v3o6437TU04tYV9LyS677bWJfMNWvoJcQAlS3r4rwj/43p9Djt2ETisg95tnvLW8+8E7kCOSZ3mnaIvuECUn97b2Az+F2cbapiiHDMzJgrgCdIy0gaWinsTyQHawvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8O4Fa0wdX3NsG9Nc96TgGPnCzDdS3g41RCeXIfu9/vA=;
 b=HPpTl9mt4RcXbqq7Kno9bkm63rOVVCSTtevFdrgCnG9YpwLAWle5gryhOmvQRqZ/GrTUqcj9aXZwjF6bukquiv3qH1YLGGAnp0zbGEGeaQS0WzVPJ3zgjsK5/qqU6WU36UNOErOSv85hpqWPZdyvvrZ4Q8vfvEBPchf+n3t4HVpI2LXbT1eCBXtDYQmEzSanL0GSRFI6RTOQbcnuSa/O4hibPViNW5IK67oao1XorfmqH4q2sn3DRgNya83n6q3JxVX8ApY5tTx71sFocejFew8MLP9fhSjfnIam1gJ2xi+Aq2sTnBA0CVlgszQ/Pb8bOCDdcUzdqomsN4JIDmNElw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8O4Fa0wdX3NsG9Nc96TgGPnCzDdS3g41RCeXIfu9/vA=;
 b=I3xiNX6+3VYips2JT5cRYnD7d9SzP3AKpMmvD8NHksJFDQLpcacCPrB9Yyu7xpEY+XMJw3HI+nWk8D18qLhRhe9dWTGgCKrTbjWBC+7edo7tkFA1r4pQsPleBDC/TDKo0wqv9vdodmbAEB0wgeU+ylNUkbWWUPDgyoq/7QazgdqAjb3vQ/Xpz69v8ykEuxlb5XknWI7sb917Dv74AvsRDfq24wusx6sWKg+5C9eXBGEnQq+qBPmJGtEFjielLzlpqEDDjR56ZNpM9BgBRv90OGhi1+EmPq3tNk0LPj5OEQJICivKDlv0NgqKrVsj7RhLhuA1u9NeBOtlT2PxAN9nFQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW4PR12MB5642.namprd12.prod.outlook.com (2603:10b6:303:187::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Tue, 6 Feb
 2024 22:52:33 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7270.012; Tue, 6 Feb 2024
 22:52:33 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>
CC: Keith Busch <kbusch@meta.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"hch@lst.de" <hch@lst.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: implement support for nvme relaxed effects
Thread-Topic: [PATCH] nvme: implement support for nvme relaxed effects
Thread-Index: AQHaWGgxalKD9zrmkE+IrxCCZGGDXrD888wAgAAKBwCAAH4aAIAAcZmA
Date: Tue, 6 Feb 2024 22:52:33 +0000
Message-ID: <cb72d1ba-6ec1-40d3-a46d-987b0fcd7221@nvidia.com>
References: <20240205191703.2990948-1-kbusch@meta.com>
 <3c8443fd-fd61-48ef-b4a3-0e6545990140@nvidia.com>
 <4efa4fd8-b351-4948-a6c0-c5969c973bdb@nvidia.com>
 <ZcJY5nSY4Zh690do@kbusch-mbp.mynextlight.net>
In-Reply-To: <ZcJY5nSY4Zh690do@kbusch-mbp.mynextlight.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW4PR12MB5642:EE_
x-ms-office365-filtering-correlation-id: eafd1e87-fe72-406f-dafe-08dc27664e99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UGjmHowinBDYHcPzZrfi6EmMyL4perd4oL1YVRhx7xxJFUJabHlzq0twURwcG9FJzgWA7KeJ+nNS4E/0+xBez8geNI38SxBItvhSHqL/OGxxDB8A88s5c4dpI8bI3VUVKC8A14/Oypxj0xVrJrZVxfTuW4S2nobjhDMeyX24eB7jfGIWkZd6vG8zm4COLnBvLProRjqXG1nUQzb/wISclADzhDwlBch1FS0ew3dE+2BuKmpePvhXn3g/9FUryKTQCYa90Eo99j3j/C4pLfj+ylBTKACgsMyBVILeqgoacnFEueL6+ij2hAUoTVcnZTFKDOoUzyGAYbFHqiRHLqUCg9q6MxpNJT/yJtzTfWE+uape15JlDXpO15ke6PiFguS8ce63BiMhD9NkAl+UpozQu+l3PRCgL+eVZpr0raQZ5VLaRsSX59S5spqKHKbERPZzDtxyoaluYk22rcY+GuH45LpIMiT9+u8iwelq5G3HxrVZsrZZ/9QXIO2bS8dNdb+8wpnmy0NCL/qDU/+yxY9iyZkADgzD1OXDj6qumFmcVj8LDHYeVfVPUoHaWdk1O0K0fQvWWIQ5jFEMAl4LOYmwTKr7j97Ox82n9AbaqV77Qq03OfSzH8TYJUPV6ew+5XlYyGc9ntJuWZsqABYjqVxms2MrxtWbgNxXptWenOXJHh7K7hHhb2xcPI8TtlXXnWnD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(136003)(396003)(376002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(316002)(83380400001)(66946007)(122000001)(5660300002)(91956017)(4326008)(38100700002)(2616005)(6916009)(478600001)(8676002)(66476007)(6486002)(64756008)(8936002)(76116006)(54906003)(66556008)(66446008)(71200400001)(6506007)(6512007)(2906002)(41300700001)(38070700009)(36756003)(31686004)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzdMeDRFVGhWWUVwYWlhcEo5eXZaVnExQnloU3doejFYS2hSYlFsYlkxejNw?=
 =?utf-8?B?bmR0c0FGRlZwRDRYdWN2UGM4S0NjaU1sOVNkbEV3RkNaQXMrVmhnWi9uR3Bk?=
 =?utf-8?B?aW9rNnFPczFBSCs3WWZVeGhTd1duL0tLdlNQbVJCVHh0RlRzVlNpWVVvNG9U?=
 =?utf-8?B?NHIyRERMQndXY0JhYnFCVDUvVExGQ0xUQzhBWittaWgzRW01TzZQUXl6SXJL?=
 =?utf-8?B?R1d1MDlJOE53RGtKOE8rUUV6ZGdOT3ltaTdrZitrMzM5eGx6RkJXMkFkUEZp?=
 =?utf-8?B?Qkh1WFgyampPL085Zmxnb0g1STlHZkZ3Q1F1U0tSZy9aeFJvaUIydkM3bWE5?=
 =?utf-8?B?MC92bkxmYUFtQ0ZsTXhXUzl4ck4vaEgzdjJlVml1Z3o2K0Yzd2hRdTJLWEJ6?=
 =?utf-8?B?bDdJU1I0UVRVM1FiY1IxVHhNTHFhc09XcGhWckJ0Y1hBaHFQR1pGVXYzVDVI?=
 =?utf-8?B?d0dudCtxWEE2bXZjbElFNk5lNTFGcXNlWVoxOUJFaWFRM2g4NDNKeGxKOUxk?=
 =?utf-8?B?ZnRndW44TzRlTkJ2eWhvUWJud3NOUUdrcVVKQVE2WlAyS1RNYmcwOW1RUVh6?=
 =?utf-8?B?enhlODRXM1hlSU9PY1RGeWNNMFltZ0d5VncwaUNWRHE2M2s2bmRIQ2w2Z0tN?=
 =?utf-8?B?RXpNUmRVZk9yemkwR2tsbDR6ck5JQzN0VTdXTDZ0T2thSnNEQUNpcytkMzJz?=
 =?utf-8?B?WWpzR2wwZDJZNkpSK3VPTmdUN3VlVGFkMmhYUUtvNlF3a3hzTDFwejB0Y01i?=
 =?utf-8?B?UDRPWDBEa3d2L0pPaC82cmZzWDVFVEJHZXZtSjZTdFNqdlZHb09SOHRYdUEv?=
 =?utf-8?B?dGtVZXhaQUFRUzZpM1lYc21HYWpZVGtvV2JNM0dKTnYxTU41Y0ZHSExlMmxT?=
 =?utf-8?B?bU9HbjNQYzhaRXF2d1dWT0RuaWJ0THhqNmFwZngweENxVkc1Nmd1UC9WZFEw?=
 =?utf-8?B?WGxlMEw0MjBWbHNSNEFIdkMxQ2pFOHoxdlBYZnA3RWFEcTNCakNlTWJTRzJR?=
 =?utf-8?B?QjBraCtxaTZ4ZFg1bkg5RFg1ZGh2aE02YmdVNk1ZekVHVW1rNkpob2RoeTlz?=
 =?utf-8?B?VEhJeG1jcFU1UTdyZE9hc3Z1VEYxU2w0WFJveEoyNFRXN1h4WGJPUGludnVW?=
 =?utf-8?B?WFFubTJrYWhnSVE5TDlxa1ZLR1hTcVQ5MDlVVmZQMXNYZ0wzQ3FOTDlGaHZC?=
 =?utf-8?B?bTl5eFFYK0pTeUNyK25xNnNhVWdMTEx4OHhlMnJBSEY3NlNoMEtYSXNQbGk0?=
 =?utf-8?B?M0NoNCtpeGJLdWNNMGdYTU1sa1plMW1MOHVVU3FFNnhJS1ZmcktYUEVMNEF5?=
 =?utf-8?B?TGpMVlEwc2ZxWG42dlVNaW85Q1QvN2F6ZjhQb3hUR1pvUjQ3WG5GRGYxUm1N?=
 =?utf-8?B?dnY5dUVmZE03UTlMREFRVi9VRmtZS2I3SDBVSm9nd3pIbzJTSUxyS283c3pX?=
 =?utf-8?B?bUFVNjliMzYzL0Rnd2FwaGZiKy91cE5vK0JIR3AwZG1BNGJiRlNxVkRhdzVI?=
 =?utf-8?B?dlNaVDFIZ29jZU5VRFo5eWo3OGwvNUo3S1JXMFd3eVVGVG1mZU15OXlHclhv?=
 =?utf-8?B?SzlMc0Y1Y0l6Y2FFSStHUllRUStZTTJ5cmtWM2xoM0dlOUJxN1FyV2EySzVZ?=
 =?utf-8?B?QjVnWmw2bHE2SUJySlBIY041RldtUUtjNkxCUk5ZTkpzVkN6QjlMQnU1K2pH?=
 =?utf-8?B?UmQ3Uitub0puWVF3bXRla1NpSGZ2aHVvVDdqSmxyRUJsTjV5ZitVcXcvZUV2?=
 =?utf-8?B?ekZqWUdlVnloaEsxY2kxakhwbjRIdy9rYmNXTC9oTnZoZU1JV0E3ZXlxY1VL?=
 =?utf-8?B?YUF1a0NMUXdZOFNtWE1mbUFEUnVDbWpudk9HcTFsZHRiRWppSmpQRXBVQ2pz?=
 =?utf-8?B?YWtlUGhNQmQreWdMVEE1WXV5UStwa0grTmx0ZUE2eUo3S3BWUmVncHZnbmRE?=
 =?utf-8?B?M0VFWEdNN2tJdWxUSVBsWTJselVsS0JTeTkzNFhHVVd6R0VzZ3ZiRXh2UHZs?=
 =?utf-8?B?STBrdWFJM09ZNXIzNkdWTWtNSjhKZE1XbUJMTGNSK29tN2NMLzdGUWNnQ1BQ?=
 =?utf-8?B?OTlFSGJFU2l4RGFyNHFRc2xNK0haanY5VW0yTElsOWJZWFh5N0EzZmdDK0dw?=
 =?utf-8?B?c2lVajl6TU5PRGFFLzZya0x1RCszTG1IdTVUblcyenZpSlQvRnRkNzF3VFI4?=
 =?utf-8?Q?HTR1qaMfq/lTz3bdI9wD7J+eJbk9odHeTuAQgLBCk7JY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2EE5D9B5A882474F847B21B1909E2544@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eafd1e87-fe72-406f-dafe-08dc27664e99
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2024 22:52:33.8175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eVh2OXtxeroEmS6XRs6N0ZOjcxL0tNWsOOUUPBtG51jcxLIeq7m7+5Nn8a9JAnS/AMe09SzA7HdOOxXF5jHO/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5642
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240206_145245_507634_CAC2D416 
X-CRM114-Status: GOOD (  16.81  )
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

DQo+PiBUaGUgY29tbWFuZCBhc3NvY2lhdGVkIHdpdGggdGhpcyBzdHJ1Y3R1cmUgc2hvdWxkIG9u
bHkgYmUgc3VibWl0dGVkDQo+PiB3aGVuIHRoZXJlIGlzIG5vIG91dHN0YW5kaW5nIEFkbWluIGNv
bW1hbmQgdGhhdCBhZmZlY3RzIGFueSBuYW1lc3BhY2UNCj4+IGFuZCBubyBBZG1pbiBjb21tYW5k
IHNob3VsZCBiZSBzdWJtaXR0ZWQgdGhhdCBhZmZlY3RzIGFueSBuYW1lc3BhY2UNCj4+IHVudGls
IHRoaXMgY29tbWFuZCBpcyBjb21wbGV0ZS4NCj4+DQo+PiBJT1csIGRvbid0IHdlIG5lZWQgdG8g
ZnJlZXplIHRoZSBhZG1pbiBxdWV1ZSB3aGVuIGNvbnRyb2xsZXIgc2V0cyB0aGUgQ1NFUg0KPj4g
dmFsdWUgdG8gMDFiIHVudGlsIGNvbW1hbmQgaXMgY29tcGxldGVkID8gb3IgaXQgaXMgbm90IGRv
bmUvbmVlZGVkIGZvcg0KPj4gYSBzcGVjaWZpYyByZWFzb24gPw0KPiANCj4gVGhlIHVzZXIgaXMg
dHJ5aW5nIHRvIHN1Ym1pdCBhbiBhZG1pbiBjb21tYW5kLCB3aGljaCB3b3VsZG4ndCBiZQ0KPiBw
b3NzaWJsZSBpZiB3ZSBmcmVlemUgdGhlIGFkbWluIHF1ZXVlLiBXZSdkIG5lZWQgYW5vdGhlciBt
ZWNoYW5pc20gdG8NCj4gYWxsb3cganVzdCB0aGUgdXNlcidzIGNvbW1hbmQsIHRoZW4gYSB3YXkg
dG8gZGVmZWF0IGl0IGlmIHRoYXQgY29tbWFuZA0KPiB0aW1lcyBvdXQgKHdlIHNlbmQgYWRtaW4g
Y29tbWFuZHMgYXMgcGFydCBvZiBhIHJlc2V0IHNlcXVlbmNlKS4NCj4gDQo+IEFsbCB0aGF0IGFk
ZHMgY29tcGxpY2F0aW9ucyB0byB0aGUgZHJpdmVyLCBhbmQgc2luY2UgdGhlcmUgaGFzbid0IGJl
ZW4NCj4gYW55IGNvbW11bmljYXRlZCBuZWVkIHRvIGhhdmUgdGhlIGRyaXZlciBlbmZvcmNlIHRo
aXMgcG9saWN5LCB3ZSBqdXN0DQo+IGxlYXZlIGl0IHVwIHRvIHVzZXIgc3BhY2UgdG8ga25vdyB3
aGF0IHRoZXkncmUgZG9pbmcuDQoNCkkgZGlkIHdyaXRlIGEgcGF0Y2ggdG8gc2VlIGlmIHdlIGNh
biBkbyBpdCB3aXRob3V0IGFkZGluZyBidW5jaCBvZiBjb2RlLA0KYnV0IG5vLCBpdCBkb2Vzbid0
IHJlYWxseSBicmluZyB0aGF0IG11Y2ggb2YgYSBiZW5lZml0IHZzIGNvbXBsaWNhdGluZw0KZXhp
dGluZyBjb2RlIGFzIG1lbnRpb25lZCBhYm92ZS4NCg0KSSB0aGluayB0aGlzIHBhdGNoIGlzIG9r
YXkgdGhlbi4NCg0KLWNrDQoNCg0K

