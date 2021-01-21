Return-Path: <SRS0=kOig=GY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49E7C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 12:45:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3833423A1C
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 12:45:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3833423A1C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9nXUr7bNGoQD5/0YQ0lLhWKanxQ6xJ5N2/V9h6ItAQM=; b=cUP2gZWvVndXBLDiZyqFJLW20
	VSs7MT8QMWgmYx+YvzgP6T45Xu1OyFmDSAxsD831cUDxIzdNXvSJhZJCQPO2lqBWL+BZC1fIQ7Da0
	0IbwVmBtjU7v2+z95AxIDBK9RsEnUN1nidNEcm39UZjqfVY78HbSyUWi6YuCrVJhdbCrvnl+6pFlg
	t2ZlrFnuMhXm4Xwil5ypc1SKUaPF8I02UmDTXu9D2Q2SqhDgq32T2qASBtBOxXUgbiC3zOecUngZr
	PNs1lqiGbwWoah1IO23JVoLEq//bY9OJ3T5ZZTShm+iSWNGnAVRwXo05h63dTaAv2+ky6x1DnF74M
	z1yW+iO2Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2ZKo-00012K-D7; Thu, 21 Jan 2021 12:45:10 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2ZKk-0000zz-CX
 for linux-nvme@lists.infradead.org; Thu, 21 Jan 2021 12:45:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1611233106; x=1642769106;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=AsD3d44anurfxvr5a1kUFxBEmwb3i/9ECWLHx30vIeE=;
 b=kuMLT42y70rRnz7h3Wq8vHD/0K3zrUilbKZtXvR4gtkIds6OFHt2iF7Q
 bD4GEdT2Djxf3p5VTBh0ehjdxYA/toLDSgRZwWqjR4xzt8HkfNsuTupAU
 rTe0TgNkC1VxMWBxFRQEXxG89ASL4blpepkbIE+j1+3UHht4jGYVCMqGN
 ivgIAH42UzI4uqLckA3Qn5R8l5OuwwOXnAobsPxRwu/LJZ80oREoCh+QO
 yr6WV4S02kFS5hCgOvUaVakiyw6QmhRyOQwZfU/pxK49YcK6tBsO9n94a
 K3OcPftwcNFF5rW+TmaGToubhgFk78mzC+1XxlwgNCtrIYWd9dsJoLTgf A==;
IronPort-SDR: zoHNUuGbOE/A/vPr6aqA1F96dPKQOYJWGWKXUHWrxrZATgYI5b06Fm4tpRjCMjzcGITAWxiA+M
 Y0JO3eZOzr7wf3fFlxD19+zRJljZXLRo/v/gmeKS7A7RpmP9pl4zWuiSvW1xc5iQZksY3vvShZ
 XmAs/Mo8CMDFEKIO/jA8R65EMmtiM0y4xLxDbQdNvNdZaQzNFw8XLfozZUSKSkVWe8GLPR2XJL
 Goa/usUT5VmmWiGxhhfYtedEvSVRhf3olucb1nh0szixm2O9SHNWyUnmiLr7maGXWbCYWe+AcD
 fZ0=
X-IronPort-AV: E=Sophos;i="5.79,363,1602518400"; d="scan'208";a="157985152"
Received: from mail-bn8nam11lp2174.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.174])
 by ob1.hgst.iphmx.com with ESMTP; 21 Jan 2021 20:45:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEVgOiseV2ElWR/sUf2IMElPe/UCCvcOF26jp+vLIlUpktkpt/o50vVcceEBfM+nNuaSKS4mE3mnFIPJ5SK4gXXUa1bsWcCQUbb97mXyzf+33eRFHMqCRr/5aRHlvk+GPlJhtkB/BuwaDNZFXx07csaxJQnKry5wLvBXaZGk9rFEiXSFHhUAamK+qPB0WtfE8Q+dL/pkfmyPOoaMtAju2Lrqr2ZCPiagwsg18yYE/u9ibzvGqWp0NajdYLzZlZMKRsIN3+MiuLXXAqpjkHsAXdpC08QSIAFwlOwxBjljftpzwPRV0fVXjNagaj/4RxJl2V7TflTmF7unfD2EbICpsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsD3d44anurfxvr5a1kUFxBEmwb3i/9ECWLHx30vIeE=;
 b=YWtb1Wh9LzM+Z5SIP96xc1ykwmUcCp0tqyHCRQIEQZfKCYShlE9/hlRdTkZh9H1DIxwCxPQJ26kN0FyaTscB4ANB8qlWcnU3m0cNhILKNV5d29QKVn3s2qwZ7L4ZaYuRSPp0TjQsRuYdBwRg2fBmYiTYAManzen8OnMtDR+FGjSvVboDTWJ4e6jcXWrwBVeoNzpbo/J7hTU/MaplnnLivkz3Mbv6x2QYvjA4RSLD1URJiqn970guFm4p7zPnv+Lsf7wZyko37ohkgbwkBz3OpgxwDrM5KqUV0FpGM9WG3dsIs64Z6PnUaNGjkg7W5L3uRvr0/gNnnALThlv8VqQrLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsD3d44anurfxvr5a1kUFxBEmwb3i/9ECWLHx30vIeE=;
 b=FSN+4DLIPmkC6DPyc2zwjbmE2DZHt+B7WN5w7ajYZJD638x4X5ZyZClkLpdni8W8guWVCybLxk+0vRUlx2mW3zMdJLAlJA4DUcT22bIpu+nHg8voKuBPl7Zq1wFvg8Bi/mk7MHZTdeFzAVs2T18UCVbSeMMd8AItZi0vXF20oyU=
