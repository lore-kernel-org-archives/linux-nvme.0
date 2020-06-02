Return-Path: <SRS0=vW9m=7P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA83C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2020 07:43:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F2412072F
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2020 07:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g1iTMff/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="c4EXqtgH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LIr0SYFD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F2412072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=bRHhXKDq06IkSImM2XwcGtHPdtDvUS0v2zGrT4wAmhc=; b=g1iTMff/8OgVz7
	/FoUUOvlCztTvOdQzGmkqnt6mh5AtzM+8PG1P3Wlkw0smvgZPfQfeWNJ9QRjtZ6FGOOdsRRTADO7i
	vlwX47YMIgh8NuausWyOs/fE4QnOlaB0BO0hxZ1tgj63U+2ynw7NQrdIpXmdhYX9VH5JEugCeNW+d
	B9LdDFl4c1ABmyB2HVue0LcWSiHSWhQgJvde8EZ5louFpIgLGNX36C3zgQhbDWbPofsrSZE31EJLu
	pH3Ewu2Ojf6J2O4+6quHqOsE3JqUe64jp1C7Lk7D26nzEr0wnmkwUaKS0wuhIPqS5CGYGVy+Rz9Nq
	+73wooe+rd1sfKQ0GttA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jg1Zl-0008Nw-U5; Tue, 02 Jun 2020 07:43:09 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jg1Zj-0008NK-70
 for linux-nvme@lists.infradead.org; Tue, 02 Jun 2020 07:43:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591083787; x=1622619787;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=0+p4OBN1us2qmzceKuvCVdQ4W8nBabJIQULbQW6xHu8=;
 b=c4EXqtgHXSZg93QiRmgzHd6qfitHUJQRLpEiijbGK65a5HubOwJ1SzWG
 guj+hRAS9GJki0/ceI0+QzSfXqUvdoH8vcniNo4ZRKEyO4uVfWH6e4OQ1
 Y1QAT1U9n85Wv/GOP5YpIvG8W6puPxJgGWK3KSWRy4bIzgVMtP9MTmVms
 KXPl85jKjWCUTIpQn1e0gypz22rKFmZ4jGwFMQP/zVPq1gUKDZHLVqk4Q
 BDb13HuHIRqO3S8PNxtgE/5hvCUOffMBY7oFX7HrwpgWbOKrLeGSduCoY
 JA+nhA91PopVsn5WXFtKfXz0pLNz9TgLMyKNoJsQ+4P6p5uEYB1kCGBQX w==;
IronPort-SDR: vBW22Ioj7jQ3I3PVYetqMLwsXtSyn60o71197bjBooM5PSmClpZNhtrk7555JRuSUNKV8Jx1O6
 XVKb3xMq7SjD03hwPN/88x/wxBdVsJDWpZDVkaZF+fIolUqa5gOQKn9ys0+NQjFKahEEICxihk
 ECmOdIBeaPf3p02bwQmkKIqlq+d+lGBKA1/4evXqrSZmIXATMaSZ8IFbQi4fn7KlrFYe5Hu3Cq
 c4nGYcBNO8ioobk2oPXxulKndNbbn1IlZ+ZTgmRubsQGgF0xzWSQbJA82Zyr5Z9OK+bP5XR5V4
 E9A=
