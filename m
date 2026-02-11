Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57EDEEB5965
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Feb 2026 04:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z9bLG1NZhw0ncnpwoCK+3oahZy+K9+/gVT6sn5m3WH4=; b=ndhff/whslKhIBsn0STbP0A023
	lgYSTiTxb1Kv/WTZ9UZZgd/6/Nn9hyXr9i+L7d7FdcD6rO3pZbkbwbVwJBxSq7Fxi+s3uO/bkMZDA
	Tgb7g46g6oaHsTcOLhlbiwYs7BezN4gb7FbpS+99MtODl7yVH759saNaOAMexcxzd9u0+n70um+EG
	rmZnMA8trGxRzKWMbLEMsVvYcAcSMpuHlS1ZNCmD08DW2/YODafLhwmq6VDsKf/mSOY9KTFZWGPny
	qxsyhEUvMh5Lzjt2sliaEgB0M3XtAPl/sdKOFRCHQSy5T6Dq9UcRixyXZG+TeFEeX0WmUnsx8ulpA
	lRBQ5Hlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vq1qa-00000000CCs-03rs;
	Wed, 11 Feb 2026 04:29:04 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vq1qX-00000000CCU-2hKs
	for linux-nvme@lists.infradead.org;
	Wed, 11 Feb 2026 04:29:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1770784139; x=1802320139;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Z9bLG1NZhw0ncnpwoCK+3oahZy+K9+/gVT6sn5m3WH4=;
  b=QGWfOCZXUX4MsIGCAo3gPXF37Gj1exQUIpUymYu7qI5FZr5fuJCEl3+C
   9cg6rYh9OCcphqhYj2TJXFRFUOOKk+vHd9lQUv+bFs/INnUNEGPTcMGdd
   fW7n5yV3uUAUW15CdSJ2ou9sQjtgt1XaMhFYlhUa7iDiDKkclpEj8NzS9
   aD/1Fm6yq+AiSehD1RR1A9yXGPrg4HXXJnNahYdiWz+3/v8XhQ6PXERre
   f7LQKS176qKsvnrqkVOZPTxml8ZNOD2s4RTmx2Jc52Gpmqv8u6jhqZ8Dn
   H0XQwk83Nc6r5o2BGWpyWU7Gqyq1MTX9tuEkJDpsvN6EE04mW1BNH7e9/
   g==;
X-CSE-ConnectionGUID: t0ewa6CgT6eW9c3SkVZBRQ==
X-CSE-MsgGUID: gd35HaAxTLqd7tHZadUYaw==
X-IronPort-AV: E=Sophos;i="6.21,283,1763395200"; 
   d="scan'208";a="140182757"
Received: from mail-westus3azon11010006.outbound.protection.outlook.com (HELO PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.6])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Feb 2026 12:28:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fyPSilUIwry+QSK0iZz1NBPQXHfOeRK9lMfzXS9yv6ki8PcMp3SzAXB+B6nZWikpnnqB1Yn6B/4QRUh7qv7cPtkpRBvBad7C8uHKzLKR/zDyO6vUdIotwGZH63LO/Hevr9IPmbD/LWWnsIP5arf6I81cIbPtwQpzjGBbdUSvv7rgjftHJjKhbypKrKageWs0jCsFVXtguODSUIvLiGRtxtZz2Zd5i2zOga6o0bj7g0p8QaTKiq5KzMJEMJ+44Y0AJVDOPwlLFmZYV6lrowTYm11cA3WLE7Q9x1H+cwX1ZYyuSdKlN5FPAcvlIC726fawNG9R6frJKqq8Tyjxe401UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9bLG1NZhw0ncnpwoCK+3oahZy+K9+/gVT6sn5m3WH4=;
 b=PSkn2IctchSCUWqoOTYj41rbzedYLF4tV3dX/F3CekBsrJKO5V65ZY/uOL5pKxVGbFL/QozJW/fU3w9WcfSLRIfDo+vQ5yeLR+pCnJfQ4JqWs1gERhbgYa4R24PCL9Z2mJ7uRYQd2x5/FfLbrIuUmAL1IIo2teQOFGPKFSh7CFK7pXtUSdxCTfAIuP+5sScpNUJhshL//AtCCIeiNgt8GXotAWQCfxWzxbwp59C5E806JYnld/pOcVP4CXMOrvRRJOsD2ErlSoyHoUvdhmPngZ5jZpGHtLJYa/qolwQLiS6osDRQE9xIK75Z6lBOEHRai9+XSuU7t+oNVXCWMdginw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9bLG1NZhw0ncnpwoCK+3oahZy+K9+/gVT6sn5m3WH4=;
 b=m3C2zePYl7VKmS9stPHJTzSHoRORCqLpBnMkFTx5OlCjmdoq/XAcyNiAkc7DSOJAjaxOutlz1lN8F98nnjjsQ46WP09TQnand+1B7yqqZGVjNSJKWDOxOoBShkTYRLOymGs6hSov24ZanWPNJlI11Jg4IP7lU2jxyq/ohWkIqeI=
