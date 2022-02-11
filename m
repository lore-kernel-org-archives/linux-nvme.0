Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42DDC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Feb 2022 02:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l+Nj1HBNBJ9skBXCNRmWt2naIuOTXajVrDZbnpviOSk=; b=P8/z9AyfK++iKEcP01pYKdH8GD
	nFrW8OeUT8A4HWADOUPXmadNU99tsDAfwsyAc6Nx/tJAkTzDMyYZgA7VCwPnVLtjHQLzX7j/X0hZi
	BDh+CyvDUCvYRFVmEZuy3hiDMAaAFGdo3+lBOgpMAAReWhifOqKbd8PFPouFEkn2ZbgsjklR9x891
	GZzHa73ZAMzvf5hQaDvGpHgZPTXIWAmcX2DEXd5YjZRzN5SD0p2qwXH2YUwc0hBV/TFqBJI/Mw3DT
	B+iqV3ohjRIZnBfFnc0gV7r3ulGqQJqegsIv+6J/o8nqytu/kMbdzT+7PesRn4HzUq2Nw/0b7224g
	RTohr5hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nILMd-005U7D-Gm; Fri, 11 Feb 2022 02:08:47 +0000
Received: from mail-dm6nam10on2060a.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::60a]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nILMY-005U6c-WC
 for linux-nvme@lists.infradead.org; Fri, 11 Feb 2022 02:08:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fs1oIl1dOTm3rUEIitTMjVMKBmE4PstKEqHVkpWEiLAETSOeuZiuCneF4RavhMUCCvt9/7FfkJQMaqoDV3g3ZEx7Odtfr46FEVyWQqvT+km4ZTstbFTKWwubA38lmoJkrSMo4P6Ag2lFL3E3vpjvfQcNnkBqwpGH6z2hh0l6hGhOjkf9Igb6Nk8JbwMKY71PuDpWZIAEVKNMkiYk3o3kzf3J5CFXJ5grektcK+SGJ0gDwHzbOPv6UFLMQtQ/gKt+GWLyWmn73vjP81pb9dc+ZwmtDe6XItFQvg0Ssz+fby5TPGwRDiTojEnqYEAWr/BZG4hJdWvw6OAkg9pg6zaQxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+Nj1HBNBJ9skBXCNRmWt2naIuOTXajVrDZbnpviOSk=;
 b=XigbCkDwR+3K01ktlBMME5qmAblqwM+6RmLFawA342/ydBxm9SnfVsnt6XIShJwufphXzeo4VKtkOCYmvsk1wE8beHTn+otw+GEizHwdWven7bxZWVND13hg552kEWrdofj+JXZvkZ7ii/202ZHHdTJcKSzByyklN/Pv2K1GnM2tQT73aMtCimYq6CRjZgpGsV9fvoR6VNR9sUMtVC1gaxKADs3hmc3t0042ICJj021enzzuOo1+7ci8bkI3tsf7zvL1DRD8JZjNEAwhyaoRd5nqeR7+BUEqGgrPVUTcS5uodspoBsZKz4AHrdRq0QYHlQEsze0suopcQW17jpSNYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+Nj1HBNBJ9skBXCNRmWt2naIuOTXajVrDZbnpviOSk=;
 b=FqrgM1vPRQPK0tojGHjXtH4jR91RX7dHdUVzVk5HpVAXe8D3HE8tVrr+tGCJo+QJfLFBmjYtRlMuPtFfpYIchhuKR2urt4h6ovnP2xDw1mQ1mFMVZmNa799Qz+f6VEad7T+Lvr+IqUEdQrfTNAqgM5RRFBOcFOHc/Ug6fSOOSHK8qLE7IbtDAwnd9IDZ1MwVKcC1eT0E0m2SF+bv8NF/B7yZEGs1oNk/jxc6xfrccCm7nYADUX6Ep/XpUEiSpQ13NzB3nW9DYKg3Q7NGqum2AgF+vOl9FZRPbeVMVLu0Xu1qz/F7/0WJ81WTzeCijr8tK2qzD6yx/zlg3SIGn3zNqg==
