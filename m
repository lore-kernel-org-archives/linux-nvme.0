Return-Path: <SRS0=GC6h=CE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACC8C433E1
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Aug 2020 18:10:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 552EF207DF
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Aug 2020 18:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IXuIhn/M";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="f4bjH4Cz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="spF/5tO7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 552EF207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:From:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=wSaPSVRWLj0oFYG6LZshkKWbBLxD7w3Vk7FyW9qtlLI=; b=IXuIhn/MwIqeLdAHzaqNb19mIq
	AVOGAaar3PSpRvSp0uM2Z+ZVkz7PBNDbJcIYRJ1y9ycDTn7M01dDSexEU+0ls6mfjv5FrLSYJ81mF
	LnX/qj7tXf9fzChHs8CrKh671RWHkSXXMXE28FRpq7vjmflue3zff9O3Y58NxtxM3T7L23Qm/lXlq
	nr6KmTTETxFpDhQ0W6Ib9lIxWqGj9X0doQXvyDpBx7sC6x5lAUNHu8gqbQhPqmEgrIiE0ezFssGBD
	+IomVh3OzI032/IJCPIBEx2DqOg3i01nfIrR3OvY5kPQRjZDEASjFDaDg9LE98do9mj/gygEVDDfh
	4qSJVKkw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kAzsC-0000fk-SF; Wed, 26 Aug 2020 18:10:12 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kAzs8-0000en-6W
 for linux-nvme@lists.infradead.org; Wed, 26 Aug 2020 18:10:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598465410; x=1630001410;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=k4i2t6HCfVn/9L6hGJ74smCsBfnzRu2iY73Wdli+k2g=;
 b=f4bjH4CzP4CkO6+8uJPpOxeZt5I8WA+nvyGI2FYmze9wpHpN6eVVBtC1
 QRxzlzmyklS1M4grqQdvykAXvG55cRBfOn6fXwWYtgBJiGbLHZTd+sPqR
 8UYwx7LIyhRhEY4t1FlX0X6oq+HeZaGWuY8pFafs7iN+Fr+JxDbVJWWux
 QKPtq6QW+sgf+rL+k9W36HiGe57+AhL2yyt6A5G7O/NPjZjs+VeyU+SLD
 2haoQ/e1sqYLY0EAxTt702jvZ+w/QTwlCOq8sT+XR24uQ6zSyMjYIWGho
 vUsjPhJ6B0LHY9Leg1UN0ddbgOx5Q+gQI+AdzB4GN2mZ6mHOs2Fwli8eJ w==;
IronPort-SDR: i00xNCdDwuneMqpsPHicOJfXtvlmnjXbtCEwPPsAb0qR2YYlCBCmYxmlwEw5K8aQQsVoQr6EXI
 94ml2JcJjAv7CUtmaIRPgx9hNpr+SmRXh+AFVEqJeK89B2bnr11QwtWRalIFUoG7AqDBeZA8Rh
 dgX0fb7vEvFfW47Bt7UIfopgPYQ8JQpCrcFHtaAYTm1fdpHuUEW0BoU6IYAINftAxmlpkxa57U
 WMegA5OadUBGyDTYxaNCEOATbiLCuCL4c187BpjQI+uNXRjnwOYGI/R+41XN0d6WjRCdYSZLzb
 gHo=
X-IronPort-AV: E=Sophos;i="5.76,356,1592841600"; d="scan'208";a="249135115"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
 by ob1.hgst.iphmx.com with ESMTP; 27 Aug 2020 02:11:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEWGsR3lDSMPVxEri9/XwQLs+a+FTV8i1HAXmal9asGOFw8YDQmVZ8uhpSRQ9MVM4ESN5XM/S8xtb+7MOWK4zsge/jAFUgdkO11SkTxGYvSt+8p/NIlktYmgTQAhnlfUgx0oalJhNhKqcEFeWyOB1+UoLsPe4FTIxhXtCjL+yYMbaRb5wnnkZ6srhBW4h8d8fbRcY5K6yIMfB8D7q5SsGghRBSdZmayTkHcN6pGrYkLV1fL/UgwX0it2HKa0eqPYWt4rstGLkGsWJ6GNKTfcHa1DVQa1uNwDmfHlo4ggciBaUlTw38hloyc1Oea1gKL0xmoQ9IvDADj6OdLpWnI5DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4i2t6HCfVn/9L6hGJ74smCsBfnzRu2iY73Wdli+k2g=;
 b=cHeStNAdw8C3Jc+o46tqmQ0U4CIRyh6X5BqeUDZ4mrkClRMiGZbqZsUIP77nksKulfgXAT1Ce50FSmOSA3v4ZPKYui4A8LpCqXOPdliSnp604pPny/WV6rt1DUrLBmTiydZcmOOQgKmiIF85y6UvYlbd3hkUTij9o74rgy223i9kv84jmoquaQHmG8gVJ7DDpq0x2Dgw4rAIqsxxAbEGN78pp2ekfZYhBq2oHCVToTsF8tKxhqYmyLNQtUqX+8i2ofy3J90taCc5drvtktctsIjEMlxhR/wKYq7DfspP4sYEQJymr1BvfROuCbd6EuVerarLkOS+1MBCdDVahXrAZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4i2t6HCfVn/9L6hGJ74smCsBfnzRu2iY73Wdli+k2g=;
 b=spF/5tO7NpIhVKMvkSW9R5LfIQRDi5AHZa6c8CombmCPl7rPrwGADSxTv9VAzCW/yTnvubxwMV/qNbeud5oZ1e+1x0M8Qf98Fciz8xxBED56dM7QamY6ImzTP3keY2GsSjmninskUesB4GuRd6VjBoChFXcZFqof68gnc/iBncs=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5526.namprd04.prod.outlook.com (2603:10b6:a03:e9::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Wed, 26 Aug
 2020 18:10:04 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f%5]) with mapi id 15.20.3305.032; Wed, 26 Aug 2020
 18:10:03 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: fix controller instance leak
