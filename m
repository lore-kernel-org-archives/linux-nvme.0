Return-Path: <SRS0=Vg0R=YZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E16CA9EC9
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Nov 2019 07:42:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C33CE208CB
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Nov 2019 07:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y9nErMRd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZQ+ualYB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="curE0aK0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C33CE208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=VE0yw4ra8ASrbZXM3no1LPeq//yMaBGg4DWN3kj5Gq4=; b=Y9nErMRds7ov4d
	qoqXbmlgYFPTztKArMRCRuf8yZlmOh6bK5DIYZgvsf6nAuLT+1Vry0STyaqjmuDGrfgHOSWRhnYcQ
	VyjwX5jMI8gQqmuqkZhUjqTz+OG/9+VFzU+4IDpS4FBZeQngWaRw6SdrfUAHdmTV6AgKL1FvrdRek
	fy0BNrlJ3GcOcjK99XHm1m1NtYoL7j5nqqwWOlP97fxa5sQMKKSamUFq/dDCnQcn77WWranVYw4KA
	/FXiIIqC7BCgFUofRrQw50HsQvs9Sk+sTOGOBHIrOTV+ZdvPajXLs8c/tl6IpW1gR6y3ZLxZY788H
	GSPTLZaKGOt9ZBppJ9SQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iQRa6-0006Ng-Dk; Fri, 01 Nov 2019 07:42:50 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iQRa3-0006Mb-A3
 for linux-nvme@lists.infradead.org; Fri, 01 Nov 2019 07:42:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572594169; x=1604130169;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=PwIe7dRYRBgcETOZViDcgB2k7EFNaCX2xZh7LCgyDfo=;
 b=ZQ+ualYBthCb9R2eGK4Jv3y6dnOziaGmeC6G5iJp9V9tZeFlDeotyqw1
 jy3iSxVUeeh0XZlUhjYKXSiMSDKL2iVJxk3oojOx2cS01R2nUrTt3QMom
 ZqXo5AuaIxcU9nql9WtMOOILYbUXDpa+xrcTrdZXfpO1DE32yN0dSvMAE
 sE+3PXrTq2rbuICjtBFBVQOG18kSoMI3cAWuLRzLSVjBbBIHMQdy1Yc0F
 Op5BfO/sS2Mk72Rajlv+rkEprU2w/UcwKtQtuKKQBYwDkmpoTugOCQF6C
 p4+2LsArarNIiszDzxEw9oVoQEADu4tAas4Hl5Vhu8acWf1fBBRndxs8U w==;
IronPort-SDR: IuF1Dc0bwhF/xY6YMEaDF/YFOIJuDsNQxAMquxRFnoxcxKr6vXElnbymL0znOd7pwr07Z0BUb6
 uGTNIMH1oqVbgcpiXPkHeefHNkj09lEsj5lf8JR4EpvwydrPqkUSOriFXGz4eh61h+3gkw+CPW
 NVauCcH4xGqQsKyQG44T5j+x20G75x774IJr4v6VOCr+sItzTuPYLkJZAJVJ/I5uZoB7AkWrMd
 bg6YHTrQNTH6M1Lsns3Cm4Su5vR6eUG/3mk0gi9MpFxkX1aUXnCM+0Yqi577bf7ZeCFlTA9WMY
 u84=
X-IronPort-AV: E=Sophos;i="5.68,254,1569254400"; d="scan'208";a="223032493"
Received: from mail-co1nam04lp2054.outbound.protection.outlook.com (HELO
 NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.54])
 by ob1.hgst.iphmx.com with ESMTP; 01 Nov 2019 15:42:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alYQ1eaPpY3DfdS9eYVxOgS1N/YTlT8aqXaDoPKeXf9e8rF/OYS0Rg9LOKJC3TVW5VrPDuAgTpN1sm4SMfTMKCuWiX0A5EDOm3DCXx4q2RSqfVJ3gfsVnn9LK2eILkbJjhoiQ+kUjzsmKftFsLf+OAcpyRAjyLRfDEmoh2/botY+NxkSCrIPCKLS6dBsVQbKUe2Wz/nAjbiyuGOHhfCIo3omGM4MtNuI2EFivvlyit2qRTcij4iEnq/1JL4RIrP9PPShcQsOGQVwWhzkNnu3ye8WY+9PZP6wdv6bdZlpDA2Qld/tkhR5OYmEBXN7db0BJeiC3pTv2/vmHAy+sB8t2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwIe7dRYRBgcETOZViDcgB2k7EFNaCX2xZh7LCgyDfo=;
 b=HszdUt+rhw9jvH9LMrN32c8S8JfhzA+ETYJczEQWMETJf3yHmBMr//PMZCL71ulo5NjeuX/93qF804PbrIH9jrrvvyYk5qda2M5By6ZzSf8CSzSdV2NtYZ+uk8P/Ib/rabE/GlZ/aM0i+gaMm94hreTpsehvyT98cA8+cEzQusQ7s3/YQwet4gxMGJq1/hQrfKEMhihU+DCd4LCWTjR0a7ytOvK8sBOQxDWt7/oivpcCd6n5uVUoVQVyWWe5rwIG4Yhs6t1ztzOBh2vNZ5QLkLcF73yCK31vJBqLULMVRHB1DAeAA4piN+GPbDXdUOCYKFKj2MhviC0m3Mc4VIs86w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwIe7dRYRBgcETOZViDcgB2k7EFNaCX2xZh7LCgyDfo=;
 b=curE0aK00RCoEzseXAvH5EJjXUJKPkiWZU81eYCEWAy0sSFKrA8P6dajI4uziRDunTlHcq6MNe/u/Y0qQfnMpx8mskMvSBAbekYOTD84zmMHTi0m6n7msXmDgupWdchQQIUaLCX+mSTwQc+EhEaA6MO9EjATg/77oiMNpTgp10g=
