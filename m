Return-Path: <SRS0=15CP=IN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9BFC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 22:29:39 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C29F164E33
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 22:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C29F164E33
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=gEHtnGXGSgR1IM1NzJ8dLzULcrPkeOnFfhXq3zGg9WI=; b=Ua5rN6VVo2Ba5y
	F9V6R/d6MQcTl2jRkGjuhYWATUgfCJcsEbJJ+3lO55sEct6BGqMw+fVu5n3uPIUTdC8iM+DhymeRO
	g62rGUuWRaxor9j9qhUALL8W0ivKveMmhGRsQjyQC74CTom/IIBxkpTGH0XVJLgGpJpydD+a3O2pL
	jQLisHPmrTm1ao6iWanV1RBlZhSS8a0QYRglgdwO2LAReMWXoB8Dp60/Xv1UIiUa+S4jxaw3IT8Z2
	zvr5i8Aedjrbu0fi5zSZLg6KSwWxCeUYpHyDLOIA3r4CGrxsl9bMnOFmdaQLJeTG7OpUX7zmHEpJG
	lzKqPJkP+qonVNOOqhYQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lLvhr-00H1tS-SQ; Mon, 15 Mar 2021 22:29:08 +0000
Received: from mail-pj1-f47.google.com ([209.85.216.47])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLvgE-00H1oa-F5
 for linux-nvme@lists.infradead.org; Mon, 15 Mar 2021 22:27:29 +0000
Received: by mail-pj1-f47.google.com with SMTP id
 x7-20020a17090a2b07b02900c0ea793940so314195pjc.2
 for <linux-nvme@lists.infradead.org>; Mon, 15 Mar 2021 15:27:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QCiGnSH2yhtMS19IH+upNboQfOR/8mDv5GXy2I0LZN8=;
 b=SHaSdqYrwMJ63SwsMv2s752322PH4TYK3xN+TLq9Nyu7R8Mk4/DjPjwua/O8fsG0X6
 qKoKXSGqKe4BpH6ndOo7aW8dfksfksfq6KhYORrsi+MM+E+b6Uj8gHM4vIwcZJmdn8b+
 Kj6ESMiiKF9gChbG+RRMCYgWc5Z8iV4l9HpWOQk0+YPx19FSx+1PCn6Mzxp8hZx4XUD1
 +IxN5Yp0HwYtSAl+fVUP28E0kWLvf8Be0m2d26m+Za9z5BCwJHbyOyxEPXn8q2oqR3Nr
 L1OX0XXiJcbVDCbZFdJI6STypkSe0aZ23Hqf0f3RfwGsnwDGn01i7piZ7ANd34esLyS9
 aOvA==
X-Gm-Message-State: AOAM530b/hwdQxt+E6orLPIHT4BXzqwNlk/OG8XSbY+q5fJOm+u0lPiL
 p6K7jOY90wI4foIC2XtpHP6E/usSfGE=
X-Google-Smtp-Source: ABdhPJzyDmJqgu6eYgjOlsUA2E9e95MhUWcmZfxpbNO12HiKkHSRPDR0vsTSaVkaX88VsCRb9g+TMw==
X-Received: by 2002:a17:90b:3716:: with SMTP id
 mg22mr1299889pjb.157.1615847235900; 
 Mon, 15 Mar 2021 15:27:15 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:4faf:1598:b15b:7e86])
 by smtp.gmail.com with ESMTPSA id r16sm14614526pfq.211.2021.03.15.15.27.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Mar 2021 15:27:15 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH 0/3 rfc] Fix nvme-tcp and nvme-rdma controller reset hangs
Date: Mon, 15 Mar 2021 15:27:11 -0700
Message-Id: <20210315222714.378417-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210315_222727_893516_977B33D5 
X-CRM114-Status: GOOD (  14.47  )
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

The below patches caused a regression in a multipath setup:
Fixes: 9f98772ba307 ("nvme-rdma: fix controller reset hang during traffic")
Fixes: 2875b0aecabe ("nvme-tcp: fix controller reset hang during traffic")

These patches on their own are correct because they fixed a controller reset
regression.

When we reset/teardown a controller, we must freeze and quiesce the namespaces
request queues to make sure that we safely stop inflight I/O submissions.
Freeze is mandatory because if our hctx map changed between reconnects,
blk_mq_update_nr_hw_queues will immediately attempt to freeze the queue, and
if it still has pending submissions (that are still quiesced) it will hang.
This is what the above patches fixed.

However, by freezing the namespaces request queues, and only unfreezing them
when we successfully reconnect, inflight submissions that are running
concurrently can now block grabbing the nshead srcu until either we successfully
reconnect or ctrl_loss_tmo expired (or the user explicitly disconnected).

This caused a deadlock [1] when a different controller (different path on the
same subsystem) became live (i.e. optimized/non-optimized). This is because
nvme_mpath_set_live needs to synchronize the nshead srcu before requeueing I/O
in order to make sure that current_path is visible to future (re)submisions.
However the srcu lock is taken by a blocked submission on a frozen request
queue, and we have a deadlock.

For multipath, we obviously cannot allow that as we want to failover I/O asap.
However for non-mpath, we do not want to fail I/O (at least until controller
FASTFAIL expires, and that is disabled by default btw).

This creates a non-symmetric behavior of how the driver should behave in the
presence or absence of multipath.

[1]:
Workqueue: nvme-wq nvme_tcp_reconnect_ctrl_work [nvme_tcp]
Call Trace:
 __schedule+0x293/0x730
 schedule+0x33/0xa0
 schedule_timeout+0x1d3/0x2f0
 wait_for_completion+0xba/0x140
 __synchronize_srcu.part.21+0x91/0xc0
 synchronize_srcu_expedited+0x27/0x30
 synchronize_srcu+0xce/0xe0
 nvme_mpath_set_live+0x64/0x130 [nvme_core]
 nvme_update_ns_ana_state+0x2c/0x30 [nvme_core]
 nvme_update_ana_state+0xcd/0xe0 [nvme_core]
 nvme_parse_ana_log+0xa1/0x180 [nvme_core]
 nvme_read_ana_log+0x76/0x100 [nvme_core]
 nvme_mpath_init+0x122/0x180 [nvme_core]
 nvme_init_identify+0x80e/0xe20 [nvme_core]
 nvme_tcp_setup_ctrl+0x359/0x660 [nvme_tcp]
 nvme_tcp_reconnect_ctrl_work+0x24/0x70 [nvme_tcp]


In order to fix this, we recognize the different behavior a driver needs to take
in error recovery scenarios for mpath and non-mpath scenarios and expose this
awareness with a new helper nvme_ctrl_is_mpath and use that to know what needs
to be done.

Sagi Grimberg (3):
  nvme: introduce nvme_ctrl_is_mpath helper
  nvme-tcp: fix possible hang when trying to set a live path during I/O
  nvme-rdma: fix possible hang when trying to set a live path during I/O

 drivers/nvme/host/multipath.c |  5 +++--
 drivers/nvme/host/nvme.h      | 15 +++++++++++++++
 drivers/nvme/host/rdma.c      | 29 +++++++++++++++++------------
 drivers/nvme/host/tcp.c       | 30 +++++++++++++++++-------------
 4 files changed, 52 insertions(+), 27 deletions(-)

-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
