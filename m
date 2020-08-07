Return-Path: <SRS0=rw3x=BR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5B9C433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 03:18:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB362221E4
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 03:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q8iu6L9C";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hmms6ZKy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="MV7Dbh8E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB362221E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=XaBOY5y+ZJFAfoaZqEJjMU/D91CNkgLym4vrQ5IqYAM=; b=q8iu6L9CnmYWTYH8hckYF5ztZ
	9mZVKtlpNhcECe4R6IftF1ofBKgWR6lc4XZpdJxCkbCdhs4xcPdINl/UO72Vf4kCMvzWpXL9em3ba
	2Rpdu/MMrq9UFBHYP2/kUfev48EiB95zFEVn5BO4WBwvs12m8mL8PQxcQ7y0xFZcZQudm0RQV6uDI
	i7Ba07gkYi3ATC/PLoWiJtrzIYiFgj1HCWrAsOsVae7Muqaa4v//NibseayM6SWWZp+NlTgP3wBzF
	RKVkpZiFum3K+V6cF0U3IaR6aN0kQ++tGH0+rgDkuvVCwP9yW1JuT0j7EJ7bwoS8BZ7KYeSA6Nkdl
	aE4UkJLPA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3stc-0005JL-N2; Fri, 07 Aug 2020 03:18:16 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3stZ-0005Ig-WA
 for linux-nvme@lists.infradead.org; Fri, 07 Aug 2020 03:18:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1596770306; x=1628306306;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=pGlijipFAWX4BlwcV7SHsCS6hiKDYRePBMHd+F5O/wg=;
 b=hmms6ZKy19RRQwMswu2v9ucXgqh0pbKxXhfimuPI0mfFyYUx9bvwUcWp
 eBbuQnW7d0WdTW4CXL8KWt6tRLZTNStTJv50CNAKrtuIxYDnZgr/jV452
 xQXBkEffhxpKvcgebAL8WqHvHMpxkof/NH2D8wT5D04S1/ZR5qO3oeya9
 /KVz+AuwXrrtHBxNrywJ34GVasOkx6LUCJ48/M8e88PwD5dsC52yYYfGQ
 dK/P16jolQ362k/95V0hRDvmUDDAPIOjTi9igKUvFWjVBpHnwSv23WID1
 jcq+EYhq0Qn/d71UFAlD6XBtVhxmSRi0eAWvC6Gw8hoZ1lTB24wcdtYf7 g==;
IronPort-SDR: qbZ9KPVwLHPXRhOX63eS0CmOiFALsi3gi0IUSoGs04lts7gTgAbTjfAkmohwi/s2k/KXSzNrUl
 H3D44TU43f2AWBEHJgGZv3R0BQTBei1UGRsAYjRZT1nK9jDCy4Ktj60CkwPh1POaA0eovOstI0
 kOab55MfqLhUYM1MIycCwd7gQ+Q4dU6uQDrPq2qlVX5oOKHrEYyjd3aLl1mdnqc6UyM+SDVlDw
 T18xCb++l1SlgMjzgBkpaOQmucrJnie0zp2tVEsBpcVj5HNrPdYl5pqpz6XULzSfw+MwXqj8SC
 Nj8=
X-IronPort-AV: E=Sophos;i="5.75,443,1589212800"; d="scan'208";a="247465883"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
 by ob1.hgst.iphmx.com with ESMTP; 07 Aug 2020 11:18:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=joe5WP2YfnXo95oXInwmX2XCzDAw54tIOWTzHnsDuGQbRWCReP3Ps2Ujk5md1oDBCcmQj1akbJBCRdI8C+YqaPYon4Feg1N4GDnxq0q+ZgQBBt1PVp3dp/Vij5Fz0CliEB97FmauR5dRFYBVV8my+cqJff8hr6zDLIgFhzDfVNYwY1roDKqhutrr3aN+IV+w6UpGuMrlHSY740lJzg9zdGiz7ZCJWXkXGGcG/c3cacae+CIt8RXIQW2IydgOhqU04rWWxrFWvsBm5s5s1WJqGjGH+/+fcS0w2DIFcd+Y3/C8i7+O4+bj6qQIGwVhWPIbPLSxYCNoOX9JW4jQYPgrvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGlijipFAWX4BlwcV7SHsCS6hiKDYRePBMHd+F5O/wg=;
 b=gAXu6Wg4HoZzk71MH2SHTkcqnKAiBImuP1rTteKtRMQv0N/LFbYwoDH7gNn+w78PoQrDWKCv+T4OTx4tal9h1M6C/QdwWyx+7KbxOsUTHkNu1NQIuzw0KXHfF74InTCOupPhCQIK6MOY+FY33ePJ6BV1uYA7MWBpkegDngOkp4TwxTZNGjignfzG7Cf2jXDpQZObYncCiEv9ybAYh8xGy8IGCoUuWDHJWaxdIId/nQdWWni0CTeydBrTVScICCheulNAES/+qVvtsqau6TqBAWIYaiQ7XluXp8BTgVrUZ3DOoCaeRRPe4qfvrcnG2a/HjEjUM2tWDA+WIh6GuJQJKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGlijipFAWX4BlwcV7SHsCS6hiKDYRePBMHd+F5O/wg=;
 b=MV7Dbh8EmRP7bjoNfAUPxJBKSEihEEypzZj6TiKQGiJl7K7zsQUrzZy7GQqIebuwDoT28tEpdoPPHqdBEh/KsSnhb561HJThLpzUfCjYwjXZfEpO6pLuFussYMoVSdTixSxwV8+b9GzcgsJ+OAKcCwsUMYx2E911c2JVs3J4Qo8=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4967.namprd04.prod.outlook.com (2603:10b6:a03:4f::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Fri, 7 Aug
 2020 03:18:10 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3261.019; Fri, 7 Aug 2020
 03:18:10 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH v2 6/7] common/multipath-over-rdma: don't retry module
 unload
