Return-Path: <SRS0=pbEM=JE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C171AC433B4
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 23:20:34 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48A046113B
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 23:20:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48A046113B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=F0F4WbOFHTehbVWaf0nddEcZfSn/7dWZICLDiw8YwAA=; b=OMyJacTDpt4ek1b+FeMleiw0r
	NPoZ6uTB06CSrEc8vCjxErXTdfJ34mBw+iawd1Lo472UFpexfN7/3C6sL3ZKDnBKlXBg5KLZbH96R
	L9vwgTN0RNFWZqcnsRECTHYk+2XYdJrRvNFqsewU00qYxWSVMX7/FX9HZGFwkRMFyFNCWrlF5frpA
	g+hfmPGnKcRhdpy18NXa8kBczt8A7r3Bfj1gGFyBeCJmvL8qHCaTtSc8IKHe2yGNNh1HpPpvTzr7R
	qlO7PfDLADesyFBa2odUNfo3/pJJ+2hQSHrbr1xEKK9tYD4prqkqD3cJORtsdV40LrbPb9FMzJwGS
	tDCntSJeg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUHSx-006GuN-5J; Wed, 07 Apr 2021 23:20:07 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUHSs-006GtV-37
 for linux-nvme@lists.infradead.org; Wed, 07 Apr 2021 23:20:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1617837602; x=1649373602;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=XEbV+NKkczIbbEvLpCoGQ/NQqFuwvrMPNVRbtj0qvRk=;
 b=Vuu/g9T/Jz2TjZcj/E0vpkcfH/hrJkmtD7wno3lHtCVIvR6i99uJ3YZz
 LiGYgedHgKWpMffvgrIVUNBi3bqbvaubfOjJl3fx8GXyayRpmB/bCFI4P
 v5F29QdeV8lbQ0wA4sXxNb2zVbOuKYpgClWtXNXpjm76GZ19ixtGvmWvN
 o6xCtg1hnXe3b3V8fA0gS5KWur3K8ZwdjZNFoIqsdQMva7ifdcSa37B7+
 BfRq/3FS6E+deNtxSVsOb0jx+tzD3uFkuBnEChdRy0D88iXSThvCaNAIV
 pGjY23J47Xus+mhSlqwrxT/TSG3M9LaqoyIQtsU7Jr7yYGLUpIi5UylYh Q==;
IronPort-SDR: GAyPGrZCZJ21Nx4aDfQJKkpUtoNjSGIuzxlQ8tzkR8Q6q/IDp9k9CT0loeuz7RPa1gviiH4igs
 JaTGgG5Gogep5hVlNrIYRUg6U13cptaAHlUtruXWnmUgSWf8dP5sK5BLMVIZHYuqYsa5V3N3dV
 tSruGBaiTg6hb3LcmwfVrRx0fIRiueND6DPnJfaVXuUUGjgUfquie1IqMZloaidKqTFLGLlWfk
 2JUX1tIj6L9AHF+YVim29vVp6t4OZFGPNV2/5VgLCuEWN2UvJPk/hmPmIH33OLaBe+DTY1/4ih
 2Io=
