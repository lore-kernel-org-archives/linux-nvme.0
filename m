Return-Path: <SRS0=Uo3O=YD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD415C4360C
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 20:10:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74741206B6
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 20:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oi0YCpgd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="U97wZZlK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="gLHzwPET"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74741206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FntosQ2toYwblPJz0qdWNsup39uirRXOHkt0O1rxgnc=; b=oi0YCpgdrdGnId
	uxr9OXNeo7XNMKlZUZjJSRWY19H/9iRJnNpKMMXhuc+5mTikLdBIEaew+PjhnQ9lLcGSldIhOev5D
	jj7k8JPQ4TFVXAlMqj4MtXFrP7Y4qph8E19THOA9dD030gsfcfNiDaIJq4ILWEotw6vuHAX4AexSw
	QNrOjwFhlm0aEfFVgfPpNqSmUrdPJMfHPcsgV7/Cm21V4whrFb5LzcrwdDkCdOEGNfg4hnU5jRZOj
	rRzOJ4Pm7Dib9Ym810DfzolVSXaB7+exiJbhzZSYZbnl6wiC4aj9M+1E1iNV07f0zpNRKDQS4rWhz
	0QvtMK9kuq1dvNtIXbAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iIelT-0001ci-54; Thu, 10 Oct 2019 20:10:23 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iIelQ-0001c7-Mq
 for linux-nvme@lists.infradead.org; Thu, 10 Oct 2019 20:10:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1570738221; x=1602274221;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xK3ZpvblN2+AjbU5y29drMT5A81k2cesKX+pY4VQqrA=;
 b=U97wZZlKQH/NOltbqPMNSzW/MOZkZ8dBxYhUg+JquP7GF0e1XBaPaIul
 eSjUirlc5IXqz8HjecF/Po4jk48Hovjikzl+Mvt+C9wG3stt+b2lOfrjC
 oZ2sI+MWAGp1t69s8LcCAWoY6E/UdWThYEriKVtRd3i5DJOW/OVaqoHA8
 551xvXe8d9w2sxq1WyzZacvJ0MEa0VLyRcMKf5Y4PPCuBOLxwobYFgGAP
 1UlGj+wlkZIGqbZZqxJuNmeyX2eNdvKLKJys7MyRkIIKf7TY8nB9G3VFI
 kn7xRuWTBzjjiFuGZUKfRE6V70g5LWKDxiXcu7phG43guSmuqjemRCPV7 Q==;
IronPort-SDR: VSdhjGZf+wTJDsMsiiQv6pYa/ISlAIhFXrbog8XemJ5JBQvDdmcrg5Lx7eoc0WiqKZPyMPwv1L
 RuyKY3eb3Qjy00PraNGghV7AP2XmQgW7EybE8BeLuM68MNhIdJnMzY8YXT7qYYnKrw3/JmP2ZQ
 nnrC5EJHK+IB9Fe6RCCk3EyP4kq+CsSl3eNzBrh1e2T7CJt0PHLxcseLCxbJjt4Y/UanaztJLO
 MEGiJTXw5zbdJ66e693PT4I3mPboL3efFitFs9IeY87Phpejb6tObzwhyl9UO0e4dzCJcjKduS
 qqI=
