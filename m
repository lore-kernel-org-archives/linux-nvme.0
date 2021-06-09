Return-Path: <SRS0=Wy35=LD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A412CC48BCF
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 09:43:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77C5161073
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 09:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77C5161073
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=JRpN+7QzjkHMIBtViCIUCmlAaJrS6aBEu1F94CbQqGM=; b=izQTDJ4CjcMizK
	ADI6Modw9fjTruqhmysLsP8fHuV+TpoXkUwiGo7w9bCq+r5UIB2T8PM0g6mID2rKn7XLki7Q8QDoD
	dDcLeN7mmRDPVKXyHEhNesyOJzUZao91TmcZWpw6W10taPcP49mfS+33uGJn59MxYQ+KKzuuDKbkC
	n4PACUbqU5vO894nWKsXsoUUiGwBgzBG2nfS9FBRByxSL+xM0ZgSBdfWlfmqqbvSN4hechjhDw8az
	aQDme8CZm5Brx87JidjuqZa0NiPesq1lFpp29rvLw236Hb8g+7c0iqAQFH6e3dKo+6mH88dSkHS8A
	VbagrwcVcLOi3nW8aWPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lquk7-00ClSf-JO; Wed, 09 Jun 2021 09:43:23 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lquZx-00Cha7-5g
 for linux-nvme@lists.infradead.org; Wed, 09 Jun 2021 09:32:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623231173; x=1654767173;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=kdZBCRM069vrVGgXQZ9Q902H1GHqQHqiQV13HUKU2gQ=;
 b=gMo8wCxYmIXaZlXQ3tYsriUs/w4gs2LRYtBidu7Y9o8JEInXHx73zPVE
 7ld+EYvYVPPQ2N7glyRQwPc9n6OVj2y2XIniFPCli0JcE0rCRPTvl1ObL
 sKUYhWeYBaNJP0nSWutBYnFAUDN/UhzenfD0azSLb/WCQ/0lzVoFyiEXl
 nbtP6wt9sNNpJCQQT9dTCraD7tfTARhUB0oTeEpbNUF8OsJ4qfQ4ygpl+
 uduC1Aw8Xn2fz9qU3Ux81AlCmJ+yEkkx/GXFqG8yj1sYsAmQdavYKxEPm
 8+IkbmMsa2hv09AqyKYFENo+Wx6nl9+kTxgrNB5CjsFqMR+aQKLp/juML A==;
IronPort-SDR: BgS9KlYthAgYHqO4R/OuHiqnjTlckd3QZq0kmqIvW5Vjy/EiLZKumlKFMiDhYl61/kwlvqW6Xr
 Fju2I9ruNr3KF4vzN8RaG2QN90XYyvHFG9zjcTGEZNzNT3JVJl6kQpa5S/NsijmQD6aqgoJC/R
 QmEczsVFD4nd43bYIcC4Ser0bNdJp90AD8U8abQ0aZN84b4LBi7Bh0IxDy3ZV6PSoz1mT0Nbsr
 asw2nRI4isa1ec7YWm/49ED475AKd+YaKMla7WcE1Mw5k/Vfh/UHl4iFK6LHLH8w04WDqbQG8M
 Q20=
