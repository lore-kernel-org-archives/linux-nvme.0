Return-Path: <SRS0=ZUg+=YX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A903ACA9EC5
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2019 19:55:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6487E20717
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2019 19:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rjjTfhiB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pENUAoog";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jg8alYSp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6487E20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=DyW/r5fyKxjaWNs6FBqOQCFg+b6WeQCvl9Emz1wa9M0=; b=rjjTfhiB4t7W4r
	6YM0lQojO27ac0LQESM69CyQBwZcbzZrwmO73OmUeTVDiL1kGNJSLFk2ZQ7xbfm8yIeZYka2cIweJ
	+JcU9Ll2k141tVbqvIAYlm0chfU0Ou9rSkjSJjS3TxeyMIa6HvXrU0WDWpg3AB4G1whNFHWr0F3V5
	XOAMavdjS9IvliZ6BfAQ0OGUoDEYk/E549bv3T3qUWhSeOPnKUNU+j8ZgBwAIRqYr4vxoHNj2mCjw
	J+2ZJD8yZ01L5Wyj3HXkplseYCdFFgoNFHquOSI0XnITXVQVS8DFr8QAY2V+bBeW21uJ0kEVRucN2
	aPauebZgw0YBSGa1ZiAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iPu4N-0003es-Ua; Wed, 30 Oct 2019 19:55:51 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iPu4K-0003eL-Ux
 for linux-nvme@lists.infradead.org; Wed, 30 Oct 2019 19:55:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572465349; x=1604001349;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=YfRlZl/RLoQI1VnfhaGlutkOKnKRhp+lO/CyoT+nKkA=;
 b=pENUAoogu9fUzlqFM8KDU5oV3QAOUxazWMIPhOKRnjNu0qtdp0cc70yr
 Bh+jQgD2nHMfv0DhdsTJY2WTr7vPpQ9mXusTWY7NKDHKkYnHFLDH/ksuM
 1Ns5ZFKsc4xQC3dC8yq/wFyG6R56RXKUFT3jCb4CORPckdxanlU3Nm7xP
 m9oNRgAZiPQgncRS23ZgnZs0t/f8fEAWd4pHHFFBKSm88kJKy1hTfhhfM
 apJ4yGP732CKkZdPR0zehFUYnY/L2EXtiYRK3DiaTZxK6gJobDIFThQPt
 nno8Jo1sk+n7sB0bRMhD9lIisZKsBjGov9sXF7BTBeAVZP+5HW1mJ7igy w==;
IronPort-SDR: uXCWzJ19K38nQjCfMJtKo7W1q4DuOWJUS0QXIgAL6BBSXkKmuDtvkLDggzIUHNENtz9J1SfxGQ
 pqyz8y2uCTK2ZYoGB9PP/nTBJPItjT9odU0Q1UL16CHXOGewxKGHDXE8yqxwTOQdwPR/t/AgAO
 GycHIZlQCjKeVRu2ROzujRMM2lGVB/GY7zLjMPpieAzneMuEAm70JbbEK2jclRe86DRtNSO8M3
 x0J6yXEC2rdzDml/eBHvSTf/kArhqJZhjO/Y9dcJP3sK4gNJDt2yf3qvEeZ8XNveM7Gx96kY6Q
 OXU=
X-IronPort-AV: E=Sophos;i="5.68,248,1569254400"; d="scan'208";a="122487925"
Received: from mail-bn3nam01lp2057.outbound.protection.outlook.com (HELO
 NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.57])
 by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2019 03:55:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fs7RlCLaB1a78RVLNkKTomo58pSG1PvD772v0usuAocdo7s6EU6VNL9xDCavTsgwfSZ9BmvIpDrecSrVljGScs4AavgyQMC6MuE6q5FJdcDZDDVJl7J/4QaG1svpmgotnDAK2aGrNxhep+1+bO31nCo62/+lTEtF4M5MDu8UNcQOkKfg2lMh3lKKzqpuccL33GMaGoTenH0a8GO2o88altWgflMiB0R6ibmo8oKp/PA07EkS2+soRHg6LwarLDFSd7qG6a86hxlGSeiHwu/CuLeBwZxci329iNRuacgJ6ij8n8a0f39KM/J0GyT9I10c3bFmDhF6arYAatM7UAZk3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLGwrWxBSnIBFfXQxSfhS0nbSev3Jiyb5zWkxhEkfpU=;
 b=I62dOVRleKDqBXR6dLOYRtUzUFNr+ieGx0fAdHb2wgWMVr/yp3mEZqbpk4Ug/Om29XF+7/39MKCMqW20z6HsnCjtKaXLYvadseWQGg2/j164Yzt6QsIkv3b+ubWX85dXtPH/nc7dZ6ZOHs5ogfCqiCMyGxKNG/2UpNic5PuDWugo5UPrDaj2yOls2aiw61G7W3aVVSayUPdvRCCvxEnldDkAdMIZelU2AbO42vWR9ZFww6CuicTi91BDnjw9In8jU4ZFO7v2zE9VVeZlPxqPrQ2oZMrB445hrbQPhlMBhJk7LfPO3qS/PGVVhbFexSpYFQcvEUHhL/qv9Gus9GTgtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLGwrWxBSnIBFfXQxSfhS0nbSev3Jiyb5zWkxhEkfpU=;
 b=jg8alYSp6H9FA6SwbRsusK2396sakyc685NtfIehoY+c4fq0ts8Pb/c3LigAh+jaUshBWkl+FesNIr+o5PhWO0bVxdlEbbXUQ1HBlCICBml+9BU3zqr2uWREQGciUtN9MJuQyDAg9TMsikSIda8SmuNRrRLeiUVFug6ro4Iav0Y=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB5271.namprd04.prod.outlook.com (20.178.49.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Wed, 30 Oct 2019 19:55:44 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::34a1:afd2:e5c1:77c7]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::34a1:afd2:e5c1:77c7%6]) with mapi id 15.20.2387.028; Wed, 30 Oct 2019
 19:55:44 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Prabhath Sajeepa <psajeepa@purestorage.com>
