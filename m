Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C88CD12D5E
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2024 02:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FJvon9KZe59rjpC6svy5pT7YyDnVoziNde4HCHb5QHw=; b=q4X28XvaI2VpGdd8llOaitBfj3
	yEIxyd4sY4lnLVkkue06jo6gx5l/Q44CelgzCsOVcpDVZRy0pQGYVXxXUNhcFZVaYDdydCrtzgbkS
	kOEizRdHQKHB07AYmm1sWpg3HDH4ly2ulINKyZpdE/nBdL8zUquA2BUKQzU5f226gJjo9EneBcMSo
	NJVoZf420e6WLlO2zASJiFRS1vfLy3PVUdlh1oSBZOvxs/Sq1UJfodhrwXv/3w+Dt5xoMeU+AWmkO
	PQShGBPneU+GCj3eADnOlToZlNePIvatbBvwbG3N4UvTAfZA/XNE0oGjW433ngM+YNFEtUgqE3rhq
	7JwO78PQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAJlk-0000000G5Zg-0NBE;
	Mon, 11 Nov 2024 02:03:08 +0000
Received: from mail-dm6nam12on20604.outbound.protection.outlook.com ([2a01:111:f403:2417::604] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAJg1-0000000G57A-2XM7
	for linux-nvme@lists.infradead.org;
	Mon, 11 Nov 2024 01:57:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OWjY58glhiVUhqeBow1pCWQvLESrIkA1+Ilt+GNgi2G7iLLSFjynr588UOVnPv0wN+990As+RB4GBHDZZEr0YvALIDbI5dXWA16KH+TBUBa6JTdmoCNkNw/F/0aKYFfRdTzgIWQEVIh++Xg5oj8G9JXpHRVWNNb3uxykQfZmyxFca12qSoS6lneC7TvWCYyI6008jpQjJ17Rgf8Tn/xGOyeReDOgvZ8BAmUVtPES2Mp9qbqrMS36yaifUQXjYoAOiBhloSBQ0XV3Z7/x3xw/MU9A7T4L480tDclyEAbxhVbErpGq+wWLWgljXrcLg97jQZzY9bYBfyTWGQxMPrFOLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJvon9KZe59rjpC6svy5pT7YyDnVoziNde4HCHb5QHw=;
 b=qUd3X7kHAnKZiCD1UJX+s6afq0iGApc2aY5U3kKGx6So2TOVrswSoAavem4fB74XhJ5DgUv7ktmj0lqmshXqJvdSldoYpdEAIuF6wfA8Py5UXVinP3Cqzcp3/cxdjXp3pTUGmla2YKiGWkZupObebFC4KAdbgAwqhg+uQne3+UystWC2L1Mv2gh2IMWnohPEQvg69fWo+ZH7TQ32roHZVoDhEO7L8nRfsmQHaNX4mvUGO2EfeZPfWNGlXXA5I1nL5f77AwQD42E9r7+TxFIcmt+hfuuL+INEKgPhWumPt0iaah37tGeiAfXI6No5ZT4BS8Up/2WylOhZeeM2hUo2dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJvon9KZe59rjpC6svy5pT7YyDnVoziNde4HCHb5QHw=;
 b=uWRQKQvAG7Aoxchq/3QgZJWWWjWUuH3d8J3KjcQnI45bvzwsOff7HrT3n4jY1Yxi2jffALohEAv8XzFBIDVAgonP4Fbs6X8wokJybyLlkTNljSBV47zXTDmO8xjpvtP+zfbZzRMr5wtRS5GbXEg6OiWfzAI8rFjZ6a9hq0BYkzX2ATZjbxTA0g3JNJEi9MZohRFbGtrOlUvA4AMZ/cVglKiR8nQVauPALNGBr1QGOLKk+3e1cuFOYtconiTAsAYxSOe8RmPnQzhG8c/xD6bzByiAhABgJRomvVHTjPAxKMr8hNX5wsLQEwdpByZwJw1CNdEFxifG6ZneJw+p+iV6Lg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH7PR12MB5595.namprd12.prod.outlook.com (2603:10b6:510:135::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.25; Mon, 11 Nov
 2024 01:57:03 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8137.021; Mon, 11 Nov 2024
 01:57:03 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "m@bjorling.me" <m@bjorling.me>,
	"matias.bjorling@wdc.com" <matias.bjorling@wdc.com>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, "kanie@linux.alibaba.com" <kanie@linux.alibaba.com>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv4 03/13] nvmet: implement supported log pages
Thread-Topic: [PATCHv4 03/13] nvmet: implement supported log pages
Thread-Index: AQHbMUzJuqXsvclLsEWAS3LZ9ZfYL7KxV2eA
Date: Mon, 11 Nov 2024 01:57:03 +0000
Message-ID: <f803715a-6a21-4972-b0e8-ebc709bc2caa@nvidia.com>
References: <20241107193849.995554-1-kbusch@meta.com>
 <20241107193849.995554-4-kbusch@meta.com>
In-Reply-To: <20241107193849.995554-4-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH7PR12MB5595:EE_
x-ms-office365-filtering-correlation-id: 7ff0a8f7-808f-4041-0f9f-08dd01f42363
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bHFRdDlhV0UxMFd4SUxyUGNzQllLZGJWQ2prQS9jeGZNMkxKMnF5Z0d6eWFk?=
 =?utf-8?B?UExFQzJrdVZrSTVydVljVm4rdWFNUEtMdTFFVmhmZjdSRFk0L2N5S2puaC8x?=
 =?utf-8?B?Y001ckwraWk4QisrMjhlQzJtdmovb3JKQ3dFWmdleFBCZmdMcWJkWkNHeEZX?=
 =?utf-8?B?dEFRa2lsdm1xWGhwcWVTakd0QldJQzRtVlBLdXRVayt5Zld1WUJKL1NjMHls?=
 =?utf-8?B?UmRMV2NiVmVFUGw0R2RiZmM1S25tN0IxTzRxSno3c2hjNmk3bmlsek1uMlJ3?=
 =?utf-8?B?R3cwTFlWQlVwUGo3T0hibUVSSU96V3J5U3l2TUdqa2JaTlZyeUhIbk1tQkY2?=
 =?utf-8?B?T1dKbGxqczJzQW8vVGtzczhOUGhrTTAwV3IzSjZkTnhQNnFpUUM2eHQ3TDIx?=
 =?utf-8?B?WEtBTytVc0w5Q3doRWFRTnpIdXExdUZwN2l4b3B1eWdtamxseHYwdlFPUUsy?=
 =?utf-8?B?cHJqZy9UVSsvYnVhNzBFY0pjZkI0bmhKNWp4a3p2elprMjVCajdERHErWUJl?=
 =?utf-8?B?dnB1WUlTRkJZblRoMWpGTnQrdFFvNXZOUUJnSlJETGNkNU4wQ25VZlpJekJD?=
 =?utf-8?B?OGliRU9DQ0NLKy9LZkdKYVNQNktUcFNOc01reXN3YTl0UWdGNXhUc2hDRlJt?=
 =?utf-8?B?eWJVam9vcmZ6c25udnpaM1U2cVEvNUpFTytDSDd5Znk0VEoydTVpVjRSWnlM?=
 =?utf-8?B?emRvMVJPbks5L2lOOTNJQ1Z5TGI2VHBtL2pjS1BCNXZDYjd3UVdEL0h1TURZ?=
 =?utf-8?B?QXUyZDdEWHY1cGYrQkx1ckNmVExZWjhMbnNmbDJGUHFvYWNJbk5CUG5Ob1BO?=
 =?utf-8?B?ZWFWV0JVbjdjcS8zdjdIckV1cWdYNnFJWFBvR1dqNXJYY1habENyUEJIb3Uw?=
 =?utf-8?B?eGIwa0c4cTVoYU5UeG0zZUtKQ2FPcTNmK2xxdzBLZlFqTjdOcW9nOW5vbkty?=
 =?utf-8?B?UDNESzZOMXdOM2FwNEZQd0JOZS9XSEY1Y296NFdkNlFpWDdHNHFBeitXeUpZ?=
 =?utf-8?B?eFE0bHNTU2l3M3JpTFNvdXczYk5mNTZ1U1E2ejNjWTVsSkJobnNJOWVjbkxq?=
 =?utf-8?B?anVQdnBNZXRYeURPYWMrSkNudU85V2ZvVFB0aVd1bjhLa1kzY3hlWUZsd0Rt?=
 =?utf-8?B?c0Z0UWJtRXNOT0hPQjYzeXlsdDJQenFhWmZDVG1VdFlQQkFvVDc2V2ZEd0Nj?=
 =?utf-8?B?alRhWWpvRlI2N09KTnFRWTdHL282WTA5YnZYTEM4dW10KzJzbE1Lb01kdFlM?=
 =?utf-8?B?R2RtcE41V1NSNlgzZ0FtcXp1LzVpeExCYUlvakZITkVUSEhwd29ZWjk1MjNa?=
 =?utf-8?B?OXhERXExNTZvVE1EUUF3TFh2Sy9Oc1Z3QlZJUkY4SnN5QjQwYkdKS1REVXhL?=
 =?utf-8?B?NGpjQlZUR2pEMVF4OTFXMjgweXJpUTRMMEc2YWxpbytMS2JoRGtPQjZBc2s3?=
 =?utf-8?B?T01YclB3bFV1REs0V2RhZGp0WUNDdEFKVDVPVndXczRWYlEzQk9ESzNCRHVU?=
 =?utf-8?B?ckMrVGw5TGRLZExMNXMxNWFCYzRrRk1FUGh3ZS93Q0c1S3VpaVREcU1TWlM2?=
 =?utf-8?B?WWtUME5VTklUSk9OKys3SEFWZmlTbThlM0dlMFh5RFV5dDlibHRhL0J2Ni82?=
 =?utf-8?B?MFg1cFFSV2dJMDVSRHE4Q2FicGtsZGJoSTRma0NtNUVqeFJ2MU1sYjZXSDZ5?=
 =?utf-8?B?K255ZFdJSjZXL3Q5R1ByeXhrNVBSb3JHcDBYMkFzQ2JjVGlLbTdRUTVpSUtq?=
 =?utf-8?B?U2Vxd1VyemNiSUFmRjZidWRlbHVrUU0wWHY3NDV4ZCtFRUg2M3hldEhpTUR4?=
 =?utf-8?Q?hMUxWTqyvmy97vzOMV7mRNwedzRYZG3KTx2OQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3Q2Y3c3SDViN2l2Vm1MVTV0am02NXI1NHNLcTFBWnlQcHRieDNwSjd0V3dY?=
 =?utf-8?B?Tld0ZnRIaHV5aGE5T2RxTEVURWxKVWVWSXVQa0RCVEFFMEZmWFhaci9FelR4?=
 =?utf-8?B?UVMyWFlEVVBJYmV4N0pRRnJyU0lHTEo4K1d2N3B4UkZocFovb0dacXBvd1FM?=
 =?utf-8?B?cEFTVC9ISGMyamtpZ1hLaHVYa29rUGQrSlNUT2xuWXdQL1NSUVZqYlZjam5K?=
 =?utf-8?B?bkRQbGZyMm1QU3J3aHpjMmQ5bTBWcEhKZGlFNkJVbVp6OTRBa2Njb1FNQUxP?=
 =?utf-8?B?bDBycnJLV2dHTzZLdEVPN0lXUUY5QmhiUkVqRmRIT0E4N0tiSGRvTXBhbHM5?=
 =?utf-8?B?ZFFFSDBGZGQyRlRVSVVqQm4xbGljR09jUEpDdFVWa2hkV1hjMGIzTFQ4VlRn?=
 =?utf-8?B?bU5USHo1bkdFOFUvR2RyL2RoSVY0cWJOUWlFc25VUjAwaHhIU0JMa0xNT0ln?=
 =?utf-8?B?em1jWUxNTC9TM25LV0YrSk5Ga2JsSTU2ZTQ3dkl0N2ZKdWZCUlZSNDRIWVVK?=
 =?utf-8?B?Y3FXK0ErUnBlQWNueW5OY216UTNHc0ZrdjZpOVM0Um01WUxhYTRZM0VNWTUz?=
 =?utf-8?B?WTRHZ2pzbXFBcFRFVHAxeEg0cXVPYzNpL1o3UGlyVnhiWitCZWZ6czVTbS9L?=
 =?utf-8?B?UjNPRU9JOWQvZUNFMlB1dWp3MTRadWttRHhZY3ZoYVJjTFd6cE9rS3JDRW5m?=
 =?utf-8?B?RllheVBWNWdDcDE5VGJPYUNUNkNmM3FVY3g5ZklReFRObWFUdGZSOEFqL3FY?=
 =?utf-8?B?NDlDV3JlVitnRm9SZWdxSER0OSt0dEQvUkVjWXhEeFQvOW9IMm9UNXV0UEJB?=
 =?utf-8?B?bDZRVjR3NXhjQ05DVEJ1TDhEOU5OZDJnZ2J1aWV2NVRuQ1NNenNYcm04aWw3?=
 =?utf-8?B?YkZhUzhKRk5DRDBCays5QjkvbGF6Q3BvQkFhaytPTnJwMFF1cm1mTUJCVUh5?=
 =?utf-8?B?R3pJdjhWZWtXckhMQnd2aGJjbi9xZXI2bzcwaUNTNzhTNmRicUhWL1pEVUlk?=
 =?utf-8?B?b3BYclZNK29MRlB3a3AvU1duNkliRzB2UW5PUkFndzF2OUhqLzE3TGhROExD?=
 =?utf-8?B?T1lPR25hUktyTjIwV3hqeW11T2JnQ1lramFwTzFOWGxxWmlBSVExUmIrOTlW?=
 =?utf-8?B?d2l3dmlsM21ITHB3cEhkeVUza0VQV2g4SFhlZXpYQWlhVTZzVVFCRy82d3JO?=
 =?utf-8?B?U3V0c01HRFhWSTZ4cWlBTWttajh3cGgzSDBweE93VHM1ejdsN3NwdDVKSDdM?=
 =?utf-8?B?Qm5UYXEvM1FFK3RuQm9nZVJ2MDNTYkQ2QVFlVTRwTTFmWlFSSG9rL29uUkxk?=
 =?utf-8?B?bUs3bng2bkhlNzllck5qSDZEbnBBb01DS3RsYkhDT0lWWkRMdnh5MDRGYlYy?=
 =?utf-8?B?NzFOYjMzbFl6L0llclo0c3JXL1pZOU5wTm1HTVpRWTdMSFhRREJyZDZtRDF6?=
 =?utf-8?B?N3NTK29KeUtmbXhCWVZraUVQR3ZacmlKeDNrdmZUbjRDdjBpazYvMUg0eUJu?=
 =?utf-8?B?b0lZMG5tTXNlYTRwWktDMkE5WGRkbzdoMmNUT1dZZnZDZkhRNUFROGI1WlM4?=
 =?utf-8?B?cE5qTXFzQmpvQUN1bVVEUEt4cTJMeWlvUHJ1QUNVZytTa3lRSmVPZTJza20v?=
 =?utf-8?B?enNxWThObTBhZnNWZHBZcGFVdG5PemwxTEFrUXlNYWFjRmFneU1wNFhTeXhw?=
 =?utf-8?B?L2IwZ1ZZdFFsalVReWlLYllYeS8zajlrcW9SeUFGR093Y3c5b0U0bnQrWW9V?=
 =?utf-8?B?SUVZbFJjZU44U2ltUXNEb1ZNUVQ0WTlFb0hlVHVOZElyWmVYNUNXZDdTblZs?=
 =?utf-8?B?UUtBMndXVzQyMFhPaDhURW5qWW5jR1pSQVV4Qlgya0VvcHptQk9ady96SXhD?=
 =?utf-8?B?U2NRM0FmN3RYbk1YaDdKaDFTVFoyVTRXamE3UlYwd3NlaU9RamRxbTYxZjRV?=
 =?utf-8?B?Rmd4M2JBeEU3aUF3dmhsaWNub2VqSVpsKzAvL3oxTlVWTVdIeWlCQTQzNzF2?=
 =?utf-8?B?eXM2ZzBORFVNazN4a2YvOUlvYjBiNHhVN3dRRmNMUkN1SFJURGxBK2NqUGx2?=
 =?utf-8?B?N1FkM3UzREkvaFdKaTBRQ0hOUkFmUXh4aGhPT2k0YmxnNlppRU5oR0Y3bWkv?=
 =?utf-8?B?VWc0WUx4NVlFMjl3aDBMbHZISStxVldVWTRoUUI2blpoaFJsKzRGeG8yZHN1?=
 =?utf-8?Q?yLzpUuTXSC3zP+ic37VOT/ZPR5cBke3TKAD40TMViiYv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE212656D67F154C8CA813994330B51F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff0a8f7-808f-4041-0f9f-08dd01f42363
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 01:57:03.3793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: csYAaX6yPnlQQYFXVJDCAn9fU3HWyPNS6jq3rhXjckPyKAvErq8xSGk/O7XKenLOsxxI7UzpH5zMVhgzt+8cYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5595
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241110_175713_689454_DD6459B8 
X-CRM114-Status: UNSURE (   6.68  )
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

T24gMTEvNy8yNCAxMTozOCwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEZyb206IEtlaXRoIEJ1c2No
PGtidXNjaEBrZXJuZWwub3JnPg0KPiANCj4gVGhpcyBsb2cgaXMgcmVxdWlyZWQgZm9yIG52bWUg
Mi4xLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS2VpdGggQnVzY2g8a2J1c2NoQGtlcm5lbC5vcmc+
DQoNCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2No
QG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

