Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A8EC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 09:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vx+TjdOwotqjmz8op7RaeTTumaRkW2lc3lge9sWGP5A=; b=lERBOiuiYFPzxmpBv+czyCzvqy
	1QrF0m7YNTx6DESn/kd0uCGUi6HgBYbBfT0v5zVG2SOhHS88C8oVAddUAFKJNO7xPCqPTRPdDN983
	DIG1Zaxb/tPoUlmZCFJhJgzUtm642OfGNvtikVpzzOznpyTnHmF7TY+tmZbeVjDVQEPCw3nyVe1Bb
	XRXhP/Pa0OXJnldhe44+IzuI4+Yye3i2K4dxi+2fxP5GXvPggDuLfnNDdcp61n6zS4Ea/UxpJudJ1
	3LO9hKqtu5cMuSc7e38s72j7EknIvTJnjTS0SSMiN1HRRseNrz1cQH+HRzM4X/LJPVcnymaStUvBY
	5C5jczRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ousX9-009YPh-KK; Tue, 15 Nov 2022 09:47:11 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ousPR-009Tb7-5h
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 09:39:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668505152; x=1700041152;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=c9BDApo/tiG9iKT46KmLs9LKCpmnK53Ns7ozN8SInvI=;
  b=QxmKLnPNyQxeexJHKSSD/QFiRCbZ8gX5O9fvC+SslGpxbP8llkEBnzJK
   cdkeEOkAhlg2vHyOQAYP8iUPQpJ/rMPjdegHYEPVAs1rF5ZKt6hMBEMKV
   YAoiPNRAW2rmfocfYmiW4vSkHNwuS4X7GFqAgern80eVyLnfnuU3hcV21
   MvpluCro5M3X8cgosnSL4T+Jx2AqeVp0mOTD98d9GW3nsJQeViCGK1crm
   OCLEjtXuNLRoAtOySugochFcPmh80ctH2lBgN3cO+ghOi7UTQnPjk2dA3
   W/NRwiBiqisOppAvwCFNqpODzxPzWB1hZpbUFgGGLVHirHZAKxLSY80Br
   g==;
X-IronPort-AV: E=Sophos;i="5.96,165,1665417600"; 
   d="scan'208";a="214573250"
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
  by ob1.hgst.iphmx.com with ESMTP; 15 Nov 2022 17:39:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=beRms/XzAjFwiKM3ufGZWZE5p5ay3wj1bIfY/NikXXaBeppGn/UqFV4KS0Q54Kj/W52xkFhUlmAvYBsQ8/lgLGVDA3+XSLqbOj2GcRFPVrOuaTg3/xr6e8QMuRypPZH3NzrgiS4396TBicDIF79PEyabiGryHXtLb1az7duNN8ScCqUxQ39Cbs3lzjAos2dxWmrRmcg0xOm5CCl4ytgPJ2zsjK3KXBqvQyYMZkblzX80YJx8f738qmZNxNYYDa1UzseVUdIXqDswTMQgk0ZNaQJwwQdhlrDXgfbSvP4/qL4aNbsuay82zfvO9+5xwuzT/R1aySVOVzT4/5txkVHrGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vx+TjdOwotqjmz8op7RaeTTumaRkW2lc3lge9sWGP5A=;
 b=PtuMY5Ey+cpvHBGT7148o+gcaKA5J+lH88a8xgy4XaZcOqh3J8bppWLQzEPh2vnIVbi8AxvNN3Yo4HWlCrT4fjpRpSnm6R5kf+t1bDwnkvxrWeQdNFeUKwoftpFTcBBLfPdHZQ6Z2DAjf7y19mVA2kGmHKGNEd0+c0NBe0V07BH2GLdNHm6rCg7Tp6eK7Ei08CCKUHn3r5UQxf/3hoCR6a2R7l86VwwptJg0WkMu676CW1EfFNM0hgBr1wqC/QuG5ChTe6mnA35W4fc2OGlO7PLayyW1SmDxodOrymB6HxQbpjqcLknYB+94U8O83wGKDE9qZCq3+wX4RTzjAeUopg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vx+TjdOwotqjmz8op7RaeTTumaRkW2lc3lge9sWGP5A=;
 b=TQYJKFEkfRV4QVhvQx1aDO1nkKNPj6Lv+W/554kMdsi7uzo1PN+mNbIa6WG473HONEhUFhejPqnaeJw6ybXfCKK/BG8l5d3nObTxjPa1lTmmaVvtc9xrzdfxOkGWMcCYLac4ZnUwy4tXkJYM4gHBSTfgNBF0TcG/2gtnq010G8w=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN7PR04MB5251.namprd04.prod.outlook.com (2603:10b6:408:a::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.14; Tue, 15 Nov 2022 09:39:06 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0%6]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 09:39:06 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Hannes
 Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme: add re-authentication running concurrently with
 reset
