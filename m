Return-Path: <SRS0=W+Vz=CJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B745C433E6
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 02:48:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 633C72076D
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 02:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aQR4f6IS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DQAucLPW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LFY5LeFC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 633C72076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=JW12gYBXMxEduL+k3MSxWXBQFDASpksoKdjrBVzyasE=; b=aQR4f6ISJZph/AA2h/2DNnaF4
	AQUwSFJD22tlFMGy/B9Obml5jNiTKmwjcHOfl3YBYEj3dCBZr48X2lq37wLYI61/aSzZ7/kc08RHW
	tf9wNVtRGbsvj15Xq0r4AE/mr4ahaVVD9ttZVbDBctB72H0SxKXBnyrnKRnT0Vt9gTt6Euk6QAwzj
	HaXXgxgp+FPyQ6WE6uEquEQI/XpbcfRoO9LCfPYb23WjaGewwqg/5ds0dLhWAVQNuUjvVW9i85bMH
	pVnfmVhHwuUMC+gFY5RaJKIqEsPGGr9CcF2pnfKbZ6DyKOjVkR5cLDY99NyHpksNhaDMsVDhB2Av2
	BK7xF7wWw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kCZrT-0006SM-Rr; Mon, 31 Aug 2020 02:47:59 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kCZrP-0006Rz-Qp
 for linux-nvme@lists.infradead.org; Mon, 31 Aug 2020 02:47:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598842082; x=1630378082;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=/11a8Td8yyguMpCjNUHWquVGQ3fbLksnSUo3DmyO0OE=;
 b=DQAucLPW4G/ybwBWlFrZPQpoL4E84U4jdJZKpC1VBDzp/hcklXYw4tBF
 HWUTnkTjXgoN7zE3dSa8MlEBa2gHYdxAYGJfTBJvrlO9C9bchWDkmcPeE
 cqnoWIvSBQSG7A5KYNJzwYR6swjiLEUBu41or4mqGKZcaD3TOHYdJYKWk
 DKK66WweV5mF+XeeGFXtaoK26yZfR6sn6RHSX4q7CqGopu0Sa9GzPnEsv
 DfPXUFtoe6RTA6ICgTNEhbX13FQ1cdLX3fwUm5uuNByry00mejEYChfyE
 HGIOFgvzAgLqd3yMBG/XkrS7oEgyzUTIScCiINYYCqhQXdzqs+HEZ3Jae Q==;
IronPort-SDR: MAwE8fjo+pWVM1/iw/HqL5inOa6AvG40vesk1FpLobyNIKGqtx7NzhF/qc41351YetOduBCZHT
 sNdmg7qs6SZcEySVbPMX2dlgx6MknjkASdN9ZoR0xMiEy6QMbs91cwAvBZQEJJGISoVZsTneEZ
 jh4+EQz61Q6m9GhXap0xS+qEYoXxzsu1iAvMwuSXcFdK9mi8zoGAYYfLD0RujIxfyIbI9TXcH/
 9tf/5CU5DSPMrjEE2gN0UGp+cO27hpc+ysxsaGiwPmE4jf2drMIbqlrCEjQp6URZUNmUj8l7qo
 yRU=
X-IronPort-AV: E=Sophos;i="5.76,374,1592841600"; d="scan'208";a="249441950"
Received: from mail-bn8nam11lp2170.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.170])
 by ob1.hgst.iphmx.com with ESMTP; 31 Aug 2020 10:47:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z79E5kb+uEQa3biCjAV0pKwkA7DMZpyXApDemQltAZQssXFXEu0QQUL9L1g6maI6wMlOdUKyU7yaib97xvvfG79YUJAcRbzVPLoeaLMfyLXIuG9x+4Gza2f6apjsnXytvNK4E+jXUIiV73VdNJugTIfiohAH9ysV6p0JFFrx9D7wnr+eurrQu0hm6ZHPVdhcLJOwAJ3FA5mn+ayXnLJgTnKFiid9Z7GBgG+zEqpQDX3mjiTJLqdmGUI6XxbuSUEHVW+nKXcQ39Tt+copanloGhIZY6lwiqnzd8TwsdpR4I+s8cU50a7Hr1pmf+/96g2uhS1zsKAat95JY3YW+Og8Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/11a8Td8yyguMpCjNUHWquVGQ3fbLksnSUo3DmyO0OE=;
 b=jhzOTQWVpSisrbwpWxcPNlNjpCkE+Y10WULKK/roiVJ+9XzyjiY08xutrfOPH/udC59DLfaxm7+hZXQ9Ya2lyh40KgFgCOXVkBM77SYANcvSI+CzFBvPmf0fb+1LefyKDspnlvoj6s8I3aMDHcyB4b8N2jD6zdTCapj0+JLy3lLrtpzvR8PDn1P8bOXILSRlCWVt0bBH6ozZwrw1Xx0OUsSrowx0PZxsTmb96HOHtWNUD0s3pjQKnbgyWd8l9zJN1EHHld1BnluxuKF5utY1xpX8HRI7dc0EqQJtFdfNqOCt8JTmW+xEq3o4gcq7ydxd1dJ0uFO95dy5xeChkZvEJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/11a8Td8yyguMpCjNUHWquVGQ3fbLksnSUo3DmyO0OE=;
 b=LFY5LeFChIawrzm3LEovztHOr5Jo7YExiq5HbtUoGnb96XQHbYKM2kS4vhoC9MMcqtovwzwjS7brmxngCywJ/pFUzQ3lOldwP8BZL+E8RrX1ucCKLiA0p1EQddLjqxjn4RDclPem+rjHsr7Kf4MdBXVafhkcQKEwkkf4euad3N4=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB7124.namprd04.prod.outlook.com (2603:10b6:a03:22f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Mon, 31 Aug
 2020 02:47:48 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f%5]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 02:47:48 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Logan Gunthorpe <logang@deltatee.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH blktests 01/11] common/fio: Remove state file in common
 helper
