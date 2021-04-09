Return-Path: <SRS0=kA4j=JG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6CAC433B4
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 02:50:16 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 958B061008
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 02:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 958B061008
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=T2147zJwUQTKf5GR0pcw/TlbL8IGo/Oll7lQ2mxkyWo=; b=bcGBD2QFKQBRlY1O0TIyRGELv
	J7eTYtakmSZkJyVj+gLJAh9g/gBLNfgmbu1uQ8udL8KQ1jXG/f24pOioKJqlBqXDDH7leVpzBFh1x
	n7WeJDWInyPmtdDWt8EZ19eaLLuFlghyS7dAO2V3YzadfE8yvljJQoNd6T07lW8HemCh1qSCnAEhq
	brWRAu4vnYR/4xpOq8FbULBhdrpDQA0mEu+GwdIVt58RdMWwwRi/IWjurA1rW/CpyC2W0GRvQMydL
	Du8B94tVkOaSwx75QttChBePfimcl7QdU/6l4CLfJPrft3lLh9/Z3BlWkaMRYulBW3kYfx06mNEZz
	bu+YJhCLw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUhDX-009lLm-95; Fri, 09 Apr 2021 02:49:55 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUhDP-009lJt-H6
 for linux-nvme@lists.infradead.org; Fri, 09 Apr 2021 02:49:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1617936587; x=1649472587;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=i/t2oSUCWRYKJvi6c46BsDfpDwnfzlI7aFfAS4Ioxf8=;
 b=d0DNSIeV0bvJHedy2y/LF1deMOs5gqlo2KJTmnHjF20PxizHjPf/RGu/
 bXkgLFCR1w+BRM6jCmL4ZPOPhbLBPUzaOWQR+y00AiK7U8rKCOG5G/sVd
 cotV0a6r6C85oVohoLs7cX/s0Fo7hLKvRRzVvlem4JvZEGAneuayahsE3
 OQFYKO6oI7faI+XmJpW3+lGtsBpRTTdGpYrV9kaWZzFSc1dQvAeBmx2bR
 Izc9zdZn3APPoc5H9tvEapkz6+nv7GwCZNFBm9EQ2KtAoUsKBrJIcSwsc
 5+Z668uxhKykY49yCHFJFhXYbMQjdvKVVOsIJLguVF8RWXeMvPU3huRp0 w==;
IronPort-SDR: HUAWI1iWG1ioG8pXqd8S/I250Ligwsl6lqnvbbP/rguBbm5fr7Ab2QTtISbXhX2M+bYwQ/xAc8
 2ZhrVhd6P4MXAE6gDV1kVguEI5HCeLAIzQhp/qugvY649VzVpBV/G9mPo4heWdEfBA5jJRhbPL
 ibCLnoXgf3i2jCeuk7Dd93idJm+HlH2i1LNTDkKZwqroFQM+4QeVj+mj58+tuKRr8Mn4OH/IIh
 qDzkkqjsgr2tgjzbYHMiU43UALPU3A0XL+Ww8+DoIA6w85TnfqtCPrHYtGhcK02Udn8SJxI1qs
 KCs=
