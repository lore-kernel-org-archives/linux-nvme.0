Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2017C369D3
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Apr 2025 18:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3Rih/XgQA7k7xSuLqsDN83GHUT2I/6AfkusohXVktn4=; b=ZNyYljZUNcURprOEVJtRBWCCxP
	vcYhagHyNRbHp9EsylgWM2ZxoP4c71mWGufwzmp3jV+ilxFxs+O56oXmYBdyzD1HcUUPTYF+IF66x
	qQ5SuDnwdTlDki4aM2GfcA1VUB2hDUlNgXtHWu/LJk85uSWKEwgkXTrZNTpURdnIvrEoyIf0DrVBl
	eHyg4JcNJDo2EyyIP0tNtN/LOk39LPZhGcZKQQKyDW8EtD1cg4H583DZSlOy7qf2Gwq+9HFsZGwfB
	zhV9xcxiCz7s1nT44BwtNUkOcaavGEWuHyc/xjt84Q/RirRFYy5GKHsCKGZ3XsDoEenqZ1rW5l8xJ
	ki/IUuSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7edy-0000000BW2U-34sH;
	Wed, 23 Apr 2025 18:16:22 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7drr-0000000BGOP-0ID3
	for linux-nvme@lists.infradead.org;
	Wed, 23 Apr 2025 17:26:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745429199; x=1776965199;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CnmddNlx01tb3KKtqBafoMKyW4ThCK5iiX9aFGurKY8=;
  b=T/FewNELNRCU+8JtCL3xxj7kw3BWXPNMO3kEz8rsEiPavNTheyM789Bp
   Mtf8bOAT/McnuX5BFffd3iWC9mXaXUczXDRB/mEFjhy1XZq+Cs6JB/unI
   PKD0lFLtq3CKLRFcEgvZ470/jx8rmVGQtiTdI6qgrEDVVQlkzcmqKzWD+
   +ufJ4uMQCv3oqfpeaGdvGucfP4f6KXzRG0E8j0Mf+sESlL+TC4DqcH2uW
   MaN/vf+ZLNHmlTYledX270F5ve07Idr18YqYILtXBTzo0NGtVV0XXhkjC
   EAsTBjTRs3YKnr7jM+GJZ0RxZs12WGk4wMUrNcgTKelP8p5C3HfR2YZqz
   w==;
X-CSE-ConnectionGUID: um+1YALRQaGittJD0BwnzA==
X-CSE-MsgGUID: BproTL7fRUWgQ1NH1gGbBQ==
X-IronPort-AV: E=Sophos;i="6.15,233,1739808000"; 
   d="scan'208";a="79124825"
Received: from mail-southcentralusazlp17012012.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.14.12])
  by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2025 01:26:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f0pltORd7Yag3bW28Ud8D8lg+pGV5ic5UhYv60dYEaqUo98XCsbpXluUdKKn8cyE7YlHVJqcGMEjoHAUT8ZJVx4oFPYLX323F2B/WLAMj24Gl9xyuEMdUS0bsRQee1hcBiVU5+HAPH9Nl4KAiarkA2qq+ja5PkTwClRCIXU+VhtWR4TCzoZhPGoiO2QNJ+KnX3XKSPnabS9LIDYSg6OTdMtGye2SUHwJc0edJJh7dKlysq4OW0HHxEg3lTB8vj2dTP+6HzyR2Sr9wyTyGxLTNIj9/q8vjvvduU9nkloRkHVFfqaCVbDu5E5rkHIv3dCl5hkz25S2YHSVJOXqnIJwaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Rih/XgQA7k7xSuLqsDN83GHUT2I/6AfkusohXVktn4=;
 b=rnuQMRDKZVla5MLe8qk6Rocjr9r5tS/up3BNxaM757FEPnn9/70/kxwtEw6VZGeupCIb0Nix2wXtlmNHakju3LdXWOhbH8S6UUC+BQAHN1/oRvCYBIimIi4omxEbVggKPj8dakMRbSuhLzz/La8jrdGH5H+WyJiuyh0PI8PQRThIJrnNx3KifBZOCzjW5O9XA+8GOTW5Ygt6LOKPKZ6dNrt6BuBYsrGPlSDvVChqqH8cLulrmRiXkdpG0xj3oyoVUJotBzCGthiGW5gG3sPc+NHYfHHek46yXXesN/pfVvJUL1teISqwU8gm01hCGRkF9HMlcgzCgA5K2JjH9MzyZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Rih/XgQA7k7xSuLqsDN83GHUT2I/6AfkusohXVktn4=;
 b=gUijBG7ZSkRnkPpU/I/wY+z2BU3Ni3Nk2ry9SsPIuWCuazw5U0EFnVEtNw7NjS2M7MbytnwEvtOhd5AnJK36pWayvsRXgcFAdsCVQHjTp+moJG9OSYZGR2HQl11rgiT9n6UJRMur1smTCLGvThckHZ/MdqzoWvBpZuWpqYXw1nA=
