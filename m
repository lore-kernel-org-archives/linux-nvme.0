Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66D8C636D6
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Feb 2023 17:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TaPDDOZrMh+QDRriG57BuEbiis5Tsv0+jNlBMpJKpbI=; b=0tJP9iHVmamH/tlsSwaSl6dYEw
	V3xBR8+6FkInu6L1VpYsNPiuH+4HgNyLwYZFNHJTFlI1rcTcWIPMmQTVpGf+jCZyy7Z8hhGQwTJZd
	sRPPVGxZheItEgxfigS8bXfuET6d3cIwYR5btn+IisSS8VP8cd+z+77ugmOMsyumkayISD9B36VIg
	p9xYLGv08Fv7wKC4rEOTMitKQVMu3FljIbO7TbshIuimkzOPFpeBX2tFiWOv++yNQXBs1prGj7US0
	a65qr+xg+nHS+m47HjsXrsybfmVyhBEicZcDkGMFo3Lc0ABZ6gsTejEi2CXPMJSssM+fbc4Jcg0o2
	BGsWc0xQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQB9q-002e9o-6L; Thu, 09 Feb 2023 17:56:30 +0000
Received: from mail-bn8nam12on2062f.outbound.protection.outlook.com ([2a01:111:f400:fe5b::62f] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQB9l-002e8h-P3
	for linux-nvme@lists.infradead.org; Thu, 09 Feb 2023 17:56:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewTyzrGVdsSaZ95x+u1U3RZiWy/ovYyyAQjKhW/OLCsm28Gxr1d0nQKfYBJH8IVVVta8v2uxECCHniMjF64y2YTcAXY8vvuxuckNPpBMX45Wp70u97VykItFP7jbQH9G47DILoF4vc1VCxxYc/rbpkQKensG8fQ+3kv4590ysdAi2Dz/4ESrL6PkgmxdeVPSrHGx8nFBiqCWvjV0DtxsJA9ePQ7VGen8W6xG7SzB7DzaICS011wBjhvxM3S2vrgYSYWhP5dFfnueM/NBN1zA8aigIZBVCPCvkbPOTVS7fdolQWyfygeC58BR2573c+TpvBwqeiR++z3bi36vEFaf1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TaPDDOZrMh+QDRriG57BuEbiis5Tsv0+jNlBMpJKpbI=;
 b=P9uEHQX/dfHBAtjOs4VZXrgmGV7CcYaVl2h7bAh2msJB7Z2WrYqQigkyfSrcPghwHIEI0/2DRVTNSlsOWpSOkS44zh+qw/2Ux2Av2gLQ6mfNJCcNe2q2arCKP+mqX0iYC8QfQoF5gTNBum5o4t/btNYt6CwcdJnRqajcAdkKQEoJh1G6wYshQycGeXnQp2jHgAeKdCD+9CW00MhD61z7mpel2aBh51ReI8lqocd8s8uhTWrRes0T13YkAzIYHs4WIQXuNdpUNHdSBB4JHf8h+ee7goJCe75eO8Z+qi3m0jb2egTby6BTg07oNxqSHuA/nicH4xH6a11QlWPAiie5rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TaPDDOZrMh+QDRriG57BuEbiis5Tsv0+jNlBMpJKpbI=;
 b=pOAkRPmqnkPHYz2Ksfz9XcreblvWx6S3fwLrtt2G+LjWfnDmqYcaOvA5HgY7rRzMB5HuLF30OmLzHnT9Owp7wwM+YSapZ8qLz8PYhNpk/DiKMMRUDGw4hoCNhNeogFRufAY60+qmiZnlCuYiNpXe9g1mcpYLfmaFeMjLeALGS2NZEI2GvZboWSWJ81AQqyJT9aX3LQPW92lxuRJeKsIftKlPmVKxDOxHygOWyBDet7V7ugoGdX/4yzziC2up/I/dm9IJNzxyN7dIiJ3ovH8qLBR588ugtx+4UfKNMVhZxqUmHiNE6r41zdqUo3wLd9e0uZlHYEF8wgunNMFc/vK1zg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL1PR12MB5045.namprd12.prod.outlook.com (2603:10b6:208:310::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Thu, 9 Feb
 2023 17:56:13 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c%3]) with mapi id 15.20.6086.019; Thu, 9 Feb 2023
 17:56:13 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Daniel Wagner <dwagner@suse.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Gustavo Freitas <freitasmgustavo@gmail.com>
