Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15119C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jun 2022 05:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hoR1w3sA3lFfbzuSLXb/TbJiQJW7KhFuFqCTLfOkaUE=; b=GuNvtp+3mrTHtvtXZJ9ic5kr59
	bnY48wbRwsdCXTk8h3woh293cvV/N+FYf8oOSS0JmpLY1ylMa2WRqIL/FQ5GmUexLtOB2FQ3rPVId
	5ISc2kQsS0sRkytYmUvS2f1s04nVnwX3V0qCkEIkwvkh0Nzkq7JjHVeLx1vKn+y8ZXnKorP4DLBKN
	cxsVRc+ahAPQPznPTrq46gSY3Qnf0dXSHtXsomqjimWRGbodZiN4urG6ayzT7fJhSWnTNT/qKbejP
	n0VZF4dI8FfyQDrPrJi9NQO+xLnS9eiUf39YVkva7FigstDFPljb1/6bUBSXz2xdZNWXL6/QwSFyB
	wa8lw4qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nySDG-004ttV-Of; Tue, 07 Jun 2022 05:57:10 +0000
Received: from mail-dm6nam04on20615.outbound.protection.outlook.com ([2a01:111:f400:7e8b::615] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nySDD-004ts1-VV
	for linux-nvme@lists.infradead.org; Tue, 07 Jun 2022 05:57:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKvIfEL/PKkJBpLww8eCVutvboXakYyk1Hn21HtNBIu/kpwfpPupT6FGwpXKwhzJkaDZ9m+1TyK6wzBuZ22u4xZI9dpy+vtc08YrebU8/qgt5V9DgE3zACEuHwo1lAvMGE/emP5qM9XOapaYk1KD0dtejH65QibpzaVctL+PapicjszSUF+9ZUGqESa8wW2le8qYdRDwTSGqRUsThoXNspcCiMncFWo+5ZJ+/8WtEyDqC2A5howR8CUF1BE/rVMC/UtNDQhUZNu1ou7xKF5BT9xDcinaKzcAzCgqO+TmxuGhU6OKGjvbblNduH/IzF3c4dLmYbu65LABxvKCX8J0eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hoR1w3sA3lFfbzuSLXb/TbJiQJW7KhFuFqCTLfOkaUE=;
 b=KY/vm2p7rxeN3r5QANpxJwoM5JMZU99r2zH1ZPtkQZdbuh4HIjbFcrAvALlWuS2wBk2ZZc69kp+T/1P/FbTCIABk6EMjxUN8+O3vhCWAqbfl0GwHFSYZCFfI7VETRyUfSVPAAjQAMAbsie+pz0mFxJ6gnGpQRVROMggu0HyRjk+20S+LtoQ3/p8bd6NW4xy0o9jpRQ6YnNuj2ImSQKtmtxOkrLuWgzWVJ3/gWZnVfb3gxcNCPN3Mg11JIDjj6EEHhW3/5y1NtxqHsDLiGowIqLOQqEQ2bG6y+oKPY9ASh+Sr0+DaQXvww3RH1DU9DIh11xN+idhTJdB5/NPL6A6M+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hoR1w3sA3lFfbzuSLXb/TbJiQJW7KhFuFqCTLfOkaUE=;
 b=kZxuxT8nebyVaxKB3DW0o55alIyqwyN/d7n2Q5AMJtz1Jv/GmpfpSGe9M8cc0ToHe/MT94yiL0lQRTrAflPBSuyZYTYRMM+bSJNd0cNFwr//lHACvGBJDtWeGID63XZDJmqfUczCBjTS65tXNHv1lZf/pu+xTTNupr4bYkiTiwsooLhYMDjR8VpVlAO0gS4rdAjVPczKw5xN5kjGETtJEamsq1BvmSZ3t19KRgOLcO8PtO6lrjxTIHW9kVfZ8+DV8pimtf80enEGZcxC2ep1BfQIYUvZvMkWCAEcSD5dY1XQHsqFzIckYnql6LE8VqwqRrqu8N5A3iOK25ysbnG1xA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1200.namprd12.prod.outlook.com (2603:10b6:300:9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.18; Tue, 7 Jun
 2022 05:57:02 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e%7]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 05:57:02 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"james.smart@broadcom.com" <james.smart@broadcom.com>
