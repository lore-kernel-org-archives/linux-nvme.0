Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D7BD6EC00
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Nov 2024 11:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=to95nSPfWdAnGy7vZbPvYMprUeO2R5o0gWC+t52B8qM=; b=tUw9iIyTTKh6bCtIgXQp+aVU82
	A1pcEXKQ315K3R1PW0ti0BoPPdk7rajCLC59dqXTB92YLj5KJeAZd3OGHtMqKo1H8+/HcJjZ/10dB
	pzyXseILb0UcyBuCV7u5rnAOs53N/KCbuJEDB1n9UxM0JsVolyfDmboN0HJ0LpFgTdJ1DextSd0Uo
	dWiatoBhwLnUKu3Oi4DUwMcGmiF6Z+ayECQAyqaHIAGorvaDuj+bxVQl/yBA0IqvDS3Bzs304Rvpq
	dgkRg1kYrmiV6P65rwJW5PUwqIoGwsJ22jSYf5PlaQqWkK47ANnfSROzj8WQJKlhx2SpkiCyjmHgo
	WxkG0+4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGzSx-0000000Hatf-0fcG;
	Fri, 29 Nov 2024 11:47:19 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGzSu-0000000Has5-3KNw
	for linux-nvme@lists.infradead.org;
	Fri, 29 Nov 2024 11:47:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1732880837; x=1764416837;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=to95nSPfWdAnGy7vZbPvYMprUeO2R5o0gWC+t52B8qM=;
  b=p5bqEWjXN39xV3h3ZDhGWoxwkGN8TVEYzd8ZKXgYV/0UqM+xDnaUOZeT
   BIJ/n3tiTGCBP0XE7O2eX5xtz/y6PRwaO8RKNp0WU8k6C2DH2S2v5V0pD
   JeFnr8XVBUxHFM4Z+y/PdYrVxalDm0xB8xQ0Vpfl4YEpyFOqoUa+i2UAr
   ipjvcZIMDHpvCVlV3PFWt/3qsZ6AGGbYntE2J7vJ2aRWhcb2obAwBB3jI
   E23SWt5iUNlDqWdQZ7LgNhCL8SIMKlcT5NeoI2w4SqzqRV1P9ANV5UrK4
   nOy+s1758UZVbPCukkNev+D5HP/ARu7JsfKVxQKRiiQZB0i8ws2cF/MG0
   w==;
