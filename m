Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE35C47DDB
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jan 2024 08:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k3SZOw/+hXsK4WW75PY6dByGBTDOtcsDOb9tPRhW/LQ=; b=ECJqlmVlhC/OEUHs3gkTcfeU1h
	7ow2/pddrv/mnHLmpI+ACYO20u1kPVr+jJOpWTNk2SqNy0NXtsX4WGMSnm+DAyKZrJSEU+4uEGdPr
	YOx9cm0JhAz7XAwXwQDDS69EcQa2m2FKs2MZZ+1C6/1DG8WyYMBjedgdLejKtMHKXud5v5b5KySfU
	4eDG3r+6YBp1L1UYhePnrR7gFZLrseehRghuCngcG1i+egH82C58H2CKycfFL3EBOR4gL4fm/3qdM
	omajlzqpGLJ7TlTlPdG/p+FDmBAvYmk0FhqFLGl6/vupz/z27xGBnBefC6HhcQ7DF5wMtx0+BoqX3
	1J+Bk9Pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTHal-00000003Rui-119g;
	Fri, 26 Jan 2024 08:29:39 +0000
Received: from mail-mw2nam10on20601.outbound.protection.outlook.com ([2a01:111:f403:2412::601] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTHae-00000003RtC-3Htd
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jan 2024 08:29:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UAgP+RViJf+RAq1SbXV/SKhSfCSciPKCiB+0p/Mu6dWfwSQyWRY1YiWZSFus6SV481gGGnJ5fOVqKi3FXkPou6cQ07vewbWc8UqstKBFhSQiE0NWvoaIqpA2K3WglGw39P9AeYDkt+gXz2pfCgDOPvqhoL4OBasNbW5YzNgQeUtrKtIs7zHQ3ulQFMMzlMrGRp8+dzsqV7Cj0fBBk/f80dKR2ca6sMqztVlvaiDNBZdENcZrkGGMorqN97X3RZuvQ9ZHgpjuOZT7rBj0IJo7HGQsE+cePryB1D6Okqe5ntM6Ds1CG4zgixtKN1b2GzUeIjm3Y12Z3x4r/DEB//qViw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3SZOw/+hXsK4WW75PY6dByGBTDOtcsDOb9tPRhW/LQ=;
 b=Zt0mLycwLLzqhywz3iJnyGCDyZkTFkoEP3+Gk94uBn/mbUuen3Zb9avB5byrDjSTBZdm4qmco//mccQy+QAHgs6NtiLHChgvFPlIGu1qTSkDyG/5pXjNLn/5BgyJ558dS88UIYoCvdioUbf5HxXPGpwCo694S3uC/56ryvFMOMzHZ0mUEd1guLNkqVxat2tGZOrHnDOr1WDKw6ZqLtKlCocyZOoHMscxGoGBBxF6dclHrpCDeIdLXuTTui2wB9wkQUzJO0+T1+tavylJAU1i5scAfvOKKIusS5tGYsorqoTAZNQR43buCnBM67tnztsYx8k2KX2fmuUbVbDCyUPXoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3SZOw/+hXsK4WW75PY6dByGBTDOtcsDOb9tPRhW/LQ=;
 b=ByeG1f8I33xkzX+oRLzxNJ/BvC3ybvsaZQyB3FE4rWPTHhm1RE+rgC7PFsObAa9GxT4J04p3aPs9YLZJUbmPHA3RnZBDel5p694XHeoqTyr4wcrAeN6GojQKJnXw01KU+KR5LYpXywvpZ8ccUxYYueexygSSSyonEnnR71xPDNmF6jossd0mKOJ1cgrz+/Ebubap8d/OxfzTXRDisSP/gJGuFe9agmvQguz7c3/ygeqE7BwIDViFmSbno+k+qtgVg1SZ+EzWJA49A3wNLBo3x9GXCr+C6fnUAGxtns1QnA7nWQzcNJeNx4LqhnswmIpDLKgq6+XdNq4pssBPq89lRg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA1PR12MB7248.namprd12.prod.outlook.com (2603:10b6:806:2be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Fri, 26 Jan
 2024 08:29:22 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 08:29:22 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] nvmet-tcp: fix nvme tcp ida memory leak
Thread-Topic: [PATCH] nvmet-tcp: fix nvme tcp ida memory leak
Thread-Index: AQHaUDFrcqYxaReDn0q1TWObHpFvlbDrwyKA
Date: Fri, 26 Jan 2024 08:29:21 +0000
Message-ID: <c840303b-a103-4dd0-8eed-1b52009758ec@nvidia.com>
References: <20240126082643.37656-1-kanie@linux.alibaba.com>
In-Reply-To: <20240126082643.37656-1-kanie@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA1PR12MB7248:EE_
x-ms-office365-filtering-correlation-id: fa4facb3-55be-4b17-64f9-08dc1e48e5b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B9THpOmpxj65f6d6pKZA5uR3qAKHDt4ZPuyWB4q222oCgYj84L5JU4nWA8hmEBjQ9xvoTMEBE6DzKNf9mbEQfFrG7z2G6gBQJBYk7xHR7D8LpCYL4FcszSpEFJ9pTmjICvIrLbd+JpJcze/pp7jhzEM3TZQeWkjhl+oygRf19KrLguJdRBGEYIHQlbjJMaIb7dZQCje3iiqmaClz9t+6hOAKHIRZ/s/Hf2XKkOL2EuobNDU7rC1Ac8EV7fA1yWvIr9Eq3xqTSHRtWP9iaN0ZycJldOtTZkHKAqhRJTpc9kcIO0/BT0NbyB17ZgZKNP0g+3latCPMikTUCy7F1zCRNUkJDwTP9RLWYaNmXVQ94+XCRtVRdCNbY8Whum5yZ136AYOlKKzja/N7c83XV7TnMABlfpqgfIm1TJ9m/p93dV648i9qrCjTOvr2Pkv0kRHLoabx/iPv4r12oIYvnTUmOk478plY0sOoQULltMFFtKXnv1BbFxq5Z6tgXkIm7TUDjUF7kYzs8XrHdxF0GLBaZOkvaMq+QFc+G4Esu+Zva0tDcwPlOgUC3avo773SrJ90NKPOvXzGc+R8KVvvkh+OTvPAwkBOICF+dXBvXYnbbcYIwam4g5icxW1QSDlRpIuQtvUU7EZkPxkuRgLGSXtaynQG/ua2SNRcp1cjdsejH53BKBIYn4iaeE3ZLDJNS9s0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(136003)(39860400002)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(2616005)(66476007)(26005)(38100700002)(6512007)(54906003)(122000001)(53546011)(41300700001)(8676002)(4326008)(2906002)(76116006)(5660300002)(66556008)(71200400001)(316002)(4744005)(478600001)(66946007)(64756008)(6916009)(66446008)(6506007)(31696002)(8936002)(91956017)(36756003)(38070700009)(86362001)(6486002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGduWVdrMWVUc1I4MmtDZjJoNXlQenNhbFN0dFl2eWZUSjB0bTg1QWdHeUNO?=
 =?utf-8?B?V3NqY0pZcDBRb1dpL080dXc2L3pOTjdkOENOSmg3SmdaRlhlYUdYK3VhRE9J?=
 =?utf-8?B?MGxPTmZHZXI3KyswNXBZVXRnUU44WGExK1gvd0Rva2pyRjBqT2tFRVFlOCt6?=
 =?utf-8?B?Nk9XNjd4M3hhRS90eENRM0tpcjZqSjVvT3l5TkpMOENKMlk2MkE2MjltWHcy?=
 =?utf-8?B?eE5UQjI0dVVoWmpIUGVqOTdQZG0ycTR0aUdHLzNFU0F3Z0dyOXQrRXBzRitN?=
 =?utf-8?B?SXE0S3dIK3hCN0JsWmZRRGxvb0Z2SjRZMjhxS2lLMWZsd2dpWlYvUTFlSWp1?=
 =?utf-8?B?bE5sNXN2dEd0MzZrV1pMaFZBR0NCeHdJNkNUTk9YcmlhUXg3SjYvUW5qZis1?=
 =?utf-8?B?NXRLdStrL2xJS2JUM1ZIcTYyQkVKTmtWdWZyWmxMeEhaTVh2YUx4cGxvMmtZ?=
 =?utf-8?B?cVZTbm9Hb2FSZEUyZ1JNY21HdGs1VVBjdUd5a0FnbXQybUpaaXVrcDJGQ3A2?=
 =?utf-8?B?V25zTFNwZ3I0TDMrMHdadWUvQjNydGF5czBCZ1RlbnoxbC9pczFPc1JUVWJQ?=
 =?utf-8?B?YmFiYXI2Rmo4T2pWYy9iQlFrTVNta1kzQ1ZvY2VUSUtEK3IzQXRFMktjV0ho?=
 =?utf-8?B?ZUU2c3lkVW5neU13MzFGMjdZVkVpZTRSQ1NMNTNDNDNwNXBXLzdHTERRNktn?=
 =?utf-8?B?S0o2R2F0VGdWRzVaajF3TzVMbkM1MU4rYVoxMHJzWTVjRDBGK3Fnb1ZzNVhR?=
 =?utf-8?B?T1l4dmc1L3BaUVpQTm5GVEJ6bXJwMnlBaUZRMHMrMFZvMDEyZ0RSYkZWM0Fm?=
 =?utf-8?B?TDhGdlEvenZBWEJqbmk4M2Ywa0JHd1JpTm01L0tQbFBwcU9GaFN1Nnh3L0FE?=
 =?utf-8?B?YjRuSjFkN2JzbDVYZkVCdEVjcU55cmdic1pwd2dLV0ZabEwzUVl3MmFjNjFU?=
 =?utf-8?B?N0JqcnUvbSt4N3ZWa1Y5RVg0a1Qyb2I2cTVDdWttanllNk1uK0FoVFNKUDda?=
 =?utf-8?B?V0lqQ1FuWE91QUl1eHFxMmJNeFArd29udmxpOFVQTzJkai9QcUZUcmJWVXBx?=
 =?utf-8?B?OURZU3pYNVV0bE4zdlI4STdIcUYyMzErSDgrNXhFVUJTenJ4dHM2M0VLUGFp?=
 =?utf-8?B?L3ZzcEcvSkVQVVBobFdyclRuMHRveGltS21IUmpvNVAvb0xqQS9VNFhlZnA1?=
 =?utf-8?B?MjlGQVFaVUU5dWR5SUVid1M4RjVld2VIaG9uUUFoM21UYUZ5d0czWkFVTTJR?=
 =?utf-8?B?MnNrWDBVdTQ2d1Nkamt4bFdoajRBMzFuT1ZDcFJTeW5GajhJRkNJVVNydkpY?=
 =?utf-8?B?SUx1ZzdUU05aejlMbVkvNzJkZExVN01sV1hvYWVsYXcvQ0pNYnRhQjlrMXM2?=
 =?utf-8?B?YTJsUXlWQ0lzSkc5bEVtOHoxdmgrckwxMHE4UlVjbWtsalRvNTNPRXROL1Zv?=
 =?utf-8?B?dUUzcm83bjM1U0dabEhYUkpGZGxicys2RHd0dkpkY1dXZkM3aUdkSDlWSkJQ?=
 =?utf-8?B?dWpKMUs5OGZiSlhsV01TUUlPMU45ZVZDWFE4a1ExaUdBcktJMmxNSSt1Z0F0?=
 =?utf-8?B?WUk5aDBCeWJnZlBDYTNRTmhWdGRrZFp4bjZJVWNrdGprL3VwUGp5Q3R4UUIz?=
 =?utf-8?B?VnNPUzJvUzhBcFkvRENSdHZnekwwbmV5ZkNUQi9NeFVXWG03TGtVZWc1NEdF?=
 =?utf-8?B?UFlxME1yL0k0UGZwSW1nVWJBYjBtdXAwakx6Vm9Icm9TanBBL00xK1EvODRX?=
 =?utf-8?B?MWpOVDZ3MXptaVdjZTRtdWZ6YUM4b0VHWXdsSGpyUnF1N0tuVjBxYXQrbmE5?=
 =?utf-8?B?N2g3b0tSOXc4eE5SMEdReWFMVGlGZ1FWWDlpcEphN1hNYWx0YWlMSTUzcmJX?=
 =?utf-8?B?S1ZHR2xRbG5vTzlBUm1MclhzUmZwellkQUVXRGRKOWVLWUQvNlV6OXVXNHpX?=
 =?utf-8?B?N3RubjgxWmlCSnBZcEJSci9ZeXFDU25HczVxLzVDcW1YcWNiN2psSTVpNzNo?=
 =?utf-8?B?U0NIaWFvNW5IY3M0NjhoeWRJdWxlakxpN3VCUERUUnpObGlLamxZTzRkekda?=
 =?utf-8?B?S2gzL29uN0s2aGhZSkxlR2VEMDNFbytIZkpLODBsRXFzenhncjVNQTN5cW1Q?=
 =?utf-8?Q?Q5zGJRWor2yH0z3bf598amVWN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0052DDDE86B1946B5BCB76C70458D1A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4facb3-55be-4b17-64f9-08dc1e48e5b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 08:29:21.9933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4yw38EoqePNJXs+fN/oFjbUMcm2/OFZKobpy1Cgr7CQUGNhpXizo4mq289Aeg71c7Z3ZvzVnHJzpiyb5yTkDzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7248
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240126_002932_848304_6AF96439 
X-CRM114-Status: GOOD (  13.17  )
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

T24gMS8yNi8yNCAwMDoyNiwgR3VpeGluIExpdSB3cm90ZToNCj4gVGhlIG52bWV0X3RjcF9xdWV1
ZV9pZGEgc2hvdWxkIGJlIGRlc3Ryb3kgd2hlbiB0aGUgbnZtZXQtdGNwIG1vZHVsZQ0KPiBleGl0
Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBHdWl4aW4gTGl1IDxrYW5pZUBsaW51eC5hbGliYWJhLmNv
bT4NCj4gLS0tDQo+ICAgZHJpdmVycy9udm1lL3RhcmdldC90Y3AuYyB8IDEgKw0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1l
L3RhcmdldC90Y3AuYyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvdGNwLmMNCj4gaW5kZXggNmExZTZi
YjgwMDYyLi42YjYwNjI4ODNiOGUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbnZtZS90YXJnZXQv
dGNwLmMNCj4gKysrIGIvZHJpdmVycy9udm1lL3RhcmdldC90Y3AuYw0KPiBAQCAtMjIxNiw2ICsy
MjE2LDcgQEAgc3RhdGljIHZvaWQgX19leGl0IG52bWV0X3RjcF9leGl0KHZvaWQpDQo+ICAgCWZs
dXNoX3dvcmtxdWV1ZShudm1ldF93cSk7DQo+ICAgDQo+ICAgCWRlc3Ryb3lfd29ya3F1ZXVlKG52
bWV0X3RjcF93cSk7DQo+ICsJaWRhX2Rlc3Ryb3koJm52bWV0X3RjcF9xdWV1ZV9pZGEpOw0KPiAg
IH0NCj4gICANCj4gICBtb2R1bGVfaW5pdChudm1ldF90Y3BfaW5pdCk7DQoNCkxvb2tzIGdvb2Qu
DQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQot
Y2sNCg0KDQo=

