Return-Path: <SRS0=cpn7=XT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655CEC432C1
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Sep 2019 16:06:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 331FC20673
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Sep 2019 16:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bxYuEzZ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 331FC20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=axXBeJpkqb8vcDcOtgr5kvtLw2oD/cPL7rFXS8558WU=; b=bxYuEzZ4Pz2LUl
	6+DDVmP4C4bzcXs724jHmRbhedlhlWzinFQgFBOpaWX2BYDgGXs+zkEThS5UQnpap/lTLkh/jOnIa
	vsktMFKOFKWUBi9qkjuZpTXCWmS29Kq/WtbGHfaK12IdjTE54nA8UKv2Xk7oYhOuTKwGKNn7r2LzC
	z9Kh6t/9gnoM9hxqpaeuuu2QL+1Biq7AkyyR1tUyjobIuls4I8PEkLJwlhIxBnE/4nle2A17PyfXb
	VTxwq+NAvSKZ1E/yMp96h2gi3pm7/EyoCeiHI8PmAhRiwzbkyd7Wbi6M6FurUGejkQy1mojZdw23v
	igiWya3ewmHTr2sOoipg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iCnKR-000702-3U; Tue, 24 Sep 2019 16:06:15 +0000
Received: from mga02.intel.com ([134.134.136.20])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iCnKN-0006wZ-Ah
 for linux-nvme@lists.infradead.org; Tue, 24 Sep 2019 16:06:13 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Sep 2019 09:06:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,544,1559545200"; d="scan'208";a="182958335"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
 by orsmga008.jf.intel.com with ESMTP; 24 Sep 2019 09:06:09 -0700
Received: from orsmsx163.amr.corp.intel.com (10.22.240.88) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 24 Sep 2019 09:06:08 -0700
Received: from orsmsx104.amr.corp.intel.com ([169.254.4.204]) by
 ORSMSX163.amr.corp.intel.com ([169.254.9.47]) with mapi id 14.03.0439.000;
 Tue, 24 Sep 2019 09:06:08 -0700
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: [PATCH rfc 0/2] allow for busy poll improvements
Thread-Topic: [PATCH rfc 0/2] allow for busy poll improvements
Thread-Index: AdVy7tImb9gZIA62QgGcFrlCDyl/5w==
Date: Tue, 24 Sep 2019 16:06:07 +0000
Message-ID: <B33B37937B7F3D4CB878107E305D4916D36832@ORSMSX104.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMGRlN2ZkYmUtNTc3Zi00NWVhLTkwNDctNDY3ODNlMGUzMzcyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiNHR2bDJsdm50VXZzMEo2Tnk5RVFMNEkzNkxSK2VHWnlZMzhYNTREUExGc3R4d2xuOGxQdFJQMmF1RldzeVZBVSJ9
x-originating-ip: [10.22.254.139]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190924_090611_454713_FF2B264D 
X-CRM114-Status: GOOD (  16.58  )
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


Proposing a small series of two patches that provide for improved packet processing for a fabric network interface that is operating in poll mode vs.
standard interrupt mode.

Patch 1:  Modifies the do/while terminate condition in nvmet_tcp_io_work() to be time based (for poll mode) Vs. the existing code that is operations based (works well for interrupt mode).  Being time based  allows increased opportunity to reap for send or recv completions without premature exit when a single iteration of loop is idle (pending being false).

In either case, after exiting the do/while loop, it is desirable to re-queue the work item if there was previous activity.  In the case of poll mode, this is best measured by any accumulated ops completion over the complete do/while period, vs.  for interrupt mode it was coded to re-queue only if the last iteration through the loop showed successful activity.

There is opportunity to simplify the changes proposed here to bring more commonality between modes, and not require ifdef check, that are under consideration.  For example, using a time based check as proposed (and as used for the host side for this similar function) and identify a default time quota used by interrupt mode.  If at the start of the function, the busy mode time period is not set then a default defined interrupt mode time period (same as host side of 1 msec?) would be used.  Then with time defining the mode, if we are in interrupt mode we can preserve use of 'pending' and break out of loop at the end if that loop iteration is false.  Then just after the loop, add a check that if (poll mode and ops > 0) then set pending to true.  We can then preserve the final check that re-queues the worker if pending is true.  Issue with this option being if user happens to set the sk_ll_usec busy mode time period to the default interrupt time period.

Patch 2:  This patch builds upon previous kernel network patches listed below that enabled enhanced symmetric queuing:

- a4fd1f4 Documentation: Add explanation for XPS using Rx-queue(s) map
- 8af2c06 net-sysfs: Add interface for Rx queue(s) map per Tx queue
- fc9bab2 net: Enable Tx queue selection based on Rx queues
- c6345ce net: Record receive queue number for a connection

Setting the socket priority to a non-zero value, via the proposed module parameter, will trigger indication to the network NIC that optimized network processing and queue selection can or should be considered.  The default value for priority remains zero to support default NIC behavior related to priority.

When applied, and running with an optimized busy polling NIC, there is a Measurable improvement in I/O performance.  The data below shows FIO results For 4K random read operations to a single remote nvme device.  The queue depth Is 32 and the batch size is 8.  One set of data represents a baseline for the standard Linux kernel running on the host and target (5.2.1 stable).  In the other, the two Proposed patches were applied to the target only, same kernel version.  For comparison, The number of threads for the fio job are scaled from 1 to 8 until we reach nvme device I/O saturation.

Baseline 5.2.1 stable kernel:
Threads  |  IOPS (K)  |  Avg Lat (usec)  | 99.99 (usec)
*****************************
1  |   80.8  |  371.40  |  758
2  |  160  |  376.55  |  717
3  |  255  |  352.41  |  750
4  |  356  |  336.87  |  734
5  |  465  |  324.32  |  734
6  |  558  |  330.18  |  750
7  |  572  |  376.95  |  750
8  |  585  |  431.15  |  742

With patches applied on Target kernel:
******************************
1  |  169  |  163.67  |  469
2  |  344  |  154.19  |  445
3  |  513  |  159.16  |  465
4  |  495  |  226.16  |  494
5  |  583  |  254.52  |  510
6  |  586  |  315.72  |  510
7  |  586  |  370.84  |  515
8  |  586  |  427.18  |  660

Note:  Data was gathered using kernel 5.2.1 stable.  The patches posted to this mailing list were merged to the infradead tree.  Currently working build issues with that tree that prevent testing with it as the base.

Mark Wunderlich (2):
- nvmet-tcp: time based stop condition in io_work
- nvmet-tcp: set SO_PRIORITY for accepted sockets


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