Subject: Re: [PATCH] nvme-pci: add bogus NS ID for ADATA SX6000PNP
Thread-Topic: [PATCH] nvme-pci: add bogus NS ID for ADATA SX6000PNP
Thread-Index: AQHZO9izYUG9Fc1OtUe10ppsSGOnQq7G5+eA
Date: Thu, 9 Feb 2023 17:56:13 +0000
Message-ID: <592530a9-73ca-eb56-94ef-ab46ee35d8c1@nvidia.com>
References: <20230208161435.112692-1-dwagner@suse.de>
In-Reply-To: <20230208161435.112692-1-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BL1PR12MB5045:EE_
x-ms-office365-filtering-correlation-id: c3ca131c-fad1-4f4f-a572-08db0ac6ef45
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  GKu68D1Zr3ZmocO7rk5k5sM+t7LTvNt2AowiM956tFK+JJ9ZGs1liqJxQQf8NB5XalV3V3AEl1rLJRENxD7WA/+TlfqOZwFMwuRvL7bzybg26KhIkD5OSVo4TAKDhSq0fIINfwUtXaFHy19xWggI5lyvN5J02AasG24x+rMJbvM3T7xF1xXMJ2PzLQ3r4TsG998PztOHAyncPML8MYypjfzMfbSqnasfMOol6B60ob3Sti2IkrER0S8Ivq6apfU3ONEltw5efMtqNsLpa17Colp7bWB4TVaYOFhbfr7OSUHLgE+qBfEXB5IUoSyKVEdY/8r42Vbq0d1bcd5Zpb2iY9PDO2S1He7XHgSrwJYkCSLwKVD9g4tyax7SqA4FPpKnm7ljY0LM0+pVekyJT70aFUtd1Pmn+6Fu/Oxr2SAnWKibxKfpBuMjBOVhyJU9tqaVBMAKkgUk0uaf5aNyBvMjRvMp8xFw3hHmkJ1b9LyOFfyhqSMdu2H45xgwEdqrcmRLI1nAJOz27JF/yQNbpntJMjXdlkn5XsBI271gri/bhID7imZEgEThZ465bOWVi1y7IB5ojACM5y/D9DGlQmq02/a6kCvpFuYYQ30c6tWOg1UbTeOhHHePJTNzd6Ot3FBCR/l4RAGjQB8ErCdn34IT7c5qTssh2mvscVeYnSF5JHCBjvSKlS7g63kK/+yuBh/UybgX5wjB4W3qxQ5sleW2V8/ikwqedl43Ops7nYFcy0CzHYzUohlFdy9/8yu1nq+PBoM4o4t42yRvxaMlenwru1anEQk2q+4yiVeV/6STTR8hY7wUeOkPgt6swMgU08QvNWuEZvLan3mQhCyyYjFHIpuald7NxrOa2uiWVz5bV1Y=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(451199018)(38070700005)(5660300002)(31696002)(86362001)(186003)(8936002)(122000001)(2616005)(38100700002)(6512007)(91956017)(110136005)(76116006)(41300700001)(4326008)(66946007)(64756008)(316002)(66446008)(66556008)(8676002)(66476007)(6506007)(53546011)(478600001)(36756003)(6486002)(966005)(71200400001)(31686004)(4744005)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?dGJYTmJlQlEvV0FsdDJqKy9ZcjNoMDJuNGNLaXAzeFNkOWR1MVpEQmt4RkVD?=
 =?utf-8?B?blFEYnk4MmptUVRTWXE2cFl3STExRCtrTmUranNqNTJXdVVZMW42b3dtK3RI?=
 =?utf-8?B?NE5HQlZmTlJpang5cURpSzRXRWxqTmI1K3FnQ1JzSzlrMjI1UXJaVk04T1ha?=
 =?utf-8?B?YzIvNTkzYUltQWxTeTJXK1JGYlJpMC9NRHVLN1RXbkZjRDFIRm4rV3N1R3Yy?=
 =?utf-8?B?TVNubFltSm9vYmEzZ2kreDV1d2w2V2lrWUNsUklab0hHM3lpY2Nic3ZBeGxF?=
 =?utf-8?B?aTFGNGFQVkY3WDc2WHhlckJpVllVcmJTQU5KOVVQT2E5dzUzd0JnTUhmUzNW?=
 =?utf-8?B?QzIrb2IxL05zRFpWVWd1eWxpd0VwVHVwVFpzWHZvRUpkSFdZb1gxbkZ5TVpV?=
 =?utf-8?B?cUdpdzBxckxwbzJycUVhVlJaOU5DQWhhQTV1bGIxTzMydThtZ0xvYXZJZkNt?=
 =?utf-8?B?WVYycGVnVUMxQUs2UHJmS1gvRTdrb3FsMXV1L05Kb3NiNkxQemRwN01obFBS?=
 =?utf-8?B?amJBUjB4ektmSWRjVFZBaXdLdGJhYk1MOHhCUkMyQlpWWHNCcTI5WEdpVEZo?=
 =?utf-8?B?N2tqbm1QdEZnTGV3ZTBValVaSGRlcDBOakJmSUQ4N2x4dGZuSVFXc2ozU3NC?=
 =?utf-8?B?d1pBMGNRNkF3NW9iTFdXZVNIUExDNmhZamYyTXBiZzV4Nk1FMlhhbzZXc0lX?=
 =?utf-8?B?aytGeE5wcmlmNXUzMWJ6bFhDdTdBc3FtRUN1OFU2Mm14RXlWVkp2UG9nZEhX?=
 =?utf-8?B?M0t0eTdZYzVkL0JEelRqWnorMmVDNG85d3A0SHMwK1E4NENURzBBUkJFWUZx?=
 =?utf-8?B?eWlhR0t5WXhLQlV2ZU9mSDloMmZoSW9neFBKVkVkekZ2aGluT3VrTG1lakNx?=
 =?utf-8?B?NlJvNEV1d1BBVXRjdjdVSWdNTUQ2STc4U1ZlZE41NStTTU5ISUlsd3FXdmMz?=
 =?utf-8?B?aXFVVnJjTUcyUE1ieDQ4eDB4MUhIVkFlV3FHejVUOU1XV05PZmpwcy95RVcx?=
 =?utf-8?B?QWRKWlpKVk8wby9Hb2tyTTlGaWZNTDBDK3hUQ1F5VnFNODY3UkhyM0VaVER6?=
 =?utf-8?B?aUpwRVBVenRSR09wV0phdXRMd3J4a3NMWXRXZDRZSlJidWwzZjA0UWllOHZt?=
 =?utf-8?B?Y2c1OG5vNUtlRm85a2YrWDM1NWt0QVFSc2MyejA3K1dOSTRSaFpjUjJlMmsr?=
 =?utf-8?B?WVpwYzk3NUUxRG9Bd3dETTY4dHBRUzFHQU9oenkvd3lZRG1hVDllUnQ5VGJR?=
 =?utf-8?B?RzN5MTJrRWpOM1VZZXRZeHlmdEt3ektub2Q0UUhHNTErTVR6Ukw5ZjBqU1RZ?=
 =?utf-8?B?WHJFeUd1eEFCMkJaQW5MSkg1RHA2UDMzUkNKR0diK0dhM21qRnJZTTVobU4z?=
 =?utf-8?B?aGgwNnlnRmQ2WEJqNlJld3VxRzI5Sk9GRWZoUUZxOGcxNzU3eldRNnN0ZUgy?=
 =?utf-8?B?K0EwMmxMcjZING1iRndQY204ZDFmL0tSYUNxMGVvYWlXQmhDOXpmdTZSRS9D?=
 =?utf-8?B?S3d5cE8wcDRCT2hvMnhQSFJLQlM3cFhiNC9tQ2ovVUI0cFh2cjVGSHhjWWRq?=
 =?utf-8?B?Ry9oR3BHbXR1dHN6cnUvQjh1d3ptekpDSWtxbzZpK0s3bEc3K281N1JjN1Fn?=
 =?utf-8?B?U3cybk1KYUlJS1JtcjI5MG9RMStMK2tadzMwR1REN05JMlVycTE5Vm83dmpQ?=
 =?utf-8?B?NmROUXFrUlFQN3ZjVXZlRlZ6ZkJaMnhObEpsdzJaaWpkeFVzd3dMVTY5NVFM?=
 =?utf-8?B?R1d2OGVvaURrZEdEN1llbXQ1MTVFaUFUeFVuRUNBZkc4L0x1MXpFbEZ6QUlG?=
 =?utf-8?B?dFIwaCsydW9sbnFjRGgya3NNc2tiakpPTlNUdVpOZ2FDVENKSS9EeDMzR0h3?=
 =?utf-8?B?VDJXR3g5L2JjTHFwYmNBbUtqUGhJRGtCWk1uSnR2Yktla0dqWk95U0IxWTBO?=
 =?utf-8?B?YzM1M1o3bFN5N1dSaXBNcFFrNlkwOXZvSXhmckErWEdjTm90RkxLeWJhbldu?=
 =?utf-8?B?YTVITlB5T0J0UTNaeUxXOUR1akIrdWYzaUcraGVhTW56cDlzc3N6Ym1ndVJx?=
 =?utf-8?B?NEtaL1VJbHBBRmVlVW9ITEJNNndyOHJHcElnL3N1SWY2alp4Wk9FYiswWVIx?=
 =?utf-8?B?OEJLRGkrbUExSzdPMmNONVFZam8xTS9vNjM2S2RNSVZvcGtXTm56SnlDY3l3?=
 =?utf-8?B?eUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D06273A1E937D044B1C28FEC94FDA026@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ca131c-fad1-4f4f-a572-08db0ac6ef45
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 17:56:13.6709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UNxTT7eZuhdRDHJmasO8OZQd7zYDc/cyonKonJMAjO+g23fbO84j0GIMXRUc5Rf8ND3652tUSTGTujlNcVorPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5045
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230209_095625_859239_F04A5EE3 
X-CRM114-Status: UNSURE (   9.12  )
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

