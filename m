Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4203AC47423
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 21:46:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B102020774
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 21:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bEKThj0l";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hc4OVIjR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="PjpfciCv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B102020774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=Ky8ToWdMlJ1157mVTS6qbbm5j/zP0g83A8qqeFNaN24=; b=bEKThj0lKTnkWUWAq7dAFwlG0
	6RH6VmIq0hS8ApJB+YNJ3itycMhgiPkBP8e75kHYJYC106jPAfqQvUDlM2kg0rBpzCBRCahLMeL3Z
	zyuy7Vyixqx4LWNQR24umQMb4GdLApwUHwb+bf6kGzHfGVUdBXtlyzaFCGj2ynmJENh1hyPMnFvgA
	1fAYZ/ezrsKKTB4KUWMtm77NjUXa9GhPJgZ56xlqllRoOqVOC77GszsFBcjwGnN47xT3HoUIKHRLG
	beQgDWCKt1HvRPY6pLE0C18sPA6lYVNpdhfgs7SoOI0x3DE6vE63WiZ1w7rCIhA0FPqbNEqPPn0xm
	SxPHyV0WA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNNSB-0000Ey-QA; Tue, 29 Sep 2020 21:46:31 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNNS7-0000D6-PB
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 21:46:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601415987; x=1632951987;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=YaWDQb6cCYLaE3eCXBFPkNYXrrWJoXlVjOYSrunQ/Lg=;
 b=hc4OVIjRwEEHrjk5AfGPmKtGtDGVkqIh+DSYYhAMxBqQr9znHq2QV+x3
 H3/K7AAecuMaUuMpQAo8viZrE1zPN0Gxw/eUQhl/Fy4p4juYWuX59Thwp
 B2i/IzCi5Si0zxjxXij3Om4Z8UM9xV0j3OvEfHH3RS6aRBXTPCFl13ynh
 z6L3VVQEjJtkp8zpbEsGByWpHTR3Xt/D60qEu0T+AbQ0100gL1lVA8nLW
 h1omokaSPvA6X/XMcXTrnfKoIrtGEy8XCUIDDQYaObzWUwUXU67m47bbM
 ttkpBukrSLMcPgC5ZbpWn6HO9kALdRgIfgX5yrRo7Psu+IdTR8CeP4OqV w==;
IronPort-SDR: OZvqzUYfZ1tT6jx909EakH7LyAx533AArKCQuu7hgbOeR+Ngac9INfjQkfZJ79XvRcs4ETyzMO
 02mhsVEatwA0lATk5TUQ1AmVYsSY+5wwJ20lItAoKSoGhyqdpJWScdTFAcUFqUNBuW6lfQhnMk
 5K5tW59PD4NXm1nENST8Srg7du6PQb8gD+IulZbc+kWmI1JZMHPjKfIKTDxBNVKizX7YN8lNs5
 Zta3dnJzwsIkN5O8yBDRBQwadJ+ky57NOS3+wfDP7ged0wQV85YuFTT77rlMpoQ+j5CylrqsEt
 VEo=
X-IronPort-AV: E=Sophos;i="5.77,319,1596470400"; d="scan'208";a="148622409"
Received: from mail-sn1nam02lp2051.outbound.protection.outlook.com (HELO
 NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.51])
 by ob1.hgst.iphmx.com with ESMTP; 30 Sep 2020 05:46:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVKjsfJfLcKImb+Lo8JCwG7BZO/Gq9jpWhNf3PeQV8CvXjaE2tCNr2oNgVESIDCQJ5js9143V3diOsw3SEGEIgDbSYNl2S4lqjiW6dc2QvNIQU+hXmWvufFGnNYUUpMo7ckUKwAE98BDIiT09NLbAIulbxPNreguXz1HmaKaYch/snUhoyIf62NVEzMeu/a3pkbhV0SzFhNw9iEF85/k8BTbNAq5Lka1KRts8BnUd3CnNUzahAzvpIG0BcjPCmFL9mgqpdHT8aP7NlFltRhR0CSZPusdfDMR758Y+3xbJEc36pW8nfDHyqui/7st5uTk9vIR9MMYs2Crmmz0TVQahA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaWDQb6cCYLaE3eCXBFPkNYXrrWJoXlVjOYSrunQ/Lg=;
 b=HSEs8BX8lF1B5HrSoqbKDBuAcGs+xcvmNld/Ue2uPRmgEKj884qq+o6vlhbEqlJmWhKVDnIpsiybhPRwD/kNoOxdpb61++DBx8/zRp+S8lANr0wdIrRYvCeCVUO4NmJyfoCw4VbPy6sICtuytYhtSekZPqGOMLD8AtQKyOJfqAzQABLEEMhGSebG09G8neuCMpivh+5wJYF1humsyt+LIVlScdoPKCeZ0VrmQX7LnKQQ2WNQx5ZFWvURCYSdmiXZYl6pjCxj5IrrSuS0xs+mKQC36pVkzw3a9qeyAW0K0ESftYqF26Qnt5lxhtMKeDOLns+Y8zYUrgJmFJmWYR6a+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaWDQb6cCYLaE3eCXBFPkNYXrrWJoXlVjOYSrunQ/Lg=;
 b=PjpfciCvbBNddZd/92+uuU+LRtxXY2HMKWM+IMmv3Zpjsu6UEczoQsnDayQd2oR/r4JlkId6LZNQtMfKWgF28FGh5eGhkIrW8P2I5XXsmZSsSibdhT6TIgwVXr3YcTtF36gvCYeFWxr1isPcSWRP6KegL/OvgBN4h4pG6wwSi08=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4869.namprd04.prod.outlook.com (2603:10b6:a03:41::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34; Tue, 29 Sep
 2020 21:46:25 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::e1cb:3a58:d588:d7eb]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::e1cb:3a58:d588:d7eb%7]) with mapi id 15.20.3412.028; Tue, 29 Sep 2020
 21:46:25 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 12/20] nvme: remove the 0 lba_shift check in
 nvme_update_ns_info
