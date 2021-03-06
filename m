Return-Path: <SRS0=TRJs=IE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C269C433E6
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:37:11 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03E2E65074
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E2E65074
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yDLkW19pEbD3/7MR1ip4hQeGsio9Uaq2OnbugHAGj7E=; b=o62dYAF3STXDXaQOQaR0vBF7Lp
	vGWK0jogjnihCmo58+VdDFr9gpZp3/F2Hmg7ibmnfg8jeA4NpVc8O/8ev7vEBI7UI+eFvjpvcD3hg
	n1xj0b+7wsHc1Q2JrrDAMrFtdpVHJ1h1m26yQKCEmqcwnppvDCNsfMPhwsn/5G+zWlJbZuQPk/Am9
	Z9TfijntlUO9w1NTmvG70RaL8tbZPkcm3Ucohjde21Eysw8V8GFsf8KUMcPRnbgW4KyH+dzUU7vbh
	wANZbl36FnjpPUVo21qwda/rwW7YeX0GzUJ82MpMe2Fl8IWSRCpyOSA3T6mWZlPJp0tpa/8Rpk1/C
	vSyOKxDg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIKwD-00HVZF-Rk; Sat, 06 Mar 2021 00:36:57 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIKvy-00HVRS-H4
 for linux-nvme@lists.infradead.org; Sat, 06 Mar 2021 00:36:45 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1614990999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=a+pl4zk1GAOv6jIfMA2Q/Kmn20s6pTGcOZ2LgQkdnCE=;
 b=DrCar9S+MuueKC4OL7YWAdvCGXq+sVMHvCuo8zRLJ7iEQHe1Khr0/tBWqFRlCurlnrs30V
 hX0p/+ksl69qWdT90EtYnFXk36fo6J8gUV4uhpvY5hxp8ditlbb7SUt8u7nvDSjyZsRJGp
 OKsoSoz2UJyknMELky+x9n5iGpTjOCI=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 4F891AE1B;
 Sat,  6 Mar 2021 00:36:39 +0000 (UTC)
From: mwilck@suse.com
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Enzo Matsumiya <ematsumiya@suse.de>,
 Martin Wilck <mwilck@suse.com>
Subject: [PATCH 00/10] Some minor fixes/additions for nvme-cli
Date: Sat,  6 Mar 2021 01:36:14 +0100
Message-Id: <20210306003624.21102-1-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210306_003643_947104_7A5A4DA5 
X-CRM114-Status: GOOD (  14.98  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
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

From: Martin Wilck <mwilck@suse.com>

This series collects patches from my former submission "RFC: add "nvme
monitor" subcommand" which aren't directly related to the monitor
functionality, but required to make the monitor in its current form
compile. A v2 of the monitor code is about to follow soon.

The main part is the "generic logging functionality".

Changes wrt the RFC: add "nvme monitor" subcommand series: many.

 - rebased to current upstream code base e9d43dd ("[nvme-cli] Fix Max/Min 
   User data erase counts displayed in 0xC2 Log Page"))
 - renamed log() to msg() in order to prevent name clash with <math.h>
 - put logging and cleanup files in "util/" subdirectory
 - converted the bulk of the logging code from a macro into a function
   (Hannes)
 - added functionality to optionally log the PID (default off).
 - added Hannes' patch he recently submitted via github
   (https://github.com/linux-nvme/nvme-cli/pull/942), with two minor
   fixes on top, rationale in the commit messages
 - various additional fixes for memory handling

Both cleanup and logging functions / macros could be used in more
places with positive effects, but my focus is currently on preparing
the monitor functionality.

I've pushed this series https://github.com/linux-nvme/nvme-cli/pull/877,
together with the follow-up monitor series.

Regards
Martin

Hannes Reinecke (1):
  nvme-discover: lookup existing persistent controllers

Martin Wilck (9):
  nvme-discover: assume device given on command line is persistent
  do_discover: free cfg.device when resetting it
  nvme-connect-all(1): fix documentation for --quiet/-S
  nvme: add some simplifying macros for __attribute__((cleanup()))
  nvme-cli: add generic logging functionality
  nvme: convert some function arguments from "char *" to "const char *"
  fabrics: use "const char *" in struct config
  fabrics: fix some memory leaks
  fabrics: fix invalid memory access in discover_from_conf_file()

 Documentation/nvme-connect-all.1    |   8 +-
 Documentation/nvme-connect-all.html |  10 +-
 Documentation/nvme-connect-all.txt  |   4 +-
 Makefile                            |   2 +-
 fabrics.c                           | 223 +++++++++++++++++-----------
 nvme-topology.c                     |   2 +-
 nvme.c                              |   2 +-
 nvme.h                              |   4 +-
 util/cleanup.c                      |   4 +
 util/cleanup.h                      |  18 +++
 util/log.c                          |  90 +++++++++++
 util/log.h                          |  34 +++++
 12 files changed, 298 insertions(+), 103 deletions(-)
 create mode 100644 util/cleanup.c
 create mode 100644 util/cleanup.h
 create mode 100644 util/log.c
 create mode 100644 util/log.h

-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
