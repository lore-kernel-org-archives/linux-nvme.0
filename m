Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A631EC43334
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jun 2022 01:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X/peCGMMRjLs89mBRdM4TsdshN0SZsfl+FHXaf1r5U0=; b=myxvQXwgskslAYV8YSsJZZ/ORO
	t+ff1pN/imCUgtU+0aCZ0nu4tnWudiztwD/p23SgZ0FRWTnr5+AK++nujdJJtKo1zX69zi5P1QwLy
	oko61b3/bvcI2nKZxr3pypADkpDSli1uzHmj3kxMeqNAO3cc/ER3dShtJyR4XVrbNhwJ75cgU8Pg1
	tSHsjKZ2T09on7M/cnDc8ci3glYx58Ul0TiRWmWl79G3TpzGCcu6sdK2p/SMuOdW9fonSI6WIv2R5
	Gve27lLkIR/bZBUttW46x0MgGfG7EGdYt+B4sVm7RrCuerbEBDydYpjD0CHYq2yGVggKUl0CKH9Dp
	FMYOg59A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwZur-0011wj-4r; Thu, 02 Jun 2022 01:46:25 +0000
Received: from mail-mw2nam12on2061e.outbound.protection.outlook.com ([2a01:111:f400:fe5a::61e] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwZup-0011vk-8I
	for linux-nvme@lists.infradead.org; Thu, 02 Jun 2022 01:46:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHKMk1ZiGNoeIJXRrvF3s36RGdWeEbUK09wHR5tgUVxhqKzC6kOuiLX5aTf1imJomCwBPJz1KSFZ2lI15sneIdXlKl+7CpaRlk1eWzGeNulCD0bpRvvGJveuKA8xBxEAnogZ12YXw37m1uyPTnMrwC0A2Irc0n/bnCRFd+0p9/2Ob9SGE16Bs0BROCq9pCBlhhBjveJIMGNfIMMZwPQG7ze/DuaWkfUybmojhH9fKCuzrIOnuh6rQRTZySUxCsiIglsZs8PHZ9VljGrPuvIqRMkw1ZPmJnjpCq0uI47+jnypEYQ0TG557lVtohHyy7kyV3PkSiqSxGgSAukVTwVNng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/peCGMMRjLs89mBRdM4TsdshN0SZsfl+FHXaf1r5U0=;
 b=RNDbWXtm2D0wX74b8uOotINUt77i8bT6DYhXeAv3SDZtBmrTmpYpbYp/jC+Q7L0tH2+rTvd0uOY1qMPVE7qvXD3/Fn6dw8FpwHlmX+alelgxIPWwe/eBf3750yNPsbBuf0OzInj1jh5oZiDLcZitr0VLShkX9lz66CMZhfLfAMNVcDu34ddGmAI15MSD7V+d2HYddI90J4n0Nypy9dxQ07CfHgeb4+bbhOXgia/kjh30XjlnywpSlFoS9sjfOFXdBgwZY7d9Sy33QYctgjmd6tpqUC+4xVhWzdOUBlndMqh1+foK3ZV/RuWTX2fSy3GLmmNBvB3ZvyjlsCK9lLAD8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/peCGMMRjLs89mBRdM4TsdshN0SZsfl+FHXaf1r5U0=;
 b=Yi4Mbu8zxNWmVpJlDhQDrh/bYmhm0k6b+AP3ZXgwolclGzF/5hG+OsioKmXMHZusUna8QUxNYEp9HGFFERaBNLVVchHddiVm/FrBvKIpxJRdPD08d2GTTDZtkE4NDERE0yY8nBzb0yqpz49Il0hKFSSZMFa4URJlKJX4lp7MPcNGG+MRAMT7h2wQmGrna//0nhbLg4RtjGHRkAjRExaQ+vnbqBUrehWh63mW6LqKt47rHcJZRoxvR1TTssD+wyDRj1t/YNTFodI2mrmaVchGJXNUyAFXBj9ZbtjxP/z6A0d4flEoy9wPOPw4WkTnIc9D8ZarLITHnRFeI7ZVxnVlYA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BYAPR12MB4693.namprd12.prod.outlook.com (2603:10b6:a03:98::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.17; Thu, 2 Jun
 2022 01:46:18 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::d9a5:f1df:5975:a0d6]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::d9a5:f1df:5975:a0d6%7]) with mapi id 15.20.5293.019; Thu, 2 Jun 2022
 01:46:18 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@suse.de>
