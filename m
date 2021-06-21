Return-Path: <SRS0=I4H8=LP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EC0C48BDF
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jun 2021 03:02:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3661B6113E
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jun 2021 03:02:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3661B6113E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=V+jmcLMUiZneZFg7JvLDHqjco6/FoXG5LAT042EC5zU=; b=Row7nOCJ7516MI
	s9s3gP09Q0fgrgqx95Vvr9DhrIVy3M7NS7UPOp0h39k1h7Q6T94tw0aL+X3hQ5BkbZ3QFKfb4916l
	8AXC9Z1t5giy7xBt+MVuAIicp1y9XqN682GsdSVqM0sR9g/WN90Il55wPj0Pf4lJy2sxpN2FkznNy
	WxB8WL7T/HSO1v7Oi5BduO4Rj+Y2WHRTLF49i1vApHsqeuyZXUwe12ib2cexoRy93/ymqQfF1yhPu
	v9yCvXcRmpbUbAJIOsbjRPUOBGmDI4t5rh71tToB7vdnC5JCoyv53Ame+xsMH2EsF4u71eBtPny+u
	ud/0V/NdoKgOssOjLBNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lvACi-001vgt-Kt; Mon, 21 Jun 2021 03:02:28 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lvACg-001vg5-BJ
 for linux-nvme@lists.infradead.org; Mon, 21 Jun 2021 03:02:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1624244547; x=1655780547;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=tmqTS/3MvCcrEC7hi2pUX4A0Hwm1hWtPNwunNcse8Uw=;
 b=N06NKSCuVagOlOovXXDwmr8+6qNIjuH9FZDJ97w5Rr/P8xPTT8NQeyL4
 tVVQXRcq7ySz6edDDq3wCVoQiGUsJydOWBuD2p2HHeQJopr9kAZ3yH7hw
 1Pn5K5mSEzmvRjbaMA39wLcNYJM65zwUA8dFdxPXNBVXOZtqRX8cT2RZ7
 buMe22EfoGV/UXQ58vsXri/hRlFZ9S4s6GbVOiPgVf15l0X8DsPTnRH/N
 Mz0fahCqb6iL0FRi20WJNZpiWsQ2Xptt31J8fl64UJs5IQqe5JV9NJq+0
 hb+HavZANOo6Kt71GZ9ALL409Otq9S0ty9oTA5IRB96tdxJu1XUKm+JYE Q==;
IronPort-SDR: 2iS0CduxDhktl907Ph5rLKUSm5uyqjc6/QO4pj1NIuVumx0jOCwF/GlRrgh0MTEI3i47Q2YJwX
 M2NMkcQLJZcPXdCxOvNdmN7BN4kdegYv8czFRjnj+eqk3fiSe+MmUCuWt8bX3WafYRe07u7HS4
 XF4HhWHiBGT5HNQbcTP0FQUXB1kauZQ5Jgk6t+hUFnhOdsXJm4sqKg1phDpUfJvkwbXI3ENl7X
 vM7f2MApOZZgvhG6MdL42jflUwm3bnR2+ffOck24juVKA158S7KiqK/eG8Xcq7Cg3XRtcuK06v
 wQk=
