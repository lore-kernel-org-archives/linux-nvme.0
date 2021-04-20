Return-Path: <SRS0=/SuC=JR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3E7C43460
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 01:35:54 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 082F761221
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 01:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 082F761221
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=7ua5XsikCOa74AsLPtVss065Fjy7y00wSzsQi1tBOQo=; b=Y/cllvcvImXeaRzxNYkJc8ygx
	+ErUrYetOcjRkn/QOlu4VVYH9uDN6fkjqlRp3jMJ3k+36Q7DXBiHyBKqFQD48WInL7bgIaSxaKPtY
	gcSib0HFcPxLMxcU6/DN8LEAd/2Jr3yriNohornNjy/OpTvw0pJcD906bN4Y4iXeUWcFDrdVeoo1A
	6Zs/FGIOdu1tFpv71UP0jaSjqpuOmoHFm4SgHHY/IiKiQ3Nm6GeXNUUMVhaERd/bLnJ1gA0mdNA9y
	qfYkW0LFPRcVe6p4JoF8EMK81uSPLl9s6FeqXGEVbH96DREeXa2QLazwncUE1kvCgxmYmqgpaaRPW
	256hKOIuw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYfIe-00Awih-IL; Tue, 20 Apr 2021 01:35:36 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYfIb-00AwiZ-7e
 for linux-nvme@desiato.infradead.org; Tue, 20 Apr 2021 01:35:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
 To:From:Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
 bh=1RBe2ZodpWE+zI5BEcX4tGpmZyQrkrsJK9u8r1d97T4=; b=KCgDmiKeMY45EsigG7wCLgrbp5
 dpeCVG8EU3wWSBr0pHFfet0lMVEY0uRV/tkvieK9ftnjWPQLkgsNLouKWBylsQ4ewUBRGsTINkB7C
 V7WGyyLRdxHj2SqdxYb+8hbPF+DRN7apuKXDYM+11v8rskVCjg+YVnXs8veN/UmAX6CtKhRUevUzQ
 jTFrNWi0aUXO0cG5a54msIi0r1or/nkDMlSkJ0zTV3+Bd/5bs07mVNGaEOjHCLouX9NRxedKdbozi
 S3R7M7RAneRojefohFdMPJOSBXAuYtLgXC+2eVJP2m2x0CHng/kIJvnWrlW33ypuGFprf2Ea3Z7BD
 gXZ+QT0g==;
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYfIW-00Bl8V-2g
 for linux-nvme@lists.infradead.org; Tue, 20 Apr 2021 01:35:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1618882527; x=1650418527;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=1RBe2ZodpWE+zI5BEcX4tGpmZyQrkrsJK9u8r1d97T4=;
 b=bqtvKj03t6v05JU9fpydlSSsG3zdx5ypLUY+XMHr268IJxZCKJslYTf/
 pqdTKu5Bwn9Bd5eGTvTS2/9fOHURZHTysT5s6Foc4nS7LoRQlAIJruTel
 OLPA8R0Z6PZ8d79LLuK+4kAncj1rl6UuOwxrfoRPgU7qVg9N501Oip+Dm
 ZU99hC22VcPLc0//RED5WUPB7e4WjwSfTgyLLZwcH8NQx+ynCklqPWPpA
 hiZIre8dTUPQxKcT+Xf6E2YsVQq+eFbO0rCx7JcoWtPvpEQdr13sOAASm
 pO7E14nP3DqF7h49EpeDu3+vVN30PeH23OPNDfhRHZy3TJWBmWhMCbcJ8 A==;
IronPort-SDR: lq3hOnSjbfl602vcd8q1ccLg6lvVv6Y6lWpbiymUa/mgilnlv94PMoN9UJz+N198SI5jRWZjty
 P52rfab5tPiqVVqT+/8Un6aGsMHVD3C/kukTj4TM0gSwOw0YtfG/HmRgmnIE0GIyikOyw7dZ80
 zZDvUWKJbajZFgVVFbWauI9cZkTL+hcNfygpL8Ch6VIZoKqtCmPpSqeVD5rqEQz6Gc1LNY/UxO
 gg9u3yz5uennl4V9UVFz/6YIEO71LT2UcfQJtej8PpMHCeb3PwNPQ3uZxBHeeEzpfL+w7LX2pw
 nGc=
