Return-Path: <SRS0=Oc5T=LJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A632C48BE5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 22:32:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 194AB600EF
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 22:32:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 194AB600EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=vIegUSZEWlvGmoP3iDsu5STweNSl6PML9EdsSyhhn5I=; b=YjDNR3KRvaIhon
	Cbs0mmjTzoH77CPRCKizismdey2Az3h7IW6DqMZZ/s4u3o8kt8bnxzHPByZFjTwIcILKQjsZsKUiL
	nu+FqU2Qg6o8yoRogmnpm2evUVKTVVrLzBri9o9HC3dET8CmEw8+/1PuV0OHPQdODiIFjdxonpU4l
	VhvTHugb0dgcCZnozQPdAMlRlV6txSe2OTofusLzjdOH83aiRnaJFtpnF6IqXS7n9qxU43TcQVGxa
	7BEuF7JlJPSxe1Vws3qwwXEQmn7RbgVQMIHqjmL+VFdo/nH2350ODlvjJRHJftTpvgfDWiMYwQX92
	YldBUwyz/x/ZcI0QNDsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltHb9-003a32-Fm; Tue, 15 Jun 2021 22:31:55 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltFL4-002fxp-M6
 for linux-nvme@lists.infradead.org; Tue, 15 Jun 2021 20:07:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623787628; x=1655323628;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=JJ5q/4ogI5ffjgtIKfFA4/fY3cqJCO2rwkXGsD2Z1cs=;
 b=btgzlkCzVRd3Yb56epQ8l8DUb7gr5AmcqOeYrjE1JXD69WDjPjxyFeoW
 jBSPrkCwxiyvupC/sRAVCfULdU8AnbDNrBJtsZ3K5YBBdOSTuQH+TnkZm
 bg0vPwUKDfE4CbkdIV4H8QYD7+kmNCzukPcwP4ZGjSqGkU6Mr3RB0XFqC
 aafQETP2eujwwPAK8BbIX1FIkVCakj4lDklGbz+cBtuWybA9CuzL1nUpj
 c6rBnjfD6ZewqyI8zQNsJXw07xe1Lgw+MatQRt9GYhpHE9roAcPD7PCQF
 VfdkBxxDe6fj7ypMPQ9ikho0kwo2+1iU0XhffUtyzNst1zTRpxFc7iOog Q==;
IronPort-SDR: vi9i9ZUSn8KOrbaZSC21vJopbPLmgkS/Wn8biasmhTAW20lURY69zcei4530FiZV4QjTxoBiBo
 SCndCmtEX+G8FEQ+RTZfBsbCSbvQJFKMcUrDr/5KEyvF4/v4xAIcSgOvVAHMWtZJ2iTvQ/63fe
 njEIc8aLx3PBIqKIf3woxyz/ZrTbQSkBeZBIqimOwdNzVdxBppvmXfKqty2e/cABvj65b9h3r4
 JRGCiawuqtybafJ5j6vf7pA+iTvnjBYZjt6K7Oa/QUDfnbOl9/kNeLXaJEK9L40mfS99iBYpFf
 bpk=
X-IronPort-AV: E=Sophos;i="5.83,276,1616428800"; d="scan'208";a="176797809"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
 by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2021 04:07:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5WC5aIuzNwNdv376Q+5ofChJYIwMJP2O6gK/9p2XqygcPnHDTh2TdIexcurrtzvbw2x1rAa5bg+e0K/V7CD+qbVFsBPqOxhJwvVKkA3BxgEbWIffI+BRFmOSXCd7fQb4UPgsBvPPUUzIe/jsPva0zmf/tQ556/NuPw4DOd3nyVdhCeCDN/NcTm6P8g5UbxRBaAigdfKWUgiDcWPd4bGTedvYOg2cajilqampVAfQdzHKxnamOZXDskRgQaFG3CAzMGR/51WyRp1oSlg/Y2or9tlee2+Q8fLoZJ1p64SxfLoFPtd16sXhEhA6F9LIuET14ogVmF/Up5/2DgMZ5Kpmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJ5q/4ogI5ffjgtIKfFA4/fY3cqJCO2rwkXGsD2Z1cs=;
 b=K3gl3VCHtuSqnycxBqAC6NFX1BgHT4jHDYrXJgmWodKonti05sEmVeiCd2/AeptvjnVLrIjXy/gjLTjuuMV3DP5FpMS9+ms0RLLCaDuzt3FofzPK6zKiHozTaT6EBW+LB3uTqxp+w6RzFlDS+dPHuRKMCBidctPiASltOkWJvpPmTmQeDJ1fwWu8m7cQTPolStynrLZxBhMGwpInIdQKVqazRCL/YxhB4Fk0KLwfDhFwHzncW1TMteXj4+/u+zqJAqmaiDp9SknqhK9eAQ2JxT2awrusE787sExTtDtHMTZdMUHdiOyaGBQBm3aZa5ePb51B3WNtlEHgX6dTRkUsgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJ5q/4ogI5ffjgtIKfFA4/fY3cqJCO2rwkXGsD2Z1cs=;
 b=lkYnXg60mJ4chlL+Vmd98jZ+6Aqe+EZ1+JugbxNG2S84S5H1hSmIaeX2VugwR+/NXN9OawmHcYvMego/lao2oyWrZTJbYPoMQUypftlzlScv5qVuMJwBPpkEeLxt7IEk5W4ypkoRN/CUW8qLV63Geg7DRXoboWUaArVninY+y4Y=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7744.namprd04.prod.outlook.com (2603:10b6:a03:32e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Tue, 15 Jun
 2021 20:07:05 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 20:07:04 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Keith Busch <kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 0/4] nvme-fabrics: remove struct zeroout memset calls