X-IronPort-AV: E=Sophos;i="5.83,260,1616428800"; d="scan'208";a="170560281"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
 by ob1.hgst.iphmx.com with ESMTP; 09 Jun 2021 17:32:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvvQyR+lrtRSraBuJ0H0H1jWaXVWBzHDwo08sI4mXA8f8iQ3Ps6kwZWgEHvBywYBd5Mc2thhCAn/w0CwZZiZTcbxFsxKm7i+k+80SLjHkQOcSfPm4b+1BM4mHp1GtVcJmZPFVSTrtD/bLgI2RdLy8D2mKVD6isV05z2WqEu5jJobFVL9ev0i1goBm/5AWy7YtL7Pxywk/P+rnTsUPebFnz2g4PsvU+h0WKYRKOlyEwFN39MFoKrzOeINcvWW9tK+8PElG71Y9SB3O99indMztBN2VmPSKFK0uUB466ru8Lki92Ket3t+MPyPdFN6BNCyIrnvB7pOhh18jJgekozM9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWvhRuM/sMCsxrhZ31kCF7Km2X5bV11CMwIOggvSXWw=;
 b=IlA2l6U3fDjlaIeQ0oCeaX9zZxlabAMCXDE49xKSmjue7QQqY+tboPxjrmF6mmvywtV/j/SJnSaajGE7/g7UaYO0OhPfKX7w5dJMtBdRqSmv5KA4LWwxxnuH8cTpLO1mk7k+4Mt+hwfZlupYEtzrOOJqhZSfZ7GdJFhGyvukHtqsIMmfEtANLD55xCkBADbo1Sy1unZKQjnJhT2DCud55jbZZXpezrb+1QpEPGHkQ6/rrN8IXoW2oB7E3UVLWQhOu4q/G7aDr8hhrTiMC9OISC9fpWkG+l673VPbFM7/PcyEMfHEu9xrnViFBmPV0hwzyrLrBiyD1zUb8O3X89yfNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWvhRuM/sMCsxrhZ31kCF7Km2X5bV11CMwIOggvSXWw=;
 b=FXm4jjvKGeDwl1A1K/Z9Ix1KeaQSq04NCCi4E+vTsEHKThThljSu4OaYEWKenLryfeUmwBqXSnv7YyHs0N8BTrDmCDhYIpYfynhqbYrjHjp1t4gNOFaVqVpC1yn2ELDR7vF8ZYuwww1XODxIo/JGPTomCBH22+ATGWwbuEUJzmM=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB6606.namprd04.prod.outlook.com (2603:10b6:5:1b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Wed, 9 Jun
 2021 09:32:50 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 09:32:50 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 3/5] nvmet: add nvmet_req_bio put helper for backends
Thread-Topic: [PATCH 3/5] nvmet: add nvmet_req_bio put helper for backends
Thread-Index: AQHXXCm/84io6W03a0aG2gXQXu3ODg==
Date: Wed, 9 Jun 2021 09:32:50 +0000
Message-ID: <DM6PR04MB7081F255F299A6359A3ECDDCE7369@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210608054635.5661-1-chaitanya.kulkarni@wdc.com>
 <20210608054635.5661-4-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:513e:a3fe:98aa:a7ae]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5fc257c9-be38-435e-dfbc-08d92b298cb2
