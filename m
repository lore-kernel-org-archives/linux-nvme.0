Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 272E0C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Oct 2022 08:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=G35PO1uoqbn4YuCgplj5V4XELt/B4qlA+fe2peYFVEM=; b=I60BFgit1N8wdEUrI/mDxArIor
	UrxgoN2TRweKh1FUxh6z/kSW7uGctrp0xr1o6+qnIx0UElVyDnmN7gNinsw6uDcZSa7lfMe/888VH
	LGmmFN2dMBwe+L82x+010Vt9/BgIeNzR/J/CgvxXWOj1zeaa2laxhb8k+z6LvUnFMbvjH/+qCmnea
	3O89Z5GpPZfLpnt22ZnIWl3N4IPnbcZU/ISYeg2+XRuDYsFju9nJxu+aF3z5ovUXsVb5V73EUpMBl
	Tuv14GJ3WabvuMuBNfv1qrBOidVbbQ8jLuQ6Zkha1foJ9K2mYBrDO38eh6n28jrBKFNO3VmEskUx9
	HyKidJug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okha4-004GXZ-V7; Tue, 18 Oct 2022 08:04:08 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okhZy-004GRv-7K
	for linux-nvme@lists.infradead.org; Tue, 18 Oct 2022 08:04:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666080241; x=1697616241;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=sE6fS+WOuYwP/PYxXNBVvN+ljPEQ6J2I18B53ZdInZs=;
  b=DK74Q3ckQjY6yWgcS5/Klyj8iBjzlV0PxCPDbPi4Nqr8P+VgXTjwuhcn
   DULdUI8jzA097finhwTj88F0TZ90FcezpBc6F692PJ4GpD9p+pdBvcuMb
   8kF3P2SC3CuSBGxp9brjd6eGBIORWsmiVGOgF5mCGOhwa7EfRkruniPGX
   dbxbSeEvgamwr9M6OJb33KssX1hZzKlb2m/HAkABKRqchDyNZSyao0z7m
   IWUs1vFSEPBYCbITkghJUHUBIMdBWxE8NNRYPXerCCd6lguY/qIuh9122
   birEoj7cSLgazzVW6RQPIKopkwuNR8pKqK7iOFWb+bC7udtFo/NYMXKeU
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,193,1661788800"; 
   d="scan'208";a="318423135"
Received: from mail-mw2nam04lp2174.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.174])
  by ob1.hgst.iphmx.com with ESMTP; 18 Oct 2022 16:03:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UT+OQ9l++TvFjjAKlGhhGG4BSceR6pduitoGCNWX3ka2ENDXtlH6yFknSuqFKFFTZK2efxa8PR0ikUX11RpDNXzsHQntZVAmOUzLmtV9tvp3Ii+DFrssNICrr9YQ4ox3ML9rs3NwZ011RtktpDiM136n+52bHMi3GnPtnXiTfl9f0E6jBz46xCh+NigROC1FrKtwWNljhC/4kq6jmBMGWZ23UgKfK5u+PVPKROxo7Kp8l8XvABF8QrtLvNjXOCPeMt1A2WnWD5o7jhw6/W91rXkKh+9zhe30lma7+GLLzjTNGzYJoTv/Rqr+GlngYJsnnneZKwKHGO3rVlCzKDZa6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G35PO1uoqbn4YuCgplj5V4XELt/B4qlA+fe2peYFVEM=;
 b=CVNwpDejdR82fd96g6M0+bZjKcopiI+uy4GQw6+MUdoIkfOO+Qd2XeGMsDUA8AD3u9a44atiYlJeZfqhf1P51aw7qxgB+OoOzw1YlAMGnoyXVe1TeCoAx/5bxwydFzsj26r5bncDMjexp0xsd7AoUNEPZOza0Ul+0cexZMEXNv9gp/lu810RDRyeM8vgkPcVdIOInhJ5F5J2+LuS+71d+AOY9k1LlRRC39Myun6LM/FKn6/hTVJm/6OrDls/1vEq4vPdbyu3zO/7HhGHkUQKGh5uEXc/6lFaAYFaKKLLGkqXcNfO5OxW4uNk1WM2xx1C9GeJ3ceS1M+rORm7wU3wfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G35PO1uoqbn4YuCgplj5V4XELt/B4qlA+fe2peYFVEM=;
 b=M4cBdpYAZSUAMYFx4OUlqiPtwd2XvPB+afUsmXHfix1DJHkDB+LKRrLMnfV6HGkPz1wqz6+hiApYyTfcDvW085lMp5y9LBdk0Ev6qdpZ/Y/2s55UFSwUxLcqdfNHStvTTjBY0RzyylyS9ZzJUt90sqhfEofSPT/S0YCrM4foj2I=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SN6PR04MB4224.namprd04.prod.outlook.com (2603:10b6:805:32::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.33; Tue, 18 Oct 2022 08:03:51 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::fe3:cfe5:dda0:f9e5]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::fe3:cfe5:dda0:f9e5%9]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 08:03:51 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Hannes
 Reinecke <hare@suse.de>
