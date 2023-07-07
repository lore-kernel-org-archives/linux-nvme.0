Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A226EB64D9
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Jul 2023 00:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PY2hFS0GwUh3CYgsG9joqww8dKu2sz0Db6pm4M31MiU=; b=MbNCZU+SVFhUQvi6PddOX3zeZH
	oBCILMwXpU+SScJgOBPTH/hg+QqMU9m6wOweStk9+QLabIm78O1qgNvxJEPG2eSQ+4jTfkmFicXai
	+aP6mSJFB5oat6xrWu6/f/qaRlilrMhR/8WP9/pLOGLTdA30hBTEPS7xBs91vCLTLOYfKn1QMLhLO
	sxroVVqfEHFcZoORFlqEra+jt3ucooOxWWqSdwhj83HUarrkn5pImiuqDORbvIJV6we9cDyN66MC3
	RAQVkjM6gbT3gLTeNOm/Crv8L2Divej1rzjtl5Qm6IKGnQ+v+BYnrdsqYlToOqKMvxx/8Z9ZhRMR7
	BTt7TeGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qHZPZ-0033nX-2Y;
	Fri, 07 Jul 2023 00:33:25 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qHZPV-0033mY-38
	for linux-nvme@lists.infradead.org;
	Fri, 07 Jul 2023 00:33:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1688690001; x=1720226001;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Rg5MnzhTJK85yk1L/z1n1AOpM0xgRzYCrMoyVtcBKak=;
  b=bMgJNE8tZxFjepsfAUDIhRRvoDjA4yZRFwV26440QelJpY5R2pmQDPoW
   kQmRIuKct15L2HZRmkexqnsaso8/1oJuzR0fJ0i3wMiiEin/MLfYlZImi
   NsiqTmiyaBXKlDHNX5nnD+7oHVZsJF/zg5NMFbilxOBwkyIYebedh+obC
   k1R4FjLFQZmrEDO2r4bPP7IvBFlghZaGxKoGoe8mI0uH4sUpi40+ZZshS
   XkNudt/Xo8rvhVZJZWMlPFb1rrb9QZ2dFp4gQm7+ymPVZEMFarNEy/ZKC
   dTAcRj61Jx1LWFcdXFT3m8/hXsvz2qA3Bjud+dv5YVflDb/psFFW2iwB8
   g==;
X-IronPort-AV: E=Sophos;i="6.01,187,1684771200"; 
   d="scan'208";a="242063418"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2023 08:33:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=in86daFchr/NCK3Bikx0PxIhs6lt6Pzfd7xaRcZHPaRX2DEN1lSyS/KWpomy56KUyaWnQ5s8DxBjxHF5W3zq6zyIAApeJq4kwe5kB4wFJ+9498tiWHy4NwIS0U1dgC8rEnkC2Ckhv7GZ9mAnlg7INcVHv+cr0oQbxL2LIyA65rlaYIOlox2A9TonksO8ZzEcXA54By36775CH/ujokWyE0AbRAdRtGwyF9LSNgMH4Hpy2ExEQZX58b1cBB5jPO9JTj0ybMct8fNyZEzntVAZqt1E2EkpGvlYLcR4dMOqrqhIwJ4rj018Ri6gB+S1rQYZ52rmfirOW2O55pV7cy2ThQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PY2hFS0GwUh3CYgsG9joqww8dKu2sz0Db6pm4M31MiU=;
 b=jSSzeUzV/DWXtnXnynWtfXXEeENteGlu9QmlDdC8pHKj3sXpfO0GkQwgEbQ/IMyyEp6C1GDB8siMLprbaUnK3rMle9LB6O9urWBKBftO4lWWL4zDyxQiaBRW6gw3rcCb1emQNS9ogC9TWxu8NCk22ZRcqMLWgtjmpQ1yUGHyGys5dQRjtD1Jkr1UFCfHQpkDEJBPXA3GBSZOEG9nFcuIWTnnFXvDdFZwhT0YQDxAoJtDVXDWqOcwImqhlxUngFFTfbxeZSwElLMtRIeTQgHRJeB7PHO31nSFkgygy3LzjEogHIWjOwXDIjjIR2Bn1YeeDkzSb2kCRUPNRejC0Ya3lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PY2hFS0GwUh3CYgsG9joqww8dKu2sz0Db6pm4M31MiU=;
 b=rsWdwTRtTUlz/MC8Koo2K4a4mKyFE8poMU7qqwwFEHCi9YOGfzxiZThMVS+VXOMbTMSlw7ybnQ5r/RrwLCiD8MbnziQGt/EDXK0MlIWMsF8n8gVBExLFB0iTJ1VecO7+Y0tdH78Y0Tsn50AzYzwbLaCU0n7MDWWDBMyMM7QKwN8=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA0PR04MB7227.namprd04.prod.outlook.com (2603:10b6:806:ed::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.17; Fri, 7 Jul 2023 00:33:15 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98%7]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 00:33:15 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Max
 Gurtovoy <mgurtovoy@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya
 Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH nvme-cli] fabrics: Use corresponding hostid when hostnqn
 is generated
