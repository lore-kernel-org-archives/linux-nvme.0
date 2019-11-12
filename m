Return-Path: <SRS0=/X2o=ZE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D436C43331
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 07:07:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D4D42067B
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 07:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gxf7+LXN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JPRU98ni";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="EB5xk/rC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D4D42067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=PP5ZNE+Jab3QOVv2DIIIZ/CvVVWbf9dsVw34rqrFWz8=; b=gxf7+LXNpsJkxy
	KjkBj5On7Mdn5vBswuv7CM7YL6CpDtIHooaqRlTBcedR6JikLuQXXBeok6Uv2zaJ0Jl9zbFHXfdwY
	ed4qmHGYUuqVm7/CIPu0nmFHXmjHmwEYyfT1LxcTV9orrScFu+3qyCDyQLigUvW1AJ0vPaA7wFyCH
	/VWqg2UurzZXMvOB6wliKXbwivJxxL7hwz41vYLLcQ1OJf5vxt66QrlnFXZ4ppwvIwHDhHturRXxF
	S7jXsDglBlpkdM73MPDHzn65UASp2rKRHwa1nMCOjxCXTGMf6sh/x7gCLAsmc7Y1UYt14AZekh+od
	daSJ3w3J7bI9D0u2D18Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iUQGd-0004gk-4f; Tue, 12 Nov 2019 07:07:11 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iUQGb-0004gM-4f
 for linux-nvme@lists.infradead.org; Tue, 12 Nov 2019 07:07:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1573542430; x=1605078430;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=sH4CCykXsnscGP55ZPEp5Jg7/a3x683j1jP8wgD6W7A=;
 b=JPRU98niPMKbt4C+q3B/dSPMjrd1sWLSnnmelel5sGrdEk8c++gp8u5F
 FvYj4FIAcnFWTp9rjOXpxGOy0mkcCejzn4Yf69+KhHu6kZEaqohfs1akI
 f457+UGg6eR1V3UQCX8JFHpI7b0U9nud51Yvvds5iuFO4/swenYm1sX9f
 YOp2/y5/GYrDxO5ROoj5160ZlMFZAzZf2Z6aZEfzVHjNISq3ll+EOXpxz
 oQ7CMyl4lm+NU98pmvEhMa4PDQQAKMFgEKC4jH8snK4jxvGQrwC49NZhF
 TuTWLQXsz4IzLKg0UskviepzKlPTQkpjs5QoakLLcB+fJBYsLJqg/47kK g==;
IronPort-SDR: qYD90wNGPTI++/dtAhlPOtol3lme5fo2DhPF+F3+vL9Uj/ARmpvs/Ux6bHR/YIzjx/VsQJAcvR
 o4cMdZ5168hGsmJSZWlWor/pluvTU2S+o9XlPBw3+0n0iKCvxzARrE3lcTRvwVlQI9Z9hgVyL8
 coraGLfuBJGhWm7ZD22+dk1DaGMWTZDMwOx0gPzz+n5OSZbP88PyUrUnGpOFBgcmc4ddg19IF0
 bb3KPQShFW7f85ERcB6nQ85Vk0d37KadsSURV7JW8WB07BCWlDSHYx4PjFSHz/id9J8Q4WzAAz
 46Y=
X-IronPort-AV: E=Sophos;i="5.68,295,1569254400"; d="scan'208";a="127161743"
Received: from mail-dm3nam05lp2054.outbound.protection.outlook.com (HELO
 NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.54])
 by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2019 15:07:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bB+q0HuEvkWwd6qVKnnMCozRlbsCFeoR3m3A+Sayjs4tdcplHMKF0NbRONIus7jDfwr+O6e6glFvNFexPNf7oLWCWQmNCjwNhDslj7lq+0Ga4THVFV1hn7NEMH/2w7tjzsEo+fD3fC6aZWVQABq3lXX2S67KrAV4SPcmBFvGPwhHiahRh6HcakzHjsmVbY+OCB8rURlMe/1Phb+DKHkmTmHtjqkQ0oNA9/KRp/zhs4L035yNqQ9Wj/ybxvNKGBCrAWyv4sglsBhKSHzYe7MMmtqve3ibj1J/env2xTRN+Q79Y1pvkjpcsbbagFwTaVxTFdzy2uZw89RS/rq4WxY6Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sH4CCykXsnscGP55ZPEp5Jg7/a3x683j1jP8wgD6W7A=;
 b=USZ96UhMkBLLiK3aUVjhxCjXsHU1RMQD8wNIwZBOaWloBaGitpewRHJEssqlzAlqQvLcYTLwNwkTQWA86Qt+tZymvUp0vPlgW4g0EypsmgoizSvKqD+c8B4skPIPOj0+++SIIiWZKop4aYDNpBNdLffWByY1HkgDKYFiowrKjA/wEekE75TmaMDjEIES2umkNgVp4J5TgRfa1mk+JT2lazY0Zs7JoSzU4VF1GpcpnQmM/re0tj9YpOE3NKmJb+4MAHPYzeTH3xiVJ0NazjooYCXlJA/3kWMQCMVvz90/IXkcovpHmUcaKzAPcwuc+CCHd/ic4exdNDaLsq5MtzPqUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sH4CCykXsnscGP55ZPEp5Jg7/a3x683j1jP8wgD6W7A=;
 b=EB5xk/rC+px8g8kujsGN7usgpG5Xu+J1HPe1Jx0NhJsz/q5/MzqTvtbfSWXJefClsBsmwMR23YDYl/iSL9zLIBpJ5mCoeMzKaJqPfcIYH+XgddLgWWAlFf83SnXO5AdC1XH+u8a1lJubDAH4rox1NiT6SVe5azVpDs7UVaHqASc=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB5509.namprd04.prod.outlook.com (20.178.232.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Tue, 12 Nov 2019 07:07:02 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04%6]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 07:07:02 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Mark Ruijter <MRuijter@onestopsystems.com>, Christoph Hellwig
 <hch@infradead.org>