CC: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: bad unlock balance WARNING at nvme/045
Thread-Topic: bad unlock balance WARNING at nvme/045
Thread-Index: AQHY4sgozFGFnCMG3EKP0AQmcjycsQ==
Date: Tue, 18 Oct 2022 08:03:51 +0000
Message-ID: <20221018080350.zir6xm6dnr4wgb7j@shindev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SN6PR04MB4224:EE_
x-ms-office365-filtering-correlation-id: ae6ebbd4-1368-43c8-04ae-08dab0df4b6e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  qvjc4Kyiwn3BpOjmGTFSkJwcXG5WWTO0jD1Hvbm0S2VbA/olPs5FTR3DXH6lEDb5gGbjBhaf1Q6JTpTr0MO5xOYLpsK5APLuxGVpQ5Vyi8blFMLoTuy2IZki512MlvW7jX7qsDYsJbtioQEk5CC6guy/sK9UyUfnjkLR+3owqQRP/XzvzPL9z2+M3ezPxMZMybMyNEDVgO7gd7+P4YZk4pUKqR6kokG2qcXEetH8OhktkucPfMqfS+63b7P020/8DJ2nqUjt4Mlr5vloI4Qx+JthF7BjqyvPNd58pGnBnbSTAXPuO6LC71HGelsMVEguEjRTOr2QAjTi5DF2oAvynqfb8Gc7ho1TFY3oTIMILUIm9Y5HHQUKm4eUInf6mlHYJ7s5PCb5At+Gbu85mQoQTHtJudFRoZ5v6VG2jwBuhgqRMEtMuGS27VRnkQPJQf22YuolW7zcCOAe87G26dPJQk0rraCjwIn22/zQ8cNNw+aX2LT8GPlYCDEEIXwV9fOwnbcmIvt6TmjgUw3wbeF6A06duH0WAT/b8vsVN924TgQ2AoJpT8Flrd+gkI8Ty2l2LU5wsHaH0HTQu5w/aPj6npMjcnNKz9RGBttVKwQ0myyGf/2b8eKSTqgJ1gv8LCAUAvC9BrBaX/hds3Ru3t+I5Hbxnmg5HmS05ymNT5pUSV66gye1fi0h2Y1tXz7151m/GF8mcE+VzZTnntgdJQvwr+Ba7P6q3Q17uLW4kno+XFapFne+kPlgiIoXIuPCt/5fEFzzP8csKCJk+F1Z8ZvscA==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199015)(4001150100001)(6512007)(38100700002)(41300700001)(9686003)(6506007)(82960400001)(26005)(122000001)(1076003)(110136005)(2906002)(186003)(316002)(44832011)(30864003)(8936002)(478600001)(86362001)(91956017)(33716001)(76116006)(66946007)(38070700005)(5660300002)(83380400001)(8676002)(66476007)(71200400001)(66556008)(64756008)(4326008)(66446008)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?md1vF568f80/Rb9Hj+ceYB3Eg6FZ/45+46Xj4rWxoOKEROgapMRYdT3xuSc1?=
 =?us-ascii?Q?mCj3cyRljWKQsck568KEmjwAUxefpdB61xXHnv5zEJURM07NO4+UVXsFgT/y?=
 =?us-ascii?Q?e1JOSvegHpsJpqyidArjkG6ToKDHYs3IiueRIyJGFke84MqiD45AraFskz4z?=
 =?us-ascii?Q?zza2Dl/pLsbrggbq2g7QWefRvWg6IafYfGdGk3cqBxLHwru4BQAu3oOrs0xx?=
 =?us-ascii?Q?tsHfNEEbu/xbNZ5YTKV4zncZhB0YQfFRbMW0ID/z+ZNH2gluovGoWzXU8KEl?=
 =?us-ascii?Q?5u4dDk5x/p45gPrIHHzmhtJv/Eu3FCUPJ0qQSQAXIfyQWzx5/mPnDSXqxCog?=
 =?us-ascii?Q?SVWNkNYtWkZ0KlLWy+EP4H5k/HBlCSu9f9JQYFQ+rhdIvXhjwyKysVrDlwTl?=
 =?us-ascii?Q?y3Og7h4UBjI5CEpqrENYkTNo/hOl3rWzUPwjjh1CcrGvplDzFB9zLm5diERQ?=
 =?us-ascii?Q?D2ShhQ/ti/nzWMenFG4yWpddOrPpq6yp0P56mheFF8fz4WdRWxywq4Nqpa8X?=
 =?us-ascii?Q?mCWLp+s5QGIsxOQhCpXDq0Vkk3hsC0PCORzwvDm4uD9WNDNAXuvd3/uOyksE?=
 =?us-ascii?Q?QqCa38A4AmlpHgMLODnZOZzpMLzqFfaP7a4HuWS2Sd/f05V9jlxEgyz2F1gG?=
 =?us-ascii?Q?wJa3hAXb4JDFxyiH1tcOX5hCsznWyCt368or0McSf1VbepCk8o1xjzYqLBzq?=
 =?us-ascii?Q?rPNhUhAhZikdeB5YwNF7xhrgAmP0PSVepR1BjbQ+VTq1vbdDkWxtCF5HjnSs?=
 =?us-ascii?Q?SW6xLnltDo3D1IaHphDBPZjg6aNPBNtMB4psvAA90JGnKqRgJq0RgUUK5zl3?=
 =?us-ascii?Q?qgXiQ4qQKgBJCIopG0Js25jG8pq5tkcllHK+ozNaWF0QY9NpTpiHyTSeyduq?=
 =?us-ascii?Q?tF5BIM0gX+NZWQYDkgKSgyEGMC54YPRM81+6pCGsRpa8DP2aY39EMsi4iO3t?=
 =?us-ascii?Q?NIZV9XprNQHA7/1bDkP1AtYvgzWqNr57dw7SAvZ1UCjnIIlZoaGKbrPk2z12?=
 =?us-ascii?Q?1RL0JcCz2K1+sx9/9NwwdxaL3T1j8tHFPp9Pm1iRSo7g+AzQcGl7mk5yrIKn?=
 =?us-ascii?Q?NwrJuqRm63XfI9v+xJfERYcBZ3K5fbqURtRoDYfLz3GpwoBTKbAizr8ABGS6?=
 =?us-ascii?Q?0Is4rcJiSW0jGX5j4r14fl13gS5elJvySEc/1/+RxP23MHc0xOxymjBHfsYp?=
 =?us-ascii?Q?/odemPpGmN5zCMlbzE3o2dCNXasLHQMw2sv4CxvOUqUNhq2u9ZsKZt646S/S?=
 =?us-ascii?Q?OQ8scr6KqsxUPyfoAi1EtXNMYILC4QCDyLMSZbSVxknzmvUxlUE8ArjGVbZr?=
 =?us-ascii?Q?KR8THahY3FO3xXwr3w/mcPJDqQc3amvdvHGNJSFuDTrptjV/TsZSYWrmzTrM?=
 =?us-ascii?Q?qZ1IOTe246a4n5WQFs0A4U+FYmhyDBprdWrEP4Qggt1pmPARgQ0dnGnYEbFJ?=
 =?us-ascii?Q?V2KCpS9ul2L8v6/MyVCD7Na/1pwvYzG34WpZqhFSxnpReFy5Nd5dAs3a9CA3?=
 =?us-ascii?Q?eDFQqjLOqRpZX8c+DnBgzVbtkxEqbDF7O65oV/aIxidyrJ94lurZQgsIPCvQ?=
 =?us-ascii?Q?dV2VibwRTtkrUeLmoe4K+tvCyjqVQgDd6ekE21O3UbpOwzUxLLeZla1IWu3K?=
 =?us-ascii?Q?dP9/FNmka9mv8RWo0Eh5a3A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7626AEBCCAE6524D9C19258A648EEC05@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae6ebbd4-1368-43c8-04ae-08dab0df4b6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 08:03:51.5574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CbJJ9H/RcMwrji/8fCdx0eXgxsU3ex+a+3s1qWNStzdVAAIjLK32ZxDHm3DZiwWfXsuLMIOxHWTHoCNrTiRnopOw5GienqBXZrA7KmaJ664=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4224
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221018_010402_461502_F5C9FF6D 
X-CRM114-Status: GOOD (  13.21  )
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

