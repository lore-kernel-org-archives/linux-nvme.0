Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8DFC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 17:35:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FE1D22C7B
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 17:35:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE1D22C7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Xm62GeSiWVSy/4sZ1+Gf4aJuXMXZLL8dvgNMTpCcUho=; b=EwbIZhAJ7YWoR6nQ0pGnh2Mzyz
	qDC1GfvhWkLev6NFojCalsrAxApCRKb/eK5WZSEjnNlhJga+NtBFibphayXqXJA26n08zcXd06Svp
	C2sQ+sTQf5F9xC0IF5vvEVm866faSK2l+XraSgT4vK7+ZXBNnMsxw9IQuy0l9bJJykJtsCwh2TN64
	qmzj3HX6lckswrTTaucbulucPeLsI9E9QXGjljLTpVYW/4Sdm/jj2R653vg845MHCixRZi4XiceGj
	2uR1qgp/Mgc/h/98AfDWLowEZxu56LTBFd+dsyXL9pReQruyDna2YteLpn8El1ExFvq0ZM5wSvsRk
	mHr8ziTg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzNZl-0007zY-C5; Tue, 12 Jan 2021 17:35:25 +0000
Received: from mga12.intel.com ([192.55.52.136])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzNZi-0007wF-5B
 for linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 17:35:23 +0000
IronPort-SDR: Zeu7/cHbHOcaJmtC5aGyOT1EQYb3UrRVtd5jn9VuFnMFPImo+W+lOBGaEx/fAyBvii8k2x5Jl1
 M9Sow6rjEN9A==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="157256763"
X-IronPort-AV: E=Sophos;i="5.79,342,1602572400"; d="scan'208";a="157256763"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jan 2021 09:35:10 -0800
IronPort-SDR: jM5swXr1Gdjmofygjd9Lzh9kQtwWOYS6MnGN/bjDfEgYEw6WZa4CsaMZu8aye/tYDVmVw9XUEW
 A+UEzV3mp+uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,342,1602572400"; d="scan'208";a="400249150"
Received: from linux-machine.lm.intel.com ([10.232.116.101])
 by fmsmga002.fm.intel.com with ESMTP; 12 Jan 2021 09:35:09 -0800
From: Revanth Rajashekar <revanth.rajashekar@intel.com>
To: <linux-nvme@lists.infradead.org>
Subject: [PATCH v2] nvme: Check the PRINFO bit and the Metadata size before
 deciding the host buffer length
Date: Tue, 12 Jan 2021 10:29:41 -0700
Message-Id: <20210112172941.3911-1-revanth.rajashekar@intel.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210112_123522_586348_CBC4E933 
X-CRM114-Status: GOOD (  12.60  )
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
Cc: Keith Busch <kbusch@kernel.org>,
 Revanth Rajashekar <revanth.rajashekar@intel.com>, hch@lst.de,
 Jonathan Derrick <jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

According to NVMe spec v1.4, section 8.3.1, the PRINFO bit and
the metadata size play a vital role in deteriming the host buffer size.

If PRIFNO bit is set and MS==8, the host doesn't add the metadata buffer,
instead the controller adds it.

Changes from v1:
1. Remove the definition 'NVME_PRINFO_CTRL_BIT'
2. Remove variable 'control'
3. Remove test_bit and check the bit with the CPU arch's native endianness

Signed-off-by: Revanth Rajashekar <revanth.rajashekar@intel.com>
---
 drivers/nvme/host/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f320273fc672..03261e0abdcc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1546,6 +1546,11 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	meta_len = (io.nblocks + 1) * ns->ms;
 	metadata = nvme_to_user_ptr(io.metadata);

+	if (io.control & NVME_RW_PRINFO_PRACT && ns->ms == 8) {
+		meta_len = 0;
+		metadata = NULL;
+	}
+
 	if (ns->features & NVME_NS_EXT_LBAS) {
 		length += meta_len;
 		meta_len = 0;
--
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
