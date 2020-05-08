Return-Path: <SRS0=GxYq=6W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9924C38A2A
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2020 09:57:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B805520A8B
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2020 09:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hVfm1Yyp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="lcho5Y95"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B805520A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VblhTUxyWkblygwSJdcYF/zh7IlC8pGpIcMFLFQ7/Bo=; b=hVfm1YypjOmfSL
	OY0snqNVzRNl5KKoUKOiJpYUvUDjPFOfPaGY4w8R9/vxkP19EuyWYL5DN2376KsO2nr4Bad09uU+C
	5wGfvJVW0PgQGYcyPvxOfG+nQgebYn4JvEP7AyS2n6gtHDlGn2dJNsjHTRAoR4Wg3nqb8Msry2Agp
	FdCk/6xEKqbhuyrIuMJBQcSeTPCBc+rTzbGrp0rTPbbVrF0VCG4uHKyX3Z2imruAsw+hzOKG85MjS
	wRNWSv/TBSmVWK5fQHTM6zDw2XWv97BZcH/ouNoT91V2WJ4Ongpfi9YYonSfmynvkWTUzi6eY5iuc
	83nTaNstiLR9bxVR2vuQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jWzkd-00067d-Ad; Fri, 08 May 2020 09:57:03 +0000
Received: from mail-db8eur05on2073.outbound.protection.outlook.com
 ([40.107.20.73] helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWzka-00063y-0r
 for linux-nvme@lists.infradead.org; Fri, 08 May 2020 09:57:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMMDOv447GUvRb1UWqLFeQnIR+ZdBg2oJY3JHnttgOe34fSaEOwS1jmwpnGtsarG9oC8sMdggCGw7/zDZlfwaw1bFaKtPlxbkyRHeKzotPPaYd8jF8uwbJgIINrP8d1pCTWFwDRFVrnMGncBubEK8UM2WhZjdoVStsTIh4ut0tnjlYiIXBBgQl8zksDQ4LnMcdHzlfoyZah+vvWsUF78zEyk1Kjuxll+cdHnFqeA6ZM66WSA1lE6bD1KYL7Wt9KlbdSjaS2GqgDC0Kg8/fkmTaNao1jxyHIKa3WY/doylaLkY5nY3VrbdfYjFpUoo65CZJ54pPBcOVqcYqd7KMkt0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mURhL7YcILLiP5aLSokOINdnHwgX7U1WbmUJaJsG6QM=;
 b=h3kI0H631oqZ2gbOwFCaV/hHMCMihOFCpTW1lwuw5xrKIqict5cL8szn3jsHthexbwRsxVhRdOUTs7kvfA3cDnVddHO09SepUkMiCqyafEh6tXa8BfXahJh3nFAUUTU8QuPKXkWuwVUMsv3W/J8m17ScRr97z81Sdn9hhUxestg9PYQ/nW7Z4nFEdPEuYU7Svqqj8VkFyDksN7pP/aGYgDOElVeRM9GOQse0LDFukDZQazPeIu5CnEy4ukJdLcgVT2jjWPcJAOJq6T4y9xxLCorecRbNtkwHp+Hf8wD204yA6OPCGE1hwwtwRujMoAcJOwjcm66pIG43L5iK45O1lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mURhL7YcILLiP5aLSokOINdnHwgX7U1WbmUJaJsG6QM=;
 b=lcho5Y95bf/PYrM8vCWPL050eSr6JtJL62wLaJ8bCjTsoIi3h0n761vh+BbZGn/WbsdQxR3XMadCDXyCZWZj3x1fmZkm32y6wGHeXT9/R7qIf7NzVyUWKpDdshU1WKCyr9LuJE8wrAglf9dAvtBezI7+GX0EYjqAB6NPwQZTTBg=
Received: from AM0PR05MB5793.eurprd05.prod.outlook.com (2603:10a6:208:116::22)
 by AM0PR05MB6115.eurprd05.prod.outlook.com (2603:10a6:208:131::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.21; Fri, 8 May
 2020 09:56:57 +0000
Received: from AM0PR05MB5793.eurprd05.prod.outlook.com
 ([fe80::88e4:8844:bbdb:e46]) by AM0PR05MB5793.eurprd05.prod.outlook.com
 ([fe80::88e4:8844:bbdb:e46%5]) with mapi id 15.20.2958.035; Fri, 8 May 2020
 09:56:57 +0000
From: Yoray Zack <yorayz@mellanox.com>
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Subject: RE: [PATCH 0/3] Add nvme-tcp hpda support
Thread-Topic: [PATCH 0/3] Add nvme-tcp hpda support
Thread-Index: AQHWJHgx5bc56c+RyUqU1V+p+Y7WUKidxCOAgAAk8OA=
Date: Fri, 8 May 2020 09:56:57 +0000
Message-ID: <AM0PR05MB579359570CF4A3F5207AB093A3A20@AM0PR05MB5793.eurprd05.prod.outlook.com>
References: <1588860124-40089-1-git-send-email-yorayz@mellanox.com>
 <0cffbf28-0e40-e1f1-219d-330c0fe43ffc@grimberg.me>
In-Reply-To: <0cffbf28-0e40-e1f1-219d-330c0fe43ffc@grimberg.me>
Accept-Language: en-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=mellanox.com;
x-originating-ip: [89.138.254.136]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e9f46bf2-5b29-467f-60f8-08d7f336252a
x-ms-traffictypediagnostic: AM0PR05MB6115:|AM0PR05MB6115:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR05MB61153E79CB64DABD88BAFDBBA3A20@AM0PR05MB6115.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 039735BC4E
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kwqXy6NA6O0krESKTj9bT9EA61WmIH3Rc0uonjerhuL1nC0j4s1yjOzCRUQ6TlqqnYV4xDlfMoYJRGzn1jUeVASIEogtP7rckVuIVGTRvUMpyn3hYFKzf3kAywgE3pFbCqpb/NN2ms1qzJ6Lg2QitF4D/4X1HClnFDmOXBhjfyCtPDimJ7pOPZ0RdW58vhrGmXr5OacG4aK2sGZc8Ty+Ielr0Fs9MCzk05DQtl4TQnL1f3W/AbmBY9NG0+fIEjbwAjXr8A4J6Xq7TWmCDBxhbK+yIWvtH6zEkFjajfcDfv/nHnjyC/pQCLs+WMhCL8OV9IFWjZfUTqY1kwNW/NN3Vjoi76Jz12CI8LTJSipTOIHVpgk+mdkiCwcqyUPC0HwdCpTJ5V7To9dkNgv7rcmvioRjY7nuZJ4ze6VEdjHqBsRO67l61aHwcmvv4MvRCKY+E2E3HGD1vk4C3D6aHKo694CvwhkKDDY3cL8Hv3cvOhXjl7UiAinrpLeO3wZWdfZPer0i00rz5mPx+21f2vJ1FQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR05MB5793.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(33430700001)(52536014)(316002)(76116006)(71200400001)(33656002)(86362001)(8936002)(66556008)(8676002)(64756008)(66946007)(66476007)(66446008)(4326008)(2906002)(6506007)(53546011)(110136005)(186003)(33440700001)(7696005)(54906003)(26005)(55016002)(9686003)(83310400001)(83320400001)(83280400001)(83290400001)(83300400001)(4744005)(478600001)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: +CCiXfPXaCbm0rzoTcf94q0GIQyF1bHzW2x8Q26+F/OiDjg7WLF3R3KdPhip8ZxnewziSIXs7l/ayRdbJBOSwXWFXYHR07FWZMsPmNwXnzju5OZJTnod1YLCfz2XVgFRkSISHvRbr8LTyhhIC31HOucZvldRMdtC2Cj1IfZdlB8FbrBMrWjfbCtyuzriMLiMmXWQmZUkVLkPk1JmpnOScHEIavUF3AkTphdaI7PD0M0yRPbsm9LED2qO2KushgQIabWOZz0tvlySI0GF2HxbBbVsyXEKDxXEONid6xzIjkM+yPZY9tN4L4igJS3MLuA9H6/PBkO3d+gattU0mVCQaF0rK+rNq1D6E+E0rHoc4ABb4+xC35jyCIAYLp4P8IWIK20T7RBV4W9aeT4W5EfogFlu9mHt3mOWqW5Gz8SJuojGmUHfukMfEAxmwLJflhXbB8vWTr8REfUxerXmWVNeq287vReslCh/4w7iUlXBDpVgv0i08EJpVnjzq76ogUpS
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f46bf2-5b29-467f-60f8-08d7f336252a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2020 09:56:57.2463 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FYdS2MId35uzBhd0Ls3ZVb4zaan2D16voFC+MBe1T7VHpAtiqO7IOiwadl5Tp/7QUOtbemiAhyzY8Tp+G8dboA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6115
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200508_025700_134340_AF8B4A3C 
X-CRM114-Status: GOOD (  14.03  )
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
> Sent: Friday, May 8, 2020 10:02 AM
> To: Yoray Zack <yorayz@mellanox.com>; Keith Busch <kbusch@kernel.org>;
> Christoph Hellwig <hch@lst.de>
> Cc: Boris Pismenny <borisp@mellanox.com>; linux-nvme@lists.infradead.org
> Subject: Re: [PATCH 0/3] Add nvme-tcp hpda support
> 
> > Given the padding defined by user-space, the host driver will send the
> > requested hpda to the target which will support that on nvme/tcp c2h
> > capsules. The host will parse the capsules according to the padding.
> >
> > The request hpda is 0's based value in units of dwords in the range 0
> > to 31 (e.g., values 0, 1, and 2 correspond to 4 byte, 8 byte, and 12 byte
> alignment)).
> 
> Thanks Yoray for the contribution!
> 
> Can you share a bit on the use case you are adding this for? Curious to learn
> about it.

Hi Sagi,

I am adding these changes because :

A.   This is part of the nvme over tcp spec
B.    We testing future hardware that needs to know how to handle it
_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
