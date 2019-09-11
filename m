Return-Path: <SRS0=M8F8=XG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649E5C49ED6
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2019 20:39:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38BE92082C
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2019 20:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UwsTOkIb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bfctKdMC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eHx58X63"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38BE92082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=Xd4mMUnju3gdwcn8hYOUgIqTCIAOm7c5MhReesLmXuc=; b=UwsTOkIbBXv7j6
	G51gkzDvMoCfgQ7J8lzk6m2xb7wnGdtgkfNMjt+CpHsUMvkUaOObalsVeFfNC0N6VqOWrLZr3bRz/
	+7EhfU5/5keE/dE/ZXxR7SdwGNf1H+5DRX/y4DFPzBl66lgdq575bXXcxFnGQlynewIbc6hwZQ6OU
	sQOTBJkzQu2+f33noXdJtZwGiTDDPDI33FR+DndIG5cjnmegaWWkiYD5I9c3m2HVFwseTFbpuBoj3
	a8pgOlIyEZa4Gpz2IlGtjFRPZduSUBgjGqiVIXLFaNQ3k9kSW2rC7GnEnXkXJxRlq+chknyQPTOYQ
	uQBfNNPP9La6IhWFdVnA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1i89OG-0003Ai-CT; Wed, 11 Sep 2019 20:39:00 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i89OD-00039T-GW
 for linux-nvme@lists.infradead.org; Wed, 11 Sep 2019 20:38:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1568234338; x=1599770338;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=fA0Yrji4qfI+gV3pm1GcvSvbB2oGuuXbNCzK6MdEoMg=;
 b=bfctKdMCjXXIoP5ltldkShFaWYTuVNcYhph1vUxiL5Oa0koIQxUF6k8E
 uvm7IF8R/E6DCvn7ovYBZWh32I9Z8nSRlsziXvXkMSBzJh03BfkIzJcAw
 jRa1PwHSzpiaNzsBxlES36jmDOjenuI67aljtnrxQLYDMPLqvlOW/NpdT
 oGDrFWnW7HP16M0TQa90+M3JmR6i8MTqJj2k7VVnAaWw8OrLM4XUeJ1J4
 iGbOYbV2DrT7aAQkbkFMwgFArxhsVmOs2OLiSsrnDmpFuQHHIlMXBzEQ/
 oxRSMhergvZr5MvMyV675+qdy8XAE4+fKQYgUT+sSD8ROAzW+F9VnnjxY w==;
IronPort-SDR: Ddtv9nCCR6W6MqylayqSWqtZwTkizsP57xyh5/ZY1ZMRgaOXmxH3RdeVL+gPJoheJc198BEICL
 AFZxFnCf69XtckMcBBcePFra54TfTdtPbzhL44oNIbwm1QV6ej0dNhgzkiFHTBo3y1jBPGiY9m
 TuNIu2d4PeVo9unxZ2SjKTigW+5XKrOBOmfaPtrVrti5G2dQ4zM1NMEQp2DWmRcb9KQ+nvh1jf
 E5S2djUC4ujyOKbFg5/7vyiaPp5CMjfaUJD32IZE6bXDzePFBAy46fjDfhMjFLUU2Kh0WP2iCV
 jsk=
X-IronPort-AV: E=Sophos;i="5.64,494,1559491200"; d="scan'208";a="122574028"
Received: from mail-co1nam05lp2052.outbound.protection.outlook.com (HELO
 NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.52])
 by ob1.hgst.iphmx.com with ESMTP; 12 Sep 2019 04:38:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UeXtZn/dDyloX96qW03nTMSlx4GqakdckpQey8JRnZVk5+MKk74T2n5EoZ5zzXPwryEf27DWGb1yJGTRKuRyIka8yCyyYh6rosrBOFZpzjqOPFDhVkUhwcaILhOpei25EmTCqmGPT9x9P9an26xpQ+NX+XsFzRagMcwq41WD/jNopWVOeuaUJBM+8aWP0jArTU4YaLgmJbJvpROqMN/67NL8Yo80GuVD2ZmMrJmxIKJrWpvvdXDomxa2e6lcrZOwvsUqwWkljrZ9M1tAxbYxQ/VUT8TtNlNcuxbeko57Epdv0FqS3Av4fvOKvEST+7o1uXTqedG45IDObWAdy9fk9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fA0Yrji4qfI+gV3pm1GcvSvbB2oGuuXbNCzK6MdEoMg=;
 b=jmCDUNKtU4qxeBZ5UtcdRQRdf6drtKu3gc/qfD8piVCXcS/TH0ScjdOO7oFEgDUVsRLjhyQOLEEyxiaP5vFvRUVaU6avBrubQhl8Y+VKwWPA4UMCBb4dZjW9j4MvPjKpT/Tf+kaQjrL6dhGCvDjE08ltXvnKyAtAIk14fKdxA+mbfAiVtqQldqJMsFrbSzOvcBzR1SBuC9ukdQtmNh1gPN43oWRgiP9bvtbf6Biopx1UxPAkIymZ9JQOomATqwfzJidbyj/6ID7nbnt8wQcgaDViZumO1qtXhI6cn38GmZ3UXqFfoJ25ZnOZwv2zCZj/mKN/egK27ebM2n7bpYoN0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fA0Yrji4qfI+gV3pm1GcvSvbB2oGuuXbNCzK6MdEoMg=;
 b=eHx58X63+KJoqXBBvBOPcJ1ZXykbeRHvYgkZrpLLarBQBDHy0S85cxqKYL9bZVvainJcASjlc/eEmy5K9LCCaUoSbEg+lVxY2IB2lzVWe6/fkVKB0ChkIVHf9j3ZHjC2FiRf/T3xCWkh47zLqO3pV9Pzz69+fejKDRtiDqSaqaU=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB4870.namprd04.prod.outlook.com (52.135.233.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.13; Wed, 11 Sep 2019 20:38:54 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d%6]) with mapi id 15.20.2263.016; Wed, 11 Sep 2019
 20:38:54 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Logan Gunthorpe <logang@deltatee.com>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH blktests v3] nvme/031: Add test to check controller
 deletion after setup
