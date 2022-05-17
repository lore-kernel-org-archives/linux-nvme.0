Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFA2C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 17 May 2022 22:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HPo1ee+HX72prtdJg5CVeXUAidLc3WUiy4qhokn9aLk=; b=rwNLDe+cY6zoa7+I+XJZqau3E8
	Iv+/LwA6pGoCaB3O1WMcFX7XGC75EsNRqDzZIEPQmnPcNpLLHKo4otWXIAijvbAb3k60EBPxny5nt
	s61UHjOQi5p8G/KWfbJg/0NmAYdU0f5MQKo5LdpYx1g1bCZTptbepesmZ66ysqOrBkAXY6i9zLF9E
	SbzCtGnm0K/9oOvaYZAaX/7mGZocjhdg0ao73rp5ncKj8GzKX3+Ta4szxJp5i01d5TfNpsnBS0zP5
	FYMeyDrmFsDAHAGpZv8Qb0YiJYClvOb41LSYUj67GRbV6hYeWOJeevyS1vscqJZCXK7HOwbfblxem
	UTa5VnTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nr60O-00G9tZ-P5; Tue, 17 May 2022 22:49:28 +0000
Received: from mail-bn7nam10on20616.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::616]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nr60M-00G9tA-CO
 for linux-nvme@lists.infradead.org; Tue, 17 May 2022 22:49:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWJ9R64oIV0/VDxhxjjMY6FOoWHazBePNOoaUivCoNGzg4GqvTanw0gqKR3Ujd9vxzKjgjmZRCirRX6aWYx1z/EmSNZ4mqcfsaNpua+dHrxc9WnOIriK78KHUQVmwHrLssiMA3GwQ5NXcfE0vVIA6A4d9Fndtawi7JIs4A6MD1Az6QELu/F2s3co5j+/Q48DcIKE68t9d36VCmG58oCwPy6Wmkq3Fkw2P0Uc4nW0LI8jRFYP34JHBPJo/jGxTG8FfwBz/wdXjmTGFhgXesWPwdxcAEAiK2durXqz9l9R6NdS6wtkUigKrqYpUh5qxkWC7vmng+jE6RgNbmCxBeKoLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPo1ee+HX72prtdJg5CVeXUAidLc3WUiy4qhokn9aLk=;
 b=HJKcm3TEoZ8I7I6QmbUVTDwa33hiOpYEPigMVF6ri127MWmcg1uqiyDls0LZUBRCPkQMXncfR4ze0MjMmXg8H0CdAkTDDOIfuqCKvlsEKF5mw6Fns7UJMTKlb8JsaIAo5zM/MGdAnRLqYMAAD30F8uV4HvJaSIk7U5IIER8MWOGwibqkqWZSnC2aG7wAaQywy1P9TFZIeVDidViRWtkVP6B2qZBJzn/mZq3shyDOc68xKkN2OJ4+4X4TZ8vPy2ZKEdGe7SopiDngZTh7yIBHIHQbqKK12tkM1/eLUWdxlSpcls6F9g3ur4Xx1Rlz0DpVH4iNusyIVDxjBYHKkFDcuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPo1ee+HX72prtdJg5CVeXUAidLc3WUiy4qhokn9aLk=;
 b=kQu116+IyoWSJtv+E3Jp2oT6wIF+XE9bMV2kxHH12QdaTqbam0og8QOAWZ3uR9Z2Ab0k9DC0wP+g+2oS2wJ7VAsnqgkt/eEpCtP7IQDThjVfv9VZJ2jvLOq5WY8gUYdhxeYhsGGwj/ZReYNGIyAWvcEpuj+X2NcwAw/Wr9WBAJZZVc5m2jdMbUum28Z2Q4GsP2JQaibOcGBHkvAv3uwYXVXqpOqXk1EfKau0BHySOcTZeDMlT+oMoYkkMhL3ygx2TK9tsFVWQ5wH3OF543OJZVANq8xAV3xn8VdAXxVuRpal17F5J6atOVtNESTUE2fLL//YokEtvmSjDTGRzuBvVg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR1201MB0240.namprd12.prod.outlook.com (2603:10b6:301:58::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 17 May
 2022 22:49:21 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4925:327b:5c15:b393]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4925:327b:5c15:b393%3]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 22:49:21 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>
