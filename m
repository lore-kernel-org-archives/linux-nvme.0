Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A86D7E7717D
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2024 12:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lk4/E2VM8Rqv4wfUwcKGmbv1cn6UfcpSayUy5inG8vw=; b=nDQ0nKRiYd1q6NelLaHr8bfAxy
	70hAWM1rd5K/eTMkHpTHSEd1/uKypv7WrbQva4Qd24LHxmxv1fufUVbTgOuTgR7UHZ+sFIPtFrs7B
	3KR7+j5JkXMe/jpNXiaf1bVCrUDpdukUa9ujpfughlIHSl9XHy7I+ZdCw0KlIJVnflyVSVD2VhOGq
	VMLuMH5N70M2d/jcQDA+SBcZxSHe7ga3wPVIzu440e6MBpoOMuU10Tz20UlJ8u9yK83ADheuKSszZ
	VBPvlLyPJudgDI0IKFdmRDhoGsEokcwsdKBOy61GTvehiJ7GQiA8eiAXhjwDQv+CchalXgZMt5a83
	iUBiYcjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLLp3-0000000EpDo-45ZR;
	Wed, 11 Dec 2024 12:28:09 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLLp1-0000000EpD8-0wrR
	for linux-nvme@lists.infradead.org;
	Wed, 11 Dec 2024 12:28:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1733920087; x=1765456087;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=lk4/E2VM8Rqv4wfUwcKGmbv1cn6UfcpSayUy5inG8vw=;
  b=dbt6VbKsDboENs1ZP3CAqHXJqk1vEWO6Atu+GhB6vTt+XFNPXm+GYW87
   1Stw3kjS4wsgOZpOBXPp4cv5DIlXS/nvhphDQ7oGSwvTPv0tHmkTDVtmw
   U3GtoOI+WB47B03ZSABKCoQ4O41fFsf2GNvgFNEU+J+VoxFyXR0TIKfLp
   WZBrLslOi7OPBZmaWu5DEwSJ1UsysfoDIJcDh8qvEV44ZoqD5Hu8mPigq
   FpcKL+ld56Ew0IM0Ab6aL+ZOdR74hPC93w7FmPh38kBQ9jbR6A5OIGGkm
   Mv48whwUVjS8aOu9nxc+jc13VUpfJPA7YUnTRrUqrvR9pQUj0xEiSEWd+
   w==;
X-CSE-ConnectionGUID: ALooB4CNRlW6LLkUlQxQuA==
X-CSE-MsgGUID: yJg7uRyvTVSoQb7mNWD64A==
X-IronPort-AV: E=Sophos;i="6.12,225,1728921600"; 
   d="scan'208";a="34622804"
Received: from mail-eastus2azlp17010020.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([40.93.12.20])
  by ob1.hgst.iphmx.com with ESMTP; 11 Dec 2024 20:28:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ledeUcxg9Lt6t8blPjwpr73GxpNbG9Nd2d0BpGaoQ7UBh6/aUg+5poqsa3awsHFeTDGfnuERgMIL82or3iNmMZejHjrccGFXq7MW3wOXDaggeVCygjl9Clw7ktDs07MgJn9qwQkEF00N9cUuEbQ8Z12iFmG2btrBI8XaGhr5T5b2k5kgwBWsS/hph9dMneKoiiOF3HfUL9xZ+TnOC3Zl52JoRAjVhhrsA1kXFcEalPe388yXMI6qpnQNT6ptBTIX7MLLOL6kDbo/lpCRCTQPQy3dHna0JmIrKaNUa3HcXGifD+4dmoGysXDnkYLqPB/Y3lEbURCDdwJGAS085TVuqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lk4/E2VM8Rqv4wfUwcKGmbv1cn6UfcpSayUy5inG8vw=;
 b=JCRcfrvg7NuB6bMDdqPUPxWsfxGcKOBg+6YhIYuhkcSKkV6RNyhFNrecccMK7wEUnSPJZ9ZA0HUJ6Be/FhY6dthLxALgZpAqu6CFpZQv8z6bnrPRXJfGqEI9vIRAeCGgZO5IW+iluKc8CRUtOpUj/NvrHJ5ohzZH2WZItq7zeOrkiniml/984u1cZ55bC9LPkDP6D2i+R3K7/cKksOCBrgAAuRVcGfreBGxs9sC3wqRyPorH313un7Ajim6YJq9pRVV0q4TyUiIZ12oxbhCceL2eMHBUHWtngrd9nNhqeD79YQANLwIw8W5bV5sIWBzWCdl25iKXPrZkAFgcCKPOpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lk4/E2VM8Rqv4wfUwcKGmbv1cn6UfcpSayUy5inG8vw=;
 b=ixrJMNlq3Pw8Kr3pcS/7o1Qz9+OeqleC8jzdDgO5nBRCtLi9HI+A0ySMhCuxqZKMQXZWPveisw3lPIWXoSsAGY64LqHqfNAHBEnSnNAib/qMCif/jVS/ZAAe3JMVPDxAyv/8vCCOzvb0PBAgFo4eijsrDCXaewpFusilk07wOkM=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH7PR04MB9644.namprd04.prod.outlook.com (2603:10b6:610:252::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.16; Wed, 11 Dec 2024 12:28:04 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%5]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 12:28:04 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Kanchan Joshi <joshi.k@samsung.com>