Thread-Topic: [PATCH nvme-cli] fabrics: Use corresponding hostid when hostnqn
 is generated
Thread-Index: AQHZrIxDptm5CZDsM0SFPDHqp/o0Dq+q6z2AgAKQ0YA=
Date: Fri, 7 Jul 2023 00:33:14 +0000
Message-ID: <4zduyt6s6zds43lllvckuwbzycpvjuhl2vwwugj4xsl2oe3njd@776mjcgc5kbn>
References: <20230702022346.3150889-1-shinichiro.kawasaki@wdc.com>
 <rehxjlrcqlihlxgcrnezbbludfxdlmqpo2jyemau7g7yhswic3@ueewl5oraqbu>
In-Reply-To: <rehxjlrcqlihlxgcrnezbbludfxdlmqpo2jyemau7g7yhswic3@ueewl5oraqbu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA0PR04MB7227:EE_
x-ms-office365-filtering-correlation-id: 12eb8b28-76f4-42a7-a5e0-08db7e81c097
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WfOWsYvQMfvAhy61FlCM/RhuJgp9WFqpHbWVkhXTax+X5pXnk6vSPETowxyEKi+GTAWnV2EMG5HdIfvYELKMrpV0qEd4lZxqxXKCsrHOhcJNwbHBviBrZtAsRNyjMT9gzcVycEVMsArVA/juKF4A3VSXQF4cQnygBbrpm/VKEjuSMIgx/QouOMyK26QOV9shtRO5yIbKm+o5XZx8VnNSDKGdj5IdG3NObqUYDTkOtht9BJv68oe27ON2izcw1JdccAM/0q8wy4LK91VxiCGU6zDxtaN6qlCctxr97JMvM3yzLrf6JCySkBmC9Er5eABSS4QsHW1QKrpx3f5in8c7JTqiCePA0pZ4WRtwWKkWM9krvrhgE4NzZ8Us4JGF4O7P3LVz14VZ21JNOYYhtU/qhpEbWcAsjYckA+AD/uLmeCqvzDPBbFYCF864uk0cE8byqdSvV32aGjLeIcxFdkojwHKtylbSdgQGXIP8IZFtuZId0Skn4IgkgV89+FrKAaW75zM8oy0qaBQw2z9GqKLQlYLObPkLDcMe6TvoQ+RaUVwMsb0c5s/maSTxKq0Y13M4XL9KpeJCfg8ZL/0lwGLxk8QKeHzByHBrKpW47YStTcY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(396003)(136003)(346002)(366004)(39860400002)(376002)(451199021)(66476007)(478600001)(26005)(966005)(6512007)(82960400001)(9686003)(6506007)(186003)(86362001)(71200400001)(316002)(83380400001)(54906003)(38100700002)(6486002)(122000001)(6916009)(76116006)(91956017)(64756008)(66446008)(4326008)(66556008)(66946007)(5660300002)(8936002)(8676002)(38070700005)(44832011)(41300700001)(2906002)(33716001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HJbYbYiIw44UffCLXR0u97GAmBWmTJmbByDwFjQPUfBvKL53d7Aqp861qgl8?=
 =?us-ascii?Q?XtBXBhVT5kSpzsuVTRD+fzgKHcOsBKtTrinmmVOweZookjfY2PlDlx6fjU9O?=
 =?us-ascii?Q?IK8TmevQ+LhUP45Q+h5X/mmz2rGegQ8B65V3JOggn1Yn3KMVgagGGGf42Qc0?=
 =?us-ascii?Q?Jl493zVhChKcJ+IY+YmKkJG1V/SDYtUosL7llgMJRc1XwMrJLNoAZl5i60Ko?=
 =?us-ascii?Q?H8r7MDLNbA3iacDt4izpMcPoD6TUnG/xkiXtItyZRxC+8vLLJOOIpq4FVVUK?=
 =?us-ascii?Q?BiUJ8babd4oW446WLse91a+OnvVFm3q43iaygN89A0oJTGRD1us71hnymMzq?=
 =?us-ascii?Q?MdokkLRDGFzxnmHgPLkS8wDlCY6pdGgxcBw8tIFDkLSykepxNQd2YGDNBG63?=
 =?us-ascii?Q?Xf9t7enO7ttxKu7OqMrQTnmi4MakciJqIS7Ue/087BGAJdG3vOb2MH622Dtz?=
 =?us-ascii?Q?nEZlf2dZnRRvayYdajsOSqbfeLfPNtYi9vPT6sFGPIIpHk+mR/c1+vmQp6zX?=
 =?us-ascii?Q?7yJTrRgu8X3OAL7C31cq2djVhTDMJRBOEROFnHQR8ZGkulZAIosoJEjDQkix?=
 =?us-ascii?Q?Wpah8GdpdokZa9rE3cPZEWpC6gaQPMS5YVokSQ4dp/QNLb0RVKMpgras5B0X?=
 =?us-ascii?Q?VIAZpED2kRIcjShE2z1GN4LeqF3j551UktieN+AcMwJq5GMWIVqIAiPuBaAq?=
 =?us-ascii?Q?7VnVH4PRC8kvey4yoGxr1ctEiWWRCqNODzpsJLm/YpFZMHHQ6ZsTGtbukhIz?=
 =?us-ascii?Q?/fr5S5npso7dX1Ebb+9fjV10SyRRJIRr+Vh8mLtckv51MSHpf7rSBvzComrb?=
 =?us-ascii?Q?+9nl4//i+c8VXZMkCR7pKC1hNVMea+JNThUwMisPPeH7ECd2TI5odrFdRmXv?=
 =?us-ascii?Q?iuOLSZj/8zUwVdGc6vJ+quANpT397s+AlYRHXuklB8CtfLQwJkUsvkWVoTcU?=
 =?us-ascii?Q?fylYOKZI5qIipVtiRmj6mvGfiAWuFdvyXAGEOmu8CsAfPrJl18XzKtRZjwy9?=
 =?us-ascii?Q?FcwxB0BlOMovHZ7/W+Oe7gNrGsCIn3JWVsqL3g48+wSJiSQnNfZ7aaMwzC7z?=
 =?us-ascii?Q?IoC8ac0lLKn5ngL7fqAHMWx1w6pIEPLqk6lcGFbyO/s8mL8WIz0RFRhbUnGl?=
 =?us-ascii?Q?gjCcWhOaVPsdrBsKsmJhPKtU6jAekn8baPEvm0FFHqtySrjOctP3Nqmif83W?=
 =?us-ascii?Q?AQxYKGDbdBfCB2bb9LOsgGwcY4VqkaVTe1qj0xfm8umADlwFYTEGrQQTmn9P?=
 =?us-ascii?Q?yYU5QC5/cWuXz/rpYlJ4qlkhv4irLu7caCfDM7ERR6/nZpPibKTodiWJd3Ji?=
 =?us-ascii?Q?Z0ftaLFkHDOJZy9+B5ltvtHZX3rZlXfQPdibpIn/mRGrrQuzQM39j5qfbnU0?=
 =?us-ascii?Q?Q1uWoAiSKjVsQNJlGa0TgkiI+ZioodKxSk50H/AparmmOJp36j+gCY8wnmog?=
 =?us-ascii?Q?HixPaXcs2otZcTEaWUA/caZFXN/SwYHZkZm//40r8igJa+wjjY46lVJ0Bb6Y?=
 =?us-ascii?Q?yQObKpajEI56N8nl+M/oXuvPDrMDz4x5fI5XvXWgnQ5X7/0t71mUEnoLWqL5?=
 =?us-ascii?Q?J0PUmwXeQ6dw1poIIKHXuYLY957u35uUoRSeq0VnGgvovnvFAxYc4q2aSheJ?=
 =?us-ascii?Q?a6MT4fSPXRdXLu0qzW49pfo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B1EA64CFF86E7B4FB35FC9767C935F52@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tnfuxjS4EBJBrecxc9BVoFzQZyqJF0pmX5DhhArNhO+buheJVOdCyjfsaDbw8+H+sjHvcHECDW9Nlr4PlO9zjk75gSSj0ATuA35VnLbDCVgpphEqLvGvXoMEcBetQUmj4PP/BcjzNe2mJjCpmyFW6Bhu5Ac94oHDuJ7U2as3sMJ0LJMQMFp4+ACBBWKMA26XJx6LFWVu+Qz65KM/C0B5dOgmvNrZmXbqKLmeO8laUU82+delP4uixnBm8Z7OLZFmnABiaIC6DCj3KDFcKx/4gk1Dwx3a35qi0zFTsMXtbqeVTOAa8SqVhqN6U9/AGPn8pFt+MOwm43+dOcQg/PcJoL6SN95iYahPxRAH5JAf5kn+T0Aj/g1LC5WEn0Bt8Ud13UGf79ig2+ZRVQVGYaEdSZq/8/WOl9/cVQsKoF56E7iTqzkIPKFtmIKRs9HRsFL8WiZb4GCjl5PLb9iX7eKWLnrWm41I2JsZMU3AHCsUb56Q3Tgh3t0jmlZNTMnCjVjUJnYUP0wzqO8l2/XJ+EHgGrwFmL8Vrile21RnDEjgfJGX+LD4eHm0YdUb/Pcr3k8b6yAo/7GJvLiX7aOIg8H4pgTfy5sv2tlXUh73kDBUraaI8PPtkcX0fOc1cTel1lz4P+em7kqAARzmc5KE16/ITl9awf4v5eET3yQKhzy9wY8ci18Yd89UPouXLfJbPkYB6QW9EHxuekpVBG4UAA2M/FwDuJ7Jzu+BOVdtff+Yu/+EfVeZDr9Q4URO+yVFzGLpTeBKZFgAZgMg3wnF0Lpw48puakoy18ZcznKxqHDQpoUxNtR7n3dDQLuYpDW0UsE8r49+sGeHAzxa9Nl2rUEHp2nom2mnaK6aWfKT4mubCLJQPb39HBgM3lnzVtoAinHO
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12eb8b28-76f4-42a7-a5e0-08db7e81c097
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 00:33:14.9943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8oMprlKpXZiB56WC+pwWrHfeK4plGP0VmwvIDPcDYw+Wm2XpHgaoXUigw/sRDLG0licVyRuwnhrqofDCifaX39HwESqGxB4clVebnggaNtI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7227
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230706_173322_068475_128BFFFD 
X-CRM114-Status: GOOD (  27.38  )
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

On Jul 05, 2023 / 11:22, Daniel Wagner wrote:
> Hi Shin'ichiro,
>=20
> sorry for my late response.
>=20
> On Sun, Jul 02, 2023 at 11:23:46AM +0900, Shin'ichiro Kawasaki wrote:
> > After the kernel commit ae8bd606e09b ("nvme-fabrics: prevent overriding
> > of existing host"), kernel ensures hostid and hostnqn maintain 1:1
> > mapping and "non 1:1 mapping will be rejected". This makes 'nvme
> > discover' and 'nvme connect' commands fail when they generate hostnqn,
> > since it does not use corresponding hostid.
> >=20
> > To avoid the failures, prepare and use corresponding hostid to the
> > generated hostnqn, taking the hostid from the hostnqn string. Also warn
> > when the hostid is different from that in hostid file.
> >=20
> > Link: https://lore.kernel.org/linux-nvme/l7vk7fnzltpmvkwujsbf2btrzip6wh=
7ug62iwa3totqcda25l6@siqx7tj6lt3l/
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > ---
> >  fabrics.c | 28 ++++++++++++++++++++++++++--
> >  1 file changed, 26 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/fabrics.c b/fabrics.c
> > index ac240cad..2eeea48c 100644
> > --- a/fabrics.c
> > +++ b/fabrics.c
> > @@ -677,6 +677,26 @@ static int nvme_read_volatile_config(nvme_root_t r=
)
> >  	return ret;
> >  }
> > =20
> > +char *nvmf_hostid_from_hostnqn(const char *hostnqn)
> > +{
> > +	const char *uuid;
> > +	const char *hostid_from_file;
> > +
> > +	if (!hostnqn)
> > +		return NULL;
> > +
> > +	uuid =3D strstr(hostnqn, "uuid:");
> > +	if (!uuid)
> > +		return NULL;
> > +	uuid +=3D strlen("uuid:");
> > +
> > +	hostid_from_file =3D nvmf_hostid_from_file();
> > +	if (hostid_from_file && strcmp(uuid, hostid_from_file))
> > +		fprintf(stderr, "warning: use generated hostid instead of hostid fil=
e\n");
> > +
>=20
> As mentioned in my my other original mail, I'd say it makes sense to have=
 the
> check after ...
>=20
> > +	return strdup(uuid);
> > +}
> > +
> >  int nvmf_discover(const char *desc, int argc, char **argv, bool connec=
t)
> >  {
> >  	char *subsysnqn =3D NVME_DISC_SUBSYS_NAME;
> > @@ -753,8 +773,10 @@ int nvmf_discover(const char *desc, int argc, char=
 **argv, bool connect)
> >  	hostid_arg =3D hostid;
> >  	if (!hostnqn)
> >  		hostnqn =3D hnqn =3D nvmf_hostnqn_from_file();
> > -	if (!hostnqn)
> > +	if (!hostnqn) {
> >  		hostnqn =3D hnqn =3D nvmf_hostnqn_generate();
> > +		hostid =3D hid =3D nvmf_hostid_from_hostnqn(hostnqn);
> > +	}
> >  	if (!hostid)
> >  		hostid =3D hid =3D nvmf_hostid_from_file();
> >  	h =3D nvme_lookup_host(r, hostnqn, hostid);
> > @@ -966,8 +988,10 @@ int nvmf_connect(const char *desc, int argc, char =
**argv)
> > =20
> >  	if (!hostnqn)
> >  		hostnqn =3D hnqn =3D nvmf_hostnqn_from_file();
> > -	if (!hostnqn)
> > +	if (!hostnqn) {
> >  		hostnqn =3D hnqn =3D nvmf_hostnqn_generate();
> > +		hostid =3D hid =3D nvmf_hostid_from_hostnqn(hostnqn);
> > +	}
> >  	if (!hostid)
> >  		hostid =3D hid =3D nvmf_hostid_from_file();
>=20
> ... here

Thanks for the comment. Will move the check. Also revise the patch to warn,
 - if it uses genereated hostid different from the hostid from file, or,
 - if hostnqn from file and hostid from file are inconsistent=

