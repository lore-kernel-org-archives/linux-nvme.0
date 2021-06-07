Return-Path: <SRS0=yMBa=LB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65BBC4743C
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 08:02:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B01A86102A
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 08:02:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B01A86102A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=65fuDCzFncdIqhzZkl2bzMikmbXxjTQB4rkyJfs/Lp4=; b=ew0oCW/peZtdp8
	lfwStG68df/UdTOJLfdV4LrzQjtLytzggXSJIzgPLxtDdWQqGKp4WoS1agCFtLhxm8BTcpbkifljq
	jhLUzJLBm89sMs0Y4o3LboaN5NHyvapZR1ISdGa2qb839G2pS4xDBNvELRoC6TA+VNnjWRPcPIrTp
	TYbZXLTUVWAxeKib4ycz2kbDdfColrIhC6PwFC0zdNx/6eilEsweyrpE7sbiv0bgeld91YhWX8UFF
	4LrpfkU+mSyF5V+UP54RBLolU2cQ8CWxXDoXs0PTTmP44KLdOiybtw+jwGhS76RV4STiBqvHpxrfj
	jtWp0Tb528p+1YlFerOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqADJ-002AsE-E3; Mon, 07 Jun 2021 08:02:25 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqADC-002Apw-Rb
 for linux-nvme@lists.infradead.org; Mon, 07 Jun 2021 08:02:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623052938; x=1654588938;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=X7kwV2JnKlZK7GcpqhrPcVKd49KJsGQTZJibmPhyZRw=;
 b=kVk14xz61cClyyNPCkkciNb/UN65xbZA2KGpGyHPBb1gkMnMy6QOAYaz
 lr49ELTSrxeu+FsO5/8pVxCBl1SkMU38xPo869MElqTVzXC4EMtlMWBQD
 bNhsoT1dVC6BlALp/v0Wn5WrtnG4aZCNXJ7QDsjTOZzbO7qzLSF2oDUaU
 OnnmegQh1dakU6kLDJT6B/K0q5pAvoy8B+GkndJASEGz4BSkzcRW8gvfD
 QrVPvZu9PS+0aUpmsV/bigvU3VI2Dg/B2n8rnniC2ocq57G8DJ1/kWvsg
 CF91g4fz9ViNxTq0zeQTtvriInfEosnd23HxrqjXNfKjC66VRw1XYQXq1 w==;
IronPort-SDR: Fh+Dk6cMvW6LOGYlDSnaKYjxyQ1msju3TXn0swtoTshR3awmJJAz9e3Oh+ql0ZtBdprpRD6KdK
 86tZiox8mA7sAoxc69eo/HsUf7W86K3ISL73Kh2+2uuQlsp25rCLEXuztfuh+71gwXPu1wsdV0
 sbZyqI89FrIKSKOAsxThFst9HQCdfQLiogPdFmvi08WEwh5IULB6NwIjr89XMBlJTySIe9u/c2
 IUWnxzzTJ1AaL50FzGe380d4ucA3SuvQtE4vDzRHso7FZV+BDEVpil0JYLwjOqur+erlRxuPRg
 GOY=
X-IronPort-AV: E=Sophos;i="5.83,254,1616428800"; d="scan'208";a="175749643"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
 by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2021 16:02:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PvMkTjehmbDcj3Nlbde/bnrtueQD441z96dN6thVBMBbaBZm9TTS3/fNBWDNtPvBtxoisdwubT3ksjklPWkoHVwiRulB1H0KN7cyMCAyZM+G0/n6gkWBWJo6x+K492TrN6whEDcVkFC0C3hD1Uxv8tCbHqEq185rDHc4rL3nXxGKxF5CHUli9zpGtzO/rgkvIpiQq9JmrG9axuHlpd82V/RsS06jQNRO+gcO2LfXKWwmh83ZPW6YRjaHwvUhg91T5PYpP4LI16J6sLVAWkCsrU4W+bEmRubkd/jkbydLyMNcLxcMKNdvtwNz7FKzfNh9IeeNnPbb7fXsUcyAgm9azQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cD9ZxRAkvha/21tw2DVtQcXJ7t8PpyS9OmaORDwgMW0=;
 b=UOCmu0W2D/HftpIrdXbCQChF6WXvDkE9RuSVufE2NYEfr4dkGIUAo5yWYTtbyF0iyh/dyYeeU4sA8P9EIlLlIcC66TnsI1FNdLaSjEVX0P/gF8LTufHRQWxvU1OId5ZMHOr8uqcR6UR9RVqqnpAkX9cONYNce2Ibjsjdx2rXMBqThDQP5p5kr2MdeM1P6xFCyyvznmvYrBczC+M/N0PlnMU0U9BS2h+NwEGR0Og7/QM403JhYuTIc0FMPNd6Ntbg2e711SyASp9qntzfb4NJaluF4OnThfPGB5g9F58FoFonbsmom4Hg3TlotnwvzKMyNVuXlVq3XXdHUzPpeUHlSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cD9ZxRAkvha/21tw2DVtQcXJ7t8PpyS9OmaORDwgMW0=;
 b=EVFeBAmAF+e3UiKF5aapXApht5T8KOGtSCstHY5YM5IbNyXKj4MYPSzEA3TFnNSx3eqbBnSpFhhw+k+yXJyvhHfaUKgs0q4UrnPb88loZsASqcJSy8XQ58BWPS71eoc0jL/DB0s/TDb0hO/WIohGJ5B2JFFq5+PGJc4yEj56aPg=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by PH0PR04MB7687.namprd04.prod.outlook.com (2603:10b6:510:56::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Mon, 7 Jun
 2021 08:02:12 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::45d7:388e:5cbb:ae1e]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::45d7:388e:5cbb:ae1e%6]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 08:02:12 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "james.smart@broadcom.com" <james.smart@broadcom.com>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 4/5] nvme-pci: use helper for ctrl sgl check
