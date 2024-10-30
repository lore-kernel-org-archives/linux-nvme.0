Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D6B2D5CCAA
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 12:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vpada42xL+3jdZSUlEf4RMpcsnRWVdXEfmEgcG0vPLU=; b=uuXo49qxFnzFEmeUC334cqKV1k
	AJwoEunpiofqh8G98Lvpaa0U7GrLjpeOpA1+A1Co9rTRtSs9Rbg4lMQzFVuGnd5j9bdGNJj37uAMQ
	TpLv77f2nZ2Hzgh4SbRB5qri0XoHf9HQq6mhYCT1G/XFVNxxf3Kn+cAylwQdO1mNZmxgkJ9QSjRS5
	y4Cs3bgBcsTgKVPY3upO7nt1ky9L45Car7mZntJjPqckXtY8sUkaXZhuTFXzinLfJ60O79cmcLsHv
	sTYmKnwgez6qqZmk9lmA6DaGzkoYdazABeCUtjtQIGZdbR2o3ycVmBtqxzRbBmz0YQnz3E4rJoMT7
	bR2WfEmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t67gn-00000000IOE-3MUj;
	Wed, 30 Oct 2024 12:20:41 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t67gK-00000000IEk-44ZN
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 12:20:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730290812; x=1761826812;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Su9HtMbxUZyMvFHlsO3AiktcmmVYmdSWlVrZ5LhEQnY=;
  b=hP7myIglaLbP0dtp7Z8i3p0WgYnRJg1MonWLc1oyPhPeP2gA1RI+D+wL
   cAdj9BT2qRmV3wlBmbcV6bOBaChAHgqUdvLQotZpfxkl0l85EqXkUC5j4
   QExW6pNkIHm9ZW5aoLNyY3DDbp8p0YZAUgMrTGmsj4pgZ7Dt9H7kMH9up
   g+ZddAR9h/Ix9jwLKaaklQQT18zRTWlxlx8pAAPjuQCcH8nPHxcqwjvHw
   eZFJWDo9Er6EMM0Ml3pooobEj6qESjfz7qVgRnF8lj6JPIu6gahMcuyC4
   0jpcYwYBn8LOtzFvqu3cASYCfTRlPWZrgNIP9f+zIozsP110fb7iFkL1l
   g==;
X-CSE-ConnectionGUID: XgwlprAtTcyX7R9NYuN/9g==
X-CSE-MsgGUID: 4J2c/Wx2TKuxx2bVm7iwzQ==
X-IronPort-AV: E=Sophos;i="6.11,245,1725292800"; 
   d="scan'208";a="31222121"
Received: from mail-bn1nam02lp2047.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.47])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2024 20:20:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V2a5BPs1VMZVSSLKb0G1A504nDDAxCfJs7CmZffjyvkPKsXWSBiDQLBvynRGHAJ/IgI5KFd7WaXYnCt+br4AP4HKYDqG/6FWT3GZLx631eYcJ2Xpgd5BgiYyedWpei+EulUrvWO1WHk/sR8EX8g8VnHq86AZZ883qUOGzBHlVYT4O97jtX22RO9edyIUb588CFumoASM9eNi58zJ+rLk1Qlu2d4QQDg1jaJOq3SX1ibzkCtuVwb+Jt2zryCM+KnR4YtsMKcQ5c5FeQBFUI9xx2RaK7oOg6yJlkD8P9PEDKRx08b2Y/608YBUDSDcuoJ58a6YZmhVyNgjDyQEo0/vYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vpada42xL+3jdZSUlEf4RMpcsnRWVdXEfmEgcG0vPLU=;
 b=BBqJDeWHNsEuVW+flEsSge7dn0rnao3pZjBcF7erjsSSTu/EeTJqCuUrpncPxDARfSxnjMfGbt8H/kAGFNWM+1nyhKQcSkfqokNNp2ywldftNyTa+ju52vu6sePyxxMHekWOx7sbgdNjAGLZo6gu4uiL8bc9NYr57Qvn+GoO0W06fBTDRQkiuXR3g10KtXjecwENIDRc8vaxWLWS2C7pHB8AEcNQDDEnMnhqrSX7TEB6tLUL+GKPekj6kuAgAdTTu0kBr4KPCRzL67MZEUOdA/OcJfaKmEVrtKYPrJtMBHwmuamjj6NHKfLeShTu5U5gnaujud+1gBkRhXr8Qq8gSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vpada42xL+3jdZSUlEf4RMpcsnRWVdXEfmEgcG0vPLU=;
 b=R6Mg7OWIOhAQF6UkG6/0ICNrxFMDUYS4EzAjfVRImP4DLGfQ+Cw0nQvN9TMY5R8gVigP58Np1wj9NM8IB+0sN4VghHbo7yh7Pj/KUkkvBVbMSQ2VhLS/XZS43ay87xtN/y3Y8N9rq88vqahz/xl9xfQ069g5XZJHPe0L/Y2FgFM=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BY5PR04MB6517.namprd04.prod.outlook.com (2603:10b6:a03:1c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Wed, 30 Oct
 2024 12:20:08 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 12:20:07 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Hannes Reinecke <hare@suse.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests v2 04/13] nvme: introduce wwnn/wwpn helper
 functions
