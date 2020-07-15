Return-Path: <SRS0=D+H5=A2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E90C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jul 2020 00:47:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E2C120674
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jul 2020 00:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Exg9nN25";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FS4PkGGr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VwnXjP4q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E2C120674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=89xl/y2oKhK6cVM/Ylz5F9HDy3sz8WQsKJmqC9cTVfc=; b=Exg9nN259zdYlmVUGlSSVqLb2
	kyUBq7qHIXZbhxJPMnuaBlzbvM9sfGpVj9lJrjx1wZ9UE9jqnGlPy9Bnqe1TZZLCaBr6BREt0S8sr
	3LPF18SzhZ4oCGN7vFoC1LMDmtzQQ+1MpvZOrmCzX2llCqkAjzRBeG/FguCtCwqKdITarVnqXJIul
	VhBmf1fR61vFZC9rO87JdRMWgITfLBPH3A3YZMXxsMKrJO5DoXfVPAdF+J4FpWRTC+YLuJcntr3Bb
	HySBH+Aff0q3wIi2xaOLkeh8GUuHDbaEgLNbeygHUX7ntG8Ilepvzt/wFgVvT+otbi0cSuxKczp8X
	FKJrtQgvQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jvVaG-00026A-Go; Wed, 15 Jul 2020 00:47:40 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvVaD-00023f-VR
 for linux-nvme@lists.infradead.org; Wed, 15 Jul 2020 00:47:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594774057; x=1626310057;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=7N1/fgtOi37f0myMuzPLNBd9URNelMYzgxzFTKb+3VA=;
 b=FS4PkGGrWrJ7MQBEgafjrTAE7D272GWXSllXucN/e04qSc0jt90FOVxy
 cQ3ylgUUv95Xk9W2+OsJkrPDsk7oFUPKpSyH3OHQ0dp5S8p94xNeZwC09
 eorNlY4DTO2hnsMqTuRLmdyBLhF8bmEDqKAVeL9VtLf7tVTk71CWvr7HL
 UVflkpA1f8Mca1n62RN81Cni3IHfxxG+ktZYhdCz0IrPJu+w3R9osTpcO
 ZCD1E/z64E1Zg2dhaYnATjOlwz9ILWuWYRL9xVIfE0XMK1CRhuB2Lq1Zh
 oEnas/r7QhbLx4Dw0sWhka8udHcqueSnEmn0NClxwjqEPTHZcLI8TLOSL w==;
IronPort-SDR: Ry2wRGmuSVlBxhb7ofRN34Vpu+8/9DzeDwyK2GZWUymw4zwDz6OMSWeGdpVjKNhEq7ym/gPLIS
 qzRPBS14lhc4cEl5YRDGHYlZys/TUsaeTv2ObQf59Ezp7B7Q7ji05FX+uYBKJbIyAvA37nNtM5
 4J3lkFT2sePmho2Ofafzj2FpLQVFGd4Kkw9b30D8KguBJwLHm9YR9dhuUM7l0aQp+OM86Mov5M
 P2NdT7UmXJ3T9Eu7PCPgkO5s4GVWHCN3ekvG1npN3HdNcSTyv2Lw6B+bBnMQSboPpHLBF9UtEI
 HLY=
X-IronPort-AV: E=Sophos;i="5.75,353,1589212800"; d="scan'208";a="142473336"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
 by ob1.hgst.iphmx.com with ESMTP; 15 Jul 2020 08:47:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOiGB8+YR4/AylieoUHXvnDKhacC3964DSbTjUBB31gyzJgW4o9xPvLTKp+3lEAub0u9qwkp/c1hWnnF/P6nwHeubhp6p/y6bn8Eks0K0TlgslMG34PSwdE4Nyc46cpeiHazHhjx41fiLat6y7XFVZl4KTJ6BnZD7OSwbTAMOv+Ha3VU7e6mA2aXDM2A/OTUBqI/GzINQ9m8nwmYripEm96fnpay0mco7Gc2N77WwpxKAi72PUj1qvg8Rl9njPVM7zXLvfa3NAn7vGolxQHD9gfVAkimJpQjUpfBVVi/5tqasAcLKRCQyoyGux/bbuYi/2ZZ7ttv9TW1m9zI2/6PlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8cAQwiJNUlqpz8yeqo3QazyACLp/Tc5L6IualN6WZM=;
 b=NShTmdgfcZzfD1dUBUg6gEvPaZjlxDBA9+uhNBgwshaRJ+z09aitc2KdfWdSj2WP3Xy5tjM7AJ/33e92K9rYOxy+CQXS4gf8Ga36fgTY25TJ3U1158XIbPwczlFdqcz7QazTvyDCS7a6wrK5PboGj92x8CIP/KR4/M2ktNHPtFwsAXUR9BxXozuKfPDBe+KM64hLJvF4eUeA10XUEwhTYheXlj9OC775YLPNyMEkDuykqrVzF6G6p104OsIyhNHzbfpStlfrUAh3bRLS2dNHeeFROUZaB14YN7uMzvXBJEGZ8YHeSCl17Qql7MFevXZStQyAaQeqHUrir8ho8BNfQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8cAQwiJNUlqpz8yeqo3QazyACLp/Tc5L6IualN6WZM=;
 b=VwnXjP4qKqSmsxeVvCT8+3eZuSvRi6yjNv3o42imv5e24v10hCSnctaKfWAM7+KLqjM/HMPTANTWfov/llMF4x+NqGFXJvlzSz2YOWq91YhV2nt4Ru9yBxcIzYj/oUaC8Vtll1/zl9Zxw+dGNRxmzZctRgx9JORVwmLBcEWoSLQ=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5432.namprd04.prod.outlook.com (2603:10b6:a03:d0::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.28; Wed, 15 Jul
 2020 00:47:32 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3195.018; Wed, 15 Jul 2020
 00:47:32 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V3 01/10] xarray: add __xa_load() version
