Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DECEE6C619
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2024 08:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=irsXOEhPFqSeBi2Go/R2gmhkUDNmBlQGmkAkA/Fn/9c=; b=BS5zQmfoAFdWIcnL+kY3Bv0Ud5
	57O0TAn2ueWYxyfUdMJcvEsKzxBrbfvl3UV+3xTgGWFMPU0MAGyIJe2rJmgic60Tq3rWGr5bVNDW/
	0TW22i2AMkZ0C29rXBFByxkP3rh0az+GZ2A0dmnGH3yHSOvSPQDDubUK0nqGcrN/whzoDN/ZQn462
	HO0kymKwdEub24Tyh+P6dOHNoIfMr0oSgmQcEqu5jZAMgRllJLRReZY9VxVIz3TcIbN5lPvUL5qQg
	f24//ZwYGq6WL4CN/nfiEHi6AnLq36D/z4WmKtjkGDflW99ZxrGfOf0le3osOL2lyF1EHoh9MtyN8
	D9rClffw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIOEf-00000008gXb-0Koz;
	Tue, 03 Dec 2024 08:26:21 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIOEc-00000008gWi-1pUM
	for linux-nvme@lists.infradead.org;
	Tue, 03 Dec 2024 08:26:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1733214378; x=1764750378;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=irsXOEhPFqSeBi2Go/R2gmhkUDNmBlQGmkAkA/Fn/9c=;
  b=LOBO0GeZqeIyK9AXQW5lQ8jRSnm7bSvC7KZ3DhX1mb/ySTSAXOkAHkvN
   LWIJHSczyvTnV+cSx16eny8sxX+zQZEkdM/q/XjL9RvC+Yw3qLvoGVNIV
   NynTcPD8HcTgobL4vLiBpfH9ouSiMjf7gvGVW5F9blhvl7a4uvrSo3NAm
   wM0Ie+tYhv3CO4lHAhi/8we3BYbYHE7TPnmxrHu/AEndhc975oK/bMlu2
   IDh69N2/tESMeCas146CGK7TF5bjlCm55UwzePHNTyg0cYQPUn1x58qNQ
   Phiokbq4eb40Zx2sdjwVbZ9aGuAn7gRvwruteaBl9q8MuEnCuWgi/3Ef7
   Q==;
X-CSE-ConnectionGUID: H9GvhtLjReCz7wnQsE7DjQ==
X-CSE-MsgGUID: 5SNjxsa/QHOTbC5GEyq3HQ==
X-IronPort-AV: E=Sophos;i="6.12,204,1728921600"; 
   d="scan'208";a="33965847"
