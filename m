Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B5DC54EBD
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Jan 2023 07:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L6G5VwwA4pvwblJIKhRcXLHyX+xfgKs2Iiz+BiPNVic=; b=FGELBzmvEG/9MDResPbwWA1kFW
	Quzwm8yFZwAWhcecr2PKiiMMI8G6X4fl3tnZ0zXwc/7WAhlspXdaklf1PQbODi5zp171KFXx4FsX5
	N9Jff76OvYrCLHmBWGpgqGvUyOaoZpwUbLXO2RPgcUZIhvjl7S5dPX9d0Nr4hXd/OkHrcprv2kYmW
	I4XwBWeAC0+3Q/6Wepr/v0VaKki4DARybiUtoW4+8Tru+8I5GjmmcClRyEtdc4pF0uHSe2DtseZSE
	HN59gqENFTh0Ch+Y7MHpVYJzaRUx+mH5HB8d504/qK4Ey9BrNBEMd7N5iv7j+00Ytn4z28ppYx271
	yyAcV54w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEmm4-000EoF-VL; Mon, 09 Jan 2023 07:40:53 +0000
Received: from mail-mw2nam12on2060.outbound.protection.outlook.com ([40.107.244.60] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEmm2-000Elo-58
	for linux-nvme@lists.infradead.org; Mon, 09 Jan 2023 07:40:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdFz92pVlZPXYZwWnIb277wThlDguoUQ1KeA55BGMT6HWEcL2Y7rs5acfChuEqF8LZn3Yf1CizPFbBPU/6Sw6dX7/bsyz8WL1ZAmcTpDuJhsqdGYhHue3X41yQIwE4uFBFMGd9aR0Aevmp4oLcHIrTkHM7l5Za8CIxspnEGFcgrS5Z2uQGdHC0yfi3/YgUiglqeLNFAYVJWr5ufaD6guk7EOHzUSgnXppw+LNBWHHEMo02UpbxVtfeVm75iXAfdNtPIaKnYKmxrGEbxOMfVdhDi7yG58KdNce88rDCqLY+EP5LnzTwtuUfURqBqURqv6E6PSU7mu8NNx87qUdMB6ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6G5VwwA4pvwblJIKhRcXLHyX+xfgKs2Iiz+BiPNVic=;
 b=SPqRrmA6O4S2v3IoMBBYCxtRSqGXY/Hl2VNeyI1s4jN35igD4B510MY2jZhMcElyB29uLfCpay7Q5u/c9gNBOT4+HKAg7yt5XRzgHsQeb4o9QTnnj2pumU06F03jSQ5Cc4fQ0hFuRZFMLP/mJI6FqnpHE7KpN71LhdkMAiHQWV113FkUv/x9ZefTNSmnK6bDCq9djdokHjrGLEs8djGk84mGFGH16yDIduVv2wLVt4oUtx+wTQGpCqLRuNsOVicobhaov/mlvU404xGmN3mMH3KFLrZpDYsy/b/pV2QicJpGobUU1oupquCXGYA7q8CJrGyA0T9pZZSSzycJFyuWgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6G5VwwA4pvwblJIKhRcXLHyX+xfgKs2Iiz+BiPNVic=;
 b=MJROeIydx9KuCUFvYCUFUZkXYfvyIejFjjZOmdX1uVNRZqDPnmCkoOILlryQz2tBij35KZf2EWSusJGaWHgxcYuLt3CEJ35+ipreQmVbVNWAqVxyV0NSWJ9h8cH44rEagIe3+FW9MZkrdSJLWDza550lIa6NH3IOZq+MJq70VUuIKL0X5ZB80iWI899lyNDtWQaPKWWgpN4aftqqv4XQyAER8AWzYZBw0vcjLh8gncKkqgHNfsM1w2/TPyMsSIAZm0IyHLyD/2wzz0vO7ppl9oBBYSsREO4FJRESyjpZIYz7MIpcIVLJZnqr6bQOTB6VKArQ5CVji7IhftlBoAN3vg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SN7PR12MB7250.namprd12.prod.outlook.com (2603:10b6:806:2aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 07:40:46 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7%2]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 07:40:45 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: Kanchan Joshi <joshi.k@samsung.com>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, Keith Busch <kbusch@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Sagi
 Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 3/3] nvme: don't allow unprivileged passthrough on
 partitions
