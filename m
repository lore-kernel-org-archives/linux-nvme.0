Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 651FECE8D6B
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Nov 2025 01:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8SDnw61nVJHOwsuFX/5kRlxgluLRui6U8tZYxojs5Ds=; b=0rm03g1ugIhxXp6ehCAgBm/enV
	/q9fZqn5c6KHw46yoClnO/DtPHcPEXCtMqSH8QgymuSCq6RTTgy6QknXqpsjzspwf83Wmw2g8WDdw
	9YOFVUieSVxmhQwBDBx4PTjhyV3wIWrv5JYNZuasER9lexoDtJzQ7Wsfpqnh1BggE6nOF/r5Pr9m1
	nZJJkRK31194j00FwJGrzFwGBrpql8w+jkRzp2Bwvip17WvuPnARYcXPBCr+JD0IO6xqtLxw1eBTq
	V6d1ctmipfXeORih6UcGxbo24CQ3xnXfGsubdbmA7cV6w9B/WpKhb2GlmgCYXiC47erMpdWhNZxDu
	TuiWeW/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLAo0-0000000HAkU-37cG;
	Tue, 18 Nov 2025 01:46:52 +0000
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLAny-0000000HAja-0FgY
	for linux-nvme@lists.infradead.org;
	Tue, 18 Nov 2025 01:46:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qdmjUYeVqZXlndrintumrrCUSZEKXAMWAU2ViJeawLhX9yb8C4h/0w3WioBlJdylvbRAnO6+p5PVrjZs9O7/nLqIeNfjiwUXefkLmFNJu0Kmdz7dm6lF9xgQQPoCldyN6YZK5xvPUw8uoUTJOujW1UO7hGc5mJOEweTVKFbGiog+VODSErM6dNrnkh2A0NAXtOlRRkgDiaWRjuw6jkfcH/vuqgnDsxLT9AZKkC0Yb5o8NkDkZFc9Y2bSou0aanQZwonjznfFH6/7xAhJcN4/1nOFrh0U/5P65QA8rHmFx0f+tsWkXC7eCg6Khi+OIKuMCCxM5Qv2yyEhipzrkEFB1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SDnw61nVJHOwsuFX/5kRlxgluLRui6U8tZYxojs5Ds=;
 b=QdayFcsQn6gpDM2nEwXlbxsbCaL0UtFQdFJeEJfYJK211iYEz4mvC7hYFF82kVu3RrMNb+G7LY1tAeiYS0w9ws8JM6UQVIShd1ko2TxxYVdgZiPXKAWXlchDj4nbrLy+CmmXPLJEf1M9VTQyVhc+QJE8BwnsuAZFo0QpRnlHYjs10ScnCRrmg3z9H3rgnHL8Na6qSkmuqjaqwk3LybEDAJM5ia8494p+60j3nhSJQOXzairBVa4kQrfuX8+dQu8TMdoPUqjC6vyERbty3WCGvIGbo+oFS9CEl10P8WQSxHW0g+EluXInw3A+xGD2E6ycVkpvQm0y509iRHvqv+xEcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SDnw61nVJHOwsuFX/5kRlxgluLRui6U8tZYxojs5Ds=;
 b=WCzYN5mVsynHnf+ZhCRf4NthhSLFsAMZYKCd3QngKiQZmDrQvwWm4hZPFqlh0d6YEUndxTiC5E0B1rcCTnLCpoYHbS2xYluqBWZLiXFtVogX+iVp93DuIdPqNZzOVXQAggqJVDO87HfhhcMi6WWDyYPPQ1/Y3qtIkV1WUjxmqmCwa6GUVS0KbAJgQov/SMkiMK+dSgkbMDtI1KX56uXw+hwMTMFQ9KMh6p7z3hLU9VzRSaZZcwkYKe8hJY3yUQxjLI6iTM+m+to/oHebPdKYrc9O4BqQuRXbANrJDY3AJWLGKbpH4q4SvV0LxKsv7h9J6lffiFORPu3FxOhU6IUdtg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA1PR12MB999083.namprd12.prod.outlook.com (2603:10b6:806:49e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 01:46:45 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 01:46:45 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: John Meneghini <jmeneghi@redhat.com>, Maurizio Lombardi
	<mlombard@redhat.com>, "kbusch@kernel.org" <kbusch@kernel.org>
CC: "mlombard@bsdbackstore.eu" <mlombard@bsdbackstore.eu>,
	"bgurney@redhat.com" <bgurney@redhat.com>, "bvanassche@acm.org"
	<bvanassche@acm.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V2] nvme: expose active quirks in sysfs
