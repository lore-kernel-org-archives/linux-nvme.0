Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30812ECAAD4
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Aug 2022 10:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f1oeWagmX+D6NnLeUHhP0dhPATXErJzW8KxQqaWqCqw=; b=PRRREHX2TCEyAIgf7GUvcb7QsH
	3qIkxSbe9QUMcYdjPXy04zCPz0kCuXoNvSx0dF04Q6ErzRFjgtn4mI+Z9g3QOmJ38+Rtgcqz723g4
	BhzuO9G6+eOla7fw1cGU/ybvggHekYYEZhtqZ9cDNYj+Q8nSGZIR/rvfL3rzIzfoA5uWF1nq08CZy
	x9tFQ/xa5lwtpiHb+1ym0NH8EJ1ghTRXLacHaUpwbFuUajcg6qPSU2w9/A+sO3R2tZKtrbsSCIj1G
	N4gYMpqiF5/2xRekua6bGfQr+g05pXuT5l/bte95rJ1iaFt9NWtNix7YCh7t795x67LzjXi/12hpj
	80HWG+SA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSyoC-00GI1H-OI; Tue, 30 Aug 2022 10:49:28 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSyPe-00G8f4-Vy
	for linux-nvme@lists.infradead.org; Tue, 30 Aug 2022 10:24:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661855046; x=1693391046;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3cqHWXl/kIRunxsGswRMnmgES+KMH1iVenZSHR1rJ8A=;
  b=bvJMlOndwTcUGhk3GlD9F0unBMheDK4yLakSuvCrmUDZ4NPzQ9u/SbUK
   gIyL8kQMfdWsofZ/BP6DAsOQVefQmZR11zHltmYg8BfgkW2qIoZQK/tvn
   aVksamRyu/fyipYCeI211pVYCuDKwTYRhAsDzd9lw01WQ27RGUkWKAC+4
   RPoUlo/HlwFegSlZBXXN20UekTlr/ax9MFAPuiwgyzpYoZlwqjhFFnmqb
   Otcpjz+NzzXSN8qm0Rs1xwYXEMbHg4Pih912YR+gZXn/u2qyUpYXxn21f
   nicCiOymOef5BwDdVIiYPjq7RETVZ+subbN3ut/umkbOrDLqFPoCOQ4lE
   A==;
X-IronPort-AV: E=Sophos;i="5.93,274,1654531200"; 
   d="scan'208";a="210511840"
Received: from mail-mw2nam12lp2047.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.47])
  by ob1.hgst.iphmx.com with ESMTP; 30 Aug 2022 18:23:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ayOsNHMZSoZz7i3CINDZ2MkE15+zBEn4x2vZN600p+KNsk03Lv/S1c3HiPEVyfFMtgBwN+/ZhW7kymTe2C3sEJyuxQP9xnFilagg1RCH9GUYKRTy0t+nogYMSnIQUmOC2gzBGUv0eIwP4CB0ORDEXcef22rYwWWG8fUqfWXn74NW3e6X91gj18EMGZbEt5H11NlNgGRUnjonXKq/WNHArbO4kEjVMu2TfWv9SKXYt4wKvY4S9u/ZqBy+hN/bozNx6wlOOVoXgeGCTsCDnuKksn2JLR8qLQ0e+N0N+vDB/HSdTn5x68peflhygiBKcyqSk3Tu42nQNnfUJGID4WFRZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1oeWagmX+D6NnLeUHhP0dhPATXErJzW8KxQqaWqCqw=;
 b=O5phGyNM0mdBXSQcn9h1Ue829a9qCT33qEAAP5qQ4DbSUt2RbuMxLKRUlu+/2uzwAWxAvlAo/vEN8wohFx+TxaV6HOzlQRdENgm4PJhZOsddIvpdBpftOvkMXLUpnbzZlP4LBmjjze6y0Gfpec3WOTKEkmiFfNVZMTJrmpoLcI9C3PHl3C0oToVNHrJcKv19rMiz7pMbrbwPd9BrBnztkwKXV+l7xP0/3U5RIBarE3Wqgd4KOwaVQe3Oh/+whNcs7XhHKjV9anwSrt+aVPA+j3HimlpYifvwDkwhYxsnsr/bM7LnZnDhCTlmHu4UU+FCTAF5RCfRToD5ctfylxHRsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1oeWagmX+D6NnLeUHhP0dhPATXErJzW8KxQqaWqCqw=;
 b=YFClYq2lnFN1CZd7lgRA931+t/KYn7HbRitJbxrtBrIaxOoRfKkutSMLRAs89ZwByB42RW+CHFwFXCtG0JXRyJblxRsFrXvdxBSTGansaIsQl/Kh+h7DGIYrae3wasbg3eb0XKpQaoerPOHRu7+lCJ1PWv2sTMMC8nlveR7Drj0=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN8PR04MB6353.namprd04.prod.outlook.com (2603:10b6:408:7a::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10; Tue, 30 Aug 2022 10:23:58 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c7e:a51:e59a:d633]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c7e:a51:e59a:d633%8]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 10:23:57 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Hannes Reinecke
	<hare@suse.de>
