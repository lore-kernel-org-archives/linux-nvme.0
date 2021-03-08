Return-Path: <SRS0=2ZV3=IG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7825CC433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Mar 2021 07:14:11 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DE58650BA
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Mar 2021 07:14:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE58650BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=zY5K9K6qm3FTLHs1eor/JCrFHp25o4l0d2K/tRu7l2M=; b=rR9UOS8I7Af3BXGm6LR+cQN31
	f8vCTvkIl9YxBLBslzfyOB5gVv/ahxzIHuzjT3DBP5TShGrIfppQfpNWmIHSC7CtkzLW06f4irPGA
	Sqj7Y6Q87TWs2/evg8F0EqR3q5b1NUB1SJ7ItpFaRVMrBUB1ISj0btYbPrEXSUQFuNqmy/QD3CZ+B
	kuMSShJg3ijLRGfAhiIMRdHql3o59YPxrWzMSuuZ/chQxFHinQzNKRWyGD4/d1H3/T+FJsMsmpmTP
	WjeOwb1yAx02Mt+jqUQa2ty886kVb+Gjn+NRWl+8b/Ovk9pKNZQULQShHQSl1YLvNQGOprArwPXev
	CFw3rLQ5A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJA5H-00FfVe-MJ; Mon, 08 Mar 2021 07:13:43 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJA03-00Fdhq-Qa
 for linux-nvme@lists.infradead.org; Mon, 08 Mar 2021 07:08:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615187299; x=1646723299;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=66RFyyhkT3mnpG4uF1Jn+iUGDigMum0ZDEUFIApdwWg=;
 b=UbsspcpEHNpST7B4VJ9o0FFSv3SxAQ/JZRQa2/zZlUjnSMY0qsgjV49e
 s2XmozrxcGECpE7O9tPhhjJxgn15lbOaleixwcLKFFWc+vg4Wy9WTvB6s
 D9VizcLucqxyqI3/lbnHexdAEdwFni2rPZNfwZd8lpvP/qWbnlpEgBchl
 gd4c3VURARfeSvgbWMFln+olxALYDQ7b3I3y1myKs4Dnhc6llWGaMpeZu
 m/TIo5OiNhtD8rzamFSLkoyIYXg09Iz4wBYoAerpJs9OL1lANcuGZ/jLB
 CrysyQ70kfbDaEfQ1Ju6EvAGf/mkEmxcmlY6R+xvPnFMg5q/shE+mM7cv A==;
IronPort-SDR: M3keSrgA4gpPo24Mr6TsZOQxwQxOOd9IvTwSF4DLMcCmLgCJ5CarICkWgDLdpl/EU9+LycUSA7
 at9Ue5tU2mz6ogajj+geTPUfSr8GHLcOq+NmBIs0JRAIITzswJzq71dvvPxDMi6bdcm2w+vp85
 E+r54dMllTOki1J8xOciYroG9wZRTNItKUfrmhSqeSm4luku2gkD0/ZhqkuKyP/lh0wgy0Syt/
 X65QkjLhimAQfW9+xCkhEp+lGbWNaB2wWbWWXTgkRsOd3lTINupdDLbFdkUCvc4qD2I4aKf/Vu
 9SA=
