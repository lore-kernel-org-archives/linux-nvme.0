Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EA7606A328
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 14:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=mVBUg4sI;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=utSz2Sjj;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=5Xa6ctjs;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Vw67QubD;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=U9mWiuMF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=9o9xYc5lmDY7CWoEsDWTMZa3KKN6v+SNySa4h0JPOv0=; b=mVBUg4sIjJX5EdMMxaG6Q+b4Ir
	Y4hgV6tKMVCj/tT2SD7o31trHA0fZMb1NT3fb2grUZzokmJNxh7ZQhJF82JDwWV0F64O4BFPepYx7
	ZExiZg6BpzX0IOF91kP/RCJrzhn00m/ruHXVpBS4aQjfvlPBB/VA9e9K3KVrLS/Io2ZKh2bE2erBy
	I3BNshl7v9iNcFMzJo61dlZwt//i5AJD7a+F3Kq0bOWN+XOEknXWI614Mdhx1ltz2GuW+pcVcVjDP
	PXoGYeFtn6UhTrFYu3VNvHh3zDaIiTeLj4kaf4tZmaO82h+Ae+yOSaMQZr7xWXB0yAtZt1PiH2b3R
	VIF8Rg1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xObvW-00000005cqC-11BR;
	Wed, 04 Nov 2026 14:25:22 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xObvT-00000005cox-3fzu
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 14:25:21 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EE36521F44;
	Wed,  4 Nov 2026 14:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793802318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9o9xYc5lmDY7CWoEsDWTMZa3KKN6v+SNySa4h0JPOv0=;
	b=utSz2SjjaSpX7Kn0biWFceXUYX228o4BrVKc2TB4G/uw3aXqxWfQSK7CdLG59HiUkti0mC
	OK37OAqWkHWVtxIiUUUoJa377vSoCEsY5n2hk/PUvNIM3V5VTyykepoGfx791KRg16TGJe
	o7cyt6SsWNCJKrpLqxClbzSD3Euh7bQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793802318;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9o9xYc5lmDY7CWoEsDWTMZa3KKN6v+SNySa4h0JPOv0=;
	b=5Xa6ctjsWe+ykI1FleZlstO+ZUuMo5YXL9pCEnOSLGGzvwkLYUxS2TtPmlYceJfMrHN2cC
	ho8KLjGuLfK4YrBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793802316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9o9xYc5lmDY7CWoEsDWTMZa3KKN6v+SNySa4h0JPOv0=;
	b=Vw67QubDzFVHDAeuHq5ecOTVc/I/TbKbAmR2lWOjo9oxGDx7FwSdWCpKKMnjH/LWNZRfMU
	aKOp8TWMhVo33g9+dkktZSw4WEVj0YiiEUeA5XKP6Ob5qwDO4pv3sh4niMDM1QvzpOl9MF
	1Qk+xjvZDxqrE4QPlDFb7JYZLRAG5NY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793802316;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9o9xYc5lmDY7CWoEsDWTMZa3KKN6v+SNySa4h0JPOv0=;
	b=U9mWiuMFQg9C4vsqr5gEroaSoCCqMstC5ehBZDrjcWZ/Mh16/zfS0VY1coZ/V8dVpwMqBN
	BHIGFQUml5UuZ+DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ADB1F134F0;
	Wed,  4 Nov 2026 14:25:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ll6AIUxA62pQagAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 04 Nov 2026 14:25:16 +0000
From: Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 0/6] nvme: tests for fabrics queue mapping and
 isolated or offline CPUs
Date: Wed, 04 Nov 2026 15:25:12 +0100
Message-Id: <20261104-nvme-isolcpu-v2-0-2d59f622a2c8@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NSw7CIBCGr9LMWgwQRevKe5gu+hhabIWGoUTTc
 Hdp3br8n98KhN4gwa1YwWM0ZJzNQh4KaIfa9shMlzVILpXg4sRsfGWP3NTOCys1VwJVXSqtIU9
 mj9q897sHNNMYkAJB9UtoaZ7Yhu1t6w6GgvOfnRzFvvgPiYJxJnUnLuf6iprz+4je4nR0vocqp
 fQFx1tVO8UAAAA=
