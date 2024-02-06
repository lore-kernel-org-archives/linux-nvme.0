Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8E1C48260
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Feb 2024 00:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YTfkEpNPrZOgsC+p0DCoaT6jvUb/Dh6r/Alay3BIiZc=; b=cBb279Pn6So4pF+jdXSL2+L1n1
	ezL0uY2LsPNifVsHaU7XyS4aD9pOnMZEMC3fQcjowguKSjUdpPgHNkn0yY9jXjmPotZiZraPfmdcc
	5BtLZj0t5IuHq10LRQ96Re7gwxG2q03VviwHzQiHktTaOLgpsiULpOM9XOSqUZ2FsR/r1hhwEqSC5
	41z8ARkYyqrKJ+SGRW2s2tDxCgv0/0XCG4Tt/JyRhpH+2mCDh2C1VRRZVjejxITjQWpPnzslJ0ObT
	ad1hSBa479wfluyZ5/lNxmVHwHu9v+IMly0iBDWAFdNHyMdJSw8k+XZv7i/yPQYuQSscyKilc0Vbj
	3+VLIs4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rX9LT-00000005dh9-1d1I;
	Tue, 06 Feb 2024 00:29:51 +0000
Received: from mail-bn8nam12on20600.outbound.protection.outlook.com ([2a01:111:f403:2418::600] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rX9LQ-00000005dgi-1wjW
	for linux-nvme@lists.infradead.org;
	Tue, 06 Feb 2024 00:29:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbyE5/Fo1+JHdxN+HdM8m6VEOmtoqDcBCJ4NEFojv8NsoMhSY/+5WzpSi/j2CKMtnBTMw+z38MllmC74aW674AFrpcy3oFl9Q3DRr6BDGU7F9KXh8bx4hPAKkurLZc18BAicx3hFB2+adDf+4hcI69E11Fd8Roi/fuN01oJveIZbBGm3i+tqLAdtpvujpYe5PaA+pYW/IXI3iix+HY6p5MMBvOMWij5TSy2ttZmim4t1k5cvCe2F6+7MOkb01SjO04BPDxU7k8mHsiV9iHbAamBdXleTidzyMVGUe+zu8SIWsaOsqUReXXviigyzytppmmw7vd3yFj1zU/jhhvgbog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTfkEpNPrZOgsC+p0DCoaT6jvUb/Dh6r/Alay3BIiZc=;
 b=n+EhUuf1WNH4Dpccb4e97Vd8VYePYR0/f4SUfSpgdguk2gQjmu/bP2zJQiERHxcMCUUkYCPAHjOgHuvWzCd0bnOIu02CZjfiMNYIZa5FK55ybnjCRwh0xe/9aZEC0GcPqtQ+jFmqkWVhGRhunaQXfLK/A0CZhRM4duaTSFGaIG4SfMo2keW97EBh3559eYdKpxTXknsEg7cQeHshSB/suzjBflXR/GvxMbAEzpWs118VK3rc6/feE5jaWM/5haDLOkzEyGzBnkpFowMA3WZkipWzS64IaAcaoJb5/mrc5Zcelx5JoBAFmO0sjLc9MM2gjODyig0kNUelrvRP6L52BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTfkEpNPrZOgsC+p0DCoaT6jvUb/Dh6r/Alay3BIiZc=;
 b=CRsZ4IdxFK5/iCzZxe4XQ3627V5AEuUOjamLX1m4W53jGz//Yr4WaOYsVhekp/OLV63OIO1jAxfr6U+I3dOPYSo8HcNZ95QuzxUqPbKxnWCZb3Wzt1cCujkYjzvfg0ewPG9J4Rgabh0jkC0K3bn6/r34IGsx6nxPj6pIP+x4K+K1uCAfxbXdE95KGwXsuDOmFsW/cqcGjEYqdB0pni9/+oBkhEsVwuzrK1lpt7lSKNS0mxD9ww6KDVB34o8ZuukT/FXaYQqX/V2BgpzUTEO4HaWwhMASY3Zc9XGbo6Sl87VsF1P0uxc8+GjyY/5KLL/k/LgykhJ5fkhiZOAzzrjp8A==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA1PR12MB7734.namprd12.prod.outlook.com (2603:10b6:208:422::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Tue, 6 Feb
 2024 00:29:37 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7270.012; Tue, 6 Feb 2024
 00:29:37 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, "alan.adamson@oracle.com"
	<alan.adamson@oracle.com>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V2] nvme-common: add module description
