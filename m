Return-Path: <SRS0=B4mB=DH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6763C4727E
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 10:05:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41D012074A
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 10:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q0DPzmjF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="A6i0Sj64";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="m6LUzaeT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41D012074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9zp+/CnsL+UeG0ZPwBKKk9pGtputQhy8DWYFBS5STVs=; b=Q0DPzmjFAIanpTrSRNtdbOBVr
	XCWqjsCxcB5kIZKwIZ/VQ/JMcNOswCVwh975wsPypSoKv5n6MaHanSQNYGtUam2Pm8/sxtIHAXigW
	+VkxEW71wq9bXBj7F8twbWB5hhKTlLIwiKv8S1VPKlAxdlyozrg38u8HRH3WeRzEQ6seBPiK6h610
	2ShTgvbWCkOJIfS5JFxgtBaH+Mnkbj1v2orExFvqTCGs01m3CGJwj4MDJH0iE44mje2kXIzrMYFTC
	/3JuPpugr8LVQZ6ARiK76LJM3EARNR9lrOr7DQXh5n4pL0vxeccHf6hTRk+Wv7zFp8Jfr2lFj7Def
	w6cWAwf6w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNYys-0003ZU-FD; Wed, 30 Sep 2020 10:05:02 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNYyp-0003Yc-Le
 for linux-nvme@lists.infradead.org; Wed, 30 Sep 2020 10:05:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601460299; x=1632996299;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=9Q/xL6qEpcst4z3oFhZLQ+wwyQyCHzyXPFY6qC2cPZY=;
 b=A6i0Sj64ZzZ5XvVofAmc484VQoFKPJnkbvhFE1Cor4CkQNQQCTFr8GEL
 hrpfzaTzeMlMaeCRTZqSsIQi78/cW+5J40kaKOtrEtYIIUmgxPYDNUvhm
 AZXBZMfmnqhqzklNM7pmU0zebsMmEmTu4YSjHCEY3xWAkovabnFJxVFXr
 E5U/QM60w3LXhNO+EwQUAzocrObZGPGhtR8tCFFww2fCi+YM/DNuGixrN
 eghVNiPoKjOjDg92DUcYt1jsuj+Bui6tnTUDmWbETjKMvptCB1dX/AhGQ
 MDf3YbwEPohv9OOJTvi2/r61N57CAdNA439QyACA7PgQ7ei8DcQB9ZE0Q g==;
IronPort-SDR: xn/in5nFFXeRt7OTlFzMWm+oBEAZG86/A/ZCpEc9sCR86dIqO52ZfmmS2L4+qTaGfmfA8OpbN5
 9sX3PIuwu022Haym8cfnAwvGSfznysqowcJjgxssBOf/8WjrGzdw6yJGa61bq9G6CFHGl3YrE2
 ZoYR7Nbhn8B2/MmaR1DbBs4XP/RoDTdeY2/PyRKpCSXbTQJbyWKIfCBsI413EQ4glgL4GuBN1v
 WROXkV57GVBsejh8ZmBBPUL/67rV+RVudyyPgI9ZXzZXYYD7PXPr/394TVpbR1f5qJCIRT1DIt
 Xaw=