Subject: Re: [PATCH blktests] nvme: add dh module requirement for tests that
 involve dh groups
Thread-Topic: [PATCH blktests] nvme: add dh module requirement for tests that
 involve dh groups
Thread-Index: AQHYu4JqMzYWLRy0pU+II16FtTMMiK3G3+4AgAAmugCAADeMgA==
Date: Tue, 30 Aug 2022 10:23:57 +0000
Message-ID: <20220830102357.yahkv5qfr2ewa7uh@shindev>
References: <20220829083614.874878-1-sagi@grimberg.me>
 <20220830044632.j7k45lhdlyvksrxh@shindev>
 <05548286-8d18-e3b4-06db-640c9d6b1399@grimberg.me>
In-Reply-To: <05548286-8d18-e3b4-06db-640c9d6b1399@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 469988dc-332b-48f1-111a-08da8a71bfa8
x-ms-traffictypediagnostic: BN8PR04MB6353:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  GyLMvKEf87aE+TrdYHiA3uWbAfR0HZ2RvubLCQjYE+FQlwUOf5Fncb08u2teanVCBF4JbVDCv0lC/ZQyv8VVroba17OyVhXctpqnGNsjCV/JVnTqu04ihviKDpSVppyX9okkb6SdOQiEYJ01oRs68i00Fbq7zy6oROP+ewCEwkIUrw3/T3j8HsIeq3pJuJDXe7N8w1hBS1gCgen7RCErMPqmYeFrgUg5RYQeOl1lDrZI2w10nbiJQUQqJBIDlnTRqdh7p+hhtnUOldGixR3WDa8WTwXy+CAiP7ExLp2RCACXkL6FxIHtbw6Rq4+euZSDUS6FqBqap5SXdj6pxcu71tDAL48pbPVtFkeaQabFAiJ9j5of7UuqpBlIJpycrlAGYhvRe8RsXpInN7ek1tolko5Tm+28xhy3qmfNH1yzjpwxLtc0PbuUdPiYYewz7QIpCMPPbQnEuX/iTcfURDca3IOgvgE88Crck4k7/G/4FMZgRHkw2UdlMj0TcADeI9x68rHxVsEXRnyzFEH98ZavPi3zrHJNbYwbLI+b+IDqj1PTx6zlFbfvfAyJSztjPvYqP5Lfxf78yXDKSHZCUtyf+UNmTSu+pEHea6FjWXnRTsqvdbqUz7grCPE7dJQClhft0Kky//wUIPuObit++hEL4ELK7CrBznKpPwHxxnj7xdCfNHz7l0jL8lFXvJsnCf0zacpX4qnnq2q7HACJWgcN3nZGo5fe8u0LYB/pPdFEFRl4D8Gce1dwPb0IJ9+04hxNf1z1m4864WS0K4RbMs5JOQ==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(376002)(366004)(136003)(346002)(396003)(39860400002)(64756008)(4326008)(66446008)(66476007)(66556008)(66946007)(8676002)(478600001)(76116006)(6486002)(91956017)(316002)(71200400001)(6916009)(54906003)(33716001)(8936002)(5660300002)(2906002)(44832011)(38070700005)(82960400001)(122000001)(38100700002)(86362001)(9686003)(6512007)(26005)(1076003)(6506007)(186003)(41300700001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?MwKYBnr6c7AA60OEBdPgBz2FRxbp0Bk13y4iS76hjqvuQaIzyEodWHXxM+7O?=
 =?us-ascii?Q?ahUYcDolgER4D/w9bvrWHS2d/hzugaHA4bvWWnm8+lT0R5dkqVn+512CfXCf?=
 =?us-ascii?Q?2zTcBV9qWay7cL7uw7TTIB3YHAF8Rp1zWeUMMrdUjaP2K4C7KmFhNhyjG//0?=
 =?us-ascii?Q?J4bgMJ8uzxeuQom4FLr7danZDFGLvBG1f14ya4ZZXGXBCTyGjAchBw5GTpqI?=
 =?us-ascii?Q?R/Ez05Iy3hOfgQDRySMq/LQ3C1yKVdbDvORVWlleLorirpZXLcXjYLPjwaMb?=
 =?us-ascii?Q?E9VGWwUS1nbiKnM23blCJ/CaHqAGO3HPf32x1a75ADTbfOosqzZXX8FKY1B3?=
 =?us-ascii?Q?aCk61h7WkkP3lUb9fCE5aagT2M0lqPcYW5070+d3kNDjsgaC36vd9MuV0Zbd?=
 =?us-ascii?Q?p9xtrcVoyT/5Trd6WZ7AEobLrFZPKf1FUCSYL7KNKiduj376eSy/XRKaG7P+?=
 =?us-ascii?Q?XtcSfkxwMgJHJ5Jn2wMMC1JCPQ2KX+im27twpSfX5Ok8s5928hzAHwjrcJv8?=
 =?us-ascii?Q?n9Gs9OpYeYhhByKXN9C+JFfKmz02RvPJZEpPU9m0DHDNpr1Dq3R11mIwianF?=
 =?us-ascii?Q?9tq9xX8BI9YTORTE+0lWKtCs05fk7FZTtQ15WpEyRPV83cKPjnRVRgPCQGqq?=
 =?us-ascii?Q?NoGAXpNDGsnl1Rbn+qmMyjJTrOVwkDpogSK0s9888p7RTuAiUJTKl3Vo8n7w?=
 =?us-ascii?Q?XdC6r5bk71gvxWnOe6IS2uyXvQL7X7ZDWIeZfG/xXtK27XUCmICKn+4K2a5i?=
 =?us-ascii?Q?tFQoELiFuA0EKT6+ai+D8yWijAe6tWgPbApCE+7FPfPXjhvCrwGQgASn30NK?=
 =?us-ascii?Q?uaa+aqPROeNFNZcskHpWhnCItzv9SUZQBdk0OyUP5IghPb1BIDJHykeMBO7L?=
 =?us-ascii?Q?+DYG33Wc8e9auDCWrhs/PD6htAfzl7WC61tiOC9btTvYEyxY56CskquF3aP2?=
 =?us-ascii?Q?PDtVY0oAU5HM2491uv5a53qy46yd8saGusVv4uWhlkohxvPmQhlsc3i1UYAX?=
 =?us-ascii?Q?xpu3YVSWEqdiWebOmBYbY6cMJcJKTatC7iLVf+e1+v7qoKJB/WgTIkl5rnZm?=
 =?us-ascii?Q?+VeGTap8XYN2YY+i2GmVvI5LOC8QpmTiIQIcLX2L+rDhsxGdIQPCHXuPcWcq?=
 =?us-ascii?Q?a+tAympLjAX9DyT0xQP1S4u6DsROGXjJhk9NIM/WU3bqF5QE7BFxCIWVfBkR?=
 =?us-ascii?Q?b0ZgHMxYIZDL1KfxjWJmZxpbt9xmKdXet2dBMf2KJL81PLtBz0hKdn5Cl8a5?=
 =?us-ascii?Q?vH/4CJ1zWSrkCMFDiYDVCXZo2AbImcW4mQ1X55FBT7vvQC3qc3yqW4pTjXRj?=
 =?us-ascii?Q?YjpE5qP8J42op0pdzEgVUUkeGuIktKIdcZ6NkMOjyNzBnLQCutjQUUxPrJmy?=
 =?us-ascii?Q?vwX13Q7XUpgsJngK3LKMkQXI8l99XKAecDOdiPJT5nUOsf2qqU67+HNPesam?=
 =?us-ascii?Q?hG1crFyzttvqA8vJC81jadkdgusaIXOaV9scSA7c6KcvbqykCPQi+4q8IcrX?=
 =?us-ascii?Q?gG81m0W2SY+fBWiOKFhWZr2ygbeqdsSIZY8fiBwW7ib3OqXYMnL5HnNRiFfI?=
 =?us-ascii?Q?b+zWdaP6ENUQyWF3/Sy26rqr/LQpoIgNj3pmtZOMV4/6yoIItmpeU8HNk4qc?=
 =?us-ascii?Q?+MRPZFDRz6QtrnH/H7WVh8g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0BD0C414F6F8594FBAA0F33D91490350@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 469988dc-332b-48f1-111a-08da8a71bfa8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 10:23:57.7589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zOL6QDg1hm9/yc3XtjLUel5sCqcywxLFuOLXMTIN3t3Eh/+Qrs3i7AxHL/PbuUD8i99ElPcrHM61IdPn1t+tpan5IgSFo+oUw9OcJmaNiss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6353
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220830_032407_421525_835188F4 
X-CRM114-Status: GOOD (  21.31  )
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

