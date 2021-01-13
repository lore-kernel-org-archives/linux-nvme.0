Return-Path: <SRS0=mLmp=GQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B291AC433E6
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 05:05:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4658F2310F
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 05:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4658F2310F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=PV71LMK5S0ei1istXi4PO83sjrPktdFnbT68lzGcU3Q=; b=Y2czLE5vgbJceaoEZHG1fxC/D
	psDEyeE3U9HYIbBUKs3whvUKtMskv4NapM8F0QOKmI0fJYG9/bXJVLahe4mEvUyBc8CdZVhBLDePc
	vsLkS5jtV9slDoifBJDtGg0QQb12kQBRlUs5KSCSDO3Smb6CAEbl4b9Wkqi3s+J0Ok2WyD0wkTlVI
	Vez4YVZrLszEHu28Gk8Q/16aSuEyI/6xmnbU9FXQPNH36SreFuGUGAhjwTtuVOam3ZnTHbs699+Rg
	9WY47ywteV0ZHGFoaIkVl2TSRiFm6voaNsGOpJVwrcaDdzCOb4oKLSrYpq5BkE8iosAdB0bgJaHxZ
	GJpFynQ3Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzYKz-0001Jc-TS; Wed, 13 Jan 2021 05:04:53 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzYKy-0001J0-AW
 for linux-nvme@lists.infradead.org; Wed, 13 Jan 2021 05:04:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1610514292; x=1642050292;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=/xlJg+4y4CHW2a3xsYaRFjeX+7AUWadCYXT9ECeh6Ao=;
 b=jmFG8CYwDTnPFhqo2dDbOY3uh8ZbTOqGcYO28oUtLYJGnSzA3c/QWKVv
 HoBj7DrTJRqcTaxlg7gL6ddfh0znO3QWKo0XB/So+V9KdPvkodciSY2HZ
 orCuDYAjpZojLd4hAVWzaXXvzmVoNpRqEX7CnRTu+SKv6X1Y02L5cHnDh
 /8Vswf/joz63lx3fDg82osyMoH7P6UaMVCl+YzPynnEeWvJcCwZFNQqvU
 MBKl9dF8skmqJ6fF5kdGNSpowuP+wSuy1YhNXDNW9QUHfe0GvfdZuXA3U
 rU77+aqTJHM8yjE5n9qnbWznvgiwUNbXVMXcRaeTBIzv4+QHPIzc6OvRk Q==;
IronPort-SDR: 2EUd8nchU3MiEwBNPKpcgtPslY5KSyckqIxjB/My1qgMwPB5AST8qJb3AUZmJx+0Tn3zCufcP4
 G5quUYZWgiVRohEcYUhnvjROjQi7F0K1znGpmMAU2iKBt/cK5DvdKGJn+s/eAiuB3Wv6brL/PL
 mJJy2kXj+sQCrulHcphypjNk+6o6d270SSh895c8r1stL9UdI8csrQcZC+npiwgV9uCzAOzYFn
 3gM/l74r77ymqkb8eJp8FsAdYMY3J/f683KFXKFFdSPugYzjsXTIHBzNgNA2EO9xPK+Y/pUbDU
 Hec=
