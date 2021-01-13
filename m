Return-Path: <SRS0=mLmp=GQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B903DC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 05:13:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B9A5221ED
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 05:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B9A5221ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=ngn+LqrMyxvzpdSSzE7J7OT8khLq7P7ZFdJ9oP5RIOE=; b=F8opekatLqzo/cxpbA2QDVGnm
	E7n7A2mur+USu6R3bONrncMnIdZjM1W4/4/X/LyBxgQgOnxjgprF0AOocPgdpElUyvf0Jb+AnLrte
	df6H9qM7T1+jnrEamsuROzX+n6JcN8eykf2f2EyBnGNPRGvLSiegwNkwdTkAZLyLhe083nl5EKPsR
	lgvxhNtnO73OJ2lWasqR1T92qIDNLsYO59s2hjFAWbovNolV5KxJrUdtUCMle9k4/CsslN4L+CahP
	v1JfLUMOBq4U+cvbZJMkjpb2Rz2mc7hwLp2b2n5fsqC/d80WMSendZR98CM17BZDalbVa0a8YWcWs
	6vvekP1Cg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzYTU-0002u0-Jf; Wed, 13 Jan 2021 05:13:40 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzYTQ-0002tE-Ec
 for linux-nvme@lists.infradead.org; Wed, 13 Jan 2021 05:13:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1610514816; x=1642050816;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=s1t14qaaW/aomAth9STiOb56hvs/gsI4GYKNBwMzzmw=;
 b=GjwO1oB+Owfz1GAMjVUjlDylGJjThpihX8PDmb5v9gn4u7Am78um9U5c
 uPEPa5c/QtTLiF28jQWumX6FhHnOf3x5xrennV5VtdqPt+xRijrq7muQO
 uRWGimAgVa1PVGKFaPKO0mTxiLZbU1NpWxB6v8AhJQP850pU5tvU8opoJ
 vBHjjq9ykigYU8tEBYUX++cIyGr2ExYAS5gw1RkzyOjNKSBIAv1z7UWMf
 UK0WSrmVTjFx+PC9mtUwd/uUo0N1EaCPu0JvcmOOwi2DvW3bGmd9sfu1Y
 mKISFp+G7e1pkt0eBlepfPYJS0Xbj/ulVXnhgVfETzLGCbmvm0cGVwwfV g==;
IronPort-SDR: ahAmkhPZEqV5/h/4QQE7bWG3U6zXUXa8ECI35ZZNMHJzyqlopHT7CqCaAX4CeMATsmQ0SoPxoL
 stBPfi79TotNFGMdIZ5a+rQhp+RhL1r6iYn6vQX/Eq5Cnc62lvw14PDGpD2UfmSz+5Weku8qWj
 rVF5oNmiYo8TMZzAybuNIIktwCh1cz51ESWtjEtwJA+OU15cpeRfD2XUEiwt7IbniqOaUeC2Y2
 zbXvjmvScuL/M70N5rkg9dwNYVx8mCgvrXNTuhGSo76GeAhdPtjIANfTmcWLviRQiPClhGJna7
 Tbs=
