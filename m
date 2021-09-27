Return-Path: <SRS0=w6YM=OR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271BBC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 22:01:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB5DB61058
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 22:01:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EB5DB61058
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=IXG6lizjl7k7Q+h4rl+Us96BGfuc8aZYU3tMdrk30wY=; b=AE9C3XDoDXn7hR
	vSQ7wxnEKub/ZWYiG5yAUYkmg3+n9bXJDRAj58jCvPQ3P4bKW9ewkzu9DyLeIaImovgX2Bgd7gGnT
	Ghq3onACkLCi57RgSpeTAZSKgGeU0LJRVkP+9vRlfjLFo4IQw4USv2aGtV2tB5YpaRTciaRWfPsKj
	nA9g+sjZUgI3SGGXYMmtnTmbqd35IdPW6ajO4IPHVbkQKKDzsbdNfwshfKqQDSRWyVq8xO64Csvs6
	KoYNF7jfGD9aB3VzyXxBaq88Qe9LvFDtQ2duriQxWnO4oYCnSCfda3FX9EoGYufEUkTL1H0KVdswM
	HiDuO+/WU42B/wpZKC6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUyfZ-004Sdq-CE; Mon, 27 Sep 2021 22:00:17 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1mUyfM-004SUt-Qa; Mon, 27 Sep 2021 22:00:04 +0000
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
Subject: [PATCH v4 0/6] block: first batch of add_disk() error handling
 conversions
Date: Mon, 27 Sep 2021 14:59:52 -0700
Message-Id: <20210927215958.1062466-1-mcgrof@kernel.org>
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

This is the first set of driver conversions to use the add_disk() error
handling. You can find these changes along with the entire 7th set of
driver conversions on my 20210927-for-axboe-add-disk-error-handling
branch [0].

Changes on this v4 since the last v3:

 - Rebased onto linux-next tag 20210927
 - I drop the patches already merged
 - Fix the scsi/sd, scsi/sr as noted by Ming Lei
 - md: rebased in light of "md: fix a lock order reversal in md_alloc"
 - Adds Reviewed / Acked by tags where appropriate. I didn't keep the
   review by Hannes on the scsi patches as those patches are now
   slightly fixed

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20210927-for-axboe-add-disk-error-handling

Luis Chamberlain (6):
  scsi/sd: add error handling support for add_disk()
  scsi/sr: add error handling support for add_disk()
  md: add error handling support for add_disk()
  dm: add add_disk() error handling
  loop: add error handling support for add_disk()
  nbd: add error handling support for add_disk()

 drivers/block/loop.c | 8 +++++++-
 drivers/block/nbd.c  | 6 +++++-
 drivers/md/dm.c      | 4 +++-
 drivers/md/md.c      | 6 +++++-
 drivers/scsi/sd.c    | 8 +++++++-
 drivers/scsi/sr.c    | 7 ++++++-
 6 files changed, 33 insertions(+), 6 deletions(-)

-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
