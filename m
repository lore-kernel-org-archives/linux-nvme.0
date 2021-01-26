Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C2FC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 02:05:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A42232075B
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 02:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A42232075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=BKObetzKSom/MsCVKYstfi6JKdIDgQ06PkjtKV8NOrg=; b=Vpw8GVooeA7dAQsuqGfxHU1Wc
	oS6tkVXDE6Sg+FMvFv2kLKgGjyIQnm0aA7I0jftjSxmrBYe2xQbHdN8+R225OL548NDBEgz7lsYX3
	Hi6tUHLTYCn/BRQI2goLzJI8mF9K4UZoNXH1dNCtOpmx/0UnUjLTiOwSrealrhwNNT5J6M3DFFggO
	pMF0nSLnDZWCajYnKDNO/8DpA1pLOqEJUPj5nIyAPQcyCTn8mMfvOn3ulpbbHJV55+rF9Et+rS0Xr
	Z/cjNS2EjWBLX8LxBKmMH+awKR+bXeE9RE0XXqi9MEST1lP+01O+fLSHAFXXFwRw4VGhs+Ngjd7eN
	ZVyG6/Uvw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4Dio-0002wL-G0; Tue, 26 Jan 2021 02:04:46 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4Dim-0002vo-8l
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 02:04:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1611626684; x=1643162684;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=C/pUYVwWnoCAyFO2EaDiHmS+Q47GXMfHWUGbDdKgs0U=;
 b=H21hTlIKIYBSMFWsXxiTJPFRk5h/XkAuaVYyY02XLrPbX3YjoIn4fCMh
 v6Qo4sp4YwRZ+LDnJYrocLJTYREalj+Bn+DBzelnoEDuEiLtyAWG8nbzO
 6zBKKzGJAW4GFQQlPk4DHIdJxwU8VO2P3jv/GRminJWAPga8ANRYDkzgq
 gj3poKuvz0hmAK1+ILZXAE8pFA7eIIVq/KxcP2tq8GRoc199xb/I4IH3V
 zhesZ2O/zGn308YHtoc5SI6ZjORnRWwGHqohRyDvo/B/2BNSL8zRfTNsK
 UWBZ8MOp5RIcqpVXxKDpAT5WaNMZWhv6Sew9Kiiy+ZxMWAgHEn5COeM7e A==;
IronPort-SDR: KxIc+5LFir42WQmfiT7ka0choAS3ENJQQmL8zX6OwGbLU8b6gMLx5O9maTPx7kUO5Q3LwPJALr
 0g7o539QFqDc/2HhpKJ/G8qU1bcvjKE5sq5X6AoAhHBSb5GBLO6+m/Nq7nNmgc0GrXdYR/bU/I
 Ji2tB8kEGsq6hFA8MBNB57OXLl6PSmOXUzH1vfOrU7JgebKo15m1hzqcJ2XhjP5Sp3XTymSJj4
 3ZtzMHj737s2Np7Jc1stlWYTJrg9dtqJWVIulUEKZXej/sPHV4kFqTxL0TV9dQN67Mq0gHn7GX
 rSw=