Hello Hannes,

I observed "WARNING: bad unlock balance detected!" at nvme/045 [1]. As the =
Call
Trace shows, nvme_auth_reset() has unbalanced mutex lock/unlock.

	mutex_lock(&ctrl->dhchap_auth_mutex);
	list_for_each_entry(chap, &ctrl->dhchap_auth_list, entry) {
		mutex_unlock(&ctrl->dhchap_auth_mutex);
		flush_work(&chap->auth_work);
		__nvme_auth_reset(chap);
	}
	mutex_unlock(&ctrl->dhchap_auth_mutex);

I tried to remove the mutex_unlock in the list iteration with a patch [2], =
but
it resulted in another "WARNING: possible recursive locking detected" [3]. =
I'm
not sure but cause of this WARN could be __nvme_auth_work and
nvme_dhchap_auth_work in same nvme_wq.

Could you take a look for fix?


[1]

[   89.883480] loop: module loaded
[   90.271575] run blktests nvme/045 at 2022-10-18 15:13:33
[   90.774324] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[   91.410877] nvmet: creating nvm controller 1 for subsystem blktests-subs=
ystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid: with DH-HMAC-CHAP.
[   91.454315] nvme nvme6: qid 0: authenticated with hash hmac(sha256) dhgr=
oup ffdhe2048
[   91.456445] nvme nvme6: qid 0: controller authenticated
[   91.458581] nvme nvme6: qid 0: authenticated
[   91.466122] nvme nvme6: Please enable CONFIG_NVME_MULTIPATH for full sup=
port of multi-port devices.
[   91.469709] nvme nvme6: creating 4 I/O queues.
[   91.620115] nvme nvme6: new ctrl: "blktests-subsystem-1"

