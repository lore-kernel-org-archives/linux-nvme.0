Return-Path: <SRS0=m9zU=P5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC2BC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Nov 2021 06:10:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF2C2610A5
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Nov 2021 06:10:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DF2C2610A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nmrvVntWMERGjxdn9ARlLm0a8Jt5rfmaqfuw6ia0ESs=; b=BIUv8VYk4dhlw8nVkCraCmyO7F
	Yy19WA8g6eceKAmdJtdFaH5k3JfXWMg3tIULBOFQ73nK37Y6AwaHgfEZEVZBHzVu7fPqVNCN++mZu
	mXA2JVGtpQ2lhZ4t+uV2BWOcA4UvUhZI7Kxlg0OIAgjARnreJhKVvoC+J+6WkPt+v6pEb3tQv5iZA
	H7sKp1+klqL6yM8joV1kU5GBPOXfUnSGAZmZIfDRKGOZSr8rMh3DIjIgCBQmo7wP8/lRFLpMCpD3y
	UjrXSKmeX8VigBErCvcxovZtvQ06jI9HwfxQ1QtmoBHXSJlO7jyhceovrXJMbh7HtIlvziVuEJvSq
	5gV+5x4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mkgoY-004YIj-73; Wed, 10 Nov 2021 06:10:30 +0000
Received: from mail-co1nam11on2068.outbound.protection.outlook.com
 ([40.107.220.68] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mkgoV-004YI6-KR
 for linux-nvme@lists.infradead.org; Wed, 10 Nov 2021 06:10:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqpu+puHcFhxkZjtM7a83t6phSquFxqxmAh9gsMOxFfSRbGC1ucyTNIC8TuZoH+A+mOZxJP1i8fRPuyEQXNy207pPd0CBF5Ru8A04u/HmCfHk1kt35589T5PyKUqVKsZb5RGx4RRtWFkMrUqxR2kaPDZB+PoiLKLG80UtrrVOTr7os67bjUlsmJ5jWnN6vCr/Ll0qwVCL6KacVZM0IG4gy9Efe1AdjZJW+zpjrbrcQQYMcVDy22a+h1JGbBbZ/jlYf0ftl2VaBT4fRyobcLDYdDJWyqp3IN5nt3qWFACwdCEyIAHXzjjlS+IEDrFkucrMCtBjJVF61xdoWaz+mkYYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmrvVntWMERGjxdn9ARlLm0a8Jt5rfmaqfuw6ia0ESs=;
 b=XKLJgDg9oOETmEz502VVK+Eclw8h8KMfYaRe+7v3pNXYSmiGGF3LTu7xcAoB7uON91Og1IbRU96r9PPIJ2IjnDUcd3SIp3RMcbhGsFV/piDdFXDWEdWfRmme366TNJe7VrKkgLLefBSpcQPT7bPVWCq29j/7uWC+JlLST4qBTkDbXbdVRnLPftq7G9R+9L/5pSp8L4+awXiWI4oyTBj2n6o/VgPFZMofrJPWmjjckeb9B6+Ifl+rw+fjdM6ckSkis26+hRVhffCoi5rGZzqdEVcTjkM2FhMpa5Qo1EwVlboLVSqtTHpKKNxFwmUOdfPmp3s8ZyeXZQJQxg6Oyh1CHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmrvVntWMERGjxdn9ARlLm0a8Jt5rfmaqfuw6ia0ESs=;
 b=UhjqSJiguICXju6hoJnmYmv1F2UlxQMcq9njP6pF4DdPXOhW8Y2GAetU2fyBGrDCqAoz4e9Po4vdFK9xlv0umhFjSlWev9Cjg+wQkGJsNoEovdZYflIZd+6onkQo4CVjtlKTz201WrmeHCr9nkY9ZJ/YxNSRjVIfInYETHB9XDDJ/3zTDXuDX47Tu0Yr6I9K4hucrkVg1qk2o7h9wHU518ZsgVvw8xiVj4NZzH/Q5jeXH0jhte2OIipEKfUI5z2hi9SIoWrnl8g7beGRm0bFsENuVpy7tNA0OgEBIPyPhEHjWUBmqibrrEKU1M4bTw80PTr8sA0cwftCuRYh2MfzfA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1391.namprd12.prod.outlook.com (2603:10b6:300:10::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16; Wed, 10 Nov
 2021 06:10:18 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798%4]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 06:10:18 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Klaus Jensen <its@irrelevant.dk>
CC: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Jens
 Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Klaus
 Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH] nvme: fix write zeroes pi
