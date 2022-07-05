Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8424EC433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jul 2022 06:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q2Da49UnAd/+h9JWeQ6pULhlI/HTIWujGtFNyYP7MiE=; b=TaN4Rpt31OHN+QBSWdJWQxhS15
	48k3ilqPCJoTzzO82RVC3X/2eMjhX2OFRjFK9ggkOGlaQDJV1DveiaNPadBYjr3yY9jp5ZPQOicWQ
	TW/sM9zM2F9UUhBPJTIyKzf3dmkXdvs2l7RQ9tW3mlwFg0p0lkg2Qnkn0+Mp3c2dB7eikTPWToh/4
	sqy9DHHEjfr5xGd6B7Ax2ECFiNrVdcUkylAQnrAlImvbghjYfterRVbrOnG6y5ntKOwS7JcAi2/gQ
	0pw8sFFAWJbAgwA4i1kBrjVasE58S82QXVGWk9JzQBP89J/Nf/jWoEHHlVOnI2soEKTtcx2za08//
	QS1eDL4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8bxJ-00Ey3X-N2; Tue, 05 Jul 2022 06:22:41 +0000
Received: from mail-bn8nam04on2064.outbound.protection.outlook.com ([40.107.100.64] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8bxC-00Ey1L-Pz
	for linux-nvme@lists.infradead.org; Tue, 05 Jul 2022 06:22:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBKo+EjeqVJtjD2xeiNoWtbKOfgGx6UeRxi6a124YHCMYy7sL2Z20CpQbqPe0iuyV7atwurOUQI/AN3R+1hFXQDHkJoGtc6q0zJGwPzJjSgPKDBybfakWoPOAeyT9yhHT+1od46Em+ccbkbI0rxV0iqocNy6Urh39ASmKYTx2y4HID1OqL863ZdxSZm2DfatXaHHpim5txU2u7b5kSJY36oLxZl1Hq66BHIfUgzdUZvxU/jxkcCHpNto6M+nXtQDfWHAg+tStqFEY9SMt6GRRpw3J70ck36sPdj3a0kOaVy1/eIm7uSG//DVjVI8JR7kUKujqPA1xufuZQ/t4d7E+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2Da49UnAd/+h9JWeQ6pULhlI/HTIWujGtFNyYP7MiE=;
 b=hNbdx0Tbm3G/rFotTjp9Ysfl2EEXqNEjmMceM0fXiodoUSnC4fddt6eGrEQ7e+4qESnYGa7KJMy3+4qGzUUZHd6jz7hixg+J91sxc8dfCMLgI2Qit4UwNiYwPED04oADRQU94sAQUrp3CiqODl1ntNgFyUn06YNUG+xkKN9OThLQ8lVkWbqDUDLSUt2PoFKcob19R4+1jfMYj52s49RKVQwugqVpgnSpPwLuJ8yW1wSx6V9AxVPeoGIzg47WIbxGMoXUJKyIQQaRa3UEDaLTWe0Wa6KtWI/yRbem9D18JUEujltfJPeQUO0SHZ1AmqU4xg39qO1k6a+Q8Sw4fi/C+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2Da49UnAd/+h9JWeQ6pULhlI/HTIWujGtFNyYP7MiE=;
 b=T7Jzc7lj9UULGjetcHG5fOQ8tob5stChDb/518GNbJKi8uNVtotgaLRO33dedPmEt/eNw4wImfOfDa/dUxvm7PxcrDBAR6+1GfvdDYyXzLGMlnujKw7ZbPoGDZhKqwL24xENZKGPX9YMFz7QwLnvmaQo3+NNe0HL2Ad1veWRZcO8P+oj/einc7CQl5pbgXZ95CS2CNrxVHsmn3Srwq5MnnLkpLfErF0fLD7/mF7cQOl4fxNHPM9TX3iOgBlnlkG5wtPNfqHLrJLTe+YJiwTu18tZPk+oPgDcg2VruFFqdamLfOLB44QO4JajQ8JO+VhybpjLcD0e+2euU5+BxKSheQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW3PR12MB4523.namprd12.prod.outlook.com (2603:10b6:303:5b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Tue, 5 Jul
 2022 06:22:28 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214%7]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 06:22:27 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: "dm-devel@redhat.com" <dm-devel@redhat.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, Damien Le Moal
	<damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 01/17] block: remove a superflous ifdef in blkdev.h
