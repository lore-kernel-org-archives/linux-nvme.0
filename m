Return-Path: <SRS0=DaKL=5S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D545C43331
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 00:35:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D37002063A
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 00:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DoiVgVz9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="reEba/09";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Uf8r5uQr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D37002063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=5LoIFCoZbwI5ArfVx+XRQKK3JkelPS1N8fnHzyI2rWI=; b=DoiVgVz9sp6AgA
	H5OziTKBc7mtcewO+kV2Brcr6PlMKMKDEj2i0Hwv1+7LIRZuxq9YCc3Tv44in2EVIoOB1jK4wHa9m
	Xbp3DXBqM6ApwmpRgwJXbRdo8p1hOzg207/6eXKNjIYaD+c7z0e5Oaa/qb0fFFEYhYfmozm/KJZW/
	6RKfjmsVE2Uicl2gvnaI/8lV3PPBsGx1M8PN5NS5SvsWiHIM1Ar8KePWHy2FQpeEh6ZzepRlxojWV
	a3O9Toq2P+F54I+D03jqoouvsY2vTpS+r2OKKaJuniz1fCT3B4MOEquT2UGCM3Y12M2Zhj5PCDhI5
	PhDaV4Rcyyplj35tJkTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJnow-0003LQ-Fz; Thu, 02 Apr 2020 00:34:58 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJnos-0003Kp-Uv
 for linux-nvme@lists.infradead.org; Thu, 02 Apr 2020 00:34:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1585787695; x=1617323695;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=dY2pCfRDHH0dihy2JnH+MWPDnxR6THDJSd9CO+woKc8=;
 b=reEba/092Rwli5SZVOMIb6C2vL9k+Lz4Q/Pwk+WPBZsZHLS/uXnm/bNL
 tgEzCIJ4Q3/4RP/JpdzVGU+CG+3xONiQLcuQqV7oIr+mbHn+UTMWqedc5
 QSbbGPan891kd3GzFbYA+MrEmrJ69cawFupUgl8Uow1ici2Fji8O1+/No
 xupl+B7SPl5g78aua+VQvZ8hTkw83vWdR4m+dXbTJp/4BNCe1tfP1rbDa
 Gpl2dJr8Ax72qEByRtCKKBgCo879fvZ29dj8+EUNkJYYjHSULti20H3Z8
 8mG/QaJmloP2opmWCEk1N5poVHKjbjzaLV29khH6DnKl9UtYlsslNYp8x g==;
IronPort-SDR: jZ2m8l4FP8MnHMzVXvJsESbJGtmcbGHr7SWMyq+njIyamNXcYvJdBWDV/DtsLBxR9j+ALBBTf1
 sgSxXV9Gof/dgvzYW+XB7fIAHAcn1dhI7nyjnZltXRcRyRFuJWIL18E9AVCCTL1CbT0ZiZugh3
 2p0d+LbFnA1GCmSjzRPMqwVI3Kv4OVN7Bl5SDEqkgqJj2Mr6GnfhjGsN6xZEI+wxNEqvVdxdGg
 5j4d2c6zZyF7oLjnP1sSW3HxH0WSmYn3OvculJ5JYo18RONQveMZ2NJct+lwgKTEXReDeqN5jm
 76c=
X-IronPort-AV: E=Sophos;i="5.72,333,1580745600"; d="scan'208";a="134683912"
Received: from mail-bn7nam10lp2106.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.106])
 by ob1.hgst.iphmx.com with ESMTP; 02 Apr 2020 08:34:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Km6F9L4V5SF/4jQtOPTOCSqaPVtkM8w7FZLezgYK7mbr7LDFUFRpu3G0umcrk7+o6Z/ViJxkmDryDiz6aZhPHig4ujNpUYedGaekOmKefJIYcY5jndK/ytH7xKH16Q52Wy2XHMu5qWTrNWYWklt2IbFyFp083TTZhokRaVJ6ixYXlMJUAa+3k0LZxuEbljv8IDnkuyonj7NugUbWQVjkHbVlbChMHmrMKjlb18pECl8J79jT4odlum1qWC/z9K2+KISCD5K8tc/kvv39wtOaPom+MmU5mtClT9mWkMtifYelyvsPay9HEOuacgC51JO7vOQaxnBRYkqJgl8vG9uPyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dY2pCfRDHH0dihy2JnH+MWPDnxR6THDJSd9CO+woKc8=;
 b=MRICp8aP7dBs4rysGGf/3Y/Z2B+/adEdpYwZocWZcQlceRIHTaF45qCheEg8ZXMC/QReMzoKEZ21cS/Tq5hJHJ7gk58ZhxgBEYzDc55+rT/P2AAGXSRvJFoxQHfHj0q7AzvpMqkvc8X4VfTKHel3D6VY+YbyYusIg6m8k9Fa+ZkKLfzSAl5qOSvzW79mylQnldvF3JxCdjx5nIuUD334gRYjZ4F31P1lbmldnJ8onka3iGRL5IZQqk3/4G4aDiJnqzURUFJofNZq3H7xtf8R364k5k4w524PC4xJLX1wbROVMN75fzh6bNNdrcXIk3yXsPpV9qZJGKHAUbJ/BPTyuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dY2pCfRDHH0dihy2JnH+MWPDnxR6THDJSd9CO+woKc8=;
 b=Uf8r5uQrmynJtrTgsk3KfyP8AmvskMF9PH+vJw+u3LYSb3bVaU8Q9edn7bLbmy5gip/vB2ETafMaCpv8H8ew2cPkzaU8u+q6ukhbFqMm7q/9Uaqe9HtFxYaVDFkb6qmVWKJKqLFJqIDGOFKJzxK4W7tG6YKVZx2tGq6laUQV22U=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6246.namprd04.prod.outlook.com (2603:10b6:a03:e6::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Thu, 2 Apr
 2020 00:34:49 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733%7]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 00:34:49 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2 1/2] fabrics: add fabrics_ prefix to fabrics operations
