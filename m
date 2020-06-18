Return-Path: <SRS0=0To6=77=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B854C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 17:31:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A92520656
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 17:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BtCHTftH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fG/NyiW8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="EHsNAyFb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A92520656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=SXWNPKqIMOuL03AlgFKDk9k/guDGtCTiUHfNDSnKDEs=; b=BtCHTftH8u3ZZT
	NUmkyujORaXPIZ2vf/CG/lvf0ujKxbPgRFKgxY+1cxAW34p6F5ULJhCI1IJkHldBrnO3wo4hup/dk
	yt8InO4EJZHLcLMsjdiANFym78s6zodWDhIqWO35aSPGlhIY7FvhYvW1c0x5lId0YekKMe3XZ5XF2
	j11R4zB7AN0SPbk/k91K7Y5THJIG0xLZkhoYFGjY/yuNkjSexb6IQOBehjXzLQ3jpjZJu/f5QxQ/i
	NFS6GxX3dHDJmi0TEaikke+bZFomMK2cO2j/00XeI5VJkRLAX+cC8pAkiEmhOOF3eFn6jPJv4r1t1
	TXreKleO9B0gIlrhcVKQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jlyNk-0002Hc-0u; Thu, 18 Jun 2020 17:31:20 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jlyLY-00063T-L3
 for linux-nvme@lists.infradead.org; Thu, 18 Jun 2020 17:29:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592501355; x=1624037355;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=65fATkcGX1XMV8ZqADTopBjp7U3D4XZZb5sTGqRsBAo=;
 b=fG/NyiW8w7hfD5z9F+VGEjgaEusYxgg9mU7+E0Gr+TTx+QagPpSUtfHN
 5fZGzepE2coo5J3bIwrsjBMhn6m7QG/B0R6Wnew9BRzJuVGeGGEng/GWg
 T5yiQqByazEl/Zz4Xf3mbxO+OIy8H1soJL0hdP8M6MPr9n1dN3ul6ROjx
 kAR8/byCk3UK5ldIPeN8BhptkCvE37agBBZ7leYo7REEstshcKKUGyfyg
 W0LMPft3FLntOeTmX6j7IEEUVY0LBTgoQcWHZM+6wn33k8QIuWeF+ZwVb
 jdCoF/X8FXywZfUD7w1tiUbrvP7NxMJhtVRMhY5Yi8X3yq4t4D5EWcZfz w==;
IronPort-SDR: GAF8GbCY2sMUDvs6oFDte2kMBtM77ZrZoggvsxxBn7dItF39O849VXdbaKEJslbY9JF+p+2xf8
 A+FKED8ex8sCU7BqJhU62Y5q07XogkBucjBTcbkrXJgHTCkUXsnPBN5hNWvJWat7TblslnM8ak
 5FXGJO5HbCklT7XUkIKaYZtaF1bauuY8cN7aFVDbdKCE4FjU3xes54tWGGQt24kUtId9HZuh9T
 3d2AaYREH2Ak+8Ma9+4gqaLZDnwNCNFHWmM+m0GOERNLEgWh7Z/N+k36C+j9hSWjOc0z8/XYxw
 MQ8=
