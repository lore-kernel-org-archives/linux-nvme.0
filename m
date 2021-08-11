Return-Path: <SRS0=LdLJ=NC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C489C4338F
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Aug 2021 07:59:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE06260551
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Aug 2021 07:59:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AE06260551
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=primelogic.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=j+Nljj6GyEXY6k0uYrAjiI7LArJoO5OYCgaEN40heqE=; b=ht9JX6Wla0STti
	jovoO7WtMKMkfj1V6FkEuzc5ZM+v/fsMtaui43A59JJ3BjFy5eD4iUKZnnpoTM/NebM4t7bAC+5br
	0YlBXWEz0bidw+e1tZE9xHpTCS+cIhgSwklL4fcYXElz8rjQVdaMHUPKBS6HGcaqFLaCnHO35fcuB
	q+g06KDEZNHT4fzsT53Zh6lBvuIfsUQzbgT/r9RpSxCmUC8XBr+VaFXw+IZG6t9NU9e0mgmnVAZcM
	SNgfZh9k2fHrc6TvFZFIRAyxBuPwlsgQ+WgBp9H9/+C1FQiQAOUmrZAvCDnLT4dqMN0zEoRRABaeI
	OsXxa2jzrn9FixjsEt0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mDj8H-005wr3-R7; Wed, 11 Aug 2021 07:58:37 +0000
