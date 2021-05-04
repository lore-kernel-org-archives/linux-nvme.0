Return-Path: <SRS0=iWk4=J7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D63C433B4
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 21:16:26 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D654613B4
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 21:16:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D654613B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=H9E4Qi/4CE6dNkEiuxxoe+eDVvQpMkB3Rz2ArW5IHzk=; b=qGfVwT2bI13UbE1JfLctfbv5F
	bD1BI2WusSKaL+P6Ex/8flL9rjMEio1EldR1RbGGNgrRvoIfXf7TH27WR0gTTAc/TgLXZkvKzoOSd
	WdcyjNTfx8irL4zYphomo5xO5yGCt93PbWybCNyUSAQtVg6w9R7oxxOCPFZdybpj7lonVCJxQIDaN
	xtClAEgB0QkFWz0vXHEV/Cnt+v1EQFtXuH8clzPL5ZLGSCpwHZn8SKfJmirMb1xnRpaV650m3u1be
	61aCbrDY2YQVS8mJePgXZoG4Sk6xjy4EwqcwO5nnNEPOu7owET/NHIf+5TvfNwH5X9HP70eF2hQA+
	D0GC7zCfw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1le2Ot-00H7EW-DW; Tue, 04 May 2021 21:16:15 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1le2Oo-00H7Dh-IK
 for linux-nvme@desiato.infradead.org; Tue, 04 May 2021 21:16:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
 :Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=sbgOhE00rDxMQjO5mzUS9yJvj+Eg+nNaogE9CfO4p+0=; b=bahgxf7nMBiIRy5VYuNtFguTQK
 H1wSxyxXrdQZF4JSItdQByvFoKF5gf0/UQ4DGSWZmKZD1ltqlrCB8rQK/fHV8d5lISeBXQR2/3Fi+
 rQ+DqGmDz2SO2vHLBtGI+DKneMBGdVIICSFTW6maEqRkhJ60Ob4byI6NSLItfJ2LJ8mgmr11s4PRr
 tngWhhkZzMjkzclN+nDKMwYgjwiDrlq0RgEI8ujo+THQMHSH7lZ8+wgSAQMsH8B/Jq+MqFRapt5Ic
 DWp1FLAvxpO4J+PxVQXghPIncKjWizdlR10NBjQ3oVewFAB9bYjmAJ2EbUkPRMsuB9ulOJ3yV57UN
 UOXm9C/g==;
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1le2Ol-004HFS-Vi
 for linux-nvme@lists.infradead.org; Tue, 04 May 2021 21:16:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1620162967; x=1651698967;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=KZ9pWMEZvIsd15tiL5wSntRoXjZbqAsV2THeGOYETg8=;
 b=Go0YT5D4G5P806Ol0WUDF5+Gw3kLx/4yRzs4xkOVoeZhR+NU8oSCd/pe
 VbZpEF2OD4RV6ARSJMOGtM5GqgX8KHEl7uorhIQG4OM/A0dI7AdqmURnX
 tPXaKimHtpqQbp2ZhBDOunSf0sut0z1bubmSvFMYV379Dv7BBm82Z+TVn
 cCIdOxnbRxes560hPhxdlkhGAxBQvw2snt4FnZiOm8SdtOgQqtzpB371o
 1QBhVBzBrYKk8YvqEX6+OKIA8SbWyIoSPMADMyW+ZyvgeYPRjnDbwaw3v
 4VhZfkIea+UYwWAFtNJixYmDJVL3895YUHeXcPUEE6Rk5MGHKo0iaZdnn w==;
IronPort-SDR: 1YbeLcAFre1EDAbvJlTQzrYDbTEoZECH4MASgDAMagfRbfBU6kLxz2wdjH//trs+5IvFR9j30z
 67uY6Yt/svYHw2PodKqfz9xbtosc0V3MXxpZrhBThzcG86isicxFPJGZTkzaEGMLFfcTugBudi
 wD7qZF+DW/0j0SaGijMFvYE4Rp8ZxCATvN059VdKW2Rpc1k2vm7HQkAUyNFwWL4Lb/iDp4mcfP
 s2VL7bjLRjGKMSWLFW2iQCSm/st+RDfn/fFQudw/eLEqudnjqYXeQyNbfKw+IjnxLGOI/7TcGk
 cDU=
