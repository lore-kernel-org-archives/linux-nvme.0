Return-Path: <SRS0=hdrt=2A=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A346C43603
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2019 07:23:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ABE5206D5
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2019 07:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PEMdQ2Ip";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="j/RBNHdy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="PdkXVKy8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ABE5206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=XZhS8jQoD1betr+DrSxqLYr5k7EWychswlwwBO9pf8s=; b=PEMdQ2IpUqXey2
	XhwlzX7IMDb9FqtaTMXEd/ZhEME1ZTmLTB99QSl+9p64ztbMnOYosbUOTx/81w3uQqd7Lu9yijo7r
	Ffv7aof6wUHyGx24MQP2SxMKJSaxlXESV9gHYLEJYcttmCVconoQOAhbMMIsT1pfKob7112l6pbVI
	AfVquL7zo0GeqJ2MEavjAVzsfk2yiwqOJVulObCvKkSy1mnamoGzfuq9oHnCcYp95BxeS7LtlU7q3
	mLqxr5mvTkNkDxXmcU6IDhmCLmaVTkBG1H5MxcRedvoZTgm0TQSvW6pPFzpqjZ4SLZ91+vSxw5IPb
	KMQfuvLqYEtbmVtvLVHA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ieZrU-0007Ol-UQ; Tue, 10 Dec 2019 07:23:12 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ieZrS-0007OH-7i
 for linux-nvme@lists.infradead.org; Tue, 10 Dec 2019 07:23:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1575962590; x=1607498590;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=XMzDdgIOOHleRtHXWI+oMNbV+gLqeJvyUARYB5oRj4w=;
 b=j/RBNHdyO179oGpNnfCF7OBZbY4/M020TrHjAI03QrljDHfTLno0OjlS
 UbeJymsQ9aTzVahS5Q/77egeBGChcYvLfaxTgYYoZCSl1RcTYnRNsaTcA
 RU6+6EZnA620pli3wv8fNxwG2OX+zuMFIZNQAN73XXhq8S0leMdZHX49Q
 wNpi2EBLUqcXXaPJbnDW+hD0kmYisAFMYHoh5C4H7qrlps1afUmSXqo5R
 riHuLbCqH8nYHKbl1z4T5dp0VZK0oAEGMzdpOZnB9kQyiuHoVyJdxJUGp
 U8IcqNzd9fICAZpecPJkEbYc03O4ZOjr+CRQ4wMDC+y51/6f5CKrPYnjy w==;
IronPort-SDR: iHrAQrlWJdwIFXzfdm7P7/MuPJoNdfe7CFtYpM0H8+BjMGHSlTJZJ2obbHmod+cRDS1owUJcxx
 o3TAtO+J9er1jre/iU1/CdZPnG/bXaeuNI6a8DLZKeT+qZyvGbvOHOza1WBBHYnw705PZfhhq0
 2eIPyNF+bk2w3Ze1UZAr3Q3r7+St1ww7O/LDpigG+o9Mm5v8p6KaloLQMFhiAdi7fybPTP0iXy
 YZVi52E6lzgInHd/mbrgpgNlAyqeHPQNENznkHJ7GAfB0NdFC+ZMZJwwG3/039wPMUbmOHIpkK
 3oM=
X-IronPort-AV: E=Sophos;i="5.69,298,1571673600"; d="scan'208";a="129427185"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
 by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2019 15:23:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yo+f97TJyTq7RbKlPPilVoXPkMmEZWMA6Au8wt3Kh7dZ/YeHqwBCF/h9sAaB70ZLzt8pyneH1NMrSfHuZPgUC1StERhwMIwVgm1vH9vl+cgUjAii4Khc+cnqB6YO8UFHuirKLhrokZxD9hXyDqvDxUpXxwU+51MePJxXvKBcFYRq6dJS6U678zC+o9H4BlFT08oQLJusfP4+YaybmOe8LrvLz9qMCCPC/aXUHE33vIfRZtExuPnl15wEHRrR+lIu5xyjQ3qEtWBg1RpCcdsOm3zgjRDZgDDd9a5qxt2IewiDx4JYlJY31Tw1gFU2YxVGNguSWSKaYUhGn+d5INmwJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMzDdgIOOHleRtHXWI+oMNbV+gLqeJvyUARYB5oRj4w=;
 b=fT9AlvZQNuXIWgitpKUqGhhO8atIZ85DPNSTBRIHn/WswaFvOCRP5Pyxlm1FlPVkacUW6V7E1vbXHnZwQhoBicOaSD4+R9LORabFrQ4Tj4rIfn9ojOjvX9yyG6Bz+MD7n6Z60TVTJAQGh049LCBfXJhuoqMhFGTu5EPvEZWPV86/QSuDqH0qRrREofSyZkqNdfPBS9z2pdcipLYp1d2IJvG7xPZUGJl8vPRzkpLto3wLBEdpaN/nCh3fzw78b0F6zUsR9Ub2T5EVFzd3l0hYLk//qVN1sWb9viEynMCyEGbLlXlFWQoy9QKq5O8zmAwpFQomipCrN7uC//b7LpNibg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMzDdgIOOHleRtHXWI+oMNbV+gLqeJvyUARYB5oRj4w=;
 b=PdkXVKy8PCPzT65pOenveKQA90J+Y6l5pKq1BZps++neZPyW/fwofKhmYQSCXCQgxWolYCJyTzUksLshkFMH6fmGCjygOejbiuqyyP7NtQZJCOAcK1L5t9MFqgYz7FXRugnt3ttPseijSQtRPqIZAKJHC+PkgDxYaETc6L+UKIc=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB3928.namprd04.prod.outlook.com (52.135.213.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Tue, 10 Dec 2019 07:23:07 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::c3e:e0b4:872:e851]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::c3e:e0b4:872:e851%7]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 07:23:06 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "Engel, Amit" <Amit.Engel@Dell.com>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] nvmet: Fix req->data_len size in case of
 nvme_admin_get_features cmd, fid 0x81
