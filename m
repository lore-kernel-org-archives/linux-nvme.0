Return-Path: <SRS0=QV8n=5I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3739C4332B
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 23:16:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A41B520719
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 23:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XoRk+JuR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="A3jtzugD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A41B520719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r6psvQYDffnvESdPVP4GvfyoNDFAc2uqrA4CwUaILxw=; b=XoRk+JuRjDJ/w1
	xNcHZ+4uX8HwIWYrmz2O1qx6FNnHM2uuH60ueBgBeO0CAPZ5xEDnrZVbKwA6/0WbEOE+42cDN75ME
	5dFH33ZWhKrEx98dvKUnGJJi5bC4X3xAVxMwYob5hEfKUsYt2yo2Nw+yrqwQPysCLtfs+B9zBvLYP
	MDA0uiGDk4pOA5Szge2GVPeavknwpLx2oiSl1rsnVYK983DGZOKhj3RsNu2RhISRwndOGz4zbDzSR
	kIlQ82S58QNmifuE1C1oA9NlmsJcOudFag9491NqQ80JgnE+MJQip4rNm7a2m8lwSFqpfrhXwyfhT
	Fy928S3CEMKX43fAzndw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jGWIo-0000FY-A2; Mon, 23 Mar 2020 23:16:14 +0000
Received: from mga18.intel.com ([134.134.136.126])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jGWIl-0000Ex-F3
 for linux-nvme@lists.infradead.org; Mon, 23 Mar 2020 23:16:12 +0000
IronPort-SDR: 1Sevwn5Fd6dyzKWnZKhMgegGt7XcrJiRSiVigpjOQAC4shhXcG/pSvPQPaSqRHl5BNwSPjMeXF
 fZCyG/Tip/yg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2020 16:16:09 -0700
IronPort-SDR: r/mmD2BvOmYLr0Iz8DTtajzQ3TTtgyLRGU3atQVY9kxhED9KMqkGYqx4wIuzJdyTX0q+yqj2wm
 iXADiHRh0ucA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,298,1580803200"; d="scan'208";a="246350345"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
 by orsmga003.jf.intel.com with ESMTP; 23 Mar 2020 16:16:08 -0700
Received: from orsmsx115.amr.corp.intel.com (10.22.240.11) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 23 Mar 2020 16:16:08 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX115.amr.corp.intel.com (10.22.240.11) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 23 Mar 2020 16:16:08 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.50) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Mon, 23 Mar 2020 16:16:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrySJuNO0DH7yc0DOA9WcMmpRX9oMjU+O3B0oSityLGRIW0mqULA/1mYGAbnxArrjGA59IA/Qav9tbK4eA4Bz9FxVPOyCBighW5IgVIXjb8+GCK2rZpMstRtK3M+RkXIDxUKs9mbsrjKKrYP2dVS2s0GmqIUVX9e3JUaQ2Beef6ug/UQDHczI/lYC744t1ciXMXnlM08CSbue0oyJYbGBBvpkYvW8MlRj24F5PJm/H4MYthiiz5p18gmGhER4ZKGd8ezLt3m3l3sWXFoGamFaaexkMr0mHMHsw17vFZxrvml4+sadAEPzhdY3d7hnnRh0pmOWrbarbSHL0PuXgtt9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J958vMl3CejsGSvxu0cGXmwL5i6LehOb82+QhgTc/28=;
 b=Exmv1wGR/qd3mWO0U3Z00gBjziy0yaY0v6ISGcA2iLpgeUL5WLGoQMOVjGuOKXwxd1iXp/WLRedsCezfsaG4sFYA2TrrxUrDHBcmJrV7xYez/taRoTU/waxtobw7j0Wov9RRphZFMQsWJ0UtTw2X6E+mdiCkb9fL20pJK2z92BF1Yx2j21ZQEOEOGiEyyEas0tZAoFiVucA+erXeOvQRQykS7XMXY4Xq+1JwkvNhSEc9lR8P90eOHC0WZ03Tv0k6zUQbNRt71BbKD5ARuIOWH8f65rEtnvsEUOABdrSxoOp4KYccmqO7jm7uPCEsCWYGsqJxrrR0QOvaWKnlmmbCYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J958vMl3CejsGSvxu0cGXmwL5i6LehOb82+QhgTc/28=;
 b=A3jtzugDg6bJj6Hu7YsqlWSpVGzXuG1YvYZD/2iAnvG+ZgLMh5aicU6zrBt3fFM3CZ6CvNb9KhfdycBunFMytG5yRFDAzduDNhm6/8Cq2uCbkEibz2fDpo2dHGnOBCd46pdX4KlZHVVkSrEY9BHPby1W4qYA/ZfLcCDVGlBYp6c=
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by MW3PR11MB4569.namprd11.prod.outlook.com (2603:10b6:303:54::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19; Mon, 23 Mar
 2020 23:16:06 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::c5aa:a4e2:63e8:d7d3]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::c5aa:a4e2:63e8:d7d3%6]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 23:16:06 +0000
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: Sighting: Kernel fault with large write (512k) and io_uring
Thread-Topic: Sighting: Kernel fault with large write (512k) and io_uring
Thread-Index: AdX9ef3PKRC8AConRsKyiM0hXsW0JAAEXlsAAPLBmRAAAElOAAAAPf0AAAFDntAAAIcLAAACE72g
Date: Mon, 23 Mar 2020 23:16:06 +0000
Message-ID: <MW3PR11MB4684FD29002D6D1FE29A4A0FE5F00@MW3PR11MB4684.namprd11.prod.outlook.com>
References: <MW3PR11MB4684AEE8587BFCC0A9F41DE4E5F70@MW3PR11MB4684.namprd11.prod.outlook.com>
 <4eaa3e21-833d-f6ec-3b14-58dd2022a381@grimberg.me>
 <MW3PR11MB4684AC746EE60B9E5D0D46E1E5F00@MW3PR11MB4684.namprd11.prod.outlook.com>
 <82255be7-fb89-c66c-442e-6fe04239768c@grimberg.me>
 <52ce2f94-e11b-c537-63d2-e9b72cf1b00c@grimberg.me>
 <MW3PR11MB46844ED6C11993D7F5D911A8E5F00@MW3PR11MB4684.namprd11.prod.outlook.com>
 <092f6922-ab29-c2bc-04b8-0d0c95c14ad6@grimberg.me>
