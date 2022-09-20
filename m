Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8808C6FA82
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 21:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yIAQW3P9R/Ag/tmzI4Xn0BXsUUWg5P7cqOENfxHxqZ4=; b=AT/SPPMCVPPFo5nBwGfvqKhKBj
	Mna0GDnTdQe64px/n3RDQLaX8kCSMCrT3aIYKmNtIKVP2eCHbTN6ZMB3bZKNKhtwzWr28rhYdrkeQ
	tAEodidTrDxR4rclaGJi10gORh3fkamO+g/hWf3oOetHl6P+uwP4ezBcf/lGefN+CgLopvCPfgpOZ
	cpCGa9MFEE/DkjvH+ETb1B8wSFZDzSFXy4Ge0+L1hucllTVput0sLLq5p6SK05803aRyIZ4HO5psW
	Ff5JJ7jOvVx20l2LhTpIOMgaD33DbtBqOOaPcG2GTvvqWXrs2yElKmQfs7+/PxlKH3Kq9u3R77E35
	1hD9w3bA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oal1u-007AWc-88; Tue, 20 Sep 2022 21:43:46 +0000
Received: from mail-dm6nam11on2082.outbound.protection.outlook.com ([40.107.223.82] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oal1q-007ATn-LN
	for linux-nvme@lists.infradead.org; Tue, 20 Sep 2022 21:43:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjXpDGApbS+gmQM0j9YMVhdRd4zzcv4aauwWB9N4P8pdX6jhbW0pUSyQ1NWYEzH1CRTOfv1X1I8oPd6+luou/msET7LEFbfR4Lz3KfFBNz87yoFC7pjPvxNRh68m7zuSHd55d6MHHwsGzCWFUL/P8GNMImexim4MH/IVQiyEYdQ2wplQNRDvN8qiI93M3zmScq2IllNGCvjyZhBwmYIdoSPDBCecKWTO1V7ECptOOWkyHgR1en/rdPbZNkLc+T04+UE8QBNhWpwl63XfBIKJ+TOsjeGPidcneSQn+fk8URI9/yp+J89RUvsYgDOKkcQi83AwITJtz36IbwGQRUkhpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIAQW3P9R/Ag/tmzI4Xn0BXsUUWg5P7cqOENfxHxqZ4=;
 b=dsyMu5y4aVvWynK2ntnEJ262wWu+eTqY0sSQWnQudIpCfsqvf5xH8N588DZsUpWF9EIZjaz2NUzQnva/xWX5NujSmitGi8IFdVGcVYSPON7IbEyV5SMnU+nccUoWIPkQpKZ2PHK3u7SBpScsPvXcWVGODtflOFn2ijR+4QkW+T3vibvipESg9AYoCUTxgl6XYpTbl9KCjs2ocHuaANbMkameloUFva+FJ8RHD6xFwmISBc7hjFZPzQGdk4iWd8cCncelYfRgZ9Gf1d36LCR+2dKK9oPLAPWIPJbqx09Gltk+/s9L9VOXXlpvTdwr+DrjsihF6tHLEtw8nTTiHTxz4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIAQW3P9R/Ag/tmzI4Xn0BXsUUWg5P7cqOENfxHxqZ4=;
 b=NyGrWOpyRIzYo+BbAqu5+SGLiK/+UFjrgoww39aIc/VxXwxPIuM27vHHNyb4gLFt7Wvu3Jt6v75PNnMwTQGGXmHgVGqD0eg5SL9ghq7Fm7HtL6zRxw7DF2z1QtsWKvBXoQ73EfqSMNutXteRR/JBrdaRNKKTejGu1j8gAuvXtK3BpsYPUEoqMh0k0XRp9EgM4XBHsILS/ajINFhsn8b/Ty19SLxs8IWXPFEFxHEdIiviJeS0th11tHebbJQJGGdgTwMffAenBnCjA6bZa/c6LWf4pZi1qA4y/AA5ZkVO022gS0Y3xeoMD5Mj5c+SYB88012ccb22cjjmwMIw669FyA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SN7PR12MB7129.namprd12.prod.outlook.com (2603:10b6:806:2a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Tue, 20 Sep
 2022 21:43:39 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266%4]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 21:43:39 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, James
 Smart <james.smart@broadcom.com>, Sagi Grimberg <sagi@grimberg.me>, Keith
 Busch <kbusch@kernel.org>
Subject: Re: [PATCH 03/13] nvme-tcp: store the generic nvme_ctrl in
 set->driver_data
Thread-Topic: [PATCH 03/13] nvme-tcp: store the generic nvme_ctrl in
 set->driver_data
Thread-Index: AQHYzRTY91i5bdfXlESARZgbC3MjJq3o2esA
Date: Tue, 20 Sep 2022 21:43:38 +0000
Message-ID: <b64a586f-02be-3541-dfff-e73cff99697d@nvidia.com>
References: <20220920171611.1289361-1-hch@lst.de>
 <20220920171611.1289361-4-hch@lst.de>
In-Reply-To: <20220920171611.1289361-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SN7PR12MB7129:EE_
x-ms-office365-filtering-correlation-id: e80ae72a-5054-43f6-858e-08da9b512dd8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  pnSCmmfnrHL65gDKxee4iQ+z0+E0naChQngKkD28IIWzsI6bxiTmIfDFDvVcyc/Y/wJl19wudqbCYOYGfcyl9elCGjPhCUDgqBsJKo2AKkrnXKt6xVSVNf0cy8bPrJnIEBJ5IDhcdw2zp3HAZAY/QT9gmQbjZy/BHqQFrpLWdnwEzSbO3E2TzRFKmb4GRTzJvVmdqd8S8Pgl41ZZVsc7xEKF9BeoS09s2DZR0rFZVj4AQeNYK/tHKahJmLaQdUUR6dKJHFJJRu/s2nl3A70/u8lH0Cg+FBchIxCm8MJCKMZWwbxImkN0NaKC7n+GPOWJbw128To9LOLIJ6S7a+Qdg5zWDReH1vdhLMSMbwe2mqZgi8KexlBzQ/v0OV2An/PIE6kR+Mu4NRx5AQ8bzeUgJm1n7nJk+dMjpDz24OGAWIlK2VCBPCVwDUFwDs4iKtXNMcwCb/oQUsUZNKQPLglQOGgVjGlrOKUJwIimWCnw9DkuaUf3X/FH28voUCw1gojlBgOIlLd84G0cssYzTlGlI/T5BOjvJddEjRTdACcbOig5SAhIwWw3so7B0y+Ngs+JLssTX9SUqV/0USgrCTyrzmea0n55ExElVsN6VlEQ6YR+HTCFfwD1lwS1TW0Ce29CUrATYMZxxdluWlZYofeNMiK4hpKzpaJpCTL+/QF3EWkF3TD8u+Nw24D7tLdbGnmtNpGG00wJ2to4KzkfZQZ3svHglmvFZxpL6AIAsIWGRzUGfb1qWBtrDgyIPReVpw8gP1TRomMBJ7nAXEE3X0Ml/+rKEvYEZ32DULCrNpuSgYVFZhiBkKGZFisdULqTP1ryF69rliNfpvtPgDGeuyoAveBdqzR4QNYxFej3n7W2WSs=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(39860400002)(136003)(396003)(346002)(451199015)(6512007)(6506007)(53546011)(38070700005)(316002)(54906003)(6916009)(478600001)(71200400001)(6486002)(122000001)(86362001)(2616005)(31696002)(186003)(558084003)(38100700002)(31686004)(5660300002)(8936002)(2906002)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(91956017)(36756003)(66946007)(41300700001)(76116006)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?WEZnYitWd3FEdVFjN2V5Mitsa1cyNGQ4RWFsdHBrWmdpdFRaak9PYXVOZ0Fq?=
 =?utf-8?B?MlBPZHUvbVN6RFN5NmF5UGdjNkxQZTA1Z0NJTFUzOHpGUUtwZVRiV3hwb0dM?=
 =?utf-8?B?bnNqSURJOG1NL3BtZk9QeW50ZXNFMFFsalFPMHYwVy9zem5PRU1EMHluUkZP?=
 =?utf-8?B?RlZlYW83NG1NQzUzVG9OUForR0JPTFdDeTZveEpCTm43ZXNTby9IMmNQQlpo?=
 =?utf-8?B?M3djcjRoOWZQenNETmVFd1lsUTN3TkppWGpQTHIvdjFTK2FYQUhEZjEzdXJN?=
 =?utf-8?B?ckpCWGJ3OENHcktCQnNwTWhDaG1xQUp0RlF5RFN2ZHVubHBNdUptQklXdi9k?=
 =?utf-8?B?ZGpmM212NDJtTjd2TW12bG5ETGRFRmhrR3ZNMW45aTk2cXBrdnlrcjFUVWdL?=
 =?utf-8?B?THhmTE1OQmVSOXV1b2cxTWxMd1l5anFsaUJxZDhEUGdhOTVFUWZuZW1EakVw?=
 =?utf-8?B?UUNwcERGMGFJaTZVNHRQMTJabWhmWUpnb29SNXU5TDB0RlpBNW92aGhrMDhI?=
 =?utf-8?B?WFdZTE5SOGdLZ3FGWkdZVTQyZzNkazJuNU5YZWFNcDNKcWFWRGVUSWVpYmd5?=
 =?utf-8?B?c1lTUDRZaUQ0djVkK3dXdWRubExDbzlFalFiOWE0ZG1abkVqejh3ODdjVkhQ?=
 =?utf-8?B?cXRRMUhVVk1GUzBDSXRmYUc0ZE51STdlWWVvS0wwQVN3aFVvRlNwRXRGTTJz?=
 =?utf-8?B?eWlhS1BRVng3UGlrNkQ0Q2thVWlCR2FqcWxBcjh5Z2xxN3hCS09BRzRLR3Vv?=
 =?utf-8?B?R2U4ZW0zWG5TdUFmVDYrMmFHekF4VGUyeStrUytwajVxUDMwRUUwa0hNQnJR?=
 =?utf-8?B?MWNMTjc4SUlSWjhBYjJVSFFYdzhZeElxVkNuNzgrK2V3Yko4Z2tUZ2RpNkpQ?=
 =?utf-8?B?UXhFMHRYTk9TN3duYm4xTWdWaVV4c2l6N2l6elB0ditTN1d2MzlvT1gvK3Zu?=
 =?utf-8?B?bFFGSjczYkJpRVpPeWZCTjhGejAvS2Z2NkZRanJYVVZSbkkzL1k5VEswS2Q2?=
 =?utf-8?B?NExTRmxkVVFNdFlRZy9meTMvb2VVMDVZdlpRNTlZZHNpTnNNY3Fvc2U0NTg0?=
 =?utf-8?B?cFFCTGhYWFdEc1UvV1VzbFA5Zm0ybDczemhJWmJtU1hMQW1UZ3VqeVpsOWdT?=
 =?utf-8?B?RnBFMTJPa0ZnYTg4aldRSjlUWVEzZWxvbCtURWJ4Y3NaK3lXY0swbG1BalZJ?=
 =?utf-8?B?NEd2M0lmSVpFMTd1MzVzanp4c2V2R3FiZUZIRzV3b3pORzd0cU40NjNrc0pZ?=
 =?utf-8?B?RnNnbDFXS1Z6bVA3ZVN1aVJUbE96RktSZ3BxWnYzaDYvNU1VNTYvMnBLTnRQ?=
 =?utf-8?B?TnA4eENiRGZ2Y3cvckJXaEord20rRXpMN0l2SGNYVFBUdVBhN3NPMnZJN2NE?=
 =?utf-8?B?azVYN0NpcHgwL01oc2J5UktyQzNRWGVyYy9RSGw0RUY0dUwrbEtkV1psQU9t?=
 =?utf-8?B?SGE5SUVzNHhuTkVYRTgzUzFBUlp2UG1oWUJrNDVuWjlHbnptdFp4SWcrVC9s?=
 =?utf-8?B?WjNja29XR1JWVXdyUGZ1TXBhQllBVFhUR1BFaStsYzdKbEtxOUExWjJUUjBH?=
 =?utf-8?B?TUhkTmxvbkIzUTRiQmV1L1QrYURublkrOWN2RmNEazNsVnc3emR2ZzRheExO?=
 =?utf-8?B?RWltaFhnc0x5Tkhza1A1NnNpc1I2aEZ2djQ4V2ovQWp2eGJqQ3VWczlrdGNh?=
 =?utf-8?B?VENScCtKWm5sUHU0bElINTUvaFcvVjNLRWhaTjkwSWtZbXJWenZqZXhkVE0v?=
 =?utf-8?B?ejZBS2p0K0hUWVZlNCtudEpZYy9QdVBSRlF2RDVHWlN1SUQzQmg1eDB5Zmxm?=
 =?utf-8?B?OHlsdkhvZjJ5RmdLN3RQYUxnZlZSZURFVGErVS9LL3lnbit3YVhnb3ZqYW50?=
 =?utf-8?B?T25RMjRMMExwUEYxdnZOVC9sNFZFQnM1TTZjY2VFNHYyV3gxbnBpQU9uNVp3?=
 =?utf-8?B?WGRrSndGcTVsMW9PdGFrQjQyTkRrQ0wvNVZGSVBSUmhZdlBqM1dFVU5VbnFn?=
 =?utf-8?B?U0dRTE9KQ25jMUdicW9tY1hUZE1rUnhJdGN6SzUxTHJYNDBySWtwMjJpSlMy?=
 =?utf-8?B?QmdHZVQvQ1cyMk1PcSsvVm9DTzRsZkdwZDdpeXF2QlVJMTVWTVJ6Qm4xeEtV?=
 =?utf-8?B?YjdjbHVITWNXeVdaZ1k1dkNtYnJPYWo2Z2wzOHpkTlZMaGpBME5qTGk5VFpQ?=
 =?utf-8?B?bVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9ED24098FCCBF34FBE8A441D951A84B3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e80ae72a-5054-43f6-858e-08da9b512dd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 21:43:38.9542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 92SnWAEHICaspOXMvJTUmAXYoEPnTlKet937ckgxBTQhaatr6zFeTQsoOdtKaLt6jFf1K/2xDEY1/XIuHN6a6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7129
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220920_144343_205785_2331D58C 
X-CRM114-Status: GOOD (  10.41  )
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

T24gOS8yMC8yMiAxMDoxNiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFBvaW50IHRoZSBw
cml2YXRlIGRhdGEgdG8gdGhlIGdlbmVyaWMgY29udHJvbGxlciBzdHJ1Y3R1cmUgaW4gcHJlcGFy
YXRpb24NCj4gb2YgdXNpbmcgdGhlIGNvbW1vbiB0YWdzZXQgaW5pdC9leGl0IGNvZGUuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCg0KTG9va3Mg
Z29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+
DQoNCg==

