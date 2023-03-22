Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E638C6FD1F
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 16:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UhiC4qFame9fgDvhXGwVagOv5g4O6414R1m+6KMBWiw=; b=oRxJEKKgT4yi1vOeRYepvOPkL0
	TsF2GuhqQ2QELLHF0utmAQFj7qY4xpd2GZjsp+fE+gR3ek8nyT/7tQBs1v2Ir//xTv4J5SwHrkIWD
	z+UdmlH98NU4PwMrtuIQ3Zt0rtNZCAxvQQEiGiUmVboj2yJQhNEyPOPPBeInBd+UNsZPlbc2kmyk0
	wDaKtcAUaXWwk4BDPJ4tFjwNDS07GkXZZSWzHIHqwQ8MxrUYWvCGChVa5aMdnnpcn1t8h6qIjUk1L
	htMpMrVSVjqMbmMhKR/PXdCfO4hysQLPKhfprqIJm2D43/ScaORobSmuByc3b8PdBmhRJTp6WhmL2
	uOUerkHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pf1eV-00Giu7-0A;
	Wed, 22 Mar 2023 16:49:31 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pf1eS-00GitK-15
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 16:49:29 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32MCYERR000606;
	Wed, 22 Mar 2023 16:49:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=UhiC4qFame9fgDvhXGwVagOv5g4O6414R1m+6KMBWiw=;
 b=U7NUkxWUiYdVSpn6Wagopo/G0aNKJj/LCY91alB89EgwQMhoEdJhSxq/TmL0Ee5Smua4
 /U45Nu3XmWz/ZwRxN4QH3yRafBKmyOGhcb9IdMPOU2NA/6LnMm7png2wY0icIdKgA7NX
 jVHAbSrAVGlseYDrOOVZMi3XnCp+Rr5MTgbUqjiVoa25zzo0SQdwQwLyIbAZkNnFjGYR
 YSsRmazr3uP695jeRYhifBh6LsYkj2FOh4YbUQx4PYfrhkDdkaJJV2wdXF4aTDOVFrhT
 hDamL4n98b7YoWtbvvGB9Ynd7/oGsjmxcgMfg3HTq+ve/fcZ2lWzIMOP12btX1UaUB0T YQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd4wt9g70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Mar 2023 16:49:10 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32MG70UF029366;
	Wed, 22 Mar 2023 16:49:09 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pg3m8nesb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Mar 2023 16:49:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4Hy4JNL625rW8NA/UB+STx1zMmSsObBE2LaCTYKw9YKVM0Iw7Ies22eeZjRT3w4IpCkoGxgJgr5ddbUmpXXLYI6Aeg7PX6pDRXb+yGXM2xfGRnRJBI2rLyTHzj9rwmsUmQW4iA1RF0F69QzZviqkxYQXT1+ovsja0ZUI9VNREoQaNcqbGBmtFPtA+gerqrPV4uXti4f6X32yZvb8c6jvAqJ/YRVenNU/DSVVVse8KDzH3Do1ry6gN9dAQewHZ+Iwi39WWsyOAG2Y0rYk/1SESsmzDB6cIoRPJmIlYdjQRCz645OeAKFoK216VZbqnJblbYyvmUghB8GSxD7eLaJAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhiC4qFame9fgDvhXGwVagOv5g4O6414R1m+6KMBWiw=;
 b=TzoZhkmAr9evG9NMKxBz1qjqwFtJ66PShV6XKXH4K+hfczpZ5ngyWsTlvxI1ndCGLhXj88qBXSro973R4yiKVlQ41ulmxbRuVjdAT/7PFnQrqV2pfSCZXof7cmRAz6R18siHIik0KiUcw+DFVXnLP6knhx2hItq/fNsXGikH3UFQtp3wvGVjHxVDXNTARAB7hK7fNCDStqBzCOTjQrh3ZJsFaZqW3TfR+OLE8gKAXhlmFBUcokE0Js35RvoAOn81lpfVYHaju5ox+7CW0AYHFCxpshcypUdf6TYGWNKMlvwcwVkkhsmfZrI5Oz5nzUVI6rn7/pqLLNeGqN6ODxvU7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhiC4qFame9fgDvhXGwVagOv5g4O6414R1m+6KMBWiw=;
 b=YcyjF/abIzZS72KrUb5JtBZ3Yyd9wqOxl7uvPtLJpn8W7yC+koQY6x0R4wODOPZW791zxLMQ9iw705uu8HSTlymAwx3xtIpaOT75PnYd9XtvkSOYNXMAHq6sZnZjOzG5R0fL+AMkcNn00B9+9bUWmhaXMJykY12kG13dKymbKus=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB6983.namprd10.prod.outlook.com (2603:10b6:510:286::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 16:49:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%8]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 16:49:05 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Hannes Reinecke <hare@suse.de>
