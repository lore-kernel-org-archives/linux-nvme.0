Return-Path: <SRS0=1rws=HL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DC5C433E6
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 04:09:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ABD264EB1
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 04:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ABD264EB1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Om2/xhMG7S16WnrKbi5K8fHajtq3/4i23oTAPNcHecY=; b=mtJGrVtCkgxh4jNj1jjtvXEwbW
	t8Oi/4Px76Ej5R77N5vBjkYn9w7qI0QOsLvvBOU+bfwbR16I6QCNZYF/t1VfOEQTM32JMEHOH6OjW
	UM4H8BXXNEblCKC5gXnvOV8b5sCZWSVJs1qyuUL4Dtq0qG8S3iJXYdlg2uZV701IKGWoRSrgLw4du
	bQmeXho5t14tMElqI/ZuYHN5AIA0zPy9XA6coZwVODIzgSKvSLQKCikln/E2c0r2gOymAbcfh44hY
	M7ozh5lBkYQoXppja2k6pXWnLtT0iWUgVY+T45oqQINUaLvDiIYkd4dy73sS3fdKK4FpJ2HXxjXMr
	9NdsYHmw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9KKZ-0002sw-72; Tue, 09 Feb 2021 04:08:51 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9KKV-0002rF-NA
 for linux-nvme@lists.infradead.org; Tue, 09 Feb 2021 04:08:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612843727; x=1644379727;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=2i94CNXtCIzZQTTJjv6Dm6n9JRhyI9qBzbzSgyk9WzI=;
 b=c8jylNmnpElt6dc/gewwoMftU3K0nw1cTlevVorFTALDMnhBJ50Z6U6d
 g715uMTmCmBL+XxhuUvOqzKkerCjhasW/beELLIiWa2Yjl9UUFMUd7tgL
 CBh5bx3XrKjv6NbL5Xdp1u2vkjynQkaXHM0hCGVKXrlIlp26Md3QyGqAr
 axYspou3H881yRDhn5/eftfR9AHwJQ1VPrYgyaKMiXOy4P/0pioqhaki1
 OMIItshsLm7UEpDrTTT2r7z8kqzg1Jgc13pSU/tgMAApcVD8eBWXirE3g
 ADGGSRyIk5sd3fN+Zbc+pnl8aSUz+botGj8x3o9fQyU2+cho6Tc6UlJkB g==;
IronPort-SDR: 2aF77sJQRRjh2zJJI+nWpbbPaHjE/JEEsHbRxqVwcIhmJJWfAaAtuQg/GB0+YHPT1BrwZeR1zG
 7d1c7ZPARCNwxVoScnnPfk9gPGJdf1u0XF2H79K+Jl+6gGlqHdLIIAvPZClIKitdzIc9xoxaIr
 W348LwpHVQriX4zK/JKe+21F7fyuork5axFVXifZVxctzc+tzv5iHmsZMUk9y60oA+XPBpeKiY
 MznHZ/7UjRJ8JQq1NMAfQgDf18BOZrww0BOBgsebu+Lph40f7WZkMzdJUzhTBtZ5CIVopWFyvF
 Cxg=
