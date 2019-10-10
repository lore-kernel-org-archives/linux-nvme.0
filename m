Return-Path: <SRS0=Uo3O=YD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636CCC4360C
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 19:11:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EF302067B
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 19:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R3Zx5nny";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PRfuFUhB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="PNmzNVeY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EF302067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Zkmzmv2N/vrsSy2YZr6FJ3+UJFaRxEaH9qUU7kqMuos=; b=R3Zx5nny8JXO9v
	6sVk7ipYpDICYlKabJ+hmgTVbyfZ7kdbkFQw5mXmRwAMNrZyU+rSP2T4uZIndHMwSxAxM168IvymE
	gEu1v1KnoMEzRMxBFd3z4nBiiEaS/+TM+YnqEzv3RUqtCtH/KumuPbTRHGAmFwYu9okSj3pcMzOQj
	cysAuyHoP5EivmyK8vzFAlxTXUKPFHzorQsOzCWdFJho5yf3JrBw8mLx51xp1ACJG8yu94XZSkIta
	vAjDa5qNNB3DJIW29pCOX1DsLhezRD/kr4UAtyv+tHMgSHLlU52Z9Txf+RVL7i1N0lxZ00wVBhu5Q
	yrWYr7fm9Igd2WlkF1Hg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iIdqH-0001ik-PQ; Thu, 10 Oct 2019 19:11:17 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iIdqE-0001iE-5S
 for linux-nvme@lists.infradead.org; Thu, 10 Oct 2019 19:11:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1570734718; x=1602270718; h=from:to:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=IHi87UKOGklhppWB1KQLIFgJXTNDt4jzUGPHdaILDLE=;
 b=PRfuFUhBtaAQEtth0sjOy2OMYVzgRJynJcKN9w6SofAZdMLKPeky/STQ
 gU0ltp25/lHuRzy9zpYt52bWsP0pC4ilvIdapAmRke7uoBN2B3EDP4qid
 BQWM1RhxzzUNhBto39m1bd0bJWtzVasEe0giP8f/ckj+vXwSiGyb3I861
 Qm8I7fpiOMNC7sU6uv/xfkYX9yVH+ePjoM99L5og8G83nEo29dZFjmkw7
 3SpO+T9/bit2umjCMuKeBesY/FQNOn8ZUkVS639MbFyLPXU4VEyV97Yex
 dUnykiQYmzKgDUeJ7sPFtF4r+9VaLVyMVtCiNXR4MWRiZYo0/UPm9gwsS Q==;
IronPort-SDR: Xye2XGjte9+li8nyAWWy+9XckFtevUQaF2OLBjHZQeveldciIhM97MbxvdOzk8eXPEPTn1j+tv
 6EQZvC7tFpX4DB1AHc6aeAHQmzjiqwe9JbDwQDbrZD5eQvupzTsUOuAX9o6E/7xcqa7dztxEZb
 pfZp8CvWyvpzOG6NNbGdMx1Agzc16Q0pG2oRtrAn3CltbP63eYL+CCpV4qtUDZ1C+xiJCvejHi
 1g5a5lv1d2kAN7exjhMyc4HIgRqw3u+vL3KNxwTYEekU9+EQV8F5PGTLYDNOAfrSTWX4BgMk2m
 /ak=
X-IronPort-AV: E=Sophos;i="5.67,281,1566835200"; d="scan'208";a="221271079"
Received: from mail-bl2nam02lp2053.outbound.protection.outlook.com (HELO
 NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.53])
 by ob1.hgst.iphmx.com with ESMTP; 11 Oct 2019 03:11:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AP42ARWBCQn1LyaKZW0r9kmomnrUW2Zi3IYHx+RTcZYR8GgWwDonSYm2vIUCd9SetnDy72qlwLwWHpIDZwCrluR8re9oTYCo2wglpYak0uSXfy12ZOc+imykgTeStOVRUpZuPugIsmTZmLrtaGR2nvGY7c4DhLJPcvCvtMKvUg2CjkNuB7SQIeW6lsGCiTsdmYGxbiZ/DXlSX2vmzR0UxXbLNri0QkYHZ1V3O49OGf9h2mcdFa02DZ7rE6qJaISJvE4NeZNtBbWEUdRNpEBh1DS6hFZpZK6qzaiQEivaGcxRNTxP0LfDfK0WwbLprEz1tdRCo5maS9GA4BDP4TU3bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2E0TYr7I9VkBDD5Fxx38P9atWTpZ43TBxF5ahX1q/v8=;
 b=k1hYWqL/YfU9okgi019Lbpg7X7eF+e9VCr8a0DGt/ReYq8ujqikwEL9Vza5tzDGUAy30uGbK3OCgodZh8zKmE1LA5zNYr2N4yEpm8uKOZPhXEFwrc0m7rdb/w2xvvxD8aOU2U2aIkJb47+5Ex9peczPZgsKxRIH89fPVannC/ux+77pDqKgEvUgE17rsSoA1/E27lstiferNidVmQSNQSI6LVgCDPiY5hhkEELSf+wdfsHEKLXRpcrb/3zzi2a/wqP7kJ6QZDbtV1PwP5yfjgt0FOBm2WY+8MbnZMF72RTVFmY6QwapGcFwvy/fvm1K6G2DBNoV68lvVQD7ztro6eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2E0TYr7I9VkBDD5Fxx38P9atWTpZ43TBxF5ahX1q/v8=;
 b=PNmzNVeYn6vxsVjFvPk410bBjNtasOPpwlbrQlk9fejpsBsRyrzRxTko3UPCwOkOSDdg/3PhFnku9BLD0vQoI3+rFGjVF9BNtDue2cWRgSLarr35vJQSVAy7DwgzivWPZ9ANPCwDZ/am2zMr0HZuOiYK7Sx//qDDwlJe9fh9G3s=
