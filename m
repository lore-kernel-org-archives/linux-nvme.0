Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A261CD1296
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Apr 2024 15:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=; b=UcQBVpd1p5oq+mDmZlmH46WXkD
	yap9ktEGxkS32KG63KFNNkyMG/zywAhZcKkh4gPAfzxxHrP1my4ETO39BUbjotlGbKOTj1zyRb8sy
	kWxuvlhVa/35ngztFndDK2ybO2EVHS8zYuoInH0zss4del0gx6fP1pq6EBQLQ6hyC8h8Jm/cu3FVm
	FbA4i0vuiJimbA3VOVtOF9uKVUthRmMvoVF0N2BnphVSuy07bWifaIeAsc4UxFo1waooNrH1MhWVv
	bLTuTL31eiqkPbHxJErhm/dL1PlCtuxaAI4LfzteIGxBZ1x+4boANoDbIKUKODL9DhnruTj7sZSSz
	Avdq58ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtrDp-0000000G4gR-28Dr;
	Mon, 08 Apr 2024 15:47:49 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtrDm-0000000G4fx-0tc7
	for linux-nvme@lists.infradead.org;
	Mon, 08 Apr 2024 15:47:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712591267; x=1744127267;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=FuAyN6lPJ5JFYhvBXGi36R/f8y1DtB09J77sksE/VZfmZFxWW5fhnenN
   gpo00C4URkHZOTEiJlASIzG+bqBI0OszLUTSLVZwxhC/1FTfNo3Lq/nKF
   P569ynrm0FpljJ00juO3ivW/mJhDAdTsChwrwgbb8S4RU6Run9LUFvSVY
   ZU1LgqYx2TavCkpRcVEC13jzlvGnntrQpT14g9VLKRYstmD5FA2ScGU4K
   NB6Wls8/09GNDLbNbSYGdblWmtv+ABCaCQc0Yh1aZKubgpKBIJ8PAz7Ui
   7gtmheHS0KmaqjPpb0S420EsglTMCouV97LM7IBLUFK5E9HfLpLThodF/
   Q==;
X-CSE-ConnectionGUID: nJZq/CHxSk26LzXdfJJd5g==
X-CSE-MsgGUID: wcWp6XSsQvmIGie4npEJ1w==
X-IronPort-AV: E=Sophos;i="6.07,187,1708358400"; 
   d="scan'208";a="13344381"
Received: from mail-bn8nam11lp2172.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.172])
  by ob1.hgst.iphmx.com with ESMTP; 08 Apr 2024 23:47:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTNao5Rh7yUvUfqnqEv7L5c27J2tLHwM1henBYkeu7qz0lxMA4LMgPRG7cwgFRbGZzJQusojeT6hh70G2vKBqpwX0JX9S6Fqz13RSHNE6KJSKFfKh30bxfe0H/3lLIknJVfxDfX7+aKegAAUv92dxK2lx6PS75PYM/yWdunSQrZ3JL0MIMQb/Hj5VbIlcCoXk+S/narwCz+flb0z6mvFxJVpNw+6jpDg6sp5Yx5ymyWwJ5TOwLa8vsAmLpmZZwSuVj2ZbUps+oBP7/8pGE5rFpCQ8MXt12FCUQVZomtNVKsPTxmXQoFX10WTY3Pbje9vjaQUgpzkKP4xUlGmhdafrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=hNRH1ILJIGQ8u1U0BuH0NhU8fh2U05hMUhjsodEaCTZgW2B0rnNvTRT2mtcwNvbtDlCwmfga7EIdVF4MsdbAiiOTPSrEgvC9Edr78TIEJPDaDGfBIwO9TP7zfFm2oWs5lgjggrUg/Dys9shbEn8PZOHF6kWQnp0zXXZSwvLRvbWtQ8X7IBr7vDuXGHTH9WxqMjE2zuIBQ1LEj4IW9J4QBgKo09LOKCLijX+ZeFsj83IEcWZn4vdVEhO7Y2d4p8TySNMxOwuIXwjxE4RlSnupQfmwuMfXzkvwChj1I1v8Q6PvWS5jgn9yF4RcnMK5WA/5btjVdUouWP+88gNCy1dpXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=nSQra0/WiA5wQ53mIalIUFzjyJp91ZaMmUFKwkssjtAoCpLe5qvXWjcw8+W6V4YXgMEOYGxz8nVzbp58pLeQVG4poF4fe6PN64J7r9OWPQzgcELNHuT95uNZfnevYVaQmqLQrGV4Jkj8QtLRPXKeIM0E7uHYxF6AZthAnnO4vEc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 15:47:41 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::48bb:3ec7:409:1907]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::48bb:3ec7:409:1907%4]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 15:47:41 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "Martin K .
 Petersen" <martin.petersen@oracle.com>, "dm-devel@lists.linux.dev"
	<dm-devel@lists.linux.dev>, Mike Snitzer <snitzer@redhat.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith
 Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 03/28] block: Introduce blk_zone_update_request_bio()
