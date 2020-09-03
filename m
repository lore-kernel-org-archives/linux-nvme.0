Return-Path: <SRS0=8iPx=CM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CABC433E9
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 18:22:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6775F20716
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 18:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kSr2itfM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="H9L+WENL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XGZJUWbz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6775F20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=IF7KOISUxAjIIWgS4opPMR8NiBBejMBdPwyzHRtCxaU=; b=kSr2itfMmVKUsYoVMhLbKJL0D
	SWuvCDqfMYqj3K4y6YjomPzbtY0bOEL0joD302qptokLRCC4XpalRH5eHOT4WIhnErcO+kS7dtSNM
	wAo6P9HGNf/ttrx0/+BXBrmhMaCaDd/6A0ep1P0dxDPHHFxp0TetNu5HF/Hz4mDsZWU9X7LL6CE4C
	gkadxShdruoFC7tOMReZeT3N5AZnqJ+OgZkkiN0kk1+i5kJFDd1ppWaovfFM0+Ld/KSxK1Q8lr6K+
	3VUNCukHgRhk1fhwkSD3qgjSUPXtQ2rmB03YkWfTdDtjcoWQJ242OMUWhnGi8DFhrbIqPhIB+egzs
	rg0GYouxA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDtsg-0006zY-78; Thu, 03 Sep 2020 18:22:42 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDtse-0006zD-IW
 for linux-nvme@lists.infradead.org; Thu, 03 Sep 2020 18:22:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599157360; x=1630693360;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=sfkvECgNuGXWGXZ471Zc8yoy/C0BuBsK7nvVpsOVaDM=;
 b=H9L+WENLuyiMIALnIjOVYpiv6uLLY/0W5r+t73STJhIK5DhcizC+CW5a
 tTEn0CXA+4/jt20Y90+f1OZeWSJvMj6k8uxQCfJ2CzA8QbzlFI2X/+Gvm
 1FcW4X8sNAFaO0dMWauMkcRCtPBQNqDMYjo3DmzrmHOZl3F1kHLICV8ka
 lFoZ1kxeyeE3kZoOuC5GAAcu/0YOBsXkNT44gbhmGYS0nKmsFLH4A2Mcg
 03uI+rtDSnBypzaupizzBno0W8aB5U2/z0oKPXiWUQHwi7RdDhQOrVadl
 p7ukJdY0r+k80q6Vjqa8o6eeWMvltzSRd4dNbesR8VtbfoyAMM+IkB1x8 A==;
IronPort-SDR: sbj64ouZtfQc4jVlkFjo7ozvn/A7d1hsvgPfZbtug+qMGgs6SXLf7AvBXfB3DG3/3gocNmwf+Z
 3odD2IUHwz74AXj6WOYowltQTpwXwSveIK6rKTITvDb6Z+R7oH7lOkvv2zOf/Avn7Gv/vK9ZWp
 ZLdfggHHZzIzWFCtqtIHZ3TP3levIdihp/fxQxGPbpGBvPYid17xKrI7NN/BjKv+9jk52Bty68
 jPoAnd3sGiu0Sm7mbxYQq1mPbuuV1kZPtgRZQ1V3GWImToSj7Q+Z2rcfp55qkATaogbqMfqOQG
 WmE=
X-IronPort-AV: E=Sophos;i="5.76,387,1592841600"; d="scan'208";a="146449946"
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
 by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2020 02:22:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtVIjNOlC94kxQLMk0dnToY3wkym/aIiO/jKbEqYGHtxZQGjwrJynsbetDkIFmUD6+f/YAN9SdtTq3UtLjAg8NtoHtMDSpTftSTMey1XRW1N24De5yEVVLVRrMYhdmfHB6+UFixrgLw6TlBquMlEN8XYvmg476IrDAM4LeLHI6wI/jHEqFVw1/r4lAe+nX2lyHTfvfGtSwgMdOSUVCgMi6J/JLbuOTYoK7bZ63g3La6BD7gX8eOihUlWo+6gezxJq662xrFIqEVYzR6eq+gquQk4T+ZHMhBorMKuAXAKk1PUZgcykafMtYjMu3PM72fQotFZ5VfUCnxDfFqdW6qacQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmgdM0vvDKBcETQGjBnxe4x14bnITSAxXhVqKfymoQ8=;
 b=liaP3WUv2Wnbk1Fg2hieS2F45mlEA+TW837Fo6beYj1IKITWlTBN1YJhG/tV4aLwtghlpu24WiV9gzmVHRQNMyQOYcZGE5uWYOESkURTq8SjKftSgLBtX706v+YHho1k9BL9mZchZLxcPvdC6VJ1hGthXAr/Pnxc+xp4HJqyqlLWAepk0ulzwZbsZL5E1oNG10SSkr3GayxVku4exQyg2vca393xzwzp28O4VnXf41x3j0FN/F/1cGUSAp+uTOGBBuNYutybnYu/e9UZWRSDREbENYDnBVghbRyCgDIZ6DgACY4XUkyKJHP//hLiiiI+z5OTvPCxVGddMaaBlrdSGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmgdM0vvDKBcETQGjBnxe4x14bnITSAxXhVqKfymoQ8=;
 b=XGZJUWbzdDhdjNVDzweLLssMY67GSHFGdBjTAL3XJe9kio8giylX5W2IRvKO8qTsRYbZx+GKeP/XQMcXYVP2NWJEn5kfWHcL6JhayzIMqEVsBm1IKrkZxlFdDGhyafdsYFmeLQXraZuwDJoG0/H4HYexRQkWxLejeKXY74vLeJA=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5430.namprd04.prod.outlook.com (2603:10b6:a03:c7::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 3 Sep
 2020 18:22:37 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f%5]) with mapi id 15.20.3348.016; Thu, 3 Sep 2020
 18:22:37 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH V2 08/12] nvmet: move get/put ctrl into dev open/release