X-Change-ID: 20261014-nvme-isolcpu-9f061e6a96ff
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.16.0
X-Spamd-Result: default: False [-13.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,msgid.link:url,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.30
X-Spam-Level: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_062520_343686_284ABAC1 
X-CRM114-Status: GOOD (  12.56  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Connecting an NVMe over Fabrics controller fails or crashes the kernel
in several cases in current upstream. These tests reproduce each case
and verify the fix.

Queue mapping bugs, fixed in mainline:

  nvme/076  More write and poll queues than online CPUs requested. A
            queue type got more hardware contexts than online CPUs, a
            hardware context without CPU failed its Connect command with
            -EXDEV. Fixed by 99fd0cbae849 ("nvme-fabrics: limit each
            queue type to the number of online CPUs").
  nvme/077  No queues left for polling. The poll map kept the default
            mapping, the queue claimed poll support and polled I/O went
            to a queue which isn't a poll queue. Fixed by 36ede1aa85d5
            ("nvme-fabrics: clear the poll map if no poll queues are
            mapped").
  nvme/078  Reconnect with fewer I/O queues. Stale io_queues entries
            mapped the poll queues beyond the hardware contexts and
            blk_mq_map_swqueue crashed. Fixed by 9588769af5fc
            ("nvme-fabrics: reset io_queues before computing the queue
            mapping") and 36ede1aa85d5.

Hardware contexts without online CPU, fixed by the blk-mq patch "blk-mq:
allow passthrough requests on hctxs without online CPUs" (posted as v3,
the tests reference it as XXX). blk_mq_alloc_request_hctx fails with
-EXDEV if a hardware context has no online CPU in its mask, so the
Connect command for its I/O queue fails:

  nvme/079  Connect with an isolated CPU (cpuset isolated partition).
            Isolated CPUs are not part of hctx->cpumask since kernel
            commit a46c27026da1.
  nvme/080  Connect with offline CPUs. Offline CPUs are mapped to the
            hardware contexts since kernel commit 20e4d8139319.

Both check that the I/O of the isolated or onlined CPU goes through the
queue the connect failed on. Patch 4 adds the helpers to tests/nvme/rc
which trace the queue the commands are sent on.

nvme/076-078 need write and poll queues and only run for tcp and rdma.
nvme/080 needs CPU hotplug. Without the kernel fixes all five fail and
nvme/078 crashes the kernel, with the fixes they pass. Tested with loop
and tcp. nvme/076, nvme/079 and nvme/080 also pass against nvmet on
another machine with the nvme-target-control series, nvme/077 and
nvme/078 skip there because they change the local nvmet configfs.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
Changes in v2:
- Rebase on master and renumber the tests to nvme/076-080, the tests for
  the merged fixes first.
- Drop the common/nvme patch, master has the same fix (64cce9a).
- Reference the merged kernel commits in nvme/076-078.
- Add nvme/080 for connects with offline CPUs.
- Move the queue tracing of nvme/079 into tests/nvme/rc, nvme/080 uses
  it too.
- Fail instead of passing when the controller isn't ready after connect.
- Link to v1: https://patch.msgid.link/20261014-nvme-isolcpu-v1-0-2fd175a8ef00@kernel.org

---
Daniel Wagner (6):
      nvme/076: test I/O queue limits per queue type
      nvme/077: test poll support without poll queues
      nvme/078: test reconnect with fewer I/O queues
      nvme/rc: add helpers to count the commands on a queue
      nvme/079: test connect with an isolated CPU
      nvme/080: test connect with offline CPUs

 tests/nvme/076     | 106 ++++++++++++++++++++++++++++++++
 tests/nvme/076.out |   2 +
 tests/nvme/077     |  87 ++++++++++++++++++++++++++
 tests/nvme/077.out |   2 +
 tests/nvme/078     | 119 ++++++++++++++++++++++++++++++++++++
 tests/nvme/078.out |   2 +
 tests/nvme/079     | 176 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/079.out |   2 +
 tests/nvme/080     | 142 ++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/080.out |   2 +
 tests/nvme/rc      |  33 ++++++++++
 11 files changed, 673 insertions(+)
---
base-commit: a65cf6bdca19cf98e80ba379bffbf3a67f86fba3
change-id: 20261014-nvme-isolcpu-9f061e6a96ff

Best regards,
--  
Daniel Wagner <dwagner@suse.de>


