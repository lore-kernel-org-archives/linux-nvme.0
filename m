Return-Path: <SRS0=rLKq=CO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DC9C43461
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Sep 2020 22:57:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19CFC20760
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Sep 2020 22:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="btz3iAmb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="I59YRXxD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nd+7rvaD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19CFC20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=ecotvSGLivciAQLobrzi7RJIsHTSn5qbPpo9Q9PcKSg=; b=btz3iAmbrUJgtICTcZ7kgc0yC
	j9Lwl0IJ/FguWuvxDduOv3SJ28lx5xoBrXLhQDPXeLfMCU0pyuGuO0tsgizzUfeNKWvmuPYawcSNI
	t5g8J7QQRkgNtzlnbMU9zEWhMQvo3HY6xRzV2gQL8difITrPtdezQmOkwYjRZIed0UdmFldF9fR+D
	5NM0Ry9JDTw17r4vWJ5K3JecLfdK66+rLQi0SUOTmjFNQkG6Zm3t6nAj5Spbd/JnQYs6baJN3IBAE
	alDNWsnT0LPxoz58hUKvBVthaKhaHnXCZ4+Vs9PxCQkBsIr4QTQmCUBXQeN7Fx/vqjJZ84yO7SJlG
	2ba4Qwaag==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kEh83-0002Qy-Tp; Sat, 05 Sep 2020 22:57:51 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kEh7z-0002QT-Dp
 for linux-nvme@lists.infradead.org; Sat, 05 Sep 2020 22:57:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599346667; x=1630882667;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=i6eDs7sUAod6BH6mo6iY17Uez1WVCHKPjLUZmrLC75U=;
 b=I59YRXxD/gKCjvQT+vYbLxtKCXNt+TUetGPXxKfXH10tyfJKValxiwxE
 JV2CiqcM71HI1WvG1e9nDK14GG2cIeOBuDjU/k2IA5hPvn0UL6qOdOB74
 kORrTODsDpfCrDS9zzSuITE5NSTj4kUcTQYwc6i5XOyd54jR+yTLZ8zlJ
 rg6l51S4GrWJCoTGH281VWR3cbFyQ/nogahilHxZriiw/XcyGmexE5M/5
 YTzjXR+23yZiDEV0Z+HP/Q/JHO40lPiERMrOQYgUx/V8QJdoeqv8tpywV
 xKeRm4tIRDyygs0pmh2+6RdjTSaZ6cL++kNHsWnLXq3NycDToss/JhNvT A==;
IronPort-SDR: ZpmDhW5gq2DjPNU/Vvw16VJ9xExZqsFArjT+fwsMPYdAvRt1K1U4Jaf3wKpTIQMu2La7Aawqml
 3ZODWnqOwlaqu9r7eIZ/AJWMrpYo1W7xy0Q1Qnp5WcAxsjrFJ0AVXBpqcZ6JUEa0LnQqw2EVmV
 3vqIHNBb9Il94FJim2R4aFfKx2lPwefPKdhXi7Ne9Z96paKq4cSgfsmYwEvvWhz8BgmfmU/kuc
 xZ9ieUDCk9LalI7eFOUjpdevDGqEWxCdbBQ0t/2/YS7a3JPTdyPSEUfMI0nkP/eONzitqRNIOf
 GIM=
X-IronPort-AV: E=Sophos;i="5.76,395,1592841600"; d="scan'208";a="146577839"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
 by ob1.hgst.iphmx.com with ESMTP; 06 Sep 2020 06:57:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqWXl7LGPB4g0BBfdc1KYM/pld04tOJL9gPnSXr8GXDtA9I6I2WZkD4fgvY/1E2Jwnchfhl3KawTZHkee1EJy/fzR2YdWUZVZ/A6ns1UTfFImPLXBh8pFnJowYPaqmXhyZv1X5XIxZQwv79UwBxoRNS6sFCSKDJCdGoFiyevhmPwj45HFM2Z+2JG4AcBNljqUDu428cyrdAnxOeQBQVRwTuOKe4+Y4f33ym5A3gK30Ys2d8hEflxpDz+L2g96sMOHPUx3Xdf056cLdKFbbs9yK6/kE5iV33YsUT3wqYm1cnpVGm6II+LfGyckhn6Pp7e4Q8cUWcmTnbIRNBhlPqJsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6eDs7sUAod6BH6mo6iY17Uez1WVCHKPjLUZmrLC75U=;
 b=Lt59I/lqDXAngnRQ5ST3lQW0Jty8l2FVcI7faI8wEUnunpKQ86Ji3G4q7z01qXeVfi34Aek4goxyBMCvkv4VfeJFfh06Ubhp9Cc6bIw8SFWLgMAsE6b3qQRMJitSC+C7UYv2PBhZRRjL/f/NNbgdLJQ5H1OiiyBZmgsvvT2Yktj9ocb5IrYL1QNQ2OdOZFLkhHb9ybN9btcFsgzIghaqRVPDzN6z5wKHeyuaI0cm6FD85olWlfsl51QYcrUjs8CkPLMXcPxD/1xP7nBFTvcB9waWRpptc/MQd5KjEOwlCp8sYBfMxISnItG4Gslvar7pgnXmWrdChGzGiPJ9Y7kvAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6eDs7sUAod6BH6mo6iY17Uez1WVCHKPjLUZmrLC75U=;
 b=nd+7rvaDpZaseVEiePZdmGWbwKvZpPwbqMwASjsUvAUKK3cC9WEa/8a5m4RWwd0vwWmZ1x1sqEWQbC+TvsuO8b7q4JsTKlXsbRHGIEcxYsAj5B3Yk0W+mo3BmJNnIbJe+ayN9RWm4c4c1AXqxx8wTHg6G8D5WgApw0y3/H1KMBM=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB7122.namprd04.prod.outlook.com (2603:10b6:a03:222::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Sat, 5 Sep
 2020 22:57:42 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f%5]) with mapi id 15.20.3348.019; Sat, 5 Sep 2020
 22:57:42 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH 1/3] nvme: decouple nvme_ctrl_get_by_path()