Thread-Topic: [PATCH 12/20] nvme: remove the 0 lba_shift check in
 nvme_update_ns_info
Thread-Index: AQHWlZSwpN+WRctHDkSQl/kB27wN6w==
Date: Tue, 29 Sep 2020 21:46:24 +0000
Message-ID: <BYAPR04MB4965AB77ABBB2DA11DD165CC86320@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-13-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3d2da82f-8782-4a70-5539-08d864c11d13
x-ms-traffictypediagnostic: BYAPR04MB4869:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB486957F60F84F15C134D3C2386320@BYAPR04MB4869.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:541;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GMcMznUSNRwQYZPVPhaUQGNTih3bQzv5HZ+z+dJ6wF+lXkBXrhU/YyQQK4zWF4yB2kYoimt3a/gEomqMZ87+/V8i7qZdtdwQHoCItmdKgl7ZlDWZrgV6xxZ0hDE5+WrZ4T09w5XmDnDUjVVahy4sNHSYtq0J1/Q/Lb9Grchk7RxLtC6zuRyKmN9cUGYCz+HzWGQOPHcOuhs/r8CwadcIkket1qbF1AFpd/M5d2KCnI54YA8UBPwmRCmXITTeYvVJKU9cEEqZYqAGTZLN49aXKXP6/SW+BMygsy1TuqIFI5B/RJc/ZqPLwEfVhh1iPtTk
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(376002)(39850400004)(396003)(66946007)(66476007)(66446008)(64756008)(9686003)(26005)(55016002)(86362001)(76116006)(71200400001)(53546011)(6506007)(7696005)(316002)(2906002)(110136005)(54906003)(52536014)(186003)(5660300002)(478600001)(8936002)(66556008)(8676002)(4326008)(558084003)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: EKIlhr9cXqOklgECzQI/sKJgX4FurrNW9VwF88W3lncCoTk6PjjAXEi5rO+OtYO+WM7IsD3pMWyqEz+V98vD+/D/xDFgDrd/SvO10q5L0R516Z47SBnlZ1gnirpwpG1ISImXVYKm9RTFVd1neDXLPGYzYa1lRjD68Wc/tyREGZZPZ30rKszZySLB1kQhKJY7mVxY2qyAOMIkYUmCaW52HqaZaVu4Kz+KFnFjP4MXHRsHUxDpbWtf/Q3uZCVm9FNq/ViKpGQjGhk57F2sVFI+DBoU8y9AN3SSQLkjxHIJFrocPL1gB70UbNZi/qJKHWVCI9quS9hvWcxspjD+oBNjGhGjGAbHYG4E9ixJ5sFbM3jZtsppCoQU5P32OK+WG0cMfFg3Oqd09CqVNEDVJ+V1owD+gS67vjyq4RKCfowNEaQ5AUGLWw0haRCPRsafrwwzJAwuf6w2c8bc7QpCS9HsR8IO4cYfo//J+WjVQEvTZop/YRAWPDBXPdzHBhMmXXYuBUwfHiXcwY8oa9JChN4z6CUt1d5GUTozYv88Om1OWO5NN8H7oEY6+VT3cVWSV8j72MzfxBhH/mlOo425zcNJjUmb5cTN9H88dc4cCtBIBJvOXE/7KeauQFfo6Y9/QCjf7PSAYQSYbltSJfH0bB8nxg==
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2da82f-8782-4a70-5539-08d864c11d13
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 21:46:24.9898 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TnnKROMof+3p75SGy/u0CsPCrDkx/fpBfXbBRGXaz9KpdOCR8SSpIuoiRfobqGoobxAj8fWvzrgz0LaT4QdpnJDGlNNWslkQn6wHiuE1cyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4869
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_174627_976567_DB8DF929 
X-CRM114-Status: GOOD (  11.34  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/28/20 05:41, Christoph Hellwig wrote:
> We can't reach this code if Identify Namespace failed.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