x-ms-traffictypediagnostic: DM6PR04MB6606:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB6606C35FBF8C9C80D95CFDE0E7369@DM6PR04MB6606.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v8QayAcZf6e+7Poe3ExWd9Uyd0iLL/89Vv6ZOIIdW34sXAOgPZMKBB4F3BN+lc3ur1XZk88dfizt167nKUjrPfO897DNMgxrVmHxQdSPn0BhCKTuLn96sqUm6WPlptH34Qjz9/tbKkXNnr1XxZEhCVUihjnGrqddmmkAmIqtaQu3mFoKokmIJwnojrrKmHGqaSycyeCAA/nq9YkeNuApd2Sf8yNjfPyrW+i3ktfpbwUrcQQWfUYHl5OvdaYulgc+C34SK1hBjcHGDabdooeFBiwNgZFxmAaolIMYur4FV32RsaJ/qkXlwObYdzWqEaAhqg92pqx0hGbX7EAuZwSFNj7xvSA4WwX061Ok2aHZtO2l8HTokFu4IxIV5TOzmKrkFKSGV5OdTw+F32YOR7NBPGiLmtnFYpxlzZKub12pe7YFemT75fFFqLX3AoxakVZD1mTvz6bxDYGmP+5U08Bt1UctErOYQmnmjA7qBBBg4dg6J/IKfaAFpq8d9+kX7IbxtS6UkX3XyXdW50SXofIzLlUNuIJSZC+K7t8aePPj+FmU8DGNyEUpdnU+h0/YQPLgLFpjdP8p7jhiOT1Uk3M8YPTyqgnYaskPFZ742Hn/zWg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB7081.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(33656002)(8936002)(316002)(66946007)(71200400001)(66446008)(64756008)(55016002)(76116006)(186003)(66556008)(91956017)(478600001)(110136005)(86362001)(7696005)(5660300002)(4326008)(53546011)(2906002)(6506007)(52536014)(122000001)(9686003)(83380400001)(38100700002)(66476007)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3HFl5tpF37mwg1wtusv9HYyC+h2TG0f3L60XgFZFcX1SMKRsSkr+CfAkXj1t?=
 =?us-ascii?Q?CEaSZxIZAlKQmpwGYRBiJXHdSe4ujbebmzFLUUg60f052ibPNL4gS1u+7jNb?=
 =?us-ascii?Q?eNEpk5H9PX9MTEpMo7DNQz2VYs5wf+7FeWSKo61DgwDX8A9x5Bi88aHUdHSh?=
 =?us-ascii?Q?CQmFVaBx+MbgUc5XxRMEzxBfhuv8JN9NUKyTpr1CsOYWHeVFFIPK+cp1VpzV?=
 =?us-ascii?Q?DFhDyf0HfgluHSNGyQvQGCnBhxYSad3PD91dOeOOAMASylM4n0FYa6c80lrj?=
 =?us-ascii?Q?PBx1/yD0dMrvaeuqlDN5oNrb/frY5raI/r77MrChWsegidPQOLnKuXrJ0bPq?=
 =?us-ascii?Q?iTQ6tJ6bSSaEGo1e9dSpvR9LC2LDSmjHQYumfT0myIGuazYHkBiD7+TzPQoc?=
 =?us-ascii?Q?Is/W6lPAHqRmksEucj0J21TG2mCbRf6pOahpX91dDEEaj/u6WSUQ8PIA/GKc?=
 =?us-ascii?Q?8cjUrxIa+WFqRqvFIa5pEyteI4+Fkdx1+i26AtKdLvcZtqTNvnCxt/m4QIIw?=
 =?us-ascii?Q?sHpimoqkVbwGoExOvHUyHSXGfc+qOr3SD4wtPa4oeh8JtpbpZPrWzc+pTRnG?=
 =?us-ascii?Q?D6VyRSvxA3xS9FhnxsmiLxrj9Gkh/vVT31HgZTytWgbN7tCNflKfjDcluy4z?=
 =?us-ascii?Q?E2IbGg5m//zcBP8jwtgIte8NxfUdquobzwDma7DkIVrPkFT9L8+yBwoxbF2v?=
 =?us-ascii?Q?3fDjfc0v0ABtfiCFK9dNyUWI3feDG8SVthC9wWvfZVdBid1agQIU0Fwi4sjr?=
 =?us-ascii?Q?Ian83fpG3A7TJpbEddUPE13anxg/32zEflIwf7JBnyt+rEXW9UOpCt9fT2uC?=
 =?us-ascii?Q?QFnFg8BrttCu6QItuxOumr4tNimOeGqXwFzlJeBFpmzdPKwDusiYdDYr9YiQ?=
 =?us-ascii?Q?EtaM4uumNH/UbDxE9tnz0mAm4HTilc+3DfMkkN/qHu7InrotSR/6CPDZ6fjx?=
 =?us-ascii?Q?5ovHkeFWwC8L2ZXBi62MTHbNTf+PTFplvFPbmZ26MIjmrExnSNr4AJbGSTGf?=
 =?us-ascii?Q?v1E302lz7TkpVVDv9ouWV8EiFDF0cIcNaT1qVPHHy1qq2y3HaiYqonzfHAAL?=
 =?us-ascii?Q?miVxUk0K8zBy7nxNkxjhYpJPpIIL8/+VTYr/0W4Em1MYQ5OiSlO0mS2bc2eB?=
 =?us-ascii?Q?l7LXtsojLV3Dav1dPxuX6TMnSNklvRLQYSSqjt/yMVWm+0zBewVA2guTMf8A?=
 =?us-ascii?Q?ZCXtGEgoONis4xdXe5+Q9Rr3CsinXknP1XTHOKaVewBWsCufhobi3FVx9d86?=
 =?us-ascii?Q?RH8HmhXjOsB9MwmmGBoHLj+IM7p+UUwygNl5UnBwztVe9/s5dZjNE4Cw6E2l?=
 =?us-ascii?Q?IOs5gzpFK9q2tLoxr+LHEwRWwuDwF4XAVu3efbiW0PafJeo7W/JyYi8ucx6J?=
 =?us-ascii?Q?4rAd77YdWKaFrvxJsQCK8lSL9Zc0vmLwti2aIvwZUc5EGgqZNg=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc257c9-be38-435e-dfbc-08d92b298cb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 09:32:50.2657 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oMpGKkxl1fg3JfIAb4tDE2fGu7mUmDyk1s7T0qZmwkXbss+NUYlqeZHfWZDKgoeQA6rfYvkHcV9W3MdR25v2Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6606
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210609_023253_389637_9C5BDAC1 
X-CRM114-Status: GOOD (  20.02  )
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