Thread-Topic: [PATCH V3 01/10] xarray: add __xa_load() version
Thread-Index: AQHWWjblgcXXMrtvmECtti2/emdmJA==
Date: Wed, 15 Jul 2020 00:47:32 +0000
Message-ID: <BYAPR04MB49652E0948122DD51EED848F867E0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200714233057.10915-1-chaitanya.kulkarni@wdc.com>
 <20200714233057.10915-2-chaitanya.kulkarni@wdc.com>
 <20200715004643.GA2772284@dhcp-10-100-145-180.wdl.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9457b6f1-2941-4561-b02f-08d82858a8c2
x-ms-traffictypediagnostic: BYAPR04MB5432:
x-microsoft-antispam-prvs: <BYAPR04MB543299357D3F50C09F6AC938867E0@BYAPR04MB5432.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0465429B7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vlzEc89tXXjYBbBM15qIWWbWwkhWf1RQm76CqZLfqTlkeeUsQ1Snd9NuIirKwSUCkHjQUcrN4mZSnJ6RONrZm/GW513duim/H5r0ta6cOij7WArbSRoCLk/+aEtYfcwvnOzp2TnYiWRvpOXsCkG6cA6n8YEbrLKqjTTmsTxdQlUBJ1W3Vch2h9fO7GdjtqQZSWf7LI8VOHZ5VUqSJRDqKKHYJFCzQRIGzdltlBK1h4/CEJuY+PC3m/Oa3vSzSGtWs+HCBrR3DAfIsood7bFNQ50pAMQtpEW3uUF+zpoHgBjKwiLS2+kj/gRZ5tZpscWQIdhiyqHjBanvlBOm8qc1Og==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(39850400004)(346002)(396003)(376002)(478600001)(26005)(8936002)(71200400001)(5660300002)(9686003)(55016002)(4326008)(52536014)(6506007)(186003)(4744005)(53546011)(66556008)(66446008)(7696005)(6916009)(66476007)(33656002)(76116006)(86362001)(2906002)(54906003)(66946007)(64756008)(316002)(8676002)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: CfnkicMPCAXRBEBrydcdKT05Fdg/4Mt6iP4WO5mbPUrmrSM4AQlLdp29u1gPWeJCgGxQmvE7wSN06jnaJLcM4rYbU2jV1cfp0TtRIixnzjy1sOTlZXjYfIhE7sgJW94q//tYIWo37wR+py5YdizSFFikQ60J8D75bi+kxN2i7rkccsiMG/+7yYw6cRd+g+1RN+h+r3y6u8bbDzKgHzANKqwnSBCOijDNDJpT+YLwxfM3XEymg+6FP+m7lpOvZth5irHP1VEzzo79b+/0gFvkhWCpaa8XeOR+6GFwiZKt3GlWPBOVrnSvE+tRsvPzkbGjjX5+IrpLEFGXPsT+C037R3SheyBvMslwuX5n18S6BV0vNys9LA+JCreVcAbjpfKe1dKTmHQIutbjHj73gvVfZiCoWW0t7EN1uWQDxfIni3ihMImYrHokwhmigSV45K55v3JKldHrAjVNIxak6/nCZwpKsvOUjlVOUI5VdqnKaJU=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9457b6f1-2941-4561-b02f-08d82858a8c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2020 00:47:32.4700 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BG9da9C06hi5RVH9G3qyPgu0JEZXPq0i1ag9XfVMnBgHAQf6RIUYmMJt04d61mQIPCmMcfXpuML+sW8algNmeLmxeh1LUaY1fAjmI2tY1bM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5432
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200714_204738_288523_674D65FB 
X-CRM114-Status: GOOD (  11.36  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "willy@infradead.org" <willy@infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 7/14/20 17:46, Keith Busch wrote:
> On Tue, Jul 14, 2020 at 04:30:48PM -0700, Chaitanya Kulkarni wrote:
>> This patch adds a new xarray API __xa_load() that moves xa_load() core
>> to its low level function __xa_load(). Caller is responsible for handling
>> RCU locking. This API is needed for NVMe subsystem so that it can take
>> an advantage of the RCU locking provided by the XAarray for reference
>> counting.
> I asked last time: why is this necessary? All the docs say you can nest
> RCU read locks so what is wrong with doing the following with existing
> xa_load()?
> 
> 	rcu_read_lock()
> 	xa_load(..)
> 	do_something(..)
> 	rcu_read_unlock()
> 
> If there's nothing wrong with the above, then we shouldn't need to
> introduce a new API.
> 

I see, I'll send V4 with that.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
