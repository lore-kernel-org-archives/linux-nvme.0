Return-Path: <SRS0=wnYM=G2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEC5C433DB
	for <linux-nvme@archiver.kernel.org>; Sat, 23 Jan 2021 03:03:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A111F23B17
	for <linux-nvme@archiver.kernel.org>; Sat, 23 Jan 2021 03:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A111F23B17
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=0szYhLdCkx9trHgDjaSZ1wagX6H6xtgI79TN5pqUr08=; b=yPfABha8dCrcN/cncUIvT2t1I
	FldJoTUfea4bj0UqB+yvVHyUvStKxjG9/TpjTqzQ9MZWesdHXeS/yrD7KysLqBl61mrH3HS6Z95VL
	8GtGhGrx74y77DtgPGtTERXueRKfmj4FF7vIGwgpNZz7rMlyotLSfa4Qmz9Q32v94mAvJuPE2s49m
	2hajRaUgKUZLxNOsR3WPCEgcEAw6m/bti4o4wQ+WWJr4OsehbjYCFSlLqhNL4puYYy7Eg+6P9rtA+
	8vtT0mMwmY2pBLATtJaTHxjRDlo+/c6HPuClSrWsCcrCxX31UTDlEH9U2RujDowq51K1XNs38Vxkx
	aHAeYkiow==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l39D5-0000oe-U4; Sat, 23 Jan 2021 03:03:35 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l39D2-0000oK-4O
 for linux-nvme@lists.infradead.org; Sat, 23 Jan 2021 03:03:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1611371012; x=1642907012;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=v2FvscVwZpSCRtJkHS5RZr64YPJVyphfBhKwmFS509Q=;
 b=pZW9CPZsQHO44skkw9Ilt9OrfTiRTi7PbMXw3qoCYHOjMb9vAv8t08Me
 IWXnkcQwhK8Sucd1Jhi7hAzbmi1BPZMsaa7psh6hAvPEIEhV22u+kLC/j
 INxydS58/1OCOnIrhHK4XSwTFAUR+wgujMIw2C5D9/XYVVhYkoV3gwnkh
 M+Mu2E8BLXZCgUoHJB3efxO6JAEs08oX8jINF4d8nmvihl8VdaDRtQOC3
 rg3n15/jJc4HMSx6H+sBiULFutoB7RjjaEbUEDTD16ksNTIdyUNrc3eA1
 rZ6xtEWgIcaldlVyGoaI3L+aoEUj2WnwvACid+4ouvU3GyCh245Xyxcuh w==;
IronPort-SDR: +mxnETCbQIP84zBjO17c+smC8i8v2ZFV5JrSD+wY/59hhA7Y6Sm/9hto1L+NPRflgCQC6Um5Rb
 Oswif3q0W0RPA/4pBZTYQ79Lic5UP52514BikqueCiWBk+nonJBgxEvF+3g4bwXm+WEMt4ITKs
 2hI+2mSa5sYKCeKONuClzvYfJGBi43nhpvEr4rmhk/Gnqsu3pZjTZWYkeHdMh9l6oYRdfl9Fsr
 i/itE0A5tKofzKTi+mSzREXtXGmrMaQGPKQK8ofLusStyFwdre2za0j2gSZGsk7LLmJAtFtQss
 z+Y=