Thread-Topic: [PATCH V2 08/12] nvmet: move get/put ctrl into dev open/release
Thread-Index: AQHWf+X1edjVMuKng0yIe5i9t+L/Tg==
Date: Thu, 3 Sep 2020 18:22:36 +0000
Message-ID: <BYAPR04MB4965EFF16B050F060426033D862C0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
 <20200831222707.35611-9-chaitanya.kulkarni@wdc.com>
 <7310435c-5341-d95b-55e7-605c0dc7130e@deltatee.com>
 <92a8029f-88e9-abbf-a30a-a339df3c6dff@grimberg.me>
 <20200903162158.GE25423@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3c75a204-6464-4e27-196c-08d8503655cb
x-ms-traffictypediagnostic: BYAPR04MB5430:
x-microsoft-antispam-prvs: <BYAPR04MB5430555A74314E7B826EE19E862C0@BYAPR04MB5430.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8WHyJVNmRFwiBbOxEgBg6E/HnA9R0ZvirginFtZChgT/yY3RvhvjwxAP7aCpfsEdVpcFMJfjO5OkkaQuVpNzRdDmcRRFCAJeQIOxQxugpj6BKXgmkDSpS1CjdSv67o/ev4vVy66OBH8UypdHHQ6aZTK8ogwcAAsmzXhaLGADaqp/2A4luXAOvo0TAoT4iycNgZWwmv817/D7hfIR7iZNo79pAkSwZbfGe3yoZGqDVcqYJq/q6HV0Xb6AwLTqSIwXfcomNucrw+XsSdUYO6ooBI+t30HjwBc9EvE6aB4BeWuFz1Dmp0+NggVjzIdzzpYfXNXoiXE218hRnUZ8yJ0oAA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(71200400001)(66556008)(26005)(54906003)(186003)(6506007)(316002)(53546011)(33656002)(55016002)(9686003)(64756008)(4326008)(66476007)(478600001)(66946007)(76116006)(66446008)(7696005)(5660300002)(4744005)(110136005)(2906002)(8676002)(8936002)(52536014)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: OR8LMD4BFYWFj6ZfW+ihnh93b7iC+vYyHVG/eOPG/m32R7ajw3YsHHlRoDVLm0AbNoN1YSXmVG0c1A/HHqWOpKegdOB5QolwfzyVFFZzrNI1KgC1Cj6FsmdOsrnQvPU87TlOZpIA4Xv0py8CUHkMYVZ/sroLeRQsdMSH8W4YKc4nIBgKYXyB84WeKHFllVtYNxaIuHvQEE4QiCdv687v2euVZaMz1+NL/hmkXxqXTrrjQImPBYgrazIXge+L08jEb7witidvpIUWSVxXyCRvCIHik4vT0f7qtG65TIjDS5jzmBEYuV24hWj1gGWbGN7l3KlwXWAusSzdrrZdVXZDDVvmRTKJAjbH/mK4Wfrdd1DuFacl84JN9ia1TLVJ/P2VqXkuQHnPeKOk9MkOsRbcPBBeRbHi8tfN9EmxWFh2c1FKfpiAhVDquRX37tu8DYfOPWlNgOtkzNMA+YgpnTdlJRcfCFeW3LrN2oCRFFNu8MIpIs3rhg19n3VUFRwSl9Cjmx/VOfT2/+LLb8Abb4tyXF/3zUhHJF3Sq9o4B1fjNMPHt63uN1NDpMaT069YME/kN5qeXu5reJLZeKu8QKW3hAquWVtHkaK1DH6ntvpKdNfXAz/biigQlvOUDenPSL4nlaGohHqPgOfz+KHubVZkWg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c75a204-6464-4e27-196c-08d8503655cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2020 18:22:36.8925 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2kjj4TkQqII4V7yoVAH2eqZfE3+ZwqcxElPYqsxXei/F60LpBNl/XxyZyMap4LD0+RwoKafsnFWoSp/CqQAvzP1y0HHS3VMmKvywtZPusv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5430
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200903_142240_750033_2A294931 
X-CRM114-Status: GOOD (  12.47  )
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
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
 Logan Gunthorpe <logang@deltatee.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/3/20 09:22, Christoph Hellwig wrote:
> On Tue, Sep 01, 2020 at 10:18:23AM -0700, Sagi Grimberg wrote:
>> Lets overall split bug fixes from any enhancement. Bug fixes
>> should go directly before we handle enhancements.
> Yes.  I'd really like to see a minimal bug fix series, and for
> real cleanups and maybe then we can get to likely/unlikely
> micro-optimizations.
> 

Okay, I'll split the bug fix and rest cleanups.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
