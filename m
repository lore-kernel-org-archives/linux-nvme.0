Return-Path: <SRS0=+gr8=AS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963B3C433DF
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jul 2020 18:10:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A15B2065F
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jul 2020 18:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ais3i6g5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lcYKodHv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="zwXZO3Mg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A15B2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=0i5lExNkmill78G7S+ewc8kzSEc794v/VxTE3zUXd+M=; b=ais3i6g5FdDC7GOwM3ky+Qnhp
	WRy5hmMyLJMTVt9/n0eLG01b6vB8+78V8Rj3/mWyAjrNiENoeVhNSieWSGZJcdaUL29+Vr0MtzcW+
	4wRT7hvlE0SYkWqiiMG5d0zOpvgAkR5DxnXF97aFtlvhXchKk2/ssMQNZYjneA4ALcxL1S7ACWkV1
	ya1tUe3lY33+m43C70tEt7BCjgQArbA5z+DsPtcz0xDP6RvinF9U3shqtWifjlxp3j2dIxfeRooKo
	FcGrn/ps7JJhdv87oOWB5+THYCZYrpvgWPKh1Fddy8ziN22dwYB+CBlKwZILkGJi//mQSCZ/GgjeH
	O3SxwU24w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jss2p-00069G-M1; Tue, 07 Jul 2020 18:10:15 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jss2n-000685-CW
 for linux-nvme@lists.infradead.org; Tue, 07 Jul 2020 18:10:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594145413; x=1625681413;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=sMHBolG5tivel6VmZwr3H711dsK9DYGeQmJv8b6kKYc=;
 b=lcYKodHvhvc8kTn0qz0AikrfQ0DXjpTE0NukvUSbNWEnlKv9PdgGKtCa
 wXOL7wPhIdhNJeZrBpaO5prvBy1doWWfVBvB3auCwQSianjqX2vf8bad+
 U7pNFgowfvQjSnih3O6M38QQVsB5OVhKe+C2aVDdG5LaGs470cZ8vmr9w
 JXRMQipWjTgt3jv/H8oyr1O3rtDhXqx6q4FerfCV880phpfiFj5IroG7G
 N796u2DAxZpkOzkAZFteCJMhbbm9B2b99GFBok5b42jBoy9T5gLep9MPV
 i9F0f/VEtbfG8cMDsMSxxG3OeoAq3Dt2blPTbVOULyxgZiQ4pgnXAQriO w==;
IronPort-SDR: H9V7ohV5dhLJhHfMcy9JFsw8mnNDNpG1PKPTS5AUVS8QQocDSGjyomiHiInV94Hp4TAlSq4Pul
 7Ek32OEirP1h1ls0Wz1QBq0Xm+EPtRAyEvhWDo5ouBB8X1eF4ffyct9H9gw4c2dmsWQ+m853VT
 9q5p1JseCkLmq3K10HeKIC7d/1xduGqUh59xU+hqcUmz49I39gbKOhaT944QHwB+FdOBrMrwhe
 RZAl9M+x4OYum50TXFGod0CQLvyze8SCJpFROFkj7qQzJhl7HkOFyhH+fQ0jWXgVkMvxC0VOSn
 OJY=
X-IronPort-AV: E=Sophos;i="5.75,324,1589212800"; d="scan'208";a="143179252"
Received: from mail-bn8nam11lp2177.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.177])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jul 2020 02:10:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7IbWYlDGEsaupUnBGkijEMM9NaG0WlpvvG+wwtgVsPfBxlBOU/plgg9MvezttnT2rQvu/mrzz0FjL8gJhWNG8Hu/K+OMDtW49vgLlQTNOP72PxCzthYiowBKUWES8Q50Upta8+7kAYMaM4wn2uCYbyrCBx32DXVJLAyXua1FECebzhH1/2KIDrBP9ePi0kmddweFlnlO8gA5detpXI40H3erxxzcsEr4I9GMgRdwG0P4KYOssrgE4yecr9rtsDdqqE+NIouuWbptYE9MpVmTaNfybEby85xyriKTGwicNeYwG8pKsZf3P1NnDhOSHHuzqsyeTquMy04H750KYWDjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+NYOk48gP+sOZ1On5YNVV/yi8wV/FPf2I451WK9XcE=;
 b=RNqJceWMtFcQ8EmSkt6Z4CxH9FW9C/lgFmKmeOvEDmsu9E4ajzmNf82nf16KDyqFP5KvXCGpjuI3wKEzG2rX5JpjQ80/bNeCwjyTpgUAJrjZR22y1mGwdMQz3IJbW8iUag/Dp97ncbqKe9MvRcwxQLytwv5wFZlOcKzJTWemSe1uy9rkeVKlvEKl8gd3ZFJpPD4CT/yi8YZOhFfFscLwUbSq5JzpkVDSWyk1F7jUqTcMUCEoEopp3WFU4/JWNKJwxKh7gCBMlua7OnIbSMtowwfsf09e07zD1YnGxxGncNpxsSNS8pTYgIjpjMoJIrTaSz0yA7dRt6btClOl7vqymA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+NYOk48gP+sOZ1On5YNVV/yi8wV/FPf2I451WK9XcE=;
 b=zwXZO3MgUmCBXpGLRMQwKBQgrCFR4tF9wdeMlEesf0kDnSZmwRM1iWIG7GCirt+9AH4wI+93mLtRO+mT9XPg+V9zBDweB4ZdVn6Mp/EdHFbLgS01dloS1eDBjbxzETCdwO4JK6XtEfWDy2kauPD4BUYCRhb0pP06N3Q22XIlOyI=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3957.namprd04.prod.outlook.com (2603:10b6:a02:af::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Tue, 7 Jul
 2020 18:10:08 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3174.021; Tue, 7 Jul 2020
 18:10:08 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH 0/5] nvme: reduce repetitive calls in fast path
