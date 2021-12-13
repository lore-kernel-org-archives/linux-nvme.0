Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23316C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Dec 2021 08:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FoHT+M3JHboCX2jcwU/7UpM/MXnu3VNWtTdpowfvudA=; b=NNnjd2LBcLKD8eZBZAKBR/agXB
	wKS6GFhmeYsX6Qx2ASOQTRBwIF4wuX2WEowFHWriC0ik/3Ab4lS+VBxAUAUE6niuzhxfxVl7MGZFZ
	8G81Hgi0OAX6QXI11E+VPXZkaCChl4lnoBw6G5kQmFWxtu5QZ2VW5lv3dLI127bzpYD4sOCpyyzAt
	od+/A5fon09TQNY5sR8k4QF6u2c00rFnd+BJM6j01vAVE+iJ3t23EdjriABZXB5ZAroLDlcy+N4oC
	HrWTi7g7cT8lkGv1N4xbrGWmLzC+Y8KKyWXIqjUnyzb2QPEetSSwLa9rOKpDeU2z209yqhfj0jAj7
	IV58Ec1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mwgP6-008Ex6-0H; Mon, 13 Dec 2021 08:09:48 +0000
Received: from mail-dm6nam08on2085.outbound.protection.outlook.com
 ([40.107.102.85] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwgP2-008EvO-CS
 for linux-nvme@lists.infradead.org; Mon, 13 Dec 2021 08:09:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjRguKWE2Lk8t3SdvyLjzLQFj2hDaWdxkmfFDV6eVTJfLqyt7kGvZ5ZxGfWIMLlueiWFS8+HpasjIQYFECf2qUICQoKAGl9VPathoMrhsZBAFbYWC7ZuA+RIGtMzhqxMXpyBtiBFxg5eA9e/8F69Ivwe7fSsul3NjmbTaec5ZrL7nmA/Lp2YtxYgHm9EzD2pWCoO1CVCTQaUmR8hbXRjSJjp4sQA2KVYVhoGfw9PM76pO+dzUNMjZaNnB0ACiV89TcLbhCR24O+4VGbdOjGlNZBD4gZP9aDiCujvtCkxHcLgI3xTqz8nAhq3MW8unmOydXUqgqZD0SKCbssNb82xpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FoHT+M3JHboCX2jcwU/7UpM/MXnu3VNWtTdpowfvudA=;
 b=UJXxIZ+ObUub5PWF9jHEIyA/CA8Gw7iYY5ok8DqKETEtU7rQuK9mv/iBXV3r1j92f79OdauPb74qXqEKmVay2dASWnj1u/8fwzYOKJUx/iFyOdvpzETkvdDV/kzvSl3WBOwqu/Snl6FhfUmKcKeSQXxJouISjwCo/JKIkKYMIrLLvKbyDXdJBzeKbjJE85PP/wp5sIPvM1EtFtiQcoAWv72MnaWTMbHnx6YFyOsoTRjp9Qc+Oz1HMLyiREp7m1CjXdRyeXlnobvgvD2LujJntZowtpoWVrvCFJhefLK48KNhOaFsbLPnEGOTc5Gc9q+9AzMZlaBc9kWetxTO7p3LCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FoHT+M3JHboCX2jcwU/7UpM/MXnu3VNWtTdpowfvudA=;
 b=BvxXDNRmXHohhEnyt/mdLtFlIlaZ3Kcpw4G8HNDATmG+lu+JKbDMKRARMUZ4zBfSkAEX+RjAAmAo5BLBgbHYqGKHQMlIASHsjadPyKJewo5bq/MfSr0vsRFfw+OQTL7wlGQON0bnwy9MKPrr7CufP5PTuLXFdNV9HVK9z83JCh10u+lbhzSv4tT7G/pzQIb23CTceYZqxaGCPhtpBFrmrs2b5Kibm+vpYRyCmZeSj13Ofs2Q+24mXN23Nh4RVtuKeM6saL2VNLnMSypCYATewCTwoJxEA07tU6rQvb7bmEtoBhM88JKvf8OeoZrIi9wDha5WOvqirPLH36E/Cdpj3g==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1726.namprd12.prod.outlook.com (2603:10b6:300:110::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Mon, 13 Dec
 2021 08:09:41 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e%7]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 08:09:41 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Alan Adamson <alan.adamson@oracle.com>
CC: "hch@lst.de" <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Sagi Grimberg <sagi@grimberg.me>, Keith
 Busch <kbusch@kernel.org>, "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 1/1] nvme: Add verbose error logging
Thread-Topic: [PATCH 1/1] nvme: Add verbose error logging
Thread-Index: AQHX7SNElKpKCM+2R0+aIivULZFZVKwrmhwAgABIPAWAABE4AIACrhkAgAF1n4A=
Date: Mon, 13 Dec 2021 08:09:41 +0000
Message-ID: <c2775180-b7ba-6393-3841-8e0d28c32232@nvidia.com>
References: <20211209173213.14249-1-alan.adamson@oracle.com>
 <20211209173213.14249-2-alan.adamson@oracle.com>
 <fc8f5858-3bea-675b-003f-b59059bd5e5a@nvidia.com>
 <yq1mtl8qxc4.fsf@ca-mkp.ca.oracle.com>
 <20211210165648.GB3856533@dhcp-10-100-145-180.wdc.com>
 <6d23d067-9115-a295-1bcb-ad28679dc4a3@grimberg.me>
In-Reply-To: <6d23d067-9115-a295-1bcb-ad28679dc4a3@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e24a9f1c-e999-4bd9-7e90-08d9be0fea57
x-ms-traffictypediagnostic: MWHPR12MB1726:EE_
x-microsoft-antispam-prvs: <MWHPR12MB172678BBDBA1FC6530910352A3749@MWHPR12MB1726.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AnRtgr5BP+RAbe0HUZCXD0d2GYF2GDF6ruWjui6Z8qvLNaecdkX9Serit99+xiF9q0wmRDmQFmEO+TVOtpqex1UmKDi+BSSaRvlSf4edMAlxpmUElOueIdpCIuG71g4TUuxGSUK3KXD6PTmVgrUzc8z+piF5X3cwOGDo3KcQ7YrZJ149fgTEyzAHYq6FxJ05UVEZMtPhjGKswUeDWBvUFKTIaF372cRMx5nCg7uTgl86Utv9+DM914dHuBoxFIn7+GWzzPNpr2WHEjRolfcgIQGsylTZiwQDSfoKvCzE3mkS+kzLuMZQJLD3bouhcjRpteWXmgZBZGx6ZE60KWNtO1EMN+ZFVH7IaKJhQ+4YX2dLftOQwuRPb2Gb1x8JfLG60nIgEpncUtFnCkDHpQXQnggZepADKg+omhad2mj5tQnfk6UOIdczCJG7h1zkYEofQbPcOX9UbDlOnL2dng3NNI5r9whkPt2DdaXHI8eLSyL+OSfZeLlJrBGiocJNppsywJZxPdTqKlCYEYwH/QyqPcaXsrwgo5SwN0C7ypEpt69VGksLWofpNK6m/IScOB6j0viWuqeAaVO+id1XKI4hLpVeFDwoAU0eCJVBE2w5aeiGVP3PPP+KrCsf3OAEszlUvUDDcqzG06IKEmFBv2gfk/jWtH5tt1JN5mMHHz7XX4z3HYhbk5P8zgOIQKQngCqzzNvnxXELNiUzwo6k0Qe/IjdqehasUqNNxRr5hX+Ar3IgX+8X4TIazly269T/KEkQXwLcEnbLiEZxZ9EXhQELRQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(91956017)(64756008)(66476007)(8676002)(36756003)(31686004)(66946007)(76116006)(83380400001)(8936002)(6486002)(316002)(38070700005)(508600001)(66446008)(54906003)(4326008)(186003)(2906002)(53546011)(71200400001)(6512007)(31696002)(122000001)(2616005)(6916009)(5660300002)(38100700002)(6506007)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHRZNGtpbVpBR0JpNnYxeFhINjhFTWR2eWRpUGNDWkVpczhxRXpRWFpsbkZv?=
 =?utf-8?B?TmluT3pXMmcwWUlmUldKSUcrQjJ0d2JGbjRWblEyTnZKQTB6VTRvN3Z4TENJ?=
 =?utf-8?B?THdiTGNJdGIwVFRPd3hUaGM4T0hVYkNMb2Z2TmlMeG12SVRMYTBlVEE2Mk4y?=
 =?utf-8?B?dy9tRU1tUEovTlJWNlpEMmthQnFPUnhseGEvdXhON3BJd1o0eUxuTmZuWlRh?=
 =?utf-8?B?Y1JPYTlXZTBEa0V4Sm9FNWRua3NNNGRmcWNYOFplY3dDTlBib2FvWUkvb3ZU?=
 =?utf-8?B?bE1JNW9vYldPQlUvWGhxbHpCUjJDQm5vUFYxbnZCb0x5Vm5JUmZySUNWZE9X?=
 =?utf-8?B?b0E5M3Q0cFh4TlZRV2Ficm5PZDRyRjYzTzFJKzJKL2F5blVoK05rTklmZFds?=
 =?utf-8?B?SGxRbjlpNWpUV09ScGE3bG1TMDFJamw0a0VWTDdXSGRoTTJQMy9UZGdZM3N5?=
 =?utf-8?B?QUJ5QzZieHM2M2FQTDhDL3VyMlROSktzZXFLSzhQOWFaUHFJYzNaL212L040?=
 =?utf-8?B?RUZrbjJYSUszdDJQVHZmZWJPVEhIZWtNNHB2NlJzdXZOa1p2T3lQcXJjM2ww?=
 =?utf-8?B?YTJUYnQyTFkrSVpOR05NODg5KzlYRGY5L0tBY0dWbysxQ2ZVL2h6SFFkRWlP?=
 =?utf-8?B?T3c5YkJJbXo5SzFhd0xuQ2xHVUZYd3NERkdtRk55OVBGU1d5aTVBR0tKM1RS?=
 =?utf-8?B?RzErdjRDRGlrMVdmRENnNStxS00xOW13U3dvcjg5WjVXMlVISmxPMmROOGp0?=
 =?utf-8?B?REFMcVlRd2FFdjF1WjhpMUJHaUM4d1hHenpvRGd4bk10SjI4WGdrNWhIVDNo?=
 =?utf-8?B?R2p1dTViN2NvbTlkSmZHYm1xSjJJR045N3NyTDE4UnZnWkdlYjZqYThLbHlq?=
 =?utf-8?B?cFNFanpWdktXd1AvRUhlaDd3anIwc0VhNVFEUzFsU2lEWlJmTVNpM2VhTkhj?=
 =?utf-8?B?U1QrQ0ZYUTNnSkd5U1krSEx1L3A2MzlQYjJLem4ycFJ1c3R0Q3NaMHpUNEZu?=
 =?utf-8?B?aHFqVjB6ZTlma2l3QzFkVXFFMmVDMzJ1R1dLb2prcXVXN1oxeGowRVFCdTlI?=
 =?utf-8?B?VXo3TEJGbGhCOFJZR0RxUUIycjVSSkMrdGlucUcvNWY5eEJZS3E3OW5vZVVO?=
 =?utf-8?B?RkVMYUNqSzExNkR6bkJPWENUcjlaZ0wxeGZsbC9SdE1LbGFIUlZmZWt5b003?=
 =?utf-8?B?Q1NkRFhFSVVWQnF4RnZ4RXpaYW5aVU9vYTg0VFd4ME9WWDI4WEJaN0NIYlRT?=
 =?utf-8?B?RGtUSVdoN3FkUXB6QXZoL1dFMEZpNHBnZWxWVCtrTXlXZkxrQ0QxL0dCVVVG?=
 =?utf-8?B?NlRLWE9lUWwvWmhtRnNHWElYMCtjR2wzQlBCamRMNWlhYThkYUE1cnNyWFNj?=
 =?utf-8?B?VVQwdWpGUmVLbGI0QWJkUi9EZG9neFNodUN2LzlKRjZiS1BLRkl0ZDJ1c3oz?=
 =?utf-8?B?aFdZN3pYS2g3ZWJZVnlJODVqanR2OWswRHdHcjEwVnRzd0VmemE0OXFFVnhr?=
 =?utf-8?B?MTZzdFZldkg5UGtETGE5UjNqaGw3REM4N2ZwUkFjcmFDcFBjWWZUZDE1MytF?=
 =?utf-8?B?MkNob0VhSG95V1ZVM0ZGNjNUMEJNbzFhQ05vWGFGMG9UMHh3ejhEZnFoK2JE?=
 =?utf-8?B?cmk2a2ttb0VINkxsalpvWWF4QVppYW1odHhLNnVnYUJxdE5xQzJSL2dEUUV2?=
 =?utf-8?B?Mmc0Y2tqRTY0eXFEa3RXYVBBNlZRNFdtUHo0WFFqZmpNNkowK0pKckVhSWFJ?=
 =?utf-8?B?dHRtcXA2QnFDZTl0WHBoZ3BQenM5UGJiUFFVMDZIOXpiamNKbE1Wa0xPSGM2?=
 =?utf-8?B?aEhqRDlEYWRCSE5HcExZZVp3QTNLKzZnZ3FKR2ZlL1BDNHhZTFVSUXQ5SzFi?=
 =?utf-8?B?UGVVVnluZlhXRUUwNEFjTU5ETG9RblpkWmQ3bVJ4c0VqQ05YUE85dHJpS1Q3?=
 =?utf-8?B?eDlXR3A2di9EK1QzV3I4K29jY0hTZEdiUHExYXBLSG8zMkJKSGhDWWphbWRn?=
 =?utf-8?B?TkhRQXlNUzREekhUSk05aFl4SzduUGtzallXbW9VOTVuU21JRG5zZXJKZml0?=
 =?utf-8?B?UC9obWlyNmJRR3dYSmR3RWFUZVdUWDl6bnNTVWpFdWVJVDNKSFZuMlFVbkNW?=
 =?utf-8?B?b1RYTlpObTNWUWJiSkdIbzRPU2FFWlBob0ZWWkJ6Y2ZUT1g4UlpjT21pa0hN?=
 =?utf-8?Q?E3oy/yoA7/Pcp2+AKw7uD14IrVzaTo1cmZ5hdqZrhDwM?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A554953005EC6149B5CD00BEDF542A39@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e24a9f1c-e999-4bd9-7e90-08d9be0fea57
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 08:09:41.3546 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m7XcaSW6fTFqzNDw8iUO8pWuDLYzM/NBbf/l+B9u1NXb3DD9xFbtEb9QstJoUf2xfnrfFw65YsbB/lJixMUk/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1726
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211213_000944_540934_8A4FE7EC 
X-CRM114-Status: GOOD (  28.58  )
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

T24gMTIvMTIvMjEgMTo1MiBBTSwgU2FnaSBHcmltYmVyZyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1h
aWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0KPiBP
biAxMi8xMC8yMSA2OjU2IFBNLCBLZWl0aCBCdXNjaCB3cm90ZToNCj4+IE9uIEZyaSwgRGVjIDEw
LCAyMDIxIGF0IDEwOjU0OjQ1QU0gLTA1MDAsIE1hcnRpbiBLLiBQZXRlcnNlbiB3cm90ZToNCj4+
Pg0KPj4+IEhpIENoYWl0YW55YSENCj4+Pg0KPj4+PiBBbHRob3VnaCBJIGFsd2F5cyBwcmVmZXIg
ZGVzY3JpcHRpdmUgZXJyb3IgbWVzc2FnZXMsIEkndmUgbm90IHNlZW4gZXZlbg0KPj4+PiBoYWxm
IG9mIHRoZXNlIGVycm9ycyBpbiB0aGUgZmllbGQuIFRoaXMgd2lsbCA6LQ0KPj4+Pg0KPj4+PiAx
LiBJbmNyZWFzZSB0aGUgc2l6ZSBvZiB0aGUgZHJpdmVyIGNvZGUuDQo+Pj4+IDIuIFJlcXVpcmUg
Y29uc3RhbnQgcGF0Y2hpbmcgb2YgdGhlIGRyaXZlciBjb2RlIHdoZW4gc3BlYyBpcyB1cGRhdGVk
LA0KPj4+PiDCoMKgwqAgSSdtIGFmcmFpZCB0aGlzIHdpbGwgdHVybiBpbnRvIGNodXJuLg0KPj4+
DQo+Pj4gVXBkYXRpbmcgdGhlIGNvcnJlc3BvbmRpbmcgbGlzdCBpbiBTQ1NJIGhhc24ndCBiZWVu
IGEgYmlnIHByb2JsZW0uDQo+Pj4NCj4+Pj4gQWxzbywgd2UgY2FuIGVhc2lseSB0cmFjayBkb3du
IHRoZSBlcnJvciBpbiB0aGUgTlZNZSBzcGVjIGZyb20gdGhlDQo+Pj4+IGVycm9yIGNvZGUgdGhh
dCBkcml2ZXIgaXMgcHJpbnRpbmcgY3VycmVudGx5LCBpcyB0aGF0IG5vdCBzdWZmaWNpZW50ID8N
Cj4+Pg0KPj4+IE9ubHkgdGhlIGJsb2NrIGxheWVyIHN0YXR1cyBpcyBjYXB0dXJlZC4NCj4+Pg0K
Pj4+IEluIGFkZGl0aW9uLCBjdXN0b21lcnMgYXJlIG5vdCByZWFsbHkgYXJtZWQgd2l0aCB0aGUg
TlZNZSBlcnJvciBkZWNvZGVyDQo+Pj4gcmluZyBhbmQgYXJlIGxlZnQgd2l0aCBubyBleHBsYW5h
dGlvbiBhcyB0byB3aHkgYW4gSS9PIGZhaWxlZC4gV2UgaGF2ZQ0KPj4+IGhhZCBnb29kIHJlc3Vs
dHMgaW4gdGhlIGZpZWxkIHdpdGggdGhlIHZlcmJvc2UgU0NTSSBlcnJvciBsb2dnaW5nIGFuZA0K
Pj4+IHRoYXQncyB3aHkgdGhpcyBwYXRjaCB3YXMgbW9kZWxlZCB0byB3b3JrIHRoZSBzYW1lIHdh
eS4NCj4+DQo+PiBJZiB0aGV5IGFyZSBub3QgZmFtaWxpYXIgd2l0aCB0aGUgZGVjb2RlciwgZG9l
cyBzZWVpbmcgc29tZXRoaW5nIGxpa2UNCj4+ICJDb25mbGljdGluZyBBdHRyaWJ1dGVzIiByZWFs
bHkgcHJvdmlkZSB0aGUgdXNlciBhIGJldHRlciBzZW5zZSB0aGFuDQo+PiAiMHgyODAiPyBFaXRo
ZXIgd2F5LCBpdCBzb3VuZHMgbGlrZSB0aGV5J2QganVzdCBvcGVuIGEgYnVnIHdpdGggc29tZW9u
ZQ0KPj4gd2hvIGlzIGZhbWlsaWFyIHdpdGggdGhlIHNwZWMsIGluIHdoaWNoIGNhc2UgbnVtZXJp
YyBjb2RlcyBzaG91bGQgYmUNCj4+IHN1ZmZpY2llbnQuDQo+Pg0KPj4gQXJlIHRoZSBleGlzdGlu
ZyBudm1lIHRyYWNlIGV2ZW50cyBub3QgcHJvdmlkaW5nIGVub3VnaCBpbmZvcm1hdGlvbj8gVGhl
DQo+PiBleGlzdGluZyBvbmVzIGFwcGVhciB0byBoYXZlIGV2ZW4gZ3JlYXRlciBkZXRhaWwgdGhh
biB3aGF0IHRoaXMgcGF0Y2gNCj4+IHByb3ZpZGVzLiBPciBpcyB0aGVyZSBzb21lIG90aGVyIHJl
YXNvbiB3aHkgdGhlIGtlcm5lbCBsb2cgaXMgcHJlZmVycmVkDQo+PiBvdmVyIHRoZSBldmVudCB0
cmFjZXIgZm9yIGNhcHR1cmluZyB0aGVzZSB0eXBlcyBvZiBlcnJvcnM/DQo+IA0KPiBNYXliZSB0
aGUgc3RyaW5nIGluZm8gYmUgYWRkZWQgdG8gdGhlIHRyYWNlIGV2ZW50cz8gSWYgc28sIHdlIG1h
eQ0KPiBuZWVkIGEgdmVyYm9zaXR5IGxldmVsIGZvciB0aGUgdHJhY2UgdG8gcmVjb3JkICJvbmx5
IGVycm9ycyIuDQo+IA0KPiBBbHRob3VnaCB0aGUgb25lIGFkdmFudGFnZSBmb3IgdGhlIGxvZyB3
b3VsZCBiZSB0aGUgZmlyc3QgdGltZSBlcnJvcg0KPiBzdGF0dXMgKG9yIGZvciBnZW5lcmFsbHkg
cmFyZSBlcnJvcnMpLg0KPiANCj4+IE9uIHRoZSBwYXRjaCBpdHNlbGY6DQo+Pg0KPj4gSSdtIG5v
dCBzdXJlIGhhdmluZyBpdCBiZSBhIG5ldyBLY29uZmlnIG9wdGlvbiBpcyBhIGdvb2QgaWRlYSBz
aW5jZSBpdA0KPj4gcmVxdWlyZXMgYSByZWNvbXBpbGUgdG8gZW5hYmxlL2Rpc2FibGUuIENvdWxk
IHRoaXMgYmUgdG9nZ2xlZCB3aXRoIGENCj4+IHN0YXRpY19rZXkgaW5zdGVhZCBzbyB3ZSBtYXkg
ZGlzYWJsZS9lbmFibGUgdmVyYm9zZSBsb2dnaW5nIGF0IHJ1bnRpbWU/DQo+Pg0KPj4gVGhlIG5l
dyAic3RydWN0IG52bWVfc3RyaW5nX3RhYmxlIiBpcyBhIGJpdCBpbmVmZmljaWVudC4gVW5rbm93
biBlcnJvcnMNCj4+IHdpbGwgc2NhbiB0aGUgZW50aXJlIHRhYmxlLCB3aGljaCB3aWxsIHNsb3cg
ZG93biBvdXIgaG90IGNvbXBsZXRpb24gcGF0aA0KPj4gb24gYW55IGVycm9yLiBUaGUgY29kZXMg
YXJlIHNtYWxsIGFuZCBtb3N0bHkgc2VxdWVudGlhbCwgc28gSSB0aGluayB5b3UNCj4+IGNvdWxk
IGNyZWF0ZSBhIHNwYXJzZSAic3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdFtdIiwgdGhlbiB0aGUg
ImNvZGUiDQo+PiBiZWNvbWVzIHRoZSBpbmRleCB0aGF0IGNhbiBiZSBsb29rZWQgdXAgaW4gY29u
c3RhbnQgdGltZS4gVGhlIHRvdGFsDQo+PiBzcGFjZSBvZiB0aGUgYXJyYXkgc2hvdWxkbid0IGJl
IG11Y2ggZGlmZmVyZW50IHRoYW4gdGhlIHByb3Bvc2FsLg0KPiANCj4gMTAwJSBhZ3JlZS4NCj4g
DQo+DQoNCklkZWFsbHkgd2Ugc2hvdWxkIGRvY3VtZW50IHRoZSBwZXJmb3JtYW5jZSBudW1iZXJz
IGlmIHdlIGFyZSBnb2luZw0KdG8gYWRkIGFueXRoaW5nIGluIHRoZSBmYXN0IHBhdGguDQoNCg==