Thread-Topic: [PATCH] nvme: add re-authentication running concurrently with
 reset
Thread-Index: AQHY+CgGXmtTUtFovk+c30l0oB2ILK4/u+IA
Date: Tue, 15 Nov 2022 09:39:06 +0000
Message-ID: <20221115093904.kdgemo7w5fk2bu7w@shindev>
References: <20221114125252.1086763-1-sagi@grimberg.me>
In-Reply-To: <20221114125252.1086763-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BN7PR04MB5251:EE_
x-ms-office365-filtering-correlation-id: 56649aa0-149e-446f-7023-08dac6ed3d47
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  hJkDlGpbvmUZzX+796rlham72omc5rvaxeS1cEqHdFJuwTZ0aQsU2dmCjdnBG6u+BCIwNs1X35bBpsDXsvlN+CSNAoSSerSTV+VGK0WUJif5HjJb+sRvL8WlgXP35fCo2ra1P0K2i8klz6WCtNhWamuvgWmiRiEzB5HVR5Qe3O9vpRR/6ZkeEb/yb0tJ9m2ZHR/zL09L+cvHHyKnpnRTgNe4wujJ/ah4/vUERcg+0xWlYw6B8Xbm9ddj0vCIabg081MQIiwi+0/glC2AB7leuw2m6rY/1F81Hkcv7wgKVIz/9K8WX6JuhWtcxU/wsV6uizNjp2oHS8mjjISaIOG3ap/vWENl9FoLwyodHkx7Eo14Ud3sn4gJj16zJyMmKQJjGwEw/CGuFr0AbQSwMgTx1QrK4PEr7lmhDI3WTIwd/ZWAfACc7Q4ij3uww5Mplm49HA19/lc8DtMGcDXghxrwM5Kcks57H3mP8K9iaWRjC8A0kmthca4s6yD1Z8KB93tykqLmXm/+s6J8ac9RQQomiah9H1nToGMAUXBnzbEapluDlVR6G/RBSTSAOugwkFv3+Q2UNZj/70irSAX22sKVP7vl1mUcAp3lF+2/L9n5gVMojzrGsPdrCno66k5tCcigmlw7Fyzn0zo7DqhwB1m7to/GMaUJ6lJMj8Jn2Lq/aQDgtLgWJ5RDjyfqt0jYW9+g57I3BaBaYnY2pztaLbUfnc7ZXqinVNWq2qHI1TTOG4qhPUVNdBfKlhqtAnPhjf1iSu9rd56wAAA8bY+ItXGrAQ==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199015)(41300700001)(5660300002)(478600001)(83380400001)(71200400001)(44832011)(2906002)(6486002)(8936002)(82960400001)(33716001)(38100700002)(122000001)(86362001)(38070700005)(6506007)(9686003)(6512007)(26005)(66476007)(54906003)(186003)(66946007)(66556008)(1076003)(66446008)(64756008)(4326008)(8676002)(76116006)(91956017)(6916009)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?n0aHFEtI/3mt9J2J0eHGCCsCHqA6cb0DK5R802QLVKMFGyKF5dOy86JVD/N6?=
 =?us-ascii?Q?ImF/wHA9caE1cHsIegWb1BanmoIlO30JojiCg1VCwHGF5UDYQRiOaor1lvK6?=
 =?us-ascii?Q?hZo9xp2B5k9RP4XnBMdVpgQxt7QUKlC2okQvDla8XSmow2SEm7Tqn/D0Tj67?=
 =?us-ascii?Q?OuVcwCLyOfuFK77cytmIe1t5DagNAf97NjYMeGWqAOGEeAGMjc7QYJ1CdIDp?=
 =?us-ascii?Q?x4z53AssMjiUmT+InSK2abvy5f74aLjXdj2DsWhjHm0MhHOhnwSF6rr3JYFM?=
 =?us-ascii?Q?IABlkGJWoL5e/k9/W6R/vCb4hES3+CJty+aNA0ihMgnAEwLe5m0L1n+aK6K2?=
 =?us-ascii?Q?edqzZZVZwy1KWvbf1yqwin9FFZdS1Imb85esw4nXOucvtZM3A0b5cdkgPtwX?=
 =?us-ascii?Q?WWiKFLMwceWfT+VBGjWgFngmMWpH2oLQOZbP0cjM+uoAqABUoGD19T8v1/qu?=
 =?us-ascii?Q?DIAmtFMhbOPeSZRpA29/qMZUzgUjYCuSzEpGL+WDc9nl2VbdMijzCel3nMKW?=
 =?us-ascii?Q?7JBU9vk5eZ4rf9ni0NJofuM13JActHUN3p+m/1ZyNLoOGBOyECKbLUTtd5lc?=
 =?us-ascii?Q?V1pck3WPTuMRCi5VU6ytJH8io8H+AbyS+pdGd8SvuahXsSTHgKP0/DNsUjIx?=
 =?us-ascii?Q?5zYUw3rTq03M6CFQoBYZz8yfEa4RKy6PXffAT+1kBudKP/xiXnUwafLuThxb?=
 =?us-ascii?Q?JmbvAyH6z1/9TfSy8iDIy2sSrZVK3Q0ADS7Wt2BRYxQ/7BogmLRxr+1s+WCA?=
 =?us-ascii?Q?2Ju7Xel1i6smpSlpKcjvL4jotUf4NrK2rsSBVPN4CAp7CJwv6yvHFVLeI5WG?=
 =?us-ascii?Q?YcyBElXdne/ah7YadvSup9mVmNNhpntuRG3quHgcSCSJtQ8oFLWrF2Q1KH0k?=
 =?us-ascii?Q?f7cXUFJHv+XfcasDzUIV1KrCuEddJSa7b0Nk+IpfTDutg1e2ELfBgKgisWGw?=
 =?us-ascii?Q?HZAgFBJTkiEiX6WItEoc0I7M1XOl6iNuTSHqs68nRSL45c69ImqoaPw3ecQM?=
 =?us-ascii?Q?js6pa+9L0nGNUXflvcrq3KjVXDIa7rPRQWVIVUCai/tKYbRP4aKPjfgQ05ag?=
 =?us-ascii?Q?3XdBoDjWgyofH3w+YGUDUZ2h/n+2ZG08MpNEylNp0vz9np0zeuZlT1ayIco9?=
 =?us-ascii?Q?ci8RACFQS1CQvc4/xBqxDZQII8rVq2SqUBlN3vmhjC78SLEv2Gzvc/Ave/QH?=
 =?us-ascii?Q?IApyCF+ixVrd/zJ+jr1VzcuIYsO/qodkqlVPM2BqCif2HQbVPPa9XNrPtbJt?=
 =?us-ascii?Q?FC+q5vZWhfWJkWofdtyITt4R4mXZmKWgc1fvmAFXwdXe0ZbgJFBZEE2VKgNj?=
 =?us-ascii?Q?d95xH+boUpmehxQk3iWOhHJHcfV5xKbbmMPBdXTcOtyI2ozaX+wyIV4OkAZl?=
 =?us-ascii?Q?wFo2oqx6Sl72OVCZKViOW2twufoyKIawqhCdQ3Cn6PIYxOBG2htYNte+lK4a?=
 =?us-ascii?Q?BEE4tKCwIFQVYaC7zavu4E+/K3h9Eh+h6CbYiqns5jHg92e2xgFLyN82SlQs?=
 =?us-ascii?Q?fQ+Gqwse739cskd/fnJ8TMXTfT5N92dKxLPBXqzPHky8qiuSOh9ORNq2qFaX?=
 =?us-ascii?Q?tlfcbtNAyexBMAu8iVDSnALnjImEibvkqXOGD+hPKpJB61tKL4N6HRs50BtS?=
 =?us-ascii?Q?KRiWSPz2TCj09ASpT4GNj+k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3EB7E569CBD2104FA294436EBE8F926E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	DUgwJCcXKHFeJfI5KsvWbXOfRmmc0kPEfDT1JOQ833P+gomScHjqjKEDZgYBy4W0fi0F0/vlo4xBDc8dhPLALVi/XNnSMerzr5aYjv0MJSX/MmaZ6zCVEviO+4To05c0SXhp3DFVCTrNyWfZM38uE6ykO3gBFccIHV9QLTD8s7ICVV3YWUI0TbUpTUEmARl9cblSn/aNgRtj1f6St0ADcFdhK2s+s7aE3C2CAOqje2wEBETEjJb5F4ydzdvHoz82Uyu8myARChskDfM/HQatFSkZzrzeQZ+2ToTNI8aWQdmz8jQnPrKUzZiHDuQF4VISWPhmnP33y/OucY5+bpBWtg4czx/QBO72dfSiAleRiPD54034TeSH5MfU5jwwWXpTEiENcdvt0lbrzc7VfHHmFBpX9y/Xz75Oyv/lXyCEN+dDqY6SpaZ6YDhUI2RQkzLebs03/hq2fwBBkChqNmQirprJAMEBgz2wYYa56nhp36aLRPTayCAjW4x4s0CwvzFBSfzKf+yRUaieeaqan49K3iA7C1PKZ24iEloPDMSIdrvv+HFz+RB622HmprkDY9R3QDr9wTxABoY9o01o6q8M7qfJAlEsJiDsz4WVhcQcCmosBnb/EoZzjA94m0VUX2mW3GlKeXTTqFh8Nmh650QUkIfELFHTCNEY/Wq6ZsIrgTYkJhaCZHZmAnGWbbhQX9EgJDXrQQZlQCsq0e80RsUMJYfIHA6yH3Szpd7eWi8XdgF9gRlq5OjixOlZgn8FrrBb3x9V3xPxPAn/5XH4hy1T9U26Mzpw7LsFCigDvjSmVYvgZQwc9jWKp0GYTDJRtJs0dlrqmMb1BJQiTcM77HvpblOqqdji1XAVF8sQXM0+BlI=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56649aa0-149e-446f-7023-08dac6ed3d47
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 09:39:06.3519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oy2WN04ZwU45X/m0UyhHKFw7FhhikSYb8UsOhTbeOEl4/0WkJZxlKkOrMXGfiU+yg+/34se8t2Bq57mdFDaAiFZuB5i4hgwZ0yQ6WwNYIoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB5251
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221115_013913_344247_0337F90B 
X-CRM114-Status: GOOD (  15.10  )
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