On 2021/06/08 14:47, Chaitanya Kulkarni wrote:
> In current code there exists two backends which are using inline bio
> optimization, that adds a duplicate code for freeing the bio.
> 
> For Zoned Block Device backend we also use the same optimzation and it
> will lead to having duplicate code in the three backends: generic
> bdev, passsthru, and generic zns.
> 
> Add a helper function to avoid duplicate code and update the respective
> backends.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  drivers/nvme/target/io-cmd-bdev.c | 3 +--
>  drivers/nvme/target/nvmet.h       | 6 ++++++
>  drivers/nvme/target/passthru.c    | 3 +--
>  3 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
> index f673679d258a..40534d9a86d1 100644
> --- a/drivers/nvme/target/io-cmd-bdev.c
> +++ b/drivers/nvme/target/io-cmd-bdev.c
> @@ -164,8 +164,7 @@ static void nvmet_bio_done(struct bio *bio)
>  	struct nvmet_req *req = bio->bi_private;
>  
>  	nvmet_req_complete(req, blk_to_nvme_status(req, bio->bi_status));
> -	if (bio != &req->b.inline_bio)
> -		bio_put(bio);
> +	nvmet_req_bio_put(req, bio);
>  }
>  
>  #ifdef CONFIG_BLK_DEV_INTEGRITY
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 058b6d3d48fa..a7d035be9f13 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -630,4 +630,10 @@ static inline void nvmet_req_cns_error_complete(struct nvmet_req *req)
>  	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
>  }
>  
> +static inline void nvmet_req_bio_put(struct nvmet_req *req, struct bio *bio)
> +{
> +	if (bio != &req->b.inline_bio)
> +		bio_put(bio);
> +}
> +
>  #endif /* _NVMET_H */
> diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
> index 39b1473f7204..fced52de33ce 100644
> --- a/drivers/nvme/target/passthru.c
> +++ b/drivers/nvme/target/passthru.c
> @@ -206,8 +206,7 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
>  	for_each_sg(req->sg, sg, req->sg_cnt, i) {
>  		if (bio_add_pc_page(rq->q, bio, sg_page(sg), sg->length,
>  				    sg->offset) < sg->length) {
> -			if (bio != &req->p.inline_bio)
> -				bio_put(bio);
> +			nvmet_req_bio_put(req, bio);
>  			return -EINVAL;
>  		}
>  	}
> 

Looks good.

Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
