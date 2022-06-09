Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B870C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jun 2022 00:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EFvKmyxViLP0w7bX6ptWD6KUzmenIi4fOwMUfYxqTkQ=; b=rjexC8kTu0rSbc4cgUJLHNGUzQ
	K+y+cMsTfaliDBVztXOUG/7eRw0qCVNPYRXAH49StiUhtHPzcX+hagBNTiVbgj5qivRxlsz+jEgLo
	ZQK3y9HaxRVA3Q61jbY+o9uUkDXYtuXtmCuOoCZsiA7poXaY5a97a4Pk9U4yPiuqMo/DgSNIit7Wv
	eiFTNgrJ+oY6+XKPM7wY9/1v9Dz5gC4dejKyNXP/VM4Z4g/BOICZHsNnZ03Z8P/ew9Mxt0+wbZDJ4
	VLz5C1KQcrONWDoUNdl/JOjpyXEOLdnLwWP9zLHVz16ELTiV3DpN6ProuFU3b49a/M9sx6KmgCoMK
	O+tksVQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nz64D-00FKdF-Ph; Thu, 09 Jun 2022 00:30:29 +0000
Received: from mail-mw2nam04on2060c.outbound.protection.outlook.com ([2a01:111:f400:7e8c::60c] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nz64A-00FKbk-9Z
	for linux-nvme@lists.infradead.org; Thu, 09 Jun 2022 00:30:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKkxEZVdKchHaqICkSg1++8hYgsE7Tl/uTEzMmIsCXRM7k3sdyZTHExCoX2ZRlUxF9jnNfCfkUhHZneZjEvB9zBpxhuVv3KuCPjc0mcedg60JHOPsFoGJpj7sE5pAO3Qcq8+estvT8ohpvhGJA/tK8Z/U1UOwBDs2D6Bnd6kRP/q+SkXJ500UFa/QM7+TedkJR0BXbVkEgTPC4e6oJDoNmYf8OTh56OEi6q6GdD86Juq6eXDqbKFuM0erC3K7AbiuQy27jvVo7q0Gw0mPiV2Z9XyO8dXZA5ta2F5YK1an/rqJmz+Z1zwruJltw2PZEL+Ahz/kp2eP2ip+gmOB9FpoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFvKmyxViLP0w7bX6ptWD6KUzmenIi4fOwMUfYxqTkQ=;
 b=JXPXk6huwrs/RG43ZeNBoi82BINip9dFRMyqObBhh1J1YN/9DmHxH1VeSn1ZyoReEIk7HeN7njrt85VuTzQTSR32XdLFlZ7sBN0iLLIi7z4btZ88M+46J5qnlLnVBIPZ4MxjM/2DQXoc6XJ1TsnK4K5ArJNga3Vj/6ZnCVeKByhNImuGmLRYGqPrQaykIKdWUK7Tn/qLb56he7eur5yJyVKl5TEjbrAIcp9xeZ1fIGEOTLaqr4oxgwrCdd7FOu47QbTLsn91o25rrqDEaQu9+4jbEZavbL5uIbaf8Wt9XjNVMn2ByCHxAdrx2Vvld/5nZyliD0zeWkqjO7yvvxccZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFvKmyxViLP0w7bX6ptWD6KUzmenIi4fOwMUfYxqTkQ=;
 b=p0XDyJt5UDtVHTyfTuradhCUR++tamxLITgaeI5IUyzP3Pp7ZTYYj2b/xvzgJEz5vbjdDurOf2i5Z8CShk0oMfO+xFg2tOWMlNOFE7lC9XypOqEhwLt/FV4pkn+BJrISfMeX1jel8rB9w93EJQR8XxGmVJ4KBs21UWJ/R3fuSIK2rBBa5ZrVJHtCdyqk/HFWnsrZ2BF9icJhXKIlichWxOEcBgvCq1cX2ngnCtfVm2UqnTP/X04CTVuN+LF9V/jLg3/QeXbprUr0V9A06dm0rfR+PKD7gChG//w6xjmGAFszJ6bz8g72t+YjKqgkDn2jx4sy7Qm5g5lSvuMaZE/9fQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM5PR12MB2422.namprd12.prod.outlook.com (2603:10b6:4:b9::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Thu, 9 Jun
 2022 00:30:20 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e%7]) with mapi id 15.20.5314.019; Thu, 9 Jun 2022
 00:30:20 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>, Alan Adamson <alan.adamson@oracle.com>
