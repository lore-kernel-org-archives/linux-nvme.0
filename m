Return-Path: <SRS0=8pqL=PP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0288BC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Oct 2021 00:16:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5B956103B
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Oct 2021 00:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C5B956103B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WT6H7xlGF4K8whPUdklocPdk3FBr97bahVCBl9jxEQQ=; b=4xJDghbnnbYy/FfIsvb/X3WNH1
	pzrMVWWDwZnOr04/DjMi6pOfrwOt0k59MOl3DId0xhk/4lAkW+lH+PL5KFKgSj//9uyY3vzv+ae6X
	ux1IDftvAwNQW8JdER7nMsIvM4ze7Nk1QhkqhfjLcQnKytz2dXMss+2aG/fw+oZ68pZSbhbkUOk0U
	qwqURgfO8bzmKvtGCi749IWaQez6x0ockpVqTGnpkFMGrgrCcfhCKTn/pnsPsrA2CuKLSSNX2fOWC
	18s5vni9cdN/jOYacaJx9uLyOtWZOvdomj0OPM6Uk4iPhITw60keKpZBSYzzH/d4XNG9xCWYWAgM4
	M8cz2ZNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mfWbl-003NGN-Ne; Wed, 27 Oct 2021 00:15:57 +0000
Received: from mail-mw2nam10on2072.outbound.protection.outlook.com
 ([40.107.94.72] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mfWbd-003NEc-Lc
 for linux-nvme@lists.infradead.org; Wed, 27 Oct 2021 00:15:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMYwkWXomGjEvV17P/4QsD6LuZcOoEyc+tuSfrs2nzIMGOFGeeTjipaKJ8QDZ6zOyZeUdP6FKoHZz5mTOwHn1xbOcJIlyKzz+d/Ux8hRqRNSXuxpl3g3xgEr2a7w1fSVB/Ho9oqOZZHQtmfmw1A7AooDpIzZqig8gc9mluQJFWLEyUD0iCaruBlT1Xg6v2AU/EvWRHlCDsGy9l7y3Qlaf/Ckfk0ivjZ9L/+CsobXMCA1WQcCP9ClApgSXaV6Gl31718W560EMrjHmdYHByh1wRiyyPmeKLIpc0ULKiN3rtBB5TCLZgqoQ9JmogI1KWdl/kSynM5aqtTFGqfN/fJS1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WT6H7xlGF4K8whPUdklocPdk3FBr97bahVCBl9jxEQQ=;
 b=Cc4Ti29WFfU7as2UkB+6hppdt27qfeSKljCIhlb2u8VwEcfeZcOKHmmNtNSO6c1RIU1M2oQsGqTogw/kgWd90Z2W4SFhK2Ags/kGhmcUoMiqnNKR7K7HKQqw5Rrx/44UlEEQDrQ/Twz8g95ALw3MU1spC4B9zaOjKtANsFcKwiUIDLUfjBQdZkR5xS2ZmD+zMjUpY9IcJMGA2AM/9A/DSVKOz02SybOuu7jwIkQbr6uBlDps1+aibTa7/kWxdhKqADhba1mXAtiES5z1irsBZbJYMsUjDabtwkoYLUKfY8LT4APFDSBOJqmRkzF0FPlQ3oZBdhNrJy9gvq5FrPIQlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WT6H7xlGF4K8whPUdklocPdk3FBr97bahVCBl9jxEQQ=;
 b=k5fCYtMuN1wkgua/L+FL7+gwXq0tDIGLXGPXXpgNzwFOxhq24xHe8d6xLo0aFygoEie1IYW7lZrzjKwjSCZWXOUX2ALuwG/iEvNDgWNu+NPKPOjGuggxmcnkeySfNuNLXUn6umXLHfctMil88L6byPhwwRdRZ4zQ0XBS1pZSJs/IvrlY6+sq+CjAPjrQUG7R5MYLXUPAZ2CsuompeMNvrdL/IRogeOZdW3tvHono0prEWhF/YKpcvBQmclyHP8ixnaJvhj6v1wrm8800/s5AoHjZEVylJ/C5wyuELvRGdvCBKnVJlVCefo/vS2jj2+wrLR/dnr/6OtjPaGS1PHQ2yg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1725.namprd12.prod.outlook.com (2603:10b6:300:106::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 00:15:45 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4628.020; Wed, 27 Oct 2021
 00:15:45 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: John Meneghini <jmeneghi@redhat.com>, Maurizio Lombardi
 <mlombard@redhat.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "hare@suse.de" <hare@suse.de>, "chaitanya.kulkarni@wdc.com"
 <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH 1/2] nvmet: add an helper to free the iovec
Thread-Topic: [PATCH 1/2] nvmet: add an helper to free the iovec
Thread-Index: AQHXxlfexGmmpBnIsESpZnxQyb51favdiuYAgAh3/IA=
Date: Wed, 27 Oct 2021 00:15:45 +0000
Message-ID: <d2203f90-a993-10f2-d0d9-8c5316f7360c@nvidia.com>
References: <20211021084155.16109-1-mlombard@redhat.com>
 <20211021084155.16109-2-mlombard@redhat.com>
 <56f23216-0b70-972b-7a24-8f496e62992e@redhat.com>
In-Reply-To: <56f23216-0b70-972b-7a24-8f496e62992e@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0f0fd56-f6a8-48d5-8b40-08d998deebbd
x-ms-traffictypediagnostic: MWHPR12MB1725:
x-microsoft-antispam-prvs: <MWHPR12MB17254F8FA54F39CEA8956CA8A3859@MWHPR12MB1725.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hnHJ8SNljlZm5ao+tMURz9yyh7hwHNGpP9i7qxHNdBKLCubYMuYcaHv3zWaueXmx4PLzWrhtFS0w9h9Oa2ExGN5dStohRBmTIHpjBXZSLtN+wk0GlXBqUP6GGWxBIgnF15LhCkao1Q1AnTzbieHTtGBjQHc/TSoOzzQLlATk10heoUCJfnreLT8lmM3QxNnxVVt02zxOsE4xmIjO7GEkMqs3J88C4EgzK92tea9bv+rDSxalpolXuZNSadOjZjRxF+Yr9IHnk9b8VlUtvGCWW9k6Zwjyg0SrKFJoio4A08VERPtb1pFBjK/GLuteVXc+Bbm/jNXtJ7HiFF70FaDK61bCHlWRD0VE1VJFQI5n1eY5BZBwj8Z/t9+KcbcSTdCjlz1xFDZ3U+Dy7dhmEu6BhbWREPhaE7MUcXrfcDehxvRj2smKL0Cmibng+MCKItyIZIgRX7dDTwhrfjErb4IyGf0nRuSJjqWVmJVPYPSivW83hUuwsHwcCYw1YaOXKJC5zfr7MQFtrFeMCsYRsHHXtsqXdrEPqZsi1C7KCyJQRFzROAmJJGU+I0FdEupGQuLJ6m/adBVVcfqCGEeueSYFjkedFUpBMo8x3bWC0MYK4WedG7jOwwv+7Yi/buZNRPKQIP2bS2bju5b9O2QacPl+nZnjqvm2AvMDctgqRX1/9hepCJ3YLCAL1hS3IIdkZ9P6UmyINQhku4RsTXJyp26MgOuupI54Hol3n0FGRyxbx5v8Vy059NF1Jre0NQ9kVw7YmPGzVaJUMByNWHFQ7C06TQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31696002)(122000001)(6512007)(508600001)(8676002)(66946007)(38100700002)(6506007)(31686004)(186003)(2616005)(36756003)(86362001)(6486002)(4744005)(76116006)(53546011)(5660300002)(38070700005)(316002)(71200400001)(4326008)(66476007)(64756008)(66446008)(66556008)(8936002)(110136005)(54906003)(83380400001)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUU3bFVjWkI4SmtreDBqVFNRV0IyM0xoaHRXMGFwSERVczE1amlFNmp0MHk0?=
 =?utf-8?B?WTZ4U2Z0eVNFOHk1U0pWY3RxVVpzcjJPaTJtcW5zc2ZubkdIVzhZdEJVUmww?=
 =?utf-8?B?dmVGSTA2eGpCQ1Y2ZzE0d05wT05zMDBVSUs3ZTFvcDhFU0NnL2VNV3QxYko0?=
 =?utf-8?B?MzJQZTJKdnJlSVRhbE0yQVhHQU5OOTZwU3RNcnZqSjdIcHJJdGJLblpwNUNI?=
 =?utf-8?B?V2pPQVpJME14OERiVGREbGEyUTMxbHBwRk5xdEZpTURxVmJ0cnhaRXZaNmpP?=
 =?utf-8?B?OTJQL0d5WlpjVHR6ejJqRlV1Wm9JZW1tUnBnQytBd1VYR0JqU0ZXOUxjMHE5?=
 =?utf-8?B?RGhtSlBUckw1ekZJUzJ6a0dCYUdmWVR0NDJJMlJWM3kzNXhrVWJvcG9XeGRI?=
 =?utf-8?B?Z1pqTXNiOGtSNGI1MjZ4N3NWeHFGK0xrRGxUdk9TTnZvNDlpYnlvUkpLOEZU?=
 =?utf-8?B?L0RObXZLZmpUMzRVZ2svYll4cmlTcVpaV21OK2s3d3VkbHJhWEl0WHpPd0Zr?=
 =?utf-8?B?QkNRTDlqU1g5bXpDc3hzcUdZcWxJZ1dDV0YxczNJbTdBaTRHaHNYR2NQT0FI?=
 =?utf-8?B?TENoUzdwaC9XelY3aEg5WFNINjl4bGErUDdBRDlkRmcyWnd4ZjU5ZzRyMHgz?=
 =?utf-8?B?a3dCVTdMSG15UzdsenRJVXdyK1BNNGkvUEJIS0pTYUE0M2VWRGo0ZVVXaTk5?=
 =?utf-8?B?dHE1VWY1bHlKQzJwclZ1R3ZoUTg4SVZXakRhTmxaNHAwVERNS3k2RFBNdHVZ?=
 =?utf-8?B?YmN4ODFtMW9VNE81TVdKV1ltU2V3Ym12UmpOaEVpVWErelduK0RxMzFRQnRH?=
 =?utf-8?B?NkVidFZRcytqK0tibEd0akU5ZDVheGtRUnh0ZTYyMXB6YzVncFNaRmtmSG1L?=
 =?utf-8?B?bXN6ZDkweXZQbFUvYlZ3cEJBc1FWSnlqblErZnM5NDU0UEd2ZmJOMitpSk9u?=
 =?utf-8?B?aUpnMDFpZXNVc0ZuRnhCenZjVWNzSFNTN0lFRWg3SmkydWV4OVZsV1o5V2Nu?=
 =?utf-8?B?REwyMk9YQXZOYVFnalJnVld6UkFMRS9JQTAvL08zQkxnZklFNENMUjh2bXVJ?=
 =?utf-8?B?RDZIMlpUSGQxa2wxY2pzYnNjcVM3TzVyMnhvU1MzRXVyaTlXNHhmbTRJeWdU?=
 =?utf-8?B?N3lTbWR5OGFMQU9xenoyQ0RKWjRDUEcwc3dQZTU0VDBYRmdnWjh6V1IyNll4?=
 =?utf-8?B?UDhaUmZBNUtRd1BkSGhXQmlRSVR6WVE0ZzBReFpMd0l5V2N4alFUdW5ETTBN?=
 =?utf-8?B?TWdRUU9FWGNCSnNuRzQwV1M4STFuTUxvQ0hxbk0xK08vNWc4RTdvQUgwWCt4?=
 =?utf-8?B?VXFSSG44bFBSK0ZvSkFMM0RyZUpVUFNKa3pZdS9BZnVWYzZ2elVwbzMwVEhZ?=
 =?utf-8?B?RlJEbVR1azA0Sld6M1NuWkxmZEZ6ZytmMEVMLzFUTGtsdkRkS285UDROdU56?=
 =?utf-8?B?cjEvYVdVWXBucFRBNEdVOGp5MmpIUlhWNWFYdmhUUUMyZEtpY2ZIamN0NkhV?=
 =?utf-8?B?YjNtMEthRzAzazNNQ3FYZXZrdEE3czJ2eDlyRDNZeVA2RFd1dEpaWkV3b2hr?=
 =?utf-8?B?T25meG5HeXEyL2tsWURxV2xFcHpGeTROOXdvNVdBNUxGcjU5U29VZEhxenAy?=
 =?utf-8?B?ZzJaN21ZV2JOb1U5dFNWT2Irb0VId3cxM1JkSTV3YzBHSkVBSjdlWmVNQzhE?=
 =?utf-8?B?dUM0R2ZXaUdtWkdMSjJSQ1JucGpVa1gxWHhSb1pJKzNCWERRTjFQS2Q4eDlz?=
 =?utf-8?B?WHdDeUJmUGZiY21laXpLZG5zRFVhWE9acHYxdmswSS9Vd0lSUk1kMFgwc3dY?=
 =?utf-8?B?UnFsYWkvQWR2dXZsTUtPTis1bWhWaEVjajhjT1Nmc1gzeDUyVmR2aW0vaGwr?=
 =?utf-8?B?VHlXK3VMOXVmVnZpVStUSkdDeitUSkgrTzBML2g0R3JIbTY3VXhnaWw3SlNk?=
 =?utf-8?B?Ny9KU0RXRVoyS3RxRWFja1M2N0ZOc3hqSTMvQ3lKZ1dQUTBBaUdDdnc3TTV1?=
 =?utf-8?B?YzFVU0Jyd1l4M2RiK0VESGtNMU0zemZPb1lGN3NKc283QUJtcFdRSmU4RVFW?=
 =?utf-8?B?T0g1ZTBDMWx0VWFQbnlUa3F3TjBrVUEyZlVhMkEycWQySEpGTVYzSDVoRXg1?=
 =?utf-8?B?MHhDM1FkdjF6dnJobmxlRmxZcmEycUpJRUYvaGJSNlBORmM0UGx2cEM4cTVj?=
 =?utf-8?Q?vArxvVy2VSZUEH0t5y8iSVMeujx/hiwLSwT9TjhvpSD/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCBF6AF4755E5E4AB491279C54517F53@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f0fd56-f6a8-48d5-8b40-08d998deebbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2021 00:15:45.3485 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tGE8aqXcNQCjoHa9v+FNpcEN3Lfxa/bPKNyiG9BBssUvpF+OZbN+vz/yjrDHb+ktpg6rmBFPZd5/Zmw5uzV7Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1725
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211026_171549_758565_BC3408F9 
X-CRM114-Status: GOOD (  12.83  )
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

