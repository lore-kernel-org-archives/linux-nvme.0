Return-Path: <SRS0=zNed=5Y=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D187C2D0EA
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2020 05:24:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F12F020692
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2020 05:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PpGp6x7i";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="A9h5/eMR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="HjxwzTSs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F12F020692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=ARijoWseMMR7ynPSycpLHAZEsandlXLYQVWBIlJiAAQ=; b=PpGp6x7i7ZzNNq
	Z00OT0zKYUp44ZMZ3Fv4gfUtNGMrhgTIY6FcBjqRpN/JRXifKE4Xt72vDBulZZCtqav9/SQNVcXxR
	ojddWw+jdfgotZDCXhHF2cERnix6Hdf0mP4cka/bsk4sEzkJdep0roPWlsXZoXhI0RYMS2FUBn/D9
	Nn44BdGA9r+kj0Xka/7jttTzHxQnrTzWqYuZjeCXVXXNfgUbqpUZqgdWO5EF0Ea1Aorkew/+Xe6g3
	+EBo6nR47UNnFm3n0sEDOLjnlNwkmpg81Y41DRWdBtg0Iqlj1NRBFRSNYltDsT9Ske1D2zUhkeOZ1
	kqcULm5Iqd3EuywOHJpg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jM3CU-0005Gb-NL; Wed, 08 Apr 2020 05:24:34 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jM3CS-0005Fx-BD
 for linux-nvme@lists.infradead.org; Wed, 08 Apr 2020 05:24:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1586323473; x=1617859473;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=XWeW+8HM8MGRjtJiqrzCwCkgezEwFTLsriAKJAbBWjw=;
 b=A9h5/eMRgNyNbeAP1vgSev4zlbnpqurC36TBtZSUtgC2Ne8jp7mAxVfE
 e/6plEipNsDnDi6cDIb6XPvdwZWszui3+Xqf2MYQbBri8Qafv+7mZ+ecA
 sjGThrs3/NglOUeXeMIQQyRIQ5A5w+WSosL2cIuqxyn21dyWNZE6OU5Vk
 TyOGvmOZW5LPbf8+EcSW97EDbNQ25h66T/kQAaoYLmkgtG4l/ZaPv0R68
 ifA/pJSPGbvLflyIXspja12EVkhi97xjOcE+hj5L0n+Ce9nt/k3VExC+2
 blvC9VW6a6gm3DxiM5rk5RmWQiUAUAbz8eGyBCLTCwrKF7cwcnEmFmtPJ Q==;
IronPort-SDR: DRn+h5+VDh6JAnre+OuBJtMfXFS8A2E4rSkxagSq5iwPZ4AlZWdL4xNWY3JfV1wDzo+snDDPyD
 mPpUI0WOQzT90MhLQINQO9VHyqPjqf5uCTJV1VbfkXugnPhqbeeZUTjoN0NJZYQ1/1hjWXTdZL
 KxcspgWmdNZTkF1/oOUVTCC3p1K56FHm8kM4qv2GPD26AgKMYTWPxAQnXOdh7VWZUlXjNLt4vX
 t+KVlCmKet2AFdTVUrkWID2N7Nn3ZPfHmMd+RfLBpdeQ0DUuQsIHM078uvvDX3mM/Gxxqt6KeO
 b5c=
X-IronPort-AV: E=Sophos;i="5.72,357,1580745600"; d="scan'208";a="135151614"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
 by ob1.hgst.iphmx.com with ESMTP; 08 Apr 2020 13:24:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8GTzX7gnah+w4ZU0rEV/dZkbuuDEuVxuGHzEwKC6RGTx/4/RrfFZHYvzzKiQPeTin9FIaTe6LQWQaoP84f1pQZvzoE3E/vlEoEp3IIXXFuJVAr58mNe4IJaZS+u3jdb10nYcov8htnAg68wd+c2+aahRR8r+niiFFz7N703HrWMVNENh5GVLjtXnMWot9kd2TepYdForhklJGmYpucfcFyeAtjwRUHBOEyGDO/5ej6hzqXfPCPjA0HV07jOSLMBItiWiw2A3n/ImlND2wimeiAZ/s2TAdoSnUmPV4z79iQFmFRveEnjGRb4cN1oZLqFI84rUxTzn48tk0y3yi/FhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWeW+8HM8MGRjtJiqrzCwCkgezEwFTLsriAKJAbBWjw=;
 b=YnSxQTlL420leh3ce+vnRSUulT4IO1n+UWYsDovsBI7osZlYmTenNUt8hlcI2ix7zzCJ8KSoKftZzFZ5SK4JhCThxNFGewa8lNCy85qYthKSgCcQoFUP4ykEq+sQiYnLSEG3n+vt22vs+1UcPKae28fZGXXRihlfJqnkJ83czwL0mQEM01YxyVbZc8yQimdOXCBWqinaMbMjZTclpOOitz4chCh2g17aBkkirmljwd6SEbI828LrfZvWoLH1O2Tc9N57HGIP06lIdFFzg58xDKVv3LHJRqYg5hF69qnF9RBlkRnciVgnpHhhiyym7TqQL+b+lkpmk7N+ia2Mr6t1MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWeW+8HM8MGRjtJiqrzCwCkgezEwFTLsriAKJAbBWjw=;
 b=HjxwzTSsNq54491GPdwXhkTEO9qneKpkt/ywwHPnqcYd2O9PASchopJHlJtDPx5NuSxXw+MG/bTR1gXJWUM7drualllaUPt9goFyiOuFvkKEXHnv5SuHYJN5bzsdh0ZCqvWJXVc81G1FQS56UsdZ//ht5wRWDO08AnmejZLNmyQ=
