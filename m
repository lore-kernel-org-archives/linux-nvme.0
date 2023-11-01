Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF75FC4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Nov 2023 12:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1bXsvSHqMrexjpSTHYB4Nul2Re01c1MFTbajx7tYY4w=; b=Tb9qnv/00lhYp6VinF/7DZVcVM
	RIosBRN8JYFd5aifuwAaWSllsqWY9PIc4wX+PYaWDs7BsjpChefI/xI/UtXLIMMrQD9+9+Rwv4LbI
	1eS2A8crexUgBCPW1fjs1qFTvUL4mKhWcQjDUUkrdF5RWgC/XVEp2Arljm54FfFjENECehLL1KIcG
	1aP6SckjImEzh0f7JZvq/MgYClgj5Fzs0NxiGggXgUrFcv7l4DN/thAaV1dgtbGyJ+txb2rA49Qz9
	IRxVOY8nsrY0pHTLzDtQuYsaDSDfAHy6HeOhntyQRZBaqKdIkAZ6hzVrbXOSqGRAIxyOx5MPXlIvo
	Z+VjVinw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qyAWs-007VuA-1z;
	Wed, 01 Nov 2023 12:41:02 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qyAWn-007VtR-1Q
	for linux-nvme@lists.infradead.org;
	Wed, 01 Nov 2023 12:41:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1698842457; x=1730378457;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1bXsvSHqMrexjpSTHYB4Nul2Re01c1MFTbajx7tYY4w=;
  b=jRR66kzevplWk/qRij2We7oCVfV4PfoLvttbXfgMArYn/LGrRSCJ83GT
   KJfzWpWaHBzaUvSpuLJrj1D41l6Xx0oB0n9TvmyyzOOaHSjm/Wo/3Aheb
   9yf77QNtR9pIvGK85hTKgEuKmAzf8zXs98UCGYoa5ebT0TVNtVax4xcmd
   nF31lMYaPUoY50hDn2x7geCCuVEcshpfdhLjygeU1asQ8MG9hGCSEaI3h
   IcHGueudgGSreJ2CjJcsjIqupmE/JWLuVZNHIMS3VT7UJ6gryztANfk1+
   FoD3E0byRl9Pakk2sIe8MoW3ZyPEohwp6nXh1ZByV09Lpq2j1lsFLrbSQ
   Q==;
X-CSE-ConnectionGUID: oGYTELpqTa6JMVhTwvqQOQ==
X-CSE-MsgGUID: ZSIYPSGZQ+WoxOB89YZDCQ==
X-IronPort-AV: E=Sophos;i="6.03,268,1694707200"; 
   d="scan'208";a="1227883"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 01 Nov 2023 20:40:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OU60p39XDjH4nC6X/JcBH53IwjcrYkl1o50MqkDuzrJWUssu5EO82KDzP6X9RFWkd/1oDrNpo704n9B4UTO8u8StlGZew7EyNCd7GH/o4SYlFViN3Ni5BrQFi8Ga02ZVokh7GWekGz5P/Uk4vIu6THqBnvtwsTg+9Y5M4sg0t2n9xruSXQccfv/T1chI6/7sZRyIHALsQE4Wfs//qWNdf9YwrCz9gIQuqZc3HnzdzDRfGF4DYfA2BzsdADOD1l7oYMQFhzYStiX/QX+mE4EtFl5UXwomgarl8coY8to2OW0oeTM6exNXctloTjBNKlaPEvgSCJ/t68iFBY+RvvkTeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bXsvSHqMrexjpSTHYB4Nul2Re01c1MFTbajx7tYY4w=;
 b=KxULsEXTGv2+hP7Hkld0m5oL1NzjQVFHGH7J+s37S+kcI/AAcgS17YwDf6Zy0gfFhZlu9bC18mVAu6knX/BF7haxVKaZVmlNllfucdOX1684kDkn8eE5phytLbLuehJhFPtRhHD42mIoGsYLZtXLylZYwlQLcxxDOnUVEQo277fhh/5+Bj9xknyxFdRJw52+khO+mEAGO8vYVjsh6qMftS1uyyvx8lDGLuYVxunnROdryoe4wlfD66iuFVVoNRSy/T1RuneqePGnSo94Tm8vk28lUItY6och38ZOoJNh5BUNw6aXyQFEveJHkNB/CoLD4BbM0V6NZlW0/IWOHMg6VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bXsvSHqMrexjpSTHYB4Nul2Re01c1MFTbajx7tYY4w=;
 b=PCWzWR+XdbrjQdS8sJB/wXu0b7L/IKqs5b/Nlz5Uzo6Y2Rbq2T1gTsR5LwCdPbraCaVCd8XPV9/jsxyF+rg2+yA/WIqhhQc0KOSBsjHPmCvDPOnxHoL6HStk6IXG0N1OlIXbHaO9if+cx9MF8xz8Cox7MIAeznQ8wSifsSlCmHQ=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH2PR04MB6506.namprd04.prod.outlook.com (2603:10b6:610:61::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.19; Wed, 1 Nov 2023 12:40:53 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2256:4ad2:cd2b:dc9e]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2256:4ad2:cd2b:dc9e%3]) with mapi id 15.20.6954.019; Wed, 1 Nov 2023
 12:40:53 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Hannes Reinecke <hare@suse.de>