In-Reply-To: <092f6922-ab29-c2bc-04b8-0d0c95c14ad6@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mark.wunderlich@intel.com; 
x-originating-ip: [134.134.136.216]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ff8ae16-a55d-4808-9d51-08d7cf802a34
x-ms-traffictypediagnostic: MW3PR11MB4569:
x-microsoft-antispam-prvs: <MW3PR11MB456986327CFCD633F487FA26E5F00@MW3PR11MB4569.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0351D213B3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(136003)(39840400004)(396003)(346002)(366004)(66446008)(110136005)(316002)(7696005)(9686003)(6506007)(4744005)(55016002)(5660300002)(4326008)(478600001)(66476007)(66946007)(8936002)(81166006)(86362001)(33656002)(64756008)(81156014)(52536014)(76116006)(8676002)(2906002)(186003)(26005)(66556008)(71200400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MW3PR11MB4569;
 H:MW3PR11MB4684.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hSDEibMzcWsaWYhAjpUZGQY0UHkaPLRDaoAYEWAmucHzExhQYp4LDaH6Q/VgktK+xk4RIl8qJSiGQmrfH2SwCj2GST73zf57o4366UTYP7oY7PKqG+Q2Hj5S993mLXKx/EUJI5qlTTHdNmjJqIkQJ6c1ZxMBDL9f/YL54KQeBsiUfLHMlFL4QbVYBfdMphYe1/K4gBdOhs2zp3WW7oxxF9RkIhT0jSX1fzYGR+Iz9K05L4uQqrvNs0mR8xs6ToHTg1sRQB2cL/ZLsj37VUCjB40w5vRUXghx5Z9MKiR9dvj+kJsshDQcRvA3Qral6GHpCbIV02/yAJcyhwUTFzTw2Vys2LkJDR4VXufArUXJmu5e0FjRtiKeVn1efKmesDGKhmH0I7AKm7x1ftEKL2YNkqYsteWeYNwVm1mdUV0SV3tAqVhhG7MLTYm91Jncdrs8
x-ms-exchange-antispam-messagedata: sLJx20sbRFxkl8c7C/WZHNYL05rYHDZlEPXzVr5l0yRhr7ycL2u21d/WFcS61ChYLrMHVyplcSa+GLu6O9UlMfSNuqrhfaZU0J813bAiDraXtu9IfQQ/bozsayULwxcO1bWAI8YYsEuJqd8/eq4kkg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff8ae16-a55d-4808-9d51-08d7cf802a34
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2020 23:16:06.6143 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AYzl223f2cLtbzRzxwHg/1N45kq0scNSdvuMkkw+Gc6T0LfDBAjyvbIFV0jRtIUy74EFzf/8S5M4kvthoQxKvJaldFPihIpp4jSt5tMQ8ag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4569
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200323_161611_578899_34D730F0 
X-CRM114-Status: UNSURE (   9.39  )
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
Cc: Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


i> OK, this is a needed fix then.

Yes, so far this removed the kernel fault seen for large write (512k) + queue depth 32 + batch size 8.

>Yes, this is with nvme-5.7 tree right? which is currently based of
>5.6.0-rc4 correct?

No, was not yet able to get branch 5.7 to build with our driver.  For now am running on branch nvme-5.6-rc6, the other branch mentioned by Jens to try.  This appears to be based on 5.6.0-rc3 I believe.  Will re-test on 5.7 once I can get it ready.
_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
