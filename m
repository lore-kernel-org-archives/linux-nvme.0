Return-Path: <SRS0=qX5s=J2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDEAC433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 01:26:12 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98FCD6143F
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 01:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98FCD6143F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=AGqqB5pSv1mqpbUvzk4f9Vm+tJNEwQdd7bcMo9neR7I=; b=DxN8BUh7Rlrl2RC5t/vAfXDsr
	IxSwBRPpI+FdV5aAA1gNurRrT+gGy4enISqcQnGy/Ze28/enA0DfRfHOe8mi4bEuQtTEPsOzV5x+I
	41vf9VAdkFg2Dcvmp7o1bsh29EfLHm9iYIjWfSJxX2zhLkGFM7/qXnRDfMmmdC+dBrNs2VSE+s7+9
	LoXXf1J4BnuWwZN//X1d/LIAInI9LrrZY7jIxA4JLHWpVY1qfPZ01Kx5rwaVGG/IkD30MXAwky+9o
	2zZIQ222aNzdu5pCp4iKy/FZeevdcc/iGUXDCEWkL5OOgpMXPMTdKEkU8udntXsh7VTIBW+AWNUe7
	u332X7mUw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbvRH-004cQs-5h; Thu, 29 Apr 2021 01:25:59 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbvQC-004cMZ-R1
 for linux-nvme@desiato.infradead.org; Thu, 29 Apr 2021 01:25:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
 To:From:Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
 bh=8PwprfGS2fIZiB8cJqEAuOxBhhmReRgBHggKOmn0mQc=; b=dCAuWTJC+R+eBLHgm2Dhj0VGXX
 YcfR4TP5jMnxQe6J8B5sxz0IQFaA24LX/o5+K5WHPiopEhzDjXA25EsNefl6r4eV2S+riOHJ6f2uW
 qCCZXg8Q4va6D/dZfgoWJo7C+J03GxIMn8ylUCXquvQ0+F05vost5uVD+jyR2GMKojYxgJecdEs34
 zUx+K2I5a2cZCuFlnUDmWCHQ1nclK3UYNMeQVZMs/5RG82C7ERkJffzArH4C3+nXOuYLxyy6jXZqb
 7Q7F9VaERC8YrrHz90Y5ZmepxQhhWQzh2gkO93f9ieg6WIKJNUGduKmBIkDYmN5DxY+jkwMWDyqGW
 5akZcL2g==;
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbvQ9-000JFH-NT
 for linux-nvme@lists.infradead.org; Thu, 29 Apr 2021 01:24:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1619659490; x=1651195490;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=6wvyJcsrwhIoP89hKGYnxwtBINZQ6wd0/peFuh6l9tM=;
 b=iswF4ouDgElXBxMQNrA9u5+RqQavFRqKo3lXeUG2gNLNawIEcxcx8dwC
 9hFI3gqSXLhVoWW469ngVXOx/zYbOAPpC5caFZK5aiwTN2UEgg/HEj8zA
 FnLvYIx7Jr3uhsRsWVn+MP37OZmdh/oo/1vzPnaHFrJjColvR9tN9APwq
 /tFkAqXz4xu+Rjue3P4k+DncHyLCubk/wxPqfG98kbgim7unh0FUaMdBK
 1WTlO9hx5COx8Do9QvuuZsUI86mPdn5ov3jNICqNTHjBxE0jl7mmkvaJw
 RSgAcIrBLim3rPrR4eESQS0vINmr8UxGmeUgruiuT4T5BEeMCwSfffreI Q==;
IronPort-SDR: nfiknSn5QMNfqFCo3AYVcxjOcz5mVzg2fJAvQB4hEVyYiq7lG4G+lNlgXeEOkHV81etvjzikwH
 8SxSBEwen6mUKUnhI4Gkx6wX0e8+Eo1KACp68j93EJScmTmoq4HccvA+aAhaOpcoaV48fvDKUC
 QUVnVzBkf/DU40xzcx0ErSuGMR+DxiTb3YOhLvQ6Jwupx5nQXkj/3QjorN5WUosJ0WMORanU1K
 rHafL3Q2oAXzucIDZSKYJkWjNavBGX84Sh42ttyQMi3KHUzFpWBA0nk+RhTB/CPIzK+Lrgf2wz
 mG8=
