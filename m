Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D2BC433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 23:08:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CEFA20734
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 23:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IvKSd4fd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PHKaN4Q3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XTSZp81u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CEFA20734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=CyIR5z4Yj4wl4OjlgVo2umWUHvDbtEeP0NjUTwI93jk=; b=IvKSd4fdWYTo8d+8SOzrjbyRi
	rC8C9py8gpO0RIZTEbjxxACqa/QEy8+L29P6QYWv2XPU/G4nj6oQVeuHX3xK6LYXCIHp1iULhriwm
	3GE7/hBFFl1WA7LtxDdCP14TMXly6tDrpI+fK6cdRg4hOnMiiP9s+NE5uxQZDFqNN9amPvUfpwpha
	enoHkxiCIW7ovxIXl33K9o87pRLCV7CaCFDBVZN5XstsNCx5hrclYJ1QwdZn9YvEuq9cLCcnTqcUm
	SIgK8v+wWx8MAFUcgKhTGCvFzF2+m/26M1p2NeFs+C2hFByoFguXqeThesTNreoMnTZTMsH7bhVny
	yG8NO53+g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5Gtn-0000Ct-Ip; Mon, 10 Aug 2020 23:08:11 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5Gtl-0000CL-4L
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 23:08:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597100889; x=1628636889;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=+nFZdLhxQXinCzCoQAkKtlLlpmlPV0uiogKS1V15oHw=;
 b=PHKaN4Q3DO540C/YaYxjqFKRsD9+elUJOg6uWqMOlC4v7hUZAwosd8iM
 pIPR9OComZJslUC2dvSpG2NOPCxSBegtrovb37jpYTpxl8SPdQ7vf9QZt
 wubm8ybbRkij99nzKHbWQFHdFhWHPNMIJvaBMvFaOMjVp1pkeJmeo7PKx
 evK0XYvgF2nJuvbqLhtBQ7m6Q5QIK8YD3jvxC5RaALIQAw34+8EyJsQjw
 6M9mch0cOnPDjyrf48198BvojG+LfbG/jl0r6eXWtTvkwyLv15aAapSt7
 WQ83qB4hLekOYRVFIirqgeKZCJeWz5f8TI1cZi8SHD3bHK/5PS9sujo01 w==;
IronPort-SDR: cYzDPnE2IRIkHymjc3a7egvaoVwzuBus/bjfleVf1j/pq1mpjYzNEc7HAeAiMt+hfoV5EGDRql
 nAKLP6MHrqvK14qoC0E+KfPUo6cASxZP2d3F9C18goa+qhiIZJgufXI2371oX0QL2hFsioPx8j
 cgTROXyDZ1mc6kDOkIFUbJWxK6IzgFHSO1eu3L3Qlg+VXa3EhgG+WhvvXO48b2ckrWZbRjozgN
 AMFaF6N6Vu38POjNnRatciKcjZ4gdiSMjxVWVE2ESlXN0vs6ojlCMPUOyMshKalx68pit6vm1x
 7bo=
X-IronPort-AV: E=Sophos;i="5.75,458,1589212800"; d="scan'208";a="254004394"
Received: from mail-mw2nam12lp2042.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.42])
 by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2020 07:08:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTB5/0D38nCQoWMJ4VeAUe3pdHZ+rIl+K2dw07DU8QJ34S6IzcJdN50dS9JHpkQl3s8X3jCrlS2eLkePyx5OpDQYiNygW86Yj/d9FPqw7DUw8DXDzQN7838ePYm0R4OeIcRB1FTP+EImK9QcbaoUPEK+/G82LXgpFFQRGOHznI4ljGOV2PjucqoT2eIrBTo0j1Ep1kmTtghw3TAOLjLnwrpLe7jQEx0kHohvCgSUZbSu0yHKO8jrpmJMN2Tz/0bFEZfFVlkqEK5r2TuhQbHXiisARWxB8PS1Za1dT+jCzP6vs1olHZ9RwUloyGb8Fh71t4CTTckZNQi3qMmjoQ0qXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLwU4UVJ9huBu5e2W/+6TDwYi4yqBpqHridQM7Or53E=;
 b=O93nYNiSYwhgCrXvcKcx9cJAIu52YvKP1Us7UYEhFjYcRDd7n1MMfDfzYIo5J90bavxrev4IXWkMcL7JUoZzEUKc27fnWEAEEpFVMD2uxlvF9bTZ2BMGACMGsdkpCc+y8P4JXr0Qktl2pMPzOOeNgqL5oIMnEtDUXuoiY+ujAbBapvc+CtjINpR7ooj7aD8qR7pPeTa3Yunepyt7OtI6F7n2Ig+ZjQYcJ4Uw3Kty//Fy/6ruxxpiSL14A5TBEWSFs3yi9pFrKwjPXFRouWRR8iKP9h3aljnkQY0n/wjwSkYN9toyNJyd4diCIbNB4a/oIMuuXt6Jq/9kadns5RoXQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLwU4UVJ9huBu5e2W/+6TDwYi4yqBpqHridQM7Or53E=;
 b=XTSZp81uhOPvX1/uy8eAG62Q42jIntRHEBB/ngYwdndOJ1mY4zI0BkcuooymgueR8Hp5GU3S04HewxupzTJvvr6415Y82MEJQfnBdhesTCWbCifTYMKWxq/VfxUmgr1mwYgqli5E2jGD4zZojgIajMrf0ZeCnxEQg5v38dJ3CDU=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5255.namprd04.prod.outlook.com (2603:10b6:a03:cb::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Mon, 10 Aug
 2020 23:08:06 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3261.024; Mon, 10 Aug 2020
 23:08:06 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Logan Gunthorpe <logang@deltatee.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 08/14] nvmet: use nvme write cmd group setting op_flag
