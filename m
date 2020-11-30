Return-Path: <SRS0=wRjJ=FE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330FFC64E8A
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Nov 2020 12:30:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8279D206D8
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Nov 2020 12:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JG8cMgu1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TnrfaJkx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Z1sxdcuc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8279D206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=rSQuO9aUnachrUjqlY9FQsdAzr2GbRjzt1x5uxf8r+M=; b=JG8cMgu1xr8ZVDzf/xVJxdhnG
	yFf7FlioRzDRzQuu3F3FpmhjufnkOrjPS92J5fW7yURqPy803BJOW2tYvK8TqwL74VroEfdHvVltS
	H5I400l+XC+SveDDSBQ2UVMmddzJ5pmCfbM+zPRdkc1uktNhvUWpINzT+2wVLZLvgRpqJ0ytAKZG3
	L8IPf/7IJbW55AcIsYyMbQ4IJxA/6odTPIOTTv2pMWuvfCOoZipYmqOMaY4Dilt5pG80xnEyz2csX
	QgbvFFV1XSFhFWCXdddyohJmVTivxjj+Mg1ezrAcMZX6YRTJxIEJf0ga5v7N8rvwrnAx8IkBYjJHG
	loV4KT6ww==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kjiJd-0007tt-6b; Mon, 30 Nov 2020 12:30:01 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjiJV-0007s2-Sc
 for linux-nvme@lists.infradead.org; Mon, 30 Nov 2020 12:29:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606739638; x=1638275638;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=WCY02q+6arzTKMXB8yvWHgwM3dgBCsBJVjh3vCtarYQ=;
 b=TnrfaJkxCh7Mm2Ui6LE5xo1ZTnbjrM7vA73LWSHJguVNcom9HbvYerjC
 3M6B9agkfVFduOE8zJxtDn3DOs5jk0aK79g3BxyM2ccicLpUoB1HK4OGC
 lauI0NFHKIylCbZ1T2KAMxI1Nwx4s7vDSnvXk6nt64c8i8UGtY0Dah3az
 L1ojR2botNa3sJ65xX14IHLIXOCch7dXm4PblKmMr786AOszb2wPZNHpz
 9xh9o2if7+8F4Ht1GFSiAMUZZl7jsZBpBi1ea3dCaYmZvguILKhDrKHdP
 EypgtNosGVY7c1Q+WdbbIEgdj4/auDUPN3hBGof65IIEgnfWums+Zpvam g==;
IronPort-SDR: 3akjqz7DGznetLMpT500qY334siPGpaxflPeVjy3GWgvogaESkl/HDhhsqgTDnqC3Tcl6WwqNc
 viTmmFAo2W8Lpfl8c32bFaY0xftPmJE8agHfghsX4RYx6fU+y56OZGYGBsAMsgE6ZeWLkop7UJ
 OcntXAfGlSqzjjrANugHgBv5BZX+JTY2IEvxF+GiHBc5g4WPfVDiu5vdWDPqWIGOe8WYfthbhA
 yRUrbNdOa1PH/6IWxAZ13CeS4NyQ53oj9DCJ6zi0jXqsaW0yKNXp/OPAWWok7n+jMq3TZrUMsa
 UZI=
