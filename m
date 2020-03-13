Return-Path: <SRS0=xptm=46=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F77C10DCE
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Mar 2020 20:46:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E38AE2074A
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Mar 2020 20:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JkbMB355";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="LhbqvHDe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E38AE2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/JjNLRaXS7uZM6vyXdNOWc/6RPdiipslI0NrtDN3rKA=; b=JkbMB355Wwtkd4
	Wdod2LBC+O/EbbPRz+kdJ8n52jtR3a9ydOpYJDsB5Jb6fVJrusKz8CdhtE0Kqg4Eson+udtDZl5CR
	clbPQOeWY7QKrFttFZDP9rSxnCmcZhdfhvMrDPEQXe1mLS90RkVziPiPvEsFanne5oBXgqkVrahvP
	Mu6K2OKqSiP3neGpfEJJyxcgV1WMJ9r0Oe9giXvGZcH38+Ip+iAW/ex3DaKlgKAMfcFJY7gQM+aAy
	Dx3G+mxY9x7RY6YjTX+UciSK9ZrINsh/R/c+I95su/IREupd/uQNcdUbMq6ijMaeVuLjJrJCfyW3g
	ZLrkBJ1FNFofSO56uFdQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jCrCO-0006UO-Te; Fri, 13 Mar 2020 20:46:28 +0000
Received: from mga03.intel.com ([134.134.136.65])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jCrCM-0006U4-0J
 for linux-nvme@lists.infradead.org; Fri, 13 Mar 2020 20:46:27 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 13 Mar 2020 13:46:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,549,1574150400"; d="scan'208";a="237063185"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
 by fmsmga008.fm.intel.com with ESMTP; 13 Mar 2020 13:46:24 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 13 Mar 2020 13:46:24 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 13 Mar 2020 13:46:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SF13hAK0ohaaCX1G2MUMjU1dLLAiQ5pODNWXbZlLgufeneJUaaHnQzZfgKxeQL5pJb+uwBGIuytbZu+SW1kf6+iHzGtXTK0aY59dxnipm8+uBygmhotv52mVoa0qJv2Iag9twgUw8GgKKB+6P9J26NkXR5Y8syh06Y++HeVVusoErEZJFaacevqrjwaEC9D+jVRmgnllvpGHCnZy+bxUcgGn6Gtj8wF5vBBhOhIRRRYYrw2PMpRQwwxKA2EKqzma9ywaADH+Qy6E4xRzqKjpsd0ZyZV6E/m8MO5mfQynzCVzI5EYSgKTd5ilo4uT7awy2ZluSja/lJcjtkmC9S3opg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37qsxABTUtiCUAVvtOWrZGM5ucPp2MlCH+S1DZ9NL4s=;
 b=KiBcebnz7ugYCSeR1XC6+0yuaJZ4qNG1a1g8fcrKHSMgJlgIDFrnv/7KLR2l608s1I3SiBgvKmBxH43m2nx8dnKhf09I6JFdT91tHzGNES/vQpmSEwMKKfWmKuPXKGpeyVb7eCHxwr4ynFl+Hy+O3FTU6fFFNh3VVx/+RP22dLiByaWTRZVqZR2rubd8kT7PJPfJwuBpS0AsjqvVa3LQvL3vO/033gyhHn2GSdv80j1mLhmEjkf4TRsUeMMPBVlHIrzbIlY1dBVy+kz1D+FJHt4oDEkeCtI4tCn7eGTyxxe4DUkplOCWugzsSGvAkMQ0JbIgUMdtnG8/RUDErcqbQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37qsxABTUtiCUAVvtOWrZGM5ucPp2MlCH+S1DZ9NL4s=;
 b=LhbqvHDeVNF8Pny+QUirnFvWkQFc9gpubuxWoBetUVWH1XnHc9KHBm/LCRg/o6s+gT1J1T+Drcpu6h+YFMRlJsK/cW2VMy469NGzAcsQVx2d3YcoGx65GnYYrAzqaDNYx7J21gQl4rMgOLIMBmEUiYBw/KsePPj6b6QHsFAbQTg=
