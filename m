Return-Path: <SRS0=Ir45=W2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0C0C3A59B
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Aug 2019 19:19:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF26523429
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Aug 2019 19:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DtvePfH/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF26523429
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=BFha27e4rfivq7ak0mcE8ss9rd5o/Tmtby+YMe/mPLg=; b=Dtv
	ePfH/c7BZckEBFC28euO6qqtB5hy1ncM9p/JDKEUjOxWSunCqp9YmS2KyJBaNduV9EBPNLYwHJmEi
	iFTlsH+dYIQk/Vmg/LxYj5kVQQ4r7bYyAPvyM1tRpNafZ50quSEqIn8eEqVhxrDfOvndBaiMgkjlp
	oBX9Y5HrrUc/hjomtWLUMMCFX2YEHCR0M2pLy7WNBTS5fgVVyaJrG2jxzbLmRXsG1LN11CEtZYKXg
	iutzGHMkttRadW+/52rED9y+e6zPbTIN/qnFvIGMddrx76GiVOutUdDpVRdCEnBsMugJ0iyzxAAB4
	95S4mUaJeQcPc7Fli3jkIqyaUz/DZGA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i3mQW-000324-QX; Fri, 30 Aug 2019 19:19:16 +0000
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d]
 (helo=sagi-Latitude-E7470.lbits)
 by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1i3mQU-00030j-SD; Fri, 30 Aug 2019 19:19:14 +0000
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v10 0/7] nvme controller reset and namespace scan work race
 conditions
Date: Fri, 30 Aug 2019 12:19:07 -0700
Message-Id: <20190830191914.29713-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
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
Cc: Keith Busch <keith.busch@intel.com>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hey all,

This series handles the reset and scanning race saga.

The approach is to have the relevant admin commands return a proper
status code that reflects that we had a transport error and
not remove the namepsace if that is indeed the case.

This should be a reliable way to know if the revalidate_disk failed
due to a transport error or not.

I am able to reproduce this race with the following command (using
tcp/rdma):
for j in `seq 50`; do nvme connect-all; for i in `seq 50`; do nvme reset /dev/nvme0; done ; nvme disconnect-all; done

With this patch set I was able to pass the test without reproducing the hang
that hannes reported.

This version follows Christoph's suggestion to ignore non dnr failures
in nvme_revalidate_disk

Changes from v9:
- fixed positive nvme status leak to the block layer (and also for
  the allocation path, just to be consistent)
- instead of checking revalidate_disk ret code, ignore transient
  errors (non-dnr) in nvme_revalidate_disk (suggested by Christoph)
- changed the ordering of the patches a bit
- collected some more review tags

Changes from v8:
- fixed nvme_revalidate_disk to never leak nvme status to the block layer
- used __nvme_revalidate_disk in nvme_validate_ns to also check for nvme
  status if return status is positive
- added patch to rename __nvme_revalidate_disk to nvme_revalidate_ns
- added patch that makes nvme_status_error get status instead of request struct
- added review tags

Changes from v7:
- added patch to split out revalidate_disk to ->revalidate_disk()
  and check_disk_size
- split nvme_validate_ns to call nvme_revalidate_disk and the new
  check_disk_size callout (only if nvme_revalidate_disk succeeded)

Changes from v6:
- dropped patch for nvme_submit_sync_cmd returning blk_status_t, it
  is now returning nvme status or negative errno again
- made nvme_identify_ns return status code and get id struct by reference
- made nvme_validate_ns check for -ENOMEM or NVME_SC_HOST_PATH_ERROR
  to decide if it should/should'nt to remove the namespace.
- added review tags

Changes from v5:
- don't return blk_status_t from nvme_submit_user_cmd

Changes from v4:
- return nvme_error_status in __nvme_submit_sync_cmd and cast to
  errno in nvme_identify_ns
- modified status print in nvme_report_ns_ids

Changes from v3:
- return blk_status_to_errno instead of blk_status_t in sync cmds
- check for normal return errno from revalidate_disk, this covers
  transport errors, but also spurious allocation errors and any
  type of transient errors.

Changes from v2:
- added fc patch from James (can you test please?)
- made nvme_identify_ns return id or PTR_ERR (Hannes)

Changes from v1:
- different approach

James Smart (1):
  nvme-fc: Fail transport errors with NVME_SC_HOST_PATH

Sagi Grimberg (6):
  nvme: fail cancelled commands with NVME_SC_HOST_PATH_ERROR
  nvme-tcp: fail command with NVME_SC_HOST_PATH_ERROR send failed
  nvme: pass status to nvme_error_status
  nvme: make nvme_identify_ns propagate errors back
  nvme: make nvme_report_ns_ids propagate error back
  nvme: fix ns removal hang when failing to revalidate due to a
    transient error

 drivers/nvme/host/core.c | 83 ++++++++++++++++++++++++++--------------
 drivers/nvme/host/fc.c   | 37 ++++++++++++++----
 drivers/nvme/host/tcp.c  |  2 +-
 3 files changed, 85 insertions(+), 37 deletions(-)

-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
