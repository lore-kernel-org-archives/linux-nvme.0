Return-Path: <SRS0=QV8n=5I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9B2C4332B
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 21:07:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 509E1206C3
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 21:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jYe7lLyR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="mZnNU9S4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 509E1206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NSmBDZCiBF9ROzu9cvyioLWeEZByqbqvBxOHYmBhtNU=; b=jYe7lLyRCsA2Fe
	bawc0F2MRMGS3r2t65oODtkV0Zl6ofaQdI2e/jfSoC4/qy0IMzEFdMWhlvB7tQbuhojlMbpT6GeeT
	hXXvgLPgtwCQgJMPLoiGXEDX0wg7vVOYyHevpol7FlmUizI3Oiaa5kyzBo4fczffOajhjrzSKSFdr
	+bQT5k4KyKKyVAYzbCUQX5sXId7ZBwhDANoi0/3kclakbhvm5liuwP9cbRYb0bCqhRfevP1kwOnsc
	HPvyn3l02zSe8uUF+yGr2XN1BdbFKYeVJ0BUHddb/u/cuGcFrQylnl7BXLz1Mbz1qwg3qZtVo2rAu
	yrx7dh7rJPXBCXu8NvVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jGUIQ-0003Em-1B; Mon, 23 Mar 2020 21:07:42 +0000
Received: from mga14.intel.com ([192.55.52.115])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jGUIN-0003EI-Gb
 for linux-nvme@lists.infradead.org; Mon, 23 Mar 2020 21:07:40 +0000
IronPort-SDR: Szs81RSYXzJzPmV47i/YBhDTvt1XsdVK1b3SwQkIn9TXBAdwXZdAORcRUmLemKkQCGtzKv9PHI
 dgbvTnBqXtYA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2020 14:07:36 -0700
IronPort-SDR: VvFb3ROGqQJn0ZkguqtRx3GiTJvZFdd0cmCZBjgw+pdybrWAnxZadqqsxSKppHj98vKInfYYhi
 R+1Lyj5Qy1FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,297,1580803200"; d="scan'208";a="447521345"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
 by fmsmga006.fm.intel.com with ESMTP; 23 Mar 2020 14:07:36 -0700
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 23 Mar 2020 14:07:35 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX116.amr.corp.intel.com (10.22.240.14) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 23 Mar 2020 14:07:35 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 23 Mar 2020 14:07:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3NDryeFFEkUauMmkPCh8Q9YtOKyqPrMSj0DpaHFru9TYR0N4Z1aX36asOBu5ugNABLWZCtXuFMmkA2bxUkhc87QDnoWDCvSw/ZYWU6/jU6DHQQKw6Duvl6fv3ZT9bRU07dmGsL80+Fw5UUHJfugtfMEZSqF9uRmLWUdkyX3N+nwLmW/kMeslMTUK+6FwI26UHl9N7WNEuTu1X0e9lKGkPSJivvl1BO5bUUxEV3b6PRklUvSVkyM5FSrDRNPAs2/SEeYL9hKoUzGIJQfpcpMXSq2oLLs9iD4+xuGEeCKRsSnH23QQ194IA4TS6U2wBCby0Yuo/hY/4H2N5jVjfwIpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utKqGYFCgtILdJGJQURBpGF3edel5zau2ssEY6e+RJU=;
 b=bnwNoLxSmFnLR7OPoITjCr1bCe1p7hLfczbTUy7bnOPIy+99Py/bEBALrJUxR+MXFeRsq7aaX6460ym3PjRwcWjmeGq8ZafbNHSf9dKI87iMmyNoTCYpPmJfGJdVj65t5NSZPT+N49O0XpU+NvMEldkjDiJDfQsfa8GLy7duHRcMsnTYrHKZqzb2PyhEzIgC5kLsi0mfNDZlJSMuMyA84svIup6mkb/oYf4RCgDalrGnOcbmt6Ze/PE6+37kXtlZcRUqGvJW22vLrZniW/WJondfbG1hACh4zBGMgGF6BDThV4EZpJSGTOw5l4FJahmHCN8D2o7A1ePQVD7/LPT8Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utKqGYFCgtILdJGJQURBpGF3edel5zau2ssEY6e+RJU=;
 b=mZnNU9S4nSLxMdf98vck697xAyiR/Zhuuaon2sO9NEpWY9rKAMkvJpavShDfWCj0I8LLqYuzGBOn5ywrWjLgEyRBpKAYrOh9MvQRnSIAv6s1EcUhwvZD3BXy7zx9jrG6l0n3WXd9xEX2C6HCWh81tT3Bt4e9Gk1EgTxisT9Alug=
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by MW3PR11MB4521.namprd11.prod.outlook.com (2603:10b6:303:55::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Mon, 23 Mar
 2020 21:07:34 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::c5aa:a4e2:63e8:d7d3]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::c5aa:a4e2:63e8:d7d3%6]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 21:07:34 +0000
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: Sighting: Kernel fault with large write (512k) and io_uring
Thread-Topic: Sighting: Kernel fault with large write (512k) and io_uring
Thread-Index: AdX9ef3PKRC8AConRsKyiM0hXsW0JAAEXlsAAPLBmRA=
Date: Mon, 23 Mar 2020 21:07:34 +0000
Message-ID: <MW3PR11MB4684AC746EE60B9E5D0D46E1E5F00@MW3PR11MB4684.namprd11.prod.outlook.com>
References: <MW3PR11MB4684AEE8587BFCC0A9F41DE4E5F70@MW3PR11MB4684.namprd11.prod.outlook.com>
 <4eaa3e21-833d-f6ec-3b14-58dd2022a381@grimberg.me>