Thread-Topic: [PATCH 01/17] block: remove a superflous ifdef in blkdev.h
Thread-Index: AQHYj6PmRQtHxI9iX0OSVg/tgsQVw61vT+yA
Date: Tue, 5 Jul 2022 06:22:27 +0000
Message-ID: <3e073a6c-1fe8-97b1-aaa4-f6ece90222de@nvidia.com>
References: <20220704124500.155247-1-hch@lst.de>
 <20220704124500.155247-2-hch@lst.de>
In-Reply-To: <20220704124500.155247-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3083c985-27d8-4071-3a65-08da5e4ebbdf
x-ms-traffictypediagnostic: MW3PR12MB4523:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  8CXFjsy3jm6kUXH/OhNYYLfk41i8YpUZc1qvOjJhyX9tXd+c7fL96TrTvYxtu0cfzcExTj9xis8uuJy1IRnjwEXqsLKHIvWoHHT8PM45lHcdxnSf5Y9JOJvgUaUZ4vmvf1Kdxwe1wj5QaX1wF3f6tylqrzCTo/+Bv4v6AAzZUpgH8fBGHAxFdax4FwAeMxaQoNbwVB3BOerpu+hg1sZq4EPqnU5uqBF6yenScpDDpZzs1ZPPgUFgoIlfbADxwar0NgkNbLsc/rW5vQramuBTXDrLdY11769QRkK+P1wYq3QaED+0Z7c0f2sx1jo9cAdzm/8POLtPyL6NKQyFs2RoFDKeqWg5mS5nji1c8b1Bh4m4TwpQ6XFGOTkf7us0X7WH1Y/5oB8tX3q0R/G1GsSunaJsVbmp5NpgD3HzafVNS+qe/IFkiWQd4LtRq/fOA+0OUfL7zivhpvaKMtui5BxwNKAYXnVFlzYzSbbYfVLEOE/71fqawQTwMlqwL8mwDwkv5n9b8fNZX+J5nOOgdyldwMwInvi1oeteclBjrugTZyTYOk+8z2mgzV8hUOU2gtznMMxu6dkh9twBAWscj9g+LyRu1C9QnNUaEtZ473rqGcZKxFegWBVqLbZWQsloqHlJkCwibCfNLjPhF+DnEattWNySZfWQCaeMcL2DatXT8vdeHrIDaZXRLjo2+Y2At7/nGrR8n2+w+EnnRCw7WvNKF9dD9oIgrP8k3EY7HH0aOD1odsGN7Omjhjjg7rX2TS9mpR9ZhFMu01I+0Sg14XXbgDV4DqoEkHbsk6BaSY5bWFXeUNZ6yVpqAvxMbWxjRGAVYFapA2Sd+cN3DIkdhhjDR1MluYddY6CUo+wD6MgPISvAhnv327nMhVlEVQNgCd94
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(6486002)(91956017)(76116006)(6916009)(31686004)(8936002)(54906003)(66446008)(66946007)(8676002)(66476007)(71200400001)(66556008)(36756003)(64756008)(5660300002)(478600001)(316002)(4326008)(38100700002)(2906002)(6512007)(2616005)(41300700001)(186003)(53546011)(31696002)(86362001)(122000001)(38070700005)(558084003)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?d3Y0T0lOUUhqdGdXYmNIRzkwVjVRYmQySjVCZ295QnJlWkE0eXVvUlFMbGZn?=
 =?utf-8?B?Ry9HUnYrUFMvZlY5UHVBNmdmUzgxRkZYYjlZZnk2QnNUcXRNdVlGR2hMdlJq?=
 =?utf-8?B?Z2JlNUtMa3RWZ29CeGZJbWxXRDVQVFNxWUZTTWZMT0hzbU9ETXhmajd1UURO?=
 =?utf-8?B?VklWV05NWjJvcmtvQk9NWW9reGVIbG1wRk5FOUx3SlZmS1pvNXRmUXJOTVdz?=
 =?utf-8?B?UDRNUUFnd0I2am1vejNLNjZSZjNLSWt5dDkwcHZjbFRIaUlQZEx5Vkt1OU1B?=
 =?utf-8?B?cFdqcVZNTEt2Z05wWndLNmJGemdUcURCVGhiV3pneGdzVXFEdlcxSlgzcDgx?=
 =?utf-8?B?QVc3UWxlMDhzN3VPRGxUcEFLRjNmOVhPZnBjZDlPNUVmZFlDbjRmSnNZUTRv?=
 =?utf-8?B?dG9xelo2YUpiUzFoNXZseCtKUWRlc2I5ZXBaUFp3SGxVUkJZZmhVWGxjT0F5?=
 =?utf-8?B?T2ZrVWVKZVE1eEliT096VTJOQVFLZGdROFVmL1V0RURSejJ3Q2tCWDdxalRq?=
 =?utf-8?B?ay9jQWMxRkZSVUlKVFU0SENIVk9XSUNwejg0MElwWU1FTVljUHAwTURnR0ZQ?=
 =?utf-8?B?N0tmYitvYUkvbzc5TUpBVUhvemVIRklBdGFSMndudW1Td3lhRDhTN1EreDRo?=
 =?utf-8?B?dzNidklpQkZhNFdQNkxmOFM3WGl4dzhkTUY5RXl0bkpoK25FMzk1VTZ1Ymo1?=
 =?utf-8?B?OXpXK1pDUUdzOWF2Y3ZPOFFQb0ptUDBOMWkwR2tLeUhiYkkwSFQ2ZThMeVM0?=
 =?utf-8?B?aHBNZWVYUDkyY3IrZ0JxOFY3WHFrZjFlZ2IxZUZvRjlXWEVPYS9OZzZtUmJ1?=
 =?utf-8?B?ZmNBMWttRmhZOVVFZ2xrc29UY21neUhGUStHZ2kxaDd1Y2crNHJ2ckx1VTV6?=
 =?utf-8?B?aWRSNDNGbC9ZdXc2amNvWk9QNTgyeWp2emt4dHdsbmZJOEQ5U0JlNG5JQVEr?=
 =?utf-8?B?TU9GU0tQd0hZdHFIZVpaRklVOWZ4ZWh4cE9rTUtkUUJkZXBtZmFQOFQ4MHNO?=
 =?utf-8?B?cFFodTZHOUxqRER5bU5VdnpONC9JV21hQW9tSHpQU3lkMTc3Y0NxSkxOdjRT?=
 =?utf-8?B?R2FmNW5mK1ZpZ0xzbndHV2UrdTVCWkoyaHgrNmNmOHFXZVFxU2NDQUlqR0lz?=
 =?utf-8?B?VU04NlNYbGRhOHFjcVozbk5UU2FjRmt6N2ZlNzY3aGloR1dhNlkrLzNnUFFu?=
 =?utf-8?B?UGFiVk1Ta0Zic3QzSnNGa3VZbldZZ1Vqb245Y1JnN3ZURCs4YzdwbzRCM0pq?=
 =?utf-8?B?alJLcS9IcGhPSXEybm43RkE4dUF3Q3VYSTk4aUNMczhadDl2NjVtSGIvODlG?=
 =?utf-8?B?YmcrbGcyMHB3dzR3eTYycUJQSGNOWUVuZkJ2ekQ3dW1xR002SUtzZ3Jma1c4?=
 =?utf-8?B?aGplYjlhaForNFMvTERLSjRtcDg2azA0Rm1qeDZGc2gram5aZm51c3ZEd3FU?=
 =?utf-8?B?TWJUZDRCdHdna3dEV3VoajFLdDYwV1M3YWhhR1FpM0t2Z0JBeUZFSXAvc0FC?=
 =?utf-8?B?VHNOdGhwOW1hTDFRKytDMk5FdkwwL3NGWWtncEtoRk1VV2svSUlTaWdwTmJJ?=
 =?utf-8?B?YUdoMWFtRlhUNVg0QXg2cmNhMllybHI3SnYzTmNIY0hsWXZuM29vNThuV2xH?=
 =?utf-8?B?NXdPaFVWT0FCbFh0QmE4M1E5UHpKYzVMY0l0RG9MMDFvazZRV3h0TjhWWFRE?=
 =?utf-8?B?MFRuVWRoaTR4Smd6QVo4WklaM0ErZ2o3Rk9LV3RRdVhvdUVGenZFWDJzdGlt?=
 =?utf-8?B?Vy9Ya1JFNG9nRThIekd4VGlDd0MxWDNvYVhiaWdObm13TVMvOVZIRHdRTzMz?=
 =?utf-8?B?bFJzRjF1TGtVaWZ4aHN5K09KUmZSYTc3RlgycXR5L2dZQ1BHUk1kdzE0THV6?=
 =?utf-8?B?Yndzc2VpcFEwYTl2VnRLMDBqNFZsZnpiVnljL3JKWHNMVjgreHRXWHR6SlNx?=
 =?utf-8?B?Z1ZkNVBWK1lDT2NyM0NkU3M0SEpLUEZmQ0dpUGtnVDR3M1hyTkJJR1I2bEF3?=
 =?utf-8?B?ODVQMzF3Rk9BRmVjeVlRK1Z3ZDNVUTkzR09veHgvUzltc21LZEt2UVZSV3Jr?=
 =?utf-8?B?UjU0TmxtdXNJT0tYRnM2dXdUcU43MGRHcWRqQVFiWmFKS3hjQnZKalVMd1hu?=
 =?utf-8?B?blI5VHZpeGF1a2d3WDJNeGpaemEySUo1SVRRL2JVVFMvcHhCWWhGaUVic2Vo?=
 =?utf-8?Q?W7udhZoXlQVYXeJ0x0QhfdH7KxUK31VeADlMvgy2Lgks?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D2D1A4017B4EC4DBEB5E6A0EDCD5DA1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3083c985-27d8-4071-3a65-08da5e4ebbdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 06:22:27.8619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mEY/SedNJ/JgaEFL7amrHfr+Z5cmkgOAKBEzstUK9MWLu7XaQo6gWcGGxNk/ImOS5brrFAedRLuIVd5ekU5DEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4523
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220704_232234_883085_5CC3B6F0 
X-CRM114-Status: UNSURE (   9.18  )
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

T24gNy80LzIwMjIgNTo0NCBBTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IEl0IGRvZXNu
J3QgaHVydCB0byBsd2F5cyBoYXZlIHRoZSBibGtfem9uZV9jb25kX3N0ciBwcm90b3R5cGUsIGFu
ZCB0aGUNCg0KJ3MvbHdheXMvYWx3YXlzJw0KDQo+IHR3byBpbmxpbmVzIGNhbiBhbHNvIGJlIGRl
ZmluZWQgdW5jb25kaXRpb25hbGx5Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhl
bGx3aWcgPGhjaEBsc3QuZGU+DQo+IC0tLQ0KDQpSZXZpZXdlZC1ieSA6IENoYWl0YW55YSBLdWxr
YXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