Thread-Topic: [PATCH V2] nvme: expose active quirks in sysfs
Thread-Index: AQHcTNBu2LgglWRBSECkajfGZRtMgLT3hOqAgAA72YA=
Date: Tue, 18 Nov 2025 01:46:45 +0000
Message-ID: <b1b0f867-5c1c-45b9-ad8c-2fe31d84a187@nvidia.com>
References: <20251103144406.1148401-1-mlombard@redhat.com>
 <88864e05-c2ed-4dd6-935a-d2346b54cc44@redhat.com>
In-Reply-To: <88864e05-c2ed-4dd6-935a-d2346b54cc44@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA1PR12MB999083:EE_
x-ms-office365-filtering-correlation-id: 9793b9d3-4035-4579-6842-08de264454bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?bGgyTk1EWHZaZ09IQm1uY3dGa280QUZ3QXNSaXc1THpwM0k5Q28rZVE2ZFdr?=
 =?utf-8?B?YkhCMWV3T3U1WkRJNnFscTZ5eHhpSnZrOXN6UzNHTUQzbU5SVUFyVDZwVHov?=
 =?utf-8?B?eWhBZUFOVmVZSWhSV1JhYU4wWUdSUEFzQVVPYlkzZHN5ZDNpa2tyR0d5VnhL?=
 =?utf-8?B?YzM0VDhTT2J4dVFGVzNZVVl1cGZHZDlTcUQvOVRSTjA4QWIxOXU2aTdJcUpB?=
 =?utf-8?B?TlZoOFZiT05kS0tvNUN6M25pSVVYM0RHanlIcFpuR3d2WW1hdE9jR1hINWht?=
 =?utf-8?B?OEp1cGluMVFKYklkM2xCOWI3UHNqS24veTc1bkpQcURVNmszRHRKc2loK1Bn?=
 =?utf-8?B?RGhkWmxxbGhxTkVvblZhTjBJd1BQTTFFWnR0WEx0cEFZZ25aVGRqT0VoTDJj?=
 =?utf-8?B?THZ1NUU1NVZySW9kekkxbGxuNE1FeS9BZTJ3eWp3NTJXR0dpdExrUUZMbnBs?=
 =?utf-8?B?Znptd01Sb0dEOG9VMjRJK0p5anBvRUYrZWxJTUVnbGJ4VFJHTlRLUjdSSFBY?=
 =?utf-8?B?YUFxTllHOGRlRTFDMkRmMkFlZFVZUTNGWUQzeWhRdm5hcEE3ckF1MFErRFpH?=
 =?utf-8?B?WEpQSGl2Z0FtZnpwMFB5WUU3OUN6ZHhFWnA3WnlKWFhLZm12elZFOXdpYVVN?=
 =?utf-8?B?K1RCdGZrRXVaRDY5TUg5T3VHUlhjdWJ3YWJWL0xnbWpRYUZHajNmSUZyMzcr?=
 =?utf-8?B?bkw1UUMwZkJpSDBCRHhMQnVSNVAyRHZHZUNKRDZ4V0RwWWFLeXVXdysyWkZs?=
 =?utf-8?B?TkV1TUVOcnZQSnpXQ2VZdEhVaWsrR3UxSTB5N2ZmT1JhNTIzVUJHUjE4RVFZ?=
 =?utf-8?B?emd0dE0yMzZOUlhxSGZpbzNQdWVWWnNKTnpTOWZOdnVjM2ZUS2J4TEZXZDVx?=
 =?utf-8?B?SkI5SjM2UGdFcjc4ZFluODhEVHZXQndleUgvUmtGb3I5aEZxSUpaQ2hlMDlH?=
 =?utf-8?B?RXZTdW9oTStpSzNOdWZFNFJsK3A3OUJmNXU5b29adnhtdHVmOUxJeklVUHFv?=
 =?utf-8?B?elRENXlxNlI4aUFyU2R5empiNE1QRUwrc3cvK09ZVEk1TDF5c1NaM1Q1Y2tI?=
 =?utf-8?B?WGgxeWFNYmIxcXhoOVdDbEg1NFBCaXZCcm9sZUdIU2lWMXJlK2JlOFp3bFkx?=
 =?utf-8?B?cnhvUUE2Z0dKNVJXMktwaVNNdXU2enJyc3RFOWl3NjZkNEc5SnhVbWlOd0lz?=
 =?utf-8?B?QUozL2psbHQ0N3BVbGdpaDdManpiZ0pQS012ZTZ3b1Q2clhiQVhoM1lHOVEr?=
 =?utf-8?B?anpsL3pXcVJVUmxwU3NjcFkvMi8xY2ZkWTRzMGQrMlpuWk5iL2ZXWVdsVFhM?=
 =?utf-8?B?Q2lQUmU4eXh4NlV4T0t1clh1SmVSalp5MmJzTEx3Wnl3ZTd6UDg3eXd3dEdL?=
 =?utf-8?B?NmZ3YXBUZnU1T3Jza2Y3S0s5MC9NUUJ6ZXNIc09LcGgrTndQcVBNcy9kVDJT?=
 =?utf-8?B?Z1hmSDhYdjdpU3BoRE12M3daY1drRHU0enFEbVgwL1dxSEViZkp5c29HSkZC?=
 =?utf-8?B?a3NkcEhUMHJJdjdEcitGZ2JKVnpkMlZWN3BKRW14enJSMmxRejNsREtRUE0y?=
 =?utf-8?B?TkwyUGVSZlBEZDVqZzhVUm8yMG5jb1FRYmxBU3ZidHEwMUJudEdBeUZIT3Rj?=
 =?utf-8?B?NERQNjRxMlMxejU4b1lJc1NCRWc2aU0vVEtNQ3AzUHVLVVNGK2FWSFE5cG13?=
 =?utf-8?B?d0U0NkNtM2ZqUkNHbDFSZ0l4WEdZSlJ1NDRSQTNDVXF3d2NnTmVpTlUyVWp6?=
 =?utf-8?B?Q1djSUlzWjZsOHlBMC9DUW1YNGpQQlk3UVc5WnByN2owMCtQWGVncFFmcFVV?=
 =?utf-8?B?NjBNbGlnblhsUFhxTWpVS285Qkh3dERQQy9IZys4aXRDd2JaQXFsQlpYR0xT?=
 =?utf-8?B?ZXUxdkhtWEpVWGtBMUFpTzBIMVlFNy9ZV3FlTEtzd0MwOUN4ZUZzYUVWbDkx?=
 =?utf-8?B?Y2phYnhYYWhydWZQanhEODlubFRzRXJrZEZJRzZRZGFyZ3dqemtSaEtHakpD?=
 =?utf-8?B?SVJHZ1ZwL09jOVRtc3pWQ2lFZGtOb3FGeDJWeFVkUWphUTFQS21wbDMycHYr?=
 =?utf-8?Q?UgWdlv?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTFwUVJ1Y1BTaTdOS2pBQm9aUWVnZVNKT25MUWpNRkFUYmhXTmhIUk5DRFRB?=
 =?utf-8?B?blFZOUYyYk5Pa2dBMnV4YlpDZFB6NkF5RlM1dXBwL2ZyVUhTUzZVbFZSbTBs?=
 =?utf-8?B?Rzk2ZzY1MHhQbTYyVU5xcDFxVU9tcGduY0NSeGJ4ZXhvQzR3c05rV01IZDJs?=
 =?utf-8?B?dFhRRk45TFl3SFFFd0pVQzA2TUJRL0I5ZVFFaXJyS1dHTmdLSWVYQWsyMm4x?=
 =?utf-8?B?TGY4MWt1aVNSM0s3Skdnc2xNWE4vVGdnYjlKR2M4RFI4Skp4MXJVMzN1TmFw?=
 =?utf-8?B?RFM2WXE2OXU3UlE4ZUtMazdjUXZmMFlUcFQ1T3lNNy9UUVJKNmRUYnRneStQ?=
 =?utf-8?B?alliQzZHanJFQWtOeVk4eDR4VnhUbVI3YXBacWMyMUczTHcxSDFRVWRaU3Qy?=
 =?utf-8?B?MDRwNEpuNWNIa1YxTWNjNDR5RFlOcldaUWUvdVM0QjdqV2paZW1QcWZrV0I4?=
 =?utf-8?B?djdzQm5kQWNZc2RyZFhzK25RVllmZzhBMi9ZajRXT2lOU2d3amorOXlDLzJX?=
 =?utf-8?B?V013YWtEcmZlelIzcTA4UjVjeEQrbWlqdlA2VjdZUG5MV0NwbmZEc0NqbzJo?=
 =?utf-8?B?bDVOdzIwNkZ4cUMzclhoMFhsSHpJVUZ4NFUxc05CdHhEeHplNS9HdjhKdjBs?=
 =?utf-8?B?ZEFROVFHTGwyb1ZIVzk2WXNUVG85eEJSZjRORUhyTlZvUUIwL1dQUUNYQ2E0?=
 =?utf-8?B?VFpPSm5IMjQySUpOVDJiUEhWMFdhN25QczYrRkFENlNYdkhVajRzcE9SMVVz?=
 =?utf-8?B?OFBzdTM4OUtQYXhoVmhoTGxIR292VWpFUXVBcVFObEVYN2lTTGlkNW9NbnBJ?=
 =?utf-8?B?NjF1WTh2dDJ0dXB4M3ZaZEVkcnRXcXQxZTIybTNyNk93YnJOd2ZwYXk1cTlZ?=
 =?utf-8?B?SXAyTXhxbzArT3E4aXZ6cStDVC9DeDZLSlBMOVRuYUdEZUNpMGR5bFJySWVZ?=
 =?utf-8?B?bEExdWhLY2QzSVgzamtxeVdsRVhBV21qdWtIRW9xalRHc2R3bFcxNUFxRjhC?=
 =?utf-8?B?Tms4anVSRlQvelNHSDlFQ0V2QytxSlU5MjkxeTZnWExTY0pXOUlTR21TbWxh?=
 =?utf-8?B?djVnbkRnU3dSbnptcTJyS0s3L1NGV3llSHI0ME9hT3htQ0xHeXhxYksyNkJh?=
 =?utf-8?B?T2xkZWhQMVBncEdGWkc3YUlpVnlBT2tlYStIRTRvQWdYSnY1MWxhU1dBT3FT?=
 =?utf-8?B?VnVIRytDNDl3c1dYZVE1VnhEMXJDalFORk9PL1FCSnpaL2k0L3BJaStYRkhp?=
 =?utf-8?B?K21ray9wOVdSa1hxODZBcEt2dW91Tk1KeFA2dU1pUjV2L2Q2VkpIbm1ZNEdO?=
 =?utf-8?B?MVU3YmpTR1Y2WXVuYlNncWVhaDlXV20yRlJFQWFaMTVVQnB4MjRXSStxTUNs?=
 =?utf-8?B?TlQ3MXRhRHY5anlMaDRUaDF0cFpvYkxmL21OR2xEK1p5dmpyb2FucnlGZkRM?=
 =?utf-8?B?NlpHTXAvN1A5RXFsT0lhMUs1S3k5N2RZUmtnZGYycmRlMWlDNkUxbjFOa2Rm?=
 =?utf-8?B?aUY4MnBlZ0xDRTFmcnF5NWN4cUg1a2l6QllHYWNTU3ptQ052QmQrWHJrMXo4?=
 =?utf-8?B?QUtYakVQVG5EWnA3ZkJyRnV1U3hwU3k0c1JuSkZVbDV6ak1nbzdzTGpQYzJ5?=
 =?utf-8?B?WXI4SDFGdmFMV1JzZkVYZ0lwcjVnTDBFbVVTQUdnYThkL2pGQ3ZMRW84Zmc3?=
 =?utf-8?B?dzgvcHMzU0tKVGdQVjRndmdRb2NUeHZmTHg0YkFhUEJMZi8xMDNoSjJZbURQ?=
 =?utf-8?B?Z3JzTWpBZ2NBKzlXOFQ1OG1IZHg5bFRTdlZtSEJrNGxmYURQYzdlck1aUzIw?=
 =?utf-8?B?bWxMQ3Q3NTcrREVnY0dnQzdGVlJjSTcxUzY3UDlVQkV3N1V3QUxETlhMOGZ2?=
 =?utf-8?B?SmtKQUo2Y3FTQzNBdzhUNDV4RzRKOVEzelRzQUNuTjBsRnVJWThXZFlOMllX?=
 =?utf-8?B?SHJBTFAzWld0a2FMMVFLWGhZVDh4bkRkNlYvVlphL0RVS25Pc0FaMEtHcldL?=
 =?utf-8?B?dFdRLzdzVFRGYmJPOWlpRkRvVkkzSXFaWDNBYm92OU55enZvTUxBSWw4Ylkz?=
 =?utf-8?B?dE1hUmRVNGNlek42d2tQVjBidnNDdFM5Nmd3NmdtRERuQmtEbnZ3Nmt2YTlH?=
 =?utf-8?B?enYrTkRYZTZ4TythcXNPSWM5RFdON2VWemRVTFo0VFFzR0dVdTV0TWFzSEJt?=
 =?utf-8?Q?IyKDMuZuKfUA4XiO35QLxCdCAif6bZ4CWQh8QKMFdMGm?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E249604A273A84BA51E6F925427A10C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9793b9d3-4035-4579-6842-08de264454bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 01:46:45.4377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yJAfI0jEtXKXt9kZz8hBu/Z5RTfhMMF6H2VrZAFrEyA0FSFHCdWzGnAFQOJdEekGMruDmgovjVt5IaM3ghXDUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999083
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251117_174650_100951_89AD8AD7 
X-CRM114-Status: GOOD (  13.21  )
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