CC: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        Keith
 Busch <kbusch@kernel.org>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>,
        Chuck Lever <cel@kernel.org>,
        "kernel-tls-handshake@lists.linux.dev" <kernel-tls-handshake@lists.linux.dev>
Subject: Re: [PATCH 15/18] nvmet-tcp: enable TLS handshake upcall
Thread-Topic: [PATCH 15/18] nvmet-tcp: enable TLS handshake upcall
Thread-Index:  AQHZW/LVaZPDBIBnuEuKqDBWb1WqJa8Gt6YAgAAF1ICAAASxgIAAD4mAgAAgGQCAABEkgIAAAZaA
Date: Wed, 22 Mar 2023 16:49:05 +0000
Message-ID: <68AA3629-6B88-4098-AA03-BEDF614F8D0B@oracle.com>
References: <20230321124325.77385-1-hare@suse.de>
 <20230321124325.77385-16-hare@suse.de>
 <6f69983c-17bd-dd72-b941-95f55db10180@grimberg.me>
 <b8a2e1d4-3571-447b-25c6-c6dd25fbad02@suse.de>
 <a1af3f6b-ec9e-4e91-ad70-57fcc9010a91@grimberg.me>
 <c426d104-b7f2-e736-c23a-b94fda54ed37@suse.de>
 <e0620d94-9729-014c-2cb8-8ff826ebbefa@grimberg.me>
 <e016af81-f77e-2eba-a805-838f62ba50f7@suse.de>
