Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04E2C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 02:01:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A268C20792
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 02:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DvirLlsx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="F/PYA77l";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="cZferUtO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A268C20792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=RDdsUXlRRS7GZVM6QoODRgOG7D5PMGH40j/fDPlrI7E=; b=DvirLlsxCKWQAg6CDBm+m60sv
	FR82ePqjOAVswNDIjpG2NeVEOZplM6m3zUwEUyF+S8JYu0N3Tir6+ofEi+5T1++ysbuGRqzW978/N
	tpfAqn8n5cYiZBZEqO9t3GVitPAXDMfppswUprTfSwvegVTkf87UNN6rPjjlZE0jjtvxCfbHfXJii
	RvJPJ31GnasXCXqysYoU10PJF35YUOUr9Il7/ZX+80GJvstn3WyGqfL/ASK+8ff0ccokIzeBS7cnF
	QP9xsDdKelcsy4jsP3m6aqcqXG9rRk84TU7NHkon5aMFuqWA8tytwKCKuid5hlnZWymRA9e/i1zja
	JQmDapa9Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3VDb-0005GH-Q1; Thu, 06 Aug 2020 02:01:19 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3VDZ-0005Fp-Ba
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 02:01:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1596679277; x=1628215277;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=XUU65niR14ZvEgUOqy3aOFOYZkbINWsDgKOB8fd2lbU=;
 b=F/PYA77l71wi84Ks0RUefwr8uA+sQU6VWtMO4gLnUGMQjcIktbqfJexu
 fbXaQA7RZmuhUkPghWnSUnr/l+ATpGQ5kB3G56MzbNv/r4tB/5h8MrFw3
 XU0yIPB/bYuU9eF/jFmncwDPbvEM1jy/tkIbyGh2seZL33e2jF5QGZVPU
 j730XCzwMnyVtQpUVKUevcBt8gGIfHoLAnsl4wgvHYRJJGLiBdPrDJn1U
 NYINg2B1yWFIPvNvo4IQrYfMGUK+4i6CreDHfxUXogro0rtpNw6bE913l
 hjcK6J/Dmj4BGCm3TuyapBRs4ZUiPoHhooL4jjPFuQKltoRr2ky7/KyMs Q==;
IronPort-SDR: ercSSR1c9DOYqTrjVHA+HGc7Yb9aPqY6lMAFv9clziynM5zh0Jb8QNh/yoHoN5XgOxCWgpEDgU
 BC8N6VRWcVa28Z8gH0FqyYbuqYRhZ3Evp293R1TQI4e6YlhFtRNQGG1exCdn2GZgOLqfpctt8d
 rfyigD0q6MCBcyid7aQSorptG2S3O+pn/FQAHnpoXR3r3mRwfUkcPfQHV4T/G/RvA4Ugc2MDw6
 +O7gwnws4Qyek8Fua5b1UM+dgpFGMFqSgM2rKA6M8dgBT+RplAootkFujIoS7mcxpTeXsllB3E
 GmU=
