Return-Path: <SRS0=FbzM=CZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB5EC43461
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 03:58:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D43321582
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 03:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hqF9d94y";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="W4G7jSwL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="tKnnObhh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D43321582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=O+vhwHfUicZLLCrvljwVlqroIXpDR3q7H4s3q6xZ6zw=; b=hqF9d94ye45rvAjJrKMqzK3Bh
	Vi4IIxSkdNLnltObZOJzxRLNPljNRqR0pNEedVox2o85gRyJ3unNoHzoSW+Jt0xZzIuYSL+z3deJO
	iu/FylD5iLgDr9IMuwx5zj1bey1DXPEV8ai4vO+L9KDY5nxJu56+H72KMWRA+bvOlds0B/4nd1yzw
	glJMysxp8OeU3kd/w1PNcXbKdIc76AG3avZ2Fc2tQL2RaF/aPizdHk90m8dTkONgasQOUzNZzyGWx
	AJKG8R2vZSe2W49ExsgiQpcluY/ZZyBqewjlE/fCL1NdW75wEqqpG0jZOywdKH0m6Wrby9s0kslGL
	dv3RiJ2NA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIOak-0004G1-83; Wed, 16 Sep 2020 03:58:46 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIOah-0004FV-Vf
 for linux-nvme@lists.infradead.org; Wed, 16 Sep 2020 03:58:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600228724; x=1631764724;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=AL6PNq179cqaURj8bxY/LyW+ydX+baS++X7KEAS6g6k=;
 b=W4G7jSwLxIETCHWOG09VI+R/oyJJjmcoXmU4DlYPF9iSpw9zsW3DU3q+
 uFQTmZhmzmCSr3XGz1lS3HFabPKQyXZ8N9Y2dKTDs2ujbVW0woqPQxUEC
 2iTsPj9g85ypgH4bpHd4Cgefs5boVL0WRbisCa3AG4YdHV9Vt0z4hF7AO
 dkgWbAsH/nqBiHjb9UKJvXTHp5qMn56F2vNKUqVxGGE3ksdR31iK9RY/2
 tAUICXSV6fvUnC7z8k5Sy7wlHhohWtwVfxBtKeMN2+nYLka8sw+eOjCPo
 Y/M/7VUyjk+q+Uut0YuHFKlumP7L1wankHPD2f0ukwAR8w/2yuOuGZ6cN g==;
IronPort-SDR: zkqcvleuFyVYZL7ZJuWytnBBSQ6FrJtVBukIutQ8fdDapHEqK7yNgBFdm2XSweSdI6RZT0Sd0H
 fyp//zUenXOXeIMF2GDel9GqvvdaSjSn80Ixq3sRDMkd/9ZLudt/RtNxyEKEcCekHTCimtxEQ4
 fDn3iuw4bhWPc+2sg4EPlSfnC5XknDnseoYkFDALMbTG5IgCTzhHvZLA5Q1pf7wQAfNi2lrt9e
 8yqCFinDHUWbNpRF2isSM2tSiwHCo8TbAH9xrCT4kdYgis28IsXgEjt3+KdsO614BUYIVZxMce
 02Q=
X-IronPort-AV: E=Sophos;i="5.76,431,1592841600"; d="scan'208";a="147496409"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
 by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2020 11:58:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hpiy+urE54ZGhWtih9EAFHU6BiHr91ZkKiu1Ju9yJvDBWdDkJG8R7p53mXIBr1+NFJnHc43dCQKpeUZEomem55Sxa3ukip3+PDkeRmiruw8S61/lHmncnTvwyu3+AxE2yeFtybb2LtlPZ6xxcLjvdQcHFv5xdya4VvO/mKkimCNKilcNa3mE5/3VwtKkDqXn8ExL26u75U6V9CAth3REQOUnt50yYSBwNXIlBcwCDmb38tC0NIaGzIVHv3A/98g3Bp/O9uHPHgPiuKjgjV3aiG6bUSWCraJXEIjL7fv/PeGq3NOpGCn59AM5ZHWTjSvI/rWNCXBWrjjzFiIiKsthyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AL6PNq179cqaURj8bxY/LyW+ydX+baS++X7KEAS6g6k=;
 b=PXkU3twHE4aoFqsv/MwyPKxWkYtAB42aHVr1uxuQH/SaSEBymISdxJTxA5wj7YkJxc9//IXoEmQ10cpeuoo010zpxOaPMVHL09nB8A+V7FRE9+L7uoTUwSXP8yt0US0BTD22Kda+v1wYqtituGwd04EidJIdgQmw02W4rtRcCeBL1Mt6BnVT1nXIw1qq8MBKquhggU5kWd0JXHCwJYrcNGgmPgwn992JsfXbK3B3SKgFxJHdC+mRT3/nciasp2OS+uzv/G6cdmp1e/al0PxZgjT9Io2+LbHYBpCqmSlVqRGBsyvjxA8oZT18yQCzs6Motdo8dFB7WjUBD5MpjKbnig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AL6PNq179cqaURj8bxY/LyW+ydX+baS++X7KEAS6g6k=;
 b=tKnnObhhhF7RFHR0E/8ib52OKJ0W0OBfTEa2nl5pTWHjpOEymO8NbKLYAgsowiXR7qcwbZRRlYuHElCqw2Uxd3sqncgA/Sl2iwILLj760LjhFQVAntQIp5d3zVf2lqV44nkI1sZYEUWg0Aw2iLSPv2BzIwyhbM01KgW+k88cG84=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4758.namprd04.prod.outlook.com (2603:10b6:a03:11::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 16 Sep
 2020 03:58:38 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f%5]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 03:58:38 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [RFC PATCH 0/1] nvmet: add ZNS passthru support
