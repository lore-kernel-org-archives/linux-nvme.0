Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ABCDE65D2C
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2024 06:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uuf6GP0JT1SDPIGzJULiAxvIFTgxpOiGsvX543/Iul4=; b=XuSz59nBKtk6GdwAMJdTwaJlOD
	SNBRjvDS5YlZUTOgehFsxRvDAqI0U2faWrd7gZW5b5u06FVAvr3zoZESw4Q/xrRF/RJeVP2H1+NyQ
	cwpTKdAUu9DRLmuluRq0cxu1mPMeJW7qxVCwQgMmb/KciwhVOEMM0UUWNouUslCqVsanmzUeaKhao
	JRbn0ArScNjbzQV62u1LIp1gYYL+21S5o0Y/w25LyUTYXLun4DRvRW+lSyj4RV3DWwdKO+SIfqZuc
	lxggsfwV2BlR3Lj0FfolIDRRAJpVftu9YjsUUwT62pPhubITkr6kXQnJLrgCobyVGveqsZ96HSES7
	0jg8RoIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEN4o-00000001j9D-0g27;
	Fri, 22 Nov 2024 06:23:34 +0000
Received: from mail-bn8nam12on2060b.outbound.protection.outlook.com ([2a01:111:f403:2418::60b] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEN4l-00000001j8J-1LFg
	for linux-nvme@lists.infradead.org;
	Fri, 22 Nov 2024 06:23:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHhKrtKXIjg1OBpnnO6+GGKxkvGzZokMTg5OimUqvHX51IThunxIS7Vdqb7cszZUEi58C1QKP6qyg6dwRU9q3KB4R64AxMSk7NRXKKqYmV47rGMtAfeEKJ1W95KTG+7lwzd/at7InW6FqnWHnRnDeVyE9vt6mZ+EIsgkPCxAYWX4ivhFPcB73JkeegWPDmEAsjcCYnjRmwHyUpnsVYC+6YcpNEXrOSAjcP2kPesxAqTEBzTL968fqYVRE8HvzV62czAop6f0VrSSdOcQ1A2UKtUTulx8ZXVhbhvr4Q/5BfUeNOSb1+g/MVztEhjhn5oDAehHfsF/IkT+TKLBf6GDQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uuf6GP0JT1SDPIGzJULiAxvIFTgxpOiGsvX543/Iul4=;
 b=uIZrvJXQmRxfQ3NP1b/H7t3bifcFzxRtgGvfxoqGPKz8r42W9kB6H/4S8bvgQyYeOlbtjpF4v4XWhWgYjn41DglxOXZpAKfaMa8br42SESxETVi9cNHF6OH7tuhsDLLz+D26i6NxZ6Mu/WxRQPqli5xn1HDo0/cM2HmcCglyd27wcWg/MSpbMGcGF2NcDRPHCjooMVmvW8NEJbvdjtD8FLPrxS66TByGxrcZsq3RvYIV+1uMHa1JMSzSGkONU1rJXxtoCWEHiPuxxjArMM25UsDMvvu5yQeX68O0NqOESMJYkzvXQ8Fx6aLytZw1olNYVNF3DknTDD24VbAw3aNcVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuf6GP0JT1SDPIGzJULiAxvIFTgxpOiGsvX543/Iul4=;
 b=JsZXwKgLGZUzf3PRfdRaUQdsrTjvyuf2CGpn7in43i8QI08eDP4WgeM8H8RfphAb+E3/uZPLYYn8axV6v5jjD3gj8CphJ8ykYVH7JegQ4OSgy/aliGGPqiVfhZR3kALljV/Hh1uMfVhlJcbJnLMOCJHtFeOa1C8oYYf5GIgwsAk7p+NdrZ+KpdZuO4jSZG5wYrB0uH0QTFpHwUq3tKaUGxKAdAPw3M2j4rG640oQ4KmHx2RtkaAASj58WWqMLx58SYNIhj4AdSVplzarRHdmB8wrLZ8E17909fHh8IgPBzZ+goBxROxmaOK+eWFe+QmSVMaUnG8CrUcYG4lrkBmmIA==
Received: from CYXSPRMB0008.namprd12.prod.outlook.com (2603:10b6:930:d6::9) by
 DS7PR12MB6024.namprd12.prod.outlook.com (2603:10b6:8:84::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.20; Fri, 22 Nov 2024 06:23:19 +0000
Received: from CYXSPRMB0008.namprd12.prod.outlook.com
 ([fe80::6c94:72fe:5ad6:97ae]) by CYXSPRMB0008.namprd12.prod.outlook.com
 ([fe80::6c94:72fe:5ad6:97ae%4]) with mapi id 15.20.8182.016; Fri, 22 Nov 2024
 06:23:19 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>, Christoph Hellwig <hch@lst.de>, Sagi
 Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Keith Busch <kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvmet: handle rw's limited retry flag
Thread-Topic: [PATCH] nvmet: handle rw's limited retry flag
Thread-Index: AQHbO/+jpq9Yi90z70yA4BqJJ9YgIrLC1gyA
Date: Fri, 22 Nov 2024 06:23:19 +0000
Message-ID: <d4fded39-a47d-4a82-a519-7d260249e019@nvidia.com>
References: <20241121102454.122247-1-kanie@linux.alibaba.com>
In-Reply-To: <20241121102454.122247-1-kanie@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYXSPRMB0008:EE_|DS7PR12MB6024:EE_
x-ms-office365-filtering-correlation-id: 237759a1-6719-4187-c87d-08dd0abe2878
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZjFwRU81OVlIaXVpSTdmaFREaTJXbGF0eGY2U3M5MkJxM1d6K2hHY0xOTnB3?=
 =?utf-8?B?cFdrS2JCaXpZRXlxL0g4VkxzcVJMM2x4b0pBSTZmKzQySm5OTkVRd2hwRkNQ?=
 =?utf-8?B?em5Oc1dGNXJTQndOQk9MUHFWemRHMXNQQitUWlR4QjdZWnBsZUxzR1pmTnpM?=
 =?utf-8?B?SFdqR1Z0cjlNMjNkamhrRkkzN2h2cERSYjdYcWg5TFVDVVdmSTlLdHBYUUNx?=
 =?utf-8?B?ZjA2eHc0Tk9aMUlHbWdXcVBqV1VKbWwxVFhKdlJWeDNUaVZaRDg2OXN0TVdO?=
 =?utf-8?B?cmY0V2pSZFBmQnVjZmJXcXdobEI5MnM3SnJVdFB2cWhTbkVlYVZNYW5HTmR0?=
 =?utf-8?B?L0ZRSUl2a0MwL3R5S0t3S0pKNzY2WDhadmhjdmdrV09iaXZoWXRWOTk0RUFD?=
 =?utf-8?B?dTd3TWZ6WFBhTG1MTTRuM0ZNbUNHMlR3ZC8rM3Bvb1ZXN2J0NVh4VkJlMzNy?=
 =?utf-8?B?dWtBS3hKMzVQQ0UvMytOMjJjcUhPeFhEbWliVzYwOXk5VlQxeWx1Ti80VHo3?=
 =?utf-8?B?eFVlTi9oS0dNcTFidWFWOE94S0QwY3VSZWREL0lnTWZXanlLVjlpcXhmY1ZI?=
 =?utf-8?B?bDF6TFhKRFV6LzdUUmFIazdLekVFY2VXTzh1ZkhESkpURm82Y04vY2tiMFc1?=
 =?utf-8?B?R3JmNVBsVlVoVlgvWGtxSE5BT0hlOHNlYmJtRmhxbDdYclpyYkU4K21Oczlo?=
 =?utf-8?B?OEtSUlR2OWwxOWJjb1lGUGIwQ3BwWkw3dzBZanJZempVN1dTUzVoR1NzaVlM?=
 =?utf-8?B?RzhNV2xTRlhUVWw1RFhjdHFzYmNCN3hyUlRYRDBHUnQ2RW1vVXhJcFdKTU5m?=
 =?utf-8?B?dk03S2xsLzNBTDBmckRYMFBCd2NSRWF2dmlpNW92aXBpR3J2clA0VUowZmE3?=
 =?utf-8?B?eUoyQ0phNzV1TDRIVzRLTTZReVRyS2pJZHAzMHVEdHlZeEdiM2liemRRYThO?=
 =?utf-8?B?eWozQ1c2Nmk1Nnloc1hzVHoxV2FlcWdkdnp0RWQ2OGFVQjNWL2k1TDE1c05V?=
 =?utf-8?B?SnBxbTlxUkcveXdTc2tINDY3MVJ4cVMrb2JBblhEZ2xnRzBiUWUxc0RBbEcy?=
 =?utf-8?B?elhQait3R00zL2FJUEhlcmlBQzJiSmFHZ1ZEbWY2QlJsNVZBOHpCb2pHbXBZ?=
 =?utf-8?B?MWNFREJsdXdvVFBKNGt3emplYnR3WTVxUWNmanFnS0pMbldjVk1MMElpQ3R2?=
 =?utf-8?B?eTI3eUpaZUllbEtLNm1heHhpZHZpZm1LTS9NUGpkSmFOakFJZGo1NWRqWVhX?=
 =?utf-8?B?VUxhZ2t0TGRtT09ieHREbEZHUjQ4K1pRTXJqckw2UkdxTTlraDhyb1JlU3R1?=
 =?utf-8?B?Umh4dW9qNFVkb0szbzdFbUhXbzgrTk5BcHVWT2Ficm9PdWlhNTEzYlR5T3Jz?=
 =?utf-8?B?TW8zRTdEZCtBTFBZQnVuR29BNG5sdGhXdnJoc0o2amg2aDdxVHBTbWpJVmxY?=
 =?utf-8?B?Zzlpd2ZXQmFrUFd6VDUrMk5GNjJLb2RGTHZKZ21Sbk1VZ1h1ZWl3K3hNdDVn?=
 =?utf-8?B?YkU5Z3hpQ0tLbC9SbGdya2JnM3B5MHRzckVtc3dVeE14YmthZTBoUmxLb3E0?=
 =?utf-8?B?S0Z6VnlxbWlncTFPcmVXUHo3aHVtbVAraUd6SlpXUGNTSFFSNHdCWmYydjFi?=
 =?utf-8?B?VXRKb0IxYWJhRGg5bG40VEcyOVhqWE8rOTBEVTJHek5wRlVxUVUyWXpmSE1X?=
 =?utf-8?B?QXNlZVNqazZFamhaQmtrbzJicjhISDdCWVJtRXJaTllYcmFMWXlQa2I3dkQ5?=
 =?utf-8?B?L0dGVkNUUkc2U1g1UXJ6UFlkMk5mQkxDUDFMTUJGaSt0dzFsbUpwM3IxNWZU?=
 =?utf-8?Q?NAv74uIjE3yAxuO6GT7aXraDN2qcc9CYYPPuw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXSPRMB0008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Um9Eb25ROXBnekxpRHJRTTZ3ZUI4TGM2T1E5NURrSDFDNzRLcW5XemNvdVVs?=
 =?utf-8?B?L0dueGM1T2xMMDJmanVnSG5ldUEzY3JEOVBIbU9sMFFwd3VvZ280V3dPaDlp?=
 =?utf-8?B?T3k2V3diZlNtd2JMbWZjT0Y4aEZmRVpYK21UU1F3amtxQ01seG1icHM2dkFi?=
 =?utf-8?B?S3FiNzFCbFV0OVJvWUJLcGJNNUw0Z1VNVThqS1NQTWxHS3NLZ3Y4S2UzTTN3?=
 =?utf-8?B?SEZvK1V1cExCbG41dVJWa1N6cnh5djY3Ymxta3dmUUlmdkwxZzdjNzRoQ2E2?=
 =?utf-8?B?SDlBdDNadW5FSWdDU0t2TmhxNUxBTlNzUXpjUWppMVI4OVQ4b1JMMEpkYkFu?=
 =?utf-8?B?Um9OZEg0cEZVaGlCdTJwd0hxaEp4WTUxWEtBMWljSVpqTzdpcWFkSGNDT2Zh?=
 =?utf-8?B?RThtTWdvQVNRamtQalo0cUcwRWNmbFNaS3A4QkNvSVFwQ2wwNkNPWGNFUnFI?=
 =?utf-8?B?c3FvL3Z4MlFjNmFaWGhHTHdzaWhLQkVQMHF0d01QTUwvTkFUbGJHdS9hRjlo?=
 =?utf-8?B?dHdySS8vUE5uWnVVUHVnS3R6aStIU1V2RmZ5b3l3bXY3NDJkVmloMEhTbkZF?=
 =?utf-8?B?eDlKZ3hlQncybkJTeThweG5kdVpGUGhSSGlqcFFyYnhCNWhOem1kNmdGYnRJ?=
 =?utf-8?B?bERXVjF5dmRHRjFUeWFwbE1idW1hQjQ0eHRvOVFOa2w2aXNha1prUUl5QjZJ?=
 =?utf-8?B?U2h4QXFuOXhrU3dtMDBqa3VtSHlQM0FtNWtabDk0Z3d2UmRaM1NTN2RHY0x0?=
 =?utf-8?B?a1dvaFR1WTl1bzFidkxLVWYrZVJPMHhXbzRuaGxTR3ZkOTRrWFhvdHdmeWNV?=
 =?utf-8?B?OUJ0Q2xvQnVTNDBURG8wSmZ6VVJBTnlCd05WTGVET1hEUnJVekpVcTlEZDhE?=
 =?utf-8?B?MUtoZVVIVjFGanR2bzBGNkNYclVhd2NDYXFtWU9BdFNlUndFek5oRXowMjZk?=
 =?utf-8?B?MzJLYm5XNDVlREVrQkhzMGZsdjF1emZmNndyVVJMYXNDb092aGRUVWpPUzNu?=
 =?utf-8?B?T0xGVnQydzdmT1dVUzYraXZIZlVnTWFHQjFCTkp3YTdKTnBvL1J4VzVZd1FK?=
 =?utf-8?B?UzJVZHFTTUVqWEJ6QXlZLzU0dVJSb1NycnM1VlBaSUFYWC9TUUYrSDZTUzRK?=
 =?utf-8?B?Y041ajRvYjU3T0JHeGVDcUVCMXNSR2t2aHV6VFk4ZkJxUXdwYjdrN0JzeGxa?=
 =?utf-8?B?ZnlnTi9tTS9vc1FucmRxL1ZLOGkzME8wQ3ZUZU5IYkkwWDUyZ3NvbXBkSlNt?=
 =?utf-8?B?NW1jMWcxZGVTNklmTTByODZVazVoNlRWcUpxQkxTUm93azR4UlNtSFpSTnZP?=
 =?utf-8?B?eVVsNnpPWlZ0NzdTOHB2dUZXU0hxUkFWOVVwTzBPbEZlUHFCbSt2TWhhdnVo?=
 =?utf-8?B?WVFRSUpFdUk2b1B4WTNaSHhVMjVvdEIzSTFmcjFmM2h0YnF5aWVLcUpxUGpD?=
 =?utf-8?B?RDVVK01PaExtMXVkeUFuLzBQdWI5RDMxbmhPWStXOEJabXpmUFVJK25OMVI2?=
 =?utf-8?B?aGlJYVRmb3JGS1RlRm1MNnlvdW1zMnMrcnNpZXgvSVk4MGFyQXZ4ejBkYStw?=
 =?utf-8?B?ZGZYaThJNzZnZHVxWjF4c1ZnNVdOUlBwMHE1WDJsMEVFM2d0SThUT2NqRGR2?=
 =?utf-8?B?NmZvbGZUZGYzWjVhWVNHbjV2THZtbENWaFl5NkVWTGtYWkFIM0pqTjk0MWRy?=
 =?utf-8?B?cGhaRE9IMjdPeEpZa3dETlByczZNU2dOa0hmZkpxdkh5bmVyS1h4WTJhaUNW?=
 =?utf-8?B?R0lmMmd5MkZkZDVadVk1cU5PTEFmOHI2Q1ZXbTFkNms4UWlOSkd0d3VKUER6?=
 =?utf-8?B?cW8rbDdRcWpvSDJiVVZsbU1TSWNOcEF3SmhBRGFMUk1jVlZocFJHdUIrY2Qr?=
 =?utf-8?B?RGp6eVU5eW1wRjZqcys2VXRXaUNsNFFYQ2ZEdWxiZHZBM0wzYzVsTmRJQm0z?=
 =?utf-8?B?YTU4bElGb2JTRlFNc2Y0dGYzV1h1Yi9HRkJ0dVB2WTl6QTh5TVp5VkJvS1kr?=
 =?utf-8?B?ZWhLa0U3VHBIQVdvd0tPYW9ZaFRlMmVUU1pkZ3lsOUlVcmlGenRFblBvMXNZ?=
 =?utf-8?B?dE5MSmtTazI1S0p0aFAvRzArdWlOamtwOG92QUphWnZhWkNDdG9DMWYwdzVu?=
 =?utf-8?B?MkJ6VkhqOGVNYmUxZ0VuWk9leldLVHdXckdNWFlDbVJxUXhnNnFjd3orckxB?=
 =?utf-8?Q?BpHo9FpFPJZOyadfqUL5sGNezCAay5lvJ/43IlkbIwtF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F67B12A9FDFF1A4BAEB003793BF8A134@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYXSPRMB0008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 237759a1-6719-4187-c87d-08dd0abe2878
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2024 06:23:19.5153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TZuyHkLSH3Nwo3Gu+QRnlke4kOPflOEp4GkFH2CeOYJPK0Vf0x+O2pxha27m+kykIIOeQ1WwmP3ss8/kfi58Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6024
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241121_222331_369403_CCD89989 
X-CRM114-Status: UNSURE (   9.22  )
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

T24gMTEvMjEvMjQgMDI6MjQsIEd1aXhpbiBMaXUgd3JvdGU6DQo+IFdoZW4gdGhlIG52bWUgdGFy
Z2V0IHJlY2VpdmUgYW4gcncgY29tbWFuZCB3aXRoIGxpbWl0ZWQgcmV0cnkgZmxhZywNCj4gaGFu
ZGxlIGl0IGluIGJsb2NrIGJhY2tlbmQgYnkgc2V0dGluZyB0aGUgUkVRX0ZBSUxGQVNUX0RFViBm
bGFnIHRvDQo+IGJpby4NCj4NCj4gU2lnbmVkLW9mZi1ieTogR3VpeGluIExpdTxrYW5pZUBsaW51
eC5hbGliYWJhLmNvbT4NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBL
dWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

