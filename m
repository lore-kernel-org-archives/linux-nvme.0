Return-Path: <SRS0=VgBB=FA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35241C56202
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 16:16:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE063207BC
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 16:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VoNb1oku";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=netapp.com header.i=@netapp.com header.b="kb6+Gr7F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE063207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netapp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cMkgucUYr+4JspgtiNDtyBVQEVPDltYyOHQCeA4JBZI=; b=VoNb1okurX9ti5leMDDNIxemI
	Qkfe0rYV2+Z+MCFFV712LtafCjoEE3xnSxJ3IGSeT39OGB248Tmmdo80FUrlVGrT0yMIt8vmPiOZG
	wjMDBrBO2DY7TuUnqWP4SNoMV78JogHUUoIQqNZE+jCDPIjNL+BQ9yqkYoSB/fHr9Lx16s8hrHYBq
	0klR2uuY767YCZ9zlTcGeWYCRLW6pIpAvBRxpvD+ye6QMaPtUaeD/5zosnY1cIIrEkUljT4pFNYZW
	YFvCdx2e4bBrt30uI2Ys+1ze7ZVUnzTU26r/2JWv3LvveKkDnerrt95x5VM2VqF06qDwzmShU7ooR
	jFZu/ygzQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kiJwT-0006TP-8u; Thu, 26 Nov 2020 16:16:21 +0000
