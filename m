Return-Path: <SRS0=SC3Y=FD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9668C3E8C5
	for <linux-nvme@archiver.kernel.org>; Sun, 29 Nov 2020 05:12:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B604520786
	for <linux-nvme@archiver.kernel.org>; Sun, 29 Nov 2020 05:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bwSL31Bq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jF5z0YAH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VOe0JD2j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B604520786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=e6pwdMlV4CK3OKOutBeoZ+5DPN+K19n2lBZ6C14sAxw=; b=bwSL31BqWsMsUqTngi/eMqNSG
	usagFud2nO8KwNAzjVhkBlsJqNoGIRL9+KGW1g/dSr4Uip/EdX6Qyc9tfmF5rM8HOl+oRzPi7j+IN
	xs4wC1Lu738Ledku32w04pVkHZIupTp6cZcqgrw79bKYvLmKq4VbBTPp6c9X4kvcq9rQqsTrrs0Jn
	Avtf5NgfUm//jE01+m7EOqYem+TdT8Eb6D1wXgiXUkOWbbiRGnfNcUuE+mK3ew9oYr2P8L7+fMeyw
	BUa/eqkiHlCrdRv+wb3iNZuL3uJG7PXUd4FX3UG9PrujjjTnKJgGQVK3DBEtQVZe1cngvhm9cJDDY
	t8he3XAkQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kjF0Z-0005E8-89; Sun, 29 Nov 2020 05:12:23 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjF0U-0005Dg-TD
 for linux-nvme@lists.infradead.org; Sun, 29 Nov 2020 05:12:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606626738; x=1638162738;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Q+9wc14wfuQMmnGUaM9/mziQvC1sLY7wMPn3qSE38LY=;
 b=jF5z0YAHxpR3w2ocGkKgDMDGItSjaPrTVpUkr+QnKx4RobO2BDtv3MhS
 hsQGcJKSquqWy8Kxbgg47Gys8eFSziMlnp1VfSkJVUIigAx/4yhL/IWK6
 M443ixxs2OTYBNNKhClbXjsTMvbnirlkEZzihEc0OnG4dbxy7AkapqsIy
 o3G2RtZU6/h3evHNl+8O2TGlI2Ys0k/OEqcGkPNWYTUVHl08DaqBLHLlW
 REJxrkMYrgzN56OC17S/1M7tIYXUrZ6ZcRVuNK32ehKDwl/962y2tLRy6
 5ALpMWcxcrb8ESiejz6g3+DjrJB3zuK9yhiXZlWoNyFMsm3qnyMrHHne3 w==;
IronPort-SDR: QpFT9fdXxa/REvwLe7IFHzZW5O6yCn45WhqmlHD4wt0FI6DGEbNVGcru4mYNDe6cT5vzAemGC2
 GjPggiZFUz52+10ca2ss+kIJQzYXiONYvmLKCHPFp69RHSvyMqClvthOZmj5ZnCOyDqSj793jE
 qZ/qYNCcQmeAveeVfaUdMIGQYz+DsqC2WxzrYw9W83hsZpiUfUcpJJHn/8YBGpHj97xgRuQXIU
 pxCU0VJgWe51pTtW8aifllCiUnmvZLYm3T0WEbCjUFVQT/j1hFvwdjankBDal++fsPKFrPxu0q
 XNo=
