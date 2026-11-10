Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BE1606A326
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2026 11:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=DU9rEkxX;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dnzO6eL7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=jTAuJxcgrOMXygZbQiiLA+hz6DjBJxMI1k/WE4B9IiM=; b=DU9rEkxXHvdQ6osWTUEApEfjKC
	hY/KQKyLxjJkBOmf7Dmi6COzJfhLdFsV2AfXI8llGUJl8f88d7BqQqBVzK77ZpVlmsbC/tuYwj8IH
	iL5kCVTx272lEAzVjuZtk6j7akeBGo+YoBs8RcHaQRGE6ZleXMOZZiXHhIvpQlIrr6Qnp6sA2MQzn
	5No77XLfx5futjv+Dt5e5FzKwm8dwSltyFxCsIJXemg3ddH8tOkpJFey5pSpX7o3WxMlyxq7uuXsF
	1Dmvlu/ITTC4SCjlwY5mNBp7BFDpiNxLrl/32c7dDh4HuKlvTqSG3R7C54Wa+iuANQNLepEH0L3JA
	3ye7gFLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQjhc-00000003aC6-2viX;
	Tue, 10 Nov 2026 11:07:48 +0000
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQjhZ-00000003aAL-2uON
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 11:07:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794308863; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=jTAuJxcgrOMXygZbQiiLA+hz6DjBJxMI1k/WE4B9IiM=;
	b=dnzO6eL7ZFagvR6seMHcoNtL6LOUCAjSzD9VF1nAzuAIKf79PyXaRNgSvqRXB1TkFdEbCFn1lH7Lf3p8a7rFs2X6LrWwFLDYBin0c1WGjC1Xk7N3UR7A+vUkwo1ZmFrh/Q4QkwABOTWNrjlH0ybbGm+8aouetPnTkfxLMe2TFkA=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XEV3tJV_1794308862;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XEV3tJV_1794308862 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 10 Nov 2026 19:07:42 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2 0/1] nvme: make SMART / Health Status AENs reach hwmon alarms
Date: Tue, 10 Nov 2026 19:07:36 +0800
Message-ID: <20261110110737.3965373-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_030746_254468_D9D8B965 
X-CRM114-Status: GOOD (  11.26  )
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
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The NVMe hwmon support exposes the temperature alarm as a plain sysfs
attribute, so monitoring tools have to poll temp1_alarm to learn about
a critical temperature condition. The device does send a SMART / Health
Status asynchronous event when a critical warning is raised, but the
host never enables it in the Asynchronous Event Configuration, and the
completion path silently drops the event.

The temperature warning is subscribed unconditionally when hwmon is
present (it has no OAES capability bit), the deferred work re-reads
the SMART log to clear the latched event before the Asynchronous Event
Request is re-armed, and the alarm is announced with
hwmon_notify_event(), which also feeds the registered thermal zone.

Testing: verified end to end against vanilla QEMU's nvme emulation:
injecting smart_critical_warning over QMP delivers the AEN, poll(2) on
temp1_alarm wakes immediately with EPOLLERR|EPOLLPRI and reads alarm=1;
clearing the warning produces no event and no spurious wake;
re-injecting the bit wakes again.

Changes since v1:

 - drop the uapi patch defining an OAES bit for the SMART event: OAES
   bits 7:0 are reserved; the warning is configured through the
   SMART / Health Critical Warnings field of the Asynchronous Event
   Configuration feature (sashiko)
 - subscribe to the temperature warning unconditionally when hwmon is
   present, instead of masking against ctrl->oaes (sashiko)
 - re-read the SMART log in the deferred work to clear the latched
   event before the Asynchronous Event Request is re-armed, closing an
   AEN completion tight loop (sashiko)
 - call hwmon_notify_event() instead of sysfs_notify(), so the thermal
   zone registered with HWMON_C_REGISTER_TZ is fed as well (sashiko)
 - correct the cover letter: temp1_alarm reflects the temperature
   warning only, not the spare-block condition

Link: https://lore.kernel.org/all/20261109120207.1352165-1-kanie@linux.alibaba.com/

Guixin Liu (1):
  nvme-hwmon: notify hwmon alarms on the SMART / Health Status AEN

 drivers/nvme/host/core.c  | 17 ++++++++++++++++-
 drivers/nvme/host/hwmon.c | 40 +++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h  | 15 +++++++++++++++
 3 files changed, 71 insertions(+), 1 deletion(-)

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>

-- 
2.43.7


