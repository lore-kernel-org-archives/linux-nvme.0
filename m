Return-Path: <SRS0=HgRT=5J=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1107C4332B
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2020 00:34:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 953A42070A
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2020 00:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KzZxeYHZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="cpm5YeDh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 953A42070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PofhQ64mf4fxHDY3EM0wbdKF8l+ZuIUayK0wXvaw5G4=; b=KzZxeYHZUzKG3V
	QSKmRmcO9XZOySBBTN85qnN3Lx8yZhnSPZIoPpjEcphbpJqmv3Kx48ZYQzvhw1yiT4O62Jd9M6YMM
	Qf2e6zrKzT7G917wk60Z/g47WR2kGT7j7XIlm6WeEHmliAkvspf1lmtAm3bS3KhafngblZWoisDeW
	eUGptFDm8ywH0DBmcnn0xJNZlsWXmaCa8ke4hMQjEVvQLgGUJwN++V3C7DVEkXi9gtEUSF4W+y4yh
	o9lDNG8w+SEOmgdL5LToEB4IY2fUne1JRnRe+irTArThW+QG836ujCM4QpbZy6XLVyGHjwIc/2JI8
	M5oastvv78YX+ZMtP8qQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jGXWQ-0003xp-GN; Tue, 24 Mar 2020 00:34:22 +0000
Received: from mga12.intel.com ([192.55.52.136])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jGXWI-0003xL-Ty
 for linux-nvme@lists.infradead.org; Tue, 24 Mar 2020 00:34:21 +0000
IronPort-SDR: GZzeWZ7nck9Eui62xHuRLa+luktqHy5EhFov5s0gZqS5qUwvSx1Z+SWeN7DezQUJqad0qTZSzg
 ChA6gNo+Dh8w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2020 17:34:13 -0700
IronPort-SDR: wc7pqCCM7UbvBMmLPmgzUoi2DSX5pFMO+0ix2KSQV5pUXkGQm1a+Dfg9T+zBbbddlSQ7CdI+9K
 ht9/5k/MG4Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,298,1580803200"; d="scan'208";a="281417984"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
 by fmsmga002.fm.intel.com with ESMTP; 23 Mar 2020 17:34:13 -0700
Received: from orsmsx156.amr.corp.intel.com (10.22.240.22) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 23 Mar 2020 17:34:13 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX156.amr.corp.intel.com (10.22.240.22) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 23 Mar 2020 17:34:12 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 23 Mar 2020 17:34:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5SCVyV6F+YK65lsF3NR6qsvwV0pX+P4cF0lQq8KlNynXJ60/cy5q/sd88D5yRxGWMOLbDKG6hQ7n6aOWK8OBcsZ5LfBrbkaGgF4tIuBPUD/D32cotj+1lEFjcM7kZSpw+MnuZQcbxeT9U1EKlhVOQ03U6IoJbmWZLkzWIPvlx3V5U4nUunOTqvvo/3e6McIC1SzCi/WYimNhulBLYc1Faa95Gq3CNFuh7dRxfahLfOM+l9ZZqpJ/E011vuFg4Re6AissOQIZDKbmFP3mB5zKoefZbsfXfHoxDY8U1TrzWJ4USERyDjK5fj1/9oBXiECQacKmrEpmb48HI/txY5OIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8L7bmDlnMZKOA74+DS0Mez9e8l/i/vb2uF7o6Mr8q4=;
 b=LuAuQVaN+K3uqGTY2SbJyqVGoVPj/5cdwOEL0JHWVPTWH/5yUteEFvKeGgyZtBY2FDGBNiI7EwLMb4fktUFGlwersxzqnnIXNz2jyX+o7xigILq7JHv2m3/jKJGHFu9NCN0M62VjZ1fZQNP53E0yZ7RYOSKtHoufvzg+AGYyXcgxKzXfqA0sBQGf5pNljUPwjS2xgb+8b6wf0WJmVbKNP9bmVL1dvxCVeDn5Nqn4N2ocln7VlW4cZhpe1zsS6xpqOwaei0rLPsPlAHWS0nADaXFJOb/1FZCA3wRYkQZ1TQySieZ5Dkp6W2SPa8hIAo/lwOABu2ht6U6z6kZdSRJyjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8L7bmDlnMZKOA74+DS0Mez9e8l/i/vb2uF7o6Mr8q4=;
 b=cpm5YeDh8ubf59Fd3XytBVdAR22ytImprPl3Ko9KwlUZFcIkT+n/p42wOXJxI8JNOAxgawwJnJYeYAusoDhjUlzygmU3zTA27GDbn21OpoUmvC0N4T+DDHnsFvG3qI3+qa1ukjT6mMI0deeFFY/D5sTzWv5b+YUdIuzYVL/qzw0=
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by MW3PR11MB4729.namprd11.prod.outlook.com (2603:10b6:303:5d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Tue, 24 Mar
 2020 00:34:10 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::c5aa:a4e2:63e8:d7d3]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::c5aa:a4e2:63e8:d7d3%6]) with mapi id 15.20.2835.021; Tue, 24 Mar 2020
 00:34:10 +0000
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: Sighting: Kernel fault with large write (512k) and io_uring
Thread-Topic: Sighting: Kernel fault with large write (512k) and io_uring
Thread-Index: AdX9ef3PKRC8AConRsKyiM0hXsW0JAAEXlsAAPLBmRAAAElOAAAAPf0AAAFDntAAAIcLAAACE72gAACxaIAAAG+RgAAAPZaAAAE4BhA=
Date: Tue, 24 Mar 2020 00:34:09 +0000
Message-ID: <MW3PR11MB4684610CA3A664EA62EE7780E5F10@MW3PR11MB4684.namprd11.prod.outlook.com>
References: <MW3PR11MB4684AEE8587BFCC0A9F41DE4E5F70@MW3PR11MB4684.namprd11.prod.outlook.com>
 <4eaa3e21-833d-f6ec-3b14-58dd2022a381@grimberg.me>
 <MW3PR11MB4684AC746EE60B9E5D0D46E1E5F00@MW3PR11MB4684.namprd11.prod.outlook.com>
 <82255be7-fb89-c66c-442e-6fe04239768c@grimberg.me>
 <52ce2f94-e11b-c537-63d2-e9b72cf1b00c@grimberg.me>
 <MW3PR11MB46844ED6C11993D7F5D911A8E5F00@MW3PR11MB4684.namprd11.prod.outlook.com>
 <092f6922-ab29-c2bc-04b8-0d0c95c14ad6@grimberg.me>
 <MW3PR11MB4684FD29002D6D1FE29A4A0FE5F00@MW3PR11MB4684.namprd11.prod.outlook.com>
 <2f68591c-d2f1-f632-644c-11de97511a45@grimberg.me>
 <MW3PR11MB46845357C4C1651D1C24CEBBE5F00@MW3PR11MB4684.namprd11.prod.outlook.com>
 <112775b2-ef19-7e8c-630c-22bc529536cf@grimberg.me>
