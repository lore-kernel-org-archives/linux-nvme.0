Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B803C77B70
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Mar 2023 05:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5tnlTrn+MhfOFmN9ARWWNMTn5/GV4KqoeRhEVHngsuU=; b=tLXsV8Xa5YWNkijhzYUeH1rbAP
	kEGlhChNg/wAWFMVb/Qys3nGUJPZKTCV4incehEOSSqlUsZeSX77pHIDRdEfY1w1hXkL/k3L2e7HA
	7Yr1bz1DHXOWfXFKoJb39fFkgqAzZEeoL7/phjDz3zfBTyjMOkdA/LzGmzlwaeidX9CnztJLAcceZ
	cEF4mEoI0o2OUhm6cJvqA/q98sbxOD+/re8ZOBAM5y0tOXjm6bYdt8ugAcw/c1oKZZBNVAyJxCG5o
	hjhWE++ZOsv7WcJr8dIrRlj9NitkAZ57OzenIQtgr6/u0B/rQyYqvp8IkSLk3EthAna7OQP119yry
	LIGtw79w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcJTl-00CMPv-1Y;
	Wed, 15 Mar 2023 05:15:13 +0000
Received: from mail-bn7nam10on2062f.outbound.protection.outlook.com ([2a01:111:f400:7e8a::62f] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcJTc-00CMG5-3A
	for linux-nvme@lists.infradead.org;
	Wed, 15 Mar 2023 05:15:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klf6Wp8v4R2ZmOXDMhcFdwbNQgBBcd6TKjMDL6hgt0C8GRH7qxMOQqqHB+OpCHeqEvabHNnEi3bs+5nihOqEUxrINJ28LWpnWnvdZJijhk+1ZWntFBlW+T75BAPKhCtIgNdxwq+EFLLwZIhymBZsmf7yL6yY7SO48w1tMNFG1om8FPiZwK9hnrAKENYHCRrhxnqfRbIHcB49V7y7SdasZf0YAamMMSmKbEyayIMSypMumPGCbneKJ6k2G28HImYk+p3QdZxnQMQ117rKtIXEE4BF7VYao3FBYb9G32J72eic5ZVMkItz4UzhOPzxniZ1ReNqKfNZsmgwzfNXaeoZmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5tnlTrn+MhfOFmN9ARWWNMTn5/GV4KqoeRhEVHngsuU=;
 b=ZCuEvY3n2bc+kpV3tIFK31fDS5d6HGRsTOo4+M1C8EeZJsIRNkyt9tFivYwgcSrcpxBPutfgZvPfSoPcUdK2VggJABLn4m3QVeX8HAnuEH1MrDWiqFJxaDWsqWDT8qrir46pFOG2mad7InHtTgN7h4n0ZyRfZrtakrAqNj0BItcs645+sW6cYHDGdc9XFqEXugwFHuhZ4SU0pX74gu14H9OClVdSiqiZ6HC5lyhcD9UMWI+2dmWc4mXe9xq6P2VTyHY2e5vmhvrqYNlYA3B3FmunajU9YgxeXCGN9nImieajBDDCfMFoYqz8D2gOYjxE1TPYsqS5tSPio3CS7cMnJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tnlTrn+MhfOFmN9ARWWNMTn5/GV4KqoeRhEVHngsuU=;
 b=ABB6XN05jWJzhttMpgUFPH/kxuCcFRKGH7enPWvXllDFyH5aWh+HCQRfJu9FqVSWfKeFkJ4XeKxsM+ktayEj5yOh9yhq2nqTQWP3t3K1TTtxQnPKVy7y20uDzwmiC87gU6rR3Vscl/sHmRyITgu68wBGE12EgcZPPQCuo+XInDl2p4wI/l3y0XDFu6yp1so7tzexu/Qsm1qHIREajYzmWAAxp2Y6aOrZBgzy7uF10W/JirYMnDxTWEFIBrbYJBAIFj8ayhWMt8J5FHsGb9pszeqpVAwUImEqE4vjxzrgmbo0ygX0zh1Ut8CxJ/xGTTic2hHGuMUcNwhKmEKMKR9eQg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by IA0PR12MB7773.namprd12.prod.outlook.com (2603:10b6:208:431::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Wed, 15 Mar
 2023 05:14:59 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c%3]) with mapi id 15.20.6178.023; Wed, 15 Mar 2023
 05:14:59 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Chaitanya
 Kulkarni <Chaitanya.Kulkarni@wdc.com>, Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH 1/2] nvme-tcp: fix opcode reporting in the timeout handler
