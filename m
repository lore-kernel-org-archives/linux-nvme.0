Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA47CCFA0D
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Nov 2025 01:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=26McHk1JtGzV2uN6agNf+AGwSTBiMMUxFrltgo9WyLk=; b=ZNTxs210gOwqnzrYyTmIsXBTOY
	pt83e5ADFsEItteuTPT+eSbopsRbJ1NVVPO/LmxZ3aX8a4CRLP9RXLClbrUgnfHuYZagcKKjlelx5
	74QAiukx3ckN5xgEKwamDPb3Y5O72iD1sLHGDR/jE5dkCUEnAjUekto3zKU0yupT/E/h5+j+nUB1i
	1crD9THZGTBMtj0/HR1kXGqznPDXLwfg1v/N0nJYRiM4lNKojigtKAyFXc9iw173tYWWk4VL3fjCy
	tWuE6ok+Zkw8bbDMWHebNYDbA5pQBsPUyg3UQBe+V4U7S8vzESGB1ZuIGc2o5Q9ErO1qjrJAt3/dY
	ETStDkbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGogG-0000000EhK4-3Uir;
	Thu, 06 Nov 2025 01:20:52 +0000
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGogD-0000000EhJ3-2QsV
	for linux-nvme@lists.infradead.org;
	Thu, 06 Nov 2025 01:20:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JzMIkLTclCo+bnm7PIPTyMg0xRAN293K5V/MeE8kGxsUcoN72f6mypPjmghUzsY4s7kNf0ozWPyXFvdDo59ooAp2eNDpCOd4bToWPFzc+5Zit7nK71DQ/aFG/2IM6bT9CaZ2S2F1Xik8+B4AURTIiNsBawZf2AY8uKiIqQ5elR32Pcwo2smHnAskSV87kkbxmkS0YqK+ICpBgOegTlgRY1QkP60RQfsbzppqcRLkGstqSawkxgi8FdFmj86jvexDECBnI/RLSvKiCku6O0pDdk3cTANe4Iy00SCzWgdGQCBJms8aP1hTfmsYI5PRmyhdobhYdnfEIdxdTXXkBO6deg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26McHk1JtGzV2uN6agNf+AGwSTBiMMUxFrltgo9WyLk=;
 b=YHMJ+6xgOvU7q22rGzY/zhdvCdzMgp62VscWNgX5MzkK+m93sx9FTfDBp65pHRGoOn7mPM+RDmwAH6aiWhu7VGi4dCeKfsrnRwesJFWYDnJyvHnPNez41Du3WQE714cdegqL9iJNs8oVog/LegC/7eTg1wYx4f8J7ZscgTANwhmRPC/DwwnhsU0OkbDJtDK+QGM56ps5JoGD1Jxx6NQiP9VGYcLKW5ES2izoErNn+eyMmApvMfG9wXmLQBj0/E6j1SdP6z8/p+8yDD6IuCwHp2AJeH3DZrcD5xdNeSSl7e9uB5gC1FIPIKAj4SwI/csGXTLRDSTAyt32XD5n1dJl2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26McHk1JtGzV2uN6agNf+AGwSTBiMMUxFrltgo9WyLk=;
 b=OBnwn1fOUF4QSZf3hUenIZCQMsh/8zvUe0hRTn3gNT0uusfyo4ioqtjB0Aun0BKFCKcJi7behnFD+mmVOlUJ7klj2Fn3kUznbXzEGL/26rid5XcpY4SGpPa6d6Bdn2TvSnTzylN7R5hWbossBZbMhuLATHgzlHRORILx84dKGLqzsYulXAYmWrsV5ffFfXMSR7sDIQCSQwRVjhs0lUYZdcXmi0eKikMiYOLymNdBt71BSR/td9zQr8e9PdWYExftPB9tYAfKwJOSyptgwaDOnHNS+BHgo+w/aqSaE+NA18YXHheYeqR+tZruAlLhvTRNODQfYou8ZhuxbDe/HQBghw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CY8PR12MB8194.namprd12.prod.outlook.com (2603:10b6:930:76::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Thu, 6 Nov
 2025 01:20:41 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9275.015; Thu, 6 Nov 2025
 01:20:41 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "hch@lst.de" <hch@lst.de>, Hannes Reinecke <hare@suse.de>
CC: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 0/1] nvmet: add basic in-memory backend support
Thread-Topic: [PATCH 0/1] nvmet: add basic in-memory backend support
Thread-Index: AQHcTWHrDheTX3CfYEy0GSlVBKKEm7TiUwYAgADjKoCAANs2AIAAyveA
Date: Thu, 6 Nov 2025 01:20:41 +0000
Message-ID: <dd3a31e0-a170-4d52-8e11-c7229b955a76@nvidia.com>
References: <20251104080610.183707-1-ckulkarnilinux@gmail.com>
 <c705eebf-bb76-4bcb-8630-99907b1b6ac6@suse.de>
 <0c299f77-e93d-4c96-af71-9e1ea387c9d9@nvidia.com>
 <20251105131414.GA19044@lst.de>
