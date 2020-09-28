Return-Path: <SRS0=ZZT4=DF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB81BC4346E
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 01:54:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8328D23A33
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 01:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MDvHmOQK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="olJ5aDqE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vagEDzKA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8328D23A33
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=mNVgW/oQUxx2ODS2sjUK6zOwe64zm/bPnmxuqUn/9nk=; b=MDvHmOQKca+dTL5q1ZHGpoab0
	AyNBMC1WLcKFXc8KLP1qwsEbGlfkp8VjOWoCNdDOWUCf+VTm79lvtbkYuhYT7TGLGfWLoF/TgO+Ov
	gMhdJvP/7PvgqAFqJReRTmswdPWKCxHWbSE7rrX4JbXIRBJ4cJMhWsaOgTqi70yNRaKaebW52kIn6
	CmDt2LHxYd8HRLfYqh3Ev+i0oy+Ie9A2NrLiNYRwjsrZfNc4V2qQ+Ge8aX+c8NJb9Xi01eT3vIR5g
	K2y489mny8MN0DTDIRq8zmfDoKfesue5BKlN3etkcXTWrunJhDIk4m42k1VjkQoXZpJ7pwIetBCPk
	mDdvlks7w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMiMW-0008Ej-7F; Mon, 28 Sep 2020 01:53:56 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMiMS-0008CC-IY
 for linux-nvme@lists.infradead.org; Mon, 28 Sep 2020 01:53:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601258033; x=1632794033;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=AtOGROFYMJTtYgVe9lHVhGMl4Qe3MpUWfAq6cCbvwEM=;
 b=olJ5aDqEXDF3NRcCTuomq95V5ji+aBMZn4pdy0cVs0jXbqWJdT+mzv09
 NPEF43Oxzx1JKWp9KKt5JXNFzQUuydbkZCSJM1qQlz1STdwIqGWitG/Hp
 gKLCzWs4EXnrVRDjljcVErHzGIcG4w2J18SdOAQ2ANkYuGs+kMtn975YB
 2qtTNGAJdV+gpy22X0aQXk4Z20ZbTpznedIzR5LwfSzcQDmJRB7dJlOF0
 JYQ0840KVbKr4UuB8SI84PaLkTs+QTFabdQRzKh5VETn8dddpoXGzJXUh
 tOQGuNqutrRzR/M8G+yqLjnQYvL030uGNxVJ8BFypEH4oSeY5o84WcQRm g==;
IronPort-SDR: 4qWzYfHOOEOxJY0WprrqTnej9GsL9ZKAUkchYSunF7CqtTEp7JfZNfmm1oODSZGauZXwzSDCq+
 onZwtwA9ptt7dhwiofxaUi6q+oXjGNCLk0oMfS9yOEdwyqb3EzfTPOzN36TchZMHumQ3haC0xQ
 SyrtvmuPofuxGVMFy5a8K/WLgFYZ9WEKZYXQp/ozJgdsaWULdQZPpjuWDSo9l+AiHqGZR4lQmF
 GzOdfCIcE0Az2B469zM6o8ha5CCjjw1en1f2ucxulLtBoN4/SmU5r8sN1jBEJLdAGn/oXrbAr3
 Fh4=