[   93.775756] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   93.776961] WARNING: bad unlock balance detected!
[   93.778088] 6.1.0-rc1 #3 Not tainted
[   93.779011] -------------------------------------
[   93.780090] check/961 is trying to release lock (&ctrl->dhchap_auth_mute=
x) at:
[   93.781726] [<ffffffffc03bf28b>] nvme_auth_reset+0x5b/0xb0 [nvme_core]
[   93.783310] but there are no more locks to release!
[   93.784461]=20
               other info that might help us debug this:
[   93.786087] 3 locks held by check/961:
[   93.787098]  #0: ffff8881135fa460 (sb_writers#4){.+.+}-{0:0}, at: ksys_w=
rite+0xe7/0x1b0
[   93.788923]  #1: ffff88811fb1d888 (&of->mutex){+.+.}-{3:3}, at: kernfs_f=
op_write_iter+0x21d/0x530
[   93.790888]  #2: ffff88810d8160f0 (kn->active#110){.+.+}-{0:0}, at: kern=
fs_fop_write_iter+0x241/0x530
[   93.792960]=20
               stack backtrace:
[   93.794168] CPU: 1 PID: 961 Comm: check Not tainted 6.1.0-rc1 #3
[   93.795552] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   93.798016] Call Trace:
[   93.798716]  <TASK>
[   93.799298]  dump_stack_lvl+0x5b/0x77
[   93.800251]  lock_release.cold+0x10/0x4e
[   93.801244]  ? nvme_auth_reset+0x5b/0xb0 [nvme_core]
[   93.802479]  ? reacquire_held_locks+0x4e0/0x4e0
[   93.803537]  ? mark_held_locks+0x9e/0xe0
[   93.804544]  __mutex_unlock_slowpath+0x8c/0x5f0
[   93.805650]  ? kasan_quarantine_put+0x94/0x1f0
[   93.806759]  ? bit_wait_timeout+0x170/0x170
[   93.807757]  ? __nvme_auth_reset+0x198/0x3d0 [nvme_core]
[   93.809010]  ? __kmem_cache_free+0xa9/0x390
[   93.810059]  nvme_auth_reset+0x5b/0xb0 [nvme_core]
[   93.811253]  nvme_ctrl_dhchap_secret_store+0x1b4/0x1d0 [nvme_core]
[   93.812710]  kernfs_fop_write_iter+0x356/0x530
[   93.813754]  vfs_write+0x519/0xc50
[   93.814513]  ? kernel_write+0x590/0x590
[   93.815410]  ? __up_read+0x182/0x700
[   93.816252]  ? __fget_light+0x51/0x230
[   93.817092]  ksys_write+0xe7/0x1b0
[   93.817888]  ? __ia32_sys_read+0xa0/0xa0
[   93.818750]  ? lockdep_hardirqs_on_prepare+0x17b/0x410
[   93.819901]  ? syscall_enter_from_user_mode+0x22/0xc0
[   93.820929]  ? lockdep_hardirqs_on+0x7d/0x100
[   93.821848]  do_syscall_64+0x37/0x90
[   93.822583]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   93.823615] RIP: 0033:0x7f6f84d018f7
[   93.824372] Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f =
00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
[   93.827699] RSP: 002b:00007ffcdb0ce5d8 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000001
[   93.829137] RAX: ffffffffffffffda RBX: 000000000000003c RCX: 00007f6f84d=
018f7
[   93.830502] RDX: 000000000000003c RSI: 00005582004ce6e0 RDI: 00000000000=
00001
[   93.831879] RBP: 00005582004ce6e0 R08: 0000000000000000 R09: 00000000000=
00073
[   93.833236] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
0003c
[   93.834594] R13: 00007f6f84df9780 R14: 000000000000003c R15: 00007f6f84d=
f49e0
[   93.835979]  </TASK>
[   93.836823] nvme nvme6: re-authenticating controller
[   93.871885] nvme nvme6: qid 0: authenticated with hash hmac(sha256) dhgr=
oup ffdhe2048
[   93.873754] nvme nvme6: qid 0: controller authenticated
[   93.916346] nvme nvme6: re-authenticating controller
[   93.948156] nvme nvme6: qid 0: authenticated with hash hmac(sha256) dhgr=
oup ffdhe2048
[   93.949498] nvme nvme6: qid 0: controller authenticated
[   93.992725] nvme nvme6: re-authenticating controller
[   94.025843] nvme nvme6: qid 0: authenticated with hash hmac(sha256) dhgr=
oup ffdhe2048
[   94.027160] nvme nvme6: qid 0: controller authenticated
[   98.836070] nvme nvme6: re-authenticating controller
[   99.345893] nvme nvme6: qid 0: authenticated with hash hmac(sha512) dhgr=
oup ffdhe8192
[   99.347859] nvme nvme6: qid 0: controller authenticated
[   99.736321] nvme nvme6: re-authenticating controller
[  100.014469] nvme nvme6: qid 0: authenticated with hash hmac(sha512) dhgr=
oup ffdhe8192
[  100.015192] nvme nvme6: qid 0: controller authenticated
[  101.560718] nvme nvme6: Removing ctrl: NQN "blktests-subsystem-1"