Received: from BY5PR04MB6849.namprd04.prod.outlook.com (2603:10b6:a03:228::17)
 by SJ0PR04MB7792.namprd04.prod.outlook.com (2603:10b6:a03:3b8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Wed, 23 Apr
 2025 17:26:31 +0000
Received: from BY5PR04MB6849.namprd04.prod.outlook.com
 ([fe80::b2a6:2bbf:ed0a:7320]) by BY5PR04MB6849.namprd04.prod.outlook.com
 ([fe80::b2a6:2bbf:ed0a:7320%6]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 17:26:30 +0000
From: Kamaljit Singh <Kamaljit.Singh1@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, Hannes
 Reinecke <hare@kernel.org>, hch <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Chris Leech <cleech@redhat.com>
Subject: Re: [PATCH 3/3] nvme-tcp: fix I/O stalls on congested sockets
Thread-Topic: [PATCH 3/3] nvme-tcp: fix I/O stalls on congested sockets
Thread-Index: AQHbpGZdo3Xoo5WOcUmvA6U4U0rVxbOkYTuAgADyiwCAAK1uAIAA7l0AgAGfxuqAAMd3AIAB65xqgAMqEs6AAUI+AIAB7eGv
Date: Wed, 23 Apr 2025 17:26:30 +0000
Message-ID: <BY5PR04MB68490B7C73C4A4DB2A88AA6FBCBA2@BY5PR04MB6849.namprd04.prod.outlook.com>
References: <20250403065522.90807-1-hare@kernel.org>
 <20250403065522.90807-4-hare@kernel.org>
 <1edc23f5-eb48-4006-a2f4-d303b05bd3e0@suse.de>
 <e7371b8a-e0b3-4387-a941-292e1f46b2aa@grimberg.me>
 <5446ef17-d922-4467-9a3c-5001713cc260@suse.de>
 <dac1d594-cf64-41ce-8a23-4b246db75b83@grimberg.me>
 <BY5PR04MB684996C1DB38F3BC4386B55EBCBC2@BY5PR04MB6849.namprd04.prod.outlook.com>
 <ee011198-9a15-44e5-a18e-02d3844ee48b@grimberg.me>
 <BY5PR04MB6849262F5822EC7132BE7414BCBF2@BY5PR04MB6849.namprd04.prod.outlook.com>
 <cb444a0b-ecaa-4f46-8323-e5c39a8c71e7@grimberg.me>
 <BY5PR04MB68498E95C971D95BD7964F9ABCB82@BY5PR04MB6849.namprd04.prod.outlook.com>
 <2223f6b3-d1c3-41d9-8adc-78b5a50a63ab@grimberg.me>
In-Reply-To: <2223f6b3-d1c3-41d9-8adc-78b5a50a63ab@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6849:EE_|SJ0PR04MB7792:EE_
x-ms-office365-filtering-correlation-id: 7ba95eb3-9ae1-4ec0-ce32-08dd828bfc67
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?exnd9h7l2LNV58+nPpdRfVksGnkIdwqsWZAEJboVTZLSRqX2zfFGibjPtl?=
 =?iso-8859-1?Q?6rkhzG8E2XlHGBE39X+xpLVy7FTTZoyzZs8qEQ9VQBwPU9vqHevGRQanXE?=
 =?iso-8859-1?Q?8FNOSRpfad8Ca5uG5ODFt05/Zr1ynj+zPD0dY+aIdOpgUXsLE90MYbvXK+?=
 =?iso-8859-1?Q?F3VME9QDtg+1BESRF1QlsszIcA7K4o3lDhIHL7ZWUpMHl7HnG50WCO+vyp?=
 =?iso-8859-1?Q?1FSBnrL5Z2odTulsoklKvLhszSqAnbuMRECr1qyvAx2B0iY/5d3ZvRfq+e?=
 =?iso-8859-1?Q?DjqVcrLZSIYUI5CedkixqLhxUpUmkmRRfDGPg9EKWaeSuIETtPJO1gCn5f?=
 =?iso-8859-1?Q?RzCFqWjQJm9YNjnOy8dCflltr1RgOAOgQqbuaAeY0E0VBeldr/TI9+/ud3?=
 =?iso-8859-1?Q?PBNXoeT1BUGbJwsByxSWjI6g4BfnkdBQCnY7rhfT0uG7D9ZvlAXADrRUH7?=
 =?iso-8859-1?Q?8fcHhb+4U9ibvte8B3vbLju8bzdGXJ9ISjIJw+WrL5x4optdBItBREoQ/i?=
 =?iso-8859-1?Q?+MDZVGVah51njQJlp+0k0Tj1AUWZx0JTs8rQgtwvUa5rN795+8gws2Zzfo?=
 =?iso-8859-1?Q?UqGEudfEySTd5AJke98Ew3DisMtcG0xzC+tewouUt4RMPdmMvkqN6s8Ye0?=
 =?iso-8859-1?Q?C5hQymvIdX6Rz3km9iBoXlFd9f4Vft8E3NOdMo9Rn9yrj4l6EVTT+uvFMw?=
 =?iso-8859-1?Q?c5hM0iDk2CdH5ip8E8d1BNt1V4Dm6YIGL6kNaKDOZ7JV38NKnFabVbDZCz?=
 =?iso-8859-1?Q?INlB6bUvDJA9PjCIt5A+yaEqTEKq/pKRN6atqhFgBf03exzw1rsqs0GAm1?=
 =?iso-8859-1?Q?oI84kkbmB+ME0A7C5Vg8Aa19j9T/xpR2dZCkwUkwlg9Bj3YLfyV2tPRl7X?=
 =?iso-8859-1?Q?C3PiNAqr9a8AMBJm+Xetgq1+AaXxthXkj5WP7dZCGFz7ht4gGDZI1YxQ0H?=
 =?iso-8859-1?Q?CL1VVDZdmjrPT63T+r/71YTC495IuK8f4UMlIjID8tRzBK3pP96CMQojO5?=
 =?iso-8859-1?Q?wwUZEq+8JUwq28iLJTEJFBSrbCX1bqoPgrC39V+E8SoB/D7VnN6tJfCVIa?=
 =?iso-8859-1?Q?6SPCXW65wzm5jZZbt8QpibzaketdptG6cVa2og/pqwGHSnxatE/lAA0F5U?=
 =?iso-8859-1?Q?ptjhcaDrpS6pqJmyMQRxjmjdmIudSONNomTwWeCPTyyq2EjbT5W+2oCcxU?=
 =?iso-8859-1?Q?t1ahQXLFFiWZZZh8CNR7N8b+ImKpWfb0ldIhAWz8W0aRBzX4Vo4juTFatt?=
 =?iso-8859-1?Q?bitsQcA82Cj8lVsuLRNKFntQPLD5PctQy1WCf9y81VcIYxhg45BYxBpF1W?=
 =?iso-8859-1?Q?WsnZAshVL54UWIuMSr7YDfDPySf8kiRyQ9Z5CTFx1Yy/P2y1Iuxfu47+F9?=
 =?iso-8859-1?Q?+sxOJEJsg2KzTFVUduZjkOxHpGbw0pgBLeXeMYetshaBfUHqLvRMFA3x30?=
 =?iso-8859-1?Q?G/zjo4it01X2iN1EIDBTE68G4xZAvyWHYMT+Yhz10dPo2EEJ29shjeLH9h?=
 =?iso-8859-1?Q?o6e2uLT3d2atG4tGjEDVa6YLtTXS6xwEHaKGAaquJ3h1i/blA+/JOhqvl5?=
 =?iso-8859-1?Q?ZCWqGZg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6849.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cQMwZdSX0qfEyowzif49WnxKAynWmLlKVNuWyqQYrtos27yU//VFfnfPuq?=
 =?iso-8859-1?Q?HirL00flkzyy+NQ/+jbgyKa0hzR1JX4RqCvDZxr9iuKZvWKcJ+hfwhmSOv?=
 =?iso-8859-1?Q?iknYI9lWlDG8b33l7IFdbGw9MnhtwkJPvSGeWDCXZvDTGRSIFW68bxUEet?=
 =?iso-8859-1?Q?RIuLBfv9tmdvFAcHQCalsOs5NDLMBNaeM9Vw9oY53sSIE8R+Pn8p09bUdF?=
 =?iso-8859-1?Q?xEtGyYzLPvfduEXHCXljC1PELLxOqr9S1r5bWuWzUeK8Um7UYiGW6QmFMd?=
 =?iso-8859-1?Q?HWL43YDeDA+zGknoSxTtGp8dZmToAaBWteFL349eHFDdNBiK1YD9SMEkp2?=
 =?iso-8859-1?Q?sOvnJ0HQ7w6C0QDiVY0cuP3yKou7mcqxufSjVzSGcrOtBAs3UX3C/UEjR7?=
 =?iso-8859-1?Q?CPl0XWIcXV1h91sq+icjUn5gmrn1WaQc757zAINNG+dcsVvRZzH+rbGg+d?=
 =?iso-8859-1?Q?tfJ6qDVIgeStFwXhLXtU24AcZARrazPr71pi7aDFYAOM8UCQuwq5iYoUEV?=
 =?iso-8859-1?Q?Br9T8DMiXGmIXET0mQ28hztf5ubSthFpq+BVRpv/Sieh2z3RrGwfJD09ys?=
 =?iso-8859-1?Q?vHEg9DPKoyrIROVxa+XebBXhr91E/7gqPXfjBZ69q+2xqFdmEYghjppuMs?=
 =?iso-8859-1?Q?5MfTSkkPyBFw1KsC0FrFf6wjkXcfr/QDJ29WGLzM4B5ljdaqsqQMJs3JKH?=
 =?iso-8859-1?Q?LwEU03d1GjTutdP1iY2l1ARVIkIE0rJLo1iAwlLg2dLuIUPNtN+s5EglKh?=
 =?iso-8859-1?Q?+8+PcCSuOmjJNYlMfi3goEqjCr6NP7uulgzIRVPx6QtHZU2fJEt3fLUhZG?=
 =?iso-8859-1?Q?m1Oy4ggmNB2BaZpkxOwqlxO7Hy/q8Y558iJbWzWZ2I91+j3NuB0Mpljf+f?=
 =?iso-8859-1?Q?RtKiThtQGInR2ES4mAica6MFR8Wb6O9lrgKiZDZsXRoHzNtqq7RqxVlkBQ?=
 =?iso-8859-1?Q?/YHzirq63jPx0fjQS1dD4egGs2DJs15AgZEnIzgS6nEtOLraJaCFHu/MWR?=
 =?iso-8859-1?Q?u4wi3MIMB6tybfseA0nBP8SM90aQCtY/yU5PZ13fwQNEMsVqTKo6w3qdUd?=
 =?iso-8859-1?Q?pICmgivMnWDrH5QQeUvzvczp5zv1JtXag6ryZQf0J+R+cT5bHq90yBMFFN?=
 =?iso-8859-1?Q?7eRAbbjYmNPDICClHB0lggvpOx198uqetd13MWDLqWw03p9FGZV6d/1vrI?=
 =?iso-8859-1?Q?Tu0jfcORkSxR+aDVTF46NL3eMn3zxxuD5xvTrSz1viLfWnxu9O4gOo78qH?=
 =?iso-8859-1?Q?vC6oiiZc2Su7sORMMOBmkOYLO0V9UKK6hiPuHHh7mnVy6gMWgAOqiTyAtl?=
 =?iso-8859-1?Q?TjY0IPLjol7mC6CTEehnobQpTaPwlIFHFrMFqp2jZLi/SIv8+2tU+IhHJG?=
 =?iso-8859-1?Q?4QvOo+p57Y2cr4yv8rcOO5wf77eqGkNod9ars6iiXvpsAywXSUtbA7OJUV?=
 =?iso-8859-1?Q?uvM6zFsvATDzo5unQKMUj/XCN7Qrrr4P+TAuqAiV3KtcoeWatmirizvEYm?=
 =?iso-8859-1?Q?17dXvrhJita5ptiuXzBEnfF+PP5OJRX9coa5OCzkuqfXyEuElty4FbE8hC?=
 =?iso-8859-1?Q?T45DKU4zIiXxnMiisVMen/LPeiL365RMZnJZjJipOg9olFqxR4awqLYbdS?=
 =?iso-8859-1?Q?rz/sYKdCSvqOMFThMEioeewMny8vAZ2d+V?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CPtlh813kZGRDKLesmky3z2wsUGwm1srQLy43KtEvb1MMvuvC5Eh7cFQDpxrSwXi8HSNgrvVLbVDXb5vUy0abBKmIXS8X+OMgDHTgJejg5TbAZxXthodnjVngTX8SLx8ttuAY+xDNvj/gOfRlbVCKfzm1oEzmlLcSVcQT8LDNCU1bjL9D6kHwr0cgLhxUwHH5xrQKRictIf0j+xwprFFKgsXreTq6CvGB70T8SqIeqfZEVULZOdO4cUvOCuZKtQXr+OD4vd9/nNwpZb+WuD2L7kWHNrnn/17sp32e3EQkAcPqAkvPRE8rxGuqNjOoNGVg4E5B5i8YujMuXtdThyPtLDxCgejbSdLWm3L+xaooYtTMCluW9j7jADn9WwEcrbimHG0rZ+1ea6ks0oMdgpLEZ5+sK4pAghcoxYMTeIhn+9QwrNkLwjM9ovfaRnRPj8mXSWT90gk80tDcIKFzhfKo/7BSKjddSRnpsKV/xFnKQSffhT4wKZuxH6a0T3RGCRLteEP/g3pDZ/zNhhvbpD15/VkGsDcLwOV1keGnYSaxhW9QWKkcnMq4LhGvavLTqrl2zrm/T3wWTn9OULEw5Imd4SQdvE1VxaA8j7aEfh64Mn2dNsSQ3frzHXDojO0r5Qn
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6849.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba95eb3-9ae1-4ec0-ce32-08dd828bfc67
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 17:26:30.2630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 438ywXTWufjDQxtvwrX9qByuLZ88pcbEKrb03RApdMc588pZA+06Mrrz0zD7zSfZfttvWqAqLfBzhny6RgJ/LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7792
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_102639_234801_64BEECC2 
X-CRM114-Status: GOOD (  13.14  )
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

Sagi, Hannes,=0A=
=0A=
>>> Can you please share the output of gdb:=0A=
>>> l *nvme_tcp_recv_skb+0x115e=0A=
>> It points to the 3rd WARN_ON msg. I've replaced those warnings with the =
patch you suggested below.=0A=
>>=0A=
>> (gdb) l *(nvme_tcp_recv_skb+0x115e)=0A=
>> 0x628e is in nvme_tcp_recv_skb (tcp.c:782).=0A=
>> 777=0A=
>> 778             nvme_tcp_setup_h2c_data_pdu(req);=0A=
>> 779=0A=
>> 780             WARN_ON(queue->request =3D=3D req);=0A=
>> 781             WARN_ON(llist_on_list(&req->lentry));=0A=
>> 782             WARN_ON(!list_empty(&req->entry));=0A=
>> 783             llist_add(&req->lentry, &queue->req_list);=0A=
>> 784             if (list_empty(&queue->send_list))=0A=
>> 785                     queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue=
->io_work);=0A=
>=0A=
>That is strange - should not happen afaict. You did not change the code=0A=
>and recompile=0A=
>before checking this correct?=0A=
No, no other code changes were done before checking above.=0A=
=0A=
=0A=
>>> I think this patch needs the following:=0A=
>>> --=0A=
>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c=0A=
>>> index f2c829f1aff6..c2d4893ecb94 100644=0A=
>>> --- a/drivers/nvme/host/tcp.c=0A=
>>> +++ b/drivers/nvme/host/tcp.c=0A=
>>> @@ -767,8 +767,7 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queu=
e=0A=
>>> *queue,=0A=
>>>                  return -EPROTO;=0A=
>>>          }=0A=
>>>=0A=
>>> -       if (queue->request =3D=3D req ||=0A=
>>> -           llist_on_list(&req->lentry) ||=0A=
>>> +       if (llist_on_list(&req->lentry) ||=0A=
>>>              !list_empty(&req->entry)) {=0A=
>>>                  dev_err(queue->ctrl->ctrl.device,=0A=
>>>                          "req %d unexpected r2t while processing reques=
t\n",=0A=
>>> --=0A=
>>>=0A=
>>> Or in your case - remove the above:=0A=
>>> --=0A=
>>>         WARN_ON(queue->request =3D=3D req);=0A=
>>> --=0A=
>> Made that change. Tested and seeing this. -71 is -EPROTO that patch-2 re=
turns .=0A=
>> Trying to narrow it down further. If you have any suggestion, let me kno=
w.=0A=
>>=0A=
>> [Mon Apr 21 11:18:58 2025] nvme nvme0: req 7 unexpected r2t while proces=
sing request=0A=
>> [Mon Apr 21 11:18:58 2025] nvme nvme0: receive failed:  -71=0A=
>> [Mon Apr 21 11:18:58 2025] nvme nvme0: starting error recovery=0A=
>> [Mon Apr 21 11:18:58 2025] nvme nvme0: req 11 unexpected r2t while proce=
ssing request=0A=
>> [Mon Apr 21 11:18:58 2025] block nvme0n1: no usable path - requeuing I/O=
=0A=
>> [Mon Apr 21 11:18:58 2025] nvme nvme0: receive failed:  -71=0A=
The last patch had failed in under a minute. I had removed all WARN_ONs by =
this time.=0A=
=0A=
=0A=
>>>> [2025-04-16 22:56:24.758] [Wed Apr 16 22:56:26 2025] WARNING: CPU: 22 =
PID: 134878 at tcp.c:782 nvme_tcp_recv_skb+0x115e/0x11c0 [nvme_tcp]=0A=
>>> My assumption is that this is a result of=0A=
>>> WARN_ON(queue->request =3D=3D req);=0A=
>>  From the gdb decode it points to WARN_ON(!list_empty(&req->entry))=0A=
>=0A=
>Can you please apply this on top:=0A=
>--=0A=
>diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c=0A=
>index 9453cf453d03..334154a58bdb 100644=0A=
>--- a/drivers/nvme/host/tcp.c=0A=
>+++ b/drivers/nvme/host/tcp.c=0A=
>@@ -453,7 +453,7 @@ nvme_tcp_fetch_request(struct nvme_tcp_queue *queue)=
=0A=
>                         return NULL;=0A=
>         }=0A=
>=0A=
>-       list_del(&req->entry);=0A=
>+       list_del_init(&req->entry);=0A=
>         init_llist_node(&req->lentry);=0A=
>         return req;=0A=
>  }=0A=
>--=0A=
list_del_init did the trick. Test ran successfully for >18 hours, while the=
=0A=
original failure took <6 hours. Can one of you please merge this in?=0A=
Which branch will this be targeted for?=

