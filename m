Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBA2CCF9F8
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 20:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vcOqPDKINYVFDwP2GqDx5bY66CKiokkYIdo18zOqy74=; b=Idq4v07D4oCVhvowtIrzBr2aaf
	gUP8UJqRAnMZYh5ttK2r5yeekWspEgNeXn6ubfgBnmJ/5UZjoLhXFKWm7nxv24cTYMnGUYKj2dNS7
	Ipf5hLbygsFJe5DwkBtdnVmeA6Vq9tDgFPo6uenAq/+qbgxlEW5djMVh7uHLlTt1lZhMy7UPiG1v0
	juqovdjboATMgz6Hz9vmf/N5XZPtmSmyhQohqK2nhclKriwjIF7iz9FcRi+/nKAyDsZO9wIFJXkvm
	UN7B/hpuA1dlf9ail/1+5jlfFENoYnsWHhHu100rXLoyA3DSRq9cUQ3VfhXt8kO+YhQIh/qm7OEBN
	U139Fq6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG1BP-0000000AbLh-1Uvs;
	Mon, 03 Nov 2025 20:29:43 +0000
Received: from mail-westusazlp170100001.outbound.protection.outlook.com ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG1BM-0000000AbKe-1nFJ
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 20:29:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YMKUwsiGyudvSU0270vxdmBUu3vfYt0ZEqHcxbI3vyrfBtQNi3eZWPZuccFTw3XlexeDa9O8Wtm4a5508qEaeUXsatJtK4pvM87ZWvD4uIRn/echEtSH/lAGWV0QJy0+zyxl2v8QZve+s4GY6C2Ktbao7RvLvqNTrbPvXC2yyj97MEn//xgDQ3b7an7KVOZCu72pSIRUoN674JZYivS/mZOPjFZBa0O4vjYig87+S5AMn1s8cfOyD3+79hhhmyIh9N1X6YxphgtbBs7B9Ma+kMc5O4QN55dwG7mT213FjM87zboeRwoU4rSUppREAu8M+Xns8cJ7QvPZ1kJpRFVj2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vcOqPDKINYVFDwP2GqDx5bY66CKiokkYIdo18zOqy74=;
 b=Ja5lqaKRRtNfbdW1SlLJZEmYB0cREAJh5X4J8rBeH3cRRkav4lSRqlIzeG2Lqc56ToP6J8YfMHONSHe7hXTDIRkL4M3Fe4reoX4g4dTLNCeSS1jdNMfCCLx8IDUDc1o3kUVuzNLEuQDOrifRc4nGIogPenFLIxopoRdQIF/Fvje1ksslgfcwPXa0lPPHCmw9+Lh7N6KmZGgO6vCGa3EDKaLLH0A+agWUadHvqH4waPEljUQ0NmieI9Ht86zYpZEQPF1r1a+7NG1OSt8MOghRREWxiqIxlK0EqJsolI7/SJamG6IYlyD8PrGKiOEdNd3ZQ98mgu5uRR2IZBvLDWp4/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcOqPDKINYVFDwP2GqDx5bY66CKiokkYIdo18zOqy74=;
 b=Z/X4HGdZsLuxd2g/I3pxJBY1VwBMEeyU1lg3C+vBUgft1IaSx49HfxqiUupv2b0jSuenpsR/zM5/dCUn3jH1/FTe9mrhQPJN7V+rIdEUttxzC8if/0vJ4KrTjQiGZ5t4ak1LB10XSmx3iaEwDqsv95f6v66TL90InmeC0718nVbTmk8KmE0TDN1uFwxDTd3x68Hd2JOJ6QoAB0Rp7rlz/2mR786a53AQnXs9any7MdYUOlbC/iP0Jvy000Zx+jtV9dLloIBJw4wk6kOUOEn+atNKRNypyrhG2wKsInRvJ4unqsKIbBy5tuZYbF9LRld58q/WqmPUM7q5GCAGabhJ5A==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS4PR12MB9705.namprd12.prod.outlook.com (2603:10b6:8:277::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 20:29:36 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 20:29:36 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Maurizio Lombardi <mlombard@redhat.com>, "kbusch@kernel.org"
	<kbusch@kernel.org>
CC: "mlombard@bsdbackstore.eu" <mlombard@bsdbackstore.eu>,
	"bgurney@redhat.com" <bgurney@redhat.com>, "bvanassche@acm.org"
	<bvanassche@acm.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V2] nvme: expose active quirks in sysfs