Thread-Topic: [PATCH 08/14] nvmet: use nvme write cmd group setting op_flag
Thread-Index: AQHWb0fs0yKpxgu3gEaaZuX9mEBqyg==
Date: Mon, 10 Aug 2020 23:08:06 +0000
Message-ID: <BYAPR04MB496527B7BFE2E1049B6E6FF386440@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
 <20200810185456.7713-9-chaitanya.kulkarni@wdc.com>
 <ec013b0e-e9ac-f6b1-3285-d281a81f74a0@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ff58910a-6ffa-4942-fd1a-08d83d823dbc
x-ms-traffictypediagnostic: BYAPR04MB5255:
x-microsoft-antispam-prvs: <BYAPR04MB5255822281BE3CF91494962C86440@BYAPR04MB5255.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gaOPT3KSGKCw9s+rRFhAGFpIL23F7RJv5myiNahZaS9UJeQGvscFrf9pD8JAtswGQ6DhZiYQn4nP7tMCfPSibLbHnkC8ojw1FCecPIxAFSwhEcdCrNya5u72F0KbfhbJrQM9Ab5UAbyvD+mcuD2Sd8o7QdZAUrM1zdYkxMSfOkNHS6yRukv+JGnlLKIv48V2pKFXL5xwwrzMUXiH4r+NjuP4V99A118DcFqFFf9Vv6gFrFc/oL3FRM0Ku5ewuEYvNdIVsdNSRZs9iMsdPz7Xb3bvOdOiX/c0pwCoyCEnm1sqy+iTwU1nkhlTPGbr91Mu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(5660300002)(4326008)(55016002)(8676002)(186003)(478600001)(6506007)(86362001)(2906002)(26005)(33656002)(52536014)(7696005)(66556008)(66446008)(83380400001)(66476007)(9686003)(4744005)(71200400001)(66946007)(8936002)(64756008)(76116006)(54906003)(110136005)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: anQ5CD7evYnouxNu6cjm6WcwE3Xp1XUXY0LV12HiO/Q1MtVqbCraAWjMDet5x7BixVMX3jXBFvPObRss2M+UP6O4wkWbKH+SVmSP6tz93SMFaa795sJlwbFS/v4mGQUuXld9q2FWGkesaeIB5GBIuRVkrgjNlgGfSkjzL6nCU5Czcp66vbc4gM77SxWiQC90mE8wRndrygT+o1YH4pwEjZxRUFmQd8d20XQ6kJYxq0BUxhLppR3+DRno7DuL/0QXBuwltlG12P2IPUMn941YMj7rnDgsVp8WpwfDYfVwXjwccbjIiCFXTUUE0nH78VWjnTMWKOhHlPg87tprmOVsYrN9bXBSPuLvMABEHe+00FdKbmIxB1d0Awn44qjjKG4/txzNtL5IvPD27KyMOBUTfL97nL6/TmO80igmGdk++aZD9DNE2tAUFQZpmCw+wceTt/Vn7TeG3K9YDJRxJN5ah49tzmoFCAuIAoBJSr4TwDidG1s+R102dQFU0JQqBfoySbeSX/LB0ei9HlqmpbeZHoUAGImn52EYBuztuXBeP3/joTXnQ+zp0cHnJglREYrDj7DiqaL5jxkW7FYOzIoon6+iyD2THTBpc0MCulsezY6hqbQLzG8OOckt4Bcptwfrjs6nl+MT3CMq8jJOEie93w==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff58910a-6ffa-4942-fd1a-08d83d823dbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2020 23:08:06.2814 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BDlDFy3PddJHXnO4IpoHB0v3Y++FihV33KxoPSpOdAPy1065SRpOx9nRbUwSqGGa/XA7rPeTFfXWAipdnGBySv33RDz2bfemwEpeajWCgKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5255
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_190809_387489_34CDCC5C 
X-CRM114-Status: GOOD (  11.38  )
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

>> +static inline bool nvmet_write_cmd_group(__u8 opcode)
>> +{
>> +	bool ret;
>> +
>> +	/* NVM Express Revision 1.4 Figure 462. */
>> +	switch (opcode) {
>> +	case nvme_admin_format_nvm:
>> +	case nvme_admin_ns_attach:
>> +	case nvme_admin_ns_mgmt:
>> +	case nvme_admin_sanitize_nvm:
>> +	case nvme_admin_security_send:
> 
> All of these admin commands are rejected as INVALID_OPCODE in
> nvmet_parse_passthru_admin_cmd(). So adding them here seems confusing at
> best.
> 

These are extremely important commands, why these commands are
rejected ?

What is the use of passthru if host cannot create namespaces format ns 
and sanitize the important data ?

Implementing Namespace management commands are in non-passthru mode are
NACKed if I remember correctly.

Irrespective of that it better have it documented there is no harm.
> Logan
> 


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