Thread-Topic: [PATCH v2 1/2] fabrics: add fabrics_ prefix to fabrics operations
Thread-Index: AQHWCHAVDn3nJYhgK0KHPGi4dGL3YQ==
Date: Thu, 2 Apr 2020 00:34:49 +0000
Message-ID: <BYAPR04MB4965CFE47742A3A83BB6875786C60@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200401215344.2519-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5cdd9853-d5ff-425b-79bb-08d7d69da6b9
x-ms-traffictypediagnostic: BYAPR04MB6246:
x-microsoft-antispam-prvs: <BYAPR04MB624633BD9339E1D60470F9E886C60@BYAPR04MB6246.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:229;
x-forefront-prvs: 0361212EA8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(8676002)(6506007)(5660300002)(81156014)(86362001)(33656002)(186003)(478600001)(110136005)(66476007)(7696005)(81166006)(66556008)(66446008)(66946007)(64756008)(558084003)(71200400001)(316002)(8936002)(53546011)(9686003)(76116006)(55016002)(52536014)(26005)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Et3hVu/UVBRPOrTeIadAnUyYCxwM32D0WPeoPnDrRavllLE9PqF41BIw6iDK8gEgz+MUPgvPk+QnKc25xawWYYob+9t5nboEeBfpOpzvIJ2/YUazguF7n2CDuklPhwQOoMYqhmnSzu410MPS6cTg8tGxbRzlYe8Ojddt4vxK9Rd1gn7zdVRIHWk5cz2/eBiRSsEczRcEMFJCRDdqAgIbQJFIcX+4KxPMxEw4i+ulEfGawlAd7+kGrbuKB51nXMBVnFz6xmA3lP2O2m7nO+72VVuvPPuZ/KgjpIyUtt50d4MECpsOAxZKDoqG9e5Jd+mv9PUsOkXTjQuC8xdbsYedCOiEtPkasJUYhnmTNZvo3gFoOAlYOq5gBLXgoonYp+WGoKjBTX1EUccxFQA22KYHPcF2S6B78E2XA1DZ0C2TQt20/I7YGbs+YUas0USJtsCg
x-ms-exchange-antispam-messagedata: wF2D5XkO6dD5IGcuh7rqBli04Jm5lm4OZnXFXGw2aUiXdJWy0CYenrfr2m8BG9WDZNB1d3wXGVcJFqZK/rPW0m0/twEaJcE0VefAB/D0+kVosBmoMFzPFbJl4yT2V6IQn3nR/aVef4ntaJ3Pn14EMA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cdd9853-d5ff-425b-79bb-08d7d69da6b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2020 00:34:49.0258 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zD8t3EGOEhSZ7yIzKaCp1rN/mXq3Nbc0FXKF4wd7T4C+fpn/5cvRPYuh6PFc0e1tSCJoypVPS18nUu4rPOCxnnedUvryDPOU6Wz9gJDhdZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6246
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200401_173455_068614_7C6AA640 
X-CRM114-Status: UNSURE (   7.91  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 04/01/2020 02:54 PM, Sagi Grimberg wrote:
> discover/connect/disconnect are generic names which might
> clash with other external included libraries.
>
> Signed-off-by: Sagi Grimberg<sagi@grimberg.me>
> ---

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