Received: from CY4PR11MB1351.namprd11.prod.outlook.com (2603:10b6:903:26::9)
 by CY4PR11MB1670.namprd11.prod.outlook.com (2603:10b6:910:e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18; Fri, 13 Mar
 2020 20:46:22 +0000
Received: from CY4PR11MB1351.namprd11.prod.outlook.com
 ([fe80::c109:7bc1:25ae:53cc]) by CY4PR11MB1351.namprd11.prod.outlook.com
 ([fe80::c109:7bc1:25ae:53cc%12]) with mapi id 15.20.2793.018; Fri, 13 Mar
 2020 20:46:22 +0000
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH v2 2/2] nvmet-tcp: optimize tcp stack TX when data digest
 is used
Thread-Topic: [PATCH v2 2/2] nvmet-tcp: optimize tcp stack TX when data digest
 is used
Thread-Index: AQHV+MMD8V+PCr32OES80G5qVhZwNKhG/nPw
Date: Fri, 13 Mar 2020 20:46:22 +0000
Message-ID: <CY4PR11MB13510A14BD8232B39EA73A19E5FA0@CY4PR11MB1351.namprd11.prod.outlook.com>
References: <20200312230639.13946-1-sagi@grimberg.me>
 <20200312230639.13946-2-sagi@grimberg.me>
In-Reply-To: <20200312230639.13946-2-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mark.wunderlich@intel.com; 
x-originating-ip: [192.55.52.199]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3624f896-632e-4819-a396-08d7c78f9712
x-ms-traffictypediagnostic: CY4PR11MB1670:
x-microsoft-antispam-prvs: <CY4PR11MB1670C2297D9D2B1A2AE59F9AE5FA0@CY4PR11MB1670.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 034119E4F6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(136003)(39860400002)(376002)(346002)(199004)(8676002)(7696005)(2906002)(4326008)(8936002)(81156014)(81166006)(66446008)(6506007)(52536014)(4744005)(66946007)(86362001)(9686003)(55016002)(66556008)(64756008)(66476007)(76116006)(5660300002)(110136005)(54906003)(71200400001)(316002)(26005)(33656002)(478600001)(186003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR11MB1670;
 H:CY4PR11MB1351.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gkT5TRHqdxW5Qq16h8t7MUkUpCb9pJo1AKg/8s5HbbbKHXUkwVtMAfCRySXpNUw40WDELgDnlVN39OdQP9txIJG7hwdEl2WknOQVUslXL5Gf2Tw+psWOjrN6RzVmhKoy5aV9b0c3sO+9mP7YkhcStcxV7INP3oX/WmojJz1pWYXvCKsfS2178LyuemSK3YINtgtucMDqdbHyiDWIXSF0B0NdHr9qibBRpafI5VKBcOCn0OuCLaipmvDSGy2wa91LA/YgVtn3Q5zzU3qtmsyRrKmWNq2+ASpOWYwahNZK25hT/N/a3qaxF2rbI1BmdzejrC1KDVGAIkjOhFCKRYyLmGn5Gr7Ady5sPrNNeqmnLeU/M3b0zbZPjfIKANyKHT7PSR2ZPE8qL7Yo1Jki0/U23buqdT2h+1gbNY6I74VdH/urGXAVZ2XRGBWGw24MgVX3
x-ms-exchange-antispam-messagedata: 8h9ysYFtCWDGGrK0G13JEvAkqtFePD2KXwrtB17k21R3Z08Ckcz1l5++SBQSe4mCdfAhB0ilAXGwqdWJmrMDxVF3axggLQj3qcAisuMX+Ab/7I5YNqu1WKjVSU0kH/njRczLtqq7NKDxiUsE9iviOQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3624f896-632e-4819-a396-08d7c78f9712
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2020 20:46:22.4306 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g1yAcJ6pob9HttiDxUfsfWiHRfbUpVHAmiQDnu3vac1GDGdsgsClpa8NDJyWa1ugXzrVbUwF2O0kOvpznXV6VjRMHBHt+P7jVZYEXYP4J48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1670
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200313_134626_099430_E157BACA 
X-CRM114-Status: GOOD (  10.75  )
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> Subject: [PATCH v2 2/2] nvmet-tcp: optimize tcp stack TX when data digest is used

> If we have a 4-byte data digest to send to the wire, but we have more data to send, set MSG_MORE to tell the stack that more is coming.

> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
> Changes from v1:
> - fix compilation error

Looks good now.
Reviewed-by: Mark Wunderlich <mark.wunderlich@intel.com>




_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