X-IronPort-AV: E=Sophos;i="5.77,312,1596470400"; d="scan'208";a="148421539"
Received: from mail-bl2nam02lp2050.outbound.protection.outlook.com (HELO
 NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.50])
 by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2020 09:53:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OdPZpQICkmRCC70gfaUsW3l99Hw/rUXT0EOksg9lS2HOqQ/VpA9+T8cgFDj4tziwGgKI9XXYTRQrFECyTiN0JdCrcFRQgLOrp4LKVJvqyvN/YBlLh4nFBKVdamE6k1OLAyaEfvlwWNyArfpAzSUpE+wn1HB2LhGf4/Urp92pMOZZdRA9AUcg0tSF5cFVE75VyqEhvQVYwOuBmftLahHr4mEw5zK00fyz05MSVnm3aoIlchsLkT/MSD5z7aK0/GLZwPJRBZ5/k7AnP+gmu8bWJUfQB6ZMgNJYXpA8fcpk9zcS3Ff2g6S8Bgbd0rVHrOahGVEvQsyKg7DfF0VSrbIwTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evd1s3ayeapN2SP/YtoTO0xcProBPcgVz6HadYdKqQk=;
 b=YydYnNd1rdrFl4MvA8hpZO2aepyl+QlzYNQwkukOi4yO7Uj4fOsmu7wRc8SNX/K+uMGRe1GYCTzjayzjzyvohWSv36tSp3LoEUfUcY4wQMMS/o3ozvFrTmenswst68RZfHBSD2WFhmimwn95HdXXJ0jKM8OU/pQRfoV/4OMmGdEWAGbvY3X1/BKrgHkEoLAvf4wriE8eeK4w85ZyX7i0guMio20v2QMKb9Qs11CgpMB3XVU6qttYzay6Fs19DreWNnIcSgnQfytY6GJB0RqVfNKagONWmLiGnU3YZjiKi7IF9b8A3uKza28QDGK8bdrXdPmBX6lz0bTbT/GM8yNR2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evd1s3ayeapN2SP/YtoTO0xcProBPcgVz6HadYdKqQk=;
 b=vagEDzKAl/915ZERCE2hxlG/5eg3YuiueIPodbY6LEc308/PsY5uJhulSfW55ivcj6S/9Na8CmobtvWfl/uA3CQzScnvFrPL+/wjH5gVbbfLFZsNc3ZoCYuzuZgEBpri/s5YxPHfGrlOSiwQklh64jwNsKrjc5du7cLJqPWi8WA=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR0401MB3634.namprd04.prod.outlook.com (2603:10b6:910:8f::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.24; Mon, 28 Sep
 2020 01:53:46 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 01:53:46 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [GIT PULL] nvme updates for 5.10
Thread-Topic: [GIT PULL] nvme updates for 5.10
Thread-Index: AQHWlJ8pb2J1rHdCcEWtcKUFLcesqw==
Date: Mon, 28 Sep 2020 01:53:46 +0000
Message-ID: <CY4PR04MB3751593431168AD25F312A1CE7350@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200927072343.GA381603@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:809d:4e2f:7912:1e64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a2805fc3-f612-4da6-94b5-08d863515660
x-ms-traffictypediagnostic: CY4PR0401MB3634:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <CY4PR0401MB3634BD93C071A77334FD4166E7350@CY4PR0401MB3634.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 77nl5p4n/LxXzUt9ra4CeJyUaZnQmILUwhktVWzt4IdWio9+8j+/NZgUSqtv45HDa2Nfy+8LLFT5eBSDdLdkR+Owhr3VbFRCsYghmSmxzh2TVHdl/ezCErxzXgvIqBJQJuPJa2Wj0osaoIBUvrEEmzhULFYYq8tCrti1X4NK1rFlZ2UcT+q8P6390TPc5qNO2v0fwec1ikTvIFf8s5tqBY+zrihGY789RXP+DDK30gmmoQmiCYM4VvxBl/vTo1kzLFV6aHvE8coHykHqs4Oa9pgUBoQx2OFbRNqAhBLmvoXJRH+e96SjTqU3u3VKVFXn7B+N45XfKYogj3m3s967uA32W+EoQpVLxG277FcIqwS5Zav4HURJ12UTiRxEH/2EaGfvg7RypT/szBBAGmWDtZ9ePIzrTrAR458bCQL645XeSo+6x0IiH9XZ/U58MyWwZ3GnZ7YHUI5NWbftKI5FVg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(396003)(39860400002)(346002)(83380400001)(55016002)(64756008)(66446008)(66556008)(8936002)(86362001)(66946007)(91956017)(76116006)(5660300002)(9686003)(71200400001)(52536014)(15650500001)(4326008)(33656002)(478600001)(966005)(6506007)(53546011)(66476007)(7696005)(2906002)(8676002)(186003)(110136005)(54906003)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: K7i2ODsGYLzWFWmjbN+mACsSUMUlaNWyJU2bsrrb/gufRhHgSlZdhqNqDf7jyheNGvgtRpdDPeLsvyh/p9/AkFITVFEyZhEQROmbv1kFlJAWWHa5owHOPIAn0EXflhPdisGHjasSPpxgk0EgChb3co+kTTf+JOCOzni3BPo0VZqe9xEFV1Xd50nKYwxwMgFnfgcfUXXHoiQYcio4IGEoozihEavG+baneAdfF3785ybfj1cUo3J2DGWui4Qmrb8hrUA7bForJw0R14WiJCEjJrIvEETONX3oKHwnAOzaqG/XSmHlraemONRMCaWq+LkgTQfFaGSa1MZeGQ2ba+K8IQ2uSl5o3+YqnhqNljjxzJiQg3qfZn/ZE1TBwrgOwugthzdCluNakTvzFNOTRvmxi8EZC4lKfRbPepXR+weTupz9Ayhe5Pbpy3kdYiKbWF90agqHOzzv0ZbC0vt2stdPkUVURDMYB0V+kC5nppgTlb52h3FC83Vqsfi8KIjh7zInrK2vEjMnevOY9It/anCn2EQ2k4JD8TomTauAqSl6XcTr381E/DQe6wVpD5JhxXOPJItHZqAHN1IRB+9RmnvV6VRZv1VUu7CdoZlmCAflypV8Pj52Dwhl3k5vdiEzUCjqo016ZZ/qTHewpFtU4F9ifPsXHx/dka6oG037hkGtcZRZk97/HQfpwH8lRB33+MPQAO1v+iR4tw+U/qm8jOfPxQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2805fc3-f612-4da6-94b5-08d863515660
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 01:53:46.4646 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cFKEr244akTyMsFTcJ+QriVoO7vVA/CmElZPNGx1UcY7Jxq6f6miGVMqoUhrysELq+P+fTD6QtwJ9nnxid/0Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3634
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200927_215352_759088_06E1C48E 
X-CRM114-Status: GOOD (  18.11  )
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
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/09/27 16:23, Christoph Hellwig wrote:
> The following changes since commit 163090c14a42778c3ccfbdaf39133129bea68632:
> 
>   Merge branch 'md-next' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-5.10/drivers (2020-09-25 07:48:20 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.10-2020-09-27
> 
> for you to fetch changes up to 21cc2f3f799fa228f812f7ab971fa8d43c893392:
> 
>   nvme-pci: allocate separate interrupt for the reserved non-polled I/O queue (2020-09-27 09:14:19 +0200)
> 
> ----------------------------------------------------------------
> nvme updates for 5.10
> 
>  - fix keep alive timer modification (Amit Engel)
>  - order the PCI ID list more sensibly (Andy Shevchenko)
>  - cleanup the open by controller helper (Chaitanya Kulkarni)
>  - use an xarray for th CSE log lookup (Chaitanya Kulkarni)
>  - support ZNS in nvmet passthrough mode (Chaitanya Kulkarni)
>  - fix nvme_ns_report_zones (me)

Shouldn't this one go into 5.9-rc7 as a fix ?

>  - add a sanity check to nvmet-fc (James Smart)
>  - fix interrupt allocation when too many polled queues are specified
>    (Jeffle Xu)
>  - small nvmet-tcp optimization (Mark Wunderlich)
> 
> ----------------------------------------------------------------
> Amit Engel (1):
>       nvmet: handle keep-alive timer when kato is modified by a set features cmd
> 
> Andy Shevchenko (1):
>       nvme-pci: Move enumeration by class to be last in the table
> 
> Chaitanya Kulkarni (3):
>       nvme: lift the file open code from nvme_ctrl_get_by_path
>       nvme: use an xarray to lookup the Commands Supported and Effects log
>       nvmet: add passthru ZNS support
> 
> Christoph Hellwig (1):
>       nvme: fix error handling in nvme_ns_report_zones
> 
> James Smart (1):
>       nvmet-fc: fix missing check for no hostport struct
> 
> Jeffle Xu (1):
>       nvme-pci: allocate separate interrupt for the reserved non-polled I/O queue
> 
> Mark Wunderlich (1):
>       nvmet-tcp: have queue io_work context run on sock incoming cpu
> 
>  drivers/nvme/host/core.c        | 56 +++++++----------------------------------
>  drivers/nvme/host/nvme.h        |  4 +--
>  drivers/nvme/host/pci.c         | 35 +++++++++++++-------------
>  drivers/nvme/host/zns.c         | 41 ++++++++++++------------------
>  drivers/nvme/target/admin-cmd.c |  2 ++
>  drivers/nvme/target/core.c      |  4 +--
>  drivers/nvme/target/fc.c        |  2 +-
>  drivers/nvme/target/nvmet.h     |  2 ++
>  drivers/nvme/target/passthru.c  | 43 +++++++++++++++++++++++--------
>  drivers/nvme/target/tcp.c       | 21 ++++++++--------
>  10 files changed, 93 insertions(+), 117 deletions(-)
> 


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
