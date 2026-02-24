Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B47EFB812
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Feb 2026 07:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t6Bb+W/R1ojy0YNbnO76Tthl9Ql5ScyLfLQ6KbQayGU=; b=MEi3Go0ZY50uJ9O77jU2k5jVQ4
	/Vc65w1yKNTKp6HWJcQbHZkHR3jnUHee1AvpxJMQkN452hlXmQfAP3ZIXZcFOTlm+HvJhLYMCY4dp
	tO2kh6b7VJAItLeyzIsvbL8s8j3O5Wsdb9cTsfrseIAO/MYHnkeOsIftNJX0GuX6vKpFr0wVGlOOO
	BExG/ObxZIMzq9qM7ACeJm/XApE7uDFBNcqWLi9eDULmabJ7Y6PjRdkGOdosyJcamW34Q0xMLZhwq
	hb2ajJL14E7p5sP0JJo4f3stwAYZhStQON90Aqsik8k0opvmdzmUsDCCqUC17oOlVKguG5bDhMMW7
	crCNrCOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vun8v-00000001b5p-32sC;
	Tue, 24 Feb 2026 07:47:41 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vun8s-00000001b5M-3EZS
	for linux-nvme@lists.infradead.org;
	Tue, 24 Feb 2026 07:47:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1771919258; x=1803455258;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=t6Bb+W/R1ojy0YNbnO76Tthl9Ql5ScyLfLQ6KbQayGU=;
  b=fdjEnkF/8bRIusySKo/arOJb7DY08yh9eO1mnQZcXPHTcWg91xsWrpjH
   MjCUzfT6sUKVHdborduc5cgGLL3n1AoDbScbaxNKNSHJiJXLDELX2Q1Nv
   VdGsHLnAIOh0WR/gnZ3KaVmb66CT6Mpxf4Lo5pNliJ2pv+Nld5j9pfTSW
   5a2xiER8VY5dpa3V1r3huXOrGAp6VkXoT3nfplBK4jGQvDzWQcdBRr5M9
   bT8EjsHUKkGm/boHiZ0YUCyt4U48l3882jFB9xYLoOI9lGgkNdo1cG5q7
   285xMwZJHhOAaCuruce00NiG8QU+NHeTnTOSyrDVDaW+5YfYwoX0rRXQP
   Q==;
X-CSE-ConnectionGUID: OI04iuGETxOSF3l2jBGAVw==
X-CSE-MsgGUID: 7oSp6wlPTO6/hOeEjQZ16A==
X-IronPort-AV: E=Sophos;i="6.21,308,1763395200"; 
   d="scan'208";a="140367653"
Received: from mail-southcentralusazon11012052.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.195.52])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Feb 2026 15:47:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=isZ8lbN3xfsNg2RjvC7X7bdPjvgyn7yk26siCP1j+rvLPXxicaVaGcgySgC6w4Bf53oLmBPkhZQMDfEEpw/5FUBmmsjtXZU85MZSCdpsym6ZRvo2JlDSp38ZzVMjslL7F083vff+BxZ+yutdvwHhFu64syh/HUZrE5H/F8KnUmZXyiAOxPRiP2U78YVJOztvh/Yv5X/xeDE78x+5FSmJXe49yTAUAxDQwCWOMxEf1wisHaz/aLtOjJU8rYx/DRnErers+EunagU3VvoX6+S8tWjPjD9pOYsSDxMLpuf9EeG0CsFVmAxKgu2vIusqkgrtAfirOeQOhaqTCY3HjVPZOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6Bb+W/R1ojy0YNbnO76Tthl9Ql5ScyLfLQ6KbQayGU=;
 b=je+KcTO6vPtnh14lTdMTdRpQ1C45smoaMcpaY9g4p+aXOYTel7bUsMz8BXnKHt5MU+/e4Lt7N+TLNAP6Z7UdWUBmVtPz54u7OqUPwf54XNL5XVKL1I3HmKBlIZgYBG8r7QatkVtn+areNEAeqwjVsDKwEkFP+iMYMQl9YVzfHqMesVsXTmYLumiymHVU8/bK876K7K9EWFQ/M1GuViLIK8i3Z3whNIJ62ufcO7MPQ2nximaAJg6yN/KtbC3Z42EW3mBTiX8MswSz0DiH9kRtpusNHHMUyDxZgh3hG/yInqKRcgQVTXCHzLdfzpniQY8JRTGVOUQPhrf9IpXgne1dzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6Bb+W/R1ojy0YNbnO76Tthl9Ql5ScyLfLQ6KbQayGU=;
 b=J+gF8bk0qMTzTyjWsMv1WeMwxasHXN2Ng2FFe6dv6fit6WeY2Bs6TzQjn5vUCywB56MwEql6spm4WSce6Cr57LIv9v8mbgjC/xITzOFFPuC+//QfxOhJVNcLYVhXZSki1hTNmqF9Zk8ir/yPdOdYOzM+FSjJ8L9aD8eFjAEIcnM=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by SJ0PR04MB7197.namprd04.prod.outlook.com (2603:10b6:a03:291::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 07:47:32 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3%3]) with mapi id 15.20.9654.007; Tue, 24 Feb 2026
 07:47:32 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: Re: blktests failures with v6.19 kernel
