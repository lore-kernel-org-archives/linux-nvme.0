Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2485BC433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Dec 2021 22:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F+2vEfuGYn3lPKYBZi8zXzHGXmoatFDI/CPrksUeblM=; b=VB0o+qldafLHRC+TU2S9vpjmD+
	3rq+IsSaL/4yUvCNGMQhbhJWFw5/72KhSea00rIElpy13z6bDkVw/UObF0JQMlBk6UKX7ppPulK9r
	YIvNa67oQhFKOawuyQYNcUcQFNfeNVxRG5C1rmVkYaoAaWOoulhqrr7n1oa3XVEClDuYmIeLNVbkM
	85mwO+ZrQtDCXMgzFNY1ckxEoZHKMI3S4T7vpBiUiAOh/0sy/AD/kWHS5zT9GkDUcHamBP7Xc1Np7
	BSY4XXwh7v+Fy/y41ZX4XvNyx0LGpsTarNixdIcI4ZbYb/1mRlCgHUZcBXj/FRYscWb+nWMX08hjN
	7fsNmbMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mwuDx-00BsoV-V6; Mon, 13 Dec 2021 22:55:14 +0000
Received: from mail-sn1anam02on2058.outbound.protection.outlook.com
 ([40.107.96.58] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwu9Z-00BriM-Ho
 for linux-nvme@lists.infradead.org; Mon, 13 Dec 2021 22:50:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQSRGYk+/ac8Y8eay5F1OZmlZnmSIEMtEEdw5r3ltGnTly+FZmPOV6a55OPOccWZnFG7HZh1L6KPQRfkA1Yt8MBGVr104UZeKRKaU4/o5Fb0IT6u9LXy1U0K86tFuL1b0BxKBmJifJ8+HSt3mNkKAI1wfwmJurflD/8vEvn3aFw+fihyI0zPeHM90UChZs/paA6V8z9U+LVBnFkVpHiAznwPqqvjG9CuskYF0nhGgQZDdOJix6nSKRT9mlBpw9jYYFhGDSmXrPachaZtO79DGjzazuFZlvjsQRTj5iJUU5Xu96YxLHIgk5lLAUDh36Bb66jjtytBG8Ljfw7O1R9qfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+2vEfuGYn3lPKYBZi8zXzHGXmoatFDI/CPrksUeblM=;
 b=UcAd3DyIh+4fmpiV0Jx5liqFv66sQ93nIsJpM8CRvMca4aRBNBnXWo+35H8BnAQresJd55JLbhD1xeMVffUtHjxCrwe3C03Qv2tGugh783uc68eZRMiJke0cQCqe7Y8EZYE2AQDjJcy9vkBQe4kuWfCodho/vVKZ/ls3XQJE52sSjCbxHRLNGxzhalb87M03cFlOixhT4uDu+DwnkDgALeDh/QyJPfld+u6bAfEvWumqF90YdCzXwZS76Af45vjieK2D1OMCjCHbhbNHdjQsXumGjR13y+fTufcbjjl2M+aLkY8haZQ0oFstvu0DaKu31ARJuwBWDdpZZmgJVHC3gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+2vEfuGYn3lPKYBZi8zXzHGXmoatFDI/CPrksUeblM=;
 b=rtPPo1mf4lfLrvlRNzOZFIAL7zNH1HRqjle5AB7l10yzlGN0Yl+yOPsA81G8g74jJ+tOD/ECkuU6TTxJlKNW5NxmVuOj1GA0gdJgCPhvgg5qOznTssISCECv7cmxiHZLUyW87QzDlzR0352EIrn9bqQ2kgSrrWzHzfYpo8zSNk/sQ8vis7BEZSz/zzpHhTEBK2ODFdtYgwMJ9kwDnZr5cZndaJhEpduTMx0KmxmPAS+QeMsK9X2ymqfgOPzB0AYbcjEKm8w61rpJWBZeoidFPKtr0EK2meE2Er4RM/GccpXcUNgVDdvrz1rNmmMW27PELGPQ8zwSvTvGQlnUFeGKDw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR1201MB0095.namprd12.prod.outlook.com (2603:10b6:301:4e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13; Mon, 13 Dec
 2021 22:50:38 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e%7]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 22:50:38 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>, Omar
 Sandoval <osandov@fb.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 04/10] nvme/rc: add functions for in-band authentication