CC: Christoph Hellwig <hch@lst.de>, Luis Chamberlain <mcgrof@kernel.org>,
	Klaus Jensen <its@irrelevant.dk>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Thread-Topic: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Thread-Index:  AQHYKbU5emTG9og65keigbS9X9lVIazldeuAgABJzICAAB65AIAAlJUAgAAa24CAA+JAgIAADcuAgAwnQ4CAAhoogIBKtzaAgAJPjACAAKy5AIAADwMAgABa84A=
Date: Thu, 9 Jun 2022 00:30:20 +0000
Message-ID: <c0a42bcc-0d2b-7999-78e8-cfc70b0fdd37@nvidia.com>
References: <b395277c-5721-4773-9bbc-13cfbc1b0401@www.fastmail.com>
 <20220408161052.GA28661@lst.de> <YlB1E/p1uqpl3HiN@bombadil.infradead.org>
 <20220411050533.GB13927@lst.de> <20220411055455.GA14480@lst.de>
 <C85067CB-3909-4B62-A86D-467827EBF96E@oracle.com>
 <20220420073641.GA6859@lst.de>
 <26796ED5-859F-4844-B1D1-7C2FF5126E40@oracle.com>
 <20220608075252.GB13027@lst.de>
 <F8EC1673-8434-4294-ADAF-96238E65A7AE@oracle.com>
 <YqDy0BIgLbAVRw2u@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <YqDy0BIgLbAVRw2u@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd49b958-f50e-4e40-a6b5-08da49af3c07