Thread-Topic: [PATCH blktests v2 04/13] nvme: introduce wwnn/wwpn helper
 functions
Thread-Index: AQHbKpg2flshrg+hoUOYfUTwXp8iS7Ke414AgABTjoA=
Date: Wed, 30 Oct 2024 12:20:07 +0000
Message-ID: <zndmkpl7qs53vyans4r552pwcumxhyhc4ualrodwnxh6y2azec@waicvtyoaccw>
References: <20241030065149.2297405-1-shinichiro.kawasaki@wdc.com>
 <20241030065149.2297405-5-shinichiro.kawasaki@wdc.com>
 <ae95fb38-8290-419f-aff8-b2964c9dc4f7@suse.de>
In-Reply-To: <ae95fb38-8290-419f-aff8-b2964c9dc4f7@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BY5PR04MB6517:EE_
x-ms-office365-filtering-correlation-id: 86ca8bd0-55be-4281-f06b-08dcf8dd315d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|27256017;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?jWbHhQMt6Nd/DhYZNLQMa0uan6fwngPllS4MG+xTkusNuuW8TF5Z17UH3g?=
 =?iso-8859-1?Q?YbHTWPK8M0iQGwVx9qGvT7qIF11VWE05eczy86d+I1p4EfX1iQ6GnuB8ZG?=
 =?iso-8859-1?Q?8wKFUSNlB56IZ9mJxmhJcMPJzZ//7HrOEdG/c5xT6d2nNw1P1Fa2nW2mbv?=
 =?iso-8859-1?Q?B7fyq8HP0t5yBQFuuRN36dbb6gZ6gUjHnzx5WavEeHb63vd9oVV2Tqtbc7?=
 =?iso-8859-1?Q?DDM89f8M3138z+Nf7w8MKwdkeRlM0TCQPVxviKpRN+aJB8EgInhhSbqygD?=
 =?iso-8859-1?Q?vwxFzKq8fmgOV3AaC0snB88OcJhE6s8aqFgZaiq7m+JdTwFB7YGpe5VU7Y?=
 =?iso-8859-1?Q?k6D4YB55d2bGQzCuZqliZ98x3HsvDAuBfHd1x1cY/iuMtgFcv+ghfQC2vY?=
 =?iso-8859-1?Q?XwS5VNl2UP+FawvM9s52rVFeWGnbsXtPze0FF6YzIDRDcv7ZOYWvs89ilC?=
 =?iso-8859-1?Q?/hOpCrk5ZujYixTcFelxh5Nfsvq/HnB0wKP5ZV5Wr5T4Ru98ZnYcKrLZGi?=
 =?iso-8859-1?Q?oqeGqrx0gp/nnAu8opPaApw6qFfI2NIY45MlhxxIXyn41JluvEiOZJU0ER?=
 =?iso-8859-1?Q?5nJ7pUELFHZxvpmUmW9bhiT0B60vM7pw0l0UnEtk+GhXy7hUrbaAI3Z7EJ?=
 =?iso-8859-1?Q?sThnJItYrHT2O3j9UQKwOhHjAj6ZJBmpjHtsryuKS4IOgG4cm0XQzmfy0Z?=
 =?iso-8859-1?Q?oXIVA2SEbEDHG0cEAm9kb7pwRm+iV3AUa06rMmuvzatwolXd3vB9nqoa9N?=
 =?iso-8859-1?Q?DY8sja/NYaaVI2litMay2vdlRirlsMROirFVoR9tT/fhHfeeSOw6a8IwtO?=
 =?iso-8859-1?Q?xfzsPC1hDb4ErvmfkImKlePHdAT56rcXRavXL1m9+HyPcBYtM8VdGKow0d?=
 =?iso-8859-1?Q?iDlGKOJxvRd+xWMqQX3RjVrAAx7Pci9cxSz4TtpZzFVefnZa9sKy44xRt+?=
 =?iso-8859-1?Q?IGT2SdWADrPpIPkWUminp9tlmh2fE7rEvdnkT0YguqnBwoPyQPGeuqHq35?=
 =?iso-8859-1?Q?BZBXm94erCwJ/rLlyQ9mW7nl8+6Meiuiy31zPoXcRW0c/QBdIczYb/HzbQ?=
 =?iso-8859-1?Q?gW1iEShDOX9q7ms0mxtLeT/pVuZrkySHSVWGcqXpsXfooedit1cLtDDRNI?=
 =?iso-8859-1?Q?ySkB21bsjblctVVzEZLrXl2UavaSUaKaaSLOVXwGzBfBNWW/seJjnMIJC6?=
 =?iso-8859-1?Q?+x2BHekwjnDtruqhGSsG5NRUwIIxsyb2oAc9+S20VvAruw6OooLNpaWhiA?=
 =?iso-8859-1?Q?LXyvKAXMwbkCBrsnI7A6/qgdUrkli3AV4G/jyGqDomX6VAXkq9NedJOpep?=
 =?iso-8859-1?Q?K3oPToWjAsluh6k1NCSyZDeGpVTcF/3h/98gtj7le0V07ZSsN0sRg6kYRF?=
 =?iso-8859-1?Q?isdK24/gPBMX/MhV7uzegIwJGKu0C4LhAAwpmL7FwLcDafZWVd0Qo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(27256017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?i0LxFwuZxOc+8s/MnJl8l3cmLMn/ivqD5x7Qmj89/a6r0r2h13qMLBsPYK?=
 =?iso-8859-1?Q?a+LwK9unMgrgrWGQcpw78TiCz7ZMlnnpBlAaJtpLGmU55+eZlbbUweIPwP?=
 =?iso-8859-1?Q?7hnzu/kTCn9lVPz4UIxjxA8P9AbD7ZohwlqcUIuK8H9p1LNTEqMc23CX2W?=
 =?iso-8859-1?Q?Al3BlJroZ0KJOUIZQdG0i0dTOZUalT6L9lYPJhdo4K7wlvp0e6Mm5Qi4Fi?=
 =?iso-8859-1?Q?F/iz4deGrHaKQ9xTANqgG0T8/8nCl6NN3uNbuqoDgPqFUkxvsmWX/cV7Ci?=
 =?iso-8859-1?Q?HR4dYo1YZujF7BrJ0TVz2wx5WmjWdZDWoKJZOQVMfV77T8aJ+1yd6cOX6B?=
 =?iso-8859-1?Q?XKMxv31CC1LC31hbaBxBcOk3joKLRLsH7xSDf6qWEm1nle2jUsIwQkoR1r?=
 =?iso-8859-1?Q?4s9MXNTKboVN4osfZSmtErjvPx+m3NrveNSJ34wtMu4R19Rc1MwRDtzICH?=
 =?iso-8859-1?Q?hS7oGjKciKlXfUb9SJoKZZfKxyajysatUyNiroM3+VHNhGJ0hainQIxc3z?=
 =?iso-8859-1?Q?rDeeFai2ok3AM5KdiscELP7EUVufItvqsMPJvmo1EY571f+2CkyJ6QkBpe?=
 =?iso-8859-1?Q?qPhxKG58vfZWOFo5PL6UsVgO/PUPgoA57FYJVFpJQz1iQ1FXbST5Rajtzl?=
 =?iso-8859-1?Q?SrdUMqB3MWnjWzSGnK1olGTt6nSijGp79GUqpO1NEHCmc5dQKnMZKnEzLn?=
 =?iso-8859-1?Q?td/FJHq6Vmuuk9kxBj3wPWZ5SKlMa7i7H68TifcX2ln67dE+HkA6LKl58U?=
 =?iso-8859-1?Q?epKH+9ArR+NPKksCx0ewU/puGuVIijLajlBhxorBSw+VwyyY3Y0xKe8z0W?=
 =?iso-8859-1?Q?3mqYr4eQeuEPj4CaNNpOxUCHgDJ5cip3FTpZ6SYhkUWraqdu9d5BTeANaK?=
 =?iso-8859-1?Q?uVKoKijnmg4QZjpKrQhw34Y4E028usD58kb3QIFm6IlnhRgfaWPCtgdokM?=
 =?iso-8859-1?Q?gqkUmepopyfMpOWyqOx5wXgq5TLVdDIEvMZevUD5un8NhEab3c9WxZUjro?=
 =?iso-8859-1?Q?fS69wzbio8MgjIT1ZK/IOgWoiVheQaR7v3QyP6ZimsaeFg+Tftix74y3cW?=
 =?iso-8859-1?Q?L6jeu97oIDFcwyabYlAlMPA6jxL4vR1YE+YdKIQu+iXoMOKkkdhPPEza4L?=
 =?iso-8859-1?Q?jm1a7Y6EG+pwOrTU8uJkNyZrcnmyy445IxzE8K4R9DEC9+jPZ/cH28sBgQ?=
 =?iso-8859-1?Q?TbWAUTe0JSCDRIT+gADyr5i9/H+NYOpUSIMLKsI0JsMyrspcK9fws8+cSg?=
 =?iso-8859-1?Q?Ne7GvKaSOM/A3Q2jWxhqtgJ2aR0FuWPX6EbBmGobWOjkQQvJT6949oUSYS?=
 =?iso-8859-1?Q?s3NxbOBS1dE5R9I+XQVcHfBl5tXNpRJwaQfnPb7SkyisQftLoIr9Y54iJD?=
 =?iso-8859-1?Q?+kFBJAdFld8xrZcDQScxaTT9UKXVHFoykz7Mz0D/gBY8USwWKi7hNuWmgq?=
 =?iso-8859-1?Q?f7fIp0jGJIO8UwjvMY4KC1G7sp5y6X6ht7uKcni5r6eSk0FknNbendiXXM?=
 =?iso-8859-1?Q?gju8kQ0QwquI+hcu88DldUBAlszjbr4YvJe7HC248zzIZhFwS2Yhc/2Tso?=
 =?iso-8859-1?Q?7myrxlZvOk8UfhgzyExYNoEZ9MAmyukDn7LLJ7VnrpFkUhWNAXom5/rzyh?=
 =?iso-8859-1?Q?DiA9CnYzr2bVpNObi+3nFIEfycIJ893pOtwzIVhca3w+E14Trdj6DlOPzf?=
 =?iso-8859-1?Q?WYmrjob+MbvAfcGRwJw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <8BACC5067364BF47BFE58CD5B042F27D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Q8HvEKetjtpYFds2b2WldljbpvW8tWueVtCvDq+ywgtxjm+MyY0cMbZZa5RyQVLMc+9wGo4mdeF/ieFiWrc437dOm1ENAXuQmQHZCFK4tR6fjn6Zo62MrbrRPxPB1hJNnt8GITfXPH4DKORP/pqFwFhUat8qD5Q53vTZf8703/thVzxaM0U7Z+btJoRasg3a4mI5dtuey2Lr7dYCXSmVKTESKIZdYjd029RZE+5+ZJtsiWI7+RuK82xAstjHqHJuoNl9/kPStzU3kLSdWxaYyWw7ezT4PhgD5GOYq3qqYSjoYtQ7BHiNAqci6RIoSEJnnrkToCHUHVtkv2sFbJGFfNF7MGP6K+LY5cZAc+xqA4wKjtc4rg1KjHIX68rYD1eDWfan9thzMwdE7BW0nE9IjcvOPdgKht24/Ex1OUBkkjwAaigOHAFGdf9/f9whBOAb/4uqRLc9mghFaDbKB67y21qTspvOn6EDF8ZT0oA2cqYfPscuImccw5Epua0gVFutS4s9BVA7R7e2Pp8ighiZanYWzVIQHN6v8LJ16L4E3EFS7HfJmuQMDaw6zKebmCwij6LDvoMJBu9Pmw7eO0fywF8SWOdRsD8UGmqfClX0eBrhVDRelP1Inth2rcSrRZqH
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ca8bd0-55be-4281-f06b-08dcf8dd315d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 12:20:07.9411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0OGiHbJWjkp9AFlFaNKSx2S7iYAB+69DZb83l1Oevyy0WJXLf0lP3xRxyAv5Jq0Ljtl2FyQ0Ldp4PAF5rf2COMYFlvuItOdfsrM2z++k3hg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6517
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_052013_063678_A0D4FED9 
X-CRM114-Status: GOOD (  24.24  )
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

On Oct 30, 2024 / 08:21, Hannes Reinecke wrote:
> On 10/30/24 07:51, Shin'ichiro Kawasaki wrote:
> > Commit "nvme: sanitize transport parameter in _create_nvmet_port()"
> > modified the wwnn and wwpn names for fc transport to calculate from the
> > port ID. It also moved the timing to set the global variable
> > def_host_traddr based on the wwnn and wwpn from _setup_nvmet() to
> > _create_nvmet_port(). This move made _nvme_connect_subsys() fail
> > to refer to the def_host_traddr variable, and caused nvme/003 test case
> > failure.
> >=20
> > To avoid the failure, do the wwnn and wwpn calculations both in
> > _create_nvmet_port() and _nvme_connect_subsys(). Introduce helper
> > functions to calculate wwnn and wwpn.
> >=20
> > Reviewed-by: Daniel Wagner <dwagner@suse.de>
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > ---
> >   common/nvme | 63 +++++++++++++++++++++++++++++++++++++---------------=
-
> >   1 file changed, 44 insertions(+), 19 deletions(-)
> >=20
> Hmm. This was not what my patchset did.
>=20
> In my patchset I changed the 'logical' FC port setup in using _always_
> the same local wwpn/wwnn, and only have the remote wwpn/wwnn modified wit=
h
> the port id.
> That way the host_traddr can be kept global throughout the code, and
> we can calculate the remote wwpn/wwnn when creating the FC ports.

Hannes, I think you mean the patch titled "nvmet: rework fcloop" [1] in the
comment above. The patch is not in this series. I once tried to include it =
in
this series and moved its commit position, but it caused rather heavy confl=
icts.
So I'm preparing to include the patch in one of the following series. I hop=
e it
is okay for you to apply this series as it is, and later on we revisit the
patch "nvmet: rework fcloop" in the following series.

In the following series, conflicts of the patch are easier for me to resolv=
e.
The patch I modified looks like this [2]. Your original patch [1] gets
remote_wwnn/wwpn for port removal from addr_traddr, but after my modificati=
on,
it gets remote_wwnn/wwpn from the port itself, because I think its simpler.

[1] https://github.com/osandov/blktests/pull/146/commits/5545881f1176983210=
0a517d29ff059435a1fbbf
[2] https://github.com/kawasaki/blktests/commit/93227f4c41f52032da3de1be1c3=
b485e639d9663

>=20
> Cheers,
>=20
> Hannes
> --=20
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=FCrnberg
> HRB 36809 (AG N=FCrnberg), GF: I. Totev, A. McDonald, W. Knoblich=

