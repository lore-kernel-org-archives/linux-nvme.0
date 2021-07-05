Return-Path: <SRS0=DaCh=L5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35124C07E9B
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 11:16:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFD5D613AB
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 11:16:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFD5D613AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=micron.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qokJniPHnUV1Qtut7zCwDar73gBgDLWeEWd0Tq+D/lU=; b=kmw/FBP3EbS/GD
	9cG7I/RAihpnFuNT+OXBERD2P6MCa6bsXKoa+pxvOPcll1HwuVgUDmtVlQctDciH2X52+Kkkbei6+
	v4ioEynzI0g2ej5p5BGqM5+b1jcHey3OjBUcqAXdxKCwbNzMcy67Lm+G9orjuNuj1l5++xbaazZuq
	w0NNuhrl0mWD5GZAt9kkytCAdSakX5ewwCISIeZCZioGIM6+IyIjg2kcRmxHBb4aY9pAr3gz1N9E4
	RvXjfhuF3EOobVf589HX9Dfluec8X4yWidK8zi1+oHkRXU525DBMNKdlZYWta9kDqcXasg950BA9E
	f6SJvznqf3VNJtMDhEcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m0Ma7-008izK-8E; Mon, 05 Jul 2021 11:16:07 +0000
Received: from mail-co1nam11on2074.outbound.protection.outlook.com
 ([40.107.220.74] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m0Ma4-008iyF-MB
 for linux-nvme@lists.infradead.org; Mon, 05 Jul 2021 11:16:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/0z6FvLfcaWZJC8QrJL9odAGeg+dDOHY9HSg4rTRUkRhrhT45BP5NZEwzYHjNOKRo/rU1xi14Lwk24xh9DEsg+snRXGJMraFH6UnBxDbH0MgxvhXsXspHAmv9PGp36XInnXWrp/KfmQEUtJPl5BEZ9tMcjGpzhYM1wNiHJ4EOdafaqkqRS/Lm6BtdKzI2qvAV8O51q+/wcRNTL59Jxhv7Unuueiy02FkksKezBcQhQ5G4aUX6v1CZWXeS0RQH8PLrLZculA8wc5VHeZsdit8W00qDTpuaNqlTrLnS064ZHrpJEYnKDGBGtu2/PEmhOOXASXnwez5irXGi7FsI5TbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O09zKzwgWUXunoh8FCnOvlLYVNT51I+PU0WB2XrDIM4=;
 b=A4CwhTx6kh6MeFduuJxcrr9SnRnFhzNBbEiW70hyHNS1A6AhGBx3OADkbJJYv7FJXw1rWETWJ1RBhmLRJRvwrnfoK3GIAt+yJoic4sweldju+RLVC6d282MQJExZeQPaF1yxuaH79q8lu1tZSA+LmA1MH86zjUP/bCrKp78Db6J3COMOK1abMEoFZxcxwNHC7pxW1m6UzOm7afszpExqm6cDDO1ofCW0s6vP84sG4P+Qgg+K0jBke0WPih/PT7Ul5gXlZreqnaDiCQ2COp/bmnv/6dayFpwWQ6J3ZdEGU3KP7Ek0mC0W1w2FZnIpwqQ7pu5jvsB6MFKXyTWJZ79eQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O09zKzwgWUXunoh8FCnOvlLYVNT51I+PU0WB2XrDIM4=;
 b=xWwmDkm282fbRLZYUa+pQ8JjY//UbtIrHpUKh1oJ0i+dWUpclufxT4ioPIAfA+msaEGQa5ebYpvz3uOwRo44K7gQRaAY+vUlt+E/7zeW+w8qQO56WckIy1R8rk7dbgIEw3YBjwP/6cIZkBMiaJpKslpoTFGLPvNb67270mRqru8=
Received: from BLAPR08MB6900.namprd08.prod.outlook.com (2603:10b6:208:325::21)
 by MN2PR08MB6173.namprd08.prod.outlook.com (2603:10b6:208:11d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.27; Mon, 5 Jul
 2021 11:15:51 +0000
Received: from BLAPR08MB6900.namprd08.prod.outlook.com
 ([fe80::fde3:800c:617d:f516]) by BLAPR08MB6900.namprd08.prod.outlook.com
 ([fe80::fde3:800c:617d:f516%7]) with mapi id 15.20.4287.033; Mon, 5 Jul 2021
 11:15:51 +0000
From: "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
To: Christoph Hellwig <hch@lst.de>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "shiva.linuxworks@gmail.com"
 <shiva.linuxworks@gmail.com>
Subject: RE: [EXT] Re: [PATCH] nvme: Add abrupt shutdown support
Thread-Topic: [EXT] Re: [PATCH] nvme: Add abrupt shutdown support
Thread-Index: AQHXcYbB/F8jcejucEauG3F+rz+Qo6s0K71ggAAGAwCAAAHSoA==
Date: Mon, 5 Jul 2021 11:15:51 +0000
Message-ID: <BLAPR08MB690003D5D175FC784DE844F8B81C9@BLAPR08MB6900.namprd08.prod.outlook.com>
References: <20210705101157.1009135-1-sshivamurthy@micron.com>
 <20210705101554.GA12803@lst.de>
 <BLAPR08MB6900B02E65B542A2C2F174E1B81C9@BLAPR08MB6900.namprd08.prod.outlook.com>
 <20210705104208.GA14891@lst.de>
In-Reply-To: <20210705104208.GA14891@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Enabled=true;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SetDate=2021-07-05T11:15:49Z; 
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Method=Standard;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Name=Confidential;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SiteId=f38a5ecd-2813-4862-b11b-ac1d563c806f;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_ActionId=b3fb693e-5008-4603-b97e-f999daea3bb4;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_ContentBits=3
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=micron.com;
x-originating-ip: [95.90.192.255]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 327b8fbb-460d-4f54-e544-08d93fa63fd4
x-ms-traffictypediagnostic: MN2PR08MB6173:
x-microsoft-antispam-prvs: <MN2PR08MB61736EB93738DA62C025863EB81C9@MN2PR08MB6173.namprd08.prod.outlook.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lQhzUbjwFI+YqBgfeJn9go2Aag0eeqVFsMM++3xMx9JHp/3vu4Fi9fsWlmFvdW5ufsmyCwSxy9pNFUd2Ik8Pu9OUZjLbccUtyaTB86dmgQ26LDo/K77xR3+RjXrMg/BRUaUyRd1irnjLtMivrAgGgkH/kO6MoiPA7/iURCZXHCTofH0fpxZsk8QzJBH53RbGNRkvilgesFp3ux+q3LDSk129MkXtJYCgArSco36x1ZkQUdMnwr6Wpf/uFqbnAkX/CzsQUUFgTFsIU7ISaEBEK7t6+XGPnvZ65W0DGwX5e9xjY/l9tcCkWMefa1Zp5onHXX7YpsppFl3Xh7w0VrT6WwjAE3211F5nLijezIW9/uoAc5F7NBcX1RJoRxuG8qRLmVWTjjwmZ93uHzEOx1MRIErKoZyMQdfPivm6t6YEVyYUKwbvrXbcy1Kxg0etaOBu6aI0oPgv/WJK/tSzAi17fxQ+6yl4HHW640OA49w7+b4RRIpqI7WPYr0Pkuh+mbxKc5kUi6yX0ZydIbz3Ow6RUmhPL6fllnFmjXF5WlXodko6tUQscZcL/fEQT9o22eBIEDlOFjt3NI4mU7mEZOEAna61cI77+/x1svaFVGZ4jq/wcevMi7RFYIdZGGjYXKLnCtkCyNj8C2GGjQxoM/uu2A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR08MB6900.namprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(136003)(366004)(346002)(55016002)(7696005)(9686003)(54906003)(478600001)(316002)(86362001)(33656002)(186003)(66556008)(4326008)(4744005)(5660300002)(8936002)(66476007)(71200400001)(6916009)(26005)(64756008)(2906002)(52536014)(38100700002)(66446008)(76116006)(8676002)(6506007)(122000001)(83380400001)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DnaCvE9Nookr6PF7hz/Wv8F8WGwRRN+bloQHAmI/y2YUnVTb9gBBVO+o1FXn?=
 =?us-ascii?Q?DCCTb0nmjADqbGl2zE5sjgqxv90ZSYUQkq2PdtLtsNFGACC8Ywql88Ko0HJ3?=
 =?us-ascii?Q?AL2yjLhu+mChMVcw9a/nnYLM2M98Ej9yHs46eqWc/pg5yYmloerdiulzjuUa?=
 =?us-ascii?Q?rII9F5glnUWGyvFm9lS9/2998uggXD7si+BNRmy2Hevfw7JXZa8gA6SvrVpP?=
 =?us-ascii?Q?2oVorVY5vbxHkQRmVRCD6bl/MqkUTn1N0cj15F465nA+Xe7W7vyPmYU27ayW?=
 =?us-ascii?Q?ImOQ6AwbUrS9VenlwZYLi1W2wSy5d4qfOhHUTnXSMcaG0al5qpPrTdvAV2KC?=
 =?us-ascii?Q?GMbPbfkKCzSInuzUxb+suZA4FaIh1pxxSEoRd48mV1wP9aLIxFAv+EbUtu4q?=
 =?us-ascii?Q?KtKbcxeGWFwVNrVEydfJnFuzVQdwAXd76v3CXz/yw4DZOpvsQJ/B+dpw/YoG?=
 =?us-ascii?Q?tJv/M6Q7VxjoW3wMD6pYmBlyRI7mEHp43wKKRuQa7T17DSXboTkCVi6+1olw?=
 =?us-ascii?Q?itupXb9S+K5HkwaWYdlHH8hv2Qhx2c/gbBuF3N76+sNIVNZokj9nMWa48Nur?=
 =?us-ascii?Q?rv5Pq9dNsolRmCkcx5JwSfLkdQrPJzfI3PuIluKxHLcgyyQpMd5XO1mMIrIh?=
 =?us-ascii?Q?/hmQvsm3VIcam5Tv2K9maQw6Q68jhRoCrG3I8PtxPgLeMWyTx7JIx8yPHR+f?=
 =?us-ascii?Q?tpc42Gu5rzlnPiC0yyV+G3YKArPO2AkrTackr7U1vKv4jEQUPwk8N7PWplX+?=
 =?us-ascii?Q?DgUsdwAJDBxucqnUvQN0yO/8Pgf6X5CwT+euDajJpIfYG8E5TUSMj3S6CRYR?=
 =?us-ascii?Q?UxE5Tsmc3r3cl8vIzLIpCbJQpROUNyYhGCusHX224PuTtvGt646+xofPMlvk?=
 =?us-ascii?Q?67qV8FBEWjUAwgxONU/h2SSLGQS1gpydT4rn3gQsbO4xUbulzW7RppwAaZ5m?=
 =?us-ascii?Q?gENEFoC/Nl9lZuffMjoeYQoYf8RHE62+01VzurS6ctEjNpJWuVfkUKc76N4p?=
 =?us-ascii?Q?mxUhkJ/kOnwJt9p3YzzY9iixk2TsXyqCiteEtCUJ8xUGxgJy2506lGrc0Kp8?=
 =?us-ascii?Q?4CRkQ8XIpqeYW3Gakig1+tn3dOY9WwLDns3XMCwT77QnWoif0AorywPtjZo+?=
 =?us-ascii?Q?1WApNQSzpUakwVxi5Cx2uIJPW4X5OHB+uRBoQiGlU7RTa3h+3gryKs/h5Et3?=
 =?us-ascii?Q?FcJ0DF10LMIspheGrBAd5CAaMZVOlyLsYX3qahguAdLcIrkz0S4/szl8kSp1?=
 =?us-ascii?Q?Y/u37APju+nwk4gmzi+DOTtNLbCUlF4pTNwDvn4T/YQ0ZrbV2WY3c4lsni9P?=
 =?us-ascii?Q?YYkTbraJdTCdTjGGub+9dTXA?=
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BLAPR08MB6900.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 327b8fbb-460d-4f54-e544-08d93fa63fd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2021 11:15:51.6747 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aNSlD72j1jT/Q1Nq2Q1ppo5oSqfA7VO+CGsqSu093xIoJHL3djh6sGI3ZOqt1kYOpEUVosdxDDVoo2BMIpHwPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR08MB6173
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210705_041604_779066_5EF61E6D 
X-CRM114-Status: GOOD (  12.20  )
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

Micron Confidential

> >
> > Hi Christoph,
> >
> > >
> > >
> > > On Mon, Jul 05, 2021 at 10:11:57AM +0000, shiva.linuxworks@gmail.com
> wrote:
> > > > From: Shivamurthy Shastri <sshivamurthy@micron.com>
> > > >
> > > > Enabling the abrupt shutdown support. In this shutdown type host does
> > > > not need to send Delete I/O Submission Queue and Delete I/O Completion
> > > > queue commands to the device.
> > >
> > > Why?
> >
> > This is to achieve faster shutdown at the cost of data in-flight.
> 
> What is the actual use case, and why would a module paramter be a good
> interface?

For systems with passive electronic components to handle power-loss/battery-removal,
CC.SHN=10b will help to achieve safer shutdown with relatively lower power back-up 
requirements (at lower cost).

The module parameter gives flexibility to the host to decide shutdown type even during
boot failure. 

Thanks,
Shiva

Micron Confidential

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