Thread-Topic: [PATCH 04/10] nvme/rc: add functions for in-band authentication
Thread-Index: AQHX4D9PHtS8dTqqAEyzrQOuMJxpuKwxJzIA
Date: Mon, 13 Dec 2021 22:50:38 +0000
Message-ID: <370e4204-0b1d-b402-c0b8-b3d44f774176@nvidia.com>
References: <20211123074940.113390-1-hare@suse.de>
 <20211123074940.113390-5-hare@suse.de>
In-Reply-To: <20211123074940.113390-5-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be5027cc-83bc-4231-5579-08d9be8afbd4
x-ms-traffictypediagnostic: MWHPR1201MB0095:EE_
x-microsoft-antispam-prvs: <MWHPR1201MB00955E0AB4731E344DFB022AA3749@MWHPR1201MB0095.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wVemIAC3p0BERTLzi3QxhEYX4xFaVFsTIBefUq9dgp56ylZ/AutkXuTz15pZkh/39CyxYHBnX6AytO7fmNoXl2l+Nf5Ww/5nw/W2b7bpx0Z1PY7AoqUAKOYF77Gh5opNOqt3EAhYgTR7xGVjcBuBCnd+X4AwPVywBL0rkeHabzfD8nwomgpCpuvYsNihD6cQOK6qqHlJwSiNS7L+0BeIUN3PyUWqYzcKm93GD30TwQC4UqXW+6+1n6vTYPRX/vKf2D3bMrnx3e+j49fjWHUG8vHi5aWssMm9CkEoO0xFzAG8Fz1Ws93e9xn2Tbahxy0Vbe16ZXcLbFERJsnOxxbbi49SyKzwrmyV6KrqJWiIsXNJmYdK02/mSCF0VRFsohZFvDilrZjCe8rEemO4iJWQj0ngU/HmfHii32NxSjaBr3u346125AuAoA8qcGpvHnqOBDInxJ/QewSCzmwOQbgwvAva2drVj4a7Oq+62tvWp1ySM90G0ymSfET2RcUSv1Ykr8nNJmHeiS4SPH8ORNw7Ns0eh9O/4w6B/IeyjJ4hJmhXvacQ4wQw/KZrU68OiYeFvKwaKkErUsw/NYo1K1JHeqDa3IDU8LG6kUPwGuW+iJ6ak6hrjT5vsBHikSVy3el3ECn6xy6MzrJivACcAsDxNLZYrTCfeCUCNUYP6ONOZ1/8Cs/YjsSmQ/3I3ClfHdS0fwpiZbO2nF8UwB6b3uhLk/zAgTjn1tVI3ItaGtA8zvW+av1xo7RyAm4jw2M/qIgM4m2efe4UvNq8cbZbwST4Jg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66446008)(66556008)(66476007)(64756008)(71200400001)(122000001)(186003)(38100700002)(8676002)(66946007)(31686004)(316002)(38070700005)(36756003)(6486002)(53546011)(5660300002)(54906003)(110136005)(86362001)(8936002)(508600001)(2616005)(2906002)(31696002)(4326008)(6512007)(76116006)(6506007)(91956017)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWI1NHVJaEVCcUowblVCbkRHNU44SmdmOVZFWUhSa1FsR2xxWkhlWTdzSEdj?=
 =?utf-8?B?UjU4VTFnd203OVRPeFJvcHBUa01FaVlGTnZzdGdJZVpQSUhmUEJJOGQvdFMz?=
 =?utf-8?B?dG1wS0hHREhkVFRDSkovTlVxTldQeHRxcExzcGVPcERzY3VEWnBjN2ZGS3dm?=
 =?utf-8?B?VjBiUlRvdmdva0ZzQXI2cTl4WlhRZGpPdHRLZzlHRjRvQ0o0NTJUSHpCQjNY?=
 =?utf-8?B?L0RTSVlqSmhDazZiMElIMCtJaGF3RlRnenVtZ2ovbmlSKzZwVUxoWjRob3VV?=
 =?utf-8?B?OWlmVXYzQ0hKVzlIS3JrNDRqcG5EVGE5Njcrcm9ReUxSc0UxRUpVZklSK3li?=
 =?utf-8?B?am5jaGNrS1duZGxPL244cS9oM2YvU1J3Z3hQbjdCMG5UTHFNa0ZCQ1YxUFF6?=
 =?utf-8?B?dHE2bHV6NGE2SDZSWXdCTHdhejdEZGc1SFZwVHk2c1lITU1UeEZudWY5Sldr?=
 =?utf-8?B?VldMVG9JaVZWSkhvdHlWdmo4T21uMW9ybVIrc1FaZmNiUVJpTngzaGhEODdj?=
 =?utf-8?B?Ymt1amFhREZVSTM0ZGFSaDBiTGtvNDFOREpPVkRqdmwrVmVVM3p0ZWsyT0p6?=
 =?utf-8?B?dXRLdFVESGgrZkdjNktJcVUrQ2lxUkY1ZVQ1L1lMTzU4dit0di9JdUhtNkdH?=
 =?utf-8?B?YnNYM2RkaWZaMkdFcFRhU0tqWFZjNC9COFZlcFFaTENIZ2g0L205K2JiZTl5?=
 =?utf-8?B?ZTJnWlh0ZEMvT2RyemZxWDlTZkx1UmxSYkZQU25NeXp6MCtRYThQZWUwRlYv?=
 =?utf-8?B?b1FGR0xIbnQxdVFLZEtnQjJWbDFlaWhlSUx0RGNLbGVpeVZydm1PZ3BSYjdn?=
 =?utf-8?B?SzZlY1JhQWlIak9rQjkwTEN6SDJBQVVuZHRBVmFNZXlwbDUrU0o1VkZlR0xq?=
 =?utf-8?B?dGRtUEtUVXRuYnBsM25LZWhGMUJLZzhBZlNHR0FvaEh0R2p4ZWhraXY2ck1P?=
 =?utf-8?B?NW5BQWUzTjZQRVoyVklzaHFMelBPNm5oWmV3RmRRUFFpRXFMa1BMSzFNWnZi?=
 =?utf-8?B?czlyZ2VOSzBBWjIzMDB6SmlGNU9oT2ZQMXVwNWZYdXhPblNIRlVhVmgyeHVX?=
 =?utf-8?B?dm1NYVRaQXhxQS9PQWJ2TDlOb0QzUUJJc0dDV28xSlNiTkNMUTZ0WVgyS1BP?=
 =?utf-8?B?ZllsblJuaXZPbHVKaXRTSXNWSTFabm42dk84R0grNGxHemF2VjJtMUdaRTdO?=
 =?utf-8?B?MUZ0ZHk0L1BjcU5lOUJCQkwzMUh6cnVHR2poRWlTbnppNWFyWFZtREVBMGQy?=
 =?utf-8?B?dTIvRFFpU1g0Tnk1bUZ1VWZxbkF6WTNUbkx0eTRwNE1LczRHaEZvT1pyNzZ3?=
 =?utf-8?B?Mk9weFI3bmlKWGlnMytzdTBBSk1sLzlOeGdKNUZSWmMyditQaitXS0JNeWpK?=
 =?utf-8?B?QTB4QnpjTW04aUdOWWtNcTFSblovSGtZTFJtWm9UODlEbVFMK3AyNUdGNjF1?=
 =?utf-8?B?WFoyeGpEclhnTjhnNGZuaTFEOEtTUnpNclhleG9tS1pSNVhaU1dRRlZaOVRZ?=
 =?utf-8?B?ekhBeHNJdlMwWTBoQlp4MXRPQ3JZNFVGZVlMTUY5MFFaQVo5aTJNd3dLcjJv?=
 =?utf-8?B?SHI5S3MxUG82OUVUWUFXenhLTHdkcmE5eVpuNGdUUFlsaTdIU1h5VWVWMFhK?=
 =?utf-8?B?b3lxRTJaelBuRWFPL3M0QkRLYkJldG12MTAzQTc3Z2NnNUJoSmtvUUhXcFFX?=
 =?utf-8?B?dE5yRzhGd01udDlleERWSGgzOXV0QnE4b05UeTJ1b1N5OTRQS0U3SXQwcWNS?=
 =?utf-8?B?STlGUHpidytoeEpYZHFEQ0xpR3NQeVZta1pmQnVBL2VUU0ZGZUZ6eEppdStk?=
 =?utf-8?B?ZnpIOFBabTYwRStPRVZrODhqSzVFNXRENXB0Ly9Lbmk1dzcrZVR1Wk5MTitL?=
 =?utf-8?B?eFh0Q2Z6M0hvekhMbEZxak5BMmRsNTIxK1FReWRZNXFhem5rT0FTb2pxNEYx?=
 =?utf-8?B?aW5rUktxeklkTTlhWDdKTGI4WHd5cDRic0RyVDNMcTdVZGRnbmdPT2kvOWVy?=
 =?utf-8?B?WlFrSmJtRTJWbHV4RnU1a3pJYUR6a0lMeDd4TmhES2lsOHYrZmRMaXh0cHAr?=
 =?utf-8?B?NkdkK1dZNjlTdWMvbWlobkpRNG1XRGIyeDY4NnM2N2VjcjFEcVo0a3VzU3Z3?=
 =?utf-8?B?cnRQQVhGbEh4ZzJScFp4eVd2MHFMMTdqMmNsSmxrbStaV2plMmova0Y4SXVW?=
 =?utf-8?Q?7Z238i+X5WXqZOnf64zU9XK+a02GBVkU9Di9n4t91nyr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD04A7E8F5851C41BBDB9D5B5B0BDF26@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be5027cc-83bc-4231-5579-08d9be8afbd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 22:50:38.8517 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u4/8KJycjAJNbje0zOJrkofG26PAcQOjbs8uv0Q66WxI7MfP8j0iK+/rfMF4Pk9V3mJR9AEbR/sliuFEJ9OAwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0095
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211213_145041_641738_069E09EB 
X-CRM114-Status: GOOD (  16.50  )
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