X-IronPort-AV: E=Sophos;i="5.82,272,1613404800"; d="scan'208";a="167126919"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
 by ob1.hgst.iphmx.com with ESMTP; 05 May 2021 05:16:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i54DQQIsbBBO/qkPF7VjR5lOyUtWtve8Z2Yjz9HdTFG6f0dkQkJQ2yVwZNmN2651fbfqsF35EirMLmh8OX/7M0xb/pUZG9Uo5QvixahI7XLEtpt8NSyOoW7m/HQ2EaR8xel7LZIxcn3TrUyz+HIL2d0FhZEUktRO3ku0/AmDjD+sbN4ekWwWtX6vsF1QMlv2xW4DFHvPkBFlt9YTgjYCodBt+QM/adhjG4aOpyfmccj5iyKPLkJg0O4BYYhYNqzhvz7zW153m/zDDq0PXmkll54Ns0hXXRG/t4akh0yIv6oCKDUflWeZtwQFJFKfmKgIkk6i/UdI06k5AS/3ORTCgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbgOhE00rDxMQjO5mzUS9yJvj+Eg+nNaogE9CfO4p+0=;
 b=lgCDhAaE4y8/DvF+fnGk8Vh2w8L5EbEMGEtty6kuW3i27o9innGF5nvdkzoC0d23W4lVPqPtFkN8hiPnD+MWmXnGZjLcZ+2O313QVinE95Qt5xkaXURuoG6KnX5Z5l84QGdfvIEyOEr7oMgJaLhoImVL/YrpytHiCliDhbcqAaHd4xbiptZrErmLJVswKxz32mkpqVh8jtw8pWCWLSdZuDPgwmZpMRe7/LJuLImHroWuRHlyz0fditXg6UXhLixC0cmUyh0fvXLH50cLPm+wP8mJQkdRx0nELtYLgDqugyu5URmq16Qftv29EYD+0EdzJM7xb+U3SGRDI3YkGLUr7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbgOhE00rDxMQjO5mzUS9yJvj+Eg+nNaogE9CfO4p+0=;
 b=zCH6CPFWTfMfaTO+iIKOl0fyRkG0GacRHrg93aF6vEmlP7GjlrFOU+vWBtfAPCPbT0Rqu+tV57qTjL7Cu7zxw7a4iBiOkNLl2FfTvIufBtrel8HezMyAu+6N+Nyo5IZncd+NLBiNAJl2zKuWheA9DYJp7D9Y8xuTToNdgKjQFdE=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6551.namprd04.prod.outlook.com (2603:10b6:a03:1c6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.43; Tue, 4 May
 2021 21:16:00 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 21:16:00 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 0/2] nvmet: consider req->sg_cnt for inline bio
Thread-Topic: [PATCH 0/2] nvmet: consider req->sg_cnt for inline bio
Thread-Index: AQHXPSeixhGGwikB3UaLR55khXsxP6rTDFuAgADOsjg=
Date: Tue, 4 May 2021 21:16:00 +0000
Message-ID: <E4E6CC49-4F86-4504-8BCE-0A7CCF3B8797@wdc.com>
References: <20210429184357.9185-1-chaitanya.kulkarni@wdc.com>,
 <20210504085613.GA21953@lst.de>
