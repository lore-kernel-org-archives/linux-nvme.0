Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF643D1CDAB
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Oct 2024 08:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I5elE9GeTReW/sCM2PjsgR+Mh1jXd7HjZOrbDMN3jgg=; b=lYNvjzt4V0jh7FH6NGw0XfVPTW
	Yy3leicRu5fvKqkUE45TWPOj6OOR/VF2ZSlTARqBB74OP/h5Mkt6pEUKBRr6J08CuZgsnBHFfAPSE
	TjXSR8p0N3/SxWJsjnayznumJX4yxz5F6ShT/klMn+YmqL2g2ijm6Tzur/QOqBRYVFTJ5joasNs0B
	p7LqdyiYQCrAXR0S+o1XSsHhTl1pvgnSms+A4eDdkG8R/Z1MoxSQq+2Q53qcH1lCUCpuyGl2+MWWd
	R37fszBE130wLkoRJqRHkvekm7h/F+6+SEeLFSgR7qUBSXJ4Z6pvBCKzS5Xs8Cf4HHQflYJ+K6QS0
	wYy9HhAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3A15-0000000A7pT-2azy;
	Tue, 22 Oct 2024 08:13:23 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t39wS-0000000A6um-0wVT
	for linux-nvme@lists.infradead.org;
	Tue, 22 Oct 2024 08:08:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1729584516; x=1761120516;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=I5elE9GeTReW/sCM2PjsgR+Mh1jXd7HjZOrbDMN3jgg=;
  b=KHBfW9l83r9ck6FYgLil6+036xCIVy9CVQBA7pReY5H6nOCjX3XdhBNz
   W2WtR/EO1kygilJIFMXxg7tFzvKVB3HX0o+NxM62Z2gQ5jPqDsMOBVCN5
   pbZilZJarJ4pqIT6bcDn6BUoAakfwzsBDJvqZwEUreQl8C8Ix2u8FQyuW
   UovTBSjUzH9U5gSeIUfmo4rpCrGJT4hWDFgEIBCDsZ2w/9ANlcQA1pjUr
   hEzsxFYC5E/YmZ/Fuew+kK1s82IDMzo8hI8gggR+19LboiNfwIKQ4zqsN
   vpBMhdxFZMsWZOLZ+LBhh9Kfi/pboPEuAU29OusP71vfIvogkbRxjK3+B
   g==;
X-CSE-ConnectionGUID: TUVLPZQoQUi9VlMbptABTg==
X-CSE-MsgGUID: pewSMblURxWWKBU8mzEBzg==
X-IronPort-AV: E=Sophos;i="6.11,222,1725292800"; 
   d="scan'208";a="30535655"