T24gMTAvMjEvMjEgNzo1NiBBTSwgSm9obiBNZW5lZ2hpbmkgd3JvdGU6DQo+IExvb2tzIGdvb2Qg
TWF1cml6aW8uDQo+IA0KPiBZb3Ugc2hvdWxkIGFsc28gbWVudGlvbiB0aGF0IHlvdSBoYXZlIGEg
c2ltcGxlIHRlc3QgeW91IGNhbiBydW4gd2hpY2ggDQo+IHJlcHJvZHVjZXMgdGhpcyBidWcgYW5k
IHJlc3VsdHMgaW4gYSBrZXJuZWwgcGFuaWMuDQo+IA0KPiBXZSBtaWdodCB3YW50IHRvIGFkZCB0
aGF0IHRlc3QgdG8gdGhlIGJsa3Rlc3RzIHRvb2wuDQo+IA0KPiBSZXZpZXdlZC1ieTogSm9obiBN
ZW5lZ2hpbmkgPGptZW5lZ2hpLnJlZGhhdC5jb20+DQo+IA0KDQoNClBsZWFzZSBhZGQgdGhpcyB0
ZXN0IHRvIGJsb2NrIHRlc3RzIHNvIHRoYXQgdGhpcyB3aWxsIGdldCB0ZXN0ZWQNCm9uIHJlZ3Vs
YXIgYmFzaXMuDQoNCg0KDQo=