Received: from mail-eopbgr150127.outbound.protection.outlook.com
 ([40.107.15.127] helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDj8D-005wpY-ST
 for linux-nvme@lists.infradead.org; Wed, 11 Aug 2021 07:58:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oq3e++tFUeGU8CvD2W6PTaRFSSdVQFwFIsE9Y35ekq+8EVFzPbJeVAv4qbT00Xrc2Q+b1kaNLRZXhWxo9ug5HxYxAE5jf+ivljCyVEZo1qwVuGy0MAuIpPXr4q1BhpGyBeuLNfMFRTz6VwVeDycwtitoBlgz8jyCNg40LSFfhP7gqGWB1Iz3f/oZwtbCxn+9xi91ug2gJkyKi0GzPfEa9kOpO+oFf/kceA/J3zBBjWM9jV3cbfknhHHV3HrzHX/MXdEgbxLdTlaPxWiK6F7RF7d9iFkM8q+yu68gqvGjjCSBqUbOctrN2wbPQ5JWbR54Mh6pWA2UuTwHYOxQcfXI5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2W5IbPaRvTowmkDu35IG86CxOeh3hwQzhAn62r0+yG0=;
 b=Hv3cR5mfgDTgy49CkGQHiu5ADVN+fgRKU+UiENtEroSMSNREclZSWWuntLyEmbMwFEVhSxY7jFHOkejn3+bWMtpzzczgbVKcC5Wb71p5GnOEks4QuG5yvTF5qPXBvWtC56Lkzjd72dK6mWmFgCJV96We28u5pBCmvvkJ//u0ScsUHComrbmseF5v8NJjaVD0m1DNptRGIsSW8MQLXnd69C2I8gkFIdV0/d+3foPWMjPXjVGyXnfJ1Br243H7qa3YBjUl8jGbr6QzN2b+Z59E6x/EBzCBNrJ6yTu3ga1hN4zl5IKYQahGK0xjRPrjAPKSSEFNcNaJP0qIasno6PrW5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=primelogic.nl; dmarc=pass action=none
 header.from=primelogic.nl; dkim=pass header.d=primelogic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=primelogicnl.onmicrosoft.com; s=selector1-primelogicnl-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2W5IbPaRvTowmkDu35IG86CxOeh3hwQzhAn62r0+yG0=;
 b=wCvxtBZYMtiZR+UhQMNOY6GdljIjQkLtN+GJrwuGRUopsGiinW6Zlobx73y3xzmmSZuJ5eo8/fl4TPhEoD/n2MbSjtzyJQ8eAjwvD5g31SzPZnzVTZr8n02f96gfLEQuyhPm/xIbdkf9xC9sshtAWx2stG2Zxl7m2jasvGB3Odk=
Received: from AM0PR03MB4211.eurprd03.prod.outlook.com (2603:10a6:208:c1::28)
 by AM4PR0301MB2147.eurprd03.prod.outlook.com (2603:10a6:200:4c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Wed, 11 Aug
 2021 07:58:28 +0000
Received: from AM0PR03MB4211.eurprd03.prod.outlook.com
 ([fe80::8162:5c10:a05a:4cdf]) by AM0PR03MB4211.eurprd03.prod.outlook.com
 ([fe80::8162:5c10:a05a:4cdf%3]) with mapi id 15.20.4415.015; Wed, 11 Aug 2021
 07:58:28 +0000
From: Mark Ruijter <mruijter@primelogic.nl>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: nvmet-tcp kernel crashes consistently when doing 64k rw with fio.
Thread-Topic: nvmet-tcp kernel crashes consistently when doing 64k rw with fio.
Thread-Index: AQHXjf132DRtDO+GekCsnZUqDItTxA==
Date: Wed, 11 Aug 2021 07:58:28 +0000
Message-ID: <B1598542-53C3-4887-919C-79D60A90181A@primelogic.nl>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=primelogic.nl;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 659ff0b2-3932-4d52-c6d2-08d95c9dcdfc
x-ms-traffictypediagnostic: AM4PR0301MB2147:
x-microsoft-antispam-prvs: <AM4PR0301MB2147403ABD663D30A2B2AB01D1F89@AM4PR0301MB2147.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HcOXyhkLqRNf65Bneamqd3mU+liIUg/JE9LCgSNywGVuyk3bn2ufYEQtkav6VNmyt1JdOmZsSx8iIyjdYzl57DOVFZQClnfeOiT/QC51ip7rZFxiZL+eAjKLVGyaVuBmGPY6xZCVWgCXFfIoZOxEemBmYHB1aRkCW0nZ7FSSE5mFc71m2r1bOuPaP7WZk8j9MLfQnK4fDXxBEsXdfpFj81smyrkF81mDz6C7AM4s/V5nLn36OcFvKRDbh1gUen8rsezVEgjy4t7hZ2TtSY/WyKw1l1xw+8oMhOmSzBtY3CPfYcHPUAq8azkEQHUDk1GZffoDeGIIv2KMo8CS+ygDLh9kkrGJBib22x7FoHln3UGgMS1IvJIPIResPOHffef5USraqcab+U//9LbTwkPQDYJQLKxJ3binsRU+hHuA1+bAyFUkPi7ZvEtybz/tWlexJIbTzZxdYiN8nf5ELidFL+0WrX7M/Xr0+8hNbjqgfBvJrtj92yuAErfJSoSY2dvNfFX6SUg7JcD7BltA8mgjC2rPaPLe447o/BJhNu9C2TXW3+s2i8+l2qeozHacdgT4xfGvf3ci/XP6ScbpcfGE0sltjnxNocvpYGFi/Lt7zOaU5qYph0C8BjGREDufDK5nIzt3ijmkdwiXsJCwko9ztpEvkr2zGJQJkvjKu1eWqk8nCUDp8LliHe/1MAHqZ9ty9Iek3ls3runYP8N9dkWwGNrPJqetDJ3Wym5CqZsXIKA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR03MB4211.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(376002)(366004)(396003)(136003)(39830400003)(86362001)(71200400001)(8676002)(6512007)(6486002)(6916009)(36756003)(33656002)(38070700005)(2616005)(122000001)(66446008)(6506007)(2906002)(66476007)(76116006)(478600001)(26005)(66556008)(66946007)(186003)(45080400002)(8936002)(316002)(38100700002)(91956017)(64756008)(83380400001)(5660300002)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czkyTjlwbE9QdXhEYW1kL1BLdDUwMnpGb0htelBJNWlBajBTTG11endHa1RI?=
 =?utf-8?B?aDloeHkvQklHNWtuTUswbEc4VFhyd1RGSXUxeUhhdGxQMmt6ck9hVllWM1Ex?=
 =?utf-8?B?bk9aNlQ5YkZlOG9FM3RDQmFMSGU3cE9rS0ZZMzMxeThZbDdwcnFJdlplL28x?=
 =?utf-8?B?bXFJMEJlcEJLcHZZeWsrMUI5K0FHa2NyOTJTc2JXbmNxRzZtcXBOQis0UU44?=
 =?utf-8?B?RVplUjVoOWZnVDh3WUoyeURDajFIR3FpM2REMExaOUxwaXFQVktqK0RwaVY2?=
 =?utf-8?B?MGc0KzNnT25FOU1NM0RPUWhUSDBDWWtVYlJXcmFpSkNxOGNVaUZnZmhBQ3M2?=
 =?utf-8?B?ODhZYjdPeEVDdWh6UE9WT3FUelhvUzhTS01kUzVqblZwSTRaYXZUdktObklL?=
 =?utf-8?B?YkZqeVRnUnhnMG41U3hxenNpRXg3TkRmdG5GblhBS1pmRUcwSDBhejVrbmNj?=
 =?utf-8?B?Qi9DcmM0Z3NULzg3VXJkSEhPUUFnVmJubU5YcjhSdDlVak1wR0NCVG83NUdC?=
 =?utf-8?B?RWR5MzBlMnUxQmJmVGJtWmVkYmplVTBKWmNKV1o3bmtjWndzRXFSUjJKMDBI?=
 =?utf-8?B?d1U3YkZYQXZibm9DOC9HZm1NSVNHOStnWEx6T1lWNkVpTTVscm1tRExUYlFQ?=
 =?utf-8?B?aWk5US9BNzBDRzRuby9Xc08ybDB3dVhWeDhoQUFuZmV2VS9nN3FVOGhWM3F1?=
 =?utf-8?B?dUtZenNzSEQ3TzhrbXREbXVscWU3WlpTNUVDWVlkSGpOSU13ekJnNFhoOGNt?=
 =?utf-8?B?ZFEyMmsvYmIya0trME85aUJFVWRkV1BUcnc0SFdWbEY4bTBWMEl4NDVOalBR?=
 =?utf-8?B?MkY1Tk1GYTRWNHhYSXcyV0lzbTNxOERhc3B5M3lYUlI5Vk9zS0Z6cmR2U0sr?=
 =?utf-8?B?UlhId1J4L25HWUFQbDNxM0VZZUtrK2FKSUJVOEVCQjlsQmFEWVY4a1U4VW9T?=
 =?utf-8?B?UWdONjl1WDBkQ2ZTUllYN2FIYTFXNGRmby9PSy91NWxDK0JZbVRhdDR2dGli?=
 =?utf-8?B?dUJBcHJKRFRiZjJ0SG1UVm9KeUZqbE9KdzZhUGlzNXhvU2R1MHlNeDhaZjdJ?=
 =?utf-8?B?b1h5Yi9CczdxT2ZiMFRCaTIya1lJQ1U2UEtta08vblM4N0VZME95VEZCV3hF?=
 =?utf-8?B?S2UxRWt0QitGb3Q3R3YxWC9ZRThTbW5FaWlaUndKeGMwdnNBZkJUNm9HdzR4?=
 =?utf-8?B?ZXNUaFhSWlI2UlhSRkFuZHdNYWZMWmlHL0EwMjYyek44cjBKN3VpREhoRXM5?=
 =?utf-8?B?L3BxOUpZR0gzMFFvSW5xVWl1emNORlRLWDRxWmh2dXZQMGFXY1JHRFNhdFFB?=
 =?utf-8?B?K25kUkFQV3d3U2o5RHllOGxjd1dReFVBSm53MjlQMTdlNTgzaWVuTUVUY3RH?=
 =?utf-8?B?RXo4ZEh4ODFzWngzYW9VeWVIcmt6bnhEQXZEdFRxbk9rZVRCalR1cHpnQVlM?=
 =?utf-8?B?aWxybUg5RFJSdzBTT1kxY1BnT2dFTjg2Rkc0ellPOVdORmxIU3RvbEFXd0Q3?=
 =?utf-8?B?QkRtekxzWWFLOVJyazhWZWcwaEwzWkVCT2dpR1ZiL1F1UFBoSElKZHVvSldw?=
 =?utf-8?B?TGN2c25QZjdmbUFzaDNxakN3eTkvQ25jcm1nUTNTR1V0VFdJM0l2ODBCcitL?=
 =?utf-8?B?RUZhZTBpSlFhalduOWNUbE5WdjRJMTdpWnBuSHpIbGo3em0rYlEvTnB6K3gz?=
 =?utf-8?B?YkMwYXVVaFo0VHRtT04vNmkrZEZaZVB0RGtKcWMvREVxOVZwVHFvWjdEdmEw?=
 =?utf-8?Q?3OWpWRQrySbCqd1K6oT4Yl5p+t9jooHpw2E5UP2?=
x-ms-exchange-transport-forked: True
Content-ID: <CE5A406F10FC26468D44474FE2E4769D@eurprd03.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: primelogic.nl
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR03MB4211.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 659ff0b2-3932-4d52-c6d2-08d95c9dcdfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2021 07:58:28.3223 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e6f00f2a-c615-4e27-aa0e-cb78655623c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vd9zUY15hRW3Y5NL0INuIR1peitBMaOCyUae5th6AH0lFM7psaIQuSYjECNVlXdcRBviRvCNlVdeYejahgq2kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0301MB2147
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210811_005834_186180_EA9D430A 
X-CRM114-Status: UNSURE (   9.52  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When I attach an initiator to a nvmet-tcp target running kernel 5.10.57 the target system crashes whenever the initiator runs fio with a 64K blocksize.

mix:	rwmixread=100
rw:	rw
blksiz: 64k
qdepth:	128
job:    12

dmesg will first show _many_ of these messages before the system crashes and reboots.
---
messages-20210720:2021-07-19T16:06:40.084137-06:00 gold kernel: [ 3402.950666] nvmet_tcp: failed cmd 00000000873b89c1 id 22 opcode 2, data_len: 65536
messages-20210720:2021-07-19T16:06:40.084137-06:00 gold kernel: [ 3402.950667] nvmet_tcp: failed cmd 0000000022c079ff id 23 opcode 2, data_len: 65536
messages-20210720:2021-07-19T16:06:40.084138-06:00 gold kernel: [ 3402.950669] nvmet_tcp: failed cmd 0000000093ff4775 id 9 opcode 2, data_len: 65536
messages-20210720:2021-07-19T16:06:40.084138-06:00 gold kernel: [ 3402.950671] nvmet_tcp: failed cmd 00000000dcb0e105 id 10 opcode 2, data_len: 65536
---

We tested with kernels 5.3.18 (SuSE) and kernel 5.10.57.
Running 64K IO with fio triggers this problem consistently.
The automated test that we run tests 64K reads and 64 writes.

I managed to grab a stack trace from the older SuSE kernel which may be helpful:
--
[65980.188661] nvmet_tcp: failed cmd 00000000d4ea0295 id 113 opcode 1, data_len: 65536
[65980.188663] #PF: error_code(0x0000) - not-present page
[65980.188665] nvmet_tcp: failed cmd 000000009fad62b2 id 114 opcode 1, data_len: 65536
[65980.188665] PGD 0 P4D 0 
[65980.188674] Oops: 0000 [#1] SMP NOPTI
[65980.188677] CPU: 0 PID: 4193 Comm: kworker/0:7H Kdump: loaded Tainted: G           OE  X  N 5.3.18-24.37-default #1 SLE15-SP2
[65980.188678] Hardware name: Supermicro, Supermicro, Supermicro, Supermicro SYS-2029U-TN24R4T, SYS-2029U-TN24R4T, SYS-2029U-TN24R4T, SYS-2029U-TN24R4T/X11DP
[65980.188683] Workqueue: nvmet_tcp_wq nvmet_tcp_io_work [nvmet_tcp]
[65980.188685] RIP: 0010:nvmet_tcp_map_pdu_iovec+0x66/0xf0 [nvmet_tcp]
[65980.188687] Code: 48 05 ff 0f 00 00 48 c1 e8 0c 81 e5 ff 0f 00 00 89 87 b8 01 00 00 48 c1 e0 05 48 03 47 30 45 85 f6 0f 84 81 00 00 00 41 89 ec <8b> 70 0c 48 8b 08 8b 50 08 29 ee 44 39 f6 41 0f 47 f6 48 83 e1 fc
[65980.188690] RSP: 0018:ffff9aa9602a7d20 EFLAGS: 00010206
[65980.188691] RAX: 0000000000000000 RBX: ffff8f6f208c1c80 RCX: f28d67c52c83a000
[65980.188692] RDX: 0000000000000000 RSI: 0000000000001000 RDI: ffff8f6ecfd8a200
[65980.188693] nvmet_tcp: failed cmd 0000000044957200 id 115 opcode 1, data_len: 65536
[65980.188695] RBP: 0000000000000000 R08: 0000000000006ee0 R09: 0000000000000030
[65980.188696] nvmet_tcp: failed cmd 000000002387173b id 127 opcode 1, data_len: 65536
[65980.188697] R10: 0000000000000010 R11: fefefefefefefeff R12: 0000000000000000
[65980.188698] nvmet_tcp: failed cmd 00000000dc7f4316 id 58 opcode 1, data_len: 65536
[65980.188700] nvmet_tcp: failed cmd 000000002b203233 id 60 opcode 1, data_len: 65536
[65980.188701] R13: ffff8f8eb4f1e510 R14: 000000000000f000 R15: ffff8f8e6f05e810
[65980.188702] nvmet_tcp: failed cmd 00000000d75d54dd id 61 opcode 1, data_len: 65536
[65980.188704] nvmet_tcp: failed cmd 00000000040df628 id 62 opcode 1, data_len: 65536
[65980.188705] FS:  0000000000000000(0000) GS:ffff8f6fafe00000(0000) knlGS:0000000000000000
[65980.188706] nvmet_tcp: failed cmd 00000000d2515f84 id 63 opcode 1, data_len: 65536
[65980.188708] nvmet_tcp: failed cmd 000000009705fc83 id 64 opcode 1, data_len: 65536
[65980.188709] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[65980.188710] nvmet_tcp: failed cmd 00000000f219ad1a id 65 opcode 1, data_len: 65536
[65980.188712] nvmet_tcp: failed cmd 00000000c6c09c57 id 66 opcode 1, data_len: 65536
[65980.188713] CR2: 000000000000000c CR3: 0000003ed41a2002 CR4: 00000000007606f0
[65980.188714] nvmet_tcp: failed cmd 0000000008d40238 id 67 opcode 1, data_len: 65536
[65980.188715] nvmet_tcp: failed cmd 000000006f8e7979 id 68 opcode 1, data_len: 65536
[65980.188717] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[65980.188718] nvmet_tcp: failed cmd 000000006d2f85bb id 69 opcode 1, data_len: 65536
[65980.188720] nvmet_tcp: failed cmd 00000000aaccbded id 70 opcode 1, data_len: 65536
[65980.188721] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[65980.188722] PKRU: 55555554
[65980.188723] Call Trace:
[65980.188727]  nvmet_tcp_try_recv_pdu+0x3dc/0x6f0 [nvmet_tcp]
[65980.188734]  ? __switch_to_asm+0x34/0x70
[65980.188735]  ? __switch_to_asm+0x40/0x70
[65980.188736]  ? __switch_to_asm+0x34/0x70
[65980.188737]  ? __switch_to_asm+0x40/0x70
[65980.188738]  ? __switch_to_asm+0x34/0x70
[65980.188739]  ? __switch_to_asm+0x40/0x70
[65980.188741]  nvmet_tcp_io_work+0x6d/0xa80 [nvmet_tcp]
[65980.188743]  ? __switch_to_asm+0x34/0x70
[65980.188746]  process_one_work+0x1f4/0x3e0
[65980.188748]  worker_thread+0x2d/0x3e0
[65980.188750]  ? process_one_work+0x3e0/0x3e0
[65980.188752]  kthread+0x10d/0x130
[65980.188753]  ? kthread_park+0xa0/0xa0
[65980.188755]  ret_from_fork+0x1f/0x40
[65980.188757] Modules linked in: st sr_mod cdrom lp parport_pc ppdev parport xfrm_user xsk_diag sctp_diag udp_diag raw_diag unix_diag af_packet_diag netlink_diag binfmt_misc xfs dm_snapshot dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio raid0 md_mod tcp_diag inet_diag scst_vdisk(OENN) nfsd auth_rpcgss nfs_acl lockd grace loop nvme nvme_core xt_tcpudp ip6t_rpfilter ip6t_REJECT ipt_REJECT xt_conntrack ip_set nfnetlink ebtable_nat ebtable_broute ip6table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw iptable_security ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter ip_tables x_tables bpfilter nvmet_rdma nvmet_tcp null_blk nvmet iscsi_scst(OENN) scst(OENN) dlm sctp rpcrdma sunrpc rdma_ucm ib_iser rdma_cm iw_cm libiscsi ib_ipoib scsi_transport_iscsi ib_cm configfs ib_umad mlx4_ib mlx4_en mlx4_core mlx5_ib ib_uverbs ib_core mlx5_core mlxfw tls pci_hyperv_intf(XX) ipmi_watc
 hdog
[65980.188788]  af_packet iscsi_ibft iscsi_boot_sysfs rfkill dmi_sysfs msr intel_rapl_msr intel_rapl_common isst_if_common skx_edac nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp ipmi_ssif coretemp ast drm_vram_helper kvm_intel i2c_algo_bit ttm kvm drm_kms_helper irqbypass crc32_pclmul ixgbe drm ghash_clmulni_intel xfrm_algo aesni_intel mei_me libphy syscopyarea aes_x86_64 sysfillrect crypto_simd lpc_ich sysimgblt mdio ioatdma cryptd glue_helper joydev fb_sys_fops i2c_i801 mei mfd_core dca ipmi_si ipmi_devintf ipmi_msghandler acpi_cpufreq acpi_pad button btrfs libcrc32c xor hid_generic usbhid raid6_pq sd_mod crc32c_intel xhci_pci xhci_hcd ahci libahci usbcore libata vmd wmi sg dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua scsi_mod [last unloaded: parport_pc]
[65980.188824] Supported: No, Unsupported modules are loaded
[65980.188826] CR2: 000000000000000c


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