X-IronPort-AV: E=Sophos;i="5.79,368,1602518400"; d="scan'208";a="162584532"
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
 by ob1.hgst.iphmx.com with ESMTP; 23 Jan 2021 11:03:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XrPPClB80Yh6j22QYeI88hSg36HJJ8rbk9P4O/Jsc6fefOS3IP/ECQXkoFejZp2/eiG8ZCZ4trqogbpSRexdIg3Bc30ScguKXV6b4eai4KtQhpFqLsDQKCg+DJxsfl7emvxrDD4MDbdnbGFG8JLnKkk6s/FACrNndgTld1it/JvKN1gmbxQIUP59gqRxXD20VIVqvzU2dfNDLzrAsW8k+T5daWKIDOhV7q8x7qpgyVrKz50Cxq7wprD23dI4f99TlUOdnRQ9PH0vBpUTm530cMpMR2uv0k2e3DnOK8UvU3Z7qfgbsGithw1COsxizgDHHLkNd2WVwrZS6HEcjuaZdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2FvscVwZpSCRtJkHS5RZr64YPJVyphfBhKwmFS509Q=;
 b=NdRZa9okfu3F5xAZlSQN+aPrI3e5JjmGqvpEGq8pM+x0gaJIhOetqQ9HDzxFj27ha1sSLCdkTfQaNqocHpQYgrS/m6JVu1iOK/DLfLO07SPS5KvU2kJwjHGTcBeFxSGJWEjhxT9PXnkAXm/YGDrf830znnorCcCYzZ2sOX/p81+W9QSqC5/alA7fZrH2gtLa6EVfs9GnKSMU601UwGL2Ljq7SnUTaTPm7vGoIieSFQzxvVH9N5BQ4v1M0UAX4iIeKBQVglUVOepTLJ1381GC3/ShiUimetqWqsic+ae9nNJ+HQq436oPo8Wqtl5IDrqv2icuCfIZT2Qren0au1xjig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2FvscVwZpSCRtJkHS5RZr64YPJVyphfBhKwmFS509Q=;
 b=t5hbFiGtoPAEWmUltaN4b3n9N4wPUo/GU7kI1+gbq3MoH3gCBxytt4VvSuf/DZG0m1bSHBpTArZ5M4eRc2QKhxIAGFTZmoJJUTfKrdgCWerBkYZR3m8zceEzkMoSEBYGWuzbZ4j5p2iwFIIAVluShi4paRPt95N44Pg+U73YQNg=
Received: from DM6PR04MB4972.namprd04.prod.outlook.com (2603:10b6:5:fc::10) by
 DM6PR04MB7052.namprd04.prod.outlook.com (2603:10b6:5:24d::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.13; Sat, 23 Jan 2021 03:03:25 +0000
Received: from DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::9a1:f2ba:2679:8188]) by DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::9a1:f2ba:2679:8188%7]) with mapi id 15.20.3763.017; Sat, 23 Jan 2021
 03:03:25 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3 2/3] block: document zone_append_max_bytes attribute
Thread-Topic: [PATCH v3 2/3] block: document zone_append_max_bytes attribute
Thread-Index: AQHW8JSlhHxVQj6BSEWc48JBLHcLTw==
Date: Sat, 23 Jan 2021 03:03:25 +0000
Message-ID: <DM6PR04MB49728F70DE83642A3B61D51E86BF0@DM6PR04MB4972.namprd04.prod.outlook.com>
References: <20210122080014.174391-1-damien.lemoal@wdc.com>
 <20210122080014.174391-3-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2600:1700:31ee:290:89ac:da1d:fcc3:58a9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 61c0c461-c680-4e14-c015-08d8bf4b73ac