X-IronPort-AV: E=Sophos;i="5.78,378,1599494400"; d="scan'208";a="263842854"
Received: from mail-dm6nam08lp2042.outbound.protection.outlook.com (HELO
 NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.42])
 by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2020 13:12:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZqpk8uWm1RlvVcHfmvpn7IAW/hpqAz+OzZiETMZxt3cdpYRBSIUh6PSEO2KmJF8Id4ZjdpWtFYvDan2q8e3gvD3g+C0hyONtH48OLrWHS4xwzIfwOtv9PsmrHjHXLc2f+/ESAulSFz8B/TzrAoTjCZ6fbA2UHuZnogpFrIp9IAi9zJ9gQAAaA4YwMwCQIlTP3pfs3yuGlUHFg3xLFMWxkdXwyC8BsixZjItteFatBHR0w/f1d7Ya5CLUza1Oask6EZzK3sW+YyEM4CxiFYbn6L4k4AtC3hezZ/Lvk8M/Wl9xC+hE8e5MbyUlNBVN4vJE8esvyU9i70tLCLFTDSs3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+9wc14wfuQMmnGUaM9/mziQvC1sLY7wMPn3qSE38LY=;
 b=hDMNPF3z1yXU0LDUaXSmqRw3/AAxbsM1h4fRI+qHci9E6oDQ+41QY6cft+ssHgUGWns78zPCJh0jGVkaZyVagnc8d1Rwq3O2PpFQfedGCylGaAu3IZ/mbg+XzqVg8Nt6edTykPogYRds4mxLFsWVHbRSlTV7d6aD7fPl0889gc8yIRZmryBdDRytsGb964AyyCrHPBd870hh4mCpwPdxuEtOS8hM1OqqACRbX25Drr2pPGtWpvyx1X3+fSSsnTXVlh7HnHg/38l8BwjPbok7h1JNTIYyHLbGtj/HFuUEeiEN4JHppy3jA8LwHo7i3L5KhyrpR6GcQkA/t+532mSZYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+9wc14wfuQMmnGUaM9/mziQvC1sLY7wMPn3qSE38LY=;
 b=VOe0JD2jBGsMED3wg6HXBWpBH+zQN8kKTQ3VvZsR4BpO1XU7jbt0T4oitVZzejaMq2CmhsFBg0ZZSp3qpEcJUP9lq59lN9VZIQS5VPz2TU640b01xRVxSlP8fsCEr7WplIQE4xBwjkG2PjS37iemR2jC3t2UDZqtg49by5dGh2w=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4104.namprd04.prod.outlook.com (2603:10b6:a02:b0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Sun, 29 Nov
 2020 05:12:10 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3589.032; Sun, 29 Nov 2020
 05:12:10 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Colin King <colin.king@canonical.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvmet: Kconfig: Fix spelling mistake "incuding" ->
 "including"
Thread-Topic: [PATCH] nvmet: Kconfig: Fix spelling mistake "incuding" ->
 "including"
Thread-Index: AQHWxEUozpSyZKKBoUa2H0DZ/NMn0A==
Date: Sun, 29 Nov 2020 05:12:10 +0000
Message-ID: <BYAPR04MB496572FCDC8EEC3B232497F186F60@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201126224029.13527-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 710fbae2-b44e-42ce-e852-08d894255370
x-ms-traffictypediagnostic: BYAPR04MB4104:
x-microsoft-antispam-prvs: <BYAPR04MB410423EE69A955BB4713F04786F60@BYAPR04MB4104.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Pa2cG9xz21wpi4ZWIM+vL3XAqzNb875ue0GGKcF0fMBkvmlBH2OJjFiGJolGY/iHMVsbTaEmrJ1Bp0Cgva552uTSh1dbjtYuXsg9hV9h+1hlXUzU0HWlEM8KfvPrZwQxdX/Vl3KdBlpNqQ0voQ54eA7g9pylPQ8k8jO7tMIllkuVgUbA01gfkRN5//QqS5OY8mlbI5fyZ9Ebwrr9g/6jZfmBtbROn3GE/8VUelsMduAU/7QlAQtKUSaDjQJZbuL1LOnjhLs/7xYse/s86bwZS+e63iomrG+fg7V9CWn45Ls+fQi3nrulycwmYryxp1T
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(366004)(396003)(39850400004)(376002)(71200400001)(8676002)(86362001)(8936002)(9686003)(558084003)(54906003)(5660300002)(110136005)(316002)(4326008)(33656002)(55016002)(478600001)(7696005)(186003)(53546011)(66446008)(64756008)(2906002)(6506007)(66476007)(66556008)(26005)(76116006)(66946007)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ipJ/FzY3miFTVtC/EjPmU38RiWt622noEhx0eboQ2MtDfthSCb5j6WESQt/w?=
 =?us-ascii?Q?NHohaC7CBOa58/ljdYcqRtfcrTHpxkbnqu3mYTcCPjpYZ2jmCIZLizx32JGl?=
 =?us-ascii?Q?NtIUlW7EAh1tEwC0l2dqRWK0Tk0aJbuFlA2iatYZLavWUZkCMuQVE0t1R4Ib?=
 =?us-ascii?Q?VTE7vs8sK/jfuMhK2j3DvO0o6yJxRFD4zBrCKa+owIO+wZQAMGldxB2Vv8C5?=
 =?us-ascii?Q?LGhMbV6231LtL+0y2SSQFTzgHt1b1hhBqOaJ6eaVH1nKXHKpZ8J2QQqc6uRf?=
 =?us-ascii?Q?FqYOYXZbcKA2QCnSidiBCEKTa2jmPBchODYQylDCABXELv2hhpqMLU/qY72A?=
 =?us-ascii?Q?a0poJxGdtgWOJUszkvb6QXfc8sFYuPRvP6hMtJ6LGpn8lQ6wCBgEwHxKC3lG?=
 =?us-ascii?Q?EDBp0KKd/C713jRKQ93SC9XVSeX5H9/t7YrgIrSO8C05KW1xzUytJ2taxyKV?=
 =?us-ascii?Q?eiXck2xO2uWdJdjSr48hdJZsuPmXKFaauY+bNFt7jwXJAu6CyMcTlJpHPiwv?=
 =?us-ascii?Q?4S6oM8dChIAyK101gt9Lbw1HIOechPehEPVddSYFu8T7LBWnqgUUo+LHa+GG?=
 =?us-ascii?Q?DhZqgIwBB1uhHUWS2F1jbkfFvWQGKhh9eycpd2RKW20zZMxxWwanmJKHFsfD?=
 =?us-ascii?Q?NhRcTVnN3yGz/ta5e7xVItNX6ou0q+UUfohys/2wHMBLaxZn0eHbEa0dpIAQ?=
 =?us-ascii?Q?j96YY4oCiRFAlh6RcRJGX10VJZYEp60BrOv9CwvzeIOSMk3mXYMMS9b9+SfL?=
 =?us-ascii?Q?SKKNHM24TjtIZdmWGu1nXHNl4vg1OCcsWdYNpQ9N3UY1Tr/uDujpn+1MMw9g?=
 =?us-ascii?Q?VinX9LEY39CLiSlp12L/iJEKD6WNZeFWcZVHpr+wPUePPDz60XdrsIyTiMVf?=
 =?us-ascii?Q?qdDtWnQ9+PUTpK/2jsteuN4VvXrlhiTljd8S694wVf9CMjoYWq6Zgxrx63Qx?=
 =?us-ascii?Q?hW0mIVvsNt7KHdAYkL6JwjyOj9MIF2rJnsc1cJ09hVfj1oSZDhQlL9zmt+E8?=
 =?us-ascii?Q?O23I?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 710fbae2-b44e-42ce-e852-08d894255370
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2020 05:12:10.6654 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vom28RUGtZUAbLnkEVbIz1QhBwyAWUlU0x8CPoHDrL2OXGjCO20q7KPLC/hHFzWmTUuSlvOTCOMdfcPkzrkYn840Dh0d4O6hwPBaWqmLRAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4104
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201129_001219_293132_9021B613 
X-CRM114-Status: GOOD (  10.06  )
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
Cc: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/26/20 14:40, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in the Kconfig help text. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
