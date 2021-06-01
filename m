Return-Path: <SRS0=ddWr=K3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316D5C47092
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jun 2021 17:39:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1C6F61378
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jun 2021 17:39:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C6F61378
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=bVu5uxZEIFH4L1VtkEKAgWmc43K7/FX18281XhOii7A=; b=LqHJF3faDs+2v7
	12LH0UaTyW5QDlYI0NAv90pvPsFE/g4Ks70gpHCf7pm/vUB5rARLyf/BvWgNLZP9LA7K1XxOWFH82
	qluigiYeSRARSUDxF/h5pweBe69Em6FqLgwubRAhFI1lRX+Q2DXTkzhtFoy4n72EnAFjKMF5oJziE
	IY6Qwd9vOBprz+h5X+6bgv6gHtuEnr5WJwvLjIHrf7iEPIUqVDaYzVlWUfJDmFNZ4pmY97vrHrbpQ
	sDtEDQJ3G97gHX2yM13/JpHCmsXnfYTOMMd0Nx69FngdvxjvmzJCaBw060BQhcsTOgHLvsBL/270q
	qN4o10WBQ/Q/F+ZZvcfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lo8MN-0006u5-O2; Tue, 01 Jun 2021 17:39:23 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lo8MK-0006su-QE
 for linux-nvme@lists.infradead.org; Tue, 01 Jun 2021 17:39:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1622569160; x=1654105160;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=QdZSL5CsXlxHhEL2Mw5vCkk6FWBeC6tWUoy9HIC815M=;
 b=R9wCblVAP7lyN+TSJxFBGJTFiun5ih5rpBtXWewn/TjoiH5HCAhzqoCd
 Gc/0ElXOJGZOeyXb05FDk88VG4QFyJNPvl+WbGQnDkMrfcSMUMvEgUG/D
 Gb0lyJFcly2YL1rDlSdPi4tCj+HB+vyzpgbFxnzjtmEcSmuDsP2V84UIJ
 dXyLVu6PcIRpPK60HNjAxY8NyYYozebgPu/W6JHIEkhxR9sNw+4pHNuNL
 Nd+WiWf5hmXuL780l22/UP56i5XPiO67X5AMqmp4VprfSaexEIbVTQbmK
 eTwek7ACCuXU86/I3defC2g/3axxoZiaCsAjP7goF9aukBw/yLySMdFHO w==;
IronPort-SDR: n8ZpkO1WGQnq7eVUuGxo2t+ikAAEDl3Reh0KjsoKuc0/D1bapDnl/0q16IWDT5i15bYwt92yb7
 b6L2blYt1ovjuCJnSMhxJal7HQg0JNdZ144stATGsYFvkjy50ysZpbNPxD5wOZLv02UELq1h/M
 Gfq60vk6ZMfwWWxPUJ9c9ksV2a24n4AxZdc0Xw8BdWn9LRTu2iYM27CEFGVCKwyy4X2ya8vWeP
 AHnl2393bAquwoBlP6XLu0UVb5s/OwXHCrKOi3wf/+1Cy18ah1RRfhTdvwbFY+5XcAUXig3jZi
 hXY=
X-IronPort-AV: E=Sophos;i="5.83,240,1616428800"; d="scan'208";a="175024069"
Received: from mail-dm6nam08lp2044.outbound.protection.outlook.com (HELO
 NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.44])
 by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2021 01:39:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kok9mxYIMxtQKTO4EkEz8QgRBo7Ga+UVXKNIm2UFsBMiKw5LXlxRY67yhEfaAtBdg6jCZl1vfEVc4utLnqtlHsJrapt378VwwqNNpHpJ2HOWvlPndtgeCJwmPEYx2V83NLacS1cuCUMAEN9z5QS6NK/pdpmWlbcCwaZdSTx+F2Lv7lhGPOAO56FDqTDdbjlNRB+6VVJizLPJ4tdo1BmJendjKqKDcg6OVNgsDKn974B+W4/3rLb21qwTQVzOLivj1Jdsp5jKTjUtsszL6L+V7MfqCuwvPnEl8V08S7EJMlU72CHwWwvrldRCv2RrHRC6meCD2Skv8nV6d7xl/7coNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QdZSL5CsXlxHhEL2Mw5vCkk6FWBeC6tWUoy9HIC815M=;
 b=m1qtenpCcN4hm8o+wB2uAdC8gvoVx0u83SIZr88Ifs6qxJcDDLMwwSzdnsq0gOuGBUwUMKjd49Zue66HIZ4Yg9C2W58LIhvx9Lk8zjty0VH3abqYo5a49eP8W/9GP/yrZ25EpBD1cxY6GS1mY0W5kj/pijwQ3T9i90E4mxExLqCdYDgQ5ge+tazZsCMVAqqxcmYmTHrlXWwwCkbeWQUc4268gAX6hfw3+iSJ2ujhtEoqFvMq3VnwAWCMFEfZrJokkarCMtuVxuOjSk5CtKc2yPEXY5w9d0c/2fpOMfHcaeYQINw5udYijQnDheEl/SIBOG72zfH1JLIBxNagHYpthA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QdZSL5CsXlxHhEL2Mw5vCkk6FWBeC6tWUoy9HIC815M=;
 b=dVmmfgUHrSy26by/AZbdDTkF4SrIR109QRUebEnidPtC1I6DQNmCdZlv/e6UFzPNW+CwhOWhNPIGaj/vAM8+nrvlxg2UyidYDPwEubf6trZUQxAMIT75O9Jv9Xl8Zk2w/WTyOwLvXmuDH5psYvIhuGU79OsMDayZo3IKWYs+828=
