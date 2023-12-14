Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F0FC4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Dec 2023 07:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DCsG4va59BodSwh79Ps8DOa/v0yjiEIwzIaKi+uumTM=; b=vts1uCMagg9is4u4Aa7kwXsIAX
	erxGLf5BGWdlTLsUedZN5f3SCpGK+APGpn7Dzsju3bPxkNhekWiED2lMt5pOQPJCsla0jHhF5iyK0
	74aXUx1qSIapH7jMNZvl/pwrNApIiipOPPIRogB9WyT6eMeuzR+s6TbQnYJ8EuarSSW1Qblm44Wke
	bYyP2RaurnURHo3gFsKOZGwzIGSNoJpAuV+m5xK0LtsXQsP0RWrR53dKwVyXGPuVHBw15kBOQ1pyD
	qxjg6KvCdgnqSl6FhBwwrJ1VhG2R++tHAn2khS5RZesW9HQ6mCRS9onKt/UUrBvbFZDZVPxVP55wN
	wTZa18gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDg8A-00H5Y6-1I;
	Thu, 14 Dec 2023 07:27:38 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDg87-00H5Wa-14
	for linux-nvme@lists.infradead.org;
	Thu, 14 Dec 2023 07:27:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702538855; x=1734074855;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=g7YFmTdnAOyRIUxwioZ0WqwjmkGf1CtbkAxBUc2KLBE=;
  b=l2c9kWNG4HXwv7/rt6fnmSfiqgCeEx90+790RWKmLZok/Jjna+WYZ5x3
   hAQD5pcKqQ9Vr7+5tfpmQTgwD4PzgikTdR/JsvTLySTPpZ5HGT0SNgeQq
   2mbz2fmDdIlL7aqckVXZQgEzF6tL9RbX5a+DCcOmgLbBaFDYwuDK+QimA
   M64yvkrwux90nbmJ4BNIrFtjxfGjvkIfbhMruyoOZ2VgnAk1UeEYuGJT3
   5M1zDAO+jOScy9UrmxMVKP6mX0jbhLDWqOIEp+2tlNcrFEFD8HCPVs5nN
   5dnJKVXqQJifFa4X5XdRtpLz/qBWugwh01chtreFjscdiVTIN4UT8XS2W
   w==;
X-CSE-ConnectionGUID: ayeFiyMhStiWcIZLej0q6w==
X-CSE-MsgGUID: pH8NEWu+RH+Y715tybXEbQ==
X-IronPort-AV: E=Sophos;i="6.04,274,1695657600"; 
   d="scan'208";a="5121257"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 14 Dec 2023 15:27:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCFL0/Zi/7WKXHsFNzLbKOZ12hwJNOpH147XmwYKRxvov6bfcvB9FGJa5I/G/aCixZb7ySYnBt3NlUurktLjeuzWSp0u/6caDWY5jpbBL6tMUxSX+95dhknSVeHZ3TfdqEKNNk9Hp0TejDPjFyVAFNAmykWQ9IcBy7iCTHJGy7+9DN6WO6zpbFgQn0PeguNnEL8d+YM3EUkiZyLFSbHheiq+wugvojQStRw6O8qUrUloeBOVjw3APvKuHLimOa5DGobGVPsyu3Oyoxm7GqkObkn4pzVpT69pkkfCMLnRKJJjMjtxrk1e6zBcWZXkFtaGe0/XzLOiQT1S0TN0GR1Ftw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCsG4va59BodSwh79Ps8DOa/v0yjiEIwzIaKi+uumTM=;
 b=CLdoCc6IyQxwrLruHpUK+9spMFflp+r2IjMYaiHRMiUd0IWYPhkfQLic1hOsemsjMa0Hn0fQtUzck5mlzqRMIgB3poQMreegQ2WDK/FS/qnCnpNRSPIfNB07PamMF7ibYenmDbSrQLzo3ZV9k3aFEEDSMwfQBKB7NAeg+XKlVEtGMLQgT/Jsr1ST6ex0Nnkxey6taQ29RUQjwVAMwMDAJSh5wtLbni+aXm4teS8BZnqUMG0fdo1Y0f43DSwoBaYbCMEK30stAbbmgBeR3Wl104DhKanANzL4NQ2pP7JB4Ps4o3BSQhbHSoErjPcZIANOQGAO/aHJrfzyunNJIG1Geg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCsG4va59BodSwh79Ps8DOa/v0yjiEIwzIaKi+uumTM=;
 b=HtqcItc3/GTfhL5IIMxVdvuGoIci9eptyjmzTz1xZW70eN/86kMEmCHoOLLzfYqvwOZ4Qdb2pDlXwZbYza96NsUn97IlWgftHIQxNQTp1hQpAAGeLTKZsuRrO+uvMkWD1/32G8+/+kuUWDmDdqD2RMA6RO41G/T8J70tcsH9Blw=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB7318.namprd04.prod.outlook.com (2603:10b6:510:19::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.28; Thu, 14 Dec 2023 07:27:31 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4%3]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 07:27:31 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith
 Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, "hch@infradead.org"
	<hch@infradead.org>
