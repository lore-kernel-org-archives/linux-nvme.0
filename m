Return-Path: <SRS0=O3HW=ZN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8860DC432C0
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Nov 2019 00:04:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5477320855
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Nov 2019 00:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dl3LIm7U";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YX3ssJ0j";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LkcmwUvA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5477320855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=SUtuTH47UsXHMQ6IMQyUZ3FCaaPm4v1g7xv2pvrkbPU=; b=dl3LIm7UZdppDq
	ORg40rPzQXSo8AdxYsOy1ZH8Gct5c2s1DALEM2BS/fDxrJ90aXhJ/pdSlq5XpCHxQQMGQZDtKGaYj
	pV4xjb+kaAbVqitBrm5BtUyBZj0ntMdGpH6MRSIWo7R/eRpUfW00aqPdAAWPts4dninUQhXnZwmwA
	aKvEIZ18ASR4slXjOrpfM3BobOUiuhI2JNiXQbqPZKVIa+5EAvfAiewHOdxm2QqXQ8QUfLmFHzyx7
	CQZFwofkJ6H6esRO+hlq5omgyW/qjluO0Ojstt9hPfIWsHQoxgJ02lEfw1RlWGAtOKk2YNzyjAHLT
	hXN2jUhq7DhHMz1NPaZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iXZxd-0004tm-3q; Thu, 21 Nov 2019 00:04:37 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iXZxa-0004sw-Tc
 for linux-nvme@lists.infradead.org; Thu, 21 Nov 2019 00:04:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1574294674; x=1605830674;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=H23ecOzfd0vsJXsXpku7MJYTjzYsJEjn6kM77JBvS4Y=;
 b=YX3ssJ0jw9nsInb+OGUr7wGjCCNtujuZrFjsQC/8GzqPOcXDOlWTMApG
 Co6nGVfI1xSKegD+GIM2tY59T6T+bcYtv4zIUiD29IDN+mla4rLwt5U2E
 +c6g/qmnZcDpJGD0+PDYSfIVKssHQDTy535TUeSLPPRa6ZyYw3b/mdmHz
 8oLt+2AIWwoT70vtiITEO3Wrrt84Hlev8xIekXqitZWjkYuHFBnpid0Xk
 spotlJ+tDiXYQ+b02RHlREnvVx5EaX22sB8dE5Tw6I2pjHAXxvZL6Kbhe
 zkNTlF9Szwa2xgKMjzU7S1Lf0tlf8W7+K2mpQx9zyhV5JvC+MOUbwNEQz w==;
IronPort-SDR: D+UchJQgObUKVo2wNmgm0nQBGqb1VLr9v1urr6aBwHqwLeBsX3uxAcMiGcWQk228Rgr9piZpcY
 4ueIv0HksU5MP+K9jY2v8zD5W4KW1PUI9b//jHv55LfhR1IwnMWZ6RrDWFHKtm3ayXK0dfqYAI
 eWNTRGZ5Moe1my0crPQ/t3YnVEf7qRRDZqXQqKV8W0Qj6RwsfGKk07xWv3Z+Gl1z8PUsFKS3Qk
 1+H7ecI9g9RRk4aXHRR46Ge9xWvgcX5Nysby06tKVwnTSqMTAvakHF2uap35rSBv23VVH97WQc
 nX8=
X-IronPort-AV: E=Sophos;i="5.69,223,1571673600"; d="scan'208";a="230966173"
Received: from mail-sn1nam01lp2059.outbound.protection.outlook.com (HELO
 NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.59])
 by ob1.hgst.iphmx.com with ESMTP; 21 Nov 2019 08:04:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/nQiUvwwPkUTGWVhVZ5aQocQDnIZUB4DkN0+W7pvnPcYsZiQwT4jEYowqxfkN0mF5eVKw0+m/656L7Lrsx4fZwNJ1Cxd+MryXh9SLuN2sOaqOKvA642MIrec0kBJl5XPMZaHwXG6A1Kzi7Kpt0c1wzNqM52Z057wuWYwEfjRghe965LZ/2aEIi/oheQ/jzfrzbnAwqMzQqAICMkeDTAqJMhJDuBXkZgAPNlTsuJFPNVkd4TlvDKLk41TLAwkPyW6aTW0001jVNM/floh4IlX4DYgDJT2VYQHOM3rExuhRBz071nkq75OYOrc79I9WA4XWdBivFzwDJhbOMiJHlmHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afvlj/19vK/gLQVctX3fPLFvOow8c17YUDVpCwMPaAA=;
 b=jKfGWygwDzt5kdaqim06BgBw+Cgv+nJq6hCFYr2uK/ZulsZBno+UQQlr5KZCnBYWCiTuaAPU+NrXqjNMXkHG7zgTI4bjjPjBjStaI5/26truYHfpccrcLQnjKtSvpkgM569x3uja5g9qkfR/Yyc7Q8TVtU6mUAFhoZb9vRGtErfkPh/EDvaPslOKqC5G95KyNSDu7ImiGIWWbgMusQWSf7t4pkdJLIEM7uU40M532FRtSDVddhq1oq/ATfZgURxN4SMfSYEIiJ2gVeG6VrfCjKSDIPyJZocSbrVG5x6yjB6xqjKKCCAXvRR/bBQUkj+bzhKDcqW4VW29YlaESFBnFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afvlj/19vK/gLQVctX3fPLFvOow8c17YUDVpCwMPaAA=;
 b=LkcmwUvAC5/6fqW6y9CSnopRdvwrm2uVfLnNFB64w8tD9Dfd7DUt6EJ/OFFqBG+hpCE7qG3Nif3B2QjPtcrQRQyoEvK5zJql4hN2U8X6x6Tgqu5iTf7KndZKujDTrUVN+po5jbXhMiduOZAU32+2KkPtG6bz8H/cMWW5BtvN2ug=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB4181.namprd04.prod.outlook.com (20.176.250.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Thu, 21 Nov 2019 00:04:31 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04%6]) with mapi id 15.20.2451.031; Thu, 21 Nov 2019
 00:04:31 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sushil <sushil32@gmail.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: NVM Sets supported on Linux?