Received: from mail-dm6nam10lp2049.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.49])
  by ob1.hgst.iphmx.com with ESMTP; 03 Dec 2024 16:26:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wTCPk3etAxurSnHqaekuBjWXJxKX2w7kyHeSoE82cmBItsNMXjEdH85EkF8kqf4rsoB8LiBj7EE+QaJzMD7in4ieIvYb4P0+1Zzwuah9U3brKe1Ycz4FVstA4fAiztWxYZjUsGxtTMGEQY1j1gRm+9CaXReDXlKcB/+l2npDutk9sDpbr+7czzWzXzGLaLydEUVorC4zBSLqvxdEQPm7+ZyW05xC67flbT7S1vxvIRzk+ANPmxwvirCrHblbT7CbjoIrQRte7E8WElP6GDWMw9m6ncIvJASyPOCyeE9Oho8IkIX7CtoFG9V+Jh9Xa/6pq6wFKPWX05xTO97SFpFj3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irsXOEhPFqSeBi2Go/R2gmhkUDNmBlQGmkAkA/Fn/9c=;
 b=dwhibgK++DlkWXTAt/AaniFiJDlbJpkC2Yb0B+rmPUJ1WFzTCc8XL3ayIuy0SFKjcIFU0lzbEXgvFyVLi6aGOKyRXvE12yxx0T9YL1hfK6SuerMDIetnhQTimP6W8SPS8HfPIDpX+roOLx3lgsJ7IikFq8bkMKa39E58S0u/52I4m1p91KE5+107ECPDew7KF3uX7jJXYZz8WEV1D5cuY04Cgnfmw4yNrQCl3SYRZkQBmx5MHkGu2tNd6TCDWaR2TibbxEltnT5wCWujQ0qu3zaydT4FnUwp0zLYDcR337DpmsZnL5n5izWxnm/mqewVSjGCXVxUg7V3Or9X0nkSUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irsXOEhPFqSeBi2Go/R2gmhkUDNmBlQGmkAkA/Fn/9c=;
 b=rIYVhkfMnatBMYV3A1atsnBNTQ0uFK7i+JVXfZLeEZ9/k8qs8Ucwf3/cakEsxpPyIXycJEVf6Smruk212WfbV/TbtjAj++sO2yNSLzlWfDCZkbR6DYSZzrNr40S9tSPyemjNyL1uxw3OU1dhFLRFhub0xU/YQY1p9S/sIo5nb9Y=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 IA0PR04MB8836.namprd04.prod.outlook.com (2603:10b6:208:486::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 08:26:13 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 08:26:13 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Nilay Shroff <nilay@linux.ibm.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, hch
	<hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"chaitanyak@nvidia.com" <chaitanyak@nvidia.com>, "gjoyce@linux.ibm.com"
	<gjoyce@linux.ibm.com>, "jirong.feng@easystack.cn" <jirong.feng@easystack.cn>
Subject: Re: [PATCH blktests 0/2] add nvme test for creating sleep while
 atomic kernel BUG
Thread-Topic: [PATCH blktests 0/2] add nvme test for creating sleep while
 atomic kernel BUG
Thread-Index: AQHbQji2nd2WUOE9rEKflXfeOZlVkLLPiuaAgAR70wCAAC7bAA==
Date: Tue, 3 Dec 2024 08:26:13 +0000
Message-ID: <htfujjbga5xvlmlkv46lncbutqr5b63kvylveewoiqmsern4qz@m7ulmfr3tjp3>
References: <20241129080231.2994578-1-nilay@linux.ibm.com>
 <kuvftnq5cjwtzh557umohu7afvndg3tl4lx6qfjjuwd675phk3@y5iaypkzdsz6>
 <9d6b3b9c-c9df-4fcd-bf2e-6a5635171bcd@linux.ibm.com>
In-Reply-To: <9d6b3b9c-c9df-4fcd-bf2e-6a5635171bcd@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|IA0PR04MB8836:EE_
x-ms-office365-filtering-correlation-id: 22e8a87e-fc02-4c7e-6b52-08dd13742648
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?XuCrGj231LWDfXY3CT/GV/qlbn8Of6htDMZuh68XmV/bvEHQcun5IjWzpK7j?=
 =?us-ascii?Q?2pvox+KpaPpocw99KuWeH9YZ4iIAeJWZ6Vs6igRY+MqKeXkFJrvkWSEgC9Jt?=
 =?us-ascii?Q?TUF0yDfaqDoI85kCed+CecBtqBaXxudnAWlR8R53t0EsDvn+1enu+3sUfJxG?=
 =?us-ascii?Q?CaFMVJUG8bGsDiGqPunPXMKhfvXJ1bOJhx2xfq6TY39acCNHLirdlnz1zV7T?=
 =?us-ascii?Q?nCnlnI/NUX4ouC1E0mKyLGiIeBNqiop++M5ss/cMHqskKBBW03jcwiLFqajE?=
 =?us-ascii?Q?HWJ9y21QQjjdXpckf7q1PzuIRJSjYrWvPAW2BUSsVIJep790RUmZfu9sY/L8?=
 =?us-ascii?Q?1IjLlHqNeFXeT25ZllGVhX/Oxb/51okpQ3Ow5Qqe7EMFGi4ei5EPMZdVNKzZ?=
 =?us-ascii?Q?pEMKPWlakjooOvMkbntHvVQvHzjF2I+dnt1QihqHuUN1ETyL0q/FTgHrP5Xl?=
 =?us-ascii?Q?dWr5KwqnzFkowiSXOa3A8hNy9T5B7dXDK0plBVQC8lnwyclWNIHN914Qmxje?=
 =?us-ascii?Q?GXHRgjHtUlvyi/0Mvkx1dchEdBQJT4BRST5lJciE5GKqo4pN7k/VFyvMqjkY?=
 =?us-ascii?Q?vF81frtVkj/kZgtm9GICnDWOEDo8Y6mdyneT66haTYy8qAB5f/ziDHCVltfl?=
 =?us-ascii?Q?bLNRDsZh3BZ6l353f4p6plavaKimd75MGQdDe70dbWBI+78PwtppOxln2Wte?=
 =?us-ascii?Q?xdQLndp7jtl5JL8TChGhFvgXH3A3DwFTwxo2oCfvzlHks9T08M5GYCV/gfpL?=
 =?us-ascii?Q?DSyIlZobzIgW5b9kH9TcjdV7Es822QMSq3n0DZhvkoEp9QFHDuqbhAcNs2tF?=
 =?us-ascii?Q?E1UjJwAX/ZcSULVUIyg6E9gGwTbKvWxTl95g6Ve494LqnXZh9YxP5WJ/prxI?=
 =?us-ascii?Q?XaonY2ar4NlVNd4Pcr0cl3z0gkX6qOmGXG83YGE68bF726Nd1uHaUfEi3SRX?=
 =?us-ascii?Q?0uBB/Su59QCdBjOyXZo5od3n5VIQQyIlUIFARsBC0m2TCkaCPUMDZpHUZEQo?=
 =?us-ascii?Q?AzYFmbM8L5X6d0hL7/UZiG55uBUb3RzGyOcaCbAb310QEfLnzTIrzo+zeZIf?=
 =?us-ascii?Q?C/v2KoSl+HzMQ8gTv+l2JQKyhdelH/KwL9H/kO1Gb3k8EPoX8UJavKuLai+L?=
 =?us-ascii?Q?TNmp3dPszT80Tz0zGQyMDbuWINnJsBR4UW3vJhsnANHibVV7onb7GW+O/DY9?=
 =?us-ascii?Q?3sp1u7GDyNTZGEvhsbc2L1zWBu85zOjXSw9rIGFLaYKX9BnOTKsJcxojQWZs?=
 =?us-ascii?Q?rpmK5DerC3izX2wXXaMSiQkDLU0bK/AEmLTXp+1i1/eD6Tkh9n8hob/sK3tv?=
 =?us-ascii?Q?9xmOOcptIdv5e9xvx7zgpSMBexvcnZjjBfhFbznblLxJvglql2NZ5ruRx6/L?=
 =?us-ascii?Q?ErygmJR0p1VrwCvS+xSoE1sLuB39N2t+8eavm4SUy5XeYS0yVVd8chIpSIfD?=
 =?us-ascii?Q?h2Ghq691eBY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5d/TUn6PhqYS7e4u+bdkP6mpUbF561KDTB9xZdoTUok49lxsH+yyPSqBHtmd?=
 =?us-ascii?Q?qbZIujLNsF+ck8PFKpjSpStuxDHH19vjUkLAIoHZz0X/MgfLjSRUYF25IPgx?=
 =?us-ascii?Q?1EtNuv4d1J4k0707hR4EZJlqM1wulPYs5laeQMKkTVHGqQ7oh9zM51xM6LHv?=
 =?us-ascii?Q?16KCIRLvXNhf6UnnhrE6zQ2WIp7q39zzz58fSK13Fef3HMq1pJOXF+VJ8Q5s?=
 =?us-ascii?Q?+ZRf4QeoZeF84BxTGZQIcagb5NjLSjTSDVpYIuPtFwVEO85pORplve77bh8w?=
 =?us-ascii?Q?ldyMZHA4Omiihqu1fOZa+zJZd6jb/mT0Wzxm/CQW4A3FXsiUYqD+QWoaB3Yw?=
 =?us-ascii?Q?MmiepAG6rHvKteI3gUWQfzQz+aNL0IhQjw+MoXortXTSZgT3PvC6nl4oU/Oa?=
 =?us-ascii?Q?xN5yNDwXvwZk3Euf/Tz6Ur/FSyRk8X+S65Yny5yI/l93iIDgApDxW343lf47?=
 =?us-ascii?Q?Hla1UEoqn1bFpMngWwdmakTyPW8cBn0SiTurBNKdCD/vmiU+7/XmE1Q7W2OR?=
 =?us-ascii?Q?KZpk5rMH8TeuQ0OtTRzyBrnR84ryq27UF0fzo6uqj7YH01uOkN+glKH+wvlE?=
 =?us-ascii?Q?BOuKfmX3ToP6axJs3HJc4tt+4y7Ap7dq5PEVW212J7W6d+lhLeNkdDykOg1A?=
 =?us-ascii?Q?LJl3aQmtbeIKI2GN4XbHPHPgMjJHqMM+5Cc6EOPpP0IFhLMANed9XQ2dYefD?=
 =?us-ascii?Q?sgSCn/oPOaPA35x2Cg91eRwLCmKMtruUUiX9q5ymlhnjHrTHw4HRtN3Vc204?=
 =?us-ascii?Q?Jtxr3kLv/3Z7kN6b8YUEM9Rfbv+q++esKYnB5qThvS8nEKrsBmkcj7P6CquT?=
 =?us-ascii?Q?6WshSuJ/7J33H7E6gS+fZcwWsZxKj+ygwKsMw3rNvI/tNFHWi8tWwTSbL0zq?=
 =?us-ascii?Q?TftbUjAEcpNctBd6pukptUiqwlUTBgRfLUauKyEiD6Uj0QbK49VdUOIKDhIz?=
 =?us-ascii?Q?lHsKBuG7wW7TC09Cr33hfRvQybOTnJJZCDOhjKJN9LTz8rbAheUnHNlnQ/Kz?=
 =?us-ascii?Q?jw43zRXRMkdHUrl/bnXnBxZR2AU7fHKFxrlzgOs2m95xomN33t9AnpEWtFhf?=
 =?us-ascii?Q?eKQCxrt3M87XVawmBDAQGOUcNWJ+fANElOZGSmpKjOooQU8HzfJSgyIePU5Y?=
 =?us-ascii?Q?v7QjjLZ5uigrvbSdPP4C3Y3YK4r0CB5x44NePHLu3yZk9xnAdGI5d+TxFM5N?=
 =?us-ascii?Q?jKLFrbMfwjVqIPriYE29C/2j1qYxeK2yrsvkgkDhm31Cyn0Wg5Duc8HrbE+i?=
 =?us-ascii?Q?+OBeSKe82l3T8nhbYhSd+3fShhilA1CYImIsI9Uog5SL2nMGb7LrRZk3KBvg?=
 =?us-ascii?Q?PHAjrbY4S9cMGJEbLCMFuQgJ+ra4T8jCM6hSvAzaexCXe3ozyQJHpHp/GIbZ?=
 =?us-ascii?Q?Ew7Cn/MMFfgwzxhz2Ewb6FJyWqmK8yFA4CrLm3KYMJNl5JL7/s53PgvnJf8J?=
 =?us-ascii?Q?WAsC/U2JNBVVLiPnxLsGF24Oiu3L6QliEsHgxbaZPWy3BBJVyTxqegyFLort?=
 =?us-ascii?Q?QmrH3b7ucSLSuhHT4o7hXvRXkOL9Uhakcc0IZxwFyb2qQsUfhMK01wx4PACW?=
 =?us-ascii?Q?Q34FyNlQyFPVOgzM8Z2NNOq9jDQ067H3MsYoeKOngGVZ7/fbu+kvTa9ghJVN?=
 =?us-ascii?Q?d/kI7EWxfVfbZpF/KOHBKsY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <82B502267B6E9541B057548A1DD53F47@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xbjvm8H7D7wf2B0byaJNUtCri83F/CwJlGbSGwjrjIM6+buq+Pe3gqdH99J9ThyIZpD8F5zb4mw3m1JHJT92mooB0sUZcIjQvrzJB+a7H+NtSt76XMWvVR30RklODWaqeTQoQx7RCXgcl6bS4qZ+xTK1O+PNV6E5zJ87zYn/H7WOIaQ38auRcpN5W+1fdohl00QJIOayoaQV5obi2804LcPg0sJS2pIg8SOV8lHvEbVUnEjibSMxBb1sQYgDRo/y0ZJVHu9bF9S/vrJWZwVNNJNACloCRCqVS291WSQjWkiUK+4WuojcQPH8/FTWs2ZZIue2yFJ8n+pjo9LsiNMbmiZ/jfdUmTgA+P8AWHz/bWY/8ht0K7JLbbW5ctpbFEnkBZEJ3WiQs7X6PWGUg0k07qUyGaCOF/toFdMHALYZvCqUq2N+LEgiiWWlfKytsRjgsOaZIJ5aVQxq9lMIkdxRS58auxQOjpjY2hNp9ts+gOwIuiE8XnfQcuDNYSOml//hB4UdQPTe8UltuG+I5eUPRKDjsnSg5f/rGK+6k3uNwh3SrqqL/iK1ur10Eb2LFnd/saUqTEiXD+BnTJeYulNJD69yrudnGthA1M67MHaJCbH92teNpl1bv6m/VM7aMXvR
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e8a87e-fc02-4c7e-6b52-08dd13742648
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 08:26:13.5329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VN/VFgJHP+huvU6AQ+AJKj+UyLN++eay+vh6j2eOR1V+OedsWKW8Kba2qQR+I6xcQ3uDFf4acrrhnM1fnS3toMJFLQ0/n9wDPFsttSxHf3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR04MB8836
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241203_002618_493798_D4BFD1A9 
X-CRM114-Status: GOOD (  24.92  )
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

CC: Jirong,

On Dec 03, 2024 / 11:08, Nilay Shroff wrote:
>=20
>=20
> On 11/30/24 14:40, Shinichiro Kawasaki wrote:
> > On Nov 29, 2024 / 13:31, Nilay Shroff wrote:
> >> Hi,
> >>
> >> There're two patches in this series. The first patch is a preparation =
patch=20
> >> for reusing a common function nvmf_wait_for_ns from multiple nvme test=
 scripts.=20
> >> The second patch adds a new nvme regression[1] test for commit 5053639=
57fad=20
> >> ("nvmet: fix nvme status code when namespace is disabled").
> >=20
> > Hi Nilay, thank your very much for the fix actions. Much appreciated.
> >=20
> > I tried these blktests patches with the kernel just before the commit
> > 505363957fad, at the git hash 6825bdde4434. I expected the new test cas=
e fails,
> > but it passes. I increased the number of iterations from 10 to 100, but=
 it still
> > passes. Do you observe the test case failure on your test systems?
> If you ran blktests at git hash 6825bdde4434 then that doesn't include ns=
 changes=20
> which uses mutex_lock. So it's expected that the test wouldn't fail. Did =
you try
> running test using latest upstream kernel or checking out tree at commit=
=20
> 505363957fad ("nvmet: fix nvme status code when namespace is disabled")?

Yes, I see the test case creates "BUG: sleeping function called from invali=
d
context". Now I see that you added this new test case nvme/055 to recreate =
the
BUG. However, I observed the BUG at the first place with nvme/052, which ca=
n be
used to confirm the BUG fixed. So it does not look so meaningful to add the=
 new
test case.

I think my report "blktests failures with v6.12 kernel [X]" confused you. I
wrote "It is desired to have a better fix and the test case to confirm it."=
, but
I should have wrote "It is desired to have a better fix and the test case t=
o
confirm that the fix does not break the intent of the trigger commit
505363957fad." Please find the discussion about how to test the fix patch [=
Y].
The question was: how to "confirm that the commit 505363957fad achieves its
purpose" ?.

[X] https://lore.kernel.org/linux-block/6crydkodszx5vq4ieox3jjpwkxtu7mhbohy=
py24awlo5w7f4k6@to3dcng24rd4/
[Y] https://lore.kernel.org/linux-nvme/20241023052042.GB1341@lst.de/


Jirong,

I found your Tested-by tag for the commit 505363957fad. Could you share how=
 did
you test the commit? It will help for us to have more confidence on Nilay's
patch.=

