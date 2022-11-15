Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 791A2C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 19:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A+4rIN55H7W/ab8ucGGsyjDq/DIuTp/bceJvhoFAdn0=; b=Db+5qnztzxO9q7Mnl2f6/M7tzv
	wZ9ivs8bHvk0cbKj3X5L3lmRwRbhuGgaxmK83NfoKGnCsaeNqfLzFfU3+bcuxogvaD3IdUoEmM1gt
	zQ7KHNHQF944btBpN7sv4Ie2inlw02zppHLLMZxg9CvLF6adG+D3C19DYByC9T1IBQaJQU7bT0NxL
	OmFovvAXmWZSlPu5lo5EVNKtORkmW4crrU+EjLPrWqmaGHfg0lwuvoRI0wp6LpHcNU9+vcJFRyxEG
	K8sNJjd0XoRlacV9JtpTaxUZngXZHacEIIW7KTmC5PITKFDlMqif+O9bZ/1aWckxBm2/cw5nVlhBt
	1nA2SU6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ov1jS-00EJiS-It; Tue, 15 Nov 2022 19:36:30 +0000
Received: from mail-dm6nam10on2062e.outbound.protection.outlook.com ([2a01:111:f400:7e88::62e] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ov1jM-00EJhW-LR
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 19:36:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/s4/9vUpMyp6UvoZu5035TJU4+iTm+5H73n1BX5rl2vU6Mnkr4KLGi4eKFt7ZnghV/soAbbdvlFkKwU4u9X8SNQk120mPhS79RVaxW9B8rHNoFbBOkULGn3zfKajadlY4/3lkWHNXv59YX+YHj1L7JSilATkAWZrjUh5h8V023Xdy1rjbDq7Xc5cPt4W2VIu6fvHFXkBxwcGORJ14e+J6B2sy8JwavMqLktHxJkoiNKjr8DLZVk013fj8lfP1ubhJnNP7zb+tcy2FZlywLHhF9px+flWG4ehl37Ssu1AXwAx5BzdxgqqdwKyYIFhcEb7iDOX6iyzRI4BUUagU9d0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+4rIN55H7W/ab8ucGGsyjDq/DIuTp/bceJvhoFAdn0=;
 b=X8I+jRK9KhrU2VHCWbgSa8fCHIFQwOEEUIP2acK2Exhbtwvc/hl9rSssotR+ZLugWI26P41VhdGA+dKhrYcoCyxaXKEQ/4GU1A3BTG/Es0A06zxK4fRkKrBUk0pTnszWQ1pgZupW0uX36yC89TlwzOeqJioV74FzzcYN+uc+DEQ42roCPwnrIKke6KGUOFcspg7kOqHdaG3cRqs2dvdeW2raHSIfVUSO0T1Bx22iqjvdEuDqCVqcTKd/gsecAZMFfC6N9pGgIDrFs/bEtPEts5aohXAJ3RrtOESKX2rpb5+8DXtyBiY5shZLZr25Ed34Y3ICl9REJVyowIM3nSYmCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+4rIN55H7W/ab8ucGGsyjDq/DIuTp/bceJvhoFAdn0=;
 b=dmAAtKqitY2xcL47n8JDQ50Zb6R2LvSzC+nmVcTE0I4WvZ8hMGgxTWyPmYHBl3EfJY6ZHYnlmHS3O0ZaEXQYzW+L4KJI8mVWTwnEcor29dct9jvbYWbhvqAFfuPbGF2xMcRex9DfzK5X9Boxk6BbBgVElgQ2BuIL/AetFRGXBUvUR7b+m9OzW+OG4UYuCVpnqX6nRaYC9V61y/iQJMWQL2Gg2wZ48vj01xxzOcde2kNCjnd24SOBTsWavhdOV8gsR0tAhKITae5ZA+r+7FYkFm677rQhjA0Ydrlee6qwccPeq1HejppZ4TwPIeKGichDqJeaGHHqZYIrlTWK9qD+sw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 19:36:21 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 19:36:21 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Alan Adamson <alan.adamson@oracle.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>
Subject: Re: blktests nvme/039 failure with kernel v6.1-rc5
Thread-Topic: blktests nvme/039 failure with kernel v6.1-rc5
Thread-Index: AQHY+Joo+0qmAtlReEOjnYEBNEp0Tq5AOFIAgAApjAA=
Date: Tue, 15 Nov 2022 19:36:21 +0000
Message-ID: <92a953f0-0d8c-90d5-1afa-27215fe31f4c@nvidia.com>
References: <20221115022958.ycu7i46vler2n6xc@shindev>
 <3F179083-A3B2-47C4-A1BC-5880237F1CE5@oracle.com>
In-Reply-To: <3F179083-A3B2-47C4-A1BC-5880237F1CE5@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CY5PR12MB6551:EE_
x-ms-office365-filtering-correlation-id: 0a47d222-8ee5-4760-dd55-08dac740ac75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  wrWDxnIiKyuaqT8WvxWCzIb0ACl96P1iEzf8WWRSuyK/BIb8D7EgeM3MiCod2yklU2y+yqrj8OgGD+l9QWjZDrPdwd0t2gxcsBvOe4DI8VVmwoCywglF1T6aQvih6rrTGsw7HfngU9y69ppxEhuGvKmkcPt+fy8PtKdsvDwrLh42MTyA0MEg/SWa/9eTtfgy575z3mmGiAXOIujnhPVXBjK3b7YdsFCmzwmm9Bi5azLENnXkFLtAJ3lZHcEHoXsy2JRsa/VlhHIxZCp4/bhwTkMjVLjz8fufdVd4II11vD+wBqqSCZHZeRd7nfAuFwyNPOaS9CerFJuRGaWG7jBczpq+lHQimYqsXQIaMeG+tv/Gh5xbB1PWc2x9Sncf0AP1dxQ5ykHpUUvdtVibfId2quBNrvdZuMPgoai3ZTP7roLZ2hMcjBiEqgAnQSoZ+e1nWVqdd10TXG6JaGxXRshAycO+IQNUyr+tbuwAz2UulpYz5r+1fQIC7tlQC4d1BoE7BHQlCDsRoWxYkW7xv3m0ZwPnii3CBh9HFWsfHMYep6N8K8dt01m+IxathpEt8ZfnrPkG8rG7tHaKp6/ApZ5uJCSRBfuiZP2zYaB+XCANIVr5LgKTQMxZkQpL98CN9LP0XtpWADFFNoDJ2Afz8dsV8Wyr9P2Fee03+T9bR9xVLgJ0cdj7P1YPOIjoGXMx/z1k6JtUJMAnMPzh7+g6+X1thB1xSfHvzNGVH+XUk+hHvPBAx0oBUFswLsIW3m/AwjF1IADmnQva95De6vX9ZTVoJLBVHP0WlVpwBG4AIg3ORQQaBNMKol0NqgjgNM5RaWAFn/mcin6GNzuN/+YrkJpNeQ==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(451199015)(36756003)(31686004)(86362001)(31696002)(2906002)(478600001)(122000001)(4744005)(8936002)(38100700002)(38070700005)(83380400001)(186003)(2616005)(54906003)(6916009)(316002)(91956017)(5660300002)(6486002)(64756008)(66446008)(76116006)(4326008)(41300700001)(8676002)(66946007)(66556008)(6506007)(6512007)(66476007)(71200400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?WWJ1M2NybGE0YS9XdFNWUFRIdHZCa0hkZEVpRFJ3aHJYTkIxQmtHY2RmVjZG?=
 =?utf-8?B?VW5QZEFmOVpqaUtEQU5YYndmS2hJTUpocWZqRlh1VHh5Ym5Xc09iK1ZYdVhp?=
 =?utf-8?B?NW5iWk5VaVZMTXdGdHF6am1oUEJPOWlZMkY3VXVBMVhqWUJISFhBcDUxRUFS?=
 =?utf-8?B?RlF0Mm9rNG53UCtUcTZCQ3FsVW96RDc5V1RxNEdhMEVQSEhjNFRIRFJrNDM3?=
 =?utf-8?B?bEd0VStjVVVLR3RUMGtRSk14alZFZkxpenRCOGNOaExqL2R1UC9MRy91NkdB?=
 =?utf-8?B?R2ozRWxuRW9ScHlnZk9BZzhpTjBCcG9aSi85azBSNm9LeHZiNzBML1lVQXdt?=
 =?utf-8?B?ZFhmMzE1bVVvTVBjSjFtUldOWEJub0pTUnc2S0dJWnliN1VWOFN4ZUVsaXlD?=
 =?utf-8?B?WUxYaGpxRTVjNnZtT01UTGFaZVRTS0REUWc3cmFUaGlqL0tZU3c1Z1M3UmRx?=
 =?utf-8?B?dHhKNm1TQW1oMDZKQklqY3hLQW9QOWJSWWcydkZRa2VnUDhPL2p4UWVVR0w5?=
 =?utf-8?B?NTMxWEhnU25lRm16elhGZnVQSU52eEpydHFubVN5OHdZbHQ5UVNmUHBjZitP?=
 =?utf-8?B?U0ZCVFFVSmt2RUR4RDJQdmRpakIxM2JBc29tSUUzdjV2SnFEQzJUcWFCeEV1?=
 =?utf-8?B?ZlFMN3M5cVpIdzQ5YytQMDRmVHlFTmQ5TjZHc2dLbCs0eFM5QVFyaVFaK25o?=
 =?utf-8?B?YTNCZjFyYmJBQXVWK0FoM1NKQ3J2a1NWWnFBS2w1bC9uMGQvdEFuVDRKQ0hO?=
 =?utf-8?B?ZWpyeHo4TUR2OEZSdnJ5VktNYUtPS1ErRXpWL2N1cWtFTEg4RDhwMUhFNWp0?=
 =?utf-8?B?N1hvSHVFY3Q4RnFBQ2xBRjl5M0NYVFptdFJ5MjB2cmdhdHF5L2J0ckpSbmMv?=
 =?utf-8?B?UkNaWkxyRGR2TmhxcU9hc1NraTgrWXYxbHBFS1Q5Uit2MTJPcUlhMitQTWZz?=
 =?utf-8?B?RTJMbjBlRkt5Z2w0RS83VmtLWVVvWGpUNzc1T0s1QmkwRUJnRmJyT3UvQ09R?=
 =?utf-8?B?M0tjLzFiZ0ErODcwN2c5b0VjTHFycnYvWjNybGwzRFhsT1B3TWI3RHBXYTNv?=
 =?utf-8?B?RzIvR1lwQS81VldIVStNTU1hUzdGUjlkNFhzNUFBRm5uNjZUckxtU1FGZmZM?=
 =?utf-8?B?ZDNVSXZocUF2RVVNTUovNjhCazROakJYTmVnY3dIZXk5ejdXTlh6bmM5VXJV?=
 =?utf-8?B?VkpBK3dWbktpazBoVEJ3emE3ZjRYcFdtTnBPZVYwcHU1aU1KelF0MWdoZUk4?=
 =?utf-8?B?U1pQMU1ONjRTVkc5RXFMbUpTWWZhL0lnN1l5eTkrMTBOZVJWRnpEandML0N2?=
 =?utf-8?B?L1UvSG5kcW5scGZkd2tJUm5YTUo4NXBnQmxiMlErTVNaNFlWUWVmTDdFa0Yx?=
 =?utf-8?B?ZWFyTkpuMkcvY3VHVWFveHVDY3lLQ1JCM2hHalVoNzdEKzVGQ1ZTNVp2VFpq?=
 =?utf-8?B?YVJCRDI3OWxVclQxQ3c4RWYwOVlkY3JIUko5Yk16aHlzUjhGb2EwR1ZYVUZw?=
 =?utf-8?B?Y29IakZ2RldxdjVzMUd3VnljNGNhenk0MG1jbGNnL2RWNURwdmMzNDhZSk01?=
 =?utf-8?B?TW54MWRTNC9ZeEt4RHRpN1lkcFZ3em9QY29RV1JlaXNhanBvV0Z4NURHbzdG?=
 =?utf-8?B?TUZXTGVMLzY5RnRNbW84THo4ckMzWktSMDBWMzNzanpDNWdDZ0E5ZGVZZnVL?=
 =?utf-8?B?UTFxaWJqS1ZGUXZ5UmY3alVLVloxd2c0Y29QSTFyTnZic0UyY1hpUW5pcEk2?=
 =?utf-8?B?NU5YZ1ZlejAyalZOYnlRRjJzSHpyTUJlUHZEaWZXajVvK3VVYWd0K1N0cndX?=
 =?utf-8?B?Ynh3V2pjb3lSWjFZeENOVmQrQTNIK2ZSc2FxajB0SUJNK2JkQ3czTVlWQjdO?=
 =?utf-8?B?L3ZrclZoN2Y4MjJoOEgwaVdZMG1NeWlvdUkrNVdrV0hzVU9aOFY2UDlubC81?=
 =?utf-8?B?ZEo5V1dxOFBPelFUSmlBdTZHNmh1NDZCeVJ6MitnUEU0WGY2SkU4Q2U0K1VZ?=
 =?utf-8?B?MzV6NDF5UkVQeUVXVmVJa0RSMzZ2KzdmejIvbFE5NXR1bkF4ZGJ6NW5VOEFt?=
 =?utf-8?B?bXpBang1aWNBU3ZoYU8vMGYyT3cyb1ZJbVFoRXYvZE0wKzNTY1pFU0h3dXQw?=
 =?utf-8?B?dE84Y2hic09JWlpWQ2ROWklHWC9TaGd1RXJjeGNKSkZtZXE0QU9XdDZNVXdI?=
 =?utf-8?Q?FV+HsJnqmUpjzOZFcu+oKYBGyOwkWLOX01bGHyg5OaKo?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF4FA8E199666A42A38B73EE99B33F8D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a47d222-8ee5-4760-dd55-08dac740ac75
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 19:36:21.1430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gy9wluHoB71SCdFNQj4tHrzeLu1pum38BODJ56FZ+VET9Ktt3iw86+86yZYiFsPdZPJeWpw5ml3IP3gy4Vebog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6551
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221115_113624_730666_E98537BB 
X-CRM114-Status: GOOD (  14.14  )
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

SSBjaGVja2VkIGNoYW5nZXMgaW4gcmM1IGFuZCBmb3VuZCB0aGF0IHRoZSBjb21taXQgZDdhYzhk
Y2E5MzhjICgibnZtZTogDQpxdWlldA0KPj4gdXNlciBwYXNzdGhyb3VnaCBjb21tYW5kIGVycm9y
cyIpIHRyaWdnZXJzIHRoZSBmYWlsdXJlLiBCeSByZXZlcnRpbmcgdGhlIGNvbW1pdCwNCj4+IHRo
ZSBmYWlsdXJlIGRpc2FwcGVhcmVkLiBJIGd1ZXNzIHRoZSB0ZXN0IGNhc2UgbmVlZHMgbW9kaWZp
Y2F0aW9uIHRvIG1hdGNoIHdpdGgNCj4+IHRoZSB0cmlnZ2VyIGNvbW1pdC4NCj4+DQo+PiBBbGFu
LCBLZWl0aCwgY291bGQgeW91IHRha2UgYSBsb29rIGluIHRoaXM/DQo+IA0KPiANCj4gVGhlIHBh
dGNoIHRoYXQgcXVpZXRzIGxvZ2dpbmcgZm9yIHBhc3N0aHJvdWdoIGNvbW1hbmRzIGNhdXNlZCB0
aGlzLiAgV2UganVzdCBuZWVkIHRvIHJlbW92ZSB0aGUgbGFzdCAzIG91dHB1dCBsaW5lcyBmcm9t
IDAzOS5vdXQgYW5kIHRoYXQgd2lsbCByZXNvbHZlIGl0IHVudGlsIHdlIGFkZCBhIGxvZ2dpbmcg
b3B0LWluIGZlYXR1cmUgZm9yIHVzZXJsYW5kL3Bhc3N0aHJvdWdoIGNvbW1hbmRzLg0KPiANCj4g
Q2FuIGNhbiBzdWJtaXQgYSBwYXRjaCB0byBjaGFuZ2UgMDM5Lm91dC4NCj4gDQoNCkl0IHdpbGwg
YmUgZ3JlYXQgaWYgd2UgY2FuIGZpeCB0aGlzIGFzIGVhcmx5IGFzIHdlIGNhbiBiZWZvcmUgd2Ug
c3RhcnQgDQpnZXR0aW5nIGZsb29kIG9mIHNpbWlsYXIgcmVwb3J0cyBvbiBsa21sLg0KDQotY2sN
Cg0K

