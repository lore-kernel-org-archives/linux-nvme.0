Return-Path: <SRS0=Gozd=AY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BB3C433E2
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2020 23:59:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 080A32184D
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2020 23:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="v6T1tTnX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VSnI/fUB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qMEx8aW0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 080A32184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=xbu3fn3zkHW5h16oEO961NEVBDpsAMm69VLWT/7o5XA=; b=v6T1tTnXvgn/5wQhFHAtb8je5
	yQe+kIcpzYGqeBqvAoUl5SCjykV4l5/6+uufap+WjAuD7OFtF+YYxS535POaOm0D+jPeuagMYEAGm
	6Ou8BLIRoh/a8q1+84VF9UNttb04PAN3rzpu/88Fm5TmZHjPasZVhrb8pD68uZtKTHxVYNqlaWoQV
	wSM/2ViNqqIsq4aF9RRXpIjH7MthSUDzSullZSMqPmb9508t5leBgqaFAIZeLnHmkGkkqeRUcMnnU
	VrDbB8y3SdKALSwoxHIguRkDbzIkRED7hDn6YUosI9wJWANokBA+fSQulYF8YkNQgZJRdg8Uvpl4N
	5gNbDks3g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jv8Ly-0000b9-2H; Mon, 13 Jul 2020 23:59:22 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jv8Lu-0000aJ-Qn
 for linux-nvme@lists.infradead.org; Mon, 13 Jul 2020 23:59:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594684759; x=1626220759;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=ZHDbc3/TNzPQaU7o7QNbm16AeTUeXImgpCXoCXxDRFY=;
 b=VSnI/fUB/IC+7dM3nWqkdXUbNVvOSpLjZWwhLHe+3JznZFc1A1tq+VTg
 9Sw7TCfX6a05szVGLobtePNtMD+swVKu1cM/jLZFPh/svboPDQRMFa44/
 nzkSTcLk3b2OU+8LOmpqoKEFiThqNSq0gBH7PNJ70jzhjSQHrIiCy7lNA
 6GCW8KysYpx4lSC3vPZT70sD8PEc17LJJpmJ1OUqguc/LFF+c2Jk0LKdZ
 URoBmQalOBKaRa9yVvd05S0gNyy20TWsIi+L3ukHQ94IEI2LIX3bt2ilL
 sCuGIfiWWXtAxRDeoUm8pvqb0siJGz70yQGhl+wNRSHljCpuTpKxaBTFl Q==;
IronPort-SDR: XJlVCLK17aZvTenN8XecYXYMvhOp7pwgGJ+FL12QozFWdaQGRKIUXk4mL/uPm5ftrI+u0Vupex
 GnxIAVjrjmTYIENgQmM20bPtelpuOtL/5Ak1pDHtc8bQ/U4ZIG3Bq7a3xa/eGJ9F58G18RXlI1
 bxIzrkfObCIxy6Up4f3a75nnE0VKq/ao7JU9793FXaoxH07aqmk/55iIv92JMIFVXt25kvmNZf
 WMWEcuEUlY5o9s24abZEcjj4Gp1zeEml49Q+oQ25ZySGXyzSaQGU5+Ku4FpWQJwEM4TJIy/6KO
 XNA=
X-IronPort-AV: E=Sophos;i="5.75,349,1589212800"; d="scan'208";a="142509243"
Received: from mail-co1nam04lp2051.outbound.protection.outlook.com (HELO
 NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.51])
 by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2020 07:59:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPpNs2PmVTVieGJN/OPKv8lF3cUvzbSJjNE8RcDYTFbc7PbCQsFnZWpctlldSVwooGlHEBcwo8Mzzf1mLKcUBk7dhdkMTg7FGX7n1FOjbzVCpqEqEtJQBfYefga0Uv86Ec8SfljMSME++sqg/jTboXmFIRVv1ouBsOIcOTnSF9ez/V+ZB569/cKJE/aymCsnoxYZRC4fFhu9DNbvr4M2G4AeuZjByUF4QM9bZSeHyzj+3CCt5//6LTCT6kOnIkwuGUnGKY8aaWy8geEY0EQdxE1wh/e81lyGslFsJNFrhHpevoo5x7m0yyr8X6Cu4iQ0I4HihntpMKvZ0ZvRJ7hH7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHDbc3/TNzPQaU7o7QNbm16AeTUeXImgpCXoCXxDRFY=;
 b=L6VOPiOqeGZHVcvtdMgkNOMJq+Wleb9tAlBB/wwtafZ/0IQBH1Q1eLLt1ROUs5FLAYiudMBMp6XPpL1u9oQ28Lqi8MCFpD3SC3N2cH5M3ZNrkkuok1SydaTGFNHPLkzYVIGGRb9AepQexAWEq1frRhgvR2np59EwWPz75o9m6ekpBAQd0pa5Ho9qdo2qy2dq3Vt4twrnkVggNtvoZXKXBpIWtwLam1QpqO7Cgfw/WuRf4utYYtg9gTHE9EaP0u12W+uZ5Bt+IP8I08qIpgfAjg1UniRBQHNmEzAC89IayJGDlzyR6JwQJ6k5jEX2cPMb53laIswkNqEZ8bVQSpl76g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHDbc3/TNzPQaU7o7QNbm16AeTUeXImgpCXoCXxDRFY=;
 b=qMEx8aW0Xf+F9SmCehLcdNFXBzJMJkiTxzdyFYRCT0Vvce4wO25L1UWfGiTtYWvRQgJzjuPiLkGIGHW/sOIvJQ93Uc+RvP9+khr2zCAWPL+J8nfZozG7NhkAntfyj+BzlvyO2bWp5luHag7LBHISnhQRZxoCYZv0Q4pP8w8USmA=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6549.namprd04.prod.outlook.com (2603:10b6:a03:1d2::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Mon, 13 Jul
 2020 23:59:16 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3174.026; Mon, 13 Jul 2020
 23:59:16 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 2/2] nvme-pci: use max of PRP or SGL for iod size