X-IronPort-AV: E=Sophos;i="5.81,231,1610380800"; d="scan'208";a="272251596"
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
 by ob1.hgst.iphmx.com with ESMTP; 08 Mar 2021 15:08:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GGwM82UdOWJfm23rChuJP09WVQgDLLSkHY7jrOhOdsktA7ofni/yQdS2bcq/13PvlGPzX+Qzzv9P+lYGDaaXMHWZWG61ki/F2EFSpbkSJ/VzP47FcjT2GyAkaSPhqw4af9nM6JAyxF1pE9s0BwS8U+VBYcgx6xoA1/2/1lNXvAOLsLG30ulUPF7jfBaygePikqM5Kqf0Kojf+1+ZiPOXKHeXl15YZ3PjVXCvFRArTU3xJbcE2XGMtdV/XSBU/3wuMSsNB/loYUwTM1fNWdS106tkCHvMNOikoDUSgfV64IODVJ3qabTPWHXZIFX1nh/y5uSnpnFFgUU7Xpahy1CDrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66RFyyhkT3mnpG4uF1Jn+iUGDigMum0ZDEUFIApdwWg=;
 b=bCL/ocPCTwb4askuRuf/DZuNxnaS20f+M2FwwFMj7yZ9Ax5iQ5616Kqs7LYiGpPqBcPcPoRVCMhlou5CO98WCEHQGdx+F8dCr3fKXCXo/COALwcnalvR/WKGbnYCT+bydsvqcgzQXvW8TNrbcJgMWV9OpIyN03u1hqeJiS9jFVT/OZ1toXjapghkc6VwhcqZWEgSBqzLjWPog5PnDcQNEFPV+mxSJevdP8uHSx9+2tXf/gONVQYLDnSA2BLtwL0D8QjVuHLB6bOx31FEQvU7IFZzUTi+LqrfYD/zahNWFQVGKAoblDvisfqe4zgvpdvhxbWtR+FSby8PBe/TsLaGkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66RFyyhkT3mnpG4uF1Jn+iUGDigMum0ZDEUFIApdwWg=;
 b=pJD7/syAl2/5LaHQ4Bbg3RT67uoSM+KQ9YFiAkzov32C+V/HPn6SFJ3Lnm8qB8fJ8zhXjPwJyLkyuflf/RqFj1c9vgL5MFnm5MACeiJq/hLYRhFy4p0duQ30I4W29p0GkonWV6HUQcmLMYd0ounqjIWhoz+QpPe7/lwP73q00VI=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7680.namprd04.prod.outlook.com (2603:10b6:a03:324::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Mon, 8 Mar
 2021 07:08:12 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3890.038; Mon, 8 Mar 2021
 07:08:12 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "mwilck@suse.com" <mwilck@suse.com>, Sagi Grimberg <sagi@grimberg.me>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Enzo
 Matsumiya <ematsumiya@suse.de>
Subject: Re: [PATCH 08/10] fabrics: use "const char *" in struct config
Thread-Topic: [PATCH 08/10] fabrics: use "const char *" in struct config
Thread-Index: AQHXEiDJH7a3jXtrQUeNwDSJkD5EyQ==
Date: Mon, 8 Mar 2021 07:08:12 +0000
Message-ID: <BYAPR04MB49659A8C518592D132E25A5C86939@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210306003624.21102-1-mwilck@suse.com>
 <20210306003624.21102-9-mwilck@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7238c4a9-b45e-44c0-c534-08d8e200f014
x-ms-traffictypediagnostic: SJ0PR04MB7680:
x-microsoft-antispam-prvs: <SJ0PR04MB7680193AC9404152AE5221BA86939@SJ0PR04MB7680.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KTmqmRtqW53xhMUYPDgh9G/FnnHntUMmWAgA2fUa1O4Vbsjn0v6OEPPVsven1Lx2+mvjaibgivjJLpvsCSgr/P7fPOK5Ph694UZTtV4aI+AGBuSFU/e75BAz8EPerYq6ErvQBOy07xyi8JPkmqrufDbh5SSmhF+d0UDCHZLRWgY8zHGPmGxzLwmy0AsfLNZuPUy2T5nu/B5OTDGlGhTvzc++FcK93YofMZikj9REZNasfp+0CYwjUfn2GdNQ65FpQ/+gn5lDARaPVbu9hCk7D+fCM4m8W8PMMfhca9bdPq+0gsdWU8KCh3KW7//Y3+MFMi1bvdzVcF9asQQPilNwme16o7PDy7IyB+2mKzkJ/47QPebGgJqtre44TMPURXeodDQAjCwuZdP1dcVy9v0A7ZKuGrh0yvpL2w7UI//tJmGZXwV/XeXfprHM6Jr7KiXRmdOQlAdBiXfAlwEwJVXYuokTv8DfBMS5+JouQYDI5Qx9xBDtLpla46vt5xa4i1QIR/sJsEX84MpzXIciU/rsfg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(7696005)(478600001)(66446008)(86362001)(8936002)(9686003)(71200400001)(8676002)(52536014)(316002)(91956017)(55016002)(76116006)(5660300002)(26005)(6506007)(186003)(53546011)(33656002)(4326008)(54906003)(66556008)(2906002)(66946007)(110136005)(4744005)(64756008)(66476007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?SJ7VQ/wMn+AWSi7i6zyfj+wMqMkeO16UJAQKfkqKVvOuxFsmfahdUQcTrMBf?=
 =?us-ascii?Q?yfIEDV2MEpTEcBUhZnY80IVmfDsXJuiYPe8GmCf2JHT2fhLOxh6slPKAR0Ln?=
 =?us-ascii?Q?0++jQHSU9mE7+s7ueE7AD+kBk3/Ip9tpCVqlF5YVWu9or5AN14tk0QfVki4e?=
 =?us-ascii?Q?rmMRi7ffU2CwBiSL6QkMphYGTdOIquTV0eGhPQCf3p8n+yg9fm1SzwyFOEbr?=
 =?us-ascii?Q?VYLs9rBlFycHBhuVMZFKxwknGR2sSg+oe9SrmzGp5gRFr/hSWv+uoz7D1/Gc?=
 =?us-ascii?Q?V4C8jckdQ0N2Q5oWmpmpN+H0ocVeYJPcisZ3zKlq3EPUhBkRBYpS6bcfTi5B?=
 =?us-ascii?Q?cSPFahF5SssAQ8GUeucddNspTyoKoK7MI7/7IhbylEsnHYD7RiIxwX2yhbTN?=
 =?us-ascii?Q?AZti6+wn789498dq9oLCP8XNCmRQMIBMG6kFzrjDpbLrdnwiG+HnCLqZRfSX?=
 =?us-ascii?Q?m8fI85LE23c3yfcyjrA2bdFs19CZli/Dpi2aahlEQ2BjDrBM7Eczg/ItrFn2?=
 =?us-ascii?Q?4JaB1aMMVkS1GKh3XdKaXHEwnDDwFkEwu191x/S2Oi2G+FS0IRqgUZS74g6E?=
 =?us-ascii?Q?S4zGVcjJmCMo/T1VALSyKpUafM0n9VPZdlndzr03DUyMXfwSFN5G3umKy1GN?=
 =?us-ascii?Q?2R4rzK8gYe08qetJvMvm7ya5ajuN5ioWAqnOI42nsg3/1qUCoJ9yYOx+9lax?=
 =?us-ascii?Q?I/McX1Pe4TiHsQBdIXs8S1PCPILesTHwr9V8fdGeKxqE/VnfZkfsCWwB0RLi?=
 =?us-ascii?Q?0Xt8tEhDXl7TYFGdXwwrlHAZWD5fUbFUn//R6rxTMhXyf7P2WtC7duumvaIQ?=
 =?us-ascii?Q?q6m+K9788hbPtP9vMsfaQogkimP08qdNRlz0i6U2X3dOcGOF8azC67nd+QJQ?=
 =?us-ascii?Q?6nuK+TzAlJqPqoNzF+E+lqRDa9eJVcVB7tp2x5012nhowwBuCWNCMO3me2qh?=
 =?us-ascii?Q?YMH/GCZ2JvDXhfm3cgN4pwM3hSONYZHSQPPdIQiYRZzOfytthLahMan2wvdD?=
 =?us-ascii?Q?KbL7YVl3hWRldFj2AyOa4gw9fWD1aJfkW9cBxMtrh+oM1F5TkpTNlBRqkV+l?=
 =?us-ascii?Q?YuR3tY76S8OEeenOaoxPmWPRgwhCQdrUqHKj9+qCuIXoeR9/zwJphkOaxSdE?=
 =?us-ascii?Q?3MSsYOGHQMAnn99phOVZVsDjKgPOvK6F+7r7l3Xyy/yizS4nxa4DJMZM9ZI+?=
 =?us-ascii?Q?xTnSAs3td3XA9Gx54VOPcp6ttiIeNvUBjMvRn1K7TIW4B6vAwaaX/mGlSXgC?=
 =?us-ascii?Q?aYuakFwhYW0z5nOl80ApNfO/XHDCBYc+NaGAM9/EZgTBrr7R0AAxTlUoLU71?=
 =?us-ascii?Q?IIARmm/FsPdHzvR6BujPYb4b?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7238c4a9-b45e-44c0-c534-08d8e200f014
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 07:08:12.7496 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KcdOiWiTe0Afx0cATrb2YSjsBAOi7wyhHMCXASeLeEhrjOdVxUaOXep739zmNaZZlHq6UFAJJyFKAjiC815Q64KR7l4E5+ImEfpwOiQNBwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7680
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210308_070820_867063_EDD0B4E5 
X-CRM114-Status: GOOD (  10.36  )
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

On 3/5/21 16:36, mwilck@suse.com wrote:
> From: Martin Wilck <mwilck@suse.com>
>
> This is easily done, and allows passing in some const char* pointers
> that would otherwise need to be strdup()d first.
>
> Do not use const char * for cfg->device, because we may need to free()
> it.
>
> Signed-off-by: Martin Wilck <mwilck@suse.com>
Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
