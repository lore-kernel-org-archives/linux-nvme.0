Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C14DED743F8
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Nov 2024 00:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gOD1vr0kfH1v4kQeL28ahBt/LUqAJ9NIXmRbQc0gqGA=; b=QN91Gomh9JhFcqtF+JV0gzOHn0
	VYghjCU18GRoPqyDMpQzB6+6R2MA03kBtvhMS5sWZpwPbqnnNOFJJMGrPgkfOLj+NKX3WbLpLVom9
	2e+/zkr6HKZ/wjAEjV4rq6VkX4DdZpWZh1VmwdcFJ4W+MCtpmOTnaLWfXOHGPSy+Y5bNHEZq2WvqI
	Nqe8Xnotwsqhh02F+n/Bz2LaFpUuzAdF7prLGlqJs6/KI5xab5TOfKuABC6v/00ko8HIWwLvOkbZg
	EuMnewrudVZnNRP62u2304Jy9KTKFkx+lMvFYF4bjrcFOwrW4Nm9Hog2BklEkDrlHFRRHx+Yl9MTk
	ugNX2XAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDucg-0000000GSJM-2Y0x;
	Thu, 21 Nov 2024 00:00:38 +0000
Received: from mail-mw2nam10on20604.outbound.protection.outlook.com ([2a01:111:f403:2412::604] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tDuce-0000000GSIF-02wi
	for linux-nvme@lists.infradead.org;
	Thu, 21 Nov 2024 00:00:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qCkbwBAXDdwZlav2kWG9GcVqo6+6DuVXiQA8v/DzC+ZNmRCALUXpT4GTgChxb6jo2cwNfdzUk/6yXtAG1ySRFdBoQ+2k2LIb6QdAcWuTms1bcYdDjabdHvpuFtOCuryR+bjXnvzT2BUJsA9bdxbDndnGsGSkSB0ijiz8htJai6pZLrF7teMHG1Tv1CDpmT113L9Ep6FUwj0LY+FWX/u8gwo/M5n5h9BKQPchaXEHAnnYdUzoLfZ4aF86Z4Qkk76ppXRu9N7p7uxVOLjyZSX1p6qRfou3Athnr/h1cDo/AwKIre0BWd0/D72eGe1ADEWaQ46mHizEfUS2uf1Ffhov2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOD1vr0kfH1v4kQeL28ahBt/LUqAJ9NIXmRbQc0gqGA=;
 b=ZOJ0h+9Id/MJFXnH62BHSWCXE2M8edZrL3q3DJbr1Yk5Civ0BcSBna2MSsLlfkSSjMG/Xb5ym8BvfrzysK9G1CgL/rQNji5Bas6qHpBB+g25sddxrpS3xuahQL4uWft0DiD78mKaDVzuWpQW7WZjZEZN/o9cGs5AMJinWVIaMtRIRw+XQ5cbU/jaKF/U1W1LAnJ0iKO4SbQmEVbBV3DOMHP83jqe47c7R1IsPsDpVO9/bgJQKBC6cFvD3oLXzJ2Y2AXtmPxXQpu9duRXKQOvtu8xcNOgSBdaRK9bEvir4u9KSADu/mdmZO6p/LyHncl1nEEO4H2dMnAjeAAR4t7iEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOD1vr0kfH1v4kQeL28ahBt/LUqAJ9NIXmRbQc0gqGA=;
 b=cglqqMeDUz3UYaPZxZgR4LZYFEYwBw2elgXBhjcr0rtBzkuXYOZC7ptu+mDyeQ010Ufe53GFiHCMMOBiRdEF4fARXXpwJs4H60vpGj6EJmSV9ibx393kk8WREBm6g5ci8aIFmDlaSSdkURO1NytiHMpLdoXaN/awVfsYJKNxkmjGeZNC2vv3LTZA6K1OF5G8Oh0qfhTNNOxmxvA4gQhv5Ly/hGP0qSU2obbStHhVS5M0v3bfeun8wEgkEcXIqvjYo7Ar6FHxtX/C6kDf+oKWq2LmescDYs+QZoa6asZvXBk++FixNkZaXEDCbOsKSzd3To2tzAOPD/Hgrs9yYS/bkA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS0PR12MB7510.namprd12.prod.outlook.com (2603:10b6:8:132::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Thu, 21 Nov
 2024 00:00:20 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8158.023; Thu, 21 Nov 2024
 00:00:20 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Ramanan
 Govindarajan <ramanan.govindarajan@oracle.com>, Sagi Grimberg
	<sagi@grimberg.me>, Paul Webb <paul.x.webb@oracle.com>, Christoph Hellwig
	<hch@lst.de>, Keith Busch <kbusch@kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>
Subject: Re: [bug-report] 5-9% FIO randomwrite ext4 perf regression on 6.12.y
 kernel
Thread-Topic: [bug-report] 5-9% FIO randomwrite ext4 perf regression on 6.12.y
 kernel
Thread-Index: AQHbO5QQ9DTUqPPC80KBpz/0L4RKDLLA2YyA
Date: Thu, 21 Nov 2024 00:00:20 +0000
Message-ID: <0cfbfcf6-08f5-4d1b-82c4-729db9198896@nvidia.com>
References: <392209D9-5AC6-4FDE-8D84-FB8A82AD9AEF@oracle.com>
In-Reply-To: <392209D9-5AC6-4FDE-8D84-FB8A82AD9AEF@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS0PR12MB7510:EE_
x-ms-office365-filtering-correlation-id: 3574e3ac-6d31-492a-fcff-08dd09bf7d79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VlF5VFQxS01ZQjl5cFZFZkxnNFpzYjUrdGVLUjcyenZqamxudE4zMHl2SzUy?=
 =?utf-8?B?YTNqdys5MWxVR1hVUHpST0NBRlBoN21VR0FPNU1WbkJrZ0pFcXFBRS9IUzRF?=
 =?utf-8?B?ZFRFb2hLNXN6Z0x4eThMaWF1MWhxRHJIek85d016RXROS2tTeldjQUljS29Q?=
 =?utf-8?B?WCt3anlwZmJqRFArV1RWOGx5MENGV1MwYlFLa0FmVUZLMmg0RkxjbmZlWUFJ?=
 =?utf-8?B?ZGdZVU1rcXRJdUY2UDFRa2ZVRDBwejBMcm8zY1dFUTcrNkltSkd0Q0UwM0ZG?=
 =?utf-8?B?YXBZcGVkamVWdy9EdVF4SjBZZXEveEtYbmJKSG0rZld1VXY2NVBXa3JzTnd2?=
 =?utf-8?B?cnpMVGRoQ1p0NU1FcElxRnA1cEtwNjYxMTR1eDZOUHN5U1FMZlVZL2N3MHdQ?=
 =?utf-8?B?cFh0dE9ISC9UcFgwOXpkU3RwOC9QVUNLaGs0ZkdmbXlHZmZkOVIzdnlxbDBr?=
 =?utf-8?B?NmxFS0RJVUJIV1EzTkN6RDJMME5PMi8xbms1bjQ4dTVkY3NlaEdTTlNteXlZ?=
 =?utf-8?B?TUN0TW92OHpJNElJeGs4MnpCeFJLTm9lcXNWS3RQUGJvRml6N0QzSkIxcWhh?=
 =?utf-8?B?WFB1RWx6RE03VXdCSmdIRU5GYWxXb08raG9nT0Fzbzk1Zkt4Y1Ryb09TTzRK?=
 =?utf-8?B?T1VKaDBJejdSQjVmTnlxNkM0NldvK084SWhGeGxpRWkwVU53VkJnNjlPbENE?=
 =?utf-8?B?OHVpNVAvRE9mWVI3dG8rVzJLaWFwcldqWFV2SjQrVVVKM1ZzcnJOWXBSOFVP?=
 =?utf-8?B?RUh2RnJKZWIrN2VtSlNtU3V6d3ZSRE45M2t6RGppS3VVLy9oTkM0TFBJZnNE?=
 =?utf-8?B?ZnIwOUluRjBUTms3eXVXNFNTYUFyMWZyTFJpNlVQTXkyT2RDdEc5TStlK2xB?=
 =?utf-8?B?S1kvYnI2bHpwcUJnNDIvM2FuSVM4dUg5SHFlaDJ3Z3R5Vys1UVJPb0FGaHAy?=
 =?utf-8?B?NFlSSkZrYkVUTzVlSXlwUVpuelNHd3BBYkczTUc1TmFPMDJVZUNranMyYnRW?=
 =?utf-8?B?ZEg1dGJ3WDU0c3lCMlhZTVFtS1pLMWVtdFFFZWFHaUJIUGUzZllnZXlpT05Z?=
 =?utf-8?B?eXBSQmcvVXErWndVdXJ3MkpiY0x6QUY2TGE1bWpsQUVxSEVaSFl3d0Z2OS9H?=
 =?utf-8?B?MWs0ajdWazlSclZ6OSs4cjFxR3dZRC9Zd0twbC91dUFIVVlhMVhtNFZxTS9R?=
 =?utf-8?B?T0lVOEJXRzVabkFjWFRMcENlTXU2ZW9HeWtLaW5JVFpMUUVIbElMVk84eW5m?=
 =?utf-8?B?WFNndExKcGdXdGRWL3JJK0tzZGdpd1JFSnR2akI4czFTWjZ4WW9LMWd0d0dU?=
 =?utf-8?B?dFpRcy9md21ja3NrMEZTdmZqNGxvOFBaWmVnelVpOUhISERMRVBrdzJUQmZ0?=
 =?utf-8?B?eFhiZVBsZVlvMU1yQW5GNU04bXhLRE1kY05QUVFTa0hBbCs5aFZza1h6Z2Jj?=
 =?utf-8?B?b0NuNS9vNDNpdy9YeFFrRmVmeU5kcCsvLzlBazVGNnJKTCtoTGdWSGlFTWdM?=
 =?utf-8?B?VzhuRmNmbDV6blRVc0V6b2ltQm40SHFaT1hIRVhSVDNyb2I2N1hYbTFWZU01?=
 =?utf-8?B?SUJaL25NQ3djUHprSEZQSWNFRTFwUVlmZVVOME9GemM3RFdxMW9XTjRJOFkr?=
 =?utf-8?B?OWxib1d4bjMwQ2VBbldjRjJsdEFiQitrZG8xWWVlSHpmK3FaZDdoUk1Wam00?=
 =?utf-8?B?eUVNeHJpdWNvdTdWc1hxY1A5aGVqVFgrL05RbkxER0xrdEQ1ZHVyNTJRckc4?=
 =?utf-8?B?ZFZDR0tOU0s4d0NVVFpkZVE5QU9aN0lWbTRRM1NJcDk0MkduWnQzekVzZ3Zm?=
 =?utf-8?Q?GMe+Fas4nInOWJFegnRvePMbUrcJjr2zYdqTs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0pxQjE1UjJoekY4YXEvT3gyWHlVdmpWS2FQcURIWUtoZm5WRm9sSkNaOTFm?=
 =?utf-8?B?aStzMDh1bjhMU0ZRZllIcTZMSy9zMkJEZW1scUt1ZTVKcHZWdWxVWW95dnFv?=
 =?utf-8?B?QnpEbDYxTjBuSmYyU3ZzcUoxQ04rZXV2ZFh3elkyN2dDZE5kWDRRTUZxMjhi?=
 =?utf-8?B?ZFFsblVxM0pkSVdITGtHbU5idzRjMEFFNVJHbFZPaS9aMVIxbTJXZFJYeEli?=
 =?utf-8?B?WUZkVGxmWjZFTHNQL3NGV3kycURraDhTWStpWFI5TjFHVzc3Z05iUENuVjlU?=
 =?utf-8?B?Q0VlSWNSbXRacExDdUlsdGdXN1FOb1kyNG1DdkU1SHZUM2x2MER3bE5xeFZl?=
 =?utf-8?B?YVBLT3l0ME95WUlsR3ZOZ3htNW9QbDY5UW1oTHpFb01UQXFQS0sya013Ukcx?=
 =?utf-8?B?S1NSbWZweE9KRjdLa01YL3JwN0xTZGYwVWlGdkQwbXExRG9zRkdiZUJ6VTZK?=
 =?utf-8?B?OWxtelRXcGxsUlJlNlJVaEVlaDNsclFzNVFqemkva2IrQzF4VWd5MENxVFE3?=
 =?utf-8?B?S2ZrbzVvS1BGaVMvUHBqaUVIOEkvSmNxSVNUYmZHd1dCS1FSb3R2enVrcVZ5?=
 =?utf-8?B?ZURGdlNYOTBlV0dnbEpoZS9MSnZDcWpqN1dMK3lpenUzQitwc2UxWEhHanFh?=
 =?utf-8?B?aUlSWEpic3gzakpiZ1ptampiZ3hBZHZkYTNTbWtDRFdVM1ppbHU2Z3I3bGVh?=
 =?utf-8?B?UkhsSWcrUHRJeEs2Z3I5R3RVS0lHSnpmVUtMZlEwUjJreU9BdUU0OGs0WG9B?=
 =?utf-8?B?NHdScldYVDlZNDFNV0s2MkpxVWI3ZVlkTVo4QVpXa0xRZFc5bXZqYzB6MzhC?=
 =?utf-8?B?VWdzK0VBYXZlNVRaeEcrS2x5OE9URFVTM3BwWHhtQ0Z2cEpSS2J6Y0lBVzhD?=
 =?utf-8?B?VUJSSGtlbVhUS3AyTE01c2xRbTR1OFF4WkxoMEpvQkxHUHNIVHlXTEpRNGZ6?=
 =?utf-8?B?SmwxMnhLRUIzYWdLNGptdG4rTVpVQzc5N1RvVFpyVzlYdWdXMnR4OVUwcm05?=
 =?utf-8?B?RUhJYzJSUldaRDJsSEI2Q1U5SGo5TkhUdlROdHVkNUVDYm9BS1NROGdtSysx?=
 =?utf-8?B?WWVFa0xSdzl2d2VOVE9PeEY5c0FJNytSOVJja1J4ME1TVHMrNCt3YUxEbXAy?=
 =?utf-8?B?Q0IxTXJ2am5iMEIrdVNrd3d2YllJSTNKVTBicEd2Q3ZDdlMzR1MyOVd3dmRS?=
 =?utf-8?B?MWszbzlWZGFkVkN4T2Z6bXo4YWFRa0hMaU5WaHpaRElmZk1kVDdFNUVpTXQ0?=
 =?utf-8?B?eDVSMDZ6ckdaVGl4Zno1UG5wVmQrY2huRHpRTmtwYnZPeEQ0RnU0bFRGcGJF?=
 =?utf-8?B?UEtSdk1ERDJCQVlqMGtGUjZhRngrb0tkT3p4TVgvTjlOR3JqaWVZaDJCdGw5?=
 =?utf-8?B?OHdiRXQyTGx1Z01ZRVJIMktLUmpoeFNvdWY4OVRiUVBDZExUR3Jya2NEQmE2?=
 =?utf-8?B?RSs0a3oxV284OGNpR3d5cUlIK085YWw3MDZVa1RhR2pRN2JNaGd2dWlXMk0w?=
 =?utf-8?B?ZHh4dExNK1I0UzNCdzI2MFdnOUk3bmNQVktqUjJSZVFIa2wwZVp3UUoyV3RI?=
 =?utf-8?B?UldBUFlFalUvYnpvNEhTcHlyci9UNXF3NDA0d1lqV3hjSldJRytYdzdUM0Zi?=
 =?utf-8?B?YkNKb09tV0M5ZUlBdkh2ejIxclVpYSt6eS80UEt6eUVVbjdqN0pBbWJ0VS9X?=
 =?utf-8?B?dTVhZTBRWmdXR2tSVWtaZGRNYWs2S3FhL2dDMEpwYWJtRGJOUVV6aVdiOEZj?=
 =?utf-8?B?bkJHY21qY0ovRStFVkhhZFNiZXhwRGxJb3I2RGh1QXhJMEdTeHcrK01jdU8r?=
 =?utf-8?B?eUZ5WHdkaENGYXdVQi8wYjNqSGF3dWM3cDFmUC9VVm83TjBNNmltMVVlNzJL?=
 =?utf-8?B?L2dYS3laTlcwUFdXRHcyMzJuYUQ1dmM3QlFIYk5aVEszTFZ4Y3ZvVEdkQTdR?=
 =?utf-8?B?K0orMjRWdkc1ajA4N09pMHF6aVN4UmpDTmtuVThwZ0VpT1JJNlJJSmsvM1J4?=
 =?utf-8?B?WXBhclUxSVdxQWhWUVVWaFZDNiszUTllSVVrYXhkejhYYWlCVHlHWVZCa3RK?=
 =?utf-8?B?cllHU25WUnUrMG1FZVZVaTNXeDdoTmlhb1ppa2JYV1FHeGtTc2lzR2JFV2hz?=
 =?utf-8?B?VWNQZ0VHeXFMd2ErbXJLOTcyUjE2TnIrQ0lBajZyQnlOK0loNHp2TnZxazBU?=
 =?utf-8?B?QkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D98564112A902744A0BD8C580E1F6638@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3574e3ac-6d31-492a-fcff-08dd09bf7d79
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2024 00:00:20.4500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lnPKCOMSm3T//3HljlKku8ShcOKmOvZAkoqXMOXcx1BLV0/Z9glQqoGzOPYEwkWhDTkHOIeTaFy8fiLl8yXUgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7510
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241120_160036_072743_1D70080B 
X-CRM114-Status: GOOD (  27.25  )
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

T24gMTEvMjAvMjQgMTM6MzUsIFNhZWVkIE1pcnphbW9oYW1tYWRpIHdyb3RlOg0KPiBIaSwNCj4N
Cj4gSeKAmW0gcmVwb3J0aW5nIGEgcGVyZm9ybWFuY2UgcmVncmVzc2lvbiBvZiB1cCB0byA5LTEw
JSB3aXRoIEZJTyByYW5kb213cml0ZSBiZW5jaG1hcmsgb24gZXh0NCBjb21wYXJpbmcgNi4xMi4w
LXJjMiBrZXJuZWwgYW5kIHY1LjE1LjE2MS4gQWxzbywgc3RhbmRhcmQgZGV2aWF0aW9uIGFmdGVy
IHRoaXMgY2hhbmdlIGdyb3dzIHVwIHRvIDUtNiUuDQo+DQo+IEJpc2VjdCByb290IGNhdXNlIGNv
bW1pdA0KPiA9PT09PT09PT09PT09PT09PT09DQo+IC0gY29tbWl0IDYzZGZhMTAwNDMyMiAoIm52
bWU6IG1vdmUgTlZNRV9RVUlSS19ERUFMTE9DQVRFX1pFUk9FUyBvdXQgb2YgbnZtZV9jb25maWdf
ZGlzY2FyZOKAnSkNCj4NCj4NCj4gVGVzdCBkZXRhaWxzDQo+ID09PT09PT09PQ0KPiAtIHJlYWR3
cml0ZT1yYW5kd3JpdGUgYnM9NGsgc2l6ZT0xRyBpb2VuZ2luZT1saWJhaW8gaW9kZXB0aD0xNiBk
aXJlY3Q9MSB0aW1lX2Jhc2VkPTEgcmFtcF90aW1lPTE4MCBydW50aW1lPTE4MDAgcmFuZHJlcGVh
dD0xIGd0b2RfcmVkdWNlPTENCj4gLSBUZXN0IGlzIG9uIGV4dDQgZmlsZXN5c3RlbQ0KPiAtIFN5
c3RlbSBoYXMgNCBOVk1lIGRpc2tzDQo+DQoNClRoYW5rcyBhIGxvdCBmb3IgdGhlIHJlcG9ydCwg
dG8gbmFycm93IGRvd24gdGhpcyBwcm9ibGVtIGNhbiB5b3UNCnBsZWFzZSA6LQ0KDQoxLiBSdW4g
dGhlIHNhbWUgdGVzdCBvbiB0aGUgcmF3IG52bWUgZGV2aWNlIC9kZXYvbnZtZTBuMSB0aGF0IHlv
dQ0KIMKgwqAgaGF2ZSB1c2VkIGZvciB0aGlzIGJlbmNobWFyayA/DQoyLiBSdW4gdGhlIHNhbWUg
dGVzdCBvbiB0aGXCoCBYRlMgZm9ybWF0dGVkIG52bWUgZGV2aWNlIGluc3RlYWQgb2YgZXh0NCA/
DQoNClRoaXMgd2F5IHdlIHdpbGwga25vdyBpZiB0aGVyZSBpcyBhbiBpc3N1ZSBvbmx5IHdpdGgg
dGhlIGV4dDQgb3INCndpdGggb3RoZXIgZmlsZSBzeXN0ZW1zIGFyZSBzdWZmZXJpbmcgZnJvbSB0
aGlzIHByb2JsZW0gdG9vIG9yDQppdCBpcyBiZWxvdyB0aGUgZmlsZSBzeXN0ZW0gbGF5ZXIgc3Vj
aCBhcyBibG9jayBsYXllciBhbmQgbnZtZSBwY2kgZHJpdmVyID8NCg0KSXQgd2lsbCBhbHNvIGhl
bHAgaWYgeW91IGNhbiByZXBlYXQgdGhlc2UgbnVtYmVycyBmb3IgaW9fdXJpbmcgZmlvIGlvX2Vu
Z2luZQ0KdG8gbmFycm93IGRvd24gdGhpcyBwcm9ibGVtIHRvIGtub3cgaWYgdGhlIGlzc3VlIGlz
IGlvZW5naW5lIHNwZWNpZmljLg0KDQpMb29raW5nIGF0IHRoZSBjb21taXQgWzFdLCBpdCBvbmx5
IHNldHMgdGhlIG1heCB2YWx1ZSB0byB3cml0ZSB6ZXJvZXMgDQpzZWN0b3JzDQppZiBOVk1FX1FV
SVJLX0RFQUxMT0NBVEVfWkVST0VTIGlzIHNldCwgZWxzZSB1c2VzIHRoZSBjb250cm9sbGVyIG1h
eA0Kd3JpdGUgemVyb2VzIHZhbHVlLg0KDQpTbyBub3Qgc3VyZSBob3cgdGhpcyBjb21taXQgY2Fu
IHNsb3cgdGhpbmdzIGRvd24gdW5sZXNzIHRoZXJlIGlzIGNoYW5nZSBpbg0KYmVoYXZpb3Igb2Yg
dGhlIHdyaXRlLXplb3JlcyBpbnN0ZWFkIG9mIG9mZmxvYWRpbmcgKFJFUV9PUF9XUklURV9aRVJP
RVMpDQppdCdzIG5vdyBmYWxsaW5nIGJhY2sgdG8gUkVRX09QX1dSSVRFIHdpdGggWkVSTyBQQUdF
IHdoZW4gY2FsbGVkIGZyb20NCmV4dDQgc2JfaXNzdWVfemVyb291dCA6LQ0KDQpmcy9leHQ0L2lh
bGxvYy5jIGV4dDRfaW5pdF9pbm9kZV90YWJsZcKgwqDCoMKgwqDCoMKgIHNiX2lzc3VlX3plcm9v
dXQoKQ0KZnMvZXh0NC9pbm9kZS5jwqAgZXh0NF9pc3N1ZV96ZXJvb3V0wqDCoMKgwqDCoMKgwqDC
oMKgwqAgc2JfaXNzdWVfemVyb291dCgpDQpmcy9leHQ0L3Jlc2l6ZS5jIHNldHVwX25ld19mbGV4
X2dyb3VwX2Jsb2Nrc8KgIHNiX2lzc3VlX3plcm9vdXQoKQ0KZnMvZXh0NC9yZXNpemUuYyBzZXR1
cF9uZXdfZmxleF9ncm91cF9ibG9ja3PCoCBzYl9pc3N1ZV96ZXJvb3V0KCkNCg0KLWNrDQoNCiBG
cm9tIDYzZGZhMTAwNDMyMmQ1OTY0MTdmMjNkYTQzY2RjNDNjZjYyOThjNzEgTW9uIFNlcCAxNyAw
MDowMDowMCAyMDAxDQpGcm9tOiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCkRhdGU6
IE1vbiwgNCBNYXIgMjAyNCAwNzowNDo0NiAtMDcwMA0KU3ViamVjdDogW1BBVENIXSBudm1lOiBt
b3ZlIE5WTUVfUVVJUktfREVBTExPQ0FURV9aRVJPRVMgb3V0IG9mDQogwqBudm1lX2NvbmZpZ19k
aXNjYXJkDQoNCk1vdmUgdGhlIGhhbmRsaW5nIG9mIHRoZSBOVk1FX1FVSVJLX0RFQUxMT0NBVEVf
WkVST0VTIHF1aXJrIG91dCBvZg0KbnZtZV9jb25maWdfZGlzY2FyZCBzbyB0aGF0IGl0IGlzIGNv
bWJpbmVkIHdpdGggdGhlIG5vcm1hbCB3cml0ZV96ZXJvZXMNCmxpbWl0IGhhbmRsaW5nLg0KDQpT
aWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NClJldmlld2VkLWJ5
OiBNYXggR3VydG92b3kgPG1ndXJ0b3ZveUBudmlkaWEuY29tPg0KU2lnbmVkLW9mZi1ieTogS2Vp
dGggQnVzY2ggPGtidXNjaEBrZXJuZWwub3JnPg0KLS0tDQogwqBkcml2ZXJzL252bWUvaG9zdC9j
b3JlLmMgfCAxMSArKysrKystLS0tLQ0KIMKgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygr
KSwgNSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUu
YyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYw0KaW5kZXggNmFlOWFlZGY3YmMyLi5hNmMwYjJm
NGNmNzkgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMNCisrKyBiL2RyaXZl
cnMvbnZtZS9ob3N0L2NvcmUuYw0KQEAgLTE4MTYsOSArMTgxNiw2IEBAIHN0YXRpYyB2b2lkIG52
bWVfY29uZmlnX2Rpc2NhcmQoc3RydWN0IG52bWVfY3RybCANCipjdHJsLCBzdHJ1Y3QgZ2VuZGlz
ayAqZGlzaywNCiDCoMKgwqDCoMKgwqDCoCBlbHNlDQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGJsa19xdWV1ZV9tYXhfZGlzY2FyZF9zZWdtZW50cyhxdWV1ZSwgTlZNRV9EU01fTUFY
X1JBTkdFUyk7DQogwqDCoMKgwqDCoMKgwqAgcXVldWUtPmxpbWl0cy5kaXNjYXJkX2dyYW51bGFy
aXR5ID0gDQpxdWV1ZV9sb2dpY2FsX2Jsb2NrX3NpemUocXVldWUpOw0KLQ0KLcKgwqDCoMKgwqDC
oCBpZiAoY3RybC0+cXVpcmtzICYgTlZNRV9RVUlSS19ERUFMTE9DQVRFX1pFUk9FUykNCi3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJsa19xdWV1ZV9tYXhfd3JpdGVfemVyb2VzX3NlY3Rv
cnMocXVldWUsIFVJTlRfTUFYKTsNCiDCoH0NCg0KIMKgc3RhdGljIGJvb2wgbnZtZV9uc19pZHNf
ZXF1YWwoc3RydWN0IG52bWVfbnNfaWRzICphLCBzdHJ1Y3QgDQpudm1lX25zX2lkcyAqYikNCkBA
IC0yMDI5LDggKzIwMjYsMTIgQEAgc3RhdGljIHZvaWQgbnZtZV91cGRhdGVfZGlza19pbmZvKHN0
cnVjdCANCm52bWVfY3RybCAqY3RybCwgc3RydWN0IGdlbmRpc2sgKmRpc2ssDQogwqDCoMKgwqDC
oMKgwqAgc2V0X2NhcGFjaXR5X2FuZF9ub3RpZnkoZGlzaywgY2FwYWNpdHkpOw0KDQogwqDCoMKg
wqDCoMKgwqAgbnZtZV9jb25maWdfZGlzY2FyZChjdHJsLCBkaXNrLCBoZWFkKTsNCi3CoMKgwqDC
oMKgwqAgYmxrX3F1ZXVlX21heF93cml0ZV96ZXJvZXNfc2VjdG9ycyhkaXNrLT5xdWV1ZSwNCi0g
Y3RybC0+bWF4X3plcm9lc19zZWN0b3JzKTsNCisNCivCoMKgwqDCoMKgwqAgaWYgKGN0cmwtPnF1
aXJrcyAmIE5WTUVfUVVJUktfREVBTExPQ0FURV9aRVJPRVMpDQorwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBibGtfcXVldWVfbWF4X3dyaXRlX3plcm9lc19zZWN0b3JzKGRpc2stPnF1ZXVl
LCBVSU5UX01BWCk7DQorIGVsc2UNCivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJsa19x
dWV1ZV9tYXhfd3JpdGVfemVyb2VzX3NlY3RvcnMoZGlzay0+cXVldWUsDQorwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGN0cmwtPm1h
eF96ZXJvZXNfc2VjdG9ycyk7DQogwqB9DQoNCiDCoHN0YXRpYyBib29sIG52bWVfbnNfaXNfcmVh
ZG9ubHkoc3RydWN0IG52bWVfbnMgKm5zLCBzdHJ1Y3QgDQpudm1lX25zX2luZm8gKmluZm8pDQoN
Cg0K