Subject: Re: [PATCH 3/6] nvme-core: remove qid parameter
Thread-Topic: [PATCH 3/6] nvme-core: remove qid parameter
Thread-Index: AQHYegxdGRv35/pX2E6QMmqQB/oc5K1DXRoAgAAVnQA=
Date: Tue, 7 Jun 2022 05:57:02 +0000
Message-ID: <ed876e75-c6e7-ee2b-fd3f-e87daa4d5179@nvidia.com>
References: <20220607011647.24105-1-kch@nvidia.com>
 <20220607011647.24105-4-kch@nvidia.com> <20220607043940.GA7847@lst.de>
In-Reply-To: <20220607043940.GA7847@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1296df57-3728-4366-17a6-08da484a8b2b
x-ms-traffictypediagnostic: MWHPR12MB1200:EE_
x-microsoft-antispam-prvs:  <MWHPR12MB12009E2A9A1B35D292F45ECFA3A59@MWHPR12MB1200.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  wHGvBXFG5BxPOjsAAVcyGp7DXxPO6DsQrUfGL8ibgf8Y+3jG6fz+zi8yHCrK0QrIPkRcTqI/L42f38zpRCKFUEcH5Wbrf3xSMdyMTy0b9eZMsBKd8mxBLJ0M3lA1giJ5zHDDiuLy+GsxtOF/k8EvTVCEs8Gfr2DNjgdgv17V/DCuzU+88vBocZeKJLEUPFX4s+pWOc5RcCol/SLPzQJH7A3oTuTD8xl2COhnSIUwCmYBM3W+DUSQPUrK1tnxR8pS7jC2jH6Eyd8A3f5iDtPHezUcN7+DQ4jxOG/KehRoUPSpn/qL2AFIH7uuZ1OvcesjEXCTV3oPvVg+7T1Q1zMgtfmYulZ1IEeDxl0ENGFVsLsiKM4IwJbwzwRSqwHdFbJWQ6+6SeVJuxsow1sIcHrnTw5ezEXUy1C7wmpTz6ls455bIfIdfe6JMFSiTQYBJAy4oKyTS1thusW0utlxjHk7ao01CBWC/x7AY+8C0oxgeese7rSNdWIhUElcNveRW9QI/ol8THZzEctUBgO7FvwfyBKYqD9kiz8m7d4MdO6u8VKOTV+6Zh0HvJ1GFU6lt1/e1K4UExdxuCjbGfrbAJNlVrBH1Dn0z4rpcldA8Cg4xMx9SAlSfjDlJWx5or7bO2makf69LT3zhtcS+yMWOkUZQlXwov38tM66t1qOi9W3/fizBcetnnhrqNQsoyhAX0mOy+qe3/niIFvj6vZmS098h2AxsbU6Y+vhLnfrk/Oh+3osiW44EnCA4TRHhW+ROMEzR3rL4ArmlUAmg5YC0Gb5Wg==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(5660300002)(91956017)(54906003)(6916009)(38070700005)(66946007)(31686004)(8676002)(76116006)(66476007)(66556008)(66446008)(64756008)(4744005)(4326008)(508600001)(316002)(186003)(71200400001)(6486002)(6506007)(122000001)(53546011)(31696002)(86362001)(36756003)(2906002)(2616005)(6512007)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?YXZaZWVOTDJMb1RON0p5cDYrdW1CMEJpVFFrOTlOcTk3ZjFTWVlFUHdJdXBu?=
 =?utf-8?B?dEFtY3BCNERIQk5USVd3ajJHbnF5eStXcU1NZ0xQYW5DQ3R4NW5LdGhnNFdE?=
 =?utf-8?B?bnZlcVdYazU5NFptVW45YVBCbTNyRlFYSnQwdUlyYXNvQVE1ZVVIZjVSTnhh?=
 =?utf-8?B?VnJ5ajd1VXJrOFhoc0dCamZBV1pGWmJzOUJYZ0dEbXBMMHl3NnZrK2EyYVhM?=
 =?utf-8?B?OW03WDNGdGhuUk9DckExTUJMOXVLSGhiQ254ZXVyTG41bmxaVmFLRENESFB1?=
 =?utf-8?B?UDFhQjZWZUdQMDNvM2ZhUkwzYktiM3B1V0lLRnNPODlOL3VQV1NRMURmUGMw?=
 =?utf-8?B?SUtrOFBhS0o5b0t1SC9CMk5sMjQ3bktWUGlVMDMzTitrQmpZbm5va1FuQ2li?=
 =?utf-8?B?OGJuRktkNWtyK0Rmd24vWExSRnZ6MmtNUlVtOGIwVldoblc4Um9UNk03WGVm?=
 =?utf-8?B?Q0Z3c050MFB1MWRwTkduempJaVFxME9CRWFmbTlhdU9OTDBaSXcyUnl3Y0RO?=
 =?utf-8?B?cTRoQmtiWWhCcjdEemZibGRmbVpka1JTem1GUEp0ZWlBb3BvVzFudWh1Ykh6?=
 =?utf-8?B?a3dkNnZBaFFmSXhiTGExRVZNa1N0UVRsR0JnY3RWZ0cvNUJMTFhsdnFKWG9N?=
 =?utf-8?B?MEwxaXI5bFIrMjFvcS9DQ2J4c2FQWGhkNHFSQzd3Ulhub0pSdGpmcldtZEN6?=
 =?utf-8?B?UytWSThpaUptV1IzTlVLTE9xeVV4eG5JcFFxeTJMOFBydER0WWFIczkyRSt0?=
 =?utf-8?B?OEp4YXU4ZlgwLzQvSFhjRENZazRjMS9EdmJ3YTJvakdrT25JOFpvZ2lxbHpp?=
 =?utf-8?B?Yy9tZGxLcmVzMnFxRVYydHdWS3hYcjJnWk9jVGJHNVBvRVdQejFITjBQeGtv?=
 =?utf-8?B?dDFsVDFIejBIdGRNSW55MG5nNFV6T2twMkpKWG5VZzNhTlhMZXltVW5iVndM?=
 =?utf-8?B?aUdGWVVwRTRoQ3VDRStLNmdQSndrNlgrQm1yU0R6dUQ2cjFQd2dxTFBKTitI?=
 =?utf-8?B?MERTOWhCOEVrTVNKdUFkTzFzMGNNQVhic2hjQ21GNDZlQjJLSzdwcDdnL2tU?=
 =?utf-8?B?TmZlN1NpQmJBTStIOVRKY1ZOaHU1RVBIZmVMUjBxcWNJQ0kvVjFXbVI4emZv?=
 =?utf-8?B?SjNSeUcyeUFpTWxCTmRqQ3Z4b1VMRStGdnBpUElzekVyWGdvQnlHRGIwSDNC?=
 =?utf-8?B?Q3liSG9VMkxOQ1IzRnZ1U2dmQ20yazRjZTBFNkcwRUtYVTV6ZE1MVURFZ1VC?=
 =?utf-8?B?Wk5OTitzYWhCa2twRnBMd0R0K3hSTW1ZeWpZVXhldXBaNkNvczduK1RTTnNV?=
 =?utf-8?B?YWtYek4xWFJyM0JTVDFtVDRoM3l1ZWRzTTF4cStWSURUZjNJMUp6dFEwM1RV?=
 =?utf-8?B?dzZaamFXVmo0NExmL0ZKdFl6RS9hU3JCM2ZvU2kvK0xzU0NuN3h4elBYaGlj?=
 =?utf-8?B?clcxdU83NGFiMzJDUzFqQi9CV3FVS3pSQ2tsTGhXVE5Jdm1qMkdIVVRyeXVw?=
 =?utf-8?B?ZEtZS3VsSTFRUUpkaGtnT0dkNk1rK1hqenl6K3dZa3dlS0tBMnBCbkZ5T0xV?=
 =?utf-8?B?YUQyb1ZqVDhoNTE2WUZzYmRWT2dYMkgvZ3gvUGQ2c0J0WldZZHV2cGUySVh2?=
 =?utf-8?B?QkprNnkwVnQxOExlSG5BLzAxTXpuZEUvV1M2aUZ5K3cxbVA3UmNOR0g3cWF2?=
 =?utf-8?B?RkliM1F0MGkxUnNyemFWNGNDVUw2enBOMUNBcUQzdXlxV2hOL3RQNnRJS2FN?=
 =?utf-8?B?RUtPeG9RYytPWGRNQlUzVjhNSFJXSzlwcWY4THVSTnpuRWZtMm5pd1JLdk5h?=
 =?utf-8?B?ejBQcXNlV3RkckJBblFkU0pJenNVRGg5TGdxcnN3ZXFBZjFPTW1telhMVkw4?=
 =?utf-8?B?RHZETTdGYlRVQzVKZWJ1dkpFRjBOQk5IclczTEdGc0lOeVNZbUV3WHVEZmsy?=
 =?utf-8?B?dGoya0FyRlpmM201Tk1wc0VKd0Y1TUF2bzhOMFh2aWJsTXRpOXg3RkxqSWlB?=
 =?utf-8?B?UGhkd3EyNm5HU1BaYytZTVdCazJ1aTBnd2NBMGVZTzBqZjhtdmFsYlYwRFNp?=
 =?utf-8?B?SWZyNXhHclRhclRqSGdWMllrZ1NCeUpKSGFXQ1Vmb0puZFArNysrOUhwMmRi?=
 =?utf-8?B?RmJ5Ny92ejh4M0p4TENoNEhtaGh3eVRxYnZCV2p3NzhSekVQOTh2L0t3eEll?=
 =?utf-8?B?a0R6Sml6ODFZRElnWTNDOHZET1I1d2dYQzJJQlBodVN3K1B1TkdLQnV1OGkr?=
 =?utf-8?B?WEpoc09LanoranI5cG1jWlpEMHd4Ni9XNHVTOWVpT1doMU1RN1F6UlI3L1Ft?=
 =?utf-8?B?TjFHQk40WWhKNWlNMVdwT2ZtQ2VRVVBjeGxGc0Qxd0lycWZGQWhlRGVnZm84?=
 =?utf-8?Q?R/NOTts91KuuPhKJYTS5lqkc+Wl9TMq5XFhQHtDnY6lO8?=
