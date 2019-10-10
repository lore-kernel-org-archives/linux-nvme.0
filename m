Return-Path: <SRS0=Uo3O=YD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25544C4360C
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 19:42:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D93AF206A1
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 19:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c5APPV4H";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Vj7slNW/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RBPzSwy+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D93AF206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VqFLx7n4Gf8Vx6/nHupWWQc2DpHdSlcX0JffpDZbejc=; b=c5APPV4HKn68lm
	+x6/EFkLuZEio0ZWSSl61WQXu+5j47+eLkqd646zoi5FAag78O+wu7AQcm1D8AYdEQe19JaLWEHqu
	UCvauhKwEzAETl5Iw2NWCuF8RBoKLpof65AKGeV+ajjpqORHLYNrrbxWd6t9esDVLqnovrkGQ0sCt
	yH7Q2An5QR4wiEJ/MyjBQmUotYNliawYHTqQ/SYUssgHF1aa9CL+9gWH9GxN1IrDi4lvd9ZZI1hkB
	oMLFMsXfzi/EAW4g0kKEWOxsEjWIQ32zywp/25s9GJ+d0idBEcNJKf2TznyWj/w1StPQ6jix7uRyq
	QiNmwYmbTi2hoGucDZlQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iIeKl-0005SF-Sd; Thu, 10 Oct 2019 19:42:47 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iIeKi-0005Rl-2D
 for linux-nvme@lists.infradead.org; Thu, 10 Oct 2019 19:42:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1570736586; x=1602272586;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=JcYHtGKWD/2Hn+L4FyfBdk0ka5CZMIA5id2Z7rPC1Ak=;
 b=Vj7slNW/1pft/NEwmVebgvmoZp3IuQ9Pw4LaYmr+7qtLPhyh5cJNnRMs
 XVDQpy/OXhKW9r0i8sTIigTvphRxsviUbwg1HT/A6rgrGftbVw9Zl8tkb
 carrKFknZwU/T4vz/d2oiuFc//6Nx0Fhgtiesy+001wDsfwKu13SJiASh
 l/BbS9zAc/9048DYT5ckeh8WOqzOSvnppelmWTW9qKYOaAcwyD4y9cEpR
 fcmt1+S5/Lxv9cZYJLlA6QhPYWP69dVhZTvgKWAKlwdnrPHjzJ8/Kfwan
 j3e1qPhjL5c1wc3O2CRx6HazK9uWjEParEAdpNQINRCeCTwY0/3Ux4Fk+ w==;
IronPort-SDR: wx6tWY61Eippq9bpbBEoCqM8BBKEioJaCxOam+3clNrPMl89flLM2ea0pFfR2KiuWjsThVDIVg
 pG9E0zd+wbw6E62UJ9aqYqk3Dm8y+UUymbLEO6fzsjv5FUrplDUFrswKXNpmU0JWRjjUr0yw1O
 J69tnxo5f4rPQNVwNND19Ipmhw/3QhgEycYzUsIJPiA7ewX9rLZeQfjjWafWgf/pPH/7saVMfD
 hHmQHFoAqTIeSOc2A9fbRTNp/S4zJCNpac2SFuFqG75xzHTXguqtwdrIbOFVsEPg91HL3eUUoC
 fP8=
X-IronPort-AV: E=Sophos;i="5.67,281,1566835200"; d="scan'208";a="221273242"
Received: from mail-by2nam01lp2058.outbound.protection.outlook.com (HELO
 NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.58])
 by ob1.hgst.iphmx.com with ESMTP; 11 Oct 2019 03:43:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNGBLYMrbXWlvOzSJKgyIPxoLkIM1e5QVTjgsikkRJnzM6J7zcRaRubQkkEz6Sn9XmOEugPqCHuB1+5JZE4iUHUo70goX66HSfEoCAFi9u83r17qXbnCxecoXqzLkgTSo+rULO86mJA8WBqh2D3rPEOA5toTbP4J9AbSI6U/1SoGrGlIEy+0pLRUHRsmf2rfgcdsT3JDrwFwQve4+BmevH1PQ5pMLQJRBaVMx/vaOIHcxMOQzy+Npig5F4ng8rPMbF8UL9WDvbdfIDbSzAaxOq822c8T3J53ySJLr5O7Rx4Lof/WZGBb57aGopN8ca5w3K5sZ7EOvN9NQhVuOPv1kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8BeluUL//MhlBFIlIoS/jeZHucQMYQkdtZGxR42DZA=;
 b=BJiHcQlGMwRuFk4Qmu19ke3BaRd9VmABA8nXACLpCLg8NdHMxtIcA7X/iupwS0UrUr73Pl1EiMTIjqtKqDJPN2SpH3UzNh8WXPkLvWr92FSGHOf80EJdQ+rf0DjZeuPdPX4yEVn0ce79KVpmICnAYEYfhhjF7Mq2t9dvR4/G0WCiIix/XYW+PVdlPaXVMf45Jo1rMrL+H4bYm3xMTbufr6DkvH7WnDYzZUDn9D+RUG2QHXLtPZUAs6ayr0qDeFJHhe0miJ9diujvlpfiHkcYTHrrRPEkFXYNi03FIOPf7THVY54ESQ7H1mwz5RTr2KX6Mi0SbApBUDK9M0VNPj/4OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8BeluUL//MhlBFIlIoS/jeZHucQMYQkdtZGxR42DZA=;
 b=RBPzSwy+q80KTutWdov0uZqhQvJEpflSiioqdbAWTpGTn96cHOtW0qY6LZnLsGywlF7GSVRqTDBUdH8mmJx7oA3Vm68niqqLfq4Krf2MUm5XJ8VkeAbhZM6ZRD+tBKjL1RGAI6fBwiuffGy8MM+++5SSJDFfqji62LOvLBG0MDs=
