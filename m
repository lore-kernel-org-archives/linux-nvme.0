Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F00C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 21:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C8tPY/gc+MTuYBuHzGOm/IOKERmTq0bJN79od2GcoKg=; b=o2xdUeBolTCg8t0Kk0G281bvwX
	nwwstHcREIkYVvjlFTVidKYGIRddjgbFKWbHottSuGz6YcFEb2Mg3rNxUEuLR7GDYSSzos3h7oVZv
	jh9TFNQG/T1yQcDu4PUQtnPeIvobYGqr3Jb9JFwKVhAWnGVezwLoUGe+AeNSFngSvntzCcNtO5o7x
	mgh2TyQrVFFCG3kXtQc4wDeVa0nbAmj9nbHk2Oz6eGugkZjwqJouLkLXRpt59lztnR4AucUOhUUrn
	BKn7G3EgPx9gxXQcaZhmmn6aL/WihpnLT+TZD13E/8L4CV6P43erO3CaCtNq1+wtBYkk8P909hC3F
	IVhZ0WVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nUFCL-00Aijs-MY; Tue, 15 Mar 2022 21:59:21 +0000
Received: from mail-dm6nam11on20612.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::612]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUFCI-00Aiio-J9
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 21:59:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJMZyDW+u4G6Je+gx5gFK4N+pSONC4KXF2RuVeXe2YrE7ihJkrE7F/+Tgk9XwnfbLcrvASkwKRqdLYzXpse4KvPQOibGyYL3fToNgeag/T30+Z5chmGzOduJZ94T+ARybHJ8htbL9RIDxCNnhMiimIGZ2/thHIvdnZGJXf2nzxI95UO/yFmcamojhCtzdy3SfvDv11QkmJBfXPM0GHw4F2U3fAorHS1VAF2Vvt7Y0IW6ke99fyeilau61EiBv/6kZciyf/+PbIKHdMk/6JrKIc+tsvDE+qV+D8ePReF6PPZ8pdNANUklqLuubj5+Pm/uGG+YQcLSHF8rAcYqlLoyMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8tPY/gc+MTuYBuHzGOm/IOKERmTq0bJN79od2GcoKg=;
 b=SZOrPZIi3FrloOomMem2mqB6KdZz2EC8Nkg47SOj+OTAtx503yW0UKtWX6MmI2Xjwfq3fN9qA+JOHvSFUARQM6AY/okISg6fSO/Nd8yjbbV7J0vh1rNRNtFFZ8taUi0zWrDO6ackPUobs1JtNY76LQ/N3rD78QvLaca9psvEZjC9W/HCoqkqLshhnHKA/BzhpALKYQi6YbAfZ1WF1+utNU2tNNctuMGapnUCETcl/eu9C+9aiqxoWzdGGztkDrRpfWze+B264QGzGQHTl/kc4ghyJvq6RvmRyMqLViJIUHyKTJqpCk02IH2Wp5RgclNGiPzN5IVFzCgWmhnwYNEoRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8tPY/gc+MTuYBuHzGOm/IOKERmTq0bJN79od2GcoKg=;
 b=bwWu0lJMVzlxY/iNm2yeoSiQQm3rYluAEOy/1fEckjn/mlvXe079rWS/ZBIVZfIr7pWgSJnC3lfYHGYD2vqU+h5OAom4TlpGGN5iYmiac5exrCwg+k1BUDW+KaENAJ9mR/QwqhxeF4IJBBThVBnFVW8sD/AyUk0N2SHDEOYhG1qsqjkQ3In3Ue/XMvZJJHNpLg1/s2/QRXVYNteRchx2wBvkpl7caIgd7jMvyis7U5rLyKtDzfaay5x5/+c/E3WPozRUaUJ70sZYngd+xfU9YCe3jD1JNEbYEYIipNLytjRwVR1bWU+0xoKWueSCbbrzAjryKuASlVZDYF55XTuLDw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM6PR12MB3740.namprd12.prod.outlook.com (2603:10b6:5:1c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Tue, 15 Mar
 2022 21:59:12 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.5061.026; Tue, 15 Mar 2022
 21:59:12 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: cleanup how disk->disk_name is assigned
Thread-Topic: [PATCH] nvme: cleanup how disk->disk_name is assigned
Thread-Index: AQHYOHxefpxn/cAUSESSX8KHObU9RazA/tSA
Date: Tue, 15 Mar 2022 21:59:12 +0000
Message-ID: <0b993dc9-b520-ad75-86e0-ffb8702cc563@nvidia.com>
References: <20220315145125.2586068-1-hch@lst.de>
In-Reply-To: <20220315145125.2586068-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9107fc68-51dd-4212-2ea4-08da06cf0a03
x-ms-traffictypediagnostic: DM6PR12MB3740:EE_
x-microsoft-antispam-prvs: <DM6PR12MB374037A922B63570AB4EA41AA3109@DM6PR12MB3740.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yindtQO9PE1BLZLt44DHGjd5bQE3k1NQpDl4VWsUMYN/jYPkHCP8yh5kWSt2AQDKDn3e2NOQasVmQLJA4S+MNgv/7OJZKYFqcpKessAdrREDEa0Rr+Rh+s11mHI8gYLop1V9hUjZI7aaRXEp4BQW55Nf4UN6GA11/7NaL8oTeqJO5ty9amsHkyxY5EImI4VXbzpMLFtFkjn08Yq2Uf3KQ3F6wSH9F6rmTExZVKsSZBEpLaGmAxjkh44QJK+TPzY/NV+xjb5eAS2Vc58zaVf1q294rJkxJwPwuTkq8yMYx+zdPYE+YJXtLymVGzHDawxYCxWaJ/qsaZQgv0+BB9+CBdKqi3O/l7UYOX7vMuzAD4b7YWeUW5jAhpT7AUT5vSoX2fzOGQ0s+adwFnLlBuTYzgqn6IcWuxvyOVbJVcpkDe2OGPYrWDsTAqRWmgTS1e78ZQWtwKVcXrCF/Sa11b0ofmk9RXrzAifMHET8aqTqS2UWX0P8hwGYH0RnRHXEP0oDMO1r8IzK33MHWpapVQnPHiXd0r5f0ZuzJ8S/veiDoc05KwHL9FHgLXbL4kbGjJU6Ezpe+svi82ccEPJlZdD5rHuJvNzou1bxrxskpdkJIejHqsifbHWk8AX0WVFTtxMBL3ANO2kyeLLSjEYnI2ihiaXgnMiTK8HCVYzaz3TMDjfHU2YGwx1PvUFVss1WMug2FsnYCa06shD2EvhUSlyGb4YqAyQWTmkv4B1HXEAAfprXH4iluTSoLOnzNLa+lt1wanAf/0VoM2JN0G2+qE9Teg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(110136005)(316002)(91956017)(2906002)(36756003)(66946007)(76116006)(38070700005)(508600001)(71200400001)(66476007)(4744005)(6486002)(5660300002)(8936002)(38100700002)(64756008)(122000001)(8676002)(4326008)(66446008)(66556008)(31696002)(86362001)(31686004)(2616005)(6512007)(6506007)(83380400001)(186003)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEZqNkwrTUdCL0FOOEJ4ZS9rZzY4clpBdUtlWnlvWjZYa1B1ZVk2ZmFTc2Nu?=
 =?utf-8?B?cWdpZFhJVGM2dHFUKzdRSk1WcFV5QmRtQy9OOTVaQ2RjSXgvbENMakptaWdm?=
 =?utf-8?B?R2FYTWM5dlE1TndWYTQ2S0tyQXlvVjBHQjhnVVhnZU1qWXVtbHF1bEJKczBD?=
 =?utf-8?B?VkxMOVVJQzVxUGRCN2VYeTBTMzhrQmtHK0xzNGs1bkYyWTNUT0NIaHVYazk2?=
 =?utf-8?B?MUNKL0JobEZObUdTRzFKQmFvV1Z1cHM1VHhxTHE4TVB1dTVFWGh6eVhub2p3?=
 =?utf-8?B?TU92bmQ3ZzlDem1ETmFGd1VDVmxydE9ua0t3b2kwSlRkVjhHN1lyeTdhejVD?=
 =?utf-8?B?M0NmNG43a2trV2MrZmdPZk1FS3VlMEJsSG90M3B2WDNoeFNIbnBVc3VkTDdO?=
 =?utf-8?B?YzZQWHlpelVGcmdOSEtvMDJqYmlDRGdVUUhGWUxuNGc5RUlobFNsRWhYVUx2?=
 =?utf-8?B?d1R0SnlodURPaVRabTQ5RE9PbWdZZFd6YVRxcWNYdE80cDFYVzhuSzk4cmt5?=
 =?utf-8?B?REZWSWh4amVuak5OeUd6UDUrazB3SzEzM2FyZUZqVnZxeGU1a2lnWXYwUEFr?=
 =?utf-8?B?UFJPRzVBbW5sOTVGRlpuWUt3djJ0RE14UmR2aTZOZ1lMWkpReWM2TS9lbWp4?=
 =?utf-8?B?aVJ0NG1aMFJscDM5Mk04SDZQVGVGYk14STEwbkZ5WWlpdUhVY2ZGYk5NRkh2?=
 =?utf-8?B?WDVua2thOGg5WmVMc2J5UnlVQ0JBN0lMVEgxcDYrRm1VbytnQVVPVXpZc1JD?=
 =?utf-8?B?RHMvcWRac29HNnJTM2sreTR4MEc0cHh2MHRYNnhOVEx2WWlCanJuY2VLTmJG?=
 =?utf-8?B?N2xFczB4K214cTkvT0c0YWptb3F1bzZKakdSUThyekJ6UmlSRThBbHBsb0pa?=
 =?utf-8?B?SzA5Rk1CejEzWEV4S0twQlY1b3VUT0JnU2h4eEVUTG93eHpMcWRDWEhucllz?=
 =?utf-8?B?NlYwWWtzY2VCZWc2bEpDQ0orVjV4ei8za2xFVjZTMnUwK2xVRWNKa0FHYURr?=
 =?utf-8?B?RmRyNWt2QXBqNGE1Yis2LytPQmdlSzM5M2oxRS9Ra05JM0pXQlI0WmpCQTVj?=
 =?utf-8?B?SU56MFp2WGJlWndpOTNNN1hFTi9OckxYRW0yQlhMcEg4RkQ5blFMUUZWbkha?=
 =?utf-8?B?bnFHaFJranN6bDREaCtwd0o0d3hhaHJFSlF0ZlFmbDc3RW9qcG1FZ0hTd3Y1?=
 =?utf-8?B?N0JUNEhmYWVWakNjT3I3OEJmWGl1aEFCYmlRWnhuS3dja0VqUFRoK2hidVZl?=
 =?utf-8?B?VWtsMnpmeFduZEQ4czRqdmUwRC9kRW5yR0hzOGd2YW1FU3hzUlc5NDk0dHRE?=
 =?utf-8?B?T21BcytKVkw1aVRhY3N3aUdFZGN5MDBJQXlGb3lZZ3E2bDVHMTRCWGhtb0ph?=
 =?utf-8?B?VnRsNG1JbHM3Q0p2bXhUaTRRWXJQR002ZHo3ZUhiejdNU2Z2T3lsRlAzc2VK?=
 =?utf-8?B?TW5obG04UHkvSEIwdEtudGVWd0JET2FxcWdTenBKSTZJWnpCbUptMWJ3S2NM?=
 =?utf-8?B?TjdoYVF1Q2JzM3JHdEdZbzliU2RVRmFBSUxZRWVNbmdNTzU4VGJ4L3hneEZV?=
 =?utf-8?B?d1loRjVIelZJSVUwYWRCaHY4amg3bVhOQlNUMmxjQ1liYi9rck56cUN0Vllw?=
 =?utf-8?B?RUlaNDVhSmczUXJzdjlPczdldjlMRUlhUjQvYVMyR21UcGFtVTh4Uy9DM2VW?=
 =?utf-8?B?TXpSRkJVenZjMGZXYUdhUXB4SktZSWxLMm9hSnNxd28vMFhpa0haUG83RUZm?=
 =?utf-8?B?Y2pxeEJhV1R6Um1tTDVQSnBhTkpWQU9DZnlrNDl0SHlSYTYwOFZEeTh1eVVV?=
 =?utf-8?B?WnFJNHRmQXFOZC9lMXhxckg2YzY2OVI3WCt5ZEp5R2ozcGxnUDR2VFBPdkUv?=
 =?utf-8?B?aXZIN3VSbDNqT01ldnByZ2NJY2lPbkcxUUhBRVA0cmtZN2JYdTBQeDhIT3hh?=
 =?utf-8?B?VzlRRGFYSkpyQS9FVS8vTC9NV3FWZXMvS3FnR0poTTY0NU1FRE41UzZWM0k5?=
 =?utf-8?B?TGpGcFNrN01vQ0k2clVQWkM5b3Z4L3V6V1F2TUIvbTltTWlvZVJOQ0ErWVds?=
 =?utf-8?Q?F6RM2D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4198C30630F024D82935090702FAA1F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9107fc68-51dd-4212-2ea4-08da06cf0a03
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 21:59:12.1074 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VBlEgWqagHbBGW1LdTDH1c8p1MdinAzncAh+PeX4kubu2SdRZgqwrd3FmayjVl3mxcFOfDyozaxwnD9RSmgZUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3740
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_145918_675743_CE2C677F 
X-CRM114-Status: GOOD (  13.02  )
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

T24gMy8xNS8yMiAwNzo1MSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFRoZXkgd2F5IGhv
dyBhc3NpZ25pbmcgdGhlIGRpc2sgbmFtZSBhbmQgY29tbWVudGluZyBvbiB3aHkgaXQgaXMgZG9u
ZQ0KPiBpcyBzcGxpdCBvdmVyIGNvcmUuYyBhbmQgbXVsdGlwYXRoLmMgc2VlbXMgdG8gYmUgcmF0
aGVyIGNvbmZ1c2luZy4NCj4gDQo+IE5vdyB0aGF0IG5zX2hlYWQtPmRpc2sgYWx3YXlzIGV4aXN0
cyB3ZSBjYW4gZG8gYWxsIHRoZSB3b3JrIGluIGNvcmUuYw0KPiBhbmQgaGF2ZSBhIHNpbmdsZSBi
aWcgY29tbWVudCBleHBsYWluaW5nIHRoZSBpc3N1ZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBD
aHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gLS0tDQoNClRoYW5rcyBhIGxvdCBmb3Ig
ZG9pbmcgdGhpcywgbG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJu
aSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