T24gMTEvMTcvMjUgMTQ6MTIsIEpvaG4gTWVuZWdoaW5pIHdyb3RlOg0KPiBSZXZpZXdlZC1ieTog
Sm9obiBNZW5lZ2hpbmkgPGptZW5lZ2hpQHJlZGhhdC5jb20+DQo+IFRlc3RlZC1ieTogSm9obiBN
ZW5lZ2hpbmkgPGptZW5lZ2hpQHJlZGhhdC5jb20+DQo+DQo+IExvb2tzIGdvb2QgdG8gbWUuIFRl
c3RpbmcgdGhpcyBvbiBteSBWTSBzaG93cyB0aGUgY29ycmVjdCBxdWlyayANCj4gaW5mb3JtYXRp
b24gZm9yIGJvdGgNCj4NCj4gwqAgLWRldmljZSBudm1lLHVzZS1pbnRlbC1pZD1vbiBhbmQNCj4g
wqAgLWRldmljZSBudm1lLHVzZS1pbnRlbC1pZD1vZmYNCj4NCj4gcm9vdEB0YXJnZXQtdm06fiMg
Z3JlcCAuIC9zeXMvY2xhc3MvbnZtZS9udm1lMC9xdWlyayogDQo+IC9zeXMvY2xhc3MvbnZtZS9u
dm1lMC9kZXZpY2Uve3ZlbmRvcixkZXZpY2V9DQo+IC9zeXMvY2xhc3MvbnZtZS9udm1lMC9xdWly
a3M6MHgwMDA0MDIwMg0KPiAvc3lzL2NsYXNzL252bWUvbnZtZTAvZGV2aWNlL3ZlbmRvcjoweDgw
ODYNCj4gL3N5cy9jbGFzcy9udm1lL252bWUwL2RldmljZS9kZXZpY2U6MHg1ODQ1DQo+IHJvb3RA
dGFyZ2V0LXZtOn4jIGdyZXAgLiAvc3lzL2NsYXNzL252bWUvbnZtZTEvcXVpcmsqIA0KPiAvc3lz
L2NsYXNzL252bWUvbnZtZTEvZGV2aWNlL3t2ZW5kb3IsZGV2aWNlfQ0KPiAvc3lzL2NsYXNzL252
bWUvbnZtZTEvcXVpcmtzOjB4MDAwNDAwMDANCj4gL3N5cy9jbGFzcy9udm1lL252bWUxL2Rldmlj
ZS92ZW5kb3I6MHgxYjM2DQo+IC9zeXMvY2xhc3MvbnZtZS9udm1lMS9kZXZpY2UvZGV2aWNlOjB4
MDAxMA0KPg0KPiBLZWl0aCwgcGxlYXNlIG1lcmdlIHRoaXMgcGF0Y2guDQo+DQo+IC9Kb2huDQo+
DQo+IE9uIDExLzMvMjUgOTo0NCBBTSwgTWF1cml6aW8gTG9tYmFyZGkgd3JvdGU6DQo+PiBDdXJy
ZW50bHksIHRoZXJlIGlzIG5vIHN0cmFpZ2h0Zm9yd2FyZCB3YXkgZm9yIGEgdXNlciB0byBpbnNw
ZWN0DQo+PiB3aGljaCBxdWlya3MgYXJlIGFjdGl2ZSBmb3IgYSBnaXZlbiBkZXZpY2UgZnJvbSB1
c2Vyc3BhY2UuDQo+Pg0KPj4gQWRkIGEgbmV3ICJxdWlya3MiIHN5c2ZzIGF0dHJpYnV0ZSB0byB0
aGUgbnZtZSBjb250cm9sbGVyIGRldmljZS4NCj4+DQo+PiBSZWFkaW5nIHRoaXMgZmlsZSB3aWxs
IGRpc3BsYXkgYSBodW1hbi1yZWFkYWJsZSBsaXN0DQo+PiBvZiBhbGwgYWN0aXZlIHF1aXJrcywg
d2l0aCBlYWNoIHF1aXJrIG5hbWUgb24gYSBuZXcgbGluZS4NCj4+IElmIG5vIHF1aXJrcyBhcmUg
YWN0aXZlLCBpdCB3aWxsIGRpc3BsYXkgIm5vbmUiLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IE1h
dXJpemlvIExvbWJhcmRpIDxtbG9tYmFyZEByZWRoYXQuY29tPg0KDQpJdCB3aWxsIGJlIG5pY2Ug
dG8gbWVyZ2UgdGhpcyBpZiB0aGVyZSBhcmUgbm8gbWFqb3Igb2JqZWN0aW9ucy4NCg0KLWNrDQoN
Cg0K

