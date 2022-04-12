Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D48C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Apr 2022 22:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Mime-Version:Message-Id:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=AMvt99Ex3LWgVMSklCg5XNF3Fu8kmLTfCLQjqVndY6w=; b=nKB7IAD0VcE8jR4uHQXognN2da
	n05oJ59DgdRnxJhHzcFGV99eqWwXWqxc1rADWhvgm1H6by3ZLYhRIU9cWafJdZtkdC+UUoyBcRO3i
	kcVQST9ss64WhAxWTTQN3broDpBZt30iGeIyWQ2/DBe3GgQ/AV1toOAWX/G3RirvwKib1t/VeIZgp
	5fCrXaattcdOx76J+VVoHu9y7ptE2BDMvcYuKyGuXYshf3UDdr7oGkLE2r0L2qWhaWywt60ii5QJo
	wBCnf1jYN8EyNC+AFq2CQcYSEmctw0uPZkn0Gtb0nrjrHX8X9o9Wsrvz+fio/EWxtsA9PPk8BuSQW
	3eZ7kCuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nePEv-00FzDu-Aw; Tue, 12 Apr 2022 22:44:01 +0000
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nePEs-00FzDI-9g
 for linux-nvme@lists.infradead.org; Tue, 12 Apr 2022 22:43:59 +0000
Received: by mail-yb1-xb49.google.com with SMTP id
 t190-20020a25c3c7000000b006410799ab3dso233320ybf.21
 for <linux-nvme@lists.infradead.org>; Tue, 12 Apr 2022 15:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=AMvt99Ex3LWgVMSklCg5XNF3Fu8kmLTfCLQjqVndY6w=;
 b=RazfDvaD5aj8XVU4guL9lnFicByqFFYKMKgI9ETIiiTeEWVsXQiUmC4r9d+KA7NlGz
 SMpX/oUt8RqMU0SPyZhXdqUQDx8LQQUHQ6iD3GKz8/G7FOVI0743NRajKeuQyq4Oxk4W
 eFksHyrtSZwa3mmURayx+lMlxJJVuTmYVWEbV46ZNxN8Mx+pyDt8lkTgCjOVXGBWGHCm
 yHyM2NQPx3xwEvLMhtxV4Jxn4NYyIPvlfVHF1PJ8ypg4N4dqW624dI5Z07Dr/nvsczuy
 CXbA2dXFHKpoD+vUdHIKSREFJjDiBl/oozVwp9T6RVdmqMsulQamDI0WhVn3V2vcxJvy
 OjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=AMvt99Ex3LWgVMSklCg5XNF3Fu8kmLTfCLQjqVndY6w=;
 b=pbthHbXUjRhEfGhW9k52kyJfZqd6BFVk7uLk9Xj0lK7xRj+p1FGLMJXzn/gk8JUGXW
 baaWQy7SlQPn+Sx1IsyuQuq08hVORcUj8NJL4C6vPuo+4E9NIpwa3IKUO4W3f2/GIabH
 K0a1Gf5GZfCbhWSsIex9ROX82GyahITjZuc/vihL4Lw3xa/JuT0rbJ12AhXN+4ARxnjo
 21hUPRh4XYseAluMxWiceuX8n/vuS9h7vQuQ5F4fuL+DxcA2SeDEbySryBH8sQWnAiaR
 Pqr7Jm+IuPTMk12YzYrQNYCBIzBRQdC74x1UyKegWCAE6x0abBwsHUuZAcNGFmLkKEHW
 YHzQ==
X-Gm-Message-State: AOAM530hxhzD/CJRb4TiMgr//aoF7AUx6V8kh7wzpdLrQGebkJcLjfhQ
 BXCwjBUqBex2mA/bbZqFRF2t+VLO32smg9k=
X-Google-Smtp-Source: ABdhPJxCd0bNO7tLDwtDjUMz0mlBl45zHQLJLdIutO0p8cCHIr5/4Sb9YUXg6f/qhNMrRWACrr9iOa0pZYfPhJM=
X-Received: from tansuresh.svl.corp.google.com
 ([2620:15c:2c5:13:8573:aa64:c3e8:ebc])
 (user=tansuresh job=sendgmr) by 2002:a25:d34f:0:b0:641:3dcc:c2de with SMTP id
 e76-20020a25d34f000000b006413dccc2demr11259325ybf.547.1649803435313; Tue, 12
 Apr 2022 15:43:55 -0700 (PDT)
Date: Tue, 12 Apr 2022 15:43:45 -0700
Message-Id: <20220412224348.1038613-1-tansuresh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH v2 0/3] Asynchronous shutdown interface and example
 implementation
From: Tanjore Suresh <tansuresh@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-pci@vger.kernel.org, Tanjore Suresh <tansuresh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220412_154358_378075_FB4DE2D2 
X-CRM114-Status: GOOD (  14.97  )
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

Problem:

Some of our machines are configured with  many NVMe devices and
are validated for strict shutdown time requirements. Each NVMe
device plugged into the system, typicaly takes about 4.5 secs
to shutdown. A system with 16 such NVMe devices will takes
approximately 80 secs to shutdown and go through reboot.

The current shutdown APIs as defined at bus level is defined to be
synchronous. Therefore, more devices are in the system the greater
the time it takes to shutdown. This shutdown time significantly
contributes the machine reboot time.

Solution:

This patch set proposes an asynchronous shutdown interface at bus level,
modifies the core driver, device shutdown routine to exploit the
new interface while maintaining backward compatibility with synchronous
implementation already existing (Patch 1 of 3) and exploits new interface
to enable all PCI-E based devices to use asynchronous interface semantics
if necessary (Patch 2 of 3). The implementation at PCI-E level also works
in a backward compatible way, to allow exiting device implementation
to work with current synchronous semantics. Only show cases an example
implementation for NVMe device to exploit this asynchronous shutdown
interface. (Patch 3 of 3).

Changelog:

v2: - Replaced the shutdown_pre & shutdown_post entry point names with the
      recommended names (async_shutdown_start and asynch_shutdown_end).

    - Comment about ordering requirements between bridge shutdown versus
      leaf/endpoint shutdown was agreed to be different when calling
      async_shutdown_start and async_shutdown_end. Now this implements the
      same order of calling both start and end entry points.

Tanjore Suresh (3):
  driver core: Support asynchronous driver shutdown
  PCI: Support asynchronous shutdown
  nvme: Add async shutdown support

 drivers/base/core.c        | 38 +++++++++++++++++-
 drivers/nvme/host/core.c   | 28 +++++++++----
 drivers/nvme/host/nvme.h   |  8 ++++
 drivers/nvme/host/pci.c    | 80 ++++++++++++++++++++++++--------------
 drivers/pci/pci-driver.c   | 20 ++++++++--
 include/linux/device/bus.h | 12 ++++++
 include/linux/pci.h        |  4 ++
 7 files changed, 149 insertions(+), 41 deletions(-)

-- 
2.36.0.rc0.470.gd361397f0d-goog