X-IronPort-AV: E=Sophos;i="5.75,440,1589212800"; d="scan'208";a="253612735"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
 by ob1.hgst.iphmx.com with ESMTP; 06 Aug 2020 10:01:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SmM7t2pItx4YtKqyHBsiDS6Hc+zjKvjfcOntF8KkVMmsTR4q4wF+tP0g1dkh3MxCxCPJGbjpAr97FU0Ww53ONMRvGh1wFf15Pa5r5pya1CvpHTkKkdUIXRM7JMc5jItuoESJTVHl0SZfgoIRkcmVUAePhH3OwSqDRPaMBINVXrX98m9jCfg/No37TbM8gXTUQtRhoTWR1EAd8nJUgOGgMy16QEkwdc1H55GShpPt5i1Qn69eqIRNB0ADkxEtyD+frz07hHpE6IHSRQjyGOqfdAKe1xendBIAc/XGlMRRBm0dm+FfyBCkVUjHz0Bq5i4baKvHIVIvTsNmVPNFkaGRMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUU65niR14ZvEgUOqy3aOFOYZkbINWsDgKOB8fd2lbU=;
 b=DjMRmMH4w0baldCr21cdgs7ptNF+nYw1yJBo4T9zw/EDCD1RWFVpzZNiODnK/XZIeagTHky4gYbKrMAhXTFmfrfQ+ww5ZH7LcMi+WrXF2bp9VOTrQNutv/GrZcFcdz49IGOKZH9kiFZ53MVREKp9656nXGnflHTM+u2U924o+Z9Q10USpT0UCK3fl9f9EaiCSFWAN9Q1jVbel5qd7Q1Qg+F20H7aGeViZa+amLH3iGH1tozaAZ0NuIdSa5ZP5Zk9lUfT55QXrot1YaZws7yXnZxSEH+Y+wvR77KMcbsiHdc4I9FZztqqee5qKj50xFGrQFf61ZG2BSsGr5GfPxxK5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUU65niR14ZvEgUOqy3aOFOYZkbINWsDgKOB8fd2lbU=;
 b=cZferUtODEXq9gm8lFFPXkKZqZeUW0UUh7+SGpfAhqALt7q/mzyVdMM1PrdEBr7hYm5yfde52Pivdq/u/7BHoKNQHImBrL1BIIBnpfTyx/cdc0CG9YoB8d0EMJHGGp4QJOzdGWTXle+SVWlIQau/7nlAbjtYc0qk6z0skLroO74=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5525.namprd04.prod.outlook.com (2603:10b6:a03:f1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18; Thu, 6 Aug
 2020 02:01:12 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3239.023; Thu, 6 Aug 2020
 02:01:12 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvmet: fix opps in nvmet_execute_passthru_cmd()
Thread-Topic: [PATCH] nvmet: fix opps in nvmet_execute_passthru_cmd()
Thread-Index: AQHWa4WuB/SmK4DZYEq5V/CCHY245Q==
Date: Thu, 6 Aug 2020 02:01:12 +0000
Message-ID: <BYAPR04MB4965A923FA197947CB02CCFB86480@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200806000804.6345-1-chaitanya.kulkarni@wdc.com>
 <4c0eab62-d29a-f1d9-7856-78af8d6fcf48@grimberg.me>
 <BYAPR04MB4965F41CEFC7DAE474CD3D1586480@BYAPR04MB4965.namprd04.prod.outlook.com>
 <c31c1600-7b9c-f2cc-57fe-e8c16d857d2c@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6f8b4e96-1216-4ee1-6ad9-08d839ac9878
x-ms-traffictypediagnostic: BYAPR04MB5525:
x-microsoft-antispam-prvs: <BYAPR04MB55257E49D1F9AC3D91D53DBE86480@BYAPR04MB5525.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9RDdVcGj6x7G9PSERFO6czgLx3xeiT3vnp0yLGu/Qzdz8TDacvi3fSXy9dsSShllSgK8XQnVtfE5ILlRoz171whqDvhCgDvcLSuv4OtZ7ZgWDjk4SRdI57crGGrJjijW4gKOQMUcuHJgLeTmA+cFTSgxiw809ctIPKs7saEVeiROBrG9EzTpmAWslqlgB1IrjnYEfTXZ+6hRadcpebJBbMtNzXXl5xa0ALmzBLx0eL9VHdrfo7nrXPUB8Qyz/REIUlBUDSjY53UTClToaUc5Giyg9L5CFlLbB6I3GGKO0mpjL1jhyhx/93jjR4YKYOdRwUwGZs+tQEU2PL/jqICxKA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(110136005)(9686003)(53546011)(55016002)(26005)(478600001)(6506007)(33656002)(86362001)(186003)(4326008)(7696005)(558084003)(66476007)(66446008)(64756008)(66556008)(71200400001)(8676002)(76116006)(316002)(66946007)(8936002)(52536014)(5660300002)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: Vq8kDyKDrCfBMUe+1oUZSy/y18OpUSwM28H55XdbCaFHy6THZIwMN2Jer5yWvyq/YtP/JHwbd9L2uQEkqXvxPuE1GIDBaEZ9vqGP4VgQdsBLybCBMYTTLExtgoiJPWh8BOhePnf7qXORrUUZwWyvl9GVnx8nwVdZCAnAlqMy1Fr7pHrx6Z0FdnLyI1YCUJ69+Tkza51vJ6rr2VN7vSL1iWSQCVMifDyAUxSwRjtmkRsXkm49zky4pykh1KxwptiecKx8issy6+WflOTE26dtvBHtk5WRWCjCRNzpHgJQSXFGfeFf7JdS7B4YCS1GIAS40bZTKqmGUDN4zPkwSyVjxVSl8SBLWFJ6yDe2hIF2JYxdShMypZJKVvBU7Fa8YoBdkcOp2C3n3iOGFEkx3GF3HgkWYStg/03mWQ0muTkf4sfBSBpST9PmJ9BhvnCyVxHPrWSMRW6lJwiTG1hDzptP2yYNAxVwcktDWkaUf7jp3utSLBJErBWWG1RbKicjUeD9YNP/EV69MJzBa3Bjy8Ty3IY5aNfZjqaWKvnlM1g/8sjOp7z51okCzhPDt1IQPflQu2nrCsttcN3DO9144J47TGFgqOzhHHHA3eXjWHJCUqXQpw3NyBD8Z1ofdlTyXOYXWh4HCC7btQtMEs0dnXaXzg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f8b4e96-1216-4ee1-6ad9-08d839ac9878
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2020 02:01:12.7213 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PceZo+IiY3xEhkEKjXMnbzkZGmgxAwcc69nelwdqXy8Jf4Wem2Iuxxz3fKKUMpwinIc5YUeRhuL4URIqIXx9x3Irj843GzAocSX2KWwiU/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5525
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200805_220117_648494_A168B236 
X-CRM114-Status: UNSURE (   9.89  )
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
Cc: "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/5/20 18:15, Sagi Grimberg wrote:
> It doesn't have the patch. can you resend?
Okay.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