Received: from DM8PR06MB7704.namprd06.prod.outlook.com (2603:10b6:8:32::16) by
 CY4PR06MB3288.namprd06.prod.outlook.com (2603:10b6:910:50::39) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.17; Fri, 11 Feb 2022 02:08:38 +0000
Received: from DM8PR06MB7704.namprd06.prod.outlook.com
 ([fe80::e5f8:848a:a023:2543]) by DM8PR06MB7704.namprd06.prod.outlook.com
 ([fe80::e5f8:848a:a023:2543%6]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 02:08:38 +0000
From: "Knight, Frederick" <Frederick.Knight@netapp.com>
To: Sagi Grimberg <sagi@grimberg.me>, Alex Talker <alextalker@yandex.ru>,
 linux-nvme <linux-nvme@lists.infradead.org>
Subject: RE: NVMe over Fabrics host: behavior on presence of ANA Group in
 "change" state
Thread-Topic: NVMe over Fabrics host: behavior on presence of ANA Group in
 "change" state
Thread-Index: AQHYHs0Be/BEM6D7ckeNgD0k2kpTw6yNjQdQ
Date: Fri, 11 Feb 2022 02:08:38 +0000
Message-ID: <DM8PR06MB770480F38397C8FE8D4D0F22F1309@DM8PR06MB7704.namprd06.prod.outlook.com>
References: <3fec0f6d-508c-c783-1779-a00e43fa2821@yandex.ru>
 <9a765265-0200-0eea-872f-780c4dbb69b8@grimberg.me>
 <02375891-2f92-c3d9-8a55-019b84c14c1c@yandex.ru>
 <205b91c3-4da1-744d-3d06-ccfdf2b93cff@grimberg.me>
 <5b5cfff7-6c07-0cb1-491a-0fa3d13c2cbd@yandex.ru>
 <fd8600bd-aa73-82f7-3ca7-ed7f766f1568@grimberg.me>
In-Reply-To: <fd8600bd-aa73-82f7-3ca7-ed7f766f1568@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.400.34
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=netapp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a684648-ad16-491d-3176-08d9ed036acb
x-ms-traffictypediagnostic: CY4PR06MB3288:EE_
x-microsoft-antispam-prvs: <CY4PR06MB328833F38F2A1DA3BD83EFB5F1309@CY4PR06MB3288.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: crUvChuRnF9awLV7hd1NSI1gksN+sIJ8fG0L1qHG7AixbFaIndADTR37EctWFk4jnciRJJ9l/vtrMvPygtudatxMYcREvVmyNH4tQj6PruJsAZiY3N+FpBcByYjHy5DpUJvErt4Xkuy6Z2OUees7CySyhYKhV88bVoZ9PUfQPdDyrk6efzYg8TdSI6Tk7PigreBU/4BSeI9531dySSetR1PZzAFvJEg1IEhZJ++aOoRqOTxScV7vwy4mGj4hnsP0P4VGueOeU7wa1NM7OYPtYVsU7z/C4/sdcsiwCEnej05kXcqI+MQ537U+FHgDihkIImjXqNHoD/y/8bGBD1uoL/4M2FKw43962gEAtEY0YneF3aCi3VnuhlOhS/Y2FG9UM07R/kCvDewYvn4TH3y0LRQSwvprWZv5Gki+Vb9G5lPuVX27ZeXUuAX9VWBtJFwD+qr4IJrlwaq4LZVo9F02SqiK4ruVVGTTQhQMj2SR0egPyIu8PxshMfRCTQHgfv6t7liVOswZ6JIpFwpY+HvmsLf7n8Uz9fVCHko613ABEvBkVm5B0KsMN78PAStMvTnsXika18IeYAYEnBqHXTZ7CXXprvIWrKaTrWmj81O0sqMa4UQNJSercWCrzBVu9cQRecEtlQpDkq9TTXBZ7RRC3Xomrl4JziQ3nxdeG3kbPrbxmjsS0PWGuRdukBc70IddYPad+V+y+4aUeIVO/tfMPg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR06MB7704.namprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38070700005)(122000001)(83380400001)(86362001)(26005)(186003)(33656002)(38100700002)(110136005)(66476007)(6506007)(8936002)(2906002)(508600001)(71200400001)(9686003)(66556008)(66946007)(5660300002)(52536014)(76116006)(8676002)(316002)(64756008)(7696005)(55016003)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHdDNnBVV1hkVWN6aFVrOUUwSFd4TDRQVXJQUVVWRUd6S3FLZE9lNmxoUzdQ?=
 =?utf-8?B?dGZHaWRRU1ZtM1VNNS80aVdCQjZrWGtUK1F2dDBuUGV6cmxtNng5dkUzRTZ0?=
 =?utf-8?B?cFRhL3d2WGc0SVNTSjl1WVhhQ2FQdXI3cURoVkFwcFM1RGREVVFnV0JOaDBq?=
 =?utf-8?B?OHo3OTZHd1VyTTVOQjcxb0d1VjBMRXY1RnYwZjdST2pTVDk2VnRoMHRoNTlo?=
 =?utf-8?B?Ri82bXFCTjE5UlVyU0tNaStVYzBuKzZSZ2pObmVLeVN5NzM2MU81VFZDTTBi?=
 =?utf-8?B?YkRUeFBsczI4RHNtdjdTQUIxRWNpZHVubGcvbVI4ak03VWdLQndNaWcwK3lr?=
 =?utf-8?B?b2U3empGenlKeVZ5bXhjU25tQThrdktGdXZxSzFhRXR3QW0wd0Y0djdXeXgv?=
 =?utf-8?B?T0RESDlrUmRlSzExQnI3aFJKSEl3enB1UkFTejhSaDg3ZXlzcDVIMEtDQ0lB?=
 =?utf-8?B?VE1MU3R2SG1Zek5sSXk1THNwOXB0dXdFSWJVamsvMXY2Y010MVE5L1U4dkNv?=
 =?utf-8?B?dGpGb2NDbHNmaklFektMd2Fzc0JsZUZYSjQ5RWpzSjJWTXB3Wk9XbytvOHBz?=
 =?utf-8?B?SXZabGFrNXhQV3VhSzg0c0w5cllpUVhjM1RGLzg1aXBnZUV3WnlCUnRkK0VG?=
 =?utf-8?B?WGFHNWNPWDUyQnhTWW9kZE1tRk1jSkpEUDNqc1o5Q2dVRUpENktSTEw0azU5?=
 =?utf-8?B?ckljMG8xTkNKT2lWY0EyOEdrQlhQZm1wQlkxYzJGdTJZOWtPc0YwZGZ1S2d4?=
 =?utf-8?B?UnhUd0J1ZFk0TVh5b2hmRW05SFJTMjkvZER4anp2azFlTGM4QTcwcG53dDN2?=
 =?utf-8?B?YWtuWHZKdjhTM000cXVIRy8za2FvbU11SzhLYWFrY05CWWx1ZXJSbk1HeU15?=
 =?utf-8?B?SXRCNTZTK3RvV25Kc2RRanpGejhIdWNwWEtUSThKdGJIQ0E2SDd3bzE2ZnB1?=
 =?utf-8?B?bDdKaXE1UFpWZjRqc050bHpCT0hWU2NwYnZTT3grVU94WDRaN1owNDVScHdC?=
 =?utf-8?B?c1pObzJzdGhKcDYvQkhLQ2pMbGJYVFNRblNpYUxOdGtHM00vNitkYzUwNEJW?=
 =?utf-8?B?WWhGam5YaVFBUDNVTHVqb2RnYUp1ZWNVUkZxc3h5U3FISWVYeStKNGU2Q1Ba?=
 =?utf-8?B?UVZ1dHhuN2NhUU9uRzRSU1FxNm1IMUM2Z3FPSGJydHV1MUl0QThSSnZHUzZs?=
 =?utf-8?B?OGh6aVNsUUQ1Y2hua0RnbWwvbDV2SmpOSS8yQmJmeS9mOEJUZXUxamRBb0xr?=
 =?utf-8?B?UEZtUnNHM2ZNVjh1VkZFSVNMaDJTSkp3S1hIb01CMS9hODJNWjBnelpubVlC?=
 =?utf-8?B?cjM4dkNoRVhLYzdYL2JqOHg2TW9rU1FGZmV4MG15Mkg0cmF2eTlxaG9sWTJx?=
 =?utf-8?B?ejZacW1ZTWNCQ2xYeUZTOVpLZkdDVmVydkFHenIrUlRRQndWa2VMOTFEZUo0?=
 =?utf-8?B?RWhadVRxTEhUZjlaaW1HTmNqdWZhSTQ4aUQvamJBWHVMamw5bndhNEc2Q0lF?=
 =?utf-8?B?ZERHRGtXVWRnQm1ZZjAvZFRET0pRZXlTU1NmOW5rK3pSRFVQamtiUzZVM3JR?=
 =?utf-8?B?djc4blh1TGR4TlI5MDRvaXRibERaMitITGNudS9uazhyQVd6dGMrOEtHbWQ0?=
 =?utf-8?B?UWREL25LVUUvY1NjSE9IWnY1azVUbzhielB3cE9tcTNYb01Vbkg3TE9BYzk0?=
 =?utf-8?B?OFpQMjhIeGNVWmtyZXJkUk41ZWxydlIxc09GWVBXTlVWdW9ZRi9FNUsrSks0?=
 =?utf-8?B?MjR5aVdmbWk2cFNUSzFBa3NreWJXaUZTL2RlK2Z2SEVaeUdMWU4vVEhhOUdm?=
 =?utf-8?B?ZWpkL1pONytNU0RRZU1EZ3p1SU9KaWd1VFEwc01xRlE2ZkRXblZ3M3ptbGNJ?=
 =?utf-8?B?K3NHWkJidUhjOFRPVlY3WERsS0ZHOWpFUmpvdzV6S1JGVzJEZXh6Nno4MVNF?=
 =?utf-8?B?SzlrVzQrT0lPMzM2UkJYWHRGcEtKK1VaUUtHNWNFUlRybnNRdDd6aWxGWE9k?=
 =?utf-8?B?MUkvZXk0WW92aGxMYmhianRuZ1RubCtzNjB1Smphc2Q2R2k4MmtFbXB5VlVp?=
 =?utf-8?B?dTJDOGNzVFlLSHBWQ1kxN25rUjdqRjJyc25paTQ1RWVNcGhLMk9TT3hNQ1V4?=
 =?utf-8?B?ZHh3VTFpUDhEbTR1ampEcWlZMXhZa1gyWmtweW05SVFxOTZ6QXZmdDBVSy9K?=
 =?utf-8?Q?esLjYyVPss384Qgv9Ecn7YU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR06MB7704.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a684648-ad16-491d-3176-08d9ed036acb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 02:08:38.1397 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dhctmm4PNV1lu4lLNoI+fHSezbfbN5LzYkXPQDS08nyEVXtnYNlYlGtJ3hrznO861SqefBHlhZipUcPVLqT+pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR06MB3288
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220210_180843_344028_F044B68F 
X-CRM114-Status: GOOD (  26.24  )
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

