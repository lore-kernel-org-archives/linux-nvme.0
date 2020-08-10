Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE735C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 22:56:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAD39206DA
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 22:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bb4SpU0R";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bOfei8/U";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="IPH0CT/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD39206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=EJM2XU10JtXWAT4j9TbhDQqYfGEu6PguMq/kl+AwHJI=; b=bb4SpU0RP32++7tagGgPClsyI
	mxtgiX+03v5uy59qQ1NbG2FU1YK7Rd81e9hl95H03leSafg8oOHp2MC6D0rdPeyu8UgKTNVeotKwg
	9Ti3Jy0lZ1+xzf++dPUQoVUuiPdMTLy+ZESAbtcUHBL2hpMFknVgsljSOTh/cAUc7vcGoKLOXhePt
	w3pQNR4vfem3+INtDI4eSP81YWrs4f3JIUJDyqYhHz1jZxxw1RlIDcpZ3K/s2/rLwLyGSUbG05Efv
	yqi34/JBLwewpWd2HkBIDNHwZrjz4kAdTyYZpbaD3X+aX/mavt18oH6jzxzuhQ88Ok3Xsvu8ivchc
	skqcf86JA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5GiE-0006SU-8P; Mon, 10 Aug 2020 22:56:14 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5GiC-0006RZ-F7
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 22:56:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597100172; x=1628636172;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=JmvNYfxowCevStJ6DcG7LxD5duvIiiFMs4Q7VfIQfzg=;
 b=bOfei8/UBmqZHXbxVrmNZbS/IOBCLP6z8eFowsfWzIHg7wUng4uVAhKk
 vJtVyJVaYKmcZclefv0AidWW+0cCBuRUEPj5sbPRpVzWIaQ7wqGmQv+Yc
 I09OLF0mAxlZ0jtGibTcKXb2IBzWpMl4qFjGT6Lx0g8KG6f2uDNGeFujX
 Yu+NO4MKjgwESXRhss1TBa8fcZ3QOXRm3KmKYG95FLb3ilNZoLC1kWXq8
 hD3k0OQWpTEIxVx4e3giSDdqzvRHVEh6uLMx7ukJXKo8rhnEp9sJDmOWs
 jmxOkd7usasUxBzIs2+DmEP8RRlj0WVQM8UpJI/5lQaBqVOjuu4efpR5G g==;
IronPort-SDR: iUDMGpPi+6iriugp6qzNYqnVW3hDXyKMHOhAUpbE4CsBXpiEIdP7ayWIuEx/Yewd4CEozhyjGD
 yp0LCPwqOc0ScY9/TJyAd/rM07Higr46E+/3Js4c0Lga4Psq6lUPDrVUmxxpzINjUI9lidBYdP
 nUgfvueQsL2PO3MI+a06n663/K5W2ZbmuJ81nekIIecw8SQBlcUK9owUvG0Gun691waeg8WLHO
 OZEDe/oOY9n1s1PAKyhGq3cbuPytOeyFQGZ/2brRTEjknPmGZTp02T0KvN7q97EcFwhqac7f0/
 pS4=
X-IronPort-AV: E=Sophos;i="5.75,458,1589212800"; d="scan'208";a="254003319"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
 by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2020 06:56:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UaoDLjM8l5Dby79Uhcz3KvIsD1DPcSmy1hdC0XznuJH4VBDggNxIp6/KZSTai4eT4BIjz5OoJwd8NIKXYNt0r+El35ioiXuuVwz2kVzVNoFxJnfzyYh+tLI72FVUI9IW9A0DTI5yCmFA7Fw40poTi8bfjAAp+9A21mGoZvqV54pPc08oUmZVRZob/svc8PlgbktiArQdeKZuQ4VYzsFU9sN1EArlcPQ3k2UkaSru6m540BZyEtvoPKRRiG8f7/A9lwjLGGG4E9M1vljIiaFdVs8+6BOjMP5E0+SAsY7cjS9Z5WzqsD0MQ+Tq4QMWn+WdrliA7WFvxbS3eVY3aCyOlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmvNYfxowCevStJ6DcG7LxD5duvIiiFMs4Q7VfIQfzg=;
 b=b3wmUsA8s1aLs6gcYQ+qz96iYVBQJPTjZZZYv2vWpWfQ/C21o3bQhFHfutLBdqA1UdjDfSePdx1qKtvhhWfPk3jWF/r8jSESBIE4/RSpR8NAT6SCie4w41ciatkx/v47g+rNF8rGfas2ZrhmUdzH3HQXDF8emqTOa2z27ijOBY8c2wwh+u/n3azivVO05Hk8Eie7mqK99a5ihvxY5HTLykbBHUFoXXC6wuUTYxLYi35E+tIp+9RkdZg+MgwoReAZjUt6j0zgmnrnvZS3+vvhNeT99Dj5CCefDqe+5MYF7JTiMaeU05NtdoiuEaydnSw2ffEkN9aHOo6Mk9Yjqpn7Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmvNYfxowCevStJ6DcG7LxD5duvIiiFMs4Q7VfIQfzg=;
 b=IPH0CT/wdXscsmsMC65R1Zv7L3ezAyTffzbg9QoJRK26oFYQDHLGq0+sqa33Mesf1V0iTl8FnIxSd0cx+nLHS2DJmPRfBmHqWgnTcm7paKNHyUvBk2PwlZo4angkyqB87jv7KiJ5LLt5/69TNXxsrmTB2yDGroH6wLxi50I/G04=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6101.namprd04.prod.outlook.com (2603:10b6:a03:f1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Mon, 10 Aug
 2020 22:56:08 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3261.024; Mon, 10 Aug 2020
 22:56:08 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Logan Gunthorpe <logang@deltatee.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 03/14] nvmet: use consistent type with id->nlbaf
