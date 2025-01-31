Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F762C0218D
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jan 2025 10:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ELVuShCAF/RMwsALKVev7m6FtwZPtjdnJ3+GNG3LIQM=; b=IPi2Q86RXo27cULhXxVLHkA2Kb
	mtL4LYTVuf3SF3qowBDe/pZinQUY80rTQKxwhvx2rRTAM/6XVtme5/O0VnWj+KhDSUcvfg2OJzxCk
	wsEFhAzpovXgf8vfXinmkPVDY1zKPeZZNyZTGqFlH0sTfki3Sidq7oiqcdie9OE2dLV/JeE2SF1bc
	XQS17msiPsppzMnmV1Xmb10I1e6lPnOPO/XB7PukzAvQ6xA7uTet2M6UW0o9cudFmakYze0jiycFq
	8z9eITfJTDniL83oEkoBQrFSQ+Tdcjp14oYwW1lqXG9aJ2zZAnuG+r/6B3tdJK5ceyoMz0hW7hIjv
	jHL09ePg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdoGv-0000000AOiB-12xd;
	Fri, 31 Jan 2025 10:29:13 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdoGs-0000000AOhi-1oGP
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jan 2025 10:29:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1738319350; x=1769855350;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ELVuShCAF/RMwsALKVev7m6FtwZPtjdnJ3+GNG3LIQM=;
  b=L0oF4dmIv3IYsPwsdfxg59MiKSwp+QF0tukUmilZ01NvfM2Noz16hoLA
   1jRHX+9DDknk+FFUqpKFC09AzO0Zuf+th4OlCKM2X89f2zbmWzq0cCuGG
   zHpkdLl590Xs81fRMz6WTXWzuWymkzlDptaPAdts4n8tWJKIWIgMm4ICu
   kYCpQrL4fXP1qb3CpiNoLHZuIUv5dxdWvQeGwsHWbK6KYyz3SE3Z1AEL9
   DHdN/MwewtZDkhCuH4VPuSH+c6t/4vvbIRAfMNSCs4ETFa3hOJIg+fMwY
   Vfgq2MULcqYH7cMozw7hbp0u1Z/y96AhSTk3Klt1eCmRgNL09B3JMCSbJ
   A==;
X-CSE-ConnectionGUID: U7TEfPBiQyuQ9b45d9L0KA==
X-CSE-MsgGUID: NwEDzmYsQcWOAWmS36HamA==
X-IronPort-AV: E=Sophos;i="6.13,248,1732550400"; 
   d="scan'208";a="38482644"
