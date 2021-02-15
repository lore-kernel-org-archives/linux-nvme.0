Return-Path: <SRS0=Cnjr=HR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFBEC433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Feb 2021 01:33:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F51564E23
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Feb 2021 01:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F51564E23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=vWI4Bj615bFmefmqUzVX7j/z+QxYLaXdJ7X1ASbWNmg=; b=kzgUkpEE0QPcmsHYv+EMDAHNb
	5A/xrJGPRhBCzXW4ZBEDRnh/rAaxmuhSA2DskMZ+v34kejWgq3YFDaJ3HraX/cW1mt+dOoyq7A5aD
	EAjAyqYOuwKjfJFj+p+Zz5a1zEqERnK4NnYLNro/JwJL+j/g+qTo598dNYRexG3pUmSeGLZffNo4n
	jRwdZu/85ihcja/kKTOeqj3Bjfre7M4LhJGuCtf2kP9W/mI5vmVMYY1jRSd0sMYrjtu+moDEgAkRw
	eoU9s1gyo1CysXdFRVOagA6LuqQum/LPQacscr9G9VZdNf4OBLWHatoBgc6tFsNeRkDZ79sMwgPeG
	FjEhvYX/A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lBSlc-0008Uy-F8; Mon, 15 Feb 2021 01:33:36 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lBSlG-0008Iv-85
 for linux-nvme@lists.infradead.org; Mon, 15 Feb 2021 01:33:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1613352794; x=1644888794;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=LyWIInpYG+Jk/IQFp1rKOU2X3zFqe02HYrFgTooUntc=;
 b=S5EAKw+V2ZNwMeP0J6WHIJKF027GkJ0LyKZV4iTJkxZtEftD3RmBrfur
 vgDJTQMtos2VdZw110REGTbw43WuwTmH1sZMIwOBmI9BYkW82FSM5bqrP
 fAKjmYbCEcZ72e3YNUmRy8wYGdrbhqw8CvSJDRchgOnEpne62WIJTMgV9
 KUw7nh4rKNQte5c622jfAUw7JXcPbXU9goeWMYtIvjwZFJCpollqlBj9K
 0Xg9KCgKTk1IWhzDJ5LtENuRBLHo2TmCVcRkT9q5DiYxPypYHe5aiBRnz
 GHCBDk1k//3V6P0a2O2gw56dNU7TbEhDQS+5IcsTmmzljfeF7tglOolQR g==;
IronPort-SDR: m6IvudZHid7WZpKrHmICm24rw7oszsBd8gv9dn3t1793zqo10y0hpDEh9c6C8WV6SdNX9lE3dP
 /9Ej2pa9t/ZrAhIGtwkdmqEo41inQUYilQFD3ZxUnPU3ay1Z+v7c3nwbTDxDBZd8GY/vgjsz1o
 /aipvt0xWR2bfuZ2YUUjjDifYvQ6ALeoFa93nTYXfMZW/g26j1wEXVmQvPrAYcif9sywk6rGcl
 /+VD5gzkkx/KtTxNiw7iEbcXY7diAJ7sokqpCn+zyU5hhBUbIBvOTDiSm+Bhjr0ZKZogoFM/WT
 cZw=
X-IronPort-AV: E=Sophos;i="5.81,179,1610380800"; d="scan'208";a="161124638"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
 by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2021 09:33:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcGPz3Pf4HqF4ahFDJ16lib65lf0uxT5G8YasTrfFkRTFM4TtSNzWRbYzrsUQlOISc6BuIEF5oWCji8wdkY5mGdruLG2pRvDTWea9tW4Exy2Cb2tin1REfvJN8zbOy4IwQkSEZJ1fNREBHNw0c0vef+L5073uoE3pPKK8l5ZaD9yxo5ijwSLo0iZjEzIS1OiilkuLAsQzvEVzzLMcmNpsjGWEqSklnshsU2D3IpZTT+KsCDtzeLBxJrj0YsGtOlAt2p7xMf5V56yg09OVZr+ffL3PWvL3tTSx2jJcR4kd1ZaT2IWmIzcg1OX/STjHB+Nuwh0wp1gx2zALtAO1tOaTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyWIInpYG+Jk/IQFp1rKOU2X3zFqe02HYrFgTooUntc=;
 b=DtnAB2sImwXCvttCOlODV7dNR6i37IkEVCagc5SJNG3CDBa0bT3DsTAkRiC2E+bObNTJFYIznhclQv68pY5FP6lnkM7bqjk/WJxFAeEDOgkckN7vY4X/ixvk4Yb2ZdZjxHTo2XhRvSoDj2RXSFx4CGKHa5QHTZURqFyFRp0UhzGYWeZtfagiOA+/L7CmqbLXBvxXwaTe5MK/QZxneeKTVuSsErIsd3aTaXG7vEEteCIc3oQ6jhE/Dynr20zBVLAI/2sGhksQOMDP/vKTgBG8g3cbIQCORaKSIPSMNHrc/OQwJ/yGNAxUj0xx0mhxRcPf707jcElSws8M30EBP6Ld/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyWIInpYG+Jk/IQFp1rKOU2X3zFqe02HYrFgTooUntc=;
 b=Wr81ISzlaXBgEwbBMm/lWCvZHxyuytJwVqiLo4t094Ep3MrcXpnrhkJ118RiDsypHVRqJhoAXadzy+YriBVmM1CzuOx8A0wTC4jeN5RT/YUEGxMNOsx/VJcvJ5evonWGMZozncT+2wZq7B3ebwyj3qyiK0ZAvqpFLVao4WzJhms=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6246.namprd04.prod.outlook.com (2603:10b6:a03:e6::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Mon, 15 Feb
 2021 01:33:07 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3846.041; Mon, 15 Feb 2021
 01:33:06 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] nvme: resync header file with common nvme-cli tool
