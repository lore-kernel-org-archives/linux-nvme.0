Return-Path: <SRS0=li1X=BB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF3BC433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jul 2020 23:32:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CF792086A
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jul 2020 23:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="zcRGfqkY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CF792086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bcd3Sy7Df4iHzGDo+fIDoFx/WLKu7lCX0nwKhQgK+dI=; b=zcRGfqkY4TJKXX/Z9yz9zCBD2/
	GWUPkbnCqgOhTZDnLwabdgOLge8eJT+cJVHZopCeit9sF9QtyHOyYVtxSmn63J2EQtVbqhRS0wU8S
	KssplWFCH4rd13VaD4O3XVLxRfxfkVtw4K3Npl8U1VkKJwHXvmTfS9TEE8CjrKbvc9xhRK8g2uoCn
	jxi46bYS5NM6aWc9zxeBXuwN3s6ri4vBUHm7bRBgpYXYxiss3/JICLPSxYt9eSp+D0VhNYptCQtyb
	Ziq3hHbg47Ju4KIn1nvACCvsF45exbKBs2viPLwd2EaFl7Kp1KVriMmrJt+WXG4FIJvpAz5yx4Cz9
	T7NgTsSw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jyOE3-0005F8-Eo; Wed, 22 Jul 2020 23:32:39 +0000
Received: from mail-wm1-f68.google.com ([209.85.128.68])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jyOE0-0005Eh-I7
 for linux-nvme@lists.infradead.org; Wed, 22 Jul 2020 23:32:37 +0000
Received: by mail-wm1-f68.google.com with SMTP id f139so3531888wmf.5
 for <linux-nvme@lists.infradead.org>; Wed, 22 Jul 2020 16:32:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=G9D64IbEDrK004ccpuN2Pz+3MMy0gNAEd5+cY60bPjY=;
 b=bZTuQeDaGJm6RGGq6WtFAkYUt0IsRjlZVYci1ezC40AB1nwT3Yhqz6DGBxXFmUckbh
 yNqcUsRC+6ceaqUW29uYYuqCx7jXx7JaphqdPKfR+mhLZqbJoFRjThFDzfeRWNUooM8u
 ktQNN65WjyFK2Vl6DZgWMWCbV4yWpKS4GwnAlZBvc0EflIKRNe79+btNwngaoS48Dx34
 wh7iZMpoHPQp8FQE7IsQA+75GEZ9kR0k5udSQVlsWHs7xTXY8kXWVPg5irfRnhUq2cQv
 aFvJJcNRpcrsiskggEO9NW2YK9LEX/kKvlziTtSDTNNPJ12Bd6HvW6oHLCQOq6dPIVqa
 1jzQ==
X-Gm-Message-State: AOAM530uibEtXKSW2ADmTQ6upia3XVroiQLCp3oc4jwB5lcCBMcv0aq9
 yLroFgpZhsUIcU01EJBa9xHndT8B
X-Google-Smtp-Source: ABdhPJyagrqi1P7GfPjRdJkUa/yciPYjkYly2bHHO59+IXbXuxvajGyLH+CsKz5YdFU4GhzrXfZY0A==
X-Received: by 2002:a05:600c:2949:: with SMTP id
 n9mr1601440wmd.69.1595460754683; 
 Wed, 22 Jul 2020 16:32:34 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:45ba:2951:1398:d100])
 by smtp.gmail.com with ESMTPSA id p29sm1309108wmi.43.2020.07.22.16.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 16:32:33 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH v3 0/2] resolve controller delete hang due to ongoing mpath I/O
Date: Wed, 22 Jul 2020 16:32:17 -0700
Message-Id: <20200722233219.117326-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200722_193236_607444_D643ED53 
X-CRM114-Status: GOOD (  11.44  )
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
Cc: Anton Eidelman <anton@lightbitslabs.com>,
 James Smart <james.smart@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Changes from v2:
- remove nvme_remove_namespaces split (Christoph)
- tweaked nvme_path_is_disabled to look better (Christoph)

Changes from v1:
- Rename states to NVME_CTRL_DELETING and NVME_CTRL_DELETING_NOIO to better
  describe the states
- Added prep patch to split nvme_remove_namespaces to _prep_ and _do_
- Added prep patch to provide some documentation about the states

--------------------------------------------------------------------------

A deadlock happens in the following scenario with multipath:
1) scan_work(nvme0) detects a new nsid while nvme0
    is an optimized path to it, path nvme1 happens to be
    inaccessible.

2) Before scan_work is complete nvme0 disconnect is initiated
    nvme_delete_ctrl_sync() sets nvme0 state to NVME_CTRL_DELETING

3) scan_work(1) attempts to submit IO,
    but nvme_path_is_optimized() observes nvme0 is not LIVE.
    Since nvme1 is a possible path IO is requeued and scan_work hangs.

4) Delete also hangs in flush_work(ctrl->scan_work)
    from nvme_remove_namespaces().

Similiarly a deadlock with ana_work may happen: if ana_work has started
and calls nvme_mpath_set_live and device_add_disk, it will
trigger I/O. When we trigger disconnect I/O will block because
our accessible (optimized) path is disconnecting, but the alternate
path is inaccessible, so I/O blocks. Then disconnect tries to flush
the ana_work and hangs.

This patchset alters the nvme states to address this deadlock condition.

Sagi Grimberg (2):
  nvme: document nvme controller states
  nvme-core: fix deadlock in disconnect during scan_work and/or ana_work

 drivers/nvme/host/core.c      | 15 +++++++++++++++
 drivers/nvme/host/fc.c        |  1 +
 drivers/nvme/host/multipath.c | 18 +++++++++++++++---
 drivers/nvme/host/nvme.h      | 20 ++++++++++++++++++++
 drivers/nvme/host/rdma.c      | 10 ++++++----
 drivers/nvme/host/tcp.c       | 15 +++++++++------
 6 files changed, 66 insertions(+), 13 deletions(-)

-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