Thread-Topic: [PATCH 1/2] nvme-tcp: fix opcode reporting in the timeout
 handler
Thread-Index: AQHZVYnLvmVnVpzHJEKAJTZb9v6VzK77TxmA
Date: Wed, 15 Mar 2023 05:14:58 +0000
Message-ID: <13e36139-344b-73ef-cba4-f2761ea6cc9e@nvidia.com>
References: <20230313085623.9321-1-sagi@grimberg.me>
In-Reply-To: <20230313085623.9321-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|IA0PR12MB7773:EE_
x-ms-office365-filtering-correlation-id: 3dc69274-ebf2-406d-e3d6-08db2514390d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  IHdvcDEvO1hl7FYYnHzMpDU+SqcY8puHf1TSrKtfYyccnf1NyH0M9D2UfsRJXwfb7zxVMe5ZaJUDZmV1kzrKt9HPLNCAw0N3yiz3OgPM9nTXt0M2SijD+3vBmQ2knB7MIbKbUu0mqP81Az7cGWfXdE8/W4ud0SJJYuNnXb93ZhGXp/y8TI+Pyx8in/qs0QBV8iwPpuLhZEIR/UXnjbYI4V5NdRR+dhaotNobS8mPm4hEvet1Y9ai9HFjZZrYg2nj8SAuLScRzQIqhoh1uEb5bsa928LTESw/Cvm5D8mRkUPhnkwOxGajc7VniRcU5OJRUOOmRnDh5nMRid/tq+dSe7Hlb9+/ksav+9xbefu1OF4OtHk3f6VD7NA4WoEeVHeuWRpuSgeVtLsW3O3426Y4u8xsFx7DO5IQi/1JrRTB0brkUqk71kK+/596CGj0pVaOw2PNNj9pAO/vJTJY8ZGLKuBpM7Dd7Ifh9V7oQGogTohmkaKvQ+u1pEmYhOZZc2aZZplq1rz4Yftl7ZyMOEx+PjnEwYEHBKht60XlbUSyPSfagczwsUovAXGyS54NFo6n3laX6BsXz+fJH9AJc0bJ5Eg2QIUX/3xPa07ha5qA2rBxf2oDqtUrrp8x8BrbddjJ1mgXNvV4eHhDPbVkuv+itdDEpqUkXk3CYdTDyE9xMpZodLXM6NGgfv7SwYCyAw946W00K2oLB1ZXowfX7bUuYe0Y3i6pODFFQlrM6F/NdnhPPD5m3x5aQJDCxD2KOrXauOFa+TqYVEzksvK70rBjHQ==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(136003)(39860400002)(396003)(346002)(451199018)(31686004)(316002)(186003)(54906003)(110136005)(36756003)(38100700002)(86362001)(38070700005)(31696002)(122000001)(53546011)(83380400001)(6512007)(2616005)(6506007)(71200400001)(5660300002)(41300700001)(478600001)(6486002)(66476007)(66446008)(2906002)(4744005)(64756008)(8936002)(66556008)(76116006)(66946007)(8676002)(4326008)(91956017)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?YytzMklHR29QRnlxMmpOVWhzcTk3OUFVQlMwbGdZSElabkpRTEcvamh1YTRm?=
 =?utf-8?B?WGdOQ2VYYTh1bHZ0Ym5QZklFR08yaEcrTW8rWmNGZUVXWlNhQitqa1FNNFYy?=
 =?utf-8?B?WTlxQVZ5dWhKbmJRQUY4Y0FnZktkbjZPV3ZEL1Nma3lVYkxRWmVSUmxrNkpJ?=
 =?utf-8?B?YzhNVW9sR2lNRjdtU3o2b0U0a09XanBzL0l6aklWWXBiSVR3TVR4R3Rhb3NU?=
 =?utf-8?B?Y3Q0R0d2Q3dyTzBjZEsydXhxMXEwVzN3cnRjNTQ2ZllkQ09hdi9wUjBlbVln?=
 =?utf-8?B?OXdpM0xDU0ZZQ09MQzRsVnBmc1JNN3UwcEVtbVNwRHM2d1YvTUplRlNKYnZZ?=
 =?utf-8?B?ZW9teVRPYTFuRXJ2d21mTjBHZHMzMHVHQ0E0ZXJRbmZWS1Q5OW5pOWxrcGpu?=
 =?utf-8?B?ZDdQUVY0dTFHc1QwUzJWeENMSlVNNEZvV3lickVydzlxOVBsLzdtME52aE84?=
 =?utf-8?B?Ymd0eFRxa0pvekpsS3gvSlp0azBweDBZSUZyWnAzNzd4dmM4RnYyNGxzdWNv?=
 =?utf-8?B?c3hKSmRjMk5HNlZ4U3BHZmxkRUpqRExNM2t3K0ozVUFiUDZuVVRpbitlMUE4?=
 =?utf-8?B?Rm5GVFV6bTZOcWg0T3VWN3kzQzF6QXFETmI3WE5Va08weE50dThlaVpPVEhJ?=
 =?utf-8?B?djUzeWVlZWRUelZ1REtNc05iODRnUnN0SkZlK29XWGZWWDZ0YVM1UzdsNU5o?=
 =?utf-8?B?Y1pmdnBFWHlQUWhCWUlIN3NTVk05c054RkFlWVVrbmtPVERxSkNLUDFoNlNS?=
 =?utf-8?B?VTFWVjBHbDd3bFZROUZuTU1HNDhjUkswVTlIcFRWNTdlODJrYXNkd0tObkd6?=
 =?utf-8?B?amVoOGhrQjNnd2RVbk9MMVFmMGlhanZuekYrcmRpejVPSnEyOHdwZnZQaFNo?=
 =?utf-8?B?dmVqbVU4eUVMekNMQ2VGYW1DNEVqVC9iVnRJZCtrSTFpVlc4eVR4Nk9jMi9N?=
 =?utf-8?B?RVZld0ptNjVNY2tHUFJrcHVDK3dDR01nVTV2dWcwRmlWR092dktKWXRFOUxN?=
 =?utf-8?B?UVRHMFN3SnA4c0lKMGJvM2dUV2M3ajV1aHZhcHFKanUwdDRTRVdoQWZRUitH?=
 =?utf-8?B?YWM3RkNoejlBZjJjMEVKYkw4YWVtUFY5WXZGMER3bS9Fa1NDdVV0MHpuV0hE?=
 =?utf-8?B?VE5CMVI1UWJNUHREYWZJNWduK3ZKZXp2clZ2SlpZbHd1dXhhNkhOMUxIbnJP?=
 =?utf-8?B?QkN6dmlmTDJTOWhBOHpYSzNyb3RIMzBtaTJZQlROLzVaY2ZjRUhYWS9ZM3l0?=
 =?utf-8?B?UGY2aE43bjBYSTFRKzhUOTB6K0owQW8xcERtMmxVa3VWOEIxS0N5bXlqb1Vt?=
 =?utf-8?B?SURsYzBvOTZaZllSR3NCUHBUeGY1MHlWVEVlYy9yV040TWhGaEpsMlVSNEYw?=
 =?utf-8?B?cnNWWHVIYityWWs2aFIyaDBxMlFTSU80QUhxT2RpOXZzbGlYYXdsZStXdjJt?=
 =?utf-8?B?NFRZdjUrQk5LYzY0RVhISTI1bUN1TUEzTCtWVHdMK0ZSQ2E1N1o0TG5RMHJB?=
 =?utf-8?B?Zm5FRkhyZ0JhdFNhK2FMUUlQaSttZStvSUd0YXhFdGt0cUNkUlJJbmFDK1Uz?=
 =?utf-8?B?Mlgxa1VVL2FTaFl5QzZtY0pMWm5naGxCTUN6UHlnclZNRXl1aHIyQWZ5TGRh?=
 =?utf-8?B?K0tSMEJ1K0F2emx3OGNqMUhBM0cxSlczemtzNEZJN2xpd1VmTHZYVWUwVmZI?=
 =?utf-8?B?d21RY2JUMGFIbmRzaUNEUHo2SXJ4NE40QVZaUWNyMGJIZHFLNHpYdVdvc042?=
 =?utf-8?B?UWd3ZVR5T1lqUWY2U011Yys5aHE5NGJxUmNUMzFPb3c5L3RLQVo5bmpROHpo?=
 =?utf-8?B?Q2E2TUNlWFZsYXROWHlWTDRrdGRzalFZT3hSNjlzWDlQQVJGdXpLdDdLeUc4?=
 =?utf-8?B?WDQ4YWN4YmIvaVJiR0xIWmlGS2RyTzhBckVmVEJkV2ZlV2g2ZFA3cDZ3Qmda?=
 =?utf-8?B?Y1FvSFQxMnI3eW5wTjBOdDZMQlQvNUUzUFVMTU44NnMxZDU4a2VYL0tka3Vv?=
 =?utf-8?B?a0plN0JCbzlYSTNDVmx0Q1F2MDdjTVNjT0lYY2xYakhzUFhBcjFTYzBrOWZB?=
 =?utf-8?B?R3c0U2lia3ZrZDQxay9lK2xGMy9la1JHc0hLTk1CYzJqQ0ZDNWt2ZkVsN1JJ?=
 =?utf-8?B?anhrNTJaaUZMLzFwU1YvRDNvanJmbzdLbmFEZlREVlM5YjJQb1VKamdPdTZL?=
 =?utf-8?Q?twISby3pRijsbgTnRzOshdMCksSPmaFWPb0I+zZxqc6v?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F048832F7940C2489F6FE98741B675DD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc69274-ebf2-406d-e3d6-08db2514390d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2023 05:14:58.9686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XSe+dc23tQ4dtEURN8Pj1oFxq8sps6YwO2+4IjQDf2h6XgYTu7pfnrU6S74znyj/V33I41xzE1+Ro6sFJ/lcBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7773
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230314_221506_027562_96B27088 
X-CRM114-Status: GOOD (  16.92  )
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