Subject: Re: [PATCH RFC] nvme: avoid deadlock warning in sync_io_queues() path
Thread-Topic: [PATCH RFC] nvme: avoid deadlock warning in sync_io_queues()
 path
Thread-Index: AQHaLYOjNfw0Ane5p0Odq6QPPeHRPbCnLiSAgAAWToCAAR6EAA==
Date: Thu, 14 Dec 2023 07:27:31 +0000
Message-ID: <3yxk7pyfvd576hgq5aoxwpqbfsvva4jeialmpqbtl6us7p47hp@mz56rdemll7e>
References: <20231213051704.783490-1-shinichiro.kawasaki@wdc.com>
 <e286d88f-5006-4878-a05b-a0c877ef78d0@grimberg.me>
 <97a36f84-3004-4af3-a04f-841c9fa8a8a4@grimberg.me>
In-Reply-To: <97a36f84-3004-4af3-a04f-841c9fa8a8a4@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH0PR04MB7318:EE_
x-ms-office365-filtering-correlation-id: 370903d5-988e-43db-1c24-08dbfc762266
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KbPBTURQfePnwf/U4PTeZZjoL68nhjenSjawLzGWwt9oMItFxb0ZAApjRPfKtNpVQpRWy4LXgvepK7p3dHMQ25kfBR8B/pmN0tufJHVsDmT/fPZXcBwp99i8n/oj0hpZ2OJfypC305SWHxdV37d2JZcwEYBZr438nWPH6x4IzD06rWLnZppCyNd6Z8JiXxOSU3vscJWUCt1Lp2L97UC6KB/jv1iU2pziMvqC/rcju5kCu/EfoICWM+oeXvNXy5+gMhEY7W8RGwPfPJPKNc6RGqTyyIKhRtQml9kog9qs2el+WsOxi8TIS53FILObSGG7eYOgXLk4nCE1UAnPf3Z4NMhDC+NSKaZ0lEUGUpTyhlZZSOh9FBila/K1wh0Fkot/mv22QRO0MxwvR2Hl67/K8YRw54reX4mehYo5ubUzW9GANufsDmV3TwRc5HBlMeUpp52/eSBsronWEn+EphrIefjLfyRLKYADKZKsKHO0MO6aMaYwEm7JzTLJjxQ+WoxPloMAZQgtHeQpQdUoHuoCCtmluPJJodN3GPqMYjAYuLCeIo6+/tRda1xEZ0HoLml/w/V/UKNQq+v8C+tlLJNtwaUyZ509fcdjM0LoPNWitNwY1vKsVFjKA7wEfsB3zAzREATl04Vq1LodmunB7OIryahlUxvSZwtKGAzFw/r+S8J8TL8FjYH+XCf+Cyy6YYv9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(366004)(376002)(396003)(346002)(230922051799003)(230273577357003)(230173577357003)(451199024)(186009)(64100799003)(1800799012)(4326008)(8936002)(8676002)(33716001)(82960400001)(122000001)(38100700002)(66899024)(5660300002)(44832011)(2906002)(966005)(6486002)(38070700009)(478600001)(26005)(6506007)(91956017)(9686003)(71200400001)(6512007)(86362001)(41300700001)(6916009)(316002)(76116006)(66446008)(64756008)(54906003)(66476007)(66556008)(66946007)(83380400001)(573474002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?00OMiya9l7vJRo7MsKhZjIDJc1j/Y0/ImntONFKrVtH1v9SWiZZQQDBU/3q/?=
 =?us-ascii?Q?/pDkgIJUmMzOsRsqttnLY+6pS4Z2Gg+a377Ssnm+6mx+gHfPK89lsflWDD8Q?=
 =?us-ascii?Q?y92DihOlzHzjXcu8sCHZg2SE/jPgyO642blTJv0cNjf0B0IolWj60DswuBJs?=
 =?us-ascii?Q?bDmxkjJzKXc+ptwAP0HAxxwH8VSI9q2CMKEGOGegGAhChQhf66dQZIH2U9Ee?=
 =?us-ascii?Q?Jea2CzDx7vddBhzfYHugQZGoPxIw+M7WDCo1Fm1KJ0Ihw84Pu7Kdsy/D8+ls?=
 =?us-ascii?Q?cbpEGFy0QzMLjnmQMiSfmirG1uE206IUr2wjvqT8Dc1cHEyBhqhzeHKaCXsO?=
 =?us-ascii?Q?l9uR0np+1HRxij1Ui8JtzzgeBwzdQ8BSo4WiqbFc5UnnQbBqWsfrb5ieFpiq?=
 =?us-ascii?Q?+0CDWRDr3kBlXcAuu7MNHcyVnzxaAr7MLSPVWN/xZnofnwG0VJzOmgdBY+Uf?=
 =?us-ascii?Q?7yEmCIKMl+emV7ODikzTJxtm1US29A125Vu/86hrZHyxWpXtbko4FiL90a7f?=
 =?us-ascii?Q?RHkBc+TvW1WS6l4thUvqhXUSfBbUDR+bcqI3Dglb1+SaVEsUPHVD5/u2Sk35?=
 =?us-ascii?Q?7/aBzGXCDiRaMDyL+TCO+xMxOI7huLBeiPRUY8RHrn/n3NIyffxLvHvEksEC?=
 =?us-ascii?Q?eSysX8e4aE8Lrz63DO/Zdgf7fkX4lS7memLFw6GSmWDafmBSrYJ3FCiu4KxU?=
 =?us-ascii?Q?I7q/V0Refo6fAbfyqJbcocxp04C6qjhVVvrnLMRXQlqP9Mw1k4jS/5WNIH4N?=
 =?us-ascii?Q?3CNxZsaDw1ujDVXlJu1opgObkKNUMci+QfsjgG7uC6fokufajU/bXpXrDQPc?=
 =?us-ascii?Q?82xmlo6FC2hsnyIzvpmAFe8IB+TvtNexhpm1zvzCX/TZ9bCHyWPEPIJLJjC4?=
 =?us-ascii?Q?26F9+YpRNusjQ7NEWZgkZsVjsPcO5zcyY2EAW4zTN4F3VctmsbgyVPM1v4Av?=
 =?us-ascii?Q?yga0hU5lC3HfST6QOFqYV1SOlNBTOO2+oyiNx5FvX9lhLzs7SjgKyq7ba3fA?=
 =?us-ascii?Q?MO+TzKsVJMjAwAcrKe77NxktcZKn9DwDjatWT39CfvhhmAatQ+zG1CIiPM8B?=
 =?us-ascii?Q?7vz3VnfNqiAEbkHCrZD1txVPpNfbKjzlNf9Xa+r4pNgtaR50m/Q1rMcfOP8F?=
 =?us-ascii?Q?Z2blplCkzctHJBRZt1TAQ/Fe9ppeimCXMNLWM5QLeOc7F0ut1lKnLmvgmsYG?=
 =?us-ascii?Q?PwQs7tgHc0br3rhjSYXvkC1gY+xXT6gU6bYKRLmjAYvNI3HbY3x2wRNk2Ahn?=
 =?us-ascii?Q?B8kF4n5aY8YgMUwONaeTD7GR/5KMDzkZEm6kLrzpT9504uybKIKQ/HVJkND9?=
 =?us-ascii?Q?0rRosqGa5LQryfM/aLigeIrHFsh7rCepKU8SLpzSz+f6+rWG1UqqBVi6j4d/?=
 =?us-ascii?Q?8CuNT/vNeenX8GM3k+LPtQBNLrVE3ChsplQEt+pgn70Md4twpW3U/3ViopQt?=
 =?us-ascii?Q?cWJDFFw9bZErjiGw/cPX5a2PBsgRpnd2eHDWMCvc098DRcCOiJraMQeDRUXI?=
 =?us-ascii?Q?EWhPg5G3A/9LxkLu0Qe2Fh6XGuUoDMAv1vZCtUT6Q216AXacpBtOumuHVSmX?=
 =?us-ascii?Q?8C8BNcYCvgdZwCvprCT97XTzXokZL1TFrDSREYVc78GGl0WcpO3vzY47q4YS?=
 =?us-ascii?Q?gf6aGoiJPo+VQCP8Htfm8xk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1489316AAA762446B5251A060AD0DFEF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: m0KApHoLj3VTnXfUGGU3FbsgKOY5VEpPnVgEEMl+nnZ4C3XisCUlempEOS3Y1Oq1qBL1U0ayLlr+8CE5yrXlvF7wKUMw2E4rjkNca38Fp6kNVbbLITx75BCFU/mMEPmbiaMqDgi3UjsjiLEuUrF+UbboFT4352KHuGoofvFIbYF8uvFo5mNgtp+Rx9848X811jYBqhEApt/Y6+6oWB1Muy/itG04mjh8bRmMAAYoI5m70renhUmekG9nfIdYDWJADhwCmM978mqXppiYXp23jlkvlMhGGIOXx71kkPkFwtCyO7nkmz4sDxGH6EIHdoPCHQfcPUhaV/SUfEivjCk8aJwTRndGuvkzbqif2h+0ME7c89gCAEeWpPGb4uuOpGRsQNAQauk6F+GbJFCitWRdlUiHSkVTJKRR3NNqGnxEMLzT2Yul0Odho4pdYjfCrCi3hwGDnD9dlmrnAYGscgSr3gwfdC11hkfDAjmZPuQzMXrVfsnrPBK3qyoZ+WJWao5hFWQjDbN7MCsRqOoEVO4oksZU83Mh57HD8gPGkM/lhjhIIDoaolY5beZv29nJbe3AnNjYdVIvHPwdW8K4LZdQ8J3AktAeUGAF4yHNz9OUpE0a3dxv7nfBtz1qDdUXsL0L
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 370903d5-988e-43db-1c24-08dbfc762266
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 07:27:31.6300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hc2i4G/vFbpYcrzLLdNssMC5SFMiqp4cV1/Z5/uywstkk+GNYpT5KBUGDmGQKhs4P10ZQdip/HUIqpR9vXENY+spfupByzF4cJSg+I7shsI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7318
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231213_232735_396124_39C5716C 
X-CRM114-Status: GOOD (  30.86  )
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

Thanks for the comments.

On Dec 13, 2023 / 16:22, Sagi Grimberg wrote:
>=20
> > > The commit c0feea594e05 ("workqueue: don't skip lockdep work dependen=
cy
> > > in cancel_work_sync()") restored a lockdep check and it triggered
> > > deadlock warning in sync_io_queues() path. This function locks
> > > namespaces_rwsem for read to traverse the namespace list and calls
> > > blk_sync_queue() for each namespace. blk_sync_queue() calls
> > > cancel_work_sync() to wait for nvme_timeout() completion which has pa=
ths
> > > to lock the namespaces_rwsem again for read. These two locks are both
> > > for read, but it can cause deadlock when another task has a lock for
> > > write. Hence, the deadlock warning was reported.
> > >=20
> > > To avoid the deadlock warning, guard the namespace list by SRCU in pl=
ace
> > > of the namespaces_rwsem. This avoids the deadlock by the two read loc=
ks
> > > since writes by other tasks do not stop the reads.
> >=20
> > Based on the report this is triggered from the pci shutdown code path?

No. I added a debug print in nvme_shutdown(), but it was not printed when
the lockdep is printed. The test case accesses directly to PCI register to
disable bus master. It just makes I/Os timeout, but does not call
nvme_shutdown().

> > I think the problem is that there is a dev disable running together
> > with a reset (driven from the timeout handler). Perhaps this should
> > be addressed.

Could you elaborate the sentence above? I find nvme_timeout() calls both
nvme_dev_disable() and nvme_try_sched_reset() for reset. Do you mean
nvme_timeout() should not call both the two functions?

> >=20
> > I don't think that making the namespaces lock an srcu helps us here.
>=20
> Just read the correspondence on the report. If this is just lockdep
> false positive, then I don't think we need to change the namespaces
> rwsem.
>=20
> Can't there be some annotation that we can do to teach lockdep that
> this one is a false positive?

I once suggested a simple trick by lockdep_off/on() in nvme_sync_io_queues(=
). It
suppresses the WARN, but was not welcomed [*].

  [*] https://lore.kernel.org/linux-block/63e14e00-e877-cb5a-a69a-ff44bed8b=
5a5@I-love.SAKURA.ne.jp/

Dynamic lockdep key can annotate locks if locks have multiple instances. I
tried it locally but it did not work. All three locks relevant to the lockd=
ep
WARN reported have single instance. So far, I have no other idea to annotat=
e the
lockdep.=