Received: from mail-centralusazlp17011029.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([40.93.13.29])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jan 2025 18:29:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uD0z+iy4xdBz+k2cUWpCe5WwDvDeSsDYnb9B/WaENaUHMAsrzZ+PYds6RpRUfJfres3F5TXOQTLQGs3Q39WctVrtHmV70cMMWeZBpPssEFFyQ6xQKs5EVaXCpDE1YmYRHhkMnKEzL7b1hQ3UUILNusH+b/4Ichp3iA9Hl1GfjdoNSX6uLrZA0rUlcSDSNHwS/hg22IQEV11fy5rgN20jhIDdtO2dCzUl/fRZ8trxObeTzf+dXJtranegu3H4tCRggU3ypxtIN4UpDxU96o1C7H1nrwVX4DdymOBpSTBtwKW98HwqRyHHZZSMB5mmB5X/fCC/PqSLddvEUb+3s4uZEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELVuShCAF/RMwsALKVev7m6FtwZPtjdnJ3+GNG3LIQM=;
 b=FFgJox0boNJ6qQYoOo42J8HmcikZpmx0Nna8Fq++EmHI5GJBBqhbOotHoQQff7Pu19lfC79TR1JwzNURn4QDLZau9g39SIWxVhTFBSrbvs+GKn27P1x4hgr81TM6WBOYE6UOZvO+jwihvTVB8fQn1TVqQ0nip3GszJIT09+fuWlPTwfAbDJ3mPYgqsvZVZOlR8xYh5gno2NzXoeKhLjYXSdH1viMMiu2l0WkKivDjC+rNPFV4sdBydCeKA780YlSjHVfGjHk0YZFF5h+YRZ2E+TnxBc3hSCktEhrPcZ0b4zh6C1E1YfpH10u/M3X2mVpYjen5xM0CoJKW9P1UeWtAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELVuShCAF/RMwsALKVev7m6FtwZPtjdnJ3+GNG3LIQM=;
 b=bYGYDhQ0Xmg+bheuLzKbkloV+FFvn3O4fe8WkZfx63u46MMt5ehu34OkSmFMYKvblCvdC2MjT7aJEJT+vcMnjRyhk11WWl9QMu/bDCHr2rDdMR0udz9f84ChgJYvhRyPPlbUgJuX6UJkoOk6GTzQbE01CGtMgdkB+GLJi1hoso8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH7PR04MB8756.namprd04.prod.outlook.com (2603:10b6:510:237::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Fri, 31 Jan
 2025 10:29:05 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8398.017; Fri, 31 Jan 2025
 10:29:05 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Kanchan Joshi <joshi.k@samsung.com>, "josef@toxicpanda.com"
	<josef@toxicpanda.com>, "dsterba@suse.com" <dsterba@suse.com>, "clm@fb.com"
	<clm@fb.com>, "axboe@kernel.dk" <axboe@kernel.dk>, "kbusch@kernel.org"
	<kbusch@kernel.org>, hch <hch@lst.de>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [RFC 0/3] Btrfs checksum offload
Thread-Topic: [RFC 0/3] Btrfs checksum offload
Thread-Index: AQHbclgBeWHKAo6I/kGqcNmmsyoZKLMt1wkAgALXZYCAAALFgA==
Date: Fri, 31 Jan 2025 10:29:05 +0000
Message-ID: <73ba28f4-0588-4ca8-b64f-2a6dd593606b@wdc.com>
References: <CGME20250129141039epcas5p11feb1be4124c0db3c5223325924183a3@epcas5p1.samsung.com>
 <20250129140207.22718-1-joshi.k@samsung.com>
 <299a886d-c065-4b75-b0be-625710f7348c@wdc.com>
 <572e0418-de26-47ec-b536-b63291acff52@samsung.com>
In-Reply-To: <572e0418-de26-47ec-b536-b63291acff52@samsung.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH7PR04MB8756:EE_
x-ms-office365-filtering-correlation-id: e1a7eeb0-25c6-4632-b928-08dd41e216b5
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?U1hqeDlXZ3RCWHlQUWU0ZXBwSVJRazBsRWNwNmVBYk9oT1U5TTIwN2YwWVRH?=
 =?utf-8?B?YVZqcmFwc1VWT3BNc3VLSkh5bHNEUnZkalZYaVF5cUpSVmZmK1pyZy9zMjFu?=
 =?utf-8?B?S3pmOTNmTS9iNE53M0svYmtNV0RMeFVIRThCSjFQMXZlYnJlZGNXeVVPaEpi?=
 =?utf-8?B?TDVKR29xU2VqbDNKWE1mbDAvTVQzazVWb1d3VW1ObVNSSGZUaGlsT1dLS3lr?=
 =?utf-8?B?dUhpTmU4eGlMcW1WUncxakwxVkVIT2NGOFhHSmtZQkJDamxFUC8vYnNxUlFl?=
 =?utf-8?B?YkdYcmFGL1FuOWRvSjhuQUpkSWNOQ2hEdXBlb1o2Y2xPWDZRbUVzRVJpZkhT?=
 =?utf-8?B?anhCbFk0MitMRkZsS0gzWWJma0crZXVaTXlNQ0hwZUFaZ3o1ZmRxQy8rTmxm?=
 =?utf-8?B?ckVjcHZvZXZLZmM5bWtBamk1cnFJYWgwUHk1UkZBRDBKb2wvcmI5UE0yUEhB?=
 =?utf-8?B?bGFLMzVoVVo5cEttdGlPNDRSd1hwOWo5Q3BCWWluR2Y4L0ZYUkJVeUdNVk5k?=
 =?utf-8?B?c0ZUY3BIL1ZYQmJzV2htMXM1TGVVZzc0cDg3OWZtbTA4cjJwU2l6ZXI5S2dl?=
 =?utf-8?B?bmEwNU1QeGhKVjl4VXVXQkc4bFFCNUVMRnQ4bzMyUm1jbWVONGk2VHl0c3Yw?=
 =?utf-8?B?Y3lwNjI2UlNIQ0NlRndKZXR0elNnTFRSK1dVV0s5S1FRdVREb1ZrdERCd1J1?=
 =?utf-8?B?c1J2dlUycXFUbFZ6RzdXdk12S2MxbkF3WU1mTkVQQml3YVlTazdhV1pSdGFE?=
 =?utf-8?B?Uk5mVHhxWTVBcjE4ZDlqWHBOemJud2lOU3BGRFJkQ2NyUGI2R1l4NGdvYXla?=
 =?utf-8?B?aXUyNDVrMzh0U3pXbitIUDUvK3owdHY3OVM3K3ZPQ3I5TVNxVXBaaUU4Y3BI?=
 =?utf-8?B?Y0dLajZRRnFyc3QzTzBrUGNUYXpIRExzeUo0Nkt6cmZiTHNJNmJOOGFLWlM0?=
 =?utf-8?B?TFprbVpTRFhtejZ0M0szdU9Ba0hBQXdNdTdRSitPekYwQlNiZnM5dmMzUGdm?=
 =?utf-8?B?WEYrRWxldE1VbGZBS09qaVlTVFlPa3BtVjNFZXJOWjQ4Y2xJQ0hmWGdZQ2RK?=
 =?utf-8?B?WDNMMzZiajc0eTVxSmwwalhBVlJWWlpFbGt5dmZIbnpyOUdKTzNjYitCQUpI?=
 =?utf-8?B?cVhPZVVrSzNDYWZzemM0OGhHbXZ4RHd4V1JzL05Ld2dmcnpNNHk1bVpiY1py?=
 =?utf-8?B?UUg0Mk53RDg4RzUvQ1puUG9VYzNiSElDL2luYUtuRjNMUHZjV3g1Qmt4TE5G?=
 =?utf-8?B?OVZuL2lCaUFPK1JnSlI1YjZzR3lGeG4xbEt4dklFUWgva0VYNXlaS0cxZE1L?=
 =?utf-8?B?azJLczhRbVNvbFVldmc3UytZZWx0NnVTZzYybmdxUzdZNFhJR0xNSWxQclFt?=
 =?utf-8?B?eWxWNk10NWlyVkM1RFF5aDV2T1VxYUx6QXQ0WW94d3NrSzlPVkVWcHNTcXZh?=
 =?utf-8?B?eFdVY291U2xFVFE1SlhrWkloRTFrcVZUWUJ2UHZpS1JPZmI3cHRPc2NkTWRR?=
 =?utf-8?B?NUE1aW92aHVWeUxzQlZ0aDFHQ0lmTjFNWk1ZZ3pJNjhwVnNxOEtscDFaSDVv?=
 =?utf-8?B?VkU2WE14MWNueGhscXBxZGt4dFNaU2xGL3lUY0FUZ1J5RFArNEdlcERpSEYw?=
 =?utf-8?B?b0V5K0NObE83SGdBTVM5U05PdXBiVko1Z0h3WUtTVjRGL0hoUTRRQmg1N3NR?=
 =?utf-8?B?cHFMejhhSldQdE15d2EyTnhHWXJ0bUw3SlIvU3pwTEVTVDhFRjFxbk05NTdv?=
 =?utf-8?B?QnVGZld0YTlFRUxQYW9sdzB5VFVCRlhlOGgyQmxTNy9aWGE1c2hjUjlOSnJU?=
 =?utf-8?B?ODFtSDNIZVRWaVFabFh1cXBoRk5QL1grRGhVVTJiQTJMalZSUUZ3QjdUTUlX?=
 =?utf-8?B?NEdxTkNGMXZacG8vMTVxbUdtL01YTmR1dENTRjhYWnlRV1RFSkN1d2tNZGpN?=
 =?utf-8?Q?YOFNj0s9MccScd0NTpDbZqNATEs0U3Fy?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UExWbVJlWnlpMmZKRDgrVVNCNTJISmREc1hJQm10Ryt6bHFid0RlN0N0TUwy?=
 =?utf-8?B?TEFCbEVORDd3VUkzYzduTW9KMFdMK2tEZ2ZJN250SS9tbVdxaGFvMmg3a1d4?=
 =?utf-8?B?anNtSHhDOXdIODhnc0VVRk1vcCtiYUE2WjV0YjBmNU8rVVBTM1hIMkF4d25Q?=
 =?utf-8?B?eTdjMWpjL1JWM3RJWGIyaERyMjZyWmlCZlgwakdYYjNGZ1hjOXVLdUtlMEg2?=
 =?utf-8?B?S2lzYXlla3RwOTlwdHpzWU9GRERhTVErZkNkOFE4bXFrd3NoM2JTOW4yUytN?=
 =?utf-8?B?SVptd3pyWXBrOHV1Z29zR2U1TitXWWRFbHZSejZFN1NzZlNPU1puQ1UyaHdW?=
 =?utf-8?B?bWNYV244N2xpd0RiblpXNlIrUVRUR0xSWjU4UmozMlJRZnVMOHNFejlSNVZQ?=
 =?utf-8?B?VUVLUG9VTm53K0NtL25CanpmbmE0L01PUjUzQXNMQy9JRWw4TThXREl4RFMw?=
 =?utf-8?B?b3RUTjcxckJoRjE4U2d5TUZuUENhRkY2NjNseXlTaW01U3dEdWV6eEI5MnNU?=
 =?utf-8?B?QTBNaWtBMEJtVDRqK3RFVVNqb3ZpQ3h4SGcrSGllK3BhTGIwcldsR3NLTXFx?=
 =?utf-8?B?aGs0UWRjczRGSVBVZ1c4S2lPMVVkZ2lGQVYwbXpwQVUxWmdnWmk2clNKY0dE?=
 =?utf-8?B?S3NVRXovTXpNQVFoOFRWcWlqakx1ZWlLVkxCTTE1M1R5N0YwYUo1U09WU1cx?=
 =?utf-8?B?NGNKWms5NEsvMk1MNDUwb2FpeFhJWmc3cEoxRlhCak54b1JCZURwT2llVkJK?=
 =?utf-8?B?WjltSjZDT2VKNkNmRFlWckFubzVKczl3YmZTLy9Ua2dlVmk4NENxWlcrVG9Q?=
 =?utf-8?B?ZUZvYitEYkZzaEZ2WU15UzArd24zV09UR1NOZ3hteTQ2bXNFMUlTOXJuTFhm?=
 =?utf-8?B?bkUxU25vVVFQeGt6c3RMVlI4Z2F6MlhkSkxMM1ZMTjFjRW8zSm1oNmJrQVFv?=
 =?utf-8?B?RHpBNWRiZmVWU29qQ1pmbDNOdTFJMmE2ZFRUcGpEZVc0MzN5aFk1Rys3dURZ?=
 =?utf-8?B?d25mNDhHa3BjTWRxYTdzSllMN3pEa0lveFBCQ2tkZklETWRFM1Y5NkoyV3Ir?=
 =?utf-8?B?bS9TMVVtWmxzV2thN2tYbXFqYzc3RTJGc2NCb3o0YlplK2V2WWVoOTBVZVBs?=
 =?utf-8?B?anFldEhHaEQzaEJEellSMkRGQy9XdnBLVy9aZkt5MHN4SFJKSFZyUTlnRlZS?=
 =?utf-8?B?TnkvNVB5bDZiNTQ4ZUhrNEpVU2xYYUh4ejBSZFUzY3YzRGJGQkpDMGl0MHdw?=
 =?utf-8?B?cEFNWEVIVXRhdS9nS2Z6VHJ0WkVYeExzdkgwU0pkaUxjcjZaczE0OG1uc29E?=
 =?utf-8?B?a2dWOUdwOWVwci94NnBZeGVSS0poNStLbWYzVzhFTDFlUE1pY01CTFdIc0Jk?=
 =?utf-8?B?cFJEdm5kMHAxMGU5dXdZRWVDYlpFSmUwQy9kQTRudVdIdmcxWG5waXRNc0ZW?=
 =?utf-8?B?WTZ0aW5yNWY2REtGNnRQdSsrYWZzYW9wN3MrWlZCQ1VKY2NsNGFNZzJxTnVk?=
 =?utf-8?B?V0tQeWh2dHNZaFhTYjNIVGc1V1MrZlhVdk1TUFlWQ3poVnlJcDNCbWdzRUox?=
 =?utf-8?B?NzFUc2FDMkR2T1lqL296d0ttVUJRNmhKVHQ3WjJzT3VoY2o1YUZsaENzWTJn?=
 =?utf-8?B?bGMwOHFjc2Z1ZUJjUm54TzNZUGhvU0U4ZG1GdmpXVFkrWW8rTko4M2c0bkh5?=
 =?utf-8?B?SjVXNGNlTXlnQ0NNS0o4V01TOU95MlRaL2VsUm1LbEJtMTY3TWxPbnFxQjNQ?=
 =?utf-8?B?eFdtM20vVGtRL0FYUkJKUFhRS1doZEt3SlkrcEdJeEZvUnM5WlBHQmE4bU8y?=
 =?utf-8?B?UHZlanBnSit6WllVKzR1dG5NelZuTnBJMHBkK0JDSlFYZDF1T3ZaaEwzN3gz?=
 =?utf-8?B?WnJvU3Z1QnBxUTVkWkJzUnY2RnFLOEdIcDA1OTk1NHJwQUkzbHNneXZqbEYr?=
 =?utf-8?B?blowNmJCRlVvR0xGcEUzTGRzcEFHOFhObXJrVUk3ZzVGVEpYZDVRNzNUNTNw?=
 =?utf-8?B?NjN2b2wvbUVCT3FwdXVDbDVLc0RsdUowRlg0UFZHcVlvRmNhNlVwTEtOd3Jy?=
 =?utf-8?B?cysyQ0tqNHlhUy96cEdCVGRncEtZMmdtbmdtTEtRUnZKOGd1MzNJNmYzcWp4?=
 =?utf-8?B?M0p1bW9xd3VBRldiaDg3dXUrTUJGSkROM01KSm1RUGMxMkR5WnRpQ3pTWDAz?=
 =?utf-8?B?WlluRGR2a3VVeDY5NWRiZnhHZlRCVUVSNWdBa2psb2tLTEd6dC9YaGYrN2NG?=
 =?utf-8?B?ZUg5VzgvZWxpNWNzZXF0VkpNNjRBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF94FD15E8E29F43A0C26331963F3D3B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vhHOjNBRXkv2fhJqn6hoqJEWrrZrySF5Us43XxBuRoA/AJ25K1qN4744RsoDUcM0qNqvmyOKSanfvEMDVPhsdZ340HfaHDZfAatJ33iqWv6Zz9zz/trparSyrDObGyZh+kYp5vRttIJDJGOsd42E5LkmuOHSVE+2aLTjMxs5eyl5iAUcr/cWnSG7+XSSZIQBdvGp+BZPrrEkZAJb5jawUE63mHBHEKr9/yIuUWhEiRsYoSjlpVctSB5Jach+imdgDZ6Pu2F8DUxTtzpwvYFQkPpqwxOmcIkm5qnaftSdRiQAkj7pa/M5gbmwwQRZ0tnLBVfZHg+xXzXOX2Z54EyGYMrQHDkwOhFtkuqzjKaLJfffzj26T1gYSB944t78DpTtyKqXrqFQ7plzNwdgqXIQ1xOmkBY5GF/+tlluFKOfPk/ZdElZ/NIBjlmL9ukdMIr2+gM8zoeewCb+Rgg8zlqzppwXInV5bbZaKjNq3OyYI4n+1ii7rqyLbTTwE8HN7Ix/PoUdSd6VpkyamADOI6dj1NbxPji5WnfTDkXhTADz44uwz/EDbaVGA+WR2kCkXHs/ztOj5kBRT4JIqwL18LTC6oHwHNNcBg/PlYzfGxyVC+L0WJvS3XG8acaUZgoxyaB6
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a7eeb0-25c6-4632-b928-08dd41e216b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2025 10:29:05.5414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ah5H4GaFuIUEGTNmKFjHB8ezRzpyAhDUTPrlxX47xzzv5oCLNE/caSR3mBnrxDwPYJMW2XhGFrVCyTZiQezvwi6B0XCsqSfz5ad6QPlqxIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8756
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250131_022910_487423_5620A5BE 
X-CRM114-Status: GOOD (  22.40  )
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

T24gMzEuMDEuMjUgMTE6MTksIEthbmNoYW4gSm9zaGkgd3JvdGU6DQo+IE9uIDEvMjkvMjAyNSA4
OjI1IFBNLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6DQo+PiBGb3IgaW5zdGFuY2UgaWYgd2Ug
Z2V0IGEgY2hlY2tzdW0gZXJyb3Igb24gYnRyZnMgd2Ugbm90IG9ubHkgcmVwb3J0IGluDQo+PiBp
biBkbWVzZywgYnV0IGFsc28gdHJ5IHRvIHJlcGFpciB0aGUgYWZmZWN0ZWQgc2VjdG9yIGlmIHdl
IGRvIGhhdmUgYQ0KPj4gZGF0YSBwcm9maWxlIHdpdGggcmVkdW5kYW5jeS4NCj4+DQo+PiBTbyB3
aGlsZSB0aGlzIHBhdGNoc2V0IG9mZmxvYWRzIHRoZSBzdWJtaXNzaW9uIHNpZGUgd29yayBvZiB0
aGUgY2hlY2tzdW0NCj4+IHRyZWUgdG8gdGhlIFBJIGNvZGUsIEkgZG9uJ3Qgc2VlIHRoZSBiYWNr
LXByb3BhZ2F0aW9uIG9mIHRoZSBlcnJvcnMgaW50bw0KPj4gYnRyZnMgYW5kIHRoZSB0cmlnZ2Vy
aW5nIG9mIHRoZSByZXBhaXIgY29kZS4NCj4+DQo+PiBJIGdldCBpdCdzIGEgUkZDLCBidXQgYXMg
aXQgaXMgbm93IGl0IGVzc2VudGlhbGx5IGJyZWFrcyBmdW5jdGlvbmFsaXR5DQo+PiB3ZSByZWx5
IG9uLiBDYW4geW91IGFkZCB0aGlzIHBhcnQgYXMgd2VsbCBzbyB3ZSBjYW4gZXZhbHVhdGUgdGhl
DQo+PiBwYXRjaHNldCBub3Qgb25seSBmcm9tIHRoZSB3cml0ZSBidXQgYWxzbyBmcm9tIHRoZSBy
ZWFkIHNpZGUuDQo+IA0KPiBJIHRlc3RlZCB0aGUgc2VyaWVzIGZvciByZWFkLCBidXQgb25seSB0
aGUgc3VjY2VzcyBjYXNlcy4gSW4gdGhpcyBjYXNlDQo+IGNoZWNrc3VtIGdlbmVyYXRpb24vdmVy
aWZpY2F0aW9uIGhhcHBlbnMgb25seSB3aXRoaW4gdGhlIGRldmljZS4gSXQgd2FzDQo+IHNsaWdo
dGx5IHRyaWNreSB0byBpbmplY3QgYW4gZXJyb3IgYW5kIEkgc2tpcHBlZCB0aGF0Lg0KPiANCj4g
U2luY2Ugc2VwYXJhdGUgY2hlY2tzdW0gSS9PcyBhcmUgb21pdHRlZCwgdGhpcyBpcyBhYm91dCBo
YW5kbGluZyB0aGUNCj4gZXJyb3IgY29uZGl0aW9uIGluIGRhdGEgcmVhZCBJL08gcGF0aCBpdHNl
bGYuIEkgaGF2ZSBub3QgeWV0IGNoZWNrZWQgaWYNCj4gcmVwYWlyIGNvZGUgdHJpZ2dlcnMgd2hl
biBCdHJmcyBpcyB3b3JraW5nIHdpdGggZXhpc3RpbmcgJ25vZGF0YXN1bScNCj4gbW91bnQgb3B0
aW9uLiBCdXQgSSBnZXQgeW91ciBwb2ludCB0aGF0IHRoaXMgbmVlZHMgdG8gYmUgaGFuZGxlZC4N
Cj4gDQoNClNvIHRoaXMgYXMgb2Ygbm93IGRpc2FibGVzIG9uZSBvZiB0aGUgbW9zdCB1c2VmdWwg
ZmVhdHVyZXMgb2YgdGhlIEZTLCANCnJlcGFpcmluZyBiYWQgZGF0YS4gVGhlIHdob2xlICJzdG9y
eSIgZm9yIHRoZSBSQUlEIGNvZGUgaW4gdGhlIEZTIGlzIA0KYnVpbGQgYXJvdW5kIHRoaXMgYXNz
dW1wdGlvbiwgdGhhdCB3ZSBjYW4gcmVwYWlyIGJhZCBkYXRhLCB1bmxpa2Ugc2F5IE1EIA0KUkFJ
RC4NCg0KDQo=

