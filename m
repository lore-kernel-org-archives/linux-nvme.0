Return-Path: <SRS0=+1uq=AT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4899C433DF
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2020 17:04:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90B0B206F6
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2020 17:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rwVcTEco";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XZIVphTr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LAdTy8xX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B0B206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=qt/Cbi8+He6/CoL6p/ruybFuqa42EqlOfcAuMLhd9y4=; b=rwVcTEcoOg4FMhqKGM4Mw+ltd
	iD7u6poEBFnj4dDUmsmG5FM1iO9EjtQQiWQwuqniYlgv3rQVU9ARIefVjenXvfekjlAAK4aOMR6/I
	cu47KhLcOx4+hwYtb1MS4Wjyk4gLY9NGpVC33hC/wJYOX4s6+5yib8KH/OErkDDYZyY2SqwQHzyOc
	noH6ZjEuJm3889ptVTh/zgW7rXyMgm4BSekbIoPDSuktFXYIZplIqau92l6X7Ub8SEUJW1w5qGIQZ
	b+o2ddLle8ipOiEXoFa/NBakUJf52tmANk1dlfFiaOxu3oT95FTVWUPOs9/UGiYBFImdqTfXcjdtk
	eQBiEbyWg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jtDUB-0000Al-Sd; Wed, 08 Jul 2020 17:03:55 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jtDTl-0000A8-3g
 for linux-nvme@lists.infradead.org; Wed, 08 Jul 2020 17:03:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594227809; x=1625763809;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=I0VE2JIlzn2CeR95mYswwgZatJhYTBbl/ag68CnxoVI=;
 b=XZIVphTrDckWoyKYqDxa2Gj7tVAGRHM6ppojEx9dFisLrDPZ2s0/rBxr
 f05bag1mCNQo4/bDRxr+l2TZ1AbXIpiN7m+tEn3Q7u6AvwS5vWh0LywFE
 BEHPejXkp/Q7Lgm+R+uzNcUsvGwPOZuSAnCgg5RCOseSWUBGqZX2iAdo4
 qzco/LAk5bpGk1693Acw3IE43mrqSjmh/2I0D2MdFQ17MfIc37M9/aagA
 H/pmeIE6aE1Y3cE+fs+oNqHvwuA3lIIehpAMSYD3kKW+5jxnM7+3Oe6mf
 Yb316ZJvkb0V97Ise8gFqRjok8t6s1Hi4cDpUCXMys/bexn5gwssSMbtC g==;
IronPort-SDR: /CRESBcfOaqZ7oJylvcfUEA3zbca4Xso1vW/ioIhMc7NnX2wXgub6qrcMcKoflTIX3FSlrlUiE
 aghtEXOqwTHA3ywgwkoikE07DsAQNokjo4x9vZNdAdRJmnSs3/tBkNbqfZTfVq4WdD372zoxk5
 vXZ7QcVq0+K6Kfx2dLBIvoX59rSu2cFrgOoXJoRyAVTniEdSjZefBCKCaoJbfAYxZNdywu1oZ8
 Vkf9keTcxiaH5vYuGU+/oAMVu2ccEP+vcj63Ssdl+JxGzxA3BRG3SNo8xYLkEl5ud8BoWNTo4b
 K2g=