X-IronPort-AV: E=Sophos;i="5.82,208,1613404800"; d="scan'208";a="163963767"
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
 by ob1.hgst.iphmx.com with ESMTP; 09 Apr 2021 10:48:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOyxA3KQrOGXNYBvD1DXU80yr7Mr5Jv6cGWtYFs1RCzAoFK/G8JQNmpmJtaMvBTh8bBVYb9CtPmy+ibDztzef9PgXBU+eHJyiLiQvzEkrA0sMAvUlNQfIMHzPvl95bByHOaYBZE8WJ06t8rY6qX86Ymn37NVnBGDp+BqRDFaE1rfwAektnL5Ug9BKzb69bws3e3u3mOIp1LHyhLHb29/eHGh0akBivdMJvMbeY8yKn2j+1ubPBiUA+zUWIkiu+RQRMxh9mTJ6ofq2orsST5rvSFNVQocdDCP0/P7Yang6uE9cV6l/9R4mJ1ogq2sUKpGSYUmiWp55DqkogpSHZihcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/t2oSUCWRYKJvi6c46BsDfpDwnfzlI7aFfAS4Ioxf8=;
 b=Z22nIOh2zdn9zRm9rgNpEgpfDKEMy/+NIJ7wBe+YGBEe61oFZXlvv7H502z0MLc4tHrf3GZYiq2WpcEeh1PTgrvaSDtVoANwBEFMSnxQ133p1o9bKntQGTmS4AcST9ak3Afw5rE/wHe9D/6I4+lQdJMkbDqfwWYRA0OQV3diXo/KvAiVQJwqFfsvgck1nY4VkrEwmNPjdWmW6JTe2hVgGjbtXzP1GV4esii9w70PmO0MB55GSQGweZn/03PeANvbqkqT90DYLY9K6RvaNo70k5GT6lOgJqST38MuuXtUsNo4eUot5f9gTO6BudyeWF6KZIxfuhdjSxxs7FPSP6qCjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/t2oSUCWRYKJvi6c46BsDfpDwnfzlI7aFfAS4Ioxf8=;
 b=mPI+JeNvD71/X7i4Z+4wIBZjJP+39ML8eo4zsWacX5bliOpqIQCSBAmr4VWzvjA3ny9Q3/S9LqTYpTpwAAoszq62S4WBH5vEnuRSjzIp5RUMRaLM67/6aQNYd2hseXz1MkHfK2ZFyspP9xYfqSQTbiBltCWDtoqa7hVZXSd3qQc=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7437.namprd04.prod.outlook.com (2603:10b6:a03:299::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Fri, 9 Apr
 2021 02:47:41 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4020.018; Fri, 9 Apr 2021
 02:47:41 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Minwoo Im <minwoo.im.dev@gmail.com>, Keith
 Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
CC: Kanchan Joshi <joshiiitr@gmail.com>, Javier Gonz??lez
 <javier.gonz@samsung.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 10/13] nvme: move nvme_ns_head_ops to multipath.c
Thread-Topic: [PATCH 10/13] nvme: move nvme_ns_head_ops to multipath.c
Thread-Index: AQHXLHOSiSZDXM8aNE6KrlxSytMf6A==
Date: Fri, 9 Apr 2021 02:47:41 +0000
Message-ID: <BYAPR04MB4965AA2F2968A10622FF09FC86739@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210408120842.1450092-1-hch@lst.de>
 <20210408120842.1450092-11-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c6228e2-6722-415a-4305-08d8fb01d830
