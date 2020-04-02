Return-Path: <SRS0=DaKL=5S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52600C43331
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 04:49:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 230FF2063A
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 04:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RoOTmEsF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GwKKstlS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dmk3P/Cm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 230FF2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=alC1p/fsDWW5fmRTB7ooFOb2qckcK9Sru0W7SStu6nk=; b=RoOTmEsFd7rp32
	iVkYm0hVmPLz8esoE+km3Q0rHTA8akWwHFxo0cx6RDbUPZx4d11DIBjFGvIBslCXArtlOzW7AgEeH
	p0qJMASMq3+lpUSGI7fdgkmwdOb584ztwRPPJ1rXygwQqW9Ms/Pg2/JerkYJHExTxxFFXKjLrfpcp
	YjmvFLyuWktYl1HLX1MGOmUMnj/4kBR5FoFXyRAw7tLgKEYUXgYkynN3HlSnZBA3xCDyujiMah3VL
	mYd9iS8wicS2giZ32ckk58jQfocl8260V3NcFH2y/wqC+h+iQTjKTeqJMV8AJV1m7s30giBMnZYM8
	ng3sQA2TmaUajm+ieFHw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJrmt-00086O-HM; Thu, 02 Apr 2020 04:49:07 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJrmq-00085h-2k
 for linux-nvme@lists.infradead.org; Thu, 02 Apr 2020 04:49:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1585802943; x=1617338943;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=SDkDAK+5k//HWQS7sDgf0aFzPyS6dWY5eHWpf8Rpw1s=;
 b=GwKKstlSbNYWVhM65cxqxh2g6Bn3I9gWAghIw4O6CGCVlWbYdRx/MAOB
 GnFC22EawUO7T03GpcmTnOYRorAl/RyPh56H5cNk75jqVmK348/wlxpii
 0hQP61wURAR7BmctVS6nwuT5Er0FYVEmPdDMyQ49m1kz4MvNRQjS2jzZu
 QNfwVG649Cbz5lNT2avXXI02pIIIpz6leXD7H9p4YzsXuGi7hXkVvD0BR
 XLx9Ujjwq40BdEQB65QLvZUqB8A1OrNlHTMwOkwQaTpDqWM/hC+4zzAQo
 oZ4eoGU4FzNsJSbMHlSEarev47a4dEbEpC0U6Z8oYWIPs25qziRAlh7gz Q==;
IronPort-SDR: sKLZH4OVQ6Qx1km7vSeQt9GLAtCx+tKfWlnf+YNZX2Mdt3JOzkIFvAPDYOGa5p7nyAh2ZC+DDI
 UVnM0Xvi9ivKCScv6FWpsniYxS1yanwC1gHig6vJ9R9ByRhZSojdjjkJwIG8mGsBOkLgvAXOg6
 vru9UylG+2foILVQrv0lwpaKwcqMS6lM07OkpRwvv14bUtx101H2+ePxI+bmfn2WA70DzQSv4P
 de/3RykzZx2+fYYEQ0ud4ixSUMVYKaSVwn1alfRalLyhroVGijBpRewgVEkJ7ZZzdwsoS/wB53
 koc=
X-IronPort-AV: E=Sophos;i="5.72,334,1580745600"; d="scan'208";a="242875044"
Received: from mail-co1nam04lp2053.outbound.protection.outlook.com (HELO
 NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.53])
 by ob1.hgst.iphmx.com with ESMTP; 02 Apr 2020 12:48:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LyLfYGwiEjZchV3+m7aeTHG+hiMPCSEw7qAbVMpLFZTRQIobGvI1ScXK28MZyc8XLQYqM1c/Qo96aKHRF/6Z0goS289cfxvtTVbc6gagtkQZlJzjQssgm7JpC03OB4a/KrkJIVJKNkYUGzV0J4O4Kb5O9/F0LXWhzQq9nltwbFOkdEdr0CKBi4LfZgTiORpkyEnFF7LHPMKuHtfIotbQDZY5waNbgWuHDo91w0fz1h8OyRc3rA6ri7di0CGwnZrp+G5b2yj7b/D4IfucmLMbhmIw81rwZdEyGPTNCKk8De3HP0EAu47XENigBTWKje3NdGn1C0mV/GJFgXKH0nbuEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+d2AkjoifAjml4fVsm9/aRsYYRQdDy9MovMYd8NzEo=;
 b=a1THL3JzLjBOD6sqDnyqLutlVsIQ9Nxf+l5LJDw6WGouQzg/XZScpUSMGuDyycTsn724hBKnSvUZgjZi7pS4SJX1RkdiT0me/f6AVlSLjP89Dk0OV/vcbYT7rpcUpCefFW6z6OrIny2I5McJyQ+LTT5GxK3gsS+HFqAoGOjcdCBQVwksnwOiPWyQxFmCplUw/hkc+Jh9IBF3LtHcsOLFGLV3h+Z988kM5Byua4tIan+Q9Tvz6pfmXAkl9kb7RFzq2SNiCNE5cZbfK/CcA1SyijtIMmv3XTpHe/EEc0kq0o/2unDlJlzujiRCv1O9zwe39QKay9EvQpdOmuhjC2bHtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+d2AkjoifAjml4fVsm9/aRsYYRQdDy9MovMYd8NzEo=;
 b=dmk3P/CmnAXtxvGCAd7NJ9YxJlyYVdca5KVeCk7T3q1wBigZVUJmcJTvZJGh/BnLPSgHaHPmSyepY+Wxmj0rKriXi4qavs4PB537YYEJxGnhu3+4kEmds18XmI5NnfIJWLuDKGyulRGGy9uAuNhcfnxUN0O8ccfGyX/57Tl2hs4=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4038.namprd04.prod.outlook.com (2603:10b6:a02:af::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Thu, 2 Apr
 2020 04:48:56 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733%7]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 04:48:56 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Alex Lyakas <alex@zadara.com>, Sagi Grimberg <sagi@grimberg.me>,
 "Victor.Gladkov@kioxia.com" <Victor.Gladkov@kioxia.com>