X-IronPort-AV: E=Sophos;i="5.77,322,1596470400"; d="scan'208";a="149863684"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
 by ob1.hgst.iphmx.com with ESMTP; 30 Sep 2020 18:04:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cggrP5faiL0M0zSt4/IXpRj1FMR6vXNBx3rgwzqE0oNz7mDlyl/ybTpliESvsBLoQYlpP9FNsbkDTnD3iighq7STChROHHFlmVxpqyBoPUbJsMrcMgP59O4wfM+YHqNy9pnH90ZN9Bs1UAjRU1dktTCJ8RZqVuM5xP8QcA/xfJFgKmFSRcqnAGa2BN0VBCARDmzXjwX/C+DotTpSxVIo9z2hwPrb2hB/CFVyl1sDEj37qPc3oawocuq0uqiDp5aBSZ+1eQwbQccL6Is6p50RMwF2EEF3kftk5Ue9Z0iEwLNW+za1IpUxqc7nxAmIF498d9fKswuRYNoZdU3bez/qQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WmDUVsNP4OVrudYEIxmLMTF8Ao8lDWOgTXRMzGftWg=;
 b=fRcb++GXGRbcQUhPjy/14Cci0NHSisAwkZJSw+umPcLLgIsu9b8jM2c2rQplpVHidstLPT1pAwGAfMkXKKvrpG+Z/7MMoyuRXkHMSg05QdAC43jQw4ECjv3rbGlbBQJJfwgCSIsZUsP+CRAA/UnQzRWMN5vm6tyaYHnzGRNZ+AQqFBmJbF/N0frQrkFDI4D7JY2uLhsGdmbdRI0VDq2iH5eNau3QjilONVOT+K4BsexuHmjDsxy9bUKL1lrB+buTX2YQqkSZ9Z6/Folx9CFrPtdBkkECzxQ3+8kQUMhPf8/OWfOfmppwH1tZcCWobYRA1Xz7V17UR5s8IYfVPony/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WmDUVsNP4OVrudYEIxmLMTF8Ao8lDWOgTXRMzGftWg=;
 b=m6LUzaeTD4H6iaVt5VYgWaJePPG7LPhzaZkIizu98vTikdWoISZIh8lKG6qp3yI3mZaWvLYPbO3EDjFDr6LV32B66sptgIPN8tY0rhTQJLuK3IMiTNMu/GHGQOgGxXzyWm+a6bmhwsF/2eSR8RKtR38KAkmxBeL4W8fgCxQrxaQ=
Received: from BN6PR04MB0724.namprd04.prod.outlook.com (2603:10b6:404:ce::23)
 by BN3PR04MB2242.namprd04.prod.outlook.com (2a01:111:e400:7bb8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.24; Wed, 30 Sep
 2020 10:04:54 +0000
Received: from BN6PR04MB0724.namprd04.prod.outlook.com
 ([fe80::acb1:47a4:73ba:69a7]) by BN6PR04MB0724.namprd04.prod.outlook.com
 ([fe80::acb1:47a4:73ba:69a7%9]) with mapi id 15.20.3412.029; Wed, 30 Sep 2020
 10:04:54 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 17/20] nvme: query namespae identifiers before adding the
 namespace
Thread-Topic: [PATCH 17/20] nvme: query namespae identifiers before adding the
 namespace
Thread-Index: AQHWlw5AkP94OOyeD0CkZEE29Sn+/KmA9CuA
Date: Wed, 30 Sep 2020 10:04:54 +0000
Message-ID: <20200930100453.GA191465@localhost.localdomain>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-18-hch@lst.de>
 <20200930094411.GA189371@localhost.localdomain>
