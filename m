Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84FCCC54E4A
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Mar 2024 00:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I8vFSMEVP0ZySrfaTeVhHPZlLkepARE238fRzHWhuUU=; b=oG+UsVuItd7IyRm5iK2D9RBaVc
	/kxBwkSNIbmaMA+XhlIsH54lTjiQCZGpqOvKfyobWfLdoW8Mo4Dbmywn9AjmtbkKmTVgwGohLvcSu
	35wvzzlA6f2iLSLxlF4DDm1nrTH4nqXkrPjAH50ggIXq0gbObpDxSObM041oaafyryY2HIjqf0w3u
	UihgY6t0X98viQgaeslX+H1EpDYaagPLQAiv2kvXkydUXb9Xek81OvIKdw4BsePOisTWkhUQWeeCP
	y9y2zLjJP43iec0bWkyZgmrYL19Xy/qmwfqLyDqoTqFcSqDZ/8Fj7f7vPp5ZqAufdlm6pOHWQOY+W
	/OBBv9FA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riNrC-00000006wUS-20xa;
	Fri, 08 Mar 2024 00:13:02 +0000
Received: from mail-dm6nam10on2062e.outbound.protection.outlook.com ([2a01:111:f400:7e88::62e] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riNr9-00000006wSy-301V
	for linux-nvme@lists.infradead.org;
	Fri, 08 Mar 2024 00:13:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmKBKcVULm4mO/qnAOBZAQgAa/zuGqurSSUBUc2EzlG6eyV6kYYc4Q6cE2nDQwBR9S2Mk78FaBWlClu78JsdQw5fi0RPwS5II9JJ6RzHjFVszprekvB6F6EGmZKYGVETgTz9MMF2t1O4s/qFo3wMryr7FGc+UqbAuZ0BkeIoBGe7VBe3rUDDlHoXmbYksSWyw4iZ6nmVyelfdmHFIfY/hg8Kq6RbGEqwrkkiQQ3sZtKKz9Xb2MAAD4JXhCHuZm+7WD+3yiUJ3F5yOGsWVXKWvFl3zDAAxYdDqiZWNXpoHr8vqREPKXShAGuuNivHYbDEDYQOx74q1wU550Ww/hHlGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8vFSMEVP0ZySrfaTeVhHPZlLkepARE238fRzHWhuUU=;
 b=Ye9NmrFIovRe9pElDdqcKP/Dny424IOvWSFev0+x6sjaoQTuAu8s3Ucqm3RcacSTKWcStT7fwu3wt2NKSnb8AgJPWPIIEHnQ2l7H8Sj4qqu2WipduLW/C6rmtyWcdhwQ9++KBsHpkKowhUdoHJfWZy5TOR3IuCBiBJb6JxN8fWTVgg9E/XMtATDLxin4+MOtSmhf8HVLBYP3a6+p77tOfhCmIh6Hxs9wiK5pQUaCDsLb0mlSBZheKrkABqimrnKU5x7G3U03KcEsCJdYn+WVL3whjTzJuve5CpJiOWLDkUvs7E4h5oSLk7tmBbfJT99oUwA0ex3zBCtQmSZoLnIYHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8vFSMEVP0ZySrfaTeVhHPZlLkepARE238fRzHWhuUU=;
 b=uX+qBLo8GdWekzFh4G/RDxIu6nWZ6PSbmdW4HZBpr5s+ktdjWiRbutnEBUuK3mpQF2hrFZW0T7SChZVnl5hg2lnK1VWAWLAmGoPh9mwDZWmhyMPDKqPAy0RBhA2Q41H7gRihetwEj8c1cnrtJdJIaqp5Z4tiEGTopwJRGXqokjug7+sZdHMnNq7Db2t7uQFafv/07UuTPUehWdlKp1igZaQlvGyPBFYGdEIR6UF8WrfLSCfkuh+x9TA4HrZ5vdbVTDdAn/UeorwAZnTfaNuMy0GKk6p1rRfFxT+WN1jZRR9JVlrl7fz/cVivBKj7MZD8Tu486Nk4Aa0c77wTxrSXtA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH2PR12MB4087.namprd12.prod.outlook.com (2603:10b6:610:7f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 00:12:52 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 00:12:52 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Colin Ian King <colin.i.king@gmail.com>, James Smart
	<james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] nvmet-fc: remove unused functions nvmet_fc_iodnum
 and nvmet_fc_fodnum
Thread-Topic: [PATCH][next] nvmet-fc: remove unused functions nvmet_fc_iodnum
 and nvmet_fc_fodnum
Thread-Index: AQHacH7jIl6CGlcFikSHOBleBJYJD7Es+bmA
Date: Fri, 8 Mar 2024 00:12:52 +0000
Message-ID: <8f4ec68d-ab2a-462d-8a65-d63931a12696@nvidia.com>
References: <20240307110158.1981401-1-colin.i.king@gmail.com>
In-Reply-To: <20240307110158.1981401-1-colin.i.king@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH2PR12MB4087:EE_
x-ms-office365-filtering-correlation-id: 297a825e-0e10-432b-c136-08dc3f047ef4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3ydy+2lP/nNWkYlMd/camhQbU2GxftMjwfCWgDvX0QlPRqlyLcXzo0McUD46FK4PRtJgAodAb4ixmDBxjLXU0ggBsaHydZF29IcEhL76MA+SusUJv1evMx4YBhU7shhhcy3vgfgbwBZVpG0I1NcP7/cI9pzTFka23JVLR4BnAOaNDVE1P3kSGvlLZERSUB/minSgVflBNgM0ddeMjcIABEX4kih8pbIX2udkZ+/yfTshIzhLNWj99RdDB5Gfy2hhlMU7Qo5IrGH8+s9avPOeiWKtbN13wPnkgjV8X9uYZWZA13pVajkgeBUN4+7oOprRs1RnjKnwwUEKefCLu7qtXXMUX6orniNxxqil8akKu+Jz7uMQQDMvQeB7zUR0dBSukTeOeD3nFjprpnsdo3YqxpT+iEb8nsnYS2toMQbUvp0WSqjYaToZZIs5NezcrJXo18rH74CRpuTrtXbLYkEJas+D2s5HVq/VoPIDm1JtYaLHCTTB6u53aYHv4T+T4KuiSnLQFCOeTQ4RAg7pHLqi6EzZ+QorNYYd7kfz0QZBsLFND1/67+yOfcuA0ythr+UZYt0aaDP3/frIFGab8DXnmM568UUAdhhGmUqJD4DaeQ+hj/UXln27O1sbjLLfPk+x7ERlUhSHfyDXxsOFo+KuYu6i5us3JUXvjcQ5C5gmD1MBazjRpfjoXS9pVSM67bT2BGbljxs68dAaK1c7XzW8aYOGPQuvhwoPbt2W1zkytpA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799014)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjhoU1liL3YvTjVDY3IvbzZZdkFhaHdvTzZxQm42WXNYSEdtb05yNEFPanV4?=
 =?utf-8?B?SmtUemlSUnppNVRZSFloR3FLWjJ5UzhoZldXaWw5UHRHaG53RzBuenY2R1h5?=
 =?utf-8?B?eXgvb2pzZTcyc3YybEQ4VlNoRmQ0d0QvbUZSQ3BNeDByNzFzdWVEYVdKeHRS?=
 =?utf-8?B?eGNmRkozN1Q3T3dzd094RW5sanFwSnZuai9nQjdkdkR0MHlvYmhXdVAvd2x2?=
 =?utf-8?B?YU5JV2p0TEpWMDl2ajB6NHFyaUlhL3g3SmlXeTVZNmJiQVM1WnhsQzJxd0Ur?=
 =?utf-8?B?emRMWXp0Q0Y3NFBDSHlnYythYVVRMUtaeDQ2NkdXem54b2NaRTUyQWZtMGVO?=
 =?utf-8?B?MWR6UzFKTzdzYjV1VmtDcUJhNFFOU0tDcEpOTzBLZnVxQ1JnUVRMelZKeDk1?=
 =?utf-8?B?QXFIbjhmZUF3MUYrS2Y0bXF4OUdOaE5YalB4UThlcEllSmpDeWU5amZKYzA4?=
 =?utf-8?B?WUtDSjRjaGtpdUxMdXQvQUJmNkdPUXF5bG90U0lHSlVMcUo4eWVlK2g0Z1F4?=
 =?utf-8?B?d0E1YVNaaXA0T2hxNFZkTzhiNTRoSWV4ZGdBeEYreVNHc1R2RWJnc3hzM2pG?=
 =?utf-8?B?Ri9jTXp3TTdZc0VFQ1d0dnJwaXYvd2dxY2Z2K1ZLYjcwN2h0V0c3Rk42WitI?=
 =?utf-8?B?SWxtSEVRRHREQTlhbXVmNk0wbnlhRXFjcTVOS1JINHdUMGlWenZ1a3Vrdm14?=
 =?utf-8?B?bTcvVUFOSDh5azZsNk1lajZDK0hYYUwwZWcrQkZ3SjhpQVg1aWVuMDlvUG5X?=
 =?utf-8?B?TDN6VTdWcTlJMDEzd1QvaExuUEpGYWNPVkdUUmtMN01FbU9uZnFubEFWaVJl?=
 =?utf-8?B?RHV0QUFtYmZUTGdzck82RHVYaG5pa09ScjFHNUhhUlhLYkpGUUhrUEozTlhX?=
 =?utf-8?B?ZXI3SzBCSmtUVlZTNGJSajc0aW1RRXhsbEdja09hOFh4STZhWGhNNTQyTFdo?=
 =?utf-8?B?cW0zbHVWaGtOTERnd3FlRUM2WndQQ0xwcnpFZitieVJaNnc4RWx6c1lGSHJC?=
 =?utf-8?B?elY0Q1k3QjlpOUpmTisybTVFODdLTGdFVGFUandqYm9EN1hQcG92UzVqdFQ2?=
 =?utf-8?B?bkxFcGM3L1kzdHo2bGsyaW1XU05xYStZTnhROFFDMUJpRkc2bUwrbjZZdHBa?=
 =?utf-8?B?Nm5QK1c4OGh2Z3FxTDAyVU1sRUVwWjNBMjRDeDF5RzdRRHpzU08wOWx2MzVS?=
 =?utf-8?B?KytNSmNUZDhxNk9PQW5kUURRdzl0cUNUTVJQamFmMmdVWXhJaEtpeENBRDBW?=
 =?utf-8?B?ZktSOUJQaTdoQjF2VWZ2UXJuUDRXN0NqUUxNdTdrc09xdlVZTHprNDR5dEdS?=
 =?utf-8?B?RjVUR05HakFSRS9qOHF5eUU3QjdSZmQzZEdKSUljaDFISjF4RlU4OWkvcjRp?=
 =?utf-8?B?cGs2WXEyZjdlYUJJVGcvUjJjUXR4akhzbWpzTHVHNmFHUCtYeVVYVzdwbzI3?=
 =?utf-8?B?S3VrR2M4aFRmQUJWaVBwWUQyWTFsTFFsRUczN0FRRHFUTFZaSC9vbktQWkVs?=
 =?utf-8?B?T3E5VkZrMHBpNHNKVTRIM0tGVVN0cy9aZmNDa0Q1YVpjWnJMaVlKWTdyYVh5?=
 =?utf-8?B?NWR6THlQbGhpVGRWbTdSb2RMYnBIVjNsb3dsR056aDFSSjlodmRnWEowQ3VZ?=
 =?utf-8?B?dnNhczlaTEhZK25IZjdpTUordGhSN2ZPTUI1cVBlUzNoUGgxdmlncFhCNDhI?=
 =?utf-8?B?cWswaENZeGtDNXd4R2RGT1hRenVDc2Jpb1BBWitSWnVXVlZvV3JJbVpSOUZY?=
 =?utf-8?B?azlzblNub09DYW41Ty82Q3pLVU5wVXVRekxEbkh4a1JCTVh5TUpVeGZpMUVO?=
 =?utf-8?B?V1BCL2ZHWm1LWnUybUFZdFRLcElRUEM0c2dIbFJCcVZQdEZsVW9wRFRuNlZP?=
 =?utf-8?B?YUk5SkZwZC9qSFBoMVQ4VjlDVzVDOE8zZjR2ZUhwL0dOY01zc1JUUkNrK1dX?=
 =?utf-8?B?LzltSlhIN3pnQ2M0akhhaWlwbkhNNGhoYllIMnZnODI2d2plZ0FxeXJ1bnQ0?=
 =?utf-8?B?aTB6NzRkUk4xT2xvMzl2OHhEeWU1UVFIVGkrcVVMdXl0YzZpQ29Va0FpOXd0?=
 =?utf-8?B?U1RhMDQvcGhvOVpDNlltOFFyTm4wUGI4NVFnbTBQME9Ld1RNYmdEQ21lSWxr?=
 =?utf-8?Q?BlNIcCRrdQt8U9gSxJpIkPwa2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA5B58660C5E7641A77E2D2B36BB72CD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 297a825e-0e10-432b-c136-08dc3f047ef4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 00:12:52.1742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ig5xSQcpiiyHQNy+bJa9Om5vyWe4q4w37WDkujFjNI8O8Avq1AQdm/Z1tRc2xA55meatBJyBIW9nMilZGtoTuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4087
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_161259_787048_93F45529 
X-CRM114-Status: UNSURE (   9.79  )
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

