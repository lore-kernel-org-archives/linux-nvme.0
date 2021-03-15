Return-Path: <SRS0=15CP=IN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFA0C433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 21:16:25 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C13C601FB
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 21:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C13C601FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=e1YfU3RvNg1k17BRKvM3OJAaDi2y3BgnWh3YOsksNUU=; b=JvcX19NofHJ2Mn+H6EuQqKEdD
	Pt8s/8bt9ACr4uL1f9xk7OHfN6ho0FUj88TYzm9kvyulfTQFKhaKeCx13t7EeBJ0N6OSJyM0I/sUt
	ezxtRfbpAO0Gv3fsirOq39ucoaboJ+HKp/3/d+7Ks1Jx/eM/xcyswHqdpvW6k/9N0QMpyBQoNVWs8
	zRLNzM8buLZj1I9Tlj3udQ0MICw+aFXQtDSfYWSW+HS2uPAmcNZw0hw08BfwA0bwHdPwqzk0a+7d1
	ZL9/L3a8QJDi9xWPPY+MZ6Syjo1nFUxsK/eR5AD0Al80vJzG6puipYdl+uKm+zv2jQmq/zPZkTsE5
	V/Mncau6A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lLuZJ-00Guzw-Hf; Mon, 15 Mar 2021 21:16:08 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLuYz-00Guwi-3z
 for linux-nvme@lists.infradead.org; Mon, 15 Mar 2021 21:15:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615842945; x=1647378945;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=ZntpnL+/qKMewEFiLlgCAcr3/5qvrk8VwoW1W22kzCU=;
 b=lYf2GXwVIzJNZ0CrTQFnSmy+OUy82YDNnHZVUwalcLruSnlgffKu6tVr
 KJ47uRgN59fT/y2LZwre2uJJZ6Lz7MxO7dB6/9qeIu2w6qNP/bfXujXPW
 wjZVtd0zl2GCb3zKDh7DkwIoT8jiyMBg+4RkIfIEKNQ5v8KtCSSwnif4b
 dWrQLDg9pBYdbBVBpt9XfPpS3lNCek72VoKCWh1RoNHLqCF1+4Lzx8eCY
 oIbW381F1ZQxh7V2UHDrl0WBjA5d/ciusuqO3y5eSu+uXEVYjs4GHkgHF
 y4cg97Q5MRuWOHrcHCkdtaLlaVKsqRXEYIGDyBp4E3BfluV629TE/C/wa w==;
IronPort-SDR: q3VFDz/XfhDqrWGE2iYpeRSyu/22PkseAAkW9Wvo0tmcO0zBuo2XJ+SnLtubO3s5K+v53hUk7m
 cqSY3SGHMvarc/n56dpcjK0Xk9livbwFyxjui/zi1ZgCEltXZYerbYhVGep4tEXYe7XUvqUB1o
 x/JAgCWI5frw+3cgNT/Ts5xwC/fpHW02LuFqg9n4SJ+ohKd/2GATys1rMWaulPXw17v/VEU1A7
 oH0wjoKwl0zhWhAIZYDkTeI/f906rQI38HXLqRYn7rjalpv/tQY64ja5SLyy+4oyfiA3tq56sZ
 QSk=