CC: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>, Keith
 Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCHv13 0/9] nvme: In-band authentication support
Thread-Topic: [PATCHv13 0/9] nvme: In-band authentication support
Thread-Index: AQHYcaCt6FEh6Cw5WkqgEI4iUbdTBK07WMAAgAAJGIA=
Date: Thu, 2 Jun 2022 01:46:18 +0000
Message-ID: <2e795a5d-b4f3-d400-f4fc-cc21050a64f9@nvidia.com>
References: <20220527080457.90855-1-hare@suse.de>
 <49d53423-5dcd-b8c9-0d27-b323c82800c3@nvidia.com>
In-Reply-To: <49d53423-5dcd-b8c9-0d27-b323c82800c3@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b28ff283-86fe-4084-a233-08da4439afeb
x-ms-traffictypediagnostic: BYAPR12MB4693:EE_
x-microsoft-antispam-prvs:  <BYAPR12MB46933BF2D0F3630C3CF42D36A3DE9@BYAPR12MB4693.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  3Gj4Di4h227b5JD1opASlitszyev/fmhy3drlGQGodgxGqGGIB1MxcGCdBgoCDPj9HrCUa7syN8TRfEMFwF4q4mBIiceRPzmvFZnCXb6BU9seCjYJlWYDPf/dD/kzUHk4O/WNZEJVDNH2rpYmhPwWwDOQdLcSS0tdFsukaBHSeRStjWSVmCJz36YCrDgm0GKA6LtA/6IAHCgDaZ/M0zWQ/ksTkBRv6Xe6vpUjruPr2p05Fl5qQzbIeC/F7dJ2Cqw+VFfTqK9AN8XpbsXstHZ68DL0L3/y0Oh2ryQMrjZZxHc308g8dkoCGh5xvoJtGzZHfPzejFgezciFSsxUf3sQpzIsd01TAuCIZ9lplkbIms5vnuHWBcG2XZuszfmaonZctQ2bUgrhE3kFnDfIdVxn3asXxabph1sPhkTrLqr0VPe/UUzYjm1K5hyne5zrdwSx95U681zFT9BXNCiSgBLXUZKU2QJ0nfKBeZSXd8liJ2jZaS/zi2UmL8H+P+obTs631U+UrsjATWtYboW1vSV63w+tpVWS+yftgIMAuX8EG1P1TS/2/yOAyRqCTTMoQoiGJ0E92kBTPu7TXbWDtNbQKuRVH9KuNgUMU0b5C5mHbiYmhzF373Qd90ixQIpib3WJQjsOba8BHZWx7TUi9Jvegrj+UXazjOzzWrT9JloMJc0jk3axD/P9HU+/zqE9K+V1/4HTUgbLZrbJS/VLm+yXv8wIdaUp/Yk8ApEvK4lpMheuJuHXGbifTwo/xn4k2GoClXv86foxGT6Jcy5cIs8Aw==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(8936002)(508600001)(91956017)(86362001)(4326008)(8676002)(31696002)(316002)(36756003)(66946007)(64756008)(66446008)(66556008)(54906003)(66476007)(6916009)(6486002)(31686004)(5660300002)(6512007)(71200400001)(38100700002)(6506007)(2906002)(186003)(2616005)(38070700005)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?eGdXK2taTlJBYVZpVVk0VUtMNkplVHA5Nm0xTDBoUFk3SHNJRkptRE9hNkd3?=
 =?utf-8?B?NXFpWVRRSUNTNWgzU05OdUNEYUVlWWdabW15MFNDQkordG9vYkMrSHhqaDNv?=
 =?utf-8?B?MjAzdWVhTnN1c3RKZzdGK3dvTWR2SHd6dWdXbUkvdTB4eGcvNGVVaHArZjdE?=
 =?utf-8?B?elpNNVZTakxkc2NGM1JIckhRcEFYTlhlMkV3U2tGZFRYaVdFc1Z2K0cvRVFX?=
 =?utf-8?B?aXBpVGZJNE5Pei9BWUw2Z0dER0tVa0hBWFhKb0lyTUtRcVdVSXR6MUtac09w?=
 =?utf-8?B?UDNmdjlLQlZCYVN2endvUmtDN1dvT2VaeEEyUWZpd3Nyd1B1MGt2Sng3ZzVl?=
 =?utf-8?B?TEs3S242MUlWVHVXNnRwNUtDa01zdGRkbUU1bnQwUDNpOUplYTJvUFNONlc3?=
 =?utf-8?B?d2JGSVVBM084U0NnUGpQbExTb28wZkk3NTFaUENIVFhab3hVMVAzMVJjVDN5?=
 =?utf-8?B?d21udUlsREVSVVFGMmU4UlJUMDMzTWxmVzJ6bEc1eElWaENTeXYzN1JnODdJ?=
 =?utf-8?B?RFJwRnBPK0dZWGpoMXlodDhLUC93ZHl4OHhRczNNMEFwSDBiU1d1TXBBZ05U?=
 =?utf-8?B?eUVsZktwMDIrUU5BZ2VlSityZXJjYmdXQTNZOCtMTGNVb3paZU8ycklEa1lC?=
 =?utf-8?B?M2Z5QmtqdzNzdGYrTTlSd0xEZzd2M3JrWUZYdk13dUFNeVcxeEwweGhpYXdQ?=
 =?utf-8?B?bnU2dmc1TWpETk93N1N5MHU3RHRRZkl5T0FPdHE4clo2SjZoQXpobDZCL1Y5?=
 =?utf-8?B?SUFBU1ZLOUJLdVZ6SENFeUFFZGxhMW9MTGNXbE9UckM3NDFVVExmbkJ0VW1E?=
 =?utf-8?B?U2UxZFk1KzJQc1VDNTZDcElFaU5xS01oK3BmUTZDR2QxaWMxQ2wxWGQrS3Mw?=
 =?utf-8?B?WFIrV1l1SVY1czhxWmlMNE5RYlVqTEhuOW9LZ1N6TExVSnZtRWQ2aERDcnVj?=
 =?utf-8?B?Nlo3MFFvQTRxTUt6cndFZWYyRDZwcyswbng0Z25ENWJBL2dROXliUlZmNXla?=
 =?utf-8?B?RUk5bXlpbWc3TU5NcUNrVGpxY3k5S1MrMGZtQjloT3EyTWprb2kxT1NZTzJB?=
 =?utf-8?B?L0YrcktleVd4WDhxVWpCaU1LbG9tR292Z0FYc3ZrclFzQ3dCaklQL1Q4YVFm?=
 =?utf-8?B?WXdDOVJxR0l1Um5xR1M0em1QbDh3U200ZGp1eUxWMnBxS3QyQWh2enV4VHdh?=
 =?utf-8?B?amVRbytrYkZJK2lML3RaV3hScFRaY241QjM1b1hYdkt4TlV3ak83b2Ntc1hw?=
 =?utf-8?B?OVgvVzNWM2F0Q2pqaHdRMmpTeDYwbm5mSzBtV3g0d2FhNUVnUmVqOENxVFFP?=
 =?utf-8?B?OWhpOVhTdCtxUFdwUmFjWjN6eG1sZkhXeUhyVDgyUUljRXdNRUwwdkszeFRM?=
 =?utf-8?B?cHZBZXpJM3FuM2VFK25FVUlweVh4c2o2M05PbGFwTlFHMlhCMlNZZVF0OVoz?=
 =?utf-8?B?eHJTaE5RSk9XSE9hVXFkRjVmL1FHR0dENXoxRU5OSVVwL1lFV1JkU3Q1MTJv?=
 =?utf-8?B?dmRmRzZqYTllZkR6SE4wMUI3bUtrMHRIcTF0UHpRWGYvSmRoOEtvNy9jVk5M?=
 =?utf-8?B?MlBXZ1RLV2RQbVJabXdyYzgyUXI5cmxWQktvSU9oYlowMTFLVXMyM3ZaNnlO?=
 =?utf-8?B?RUt3dVdwUENvK1d6YmhZUzZvdXgzdW92blJoNElGM09mckpPb1R3MGVLTWxB?=
 =?utf-8?B?YisxbU9xclJ6dmo0N05uRHJZQy9xOStzWUhsSHBMV0xBbTFhalFWV3hHMzZU?=
 =?utf-8?B?dmZJZVlHb0RFVloxVVFJa292NVFidW8rVDVvVlkxQlRuSUViUXJKUlZxZHhS?=
 =?utf-8?B?K25Bcm41aU1pRWJac1kxSmlDRUV4WE1hMENUWWRiZzYwdGZMSVZqNGNJdmox?=
 =?utf-8?B?RkRpc2FRa3g0d1M0RmRkT3N6M09JajYrSnhRU0pZSFRlMWE0RjFXbllESDE3?=
 =?utf-8?B?YVJJb1ZtTFRGVEFPRlFIaWl4akxXOTArQjRUYXlEbldkWGdRRUR6UlZMR1gx?=
 =?utf-8?B?eVZRTlhacURycFZoQ0F2c1Y4L2p4NC9nSWU5WXdKb2Q0amJOQUZKbU93UmpZ?=
 =?utf-8?B?T1k1eTVGd3ZCcVI0R2RrOXpEQVUwN1dLU0xxZUpGQ0J4bzNmMlI5ckNlOHJi?=
 =?utf-8?B?TnhHbm1XWmJqbmVTRmN6Vnd6N1gxSmtvdmlsM2REcHZURUFzOC9yRmgvUFR5?=
 =?utf-8?B?eUg1SWJyUmFsTkJEaVhVVFhlRGdreVp5Z0t1Nno5aTlnV1Z0VXF5RytvU1Ns?=
 =?utf-8?B?d01qZENxN054aVd1L01TUmxLQkZrenlIaUkrNWdvSC9qbnhYWG5udWU4bURL?=
 =?utf-8?B?TE5EdVZGcUVkaElDYlMxSU11bmkxYVIyUDFMR0tmQW5GdWxHOURsWlRGZFN5?=
 =?utf-8?Q?qAuRBkmF/acLWvxR5nqmaq1T0tGbVaWzJOqHHmJiRygaz?=