X-IronPort-AV: E=Sophos;i="5.82,258,1613404800"; d="scan'208";a="167150082"
Received: from mail-dm6nam08lp2043.outbound.protection.outlook.com (HELO
 NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.43])
 by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2021 09:24:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dhs4RzovWFbuomDRxaj57ilqHOjTuG4LDxyFIRiDcZoM+nJpm6BigLkkjV+cGFxDYzZAOhCV68kURjk3IFgu/f9feVdtk751li6JQZEhHAd2sslEXW2ihp9k0K39Y400gTVZnMWYbWfrhoqOv9DOA5tPio7FlPrvSfLSMUNkgurr7/1S3AgUL5Nqb+2hDL//WkhaMB8nMFW6hCQhbwqoNtpWFYmJJWRDsx3Ii+FtSdZ4U3RBBb5CbIGYXVNVxJwmkPGGlqY//wzLFoHTfln3XMGqyY8lh5++SPbSYVNyxGXz9uHUC8QflAr/BPq/uJI+bjbhOH+LCX+ldHGbeFnU0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PwprfGS2fIZiB8cJqEAuOxBhhmReRgBHggKOmn0mQc=;
 b=UopVFOn61OBrvm6hAC9yHZjgTkvqM25qLpELFNzGO0iJ4LCrrIQMN21F10k2sYxaj5LBwep36N9OSpy0ZdnQxS/h832Zs3rvmRe/qe6fhwEYk9j/1nxlucjRQz0fTqgwcEf1GBVeEQhu5Rm9JB0R0mFnCOhox5bG0uLOERv6d9/UUBnfB9aiPq9Co95xCf9+4sXpqnALCE66XA3YBKTKHwGplunj3FR0reKA5/mOR6bwiCFUSnYwGgSuT8kTdp2luOVAXkSrAF6AVR1pPvalsABlx9FNGQvMT/i3nrt3puIC3Ivigk5q3jfgD5/jTrtlGdYfRkvCDD863oodpgmSFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PwprfGS2fIZiB8cJqEAuOxBhhmReRgBHggKOmn0mQc=;
 b=HVJzPbSUzMFJYDBCF0mk5jmwFioSB2QH5T0fc1dPoGAVS7REbLjRPSRWNJg5vuQxjAZCeIMW480mEXKYaRX549Y/ZGHbonxz6IbUo6UN2G5griiP9eI6rzn7sqf7QHGn55FnEba7vTbDZJrmOYJ5fUb74qmC5h8VO73Z8O8+ZJE=
Received: from DM6PR04MB4972.namprd04.prod.outlook.com (2603:10b6:5:fc::10) by
 DM6PR04MB6698.namprd04.prod.outlook.com (2603:10b6:5:22a::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.26; Thu, 29 Apr 2021 01:24:42 +0000
Received: from DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::882c:527b:8a9e:8c01]) by DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::882c:527b:8a9e:8c01%4]) with mapi id 15.20.4042.029; Thu, 29 Apr 2021
 01:24:42 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Martin Belanger <nitram_67@hotmail.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>, Martin
 Belanger <martin.belanger@dell.com>, Martin Belanger
 <Martin_Belanger@dell.com>
Subject: Re: [PATCH 1/1] nvme-fabrics: Generate uevent on namespace AENs
Thread-Topic: [PATCH 1/1] nvme-fabrics: Generate uevent on namespace AENs
Thread-Index: AQHXPG0XeEN+DoD31UWTKCt6MGrgfw==
Date: Thu, 29 Apr 2021 01:24:42 +0000
Message-ID: <DM6PR04MB4972E8D024E2B3C3CE8681FE865F9@DM6PR04MB4972.namprd04.prod.outlook.com>
References: <BL0PR13MB429142FD8B9FCC57C2FE451D9C409@BL0PR13MB4291.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hotmail.com; dkim=none (message not signed)
 header.d=none;hotmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94c7d378-ba80-4161-a3b3-08d90aad9106