T24gMy8xMy8yMDIzIDE6NTYgQU0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6DQo+IEZvciBub24gaW4t
Y2Fwc3VsZSB3cml0ZXMgd2UgcmV1c2UgdGhlIHJlcXVlc3QgcGR1IHNwYWNlIGZvciBhIGgyY2Rh
dGENCj4gcGR1IGluIG9yZGVyIHRvIGF2b2lkIG92ZXIgYWxsb2NhdGluZyBzcGFjZSAoZWl0aGVy
IHByZWFsbG9jYXRlIG9yDQo+IGR5bmFtaWNhbGx5IHVwb24gcmVjZXZpbmcgYW4gcjJ0IHBkdSku
IEhvd2V2ZXIgaWYgdGhlIHJlcXVlc3QgdGltZXMgb3V0DQo+IHRoZSBjb3JlIGV4cGVjdHMgdG8g
ZmluZCB0aGUgb3Bjb2RlIGluIHRoZSBzdGFydCBvZiB0aGUgcmVxdWVzdCwgd2hpY2gNCj4gd2Ug
b3ZlcnJpZGUuDQo+IA0KPiBJbiBvcmRlciB0byBwcmV2ZW50IHRoYXQsIHdpdGhvdXQgc2Fjcmlm
aWNpbmcgYWRkaXRpb25hbCAyNCBieXRlcyBwZXINCj4gcmVxdWVzdCwgd2UganVzdCB1c2UgdGhl
IHRhaWwgb2YgdGhlIGNvbW1hbmQgcGR1IHNwYWNlIGluc3RlYWQgKGxhc3QNCj4gMjQgYnl0ZXMg
ZnJvbSB0aGUgNzIgYnl0ZXMgY29tbWFuZCBwZHUpLiBUaGF0IHNob3VsZCBtYWtlIHRoZSBjb21t
YW5kDQo+IG9wY29kZSBhbHdheXMgYXZhaWxhYmxlLCBhbmQgd2UgZ2V0IGF3YXkgZnJvbSBhbGxv
Y2F0aW5nIG1vcmUgc3BhY2UuDQo+IA0KPiBJZiBpbiB0aGUgZnV0dXJlIHdlIHdvdWxkIG5lZWQg
dGhlIGxhc3QgMjQgYnl0ZXMgb2YgdGhlIG52bWUgY29tbWFuZA0KPiBhdmFpbGFibGUgd2Ugd291
bGQgbmVlZCB0byBhbGxvY2F0ZSBhIGRlZGljYXRlZCBzcGFjZSBmb3IgaXQgaW4gdGhlDQo+IHJl
cXVlc3QsIGJ1dCB1bnRpbCB0aGVuIHdlIGNhbiBhdm9pZCBkb2luZyBzby4NCj4gDQo+IFJlcG9y
dGVkLWJ5OiBBa2lub2J1IE1pdGEgPGFraW5vYnUubWl0YUBnbWFpbC5jb20+DQo+IFRlc3RlZC1i
eTogQWtpbm9idSBNaXRhIDxha2lub2J1Lm1pdGFAZ21haWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5
OiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPg0KPiAtLS0NCg0KDQpUaGlzIGxvb2tz
IGdvb2QgdG8gbWUuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtrY2hAbnZp
ZGlhLmNvbT4NCg0KLWNrDQoNCg0K