Thread-Topic: blktests failures with v6.19 kernel
Thread-Index: AQHcnL546UP/dHCUV0i3P4Kt4vejdLWRiiyA
Date: Tue, 24 Feb 2026 07:47:31 +0000
Message-ID: <b9488881-f18d-4f47-91a5-3c9bf63955a5@wdc.com>
References: <aY7ZBfMjVIhe_wh3@shinmob>
In-Reply-To: <aY7ZBfMjVIhe_wh3@shinmob>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|SJ0PR04MB7197:EE_
x-ms-office365-filtering-correlation-id: 5a464b5b-9938-4fb7-05e4-08de7378f78e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|19092799006|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?MkUweUsxNmpwaDVlZ01nT3lidmJPZFc2d0hjL2RTQVlYY1Z2eU5MRHRzQlpm?=
 =?utf-8?B?OVB4Vzg0d0dRTmRpc3JmRUdTSlpSNUdBM0tOYm0vRGFFdUxOYWFiN28xMGxZ?=
 =?utf-8?B?cEdvRmd1V2p0VElZVHVyVHVtblVldEw4NlZnVUxZNnZJaDBQVWpFL1owdzZt?=
 =?utf-8?B?TjN0YW44NzFCWXg1YWFFUDBPLytBNENoVUo5WVREWTR0azJrSkg1UVR1ZGsz?=
 =?utf-8?B?VWZ0TWJ2VU13MW9tVXBBb3dlVDlMVnlVMmIyWm5iMDBDbEZKZmtpZ256WkRo?=
 =?utf-8?B?SkJoMklRaks1K211MVEyOFJYazZrSS9GQ2JDNm0zMm9NSnR5YVFNUFBnWXZR?=
 =?utf-8?B?RlNGTWJ1WXFTYWg5b0wxNkdsUVdFN1E3djdFblh6YnZuRXdyRFpWQWl1STRI?=
 =?utf-8?B?TjlWWjV2NWxrRWMveHNDWVRGSy9oMnlGL1ljOExzV0tyR3JpMkJGT2cyczAr?=
 =?utf-8?B?a1FrSElIbGlPeFcvcys2Ti9LVnZRd0ZCbm5oOE9KSnUxRDl6UzFQVFhyYVJr?=
 =?utf-8?B?bU1KOUMrRG1JK2xCcFJoQ2wwQVJJU1VJWHA2MUhFZCtHMUZmVExkNWFNeHRn?=
 =?utf-8?B?ZUJjbE9ZRjhxNy9JYVdMK1BoVHljUTg5VlZnd1VhZHFrTGlDTEc4WWowYXJZ?=
 =?utf-8?B?SVlOcU42UW1UZzdWSG1uZHhocVBKTUhndDdlSzA2WDE2eGhDR0x2QzBqNk1X?=
 =?utf-8?B?aitnSFFZbExVUlBUZlo2R0JKWC9GZzF4SXh2b1ROSmNMc0s1NWlTOG1TSDk2?=
 =?utf-8?B?Mlh0SnVKSllCSFlKdmVnQW1MZHl4bkM2Z1EzVXpvUHBhOUIzRnk0RUs2S2FD?=
 =?utf-8?B?UFk1NmUyVjJ3cWJsN0lTcTdnRGR0SnRQSThpcWVHZm9nR0htZ05kU1pNdlV4?=
 =?utf-8?B?VWJKZnhpS3FvWkYxaXMwSVdFRndXSzMyYTUyM1hPSHpjYTdTQ0tYN1pFelpT?=
 =?utf-8?B?ZzZzZXJNQTR2SEdyUnpUZXhoNDVFcGJYdkl3cHJyZDhWTzBMZml4N1ExR1k1?=
 =?utf-8?B?dXE0ZUxqcE9GMEZjdzZuRWViUnEvWjV4NzArZWFFVm9vd0Q1UUNubHQwWk1o?=
 =?utf-8?B?em9pRXNEckZUMTYvQ2hzMHV1Z295b3hoSkd1SVd1aHFQNittT21zeTE1cU83?=
 =?utf-8?B?U1lSc2h0ZDR3OHkzenBJZmZISTRITjlieTBab0ZnUHgxWUpBdStpalVIQmxR?=
 =?utf-8?B?Y3JoaDlvMEZKYW4zZW5xL0UrZ0tpQjdyblo3cHhQY20xMFJiMzFXbGlZSVN5?=
 =?utf-8?B?Qk52MzNXOUsxVWlRVC9yNmhtemxoVWFnajZIZWw4SGFuUXpNOXQrQTFnczhC?=
 =?utf-8?B?Tk1LUktOaTQwcm1kbDRpOVNya3NmM3ZsaThtREpEQ1BFQmZyZ01GdkJtaURy?=
 =?utf-8?B?Qm5NSmpJOENtNW85bDVKYTZRdWxZYXJFVyt3c0FqRTlVYmwrdFVCem1BYTBP?=
 =?utf-8?B?aDhjYnBJK3pVY1FwOWZLSyt4aGUxeGxZcHg0eCtScStGd0lCaDI2bWdIWXkx?=
 =?utf-8?B?VmtBaU9Od0J5WmdKSmtzUnUzaGFDeTBSVmRRZXBaQ1lYcktud0J4dlRuR2ln?=
 =?utf-8?B?NkU1dzU5RHR4bnJ5dVJlVElQRHYxb1p6ZmVONFp1emtZTG9IU3VpbnR4QURL?=
 =?utf-8?B?blFFZ2IvaTBOOUJERGxqWW9EajBsSHpQSjlzQ1h1c3lURC94aHhINnJwS0J6?=
 =?utf-8?B?cm1pYkgxR2hzNjhlb2EyTE45K1QzdHhVYWpqd3NJZ0ZKK3M2RG9iY3A0ZFdB?=
 =?utf-8?B?S2xRTVlZMUFuOU1oZVpXRTN4QVNVTUVvalRtamNVcEp4bklXMnYya1lSenF4?=
 =?utf-8?B?MVNDSzdtLzE5d3Vkbmw3L2hkV29XUUxMMUlwU1dVRXBiajlFNnRoS3oyaFcr?=
 =?utf-8?B?YWl6dU1BS0xWRVVpSmpycGFsaWdjeExzcU80cHpnY2FwRERER1RjUkErZjBS?=
 =?utf-8?B?c25WMjZ4QkZGM0I5ekErZ3F4cWxVaU1LcTF6UFV6RGxnKzBleENiWTlnY2RR?=
 =?utf-8?B?bjNjbTFTWXhYUXNHTVNSbTdSM3JhNlA5SVgxZmlDRWZabnFiejRnMnpFcFF1?=
 =?utf-8?B?dnFNbFREY2Y5YUw0UWJ3ZFdvUWh1Snh5NTRISVFnMXlUZXdCVlc4cDRvVnpF?=
 =?utf-8?B?OXQyaXcxMEtpL1RUbnNSa2tTdDcvamdPZ2ZjanZGVnZ1L1puTG9mQ21JNmZF?=
 =?utf-8?Q?dRtNjeCAyznNtKNviZTHTLE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmdqT0lWb0Z0aXBtbGdYQkZUQ1BueEFWTXhZUHl2YUFwY1EvRXgxVng1VUEz?=
 =?utf-8?B?TXpzZGlYS3h0clh6NnRZc3c0M0VZQ1RpckYzejlQRjZNVzFlYS9KUFdOamov?=
 =?utf-8?B?ZW14SDZNekZ3bjVLOTNpK3dsY1QzMjVtWi9xUDZGa2hWbjdWeXVuZGNDenhV?=
 =?utf-8?B?QjFGdUVyTGl5NmJ2QnRFL2lDcUhnbmRiYmRZYVVEOVR0VnZPc1AxaVRpbG9D?=
 =?utf-8?B?K2ZtaWZXcXh4Rzd2ZlpSazlWUFlBZ3UxYXNJR3RzWlFWTVV1TzQ1TC9hdUpp?=
 =?utf-8?B?VUwxWTIwaFBZSThFOXZZTENWRzNNSENDand3a09mQmtOalZVSUpQb0I1WUNM?=
 =?utf-8?B?dHFQZThyTWRPZFpYalBNTmVYd0JEUUl0bzJ0Vy8rdXc3QWtESWxpSnB5K1hk?=
 =?utf-8?B?c3pVT29NaEtmQ0p6RXF2c2hPY21UME1NbFlFSm5NUU5lNU9vQzZRVHd5V1lD?=
 =?utf-8?B?d2EvMktoWDNDbEZpaUFmc1d0ZEF4ZUNiZ21ZN2hTNDQ0dW1sTUFZenp1MFNH?=
 =?utf-8?B?OG1MWWNodlVJUlovTU5FM0hTZnR4QUpSRTg5RFhNU0xDR2hCUW1kQ2xQWUxl?=
 =?utf-8?B?UitmRGJFRmVIVjdMM2lOa3B1amdxalhQbWtrUnBZNXBRdWoreDFSMUpXcGdM?=
 =?utf-8?B?UWRFVENvQytPUWh5bmZwZUxsY2Z1dncrM0dlVUl5eGZ2emNNeU1PbmpXQmZk?=
 =?utf-8?B?ZThUWjh3Ulo1L3lRSEIwRDNvV2hHOE1FYm9IcGpuaVdPS1doZC9LTVRRRWRN?=
 =?utf-8?B?WFhlR1JudGpkV2ZMbUdHeW1JZVZwRG83MkVDbk02WW56V29WUDRLVXpNTVE1?=
 =?utf-8?B?blk2RWJZQ1dSZHpwemZZZGlLbXY3RHM2ZXU3bGRmRjJWbVQ2NFpJTTlLekJi?=
 =?utf-8?B?K0pLRjNNMzB0eFlwdExZaDBJK2hnNStNVC9POFF2TWRJYnBJUnpvcmphS1Bv?=
 =?utf-8?B?RHJlMEVQY0xXVG9OVWtUTDJNVXlhS01PZ0ZjZm9uakYxSU0rTGZwOFNVVXBr?=
 =?utf-8?B?Q0VkN2JweFdBMlNSZnZqSGN2T0lTZUQyNmpZUndkRGtlNWVUTmk4cDhZYmhQ?=
 =?utf-8?B?aGNKcVhaUVZHaENta2N3OG1PY2dFVWRPNkpWdExYbmZaVzRSWW5jQnlKVjky?=
 =?utf-8?B?N2NzcVRpL0ZSK1BlbE5LTWpJMm5lektDVVZaMFFpeE53cS9WV1pSbkUvV1Mz?=
 =?utf-8?B?N1FCRzU5V1NlYWFpV3M4aENlMmtFaFcwL08yYkU5a05qRmJvbk90TFlqUkJ1?=
 =?utf-8?B?b24wNEl4SHZFbHhzNnZ1aVVuYjg4MytkOUtFZWovV3ErcHFVWlRvcU1UVGs0?=
 =?utf-8?B?d2pGS3BBSzdxZlQ4SnNkVDJvR3ZteUVFRzBHd3BLcDJ0Y0VWbkM4WmVWVnhY?=
 =?utf-8?B?SThDdDlndEtkdGhqMVRaNDB0bVZJTllySmZqNWRkOFh4Z1JRQWhrRXF6WWJQ?=
 =?utf-8?B?eDFLc2p2MjQwbjg5aWNsYkZXMjVuTFBsd09VaGFDNDNKNzZ4YzVTNXVnc2NM?=
 =?utf-8?B?UGRJZmtpQmw4bkllR3JxSVVtdDNGS0JyL1hESHdCVVZnZk5GeW9QNVA1dVlp?=
 =?utf-8?B?UzRsMjdPUTVROHJxY3RDMWtwV3ZTbWM5Z3dRNDVlV2t2NlcveFZSMXBNYkRN?=
 =?utf-8?B?eFdYV2pJVVBTd2VqR3p2TXJlZlBBTXhwdzBNTEJrWDhlYWg4NDZuTytwVjFq?=
 =?utf-8?B?STIvTEs3L2NTS3YvVnVzdEIxOHJhRHNXS0c3TUUvK013ZHFrM3B6cW5PbTBW?=
 =?utf-8?B?RU1wTHhETTA5TkFueDJqOTN5SU1EdlZFME85L2pDdGxpc0lxVWJkQTVEMzJ6?=
 =?utf-8?B?M1c3VUptdEw0WmdMMk9WZW1xYjd5ZXhHbUhQODJlZDdhT1JYeGFKdVdOc0or?=
 =?utf-8?B?TnpidTBnSzFwYnIzY3dGMWxKcytGVW4wODI3V1JPN0ZHNW5Bd0w4RzRQSGg1?=
 =?utf-8?B?YkI2MjJVNldTc3E2SUdvOEtteTJoMUlSYU5SQ1I1NGpLMTdwcVF2OVhjY1RZ?=
 =?utf-8?B?TUNLcGp0Skx5ZjB3aGU5cFI4a1M1ak42YUlsdkV5U2x0Mnl2eGVrMDl1Wk54?=
 =?utf-8?B?anV5NkpvR0lIdkR6cmZzcWtvZUk4djc1K2t0ODFsMjBlMWdsL1FrVWZCUzBn?=
 =?utf-8?B?T3Axdnhtdk5JbzFoeHVieW04R1BkNWd6dlg4RjlEQm9XTVFjRzRDQ3daY0Fa?=
 =?utf-8?B?ejZ5cWo2WHFxeGFkNWUzNEtEYjBlanIrNkFxNmFJVlhzaHlkeVJ3LzVjRnNV?=
 =?utf-8?B?cXJUZVpPWk82b0k0NUVoMWdZRUlLLzVkWWVjV3hpOWNpNmJtN2hQbTAvNGNG?=
 =?utf-8?B?NHZNdDZBS28xcmlKTFNWWFdtbDJNSFVjbWpQWHFwa29PZU1PQURoTzFDRDFw?=
 =?utf-8?Q?Wn+GwSjOoVpn0idghKXGdFVl7cJZc1H525j2b4fcISLeP?=