T24gMi84LzIzIDA4OjE0LCBEYW5pZWwgV2FnbmVyIHdyb3RlOg0KPiBZZXQgYW5vdGhlciBkZXZp
Y2Ugd2hpY2ggbmVlZHMgYSBxdWlyazoNCj4gDQo+ICAgbnZtZSBudm1lMTogZ2xvYmFsbHkgZHVw
bGljYXRlIElEcyBmb3IgbnNpZCAxDQo+ICAgbnZtZSBudm1lMTogVklEOkRJRCAxMGVjOjU3NjMg
bW9kZWw6QURBVEEgU1g2MDAwUE5QIGZpcm13YXJlOlY5MDAyczk0DQo+IA0KPiBMaW5rOiBodHRw
Oi8vYnVnemlsbGEub3BlbnN1c2Uub3JnL3Nob3dfYnVnLmNnaT9pZD0xMjA3ODI3DQo+IFJlcG9y
dGVkLWJ5OiBHdXN0YXZvIEZyZWl0YXMgPGZyZWl0YXNtZ3VzdGF2b0BnbWFpbC5jb20+DQo+IFNp
Z25lZC1vZmYtYnk6IERhbmllbCBXYWduZXIgPGR3YWduZXJAc3VzZS5kZT4NCj4gLS0tDQoNCkxv
b2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEu
Y29tPg0KDQotY2sNCg==