In-Reply-To: <20200930094411.GA189371@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8d493f09-20c0-485f-73d2-08d865284791
x-ms-traffictypediagnostic: BN3PR04MB2242:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN3PR04MB22424A01201FAA1C89E45856F2330@BN3PR04MB2242.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:962;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QpZbFZEmjBc43QeFu5R15ftJwAOBQspQdDuY/emveYFG37d0nZETZwiKEWBbgdPPoIJ3zw+laraW0mObC+NClrFL+CnTIUEuCA4oaZCGDvDW5PGzVt8BqAAVia+dXjTfcZL9HeCAqzekcEnMfQgU7zCr4F5M40p2vuNgvqEZUg/ZdO4qrpRaqQoqSI7jjvu1pPRFb9TwDD0q1d9r/OOu97VY8fBLENpwKE4IEmFFsusuPX0ouqHJFx8gLjb77LgijIGu6nXZgmgl+xweBHF0ohSQsJedU4XZJ5j85olKevyhTKbOfPbrY+p7WYTxrc3H9oAFLf2YvWrL50FGaq0JObPyMrifJL70hPb2R2XbCGT/sBbhfL2K+snDJhWANrxm
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR04MB0724.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(2906002)(478600001)(8676002)(4326008)(6506007)(26005)(6486002)(9686003)(6512007)(186003)(54906003)(6916009)(316002)(83380400001)(66476007)(66556008)(64756008)(66446008)(66946007)(8936002)(76116006)(71200400001)(91956017)(1076003)(33656002)(86362001)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: tmrE0fbwOciRBW+1n8Y2eD7YdWvDaXmgAEOmuNFEMJJDs8f53HfiHCYf1t44plcVy5N+6IOckRQB+12AHU13QQCJdZEONZNFwN7woXzu2/52odJ/mkZ10mP2l1SiAMgP7RQgyXEBwLaPf5+aHbX41L3Rz4xRU+pugF+jMv1XZy9nTLtJ2p50xEM/OW6NdJGWvBfYdIXPo4lexvSqTzuRZreE6tbZrBkGo1yY/uLJFo6Wi102i+XOBWUiFDfZ36tgrnpRXLsIB1lx6HwVRfEqJU9zXeOYp8m9qwQGCUaxDSs2VfIrD/D+OAAFKzeUoeDPnLLULnDAU3oOzNX1D8LywkCsCIGeKYy/Jt5hfPJNKkWysy1LVWdE/FELXpkyyekwVRZ4Uhzn1sG6Y/aCEWgw1Y3H6wLNkmbTOnT1tzR1tUvxWG+GDAmUc54zzxSR66C/KYxhdnsgEluqzbdzf91IS/eFcMaZc2RAoTsy7DZ5+4Nql6LYg/npVfLYzQa+q1+fpg0vnqho8aTA50uiUNd1/WgXZLCoKo8GvOqbrUNTyK2DNv14yPLtF2eCe8b7CZOrcFijexp2J+A+hbYdmiKTP5Bz3QMR1beMIqniG84h255bAO0NYHo8syJdVQx4Byy7oTlvrIwQ/hBtK1xGWl9yAQ==
Content-ID: <D9384AFA03611E4C83ECEE5DEA5A3477@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR04MB0724.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d493f09-20c0-485f-73d2-08d865284791
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2020 10:04:54.5597 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1YWOzsn43LNpXeuNL1xNfI4BJr4JS5gxnCuLtpULMvPxZP7qphKBWAN65TSp/5AbNTrXdFdqdHnHiilx+goSEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR04MB2242
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200930_060459_886287_09C9A5D6 
X-CRM114-Status: GOOD (  24.50  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Sep 30, 2020 at 11:44:11AM +0200, Niklas Cassel wrote:
> On Mon, Sep 28, 2020 at 02:34:59PM +0200, Christoph Hellwig wrote:
> > Check the namespace identifier list first thing when scanning namespaces.
> > This keeps the code to query the CSI common between the alloc and validate
> > path, and helps to structure the code better for multiple command set
> > support.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  drivers/nvme/host/core.c | 116 ++++++++++++++++++---------------------
> >  1 file changed, 53 insertions(+), 63 deletions(-)
> 
> For the subject of this patch:
> s/namespae/namespace
> 
> 
> 
> In your v1 series, you had a separate patch for:
> 
> "
> nvme: remove the namespace identifier verification in __nvme_validate_ns
> 
> None of the identifiers (including the new CSI) can cange over the life
> time of a namespace, so don't bother with the extra query here.
> "
> 
> which now seems to have been squashed with this patch.
> 
> Squashing it is fine, but perhaps you could add that information in this
> commit message?

Hm..

I now see that nvme_validate_or_alloc_ns() in v2 of this series does a
nvme_identify_ns_descs(), while nvme_validate_or_alloc_ns() in v1 doesnt.

I don't see a change log, but considering this, my suggestion that you
the above sentence from the squashed v1 commit no longer makes sense.

What was the reason for this change?


Kind regards,
Niklas
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