Received: from mail-westcentralusazlp17012038.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.6.38])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2024 16:08:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L5JxoN6UxERgf7I/9QpNLYlicpw5tTtp19yrmUweHQFg8Uk0y3TWP0IZ6xKefxB1/HCJtu0KH4T1AJENuNNurIO6n8tamn5kJhs0uHyUZa/Cpk6CZ9aF4yA08RAPrsn0+r0aNvwRrMKEO57nMHiQ4gya0+W3dlMLeIcaFeMl4s5xOWyP0OyH685b0xBj/XsMiQd1oSDQSuhYXn0Cd0sO842DvZdKpz8UffSQyt6MTXtO9ySivNT0wAsbapfc2uoH+bie2V2orwJD5BdCx1VE46GFfFSG8ApT94IcXRUgCjnlGusxY6BdBOOwfdIfAPIBGYmJW1Zwjagte9DokEZXCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5elE9GeTReW/sCM2PjsgR+Mh1jXd7HjZOrbDMN3jgg=;
 b=Zm0sjh8VI7lmPI6tLWEhxurOmLKVWCPluRT4lBpIHU3ZOZP2tG5/2wBojZvBIhrHarAoLwSeZzJFjEUbDwn0jB3Aer1GKEu2mjDLnJiPx+U22+NUJ3kKp0Th2eu/Dvw1sAyMUvHL7bWKgjfNKxkha+hIJeQ0UHKBP7itMS0jtq2cdlvn3GyhyU88ZqubAzcHEb1j4phDO2NBf2Ednq+4eyCJ6X0R+2q8VF/9DI0vLxAXwdNcYLxjEP3UXdjWS93ADLiYyC1zwWbjxKvDrDqcHO7Laz3TZYtZ/j5Qxzrg203/cVlOvWD6qsM+AatRHIn+tfWrb9bMy7NYXH+Yul62+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5elE9GeTReW/sCM2PjsgR+Mh1jXd7HjZOrbDMN3jgg=;
 b=wD3JfIC4tPe0pdV6xvkWHlnxfPE1gNtZTP5YGMg1qgJhbYyEdepO5LTPGr7lgn8dtShTyedQB+eOGA0TUwZSSqv0AcR7pR+G6XlxJx3k+VTztdCAj6eRx+bGIYMU1Apksa89R+07BEIsElpsHGCC3HjLFkjn6Wec9nPISU1j+0A=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MW4PR04MB7218.namprd04.prod.outlook.com (2603:10b6:303:76::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.29; Tue, 22 Oct 2024 08:08:32 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 08:08:32 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: hch <hch@lst.de>
CC: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, Jens
 Axboe <axboe@kernel.dk>, Keith Busch <kbusch@meta.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-loop: set blocking flag
Thread-Topic: [PATCH] nvme-loop: set blocking flag
Thread-Index: AQHbILj4WY5++aniNkmiSCycU7ANMbKLNZAAgAAG+YCAALo+AIAEN7CAgAInNwCAAAmyAIAAEliA
Date: Tue, 22 Oct 2024 08:08:31 +0000
Message-ID: <ygq2tospvgesry2uuhh2fh5gzdm3vbkatdm42v2fjqlddzj43d@sdoplqu4vg62>
References: <20241017172052.2603389-1-kbusch@meta.com>
 <7846e57b-fb03-42ed-af8e-0df88cc566a4@kernel.dk>
 <ZxFRpdU-GI76uetA@kbusch-mbp.dhcp.thefacebook.com>
 <20241018051056.GC19831@lst.de>
 <64f4d599-3261-4544-90c2-4cb3e1ad96fb@grimberg.me>
 <20241022062810.GC10573@lst.de> <20241022070252.GA11389@lst.de>
In-Reply-To: <20241022070252.GA11389@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MW4PR04MB7218:EE_
x-ms-office365-filtering-correlation-id: 4b88cc07-d67e-4bf3-a467-08dcf270b832
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?UDnmnWNOHOc6+nZCneEwh/MX1dr145pmJGIBgXCb2/gSaVveuJ5Q1ENREQPV?=
 =?us-ascii?Q?qv9DJqJwMOVzW3/OxuWKPRnrkQ30J1Z0e+H2fDtIsS50WHjpdu/+FbJ/PdHU?=
 =?us-ascii?Q?efm9spTjpgqRmHnDqRrrADsHrKVVizIETVzK8gyDJ4QrLDF4q5/+vN4ygEXj?=
 =?us-ascii?Q?Y4L+1rSBODa9XSWxV3u1YmFbvDk5c5ir/sGiSERLDk4DEq48LvqLyFASMigH?=
 =?us-ascii?Q?RVIYigYf+IQkMJyasJKwy3DdYnYfLOLBlbgTaxe1PAq9RD02a9+65/6ljhLF?=
 =?us-ascii?Q?yLnl4GtkOHU4Xp124IOfPESBw9QR3JTyG4YxyYCMeeQP/quJ3WkZnUZVHDxA?=
 =?us-ascii?Q?N3f/iTdcdL3gScI/TggWP716C8dQxl0I1X5wxPCKP3zMrj67YmAHLOCzA2gQ?=
 =?us-ascii?Q?3RpfeYBnWuk9BwBi9jyiXaF75OcpzfoDJTy8z3PwFrXKHfY5bHPNuQ9pMj4K?=
 =?us-ascii?Q?f6WGMACmySlpV7KeejovNZQGDmREqB8Z/fjo9ZdM1+h5/XmZzOlgwpbDa1ES?=
 =?us-ascii?Q?IHRSm/ilBAcFAzzLihyckBx67ygovJ/c+0HKeZ1411HNiq1fyKcnJdQ9xpH0?=
 =?us-ascii?Q?HL1dvQf2a0N+uoZSOeFGyLQpwCpM9PuH8MlFQpeHNHP59URCD9XStKF/+Z2/?=
 =?us-ascii?Q?bS064m3iJO6J/U3IMvhdzwfmxIzKruoBg2qrBMOyyhyUPsqP9OONPIAOkHqL?=
 =?us-ascii?Q?LHRD9T1my+YR5wLpWUTFP5IV+ixoL5fZnFUvDmYAyIpIfdz3cvsHhknb/pO0?=
 =?us-ascii?Q?enxhJCtHAH94djLzYmiFHSCHFCOoFJouGbSyhWw0lYq2mSh4P5JveRel81M0?=
 =?us-ascii?Q?hcJ+Yv/wzgCMWBrrSZIyhXREuJcnYLy363gdpjr0O8ArK1afOiFhVeobXeVF?=
 =?us-ascii?Q?Unv6iLSBEkpciPS7pIuxGWDzrI69e81Fg4/82qSKXO0uNMvnIMKzuhywiTDS?=
 =?us-ascii?Q?a0YN2YuVc8JclpUyBxvykdYUgEeceYM9srClh764FNPSexzBrmcHXR1mszdQ?=
 =?us-ascii?Q?p9npo4Z8P7aXzDRp5ZCg+E6a3fswHxu0UlaMTWLcYDUAYGaLREfT/MNTZhaV?=
 =?us-ascii?Q?OrxArcUKV4ZTBd684jkX07Obv1ImjJWmXFTgBY5ydG8/xAft19Rv/is4Kqpu?=
 =?us-ascii?Q?ppP2+SHCLaZfC3fGr6AQiCprf2FbgBiQV3lAvZ55b3Qfj9MXg/kWzXkdyS9Q?=
 =?us-ascii?Q?Y93OKPgrxlul0RF62UY7i2E43u1qPZTFa3Ndalxmgd2NN1lTekDLZzERt8bX?=
 =?us-ascii?Q?PRZ7FcuFkhVS3tknHXb/pv9QeC57HKoVVN4xSWoEg2r/9k/u0GUoaxp0/ytv?=
 =?us-ascii?Q?yFvGJD9OXrDK+YtmcpGLBCPd34GsK0QRH5gxiD81/7FTXhI5Oh7hjPKmsGcm?=
 =?us-ascii?Q?zj2YM/QA7b2yEGXuvLpu2JkXH/3O?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NtT4bc0FsBZJjgJpu4nYAn/JjEOKPUTVu9EpFU2iNqvQCs9CCOI4vmHC+7I8?=
 =?us-ascii?Q?7UYz5BU2hBwGAjJq8ZPdXl0hDlQcBa9+1oWfCOQEsmEP7XZ+oZe9hiFnKGnX?=
 =?us-ascii?Q?SJTR1NjpUtpo4eLnYFgwMhetqPaR7xbd4kyc6+DBCXPT9B9Nplxn5ODnE7ao?=
 =?us-ascii?Q?pMDIn/TUlw27Sfn82o2z6uU3/Re6ARxwXHnACbzUDH1Jq3nAKUYiKWUA3MKW?=
 =?us-ascii?Q?qWrsvZWZ7Exlq5a2/1BvwrpkV1DgXexTh1fnuBLZWpuHiAbFMevZqevjMdqP?=
 =?us-ascii?Q?uoFfiO06jTuxJ+/t+LZyi1oQS/HIbHzUqKXtDDPcTECsUq+KQ9GoWAadI7oa?=
 =?us-ascii?Q?GqGo/NrjJTvusk6dF+vykCsnmv0/cerh0+1R9V6xaDq1bsLQASHFwQAM4aGF?=
 =?us-ascii?Q?EkAuyHv67wpwp70mm8fTo6UxWwiqGuwj63UcGzwNpGUif8L3Ub3RIU+z4lCy?=
 =?us-ascii?Q?wsAgCmQZ1kAFnQo5T4scP9jp4ShQaHtE43wO6z7+UtICKbdadGlgH+S9hedb?=
 =?us-ascii?Q?k991VFco/GqrLx4sX7H/MpjQ+Pwg1MwYkbwtpSYNACwwV0o6Ihx2TcyRXuEg?=
 =?us-ascii?Q?e7QqASSvo2Navwu5FG/lPOIOC83mJmKsCEp1KRbc0nolaECKLtf/9mPuWoNf?=
 =?us-ascii?Q?BSNgUbm3omBZCMc4WmnvAIw07B10/8VSL8WnH0yuJu3SmodW4uAiaUJV5iNP?=
 =?us-ascii?Q?+rMso3iLemuExmcyJGhsVEVJqIg2W3szP0sZefMM8s9hMO6b89pcCQt2DtX2?=
 =?us-ascii?Q?WBrvat6UfYdgtoA27OpXfvxFTIY1ORN4QLHgkiBPlLQtWQJvH905g5KjWF3K?=
 =?us-ascii?Q?wr550OmmYVCs5kaR3AL0xShN24n7NWbctXoNVA1UyswLHZvTAdLdLdB9/udv?=
 =?us-ascii?Q?QyuQ88njwAaM53tvcvIh4Le35M7m7oeIEswdC/W+RtbSNcXc1PV5xT+KCiNV?=
 =?us-ascii?Q?vJLvfyPq0rnckAY9lCZxznsb3WB/wcKJav7CKrz9lfzflPv9KII9yZSUuUFJ?=
 =?us-ascii?Q?yxOLaLaI0RoSVLcJ61TOOXoxeQ1bvOr45wfp8sfPrujxAGbBRHwSaL2KczF5?=
 =?us-ascii?Q?G8C5QS88RJJLaMdkcV8PTX5EW9J7Kc6TRsMz590RAXLct75O1A85edpB88gV?=
 =?us-ascii?Q?YvTu55cfljXm4spFBog5dPgQVKliIOWBrbR/drJqeeyADGMtbNIhQWjLQvOO?=
 =?us-ascii?Q?fsikqkq2i3YFyzQxgKgEMmDxdJBe+WodRCCQPNnh6lf31ykw2n+rhKWPALqr?=
 =?us-ascii?Q?YyS5P5dddpdiaYDaDjvX+19a2LHKRFHaLUaUJacj1jPdzzaVl+LNdESGCU7W?=
 =?us-ascii?Q?K6dLeJythA2l7YxbV0Q2tKh94KlVWemGAy1aQG6iiCwDxwWhUQwvfY3L+CT1?=
 =?us-ascii?Q?cYk1z/yL/a9WQxjLcBE/RQJXCaScDdHZc7G5sHEnmsUrSW6l0YSpfDBkR8HJ?=
 =?us-ascii?Q?TVrXGRGb2mwBd7QHqZTClmVu7pwV/TWg+tR1WWnyn8VeKNmyIHKJqR5CFfnc?=
 =?us-ascii?Q?CR5iTIkkjMsk8c9JS2no5RugYvBrClZp6wQJod+tKg4YlaGaiZ645bz60QR4?=
 =?us-ascii?Q?Dx9iAPgS1c0rcEuPEaByy2UqrQnMzCHmVxNhAzybPthHsGwI8EpKAs+IU9Sn?=
 =?us-ascii?Q?VrBMSCmYBP4O2k3HHgs+6pA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <132F2B1A831FF84EBA371A90CDF60DF0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2ZXel8OxVrQt4Zr7u5VY1+NjRVjDz+Qk7j0xvOU5Xd6LZJyI64ibj3vul7GVnLdZXbVOgXqm4aeN2McbXxLb/dm0XLiLdvS1K7GGs3hCaiwQSUN7/5EAjTp9rCu003/Yi4gqDoe2TycPFvcln7Hn+LHzrXHPkdVaeej6GylyWtsKEL2uZJuvLoGg3rtZUzbAD9OrzMS2rYW3MowfiMQI+jVGzIwGWkXLD8wS8QPPwjzENwFfTgTpt3a5n1YM99hKiY+eblJIBtXyR8dc3qFrUONMgjG+DrAokYafOHbLevMYWCPrM0Zr0z5lv6ChkInvtw8SbsRpuJlMkqAZkN27nQCLVg8xir6O399vQ8i9Kc1V6Pws33qbNtPRfGfzeDYjoMopxfK21chfZyyFG8eTLKeVblFYKzIrDzSDeo+gqeNlS/KBsKHXbnX3Nsze8HCmlYbFKTF8iwr6Im9D4xsyWXUE+kiW0AprqjG7dEgIpDBfjhgr6Sz+qFwn5D5CbpkQ+0dRUD6Kak8oVtvngS3IjUEKw7cZG50AoDFDGR8FmLZfTmmw49bKpUKLXkeQ/7f4Zzdub9Ri4s03ClKiB/9qN776CJ/S3RRAhEEsvFlRCHyf7a9ug8hNqxlG5iBQ4naE
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b88cc07-d67e-4bf3-a467-08dcf270b832
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 08:08:31.9875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: llayl4QKmP5+eWfcSe0VUoYiBe8ah9K7GsDPZmj774JuuEcHWMf5sMDaXYFS6JfH3Du15IjLK/luTCAqu2WLJlIm6oL1yUEGXU07W1hccU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7218
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241022_010836_301522_20609268 
X-CRM114-Status: GOOD (  21.68  )
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

On Oct 22, 2024 / 09:02, Christoph Hellwig wrote:
> On Tue, Oct 22, 2024 at 08:28:10AM +0200, Christoph Hellwig wrote:
> > On Mon, Oct 21, 2024 at 12:35:17AM +0300, Sagi Grimberg wrote:
> > >> Let me see what I can do.
> > >
> > > Note, the search is ONLY in the error case, i.e. when nsid is not fou=
nd in
> > > subsys->namespaces.
> >=20
> > Which kinda makes it worse as we use an unusual context just from
> > that rare error path.
>=20
> I just took a very quick look, and inserting the namespace into the
> xarray when created and only removing it when it is deleted, and
> instead checking an enabled flag during lookup should do the work.
>=20
> Do we have a good test case for commit 505363957fad ?

As for the BUG caused by the commit 505363957fad, the blktests test case
nvme/052 can confirm if any patch fixes the BUG or not. It is recreate in
stable manner on my test node [1], so I'm happy to help testing.

If you mean a test case to confirm that the commit 505363957fad achieves it=
s
purpose, I'm not sure about it. According to its commit log, I guess Jirong
might have a test environment.

[1] https://lore.kernel.org/linux-nvme/tqcy3sveity7p56v7ywp7ssyviwcb3w4623c=
nxj3knoobfcanq@yxgt2mjkbkam/=