Thread-Topic: [PATCH blktests 01/11] common/fio: Remove state file in common
 helper
Thread-Index: AQHWfKsqMIaAh46q+UeHxECpT+6G1g==
Date: Mon, 31 Aug 2020 02:47:47 +0000
Message-ID: <BYAPR04MB4965AD9B75FE039D7A71698786510@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200827194912.6135-1-logang@deltatee.com>
 <20200827194912.6135-2-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 53e5217d-3fba-475f-4d32-08d84d583ee2
x-ms-traffictypediagnostic: BY5PR04MB7124:
x-microsoft-antispam-prvs: <BY5PR04MB7124AE2D9986F7812809A93E86510@BY5PR04MB7124.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eAOJ2yIsUwCYv/GYnlVay+FG7fnZxm9mYO47yjr0rHSqnH/yq+EytfZKW1ntJoSPzAqiYbIrIrhc4VWSPYuxL4qPmqccn+83THAhvyr+GTyw9deSsq1s3KOymuVqVUJblrfSqgR6MNi4aTen0QimuVDZ5NNVlKJCawK3rGuzOsvK9sw+00SW5STZMzKIBzdB+NYf0JLNCR2C0fXlMvS2cpshwqZUHp3ffL4XbdwaILvT1+s2lByCbfEL/oetpiGZUa07mrY2PkqJnXwbqiicmuXMP4rfX69IB0Iq35SrcnS7NgaLdV70/uUsVwgAsgg2IjCWeEzPApRUqrqx6yw7HA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(8936002)(66556008)(64756008)(8676002)(4326008)(316002)(66476007)(66946007)(66446008)(55016002)(76116006)(86362001)(33656002)(478600001)(9686003)(7696005)(2906002)(5660300002)(6506007)(53546011)(52536014)(26005)(186003)(71200400001)(558084003)(54906003)(110136005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: Qx0eMK9/bs/zDADeYwzBP+SYn9Elhya650LgSQTgx0z2nMd43ioGkY/KbeIyvzTC/auoD42iyvZ2LXSkO9i/67lr9ltz0PeYtrRIpRaKMyttlO9zZBgiBZjDMr3u78T4IR1KzOaGbGZo4zrXmObsw8bog+IOzCIhKoxbb+dzw7kKyLNNLjQCu2WD7dYcXMcsbwGS4BQ6i4rlrSjmjasRpbP+Hrc4wTtDEQaveSR9HG9Y+21bMVESGL6oJO3gCPwubSt4l38g03wi5wMk+Rk75lOzxZuEVik7FzZuPXhuAhizbFSvAk2uaDiqGekGhw+VYUPd8okSLkkl7/kOPQgCXhK52kZ+gR8zRnVnQ4tJPlSuD1CwNXgpQXQ920jw1MCcd3NiXJmMyJ48x8RbzcNU/8cTF00jyQQ+C68QfCcUhBSH7MrqWJCqJjV/kbQdQ7lR1XqjwOkhCNYasdi0M8J/bxZCRhJy0EZRn8orueyhBCiJWU9pR/vc7eYaic4sTALcAtkIsqZfe7rd1Z/xzkibsuO8pmqe7F4HhDUC2qQ5To5qZyl0fWf1Fx24hEg7REwrR84CeX3kJLoLNwDBJg7FRTuj8MBwH4p9o/t7enMdQ97tt7z1W12vl4DiCYJu9WZbxEcidsePsCcVAraw1hk6DA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e5217d-3fba-475f-4d32-08d84d583ee2
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2020 02:47:47.9254 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +WyVNdAzATQOD+fYwF3DX/tosjzBEwaDwbDwJ4YBBBvoxI5zt7lpPuWIO1q7ou6fEKKnRYw39mYIdCCavM2Hj+50s84PgSnQcDRMGT5eO1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7124
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200830_224756_047819_077F7758 
X-CRM114-Status: GOOD (  10.81  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Stephen Bates <sbates@raithlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/27/20 12:49, Logan Gunthorpe wrote:
> Instead of each individual test removing this file, just do it
> in the common helper.
> 
> Signed-off-by: Logan Gunthorpe<logang@deltatee.com>
Nice cleanup, looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
