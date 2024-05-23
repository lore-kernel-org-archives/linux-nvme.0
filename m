Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8C4C25B75
	for <linux-nvme@archiver.kernel.org>; Thu, 23 May 2024 04:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G4iSH4S+dAw0ALjUtN16Bct4cGFa77jcep3Ac93fx5o=; b=QFiBRz2th2pzzHUXtg4RqR+IVH
	yZbZINO8ohvl9OhmBft/7azWLyd0ANxu8OpA0S0atd3nctBvKwOCs08AHz6nqR+xLuu3KK8TRG/17
	F7QSmDJOeev3pwMZ51hEiN45OHxd9bcSeRMg07tRSO4nMSs63GJiowVPDzs6qH7XoUSt00F7yeXUq
	wVFI28cyLAc6HZCRiWxrXdrPcYaopIpmYcz8qRFjXD5a8ffMQb3Ok/qxI7mz2KXyfYcbARkORF7Zq
	TZIkRpFmlqUtb99zJUSVO1Zj5IZHCwQwEAR4+LHA6Z6MyGRNiudjfoaX20uq565PqoRE9L7NRgWuG
	nJqmwzqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA07l-000000050NE-1GBy;
	Thu, 23 May 2024 04:32:17 +0000
Received: from mail-mw2nam12on20600.outbound.protection.outlook.com ([2a01:111:f403:200a::600] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA07f-000000050MM-21Mu
	for linux-nvme@lists.infradead.org;
	Thu, 23 May 2024 04:32:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVYDKwyQ1Rjv5i+VmK75ym/MbqImOvFyC/bX8LzekF+CEki1jFhgubp60zVYPxA2TbooSsRtGKHxsZtzpZP93pwLTbEJk3zCTfcisdBysuMvHa2IftpNbSmIIIzuK+60SaIMzlZHm2mOSlDV7m5zd4kNRchwBPIzdrxbZ4HLtRIqmzfO2GITiaI+g2RlYJDam925/PniZdp62OcHtUH8FjIY9rR5XPEzS8oF/WnK5yvxFN4EZZKdnsD+yCk/YX3whHocBnby1GZ8oddbrRu5C9O8r9maMw4MqbByL7K4F2YHVuHF9QjsM1x0gt8hzvYoACfpyWwctMQNiySVfz6odw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4iSH4S+dAw0ALjUtN16Bct4cGFa77jcep3Ac93fx5o=;
 b=l4Wld8gMhiefJgHhzcUbGR4d9mCmX/ak411NoYB3+fAjBZ7n4NeR1jzM3gL5P02VTFFWlmjL/nUFd1wTUb8ufQk8NuaULAM2HLo+Ncy/vCiS6AOrseaJyCRPFbYBlIoqzQWae480eTPHHWvcI0+hvX3sRwAbf1Rx0/YVQPJskzazobrR0QJLSFxXe4MplQ+JGuQcWsOfvbr1kTE1m1MhOVFGrm/CcFoobU1JC7NXq7MnER4zfUoIWWFalXvN6XxXsv+YMq4ihcaR43opEeKZTSmlOC+/ZXN0gZHhjXrQ0KCVULcALKKHnP6g0JNT7MRUowcFLW3c3LoaJaJQDeVh8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4iSH4S+dAw0ALjUtN16Bct4cGFa77jcep3Ac93fx5o=;
 b=YE5j5RgaQmnyobVeThR77tLVMDdOFmDkwNtguWREyn48hpWStd1ndxfClbj3Jcd70Jq3Vt6CrQKWknWMlrCYHM42Ga8Ztt4Jz5tRI9xg7sSEEflpryatzLY+jA9As3Er7iIanDKGVkUZbnnvCROUP3SfEAQ57TBqxc4X2ws0wAEApNoQSHtYK2bH37TVHy0XJ8Ya7OoixUXUXo36/wxz/1KjxgW2DFUiNNfxxq9oaKdBtyvnH9SVY2GuBop/RiHUVxEHBGPz+pPpbpQfusbf2PNgoyXF45yM0oz3FGcehg+ubvI6GS4xbaZ+5MIeBBI9LMOn5IvYGxXegRn9r94Zug==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Thu, 23 May
 2024 04:32:06 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%4]) with mapi id 15.20.7587.030; Thu, 23 May 2024
 04:31:59 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Chaitanya Kulkarni
	<Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH v2] nvme: add regression test for concurrently
 enable/disable nvmet ns
Thread-Topic: [PATCH v2] nvme: add regression test for concurrently
 enable/disable nvmet ns