X-IronPort-AV: E=Sophos;i="5.79,343,1602518400"; d="scan'208";a="157300652"
Received: from mail-mw2nam10lp2102.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.102])
 by ob1.hgst.iphmx.com with ESMTP; 13 Jan 2021 13:04:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kY03ZLL01bhOVd7kG/fwSqKZcPaJSikApmfawiD2VBTvbPcnPT4lju0LIvExnLlCMrRDZVC/X2l+oO7/ecqiGquy8OISvlsdSunddDuxeX4RkvCvB2f52MzqBs36nac16m9OatjelgkRTAB/+oJ8DQHSEb7M1YnzDulRMrvWHVPdtPkW7szwAuiT66BpHGaX7g6fV5LEWmdpCM4nDk5fPqn+OWBQhZtbZckzP7F3uprc0YDL0Oxx91x9Pt3SH2SlP67JW/BEiQu/1pgd96v20m6vqxwZaaBLVolXdnesZjdYU7D52yokqbaCYmnLQBspwZwPRfq094Y84PPg9OVNfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSsbriwQxbUoUcBX2HUUSQh7SxZdBW33R5y8N++/mo8=;
 b=gJegPvPEGGYvOZSmytGLxnVP5r/oNh8N/cI0xESazFfaWej805XN2e7l9gd7jVYXNapgz7XLP6ArTZjzyJoQ7eGkld14RW5Vr3frq2xqEZmeNRtAWEl/RcfJ2XFs/5cfPgpikCtJkHxKpOw6Aa2ZetXJS3ez4/T9L+Ksu/5TB+2KbSTmghrN6N7odm8y5+vM6b6ug0fPAMEvFHMGMLFYBMWb8FYzjza2e5V1OOF5ih+6rYbDn5G8H33OuGnoDUzfotmnPjd+lTvWAdQatuHL58zWmkcb9Tj3QfykWJ2BKc/EA/+CpeJkfccxI7gn4mdWQy+mheG/seGruv9gkudW0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSsbriwQxbUoUcBX2HUUSQh7SxZdBW33R5y8N++/mo8=;
 b=dj8IHlV8lgs4H2TgWv9n3566WiNLBav7MdKmQfQ526JGYNHQc+m0yR1KbNbxXWHy0W1N1VH8u66Ue3XmoAtmOeF0tPKw/wFYtm5EbkJ5MW3mwclB+Kolv4+MSdRuTbykbqYtk1P8IvxFsOTOd3AYJ+b82EH/AfZ4EU0zyTCv0tw=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5333.namprd04.prod.outlook.com (2603:10b6:a03:c2::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.10; Wed, 13 Jan
 2021 05:04:49 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a%6]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 05:04:49 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V9 6/9] nvmet: add bio init helper for different backends
Thread-Topic: [PATCH V9 6/9] nvmet: add bio init helper for different backends
Thread-Index: AQHW6Js+dLnOabsb902jm/8Qx/tj3g==
Date: Wed, 13 Jan 2021 05:04:49 +0000
Message-ID: <BYAPR04MB4965824B7DB93A26C625AAD586A90@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
 <20210112042623.6316-7-chaitanya.kulkarni@wdc.com>
 <20210112073358.GB24288@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 15be180c-b482-4ab2-2cd5-08d8b780c0d6