[2]

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index c8a6db7c4498..4e824aab30eb 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -926,7 +926,6 @@ void nvme_auth_reset(struct nvme_ctrl *ctrl)

        mutex_lock(&ctrl->dhchap_auth_mutex);
        list_for_each_entry(chap, &ctrl->dhchap_auth_list, entry) {
-               mutex_unlock(&ctrl->dhchap_auth_mutex);
                flush_work(&chap->auth_work);
                __nvme_auth_reset(chap);
        }

[3]

[ 2678.264545] loop: module loaded
[ 2678.679919] run blktests nvme/045 at 2022-10-18 16:34:00
[ 2679.231157] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 2679.854789] nvmet: creating nvm controller 1 for subsystem blktests-subs=
ystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid: with DH-HMAC-CHAP.
[ 2679.898208] nvme nvme6: qid 0: authenticated with hash hmac(sha256) dhgr=
oup ffdhe2048
[ 2679.900508] nvme nvme6: qid 0: controller authenticated
[ 2679.902183] nvme nvme6: qid 0: authenticated
[ 2679.907944] nvme nvme6: Please enable CONFIG_NVME_MULTIPATH for full sup=
port of multi-port devices.
[ 2679.912737] nvme nvme6: creating 4 I/O queues.
[ 2680.068539] nvme nvme6: new ctrl: "blktests-subsystem-1"
[ 2682.156749] nvme nvme6: re-authenticating controller