x-ms-exchange-antispam-messagedata-1: 1TjC+swh4lhJHA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA777A7FEF3DDF4BA2B1A4F4AEA68C74@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b28ff283-86fe-4084-a233-08da4439afeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2022 01:46:18.1157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y+sBxPoFv7iCra7jw+A8iNE256gJ9vXlmT8mzkBIwnGZdGsVh3f3vUt+cMxfguBCLOKQFd8Liot6WEHmNs3WqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4693
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220601_184623_339957_C2950122 
X-CRM114-Status: GOOD (  10.20  )
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

DQo+IFJJUDogMDAxMDpudm1lX2N0cmxfZGhjaGFwX2N0cmxfc2VjcmV0X3Nob3crMHgxNi8weDQw
IFtudm1lX2NvcmVdDQo+IENvZGU6IGM2IDc4IDYxIDE1IGMwIGU4IDVhIGVkIDJlIGMxIDQ4IDk4
IGMzIDBmIDFmIDgwIDAwIDAwIDAwIDAwIDBmIDFmIA0KPiA0NCAwMCAwMCA0OSA4OSBmOCA0OCA4
OSBkNyA0OSA4YiA0MCA3OCA0OCA4YiA4MCA5OCAwYiAwMCAwMCA8NDg+IDhiIDUwIA0KPiA2OCA0
OCA4NSBkMiA3NCAwZiA0OCBjNyBjNiA0NiA2MCAxNSBjMCBlOCAyNSBlZCAyZSBjMSA0OA0KPiBS
U1A6IDAwMTg6ZmZmZmM5MDAwNTRkN2RiOCBFRkxBR1M6IDAwMDEwMjgyDQo+IFJBWDogMDAwMDAw
MDAwMDAwMDAwMCBSQlg6IGZmZmZmZmZmYzAxNWYxZTAgUkNYOiAwMDAwMDAwMDAwMDAwMDAwDQo+
IFJEWDogZmZmZjg4ODE3OGQwMTAwMCBSU0k6IGZmZmZmZmZmYzAxNWYxZTAgUkRJOiBmZmZmODg4
MTc4ZDAxMDAwDQo+IFJCUDogZmZmZmZmZmY4MjJmNzM4MCBSMDg6IGZmZmY4ODgxMDNkNzgyYjgg
UjA5OiBmZmZmODg4MTAzNjkxOGIwDQo+IFIxMDogMDAwMDAwMDAwMDAyMDAwMCBSMTE6IDAwMDAw
MDAwMDAwMDAwMDAgUjEyOiBmZmZmYzkwMDA1NGQ3ZTgwDQo+IFIxMzogZmZmZmM5MDAwNTRkN2U1
OCBSMTQ6IGZmZmY4ODgxMDRkZTFkNDggUjE1OiAwMDAwMDAwMDAwMDAwMDAxDQo+ICDCoD8gbnZt
ZV9zdWJzeXNfc2hvd190eXBlKzB4NTAvMHg1MCBbbnZtZV9jb3JlXQ0KPiAgwqBkZXZfYXR0cl9z
aG93KzB4MTkvMHg0MA0KPiAgwqBzeXNmc19rZl9zZXFfc2hvdysweGE4LzB4ZTANCj4gIMKgc2Vx
X3JlYWRfaXRlcisweDExYy8weDRiMA0KPiAgwqBuZXdfc3luY19yZWFkKzB4MTA2LzB4MTgwDQo+
ICDCoHZmc19yZWFkKzB4MTM4LzB4MTkwDQo+ICDCoGtzeXNfcmVhZCsweDVmLzB4ZTANCj4gIMKg
ZG9fc3lzY2FsbF82NCsweDNiLzB4OTANCj4gIMKgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2Zy
YW1lKzB4NDQvMHhhZQ0KPiBSSVA6IDAwMzM6MHg3ZjhmZGJlNzE3MDINCj4gQ29kZTogYzAgZTkg
YjIgZmUgZmYgZmYgNTAgNDggOGQgM2QgY2EgMmEgMGEgMDAgZTggYjUgZTggMDEgMDAgMGYgMWYg
NDQgDQo+IDAwIDAwIGYzIDBmIDFlIGZhIDY0IDhiIDA0IDI1IDE4IDAwIDAwIDAwIDg1IGMwIDc1
IDEwIDBmIDA1IDw0OD4gM2QgMDAgDQo+IGYwIGZmIGZmIDc3IDU2IGMzIDBmIDFmIDQ0IDAwIDAw
IDQ4IDgzIGVjIDI4IDQ4IDg5IDU0IDI0DQo+IFJTUDogMDAyYjowMDAwN2ZmYzcwZjMxYmQ4IEVG
TEFHUzogMDAwMDAyNDYgT1JJR19SQVg6IDAwMDAwMDAwMDAwMDAwMDANCj4gUkFYOiBmZmZmZmZm
ZmZmZmZmZmRhIFJCWDogMDAwMDAwMDAwMGQxMDk3MCBSQ1g6IDAwMDA3ZjhmZGJlNzE3MDINCj4g
UkRYOiAwMDAwMDAwMDAwMDAwZmZmIFJTSTogMDAwMDdmZmM3MGYzMWJlMCBSREk6IDAwMDAwMDAw
MDAwMDAwMDMNCj4gUkJQOiAwMDAwN2ZmYzcwZjMxYmUwIFIwODogMDAwMDAwMDAwMGQxMDgzMCBS
MDk6IDAwMDA3ZjhmZGJmMDc0ZTANCj4gUjEwOiAwMDAwMDAwMDAwMDAwMDAwIFIxMTogMDAwMDAw
MDAwMDAwMDI0NiBSMTI6IDAwMDAwMDAwMDAwMDAwMDMNCj4gUjEzOiAwMDAwN2Y4ZmRiYTZkYWYw
IFIxNDogMDAwMDAwMDAwMGQxODVhMyBSMTU6IDAwMDAwMDAwMDBkMTA0YzANCj4gIMKgPC9UQVNL
Pg0KPiANCg0KU2VudCBvdXQgYSBwYXRjaCB0aGF0IGZpeGVzIGl0LCBwbGVhc2UgaGF2ZSBhIGxv
b2suDQo=

