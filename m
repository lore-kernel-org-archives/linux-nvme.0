Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E594606A323
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2026 06:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=i7kFW40h;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=M1/ba/4A
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=Gf4lFFzI99gSSxv4dAz/Qu4nvOX3F/pyFomwsFkIuGc=; b=i7kFW40hJvjCK25d8IpL4dHvUo
	829AHOE4b5tteeIjlEOi3KnwUeNtd2tUClXCv51iw4UnsCC0DcJlNNedQqyjcUYsQcjltNz1jPyXs
	7ozNzuaeVlcR7IOmoAkrMe2pzBMCXxVVGJ4ZzDYiAChaPLm4Qbx+pi3GgCCOI2DeRie1zb4ChOcJs
	1xPwo7PxTtCjHzF741ZKsf+b2eKH80UPvWbdUp+CV1FfuW3TL40gs21Q72wE661Lwzq3Xoox8ugHc
	fFtxwZJkYdvMkVER+4M43a0XsS8ckBRlG9/Ppzfla+G0m59YylgY9Lbhs1bMzsnFqjLdNNcj2JG+n
	X1felSOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW6Hw-00000008Y3T-0Ptt;
	Wed, 25 Nov 2026 06:15:28 +0000
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW6Ht-00000008Y1n-1Y1D
	for linux-nvme@lists.infradead.org;
	Wed, 25 Nov 2026 06:15:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795587323; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Gf4lFFzI99gSSxv4dAz/Qu4nvOX3F/pyFomwsFkIuGc=;
	b=M1/ba/4AmvvCvdSjkH/KuN1Szef1tujmmBIzznGDmBN/Iv+Hawb7IDl3kM05SbKmyXDR3i60Hdbz89sADOi0h7XmAy4064GGzz6OAhFDJnSHB/nkhoxbG4jbEttVr87uIoQg57WNmqvn1zAnYJolvIIFeiiIzdPf3MeSbifFKJg=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XFQgjiY_1795587322;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XFQgjiY_1795587322 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Nov 2026 14:15:22 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v5 0/3] nvme: make SMART / Health Status AENs reach hwmon alarms
Date: Wed, 25 Nov 2026 14:15:19 +0800
Message-ID: <20261125061522.231591-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_221525_725716_C137DF27 
X-CRM114-Status: GOOD (  19.60  )
X-Spam-Score: -17.6 (-----------------)
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
X-Spam-Status: No, score=-21.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The NVMe hwmon support exposes the temperature alarm as a plain sysfs
attribute, so monitoring tools have to poll temp1_alarm to learn about
a critical temperature condition. The device does send a SMART / Health
Status asynchronous event when a critical warning is raised, but the
host never enables it in the Asynchronous Event Configuration, and the
completion path silently drops the event.

The temperature warning is subscribed unconditionally when hwmon is
present (it has no OAES capability bit), a work item embedded in
nvme_ctrl re-reads the SMART log to clear the latched event -- the
same shape as the namespace scan reading the changed namespace list --
and the alarm is announced with hwmon_notify_event(), which also feeds
the registered thermal zone.

Testing: verified end to end against QEMU's nvme emulation: injecting
smart_critical_warning over QMP delivers the AEN, poll(2) on
temp1_alarm wakes immediately with EPOLLERR|EPOLLPRI and reads alarm=1;
clearing the warning produces no event and no spurious wake;
re-injecting the bit wakes again; enabling the spare-block warning
through an admin passthrough delivers the AEN without waking the
temperature alarm; a controller modeled to reject the critical warning
subscription with Invalid Field in Command falls back to the
notice-only mask, which a Get Features of the Asynchronous Event
Configuration confirms; a temperature event whose warning recovers
before the deferred log is read still wakes the poll with alarm=0;
detaching the namespace through a Namespace Attachment passthrough
exercises the renamed events bit and rescans.

Changes since v4:

 - use the normal kernel comment style for the events enum
   (Christoph Hellwig)
 - split the command set addition in include/linux/nvme.h from the
   changes to the host implementation; the latter went into the hwmon
   patch (Christoph Hellwig)

Collect the Reviewed-by tags from Nilay Shroff and Christoph Hellwig,
thanks.

Link: https://lore.kernel.org/all/20261124120032.1824788-1-kanie@linux.alibaba.com/

Changes since v3:

 - split the preparation into its own patches: an event bit enum for
   nvme_ctrl::events, whose only bit was indexed with an AER subtype
   value so far, and the SMART / Health Status asynchronous event
   subtype values
 - notify temp1_alarm when the event information indicates the
   temperature threshold, not only when the re-read log still has the
   temperature critical warning set, so that a transient excursion
   that recovered before the log is read is still reported (Nilay
   Shroff)

Link: https://lore.kernel.org/all/20261123112342.2761131-1-kanie@linux.alibaba.com/

Changes since v2:

 - exclude transports that do not implement asynchronous event
   requests from the subscription: apple-nvme reports no OAES support
   but registers hwmon, which would have queued the async event work
   and dereferenced a NULL submit_async_event callback (sashiko)
 - embed the SMART work in nvme_ctrl and only queue it while the
   controller is live, so that a work item left over from before a
   reset does not issue a blocking admin command against a quiesced
   queue, and the work memory is tied to the controller lifetime
   (sashiko)
 - only notify temp1_alarm when the re-read SMART log has the
   temperature critical warning set, so non-temperature events
   enabled through passthrough do not produce false alarms (sashiko)
 - fall back to the notice-only Asynchronous Event Configuration
   when the controller rejects the critical warning subscription
   with Invalid Field in Command -- the SHCW bits have no capability
   field to probe, so the subscription itself is the only probe --
   and return early when the reduced mask is empty, so the notice
   events are not lost with the subscription (sashiko)
 - drain the SMART work before freeing its data during controller
   teardown, so that a late asynchronous event completion cannot
   dereference freed memory (sashiko)

Link: https://lore.kernel.org/all/20261110110737.3965373-1-kanie@linux.alibaba.com/

Changes since v1:

 - drop the uapi patch defining an OAES bit for the SMART event: OAES
   bits 7:0 are reserved; the warning is configured through the
   SMART / Health Critical Warnings field of the Asynchronous Event
   Configuration feature (sashiko)
 - subscribe to the temperature warning unconditionally when hwmon is
   present, instead of masking against ctrl->oaes (sashiko)
 - re-read the SMART log in the deferred work to clear the latched
   event, like the namespace scan does for the changed namespace
   list (sashiko)
 - call hwmon_notify_event() instead of sysfs_notify(), so the thermal
   zone registered with HWMON_C_REGISTER_TZ is fed as well (sashiko)
 - correct the cover letter: temp1_alarm reflects the temperature
   warning only, not the spare-block condition

Link: https://lore.kernel.org/all/20261109120207.1352165-1-kanie@linux.alibaba.com/

Guixin Liu (3):
  nvme: define an event bit enum for nvme_ctrl::events
  nvme: define the SMART / Health Status async event subtypes
  nvme-hwmon: notify hwmon alarms on the SMART / Health Status AEN

 drivers/nvme/host/core.c  | 32 ++++++++++++++++++++++++++++----
 drivers/nvme/host/hwmon.c | 37 +++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h  | 23 +++++++++++++++++++++++
 include/linux/nvme.h      |  6 ++++++
 4 files changed, 94 insertions(+), 4 deletions(-)

-- 
2.43.7