CC: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith
 Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 0/2] nvmet: avoid circular locking warning
Thread-Topic: [PATCH 0/2] nvmet: avoid circular locking warning
Thread-Index: AQHaDMCmrQUNBMkMU0aK94UASGhifg==
Date: Wed, 1 Nov 2023 12:40:53 +0000
Message-ID: <g322tra3uz6qoxg277g6xz6uuguuqa4wgpcumfpeqdrevrhlsf@jug24npbgvmo>
References: <20231101103228.136570-1-hare@suse.de>
In-Reply-To: <20231101103228.136570-1-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH2PR04MB6506:EE_
x-ms-office365-filtering-correlation-id: 6cd82cb3-3948-4b07-78db-08dbdad7c990
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wymfefBuu7ksSYQ9NRqp5S5FaeTNTibNtrD5rQ3nHLHWu7BaPnkYxd96OCor+wd4puHWmIpVlJumtgOrravnbdhBnUP51HqeQdH+QUU4Gz9Wll0aCcuPcd4MBKve5OKOP1O7DmcD5AJ1wPkV4sbXLhzwtzOS8aaYqXx+EassqD2778VFjK+3iQJkIN1RCfYakpvhhlpHDwzdpWhW/hziO6wTQkjZbDvb9k1a2aWMWlZopFqPDzV4kMNx6nWNL62RqNWas/I2nN23fkMLfLbFwUl/Hpc4npeF/jednSwGcCbE35Dtlu4s2m8SZu2EDJWnCiZTqsu6rAKb9hTE8bH+mhxtSkdCAzijxT5WzOaib4NYqQLOOWEY5c2SE2JO20x2eDKe70Pmaww7fKgYl85Dd8y2xTHiQN2TsFSRuaBG4dsGVV/JmE7AhwysKj36lzSthSD/I6fdBkFzu2zbu1mOCtJxERD2SWZJnwC3twyiS6JdG+rI5Ibcb3g/ru7uhpkzv8HVh67HrFyzqXHeyoSMsI234uTW9kLz/XKeBsmcRLwYWJzTJUN0vRz3xYkNX0hMnVLpQLRdJQSQVY+tYy+5A8zH2UJwq5TtT5mUriVa2w5exdytbqekuLk+g4U8vqI2+rW+xSVGi9q8I6cfctkFwouHjLi+23Lp1CmwyHmiRpA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(39860400002)(376002)(396003)(366004)(230922051799003)(230173577357003)(230273577357003)(1800799009)(186009)(451199024)(64100799003)(6916009)(316002)(86362001)(4744005)(33716001)(2906002)(66476007)(38070700009)(83380400001)(64756008)(54906003)(26005)(76116006)(66446008)(66946007)(6506007)(478600001)(122000001)(41300700001)(6512007)(38100700002)(9686003)(44832011)(66556008)(8936002)(8676002)(71200400001)(91956017)(4326008)(82960400001)(6486002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NFrZZ8/hEWEjguIGqfWWAhQDr02pAOAGHB4dfd7cypBatNfirA+NB3MJVOsZ?=
 =?us-ascii?Q?B0UKTZWlZQbRlor/ZB1AH8A7kjh+bvGGP9iat7pKrs7xkrhKMePWLWCjqN/i?=
 =?us-ascii?Q?iCrPvKk1JtNWje5B1Y9vQUSfVxYltKoXUuAKs+0gp27mJfWknuTZhkOEYgEj?=
 =?us-ascii?Q?Ax7InIBUwUQOyS/hqrUY5OrMhOMQvRO5AznJqrKw99+X4I+OE5qggMOK78jX?=
 =?us-ascii?Q?tnnYkdU5kcta0bq9T4gqbm6AOkiaNnETC5pi4c4RAtsac3lD9CGGJfGL893i?=
 =?us-ascii?Q?/HtJDarPXLILMpRwHy77aqcm80np9xM0R4SjqjaxW3XGoyL01XS3f2gxvTOe?=
 =?us-ascii?Q?1oTnBiUn8zrU04+0trH/nXlFLUtXm9yCRuiGB6FZw1KqsRJKgy5XrilHrYP7?=
 =?us-ascii?Q?SkrmtVOyYO/5JlhqAG4N5Pb+81rjJeiFCLLvamig/74ks7G3sbVqFh6sab0A?=
 =?us-ascii?Q?Ryx0HKp20vpKaiFFhUIdDg/d6qlJhsCrbOVMjYDJ/9f3j7ml2Rjv8Fi7rqBD?=
 =?us-ascii?Q?7wf/w/ZDZOTt+k5ZymvdDsF5iYwyTynF9AbRYdyAWmCIlY4J3JZ6rL0zg4ir?=
 =?us-ascii?Q?PtaLcD08NvVWoGmfqWM/axNw6SCXbWx63N9AkmRdKD6Rva3ZxVBT7gA55Aie?=
 =?us-ascii?Q?Erg2dvfPOCzMyatGgkl+DUs5z35ueX7ARw5txSjbLmI1xSkIoWxXWJW+u95o?=
 =?us-ascii?Q?sjgy9HZsL9yxuFy9kvhiX/qj93BzZACdwW8OKBMa0vdtmdO5Xddd0bLYfht1?=
 =?us-ascii?Q?TCBku8xvaJveOdokaJ3mOQ7irtWOEglTB8+RB61F4hSu5Nmq/cI2nAD9YLyj?=
 =?us-ascii?Q?vBvW6tQc/lOr00dWZyqSg5AbqtcJtVRdfB8EnIWeqP8kWsK4DHhTZa6wb+sS?=
 =?us-ascii?Q?VbbsKutdQSDXUATJEjAqWBv6G2pxvyysb39bnAg8i8trZZ3Hn2Rcm/As9Pmb?=
 =?us-ascii?Q?3Ox88rO/GZNvBxkqMYzUUWzzDktTxaAmXmc8y+zjgUAxfIIhbKgcyLDHw22j?=
 =?us-ascii?Q?CQTqIV4E38rPz4fB0HqbxhUWU1KLxnZ6XRy+MRVMsmkVAhVtWUBslW4vh8jQ?=
 =?us-ascii?Q?ub6STsFgwnOazNdGrmr0YTnCLt8bPWTLCZZMU4MVjXPp5S+dEAvOn+RqhYuC?=
 =?us-ascii?Q?AawZUnbY+Yf7djw7tOJ2AAWf3Tox86ucFzM5jarl4F7oYKYBrww3lXV8tWKh?=
 =?us-ascii?Q?yhyoRudJ6G5EYA9mnru4aYnWlfTwYXX9nnK5Q9rLS8xNjTTIZR+4Axd6gN8h?=
 =?us-ascii?Q?VNNRNW/5UWTDuGo/U9OULhk6lHZSJaHDoGWqM7otVM+FJXqgcaqk8tGWA+qk?=
 =?us-ascii?Q?6NPb+whY6bpnKYUuTAvLgqeEETHyq7RatxbaabTQ0epwHcIf6/D97yKgab6J?=
 =?us-ascii?Q?8yiWL1QOMMQh0uKstroPjELfju/JnZ8lZLJReFbla6INuRXcO2qSANx13KMW?=
 =?us-ascii?Q?CWtSf0TzKjlh50GgeEXyzxtVW1kW1zTauadKfbd76/gJk3un/vI9d1hadrqz?=
 =?us-ascii?Q?2KnJWhklZS/S3kfB0yGT2UCh+vc9OIOKLVdAWEkxpkkloDn0eeRazdFZof+H?=
 =?us-ascii?Q?kpf86wqcwsR5ozWXOq8A1DtTgDnNW0woOMROEXeedTUixiUWK8TjTDnBfnAg?=
 =?us-ascii?Q?w24IoZf9jlw1RCOqOQf+WGQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <207EF5ED5A398B4091254D1992E4E960@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: F4zc1Ka71vl43X8s3X/5twBn1bFa6UVaaahoyYWhGMlm8V116ycBOPKKZq3SsR7IaFpN9xYkehGrZjCUknTLMDfQ+OrkGd+OasfOlRNr76YAmwCemR9JXIcZ+Xx0yRyR+Vjx3n2GNw7DhvlZikVaLULuN3IGzXz6IexP7aHbYpKj+l9yFLZtbN4iwpFKuc4YVANUmhE2vlu1Kbh+FdQ/+CoK8keYDsYhEQp5qOuEMazTIJXcxaDFgdMA5pHq7FMwx7bIXpjJJthPE06S7ttRBHoqQ306sow7a0adtwKkoL2PA61Uxvu12txfTTz+xyn59NP/IrMH0moZMuZWz3S07Fv0GFrPk+qWIzz8T4f0tXtIzPyGWaYNsO+H+Rh2UcC32vzIc2Q63OFn+1EOf/uEuNUKGLqWp1pKoDgzLtASYlUmMb/ivyIPam4R4xtlrwGa1O5FmOZFH/ua4gWt8fdYpOVUpJrZck9WQFL9HM/y4SkNSsKMIGCfco3aSKVLWtcwHuCKIVN2ZsCglZrA4XNEO0bkYl4XvgQY96rblnG6RjAYS9V8WqNTIkYGQweOLMb4fMtoBwQHbfCjq1nSEUDtKbHweBGA5ydmUDn9MTNqGsGZ8NH8EaQ3UKHWEJ204thd1l6L4PhalE2Z4z43pRoYZFMpXKoc/RfeyXbg4o87RnnR+ceNFdrjJR6yWf+lYaNsHgd/rX5bTUUPk+/qtRxnyV9fdih8wF2XP3ehmXDjSF3PCk7nOFrpEh0EJEr8MEZqR4D6+Tf/aeXoPWNBpnI69wYOk9kU66l8CDQlICjjrcvc5cmoeKDXtrhI0PRpdJfJuyz+7lpZLgUN+RBmyYFZTYhqN7CDmQEa0ZRnMTqfog5A8e1bW7oIZ2AQ4LNiWGrsmConBI29bTy9zdL0z6po/A==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd82cb3-3948-4b07-78db-08dbdad7c990
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2023 12:40:53.7164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oj4vOhgMmxxQpZv0NIT1wKLs6PususTb3DxxkPhrGuHaAxoYqNHBdNKFFKSrHWDDhSzlFG2y9qJ5nE/iEmuD0VKRwHEbmOFNroOHmHMPUmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6506
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231101_054057_488044_50938952 
X-CRM114-Status: GOOD (  14.43  )
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

On Nov 01, 2023 / 11:32, Hannes Reinecke wrote:
> nvmet-rdma and nvmet-tcp trigger a circular locking warning when
> tearing down; reason is a call to 'flush_workqueue' when creating
> a new controller which tries to cover for the fact that old controller
> instances might be in the process of tearing down.
> However, this is pure speculation as we don't know (and don't check)
> if there really _are_ controllers in shutdown.
> And even if there were, that should be short-lived, and would have been
> resolved by connecting just a tad later.
> So this patch returns 'controller busy' if we really find ourselves in th=
is
> situation, allowing the caller to reconnect later.

I confirmed this series avoids the failure that I reported for blktests
test case nvme/003 with trtype=3Drdma or tcp. For the series,

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>=

