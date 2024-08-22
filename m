Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B114C3DA4A
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Aug 2024 20:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kOL/fNnXaWdoKAkeEncC6MoPhHPgBP4rm3mSsYbtP7M=; b=b9osQN6v0AZG5xUNOv727jW17r
	jHK/Otv53s1PuVNjB2d/jjL8KCnMFkgR+hGqYKqN6ICQGYajY13o91VhsioF5p4F7In+aK8paE1lr
	HzZp6lUj5GyYffBK0n76SRjEk93oOSm+bvzfS6U4qWfwZd0JLM7YSg0k5mIcrL0bA0j0jES9EJHCR
	c+cujcOmlvdLa1GPDh1lsyTcE+mGVBKTk5+DkhQShGPmsp3xcBUBZOOSu/eF2eoTEq9QEndUtgaFd
	0uMa1pYmCejt9nFO3G70Rb/WDcy+Jkyd0OM7ro5+/3mMjI0D7Wwj38DIHTa/Eqyl3qR8mJZHIJ555
	/ohm9L0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shEPq-0000000EDbz-1OBu;
	Thu, 22 Aug 2024 20:28:18 +0000
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shEPn-0000000EDa6-2ZrE
	for linux-nvme@lists.infradead.org;
	Thu, 22 Aug 2024 20:28:16 +0000
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-5d5b986a806so1185198eaf.1
        for <linux-nvme@lists.infradead.org>; Thu, 22 Aug 2024 13:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724358494; x=1724963294; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kOL/fNnXaWdoKAkeEncC6MoPhHPgBP4rm3mSsYbtP7M=;
        b=j5qlKg84eXFiCMN7WE7923ebJXkXT+k1xMmXAUXKCSV+kz/aOX9mM6w0RO4H7pe2vN
         MLnpmQSxpYNM5k2TEtfmQ7Xyfo/d5IkNCifm0fGqrdQ7JOrOAggd7OeVphCHWqatxVKF
         7s6JKLa8AVuoxnlB/f4BnZFbTSxIQiVpc+Fz97ZpMfDNUmHjQkGnowpCRub7NYFiqblL
         RopXhJ3Cb36AG66EI05uu1UCkCJSLwxWj0uQn6SoKJ+HIBJ8nMRXIqKLpvNabnixWDCU
         tZ8qnQSoc4XikEdZvQj32onFGHE/gHtqj/3g8le2CXnZY2Tuuf4osNpVCo1hE5jCBoNC
         aqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724358494; x=1724963294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kOL/fNnXaWdoKAkeEncC6MoPhHPgBP4rm3mSsYbtP7M=;
        b=Bi93+73DJYco9h0/HwSEEYfaUncbNhdLeBRLltBC8n5HdgOFSfsGmTA5CK2k4qXzKj
         KEWRDjAGcnhfjzZRtd2OWUM3IjaIngQ2Fqc3Yhg1/2TqMcXe57l22eWPj8QySkZlGsKA
         xTigBbBnJn8BnB+3kXEQQAWTA5RNtMZc5O3vZUGNDYk9a0LpKla5pPLLx5m9K4KxAo6I
         0badLUOe9puLGYsXqA38uAYv6HLBBPRKRHkhOtonFfTcMkKabvexnCnllaV4EUb4zJTd
         YFlpENOzABk5blBK0nfpdlf38ugWzcS1mbUldNJDALdW+KbgSxNeUiNmaceyH42J6P7a
         O1Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUbD68BFqROQRRQ3v2VyJQQ4MLvfHFDSddudkEjj8lHpL0IPGBA4eQ6RioQJD3HncIbIWuiR8yz6pXt@lists.infradead.org
X-Gm-Message-State: AOJu0YzDTXKuDYwtZZ8UsOWCwooId++PF/ouTYBzOvnfUb7P7TNrsfyG
	klG/dgTrx3fWjufbG8AkkET73EmScUJcHCPBeTaUv3g9gs2vScIo
X-Google-Smtp-Source: AGHT+IG+b8+rh+weNuQzr3aYdIHNhytmbEf+tbNYhQ48GtEiG9O5RHQ6QpprH8GqE1FOdKK6MYyXgw==
X-Received: by 2002:a05:6808:210e:b0:3d6:2bab:16ca with SMTP id 5614622812f47-3de2a2ca587mr84006b6e.13.1724358493701;
        Thu, 22 Aug 2024 13:28:13 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3de2252d5fbsm421265b6e.1.2024.08.22.13.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 13:28:13 -0700 (PDT)
From: Stuart Hayes <stuart.w.hayes@gmail.com>
To: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH v8 0/4] shut down devices asynchronously
Date: Thu, 22 Aug 2024 15:28:01 -0500
Message-Id: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_132815_676254_1010AA46 
X-CRM114-Status: GOOD (  15.98  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This adds the ability for the kernel to shutdown devices asynchronously.

Only devices with drivers that enable it are shut down asynchronously.

This can dramatically reduce system shutdown/reboot time on systems that
have multiple devices that take many seconds to shut down (like certain
NVMe drives). On one system tested, the shutdown time went from 11 minutes
without this patch to 55 seconds with the patch.

Changes from V7:

Do not expose driver async_shutdown_enable in sysfs.
Wrapped a long line.
 
Changes from V6:

Removed a sysfs attribute that allowed the async device shutdown to be
"on" (with driver opt-out), "safe" (driver opt-in), or "off"... what was
previously "safe" is now the only behavior, so drivers now only need to
have the option to enable or disable async shutdown.

Changes from V5:

Separated into multiple patches to make review easier.
Reworked some code to make it more readable
Made devices wait for consumers to shut down, not just children
  (suggested by David Jeffery)

Changes from V4:

Change code to use cookies for synchronization rather than async domains
Allow async shutdown to be disabled via sysfs, and allow driver opt-in or
  opt-out of async shutdown (when not disabled), with ability to control
  driver opt-in/opt-out via sysfs

Changes from V3:

Bug fix (used "parent" not "dev->parent" in device_shutdown)

Changes from V2:

Removed recursive functions to schedule children to be shutdown before
  parents, since existing device_shutdown loop will already do this

Changes from V1:

Rewritten using kernel async code (suggested by Lukas Wunner)


Stuart Hayes (4):
  driver core: don't always lock parent in shutdown
  driver core: separate function to shutdown one device
  driver core: shut down devices asynchronously
  nvme-pci: Make driver prefer asynchronous shutdown

 drivers/base/base.h           |   4 ++
 drivers/base/core.c           | 108 ++++++++++++++++++++++++++--------
 drivers/nvme/host/pci.c       |   1 +
 include/linux/device/driver.h |   2 +
 4 files changed, 90 insertions(+), 25 deletions(-)

-- 
2.39.3


