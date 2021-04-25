Return-Path: <SRS0=MVBk=JW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E101C43460
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Apr 2021 08:58:47 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE6FD613B4
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Apr 2021 08:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE6FD613B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=sRl4UBvIrGdpmFGBPhqG6+zwZfvOejz+H9MTIXzHC1I=; b=XU4BMQdn1xyncVHIxUxFJRQq8C
	D0ypudrfrn1niUhzKqFFO0e4DCq+qbvKHohqvcXE5hD5yWvIwh/PxGgV1BnbqZMjz7T3xtYdcQJeI
	8xoC2EKumbNbS3H6Y+PNBLUW3P79zWDGoHw7EpUkYWgvOleWDcUWTQSQIcNfGHIH+F4MnAoa/X7XF
	hjGWJufAhRJd3Qt9ySL8CuBn+8ut/P4JLK/qmk9GbpqQXnVfD6gvf7eReMlr+1FbM4LIA0c2D05Tc
	8xIgymQw+16sV/SR+k9j337FYu9pohxPgscTT6KY646gSjuL1fQC983V+amaF2niry20A1nMzMQNg
	Evqn8NOA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1laaam-005Jpm-Dq; Sun, 25 Apr 2021 08:58:16 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1laaai-005JpV-Nl
 for linux-nvme@desiato.infradead.org; Sun, 25 Apr 2021 08:58:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=b6ybz+qmRf2Zi4nCd5Sb3S6od2SpNl7/yvNkCu5afNM=; b=Z/6YOMNmAy7Lld2oo7jBktsG1U
 Gmvsua9AAxgqhFLh/HvifwpJCOdS0SovJM/rZWBgnTkSFBADTrbE5/9v1yAzBXaFrrEIdAc2gIV+Y
 vipPZTCQtzJXUhlt+1oq9es4tsDIxZDKPEcQynGdyZf2W3wHpNO8k78Pqakf2PMpCAUp2P9nqEOoW
 wTWK6vcpjc1zHR0JClvHQZjADJp4QtRcgvJ72dCZM6bQRHYtVDYjZLqvjzIBygkV7TPShDfPQNj6A
 40H4oxOs2t2OkLgb290A0po/xkROFIf0bVENO/eHMLWYKL0jp7qbPmzB78h6gXsx9kc1zRzQVdqGj
 fBBzY7kA==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1laaaf-00FMWB-3i
 for linux-nvme@lists.infradead.org; Sun, 25 Apr 2021 08:58:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619341085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=b6ybz+qmRf2Zi4nCd5Sb3S6od2SpNl7/yvNkCu5afNM=;
 b=bg5O1AkdoBdry9/HRRrkku74B7K1HdnzuT3lrRIgxs59npwhX70/6cvmAY6/kCds6s1B34
 IamwsrzO+akRAnY0ihgrNfhkYsDqTYTER/2WNvDoXuDIiJtk58MRRO0nFA44h4L5ZlJn5X
 gpZQoGO+Yez+caNFl80DeK6JrZyGGkU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-IVIFdt_CM9OX-FE2Fq9inA-1; Sun, 25 Apr 2021 04:58:02 -0400
X-MC-Unique: IVIFdt_CM9OX-FE2Fq9inA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E7D1343A6;
 Sun, 25 Apr 2021 08:58:00 +0000 (UTC)
Received: from localhost (ovpn-13-143.pek2.redhat.com [10.72.13.143])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 67D182BFF1;
 Sun, 25 Apr 2021 08:57:55 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>, Khazhy Kumykov <khazhy@google.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Hannes Reinecke <hare@suse.de>, John Garry <john.garry@huawei.com>,
 David Jeffery <djeffery@redhat.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/8] blk-mq: fix request UAF related with iterating over
 tagset requests
Date: Sun, 25 Apr 2021 16:57:45 +0800
Message-Id: <20210425085753.2617424-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210425_015809_252913_AEF20213 
X-CRM114-Status: GOOD (  13.30  )
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

Hi Guys,

Revert 4 patches from Bart which try to fix request UAF issue related
with iterating over tagset wide requests, because:

1) request UAF caused by normal completion vs. async completion during
iterating can't be covered[1]

2) clearing ->rqs[] is added in fast path, which causes performance loss
by 1% according to Bart's test

3) Bart's approach is too complicated, and some changes aren't needed,
such as adding two versions of tagset iteration

This patchset fixes the request UAF issue by one simpler approach,
without any change in fast path.

1) always complete request synchronously when the completing is run
via blk_mq_tagset_busy_iter(), done in 1st two patches

2) grab request's ref before calling ->fn in blk_mq_tagset_busy_iter,
and release it after calling ->fn, so ->fn won't be called for one
request if its queue is frozen, done in 3rd patch

3) clearing any stale request referred in ->rqs[] before freeing the
request pool, one per-tags spinlock is added for protecting
grabbing request ref vs. clearing ->rqs[tag], so UAF by refcount_inc_not_zero
in bt_tags_iter() is avoided, done in 4th patch.


[1] https://lore.kernel.org/linux-block/YISzLal7Ur7jyuiy@T590/T/#u

Ming Lei (8):
  Revert "blk-mq: Fix races between blk_mq_update_nr_hw_queues() and
    iterating over tags"
  Revert "blk-mq: Make it safe to use RCU to iterate over
    blk_mq_tag_set.tag_list"
  Revert "blk-mq: Fix races between iterating over requests and freeing
    requests"
  Revert "blk-mq: Introduce atomic variants of
    blk_mq_(all_tag|tagset_busy)_iter"
  blk-mq: blk_mq_complete_request_locally
  block: drivers: complete request locally from blk_mq_tagset_busy_iter
  blk-mq: grab rq->refcount before calling ->fn in
    blk_mq_tagset_busy_iter
  blk-mq: clear stale request in tags->rq[] before freeing one request
    pool

 block/blk-core.c                  |  34 +------
 block/blk-mq-tag.c                | 147 ++++++------------------------
 block/blk-mq-tag.h                |   7 +-
 block/blk-mq.c                    | 100 +++++++++++++-------
 block/blk-mq.h                    |   2 +-
 block/blk.h                       |   2 -
 block/elevator.c                  |   1 -
 drivers/block/mtip32xx/mtip32xx.c |   2 +-
 drivers/block/nbd.c               |   2 +-
 drivers/nvme/host/core.c          |   2 +-
 drivers/scsi/hosts.c              |  16 ++--
 drivers/scsi/scsi_lib.c           |   6 +-
 drivers/scsi/ufs/ufshcd.c         |   4 +-
 include/linux/blk-mq.h            |   3 +-
 14 files changed, 119 insertions(+), 209 deletions(-)

-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