In-Reply-To: <112775b2-ef19-7e8c-630c-22bc529536cf@grimberg.me>
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
x-ms-office365-filtering-correlation-id: 9e013cfb-4bee-45b8-5143-08d7cf8b11b2
x-ms-traffictypediagnostic: MW3PR11MB4729:
x-microsoft-antispam-prvs: <MW3PR11MB47291241A00F5E64DFD1D187E5F10@MW3PR11MB4729.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 03524FBD26
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(346002)(136003)(366004)(376002)(39860400002)(316002)(6506007)(26005)(71200400001)(33656002)(186003)(66946007)(66556008)(110136005)(66476007)(86362001)(76116006)(66446008)(64756008)(478600001)(5660300002)(8676002)(55016002)(9686003)(8936002)(7696005)(52536014)(4326008)(558084003)(2906002)(81156014)(81166006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MW3PR11MB4729;
 H:MW3PR11MB4684.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rK852PO56wdpwNaHV3NgylIp8pV1s8FU7siKSEDoWtwtWQ7p3RnA2Z07m0XBlQU6fHFZFdfcg9rjd6+ZUnU0ehThhYfSNpNSQzZJrs2NfjgdVfttALtYG/izQzaL957HfBitsogkp2R4VYZegV3T6/hIR3OfAwFmi/P6fZF19Q/lmT4uYNlwmhZ+sjSsxUiich527RPf0Npx1bo1cdToSxfO6o/5D8vs2DbS3LtF5sZdHgiaMEyEzQ7Q2/Ff9ds6uT2QI88l8z3MJsbgicvP7YRMZB/J1WzAdQcmRRcRRo4sA8Jb6ofHj7EuQv8c1tyaU/brJBdfDnGiKclCR3wXhHjqB6VzOaMjJBO2D/6kq02LEXYWYzA7ELuDnRVLGS94ptkCePoVTuoXAksOAS8AF+VQzNi4obADeDWRd3vmE6koRYTNzByKC3XKLv9WPZi/
x-ms-exchange-antispam-messagedata: mACU3Q5J/oMh8XAiJwgMkAgu9EPBbR2txFuYkD1hUJEgRtDvs99RQaDA7+XiiQOcnHRNB6Jpeo5YbAtac0Roiv572IEVOpf72h2m4cdYtXTr90Ylgf6Vv+zE9/Yoq/OQpFKULUakwPQG/PwX8tYltQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e013cfb-4bee-45b8-5143-08d7cf8b11b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2020 00:34:09.8963 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Asi0z9IAQI0OC6dtwDGN+0QbFPleAEIZnOeEQiwdX6lrDjL9gqbyxTSJO2tBVuBUTdtujBNlq684V94OxESPQSK2akEMt6C05elAHjeNbD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4729
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200323_173420_340085_D0D56852 
X-CRM114-Status: UNSURE (   8.39  )
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


> Does the I/O timeout only happens when you run polling mode (hipri)? Or does it happen for non-polling I/O as well?

So far have not seen a failure with io_uring (not setting hipri) or using libaio for same I/O pattern.  Only when hipri is set have I been able to reproduce the recovery failure. 
_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