x-ms-exchange-antispam-messagedata-1: Yfc25z1lss995bEjYp5f4oC8cSWA9er/vkU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <77EFA6A7E66AB6478E8CB75F235163E4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dl6ZGUtsljB3T5CwN/+bgMtG0S7Uc+xScuSGRPkHDs7pYAr7tPpg92Zr7FUy5k6Expwe5n9Y/SM2nBYAGXZlE4y1GFOL68ePdSQ6920QDwcKxO9bJ9e9WGBhhUNyduwrDL/Qp9MxF5TWcruURmj4u/i2mNBZJ4gEtNhYg4NSM5L6QYBQuYscFKj8VCmm0ifJgsEVOSPgOPiKqwpuczXw/pwROmMGY2gTlb033gwBhv1U+6y0MSzuovoySnfbveRItXPF3PaVhy1BPoSjDfFdXP024YC67Y3ng0PqF15ccKIvM/9e2AojkWFi4bRecX/m8eTBMV6ky10OIndb34a/r7UIdZ+dN5GjEzlZAvhgRYG/FMPULXmMns3oW8UFw/q24YfktInROZFKRL1fgC9b+LMS/88PK8JEAfAYPKz6AtyS3jzV/9RqAKGJ2q5XpthrRbqtuxNRECuIiUboHUD7MLf91WGKWZQTYo0+A9DGDLRAyDoJLSEJy7T0NtQJxdvrqtm67gblkLzFj194O7MqCh0s7hY9e3Q5ARZNMj+Im/O2KYPuZeW6LU3VxMfDhrr52Sqej/revDWHFjTpdmPKGgEEY1kCCOREcoJJiEPmpgEOGkYmDTr68wzVKv5arXdz
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a464b5b-9938-4fb7-05e4-08de7378f78e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 07:47:31.9542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2/ccTRgywKy6xVtwSD6rACc68yJXQEvpBbcHHRrum4sT9gXf44OJqLioI2YWmN+hp8XfXIrrj1qksCR6uQm3nAD3RyHCr0+qszONGxuTrZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7197
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260223_234738_924129_EF89AB07 
X-CRM114-Status: GOOD (  12.20  )
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