X-IronPort-AV: E=Sophos;i="5.81,164,1610380800"; d="scan'208";a="269970512"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2021 12:08:44 +0800
IronPort-SDR: JTlUKRdG7+3TeVXGX8JgVWS/ilPkrP+XTsGYeqotLv+NWsvcPZ1cwQGLd2h8MASSyWOGzNMmpu
 i95wcDHtePnnFVR1M5wqSdkqQz2sM6/p3CDGgOHcoqHxwVf53tFPhELaZmuSAPHZPdGgg33Nt4
 1I2t6BEY4RpnjmRccPj2IjOTu49tpFQvnWcIBg+0PKnagUsn42YgGZbwKHAEVqn0JLoJCAjiCb
 9U0DnNkh/9prUA4RhBq9EmjAwkxdgTCWzHUGcp8+lzaAglJt8olSGeIB0vmpTuTFkj/Iy9uWLK
 AG/pojt5t6Bh1FlfHCPM/n9g
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2021 19:50:38 -0800
IronPort-SDR: jKvDSY27AlGI/BGbru+ciCjgHoAKNoE9JuC2hn5VSMIh7VEx/vPP3LY8SzycMfCC7LkmtxfqFW
 rcWLj40CFlk/DGWVz7EefpJmoHXv1ynnaWqvccPhC00SkReQE3l6+Pz2tcucPty7jVPJSheFjE
 o6ERP30V2Cc9H5bsP2Z0G4ci7DfsATi5rd4bknZgZFGXb5fhU1WbhDruaa7hlJ5BJJiCG4f9+u
 yS/SEHtICcwjHJj8YUuu+PODJcg6e/eJApw/QhYy2dcJdcaEq3+5KBrQNyGBy8X+xZkIdaU+Uh
 9H0=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 08 Feb 2021 20:08:45 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 00/11] nvmet: fixes and some cleanups
Date: Mon,  8 Feb 2021 20:08:32 -0800
Message-Id: <20210209040843.45572-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210208_230847_911246_F9D9CBDD 
X-CRM114-Status: GOOD (  16.27  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

This patch-series fixes behavior for id-ns that is against the spec and
does cleanup for nvmet_find_namespace() to get rid of the duplicate code
and remove the inconsistent error behavior of the host, Also this adds
an helper for unhandled commands to have uniform error message
reporting for the bdev, file and passthru backend. Patch 9/10 fix
compilation warnings. Last patch removes an unnecessary else at the tail
of the nvmet_parse_io_cmd().

This is based on nvme-5.12. All the blktests are seem to pass on this
series.                

Regarding the comment on V1 for bffcd507780e being wrong see [1], we can
continue the discussion.

-ck   

[1] http://lists.infradead.org/pipermail/linux-nvme/2021-February/022637.html

Changes from V1:-

1, In nvmet_execute_identify_ns() zeroout buffer for unallocated nsid.
2. Adjust the patch #2 to reflect above behavior.
3. Merge patch #3 and #4 from V1 to change the nvmet_find_namespace()
   prototype to only accept request.
4. Rename nvmet_find_namespace()->nvmet_req_find_namespace().
5. Remove the backened string print from nvmet_report_invalid_opcode() &
   replace pr_err() with pr_debug().
6. Add a new patch that creates a helper nvmet_req_subsys() to replace
   a chain of the structures all over code to get the subsys from
   nvmet_req.
7. Add a patch to remove the unnecessay else at the tail of the
   nvmet_parse_io_cmd().

Chaitanya Kulkarni (11):
  nvmet: zeroout id-ns buffer for invalid nsid
  nvmet: return uniform error for invalid ns
  nvmet: make nvmet_find_namespace() req based
  nvmet: remove extra variable in id-ns handler
  nvmet: add helper to report invalid opcode
  nvmet: use invalid cmd opcode helper
  nvmet: use invalid cmd opcode helper
  nvmet: use min of device_path and disk len
  nvme-loop: rename variable to get rid of the warn
  nvmet: add nvmet_req_subsys() helper
  nvmet: remove else at the end of the function

 drivers/nvme/target/admin-cmd.c   | 69 +++++++++++++++----------------
 drivers/nvme/target/core.c        | 28 +++++++------
 drivers/nvme/target/io-cmd-bdev.c |  5 +--
 drivers/nvme/target/io-cmd-file.c |  5 +--
 drivers/nvme/target/loop.c        |  2 +-
 drivers/nvme/target/nvmet.h       | 18 +++++++-
 drivers/nvme/target/passthru.c    |  6 +--
 drivers/nvme/target/trace.h       |  4 +-
 8 files changed, 73 insertions(+), 64 deletions(-)

-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
