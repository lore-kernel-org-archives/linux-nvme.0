Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F48C43334
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jun 2022 08:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uR1DAuXxe5baBGlM5xLSoDGKHMduUO1b6xzaDnYkV28=; b=IyNpC5QrF0Umn7kFGjNMY/vg2S
	7N0urs0MSkBurPUj4d/nWiTj0XNtvREkx+5HIjDVzB2ytP/bISjc9CMHn7M/vxUJF7ZHpVoiJCOky
	TGX5h+M0TELPZ960Myr1cZstQoSyxfv6EAHmnX/b9sFsRTN6rbvCHkufUo8lB8M2hXQX9Lr0vyaT+
	lgViGmssHeG8ts8WaeJFvx0GUl64VU6cF/RkXhBFGHpNlYSmFdUe3F19LOenXpgF5UWmJbhyI6nyi
	WRL3ii8EkrtvGI13n+l6RyqgQqy6KGJxU+ICyyG2h4cIbpvng6ylCeTeJpXH0mvPhPqBz6nOybPLx
	0kSDJDjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzaQf-006xGx-Ji; Fri, 10 Jun 2022 08:55:41 +0000
Received: from mail-bn8nam11on2060a.outbound.protection.outlook.com ([2a01:111:f400:7eae::60a] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzaQb-006xFz-Ta
	for linux-nvme@lists.infradead.org; Fri, 10 Jun 2022 08:55:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0vjkFS2APo/Tb0dbpogcN4OnJhUFzMsQvvKTqrp9LoDAUNRmWBsRBmclCsZyATAKD59C+LLuOq2aLxBBevynafUt7NH2bjjqg1ipcoBdCl8vr4ftc4WPOwpkljf9nSGc0A71NIdTnXgzKsxc+9OpxQiqIepntMsqhs94j8XuKqxK+Spz7+i166uNQMCEajmwpH8/fpWO0YAQng/K7NzcopAamEakEKDXO41OKCF1uDsZJoR6uLnerrC249drKzVExfKVelKMLVCg1euMY4DN1JKiGXWWEHTDCFuZWdo/SITuiMEokFsc/zSEOWMJSTLPXDska7ixaO2E2gZNdx/pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uR1DAuXxe5baBGlM5xLSoDGKHMduUO1b6xzaDnYkV28=;
 b=At+UcA9BQwuRdYnkam5gQLQnU2Wp6K62LbF2hAb4BExdW1H75E2TYEFQMGF3hfePxNvqYW00jOpG+G32Z/n9LId5VvNCoRAk77n4XmSKU9jDCGMBmr0QrLhQXEXv8p5tLKKxmYNHwOSPcH3LWWutcV/0nD40nKHWDKXgfiRv6clcE7CFU7tU3XjLxYY9u4MTyPI4YO28di4NefhJlX4rf0qyQbk2aN5kpHSyuDOdhaagaGIITslsNQSYQS1fzeB5ZzMxQ3UgbWBV5UrlAJRrLi2sGVGDlAGVwDq08gzyES1URP0b43zDjdImnASQLtCFnkDHyEkaEn5pfLyYYk2fzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uR1DAuXxe5baBGlM5xLSoDGKHMduUO1b6xzaDnYkV28=;
 b=YskjM+8Ej78MSgFB+eUmt0SSccR/cq9i0mlCYe9KmoHwfa5g7EJNRw4rRvUlqnN/Xks1zUv16ab0XLbMXpl8hAFaAvrtoiY76Xf7S7nppe5VqZRdiFEhjNxZ/h03BUOD/gIY0wfocFE3UkWRYM3WlxTdPTbhPess3wIykC5fHik14Wvwax6h4d7F4ytxQN73SEp8oXUEdSQD1kShm1lfbNyudn5C893nAiSFisDdCLbhvGSHd0b43NdP67jtxVxEZba/68RUg2BYP+P1Irkr8A6pwVGf8WUHNo6ESQh6YXMoWAZFLUygiae2LmoWNadsydxgzNmT8DLso7ixqwwHOg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1790.namprd12.prod.outlook.com (2603:10b6:300:109::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 10 Jun
 2022 08:55:31 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e%7]) with mapi id 15.20.5314.019; Fri, 10 Jun 2022
 08:55:30 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@suse.de>