Received: from SN6PR04MB4973.namprd04.prod.outlook.com (2603:10b6:805:91::30)
 by SN6PR04MB4671.namprd04.prod.outlook.com (2603:10b6:805:ad::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Wed, 8 Apr
 2020 05:24:28 +0000
Received: from SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::b0f4:a811:73dd:6c4e]) by SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::b0f4:a811:73dd:6c4e%5]) with mapi id 15.20.2878.018; Wed, 8 Apr 2020
 05:24:28 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V2 0/2] nvmet: add revalidate support
Thread-Topic: [PATCH V2 0/2] nvmet: add revalidate support
Thread-Index: AQHWDVx/Ivpp2bCu4Eeu7LJYE0doqw==
Date: Wed, 8 Apr 2020 05:24:27 +0000
Message-ID: <SN6PR04MB497396578538E4E839DC489C86C00@SN6PR04MB4973.namprd04.prod.outlook.com>
References: <20200408041633.20632-1-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ef9f2725-ee76-4efd-04b7-08d7db7d1be2
x-ms-traffictypediagnostic: SN6PR04MB4671:
x-microsoft-antispam-prvs: <SN6PR04MB4671554F7D56B928176B8D4986C00@SN6PR04MB4671.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0367A50BB1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR04MB4973.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(6916009)(66946007)(54906003)(64756008)(81156014)(66556008)(76116006)(81166007)(52536014)(66476007)(2906002)(86362001)(33656002)(91956017)(66446008)(53546011)(316002)(71200400001)(5660300002)(26005)(4326008)(7696005)(9686003)(6506007)(8936002)(4744005)(8676002)(55016002)(186003)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HZ8dehasimml+ECdCOFIwptpwXEEivPOk+Wbw6ypSF5hQPcJm4pAUCORJM+npQNCVRKVvdNnslrjNJgqojBzXL7zMk7Zv4UgqyQuShy8/3Hnkf6cAJiXcOJu8862NAsfONszgzwLmsJzxPdvpPNiFIX8LKSQ2iPYSP04L2k2+Q3r+JG95P3+DibQah4Xx5IRTpYZ1Ucbp/xVsUg+HCeXnWZnEYVfTYmppimDT5nUFJv8nmfcsqvhqNtrRhUGbn1IPR7HkfZzjgfv48s4yPGizKFCmt6cK5uWz1jCHQleaH4QgK3PUHluZT9VhXtTg/w+YbAafMtVdZLJLR6OrfXSTbr8n1F4fr3QI8K8Z0ktjDTRBaPprjcgBf3Ejmi1e9/tJmp2Lmmwf4KfHGEm+6kcQg5OhP+P7CIZCpdvJsYP9t5K5nUXnZfgxN+7EfVU6bpP
x-ms-exchange-antispam-messagedata: 349f2SMSB/+l2p+BRy+UzZZ2giU+sUT8yu41Ssca2GxcZWD0dk8cJdE67wau3Hx99cE4sFVCzwWzjwziQ932vF7Dz5sce5syT1LaGrO2I3CSN5pJKeseMdHTyI4VivAnkOcsGzXYqhSWofbonn9yig==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef9f2725-ee76-4efd-04b7-08d7db7d1be2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2020 05:24:28.0057 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gZEbIbCRpxpJErdoaUC+OYq8Zfu1cI6f9/T6VvJjH2xeFI1PasKYJ5ljxQS5yFbx45Hm1T9qvbWJh+OwHnHmqHwJrmQycrM2b38jKdlN07c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4671
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200407_222432_508283_3AD1AE36 
X-CRM114-Status: GOOD (  13.89  )
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
Cc: "ailiop@suse.com" <ailiop@suse.com>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 4/7/20 9:16 PM, Chaitanya Kulkarni wrote:
> Hi,
>
> This patch series adds support for the NVMeOF target bdev-ns and
> file-ns size re-validation.
>
> The first patch adds bdev/file backend revalidation helpers which
> was posted by Anthony Iliopoulos. I've fixed the comments posted on V1
> by keeping the authorship of the patch.
>
> The 2nd patch is needed since the change of size detection on the target
> should generate the AEN to the host. Right now there is no mechanism
> that allows us to add callbacks for the block and file backend so that
> we will get the notification (if anyone knows please let me know, I'll
> be happy rework this series). So this just adds a simple per namespace
> thread which checks for the size change and generates AEN when needed.
>
> I'm open to use different thread model.
>

FYI I've generated this series on Linus's Linux 5.6-rc6 tag as my nvme
git repo

is messed up. If everything looks okay I'll re-base and send V3 on nvme tree

tomorrow.



_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
