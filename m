Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 056C1C7EE2A
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Jun 2025 20:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=onNVXuSbIFlcy7frbu83Prt+nhvqq3eE8ga25tI8NzM=; b=2Vhe/RwjDNpMvVAy2U/bY4zUaU
	hWIrwc4kyxnUMPINPfiW7Iq9qYvsUGyJ4XbvLvMA0Gnj18r8zSr881MN+/50pdyHQxlWL7/UXAste
	1kUewucRT8QWONmmJeP9ByznkQTj0SB62r9T+J4saBv3L5uWn+Lu52wdKfQ3d1/QHT11ML9P00rk6
	51Mn5kZHk20PetVw3AV3eSNnf9r5mJONqd7II53LH7EmxBkT0WeWbpHYCssSpUV5d88YVXFQuanAf
	VVrgsQMOMX7OsEJTBn1VqmHwYvWgbeI9DXtBt/jIPQPx1gqHMsUxcME3yEOiUwbZyQ1YfZS9xmfY6
	cgsXqYCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUWrq-00000009tDQ-1q87;
	Wed, 25 Jun 2025 20:37:14 +0000
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUWaL-00000009p6l-3EFQ
	for linux-nvme@lists.infradead.org;
	Wed, 25 Jun 2025 20:19:15 +0000
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-40a4bf1eb0dso175067b6e.3
        for <linux-nvme@lists.infradead.org>; Wed, 25 Jun 2025 13:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750882748; x=1751487548; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=onNVXuSbIFlcy7frbu83Prt+nhvqq3eE8ga25tI8NzM=;
        b=hP4TPfUJvDOdd5G0pPbb3RImt8BJtpV1SrXu4dEKD/X04epiq0cM20YuwV43VwlYWk
         7ihviFJCNVbLk3fm+YJEPS5rscN823meKCeLfZzf4bTIbpkzSHdt5YtLzzMaR4MjcCY9
         WKEbfAiQn3FycYkrXOGD6XmvU8fGrGwSYxoGI7STlzguuA1y44+XOJ51ZtZi6UoMFJMX
         uAzQ51++uS6LTyJ/LXj2bZArygm8YGy1ag55KcYUGaREL0sIagFa/AURdw7yE/aIXB3q
         WAxjzKH72+Vsxxg5z/Jt1WXSTIvLEblnU8Bc2ICHU2LufEJlRKznMsz731Y0IIp0DfTj
         apcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750882748; x=1751487548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=onNVXuSbIFlcy7frbu83Prt+nhvqq3eE8ga25tI8NzM=;
        b=V6gfzRTQlcETRKLiL52+Dg4oTGsuYefFE0YY7pKkwoFBxbwwIbWlmegqBdu1y829Nr
         XknptpsV3Y00xX0urRgk4X0ORtS9BLlTdl6YVGsBNrfRTYlxH8zM9XIJmShnrDqFFUsP
         lndciX4albdV6bQRO4alhz5CL6fm8CmgZ/35w9Rs0/0IhzBCsyTgoQjFGHCIB5uEE4xq
         e3NaAZ5kwLW1p3M9DBJlT11M9oVY6JpxVfWfWrsQ59WiWiFOvjCPbho0WocMcFgZLhWS
         DH9o462W7MzXamRXKOhAOZRTXTUCIJ+3ddCVAiqak+rc3T/yTuk35SCmHFGyN6/DcnF0
         n/gw==
X-Forwarded-Encrypted: i=1; AJvYcCVuncK1K4BdQ5ppXbdvHOFNNvAgGsaUOqeZU6Z0nwT47ky87lrH49sm2SoekfxzsciFK/S5USOZaMw1@lists.infradead.org
X-Gm-Message-State: AOJu0Ywr5G66A7BzNMLNj1/+s5hgBoqwtBkke277gErcE4tTGmcCmhTu
	Vr1fHEqw1buPUvpZ3mdIxhk8lZ5+gHxi9x85yOx9Urp+3fVvE5k5z8x7
X-Gm-Gg: ASbGncv9RbGsX+tZyYl2K13Mpt6zg88Q4LXa9uY+r7VSVfQh0oG1xt3c8+C7pvVhbCR
	Q57Cj9neiak4y/p2jQaEqJeK0D9fcyznpA7zN5mYxz8dulH5jyTD1yC9NMHeGdt2viukGK29gb8
	FSb+TAKZozZUl1VKHoe4VYc3sFnnaCks62MzV7EiCgUzcqe1xSmOjA2Laxut2Uk0c79jlVwj7xp
	rpW2DBZTfOTd0dxvNvA+xlqIlMI/FqkP7qvt49hiSKUBgX2x40TmHALgPz+k/eQ7Ly0q2WQknjf
	w+q7oNo9935eOGCxlWny2WxggpEjwbRA4mSQwg1Q3gV78fb4lhvgtCRFn8O6aDVzau3ZlAJW7ME
	WoXSEyH0=
X-Google-Smtp-Source: AGHT+IHueD54JkX9PPRAjzVEJoW4n3jQNUrmLBzManXDVShulUALPX/DPQ0I9lujqWAtLJnL22cVmQ==
X-Received: by 2002:a05:6808:1894:b0:407:a501:19cd with SMTP id 5614622812f47-40b05c427b9mr3936207b6e.29.1750882748007;
        Wed, 25 Jun 2025 13:19:08 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40ac6d22c23sm2319188b6e.42.2025.06.25.13.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 13:19:07 -0700 (PDT)
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
	linux-nvme@lists.infradead.org,
	Nathan Chancellor <nathan@kernel.org>,
	Jan Kiszka <jan.kiszka@seimens.com>,
	Bert Karwatzki <spasswolf@web.de>
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH v10 0/5] shut down devices asynchronously
Date: Wed, 25 Jun 2025 15:18:48 -0500
Message-Id: <20250625201853.84062-1-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250625_131909_814573_1D3D238A 
X-CRM114-Status: GOOD (  18.49  )
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

Changes from V9:

Address resource and timing issues when spawning a unique async thread
for every device during shutdown:
  * Make the asynchronous threads able to shut down multiple devices,
    instead of spawning a unique thread for every device.
  * Modify core kernel async code with a custom wake function so it
    doesn't wake up threads waiting to synchronize every time the cookie
    changes

Changes from V8:

Deal with shutdown hangs resulting when a parent/supplier device is
  later in the devices_kset list than its children/consumers:
  * Ignore sync_state_only devlinks for shutdown dependencies
  * Ignore shutdown_after for devices that don't want async shutdown
  * Add a sanity check to revert to sync shutdown for any device that
    would otherwise wait for a child/consumer shutdown that hasn't
    already been scheduled

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

David Jeffery (1):
  kernel/async: streamline cookie synchronization

Stuart Hayes (4):
  driver core: don't always lock parent in shutdown
  driver core: separate function to shutdown one device
  driver core: shut down devices asynchronously
  nvme-pci: Make driver prefer asynchronous shutdown

 drivers/base/base.h           |   8 ++
 drivers/base/core.c           | 210 +++++++++++++++++++++++++++++-----
 drivers/nvme/host/pci.c       |   1 +
 include/linux/device/driver.h |   2 +
 kernel/async.c                |  42 ++++++-
 5 files changed, 236 insertions(+), 27 deletions(-)

-- 
2.39.3


