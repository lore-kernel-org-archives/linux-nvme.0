Return-Path: <SRS0=/NUg=KW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3492FC47089
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 02:37:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D47D061186
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 02:37:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D47D061186
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=Irnp42gNCOfWugbznrTi3O4/ELzlGyRcdGh/a0kFCsc=; b=pajyuTSz51umjk
	6fgec+Bk98zdfCeMQ4hUS55lsp+0UiXZrS0oceT3oROr3pV2oydwi6mwMAcZwIYZR/2Z1s8GzDJxu
	CZy7dwWDwfZEYPlZ1ijoBRoXPNLQC+r7iZslvAmsOlv3kWx2XLBp0Z5XW4tFq0hTWgjP6/wj55BIb
	yvN2nJ5V0hm+BoH2j/FXQx8wU7KV+pCdrJLLZspSBbI0Mst0yG1qWzM47rMVS9uVNwsm2aY/VenzA
	p89Mf24AO8CpdDaZhoFrOnH158Pufrm+92BdDOx6QItukI+iXeDOswSCMvLZnirGwKDhXJVqH8nGc
	i8eJdPzslnSdRDK1FuVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lm5tT-001pMa-O8; Thu, 27 May 2021 02:37:07 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lm5tP-001pJh-Uj
 for linux-nvme@lists.infradead.org; Thu, 27 May 2021 02:37:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1622083023; x=1653619023;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=yPUIeMB5Ri2bTpI+DHPpvPd5a9Sm+QT7HZ7HX8k+gXU=;
 b=neCuUDaActX9SRKgIoI4QnXzzeoUnA2jSgThcOuf31gGPcqXq7eEEitI
 5Y7m2m1bEcAetsZWdKUO88/qh1AaufYlNzQUDsIP8okzfu9nYNm9GL7cq
 s0iE7tzqQyUFjK5SsQazN1PC3/Zl1Q7vw0yewzhBJz5+G5W4MbAcenA4c
 iX/AQMNfpfGXf9t/mx6u+lrt1xQTt7TvBmsgFQsPq/2EUMPy/vwAQPJGz
 63g4vCb9F1X2O3+HVbNz52cgz+xBF3tpk0tJJJ09grOIYGNsR+HgXNYFT
 4qHR5u2oU/nKSDaNECHuX8gMwTiQN3tOQA9M3rK+vSfp5s2pbKb1sIqBR w==;
IronPort-SDR: nftLuz9pqr+LZTLvpvjGT3ll6wd9GP5JE3qKYrvijpRLFMhTIEfQQHwYLZCZL764TL1XBgaExw
 Fy5gQqhtPm2ddWJngFFYQbvc7EREm+/uptBx19ZZ5ERP3obg7zpeMSxnM4xWvW0d0ydlhn6n9t
 7V3+UJ+fBXMM5RoLkz3e0nIYd+x3K3r6aZJBkv5Lfk2DdZAAQEzqyZvwoQbzjnieMJiecZfRZN
 tJV4+8Yi0Tc69IsFWl7Pe1TrdSXVx/+4m6QAr8jHyfsWsKCPozSclUgc6QTaJo8HhR9IhtBpjb
 Rlk=
