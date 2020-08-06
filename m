Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F746C433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:44:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49B772177B
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZV084E+t";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="acXjCNTB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="AEiTG1Cw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B772177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=X8HSkPLUBjVKmbktIz2ZvtiKOT5wNVThYLQFyNQsic4=; b=ZV084E+trQYhUgq7sKSDDLTJv
	97Wr7YR+I/PxumGx1hkyKQByt2WltU+dw7GNUQ9ZUJXxLLPVjSoiuy9t+QsOvXB3Czwspp9GSR3rP
	gRvWUTHkB1aXUI61gxIIijLdIoKxqnkCjeKtTvq4fF5ltTWl0H7EVA7cxJ0dpjFI/+yytHz++/Lle
	LwBXZz23JOWfZpnqxGi2itbJtA/A6k4KN2CMBnmm8eKA3N1rVeLTKGMRsSchaZqN9An9Ph9p0IvV+
	tDdkcWHpKYAilelWlGaB0TG704XFst4ngOBcz00eFRV0OFZFmAysFfuHNZcTzBujoHdX93ySSkOVf
	KrbSTNd3Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3loZ-0008OG-J3; Thu, 06 Aug 2020 19:44:35 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3loX-0008NZ-Cd
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 19:44:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1596743073; x=1628279073;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=5M+5Q+3B933yctwijpcygnYblhjSuRdJ/IY+lsvwZUQ=;
 b=acXjCNTBLh/dIeCWc4j+0dzS4sgaC7sNFLy/YeoA09zFLXbAqT+5H9OP
 Z03ePqHOcq9P5var9kzn/iP4hCCrY4zY07GyfNX8fAqCMcygKq9Yhy3zK
 cbgZbzYXoRcCGsOmuYt29rqZ/LTLhqWep/+aTaly16peXvw1xCEl5EYJA
 7kt1i2wTeHRKF19TymP0BVzBLRzeCgE2C0LRISP3Y8C2Y36Fth6LG3mid
 M8i+tQlmYCVFlC2YXegOstAFFaHtnh+rSS6MY27WF1mYU25kq5QNFoMc1
 FQKv1KQGemHmxReNjHpAOsvcHgxCxGRq/w/3XdbhT7XpG9ANj+nhsBQKY g==;
IronPort-SDR: jj7aX1QkZqHFiDtO+iXoUZLI7MdyMpXvlO6UHaTSvB5hAB9Z7lSGCmC8XGTrJYIM8hgvlkRURM
 NWpQoB0xxMUHkruKjzxA+RcznMnXfnbkcs3cy+yOyYlAjAEuzHV2g7xHcy2CWjtPfY5WoT+eNz
 bbpln/Q/7E1Q2oiWt9LBv5HDOSBZWPYZ3wXaIeQx0OJWxX+PqrfNUf2qqTTqj7FfHdzsrF+YWj
 HdfOqOxe9wNz9gDMPwDam0m1FnrF406jWkTSOZxXXSg8UYhcZNkwqExn+gs9s6egDS6zw9Cf/1
 G9A=
X-IronPort-AV: E=Sophos;i="5.75,443,1589212800"; d="scan'208";a="144331423"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
 by ob1.hgst.iphmx.com with ESMTP; 07 Aug 2020 03:44:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dEW+j/zZpHqWSDVLdmeLldzGyJoyx4wt4wXWKyswIo5VP3zkZFwwrUK/7Dc+ea+0ty7VOX4L4cB6qOVK8ZeblvRXq5VrjwUbcYoHUlivrH/W1+AQRPGgDc9ZJyOUtxU0whnu/i0BlELv0VHqGY1PCy/h7qz0vrXn43pRZ99PwSWFFmTcYTqDMvW+50tjD6E6Dxcp8gDnWOIrTqiyGHR7kYvpVyRZjQv4tKXN23oyrJSu4LRKJ3+pHPJF9f18gNkqLKkei/T0VvhILKBwaxy7k36LTMNTaFSLtFx9ZFCie8WQ8YbQDEYIXqvoq3s29SARB7Oiav33rEDAOs14Rsjb3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osbCwJFtEYTpvvw7GRVh2PD9VKRRbmaXyUvb4naTLXA=;
 b=lR8N++kq70tWjikeNLz2e4eaQl5TxIaH4H0RJxPp7d4UbII7iH+b5Wkmn/rtf4w9KLXM2VjVo2rS1H21rZI3F1gQAR5jCxZHJaaMl/00oOKSQ+FIKLZbGsaeLdrYe08Y7/o01k/7iRATzPq7F+O1k4uMrb8sqxJAkCqmhEj1krROgOtlwzKRh7ArrBdeOM2UxqnLBiWw2SfsIDeB0vHi4d82JxOXFCDM4V/HcELRqFYawhOL4bGlNXRL5zMfdL6ZUuaChpZPhwNH/Oo6Wo+xw9P7pvEf698VPa1vu1jLVpRRJn8PDQCJCL02Xx8hmXenK1QxElSQkJ8dXDz9fZi8HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osbCwJFtEYTpvvw7GRVh2PD9VKRRbmaXyUvb4naTLXA=;
 b=AEiTG1Cw44Z7TmziwDaJyYogrTumi1FcFLRyHrNjkC4q6t37jqWq7/ZiPjd2tLE9ot0q9/AAqA+5uKfr20nlGPUCpuNORNCi0rVXHcFQsLWZgHV+EhQsSN6RvhXpbaheedxqavHn56MNrtRJpHkYsxHtbtewK+LviRP+c/dEEOc=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6584.namprd04.prod.outlook.com (2603:10b6:a03:1de::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Thu, 6 Aug
 2020 19:44:29 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3261.019; Thu, 6 Aug 2020
 19:44:29 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, Logan Gunthorpe <logang@deltatee.com>,
 Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/2] nvmet: fix oops in nvmet_execute_passthru_cmd()