DQo+ICA+IENhbiB5b3UgcGxlYXNlIHN0b3AgdG9wLXBvc3RpbmcsIGl0cyBkaWZmaWN1bHQgdG8g
Zm9sbG93IHRoaXMgID4gDQo+IGNvcHktcGFzdGluZy10b3AtcG9zdGluZyBjaGFpbiB0aGF0IHlv
dSBhcmUgZ2VuZXJhdGluZy4uDQo+DQo+IE15IGJhZCwgSSBqdXN0IGhhZCBhIGhhcmQgdGltZSB0
YW1pbmcgbXkgbWFpbCBjbGllbnQgaW4gYWxsIHRoaXMgDQo+IHBsYWluLXRleHQgbW9kZSByZXF1
aXJlbWVudHMuDQo+IEFsc28sIEkgd2FzIGEgYml0IGNvbmZ1c2VkIG9uIGhvdyB0byBoYW5kbGUg
YnJhbmNoaW5nLW9mZiByZXBsaWVzIDopDQo+DQo+DQo+IEluIHNob3J0LCBteSBvcGluaW9uLCBh
ZnRlciBjb25zdWx0aW5nIHdpdGggTlZNZSBiYXNlIHNwZWNpZmljYXRpb24gDQo+IDIuMGIgc3Rh
dGluZyBpcyB0aGF0Og0KPg0KPiBhKSAoOC4xLjIsIHBhZ2UgMzQwKSAiTmFtZXNwYWNlcyB0aGF0
IGFyZSBtZW1iZXJzIG9mIHRoZSBzYW1lIEFOQSANCj4gR3JvdXAgcGVyZm9ybSBpZGVudGljYWwg
YXN5bW1ldHJpYyBuYW1lc3BhY2UgYWNjZXNzc3RhdGUgdHJhbnNpdGlvbnMuDQo+IFRoZSBBTkEg
R3JvdXAgbWFpbnRhaW5zIHRoZSBzYW1lIGFzeW1tZXRyaWMgbmFtZXNwYWNlIGFjY2VzcyBzdGF0
ZSBmb3IgDQo+IGFsbG5hbWVzcGFjZXMgdGhhdCBhcmUgbWVtYmVycyBvZiB0aGF0QU5BIEdyb3Vw
IFsuLi5dVGhlIG1ldGhvZCBmb3IgDQo+IGFzc2lnbmluZyBuYW1lc3BhY2VzdG8gQU5BIEdyb3Vw
cyBpcyBvdXRzaWRlIHRoZSBzY29wZSANCj4gb2Z0aGlzc3BlY2lmaWNhdGlvbi4iDQo+IGIpICg4
LjEuMiwgcGFnZSAzNDApICJBbiBBTkEgR3JvdXAgbWF5IGNvbnRhaW4gemVybyBvciBtb3JlIA0K
PiBuYW1lc3BhY2VzWy4uLl1UaGUgbWFwcGluZyBvZiBuYW1lc3BhY2VzLFsuLi5dIHRvIEFOQSBH
cm91cHMgaXMgdmVuZG9yIA0KPiBzcGVjaWZpYy4iDQo+IGMpIChGaWd1cmUgMjgwLCBwYWdlIDI3
MCkgIkFOQUdSUElEWy4uLl0gSWYgdGhlIHZhbHVlIGluIHRoaXMgZmllbGQgDQo+IGNoYW5nZXMg
YW5kIEFzeW1tZXRyaWMgTmFtZXNwYWNlIEFjY2VzcyBDaGFuZ2VOb3RpY2VzIGFyZSBzdXBwb3J0
ZWQgDQo+IGFuZCBlbmFibGVkLCB0aGVuIHRoZSBjb250cm9sbGVyIHNoYWxsIGlzc3VlIGFuIEFz
eW1tZXRyaWNOYW1lc3BhY2UgDQo+IEFjY2VzcyBDaGFuZ2UgTm90aWNlLiINCj4gZCkgKDguMS4z
LjUsIHBhZ2UgMzQzKSAiV2hpbGUgQU5BIENoYW5nZSBzdGF0ZSBpcyByZXBvcnRlZCBieSBhIA0K
PiBjb250cm9sbGVyIGZvciB0aGUgbmFtZXNwYWNlLCB0aGUgaG9zdCBzaG91bGQ6Wy4uLnBhcnQg
YWJvdXQgQU5BVFQuLi5dIg0KPg0KPiBUaHVzIEkgc2VlIGl0IHRoYXQgQU5BVFQtYmFzZWQgdGlt
ZXIgc2hvdWxkIGJlIHN0YXJ0ZWQgb25seSB1cG9uIA0KPiBjb25kaXRpb24gdGhhdCBhIG5hbWVz
cGFjZSBiZWxvbmdzIHRvIGEgZ3JvdXAgaW4gdGhpcyBzdGF0ZSBidXQgY2hhbmdlIA0KPiBvZiBy
ZWxhdGlvbiBiZXR3ZWVuIGEgbmFtZXNwYWNlIGFuZCBpdCdzIEFOQSBzdGF0ZSBjYW4gb2NjdXIg
ZWl0aGVyIA0KPiBiZWNhdXNlIEFOQSBHcm91cCBzdGF0ZSBoYXMgY2hhbmdlcyhhbmQgdGhpcyB3
b3VsZCBhZmZlY3QgYWxsIG9mIHRoZSANCj4gZ3JvdXAgbWVtYmVycykgb3Igd2hlbiBBTkFHUlBJ
RCBpcyBjaGFuZ2VkKGFuZCB0aGlzLCBpZiB0aGUgbmV3IA0KPiBncm91cCdzIEFOQSBzdGF0ZSBk
aWZmZXJzIGZyb20gdGhlIG9sZCBvbmUsIGFmZmVjdHMgb25seSBvbmUgbmFtZXNwYWNlIA0KPiBh
dCBhIHRpbWUpLg0KPiAgRnJvbSB0aGF0LCBJIGZpbmQgaXQgaXMgbG9naWNhbCB0byBuby1vcCBv
biB0aGUgZW1wdHkgQU5BIEdyb3VwcyBpbiANCj4gImNoYW5nZSIgc3RhdGUgc2luY2UgSSBkb24n
dCBzZWUgdGhlIHN0YW5kYXJkIGV4cGxpY2l0bHkgZGlzYWxsb3dpbmcgDQo+IHRoYXQgYmVoYXZp
b3IgaW4gYW55IHdheSB3aGF0c29ldmVyLg0KDQpTb3JyeSwgYXQgbGVhc3QgSSBhbmQgdGhlIG9y
aWdpbmFsIGltcGxlbWVudGVyIChDaHJpc3RvcGgpIGRpc2FncmVlIHdpdGggeW91ciBpbnRlcnBy
ZXRhdGlvbi4gTm90IHRvIHNheSB0aGF0IHdlIGFyZSBib3RoIHdyb25nLg0KDQpBZGRpbmcgRnJl
ZCBmb3Igc29tZSBtb3JlIGNsYXJpdHkgaGVyZS4NCg0KW0ZLPiBdIEkgdGhpbmsgSSdtIG1pc3Np
bmcgYSBidW5jaCBvZiBjb250ZXh0IGhlcmUuIFdoYXQgaXMgdGhlIG9yaWdpbmFsIHF1ZXN0aW9u
PyAgSSB0YWtlIGEgc3RhYiBhdCBzb21lIGFzc3VtcHRpb25zOg0KV2hhdCBpcyBhbiBlbXB0eSBB
TkEgZ3JvdXA/ICBUaGF0IGlzIGFuIEFOQSBHcm91cCB3aXRoIE5PIE5TSURzIGFzc29jaWF0ZWQg
d2l0aCB0aGF0IGdyb3VwLiBNZWFuaW5nIHRoZSAiTnVtYmVyIG9mIE5TSUQgVmFsdWVzIiBmaWVs
ZCBpcyBjbGVhcmVkIHRvICcwaCcgaW4gdGhlIEFOQSBHcm91cCBEZXNjcmlwdG9yLiBUaGF0IGRl
c2NyaXB0b3IgY2FuIGJlIHVzZWQgdG8gdXBkYXRlIHNvbWUgaG9zdCBpbnRlcm5hbCBzdGF0ZSBp
bmZvcm1hdGlvbiByZWxhdGVkIHRvIHRoYXQgQU5BIGdyb3VwLCBidXQgaXQgaGFzIG5vIGltcGFj
dCBvbiBhbnkgSS9PIGJlY2F1c2UgdGhlcmUgY2FuIGJlIG5vIEkvTyAoc2luY2UgdGhlcmUgYXJl
IG5vIE5TSUQgdmFsdWVzKS4gIFNvIEknbSBub3Qgc3VyZSB3aGVyZSB0aGF0IGlzIGdvaW5nIChi
ZWNhdXNlIFJHTz0xIGFsc28gY2FuIHJldHVybiBBTkEgR3JvdXBzIHRoYXQgaGF2ZSBzdGF0ZSwg
YnV0IG5vIGF0dGFjaGVkIG5hbWVzcGFjZXMgKGl0J3MgYSB3YXkgdG8gZ2V0IGdyb3VwIHN0YXRl
IHdpdGhvdXQgYW55IE5TSUQgaW52ZW50b3J5IHJlcXVpcmVtZW50cykpLg0KDQo+IC4uLiBvciB3
aGVuIEFOQUdSUElEIGlzIGNoYW5nZWQoYW5kIHRoaXMsIGlmIHRoZSBuZXcgDQo+IGdyb3VwJ3Mg
QU5BIHN0YXRlIGRpZmZlcnMgZnJvbSB0aGUgb2xkIG9uZSwgYWZmZWN0cyBvbmx5IG9uZSBuYW1l
c3BhY2UgDQo+IGF0IGEgdGltZSkuDQoNCk5vdyB0aGlzIHRyZWFkcyBpbnRvIHRoZSBUUCA0MTA4
IHNwYWNlLiAgVGhlcmUgaXMgY3VycmVudGx5IG5vIHdheSB0byByZXBvcnQgYW55dGhpbmcgdGhh
dCBpbXBhY3RzICJvbmx5IG9uZSBuYW1lc3BhY2UgYXQgYSB0aW1lIi4gIEFOWSByZXBvcnQgb2Yg
YSBjaGFuZ2UgKEFFTikgZm9yIGFueSBuYW1lc3BhY2UgaXMgYWx3YXlzIHJlcG9ydGluZyBhIHN0
YXRlIGNoYW5nZSBmb3IgdGhlIGVudGlyZSBncm91cCB0aGF0IGNvbnRhaW5zIHRoZSBuYW1lc3Bh
Y2Ugd2hlcmUgdGhlIGV2ZW50IG9jY3VycmVkLiAgVGhhdCBpcyB0aGUgV0hPTEUgUE9JTlQgb2Yg
QU5BIEdyb3Vwcy4gIEFORCwgdGhhdCBpcyB0aGUgd2hvbGUgcG9pbnQgb2YgVFA0MTA4IC0gdG8g
YWRkcmVzcyB0aGF0IGtpbmQgb2Ygc2l0dWF0aW9uICh3aGVyZSBhIGNoYW5nZSBpbXBhY3RzIG9u
bHkgMSBuYW1lc3BhY2UpLiBVbnRpbCBUUDQxMDggYWRkcmVzcyB0aGlzIHNpdHVhdGlvbiwgYSBz
aW5nbGUgbmFtZXNwYWNlIGNoYW5naW5nIHRoZSBBTkFHUlBJRCBpcyB1Z2x5LiAgTWF5YmUgd2Ug
c2hvdWxkIGdldCB0byB3b3JrIG9uIHRoYXQgVFAuDQoNCkFsc28gcmVtZW1iZXIgdGhhdCAiQ2hh
bmdlIiBzdGF0ZSBkb2VzIE5PVCBoYXZlIHRvIGJlIHZpc2libGUgdG8gdGhlIGhvc3Q7IHRoZSBj
b250cm9sbGVyIGNhbiB0cmFuc2l0aW9uIHRocm91Z2ggdGhlIENoYW5nZSBzdGF0ZSBiZWZvcmUg
dGhlIGhvc3QgZXZlciBub3RpY2VzIC0gc28sIHRvIHRoZSBob3N0LCBpdCBjYW4gbG9vayBsaWtl
IGFsbCB0aGUgbmFtZXNwYWNlIGluIHRoZSBHcm91cCB0cmFuc2l0aW9uIGRpcmVjdGx5IGZyb20g
b3B0aW1pemVkIHRvIG5vbi1vcHRpbWl6ZWQgKGFzIG9uZSBleGFtcGxlKS4NCg0KTm90IHN1cmUg
aWYgdGhhdCBoZWxwcyBhbnkuIFdoYXQgd2FzIHRoZSBvcmlnaW5hbCBxdWVzdGlvbj8NCg0KCUZy
ZWQNCg0K