On Nov 14, 2022 / 14:52, Sagi Grimberg wrote:
> when re-authentication with new host-key and/or ctrl-key there is an
> async work that is scheduled async. A controller reset should be mutual
> exclusive with the re-authentication work. Add a test that triggers
> re-authentication and immediately resets the controller.
>=20
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

Thanks. I believe that this test case checks fix of a problem found during =
your
work on "nvme: fixes, cleanups and enhancements to the dhchap-auth host cod=
e".

I have some nit comments. Other than these, the patch looks good for me.

- Shellcheck have a couple of complaints:

  $ make check
  shellcheck -x -e SC2119 -f gcc check new common/* \
          tests/*/rc tests/*/[0-9]*[0-9]
  tests/nvme/046:87:20: note: Double quote to prevent globbing and word spl=
itting. [SC2086]
  tests/nvme/046:93:20: note: Double quote to prevent globbing and word spl=
itting. [SC2086]
  make: *** [Makefile:21: check] Error 1

- The test() function lists all local variables except "hostkey_file",
  "ctrlkey_file" and "nvvmedev". A bit better to declare those three also.

- It would be a bit better for linux-nvme readers to have subject prefix
  "[PATCH blktests]" to clarify it is not the patch for linux, but for blkt=
ests.

--=20
Shin'ichiro Kawasaki=