x-ms-traffictypediagnostic: DM6PR04MB6698:
x-microsoft-antispam-prvs: <DM6PR04MB66989C7F426EC94DF4ED9554865F9@DM6PR04MB6698.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bsVZ424fQqs9M8DecbELWR4tH+tGWE9OxP3WGSv7HUNb3uEOMkGG6L2iMsULZVxkCbecQy11j+sGkF/7J/lj8FhqqhzYCMqj79ulWjqd8mBnD1o6hkrhBtedcZlKW+HWXbaq/s4lp5F9a/8AFB0wkAjVhDgNUJJbIhua9q5Fz1PaGfN4sUa4PwbMuzQYjMBK8Wgz42AnsVYkkRqmNLW3gv28G8Y0VWLimC8ezbQCj6Q16V79k/wOkKMwdhTngM2+ubFXwEYUQaDPHk1EYpjYmrH8MIcS+lQqqR1M5bylzs499BW5e1vpMXE2gY7hfDSYG44ZvvXDeiVvPxJzcaNDnI/cW86BvEOiv2kvkXpaGUJR1E98/rHwNyHhqb0LMNxxOUDPMleV2FEZDjL3aKskZWbWk1W+0oqEwUEmxcAW28e96lsCwCdK1l0mG0qRnyJ4o1H4Nj8VwRw7+d11SN772u1YeZaqs6eAau9P7zOeTxNIcEscB/lzmKACe0yNiJ+LdVBxOaXe0Trp7N+dTYV7qoCgkY5Upq5fielbXtMuTbigcTNlSBtEH8f8IkengUceVpVsY4saUuJYc9hYGe3+nuS0ISi0IbQWeTHq9LSY6SDmRcACpY3FfLY93s+22vS9Pokf1wjwEU4cIDORRge/yrJH25ZoD74iq2W+ziWmyxRkHiVhjQV1CZKj3A4DOE2i
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB4972.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(136003)(346002)(39850400004)(186003)(478600001)(38100700002)(6916009)(83380400001)(966005)(26005)(4326008)(316002)(54906003)(122000001)(86362001)(55016002)(8936002)(66946007)(7696005)(6506007)(5660300002)(53546011)(76116006)(9686003)(2906002)(52536014)(64756008)(66556008)(91956017)(8676002)(66476007)(33656002)(71200400001)(66446008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?xFBCL7onXljau8boacLYm6n/E+iKoutouM8PLcdDWzq6NaiFwDRDNiszPOB4?=
 =?us-ascii?Q?reblJvhjVJixnYS8j0gc5DwskBYpkdcZBrY9hOrRthHKpFwr85NiSDNyGL6N?=
 =?us-ascii?Q?paJeuVVjAPEhzeZCr22W/4dpRdr+SEaEFwIaMIxsrgHcrq2QQHQV/XOsKnCP?=
 =?us-ascii?Q?jIQ0O6REMxVUCBk+Xv5k1zOGzc+HilWiT3rRsprKY+cUDlO7kjEC+mnsH7v+?=
 =?us-ascii?Q?9leol8nZ2M5g+AqpYPLoNP6I/oaz0CyDbFp/loXlWefN8cvwwo+GnAA0MOfM?=
 =?us-ascii?Q?qNfC4cnxycYWIlExqwK16iTLcjSWkdZAnVHn2z8nuks8Xgj0NppD6+CmGUAL?=
 =?us-ascii?Q?0sJIGagovxRACqwvLtmmtr+ISLnPvsbvm0Nx8v+ICvRpUWcejeZWo4dBAZ9O?=
 =?us-ascii?Q?m3YynBVeiMMRSsg7lVslnkLWHhClSwAWVWuTxk63/dZYyT5FyQROIjkhuCfA?=
 =?us-ascii?Q?Fx68puFGAYdhcvdkBocsn3QkIkKDvg3n35Z693U6Ek4XA8Xb5diuaWyBov+0?=
 =?us-ascii?Q?sP8UFahl/QmNqdUnPYFoFuVh5O/rDnQegQRKGMy+/ISLRAUXfeF0x9D5RGLU?=
 =?us-ascii?Q?ZfcKKK9lMg768Z0JJ0ctHjncoQZEhB69b9n7nWcGWpm1m6bIFDBjHGv5/2rD?=
 =?us-ascii?Q?JT1VHJEtHkDqkcdmhpi+fNrG0EzxkcWCv1XZjpfOX9ulNJmPDLpBQCYlPynN?=
 =?us-ascii?Q?9/j8VdKOMeJjx/wKFmIAjlGPgS/L54FOsLijvgeXunmX/U41S4mjd3p9jz4i?=
 =?us-ascii?Q?NcEGD2UTlUdeCjuHwXTVgcHEMNgDuK+KUQYDpp8UcHk3SZ7zGnANZonhVnFN?=
 =?us-ascii?Q?eJzqRTQvtrhqjJzR25o8r4uBGh7gD0Ph9q+sBdzY/AzhFVWCA00NFk/YA0JX?=
 =?us-ascii?Q?TRmbzOei9HTHWhxz8F5V0BBPl0IP4yVLIscrD44XPRs1w7x7dYKtzRzJTLof?=
 =?us-ascii?Q?WPp9uCucWbKDdYcX/V2042OP+suNCn82g8gV/fWCktXY0a89MASTdr1ef2Y6?=
 =?us-ascii?Q?TJxjMx/IZz8Es5nDwN+ywez8Brqh6LM6gzqfUPdBlDENKI+60HgjO/Uhe7DX?=
 =?us-ascii?Q?hUqeqnpGiS1Uc0m0MEkXiXnaFQ/1pQtuRhfAlyQPJSiZbMC0dmsrKzqMYVj0?=
 =?us-ascii?Q?Zzoz3gfUeFiosVsyNcp1PlYIUNCBxTzUSDuEtCV5vP6ScToC+UFSm99ERfkI?=
 =?us-ascii?Q?h68sjgLnc3gpe4ZeVVVBxzddacG+9vISNlABdHVJsbCyvy5wPRTirgTVWmTy?=
 =?us-ascii?Q?3h465EnJC+ajNgUw+J+jVsix06S10IIETW37ykQc4aeOH/ZeBF7Gop74+o/L?=
 =?us-ascii?Q?s/wLK3BIOcHVHtPgWAZcT9u1NrWW/Xz2w4/ICsFhQONbcw=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB4972.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c7d378-ba80-4161-a3b3-08d90aad9106
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2021 01:24:42.7527 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d7hU16XdL3wJdlkWaI94rjcmApnw76A3SmGm6OSul9fyklR2NdoS82RqUoGh5MgQrbTO7Hj/Reuq3vkzt1VitWe9xtfHIWeL17uUZ/AnSE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6698
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210428_182449_853865_F87AB63B 
X-CRM114-Status: GOOD (  17.23  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Also, subject line should start with "nvme:" and not "nvme-fabrics:"
as this code belongs to nvme/host/core.c and not nvme/host/fabrics.c

On 4/28/21 13:28, Martin Belanger wrote:
> From: Martin Belanger <martin.belanger@dell.com>
>
> Generate uevent on NVMe Async Event Notifications for NS_CHANGED and ANA. Today
> the uevent handler is not capturing on NVME_AER_NOTICE_NS_CHANGED
> (Namespace Changed) and NVME_AER_NOTICE_ANA (Asymmetric Namespace Access).
>
> Signed-off-by: Martin Belanger <Martin_Belanger@dell.com>
>
>
> ---
>  drivers/nvme/host/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 2f45e8fcdd7c..bd37ddb172de 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1115,7 +1115,7 @@ EXPORT_SYMBOL_NS_GPL(nvme_execute_passthru_rq, NVME_TARGET_PASSTHRU);
>
>  /*
>   * Recommended frequency for KATO commands per NVMe 1.4 section 7.12.1:
> - *
> + *

Please don't add extra lines.

>   *   The host should send Keep Alive commands at half of the Keep Alive Timeout
>   *   accounting for transport roundtrip times [..].
>   */
> @@ -4133,6 +4133,7 @@ static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
>  	case NVME_AER_NOTICE_NS_CHANGED:
>  		set_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events);
>  		nvme_queue_scan(ctrl);
> +		ctrl->aen_result = result;
>  		break;
>  	case NVME_AER_NOTICE_FW_ACT_STARTING:
>  		/*
> @@ -4148,6 +4149,7 @@ static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
>  		if (!ctrl->ana_log_buf)
>  			break;
>  		queue_work(nvme_wq, &ctrl->ana_work);
> +		ctrl->aen_result = result;
>  		break;
>  #endif
>  	case NVME_AER_NOTICE_DISC_CHANGED:
> --
> 2.25.1
>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