Subject: Re: [PATCH] nvme: Fix parsing of ANA log page
Thread-Topic: [PATCH] nvme: Fix parsing of ANA log page
Thread-Index: AQHVjeMDyum6rQpnYUK6qpC7Yp3GPg==
Date: Wed, 30 Oct 2019 19:55:44 +0000
Message-ID: <BYAPR04MB5749C7095DA29A52C1D0336286600@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <1572303408-37913-1-git-send-email-psajeepa@purestorage.com>
 <20191030142908.GA14551@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7cdd64a4-02aa-4a20-3aa4-08d75d732661
x-ms-traffictypediagnostic: BYAPR04MB5271:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR04MB5271A5117913F0F04233032A86600@BYAPR04MB5271.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(199004)(189003)(64756008)(305945005)(7736002)(316002)(53546011)(186003)(6506007)(99286004)(76176011)(26005)(102836004)(52536014)(7696005)(54906003)(74316002)(3846002)(66446008)(33656002)(256004)(66476007)(6116002)(25786009)(2906002)(110136005)(5660300002)(66946007)(66556008)(14454004)(8676002)(66066001)(478600001)(229853002)(4744005)(966005)(76116006)(446003)(4326008)(81166006)(81156014)(6436002)(71200400001)(6246003)(9686003)(476003)(486006)(86362001)(6306002)(71190400001)(55016002)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5271;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nxa5xyjTEZiVwA3hqajN2m/GkrwFmForD88Fnig/ogWAam4N/WWthvKTXA8t3NAtqSZq41jsI+Ql40gKcQ0LhwgfS07AQqTVVGTcDb5UViepdFaPmIY7Q/s3SchnBk7THPhXHa7aqbdKd1kG3+FDXDhMfhoKdAXwgIPjYkiiID285D0m9NGvRoEWODfbCKNEUvWYyNGcM7K19DBuEU1jz4Hjp96g2OnsaNAAbnACV4Ov4a2IfpE6db2T5Dn+qI9tbpGcOdd65Kti4foAQdFCrFRy3X12Ugbc0nM57s4nqHLv81HzG/9fCotNCuL7nKqDfmTjfXdomEivoMIvDmsw+4LrIA7wbAN39T027J132ONtXO9EDaT1y/hZJEpplj2eiX/bxUApEGVILl9XCf148724MjIutpbY0IEX/ySdghC1NNs6ZBaRhaxOc9FyqKkij5DYXMcj7ZK3HKRT0Ac7sKR7M4TMr4HUUTrxM+4R/7w=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cdd64a4-02aa-4a20-3aa4-08d75d732661
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 19:55:44.1303 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /hz+NS1QO/X0upOkfzbyKJ/573eYQj3C9BIi6zMVmHi0asBkXPCw7ISudSNEMxu87uyL3wMzIh2RfaLNDcmFvUqcSIA4LWCS3WZqk5hdg6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5271
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191030_125549_071618_F9BE0795 
X-CRM114-Status: UNSURE (   9.50  )
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
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10/30/2019 07:29 AM, Christoph Hellwig wrote:
> The only thing this changes is that we now also execute the check
> for the first entry parsed.  But the log size should never be so small
> for this to matter.  Can you explain what problem your are trying to
> solve?
>

I had hard time finding out that scenario.

Prabhat, can you please explain ?

> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
