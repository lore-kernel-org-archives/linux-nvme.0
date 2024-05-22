Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0368C25B74
	for <linux-nvme@archiver.kernel.org>; Wed, 22 May 2024 00:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XakiEgWOcyY0EIh3gGS7ycUjy3m6qWQq32wqLdKv5vg=; b=pFVZLYLzsmYre/3Ko0zA/IMYgq
	7p/N/XJL9CBCSt0s1FtxTThrrklt9NjcPtRORmEikX1fuoGSixVFSc+yfvmRFHcNS+FgIaVGz+UEZ
	xxEt/SrmhosIYDdXS0LIab/p3xKUFhofFjOUC1voAjaKrjgqTigYeh9jFIT+DL8PNlQYQU9BTnztR
	T4osm1OoF9ax9VrQ3ZMaRL1Po6bvsuxfffw8tHRl5VzV9Vt8KdUhvS319ApjmkUxPBzXxXKZhgSTE
	seRWZqhbxn7QHkKT2t/0JFdVj2gF2et8IJke7Hb/ZLjDsSmSkmK/zWmwqIZoGdxYCPRAFuWrqeaNY
	gjaXwJWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9a6q-00000001Rl3-32Vd;
	Wed, 22 May 2024 00:45:36 +0000
Received: from mail-dm3nam02on20601.outbound.protection.outlook.com ([2a01:111:f403:2405::601] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9a6o-00000001Rk6-06sZ
	for linux-nvme@lists.infradead.org;
	Wed, 22 May 2024 00:45:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UobT95dywTzfhQR53EUjM15GD3i4AKYVNvcdysOhPYb/tMYwMCR0qVLXuw9JETSvXxDNAHgVanK88r4YD6gF9JfCMEl39ppDhB3P0z7qXeTQ4SWsOXfTbK/pXKokOr6VZyyL8Osr/TnV4nCoul6Zr0ruB4PZCr3KBUUqjozXJ7i9IcNKWwQdK10FufULdNnARkZTARHvxtxHX6iv3wh/lFViiCqoN8lvdmPH57G0TjhN3amN9IWVBhoJx6YOJnXO1PKXMmql9lSnycH2Usm5fQuSiL5jXNh313Y6aVBlM6uZ8BFvCpOn/M2S1dVg4XA3gkk0hbYAsdiVq852XGQu2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XakiEgWOcyY0EIh3gGS7ycUjy3m6qWQq32wqLdKv5vg=;
 b=hH0GpH2eygHeSYbtUhEQcNIFhR9ZOiNIA+CV2wSc5dPyD7u/Q3esSYNn/k4Rh70zgoByY1KaCJvQoJvAr3Q19nsuGR468S4t/wB+zEbQCUpHJhFmGVt5lesviB2ceDiElTsHrtJ/gn2v8K4zjICrqXMqIvGqY6yBKsBtOZMaXhT6jFBNaqJujmcKSDMi8Hil1F1TzhlkOEWiZPPsqcvF1PaShmYAifj9dWOHUYA8ymRDFhy527WmuAW0KUn0lz8wNqbuGuu5B45vavqWV5ZGcW//FiYUlzsSSZgeOUkLfQ2r8hit7C1+Xzx+MRpcluMS0v0chLfKXY63p3Fkv15N4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XakiEgWOcyY0EIh3gGS7ycUjy3m6qWQq32wqLdKv5vg=;
 b=rI0o0/Rlh7RGDHrbJ8m36Cue7TSiXIpLn7SXLcnbisamA0w36qS06I/jrWyVyeuXwPhYw4WDTtN1PRoi7hsU+ciHhX1qhj6Rlt9tApkGpBnVMLx2FPee+diYHdmxKi9z3T1M96SMUr4lR+H57yA7RurEjPyr1piv/9WHfWH3B51sx+lYoLycAxrDkwVKceYZlwyK2o1oXvO+/Dcfi3FIKBpleLCQ29u/q0x7fpzOkfF+znUFXPtKbaNU20pdGtGTdFCtpdK/eaix/e4mES0bLJ5oAZOv+Xfgx2OdOR4F2LSweeosQaf2GIHU0G/Y/eXnoKHU5lmtjAsE98gypkD0Hg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS0PR12MB8573.namprd12.prod.outlook.com (2603:10b6:8:162::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Wed, 22 May
 2024 00:45:20 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%4]) with mapi id 15.20.7587.030; Wed, 22 May 2024
 00:45:20 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Chaitanya
 Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] nvmet: fix ns enable/disable possible hang