Received: from DM6PR04MB5754.namprd04.prod.outlook.com (20.179.52.22) by
 DM6PR04MB4108.namprd04.prod.outlook.com (20.176.87.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Fri, 1 Nov 2019 07:42:41 +0000
Received: from DM6PR04MB5754.namprd04.prod.outlook.com
 ([fe80::65c4:52fd:1454:4b04]) by DM6PR04MB5754.namprd04.prod.outlook.com
 ([fe80::65c4:52fd:1454:4b04%7]) with mapi id 15.20.2408.016; Fri, 1 Nov 2019
 07:42:41 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [blktests PATCH 1/2] nvme: handle model attr in subsys create
 helper
Thread-Topic: [blktests PATCH 1/2] nvme: handle model attr in subsys create
 helper
Thread-Index: AQHVj1uq6KWVSR9vcUi6kuvCeP0e8A==
Date: Fri, 1 Nov 2019 07:42:41 +0000
Message-ID: <DM6PR04MB5754FD5709BDB1BEF52FDAEF86620@DM6PR04MB5754.namprd04.prod.outlook.com>
References: <20191030195258.31108-1-chaitanya.kulkarni@wdc.com>
 <20191030195258.31108-2-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 177973ba-4969-4176-f2fc-08d75e9f134a
x-ms-traffictypediagnostic: DM6PR04MB4108:
x-microsoft-antispam-prvs: <DM6PR04MB41085AF8F4740E711E40DDF186620@DM6PR04MB4108.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(189003)(199004)(8936002)(66066001)(6506007)(81156014)(7696005)(81166006)(26005)(6436002)(2501003)(256004)(102836004)(74316002)(316002)(53546011)(52536014)(229853002)(55016002)(9686003)(8676002)(76176011)(478600001)(86362001)(14454004)(486006)(476003)(33656002)(3846002)(110136005)(5660300002)(25786009)(4326008)(2906002)(99286004)(186003)(76116006)(305945005)(66556008)(64756008)(91956017)(558084003)(66476007)(66446008)(7736002)(66946007)(6246003)(6116002)(446003)(71200400001)(71190400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR04MB4108;
 H:DM6PR04MB5754.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JRh5/vOoDxeD70Yq9oB2DfDjScbqCRVgm5ZFSNWnIsgVy2U2JwRf/uj49t0df20WtR61qMN/NCuxhEic9dN5UYtRuZAahlkkkz85KGtkrkDFDVsjsNl66NXtbt2DTdNvkIcbWhu92cV4mfCqrxTDB6ORfptuTTRrwy/FupQuuS2DNrhA/n9MnHaSeaGm244Y2+Vj8774vLj8xFjVopYjq9PHh6edmO+2D+FPvWXXLSNKNU4d9MNLN6qA0MC+USBsZt3Jo1eHr1hUm99lhCPWNBMgzsDIuwcws2NAe56PDpseDnXi1uUM2Clz7bxeua+9YHyybWWqUwj/J92iVw23NEzi4mN/r1tjMVjjmBNaHWWMS3pMeGtOwA6J4iZTnowP46GIyv7DzLboyLM17gc1jmVoL+9oLc/r9KUz+M1p6I1nJiGW6nVRplQanD91eJHL
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 177973ba-4969-4176-f2fc-08d75e9f134a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 07:42:41.1545 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gzcMtLFc8B1D+bSN42VHZubMq7EwM6tF8xHp2ugo5NNi4jlKQeWRIRDLAynMoNAHhZri0BxHZZAhfHVAMSo55AR7tpqwChvdiwxYE2mIOH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4108
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191101_004247_386561_1BC638B4 
X-CRM114-Status: UNSURE (   6.98  )
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
Cc: Omar Sandoval <osandov@fb.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10/30/2019 12:53 PM, Chaitanya Kulkarni wrote:
> This patch allows _create_nvmet_subsystem to handle and optionally
> set model attribute for the subsys.

Will send out updated version along with kernel patch.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