X-IronPort-AV: E=Sophos;i="5.81,251,1610380800"; d="scan'208";a="272915147"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
 by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2021 05:15:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmEBPiBII75Y53FI7TtIEZ+Vf9hWwx+cHKAz6K3dbQ9VNVpeeZ6D8a98LeDipzTSvzs7fq4wakDrGPWgN18Kc0oNLQew80UAGyYzsBviDaXLO0f204BhZNPdbd4Qh29vvX75YlBlp4qpXr+tmoKjWTRUD2wTuDPwuNBGa7+DhLd5ID3H//lQvLBqZq37EbEeAq2ZKBTxoq04wdNu8uVFw6vUFZfcsqHNvE/q7+Qq1LwGPUMVuRq13lWJXFf5JJKI4gwUQnm5c7dLUHihs4BUs1e6iBrUdW4kp2r6itEBTt1oPoNVXzy67H23O97iryc1h0JUPGDn18Bw6fGX5l6AJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZntpnL+/qKMewEFiLlgCAcr3/5qvrk8VwoW1W22kzCU=;
 b=K0eJyUafEBgb47oOuU0Drh2WTgC/xpSYsAhrrnEyHBZi7WGxV6BQmnuZK2jv/ap4pWFCc8sIFdXfcrBCKBlNAeGrEymwlc+afUIvJx9R2WvRPFw5zPODaEvsWKJ0ItVwgPkU1GXem3tkMzhwHX+96CUo8TfAWPgInXu3G6Tz9fgeb/fxny2BZMThjNMqTrHLPKToTCgYWsFfleZLulQ+dW9O3lP/c1BuM52SgZusWGoJzwTq9TUWJdM/tZJTJ3+KzeZ82+i1NFK56S2V1Zk9ty6dTCInbgZJ6BSVHsTkCPxgGxn+0/rt9+jNNHBxXIs/HVrSTusPmuvX290kg5ptBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZntpnL+/qKMewEFiLlgCAcr3/5qvrk8VwoW1W22kzCU=;
 b=nSeW8E/SvU3WG0LB9Aaj4gtNDJMtZaS6qLlTar8E4u5SFbP3sCWReilpv/OEVpyrzRlO07DF2RmrDQ8/KQqE8VQYIYD2HVeCy0jw+2PBLMNOCEWQmLoTqhQbr2Ub/CBTzjhDkbfm+cAPkc/+YdyW0h0b3CoHGCQ/F7iL38f1G40=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6600.namprd04.prod.outlook.com (2603:10b6:a03:1da::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Mon, 15 Mar
 2021 21:15:41 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 21:15:41 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>, Keith Busch
 <kbusch@kernel.org>
Subject: Re: [PATCH] nvme-tcp: Fix misuse of __smp_processor_id with
 preemption enabled
Thread-Topic: [PATCH] nvme-tcp: Fix misuse of __smp_processor_id with
 preemption enabled
Thread-Index: AQHXGd5tbQRyUGxAYkC7WfjgH8x9sQ==
Date: Mon, 15 Mar 2021 21:15:41 +0000
Message-ID: <BYAPR04MB49650971EAA4BBFEEA34B4B2866C9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210315205347.353806-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ec2af6fe-936e-4819-94ae-08d8e7f77d5b
x-ms-traffictypediagnostic: BY5PR04MB6600:
x-microsoft-antispam-prvs: <BY5PR04MB660045F33BDC40E417741F98866C9@BY5PR04MB6600.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GihoCz2/TW3UbC4nvv22SEHskkSKVvhcqqPsq6W5q55nv9262WYQvUu6GC02Zroy0U/YDuggXcecbpyCWy6Pg18Ubq7AADcHN1j6JcQLWIC+NhqySdptZrJfgBbXcMmeAQ99R4QoAoDi/AuIF0Cqz2CSEqn6cC+wpyTjxzPibZSUghwzTrqnKyx9Qg8UXg2MqS76d/r4JOiRu9YCtlUzlHBmdHZ9fFyyWjQcswMQKfuLX+LPeMnmvMCC/uLy+OZXuDdlpRsqJI2xUTQ2bCVvoPja85U4iMmSbJNa4lq4zg8xIa5Q5CzXGtCYJyHs30mnoqia5lfjP7TVRjzd1swp11pxUG2WY+invU/tieuZabpgwpqoVEcgJOVsj2YphHvWCAvdRzQgDjSFGRElMotkjKVFp0vMkM46/RqaqcFcl3ibHbZG6q+GWnXB7fNyH+x6asN+lzea0O6vF98WlkF11j+Ec3UfHSXI9AGnfjd149qI5ekQbH1MXAxCoeRLCUAHteCsBe4n4cY4S0ybHLActYBKOAQWMAVsfYDNZzCE/32dxszGJ56TtS3noBX3A7rB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(6506007)(76116006)(71200400001)(8676002)(8936002)(316002)(53546011)(5660300002)(2906002)(186003)(478600001)(66946007)(26005)(110136005)(55016002)(83380400001)(33656002)(4744005)(9686003)(66446008)(64756008)(86362001)(7696005)(66556008)(52536014)(66476007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?uQyFsFpKZESFfxhOdwMYVV7yh9bSeU6r9hGj0v1OfMw0+H76HymO7cVayGB/?=
 =?us-ascii?Q?8nwtHPIct7GZdKlFWcoT/j/vkQMav50Dko5t/nXYXDH8JNcAiNxNNh22zQS7?=
 =?us-ascii?Q?dv1pubfKGOdFDsr2oSIdXmp/SEqFstg/0XNvyKGf53oyXFsQMPTiUVs472i1?=
 =?us-ascii?Q?D1esJLFrwRGDuFQ/xSpEbpER4RvbPJ0Tq5ishHJiKaiAUmn2eZJm0n9CSYTC?=
 =?us-ascii?Q?cs62pYowZRaxyHMxteca6FWgCPhtkkPRJ8V40VVnASSo0WtFHQ1h/ACOOJAv?=
 =?us-ascii?Q?BdGSKeQqRW75pQdAOW9zwy6x7ofbQEazIT1VUQqCFBE6oHo8h+5q3U030vv9?=
 =?us-ascii?Q?0qdnjZOOfe2xzzLcYkBco1mOFNfgdoZaCMd0ed2zMMiwz/lSltrXmb4fIzjf?=
 =?us-ascii?Q?nq0xbt8ZPjCXgMJ7v2P5C3qQRTSwVMFouzqhKj/CesqmvX7Ym0VeTK5HzAvv?=
 =?us-ascii?Q?dWUkFjwqZZi0UW8VDpxtVmM1KFR1Ldp6TDhllNh033pKgiBs21KiK0yfI3aC?=
 =?us-ascii?Q?dF5S1GFbTqh3u+dCfr3kIeeztcbLE9Jy9mk6dnpZCP4WOreiuadh46HSiFtk?=
 =?us-ascii?Q?b5Km2dnWFxmS/4EeT59J63yhNNBwitMB0S6TYTNrhaqel2+uuYTNlwB4tQZu?=
 =?us-ascii?Q?iem0z79GQvm1p47sKooLAGZdR8EDMtmyEgWgEi1L91Ka4PF1IxxkKW8m0GXn?=
 =?us-ascii?Q?kc22WUfBzGEaJycz//E+oCRKb13+Jw3cPJUG6ZRaULtIq1Mup8WON7Ut4DOe?=
 =?us-ascii?Q?VJCfmO5997Mk/QCFRnDrrM7743g2Cgn8FT0WmFe3OOiQYNIGw9Rk7IGe6JRm?=
 =?us-ascii?Q?5293NLzm2CoiHtO+/ZPzgt2YZmRRZK/5vMQyI2c9nwnrcvP3m5NSMW2RtQLC?=
 =?us-ascii?Q?enz/AWPQMph4T8DActYs6IoGe1Qty4/EOt0cdQMQ7EQ6fUoJtJHjAk/zAqUl?=
 =?us-ascii?Q?Q89yWWvJYjHGjVo3yBMlvBnlBc7G9JxLw9PEMigPvSjMN90yLXN8UJu1DSAT?=
 =?us-ascii?Q?o+E7SF2qTSHdvXi3400IcLQVXdnVcg7juUDR5YRr3QGnNHIxOAtXInzctYRA?=
 =?us-ascii?Q?0S+3SF2508r5+obm9K95zIy9i/oBnu/U+UF6yrD3nMWpU1KU8uXosC2ANbSB?=
 =?us-ascii?Q?aicaeX7xRGSMcr0IrQSa8vc3FirH6Zf8tQ39vuozpfRMU4ebRFhxTx+g7PFz?=
 =?us-ascii?Q?NOUZ224IxXFl6vFL4QOfqjnM+7380KXI6bYqZD5ZBpVg1Cf2x5DPCm5yy9tT?=
 =?us-ascii?Q?cwgwNz5qGBn8zEl5qn8bZP7yyNENxcPda/aVvBTKdowQTdjIoY0DX0ffBpeD?=
 =?us-ascii?Q?S4/JRp7b0IsRLfkGK+RzczfS?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec2af6fe-936e-4819-94ae-08d8e7f77d5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 21:15:41.8029 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: abAhWyvxSZkjbu4kn49aJH2lnTWNJJ7RujBEpTyWt00Pzn4UK7EtN3u73hQCeTfaFg6t2GXMVeHGMHCIfQCnM09slI0I04bR+TfRExJ3kd8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6600
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210315_211545_708933_FC472ADA 
X-CRM114-Status: GOOD (  11.86  )
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

On 3/15/21 14:01, Sagi Grimberg wrote:
> For our pure advisory use-case, we only rely on this call as a hint
> so fix the warning complaints of using the smp_processor_id variants
> with preemption enabled.
>
> Fixes: db5ad6b7f8cd ("nvme-tcp: try to send request in queue_rq context")
> Fixes: ada831772188 ("nvme-tcp: Fix warning with CONFIG_DEBUG_PREEMPT")
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

This patch adds the call that is discussed on the earlier thread.

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