X-IronPort-AV: E=Sophos;i="5.79,343,1602518400"; d="scan'208";a="158480291"
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
 by ob1.hgst.iphmx.com with ESMTP; 13 Jan 2021 13:13:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsjyvoCcsJGO6/4xg64TmRyksr1YVpnHT7fkPL2FKahFcwr53wPbAFcINiZcTBpWAxuedej+L13ugJ2OM250wwuJkbJPCPHtXk7x8wK2p2yT6zhhyZm+hbale+SVIw/Dqdacb3VS5o+30zrHIya+d0QzEbGPi8YgWh4sVOFcN9SPM9pDev9VAuNkYlxW+Y7bWopjdhKKCOL2alxw3z8TH8JqCPTR4zqr+x27rAjVifeolQNbabi7rDhGP/gNsYe+3hgUnVJQ0LPGvPa7uk6CgOdxSUUJLij7QyYmNY2EX33+KrY3uXpHEqIv3Gh8KZKDZcw5q3+1t7giNBBCGnQWKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1t14qaaW/aomAth9STiOb56hvs/gsI4GYKNBwMzzmw=;
 b=nfpbMkRmfmh1ZnuAoITrrT6c1g6rczcrBwfjKQGsB/CY+KUYH5ab1QzZYDcKu+MJS4/8VZQVH5CTn9saQihjQ0MQieQ6A5gym8yDIDInqFsC1AggYIQXDA1+V9CqlJ8RnHfW2JAGHma2vl4VZ09spSqzDm5gVHwFrjosdSsFg6P55EJRggTNOKpJtWjnaBjVTW9nCqoqz0xT5za3RCq9S0MM+92cFk8sOThcWn9jqN7RAAZmc2366njHi0frwdTnsA5tGJ2QtGr9kwjs7fym8BcDgq9C/43CcW30g8MIdy4gkgHiciU9eOrfDmHSFpzKq3Vy18pnx854xfNzbahgyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1t14qaaW/aomAth9STiOb56hvs/gsI4GYKNBwMzzmw=;
 b=zLddGaG0akOJVFqAaw+udS6NIV6s1p4XIwWBYyXYfAzhzXWU5jCxStK/Ys59Q/vg3Gl2UqkkOgx7XAj41MjChvhcQJVuNAonhy96fy1doBf2EByZX4CORenmtOOUwrhb2D6zJxl+4G+EoAiIRBn40FZKSe2tOarRQCFTWLer0SM=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (52.135.233.89) by
 BYAPR04MB3959.namprd04.prod.outlook.com (52.135.217.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.6; Wed, 13 Jan 2021 05:13:34 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a%6]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 05:13:34 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V9 9/9] nvmet: call nvmet_bio_done() for zone append
Thread-Topic: [PATCH V9 9/9] nvmet: call nvmet_bio_done() for zone append
Thread-Index: AQHW6JtQ0H5m8Jk8+0SzCyXjMBnc/A==
Date: Wed, 13 Jan 2021 05:13:34 +0000
Message-ID: <BYAPR04MB4965963BCC2BC929CC4B730F86A90@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
 <20210112042623.6316-10-chaitanya.kulkarni@wdc.com>
 <20210112073606.GD24288@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6868ee05-a0e0-442f-329b-08d8b781f9cf
