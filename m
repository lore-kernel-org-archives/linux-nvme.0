Return-Path: <SRS0=SY4p=CG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC29C433E6
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2020 01:01:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD679206EB
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2020 01:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ij1RWV/u";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="aKJHNAzg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD679206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bWqHbr5nmb+KupE7f1JtQXGVWd3kiMsxr5GWzwLuczE=; b=ij1RWV/u5gxxo7T9kTwipREHuo
	1FbEINOFnho5ETYq7VHO8ovlAvp1OQvN1q0uI7bqyOB7e72P0AmmxUNr5c9ZHq3JQL6LZ4DKZFi71
	P3kcsbrbtzB293xLfNiRQO7WYBWQPbkxfcWvtCMMKX3cyV8ET/SUsjhPsmjINz9Gf3QkH4Jy+2lzN
	0tFcZyzollpWc9m2odLicec2uLKZX2SGM0P1vyJsKu0pVxQ4wKblliFu/EWeTThiNv/UK2Lv72LEn
	mrW9vSsBTqOlY8PYL3HK4QYbfMEs+1qVNbgCtLgGKlqCnjK67xNDU/7jk6ipAYYXWRyUXaUI0UUst
	HGpisZSw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBSlt-0003wK-A5; Fri, 28 Aug 2020 01:01:37 +0000
Received: from mga07.intel.com ([134.134.136.100])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBSlr-0003va-08
 for linux-nvme@lists.infradead.org; Fri, 28 Aug 2020 01:01:35 +0000
IronPort-SDR: W4GTB+nVg7nCk/u1e4LC7xkSXfAHCOSgyPCYtMHVVqteir0hdf+Axxeb9UAOUF9vrOuON4dY/I
 mzVbglFsa2Mg==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="220836371"
X-IronPort-AV: E=Sophos;i="5.76,361,1592895600"; d="scan'208";a="220836371"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2020 18:01:34 -0700
IronPort-SDR: EfDEnpnsaHqQTiq8fb+NfyYmu3+XR+qidtXKXmPfXr7B76zuP1Nbgw7KeC9f5Bo067Bxe6JZZV
 z12CSaySoBvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,361,1592895600"; d="scan'208";a="280800477"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
 by fmsmga007.fm.intel.com with ESMTP; 27 Aug 2020 18:01:33 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 27 Aug 2020 18:00:51 -0700
Received: from fmsmsx108.amr.corp.intel.com (10.18.124.206) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 27 Aug 2020 18:00:51 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 27 Aug 2020 18:00:51 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 27 Aug 2020 18:00:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZE2p4VxP8zPivYnW+CL8ba0ugJtz9clA7v7GYhsAJf4UKzJHPG8P6XUKknjXet/jR92r4odm9nIZTbW7GR1EcvNfD03DWH5OgqtBCcHtIVQNJKBmcXrc5n19Euv+IHz/dJnKSKnZjsjjJatXZroBJEu0zW3qbYgcUReCFaGnQtkjADv/hpx1fHDyGTFfyl3JidsWb3eQLQdIxoq8EieYG6RzcPzRByKRrBHCcM9+6aH9ceseSrJ+nfSburaRUYPeh4AiMhl4ZiJ/Au6g7ET0OV5dU1tdyRGRJE5OHMatggjUqE355Xc7T1PhxUl8m8Z5enu1BoNQtVvvBL9+fsppAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JX6B1bNvxInNulLJ/qyWYEoZAKXYu/fgFvN8F3cKF18=;
 b=n+MPEDuvf3bODj7cy2vYVNjuXDhfar/h7ZPLfXOUYwH7eIEf3J3Alxykf38v2lhuCXOasHc8xXH9g/+dmBq+qFF9/mIwO+izUVYJYeXcN7JP4ak5ZgVqzUdJZC39vzQQhIWfUyhygCFS3T/lZ0ziHVuwhs4ty9dBVyz7xpePjIzfnfSZ/G7Kn7hzdVLG3W7fQUN4rptL5Y+eC2mb7E71kiLsaKnli2Sstzl8vUscMgl6vsfIXA7xw0aZZgwsmwc2V4IgbJ3F8oaj2zyjE1joAtKdfchwmF0+MabksxAYY5AoZ9opMSIDdGanL5C7Jj2X/VKtzchpFwF1tIjkr/EXeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JX6B1bNvxInNulLJ/qyWYEoZAKXYu/fgFvN8F3cKF18=;
 b=aKJHNAzgDZPy06DRcZiy8RGqI/LrFAD5e9ybWj35FalmMrDEUuSmFt+0ZEriYESSUrdyMN9y877nqEdg/PMbSvt2aDSfETBnvZeFUUA946rzkaihyM5W3VAq70W2ds4Ulk76qgiepPf+mqoLpUYsfAJ9IknMY3QAP5t+6DxK7Ug=