X-CSE-ConnectionGUID: HuPE8eW8Ql6C2wYBlI1oOw==
X-CSE-MsgGUID: rBjdD69LQRy1KYthmBh0zA==
X-IronPort-AV: E=Sophos;i="6.12,195,1728921600"; 
   d="scan'208";a="32720919"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2024 19:47:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aIvAx/YZzFXYGJ7SxL/L6UHlNCCOufcXI1KRlls3Oa3GMIzQ6palQiO74/QBjeMdhmm6wG5QDjXrMeHL4a/1haSg8K0SGnp905qqa/4AQHZX1cLKYGfQQTVChQubF6benATup5BwmzMqCUmc4cg2FgM5U5/cohnMxasekYirP/TzS+vSmV21yi6Y0cvN5eZ1CUNOjQQeMfdJVAzABEGpp9mxt8E7F3JelUC5d48iyes0xO9vNwmKZ4MYl397gRdpnVoTA+uDWTd8Q/v5C9Vq6EzCJudTPMc5DKznaekUeOoLtE+uje93dfoy1JQtGsLMTKsIpioe1Z4Hhyr21E21iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=to95nSPfWdAnGy7vZbPvYMprUeO2R5o0gWC+t52B8qM=;
 b=galUZFzNERneh2O9dDc+8gQqHymhC4CbSMOKLNVW52qbIs1e4T0+a2ZOaxYXNRlg8ricB+trU2o0dUAXJ23KEZkbNZL2EqiuoJ4mvGGqNpj9K8ZxJnpLfvYZR8kKslmqEwrKIDfluahcqhVxKbF39bKbwf1Tph77w9EzGQC/iebxzmXlJ/ZXV8Jvsy1wrkXTGsgyNC3dIvja5hI0hoB4kfNuU5oIpz9RhqJE/gDN63njxhJIf3caIn9BirGzi0H7bbM7eq8WEOtTd2Q+rnq8lmHD70TD9KlEHcNpw/fdWCGCmFBbLg8/si3kVtgX8efPveU0vCy3EULfcYc2cgkMdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=to95nSPfWdAnGy7vZbPvYMprUeO2R5o0gWC+t52B8qM=;
 b=wxWdgeGnamscNGv5Y5my4396caqBz/KPFCn/kp7azkbYUsOyuaAGORS0gM0VSwZtMkFRTXlzaQjH1f7RMIpCZW51RwSSm5WiWznITSBoaCVrF7PZqA/+FTfQtl6X+l3ZOGe1bt1Wj9ZNPzC7S7aaRWRwHY/u2uJUU13X7viXgIQ=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MN2PR04MB6816.namprd04.prod.outlook.com (2603:10b6:208:1e3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Fri, 29 Nov
 2024 11:47:08 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8207.014; Fri, 29 Nov 2024
 11:47:07 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Aurelien Aptel <aaptel@nvidia.com>, Nilay Shroff <nilay@linux.ibm.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: blktests nvme/055 test case number conflict
Thread-Topic: blktests nvme/055 test case number conflict
Thread-Index: AQHbQlRqxE8FxGKHkUCff6naZBTYnw==
Date: Fri, 29 Nov 2024 11:47:07 +0000
Message-ID: <eqdndvtxup6mujwo3c24c3f6ctbtpz7gvkis4njk6a5iymoyoo@xfoc5cqgxh6v>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MN2PR04MB6816:EE_
x-ms-office365-filtering-correlation-id: 816326c5-b209-4b70-2b5b-08dd106b8d72
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?eSnPRgh+rvMmJk6pFoqkaFukNpjnToecq4JqgtxP80KLPugZWKd2YmUa0pix?=
 =?us-ascii?Q?1UUcFAmJeqqrzlJ402GsXRbUNxcKbAp5T4BGdryQY6wUPhVAAV9MWdjKPLre?=
 =?us-ascii?Q?RgdhR2MDC0owQ9nTHd8MJdHssb4macrd5XBp+CS482Z3MKMeYerlhh5f8/ZX?=
 =?us-ascii?Q?9L0MInqrcKcanjGhxotrE+BTy29C1bKm6ldxy97E1DqWcSgnSMfFAnTuEOvI?=
 =?us-ascii?Q?RTvl2bNQ0DefkTP98SOzHi2jvtgB5AAvauX1dtvLx9ebi47+5ylAidajkzrZ?=
 =?us-ascii?Q?lj+OOBW5ynqPNxvdNNmbfyDjqXK5/UuxNzw6k6y4p/Gp8Wp/j+8b3WCengRd?=
 =?us-ascii?Q?5kivojMhez+/zzWDdHrEuo1VptVLw/UHaqlEyndN89aRVW066JGo97k4F40e?=
 =?us-ascii?Q?eja8PpTgWMBW3P6F2zQUjsjhGcdgVH9skK4FwAix/TEtD6jdGPVWRDLxgWgU?=
 =?us-ascii?Q?5FxGLWKCWyFIrF8KrP3oA1rI73PCFp/j2Y+PLsXEUrIqaVhmaPzImf6YadLX?=
 =?us-ascii?Q?6K/JPL44KJPLe2eVQV6jcJhojdaaSk6Wd7YmvaJBgoVv8bo+BD9dsV6/3t32?=
 =?us-ascii?Q?9R7jtr8NNB2l+LB+k6B3QIjjeLIZSJ14jvOc2SyAQ31mueEF7HtOp3wNzzj1?=
 =?us-ascii?Q?ciwhj6uKxXJ4JuVOBoqDL6h8Eo/BY7yMT/nQm2nJwPNsEkQYz94pqqMWBA1c?=
 =?us-ascii?Q?Ks42JYVkC5TXHIiJzKIGpUgh11cs8Hw0/CwSABM2laq4Qs5/Cp1KXQj621/x?=
 =?us-ascii?Q?OIzzx8B1WO++VPZ+gy1uqp7AiJxVZi6nHFHjsLb1YTxaKT9XcZ39iQwXhW0b?=
 =?us-ascii?Q?YOUlIlmfRBVaPVxXcjz7MuLJ3qwMWwwIkX92eEZpjeK7uWUpIDGNxkFrKvU9?=
 =?us-ascii?Q?OqoTN5pamadIqb56a5zTuoavW7I4i0JJBttmICBt2mnpWviC2IsxfVVgHhBy?=
 =?us-ascii?Q?L8tWIvkeUlS/US7kXnW146CUg8HATW31p8NE3LD3XjFu8L65CsqPifxeb3qJ?=
 =?us-ascii?Q?OEblElrQDnfsbeTT4X/i99bp8lRQdPSihwHEhh0Uhrm1Z2soCoiNqPTkwW97?=
 =?us-ascii?Q?ItdrIcigBmDY7xtyAH7UTJcDJZy74bEEd312koDed/htw2YJqfax22blDThA?=
 =?us-ascii?Q?4IUaEX7GEU2H9cDH6j8SBfDjsAJZVKamp9Z6QfDnWclPCv8nMgVEb7cwAp/K?=
 =?us-ascii?Q?OCuC6qq9cJh/bguwF2JWzgE3sPQSokKr7VnqJ+HuPy8KIBaarFVwbT5VV9vi?=
 =?us-ascii?Q?yT1B/DBimiwQL+SjEwdrWlN7W0Nk4p/IkKdNJAyKOZ4aNmlKGWbmQ2uKOFiD?=
 =?us-ascii?Q?oMOYIRzAo2cHQ+AWCa39uN4hoTiukYoWOfs+j4XVt4AiHehoLxEILkIbyy9J?=
 =?us-ascii?Q?4ybstH8LbWIR8J0c/z6y/jykcgaAt0EilVGQHhJXSx31GO3MXA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tX/kgpjFvFyuMGO6jFHc1y7lSybL7YkTXnnGE2vc0A2Nqd55FateKiQe0PR+?=
 =?us-ascii?Q?iVd3cZR2e6ZWe8ealjKou7Xw5pJu39M5jbsI2lUj0ScxExCipRV4Sesb7MqZ?=
 =?us-ascii?Q?TrAMj+1UrrTKqHJvAOn3xLwyoRi0CbryMiSUw7my20RsbkWr6F9dzaASAe9F?=
 =?us-ascii?Q?9che8diw02TtSJf5r4Q2e3QfUnXsWlXZrV4Hyb4Kh5ArgUkwhFZL1fk/2KTI?=
 =?us-ascii?Q?ZqeGEctNPdszDm++ngQ9SfVjLrbb23t7ow13VHdVZoLXaE+sZnU/lCfantV+?=
 =?us-ascii?Q?1WB+K5KP3+GWSq5kxT+McLABxzenpRZo/rv0zEBNCUPwGWCB5PE44FhMmgGv?=
 =?us-ascii?Q?gMz7x8ww7JbmSXp591q2OXuBQMuAhRt5dnk/4Y/Wtsal40GZfBKLAtTkBOyn?=
 =?us-ascii?Q?w2BRYCaLYL3tiFZHx2JaZ0e/QQ+Jk04GjQvUHWs/hugKcp0FH+ke9YY2GqSq?=
 =?us-ascii?Q?U0rIH6PnIEZrA1Y2DcD5gUkahZL6cLsNMZ/LCBXN7vHn5y9OVkr9OVBNJpS6?=
 =?us-ascii?Q?sKXTMF4bbfHjt6BHjGsW1GG4awu//tzxssVhY7pSvdXyOJP69oBqEjB6z3u1?=
 =?us-ascii?Q?hJKwZYIe/laLMXmnhGQgeB35bxWOFOAwJuqZvUFv1QlxVZFDYTZmuOdxVMdK?=
 =?us-ascii?Q?oiVJk4jz+bZbCA/9wrOZwm9k2WUd/RjzrIpsNO2ehKirYSDIimReEzrAQtJd?=
 =?us-ascii?Q?isl1OYNM8F8uT6isuTADHZfFPliYKZtBZFNTn2EFou1uZ6nDtn71RMlycPi1?=
 =?us-ascii?Q?DCpmysT0tPp4Ix0LRAzSakZSOKpRDg0BW4qpEa0lxAeli8D5rx7Bd9RPjAER?=
 =?us-ascii?Q?tE4GxkORzdfrXEkrg08CEljUiGdiONSchRycyeerLWU+OAd+9OQcEmQVEkq0?=
 =?us-ascii?Q?tw2JKlW+EI1cjwDmf5IpaMfMQbazQbWGNky8hNYVtmXTjR75Gyv29R94bgz3?=
 =?us-ascii?Q?QWBjLZp844F5D7SUrg96ZJlPNS2damWCLddKlfuChBY3SPy1o9FY+JGj4I3Y?=
 =?us-ascii?Q?l8jIRfEJQLgSYRWiK9lUldXpaR+MEFcPYh7qo7VeddxHeckiW+eYU1yOCQu6?=
 =?us-ascii?Q?1fmRcfVy1C++tdfZHvjQt2tkRLqecA/YwC8kRCqadmKAOYbCSIZxaDR0GPSY?=
 =?us-ascii?Q?4KFukaiILYME30qMEWM3UmdZiknxxf4wAYjVgYF7rFGaKGZtXOAqKLBFbX5S?=
 =?us-ascii?Q?EZO0L7dXGlBmhlwC1qRIhQFU+Y0BkIPXVfEQPKrtI74BEv+644u0iiaoPRjm?=
 =?us-ascii?Q?zRpu5foTriYeUX4iHvRsM+HvZtO9ot0TfqHiyL5BHnhTIGOEWRx/bs/Sht2J?=
 =?us-ascii?Q?Dv9bAnxI6OYFPlu6a5w3sdbWMHpEmQW/rcwCW+kT5V+e0shvt0piCWSYem7O?=
 =?us-ascii?Q?hV1AtQU+OXEuZNvc9NXi+tzX1/5byHEd7MuIE/Nrhvf/9MVcWvzgvPgNxGyF?=
 =?us-ascii?Q?KtFCEc1AKbc/o7AXEPZPWEAICD/8jgSXm15eyUfpRZcVgrBFeV3Gx6d3stFR?=
 =?us-ascii?Q?IEs7IA+FgTX1AximcD24iH/68ScZDezyHIWFf+OsN92PMySx/yJebGdMcBcd?=
 =?us-ascii?Q?X2VUPWjsyF5RArMprFuVpoUmqXbMcKkGCBFY6AWRKuV1gHMpsAxkAO+1Cr4H?=
 =?us-ascii?Q?6I4xUy02BJR1Rg2TfWILjtw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <80E7AC72549EA24C8B067BE547DFD935@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: scU3SnkUCqUUehtMSgYOGgDg6p/UAaS0TOvGKGv8TiDup6q6BZE4SGBlznA+5qJcIBdrVAiUCPwyyGpYLCTI+TuxYyjQ5GDTAzsU5996JS35Lz1lA0yWx5exkQW2Mz7F9P2Qeou/W6FHZFgsWoJNHdoN2E1Oeogvj+AjzlAG7ZC1EA8GNLeufgCdhXL8uVVpwJOwmX6xY9GY/71p5XOFEemZq28MxUi8n3pUl2pG0cLlcaJxDj9Grme6Y22VTy567hYGRdSkyT8v+TtPr0VVmy1t5pdRp7AvAY56IYYeHRud6yCN8S0u/SDefaAzjUSGfT8g3zWJlbuZmtDuRX/CuBMjdfVESfwBU4ACa2iE8UMSnZv7S3eCucuMp1MywJWyADwAivfQBnNinBfwffgO9I+IwRx1OWVyYJOP7D1QPZz0QOAHoNTmcquBNtc1o5CoZeExyDik5PYnTqR6NbBKiW150pkTyYumjmCuqb3PeuL/LrlAIe51qgGp6RLXR3w0xDPjVnirzwKE04RznjwxYuFhWVMvDBSnOh30Z5hFiQW3VFDue0JD5zl0MsFOlLmUQ7u597EOP6uZUBo6B+VjdI/G7THfqWt8v2Rpgqxm+9/OQo9rhWxwN0k/wHpiO0xk
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 816326c5-b209-4b70-2b5b-08dd106b8d72
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2024 11:47:07.6564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1guTEAZKPHV0WzeQDuXoqQ6m1f6e9RMsEMFTWi64EuAsfA61sxo/I6/FvKrsui3BRIKPOMIxSZ3Hu3mqchmeZipa3gp/B2+QLae3CzDbWfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6816
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241129_034716_853617_807B5B38 
X-CRM114-Status: UNSURE (   8.62  )
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

Hello Aurelien, Nilay and Chaitanya,

Thanks for your contributions to blktests. I noticed that your recent blkte=
sts
patches all add the new test case nvme/055, and the test case number will
conflict. On top of that, I plan to post the ANA support series which will =
add
one more nvme/055.

But no worries, when the patches get ready, I will renumber your test cases=
.
Please don't be surprised if you see different number for your test cases
upstreamed.

Thanks again, it's my pleasure to see this number of contributions :)=

