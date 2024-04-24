Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99155C4345F
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Apr 2024 08:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dVCxbh4anJoFVUwVDP1auXfQkKmEa1MZGAJJqFZuoAE=; b=mzcM4rw5QQioseBMvwKLvziMYK
	l6v5x+1ahyVUEvN9xtQ+FtABz7R77Rvpb0vjKTpC39yjBH6fIlBNIp9u9WHftWT0EDGu9zEyYSC/v
	jvW2rGLbmNroTiQ/Om5MvAnpdoitJyqsMCu5Xw72Pkwm2F2ah3d6HB2xxIgZRH9MmN0UuPJg+A6i0
	UF8V+CCDBOihHxf2at+D8ZhGXHt09Ccv9u8WyLzGVDpxeIt1hUMXnkhpQvQbAihMX2bylpBj315Mt
	MZmHHfrb1LH0v9qDAqU7EKSXhIn//5UhqewLf9caKMFvCLj/S78439hi58MdKO6wkkSTpWzg9m5tR
	15ol9CuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzYPM-00000003Myt-2mH4;
	Wed, 24 Apr 2024 08:55:16 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzYPJ-00000003MyJ-3vG7
	for linux-nvme@lists.infradead.org;
	Wed, 24 Apr 2024 08:55:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713948913; x=1745484913;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6g12SaQJp5s2kAAb+x/e+LTa4IuFE5WI8MqGq3A5vMY=;
  b=OLkX1SzSxcIDInO8TZZDb12rzMO8KysHSckNaJOhFl4btGBukWoYNN7q
   Cc+vp5mT61Nd23GBg5g7nDIHWO52KvJFgCYBd5VZct2OIUf0ysDUDclaj
   Xvbup+RGuakklv6LyAtGZCo7xs81OXn7G07CY/FGOm8mV9Zl1fUwaVvrI
   MbXxKzlTvAdXehgEbirhttGFI6POlIwBX8hTBXtiXNRZE06uEAoPdU3ME
   mih5NPLONKDWNfNf/SlRegnPKvKYA9b9JUxV1YdRbaA6k67oxIv4A2KF6
   9plXEP6QAneqrDmyklSiDa1A8cFjvW/NVB+HkfunlfNm6XbjBo6PlLqJ/
   Q==;
X-CSE-ConnectionGUID: MwWGskEtQZGJ8HfBGXkQGg==
X-CSE-MsgGUID: Som7fEE/QNWtOLl0nppC8A==
X-IronPort-AV: E=Sophos;i="6.07,225,1708358400"; 
   d="scan'208";a="14733442"
