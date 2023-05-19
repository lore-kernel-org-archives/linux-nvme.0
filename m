Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8955C77B7A
	for <linux-nvme@archiver.kernel.org>; Fri, 19 May 2023 01:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8tuIGEAR4OXYEfmoVoNEiNaFQ6p+5JPNK34sOszG+fc=; b=1+e8a25NELIYxGwrR/YjikxVQA
	y9learZQ4cqDhaHUjkTDujrLKQlrxb3wgU9mBShF08RywfqA5WZirlgZMfesPEnjxgJSThmim7ocK
	7cFaECjQVmP3stHQFKjt4kse35MAfZL2XDcDgtDwdNJ+GEGFEMrrfeSGfejZ+gwyQD52EpD+01xwu
	xLopw1wQ0ZBGwCaiO7v3Y+RtCqfYRjQ2QQq0TapTImeI0VKfSCirxf2N+YRuH9neC9cNdaFIXEYWO
	LOcqf6w8K+W4ESMq+CX2VYRcQYSGXVcQc7If/jUDbbK1sroJRsk1VB4IJ1k9wKsptb04WgutBOaZ4
	xK0Lpsrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzp2g-00EhDX-23;
	Fri, 19 May 2023 01:36:26 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzp2d-00EhCP-2H
	for linux-nvme@lists.infradead.org;
	Fri, 19 May 2023 01:36:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1684460183; x=1715996183;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8tuIGEAR4OXYEfmoVoNEiNaFQ6p+5JPNK34sOszG+fc=;
  b=KGdxc5DJjbOqOBmd456uImcU63bq+7wZMG70RD6gNH2WDD4qCj063McH
   cHP2rCABTjehS8NR5n/otnsIqOGz2jWJG/9dpTxv951eUkMqTgFo/Z0/B
   SX9f/lHp4b7MLtEOqDs7FwFSGVKIGksX+VyOeG+Xkgxg2B4kKpi/klS9E
   /atJw4rxMQRV9R1ueird97U20c4eebD3nxSh900LbZ5vAJETbo9EzvOro
   bkM0c3qdlndZP/mLrHB/xe/Xbbx69bZUkzXPsKpEUL4924kud8OGGBGKd
   Gxb/QmRMQDb67Kh2uOBJ2XiE+vkBIboP+11syU2hRkGtUH3yGV6OEr/5/
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,175,1681142400"; 
   d="scan'208";a="343203732"
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2023 09:36:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JgSTmOtg2mqihfXWkJSxXS5Af0dpkro7HRydii+PUk+wy/6XTb/QKs0qdLzRJzZ8yivo/y8HEu1323YsJLfpHe7h4GOE0M6SWaHZxPiIp6y00h3hAe7ZhRYeRkBovVpEswB9RzBTkLTtZsOXVLqoaZ3lHLQmu+dq8fGX0RqiwMgjD+rkyTZ48ZGqlo0Yd+WCBKt59Mh+22kfA09/3Z8OpbZTMOd39O0rSREn97wVLzJcxazIsD0/nY/Ihipv1NUVyKsLztKmxwex7v9m3mj4ydjXPin0g0dMHIeUxto5r9ESjUaQkIfzdQpxK9OkuOkHpUvrhZRF5LdoBz5uYbIWPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tuIGEAR4OXYEfmoVoNEiNaFQ6p+5JPNK34sOszG+fc=;
 b=hpeZjjcFGPHOtN3mhum8kYYf19JXJClcmbsiHBvwT0bNlKs60+oHpMbLHTY4bProUhcT5PvImTtfU6Ho6q2EYMiekU3dH5q6eA/4JPdpPQVHMhXs70XXgPS3wUvvP3qSXhertFLI550N742jJH14NqwCtggkTAyVgyo5A3+IueDV+ISJrDzyvUAiNWaEJSnSABWA62orv1yRZNYPQFsDfPMJAmVsKg1bqPHYr0Cd7diB+m1C5FzprwpB3mYZRinRW4JTVpGRrf1phcukSOh6eM6I+6Fi2+7+WM/XmqRZ4KRWlfys58DDbReCCcvkdkQ+couFgneNUDmALnYWXWmRVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tuIGEAR4OXYEfmoVoNEiNaFQ6p+5JPNK34sOszG+fc=;
 b=oZ98yfzSfw9S1/Wg2N7gT4zTYsCVYOihK5unq2Wej0/zL2z7UCvp+Log0FsZA0dSMEvV1dl8jYyONVyROlHMU3OFxw7Z/EVM79tTh5Jr1cSQPBSXJb/uQEHP3B3aTO21RB6NLRa/Vi4qtDty9eNai78d4jGId7pkKAKQWbQsxPk=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB6715.namprd04.prod.outlook.com (2603:10b6:5:24a::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.19; Fri, 19 May 2023 01:36:17 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%7]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 01:36:17 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: Daniel Wagner <dwagner@suse.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Shin'ichiro Kawasaki
	<shinichiro@fastmail.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v4 09/11] nvme{045,047}: Calculate IO size for
 random fio jobs