CC: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>, Keith
 Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCHv14 00/11] nvme: In-band authentication support
Thread-Topic: [PATCHv14 00/11] nvme: In-band authentication support
Thread-Index: AQHYe0aSk0irjXINo0eCGJTZzeAdv61GRZ6AgABSZ4CAAcEZAA==
Date: Fri, 10 Jun 2022 08:55:30 +0000
Message-ID: <7b9bdd9a-1411-ca0d-9f87-71e2c25dffbb@nvidia.com>
References: <20220608144518.67607-1-hare@suse.de>
 <bc6d292f-f1f7-3cc4-772b-ef8e2a6466db@nvidia.com>
 <3d2cd533-6bd8-abfa-4df9-40aa6a2eae63@suse.de>
In-Reply-To: <3d2cd533-6bd8-abfa-4df9-40aa6a2eae63@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59e7f487-a14c-492e-8331-08da4abef902
x-ms-traffictypediagnostic: MWHPR12MB1790:EE_
x-microsoft-antispam-prvs:  <MWHPR12MB17907FC7BFC6E5EF994EE791A3A69@MWHPR12MB1790.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  v1CDyOv/8ix/dYisjD2sop9NzjQ52TDQyEjFAyElgsYtJGBOl9cBNNDde0p6i+oHI43hrBuxDINPrj/HGmiJsFbEEsbKRCH2kCIEI3sCH5tCOaieYsl3cpLgNEpJ/lO2oE/h8d21sOEJP50y7GrCSAGY6QfwbqmeRjoapCHu9gdbX62zaKSljiD1z5SvOe25qOdZtIFAF3oAj7tVZkWeF23jtiKgtcyyJwUuV7DZ1MtD6whe3x5SCoarMWyX6SYWGwRNEzs51MQQcLlC6eNCP7HhGQZTx9+LCd1MAc4bffZ+EzcFdt3SG/sl0wOZ7s1dmxYMZZ1D2Rs5cSftfhHCoTfhoaFFHc7bAUncR6Htjc9MrIHyCHBOLRDaDWe5GZ5RQMFs6xmpl1lHgPhCg0vzcaSvdeATLCAiQkELbQalqwCM9tWxp4h0jfYpyGrdJl9wTjzLufuH/RDIIUIu8YtQVl8vGm9TxDsuHmr3i70cEx8R9NmX4gjiCmXtZCalJPoZV/Gf6bR6QK+0PV8JF+HGxgQgODvtjkb0YU2OXDFkM+f+o1T5arzxlRrea54x4TJo+QZPwxptG6dgeW337IqWKnTS4Pm6kZzJyz8fATpxAjzsbqolNSDnv3kYIjqZXu8tqZZtuXfKfYKj8whxs3JSt5Gd9ARhxA3qC9BtDIl3Wvv/bk8c3PsWw3fWv9+wEpC5kt9TcpMGviSAQkeGwDJWrcYIFm0GEj1cXNPNgZDJpBuxF0fah/24637apSntDI+KomAwWg0y8w4q48m3HE5mig==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31686004)(2906002)(38100700002)(6486002)(508600001)(5660300002)(8936002)(36756003)(76116006)(4326008)(8676002)(66446008)(66476007)(66946007)(26005)(6512007)(66556008)(316002)(64756008)(91956017)(31696002)(83380400001)(71200400001)(86362001)(54906003)(6916009)(122000001)(2616005)(6506007)(38070700005)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?SGFaTTB0NmlBU0xsSWRBVmdwcVA5S0p2ZVpleEQrNExXQ1V1QkNGOHdBc1dZ?=
 =?utf-8?B?eUpHazZkQnd1Z3FobTJYV3pKaGp4YkdBNExrUGJpRkxDQVFjYmh1U25TcWc2?=
 =?utf-8?B?ME82WHpPUjRuRnpWWWp3U1FWYnpVa3pzdUEwdEhhSmprM1E2bHFIRTF5aExK?=
 =?utf-8?B?RzFxTnNCU2s1UTNyMWhvY01ISUR5dHhYeXZ4TTYvVnJCRUFDRk1rTE1SWUZx?=
 =?utf-8?B?NWMvcXdUM0hiOE5TNGpGb05ZTGl3NE55UGhORGI2MFJFSDVOeU9zOGJqL2Rz?=
 =?utf-8?B?SGhzTkNFSnA1Mm1yZWtaZ3VPRjBTNmIzMDFUdFNYSFJLQmdCWHpQTkNaRStH?=
 =?utf-8?B?TjB5eUNrU3pRdndldStLOWJkditUL1QyNE5Gb2p2TnlNQlVUS2pCQ09zTUJN?=
 =?utf-8?B?TGZFblhCeWtqRFh4cnNkUmlMN0duYmU0eEIySGRxbFVpQlBFNHJpQ0ZyZlZi?=
 =?utf-8?B?TDNJOVlSTVRLdG5DdzZNMHpYMjJJa0lGcWhDREVDTUVWZ2tlV0JXNEEwSmR0?=
 =?utf-8?B?dlZTRXFEcEtOalMzTWFGbXQ1em1QQ0ZSeDJ6S1RxQ3d5RUFOTENML3o5cWhw?=
 =?utf-8?B?UWNqZFZKeVVPbFJjVHJJVVVEWXhkb0Z3SU1RSHFzQzA2WFlka0RNSkdaRWxI?=
 =?utf-8?B?YU16QVFjaGZ6aGdMZjkxQVJjS0E3Z3ZrTElTVHdmcFFqVzJvcmx0QklUeU96?=
 =?utf-8?B?RE9iaW5FNURlNnh4c2ZOdHpQSmF0OExqUFhWK1BxV2JDb1lkSmpiUFkySTBs?=
 =?utf-8?B?RUh4TWVWcmR6REMveU9wQ2w0T0FMUmxZd1d1RUxZd1JVc2I3eVBiU2lzNzR1?=
 =?utf-8?B?QUU5M3orM1VoOWw2MmU0YzZXeDZjTTdjYlcvVFJQTWFwSTJGUVhkcXZtZzVC?=
 =?utf-8?B?QWZKK2p3QnQvQ2JrUXEvdE95dFZwQzVwc1dsZXB0Si9MdDN6U3JrWlhqZk5s?=
 =?utf-8?B?Q2NKUENkOWNkZ3pvdVdKSkdyQjFMc0lRNUdnOXFaUkFzdmFkVXROMEcwSWE2?=
 =?utf-8?B?cG1NSDlLWlozZmN6VjNGQnVBRCs3b3ZISksxazVJYnh6TVRVNzJ3ZkZYcjZm?=
 =?utf-8?B?R0dSOXZWTjdtcDFhRGF4eXkwdVhKOXJwNHYrRWhXYTBuWFZUckFYM0FhQ2ln?=
 =?utf-8?B?dnBJNm5OTmFWWXZQTHVKcHBMTCthd3NaNmhmVFBMZUtDVHlrQi9Bd0tKUm41?=
 =?utf-8?B?OExGNTUrQ0ptWTM0QTZTTHJKNWtQM3EvbzA1R0p6UVkzTFNVNE9UTWF6b1ZC?=
 =?utf-8?B?RGp0Z3ZNclRCTXp0MlBmWXc3b1M3bW9JSkJTdW1oL2VzRzhzM01wRjFTTk1S?=
 =?utf-8?B?clluWTY3S1pybXd0RjdlK29BSDg0aWpYc0xjOS9DUUV4dDh6d21NNjJEQ2Ja?=
 =?utf-8?B?S0pTcE5IcVJKY082L25IL1lEZWE1UlBpbldFL3ZoYzZGOFFmRWhSTG1GWHlm?=
 =?utf-8?B?T0xWSy9PSnM2bm1lY0psNGxWUkJQVVZUTkgrV3BKQ2pRL3k1djM5eHR4Mmhi?=
 =?utf-8?B?STZaS3J5a0xkODVuRkNlTWhUeS9RMCszaitBdlZ4dXIxWGpEdlBuTTZEbjFr?=
 =?utf-8?B?dEgyY0oreTBiTTBIK1hFQm5abFZoNWUzelRlYjRiY3pLN0J6a3JGeTRVc0hk?=
 =?utf-8?B?OXRtMHlFSnFwVXB5Z0sxWkpwWGJwb295cHF6OXBKSmNrd1F4QlhzYWZadS9H?=
 =?utf-8?B?aWEzei9JQ25DVUVpZnBVVVhYb0lHOTBza2lhUzg4Szg1VFpzUEtLV3J2a0FK?=
 =?utf-8?B?SGRGL3V0Z2RnWGUwNThuTmJpeHIxamp4eTdmNWZQUnRsUkFxaXhlTXIvRk1T?=
 =?utf-8?B?WGRqMlNVNUFpYWtEZGlrbEdmMXZLVUNOYnFGeXZhWGZWUm5YTHVja2g4TC9a?=
 =?utf-8?B?ekVCUFFBaFoyVk5ZeHl3SlB6Y1RSQm1kY2RlcGJRbE1SdElyRGdFQkFpYk9Q?=
 =?utf-8?B?NWhlV3FpbkswaVA3KytybS9kaWY0QTBUNjVxWXRlR01SaVpuVDBQVVZmUVpw?=
 =?utf-8?B?bkJ1SUQwOCtSNXRMOG5wa1RUMTBaQWZUSHdDRnUwSlRSdVgwcHZQeVJ1RXEv?=
 =?utf-8?B?aVFSOEgwanFVS09weVZITXdiYjVTaTRHbHN4MGQwcTFVUzREMkdYUCtNeUxr?=
 =?utf-8?B?YW0xeitiZVV5a05hZGNaMGNvT0lvMndSbWR5eU5oSXVMbm14M1RMbjVZaVZ5?=
 =?utf-8?B?TFFMd1JXcUt3VTBwYUNzS1JLN1pGaGV2dWlGK2s4a1pzSDhJOWRxT3lZQVF1?=
 =?utf-8?B?M0YxelREZC9QZDlNWGxFUjFEb0ZSUFREbmFxdFpXOTZGQ2FldEk0SHJncEFP?=
 =?utf-8?B?VnN6VUtYVTNRMEprT095OVlVNlkvTG9vVlF4akxRVStUallFWktaZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <10FEC8C5EE539A4EBAB0CB922820B5EC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e7f487-a14c-492e-8331-08da4abef902
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2022 08:55:30.7654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Un/GdBBajs3Hkg3odrxAhhsg0FnlXGEwfVgor9iN6mk0jVfdOG9fen43t+hpXVJVITpx9pV+VxU4FkNdk9Y11A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1790
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220610_015538_168033_1BE6FF81 
X-CRM114-Status: GOOD (  12.85  )
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