Subject: Re: [PATCH] nvmet: make ctrl model configurable
Thread-Topic: [PATCH] nvmet: make ctrl model configurable
Thread-Index: AQHVkIuhfS0yIueSIkOuObr/y5OBWA==
Date: Tue, 12 Nov 2019 07:07:02 +0000
Message-ID: <BYAPR04MB574989309230B5DD237A644786770@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191101080855.17970-1-chaitanya.kulkarni@wdc.com>
 <20191111103421.GB6127@infradead.org>
 <829AB08E-457F-4E8E-8964-DD3ADF9140BD@onestopsystems.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2b3fbd51-55b1-4d44-d722-08d7673eeb3f
x-ms-traffictypediagnostic: BYAPR04MB5509:
x-microsoft-antispam-prvs: <BYAPR04MB5509711DFEECEDC9052BC55B86770@BYAPR04MB5509.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(199004)(189003)(51914003)(54534003)(2906002)(99286004)(74316002)(229853002)(446003)(7736002)(9686003)(66066001)(6436002)(476003)(256004)(54906003)(33656002)(110136005)(316002)(14454004)(6116002)(55016002)(305945005)(3846002)(486006)(86362001)(71200400001)(71190400001)(26005)(558084003)(66556008)(76116006)(6506007)(66946007)(76176011)(53546011)(81166006)(4326008)(64756008)(66446008)(7696005)(81156014)(66476007)(6246003)(102836004)(8936002)(52536014)(8676002)(25786009)(186003)(478600001)(5660300002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5509;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RwB++KjYhFDb7Q56YJY1EaHN+LS8WTMeVvUMHYvf+P7GcKL2zDtCg1I6qVADcbjoUo+3NnShxABkpabGHfjLzSkTa5cKWxy+zNXzszo2x2DCQ+AWbJzmZTJPLXhBxvgwx6Gzigvk1x7AsAI3KXZFNbh9xw0eJvaiLYvT8XzeCBtZokN30agW3pDLkGU5aVXQgu5phgif27gIvldLBLlGQIwuE1a5suFH+1kP8HIU/ALIa8wOQ61v3Pbb7PsYVnt9TAqDtmLKRUzdDqZdO8kBVKm1pkrE8NkFzfBy+yL7Dt/xTS6TIxYLZgXvoMtrfX3/v/UlXy0gbF9BB/8ZooMGvaePDL/4UueJioPFK92K6JExjrdglo/ZAiSdY7MVEw1syNvTHR7PfLzoN0wmVGIq0aRL+18X7ZRdl2gOGV+jTa7hnmI32GgKgrHV+faKdUHk
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b3fbd51-55b1-4d44-d722-08d7673eeb3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 07:07:02.7268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dT6P8B2qB5fPav7XaVVKQmKU8EhL3LDvuSbWlkUGnCRztD0QuA7184CKZt6bmcvPYu2h1PkHn8DIe0Emw21OH1EeTnE+5aJllpbAq5qeLvc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5509
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191111_230709_190208_F8C70227 
X-CRM114-Status: UNSURE (   7.78  )
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
Cc: "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/11/2019 05:31 AM, Mark Ruijter wrote:
> Hi Chaitanya & Christoph,
>
> I changed the patch I posted this morning and added the changes suggested.
Thanks for the patches, let me test both and send out with proper change 
log.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
