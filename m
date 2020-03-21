Return-Path: <SRS0=c63/=5G=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D1BC4332B
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Mar 2020 01:12:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FE9A2076C
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Mar 2020 01:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CBqKU9n4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TdZq7viq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LAAVDOKo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE9A2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=wR+QRciPKmxrB+mO7lW3KiosduN8yoTOf3yAOH+/ZTQ=; b=CBqKU9n4X95SOh
	o83sfFBmdgZ3ySKi2g5DdQyiRyoWE1TIx+JePKv59lZtl3ox6S0N75F2AOBSNfHBYnKqRVFaddgCy
	ZkxDBMtakEiRNnUJJpxy9JTcBk4X/JeIQiWOnYbQbVOI6hNKF++wYgRpZdagZsqGjFw50kJRDH4F8
	qF36+WeYBIYdjy2x2DFjIGb/FqYKZbvkebPsYPuBSWZSe2Inb33Q9eUbxG+Ul7IigLFtSdP+lCROB
	EQMHcZ9ZXisYf0PNuIdu38umnyH94hcP8HQ2idt6Gn8Hy/DlUxNt1rXnONNmrnflINdAHzol60JRz
	/WJ6XOSJ23RbM3kb26sg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jFSgO-0002Eq-1v; Sat, 21 Mar 2020 01:12:12 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jFSgL-0002EW-7X
 for linux-nvme@lists.infradead.org; Sat, 21 Mar 2020 01:12:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1584753129; x=1616289129;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=dDqwdfhI26BD7pvFORhPDD4L25Vj88wpxr/CWJpx2UM=;
 b=TdZq7viqUvagMgwNmMRezeVFWqFer3o3bvAc2a/lavttOORx5/L7UnL2
 sGL7M9HRq6eYF2vhsNRUp64KqYBVODysvKXbTfapbOvBqcaMrLrJ35s+N
 DCEXkQgy272AsFbga90EdmH6ztlTKhhv9evkJ/8AwB4VDeAzS5u7ubL6h
 J0ycN6LIZfnRvyyKZiWBNcb+aDtrt3QAH67MYSFyySF/EBpBQ2ZPazDma
 lwo9uVbPlDLchvCmESfvfyCyhxXzaG+nxrODAOAc/9Ee8w/AR5/IxHWhI
 YI4yZlW4UjqJqNmR92JWRcxRXPpuwsM6snsWA1mD2V11OE1PJPFqF6b34 g==;
IronPort-SDR: QlNIwdZ9geEWBP1OrJ/YtzfxwwcNvkBOli+hQGvFpSj3ip5hcAqrsaoCkkW1gyIo/6uw2XOYef
 zdd/w/R/eafQ6KoNZcIjtUgxjVB8DSjfJSjsotjhZ4/USeM/wDSU/iZM/Y8etjUcmTsHUdmN8h
 DlpNlqBb/A22pE/gT+fWrpyu827V64USZyYzZg6MAe+ZIvP7UKJn1qrgTjEeqwXK9QC5l/C3oF
 EUnlWLdWysqU8Dnmnw6iDeuXPtdP4Xqq41GbjsyMY04ed3lT+OxlECmgkPXMXd8biIFkb7V5lh
 /0A=
X-IronPort-AV: E=Sophos;i="5.72,286,1580745600"; d="scan'208";a="241531475"
Received: from mail-bn3nam04lp2053.outbound.protection.outlook.com (HELO
 NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.53])
 by ob1.hgst.iphmx.com with ESMTP; 21 Mar 2020 09:12:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cwj24onMPCwSbGskQioO+R/DwB9lvrCVlW6ZL4jyVkZfzEPpERRUDJjbNlwuRRtqV5GebUnkI7Bd4yhwDgUi42IvTJEI99d6Ntte6/FvmwmDR01gK2NjjLxNSABfb+ulE4/Vv5ERJfcnlciLU+/uRzFhhJgBPV64rZWyjP3G2VMyxvCG73oH5/FK12ImX3JO9eZxJgGJhGXp1LLshPBx4WRlcu4QcrG1x4OQqFqUAZFORSak+x3Bxp+QFfo2lOWvb9h86z6a9IfVz2aZsRRsbT6w3VNvo6wA5gCOjiyjoS5QesllEUIeWvaayw9LUbbHondWruBCit6vD1rBdVjtfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDqwdfhI26BD7pvFORhPDD4L25Vj88wpxr/CWJpx2UM=;
 b=H5DKbLMKiTH2nSlJ2XUUXQdC0xJPIIXyIqEemFQyaKGqIiYByAkbTrvVYAaSxZWEIh0UCWoPU7KG9UW/6jMF8GLv5WHvsNekGtp+BfrPrLnVKy05g9Ceul8/1xcdVhPg4RijISeuBnrmns79/fwH8uZ/oZHHfWeQLJSD1OFomnI+wNl4Im2zMIN52rj1dTvVLYmV3xpoi3fW05MPfFLHQFPT+px37guQyLy+oCPSED7sWsV/F+N+ydk9JgkQJH4epRH4ykPtRJ/SYn0cIuHMU1k2CzonqHxBAGWNwK/fq5PzzHVp7O4h2D2VucIpBFXcL33/ofXF4V9aSMEPvDQhPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDqwdfhI26BD7pvFORhPDD4L25Vj88wpxr/CWJpx2UM=;
 b=LAAVDOKo1n4mvcKKRvGuviBgYYL0zf7LA554jyF+Av+umWQ2PytwhyYB/Rb2LoRmYYg8y+2DpO3fX3bpr4yaN/1+Cmtnm1N4bcXbHz9VLy1KKq79l17SAd7nHW2q3ChHmyj07kd9IfSJ3uoS/CPVw5TZHaXuLKGaXwBQvr0yCT8=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5367.namprd04.prod.outlook.com (2603:10b6:a03:cd::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.22; Sat, 21 Mar
 2020 01:12:02 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733%7]) with mapi id 15.20.2814.021; Sat, 21 Mar 2020
 01:12:02 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Tony Asleson <tasleson@redhat.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 6/6] test_nvmet.py: Use string.ascii_lowercase