CC: Yi Zhang <yi.zhang@redhat.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: blktests nvme/049 failure and fix
Thread-Topic: blktests nvme/049 failure and fix
Thread-Index: AQHbS8gfmrP/xzem0Uahy8oupUJELA==
Date: Wed, 11 Dec 2024 12:28:04 +0000
Message-ID: <s6mohcucgshee3wcs2z5e6j6eugbidxz75szuyiuzb764teqxy@6j47chnzjzvj>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH7PR04MB9644:EE_
x-ms-office365-filtering-correlation-id: 99198ae2-25c0-4739-622d-08dd19df4286
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?V0qRYRrF7YpSIQcDkO/pRe8elTW4x2nsR2MOkydmdl1o3yyYD5kKMJvWOyCj?=
 =?us-ascii?Q?G6N5u3Y5S3O98S4BVPprf3haPMrQYv3ARPHHpKeoGk6tdB2VsAriXxogYIz8?=
 =?us-ascii?Q?WZaFDZDKQW4DQkM1Z4wUo8If52OsQqlUJVH6DmkhuLfFLGPuQDDwQT2VqJa7?=
 =?us-ascii?Q?u75lI+o+Ett2SZX/wH6Tcfv0Ir81nHWsvTmrHCEtMDqBqSn3hLDpq2B4Czrj?=
 =?us-ascii?Q?AvbYy9DdJPRmEiWwEpOhEk13iUTDvCWBcbzGSqgGD3VWKicC6EKcIstCmq01?=
 =?us-ascii?Q?BPxzRdmxWSgQ/C544W4aBUWEMp7hoTKhKkUb8KgMl+UMJDRTztLxclBCJZ+o?=
 =?us-ascii?Q?KvTKeagIBtH02GM9vYSkLsLMlqgS2ZwA5QlNwWIaGGOhRisSm1JXbjlWVRpo?=
 =?us-ascii?Q?I7vaFWkHWcn+SAR3Nqvw7F1gDqpltOtKzeAKs+PQt96Y+h5A5agoaHv+zgTH?=
 =?us-ascii?Q?ISJ0WSbaTX8ElMjMTBHtyi/k2cF6T9adezaY9BaQ6GZwe0yIh/LRUf90MoTD?=
 =?us-ascii?Q?MVq4DDljqdiXBscpdxzYvT6DbQhbAY88vpffLIMAedueAVS48e2VzyjLVuHN?=
 =?us-ascii?Q?rMgDCFUucOskLA06aVEyPcAMDge+Wy7IE/MHwGCaA4i4nCfOJ3LMjImnZ7SW?=
 =?us-ascii?Q?Y1y9GRP2XLTfXaqkmD7lj0/etCMPDa6UT2FGMD9ab7/lpCq42/5Ci6YNAdRL?=
 =?us-ascii?Q?dk+2FvdtsxmECh9S3zmaME/zMHNzUOCpNu+IsdFXWdgD9nOgv+D45h+wMUlk?=
 =?us-ascii?Q?N6KHR+Mm2h+qhe5pyWoMhpid89tYjXrBjqUNirXAUrxv9KoEQH45qzgbV2Y9?=
 =?us-ascii?Q?KbZUb1jgT+uSxB/xlsJzQ88QxbKlFuVGR3QHK2P33+WnDYtWeladf52bS//s?=
 =?us-ascii?Q?30nHqPZapR2WArCIW98psNvjlHpyamLKRCDWf/+UBv2/7VwdvN/3Z0DUIvw0?=
 =?us-ascii?Q?Y+X/iNroAcki+D3Tc66x8FO1jPobG3ng3NEkDKqYLxOkYnwEE6aHa2gVuElw?=
 =?us-ascii?Q?F+bbxCxfBmrrWnMRM31/EpO8GDQXGSLs1Mh/eIByzPy39m196uuh2DkkeXCh?=
 =?us-ascii?Q?tx31Q8HHbIaoDZ2eYbYu0ZVDp35ZG1vhN38CyOW5naFMWM8crZ6Bwq+xKR/V?=
 =?us-ascii?Q?5qPtnyFr6eqZu21Yld0jdScJZ2gBx8PU+rQRt1Y2x20l7dS824agl6xcNRFn?=
 =?us-ascii?Q?JNE021ikgYnI73GvRqIONzWzi9J3p54ce9Fv15CBwMAZF5D0JkJ7LKn6o2Qs?=
 =?us-ascii?Q?4mkrOP4XJko7N9pV2t3MP3N9VkSXfjCBTjekLxIuaj/HIBZipDSPcTcS6j2i?=
 =?us-ascii?Q?MPjaO/+8+CoiJnR1giQ6bp+vrTMniWnElL0/eIdtytKW7eIWI1WQ+sBGXe9g?=
 =?us-ascii?Q?2dsOcO53jCC8+UIRlHRdFzmPDLGa5L1j2uB/PVvw3pfzRmufDQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fisMSO81UawGXFYNhmaOqq8YeZMom240GHWXjx680EtZ9jxaADKLEUJblV+e?=
 =?us-ascii?Q?WT+FghcqFkh+INLVs5CUtoQHtZVP94STq6DPSfmAkdEWm3EQUO9SXb8CRJSf?=
 =?us-ascii?Q?d+91dVtSGPDR6JCWYdE5FP0N47u+YftNUPXe/sW8K6xLb9xONqM7OoNKxFC/?=
 =?us-ascii?Q?peTL71P+MhO30eMZks/8LUXywuY1bCPo2gfTeQyBB+Xn+FZsn8Izh5HNMydS?=
 =?us-ascii?Q?8cb+3bKchOKzMiJpA9n4XCDfHBhDejs4Tdgo39cQpQAdmL+Ce1sXrPJGD8yL?=
 =?us-ascii?Q?cGCThE1NTXpnbnd/WDeihLcOkLTVHELUjHdWoWLlRq9mjxq1y9uY/uwKgxfO?=
 =?us-ascii?Q?gMuH3UFwiN1p9hRdakWn/6TJdH0/Ppx9SBFT2+v8rlxZh94LEFlLJqb3Ouj/?=
 =?us-ascii?Q?iXgk8y2NXp1Pq7pq0oyRx1Lfk0LoXIPYopkLA39yUPdhyGJe5CklDSrXeyxE?=
 =?us-ascii?Q?d8zQy2IiyoeGxsf22oRmomQrwkf0pdEY/Ncugj2AgcBwDar6mlxhbcyCNHHZ?=
 =?us-ascii?Q?pM1Tctjj9rKryqH+N/Dxnzbrvzg8AHK1HjKgRFT3WIjFOsl9wvZfo4Mc4YQy?=
 =?us-ascii?Q?ATApZHlJXyfJ8uod+07hHjpFwvBbUaO+7M8REqwSYPH87ZsRdaa1fp1AvcGO?=
 =?us-ascii?Q?oyDwwo2S/sY5KON1SAFuGcuehAqyjxuKKFCirvHpW0r4hPeCusmFv3CEZySj?=
 =?us-ascii?Q?3UeI58DF0Q9IOFt+9Kkt7LqFqKnsfyCo0rU5Wrb1/fwJigadOE4F9yDviZj5?=
 =?us-ascii?Q?Mom2X8ouv7ch5DZfbvzA0NlHVeHIpc5wR9wbYUhlxQkMg4iPGRB/DUNx7sTV?=
 =?us-ascii?Q?z1sukd1qhPhsSmYGT2Nxt1g8Bhx51Q3O21Jr6lupx5AOq8s8dRSDUD3Rfa88?=
 =?us-ascii?Q?TxyoYeGkDgVMxKiTWzoHxu6WEssa6uxAbFwGPySczNJPoIgDp/6gUelujwJd?=
 =?us-ascii?Q?gvzX5w9NHNDv5raQFbm0GXO8XC+iqKfAt7byFs0zB8vHqCNg9wPIi2j8AE+a?=
 =?us-ascii?Q?aqGCZNu9mbYa5/gtA7XVj/AOeDofUvl4SPoIbBEtK2/MlvyzYow/OJfirswX?=
 =?us-ascii?Q?yArcoicAnAWphZAxUqA1Y5/3WTDUyUbrYDj7pQ642coTav3UNe8MW4ERsUkt?=
 =?us-ascii?Q?NOCjqLl9oZQpIyHxNn84IYOIxCHcVq8Qjf4N4lVW3w8879lYZAyEQk7W0y0R?=
 =?us-ascii?Q?Zc58D1PuNXwv/GjDi/i2bE69E9PxOt2597RDhRoXV+ozNlTpR+cB+AI63slp?=
 =?us-ascii?Q?3j1FVEOQiDAHR3nBX9tFXy/JXP/3GYZp4LAPCqz+KWT65Y3zRnzC5zqrAgU2?=
 =?us-ascii?Q?t05cnkDim1011MwVjR8nVK2gmfPvNYHUjFArUkVMlZiO7IX2jAyTLjF+U6Q/?=
 =?us-ascii?Q?xUWoNnSs1fVrEpclei25ME2US3TmWR59WMOzat5IGPedNlgGbGks8jFmY6XI?=
 =?us-ascii?Q?4GKk8QnHu3MnmvIpJ4Z3ZBCg+yciv/Z0L7XQaCu/QeVLt+t+NuzZybP5grUK?=
 =?us-ascii?Q?3C6c/Ad9lcdjLAC9UVT5zeEzzcD3AvL+fiL3AtffkJ7w6lu4rJDSx1CBdqUV?=
 =?us-ascii?Q?/ZQZdzN60U4vaQ1k5Ity/E7eTwXXqqq2oPLxEY9mWfA88kdOzb21xoX1zdrS?=
 =?us-ascii?Q?9SnXrCm3Oziq6ceOlPmv1wY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2115F45445E2F3479C75806BE73AD2CA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: v2hHwDH4qP++kBTdpgw19lpYGaKzqrWhTPEqGoMMSJmh6UoNb1RVcTgNL82/GNAUomXGS6bZnTI2MChcPQSVxkE6KmpNsf16oPt+Wp0MJHaLQS9jW7efQMtVrdC1roDKSaO90Up7RtqEscuZCSAwRsVi955lC3nlmJsK1eSGOIXZdSNh+NMy/w+2WeyTsZ3dFXJ7TfRdMibMb/YQsMpsvVkcmJKfwrj6XrlHls5bC3uWYgRX9gaqk+GnpDqhlx67D8jtrRwNo709L1PDfkbrDURykXI2e4Ud9J/jQJQmpH6UX4comIcpVOOq+SqP/1+Rix17euGV0Bu6SUe4MFW5OTAxc9lCBNwSh42DmSR2vpsCyyQuFa/nG0yYFLwTZ0SuFfsnpJGk9/ZfOXA48pnDSuMDzMjEORw+XjgCH+7EGc2WzgmfxqOjcLa+nZW4rDqMuhv3tozSDljecZBNBtB8PhaUh8t0mYwfymbVTWEKjP8LQ5Vz49uvy475B5e48/n7G3LJteueMEaPa0dCwuaye8bX5NvZC0pYPpNuzTGxUuZzPpQfadu+yfeNnH3SUJhLe75u0Tw9zh1P29PsBvxd+th5mv2jVF4ksg8P66xhgpBOuEKHhRYhoPp/u5HM62M7
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99198ae2-25c0-4739-622d-08dd19df4286
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 12:28:04.0385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gpBAit07WSmbYURpT4eOfGwz5IqRG3MllM8gSgBSxRuVRrQCOWDLRJ5hU4DOKkhq8WWiFoaSQDJsGcbgl1Mxv6JZHocbAVOcW/tnYnj5A1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR04MB9644
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241211_042807_291490_AE60DF86 
X-CRM114-Status: UNSURE (   7.91  )
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

Kanchan,

Yi Zhang observed a nvme/049 failure and created a PR to fix it [1].
Could you take a look and comment on it?

[1] https://github.com/osandov/blktests/pull/152=