Thread-Topic: [PATCH 3/3] nvme: don't allow unprivileged passthrough on
 partitions
Thread-Index: AQHZI4FaMBM5U2oSlEWgis3ND0Ilu66Uu6KAgAD4uIA=
Date: Mon, 9 Jan 2023 07:40:45 +0000
Message-ID: <0df55847-32fc-b8f2-b820-8fd55cd51dd2@nvidia.com>
References: <20230108165033.380842-1-hch@lst.de>
 <20230108165033.380842-4-hch@lst.de>
In-Reply-To: <20230108165033.380842-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SN7PR12MB7250:EE_
x-ms-office365-filtering-correlation-id: 88279088-eaf6-46de-0862-08daf214d1c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  JpZUbgjg3uoA9x8xdcif9ZRq6OxlmGmTsBsJlIEECZysxD3O8J1S8R1uAt/aNH88PGB5prH3GpF8Y153xrNl7tqMyLWUYLbV3XLaEy9x5XXgwM1mTX6CKIx6ie3281u45JoQYkqNMn/c72dwhI8VkzGFxNW8owXePgORM48rUfrmjIGPO8FgCCRyGoRWtrOpW1DkPk6m5hBa4JxvciH+t55lu2KeyEUzpcnKc//GOQUI8w28xfPX2HMn4Pz6UPm1xGaXA3PmR+R7tMsWB7MzN9eoenVO4lH4ASiQocoXlXAK+PtfB9aB8j1aQl7GJex4/xGPmCRtmjN8pPWeJbtSNJf7bBjaJ85jPYtao0KI4FhzgMwXihe502L2BS2/4DxlUM00JhVQBv5VxqE2GhcP8twFL32taUx++IBDndgeEnjKlQTaEQr2JeZlqpw9s79f537iAUpIFIy1DCB/4BKAwkPv+ZKVgknBoYZiBW9dyMLngiD6oy87tiI0n7KlzlJr5gudYRqvBnCtPMbNc4uzzmHejJHqEc/LkE+GjBgdC0jFXYo70Da9AjRLJQiEdfMsYcryGNN4Dtrb+taVTI/gr3ZePiopXijX/Sogy2o9VoBW++b2OZd4nQ1oxwM/poWGAIh3uoU9Weh25LSMnra4iYDH0wN8wqNOOEIX4A/SfkYYK8GMg7MrnStKyOSLlvpuXpj1702f5FLTQrc0cBMQrWdWIfpTdNklo4mPfGzAI0Du0Ag/l/gGXIJAqUaVPI9uNzzrkrmPt363wrOWODdZgg==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(451199015)(6506007)(38100700002)(122000001)(53546011)(31686004)(2906002)(6486002)(478600001)(2616005)(4744005)(186003)(6512007)(5660300002)(316002)(71200400001)(83380400001)(8936002)(36756003)(38070700005)(86362001)(31696002)(41300700001)(76116006)(66476007)(8676002)(91956017)(66946007)(64756008)(4326008)(6916009)(66556008)(54906003)(66446008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?alcvb201bCtMcWdPM3hrVEl0SjFVbUZWbGhxeXZLUmd5SkovODJuZUpyWUtI?=
 =?utf-8?B?L3JTOVZ0VWZ3allHVVoxd1RWa3AzRjVvenBIdEZ6bmNnSkRDNGZDSjJQdW9a?=
 =?utf-8?B?bDdvUHBpM1dSdmd0enNnaFU0bCtNTFhPc21GemltcFdJOXVreDVMMVIrQ3J4?=
 =?utf-8?B?d083VW93WWNzaE5RMTNiSmxNL2Z5M09zT0JkQmFDak5oZ3l2aGU1b2p3SExs?=
 =?utf-8?B?aHZ6VnluVTNNQkRpYTkwbjZyVDdySGJ0MTM2OTR3V3JtYWt3eG02TThoNHF4?=
 =?utf-8?B?d2t6Wkw3RXJRQ08zZGpiQnhwcHdVUXFFbkVGcnZnUTM3VFhKUTVnOXd6emhr?=
 =?utf-8?B?Y2kwenJDbkIyMFV0bVRSN3NUWngzY3MwUktTNmFLT3hiY0I4R1FpQ01Nb0Vk?=
 =?utf-8?B?dDh3a0RBWFhBdUFDeEFBcHBVb0VsOGJoUGh2NEYwN3lRYVZNMFdtKzJVaUlv?=
 =?utf-8?B?NHEzZHE1NHRRZmhjVkh3eUN5R2E1UnAvemlnTStzVkVjdG9JZUhSdC9KU0w3?=
 =?utf-8?B?WmFWcHNuc1pWb1gwUFZUOVpNUTdKNE5VTnNpSkM5T1BpWldybVk5OUNWRE85?=
 =?utf-8?B?dnlzNTJLMjZmUTl4TEtRNG1VNkNHc2lTNzNXZDBNY3h6MEZOeW1UUk83eTdv?=
 =?utf-8?B?UVdWRmhHSys0SmxRUTNzSDlQTGprNjI3bXZBano5Y3lnTmluNnB4TWJPL0hP?=
 =?utf-8?B?cnZhOTVENzRKclF5aGdSTUxldnd2b1ZUa3dneHJ5bzNicHFQTXRXTnpKRUpE?=
 =?utf-8?B?MEk0eVJScFVHNlV6QkJWbHluRzN6VGJyaG92SElLZWNnNmhVZkRnc2xMM2hC?=
 =?utf-8?B?TkozNTZRcHBua3lDOG43TnBRcTErOUI4YjNhQjB4eDRaQjF4QmhneGRFc0oy?=
 =?utf-8?B?aDQ5MHh1YksxMEtMb1NIYzRzaXQ5UlhUMWo1K0VSV3VVNkJ5V2FpMnBWZ0FV?=
 =?utf-8?B?OWErWTZBRFpDR3dqSnhLWkV5b0ZmSjhYUHNFblhlcGlabnQrZVF2SzA0cHhG?=
 =?utf-8?B?Ym5BQTQvWEdTWVZSa1J1RlZHa3FxRm5yUmZWSVBmZWVWQm9EVG9BaS9NL0Vj?=
 =?utf-8?B?aG5xZXRaTS9yOEhKeGZxa242NC9NdVI0WkhoeVFWOFhJbDhTUHp3UTZqdUJB?=
 =?utf-8?B?OHdJS0ZMT1RPUysvVjJjYXBsMGs1UU5EbHNIbnRsUkFUdHNqTzB6bGJucWc0?=
 =?utf-8?B?KzA5Mjh6aEpyc1NDRVRJWmxoMkE5UC9WdG40cHFvaGtGUkdpNS9yTGVCOG0z?=
 =?utf-8?B?WTNYN3c3ZE9aUWExZnl0eUdkbDVXRjYwcDNkeWNLcyt2b21iWjF6a002dExG?=
 =?utf-8?B?T3ZjSEVpSUowVEV4RU1QWjYyOUxNZWM3YktlZnBwVk9KMmNLV3FYcU00cVNP?=
 =?utf-8?B?M2Rsa0EzOTlmN0xvK0w0eDBVVUVSOWJYUXNKVjRuQVhyL2FzK1EvTlRtQ3Z3?=
 =?utf-8?B?UDZneHlGOHd1S2RxM2F6Nk42azhaSjFjUDZNYU1qRkZ1N0hTeGgrOWNqNlM5?=
 =?utf-8?B?bGxyRTQ4aUQ3eDhhRUlIR21hWEh6c3prQTVaTmtpV0wzbmloOE8rYTlXVHdx?=
 =?utf-8?B?bmhsMGpYQ2VpM0duRzBYa28xd1ltUkJzeHdoZEpiNXJnSVdZNDdzZG5kanVB?=
 =?utf-8?B?QXA0NVBlN29ZR1NtVnJ3cTdremM2NVdpRi9kWEVraXJWaTdFajlIVDdkTkE1?=
 =?utf-8?B?OWN0SHBoL2twM0dxUTZNMGw4UlFGMmN2LzdDUUcyUlh0RFltT003ZDV2MUcz?=
 =?utf-8?B?YVozanYwdWtOUlM2RUdMN05ZVDJoNSt3RW15UjEvWmRBUXJMMXZSR3M4d1Vy?=
 =?utf-8?B?Q0FHL1h0V1k3N1VoeER1Tmoyd2tCdXhqTHJSMnl2cmtreFdXWnFkdFRDUGZS?=
 =?utf-8?B?WlF5cUdVVkZaWWNjV0pheml2Y2c4ZUpRKytWaW5sRUlvSmxWWFpUOGVpenFV?=
 =?utf-8?B?VGhoclVIV1lWdDkxa3FXVGd0RXdVNWtGRHUwYUNQM0hPcnZNaVNYLzFzckFY?=
 =?utf-8?B?WHRFejErNS9pL3Q1QTIvTHM3QnBvVUh2NE1rSXdWK1IwS2NzZXhic1ltbVp5?=
 =?utf-8?B?bXRQU0trcWdSOXhNdU1nNkJWeG42SFVLcUFOcWoxeDFVV0hPRHpMeHZzQS9m?=
 =?utf-8?B?MXcvdU11RWswNkFRY1l4MTA4UkpTdWJtWnEvelZXcmdjUXMvbEtkMWRKa2d0?=
 =?utf-8?B?S1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF2D4011871AD54181FE634A9235F7A5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88279088-eaf6-46de-0862-08daf214d1c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 07:40:45.8365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B6fg/fp94CQVW2rZ6EkeSUR1/GiiDIwtAA4SOTvHBT7r29IaSBfh6p5h4Cx86YjpF3IPSY+X1kc9tJBYwMHoXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7250
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230108_234050_216335_8CA04207 
X-CRM114-Status: GOOD (  16.32  )
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