Thread-Topic: [PATCH blktests v4 09/11] nvme{045,047}: Calculate IO size for
 random fio jobs
Thread-Index: AQHZifJME1vyQKMTO0m9RnQtffwKQg==
Date: Fri, 19 May 2023 01:36:17 +0000
Message-ID: <5duh22ydzwth2z2sd4oo22cuaqlazxq3u5m7vo5qfkp4fgec7w@elzdr6vbksgv>
References: <20230511140953.17609-1-dwagner@suse.de>
 <20230511140953.17609-10-dwagner@suse.de>
 <c5c2af7c-2b63-f30d-f568-c136dd6f6c5c@nvidia.com>
In-Reply-To: <c5c2af7c-2b63-f30d-f568-c136dd6f6c5c@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM6PR04MB6715:EE_
x-ms-office365-filtering-correlation-id: b92cab8a-cd5c-4fd8-de56-08db580970b1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  U049zsciaNDpMzN1oS91brW8ePKF5ftCuL9qPoV0BpdDUnI/K8FrZtfYopADcTuCQ1Miwp9FVsgZwfH6BXPuK3egAczBALKbdU5bWauC8Rj6E4S7WUxPiFMUu39TChLPtnfM5nHcnjyP8ulurZpnyDLRM8OEULoM7kGJyQ1o4oXMyk6hlM17GLikD0XwfI03CexegLCOHeFW35R3zmajgYMmoTPP3OBEA37Uad5nK50xcE3nJqZkbRRzAyMmSg2wb1HZRpknp5VMECJTjBmpVd0Z+2lZdtmhm+fXiGHdqMo4cvzkaM7xB4VICimCFgnZdOplOWsxh1u+0+Bi5VnVLvILdYHpKKzuBYq/ydr44FzXg4JwD1/SRh3c285xKZj8cPFEwgSrnLUY5XIG20pgcr/ArPF19ucFdbMD+VMR7/CcPyts35D/BeoVBWL4SAh231KU+m5JOY/lPx71B7ChbhcCJeYO91kGcxlSNA41FlRvU/GYt35tDUvHFO007tikhfmc25bh2JPJejJrw3djHLNPrunNXvFIda+d0SZArCdea9vZvXgFyYU6F2smQTn/T1F6EH9gTKz0SbqkN+kIkY2BsgHgZSEHmNUDLBXIkPsAgd14S4/KgvkA8wllL/8K
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199021)(26005)(6512007)(6506007)(9686003)(53546011)(122000001)(86362001)(38070700005)(186003)(38100700002)(82960400001)(33716001)(54906003)(6486002)(44832011)(478600001)(2906002)(316002)(6916009)(4326008)(8936002)(8676002)(41300700001)(5660300002)(91956017)(66476007)(66446008)(64756008)(76116006)(66946007)(66556008)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?cuvy+PAvKwwuHxRni13WnSWvodY4PGEQPRZ7uvRYqY/PWXIO9LxS/kcD5+gm?=
 =?us-ascii?Q?HjHTO2CEfiYaQ1RUXGqPT5KE8M191TAtvOdJ1Yx7MjAFtQWXVE+OGG4aaUTm?=
 =?us-ascii?Q?/GP+b5I+LI8eSzkurDx56skFj6Imj+SJiWd0iJ3UFUkwyID2I89gj8fJbb5v?=
 =?us-ascii?Q?4qeZE9vC3UeRkydBTc5kt/AQLJzex0pLpBvqLFjiHRepm1q7Zbb3m7hgyDWL?=
 =?us-ascii?Q?g5eDloHapCkg8dK9K/SmbhjiuS7/xvswcc75xoeA1m7byGoRfa3pFvt8hRed?=
 =?us-ascii?Q?d6xRdkuCCNIx1vZ3ibLCQw4/VcuL3JOn/pzwHP/axtwgw4PnDzuS6TuzSRou?=
 =?us-ascii?Q?9FJ9t+rdH9CsKYsIF4spSlLt78iABQu4D6xKFmV6n91gI2N1d7RQjZbLrwYz?=
 =?us-ascii?Q?KuVmGOMBx/t6+xlJXsxFuGc2jLBLh4OSfRwMgfNi8RPCnVKcq4KHeA3uEUpo?=
 =?us-ascii?Q?Hb3PRknmr/fOz85YLxwQJCaeFDiouaTlSexrKisKsw0fnzmmRTNfD6G+9d9I?=
 =?us-ascii?Q?EBUuoQtg9yo+0TtV9s6V2h4hSLacLzNq95LZLNBNuIpr3P4+uTWI/q3XDeJ2?=
 =?us-ascii?Q?lMD4ZX/V854gyTNuXbBaO1DkNE/DOUfD4YuBAhLM440GndCuSjo2Fwg4khk3?=
 =?us-ascii?Q?XnuL/aUErnEEtEFqQUtDiMxylPr63Bdu2lFQ03jRXLe7jbzBan44J+4xyJ6j?=
 =?us-ascii?Q?tTsIhsny8jKkCky/wBoM0E8Bn+MpKEHLgLhPi9Jg7oLqcH2TI1WLTru7ZN+u?=
 =?us-ascii?Q?YbcySi8FIlJq3/qDmeQsTcLkuq+3419ffhDVJmXJWDFIi7fs2Y3Owo0ozmRF?=
 =?us-ascii?Q?T3VT41aOQALEpzLEgDEA7EYxR8EeWKH0knNFd3MMoGXOjg/ljvZNm99Gyg1h?=
 =?us-ascii?Q?IJ/lEWCspp0+PAIuP+ndlcoyRxZ+zUFRi+bqC4xL7bAwvcCBj0Q5t3hmeSpt?=
 =?us-ascii?Q?eYg1vpbwHGPFUns89bCE8YFfeu4ecQ0q6rq+ygUkXYDFeEwKXcknr2v0yyjX?=
 =?us-ascii?Q?tsLC3TtVjgHw6t/CS4dTtRzcgO9p/ZwoC6gisKl2mbL3J6g+F9iCbMoEXZz1?=
 =?us-ascii?Q?/0GtXXi+Uh7TfkvhBFU6BnRn/oK+q7LyOtygWxBJfniNw6zhi9NARHN0D5K2?=
 =?us-ascii?Q?0SreraKlNlrIciXH7//wpnKu7K7ViE0SuGWVGveELUZeWNkMFmyaHs113FWT?=
 =?us-ascii?Q?qnDOLeNNiZ8bRbD3jplj/XAbUpcHCYcHqXN0TijDGwIkZ6Lpczlk4A7v4gVD?=
 =?us-ascii?Q?1bbUkONwUsG5KA39wIvF0Y2qmk7+zrmNR/YSrae6aW0l7lJ1Pg+UCids+NcP?=
 =?us-ascii?Q?0+1RgzQV5LQ7ocYPGoEssBAONf/4HERA+2xkO8Q7aTEWo9oaSusMYSKtvxQi?=
 =?us-ascii?Q?ysypfCdio8lQUwjHwoTfQKhkFuLp/kVwi6O9+X60T3wT/zEOjQk5W+u+aY0G?=
 =?us-ascii?Q?2Ul6bU86AmrebMwIY9TCuXHitxIBG4m4fzlIf6xK5AeLUMjKLjK1WU1MCkqe?=
 =?us-ascii?Q?KNmSJDkNKatDPKkNSd+mmUZYW8EJ4wQSRMFx1yAvje9rrZa6FwnlbSQxhfZP?=
 =?us-ascii?Q?COVilz/tCp5sRPr2JdsNhoff1y/kQ0dzvWOMlg0ZOgYAyTyzzaWI+gJYjWf/?=
 =?us-ascii?Q?IO0d4prQOCyC0tdr4yUu8K0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F0DFA4A43ACE9048804FE2612BC912E4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	hnZKrtTi4Zs2tCRfVb6KJHthy5oqbIb3wMgCKt3J2CYiPLE4FkulCGD3RcsPy7wKNB2DEzPT+NzYykt8a497RUf3EkZO8lFL1fyXuFWmmzSmg9xzsyJ03EvLqjKGNeBpdHqRjijRp9cP1L6i97OQ0ACNyEIczzxy9DXcEjEShiC43Zm3BEdu7YBU/bWgWcSCrgC6l3l11bdB0egJyWf0q4apQbSYWLJljuhntbgIt9GvaNn5N+zkNDO3Ckz7zeh1xzcnUZqexeYv5jL022WNVPcIGyaLhpbprOQvkuc/iz/zlsyo7k6MlZ4LhOJuQgTQr8gp2oy+Im3tWJykEviSOQlknUo9NU3fjadN3pw6/z/1oQLmMVWZRTjLxLh0jjMfTpE5cuLm0udnrhrt3b8CSKdrXuI+hl9kVJLKWuGu6bfHaUAYldAzDj37T5gz1w6dyc2FhqzwL6JsW1NKLWmx9PpO7ISA/eB9uj5DSmXHyKAptvfhyU0bin9sArSalqz4Gg2n5xxB3AyHVD+xY2n1QZeXaoHf+HS90jqKmS0jg5zYdI+dOtleXJDBm7RWKlgpZUl4NnWTG4vAphI1akkm/RYI2ORQXzXqIcb4KWIK/dZ1/Iq+o/6dCzrUzgEzGdgvO7795a14gGqB1VGVkQWjScRcwlSiZg/YZpO6XpbumZ60DXO+oxhqWCq8W1+T7NjCj+fYGFYthjR7ZYyvi2P3Kzm7iE1TYcwhZMBo2qqzuJ4QCgnzKCM0D177/RWmsimRXJaRckFwakyjkzNU6O798uxEyN5KOnBY+YlHBvIFAz0hkDZeaaRYFDXINEmiYlW7KYWTBflvPlLrpUu0sMKivY5EsS6uiR1wPCp8ZNlKV15PYcR97iggquXnGkkdvmQWkvk4SrbxOk/Yk49H0WwJmSHXSsfrtAsx//EkWRydW2o=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b92cab8a-cd5c-4fd8-de56-08db580970b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 01:36:17.1647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2N/EVFPtFGFl6qi0Nh9+K8AGkouwRCC6oGhTpoD6rZ548ODtUE8i+PIr1L3a6U5hgzhTfjTA39MChMt4uIbxcyN+5Kj25sDCq/QiAnZuFro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6715
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230518_183623_869489_560B9518 
X-CRM114-Status: GOOD (  13.28  )
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

On May 17, 2023 / 04:44, Chaitanya Kulkarni wrote:
> On 5/11/23 07:09, Daniel Wagner wrote:
> > _nvme_calc_run_io_size() returns the jobs size for _run_fio_rand_io()
> > function. The jobs size is the size per job, thus we have to divide
> > through the number of CPUs.
>=20
> sorry I didn't understand why we have to divide through number of
> CPUs ? isn't tht will change the current job size of the test ?
>=20
> unless we are increasing somewhere which I missed it .

This change reduces the I/O size per job, but it keeps the total I/O size
regardless of the number of CPUs. This will keep test case runtime reasonab=
le
on systems with hundreds of CPUs.

As for the test case nvme/045, it tests re-authentication. I don't think it
requires total I/O size proportional to number of CPUs. As for the test cas=
e
nvme/047, it exercises different queue types (write queue and poll queue). =
Does
it require total I/O size proportional to number of CPUs? Daniel is the tes=
t
case author, and I guessed he is ok with the change.=

