Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B9B1CFD31C
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Nov 2025 07:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4YW1uuXnDntCl31Iv3xSCDomdDENuAx0EqwAh8B2LDs=; b=emK95SatL9gWJtYrg7J4lDbgiU
	+a+NIvuGtKgoDvfx1Ch+9zYXL2Oq8pMaHAVi5w57ECEXNGQ1gKNae+fNk4RHYYZgk0rATOmS3ydtv
	MfwHye49aI5PYYAtVIOem+BqiG6rnnZb3sJ7XBJvikY4fwg6ODUseGyGgI/CFYjlcmdAdGD+p3LYW
	Lj9pA89X4tr0WX3mm4WgA6iNVblbvURL1CMQp7FZv2Gz+v0t9DOQmxxCaUN2Z0y0Zu1p7Dyf+YVCU
	LPhbpRLacZ5YCr69l5Lcc6QcN57ek+n19PHRwfdgayji0ha9uW/OS+hQ9wAwCpIE0kUEn2f42/+CI
	RYeSC3Dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNRO5-0000000BEvY-3iMK;
	Mon, 24 Nov 2025 07:53:29 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNRO4-0000000BEv9-05jL
	for linux-nvme@lists.infradead.org;
	Mon, 24 Nov 2025 07:53:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1763970808; x=1795506808;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4YW1uuXnDntCl31Iv3xSCDomdDENuAx0EqwAh8B2LDs=;
  b=kFKnDzT7OgI7MHb4yJrC2BJkmNbcuDe1fhjL+d4+xxPDQ6p5x6M47xmN
   YJNxR591SK2C4uTJ1XuCpObkrX0wcJQLt495xtV/YAmU4LiI/H9I3JoN8
   FnJ76pSUxuYm42CIpJXcjwnqWk5HpWwu2g9lB/kOQBM3GB+2faifjWDzO
   1bJkfhR9p8Cf8hmpsHS9sYR0m1QkIoeD757kI7f4NDYrYpYrx5g6QWP0x
   VUDRS0M/F8Lotg0ws2l96MWZM7s5uvGeoAxGYuMGuSjvD3KheWOu3AqtE
   bR4O9TEyqqLfmnwshIYBuqyymS01LL0FRlEsCq7+X22vybMLA9e/0+tZT
   w==;
X-CSE-ConnectionGUID: OX81HUf4SISpiWlBZ9y58Q==
X-CSE-MsgGUID: /Ow9qk2ATVOglo19w69dtw==
X-IronPort-AV: E=Sophos;i="6.20,222,1758556800"; 
   d="scan'208";a="136608908"
Received: from mail-westusazon11012059.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.59])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2025 15:53:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZjAyXY8hz1b3vUMRObSocaWuNh5lw9jTDjzbcTI+vvZMCargIFA8HQyN7ZgwAe+SR2UvfNjowVkr9B/+Ym644KyamQjVUCJnd53kdGlJZQQXKD+QpS3ZkWyOdd9SoRQ6bMXGUdzgH0eGEn+w0E9VXluKoywb6j38esEGtT4LNB9Jqxki3L/fRraPWDrrVGs/iuapVlxck1kflU82MQk7lef/UfQ/LH0PEf0nDROlHS97ftARjBBx4F0/fsQPtcwaIp+WM5EUKcw/tTUrM5P3Z7u9e1ozxMvmymhewbevlI8nqnRRE+MvC0QsuSE+dg7PMPTl1gG44FUNezh775kIRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4YW1uuXnDntCl31Iv3xSCDomdDENuAx0EqwAh8B2LDs=;
 b=Lzb9K3jNaIyLDsIWoOOTaCKVbQcHXT+FRUPFTUrtJcFznOD5xkyMFRMxoooza2gTpAWsyIzJ6W6gyW0H40X9w+hrxTkd5gRCYN9lQO5XvhL+0wuP4Gsn35yXvAP4k0W5ROO15Ghwy+frsw3/T40nO0MbYLHebEtc9d95zvYVusbZhDd+FaCqsdcxmblcWbcYBzjdZAbRu0R7YvVRS/eh6mObDUxwU2G4BbwF/COnpY2jfdCAJHU50xVAJ2ZQ1hjcpZmj1MukHsDHJNFL4pbgWJnSm8CwyG6KRghYa99WwTwdYD7RXW1TuEarnBylSe38E7YQqo5dQnnOhFhvwAhC/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YW1uuXnDntCl31Iv3xSCDomdDENuAx0EqwAh8B2LDs=;
 b=ZsQlIi90Mvkre/PmMtzWjMe0I+c73kf8O+grzJNAgyrr8d8tCZLmUpL2zzWwfE2TdLV6JSvDaEDHI9jMilaHKkObHbaTT0WfphE2+J+tJvGEomSq9qSK94UOqor3ZRnRJBzalFJRmzE3MHTPzxL3rucSUUMzsfkJzOH15DOm+VQ=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by PH0PR04MB7288.namprd04.prod.outlook.com (2603:10b6:510:1f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 07:53:24 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 07:53:24 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "agk@redhat.com" <agk@redhat.com>, "snitzer@kernel.org"
	<snitzer@kernel.org>, "mpatocka@redhat.com" <mpatocka@redhat.com>,
	"song@kernel.org" <song@kernel.org>, "yukuai@fnnas.com" <yukuai@fnnas.com>,
	hch <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>, "kch@nvidia.com"
	<kch@nvidia.com>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
	"chao@kernel.org" <chao@kernel.org>, "cem@kernel.org" <cem@kernel.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>, "linux-xfs@vger.kernel.org"
	<linux-xfs@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH V2 2/5] dm: ignore discard return value
