Return-Path: <SRS0=+gr8=AS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58445C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jul 2020 10:50:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F927206DF
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jul 2020 10:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NRpejSJA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F927206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1Z8IYvoNqrRFHOb0WVqZH6ger9B9za4heGsTtW3lQdM=; b=NRpejSJAy9s1CQqoL7B7uKM3g
	wHBfQMqEyJEiDZTOEFVAspu50YEB+qce76iJlMsHFktafXjB0HNQTgDvjgODbOc4QzzjzHjD4v9Kl
	XQUE0iy5iPgWjRieHURc1fjKh9sYL4xGv3sp21Csm/dmC54+5RoO0mgVUi6jO/DpY2YEbSpQdBIfV
	Fd+U18hNagWrH7fhXGLLvzV4KP7nI9dJkemu2/e0rKp+SDUU8mI/GANXurBeP4X5RQgXNDrg9tpdi
	/tbmqdI9fc0ZNkiq7RUD+CcbRU5MHo1bS9qegRCqw7N0mRtY+za5so0h++lsmruGnRKbyTsyrjRup
	b9+eXlMTQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jslBG-0008Sh-VZ; Tue, 07 Jul 2020 10:50:31 +0000
Received: from mga07.intel.com ([134.134.136.100])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jslBE-0008RS-1g
 for linux-nvme@lists.infradead.org; Tue, 07 Jul 2020 10:50:29 +0000
IronPort-SDR: RHUD+QxdT2Ec4LDKW1XOXkWbjQYvku2WSfsGGu2avEon4CVre743mF7QonWjmZCiYipIMTlJDI
 NyHqu3w04/nQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="212539464"
X-IronPort-AV: E=Sophos;i="5.75,323,1589266800"; d="scan'208";a="212539464"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2020 03:50:25 -0700
IronPort-SDR: QGmr3DWwmS7+g6d+JXFnWU5sohtxa+57LStWKwSlayV0zsUuLlZWtU+sG8yT4Bibp9EFeLp+uZ
 ZthXFDU1MCng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,323,1589266800"; d="scan'208";a="427434944"
Received: from lkp-server01.sh.intel.com (HELO f2047cb89c8e) ([10.239.97.150])
 by orsmga004.jf.intel.com with ESMTP; 07 Jul 2020 03:50:23 -0700
Received: from kbuild by f2047cb89c8e with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1jslB8-0000B6-SX; Tue, 07 Jul 2020 10:50:22 +0000
Date: Tue, 7 Jul 2020 18:50:17 +0800
From: kernel test robot <lkp@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: [RFC PATCH linux-nvme] nvme: dev_attr_ctrl_loss_tmo can be static
Message-ID: <20200707105017.GA3658@42360abf9c00>
References: <202007071822.30Odtc0k%lkp@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <202007071822.30Odtc0k%lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200707_065028_265049_7DB25FF1 
X-CRM114-Status: GOOD (  14.53  )
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
Cc: kbuild-all@lists.01.org, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


Fixes: 3be72d5b2ac2 ("nvme: expose reconnect_delay and ctrl_loss_tmo via sysfs")
Signed-off-by: kernel test robot <lkp@intel.com>
---
 core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9de93298bd81b..088608714451f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3564,7 +3564,7 @@ static ssize_t nvme_ctrl_loss_tmo_store(struct device *dev,
 						opts->reconnect_delay);
 	return count;
 }
-DEVICE_ATTR(ctrl_loss_tmo, S_IRUGO | S_IWUSR,
+static DEVICE_ATTR(ctrl_loss_tmo, S_IRUGO | S_IWUSR,
 	nvme_ctrl_loss_tmo_show, nvme_ctrl_loss_tmo_store);
 
 static ssize_t nvme_ctrl_reconnect_delay_show(struct device *dev,

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