Thread-Topic: [PATCH] nvme: fix write zeroes pi
Thread-Index: AQHX0ahdoiiPVPBuf0SAQrCEhrQcWav8T/WA
Date: Wed, 10 Nov 2021 06:10:18 +0000
Message-ID: <db739cda-2dd7-015a-5ad9-d2d6e44131c6@nvidia.com>
References: <20211104181618.864157-1-its@irrelevant.dk>
In-Reply-To: <20211104181618.864157-1-its@irrelevant.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
authentication-results: irrelevant.dk; dkim=none (message not signed)
 header.d=none;irrelevant.dk; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18478f87-acd0-4442-39c3-08d9a410c576
x-ms-traffictypediagnostic: MWHPR12MB1391:
x-microsoft-antispam-prvs: <MWHPR12MB13915E7C39D7C1EB5C6D3C66A3939@MWHPR12MB1391.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: StonPQjMdxM8obYEnlN3fi2YH1Za+h/3s931aG+ZAtzR+bqt3202c0hWuBVohO1SKF46I40Twq2nUedcV0BGaD8Fx31/3X8reKxRv2bjnsWW/Zu0+z58bgvFUz9EnO0JnWNl2XKx4t8tCZzusJ3vD9SUt5MsgV7i9OoeWLgDbSTqu7eEQoE3WMXLcCPIalKYOV6Da9e4Oc99arA9UxNj+vlnPt+8KhpXbEtCVTcCUSRcNu5BKjOLlHELeKb3+ui3Sze9jpoSKYBw8gX8fDTYZMU++ere7xNB8hUT9pOdUk0+VFP2RfUFyP6CGsfzQKwCj5ePH2fhsekFYmh00O+aOJrVs6/ORHyqGeQQ9einLvGwfR9MC/n1Rf7LeK5DaIml/xf7JTB0J4isodHsdKQXGveCV2hlHctgxJmBs2mDXJrZEuzbO7pOpgFnjuRwTbwFhryOaru9QNHJ8zjpaaK63WrMsaP64W2li1gAxyoKEeQkc2u2JWdljokECwMiCKX/BOVjE5lW7Y5lnp55jXpyIn1WsOdxbVToRvKMiV2oOlxuTO1NMUWvTjy8EPXgXGGp7IS8gJmnsUFPNkQlp6vOZbgfT1TLVSUy4BVR0psIZ6uX0F7b5urcQvIqwZldynfxxqBqgxsxIcKSc8P8t4ZBvClgia7ZKNRoBaeifoQ/GtGBk43jdD69c/mysFrPkBH+uflqpMmWLNLdoNuMfo7S/FRJ3KgMHO5Zav5LicgO8lNQ0PAyF7SJCeywp9ze3J0ohseBevJyVTEW9BpIqzf6Hw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4744005)(6916009)(8936002)(66446008)(71200400001)(64756008)(6486002)(66476007)(66556008)(508600001)(66946007)(38070700005)(36756003)(54906003)(86362001)(5660300002)(316002)(8676002)(122000001)(76116006)(38100700002)(31696002)(6512007)(6506007)(31686004)(83380400001)(2906002)(186003)(2616005)(4326008)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTl3RVdTNTAyVkpJQU5abmN4RjU5ZmFMd2hZcWRHeVBGbExVWW85TFRLQUQ2?=
 =?utf-8?B?WTZDVzNndnY0bThaT2pyZ1pTQVZwWDBOcVNleEJVWmZTa0ttc0svMHN4bVlG?=
 =?utf-8?B?RFBQYjU0dFRNSkM4RzROVk50aTFiMWtaZS9iaVdZN25qaU9FWmMxOGw0aHlZ?=
 =?utf-8?B?RGlPR29sTzY1eDhSWUtHVXVaM2cvVDJpMngyRVI4ZFJxNXhkM2JnSEpscHhn?=
 =?utf-8?B?dEpYajVpMkZESEQyekNIMU1FbGxOMm42TXFHTTVFTU03cWtnZlhXRHBuc2Nh?=
 =?utf-8?B?d2VoUFFDajlnR2k2b2hOdHBsN2tKbnVaMk9hdDhGUElxUUQwTlZRblpBNi9G?=
 =?utf-8?B?R3duazhOanc0MHZSTmJxZUExWlJYUGRydThMeFVMNm9IVHBDaU1NeVZacmY1?=
 =?utf-8?B?Qkdoa05EL2lScklFZmFyY21FZmh4ZDZlQ29GVk5mUjRrZ04yU3V0Yk5rb0Zj?=
 =?utf-8?B?LzRjTGhsYUVuQmtkWk4xTi9qREpiNm1wT25SWUNBVGhUaHczK3BkbFBhbzFZ?=
 =?utf-8?B?UHUwOVY4YXVoOWRKTUJSY2NETFRUb243MSt2TmxpM3AxU2EydXVKY0o2MzdW?=
 =?utf-8?B?L2Z4ZllubDJiZlhSdSs5TXhwVDF6NFRGd2g1YjkxR3AyMHpReWFDNlRhTStk?=
 =?utf-8?B?cGlobXZsVFpWUEhWejMxaWJlT1ZQRVRMN1pzeWRZdHJQZ0d4TzQ1QWtmNFlP?=
 =?utf-8?B?SWNQM2d6RnBOMGU0b1Q4SXdFLys0Ni8zdFZWRWllQVVVOGxxQjZQYllkMlRC?=
 =?utf-8?B?ZkJkWGZKUUZXTmo3TmxPZVZWQjZoenR1YkZxcm9RNXYvdXlEV29oYkFqZXg1?=
 =?utf-8?B?dVhtcWYzd09xVWZ3OG95ZFZiamVRY0pvMXl3MVVpaXV0Z3FXeTNuZkhoRi8v?=
 =?utf-8?B?VUhDS25nb1M1YnIrS0RpK0JoanJUaTRZNmFkVlZLdkhqMGovcU9CS0R1Mit4?=
 =?utf-8?B?cEZ2OVkwMktlZjhaRTZJWFFRMHhOWTFKaFdoRFh5MXN3RlJTUlMrRmREUTk1?=
 =?utf-8?B?alhhbWF4TlBFcjhKYjBlUE9COWYxalhlNjY4QkVuK0tIcVo5RnFHM0JwUmFp?=
 =?utf-8?B?M3FWVCtYZkhzZXZUcmVIbkdid2taWkxTcmlGVHlBQlFsdGdLYk5VMFBtd3JQ?=
 =?utf-8?B?WEZnVnpETzhZZ2c1QU9JWWhxVFNuRmgvTGI1WTQ2NWpXT1hXc1QzWFRYdlhr?=
 =?utf-8?B?WUN0UGRCVXV2M1h4bkFKUmtsVS9wWHJEbEp6N2tFZEVJU0Y1U0l5bjdQaDd6?=
 =?utf-8?B?VlIwa2xnZ1k2b0tGVEZ5b3ljcGdqNXFpNUdzUzhXYUgwZVpBRkF3MzhmMERI?=
 =?utf-8?B?NGF0VXNGS3ZneEZ0UmZ0SUJZMVc2UWxkZzBPVHpQZXBPVFZ2TmQxZ1c0Y0lu?=
 =?utf-8?B?SnpEYjRkSXZwa3NyOWNlM01UOXR0RWZlQ0tia1JuMGVsTXNSQThvMWtud1dy?=
 =?utf-8?B?R3BwMEI2K09EWWZ5Zy9GcUpQNVlnaE8rZzZld0JOUUlrRUZIVm56OHRoYy9a?=
 =?utf-8?B?bjZHTStRbnFuZEVkRm5xa2tBdldXS3RzbVVxV0kvQWY1M3NRSGtJVGo3U0dS?=
 =?utf-8?B?WWE0Kzl0UmV6SjNuU1NlMW5iekluS0NjeW9tQVo0Y24rK2tzVFpmT2hLTXhm?=
 =?utf-8?B?T2hUc3NTejJpVGYvRXFUS1UwRjJOSjlvdXFqL1RFQ1loQnZVdVRXTWFmbVdH?=
 =?utf-8?B?UzB4VHoyRWd6eDIzSCtmRDhmRGg1azdETTM0bEEzeXR1NS8zcDNNQmp6ajFH?=
 =?utf-8?B?NDBhRERBL1pKblhkN2c2N0t5Q3dIQXpwdmRodzJNZ0pGT0FIcWY2VVlTdFNJ?=
 =?utf-8?B?L3RXYktqbWlGWkM3NUF5VUYxa0pURTJtdUc4NVhvdDdkN2NCYnBCWTY1bUtN?=
 =?utf-8?B?T0lObHlJbTFzY2d1VkRuNCt3blVVQzZONFhlZ2NNNC9oL0xidXRlWVBMVXl5?=
 =?utf-8?B?MlFuY04wbVhlbTVMc0JtUGNhNXlwRmJjK2NJUXVWZ3RvRzdscEg0d3pIcXdy?=
 =?utf-8?B?a1pFOTRpWVFiVEczYmlTZlR3QmN1VHVld0l1TTQyRmd0Sk5RVVN6czNmclJv?=
 =?utf-8?B?bjNFdkZBb1BGN0NnN0NsWVorV2REdTRJeCs0Z3RXS0hiZ01NS1N3ODhaTkgr?=
 =?utf-8?B?enNHcWllSit3YjZpcjZwcGpGRzYxZWlDcTY0V1dEMkZVQnY0cm9VNFhzSXJ1?=
 =?utf-8?B?UE9BWGpjNzM4b1U0VzRTK2JzcWF0N0JvWmZ1VWYwUzZLM1I0WVp3bFpTMysx?=
 =?utf-8?Q?S3nwTez6uApjIifSfstOlNWNZh0xp0hkI+Thcasvto=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1814B869D851464AAF865AD206250311@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18478f87-acd0-4442-39c3-08d9a410c576
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2021 06:10:18.7488 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o3mzohgf0vYc83bFES+fvRZOq6U0WjqFQaJQ7tcNdJi8VESgQrtgTtqmS6UW5EopZb7siuMPkeIe7W3eQFld/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1391
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211109_221027_702647_151EC246 
X-CRM114-Status: GOOD (  12.07  )
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

