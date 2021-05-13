Return-Path: <SRS0=xhFb=KI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E14C433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 17:04:15 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C6E961443
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 17:04:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C6E961443
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XSlHpERzSWbzUp0Yn3fTrJjLfjdOHkrMmOtoGqxvSFc=; b=BMgjSBu4Ph0RDtk0+//LB0hiX/
	jh799w5V8PB0aKQpwfnmH6lH76+0ue4JBxRL75WPTNdJZJlAHZMkFO+hhhCDNypi28nFUXbpZdLK1
	DdDJlyWDFa2XLuOeRyfsKh0ZO2D0aB7EWMc54niTWnNw1OHnadwugyMM2x7AX69ebpkS9Fh8VD5n+
	pac4j5FSRVJoLtxPROeQ9NgVLipilEsH2VO4VcgZQJ+r2k4RB3/UfJVBKmQKmDHq80nnH7T+5DKFE
	TbgC4ew2aQp2x7nl4NtY+7DjKTR1inZ8sJ7Cvxw38SepPqZZu5R20sXWecKIwQxpwNmnZkafrcUKw
	9AIVnlGQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhEkW-0062MG-1W; Thu, 13 May 2021 17:03:48 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhEkU-0062M4-1u
 for linux-nvme@desiato.infradead.org; Thu, 13 May 2021 17:03:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=fiCWapO073jEA0FUhOiRuc4EhkynRDlHMqEG2raIyC4=; b=zqGQUb/zw4xOK/n5ziSLL5ZDYS
 4ggTWxZEvp57J1Ajy6OQaXn24aXWeBSH/XRSvEhStFKaJGl8BfcLkjQmELcnmRWwcqhW8c6DK1fLW
 WEQi5bqUQw3vu5idBHVtNVC8+Ccf/jxjMQN2gwnwXdBbjNyPDopO4RoAYhExjv5h8mPKhXGl1hl0k
 t/Q1TJWUuJ0bNPY5AxQslF7wvheu3UmpR2P0o8nm5/iafE4o7qoT4fgYB06oGeNXkvXXxG501e8zf
 Soigj4ipNRK87pE87zzeISKB4VQYwjUixf7RrsJ4x0qqEa4oB+uDa8jqrbdzLGmaLUCzMt1XTd/Kg
 cMRO8oHg==;
Received: from [2001:4bb8:198:fbc8:26bf:3bb3:2a36:e078] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lhEkR-00BPAu-EY; Thu, 13 May 2021 17:03:44 +0000
Date: Thu, 13 May 2021 19:03:40 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 5.13
Message-ID: <YJ1b7OeZpoR3j13K@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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

The following changes since commit efed9a3337e341bd0989161b97453b52567bc59d:

  kyber: fix out of bounds access when preempted (2021-05-11 08:12:14 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.13-2021-05-13

for you to fetch changes up to e181811bd04d874fe48bbfa1165a82068b58144d:

  nvmet: use new ana_log_size instead the old one (2021-05-13 16:33:32 +0200)

----------------------------------------------------------------
nvme fix for Linux 5.13

 - correct the check for using the inline bio in nvmet
   (Chaitanya Kulkarni)
 - demote unsupported command warnings (Chaitanya Kulkarni)
 - fix corruption due to double initializing ANA state (me, Hou Pu)
 - reset ns->file when open fails (Daniel Wagner)
 - fix a NULL deref when SEND is completed with error in nvmet-rdma
   (Michal Kalderon)

----------------------------------------------------------------
Chaitanya Kulkarni (5):
      nvmet: fix inline bio check for bdev-ns
      nvmet: fix inline bio check for passthru
      nvmet: demote discovery cmd parse err msg to debug
      nvmet: use helper to remove the duplicate code
      nvmet: demote fabrics cmd parse err msg to debug

Christoph Hellwig (1):
      nvme-multipath: fix double initialization of ANA state

Daniel Wagner (1):
      nvmet: seset ns->file when open fails

Hou Pu (1):
      nvmet: use new ana_log_size instead the old one

Michal Kalderon (1):
      nvmet-rdma: Fix NULL deref when SEND is completed with error

 drivers/nvme/host/core.c          |  3 ++-
 drivers/nvme/host/multipath.c     | 55 +++++++++++++++++++++------------------
 drivers/nvme/host/nvme.h          |  8 ++++--
 drivers/nvme/target/admin-cmd.c   |  7 ++---
 drivers/nvme/target/discovery.c   |  2 +-
 drivers/nvme/target/fabrics-cmd.c |  6 ++---
 drivers/nvme/target/io-cmd-bdev.c |  2 +-
 drivers/nvme/target/io-cmd-file.c |  8 +++---
 drivers/nvme/target/nvmet.h       |  6 +++++
 drivers/nvme/target/passthru.c    |  2 +-
 drivers/nvme/target/rdma.c        |  4 +--
 11 files changed, 58 insertions(+), 45 deletions(-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
