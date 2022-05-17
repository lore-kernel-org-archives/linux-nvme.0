Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 475B7C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 17 May 2022 22:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Mime-Version:Message-Id:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=X9rd48IcOQMlJI4fL1LiOmaxrjRg+Q4uXQPcsoEgV+k=; b=wQlZfHCpmGMJUJPmTi9ekCo26a
	xTx0JKRdb4hrMR7IBaQY4HMx7zc7ktEUHukHg/e+L5DUG9k8cvdUBjbeMVqk/NQ3auh9+FU9DyHGJ
	OV+VCh6WhnCLlFgo5ubdIDbXPAIy3Xc4GpxBVOq9x2TKqawUgRIqAalA0awaWx3yBjIJaU9kaxb0t
	hIHWioI6gqtkLD/Vjq7X6hrzGhiMAKehjZYQuIRJusBEoKf3Bt5r5yzpVxqlv8KGGnFnXJ5+o/qzI
	nzoyR/88NwDXTRptxYMFzlH69GILS124GWgXUGTyTpiMWzP+EsP1HuSdF7n7tN00fO32DdGX6HW0k
	MNSYeOmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nr5Mh-00G2Oa-KY; Tue, 17 May 2022 22:08:27 +0000
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nr5Me-00G2Kn-Cm
 for linux-nvme@lists.infradead.org; Tue, 17 May 2022 22:08:25 +0000
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-2ff3eeb2dfbso4341397b3.4
 for <linux-nvme@lists.infradead.org>; Tue, 17 May 2022 15:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=X9rd48IcOQMlJI4fL1LiOmaxrjRg+Q4uXQPcsoEgV+k=;
 b=FlPd4Ema1RTlqOmUDneIdv1KEKzfvy5j81NCIQeDPZybHktJlCFTbLL4ZkCjfGPLVC
 nMHR9eGulo22rP5seemivgemqbsWdMosN/8jIZz+5WRGX7iR97kNyjmLjJacDnOJnsdn
 L+Rhi1RJ/5Vk2i2KnaG7WO10vJsTNBLaN4eITTnEPWFkpEzMB8yYbbm8Q3GEMOzVP5MQ
 3HSQqqhUCeOpRHu4aKeQ6HDtK32bZIUNT2zL/+Kj+9UEztN8TtaM/gqYK841nJ9TcN5g
 GMI5o9E8QNXP+KkedPoVP3OeQsAjzD9IDLkczE0Iu+oj9bEqvQO47sCQW8NfvLUrFFVE
 NZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=X9rd48IcOQMlJI4fL1LiOmaxrjRg+Q4uXQPcsoEgV+k=;
 b=kx4RcykOpbw/MdKZDox9Xyjp5wHTlgONOSyGC1oPFlrSuQyj6nfkhH3Bjoymmqnfqs
 P2RQguT2yH6zjWuaqlD7pCQsY3jur1IRzy7l5oRIiYN558zIXBViQVTR9IPR7Dn/SOMS
 bjDld/jzu9GB8ufHqho+vi/zGLWlIho5uYA0bqT8lSXNW7qHcVyHltzG+a7GUenA+n5Z
 b8lvLEDavhecEXvGfUg6oPj+VNzM4MWrcTW+K+DaaSMfhL8cnqqwgHN3HrTSRvQVlUyX
 ruSGFxvHqkiDa8KvLaD5E9QBfUTrPp9pT8H58+KxqGdIhJX3eIau2l1xg4LSEp7fuLES
 jQ1w==
X-Gm-Message-State: AOAM533+LPH4cysvaYB6cX/XnFr+Y/0Ccz4+srta+h2lO0j/K+Ub8Ph8
 TkWgjEppQ5jNI7gATlcxk21et/oVncvVQMk=
X-Google-Smtp-Source: ABdhPJyAvSIgyxv8X2AWvhlPaUJR0PhTeRsTDBvxqVMgCBrF0GHmO5hdx8s6AygIcKEcbgRoxQnJXpmt/P1nufI=
X-Received: from tansuresh.svl.corp.google.com
 ([2620:15c:2c5:13:3c9b:5345:708:1378])
 (user=tansuresh job=sendgmr) by 2002:a05:6902:84:b0:63d:4a3d:eb5 with SMTP id
 h4-20020a056902008400b0063d4a3d0eb5mr24596845ybs.145.1652825302496; Tue, 17
 May 2022 15:08:22 -0700 (PDT)
Date: Tue, 17 May 2022 15:08:13 -0700
Message-Id: <20220517220816.1635044-1-tansuresh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v3 0/3] Asynchronous shutdown interface and example
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
X-CRM114-CacheID: sfid-20220517_150824_477384_C1400B13 
X-CRM114-Status: GOOD (  18.81  )
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

v3: - This notes clarifies why power management framework was not
      considered for implementing this shutdown optimization.
      There is no code change done. This change notes clarfies
      the reasoning only.

      This patch is only for shutdown of the system. The shutdown
      entry points are traditionally have different requirement
      where all devices are brought to a quiescent state and then
      system power may be removed (power down request scenarios)
      and also the same entry point is used to shutdown all devices
      and re-initialized and restarted (soft shutdown/reboot
      scenarios).

      Whereas, the device power management (dpm)  allows the device
      to bring down any device configured in the system that may be
      idle to various low power states that the device may support
      in a selective manner and based on transitions that device
      implementation allows. The power state transitions initiated
      by the system can be achieved using 'dpm' interfaces already
      specified.

      Therefore the request to use the 'dpm' interface to achieve
      this shutdown optimization is not the right approach as the
      suggested interface is meant to solve an orthogonal requirement
      and have historically been kept separate from the shutdown entry
      points defined and its associated semantics.

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
2.36.0.550.gb090851708-goog