X-IronPort-AV: E=Sophos;i="5.75,251,1589212800"; d="scan'208";a="243303844"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
 by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2020 01:29:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MaC/dJMMSKZqx7RvYLrz6icf+c5qcmaLjmrAdeb9vV8lwkt83FI2XzTidq3ugQzzCxlai2gcgRkNTQuRdhkGbv+BdZimuLPojCvjnpR5rxivYZewKSbBUQhCe8z0kvGm1pW3P2HxD16QoUo8NF+scwmAi0XEyO0xAaEqIkMkzdbcG8UhU2gpw4C6m2wOGl5cEhGZWhf3ZuQLO4tRLhL0w6QMz8pmGi1YH0XeQ8vynHOJvegxCX0QmUhF/WSJO1CNjuCtioVV+9pubXr7/eF8Nl2oczEno0gLGNO/wKo1mGRf4WXBhwUtjo91wGXeveQ2oN2IM2QZLYTNVNNk3aIVYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2pKAGXGAjeAxpupRWGLgSEORk+y91EzQzS3dSarqH8=;
 b=oNS62eV3IkbGIcROejSQ2VUQUPmts8xVZ41rX6rwHyMBDcJFWVpyDP5N+ooZvrL+ikjTPMVB+gEWpVrCtC/eLD9ZNPRHg03XHXaEEyx87Cdwh1f1fshnUcxkuWs+Gp38YXlIGC4nqfGLB6GgwbW4xa0P/Tno27PtagAlChFQoJ6jYFiQ5t7GfNQHv8W9JvDRaryloxEgarYMPnjjOjX3h+97YR4YOBAWpW7HPfePlEbHZt0oSbbGfzor3wr7WIntmbCQ1MEfn51DkpSgqvPPuU/+4q92qLsnbmvqQRUpBjVHZ8dtzg16m1B81fNCDMNZrjQkdHvZJtK4pqvgvrBmQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2pKAGXGAjeAxpupRWGLgSEORk+y91EzQzS3dSarqH8=;
 b=EHsNAyFbKdRhtl2SSi3JC35bRZmedihATI6t17XhHexAHXU+BmGxO6nXLF2pTjkJ8iVRKMtnqAsxXHOEysIO9X8mqcyzrsG20PCoDk2kOS31ZfQzNNUSLJIJN9tQVV95+/H+J3rmwb4vSrT/gDsBHbZiSwP6XOSnozEPHjW2Hmk=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5032.namprd04.prod.outlook.com (2603:10b6:a03:44::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 17:29:00 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3109.023; Thu, 18 Jun 2020
 17:29:00 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: Re: [PATCH 2/2] nvmet: remove workarounds for gcc bug wrt unnamed
 fields in initializers
Thread-Topic: [PATCH 2/2] nvmet: remove workarounds for gcc bug wrt unnamed
 fields in initializers
Thread-Index: AQHWRX1ZyGByOih9fUSrbaAjQMq7Ig==
Date: Thu, 18 Jun 2020 17:29:00 +0000
Message-ID: <BYAPR04MB4965AA7B57AC6B6E19BCBBA5869B0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200618143241.1056800-1-niklas.cassel@wdc.com>
 <20200618143241.1056800-2-niklas.cassel@wdc.com>
 <BYAPR04MB49657026BADC613CA83CB896869B0@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20200618161509.GA1059668@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 385760c0-5ad9-4477-7bc5-08d813ad16de
x-ms-traffictypediagnostic: BYAPR04MB5032:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5032D4C407FAEE9F8923A3DA869B0@BYAPR04MB5032.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HRdGICNiwgK6P9SrezoEiLTNLiwGO8msAxOUxCPdlJpienveRK9EqTcTPAAp/uG5iOMkpnD1klIRex4K1bXayVH+cGZN8tIN8J/OEFbCUsA0iNVcU0YWXLbEkFewCRLX45K1B9gEn3C2RxLYOM5dbrGkLf2UaB1hiON3iCcTImL3avJflb99eAvavGKoI1vBIpcT/QcdwbTafNaMTWuIMO4Dwz28QygUZh7ab53sP0me246EZbJzaWw1WuokNarMksuXGU7Uvzrd68IcfvoA9LzsO6mZM2ak7LsKg6Tb3aA+I5IUuhBNJ+CoUM90V90oE+mLEtXDluqfzGf5enyhhA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(396003)(39860400002)(136003)(376002)(64756008)(76116006)(66446008)(66946007)(66476007)(66556008)(54906003)(478600001)(9686003)(316002)(55016002)(6506007)(6636002)(52536014)(4326008)(86362001)(8936002)(186003)(5660300002)(2906002)(71200400001)(33656002)(6862004)(83380400001)(7696005)(8676002)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: Kg8m2E+DfNbCwXAFrtbCRRn2Gasxw7iRTljJxUQZmp/2ReGtN3d4xvujOK4hBugGbYx0BTujUUgvWT2EBV5tRFHL4qL7UPq2MT3rLp3DwcMfl1tgU1yNU7qvjf7jJtIWPPFLbAjdVYl9Aehs87wdDGjeaRuLvgWmwSZGqjm0CrCQ3vLO92AyonEZNkW/IOlW7Xed7oD1tjFwd2uPYoUs2+C7LUHC00QPJ0e4IjPb9jdYfv5jygVuyFTrYNXkN0/QfXLd97ENn9+v0GyISsDb59xSyqIpXQ+MoWCm4bGJuu/MhfxbmHO4qWtdzgqJuAw777e7BGM7ftIiGSbfBLoXeWs9NAUedQZUOpn6hniZDxsqpe8S3yVN+DWWKxITu9ciAlzHIwFeHW8rB14ecSBuVTZs+CJpr9sdII9MTkWBWM8e36ft/qjclZHxc5CeNjZ1E+fOmv/v2/gx7HKTtlWl4MvZJQAQLcgJaeTZUTqWh6Y=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 385760c0-5ad9-4477-7bc5-08d813ad16de
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 17:29:00.5315 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TYtemYXtOtzOq6Jg4HAgEjweYlr84bxJuPxJc4zoENwriFwFbxUk+8qIO3pQzdIBrVNEByNolvkbSjQ4brf3hsgKKmXGIqQ9SR/tcuHDRz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5032
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200618_102904_814836_3CB4246B 
X-CRM114-Status: GOOD (  22.55  )
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
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I'm  not against the code cleanup and it always welcome.
Please also have a look at other comment.

>> What is the issue with existing code that we need this patch for ?
>>
> 
> Hello Chaitanya,
> 
> This is just a cleanup patch, no functional change intended.
> 
I can see that.
> It simply performs the initialization at declaration time, which is how we
> usually initialize a subset of all fields.
Absolutely not true in case nvme subsystem.
> 
> This is also how it was originally done, but this was changed to a
> non-standard way in order to workaround a compiler bug.
> 
and the existing code matches the pattern present in the repo no need to 
change if it is not causing any problem.
> Since the compiler bug is no longer relevant, we can go back to the
> standard way of doing things.
Is there any problem with the code now which mandates this change ? 
which I don't see any.
> 
> Performing initialization in a uniform way makes it easier to read and
> comprehend the code, especially for people unfamiliar with it, since
> it follows the same pattern used in other places of the kernel.
> 
This is absolutely not uniform way infact what you are proposing is true 
then we need to change all existing function which does not follow this 
pattern, have a look at the following list.

In NVMe subsystem case there are more than 10 functions which are on the 
similar line of this function and doesn't initialize the variable at the 
time declaration.

Please have a look the code :-
nvmf_reg_read32
nvmf_reg_read64
nvmf_reg_write32
nvmf_connect_admin_queue
nvmf_connect_io_queue
nvme_identify_ctrl
nvme_identify_ns_descs
nvme_identify_ns_list
nvme_identify_ns
nvme_features
nvme_get_log
nvme_toggle_streams
nvme_get_stream_params

Also here :-
nvme_user_cmd
nvme_user_cmd64

Last two are an exception of copy_from_user() call before initialization 
case, but we can do copy from user from caller and pass that as an 
argument if we really want to follow the declare-init pattern.

In several places we don't follow this pattern when function is compact 
and it looks ugly for larger structures such as this example. this is
exactly the reason {} used in nvme subsystem.

> Just reading e.g. struct rdma_conn_param  param = { }; one assumes that
> all fields will be zero initialized.. reading futher down in the function

No this is standard style and used in nvme/host/core.c everywhere 
nothing wrong with this at all, please have a look at the author.

> you realize that this function actually does initialize the struct..
> which causes a mental hiccup, so you need to do a mental pipeline flush
> and go back and read the code from the beginning. This only happens with
> patterns that deviate from the standard way of doing things.

The function is small enough for such hiccup which follows the pattern 
which we have it in the tree there is nothing wrong.

> 
> Kind regards,
> Niklas
> 



_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
