Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9420C43334
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jul 2022 13:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=; b=fCX52ElZSVF8hPlSSJ6Wegi27h
	j0Uxo8TAwdIhxoefrmk2qThqiXnEF2wauMdArf1dBYl2v3hSXmbYbTLvCViaSNBUQwz1fU1XKHG8k
	nc5QCo8UXqLdpdjpljsUT5ULkJlwBoSKr/ZZtdVs1IBlHgSF7UdCa7h0tQ3ncqQzrqQ/un7X4erHr
	7Ek0dbfQdzjXM29oz3YhlUrzeNL/Zx0IENp9oo54jd3bxL0tjCX7wxzn5xQhGAqFUcQt4pAJIc+g/
	eRd3soZTdCMuCPCEQNQkdRWiznomy+mLMhuLoxgKAGtZdrAThfkBnGOFRhvqzj1mH8fKAGCA9Wq83
	NM2t2aWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8LhQ-0090OZ-L9; Mon, 04 Jul 2022 13:01:12 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8LhL-0090L8-54
	for linux-nvme@lists.infradead.org; Mon, 04 Jul 2022 13:01:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656939666; x=1688475666;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=K0Ck68mvfDXMY2pFY0m8aqgd0Zy7gMHoqMyWALAMhwvtanxZzpSj2m9N
   qKcpefLpqM4C9okkuMp25ownq7R9sX2eCY6+wJx1UZm2DcqbeZqwIuWNB
   pLG4PJhOBt9MVDr97dqnS1+88h4/1AUyF+TSqVSKheaZ/L8h0kEMF1IY8
   q8ItBLJjwInvt3VDjv85O2uDL94ThHEkBBUjKhVjQwHW3gpoNdDoPc9Q2
   9FDZbvNcFhwus4FzefuikZfJGsVOex/Rk76GT27Jwq6UnLoEZm++MxmNV
   mIYs94cpIv1jstzy+xOGX1vfsYRE+97cs/O+08lFNle/Phw/RKKvOdQGx
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650902400"; 
   d="scan'208";a="205480420"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2022 21:01:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DU4XiHT+8x0ICENpAWR4gtG5i7La+CkDudELCDpj6El5iSrMGmV08a9boKpe81IeEpj5Vk71gK1BNff1VjPkfYjjxM7qtu1UVk/B+nraOYA20m1UVQ3AKL1g6mOIgbB1LsV/oVNuq9YPiseF1kG2eQ69+EFFrg5FDhsiwukNE76g+eQSQthuULvLXE8jooU6fapmjgI25xnQHgOEP728B+LF+AnDlMfrv1j3WuScBsLkUPK7wLYzuxxboaaTAGDKp0lRALbNXbxxlXZxiMrMJPvOMaOxIV9dFCDLg/PmdXAGN8x+RppShPohBcvh2Jr9HsdS8p1yTRSmKuWIaTcHCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=O0JfTn5QKubfX8isTmR06GpVtBGAHm2HTk70SU2egiT1llIf7QasoiQReuzoATP+pZYbL9fShDiqGcid/dsL1mPvCfg4Vr4m73FmhFRTwLSxCYPng6iOUb2RS/o1T5/sbP+XIi3wLzuKv20HWB4EZsr4i4cZNiVFxbsHtIvwmtiNGYVWwYVdFPzo5t6jiTYUl9LWy8Us/xAdwPX6lcqUuxzMWWqxxe5JoP7Em2Aa24wdmBk5lp0Y8MKnEBJ1cO7rdWlzs5Sz1wnJFzSbobL0+a/7ABH9Kbo2+w9gL5ttuH2Sg3vkagLP3oKisheBpgvwwljpUAusBXdbBg7jZyrQpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=gIWkvKAhT1cAKQ9zoe2E438IjsSLIBbwaZR5nDctzjZtPdQFZFEoh3oGxX5gs82iAek4FMNx4Z/VippFDv1d5FKCltaV4/WrkDIXNk9SaVEy3JygjCnSc835u8bQrCSMq4KsGqZU79+7thhOZ/2YQmfW+i23AmA9WerNVCuU0KU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN7PR04MB5249.namprd04.prod.outlook.com (2603:10b6:408:3d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Mon, 4 Jul
 2022 13:01:02 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91%7]) with mapi id 15.20.5395.021; Mon, 4 Jul 2022
 13:01:02 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Damien Le
 Moal <damien.lemoal@opensource.wdc.com>