Received: from mail-bn8nam11lp2171.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.171])
  by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2024 16:55:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OyFkof7hZS1nXtre8PSAtybh15pP7rK7aJFPsOAx6ryPRwiJIIKMmGEMRZOsUlLtiiTZ5eWY3u02gjP5RAhRxc1xwzSdsePXU96lgeaFGiiqoT1BoXoNovNGWx8CnhQwWaU2oJFPxwYet0ZtDCGQ2wxStPIh6nrvcpiGwv/L34F31ITsB/V8zJnb6j4QkVtFixjxl+6XEJnL0qqZd02hlSWPS+46H0DREBUcGh3MF8IwuYd5CQWIHPGnPWrG+RPkygDxm1AW8PP+dKrIVKN0Sepbug4M+tuppd7k3ctAptTx7cOzwNrvhXkzBlrfD8xv9yFK3W6jMh7Hd4igmDaq7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVCxbh4anJoFVUwVDP1auXfQkKmEa1MZGAJJqFZuoAE=;
 b=PTw/yClDtDxWdcWUfSQW5MZOros/90OIkRFX7DqRi9IxiDhHnCkge03NE/F2CebRglGChqegPTT7Zc/SsSABtORK5zY54/p/5h8Gy7/hvyIM8RyTzEKlGUsQrSAiPr5fwUG3zCC6X0MwYNovxiYGQX18fMjcsJ69ogX3F8PA4oTZIKoJIxbp0DbLlbqKpZgZXwmXHvsqdCX7ePEkoeBl94wfNfbh5nonGGATwqcu2ha+paz/F+6EhkDB1odyzbLJ3UbXEAzm61Qo0BxHW7kRyUxQUvE+Uz2SoUloyjzYs41uJItWfVF8DOmy3a763NnJgZAwbpcLHttiv2Y5uSo5Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVCxbh4anJoFVUwVDP1auXfQkKmEa1MZGAJJqFZuoAE=;
 b=DmjC9pVY/pu0Duq+Rcd7lDxSr6xqn+Lz5RKU2pu4QdFboQuTZkmkIKp7OQLBih7TenLHYgX62FP6goCRmkxPziES9HLPwgz4kJzAOoWDq3Wf47beDxiHGzvRM86m/MeoS3VuSvkjtRM0YnzKrfJH2k+QzItY73vwOmFN2jQZpYU=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH7PR04MB8707.namprd04.prod.outlook.com (2603:10b6:510:24f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:55:07 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f%3]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 08:55:07 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: Daniel Wagner <dwagner@suse.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests 05/11] nvme/rc: introduce NVMET_TR_TYPES
Thread-Topic: [PATCH blktests 05/11] nvme/rc: introduce NVMET_TR_TYPES
Thread-Index: AQHaj73aHKCgSe6kfEa5k1xtmLrU0rFqskAAgABjLoCAACb7AIAAaPCAgABV+gCAAZQGAIAABouAgAAL9YCACYjfAA==
Date: Wed, 24 Apr 2024 08:55:07 +0000
Message-ID: <nx42wgmw3q5ricaycd23w27nmsoqlidzalq6sauflf7skeconx@ndpbhr4jtebx>
References: <20240411111228.2290407-6-shinichiro.kawasaki@wdc.com>
 <7okerxv2q5k6d2jl4ehdvido37rmycxopqalkt3xcouxeuxxe7@q73je25fv33y>
 <x5xlzl6g3riybq4uuoznt47yp2ieixtltq2sw7w5uodpcosln5@pmx2vne4qgjq>
 <fact36d4ueuna534ktaafuel4uqkexmlkrwasky6ytvpmi33bq@x26qccgbqbnw>
 <b159e306-2b08-4880-96c0-2ff7d5c3023e@nvidia.com>
 <epbj4opovczrfrs3o3mdodjs2dtekl4jsxgbwhtnqhq5bjhjnl@54b5mo6wixsk>
 <extncf2en5xoiov5mhnaglwd33nmffx2u2mw3zlnrxuty3zurx@nij7avtahebv>
 <f4b9ca90-3d8e-4782-a54b-b83c01316d29@nvidia.com>
 <ar2nwyps3zu2vf3zjw322nfxhua67rh5tdyqfsj6cymvia3zjc@y42szgq6ikvc>
 <6ec99060-34b3-4394-a47f-3893f5ceed0c@nvidia.com>