Received: from CO1PR04MB8300.namprd04.prod.outlook.com (2603:10b6:303:157::22)
 by CH4PR04MB9248.namprd04.prod.outlook.com (2603:10b6:610:222::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 04:28:53 +0000
Received: from CO1PR04MB8300.namprd04.prod.outlook.com
 ([fe80::a603:6dfb:1d4b:b36a]) by CO1PR04MB8300.namprd04.prod.outlook.com
 ([fe80::a603:6dfb:1d4b:b36a%6]) with mapi id 15.20.9611.006; Wed, 11 Feb 2026
 04:28:53 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "kbusch@kernel.org" <kbusch@kernel.org>, hch <hch@lst.de>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "dlemoal@kernel.org" <dlemoal@kernel.org>
Subject: Re: [PATCH v4] nvme/host: fixup some typos
Thread-Topic: [PATCH v4] nvme/host: fixup some typos
Thread-Index: AQHchSCaO0WHVdEc/0adeepua77uNbV9E5gA
Date: Wed, 11 Feb 2026 04:28:53 +0000
Message-ID: <18e09860f731dd83c206e286f570ac77a5186ce9.camel@wdc.com>
References: <20260114063722.68846-3-wilfred.opensource@gmail.com>
In-Reply-To: <20260114063722.68846-3-wilfred.opensource@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR04MB8300:EE_|CH4PR04MB9248:EE_
x-ms-office365-filtering-correlation-id: 2ee11a54-c946-4374-0f15-08de69261042
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?UGhneWVnR1FabHgvVUtwZkRWNHY2ZTRIbGp3elg5czZBZ1d6YllObWFuaTVC?=
 =?utf-8?B?VlZQSzFoY3NVNkR3d1VQWnFqWXhFaENwQUEwY2FvVEs3YWhJenNodFNqR3RD?=
 =?utf-8?B?OERtSTRIUFFSTE9GYWtraHFXNFI1RHZmK2dsUHdqWWdUQjVKSTM3Z21VV1hS?=
 =?utf-8?B?amc0aHkrQjV0OFgrLzRQNW5qdU1VM3RROHJWMUR4d1ROVFVmTnVGNVJrR2Q2?=
 =?utf-8?B?ajBYWk5SOHkySkE3YUpOSFB5TVVQVGpmNm5BaGYxekN6T2p2NS9FdVRBazVQ?=
 =?utf-8?B?VVR2TEtvdDJ1ZnNLdE9mQjR1K0h2UVZYVGlweVJNUmF0eE5LRHhwaXQ0aDh1?=
 =?utf-8?B?ZTZwUGhreEVibWppclBOR1ExYmpsK3lmSUtEV0ZjNVNlNTBtRHVVa0hpMk10?=
 =?utf-8?B?NWZ6enA1TFEwdDdONXcwbWwyVnRBaU9uWkZqeklESWZ0b3BBMDk4ZTJtQjhZ?=
 =?utf-8?B?V0t1K3R5ZVRLRXdGdStkaGh4VGgweC9MMVA3R2t5cHRRcjVNNk9jUkkwNnJn?=
 =?utf-8?B?VldvdGNwNlVBLzJNd281dXEwWUtFSk90VmF0c2wyWG8wbTU0blV2aTdjMGRU?=
 =?utf-8?B?aUtNZktVanFSandLRzlkTFBZUTk2djZHcVlBUVFBTGZYTldkZUY3bmZIOUhV?=
 =?utf-8?B?MDd1eEdJcmh0ODFmcXZ5WVhPV2hQOUYycEsrM2hrb01Bc2NBWFI0OWpPOElQ?=
 =?utf-8?B?NmpFcS9DSzVMb3VkR1V4UDFQaFRnRUFVbkZCQVNIZUtDR0ZybmlaRXpkUFFn?=
 =?utf-8?B?R3F3RTRpT1VVdnRBVTh0dVQrdHhuMlZ1ZEFoajlqOFo3YWplSUt2SHVtemNZ?=
 =?utf-8?B?UWlZZ2hFd3ZiajlHMDRtUi9nU2t2cTJWZHFNTDdWN3dRSUFFMk5iQUgvMXpz?=
 =?utf-8?B?WHo0WlZQdVlWSklqOU5DdCt4SmZGZ2RIaGZMRFd0NUR3cGRpMDJtc2RFT0M3?=
 =?utf-8?B?bGtXV3FrUnZjWG5RdTVEVlJ2QmVnZTJPb0c3ZWNyQ29PODIyMXgrNENvd295?=
 =?utf-8?B?a1NQYUdQZlArL2M3TXBvazY1MzdGQ2VLdk5BblhabUJ2UjIvclp3MnhhKzYr?=
 =?utf-8?B?aDFGWjN1OTlDZ21jWTk1NUJvT0c1VzZoL2QvTFByNnp4Mk42dFQwQXdHS2s2?=
 =?utf-8?B?YXE1TjIyUlpBbXM4MGVFeitPcmFPcU1aRU9VY2VRMzgvU3hmR0JZemMvTmFv?=
 =?utf-8?B?OFZUaTdUbElZTXlsa3hmbjAwTEFFOStUdGdTSTVpVG5RbmZ3VDA3cjMzeUNF?=
 =?utf-8?B?ems3VXNUSUxXaWd1b04zdGExYTNxaGRyOTFxLy9qb1FVdkdmaXZwaFpxSmJk?=
 =?utf-8?B?QVVJaEFmUktKSzMxVXFqK0pGRWs1NFZkTWNGU3VYTlExUlNJOVNoNldwTjk0?=
 =?utf-8?B?UWdER3VRTm5hcCt6bHpyR0dOQmJNUUd5OER2M2hzOVFEV0p3Q0ZPL09aSXNC?=
 =?utf-8?B?My9iMVFCRjVVV0pEWEtUQ3JlTkZZWGRqNFJSUjdXUHRsWTNYd1AveFAyaGRl?=
 =?utf-8?B?eExRa0QwRWF5Z3kvdjhOZkRyK1JWT2ZpaHJWS1V5ZUo5aXpEUjluU1FJZHFR?=
 =?utf-8?B?Qm5qT0o1d1hrR1VORVlOTUx2UlJTV256djJLZkFocWtLRFM2bGlCSFo2Qk5x?=
 =?utf-8?B?SnF0TEFjbjJYSnNmdlY2dStSRjBJQWg3ZDlDRUZaZ2ZZQmFSUmNxYys4b3Jk?=
 =?utf-8?B?b2sxYVBhZW10T1p6cGM0OFBPUGxDVFBqNDZNYU0wRGZxWExaQWpzZEE4ZENV?=
 =?utf-8?B?NmtYRytlZW54YWRCbGpNMnNYQmllTTR2U2ZUaGVTOHR1L3d5MnVNWExSMzQz?=
 =?utf-8?B?Tm8wdldoZDhHeWlnSUl2cy9QbnFuMDh4TUFrdDAyMW9KQytJVFpPNm8wc3py?=
 =?utf-8?B?Ty8xekVsZ0EwUzFxS1dCNmxIbjFJK1QrTXN0NTh5bldFOVJkZ1RVdDJFUThT?=
 =?utf-8?B?TnBGNW9Ra3hRMmtHMkxQUVVPeEM3LzZmWms0eXdraVUxenBaUjRtSTFKbTJt?=
 =?utf-8?B?M25OMlkwT0hZTzBiSkFzZGxQTnNGZmZjMC9YL0hudUJKM0RoSUlWWEtUMUlC?=
 =?utf-8?B?MU95VWowVzZ0UEp1OGZ2WnhEU3M5L04zdTZFZ0FvdDFqRHhHdTNFb09yR29o?=
 =?utf-8?B?LzEwY1pFcG1VSWg2WThhUXNaUUhQcHpHQkZzSitVaUVGaWUwMmJpenljNG1K?=
 =?utf-8?Q?bOi4EsrOXwZ2Dn5YtV91LWo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR04MB8300.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWNyekdCTmx0VS9aWDZkeW5NU01OejFyM3Vickw0cWpoMGVqbU5STnBGVEJj?=
 =?utf-8?B?ZmVZZTl0Umc5WUNkS3NNYVFrUERJQ2QwTzVBY0lxRTdPandNckxlaFVFbkEr?=
 =?utf-8?B?bVNaWmx5Rm45aXJXcnRTRUphN0pGMnJJVVlOR3hqS3NibVBKRVJHR01LU3Za?=
 =?utf-8?B?TkR0ZDZSQnRDZVhNeUFMK3B2b0ZveEhTb05XSVROOGx0NVVOaHJhZnJ5d1VG?=
 =?utf-8?B?YXR5aGxaSzg1Z2J6TnArWlZ3ZStJSjdoNU9DUXRqM2pya3E0R1dLL1g2aTRZ?=
 =?utf-8?B?Y05aOUZQR3lPSTZ3MzdUT09YeHNkR29ITjhmakExM0s3TXpybUZBTFBTR2du?=
 =?utf-8?B?NUZyTm02R3lxMUpaTHMwS084bEU1bTU1dUNxWmsvaTVMUDZPK3IxVENkdTdE?=
 =?utf-8?B?bTRlQWN6TnZqbE1vb2Y2TFlvRnlhOUVJaVVwUjBieWVWSitaS2F4V2dnWnFi?=
 =?utf-8?B?WEtrY2w0cU9yQkswWlJmdVYxQ1FIWFZ6cUpzb3Nla25JWlBuUzdSdVNhNGw4?=
 =?utf-8?B?eDZrQUcyNjVZWUJzeDBOZHJiODJFaDR1SVp1TlltSytLR1lmZlYvUWxpblZD?=
 =?utf-8?B?YUpOZHJ4WjE5WGJjbHc5TmNGYU10R2FxaGpyay8zNkpOOWFmSHFrOWYraXNn?=
 =?utf-8?B?aUs2N1BDZnUzUTFPY1dITC9ha01LNlVJa0RGNkRaL1RVbktEaU0yK3F1OERE?=
 =?utf-8?B?bXBvbk80dGIyQ3JVcVRSQ1ZKVzBmMU9QL3IxUXo2V0loK0syVGZtZUw5ZFIv?=
 =?utf-8?B?cmZyTUZobnlmVmFqN3ZhOG5XaDBEU1RPUlBlSzlWamwyM1RXWFk4MzgrbS9l?=
 =?utf-8?B?V3FySHA2QkZyNHF5bEgxOFJXd0VGekMxQlVrdWdEME5DTmZyM2RqNkt6NnND?=
 =?utf-8?B?SHRqV0RSZDlGdnlqK0ZXeTBGWkNPYkxKTGh2eGcwQVdHdHlnRHFDeFFUbjAz?=
 =?utf-8?B?R01qRjhKWVJhS3VwTXJZdUtCYngxRHhxWVZJTUFBUkZxblpwVjlndkdWeVV2?=
 =?utf-8?B?MDY3TjB2ZTlhQUdNWnZoSENWWkNENUs5K2VvT3FLRlk3QzNsK0E4MmdVYlBq?=
 =?utf-8?B?cHM4SEx3L3ZQQWFqNUJTcHQwK08zWWFxZzlGaWFpL3M1eXp3VHRzdGtLQXBZ?=
 =?utf-8?B?T0hKUWJPSUoyZ1lWOVFHOXRSY2hORHNtKzVnU2tWMGVMaktGbGtLY21kdlpF?=
 =?utf-8?B?ZVBYUnN0Y3BlZ3hkd0JUSHZNVGJob2JrblJkWkNnazdCdmxINnhwN1VsemZ6?=
 =?utf-8?B?WFZsc0pUZEx2ZWFKa3pzK3VUSFMza3lZTmNYaXBWWjdlUkVnRWxrUWZqMkh1?=
 =?utf-8?B?NW1oTW5QYURRWVErZ1V2ZVdzVEgrSWREQnJwcDJOd1JRU3YzM1d0Mlg1UitQ?=
 =?utf-8?B?ajJKRElGazZrSUZ3L3dxOXQvV2RJOE9sMzR5ZHh4d0FFNHc5V1F0ZkZUWGVY?=
 =?utf-8?B?dDhmNTh6cS9IL1dkMkE0WUVUMURNMEVDRDBtSEQ4enhTT3RzYXZWcEpCcXdq?=
 =?utf-8?B?THEvYUtYcXhwYWxDbWhSdm9lUWl6eGx3UWhDR0MzU0RpUnR3Q3JacjQ2dnlm?=
 =?utf-8?B?Qis5T2hBMG5kVHg2Zm8wRVJSMnpHeUZhdm9BcWJHbDdoMDdGckE3R3RaLzZq?=
 =?utf-8?B?YnpPT0pTYXFYL2FGV2JrK0d5THBGYUkyY1RMT3dkYThza2hvSVFRUEZnR3l0?=
 =?utf-8?B?VXA4K1JqdEVIREdHcnAwMTlXd0psMGEvaFZiczJ2akk5ejM0dHROZkR4UFJ6?=
 =?utf-8?B?bThLTUUwRlJMVHBNZWhaTjFTMXZjZ1o1Qk1jZG85U0JSY1pEeVdPbUFxckhl?=
 =?utf-8?B?anF3WkxJRmF0TzVUNkxFTUVuNUNhY3RGejFiajgwcFNQNHNQcG96OXNONGJ0?=
 =?utf-8?B?Nm1GNFNha2FGbDE2aHd5dWVlMXlSS2tQRU4vRkt5N2dSMFc5UXRaOUNSWU5C?=
 =?utf-8?B?VkozcGhlWGpqTGNXUkxVQXZqd2R5Qzlia0pIa2k5MTNvTFNMN3B5SVdMZXFm?=
 =?utf-8?B?Q2xOakt2Z1Y2akNDazhYVFo3SEVlSW5idFVZMmlDYmRESm9GSXpsOGlRRlp0?=
 =?utf-8?B?bFNJd00wS2pmMjVyMGZqZ003S3hyc0dGOUsvcHN6NVFMNmQzZDJxZzh0b0tT?=
 =?utf-8?B?Yjh2VU1zMVJTWkxXaTd2K3pHRXFKV3F1UDJCWk1OajJlRlNoR0VrMDlWdEQx?=
 =?utf-8?B?SEpXK2RHU0ovS0ZBZTBQYndrTjhvMUdOY01UTWwvN2EwTVY0V3F1dC83ZGhO?=
 =?utf-8?B?ajdmcVdLb2JhcWN3YTE5K1Z6eG9SRnR4MkdzUUpWWUwzb2NBbzNvUVF6Vml0?=
 =?utf-8?B?ekZYakVBSno2TnJwME9BVG9IOStOeWRQOTRGRzluVlhpdDVWWnFrRkdxQ2x4?=
 =?utf-8?Q?aU57cZZgfk39eFRc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA161181D3C57D459C3D76217685C966@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dd+YLzPHDskgcPAJok2LgZUoFdVOwrddsm3ycb3mMm8IRM9LPOjxgT3RglNC0Ki/Wv/GjFLxCXrck5oblBM047mfqzN0ETXxg0EKubQ52zVuWHeAxxq/ic5BwBTXhHpKQJkEWwdVXrjOTKrrE7+ILSYOsaMLgVa+k37PdM5tca3AdXW7Ambs/CEqAh/7WgPo4m85G+MmHxOeEJJAnJwfBLXFnNdQBio/7q81WWWIUY//Hze1FXURlIrWqcRrGncG+Ne+mhUMlTetzBA33t31yendTYKZTJ41D/MhLncN7HYfTqYAt4htY0YEaTP5SVHlxmsf+go4wYL5UXcvv841GSnkWdLkyPKTqnhp2i77u5XG+BZZ22XRrY6XNa9Tumk3HbHdFiacmwUnCxTF0X4d9vt0dyF/+PmuoDRIV5uD7ghg3OuauAUroXMeH3k1FDl1ks0kTlUvkSB6Vsap1gk3YOq64JTPO0Pa5zUJg6yVPMN4sTCdIxcro7nJ0jgaXfkoJhVRNYbRgG4JLfUL4ILzeWBPdZUGiPnMvWFWt4r2zSK5T/g7nUT4Y2Eo7pShnMEY/oA3eT0cuzsmoW0+mgyBPjReY7hp+n5u819mEODY5u6aFJGpUezfY82C8IrvS5Zo
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR04MB8300.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee11a54-c946-4374-0f15-08de69261042
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 04:28:53.5289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tNGBHFY2xsrdN4k+IoQUxyzc2SrnRgVzZoAj1zVneJ0os+h4Tn3twaZKSKDXCvqEtEcO6hzr9k+ZAo0jP/7PgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR04MB9248
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260210_202901_695664_A677D323 
X-CRM114-Status: GOOD (  25.88  )
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

T24gV2VkLCAyMDI2LTAxLTE0IGF0IDE2OjM3ICsxMDAwLCBXaWxmcmVkIE1hbGxhd2Egd3JvdGU6
DQoNCkdlbnRsZSBwaW5nLCBpbi1jYXNlIHRoaXMgZ290IGxvc3QgaW4gdGhlIHRocmVhZHMgOikN
Cg0KV2lsZnJlZA0KDQo+IEZyb206IFdpbGZyZWQgTWFsbGF3YSA8d2lsZnJlZC5tYWxsYXdhQHdk
Yy5jb20+DQo+IA0KPiBGaXggdXAgc29tZSBtaW5vciB0eXBvcy9ncmFtbWFyIGluIHRoZSBudm1l
IGhvc3QgdGNwIGRyaXZlciBhbmQgYQ0KPiBjb21tZW50DQo+IHN0eWxlIHRvIGNvbmZvcm0gdG8g
dGhlIHN0YW5kYXJkIGtlcm5lbCBzdHlsZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFdpbGZyZWQg
TWFsbGF3YSA8d2lsZnJlZC5tYWxsYXdhQHdkYy5jb20+DQo+IFJldmlld2VkLWJ5OiBEYW1pZW4g
TGUgTW9hbCA8ZGxlbW9hbEBrZXJuZWwub3JnPg0KPiBSZXZpZXdlZC1ieTogQ2hyaXN0b3BoIEhl
bGx3aWcgPGhjaEBsc3QuZGU+DQo+IC0tLQ0KPiBWNDoNCj4gCS0gTWlub3IgZ3JhbW1hciBmaXh1
cA0KPiAtLS0NCj4gwqBkcml2ZXJzL252bWUvaG9zdC90Y3AuYyB8IDggKysrKystLS0NCj4gwqAx
IGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L3RjcC5jIGIvZHJpdmVycy9udm1lL2hvc3QvdGNw
LmMNCj4gaW5kZXggNjljYjA0NDA2YjQ3Li42NjU4YTU4MDZkZDkgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvbnZtZS9ob3N0L3RjcC5jDQo+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L3RjcC5jDQo+
IEBAIC0yNSw3ICsyNSw4IEBADQo+IMKgDQo+IMKgc3RydWN0IG52bWVfdGNwX3F1ZXVlOw0KPiDC
oA0KPiAtLyogRGVmaW5lIHRoZSBzb2NrZXQgcHJpb3JpdHkgdG8gdXNlIGZvciBjb25uZWN0aW9u
cyB3ZXJlIGl0IGlzDQo+IGRlc2lyYWJsZQ0KPiArLyoNCj4gKyAqIERlZmluZSB0aGUgc29ja2V0
IHByaW9yaXR5IHRvIHVzZSBmb3IgY29ubmVjdGlvbnMgd2hlcmUgaXQgaXMNCj4gZGVzaXJhYmxl
DQo+IMKgICogdGhhdCB0aGUgTklDIGNvbnNpZGVyIHBlcmZvcm1pbmcgb3B0aW1pemVkIHBhY2tl
dCBwcm9jZXNzaW5nIG9yDQo+IGZpbHRlcmluZy4NCj4gwqAgKiBBIG5vbi16ZXJvIHZhbHVlIGJl
aW5nIHN1ZmZpY2llbnQgdG8gaW5kaWNhdGUgZ2VuZXJhbA0KPiBjb25zaWRlcmF0aW9uIG9mIGFu
eQ0KPiDCoCAqIHBvc3NpYmxlIG9wdGltaXphdGlvbi7CoCBNYWtpbmcgaXQgYSBtb2R1bGUgcGFy
YW0gYWxsb3dzIGZvcg0KPiBhbHRlcm5hdGl2ZQ0KPiBAQCAtOTI2LDggKzkyNyw5IEBAIHN0YXRp
YyBpbnQgbnZtZV90Y3BfcmVjdl9kYXRhKHN0cnVjdA0KPiBudm1lX3RjcF9xdWV1ZSAqcXVldWUs
IHN0cnVjdCBza19idWZmICpza2IsDQo+IMKgCQkJcmVxLT5jdXJyX2JpbyA9IHJlcS0+Y3Vycl9i
aW8tPmJpX25leHQ7DQo+IMKgDQo+IMKgCQkJLyoNCj4gLQkJCSAqIElmIHdlIGRvbmB0IGhhdmUg
YW55IGJpb3MgaXQgbWVhbnMgdGhhdA0KPiBjb250cm9sbGVyDQo+IC0JCQkgKiBzZW50IG1vcmUg
ZGF0YSB0aGFuIHdlIHJlcXVlc3RlZCwgaGVuY2UNCj4gZXJyb3INCj4gKwkJCSAqIElmIHdlIGRv
IG5vdCBoYXZlIGFueSBiaW9zLCBpdCBtZWFucyB0aGF0DQo+IHRoZQ0KPiArCQkJICogY29udHJv
bGxlciBzZW50IG1vcmUgZGF0YSB0aGFuIHdlDQo+IHJlcXVlc3RlZCwNCj4gKwkJCSAqIGhlbmNl
IGVycm9yDQo+IMKgCQkJICovDQo+IMKgCQkJaWYgKCFyZXEtPmN1cnJfYmlvKSB7DQo+IMKgCQkJ
CWRldl9lcnIocXVldWUtPmN0cmwtPmN0cmwuZGV2aWNlLA0K