Subject: Re: [PATCH V4] nvme-fabrics: reject I/O to offline device
Thread-Topic: [PATCH V4] nvme-fabrics: reject I/O to offline device
Thread-Index: AQHV8ELvo82ERkhI8UeMpldGRX4hDg==
Date: Thu, 2 Apr 2020 04:48:56 +0000
Message-ID: <BYAPR04MB4965B8FC2D68B37B5D384F4E86C60@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200302033004.19474-1-chaitanya.kulkarni@wdc.com>
 <CAOcd+r3VVcjM=deQxZYskw=E+qZN68PKAy6vL8yvyCc4FTxJgg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e8c4dc79-801f-4f8c-35fd-08d7d6c126b5
x-ms-traffictypediagnostic: BYAPR04MB4038:
x-microsoft-antispam-prvs: <BYAPR04MB40381026E53EDAE09563A2C486C60@BYAPR04MB4038.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0361212EA8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(52536014)(66946007)(26005)(5660300002)(55016002)(33656002)(9686003)(186003)(7696005)(81156014)(81166006)(86362001)(8676002)(966005)(2906002)(4326008)(64756008)(478600001)(54906003)(316002)(53546011)(66446008)(66476007)(8936002)(6506007)(110136005)(71200400001)(76116006)(66556008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pBmbqICN2cx0MRicWodNmlLJ0kMlA3/iWRROP3N8nnWuFDXq4J5FVwY/oDWY9tdx60rM646TFZu0fZB5eZ6ekbKbkVqLlfm2Elqz0AHPU5lJVy2YR0ePSZUFxaap/6//RARv29rM03QS6A65C/Z1ux/lIwXk7f91BHvoYgsJqzsMC1zIt0sB8IzfBOy6xITX1uONnaPxzECsmPhO5G5Ri4h+c7jvNKQgX64EbgsRY3RvlhjmjyTiXQiBFyhFjtQxLapRCV6DwrV1vXjPPLUdioKjHsebCzFVlEYRTxpTJeVHx+TKUSCdRET0NGqXMWVJyNV2iiFOhdVtpIALOyLuksTtrbEUHflN8GQBKJ3Xq55QEQE+Um83RyYeQV1yir6o7/1qJk0konrOvgMIPl9o3I7o2+mivo4lUOuZkuvmZ8AKjmITLHIkWl8YrdV05I5XCoYNlNrURaHNtMSzBb7x5tgIRkudR66KPPQ6sEZMo+syYacuKxNq7qqYji1AHaJ6RsRmatavtFY4IxPeD60ClQ==
x-ms-exchange-antispam-messagedata: LrXCLGWOVjrJPxGqA2HxlR0zgEJOB94YchoEuHk4arzftJtD/OcPEk0LoGAwbVbjR4QTWyuc3crSg6uO4fvlS3BkGiz5wSElew/ldMMktts6nAKmS1CNLzPR6X1PSGzCk1Sz2HvuQXGlqNStbcF5iw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c4dc79-801f-4f8c-35fd-08d7d6c126b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2020 04:48:56.1647 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KDA4EedCcyXYjrDq1B1h3suBR/VhwiZiSWe7nEeXkZhsNKk9UR5rFLEthNFdSOW58eptqRVTcy9/ip7h4o1s+qc+5s+gp3VUMcYM45u5wv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4038
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200401_214904_135864_29035999 
X-CRM114-Status: GOOD (  16.02  )
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
Cc: "hare@suse.de" <hare@suse.de>, "hch@lst.de" <hch@lst.de>,
 "snitzer@redhat.com" <snitzer@redhat.com>,
 linux-nvme <linux-nvme@lists.infradead.org>,
 "james.smart@broadcom.com" <james.smart@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 3/31/20 11:21 AM, Alex Lyakas wrote:
> Thank you for addressing this issue. I asked about this scenario in
> June 2019 in http://lists.infradead.org/pipermail/linux-nvme/2019-June/024766.html.
>
> I tested the patch on top of Mellanox OFED 4.7 with kernel 4.14. From
> my perspective, the direction is very good. But I think the problem is
> only partially addressed.
>
> When a controller enters a CONNECTING state and the fast_io_fail_tmo
> expires, all new IOs to this controller are failed immediately. This
> is great!
>
> However, in-flight IOs, i.e., those that were issued before the
> controller got disconnected, are still stuck until the controller
> succeeds to reconnect, or forever. I believe those IOs need to be
> errored out as well after fast_io_fail_tmo expires.
>
> I did some debugging to try to accomplish that. I thought that the
> crux is that in-flight IOs are failed, and retried due to non-zero
> nvme_max_retries parameter. And by this time the request queue is
> quiesced by blk_mq_quiesce_queue(), and that's why in-flight IOs get
> stuck. I indeed see that nvme_retry_req() is called for some IOs. But
> I also see that after that, the request queue is un-quiesced via:
> nvme_rdma_error_recovery_work() =>
>     nvme_rdma_teardown_io_queues() => nvme_stop_queues() // this
> quiesces the queue
>    nvme_start_queues() // this un-quiesces the queue
>
> Can anybody perhaps give a hint on the approach to error out the
> in-flight IOs? I can modify the patch and test.
>
> Thanks,
> Alex.


Thanks for the feedback. Let me see if I can generate the scenario and
have a test for this.

I'll send out the updated patch soon.


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