Thread-Topic: [PATCH v2 6/7] common/multipath-over-rdma: don't retry module
 unload
Thread-Index: AQHWbCX2Ucn6eo0yREGPkQcFWf6A9w==
Date: Fri, 7 Aug 2020 03:18:09 +0000
Message-ID: <BYAPR04MB49655A5CD40DA1DA6A6D046186490@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200806191518.593880-1-sagi@grimberg.me>
 <20200806191518.593880-7-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 04b08dd9-380f-480d-1f67-08d83a8082ff
x-ms-traffictypediagnostic: BYAPR04MB4967:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4967CC17E569CC4299D83B6F86490@BYAPR04MB4967.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:989;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W3USvLtNQXa7MonD1ttb+gjwPLViiAzNmhjqxliPsOKl2jSwuzaLuu0vTzmhisCccQmMKOTWm3jSJoNy7/y57cxoAQ30MAT1BJZdedmiAHw/gNKxw9nGcgUSV3g+azmiA/Pwneu2skmGgqjk+6xN83GC4eIKJ/10Jr+8Dlm/rIIIZuxgT8d4eLqbk92r73d5jA8GUc1nKbQzvSJPgp8pewwLrN/ljefGZRxDdP7Hgr+Q4ADwNbEtuhvFzokuu9R97zvPTSpclpi/CphQ2DNEHdgLNdvaKwGfZzbEfocD4ockZKj97Z7evSnI+uuzQZKz
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(26005)(33656002)(53546011)(558084003)(6506007)(7696005)(86362001)(71200400001)(54906003)(110136005)(8676002)(478600001)(4326008)(52536014)(2906002)(66476007)(8936002)(316002)(9686003)(186003)(66446008)(66946007)(66556008)(64756008)(5660300002)(55016002)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: D2Dz7P9R6nxdz2oGAdSg392hbJbp4l/KcHIcTaLaWfzH7bywQq59EZ9UyxIMNSmEaYJ+7DhjWhoPlhSYDdZsoGTChAlq9vsHUL/NvKx/WDlUoNT1GRdMlyXfsXP0JJGyELXArgAGrsjLbbfvzjkfv1LRy6yOj8tJHeOaTQTZxwZJ3W2RSbITLXtGyvvXDMdFKyFDd28b6lt1oEcgSJ57Q2oXlqcW7ZKFPzdX/XxBUD57yh8SqasaIL8kAlfBnqw/GLmLyushXllv9VwL4gkVP/PcUOlAjx13EcJei2XaA11nUcxsnCWlQcFgbXKmA3CbCkBwR2Thm5FXzglpXYH4XHNs2KocPbWerbiVyQz9cI+N+OzB+EOyUmg/zs4gUjzLyG1q1G2Y4rKzwevsUXt0oMCUL0lxcRyfHNLeZcTOsRePwT/mMswJDayppcdajNzkfkwXbaENBq8XG4hZxOgKZG3j+XXQr0axfvDh+WPU8xrQSk8jKkvR3f5vEXQ+uyOgfQYnWxi9HNCpsxbzUgOKJuyied+u9FX09Oj9r9hZ2QLqVg3+6yMtdvzPJ/fvT0AgN/T4BXC35Ixj8u9Bj37tDnbgH0aTebvlnhCORSrF3GergshYxriglpxmRfJXesurZUzA34uKcoRVncYw1VVLqQ==
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b08dd9-380f-480d-1f67-08d83a8082ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2020 03:18:09.8649 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VDCJVS50Le1orI88DsQEt6ap3RkhPmfUAfCnI1mz0MLSQZ9NqwzY/2Id2eI+hTPKxD6h1ob8RlViDZKWC8yd4m1JqmT2IkTUMR8aiTeVn6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4967
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_231814_166622_47942173 
X-CRM114-Status: GOOD (  11.51  )
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
Cc: Keith Busch <kbusch@kernel.org>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/6/20 12:15, Sagi Grimberg wrote:
> There is no need to retry module unload for rdma_rxe
> and siw. This also creates a dependency on
> tests/nvmeof/rc which prevents it from using in
> other test subsystems.
> 
> Signed-off-by: Sagi Grimberg<sagi@grimberg.me>

You might want to CC Bart for this patch.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