S2xhdXMsDQoNCk9uIDExLzQvMjAyMSAxMToxNiBBTSwgS2xhdXMgSmVuc2VuIHdyb3RlOg0KPiBG
cm9tOiBLbGF1cyBKZW5zZW4gPGsuamVuc2VuQHNhbXN1bmcuY29tPg0KPiANCj4gV3JpdGUgWmVy
b2VzIHNldHMgUFJBQ1Qgd2hlbiBibG9jayBpbnRlZ3JpdHkgaXMgZW5hYmxlZCAoYXMgaXQgc2hv
dWxkKSwNCj4gYnV0IG5lZ2xlY3RzIHRvIGFsc28gc2V0IHRoZSByZWZ0YWcgd2hpY2ggaXMgZXhw
ZWN0ZWQgYnkgcmVhZHMuIFRoaXMNCj4gY2F1c2VzIHByb3RlY3Rpb24gZXJyb3JzIG9uIHJlYWRz
Lg0KPiANCj4gRml4IHRoaXMgYnkgc2V0dGluZyB0aGUgcmVmdGFnIGZvciB0eXBlIDEgYW5kIDIg
KGZvciB0eXBlIDMsIHJlYWRzIHdpbGwNCj4gbm90IGNoZWNrIHRoZSByZWZ0YWcpLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogS2xhdXMgSmVuc2VuIDxrLmplbnNlbkBzYW1zdW5nLmNvbT4NCg0KUGF0
Y2ggbG9va3MgZ29vZCB0byBtZSBidXQgZGlkIHlvdSBnZXQgYSBjaGFuY2UgdG8gdGVzdCBvbg0K
bXVsdGlwbGUgbm9uLVFFTVUgY29udHJvbGxlcnMgPw0KDQoNCg==