Thread-Topic: [PATCH 4/5] nvme-pci: use helper for ctrl sgl check
Thread-Index: AQHXW3NspUhk/PruIUGakI4qs4MS1w==
Date: Mon, 7 Jun 2021 08:02:12 +0000
Message-ID: <YL3Sg2xgnKN+/a4y@x1-carbon>
References: <20210607003705.21784-1-chaitanya.kulkarni@wdc.com>
 <20210607003705.21784-5-chaitanya.kulkarni@wdc.com>
In-Reply-To: <20210607003705.21784-5-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7357ba0-4ebb-4889-2f58-08d9298a8eb7
x-ms-traffictypediagnostic: PH0PR04MB7687:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7687177CD28594564D003D10F2389@PH0PR04MB7687.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bJ01eszNo89HjOlvrgIF3knqZCm9Z/Mhg0Uj9JVWjdNaT2gukY+9DYkABlY8zFa8rHxA0xnXOqfcIAbdHb7hK0a31kz5Z1HIenv7B5gM/ACgr+0vxZmEoNONTMpU3LV/ftk/GYxyqNp3zL+Mtoh9K339jhRHwnFp8bCOBcrlLg0IIA2z3jmwfs+tEN93LBrG+esjND51fX2HfHNZq32cu8Kw2xVcc55OZx9BL7eq9V8id7aWj/tpgeWFqeDI6jOfgPsmX71vHxxdT5TBOB+RfTVSDy/YU4xdFa2Lhzo1nb2dv6s3RXjeOI3tc2uhOzVtT28HLQQ4FnA2ycsmu1anSmNwjFDpqwqAnHsUUGTYYz80ZPi8nXOS1iMD6GEv6izu259TVRShPG2+SIBi5qLSedKqTRz9ieLQwiigRBCA2m7J6K+PG1OiJtYblQxyZPwImOsGj4+AOjFTgGCp2y/rBNgWJtIFLzJO4soRcaaBHBCEgsg7cAeTdTQ9euLrAWMjnx/e8qvHY+mPmqLXNUs0LHVu3WT47w5TQYg8vWS3o8VBJtEGepAFRCKrjiOmBsyReMdQN+wZBGk3/RVBX+2MrZlzOOfJrEgwucD/R0lGRPY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR04MB7158.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(7916004)(136003)(396003)(366004)(39860400002)(346002)(376002)(83380400001)(2906002)(4326008)(6512007)(4744005)(38100700002)(6506007)(122000001)(316002)(71200400001)(6862004)(54906003)(5660300002)(6486002)(8936002)(33716001)(86362001)(478600001)(64756008)(26005)(66446008)(66556008)(66946007)(76116006)(9686003)(91956017)(66476007)(8676002)(186003)(6636002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?XxIF6KYCh9PA1zUdlDr2hinZWYLFZRwG4uwdzFvcC0d0/oTHauGx/IlBmSol?=
 =?us-ascii?Q?2OAJ2sWN1l3KHXoHuVczRQp/hnUbqiT3t11LudWmXDyfKcvIa58mVvvi3bQA?=
 =?us-ascii?Q?w76Ro1pvcQK+HFeKszwORjFNNC5iNjlN6y6/RnYxj3t7IchlGZxHE6V4+XaH?=
 =?us-ascii?Q?XhPl8e0EUB030JWv+C9zAa0jhUl5ykWKDFHmUVgX/XkhzlTfz6TWC+o4/pfG?=
 =?us-ascii?Q?WG815D8Bt+5IEWy8Aq4GxRVafoon0ZiK1w3TjNLBPt4g7VkFXMPUiCMnxBod?=
 =?us-ascii?Q?4Qw71KIEt/36cOK5HkFnx432hlROB6gjyaGv74KJwKRG+Nn8OS+jOkgiZQ0m?=
 =?us-ascii?Q?4P96ajgxWL2mmghPfRyQa5lbItc89n6xUbszgL518AaPS4W+fnS4lx7+Ty+H?=
 =?us-ascii?Q?5jMzQD5tE5lKnUJ81FVv5TwqCRwMDew1BH6vJdsZuFLvITwDQgmrRCOaeCjv?=
 =?us-ascii?Q?Y7VNaG9MHnRJfNDzBWEKjJ098gYIyb/ntIvNXFs72mUxa7i+t2DMJuaNgtHG?=
 =?us-ascii?Q?LRoepfZZZou/kDW+xXgbt3F7qOa6Vu+KfA/dwDfhOn2bdt6q7svcgKNTG4PA?=
 =?us-ascii?Q?rCYp9d0Yq4ZqNEw7Vti2ZrxNFDBovT0+szzZROSYyTInZ6QeL7zRtIoPWSn3?=
 =?us-ascii?Q?sfFCoLfLYCh9XjJhQtSbEMDD4NGncKdtPuV5uW7rNe+icMHIQ0GmS90D251y?=
 =?us-ascii?Q?RJFRLKExoX4e2wdTemhY9gImwqLAEyeUISUKI+3cgcGN+cZL+kgyORa/YGKf?=
 =?us-ascii?Q?h9IY1llcAJ1sSZATn0E67VCmEV5wP3KsclmHlRAPafX4XD4qrZiLKJ/3eFK5?=
 =?us-ascii?Q?iAaVC75IM0XCuQW1VhMb0ZYcZSFs3JKOUXKNMopRWZ95Lf9dS1LW1Hw/j6fW?=
 =?us-ascii?Q?ncz2WPif5bbU+779/zjdhFlFGhXW/Jw/mT013hF3TT/I7O+Si9Ap6Sn3bZh2?=
 =?us-ascii?Q?vgSKgoXHt4WH0m+tM7beuz7YhgZrJiJnuNa9ff2EZ4aTya8NhGe9PAglT485?=
 =?us-ascii?Q?7AgCyJpbEAwLqvM4DKQyZl7EZwLG/AvlAQ4pSHkwqlN4MTZkaQoAynd2gDZH?=
 =?us-ascii?Q?ndhw/XkCS63fkvFrBTfPUdGndD9z4SGpXBgc4Lsf1jAw++g1t9WbIvI4z+4y?=
 =?us-ascii?Q?JjLtTlp5Ds45QLZtuStbxgnDT2DxdvAAtqEJc11jgwC8XPF9qPKko4KCUe47?=
 =?us-ascii?Q?PKmDM7Z3dGmUzYG64IJFFy1lyDy2VhMDWbQprazx7CCOvxMQyW7nBh/pmfUP?=
 =?us-ascii?Q?eqbIIdmMPvM+iWsvrZ1tCfPRfpMhKRMQEXzsJGtx09GnMP/YkqfQ/0s+FIIZ?=
 =?us-ascii?Q?J/hCGwGEtK13nHglbMoB9eSI?=
Content-ID: <F0F90B7A45C98B47BD203B8B29440AB7@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7357ba0-4ebb-4889-2f58-08d9298a8eb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2021 08:02:12.4877 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Otbv6iX7Hd0dnkjTIc0bZR4bwpFoqifeuyvjSTKi1RZUMcOo3c9qNby49V+XRDdlecMrhRFNmx+Sh06eqti6ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7687
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210607_010219_028308_C07B5E94 
X-CRM114-Status: GOOD (  19.11  )
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

On Sun, Jun 06, 2021 at 05:37:04PM -0700, Chaitanya Kulkarni wrote:
> Use helper to check the controller's SGL support instead of open coding.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  drivers/nvme/host/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 3aa7245a505f..a7e7afc609b4 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -536,7 +536,7 @@ static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req)
>  
>  	avg_seg_size = DIV_ROUND_UP(blk_rq_payload_bytes(req), nseg);
>  
> -	if (!(dev->ctrl.sgls & ((1 << 0) | (1 << 1))))
> +	if (!nvme_ctrl_sgl_supported(&dev->ctrl))
>  		return false;
>  	if (!iod->nvmeq->qid)
>  		return false;
> -- 
> 2.22.1

Hello Chaitanya,

I believe that you can apply the same cleanup for pci.c:nvme_map_data()


Kind regards,
Niklas
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
