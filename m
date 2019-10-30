Return-Path: <SRS0=ZUg+=YX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77819CA9EC7
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2019 22:27:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 368982067D
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2019 22:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Vu85M2Q1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 368982067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=qmjjAFkF1Sqm+m3F4K5IhErMzH3CzYcE+4pOi4vZ8T0=; b=Vu85M2Q1dzPr2T
	XWRYKkxmdmg30YLITW1DV8RD+jfC4BP/gMRLAyCLzT3qL5CywtdEz2XwnyXQEaLeSiKWUToTX3jGw
	3ckYLpiw5c1UP2meeg0Z3fkc+DGfNb9a933OTSHIFE8v2GHskkzbBeN/6ePhPazgaQB4rnTh+AKxJ
	BiUKcuka/m0cPkC11rywxVzZL9BfPx5umBo+2nAvvvI4+bFTX3oiF5XPIRC4PPRLktrIrfZzkvK2F
	ZJoRTRGtK7eqP8qAUiVuw5tO/4/oWc3YDQUXNMPfK2yObbSJzWM5gFsXdwp3dXNyeEUgCPxmrvk9M
	MmAoQmFni5kBTpQ3vKxg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iPwR9-0002sP-Ri; Wed, 30 Oct 2019 22:27:31 +0000
Received: from mga07.intel.com ([134.134.136.100])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iPwQr-0002YH-Kw
 for linux-nvme@lists.infradead.org; Wed, 30 Oct 2019 22:27:15 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 30 Oct 2019 15:27:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,248,1569308400"; d="scan'208";a="190427157"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
 by orsmga007.jf.intel.com with ESMTP; 30 Oct 2019 15:27:03 -0700
Received: from orsmsx160.amr.corp.intel.com (10.22.226.43) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 30 Oct 2019 15:27:03 -0700
Received: from orsmsx104.amr.corp.intel.com ([169.254.4.167]) by
 ORSMSX160.amr.corp.intel.com ([169.254.13.29]) with mapi id 14.03.0439.000;
 Wed, 30 Oct 2019 15:27:03 -0700
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: [PATCH 0/2] allow for busy poll improvements
Thread-Topic: [PATCH 0/2] allow for busy poll improvements
Thread-Index: AdWPZPmJDNMuypQPSDiBzjHO6knvSg==
Date: Wed, 30 Oct 2019 22:27:02 +0000
Message-ID: <B33B37937B7F3D4CB878107E305D4916D4AFB9@ORSMSX104.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZmE4MDZmYjItZjA2NC00YWQyLWE3ODUtMzAwYzJjOWM4ZWQyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQkdaclZcLzdJYmZqaW1hbzNjOUhWRVdxQlE5eDRkRFVqamQxa2NKUXI4Yjg0VlZBZDZhZnY3NkxPczlaZEt0WUwifQ==
x-originating-ip: [10.22.254.139]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191030_152713_743461_1B612C3C 
X-CRM114-Status: GOOD (  14.66  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Proposing a small series of two patches that provide for improved packet processing for a fabric network interface that is operating with poll mode enabled

Patch 1:  Modifies the do/while terminate condition in nvmet_tcp_io_work() to be time based  vs. the existing code that is operations count based, which will match more to how it is performed for the host version of io_work().   If poll mode is not active then original function behavior is preserved.

Being time based allows setting the loop period to a value indicated by the network socket if CONFIG_NET_RX_BUSY_POLL is enabled [poll_mode].  Operating in poll_mode provides for increased opportunity to reap send or recv completions without premature exit when a single iteration of loop is idle (pending being false).

After exiting the do/while loop, the work item will be re-queued if there was previous 'pending' activity.  In the case of poll mode, this is determined by any accumulated ops completions over the complete do/while period, vs if the last iteration through the loop showed successful activity.

Patch 2:  This patch builds upon previous kernel network patches listed below that enabled enhanced symmetric queuing, which is leveraged while in poll_mode:

- a4fd1f4 Documentation: Add explanation for XPS using Rx-queue(s) map
- 8af2c06 net-sysfs: Add interface for Rx queue(s) map per Tx queue
- fc9bab2 net: Enable Tx queue selection based on Rx queues
- c6345ce net: Record receive queue number for a connection

Setting the socket priority to a non-zero value, via the proposed module parameter, will trigger indication to the network NIC that optimized network processing and queue selection can or should be considered.  The default value for priority remains zero to support default NIC behavior related to priority.

When applied, and running with an optimized busy polling NIC, there is a measurable improvement in I/O performance and reduction in latency.  The sample data below shows FIO results For 4K random read operations to a single remote nvme device.  The queue depth Is 32 and the batch size is 8.  One set of data represents a baseline for the standard Linux kernel running on the host and target (5.2.1 stable).  In the second, the two patches were applied on the target but the NIC poll mode was not enabled.  This to show default target performance is not impacted by adding the changes.  And finally, the two Proposed patches were applied to the target, and poll mode was enabled.

For comparison, The number of threads for the fio job are scaled from 1 to 8 until we reach nvme device I/O saturation.  The data shows no performance impact by adding the patches and run in default non-polled mode.  While in polled mode device saturation is reached faster with lower average and 99.99 latency.

Sample FIO invocation line:
fio --filename=/dev/nvme0n1 --time_based --thread --runtime=60 --ramp_time=10 --rw=randrw --rwmixread=100 --refill_buffers --direct=1 --ioengine=libaio --bs=4k --iodepth=32 --iodepth_batch_complete_min=1 --iodepth_batch_complete_max=32 --iodepth_batch=8 --numjobs=1 --group_reporting --gtod_reduce=0 --disable_lat=0 --name=cpu3 --cpus_allowed=3

Baseline 5.2.1 stable kernel:
Threads  |  IOPS (K)  |  Avg Lat (usec)  | 99.99 (usec)
*****************************
1  |  195  |  157.69  |  553
2  |  215  |  284.31  |  758
3  |  404  |  229.04  |  742
4  |  515  |  239.98  |  742
5  |  549  |  282.22  |  750
6  |  581  |  321.64  |  750
7  |  587  |  376.68  |  750
8  |  587  |  432.58  |  971

With patches applied on Target kernel,
But poll mode off, so_priority set to 0.
******************************
1  |  197  |  156.40  |  545
2  |  286  |  215.14  |  758
3  |  422  |  218.75  |  734
4  |  491  |  251.34  |  742
5  |  504  |  306.68  |  750
6  |  583  |  319.91  |  766
7  |  587  |  378.32  |  742
8  |  587  |  434.57  |  660

With patches applied on Target kernel,
Poll mode enabled:
******************************
1  |  227  |  129.43  |  537
2  |  404  |  144.33  |  537
3  |  523  |  170.25  |  529
4  |  563  |  215.94  |  537
5  |  587  |  263.78  |  510
6  |  587  |  321.41  |  506
7  |  587  |  378.67  |  502
8  |  587  |  435.27  |  502

Note:  Data was gathered using kernel 5.2.1 stable.  The patches posted to this mailing list were merged to the infradead tree pull 10/30/19.

Mark Wunderlich (2):
- nvmet-tcp: enable polling option in io_work
- nvmet-tcp: set SO_PRIORITY for accepted sockets


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
