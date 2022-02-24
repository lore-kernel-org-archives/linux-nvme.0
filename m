Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7D1C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Feb 2022 22:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zDgFA18mnVZ0sjzkp7wI1IL7pwlh/lqeorK2RjM1gqQ=; b=J9mQRaGh2Vs6xh/ZB2aPTXy/RP
	OJk6V3j3pNOcS3d7MGfFH7j6A2z2NATAa03EfzN5xmIrXYGhPvDnvP0K6WtGSaIM24yGnQMRU/5CL
	OWDSZFSNWMyJzLJANvfCzKve6KOIIKH5bqwXAo6Y5yU2sCUB7uXrU44ADHNA4f5EiYLzVRbdTdS4t
	90QLE7HgWAZUYOjp6RMdXKEwPY5tIAIPoUB80fd+MLYqt5GuJWksw6+R47JESdFTKV+YmQvGWjig8
	56f4BXKhG2Ug/wRvHvWxMPZSh7PXDj3C2uD2P3bYaW7Q4vPH2jxJMWOilE2/TJxROU53X5KG9ae1X
	nilXnvjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nNMyY-002b2c-RT; Thu, 24 Feb 2022 22:52:42 +0000
Received: from mail-mw2nam08on20628.outbound.protection.outlook.com
 ([2a01:111:f400:7e8c::628]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nNMyV-002b1k-Lk
 for linux-nvme@lists.infradead.org; Thu, 24 Feb 2022 22:52:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8wXUxOwfH7x7YWG7OFYcBN67pflCHSwVBwKba8LQK+eRYahz/L2iIU3IaKW2na3mTYWIL47RZTcXEhUIC3z7AuAOmGx399fxJXPm7nYMaCBGrwYQDFa6l+9N47S4LCe9BcquABBPtatd9lpLVjWKKbz7cHnS/MYxPIlYSKP6fPHYcGrCaZgir/hgeXhKa8H/Qq/pJKq/i+kZVqRDNshaZBC9cACagynQ1VjZIl5Zm0myJCfu9hiWVGZp1qemGIAErFm8V3jz42kZDg/3sth5CrZmviI/aPEmfqVvgXXyzf1WNg4mcoaFksXIWeZesGjWiuLPo63QmV/O2LInp80jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDgFA18mnVZ0sjzkp7wI1IL7pwlh/lqeorK2RjM1gqQ=;
 b=GQqbRZTiiEawupwZ19Pp7hCItECHhp4HnNWzfq5H6nLrRZ56BG+gyhQ778Hht4ov9VH9MivpLxxVmnjRezK6H7uQ9YYq6tNBIFQdK4qx8/vw+aHJbU2DDYHkpO+T3bGhtIpiMFPa1dXRhsNctQh+15qb8cOuOekn3b0QsQmDke2wfVLaHssVCAYH55PJtZWeWBlZ9LK/flAr569vYNjaEk8u2JdUneAi/ltQUSkHObHiBiNJGSY+gqUJFMu3RaJ64gc5Rqn0O9U+T5xKSElFuRc/d00HxSuad2duvbs42LF9q6reW1JhVMmIlrRgvAoLu4vnJnKupIDAmp65zXvxFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDgFA18mnVZ0sjzkp7wI1IL7pwlh/lqeorK2RjM1gqQ=;
 b=NgeTGwwHkwYhNxWiFTSuRhTP1jGT9KndwTrPx1uJV+G4fC3Y8MmSNiIW1olOXVCxeOrgsRAmIhyKCtsHy7LrLcziFFMAfTfF01/1rQo8fAOnP2D0YqEQs/UtlXTZ9V+fszG/wsk5Hy5ULh5L5O1T+Qld6BhnnBcibbL4tHFM1I38WGtt1cDsLt/83ejdCPdanMb2wNvXPEGFN2KywuZGKB7aQe6iOfJPSCwqmcU2nlIIjrce9eUFxeT6kJ28K90PLQDMfKXJxcdGyIQNMsbNCQLNyziYl8UFnbB9HSsCdHjPGAQiD+uf8despxMcwO8vDbdJ3F1I7mDwchbVqWsZvg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM6PR12MB3147.namprd12.prod.outlook.com (2603:10b6:5:11d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Thu, 24 Feb
 2022 22:52:35 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.4995.027; Thu, 24 Feb 2022
 22:52:35 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Sagi
 Grimberg <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 3/4] nvme: check for duplicate identifiers earlier
Thread-Topic: [PATCH 3/4] nvme: check for duplicate identifiers earlier
Thread-Index: AQHYKbUB+QvVeq+ztES+CaW56dcEd6yjTwIA
Date: Thu, 24 Feb 2022 22:52:35 +0000
Message-ID: <227de5c9-c963-f16d-2000-578ab8998567@nvidia.com>
References: <20220224192845.1097602-1-hch@lst.de>
 <20220224192845.1097602-4-hch@lst.de>
In-Reply-To: <20220224192845.1097602-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9788a25e-42fd-4724-1f28-08d9f7e8593c
x-ms-traffictypediagnostic: DM6PR12MB3147:EE_
x-microsoft-antispam-prvs: <DM6PR12MB314736E739F6066FED912DBAA33D9@DM6PR12MB3147.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GsjQY62MmaDsCyy1Qk0RB34M4BI/plrQ4zWVhvu87LcmqpPuaLcIMV+2FGNpnizVikkOPv5KbiWc8JdYj+hDZDHQ7rzz7qtcugywefRDSs23B13h1RjED8D03inyHKon7BQKcuMOvV8m9WX05SjbtKGop7ZHJ9yolejxbH2530D0y5COVhOZFSWHvdbN1WSpULMNYMHCsheXFlSEVJBDnbizzRYRSTF2CxPNh9p+CBmotaoO54b4/+Z+AIAJXmhCqy3/tS2ThcpvbuMR4zMhlOdYlMmwMqDFAuuTMgtyjUpwzhDKRHaWg5yV3gY7SPUjt7HLj+DLpbNt1fE5FcML1pkekD4kHjgzMSTIISORWygoPRb833CmY6zTDHvyewceCx1JzeP4r5mDnVgWa8pZllJ9AqHmFI/ZHhVCOW9GNQW5yoOqzte0LjhiUpNRFQpQFgBanGLPkqmjYTwItoFYCh4XSArGRuK4/b15Cq0q8XW0yl/Ame9DHjssaZIJcu8B1svncHqnuDeo9GU5AuDkJo6DginhFKrqejjJfAYViTgcyHATC5eq4B8bXlFGjqwMXBoWtdK6QS0/v2ES07GSiWebhH7f/Xm0G1OWMh2HxrNm2HxQwTtWmgb1NB9r5wg7GAnLmcmhA9KcIUwAdyUw0jXRaH35GIsXYh/7RPSYRLt9/c0audX6hRDbE+lPGZbr1eg0QyWjrCGdDumAQv03BOdDtTGzoljG4wlmXXlYU9LmIaxMLtMKbbGCghQ89GUYs0b/eNHIugvvNPlXjakh2Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(2616005)(36756003)(6486002)(6512007)(83380400001)(186003)(2906002)(71200400001)(4744005)(53546011)(8936002)(5660300002)(86362001)(31696002)(316002)(38070700005)(66946007)(66446008)(91956017)(76116006)(4326008)(64756008)(66476007)(66556008)(31686004)(8676002)(38100700002)(6506007)(110136005)(122000001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHkrcUhudEI1Mkh1a2dwS29PSDNlM0E1Sm9ZNUVDcDBxL1hMdXJnQlIrNzNC?=
 =?utf-8?B?UGFuMGNjVTNONnE3dzQ0dENrZnZoSEJpd2lFbVFTZnFDa2VHeHJtdEc3dzNq?=
 =?utf-8?B?QUJPV1pSSFF0d0pvZnZVcFVQUGdHdU1uLzcvYVF5bkd5UThEalNvRGQ1MlUr?=
 =?utf-8?B?RFdyWXorcjlkYW9VOSsrRzBjUy91ZHdBc1hOKzQ1M29Rb0NJam9WcURNN0JJ?=
 =?utf-8?B?c2RkUUlCaGVJbjErb2kwMU1BaVNKbmc5S21uN3E1cUtBaWFIOHpVMjFkVG5F?=
 =?utf-8?B?YUpjUGRNYlYrdWlYaFdid0FpRXpLY3JESVlYOUdvak9GUmxwTERmVG1TT1Q2?=
 =?utf-8?B?TmNIdFVtK1Mvb0dGK0sycG1UK0Z0Uk9UN2NMWElCQkhqN05LNjM2Lzd1SVZG?=
 =?utf-8?B?emhFKy9QZ2hEWnlrUWdZOTVpaGk4TGdOQlo0cllqNnk4VEZhSndiR28xYnRS?=
 =?utf-8?B?TFJZam9rVlhkMHZiMzFobFdCOFRsSWMyTXpzVnRFT2JsWmdXK2FFb3RGVUhD?=
 =?utf-8?B?c2VKMDJveUhaNUNFRGpzaUVFOXpZejQ0UkdPK2owTEM3dS9zYzVyK3VzOEFx?=
 =?utf-8?B?N3Y4YzRocUZVM2tsb3QvRkRjSnZCb1doUVQ1SHJsV0NvNlJJMU9hSExxZGxx?=
 =?utf-8?B?UkNMUXZPMUJxd1VDa21TeHJTd0NrdjFjcDRvaDEvcjRTT3Q3eU05SDViUlBy?=
 =?utf-8?B?Rkd2c2tEczNaR3FDU3ZQMU1Rc2hkUGJ4Tmd5YmFWYURXMnU1bXZFZkhTNFB4?=
 =?utf-8?B?SmRyQm9iUGx1TUFGYWRpeW9zcEFHelQ4Q3J0eUQyM1lmQTEvd2dCem9rRDFC?=
 =?utf-8?B?Zm1JZlRLbEh4cjkxc2hVSEptV1A3cTQ2Z21tVGt1R2pNRVo5MDRvT013MFc4?=
 =?utf-8?B?OVhrTy80emJoaCt4emZSMTkySWh3NTdxVXVRS2w1SFhwakJoN0pGNWhXYU5T?=
 =?utf-8?B?NG00cTJadWNxWUtMZ2hWN0t2bmFaYW1Xa2RGaVhtQUpTa045NE9HM1BzY0di?=
 =?utf-8?B?YWJHeVhpYUs4bHE1RUpmL0F5aUtFZ3lhYWNJQnYxNEExUDQvcDJXQUFXVTlR?=
 =?utf-8?B?UmxyYVNzN0NPTGNiaGQxdEZ5UVZ3NEZkNW1aWG83YnYzQk83ZU93cXZLd05q?=
 =?utf-8?B?bklTb2FqVTlBT3dGY2U5eisvY1RxY1dRd3dhRFBoS3BoekRSUzg0WGU0UWk2?=
 =?utf-8?B?VG5mWDV2a1o4OVQvK2R1TEptUng1VmpVK1VHMm13OU9LNTVockdiK1lmMkZH?=
 =?utf-8?B?RUd3Nm1QZlA4TWVqUU8wQzErOW5Rcnc4MjRGTFI4TVZmYzZLY1liL2RZQ2Ft?=
 =?utf-8?B?elZzWm5YTGhVRXNuK3ozZ1RlMVFLeVBhL1FTUUoweDZUK0FUcXVoYzVUSVZn?=
 =?utf-8?B?YkJJeGdPY0pyS0wyTGZEdWgvcG8zSFlJdWJCbDZPSng0UFNSclMzcWRwaFlz?=
 =?utf-8?B?L05sSG13ZFc4TUtYT2NHVkRndGtlaUlSbHBqMWVadlNWdnVQMXRWSDYzaW1N?=
 =?utf-8?B?ZW9RZC9LczIrVlVyajRYSnVGNlEvMXVTTzFPbVBxZ3RpRjJzcndicUJjaGhL?=
 =?utf-8?B?dFdBQjJrcEZNU29IelJZaHVCNU9KTElLNTJoQTc3RzIwWis5NXNSdjVyT1Fz?=
 =?utf-8?B?QVZ3Q0JoNG80ODBXYnphejNIUzFiQUxxNnVFU2hnZE9Vc04yeU04ZlJKSExE?=
 =?utf-8?B?dExtaTdFb3htR1ZMVWRIekd4emVNK2UxNUtYbnJGL2pTT1dVMkhQdGNKRkt5?=
 =?utf-8?B?ZVJSY2FTRXkwZExRRU5nd0pJT1EyS1hOb1p1MDQ2Q0JqZmdCNTM2TklTUnRy?=
 =?utf-8?B?TWdpbkk2SmEydE9QQzl0a0FZak9nQWJJSitEZEwxeWMrRHlyc0pzcU82c2J3?=
 =?utf-8?B?TTFWQkUrM3NldE5MKzlwRFlEaTY1WGdOcGtJKzhTVy9pbnRyUHozc2ZvbU04?=
 =?utf-8?B?TE1oK0dEL1RXTXpKeVpUeHVHTG44SnlxR0Q0NkpFNTNybnRVK0paVHpaZE8r?=
 =?utf-8?B?OVc5Qnk5bVYwTzRMb0lWTGxkN1hBUzQxQk9TcVNEdWtyZk9DSEFFTDZIcS85?=
 =?utf-8?B?cytaZ0JRU2dnTCtrR01CS0JOUHdOVkZ1V0o1UGtaTlZSRVBWOEQ2c29ETjg2?=
 =?utf-8?B?elpKbkVBT2s5S1hETjNHR0FzTnR6b1hBcE9wQzVlKy9YVmdyWDYvTldlUEVZ?=
 =?utf-8?B?WHF3dDZLN0RIYXpOZUJYU2gyOUNqYlIyZUEvd1VreEVadnB0Z3ZjY2xmRWJ4?=
 =?utf-8?B?QzdFT2ZnSzVSb2VialFpOE5hODR3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <522C9B9F34D86D4BB23E057627DD17A2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9788a25e-42fd-4724-1f28-08d9f7e8593c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2022 22:52:35.0596 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7QFA5d/1wGWZaQsAjFp9xH4luFaEdDBH+95jdXCc96p8Uq9QCesY7gM/V/FFmXlHE+KZau994vpt+zjMxDYebQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3147
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220224_145239_740547_EB6C2E9B 
X-CRM114-Status: GOOD (  14.40  )
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

T24gMi8yNC8yMiAxMToyOCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IExpZnQgdGhlIGNo
ZWNrIGZvciBkdXBsaWNhdGUgaWRlbnRpZmllcnMgaW50byBudm1lX2luaXRfbnNfaGVhZCwgd2hp
Y2gNCj4gYXZvaWRzIHBvaW50bGVzcyBlcnJvciB1bndpbmRpbmcgaW4gY2FzZSB0aGV5IGRvbid0
IG1hdGNoLCBhbmQgYWxzbw0KPiBtYXRjaGVzIHdoZXJlIHdlIGNoZWNrIGlkZW50aWZpZXIgdmFs
aWRpdHkgZm9yIHRoZSBtdWx0aXBhdGggY2FzZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENocmlz
dG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiAtLS0NCj4gICBkcml2ZXJzL252bWUvaG9zdC9j
b3JlLmMgfCAxMyArKysrKystLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9u
cygrKSwgNyBkZWxldGlvbnMoLSkNCj4gDQoNCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6
IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCg0K