X-IronPort-AV: E=Sophos;i="5.75,328,1589212800"; d="scan'208";a="143267587"
Received: from mail-sn1nam04lp2056.outbound.protection.outlook.com (HELO
 NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.56])
 by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2020 01:03:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Av9tZaqKh34xr1uqvz2IoOud8n0eOvL9kdfqMcfmdYY7gmbG5f+NfeDRbikFhnZGEtEB3MAPHPOPFtHyLt8aKDOsE1dOXOO2FJOFgKkFwyHDk0KMmYya5sP1ui2PN4sQu/ajOoKgzysJg4HJfxaaxZRxK6VS7IiM3LuGK2DHdtDPvzNyQqyecu7Gbt0YOm8F5T/0FkoihkYsMsyCmzMbCupRDSD5DLaCaZDhfZM7dx7H8WfoYSH0oig5TnC2y0blnigjDEgxbauorsDcOPP/XLeI+Ik4X6ec2X6VynbsZ+48ILpPvq68BOKeeT7jbQDLcCuy54bxic73VPH3BUER2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0VE2JIlzn2CeR95mYswwgZatJhYTBbl/ag68CnxoVI=;
 b=ek2hcd/5ZmWv0O9xGlllItXnxLxqa37OYdNSGpDYmcfVDH7z02SS0q5McupybPvAsTqh+yGezNwWN+a2GAbpu5acO4JmxaWlVn69gJ3W7Cka0ga1deCHpk3WDD6geaNh9DxEr7mTdZEHEwQ4jFkU77s4TFOpYe/8C6IhLioW7n+SqdYBsfxVxFPEKEewn4gun2cSVNir7EuZJ4Bxq/eVqOdeMNvAccFB8lW2OoZqCQnOPYXsxGXIibq1yCnBuyfc0+WPDWDBhb2ktELI054AGXZzByLwyghjrCwNs+kVcYqOD2SNDIGpEBBJI2YhzG2i/BFP+U15kPCM8wUwXiX1Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0VE2JIlzn2CeR95mYswwgZatJhYTBbl/ag68CnxoVI=;
 b=LAdTy8xXx0fhUX1uZYw7s4LgNQBYKeTwFJ2GQxqv0lfFO8g6ViH9Yc9IbX46miL3/f36yemi0YsuUKrXgxBaasTa3N2XdBYaYbPy/l1f17vn94Fq8aL5eiDNN4/ardmIF9KWFDk5u9FG6VqF/TzNvStFmhuZOwrEOcpzFo2RuTA=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5528.namprd04.prod.outlook.com (2603:10b6:a03:ed::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21; Wed, 8 Jul
 2020 17:03:22 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3174.022; Wed, 8 Jul 2020
 17:03:22 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "kbusch@kernel.org" <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: remove ns->disk checks
Thread-Topic: [PATCH] nvme: remove ns->disk checks
Thread-Index: AQHWVTcb21gvh+ev4kWvVxyjNoG37A==
Date: Wed, 8 Jul 2020 17:03:22 +0000
Message-ID: <BYAPR04MB4965961A5342BA0FE13F461986670@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200708144015.315108-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 89188a7b-5154-4d3f-7504-08d82360d283
x-ms-traffictypediagnostic: BYAPR04MB5528:
x-microsoft-antispam-prvs: <BYAPR04MB55280A03443DDE33AD38335586670@BYAPR04MB5528.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 04583CED1A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zZZwUtSQFzSP5hsreJQzcUX9Y6x9IumbZxGOdXLCnlntfbN+L8lqxZZtrDFExHJqPuNPqy7WzgYbOcrsgf/r1igvCiJgU36pb/aOdWQ3kfY1WB7CIOaZkjCpU8r8I4WQZAsKbC5xZDVz4zU3XYi7Z1lmcECJwwBMNsm+/QR1n5MRVR4DX7ESGef9vWPzQf6Wj58qRiRHRV1NXQWFpsjq4twujl9UPv0tCow/asJR4pITAbO2o8IzDIa0Jqb+4xdf7d3E3SsQzCmtyaavW1k+17Ic/8DxJznO0eCHBP0Yk2Xr22U0tKB8L0xMfD8rPCQon0ikTnJgYSkoSY/NmEVWnw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(26005)(55016002)(478600001)(33656002)(4326008)(316002)(186003)(9686003)(52536014)(76116006)(66946007)(66556008)(66476007)(66446008)(86362001)(5660300002)(71200400001)(2906002)(8676002)(6506007)(8936002)(53546011)(64756008)(110136005)(7696005)(4744005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 7N0zS9Ga0Qmm6+glsJW1aYDhZ7upQEDs9s3zdy4dh4Ga4hhe/IXXAlb90JBXmnUoq2XU7HGPZAfkMpJoPIcJp6//a67vEdVXcIQctEQXe42AWnHyraslpklNGeaiCsSiHokxHyj9/GRe9ZD/cZbIa0hPMHmCP3R75zo5WimiheeCOf3QbF6biuITyK6jjROWrtBt5K4i/h17YNvxJgsIPXjh5nQKMS7EPyk09wf6M1aZFASL9BMUOw4Ubk69hbXFD17m/YbeASIsDp/MysmtxxTydoOB65iEepA+MuhCCy6gOZLaPWvbcMlJV0iBhzMXLacA6bokj5YKom/sRGH2urTwTn3zES3fZkGdvx/bpLLFdAz3hUiRviXVXjys6k9n//2l5OOZqMLP8x85gWrz2L7woYrmUkPXfSvTiJzqWAY6Cq4YHYENDJHCt0GJ2kyJquLnokunZ8YTf8oKCwTaIf9XrJFQc6gU3/9eW/JG5hA=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89188a7b-5154-4d3f-7504-08d82360d283
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2020 17:03:22.6329 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SilFb9PkMQ6UghRZrP5ov5IVxSyMPMeybXlQpb6gOIjPv9sQCWgqk3t77wowEUGIt/ITWUnd7DWUpdp2BIGjraCFbQhAfYP4s9n62U9mGWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5528
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200708_130329_445530_B00F0C8C 
X-CRM114-Status: GOOD (  10.14  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 7/8/20 07:50, Christoph Hellwig wrote:
> By the time a namespace is added to ctrl->namespaces list and thus
> can be looked up ns->disk has been assigned, and it it never cleared.
> 
> Remove all the checks for ns->disk being NULL.
> 
> Signed-off-by: Christoph Hellwig<hch@lst.de>

Looks good to me.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
