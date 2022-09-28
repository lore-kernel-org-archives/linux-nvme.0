Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 764ABC32771
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 18:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VEpl7vmkuGL7MU1UXXh47y13WJOeI8jL1D7YUGU1ELw=; b=ZkSaMwTzxFjkvpgEj7zU9yPQZ/
	xusEa3hToQDxyMGPWXZoyZb8zDV58/fp/z7PiMtCQCjVfh5+Fjg+aUizobK2w3QSBmYXIsL6Et3RA
	K0F+pfMKEuqYSn9UuMYywz2fXtgeux+X/bATfbS+QSUqnBbUjDk/lEonv+nkrHd8KkoxHz7UpiC11
	+IAyWTZ9LSFSNrJbr20+OSlmVftPQGltoIXDN/+C6B/5AEsheSNq2uXwKgu3Eefw7Oi6V8pLfileb
	PB/SKejdz3ZWCtoaGJ4x04mIaoWF9vChcF09DbVBlGJffaOAvLcVOo/JRFZS+tZ1Riv4ak4zZdM4s
	QFfldsDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odbO8-00HV9A-FB; Wed, 28 Sep 2022 18:02:28 +0000
Received: from mail-co1nam11on2061.outbound.protection.outlook.com ([40.107.220.61] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odbO5-00HV7h-Uj
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 18:02:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0a39FCSQQHx1YBO820E6fB9eBN3AC8xizUaNEsGzgHqRiq2ZXZn1udqcXARnc+O68m4mt8mjwLlVFyfNfdIhKca0oHd41MXZjLDDDXsyivc0J7QVJGDFeRWUKuLXZTLGYUud8vyRTZ5NngTsm5RyS0xWOTipxe7gnO6A5XpHc0rhMCu3iUHa8HUTj/VgA/7U/LZ/DuO1lBRzqbEFyC+wtAScwZcH1fDvltvdB52LY7aYiFvPEOxECYYLjI7pN6IniborWxXDdfLTNQBdJoZYM7FeoBHErcYFj7c4RxzSicepTVonUIH6MesWWTD901xzfDJYXoywfFUDAAqj4WANA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEpl7vmkuGL7MU1UXXh47y13WJOeI8jL1D7YUGU1ELw=;
 b=NqFkhDhEmYB+xEnMrmsna9EcEWet+Uvk9hTCLWpjl0N2QExGVRwfKxD7VXDrq11KAzBvFf7dncRii0DYwKMO4v7lHpOcAH6jXa+bnTPm3ZYuhosLIUDF0mlD0l0yoNRAqt3u4CNxjKOxcSSC27TXwmREXxVcUT2uE52HpTBo2Oepak9pDwpa/0fwN87WyBLB586ConQOKktiJhI5B+xCYM+CPBiWfHEzBEkA9dke5htWz8OcOGXeydZTwtQEl9Uciaij214+pqdEFfP746dG4ou/zx40LlPSIg8CboLwuz15FDUrjycIrHJlfjqU1j1Fc3juReebCbvYvsybqyOPRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEpl7vmkuGL7MU1UXXh47y13WJOeI8jL1D7YUGU1ELw=;
 b=e2K/HkKknbg11Tdv28OJHOFQTzIAGBoioMyeYh4NkJAkWrl91zoU+kaMwxGPOQqxizud1bkfnu0iYSnrzhhF2KdcYuWeafsi3LWeTUJdJ7dy0jC2yLkcppvyc2vToEXgXIo4/L6iDArESlvKAOcoOZD/pg4mSM3+iTOGWv3ZhtecoJ9ik/8tW6/5TTONgNQAkxQs1f/QEuTUdYNG9zky7ErtKC6BqiUBsD4jQpuD0qu1tQ+dtuuVBxSl5MR6qmYDLrOllx4zHP3FLqx6j0ztl+Ch9peDroZ8eAlfLdxoyWsz0Y79vlMKBPPHU4vDlS9N8Aq1lbDffGyIhz1gRiRx7Q==
Received: from DM8PR06MB7704.namprd06.prod.outlook.com (2603:10b6:8:32::16) by
 CY4PR06MB2982.namprd06.prod.outlook.com (2603:10b6:903:12e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.15; Wed, 28 Sep
 2022 18:02:20 +0000
Received: from DM8PR06MB7704.namprd06.prod.outlook.com
 ([fe80::29cf:1ad7:d52b:6f9f]) by DM8PR06MB7704.namprd06.prod.outlook.com
 ([fe80::29cf:1ad7:d52b:6f9f%3]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 18:02:20 +0000
From: "Knight, Frederick" <Frederick.Knight@netapp.com>
To: Daniel Wagner <dwagner@suse.de>, John Meneghini <jmeneghi@redhat.com>
CC: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>, "hare@suse.de" <hare@suse.de>
Subject: RE: [PATCH v2] nvmet: force reconnect when number of queue changes
Thread-Topic: [PATCH v2] nvmet: force reconnect when number of queue changes
Thread-Index: AQHY0xkW0CvFgvGYC0OqpzqIUZQ+Z630t3BwgAA4mwCAAAcPAIAAGs6A
Date: Wed, 28 Sep 2022 18:02:20 +0000
Message-ID:  <DM8PR06MB7704CA28602F1367574EB23CF1549@DM8PR06MB7704.namprd06.prod.outlook.com>
References: <20220927143157.3659-1-dwagner@suse.de>
 <d151b0c1-d28e-faeb-03d4-ed28b9768ee2@grimberg.me>
 <20220928074850.h6rwvwgz2oje3ebg@carbon.lan>
 <f1909450-1435-9661-056f-b955d6089ca7@grimberg.me>
 <20220928090243.c4ctbj2frydwsfav@carbon.lan>
 <DM8PR06MB7704C17B1DF832A432024BE2F1549@DM8PR06MB7704.namprd06.prod.outlook.com>
 <6e172046-53e7-d2cb-38b8-e87d725046de@redhat.com>
 <20220928152616.inzetc3fsvnhb3o5@carbon.lan>
In-Reply-To: <20220928152616.inzetc3fsvnhb3o5@carbon.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.600.2
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=netapp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR06MB7704:EE_|CY4PR06MB2982:EE_
x-ms-office365-filtering-correlation-id: 439aca24-31ba-4132-8412-08daa17b96a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  noT2Nx8ACofPxCCl6N25mbFNQ+Ok8MUvilzGlAhM7HXjcFw3xP1CvktPTLA5I41G1ugfEPTA5+IAm7OgeT0QBsEo9xeGpBsZxZ9hH2lHPcW+ilO6Pv2OAPM71i13pC0NiNzlT8saVVXIG6xM84rN3nnZ8Cz/C4VT/lIov9VBQFTzdAx6wCLFUlF9s0kuhVIP6jotjW+J+KwvaA8o937in5MFbsWpHebkzymJmuQro5uTQExEhp9DDyoe6OhyyJ4RqtapMIcnUSamFMRRebOFnve/DGDFnGtfcJ0gA7BpcY34OVYDar/x+3K956X7NBuuFNP47VXsGadCn6hI2a40oqvIcI5cJH1pSNcluVu2DHu4N0X+pTvCFWVKM62Iruk9Q4ZCWoXM96tb+Wo3OWIpn6dmdmlqrC+k8wREN+mNBc0mfBsL4sksve0lCu1EcDrmIVOzOTBIHMToEHGSNUg3CP/sb630gsVcdV7PzWDuz3s9N6eM3Hrvf1E4K1IpqWnBByeAVwoPvoMX0rYALOzHN4RwX92VDhbrSvR+4emqd0iYtAPAmAZsXuATGsBbSkPMcZs2RdQ+AJ9mPbdNGxFAKtKL7YFsQJWgbPfr68q6PhRUxyy7mKQiDurRE0Y3i+QlRWcJg12tkE8wWHlkbYTpy9KxUWhcO8u4rKP2+ruaS+78i9o76eiurCYaxxMB2z2WJ7jFtbBG9y67TlYxKVnoQFlIzeNIB113sAMyDgT9HGSOUYxihDfnu6RiQtrWVNRLn2YsVO9h1bZdzGlGNkHylw==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR06MB7704.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(451199015)(55016003)(83380400001)(186003)(54906003)(38070700005)(110136005)(52536014)(316002)(8936002)(86362001)(66476007)(66446008)(66556008)(64756008)(8676002)(4326008)(478600001)(9686003)(122000001)(26005)(41300700001)(2906002)(71200400001)(6506007)(38100700002)(66946007)(7696005)(33656002)(76116006)(53546011)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?2E1C0elrmV2o/1hcFGkJwvTNT+4N7iUDBQN4tWpMvhNFRrdFmRL7WDwfSfiu?=
 =?us-ascii?Q?FlO2gITVxY4su5RPvOLygxpicIeEXLDmTGVPa35ljErizB4hMLHw3XzjiHUl?=
 =?us-ascii?Q?ofRpLw/CO/RhHLFJVNgtOLHr4sjKlQkiPpqbgbqel1OUU9o1CLdf3mMTENXv?=
 =?us-ascii?Q?wx5NjlUlD6td1dyF9kIlTP6ORkvYmsE2QJnE86jfylUQDYK443oiH81ifWtr?=
 =?us-ascii?Q?Fu+QEfqllw8ec2VV0T1bxpRiAGnRwwWPemr3QZUvk3YcJ+vLVPDMqQ471iNH?=
 =?us-ascii?Q?PeXzcyIO//NXlFWfbp9gy/eohbJmQk/AK+S3EcmeId+Rmk8s4Cr2WAcHoFPI?=
 =?us-ascii?Q?qHd9OrwMp6QR0tRoCRZk4SjQrUwJV8zGFquXCXX1AcKAg3OsWofYaVfb+XsH?=
 =?us-ascii?Q?Aobta+3+0y7YTNFgqbpRY39w8qlqYFFxUqrhk2FEY0d/w0VldBC+f0OZ3IFt?=
 =?us-ascii?Q?761J8GMsdS1APYFv25k+FrtVmEpYq8g+zjb9MnE0s+dqmU+1v1GGu/fcEEd4?=
 =?us-ascii?Q?5HJc/nDJvnwvTOAF8tANRiCHyhdwMlxCaCc1UlQYhXF/jA4l1TmCGUFxWk6E?=
 =?us-ascii?Q?nrB/PRAfSbRqxwzeUnDm0cwqjFirabZusNWISQLVNVvb1pIQCcyNsb2tnwSL?=
 =?us-ascii?Q?FjTjfoH8Tw+aaf2ZHzu1iGxOLTLaoXSkGgx2HD8MpA12jgL2YmXQFEksLB7I?=
 =?us-ascii?Q?ru+mMHYTXCrVBPtw3RnXah5eA3gYHdRZYjWVoAqEArl489RsjmYppj14uSna?=
 =?us-ascii?Q?5SwSDk5gAUv9eW2SZjcq/PtWbykSqR0yLa97CYFoXJhmqxxTC1cMu9EztZ4i?=
 =?us-ascii?Q?rHzFAliDwn4dUQYNBCE+8nPqBgLmrpxKGfK6BPb+74ZN7GgO5pMZGmHPmCsI?=
 =?us-ascii?Q?fovPvtfb6oYunCwzRSszSEzDnzvZDiDY4vT00dfLMLh2FD6fcZ2LNJYwHiAR?=
 =?us-ascii?Q?YvxQqwBpblR32V6fuBJdR3ukoPyL953xLMxOQggbHiIH6YxMr+oP1lmxHsWI?=
 =?us-ascii?Q?mOhLBzf3hQHrXdatSnf87T2dKgw0FLGgUEhcSGm2Kdo29SyTRKuGs0OTV76L?=
 =?us-ascii?Q?JYc3XYHdl6E51YFkYmMBFbhnwIYfA0uxSFHr70eWA1EimWH9B4YwlSsoNkKT?=
 =?us-ascii?Q?1TQnxYPcqrVQaMBRP0qcxg2l5JRJrXfWSMW9XG4IQGWU+wbwzAj3VsVcMwK+?=
 =?us-ascii?Q?CcpglQqxQUA+5nbppRq5wehz+i4GzK041HQyEieWQajWFL1KO90LmuHmMDlQ?=
 =?us-ascii?Q?xDGe4IzP46zUB84owp481ISaPVzLpJsio2qJV3q/ZEyZf/PHq5KT+uf6bEUH?=
 =?us-ascii?Q?KDsfC0iFnN+xnrH2XM9FiFZOivgZyMp2Sv1R9SbX0PvNsni8db+P/l0mWdch?=
 =?us-ascii?Q?gwi9a5Egp5TjcBq9kT136c6noU/5iaH7r+MteOwe5Mu+tSHdGuctXjanWXgV?=
 =?us-ascii?Q?4hI7JmgSOvXSbhh7tkk1vE9+R2s26HrZ2biUTeR/nQo6mY7GfPi4wSNXYG/J?=
 =?us-ascii?Q?bIupDBLl2E57nGVvnXHnJwGfd+D+PsTsQXAjCujixWzMmUOLqqPyT8v1pk8O?=
 =?us-ascii?Q?xPoQa8mjXB5rmbP+mj0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR06MB7704.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 439aca24-31ba-4132-8412-08daa17b96a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 18:02:20.6472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ictO9WMMzpQX6GeXDmOntSMEh4er8brLOn5Ym6nFATIIeYwnQGNFo7tJLAMJIpH+P152JxazmSN+UmYU06WYXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR06MB2982
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_110226_010046_CE52377D 
X-CRM114-Status: GOOD (  17.53  )
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

Reset and Disconnect are different.

Reset uses registers (and therefore Get Property and Set Property commands)=
 over a valid connection.

Disconnect causes a reset (you have to reconnect to the reset controller)
Reset does not cause an immediate disconnect.

	Fred

> -----Original Message-----
> From: Daniel Wagner <dwagner@suse.de>
> Sent: Wednesday, September 28, 2022 11:26 AM
> To: John Meneghini <jmeneghi@redhat.com>
> Cc: Knight, Frederick <Frederick.Knight@netapp.com>; Sagi Grimberg
> <sagi@grimberg.me>; linux-nvme@lists.infradead.org; Shinichiro Kawasaki
> <shinichiro.kawasaki@wdc.com>; hare@suse.de
> Subject: Re: [PATCH v2] nvmet: force reconnect when number of queue
> changes
>=20
> NetApp Security WARNING: This is an external email. Do not click links or
> open attachments unless you recognize the sender and know the content is
> safe.
>=20
>=20
>=20
>=20
> On Wed, Sep 28, 2022 at 11:01:00AM -0400, John Meneghini wrote:
> > So this is one place where I think we conflate NVMe-oF with NVMe in
> > the specification.  If "reset" =3D=3D "disconnect", then Daniel's patch=
es
> > just implemented support for something which is forbidden by the spec
> > - a controller that changes the number of IOQs between resets.
>=20
> FWIW, the scenario I described is from a real world experience. So even i=
f it
> is forbidden by the spec, it exists.

