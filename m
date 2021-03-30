Return-Path: <SRS0=nD3g=I4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4ACC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 15:59:49 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9659660241
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 15:59:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9659660241
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CI/bTf022XyzFgn/EFJg0ERzUeG1+rHwmQ3Hy1ifP4A=; b=Ln3XLX+DZ4VS7qcYU+bedfeaPR
	s0g4xBL623IY3cll6inPmoC/Szc2IPrqHFE2VW8PH89ALZAmUH2OK3FR6x9D+yS277ASWRetPS21N
	Qj7MI3qTM7wQcOSQ6dXhWxmHy6C7UjGyPnmWtmw63dA4Z6e37Ql3K1vnQyN2+2WA/JHqx5x8mVXZx
	RL3DipD6M3ueUuJaBEoNyMEOsfaJuSf4pgrQFiLHZ1mOBMS5fAaolBCSjfnIdxMx7eQG636+BSNRY
	uptqLy6SJjvqIGq60YYHV/nPp8v8MJO9H/SR+/fPlcBt8k77EGGJSdYSvmS1wnmzburSuNkhBxkvA
	EE7Awkgw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRGmH-004HXp-9I; Tue, 30 Mar 2021 15:59:37 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRGll-004HQm-Ln
 for linux-nvme@lists.infradead.org; Tue, 30 Mar 2021 15:59:09 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1617119941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=pLt++mSfuvoo0Dj8M9HmhX/kRkkiHsEhNuDqLSUrI40=;
 b=mkwylF8vKiO4Iwu6Afh0dBP1Cd7h/FD322BImYF6Ly9uWJf7q7YcGgioX4QwP1HMPFs5xp
 C8jm0I+mzcb+G5edp5lD7YAcOL+Gl+8dsEVAqfweeO0snRX0jMDcvl7FBrH24vd233rtaT
 3njcsMqQw4O86Rc92axgEb9FO7GsKMQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id DA177AF10;
 Tue, 30 Mar 2021 15:59:00 +0000 (UTC)
From: mwilck@suse.com
To: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, Enzo Matsumiya <ematsumiya@suse.de>,
 Martin Wilck <mwilck@suse.com>
Subject: [PATCH v2 0/9] Some minor fixes/additions for nvme-cli
Date: Tue, 30 Mar 2021 17:57:02 +0200
Message-Id: <20210330155711.8436-1-mwilck@suse.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210330_165906_154584_0F7A9820 
X-CRM114-Status: GOOD (  17.19  )
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
compile. A v3 of the monitor code is about to follow.

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

Changes v1 -> v2:

 - rebased on current upstream
 - squashed previous patches 1 and 2 into one, and simplified the logic
   (Sagi) - if the kernel has no "kato" attribute, we now simply assume
   that existing discovery controllers we encounter are persistent.
 - added Reviewed-by: trailers where appropriate

Hannes Reinecke / Martin Wilck (1):
  nvme-discover: lookup existing persistent controllers

Martin Wilck (8):
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
 Makefile                            |   3 +-
 fabrics.c                           | 218 +++++++++++++++++-----------
 nvme-topology.c                     |   2 +-
 nvme.c                              |   2 +-
 nvme.h                              |   4 +-
 util/cleanup.c                      |   4 +
 util/cleanup.h                      |  18 +++
 util/log.c                          |  90 ++++++++++++
 util/log.h                          |  34 +++++
 12 files changed, 295 insertions(+), 102 deletions(-)
 create mode 100644 util/cleanup.c
 create mode 100644 util/cleanup.h
 create mode 100644 util/log.c
 create mode 100644 util/log.h

-- 
2.30.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