Thread-Topic: [RFC PATCH 0/1] nvmet: add ZNS passthru support
Thread-Index: AQHWi6kYS4Kl/kkB30a/kngXP6nnUA==
Date: Wed, 16 Sep 2020 03:58:38 +0000
Message-ID: <BYAPR04MB49651F6481B57D6089744C4F86210@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200915214212.14868-1-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1e1a2ec1-a166-4687-61ab-08d859f4cb0b
x-ms-traffictypediagnostic: BYAPR04MB4758:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB47580C0F953058E611544E1186210@BYAPR04MB4758.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SwJRGzNMUbfUeyyrH6nkz5GJ43NYtmN/KAg7TRaSTxFISUAWW1NPtC8R1SzJEM1IxVTgcFyzyQOOmeFVncFa1lhkZ1Jmdr/sEPiu/8G4yL3zXC1y96rOWClo2Wog7CQusqBmBSRmR/VZhGOArSvPsAFagqTV0uEX/NAEK/YPiSzIlIMJOfddsp679ogBEHudTuIn9v8QbRvpQXL6U9uq3uLI9OXI/ghV53jjqGyyh6wLrH4hze+zPgClWmykyonbV+cvuA3FYhYhs6U8XI5uoxyzFPd9DZmH7DpNbPPPph2ALEcPT0bHyxCOGmtuScKYtIEJTlubP5YCvahaUmOg5Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(5660300002)(54906003)(26005)(53546011)(6506007)(316002)(2906002)(8676002)(33656002)(7696005)(8936002)(4744005)(86362001)(186003)(83380400001)(478600001)(64756008)(66446008)(52536014)(66556008)(66476007)(71200400001)(66946007)(55016002)(4326008)(6916009)(76116006)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: KbLFQWuUPpNoacBOYkB+7VroLsMf6new4SKLiYhyE2zqsZ4Go9FiGfk5W0AbhB6f+1wskojaeoEornj+LCc0RNnHSuyIICbRumd7XXPASAhqK2sTrmtZx9GN03s7kqYm0X3iCuwW+0GQXxf8pB2dGh1+KzniyV/Ihhlt0dTWBTK2iBiGGXnSnqTKZisAjWZ9Px6suDatgooX30TixugE845HJO9psaMbK2Uq9tVLSHFIo6d7O+F1xvB8622D3CnKUzZEnSxsR5+mK+LZ7M+FfDwVTT0pxkUpFWGHTmE1zWJ9p/lzXUn/4tCLZ+z1VbP79ztDEakw7scGtpmL3RoBiOunp0BEdIVhJEsLs7Up32Eaeern3UlvA4TEygrcFb6tCAbEqkPINtWtTst0stTaTC+9TuhxiRMCUKxPVLJusx5zUwQMCafK43xi8A/O54Q8hFrV+GQu+BmiXrnIQMU8AicOixbsghQChhQ4Kl3h+zTRNv/+jeUXcqXbP8vrSlRIVXdE5DxK4BxSt6WSA5qHFRSZrKk2dKc1JWn2nrpy7lDMiPnvXJLRz87SHg4cpwZPRGT6zei0e9rTNy6VNOhf4vPMq/UgNG9t74qk7Z+3CkkYcv4reS32cILRzIGOp0UZhr0JjMqa47yq3VdDlFb6+Q==
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e1a2ec1-a166-4687-61ab-08d859f4cb0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2020 03:58:38.5258 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xz2hH7ajot2LG0+CCnKrwakPk/RBdz/wy8hEApdj3rsGPCUZBfU8fA0iLpD9t4w+glYLnb8JNxn+10W1GbnS8PznVmchemGRm9yfUVTh9o4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4758
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200915_235844_146429_1231D5DC 
X-CRM114-Status: GOOD (  13.66  )
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
Cc: "hch@lst.de" <hch@lst.de>, Matias Bjorling <Matias.Bjorling@wdc.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/15/20 14:42, Chaitanya Kulkarni wrote:
> Hi,
> 
> This patch adds a support for NVMeOF ZNS passthru.
> 
> I've tested this with zonefs tests [1] and fio verify test, all the
> basic tests seems to pass at this point.
> 
> Regards,
> Chaitanya
Please disregard the RFC tag, the code is well tested and seems to work
fine on my setup, if any additional tests are needed, please suggest
I'll test and send a fix if it breaks.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