On Aug 30, 2022 / 10:05, Sagi Grimberg wrote:
>=20
> > Hi Sagi,
> >=20
> > On Aug 29, 2022 / 11:36, Sagi Grimberg wrote:
> > > Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> > > ---
> > >   tests/nvme/043 | 1 +
> > >   tests/nvme/044 | 1 +
> > >   tests/nvme/045 | 1 +
> > >   3 files changed, 3 insertions(+)
> > >=20
> > > diff --git a/tests/nvme/043 b/tests/nvme/043
> > > index 381ae755f140..87273e5b414d 100755
> > > --- a/tests/nvme/043
> > > +++ b/tests/nvme/043
> > > @@ -16,6 +16,7 @@ requires() {
> > >   	_have_kernel_option NVME_TARGET_AUTH
> > >   	_require_nvme_trtype_is_fabrics
> > >   	_require_nvme_cli_auth
> > > +	_have_driver dh_generic
> > >   }
> >=20
> > Do you see failure without this check?
>=20
> Yes, if dh_generic is built as a module (CONFIG_CRYPTO_DH=3Dm).

Thanks. I was able to recreate the failure setting CONFIG_CRYPTO_DH=3Dm.

Unfortunately, your patch does not avoid the failure after the recent commi=
t
06a0ba866d90 ("common/rc: avoid module load in _have_driver()"). As the com=
mit
title says, _have_driver no longer has the side-effect to leave the dh_gene=
ric
module loaded. Instead, I suggest to load dh_generic in the test() function=
:

diff --git a/tests/nvme/043 b/tests/nvme/043
index 381ae75..dbe9d3f 100755
--- a/tests/nvme/043
+++ b/tests/nvme/043
@@ -40,6 +40,8 @@ test() {

        _setup_nvmet

+       modprobe -q dh_generic
+
        truncate -s 512M "${file_path}"

        _create_nvmet_subsystem "${subsys_name}" "${file_path}"
@@ -88,5 +90,7 @@ test() {

        rm "${file_path}"

+       modprobe -qr dh_generic
+
        echo "Test complete"
 }

--=20
Shin'ichiro Kawasaki=

