Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1FA1C38A2D
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Oct 2022 18:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2BWC/TZv3f+IfopgGzDPMsZsa5EriRfCRD8Ca1Emv9Q=; b=xCz4B/n3yCwm2BjxFVqOKUstfA
	+/mGggD5hX/OOJlIUMiR7i67BB7577SV9fnzsb0zScGnjDZOMfy6qz2Vmm/s6UEjYJeqmGeZ/9LNq
	aw6B7o4dO1kaH0u1nFhx0t1YDOZFfNDuwVEOQ0KymipDDcEDhHcDfj8voYmOlu4BJZWbz+udwBog0
	lhiZHPxa9EY6f2sKW7oWt2aJtc/XNA+CflmI272QVdtMr4Z8H5Ctl+QNTTOBInTcv1/dFoeVFZRY0
	6M4IHqxFMsAsztwUnut86jkhDU42Fo8YFtPP5O4VRPtEQfEbH9KrLV2+NiSgef4fcwcdj+RTbkD/E
	nw4qKBfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onklj-00ATWK-4E; Wed, 26 Oct 2022 18:04:47 +0000
Received: from mail-dm6nam11on2086.outbound.protection.outlook.com ([40.107.223.86] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onklg-00ATVV-8j
	for linux-nvme@lists.infradead.org; Wed, 26 Oct 2022 18:04:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fG27dNpVlnd/rZeHDx3yy3bdpE0ltA8nLu9LycGIP3z4OS8Y36ATwi6AHuHvv5+0/6xrBzkq+xXGdQJhvWF+7m6sX5dv41z9Vw+0oVkIOqD6ei/xeh1lT+wcHLbP9WlJwHN67AMg5jepLqJdtVyxaqGw/tjm7YosggDyS9J8q5vtu7jztKCKSLHUA3RMLrPDLNG4fh3U/ytWvq5w00GVMOENSc77/CQzHfjONixabsSTfmLaPoTKD1MrToyJXvVpJd/r7U9hp7zicIdiAQHxZpwqSp3IFVXVNUUBfxTXBvYu7+y+FtLfeqxeaHwpRYS0WkDHQawQXaoQu6U2nReYaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2BWC/TZv3f+IfopgGzDPMsZsa5EriRfCRD8Ca1Emv9Q=;
 b=amGcz7yeQgJ16ZCdiE88+3PP46ce9ewvtQPDmIqfOuS6yCiksO8nLB9uNKieWraXayRtwjzX6gH2DFv9NlcoumTwFMsME3JkqmPFF3QUFyqo6BBNe02NYcNlLzPsjUTi0XP46Xe6IMJRgwLdjMTwL3UIFJGylUSSfPA9EdCDzBb70kjLWynGbyPZd2E9MsWfFtHxrQW1Sgt3JCAKT13Vx6tJtSsCJWsvUozQcc4FYxOLoY3V//7gCVMf/umbkQ8SyXq1gITAyOIRhE+/msLX14Brp7rLX71WEWBGFVeLNCowGWEuVALBgw1pAeUD2E8eBZ623bretf9Pchna7FOpvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BWC/TZv3f+IfopgGzDPMsZsa5EriRfCRD8Ca1Emv9Q=;
 b=FI6koTpLx5pz3dUImc8RQINaXeVxMbaAMwnJOSlv7KXWtq9wqpdUOStH8yOwvzEi8+CNou09A3zWd6p1BolZvGZ3AMRvYdG67cyP+KUBSk+J0QT1nZn7xPkA/GFWlPhEl0VIF8Owf7lm95E8TZ7qYnxc2qj6TjpjKLC5qKMydS4LyufrzDZA6tbKyGMJDyOZe6p8DIAUEZFBgcvIq1rQSmWFqp9yp8h1qZ6Xy5QsCfVmTSrEIGlviYchj5QfwMF29DGNHQLDs+grQqHgCd1NA+WOxB0VNArZuNyCys6/ltOqqweiJ5mMZc2DgyjbYnauCWe1f0VI1ygS8NOfCbsDMg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB5987.namprd12.prod.outlook.com (2603:10b6:8:6a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 18:04:32 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3%7]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 18:04:32 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>, Keith
 Busch <kbusch@kernel.org>, Daniel Wagner <dwagner@suse.de>, Alan Adamson
	<alan.adamson@oracle.com>
Subject: Re: [PATCH] nvme: quiet user passthrough command errors
Thread-Topic: [PATCH] nvme: quiet user passthrough command errors
Thread-Index: AQHY6V2S49CphEinZkm15ANzyd7xQ64g+BAA
Date: Wed, 26 Oct 2022 18:04:32 +0000
Message-ID: <52e66f7f-30a8-0726-3db5-dee2b010c1a2@nvidia.com>
References: <20221026170715.2657664-1-kbusch@meta.com>
In-Reply-To: <20221026170715.2657664-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM4PR12MB5987:EE_
x-ms-office365-filtering-correlation-id: 799c9614-5a4b-4a9d-9737-08dab77c88fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  YoQ4GW1B1RXkSPDynsjHNwXm1/98pKnW2ZVReB2TK0U5zOhGK53zsfeKKSWI73JK9ecJYQ9sn+pZWNo7sPYen4vPXfdSTXTeiXfl4QluJ4Cw4K3wf1UewSaT9T9t1uTcHdXv7yLs34FqMXumi19Iz2Wyy1gqLLaLAEx2KQnxXDxNo4krNGRw3gy6F8sSPJyRx5I6OwTbic8hydKuCBwI8KleDWba06z8LmC5FcRfj3GpBL9Y7lDkxvriFFCd17XeIPW0WoxjMzbMn3crHmgboWVgOc6nqO5y4hMr/atvUmq/msJMuh73Fe6YeKMCsDJkubkxA0VcS0LtfUw5Hyly9KG/zP1JDyb+ejvjz+QVOGRHpkZdJB/kreH7ys95BuVKKTs16CdkPgF3FaxOgidVbUn6jSdbzqbkYgAgn7ieJTsPD5JWbXBAho1xWCAjuLr6/4lxJKjanfmerO/m6ymQ8JTr23Zz+gCsjD0+WnqNlYBC2CTDbu7WC7An+vIm18XBA/OQQagDbHNOviB5DLZEtM20Q/u2039AEWtHUUA9YtSWdmgyukRmhQABdbM5Gkyp3Oc7rq2nbM/1CWHu1ErOOEl+a6HKu47pb2lsjx+/uRI857q4iFf3DbfwZDh7fJgTUxF/SPFyhDns2v6e34ADRveXKxmgu/jPEgFBUKkXkM8J5uSzFHEJTL0h3osY6KatDCWWVMA8UMkntHOrftCPkRNdUw6ZiCMK8FC7yMK7kgXGdzYRoRrWkKcpbSCMN8t3hnxqy+RSwlMuZ6ssYWdcNE1PdBWviiQEddAS0E333M4bDatLn//CcK9+RTO63rwb9FSPMmvcETlb2/wh8jVYEg==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199015)(31696002)(83380400001)(6486002)(478600001)(86362001)(71200400001)(31686004)(38100700002)(66476007)(2906002)(6512007)(53546011)(76116006)(64756008)(66946007)(8936002)(66556008)(6506007)(54906003)(110136005)(2616005)(66446008)(186003)(4326008)(316002)(122000001)(5660300002)(4744005)(36756003)(91956017)(8676002)(41300700001)(26005)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?VXcyN3MrOUxheDhjZTFYNFlnaWZVMmloaTNiK2N6NlRmOGhOOGRCampnMDRm?=
 =?utf-8?B?SlNXdVJycXZxdFR6S0tVZEJuclR2VXJxOFU4aE0rZmx5dmpQQlRwc1Y5M0tu?=
 =?utf-8?B?YzFsT0MzS1E2ZlFnOUlndGVMRFBnWGhJTXlKaURIdW8wU0xOWkpvaWdwR1VX?=
 =?utf-8?B?V1NvUGR4R1Z2QjlzUGNsZkJZS1FzWUxGbURvanNVTjhlOG13Q0E2cERkRG1r?=
 =?utf-8?B?TGlIa3dEYXZlY0lZZmQ1TjVXOXJ5MGNUODYxR1Q3TFFEMGl2akJpMGdBY0dK?=
 =?utf-8?B?NzEzeXNCZ3RxYlphdGpoZzJKQXBJT1o0REFUUFVzNjg5UmtaMjJ3NkU0dHIw?=
 =?utf-8?B?ZlI4TnhraThIYU5IQTZ2dnpTVWpSNWRhNnAyRzNBU01XbmpobHhSQUovSUNh?=
 =?utf-8?B?WmozMWI5K1NBU0xWY2JNMHh3cVNXNGxEY202V1JCZFZBVGRFc2lwQyt5VEZu?=
 =?utf-8?B?SWw2b2FXRE9GZjdqek5iUWUyUjZDWUFlU21zckIvQW1BMDZkS3dwRkFCaVBk?=
 =?utf-8?B?SzFBYlIzQkZiU1lVVUs4bjkrbFpWa1pnL01XY3B4YzNwbEsvdjlEQUEza2xv?=
 =?utf-8?B?b3M1OE9xUExTemZMT20xN2ZOWlcvVnY5RVhCTHRvWks2OHl5MlNFRmQzWHJv?=
 =?utf-8?B?OGNzU2xDWk92cktlbktmQWd0SG1PK2xubTRib2Y2UEUwSDVrSExlYUVXYTJD?=
 =?utf-8?B?V1dxWG5rLzk2NWU5Rm9kVGVuaTBuaE5OUHh2bm9hcno4eHJpNTVZcGg5UnpP?=
 =?utf-8?B?cG11UzNLTUpMd1B0RGZzam1Qd2xzaHV5enhsclNyVXJTamhra01QNXFsTCtY?=
 =?utf-8?B?dTRmUWxxSGdXSzdSRHVUNG15emVvQ2NEZElOcUhMRFdFemhuMzR1K1R4T0dj?=
 =?utf-8?B?SWlwaVhObkwzU3UzZFlxSGlwSU52SGt6Qm9sWTZJQjZxWFVxbTFWdGFIRytH?=
 =?utf-8?B?NzRPcjd1VDhTUGgxdTNPR29ESFNLRWpyZ1FXRURlRWVSRktjcEtEdEh0OWhL?=
 =?utf-8?B?WUt2UXNBV0l2blpZOGNJNFhpNzhTOXVoTER6bFdQTWMrb05FZ3lCQ1JBRVdx?=
 =?utf-8?B?eFlqTEFkOFU5b0RxeWFnR1JMZHdZZG94eVJpdU1jbFRYb0FuSVEyLzJVdHJR?=
 =?utf-8?B?ZEswRlBPa3VkSXJRUHNuRkw4RGJUUFk2Q3dVcWVMa2FpTmp4V0pocU9rNGow?=
 =?utf-8?B?WlJXcTc4d0M3MXNEcm5FUUJ1U0JwQnM1TW9Mdm4wdklXVXlIVmVOSXN3T2U0?=
 =?utf-8?B?L1ZJc29vNVdWK1NqUlp3K3RTaXhEa2xYRkhsRmtGdlpDNmVzRTNIcENOVDNE?=
 =?utf-8?B?R09EeXYvNUxWOWY5QlV1SDVOUllldVR3T09VV3pHNDRXU2t0VU5DY1U2bmRM?=
 =?utf-8?B?bjBSZDdLMkU5cDlFZWNUcTZ5Qy9LelJvMXphNUNueGw1a1g0V2pOMW5PVCtn?=
 =?utf-8?B?Q0tJVzhQa2xJYXB0RW5VNWdsMTMxN0daUmdwMDVieG1JOW1hcU5NbnpCb2My?=
 =?utf-8?B?YStDeWxjeDQzSUc1NE9nbGs0TjVyTStxL0k0eEQ4eXJrR2NHYnh4MWVFOGQ2?=
 =?utf-8?B?VDNjYVVjTzRrZ3oybmxiN1NId0lPalRPYnA2dk1lVHoxUFRjZW4vNS9VWHgx?=
 =?utf-8?B?Y2hzVmxheEZLalgrczFDMFJMRmJnWGtKWmkxZ28yd3ZHeS9xb1lGeTc0RUNF?=
 =?utf-8?B?WHdzYVRsazFKbTVJMXFLdFZFOXp1dEI0U01tVHpVVU9Rc243amtRRDlIb2c5?=
 =?utf-8?B?azFxbGFrUWdhL2cvSFd4d2dmckQrSjlQcFRCZFJkRlZCdjd6RDBIT0VQS3Yz?=
 =?utf-8?B?eDNJblB4Q2VKbGNkUG5iVW9obHVkb1Z3dmlDVkpGK2pRbkdTeXAwTVlRL0sz?=
 =?utf-8?B?YnBsaHFHUWxRcDBpcUU2SnM4MHRXay9paHgxWXJlc2tOeE0rU1FFMklidWdz?=
 =?utf-8?B?NmV6VER4d3A4d08rVGxjUkNoWkZqK3FxZnZQcE9xc3VuTDFqQUhmTWJZdTc1?=
 =?utf-8?B?SnFkNG5CTE1nV21ucUV0NWh3RzYwUWlMVm5IZm5jeXhuZUFuVDlIV0o0elFD?=
 =?utf-8?B?N3NHYXNOb25ZRFRzMWtSajJaR2ZUR1pUbTFsVkF5cHdHVlNVTlY0OVk2RGt0?=
 =?utf-8?Q?+LSL//UklupQU2Ld4ZzBR6sgA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB82A71A029AAC4B84EA2BF85DF050F0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 799c9614-5a4b-4a9d-9737-08dab77c88fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 18:04:32.8182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fI09d3uOCn0iJpzv7x+KHjYZMdWLGuNwAsSvDHhWBiKnHs0H8lrUUE1nKy3kLLeAjrWUN4Y79oFKG31ynKg3Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5987
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_110444_351864_2B2A116E 
X-CRM114-Status: GOOD (  10.82  )
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

T24gMTAvMjYvMjAyMiAxMDowNyBBTSwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEZyb206IEtlaXRo
IEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9yZz4NCj4gDQo+IFRoZSBkcml2ZXIgaXMgc3BhbW1pbmcg
dGhlIGtlcm5lbCBsb2dzIGZvciBlbnRpcmVseSBoYXJtbGVzcyBlcnJvcnMgZnJvbQ0KPiB1c2Vy
IHNwYWNlIHN1Ym1pdHRpbmcgdW5zdXBwb3J0ZWQgY29tbW1hbmRzLiBKdXN0IHNpbGVuY2UgdGhl
IGVycm9ycy4NCj4gVGhlIGFwcGxpY2F0aW9uIGhhcyBkaXJlY3QgYWNjZXNzIHRvIGNvbW1hbmQg
c3RhdHVzLCBzbyB0aGVyZSdzIG5vIG5lZWQNCj4gdG8gbG9nIHRoZXNlLg0KPiANCj4gQ2M6IERh
bmllbCBXYWduZXIgPGR3YWduZXJAc3VzZS5kZT4NCj4gQ2M6IEFsYW4gQWRhbXNvbiA8YWxhbi5h
ZGFtc29uQG9yYWNsZS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEtlaXRoIEJ1c2NoIDxrYnVzY2hA
a2VybmVsLm9yZz4NCj4gLS0tDQoNCg0KVGhpcyBzaG91bGQgZG8gdGhlIHRyaWNrLCBob3dldmVy
IGl0IHdpbGwgYmUgZ3JlYXQgaWYgcmVwb3J0ZXINCmNhbiBwcm92aWRlIHRlc3RlZC1ieS4NCg0K
UmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0K
DQoNCg==

