Return-Path: <SRS0=LCWA=KG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43391C433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 11:02:29 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6263E6134F
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 11:02:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6263E6134F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wEIJlq6B3SeDIVzFHxlbBJk7jwvGUfTWOIBlJUyDoa8=; b=cdNAK8xzqjVqGQZCaPH96pGFI6
	qEcrXxrhWjMW8HNZ0sbolVxTxKzSynbJ9TKF96cTut+mW4KTRyiDMyBzgp2BvV2RcTNRiVSB6onrZ
	6nyl2oJmWf8QCxZs7zMeakdHdi3EQ1285/ht7ZnZvwHGSeYMIxDzEId7Gv3S7EkSvoatX9nzMZ/rg
	YBE9Oo2irWOWzoMajmheCVRPBy9AXmtkXnW1lNQhPi+5tL3L4NUlXBYaG+3BtZNLCsGF266YzvIsk
	ixA9FjeMTRbAhBTFdNHVhR5JVuHA23xM2kv2zmJrqcUiAocSSomZYWSI+SnvXQwxsuD6oqcez2fvU
	FEMMvdVA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgQ9S-00H3ig-MH; Tue, 11 May 2021 11:02:10 +0000
Received: from [2607:7c80:54:e::133] (helo=bombadil.infradead.org)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgG41-00Fwmx-9r
 for linux-nvme@desiato.infradead.org; Tue, 11 May 2021 00:15:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
 Sender:Reply-To:Content-ID:Content-Description:In-Reply-To:References;
 bh=JjM8ujsvXp7jHvSFmqPSg/Z1HfYFtO93xJbVMe8YOf0=; b=ulf7iFeSqnqiXNqCh8xhlk0PTf
 lxFQabfhsstjp6jnzZtbDjT/dC5sKTxIsLpOCDVKqlMlCwM/yTvL7EjpWXrnq1ruqejljrTacr/5X
 QZjXS+xPRKfz0Ov8/glQ0RdRznWr5dksHUUvHMXxs8AGiVy972Ounoh/5g096G0ZAeWkD04N9Dhk/
 GmV507jvHj/kwOVinvXdGOA9cjd58bCjPkTyJ6JWU60TjwnJmk7lbEh1A4pZHdOXNyWXU/mrxbnO3
 tBWAd2uJ9Q6hkbLcz+73h7BZMFWI2VvSQgfMQWrvHSJBM15FYcj702o30OYgxBFVSYEJ2Uk1SVrKy
 LTkXK63A==;
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgG3u-009D1K-F5
 for linux-nvme@lists.infradead.org; Tue, 11 May 2021 00:15:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1620692145; x=1652228145;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=lsRBcCZb99blwbcaHk8vD6wtXm96ZnH1SfxDstR/BSc=;
 b=fVuZsBdj66rgMxulU7qPFFh4HIdCQbryCrBcbIf4Czz+ggsJPSJDGu1B
 4Flf9wqZhvP/gkGbq4/v+R88hxjaz7twNXkwSktTEzqS3wN1Wb5VD0qMS
 QMcMIxrtJSD1Qz0xoZHZhcJyLM9yxDUmMmlxD8xq++IsYTEMoucekHXIO
 HvV4Tvaqy2MzDEsmxcss66CHfn3Pn/WzlpmSSA72jfxI18m0GU3W2jfrl
 1i8qcK30+obOEbKPeOQQFteneQCT0ZgjeQVhbmFJ1GRlWo8OXxpuoeUWr
 ddMqcPpcQqDfJQbiSzmoaacfHWNpC5Ucdl22rIMiFl7xSA8FtRHRhwpZD Q==;