CC: "dm-devel@redhat.com" <dm-devel@redhat.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 02/17] block: call blk_queue_free_zone_bitmaps from
 disk_release
Thread-Topic: [PATCH 02/17] block: call blk_queue_free_zone_bitmaps from
 disk_release
Thread-Index: AQHYj6PwWc2YB0PqMEi8xHAfr13CWA==
Date: Mon, 4 Jul 2022 13:01:02 +0000
Message-ID:  <PH0PR04MB74168EDAA4A303F4513DA3049BBE9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220704124500.155247-1-hch@lst.de>
 <20220704124500.155247-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e763dd36-641f-43da-ec6c-08da5dbd3fbd
x-ms-traffictypediagnostic: BN7PR04MB5249:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  g28chmxErwZut5e3YErPzA6IhcD5TTrd4XT7m3FyUk7i6nB7Mhui2rnNYdKvTe2o/dEKeQ9X7e08Egb6jkAg4wlq9ukqCxnpCv7SUiZYm13lyw8VrZcQ3p2hR/UKU0GBg93xWk8rdvTLyrzQPHPsQd+9bTLFIjWQDjiHSDp99PWmhX4ybJetD/Pcv6YVg/HAfbyG2NUdFOhIStHGdpLwNAB4zPvt6Ghu+AWe1417yYC1Nvj5MapGfFHgbBGLD3Jngg3jdj6ZEj2/fIfLwgKmGPcl+onO0Km8NF7b9cnoDxBuSLTt6UPaeR6c3/y7VAhUAHRKuPnsoCbOT0dNKP2qfug2ueQiBNwvdn0qZELXfPjbaMMCOM166EGjFNt4bcuVESwpIR4hL/LtgszmeoBhxkALFXllzygFMvm8LGyIIGTUq6cqe2pb78YwTaTS9mKNAKVqALRzFK+7ctk5v72BZQAof7iZV4Bql0hlgVfmwOlo4ONBi/VKOuMy9t0AQ2r1x3+77ctQJ1vTPEu6LdKWj9j7jm34AOMB1c/BB8aCB3QPwRvZN8cPMynfsMScCCFL+1pAoTU0sCb63J58d9HHj55k6BV0AIdJyLgObgYDX2kMiiHIgsBrrBY9575neqjxGYapAIeh4RDEAyEa14MTNwSt1NEPYUbE/+orxIE5lc/1RlR9jBraB+tBaT39urq8XVW9NqyMhQufv63QolZhu1Ht2zL36QyQNggRaJDrgCdHvf3DNu69JFEag6uWi508zncCR1hVYeiNIIXrlY8QVHiqkFdcHCDODZL/8WBfQ+HvFFcZ+C3rzQkWzOgBEt0F
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(7696005)(9686003)(478600001)(19618925003)(186003)(6506007)(41300700001)(33656002)(8676002)(4270600006)(91956017)(52536014)(8936002)(66446008)(66946007)(76116006)(86362001)(66556008)(66476007)(2906002)(71200400001)(38100700002)(55016003)(122000001)(558084003)(54906003)(38070700005)(64756008)(5660300002)(316002)(4326008)(110136005)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?v6MQ8mmrNOtYRkwulK9ZeMWiYDl/H4Z+174GK+DbjZACLCBjh9crbt97lfub?=
 =?us-ascii?Q?kjVpwCNymiBFSfHfM10DWjGwk4ve0hfR9UghEjb9h+SxJrknsNJmpsYWaYYe?=
 =?us-ascii?Q?g4GY4lJG3XffNfZRE4jCfOsZ9IWbvyuwugNQ3PQ4SKOR3JDuMn3teLxqOFl8?=
 =?us-ascii?Q?5EysQyEFYdk/qPnLNDwpP0Mc1E4ci6Dau0drs6ujOhQt/gOSPocsE44Mn7rq?=
 =?us-ascii?Q?RvoZFg/21UrNP24Hqe/S1ACXHfAeHBRQHxzMORi5fVJL3ypWPsA3CHQH1cPi?=
 =?us-ascii?Q?COsQuyLeIi0yyASNheqh6ZMi3soRWPpODVl3BBUHO0cWaXn2P0an6+Uq+k9S?=
 =?us-ascii?Q?c+1TAAmEYeYAPUyzc9RSzNAZ1++KS3+J9uWeHU8cSvGufuxX8EBrlxIBt+22?=
 =?us-ascii?Q?FrD0Dg5K2Hlh6DS3AflbtZ19TEGnIubz0ePbSbYmnm0j5FT4p7kCvvevVWDu?=
 =?us-ascii?Q?BZrdEjZRcjfmZBhgWA8cXvqnUlbEbDalU1YNhh3SwGsI5Gfgt0aQ7uTypT4O?=
 =?us-ascii?Q?6plQxWTrRNID3vlcP4U33XBx1u+92COhK2xaPi56yLEJlkiPKXh7LUgtBtct?=
 =?us-ascii?Q?lVccNnAbM2myh2r7zb3eW4gMOD51bhwK5gXJVedLn0btmlbRfj53rk6DscoE?=
 =?us-ascii?Q?MSaaS1y2DU+gNNiLH5hCxIXCblj0vGKrIoBn33oLCOYUuGqM7ECS63GJHsYv?=
 =?us-ascii?Q?1lesJrOHChneD45QRmYmP/IOYT16XZBdQoMptQOXXlu1C+nAWKGsxtSYgfgG?=
 =?us-ascii?Q?KWriJeu5yyRYNorwW0YDZ2CkUdxuoJ4FkxlVREjnJ0VTIFQZUz4eSdvMXLER?=
 =?us-ascii?Q?uOpx2mCAAWJKXhq0BIdk18qkrpZNivVg8FFPkf8bHTqJbpeMZB1cNpT06Eol?=
 =?us-ascii?Q?r6WU+jS3fB/BjhzbnlL9mjyXXS8BRlw/S5fRE1xNyOvxl+h+DMT96ien8kvz?=
 =?us-ascii?Q?oZRnEltDLiS158CyFbl3zx+m+HjQsSaOFY+XX14rnRcAvI5uB0FE/ETJKmd2?=
 =?us-ascii?Q?CkS4kP+Uet+NjOmiJF/Dz+iDwfTo9StKCw0KiWbjWD7cYN1vwmZJDNfYsYwV?=
 =?us-ascii?Q?8mYYRDnC1b3TlaZQ36Ci0rDWcIVovDHdXGDDCn6NzM6of66zAS/LrjQIuSnS?=
 =?us-ascii?Q?D9Xrob6lD1Eq3xxmmgU4D3WEz3ow4iSa40VQMlXX2A+iQ00d1zkmpwjH8KKM?=
 =?us-ascii?Q?QNWan9g4+kwTMYBmpwL6VxHU7RpWfYREm2q41MSA1ubenq5zbcZW9W8aRRAk?=
 =?us-ascii?Q?qBRsegDCMUhhjDn0Izp7EKjoRA574j/YRIptagSBoGwotkq0nNuJVsxISPip?=
 =?us-ascii?Q?ESbNxvi+Jr3dzwA27f2qlW0emjeveVJsE103kSqXlO+7hgTcBVtEXiHbVZQv?=
 =?us-ascii?Q?swtfHpGOjcKvKh7Lff5NWWD7TByyjMYTfESQadq9DYamA4U3z1rAVo8xfDIp?=
 =?us-ascii?Q?RN4SrjpLDIexpmL2TMNBdPq+mVJXUd8Dej+/usDqtZQMO7NaN7FZ5J9CCSlq?=
 =?us-ascii?Q?wttM9hNmHGG64g/kkMniAery3vvffugH9M9UZjZFXJmzR6PeUZ7S3WAl3j67?=
 =?us-ascii?Q?7EOSDUwCHsuhId1Yy9rlUDlu9NQZZW3vQM7LaxaUqkRi/eCG2Z3iryzIXUx0?=
 =?us-ascii?Q?W8g4hMS1IugFAOhpfM6nMGP2H5jCBcP/hda4BIV4gabyg+TI02OuOpVn0i1x?=
 =?us-ascii?Q?PGTL/q/u3spjMI5Y10sFBLoL+ZM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e763dd36-641f-43da-ec6c-08da5dbd3fbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 13:01:02.5477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9HPy9mDT+F9DYCZjP/SI9DjLkSZoUgzYbFfRwCUPa+xWnK6Aw+qK+vdVhRIPRlgh0AJEcd8cV9/MCyBqE44heDdWckB5jUHFLFujpEvbK10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB5249
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220704_060107_322894_55D620F9 
X-CRM114-Status: UNSURE (   9.77  )
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

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