Thread-Topic: [PATCH 2/2] nvme: resync header file with common nvme-cli tool
Thread-Index: AQHW79UzK8NGuoKv90iUL5zUL8kTvw==
Date: Mon, 15 Feb 2021 01:33:06 +0000
Message-ID: <BYAPR04MB4965D9C2B54B8B01FEF26FE286889@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210121090948.8027-1-mgurtovoy@nvidia.com>
 <20210121090948.8027-4-mgurtovoy@nvidia.com> <20210127174717.GF28180@lst.de>
 <BYAPR12MB349445BDAFCBD9C9FBC32701DE8E9@BYAPR12MB3494.namprd12.prod.outlook.com>
 <20210209153503.GA8607@lst.de>
 <BYAPR12MB34947F0C352E4035BAC258CFDE8C9@BYAPR12MB3494.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 98894d45-7afa-4a27-f986-08d8d151a55a
x-ms-traffictypediagnostic: BYAPR04MB6246:
x-microsoft-antispam-prvs: <BYAPR04MB6246B2BA3DC677CD5795AA1386889@BYAPR04MB6246.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f6RmGJhuTOMD/ibT5h4Whplv5qZsxDclBPp6zF7DysHsfMS9AZ1meZCVol0p4vpYDM70B1rPF3rrR2eGQ2OO8KRik1mM7KCf6Y9+6uY4b2ZZEkSk/mqyMWV5W7FoY004G1ETcxAYhpjGhMS9xK5ssSItKFKy5VRYp0aF0Zioe1Ps4qAUQ6FYymsx0YcrHBeiPFISGhQaw9G97gDYt9efLgfk4RMywQ4CVvr5F5V4fcloktA6EJGgNY122mJYmesBWJoiYAeEF1dfPM+hz85If6SyMxNbYT1PcndjMoFxftz/2fLmkswg/9gJC+2bAeeZP+t1nI1Y75hgdtdevtgKkFJhP65NKs0GNovChqo99jA+NB02bW4oP78U3/SDEu3aH0AzJfWF2PF+OJcwgnlWpWEVhFju/IRRRTVJMrA9XPbUhA8TQZUz4x60TKlua+NlS61vwgAK6LYacF+WZiczWJAZjZ50aqq05ZkduTFEfwS9hX4aFrFr4sTMPeOp89iWjyc8Y7nhG6/iR9NSt7VGQw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(8676002)(5660300002)(71200400001)(2906002)(478600001)(53546011)(6506007)(52536014)(8936002)(7696005)(186003)(26005)(86362001)(4744005)(66556008)(64756008)(316002)(66446008)(110136005)(66476007)(55016002)(4326008)(66946007)(9686003)(83380400001)(76116006)(33656002)(54906003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?P/jHTuuTDjzSR0t+1BUfjTw5Pk7iXuXvjrWhXr0W+NzA3XfZHKJ97U3hxc7V?=
 =?us-ascii?Q?Sk2VUQd/0unG5Wcn2UuG3YhZv9utVN9DUfJWENDh6QUa8EQln14XQqOptssX?=
 =?us-ascii?Q?Wjklqy96Ns2ULp3W75tebeoFiHeYvRyzEK9bD64gxJfGSC0F0MRWuXOW+s5h?=
 =?us-ascii?Q?Ao338jnbtUT4XJNKb44QpONa8DxiR0dW4GrPXgGXs6xCyFeTa9/b63wJAIeO?=
 =?us-ascii?Q?fAj8AvWJtXKBavz48nOCsezTz6/wGEbf/Vc1kJl62x9EczzEjPGH8MxIDZfA?=
 =?us-ascii?Q?iXW4FKXbniem3zofEKoDRh8wkZ/FZlbS5ACiv6VY2YO8jbfDFEudf35vnyum?=
 =?us-ascii?Q?peAXzE5SyD4sYJ/6k0Vbr0jpA/cIV0k0yN93HsNrYuH9qpY/2nugmLA34fpR?=
 =?us-ascii?Q?aNAt/vRNaJ+N4efs0BsJt9Ug5Fyeq2Ptj/wpMxBBQm86mpR5yRWhaopiU/+6?=
 =?us-ascii?Q?hm8JZ3zy+RY8Zk7pwFYWj/s6Wn64/KgeoG3tUyGPkrZ1HOPgEtGLc8iQQgMs?=
 =?us-ascii?Q?Hicqz+cdFTZT/7n806ZNoILrGa0Axen8HkRvdu/bSuXI9Jl+HbkfrBym0ctd?=
 =?us-ascii?Q?DtIuH70pi6DtoIfW6q3sYpyqsVUr7zkA2qjfxyVxXa9d7S7HuIqQUxUYBi2e?=
 =?us-ascii?Q?xc33oAXsZqLlmMnRRxWZS2SVl38XXxMEzguAhTGUT5wmddHtDQZ1Y7KiHRXK?=
 =?us-ascii?Q?Buxz+cZvmxL/tFt0i9E9Hs9XOqJSrjb/FRfNBDZ1qBUWXdNtVgSTVxHyN8I9?=
 =?us-ascii?Q?O2mGIv/WyI8q3ydHvwB4ljLWEu6JF/SbeTSVzQSFIR4+A3tLb5n0ifGEZgvl?=
 =?us-ascii?Q?yLuZ9pI0YlfKChM/fi7xuJj5O9IXizJmO4D5/JFEmno7XYz/WXjY09NiG/iY?=
 =?us-ascii?Q?bBPG7OwNHEHDsUGBnPQfn6aHGhcZnfmqVxVLrKGaUBPt7F8jz03sq7ESBNNO?=
 =?us-ascii?Q?A5v/MSP4ElGpgVsgpHLdhSYlVxRGJKFxRmQBmqMtQfh0ZbGMoD7ppUJch/0S?=
 =?us-ascii?Q?UZA1ON7m08x0zQbux87fxDfw09yXzewZj4i5mFc1vrRiKwnlZ+2xrNE2sDjc?=
 =?us-ascii?Q?YuAfkWV8PIciR9WaK9S8htbz16X6sERB9auhZnPjqUPBU6S3VG+a8a5ayIEu?=
 =?us-ascii?Q?t/C+TCa+vWeXQhMB17MoRszIOlbEB/KK44fG/NHGjwRj1hpX7uQGYFgG4Vla?=
 =?us-ascii?Q?OaxCgd4ybv4xBpVfX+tyKZOV7ArSms9dWhLE470pgj80582tCDE/oj+jrzJw?=
 =?us-ascii?Q?mZwlEuJ9h9ST799BdK6G/JTeBbq9Z9lFtFlP2QXjQCfU+zr1c269ShH6kI6Z?=
 =?us-ascii?Q?+iclz4QnronaGi2diuP9Z8Zz?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98894d45-7afa-4a27-f986-08d8d151a55a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2021 01:33:06.8085 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SvKzMl3YMTRTa/fLGL2+cg816ixjNXD+WrmMX9W7CYfh5YKGNsja93Z44gQMbnHkzcbGL+x+FsKTyD9ckY1b2kHODm06LhCrpyEgCJE918U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6246
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210214_203314_627671_EFEB3237 
X-CRM114-Status: GOOD (  14.78  )
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
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/11/21 05:02, Max Gurtovoy wrote:
> see attached.
>
> Btw, the nvme-5.12 is not so stable.
> I didn't debug it but I couldn't establish rdma/tcp/loop connections.
> So the attached was just compiled and not tested.
>
> -----Original Message-----
> From: Christoph Hellwig <hch@lst.de> 
> Sent: Tuesday, February 9, 2021 5:35 PM
> To: Max Gurtovoy <mgurtovoy@nvidia.com>
> Cc: Christoph Hellwig <hch@lst.de>; linux-nvme@lists.infradead.org; sagi@grimberg.me; kbusch@kernel.org; chaitanya.kulkarni@wdc.com
> Subject: Re: [PATCH 2/2] nvme: resync header file with common nvme-cli tool
>
> On Tue, Feb 09, 2021 at 03:07:05PM +0000, Max Gurtovoy wrote:
>> is this respin still needed ?
> Yes.
>
FYI, I sent out the series with Max's attached patch as I needed that to
rebase some of my work, please have a look.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