IronPort-SDR: hKACrQiB/ODSzwU0IkVnaOF5ZGwDwhIIG0YGg3kF8iA3k3SzfF3aa1n6g7Ab7j9YFXrZPe9387
 Dr+a/HpAMvsr/zT+b06NhfChdWzUdn26HWCKK1jNq4uLk4xxCw/e25pSpjl27Ofe6US5z2y+Ip
 9vo4Xpojv48E66YI+/Fih1TRqGbbo7y65Fw9uN4bmseV6+hzN5DSHJ+Fl71bOlQysosVoM1M+v
 7E+rKReNrcDQTEpfiaLpTpoqifl0Kg7Q7w2DBOkR45V/aktLeb5CS4BGQuTVerP4YGKn0hAVs6
 BNE=
X-IronPort-AV: E=Sophos;i="5.82,288,1613404800"; d="scan'208";a="167685163"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
 by ob1.hgst.iphmx.com with ESMTP; 11 May 2021 08:15:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBkKEV/D1XqpWXXnQ47xRyBzlpVhZ/lumFvLhJKLyPyx9TpP300vxoauPXQHtsxaBcEArYXgtYBeX/Ic/8o6ENYEXcoRzcJ6O3g7kjUrnH6WzsOVzNxL2KZJ7vYMgTECcL1pTkdr8v4yfcRA2QdRSTcJ8xmX6OCFX+q0IlO163O6nj64gGCQd4vE3QfKKQbBn83UWcw4MpCuHezX6Xn7D9iHdvVPhVbhRf35dZr3icgAppNdSCZld2gm2pY4eluRSNomY+UJp3fosx79vpQv8/tAxFrF+I+p3PwvHTakeH/LiRvBCynTl+M3p1BY9p87c48b6DyobTQSdj2Dx9MSxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjM8ujsvXp7jHvSFmqPSg/Z1HfYFtO93xJbVMe8YOf0=;
 b=IeCHcU0XYG1wCNt6j6AMUvtRznLXDhLfZMt8tUggi/htYZ2mFml9GBXVuoV22swGG4347BH6ZFv+xqT1B/298HeDtfgplTg/DB0SQVrtWWLdrIysW+izq2I2dq0gd9MrUp1/F2Uw+a4EJFDugZDXC/393dfsegO05U2D+JnmWO4Cb+FY9kgoRGaU7DZVAsEgNwpe6ZhwLOawbuflgUZGn77nMJsgOvTf+1IMFtCglyvpXwMiBajgwNGgjQKnCsP/YGQhd/ZuhiWLt076oqzQX5MV2VDHOqeefozbF22z5t9kxxGfiO6LsnoBJnlGmRcreBW37bD3CI5kBSvMKaUKBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjM8ujsvXp7jHvSFmqPSg/Z1HfYFtO93xJbVMe8YOf0=;
 b=fAPbUzMG6pdjW0kecdzUfiJFjqTAyB8MywxMw9pxloAlAzRKiE0OborW3AU7Aj2hU5FNYb1V6ximuBB6Y/kCBT0bcHqoXjPwTjO5DpQuvK3fDOlXhuFugeDSjUDb5E4qhc6e/+Bv17W9QWCQ+KiB/4qiLvnx4p/ZPQQ2KLrSMYI=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6088.namprd04.prod.outlook.com (2603:10b6:a03:eb::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Tue, 11 May
 2021 00:15:37 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 00:15:37 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "msnitzer@redhat.com"
 <msnitzer@redhat.com>, "bvanassche@acm.org" <bvanassche@acm.org>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "roland@purestorage.com" <roland@purestorage.com>, "mpatocka@redhat.com"
 <mpatocka@redhat.com>, "hare@suse.de" <hare@suse.de>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "rwheeler@redhat.com" <rwheeler@redhat.com>,
 "hch@lst.de" <hch@lst.de>, "Frederick.Knight@netapp.com"
 <Frederick.Knight@netapp.com>, "zach.brown@ni.com" <zach.brown@ni.com>,
 "osandov@fb.com" <osandov@fb.com>
Subject: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
Thread-Topic: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
Thread-Index: AQHXRfrE+mT6pvaiwEOWn89Dsv4XaA==
Date: Tue, 11 May 2021 00:15:37 +0000
Message-ID: <BYAPR04MB49652C4B75E38F3716F3C06386539@BYAPR04MB4965.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d3141c5-56b0-4b6e-0e1e-08d91411e710
x-ms-traffictypediagnostic: BYAPR04MB6088:
x-microsoft-antispam-prvs: <BYAPR04MB6088839B9CE235B2E05EF16886539@BYAPR04MB6088.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dVR08EHLBMBVndjSSzCM9Fbf0NQJBDNh11xCLBpRGyYoWb8qefYJQcGgdwrh04/AULruZJgyvczISwoPuHN++xKyqkuYpDIl24us0i7HtWVh9OsZwIjBoHi4NiujkVuC7cAQuOljCYGeA40I9Af3YGVIK6OWmy8a/1vLwkQb3twazbSjXo5YAxfrwIeRPxZa94BtPX5GyPX5X8lNHuM4MDcZFxlTqqPzmb4U9LxAUn7xlXIR5RrwK60iaoqW/Dopn29XsWz2XHRH/hiQGU9T2dvw8ckT2MnbptKo12BvSSNjZutoAezFKRq7o/rMe4UK0CPu1ACIThHKVEuslvGFoEx4WaaZkP7JN3b5y8VIR/64Mtk6F0i1pKDZoiVLNJXN0+YRPL46yRSMTZz/jPqHrAfIUO0BErZBGiJhz8ineMWx5p7pU77pw99uiTq5nNhB8BmyYYv3/tHDH/lhDp0C7hxTKeG9+WJQ3Atfs+FUXUAzV/rgJsCGT5cdIrD2AqL9pz1wpTkgzxQQrc0MHBBIaI8jVuBYwgiVFylxWgAzsCHPfqr7Va06pf8BJiShyjD3aUpTzl9FV3pOIMBXPEcvojZG+kavU5gMS3SmhpVh5RwC8jpj1yZsIvbEC8JWpCJUdvrQFRnCCE22we/g8kMaPb950lT7D7ZoK4kkiWfmxF3sPML7RPHmdBdVjXeovkhja5oF8o63+iC1PBlo8F2qOYQ2rbro8uvp7yGNkG4rMl94EYSLY6VURTkgOeoocJpYdjuIZcLkg6Xr1ms5BBp+XA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(39850400004)(396003)(346002)(2906002)(64756008)(186003)(66446008)(83380400001)(66556008)(66946007)(52536014)(66476007)(316002)(966005)(110136005)(6506007)(54906003)(8936002)(7416002)(4326008)(71200400001)(86362001)(5660300002)(38100700002)(122000001)(55016002)(7696005)(9686003)(33656002)(76116006)(478600001)(26005)(8676002)(15398625002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?IFSN04bQCjnysLzidHAS4sFGBWQqehrif1DABUkifaOaiwocMi1jsF7KyeFX?=
 =?us-ascii?Q?QjFw8c/EX4hG2oKUnnNdMpG0ogDVL6lrULLlWM84s/qI55yohcDB0VyKGQzV?=
 =?us-ascii?Q?giqXk0Lc8P8n85UNTm0Ypy6VsmsoJDhGCZ/02/7GmOOtGKV4gInSvRMA2wa/?=
 =?us-ascii?Q?fxnpFP8+w6rBBZQWd2SvzlMktcyOPdNYDvw6Z1QZvQlQ0SZFnSGrjTQxNDoN?=
 =?us-ascii?Q?EFsQzavdQILKamCxL65OphBWbHl0yjsiR/4WefZuP1evg/QloACPiHLlXOl6?=
 =?us-ascii?Q?kj05tWVbqYP49wbdqZQ+Jm0qEAq8Hs2NxqjIME2pA5/FOSxoSDKk3iW9jCl2?=
 =?us-ascii?Q?dls1LljJKppfm2tbz2C6WMaZ2lqzkNUiVSJbRitUmWDzk3D41PdWar5iPqm3?=
 =?us-ascii?Q?6ww5untp8yOf1zTAptV1uQ5K2LSHzx0gE1j4NRwvGcRgoUZMDRpuO/4ylwfa?=
 =?us-ascii?Q?xtjKdxRnUsbRdeHsjcYbzNQPIZQUpBrUAcvBkHrpHgIouHQRmahnJJ1duOvB?=
 =?us-ascii?Q?Ta+T0QPGo76pcfAu9nzU68ES6H80U5hkPgUsrFiz3z4hhCtcHHw2cSahZnvQ?=
 =?us-ascii?Q?ZrUhx9c2b2yuCYptDwKoH1sJrHoPQvUGw1Nm4f38RCgmNiAqtejJG4v7mS2Z?=
 =?us-ascii?Q?dZZGQ2VeBvwIfvr30C6K9gXystOYor23XeiaAkq7GCOhdlYtYxoEUk15yzx2?=
 =?us-ascii?Q?W+lkFvmDyc0k4kciqUvcueBHV1Ll+p45QS0CM6iiwcxJGiSXm2o2ng9oBBnJ?=
 =?us-ascii?Q?yQ4Z9P+2vK/VMW2zwf9XoXAtfsfssKGUuiwPFtyxnC9PLWuGEUiXs11MrKel?=
 =?us-ascii?Q?ZURk4/REPYhKBbZmYMNeMcCjwIafeth852711nEjSTdhBNCP+teSR36/zhBB?=
 =?us-ascii?Q?t2aNAPuRU95ZlplmGXEED4uSjnTJbhRfekbJRQFS1HP+qx55WLJKK5TpoDqO?=
 =?us-ascii?Q?/Yzg46jNWCwtxb//+SgwMFsys1fULSB7OBJGYWXnWpBRCe5d9XZx251jrFn5?=
 =?us-ascii?Q?/phBmdkNXHxRW1Lea4NA2bGi8+HWAFZ2FCh0VgStXKBQHc746WZRsRtoBld6?=
 =?us-ascii?Q?CIDJNSVCPqZRgsbzp555yWlaweVDKkeBrOLM05TyvR33rl2MSpk4yqghc4GS?=
 =?us-ascii?Q?FS4G5/RzZWk5KeW5hUd8Ph6+I61cLwVfBLxmfij6+XKl8FreJeFruhigc4kc?=
 =?us-ascii?Q?KGHtRtUydW9exMIsiVQBqNaQ9zmY2Yv+EiLYZOPdXmxwVlxrIlqlXkAkSpjC?=
 =?us-ascii?Q?ZaoK5Wv8MS3+dCavCUt1PayenEF4Z4ba0gHDhNMWDS3eIPvr3LWv5kQIdy7D?=
 =?us-ascii?Q?J5WKGriqQLP7S+XqzdKCkPUt?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3141c5-56b0-4b6e-0e1e-08d91411e710
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 00:15:37.1555 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mSYtTpSKo4aEFK1FYZvnXxoXH4xilMS7ALiBTuBvFXlvcXxVrm7s0R279gvGbFC8oCZOefXk5don8hAha2WSBNome6k4qfJymuiXgFxu9Bo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6088
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210510_171546_543583_C5E9BB1E 
X-CRM114-Status: GOOD (  17.60  )
/bin/ln: failed to access
 'reaver_cache/texts/20210510_171546_543583_C5E9BB1E': No such file or
 directory
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210510_171546_543583_C5E9BB1E 
X-CRM114-Status: GOOD (  13.02  )
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

Hi,

* Background :-
-----------------------------------------------------------------------

Copy offload is a feature that allows file-systems or storage devices
to be instructed to copy files/logical blocks without requiring
involvement of the local CPU.

With reference to the RISC-V summit keynote [1] single threaded
performance is limiting due to Denard scaling and multi-threaded
performance is slowing down due Moore's law limitations. With the rise
of SNIA Computation Technical Storage Working Group (TWG) [2],
offloading computations to the device or over the fabrics is becoming
popular as there are several solutions available [2]. One of the common
operation which is popular in the kernel and is not merged yet is Copy
offload over the fabrics or on to the device.

* Problem :-
-----------------------------------------------------------------------

The original work which is done by Martin is present here [3]. The
latest work which is posted by Mikulas [4] is not merged yet. These two
approaches are totally different from each other. Several storage
vendors discourage mixing copy offload requests with regular READ/WRITE
I/O. Also, the fact that the operation fails if a copy request ever
needs to be split as it traverses the stack it has the unfortunate
side-effect of preventing copy offload from working in pretty much
every common deployment configuration out there.

* Current state of the work :-
-----------------------------------------------------------------------

With [3] being hard to handle arbitrary DM/MD stacking without
splitting the command in two, one for copying IN and one for copying
OUT. Which is then demonstrated by the [4] why [3] it is not a suitable
candidate. Also, with [4] there is an unresolved problem with the
two-command approach about how to handle changes to the DM layout
between an IN and OUT operations.

* Why Linux Kernel Storage System needs Copy Offload support now ?
-----------------------------------------------------------------------

With the rise of the SNIA Computational Storage TWG and solutions [2],
existing SCSI XCopy support in the protocol, recent advancement in the
Linux Kernel File System for Zoned devices (Zonefs [5]), Peer to Peer
DMA support in the Linux Kernel mainly for NVMe devices [7] and
eventually NVMe Devices and subsystem (NVMe PCIe/NVMeOF) will benefit
from Copy offload operation.

With this background we have significant number of use-cases which are
strong candidates waiting for outstanding Linux Kernel Block Layer Copy
Offload support, so that Linux Kernel Storage subsystem can to address
previously mentioned problems [1] and allow efficient offloading of the
data related operations. (Such as move/copy etc.)

For reference following is the list of the use-cases/candidates waiting
for Copy Offload support :-

1. SCSI-attached storage arrays.
2. Stacking drivers supporting XCopy DM/MD.
3. Computational Storage solutions.
7. File systems :- Local, NFS and Zonefs.
4. Block devices :- Distributed, local, and Zoned devices.
5. Peer to Peer DMA support solutions.
6. Potentially NVMe subsystem both NVMe PCIe and NVMeOF.

* What we will discuss in the proposed session ?
-----------------------------------------------------------------------

I'd like to propose a session to go over this topic to understand :-

1. What are the blockers for Copy Offload implementation ?
2. Discussion about having a file system interface.
3. Discussion about having right system call for user-space.
4. What is the right way to move this work forward ?
5. How can we help to contribute and move this work forward ?

* Required Participants :-
-----------------------------------------------------------------------

I'd like to invite file system, block layer, and device drivers
developers to:-

1. Share their opinion on the topic.
2. Share their experience and any other issues with [4].
3. Uncover additional details that are missing from this proposal.

Required attendees :-

Martin K. Petersen
Jens Axboe
Christoph Hellwig
Bart Van Assche
Zach Brown
Roland Dreier
Ric Wheeler
Trond Myklebust
Mike Snitzer
Keith Busch
Sagi Grimberg
Hannes Reinecke
Frederick Knight
Mikulas Patocka
Keith Busch

Regards,
Chaitanya

[1]https://content.riscv.org/wp-content/uploads/2018/12/A-New-Golden-Age-for-Computer-Architecture-History-Challenges-and-Opportunities-David-Patterson-.pdf
[2] https://www.snia.org/computational
https://www.napatech.com/support/resources/solution-descriptions/napatech-smartnic-solution-for-hardware-offload/
      https://www.eideticom.com/products.html
https://www.xilinx.com/applications/data-center/computational-storage.html
[3] git://git.kernel.org/pub/scm/linux/kernel/git/mkp/linux.git xcopy
[4] https://www.spinics.net/lists/linux-block/msg00599.html
[5] https://lwn.net/Articles/793585/
[6] https://nvmexpress.org/new-nvmetm-specification-defines-zoned-
namespaces-zns-as-go-to-industry-technology/
[7] https://github.com/sbates130272/linux-p2pmem
[8] https://kernel.dk/io_uring.pdf


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
