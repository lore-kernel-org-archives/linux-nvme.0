Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7078EECAAA1
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Sep 2022 04:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pCSOjnXaaT9zTVycDIllgTcIK/n3z3dvzG3J6jQ6kfg=; b=FiU2TNYsum+ctgogVqeF7iL3wN
	ndM2yWc4LQv/hbVWRnqQCwVxXGHw4UqvgcaAUOX5H1ao+hHqxlpGb8tL4tFAfSX1BpJuSSWigA1bX
	udLcEwXOsEI/svI3Wew/Rtr3bOif+C2FQfh0euqxn4teBrHyDc55U6wYl7W+AMrTqMvjoh5oADx/a
	RT1FNGAO49Ssg9R+zy5XJKTLSTsySFSLdq7mwGKi/eobPbPn8dN3hGwxf/+n2kk2YQC0PUpwJakob
	QVCi7PuOMYz40y7Loha3WmrrWMJWb4ioFYJTcas6oYQKWNvOLuv7d6CBNRXn+pN0bJHsDrdr2jWPE
	v2lI0szg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWVPq-00C6Ye-3d; Fri, 09 Sep 2022 04:14:54 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWVPn-00C6Xc-8G
	for linux-nvme@lists.infradead.org; Fri, 09 Sep 2022 04:14:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662696890; x=1694232890;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KeMiC5KYi8EbTjZKMh7N7wvIBBDBAfApevhtY2TezJI=;
  b=GA/nBV8JgIISdw+SsCPhsqy401Tk7i71B+it5HBwBVpM0Tm0uQYG0GQb
   aDyKthf52O1N+L7atPn0mFsnl8LNBmpO7ES3Sv2dKiObs41M+zhRw83nZ
   qqr8PPVumdHXxATB7HtGKGIG6j8pOhKSF/keP4cFon8nlXlOXI7TYa5NF
   D95CvKR018JPdd+Sk11c2WL+dxaR1cyihPchk55h11ydVMwEt73i0HS41
   24lf8I0YW8S2wiiAbqBrQHoqvVphq/DrjGf4cfBQ86JvdWfb8se+z0HL6
   ltC8wE9sYmDiMS1JwUOJZSi69f2EMzbK7TorRk5nlYP4K3SozC4qsxbna
   A==;
X-IronPort-AV: E=Sophos;i="5.93,302,1654531200"; 
   d="scan'208";a="210905818"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2022 12:14:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCB2GNeviRmASooWGjjt/ci2Hm03KoFSgDpYzgXCVD0ovPoUZwxCouvWfdF9Rw7JepkCbh2fhge0m0Dn05hAe0sZQXFi0c4mjDrGCx585enqyY94Hcq2abL104XDKRUclZJggJZMIkjiR+C6zGPs3cmU9QwjIKqOEtDebRtfHu7n7n082Ng72PwFMML3lVX6EEa8FHr2LhepxikMQV/ol6ITeODbm5NtlZqI0IBJXmN2ZWwdbm6N3vJeHzr3xygADJMTZRTJT+ToabQZ5jjT1jatuWAq9XWtQR6l9YZBlwl54NPykKbegMk5QSS4NOuuxcc6OLEt+1TdZ6BznDkDXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCSOjnXaaT9zTVycDIllgTcIK/n3z3dvzG3J6jQ6kfg=;
 b=RpDzu25lELWzbktypR3MKW9gTXqmPqpiGDYMgqyC2Xk+ntQy/2iYGf7uvhCKFHfc043LgRQ0pxx5n7RqMQ9+3lEyVHpFmhvZ2CFantHzPaC3yy1dGcjlFzHEBYtsE2U31wxLPYmqPnp+CepCiYbZ8aYUedZFSRd/ScDVKbRZrIUnvxngJ7QcFo1QSzBm6ZPT7JQTYGCf9nq+SR2XCkh73HqL2h3ff3iLr0va6n98wDDcfa6lVW+Iu/0ggZ10aDNGQdKaTpYPLVVrxVv62V/X9+/0vGW5fcPDg+lxEQH3J0zl7XgFzcT+dlOU3LB6BOZP42L+aAEd/WlJRxhOLuiXsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCSOjnXaaT9zTVycDIllgTcIK/n3z3dvzG3J6jQ6kfg=;
 b=dWsk3QbtkRF2pqXJ5qNuxBlYDRoDwq6MhlrSCe/X1GeH0ZzuxC6p3wHD+kPfq6iTEyAGuVDtF3Y87tutDytS0IWzLsX1TY1WkwOZ0VwHGDgC84uq0dLysBh7x0RXK71k9zzHcml/jADz5VtrEX4fdXHg4lQipNLqIU/fFki/CI4=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BL0PR04MB6563.namprd04.prod.outlook.com (2603:10b6:208:1c2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Fri, 9 Sep
 2022 04:14:46 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c7e:a51:e59a:d633]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c7e:a51:e59a:d633%8]) with mapi id 15.20.5612.019; Fri, 9 Sep 2022
 04:14:46 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Hannes Reinecke
	<hare@suse.de>