x-ms-traffictypediagnostic: BYAPR04MB3959:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB39594889613CC59FDC35DB5386A90@BYAPR04MB3959.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pn4GdEw3u1WlKMzQRMaMVlCIYFY/Qlyibkaj9rYE7Q5553LM5FKfAhOxwFT0cPLPE1lgrB/yoveBeOlgzXjGyONVgNckH46ZgXkaW3fhQq718EerHymiKIl2JfpbflY0jCkXSwDg4Nb97z0RhnoXQsOtCiOvzzXJ7NwOTQIwiEtk2XVloGp+eFUfVisFuEmezd4Ki1qPzkFAVxRblBaOQZKk2v8fUjKTuUBJqs6fLvWgxqqTLbzV6EiSfQ1K0cbfjd6eHfS9dIHMNOi3YK+L/92TpVULPnKP9C7RwupY4RVG2aPUmwcgZiIuzszkCcaFc8Wg759Vfe75Y3qFdHmrcu/+1up9n0bFjE5Ol3kgzO4fnlQdSbIobV+Cu5vDnH0aq62jqyh+9c5GnGji6sVudg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(366004)(39860400002)(376002)(478600001)(71200400001)(7696005)(53546011)(54906003)(86362001)(316002)(4744005)(33656002)(8936002)(8676002)(2906002)(6506007)(26005)(186003)(9686003)(6916009)(66946007)(66476007)(52536014)(5660300002)(64756008)(4326008)(66556008)(55016002)(66446008)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?G1EgKmhxx80YiDQhqgSY12JQrkKDrEWtmOORPrdB4sDCOa9D0GaAFhFhgDRK?=
 =?us-ascii?Q?b5ldsUuce9RaOEHfspEmFoT9CgpguS36KFNHRRSAmU4aOiKa5/ICAmoPk8sH?=
 =?us-ascii?Q?TxiACfH4sCQTAxCtuhOtx6AeGgxvqdWLUBCK19uR0X1Sj7GCCd61AvTruCSw?=
 =?us-ascii?Q?3eFoS20ByczLYdciU9w6qCh/kPAKPfVUgsEx8mkk7C82XxJ25AGaqV8Yi1oK?=
 =?us-ascii?Q?0c3YYCpZBHX2AK1yN/juVYrgrk8mnC6WrmbFxJWiFiKzfpwsZw+shU+uuuqx?=
 =?us-ascii?Q?b5ilxELCwaacDgRwt8Jx+B4sDeYpqzZBj/ueWP3bMY7ifLeVk/c2AdHff3fE?=
 =?us-ascii?Q?XkkEy5MxmedBh7Ozm9EBEfX1xR+5p2UrZyyOnGJiF2IJ0EKNt1w4frj3A6h6?=
 =?us-ascii?Q?l563kzE/LteuS4Rjfh82A8i2vNRrkIYnuasEp+VQph136MnCdBDMFZ6Mb44F?=
 =?us-ascii?Q?ELaAgamXumdWTwnzs/zeuxPLBWW8bsssOSo3etn9YvkbU6zQhIlhdEtZqrpR?=
 =?us-ascii?Q?Dyx767mdzHtgLOiA46VPnPB+u+mecnzPswZyt9mQu7/BlWYlQa1X5SFGyo51?=
 =?us-ascii?Q?wwZVkBA5BgQWQfth7fxAUitWO4t13JxGOB2TheefcI94Q9XE5uGr9VI0mki4?=
 =?us-ascii?Q?rxte7eGkjrCrxKMMx8Pm9KbCCmne20eAxm955N6agItDwpZELZgaKGYdNZxp?=
 =?us-ascii?Q?Qwp1Gcs18wirHE0sGhA55bzObVLewtkKsOOT5m9Y4w1IpQRnws/jkhPzfhU6?=
 =?us-ascii?Q?+BKwGF/w8QcEy7anXkXsVT/DkixiJpIh4G4V1uCLQqI1kRWCnYFsKE5UCX9E?=
 =?us-ascii?Q?AFH+XBiBUM5p69WbT194Jpbj7R0u4SM9E9Qeyjaicz6Yipkk1qpU3VoSl/kM?=
 =?us-ascii?Q?EK4v1GbUMzQ/5gpJ5F4Tg7qnLdjBZeEZDNWTZq3O9KsaxQ0BnQCqZtl3NCvY?=
 =?us-ascii?Q?vj9Q91qPbmG0B9sOuIeI7Irj2k/O7SwgF4jpJk7wh3UWZyxuMy5UYkQJEjDb?=
 =?us-ascii?Q?85hL?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6868ee05-a0e0-442f-329b-08d8b781f9cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2021 05:13:34.1622 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kf5XVYDrhFV2XpXeJ62y0uhabM9M6+A3FZeog/juNhFptQ1YP65u0CElPY+RviyAfFnE59GM6tVRBAD8DvxFGsRZSjLmZ2R18BFxXpsEsq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3959
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_001336_802526_2360E2DE 
X-CRM114-Status: GOOD (  13.42  )
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
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/11/21 23:36, Christoph Hellwig wrote:
> I don't see much of a need to share such trivial functionality over
> different codebases.
>
Since there is a function which does exactly same thing thwn why we should
open code ? I didn't find a good reason to open code, in fact it made it
easier
to search for nvmet_bio_done() which is logical point.

We can drop this but please consider previous patches as it has a lot of
repetitive code. (will remove the weirdness and add name fixes).


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