X-IronPort-AV: E=Sophos;i="5.67,281,1566835200"; d="scan'208";a="121057040"
Received: from mail-by2nam03lp2054.outbound.protection.outlook.com (HELO
 NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.54])
 by ob1.hgst.iphmx.com with ESMTP; 11 Oct 2019 04:10:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3PZ/1FaSU1MTpEoTjdFt/PfrJg96/+Pl1Qb7UCp1z1oRpQ/9ZYpBcIL6tjfJ6Heo2cVLVVdtHNQXtlelauCO11auxfMnjjbmOO4hZhniLRHdispopMmHBhE1vIi3JVxEpjjH/vQM4ZTzdTwO3Ar2U2l40uZj+VAaIMY6OWJ95gjQWsGLorYtHF1Lda1156C12qt2kPfGWt0980EFjb7ZumNakooPsQMiROplFY3ZdmSDYS0rJvUJ1Qt0Yo/e5VnSKv2zKfG+9clDzwmYekK2s+W3yLhUYHE9Yuon3GALxB7Xhh18XP3tnbVoXdAKp4J2Ymxj8tBYENMB9J2pKnRnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUZkIYjwJkvsVCnSvEhnBB6V1hyIl/3hCvcYUIpZSm0=;
 b=bHaAuOIg5E4lT5doFIpCwOB5Fur81hXX984y+b/jyJUEHBVilzxMDLPl2NlIMf9sAXL0O+zYcqR4j7x+gIHV992q9u6QuMoCbXOr3IfQINCohwpapQXbptm5hGMZv15TpJXAPRWSmihKNrPOQDrHH3L+unpTsCG9tfrfBG2uaaKxpBbKLt4ekZogGZm07U8zy7/hAQLg3HAA2oAk+3PwhsQq4LnC6w8BrZNfEjILi/2eRLf/9H5OF/giIbXwNNlzVjfWMiB4omubHeIdyHHxb1w82dV4y4wMKWD7EBYnaLjhl67Okdcf0KdDBSIu3c91TWB5TREbnjpF+CQWahZMhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUZkIYjwJkvsVCnSvEhnBB6V1hyIl/3hCvcYUIpZSm0=;
 b=gLHzwPET1TGokMfCbPq9ugtPfpd7g2cVqC2oYjJdtCSaAAifa97WG+av/VbVsE4RUOvDWR/NUz7I31tk7V07HMkcUef2AbLy1aPRw980Q2Od+zhVGyKwP7O+fTrYLIaZBp02GJG/p6ceeBXiUQdjSiomf6lXHU+cVnxYb5ki9s4=