X-IronPort-AV: E=Sophos;i="5.78,381,1599494400"; d="scan'208";a="257487802"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
 by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2020 20:33:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cojLsWp103iElLNjMp5bI8GpzJjeYFWrhjeJ5SLx48gzmqrin9fkMVzCoFnCF1OBdPdR0uH3OemsLh4XRtSNSRRDewA6ViqYx3S4S8UxFuUGvFHVe7gGYbPRLCYbX+MRyrm9vx3zQkC2tgWRceHLrxwAsE9HnEK2EQNy9X/aFzhks1Md0QmllmEW0kN/1EzQ8xyhZ+YWPB3ZAuFqU1K2CPTSTCAZDDuxx7dSK2bbjI6euE/rxNPlGOz1qgAN3xr4cNfyS+w4Myn2TFSw+i934J4WMfm7HVs4hL2KL7S7JmokboYQEUP7PIgYUvJdsaVZ/IqRgPnZFKoWCV9C03FzOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apAXbdaLLVNuiF9sM5Ix1xWIFtkC18oLtFHaXCwitfo=;
 b=RFVb6gUjWJ3X31KNt2iCRReU6uLJXfmluilu2zHb8zdt1vHAWtF90eRbl71ANPykj1TbhZ+qF3lp/6naMLGscHnGtemEAI/VyQlWl3xs67aMtps0hnTjwD8I1jG4K6wB09QXsK8vvYluVttwwK6/flofrwqXo+2n48lEcq0wfZfCNjDX5Vb1GSO9hTesBsXPFfahZwT2LSJjDY4FajHLr3hXXApSwjkw8Vb3ePKc/ZG2eJmol+Qs+MoMOwinISTiyti1lXmD63VSevvo/M613ZATYEEBU5+WOFjeUEHPB9STYClLJqbnM5c71eqdHhxHHM4AxpKO6ouDh7reYsYjcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apAXbdaLLVNuiF9sM5Ix1xWIFtkC18oLtFHaXCwitfo=;
 b=Z1sxdcucgOgHHeo9XEDIQMfZb5iYpEklJATwXTldyEHaen3WMr/fAskVJ5G7r/WOhFLQGA3yvQN1RgNnnirIAEx3jBxnKbugu18BII0to6Bq35FzuM+7wqaNnxBktUT5tld4HWpDVKYKgc9FmZN2/U/vcNTZky22ObXF1ef2I40=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4045.namprd04.prod.outlook.com
 (2603:10b6:805:47::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.24; Mon, 30 Nov
 2020 12:29:47 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98%7]) with mapi id 15.20.3589.030; Mon, 30 Nov 2020
 12:29:47 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V2 2/9] nvmet: add ZNS support for bdev-ns
Thread-Topic: [PATCH V2 2/9] nvmet: add ZNS support for bdev-ns
Thread-Index: AQHWxsl/DkSBeYlhG0OpN4tsfc2WHA==
Date: Mon, 30 Nov 2020 12:29:47 +0000
Message-ID: <SN4PR0401MB35989F591B47F3A8AD3E2AEA9BF50@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201130032909.40638-1-chaitanya.kulkarni@wdc.com>
 <20201130032909.40638-3-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:155d:1001:2c26:fc00:7c60:29b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bb26b93b-cc86-416d-8c87-08d8952b9fdf