[ 2682.160640] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ 2682.161903] WARNING: possible recursive locking detected
[ 2682.163112] 6.1.0-rc1+ #4 Not tainted
[ 2682.164063] --------------------------------------------
[ 2682.165319] kworker/u8:0/927 is trying to acquire lock:
[ 2682.166573] ffff888119d27138 ((wq_completion)nvme-wq){+.+.}-{0:0}, at: _=
_flush_work+0x40e/0x900
[ 2682.168529]=20
               but task is already holding lock:
[ 2682.170022] ffff888119d27138 ((wq_completion)nvme-wq){+.+.}-{0:0}, at: p=
rocess_one_work+0x73c/0x1300
[ 2682.172088]=20
               other info that might help us debug this:
[ 2682.173695]  Possible unsafe locking scenario:

[ 2682.175196]        CPU0
[ 2682.175908]        ----
[ 2682.176559]   lock((wq_completion)nvme-wq);
[ 2682.177589]   lock((wq_completion)nvme-wq);
[ 2682.178631]=20
                *** DEADLOCK ***

[ 2682.180252]  May be due to missing lock nesting notation

[ 2682.181918] 3 locks held by kworker/u8:0/927:
[ 2682.182988]  #0: ffff888119d27138 ((wq_completion)nvme-wq){+.+.}-{0:0}, =
at: process_one_work+0x73c/0x1300
[ 2682.185078]  #1: ffff88810c8bfdd0 ((work_completion)(&ctrl->dhchap_auth_=
work)){+.+.}-{0:0}, at: process_one_work+0x769/0x1300
[ 2682.187535]  #2: ffffffffb483d560 (rcu_read_lock){....}-{1:2}, at: __flu=
sh_work+0xc2/0x900
[ 2682.189373]=20
               stack backtrace:
[ 2682.190590] CPU: 2 PID: 927 Comm: kworker/u8:0 Not tainted 6.1.0-rc1+ #4
[ 2682.192118] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[ 2682.194630] Workqueue: nvme-wq nvme_dhchap_auth_work [nvme_core]
[ 2682.196108] Call Trace:
[ 2682.196755]  <TASK>
[ 2682.197290]  dump_stack_lvl+0x5b/0x77
[ 2682.198143]  __lock_acquire.cold+0x36f/0x3f5
[ 2682.198510] nvme nvme6: qid 0: authenticated with hash hmac(sha256) dhgr=
oup ffdhe2048
[ 2682.199075]  ? lock_chain_count+0x20/0x20
[ 2682.199089]  ? lockdep_hardirqs_on_prepare+0x410/0x410
[ 2682.200949] nvme nvme6: qid 0: controller authenticated
[ 2682.201771]  lock_acquire+0x194/0x4f0
[ 2682.201783]  ? __flush_work+0x40e/0x900
[ 2682.201796]  ? lock_downgrade+0x6b0/0x6b0
[ 2682.201808]  ? mark_held_locks+0x9e/0xe0
[ 2682.207078]  ? lockdep_hardirqs_on_prepare+0x17b/0x410
[ 2682.208041]  __flush_work+0x42e/0x900
[ 2682.208736]  ? __flush_work+0x40e/0x900
[ 2682.209507]  ? queue_delayed_work_on+0x90/0x90
[ 2682.210322]  ? flush_workqueue_prep_pwqs+0x3f0/0x3f0
[ 2682.211209]  nvme_dhchap_auth_work+0xf1/0x1f8 [nvme_core]
[ 2682.212163]  process_one_work+0x816/0x1300
[ 2682.212858]  ? lock_downgrade+0x6b0/0x6b0
[ 2682.213589]  ? pwq_dec_nr_in_flight+0x230/0x230
[ 2682.214367]  ? rwlock_bug.part.0+0x90/0x90
[ 2682.215062]  worker_thread+0xfc/0x1270
[ 2682.215670]  ? __kthread_parkme+0xc1/0x1f0
[ 2682.216367]  ? process_one_work+0x1300/0x1300
[ 2682.217052]  kthread+0x29b/0x340
[ 2682.217620]  ? kthread_complete_and_exit+0x20/0x20
[ 2682.218313]  ret_from_fork+0x1f/0x30
[ 2682.218922]  </TASK>
[ 2682.254321] nvme nvme6: re-authenticating controller
[ 2682.292068] nvme nvme6: qid 0: authenticated with hash hmac(sha256) dhgr=
oup ffdhe2048
[ 2682.293937] nvme nvme6: qid 0: controller authenticated
[ 2682.334786] nvme nvme6: re-authenticating controller
[ 2682.364032] nvme nvme6: qid 0: authenticated with hash hmac(sha256) dhgr=
oup ffdhe2048
[ 2682.365898] nvme nvme6: qid 0: controller authenticated
[ 2686.934974] nvme nvme6: re-authenticating controller
[ 2687.345435] nvme nvme6: qid 0: authenticated with hash hmac(sha512) dhgr=
oup ffdhe8192
[ 2687.347055] nvme nvme6: qid 0: controller authenticated
[ 2687.738816] nvme nvme6: re-authenticating controller
[ 2688.133101] nvme nvme6: qid 0: authenticated with hash hmac(sha512) dhgr=
oup ffdhe8192
[ 2688.135123] nvme nvme6: qid 0: controller authenticated
[ 2689.624308] nvme nvme6: Removing ctrl: NQN "blktests-subsystem-1"
[ 2886.071612] loop: module loaded
[ 2886.269473] run blktests nvme/045 at 2022-10-18 16:37:28
[ 2886.533625] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 2886.726637] nvmet: creating nvm controller 1 for subsystem blktests-subs=
ystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid: with DH-HMAC-CHAP.
[ 2886.763826] nvme nvme6: qid 0: authenticated with hash hmac(sha256) dhgr=
oup ffdhe2048
[ 2886.765778] nvme nvme6: qid 0: controller authenticated
[ 2886.767199] nvme nvme6: qid 0: authenticated
[ 2886.769632] nvme nvme6: Please enable CONFIG_NVME_MULTIPATH for full sup=
port of multi-port devices.
[ 2886.772454] nvme nvme6: creating 4 I/O queues.
[ 2886.918047] nvme nvme6: new ctrl: "blktests-subsystem-1"
[ 2888.496721] nvme nvme6: re-authenticating controller
[ 2888.532075] nvme nvme6: qid 0: authenticated with hash hmac(sha256) dhgr=
oup ffdhe2048
[ 2888.534031] nvme nvme6: qid 0: controller authenticated
[ 2888.583146] nvme nvme6: re-authenticating controller
[ 2888.615654] nvme nvme6: qid 0: authenticated with hash hmac(sha256) dhgr=
oup ffdhe2048
[ 2888.617588] nvme nvme6: qid 0: controller authenticated
[ 2888.656311] nvme nvme6: re-authenticating controller
[ 2888.683953] nvme nvme6: qid 0: authenticated with hash hmac(sha256) dhgr=
oup ffdhe2048
[ 2888.685868] nvme nvme6: qid 0: controller authenticated
[ 2888.724955] nvme nvme6: re-authenticating controller
[ 2889.200478] nvme nvme6: qid 0: authenticated with hash hmac(sha512) dhgr=
oup ffdhe8192
[ 2889.202425] nvme nvme6: qid 0: controller authenticated
[ 2889.625949] nvme nvme6: re-authenticating controller
[ 2889.992842] nvme nvme6: qid 0: authenticated with hash hmac(sha512) dhgr=
oup ffdhe8192
[ 2889.994815] nvme nvme6: qid 0: controller authenticated
[ 2891.514773] nvme nvme6: Removing ctrl: NQN "blktests-subsystem-1"

--=20
Shin'ichiro Kawasaki=

