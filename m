Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29460C27C6E
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Jun 2024 23:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XWXcAdK7ktwOstOVDEEeU3Cs5zHiBQrHwXMyZo2naWM=; b=ut5Yp9uB/06S1gV3bd/Ma42VKk
	cMePMakCAkquKywYMNtFwz/XoMrNIns941+U7s4xual+OHRUG7N8a4hSPTLjLQm5LFECYRDR5uG0X
	rxzfNrL5kc0bCTc4h7WinCdU2ccKLOTW+eUVQD6WFsQpeb17k0NALy/Vv1NUMyLOcD41N1TrFgHqy
	1LbuYaPBUxkQqN7w+Zz04awjtQqG/b2cyhzVm3rzXaSND2AL07O3xS2obo7eEQcdNpLwHXS5cDM6/
	CT7rPYDxXZh5E80i+PIoc9o1sA5E1tmLQ+TS8OAuuWIEh7nC73wMTtMxLU8YSNCJJ0zRXQzn11RUA
	PsHv/4nA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIGZ6-00000004Gzb-01i8;
	Fri, 14 Jun 2024 23:42:40 +0000
Received: from mail-mw2nam10on20608.outbound.protection.outlook.com ([2a01:111:f403:2412::608] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIGZ3-00000004Gyw-0MTX
	for linux-nvme@lists.infradead.org;
	Fri, 14 Jun 2024 23:42:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJorvkkmHZEL7mPypVZRn8YKZhLrvFsIjYa6DxtX3FHkIw6453rkEOL0TR/ENAVGufpiuvXyjZQ+PrfpCqGwgcShOp8I0GvkRfau4aMFa8+vqRmEkPY4+/LFkc1UvdK0RhEG0DJsBCMiWJ6WAi6KaeOvpFrMf2hCkRuKY83I3xxElDosaBmkVdHOTXNm9TXES6+welwMhtyyq89SDQtJWOyUAS9FpynvOPeimylJ5uZvEVRpt49Ev+ElXn3ceLRkybHrZxFTZpUx5UXUrFevNL+Q+l8KNChaO3Tz1JhFbCcTqetTxGO56dao1DQiqP7pKNBZlk1p+mX9lgCvc2/vdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWXcAdK7ktwOstOVDEEeU3Cs5zHiBQrHwXMyZo2naWM=;
 b=H2XdPnaLlTJIkulUI3h6GEPCy5sVnpPHM2JHC/AvPmmDKVREuXBo5uBUwdFif2ATNhCzTywczfNXZIUhsVd9i66wSMVgQkkeoYigz/1YsKhmKiU2tdNs/2Z60l24ickpOiNkTZ4bb+vdZfvUWF0a1EdR0ZXwQeWAdGhoXm/E7jpmljDqMQ1pJTxlCyq2vcwFqYAWGA3gNFqcZhvVCbIrUBlR63vNsTWXtmydG2xBH2rTAYaiSarA8CCs8DjCtsL4Of66GiomRO4FhIr5LQy2z35n5gLz1aLJkeLGn22ZSkcVSSJt5Q7qIYDJPdiHqZVjlyn3MRR59sqso8FzJRk1bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWXcAdK7ktwOstOVDEEeU3Cs5zHiBQrHwXMyZo2naWM=;
 b=Zs/eLWQ1n3wJX42YIAkA74JKPXzsyTrZtJahyzt2JcCaB/Q1yT0R21oCLpv8dcEljcecY6EQk4H+dGaCeUtDj6ohXLU2I4zF+WQNXeCwYukfzmFVLoK4P7EdraNgmA/xnKDbamdgwJ+URBrz/B7tE3RKYuG3Y1PHXXlMdHJgVQ9wJe0Jx7DeN+4PzWZ73weY3ZHbiYcQi9cahkiXGYqnl4LzAw1tj6uuYiNjRNyQ8CC+g3dTQU9oAp3UFiQFrPPZRcbOc5iP7CK7eb8lQNaXxobbT6iy6KByB+2FWdpcI3mGruSjIbSf3vgXUXlqOVz0JUxL51N99IewxUGdmW0n3w==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS0PR12MB6461.namprd12.prod.outlook.com (2603:10b6:8:c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 23:42:30 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.7677.019; Fri, 14 Jun 2024
 23:42:29 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
CC: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvmet: do not return 'reserved' for empty TSAS values
Thread-Topic: [PATCH] nvmet: do not return 'reserved' for empty TSAS values
Thread-Index: AQHavkfpbJ946CyWrEarb5KekDf62LHH7HmA
Date: Fri, 14 Jun 2024 23:42:29 +0000
Message-ID: <a4b4cab1-4eee-469f-a336-6b0f79cdc4db@nvidia.com>
References: <20240614104423.103215-1-hare@kernel.org>
In-Reply-To: <20240614104423.103215-1-hare@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS0PR12MB6461:EE_
x-ms-office365-filtering-correlation-id: defa4cd9-54e6-4eac-4f6d-08dc8ccba79f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|366013|376011|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?R3NoY2RacytxMUZjeCtHT0wvZXcwR25UVGJnbUFkTWlzNnJTcWliU1BuMHgv?=
 =?utf-8?B?emZKaWhBZlJrSEFOMUp2K0lGNUU4YXZMRHJVWHlwMTBBdVFoblZyR2trRFlp?=
 =?utf-8?B?SnNOQmRraEZBSytiVUxlVzlQb1pMKytKWndsbk1MbDRrTTJQSDBqZHBLaHgy?=
 =?utf-8?B?ZGhLamgvN0tZcmsyVmtTVlRkMENjU2o4M1Z0cm5GbmlwOHBKTHBPblZjeDVO?=
 =?utf-8?B?V3YybDNVTk0rKytSMnY0MGVQSElTRFVhZzIzSlNzdFhsdU42TkpoR1RTejM0?=
 =?utf-8?B?eUlWUEFwMEFDUFVuKzZpTU50MHNtN3ladjJaOFlhR1NaZER3YUhKRmNVUnlY?=
 =?utf-8?B?cGlVS2R4MUZsaVhpdXFPV0tka1I2ajdnVXBrTDF5VG1DT0QvYjhBd0paN1F1?=
 =?utf-8?B?a0RQNzB1VERtb0dDMHVBd1BnU0Y2V0pNQzFFeERtdmRWM1Fqb2pLL2N4S2x6?=
 =?utf-8?B?ZHgxTm9WYVQyVHdjTitaVEN1cmcxYlBFZHYyZVFmL0RxU2Nob1l5RWV5SmlC?=
 =?utf-8?B?TU1MdHErWisySDdyWGxSZWloQy8wUHBhNUE2V0tNWlZEdDczOUVNRVhXUlRv?=
 =?utf-8?B?U0s5Z1NYU09ZWFFDcGFIdXh5WDRBbGFiZlRVblpnSldiRjdnVUcwMlFIdTN3?=
 =?utf-8?B?ZDFaTlk3YzlFcUdWT1hRMG96dEU3SzZ1MW5aako1Ry9rczZnWFYrTmZ4cmpI?=
 =?utf-8?B?VmRVL2l3NElXaGtzV1pLMlpWWkVJdVo2dlRyU2JuNTl6SEluTG1RbldLcDln?=
 =?utf-8?B?c1lyWkFKcDRlTjQwdU1sMDlVZFJjVnNKRjJJYnJlZDJIZ0xnQ1ErVWtqazNy?=
 =?utf-8?B?bkRTb2Y1QkpveWhYWUdCWS9KZ2FSR2lybDh6TUl3TWxZd2dhdVdsdVM2TkZV?=
 =?utf-8?B?UXdBY0p3NG16R2owSnY4ZlljU2lydkNrc2pCYUdMNzZpU2c3NndyRU12RzRr?=
 =?utf-8?B?QWZPdVl1UkRlUnlLREV4K3VwUkhnRGdDeDFsNE5OSVBuQXFTdE1WY0tqdzJG?=
 =?utf-8?B?RDlsNVRMYVBjelhjSEVhbTU5T2czWlBXbCtWVmNjU21YRE44QmM2NHVyamRC?=
 =?utf-8?B?R3g5eThGZW9UNjFYSWJ2TDd0andWckZiQURFYVM5NmRJRTFLejR5TkdINTRh?=
 =?utf-8?B?OUxIVDdvNXdhT1ZvQ0UxdVVqR0phdlJsejRQSDByb1BCYXh4bXdtSWt2MExR?=
 =?utf-8?B?OHJUcVFxMDNoWUJpZVg1T0xES2pwSHNiU0p1N2pnTmhsUENGcjRRaWJFQ0Vy?=
 =?utf-8?B?OXhjYlZVaER3UUtHc1p5YUNxNUFYSldvbUJSSUVBNGZlQkRpaFdrcG1UVnpu?=
 =?utf-8?B?Z1NFbGI1U1RoMklIdlBlYzlMZUYvZnQyTXg3K1NlTkdjWFFsR1ZNaXBJSnhF?=
 =?utf-8?B?R3ZNeGczQzBBYjY4MzVwSFFFdGVoY2VxVmk0SFBRcEt0VE5pd1h5a2ZZZXNn?=
 =?utf-8?B?R1NjWDYrc2JqMERkWm10MEhnSnd1SjdRRDlwWXhuZm5Yd1JFdFRhT1BEUlg0?=
 =?utf-8?B?bVZNRUNGU1JQZEx4Sm9ISElYMS9XLy80bGw1U3Q5N2xJaTh1R0NDa0FNaGdk?=
 =?utf-8?B?eGlBUWo5VHNtYWRoemsyRnBlWHNhRGhHaTlBcHN2T0lFdnVZeVUrRGRNS0Yy?=
 =?utf-8?B?eHFBS1AwK3ZkYi80d3o5dXlxRytPUXlsVU1QWmw4cGl2eXYzZnlQQnZMU0xB?=
 =?utf-8?B?QU8ybEM0bkc0N0o2VFlvWDV5VnVtVFExNXlwUG5BMnd5eVhHTk94Ly85d0hR?=
 =?utf-8?B?WlB3S24ycHlUY0lOOTZrMTJGSmRLL3hDMis1alZITjVhZnNLWGQ5eU9zcndi?=
 =?utf-8?Q?G1PK603CTd8Ehscftxf8BdiMOlR61719ZPz/k=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0I4U3ptRWtXL1lJZWI2bTRCU3p2WDBERnpFaUFNazNoSnRUMXRoQ25udnNK?=
 =?utf-8?B?TzIzUElDa0RSZVFQeDZMc25idDBiMjROM2Z2dG11R29qSGNTWlF5eFdBek1h?=
 =?utf-8?B?cUwzQzFHWnpKMXZZcGwreTdRU3FNYW9GdVhnRVZJb1JkNHo5cFpuUSs3cWVo?=
 =?utf-8?B?azJBOGwxcmozTkphNlNQRTdYSVk4MnBoU1R3Ly9RWVQ3QzZDVGJ6Q2hOUExP?=
 =?utf-8?B?SzNzbnpRK0dJUDU2c3h4aFhDSW5HM3hGNTN1bW9wUWQvdTcxMm1zclJRbXJE?=
 =?utf-8?B?OTJ2bERzcStKZTVJdDRUc0lkV3ByeHlSNnlJUmhIUFR4MnF5Z2FmcHV2eDlF?=
 =?utf-8?B?WDlBYnRoZ2RZUDJsbXJ5S25vSS9LYjZoRGpSNko1OS9IaFZDRHY3US9HNXd0?=
 =?utf-8?B?eUc5eTVJYzZDb1R3MkFYRzd2WEhmT1ZzbVdDTTJ2WkdKdDl2aUhwYXNIN0p2?=
 =?utf-8?B?R2V1L2laVXIwZkJtdmhNcjBnd01VbGJhTXZ4Qmk5dGtFNmYxaUhUa0xGTWxj?=
 =?utf-8?B?QTRZeHBVOWViRFlKU3Vva2JJcXZpQU1jdzRjTWFCNUJSZEsrMktGV2pCeTY3?=
 =?utf-8?B?enVFTGttem1MZHlMV0lGcDMwVDVJVG5vL1dxeWszS1NnT2lFRFphSS9qaDFn?=
 =?utf-8?B?QmZ0dDd5enJBODV5bURrLzF6eTNIbFdqUzZaL29tUVdqcC8wdFVGZ0tGSlhr?=
 =?utf-8?B?aWM5dElnUTM0WTZPbmNXZE42VThDRTFNaDZGRlFKRW1qUG1vU0tOaERZaXc0?=
 =?utf-8?B?U2ZLS1Z6VUxCRFNsRWJmU3JqRzNIdFowczM3alNSN3lKNERKRVhRZXJMRXZK?=
 =?utf-8?B?UnRmUm5RanFvZCtHR2g0Zk5mK3lWaGdHeW14aDljMlJPUVIrcWE3R3JnTzdT?=
 =?utf-8?B?bkpnNnN1MnQrK0ZPRkdHSzVCZmN0b0pCQWJLU1AxOWZ5YkNQWlBBamJXOHRY?=
 =?utf-8?B?Mkh3cUwxaFBGWWRONTRLdTNWYkdCWXpKbWNmNkJ2enhXeFJSRHlmSmtLeTAr?=
 =?utf-8?B?Yy9mQzYxSVdxU1dwRncyS2dGZVlhaWwzQkpQb1VZa0dYTytsQzlsVTJrV1Aw?=
 =?utf-8?B?Z1daWjVlOFFpQm5QYWpiTHJ0dTlDSzVuSUg0SWZwbWRzUkt2UWgxOEp0bEpy?=
 =?utf-8?B?dS8zZUdhYVJsdmhjRy9mYlFwa0RJYkZBeDdxV0pkdGxqUkV1UW4vVEFKbm0v?=
 =?utf-8?B?WTlPd2NvN3lKV29JZkFzT1R1L0t2WW5ZQlZEZWQzYnBUSFFaVUdXNkpZYXJh?=
 =?utf-8?B?UHd6ZGRQV2dmc0xBeU5ld3dERHpyTEVmbGdsV3VTQXNXbGNWY3JsUEUxbjg5?=
 =?utf-8?B?VERTVlduZndnejBTeGJ1MzZ6VmxJNGlUZnNKbmdndHV5eVNla0FacWZEZHpO?=
 =?utf-8?B?WGJXeDJJOHdVV3pZNXBSbnFYZ09qWm9aYmVMaXF5eFh2ZjVCWkJkOFd3UGF4?=
 =?utf-8?B?Z1FUZXE2dGc0cTFJWCt1QUcrdkNIZkIyS3ptT2hpK21YWUgrTEcyRXlwK2N4?=
 =?utf-8?B?dVEyOHNTVFpybHJvQkc3dlhFeEhsczNpZVV4NEtjQWdNa0VOb2g2QTBpeFc0?=
 =?utf-8?B?QTc3azd6OFBUUFp1M3lPU2dnak9vNElIUFM1M3RlRWFmY1dLeW40MWNla1RP?=
 =?utf-8?B?SmRxNFVQYnozU1RHWkQ4MkFQUFVUWUVRcU9RUU1jRGhaenlYRitiNXFNcUhW?=
 =?utf-8?B?d0FIdW5nWGR4cHRYMThhMUd0VE55V1hlRmsySUZJODV1MjVJS0xtT1R4N3R4?=
 =?utf-8?B?M3NEbG9JQTlBU01RckxUWmRPS1BVeDNOdWU1cFh6dGlLR0Q1UHpmaEFxekli?=
 =?utf-8?B?eFdvZjkyTTRST3NUMWYzZ1VoVXE0N2RoTFRTUmhNZmwrdFVmLzZrSFE5NzhW?=
 =?utf-8?B?dDQ1WmFNc1J5VDhENkVkK1VVcmZwRm9Ga0RLOFRBaVhMVHZsQ2hzeER6bnRY?=
 =?utf-8?B?THZRV1dpNWYvR21rMFNXR3hTOTQrT3A5Q1pQTy9ocUFsV1VPSjJxWkxCVlF3?=
 =?utf-8?B?Y3VFNCttdTNKYVlKYjJma096NFZYUFdkY3dWMEcyamtvL2p6TkZnb01rbGN5?=
 =?utf-8?B?Uno3bG14ZmlRQXloTkxGUTM3MjdEYXZLUFdoTC9tL0JCaTJFVjN3eHlDTDVj?=
 =?utf-8?B?Q0VTd21GTlpQSEd4MUhDVDBvU1BvZU5jSTJLOHdFdE1ZcnR4ZHZPVENIbWVI?=
 =?utf-8?Q?HhjAyCjvDPdxDjOMgzdFPTZy5dhJzilVPQoWwlSYUbDm?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <589EEDDCDF4240428E6A0507DE1560F8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: defa4cd9-54e6-4eac-4f6d-08dc8ccba79f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 23:42:29.8070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8NejjF9N2A+RShj4hRenV7fyp4W0jennVoZuOn+A1DOSpcYCRwC8Ly+WmRlQZRufaQ5jLvszGT64zZZ4caDMpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6461
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240614_164237_157541_7E3F81F3 
X-CRM114-Status: GOOD (  10.26  )
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

T24gNi8xNC8yNCAwMzo0NCwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOg0KPiBUaGUgJ1RTQVMnIHZh
bHVlIGlzIG9ubHkgZGVmaW5lZCBmb3IgVENQIGFuZCBSRE1BLCBidXQgcmV0dXJuaW5nDQo+ICdy
ZXNlcnZlZCcgZm9yIHVuZGVmaW5lZCB2YWx1ZXMgdHJpY2tlZCBudm1ldGNsaSB0byB0cnkgdG8g
d3JpdGUNCj4gJ3Jlc2VydmVkJyB3aGVuIHJlc3RvcmluZyBmcm9tIGEgY29uZmlnIGZpbGUuIFRo
aXMgY2F1c2VkIGFuIGVycm9yDQo+IGFuZCB0aGUgY29uZmlndXJhdGlvbiB3b3VsZCBub3QgYmUg
YXBwbGllZC4NCj4NCj4gRml4ZXM6IDNmMTIzNDk0ZGI3MiAoIm52bWV0OiBtYWtlIFRDUCBzZWN0
eXBlIHNldHRhYmxlIHZpYSBjb25maWdmcyIpDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEhhbm5lcyBS
ZWluZWNrZTxoYXJlQGtlcm5lbC5vcmc+DQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBD
aGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=

