Return-Path: <SRS0=W3/M=PH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBEEC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 06:24:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F69C60230
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 06:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8F69C60230
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TnDhJZX2Vb/oE6pcvyHT8/xjIOeGfMaW/AlZ5KqmIyg=; b=XIGI3luKlw55vPzkI8YXMZeXNm
	gchbKAZSEKZ9j6dCU9MTIr3RdExN+n39ygYo3ifbASxRCnoEGO5M/iU4TewHArbqq3/hcDhz2kMa3
	H3p8QduvCDOuZazRd71y3Ei31FC9ruXZHf9PejTa39gXfF3LfI2Scjh7/Lf2Ya2GtxizpaHKbi1f1
	iePPpxhdzVpkts5TUtToi0QpxVRdjGbIbx69MxmXUJuwbEx9uDniozbVgQ+QhGCNTEW/2nNDvVWUS
	7ApbSYrtpYNe7OBaPNty9KrlaHmiSnTsxWUmo6xQFT4sdq1Dya/GtC+I6XE4z2MeG8bLnbNXNYCtz
	1hTVU6Zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mciXx-000HTO-Hu; Tue, 19 Oct 2021 06:24:25 +0000
Received: from mail-sn1anam02on2087.outbound.protection.outlook.com
 ([40.107.96.87] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mciXv-000HT4-60
 for linux-nvme@lists.infradead.org; Tue, 19 Oct 2021 06:24:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knUWgTBqZFFDmxHWhBVBzEZ7MZ6k2Wls8nh5T8nbvNxNsQGimhhLTNwaVcny0RnfHvQDR6lxt1J0UlO9gzplr8VcqJ100cWZAANcmBDSHSpbHVT6ins3jl+N5+ZnJWR4sty05nasE4KTg9zSV13J+mMU4lK0DhGBFWChsrKyMPtVd8vsMFnklBQ5jUgXqrUH5q59/FY2CWe5VyrjfJGLp2nLddW0IKKt9y5nsdjaLamgqa0BiH6EklLTPEN2zmCg5cIiq1uihOAz0P17/sh41+4+fTgcBaBd+jnm+yeYVWGygPzvv6ArtxYmyfkGjcCXJf0nyxAynnenfBXlyjyUXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnDhJZX2Vb/oE6pcvyHT8/xjIOeGfMaW/AlZ5KqmIyg=;
 b=CPjf983OcHbd1gjcwVwGZ3IFiJu7Fjwa9TLU0NN7H3CD+yL5x99ftPqLGqyEpSHl5F9wMuyAn5ezI7oNraTa9G3G7wodBTtG2Gc3kqeGEMMIR75sdZPC8zV5ago8YJfGDGnU8hwT3BedpWMOsPF1AFMjpaSG3ghB3OsTg7kR1MN42n9XvdZxWOTUVk3PXcYvd80OMbgDxt96A8gyeH0NFoSJb/AwlarP1gxH68FKmE8oCc2YLEoSMS6gTggpLh6QUIoCB+Z4wE5L+KSCzNoO9CA+pZHFypFA8yBS0raW9CjC4XSsho2Rn2t52Qvm+llks1QpTK4qI03h3H9cIvBTnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnDhJZX2Vb/oE6pcvyHT8/xjIOeGfMaW/AlZ5KqmIyg=;
 b=Evfw8h7+0GcZl/cbOuu44q1Ab9vWeys/3tHV9VFvemT5zRbNWQWL7UPDyDHqVEDVkYXfvD7LyIokaMF90MfbDc52Nk5xPmEUQd5xdNZCdg8JjjFvOTUhAIJZLVfKV0SlUTvBXh8ew1L9IyTOkArdKqFki/z0IG8isfFjhPI3UhFGkSX2hAv1IbsBWOUHnjWG1QcY1gzVTRrRROrDkM8pFEJF8aCfJFpWWZxT0UnWFBkWDOhEaYAe/miWxnu2VT1T160HgWOHERcnnsXBWOp0Pt9/3vFmVYoupQaFhRvWxnOcJfu+oO5XCsOujp5OS+i6ywRf6+J62MqNSrLCQOrOdw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1135.namprd12.prod.outlook.com (2603:10b6:300:e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 06:24:20 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 06:24:20 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
 <sagi@grimberg.me>
CC: Israel Rukshin <israelr@nvidia.com>, Oren Duer <oren@nvidia.com>,
 "jsmart2021@gmail.com" <jsmart2021@gmail.com>
Subject: Re: [PATCH v1 0/7] Centrelize common fabrics code to core drivers
Thread-Topic: [PATCH v1 0/7] Centrelize common fabrics code to core drivers
Thread-Index: AQHXxCW/0t8xzRL9TkO4LJ3WFEH6OKvZ25sA
Date: Tue, 19 Oct 2021 06:24:20 +0000
Message-ID: <4db45754-fd1d-1f55-5f5c-070b03e8333e@nvidia.com>
References: <20211018134020.33838-1-mgurtovoy@nvidia.com>
In-Reply-To: <20211018134020.33838-1-mgurtovoy@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1946926c-144f-4a5a-cff5-08d992c915df
x-ms-traffictypediagnostic: MWHPR12MB1135:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB1135D3CAC147A05271FFC1AAA3BD9@MWHPR12MB1135.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yb5lheCzweO1f75lTkgZcW/yBxFTKpeAnBVog0GE08jwTKmCXCwoRPMhj4/pI1lsdn5tJ4R186GUDDjDi2oyNfGKcNqRnJPFz4xrafZKEF5kVUTqdTu7d4glNM1mnrhACiFv2UWm2kbjlh9G2oQaBGApUK7FZ7zS9ske1tN9ZiLj45sJ3kdJcJveH1gocT/oWYuYPb5OgZZ7KoUc1KEOnKmDUN/+fwdR4gAf0v+B+SZRP/PXHKIEpfBZo0m+2xpBGFL9fJmSVYEp4jdoySPDPCeO2RgNriuA/LkrogrQIgAGd1bIogeurkhFjlpGOhMwkA2hSuw5m8VQ+Y80flI7V1Yx8HB/Brv/JhPtRWGWQauIYvB3WISqdjp67yOdjdDbC8X8xd70EyUFPmXM+evQZgCMRC2pyr85OezIKTad8+MsNktFbgF9DSq3brot/1KL05ExOaf6O7B0gzBR8m67Zy1DW0ATl10/4OmUBP1GVKejWEo9+NBAiWH8tEanpuDkLedEmDuMqzcBjpl4GavUlyGxpjJyWBa52Lb0+y1rzEqt7pPM3DIxW/oI8jh7PZwhCkR3s90P85cURGjDUSB6HMAo3IC18ErC4lZpo1REbVGWhiadR9OLDq3ExmsEhL8ipBEImP0fNy8Cdqgj6wBnG3HqPgnFLH03wVXSTRIZtlRQqd6FSnDLonCr2rCTXmDSGyoDaYMyF9qCUHXIxBK3R6HJQgQ3sby++6YQRUyfJIdK5RhtxHGpkYZBJUJ+qBrl/bVczfkOJHD+63ysxSeDTA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(316002)(66946007)(38070700005)(31686004)(4326008)(2906002)(8676002)(8936002)(4744005)(6512007)(71200400001)(38100700002)(36756003)(122000001)(66556008)(6506007)(508600001)(76116006)(91956017)(186003)(2616005)(86362001)(66446008)(64756008)(66476007)(31696002)(6486002)(110136005)(54906003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UExsSThKSGNvdUtONGNGLzlFZlBBQXZLejJhNzNIdzEyejFGdUI1cWhTeWc1?=
 =?utf-8?B?RTVkV1FqakIzelptKzk1RkRGQ214bmNyckQ4Rm5ZYWd6ZG5wRXpQYUllZklQ?=
 =?utf-8?B?QWo1Wmc4L0s5YmN0aHdVWkdvaTl5L2hkZ0g5S3Qyd1BKODJ5STBFY25Gd3I0?=
 =?utf-8?B?cEM2T1I4UjFmRHlMNTkxM00veXhmZ1lzYlRhQTRsWEs3a0NGSDN3UC9YQUhD?=
 =?utf-8?B?cDlxNXZyNlhGcldVUnAramtTWFphVEdtVGdZSUNib2RoeUhEWDQ2bmhYUmt0?=
 =?utf-8?B?bjNjREZUdHg1UUllbFdiMGdIR2JISlBIaHpMbm1KSHA4WUMzNVRXaUxRUTZn?=
 =?utf-8?B?YmhtN3JnTDdTNU12WmJVQXlIa2RZR1pySk1mcjNYaVc4TENLZUg0ZlpCdSt6?=
 =?utf-8?B?aHF3NmFLcVgrS0traGQyOFZ6UkdKdGVvK0JEakZrQU11RWlMMlptbHFpUWZO?=
 =?utf-8?B?TDdKQ1dnaURlay8rNGEwN0o0RzdZb0hEM1pmTTVIZFN5N2pxRmpCOEtSbkRM?=
 =?utf-8?B?S09nNmZPTEo3NTdWVUNNMXplajA2ZUtmMXBjR05xL2ROcVEzL2FrUjF6NUdF?=
 =?utf-8?B?aFlHR1JVME1uMVUzd25pMm0vdUpOT2VsUWdnQzUyLzZMZDNhSnhSakNiNG83?=
 =?utf-8?B?UllOSHd1NTBkdm1iMWJ4N2o5K1ZsQ0U5ZWc1WGh3cEVVM1I4MTNlZjJsakl1?=
 =?utf-8?B?VjI5MWhLbXVLRkhCaFRVTzRLSHB0a0c0cHkxOG5nekxhVVdxZTU0d1VYemdE?=
 =?utf-8?B?UXB5Ty84RWFadHZZUnBXd3FHd0h0cWxZaHBZdmR2UlZqMkJsL3I4NnVZUDBs?=
 =?utf-8?B?WVp0OG9Zc250Y3RsSU1qTC9MWE9BVTBia3dSeHM4aFNPdEI4ZlJTZHpMeUVm?=
 =?utf-8?B?cjRMTHovQTZJQlE0WStXYzRTUFluUkkxQkhYaVAzNmhnNitCR083czA1Ykdu?=
 =?utf-8?B?ZFlLMjFJR1p4TUFsNWEwYVFZbDgvY1R4VG5jTHhkWXFSUVFsY3ZrYU1ybjNu?=
 =?utf-8?B?TjlBWkN6b3BKdVJKZzhmTkRYRWFUWmZLK29SUDRwMHYzeldIZkdMb1djSGNQ?=
 =?utf-8?B?aWZPNWlsSFNzSXNOYW41Q1NnbHNNRGs1TnplMUZRdVQwSUdjNXBYUEltbE85?=
 =?utf-8?B?bm9ZMXNXclNBV2R0M0F5SFp2Q0tnZEZtY2toMUo0eUxaOUpRUmt3dmFMNmlZ?=
 =?utf-8?B?NllqUWZpOFJQR3gyM09Md3lDVkNxZ05KVng5WkczN05RQzVxa3pibjNWK2Zk?=
 =?utf-8?B?TW9uQlFrWmVTdVMwYnNHV3FsNWt3cUUvTDJNVVpJcDgrbGNpUGhHajlNcTh5?=
 =?utf-8?B?RzlRdHVMZ3RybERhODN3QUdmNVAramh5NlNla3VlNlh0MFo4UGJkeEVQOFQ5?=
 =?utf-8?B?QkdYM3VDWkpQQ215UFB5VkpXcm1KTGtSY1Q5VTJnQWx3aWN3dHNEcXI0emUz?=
 =?utf-8?B?YkdCZzkvOXoxQVJ6czlwWWdNcHRqTGJYbmJ3TGI4STUxVmRRcGh6MFlkOVFR?=
 =?utf-8?B?dXVkdnRqZ0V0aUNadGVGcmtqMzkwK0M5cmU2WDNZK0FGRUxURi9XS3l5SGZh?=
 =?utf-8?B?TmhGRGxyVjJsM2Zwd2NBTm1DMDJLRGNZbGtWWmZzSjUweFpUdCtLY2libUs2?=
 =?utf-8?B?NFZHWGpmLzJOUG1NbVdqRDdYUm9TRkpJbkJlSFp2WXJXUUdXakhPc09ZNHQ0?=
 =?utf-8?B?T0N6b0trS0xMc2F2cnZ3aEFJS1dCcHRoaDZ3a21SVzkxbld2allwUzNVaEhi?=
 =?utf-8?B?Ym1ETnNROTBCZTlaY3lRMWthV2g1TUlMcjAvZWdZZ0F0MCtScWt0QUNJRFNT?=
 =?utf-8?B?aHM5RzN5elpWVmt4U09BOGdyYXJrNldGTlo4dy9JTjJtNUZqYmM5N0pkcnhL?=
 =?utf-8?Q?GEHyx6EpI+uIT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B321E57F4FEBB249B32BC44B5EE4FCF8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1946926c-144f-4a5a-cff5-08d992c915df
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2021 06:24:20.1057 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gdUzvSFYM8byQU1CgPORWwuuh/yNV36kTSoyl6YE6LC9IAv2vs049G7IILRUpMbWHtPN+93H1zb/B+iHd506wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1135
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211018_232423_268611_AFFCDA77 
X-CRM114-Status: UNSURE (   6.84  )
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

DQo+IE5WTWUgUENJIFBlcmYgbnVtYmVycyB1c2luZyBOVklESUEncyBOVk1lIFNOQVAgQmx1ZWZp
ZWxkLTIgZGV2aWNlDQo+IChGaW8gMTYgam9icywgMTI4IGlvZGVwdGgsIGxpYmFpbyk6DQo+IA0K
PiBJTyBzaXplICAgcmFuZCBSRUFEIChiZWZvcmUvYWZ0ZXIpICByYW5kIFdSSVRFIChiZWZvcmUv
YWZ0ZXIpDQo+IC0tLS0tLS0tIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0gIC0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQo+ICAgNTEyQiAgICAgICAgICAyMTg5ay8yMTk3ayAgICAgICAgICAg
ICAgICAyMDMxay8yMDkyaw0KPiAgIDFLQiAgICAgICAgICAgMjE4OGsvMjIwMWsgICAgICAgICAg
ICAgICAgMjAyN2svMjA4OGsNCj4gICAyS0IgICAgICAgICAgIDIxNjZrLzIxODFrICAgICAgICAg
ICAgICAgIDIwMjNrLzIwNzhrDQo+ICAgNEtCICAgICAgICAgICAyMTUzay8yMTY5ayAgICAgICAg
ICAgICAgICAyMDI1ay8yMDc2aw0KPiAgIDhLQiAgICAgICAgICAgMTM4MWsvMTM4MWsgICAgICAg
ICAgICAgICAgMTM3OGsvMTM3NWsNCj4gICAxNktCICAgICAgICAgIDY2OWsvNjc2ayAgICAgICAg
ICAgICAgICAgIDY2MGsvNjY0aw0KPiAgIDMyS0IgICAgICAgICAgMzIway8zMjJrICAgICAgICAg
ICAgICAgICAgMzA1ay8zMDVrDQo+ICAgNjRLQiAgICAgICAgICAxNTdrLzE1N2sgICAgICAgICAg
ICAgICAgICAxNTFrLzE1MWsNCj4gDQoNCkNhbiB5b3UgcGxlYXNlIHNoYXJlIGxhdGVuY3kgbnVt
YmVycyBmb3IgdGhlIHB1cnBvc2Ugb2YgZG9jdW1lbnRhdGlvbg0Kb24gdGhpcyB0aHJlYWQgPw0K
DQoNCg==

