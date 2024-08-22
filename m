Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17465C52D7C
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Aug 2024 11:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/IOlT5SIy7ZG1euiW28FWujSTGAJ4yMzynKeD4o/2m8=; b=klkZixtl/Wh+QU8N5BDFeDO04C
	PtmpSRf1Reh4u2FlxzsCGYYG+5OUZPj9B2E7ARsoyNeKdww4Gt8TGhZIM00w0Qo/R/wDaFI+GGtu6
	uJnbSgDMG9g7+IB8+HBUoRRcrkwx7Gt246elIPFZoyJ5R/c+iWlPCzBjXudW+WCSmIQfELck1sDQw
	qpV4ui325X0OCMM2iTvwlMAV0c0RseeIb4UVbLvkq5QPaoLucN8QHGSMPGTdm1KVnwfFvGmyk7MKa
	0/B1zr9BJ/eys/V5EbPaW22AXA5xKwTMO10r51fGpcsLgGO0YW/D07p4+RPpGYcXIeivChRYmHodQ
	coc3ZW6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh6Td-0000000Cfxp-3bD8;
	Thu, 22 Aug 2024 11:59:41 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh6Tb-0000000Cfwm-1uSs
	for linux-nvme@lists.infradead.org;
	Thu, 22 Aug 2024 11:59:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724327979; x=1755863979;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dX2C84jVYvq4RaIz/uZ6Z+Ptf07t6K6K72CB/hs70Ww=;
  b=QgbnVhpVmDOiJLXvJF3xPeQITbTmaf4+ZglqjfRMFn83/lqpNODSfjwy
   qZJMuFesxsOjKp3Zl+/u6HNVOYRc0xAhm361MNQegKtQgq2xmoFy/E1E6
   ei1b/9T9g7kkk4qtp4GGRuKdW1YBAan/3wvyWXbqafOFNZcsCGvp0Ay28
   VvhZN4SFGL5nyJJeLXLi/4Wczl6pefoaFVL9zGo5S61aYFgA48iM3+7K6
   SzFmvYu5QA/00Sb1bMcasFn4jL+e/T3W8gYOQ1cOC9vVmmwBKIBuXMQnH
   ji/YEE6K6r6L3lv3K4ObdeZskmpsksfMxPuy7JRzP0Os8ACzQnmSOWAHq
   A==;
X-CSE-ConnectionGUID: +lDoiRg/TZqnLRIjCu4Vhg==
X-CSE-MsgGUID: w4Co2MqsQR6NMv+k6pOVFA==
X-IronPort-AV: E=Sophos;i="6.10,167,1719849600"; 
   d="scan'208";a="25197155"