X-IronPort-AV: E=Sophos;i="5.82,235,1613404800"; d="scan'208";a="164838428"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
 by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2021 09:35:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+Kzfh1v2OZTgTEySx3mQkGb4w0IaHRXRYmQ7uxrL3ntNv/Vep1NVtKVi1a2uUyT812PIWFuhykmRYsPyYyoEqeKS/UYnN718/bT04wsc9BZ/8gTh1AFHCRII6T+FCcwABfDlkTALSMmoixeyzCbVeWppnem6lIliscbo0PmJn6ZPK8S1XTrBJJ5UBztghF/B4zSZmtF7UUXlsLNb5Xr0ZmQXQ35UgTD3DC/BqVs0RW7uPkciiOhdabN/pyY16HArp1ihNc0C4Xtnf0rlywl4mgl/YPVNx/5YMeIpGi6JOh9WDgMffga71+xMQitv8SSdPZ6ywXbSVM40/1YtKmp4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RBe2ZodpWE+zI5BEcX4tGpmZyQrkrsJK9u8r1d97T4=;
 b=EaVay++TpC/4EkiZkfh1JMTdW9ZtpoSiYChwrjPtCwupb0pLc0iNgcGUaxXjwiKDNB9vUHo3b7ILHAFoxFQkrLH60LP4EOoBNlpbBJ9i9k7EPFv2cgLoAPB2L5WM+2zB8LW2oY+78TmBjBwRhD/gHc4D85KvLrWmNdrIB3DITILDKwJ8UB0WHwuCir5XP1AqPxhJbBzodU9UUIiiZaRb2IzzYKM5mG1sAyH8RhKnYVhkpoNMj5/iiDJgDoZPcwrviwsyfCe41oRnrujXYOb/Twk/P2KpDvQXWW/VhUMDMF1oR+hvWnaU/3u2Z/jFHdmyamY47z83mSSpykBgMcpU+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RBe2ZodpWE+zI5BEcX4tGpmZyQrkrsJK9u8r1d97T4=;
 b=mjXaWre2sQ9Ra3MoUAL4NwWfkcqymuI0sbZFcfQ6eodjplrFQrkNl1OWS9DXN/VkfXGefvs8AuBp8NArNov2X3dXbc0oa108Mi1FVSE4QNPvNDkd1p7ElHfqrvlShsD7XtcZ44F6MFCmatBUcgVOK/EJvWCJbLXatnaloyUVpNM=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB7008.namprd04.prod.outlook.com (2603:10b6:208:1ed::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.21; Tue, 20 Apr
 2021 01:35:22 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78%3]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 01:35:22 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: "dgilbert@interlog.com" <dgilbert@interlog.com>, Christoph Hellwig
 <hch@lst.de>
CC: "dm-devel@redhat.com" <dm-devel@redhat.com>, Mike Snitzer
 <snitzer@redhat.com>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "Martin K .
 Petersen" <martin.petersen@oracle.com>, "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>, Johannes Thumshirn
 <Johannes.Thumshirn@wdc.com>, Shinichiro Kawasaki
 <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH v2 3/3] zonefs: fix synchronous write to sequential zone
 files
Thread-Topic: [PATCH v2 3/3] zonefs: fix synchronous write to sequential zone
 files
Thread-Index: AQHXMzIUD8ZVvai2c0OhPeRaKpo++w==
Date: Tue, 20 Apr 2021 01:35:21 +0000
Message-ID: <BL0PR04MB651451976F15C55D5578C131E7489@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210417023323.852530-1-damien.lemoal@wdc.com>
 <20210417023323.852530-4-damien.lemoal@wdc.com>
 <20210419064529.GA19041@lst.de>
 <9a4d5090-1a70-129a-72f7-3699db0038a1@interlog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: interlog.com; dkim=none (message not signed)
 header.d=none;interlog.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:b085:266a:414b:c56a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bdc245fa-646d-4c17-52df-08d9039c9051
