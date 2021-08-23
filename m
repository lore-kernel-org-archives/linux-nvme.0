Return-Path: <SRS0=nO+g=NO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C362FC432BE
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Aug 2021 20:31:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C41D61357
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Aug 2021 20:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8C41D61357
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=NvmOob+LkVdRSWKtBn0Sj6g5LjeJZJlX9N/Jv21MQ5g=; b=d+zkfQP65/f41P
	UY65+Rbx0Tr0NOa7kVLNmOioxLr5t+KBK8+SZKG/VK0pDNNmG8QjUf5otI184801ZhZpUX7fGFOgf
	+s+smjmr1ZMPyDK8OtEsbbNygrNaRVp727kUh6P1LNghVJqL+lk+lzdv0ZV6eTNlISo03E2bl+wdF
	7ymxS0NW29Se8aNCp9riO9XQ9sdwol3hlxMOIowcDuSDNZebiEg8kcVPjHplC8/+L3gupUeFb5V3H
	akAZIjplRQywx5nSXVkNhNMo7yTpS9GXInKdtdn80l7Q5PSyafRLICHs09acWfg8n51tFumRV7DqT
	jlTf9PED1c1hMvH1ujow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mIGax-000aRB-KM; Mon, 23 Aug 2021 20:30:59 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1mIGZZ-000ZjI-Ty; Mon, 23 Aug 2021 20:29:33 +0000
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
Subject: [PATCH 00/10] block: first batch of add_disk() error handling
 conversions
Date: Mon, 23 Aug 2021 13:29:20 -0700
Message-Id: <20210823202930.137278-1-mcgrof@kernel.org>
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

There's a total of 70 pending patches in my queue which transform
drivers over to use the new add_disk() error handling. Now that
Jens has merged the core components what is left are all the other
driver conversions. A bit of these changes are helpers to make that
easier to do.

I'm going to split the driver conversions into batches, and
this first batch are drivers which should be of high priority
to consider.

Should this get merged, I'll chug on with the next batch, and
so on with batches of 10 each, until we tackle last the wonderful
world of floppy drivers.

I've put together a git tree based on Jen's for-5.15/block branch
which holds all of my pending changes, in case anyone wants to
take a peak.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20210823-for-axboe-add-disk-error-handling-next

Luis Chamberlain (10):
  scsi/sd: use blk_cleanup_queue() insted of put_disk()
  scsi/sd: add error handling support for add_disk()
  scsi/sr: use blk_cleanup_disk() instead of put_disk()
  scsi/sr: add error handling support for add_disk()
  nvme: add error handling support for add_disk()
  mmc/core/block: add error handling support for add_disk()
  md: add error handling support for add_disk()
  dm: add add_disk() error handling
  loop: add error handling support for add_disk()
  nbd: add error handling support for add_disk()

 drivers/block/loop.c     |  9 ++++++++-
 drivers/block/nbd.c      |  6 +++++-
 drivers/md/dm.c          | 16 +++++++++++-----
 drivers/md/md.c          |  7 ++++++-
 drivers/mmc/core/block.c |  4 +++-
 drivers/nvme/host/core.c | 10 +++++++++-
 drivers/scsi/sd.c        |  8 ++++++--
 drivers/scsi/sr.c        |  7 +++++--
 8 files changed, 53 insertions(+), 14 deletions(-)

-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