x-ms-exchange-antispam-messagedata-1: wX3swhoNqEAvxg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <16D46896F637424C8CCE3F2138C60FC1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1296df57-3728-4366-17a6-08da484a8b2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 05:57:02.5358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gg4DaJeMzLNodm9cxr7Dv7QA+kk7XaKU7zyWEM0WaG4PvV/+bSBrJcS2g1o4ynQvaJj7jB+iFEaMtZJbE+XIRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1200
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220606_225708_264997_2A7B7115 
X-CRM114-Status: GOOD (  12.48  )
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

T24gNi82LzIyIDIxOjM5LCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gT24gTW9uLCBKdW4g
MDYsIDIwMjIgYXQgMDY6MTY6NDRQTSAtMDcwMCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0K
Pj4gV2UgY2FuIGVhc2lseSBkZXJpdmUgdGhlIHFpZCB2YWx1ZSBmcm9tIHRoZSBudm1lX2NvbW1h
bmQgcGFyYW1ldGVyIG9mDQo+PiB0aGUgZnVuY3Rpb24gX19udm1lX3N1Ym1pdF9zeW5jX2NtZCgp
IHdoZW4gaXRzIGNhbGxlciBpcw0KPj4gbnZtZl9jb25uZWN0X2lvX3F1ZXVlKCkuDQo+IA0KPiBU
aGlzIGlzIGEgcHJldHR5IGhvcnJpYmxlIGxheWVyaW5nIHZpb2xhdGlvbi4gIFRoZSBsb3ctbGV2
ZWwgc3VibWl0DQo+IGhlbHBlcnMgc2hvdWxkIG5vIGtub3duIGFib3V0IHRoZSBjb250ZW50cyBv
ZiB0aGUgcGF5bG9hZC4NCg0KT2theSwgd2UgY2FuIGlnbm9yZSB0aGlzIHNlcmllcyB0aGVuLg0K
DQotY2sNCg0KDQo=