X-IronPort-AV: E=Sophos;i="5.83,288,1616428800"; d="scan'208";a="173012017"
Received: from mail-mw2nam10lp2102.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.102])
 by ob1.hgst.iphmx.com with ESMTP; 21 Jun 2021 11:02:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asgh5giIcu1X+WXCaf143ILC9QTfTIdUmzUY49F1ZpmoUeym0bKBCsuU2SYHroMVT8oywjsR6NGaJF2VKzi+FRFSHwY3LjPLn4wD/DuRM5AiwRuQR1BazwOIMRcidpWJx1P1+mJ3Fb4Ge/+PoppkZ1BzoY2W6Ht5joq8nlU6+Lckny6qZpa+0BiUngNx0+07Rm0a013Ctom/0EHebkiLIg/kkPVKWUGdEuhVUsIDL9uFEGULmvTK0Byj7tHPZ1AhlMmOpQ2VFoOQJoSByyXMB3VcjAuu8GlJSIcyN15Zps+9a4Ojo9DxdPa6OaWksOQCpo6jmdorvAILm2ZOvogZFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmqTS/3MvCcrEC7hi2pUX4A0Hwm1hWtPNwunNcse8Uw=;
 b=YfiQV6M0EeTQYUmb6kKRuposi8ndS2N4YR3GZKKyCvfCJL7DLf1AhtsXTwsZ6wtFPSOMJ6Ng45dB//KsDbOikbcrdF2sJb8PXtkxhcaKkpApQ1LaF0+8y12cwK1JXdWbela3QdA0QMV8waobdNSFDJXq/3TpK47DRxhp74SSq8BjJHqjcQHUDwqVyhT10H2Wpf127hFf7PMdbq5wDjIB/jEyLeKLkBczjBsqCzSu8/936wQc6ifGmy6zhSFTSAChBE5Jrl0CB4lspMuyx879BOvid+lptx89v+Gj2nRiMHxjiFNkXGURaNTvUkaK/L9s8Cf6mPkhvLedv1mQ8CVsaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmqTS/3MvCcrEC7hi2pUX4A0Hwm1hWtPNwunNcse8Uw=;
 b=m/Ggm1f7kSVVceP4a7gujlyFJGxssuDxRpSiiqeAyIr/tm/4vrfruuMZts8VAkOVqtCPVMI8bQw6nJxsezi87o3TawZai0a4TjiLPnTegaItBIsjZTOXdy5jIuT0YWBwpVLtFC0JPQEyzRuGY03ZoY850A5JNBh8IaHPJvXUKCw=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4662.namprd04.prod.outlook.com (2603:10b6:a03:14::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.22; Mon, 21 Jun
 2021 03:02:22 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 03:02:22 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "dwagner@suse.de" <dwagner@suse.de>
Subject: Re: [PATCH 2/3] nvmet: prevent creating ctrl with no namespace
Thread-Topic: [PATCH 2/3] nvmet: prevent creating ctrl with no namespace
Thread-Index: AQHXYI8fm83aMu3lkkyKf757po6sFQ==
Date: Mon, 21 Jun 2021 03:02:22 +0000
Message-ID: <BYAPR04MB49652E3E4188D7FB861FE908860A9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210613200252.9167-1-chaitanya.kulkarni@wdc.com>
 <20210613200252.9167-3-chaitanya.kulkarni@wdc.com>
 <b6b62366-fff4-81e8-5b3b-c3062211389b@grimberg.me>
 <20210618042814.GA18021@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3729616-d9ee-4a92-46e9-08d93460fd80
x-ms-traffictypediagnostic: BYAPR04MB4662:
x-microsoft-antispam-prvs: <BYAPR04MB46622E4F6CB9897337533A30860A9@BYAPR04MB4662.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K1xjxA6vWOmBPJ7zMEyZduJnO+XHeK62PCMM2tmuLw8u+mh9zNhFEzBD5nQWlkGLNRrJVF8y0L3NJSm8+bjCwdPFvXJy1hOMg2WP9fuqwZpBuDR1Q4hQjUvQ4eW8G0XG/3jhfQXhsOh2NCEGf/C1vUhhbQfblw3SbbyoGqD3FtAmAnM3jA3P5wgRsPhz4ORWMtGK6/f3A5SxStfDWjBZaXC2FlDAhsg+mO5weqwZqU1hu7sbrgjIPr4SjCd2siDDC+EelSI0TO6U/BViOvJNyCWZ+gYjTr459Q1DvFe6p20voLe+tuRqF7ddLE0Juu3cqP3z/Q+dpcboKKiqi7+D6ReSRxrwLRMk1Oubk47aed9GeH0/g3EEdPoVh3urzDDnBgKRHuQ3ev6nFD0RZhUYO938K+wMsmYkKL4TRJN8n7Z24SBrQZ2t/S31UOJba13+eNf3kC3eBytq5Ag2YJKKH99zh9pA2hDGsXf38IcI9j/qmxKHtwHi4yIdrVORKeKRdgSSDYXMpddJU/1gZyXVV9YuqdTRKM6CEEj4AMKq516iGXkcJH60v8X1goMUNGit/zijG+lXm6bac7OffgmlapDPEIccD8fnuBeT1MsiOV0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(38100700002)(33656002)(55016002)(26005)(9686003)(2906002)(6506007)(316002)(66946007)(66476007)(8936002)(66446008)(64756008)(66556008)(52536014)(5660300002)(186003)(4744005)(110136005)(8676002)(478600001)(91956017)(53546011)(71200400001)(54906003)(4326008)(7696005)(76116006)(86362001)(122000001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C+1mWCmnzjjj+sRnnuJyZiM3FP/GlOmp3Brfc+eXiB7/CBzbtwLlOMZc/GVj?=
 =?us-ascii?Q?MNtCLpjMH/REZ0s6ezPuJl/MOSWyZIa+MqMZh4fQ5sKPlYKs8gWJTGxmQ7GO?=
 =?us-ascii?Q?G/VYTDBcEnzVeif1Sx+hTEbhdS+Q9s0AkPM4olhlPKcOoPiK0HX2+x2rVmZh?=
 =?us-ascii?Q?WBWRksibfuMQF2Hvs3KEWIQouSluj+4OrHmdajmu650alRfyS8spD5GjZuMA?=
 =?us-ascii?Q?CcH7yGw8LFZPIdptv2DbCQIFN+E1SlVQIGM8TcDb0l3uulJri9/QdRmyzXHN?=
 =?us-ascii?Q?Q2ZdhctBR4jColAkbgeOOnEMZfyGLqKkFNZTNIfnHDB3r2wT703Hl1ToKevR?=
 =?us-ascii?Q?IY1qs1NlO+xGhQn1j1OS9xXCZvyp6PWwzm5A66wyXzrBiVILu3h67nxz8rlM?=
 =?us-ascii?Q?fEXOPRwxR+kh5tN39iHlcOmOMkhffCEK3EvLMxwi5hW9+CcwvX17hfFd7iJm?=
 =?us-ascii?Q?kgj1zpHk3UXPmLMK0ZipiwoobvpAB54Mjd2G4fnFrdlZDvu7pbWfkcbnUD5U?=
 =?us-ascii?Q?dayKlCFCA5JNw3jbMr1DMcZYaAQIYc4n+p4soqPc29D9wkXEOd6Usvc6rU6O?=
 =?us-ascii?Q?mwNvOpsBTtxfyYyOCNfzBhpMxY20XoTpYPPyfOYmzKWjtOilIgxYNm4KxWyH?=
 =?us-ascii?Q?KHd2eJjrhOct3GDQBO5PDkwfRsgFi99rWPpBvWK0ZzJNeaOjgDlbxRSuhrDl?=
 =?us-ascii?Q?qzUJ11+m6UObwOHEBD0BmwK/K7v01KGAb7jSawmqLTeypanFIsMnd6J7L6V+?=
 =?us-ascii?Q?NcsAv39Pzy/G0hsuggyQ23cD2zFQahnLYd6+4topvOLy+BBm7rWIYOVZ+viV?=
 =?us-ascii?Q?A9aQyrMaKgYrmPWkhS7jue565HGYSJiaFB2gPgmd0XLaEn3S1UPWXrUsphN1?=
 =?us-ascii?Q?txayD67oX0AJjae9GEm9Lj5WvP9XILNZ4vG9VQgsWrAtdlswCERn9pdYcEUv?=
 =?us-ascii?Q?7tma7co+QAG/xIuHjKUGqZgkpQwtaemdVt83O6RibrL2ghFu+AI43+lCkUvD?=
 =?us-ascii?Q?x+/nt+mLvHwtxAHcdniMhOGWKjSWPJy2SdYuL6fbdHQjs9WHM9cLHWJUxi3V?=
 =?us-ascii?Q?Ah2RPv2o56RYeuuOn14qRjdXNW59YHqWTGBH7CTS+j3FC0AjG3OCw+sHyc4+?=
 =?us-ascii?Q?J5FaqVMJ5gWWKDUUwwkQ3xlb5aoNCFsw5P71Eb+wLfQoIEvcndWfl0/G/zVC?=
 =?us-ascii?Q?ySxw9e2vFtgoX1S4mO55wsJGoL1QwyG8+nTP6SbxlIuU65EkLv/qtFCgTwco?=
 =?us-ascii?Q?gosSjd+ynROlmqwU8oPKtazX4MPlk497d9YpzvliwDG8bsxdRC3ftj0LaUUa?=
 =?us-ascii?Q?ajGHP0vQI6QMCP7aRYIbbK6d?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3729616-d9ee-4a92-46e9-08d93460fd80
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2021 03:02:22.2523 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /97tO5aL84Za8Y3UeFmCzmOPTavRcQcNhDHjUpsraYVxmUYSo+K357299jJIIey2HRCOF3cp/FG7/UdQovHIp4MvChSgRnemsVEVsTNMsEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4662
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210620_200226_495072_C9A53157 
X-CRM114-Status: GOOD (  12.73  )
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

On 6/17/21 21:28, Christoph Hellwig wrote:
> On Thu, Jun 17, 2021 at 12:06:11PM -0700, Sagi Grimberg wrote:
>> Why not just set both nn and mnan to NVMET_MAX_NAMESPACES and be done
>> with it?
> Yes, I'm pretty sure I suggested that before somewhere..
>

Sent out the patch with NVMET_MAX_NAMESPACES, please have a look.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