Thread-Topic: [PATCH 0/4] nvme-fabrics: remove struct zeroout memset calls
Thread-Index: AQHXYZCVTEyxjLjeN0mJyUd3Tp8hTg==
Date: Tue, 15 Jun 2021 20:07:04 +0000
Message-ID: <BYAPR04MB4965C9ECA762535BCFB5532286309@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210615024554.42585-1-chaitanya.kulkarni@wdc.com>
 <20210615184226.GC646237@dhcp-10-100-145-180.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 712e3a0a-91bd-4423-9a6f-08d93039257c
x-ms-traffictypediagnostic: SJ0PR04MB7744:
x-microsoft-antispam-prvs: <SJ0PR04MB77449DED9584B2AA5F7DA9C686309@SJ0PR04MB7744.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N9FNFvIZXzaEVMY90yBxKtds8oVOSw9GthhP8GqMffaokWRZKS4nLgnbKvf2+gaMYZ9nS8k3Zvx8aWwhMZF3AQ4qGvIqNmXZqhNg5aSm4GB8NAr4q9io8yl8S94lLsCqrVA3+KFb4Btb6kE82fXhsuuxI2P+S9M952GOdEFvJ70CHZ4G/AW89diwrxinlg2/JKKeJoId1Ma+wC54+lr38HnOFf8K5E3Wuyk9lEiV5vSAJ8ArUoowKjZaivH+RXtFXHO+HrOcXvE7EGfQTLX++z4odK0iFRe5h+qF3pxAaEUgjFeySQrmhEM1wPS7hs1Ea0RjZfaaNZnf4tuyCG0rUfj4YBDS4bxxVl5+/GyJgi7WTHTDQm3rx5qHpvx2kTXHmn2jXBniMd17vcIvjEfowImNUYIYTGWrJr37iGi7POiwz+gwvn7ABj4EpdfSLOCBrnxAcFbHgUlKsJw6z8u/TWKL4BPz3QjaP2BtdpS1YyxmpiJcL43R4qcbwv9XezEL6sok42Kk3jDrSwtxNhVOqGndY7mwIL//g8MooBr6BtfaO1asNvOiGm8Y0Sv2QqSz47+vImkfGlAm5mjVc9M3DR+mliRpapkLsG2Htj2cLZ0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(76116006)(64756008)(66556008)(2906002)(66946007)(7696005)(71200400001)(5660300002)(6506007)(53546011)(478600001)(26005)(52536014)(66446008)(122000001)(86362001)(66476007)(38100700002)(186003)(54906003)(33656002)(9686003)(6916009)(8936002)(4744005)(4326008)(316002)(55016002)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7apMgwoSFGTzQu0XMRQZeQvR9ituAqSUaBQGIWZkM+eVYGv6NSj2WPmkVYo6?=
 =?us-ascii?Q?wTSRmYxqyWyoPw+QIT7kFIzHpgVlwooT75cg1xq8VexGvoeoDtz+FEk4+QMS?=
 =?us-ascii?Q?Um9ZIpzgdWp1oOVJ7Xy7LNyETiRvPhyd39zYHle2tjsjedMxigcyfpftJ0Rq?=
 =?us-ascii?Q?+xHt966ISQQfhBsSs0XeZKB0uOrM6LGCxilxC82Bd7tOKAy42+hu2f/IGQUw?=
 =?us-ascii?Q?pClnEyZAlUlTXRnKxzUX76MQu1A5YmcmZC/eH92InO+1V9XdAClsAxv9TO6G?=
 =?us-ascii?Q?8B0fww+k9SMXeB5oG9W4tAC97vlrOkHHq0S+nYmixjG6UdBKntnDGaVN8x7h?=
 =?us-ascii?Q?urvkGd/nqCEowRs7dRUDh3aQ+HX1mQgvNzpN2V8PuVH1BzvyjHRJypTFFGzh?=
 =?us-ascii?Q?aFwAuICn7hFoyePJt3iEPBWn9nUx6bSStLbEx2a+AscuozLieoLRxAZud7AK?=
 =?us-ascii?Q?/Q6eE/e8h8eLNu4nBZGkHES4xIaz00I2wCXYOKxc0XWc086ko2dlYkS+XdB9?=
 =?us-ascii?Q?/u2VsluGqDeHnlE9xkrCSpsrKXWHsG6+S9/ZxQmT3KY56tDHhK5UoywaxEcD?=
 =?us-ascii?Q?m+djGoGwv2qg+lwtD4OUy/ND0ShqwGpKUNMv2lCWpzAyCQhs3BhKgl/YsodV?=
 =?us-ascii?Q?pHF1qkBNfyxzdiOLbGXUXK2d5pkGJX3pBMDyBWhoBfTEcWfGt2Mc5PdlEJKX?=
 =?us-ascii?Q?nXoUdnR3nj3Fomum25nb5vAQXVfCki6Q3que+WNlrXFTol0DVvjcx8HsKfu9?=
 =?us-ascii?Q?SFaRudZxTl/sUxOrsRA6oH8J8QyBA2b/OpRpd5FxLYbBNCruHTp3wT9ioukj?=
 =?us-ascii?Q?Ox8mdrwMfVEoRKfUapyUz9LxrnntDmEHck0YMLSqD/twaPS27n/J6TOM3GyR?=
 =?us-ascii?Q?eGpuMkb617UVGqYvOxfTbnNa1kfmb4Vl8WYOAuyOuAVi6JwMMAOTti+YqEcv?=
 =?us-ascii?Q?ro1M5wHglrHV6gBTrfH9gg41osgYPIoP4vC8NtR/iPNZq1tZkyxguaZ/LfYO?=
 =?us-ascii?Q?vkY9kFj+a6BE6E3HeiZM8AQ3np7nLH9J+YDxkLjhXDaZ4+mAs6wZlrwYz/uo?=
 =?us-ascii?Q?s6EL8reO5BMk7CbKI5geZg0aiqCgUF0qU/WZuXg9aHC3FhAxh6T2AMa0NNPG?=
 =?us-ascii?Q?rcjCfbhWpIsB39b6cWXaSui0PtOh2Y8wG3ye3Ys8u5lRKu1EgiMShQp00jRC?=
 =?us-ascii?Q?sA3ug7O4/aNKtd684hgjgSJwxee2OReM3nxeUIxrgfWBHP1QrpeKTCRTDBQy?=
 =?us-ascii?Q?t2tJ2QEGXLsHUvzzNaJTLrlM6eDqumD7gIPmTVOs2TvCeIzri8DX1kzsMHlz?=
 =?us-ascii?Q?feJ6G04hI5Fhz8/sVQAJxGv1?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 712e3a0a-91bd-4423-9a6f-08d93039257c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2021 20:07:04.8758 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gVUCQx3tqWKz6vtMeb7p01dUgbkONPe3uofqwGlMl5bqwxnDh0qooOSTQP+5f0uyTqnOX3f4fJDvKpd2PZZ/519YiZ32Gpt0VRtqGILgwrc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7744
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210615_130710_792865_FD27E04C 
X-CRM114-Status: GOOD (  11.29  )
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

On 6/15/21 11:42, Keith Busch wrote:
>> If this is accepted I'll gradually convert the rest of the host code
>> mainly core and pci.
> This looks good, and aligns with the local style. For future cleanups, I
> think it would be fine to do it a single patch instead of individual
> patches per function.
>
> Reviewed-by: Keith Busch <kbusch@kernel.org>
>

Sound good will send soon.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
