Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF1AC0015E
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Aug 2023 08:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nhisd77IGbbZy1y9H7C8vFAjHxiE6cu+U7RWv0owgHI=; b=wOWiIh0EIEzgLEleAhAO615xPM
	i5voocA8GNyzau+xIw8RrANQ26D8OH66Ywjx3WQ0CcdbYIiCi/bws9/fJrDZBat9qP4Ei7VOiz7Lp
	QgoPuzi0Aae34wQjPYAb/EA7PEjAmP/3T73RtahCGfNZBjnWJSMfVuPho3J7DsAnGBIin8jZU1pKw
	3lZobqwYglQg5TZSDIcJXdm6DSFlxJBJD/Oidu4U7cRvswWoRW4kpIWzfOvG9E1vhPWDOkButhVEK
	ZjSMxuXIXCj7Poytodrk2+pNb0NZfoU7F9wM2yDHNXuiZbINiXre3ebhm9OZp+wK2uMTsK/3jHD3R
	Ob3GiHYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQki5-000elZ-16;
	Tue, 01 Aug 2023 08:26:29 +0000
Received: from mail-bn8nam11on20700.outbound.protection.outlook.com ([2a01:111:f400:7eae::700] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQki2-000el9-2d
	for linux-nvme@lists.infradead.org;
	Tue, 01 Aug 2023 08:26:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQuYseyZ/wINJk0jATNZzDLpfqIBpgGO/L16z6YNmG7XmbtSjahmZYlkip/XxA1bMIOwnOOzVKrGBRMNpwN6Mygs219JC3QmItZeqG4PVoQQ929CGGkisdgKnKzp7EjHEJsJZVq0sWWMh1tbz3EMQgCDMqrfb5HI24JJoVbJuHRVPmIDgrXTeXWJBYhfK4WZEZ1SUUE3BkpLU9ulw/pqRnj1aaan9kHXW8PASvrOmX/srHFd2XhYfsrQyvG61p15/BbvhLyhDpjtLfYKU9MLojc1UQuysVrraFODvRbDaP7RmSnC93AxGB4KD7p8r1fanbOc++nb08D61dXxM06tpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhisd77IGbbZy1y9H7C8vFAjHxiE6cu+U7RWv0owgHI=;
 b=JPyvsXPyjXt+LjY1qGtvCDykVsoG8mzNo0iMGCPQtlMjUA3jl2N0EXctO2bjFiFKZxoPA82JMuTCTkCiIBfsoDTD670w8IHrSqwrz/j9Pzsmzw8WW3+AVsTWhTfhTJdj480qu8AiNxVM70TWYfymu0JCOpo7AjlszV5tNCG4EJQ74snRhgTt+6spIMjsX9FjTT6Yl+hp74WSBEKNquZ10EqgC/XJg277AVVq9kJAeleAN4uGSbbyoClmVOu+DtRDA0osyTWiu5HNtW0k8EKNf2REaNHvSF4NRvvZcJvkrajHdTAAgUl9NBmESO/kEV0FJFzQ4UeX++eFfxmC+j7nDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chelsio.com; dmarc=pass action=none header.from=chelsio.com;
 dkim=pass header.d=chelsio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chelsio.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhisd77IGbbZy1y9H7C8vFAjHxiE6cu+U7RWv0owgHI=;
 b=VBDY6Te18WfDs9cydAK6j6QmrDnI/M5CmsXAZgpBCoiCvdEpQYr9yi8KGVsbKwDb+sVD/0w8V5bRMVMdihFEabo3V92sNuiw6BsiXN9IjfxX3mLT8vO24OqTyRvL48iHYCeIdFS2fnK15EDmsPKthF5nmFLE9EUdEdah8v1pjDg=
Received: from BN9PR12MB5324.namprd12.prod.outlook.com (2603:10b6:408:105::15)
 by IA0PR12MB7625.namprd12.prod.outlook.com (2603:10b6:208:439::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Tue, 1 Aug
 2023 08:26:22 +0000
Received: from BN9PR12MB5324.namprd12.prod.outlook.com
 ([fe80::8274:86cf:1c54:8af3]) by BN9PR12MB5324.namprd12.prod.outlook.com
 ([fe80::8274:86cf:1c54:8af3%4]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 08:26:21 +0000
From: Varun Prakash <varun@chelsio.com>
To: Sagi Grimberg <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Rakshana S <rakshanas@chelsio.com>
Subject: RE: [PATCH] nvmet-tcp: fix data digest calculation for multiple
 H2CData PDUs
Thread-Topic: [PATCH] nvmet-tcp: fix data digest calculation for multiple
 H2CData PDUs
Thread-Index: AQHZwJh5rpnC9OYkIkStRpfynSON8K/T6hMAgAE3H/A=
Date: Tue, 1 Aug 2023 08:26:21 +0000
Message-ID: <BN9PR12MB53249ED623D6024129237F03BC0AA@BN9PR12MB5324.namprd12.prod.outlook.com>
References: <20230727150731.5905-1-varun@chelsio.com>
 <3e08284a-9163-a83f-b7eb-e5b697e45947@grimberg.me>
In-Reply-To: <3e08284a-9163-a83f-b7eb-e5b697e45947@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chelsio.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5324:EE_|IA0PR12MB7625:EE_
x-ms-office365-filtering-correlation-id: bbded42b-6527-4b57-b937-08db9268fc6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Q9wMu2zVktEOi4cYN9G5WlqoZVI3yXdyG630Nbeg36yimK9Gwad9AsZbMAxrEyF++CaV9q0d9uOUYpZZPjhvD/Cw/sevd3iw0JRWcso0fwE2gxy+duaQgDQ8HGyopabXr/jXUvijvxvVIdeKay0SMc70fI14ZbhI/yE3wPOPN8T5lMkUKVKm7NhIDyILVKNteuoG0OA5beRPLkhpIBH7svHoA07GFgt5lavAinZDxsy0M/QBDKJDyYPZOW84w+aKctZm8Jw82sWIu19R6DSMMoSFWi3q/ctSvW/Vnwe6chCVFYXC6MZkutWuYyCX9lBp0w56d4EdM9j0L2Ig5MBqhiMfcKDDbq+2ILV6aoqRdH1/CA7/0zWdc8WvLoG7LGV+gB7MWWYNGo0d/m8kUjoaGoA7uRPjxudLrNZtBm6xau/Bg8788mb4iUzAqURiL9VRcNBNeewn7tliwdl4Djzz7V7dZr0gko5LW5lnN4xASu2DoAd1Hnp5eWdBKFlmdo0ks9ojLFrBzrUDnq7V2ReKVrW/sqs6uQLbu3ZXkj2HSvwDaDT2j02W0KlN2WFE7/Pp5zLEyNFDBM2Iq3hx3SLm/HGcvHVTAEcRYdDeQF4gGYCBCLttA/rGszUBMhM2GAF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5324.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39840400004)(376002)(346002)(366004)(396003)(451199021)(478600001)(38100700002)(122000001)(55016003)(86362001)(33656002)(38070700005)(9686003)(71200400001)(7696005)(186003)(107886003)(26005)(8676002)(8936002)(6506007)(5660300002)(52536014)(76116006)(4326008)(2906002)(66446008)(66556008)(66946007)(64756008)(66476007)(41300700001)(54906003)(110136005)(316002)(4744005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjJ6cEpwK010ZGJnQ3R2ci82aTUrR1d4QjJrSHBtSWdMcVZmY3pjQndEczZE?=
 =?utf-8?B?M2dzSzdFSUtCVXkzdWJ5eFJuUDlpUGMvT09rejhIUXVSdWZRS0xBT0NtT1dY?=
 =?utf-8?B?YlBZVjdUKytjNFBYakFWUUMxMzdRY1JYQ01IaDNrT0hncElMWkxMQTdlLytV?=
 =?utf-8?B?NW5QTGVRYm9ycVo5UHdNSE9mOHBLeDIwdWdxTVVlbk54d2gveGYzNmlVTndw?=
 =?utf-8?B?aUlDaVdIblFGM0FUYTcwNkgrNVQwRG1LQ0RMWFFjaEt1UkNiYWEzcUN3Yk5y?=
 =?utf-8?B?dWVFTVNRNE1lYnA1TXZTcUQrTUVkNng0Y2RqZ3lRTUtobzR3YWdvN0xvdlFE?=
 =?utf-8?B?RlpVSXI0dVRQZXZLVGFoc2t6YjJnZSsxK0JYM2ZvdWlyeHRxUjhBSmNaYzQx?=
 =?utf-8?B?RW5QZnpVSndsQkFPcmErZWdXTGdjRXFiOU40R29Ed3Y0dWN0TWZtdGFobU9l?=
 =?utf-8?B?bmNSTHdyTlEzQXlNTDFpeDlkUnlsMlRQaWE1eE83R3NjRXBPbXMvTjhxbjRG?=
 =?utf-8?B?WEtDVm54TnZEM0krQ3JVZ0RvQ3BOTDYzalhMU29uVlVMYmVrWDVLcGxQZ0hR?=
 =?utf-8?B?NUNyNXdEWDluK25CTVdLS1g0NGZlVWpIelZwNkQvTFNjckJ0UkVlK016Z0c1?=
 =?utf-8?B?NmpMWEtoQXA3Si9JVzdnc2pGd1l2RDJkOVBPUGxsekZBL0QvNU1wZlZPK1kz?=
 =?utf-8?B?N245aWg4UXM4NGZJdSt2OHZmUTZ2UVozcmZ0TGVmbDIrMGhRWFZJb2FzeTJG?=
 =?utf-8?B?VXVDaGJsQmxTU01LNjNrdDdWWExGSTZvTkVuSGt1VGk5cklhTGZTMEZNcWZi?=
 =?utf-8?B?ejF6ZG9qR3lwWDNua2V2M2hTQytlRGdhbS8zOXJ5a25nOVltVlk5TjJVK0hK?=
 =?utf-8?B?ZnJSMUxBcVc2RGVvVFJ2R2kwYTR5V0duNGVBV3VlSk9sY3ZoZzJJRkUxUW9N?=
 =?utf-8?B?dEFKUmJvMmI3MGR2dDkxOTRmSFRWbTNGM0pyVHAySDRoYmVFdHlxSGd5dGk3?=
 =?utf-8?B?elE5b3c4by9jbS9PZDcweTFZOXlqRFdLYUF1Sno3UHcrSFAzY3ZVazkxbncr?=
 =?utf-8?B?RjN2NGpXUTZvdU8xaVZmRFRkeUZ5Y0tmSXVTU0xOVks5WS9jd0pYWXB4ME4v?=
 =?utf-8?B?RXVJYjdkRjUwNHFad3JkZXpPT2tyMHZOMk12UXduNWVTTG5mVzl5ZDdjY3JT?=
 =?utf-8?B?OW01RlJjbUsybmJWRG9SdUthVEJ6NmVlZmtWbGRXRnJ5b1k4Y3pWZWkyaEYy?=
 =?utf-8?B?OVI1eW1QZmNLRWZjbmJRVE5CalpldW1KNytoRGMzdmJWTDdGdlVrcVBmMG9o?=
 =?utf-8?B?YkYzandreXJKRU04M0lUZzdQRlBaTnVjQytUSk1ORUk0U0owb2JxSEJ0SGdx?=
 =?utf-8?B?dU9QNFZmbDZBZ3NNY0N6RWsreFJhMmQwQ095UWp6am9xVHFzSkg1Q2FRaUFY?=
 =?utf-8?B?TTl4OGNhU3dvalo5TGg0bm9IcUhHY3ZHZEg4WkE5TnNjTkJVMG5JM1REQStG?=
 =?utf-8?B?c0p3ZTZCblNvVWZwYkdsTjgyelFKUGZzZnV5WXEreUljL0t2eEVuWk91MHBW?=
 =?utf-8?B?QjRQbVZTU20xTHo5N3JNb0ZjVWl2OXpTU0htMXVBWnVNb0pDTnU4aCt4K3Z6?=
 =?utf-8?B?SGtha0ZRRld1SmdGdEszSDM0eU51bWR1S3kvUXVuYzFiZ2txbWgvMFYxOWZr?=
 =?utf-8?B?VlplelBLbTA5V2NKS1VLNUo4RXZOSG1sQ2paZzZpY1hFTHlTRzdkOEVqbnQ5?=
 =?utf-8?B?ZGMyN05Bd2s1R3NPUFRKU0xjVXF0YmtJTFFjTnlROTNlT0VZaW5EMGtEOCt2?=
 =?utf-8?B?bFlIZTFVUHhzVC9hZWdKcVFPamxLZXFKUWZ2REY4Yy9COTFhMFJldmdXd1hh?=
 =?utf-8?B?V3JkUVFKZDdnaVNSdjl1RU5DR0hjMVgvU0RBa3RJS3ZvREtHcGY5ZmJTWXJ3?=
 =?utf-8?B?ZlQ4clp6MWVHMjF1aHM1cFM2WTZrTzVwL09COXZPMzNOa2RhN0xMem1xNHhu?=
 =?utf-8?B?b3FqbFczdjR0TWZrQ1ZRSkdDR1gwcDBLRzFkUk54Y1BjeDNSaFJSSUV2RzE5?=
 =?utf-8?B?MlYyVlIrQ3BtdUFhSDRVQWQ2Q3dRUCt0V0MySG1jclFKNlcyV3J6SnBVMm85?=
 =?utf-8?Q?blO/p17PSa6Nl+tAzKPE1UQS3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: chelsio.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbded42b-6527-4b57-b937-08db9268fc6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 08:26:21.1922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 065db76d-a7ae-4c60-b78a-501e8fc17095
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: et8MspD7BrtbB2Fxh1J6/C/8QpCF2F6dl1Ra9HE0kxyDWOc44/GQe9WjI+HaJaD11tzXMbk5WKBv2E9HKV9z5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7625
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230801_012626_857054_8C5919E3 
X-CRM114-Status: UNSURE (   8.01  )
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

DQo+TWF5YmUgaW5zdGVhZCBvZiAocmUpY29kaW5nIGNyeXB0b19haGFzaF9kaWdlc3QsIG1heWJl
IHdlIGNhbiBkbyBhDQo+bGl0dGxlIGhhY2sgdG8gcGFzcyB0aGUgcmVxdWVzdCBzZyBmcm9tIGNt
ZC0+c2dfaWR4IHdoaWNoIGlzIGFscmVhZHkNCj5zZXQgd2hlbiB3ZSBidWlsZCB0aGUgcGR1Pw0K
Pg0KPlNvbWV0aGluZyBsaWtlOg0KPi0tDQo+K3N0YXRpYyB2b2lkIG52bWV0X3RjcF9jYWxjX3Jl
Y3ZfZGRnc3Qoc3RydWN0IGFoYXNoX3JlcXVlc3QgKmhhc2gsDQo+KyAgICAgICAgICAgICAgIHN0
cnVjdCBudm1ldF90Y3BfY21kICpjbWQpDQo+K3sNCj4rICAgICAgIHN0cnVjdCBzY2F0dGVybGlz
dCAqc2c7DQo+KyAgICAgICB1MzIgc2dfb2Zmc2V0Ow0KPisNCj4rICAgICAgIHNnID0gJmNtZC0+
cmVxLnNnW2NtZC0+c2dfaWR4XTsNCj4rDQo+KyAgICAgICAvKg0KPisgICAgICAgICogYWRqdXN0
IHRoZSBvZmZzZXQgZm9yIHRoZSBmaXJzdCBzZyBlbGVtZW50IGlmIHRoZSByZWNlaXZlZCBieXRl
cw0KPisgICAgICAgICogaXMgbm90IGFsaWduZWQgdG8gcGFnZSBzaXplIChhbmQgYWRqdXN0IGJh
Y2sgYWZ0ZXIgdGhlIGRkZ3N0DQo+KyAgICAgICAgKiBjYWxjdWxhdGlvbikuIEEgYml0IGhhY2t5
IGJ1dCB3ZSBkb24ndCBuZWVkIHRvIGRvIHRoZSBoYXNoIGRpZ2VzdA0KPisgICAgICAgICogdXBk
YXRlIHBlciBzZyBlbnRyeSB0aGlzIHdheS4NCj4rICAgICAgICAqLw0KPisgICAgICAgc2dfb2Zm
c2V0ID0gY21kLT5yYnl0ZXNfZG9uZSAlIFBBR0VfU0laRTsNCj4rICAgICAgIHNnLT5vZmZzZXQg
LT0gc2dfb2Zmc2V0Ow0KPisgICAgICAgX19udm1ldF90Y3BfY2FsY19kZGdzdChoYXNoLCBzZywg
KHZvaWQgKikmY21kLT5leHBfZGRnc3QsIA0KPmNtZC0+cGR1X2xlbik7DQo+KyAgICAgICBzZy0+
b2Zmc2V0ICs9IHNnX29mZnNldDsNCj4gfQ0KPi0tDQoNCkluIGNhc2Ugb2Ygb2Zmc2V0IGluc3Rl
YWQgb2YgdXBkYXRpbmcgc2ctPm9mZnNldCBjYW4gd2UgY2FsY3VsYXRlIGRpZ2VzdA0KZm9yIGZp
cnN0IHNnIHNlcGFyYXRlbHkgYnkgdXNpbmcgbG9jYWwgc2cgdmFyaWFibGU/DQo=