X-IronPort-AV: E=Sophos;i="5.79,375,1602518400"; d="scan'208";a="162751608"
Received: from mail-bn8nam11lp2173.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.173])
 by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2021 10:04:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WELgbeJpDZ/yrhx8xC0ldAiv9lbohoEYl0Ds37aMwAzm0QbPNLmS32hiFCNDmiB4af5SCiL1b0w8jw+jSvLvyJAQe39AZ4m4/uehoYEbbRVj5qnJEnVo3f3m/jSU7MZgtaCPt1qy1RfEa7KtmwR1jS0+6tg5XKZimc3GUHK9ARbBH+wBdtoKESOw1ut1MR4k2aER+7piWuEWFNlOAzaOCgxSonn84u3XNLJAln+IypVe+GnM/flVWw4+4qQsNuXLEwAA7WMPNRHNl7aNe95uMgT/Tb0B9OUqO3WOPLfbLI5vfRdpSYpkPx2kEMUNKGqaJf4Fg+STIOQouZ8OnSuwgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/pUYVwWnoCAyFO2EaDiHmS+Q47GXMfHWUGbDdKgs0U=;
 b=f54CvKtaPNasRCuORbMVvUJE+QWMRyaFCTOVIGgh3BfQo0LTtHlv9j9Cb5+w8z7jfVp77qBWc2BG4HpHpm4y/RyIx8nFi7Lgq642rY1tuieod/UUulap/6ad9fmW71cX+s6wJCdWVDPXd3VfLzOzZjhM9uFbIZzW7YNjkZkGHQxU4DmGrlaQ8nkJUvvn3XBpA0saOL9mEH8PB8H5as0Aq97kblibCdn9WDVHj0yO5/3lXLkBAN1miHXsqygUYrY7cGubQcRPP02ZEEpDNVMJ43b4nmVeh+NZdohkIWZ42fPU5sBnw5JhNIL68Jxu2y+AyUPjWgYOwH1P/qdSX7LnYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/pUYVwWnoCAyFO2EaDiHmS+Q47GXMfHWUGbDdKgs0U=;
 b=T3mECumHaDzfgKm51FO4uNU07DW3rg2oq0M6kr3DOai06bQgK5dn6i8WHxeRhEHqJzf5gTLHGtKIW46eh3MsV8bwJOV31jnFTArIGSND9O2Q2Cl+79tPtZ6l8z2dGk/Ez+sPIS5qyhjMDD4Hm09CQJmkYCv2VTX8S0eYFPI28M8=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4758.namprd04.prod.outlook.com (2603:10b6:a03:11::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Tue, 26 Jan
 2021 02:04:38 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3784.016; Tue, 26 Jan 2021
 02:04:38 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "chapman6235@comcast.net" <chapman6235@comcast.net>, Niklas Cassel
 <Niklas.Cassel@wdc.com>
Subject: Re: Problem with SPCC 256GB NVMe 1.3 drive - refcount_t: underflow;
 use-after-free.
Thread-Topic: Problem with SPCC 256GB NVMe 1.3 drive - refcount_t: underflow; 
 use-after-free.
Thread-Index: AQHW7QO5MtNnJXjl5ka4VClzrgzGFg==
Date: Tue, 26 Jan 2021 02:04:38 +0000
Message-ID: <BYAPR04MB49655D68A8FD54E1BD6E181286BC9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <f50bc59c-db11-bb44-55be-7b9db1119872@comcast.net>
 <BYAPR04MB49659C0F0F0E11D166B31E0586A40@BYAPR04MB4965.namprd04.prod.outlook.com>
 <a4c75497-d170-1e0f-8608-282231ff3a8e@comcast.net>
 <BYAPR04MB496542BEF594F0380F7D41CF86A20@BYAPR04MB4965.namprd04.prod.outlook.com>
 <df46d7ce-ce70-1f43-0efd-7153761bcff0@comcast.net>
 <20210121124459.GA156577@localhost.localdomain>
 <c48abecf-8e4f-b76a-c751-1a0d239c99b3@comcast.net>
 <BYAPR04MB4965404638B4C43DBA577D1686A00@BYAPR04MB4965.namprd04.prod.outlook.com>
 <BYAPR04MB4965342B52D5C3C6D8A7892D86A00@BYAPR04MB4965.namprd04.prod.outlook.com>
 <23f49172-5d0e-618a-199d-d568f695dc30@comcast.net>
 <20210125081654.GA226984@localhost.localdomain>
 <6709E718-ABD5-4B69-B4E7-883C4E4CD178@wdc.com>
 <05db52bd-7484-56f1-510f-b1bd3808d385@comcast.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: comcast.net; dkim=none (message not signed)
 header.d=none;comcast.net; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: abbe2a5b-7a7c-48a8-ce41-08d8c19ebc5d
x-ms-traffictypediagnostic: BYAPR04MB4758:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB47582085437F9CA86571EEC986BC9@BYAPR04MB4758.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GcHEMDEKhZxtT4j48GzohD/YbTtgKYHIK3DJ8fE5h6sqvsmKq1zsN6NQrq68SsjhTFj8HDxbH6ozau2Cr7gX6/v754uHNBEOU2Voi0FJi/XWOKd3ARDug6jsWe59z4/ixznluEWolu6zNmsJ0ikraUVVjvziJxkOWb1gwsopY1KAxWRZcOvwg0UCT8B6OjRXrVcWgXvpU5GLZdWsJDgKF8eyhyIhMTxCxBjt6r7nw5kLqLVuna9P/YEocm4D4DDm/qxiZ7nQWe4T1UUAnYThycDjkoE+b15SfhIguaLxMc/0HyB5uAJPruXRRZQOwrNm4oSmBtdU1x+hLsGrkJLQqAxxXXKEBx0DYs9xjokj21PXt1gqS0sQwB1GaTVZcUJ5OhmtbADr4ux7XBJKXuCX2Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(5660300002)(6506007)(53546011)(4326008)(8676002)(186003)(52536014)(26005)(478600001)(83380400001)(558084003)(33656002)(7696005)(9686003)(71200400001)(55016002)(110136005)(66446008)(66946007)(316002)(8936002)(76116006)(64756008)(66556008)(86362001)(6636002)(2906002)(66476007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?s7tF5FZX4ONTrN8jfLojJwUJRm/g+C1dy8tqcSkW59FiDbk0pddmID8zj82S?=
 =?us-ascii?Q?OumuQ+rqA0YQXfV7KqSC6twStYF0g/NtCRePmCnXZ0C+32VBl4I24uRaaNEN?=
 =?us-ascii?Q?vZ3F9U0LfolDQpWty/taT9so+SaOLU7gLiXYZ9WsHHZEVkYqcacdgucGImZE?=
 =?us-ascii?Q?fVuYic+osrlqaDMl8HIKiWKotLNpTMWisygwXvBT5Rph/AkBrmzTS5EtQp7Z?=
 =?us-ascii?Q?PT/P0AUUF8wf6ukoqvedFBInj9Be/9OD0Yw7WkotDQ9qUh8y/hkFztWbdHJA?=
 =?us-ascii?Q?Bgl5AJbC2UlaRlTOfSyXq92cVtZPymTkeQE+N73kttUMVbnPxKsAz22Euk69?=
 =?us-ascii?Q?fWkj2p1CImfIWrJl6Tpsd8BE2YFC0+xhzC5oGLfFw1STsERMdnGyTbV6myNn?=
 =?us-ascii?Q?c8dNxEwxKnNZP1hsY9eIdEYnASv23SJGMJt3A0X7QGQL243Nn/Wt1Wtyfz+J?=
 =?us-ascii?Q?MIZlbuNEOKt1LhkXMl1r6SHTtSv7FO/l/KUnKoyHm1tbaiOg1UpaHjAxW7S4?=
 =?us-ascii?Q?Igh+4mpvM+kW59bYnySbukEq2kBLfyvGpjSR9aaus6I+IPgOcdBPA17VHAVk?=
 =?us-ascii?Q?vI1miUMgUK7GgXmRB/ZScSnbOgbrJ8ov+kcMBxTd7hF6VpV4EaBWYwkvtj+o?=
 =?us-ascii?Q?VdgIjzb9oLizx54TMXyWlzv89VZvNBcHx5JzX03fyFoAi7BZeyPzCSyLsev5?=
 =?us-ascii?Q?dlz2Is/Xf3T1WDoGgL2giJT6RTXPBXIH0Sj96VAvAVWmsLM8NTs2LvjeHKfa?=
 =?us-ascii?Q?6VRRQAAc4K19YVDkHX0vDQMOyZys1BCPPQa3xuuvXUPCkowz3AsAFUClbVBk?=
 =?us-ascii?Q?Fa9LGAeTi58MH/9+f6CtCu31fthmlO073p7qTA4p4EYjIDSWNZ2Q6bqugUGf?=
 =?us-ascii?Q?Dv5mrKCfPhRi6nUjA5OMtqm1d2MQsBuTtfq8027UG2od9XBZlFzWDOD38C2b?=
 =?us-ascii?Q?sLJ+A6UD6V3CocFfOTeFs8b/BShHv2qUdbRvafJH/8aCJ3yPjWZd/GVQqKUa?=
 =?us-ascii?Q?UkkMXMsmRBWt0Q1hIFX/+Wk2aXWJOHOFFEwVLI4ttxCJFKU8297JvX6kKlUm?=
 =?us-ascii?Q?bR+43V1h43r4UaR2+ivYZzskN3QI9w=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abbe2a5b-7a7c-48a8-ce41-08d8c19ebc5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 02:04:38.0953 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w0JwwYo+ZX0NGLRGKGQs+yuKOhhrZ74Ng47p0giHBazWqJBel5aHoL66IgGHDBM/Y8jVHMvlx3hbmfx8+EwQQvzn2K29jfKIN5T3ru2VZFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4758
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210125_210444_539508_BA6ADE2C 
X-CRM114-Status: GOOD (  10.70  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/25/21 18:03, Bradley Chapman wrote:
> As Chaitanya pointed out, I did in fact re-test with the correct patch 
> and everything worked flawlessly. I have sent the corrected patches to 
> Chaitanya directly.
>
> Brad
>
Thanks for confirming that, I'll send a patch with your tested by tag.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
