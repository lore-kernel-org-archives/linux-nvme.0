Return-Path: <SRS0=9COT=NS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061E5C25AED
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Aug 2021 19:05:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C42CC60F25
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Aug 2021 19:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C42CC60F25
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=N3rAVnchGXoMHEHm0PCH/mSDQ7f8eCS1r42NKTZ1jfU=; b=tKSEtb2XcjhFnP
	esXm4Z4AXTzYG58ULAmjzhFQ+tX6hoUWmDxoC7dR18zXIQXKEtmFc1o/pIDvI80qpyRBX88Tx/Ts4
	T810rNOMr+3qae9/xxzAifC9JiU8Kmc4xUesDSz4L43Y4ZsiFzSJoWuqcXL8xEdn9sJOR1Ew2n18M
	uo2shKMmW82hVcSir+1Qw92y86/ATUlAmNXHVURe15RJDNtYapSGy3aaKvwl85/S3FO76VASxQsxC
	euHazlx4v8P6MmoH3kUFOjDn1/MUM+kkFynzIRNqXW3l/F3pJTB4ZN8Q1ltRitArvuRLGXwsEer0M
	J+6Jaf+GT2F1Ah2cTrBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mJhAZ-00D1YY-AY; Fri, 27 Aug 2021 19:05:39 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1mJhA1-00D1Kz-4A; Fri, 27 Aug 2021 19:05:05 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: axboe@kernel.dk, martin.petersen@oracle.com, jejb@linux.ibm.com,
 kbusch@kernel.org, sagi@grimberg.me, adrian.hunter@intel.com,
 beanhuo@micron.com, ulf.hansson@linaro.org, avri.altman@wdc.com,
 swboyd@chromium.org, agk@redhat.com, snitzer@redhat.com,
 josef@toxicpanda.com
Cc: hch@infradead.org, hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
 linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-mmc@vger.kernel.org, dm-devel@redhat.com, nbd@other.debian.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 0/6] block: first batch of add_disk() error handling
 conversions
Date: Fri, 27 Aug 2021 12:04:58 -0700
Message-Id: <20210827190504.3103362-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
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

This v2 drops two of the scsi patches which  Christoph pointed out were
not needed. It also fixes the nvme driver change to account for the
missing put of the ctrl. It also just appends the commits with the
respective reviewed tags. I've also dropped the mmc and dm patches
from this series as that is still pending discussion. I'll roll that
into the my next series after discussion is done.

The only patch which goes without a review tag is the nvme driver change.

These changes go rebased on Jen's latest axboe/for-next. The respective
full queue of my changes can be found on my git branch [0].

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20210827-for-axboe-add-disk-error-handling-next

Luis Chamberlain (6):
  scsi/sd: add error handling support for add_disk()
  scsi/sr: add error handling support for add_disk()
  nvme: add error handling support for add_disk()
  md: add error handling support for add_disk()
  loop: add error handling support for add_disk()
  nbd: add error handling support for add_disk()

 drivers/block/loop.c     | 9 ++++++++-
 drivers/block/nbd.c      | 6 +++++-
 drivers/md/md.c          | 7 ++++++-
 drivers/nvme/host/core.c | 9 ++++++++-
 drivers/scsi/sd.c        | 6 +++++-
 drivers/scsi/sr.c        | 5 ++++-
 6 files changed, 36 insertions(+), 6 deletions(-)

-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