CC: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>,
 "james.smart@broadcom.com" <james.smart@broadcom.com>
Subject: Re: [PATCH] nvme: set non-mdts limits at I/O queue creation
Thread-Topic: [PATCH] nvme: set non-mdts limits at I/O queue creation
Thread-Index: AQHYabJt97Qh9I0ok0uE3+uQMdd9La0i1UWAgADV8wCAAADMgIAAAUmA
Date: Tue, 17 May 2022 22:49:21 +0000
Message-ID: <04b837d9-fbd1-ed80-9225-e452a95a1594@nvidia.com>
References: <20220517055312.50331-1-kch@nvidia.com>
 <dd46fded-d213-6956-8f0a-69a70e0107d5@grimberg.me>
 <955bc8aa-dc88-68a9-c656-51e52fe589f6@nvidia.com>
 <YoQlXXvNCQIRT3yc@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <YoQlXXvNCQIRT3yc@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8348064-c276-476a-2a8e-08da38577be4
x-ms-traffictypediagnostic: MWHPR1201MB0240:EE_
x-microsoft-antispam-prvs: <MWHPR1201MB024005E5AA4D4E924C804AFFA3CE9@MWHPR1201MB0240.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tH8UvyDhH2JkUfm8hBgII6Eyk5EMzN5YGK0XKK39k+W8K12o2fDJhyjzkJjCBvHkBbB4ej8aUExn+hzdce8nHiB6sZxRLd8Bgpac97akq/czjYSPK4MfLdnvWdBS8SY0xns/7Ao0XKrn5A5I3LiB4NiNbO4MVxsqCoyJZzv0e3RyYcvlih4eJUeSrQwAaJ2oKIiBKjBbwWoIUK+b40BWZncHWbkzdXxM6RyhJ0omVYWDlSL8bV02+OYAmYSYUddJP0ceckeNtNRL0xZ02qJF/MalTETYDdO+PWLMYN9rEK2KFy5nssVOmLN7BYYgZvoqvafH4JK5uYjjgJ0YdbKS2cLoTrgLOFgXix2N4V5UUiI73G0jjDZp7Jo3PS1cIBjl6Pb6iMYUv8W8abi4JcJDqOiFYDYjb6szMMhSMhXoJApYNDSxycARGs2wqw8xlAO3+WnmtG0/KiHaXSTkPo9SFw+6AU4ZDPmduM1JOwpfGTDuy5RNWpHi30VVwzVliNZxuO6VwNNMheINNEyc7LrKusLCIm71+ERfawC8by5EyKj49UQPXF0UjciyE7V25YaY9sSXISRG31FUwNJlpaarLkIsJXftA6oiCp21bISbZPita1VP1QJxCf8l3CQdve80QnBPetWQNS/EOre3PPSXVDfBWi30JywWsMeYansJr1J/kst7sD8NUMc1F+XK3F6ZtNq3VfsCoJHY63PpApt4+9O8DskiG9VVnvJEan0KJbCExJZtlFsfyQzyxHbr2LqO3v0HXqz3zuCanIRGjsNabg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(83380400001)(122000001)(4744005)(8936002)(31686004)(186003)(8676002)(6506007)(53546011)(316002)(5660300002)(31696002)(36756003)(71200400001)(86362001)(2616005)(54906003)(6916009)(2906002)(66946007)(508600001)(6486002)(6512007)(76116006)(64756008)(91956017)(66446008)(66556008)(66476007)(38100700002)(38070700005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVBlMHdxdzlraEk1K1JBWXpYMlpkSEpUeXA5YUtCUDYvQjYyNk5VaXB1bG5s?=
 =?utf-8?B?VTFJbmYzQkVlelB5b0JwOWlmc2l6cytSSE9MWEJ0c2lwejBrS0I1SkpRMmdu?=
 =?utf-8?B?SXJKUzNrdytlSEUzNEJMRVpraHUyeStIR21tOTZLSXRVMDZDZlIxNmFFRURu?=
 =?utf-8?B?SU1jQ0U2K2R5c2xJSUhLdG9JWVFJaVJ2NlNycGp6OTMxVytyNVpsNFpMOVgx?=
 =?utf-8?B?OGYvTDhtVkNBSm1KMXZIVEhHMWFaMExhWmhIYWVKaXJHV2ZTdDh1cHk0clhs?=
 =?utf-8?B?a25IclpQaFpXMWQ1TXJxd1NqclBpVkxhU0p5RlZMOHBsZEJPcTJqMzRCeUdT?=
 =?utf-8?B?Mk1pRWYxelpKS2w4SFlvdEFjR25wbGcxYjUzSWthQlhTYWFSd09PYWZhM3dN?=
 =?utf-8?B?TXFFQUJ2WnNJa0VtNkduNERXYzNuUk1GTU51WkFtaUlmRGRDV0hxc2dBb2Zr?=
 =?utf-8?B?V0x2SFhBOXFPYzVWb24zNVRIYThEMHRZUEZ3QVhHRnZSRmJzdUdwckczb3pO?=
 =?utf-8?B?MEl3WVJGejF1d2hqc1lUY0wySFRUUm5ldzR5Ylk2cTgxc2tvM0xNS3pSZHVS?=
 =?utf-8?B?cEV5YU9KanZZWmZFaUcrc213WkZPczgyb3EwV2ZxVmpLVkUvMDJYUWRGNUdH?=
 =?utf-8?B?SGR2NWZnYkZ5dUhKS1NJWFA0TzBTRmVabUhoNy9rZTBGaEU2blBaYTlOOUJm?=
 =?utf-8?B?NlRiNkZtMkZzNHFvMlVUd2tucjBxZ2RvUy8rWndFYjBFTXJTU096Qi9NTWVQ?=
 =?utf-8?B?UXJtQTBSN0lQczN5c3o0QWtvVGdDbnA4c1dlZ0RRS1FjLzdZZWRsazhITjcv?=
 =?utf-8?B?OHViVTlrRWJOa2pNaDZiMGFZZ3FtTkVmMWY1MWc2TEs5K0M1N1ZIN2ZWYkND?=
 =?utf-8?B?QWoydEF3aGFuV0JYc2loRHgvVWt3eHlQU0NVS2RlNEppa3hNZllpMHE5NkF2?=
 =?utf-8?B?RnBUT3N1eGFUZEpPeWxwaGlMWCtVakxDVHlxQ0ZORENlN051OTBhZUJ3Z3Qw?=
 =?utf-8?B?OFh4cEozTUxhTFgveFFMK09zaXJ1QXlkeVVMQ2FNNFJoT203TXV1Q0lnbjc4?=
 =?utf-8?B?VVVzelVUblQ3RUdEMy9Edk9BN1cyUnRHa3hHcGtLWGcyWVNrZXNqaU9HdDNR?=
 =?utf-8?B?ZEZZZjBsMGtQb2NtdDJ2NisvemVtUjZMcjJQampNekpPUS9UblVIU2YxYVpH?=
 =?utf-8?B?RWdjRFlVd1ZnS05oUUJ4elBkSHdSTGtMcXowd0h3MTQzSE5HSmh2YWJ0UVJY?=
 =?utf-8?B?ZkJEekdXS1BBc1VEcTZGZXFFa3NaL0NObElVaHhtbjBRQkJaSmFHbmh1amVy?=
 =?utf-8?B?aHJXN3JBeXEra0RIMjFMVFdZYTBFeW53UTA3ZWhBb0tKL2tVSFV3OEdxejZB?=
 =?utf-8?B?UWYweGRWMXJoKzc4Q1dFQlJQTEJ1STY3SUpoZGdtcURGczlCZHQ1N3hsaTdv?=
 =?utf-8?B?ZWdYbVRETlA0MklLaW1tWWZyZjVqRGhDbWZ3cThnQmxZSENoTUhyRE9Yd0tS?=
 =?utf-8?B?eEYwaitQV21qdzE0V0hwRkc3UGNhT1N0Z0tLOWhNUTU5QWV3UjkvZjlDWnky?=
 =?utf-8?B?cEJIS3FlSmdWR3FUYW96eVMxY3lERFI5Njk0b2k5aVZKdlRrdkpNckUxTE5n?=
 =?utf-8?B?Z2FjRjdaK05Fd2h2MVhacDhTZ2NNM2xjVU1TNHJXVEw4T29DdmlWK1FkamRV?=
 =?utf-8?B?L2hnT0dHVk9ObFZLc3NxcXQxbG02NmRjRDRjNzNCL0lpRmdsZURyQkRFU0VP?=
 =?utf-8?B?SldBL0tzZHdySk9BV1A4WWpZOXRENk9iMm84T2FXN1lib3hWeHNFdHpCZnNO?=
 =?utf-8?B?bVF4aVVSNlNRSm1ITDR4cVJpZ3V1SXFCWDNGNGFJdXI4ckpib1F0MjZSNFlZ?=
 =?utf-8?B?dHVTVUkrWDdKTC9PZHBPcjRXK0d2L05yTk5lM3BMZXpOMGhuUlI5dkhVbmJD?=
 =?utf-8?B?anY0RWZqTC80WlYrY3pJUFhSMHVheExDNW43QkRyTGNUUUszdjBvVXV1eG82?=
 =?utf-8?B?NmZYOC9wY203eGU1UW1PKzMzRTBRVWNvUG1wdC9pU2xVbnlHMmN1TEdLVVNX?=
 =?utf-8?B?dlFRS3BqNlBpdlFRcWFhazdVb3Q3V09TQW92OElaRGdSZ3hFNVgvaUVHMGlP?=
 =?utf-8?B?b3pVT3Z4UVhNbjQ4MEZrZjlEZWhUQlU5eVZIeG1IR0RGZFRxZ0hoVTF2WnhV?=
 =?utf-8?B?TE15MDQ4SkZFY0F3UTlIMGhsWUQ2Y2N2MEI3aWIraFo1eFRPdDFRVVIwaERM?=
 =?utf-8?B?ZExqdHhwMUJxUThqOUQ1OGpUTy9MNzI3YUxvSStrNDZPaytJOEZrSGpYbS9N?=
 =?utf-8?B?T1dFQUhzNUhIcXpadEVXKytXMDNETmgzYjRIbGcwT1djbG5JdGNxKytYSXho?=
 =?utf-8?Q?na8+U6m6XahhXEv2wNYdwga4tAxIcrG8RWpCWq4bTRkmq?=
x-ms-exchange-antispam-messagedata-1: 2ejef0l5jDO/1Q==
Content-Type: text/plain; charset="utf-8"
Content-ID: <DEC45A0C1A6FF545BB1CD390CADC8DF7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8348064-c276-476a-2a8e-08da38577be4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 22:49:21.7894 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tZooxwhLewJkIb8TAPwYI4vhShEpHd0RgxoJci8akYP/aF1NK8FHsWaJMLVd2P3Tbii7fjQ+UCd/+hQZz0GELQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0240
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220517_154926_459654_88D96136 
X-CRM114-Status: GOOD (  10.03  )
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

T24gNS8xNy8yMiAxNTo0NCwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IE9uIFR1ZSwgTWF5IDE3LCAy
MDIyIGF0IDEwOjQxOjU0UE0gKzAwMDAsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4+IEFs
c28sIHRoaXMgcGF0Y2ggZ3JvdXBzIHJlYWRpbmcgY3RybCBub24tbWR0cyBsaW1pdHMgcmlnaHQg
YmVmb3JlIEkvTw0KPj4gcXVldWUgYWxsb2NhdGlvbiBmb3IgZWFjaCB0cmFuc3BvcnQsIHNpbmNl
IHRoZXNlIGxpbWl0cyBhcmUgb25seQ0KPj4gdXNlZCBmb3IgSS9PIHF1ZXVlIGFsbG9jYXRpb24u
DQo+IA0KPiBNYXliZSBqdXN0IGNoZWNrIHRoYXQgJ2N0cmwtPmNudHJsdHlwZSA9PSBOVk1FX0NU
UkxfSU8nIGluc3RlYWQ/DQoNCkkgZGlkIHRoYXQgaW5pdGlhbGx5LCBidXQgaWYgSSByZW1lbWJl
ciBjb3JyZWN0bHkgdmVyc2lvbnMgcHJpb3IgdG8NCjEuNCBkb24ndCBuZWNlc3NhcmlseSByZXBv
cnQgYSB2YWxpZCBjdHJsIHR5cGUuDQoNCi1jaw0KDQoNCg==