Received: from CY4PR04MB1175.namprd04.prod.outlook.com (10.173.195.148) by
 CY4PR04MB0567.namprd04.prod.outlook.com (10.173.188.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 10 Oct 2019 20:10:09 +0000
Received: from CY4PR04MB1175.namprd04.prod.outlook.com
 ([fe80::6988:d052:2b41:d002]) by CY4PR04MB1175.namprd04.prod.outlook.com
 ([fe80::6988:d052:2b41:d002%4]) with mapi id 15.20.2347.016; Thu, 10 Oct 2019
 20:10:09 +0000
From: Jeffrey Lien <Jeff.Lien@wdc.com>
To: Keith Busch <kbusch@kernel.org>
Subject: RE: Issue With NVME CLI list Command
Thread-Topic: Issue With NVME CLI list Command
Thread-Index: AdV/nKkBxaoD/U8hTdiiwmMsi0edrQAA4KUAAACPWQAAARCqsA==
Date: Thu, 10 Oct 2019 20:10:09 +0000
Message-ID: <CY4PR04MB1175591968942C0302603870EA940@CY4PR04MB1175.namprd04.prod.outlook.com>
References: <CY4PR04MB117531DFE8560BD3A72787CFEA940@CY4PR04MB1175.namprd04.prod.outlook.com>
 <20191010192318.GB22635@washi1.fujisawa.hgst.com>
 <20191010193920.GC22635@washi1.fujisawa.hgst.com>
In-Reply-To: <20191010193920.GC22635@washi1.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jeff.Lien@wdc.com; 
x-originating-ip: [199.255.45.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c6a6f9e-efdd-43cf-6547-08d74dbdd9e0
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: CY4PR04MB0567:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <CY4PR04MB05676FCC7F6A418EBE3A006BEA940@CY4PR04MB0567.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 018632C080
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(13464003)(199004)(51914003)(189003)(7696005)(99286004)(74316002)(76176011)(305945005)(7736002)(6916009)(53546011)(25786009)(102836004)(966005)(6506007)(33656002)(478600001)(14454004)(66066001)(316002)(9686003)(76116006)(14444005)(5024004)(8936002)(8676002)(81156014)(81166006)(71200400001)(71190400001)(486006)(476003)(66476007)(66946007)(52536014)(55016002)(256004)(6436002)(11346002)(446003)(229853002)(2906002)(6116002)(6306002)(6246003)(5660300002)(86362001)(4326008)(26005)(186003)(64756008)(66446008)(3846002)(66556008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR04MB0567;
 H:CY4PR04MB1175.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 59ecg0+RiJDirLZQTNigjFK7J6tKRLYp6LRTplo+BMHU4Xdu4hG0TRlBFztmCdxaI8Fqs9dTKsn4WkAlW9tAAYtbUdvIzRgf+UEUZTmCNpqyHsHRKWt+ZoJqLaLzdOy2KpNg+Y3OOKZXPWwREMVxEiaYGafYYXAd0OjDtd6OWba5ellwlGA6Qz6Cetlr5jR9N0xDcCIzSSvOG4yMKxveGN/egGtToNlLDijT2CyN4ElqwLE/fxxHSF2khej7C/rh7llAKa3FlZTYjMRy+W2LGMNN5EyJ3/C14HDU9HS65wq0cP9dpFUqjTiXtD8e9xKr2Hzluk66JDYzHzjfJN/MPp5Rm5e2LgD+guIL79LAwk/JLjOn3f3sOoLGbyf8wbVdPsAh90swyTw4hXHrF6nujgYh10ju+nD6tV2sracd05rgvfw1NMJYi/ewwmz9QUfBdJBVvEs0YoIbrcvpbUjhPw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c6a6f9e-efdd-43cf-6547-08d74dbdd9e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2019 20:10:09.5424 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bPGC3F7I2QW5Iz7sIUlUhh3d2z88WDx7ZRzAP9kSHiuf9A9YnevoENWl17dh1zSqk2j5Jr2RO95jchWRxyTvvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0567
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191010_131020_759592_711E56BA 
X-CRM114-Status: GOOD (  20.26  )
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
Cc: linux-nvme <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks for the quick fix Keith.  


Jeff Lien


-----Original Message-----
From: Keith Busch <kbusch@kernel.org> 
Sent: Thursday, October 10, 2019 2:39 PM
To: Jeffrey Lien <Jeff.Lien@wdc.com>
Cc: linux-nvme <linux-nvme@lists.infradead.org>
Subject: Re: Issue With NVME CLI list Command

CAUTION: This email originated from outside of Western Digital. Do not click on links or open attachments unless you recognize the sender and know that the content is safe.


On Fri, Oct 11, 2019 at 04:23:18AM +0900, Keith Busch wrote:
> On Thu, Oct 10, 2019 at 07:11:10PM +0000, Jeffrey Lien wrote:
> > Keith,
> > I'm getting a "Failed to scan namespaces" error message back from 
> > the "nvme list" command after updating my fork and picking up your 
> > changes from Aug 28th.  The cause of the failure is the following 
> > check in the function verify_legacy_ns (in nvme-topology.c):
> >
> >     if (memcmp(id.mn, c->id.mn, sizeof(id.mn)) ||
> >         memcmp(id.sn, c->id.mn, sizeof(id.sn)))
> >             return -ENODEV;
> >
> > The problem I see is that ctrl info is never filled in (at least in 
> > my case).  Both c->id.mn and c->id.sn are blank.  Looking back in 
> > the legacy_list function, I don't see how the ctrl info is ever filled in.
> > Maybe it's just something strange in my case; I would have thought 
> > someone would have stumbled across already but maybe not.  If I 
> > remove the above check; everything seems to work so I think the code is
> > basically working as expected.    Could you review the changes and
> > either confirm what I'm seeing or let me know if I'm missing 
> > something.
>
> Hi Jeff,
>
> What kernel version are you using?

Oops, nevermind, there was a couple bugs in that path. The controller needed to be initialized before scanning the namespaces, and then we need to compare the correct fields. Fixed now:

  https://github.com/linux-nvme/nvme-cli/commit/1e858be6c25172f9946e4979ee724244bdd722b2

Thanks for the notice.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
