Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D341FC3ABC3
	for <linux-nvme@archiver.kernel.org>; Sat, 10 May 2025 10:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H3wpBmmvrUtn7uQlBwXcYU6Ze2JUyYJOKDsMLE10Rlc=; b=gu5VlgKDxsxwy5jnRk5sogv8iH
	6BgitiMQHjtp/J3mO20zXehKel7AA3e9AGIx341F7EpF0s5TJ0bsEGMGxeRWqc2dKh9hVMuJBVlIN
	T1qQohCCjDVT8g11y0zsyx6jq4EHBHcrPDgpBbvgS+MilZFMX3KRxZ381GGP8823cDnrc+R7mhgDF
	Em/gporTNFUoZQ4eXNn7U3gBojYER3PSRTwmlWiliA3N6LEXiRrs/rwUMPmL+KuWfe90Ri9oNcvFQ
	hAwFrFlD5f2qlt0baQ0bJujMyVb0qKgp2M1h1fKhAtAZZ60zX/Q+xiudhOhnIVMOqvkC1kPgZpp3B
	aPlLalkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDgzk-00000005mOd-1dUM;
	Sat, 10 May 2025 09:59:48 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDgzi-00000005mOA-1XGo
	for linux-nvme@lists.infradead.org;
	Sat, 10 May 2025 09:59:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1746871186; x=1778407186;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Z7xrnR6NDB43g4dVg+n5X4DQXHVh6JJ/I9SEdCjqURc=;
  b=BW6TSb/Wgk4KXLPIVIkX4SMwLo7jTAlJHazrmj7E5ajfiAi7m8J1mD9F
   wY7eICpYONQZmPwgXu4hsnkhQp/F9JNJJ8lpUh8EY5d6oKVniWpm32GrV
   2UuPxDXgqV5xTJqHTKdm0jsCL4VLCROrRyivJxRLKpa88hOytY/mWY9Fm
   r6tg4qolUi+W5bDO3XWCUiQB4N1bF3+xpDPU2G2SOv5eZ2TYMkChXCqoM
   AaU0LVQ5pAhTjtdDaGKE+HtensW39pDdGNtVZEqmco3uiMGBCw2jt2OKv
   cGyBxyr+cJqbMe9KXEBhakUtjmfOq+HkC81GJpNgtJ1bgCMOT39SXF0si
   Q==;
X-CSE-ConnectionGUID: 5Le1nrAcQCGch3882IZTug==
X-CSE-MsgGUID: r/x5mt9JTSiyexG8qHVOUg==
X-IronPort-AV: E=Sophos;i="6.15,276,1739808000"; 
   d="scan'208";a="84831334"
Received: from mail-westcentralusazlp17011028.outbound.protection.outlook.com (HELO CY4PR02CU008.outbound.protection.outlook.com) ([40.93.6.28])
  by ob1.hgst.iphmx.com with ESMTP; 10 May 2025 17:59:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hWwhnNhkTi4ErDqlhSk/2IOKiaoDxFnKeQcod/ySu3z0S3X/soVbuqxSZJNxOc+LZF6FucSM9UBcCp3BoEgw4rnMaqgX67RKNc7g0qvKRSjIfdxVDf29p4pTdzGLYxOYaPzmynVrSsqchG1/UCpb9MKRTCE/s64xyPmC04BpP9oin0z4E0CRurpzdoG+SnJKFgIq8k5Phq48UVtpZKt4sR4VkfFvMwCi76PJmOW2/GesAVR3bM3xhamSwYQ6Phr1c0AKGtEzi49tnWg6Zf8pCSJ34c4pQwPu9T4PabvM4G+jFQBHWPd7rGjCSy+DaEH0lmi4kM/FWTphollgmSdixg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3wpBmmvrUtn7uQlBwXcYU6Ze2JUyYJOKDsMLE10Rlc=;
 b=Da14VYBqg6m1mlCe0854S7WB29QsOJCpPkgtQDaxclswMFw4JwMzuE+MYakKq1TNp5SRoL6F7XCRa6+d9U7uiXI+zqmRjshUsx52ChSOzSZW7iq1Z8faAsJVCrVwvYraQhwt3479SNbiUX4QR8gLRJkwsbNYBPzhldSZpQ2cr3x6kr+W1j+IEO9JHA3jnClNpV84P1cbZIm47gWVfiECFSSSG5Ewe63LHNcDOASHoUUJPBanJQWI9JGFzKVU5HiMRdLHp0F3Fhs3yu4yeuCFW9L7qLHsefRxmod3RGDuE6osh5KhBMvwWrLFI/3WqJcSXnHhk4km8VCSNdfAPx95Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3wpBmmvrUtn7uQlBwXcYU6Ze2JUyYJOKDsMLE10Rlc=;
 b=TllpqIcBXN65nONO9bPSgQeIsi85rVd/FI3asnCX8N49N7Z6yb/xjO3RgCRVY+Hqu4Fni44RZNtsyofy/Iaytt1bmE1IiVa0HersbiZfaCQmkGAwS8rYOC+JEOIIk79SOF4ykzrLglEEuNl8ogprUR26Wd+ZYsR7orYSotOvPXg=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 IA3PR04MB9306.namprd04.prod.outlook.com (2603:10b6:208:506::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.21; Sat, 10 May 2025 09:59:40 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%5]) with mapi id 15.20.8722.021; Sat, 10 May 2025
 09:59:40 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