Thread-Topic: [PATCH] nvmet: fix ns enable/disable possible hang
Thread-Index: AQHaq1zVrubVUCVqLkeJQ5Ud0/K9p7Gia+qA
Date: Wed, 22 May 2024 00:45:20 +0000
Message-ID: <e6ebe0e7-ee45-40e4-8f96-22bb2303b355@nvidia.com>
References: <20240521085623.87681-1-sagi@grimberg.me>
 <20240521085623.87681-2-sagi@grimberg.me>
In-Reply-To: <20240521085623.87681-2-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS0PR12MB8573:EE_
x-ms-office365-filtering-correlation-id: b8230363-6430-475b-9f02-08dc79f8750f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?cUpBa0tpM2J4TFUvTStuKzJVLytjRW0xMWNtWjlYRm5MOE9ubUMrUWY2cVZr?=
 =?utf-8?B?aWFtaDlQd1ZxdTZod3BiTUpENkc5Z1c1eUZ6ZWdINDh3eFVrZFB4RUwzeWpD?=
 =?utf-8?B?d1BVbUE2eGw4L1JwMld3amx1cnlpZGFLRGVlV29WYWRaN2VNNjNZWDh3Y1Zm?=
 =?utf-8?B?WVErRVk1YklXd0pUcGlvNVdIWXgweTZsNmVMYUNkd2NtZzJQdk5OaXhaNENR?=
 =?utf-8?B?L0hEcHdkVitXL1BjdE9aUWFrUFdGMkpYVXpha1lvQXNBbHVwR2J5NkFsQzVU?=
 =?utf-8?B?eEVoeGdDcVdIQmdsMDhHd3hoU2d3VXF4M2FWSjJaNVBWMU1QaTZiZ2VnWXJP?=
 =?utf-8?B?a3BGaVNUU21KYkFWak5vSk56Q29ZSnpkY2ExTktEYTBTbElxY1B6WWoxdHB6?=
 =?utf-8?B?OWhOWlY2b2JMQzZaanpPTGU1YW5OdTNhRmhYWnZJdzVLZTZ2bUtOblRFUkE3?=
 =?utf-8?B?UXM4M2hYUVR4RTRjeHYvTjd6cGxRZE5HMnFNcFExS2w2YWZ4aStSNUtLaWti?=
 =?utf-8?B?eDdtYUxCNnhxQW1NL3VSRTE3eDArMGpDcG5YR3kzZUplS3U0QWtyL0JCOFcr?=
 =?utf-8?B?Q0ZZMzlOWGdFeXVsMGYyNGpCekI1RGxCQ3ZqZEhiOHBQR0ZOVXBwWW5DTXU4?=
 =?utf-8?B?eUN5YytqWWZ2MGFOMnlVTzRxejF5aCtxNG93NW1qSGc3Z3dSUTIydUdvclp0?=
 =?utf-8?B?d01LTVZha0lBdkswK3BLZEF3V2swZ0V2YkkrejZ4K2VYRENKcGxPYXZ1Qmt0?=
 =?utf-8?B?SjVQT1FLTnJ3TjEwSVZrT1RNUFVuSnZMNzdQM0g2OVU1TkMwWmZZaEE2Z3lB?=
 =?utf-8?B?UGJrbXZOUzBIM2YwZlZMOEdxMitmbG5yNVo2U2JVWUo5TFQ5V0FFRkhPRUxx?=
 =?utf-8?B?bjhBRHVQMS9WcXk2R0J3dmtyTEdVbitGYlRRZDQ1V0ExcFU2NjhzMWlhcW8r?=
 =?utf-8?B?bzJrVmZyZU5TWSs4dndDakdnU25CTkVVaUR4TC93NStqUTFHdytvRUhEN2Nq?=
 =?utf-8?B?eFJkcDJmYWlNZWdUbU9aZUZvVzZkSWt3WkE5eXgxZXFJYjE0ZmNtMGpzUFdJ?=
 =?utf-8?B?MURiRWdaN2JwTFRkaGNtZSsvdXMrRVh4Z3pYdUExYUJnWkh3UGpwbFMxSVBq?=
 =?utf-8?B?TDh3b1Q2QVpjSy92V3BIU1NzekVsYXpUeEtmUW9QQXF5V2lmT3dLdXNJaVg2?=
 =?utf-8?B?dHkzSlpiZ0ZxdkJ2bHlVRGYzemZ1MUJORUZJVCs1Wk1UVE1jRkhFQ25COVIy?=
 =?utf-8?B?UFZ4dDJQTjhvMmVYSW9NVTQ2NXdxellpbUR0aFZVVTJ4cTZCMFRyS29oYnBj?=
 =?utf-8?B?WDVDa3NyY1V5NkZReVBVRGd0WkVNbVRJMm9odkN4cGpPRVg4R3V0ZVg2OVVE?=
 =?utf-8?B?elVqNXR3UDFhNXd3ZFBWclQxMnlCaEFaMlNzSHd5RjRRa3lkZzN4aVR2TktM?=
 =?utf-8?B?VnNIY1NCUk8yUVJXSUhKUlJGNzRNUmpJbFJYazNzUEptd3U5YmM5REx0eFVt?=
 =?utf-8?B?ZmdKU0lpRTlPd3YwQmJLQnh5R2M4eFRKdFkxUWNIT3Btek1QelFXVFM4WEw4?=
 =?utf-8?B?Y0N1VFhNYStDTjB1cWpoV0Jmc3FKTm9oOGZzbXBQRGJwUlJIOTQvVVRHdU1i?=
 =?utf-8?B?ZUdXOUsvWkt5ZzNxa1ZvVmt3VzkwQ0Zzbi85YWcxeWtNNVMrcTJTV0loSi9W?=
 =?utf-8?B?MnhMYWJucmNoMEpzMjlqb3JzM0JkdDNsditRTUkzNC9YK0w1Qjhsa21XK0gw?=
 =?utf-8?B?Rk9MbW8vL2UzeDFERDVBSjlwcVgyWWZqWGVBL2RZN1N5M29FSlc3U1M3NDhK?=
 =?utf-8?B?c2lIdXdoUUdQaXNwK0Zmdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VlEvaFAyZ3ZIcGNVczl0QWxobTBKTU0rY1dVbC9QY3ppZ2l0Q2xBQ0pkWDd4?=
 =?utf-8?B?SnRTWFBYK1A1VFdzVjZ1bjkya1p2aDJqMUFkUkZWbmkwOGVSekpIUmtEU3pE?=
 =?utf-8?B?NjNkVFoyYzloYjRXdHZjd3V2M3dvYjNyUkd0bldUUlk0VXpDWWkwKzR3STRm?=
 =?utf-8?B?Y293eVFiUks5QXY3ckRQVFp4N2lhSjBBS3ljZ1R5dkpjdjk1YnJqTFhsNWZ3?=
 =?utf-8?B?QVdjN3Z1cjFQekNuR3Z4N3BGRWxDS0Mxb0cyZHFxYm5FazU2MG5WdlVxNk1E?=
 =?utf-8?B?OEhHMnprdHcyekJoQjRySlNrMU0wdiszUy9KSHJGNjVsWmNxaG5HSUc1cVgr?=
 =?utf-8?B?a0M4SUhOVEJrQlpCbi9XeHdadHpJMmRQNHBLQmtEUFNDNHdIQTU5S3RQTHpj?=
 =?utf-8?B?cTVuMWdOS0FRR2VERU1kN054dGpUNDh0Y05YZFlOZkwyOWJBcjB4bnZoeUFH?=
 =?utf-8?B?Z1ZreFZMZGRMQkFlTU01RW1Nei9IMWdqV3BoT0pMK2NwdGRUbHJmTjNjZEdk?=
 =?utf-8?B?R2hHVk9xT2pJTDREaGhyN0YrY3FkWG1rcUNCS1RURE1TdGJJYkYyNzBsRmZX?=
 =?utf-8?B?VW9seGdKcmhOUlZuOXJEeUEwY2V6TVEzQU1udnRrZWtFWndDR1RuZWFYZUl2?=
 =?utf-8?B?V3MvSXVkZnQ1MU8yYk9VN2xyRENsMWE5bFMwa1RsakVzWDZxQlRFUEdtb0Fa?=
 =?utf-8?B?dGowVmkxWENqU3d6R2RlZXU1cjdLb1IrRHVERFpVSVUrQkZqR2pLUHZxTG1V?=
 =?utf-8?B?aVh2TkIydHhCaFRucnJPMWQyS2pJTC93QVNUWm5yM01ZQVJlNTN1UUFBUjVO?=
 =?utf-8?B?YSthejBidjZZWU93TWlqVVZXQUtLNS9wL1dMSU02eEtNdlhrNVpxVERYZW9J?=
 =?utf-8?B?ZGl0VEo4NGROWDAzQXZiQkJwM3RmOWF3UTg2a3E5ZFVCeHR3NEo2UjJycjdq?=
 =?utf-8?B?RHByMXVzUUtjbk5SUFRBdjU2ZllPMzE5Qzh5Z3d4dCthZEhFZTMxQU5HdFJP?=
 =?utf-8?B?RWZQd0liRU96RnhzYVlsWEZaS3ZHbldZRTlDbkcrd1diU0dJY2N4Y3dPZGxP?=
 =?utf-8?B?a29CaG1BNFpkeTM4UHhFOGhpajNNWWRERXlEdEVCc3hQSlFZOU1wblhSTU5p?=
 =?utf-8?B?alNtR1R6NTdrMzR6UmFRUDdyRmVtaG83RXg3U01MWHhCeFFxZFFmL1dTT3dx?=
 =?utf-8?B?ZzdxU1FYcjBKSnNra3BhTDBBNG1TdU00bTJ4dnBJZ2toMjlmdThIdjlhY01E?=
 =?utf-8?B?N3FkUkVoN0N0Qnh4TkZjMnFPSkljUmRoTzFIbVh0RXM0d0xITkFuYVRHL1lL?=
 =?utf-8?B?TGM2WjhZb1YvQzl1MDNaVnU5dE56cXY3SnNXS3hRTWNGWUZHeWpzYytYK2hk?=
 =?utf-8?B?OGdaOFh0R0Y1TzhGa0NFSzMrOC9vck5BYVVrVGRBOFd6d3d5ZjhiUjNzTE1q?=
 =?utf-8?B?dEs2a2FrUkxlNEs2REliZ1JpbzgxTmtKL053MkQ2NEY2YmdNVVBzWXhCY1hR?=
 =?utf-8?B?cFZoQkhKRHNvVGQrdnNJZzlZenFCQXdXLzRkK1JoQW4zS1NEbW9DSUhUME9P?=
 =?utf-8?B?MUNxRndJeHdFZmJ3UE9oZUZXbURlU2ZLVWIxWDlXRUVjQWROQ1NCYWFod0Ur?=
 =?utf-8?B?aDJKMTBTSlk1Rm1rZnZ5VFl0M0VUWFpQN3c5bWliVDVWREVMV1pQZ05pODVw?=
 =?utf-8?B?Zzc0OVlDR0Q1WC9yai9nRjJsQzhBWmx0MGZQTUt4ZUhENk9LcFhTd056bWFZ?=
 =?utf-8?B?VGRPQTlhVnZLYzZFN0dUbU1mdktCV1ZoUSt2WWdKclErNVB4RHZzL25kYXZ0?=
 =?utf-8?B?MHFnN0w0R3h3WkRMbll2R1M0SlpmdkU0RTI2amxJQ01IQk81R2ZZelgwT2tw?=
 =?utf-8?B?ZWorMXh4ODYzeUY4Y09qTFdVbkpqUlFTaENwSXhrbWd2OXBOcXZvUWxzeGln?=
 =?utf-8?B?RnNOcDkyQ0Q0bGhXeW1SVE5oNzFDVzN0UjdsWXZjNnV4U2sxVXZmc2xBY2Jk?=
 =?utf-8?B?U1ZqQkNmcGJrUG9xeDFiNk9kZ0dwem0zSnBGK3B6QnFWajdQdDdXZXdFSU5H?=
 =?utf-8?B?Z3VqLzBsQVlMWWlHZWxxSnY2bmdsV2Jlci9XNG85TVBDZHdwMm5PbXZ2cXls?=
 =?utf-8?B?eld5Y0hSZm5QSkM2bTZMS0oyY2w1MDBSYXBEdGpIMEhwMFFtZVlwcnJpWmNx?=
 =?utf-8?Q?IYLVTYj8CeO6U3ilPMcIuoN2BGz3on8fb2I174n3bWdc?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6705D055E3373D4EA2B52D0EBDCDF6E0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8230363-6430-475b-9f02-08dc79f8750f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 00:45:20.2152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S2buaft005zobxzn5szxlTahbLUl27iMVm3tlUoQXuYAN0NwiQnlQeN7JIGlNoPVWBZFcRsXbmr/8wlQs0FWqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8573
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240521_174534_167526_C7B50571 
X-CRM114-Status: GOOD (  12.67  )
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