Received: from BYAPR11MB2869.namprd11.prod.outlook.com (2603:10b6:a02:c0::15)
 by BYAPR11MB2775.namprd11.prod.outlook.com (2603:10b6:a02:bd::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Fri, 28 Aug
 2020 01:00:50 +0000
Received: from BYAPR11MB2869.namprd11.prod.outlook.com
 ([fe80::cce3:61fa:c7b4:42c8]) by BYAPR11MB2869.namprd11.prod.outlook.com
 ([fe80::cce3:61fa:c7b4:42c8%3]) with mapi id 15.20.3326.021; Fri, 28 Aug 2020
 01:00:50 +0000
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: [PATCH 0/5] nvmet_tcp: Introduce poll groups and polling optimizations
Thread-Topic: [PATCH 0/5] nvmet_tcp: Introduce poll groups and polling
 optimizations
Thread-Index: AdZ81AmxtCCPJqTuTBGqIHJ50W8p5g==
Date: Fri, 28 Aug 2020 01:00:49 +0000
Message-ID: <BYAPR11MB28691354BB3008AEA85D37D3E5520@BYAPR11MB2869.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=intel.com;
x-originating-ip: [71.238.29.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d80d6d2-9eda-4521-e646-08d84aedce39
x-ms-traffictypediagnostic: BYAPR11MB2775:
x-microsoft-antispam-prvs: <BYAPR11MB2775054AF916213B7314E9B3E5520@BYAPR11MB2775.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hFNm3CogA+l7x9Puha73hQkoZgnFnzcsZnJzvHfH2nmrWpwCnI6j897VpBkAh/dkx43VapM8mKZHLlDE6cgBR/j9kv5L5c/DGx2610Ud8JeiSbyBcl2847WqEp5JxnrHiAY4UVYZy7Lh//YoukpKwtRp14Hp3LrAnxlAzL1IYy9vh6tz23rdxWQ+kV+CiNc9tmkRKVDw9bu5jCg7SK9y4RAZzbHsfxUpXuRLRzssoE+3eyBLh9fkAjhtwtzRQbg+ymrrwRWwrzFT6okI2eTwcZN0Td3YHgUcjexarL9PcgnhSEy27iP3uu/vuk+KjuhwfNITNSPsnfuK414jDGZ/ow==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR11MB2869.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(2906002)(7696005)(316002)(86362001)(8936002)(52536014)(5660300002)(6916009)(8676002)(33656002)(26005)(186003)(4326008)(55016002)(66556008)(64756008)(66446008)(76116006)(66946007)(66476007)(6506007)(478600001)(71200400001)(9686003)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: Wl1rBtqXUf1YH4MZKk4Z5bo+rR6MzslYBwr3JQXMchj6d7/G0hrq9/XKxVg1XXLqjPJ2svSw0NWgu90FSwUyjZC1347zRxfnNenxah3+LcIZSu2RSE+mCkAWPOBHgCQnlGiWseUc/f7vWLue40T7binuVaxyviNSxBKLOt+dn7AbuFN49FAXTjNWGnhDe7J4QgbWNf/yb+PfcNrtToI6d0Xxjb4IOazB5YVZZRt3IyRe9/GCOssy1fX27tXwU/un+PsqbWQhdWuH+8Me3vvag9apxbmTUXtgm4tOo8TcAZeSYpDTKQHvuim4aT6b2TF4yYyNXU9IJ0yTieYfH0XAkL5bnFziFqJg7GKLBSM7HAOdj5i9Wu4MQdPtyteeB32fUcGHemWbTOOCLnXdH5Hvr873eboqrAgceqEQLve/LJXnn6AhdOVgo104nUGLLgT7fHJDXhv1ZGTns8w03AUtsDvAjNNGQ4bfWtleDZCAgdse2EsNfU497pd3JMG/s/3Fh7l5kgvyEiV67qoWjNBSGQbcl4fYTvYG6wPI8he81BIODPbr5X8lcr64h8fJDebYsp3ptap+Ev4Y+qMunUnACxtks5Eiza9bzxzrH0rRxobg/HFj+pLR45p7M2apZow+OE3b1LTcAacaKIjU9gB02w==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d80d6d2-9eda-4521-e646-08d84aedce39
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2020 01:00:49.9061 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BW4XUzcsmUpMF+uT56IihHjEHpHY6ShVc5va2yHrJdCQThZO/m2IQ1aPNsUEYtVeCoN46Fu/kByzhAq+CYqyG/IJfZrDXGny9UhYwS88Xrc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2775
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200827_210135_185331_4B05453A 
X-CRM114-Status: GOOD (  16.78  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

nvmet_tcp: Introduce poll groups and polling optimizations

Currently nvmet-tcp spreads the incoming queues to be processed in a
round-robin fashion, independent of the underlying network details.
While this helps to spread the processing load across available CPU cores,
It is not optimized for latency based on NIC affinity, and not optimized
for polling optimizations this patch set is aiming to introduce.

This patch series introduces the 'poll group' concept where a single
kworker will process multiple connections associated to a group.
Each group being aligned with the CPU core that matches the
so_incoming_cpu value of an established network connection.

The motivation here is to allow NIC steering methods to drive the load
spreading while we can maintain threading affinity corresponding to
that.  In addition having our I/O context work on a group of connections
allows us to minimize the context switching involved with having a single
connection per work element.

The new group I/O context will still be bound in quota, but a suitable
quota that is designed to take into account multiple connections and
is configurable by the user (via modparam).  At a later stage, we will
make the polling quota adaptive based on load statistics that will be
added to the driver itself.

This model provides improvements in both IOPS and latency reduction
as shown in the measurements below.  

Patch 1: Use of socket sk_incoming_cpu as the queue cpu for processing.

Patch 2: Defines and allocates grouping structures.

Patch 3: Implements how connections are associated with groups.

Patch 4: Adds how connections are added/removed from the poll group
list to be processed. Provides module option to increase io_work() poll
period (io_work_poll_budget).

Patch 5: Adds how connections are transitioned from a group in support
of disconnection.

This patch series was developed and tested on the nvme_5.9 branch.

Resiliency testing for controller resets or target disconnections was
performed while running >10 active connections with over 2M IOPS
for over an hour.  The target was not compromised during this testing.

Performance testing was performed using a single ramdisk.  It used a
random read pattern for 4k block sizes. FIO io_uring hipri engine option.

The new nvmet_tcp module parameter (io_work_poll_budget) value
of 50000 usec was used.

Single connection/group performance:

For the following data, the results are the min/max for
the two queue depth and batch combinations, across 100
host fio threads.  Single host thread connection processed
by single target core/group.

Baseline before applying group series.
QD/B:    IOPS       Avg Lat (usec)     99.99 (usec)
1/1:        30.6       31.56                    64.25
               42.1       22.63                    25.47
32/8:     186        154.42                  433
               277        100.05                  188

Grouping patch applied on target. Single connection active in
each target poll group.
1/1:        43.5       21.93                    29.82
               47.8       19.87                    21.12
32/8:     212        126.19                  265
               285        97.85                    188

Group scaling performance:

To test group scaling the number of online system cores was
reduced to four (two in each numa node).  The number of
connections established was a total of 24 in order to ensure
at least 5 connections per target poll group.

Scaling is measured by increasing FIO jobs, one per target
poll group.  Each job issuing 5 threads on different host cores
to drive I/O over 5 separate connections.  Numbers reported
are an average across 5 test runs.

Baseline:
In the baseline case some up front testing was required to
first learn which connections were processed by the same
target CPU (a logical group of connections).

All latencies are in usecs.  IOPS in K.

#groups : IOPS(k) : Avg.Lat. : 99.99 Lat. : 99.95 Lat.
Baseline:
1 : 659 : 223.02 : 1214 : 468
2 : 963 : 312.79 : 1582 : 657
3 : 1364 : 330.19 : 1539 : 763
4 : 1652 : 359.27 : 1280 : 827

With Grouping:
1 : 749 : 208.32 : 881 : 237
2 : 1277 : 243.57 : 922 : 285
3 : 1896 : 246.27 : 881 : 297
4 : 2337 : 266.20 : 857 : 338

Signed-off-by: Mark Wunderlich <mark.wunderlich@intel.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