Received: from mail-westusazlp17010001.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([40.93.1.1])
  by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2024 19:59:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HR9sTVkkNl/ZKJcEXVkKCzCiWho/d1q2FNUpmIHwcNKrlZyycAvF6eHXC3DXGQQQXuUsfYIrj0Mb0pdLSpkcm0vf1gppoTO5fAWXs/QWnNsPd38tPevFCHP7fqlVbC+UQhnEi6Pq+Mbh90Xpn1kLq8fKhSFe4CY8F2kxhO9+TD3TX/MvWTOnWe9h9fht6QtLoEy7j3zTTNzgF+W8K7vImbYQqCmUbfXF/g+r9DWXmohPVRsJFdKMeBCSKPM51T+jco0S7IIXBZf/IRckTZVDB85TQAysobpHugmSrBJN+hgNWlpG+T+glWo2x05D+PAZq34q+PZrRnDfFPzfyOyqNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/IOlT5SIy7ZG1euiW28FWujSTGAJ4yMzynKeD4o/2m8=;
 b=Ll1ArHCUHBpB1QIpalcmYIDiw9I5Fk+xNvF5T7t0LdQzr4Ew1GZ6/jQbNnXGOZwaOmZtR5gYQ08Uldbxo+I5mgb+EVNa4yhV8k7j3kd0O8iJ8Dz8ReYfyhWC11C1ek9Mp1dZ59B1X8qT/I1EMafP4cS25Is1jNY8nS38WP5F0LrKnROMbkRVXD6cRtAswrMwyfKS4FwwtRZNViG7NQoAddELXuee5tygdtTTQ3kqmh0GNoP0cea7uTYAm4iMApHFH9QM1SUcqpBKU7NLxp9XJmJKQvBhis9WoKxLBZnBJsUk8KQ5EZcz0T0eBe68CV6x/MLwBsyopbAk4LNsLQP5CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IOlT5SIy7ZG1euiW28FWujSTGAJ4yMzynKeD4o/2m8=;
 b=oL2bZaf/4d+pr5q6SnQyDZpxHsoALxhBg2YqEGjMBnJDAeLwVFQ8bHiZbFwnVKOY9HJq0lNuNkE7zp2U2ui1r+248mG/LTx/MSLFl6Io9F+BcTV8+VIIRwlYtKDCUrpUBNs5+iQBVdainDhlnD5nwCPNZTW1Y0CiA4Suj+esqmU=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MW4PR04MB7249.namprd04.prod.outlook.com (2603:10b6:303:78::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.19; Thu, 22 Aug 2024 11:59:35 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 11:59:35 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Nilay Shroff <nilay@linux.ibm.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Yi Zhang
	<yi.zhang@redhat.com>
Subject: Re: [PATCH blktests] nvme/052: wait for namespace removal before
 recreating namespace
Thread-Topic: [PATCH blktests] nvme/052: wait for namespace removal before
 recreating namespace
Thread-Index: AQHa8uqR0Nq3uU3VMkila6SfAwK3vLIwXbgAgADx2QCAACN+AIABgyqAgAAtNACAAAw+gA==
Date: Thu, 22 Aug 2024 11:59:35 +0000
Message-ID: <wpapwfrmpkwxdqahiwvp5y6l53z2xuidc2qyloolzfundec3p6@vsuen2jtxot2>
References: <20240820102013.781794-1-shinichiro.kawasaki@wdc.com>
 <d22e0c6f-0451-4299-970f-602458b6556d@linux.ibm.com>
 <zzodkioqxp6dcskfv6p5grncnvjdmakof3wemjemnralqhes4e@edr2n343oy62>
 <0750187c-24ad-4073-9ba1-d47b0ee95062@linux.ibm.com>
 <wf32ec6ug34nxuqjxrls5uaxkvhtsdi4yp2obf5rbxfviwlqzt@7joov5mngfed>
 <12fa9b5b-8a8b-42a6-9430-94661bfbdd21@linux.ibm.com>
In-Reply-To: <12fa9b5b-8a8b-42a6-9430-94661bfbdd21@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MW4PR04MB7249:EE_
x-ms-office365-filtering-correlation-id: 42b4e755-c9b5-4e12-10ae-08dcc2a1e40a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?usmV9Zj7s2sI3DM2b7L7cPEgZvuYapRdMV2bZ4903LQhJWxNZB/cSUgDG4KL?=
 =?us-ascii?Q?Ikj2NARRlv6AEfQsMLP0GD91HxvQEHuTiMHNmAIQoCOr45hzng7uip8IqNZb?=
 =?us-ascii?Q?3fCOhGeHAIg1iDPlVRZVtZXWPnbXMB1snld5YkWTvoQ0vrAtw+VUkCQExu2r?=
 =?us-ascii?Q?UNeEAzgFEwqKPz96QYVC6TDXWWXx44HvIen98kohEMLXL9Cly4R53nxwORJz?=
 =?us-ascii?Q?0A+6ff65veV9+lew7j5epTM/fDXmeDinVJMSan6irsh0Gg2nLLBT6X6kGDTw?=
 =?us-ascii?Q?8t+bUGGJyS645WcoSkdSPxYhYY2cqdLgkpngwJRfx67x4YmPjNngUQ2g1Yhh?=
 =?us-ascii?Q?zkM8A6XH0P3NdTw9FvW1WHCDNkLBo/hbv7zDbP2zf5V7/hsx6Q++EiSHRwWm?=
 =?us-ascii?Q?PP6Rv3SYIdUEJhiWQj87RyhGnmh1qyO176Isb1tmAwhKYWZ6tGiKiLNkAZyZ?=
 =?us-ascii?Q?Qj+s6LG00GxvMkAv+EEkY25NAOPkEXnTOhc8GLKoGrVG0xVVU1u1b44mtejN?=
 =?us-ascii?Q?WcLO9tazLfhc1ePMAfOHcVbCjfqWUySYQtelmNfdsFlC/uvVxD8P7zGarEEP?=
 =?us-ascii?Q?paeExVEXSPaSZ+x9tgzbJOac0hCSFetooKkOqsEMXqbPENwe4U/F1NCiHS9F?=
 =?us-ascii?Q?fnZdDNLLtobJ0X1nbBndTBm9ufABl8gRhXNppDcYWvxFLQd5mMeTLVh68g6n?=
 =?us-ascii?Q?nq6OBlNY8FSZQR/qocXRw91MxK75JyMXmGF2/SR3V3ELe3QFS91zWJZ2xDpj?=
 =?us-ascii?Q?a/Aqz9gTo3tWwXDsGgcck0O8u+++Lp1rnsJBDBA8cnsTMK0SuGZWIuQhmWs0?=
 =?us-ascii?Q?EMnt7SHeHKE/BTzyO6rTMx1RNnznF/YH8WjeFUw28kzNgdHAl7cj3qShQtsK?=
 =?us-ascii?Q?61ztRdFVzmbkeGUlchxUZbR0jO78w+1cIu3ejYmIbBfYgv9p8yHz+zeM0qcA?=
 =?us-ascii?Q?1iE9qtzGESkVLdTOYht+LgHz4rBAHeeA5YR8F0A/AMxOZQ18MzQqTlkYi/pj?=
 =?us-ascii?Q?3+pgxtfJ8/1Nb9RLiZXwzDSdvah1mMsQC8dd16mHKHsYFScOW8Jq+0rgvMVs?=
 =?us-ascii?Q?SX9oQfximbO01yNoOYVWb1sG1sKjLRPlgMN6dvpcufQnDCvLDU3+dOBRDOSd?=
 =?us-ascii?Q?5CTc/z1OkTNfQSS/ucm2or7U0Mvf1HoPcrtYTmwkNBfluP66cJPEkEKQIkUg?=
 =?us-ascii?Q?+YROFqvYWzeMmbkgg+eM1zht+lyB+pxCArNPwvIYWe6NpkTVJz5iSJYIj8aJ?=
 =?us-ascii?Q?urqTrqcAYvTaFHEot5NtiXmJVwEt9py26vTkPYfACLZzDAwsdBe6zbFdooOF?=
 =?us-ascii?Q?cMUP2JdnNUicfSe6aB6872iStqrL6drTmOSTdWC8Mrc7rEfmvMPD6RFeWIOQ?=
 =?us-ascii?Q?QHwMxJZ4zkWoc6ZetIjc35VBsbsPN6Ldu+tn8rdxkhV0SRV/FA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oYI4jSi78BolAo63gEEjPtU6jgIrrcTJjPB7GR/+wVXKO8lZ6Y/iZdsji28A?=
 =?us-ascii?Q?SQzYxWv3AKsa3lVix+wWUKx4fLLa2TG6G8uuSOj81FCdMkF5RmLTydRFyyp7?=
 =?us-ascii?Q?337Aq9ldEm7KTsSe3SXMIQaSiqbNk4y93jU4NsBjnDeBMWxBXVz2QXOY6asm?=
 =?us-ascii?Q?PEQEtzQWB0MChhkCWNMWykN+PLuHXkZCnAQqHn3wIegYAZUofWp0iSWbgV8M?=
 =?us-ascii?Q?8YJkpCzDk/nRND+KP90v9rdGT3HxyqnC5jxdtFrrb2DAbu552CZcykDe/g4A?=
 =?us-ascii?Q?S77vR+fROH+80aW3C7zETEmh/Wyz4vgOqptjJhXHsvk6wRYcnH+0YxZ9uJo3?=
 =?us-ascii?Q?8EIC70qWBixnmDvoZpR5K+mIHdgEU4cvlH301TFX0kREnSrOUt9S5tmlNBER?=
 =?us-ascii?Q?YsgqNd4gokO638dShbhC4M87DkdTVy64H1SFYeUjTAvj8oHAU2ghm9kwI69y?=
 =?us-ascii?Q?IkNxx5zCl5aRUQp7ega9K7Rnyxt15nM2oMa5Q+anF8a7uhJ2alLELyU/ghnf?=
 =?us-ascii?Q?WPbglhQ+XbazxyGp8NskQbEtf9DiAvTZjOwJPdHBImZWjjlRf2TPHA8vMT1A?=
 =?us-ascii?Q?4AVYwME7+YnzjGGfJHs/pgjm1OBUKBA9/466y16YJr77fsUEYxWjAnZa5D8o?=
 =?us-ascii?Q?tUi48MfT4mV6GAtqYzE1s9gaOyHNVzXf4fwSUcHY3n6jWQb/UEVXNXOoBs8Q?=
 =?us-ascii?Q?yFB5PsWpv3e4WNmEcHBim2vqk87dZ45pBa3vyn0hdAdAQHoHxyUbBzsRN7ET?=
 =?us-ascii?Q?YhlnN2QCiNZjyAzLbbzTNjnpYpnxVIqggX3+kcBx5IZx1SdkHZ/PoFJTpViR?=
 =?us-ascii?Q?3yKDmye+x0P4EQHjDJxrktqJ+IzEZ9ZJJ7myQOI8HzxYj3WNGSSSPD7Kr3RO?=
 =?us-ascii?Q?4SowU7il3Wvrh5oV51k3QyxxBO7V0C4usjPCH5caSO9Dp0op37Ib9eJGTPM1?=
 =?us-ascii?Q?wq9k4jYhuEMTa2q8xbmvNABGnWYOCOSScAhX6hsx22fksCk7iXDL+wTVGQGG?=
 =?us-ascii?Q?Zly68+CvtTvX8dLXcwKXfWvUolzxmP3zunlEXkJVhpcybFU63LekR+YMmaW8?=
 =?us-ascii?Q?uXDfdUWnnVavZQU9hAJf3z3NmolpWOSoA/ZXqmqfza6u7QPn2wVSxGb9+iwp?=
 =?us-ascii?Q?5iqECeTxlvyzjQXnya2/XzI1vdapJmobuUTBmrXRQhJgnZ9hnQ9QhvNJURtU?=
 =?us-ascii?Q?3j5TNKGEx15eemn5L/WJ/Gsfh7jHXtJycTw+CR/4LumoZnOgHRGRFRBwIbX4?=
 =?us-ascii?Q?xO4gti166Z1Kdx0KcPYRqfJjC0t/e4SHHlCrJninz31Jlz4k4cHBZryYr3zk?=
 =?us-ascii?Q?MK6K9xV3g2AekzrYV01+Vc90LAwbD37PfHFMQpOwTTCJYl3dIUDmnHeEVmhk?=
 =?us-ascii?Q?cfKOuM2qupaU6RNK5oJyd/qw+LPv/YTUXnKwqaRXNJdgLKPfLptauOmy8oAD?=
 =?us-ascii?Q?t3bjI3jKrLz9EETSUwBDJVdlE+HLDnzZiq31uFtYiBLw+5GqovXXOj6D/1cL?=
 =?us-ascii?Q?d2LaLaJ6Y1bqexmSxGNhyQIoQ3p+IsR6hRALBg3rVtib+7BETEJgO+QQvLQ7?=
 =?us-ascii?Q?s996LkNXV9MpAABjKKX0yBua5K1TpCbiYMs2R9K3aIEWcJnQaWP+ppwKfGoQ?=
 =?us-ascii?Q?WqfQtjCH2rr7ePDQh70C3PI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F1D82DA3D25A834CB2EB02F1983C1B78@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zOr878Qj3oCnCy602mtgh59Z6al9xqbYZZJZjEg7BBKo1cvBLOG02n447aMBazlRUbISRUUCfW7Cw4rd3w+AFmlvrfCzQaLJrs+cC1iRf+3X/4lbDRKLJ+nrl8wt/fjEBKmVjCJiaOhqF4/G8ynV7FPnOC0A81Fpw9L5WLMMTUl3uI1p7f0/zyLs9HJ2bCT0dDUYuhG06EqWRyvIPYc55bgBHjQc6MlEs+BpM1R6k+3MzFZCE84Bhj3M6aY+sgWhgns17UrmqPTiGxsLcORO35zDing1v6TW+giEOCun2TsNBmcVA0sxXtJ8k7jK6QEtlDOrX5Ei6RKFDUv0/cU097mJGq8034KVJ/aPjHQcXJJorJJ0jQypJEwvVVa6O/ec5uTLbNmZI0aTRRS5LN/KOzv97/2No/1p2+IB6GrHtbKBAhfSIs2ZIbjN6eGiXEwSSb+Vf5JFq/nGWsGdc5RfsVF6EX9ViX/wgQgPvGN5sLU2Qq92KSp4Q8AFhGp6Iqwtk+sG5Ojwk8WYkJaEe/DoIg46CFusxV6DaYStmgWDxAnD0tKoxQGyWZ6zfD2+mgcof764LWOZLSkPGjteRXD1u4cepafIaWRa5qlQTn5hAsljAWUIAFLCeqiknfYVSTzU
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b4e755-c9b5-4e12-10ae-08dcc2a1e40a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2024 11:59:35.0959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /sx0d69aYHTB2AFeJ8s5Ur/91HxXQ+sd4DXCobujkK9vF4O0n0PfgNkiTb4afdH8F52kVyxEgzgIlXn8yoav7N7JAXgjHwyXNpkX+E/VshI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7249
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_045939_586109_D1C3D735 
X-CRM114-Status: GOOD (  20.50  )
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

On Aug 22, 2024 / 16:45, Nilay Shroff wrote:
>=20
>=20
> On 8/22/24 14:03, Shinichiro Kawasaki wrote:
> > On Aug 21, 2024 / 14:58, Nilay Shroff wrote:
[...]
> >> Another point: I think, we may always suppress error from _find_nvme_n=
s() irrespective
> >> of it's being called while "creating" or "removing" the namespace assu=
ming we always=20
> >> check the return status of nvme_wait_for_ns() in the main loop. So ide=
ally we shall=20
> >> invoke _find_nvme_ns() from nvme_wait_for_ns() as below:
> >>
> >> ns=3D$(_find_nvme_ns "${uuid}" 2>/dev/null)
> >=20
> > It doesn't sound correct to suppress the _find_nvme_ns errors always. W=
e found
> > the issue since _find_nvme_ns reported the error at after _create_nvmet=
_ns()
> > call. If we suppress it, I can not be confident that this fix avoids th=
e error.
> >
> Agreed, however my thought was that if we always(while creating as well a=
s deleting namespace)=20
> validate the return value from nvme_wait_for_ns() in the main loop then w=
e should be OK and=20
> we may not need to worry about any error generated from the _find_nvme_ns=
(). The return=20
> status from nvme_wait_for_ns() is good enough for main loop to proceed fu=
rther or bail out.
> Having said that, it's debatable as what you pointed out is also valid. T=
he only thing which=20
> looks odd to me is that we have to suppress the error from _find_nvme_ns(=
) for one case but=20
> not for the other.

I can agree with this point: it is odd to suppress errors only for the name=
space
removal case. I did so to catch other potential errors that _find_nvme_ns()=
 may
return in the future for the namespace creation case. But still this way mi=
sses
other potential errors for the namespace removal case. Maybe I was overthin=
king.
Let's simplify the test with just doing

   ns=3D$(_find_nvme_ns "${uuid}" 2>/dev/null)

as you suggest. Still the test case can detect the kernel regression, and I
think it's good enough. Will reflect this to v2.=