Thread-Topic: NVM Sets supported on Linux?
Thread-Index: AQHVn3yMBS35jFJF6U2OLi2KtKuxmw==
Date: Thu, 21 Nov 2019 00:04:31 +0000
Message-ID: <BYAPR04MB5749FE5722187819A0A612C7864E0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <CAOoKxP99U8E=oAY23wA4_JVQNbPXVnkpcL6_-_zcwCnYDCoBaQ@mail.gmail.com>
 <20191120152935.GA9426@redsun51.ssa.fujisawa.hgst.com>
 <CAOoKxP8XWhuF7ROKsTHmUpsaUvwCJS0ZH7xOXJGUKQvqUOrU+Q@mail.gmail.com>
 <20191120182100.GA11886@redsun51.ssa.fujisawa.hgst.com>
 <CAOoKxP_06Qj92GrbnyVQ0tfF0Hp00L-RyMAw6_rr+EYnGZw54g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [2605:e000:3e45:f500:d92e:fb32:3834:a2df]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d3713744-ac13-4abf-fe19-08d76e166255
x-ms-traffictypediagnostic: BYAPR04MB4181:
x-microsoft-antispam-prvs: <BYAPR04MB4181E9BE5A08250C5F0639CD864E0@BYAPR04MB4181.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(4636009)(376002)(366004)(136003)(396003)(39850400004)(346002)(199004)(189003)(55016002)(2906002)(52536014)(14444005)(5660300002)(256004)(102836004)(33656002)(6436002)(7696005)(81166006)(53546011)(478600001)(76176011)(81156014)(6506007)(305945005)(7736002)(74316002)(8936002)(9686003)(6116002)(76116006)(8676002)(71190400001)(486006)(71200400001)(4744005)(14454004)(86362001)(316002)(46003)(66476007)(110136005)(66556008)(476003)(4326008)(229853002)(446003)(66446008)(186003)(66946007)(99286004)(6246003)(64756008)(25786009)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4181;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5uJmD/LW0JfB/W15QEE8kC853canuwS3d5DPfWhS+r9vBKiKpO9vyiUvEtmkAzLrwCEdwwFxXHvKocM1G/wd36QFoTpSQLg4D3N4MXkcHPCI+wwj6sCEdMjrcXSedQ36cPGWaj04/Srv2z7PbXiYWCbq3jca0VX8Bv4DB60YFa49yh52ZmkiwQt60GiQSbYPqMAwdY7X5+6d2fb65z3aQpmT5D9kwQIt8m2i4YAMvT/1T3sk1sbVKzfP+vo6LrejQqIXfzb9PY2+aQ1x5e9/0kA37CV82WWPoxdq4sBe2uhWTaYouVSTvznVYd3zanUeantstQsVzU6UYsxUzdK3W9Um18F8M/OCDXPd5QtPY4FRWpumb3T3YganowhFLapLaIYH2ATZ8lYk0PhOY8sV4fs1LFPK0oZ+ueFmxzGqgs7VRf4aSV0Cu5ZeofHAdCRj
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3713744-ac13-4abf-fe19-08d76e166255
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 00:04:31.2784 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OOGch0MdXb7lzovxw2ZWnty6LlXEJzeSF15lx5kWFkwL9jkBwlHZmsFswbe/oQkJqyfMGeS/rCANh3yojA9KupuXo0e0kE/yByyzsAH/czY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4181
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191120_160435_130734_F7F02C7C 
X-CRM114-Status: UNSURE (   8.04  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/20/19 11:23 AM, Sushil wrote:

> 
> Regarding taking a stab at it: Sure:)  although I will need to come to
> speed with NVMe Linux implementations fast!
> Also, NVMe is such a hot topic and with NVM sets being an enabler for
> new important features such as Endurance, PLM etc., I am sure
>

Yes I did already when TP was being developed and came to know that we
don't need NVMe Sets for target. But if then since situation changed
and if you have a detailed usecase for it, please let me know.

  someone must have already jumped at it:)
> 
> Thanks,
> Sushil.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
