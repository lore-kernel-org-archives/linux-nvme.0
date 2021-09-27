Return-Path: <SRS0=w6YM=OR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B3CC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 10:25:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 177636101A
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 10:25:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 177636101A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o7aU54/3VG4w/PK7ZmOaM+SuXvSBN9H+aH3v/IwNiVU=; b=seAcaBy/oR/KjD
	rQigHC6ZjMn/YqtbB2LQMy71FS/9WbPQMBLHyeLLlprKloYbp4ut55ga0/XqFKnpE6lxbeyLYt1TG
	xiBSGLXga/56uZ73MPR/onfarLKFxQZtcvqJPo/70jz5qsrQExlHjg03i1eEdxHtr0fcbHKPNLYGu
	CIm3F+zcmfm/i1Uu4ly0hfiBaHah/3ZbOoXUysrpnATcSSSH1ilmKeH4+84thq8QL8S5+BoRbbXes
	sqzT9XNlvFGelc93UqjdZWD9S1dhPdkfI84Fz6OozfpFDYaPQtLJNp4e6Es5hpJUf6KQu+gMj3jrM
	JKeBnOpV5NVbF5DzXlJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUnoP-002HnD-H0; Mon, 27 Sep 2021 10:24:41 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUnoM-002Hls-0u
 for linux-nvme@lists.infradead.org; Mon, 27 Sep 2021 10:24:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1632738277; x=1664274277;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=zEiBqC4NRtis2+rzcR7R2o+nSPVhXIeT5wBd48j3j/g=;
 b=rT/17f/dOxCoYJVo2h3825F51FWau8VGQPE0x4fQD74nJcWGwA0ykOTE
 SujTA4bd+6fFtNFBc6P1nKrJxslBbNcTMQmwyAsCAYFWSbegkHtIbBjLQ
 3lLXq3uvnYhIUhSNeIJ68T5b1U6LfhTNOE2LYM9qZm+qYna32Bf1raeaL
 juM1PwNIzpU4tx+XjmFFeICa28WZxrQ0sf3nOq1+1bCPzBahxpwZFTsjg
 CRdV3JvEMsOOFXFuSVSwVDxLUUDq+DCTm4SpYkULkwOP2dW7xyN5yBtQf
 nFf3zYAAbgt4TPviVoUuZOSOtNM9UwKS5KF6HURSDQDL45K3NMFdUWcJa w==;
X-IronPort-AV: E=Sophos;i="5.85,326,1624291200"; d="scan'208";a="185847396"
Received: from mail-bn8nam11lp2174.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.174])
 by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2021 18:24:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=euA5eUPbPDJr51XdiVlnpxVCc48UJq3tncPvzWpoZ5mJaTKmYQ7gEqEps0OapcFFPmEJiAEVJIkd+oxwhDz6++/t13f9or1bUct1fAA06Fh5k2nPj4cMBXvWzibtwC7PgboccvhNol0abmZGwy5lfm2gIOYn0sNZJZnhNjsRtsRzU/t7KWgqAt+eDUGBtSMxI+CovoR5bKVQefIgt5OlqSgXEWlqE7blaeBY/QzUr0IRf5uPgF9dUc6b5eJGszcPEodx6Xa6gugidZdEZ681SbyIU3h4aymPzbV37JXcjO2KzIzcAuF87/zGDT57Xy7dxSECnhC7e0u5XnG9EZYiDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=0TfZgB2Fip214IJLLWibJrG7AaDROU++dV/cn2fR0h8=;
 b=eLz5Yg4/P0Mw2ETEjO/ObKCSlB70qVSugianOiBIKNnmuAK4BQz02qnWq3Hd0XXUFiC2V0VP8OxDi25gagi+PeppF1IE4fG4LEfmY/aeZ78Pt30S3YF0Ta5/LInc3ZMlG+ssB+QLDud50t8cm9Ev3KH07CHb1fjx6eaIHVSuDcVZQOuQdxAL9nIPo3iR4XqV+yCDofJL7ZZ4L/f52z2q7pNr4Dql2Aan4d2av0Ny98rPsvlu1Mgp+3zHQgdaWT9CdXKg7PQavcji2KMMykG4hkpqBk4XQ9M69AIPbNYubKzhlcHfOUYUEeV3uVJ4bgW4bGV22T0NHvCngEx0JsjXoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TfZgB2Fip214IJLLWibJrG7AaDROU++dV/cn2fR0h8=;
 b=W7gAR6dK2uzCtUtOI/utzSQL59Go0rrGjLHUq8iUHHUhKs7lfKTE20OplomMg3qbA5nSuLeguATDidN+vkqc5frHFimgw/PKSK0Kl3snaqdOums6BqAjRZJqu7G4mWHEw5UvIfiZU7d4ct2I+qeuBt1I3GmIL/Cp38+5ukRzWeE=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by PH0PR04MB7638.namprd04.prod.outlook.com (2603:10b6:510:52::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Mon, 27 Sep
 2021 10:24:32 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::3d04:c2fb:e69f:27e8]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::3d04:c2fb:e69f:27e8%6]) with mapi id 15.20.4544.022; Mon, 27 Sep 2021
 10:24:32 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Steven Seungcheol Lee <sc108.lee@gmail.com>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme.h: expend lbaf on nvme_id_ns, lbafe on nvme_zns_id_ns