x-ms-traffictypediagnostic: SJ0PR04MB7437:
x-microsoft-antispam-prvs: <SJ0PR04MB74372037A565E9313CCDA7A186739@SJ0PR04MB7437.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:635;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U7npDyyq2MesSy3FzYRj/UVzjEd7qJmU9Nkk2vkhy8ny4GrZuf0cIFC4L4zu23kasi8fGyHIku0SCee2fR3zlTO9VFZitdwP6bG5zPFH2LTkq/MIVF89oLRwO+saSHGLZzk3FTccKTBp3UvIxpyWCQpQJy67pmttVD+C5okLfGwvalNA/Ruise3G0Gst6ylByLqVlyCmU9jaaNyraGBH6mDL1RnGAPYMqZRqjsvZqojjZPfOoKSB2AIPszSmOHuW7u7MJ5ccWEplizZDpUAWNJITB6yDu1HUlFLRRjeWhyDnzhTDD1wvWTfYuLR1s8Aq19S2iz799B+IQLdjYsGDJaEn8RH7er+Q3ySZ9bJQf5tbBJTnNZe3K9YIrcIALnxvuIERPoHg2a1J6vgmY9cdrC/BS4EoLbtJwR/DQGeWlHVGqEDIVWWGkZZlqtA2AbFBtR1PzlfnXi2tCTV5d05r7C3LSGBU71mdYM71eja965kymqwIkuEhyww2ioFNRdIWCACHXhiuQ49h0RbPz0CQ/ArKjVeiiURZVBuba5xeqhqGj3jhPKMS+mPUEts2vIJ+/igdQPUlN/7XrC42LQqwjaZLxCe5Wp4+gu56RNQ0j51sXV4v44k7yPh+7+lhzA1q8RVUvA3ok/AKOfNnrC3nXjfpoSML79TvZkDDeCG7kJg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(83380400001)(2906002)(52536014)(478600001)(53546011)(6506007)(54906003)(186003)(66476007)(66446008)(64756008)(110136005)(66556008)(86362001)(66946007)(76116006)(8676002)(71200400001)(8936002)(4326008)(9686003)(33656002)(55016002)(38100700001)(7696005)(558084003)(316002)(26005)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?NBoopnxiH01MLUYCbI6lE1eOhvjOXPCNWUPvb6FIQWkDsBSC7q/90uIRtw8a?=
 =?us-ascii?Q?ta2Ckx2aZHGsm+Fdaza/Io9QsBqYPtqFTr3gCHY0ESvYDj9fGxHB3DUSWNIM?=
 =?us-ascii?Q?ZUoiF26AqYpxUrUdh25FNm2c297WOaWuBya9nZvEOF9A5qxeV7LH8kyW/trh?=
 =?us-ascii?Q?rgSgsFKkoBhzeBOyyCnDl5m+kSR/7wYqA9yJ1vmYU2xK4CKui/bhaWSb0PvE?=
 =?us-ascii?Q?+aEP7g+skx3wt97bfELAdCcjRUpJWf2pyTLFj36YCuTQsrclFxMQuh3e+aU8?=
 =?us-ascii?Q?kuGwJsjMAoLgqVns6PQDZ4YkwTtkfYhFGZsoFrRknENElbXl3r/ed2QdiPVc?=
 =?us-ascii?Q?yNVxbX+KqFBul3Xl4fTmE4rBnZHJGJYWu/NbhOUb3nBJDRgV/ERjEL+qN42t?=
 =?us-ascii?Q?lD0oMOD1Se49cYGVPY1dNfcOKy3moESVUclNwlgkrFd9Rjxksq+9SyZthY/n?=
 =?us-ascii?Q?MFOuwixoeSZPnJbHqNoqX7B+RSc4P7KHNOIowdlOYPkdLIRUmmUSPcUlxsmC?=
 =?us-ascii?Q?dQdQ60i1Gw56vI6ztMbDzXiOukrrhylAzsv00+5heNYz/eM+sK7a2dA64D5Z?=
 =?us-ascii?Q?UjvnJNcuJ/unXRSxktbcEZgtzBjiBIKslVUi8QcvfxoBVVfYX1zkskkEV8qP?=
 =?us-ascii?Q?feP/uL3Mdhapz5PHuUg6mM8SDMaXvyqNyox9K/n2iN2lGyY8hYPWdi95ynco?=
 =?us-ascii?Q?B6tArk68FD6uZ5jXJuPPlLDm2eOGOxkB3csa4ipuAEmbl17OV2VVn6bZACNe?=
 =?us-ascii?Q?46U31SNp7XJrkiFX4jtP3fYpPto20o7Bu4DsXFZ5ARyWtaWlIEFPM1njc16u?=
 =?us-ascii?Q?k1RuK28U52A0EzpQIbFFfrtrwOBCnZM3PWWTVtzDvtwo5WvWbcsiMcAhaAuZ?=
 =?us-ascii?Q?Ci26qSO0nI7d15rATirEbhJ9YJu7aQ/cE54KSHFx5iB+Cu37JTJA1AAnyl5p?=
 =?us-ascii?Q?vHFd/mtRXGhujM/pDBv5qdr5PJRnViOb2PpoktSZrDRxQ7+8qLzmloIPAmPM?=
 =?us-ascii?Q?uJc0S/q7iFVRuO4REkadJDZDopbDVPqWCLIEE+BoUDUsmrMmBFU1a9UCOWde?=
 =?us-ascii?Q?LWTwDC9B6mlL2OMWSD0EDRUsr8e713heiOOZVJg+K1d2nbvsfoSMLdRhCPDX?=
 =?us-ascii?Q?PM+iJdVAD0ilCv9UztBnUAOVG7FZYbd615wPizJ+Q8EEXXvNvdKr7+9eyR6W?=
 =?us-ascii?Q?k/zVvjC7kVVM0YQDAuxff5aEpBTKpl/Po9CEc65ZjiFC+Z4J2EcLDmawxkXz?=
 =?us-ascii?Q?U9h1m79/1QOwvsooGR2rG0lizU9k0dOmEX7gvj2uE0+sS10FQmQ1n5/BqRpV?=
 =?us-ascii?Q?rfVUg8Mh7Czx9+6abmSyvBrX4GGBhbLH7kHqkQXPoA4owg=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6228e2-6722-415a-4305-08d8fb01d830
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2021 02:47:41.1177 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xYTbEI3vYyN5UgxWHch4oVNv71tZRzC6V+h0iLZ3+Fhj8KDtHTJ6OYaVoxdH88wAgHbNpuWWHjJFIzYNEWk//NkeuUI1GVUgYyrqo7LZV3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7437
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210409_034948_429029_468A758C 
X-CRM114-Status: GOOD (  10.20  )
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

On 4/8/21 05:34, Christoph Hellwig wrote:
> Move the multipath block_device_operations to multipath.c, where they
> belong.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