DQo+Pg0KPj4gYmxrdGVzdHMgKG1hc3RlcikgIyAuL2NoZWNrIG52bWUvMDM5DQo+PiBudm1lLzAz
OSAoQ3JlYXRlIGF1dGhlbnRpY2F0ZWQgY29ubmVjdGlvbnMpwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBbZmFpbGVkXQ0KPj4gwqDCoMKgwqDCoCBydW50aW1lwqAgMS40MDBzwqAg
Li4uwqAgMS43MDdzDQo+PiDCoMKgwqDCoMKgIC0tLSB0ZXN0cy9udm1lLzAzOS5vdXTCoMKgwqAg
MjAyMi0wNi0wOCAxODowOTowNi4yMzk5MzE1MjkgLTA3MDANCj4+IMKgwqDCoMKgwqAgKysrIC9t
bnQvZGF0YS9ibGt0ZXN0cy9yZXN1bHRzL25vZGV2L252bWUvMDM5Lm91dC5iYWTCoMKgwqAgMjAy
Mi0wNi0wOA0KPj4gMTg6MDk6NDAuNTk2NjYzNjkyIC0wNzAwDQo+PiDCoMKgwqDCoMKgIEBAIC0x
LDYgKzEsNyBAQA0KPj4gwqDCoMKgwqDCoMKgIFJ1bm5pbmcgbnZtZS8wMzkNCj4+IMKgwqDCoMKg
wqAgK3Rlc3RzL252bWUvcmM6IGxpbmUgMjY5OiBwcmludGY6IHdyaXRlIGVycm9yOiBJbnZhbGlk
IGFyZ3VtZW50DQo+PiDCoMKgwqDCoMKgwqAgVGVzdCB1bmF1dGhlbnRpY2F0ZWQgY29ubmVjdGlv
bg0KPj4gwqDCoMKgwqDCoCAtbm8gY29udHJvbGxlciBmb3VuZA0KPj4gwqDCoMKgwqDCoCArbm8g
Y29udHJvbGxlciBmb3VuZDogZmFpbGVkIHRvIHdyaXRlIHRvIG52bWUtZmFicmljcyBkZXZpY2UN
Cj4+IMKgwqDCoMKgwqDCoCBOUU46YmxrdGVzdHMtc3Vic3lzdGVtLTEgZGlzY29ubmVjdGVkIDAg
Y29udHJvbGxlcihzKQ0KPj4gwqDCoMKgwqDCoMKgIFRlc3QgYXV0aGVudGljYXRlZCBjb25uZWN0
aW9uDQo+PiDCoMKgwqDCoMKgIC4uLg0KPj4gwqDCoMKgwqDCoCAoUnVuICdkaWZmIC11IHRlc3Rz
L252bWUvMDM5Lm91dCA+IA0KPj4gL21udC9kYXRhL2Jsa3Rlc3RzL3Jlc3VsdHMvbm9kZXYvbnZt
ZS8wMzkub3V0LmJhZCcgdG8gc2VlIHRoZSBlbnRpcmUgDQo+IGRpZmYpDQo+IA0KPiBIbW0uIE5v
dCBzdXJlIHdoYXQgaGFzIGhhcHBlbmVkIGhlcmUsIGJ1dCBhbGwgYmxrdGVzdHMgd29ya2VkIG9u
IG15IA0KPiB0ZXN0YmVkLiBJJ2xsIGJlIHJlY2hlY2tpbmcgd2l0aCB0aGUgbGF0ZXN0IG52bWUt
Y2xpIGJ1aWxkLg0KPiANCj4gV2hpY2ggbnZtZS1jbGkgdmVyc2lvbiBkaWQgeW91IHVzZT8NCj4g
DQoNCn4gIyBudm1lIC0tdmVyc2lvbg0KbnZtZSB2ZXJzaW9uIDIuMCAoZ2l0IDIuMC05Ni1nMGIy
ODZiMSkNCmxpYm52bWUgdmVyc2lvbiAxLjAgKGdpdCAxLjAtNjItZ2FhY2FlZWEpDQp+ICMNCg0K
SSdtIEkgdXNpbmcgd3JvbmcgdmVyc2lvbiA/DQoNCkNhbiB3ZSBwbGVhc2UgYWRkIGNoZWNrIGlu
IHRoZSBibGt0ZXN0cyB0byBza2lwIHRoZSB0ZXN0DQppZiB3ZSBoYXZlIHdyb25nIHdyb25nIG52
bWUtY2xpIHZlcnNpb24gPyBpdCB3aWxsIGhlbHANCm90aGVycyB0byBub3QgbWlzZGlhZ25vc2Vk
IHRoZSBwcm9ibGVtLi4uDQoNCj4gQ2hlZXJzLA0KPiANCj4gSGFubmVzDQoNCi1jaw0KDQoNCg==