Thread-Topic: [PATCH 1/3] nvme: decouple nvme_ctrl_get_by_path()
Thread-Index: AQHWgmS7olwOLSYJF0mWi6BmMR/4Tw==
Date: Sat, 5 Sep 2020 22:57:42 +0000
Message-ID: <BYAPR04MB4965438594B46644D7A35AC3862A0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200904023929.5320-1-chaitanya.kulkarni@wdc.com>
 <20200904023929.5320-2-chaitanya.kulkarni@wdc.com>
 <16dc2193-9830-6184-e7f6-ceaca5f0aaf0@deltatee.com>
 <20200905072018.GA13403@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8c1d94a4-c290-44db-5398-08d851ef1883
x-ms-traffictypediagnostic: BY5PR04MB7122:
x-microsoft-antispam-prvs: <BY5PR04MB71226BC7FB6B8FA8D8EFF018862A0@BY5PR04MB7122.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vfAHX5HEHEO5pJBxf7lXvI6SgXKQtToqEa2o9liSjSn2/thK/R9RdAkh7FYsPgw0k3dEu9Fbw+CrC9y6AU5Hyi/Q+huuXG3wAZgCv3gRW+3/J64lGJuXibV/uTrikwXMxjORURWBkeEGthdoaSxKWB3WNtt0STT8beZUAn2h854eXv1dyXrxUM6sqJMVYQmPXjlRRVPVkln+HEmEjnvcdpctF5Udz41WvcwJWmVnHHbhmSVtE1z2zbNpBOzZmmJukL2CAECjUO3BLniRpOj1ds5dQboh8BpmfDU3RezzXz7O1rRtA5fC9lbanADjx/xctciDt7J2gslDYlA40iAm+A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(346002)(39850400004)(396003)(4326008)(76116006)(4744005)(55016002)(86362001)(8936002)(7696005)(2906002)(33656002)(6506007)(53546011)(52536014)(5660300002)(26005)(316002)(110136005)(54906003)(478600001)(9686003)(186003)(66446008)(64756008)(66556008)(66946007)(66476007)(8676002)(83380400001)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: dIkzAlZY9P3hQluX6JlC/d3IkU8yYyUQI1a/Ve1iDuShDdg4WrYk9XRw1V8rRzdbhLoajEOXHSCut4bxyYA4n+7cvWmHf8QJwnKPOaPDnMvKFTgsbgnRgfaucJd8DLfg3VpsOPcsvfMoQLYx3JflfuSoX5WD91DwBQ1Mt8KstoXoTkyUFw3pRhmriz0X0z5uvQcBjBYl9/U56dmwcHvrlshwlw4nNYcDhRzl1JLrW67VuLQa4QDC472dir33eVafCBnAqFJXvR2SqjNrU8HR2nwztKd/2KezQIw57Q9gncery2xSquJTTGAOxZO+wXxHm0siCQkJ8bmXAOQw9Z1A/GBZCa7OaYk7bhQ2hkFfKjuKMK9itbpZ6QAqbc28wlASyzA0iA7ILtgdiwrBD2I6KpuT4y0nunsRLftu4HAyRb3dzPZMVln13naQyoOk4LjYzgdHfIkTgX5bYD4wgKL6HU58P9UqxqJackTmkFEF+7ORPWrNnDURNdtP71N2DFLxfA4wT6hDIYzFv1QUj9a+QjdzWAWgrpLDn1eYhas9yF8VkYCewRS7PcHsMVZL2UT0NC8Tr4mMmUEZJx0t9E+sJe/VOYWSYPmXtKOWG/vh4394qHWmLB8hYyEYTSIRQ/sJl41+Kezmbweumt3exp4DqQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1d94a4-c290-44db-5398-08d851ef1883
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2020 22:57:42.1899 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YYDlspt0OwDatqPgqtTwI68h6roNlkyZQPkr4WcBKDAow87FqD/gw3liEXZu/guarO1hO6CmQ3fMsF0x859eei/FE475yKOxbzqU94dNzms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7122
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200905_185747_738063_3ACE57BE 
X-CRM114-Status: GOOD (  13.77  )
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
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/5/20 00:20, Christoph Hellwig wrote:
>> I still don't really like this idea. No need to keep a reference to a
>> whole other file.

File reference open/close is coupled with ctrl refcnt and module refcnt.
What is a problem with keeping the file reference open ?

> We could still lift the filp_open into the caller, but drop the file
> reference right after we got the controller reference.
> 

The file open call gets the ctrl and module reference atomically and on
close release the module and ctrl reference respectively.

If dropping the file reference means closing the file then it will lead
to loosing the module and ctrl reference.

That also means, moving the references get/put out of
nvme_dev_open()/nvme_dev_release() in host-core, it will fix the problem
only for the passthru case. Having done it in the core takes care of the
all the cases if any.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