Thread-Topic: [PATCH V2] nvme-common: add module description
Thread-Index: AQHaWJNBocyCw4YnEEy7vHqXdVrE77D8dfqA
Date: Tue, 6 Feb 2024 00:29:37 +0000
Message-ID: <8d17f0ed-de04-4d44-a6a0-fb957337851d@nvidia.com>
References: <20240206002654.5514-1-kch@nvidia.com>
In-Reply-To: <20240206002654.5514-1-kch@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA1PR12MB7734:EE_
x-ms-office365-filtering-correlation-id: 3a404f9a-364e-4ea0-eef3-08dc26aab365
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iraJS3cSyLq8SLQilrRZpPaaze2j4plOHrLqAz1BMLavEMCwCoQVWOPLG0jQSDLiroNwGqGfZojRgGMqMGnr6MorfTrAE2TViqq6fYdGSHbQqHTrzErZxlRsOHmdBoxZ0Qd0sbBBSF1Am6fKRbkF6getXLgM6h+eEymQtUyTngtnoVdTYefSuAE62oVrG91hUqNJldBj7F4ZgSDjSgkBNkP2KVgLa3yC+76mCODTkAlbYfHG0JdnF45ctoPzh9O6WBbzFo0sxSLKLGcKbsx13GCPvJTKo219KlKk4OeX6eWBSE30H9kf0JRVHj64g9XOmGfYpJZzmVBZbNOdMA0fz8ae2NCwOMx08I/yxoUy4GpBJ3MVW/7j5Zii38Zx/U7dMCgdVSpThTsNsMBFN3Rq1EkRecoxYUbh0Zguwri82JyVZn1ldt5LFkLxqecDlYe6EkVkdwq8J25cn9I96iBZ7VNW3k0NGycXr67+etaMVDYWdTENm3UM7IuwQuiH+uQEG3QfQIlT52okeXpF/6bRU2SwyWCnjbKca2QEzt/0pQa/ZYoPRyRFljwDii1Cf1SUd78AjdmOR0PDtMnGXsPF07GPLG5FwEr/TvmRW8zKgyhGsjFJLTSTrDLWJYF97sFScQolfZ8F243qKMglfgHsbQeqvbgJBWXmoK0vusxzF1Zfdqxne4gU+PridlUdxgQz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(396003)(136003)(230273577357003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(31686004)(316002)(91956017)(83380400001)(110136005)(54906003)(66556008)(4326008)(122000001)(38100700002)(2616005)(64756008)(71200400001)(86362001)(53546011)(6512007)(6506007)(2906002)(31696002)(6486002)(5660300002)(478600001)(76116006)(66946007)(66446008)(8936002)(66476007)(8676002)(38070700009)(36756003)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXNLRUlkd3FhTWxXSlN2NVQrZFRCbFNkWEFiNFhzeWZ0RktCYzU2OGR6eVZY?=
 =?utf-8?B?UGJZZ3NRVFd3eWpsaUlYYkd4K3l4VnUyNDAxYUhwNXdtNkpQNHY4Vk5QUDYv?=
 =?utf-8?B?WUpvY0VKMEptZmR3UDljWWFSd1FDUjV0KzUxQ1kxRU50OXZQZThGZC9peDMx?=
 =?utf-8?B?WWVNamsyOGtjWHREWU1ucTl0S0p6TkEwYVI4bUdUQW1sQktYeWprd2ptS3ZK?=
 =?utf-8?B?MEszS2dZbEtvU21IajRGRGlTU3ZwNmFtdGFLNTAzZjQweHlkOW5wQlgyNU9n?=
 =?utf-8?B?TlBEYTZXS21rc1pJV3ZEZGZvVVNqWE1aZ2lxNHFKQUlBTFhSUCs3MERYS050?=
 =?utf-8?B?V1lVREF5ZExNN3VQSGJhR0FoZjNKMldmRTA5ZnFPZ2JTQzBhdU4wdjdodG50?=
 =?utf-8?B?cWJZcmFpaVZLbGp2bk1YellVWTh0N1J0NU5BelNhTUgwRVdJT3lzdlFQTDF6?=
 =?utf-8?B?K2hKeVN0OWVkNkFVSzdIbzV4OGRHOVNoMHF5ZXBHWDhab05qVjBuL3czemhU?=
 =?utf-8?B?WVIwa1NweWY1SHBZcFN1NDAyb2MxeHIyVHBzNVdHWTAzSmdCdklYVHhQc1l6?=
 =?utf-8?B?bXNhbERjY1VEUndVcU1zbjRUay9Gc0JtY1FZMGlvaURldTVqbUlzUnRQaFdp?=
 =?utf-8?B?Q1NyNlpIa2Y1NTBwK3VIUXNpYm1MWlVvTDVOc0VLL1d3eEp4RWVTWFk2TUJk?=
 =?utf-8?B?MmZ6cG1tNTQwVHpGSUFiVUNQZVg1TkdwV0dGRTZzSUJCbmcrQU5MM2NLWTND?=
 =?utf-8?B?T2x0QTJvRVRKdUlPWjVtYStWeVMySUZ0ckk1bzVKZHNON3VzRDgrWWl6amQ2?=
 =?utf-8?B?ZGZFYlhHd0wyL3A5M3N6Tmpaa1ZLVTBGdytQNE9TMHZ6VFhHeWY2WjJJL1BO?=
 =?utf-8?B?aU9qU2p5dmRyc0VLcDhTemovRkhvc0xCbnZrVzl2Y2xKNmpSQWtrWHg4dTdh?=
 =?utf-8?B?STMvTlVzSm1FSWJNVkJTMk96WkNYTldxdDRsd2tnT0orYk1yQko2Lzd6L05u?=
 =?utf-8?B?REd0WGdLaFhCNVVNVHRQbW9OSkdPOGRDL3YxWklxM3ZKaSt5THpTOFVCbHVC?=
 =?utf-8?B?amhkQkxYZUFIM0x5Rm01eTV2RHV6d1p4c2tiaW1zaWRwajlsb1VsenQwZUFF?=
 =?utf-8?B?dXRVTlViRy81S1lNZk51V1NXaGtGM2QzalQ4ZGNFUmJxL3k4V0NURS9NczdF?=
 =?utf-8?B?VG9CTnBEM2RCU25JMnR3d0xXdVNiWk9GbU8vNWhNRGVxclorUXhLcDUvczRN?=
 =?utf-8?B?eURLSE4vWnlJS253L05kb0RiUjF6TUFaei94MG5JdE9mRXZPQ05sSGoyc0lq?=
 =?utf-8?B?aWpmdVN5bzJjRjdIenM5d28yWU95UkVzem0wbk5uS09GTStCN3BkeFk5OTVW?=
 =?utf-8?B?cnFyMmM1Q0lLTXFGc3dXamNhR1lUNGVxUE1XaU9SVGowNnRnWVp5ZFN4K0Ra?=
 =?utf-8?B?T3ZxcjFkRXB3S2E4Qk95K3krSWJTWld1Z2gzWTN4cHdHTm91Q2hhK2orNFlQ?=
 =?utf-8?B?cEFsZ0V2RXNWc0Z3ZHJzZmlmWE45L1BNUW0wS2t0MlgvS25reXp5WElTT0tG?=
 =?utf-8?B?OGNvbDQ0bUluVXBha254c0Fxc0FHWUdTRmc1cjdLMkRvQWhCTkNubmJJVkZa?=
 =?utf-8?B?bFZTRWpUbVF4b0FHTEFtL3czNXVrTXJYR0sxWHpoZ0RrKzVLZ29nemxKZ1hQ?=
 =?utf-8?B?NkFyc1AxWGZueWczRWVISGh1a2tWS2JjaGRXYUNPdW9kR0VkcWtZQkRxYVBn?=
 =?utf-8?B?RzUvSEc3ZWlBbVJEWURvbDdwTDlIVm5YczFlYXd6K0Jtalh5ZmdVUWEwVVJv?=
 =?utf-8?B?SzdwK2RwbCszRUdHTm4yam5pRnQxT1l1SGF5cGJoL3QzTitGQWhiOU1NbWls?=
 =?utf-8?B?ZkNiN1Mvek56c0lmWmYzaDVCRWhhUlBFazNaOUNWbkJaNjJBMmpTdnllbHBS?=
 =?utf-8?B?YnppOVBvNzVrbTBiQ2pRd0hIbVRHb0M0cm5rU3VjVVg4UXBPSDdtTnpTQWxV?=
 =?utf-8?B?L3JrUTJrUkJzdktRN0tEVXk1UVAzR3UxVzhqRnJFNkN5aEcwUjRmc2x6T29O?=
 =?utf-8?B?clFnWWVoLysxRkhWS0FydlR0WWZ3a0FENytxNG1ON09zOFg0T0dnNGdQK0Zl?=
 =?utf-8?B?N0ZGWURCekUrRlJTU2lteUJxMnlGdldQSkxBZFlyTjlFRWhzRWkzbkk4RDRG?=
 =?utf-8?Q?ps+72nNz8eFWr2OM/Pk+ijAArp5dBcKZafY4QMqlpyun?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C38D799166B954CBBD7DC2DEAA18E23@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a404f9a-364e-4ea0-eef3-08dc26aab365
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2024 00:29:37.5812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: asRkaAaMiyVU1bos+zYrJhCEjfMxFgHamgaxoKmVjpo28rbPQAT5b5fCdWjsqJVCx/5TjRd3DlDiR3zbdA6xtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7734
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_162948_528409_03D78799 
X-CRM114-Status: GOOD (  15.10  )
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

UGxlYXNlIGlnbm9yZSB0aGlzIHBhdGNoLCBzb3JyeSBmb3IgdGhlIG5vaXNlIC4uLg0KDQotY2sN
Cg0KT24gMi81LzI0IDE2OjI2LCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+IEFkZCBNT0RV
TEVfREVTQ1JJUFRJT04oKSBpbiBvcmRlciB0byByZW1vdmUgd2FybmluZ3MgJiBnZXQgY2xlYW4g
YnVpbGQ6LQ0KPg0KPiBXQVJOSU5HOiBtb2Rwb3N0OiBtaXNzaW5nIE1PRFVMRV9ERVNDUklQVElP
TigpIGluIGRyaXZlcnMvbnZtZS9jb21tb24vbnZtZS1hdXRoLm8NCj4gV0FSTklORzogbW9kcG9z
dDogbWlzc2luZyBNT0RVTEVfREVTQ1JJUFRJT04oKSBpbiBkcml2ZXJzL252bWUvY29tbW9uL252
bWUta2V5cmluZy5vDQo+DQo+IFNpZ25lZC1vZmYtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2No
QG52aWRpYS5jb20+DQo+IFJldmlld2VkLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5k
ZT4NCj4gUmV2aWV3ZWQtYnk6IFNhZ2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+DQo+IC0t
LQ0KPg0KPiBWMjotDQo+DQo+IFJlbW92ZSBUTFMgZnJvbSBtb2R1bGUgZGVzY3JpcHRpb24gc3Ry
aW5nIGZvciBrZXlyaW5nLmMgKFNhZ2kpLg0KPg0KPiAgIGRyaXZlcnMvbnZtZS9jb21tb24vYXV0
aC5jICAgIHwgMSArDQo+ICAgZHJpdmVycy9udm1lL2NvbW1vbi9rZXlyaW5nLmMgfCAxICsNCj4g
ICAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9udm1lL2NvbW1vbi9hdXRoLmMgYi9kcml2ZXJzL252bWUvY29tbW9uL2F1dGguYw0KPiBp
bmRleCBhMjNhYjVjOTY4YjkuLmI3MDdlNmI3ZDI2MyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9u
dm1lL2NvbW1vbi9hdXRoLmMNCj4gKysrIGIvZHJpdmVycy9udm1lL2NvbW1vbi9hdXRoLmMNCj4g
QEAgLTQ3MSw0ICs0NzEsNSBAQCBpbnQgbnZtZV9hdXRoX2dlbmVyYXRlX2tleSh1OCAqc2VjcmV0
LCBzdHJ1Y3QgbnZtZV9kaGNoYXBfa2V5ICoqcmV0X2tleSkNCj4gICB9DQo+ICAgRVhQT1JUX1NZ
TUJPTF9HUEwobnZtZV9hdXRoX2dlbmVyYXRlX2tleSk7DQo+ICAgDQo+ICtNT0RVTEVfREVTQ1JJ
UFRJT04oIk5WTWUgQXV0aGVudGljYXRpb24gZnJhbWV3b3JrIik7DQo+ICAgTU9EVUxFX0xJQ0VO
U0UoIkdQTCB2MiIpOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2NvbW1vbi9rZXlyaW5n
LmMgYi9kcml2ZXJzL252bWUvY29tbW9uL2tleXJpbmcuYw0KPiBpbmRleCBhNWMwNDMxYzEwMWMu
LjM5NGMzOTQ4ZTMzOSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9udm1lL2NvbW1vbi9rZXlyaW5n
LmMNCj4gKysrIGIvZHJpdmVycy9udm1lL2NvbW1vbi9rZXlyaW5nLmMNCj4gQEAgLTE4MSw1ICsx
ODEsNiBAQCBzdGF0aWMgdm9pZCBfX2V4aXQgbnZtZV9rZXlyaW5nX2V4aXQodm9pZCkNCj4gICAN
Cj4gICBNT0RVTEVfTElDRU5TRSgiR1BMIHYyIik7DQo+ICAgTU9EVUxFX0FVVEhPUigiSGFubmVz
IFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+Iik7DQo+ICtNT0RVTEVfREVTQ1JJUFRJT04oIk5WTWUg
S2V5cmluZyBpbXBsZW1lbnRhdGlvbiIpOw0KPiAgIG1vZHVsZV9pbml0KG52bWVfa2V5cmluZ19p
bml0KTsNCj4gICBtb2R1bGVfZXhpdChudm1lX2tleXJpbmdfZXhpdCk7DQoNCg==