T24gMy83LzI0IDAzOjAxLCBDb2xpbiBJYW4gS2luZyB3cm90ZToNCj4gVGhlIGlubGluZWQgaGVs
cGVyIGZ1bmN0aW9ucyBudm1ldF9mY19pb2RudW0gYW5kIG52bWV0X2ZjX2ZvZG51bSBhcmUNCj4g
bm90IHVzZWQgYW5kIGFyZSByZWR1bmRhbnQuIFRoZXkgaGF2ZSBiZWVuIGluIHRoZSBjb2RlIHNp
bmNlIDIwMTYgYW5kDQo+IG5ldmVyIGJlZW4gcmVmZXJlbmNlZC4gUmVtb3ZlIHRoZW0uDQo+DQo+
IENsZWFucyB1cCBjbGFuZyBzY2FuIHdhcm5pbmdzIHN1Y2ggYXM6DQo+IGRyaXZlcnMvbnZtZS90
YXJnZXQvZmMuYzoxNzc6MTogd2FybmluZzogdW51c2VkIGZ1bmN0aW9uDQo+ICdudm1ldF9mY19p
b2RudW0nIFstV3VudXNlZC1mdW5jdGlvbl0NCj4NCj4gU2lnbmVkLW9mZi1ieTogQ29saW4gSWFu
IEtpbmcgPGNvbGluLmkua2luZ0BnbWFpbC5jb20+DQo+DQoNCkxvb2tzIGdvb2QuDQoNClJldmll
d2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=