Thread-Topic: [PATCH V2] nvme: expose active quirks in sysfs
Thread-Index: AQHcTNBu2LgglWRBSECkajfGZRtMgLThZ4MA
Date: Mon, 3 Nov 2025 20:29:36 +0000
Message-ID: <f95e3006-7773-4230-a426-8a3469c6fa22@nvidia.com>
References: <20251103144406.1148401-1-mlombard@redhat.com>
In-Reply-To: <20251103144406.1148401-1-mlombard@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS4PR12MB9705:EE_
x-ms-office365-filtering-correlation-id: dbde2e4e-d8d1-4e04-6117-08de1b17b4d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?dy9VQmtnUjZEcUQySWpiTlhvWjVJSGdiTXkxb0ZHSUVQRTNYRjU4Zkh0VzQz?=
 =?utf-8?B?R21MdWczaTV6K0hFaFJKVVhrdmx3UXhyQ2R1Wmt4dzBzU09SNUR4QVhPcXg2?=
 =?utf-8?B?QnFnOWVsU00xLzExQ3JiYUhwbXJPRnVTTlpUTys3cTZ3eFdETi9sTlY4ZFM0?=
 =?utf-8?B?YXVGU1pvVjBBRUV3NzhMSFFyU09Od252eEpPcDlWNzh0cjhrSGNhbmg1b01q?=
 =?utf-8?B?aHF5U0YyWEZ6cFRiLzRBdXIvcU41U0tRaFRlY2NZSVBFVUpuNTVlYjZzUktW?=
 =?utf-8?B?MStiNHBOZjgxNHpNZ1N6STh6N3BRYjU4UUJBaDZEMVliM1N4a0hlZHVuaEhn?=
 =?utf-8?B?L3RVVk15cHQ2ZDZ4dGlzVEVFK2p5SlBRWDFhUnVFd3cyUGVrNi9sYXhpNUsr?=
 =?utf-8?B?Y08yT01aTExveFFkeW52ZFA0cERPdkQ1Nm91eVE3KzFDSVp0K3IwU0tndGZy?=
 =?utf-8?B?clZhOU1wQ3c1NTM3b0VORzY2YjU2SENZN0lEeTRJd0lST1VkaHllbkdUT1pK?=
 =?utf-8?B?NEYwOVpFQU1VL1RMaGZIMlIyK0I4Rk1FUkJQTUZibUZQS2tkK1hsVjIvUG8r?=
 =?utf-8?B?S2pKTjZhZG9vWVhRNW1BUWVqUHRiQ0REVVZTbVpWVXVPRXhJSDJJR1I4Rk9V?=
 =?utf-8?B?Z2lpNlliZ1M5ZmxCSUFLOC9VRzdJT0IyaUpMUWN3ZTA2blU4SjZ4eEdsUjJl?=
 =?utf-8?B?azkrNkMvcWp1MmY5dVZuYmlicHh1UWFKZ1BCMjQ5Syt0RmxMNGt2TUd0RmFa?=
 =?utf-8?B?MTFySVg0cG9xR2o4SXVKOUV0Szl5TjJZK3NlSlNtUFo3V3hUS0tTRmR5ZDVw?=
 =?utf-8?B?R2E0eFVFaThFMnlTT1ZBZnZuM0ZEMk1kWHk2eHdsaENWWFhsMUhYNnVneXVC?=
 =?utf-8?B?QkoyRGxKcFFGdjFtQWhoTkxUbVkrWmVjMkpkWlZYd1JqZ3c2MGx0ek8zT3dX?=
 =?utf-8?B?VkM0MmRPQ0NoSXVmUDFYbHpCWndHeHJVV090dzlhUlpOM3lSaEJtaE54ZWtP?=
 =?utf-8?B?cWVKS2x2WlU0VDg5OFN6NEgybTZPOHEzY3lKVHQ5VTdITi9XZFE1WHpxWUUy?=
 =?utf-8?B?L05YNGxTQURNamh1U2tiRmF1MFE0amxxRG9OVzlLK2htTWhMU0VXVjk3UzJQ?=
 =?utf-8?B?ZzRqRDdhVGpHUjczN3JSa2hjVVBaa2dkQjlvK2V0dDZSOFZpSkY4aFBOV2E2?=
 =?utf-8?B?SlBDdEkyMStJdk4xcXVLQyttTU9yeUl3N0N5Q0F4VEFCTmIyL1NIclZ1NmRH?=
 =?utf-8?B?SmZNR0FuUk01OW14N1p0eE5ueXZKWVZoa1F4MW5Fcm9YN0tMclFtQnc4RExo?=
 =?utf-8?B?RkpxZHZaTWR4T3pkQStZUzBaRG5jZ2NvT0d1K20zU3gvYVFDUm9XcmVQOXNX?=
 =?utf-8?B?QzBNY2MvQ0FvVEJrQnVxNU95Q0lobGplcEVydnN1VTVUeC81WmV3eVZoZk5U?=
 =?utf-8?B?MTJIb01PYXNvMTdCZXQxdm1aV1ZXM0l5SGY2SG9qTmxqZWRUYXhqanM5VXJP?=
 =?utf-8?B?d3hVaXJhTVpad3BuU2FzMWNoUFZrV3N5MFRmWDFCaHNMSEpsZ25KdkFzcmFQ?=
 =?utf-8?B?K3l3RmdoWVlLSWpmbU5RaFB5N1A0N0M0OWpOb1BRaVp4Vllhek5wVFVVL1Bq?=
 =?utf-8?B?L3NHUU5jOTE3ZzVDT1hGM1JxQnVxKzJyREcxSTlvak9QbnRKNStyQ1hsbjlW?=
 =?utf-8?B?cFhpL3RJT0JOeHkxdENEbWdqMC9BYVltK0k0QTFzdTkyWGtzMUpGUmJuL2xS?=
 =?utf-8?B?dDNDR012M2M0LzJGa1EyNGV2K3BmL1UvdGVVcTBtRC8xVHBOOStYSTh4S0tR?=
 =?utf-8?B?VUttaGs4eVNtWkZMOFNFRUY1NHpTSTRNT1czdTRMUVFIZitoczM1UlpPT1lK?=
 =?utf-8?B?WkVVRE03NWx6QWo0d0RYMnR5WDFaa3UyMTJPVVQzdk5yZEFTTDVJeGU0YkNi?=
 =?utf-8?B?cWFkcFhnRU0wcEVLd0RuSXdYSXcxQkQ1cEVmWTN0ckw4NXY0QjFWSUlvZmlB?=
 =?utf-8?B?SnEwMmw3MEY4K2d5dHpxVVF0eXZoakxsSHpvbUNsZEp2S2wrTU01R2VwQzhi?=
 =?utf-8?Q?2C8r2F?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2tHRm1SWEY4WlFNM2x0K21RZjFhM1pNS3kxVS9oRktRZFhYR3RkdWxrNTJ1?=
 =?utf-8?B?MVNNZkF3ZER2OGN3QXNRdmlwNDlNQlVpYk9SQ0IycDRFTTZkZS9VMWUwUjhH?=
 =?utf-8?B?RHpNYUgwK3ZYU0VNVDF4bG5vTEM0aGRzc2FOdlc1NUlIeWNSalRrbjE1UEdM?=
 =?utf-8?B?WG44NGEyL3BzOENDeEd4cVNqek53SkEzdHA0QnVHenR2T1Y4T3lLYVR3TnJH?=
 =?utf-8?B?ZVFNRHdXVTJmbUtVZktxT0lkWWhObEx1QUJsVHRDYk9lV2l1ZFBEU2hmT2Zw?=
 =?utf-8?B?VG1tTjUwL0hwZ1dsNE40b255TDMyOGl1K3ZGVlpHcTdqSm5XKytUTVhuMVVM?=
 =?utf-8?B?d0I5RTNJa3NXaHFzSTJZdlg2cHQ3cUVNenlpSEhDOGI1SGVrYWR2TURQTktm?=
 =?utf-8?B?WEh4c0dIRGQ1NE1QVzNXMGtNcWtjWXc2Y052RWxxdU9COHkyQktsVmk5MkhK?=
 =?utf-8?B?RVN5ZUdGVTh6OTBBZ2xHNGkzMnpqV1U4d280VVZNZnZXRk9QaDNZaTlnN2lE?=
 =?utf-8?B?VVNyVC9LUnhOY2NLQVdiaG4xYjJ0MGtxb0h3NzNQYi9lWUFzL2VGNXZsVHBK?=
 =?utf-8?B?QWNvUHNseW9WeEp4bzZCbi8wTUMreHFveVp3aUtkZlMvNmpuR0R4WUlqci9N?=
 =?utf-8?B?Mi9KeTBQYmpXU2c3UUoxQWVHMmtWaTZWYlRXTGQvOHRpc1VWa1ppMU9ScFZT?=
 =?utf-8?B?ZGYxZUIyK1FUbjFOQko0R1JRMGEvMEhqbWEzV3duclR6K0NnYTB6SytYam56?=
 =?utf-8?B?NzdvU216WjNtRFRLTzZ6L0lqQ09WR0FMakQzRm5jcnkvTm1DSjRaTDJPMytu?=
 =?utf-8?B?a3RqS0VTdXY5N1VtR1FIVHc5WngxMjJITGRyTWVDU2ZYSW5qT3VtU3dsY2Vo?=
 =?utf-8?B?RDgvcmNZajZwSXpRYVBUcVBXY2x0dHExREhydm1UMGQxeWpiMUJ1UHArclB6?=
 =?utf-8?B?dkM1WjBGTWhzdDREZStvaEVFOFAzbWhLYUg5VHRJQ1hMeDB1bDZqQXdDN3o0?=
 =?utf-8?B?WmRvK2F5clZjc3ZTd3hGTVI0NWQ1WktNUTBKTzlFQitEcGlRWld6bmJaaEdP?=
 =?utf-8?B?T0tLQlEvU2pPRlQybmNYSXdwcjJkYzhiQ3B5bXUvZjRtM2l1aWNSQUpCQWtV?=
 =?utf-8?B?RDhkVTdDemFETHl1blZVUy9ZLzhnd1VBcnVxck5HOFZZMHptcUVvUWR4WUZT?=
 =?utf-8?B?SGczbFlua04yalJoODZDWXd0UVA0eWtkelBlRjE1UnkzYURvZVdMZFhwV3ZP?=
 =?utf-8?B?bE92L2YzWGozWkxjVDZpM2ZaN3pPY2d1RVZlV3dvS1pySGorK01VZzc4L2VO?=
 =?utf-8?B?bmJyamxVQVNCM0FDUUVteGlxMmhveGVWVlphWnpXbDkrM3VMeGdqTU5pSkJr?=
 =?utf-8?B?YUg3b05GUzVvUjIyUnVjVzFtWnF3Ujg1eHJTejN0dTE5RHVFWk44enAvb3hD?=
 =?utf-8?B?eEZKOVh2cFY0MnV5WlFQL3R1enNON1Eyck9vb0J1Mm50a0lETExWMkFncVE4?=
 =?utf-8?B?ZnIrN1ZvWjFnSiswVHc5ZVFjWjNFblJIVFBjbEcwRUFqT3ovY0x4MHJXR25W?=
 =?utf-8?B?YkxNTXNlbmFMNnFoaU83c1FjeXl6WnlCb1poaUprOVh4TktRMWxxTHhQMloy?=
 =?utf-8?B?aVpuTXhnWG1zR3BtN2pTZzJuMTZnVTZGMVl4Ky9OaWp6KzBpKzNyRzVSNEw1?=
 =?utf-8?B?RG1tMXNycmNTeStBd3k0RWdqRjg5SkF1THc1K2c1QTU1U0hJbGhtaDFUNXVu?=
 =?utf-8?B?MEJKZTZqR2phQzNzRzlsNlRQN3dQM1lnTFpZM3BxUDVCYkh0aEsxdHZaRmNZ?=
 =?utf-8?B?Y1FWVGhpTi9nQWErNzg4Mmx6SHdWaytDd3lXbnJaeEtOeVFheGR4RWtaNW9q?=
 =?utf-8?B?VnNWTTd4Zm9xYWdIUGdTWklJWDNFc1BkYUQ4MWhudDJGT3cvWVJwTWxWTWhs?=
 =?utf-8?B?Q0x4aHZQZTYrNC9jU2NUaTBvVnpZTVYrTGFBLzBPMmYwQm1IVENCNnAvaXU2?=
 =?utf-8?B?MnM1MWFvWkVUOHRKMW1laFVVSms5R3hkR1MyNnZoQlh0NEtLSlpleEdNVHlh?=
 =?utf-8?B?TFZKU2JOc2FCUThYN3cxTndkY040TWgxV2FDTjJMaEt6RWlIZStaK1NMUUhi?=
 =?utf-8?B?Z0ZXUGx5MkoyN2taNVZXN2hqK0I0MkJXY1JYb21LSldzYUg4NFJlSFhVUStp?=
 =?utf-8?Q?3S80IH+j7GV2GgSSniNDjpeTV5vHZ81pG1cniI7AW4SY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <055344FA78242E438703FA8E95A3078D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbde2e4e-d8d1-4e04-6117-08de1b17b4d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 20:29:36.4623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HwFBDbnvNCRwJyF8XmZcwhOD08u3bQqUfHNSMsWfCVUCaVarh9CczqMLpgzqAixpeDaP/+guVQ+uYYO+Q8sJCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9705
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_122940_474090_FB367B0A 
X-CRM114-Status: GOOD (  10.90  )
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