Received: from CY4PR04MB1175.namprd04.prod.outlook.com (10.173.195.148) by
 CY4PR04MB0775.namprd04.prod.outlook.com (10.172.137.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Thu, 10 Oct 2019 19:11:10 +0000
Received: from CY4PR04MB1175.namprd04.prod.outlook.com
 ([fe80::6988:d052:2b41:d002]) by CY4PR04MB1175.namprd04.prod.outlook.com
 ([fe80::6988:d052:2b41:d002%4]) with mapi id 15.20.2347.016; Thu, 10 Oct 2019
 19:11:10 +0000
From: Jeffrey Lien <Jeff.Lien@wdc.com>
To: Keith Busch <kbusch@kernel.org>, linux-nvme
 <linux-nvme@lists.infradead.org>
Subject: Issue With NVME CLI list Command
Thread-Topic: Issue With NVME CLI list Command
Thread-Index: AdV/nKkBxaoD/U8hTdiiwmMsi0edrQ==
Date: Thu, 10 Oct 2019 19:11:10 +0000
Message-ID: <CY4PR04MB117531DFE8560BD3A72787CFEA940@CY4PR04MB1175.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jeff.Lien@wdc.com; 
x-originating-ip: [199.255.45.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1580dc12-f6b0-496c-5114-08d74db59c44
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: CY4PR04MB0775:
x-microsoft-antispam-prvs: <CY4PR04MB07758D98C4DE02859DA4B3ABEA940@CY4PR04MB0775.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 018632C080
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(189003)(199004)(81166006)(102836004)(8676002)(8936002)(7696005)(256004)(33656002)(110136005)(186003)(6506007)(26005)(316002)(66476007)(66556008)(66946007)(66446008)(64756008)(14444005)(478600001)(81156014)(14454004)(71200400001)(25786009)(6436002)(99286004)(3846002)(2906002)(6116002)(71190400001)(486006)(305945005)(86362001)(5660300002)(66066001)(52536014)(7736002)(76116006)(55016002)(74316002)(476003)(9686003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR04MB0775;
 H:CY4PR04MB1175.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9RCLdfqGEJxoTdvrG9DRlIrcuATvaVVtYmaCvbwMRLBvqg0PM7DlaWmmsQd850ISuEXH1ZUMnQA4fu1S9pXCj1WJkJurKOdAdZZMNPsgJrtFV66gdF5tpTopCMwzh7G7Qk3Ze5iwA9fObsb/lraCNKzWn6L5J7F4fT0+3d4WTIOjkMLAnvLvUTn06xR5AidR0FJpb6YqvScfUy03WBm5V1nDh15fEvGdtROI5kiYYegAi/ldUHEE3+tHxkNHmRx2ZVMQMm5Gz3ZrRT8y/GIu3T3yfZ83KsvVrFpnQf6Kxs5wZjZwsrJ29sJRNWn298LcOqgZiJZVWwIvg+xiweL77WIe3Xr/m77DrenwDHie8EunmQiygVU3QFGTPaio+Zh3V1QgzTGWePPn82D+3ttJjpVwUqljRsOFQX/4zSHkpcM=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1580dc12-f6b0-496c-5114-08d74db59c44
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2019 19:11:10.0527 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OcdER39HxTep1Vo/5wmmwBTNKQzUh+WjavX93mqNK4iuxIceeaKpaigebVtgjD+ZZEGcQq1h+pRFE8Y6IjMU8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0775
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191010_121114_298010_4E034318 
X-CRM114-Status: GOOD (  11.81  )
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

Keith, 
I'm getting a "Failed to scan namespaces" error message back from the "nvme list" command after updating my fork and picking up your changes from Aug 28th.  The cause of the failure is the following check in the function verify_legacy_ns (in nvme-topology.c):

	if (memcmp(id.mn, c->id.mn, sizeof(id.mn)) ||
	    memcmp(id.sn, c->id.mn, sizeof(id.sn)))
		return -ENODEV;

The problem I see is that ctrl info is never filled in (at least in my case).  Both c->id.mn and c->id.sn are blank.  Looking back in the legacy_list function, I don't see how the ctrl info is ever filled in.  Maybe it's just something strange in my case; I would have thought someone would have stumbled across already but maybe not.  If I remove the above check; everything seems to work so I think the code is basically working as expected.    Could you review the changes and either confirm what I'm seeing or let me know if I'm missing something.  

Thanks
  

Jeff Lien
Linux Device Driver Development
Device Host Apps and Drivers
jeff.lien@wdc.com
o: 507-322-2416 (ext. 23-2416)
m: 507-273-9124







_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
