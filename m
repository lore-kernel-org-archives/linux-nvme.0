Return-Path: <SRS0=kA4j=JG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69390C433ED
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 16:51:42 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8587610CC
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 16:51:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8587610CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VVuyTdWDL53ohPz6FBl+6HRZtMWaphlmkwQsB26o17A=; b=kEeEiKJOOFamH/9M0iDjf6Ryo
	o82bVVOQc66nPVOReri3AacXw3/jrdda4YUopno1Q/RuIX+QhYQk9tjiGxbibAKkGWzitFVPfXLij
	dLE8+ChK5k3f/lomWGc8XIrcSTD9S9cw+N1DQJzLsf07HFkTHkwOGKihyti2K1i8mnoPxaKf/nG/0
	4pG3yWO5o3x2hDCI0rj7HefEd7o2OfGP1Xq9R0Vl0VUvcBcjykcT2azNuauciWbBmcZxn6ylBB5Jf
	h9DzYIcowJ7W72DE0qL6htwh6/P80Bxksfn9S9TwdE/Gu/NjjT2zx/26ZyHKBiabwHkH/PQZ0nRyv
	fZZvERfbg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUuLn-0019Nq-2O; Fri, 09 Apr 2021 16:51:19 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUuLW-0019Nb-2B
 for linux-nvme@desiato.infradead.org; Fri, 09 Apr 2021 16:51:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
 Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-Description;
 bh=/u+0UR2+6vOkEEaodkzs7qsCEjbrqBPwmM8ygytCGRc=; b=HValtOfA/H8N7IH/GjUDurjJgx
 NH2IPe8FQsbhF8CQk0RBIdox0C4GAAx3ZLB56oEwZlMINHs9y0tNZLYeKfaCWYs7k4ApTFsZxtmgl
 YEFfOaqWrBAwt4AofH4fdNCDp+KPBDO7PrCiDnzZ+m24G3gMha8mf03J0AYf0uLxPb2n8BMzt0uaW
 OTJyl34T/e7mapoYA1OPH93TSXyYnyk++7j/wo79svklE79E0eE5ufOCzIPpR+iuMCZrb5DMjExk9
 dI8+7OX+8KovFay2sn65DkL6Hqkew0PSWBtDhP7dpd+M/g4zpW9yXp4akKuBsA5Sjyv5AS8p83s1q
 LhTH2pMQ==;
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUuLS-004fZv-Nn
 for linux-nvme@lists.infradead.org; Fri, 09 Apr 2021 16:51:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1617987058; x=1649523058;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=zN0ARYbewMkk9YSCT4QvsuhNweiInLDALtYYtZod1P4=;
 b=esoXvJK0TzLoITJS6LgBONvDKAqG0b6lRpKjTXGq043VGK6IR9bNUhvD
 bGRW27u60zKqqwClJcwSqU2J+U7sPm9FJm058t5pS4CRtIc0xixkPEUDF
 t9VpLkitdlzQ9kc84BUCcYBKblnzu++0o9BIg6yLJgyxUzbN6+W/Vj7u5
 IonyxG3sVQQdB33BoksDo80C7smAOPsfHg1LnLliF4KWf2u7D5gkzO9Ro
 HXx+wBnu9uXIGI5VCQI4czTnG5+r60XBIcb3dVcT/e5UJLo4fKQaHqMua
 XWz7MOrJ54YEQzaqHNQZ5PDyi/xiM8P2u5BoZhKFG22wsaK6e4SOBzVSh g==;
IronPort-SDR: kLHWP97rpKli2KIyqedO+2SuK4AH/f0AFPb0kCzcsFUntEalUXX8VmhV1NYUElf9bszamvRa/G
 jgl37wXfzF1AtefSPv1Q/kDpzoKx8tyLGKLlamZlnQ0hv+R6CZOZXTrh64BG6E44nu+JaIBNci
 WUo+hzPQRGPqndWd1nOHmN/D4XBHxgIWraiOwo9Ug0jNqkPGpGKqwOwTv9cZAKY2HTUOijDQBb
 d1lpGuchSqYwzZcAyJAySphfufwti6wRarLrWarkO7kmzdOmR12J7rrxttJkXbjcm1VDmdf19I
 Z9Q=