CC: Bernard Metzler <BMT@zurich.ibm.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Daniel Wagner <wagi@kernel.org>
Subject: Re: [bug report] blktests nvme/061 hang with rdma transport and siw
 driver
Thread-Topic: [bug report] blktests nvme/061 hang with rdma transport and siw
 driver
Thread-Index: AQHbrfdhJhGSraouF0ezotWmIGdrJbOkzJXwgADapACAIstSAIAByaiAgAGMWoA=
Date: Sat, 10 May 2025 09:59:40 +0000
Message-ID: <ap2zjvglkfpkeemdml3iksapo5lbnr5sixa54kqdj5hdiupmim@jvbajtblcr2o>
References: <r5676e754sv35aq7cdsqrlnvyhiq5zktteaurl7vmfih35efko@z6lay7uypy3c>
 <BN8PR15MB251354A3F4F39E0360B9B41399B22@BN8PR15MB2513.namprd15.prod.outlook.com>
 <lembalemdaoaqocvyd6n3rtdocv45734d22kmaleliwjoqpnpi@hrkfn3bl6hsv>
 <d4xfwos54mccrwgw76t6q5nhwe2n3bxbt46cmyuhjcpcsub2hy@7d3zsewjkycv>
 <f3ebdaad-9911-4533-ac4c-35aa9e7184f8@linux.dev>