In-Reply-To: <20251105131414.GA19044@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CY8PR12MB8194:EE_
x-ms-office365-filtering-correlation-id: 5426724f-a1ba-4f32-b22f-08de1cd2b37d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|7053199007|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?ZmlXcGZiYmJ4U1hZcnZYbTZwWFBqSDY5WnBlRDV1QVoxTXU2YnR4RmdQYjJR?=
 =?utf-8?B?YnFzeG5uUDVsd1pYTncyR1YrZ0w3cnJtQnNCaml1UkRHaFlDWVdFZzFCQk9J?=
 =?utf-8?B?c2ZBVWxHcWpRQ0lXbzVTd3gzeUViSTVHR1ZTajEzQ1ZPenVJV0grcVdnWFhV?=
 =?utf-8?B?T05MdUVCZUhVMGczc1RZVzJ0VzhNTXZQRk4yMlE0WklGdjZROEY5S0MwS2Ir?=
 =?utf-8?B?UkhHRVFLSHV0RW5UYldIS2x3Uk5ya2NjakhpMmFiZ2w0bWdtVno2UHR6cVo0?=
 =?utf-8?B?d2d6WlJtbCtJbC9aRjUzMUpzeXkwa1RBN3RMRmc2cSt4akdhN01iSDVUOGRo?=
 =?utf-8?B?VkI0YXFsSzVhT1FrNUFxTG1FeEYzaEY3c1VIenVncGpPem1wcUQ1RWZuaGxE?=
 =?utf-8?B?UmFmckdDTHBmbUJWdk9LbHpiV28zR29MU1djRFBDTENQclRKUGppWnF4Zzd2?=
 =?utf-8?B?RVpRY24xSTZ1M2c1UXBvUlhHRE4rRGIzUXliRHY4MFFZZ1RoT2F3ZFlNeENn?=
 =?utf-8?B?N01NOXU5ZnVXaTIvTng5dUNKcDJIYUdnR2pQMDBUUVlLSWlOaUx4alo4Zjh6?=
 =?utf-8?B?aDMzZWZ6QXNncjFySk03RmJqT0g0MzhBSGpoWGVvMFl4bjdWTVdFc2ZvWTFP?=
 =?utf-8?B?NzFQN0cyN3RUQVd4QWpsbWV3a1RUNVhZT0JsQitSa2JBbkx2REpkQlptNnFM?=
 =?utf-8?B?K3ozOFFyNVVNVldKZ1RvVjM5a3ZzTEJlVktzd0lZUEVrWmNlREIzTjNsdFQy?=
 =?utf-8?B?ZHowK0wwbyttOXVQK2Y0STFUTzFzL1dFZlRkS0ttenpIK2I5V2JObmdkL0Jx?=
 =?utf-8?B?ck1lNmo0UVZvMHFMNUUwV2kraHpHZWNsdmhrdmtOZmxiTWdPRFZBcEg3TUlZ?=
 =?utf-8?B?ZkdkaFZOS3FFSDRmNndISjhWK0NEVldESkhEOFFaOFEzWVFyNkRSM3ZueUI0?=
 =?utf-8?B?WHB0ckxWeHdKUWIxVUw5azd6TVBZbGI4THIyNHFqRUxaemhRUVZSNnlSS1dX?=
 =?utf-8?B?OThCTTZIeXZ5Z3RSQU00dlMyTzhVNTd0TDNuMHBlU0hTTDdCNmRWbjlUeVpH?=
 =?utf-8?B?RC9LWmF5eENNVENEWUVlakZNTVROWER4VTlVQ0J4UmhINXRJYnFsS0xYWk4x?=
 =?utf-8?B?clpVRjI4enhvSGgwdytRM055d0UwV3JmRFQyNEI3ZFBtTWVkeXV6SXhBNkwr?=
 =?utf-8?B?LzZQMzZ2eXdsVmlWWElsSWg1bjh0SHVEWkNtbDRSQldFYWw1UjM0UlpWcG51?=
 =?utf-8?B?Tk1idlRJZjZhOWRYM1dCbEUrMkpoQW5RWERIeEFwdTlZY1pOSmkrQ0xoblFQ?=
 =?utf-8?B?YzErUGt5R3dMcmZoc2hmOU1mUGh3VndBR0JjZnp6cU92Ris0YVk4Y2k4bUla?=
 =?utf-8?B?ZndkeW9HU1N1bEtoclIzbTN5cURwUHNXWnVTMklzZ01mV3BqR0poWUNubXFT?=
 =?utf-8?B?SFhYcmZ6ejZGRC95M0xSUWs3TVJLNzhvUTF0QUdFWGdiQVBhNzVBWkJ4aTRn?=
 =?utf-8?B?LzhmUXlnVXBPdDdGWUJzN2ZrNUpNUDJMQXFPdVRncVdTSWZVTTdDMEpUK3Vr?=
 =?utf-8?B?UnpQQkY3MHRwUStOa0p1elhIRmduRy9ScUd5WGY3QU9xMDJPL3hHTVpjekJx?=
 =?utf-8?B?bkdNQXN3enVLY0I0Qm1qS0tad2xyZ2JzT1l5ZjdheVAxWkR5VDZyR2ZlVnNn?=
 =?utf-8?B?UXk5SkpWRERVVHZNcFRmQTVPR1VsWlRmSExqRDJFUXcya3lMZWQ2UXh5Mnhi?=
 =?utf-8?B?eDRBd2F5d2dFK3JYUFJ6aDJxaXo5L3NvNFFudFQwY084VmhMNzlZbGlSdVJR?=
 =?utf-8?B?dk41QUtkVTNYcXlGV0tFU1NqbHBiSXZKY0lhSG5qVktnM3RJTTFEQzlpYnZN?=
 =?utf-8?B?ZVUxM1l0eDRMalhPM2czTG9Bank0ZjVPcUdSWmxNbk9PYlVpRlAvd3NjdFJW?=
 =?utf-8?B?ZFRwb0tIdUYrVmUxelpVbktZTkFGcllIVmxlWnpGUWNFRzBUSTRXR1dvblJX?=
 =?utf-8?B?ZDBoZExtNm9zdDBia2dSYVZVdnNXQXduK0UrRmhwOC9PQUtEc2dNaE9TbzJE?=
 =?utf-8?Q?PYmNEo?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWFXTHNMUnJ6UURLOTdkcUJ3NmhGeDBzVm1ZRzA0R2ttajg2YzBPSEl1QXlK?=
 =?utf-8?B?Mmswb0laSm5UOEZHVXY0STlxTFVvdTUyZEhBTjhSNXAwUWhLUEZIL21DZFV1?=
 =?utf-8?B?Qy9hcWJxcjFITjhjVU44NUpwMVUvemdXdGgzRW1vYk1KN280cXo3TU1lVnRR?=
 =?utf-8?B?a2VXWE9mODk3NWZkSktYSkpsMWlWcC9XRUhXSjh0eGJXUWp6OURnWHY4Ty80?=
 =?utf-8?B?RWR2dUZTWkQzU2szdWVVaTVwMFFmSXhEemhabUk0MERCemYvaFl4Qmo2bUdH?=
 =?utf-8?B?dGY5cEVNMEl1NUFIT0R0ck5JN2VnUXBDRE5scTN5YmxkaTZHUnB6c0ZzbElt?=
 =?utf-8?B?V2dHZkVQa2U4SnJqbGxveEZlbjRyK1JkZzZaUHBTZ1M4Vlo0NWtTY1RNeTJU?=
 =?utf-8?B?emZNV3VpZlJTN05tZG9XVFNEdE9xUXpMVnllRlJUUjAyeFNOei9qclBpOWdy?=
 =?utf-8?B?MjllT1lLNldjQS9xU0tJV2VVN3NLbDFENlg1NHN4U0k5MW5MVDFsMTI4R01z?=
 =?utf-8?B?a0pTWVNUaGkxWEw4RmZ4eGF0Z1JhVWRXTGl2L05TenBobFlKY0RWTUdpNS9H?=
 =?utf-8?B?akljSXh1V2tITkxHdkNSUmFtaWVudmZvS2w3Zm53MCs2WTRuS2hmTVFoQkQr?=
 =?utf-8?B?QUFyd1YyRC9vMng2OHo5ODBGOUNQTjJxOGRRd3I0VnVoNU9IV1cwSnFGTWtp?=
 =?utf-8?B?bk8rclQ5MUtlYmRZTEdNblR4NlgxUjlIQUMrcllLaTdHT3VwaWszeGNSMHVi?=
 =?utf-8?B?dU1YbVpZNHZ0K0RsRFNicnUrbUJBSWZTSm84U01BR0dnYlM2dkJPekh2djQv?=
 =?utf-8?B?b0R3LzdrYlh1WEY4czZ6U20zbDVRZElnMVFLRXJsSDFnMWxFR01vY0R5N1lO?=
 =?utf-8?B?QVA4bXVJa1JWallJZzZsL2xaRFFZdUwrUHNrQXpYWnFCNnlORVN5N2V6dVgv?=
 =?utf-8?B?ODF1S014bXl5bEFGTzJ2elEzcmRlallUaVVoVjdwbWV4NENhL0ZoMjZjRkh5?=
 =?utf-8?B?TVoyYlBTbkJydFdZVFhOTEtvVEF4UWtKcWQ1VHhmd3J0aUI1KzlXdWdXV0E0?=
 =?utf-8?B?Z2hCMzlRNW9rTEtJUEJZMlRkNDIzUXBsUXNtUTAwUkRTbExUdEpWVVlSZFdI?=
 =?utf-8?B?Z3Q1bVE1YTVDYjFiRlgyNGtjWlp0Qko3amdGMjZncm4wdmt0d0JwZWNyUEZv?=
 =?utf-8?B?MWQvZjNhZkl6b1NmTEs2RUh4SmxDdFdmakI1akFoblRWZUhkTkYwMHhXelhV?=
 =?utf-8?B?dzRvWFBOYUxRNzUrU1B2elhtQ3BBNkdIOUNTS1h1RW9vQ3pvWHEyY01rbTFp?=
 =?utf-8?B?RHhScFp1WHVvU3pSUGtwYmFER1RYVmFnczNHTUV6bDV6KzVFek5ZWFR0K0pq?=
 =?utf-8?B?bkdUY0xaOWNWd1pJcHI1MVFmUWhCc3dCMFlmbkZYQnNVY2ZRYkRVZU5sRmxk?=
 =?utf-8?B?NlVpaHhzNHpxa1Uxb3ZKZUhraHpRS2hhRGN0OS8yYnp3a3BMWngzNmlCS3lS?=
 =?utf-8?B?bmlhM1ZzQmlsb1ZMM3VwNnBvS0tpMXFId1FUVHpLUU80WGRNZ29OYU9qb2o5?=
 =?utf-8?B?L1NTYVRPZkhmb1lvT25CVFJJaFF4U0hJZjZlYVVCOEVNaHVIK2d1djJrTFp3?=
 =?utf-8?B?RVhFelFXT2hMaENxcWtkUWVoQ1pYZzl1b3FBNGpSdXF1cGRrVlc4emowWEY1?=
 =?utf-8?B?dEpQWWlaSkxLQ0JSTEk1bjlma09rTWYvRXNRdTVVa0RiUytuNFo2TDQ4LzJL?=
 =?utf-8?B?SVBWellJYVhYSFIxSkRzNnNYQ2hnKzNGT0ZET2FMMTFIa1BoMzhRU0ROREt0?=
 =?utf-8?B?QklQZlZZRjBQWFFXMFcvYldIWEQwSng4bExscHhqMzd1OEJWK09SdXgrbCsw?=
 =?utf-8?B?dHR3TUR2OXRkdzF2bFVJQmcwZ0VLenZrTVp5cUU2VTR6SFhuZXRHc1ZZTmZo?=
 =?utf-8?B?RFZjNXJXcmNhZlJBbW1DMjNIL1Yzd1hVOVViTEE5KzlOM1pzckgzZTVYUjhP?=
 =?utf-8?B?VDUyMUVYaUptTUVKRGJ2NmhDeXZJb08vMWU5SVFLWUNhN0VpRjZyak14OGVE?=
 =?utf-8?B?MmhsRDlJNGdJaTNJSXF4TUxxYktVKzQ5K3BQTEpoOXgyM3phdlR3S1AyVUd5?=
 =?utf-8?B?a0c1QTM0N0NwTSszVXFTOUZTaThRUVh6NkFCN0psckgveGxKR25SNkk2NTl4?=
 =?utf-8?Q?hJwpTFab4MI6ATqypMEx0poBPuFd9LIt1+6OWgwPM55C?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <577FF76203B39F4484EA469D2A3ABDF8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5426724f-a1ba-4f32-b22f-08de1cd2b37d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 01:20:41.3182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Kcx5J5518NgJ1hGIfEFNZ64dZIp9xxQgOcO/DVroUg4rCOgN760ZVi+Ti2b9axVIm8XgwirPxaGNaMzeiAU+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8194
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251105_172049_809056_709FC9B7 
X-CRM114-Status: GOOD (  10.40  )
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