Thread-Topic: [PATCH v7 03/28] block: Introduce blk_zone_update_request_bio()
Thread-Index: AQHaiVX2gknGZ+9ufEK6JrbmCCJZN7FehYGA
Date: Mon, 8 Apr 2024 15:47:41 +0000
Message-ID: <70006933-a00d-4a27-81e3-647776a1f3be@wdc.com>
References: <20240408014128.205141-1-dlemoal@kernel.org>
 <20240408014128.205141-4-dlemoal@kernel.org>
In-Reply-To: <20240408014128.205141-4-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|LV8PR04MB8984:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3BfnSl44m9X7m/7lUjfPd//5rKr5NVinKadGVGXwFZwAOJ4O4M6oqb3ADz85/TNxmg8rSrYktWzuCtCd9f0zdxclPEEnhKILxstTECuOdYWfKoc+4ZvkCfJN3cOV0P0IFoE5ebvxLKswkiEDKuKcwDkpZVAy1DPLtqaaAr9ke1CVg6xS5ZdMXNT2F11uoWgeCefJ2FpiSPm7+y+Isu3xWaiObPUCJULJyj8TYsUxi52NTr/gk1nCzhLyWUZ36JvNoyW34fQpBWwww87coLtYr1yTMS1cLXcW1k0vXuibmvaGbmKIXWsviYolCd5vH/HcX4jB5WBcDzhJaizDyPQn09cfaMTaawz0OsQ8gVeaGlCMFT5RdUfCkyEuas1nW2sxCrQHt3yf/9rFJFoCNYC261TWpHX94BlxZDlQk37OCV5nBYP9Nq/XLra16oiqdXec42DVdBa/NNXxWieYIEVKNcFvzHZ4w87eX3eH+eb6OtiOUEl5b78sPNBzU1NA5GhyzwQ81ibKEhAgP5WT17Dp9GNWJU0qok65YFB0WHV3o6EyZl6QkC+FEe5EeSsAGBUOESjhlMwr56W3gpdZdGP2jqmU3VwypRgNOdA+jE9sfMRQ4YTJLjUVb1Ms4dc+CTASceeCsIKSJMsitdR3r3wXBNT4TLU9sW7KuzM7gom/FuW/XaYkmQtKhozSbLUsw7i32hLvE8C5wG5orlreq3maiQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGFTYjJrUnBDcW9nZFhweVdqay90VUNZZ1Y2RHRvblpKSk8vc2RyNXN3b2c3?=
 =?utf-8?B?VVl5U1ZiNVV2RXRYUmNrUiszemlzNzIvcERYazNpc1YvYzUwZWtmZG8ydFZw?=
 =?utf-8?B?c2hJcGpWQmx1L3FDbTVqZ1lBU2R4dk9LeVZFSSt1TGlNNjdab1c3ZGY3REdH?=
 =?utf-8?B?L0RmNlRWd05KNDZCSUZvN25FTTErNHE4clEwS21GTlh0bWE3QWJieklrL0lz?=
 =?utf-8?B?TjJ5RWc2QXQvSEVvM2V3NGVtak5HSjhldFRKaVlLQzlZL3FTWUMreGUyRWFX?=
 =?utf-8?B?emgrVkNTNkJvRkU2RHZmTDFZTjhXQ2c5bU5IMUQzbjNVbUhPZFUwMDl5eHZO?=
 =?utf-8?B?elJHMlJTQ3h4VmhkZ0V5NDg3eE5WTWtQQUZPUXRjZlZ0eXJYb0w5cmo5STBw?=
 =?utf-8?B?MGxVYWV1OGIyWllsQkNxS0NOYjJPQng5WWpJbzl6YUlHNlM3a2V6b3Rmemp0?=
 =?utf-8?B?TEpYeUJDdmtlcVBqVElRSmRWVEJiU3J1bUhGTVprUGpkVkxralduOTlxV3Rl?=
 =?utf-8?B?NmNpTDQ4UTI4NlNSVkIvUWREUS9qalFGMk92ZFFTSlZ2V2owTVFBZVdqQi9w?=
 =?utf-8?B?dE9jRnJhQmwwS2c4cDYyOWY5MWFzMlllZTRDRTRVUi9zR1RnU1BxeFpRTk1Q?=
 =?utf-8?B?clg1TWI4eDkrNzZuK05zY09ySE1YbWlWRTFwL0taSC9PVkdqNzZ3OUp6L0pF?=
 =?utf-8?B?VmlwaGVZOFNzQk9xenVXaGlWT0tzdXBmVzA4K0VlSkp0MFNoelNvalVmeFNR?=
 =?utf-8?B?M3YwZ28zdytadDBETUJSMEcvMURYTisvMjFSOWJIRjRrejkxZ3NSZE54djlL?=
 =?utf-8?B?T0V1QWJ4OEFRcTNJczVHUnVQL08wTngxdHlTYlBsUkhsNk5JOHp6YkVQc2RH?=
 =?utf-8?B?eC9BOUxQQ2RCNlNuV0I5czhLM2MwZElwdmczOUJEV1VsRWxMYmxGM3Zhck9j?=
 =?utf-8?B?Skh5eXNoNnZiSGtEQUtaUkRxZmYxMHk3ZTJRWGRabENGcWVLZ1JkT21wUkk0?=
 =?utf-8?B?Z2NoU0VibWFLQ29NeU0vNlMzeDZ0VkpuSGZ4NmdPOHB4R05xL2NaVmFLL0FT?=
 =?utf-8?B?Nk1CL3dCMWxtclpCUktSU2NlWnVoVzVubWltQjVwclpGc0s0VEpGL0VjdlBw?=
 =?utf-8?B?aGM4bVVaTXAySzNud1djYytHMVZITDZYb1FKWmdTd1I3byt4YjlBM0drVmRl?=
 =?utf-8?B?cSt5TjRwZWlhWUdpbzBoaE1YcGlybUJUbTdWS0kvd1FLWEo4K3JiOE1oMjhY?=
 =?utf-8?B?R0tSeUlZeUcxYXlXem5FVDRzZXA1cTZiTGVJUjVMN3NjaTlZeEZvQzQ3R2Fj?=
 =?utf-8?B?dGJPdG02UGdGVEhWUjZyU3N0dDlleDRGbG1TaDNvMlFTWkxpeGpScTgwZ2Uv?=
 =?utf-8?B?Z0VaS0JaUGtpQ0hQdHhTS1U2RXpRMHgrMFdwWkhHcGQ0UWFDSWw2NGJVUTc2?=
 =?utf-8?B?WGZaSm9DYzUxeUV4ZmpyVUtvVFNHb2dkVHovU0UycWZjR3RoQkZzUWVSbG1O?=
 =?utf-8?B?S3V3eTVmWm5TeldWMDIrK0FIN2FzQjZGTVREd2VXTzRONHRiaWJzelRBaUhR?=
 =?utf-8?B?YnlSdFlaaVMrY0kwS0UwSFFSSWNPTTFIbE1GRWRjVnNLSUhFQUYzNDREdDBJ?=
 =?utf-8?B?RFByMW95ZGpjRzlYUThkb3hGOENGSzNBbk1FRWlxMEc5c1lZdFpMRDFBZ3d5?=
 =?utf-8?B?bW5LQ2JaOEtvb2NRalI1TnJsMGVkbUQyTDF5RkhNQmg5SVY3eTFCV2RwM3pH?=
 =?utf-8?B?SnlvRjR2YUVncEQ0czdVM01ESXQ1VnZmdVNiMW5JQnpEcmtCMWhINVJ1ZEti?=
 =?utf-8?B?MHRxVEZEaU5jZTIrNm1yeXRUdnlTbEc2QjBkM2FxUnVZOGhvRGpkeENERTJi?=
 =?utf-8?B?Z0ppY1h6VDN3N0ZjcVFqNEw0dHI3VndoblBnWFFyYXlkOGtRTU93MStEbEhV?=
 =?utf-8?B?cXVPdE5VVC8zb2VGR3dWdDJ4RjZNbnFsUXI5NEVCeTltNDhqVE9tZkQ3ZE82?=
 =?utf-8?B?bkVZSHhRQXFpTUhUMTE3dkR0N0p0UUFkc0NKaEMxY3FpdVRBRjhBOXJpUm1Z?=
 =?utf-8?B?dDN1RkVxVGNScEMrOWd0dG5veHhhcEhmZG5zbUFiZ3NtVDF0N1c4ZDNVVzdi?=
 =?utf-8?B?VzlsdmprQllkM21tMUh1eExDYWJlVVNZTTZ4OWRZVVNYNjJZSFVNT2VSaTFz?=
 =?utf-8?B?UGJDbUdWM2FXMW1QN0lKVldNRDF5bFlBc1poOE93SStmeDhib1N4VFEvR2JW?=
 =?utf-8?B?S215dDQ1ejNHVksyeGZoOEJWNHp3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <749EE9B4BAAFF448A4CADDF822881A05@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: M1QN1LuiipgNkCirLePdGYmk/eO/TUOtzG96gzB+O14xfXylvc6D0MFeLeX5YfETOsIpdfqWHDxqaN1TKDRvmxbcpu0sovhNlFUJnBQ2tSeqiKGzn2EWBD27a2/IyAYtynLJezssQnf+Z0iPdJBgFSSAhgGCtT6MSNGbenPHoNrmVIeaiXmO+xQ+8Kb6KGmQr+Dg8oktT9FBQ7oT579+0C68KEKUlaf52CCPFhf7sGFLWBa3bP1fftgUG0GspcUaJ/d9y3u6pz5a41h4R5SitiFaouDbMYFhlJuHn/cpN5qCOL4d5YtgYdy/YuwIOVrWSCcYi6frIzPgJbkcOxxrtu0M9bA6ARspgXVGtDybea6oH7fqGweF/ZB9LPwU1doAu3pI15kef1x/od89DcsswN5mAsYQXgvRDp5sp2Tjs6k8KgTKVBKv5CF++ZnwcqV7jIdNl7Sv5XXRoLaaLF5apxwkJKvnixJn79tWOZB+JbkuSJljEIuzsGsnGcZEpa9Bm4ZO59eDho1MlaGxUWL8/D1kuFFcJH9p6Xh7ZH8bgZkefXiwzBvPKGKKvkve/2tM5Xw9F71S1EV1jKHBuDf+tnwkaBijO1/NMe50/4Eb15cYtTwp5TEGugi2c+j1mJJX
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c0f87c2-dad6-4817-c7af-08dc57e339ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 15:47:41.6538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C/HCklDU89O7OS5Dii+nyFeoTeptZ5pe/RJtjlUklKyJGusAFrz09p+Hx744562MxdiLBtsE+jxrvRusSjTs+vY/823/lVTZazyMqkouoUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR04MB8984
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240408_084746_278356_BE5DEB2C 
X-CRM114-Status: UNSURE (   9.23  )
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

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=