T24gMTEvMy8yNSAwNjo0NCwgTWF1cml6aW8gTG9tYmFyZGkgd3JvdGU6DQo+IEN1cnJlbnRseSwg
dGhlcmUgaXMgbm8gc3RyYWlnaHRmb3J3YXJkIHdheSBmb3IgYSB1c2VyIHRvIGluc3BlY3QNCj4g
d2hpY2ggcXVpcmtzIGFyZSBhY3RpdmUgZm9yIGEgZ2l2ZW4gZGV2aWNlIGZyb20gdXNlcnNwYWNl
Lg0KPg0KPiBBZGQgYSBuZXcgInF1aXJrcyIgc3lzZnMgYXR0cmlidXRlIHRvIHRoZSBudm1lIGNv
bnRyb2xsZXIgZGV2aWNlLg0KPg0KPiBSZWFkaW5nIHRoaXMgZmlsZSB3aWxsIGRpc3BsYXkgYSBo
dW1hbi1yZWFkYWJsZSBsaXN0DQo+IG9mIGFsbCBhY3RpdmUgcXVpcmtzLCB3aXRoIGVhY2ggcXVp
cmsgbmFtZSBvbiBhIG5ldyBsaW5lLg0KPiBJZiBubyBxdWlya3MgYXJlIGFjdGl2ZSwgaXQgd2ls
bCBkaXNwbGF5ICJub25lIi4NCj4NCj4gU2lnbmVkLW9mZi1ieTogTWF1cml6aW8gTG9tYmFyZGk8
bWxvbWJhcmRAcmVkaGF0LmNvbT4NCj4gLS0tDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5
OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=