Subject: Re: [PATCH blktests] nvme: add dh module requirement for tests that
 involve dh groups
Thread-Topic: [PATCH blktests] nvme: add dh module requirement for tests that
 involve dh groups
Thread-Index:  AQHYu4JqMzYWLRy0pU+II16FtTMMiK3G3+4AgAAmugCAADeMgIAAMuUAgAEE3QCADhhmAA==
Date: Fri, 9 Sep 2022 04:14:45 +0000
Message-ID: <20220909041444.voeqce62gp37favp@shindev>
References: <20220829083614.874878-1-sagi@grimberg.me>
 <20220830044632.j7k45lhdlyvksrxh@shindev>
 <05548286-8d18-e3b4-06db-640c9d6b1399@grimberg.me>
 <20220830102357.yahkv5qfr2ewa7uh@shindev>
 <a5c3c8e7-4b0a-9930-8f90-e534d2a82bdf@grimberg.me>
 <20220831045946.3elujhdydvqkkhv4@shindev>
In-Reply-To: <20220831045946.3elujhdydvqkkhv4@shindev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BL0PR04MB6563:EE_
x-ms-office365-filtering-correlation-id: 1a40bbc1-9864-4a35-3a3b-08da9219d460
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  pdeJRLJDqrSBMb3twdtzmYz+Ck5x2owOyfUkm3UphFajFQXvRnQUvq0PfbQTRWxtIyc2YdRuEADzexXYSVCqumI+OY+oOcHsqBnFgllM+ZsoptV557i6E6mTnbttxepU0syb46ky8vFbkCt0GzmQyFw126UskeyyjrZRQs71ExmVuCan7Gyg8tQYaX/fPe+PgnnOBNxfEdXAkLBN6FyG88YLwKHV+8PdCjWV0cqRo9eYRlfw3KGK9OgQBqOHuBfVLXMjtWe2SaYBJdejY0OTh43GdxbOOUb8N01OxitQ4GooC1m0gzXiB80CXXMyv2g7J5m+ORNazLZe6CUmGORGIYKFnhpzwiyxBuZQuS18fhmQjrG+PQY2mtWnOJ5zi35uOJw9CT/HatJdhbEoBBKEQX6k+V2z8l8I7u1ob7IbHD1kKEmw5DdcWd4Crei2Mhwt3Y2svBmj9mTU9T4EXlH4kaATgdzcxCydP67YZXoBFmFKVR0bXy91/eUS+RPmRCjAG3bkSQIYgNiJn8XID/ZF09zBbPq380v8sEe2uPq9Eex4FKNFvkhcgFvNrkuYS6zjmmOoHP0rXnJ4AJuaB1ao5wosb6HqEMrB1q+aGfs/qCWIMKMrDNn/9+W1neVzCu4Dx422bgS9oHAEkO4Va5H9OxpRlwqYqLlxkXDapqaMJ03b2XTyv8Iz7PlawrbRdD5RGJBKQW3zpcv0D6jmQraYilKX997dzhlayjqYlZO+47uKBz465g0QNzfYhcSaHxwc03NHsxbu3eh37SpOmpKOCCXv60+OfN+KU5rAVTT5AVD2gGbmaRcEy6xBXrPVCucWjeTO8n/Oo6J4l7SbBdDLIg==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(376002)(39860400002)(136003)(366004)(396003)(346002)(6512007)(8936002)(1076003)(186003)(5660300002)(44832011)(2906002)(41300700001)(9686003)(6506007)(86362001)(71200400001)(83380400001)(966005)(6486002)(478600001)(26005)(122000001)(38100700002)(38070700005)(82960400001)(66476007)(316002)(4326008)(8676002)(91956017)(76116006)(64756008)(66556008)(66446008)(66946007)(6916009)(54906003)(33716001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?cPnCRMaF8klO7axI2dcEWKOkIz/z81bo+tYFuIWlyokQbdnkAb//4R+K5c9a?=
 =?us-ascii?Q?ivGAZohFYDntYiGiOB67i4SJArjrVLA7UgFV4nBZgLBVH0J1076mj6sgqYaH?=
 =?us-ascii?Q?EJFDYJ937ILhn0G8XdRq/DfYn90icM0DgkGQTamlBvEEIFZzKcsP0ggC7cNj?=
 =?us-ascii?Q?pW/VHxkqXR+VOZkiOvK6a4/vAS+DAICW8zUFznQL8QIEW3ENycihORn+LM07?=
 =?us-ascii?Q?QbzQ3pwpof+T5wZOjvk+WIzAmkmtAYNbANNjnrdX+BiRQ5TwxvIPX5zaG1xJ?=
 =?us-ascii?Q?YO+nxSFpepGVqh+hwDqMkSXBYzBfMlh0GPoWja94WMZ/W2sbwmNI8gHqBlui?=
 =?us-ascii?Q?hKT2ld6KStvfIZYU5xtkxph+oDOJlFLKV1RXfRfPNlwLryNUFbjmAgQNbeCG?=
 =?us-ascii?Q?Z3RK+pXPD/Vo1O90S92TnPG7/SJaLS1B9BDqxf1JMmfDBbyZBCow3AVCEHP2?=
 =?us-ascii?Q?lvQda/x7tTThV8BByK6HGJ1KKdK2di28/HGAuEEdo06YovkI7VtgKbM7+euj?=
 =?us-ascii?Q?1uZCxbexdnVCoYpvEniCys6QedhZX6J/hvwpX3c+MpnjmUskviMcGZTsh6ge?=
 =?us-ascii?Q?yO05Ce+R184TtEO24EcYUqhVwxasuP1AOaGOg56NsrE83GGcBQnJNnd2mmqq?=
 =?us-ascii?Q?gHOmSwet58p9+lTNViYMi5X4eP+BqdNSI2Gxw1VEk+VctBeC17yglrplk2u0?=
 =?us-ascii?Q?KqZpx8G8OmMbfkqsd/PJeDdVpl0CtQYdxq3MBYm9vkIjmnegmBBQw7MRGyEz?=
 =?us-ascii?Q?ocbTui+Cei7WGBf7QDFqHEA8DUrWhFZmAE7gNCppqSLyVXyhG7D45JUpmX6z?=
 =?us-ascii?Q?LkbuwNMs4LxWM9HU1gODreGDkDn2zEJYbOYTx8vGJPMhAQaLIbAjeBmzJcEe?=
 =?us-ascii?Q?7xM9ckj3/oy/0XDlioGPTAk0PrBEKOzUPafpDRo0wlRGhHXqfVf7+ojfge7Y?=
 =?us-ascii?Q?gTd3MpHbJ6JOU1pvwTdwRNnuWAAD0Q6eikC65lrcRnGzGQtHZ0qFKKv8Hm2P?=
 =?us-ascii?Q?vf/TCwiTI5+EWRj/MvmtUN3CSy4e/OZGyQ9y400sA2TOWrXJuRo6I3TfXxtc?=
 =?us-ascii?Q?b9Q4nawuyZ3zeIccp5/qXVAFAnj6TQdMTvd2go9hR/9eTAdFOTHTOSh/B0fB?=
 =?us-ascii?Q?X5I25dSVu0/fveEwvJ6JoFSJ9USoQC0yMkxDFe3t2GUc7586eBA1ARDebzsH?=
 =?us-ascii?Q?1cT2yOCrQBqqUeKKEdwEYfzilVcXdVIWJjaXhSvigpS8a2fuNM8UBpwOHVz/?=
 =?us-ascii?Q?TEqpSGgm4axlbqRGd0eP8wFbNWrVuVdzNh9Ah6EHwUS0s83I15BOjgBDL3MS?=
 =?us-ascii?Q?//LYuTaqUfRVmj/QjQSDiiQ5Hv1NObA8fZDC+vvWc03ODgOMUvs/7vGeeRRm?=
 =?us-ascii?Q?N66bHwXY7etEhw5DATj8msAh+D+Za8VFSFP8UBVtwiexdssW2DeWK9hrFgyK?=
 =?us-ascii?Q?gGZ9TCVO7UuJuAq2vJOzMKiEDoAoeor3nT7VWiLoZlkL/7+zlz4eRh8Vvy95?=
 =?us-ascii?Q?f79zUPfVPOj6jEdc5DbmAUlNOJomoy3wKGf6H3ZvBPLVRoLaNZL+H1qZQY4O?=
 =?us-ascii?Q?g/3hgHyKPR2eB9tYzmkr8hp85EgSvQBIWMOwiGcZ21Bstv9bL19pmvD88kQH?=
 =?us-ascii?Q?irb1M+akwl0buG8RNT/9rJs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <88F7E43ED6AD8D4D80787DA902142F37@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a40bbc1-9864-4a35-3a3b-08da9219d460
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2022 04:14:46.0635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ClKQ+6tBosw8Y3yXly3ScdXW0lm+77vX+MG6g3d2UjKaQ9XtwP3Jm2OOYUZC1eeZT+xRNMj6nBZpbu9Np0POwT9o20d88DzSrvkYhLZe4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6563
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220908_211451_598416_B791C575 
X-CRM114-Status: GOOD (  17.89  )
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

On Aug 31, 2022 / 04:59, Shinichiro Kawasaki wrote:
> On Aug 30, 2022 / 16:26, Sagi Grimberg wrote:
>=20
> [...]
>=20
> > > Unfortunately, your patch does not avoid the failure after the recent=
 commit
> > > 06a0ba866d90 ("common/rc: avoid module load in _have_driver()"). As t=
he commit
> > > title says, _have_driver no longer has the side-effect to leave the d=
h_generic
> > > module loaded. Instead, I suggest to load dh_generic in the test() fu=
nction:
> > >=20
> > > diff --git a/tests/nvme/043 b/tests/nvme/043
> > > index 381ae75..dbe9d3f 100755
> > > --- a/tests/nvme/043
> > > +++ b/tests/nvme/043
> > > @@ -40,6 +40,8 @@ test() {
> > >=20
> > >          _setup_nvmet
> > >=20
> > > +       modprobe -q dh_generic
> > > +
> > >          truncate -s 512M "${file_path}"
> > >=20
> > >          _create_nvmet_subsystem "${subsys_name}" "${file_path}"
> > > @@ -88,5 +90,7 @@ test() {
> > >=20
> > >          rm "${file_path}"
> > >=20
> > > +       modprobe -qr dh_generic
> > > +
> > >          echo "Test complete"
> > >   }
> > >=20
> >=20
> > That's fine with me, can you prepare an alternative patch for it?
>=20
> Sure, will post it soon.

As discussed, the alternative patch I suggested was not good [1]. Then I ap=
plied
your original fix together with improvement of _have_driver() [2].

Thanks!

[1] https://lore.kernel.org/linux-block/20220901063551.djziyblzw6g2cxwd@shi=
ndev/
[2] https://lore.kernel.org/linux-block/20220902034516.223173-1-shinichiro.=
kawasaki@wdc.com/

--=20
Shin'ichiro Kawasaki=