T24gMi8xMy8yNiA4OjU4IEFNLCBTaGluaWNoaXJvIEthd2FzYWtpIHdyb3RlOg0KPiA3XSBrbWVt
bGVhayBhdCB6YmQvMDA5DQo+DQo+IHVucmVmZXJlbmNlZCBvYmplY3QgMHhmZmZmODg4MTVmMWYx
MjgwIChzaXplIDMyKToNCj4gICAgY29tbSAibW91bnQiLCBwaWQgMTc0NSwgamlmZmllcyA0Mjk0
ODY2MjM1DQo+ICAgIGhleCBkdW1wIChmaXJzdCAzMiBieXRlcyk6DQo+ICAgICAgNmQgNjUgNzQg
NjEgNjQgNjEgNzQgNjEgMmQgNzQgNzIgNjUgNjUgNmMgNmYgNjcgIG1ldGFkYXRhLXRyZWVsb2cN
Cj4gICAgICAwMCA5MyA5YyBmYiBhZiBiYiBhZSAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAg
Li4uLi4uLi4uLi4uLi4uLg0KPiAgICBiYWNrdHJhY2UgKGNyYyAyZWUwM2NjMik6DQo+ICAgICAg
X19rbWFsbG9jX25vZGVfdHJhY2tfY2FsbGVyX25vcHJvZisweDY2Yi8weDhjMA0KPiAgICAgIGtz
dHJkdXArMHg0Mi8weGMwDQo+ICAgICAga29iamVjdF9zZXRfbmFtZV92YXJncysweDQ0LzB4MTEw
DQo+ICAgICAga29iamVjdF9pbml0X2FuZF9hZGQrMHhjZi8weDE0MA0KPiAgICAgIGJ0cmZzX3N5
c2ZzX2FkZF9zcGFjZV9pbmZvX3R5cGUrMHhmMi8weDIwMCBbYnRyZnNdDQo+ICAgICAgY3JlYXRl
X3NwYWNlX2luZm9fc3ViX2dyb3VwLmNvbnN0cHJvcC4wKzB4ZmIvMHgxYjAgW2J0cmZzXQ0KPiAg
ICAgIGNyZWF0ZV9zcGFjZV9pbmZvKzB4MjQ3LzB4MzIwIFtidHJmc10NCj4gICAgICBidHJmc19p
bml0X3NwYWNlX2luZm8rMHgxNDMvMHgxYjAgW2J0cmZzXQ0KPiAgICAgIG9wZW5fY3RyZWUrMHgy
ZWVkLzB4NDNmZSBbYnRyZnNdDQo+ICAgICAgYnRyZnNfZ2V0X3RyZWUuY29sZCsweDkwLzB4MWRh
IFtidHJmc10NCj4gICAgICB2ZnNfZ2V0X3RyZWUrMHg4Ny8weDJmMA0KPiAgICAgIHZmc19jbWRf
Y3JlYXRlKzB4YmQvMHgyODANCj4gICAgICBfX2RvX3N5c19mc2NvbmZpZysweDY0Zi8weGEzMA0K
PiAgICAgIGRvX3N5c2NhbGxfNjQrMHg5NS8weDU0MA0KPiAgICAgIGVudHJ5X1NZU0NBTExfNjRf
YWZ0ZXJfaHdmcmFtZSsweDc2LzB4N2UNCj4gdW5yZWZlcmVuY2VkIG9iamVjdCAweGZmZmY4ODgx
MjhkODAwMDAgKHNpemUgMTYpOg0KPiAgICBjb21tICJtb3VudCIsIHBpZCAxNzQ1LCBqaWZmaWVz
IDQyOTQ4NjYyMzcNCj4gICAgaGV4IGR1bXAgKGZpcnN0IDE2IGJ5dGVzKToNCj4gICAgICA2NCA2
MSA3NCA2MSAyZCA3MiA2NSA2YyA2ZiA2MyAwMCA0YiA5NiBmNiA0OCA4MiAgZGF0YS1yZWxvYy5L
Li5ILg0KPiAgICBiYWNrdHJhY2UgKGNyYyAxNTk4ZjcwMik6DQo+ICAgICAgX19rbWFsbG9jX25v
ZGVfdHJhY2tfY2FsbGVyX25vcHJvZisweDY2Yi8weDhjMA0KPiAgICAgIGtzdHJkdXArMHg0Mi8w
eGMwDQo+ICAgICAga29iamVjdF9zZXRfbmFtZV92YXJncysweDQ0LzB4MTEwDQo+ICAgICAga29i
amVjdF9pbml0X2FuZF9hZGQrMHhjZi8weDE0MA0KPiAgICAgIGJ0cmZzX3N5c2ZzX2FkZF9zcGFj
ZV9pbmZvX3R5cGUrMHhmMi8weDIwMCBbYnRyZnNdDQo+ICAgICAgY3JlYXRlX3NwYWNlX2luZm9f
c3ViX2dyb3VwLmNvbnN0cHJvcC4wKzB4ZmIvMHgxYjAgW2J0cmZzXQ0KPiAgICAgIGNyZWF0ZV9z
cGFjZV9pbmZvKzB4MjExLzB4MzIwIFtidHJmc10NCj4gICAgICBvcGVuX2N0cmVlKzB4MmVlZC8w
eDQzZmUgW2J0cmZzXQ0KPiAgICAgIGJ0cmZzX2dldF90cmVlLmNvbGQrMHg5MC8weDFkYSBbYnRy
ZnNdDQo+ICAgICAgdmZzX2dldF90cmVlKzB4ODcvMHgyZjANCj4gICAgICB2ZnNfY21kX2NyZWF0
ZSsweGJkLzB4MjgwDQo+ICAgICAgX19kb19zeXNfZnNjb25maWcrMHg2NGYvMHhhMzANCj4gICAg
ICBkb19zeXNjYWxsXzY0KzB4OTUvMHg1NDANCj4gICAgICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVy
X2h3ZnJhbWUrMHg3Ni8weDdlDQo+DQpUaGlzIGNsZWFybHkgaXMgYSBCVFJGUyBidWcsIHdlJ3Jl
IGxlYWtpbmcgdGhlIHNwYWNlLWluZm8ncyBrb2JqZWN0LiBJIA0KL3RoaW5rLyBJIGtub3cgd2h5
IGJ1dCBub3QgMTAwJSByaWdodCBub3cuDQoNCg==

