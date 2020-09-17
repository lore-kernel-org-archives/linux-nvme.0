Return-Path: <SRS0=U7CH=C2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E709C43461
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2020 01:11:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FBE5206E6
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2020 01:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qKXL18MR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jRpFiMR5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FBE5206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=iAbSafARyiIPk53ri83+euTEQzEcTGDYLXe5pFRNU5Y=; b=qKX
	L18MRxm/csO1bS0JbA60zxMhyo2DQnS5s0cxlvpHEqpyJMM6GI1NZ45UuiqoPA8rbnckXK/m2qPQy
	tUWczqIamJo4rOAqAQ4pcfa0wX48ktLX+M6xYMyZhzKUjgnMthgvE+L+uTfTyk7NBIAt7tgsItfT8
	kWnr/TE1r536PFwnaQhm+xsKBSX9wGuJmkJ17DFYtnd+/4h9TPJ/kxQGC4q7l86wIer/S+DcVBbI5
	xKW2oCOG7iCMEhgN3kySPmOxMmFAAtUpCYgMs5H3N7cCRVMGZjLtVJGb788LHZFaTG0mBO40j6p95
	1g72BkpV+KGU1/ilK1OTDFyuC7Sco7A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIiSA-00073J-GS; Thu, 17 Sep 2020 01:11:14 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIiS8-00072h-BW
 for linux-nvme@lists.infradead.org; Thu, 17 Sep 2020 01:11:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600305072; x=1631841072;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=QyMkkq9DIvqip1Vlz+dnqA/emGgUb1MqTUmrNZimaCA=;
 b=jRpFiMR5aotZTXk+kzbG+//V+1pXY6dG7JvUhYf+DQJOZjI7HWp7zLPr
 igeOoRCFL4ohwoeZDB4ZxyB537dgpkjbt1PJJLVsipXjjLR1V9NQdb6k9
 kUPIRJmm36K9AUKuLyd1RptPb/ks9KyYOY0cik+Wlq35o2HsuFYzqoQBj
 bj/9eJoDaZwQ/Zc3BAcmbp7SZiWVH1VAkorPBszGAVlk144VxPgRWbuvH
 s79oshHAwY0joAcJpbYk59UbwH8BGt+U6Vv4choHXFv6OEhwop7riXFhM
 JQZo0zprPG6TDcM1C6PiFgDWMve563SLkyLoUmYyDihrUyENZokhV27+E g==;
IronPort-SDR: wTi2c/R33OqbZSSeDFRSCwWxPq+Yhkv9xkL8NlLS02gVuQfzCUqVV2X+yZztWLhfnNA4xYMly7
 uFIjVd414xT7130HdtJcGxYls20y7jBD554vRoUgEG0KB4EH80GJqzYI4WomfhUiwufqbFvWnP
 X4YZYWBGkv2JFtAKuYKAWdWD+wyo2e3me+6Zw9S6wMYT4d9wkYc1+aTs8HdaUcKVBCnYDbIowr
 +DU6/4tdt6p0WPvFLniR93gpSy2z+9jdT5pfQ7K9a1jY5VeqFUiCCElYqPeabyX/x+8fESJfJF
 pKs=
X-IronPort-AV: E=Sophos;i="5.76,434,1592841600"; d="scan'208";a="257236071"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 17 Sep 2020 09:11:08 +0800
IronPort-SDR: g/7huzMx/+c50kJ1U8YY+qR80yCMOZj8apsUPRig03yebaO5wU4mtnImry7UEQvO7a5jlwML9t
 uk95r+T7ou9w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2020 17:58:17 -0700
IronPort-SDR: 3CWT2mK8BlLpa9widQCRc6c9Zjq4y7ZdphpErWv4Ywcf5cz0CsSzFPD4jbyuZdtI/K8mWeWkyI
 PVGtQ6guYV5g==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 16 Sep 2020 18:11:09 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V3 0/3] nvme: fix module ref count Oops
Date: Wed, 16 Sep 2020 18:10:59 -0700
Message-Id: <20200917011102.14819-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200916_211112_594512_AB9B03C4 
X-CRM114-Status: GOOD (  14.60  )
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
Cc: logang@deltatee.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: multipart/mixed; boundary="===============8420056984894162853=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============8420056984894162853==
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

Hi,

I found the module ref count patch in the git without the ctrl get/put in
the nvme_dev_open/nvme_dev_release() with latest pull.

commit dfa76f46dad568ed81368c3cb810d95f820debc5 (origin/nvme-5.9)
Author: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date:   Tue Sep 15 20:53:25 2020 -0700

    nvme-core: fix nvme module ref count Oops

In this series, the first patch which adds the ctrl get/put in
nvme_dev_open/release() which can be folded onto the git HEAD on
nvme-5.9 or applied separately deesn't matter.

The last two patches are Christoph's suggestion added on the top
host-core module count fix to decouple :-

 a. code for modue_get/put() in the passthru.
 b. lifting the file opening from the nvme-core.

Regards,
Chaitanya

Changes from V2:-

1. Add a patch to get/put ctrl reference in the nvme_dev_open/release().
2. Use Chritoph's suggestion to split the 2nd patch from V2 into :-
   a. module_get/put() in passthru enable/disable path.
   b. lifting the file open/close code from host/core for char device.  
3. Update patch subject.

Changes from V1: -

1. Move last patch to get the module refcount to start of the series.
2. De-couple the module refcount get/put from nvme_dev_open() and
   nvme_dev_release().

Chaitanya Kulkarni (3):
  nvme-core: get/put ctrl in nvme_dev_open/release()
  nvmet: get transport reference for passthru ctrl
  nvme: lift file open code from nvme_ctrl_get_by_path

 drivers/nvme/host/core.c       | 27 +++++++--------------------
 drivers/nvme/host/nvme.h       |  2 +-
 drivers/nvme/target/passthru.c | 29 ++++++++++++++++++-----------
 3 files changed, 26 insertions(+), 32 deletions(-)

-- 
2.22.1



--===============8420056984894162853==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============8420056984894162853==--