T24gMS84LzIzIDA4OjUwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gUGFzc3Rocm91Z2gg
Y29tbWFuZHMgY2FuIGFsd2F5cyBhY2Nlc3MgdGhlIGVudGlyZSBkZXZpY2UsIGFuZCB0aHVzDQo+
IHN1Ym1pdHRpbmcgdGhlbSBvbiBwYXJ0aXRpb25zIGlzIGFuIHByaXZlbGVnZSBlc2NhbGF0aW9u
Lg0KPiANCj4gSW4gaGluZHNpZ2h0IHdlIHNob3VsZCBoYXZlIG5ldmVyIGFsbG93ZWQgYW55IHBh
c3N0aHJvdWdoIGNvbW1hbmRzIG9uDQo+IHBhcnRpdGlvbnMsIGJ1dCBpdCdzIHByb2JhYmx5IHRv
byBsYXRlIHRvIGNoYW5nZSB0aGF0IGRlY2lzaW9uIG5vdy4NCj4gDQo+IEZpeGVzOiBlNGZiY2Yz
MmM4NjAgKCJudm1lOiBpZGVudGlmeS1uYW1lc3BhY2Ugd2l0aG91dCBDQVBfU1lTX0FETUlOIikN
Cj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IC0tLQ0K
PiAgIGRyaXZlcnMvbnZtZS9ob3N0L2lvY3RsLmMgfCA0NyArKysrKysrKysrKysrKysrKysrKysr
KysrKy0tLS0tLS0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygrKSwg
MTYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvaW9j
dGwuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2lvY3RsLmMNCj4gaW5kZXggOTk5ZWJjMWI3MDAwNTYu
LjA2ZjUyZGIzNGJlOWJkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9pb2N0bC5j
DQo+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2lvY3RsLmMNCj4gQEAgLTEwLDE2ICsxMCwyNCBA
QA0KPiAgIA0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5p
IDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K