In-Reply-To: <f3ebdaad-9911-4533-ac4c-35aa9e7184f8@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|IA3PR04MB9306:EE_
x-ms-office365-filtering-correlation-id: 40463133-af16-4503-0cc0-08dd8fa9614c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?AT0yehqnq6AUvC+L4jUDdshqAt1uACDcJ/Y/24uomx2AgOqH5VlmykQhI3qb?=
 =?us-ascii?Q?rEuIE7f93fD5n/8BZ9f+Gt95wflLA7IbjCStQJG+L8+gtfKDLd6sSIXdJx88?=
 =?us-ascii?Q?83s0QDfP9vu4yeDX/1P9K20gKPSPG24e0U7EG2+yTyUE5qok9iu0l6kq7jUh?=
 =?us-ascii?Q?4kvzlPk3yBE98dfLmtkVtvfNEBb+dI5TncsNY/I/aK73hSJz0mfnKB79j+CM?=
 =?us-ascii?Q?s05YjivayBPHfaXAg3sqFXNPuynGXaQTREFS20M6PeEBdYplERuqXO8nVpkk?=
 =?us-ascii?Q?vDPFhqpm2pRQaKJIiRBJ4uKhKIf+KKpxB+zAKTs6DtXFSOdOr3VvnSYk8Hhb?=
 =?us-ascii?Q?o4VElGJccMXyrs0UmsrISrFbLCBh4dEBCYM5JrR/ST+g7Aw2XOCqeyidmUfi?=
 =?us-ascii?Q?wcOFYjU5+ShzJLbkgRVqtnWTLJvho3oKZ1bg/3YJzXffDVZr3/hGdxtablSS?=
 =?us-ascii?Q?OA3/ek5jmUbxchGedv5iHHLiGv3HBiWdiJ8j22l+r76tdxSTixNrhd6VV8+e?=
 =?us-ascii?Q?bu2rwvcPkF/n5neldcWDGZNkeFsw0oBLADTyM852/yKE8EFoAJ3/0NS2gZC9?=
 =?us-ascii?Q?XmFELkc9JAqlw+ON7CuczA24MYcy9O2z2ot7eb0vQ6youWQhOZeHSQqT725A?=
 =?us-ascii?Q?1bAivqlDPTSYE0Vg6+FEzE75aHzAPRQSwBGIjn8iqDEC6nlsFgia5vPIm83e?=
 =?us-ascii?Q?ehsL8U1J37xzNiIpHPJNffshmLjP2VcdFLXAhRbuVg7qCWoWk0j7iEX1vGSG?=
 =?us-ascii?Q?Qds5J5PTfKVGb9rCR9shVJBBl1bpGpzj43B+O4srGqsT1abXcuIqIyfjKvTQ?=
 =?us-ascii?Q?CdftHfY5Q6Pva6nYxhNJonryDM8+pO/FHOQ4UXnKzFYZXMCbjE+3TjVrPxqw?=
 =?us-ascii?Q?kTy1CmqHol7SxYvyU0nhgopRzx3b5D8Oi4Jx/srfxPE0O/9Ew4AmwPk4P0su?=
 =?us-ascii?Q?prxFxQ+8iz5npBNm68NWkt6dAyzZyhnq6rg8X3VoWDxQCGx6y6tD+3UiaW1m?=
 =?us-ascii?Q?j2o3LFIYwS81Bdd9+iD5kXZWAghgcMDy4HaXTFpS9LBeCJBZtbcLonfEbOCi?=
 =?us-ascii?Q?msWItfrNn+rdgeW0WxUn/UAVw86CweKsw2OCg4Csmo+vwMI0SlYXMi6L2e5s?=
 =?us-ascii?Q?6GKda3azTG7dN14TLPx7uhSOW5znpIQtDcUTPIFyikQDmyTKa/U3kDgGlaMq?=
 =?us-ascii?Q?rnXZ70V0mQllOkh3Uf1xjp5p5kl0SgtTk8CVhSD1kGkkFLy33GZlaS/htR21?=
 =?us-ascii?Q?2PLl+fQJy6myEiP2NNzxWyk3gqMWREq+QSHYqMxaUNj47eF0P5UVKgjredMo?=
 =?us-ascii?Q?+uDCJGIs+NQEhqLFSZ7nHdXUSdfeJ4VBsMW5Xsg82Dj7Ot5FI1swU6tiqabK?=
 =?us-ascii?Q?Yf+qk30h80utBoSBjmJ3fGd5F0GfEcFhSLxhpPa/uLRkp5NSdAXhtwM2ZOGx?=
 =?us-ascii?Q?ZCMNe2BfBNrR9MLhoAceZAz8awnLnChscf/o2ZyuDODAgo8x/wrZww=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?I4j/HsB6idyUi9ekGpzjozxLBtSBpxRSiUUtEHnUgeGt17zywOjpOBR8zfqm?=
 =?us-ascii?Q?twfIRd3gDJVsYhG8t1lq1ED3Eug4Aa8mbB3a29ZtcygQYzarXpgzA58N2iPk?=
 =?us-ascii?Q?AxL5iaIcVc9PisF5caPHFF7sZ5gVCTw7WwE1bZmz+bXRCKBxKndqW3mbktHJ?=
 =?us-ascii?Q?obf7CdHrxtlEYfl8rBegR2+NbllUCURp/zo/n80kug14smIE5PWN/NxcrpuL?=
 =?us-ascii?Q?wVCvZCtzuVcU/uchWz1vdvCFuOIW6cIMhRmyLGgpHxRddJathPtkg3asrpOl?=
 =?us-ascii?Q?3bUUAO0tqHWj4mFME9vO2RVfar0C8NrAj0WH9P+BmQcC2VZ+lQ9qZeGqOGYq?=
 =?us-ascii?Q?UoYBgtmUymy/LQhQKpLVOg9dKQInDV6tSS2eHKaPyoS/aEAIqdiagbFlus5w?=
 =?us-ascii?Q?sKs3tFEeSEkxhDZhMlLi4+sSSgPAmygJVXF6ZQTnONS4fTsQ4rOR84jaXdX7?=
 =?us-ascii?Q?DGHtBmPCTuMfqDXB58T8XTLiOXnjdDzBzAkjaL5myz39uNQSAh6OaNtF93Dz?=
 =?us-ascii?Q?q/THUZdTx/FjWVrtUWlPRK+HFFILVKl7DmBEBeortyjzvqwItVYqKFKo2dy9?=
 =?us-ascii?Q?eOhIy0F8vnYLmrI4j7MlnKEXsSbjWQ7ZfkFp8i5kumPSOeb6SgleF9s1Yx30?=
 =?us-ascii?Q?5WLFvMd+A6gs+DIfqjzEq0xl0ceZkcgfzQ/vGPRcA8b6MGmbQnB1qNhKUY5j?=
 =?us-ascii?Q?WymLJkk566AGjA7XTo1YnlDFUvDboTGhmCX7O2vLox9L2fMm87S4b/M2XabK?=
 =?us-ascii?Q?ZeZgCEeJ38AUrRC/4ldixE1xRpCDUQRjxgZlVU5RgUx7jVeJc7UxR0LNr1PF?=
 =?us-ascii?Q?w9oF934gdV3Nf4f9DbK8jpcDYQ2Lz4hv/cznnArh7ZrIfGo49ONBvP1BXeST?=
 =?us-ascii?Q?7/1msV6IksXjCfiexmW3FCK9eL9k/ooTlcY7b7i5ZM2TFKkvVHmXZeo9mpIB?=
 =?us-ascii?Q?ucyQVO1/jN2+AKyScXzYNTGHi/xQtWVA655Di0eXAbmlcenqrgRa3YxIz8jd?=
 =?us-ascii?Q?TQiMhFrxiCPFQy9aizN0fORb319XcuXN9CIwFvBFL+cj44Bn+Rp/jBF/5xA/?=
 =?us-ascii?Q?ysL7F7hPUdCl2usVsjsh4ftSwOkNHr3svh2dnb+rA2MD8w70zYrfPh2BBiTB?=
 =?us-ascii?Q?MuKyPzhsvZKHPq1BPykjrx9/1hMwe13s+XFgSJdBfeSd1GA9TCZZ171dm8IO?=
 =?us-ascii?Q?lpGi0xDiE/xqEJAHckrjyywJKK8fkk9+a0Ev1BviSefWhqPb4Ow/Pxj2QfDy?=
 =?us-ascii?Q?+UQwSA+J0Qc1i+inDz3MlBhI+BqfvtHwNsLv8YbrHnwRyatKAdBInNspPaOx?=
 =?us-ascii?Q?5KNA+960ASold/ZmEZSYj105YYD5c+XeTmhl7RxqaRECxSxKFL88SAltEzeo?=
 =?us-ascii?Q?oOmORLB2dxsKYhIKHoO+XaMcPTv+7t2XqwmGq6JS38mq8Bcb7sprm7wiFANA?=
 =?us-ascii?Q?yA+gZB4msUy4d4h0nxeiw9ptKYdgTbCE+pppbcX9nxMsihAac+pnwnoIRiNH?=
 =?us-ascii?Q?e+V5zo7MvgtftJk4AtUG8SchAM8kgKRFlsMPkC+NB05T/ikJcJBaIaUxsOom?=
 =?us-ascii?Q?Y/llvsNrX0acAUJJ1qDi6Cw7p10XVI9it2o/2/EVDS+FoNEvWSdnqloEpEsD?=
 =?us-ascii?Q?2g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <232291B86A65944FA0FAC09B1875979A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sBwm4V4s3jt8/5rCt4kTnAT85PEsF5SOVN8z/xixElybnBaVXlsvl8REHeCC6qghW/JLiWCVfyl3gMx+5J1RUrMv0UEof9U8YmLkedzvqJvmnv/uBlkMpBev6Yzgq9LJQPpEck/tQ8KRk+FzBz+Lkayl3JtEbJi7kkXIUqZnqmcpYOJVauvadx6qb1j5TW9bhjSUNVWZVKAJILVSuc6InwAfmQ2Da4XnRxQQWqSchvTid79/UsUuRsfvpiqGcG17TdoZRsOZJSG6rLFkvQJFMp5ndXMJ3BLsEUy2dUTnzgHoNa6C3wvbgJeW0+6Tp8N519ATvjOJdjyldiginSuhC34UwhLQjfr2tzGdJhwbEZhierarXEEDNa9gQyP2L2N6UwGdOlIF11OrYayRaUen8l/gL4hyccxIrpzmlrm0P8y2y09YI+sWYhWsApHHkVklaQnnpw0LvC8tuYiALJssE+uaZokEju6d7pQGq9YOg3VZwlPnpvHhshSxxKPYlXKZh1UE2sSwegykg346wsZDy1tvqPnE4DhG0xz0Ass2YVp3ObcinVRWFa8LIdfYuhHKIIrwhuZOw8itZDQVzpJK8OxbPNawyhL8HTGVfcG//8gStnMwe734jfMkDokyFm+j
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40463133-af16-4503-0cc0-08dd8fa9614c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2025 09:59:40.0993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5pqvadUHLlizedTZwkVp2olKyj7y9HnZe2K7KjBfPd0sDJ6cpHdgp9Pf1fcFbqQhd7z1R5LgNUa+S9rHPzo1VA0fqLmUiBbdSpADsNgmmtY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9306
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250510_025946_484030_5E4FB3CC 
X-CRM114-Status: GOOD (  27.38  )
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