Received: from DM5PR04MB0684.namprd04.prod.outlook.com (2603:10b6:3:f3::20) by
 DM6PR04MB6363.namprd04.prod.outlook.com (2603:10b6:5:1f1::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.12; Thu, 21 Jan 2021 12:45:00 +0000
Received: from DM5PR04MB0684.namprd04.prod.outlook.com
 ([fe80::11d3:8b30:e11f:87e5]) by DM5PR04MB0684.namprd04.prod.outlook.com
 ([fe80::11d3:8b30:e11f:87e5%9]) with mapi id 15.20.3784.011; Thu, 21 Jan 2021
 12:45:00 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Bradley Chapman <chapman6235@comcast.net>
Subject: Re: Problem with SPCC 256GB NVMe 1.3 drive - refcount_t: underflow;
 use-after-free.
Thread-Topic: Problem with SPCC 256GB NVMe 1.3 drive - refcount_t: underflow; 
 use-after-free.
Thread-Index: AQHW7/M76C/jHanXd06518y48t9PXA==
Date: Thu, 21 Jan 2021 12:45:00 +0000
Message-ID: <20210121124459.GA156577@localhost.localdomain>
References: <f50bc59c-db11-bb44-55be-7b9db1119872@comcast.net>
 <BYAPR04MB49659C0F0F0E11D166B31E0586A40@BYAPR04MB4965.namprd04.prod.outlook.com>
 <a4c75497-d170-1e0f-8608-282231ff3a8e@comcast.net>
 <BYAPR04MB496542BEF594F0380F7D41CF86A20@BYAPR04MB4965.namprd04.prod.outlook.com>
 <df46d7ce-ce70-1f43-0efd-7153761bcff0@comcast.net>
In-Reply-To: <df46d7ce-ce70-1f43-0efd-7153761bcff0@comcast.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: comcast.net; dkim=none (message not signed)
 header.d=none;comcast.net; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 51927a89-83f7-416b-d87d-08d8be0a5dce
x-ms-traffictypediagnostic: DM6PR04MB6363:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB6363E03EF18BD38C9810017CF2A19@DM6PR04MB6363.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +NuWuip07OX3Mi8H6gYU6o4Iqoxxys9FWY+cMn0S8vu7o6MSGzMfDt3UrvI3/t8huI/xLLlBprlYJoOCKYrV7Mprvd0BkjQuyLAsCw2Csxyegc525nZ5hmYJYNxQNY22dJgaJ20UOf8w5ksmmMHkW6SZfsvKz/IyfyKei3nqICUFb5Zi68abenIjMi6vTET+HZchhUR8HEuB214aHhZU9b0VSvBQxRcqzPTkKXZ+n3UY/H8sZUrz+MHgDe623yFgiTbJpmIPN2PL8bWAssuEDvEPTMoquJn8ULF8Viq8NDu68P2tR0lSZ3DSSb7VDKidsg1dFApYlIcwseXtYLDBvwTLu3q/aw7sJ0rCv35UG4XLSkT/lINu2FAXMorgv0sXOb/fkQT+Rj/VePRzeJ2QcUgfeHBrH8YdbpXOurHmf4HO8qW6nEIyFnUqI6UMreqKlE+iY2YUXb/fqEooBwOBcQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR04MB0684.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(6512007)(71200400001)(9686003)(6486002)(83380400001)(316002)(54906003)(966005)(4326008)(66556008)(478600001)(1076003)(33656002)(5660300002)(66476007)(64756008)(76116006)(6916009)(6506007)(26005)(2906002)(66946007)(8676002)(91956017)(186003)(86362001)(66446008)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?B7+/Ny30ToxUYrrpmVojn/eLleTeHJ3/PeYyP2e1k+SJU/wTD3hCt9malDA5?=
 =?us-ascii?Q?8kZMBQbYbD4nQ1OrEiYYx6kxJhYBo6xX2KENXas2i0ej/E6mgofqFQhhAPPj?=
 =?us-ascii?Q?BJLRjTQYxhkgNjwRHlCgZSlYmrr47byzETx1f/9vn0AIEM8TUi5aueyBeSE1?=
 =?us-ascii?Q?MRtv9qO95jqtFP5oLZRIgsYi00BvmV0iDctAkyuKpLFQI0R3m6zao9brV+m3?=
 =?us-ascii?Q?baEl/Oi/bzcud45+7MbmKyd/EJDok1WVOu8+uVQjj6CrVyAGqAiotvAz8eKR?=
 =?us-ascii?Q?oYjzAvRFUXH19GetBC2cSnoLI4OMCcCalBCJ+IX0DjBhsI7UWSdcnDwjSx9V?=
 =?us-ascii?Q?9BpTt/sPkFyS3bu8XsGF2903Y/DOIe5q+/5opHmeI9wb4hkptylCzqbiWiYF?=
 =?us-ascii?Q?0HgGKOetAORE/QDW9rt92g+p6aDOTZMJ2LXSOzcjbQGngJsFbVy8QWOCeoYZ?=
 =?us-ascii?Q?RW+xfuZ0d4N/uKqZ6bCxvBw7m5k6FHJPzcvmyXaB2PAorrh3RBndV7Jg/CZf?=
 =?us-ascii?Q?9wRGA3NsagK+3yefUNYceRrKk/YJCVxfBhX4e+XNGsPFVGo7tEnxi4omfUvZ?=
 =?us-ascii?Q?uFC9iBeVh2Dr+NUiX9SlMvL3DZdq2cA6Q4AnBqViFFuj3zlFYVUWr8P0c6Cl?=
 =?us-ascii?Q?kSZfl/uZuZT5h1bpEFce1APy2plIhjuY5gUTwmQa6Dti2RNm0VHPkyhbDR37?=
 =?us-ascii?Q?oYtSWde1tjEyLouB0YM9fNrzhoIxaq+/LijJWUJO4s3cjHeYY+McB4VUsM9V?=
 =?us-ascii?Q?q2bLwHailUiR6lUbBjZ25jFttnAHvV31K/Kinv/MpFaeYk1qeUd2lXC+Q6Qe?=
 =?us-ascii?Q?0bzNOtOX7G9Sf3qa3mXIDt/FD1KAKmc6if/XGdYFL9AV5iKWz7H1Ovyq11yp?=
 =?us-ascii?Q?ts36WuPgyLclOljqK3I0WlufcoWk9bTawI55s4wkEQJ7wNUC6oGO/DFB8yEX?=
 =?us-ascii?Q?ASu1D0TrdEVw0Ga6OvHc9MIf/xg0M0InEpE/4BRxwv8dJG+5NogNfLPvLQa5?=
 =?us-ascii?Q?nUPo?=
Content-ID: <AF3752BD17118D4AB156F68E9EC9A713@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR04MB0684.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51927a89-83f7-416b-d87d-08d8be0a5dce
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2021 12:45:00.4792 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2xrQ+1QPIy9zUTMS2ZlUB9pH0fkKdpieHN0S703/Zgqcpm2JtHwasGEp2bgauJiBfmLsE2NmoORHOocKBbudGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6363
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210121_074506_775379_D9C10E44 
X-CRM114-Status: GOOD (  27.46  )
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
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jan 20, 2021 at 09:33:08PM -0500, Bradley Chapman wrote:
> > > > Also can you please also try the latest nvme tree branch nvme-5.11 ?
> > > > 
> > > Where do I get that code from? Is it already in the 5.11-rc tree or do I
> > > need to look somewhere else? I checked https://github.com/linux-nvme but
> > > I did not see it there.
> > Here is the link :-git://git.infradead.org/nvme.git
> > Branch 5.12.
> 
> I tried fetching the entire repo but it was huge and would have taken a long
> time, so I tried to fetch a single branch instead and got this result:
> 
> $ git clone --branch 5.12 --single-branch git://git.infradead.org/nvme.git
> Cloning into 'nvme'...
> warning: Could not find remote branch 5.12 to clone.
> fatal: Remote branch 5.12 not found in upstream origin
> 
> I haven't compiled any out-of-tree kernel code in a very long time - how
> easy is it to add this code to a kernel tree and compile it into the kernel
> once I've figured out how to get it?

Hello there,

You can see the available branches by replacing git:// with https:// i.e.:
https://git.infradead.org/nvme.git

The branch is called nvme-5.12

It is not out-of-tree kernel code, it is a subsystem git tree,
so you build the kernel like usual.

If you already have a kernel git tree somewhere,
simply add an additional remote, and it should be quick:

$ git remote add nvme git://git.infradead.org/nvme.git && git fetch nvme


Kind regards,
Niklas
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