Thread-Topic: [PATCH] nvmet: Fix req->data_len size in case of
 nvme_admin_get_features cmd, fid 0x81
Thread-Index: AQHVq0So/aX9dSOzQkmXEUk46H5isw==
Date: Tue, 10 Dec 2019 07:23:06 +0000
Message-ID: <BYAPR04MB5749D2F3BF2C6559DE70CC2D865B0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191205081541.55962-1-amit.engel@emc.com>
 <20191205083325.GA855@infradead.org>
 <MWHPR19MB1487C34E6A3487475B480C88EE5C0@MWHPR19MB1487.namprd19.prod.outlook.com>
 <MWHPR19MB1487371362F731AE4A6FD768EE580@MWHPR19MB1487.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9f5435c5-4ca3-458b-502c-08d77d41cd7a
x-ms-traffictypediagnostic: BYAPR04MB3928:
x-microsoft-antispam-prvs: <BYAPR04MB392842E932A26296E5C00229865B0@BYAPR04MB3928.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-forefront-prvs: 02475B2A01
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(199004)(189003)(8936002)(6506007)(53546011)(33656002)(54906003)(7696005)(316002)(478600001)(110136005)(5660300002)(2906002)(81166006)(81156014)(186003)(26005)(4326008)(229853002)(55016002)(8676002)(52536014)(9686003)(71190400001)(76116006)(558084003)(66946007)(66476007)(86362001)(71200400001)(64756008)(66556008)(66446008)(305945005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB3928;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NrRYq/jePN/vgruKCzELS4WmoS4xYLzobVmTwj/a33kzMrjEIsMf+BkqHkw0k+pyG7+qxqwNongUu1WFakWeTeOpCHbly4z67s3Iqz3+OCw1winhHHQBjGiqMVKu/pbSmY1eIUI5G+D9ZE+xestARi4bR97m281V4DbyonXxcYqxwElNi/NLsxRMLY0HKz+aXPDc4s0Wyq/5oVytfupKwDtada7iQfvdiKbpVErPAQ+Fu9v64A2AjJuNN+dmZgkVYhQz1eg8wgLHpXipGeMahF364rFQ3ZflwYQoOWa7DeBAuEGPJ18ZtxL1m8PhyEbvUfh+CU2pLukmpz09VgHE5pXskNmMRIuqp0SG1jBF4VupAGPWSMyyGCg+i18oNcFSr2+jSnmmrCjmEXfEr6dKtqVLgXW357QaWtZlnmNzT4m3cstEqqX0KgPUepM82g8y
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f5435c5-4ca3-458b-502c-08d77d41cd7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2019 07:23:06.8506 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V6z5o2J+9s01B3OpaXg8TA3ZE/8CoPEEJcvYlYG/6V9VYgp3YyhMnSYTovw7w3WgWF7F0txpCJ8oFpTKEwFmVS7Reu4knrbxw0B+rDG/Sgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3928
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191209_232310_285748_F318C4F9 
X-CRM114-Status: UNSURE (   9.57  )
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
Cc: "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 12/09/2019 05:22 AM, Engel, Amit wrote:
> Hi,
>
> Did you receive my latest patch fix for the below bug?
>
> Thanks
> Amit

There 3 patches on the mailing list.

I've just posted a patch with some fixes on the top of your patch.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