X-IronPort-AV: E=Sophos;i="5.73,463,1583164800"; d="scan'208";a="139005631"
Received: from mail-dm6nam11lp2176.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.176])
 by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2020 15:43:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JcWCxQt4cfmWBM5vhYOC84rbGwv7ZSFIOed8Qq2UMQ/KQBVUH5FIpbf1o7T/5kyo1nAUuNoXExo1G6pLkwcPMxpSj/q3iWbVBygvhvjcK6+uteTYvxc6bXJ1oAcJG9ZR1i+uPGP6VtB+2bdPiPP1CpFmabmHL0Wh27gN15iMsO0r95yjq3PgRpC3dXx1pKOnr5ThojJR+sPAMuDyudsjsV5ZVAYQOFghKOJmKmsur9ddxuDLYACFkvQGqCuKhg7dUv6bRMcuMTOAJOoVVC97f7/OBmpkp8TziJxvHfxXvSMQSdqb+Ej+EKvOxv/KCzhKaWGMufTUO9htCmj8+ZNE2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lflYut9YjbrQwh/Gz7B+l749IPVQw5Eu4Dl15eN03Ek=;
 b=D1EeVPXX9aKcysI3rlStrfJtQ24sR2UqLX7bzemLWjl0vbOpqi6XI+j6SngJU3B8tdZnZ3b+7ipe2/v9a5y5aJUichvIcw+9E864otKii76ukZmj1Ygbc7Ne/jYF0VBYSjtNcfGwvGTrph7VwZr8ZkdNdwkuJDw2gBQclfl/wfY6ZEGQXqEWHGg8SWNbkGqYfagisFBxU4emaW5pYuX1OOFHK6EGlr3bsp/9urfoYWigzKpqw0dqaIkYdeS51oohkrLOulvA6Uujp3JouJEiSOz1xhwa4+lAqhBiCd0Vur2UcJzHJazAWQEiMvykxMM7/8Wc9OV7F3N6pOHqjK1OfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lflYut9YjbrQwh/Gz7B+l749IPVQw5Eu4Dl15eN03Ek=;
 b=LIr0SYFDUC0fC7fPlTyn4sMlbRJSby39PimQ4MvIrpqdMz6m5GPxkRXviqtMihidlI8fH9bfbR6sUNFaqNeVs9yMOps50dUmU9hNEY0XqgWk9vPzdF4S9ft4hnMtIeVND/TiRQydhWVK4MOPgiLsgrMfokKPh5h201ui/k3dMrs=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4437.namprd04.prod.outlook.com (2603:10b6:a03::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.22; Tue, 2 Jun 2020 07:42:11 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3066.018; Tue, 2 Jun 2020
 07:42:10 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
Subject: Re: blktests test nvme/003 fails
Thread-Topic: blktests test nvme/003 fails
Thread-Index: AQHWNIJZVRL6ENIo6Uy1ge01JbudSw==
Date: Tue, 2 Jun 2020 07:42:10 +0000
Message-ID: <BYAPR04MB496567BF87D28199FACD5DB1868B0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <a2b9e92a-f499-b54c-a275-c08a23467866@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 474cfbf7-6516-429d-407f-08d806c875a5
x-ms-traffictypediagnostic: BYAPR04MB4437:
x-microsoft-antispam-prvs: <BYAPR04MB443726CE3A9E381B64FA8725868B0@BYAPR04MB4437.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0422860ED4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e4aIHcE/LQvjCyEziZAojezyKATDvNQlTkD+PDHbesXtbZK3qze+/neybvF1afs9acQuTteu42uq031AX6G0PSuTsZtzpDmlCoheliGQm409CrTfpNsWB+zFQkOWm8G66tjNNz+SWy4bj3j7TAvQ5pjkjpRxQZEXI+5d8/4TOttB6TjsNLtaP81u9Z1aH1LtVD8WKG4XjRzPicd6f9msebn2IrgekkOxo9iN19xE3mHLsv152d++NS5d/PzPVmBuaEFCOOnpgKNVSkEGbOCA5gnxTOUcTOFjnyZCwwa8/7bp1fXanCdvTDn61QQQ2qUY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(86362001)(76116006)(66946007)(6916009)(66476007)(66556008)(52536014)(64756008)(66446008)(83380400001)(5660300002)(8676002)(8936002)(9686003)(55016002)(33656002)(186003)(478600001)(7696005)(26005)(6506007)(4326008)(316002)(2906002)(71200400001)(53546011);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: uXIEGESsdELbqOgc6AtstzxEOeo7TfvzyA7UbimLpiY6uf5M97Sf/06j2ebbLMpVPlzweRXg389jiHmt2n0im4m2KzfOlHnjcLaoTvTeXgmPzn7rOtlLrJVHEA6fHj8OrZZLz47x+WAJ6mjh5ZRk3YLwb6VQ4mpjADQqHezCRk1B0jP9jwJlo6FZksGjgJozmPGR/V48RD7koOIEMpV4K7YejB9QA7nQ15Fq+pCyLVleHub1cMUGh0qO7Qjm0VM05hyng6/S/xSSz4RyvkSAg1woNFcixRf1FJuKkf6oeJczmZh46KmKj7YEhF7+cRRc0/84TK8VjhHQohVZaVCGSLLYuUdBBW2wv7JxUYy7jHiNwGzvKnF3naXZOPesJXlTWrEWO2Xi/OULe7hU+3qjmPo/f2PmP8SF52Y61jrEVJVekul3aABjpJlunfuWky9m99l/NYe4A9eiCtQB9XXF9nXvpyqWMr7RhsnnK4odVJo=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 474cfbf7-6516-429d-407f-08d806c875a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 07:42:10.8496 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yZVblyYNbs7im5UUPwd65k1B7T+xMYJfBNHiAltZ6sd6qGSkb+JCXUg7W1bhdmg7G27nkDCj06jRhjP5Edl5KO36X5/EWL+cwMuFibUjzVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4437
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200602_004307_405724_C0FD6A04 
X-CRM114-Status: GOOD (  10.58  )
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
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 5/27/20 4:55 PM, Bart Van Assche wrote:
> Hi,
> 
> This morning I updated my local copy of Jens' for-next branch. Since
> that update test nvme/003 fails. Is this perhaps a regression? This
> is what appears in the system log if I run that test:
> 
>   run blktests nvme/003 at 2020-05-27 16:33:49
> loop: module loaded
> nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> nvmet: creating controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:47f11c7a-c9c3-4964-b450-d1818ee33113.
> nvme nvme0: new ctrl: "nqn.2014-08.org.nvmexpress.discovery"
> nvme nvme0: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
> nvmet: ctrl 1 keep-alive timer (15 seconds) expired!
> nvmet: ctrl 1 fatal error occurred!
>

Something is wrong I'm also getting similar error when disconnecting
controller with simple nvme-loop bdev-ns, looking into it now, unless
someone already has a fix for it.

nvmet: ctrl 1 keep-alive timer (15 seconds) expired!
[  552.633034] nvmet: ctrl 1 fatal error occurred!


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