Thread-Topic: [PATCH V2 2/5] dm: ignore discard return value
Thread-Index: AQHcXO4vrmBXkc7TXUW0PzYu9kO4TbUBdPSA
Date: Mon, 24 Nov 2025 07:53:24 +0000
Message-ID: <a0dc01ea-246f-45bf-8ec3-62ce44d76b05@wdc.com>
References: <20251124025737.203571-1-ckulkarnilinux@gmail.com>
 <20251124025737.203571-3-ckulkarnilinux@gmail.com>
In-Reply-To: <20251124025737.203571-3-ckulkarnilinux@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|PH0PR04MB7288:EE_
x-ms-office365-filtering-correlation-id: d9f930cf-6fcb-4435-e347-08de2b2e8b89
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|19092799006|7416014|376014|1800799024|38070700021|921020;
x-microsoft-antispam-message-info: =?utf-8?B?b2p6L3JsU0owcHVmRHRLZExQSWY4K25LRHhXTnFjSTBQN09mZTcrVUg1dVVF?=
 =?utf-8?B?eTh0ZTdkWk1pK0hCUklEU1BqazJETWN3WVdieGs3R2c0LzhpN09rSk5qWndt?=
 =?utf-8?B?L1ZiN040N29YRkwxS2NlakxKY3hNb0FYUlQ0c0hJbFJLL1AzWGVEUzZJc3Nx?=
 =?utf-8?B?UmFudWRGRkxQMU4vdkluWU5UclAwMUtnZTlEdXVEYi9pM3ZzTGpsR2I2T081?=
 =?utf-8?B?NGt3bVM4RmVhdDF3NlJDVDBTYkZyRVE1dFJIQUMraVVMd3F3QTV0RGRrRGR4?=
 =?utf-8?B?OVRLcjVaNnVxcFZOSmRoVXVpUnUvb21VWXpnQTNEV0Vha05EZkJGRWV4aVl3?=
 =?utf-8?B?YzRYQnl0YkQ1ZkZ0TGI0dEJIaWQxTG9rbHY1SlVCcjRxYW9vZ2kyRE0xLzdk?=
 =?utf-8?B?UGJKRE1rT0Z4NWloV0Jyd3N4TkdGRm93bEdZL2RuQWR2aHFIeUsveW9CZHl3?=
 =?utf-8?B?UFhZOGJ3alBidk5oeFlTUkQrWkRkSEFBYTRHUU9PREd2aEg0Skh1cStMTzNw?=
 =?utf-8?B?cFQ3TDZzK1grdEVZMElvY25la2ZpNU9LRGxHbU91YkhpTFZrWlZ0d0llUkNu?=
 =?utf-8?B?TGVVSHNaQTBvaE8ySzlFeFR1dFpqWnluM29NQlVwNS9Hc1p5TU1wTytRdEFt?=
 =?utf-8?B?T2dwcEEvTDBXQmpyN05BanU3YWxQMEdleGxGMzRFcG1xNWhtalFTVjBhcnF0?=
 =?utf-8?B?ekRud3NtOCtOM1hXOWFCNmZCenJUYlptVzZ5YkxidnhmcjdGYlhFcklmbU90?=
 =?utf-8?B?aEMwWkVXZGRUUE43UFNkUzFLajFDK013OGkwelloNGkxQURtUFIxN2RZc1Jl?=
 =?utf-8?B?RzlHVnBqWkhTd0dhc0Fndzg4NVpDa3orL2lyNWV0RnNvdy9iL09ONERQcG5E?=
 =?utf-8?B?MndvSU1xcmJVSDFSaW84dzlmNERwam9ReFhzT3FDUWU4L3NBQWRsdDcvcTM1?=
 =?utf-8?B?eTBibjFNa2hxdVZDTHhkc0RrM1FQV24zVytVcFNZZ1lzaHhmNGMxTVZjRVVE?=
 =?utf-8?B?Z1VBdXVXU1ppa2p5ZisrUFdxcWxDa2xEWnlPVzFCY1Z5bEI3VnJWSEsydXBt?=
 =?utf-8?B?OHpiTVI0R25CV2diUzJTUXR3aTBuYUUwR09qRS9PL1h4OW1IYmE5VlRjaTBU?=
 =?utf-8?B?V0xZenNOYmc4WksyRExsdHE5emZMclgzandKSGRHRjJyMWc4QldleVJzazRY?=
 =?utf-8?B?Wkhsdkp2QVRUZ0tENW5rRmRSMCtGUm5NSmprT0NSUmdkV0xaUGlscjNPRzdy?=
 =?utf-8?B?czF6bkxUSGsxY3AvZHdCRm1jSzBVWDFRb1pnU2Z3S1RZSXJCVlRtVHI5bUpn?=
 =?utf-8?B?eHlIS3Q1dUN3eExUSTkvTDdQYkJOa2RnSWpISHBSam00QjRwemQxZUVmeHlM?=
 =?utf-8?B?aUVjT056eCszL2lKL082STh2SHcwMWt2VW9DWmdQSzlUSGVqM1V6MzIyY0pz?=
 =?utf-8?B?V3BHQnFaS0ludUhMZkRHQSt3UmlIM1kwMWpwdENRUlRlSmY1azhXNlg1YWMw?=
 =?utf-8?B?RlFiaDUrUkkwakJQTEhrek9ER3ZzWFRlZWIzTmx2ZjdlUzd1T0Roa3JlVVdr?=
 =?utf-8?B?Mjdxc2dQTko2aFpKYUxWWFlTZjZNOGhKaWc3VW8wK2NTRlJUVXp4RG45Vmho?=
 =?utf-8?B?WHU5eVgvK3pzeEhpSDAvQnNrOC8zT0prb3VISHgrMWRaZmdHZUc1UEQ1REN5?=
 =?utf-8?B?TjdOeDRuWTNGVUdGVDV2eXdYSVZjYm80NHJzYWVCVkh5N0ZlNDhhVWFjTHY2?=
 =?utf-8?B?QjFBcnR5a09Sbm9jNURXV2o3ZG00NmtUYVBSRE50RUJ2STJmeWhyMTljckpB?=
 =?utf-8?B?VlFKSGIyeTVaTjhDSEt0UmREc3BTTWdBeXR3cEpFeThRaEFzajl5d015NXZ3?=
 =?utf-8?B?T3c5R3dIdXBXOTFwYytwVU9Zd2tvSHU5ekhzMW94NlFHV2pUQWRkMThHWE1J?=
 =?utf-8?B?a1N5YnhEYk0vQVd4MFdyU2VsNk9DVWFGOFpTZk95a3l2Wi9GWUdDZFFkSHZC?=
 =?utf-8?B?T0NxTzNDVHZaN2ViNFJCSnBHaVphZ1dzcmZ4QTd0aHVCQmg3SFlvalFUbzJM?=
 =?utf-8?B?dElNUjEyMzByNGhGSjZGb3hoTThqMis3QnpiUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3dCdkhvekIvYWsyL2N1cENTajRLL2hCRlR0TmZIaVFSTmZBUlFMTlUvaHF5?=
 =?utf-8?B?YXVxcW5ENTZEYjU3RGZXcGl3TGYwVlc3c0xiZUk0eXVEbElhSGE0eVluMHJE?=
 =?utf-8?B?MWVMZGY0dzNWeVpZbDNLVklmTW5KWUZRUmREM0dCUnJsRUtBSDNvTnY5S1JE?=
 =?utf-8?B?SHlkTzlRQWYzMDdvY1c3eTZ5dkc3NVhmaGZNdVNseHE1VGZEZ2Z3UExlVUJF?=
 =?utf-8?B?ZEZ6dG02ZURPUFRmRC9CbFF0Zkh5TFdaMVBjMkc0U2FoaU9VQklSU2V1Y0tX?=
 =?utf-8?B?aFVwRDQrTE5Nei9jNzFkQVYwcnhsdTlKaGRlOEk0YUt1Z2lqb2d2QnkreS9T?=
 =?utf-8?B?cHZXc1BOUWpUbG4reVpKK2F1R1I4UDVjOU52MFgzZUNWWEloMFdnUldXME1q?=
 =?utf-8?B?eW8zZGJHZ2ZJUEh5TGpWR1NYa0hYZStmK3lzVUJMYmp3cEprUjhtbytTUEpv?=
 =?utf-8?B?cUxtUkRqUVdCWXNxb2d5eHRFQkFlWUllQXc0TndubHhPRk1aVFh2cFdMbk1h?=
 =?utf-8?B?U0hqWTJuS3k4cXJBSFJzN20vMGE5TWxSV0FISkpGWlMzUEhqdTk0S2xOTUxM?=
 =?utf-8?B?cUFIbFE3bXNVZ0lOKzVnZXhscnBsQitxNXRnS3lkZDBmOXZGWnB5eXk2QTVv?=
 =?utf-8?B?Y0ozVFRYUjRxVzh0NzB0QStvWlhzRll0NjYzZFRLZ0l1bGEzY1NBaWVWS2lE?=
 =?utf-8?B?VG9Wa1dSaGZSR3VZWVVOeTNqLzdFbk9ONnhKZ2QzQ1hqQ2dSQ0lIbzkwUGhS?=
 =?utf-8?B?eFE4MlhabFF3NE5GUWNrWFNvbUdTNm1lTFArRm5vZFo4WmhjU2JqNEJORFhJ?=
 =?utf-8?B?UWxzQWtBSUUwZkJ0YW9JKzJDbE8waEZndjFBTHUwL3NOVDdtV3dXTmlQZUNV?=
 =?utf-8?B?Vk9waExPcHVibmdiVHN3WVpCbEZMdnBCMlRFUzZ5N3BXeVJjZUZ3MExITDQr?=
 =?utf-8?B?RzVLS0pyZXJ6NFVzbHZHUGZibEFNb0g5djEzUG5BYzg4anEyV3EzanhydndM?=
 =?utf-8?B?aEJtTS9NWFpvVE05OXJpa05lSjJDamJlYktHS1EyUjgrekVQNlJCYUJabVk0?=
 =?utf-8?B?SHZMR0QzTmgwTXl1K3NKbmlrazd6UGZBK1NXalczMSsrRTlJcDloT0VIU2Zv?=
 =?utf-8?B?V0lSL0RoNVBVRzdCNE5pdHhYbjVTS2ZISitkYXdoM3ZJWmhtOEFkQlZlMXZV?=
 =?utf-8?B?L3pDa0JDcC9tRlQxU0loNyt6YmdDNVdNeXBRYUdaaGlzM1JkOWFUN2UraVhT?=
 =?utf-8?B?OFgyaHNxVDJGMmRndFowbWZacG1wOGk4ZGFVakcxMzhjRHUvTXpvVFlXcDlG?=
 =?utf-8?B?b3hZRnhVRHp5WWs1NkVwaHdiMzVhL3dkSjJCSkFqTU96RDVCWUJGa2ZrTnhP?=
 =?utf-8?B?QzNqTXVCMGhrRzZOR01iMlBJKzNZampjNHNNTWJhcDZJZmZVajFYMnFOYXE1?=
 =?utf-8?B?UXFzZFFYVkJObnE0RVg5L1RTbFRKeHVVUEZScWlyYXhTM3NsYTBEQldlczNY?=
 =?utf-8?B?QjNGQXk5cWNENGR4eU5wOUZCbXFhenRQaHNqUk92bTlyMFZoNkxET01SeW4r?=
 =?utf-8?B?OUtOU1lXTk92anZLdUwwblU2R2M3RXd4S1pHN0RJSnptMU1oMEtRR05RZ2Mw?=
 =?utf-8?B?VG1hK3hER0pqTG1EZStlVnlObmJyb1FUZXF5dzZVUXd3a0dNMzNBalZ4eEw2?=
 =?utf-8?B?dm5HaER2OU81SVVlcG93Ui9wQUFTTFphM1ZjWG9GRDE5SVdJa2ptUWpNYWdX?=
 =?utf-8?B?K0FYMUphTEp6dVlLNm4wRXJ6aHZlTmhnczNBM3IveWczSCtCcTBVaGVRaEl2?=
 =?utf-8?B?dWltOWRNdDNWSlR5Qld6ekR2bXNmdmNrWVdoU1lHSmNId25oTkVnTFluaVFv?=
 =?utf-8?B?dC9oQ1k3WS9SSVE5bGRlek00LzYvYW5UQVVndU1tbjdHUkNFVDNUVGhhSm81?=
 =?utf-8?B?bFpkWmpmYy80QlhpcmwwWkRhTExLL01obmtZY1dxYjNsekV0V2swMDV0N1RF?=
 =?utf-8?B?Z1Q2QnZlUmNGMGx3MU1DZnZWVTlJV1RHSlpMQ3ZYRHRUYXRhNzRGZ2N5NE9B?=
 =?utf-8?B?eDNscjFVU1BqWWprV29yY1Q2clB1a0FqOE5QbDZmTDlvOXZsdDBQQzNsWVRa?=
 =?utf-8?B?U21FSHJpT2w2Z24xeFl0T01BcHJtTEkvVGVKWTNWN1Q4bkR5WjlzTVhnUGtu?=
 =?utf-8?B?c2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <955467246AECE24F9CDFE7DC19106064@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UXs+nDgGP7UGAYi/6Mhi90XbRtU8kAn3gE5oa3MxAaio1/XLocgF517LQBG0zxdqjT+My4Oy7+DJsK/QvTeKp+vbEGnwHfqSx04LuxsR0ZGZUMtGwwV/GMssSKw3tG32f4f1nm/vwmHkRIiRqOMR9zANNSvUNmeSMPNFZ8DYF4+gtJNzV6wT+IkBShedfN80otLrl7p2EJWxxFOt+5m7D2n0u8vHjbX53KhxXuAnqqJ+TVxKS2EUvydya4KjGPNyvjnJ/rA7CvE6INA4UHYuR0WaRhgyDfnk+t7E0IRu59JzxA9jd3J6xzy6GSbpPdd5M+JZUQX8a7vVFNIgT9YWMifJjfX0inL7IcWKNS2eiVIlmFgOH5au3T0GjpBxvNmgGWvVm4h3LNT9JOnLRoj8t5qFSGqSwuge8cn7AlrA6uDHgTYYTmMPKW3feNC+UOzFXUfm1QCvho91Rk3hOLGYAWHmwLerN4+BIp6E1SaBakbniRORe17BF9bxhLMYbZYwZuK0DW9PibIy7zQRfqH9oPZczD8AV88EmU9ryiLqi3teiXqVPh0Y5xUzQsn6pDPmbXIk7lO+oDEpBHEbKLTuATTJX2IGuc7PU5OBGM7ipBzaTboFM6kVyyxoNvVcx5Uh
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f930cf-6fcb-4435-e347-08de2b2e8b89
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2025 07:53:24.2275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z4FeiKt82VuqgiqiCYBzVUSsjRmjh/ReE9m7bIjW8JVMivHTjbQswnAM5RST2cI+UwYNhQg0JcoR/UvAS1SDNiXPZg5xxEJ4xbghoCl5JC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7288
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251123_235328_090249_79E4D39F 
X-CRM114-Status: UNSURE (   8.80  )
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

V2l0aCB0aGUgdHdvIHBhdGNoZXMgYmVpbmcgc3BsaXQNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVz
IFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQoNCg==