Thread-Topic: [PATCH] nvme: fix controller instance leak
Thread-Index: AQHWe9Lg3vPe0+3yRkuWfEDZFGJy/A==
Date: Wed, 26 Aug 2020 18:10:03 +0000
Message-ID: <BYAPR04MB4965D0D3E536ABCFB3FD2DE786540@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200826175304.2151626-1-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4cb885cc-48b0-44ac-81e5-08d849eb419d
x-ms-traffictypediagnostic: BYAPR04MB5526:
x-microsoft-antispam-prvs: <BYAPR04MB5526BDB52870595C2BC9922386540@BYAPR04MB5526.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JQcIvwINSJD0qxiq3LugOrN+Nexic1y8ZeEIqp5NrMxjTGoDjfph15avW6LozN17R8Tjme1joDQ81rNe8hi2XD46Q8gFQ/XyB2LKlx4wYO8l5jiDZHeEhzK3Gb/bdoWFKHx0g6yEhYxP+13tTZ/eLD/t3/7USfFgQDJTjpEULsdfFnl9puJqN1SAdCqrzy5fV/KEtrFWzylv8m+k6sxaMc/b6Qz+FZQlrP9cFJSJZIGFxDr28nQ7oGmxFublWZyFTqbRv6KTANS4yYmTYg93DbknkfRlKje3UeJarNYG+tvA8FR/+cguWKdwNs6nI55/Kq1SKh+GGC/U6DvyUWqIHA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(346002)(396003)(136003)(86362001)(33656002)(83380400001)(64756008)(8676002)(66446008)(66556008)(66476007)(76116006)(66946007)(2906002)(186003)(8936002)(71200400001)(7696005)(52536014)(110136005)(9686003)(55016002)(478600001)(4744005)(5660300002)(26005)(53546011)(316002)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: sRm+Alr8RRyax0TWYibhv2e159/JkK21eVvymz12HFTS8+tbmtFTt6hsC4qVWD9uNE2VlM5TOw8m1a926aIFGBhe2iJufQgPzvIt+AoN6AGxPxdFJ3sgRI/CLD53YGK6VgFBjnA2WzaZ3FBliqhNv4Ek7F1WkvZdk0/PeushMB9S02TQgAXflZ8UKFwoWNrZoAZ8GZq+IZ+R42HGXHUesvX3eN/7+BgM7zurhFH6ZiMmFWRUjKlxktreyVEajG8s5XqH/eQwGbDSyPWo3WBf2SfCUbKDWbqR0O1ahXvjHnCRrGoFK5QufkOb909QzTn5rIyYm9TKVsnNkcp/pNO7THQnm5i4eCr1etROF0MpYwSrPm1VVsFVLbb1iV+FZIJ0QpIYaD6kVPnh9TMaZI6mpo/nq6gYu8jyMSJoDZPm++LzvUgi8iSdEiN3RKV1lE0D7UUDhTtnO50XkUYYbxD7fF4XlRSrD9MOO/1R1kdNX6EyEryMDWx+NAwDPLPxRBdfytOu9U2dNCaMWv/ptT98CCv8rkHAFyPVHEATKh/H4aONXo+P28OZPXPIYNWXXms1DkmcILWqjjXl2EIeeOP6ENEoZS/zb32JnMjMZsItQRb5+sAIUW4lrtGvDjLMSUJttqbXASo0LMzx1YpK5DScgQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb885cc-48b0-44ac-81e5-08d849eb419d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2020 18:10:03.8529 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HeCPXy7TET1rzc7GvuEgllVi8eI7vTbCkebxT/mPArca5ZGEAPZx3HjvR8gXv/AxOD7rOqCNbFxwEGXCiXvtyCOtiPtxfUGfDdSETLh5hF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5526
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200826_141008_544552_889B8199 
X-CRM114-Status: GOOD (  12.15  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/26/20 11:01, Keith Busch wrote:
> If the driver has to unbind from the controller for an early failure
> before the subsystem has been set up, there won't be a subsystem holding
> the controller's instance, so the controller needs to free its own
> instance in this case.
> 
> Fixes: 733e4b69d508d ("nvme: Assign subsys instance from first ctrl")
> Signed-off-by: Keith Busch<kbusch@kernel.org>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