Thread-Topic: [PATCH V2 2/2] nvme-pci: use max of PRP or SGL for iod size
Thread-Index: AQHWVkpX+pWmytrII0K3I1us38R7BQ==
Date: Mon, 13 Jul 2020 23:59:15 +0000
Message-ID: <BYAPR04MB496507388204C9FCE452109986600@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200709234025.10673-1-chaitanya.kulkarni@wdc.com>
 <20200709234025.10673-3-chaitanya.kulkarni@wdc.com>
 <20200713074254.GC14676@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8bc2cc88-d134-42d9-86c7-08d82788bfdf
x-ms-traffictypediagnostic: BY5PR04MB6549:
x-microsoft-antispam-prvs: <BY5PR04MB6549CB56C227B6F22363DB9486600@BY5PR04MB6549.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ooa7imnkJpkZrBsiHH+1ISB+1j7sCI72HRMw2q+J1JDpONMivYElJbqzQPThGgLE3vrJuq4VLN/xXWTiYbu74smvvM4az4jQEfR4Pv28oeRhsev6fgNOsL9sG/Oyw1DfEhx3rCkfWvO6nevVzzPaR7KaTRrHBgXD5lnLJCjyIQdk4k52hMQiyZHRtjfeebS5Ty6n0nVb8T6K12hsk1xWl2un8XgznSBlPNujcNLTOQQ5tpHUFSkvn9ROVJfhKRm+l5H8YJpBMTOaCnYd0TfV7AOxnigmXtB/Gu2LkCiONnVzMFmmcOqPqq1vijhMVqv5
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(66476007)(8936002)(478600001)(9686003)(4326008)(55016002)(86362001)(8676002)(558084003)(54906003)(66446008)(26005)(6506007)(66946007)(2906002)(33656002)(52536014)(53546011)(5660300002)(7696005)(316002)(186003)(71200400001)(76116006)(66556008)(64756008)(6916009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: zvs22NFLdQKvzIzCSqp4da8J/3pacMrg7glzxfRR9TNyI/Rp5yBOXOjDMYVyBFFqi7A76g3Z2XNOcKOPlrBW/TaE12EAe0nqJLwG/fStwYb/DY3TpANxXS3n78XvyqKcVdudC3IHsvwwAx7L3eyS0fWNlfbnREQQd/ak2trkNXfHEAYKC0x5nWrbC7079oqM01Llc+wYrlXtrN2N/yqNT0f5KS/8qSRDaaJiTSiXqYPZTmIm26hNICBJVkhTc0C5ur/qAlgbzJf21AJFwYL76Ldfy4pzKq/gx1zIP1rYjiN0R04OW0zsPlIO07qnJSOdu6OAT2JKZAJGMVPerQuPD02+BiVEyaYcLaC480oN8dCGl5i+mq1as6iqeIHOAZUJ+tLvmPnSgjYPU0P7yhDsG9GULyoQnvOV5s1cNF7YKRtsyA/fcacQJ8GRwo6+YWFsNO9Vpw6cVTOrAHram9RjhIVJpvDs/rdtx7Bw5OEP0fQ=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc2cc88-d134-42d9-86c7-08d82788bfdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 23:59:15.8589 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pR73i0KpFfSYX2bXW7gaP2hoVMykk1Peii42ZeU6IjPQiwj+7yGTfBjE4rAGcZkgRHzDKKPBPp6zm3IQnsE83vsOlTzVbb5rPJ5HY1X6hwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6549
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200713_195919_006096_D354FFB4 
X-CRM114-Status: UNSURE (   9.61  )
X-CRM114-Notice: Please train this message.
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

On 7/13/20 00:43, Christoph Hellwig wrote:
> I think we can just remove the size and nseg arguments and hard code them
> in the function itself.
Okay, will add this in V3.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