Received: from DM6PR04MB4972.namprd04.prod.outlook.com (2603:10b6:5:fc::10) by
 DM6PR04MB6427.namprd04.prod.outlook.com (2603:10b6:5:1e8::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.21; Tue, 1 Jun 2021 17:39:16 +0000
Received: from DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::8dc6:ecf:9d83:615f]) by DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::8dc6:ecf:9d83:615f%7]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 17:39:16 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
CC: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <Keith.Busch@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/4] nvme/loop: reset queue count to 1 in
 nvme_loop_destroy_io_queues()
Thread-Topic: [PATCH 1/4] nvme/loop: reset queue count to 1 in
 nvme_loop_destroy_io_queues()
Thread-Index: AQHXUlH/o7+6XZD5J0+Mqebx0OtKGA==
Date: Tue, 1 Jun 2021 17:39:15 +0000
Message-ID: <DM6PR04MB4972429B02A7CC58C3807F13863E9@DM6PR04MB4972.namprd04.prod.outlook.com>
References: <20210526152318.107202-1-hare@suse.de>
 <20210526152318.107202-2-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5459e6c-6371-4e89-c41e-08d925242d60
x-ms-traffictypediagnostic: DM6PR04MB6427:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB64279A9F504CF9FE1CE09F40863E9@DM6PR04MB6427.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xGX1HUksrbCk5xAu1Ae3p1LyXlAcNRsjR4nUhFXYj8U4frWbjWqX4fuSXO0WXlloztR72xcmqiQ9Y+OT+vGb+JNdvaA3zSqiWRirBDBR14LiR9xqF2/iTxQhdPzVUWJv95dp+xcG9ojVw/bZ9JRNV0KkOmDYqQxgXL108TA+9L1x7K55tEdxt5hsLGCvnokAcRsVlJPN4m7WENshElNvIdAlQTzWmmna/hBYQL0xud9kG/lzUToNO2nWoHoQeO9GGj3XfYWZoaZyhUIXBDntoR3wrPHcNHpvwWFOopsf3q7VCWghnHjWI2R6LKSvvvyFgvLdF3Lf6+sN5b4ut5ExnIHEgy4pcyO7GaqwHUc/M77OtKnzJ919x9qBaveHPY2549kRJaFH4m2++3m2VkIhHTWJtUP7Ixeal2D1xFufJ/zHQfYetxE7tVjaqi0KLcw/Z54gX2uPLlxirUKbDz6GA4Vs3HQx6fXFiJ5Vv9atxJU+aM3jGJU7ZzkTLNwzaKCfxBG36ii2bGRMVf76h62QzK0lZpHgjTNUr/vsjsS0u/5/ISgCKW/P47zES1gqU0Lv5Ivu6sYj6VOaG6kgfiC44w0kWpe2I+wLwnKbmQD7o7M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB4972.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39850400004)(396003)(366004)(136003)(2906002)(6506007)(86362001)(316002)(38100700002)(26005)(53546011)(478600001)(55016002)(71200400001)(186003)(122000001)(66556008)(66476007)(66446008)(66946007)(64756008)(8936002)(91956017)(4326008)(8676002)(5660300002)(7696005)(54906003)(110136005)(33656002)(4744005)(52536014)(9686003)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?USh3cz9Fl44LcS6VGZVBYN/Imwh8Od8AuWkHYbzRdTXhgazDgUm0nnFTn1K7?=
 =?us-ascii?Q?FqKGGmb39R8P6fTDP8Moh9sW1aTxW180PE+b+pZ0gvxVBJU9oeGxTKJb/ZyE?=
 =?us-ascii?Q?7N2hxMe9NeqR9d0gd6kCXGfLcH6uc+klbKeTj0J0FFc6wS3aKet8Ar2CiCZK?=
 =?us-ascii?Q?SLiTm+PLAOsn8EqTygjvWQKk29JHJo0Mw+G7gJey1Su0H6F5yEHcV5CP7N6K?=
 =?us-ascii?Q?WmGdfjlC7KKYRP8RF6cgToyUPj+HE7qqTgk9Bo/f3hDCtjPW24pLC3crqQr0?=
 =?us-ascii?Q?8+MQ/0MZ9UttFKq3Xe8pMQz006r6tWXLtaz143La/GBq6pLfrhZ2Lcp1kSNM?=
 =?us-ascii?Q?n3nTXnewVW/12gH6nx5lh57rlIa5qQB4qt4TwOi60vKmCbBASvdxq0/lqJdv?=
 =?us-ascii?Q?ZeYmwZRFb+M7cH5//EVsDGMzyXTT+Wq5XmjfMSsShYl+PbMg2yw+/fBzY8aA?=
 =?us-ascii?Q?0Kufw0ent1zTYyRcJ6U2gplKPURl/lTOcafm1LVeiCUeYYhHyRkRSi1cW7XI?=
 =?us-ascii?Q?X6F5Vp5fAuqG27NY4a2udewk5QY0YTLmza46gJo564wZEYzJVEjB/zVdOcoZ?=
 =?us-ascii?Q?9SvAVH6w8UsD9/HgabsG9f4GQpiHYpBSVaIibtDV+hgdc8+93NKzLzeMSHC+?=
 =?us-ascii?Q?dGWHYG0mEqvrr8laxSm54EWGKyoVohLl8OnLbxhoBbDCvwhAoDQRxPAS/xtb?=
 =?us-ascii?Q?OI3rTyYcbM3tV5yZ6uLZ86Y+++b4VsgYtyCE/3UEUAyiM4W6m4CBaBzwqNLK?=
 =?us-ascii?Q?7AqTOVUk+WCn35yueBONZ06vWpPRhWD6b43mkugK2H1GuS2Dyd6uHIBUT1Ra?=
 =?us-ascii?Q?kofnQ+9pklTNMqOh6AfRG8Gza4f8j05kRQnzr95mRhnfrAs/5pH3jhfqZ3ld?=
 =?us-ascii?Q?/Xs1oN3Pncqx9iv8GyvVC6mR7Zr427OZNT1fuyps8R4kswaf9QPF7pcT3Cgl?=
 =?us-ascii?Q?DJiow2JTVSOuehtm1OxSeP8ASqEBNyR/UZVrmCgANAQuNHfOBTetb4yV82T1?=
 =?us-ascii?Q?eH7HIEirBqMWB7wvCGQVjgQMmdfPXKuX2EvGhWuRjShSbEBDVQ/BPuj60Z58?=
 =?us-ascii?Q?pknLB2DRxZMWQ2ycAIsu0Zo5z4Z1/IvBpfPVOFMjini4Hyli9jCQJxvoJZq+?=
 =?us-ascii?Q?8k4sY2Lr85/zi78XlsS+ByPBA9S4S/Ekhs3S60+mzABN5jeLWygw7rqz9yLS?=
 =?us-ascii?Q?EhG86ci1skf9DK6TnNoScR4H26U4HclB7uKNGGaT0zkMDGZH1izxFtm88PF4?=
 =?us-ascii?Q?SKzqUKAi/MSKtNYLKJe75Wfq39/6+BIaNjw7cwCHdl/VhVRQ55eO5V8gvWTQ?=
 =?us-ascii?Q?NkmkqetxBoUMmTOS4ZYxZwm1?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB4972.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5459e6c-6371-4e89-c41e-08d925242d60
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2021 17:39:15.9103 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ynBTcmyMLGuLbapYweGg8+ZopI6aZHN8aqkmc0E4HpmkfG27F5ej2pJAxhk0cRauoAznB1KA0HGduxgAjorISe5eIPGktPJYnhZVAMiEs30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6427
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210601_103920_884176_FE95329D 
X-CRM114-Status: GOOD (  11.91  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 5/26/21 10:10, Hannes Reinecke wrote:
> The queue count is increased in nvme_loop_init_io_queues(), so we
> need to reset it to 1 at the end of nvme_loop_destroy_io_queues().
> Otherwise the function is not re-entrant safe, and crash will happen
> during concurrent reset and remove calls.
>
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
