Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953DDC4727C
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 21:20:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B31B206CA
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 21:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1pqJSN7T";
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="pCQRv1RR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="wjZKw+c3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B31B206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=DxfUcDk9FzSyTCPtS7HBMf9syHM2oIyQkGXXRnBuNxc=; b=1pqJSN7TsVW1VqvMtyvXLmhXj
	Vz4BjYemPu/x8T373grUF01NANH1GvHDz7fWWScupIqMiiwJb/spGeSM06Ss6Y5qUXO5bdn1thND3
	6dHwmdwh9D4/Q5U4vUQo7pbrEmeI0oMsqqL1cDsIfsz6YTQ4WN5Umz/1h4pPXi3t35kIV/Un5ljD2
	V0anAKgDhex+vOCKeUI0yUfRoxoBtce3G12Ry/MNeJX88XQ7ednrIJnk2PLCw01Y8ucMsEGwLqJmt
	cl1l4bKQx+CXM/7WeS1+1XCDEKuuEG6k9wQzgWT36bQEx/85JrV88bbGOJ9B0H83p8nhW1gXaeRSO
	cXDim7Ipg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNN3J-0002S2-6V; Tue, 29 Sep 2020 21:20:49 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNN3G-0002R7-Jj
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 21:20:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601415543; x=1632951543;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=MAuykPUiAkUQj0XTOJtUjqap1WyJ57h3pmGMI/nQVCg=;
 b=pCQRv1RRaLnMaApmqavTo8ZmBSzQGQB0Ek6C2OcUP+s2Q5Rz324+UuKi
 UOac0QleHvDrbYVAzTtpcxiRR8wfs0VjfkThr67JSoc4jDV7hS1/taG7p
 hzbHFDPgLbyYm1kwkqgk0Z0Zkc+Cg+HvEE6GpMy1Wv+k4zXMVIvK01M2D
 +nRas+55TEwVSGbEcTJSoohEbNheTsUqcX/DOxXhxdAZtlIqFCPd135RS
 sAtZBYS67CF0uIkLv0zrpWM5jEBu5Qc5GqkSt7e4OTgFNBtzh8koe/Vq+
 zPWjovXfdj88MdtOvgaRhIT4zujA7gQQ1OOO+BHZEeAl+ey3Vgb0Usl+v A==;
IronPort-SDR: Khhie9Xgzm3b00k/c9mYt8CJFbhT93QN8zXmeFkQcj/yTLpKohlvRgi5j3UEfBDXF8HKxcdUd5
 nmg72of6ufEQEZm0tYztJGeSGxr4fdOqkmBGruLYj3d3d1WiHOuTAnAN9kCNYtmG3MVMtu3V68
 1eZ+WR4BGuAitCOx5TKezzA7HSMlHolbZevO1cQpYjAjDTy2RzdEcaXlAplM8gngymNLoqPpe3
 tcUzGuOGnXd+sCmfIoS/Ml+PPR3t0tWxQqoiKGHeYp2DI6o4qLXzlIBUtEerjnLllfg8dF92LY
 DUk=
X-IronPort-AV: E=Sophos;i="5.77,319,1596470400"; d="scan'208";a="251999973"
Received: from mail-sn1nam04lp2055.outbound.protection.outlook.com (HELO
 NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.55])
 by ob1.hgst.iphmx.com with ESMTP; 30 Sep 2020 05:39:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQ7JFGdujUvGNd8fFpY2oOv3CFMfAw9SBACU2hCi6GWjO5rAS0eo/Ud7YwDpPfwtITWwZ9ovHLaj/vy7mZB31PcF3Sg1V8ppoQufPrCpVYeZLdxG+5oMM64JTmVtGSdAEV/rCKLprdcg7UU+8I7hJUVvGs6oiVtRr/8ez5Y4Weewd9LH1IAw4g/ZV8M0vo6SIVFt1ntnms1GfazYWeRKUM0l8NEcBcEAZldnPrINFpQjcjyGLgcBniCtdIh2eZnkOlhjNk8OJNh4tfDfZIL/0u0sC325/3JJcUy91eJ5zlPTWNpMHXb1td5ckitNTTOdzSU8rKzDunCdoVSyfOlWjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAuykPUiAkUQj0XTOJtUjqap1WyJ57h3pmGMI/nQVCg=;
 b=Op/TE37fFEAjrMUthKdMVwF1sMBQ7KrdS+QfDIQkJu6H5w8gV4pzXI/jEXmRoSrfHH7E1PhIgv0+HiW6vf8GAdPn4vCg91rgUE4KUlP7M7hEPnWZJ6yt6vgFgauwapjYmkvjMhiBcOytsFUD2XpphqDl8Gmqd/0nGAR6BNhhi9qw7ZenUaFvfn1tSUTeJucx6zmGVTf2ohehnUSSgQX+BJ5yIUYg2G1vmZFoj5KZDgJxSpZOFKeEflvbEqGArOI4zFHCMUPqRp4DqrKADtX3sAn6zV7GGFo6Phi0TJsBbDutcTHw/OfhwvlPCkuoaSD3Vo7rH4yV6DIhK9F7xXYviQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAuykPUiAkUQj0XTOJtUjqap1WyJ57h3pmGMI/nQVCg=;
 b=wjZKw+c3iLi7z0TbhyHAnR8I91eWZoqOidzTC/dvJ+6TvLaJX/zQpVlwqhYUR2ERrozz5Iy8TUEWMsJFWTSbHbpAIP8J91et0NSEIBngU/9IXM+cIOJ9H1S/8RiutnwxIQuaoSftAS/UDpymAJpjym/yjfl0V8SfM1FCQr8WWpc=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6102.namprd04.prod.outlook.com (2603:10b6:a03:e8::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Tue, 29 Sep
 2020 21:20:44 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::e1cb:3a58:d588:d7eb]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::e1cb:3a58:d588:d7eb%7]) with mapi id 15.20.3412.028; Tue, 29 Sep 2020
 21:20:44 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 06/20] nvme: rename __nvme_revalidate_disk