Thread-Topic: [PATCH 03/14] nvmet: use consistent type with id->nlbaf
Thread-Index: AQHWb0fOeY8vefgEbUuTM9pu6XCb1A==
Date: Mon, 10 Aug 2020 22:56:08 +0000
Message-ID: <BYAPR04MB4965062CCACF7B2DF5F144D586440@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
 <20200810185456.7713-4-chaitanya.kulkarni@wdc.com>
 <31ec987e-edf7-0f02-4edf-de33c9c6d533@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9e66a344-425e-4c9c-9fa9-08d83d8091f2
x-ms-traffictypediagnostic: BYAPR04MB6101:
x-microsoft-antispam-prvs: <BYAPR04MB61010B957CC02370579B226286440@BYAPR04MB6101.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZggdDwXhK8NtSOoXvEwtDjVAexV7IPGZ1FHHo78kdLF5efvj8vA/UnhEZmUtnMDpNdHmwCRREDtA+bC5lgigq7OlGRCpT06Q+gudCQHHKoKas9vKdNGNLDTy85rXCHz1QhIp9lrkx3otfc2gWFryZUchQQu+pwqTJe6A9zfTWdMU+m66/pqeJur+Pz0KTKmjmi31g1+cNyBrHb2r99934pyRXMdJs+bZpiV7fEDtqSCo6w6UaRT8O6nnH0Z3LiuskFRTKKRwPfoR0jLkSybYUz6ipqhmvEeY+AaCA+mwUjEuUPfWjLOOOIqzjk2ZHD0/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(346002)(39860400002)(376002)(366004)(55016002)(54906003)(110136005)(4326008)(9686003)(6506007)(33656002)(26005)(86362001)(8676002)(53546011)(7696005)(66446008)(71200400001)(186003)(316002)(66556008)(64756008)(76116006)(2906002)(5660300002)(66946007)(66476007)(8936002)(478600001)(558084003)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: mrwMQvHiLUUWAvscG8QCWnqfQPfNbJzI02Szz4a9JYQv5nfLszbCOlEaaUDtZSi+/XhN8dGKikmv9UpIS/PSsBg7vOUKXYf/OKmMKniHYr7o5L28gP+FV00pACiZZF87hsDGZWFN+124yT0L1OyrS0KTl4Us2snGFP+vQaMeXQahQ0Q3NHde53/QQWsdP8ZYdhJrIEZ+CXt8DBSEsK2M3PvkigDtOZortRAFTAyMNTORLCZXSM1+5zUI2eUfeRGYBfgZf2ew92uPR/YMinfx0Vz9NkKk/fMcAgtrq/ZhL0/pW2/dyWQJR7c03AziXBmOekJjqzktBwNw5uaVPh3F5gkdKJjD4SqG2bQf09YIeLxe/qKWHS2RwxyB2/3wJormIPK7NFYXTuc1p9kbY8Ipgm5D8JCT5Ufs0r6qxtAoWJv3N2/atS4Oy2PeB+t9wThhptkioiVp1eXPPwkc8nawHG22A2nC02OwudUtAvJ8pzWgHPFwVH4mfC0vPcOksN43ifTel0JTs1Sdu7TSdujq4E2GIFDMRhcJqGCTVw6mh4C520xw2gRW74rYeqwZz4cTeyVOU46WLsS+Usi+TTwAyDxZP2D7ZUL6Hdb+Qvbs8qV5gb3wxy94ZHhZ/9KY7o3TbIbh+CFWes+HSUJdzvPK5w==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e66a344-425e-4c9c-9fa9-08d83d8091f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2020 22:56:08.5680 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VeGpeVbp/Mv/+C9RkUCCSOaqLoUW/zENIG9wfpCQnDuFkx3jSsj6KC9rZiH/jCath+WgNLc780SG+x4eWlmdh7IAuK01zv3jUez6AjhhPJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6101
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_185612_670235_B6053F51 
X-CRM114-Status: GOOD (  11.28  )
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
Cc: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/10/20 14:55, Logan Gunthorpe wrote:
> Why is this an improvement? Seems to me a loop variable should use the
> fastest type (ie an int).
> 
> Logan
> 
It is a type miss-match, why we need fast type ? its not in fast path.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
