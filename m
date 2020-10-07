Return-Path: <SRS0=DCfI=DO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA23C4363D
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Oct 2020 00:58:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1CE620679
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Oct 2020 00:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lOBhJT5d";
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="V20hG9EH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="P6qCHV0l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1CE620679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=Sfsd/PfOP0KDfvbo3JU/o+loyZWmVm33G3GUeUpSZN4=; b=lOBhJT5dKSfmKD9LAPGZ++scN
	8JzY9q+eEzBzoQJ++gxNu+er3Colyh2V5R4kn473W4av/Qij/1MndxYxwWvICsODA2uZzl9jBpyXA
	f3z1VFX96YmZURq2gxxhZYE2KGrm7Wf6vsT1kg0hKN8eRuIKnWHvDceJhiifqZzYo2Q0p3rHKqQGN
	uui4KtJpaTmjTzFSlK30GiBk9yRJ9xwMan79PfkUg9Y8vuzJDduSaRM4XMtSVh72ZTkIzAuMEvoTV
	HEBMFBBf9tf6Amy1OvNM8tAwds3dqiZpHH+hxkAKYUmkSNu2neE+sq3qbzdeQO82K0jNhSA8URXYj
	IYtUdJyhw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPxmp-0004fU-Iv; Wed, 07 Oct 2020 00:58:31 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPxmm-0004et-Pe
 for linux-nvme@lists.infradead.org; Wed, 07 Oct 2020 00:58:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1602032631; x=1633568631;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=bePmi8nV1Z0agk7cf7CxbiWA7BvcuQr0qBLJYZV4XFQ=;
 b=V20hG9EHYjlrQUUqEGdExSrTgDSl4oK2QsZZuCF7L2r5lmXgDVNROcGI
 gYqx36+Fydtw9ROUZeGwK5qfkbu0QQbbE2YD3+BZ/SxLjJecVn8BiKeM7
 ARh9OVuy/uHeVrPSj2hYpsBbfOBQanXcjJ57tTCjtu9PWdnnW7Q/P/8Zw
 su0FDRIx/73XqDXs50Pxd2DXU8rIdGtzeBkccYY3JVWeYwPh6VtC9JG5S
 wzYkAJmmQr8HZC5RmJWwtbyNLaoAZAAcxnCa+Q3qaNzKlKCRQBQ6xd3Uw
 dpdxYbOpXcxZxOWk1PJuvQzLqwAM1BhhygSWVzPdvypL3P3fknHi6guoj A==;
IronPort-SDR: z/02lHZCV+6yCNwRxP9N4FAj11lL1xbL6lMx+ipp6YNTyI1u/L+4Lz3mIPigMgYr6RikrQNN1P
 Xnf+Sg78MNpUNupXWQzEGf2PX8s5rmlHMpeODBO7RqHRjoe1SN7Od9gC1t8sLHr5eiEBwzMPCr
 i+2nAl1IeaLajaErPZ4svqGqy2hmU8v5SzexAi3J8R/bwx/befo9nyKhizoa1oC/D5EjpNd2pY
 r/pz8UigREahwNIXtQ8bxuf+PsLzrGT53giQSNqBmDxIzaFpWSvn29ikcnbv1ZdXE/fdHEdEnO
 K+w=
X-IronPort-AV: E=Sophos;i="5.77,344,1596470400"; d="scan'208";a="252652743"
Received: from mail-bn8nam11lp2175.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.175])
 by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2020 09:03:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KkdzQ91mVWs3BnGIsh9Bk/kFapORZfNI8tFte+22+8Ng9VBlqRB/7eEiFDzf1o/xeYE1/arn0h0chxeQvb2fAVCuWgSb/QykT7BJdGNaEbtlUEdDmkdgs+9y4qIjIMNXpg+RhLXfTfFvg6ups5RSn/xhV0xM+T+fbhQfOH3f0SEYUjloV0DyQf+dXHkNIPvVfKMNXxaRewCdB1exaZwlHaaD/56K87GlqIUVq+9zZIgdQLkqLMPsgvve3gKUlUv+GXK6r+vwhWOzcRqLAwMm1amgECf/Vd+jaXT3yXDPVr0UNaAmqjhnU1yNSpTE8y+sxDblpyEQHX/OTFbmNwp3LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bePmi8nV1Z0agk7cf7CxbiWA7BvcuQr0qBLJYZV4XFQ=;
 b=akgzzTwgnQSCNYoFsCOEq/dEjwGvBeBS1wMHCVZkPUIaNu51CW4cJS1ddg3Sb5F2DyZIoUjmXNmU+OO2Dfo+/8sftyaU3Hs3qrJy1kevh3ugdXwjXF6hZomIhcEAsWTA0zjnFX4wUorAsb/WPxE34uZGNgH8YBlbFKH46CJz4KOnFVK2q2DSpNInjwvuaVbrqnczgQ++vijwZBEcybo2v6e9mZSIltaqcnT1oD4saHUKkErlz4Zb64m8b6Ksjt0VOoYZzvKZ+AtR6uTI1hOVAdDXs+tprDo/RFVF2CIaAHwRqaDCRBgM1iHIxo47MfNMRKDp139+9YFiRmAjfjeQVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bePmi8nV1Z0agk7cf7CxbiWA7BvcuQr0qBLJYZV4XFQ=;
 b=P6qCHV0l5OuOeOVITQwoo9Ioq78K3tiEMWJCFNphjmjen1tMUjBXv25E9P7d5o9osNqq0BYZ1HzOrUT5KdRjqpT4owBFK5l8YeQP63P9AAdaLiCHmo0FsUojKGqJwlebatIXWj3zsvFt2nI4+2NADDB9whFRGUDz8YpsTx62j5w=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3958.namprd04.prod.outlook.com (2603:10b6:a02:ae::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37; Wed, 7 Oct
 2020 00:58:23 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::3974:3107:df66:7698]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::3974:3107:df66:7698%7]) with mapi id 15.20.3433.044; Wed, 7 Oct 2020
 00:58:23 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Logan Gunthorpe <logang@deltatee.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH blktests v2 02/11] common/xfs: Create common helper to
 check for XFS support