Thread-Index: AQHarCdKytemO/T4IEGxLprcxIVilbGkO/6A
Date: Thu, 23 May 2024 04:31:59 +0000
Message-ID: <f80d3e1e-4f3a-4c1d-8fe4-709c7e9fa468@nvidia.com>
References: <20240522090540.467551-1-sagi@grimberg.me>
In-Reply-To: <20240522090540.467551-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SN7PR12MB7201:EE_
x-ms-office365-filtering-correlation-id: 7b7cd857-693e-4d02-9b1b-08dc7ae1495e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?dEE1MGp5dWZKZVJuUkxmUmRzS1lldGczMVdTZWVITlYrd05DaEFKQ2JVSUYr?=
 =?utf-8?B?RS9KbVBiN0xOd3kyUUtjc1ZHRkxzMXZWL3JUOThwT1pUZXFEZ2Y3aG4raFlP?=
 =?utf-8?B?d1NCbVBlbFAxZGV5c2dpZ014UFpRbnh3aXZCZmtaUG9nVFQ1cWhZR3hMWWR0?=
 =?utf-8?B?RGRSK1ovd0trRk5yaXo3N2FDMURvOERBOG5NOGZZbE1mMm9CVjNqdWV3bTYy?=
 =?utf-8?B?MGVabjBuVC9NVDdpN2FpcGQ4QTJWVFVLbUxsbHlXT0YwVUd3RXZhRWJpLzBn?=
 =?utf-8?B?K3F6OUF4MkJmYlRySk5oOGpNQ0RLcEwxQ1Y3WnRPTHdpN3kwUUNYM2JEbFFC?=
 =?utf-8?B?S0ExaU5zdEpabE53bkZJQXNZcG1veC9ZYXdEQ3VUaDlNNnpFaEQvVGxqTmlq?=
 =?utf-8?B?dWlpSURJcDZ3UjNlR0ttV040bUZTNkNHaUtYUHdaUXNvTzlQeTNiLzFXak9Z?=
 =?utf-8?B?V1NtNm42TEU1QkN0bFhqejJEcWlmd2R6M0p6UmE5b3dJS2F4Nm5MZm9SRU5Z?=
 =?utf-8?B?aXc4d0YycjBOd281bXVJUm9vRjU4NS9ndWtSQkpXdm5MUWRoT1ZXamhxV1FQ?=
 =?utf-8?B?Y2c5RTRWaTA4L1hIU2thV3pZelJDWFpVeGVNR1B6enVaWlBHNkdSNTRtUS9v?=
 =?utf-8?B?UXlrdndmc2JBcFRaQnd5T0o5RXdYTmtGVUVnQzdBOEZlWjlLZ1hWQ25iOHFo?=
 =?utf-8?B?THc3WEpzZ2lhZmZIaUV1YkRuYXRkaXFLQ0FNTUJTQ3NvSjN4TERLWHZjQzlQ?=
 =?utf-8?B?WUV3KzB4c3hBUllXak1hTVlYZXJpQkVSbW1jaFMwTjU2VitaRjJ1bkxvT0R6?=
 =?utf-8?B?Z2Fwd0FFOU94Z3AwWWN3NERnV2VyK1lTVDVOWU1pVG9CYzR1S2pabnViTklN?=
 =?utf-8?B?NU1CbjZxZmFsRjNXTW44MDRUazhDUkkyN255K214N2pnTVB4OVBnc2NZY0Z3?=
 =?utf-8?B?S1pjU0xlL201cTJqSDY4bjU2V2FIR2NiYjhVSE0xbGRxUmlaUkJIOFV5QXZ0?=
 =?utf-8?B?MFRVTlZaWmdCakpsU0syZmkvcUh0aVErOVBqRW9kb2FNYjExOVBEVXQ0MzJC?=
 =?utf-8?B?WFVrRDdVeFdXZlB2TVRhTG0rM1hrWG1qT0FYRy9lanNObnBBUWhpNk9zQXVx?=
 =?utf-8?B?cjIwbGZ0WVhYQkhrVGFBVlJMZWF5WER6NFN6WWFaS2RjZXFhUzRacVVQd1Zr?=
 =?utf-8?B?WWd5Rndlb05RMENRb0hodWxwbjE3cm8vZVNrN3cyWFptUGRuUXlOTURtSVE5?=
 =?utf-8?B?bnk3Z1Rua1R5T1lTMGZoRGdMYlY4dmZSbUY4M1VyenpMcHhxUHVFY2xMMU9w?=
 =?utf-8?B?MTJFQ2hMaUUxcENyT3c3ZllQVmhvQ0FFSm9VY0dySUpwMHhUQVRiOHVKeGZo?=
 =?utf-8?B?c2JqeDFTR3dTaDFjdENRK2NUZEd1ejZVUDBCaDNsbnV2SCtHbFJSL0Z1dDA4?=
 =?utf-8?B?L0FxU0R5U1dneHUrSGh5ZjVhNEJMcXQzNDY1UEZkSlVvQUZkY3RyUEppNFk0?=
 =?utf-8?B?WEFOS2tISG10b2grdUtRZ2VVbGRYYWFSRkVzd3IyZVVnbHpUMGFsWld6QlhB?=
 =?utf-8?B?ZW9FdUtIU1lkRHpORHBYQUxrb3U0VXc4VnRTdzNISEpwQmZBTHppM0ZSQi9r?=
 =?utf-8?B?YnRRQVRnVElJWExSMXRpdjI0Q0ZKZmxod0d4eXN6aXhKaUhnSlQzQmZOSENo?=
 =?utf-8?B?VkVEa2FKTFRudGN3dWMvMFl5RG0rbUNYL3NtMEpNKzFTbGdJVm56eUhLaVZo?=
 =?utf-8?B?UURlZEJ0eFdXbWlrMjlkNm5TQXE0TG5HWkJEamVFNWJGcXNNUUJxOEdFckRH?=
 =?utf-8?B?S3QrSWpwYlMzRVRnSzF5dz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEltQUE5c1RjcHlhOXd4TGZLd0VUY01VSURHbG1nNlZFWGVqcjhYOUE2Tlpv?=
 =?utf-8?B?T3NHUEJGcTdWbDhVdkl3KzhzR0Y2RlM4WEJTU0tjK0pzcHhxcFpITitmM21u?=
 =?utf-8?B?RjcrRnpiUWhWa1ExNGZ3bGZuVGVWUGVkS0NVdFdCWVJRUDY1UlFGVzNZY0hS?=
 =?utf-8?B?UGhvRWp2bVd0YVMwM0JPWVZ1MXNpMnZPdGNZempTZGcwQkIrbnlOSSt2TkE4?=
 =?utf-8?B?UHJBakZ6aUswMEQrbmkreFBsN0F0Vy92MzlLQVFmNU1sYTRoaklzYWlCZmht?=
 =?utf-8?B?WDdoTHF4cXJQUEo2MEJkRnFzT0o5Q0VXTFF5QzlyaHB3L2V0WjUydjMvcWdB?=
 =?utf-8?B?Y3U1Wkk4UUl1Wk5OOFZ5ZEQ4cXA2OUltSzRuSUpWRGZBWGhjcEl3ODlNS3Z0?=
 =?utf-8?B?bjdCd1hGTlV3ZFFaWTRRdWh2NmhsZFhoS2lreTNSQjBVbWxYM0x4U2dvU0ZT?=
 =?utf-8?B?S2VBMFJVdFkyWXN3WU9YVTZQd2tXNTdCU1hQYVo3Vm1DWllYa0tiSlFPMUVM?=
 =?utf-8?B?Z0R1UG1hTFhicDcreVRtUCtrYUV6b0xOU3c5OWhmN0R1STlCdnlIa0VZOWFk?=
 =?utf-8?B?RVJoT1hENDNmRkgrdC94ZW95eG0rYlQySE1mZ2lhbFlmaEFUMUFBRUFKWGEy?=
 =?utf-8?B?NjlvKzYwa3duZk9IMHFwSkM1QmRpZ2hsdEhFOGtCUWtzRVVIRjJJZDFSdDZv?=
 =?utf-8?B?a0RoVmd1RzVCY0ZRUFdGNHNtanRHeGhGRFQ2QStBZU80V29RTjVFam4zSHNw?=
 =?utf-8?B?N1lxaTExKzNxa29UanozSDZ3OXY1UTdhbkVGOHVMOEVuTk1JRE42aElrWjFk?=
 =?utf-8?B?NFNDWVlTL0I5T3BhTXNyTC9IcXNBdkdRemxTMzlXK1hqTWU1V0VyNVIwMVJa?=
 =?utf-8?B?UnI1enZpc1VaNlFqZE5iTlpGSTlMMXNBcFpSc1FScDlHT3hIOHlwUS9tNGNp?=
 =?utf-8?B?eUsvbVBKa3Rzb0tXU3lxN0IyMHN4N2NSMy9LQzVjRktaaWJVMi9YNDI5TUNY?=
 =?utf-8?B?L3podlNNQ3VaUWVQV3k1Z1doU3hJb0pHN2xlc1dKK3NhZ1RncFhoMEZ5aDBS?=
 =?utf-8?B?Z2l3bVJncTBHY09SdVFEYnNoamdxRU5CNW1VaHhaMENwdENkUWRMNU9NZmNW?=
 =?utf-8?B?QlVBVVkxcHgxbkZRd0d3T1pVdWc5ME5WdEM3M21HMTc3NnFhVTJ0MzRYSnNp?=
 =?utf-8?B?K3FDeEZ1bTVWWHVsZTNLMlp2d2lvcFBzRHBkMm5TeUNHRjl6bUx1WWdTNVpT?=
 =?utf-8?B?T2xzcjlwQnR3WllsNk5sMlpCNStkRlNnbVZEY1g1MXVhb3J1dGl1S3BoNmls?=
 =?utf-8?B?TURCTEJWV1NFZHdvWmZDTDl2QzVSQjB6QzhyQUIwZWpCY3pvSFZDR0kyVTZU?=
 =?utf-8?B?WElZTHoxTEhleDFLSHVUdzZhajQxZ3N5STJLMEppcVcxb21QS3lHOXNzWFNk?=
 =?utf-8?B?YWZSWitlOHp1S3owdEVoakVKZ1JmMmRwNHFpdUtWVmZGdkZZNmV1WEp3NC94?=
 =?utf-8?B?NHMwN2dxa2RXc3cxSDl0MmV4ZWVtMG9ZUUNDWDlGclVJRUl4d1o5azJPTmZ2?=
 =?utf-8?B?RHptcHovdkZLdmZMUEpXUUJsQzhDZC9jZFZINVorWnVWTndDTlZSTlZqcGl6?=
 =?utf-8?B?ODRmN3FaNzBjdGNMNmF5dTYyN2pOeUdubEYzNmk4YjNlakxpOU5FQ3hHd1U0?=
 =?utf-8?B?TkVzWFN2MlI4NUhlaVdlNy9jTlYwMXIvVHpqQlg3RmtiV3lsbG1HaEJyVG1y?=
 =?utf-8?B?WElNOUtuQVVxek1uNVZFZ0JrZWx5YkYwSythRHNMemRhN1pLUm8xTEVNYkhX?=
 =?utf-8?B?YkpMUGovU2VGVm5nNGdJMXdVK0NjTHU4RUF5YjQ5U1pRSWtuTFNKbFVtc1Jt?=
 =?utf-8?B?M29TNVZHNXV2WWs5eGUxK09tMjJJd0hpdCtQcVA5SlRzNHBLdjBNWkhacW5z?=
 =?utf-8?B?N3pzZHgyaUQ3ZW5aY0RjcElVTGJraXdxUWNIb0JFQWhUSDBWRTBmcDRtM2k2?=
 =?utf-8?B?eklEZEtlbXNjUkgyM1o2NGNMdVM0NWlibE5KQmdiQ2h0QlF0eEpUK2s2QkNh?=
 =?utf-8?B?dUIyazkwNEJpQng3Z2RPbTBTcHJ4V2NYNXA2K1pQa3VBMFhQSStOY1BKVzBs?=
 =?utf-8?B?dHNZN0h6ajJuSHordlJOcmdzYUlwckx6K0ROSUsxT0wzVWlHVG5UWFpRbzlz?=
 =?utf-8?Q?LDTYDm5lcPgehm83pKwOw2fPYgzFW/K+WdfIPgv7aHQ7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <938E48D99A9DCB4AB8AA8F0415C64CD9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7cd857-693e-4d02-9b1b-08dc7ae1495e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 04:31:59.6912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wN87oQ26cjn55LVfNStauy9ieSkEhaqkuBY+DZdtNj+SX+b80wq51B3+lj81jg6gECKd6EG2VGqUEKyXgZunvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7201
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_213212_730698_CA9F6BF2 
X-CRM114-Status: UNSURE (   8.86  )
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

T24gNS8yMi8yNCAwMjowNSwgU2FnaSBHcmltYmVyZyB3cm90ZToNCj4gUmVwcm9kdWNlIGEgaGFu
ZyBpbiBudm1ldCB3aGVuIGNvbmN1cnJlbnRseSBkaXNhYmxpbmcvZW5hYmxpbmcNCj4gYW4gbnZt
ZXQgbmFtZXNwYWNlLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdy
aW1iZXJnLm1lPg0KPiAtLS0NCj4NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0
YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