x-ms-traffictypediagnostic: MN2PR04MB7008:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB70086E344A5C589F191CCCA0E7489@MN2PR04MB7008.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U4bcyF1KlDCACFTH0byril27zQ/UGlodb390pXRKdqHOKZ9Ik6fBGNMsTW1NoOBgNsP7TWvmK1H+xE3ai81m6iTpUw9tTwlMxoXHK6VNgfad1FbKrqRhX72sRm2+RAVLAC6JaXucUfG40qyHBK4EuQiSxe26HMz9WWCSz3U563/Ep/Uxl6swjKDzl0sfWolLI6vUTV0iqRzOV0cigvI3h6tm5oqb+GeZRpMRjwYN4dv3LhjcsevAWUhlUZZ1BDmiemfzWgPq4A60Td2CeOBGKh2fO60Kw5deFnyTHc7UUNh6ZZqyoQe5NI7B38QtNt9Yyliz1GeucQqkvCF841dfT17c9eEd5/Ts0SYxNeGZCrTpgZRhsAIQz3Stkd1X0em/7TGToSkrKNXpkjuoSR6r5+EsXmavTwDldm5N41zPY8Vf85n4ZBliCGuoJvXsCdyZ3N3WvQpwlIMHx6g1Jay575GTlDaS8E7/KsSpEllLbP1nd2GJEcMQ6OGr+2MD09LiCDK0owiW1mkE9ocTxpdXpLJ8I29tNbkXmsgewuvO/QaSiPTNa/YNpQd561oRPAKYNNmQJA3OQavrr7Va8auzTBggQrSzcQe8IZvWpuadIWQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR04MB6514.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(7696005)(53546011)(6506007)(8676002)(38100700002)(316002)(66476007)(64756008)(9686003)(76116006)(478600001)(2906002)(54906003)(66946007)(55016002)(91956017)(66556008)(122000001)(7416002)(110136005)(8936002)(66446008)(83380400001)(5660300002)(186003)(71200400001)(4326008)(33656002)(86362001)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?3EStXqiTBffkjQ3C7PGe0ee+qwuJF51+Eh75DitD3c4i8yBoI2uMoi0Tm8vE?=
 =?us-ascii?Q?9g9mxdAmSxAmRy1khL/435XT67f836aywmXcPIdkPF8arDn2CRjUV++EzIbN?=
 =?us-ascii?Q?ZU9V8uWZRw3ubxdbcSyNCHv89rKMN+CX1eJNfh9zDq7foRkhOp9T5S6TOAQ2?=
 =?us-ascii?Q?dUj39MJ41/V2DVZHdT5Uma8pswnKbTRrAqHaTvC6k+Z3Xugb0ukeLB64ndvu?=
 =?us-ascii?Q?P2Le6h6XOVs0JouZ+72gfx54AkXA57Dc+oFcbeBvlQq04e08r6SYGCEhMrLX?=
 =?us-ascii?Q?A2xrj3Fbl8ywp+cKbUtLfwgYWkYEEYZ4cH6pK4tYLLs0XDVG+SWtwquMobnL?=
 =?us-ascii?Q?SemUuJFzJYkAN3icE7Ka3X3mzbD6l7FgaW3wEsZu2NcKo6p+SzbaC1EAlUbu?=
 =?us-ascii?Q?4rgtN7u4QB6tySiwgVGFR0VzhgxIrv9/n+oYf1/h2lknKGekDBDXchxSKqsx?=
 =?us-ascii?Q?AN1I4ZPXtu8Pb6e1rxUWhvZJO5+3fmW6irQ7p+1HSKhXNzsjYw51cUUBEG9p?=
 =?us-ascii?Q?6KVKD82XzTKE+tIDTUbrcDJLaGbAH0vAKHlc7XfTjGnI5IfGZDp5iB0ABCul?=
 =?us-ascii?Q?L2d3Epduxpt9uQOXR8t4dVRI70K3lX+rDeq4zVUUK3U/S/n5ucDN2A4l87rx?=
 =?us-ascii?Q?bAWrtNNCe1iUgR+d3Yh5i5zD+YS6YMwiKgAFrXL0Vwdv+pKEzLhvnK9ydtlQ?=
 =?us-ascii?Q?KO8TbJ9O/svig9mKApuRJev0oMvAEJJK99uIDFfpcu0A+46io2AHFRwLO36E?=
 =?us-ascii?Q?8/1HX0cm373i+lkveg+3KrkIlOm+MoWRjidqFPO6au5AFgiHE1sgORajTmI5?=
 =?us-ascii?Q?BxUnslTnjqVsToyErMvIK2B90lXOpd2c5cha/sEjvV7sxa/l3DHF+me0wWmT?=
 =?us-ascii?Q?GAR5tjG7oEocbyfR4S7P72NwX+yLCYJ3i8Wp3hc5/XYc2/khnRBDdRcsP25s?=
 =?us-ascii?Q?zF4iLvYF0QQtfDEhGiLQ9MproeAw/jXkyFNmu+QA468IpmEaxYV2P3WzdQor?=
 =?us-ascii?Q?g2EhmvAohaGCljcGiwjFBaIeUS7gqRjOGRbY6rewq8pzUbGmkT2SpWGtIwGF?=
 =?us-ascii?Q?upGHMVq6ZbeRwRymLmhz1iK1AL83nJ2xTEA+s6QSA6PCqDJBCVn0JayFaxqG?=
 =?us-ascii?Q?KcgBrnEIh77uGUHadF5Fw5b2xrJGxSe337jIXyXHnLlnFo2tSU8qJpNmhRX2?=
 =?us-ascii?Q?D2zg7C1fxP9tE/N3Y8S3ehfsR1340gPHo1dX65Irs8BdDiJlimS2aNL0hkqY?=
 =?us-ascii?Q?DbCfX4xqLMhwXT5j6NqFjcx9CHLtHWPjHGTJz2iQupHIoaq2cmkCfalE2W9s?=
 =?us-ascii?Q?xDjpVoS28bGbpTKZ0Diin6w854tQMrszLtpS0faNmf2+TpjP7tykD1doa43i?=
 =?us-ascii?Q?DGisWkobsht4kH9+WOUH2UsdiZSvzSmfY7RHU2J0n3UgfDj4nQ=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc245fa-646d-4c17-52df-08d9039c9051
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2021 01:35:21.9590 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VdwDmpU0srsXULzQJMEHRDRmuJMCLSYoLrXQ+/nBsUq7nAwfGOxV5lJwf97nUnc7QAsyYSaCvLrR59Pmi0bz5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7008
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210419_183528_204547_F16D5E4A 
X-CRM114-Status: GOOD (  14.44  )
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

On 2021/04/20 10:20, Douglas Gilbert wrote:
> On 2021-04-19 2:45 a.m., Christoph Hellwig wrote:
>> On Sat, Apr 17, 2021 at 11:33:23AM +0900, Damien Le Moal wrote:
>>> Synchronous writes to sequential zone files cannot use zone append
>>> operations if the underlying zoned device queue limit
>>> max_zone_append_sectors is 0, indicating that the device does not
>>> support this operation. In this case, fall back to using regular write
>>> operations.
>>
>> Zone append is a mandatory feature of the zoned device API.
> 
> So a hack required for ZNS and not needed by ZBC and ZAC becomes
> a "mandatory feature" in a Linux API. Like many hacks, that one might
> come back to bite you :-)

Zone append is not a hack in ZNS. It is a write interface that fits very well
with the multi-queue nature of NVMe. The "hack" is the emulation in scsi.

We decided on having this mandatory for zoned devices (all types) to make sure
that file systems do not have to implement different IO paths for sequential
writing to zones. Zone append does simplify a lot of things and allows to get
the best performance from ZNS drives. Zone write locking/serialization of writes
per zones using regular writes is much harder to implement, make a mess of the
file system code, and would kill write performance on ZNS.


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