x-ms-traffictypediagnostic: BYAPR04MB5333:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5333DC9DF43AEF372E55176586A90@BYAPR04MB5333.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LVdurMt5FvcCnEv/qHMTQ1w3BOTv5hl4BllVR6soNUDhnYK+baQzlHs5NdJSr4IcUnYPgRw2TDf1r5BUDADNs7FZXLTwCx/toWL1nWD6i2LO9KUqSC8oMIz40nzAX2JLX6YEb0phpvE5iYcK/AB+Wj5ST00aZpb0wuJoEE+6Qj/gOaGDFULp8Fc4ZSkD3kmy9e8/c8SWFCs2vyqHK1FThbUJZfMM/YpstBocq1BRPIeKtkadqUoVlAYJXcxo+f5Zm0bjOxexWb7fFm2CbaCXBdzH8baBoQ5CEIJZwRHSokdU/uBYtU0QLoRLRbRupvJjOF6WW/+9NbtXnyYJq+DLoMhgd942S63TlR34f5vYeteCDZ9pKANyliyLJ+PGsdrlyi8UhPzL1E+IlXcLk0JL/A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(66556008)(26005)(186003)(7696005)(64756008)(66946007)(54906003)(66446008)(8676002)(86362001)(316002)(66476007)(9686003)(76116006)(55016002)(478600001)(4326008)(6916009)(71200400001)(8936002)(6506007)(53546011)(52536014)(5660300002)(33656002)(558084003)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?lzPYqIBx3Uvjr9SlXfAsEY4jHHBgtDrmDdHkXBUPxvWkoNp7DPxY3whRrleX?=
 =?us-ascii?Q?6f/vANi8Tvh1d+gVzvkVRXmHMmNA2k98UBuWCMfekSrvybLP7c5gYHAj4mUB?=
 =?us-ascii?Q?fZew9Bz1v1Vl66ZYngZnLtQNJUNxaOi+rVop41MZgl+jJo/0YtC0yN/IWAxA?=
 =?us-ascii?Q?k9QhnnKkCvic2RwVwDnGud1p2iyIibdIgoknZA9ph/HiGa7pAgSFQH6v7X+Y?=
 =?us-ascii?Q?u1yhvLFwjOjFr/58Ml4srlMtnSE3jAhRXEsA43ws63RZ0q3mJM0NZmimJLdm?=
 =?us-ascii?Q?q+xDXhVaHf4SUQBscPdX7ZPQcqKXCMo5RwZtfp3FfQ1W/caqBmHbGmqMarGv?=
 =?us-ascii?Q?fl3RZtoOVRBOpy8wcPHQDu2Rpw4ZO1BwFNM/SoW3xMW2nAj4IWyS4sUmqC7N?=
 =?us-ascii?Q?vkAm30+h8aH7EF+MGd5fINVGP+ptEqy4htHMh6DYGdFQT99O5SeRqRIFYICc?=
 =?us-ascii?Q?2f3KWhA+mssbnsy3KIJT8h8XuIrl+MavKdb2PxtwZLIzS7z4crBGbbk/K61r?=
 =?us-ascii?Q?FzsCY33Lubir1w77U1otHqaAU8pqD+SJOUMKWI9CrPWc4fFpSyhaN4oIT6Zh?=
 =?us-ascii?Q?kr8+c6uYJ7drYYJ/qMBTECD8LXy+1xFJG6zfsT55nb3W7hCkKCkhVwZfyhLA?=
 =?us-ascii?Q?fi280hpzgwehKMZDB3Yogb07LCNW1rq3MHWIXNxR85KukrNIUYImHr/KpwSH?=
 =?us-ascii?Q?j0CLxw3cOQ6YZe8gFCG5/V5olc+FiWLcuYCjGdJtiebF2iLmppugxW5M0cOh?=
 =?us-ascii?Q?8nAUnvqk2M2ozAcWmoWM/Xz8xxmX2LEEXtUL5T260q9LSc5qOUu8j7rV+65f?=
 =?us-ascii?Q?J/k4i+JgA+YC8VneZM088pNe6vLg/MYFrH0qPm0TQx5I0TvkqmmHBcPHHq7S?=
 =?us-ascii?Q?pT9VkdRrzDPHT3e7jDNb9AnO/MoToC5utRhBrxW6jT//ZH7SVSvorOZ5jjNP?=
 =?us-ascii?Q?BKAG3EerEs/Lz49VKoh6neDkiXZKqOdSiMsNvX0NYjd0BDab6Ngv3KgzP7XO?=
 =?us-ascii?Q?hfcn?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15be180c-b482-4ab2-2cd5-08d8b780c0d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2021 05:04:49.0666 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hqd0zjq2raAfkGKTtYCrqKKu9auyJc+hM7enq+HkwsmKQQLz+PqBdkFiQahzyiZfjZsOTE6/hUtkmoXX49pvrZFyLAT6/e8RBRXP2yxZako=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5333
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_000452_535119_3872EB35 
X-CRM114-Status: GOOD (  10.14  )
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
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/11/21 23:34, Christoph Hellwig wrote:
> Nothing NVMe specific about this.  The helper also doesn't relaly contain
> any logic either.
>
What is the preferable name ? just bio_init_fields() ?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