Thread-Topic: [PATCH blktests v3] nvme/031: Add test to check controller
 deletion after setup
Thread-Index: AQHVaMU8QUU7CWdh+U6FXoE9awxRVQ==
Date: Wed, 11 Sep 2019 20:38:54 +0000
Message-ID: <BYAPR04MB57497809CA89CFC73487A19486B10@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190911172021.5760-1-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0bde0c98-2741-4fbe-4ce9-08d736f80ff3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:BYAPR04MB4870; 
x-ms-traffictypediagnostic: BYAPR04MB4870:
x-microsoft-antispam-prvs: <BYAPR04MB487027229DE95A077825248086B10@BYAPR04MB4870.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-forefront-prvs: 0157DEB61B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(199004)(189003)(55016002)(71190400001)(2906002)(229853002)(76176011)(8936002)(6436002)(81156014)(2501003)(6506007)(81166006)(8676002)(102836004)(53546011)(478600001)(52536014)(66446008)(66066001)(66946007)(6116002)(9686003)(3846002)(64756008)(25786009)(66476007)(66556008)(76116006)(6246003)(5660300002)(74316002)(110136005)(476003)(305945005)(7696005)(316002)(4326008)(86362001)(14454004)(99286004)(71200400001)(4744005)(53936002)(26005)(2201001)(7736002)(446003)(33656002)(256004)(486006)(186003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4870;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DV33dCE28dSQhGWuPJQanIBVJK8z2+7shJHPK0YzZhmU4XS3aes1436fGhfv2Ae/4krrwRG067HUgdd1wtcCQ1fLOYoHs8Lfnp7DQs7UNu1NKdKSKc72UozZFYtI43KESyS+3trRUEkoihwMtlmHWCWMu0TAVktNbZ+VUPuVHs3q93FA8PkJxsDATSAMP0geore09eGFcjYm7fwwgmoqSG6dOEnY+0jO3qJEq05rMS7FrVlT68Xj57uoJKhFv2LIoXgMTgb6FZ6PXcf9vkDxM3TiGg/EDIMfYFtNhGitqhRdSkKb6bBjpkZndNQQYsvvgpxYG9pdaeq/pISvooMgUnpFDxoLltKnUA/PC1vE9vr1rnJbpIOhb1WtoXz6G2Y0/MzPO5UIIPqbvg9h8ugsu5oEfdKMPjYsj2nrVd8W/X8=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bde0c98-2741-4fbe-4ce9-08d736f80ff3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2019 20:38:54.2527 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DB6r6WsNpUvXUjIMdPwEln0oo8xDClToJdALJiYJNIaLfLjIIn79Yi/DlICIRuSyLMqX8QYO1wXLMbc84RaapqrkvZHMj1+xTX8poH947Wg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4870
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190911_133857_631662_87E736F5 
X-CRM114-Status: UNSURE (   8.77  )
X-CRM114-Notice: Please train this message.
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
Cc: Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

On 09/11/2019 10:20 AM, Logan Gunthorpe wrote:
> A number of bug fixes have been submitted to the kernel to
> fix bugs when a controller is removed immediately after it is
> set up. This new test ensures this doesn't regress.
>
> Signed-off-by: Logan Gunthorpe<logang@deltatee.com>
> Reviewed-by: Sagi Grimberg<sagi@grimberg.me>
> ---
>
> Changes for v3:


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