X-IronPort-AV: E=Sophos;i="5.82,209,1613404800"; d="scan'208";a="164012568"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
 by ob1.hgst.iphmx.com with ESMTP; 10 Apr 2021 00:49:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDGVav9NxNCK0cwmBZmCCoyy905o2IY5ikT8c6CfW/PpkG1pT6Lvpe9U9v9CGxaAn6llowfcFPTPmt1SNUABFwkYzHG2VtOj3iH6G6+lY/WWcNdo+BGg/atVfKDNy2uuxjlRRkpyzJ4mK93Cl30ygolst44VtbN+1PuCC0NB3AwG8ENgnVaCCdq3vsD8LSmtrgXvnSiIWorJ7i3+C6C+pd04Dh8C1npIaqI9VJWGPNKA7H/BCwbIkLte6SwqubfGWuE06aMJYKlI1H7xZOUoI1uOc6/SUc83zRKWuSY9h579aQUg2/nbWnICzZDfIjbhDTzh7AOCyB2X7YFb4EeSLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/u+0UR2+6vOkEEaodkzs7qsCEjbrqBPwmM8ygytCGRc=;
 b=oL/H6U9QXY3rBdZAYEXDEgVpY1UMq2mJ5kcdjYoubzit53uwEwP77mF6FZqDdOv1cFaaUPMACgZ83HCkB90NfMCKrqPk+tU45kQIW6UMx4QmqWJeZWgqSAwuNZlDSQpmbD0IoooyA+tbRKUM7Un1Xx2d8ILXFtb+ELm3icROtyhw+cVvW7cw8SrwuhS+QmB0/0r6aYWPMYvKNSxT27dq/BJvl69nFxUiumcLZ1yro2lnRpXujnBfjuMBnKsU59cgo/S2G6SPHILW2ahi8/RxSjvoF/SZOJprDVK2oOVo8Kbku+zgT5MnN0X1rN0zFtLtLbqKepZGMu0XQkyadmslXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/u+0UR2+6vOkEEaodkzs7qsCEjbrqBPwmM8ygytCGRc=;
 b=s1N6+PQuhDMu2ynMD3n15JWwJTViTlG0Q2/iCAIfiLaaNF4W24p4zCrcaolzqF8AsBHGqDTW0mkBwblS1JbnwFR0UILGqNcSIe56D+x3R7j6k/YxHx+nHEs3d0J0GC0bA5isXRjoPo/fQHATqRR+kSv6w+g0Y3dHdvygSlI42rg=