x-ms-traffictypediagnostic: DM5PR12MB2422:EE_
x-microsoft-antispam-prvs:  <DM5PR12MB24221AB4B327754800EC6EA8A3A79@DM5PR12MB2422.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  1IojJwBMqMHI8ZXAyWqEng1qz0RmmOjFXau+wBim5nx43TiMPJwuoXo6ORcsBDvgnEUaReqV7yaM6AaKls05zhXGAPOtlG4O6azCaNUCXiAXHk5oQEWbZZUvtVhoNi4t/kRjvPR0ng7V55/9f1y7OLqhWNoEL2jB3scaOAZwm4rzP0SnS5SmikovxnxMDXw9ssGaLYEs5uvdcVjZp1iW4SIuFTT/DHIYup2l/W+qKVigzKeoR6dVwWxfQE+pN/g0yOwJC/u+oClfiQVMVsdjOH/KORz2pJFdxNnFSUzr6DpQ4P9MPwZK0Yf+qDhoJEc+Z2TEjfS5M6d/piu9xOTMYL2YCGUwCwuv5tBj/+ddLoO9IHSUzXFmKcNytzGGKnakVURwWIlWEk0jVggXIrUXJHW2IgsiyBfp/dQoEvyk1iARlLpB8lkwGLLBn1TP8QzUlVZ+tuy2BLhNgGfRZ2qVIG93189/KK7djziaUzHzRteHcrDEz78ZdyBIO8j18ZJh7+QgRYLNXYI1f7BjH7UAWHyI/QhB9mRjxwWK7czvcZHOul4D+p39bX04Y6dLUvmxJoRqSxLz/t+K79krvOSq7fSAPGemjc7Pl9kFm9Fji87d8raIcjG/mz5xkOa52X6+znqQiNVqBhQVebX8gXcWYbL6nUC2wltkRCzITH+PikK0bzGzRhDSTtsL7beY/WX7KKSeXs2i2hhvWF/6PUK+nKtWwWj2eMP82xcimeJijBaWX+aJ1OBQT6efcIX6FygZ7K2FVJE6TSkNeIKzsnumAA==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(122000001)(31696002)(38070700005)(38100700002)(71200400001)(6506007)(66556008)(66446008)(66946007)(66476007)(64756008)(4326008)(53546011)(76116006)(5660300002)(8676002)(508600001)(2906002)(8936002)(6486002)(36756003)(54906003)(2616005)(110136005)(186003)(91956017)(6512007)(31686004)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?VUZFWk5kd1MyN1I4R1hEZ2VmQWxRZ0xFdjV3ODRWM3d1UGtJT1RJZjZOY1J2?=
 =?utf-8?B?TTBZcGtEWG9WeU9tWVlhVUZUNnZqb0lHams3Mzh2ektuYnhKcnNSVUdMZnRG?=
 =?utf-8?B?Mk92YW1nYTlrcm5QYnpyOFJ1QzRTa0ZSR3dDcnBCZjhvQUgrem0vOFpzVDF3?=
 =?utf-8?B?cFRJVFR4QVhFZllySWIxK29EdWpLanhUM1MrajRMSmFtV1dBUGpsL3RJWVk2?=
 =?utf-8?B?YWRNM3lzbndKL201N1Q4NzRSdllqSlU3STRGdUd3bTQrcm81S2N6ZlR3V21M?=
 =?utf-8?B?RlM4Wit6alhqVjZXUFhZeW5OdEpaRGdvOThqL3RnQ1VuTG1saWM0UitjOStk?=
 =?utf-8?B?NFdyTlgwWk5HN0lmd3hHSmtjdGlBNEhWcmpoOFBaanNkbklWZnl3M1ZtQWp5?=
 =?utf-8?B?RElFbDlGOGZYa2xRVU9pR1RsQlB6QVU5Vi95REVTTm1CN21GZndqQlEzTUdM?=
 =?utf-8?B?Z0gxbXdiYU1jaWI0M2QrRzB0U2Zra1dVYTh1T0orYjErdjQwRXVlV0lRSXhq?=
 =?utf-8?B?cEQzYjFNa1NjdmlqK0p0aUc3Zk5YREJLVkloOUx3Z0tQTGNEcHF2U3pWTk5D?=
 =?utf-8?B?T3BCUmRzQ0RTaFZYRkdiQXV2R0I2TnJ0V28zM255U1NHM0toQnVEdTY2OW16?=
 =?utf-8?B?TE1scGhYOThBTlRmQVFURFI3b3VCcEIrMXA0QmcyT2QvRDJ3c0hWRi91R0lN?=
 =?utf-8?B?QzhKa3BHQVVEVlVxS1hLeWt1QVpPbDBNcWxwT0FKSXBkdFBUQzBZLzh5cGFF?=
 =?utf-8?B?T3lSL1ZGaXBaQmJwc1JVVzVWT2hJVUM4Z0lSQVJNMnVaMml2QnlvdGg3REYy?=
 =?utf-8?B?UWtUMjRKN1MyWGdqemFESVhOZ1RiZjlQSG1GbjVkWHZOUU9pU1ZFTDFPeGtR?=
 =?utf-8?B?Yzgvb0Rwa0hSVitGWEZTYkpoWGZhelpYNDYrdkFscjZMTHB3alM1aERkUG4y?=
 =?utf-8?B?ME9KVUNTaERSaUtIclFiNWsrV0xWd2VqLy9YWldpeWpKV1pFc2lxQzBNZC9C?=
 =?utf-8?B?Ny9obi9sZmQ2L1Eyd29RaVNjZFl1M2FJbVhYSGlLalFvMkd6NTN6WmkySnpk?=
 =?utf-8?B?bnRxV28yaUZzY3o4cDcwNWJXaW9kZnR6OFZmQlMyUi9aRXpxUURBYnd5YkZm?=
 =?utf-8?B?aklxc3dYdU9abTYwRGRYU1ZYYVBHV1JjdnprZ1Zabzg3UVNHS1gvWE9waC9t?=
 =?utf-8?B?c3I0RDJtVit6dEdpdUNwOFE4blJhM1NFQU9nVzhEd1pwV0FxZDhPUlRMRVRZ?=
 =?utf-8?B?ckcyaGR6U1k0Zm1ka3NTS3BkNlhDQ1ZFNEZ2L1F2YmJyNStNMExQbXk5SDJJ?=
 =?utf-8?B?SFMzWlFsSFpqMmVHK0g4YmtNZHFKa2JiVnk5SHUvODhyL3NCQk12UEp4d3FF?=
 =?utf-8?B?RHRMNklqUkJ6aExOVk5KOGlmWkRkeGhZMjcwaTFHYUtmcEJMa1dsUktoTjNk?=
 =?utf-8?B?c3QxaFVMNSs4L1BmZWhqeVhYOCtpakZJQThIZGNEWTdxeFNVZVB0dkxSaDdm?=
 =?utf-8?B?TG9ua2lHdXZXTEJTeWFDbE8xQjJVTUZPNTdtLzRseXBsOWR6N3V0bVFsZ2Nq?=
 =?utf-8?B?Zzd2Umc1S0p6VjFia0o5aXRrdk5HaVBiZy9QVWJDelBIVWh1VFFkcDhxOU5u?=
 =?utf-8?B?V3ROZWlzdFMxZVAvanZtNi9TeEwrMmZOY1ZTbmxwYTFRUlBZRGZ1ODJkQThS?=
 =?utf-8?B?MlRiNWRQMTY2Mjl6dGtkTmNRcnQvdEhTSXNic1ZYN3Y1ZEJEYVE1VHJoUXNy?=
 =?utf-8?B?V3B1emVZbDhzbzlLVEI0TDNKMUp4WmxYTW85aFR1eVpFTHplODMyUDNXQnJa?=
 =?utf-8?B?YUhIeE8ydTl5WHoyYlNWWnlxY2kxTmRwandtM1I4ZnBQcVVlalR5ejZwUDBP?=
 =?utf-8?B?bDg5MUxSMGRGc2g3TGk5cEoxSmFWZGdjbjdVS2Vtc3NORXNNaXAxdnlDRjd6?=
 =?utf-8?B?VkE5YU96ZVU0U0poK0lHeEt0WkdDQjlUNE4ya05LTkxidVhuRWtieGtLdzZS?=
 =?utf-8?B?NzNzUzBGYkdIUVhURVY2SVB3S2x2Uy9lbDQvUWtpYVVrdVRWdHdETUtWSUMx?=
 =?utf-8?B?eFNGUUFreVRZV3pVOGJYQ3phYVdPK2xFS1gyQzRYc2ROQlFvR0M2QnVCNzJ6?=
 =?utf-8?B?dFB6YmcyVW9QeC8rQys3bW43Y0xUSnNscjgxZzlhaXlCLzlJUjdQcWpqa0hD?=
 =?utf-8?B?NC9tWXJyV2RINmxpbnp2NkRHbDJoZXJFbi9ySHFqSkM2bE9wZ3VoTGxRUUJK?=
 =?utf-8?B?NDdUMklLeER2STBoR1ZyaC9kTEFjMmlyM0htSmRyTllzZUsxQjZzMHhXT2xU?=
 =?utf-8?B?Zm9rMnQ0OGpyOHd3Y2lGWEZCeklpN2FsT1hKcjIwcTU0UHNlSVNDSHViOVpp?=
 =?utf-8?Q?fXZmS9SX7iloinlNVk5IW0KlMoVgxyt7ei/wPhi9jbM9C?=