x-ms-traffictypediagnostic: SN6PR04MB4045:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB4045A09B10F7261F1DBF881D9BF50@SN6PR04MB4045.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VzQ8X8K9X+u3uqSdigjtJBe7aHtu/LMrxAYFwiMUSCu/kRu6JSGOyWDQi568AbZn81DkCsC9zR6XMo34rLxOksriGdvtXUICvc+QQukyywB0muPxPR9cyfH7tDqJAG0K4fs7+gNBp6gYRmvtvtmCl+oR/KZ2hJNn+5HM5ftNDM0yyYiWcl/poZIn5ESLAcITN52nye9Sx3MBPRNvq7wxjklE7sgoEyguIoRlobjeuY0jeImg05FDgHCMmq9iHdFDyaN5xvcicEA9X/l3HczA6i8RYZHk+cVBvgXCveJiVXjsCS2mI3dOEtLBrffPpeK7Prt00cgovZp5qA1qaqutNQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR0401MB3598.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(186003)(55016002)(4326008)(7696005)(6506007)(9686003)(316002)(53546011)(110136005)(54906003)(83380400001)(33656002)(86362001)(52536014)(2906002)(71200400001)(558084003)(8676002)(478600001)(8936002)(5660300002)(76116006)(91956017)(66946007)(66476007)(66446008)(66556008)(64756008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Q0eknnpkZNnlsg+W6auDc9q3KIUDMdX8y6uMh4WSd0HuHiLIvAVkJLZ7ubGo?=
 =?us-ascii?Q?nMQD7O0D5oVjw+s4IOm/SEN664q1q6g3f+QK60FPN52vv7ERvTYpd0j5Noio?=
 =?us-ascii?Q?QNK4mnWhkxgpgu3L+gPd9uHNCsGaF16ysSJqk9K4aoz5sJqrDnTxyQi/l9hm?=
 =?us-ascii?Q?pNKe+krq3O8tCyFb1qTf9qUlBPvqRqLHreDnSdNFDK3msOv7/EKqlD8QdmgO?=
 =?us-ascii?Q?osdFiVl/y643P0+/afU2SntoAgj2/p4c9fmgm/1fCG+9Z0b9Xav3qZOWNYEL?=
 =?us-ascii?Q?Wr7uIyYtzWxAlAiC+twSFBpAlJNNfo1Xn2QAwzGDIxVu8Ft6gXnqtd6CvTSN?=
 =?us-ascii?Q?DunNG6QHEJU8UQpsERWgZDfRK46wacyUM0k8ObNUUy9sBpQYAT1lh2EtEElQ?=
 =?us-ascii?Q?Csw3FckEWUZJn0pfd/jNW/gp07niqLf/4+7BoGCOf4V3QpsCazykYjOKLCor?=
 =?us-ascii?Q?Kfet7C3W6e7UMe6S8iS0/KrZn0pk+D0pA412wTedBrOArxdWX2PSpyGqd7s7?=
 =?us-ascii?Q?CBwtSC7c5ICyUR/URqevKXeMMCecMxFlrHAOWLd3hmadEteFrkVUBcMS6Zb0?=
 =?us-ascii?Q?wCcOkpeeuJuOJXNi8qfRr0LKlSu5dum/Q+SKs1aidPJWwytQcu1MUHZ3hDLW?=
 =?us-ascii?Q?wBlNEaDsb0qTL1E8VcOL5UQVTh1fiDH4L3xvsMVZLoNgtO4V2mbcY/o+ZuTX?=
 =?us-ascii?Q?w1rPYBs3R6D0T5VtKhb8TROFfbDPaXF+/dl1w0clfAzv07iaYJyyavP9Hzyv?=
 =?us-ascii?Q?I7rdTK9aNgOcynXk/x9PFjodk7V18hWk+5eSYHfdjSAGQL3F9UiqxlD1L219?=
 =?us-ascii?Q?QcEXhHe6aUhOabC5D4eGK1sOLA89dC+/h6lsOnHyz6qAA5kbw9A3IixQ1kXo?=
 =?us-ascii?Q?KQMurWZALsjf4qe/3eG/HpHsz/hVB01cbOkzqO7yLGF5Sm9ZrE9JG0mQ7RBk?=
 =?us-ascii?Q?ZQ8sSAqwwrgF6Qm/OlqQY13Xy+CSxbJlWHAifWZTO/8P34BIuK66Ls0brTEy?=
 =?us-ascii?Q?nOzTaE61BxXRNyoz+1oAIMSmjysZpykpQc4j6KbI1lt20drW66qlRFRkDje2?=
 =?us-ascii?Q?GT4enPbd?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb26b93b-cc86-416d-8c87-08d8952b9fdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2020 12:29:47.0585 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bqocvpjGSUEART+7J4iHTXylWswveWWxMEzw7MxiMoEyARTYb7PI4nViKlleAdcYCI/HGmwoDEAh7judu0wus20wb/qLSVyA6Yan0wbDMqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4045
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201130_072954_756104_770FF368 
X-CRM114-Status: GOOD (  11.84  )
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
Cc: Damien Le Moal <Damien.LeMoal@wdc.com>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 30/11/2020 04:32, Chaitanya Kulkarni wrote:
> +	ret =  __bio_iov_append_get_pages(bio, &from);

Can't you just use bio_iov_iter_get_pages() here?

It does have a 

if (WARN_ON_ONCE(is_bvec))
	return -EINVAL;

in it but I think that can be deleted.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