T24gNS8yMS8yNCAwMTo1NiwgU2FnaSBHcmltYmVyZyB3cm90ZToNCj4gV2hlbiBkaXNhYmxpbmcg
YW4gbnZtZXQgbmFtZXNwYWNlLCB0aGVyZSBpcyBhIHBlcmlvZCB3aGVyZQ0KPiB0aGUgc3Vic3lz
LT5sb2NrIGlzIHJlbGVhc2VkLCBhcyB0aGUgbnMgZGlzYWJsZSB3YWl0cyBmb3INCj4gYmFja2Vu
ZCBJTyB0byBjb21wbGV0ZSwgYW5kIHRoZSBucyBwZXJjcHUgcmVmIHRvIGJlIHByb3Blcmx5DQo+
IGtpbGxlZC4gVGhlIG9yaWdpbmFsIGludGVudCB3YXMgdG8gYXZvaWQgdGFraW5nIHRoZSBzdWJz
eXN0ZW0NCj4gbG9jayBmb3IgYSBwcm9sb25nIHBlcmlvZCBhcyBvdGhlciBwcm9jZXNzZXMgbWF5
IG5lZWQgdG8gYWNxdWlyZQ0KPiBpdCAoZm9yIGV4YW1wbGUgbmV3IGluY29taW5nIGNvbm5lY3Rp
b25zKS4NCj4NCj4gSG93ZXZlciwgaXQgb3BlbnMgdXAgYSB3aW5kb3cgd2hlcmUgYW5vdGhlciBw
cm9jZXNzIG1heSBjb21lIGluDQo+IGFuZCBlbmFibGUgdGhlIG5zLCAocmUpaW50aWFpbGl6aW5n
IHRoZSBucyBwZXJjcHVfcmVmLCBjYXVzaW5nDQo+IHRoZSBkaXNhYmxlIHNlcXVlbmNlIHRvIGhh
bmcuDQo+DQo+IFNvbHZlIHRoaXMgYnkgdGFraW5nIHRoZSBnbG9iYWwgbnZtZXRfY29uZmlnX3Nl
bSBvdmVyIHRoZSBlbnRpcmUNCj4gY29uZmlnZnMgZW5hYmxlL2Rpc2FibGUgc2VxdWVuY2UuDQo+
DQo+IFNpZ25lZC1vZmYtYnk6IFNhZ2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+DQo+IC0t
LQ0KPg0KDQpnb29kIGNhdGNoLCBsb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlh
IEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K

