Return-Path: <SRS0=SWCy=JM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C83CC433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 20:18:14 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80B0F61158
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 20:18:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80B0F61158
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=swHiPW4j++x80n2dDPtgRJH2L+ZavT9H5OtvuCyEdWo=; b=GfUQCafg6rQVftmMP2hEu7Mc/
	HAXUjVbztyU5KHt3QcFqTdV3kXWWW4j06SArwFm0IG1B7I8z1Z+4VxxF3KcfZ5Ff3Xis/9ELdIDmB
	re/ecPRT/xaOJqw/AMdQM7GwpU0n8+LOygX/f/jE65vtFRQoF9RZf/u0QUVRYHB80HeihJbgtHVDD
	W2juE/CAHoDFOG8XygMlI9mDeXLkTmAoIMPRwiwVa9a89ZuFt22b5NHVLU7iDx96x1j5vDLMtYyLy
	TXjer8b1IZFX7jBuxxVFzH0gxcJ19E/MOE9wP3VUbdEZCp6Fuwb7HFgi8FiHtAkBCeyV4CSPFwk8V
	DLplMPEgQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lX8Qw-00HEpC-Rs; Thu, 15 Apr 2021 20:17:50 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lX8Qp-00HEo0-TZ
 for linux-nvme@desiato.infradead.org; Thu, 15 Apr 2021 20:17:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
 To:From:Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
 bh=8ddHXA4v6YQafqyMK7d+kjdExiocQeOKHrKwap64vBo=; b=10uEzPQ1Jvkod8yVMrgVFElci5
 cHWRwiO6N5gtKNKLTE7AlfoxcC0WQb8hW1H/NVr/dx+YsklCzrFwF5Jg+tmmbPEBRsf70YBQfpije
 GLwQZ7mWHnlZO/JXPDnyzJngKJKtIBO4FRlUmo2zdZdSf4Cdesw2BAvim3OoSs7LPpeA6JRAl/hKm
 vEnQSXNVFF8pgnXCq8SOK725JUMIFrE5R+aj9nHc2znl9gYbB5YhubRDox4NwHVBHPd6IcuLkbnJn
 S0SJEquOZ7RjhbZpR4M4Yc3gRGxMhvDodcreepC+d5qxVmaukiPKSPkCkzBuOiZOOMJhrZcMRmP8l
 lvLmgy9Q==;
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lX8Qn-008s2V-AF
 for linux-nvme@lists.infradead.org; Thu, 15 Apr 2021 20:17:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1618517860; x=1650053860;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=eV+Y17t1938DIVWm5HVL4RIryilBrTv7D6YlBEyA8Yo=;
 b=T6dtqL+coyOpf2vPUlSVQmJCMVKff2pjRR+Ud/6Gpu0gdZKVXn5iogvn
 AlUvMEbsRRXlqAp+JsVLq4XEU9aV6CDoYlKp638w5qVKaJl5nrmrTbLCg
 QOSzINv2mL8A/1i8XpS7z44lrGs+oaq5Vt8pGQjxVwMx323YW3wumnOI6
 mEJqaeRlWApcUwni5NPv7RDKBmXyafZkXUBcFrBQ8foIxmz4RRN/NoKXm
 bdjGFx++C1S/gw55M6QRYHfyG1/ATORcB7NAZhwB0pA3zgAVjLSs37XY+
 YZmb274RI6PztZz65zU/JwrzrNCyq4PL35OVb125Qt9s0D4ZLlEe7luUC A==;
IronPort-SDR: uocEumGaJ6K1QkLYTIOePHeqzqY1kv0RvQn9VQUVJr8rZB/5kjVQby8SpY5Jl7LdoDyEXJWUg/
 xPa6Vv7T0V02kEvlaTd+vjOnb/oU5UiH3aB+K5sgWPmHOXVaWwDwTo10TlRN9YxvYO4OTD3CGV
 /dt9r02sAqZpyaUiQlGBw6AizZzNwLNFRUEvdg/lIFN7G9F30++AFFobsO3VRZld/XCOFPo7uT
 5+nNtbFEVeGIoNOSuVFZP2boNLT0JqhTVg5Z0vPp26L6aH1FTGusjJVnMTJGSUxNONc5YD9jzH
 KbQ=