Thread-Topic: [RFC PATCH 0/5] nvme: reduce repetitive calls in fast path
Thread-Index: AQHWU/SbDkkPx5lZxU6slWHlCE2dtw==
Date: Tue, 7 Jul 2020 18:10:07 +0000
Message-ID: <BYAPR04MB4965AF61809A1B8ECD71663F86660@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200706231524.16831-1-chaitanya.kulkarni@wdc.com>
 <20200707071111.GB24011@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1c5c0001-c0e1-4391-51c4-08d822a0fb60
x-ms-traffictypediagnostic: BYAPR04MB3957:
x-microsoft-antispam-prvs: <BYAPR04MB39576F9077A74F78DB88C86086660@BYAPR04MB3957.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0457F11EAF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7qc6EyrXkV9cZN8UouZRaHspVx3RqZZVtOQd57ztjZMmyyrWSkN2WsBh/6jD0mJ8BEc6i6xz7d2abb7t+Q4Zl0uF3A+5fLZJJzVUdHZUyvmz70PA75dqQSuyNwOTic2xBEPOBo0T08X1rZJmW2IFJL2I/jJj26xqbzTmI1/zZBMNJ40w33sQtNr8EGlTdyObGpZ7aVYjEJ56CHgKDOwap8zjDT97nVqrHKzctgP1Vfqe04er+x95wj7TjW505blYnnUZBi3rcMY2qWgGAkWc1cPLGRSWM1ty35jFBkO91EQCDYuK9CaUsyv5apfHHukAGopSiVOA5iALDtKbHtukDg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(39850400004)(366004)(376002)(346002)(6506007)(26005)(53546011)(7696005)(52536014)(186003)(478600001)(83380400001)(2906002)(4326008)(8676002)(8936002)(6916009)(55016002)(33656002)(316002)(54906003)(4744005)(9686003)(86362001)(64756008)(76116006)(66946007)(66476007)(66446008)(66556008)(5660300002)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: nG4IDvHaIswJhkrLmjeibjNZdSwZVTBV8M+BKgo4OXxxR9PAIhZB5LNHU93N/xpPs3YegTMsv41mquCYKd+vuFmJannvT+N205AOFATGJqDnUYNZckSCnQhAcZGA3ftuDrjKKzwm+H22iwf9QYVVaR13/QCO8EhXhK+W4hhGs0EmRKcKTnZF4u4o8aELqNK3Hqzh+7IGrIbHImhYGGPQeWWIsxjDLJIXSelwitMVjJqHJZ3P+RLJ1ZM4HCP7Mg7kd72uMgbApcvHp5Ggkbyav6nUj7H8e3OTTOpBAXw+EvhmtaV6Ry5Q2BLAXZYVsnknDrcXsdKENKxJLn29Uw1SG1NIUXc5gAxvu1zMb/RArllj80hh6hY0VsRIBuRr5YORRrRcHtHDBhib6ctsNn/mVIVfdL6c/EDrLZKQgrbZFGR5jJL09grUNO/En8XcaynphqwdGYX4IDVoBiU9Qhwmyud1AqYrpIqmlbXoAxVrYoI=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c5c0001-c0e1-4391-51c4-08d822a0fb60
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2020 18:10:07.9241 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ZtLtC7x3g91hpx/7W36207KebdL3YWLRYsCMbgNYQYzapSznGmpa1uT3mMQKxhb/L6eS/sX+9iukdZ94gzgCmyVsJiM9MRr8zgiBX/1J0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3957
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200707_141013_721787_ACE8923F 
X-CRM114-Status: GOOD (  11.09  )
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
 "james.smart@broadcom.com" <james.smart@broadcom.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 7/7/20 00:11, Christoph Hellwig wrote:
> blk_rq_nr_phys_segments is pretty trivial - just a branch and struct
> field access.  Does this make any kind of difference?

I've not seen any difference, on the code level host side adds the same
additional multiple checks (fc(3)/rdam(1)/tcp(1)) and if the device on
the target is nvme controller (nvme-pci with SGL 3 additional checks)
the same check will get repeated (host + pci) in host-target fast path.

In this case having same multiple checks is not bringing us anything
either since rq_nr_phys_seg is not changed once we setup the command in
nvme_setup_cmd() unless I miss something.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