x-ms-exchange-antispam-messagedata-1: 25Xf2bkTij/oxg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <D032D816D6DBDF4ABE1DF63DED1F94E5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd49b958-f50e-4e40-a6b5-08da49af3c07
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2022 00:30:20.1429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vyoU8kf40MZXk7T4Pf5BdarywDOsTcYULIeFtYvJJdFj4hHGhsTt/1trANtj+mz3C7P1QlRAnTRoQoGJ55HUBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2422
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220608_173026_398710_292B4600 
X-CRM114-Status: GOOD (  23.32  )
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

T24gNi84LzIyIDEyOjA0LCBLZWl0aCBCdXNjaCB3cm90ZToNCj4gT24gV2VkLCBKdW4gMDgsIDIw
MjIgYXQgMDY6MTE6MDRQTSArMDAwMCwgQWxhbiBBZGFtc29uIHdyb3RlOg0KPj4+IE9uIEp1biA4
LCAyMDIyLCBhdCAxMjo1MiBBTSwgQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+IHdyb3Rl
Og0KPj4NCj4+IEhvdyBkbyB3ZSBnZXQgdGhlIGNsZWFyX2lkcyBzZXR0aW5nIGZyb20gdGhlIGNv
bm5lY3QgdG8gdGhlIHRhcmdldD8NCj4gDQo+IEknbSBhc3N1bWluZyBzb21ldGhpbmcgbGlrZSB0
aGlzICh1bnRlc3RlZCk6DQo+IA0KPiAtLS0NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS90
YXJnZXQvbG9vcC5jIGIvZHJpdmVycy9udm1lL3RhcmdldC9sb29wLmMNCj4gaW5kZXggNTkwMjRh
ZjJkYTJlLi4zZWFmNDYzZDA1NjcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbnZtZS90YXJnZXQv
bG9vcC5jDQo+ICsrKyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvbG9vcC5jDQo+IEBAIC02ODcsNiAr
Njg3LDcgQEAgc3RhdGljIHZvaWQgbnZtZV9sb29wX3JlbW92ZV9wb3J0KHN0cnVjdCBudm1ldF9w
b3J0ICpwb3J0KQ0KPiAgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbnZtZXRfZmFicmljc19vcHMgbnZt
ZV9sb29wX29wcyA9IHsNCj4gICAJLm93bmVyCQk9IFRISVNfTU9EVUxFLA0KPiAgIAkudHlwZQkJ
PSBOVk1GX1RSVFlQRV9MT09QLA0KPiArCS5mbGFncwkJPSBOVk1GX0NMRUFSX05TX0RFU0NTLA0K
PiAgIAkuYWRkX3BvcnQJPSBudm1lX2xvb3BfYWRkX3BvcnQsDQo+ICAgCS5yZW1vdmVfcG9ydAk9
IG52bWVfbG9vcF9yZW1vdmVfcG9ydCwNCj4gICAJLnF1ZXVlX3Jlc3BvbnNlID0gbnZtZV9sb29w
X3F1ZXVlX3Jlc3BvbnNlLA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL3RhcmdldC9udm1l
dC5oIGIvZHJpdmVycy9udm1lL3RhcmdldC9udm1ldC5oDQo+IGluZGV4IDY5ODE4NzUyYTMzYS4u
MDNjZTA0NWFmNTRlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL252bWUvdGFyZ2V0L252bWV0LmgN
Cj4gKysrIGIvZHJpdmVycy9udm1lL3RhcmdldC9udm1ldC5oDQo+IEBAIC0zMDAsNiArMzAwLDcg
QEAgc3RydWN0IG52bWV0X2ZhYnJpY3Nfb3BzIHsNCj4gICAJdW5zaWduZWQgaW50IGZsYWdzOw0K
PiAgICNkZWZpbmUgTlZNRl9LRVlFRF9TR0xTCQkJKDEgPDwgMCkNCj4gICAjZGVmaW5lIE5WTUZf
TUVUQURBVEFfU1VQUE9SVEVECQkoMSA8PCAxKQ0KPiArI2RlZmluZSBOVk1GX0NMRUFSX05TX0RF
U0NTCQkoMSA8PCAzKQ0KPiAgIAl2b2lkICgqcXVldWVfcmVzcG9uc2UpKHN0cnVjdCBudm1ldF9y
ZXEgKnJlcSk7DQo+ICAgCWludCAoKmFkZF9wb3J0KShzdHJ1Y3QgbnZtZXRfcG9ydCAqcG9ydCk7
DQo+ICAgCXZvaWQgKCpyZW1vdmVfcG9ydCkoc3RydWN0IG52bWV0X3BvcnQgKnBvcnQpOw0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL3RhcmdldC9wYXNzdGhydS5jIGIvZHJpdmVycy9udm1l
L3RhcmdldC9wYXNzdGhydS5jDQo+IGluZGV4IGIxZjdlZmFiMzkxOC4uOWZhNWJjMGUyNmQwIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL252bWUvdGFyZ2V0L3Bhc3N0aHJ1LmMNCj4gKysrIGIvZHJp
dmVycy9udm1lL3RhcmdldC9wYXNzdGhydS5jDQo+IEBAIC0zMCw2ICszMCwxOSBAQCB2b2lkIG52
bWV0X3Bhc3N0aHJvdWdoX292ZXJyaWRlX2NhcChzdHJ1Y3QgbnZtZXRfY3RybCAqY3RybCkNCj4g
ICAJCWN0cmwtPmNhcCAmPSB+KDFVTEwgPDwgNDMpOw0KPiAgIH0NCj4gICANCj4gK3N0YXRpYyB1
MTYgbnZtZXRfcGFzc3RocnVfb3ZlcnJpZGVfaWRfZGVzY3Moc3RydWN0IG52bWV0X3JlcSAqcmVx
KQ0KPiArew0KPiArCXN0cnVjdCBudm1ldF9jdHJsICpjdHJsID0gcmVxLT5zcS0+Y3RybDsNCj4g
Kwl1MTYgcmV0ID0gTlZNRV9TQ19TVUNDRVNTOw0KPiArDQo+ICsJaWYgKGN0cmwtPm9wcy0+Zmxh
Z3MgJiBOVk1GX0NMRUFSX05TX0RFU0NTKSB7DQo+ICsJCXJldCA9IE5WTUVfU0NfSU5WQUxJRF9G
SUVMRDsNCj4gKwkJbnZtZXRfemVyb19zZ2wocmVxLCAwLCAweDEwMDApOw0KPiArCX0NCj4gKw0K
PiArCXJldHVybiByZXQ7DQo+ICt9DQo+ICsNCj4gICBzdGF0aWMgdTE2IG52bWV0X3Bhc3N0aHJ1
X292ZXJyaWRlX2lkX2N0cmwoc3RydWN0IG52bWV0X3JlcSAqcmVxKQ0KPiAgIHsNCj4gICAJc3Ry
dWN0IG52bWV0X2N0cmwgKmN0cmwgPSByZXEtPnNxLT5jdHJsOw0KPiBAQCAtMTc2LDYgKzE4OSw5
IEBAIHN0YXRpYyB2b2lkIG52bWV0X3Bhc3N0aHJ1X2V4ZWN1dGVfY21kX3dvcmsoc3RydWN0IHdv
cmtfc3RydWN0ICp3KQ0KPiAgIAkJY2FzZSBOVk1FX0lEX0NOU19OUzoNCj4gICAJCQludm1ldF9w
YXNzdGhydV9vdmVycmlkZV9pZF9ucyhyZXEpOw0KPiAgIAkJCWJyZWFrOw0KPiArCQljYXNlIE5W
TUVfSURfQ05TX05TX0RFU0NfTElTVDoNCj4gKwkJCW52bWV0X3Bhc3N0aHJ1X292ZXJyaWRlX2lk
X2Rlc2NzKHJlcSk7DQo+ICsJCQlicmVhazsNCj4gICAJCX0NCj4gICAJfSBlbHNlIGlmIChzdGF0
dXMgPCAwKQ0KPiAgIAkJc3RhdHVzID0gTlZNRV9TQ19JTlRFUk5BTDsNCj4gLS0NCj4gDQoNCnRo
aXMgcHJvYmxlbSBleGlzdHMgZnJvbSBlYXJseSBkYXlzIG9mIHBhc3N0aHJ1LA0KSSB0aGluayBz
b21ldGhpbmcgbGlrZSB3aWxsIGJlIGRlZmluaXRlbHkgdXNlZnVsLg0KDQpBbGFuLCBjYW4geW91
IGdpdmUgaXQgYSB0ZXN0ID8NCg0KLWNrDQoNCg0K

