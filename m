Return-Path: <SRS0=2ZV3=IG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3EBC433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Mar 2021 07:48:28 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D67BA65132
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Mar 2021 07:48:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D67BA65132
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=BwJJEIqxmkO8RbgJESq6v7rR2xVNnJdyABJAXDewPCk=; b=Hdizhuo3RrNZWA+oOMzmydrTi
	FptsT2vYGbVhzuMaTj3vrYL3imLqi5zleZo1awX8QZA8CBaToLLSYsZGM2UR+Juy7SIcGn/7R/mew
	XR3R+Wj4Oovh0RqaF3x+O9nKtvDp85oXFiBDwWE1E+NY2ep92m/r4fPVndDN5tCEszGGVHnGinTf+
	Ux8GTy1susPrFa2SsY31ek+Fnee5URCZHXztxjBppFVtu2k0TSs7P41T6b7KsJi+0CAm7OqZB0OJi
	vBxMj8AUpTuvTsksrOTHB3p+BDeDqNfAScQO5Z62m67ghKG8tKot4v8QzBX6G9nwdr5WwRR1on2lu
	4QWJs5kuQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJAce-00FoXx-O2; Mon, 08 Mar 2021 07:48:13 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJAcY-00FoWH-Q9
 for linux-nvme@lists.infradead.org; Mon, 08 Mar 2021 07:48:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615189686; x=1646725686;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=hAqiX5OJqX6YiupRfdULK1JmN2AUbGwVAv0s4f6DEVM=;
 b=i1P2PanwojqXWbyAbcPbLOLcGQdkBzVzwoA2azywVjyobsNgU1MEw6G2
 OXjkwL4CaLMO0hc2NiHGlWpkNhQPUsKNVPgVQi2PPiIxA5gU4sqGiXnOa
 dHQpZvrjiAmxaRK/m1pLuJipVi+g04cyfaJEXfwaWwmipayAuV3Y3PmCe
 b80UiUvTx7jJIkwUfisoLy89nhlOlzvDglcnCRDfzMbL+pCWx/ggUw7nt
 4GqdNllfoLYjj4ztC/+9aoUlJWZETx0YRT6wDcMNpv1Xui/KwBjEGcU9P
 9Fodr0yJiyw5hEqMwq1QrW0FaBK7Y0ZdnlT7r3TmTh0Vzq7dopv2rNNXT A==;
IronPort-SDR: 6GvgCb2c4hrSNoQUBkeU+n9p50aCQJBZ5vYmPPCjJgXMWfEnz+rBRzEHfxWXkt09tzH27dBP8h
 35xdDV7SbgrFh4Zmn/PUrBANkHrFwXMH9QivsN+YXIFeicRAmlUJKhR0c1l4qy3kcVqPbGhx04
 XeLrGzeYDsbNtW2HaV708VJzgM3rT/H2Ng8YYZICscLilS2ZF//Fg9AiU3QKEboGGVL9unkC5K
 ir+tRp++t+gwQi/3/ymHxGOuGcvDRBbM8XGygQWCCVTzta6ZUPNTyDxyHaPiBZsfJTHmX6D9RA
 Nag=