Thread-Topic: [PATCH 6/6] test_nvmet.py: Use string.ascii_lowercase
Thread-Index: AQHV/vgDjdAvNxgMk0mDWofAW7aoRQ==
Date: Sat, 21 Mar 2020 01:12:02 +0000
Message-ID: <BYAPR04MB4965153A921BBBBE14A2636286F20@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200320203946.37338-1-tasleson@redhat.com>
 <20200320203946.37338-7-tasleson@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 000e3c84-199b-4b6f-64fe-08d7cd34dcd4
x-ms-traffictypediagnostic: BYAPR04MB5367:
x-microsoft-antispam-prvs: <BYAPR04MB536767BEC87DA339C36C35A386F20@BYAPR04MB5367.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:209;
x-forefront-prvs: 034902F5BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(199004)(110136005)(5660300002)(66556008)(478600001)(66476007)(52536014)(66946007)(64756008)(76116006)(33656002)(316002)(66446008)(71200400001)(7696005)(81156014)(26005)(558084003)(186003)(2906002)(86362001)(81166006)(53546011)(8936002)(6506007)(55016002)(9686003)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5367;
 H:BYAPR04MB4965.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SFS/25rioYWr8kxEdTx30Dh7QtIk2KRQEnh+Oq5qNbS95t7VExYZ8M3c0ZdC3S/RnCjoisslfVY2wyMVWwifBZ5ExQG9TjcoBRHIF6mJO67GxFpT2jxJIPtRlVnZoS5pQUBywLQjZElRayP88/Rh4a0IQ8QHGVUP/46iVskAfBjHIEsclCe2BdXMaLqg61/b7oTv5FadddccWZrfKp/2UYRc0BY4EeOiTxbEUG5KMSLLCu0ntKhHYDCrE/Gd/C82g4+MSqPr8IX7djbkPsBYrScO/xg2Mavs/hog5vjEMvZ+sIM4sffga/dudcUdxGik9v9HQN6fNhowwPPjIJh11+7cbLXMzzW4ZZgsl4sNWYo3kGYODLgjTSvXzWAXxSZ8uTU5z7dnpmf9YCTadXMJaD+x732Z1vbnJs2wvojqNokHRYmPjvA2YVmB1EeoNWxM
x-ms-exchange-antispam-messagedata: h3FeTyIqeh/rXarOL1n9gEda9JIXN6nPo7Xjil6MQgHs0spLUgSZNI0mu50LOeOXiQV53Xw1iv0g4MxDs+TaNMcT3GaNRfyEcbE6T1KH4BMgvO24o2CuaqYeRGgGVqq+D28RmgbfENrpSZIAF0QIRg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 000e3c84-199b-4b6f-64fe-08d7cd34dcd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2020 01:12:02.1016 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sKIkpBe8AO81HlNAer6v1QcYs7mG1luc41TVlmdJuO/T1EIwMRmUjVIBCIMm81VqaH/MIsHp5sHJ+xhrEEyB4mIGjt+XPC6llx4Gw7s1Fq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5367
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200320_181209_282488_484CCE9B 
X-CRM114-Status: UNSURE (   7.52  )
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

On 03/20/2020 01:42 PM, Tony Asleson wrote:
> This exists for both py2 & py3.
>
> Signed-off-by: Tony Asleson<tasleson@redhat.com>

Can commit message be more descriptive here ?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