SGkgSGFubmVzIGFuZCBDaHJpc3RvcGgsDQoNCg0KT24gMTEvNS8yNSAwNToxNCwgaGNoQGxzdC5k
ZSB3cm90ZToNCj4gQnV0IHdoYXQgaXMgdGhlIHVzZSB0aGF0IHJlcXVpcmVzIHJlbW92aW5nIGFs
bCB0aGF0IG92ZXJoZWFkIC8gaW5kaXJlY3Rpb24/DQo+DQo+IEkgdGhpbmsgeW91IG5lZWQgdG8g
ZGVzY3JpYmUgdGhhdCB2ZXJ5IGNsZWFybHkgdG8gbWFrZSBhIGNhc2UuICBBbmQNCj4gbWF5YmUg
ZHJvcCBhIGxvdCBvZiB0aGUgbWFya2V0aW5nIHNvdW5kaW5nIG92ZXJseSBkcmFtYXRhdGljIGxh
bmd1YWdlDQo+IHRoYXQgcmVhbGx5IGRvZXMgbm90IGhlbHAgdGhlIGNhc2UuDQoNCnRoZSBxdWFu
dGl0YXRpdmUgZGF0YSB0aGF0IHByb3ZlcyByZW1vdmluZyBhbGwgb3ZlcmhlYWQvaW5kaXJlY3Rp
b24NCmdpdmVzIGJldHRlciBwZXJmb3JtYW5jZSBmb3IgbnZtZXQtbWVtLWJhY2tlbmQgYWdhaW5z
dCBudWxsX2Jsaw0KbWVtYmFja2VkIGFuZCBicmQuIEhlcmUgaXMgdGhlIGxpbmsgZm9yIHRoZSBj
b21wYXJhdGl2ZSBkYXRhIDotDQoNCmh0dHBzOi8vcmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbS9j
a29vbGthcm5pL252bWV0LW1lbS1icmQtbnVsbC1ibGstcGVyZi9yZWZzL2hlYWRzL21haW4vUkVB
RE1FLm1kIA0KSSdsbCB1cGRhdGUgdGhlIGdpdCBjb21taXQgbG9nIGlmIHRoaXMgaXMgYWNjZXB0
YWJsZSBhbG9uZyB3aXRoIG90aGVyIA0KY29tbWVudHMuIC1jaw0KDQo=