X-IronPort-AV: E=Sophos;i="5.82,225,1613404800"; d="scan'208";a="169505099"
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
 by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2021 04:17:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Avwqp3TDq5Ka6M3Js7HYpi9CKcrdBxsA9YKJ4kWAvxuhn6JWY2vNEV1LS8XVmOptgUx73kDeeLoqZq/rmHnFZ24Ftcc3bq/0uLNU6HrZ8yxrtBB85xFj1bGhkT1EoorTCSJbXg+i1301kUjububZE8iMLb7wmW0s1dtKpxXgnZxbzo2Coi6cARtsu+xYh8m36gYOkuJuvGuyNi7T1fH9Www0IK1Necl0JsxP2w2iabaKPP5cvCduKa4SRHFLngzRYNLbwvPEYMy7mkzEYeO363SIHvlJCAEGmhCT2u+MB/uqsjsMPKTsELnLw3aUZwFhQxGxv9bG4Srtjja1D4DNuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ddHXA4v6YQafqyMK7d+kjdExiocQeOKHrKwap64vBo=;
 b=EfgurRNs4C9Dc30hhydYJWmDGV2NWB1szB9L7vWtXbKlHcy723ZJHJpgVrZueF/XrCurKzj6mPtK9XfUqaKrsH90fG6F17UOvS6N2uEVdnpwX5g3wXiKl586uqwHKZCRCtcJMbBdB5dA9m/wDsensynUz9KTuIlZ36aigwUwt3QQX950JnR5nzZ2yVeO0rnTwomz0OJrzWdRRlKlM4fhWff6iZ3eO02YT8cPXJ8onWbBkdSMHXO1jQlJUNpOrXyFwgYFZfGioUhQbpatLCRZR79r5/b/nok/oWyqCFjza40A1VYw5RszaCwIUkboiqUXGZCdnPejnzT4ORCYyTjzmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ddHXA4v6YQafqyMK7d+kjdExiocQeOKHrKwap64vBo=;
 b=nkOsG5QTHxc+5c48fo3Nf74T4cZ5JxRyNKBZN61uVd8zeTwqOod3u8/iSjMpyKbzmn5qoOS9Dj5kw1jDXoJURot/CunO8z8ZsjGO/HTIHl/oEaG4dCQDJ9IBdQ0e7l2kWWhGAkw/o0zqDYYZeiz21l+w7Qk0yiJ/xIdUZmA8EwY=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4327.namprd04.prod.outlook.com (2603:10b6:a02:ff::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Thu, 15 Apr
 2021 20:17:05 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4020.023; Thu, 15 Apr 2021
 20:17:05 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Hou Pu <houpu.main@gmail.com>
CC: "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvmet: avoid queuing keep-alive timer if it is disabled
Thread-Topic: [PATCH] nvmet: avoid queuing keep-alive timer if it is disabled
Thread-Index: AQHXMdayX8M73NB25kWoPQwsZdxM5g==
Date: Thu, 15 Apr 2021 20:17:04 +0000
Message-ID: <BYAPR04MB49659A9C02A2344BB68BB7B6864D9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210415090530.2353-1-houpu.main@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c88ee17-a79b-4f20-548b-08d9004b6ffa
x-ms-traffictypediagnostic: BYAPR04MB4327:
x-microsoft-antispam-prvs: <BYAPR04MB4327D3F0936BBF513A548480864D9@BYAPR04MB4327.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h9Fo2gegulq6ibSeoD4FLewrDBHnBE1Fw5qY8wN+AglS7j+u+TgNrQQe5H3PCu+j8VzIkBepW7dhMsNH9airVxDUNBnbabeqgfnQdUNooLdtmsZZFFS19SBBM6c4RoMm/FpFjcXK/PjdF9UnEi419pK+KjRXxAuZpe2ilnIMofM3/yH7+cyCgq+uSXcH1AbksFutY37GJnqgyFQ0ZepmBj69B48MllzwtK/xdffMxzn8ntFzUgaQk0mu2wh4E1sebKFtYwCKp4dVbdISpuOuCYxql4GqtTxdMSKd774JVDZ1YQt0wqKTnSi8wO56HuLuJzkHic9yISTkp8Xyxw9VxJcs7D6clvp6/ZEkhZMvqdgOiMWTUJZEUIJwFuV3FDc6ajtyHw/pnyCO0Nebo4gOaVluquD3RpxqeR0ND1d0dNhjxqppUyNockMunEW+/8nkypOEO5L0NkDX0xBnrrPYFZJhzW15a16R2vKR9n8MgV5IBInId6heqtwhHKn9D8ypNBOP2sm4gfnBnfvvwUTKn1Wim2Ayc0A7w807IblDn6iSlKpC26GuAbfJGBUAU9xFz6oZ8YVnAjj4tiflqc5m3sF6YyYbYK1e7goJWzX/mDQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(396003)(39860400002)(136003)(376002)(53546011)(6506007)(7696005)(4326008)(66946007)(6916009)(86362001)(76116006)(83380400001)(66446008)(66556008)(64756008)(2906002)(316002)(33656002)(186003)(54906003)(5660300002)(9686003)(52536014)(26005)(8676002)(478600001)(38100700002)(55016002)(8936002)(66476007)(71200400001)(122000001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?VKQGS+MTZHq2sdzY81+zYSqIXyd1kZvbtqFf+ShqNfW0KGbXagTrXkW7H2DT?=
 =?us-ascii?Q?WHNoTauo5wNFfTd0nItuRu3gC/b4OkfjaD2rPzGt5+CQDrZrUUTsYKjS7jz3?=
 =?us-ascii?Q?fLF0FPFVLxA9JHW5tnUcwVdohPjokLYyAqH5nSMegnzbeyp1C22jCUttQ1t4?=
 =?us-ascii?Q?vLskxe/LpqXrE652Z6+38ldNn2iIdw0dasaGsNhSS0KlXFoiIkKAMlXMpnfu?=
 =?us-ascii?Q?/sW9cH0HYvTsv9rws7+yUZ3nA8vYD8s3fUTJ8r4qJ132awlKinACeiSuBCLw?=
 =?us-ascii?Q?jNpqOs8JLO3qrsA4KPw7ocJhs0fWE51bdCDasfnV0jLp0omZiyqDpQnfm7JC?=
 =?us-ascii?Q?TCMXUR0Alo7v7MP5RG3yNsyMhFSqIXrKzv0q79HOZIJuQvXM0N8uY/TXJItg?=
 =?us-ascii?Q?XOJlKtYBjpy138r/hMwwvcvh8dJeVhKtRa+cva1k6+pD4BlCJYYIe5PM7zyL?=
 =?us-ascii?Q?5lUOC3kzGxtzOJJA7JK53UXTsL1j6L5y0AfV6j1DrVCcMCLxl4BbyGJVFvnc?=
 =?us-ascii?Q?Tx3Eu+lhWmeNTWew0DWkMSKX6jomsBV0fmhREr6G5KGDrmd2EumbodcxeJpd?=
 =?us-ascii?Q?+RgvTNM/niaFlXENWN7edhd+5OWkuE19EsXt+dZErNnMyy3e1Pa1G6J4nuv6?=
 =?us-ascii?Q?Owfzl/RpesowIp2HRXMIOrCCLoj47CFBOW5oXo7/GfmGbX4Dw+5rt8Eu62+X?=
 =?us-ascii?Q?YbaCjXIwci4jIbcxNuUFg+vZqdYok4hy2ZofQ9MZBUsf+saDpEKmsVbFSsza?=
 =?us-ascii?Q?ZBDvGwbbbUid8XR537Tk/ZU49EbL6Ue9TaEADcsSaPxbnr2vm8msEYfnclfg?=
 =?us-ascii?Q?3XWNSZOKSS7KFOJQ4lQUxG2u03omURCjBKZ0+eJKrmg41U8gDCMKvrFekZ9A?=
 =?us-ascii?Q?MPAolMWofQMsmKPUY7B5F149VGUH0QTIMe5iJHg141iN2LQaHBdF/3koAaeA?=
 =?us-ascii?Q?ci06z1lHQm/0eiRhlmJiR2MJtuziCoUrsBR4xp76gL1nPnKGFKCwFT1wTLqj?=
 =?us-ascii?Q?h4cD2b7kNWSNhqfb680UJaIhtfWzT0tzyNFMvz5ZW/87A2TNaR6ospqRcJfW?=
 =?us-ascii?Q?zxxIMlJ15E9GZJUxCPpSUft/bQy5OsEDeV3z5J1jqOQRC9SnWvbN0YZ5M9zf?=
 =?us-ascii?Q?5B0iahXsUqG3c0+T7M1VWGY+2DaAQhtSXZYwM+rogVYxMRMDMnX6b5cy56i7?=
 =?us-ascii?Q?YLAHvCeGAXOOHLlTFoHLxLAVqIw1t56DZ/Ee92S8yfk1c4/V6te1c5RKcOga?=
 =?us-ascii?Q?o6+xI/dPRlpPlYjF6A4w+kJca8kwlNTvnkPbNNMb3nw21p2fnAIjYRLl4zqE?=
 =?us-ascii?Q?D+zspf+aRFScTTCH+yEu5mTC?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c88ee17-a79b-4f20-548b-08d9004b6ffa
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2021 20:17:04.9310 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5KhgF/tst/3CE8a2M8q7uz3szRx8wjJULa1HCtcRXm7DdiOo58FhaF+8yDRcCmhzwbKaMLzSe5/Vp5vfdaThfywkSkkRrU4eJz6RAjQGs1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4327
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210415_131741_463120_C7FEDE3D 
X-CRM114-Status: GOOD (  15.01  )
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

Hou,

On 4/15/21 02:07, Hou Pu wrote:
> ---
>  drivers/nvme/target/admin-cmd.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index f4cc32674edd..b8a33d1506ba 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -926,8 +926,12 @@ void nvmet_execute_keep_alive(struct nvmet_req *req)
>  	pr_debug("ctrl %d update keep-alive timer for %d secs\n",
>  		ctrl->cntlid, ctrl->kato);
>  
> -	mod_delayed_work(system_wq, &ctrl->ka_work, ctrl->kato * HZ);
> -	nvmet_req_complete(req, 0);
> +	if (ctrl->kato) {
> +		mod_delayed_work(system_wq, &ctrl->ka_work, ctrl->kato * HZ);
> +		nvmet_req_complete(req, 0);
> +		return;
> +	}
> +	nvmet_req_complete(req, NVME_SC_KA_TIMEOUT_INVALID);
>  }
>  
>  u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
> -- 2.28.0

I've validated that this behaviour does exists and this patch
fixes that.Please add my :-

Tested-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

Also, please consider following on the top of this patch :-

diff --git a/drivers/nvme/target/admin-cmd.c
b/drivers/nvme/target/admin-cmd.c
index a892cd246783..3422d35b25a1 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -1010,19 +1010,21 @@ void nvmet_execute_async_event(struct nvmet_req
*req)
 void nvmet_execute_keep_alive(struct nvmet_req *req)
 {
        struct nvmet_ctrl *ctrl = req->sq->ctrl;
+       u16 status = 0;
 
        if (!nvmet_check_transfer_len(req, 0))
                return;
 
+       if (!ctrl->kato) {
+               status = NVME_SC_KA_TIMEOUT_INVALID;
+               goto out;
+       }
+
        pr_debug("ctrl %d update keep-alive timer for %d secs\n",
                ctrl->cntlid, ctrl->kato);
-
-       if (ctrl->kato) {
-               mod_delayed_work(system_wq, &ctrl->ka_work, ctrl->kato *
HZ);
-               nvmet_req_complete(req, 0);
-               return;
-       }
-       nvmet_req_complete(req, NVME_SC_KA_TIMEOUT_INVALID);
+       mod_delayed_work(system_wq, &ctrl->ka_work, ctrl->kato * HZ);
+out:
+       nvmet_req_complete(req, status);
 }
 
 u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