On May 09, 2025 / 12:21, Zhu Yanjun wrote:
> On 08.05.25 09:03, Shinichiro Kawasaki wrote:
> > On Apr 16, 2025 / 12:42, Shin'ichiro Kawasaki wrote:
> > > On Apr 15, 2025 / 15:18, Bernard Metzler wrote:
> > [...]
> > > > At first glance, to me it looks like a problem in the iwcm code,
> > > > where a cmid's work queue handling might be broken.
> >=20
> > I agree. The BUG slab-use-after-free happened for a work object. The ca=
ll
> > trace indicates that happened for the work handled by iw_cm_wq, not
> > siw_cm_wq.
> >=20
> > I took a close looks, and I think the work objects allocated for each c=
m_id
> > is freed too early. The work objects are freed in dealloc_work_entries(=
) when
> > all references to the cm_id are removed. IIUC, when the last reference =
to the
> > cm_id is removed in the work, the work object for the work itself gets =
removed.
> > Hence the use-after-free.
> >=20
> > Based on this guess, I created a fix trial patch below. It delays the r=
eference
> > removal in the cm_id destroy context, to ensure that the reference coun=
t becomes
> > zeor not in the work contexts but in the cm_id destroy context. It move=
s
> > iwcm_deref_id() call from destroy_cm_id() to its callers. Also call
> > iwcm_deref_id() after flushing the pending works. With this patch, I ob=
served
> > use-after-free goes away. Comments on the fix trial patch will be welco=
med.
>=20
> It seems that this problem is related with the following commit.
>=20
> commit aee2424246f9f1dadc33faa78990c1e2eb7826e4
> Author: Bart Van Assche <bvanassche@acm.org>
> Date:   Wed Jun 5 08:51:01 2024 -0600
>=20
>     RDMA/iwcm: Fix a use-after-free related to destroying CM IDs
>=20
>     iw_conn_req_handler() associates a new struct rdma_id_private (conn_i=
d)
> with
>     an existing struct iw_cm_id (cm_id) as follows:
>=20
>             conn_id->cm_id.iw =3D cm_id;
>             cm_id->context =3D conn_id;
>             cm_id->cm_handler =3D cma_iw_handler;
>=20
>     rdma_destroy_id() frees both the cm_id and the struct rdma_id_private=
.
> Make
>     sure that cm_work_handler() does not trigger a use-after-free by only
>     freeing of the struct rdma_id_private after all pending work has
> finished.
>=20
>     Cc: stable@vger.kernel.org
>     Fixes: 59c68ac31e15 ("iw_cm: free cm_id resources on the last deref")

Yes, I agree that this commit is relevant. IIUC, this commit addressed the =
use-
after-free of the struct rdma_id_private, but it still left the use-after-f=
ree
of the work objects. I will mention this commit in the commit log of the fo=
rmal
patch to post.=