In-Reply-To: <6ec99060-34b3-4394-a47f-3893f5ceed0c@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH7PR04MB8707:EE_
x-ms-office365-filtering-correlation-id: 053c72fd-5f12-4d19-ccb1-08dc643c3db0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?VxcO2cL4iPf/9YRU21Mlc9ACG0JMeMYmIu/Ww9PHiPEaI4CXvetd8iiSNNia?=
 =?us-ascii?Q?uVg9glI7eItDh/b1svO5MdlPEgxGWSmVLNWpy6LajNaswu5dMmfLHTgeb8ZB?=
 =?us-ascii?Q?lJfbTGz1NSci2xWs95keZv1j2x04Q9TUsFbtpNSwz/dbgCGk2VP+jhNb4NFw?=
 =?us-ascii?Q?kQO3QOFsTA+px6+unzgbOlNudDHRbwozNTN7HYID8+9znleFgdMpUxx3EWDY?=
 =?us-ascii?Q?teVxXpGGgBeyap0xBbKKa/qTG5I6w28D+6+T4ExVvArAmYP8JtnAqlhpa3TY?=
 =?us-ascii?Q?NW6nXxH3P/uA3TXGlBx1axzTtwyEKU9iRTyB4jdDPHrrF2nM6Nbk1ss2rR08?=
 =?us-ascii?Q?abzGn9YLDInATRXpnukXKU5817MCik7Rs3k/L9Bfi4Z9ZdukaI6Jli2H1pww?=
 =?us-ascii?Q?qLJEYVAmPDarNVU4OPrI59aLaNIRKrWs7Z7BptF1N+pYDtx8ORUGIg4kSj7K?=
 =?us-ascii?Q?GL6RGLrX07pEV2LTcPTLf1nsbBIGo1BqfYExRVDtTKI024GKg+4ZEo/nCTDg?=
 =?us-ascii?Q?SJFYWOvWt53ku7itQYepCb5VZ4F+mj4SNIaUWNdwWgcqIGAyd/Kzhb+cbSpS?=
 =?us-ascii?Q?IvqgdCtdnYtMR4iUQmOmDs2tOCnLf+pXkhHbZPq9Ls94x1SebkAB9b6cbELy?=
 =?us-ascii?Q?WR+lV6rSxqphxCz5hwmf6sTKYUPM3RkRDimEvol6741T4lmWh+/0Lbbq9aGI?=
 =?us-ascii?Q?Fzy6/fNNSPHbYGQ/Vbc0rpmfHYyVWzQ50YwWuC+lQ15NltU2CVmJWRLC6eoT?=
 =?us-ascii?Q?8FAkRWkUaRLG1xQMjtIUa5XXu8L20a+DgPGwKx1ecuoLN/rWS7UJ74q25q1s?=
 =?us-ascii?Q?X9B6YsgCNRRiapAy6JIQ10O/6/cY4+oPTeB/9cTrJ3V4oqDbENdx/LDpk2vE?=
 =?us-ascii?Q?QcDLI+FH5kX7OV9yh0HReRRiEGeMB/SLoxhdQ+gRVz1Kxae5U83WIsrkVrr6?=
 =?us-ascii?Q?9Of/n97G/dIkD17uKpfrkumm9iPPGkpF8AAOvfurJwD7U16GERdn5Rb84lvd?=
 =?us-ascii?Q?H+ZObSDkm48ExBLXKKO1y3VnMP4ON/Cd52hOOlrdhC5FtMjVDZksF/wpfAK+?=
 =?us-ascii?Q?4mXitP+K8gBCl2OPuvVtzy9cSmJwOmt8rp5BgkEJaijeCgZ/Bpbhua7nE84H?=
 =?us-ascii?Q?IUC18kCXWhA6OvH2Kfp4YPz0gGz+nK+/+LtqlLBIg4XWN3VJJd05XLY2Jb+h?=
 =?us-ascii?Q?5mX7RO4Oq+RMDigIc8oqWQWxY0iRtVO+J+Gv1cmSJQAVQ/LCmutsnNbAXo3N?=
 =?us-ascii?Q?ImRp6VIcQkbIXTZwAC3SOJ6CydNyCJkhezHCbncFlcC6OVwPnVPwsvLH26rp?=
 =?us-ascii?Q?lv8RlEo+I8A7j+VWbepBx82uc98BrZ35o9pEkYcCPrJ00Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h62SJgP/+N/g/lGEXhkETmGauH2pccI7nnlEw6QWsyQsemdA9rm5eAOb0uqU?=
 =?us-ascii?Q?pgmbBPdxRt6lTO+cKS4TP8JM+DyihL6Dj5gByuqiJy6qeQ87lv+reC4UCnzG?=
 =?us-ascii?Q?b1FdBhecLNerNv9e+SNxDR+fK6TIvxdIUGLR4YmbFcXr10WRYUGdo7yAax6f?=
 =?us-ascii?Q?Lpcw+E6XYgUSIev2SVA7BakzUIKJTQAiHmqnr6jE8ec982aUWLE7tr4TUzBo?=
 =?us-ascii?Q?z3HU/JuWHn75AfeSkrwblxLHe9CmwsVQOCw9nxHSiJFSaQwm7+mcP0yBiplo?=
 =?us-ascii?Q?yVzLK8rAuC/tzDhOUb/hpmwox33RotBhTUD9xwASKo5QWCAkt228Wo3BfRjg?=
 =?us-ascii?Q?ZWUlvuQYmh9q/w2/ojppgXhAqixi7Px6qfnOc6TcOYoqDSpZBYbiUCQFFJEP?=
 =?us-ascii?Q?6r+efvHF+n4w1eL6yqqWBhUH6SWlTC66su8BRakCEPpLrSdDHBK1Y2nvb6JX?=
 =?us-ascii?Q?5BGElnz5fd8JlObyyZvcIOFq6D50H4poFlAi1ovx91Fq/SxB51aN9t5BWO5+?=
 =?us-ascii?Q?7txbD/RuvFbidtLgK6MGq5ipKX0TOnNLtF8h8iCOIiFnnf032wasd2GhGhhV?=
 =?us-ascii?Q?SdKHli+Lncb3w9o63JmCEU9q5AKGyuFiKVtVv7EK/kVcJqvMa38Jd/8OiS9o?=
 =?us-ascii?Q?tPyLHgro4uKpWO+wFMc2x6IlKG4zlqRcBSwNbFRWm7H0jd+UoyMxOwnfvRpd?=
 =?us-ascii?Q?y2WCaHn8MOo2VA/EK23su5HZbD4WKpP748bQK8mtyEjyX8uI2+tMlRPtdPNr?=
 =?us-ascii?Q?NdKqlFmf+N7m/yuA2ruFx7+WKAuVkvL4Dnidw4FpiSFUMCl9YUUXPeTKuc7o?=
 =?us-ascii?Q?QimwucHMaEdvIvxor353J0MrVD61UcZnBHhdLwrTVHbd+TSOt0bXrMr8qFEi?=
 =?us-ascii?Q?CtAlrDkiFbLscl63oN6V/O3Kf8R8/jStbR6l5Hhn3u6dbyyNzxzE+HLtgmSL?=
 =?us-ascii?Q?9rEiV+hfGxA4bEkXthc7QyeFvkeu9loalxBD1dzn9WW491dKQ00/RynTQ1PC?=
 =?us-ascii?Q?zM8ngASvXr1YSFRJD0jOaytIRLuo6VLvmfmEZmvdz+VLOSgrDYW2cmdYT77M?=
 =?us-ascii?Q?dGCK7Ub7AT2GfMdQBZw9kWvH3Ph5IRIz3D2CA4WoyZsPJGkQs9WLFy4XYI3D?=
 =?us-ascii?Q?0UfL9KuuasfR3FoIrpiDs821InzYuRxYAKchzo/jL98uCB+WtJYKjDP+rsBQ?=
 =?us-ascii?Q?omJDMaMNArxLeyEN14nbOpGhoi98nvbONmTcab9mb8itmqbVkDuulll3FVGm?=
 =?us-ascii?Q?i3ZX4FNCn6osAq+VwGkEhBJZI7DCysRkcxBH34UV6sRKSDFQlX/d0GS8m2Df?=
 =?us-ascii?Q?ApP0UDixZebmV6alo+J4/f06i1OYKwheDFgESVYieUHqYMd133hIOch/K/9Q?=
 =?us-ascii?Q?Y/ssRKkyAhyR9H1rJYYqh9K6JxLqDnUhjILaRYBQohbfB737kFHGteoInqqP?=
 =?us-ascii?Q?r7wavogF/FFf9ZRSdPyRdr9TMxnJOP7Xa7SB9cuO3mP5v5+AEWvCj8dcF7Kv?=
 =?us-ascii?Q?v34D7I2NRxKYme38H+JYU1l3lBQ3WQSeE0Pp4x+hpefl2/bSPpYBrHZgN1AV?=
 =?us-ascii?Q?7o5NF6EmVnZrC5Hu9yWsIPxtNLWttKPCXogbi697nwWV2hMTU1uaQxUVzUcL?=
 =?us-ascii?Q?1TcVEtT/PSrK5OcjhorcHjE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DF92A56BE829A24EBED4781D184AFAEE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ca4iLc99Do+dYvGV9B69uJRoeOP38Zld8cvGgutbKYTda8bxjL4c18w1P51eKeUrutnJncHvwgL9755aK/OijKdzxiFhfT4Kr4n/eXhNT9cOU95wr2KoF72jLC58QFoIjuU9ELwrCMtWdewrWaAQVXfGinhy9vKpW2S5aMKH8VDjjj1ncP/9VIUIDqbujKVcE9bq1GZ1RFN7JIFgQvrB70t7+EpBoEa8Tu/rocOaSn9NvkBrEU0zVAEaTfiwoNyzue90rUpHQFnyl3zUa0PM3c4dsMKrUjko4WYzVFyfoBwU+EenhQJ/2gKXNc91nkHgr8/n1ZP6qME1k346AkkBeGlnovEjN0QsD8SVnB6HsoiIHhQwspuJz1AYrEVTNmIrAI1KPv2leUYqmvP6hDTLT8b4qWlnA9GSd/IcQLZ/yyG8aY6SS20n+i+faxrtux3FnRRID0HyOB5LkxmCbSAgvBWwmucJKWlXlYN2grqio/DpZAFN48fqU92y9278wPorLFLe8BkO4DygLC7vs51FWW5ihceRLyt4m40+4UXwEgLnpBe+RAU1R/QLqwiLUJieF8Aj5jU0zYXZ1DoeGPLBNMgswWnGmd2uGBc8YjUT2h1SXDepDsYBItpqvhEe7IwQ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 053c72fd-5f12-4d19-ccb1-08dc643c3db0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 08:55:07.5015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6iwEGx3+Z90l3BW2pZfhnGpcRowB7Bx549L+zv+SxFn/ObSxIQHR5y2vRFw8BJClEQ+CDg1H588f2uB7pHrkgShGlj89qteYhHWd9V1/Q1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8707
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_015514_082343_68E1C8C3 
X-CRM114-Status: GOOD (  18.41  )
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

On Apr 18, 2024 / 07:18, Chaitanya Kulkarni wrote:
> On 4/17/24 23:36, Daniel Wagner wrote:
> > On Thu, Apr 18, 2024 at 06:12:40AM +0000, Chaitanya Kulkarni wrote:
> >> agree they should be uppercase not denying that, the only reason I
> >> asked since existing variables are lowercase, it'd be very confusing
> >> to have some variables in nvme category with lower case and some
> >> upper case ...
> > Same here, so let's fix this and add upper case versions of the existin=
g
> > variables incl documentation. I suggest we keep the lower case ones
> > around for awhile (maybe incl a warning?) before we drop the support.
> >
> > What do you think?
>=20
> that should work but let's be very careful about removing lowercase
> options since it might break bunch of setups ....

I agree with this approach. I've just sent out v3 to which I added the patc=
hes
to introduce the uppercase options below:

  nvme_img_size -> NVME_IMG_SIZE
  nvme_num_iter -> NVME_NUM_ITER
  use_rxe -> USE_RXE

Both uppercase and lowercase options will work, but it is guided to use the
uppercase option.=