X-IronPort-AV: E=Sophos;i="5.82,204,1613404800"; d="scan'208";a="164134099"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
 by ob1.hgst.iphmx.com with ESMTP; 08 Apr 2021 07:19:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mt6m4zBMUITThlPciJ1EAlh4lnmzZGRhxbTcruldetMimeufZWxi1oBATL/lIKNs5zlbLkpmcsTbAGIBTVQwHCTauCH4avnPBlklP3GrOVUsmxGvkMqRwCJ5/gwUd35n22EkxPkP62aFfmZpmjfdYfYq+h0XF1LQJMMWHg3SPMmNrNxY7Zck7fdVcfzZSNsItRNI1tTFelcBBeKyWx6HhQcx3jkVX5fqMoEQSNsvmrCjRPPsISR4Ec9yLQ2RtTkHVRMDNmakL7zPNSkxp8TRnGgfnkwFKsx54OZSzRAIRp7N0ODZxTJ06sNpXPAe9KKhMEtRnVaoxrcwaBnvsiHyqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VH1f8TQtLWlZ2J58Y1zpxMs2KPIt1ubLRDq2cj/Ys2E=;
 b=NuyJqFIYUuC6CejUjsg/MvhsL+xSjUTf0Q635dvF+nnYN47g+GyJYTJ0eg+ySwVy7Ww2uvOWkXDvhcjH7+KNsXuEUtGHPPziNJAUhlIA4RFoz8QxzFkMKg0GPlb4pRV9/q/HErT96yfl7IOH0Y1IBZSta+7BY/cX4fefUWu3UaKEgTXx7f5anN3kri+dhL0VcbB7VwPl6lhf1UC9WdFkcvdtcIEM2M5bseH4ESERBcxjSNX7p4Uq5k5HXcso8ufeJcGaAIGg7b72Jq91hcVusUqGb1zcOHHK53323lFIjwNEavvRdUbaLD13dYxfeArlLsiAF7MHUYxN66H0vNto4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VH1f8TQtLWlZ2J58Y1zpxMs2KPIt1ubLRDq2cj/Ys2E=;
 b=mOcLUAMue4MUh8d4efjNKY5VXCuptECMSM8rnqVIrTpiPfQALnM8bQ4o4RJJV5FUEm0/71qojJ5jXiIo6VU9NTO8jpme9MzrIosuvfvll5HUDc4pxe1JZmSdYoEDSclN9yUAle0D3ygLzP5Ceqtopky7Aj9Q+XyKuggF8sKIdN4=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7744.namprd04.prod.outlook.com (2603:10b6:a03:32e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Wed, 7 Apr
 2021 23:19:57 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4020.018; Wed, 7 Apr 2021
 23:19:57 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Padmakar Kalghatgi <p.kalghatgi@samsung.com>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "tasleson@redhat.com"
 <tasleson@redhat.com>, "tbzatek@redhat.com" <tbzatek@redhat.com>,
 "prakash.v@samsung.com" <prakash.v@samsung.com>, "d.palani@samsung.com"
 <d.palani@samsung.com>, "javier.gonz@samsung.com" <javier.gonz@samsung.com>,
 "k.jensen@samsung.com" <k.jensen@samsung.com>, "mohit.kap@samsung.com"
 <mohit.kap@samsung.com>, "krish.reddy@samsung.com" <krish.reddy@samsung.com>
Subject: Re: libnvme questions
Thread-Topic: libnvme questions
Thread-Index: AQHXEJkDKinop2xAF0e5sqK7JXt5sg==
Date: Wed, 7 Apr 2021 23:19:57 +0000
Message-ID: <BYAPR04MB4965B31055E6805C185C26AA86759@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210312161824.GA3953@redsun51.ssa.fujisawa.hgst.com>
 <CGME20210407123854epcas5p48217db953741a57d651a8a8bf240ee23@epcas5p4.samsung.com>
 <20210407123806.23253-1-p.kalghatgi@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42fc576d-10d6-4e80-7a08-08d8fa1ba8f6
x-ms-traffictypediagnostic: SJ0PR04MB7744:
x-microsoft-antispam-prvs: <SJ0PR04MB77447508543781ECF6E9D9CF86759@SJ0PR04MB7744.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mKIjOhQhC8CSnR51njP6IzmnYvDea/frUdAPQYUK19MctSsVVwLtyPA2pN3bpfjx7FDIn6GSlIKwEu+5Wk/1LM0M5WLUC6Z3pdOkmlV7VIrENwIPsB2fm6vuAam69LHzdlY49knX35jaSlqRMj27KvvJ5oibOq1ZLzvVrsjrVVyPM4oFiE65oHsfR5fu1h4pACMN97Oyh/o2mUITPHIwUpUmsjJXbOtjv+Py8/oXzZ26OA202CvkwAqKCM6R0UZ6cogJwUeW7XyS7t/H5l4KB18bo07yWVPl9/PcPVRqbqWQVY4qrqWMe4xHGo8BBPZSl2Ylg13qW6Zb9fZEYk6GOoq3hUqkBSN8u/8bgPFMHYpcO8k+V4bIV3b+xNt/zsW81Splt7PauIBGjpW7BY+8eVq+phPwG5yw4U7ile+cSgLyrNNmcJP78YM2OJHaqg2i5gzfKiMZnHB/3hi45KRh9M9dS2ix7L+0du8of27tHo2hHkwS99zCx8b0/uyhzllCbXbeMBC66tEU1UHzhj4widTJkISQ/zhqRkLvg6KTGr55tO4wtD3WtYAsNfmkEWZV/r34VM97Og4xrD4/o8mooPazbYI7QKRwhm8qbXuYz9hTdKbV/fUFkcsQO96fFDTKAs4zom4aL/sYeK6bard6kS2AMH69hRPB6Na/59s7Nys=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(4326008)(33656002)(54906003)(71200400001)(316002)(4744005)(66446008)(8936002)(38100700001)(8676002)(5660300002)(2906002)(76116006)(52536014)(186003)(7696005)(6506007)(53546011)(7116003)(7416002)(26005)(66476007)(55016002)(66556008)(478600001)(64756008)(86362001)(66946007)(3480700007)(6916009)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?yWohYcfpOUh9V/ckhNl+l7J5SgZjS75Ys5mQP+Jzutdwuk0mnmjNLZZNYbm5?=
 =?us-ascii?Q?UbysesUf/Z3i500b+5acN4+QnqrTPzEdu1FcqDF+g5DdOBxyp3846qWYxvl5?=
 =?us-ascii?Q?OvCXR1L+2qvfSIV7+MylS8Vuqq9E7bHhYvhKQk6yfehKV1IK1QQhKmMrCDmS?=
 =?us-ascii?Q?mcSpgigScT0KkNfJSvyMd9tABEXJFKZPil8Gw7hOlpLz6vKgk1ptjZy1fmZD?=
 =?us-ascii?Q?gkMQfeibrgPkGUuOD5HZOnK7CJzrNklRA+TSglxxB9sYRPQc7bXFyzgS3RoL?=
 =?us-ascii?Q?k21winrS0reqTwhgeb4MOKcU/yCM1xG9I4d8HVlbeOFsB6ttn8uB8chYyo9r?=
 =?us-ascii?Q?Z0Hg9PEx2m4MLAu/i1Xr/qZFTyWbYd+7ViBBIT0DEEW3UNYWXPKuJi8Pv4hM?=
 =?us-ascii?Q?s+O0JYEaGy5YUehxKQe3mfvfUeS5ndnuGrnEgpsX9Kk+gOOB4wySa3c9DxTf?=
 =?us-ascii?Q?UCR/iqVjGA9Vok/uOrcqm8VjdY5kKyPG1r5Y2Gt++1DxWQsZMZGVMaIX02iQ?=
 =?us-ascii?Q?oojnvAjvUrIFqSb7As/AgMayA0OG1RlyF20okgigyGgqBwp1XwzJIq6Vgn9j?=
 =?us-ascii?Q?KMrDDeRBdj3I7DCv/zV5kOb9a4YGIIrv8iAl6sFZurzriY4NCdpLGBIJYv6n?=
 =?us-ascii?Q?D5HvwBTgAHCZb/lXQGNBkDiddxkFwEk7yUnyKbJg9kMpqJJItBF1FdSVSoNf?=
 =?us-ascii?Q?pyRMqb7KmNQ9vvGmS76iVe5pSFxxpJ1ijiP+LDQQRt1d+8EpiYZMHS0yudr3?=
 =?us-ascii?Q?mNTf3XTQDuW10ZSxmavKAj7NC8O1VTjit1ol6wBq22h/E35u7uPtEBxzyKCZ?=
 =?us-ascii?Q?aLga6hw+YT/3DQ4bCOkvK0d1nHhlJx8VkWvrl8Hb7WgnOXeXd4UlpQKpKxiT?=
 =?us-ascii?Q?6Crk1oyBVtN6bSVrXfDFsDSwqvc2sQxaNlSKTguaJR+6BVNbZ2qhrNY3jK/2?=
 =?us-ascii?Q?/wBWPCk+OQ78XnToy8+QyL8m6ourndPjXfnWakVrVAS/kFhnVmwuVkcWaYGS?=
 =?us-ascii?Q?gLoKUA7xMVD/aJMUHD3viiDX1IiRONSTx3m9UKPYKi1gGNXtt/JNXJZR5ex5?=
 =?us-ascii?Q?nMaKXB2G7/y10OG+gBPSjkjC0EWm7Aj9VNNcLsQ5whdzHfLxuSPYuuzhdW7t?=
 =?us-ascii?Q?F2oZ4G6XYL/dGEw6Ju+h6Ks/woaFSpByJWpwqrXpsrA7nQrW01LFD84UPshd?=
 =?us-ascii?Q?824JY9PZXbAo4nhdFTuOPV2YejnAJ67h7VpUYAWhCeyWRnLUD+AW2flgdwuW?=
 =?us-ascii?Q?ngx1DhFzPR5MqfZU1uyaEwGANZ5IIbirz2IPTvnbVOXnpzJ7AY4eFIcw2TVz?=
 =?us-ascii?Q?6AcAy4DuINVcvWYYXc4hqP6W?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42fc576d-10d6-4e80-7a08-08d8fa1ba8f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2021 23:19:57.7852 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DqND4A3CxMF5LX1fZ0OmQLs6zp8EX/GjRMkDmjBkv+ekQSW4+ZVrFU9hEBZG7B34o3ThvN//gml5DBCyTafNmEhWvI0GQ6sR6cNLJjRPigc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7744
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210408_002003_414356_636CB823 
X-CRM114-Status: UNSURE (   7.83  )
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

On 4/7/21 05:46, Padmakar Kalghatgi wrote:
>   
> Please share your thougths whether to have this feature as a plugin or as a standalone tool, also provide feedback on our plan to have the sideband MI functionality.

If you want it all in one place you should implement it as plugin,
it will make your life easier.

I think Keith has already NAVKED SMBus, you need to provide a really good
justification if you want that to be a part of nvme-cli.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