In-Reply-To: <4eaa3e21-833d-f6ec-3b14-58dd2022a381@grimberg.me>
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
x-ms-office365-filtering-correlation-id: e97b6394-e007-4761-0dbe-08d7cf6e3556
x-ms-traffictypediagnostic: MW3PR11MB4521:
x-microsoft-antispam-prvs: <MW3PR11MB4521001284992F0A7D22181DE5F00@MW3PR11MB4521.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 0351D213B3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39860400002)(346002)(396003)(376002)(136003)(366004)(8676002)(7696005)(5660300002)(6506007)(55016002)(52536014)(2906002)(9686003)(316002)(110136005)(4744005)(66446008)(64756008)(33656002)(66476007)(86362001)(186003)(66556008)(66946007)(4326008)(76116006)(81166006)(81156014)(26005)(8936002)(71200400001)(478600001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MW3PR11MB4521;
 H:MW3PR11MB4684.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8WjurN4B5ARElyDUyuwgyiUnspzyX9HmsDqGEEI5lW63rAPSXC33xY0oG2BZVy3PtTz745Thr2V7R6lqEwICPdgcN+/7usA9c3+MTuG+BTLtFNHmBMmeaYynZIey8LsbZorL45EmscKQOsV+8ZCGlBxT9sxVFVyEfZf+bpl+BvaWhIWoWjWU1p/gfCeZ+A0WzQvAHK5ld+onycn9oikpVwjD4ykgFI1AAnlxhUbUIURZjG416fy0qep+Gnt1if9QfRit1xGntQffG2IIjwZYejkZllUb9rDTmSqPVxYIwS2hzSaja7uiPVTlySkIsC3fUCyOKFYNHjPPefNYzCYMb8PFkMykTPM3R/+WnXKZT0goE3mtpnHdgA2Zc1T9rHQppA2ThpCRbs/UlLGkLNeGw89JF/76rWQr+opgCMWKvdUGU/1Rr5+j2hqlNnNS2unH
x-ms-exchange-antispam-messagedata: fyvIn7r+z0FnlkpeZ/ev8t1vwnlj+ueOdIQIy/4rt94X74ZIldfoH1Y8dsjdzye1MxqWcCxr1esvGfAP+XEFnSbPhnU9F9k7vVN+fwfGHw7Oxyw0JhOxaTXu0Jf0tKAlfK4gCeUx6VLSCtRjQfLOvQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e97b6394-e007-4761-0dbe-08d7cf6e3556
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2020 21:07:34.3024 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fDkc2GsvSlniWuJ6/RxDu6PuGcqYFksLGgY25o/cbk0/gQgvqHYwUmwDRWwqm/WD7NGd1g17ea4joZYBypg91bBNfl8dtKM4iZfkArUqejc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4521
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200323_140739_607525_07780525 
X-CRM114-Status: UNSURE (   8.02  )
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


>Can you run:
>gdb drivers/nvme/host/nvme-tcp.ko
>...
>$ l *(nvme_tcp_try_recv+0x59)

(gdb) L *(nvme_tcp_try_recv+0x59)
0xffffffffc03d04d9 is in nvme_tcp_try_recv (drivers/nvme/host/tcp.c:1046).
1041
1042            rd_desc.arg.data = queue;
1043            rd_desc.count = 1;
1044            lock_sock(sk);
1045            queue->nr_cqe = 0;
1046            consumed = sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
1047            release_sock(sk);
1048            return consumed;
1049    }
1050
Reproduced this fault on branch nvme-5.6-rc6.

>
>But this looks like a use-after-free condition.

>This is interesting, when we go ahead and do error recovery, I am wandering what is supposed to stop/quiesce blk_poll before safely tearing down and freeing stuff..

>I suspect that this will be common to others that implement blk_poll?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