Thread-Topic: [PATCH] nvme.h: expend lbaf on nvme_id_ns, lbafe on
 nvme_zns_id_ns
Thread-Index: AQHXs4nctK0BX5OYvUmwJxhkNF0wlA==
Date: Mon, 27 Sep 2021 10:24:32 +0000
Message-ID: <YVGberwHSmN/HSjR@x1-carbon>
References: <CAGrZSEyrdJaZkHX9fPse0bv3d1x-HU7vvPQeg5JyR++_hOs8bQ@mail.gmail.com>
In-Reply-To: <CAGrZSEyrdJaZkHX9fPse0bv3d1x-HU7vvPQeg5JyR++_hOs8bQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a9452b9-d0ea-405d-ad3d-08d981a0ff2a
x-ms-traffictypediagnostic: PH0PR04MB7638:
x-microsoft-antispam-prvs: <PH0PR04MB76385F7AF8CF60D9C2EE1FDDF2A79@PH0PR04MB7638.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ol/+R59Un9rokMZX5dO7UDtWIOHm28Wh3n8OlBPvFIzLmTxpaYI9paH3WexvrT1K+TfuBVostVvfYtY3o9k0Xsnnm3P+XDAeMaP9TpoFo6k2WL119EKpP/USjZRM5dnJA+kZkPsoT1jarEDysa2HnfJilVjo6I/S/CDqsbGz4sNL1gzgyYdbbj9V0WdZAjq9UlAt0SkbLEkY5fSxWKch+c712F+G+R8JgH9MO/pkgE5VRIzTGRcRtjzJ7hKtdYhZLKU0T/zE16w8N9ybd/zpDdHvYhIFZb3UID4xSfxQnTAcLvOTPreLnbiaQlNc7xpLTZfaYL9Ze3tBpi1AHflRnOmRr4GlCKMLb6pwiSwo/Jg3tvKGMdZdo/j7kAIerXTVAKFBOK+QZCj1vLWR8erVvfJFeSARmisPTMP0jsW981ZcQU4enhSup4OpZndi1LKnNO81fAnp5WaObWlkBn+/YBRfRyGBQ0EJGh9p/8gB0i7zJEiy0P08V5HHKRjfYmYuVRB1tQPNIo4EfZCON/UxBCnPjwsl/q8GNrfsvpjsAe+PeT+o8tK/IbfMIY6NsVdvqizuSna9GtKMobqWzJOf4FRvCW4GFqTvkC6fVh3A7zTirnF7yvLGCpopBAC+CZ8BFztzCPXckdCklu1547JyB+H+tcSbjC5vKpAg2QkQ7tixXsEyZfF+yeqt91ZRUTvjrlmOIxQ2YJWKTGkh5RZjYAZGb193uItevgJLo4tJcIr/yGkyBtHBQ+MROktjvXIGfcUUvOHoK9c/Tq3zwR+EjOzqAT8YWA0R3fjenwkz2k4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR04MB7158.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(7916004)(366004)(2906002)(122000001)(508600001)(6486002)(38070700005)(186003)(66446008)(66556008)(66946007)(64756008)(66476007)(966005)(91956017)(33716001)(76116006)(6916009)(38100700002)(71200400001)(86362001)(54906003)(8936002)(9686003)(6512007)(5660300002)(6506007)(83380400001)(26005)(316002)(8676002)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kORows14bHBOeU9OcHaGXofvUkBqkQp6KToC6n8qh32VOSTq6L1GuqgY5hVs?=
 =?us-ascii?Q?VE8gu8APc9/MtC+FP38zG7apPsR6lyfvSQ54ftuygEfLL7FOWFvEsKDUAOm0?=
 =?us-ascii?Q?xTes1weeXtrNEgsvqGIZHTQ8OLcLME4iQToH7HpGIuO3b64gw2PwNFlxc1Qj?=
 =?us-ascii?Q?U5s0gesxy46OQqQfjEAoCIP9ZiNKDeWdbEwcsVqayYjx1Rcap6zBwzGpbBl4?=
 =?us-ascii?Q?TDBaGOhYpcOboorcZ/n3pMYiuNjEPQ17fHKNbnv+N//tbVmrz6Y/G4dVKc+1?=
 =?us-ascii?Q?zLEbLlccRcCV3vg9+ABEAXh3OfMVOwXeN84/n8g4GUz1zDtOWKyRQdk6CrIA?=
 =?us-ascii?Q?nBlGLzvwr64fanRyH6HgS0SrmaGGQaDxM70JXIoA+7VdWzmP3Y8vJbh3sHjK?=
 =?us-ascii?Q?8v5vkNS/psmyEuFdo8MKeSNprl+w8P8R7zY9mS/ajQDu8d1amMSnJMJc5JRl?=
 =?us-ascii?Q?2PW71mswSBGzK+gd0FJ8q1mUucxbrxKmHcgR45JUy2flA2gTWGNXSJ0WeiNT?=
 =?us-ascii?Q?wZSHGqFHpopd7n7YJ2lNAZBei5Q2QD1bHs8smMQRFbLJVAJZxOI1eSMmFurA?=
 =?us-ascii?Q?Bh7pJDAyZKDhFWv3wLMfSVy8GkADflCO5r1Ok7w8bjzBp5sXqvnCj/R3eCKC?=
 =?us-ascii?Q?lEjhx7oJdv8qTFscchALbzFWOh9xFj1+LLJTK2deNxcOaOmVT6ghOtIUW5o6?=
 =?us-ascii?Q?92tzpvjgpHZx8acUzcsYZ7noiZYU6gEu95NYYtJcupuYs7cIFTLw+gfwI51i?=
 =?us-ascii?Q?rArgFhD70r0nC87nPNpXae6mWJzRjKuOQ9r7il9BirpmryHKkRhRMGJDN5u/?=
 =?us-ascii?Q?DzPKq4+nE60z8nlLH45nOPZ6w2bNlUS1g6WL16Rb+pLRADj+SDolg8xwLZP8?=
 =?us-ascii?Q?cT0vbKkhVHmnGeI8OEyFQKIkU8tVTssHgsAsosrs9I9MC+luX3YmDymxSbYe?=
 =?us-ascii?Q?m25Czg++0PYJK4oGX1aOW/YufI2r+MC/9yuGjWGA9HWCGXUhgXPSmtXYAvNT?=
 =?us-ascii?Q?6yggjMdFk/JKcnWswrnX7H5PxjUWgtUYKJ6YTfbrG5+myCs3rjCC6+VWIzEQ?=
 =?us-ascii?Q?qAEA3/yeBfLMBocl11zieATF1cPETs6rC595IuZy0qgzzW9PDLLoIWmjlVxt?=
 =?us-ascii?Q?B0+IYmuz2Z2FhoLO9vFyF+XrOGhrAP9VuL6v7u9gI+ox6Q9V6y8PvRcSMUJG?=
 =?us-ascii?Q?oaGG9kfEFNliCN51eHE/tEiZmR7dZMTlr/1gFmvBZi6WdqCVPTv3A8s+Ph9f?=
 =?us-ascii?Q?CgIMRAA6cl8ngn+CmzgTrXNN2ZcqOfHxXnV2EURC7zdSUA3PHm0ffOvyHyX6?=
 =?us-ascii?Q?D1dLTeDUmavDN08a9FU3NMX3KoQuVGkUS1Ob93QGC0+3yw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-ID: <CDCF768572BD4D4BB24CB8C3E2FA17EE@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9452b9-d0ea-405d-ad3d-08d981a0ff2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2021 10:24:32.4228 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X1RLL9ux1VxcXdc568ZbiQU3PwnqWaw9kymU52IWl/TdeYlnTf4+uokIhufhb0ftNblUoxX48YvTvjjZI/Lukg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7638
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210927_032438_119020_53701186 
X-CRM114-Status: GOOD (  20.80  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
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

On Sun, Sep 26, 2021 at 01:34:10PM +0900, Steven Seungcheol Lee wrote:
> lbaf, lbafe used on nvme driver
> Base spec:
>     NVMe-NVM-Command-Set-Specification-1.0a-2021.07.26-Ratified
>     NVMe-Zoned-Namespace-Command-Set-Specification-1.1a-2021.07.26-Ratified

Please read:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

You should explain what the patch changes, and why the patch is necessary.

> 
> Signed-off-by: Steven Seungcheol Lee <sc108.lee@@gmail.com>
> ---
>  include/linux/nvme.h | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index b7c4c4130b65..c11eda4be426 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -368,7 +368,10 @@ struct nvme_id_ns {
>   __le16 npdg;
>   __le16 npda;
>   __le16 nows;
> - __u8 rsvd74[18];
> + __le16 mssrl;
> + __le32 mcl;
> + __u8 msrc;
> + __u8 rsvd81[11];
>   __le32 anagrpid;
>   __u8 rsvd96[3];
>   __u8 nsattr;
> @@ -376,8 +379,7 @@ struct nvme_id_ns {
>   __le16 endgid;
>   __u8 nguid[16];
>   __u8 eui64[8];
> - struct nvme_lbaf lbaf[16];
> - __u8 rsvd192[192];
> + struct nvme_lbaf lbaf[64];
>   __u8 vs[3712];
>  };
> 
> @@ -387,16 +389,21 @@ struct nvme_zns_lbafe {
>   __u8 rsvd9[7];
>  };
> 
> -struct nvme_id_ns_zns {
> +struct nvme_zns_id_ns {

You cannot simply rename the struct like this.

You didn't provide any reason for renaming it in the changelog..

..and even if you provided a really good reason for renaming it,
you didn't change the variables that uses this struct, so patch
should not compile.

>   __le16 zoc;
>   __le16 ozcs;
>   __le32 mar;
>   __le32 mor;
>   __le32 rrl;
>   __le32 frl;
> - __u8 rsvd20[2796];
> - struct nvme_zns_lbafe lbafe[16];
> - __u8 rsvd3072[768];
> + __le32 rrl1;
> + __le32 rrl2;
> + __le32 rrl3;
> + __le32 frl1;
> + __le32 frl2;
> + __le32 frl3;
> + __u8 rsvd44[2772];
> + struct nvme_zns_lbafe lbafe[64];
>   __u8 vs[256];
>  };
> 
> --
> 2.17.0.windows.1
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
