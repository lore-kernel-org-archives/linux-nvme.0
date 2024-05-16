Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B95C25B77
	for <linux-nvme@archiver.kernel.org>; Thu, 16 May 2024 15:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZODEtoePHUvziuRfhdaaoUIRaMRicIhK6wIEY1B51+Q=; b=UDdsRbtYBPBBFw61E7JT1v2USd
	63AsWnsxWQfOm+JFjY1C1mOfCVsHvAZXPIosPZiifcXW5oC0Rset0j1B2QYSGarO7cCmbOyB/ZEfV
	frSKqkme3skwuuX0XXYAn9GM4pW96XyuXrVmiBgkh/2k8BGWtiB+aycD8tYD5pE6az621XNBqfwQH
	/WJwbgPjZpKh4bvQX8QCcH2EEeAHuvsL91rvhwl+J7QgC12pqSL98YCgQEHM8jUEPFoRlh30ztDFI
	JTij28LJwR35F6DzS+8OyQ+feBf8IhCbg/2WR/tD+pInvocVE2NOBGXkl79YU1MWT8uzUZipYeSjw
	8tzGTRzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7dMV-00000005NKH-0PGR;
	Thu, 16 May 2024 15:49:43 +0000
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7dMP-00000005NIP-2oKx
	for linux-nvme@lists.infradead.org;
	Thu, 16 May 2024 15:49:39 +0000
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3c9937b7292so211540b6e.3
        for <linux-nvme@lists.infradead.org>; Thu, 16 May 2024 08:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715874574; x=1716479374; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZODEtoePHUvziuRfhdaaoUIRaMRicIhK6wIEY1B51+Q=;
        b=XjSClbncBiojNujs5by6qcNEOKWl6ia2Ia0xkuW1YIVHtQb5X0/x84WwT/eRqp6Lgu
         yQFQNn777J7tWH5+POr/MxtGh3/6Rgu9T2PGgLJB5jRec2C0njDRFWXWqIoiTcFWDfOI
         kVQehtUqhoinkMjuhxu9jS6jrJd1ggl7vLknpE2wkd6frXU8KSoUOujrCS4OQS4MEsZz
         yyU1oL34TwN5YKjpOgrAzP3PLHU16DbO7ryDEVyWcFeQ2h1rph/RfccRygZDbQkhyRBi
         B+SmsEYIeCEM6+5aWPnkYTMKTTZR8b8I//9tTZ96cNF+mbknGGm8ztFGFBqO4UW02n5E
         h+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715874574; x=1716479374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZODEtoePHUvziuRfhdaaoUIRaMRicIhK6wIEY1B51+Q=;
        b=Ire2iHnfTcBKH+e+lq8Pxw1JNhnkI4GXEhcXHb5xlh5HDq7iBUQIX2GthzTHcEQSIH
         YtKg7puadElHgLV0LgVPzF8J1MxM2mTvakxjk3Js6Riej7oaZfHL1cqEfBpuHDrJDkOH
         8SUnas9FTQoQeMAP2bJlzgw5OUr0wwmWG51I+QQRw9vN/owzG1dfzhrcQFsSsbLWg7I0
         oRwVxX6w0/qIf3pinHG+lofKbaB5+rm2qvHhmWZSkf54giMFUpINLl3ZduvOP0HYIHtT
         1TmJVcPR9oqiXr29pScT330Q/5r3FlgmWnA6MRGkGHPQvjTYSJUj00GHR9WSWWPLRZ7i
         Bbiw==
X-Forwarded-Encrypted: i=1; AJvYcCVkIAm2+dTGwpkh5IUoXQp3jE7z/oagWlryh9wZ8jH+G4JLvfz4FSe3gVJZUiiK1TlxIZNInH0kH3V8HUTK1yIt2P7AKM9/v82qmEtJLGs=
X-Gm-Message-State: AOJu0YwUknKPKyk6ipUmdxBpsfJ/kueteSMi83QEcCyK5NTw5u9+7xlX
	0e2ZlvKebMaRxnaZR+1gezXGA8TELTZScF7jI/+gmziyyRAlaXjM
X-Google-Smtp-Source: AGHT+IF6t54ePxZMF2EPjr0HgtmTRNEuOe/2crHF3bicO9KN5F/1a0XF86D7UMPfJp9Y8ddQhiMDRg==
X-Received: by 2002:a05:6870:2f11:b0:22e:d13b:c13d with SMTP id 586e51a60fabf-24172a70ac7mr22479435fac.18.1715874574490;
        Thu, 16 May 2024 08:49:34 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2412a3c82edsm3562563fac.12.2024.05.16.08.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 08:49:33 -0700 (PDT)
From: Stuart Hayes <stuart.w.hayes@gmail.com>
To: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Tanjore Suresh <tansuresh@google.com>,
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
Subject: [PATCH v6 0/4] shut down devices asynchronously
Date: Thu, 16 May 2024 10:49:16 -0500
Message-Id: <20240516154920.221445-1-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240516_084937_731328_D01F3EAE 
X-CRM114-Status: GOOD (  13.95  )
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

This adds the ability for the kernel to shutdown devices asynchronously
(this is V6).

It is in "safe" mode by default (where only devices whose drivers opt-in
are shut down asynchronously), but it can be "on" (where only devices
whose drivers opt-out are shut down synchronously), or "off" (legacy
behavior).

This can dramatically reduce system shutdown/reboot time on systems that
have multiple devices that take many seconds to shut down (like certain
NVMe drives). On one system tested, the shutdown time went from 11 minutes
without this patch to 55 seconds with the patch.

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
 drivers/base/bus.c            |  47 +++++++++
 drivers/base/core.c           | 185 +++++++++++++++++++++++++++++-----
 drivers/nvme/host/pci.c       |   1 +
 include/linux/device/driver.h |   8 ++
 5 files changed, 218 insertions(+), 26 deletions(-)

-- 
2.39.3


