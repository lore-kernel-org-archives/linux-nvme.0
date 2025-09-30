Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A7CCAC5B0
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Sep 2025 01:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2VI+spQpgXQxtL0rZWfeelqrsIMlCiJS/V1DC2Mt23E=; b=YR5VgVr7IdbhLxVE9DFF/wDCcQ
	/uuFukFEwg5Bdt2ILTFtQNBe6rpVn9rdI+wc7UgU6iaAGCGP9CxBXVliT4hC9vzFEtOKbdLNixn09
	ChoITzQ8vjCl+MeNSY3sGGqgYtIjuP3ooaN7cFwfqPSujInyUtxFtFUOFJlL+9slln/EFn6uevWqM
	HclWRcAo+fD/jEN3t3bFdagVdtIuBrJyOozrfvHQqSvkbFYOCPRkxdIiNdZLcUOsKCs06moNFRPbS
	oiXsQP6yKoD7A2FTnSpYOUyVoP+U4CNSeAixDKS/1Ce0QbaSUpsHZK7b0ZhVY1unz8T9+Odpd43om
	7D4BQlrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3PPg-00000003oGy-1ObW;
	Tue, 30 Sep 2025 01:44:20 +0000
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3PPd-00000003oGE-2xv6
	for linux-nvme@lists.infradead.org;
	Tue, 30 Sep 2025 01:44:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bGhSUnkoLcPpbacGdX5T6hBJHIXN6yYu8VeqiIDiMFlFjvdA3Lp1a5vdumRjMuAe99NTlykU+fEKhovz7wKVsMGFShkJkn4B+YpRVG10kcrDdI+4uoAFPb3F12miXMAXeQGWvmnonkHlcCxBxiM3LiVv4RF2TMjv03KajbFLPxv1oWv4iXqQxbH8FtkRyEgWjgPnyD9HiIBmW635ytsyG1j8P5r5xS0jig+9ydQdWsW3X7r5Y+1G8EACjGsJgN4DqpQuqjBLg1mimbgdwzctGkR7CUWdh86vcpuQMPq4PaccXn3OIVUCr8qhfNjVVrisLhZ0V75mSho0g5d5hcIGlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2VI+spQpgXQxtL0rZWfeelqrsIMlCiJS/V1DC2Mt23E=;
 b=My4GwMisAfrOk0o/1qVNURTZ25eDLJPG30WPsfhUnPgg0HTVxrxf5pJegZfSzEa5jiBy9AZYoyh19J4fM3NRxSpNEPL3eDi+OLBEcuuYh6pxuo8w3rhxezNWj/kWXPtwz4af7rW+EFW02ujouR9mH7CIAD/hQqf38BatI9qOgqmL35K87o1pv1VwgINs9kiE6pG7U+bYJ/8Mxj5iBWfZf56SjVVIQj0sgSVRQXssoP87g7AxFiTjNoT0xR/3LP9442+CRSPEkb7dbIr/0XOIu6SnZutCGTtMpAYzBtu7GqaAzCuDXGj4I0zxOCDERrPz/5HsKz/D1dRmfLwvZ72NOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VI+spQpgXQxtL0rZWfeelqrsIMlCiJS/V1DC2Mt23E=;
 b=QLri9h49uZQAoyD370SYZRqgHHhqy1j1mzdJ04Xfh8BHK/eVY127VLkEFleiObj9Pu5Q/UMaW1CFkZF4FTzVvPAsXDos09TpoQxfyMdcdngo5iFcakvU3Is5FyxBZ2XU13nkCggWui0V25p7YjdrnsVyNTDVS2EiuAX1j+Qb0eyhAaINEy28EBNkiDh93eJNtcNuA1EOSkJnOxWNDUgUSJshMk5yrWgQkKwO4v9Khf9pSmrrSxpKm6WxS3YNc5SJruimbGRoYU9uv9ZfJJ8TKGz5WKoHVUZwu+J9l3ftdCWYZbWJx/4mZMRJwyzKM2W4ZTspYYYderhwp5nH6THgyA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS0PR12MB6437.namprd12.prod.outlook.com (2603:10b6:8:cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Tue, 30 Sep
 2025 01:44:05 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 01:44:05 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, "dwagner@suse.de" <dwagner@suse.de>,
	"johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Israel Rukshin <israelr@nvidia.com>, "shinichiro.kawasaki@wdc.com"
	<shinichiro.kawasaki@wdc.com>, "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 2/4] nvme: add support for mlx5 RDMA devices
Thread-Topic: [PATCH 2/4] nvme: add support for mlx5 RDMA devices
Thread-Index: AQHcMG5AeGXEu1ZrxkKUzj4n3/KaMLSq9osA
Date: Tue, 30 Sep 2025 01:44:04 +0000
Message-ID: <2fc38f64-90b9-41cd-8cbc-54611fcb4e8f@nvidia.com>
References: <20250928115125.38383-1-mgurtovoy@nvidia.com>
 <20250928115125.38383-3-mgurtovoy@nvidia.com>
In-Reply-To: <20250928115125.38383-3-mgurtovoy@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS0PR12MB6437:EE_
x-ms-office365-filtering-correlation-id: 18b4bcab-d686-40f5-908c-08ddffc2d6dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?VVhTcnlsUXFBT3lHR0kwdzZSc0hBajdSMVpHSjByNWFyWTVkTEQ3QkRVeGcr?=
 =?utf-8?B?Q1p6V29HNHFMeW41WnpUb0luYmZQN3VCYVJBdUwzMC95UW16d1FiZndWVFh1?=
 =?utf-8?B?TktOMkhIRDV0T1F1eW1hMzFOR3V5ODNvdXYxQ002Q2FUK2F0TFI0amZiNFFY?=
 =?utf-8?B?QWdYblA4WTdsWFI1RDBNd3lMUUkvYUI3RTNFcVZtbXQ1VHRnMG9Pd1h4azJG?=
 =?utf-8?B?V3FNV2ZtRzBPWXJKRDR0Z0FCRTlzaW1CbjlYek8wRktmT3RHLzNrMHIyeWZ2?=
 =?utf-8?B?SHMxeVhHOWVZZXN4dkI5MUdndjR3bTdDbGlETDIrQVhBOXJVQnBEU2c0ZXNy?=
 =?utf-8?B?KzByU0toMWtHaFVFRDZpWFBBQ1BCbE1SOWhoalF1Q1E2bGZaNXJLTnpXWHI4?=
 =?utf-8?B?M0ZHSDloUDFreGFVeFFkS21jcG1LTnIwSmR3Y1BkeEI2elF5RklnZ3pFN2Rk?=
 =?utf-8?B?aUxSVEw2TjdqeXJ6N3NmWUpVamFucmNvUVV2dXZ6OXZvb2tJMG15bm1UYjF2?=
 =?utf-8?B?c3J1OE1hM3ZDRHFTd3hUNmNCVHhiRUo1RGFCWncxY05ucGNORXV4K3lQNkxO?=
 =?utf-8?B?L1pHQk9INWYzeDJxMTFYckV1bXFCTWNZS3pjZ2JYOFdIYUZkM3BraStUMnhE?=
 =?utf-8?B?ZlJ2eEhEVFRBaDYza2p2bDBSZ0lwSXppVTVLMDhXM21GZFdSNldnaE43VWJU?=
 =?utf-8?B?YTdxeHJLY1VDRms0MVBBdVJTSFFrUmNkSUxreHNOY2dyK2JSdWdscit6OEl0?=
 =?utf-8?B?TWJrQUFsT255NXdML3lSVDVVdk15N1NneFRySTRFSHdLWHRxbTYwdm5BWDJE?=
 =?utf-8?B?S2ptRHdWL0x3ZFdTOXBsRHBzblh5c2Rzc3lrc3JOM3ErcGZ3RmUrUHdNcjAy?=
 =?utf-8?B?UlVObGJLUGlrcXBmWGZncmZYMWlRVnlFL2RNbEdOekRJbEhodnowbklYR09W?=
 =?utf-8?B?U0hsTXcvdk1ibXZtQzN4cnpxaFRFaWpJRmNUSVFKTENEME5oSWhYNldJeTFx?=
 =?utf-8?B?NmVHRWVmSXpFTUJWbXd0bDRLQTRib0hCWmlFaUxoaCsybS96bGN3Vk1KWitE?=
 =?utf-8?B?ZFBjNDdwVUZJU0t5NmZhTDFCUDEzSTRXaHlicVoxUTg2MUt6eFg5ZFp6YXBn?=
 =?utf-8?B?cFlYeVo3UUpRTnU4dWRpZTluWHM3allKUEFDandXYllQRHVxWXA4cjBLY0d1?=
 =?utf-8?B?NVZQNForL2doQkV3NE1NcFNiQXkzNzV6NEN4dGw1L1ZtN0RyWW90cWhxYTlL?=
 =?utf-8?B?Wk5zVC8vVXRuU255bTVHelVlOG1CY2hoV2JVVlNXNVpDRGtyNkNtRzFXcnZT?=
 =?utf-8?B?b3E0ZzBMQkZ1c2EzcFpFZ1FPSnlaMEMva3hCdkpMK29tVENNUjhwRy9nTDdE?=
 =?utf-8?B?cjIzUEZvSmtNVitBZVRBZld6WTdUQWpCUWk0c1BJTE1XcDcxL1UyWi9xOTAy?=
 =?utf-8?B?cnBseW40eWFESUlpZ3d1NWVnNnRTYXNBZ1RJaktHb3lIQUt2NFNlV0ZCTG1H?=
 =?utf-8?B?T2pBUWUvcWNMWVJMbjVBc2dHS1RJWlp2R2htOHU2d0lVakJiMTVxRjZFeWk3?=
 =?utf-8?B?WHFiM1V6MkFUWmx5bWx4ZVMrYXlmOGFZbkNsUkZXeCswVDh5MjhvUkhIamJN?=
 =?utf-8?B?OUwxeW9PWjFTdWhsQzM0SUk0Ry92Ly9JNVFIK3RmdzJXc0ZVYTA1RW4wOGl0?=
 =?utf-8?B?TjVJelFaYktXTjg5SWhaSUNBNE45eTdJWWZRQ0kvK3JRSXNuMWZkTGNaQ1Qx?=
 =?utf-8?B?V1l4SFkyVTROQzArTkJPWTQzbVRrWlhhZlNzWkVQZzk5a29RS1ptL1M5MDNj?=
 =?utf-8?B?OUVPNWg0dmN1R1N4M0VlMU1mWTRweDRvYlNhUmN3TjEwZGtNRnF3TGhvQjBm?=
 =?utf-8?B?dzdlRU9wSHQ5elN4K2hJWTd1U2ZZS2syKy9PUVFpcGxkRXBmZTdkS0lVbVIz?=
 =?utf-8?B?TzIxVDlDUmdsOEtYMkRhdlNKTXg0QXZPVHpqbkdnQm9iRHRZWFEvcTZWc25q?=
 =?utf-8?B?WDBqWGNGSlVqckhOcU0xTkpXbWhpbS81VldCeW9ScVpZdGZ1cmt6TVlBcDFI?=
 =?utf-8?Q?92RYm9?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1pkVlp4ZkdtdjZIWVJKbGhMYjR1OWtoMnU5N0RwazhNYWZDUm42NXUwQVY3?=
 =?utf-8?B?c21OMG12MnZEYlN0TXRkUldZZitUT1d3YXBSNlVXbXYxekNhNXhzd0tMTDZ3?=
 =?utf-8?B?dHErZ3dOSHV5TkhwWUtId1JEdDZBVmdtNUtGUENtWGZhV2MvVlZQS1lXd2FW?=
 =?utf-8?B?OWpvdXBJK2xST2FVb2pkNTdnbWJqRndkSjNkdXR0YzZGYlNGV1gvWDBtcm9z?=
 =?utf-8?B?KzJ6YVZ2MDBjN1NhUk5DV05LRG5mZDExaThyV1J5ZG5VbDhUb3JzRC9UL3ho?=
 =?utf-8?B?NjhaTFNkb2NvL0tldzQ4QmZWczlOSG1YalUvV0FpbWNrMDVYUzd0TGZMNTNs?=
 =?utf-8?B?TWxFZ1Y4enJRWFB6cmJnblR6ei93SU0wTGxIM2MvN3ViSUNtVnhhVEhteEx0?=
 =?utf-8?B?YW9GM0xtVjdCRDlhRG0wMFpzZ2NiRVBCWDlWK1MvTlJOVmZFcm1BWXJvd3hi?=
 =?utf-8?B?TERNYjNhb0dDVy9SNnFQZGZsc2tXNXo1Wm1uK01FOGFqRW8rMjh4MjhZUDYr?=
 =?utf-8?B?OGxOaEg5OENKdzh4ZlMrTVhEdjYyaTlXeTFkK1EvVENyWWlzUXpvRTBzN3F3?=
 =?utf-8?B?aHNOQW5MOElmV3liaFlhdUxzeStzay9PUFdmUUdwN1M2SURvUTVNTzRqMGlQ?=
 =?utf-8?B?N3BheE1UeDVjZVpxbXQvYk1BWnMyOVhJaGdpKzNES3g4eUh1eDZtbUxFdXVs?=
 =?utf-8?B?c1hkVWpQOEJoTzFYZEpQaEJ2T3AwYU9yc2Nyc3FYTjNkYkhLa3lqeExGVWhC?=
 =?utf-8?B?VWlwOHY0YnlRZE1FeTdDWHNuQjJsUmV1c0xHSDFSZm5yVU9jaVpqRWlCNUtZ?=
 =?utf-8?B?bjRXWVNsVUc5bkxYMk12c2tZMitXclAwc0dCdFZCaTM3YzVSQ2dGTUFBNFVi?=
 =?utf-8?B?ZnNheC9JOGo3TkRRVm8rMEEwM0h6QkduM0o2U0xlaFp2dGp0ZUF4M01pek5F?=
 =?utf-8?B?SmI1aCt1eEY2YkZ1T1d4R3cxb3FjaVhVdmVBcDYzdnUxSWlROXRaSnJONk15?=
 =?utf-8?B?SFE0Nk92YlN1UjdjZ1dUSjFNYzA4Q0tJdjR4Qk0zZ2dlVzZIUVpSc1ljY0s1?=
 =?utf-8?B?VEczakNZbkQ1c0U4TWRTZXV3cVFpQWhoN0FyQUoxZ1lRL2tQTk9uN1BJOGdm?=
 =?utf-8?B?eDJrRU5IOVNySDA4SlcxdHNOalRWL1h3Q0N2UXJHbDkzL2h6Z2h5MTVrVzFt?=
 =?utf-8?B?TWdlcVJ6dEFSS250WUkyeWxLRkpiTXNSVWxzVXllbjRWVERkV3NwVERON2sy?=
 =?utf-8?B?TGFMQkNFOGlRZ2p2M0FaODhialVxbFA5QXRkL2Q3WEl3L1E4bmhLTkUrZDZ4?=
 =?utf-8?B?dUVBdFIwd3BZWkVWNkc1YVd5NzFIYUFWdTdhSzJmK1VWRWdBTVA5YitGeHF4?=
 =?utf-8?B?eGt4RjdodUQ1Ym9iTjFmUkV5Z0NydExNTnlaS2IydGhrMkowZDg2dXMydy8z?=
 =?utf-8?B?VlBGZS9NMkdXL0xGZ0tMbk1ORG1rdWQ1MldheTNjV0owWFplcmhnUGdvcEhF?=
 =?utf-8?B?MmxaSXBsMm1IVFQ4VmwzUlJPZTlwOFl3VEF2WnhuZGNWNFVKc2l1M3JocnY4?=
 =?utf-8?B?WEtvWWlQVUtWVGtJTElXbkNGa0s4OWt6TkZ6LzNndC9vOG9SaFNQWTJxMXRa?=
 =?utf-8?B?ZlVzbmJ3T1dDMk9qcTVMRERxeTFwTm1LVUJIdTlWN2t6MG0wV2RHRzl0NmZ3?=
 =?utf-8?B?QVZYKy9NZGc2MEJyNlk2a0xJSkpyUk9FeDZIbjlPemlhYWlmajhBeWQ4Ym10?=
 =?utf-8?B?MGRzYW05aE1mbUttb09zMmpWYVllMEJQM2pueUp2TjV5Z0IzZFBpN3U5Qm5Z?=
 =?utf-8?B?eWRrb0dtbFpNUHBrODh4ZktTYzNtaHdoSDNvTmljb0VHc2dZVnFZeGE0UTBW?=
 =?utf-8?B?SWw4cmZLWXJ2YlVxUmRmLzNobWtNdDNwQklDQjUwZHlVbStTd1Q0dW1MZWZh?=
 =?utf-8?B?eXBseGpRc0NRbEVZTkRlQmNzV0x3Tml1M0RVS3hBTVJFckhUSWg4MDJycXB4?=
 =?utf-8?B?cmowVFFreEUxeEk2cjVpbm0yWjdkcEJmYjhLVkxXM1BNdVdoWEt4aGRFbjlU?=
 =?utf-8?B?U0ZpUWZSZXVpVm55T1RkSVBoaktaWm0zM1JZNmlwYkVrYndpb0M4d1YvTGo4?=
 =?utf-8?B?d0FNUzZtRXFuWmhxTTB0WVlkYlZJVG13VmdUbVR5SzNmb1FmR2xLcWllY01j?=
 =?utf-8?Q?NAkyMWLexWzO6QvQoPcBpSl2aBWWaLYItxOX3g5zTAML?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5A76351E7B3AF45B64A57021DB41A03@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b4bcab-d686-40f5-908c-08ddffc2d6dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 01:44:05.0011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GHjPWhEBPWCL25ogzWYLG6PGmNX5tEfb6C64kNrbJSNVXemvxF5pg9OPUsEOzSFYFyi/gbjOEvYjSCUm/Tj9pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6437
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250929_184417_752130_A66E18AC 
X-CRM114-Status: GOOD (  10.21  )
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

T24gOS8yOC8yNSAwNDo1MSwgTWF4IEd1cnRvdm95IHdyb3RlOg0KPiBVbnRpbCBub3csIHRoZSB0
ZXN0cyBmb3IgUkRNQSB0cmFuc3BvcnQgd2VyZSBvbmx5IHN1cHBvcnRlZCBvbiB0b3Agb2YNCj4g
c29mdHdhcmUgUkRNQSBkZXZpY2VzIChyeGUvc2l3KS4gVGhpcyBjb21taXQgYWRkcyBzdXBwb3J0
IGZvciBydW5uaW5nDQo+IHRlc3RzIG9uIHRvcCBvZiBtbHg1IGhhcmR3YXJlIFJETUEgZGV2aWNl
cywgYWxsb3dpbmcgZm9yIG1vcmUNCj4gY29tcHJlaGVuc2l2ZSB0ZXN0aW5nIG9mIE5WTWUtb0Yg
UkRNQSBmdW5jdGlvbmFsaXR5Lg0KPg0KPiBQcmVyZXF1aXNpdGVzOg0KPiAtIFJETUEgbmV0d29y
ayBpbnRlcmZhY2VzIG11c3QgYmUgY29uZmlndXJlZCBwcmlvciB0byBydW5uaW5nIHRlc3RzDQo+
IC0gVXNlciBzaG91bGQgc2V0IFVTRV9NTFg1PTEgZW52aXJvbm1lbnQgdmFyaWFibGUgdG8gdXNl
IG1seDUgZGV2aWNlcw0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBNYXggR3VydG92b3k8bWd1cnRvdm95
QG52aWRpYS5jb20+DQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vs
a2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=