Received: from CY4PR04MB1175.namprd04.prod.outlook.com (10.173.195.148) by
 CY4PR04MB1238.namprd04.prod.outlook.com (10.171.245.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 10 Oct 2019 19:42:42 +0000
Received: from CY4PR04MB1175.namprd04.prod.outlook.com
 ([fe80::6988:d052:2b41:d002]) by CY4PR04MB1175.namprd04.prod.outlook.com
 ([fe80::6988:d052:2b41:d002%4]) with mapi id 15.20.2347.016; Thu, 10 Oct 2019
 19:42:42 +0000
From: Jeffrey Lien <Jeff.Lien@wdc.com>
To: Keith Busch <kbusch@kernel.org>
Subject: RE: Issue With NVME CLI list Command
Thread-Topic: Issue With NVME CLI list Command
Thread-Index: AdV/nKkBxaoD/U8hTdiiwmMsi0edrQAA4KUAAACjdLA=
Date: Thu, 10 Oct 2019 19:42:42 +0000
Message-ID: <CY4PR04MB117568F1F7120303A9168743EA940@CY4PR04MB1175.namprd04.prod.outlook.com>
References: <CY4PR04MB117531DFE8560BD3A72787CFEA940@CY4PR04MB1175.namprd04.prod.outlook.com>
 <20191010192318.GB22635@washi1.fujisawa.hgst.com>
In-Reply-To: <20191010192318.GB22635@washi1.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jeff.Lien@wdc.com; 
x-originating-ip: [199.255.45.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dea9dbe1-ad88-4d0d-9c54-08d74dba0418
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: CY4PR04MB1238:
x-microsoft-antispam-prvs: <CY4PR04MB12382A8E2FFBF4A74E2B4B4DEA940@CY4PR04MB1238.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 018632C080
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(199004)(189003)(13464003)(6916009)(229853002)(6436002)(86362001)(305945005)(9686003)(74316002)(7736002)(33656002)(256004)(71200400001)(5024004)(14444005)(71190400001)(66066001)(55016002)(8676002)(5660300002)(52536014)(8936002)(66476007)(66556008)(64756008)(66446008)(66946007)(7696005)(81156014)(81166006)(2906002)(478600001)(14454004)(26005)(102836004)(186003)(99286004)(6506007)(76176011)(3846002)(316002)(11346002)(4326008)(486006)(476003)(25786009)(6116002)(446003)(6246003)(76116006)(53546011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR04MB1238;
 H:CY4PR04MB1175.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ny3FzyjbnVoN1TVrWx5PWKjPy592AtO5dCnxD1cGRGmETZmg9S+9ZlAacFlNKjZCtTuWvSj73GXt5GLLBBh6A7QJ+Gac65mPbgJgRtV0FzbujyFJyEAXdDAgAYeSsOsUKkwhxHuIk9eW2PiZdPZMyMeENPkEphx6LzlmhnbFAGebZU+l70Mnd68qqJZjzrOFh8ikXie3wHzvVAKamOzzuR2Z8+0xMxj4wn5In5W5Ssp/G4gZ56poslPUVUOmRhyOzfP+FHv+Ar4Mx5rKRuJ13i9jbIeim/b5UkccwW+9/K9b7PWCdyC+UZfy+RfkD3tAILzJhDBTKRg5KQXGtL1iPG5A3IG+c1KA58Kg3nkJC+CPw2isdMwwXEA5zT1dTxj4HiyMmaDk/18jK/yMCjtkglGfZPgJIOH/ZS/3awFfydQ=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dea9dbe1-ad88-4d0d-9c54-08d74dba0418
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2019 19:42:42.3232 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YTR20Rx8sdLeYO2IcZNHakWhdJYQQihlmH9K3XtObcazfQbi6b4KQsuxiMvFrKIgNeQnLSB8EtbYjSUD/6ykmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1238
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191010_124244_190430_24A86A10 
X-CRM114-Status: GOOD (  16.90  )
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

Keith,
Redhat 7.5, version 3.10.0-862.3.3.el7


Jeff Lien

-----Original Message-----
From: Keith Busch <kbusch@kernel.org> 
Sent: Thursday, October 10, 2019 2:23 PM
To: Jeffrey Lien <Jeff.Lien@wdc.com>
Cc: linux-nvme <linux-nvme@lists.infradead.org>
Subject: Re: Issue With NVME CLI list Command

CAUTION: This email originated from outside of Western Digital. Do not click on links or open attachments unless you recognize the sender and know that the content is safe.


On Thu, Oct 10, 2019 at 07:11:10PM +0000, Jeffrey Lien wrote:
> Keith,
> I'm getting a "Failed to scan namespaces" error message back from the 
> "nvme list" command after updating my fork and picking up your changes 
> from Aug 28th.  The cause of the failure is the following check in the 
> function verify_legacy_ns (in nvme-topology.c):
>
>       if (memcmp(id.mn, c->id.mn, sizeof(id.mn)) ||
>           memcmp(id.sn, c->id.mn, sizeof(id.sn)))
>               return -ENODEV;
>
> The problem I see is that ctrl info is never filled in (at least in my 
> case).  Both c->id.mn and c->id.sn are blank.  Looking back in the 
> legacy_list function, I don't see how the ctrl info is ever filled in.
> Maybe it's just something strange in my case; I would have thought 
> someone would have stumbled across already but maybe not.  If I remove 
> the above check; everything seems to work so I think the code is
> basically working as expected.    Could you review the changes and
> either confirm what I'm seeing or let me know if I'm missing 
> something.

Hi Jeff,

What kernel version are you using?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
