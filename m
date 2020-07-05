Return-Path: <SRS0=sPWJ=AQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5392BC433E0
	for <linux-nvme@archiver.kernel.org>; Sun,  5 Jul 2020 07:59:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20C9920737
	for <linux-nvme@archiver.kernel.org>; Sun,  5 Jul 2020 07:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sYnvg8+P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C9920737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wmWpGR5a5QFht4AkuXatvXPxmnoPsdShuwnxOY7ICr4=; b=sYnvg8+PXwISCpQ1WrsK/gTkVb
	MtqsL8mIRV8E2kiUy3qp/9QWLcCIGK7+D22PowL/MbVTQPZSbQ7bfkBGMXXHGaZTQc9CMn0VJxDpf
	CgrI22sVomiO9fifxrEQHIV9InLToFb7PsJIa2FbCGU8LftjuCZZSGkDcq8op0zh/N5NPpejF65Hb
	oMSMeq7Y+XgU/vu01SFQS/Nvvz3WNA6GfkflCCx4lC4gP4I/Mn9Odtia8LBXWB6EshsDVXVH33ZsT
	9feHxP360H/fzmdi3Eegmk+LEZG7nyR1So1z+JVi3dFe6sHZ8RYe/P39svkznt2mdNkvnlinUwnSo
	XrC5VTzg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jrzYr-0006RF-27; Sun, 05 Jul 2020 07:59:41 +0000
Received: from mail-pl1-f194.google.com ([209.85.214.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jrzYo-0006Qb-9V
 for linux-nvme@lists.infradead.org; Sun, 05 Jul 2020 07:59:38 +0000
Received: by mail-pl1-f194.google.com with SMTP id o1so7582297plk.1
 for <linux-nvme@lists.infradead.org>; Sun, 05 Jul 2020 00:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mu9CxNGVPoaPob0uHoq3t/xToPh1GlGlVKZUwZhG+DM=;
 b=GxP2XIO+hNHId35sJJ9RS/UytEQUsVwAUIcyW09aJeKR8KVVPVP55bdS/2jcAMzWkp
 03celR0T36pguoyXDqnJuKjzaUUfRmm18A5jWFTvi0/LbznX3DWpDhzOycSGMT09XMLJ
 siH4fzErkUoTf4//kQ1O0ki5tuX0VPeUnG6vZSeqHXhCy6idfVBqNDDS5P2ejkj+GnOW
 2c/pPF3ogN1PAIYC+ePBVE9awPRsH2ZR81ATZcox6FMF3gA2iRvOI+G3LGPnT7RbiV/D
 egBpIiyJg9BcYS7vs7qxMhYtq7Ay5LXTXMO1ze47083zp4wukrv2ihQg+jEspjIoedWk
 urXg==
X-Gm-Message-State: AOAM530q9lAslULSdmATs5kRz56r1rZcWhwxA/psp7WAWqSN8DWrfvCC
 bnVzqeHE4FIGin84jChyCyAoL8Vv
X-Google-Smtp-Source: ABdhPJyr8Hkdl8bUMKe++D1iOOaO8bVF+qfJ+xC4OkCjhK+Wi5n/HZKasbrTCEpU2Dz9JN8jTes2kw==
X-Received: by 2002:a17:902:9a81:: with SMTP id
 w1mr35204256plp.50.1593935977156; 
 Sun, 05 Jul 2020 00:59:37 -0700 (PDT)
Received: from localhost.localdomain (068-186-033-250.biz.spectrum.com.
 [68.186.33.250])
 by smtp.gmail.com with ESMTPSA id k26sm16133228pgt.90.2020.07.05.00.59.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2020 00:59:36 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH v2 rfc 0/3] resolve controller delete hang due to ongoing
 mpath I/O
Date: Sun,  5 Jul 2020 00:59:32 -0700
Message-Id: <20200705075935.506535-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200705_035938_368576_82098B77 
X-CRM114-Status: GOOD (  10.93  )
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
Cc: Anton Eidelman <anton@lightbitslabs.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Changes from v1:
- Rename states to NVME_CTRL_DELETING and NVME_CTRL_DELETING_NOIO to better
  describe the states
- Added prep patch to split nvme_remove_namespaces to _prep_ and _do_
- Added prep patch to provide some documentation about the states

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

Feedback is welcome.

Sagi Grimberg (3):
  nvme: split nvme_remove_namespaces
  nvme: document nvme controller states
  nvme-core: fix deadlock in disconnect during scan_work and/or ana_work

 drivers/nvme/host/core.c      | 45 +++++++++++++++++++++++++++--------
 drivers/nvme/host/fc.c        |  1 +
 drivers/nvme/host/multipath.c | 13 +++++++++-
 drivers/nvme/host/nvme.h      | 23 +++++++++++++++++-
 drivers/nvme/host/pci.c       |  4 +++-
 drivers/nvme/host/rdma.c      | 10 ++++----
 drivers/nvme/host/tcp.c       | 15 +++++++-----
 7 files changed, 88 insertions(+), 23 deletions(-)

-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
