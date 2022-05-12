Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D73DDC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 12 May 2022 19:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e36sU4ZWqN/nYqb+6vSFI2cllZnsheXHyTrl3FKZnlw=; b=Z31ROZZ5riKmIf4G47wyAuM/Gq
	xvFXsF8IvuWnMKdoOq086aLBdx+nYSb+C9ParfAbOlDQjUZm0hA/Yt4dapm2T9MB/jBRXqDQrKsBW
	APP6J1w/AhYUE+XfztgTtK0q02gnT18OsQ6lgNWOaXCu8kAoQOm+KKzVRfYOIEnRoKggDXB8WcCb5
	hM35iVxx6GcrUm9fRyZdLIT32BNHockiUA4gtT5JUgDL0UVUifkHPUau+gnL3VtwmO6Ev3yJCs2bi
	zG+AoF0jM2+s6dnQDJbEAXAoI1B/iGsQU2NrPjc1TO4zSOSIjLEq22uL+gkKESx+gZj0h571wcIg3
	078LdMKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1npEJm-00DDtq-KT; Thu, 12 May 2022 19:17:46 +0000
Received: from mail-co1nam11on20630.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::630]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1npEJk-00DDtM-Fl
 for linux-nvme@lists.infradead.org; Thu, 12 May 2022 19:17:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxU/QBls2Kxat7dmS0UJHptjdYLbFwYlQQrNbjihZgvh4gC9hUuvp1Ckwj/XW2MmYAg0BwrDdAL7FLVnsKUujaAQv9JYg0LKyRGCBKdE48AqBrI48cYMoSiFrgiifuDImzhe9e+q6mZ4MSKbAn6G4Sn4SpRMGgTrNyon30KfTrgreGH+UUc/foUIDTL7fBVRnOVJYC7BMFgvhyaNwQgZnenxXX83h6VhO2pSPYwtETDndUMl/1HTWcKvOQXwXuY8K7Ae9TBiOEEhAnTWZkabQt+q8VLpivW2DBxLqyakIP1ytAaNr7+h25wVsVKhojWCQBEiBsH2nqfRUm/k5CNj+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e36sU4ZWqN/nYqb+6vSFI2cllZnsheXHyTrl3FKZnlw=;
 b=NCbw0xV9hk+N40njcwaRXRrl6OIiHhdpBpSabZeQ9fGDQfb0HEKU989N4JeyUeAlxvxzadTmZ6FdcCoOwlKUehegVqsDMau/9SWlYMFtSy3HZ+2c1QsHlA/SdzKcNTfPHfO1tyGZ/ct2Psnc+2fRxWTJGls39bkUTY9RYe/CT3cEi6enNIb+zQmI7nTFCEfe2aB0ajSDnleywPnXPyscJX3gB0nPcytf1asjqeT1n2wGBul7uQCOZHFkzaxajLdC6JdbVhRDIl5xhIk+sXEkYm1pmrcAkkmZ3fwFnTcS9TjtCvvc6h/cFLH2YYHVCcLOvCYE6xUGlU3LTwgSGFptJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e36sU4ZWqN/nYqb+6vSFI2cllZnsheXHyTrl3FKZnlw=;
 b=jCIgQu5oqf9mbFBO+RtgcpfkfZN7XY6qHRyivrq+4UmJGEgRGvr2OXz1Zng4oPBMVS8xsm3XlP8zNtuC9mq/K+CcmhsiOB3I5oyYCXuelrZi3jZkJiJ3vBWMm8Dso9TC9HA+XXJxrGCei1mbU0dVtN/+TiII3G/ca+Lnh9/aY9QUVUcFu5khlAm+1Pyf6zXOuGeP/tv1j5ea6GTQ8ux19ECaKKgeoT12NLSNdFzgMnkkv9PyU4egZrmK3mw6H9lYVNYUFjIajvlyA2oG+Wc1j2knapYH5Sqx/F5aVDD0KUIU1dygg+E2x62guHU1WFq0DdMFKPnDFHMOAaGPG/1xBQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1343.namprd12.prod.outlook.com (2603:10b6:300:7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Thu, 12 May
 2022 19:01:44 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5227.023; Thu, 12 May 2022
 19:01:44 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Alan Adamson <alan.adamson@oracle.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH blktests] tests/nvme: add tests for error logging