X-IronPort-AV: E=Sophos;i="5.81,231,1610380800"; d="scan'208";a="272255162"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
 by ob1.hgst.iphmx.com with ESMTP; 08 Mar 2021 15:48:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0gYpXQmLot8aAAHrmY7Ys7YBlswJggZpq0O1j/0GdP3ASFmBd9Dqcgr9iTyd//Y21ksSYML41o62x7SzBuXFPaq+F78yvcF1RYrZzgMEjvMW60I76xJofk2GUWNtwehyqdBzN1e4KYhGj1lbOBo26jNIsb2srqurSjq2mNVy23owEFU6KTkqBPiV0jRWAuHoXvN8foT0xw+ftqATobrTGhK2L4AEAT+YyyPats12G66I7ZIqDl8UszEY5f4CWYbpJWonTbzhpOfpFqohqgZeFjec/D3cxwG7TnjW7nvFm8Fi0nOeotTB0HX0Q0nZluODsCLX0NX5OZzdE61sk1VTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAqiX5OJqX6YiupRfdULK1JmN2AUbGwVAv0s4f6DEVM=;
 b=YqQqgSfol7qJD80txePRrlVi6/OJ2DyfiDXRmrDqW/gC3h7Gk7hPvTuvdCadQvzfI0xIST75RWjul1nQVnirlnOiNYT04s4KuxpqQm3vTdKh9dHrcUq9DRKVM1XS1MywxCjKCgwVHO9WW2YMIyQQcYVh850BakfYKyRuPQwbDPvZ/BnqTuN3u4KniC3UzC0oa2gv2TITHxy3YCvgpwbZldaYYy/wbOPxbHl6LzHNryXsaeXhdL2yuI1iHfAqd6r425CdGabqpKoXix1z+6+SnhghEGTTgjEWOun/bAUzQ6y4r94XIPgqt9NyEMxjTj07nUPtycuRjHWH6Csd33eq7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAqiX5OJqX6YiupRfdULK1JmN2AUbGwVAv0s4f6DEVM=;
 b=lOhOAmKw9JRKolwnUvcTkcaAJ+zmqrOdfndH5h6gbHpMn0vvYvDLFdUc5kCCQC6NM2kfme0Lj7CByz+ppPt+el0qEZg2HCXtsWdG2uj65IpqkFxzL3s8v39jfeYn4HUbHhiWeq6AdjYpM6f+BjixsHJEDHE+MMOllkMf37YoM8c=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7456.namprd04.prod.outlook.com (2603:10b6:a03:2a3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Mon, 8 Mar
 2021 07:48:01 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3890.038; Mon, 8 Mar 2021
 07:48:01 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "tasleson@redhat.com" <tasleson@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Tomas Bzatek <tbzatek@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: libnvme questions
Thread-Topic: libnvme questions
Thread-Index: AQHXEJkDKinop2xAF0e5sqK7JXt5sg==
Date: Mon, 8 Mar 2021 07:48:01 +0000
Message-ID: <BYAPR04MB49659AB2C657F8D82348969286939@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <245fc813-9441-56d8-47e2-4417fc1f87e7@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e6327bc2-ccdd-4f98-66b3-08d8e2067fc7
x-ms-traffictypediagnostic: SJ0PR04MB7456:
x-microsoft-antispam-prvs: <SJ0PR04MB74567410F6AAE181E8FC629086939@SJ0PR04MB7456.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /uCEkCJVMuiR3GJWIIPBi9QzP1RPCPq1wt/mmPIXGZW5xxtRF9nWPodQhGGgQNvMTLH68PztME+/8rVkjPY6gcDmJgHJ+B+qwCNrpa6n+1VZKioEI1ZiPwsN4fOMlSgJ2ouw5WokxCss162MFsjW/3R/i8ihQ7nllCQvYK79GWeCNlmsPd1WI+TIPrqhW2R3ySbECWUKClpIoprl8bpjNXBMOz+Bx+k6Reg9dpvN+FW2+DNJSTnSvDNUIGXNqEgaywnQbqS6wlBomxqOMoGTGGBxtN5sWoUkeZNnHxCjccxLXDtvJJmzHC7iGK2ZIipw6dj4YNrGDIz4J0QP5Szju538vN62g3eYTn4SkX1RZB2+siaLyjg2Go3eWBpb6DJJWsgYHN1839qiq1ijKRnPtm7SiyjyE0dPiiDyMXBV6EnkXfv334EMAzuRc7kek3SUfusMuYbKAQApRmMXBXf4C1KOl3oZgT9STsIVIia8d1ZehzVq/AkFZCgsyX7U1i6Ixh0hMln1HCuraOMKfK/8ug==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(396003)(39860400002)(346002)(136003)(8676002)(52536014)(8936002)(9686003)(71200400001)(55016002)(316002)(478600001)(66476007)(66446008)(64756008)(91956017)(5660300002)(66946007)(66556008)(76116006)(7696005)(186003)(26005)(2906002)(110136005)(54906003)(4326008)(7116003)(3480700007)(86362001)(53546011)(6506007)(558084003)(33656002)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?5tIbL5C81Tb4vXUeS+RloI2xSXmn74fqNd4UHyrRLNREw4VgkgEJAJihTH9E?=
 =?us-ascii?Q?YogpyBSNLroGPycEsZ6jI/q7qmJUJBYKbaFYDCs+SB20gbWA27emD/f7vtbV?=
 =?us-ascii?Q?Y6lbU6T3+19OdUnl8xtOvNl9jj6Q08mqC2J/xa9Uxrn5kVJP/aVViYNehrbZ?=
 =?us-ascii?Q?gioL6naTqybIqV+qZGueP1jkrF/NuyGb/3TPjOk9fzajHoNa9Upz6keh6ezO?=
 =?us-ascii?Q?xDzLFo/WIXEScQWX5XV25XWV6wIgQDPLgpyO6GfIYVqBRk6tv1uMORctVOcz?=
 =?us-ascii?Q?Hr7vgAoBFfXAdkhIJ4Fn9+5PKRatD38lVw/YJhmJ8E3twycJ+EBdft6z2tF2?=
 =?us-ascii?Q?AhB4hWoRT70/N+nD4Vz0hK4owOR2b2T9CAuylk/o7fu1Agu7kugXLrXmmecw?=
 =?us-ascii?Q?5gjq+NyGiOdsQBxkJzfkD5c0+Uy6cj3jcNdv493P20rndduSybtSZID3peXl?=
 =?us-ascii?Q?OAgU2JAEn2gWtO/o1RLraRkbIyY1efdzrKliAT+3Q1110N7lv9Th+/v++4HN?=
 =?us-ascii?Q?FmhCPTq967xFzQmxwKzofAf/noNWDBHEgp6CkjDCvs3TKWCxN1UbASfV0IoJ?=
 =?us-ascii?Q?FGKSBX0+RmXVQ9XDyLAZgXr0yDhkqzpPpvB9r1KhE5PbqAkI+9IsAAZJZSLC?=
 =?us-ascii?Q?D4CbRsLmU/cH4EFxrzvz4bGq5+dZ5OmGE9a1QJScmefV/cak4uiISshiFYFi?=
 =?us-ascii?Q?/Z2lTXLrtXOJuH9PbDxBXFX0l19mMR9nJ61umMHChoTVhwc1jui2Iq8T/obP?=
 =?us-ascii?Q?ibdgooyVNZhW3TOU41oxwEWdi2HkZB6rRBw8qZxMcq50qo9l/q1FUwL6yeUq?=
 =?us-ascii?Q?iq8ahV/fwNf2Vn+bs92fQ+makbM5JTVP/qeu16K4xiw7h9rHGHTxprAxA2eT?=
 =?us-ascii?Q?c4VLsKXZeYFhObLRaDOMXJ9L41S3QZ9trq5bgPT8QTjIwDK33F0rJKq2vAEV?=
 =?us-ascii?Q?I/9merSGGhVCbZpL7FlDLK+QiVb41PAaFU8SOIH7W3bMD6HM3W7OhzJfsUaS?=
 =?us-ascii?Q?cQRzl01YnF3vKtLuMijWyuXIu3Mldg0KZ32dY0ITenIxUBi07nxrC6l8SamK?=
 =?us-ascii?Q?3Eup7cbsP3+b2nPzHGMcB1ImUu3FHsnAgRwvUuVkm+pZghpjzikEcGO+SykD?=
 =?us-ascii?Q?uMzmoBO2x9Fw+EJ3n7bgBNm3eFSzzox0iJL6Q+SQFY+3P+ltgnss5ECOUPnk?=
 =?us-ascii?Q?u2U8Kr9zFrvspuRpOX8QSET8SvBu0Gf7vdCErINxTM60E22mcw5SQ4mmP2D5?=
 =?us-ascii?Q?gCCQCSDJM+cuStmgObmiWwwYLg+Oc083bOMiyGtuGS06WNU0D5G4q+GAv/oW?=
 =?us-ascii?Q?aqVIK0BHNNVu865tUYtXgt0M?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6327bc2-ccdd-4f98-66b3-08d8e2067fc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 07:48:01.2531 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SV9VmNt0tmwl3gphkhfWUMSNYkXnKQyfcFCjj7x/+uxz/uGQOJTe1+JCj2GprtEgSP258qsnqD/w8i1MJ/z8lpxSH6AdY/MfUI3oVdhMcxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7456
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210308_074807_427168_3E59CD0A 
X-CRM114-Status: UNSURE (   8.62  )
X-CRM114-Notice: Please train this message.
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

(+CC Keith)

On 3/3/21 17:52, Tony Asleson wrote:
> 3. Any plans on adding functionality for NVMe management interfaces to
> the library, e.g. NVMe Enclosures?

I'd add a plug-in for he nvme-cli named mi if Keith is okay with that.

Maintaining a separate utility seems out of scope for nvme-cli to me.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