Thread-Topic: [PATCH 06/20] nvme: rename __nvme_revalidate_disk
Thread-Index: AQHWlZTU3yUJTWolVUWOAoX0QFWozg==
Date: Tue, 29 Sep 2020 21:20:43 +0000
Message-ID: <BYAPR04MB496598D98960987600755D0F86320@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-7-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dd32eaa6-4355-4106-0f00-08d864bd8680
x-ms-traffictypediagnostic: BYAPR04MB6102:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB61020F77E679FB22F15F554086320@BYAPR04MB6102.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:935;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ch9TKKknOvyOCl2qId0qLw0B0r4XBR4S0aXt5B0qf59WgyIMCubeckMyOPO6SdsNUks9rI2+7F54YrqK41UIQW7/vDAqwr+oOH3lOFEJurVh58/Pp7QAnM2/D8goUYc4lJgAxQ97MD8yrK9ncehql8zvIy97TFIaWH6uYT2jRiUa0XR5S+GlnKCjwooXpvdHABSw2E+3AmP+rlNfTPiJQBUcO9b773sUNdfozMNbrL1t5xnYO9DhnHebn6caqbjDDHuzXRGONaTBMb2ElwnGo8QjbEQSmIsdrl8aHpn77DJTopkTiP52ufOcMTsfC1NwZ+rYUHx9pD4rdgSTDQhGGkzWm9D0MSUIo26oxrncHVafubqjcP/h55gfbsiF8lE+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(53546011)(6506007)(186003)(26005)(9686003)(558084003)(33656002)(66946007)(5660300002)(76116006)(2906002)(83380400001)(71200400001)(4326008)(110136005)(478600001)(7696005)(54906003)(316002)(8676002)(55016002)(66556008)(52536014)(8936002)(86362001)(64756008)(66476007)(66446008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: Emj/YESVm1CAgyPaFlMNsoQV4iulpzlbFlMHDo2GS8zC7ugqjs7xj/PeBfn+e57PfVskuNrQfKuJ2BZMn2nFvhYh7i6N27ujuB1ltdzmd3HmIpUXjbhutUzc2BGNvnwoMWhIhz8cyoAMtwk/u6H+UzN9Wxw9voayLBf9eebB28VuHWEdLcR3p92ePutyAgpiwxjl24IuS1B7sQrd3u440y1MU7RXIDRa36lq6oY6L8S8BcNbY/Ek3lvbyS5mnTHvYRsRwiZk07pv/w3MWni0i7GKi4x65dZaqf8FrWfmSGr2FP04JCpA7UE5kvlCAYaBGu5Vmadk2xfxmvMCpSEyNlYFlctnacKllq7SqIi3ZOFMsHJLHGK3luSvu4hnhE+sJJPoKZBNrJQ1qd64hvYkYlWfq/TVMzrdNUU8l4aWNRYWmal1J1lfoDtwJUU0NB2H5OLFP6U/WnAZcsgTDcQbMTI54MjA45JyuKgC9BOTZl/3okY3vdY0aTUq6yX/XORzvqGlc2siM9anz3HZpZcFeOT1gBffxlxXmyaqM1WGOBSjSOvpnAvRtiTbFDU6xgrCI9uRG72q3+U5V1JjfEWhn8mcQFW7m11o8x+gMCQOnR3wnYX0s6pfVo6M0H82qKqW7knwOsFhY4ejKVu9B0m9ew==
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd32eaa6-4355-4106-0f00-08d864bd8680
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 21:20:43.8702 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OPvNhl+sln5AcBgy+BzCze9LhOCaSjkV3usM1jJwA2aYrfiP+NcYVXurUSz1bqxbSAnO/4g8jX0mcaqcKRNnFYcNkHp/x6PuEpEtTgwNYfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6102
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_172046_782704_2A8829E5 
X-CRM114-Status: GOOD (  11.22  )
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

On 9/28/20 05:42, Christoph Hellwig wrote:
> Rename __nvme_revalidate_disk to nvme_update_ns_info and pass a
> namespace instead of the gendisk.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