In-Reply-To: <e016af81-f77e-2eba-a805-838f62ba50f7@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB6983:EE_
x-ms-office365-filtering-correlation-id: 6ad41cf7-1d25-4b4e-b1a2-08db2af55975
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  5fq9ujR04joWkOB23cRMW8tzpC35n1j2DC33NLymrV++2pbpOeUG0pcJ8vMvARUFuJhNc978A4vEkDelqHsp3RTKs0XgHpNvjFxfuayCwCjQxPCR6K8z+iJ3xZp2fuhP8sorj0t986wTUpmHEBKImo0EOF1TnD4Sq8B/9XV0HRwg7kn6cDjYLcdtU8065yw6UVWK0LreKHz3dh64UbrVGEOYUZvowip3HmZm/6zsRjvExrmyAuGZ5n90gq5ps7n6Lq8TBShhimIsD7GmOG9+0hh2FHtfvFpxVEEihSvwhVn+x6wCa0gWqBpA/7ns84MHWxf4CVcgoeaOw0PVIzIl1UXw6tias0x075M0ad3dKp5bCUDwtuq76VJ1+10MFF6xIZyTYt1+O1e5eJblbREKScxpYGXN3Fqh8Q+WLCbymsYThUJc3z7wg3UIC9PD5Zbb2DC36FrJQ0Njy32oynfo0mLi+OxhL7noFeRCB9QRJG6zSdUuG9cMFjeLw5Kr2yMTErpGe5ckkmhxC44U0gdKGhFz04UfDztqcIy9tGhWK6coSPFGv2pYNux2QqAb0TuNDfyJJ7YGqk7JQYa7DatJdksvupCVCL/pWtnZRNdqMiEYj3ZvC8V1FTZB5ZFT46nacIdUBrqx+UwHIhHrBsi6ud25XvkKLcjhGlzwblznvI3T0VYXuNoxz5WwUTowr27AVE4Hk9i/9XdNJm69NOwfMRPnn33RqxIsODlSZuZaQyE=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(346002)(39860400002)(396003)(376002)(451199018)(316002)(478600001)(6486002)(54906003)(66476007)(91956017)(76116006)(64756008)(66556008)(4326008)(8676002)(66946007)(38100700002)(186003)(8936002)(6512007)(6506007)(41300700001)(26005)(71200400001)(6916009)(53546011)(66446008)(36756003)(5660300002)(2616005)(2906002)(83380400001)(122000001)(38070700005)(33656002)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?6cqRBgL73jYjgwDoCnaBVfeiyfRYL/jVA2f4EEUqmI7/GPfVfLiGbev1vh/i?=
 =?us-ascii?Q?bm5Ws4A44w+8rnYDxPWdizLvGQpVEaUnD0yAPUbVWvYQL7F9JVreMrj7nuZZ?=
 =?us-ascii?Q?j0pUmyH/DONzLyMkPDBM0YNUkQXa9A5UnQmlnWGpxvuNTcxqJzLM14szvKSp?=
 =?us-ascii?Q?0Bl01WuW5yE12+xtOIOnFAbjGurx0zWujYuSIVz+5ubHH4xt0WRW0gpmVT7o?=
 =?us-ascii?Q?LoFo9Px3SpYP4mtt9P9maDLAFr1QCMTnnN/Zee03/ThN0ok/bg0AFvXaoKzs?=
 =?us-ascii?Q?4LehBaeq08w0BO2D5W5vixEBuQCjRWu4CVepaXLG/pT1lz7N+yaE6UiVU6OY?=
 =?us-ascii?Q?1lRAQLBF1p9MoHpM1nGqCTP7ejwgCv4h/fLw0yaS2pgEdGPiqhkSct29REK6?=
 =?us-ascii?Q?bBJGpr5psB3tmdXdZa5wUaLCdCZRsWKdbKwdzagWk9vUGJcjG7oZttv8CHPF?=
 =?us-ascii?Q?QG21aMaf2r/G0oiE6v8I/MfJHMmzCjBP7skLDwtKa1BCdheqbpmJ/LKJkb4a?=
 =?us-ascii?Q?G8JcIhvDBjke+VMLJeffU3lP2q771tK030HsOnoI04rR2emYqPOykBnhZSLw?=
 =?us-ascii?Q?tfrGzN736RHuLywClcveIQ8vvmSmEYdmqBwgpLTEesnTpsYGuvvP0IFckKif?=
 =?us-ascii?Q?7RorImTV0/vvt+g0iDzopYlQZkk+5thTOoG7XyPZpJymUeTHmtt1zjb9iTBb?=
 =?us-ascii?Q?D6L1v3KC75jcP2d0jyDvW1iQp+arsbQr5d9VuIjLnQ4EJRg3HAcKHKx1hGwZ?=
 =?us-ascii?Q?W3j6OaTbluj7XXkvX4ibYxZSyfIpx/Hzp9uKzMBqsNnvjvQu0ucHEbxmYpMR?=
 =?us-ascii?Q?auhjzvdzM7XFWPCpZDc2DShLVw/RdB2zwT0B7xPZMNzjqjoHbSkY765n2bci?=
 =?us-ascii?Q?2DKSfxEyFzQBO8jOY+Pfvv6mru/4zddEns+M4E/JjK4egKQ4HtfxwwkpK/cj?=
 =?us-ascii?Q?NNEDjAYGmVG/ptTqNSxfRYZSCajTqfI94xcSmu/p9Y2MDR4uC0l6DB+PRb9u?=
 =?us-ascii?Q?ajD+fAt1DgfHwJbCv7WvtdeeHXc3B+zreHJSlGu4KmjrjTfZnmuqUnU3mA+I?=
 =?us-ascii?Q?NdsejkXQITnOAIx0W2q2v1wtsrdlhWaoxx5taZSxFqqPiU/Vni0wByeJ06VV?=
 =?us-ascii?Q?EzPLhgQh3n3v3Ka4jNEM3txKE0kWC0270Rj6El4rqUB/EVuq19say5n2V9FJ?=
 =?us-ascii?Q?lwm7Y1PbCFg5CYO8Q9rTyXZDRSxPKnSkV5W4sIYTliECLVJh2yHWpHmHbv68?=
 =?us-ascii?Q?mJqcvf0ZSW+nljyrLegH6MtWVYYYg6ENcBmrAHC9GDbJ6ewP4lJWIQSj70Kx?=
 =?us-ascii?Q?dodOxl+8N9zVvzkO/v/inFdR9ID7lIrsBGDe+E73r78l2bUe7wMmGDGVci35?=
 =?us-ascii?Q?we5p3Vf/EWC66AfaKS9ZAuoS4LvPKlcUSHuGYf7125PI+l59ILQXeWsCKZk1?=
 =?us-ascii?Q?eBklysa4paXPGDrd9wMjHPxanxsIWB8oXpCMnDQt8NKBWjUe23JUb3nJ0cPp?=
 =?us-ascii?Q?ihOwy16GpgTv511NNlE/GelPYT2kzCDFQH0856Aga+iGFirjsBRRz+CFRYwq?=
 =?us-ascii?Q?LxJymcNxTePeiK8mGjy8B4HopSVXPGFSPF0eSLxGqEvhWYCDLiB/Xbwjpyfn?=
 =?us-ascii?Q?gg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <65656C5E946AAD459FD0833F122528E3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	l3a/aSWdaPCb0v9egUOF0LM7zAE6aYmGVoVhQpjhDF/3wa0piG2ij1IkEpdtSD4v+dWFbgc5hqv+XhZuAfcElGJiL1SXfUNmQ3PEYHGRWx0/kcgRhGWrWpC3bDe78pbKTbSk5+7ZbdIGhkNei1/ypRNIqZkmqIDTjZXLdIvL04nj0yHMdDvkq83HQfSinFhQ7mWtS7wjgaJYlEnS13cGFIqJQ7anp1RaUwUlZAU1nk1ow6yz5Dk0C9PrMZrH1m5W+gb+iA6i+qsUCv9APr6t8dIUbSI63ocakanraqwnPQ4BEa+bYgNC7+kwosipQeDqOVM21P9eAc+fbtAPr8AwZNWHKRvlHXRWxifhMfDQATfpz/JTVVkc3i+D9DfHQC6GOiY0NyDF/+xE6dIR8f/oPVHUBNbfZ9MiHLc9Giq2FdK2bh/+5IGx8QpMSCaQCRE6fwB5TXefHfYr1AkIgsds7nzitkr8aUQR/qBGLrq5yVfKQaFNfoCP+G2KuOZ7Vsr4Mu7f1d7ADRpBjaF3ndCKYF4V/zgDJOY/SBxqqwJe1HgGtipUoF7DCb3h9Ww/zatEXiJM0dtGc+Argyg9bBfEy67DHFSI9r/gE9A5p3XX0RWvIk84ptEV/8cJxG+TtIDDLgVFgfsp/sINlEOxqgWIKwBGvqmq159y2nlSV0gIu6CycihVrW/sdVIXFkuyc4qjeyVY6jdhlGWfr2XilGXFMvdbP1xQ1gZGl58v9HNmzanvw+Ioo8QBFWUQNt8IzACdbfi7wlO4j0qNUM0Qrd2Lz8M5nKH/6uOyDGMmwIa9SsVfZy8QTwc4ThQgMiMAvme+7MwDs5W/fwLKkolVFYpvFRLhhJXWsvd56BWtafJO5tOSeVc5Olp1+WJ0C3QejQmJ5idUpFGxpWsL6M1RZlpyBr6Rf3idnWj3Je7xeueq7lM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad41cf7-1d25-4b4e-b1a2-08db2af55975
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 16:49:05.8671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SMz5bFQpcY04RSPb2weHC5j53ApL6ViE1S+9BlpZPNeMSX+aQmFqqhqxS4TT9tFvVtyJTsdmWOEsRJVHTSaOaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6983
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_13,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303220119
X-Proofpoint-GUID: iBjH1pdibgRTRQdAhptDSRHrTtH8HRfw
X-Proofpoint-ORIG-GUID: iBjH1pdibgRTRQdAhptDSRHrTtH8HRfw
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_094928_513939_3035CF09 
X-CRM114-Status: GOOD (  25.52  )
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


