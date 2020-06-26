Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9C0C433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 11:31:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58A81206A1
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 11:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MoCDgw3F";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WvDvaPEF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ATqIXtUf";
	dkim=neutral (0-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="OVH2xSLm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A81206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=JjMOv0qyYtgCA0iRF0K8L3xArwFAHyx9Bdbr56EUeIw=; b=MoCDgw3FuHJ+gTY6lDlynMFNX
	KgO0lglsuFscxKxmnn4UlFVtHhnVufIYOUK/taB7vPOgCg+dO5sC11NrMXdbHZ6SMTwXYXXUfLBz6
	QDyFgg0SINnSml1v8dvskZf/zbz6UKWYZicDfJ9rZ7zTXFOE1rzh9mBoE+4YGtiR1i49+jTAx4NOh
	IwaI5yB870up94ZcHsSAp7tlgZPVc86ZZrsrwB+ZjCf6S8H1D2+x3BkvwGIdB8GyHQZq5NvOXPCKF
	oeFtcB+Mfy9nIEkOjy3fTuTTtYFCxa7RkZQIs/mREJ8e7TYS7YMRKR9rvbkXgiSpEZUs0qjijxkjl
	YNQRDPjDg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jomZS-0004Ry-0m; Fri, 26 Jun 2020 11:31:02 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jolGQ-0001wR-5r
 for linux-nvme@merlin.infradead.org; Fri, 26 Jun 2020 10:07:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To;
 bh=q3ZGOpdmGykzK6Fz1NrJwuYDbgcCPK4mpSU83RhsJDo=; b=WvDvaPEFwtjWzXK6kkb+KzJXdY
 FfLNe6VnMASy1pGs0rh8PF5uhgql8T7i36sULinbjhJDGs1oFjb581lr7YuiU/Jub09gIORHIWFXe
 ym7/XVo+tDmeacbUYG64OmVNduMYQTE8pM63fWelDw6SKkDkRqE0Kh2fVPooqmjUvD/8k8HPJWGqi
 sWLHddMwPEiyNC6TlBMjr/lAaxVSR8JLeptSN5gfUJeyPtr8z4bTyN3wvajafYSpo4CvImsUS8W9y
 7r2bN4my1QSxfNZIS/8dNP2cqqibcrp0fHM0mYkbn5hpWQkIDuWok7Stv2vFv+fS9bFVU0s8sJ+AL
 oknKC7Vw==;
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jolFp-0005BZ-JN
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 10:07:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593166001; x=1624702001;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=MSesirUQ6urRk5pEvK4vW36s6lDxR28nW4Pbw4yIIbo=;
 b=ATqIXtUfPtL3oEtMw28hu8aY1+EsbMLUnWLTk70kWWOSV5vARKl1uAYU
 63liSgNrW9HIYBfxCHpyBqqOXjrnbpDq9NyI0m75XUOzmjF8Vl0Vpc0IX
 HPpb+AMVLMwZAGa5fzOFPJRriZoMhUnuNb6qOooPAA7XMp5BYUeC79fUn
 2VONG1/mTTnidqw0c4mfrdWjvW8vHUnJ2FgMu9NIn89l4aW4S/1d/HUXE
 9ZtyedjIfyMYNJZBx56VPbVqD/pWtKMjlenvnE0viWeMAdCFageL3S9wx
 YF4eeMLod57XVXF0L2MgGUJfx6Ni2Z7PiJJuMs/yqsrBM4AaSXHUe5/cK w==;
IronPort-SDR: cq+eqDv7Q62CmzVqcvj3ip2uNcQYe0UOnCxkBFNwKPkSNMA3d80nNxmPI23lLqZ3np2RsjNJ/g
 EneyhMVpJbS2ZSWHpchf9cDqP76M3Y9WpDYmDtGf89Ip26d8IJuVmSFJfPd9L1A4zNzo23oy0y
 5FIDRrtFsBvtq+au/RA1ZsdgRS2sBGeA/A11CSeoIUljJKAoho+sxi0O5iB4T+tAf3rvcs+U6p
 DdGesOZLVcIuH8TcjTY4sugV15jGRrKKogFbucatAX2f98kluYHmZ/FNbDZ8pHODTd+A/nj6ok
 bso=
X-IronPort-AV: E=Sophos;i="5.75,283,1589212800"; d="scan'208";a="250213706"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
 by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 17:15:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNOCxlNAXGSdPw8dOMdD/ZqGV+x559sD3BYwquOmSmJ5idFxEcSYxwRo05CW0aUHC0YPeds2pWXTW7A7hYXQB8izMOayDV39WO17MSAQGFaq39wBGBfjPS5XUHiqqdDxoKqLLP5FlJeP84KXBp5k3q3AtV4z0SzlJSa6Doc+znTNxLOUOXeJUaM3XOF34gZ3UeCpsXRZUzCc5uXNy/XFMeeSZBvO5ix/WbXXUhvsF0HbUQWVF7sLTS6B5DVGeOUpw9nf2zWGnZo8XkUfna6msBLgBdpNK4oxbwc84eU8jWnuZrZ3JeoEBglScJ/tlHA4YlL9cLas0cn31KqMMhOxeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3ZGOpdmGykzK6Fz1NrJwuYDbgcCPK4mpSU83RhsJDo=;
 b=m5/z+eYs4/MFkI7gLDmNiwp1GxPXYaj4xq9rnOjyhTeqf4l1yM4g1enDGbzQyzCLMDsdiHsha4asHDLJL0+g8QQDrGLuo5/Y50nlclEfdrOhS1FAPMJb84nMrzBwxzGXRa1KoinULgbdeAx+yC2+fVC2DE91WIf59TachQiqdCh2Bflf1cpKz4Biqg656LYmsMZKTtfYMnNtEhq5N6ffjUxztDv8RJXLVIT5BUw9iV3h/f4KdBQ0Ihyk8Gdytzh8P5WKb8uj04mWE9jmGsPc/pYqlxLWpE+oVMMasWZTdRfCHxVn+w8pDXx0NQHGh1YpiV8aH7SNfFbR+S4UPl71Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3ZGOpdmGykzK6Fz1NrJwuYDbgcCPK4mpSU83RhsJDo=;
 b=OVH2xSLm7ZpzEdwDLQbdBFm5rFxXs2kbeYTFhBMBtfVlY+QABJ5kjhpg892KxMed93BBY0WLjGqEkS6varz6A9AaF7kc2k7ImaknYHGgWbH3QownlBtLYkiPRO1hZ1YW3eQNxyWgQvetTCnD3k17MJujLb/77RRX8nSdkYTkGjo=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0248.namprd04.prod.outlook.com (2603:10b6:903:36::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Fri, 26 Jun
 2020 09:15:14 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3131.024; Fri, 26 Jun 2020
 09:15:14 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 3/6] block: add support for zone offline transition
Thread-Topic: [PATCH 3/6] block: add support for zone offline transition
Thread-Index: AQHWSutT3xCQHGem9k+D54mKrpOEQg==
Date: Fri, 26 Jun 2020 09:15:14 +0000
Message-ID: <CY4PR04MB3751E3DF3A1BD1FC77E6C101E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-4-javier@javigon.com>
 <b3429226-16ae-df3c-38aa-50e3a8716e71@lightnvm.io>
 <20200625194835.5hojuvdwtjxtso2l@MacBook-Pro.localdomain>
 <CY4PR04MB3751E7721E5D5E15065B0ED2E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200626091113.GB26616@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c08c900c-c7d1-4797-7cfd-08d819b16fac
x-ms-traffictypediagnostic: CY4PR04MB0248:
x-microsoft-antispam-prvs: <CY4PR04MB0248BB10000F5139D1566BA2E7930@CY4PR04MB0248.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q3AhdWEqV7TQR3KXMMOZjdy4bipZaehPAA3XjPZiO4uCEnZjoEpKp8Yf94Ag957Pf37anCvR0p1uVEJEYsG+SOer8mvpV7qlnZeAJRuHLNhwflwlvSIivYjckI96CZHRpiEm+7u1esejzQW2JnBI4yZr8U1JOK4r0JC6bS0kfN3B9VcG8ZH5fBt8U2xcYwriHuMJiZYOE02vO7d2DMZstnoWqhpbzAUJtRSuFHevNsWSqfLJt0yHXEtejNIdJbGbKnNAroUJozdW0Q9UPfVzcABC1/Lv+VgMB04eO8DPFQoxgVFf3CH43zW9ESiQCV0H
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(71200400001)(66476007)(52536014)(91956017)(186003)(2906002)(4326008)(33656002)(83380400001)(6916009)(86362001)(76116006)(55016002)(66946007)(54906003)(316002)(66556008)(8676002)(478600001)(9686003)(7696005)(64756008)(5660300002)(66446008)(7416002)(6506007)(8936002)(26005)(53546011);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: aoRpjNHiYEfyptG/I7lgyojohUyyLrdHDNSZSu5gMxX9ttE9OwC7M9R0nyo7EYUfjUAhfmK2Dz9PeTzRr6gFuUzq87LjUSPrNP7rWYtJHbcjZSaSz5kPFqWyalvXI1G3/mcZUx7v+melOuq2qaBPd73WwG50rxOzpgzaJRMOrQes4SFL2nmp6E6KuH6K8CDALbVFaWD6pAoAWIL5f9pvZGHpzsnKgRwNMdOc62K0qpiyc5qnA5YE+iYEIgBg8wDN/R8+Z5AuvIMrQL64cI8JI03ouf04xisitm7YrmkHxAkMmO+LU/nDNEQxnWAx6ZV/eq4TQNU/Z6BLEBKWqsiinCKkvSlgUHqxXRFur6BHmGYBpg6oon/zBHL6CHuLphyTwzyxst+5Fh7OHLjmt3GwpAogrN/WA5A0fm6kG6hKxJOcMvwtX3E5e2cr90dpOk7G/tKqpQD7hJFSA4SCvtazS4JsaKZ/aMXg1xZ+e6Bpj6UKLYBam6yKSKl7M5WG3xCr
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c08c900c-c7d1-4797-7cfd-08d819b16fac
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 09:15:14.5646 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SejZewhKfGM0uKgGc+jCNZu3i81hoUQ6PFC3qChfOPpyCebIhCYy3mqfIU8GU8jFB1mugGUzpWsn/jgeD9KooA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0248
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200626_110642_866579_CAE5B0E5 
X-CRM114-Status: GOOD (  19.82  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
 SelvaKumar S <selvakuma.s1@samsung.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 Kanchan Joshi <joshi.k@samsung.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
 Nitesh Shetty <nj.shetty@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/06/26 18:11, hch@lst.de wrote:
> On Fri, Jun 26, 2020 at 01:14:30AM +0000, Damien Le Moal wrote:
>> As long as you keep ZNS namespace report itself as being "host-managed" like
>> ZBC/ZAC disks, we need the consistency and common interface. If you break that,
>> the meaning of the zoned model queue attribute disappears and an application or
>> in-kernel user cannot rely on this model anymore to know how the drive will behave.
> 
> We just need a way to expose to applications that new feature are
> supported.  Just like we did with zone capacity support.  That is why
> we added the feature flags to uapi zone structure.
> 
>> Think of a file system, or any other in-kernel user. If they have to change
>> their code based on the device type (NVMe vs SCSI), then the zoned block device
>> interface is broken. Right now, that is not the case, everything works equally
>> well on ZNS and SCSI, modulo the need by a user for conventional zones that ZNS
>> do not define. But that is still consistent with the host-managed model since
>> conventional zones are optional.
> 
> That is why we have the feature flag.  That user should not know the
> underlying transport or spec.  But it can reliably discover "this thing
> support zone capacity" or "this thing supports offline zones" or even
> nasty thing like "this zone can time out when open" which are much
> harder to deal with.
> 
>> For this particular patch, there is currently no in-kernel user, and it is not
>> clear how this will be useful to applications. At least please clarify this. And
> 
> The main user is the ioctl.  And if you think about how offline zones are
> (suppose to) be used driving this from management tools in userspace
> actually totally make sense.  Unlike for example open/close all which
> just don't make sense as primitives to start with.

OK. Adding a new BLKZONEOFFLINE ioctl is easy though and fits into the current
zone management plumbing well, I think. So the patch can be significantly
simplified (no need for the new zone management op function with flags).

> 


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