x-ms-traffictypediagnostic: DM6PR04MB7052:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB7052FD4A049DDBC2583D183A86BF9@DM6PR04MB7052.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:335;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /mmDb9FjlpwKNSJoJDYobyQK5hrEEAOD3o7Ha23Xt0QtIjzrJvVFvrfdx+bnZdfmvZe29nAyXIauUk6RiHdcs5yyfbZtXGcjl/EcX6SrzHxczVVlDfFqqKkuofCmB/H74XzB+3Q139ttlXZ0QdjTB6xl0e3Xv0VkDOI2hTykFw05coVR33k4XC/cL9z7b2d953Hm5lUtuXgs3V/+dgcz6YFrFhNlSISy6qFkmlrSlhzW4suTumqLxx7YxOXC/KcN9apkAInUDy93lFJsbubIK6bz7G6Afklgcprr1xPElnCOl9ZYH/nVnRGHSoRRSXhyHVgKP1j8I8VQBK0AELiD4TNJ7u8WRAnlMOiwmZMm0Dp275S/xbM2eDCYLakINYaIHea6ClTCdxWW9B+qAX3WnQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB4972.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(558084003)(8676002)(316002)(52536014)(54906003)(33656002)(66446008)(66946007)(110136005)(4326008)(66556008)(91956017)(86362001)(76116006)(5660300002)(71200400001)(2906002)(64756008)(6506007)(66476007)(7696005)(8936002)(55016002)(53546011)(478600001)(186003)(9686003)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?tqgUttjpCOzH6K9R9WCw7664i1WVkSsOEtDwcwniXkUs60cudpcsrpnIZ3hJ?=
 =?us-ascii?Q?tiRPdH6VHYHxokN39hYGxhOLgTIh/t7cmve9S5LP9iUMOy9Fjx3r1H/fgVjD?=
 =?us-ascii?Q?+jLWNnDj0IGTZZRiS2Ak3XtvPG+0FoboxdXIsXWz2Sx9y+lclyUVsy4MsUSB?=
 =?us-ascii?Q?z5Gs8Crye232VLzJQ2w+wqgARuhOO+toirOwAdT6gPm5s7MJcQ52n2QlV+Cz?=
 =?us-ascii?Q?Uz8g1k7mI277WWGjVkRosPWUt9gxKKQSl37i5b9zZVHkB3OJCx9cOQ/UNXF8?=
 =?us-ascii?Q?W/Sd8gU/s2fskfXt7HJQR78EJnBbQuFlZFYTVIV0JGsq9CR64n8/f2Lh7CvW?=
 =?us-ascii?Q?3mYWUGYC4UsEV81P+LYtwdUc8UVMzs4mjbxMyO7DJ/m//KbgIKTTrxmKvUBT?=
 =?us-ascii?Q?1iHEctnNQV7+3nO4zAA/ltKf1k6e6heCZSyqYPNKMnDVZYEBudIHrbEHhEZ9?=
 =?us-ascii?Q?F1Yda8Gb1sW8ivxkt1UFu+RhgUHSVKFqZYx4QZYP0AVArb7v+0MEdqDiaHuN?=
 =?us-ascii?Q?+/1ctf+Gk9g/s562zXSKZKmvTk0mI2oyaVTciNcrSIxzUaQsDo0hV+IckQAV?=
 =?us-ascii?Q?UNiP1r7vG3hEAB6YboHbsPuCApkazfYaoQ05Os9EbRO181DU77tbkgBIF43p?=
 =?us-ascii?Q?1DLxTRA+sjzH1vKAbACuBck4vKPPaYwOPlY0g8nUf035IdHUM/GBB1cTwD54?=
 =?us-ascii?Q?JIoPb3YBkf7DJSXZdmhGQhrsoamHwd/DKcPmBtMXlFb50+7ImxHog4eTBoks?=
 =?us-ascii?Q?d/gIgpoT6cFWADSjAcGefAS7U95DU5guiQTJvV/HN8tTFcuA7pQ/8TX6vyfd?=
 =?us-ascii?Q?yhiPkXIk23Awmp1+qEMvvG1w/5qrCcNogtAgxiqN5HHYby7GYIDvdkNUAPxH?=
 =?us-ascii?Q?ZdQTkzvb3rBx17rvFyzFfpPJKBszkvlO9Ut/aae+aZ/N2k0PItTAOZs8OGAi?=
 =?us-ascii?Q?wVzAA8dwS+85qO6lkipoB49oHIanQoSzTc+qUzQbrGExUhXLKoP1n8lJaH90?=
 =?us-ascii?Q?QgW3lywQewNNpv7QGeQbD+yexGuvyD/6u9/JDFt1chB/yLGytaq6qjNmW0fV?=
 =?us-ascii?Q?Xm/CyIihX3EIVoDz5VIFwcqka8rMzQ87J6PyCIux59U+Mbl84Z+Fc5CTI6oz?=
 =?us-ascii?Q?WkhNpUynpzf0azsIubMthr/nspOE+yMb8Q=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB4972.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c0c461-c680-4e14-c015-08d8bf4b73ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2021 03:03:25.5929 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oyLU36aoVikUQpu0H/JWfg9YbVC4M7AqGREtLosHWbOr2l6tIvcEigr/essbAMFkkZpY8MNs8kZbht2hF+gTxkNA1+mzcUfJYyfEOjlu+lc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7052
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210122_220332_341566_B2BFE9C9 
X-CRM114-Status: UNSURE (   8.79  )
X-CRM114-Notice: Please train this message.
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
Cc: Keith Busch <Keith.Busch@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Martin K .
 Petersen" <martin.petersen@oracle.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/22/21 12:00 AM, Damien Le Moal wrote:
> The description of the zone_append_max_bytes sysfs queue attribute is
> missing from Documentation/block/queue-sysfs.rst. Add it.
>
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