T24gMTEvMjIvMjEgMTE6NDkgUE0sIEhhbm5lcyBSZWluZWNrZSB3cm90ZToNCj4gQWRkIGZ1bmN0
aW9ucyB0byBlbmFibGUgaW4tYmFuZCBhdXRoZW50aWNhdGlvbi4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPg0KDQpMb29rcyBnb29kLg0KDQpSZXZp
ZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KPiAtLS0NCj4g
ICB0ZXN0cy9udm1lL3JjIHwgNzMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDczIGluc2VydGlvbnMoKykNCj4g
DQo+IGRpZmYgLS1naXQgYS90ZXN0cy9udm1lL3JjIGIvdGVzdHMvbnZtZS9yYw0KPiBpbmRleCBj
Mjg0NjAyLi42ZTA4YjQxIDEwMDY0NA0KPiAtLS0gYS90ZXN0cy9udm1lL3JjDQo+ICsrKyBiL3Rl
c3RzL252bWUvcmMNCj4gQEAgLTczLDYgKzczLDE3IEBAIF9yZXF1aXJlX252bWVfdHJ0eXBlX2lz
X2ZhYnJpY3MoKSB7DQo+ICAgCXJldHVybiAwDQo+ICAgfQ0KPiAgIA0KPiArX3JlcXVpcmVfbnZt
ZV9jbGlfYXV0aCgpIHsNCj4gKwlsb2NhbCBob3N0a2V5DQo+ICsNCj4gKwlob3N0a2V5PSIkKG52
bWUgZ2VuLWRoY2hhcC1rZXkgLW4gbnZtZi10ZXN0LXN1YnN5cyAyPiAvZGV2L251bGwpIg0KPiAr
CWlmIFsgJD8gLW5lIDAgXSA7IHRoZW4NCj4gKwkJU0tJUF9SRUFTT049Im52bWUgZ2VuLWRoY2hh
cC1rZXkgY29tbWFuZCBtaXNzaW5nIg0KPiArCQlyZXR1cm4gMQ0KPiArCWZpDQo+ICsJcmV0dXJu
IDANCj4gK30NCj4gKw0KPiAgIF90ZXN0X2Rldl9udm1lX2N0cmwoKSB7DQo+ICAgCWVjaG8gIi9k
ZXYvY2hhci8kKGNhdCAiJHtURVNUX0RFVl9TWVNGU30vZGV2aWNlL2RldiIpIg0KPiAgIH0NCj4g
QEAgLTI1Myw2ICsyNjQsMjUgQEAgX2NyZWF0ZV9udm1ldF9zdWJzeXN0ZW0oKSB7DQo+ICAgCV9j
cmVhdGVfbnZtZXRfbnMgIiR7bnZtZXRfc3Vic3lzdGVtfSIgIjEiICIke2Jsa2Rldn0iICIke3V1
aWR9Ig0KPiAgIH0NCj4gICANCj4gK19jcmVhdGVfbnZtZXRfaG9zdCgpIHsNCj4gKwlsb2NhbCBu
dm1ldF9zdWJzeXN0ZW09IiQxIg0KPiArCWxvY2FsIG52bWV0X2hvc3RucW49IiQyIg0KPiArCWxv
Y2FsIG52bWV0X2hvc3RrZXk9IiQzIg0KPiArCWxvY2FsIG52bWV0X2N0cmxrZXk9IiQ0Ig0KPiAr
CWxvY2FsIGNmc19wYXRoPSIke05WTUVUX0NGU30vc3Vic3lzdGVtcy8ke252bWV0X3N1YnN5c3Rl
bX0iDQo+ICsJbG9jYWwgaG9zdF9wYXRoPSIke05WTUVUX0NGU30vaG9zdHMvJHtudm1ldF9ob3N0
bnFufSINCj4gKw0KPiArCW1rZGlyICIke2hvc3RfcGF0aH0iDQoNCnBlcmhhcHMgY2hlY2sgcmV0
dXJuIHZhbHVlIG9mIGFib3ZlIG1rZGlyIGFuZCBhYm9ydCBlYXJseSA/DQoNCj4gKwllY2hvIDAg
PiAiJHtjZnNfcGF0aH0vYXR0cl9hbGxvd19hbnlfaG9zdCINCj4gKwlsbiAtcyAiJHtob3N0X3Bh
dGh9IiAiJHtjZnNfcGF0aH0vYWxsb3dlZF9ob3N0cy8ke252bWV0X2hvc3RucW59Ig0KPiArCWlm
IFtbICIke252bWV0X2hvc3RrZXl9IiBdXSA7IHRoZW4NCj4gKwkJZWNobyAiJHtudm1ldF9ob3N0
a2V5fSIgPiAiJHtob3N0X3BhdGh9L2RoY2hhcF9rZXkiDQo+ICsJZmkNCj4gKwlpZiBbWyAiJHtu
dm1ldF9jdHJsa2V5fSIgXV0gOyB0aGVuDQo+ICsJCWVjaG8gIiR7bnZtZXRfY3RybGtleX0iID4g
IiR7aG9zdF9wYXRofS9kaGNoYXBfY3RybF9rZXkiDQo+ICsJZmkNCj4gK30NCj4gKw0KPiAgIF9y
ZW1vdmVfbnZtZXRfbnMoKSB7DQo+ICAgCWxvY2FsIG52bWV0X3N1YnN5c3RlbT0iJDEiDQo+ICAg
CWxvY2FsIG5zaWQ9JDINCj4gQEAgLTI3Miw2ICszMDIsMTMgQEAgX3JlbW92ZV9udm1ldF9zdWJz
eXN0ZW0oKSB7DQo+ICAgCXJtZGlyICIke3N1YnN5c19wYXRofSINCj4gICB9DQo+ICAgDQo+ICtf
cmVtb3ZlX252bWV0X2hvc3QoKSB7DQo+ICsJbG9jYWwgbnZtZXRfaG9zdD0iJDEiDQo+ICsJbG9j
YWwgaG9zdF9wYXRoPSIke05WTUVUX0NGU30vaG9zdHMvJHtudm1ldF9ob3N0fSINCj4gKw0KPiAr
CXJtZGlyICIke2hvc3RfcGF0aH0iDQo+ICt9DQo+ICsNCj4gICBfY3JlYXRlX252bWV0X3Bhc3N0
aHJ1KCkgew0KPiAgIAlsb2NhbCBudm1ldF9zdWJzeXN0ZW09IiQxIg0KPiAgIAlsb2NhbCBzdWJz
eXNfcGF0aD0iJHtOVk1FVF9DRlN9L3N1YnN5c3RlbXMvJHtudm1ldF9zdWJzeXN0ZW19Ig0KPiBA
QCAtMzA4LDYgKzM0NSw0MiBAQCBfcmVtb3ZlX252bWV0X3N1YnN5c3RlbV9mcm9tX3BvcnQoKSB7
DQo+ICAgCXJtICIke05WTUVUX0NGU30vcG9ydHMvJHtwb3J0fS9zdWJzeXN0ZW1zLyR7bnZtZXRf
c3Vic3lzdGVtfSINCj4gICB9DQo+ICAgDQo+ICtfc2V0X252bWV0X2hvc3RrZXkoKSB7DQo+ICsJ
bG9jYWwgbnZtZXRfaG9zdG5xbj0iJDEiDQo+ICsJbG9jYWwgbnZtZXRfaG9zdGtleT0iJDIiDQo+
ICsJbG9jYWwgY2ZzX3BhdGg9IiR7TlZNRVRfQ0ZTfS9ob3N0cy8ke252bWV0X2hvc3RucW59Ig0K
PiArDQo+ICsJZWNobyAiJHtudm1ldF9ob3N0a2V5fSIgPiBcDQo+ICsJICAgICAiJHtjZnNfcGF0
aH0vZGhjaGFwX2tleSINCj4gK30NCj4gKw0KPiArX3NldF9udm1ldF9jdHJsa2V5KCkgew0KPiAr
CWxvY2FsIG52bWV0X2hvc3RucW49IiQxIg0KPiArCWxvY2FsIG52bWV0X2N0cmxrZXk9IiQyIg0K
PiArCWxvY2FsIGNmc19wYXRoPSIke05WTUVUX0NGU30vaG9zdHMvJHtudm1ldF9ob3N0bnFufSIN
Cj4gKw0KPiArCWVjaG8gIiR7bnZtZXRfY3RybGtleX0iID4gXA0KPiArCSAgICAgIiR7Y2ZzX3Bh
dGh9L2RoY2hhcF9jdHJsX2tleSINCj4gK30NCj4gKw0KPiArX3NldF9udm1ldF9oYXNoKCkgew0K
PiArCWxvY2FsIG52bWV0X2hvc3RucW49IiQxIg0KPiArCWxvY2FsIG52bWV0X2hhc2g9IiQyIg0K
PiArCWxvY2FsIGNmc19wYXRoPSIke05WTUVUX0NGU30vaG9zdHMvJHtudm1ldF9ob3N0bnFufSIN
Cj4gKw0KPiArCWVjaG8gIiR7bnZtZXRfaGFzaH0iID4gXA0KPiArCSAgICAgIiR7Y2ZzX3BhdGh9
L2RoY2hhcF9oYXNoIg0KPiArfQ0KPiArDQo+ICtfc2V0X252bWV0X2RoZ3JvdXAoKSB7DQo+ICsJ
bG9jYWwgbnZtZXRfaG9zdG5xbj0iJDEiDQo+ICsJbG9jYWwgbnZtZXRfZGhncm91cD0iJDIiDQo+
ICsJbG9jYWwgY2ZzX3BhdGg9IiR7TlZNRVRfQ0ZTfS9ob3N0cy8ke252bWV0X2hvc3RucW59Ig0K
PiArDQo+ICsJZWNobyAiJHtudm1ldF9kaGdyb3VwfSIgPiBcDQo+ICsJICAgICAiJHtjZnNfcGF0
aH0vZGhjaGFwX2RoZ3JvdXAiDQo+ICt9DQo+ICsNCj4gICBfZmluZF9udm1lX2RldigpIHsNCj4g
ICAJbG9jYWwgc3Vic3lzPSQxDQo+ICAgCWxvY2FsIHN1YnN5c25xbg0KPiANCg0K