> On Mar 22, 2023, at 12:43 PM, Hannes Reinecke <hare@suse.de> wrote:
>=20
> On 3/22/23 16:42, Sagi Grimberg wrote:
>>>>> The 'data_ready' call might happen at any time after the 'accept' cal=
l and us calling into userspace.
>>>>> In particular we have this flow of control:
>>>>>=20
>>>>> 1. Kernel: accept()
>>>>> 2. Kernel: handshake request
>>>>> 3. Userspace: read data from socket
>>>>> 4. Userspace: tls handshake
>>>>> 5. Kernel: handshake complete
>>>>>=20
>>>>> If the 'data_ready' event occurs between 1. and 3. userspace wouldn't=
 know that something has happened, and will be sitting there waiting for da=
ta which is already present.
>>>>=20
>>>> Umm, doesn't userspace read from the socket once we trigger the upcall=
?
>>>> it should. But I still don't understand what is the difference between
>>>> us waiking up userspace, from the default sock doing the same?
>>>>=20
>>> No, it doesn't (or, rather, can't).
>>> After processing 'accept()' (from the kernel code) data might already b=
e present (after all, why would we get an 'accept' call otherwise?).
>>> But the daemon has not been started up (yet); that's only done in
>>> step 3). But 'data_ready' has already been called, so by the time userl=
and is able to do a 'read()' on the socket it won't be seeing anything.
>> Not sure I understand. if data exists, userspace will read from the
>> socket and get data, whenever that is. >
> That's what I thought, too.
> But then the userspace daemon just sat there doing nothing.

I haven't been following this discussion in detail, but
if the kernel disables the normal TCP data_ready callback,
then user space won't get any data. That's why SunRPC's
data_ready calls the previous sk_data_ready and then shunts
its own data_ready callback during handshakes. Without that
call to the old sk_data_ready, the user space endpoint won't
see any received data.

As long as the previous sk_data_ready callback is invoked
properly during the handshake, the received data is queued
and the user endpoint will behave exactly as you want.

--
Chuck Lever