Thread-Topic: [PATCH blktests v2 02/11] common/xfs: Create common helper to
 check for XFS support
Thread-Index: AQHWl1sou8OL2CxeA0mV1a+SBBjD2A==
Date: Wed, 7 Oct 2020 00:58:23 +0000
Message-ID: <BYAPR04MB4965E6FFC184E347DDB78A29860A0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200930185422.11494-1-logang@deltatee.com>
 <20200930185422.11494-3-logang@deltatee.com>
 <BYAPR04MB4965388F1D0E70EDCEDD57E2860D0@BYAPR04MB4965.namprd04.prod.outlook.com>
 <b809f785-fc8b-4fa5-5de2-26dc9a4aed94@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4d22471e-b258-4896-925e-08d86a5c172d
x-ms-traffictypediagnostic: BYAPR04MB3958:
x-microsoft-antispam-prvs: <BYAPR04MB39585E5DAD79CA7CCEB662B6860A0@BYAPR04MB3958.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3ihA10jji0rPzj8TkJDY+JP9h0YNbVZfpT21j5MOnvVY1DrffvRZNPeX/WdNyBRay6vqtu9zXDz6RJaksPLfIniZfLWVX56TetcVQrPR4SJnrSNJtGExdmv/X5n1G89j1jJwJm/D3+rxN8BMALauhB6y/AUBhjf6ncczYeAX2BCzxAxD5zlA5O9nY/Q++LYUBN/rOrmPSsJm6RnKG/oqnHhICut/8ww1x+6xRrNq2rGRv8XMNgkqSMLtN9kEOk3YO+AESUYog+6lEX6qa5Zne2WX8Sv1qyPxFrbT2IQeTV+SEBKXsVdAlBRy6paPknHWRDvMDhrsETo8GWU6BAX9CRhxDmIB6HFiAxtbYYRxVAT6tRSP1maM2F2vur5EoqmLgss+nUnBzV3OO5LOjqyNAQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(9686003)(4744005)(55016002)(5660300002)(8676002)(83380400001)(83080400001)(54906003)(110136005)(8936002)(966005)(53546011)(498600001)(7696005)(52536014)(2906002)(33656002)(66476007)(66946007)(186003)(76116006)(66556008)(6506007)(86362001)(26005)(4326008)(64756008)(71200400001)(66446008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: SodsewaHJXActT2olbjkgBtKDPBs5wJ+QB9TP0N9/B2vhGUscwgq0avfzu8onFBnFCkMTwo6j0YJeNH7V7zavRe36tzKaz9MSiKY7kAVxRHdT07T15sJztRco6yERmllqD+Ba6gyZtP5W6G4Q611u4E+TdMAbVr/FT98ChW/GM88kAEGvXqNj1jDttJPK/Qrp6x3fDrszuDO8+gBEBOL1di3cQ0E4MYGQt8ZlRodXYPdO0XiYXBQLhCxVzpCW8Ld4mZ8iyOi7PbTZQyvnHfs6AZUKtj/mzMvaPpI8lFIqla3KXChrgYskZpPSRJgObbR0DyyHz8puhsmdz9Ng2dC4ZGzJySbsvENWM9OIZKhZpU7PYM5wVSC8XRYMGi1/R/2dpPaPBsfDnroCDql83YHhSk1/msBa8s1tMY0OEhroX3CtgneF/lqzL/Qh1izHgOJ0co6rhts9+/zAuVoWRxhQf5i9kHiAgj/xTmAWUHuF7qX+6dGeVjjzzyis61KqXF2kjArWaId0YHA5zVAK9AA+EqekiG3+uyNxfTKwqsnQsTWc+pfxlb6QMP1j69rJ1AEfGnEDl8Kp8DE4IYRIaQeb+4DXrm9C6g2TL4KekWuQ/lJq5YauRDVb9iGH1lUtW7IBWaI7HXq6jGtShF4PS4BMw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d22471e-b258-4896-925e-08d86a5c172d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2020 00:58:23.0513 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o7fqko/tKq/yYcrfQPwepgWqKEMV9y6wIoIe8BlavdY2b2DRpqE8LdpWWWqkJ2zwcFcIfH7PUt4UXxVCMe8/dEswdb6u0x+I5mzgz/uBsSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3958
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201006_205828_944465_EF505A46 
X-CRM114-Status: GOOD (  14.77  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Stephen Bates <sbates@raithlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10/6/20 16:51, Logan Gunthorpe wrote:
> _have_xfs() does return true/false and can be used with && or in a
> conditional.
>
> Per [1], my opinion is that using && in the requires() function where
> the return value is ignored is confusing so I prefer not to do it in new
> code.
>
> If we want to reconsider this we, should add a check to ensure the
> return value of requires() matches the expectation of the global
> variable it uses.
>
> Logan
>
> [1]
> https://lore.kernel.org/linux-block/92478e6f-622a-a1ae-6189-4009f9a307bc@deltatee.com/

Make sense to me, lets not change this, thanks for pointing that out.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