In-Reply-To: <20210504085613.GA21953@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=wdc.com;
x-originating-ip: [70.175.137.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0cfcd74-28b3-4d7a-b7e9-08d90f41d117
x-ms-traffictypediagnostic: BY5PR04MB6551:
x-microsoft-antispam-prvs: <BY5PR04MB6551CA0EC250E27970D1873E865A9@BY5PR04MB6551.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LDqZi5YN/CNN2GcwY90KGCF2tQFDynMYoIRBM/+7kt2NyICN+bizXA+h3dxhQfeiDrdcrGOv8xBqNvJX4IGL4HeLTESbPSVZzjBB8Er9noHRvEfLukld7PVvMQH3nveANa3ml+tKZk6z+OSvpEYAZUGxf0lx1wBRQqbNBfAq1uZ7i3AppMJr1vnUZQWYi8gOWql2T6NNKduj0ECvFejTueRU2DSYjRI36z9JeInNO8yGUp052kwyVImTnfPL1CjgryQVHtz0T377elluT0HNmig7H9nmNWo8/uqAORSn9+X66L30uhwRcCSuhQBToQuQx3lSQ1uAjphtKuyUwDl1z/jfkN8bl6N+N6N78aG1nRXz2Xgc+wHjoZzabtHNp2XP2OjJa3vNMKgVxv1U2D54cdkNoZiUxVkowzGNOkQbYBA/aJ9yQz7YSqxB4hypGOuPc8ZWbrVdiCzy/2HNbS4BDNuxfqvTzPctHutEuqtgaBSixierpjuu2jfM7A9IjmSFyvNarnPEQwyEMh6KgEZmDdqFAOcGhDxEIpJkg7v1ZlitEGWmBI4l70YrI+zgseiap01L6pEx7k4iNLQAptvGFtFWU0D6T8yXhpAKcCZqg/xkh4kfzIV4iJcx+lBa8QRiAydSy7IPVLVhqfV4exRDZhKJKv3TAFqs23EtgPd0jfg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(39850400004)(366004)(346002)(64756008)(71200400001)(36756003)(66446008)(86362001)(83380400001)(38100700002)(122000001)(478600001)(66476007)(66556008)(26005)(2616005)(76116006)(6486002)(6512007)(4326008)(66946007)(5660300002)(6916009)(2906002)(4744005)(8676002)(8936002)(54906003)(316002)(33656002)(6506007)(53546011)(186003)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?JtpZAXYUtxGE7RV7Jmi5yb+jVqVAUhsiRdc+jYxBk9tXrBYDF+xKhGQggJT3?=
 =?us-ascii?Q?VczxUeg94nKCD6++ZMipRRp2m/oJjW5MORB6mdF7huF2n5SC98KJ2tCknWFh?=
 =?us-ascii?Q?V+D8kj/f/piPsVvfvmdDBwBlx7lVPDBYftP3XUuWYwa+bBzoAkuy8QiNTNNl?=
 =?us-ascii?Q?7HuSxIV5geNVZHt6r12Q4iUh7cTaP1kg4LnCuqpRBnqUXaUFSKBQAilSnFlG?=
 =?us-ascii?Q?TWe+HFw10/khzuBPmMt9sfxxtyBX6/oY7MR14Hdbt3vVrRnBwezlATUl8Cai?=
 =?us-ascii?Q?66GZXguMJSuqxQmkLh9DXTmSaiv8r+aUvmvsaPqYxf5h8HcGgdKsaHoVhpMI?=
 =?us-ascii?Q?rSEp2WZlvlBGcjEPk/bYOMZ6wt5PcUf6aU8iwnNQMDGkwsT0GlOq+oGh84SL?=
 =?us-ascii?Q?psn7TrCezs8oImxauHm/okE1opZ/xsMEzfwfRcWsLk2T1OJOCfE0cqh4sBYH?=
 =?us-ascii?Q?ElPgQCF5f6rP6yXEVfOP5BqmBkgC/r90pNblp8XSsFMBeUGCz2bPV1RtABUG?=
 =?us-ascii?Q?QD/5Rj5S2SvlOf1EIc8l5oqYmUAgRHpl9WctjnbAJLlFZB68LuCZQ7OfC52e?=
 =?us-ascii?Q?8i2y5p5fxCbzhCmPvrNCsUp02yXmcemPTLCpK/IsYuA1Cshfb6hgEQ6qdWsT?=
 =?us-ascii?Q?YUMlCNaqvYo6LDcn7vBh+FvBXGcZ18LbMF6cInD3jM/RnCl4FTzZ80Te6Ivc?=
 =?us-ascii?Q?rlh/cjmmJjoarEIHFwRPvTqAQoExWliMoV51giP4AhBFFvoBu+bhGP61xHEg?=
 =?us-ascii?Q?jLhiHqgBwswUYZ7Z7eFqDRacvM7RJyDauDJcn36zg1WI6jcRMk5Gqn1ygW1U?=
 =?us-ascii?Q?KMVcop6P8T8sZ9JSwJQULJNpO3Wwv1RzpBLhP6CSPzosEzmdIXVv6cpuUi9g?=
 =?us-ascii?Q?xYKKtg5iYr20F20OvFq6luxF7nSx9nSeW9YwSriabLisDK+W2NWg1XSimyVp?=
 =?us-ascii?Q?j+PGG5wVr6hJ4S3XueQ+EzgIZE1TjpY6wdX76YXBMSC7ev6RIQO6nHw43xOF?=
 =?us-ascii?Q?AM7TAXrInYzS5UiOTeXAqKA/5j7PKWAIKu3hegGt8uxftvnCsIOPwNUVsbmZ?=
 =?us-ascii?Q?ziUSbLlCggS8TsO25MSPniA8bCpojOzsi45VKUGn2LRjDD/ezX22lXtWeKoU?=
 =?us-ascii?Q?utwOSkd+JXstzAei7gFapzEEFVNIpqLk32YU/4LP65hNkof84bENwM+3nY+k?=
 =?us-ascii?Q?/hVyb8qhIsaXEa3Ubze9wRiDKTaZPSrs3x8ZwYkf6QAKFehD5G64R5R/g+mH?=
 =?us-ascii?Q?ZU1Iw7+HqxM6gD1h6rcQIPplj/SgLY9cnSdOOEMN2LXJ8kb+68nYm3SP8T2v?=
 =?us-ascii?Q?l1ox2hzfO6+kD2BIiokf/hI1?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0cfcd74-28b3-4d7a-b7e9-08d90f41d117
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2021 21:16:00.3370 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fn013qq9Gqlu98Ixz8Vlq2mjO0LoJ3S2obnfzTOPHHJQMCi8NbZ3a5E0a7DUH5+73lWmf3Ac2RkqsAirz55Li6N/6lRTge1BOUy7837iw3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6551
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210504_141608_131940_C4B9CA47 
X-CRM114-Status: GOOD (  11.98  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> On May 4, 2021, at 1:56 AM, Christoph Hellwig <hch@lst.de> wrote:
> 
> How do you get the fragmented scatterlist?  Oh I guess this is due to
> nvme-loop not using our page allocator but pages that come the
> block layer?

Yes, with nvme-loop and the test framework issuing I/Os using malloc allocated buffers with passthru I/O interface. 

With respect to Sagi's comment do you want me to send v2 with fixes tag ?





_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
