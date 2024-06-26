Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16BAAC3064D
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 19:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5KlRYq6p5LkP029bKZx9mVcz2J6oFnFhtgLKInBjC3M=; b=troZw36amwSfm9g3OaZ6ZswUSt
	cPFiFND+iszTp3q+V1mgIqTQM/J08tJUZPC+5B9nspZJkfNT64IYdorn/QEDgJ7qOsI1uSt33RDMp
	ivKz27O4nZDBB6rWXU1MJxaY8l+JQ0meVdyNNsziTf8Ygrcq6KgnuFHRHuLUCc9YoWtX7XXb3g/3E
	UDTOihHU9bIoJXUBYi6wc1pXGmF1bBao6UWQafP/mtwZO+XZ4uKgQXwApFXg8ArjaJ9uyQWiW0B/+
	/3aKK4FQWyUTKYBa7B3NhIre+aBZthB77GtGYzNnuOnxBSxEeQ7QCVS9u+FS+jGaGv90ORULxVHwP
	9ridJgBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMYbp-000000086IX-3wK1;
	Wed, 26 Jun 2024 19:47:13 +0000
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMYbm-000000086G1-1yTW
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 19:47:11 +0000
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-79d5495fe01so56856785a.1
        for <linux-nvme@lists.infradead.org>; Wed, 26 Jun 2024 12:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719431228; x=1720036028; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5KlRYq6p5LkP029bKZx9mVcz2J6oFnFhtgLKInBjC3M=;
        b=bsR9KQzib3zlv3/WmTCE6lRZcxZHpoKjcBI3xdUI3XjlRMG0pjZHXiklgK4tcTPz92
         ZS8eK/WXREx2G3joAIgO5kuYqNBiGn3t5XcWLHfdEh/sscW/sRIloUdvtQGZXZLk7RW8
         xeLGiXRdiBS6gPVQvWnUoJuCa6JfRsVJF4jbl9KSsqPU7AsHHL6qzPmdGjz4GGcMff+J
         srlD8qeWLyO9Wi4YpJ3pCUWxNls7duU6ug4FnIjamfkATdohvEVQtniuvgyK1kx9Q5H3
         Wo98usoRRUqe3mEe8Iz4ACm5ZOXCSA0Wpyhh03LE7CsjOmID3d1SqI0ErhCFzCicEpfG
         1JlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719431228; x=1720036028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5KlRYq6p5LkP029bKZx9mVcz2J6oFnFhtgLKInBjC3M=;
        b=lfYf9ymKIG/frDiNIIadL0hH5dSc5r29IVEO9X7qS4IbM8mys7yv9aKqcDPxFva0fs
         rKQqj+tgTjCYWmL30hHAvgILEpAcI2WLrIXg0OwahnHCiWrtUZ/o/D6sd94t+4npDsQh
         /XVEBcSggYqg8aUHpNOVxikX6pqZdSwFM1zCgjwijs6I71SGy2vPWMiKsnOWs7bjAD4y
         zF0e7zNDE1YALMARjeiFmvuGEZj9NUxpX2pV/vdDJej2ftgGFDNhh8Jk9nuOqHipBMGl
         RkMByApudYK5GmvAMS928U6AEIZJ5dks7F82jWnXbpksZe0OemGFqxDhByMNsifFWFND
         XHUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJVTnNR6LzQKlUzvw/PQgT3EdrrGwsIIc2sSlOH8iWSDzvCItvSlQSBTobzdO2HT46ppmz/UoaIb5VQqQsPT2kvD9RqWlYyUM1TnI1Tgg=
X-Gm-Message-State: AOJu0YyzdSSyHMfgjEMAO3pVZjBw82m8rvbrNsW9jO5KUTmGxuhgJq+D
	IiyL/HAo8YH0boWouGbBn38dcaBeuL4ASQ0qxVWNAVIfmZNZ8yLo
X-Google-Smtp-Source: AGHT+IGnBEWNgvDQcr+Fw7YuGmUhVCJXdSp8AWzbPtl59HfE9luhHi13VAdgTrBgWgPn6XmOPUb2Mg==
X-Received: by 2002:a0c:8bc2:0:b0:6b5:40c:f108 with SMTP id 6a1803df08f44-6b5409e0ba3mr125914316d6.37.1719431228257;
        Wed, 26 Jun 2024 12:47:08 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b52ac1028csm48489996d6.99.2024.06.26.12.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 12:47:07 -0700 (PDT)
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
Subject: [PATCH v7 0/4] shut down devices asynchronously
Date: Wed, 26 Jun 2024 14:46:46 -0500
Message-Id: <20240626194650.3837-1-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_124710_659777_54EEF40A 
X-CRM114-Status: GOOD (  15.59  )
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

Only devices with drivers that enable it are shut down asynchronously,
and this driver setting can be changed in sysfs.

This can dramatically reduce system shutdown/reboot time on systems that
have multiple devices that take many seconds to shut down (like certain
NVMe drives). On one system tested, the shutdown time went from 11 minutes
without this patch to 55 seconds with the patch.

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

 drivers/base/base.h           |   3 +
 drivers/base/bus.c            |  26 ++++++++
 drivers/base/core.c           | 108 ++++++++++++++++++++++++++--------
 drivers/nvme/host/pci.c       |   1 +
 include/linux/device/driver.h |   2 +
 5 files changed, 115 insertions(+), 25 deletions(-)

-- 
2.39.3


