Return-Path: <SRS0=GxYq=6W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20DDC38A2A
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2020 09:58:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BFBE208CA
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2020 09:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TGyCUHuA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="d8vGwJdv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BFBE208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yR2yXjioZf5i1d0SIX0dQAhwT0p8sUi9H+pH9qf9YQ8=; b=TGyCUHuArRJNkD
	8iUXtXJ9LHV/ilrv8E8BX/Q6zhz3xEI7gcpdRSP6NDZPLRWXQFbCq+TfefOWe00mzBmWN91XZltQ/
	q745je3gYRGSZLIItx+CQOm45hvtOIrcD7WfLtccN+MOhpnPuGvE3mqwr42SnhkeHmpJlEV6OAVY7
	a4QIjUZNYnW2xjp3jz715+nI5sh6Fsztup2gktuXT0pn/Jz+ZhVIJ1BFo0UHKNqaKxblgSaOEgzdl
	ZRgy6RYwlqSLrSRYoFDIcKJcfMTAIF07liGeYKtYZ0CzxYcbCqmnuxBG6vCI8MlT5c3Wbr4H83gb2
	vokze30grXvqIjDj0Low==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jWzm3-0006R5-9Z; Fri, 08 May 2020 09:58:31 +0000
Received: from mail-db8eur05on2078.outbound.protection.outlook.com
 ([40.107.20.78] helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWzm0-0006Qa-GN
 for linux-nvme@lists.infradead.org; Fri, 08 May 2020 09:58:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yl10ZrmlX80Pa9sJ6aFc1r4ZS3sE9MoKGCwPc7eh28gr1xFLFbRMNK4ZY54mjvt1p6qrYZaPoOJC0EH8QatX2G89WtDVVOfhCrVBfLzXO2P7NnwHLHNaS/mcWBJdPf4Me9hbERbkIViVrlExMklaPUrV7DUqspWIUIq7ldt+wVgrgFFKE1HppH+JIOquW45N3HZA9XjyqIoZ8ECDxVDk7X2eg1BQ+CDfwA0FJG2gXbmzpYHf+bC8OAr9iuPEQs0ha7MPo/dN+l9I3bhxNhZExx7A0rb51E0oCSsoFTB/dsCUf54ahlykyw027CtHPThxOPvL+drZs4sEwK6BLsg4Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yv2Dcm8DhaBYOnsFz+r57fjg7oDjpkW+M9+uI5Fw1gc=;
 b=i3KmpuIbHk4mqLZEAsKSoJJ30U+ZjZye991RLG57A2re3XCu8rjnvIZen9AbaWkYEXrXsYrwybL3UKHvtBBtFEIdZ/fm6j6Q6EfM7Lfe5xVafBzHkoExYlm/D4Chq/1S6/+UV+eHA1uoQlQjwqD//UfTSNET+ighseiuRzKHx7Uz3YETzjbc7mR/rgS4kgb6vhkyQTQk1ekj+57eVObNIdfkszumi0b2PWLTo5Zr3EL9of/3k23R9InZCgf10sBrdJ0qA1znpbwdZSM1QenC1SQoH63YwXOlSNOZHPvzB/TsTOMBuqh2bZ35EtghZNL8+deEP9GgQG88yRoqC694eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yv2Dcm8DhaBYOnsFz+r57fjg7oDjpkW+M9+uI5Fw1gc=;
 b=d8vGwJdvqhZTcU5BIaof1DOZoVi/kIqmPSSRSvFxMWCON3xCGmXXg0fqrFswLRCHck9r6Jp1BL1V7AvZLCPj/NxyjCFnPj/dipldWovqpm9nAtQ77Qc4EJk2NOqj/4Zmc6O3+Qrox1MFcNtrILc4dsvqK4Zvo3qbLmcEwyTSBmg=
Received: from AM0PR05MB5793.eurprd05.prod.outlook.com (2603:10a6:208:116::22)
 by AM0PR05MB6115.eurprd05.prod.outlook.com (2603:10a6:208:131::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.21; Fri, 8 May
 2020 09:58:23 +0000
Received: from AM0PR05MB5793.eurprd05.prod.outlook.com
 ([fe80::88e4:8844:bbdb:e46]) by AM0PR05MB5793.eurprd05.prod.outlook.com
 ([fe80::88e4:8844:bbdb:e46%5]) with mapi id 15.20.2958.035; Fri, 8 May 2020
 09:58:23 +0000
From: Yoray Zack <yorayz@mellanox.com>
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Subject: RE: [PATCH 1/3] nvme-fabrics: Add support for padding alignment (pda)
 option on tcp
Thread-Topic: [PATCH 1/3] nvme-fabrics: Add support for padding alignment
 (pda) option on tcp
Thread-Index: AQHWJHgt3rtVfETQ/EyObwhEvoqBcqidxWYAgAAvtWA=
Date: Fri, 8 May 2020 09:58:23 +0000
Message-ID: <AM0PR05MB57935C225C02987C2E1C85E8A3A20@AM0PR05MB5793.eurprd05.prod.outlook.com>
References: <1588860124-40089-1-git-send-email-yorayz@mellanox.com>
 <1588860124-40089-2-git-send-email-yorayz@mellanox.com>
 <fa6f363a-17fd-b8a2-e772-da264a2b4538@grimberg.me>
In-Reply-To: <fa6f363a-17fd-b8a2-e772-da264a2b4538@grimberg.me>
Accept-Language: en-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=mellanox.com;
x-originating-ip: [89.138.254.136]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6731a372-0524-42ba-11dc-08d7f3365876
x-ms-traffictypediagnostic: AM0PR05MB6115:|AM0PR05MB6115:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR05MB61152447E73CB8131EBC0DE5A3A20@AM0PR05MB6115.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 039735BC4E
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xI2GlPIR6gQ14sBHBc3iVOcHg34KoxnqAmywpfdf9trUyG3BJRKCphgY7mEDZWl67xsYFRK7zb8epHJPdeREXfDWCKMIiHCLc0nGCYoH6mpkhHKy1PtxwzyvAiC/fH08OPk9AteDlBW8wTncaVNg8DButn9mC7Pysctzkw/OnkxrUicICO9BWjyBhc5L0JPyoaDo0tv5BD/s9HX02E9KzK7zW02/48i48RRwglZGp2deAZyCrYKL0pD1oFYIlEjXxvEuqn7N50SHihPTzyhTbvsBvSujlO5K3Sr9UvbSRx0N0dBrap0/Cr104kpstD1VkDUXJmIbJM9LQRxDxpKTKT+k5u9x2YMQy9VNB/6g/QaRb1GMBOp7IQcBM3FuKYl9xPktqRXYcWMKX2rPCCJs52GHiYp+4gXH60aRHglUggzs5YGCZEEsWezgRc7AfvHBeEjRd+je6LI8aauZGCBBGkN+58tCGtqwDUreKhT/PD9YTTixvFxfGIepn1Lj+FhmRiaHaZdsSHiBGe4r30I2Lw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR05MB5793.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(33430700001)(52536014)(316002)(76116006)(71200400001)(33656002)(86362001)(8936002)(66556008)(8676002)(64756008)(66946007)(66476007)(66446008)(4326008)(2906002)(6506007)(53546011)(110136005)(186003)(33440700001)(7696005)(54906003)(26005)(55016002)(9686003)(83310400001)(83320400001)(83280400001)(83290400001)(83300400001)(478600001)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: T9kPHu0VT+RuoR8bjSS8jZpv+kQJNPoHpsDqGbml0QA1mLtUq4EWpeZKXa0G8kHk1rwvz7U1LQLrh+PosJVDGxrRA2kJ6wRi2CtkHDMmbRHltF8WKkbOd0ervsqC82cyvApQEBy5CKP1Dd1S0MTeng3/OZDxEWVdAn4XYqJXLiqw1yzzDRUXxDRDbKjBkWJcrfyL9UKtNi95mBdgxGDGql5bgnVPQis6eoRgkf9Jmpjuh9MSzBIV6yLfuCPPK6joA75lnUdKW6x37k29xr+PgmliKL9KI4UBQFcjCpce27MmB2GXYLFVLhzImtyywkPGrgcKq+6YWdyt6T9JUaWlKbgSTjS8B+x/QUNPKz1RDuXqMxPDQ2RyhKMbs2/u22b6sfLdn2LaFXaTosCYrYITc1lo63OJZRO3qSWWpteAKxzgEKm93qQXr/q+bNur1ZVkgGiFk7J6f5eJxn2OOjEMG+IvRTvn/sINdEYOGrSod5JTRPTwfkZclLKbJ6JtJvFz
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6731a372-0524-42ba-11dc-08d7f3365876
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2020 09:58:23.3481 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZZKFIkspmaxc+iyyXpUnDGmbZZrrLqnoEI5MbOwdRvyZsu/GMNMBK5sCtQcDrXSuun9d+N6zvf8aOmsod+kPkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6115
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200508_025828_547121_23F3778F 
X-CRM114-Status: GOOD (  15.35  )
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
Cc: Boris Pismenny <borisp@mellanox.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



> -----Original Message-----
> From: Sagi Grimberg <sagi@grimberg.me>
> Sent: Friday, May 8, 2020 10:06 AM
> To: Yoray Zack <yorayz@mellanox.com>; Keith Busch <kbusch@kernel.org>;
> Christoph Hellwig <hch@lst.de>
> Cc: Boris Pismenny <borisp@mellanox.com>; linux-nvme@lists.infradead.org
> Subject: Re: [PATCH 1/3] nvme-fabrics: Add support for padding alignment
> (pda) option on tcp
> 
> 
> > Consume the pdu alignment from the nvme connect command according
> to
> > user-space directives.
> >
> > Signed-off-by: Yoray Zack <yorayz@mellanox.com>
> > ---
> >   drivers/nvme/host/fabrics.c | 14 ++++++++++++++
> >   drivers/nvme/host/fabrics.h |  4 ++++
> >   2 files changed, 18 insertions(+)
> >
> > diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> > index 2a6c819..4468b57 100644
> > --- a/drivers/nvme/host/fabrics.c
> > +++ b/drivers/nvme/host/fabrics.c
> > @@ -612,6 +612,7 @@ bool __nvmf_check_ready(struct nvme_ctrl *ctrl,
> struct request *rq,
> >   	{ NVMF_OPT_NR_WRITE_QUEUES,	"nr_write_queues=%d"
> 	},
> >   	{ NVMF_OPT_NR_POLL_QUEUES,	"nr_poll_queues=%d"	},
> >   	{ NVMF_OPT_TOS,			"tos=%d"		},
> > +	{ NVMF_OPT_PDA,                 "pda_size=%d"           },
> 
> This is very specific to nvme-tcp...
> 
> We are gradually making the fabrics arguments span transport specific stuff.
> I'm wandering if we should have a cleaner approach to this...

Yes, this is specific to nvme-tcp

 But we added it there because there are already other parameters there that are nvme-tcp specific (such as data/header digest).
 We agree that there is place for improvement, but this is a separate infrastructure work


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
