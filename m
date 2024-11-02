Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D1FE67819
	for <linux-nvme@archiver.kernel.org>; Sat,  2 Nov 2024 23:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5H5kzTw9p7zyes/vpyIHbxrZkadlPPh5qaF46OExUSc=; b=0jH1TT4acAoz2eElgQjm39HghS
	UIATARegbOyURVJVfJE0WdXIX9plkhRYfd3Nfay4gYgmwpJCHfFxje2yfqHAtbPYy3LZH2jKV8NEN
	0vVS9gvr1pYQCzY5QJ1OeDH2ZO8VkMXkBBmfIHLrVLZcnr4vh0JWQTshy+6iKinl24vByNklPnbIV
	EQKTS7FlUqkQXMZHhK8IK4uhEldAV6gyhMhi2S8KMq0VC3k03mgxfqRLKRWrovchZjt94RJV6+16/
	8RtPsVW45hMdOMZpHPfnpQ4t34CdryC8a3lcsn1T3rxJPIsXruR3dySxQELDBVKUrbrgsWJ3Gw5ya
	aFN0eOrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7Ntk-0000000AdES-2PXv;
	Sat, 02 Nov 2024 23:51:16 +0000
Received: from mail-co1nam11on20612.outbound.protection.outlook.com ([2a01:111:f403:2416::612] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7Ntd-0000000AdDG-0BFX
	for linux-nvme@lists.infradead.org;
	Sat, 02 Nov 2024 23:51:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XobXqprD1ao4P19nNBVXf7pLXDXtGaCEOcYbxZ7tyb8Yp1tBOt9UJK9jVpJWYYA0lUcq8WHfqu3bowTMyXqhWKc8wU1nTett38+jTx/FQUV46SF9X7TIWioZDC4/PNhLPulxwHc3Ln1HBozZKBcQ7cHAFAao956rYxNam0fe5klCVKeX1tkggKJ1G2bM3t03mHmUwdgCSzz77hvJNFwfmphGFjTZ/1meN6OWT1f6bUfLbqLuOvZjcmKgVBbjjtq3qL639thxb7+fkOLWnhmoqQbGjrC/GSawCCDWObVpeZsaiofG65NzmF+ltyF8pmojNmh9R38TLKW2GKm7BGnSLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5H5kzTw9p7zyes/vpyIHbxrZkadlPPh5qaF46OExUSc=;
 b=nXHxTZNtsIYHjA1mDXJuPiF5ICA23xXCPEpoMJUAFLg9H8oQAJFatkHTJP9iusJTBElikQ5d32dJNS4winqTskD5ee12UY1KQwT3wL+c/W0RNR2x9ioG1q9I5KelsxthmYECLw+1n27nwq6LHBdQiomTecRDtTDVr7qVNhnCEcmPMZsypdacSzjHn5NqLllYfaLzioRYPUJz4rGa+oGeDg3LxWzOPBqmTB5WLNHmiFDPVt2VGJI+CcE8JA+XL28nSZaweL34uVPPLxvyo60Lk48wpiLSdAqJEikW0R68eD5ECNVybjdHSNIt3lUBQ9GVWTlv9ibD1DlwnqqTNMRA/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5H5kzTw9p7zyes/vpyIHbxrZkadlPPh5qaF46OExUSc=;
 b=LmTfKIcSRA+uIVn5GGqusSliH396AHR7C16mvpLRX0MZGlS7nKyyPuDG4w0ldo2tw/9p0ttM/ZoxXim2a9/eafAbmlh9aRysz55TfOQcLflNjZlAHIgXRkg9kFpP852yg3/6u1ZAmN8JGyqOjlq/YuyqPyMgzBK78zqUDh08lDI7dfsJILhWCkbi7gY/V9j3Nh0ZgZgsCWMEFimSBoOE2NbvbCEzm20xAPugyXDLBaKX503NTTYMNblgHDpZWJ26TC44udUOB9/peW5y1xTJvv3rWTl1T9HpGZjgAwo3o739diYt71eC5IQJdue9P1/9vs3AztttvfxZU5s/JraumA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SJ1PR12MB6218.namprd12.prod.outlook.com (2603:10b6:a03:457::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Sat, 2 Nov
 2024 23:50:49 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8114.023; Sat, 2 Nov 2024
 23:50:48 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Honggang LI <honggangli@163.com>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvmet-rdma: WARN_ON when nvmet_rdma_rsp::n_rdma equal
 zero
Thread-Topic: [PATCH] nvmet-rdma: WARN_ON when nvmet_rdma_rsp::n_rdma equal
 zero
Thread-Index: AQHbLPIi7+30whVqtkCKMDpBaUveNrKkqjAA
Date: Sat, 2 Nov 2024 23:50:48 +0000
Message-ID: <40933ac8-a50b-4162-8e33-514324adc852@nvidia.com>
References: <20241102063953.228107-1-honggangli@163.com>
In-Reply-To: <20241102063953.228107-1-honggangli@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SJ1PR12MB6218:EE_
x-ms-office365-filtering-correlation-id: 8ad8f8dc-eab2-4d10-37fe-08dcfb992d48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZHg4dHMwNWQ5WW9PL3A0NXJ3TjVmSnFwK25oa3BSd21RM2M3NURkWEVTWUZv?=
 =?utf-8?B?UStZaW1rR2krdHk4RENQRG1LWGY4ME0zdEJkKzF6VzVQSGVRckVlemFscS9D?=
 =?utf-8?B?Zy9pWkIvR29LbGQ3alJremMxQzdtVTdueko3bUVFRERsckNoWFpiYkdHQkc5?=
 =?utf-8?B?dzNSZUlYQjc3ODVDeHlRMCtxenBnQm5tbTFyY0kxM1hrbzdDZzJodWJMbWlO?=
 =?utf-8?B?cXp6WEJBejBVNmR0MmRCalZzSysxUnM2SjhuWnZSeTN6WGVOYVovZ3c3MWhL?=
 =?utf-8?B?eDE5NE0vbldUbE4xSy85bkRGMmROSkNYQjB6V3B4d1VJN2dSckNteWhTVWlI?=
 =?utf-8?B?T2h4dU9zMU9Ldmwxd21YVzllMkY5RE1UcjZjVE1nTkZyKzF2WGN3dm1BQ2sr?=
 =?utf-8?B?N1ZEQVZZNTlNdUJIVXVtRU5lcGM2cDBuZmt1VDVkbVVlWXliUS9DVXA1UkVh?=
 =?utf-8?B?Q1VrRVNHMlh1S0RuSlpMbit6VHhBL2hmZE0rTmlFa3hiU2k3SzBHZXJieEpn?=
 =?utf-8?B?Zys4UWtXa3diSkkvWDNuemlmaE45QWJ2d3RaQ3QxU2NqbmhIRCtLZkI2aUtG?=
 =?utf-8?B?SWJ6Q2NFVk1pd1lPR1pUUTNOYjBCUGxBdTIrUmNGWVRuR0NaMTZoYWppc0JX?=
 =?utf-8?B?MmdRRmhBK2xaRE00aG1kYTNRYkl6MEo1VXQwWHZsUTJ4dzcrdGRzejdseVZG?=
 =?utf-8?B?V3J0ekE0a0ZlVUFocEtzcGpzNWx1ODdERGdjYVliZk5ZemhpbXhybUlpQ3di?=
 =?utf-8?B?VTBkQzVRQkdTNmp2UzFkWHlzOWxtSzgxSU5vTjFjNTRHTjZCZGdVOVlRWk1n?=
 =?utf-8?B?SzV6NFYvMkM2TkFzanlEZjBFUnBBWG1xRGRrR0lUQnpUT3Nza1l6SE9tR2tS?=
 =?utf-8?B?RUczU2tCbDdrTnU3VGtqdHkzWEQ1aGtnQU9DQS9yaW5SL1o3SGtITHZFZW1w?=
 =?utf-8?B?dk81Yy83bkxNd0p0SkVHOXVKWkd3WlloRkN6Uloya3h5bTFucERFSU5aWSt0?=
 =?utf-8?B?dVF5UXRGbEh2TWhUdkdYOXlmNnZzQjRiTHJxQXlUc2JJVFNvdzlDQzVXeXV1?=
 =?utf-8?B?RUMybkdzQ1BnUFByYkJ6ajJSK2xyekFYQnROY1crSkM3VTY3SzZKSU81UjB4?=
 =?utf-8?B?c0djTWRRUndYcUdQb2xnMVNteGMzbE9kZkxjQjR1a3pnUy9mTHZheUJmZnBn?=
 =?utf-8?B?S3dlME5icDZTZ3ZKdDJZcHRNeUVYdm9vL0liSDlyQW5rUGJSTHZHajZYYy9X?=
 =?utf-8?B?SzFYSWtUSnh1WHI4RDdZZlFNRkxBOExpZWJlVUw4d00vV3BUQWNVU2VVeFV2?=
 =?utf-8?B?OWt2TGFkSnQ1Z0RpeWJRZWgyTmxvQXBiUW5rdURzV0Z1TnFWM1U4cGhPbDBt?=
 =?utf-8?B?WDRIZTR4M21HeDcvc0VXWkkzVGx4QzZmUFgvUnorZTFvRzVGTjNOU0pXYkRT?=
 =?utf-8?B?WVV5RVgzcjhrMjNBTGUvckFFaVBqV1dDTTVBNGExVVhzalZiK0E5SmVWM3Nn?=
 =?utf-8?B?T21BMVFrbTJORDErd3JGR05vNCtncjlRdmhLeWpQZ0dIV3FhNHQvVis0cEcr?=
 =?utf-8?B?V3piQ05tVUlVNWsyS3FXV1liVkNyOE92UHdXb01uTDBpRExoczBWaUs0ZUUv?=
 =?utf-8?B?WmljMXdIWXp5cU0wM2xFdERzMGNjUFd5NzYrNkN4dEs2L21uc0twU1RlTUlM?=
 =?utf-8?B?YWNEOHE2MWoxdG0rbnN6MG9icXhnVCtaeGRpS2lucVZQV3ZvK3YzTVV1NVJF?=
 =?utf-8?B?K1h1L1ZleFVFZWFGSW4zREpvbFkyQWozTDlPblN2WGxMT0tiWERZV1BPMUlo?=
 =?utf-8?Q?6etDrkhuBGKiY4nEYkm8G2Dn2nZH+mWCydFKc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3VlcDVBUVZTY2tLazY3Zk5WYUNZZFRmM1V1TkNYcnowVU9ab0EvRzZWUDBC?=
 =?utf-8?B?eUxVcTVCdlJJd0VBWlRCYmRZMTRDeGQrYnlxaE9PUVRhWTMrbnB6OXF2RzdJ?=
 =?utf-8?B?RTJJSitlaHdwK09zVy9HZVpEWHdMcjVUWjRkUzV6cmZuYmNuV2Z0c1Q4cElv?=
 =?utf-8?B?bG8xTmVySVlLcnhnSVZGNjBLR0VyWkZ3d3VML28zK1liRE5vLzJ5bmxUV3pr?=
 =?utf-8?B?S3k4RVRCMzBPV0Y5OHpEWk1xUk1ucU92WTUzV24xVXo5R0diWnlNd3AxNXpv?=
 =?utf-8?B?NzJHL1VvS2pCT08veHhYcFF2KzVBR3lEZEQrQjA5Y1FBNThJaXhMK1FlWXFD?=
 =?utf-8?B?dFR2RU9QUEV0akQ0VGpmdTcvMkc4TTc0V2dxQVZNc0ZKSGdXRVNnenFldi9F?=
 =?utf-8?B?U0RjenExRVF5SUJPTllJN3o4Qmpob1c3ejdZUjg3ajVuUzM4ZzdTYS9zTk1U?=
 =?utf-8?B?Tmh4R3ZsamYrckUvYkl5NWwwcFByVzN5OERiN0o0UnZWYWY2MnhtU3VCdzh3?=
 =?utf-8?B?RHQwQUlGcmdGT08rTk1lcWxHM0xSV2FUVmYvak1FcnR4KytDczFyaXNwQnE2?=
 =?utf-8?B?SGJQb2p6SFlNNkNjY21paXdVOC92eHE1VUYwazVIVnBzdkUzNFpoazZaaHhw?=
 =?utf-8?B?cGphYVJsc05EVFJQcG1tejBVM2hjVUVmc3doVkozVXN2S09VbjJXZUpGZStj?=
 =?utf-8?B?Z2ZkeEJlbUdBQUNVUlBCTGhWY1A3UXg1c3Y4Rzk5MTNKbkNJMXNFNjcrYnpU?=
 =?utf-8?B?K2Q3TDlXNWg0Ti84SzE0Um9NRXgyYjgxQzZrNzkxeUZPQkVDdTVOYjJ3WXdC?=
 =?utf-8?B?Mnp6S2RxSDB5b0VWQ2ZIRUtVakROV2x3bzBCTDVhakpZejdncXRxditBU0J2?=
 =?utf-8?B?RzhFd3pYdUNBQWpPTmRqSHh4QXFDeVZvRVp6enoxU1M1eGR1R2tzN0NPYlht?=
 =?utf-8?B?d2tvTDBua0ZTWlNRR0M1ck00YzVxaDBJeENBN1A5NEYyeUhteWQ2RS9VdG1i?=
 =?utf-8?B?Y05Fbi9NVUFaTUJmTGZaY1A0d0REUWV2YmtaUG5hZGJTL2lPL0lFeUJrODFF?=
 =?utf-8?B?ZnllVHNLM2R2NzQ3amNxVFk2VG9pWkEvdnZid2FKei91NDVEVERIbzhiQlVm?=
 =?utf-8?B?MXJCRHhhSGNNYThpWE1HY2l4UWdsTXVGVFErOXQ3SmRpUGVCVUhxNnFMOWRa?=
 =?utf-8?B?ZDNFQ2pxLytiN0plTDlGVjFhVmtpak1rem9PYkpiMlZXaFZVa1d6Q0REMlpD?=
 =?utf-8?B?QVFGSE5xa09Xc2RYWnpCbXE4ckZaSnRhQUJkNjRXNXY5eExrd0FhbDQvaXNF?=
 =?utf-8?B?eEhmMnpndlZaRm5aeDkxdVR0QUJ5aG0xaDdmVjFNZTIwaDg3UmdxQVNCbXc2?=
 =?utf-8?B?aUdUbnBWeDJDKzB3YmRVMlorbmwrcDcvWnJ5dC9yN1hYWHpWWmM2UGp5dWZt?=
 =?utf-8?B?QUFYeTZJNXNXdC9pRHcvVEZQVXBFS29PdmM3aDJLL3ZhUWRpRGx5SFkxa0g3?=
 =?utf-8?B?TTJoeHpvQi8zbzZrTElOeExhZENUUXo5QmlKZSs5dTA0VS8yUDNNWnZyZTVj?=
 =?utf-8?B?VHRVdy9rblhTM2VMU2RNRHY1d2k3RjZsc1RveDhkTWMyQWNiQndyWUYwTm13?=
 =?utf-8?B?MUN2TzhTS0l2QXdRYnhSWTNheHV0R0RiR0lHZXR5eE00RUxzMVdtOHNaTlJ1?=
 =?utf-8?B?UzJpQ1VyMW1pNEhPNkNLQncrSVRxemFPdEVDR29EMFJEVU11MDY3ekE3b1Rn?=
 =?utf-8?B?S2dvNml0amxHNEN2bU5GN3pFczJ6b08zREk3bysySXdyRURKeXRXc2cwOGV1?=
 =?utf-8?B?T0RkdzlpY2JrRmVNWEt1Z0tjR1VGQVRmZzNGaTFEWXRUcUI2ZDk2Tk83VHJ3?=
 =?utf-8?B?ZjhkaFdicVJtSUhHOEwvUXV3cEhUc0FNV2RIUDVGV056eTAza3NtL214blN6?=
 =?utf-8?B?Zm5MYU0rRXNPdlZELzZaMTl5RkNITnd0aEhzbUl0N2x0a2tDWnlXUThiT09C?=
 =?utf-8?B?T20vb2RmaDcxUy9qMmxNdGt1dmV4b0ZjbFM2WHhaNGhxWFFpM1JZUnN1dEpv?=
 =?utf-8?B?MWwrY3hXdHpDM1NaUGdjaW94UnFWOGZzd0FPUGZXRDA1RVZvTGczd01wQmo1?=
 =?utf-8?Q?cLG50Gn3WlJLKnOHS7nzeb2KC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBBBCDE10A913A4597261A0A6EF35431@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad8f8dc-eab2-4d10-37fe-08dcfb992d48
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2024 23:50:48.7899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9zEIHResSjQOvqTT5I91KIcR1n8nYJIq+vj7l/C7mer71ZhYDdLgFP6nsaUL0975Wmbf2LHzRlhxSGskt3x3XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6218
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241102_165109_091216_1EB3E35E 
X-CRM114-Status: UNSURE (   7.24  )
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

T24gMTEvMS8yNCAyMzozOSwgSG9uZ2dhbmcgTEkgd3JvdGU6DQo+IG52bWV0X3JkbWFfcnNwOjpu
X3JkbWEgaXMgYW4gdTgsIHdoaWNoIGNhbid0IGJlIG5lZ2F0aXZlLg0KPg0KPiBTaWduZWQtb2Zm
LWJ5OiBIb25nZ2FuZyBMSTxob25nZ2FuZ2xpQDE2My5jb20+DQoNCkxvb2tzIGdvb2QuDQoNClJl
dmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0K
DQo=