Received: from DM5PR04MB0684.namprd04.prod.outlook.com (2603:10b6:3:f3::20) by
 DM5PR04MB0459.namprd04.prod.outlook.com (2603:10b6:3:9d::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.17; Fri, 9 Apr 2021 16:49:32 +0000
Received: from DM5PR04MB0684.namprd04.prod.outlook.com
 ([fe80::9842:455e:f0d:a1bf]) by DM5PR04MB0684.namprd04.prod.outlook.com
 ([fe80::9842:455e:f0d:a1bf%11]) with mapi id 15.20.4020.021; Fri, 9 Apr 2021
 16:49:30 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Christoph Hellwig <hch@lst.de>
CC: "sagi@grimberg.me" <sagi@grimberg.me>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: cleanup nvme_configure_apst
Thread-Topic: [PATCH] nvme: cleanup nvme_configure_apst
Thread-Index: AQHXLWBP2X2DLWp/Zkq2wlfNg6YN6Q==
Date: Fri, 9 Apr 2021 16:49:30 +0000
Message-ID: <YHCFmClWBxLCX9yN@x1-carbon.lan>
References: <20210409094524.1920584-1-hch@lst.de>
In-Reply-To: <20210409094524.1920584-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7b6eb4d-f1bf-4e0b-1923-08d8fb7771f5
x-ms-traffictypediagnostic: DM5PR04MB0459:
x-microsoft-antispam-prvs: <DM5PR04MB045912C58A2D65CBB755E3FAF2739@DM5PR04MB0459.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fpz1m/N+kUMHZ1BnvIwVlbXx5ugIUIRwW67qVmfgJe+BWbwnri0+r9qyhrSFCNaxIDkgVuvDaqANgs3RCnBMep24q8BWqxH3PeehhmmzKpsyMZbigxC8cMH7UV8gT7Syup+DJseU3WPmWt6qk/XQbln0/nwMouODw/Ks63mzq0bzwQYTahGw1Xgk1oCcVvYCurEOoS+Mu7CBOMm5Kkf/IWbWLf0SxspuXzFwiiDnjwo695aYhMbfHMk8J3mGjrXWbsHMK4Fi3i42zaRXhreM6jy0sMuf7YDvXm65ZuyxXCdN+yNXjAge8zoC2P3WNDO0fCyVQV32n5jPy+9VzWAN97ZnYWesM+u1vZ9C/dmU5N0YkvVo8qiT0//fC1TVyRloP/ytJOANN4kQVGxeemK1ghlO7rABM2fWqFBUYNfn8P7DM3dGX+TSHDg2ubHvwzo24t0TfMBGHx1yMkgzKe57JbEMVVEZ77YsDiCXDLqvy/bYUh/gA0sgPjL3qUp8YQY1oPK5bVSGkaLYP60HKzIBzxzsYR69X/e0YDrJfxdfan9CPhLHdsMexdILW0Qi8A4AZ1R8fX0LVDV6/hW4wmyoKeAUHzQF7ozJYOdqNuAbDKNVfWCR5b/B2p4M9KJzcCtQlIrUG6VC0i7/aBjZuLXyVRYq7PO/wa57L15q6jaO38U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR04MB0684.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39850400004)(136003)(366004)(376002)(26005)(6916009)(54906003)(36756003)(6512007)(186003)(86362001)(6486002)(316002)(4326008)(9686003)(76116006)(6506007)(8936002)(71200400001)(478600001)(5660300002)(4744005)(66556008)(66946007)(66446008)(66476007)(91956017)(64756008)(8676002)(38100700001)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?vzqZGdnPRuiWU1+IlhOaMMLuZSuqZ502b2hzC9c70yfJ7peCPC9+uH1GYIRW?=
 =?us-ascii?Q?kKzGPL8BTOwqDulE4EVs1jtW8oyyCqze4oPd25gHbt3iyK4W24IrEWgsy1wU?=
 =?us-ascii?Q?S7rJhp3SZIAgsedHGc7CcFeWXFDGg2EPF7yHmvuwC4/DBxRtx4wZJTxJVGEM?=
 =?us-ascii?Q?ixxBTlWR64gldFlH9XBFmpNB6PVAWxR/aUk/4dOVQkxPUFvU7h4hKOz2FGix?=
 =?us-ascii?Q?oRk07WcocF9P074rENroEGPe0qw83IwLmvKIoq2Ch9uZ3JMf+L6xKnT/hz0t?=
 =?us-ascii?Q?w6qi7Z58TXXkkHzL2ZGXGvID2UeSBNrCnq70bwRGMn0Iyn3tkgrAeAz4ifUd?=
 =?us-ascii?Q?PG8uPPH+dcWbRHaxmD7FE/lV3TM3jIRwc8Wt6Ig5rgcS9apvBS2Xd4g12yMq?=
 =?us-ascii?Q?gmE0sdLvwUkaNwrCY+5D6lBxmSee5O+omgvd6p3GhGCkyagTWRzJSZCfjpiE?=
 =?us-ascii?Q?s9p6C8DrkGo4sZ7VZZa50vO4QDSeJQwrqZ5w4iqxJ8t0JuWyk/mTyczhu68d?=
 =?us-ascii?Q?osc7+zLbK3NPeod6HftS6OKKdAuEeXjWn2/tk0ZDU3mVYSSZfqvQDiEIS+jf?=
 =?us-ascii?Q?sjHC4Dd2ACp7fDjrn7/n/G4isBlI+jN2j3VCfpYWauPnlA4nLb2XfZ9kD/U7?=
 =?us-ascii?Q?Ld/HwLrR5KaSlO/aYZLUwRuPwKXPZhqAHcbHeDoIcOtBbONr1aCGAYNKgMbN?=
 =?us-ascii?Q?7VTvKMn5r6ufPGn6oxLkwxu/4en0aiouJZAsX71pGPie5qEN9byg4rHofrpv?=
 =?us-ascii?Q?OdFR3JmSX60qz3e7IKs+VrgIDqHqFAJFQTvwewupFPnMQQCF2oBjf4jCVarQ?=
 =?us-ascii?Q?L/7BB7lCsRqSy+uJixuUkrkyYrNy+kEmNYMHHvakKGFkNrbJNJ22dQl8wO6a?=
 =?us-ascii?Q?ZTkMpBk8hw89jS5tnARGAG44DrkVjUioU5Vi2ra/M1yywkKiJ2MDPS1wn2he?=
 =?us-ascii?Q?ooUAtksIVIv+9+cA+4CkkWrbB77YQlkkT/9wDe7pvkz1NjtBGvK11GHsQAVd?=
 =?us-ascii?Q?/GnMiGxW6EmZK92faGE9fuHqUmUZYPz5uvpMciTultY5zq6L7hWfhWlu5wpz?=
 =?us-ascii?Q?MU7Sag5uItCXuBeDoD8+nwPVCZoWPwpWSEDHeb+45uRq3zcMDvOdcyjbEcuA?=
 =?us-ascii?Q?IVAh2SRENWJH0W5/nWjjY63+tR+QC97yDo36KHj3YEl9pUkTnnjmvSgMK7wk?=
 =?us-ascii?Q?rvffieJy0oUGOB3MtJwo47QIVJl/8tHP2t0FCCfPI4+vcX9UptuLkCfQG4Xu?=
 =?us-ascii?Q?6ssJ/21ezoAnWWt2xrxQng1Mrc5QOmImClXaSovCzMY1NYMVg9HsGt3kirEY?=
 =?us-ascii?Q?w80rEjDWtba1HqBKquHoBn16?=
x-ms-exchange-transport-forked: True
Content-ID: <55CD18F8A04F634C9F1B06F51CFBC91E@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR04MB0684.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7b6eb4d-f1bf-4e0b-1923-08d8fb7771f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2021 16:49:30.1774 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jXAHTaKsLe/0VhEgyFEHXfNSuNwAbh00nKoSTw1NQW8EG73WuQtnYw9vT4s2MyL//xT+xvtVJXEwPVCMh6P3tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0459
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210409_095058_963926_BFC96ACA 
X-CRM114-Status: GOOD (  15.19  )
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

On Fri, Apr 09, 2021 at 11:45:24AM +0200, Christoph Hellwig wrote:
> Remove a level of indentation from the main code implementating the table
> search by using a goto for the APST not supported case.  Also move the
> main comment above the function.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

(snip)

>  
> +done:
>  	ret = nvme_set_features(ctrl, NVME_FEAT_AUTO_PST, apste,
>  				table, sizeof(*table), NULL);
>  	if (ret)
>  		dev_err(ctrl->device, "failed to set APST feature (%d)\n", ret);
> -
>  	kfree(table);
>  	return ret;
>  }

Since your patch includes whitespace cleanup related to apst,
perhaps you could remove the trailing whitespace after the
nvme_configure_apst() call (in nvme_init_ctrl_finish()) as well?

It's the only trailing whitespace that we have in all of core.c,
and it makes my eyes flinch everytime I see it ;)


Kind regards,
Niklas
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