Received: from mail-bn8nam11on2041.outbound.protection.outlook.com
 ([40.107.236.41] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kiJwK-0006RZ-9Q
 for linux-nvme@lists.infradead.org; Thu, 26 Nov 2020 16:16:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+k3FERQwXa6gGTs0Khm3vE4xWJpbGnxJKn3DIaIq0gz4BnL86v4L/LWaJI9iojqcQ6AmuJMwFPZ6o9zN9sjtGB4vg+JgPLfClxBnKjKx4p8jqHcSXl7cKt7XqlxagzEkTbG0bmQgNmc7Yccm7A618K8Po2MVicWFTJT4ukUnFKdFCmSMYSTVPLrA75J31ZfxC9nOM4nmNYaJ7/PQGouP4bG6xuNgO2BQzRyL0h/sLhalwe5Thi0eqrJ9S36Rnmvfe6Zh2qEfZ9d22bLRYmM83y1cy4JktmXuLhAcHAcqgN42eBhKYOWymOy+899Uf0z3EqXoPXGitlzlNfaL0WvGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnNbfL0LsUV/puiGY3V+OAEBRZHkzv8Z8Jl+EVNNUQA=;
 b=YZyNzCrVm6GoHfCjJ4albgI4jNEdu4B0Iuh7rP7QvGizPngAFd8SMiqws5K51gIErSyHm0b3A5x0317F1QNTOpgXNzkh/7kTDIpjlh/m+KTSMVptG6fja8x6zFxhvxYZW//S7ZM7CuYYU1Bhgz9gLq/dj2Ktr/psI6I4tcv2lehL1VAodhm0jYQT+BwenSc+sJdDkw+Sh/7bzd8varLJC08VxehWik8L117TTB3nZPYeBl35kkXetIfzC1USBugOkhA6IIiq3dgvB9kN9uAsHCfSQB4Nolz5wBg+091jfAufEVLVoasqQu9EAlRv9DHlF9ygHJZvxeoe3z10oLut1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnNbfL0LsUV/puiGY3V+OAEBRZHkzv8Z8Jl+EVNNUQA=;
 b=kb6+Gr7FqXfXPd1zror0hNyP4cytAIT2EbTK3E6zz4b/Udqxx+mJGG51KsYmzP/y0V5+mzzGmVZ2wRRpU3ES31Iyaj0cv73rmOOZbRDY1lOu3v8NBedN+DmN8uKCjlFR7xTTkeP0hW+LNOhE4BUJ/bxdg0lMHRcdUZLQtDtPTSc=
Received: from DM6PR06MB4634.namprd06.prod.outlook.com (2603:10b6:5:ff::25) by
 DM6PR06MB6571.namprd06.prod.outlook.com (2603:10b6:5:255::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.24; Thu, 26 Nov 2020 16:16:07 +0000
Received: from DM6PR06MB4634.namprd06.prod.outlook.com
 ([fe80::6429:b04d:bef9:cac2]) by DM6PR06MB4634.namprd06.prod.outlook.com
 ([fe80::6429:b04d:bef9:cac2%5]) with mapi id 15.20.3611.023; Thu, 26 Nov 2020
 16:16:07 +0000
From: "George, Martin" <Martin.George@netapp.com>
To: "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
Thread-Topic: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
Thread-Index: AQHWvaDZ4On1YeAvk0yKbnb0IwXxeqnOE0GAgAA+/ICAAnYAAIAFOsWAgAAb/4CAAAOKgIAABBKAgAR9AoA=
Date: Thu, 26 Nov 2020 16:16:06 +0000
Message-ID: <acad8941fcf536a5db672b46f83115b723e9b721.camel@netapp.com>
References: <20201118114859.7985-1-marting@netapp.com>
 <20201118162415.GA16753@lst.de>
 <7fd0b51f3b7bc73abf7132aaa5ee7c493a93aef0.camel@netapp.com>
 <20201120094432.GA25846@lst.de>
 <20201123173611.GB2865091@dhcp-10-100-145-180.wdc.com>
 <f2afd4dc-dd4b-d7d0-7421-11daac94b61c@grimberg.me>
 <d50766c203d849fa97003ef9585af47f059dc42c.camel@netapp.com>
 <20201123194337.GC2865091@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20201123194337.GC2865091@dhcp-10-100-145-180.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.4-0ubuntu1 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=netapp.com;
x-originating-ip: [202.3.121.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1115b80b-f113-4881-8387-08d892269480
x-ms-traffictypediagnostic: DM6PR06MB6571:
x-microsoft-antispam-prvs: <DM6PR06MB65716964E09401E4CAE986EE95F90@DM6PR06MB6571.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +s6FY2GrYMFE2n/TDV+TtNLEkY5OjX30QB8aEADVucCnDAZwOVI2LOUVJzsvYBanQGARP3et0I/sJ8jjhVLAv4MUvj/um0urYEUsp3DzkfysaxIxS4qmtM1YioQDTpa7a7Ac9LxqLP+MpQRh6IcAL8UIeeMghy81QQNcWzRdeXP1PN6gA7MzWGTPLtvHzYiW9t4RsFgIGITjaNgLeToebIBf78qmkOx/uyYuelRZoHyJwvXh2lAfYzjMSzRP+XmALC8iysZOunmCGbfoH70FrUzQ6xz4lXKvN+hpgiKGGM1EC650q8d4MenZtH4UENjH
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR06MB4634.namprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(316002)(6486002)(110136005)(54906003)(83380400001)(4001150100001)(6512007)(2616005)(26005)(6506007)(186003)(86362001)(8676002)(4326008)(71200400001)(8936002)(2906002)(5660300002)(76116006)(64756008)(66446008)(66556008)(4744005)(66946007)(66476007)(91956017)(36756003)(478600001)(15650500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?UlRLT3NrK1o0MWQyMi9CYTUraUNWZGZORmp1Vllwclk4eWo3MGZSZFBiajRq?=
 =?utf-8?B?Zkl4bGYvdkZRd1MrTEtWQk45Zk05OU1xazBLbldLZ01WRVlPZVNMNzhlU1dT?=
 =?utf-8?B?Vlk2T09OK3Q2cE54ODZpaFptMk1jOVBWVkt3OG9Hc0xWWUlEdS9OM1lHL0RU?=
 =?utf-8?B?aHZGNjVXR2hZY1hoVTRMZTJ5RUpsWWcvQmx0Mm5iSDdZZUpKc2hlV0V4UjhD?=
 =?utf-8?B?NytnOGYyRU91ZkxjaVFTOE9pV1lwUHRyNklIdnp2ZTdtcnhTUHRUemVqOG5Y?=
 =?utf-8?B?REczbHppb2VvbGVrUGJXZU5LNHhWU2ZkZmdOekQrRmxOd2crNHpXaFhNaFNq?=
 =?utf-8?B?UmxZM2xzU20xdmpEVTVVUWlKMy9rQTdHR0dtd0FDUEZEV09oYWhHZ00zK3RY?=
 =?utf-8?B?Q1h4NFZOYkdpaFlQQzJvaUI2MStrNUI2WjhDelZERVZ5bXplS1FOY2o2RnE4?=
 =?utf-8?B?NDZWRWFha2JYeWZXaEtLM1FhM3RrQ1lFbEI3TzBvSW4vTXZFMXlHbmtLaUxF?=
 =?utf-8?B?aUdWS25ReE5TQ2J6ZWFac1haRzBjbkNMc3VxWnVibDE2djNlZmhWWG9kcVNF?=
 =?utf-8?B?cXN3M2hPSTlGRzRydDdnREkzOUQxMHBDK1hvMTRoeHd0ZnMwWkNqelFvT0ZW?=
 =?utf-8?B?VWRpQkEwQTFJMW5OcGxwaDdMem5sMUF3bUJHU2lZdTRCSDBobW15bFl4bDcz?=
 =?utf-8?B?clNnOUlLeFMxOWdwUUFsWW9KUnRNVDc1VTQ4M2FZbmFtR0JsOVZvVkEvYzFm?=
 =?utf-8?B?RFVrSHBJeWwzRGdYYWxLVnJpU1N2QW5Kcy80NGRzcU12cTJ2THcrOG1rVjZI?=
 =?utf-8?B?MDd1Q2I5VHFFaWZlbGJRZ0lLVlYzKzJqOUxuN2ttU0ZQeWFEazlVT2JELzR0?=
 =?utf-8?B?TGxXZVJOUmFOT2F4MEZmZFlkbzQ3VjJ2eVRnZDRZUVlpLzZIdzAzMFhYQWxJ?=
 =?utf-8?B?Q3RzQnRWWXhGcGJldlNhYWdRVXIrY1huNXhsR29oOGhSRHR3aVRnUUk0L1pQ?=
 =?utf-8?B?Q1U4U2YvUDBnTVZzRG1zS2J0bTIwdVg2ZEFVWmR3dnpRSjNsc01tbVJXTndD?=
 =?utf-8?B?NzhrZUpIeHNrTkk5bTNZR1RpYXBxYTdXZFZhYlcvSFk5cUtWQUxNN2puY1BY?=
 =?utf-8?B?cjRqRU1kYzdJRzVYbmdwVDBmczV5QWx3Q1RjNE1lVTZLZWI0ckhXMVRMMENE?=
 =?utf-8?B?bWhzazg3RnZkUGtxVjJMR1l0VGhKdCtkZkE4Y0NvZ240Y0ROR05xaFdJYTZt?=
 =?utf-8?B?UldROG9mcFJrQ0N6bWpWQmpWdmZYN1M3MTl6MW52dEd2YTlxbDZ0TVdLbUNE?=
 =?utf-8?Q?JRxo12YLNyL19Oblsh366lojORQYgpehFM?=
x-ms-exchange-transport-forked: True
Content-ID: <D3C05FB5C919C645AB5A748F942F8457@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR06MB4634.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1115b80b-f113-4881-8387-08d892269480
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2020 16:16:07.0158 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U3QsLtMX2hiQWfiojLahfN+nnhNsuakfGJ1IBuydG0GddqPn0O1ZZYBeV9fwveDUkXpbO1OdYLYMDo+/NL7YWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB6571
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201126_111613_333525_3A23B157 
X-CRM114-Status: GOOD (  18.54  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "anton@lightbitslabs.com" <anton@lightbitslabs.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, 2020-11-23 at 11:43 -0800, Keith Busch wrote:
> On Mon, Nov 23, 2020 at 07:29:05PM +0000, George, Martin wrote:
> > On Mon, 2020-11-23 at 11:16 -0800, Sagi Grimberg wrote:
> > > This looks like a good simple solution to me...
> > > 
> > > > ---
> > > > diff --git a/drivers/nvme/host/multipath.c
> > > > b/drivers/nvme/host/multipath.c
> > > > index 74896be40c17..300cff8c616d 100644
> > > > --- a/drivers/nvme/host/multipath.c
> > > > +++ b/drivers/nvme/host/multipath.c
> > > > @@ -667,6 +667,8 @@ void nvme_mpath_add_disk(struct nvme_ns
> > > > *ns,
> > > > struct nvme_id_ns *id)
> > > >               if (desc.state) {
> > > >                       /* found the group desc: update */
> > > >                       nvme_update_ns_ana_state(&desc, ns);
> > > > +             } else {
> > > > +                     nvme_read_ana_log(ctrl);
> > 
> > Shouldn't this be nvme_read_ana_log(ns->ctrl)?
> 
> Oops, I just did a quick copy-paste. You are correct.

If there is no further feedback, could we move ahead with this fix? Or
does it need to be sent as a separate patch first?

-Martin
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