Thread-Topic: [PATCH 1/2] nvmet: fix oops in nvmet_execute_passthru_cmd()
Thread-Index: AQHWa8OqKK/52UoSzkecfpDi4eSGxA==
Date: Thu, 6 Aug 2020 19:44:29 +0000
Message-ID: <BYAPR04MB49659516EF74C3DA862400BA86480@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200806073151.56061-1-chaitanya.kulkarni@wdc.com>
 <20200806073151.56061-2-chaitanya.kulkarni@wdc.com>
 <20200806154247.GB3075319@dhcp-10-100-145-180.wdl.wdc.com>
 <1f6a1c73-fd0e-d05d-3254-03d0592ac998@deltatee.com>
 <BYAPR04MB49659642F181754E06FF02DC86480@BYAPR04MB4965.namprd04.prod.outlook.com>
 <d09e3ca6-4589-25a2-6b54-10a3b076ccfe@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c3022e85-9734-493d-898c-08d83a412254
x-ms-traffictypediagnostic: BY5PR04MB6584:
x-microsoft-antispam-prvs: <BY5PR04MB658481121BF4AF5DA3BD277686480@BY5PR04MB6584.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sw6s7gQJ+KLnRdEhNIZpnrS011r77wKdw9HK9PFODw7Z1Ki3/mQyfiQPkT+gosA6OieWbiMfaXiXBXeAyB4t6/y10LQMVg7V2SPcU5jIGX07UA0IelD+t/QehrtM6+Rw5kv1BjBHM02zHPfg/DJFOlEqgPeiTnx4N9Bwns38wfQ7a+IWh1ntlis7vKJqrRGiCUjXl5zlR19nEWHivwkP5XSHd+Ai1xUwSy7KFQ1GZ+jbUDjIEVlz4hQSkyG9evoslbAYpvS2Dvwnp6L/2v9QkBgq81QWacOGS4HxoN9QIwjZJRlRt2xLrDrOfrsgXzWB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(316002)(8936002)(55016002)(9686003)(110136005)(54906003)(8676002)(83380400001)(478600001)(33656002)(66946007)(71200400001)(66556008)(86362001)(66476007)(64756008)(66446008)(6506007)(186003)(2906002)(26005)(53546011)(5660300002)(52536014)(7696005)(4744005)(4326008)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: PE+3ztftyUSM/ry/uqwVYgS1gi8kM4xfLJ7piXLXOZCFcDMPBwYlG3G75jO65oD1Ymjc6xqDS5FR59ics++GRm9Rf8o4GcULWY5XjzxYEHaNETjgVylt1y5SGye7DStr96+JgpW9AGepU/EREec1I33nPdE4ztwustgYOxwMubsfW+RQayv54NR/QmSGgYpuVRNxvJDZxiooYVVNHqGCvQCBBnOf5oSWfwqV60BXUGfjY4cpCGqT8oXs2DPIbdVm/Et7B0BD98a2cnTrYS36LMU6LN8x02oLaJdQ3qi6zNhy8nY39igv6QFWjNLKS7CQbiIo0xWgGZSTdEmwntRCgt2aUZLqMxVQ8Sqr3CTswqTsFz+fBMYZQrPs5Z/m7pKS7oiJpSLsFl4byVzBn8VTwvMkgLOVZWjHF3nTHul/Xyak2Pv9lkHO7BIAVpJLH/VIGsPaILCcrCjNAZXYZExG5a/fSqEVQW0OS6JeDyK4Y2Vh320V8Oco613PC4tnrdhlzwmvchyo9OSDM6hm246BnDR7LuVfOHYKn319ONxNC0YN35lHnrrAfX2boYZ7MnTBb0iZ8XgKnTh8DUn1eHI7mQqxoQi6fmwoRIAlAvh+yFf8QIEBhvB/68Xd5am/OSG98CRZt+F+0r73uwV6cG+sIQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3022e85-9734-493d-898c-08d83a412254
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2020 19:44:29.4756 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: URXtDKl8ilm2zdKLqI7p72Q7Wxly4HZfyo7hDGfIQd4l/DM05Yn7pWIgbNORYoyw3y/0MK1nqID+H0FHYzruovBs9Q2hkvuWqSiVmgZM7UQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6584
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_154433_661615_1C808280 
X-CRM114-Status: GOOD (  11.92  )
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
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/6/20 12:41 PM, Sagi Grimberg wrote:
>> Christoph, Sagi how guys would like to have this fix?
>>
>> I personally like to avoid introducing new labels unless they are
>> extremely necessary.
> I think that having an explicit and reverse-ordered target error labels
> are always better.
> 

Okay will send v2 shortly, although it dose create an inconsistency 
between a call to nvmet_req_complete() and blk_put_request()  in 
nvmet_execute_passthru_cmd() and nvmet_passthru_req_done() which I
didn't understand why we should allow it.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
