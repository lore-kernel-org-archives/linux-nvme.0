Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896ADC25B78
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jun 2024 00:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UtoLTAbPlJF64TOjU1ohKrYcgy1nlTf5Bkbu0jGXMug=; b=ZP+WZUQJPFINvvvFJoF8uTk2st
	hMIlPIpo699wduK+qgvY0Lp1f2ISScZwKW+jhpd10UIADaXN5aWnOXulvvX+ryT5/iHBTcVx/qNN7
	0ekdlRUuDBv9SDrp8AOGhc88vK8iqYupt30h8KamvizUf31XaEZKktZEN0FEl+wi9rfXmStbakBYO
	ADVwTRBVWS9sVsn46XfXfqS3ez1RmdOBmUFkEk8ibC5CPfxIPb4N+beRl/GiPFaeCkyWTbz4voYGm
	Tc+iAT60SkKiseZk/v++0MkXsjMmTJCgXyrTk3eDNiDnrlpO5lT7bqvKu8PTxsmg9L3/r7Adzxd3L
	8SZnQsXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEe6y-00000004Eka-12xC;
	Wed, 05 Jun 2024 00:02:40 +0000
Received: from mail-bn7nam10on20601.outbound.protection.outlook.com ([2a01:111:f403:2009::601] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEe6u-00000004Ek1-1k9U
	for linux-nvme@lists.infradead.org;
	Wed, 05 Jun 2024 00:02:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DepRfIhmnO83J0/NDhKrqY1CyB+gAlJGNBpx5liqbiLsIx9j0/kK6X1GJrUMR/5iyEb38LlnO2LQLy8FBS2DxktEnwmlp7qoSlndwyFZpwo5VJUduTX5Ny6pIeG0zLVRc1NAWdn71VqhOZ4Y/z9+mPdHsN2h6jsPWlt0qEXfAV9e67uNJCCYiZzQztzuN7siPCqCd5/ZOAOZQ7HziRSBbNeV6EQtClgir2ifbVOCh4T8UxQI33uY6EawmQ2XVbJNcCFoms7AR2oiQ8MroHeE0YZhYIv6plaotpnUuQ/zZpIQAV7ZUGo5B7rm2SOoW4jMvKGcDigoorUAK5hcPwKstA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UtoLTAbPlJF64TOjU1ohKrYcgy1nlTf5Bkbu0jGXMug=;
 b=Pvq7sWG7yqt5d2SjsPzD+BLosRadYSftouAJ6iU9Bn52YliJvNnnIv6kIP/opFb11+ZLfFvvAtOZuaZjuanyO+RrCPC+RHQJPvXHhivYCSYTx4ibkZN5ymUqoORcX/1J4rhnhGmDnG2zLFo35zMIQOA/cV3Kf5tnqPRY1aNeIeHutCqhpVBg3ZDpGXR9sRKVW+NJuCPIn7MHswupwrqoEFYhZCLl1xTyACvPgpoRvDkDP3PYl4dNsdBERqpBOLcdqozMWfLBg70ePhCWGk5PZ75k17hq3LwkNs8TfXYWk9h0ZmqdDeap/mD8KD2u3akHgaH1jjEyUIn7Lk81l9IA2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtoLTAbPlJF64TOjU1ohKrYcgy1nlTf5Bkbu0jGXMug=;
 b=UQ7a90TzFEUZgH+h3SZW0gnLHur4lgTyHSvHG7ixRJbPYTYsq95zpODnrBgG9yqlEVZtq1ppK0iWH1N87wQ2a/zh6/r0ShvNxHqre/nXL1y6iNVqnOjDYYMB9ZhWEcl0KufwKL5w2AdXxOzohPrAi8Nw952jG3dp5TdDsSp1FKjvmrY5eOGgQV4jG4Qo0TSg1kX5EZh1UR1EZfxxaghBP8jqN7eWyWQBQIWGU86N37EWBtf5PMNttkLBTJa/P6xRvqtZSd8U9dFNRrx3woZqNLXISFwdWeXVLSNWzcfj5B/kh/t/4PeJGU0gh/ZcouJf28DW2nTcyPaImpJlx5zdDQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CYYPR12MB8751.namprd12.prod.outlook.com (2603:10b6:930:ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 00:02:24 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 00:02:19 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Weiwen Hu <huweiwen@linux.alibaba.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>
CC: Mike Christie <michael.christie@oracle.com>, Christoph Hellwig
	<hch@lst.de>
Subject: Re: [PATCH v2 2/4] nvme: fix status magic numbers
Thread-Topic: [PATCH v2 2/4] nvme: fix status magic numbers
Thread-Index: AQHatbWsDIcPePjWE0qt+fFoJ6cHcbG4S9cA
Date: Wed, 5 Jun 2024 00:02:19 +0000
Message-ID: <c680bbd2-2b8d-4d99-9e5e-51b4e922612a@nvidia.com>
References: <20240603125702.97368-1-huweiwen@linux.alibaba.com>
 <20240603125702.97368-3-huweiwen@linux.alibaba.com>
In-Reply-To: <20240603125702.97368-3-huweiwen@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CYYPR12MB8751:EE_
x-ms-office365-filtering-correlation-id: bfdf4822-fb41-4fb5-6a27-08dc84f2c457
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?VXc1NEh4c0R4cUdhb3pvVmN2Q3pGaFgreTc4WTFxSkw4V2htTEF0aE9LOG94?=
 =?utf-8?B?dlZKKzRzMnZ5ZnVMbTVublN5cnp1Y2tjVzdCRFQ1YnNpYWprUUV1THVWWGtp?=
 =?utf-8?B?TXdLTVdjNFA5eXk2dVpNWFhmNkFWV0M3MW5Ba2dpdXh0UXBmeUtKSlV3MWcr?=
 =?utf-8?B?WXhJeUNVdU5ZQWk2dENVVmJaQ2lLZlZmcUtybXNUaFRMa1czT280QW1OdldB?=
 =?utf-8?B?MnV6VUlpei9wK0lFOFB6dFhaa0ErQktoR1FzeHZnYlpHZ1FuTlBvU2tlbEl5?=
 =?utf-8?B?QURBd3BrbUtkVnZpaEZRYndBTVBLRWZDOGgvdTJWWmJDU3JlZHNNcy9kTm9L?=
 =?utf-8?B?WVFjYnFEemQrTnJ0V043bENlM2gzMkluVG5GdEhBRjFOTVVNdFBMMFh2cVRr?=
 =?utf-8?B?OXZoS0Y5SEoxSlYvbGJLKzNaalZaUGtVZmp4c3RwZTJoVTNHYlJFRGViZHk5?=
 =?utf-8?B?a2RPMitITDRCZXU0c1dkSDNybDZCbnBLSkpGTmlpUWFYVnRaR1cvUnNXZVlk?=
 =?utf-8?B?T2pscW4rdU8xU1ZWUDlHanI2SHk5eG1UTmxUdTlwR1Q4eSt2Z2xINkJ0TkVV?=
 =?utf-8?B?WGZoSnBvbWhtMm5pTDBjN0JwVjVMK0ZrUW8xaThvMU1qZUZFL1FLNU54NEdB?=
 =?utf-8?B?NHZ3TzNaKzFHaGhuSHVyWnhpK3QreTZ0Wlc4NU02Nm9mWG9uY2lMR2NQclJP?=
 =?utf-8?B?R0hDT0wrSXdvZTgyZnNmaExrY3RuRjMyL201Z3E0andDSVhEczJ3ay9DT0p6?=
 =?utf-8?B?OThiOXhza2l1b2JBdExhTzAzbnFmaHdIUDREdHRvbTRDZjE3aE1PUDJieFNQ?=
 =?utf-8?B?WWJMLzVZcmZkYmJpbUFRWUdZVWhNbGpKNElQWXd6SVpLcURCcVlPSHI2Tjd2?=
 =?utf-8?B?azVtQUxGTk44M0VRRHo3cnN3UnFUdmRVM2Fra2J2R0xyVFJuaEYrTzgzcFdI?=
 =?utf-8?B?c2tPQVhMdUFRV1lVNWp5SnA5d25NSm5XbTVBRWtoOWlubWZXMkt6dUVXZ1Za?=
 =?utf-8?B?TnZuRnRkYWVWN0dvRk1iaXhLUGlhV2l1MVBFNkVWdTJSS1VPRVFVeTVuNWgv?=
 =?utf-8?B?M0tzSUhVZGFRZFZhanJjQi92aGtsQmw1ajRHZVVoQXZmajdaY0JxWlMwQTkw?=
 =?utf-8?B?TXcrazFINjNFd0lGWkZxWFZhWjBFdTNENDUwWHUzUENRcUMwTWNhSU5VdUQw?=
 =?utf-8?B?Vk01RS8zLzNsWWxsUmVYVlRsZ2FDOWhlc082blRJbG52SDViS3Y0QnR2L1pw?=
 =?utf-8?B?Z1lxWnkrRzNkR2R1NmVPSlJZdVQxNkxZVVlKSThLTEgzeHZuaGlWWEJwdnRn?=
 =?utf-8?B?RVdBdWtFWVkreHAybVNFci9JTWNNUlp4VUk5bFVFTlNmZmpxRjBhcGN6cDVr?=
 =?utf-8?B?WHVPVUd3M2dlV2lLWUZUV2szWW4vS2tqMDJBczJjd2ZUMHNHdEk2SllBV0Iv?=
 =?utf-8?B?dmhzbTlBQWdJL2V6QjQ0MSsyNEhqV0J3RXFaK09ZR1JjM2FlRHRjd21NQW92?=
 =?utf-8?B?aTFwQmkzNkRPeXVxTkFBcTQ2SVMwclFQa2xRMW1vbEwwSHV5MWJNNmxhVk0z?=
 =?utf-8?B?R0ZNbmFXVEdvQzhPam41bGVKZVBGMU0wd21Od21UWW1vejcvWkhuMEZ0S0pZ?=
 =?utf-8?B?UWdRS0I3REo0TkZMNnFNanlPK2ZmQXZ4cHJyckp1MlNWQ0RxRW1CSkFqUkFh?=
 =?utf-8?B?Qi9EdVRFRTdsS0QyWWdBa3VIZ2o2ajE3c1RCNzZNRVFwdzAyb3NwejVqSjUr?=
 =?utf-8?B?SDF6bzhnWStuYTRUMnRzN0NaMmxqbmJhSC81bXk4ak5xUE1iS0VSd29qeWVF?=
 =?utf-8?B?ZWk1VERDWU5FR0Q4TGtNdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aElJS0QxRU9heStSM3Fmd0VNaGgwR0NlV0NFQjZxVXdKUC9MelhXMlYxVTFK?=
 =?utf-8?B?RHdHOHpiMmhnL3FleFJQcm5MSjB0UGE1SmV3d0N6NWs4UjhCMEVoaFRPN2Zk?=
 =?utf-8?B?amt0ZmV4TVNqSmtNVSswL1VSdWo3NWVaNmdDNXRDVFlGQldrQTVESFlHZk5m?=
 =?utf-8?B?b0gwMm1KZjNTV0hKaFRlb2YxaS85S0cxS0FZaVE4cFVTRmVSaC9PMkdVNkN4?=
 =?utf-8?B?UEpMdTQ2SHhWLzNGT3I3NnhjaXV1MlNDNzN5SmFwVGM4amdJMW05OFhIRTRC?=
 =?utf-8?B?WUtiVDgvWnJBdmwxTlVTaGhaQno1V2VTcVZPQ1BjV2ZCMnRNNTNTWGJOc1NP?=
 =?utf-8?B?Nk1ITCtLeGljbmFjYS9aN0N0d1J6bUtxWUpsejZzckNGS3huNUJDSzcvWSs1?=
 =?utf-8?B?OVpuOUd2OFNydVh6d0xOWEhEOUttOHdjS010YjNaQWYya3lSM1MrQzJNemN6?=
 =?utf-8?B?eUpMZnYrcXJaWHhlS3dHUVQ4aGlyZDZIa1JkcnFEbmtkdDFPekxZMCtULytW?=
 =?utf-8?B?SEhVZm9kRmFoaTRrbFNwMGk4UlIwYnJxVHJLdkR4OEFuM3hCYlRuSlltZits?=
 =?utf-8?B?dHp1Z1RCdjdUajhpNjcxdDhBeURqeE5yOFFnVE1rSERTOXBWcDVxUEtQT0ZX?=
 =?utf-8?B?OGtMNG5ha3Mxa2M2NmRsRjZKemgwTS9BY21UdGZlQ1BWQStXL3FHdUxMZ09I?=
 =?utf-8?B?YzB6cm9nQ3d2WWM4L0Y0Yy9JaUt3MHJnalMydTYwYjRHOHNEZnRLdnBiMkV2?=
 =?utf-8?B?dHl1SFRJS1o3Zkt0bjRRWEdXRFc2eVlnRTNWQWJ1eHpobTFMTUhVeHp5eWlO?=
 =?utf-8?B?V3lrV2ZtUExCS2Z6ZWY5UEZTeGhMcGdiNkZFM0VDUTNRWU1LRTJkek44dkRq?=
 =?utf-8?B?VDRhbUR3UnJQMjJiSjZzTUd1NU5vaVFNdnBndHY2emNZQnpONlVqQjE4eVVj?=
 =?utf-8?B?ZXUxbEFhUlBEVTZmbTFLWWJZZDVjNWlmT1dEVGd6ZnE1Nm9jcTRjM0xUTERN?=
 =?utf-8?B?SmVySTg4TTFjcFFLK3diNlBoa1NZYVV3b0JNSWNYcFZzd01ZV214UWw0Y1Yr?=
 =?utf-8?B?a2d2aDFoTmJYWkUySVRQRHhWQVZRdGlWbEZWVGRyMlcrZmZ5S0JBa2l0ZC9j?=
 =?utf-8?B?bUx5RitBSEh6eFV2WGdkTDczR25zQXROTCtyVUJ6cDhSMStSTmVYRlRIaWgw?=
 =?utf-8?B?bjY4M1kwMlE2RW1DR0tHYU9TblBJQUpZaWlITzdsMkJJSFNOYTQ5emlHM05v?=
 =?utf-8?B?M3dBNkQ2SlBSL2xJQkV6bDhuSDA4SFhsSGR6NGc2R0ZtVHdsNGtYRzB1U0s4?=
 =?utf-8?B?L3JkKzBPMkRHZjFkcTMvdWdrZ2tjUlRRVjVOYUNUcXcxcVlZSElRMUFTU29V?=
 =?utf-8?B?dTVBYTd5MW0rTmVQQnRTU1BQNTdVS1VnYndJNUc4MGNQYUZMUW4rKzh4QTlR?=
 =?utf-8?B?Nkw1UU5CTW1HMGIyUFpyWm1keURyaUJaT3hqNW9SbmQvcForSEx2NG40U1JQ?=
 =?utf-8?B?K0lGYVFUdTF5QytGL0pla2U5QWlrSnRSYzdrKy9yWTEwSjJYWlpQemxaL2wv?=
 =?utf-8?B?UktFQXBhUzFrNS9iVVZaK1IwcEpPbzNzSVpGOU9BZnRKYjR3U0tjeTJ0Z3pS?=
 =?utf-8?B?SzlBQU5vcS8rN2JZSEFZdG0wMktUVVhZaHNmd2NrUjVIamNZdS92bzNTNnZu?=
 =?utf-8?B?MWFmdEllMTBNb0pTaThTQnExZ0tjRlNiWXlYK0JydXZRS3kvZEZUZmpoOThn?=
 =?utf-8?B?YjdtcnRrbUZsZTc0NEY0TnZKc0tOckU4a1IxWlN6SE0rWWMrNUhJUGdjL040?=
 =?utf-8?B?a2gvWFNUenMwN3JVeGlwblRwcVM3Vi9PY3BrcTJvQWovbllSQTBVbmtpRkUr?=
 =?utf-8?B?YTBMWmpSUnJGM3lMK0JjWHlwQWNSa3UzRU0xeTBUQVBQTUVJNFphbW4zSDFh?=
 =?utf-8?B?WGF6MUFWSDE5SzlBaVV4Y3o3N1NVUGpHNUxidFNjdXdtOUpuVHZ2b2pCYUl0?=
 =?utf-8?B?Z3B2YlhQSThyWXN1Mi93Wkc4aUlzaHVnZ0xlUkdtZ1VuNFgrcit3Z1lTYWNy?=
 =?utf-8?B?ODVnZTZRcnBuSk15OHhGZThpdXZuWnl4cWY1R3dYRzNuN2xEMkdSR3JuMWQ5?=
 =?utf-8?B?K3BnQUZXMVQyalRvRlg4dVU4WXZEbURDc1pTa2pEZ2QyS2dsSUZvdjZ0cE1y?=
 =?utf-8?Q?1vXdwMMcQcxi91Vo1u3O809k/GuHUdZvivUNWZOk5Kso?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBDA06B2773BDF44A8C91B691B136467@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfdf4822-fb41-4fb5-6a27-08dc84f2c457
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 00:02:19.0193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4oRk0PTTpPTYu4Ms2REGgDedAFfy+UC7+A7pSvZ6woODM9uAFI4pTcfirqfmdDYujBiHp0RY+VQPvZ9En8QYvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8751
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_170236_557258_5F3D6E73 
X-CRM114-Status: GOOD (  10.36  )
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

T24gNi8zLzI0IDA1OjU3LCBXZWl3ZW4gSHUgd3JvdGU6DQo+IFJlcGxhY2VkIHNvbWUgbWFnaWMg
bnVtYmVycyBhYm91dCBTQyBhbmQgU0NUIHdpdGggZW51bSBhbmQgbWFjcm8uDQo+DQo+IFNpZ25l
ZC1vZmYtYnk6IFdlaXdlbiBIdSA8aHV3ZWl3ZW5AbGludXguYWxpYmFiYS5jb20+DQo+IC0tLQ0K
DQpbLi4uXQ0KDQo+IEBAIC0xMjIzLDcgKzEyMjMsNyBAQCBFWFBPUlRfU1lNQk9MX05TX0dQTChu
dm1lX3Bhc3N0aHJ1X2VuZCwgTlZNRV9UQVJHRVRfUEFTU1RIUlUpOw0KPiAgIA0KPiAgIC8qDQo+
ICAgICogUmVjb21tZW5kZWQgZnJlcXVlbmN5IGZvciBLQVRPIGNvbW1hbmRzIHBlciBOVk1lIDEu
NCBzZWN0aW9uIDcuMTIuMToNCj4gLSAqDQo+ICsgKg0KPiAgICAqICAgVGhlIGhvc3Qgc2hvdWxk
IHNlbmQgS2VlcCBBbGl2ZSBjb21tYW5kcyBhdCBoYWxmIG9mIHRoZSBLZWVwIEFsaXZlIFRpbWVv
dXQNCj4gICAgKiAgIGFjY291bnRpbmcgZm9yIHRyYW5zcG9ydCByb3VuZHRyaXAgdGltZXMgWy4u
XS4NCj4gICAgKi8NCg0KbG9va3MgYml0IG9kZCB0byBoYXZlIGluIHRoaXMgcGF0Y2ggd2l0aG91
dCB0aGUgY29tbWl0IGxvZywNCmJ1dCBpZiBldmVyeW9uZSBpcyBva2F5IGlnbm9yZSB0aGlzIGNv
bW1lbnQsIExvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtj
aEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=