X-IronPort-AV: E=Sophos;i="5.82,333,1613404800"; d="scan'208";a="168883410"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
 by ob1.hgst.iphmx.com with ESMTP; 27 May 2021 10:37:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwefztSq71Ztp8EmftfNa299h8eGqQKgvZg0xx55n44Xub3dP81c9tl/sDo5I6p8ieIb3APZLp/BwcM1VOLda8VcaDSbTBcsf+0UaPqfqLf/7NGpqHA/wH9Ch+kGzsjmCG2CmrsU/DKLZupGvZa0orkxxYfOoS0Qh9UTu1d/zaKTir9noj1ie/LUB7KkDmJP55l72NljgMwjIJsVVPWL0pvbL73QMS+AMvYvMzj12YHjP3DfZNzThP0mqLbBAJAFo84UC8cmukYxPTd5inK+jT52b1ib1c70lFq0nHuXy14v7zVFU3ENZH+I1eWjd4MX4feHhrhdieOUMraSjkYDnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPUIeMB5Ri2bTpI+DHPpvPd5a9Sm+QT7HZ7HX8k+gXU=;
 b=BRNQKosgfsLVUM0CgBQDaUKHioI1zIXuArb33kwj8EnqvYM7pgN9vUyQp0Fsz0MJNADVm7IhieWtI4pMfnF/ViQx5H85q4+beljdKP3e5cuojGROTKdzDV5QP/Bbpcj/KP8AcVWICN4HuJGX3fCWCmGfnTyni/AOM5l9vR+avXKFJETGXx/Ajs6CKM8RnoTJfYufBodf0SkYvDpmqS99SqqGPr3Hr1EadfO8C7Bi4GCXQfVtUPs88zPs4Kxc6dNfQeJk6RwmV5s20g5wPOKCQdc0eAbzifXjTAw/TRcItrjZKCmKcT6h1DEpo0fW7eNXKXhWs1xKMXlC1h2pIWM6eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPUIeMB5Ri2bTpI+DHPpvPd5a9Sm+QT7HZ7HX8k+gXU=;
 b=vv/0+3f7+nKBFhg7hble5f08nE9A11dmAiBMmhw3qtGASoFnUulJgEqo4KxJeLvtAJWfvzE2DaJ8r00maphXOPchJLYxF18VnGk69vf15uQpe+ZJzLscH/wk/86lMcmqVj4DymxXk0mamnPRfYFgB9V/X8DCh1ye23l/PzAB3PA=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4517.namprd04.prod.outlook.com (2603:10b6:a03:5a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Thu, 27 May
 2021 02:36:59 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4150.027; Thu, 27 May 2021
 02:36:59 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Jonathan Wright <jonathan@knownhost.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvmeof Issues with Zen 3/Ryzen 5000 Initiator
Thread-Topic: nvmeof Issues with Zen 3/Ryzen 5000 Initiator
Thread-Index: AQHXUnEoFF8eaU/PYUSIccVX00aCFw==
Date: Thu, 27 May 2021 02:36:59 +0000
Message-ID: <BYAPR04MB4965276BE6BD29AD9594F4DB86239@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <ffae89d5-05d8-e0a4-ca71-b3db18f70286@knownhost.com>
 <BYAPR04MB49650971173C72A97AC8B0D186249@BYAPR04MB4965.namprd04.prod.outlook.com>
 <98b9e916-1c62-d6fe-ade8-bf0a8788e622@knownhost.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: knownhost.com; dkim=none (message not signed)
 header.d=none;knownhost.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1fc80119-f791-4323-079c-08d920b84daf
x-ms-traffictypediagnostic: BYAPR04MB4517:
x-microsoft-antispam-prvs: <BYAPR04MB451795924EEA5BA19FE7D13286239@BYAPR04MB4517.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AZHRgtFunBdKF8LUGxl90ravNN6eAWogTIbKJ1JdsiAkWOJRtUnkuWj8XIbrubvk6S30SBvflVFLD/EKmeigij2yi5UVwXwIoN871wcDWP6rJeP8GHmLUe/zd3tRkgtxbGsg6j2h3ynPhjD4vNKIxkULPJzLYGFjQyL9KKLFbi/Opay2IEz9REac7Rf4wB2vzzJuFBRCxulKYBuVNXBds1MSaBJsUm/Y+I0beRXjHE2zYQX2V6qV6liZk4xfkYRDM19xjocq14GyQGXN/DBC/sZo7gFHUXQIjLA62ce2T5QuLSLvqZqvRE5+t4k+eujUUdl2s9u/KV3YP+ZTfbKUGoNUvimG2QJCtahZItzYI899F/fF0ZUQRY6dLURN3lxtcaskWrEeTPNf1w59HXt9cZ64GEi6ClCRjjPQR/iC6i1m/8FzztlBl8ma2B3SxFG/d09HzeAgPGXcBfuUTLss0BuvEqm8C9bLtI1MUHVvusAUpVgvyj6Qds5+D9dyvszCYwquui6GG2X5os5sOxwziy/Ahjx4FGqzPnuzz8RdMPzzGbUd/S1KBOsRpwMCSFfXAfT0Q+GEPNcnk1say1WJVbMMfcELx2E4+emsyQrYhIF8rcxuJyiyLnXZ3DtjPuvnyElSiiA62dU+k9Ci8yTLVtOBAWk4hdDAVLNg5uUoCJk3wonUO8jD99EoACHi25fBTt248USwrRuLjTfYXREWwQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(186003)(478600001)(26005)(86362001)(8936002)(53546011)(6506007)(66446008)(6916009)(38100700002)(33656002)(122000001)(4326008)(7696005)(9686003)(2906002)(64756008)(8676002)(76116006)(55016002)(4744005)(316002)(66946007)(71200400001)(66556008)(66476007)(5660300002)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?c8OB5bA2vGdBNXIfeSpb8pCPdK20czhH3+C15hHOHSukHlPw4ArnwmbfyAbt?=
 =?us-ascii?Q?v7gXLs6mWnQlfaUs0XoDoipCBFvo4qx7xXcI3iI+ReYfk6oooU/etwYXotIE?=
 =?us-ascii?Q?8Yg2su0flyA2kcd19iKWuKNvAXsJ+WAE+g8BlZA1g35RNkhfq6UMSWB3TtCV?=
 =?us-ascii?Q?b6uNs19Tbw0CGCT11BO/axjFB7RLv+If7r4xZkjU712Lk8HpITgqQ7JvMSSF?=
 =?us-ascii?Q?BnkRm4nfhpHAsgpMi+ogHb6Fr7foeHJBOmI66n93KbQ/HLjjAvzGSXMX+zTi?=
 =?us-ascii?Q?ZAXs2rYO5SAToWG8XBf23bxggK8civRGs09rW3A1g11Y92XslSBB/1+nt5Sa?=
 =?us-ascii?Q?1Yj4Pov+5YhmMI465iSnBI2GgM3NSd0t2GlvNM+4NNGQJ9JWMYOWwqOUvHyT?=
 =?us-ascii?Q?29EIpYyZMc+3k/EWTCyPlDTthxa3tnhCEd9ge5+cJqExFu1rkYWKITFQ3xi4?=
 =?us-ascii?Q?CDkyTfS78G96Cf/bYJI1QCu0m54luFVqIM1jzXF16AA35cuUfly6/jrqt1YF?=
 =?us-ascii?Q?NIlWeWXFvutU+DLNFOvwOxThpv4a/QLFBZANVVuDA93VU56Moae6UID5Ey/8?=
 =?us-ascii?Q?bdh/21s6Xa7QfMwPM+/f9SVgYMaokyi/mzNCR6vZ+e6fJ2RsOqK/1+HwWJ4m?=
 =?us-ascii?Q?mlDL+GSm8rKkX0e1COtsLnnsI6gGw4ZrYJqooEaosGYJl1+PTJm2NDuJ6QpW?=
 =?us-ascii?Q?KFWatpmvJU6gTWESuYcpqAySyDyYVrqB49mFvKgXwF2fGnJUP9h11wMh0apG?=
 =?us-ascii?Q?ktmcRH2hfHwubF1XhBKMZUOYPmn+7UWyk64jsY35KmuMn4NKHmbDdtN2Kp1b?=
 =?us-ascii?Q?D5JbvR0iSEVcOROiskVdKyZZq0SXfBV07nUEgHkp26Rbg938Khn+kY6zqZ8O?=
 =?us-ascii?Q?V5cWD+OQycgoF6vGxi/+pT2haK6Vm6tFoPyB6+/kpKEH7gyPHR5GGAxsJPH1?=
 =?us-ascii?Q?aU0+UfHKazndmuTKkFEP3LftSFh7lzXomc1RRxq4aW30nOu8MWSVH7DIMtcK?=
 =?us-ascii?Q?VI1Lo7WW52m/Evq5xUrks+J4+vmJAcGNRD72KdJA4bI3rR4ONlCljbAsLNQv?=
 =?us-ascii?Q?1geHocIUdj+ua8bRrUukR5Qow5S1l1wsfAG8oBN9S7EhD1zCtPO5moJPD+R4?=
 =?us-ascii?Q?ERPB/Q3HOIZTXG/0hUe4tGWx2c8/MdaeE/3dsSx75Kk+sXGalrdlulWuBMbc?=
 =?us-ascii?Q?zu3oOGxmxbrC9iXn0q37ZKlz8ny/jthVQqLoovewr38A4ICNpV0P8G3+5BL2?=
 =?us-ascii?Q?/VU0hUILFSDRvj2264tfD44ukjfIwNwKKsghMji47r7e1lNm1kcCq/rHsTD3?=
 =?us-ascii?Q?ioOYCA+iuQqJM0oIIj9QqmXR?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc80119-f791-4323-079c-08d920b84daf
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 02:36:59.7944 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cEVp5ttQ9TQM2MWSfWfNUXSADszn4a96f1/da3XcWwOxTXe4Cmt7lh/Wlr1HLpJOtzPEZ52Z3Q4VVYbYjkaJnIOxzk/o+22V08FG0SUogNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4517
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210526_193704_083346_5E9D2A97 
X-CRM114-Status: GOOD (  10.96  )
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

On 5/26/21 16:14, Jonathan Wright wrote:
> I grabbed/built the kernel from the nvme-5.14 branch 
> (http://git.infradead.org/nvme.git/shortlog/refs/heads/nvme-5.14) and 
> managed to get the NIC drivers compiled.
>
> Unfortunately the issue still persists.

It will allow everyone to help you to fix this if you can bisect
the problem.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