Thread-Topic: [PATCH blktests] tests/nvme: add tests for error logging
Thread-Index: AQHYXBXvgw8igX/zVk6hotp6/G/rIa0WbaWAgAU+FYCAAAB4gIAAARMA
Date: Thu, 12 May 2022 19:01:44 +0000
Message-ID: <0bf90c9f-dbbe-4064-c569-b70b32e6412f@nvidia.com>
References: <20220429220946.22099-1-alan.adamson@oracle.com>
 <20220509105242.hv52nmc7yqd4chnz@shindev>
 <4a655f3e-a5dc-6aac-c1f2-a9620d05ae4e@nvidia.com>
 <8C5E4A85-9A5D-4F2E-AAE2-4BA16CE69DDF@oracle.com>
In-Reply-To: <8C5E4A85-9A5D-4F2E-AAE2-4BA16CE69DDF@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4cb40a1-d281-4a48-3c23-08da3449db85
x-ms-traffictypediagnostic: MWHPR12MB1343:EE_
x-microsoft-antispam-prvs: <MWHPR12MB1343F7331965C766C6773B50A3CB9@MWHPR12MB1343.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hhP3wmrpNzwHY14kHPX5E98myTizNRvt6/j6IBLo8Mhab4+BVA61TM/wvVHDSqfIamjE6xW6PBsbW0YFXMO9VkXTiL/x1KNnsHPpPRqQ+QaRahDk14YLBHsE+QwsceUvWftrbDT3HHgR1KOi9WaZjU7V0X7fBCqqhcPBdqdafn6dE8EbOaIYRJbiFsQlKkBrRWi4Q6fxRrtgMjWAkQ1A/+Dcnw8Sv5uiE4vunGclq7pIZWZ5q3qDToJjXJQj7ip+Q7EthGTPLQwH1P5zss82wMxXbd1ZKojY6SvCnhOBujT/i+Fg9Xq2S2R+MNzcFyOVSF8iU14PbIn3m+hzVXmY1VwoMZslImu3zU42GaYnfvEUmWjGbV6QLSyyWl5ECzErSwOw+Qjkk4f9TdDJxY+a9ULVlL1HmqpQDDYcaAP+DD17SwlaJhAxiKNU4v4WWd5930EhmO9f45gnEI5RIm2LOayRTry7dRNO/ZAakZsH+Pno1VkQLaxYzOnYaDGtWsMv8tffuVhfRnqUcIQ2HrE4+kujd2Ija2uJQjia+QaNVD0UBZW1+Tm2a0ioXr1AzNMAjha9M1ZJDWfhQat9YzLKkb387w7vNneL6H5VgYly0o3V1yHeGuCDKkLPHI/BkLXNrJ7go1ehJlLoGREdG/Hc9AAfCAuMj4u7O5L7IjZEPJ603iA4yH4Qgvc0L4/wwrLn7DAo38Bm2XSjNG2ckiNpCMZAMdEJZHgbxYuDkfwP/CA6DWT/XEzXZ3fVkQKPP/ajDyB+lrgwfxOhTQVvE4pzJg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31686004)(2906002)(8936002)(508600001)(36756003)(54906003)(316002)(91956017)(6916009)(6486002)(558084003)(6506007)(6512007)(71200400001)(2616005)(186003)(38070700005)(38100700002)(122000001)(8676002)(66476007)(4326008)(5660300002)(64756008)(66946007)(66556008)(76116006)(66446008)(86362001)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rkk5QkRFTzk3T01tQ2djTVdmUi9ObGN5UEhwYSt0ZGZYV1hib0JlMnZJU0Qr?=
 =?utf-8?B?RCtGTC9US0ZvQnU3cGNITW5RbGh1eHFKam1EUVhMMHk1Q2d6VTBoSVhXU2hj?=
 =?utf-8?B?VGlnUjVtOEVSaVZzOXhFUjVJc3YxN3ZKMkdGd0tnemRmak81eHZYa2FiV3VP?=
 =?utf-8?B?WWhwdWFsNk1oV0ZHUFdaM3ZXL1JZcFpUVGNNN1lFTW90amRYYlR5d1BCN0xC?=
 =?utf-8?B?cUdXZmlhcFNZQWRBcTFjaHpsam03NHVjaGtwbVdGQ2tjNlhLWUZ0YjE1VHVy?=
 =?utf-8?B?a0U3ZVJZNmtqY0RUL1c3TDJQVUhjcXBldSttVm5rUnJVc016RmZOejNlQTV2?=
 =?utf-8?B?VEVvVzdwSXZWV1FaWTNVVWNTQUx0ZVNnYnJRckxQV1NGWmZwa2J2TTRxeUFH?=
 =?utf-8?B?eEMxRmREZTZGTzlsaEd3VXFPME9lTDRyOUt1RE1OM0MwemRZQnlZcFNIWVpi?=
 =?utf-8?B?L01odFZFSVltTGtLajIwSHFCcVdoMGZiTk5TT2xTM1RidzNKWDcwMGVhTW1L?=
 =?utf-8?B?VWRmV2R0OXRKU2N6NVJPaVlaWUorQk9oNVQyMkNpL01jRENzR3dodnlXTTJ2?=
 =?utf-8?B?M1FCZTczN0V2WTArUTJOZ0dHempjU1VoNGd3a2psMVkweXlBcldoajV2Vmh2?=
 =?utf-8?B?c0VJeWhUOTVqaDIxQVdmbnJLWFBUUXRVZkVES2NBb21Ba2lRd3pKVytVTzEv?=
 =?utf-8?B?dlhzRmNhTmJDTjhrRy9hSHlaRWxxWENpTnIvR096UmpJSVVLOEpKb1FvL0lW?=
 =?utf-8?B?c2cwaHBBKzFSWG1BalFZTnBYbmI2cDRzU1h0UTZtRjJ2dmVCM3VUNWZyMEc4?=
 =?utf-8?B?dkQydE41Z3JrRWdqNytnK2tteTRiZFA4RGRCcVZFbFV1NDRCSTgvOUhSWHcv?=
 =?utf-8?B?R2tVSlVGc0V4WkxpRDFGdjJleWNwRFF6TlkxR3pqMXppeWhmZ1RyRXFoSE4r?=
 =?utf-8?B?b2FBOFdGUTdKbVlCZ0ZNTWpRYzJid25tZFZEZTc5YVZlM0cxNStCZG5GR1pk?=
 =?utf-8?B?cHl2dUdrU0JIM0xnVzNzV2ZwSVc4TTZJamdHU0JLRGxiVlNXODNSSDNBVm53?=
 =?utf-8?B?c0RBbEx0d0hRYjZNOUhNWUFCWS9tNFk2NTZXKzFGd1hWUHo2cXFpKytzZ0RR?=
 =?utf-8?B?dkdNSjl1MzZpMkVwdUtVYXdBNlpjK29yekpWOWhvK2RESWNySUF1NVZnNXcr?=
 =?utf-8?B?aXRwWXJZd2hwa1g5M2FTcDBLa2JSeUplMisvb1lSUzFjYTVubXl5eVF3aElz?=
 =?utf-8?B?ZGpxcVZXa1RseHNIeVptc1RPQkVwZS9DaWcrL0Nsd2hieHNGVjRFdnZFd08r?=
 =?utf-8?B?V0ZjeEJZdFl6L0p0Uk1jcTNGZm5LVnROTTR0QVdjNHdsQ1U5cXZsRTRyN2dN?=
 =?utf-8?B?ZXBRaUxNWWhOQUEvdlhteWRQWVF2MzVRZW8yeUZQNDBqbU03MmJjZ25ObW1j?=
 =?utf-8?B?RUVLMUFxMjZ3WjJ1SnFkZHlHNnVCdThKVk5QTzlLMnV4d0lmaENaR1JEQTdz?=
 =?utf-8?B?aXAwVmFSU1dvMEdObEdFTFFENEZsN1RWUG5pVm1Vd0lra1FwNVBXZlN5Yzhs?=
 =?utf-8?B?UzlOQXRMWTE2VDFNQ2JWUlBldkd4NzRWeU43ZWFLNmhlaVYreFNlTmhaZ2VY?=
 =?utf-8?B?ZFFUZlNpYjUxYk5KU1NpbW45SCtQTTZ5amhyclpYNTgybTdjczNQRnUxbkZs?=
 =?utf-8?B?bktXVCtIRDhQNC85SHA5bWRHeUF4T2diS2tXakJsamZDM1FJaEpsaG50WVVr?=
 =?utf-8?B?c2JxRUV4VitkcHNlUVFjR0hLL2Q4WUVUMS9FQTZLYWUzRmhJMWpyMmUyY3gr?=
 =?utf-8?B?Tnl5b3VmS3FwaUR2dlYwcVhSL2F5L09tREs1QVIrNFdlRGRUbWRGeFJsNjV6?=
 =?utf-8?B?K2VVOXBuZ1RFelhHeW92cG5VNVZ6bzRKMnZtNVdDbStVQkZTTXUxc2xSNmhU?=
 =?utf-8?B?MXdUWHZxZXZBSXhkQnNhMmpMMUI0Q1dQWE11K3RKVkRtZE9ha3VPZ09JK0Zv?=
 =?utf-8?B?Y3BYTU9VcXh4bTNNVTllT3U5UlpSYWxrWmphaTFqVm5OVzNrTlZBVG5jWTcr?=
 =?utf-8?B?aWxOWHlZeVpsQmNpdUI4V0t4bmtGNlVTMWQ1OWtrY2taT3JWTFBHSXBQUENZ?=
 =?utf-8?B?aWFqRzBlWHAvdjNUOVNqa2NtQTJYSEhMYklCVzVZU1JBS2xhNjJQSTQycnFJ?=
 =?utf-8?B?SXR2RExmajVDK2N5WVRnYVNwTVpHZjhJa0k2bGRYaXJjMVpaRTVaQ1hRWkx1?=
 =?utf-8?B?cHkxZGpCTlpROE90K0NVQ3lIdGl3VDRBMllkM3RUOFpaWXZTT1VFMXNJSWJp?=
 =?utf-8?B?RXYxNVFSdHFDYVpGd3V6SmphYSt0Zm40czhhNVV1NzB1STdoZWxSM3IwWTFT?=
 =?utf-8?Q?za6Ei4y1B8rfD+Ek=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E80270C88C70C84B9A7B56B1CAE6548D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4cb40a1-d281-4a48-3c23-08da3449db85
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2022 19:01:44.6389 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z0j1PxHWDwwdc/yHKdCRf+jXlrftgA3KZOEvu6YRGeghQXchfVMXUZXwccAoJd79Cdc3DBLVAzjzQqaza9Xbtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1343
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220512_121744_558008_A0600EAF 
X-CRM114-Status: UNSURE (   8.70  )
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

DQo+PiBjYW4geW91IHBsZWFzZSBzZW5kIG91dCBWMiB3aXRoIFNoaW5pY2hpcm8ncyBjb21tZW50
cyA/DQo+IEkgZGlkIG9uIFdlZG5lc2RheS4gIEdldHRpbmcgcmVhZHkgdG8gc2VuZCBvdXQgYSB2
My4NCj4gDQo+IEFsYW4NCg0KWWVwLCBteSBtYWlsIHNlcnZlciBkaWQgbm90IHN5bmMgZW1haWxz
IC4uDQoNCj4gDQo+Pg0KPj4gLWNrDQo+Pg0KPiANCg0K

