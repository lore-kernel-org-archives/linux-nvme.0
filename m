Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E29C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Mar 2022 23:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Mime-Version:Message-Id:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4i1l9AwTfFdRqUE9mxnbmrk0dHwvz4ZAenZccJvB6o4=; b=F3V5BZYAH11+KGP8qDVnCEa1UP
	Id84CtSa4EEg4MTkiKU0Xeaubq8iQ1xRSDuIc+c14ph/jnmIrFEusnG5f3kW30ivb1/zipR0qYuoI
	dXrvOqtssdVG20jmO8fXv7quijtzEhGIrjhm0DZWfIr/7fuxvFEEtbwIaKdt3sZi43mm1izG0b58Z
	1zy4tcDbTW5/RcKy6uvBMEieCFRCrQEeWmEW9ydUmsWs7JNU1a6fmXWes3mniNy5H9XNcddWETkTS
	/2CsBAPAGlhbzqoE5XaZfa7A9BDxEtc3yRrDHGZJQRYMGADkMG42tIeAlQV57em4VSm0KKrACiYQi
	hniU2Iig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nYyLT-00AO4M-Rd; Mon, 28 Mar 2022 23:00:19 +0000
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nYyLQ-00AO3Y-Ch
 for linux-nvme@lists.infradead.org; Mon, 28 Mar 2022 23:00:17 +0000
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-2e696b18eb4so130269187b3.0
 for <linux-nvme@lists.infradead.org>; Mon, 28 Mar 2022 16:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=4i1l9AwTfFdRqUE9mxnbmrk0dHwvz4ZAenZccJvB6o4=;
 b=qhQZecwTYMf+9F7yNoTpRhQqYlOzBbcyLmOjLGZ+2DfFLnN01ArsyEc9L7i4fW5gIW
 wrxurOmtOwKxa22NDpX1WjFuENaqRudK5KYX4o5DTCZDzvB1ApjdSVEqdraxxjyLCAH8
 F2CdZhA5eh6qpyE2sFKVxh9A2/F1rO1MbiqNhzvrAYNt6IXbe+iWvWzawNcppFFX1gDN
 QEy5IaxY4b4XhR+DUb22pzXMedvHOcdcg1P3m53/ejxgDotSV8vSMW9g5YicsNVmNd5w
 TbMLzukw8r0a8bwmSzuyzT7T3BcIqEbgNIWtEq6FCjEqb0bm8g7kXPzcd73diH9jL9TW
 MjbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=4i1l9AwTfFdRqUE9mxnbmrk0dHwvz4ZAenZccJvB6o4=;
 b=OHS8OFDcWbb1Iok5rVVB3cg5dw/6FxSEYHQ69i04LRLzC/WBI0QVzs5fgvamYOIIxv
 QqHVFlTM59kFTWTCRlS0cV3XF1WerMKlvNJbTqLn0AxBREsIe8hwN/Kcxma/RnqJJGD8
 qLPforpnakTbuiiz2SbxMcDI1cs6M1r9mzV4W1U/cMIEdN4WD6BsXT6LK+RVxV9LoiEB
 o2nu7/eANAxklUaS/1DKt4RcZz1XY/+iWEMlhtCHwdTLwKlQ/w8WIRZs9Fy4lhF4C9ZI
 HbMSFr1Zf1huTNUwNuRB0SpDzJcygBpcnAjDD0mafkiHNB+b5c/XVeyXGbZI4r2gMRfU
 o1gw==
X-Gm-Message-State: AOAM530BgZRWkkHvn0Gw2v4USLVNqLLRnJpt/tqVDOgouvBi2q1mTn+1
 rOcR6cJW4gsX7SrR+OVf4kdolU8kD0Lu27Q=
X-Google-Smtp-Source: ABdhPJwQazt4139wX1tGxlX7XgKb6/VZvyzPRdIhufvuYPe+Sy8H/VS5jPEanUTEUA+sCU5Vw6ybWDF1XyuZkCg=
X-Received: from tansuresh.svl.corp.google.com
 ([2620:15c:2c5:13:3dbb:6bbc:98be:a31e])
 (user=tansuresh job=sendgmr) by 2002:a25:e30c:0:b0:633:6081:d44b with SMTP id
 z12-20020a25e30c000000b006336081d44bmr25995917ybd.523.1648508413391; Mon, 28
 Mar 2022 16:00:13 -0700 (PDT)
Date: Mon, 28 Mar 2022 16:00:05 -0700
Message-Id: <20220328230008.3587975-1-tansuresh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v1 0/3] Asynchronous shutdown interface and example
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
X-CRM114-CacheID: sfid-20220328_160016_481972_16C67A7E 
X-CRM114-Status: GOOD (  14.03  )
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

Tanjore Suresh (3):
  driver core: Support asynchronous driver shutdown
  PCI: Support asynchronous shutdown
  nvme: Add async shutdown support

 drivers/base/core.c        | 39 ++++++++++++++++++-
 drivers/nvme/host/core.c   | 28 +++++++++----
 drivers/nvme/host/nvme.h   |  8 ++++
 drivers/nvme/host/pci.c    | 80 ++++++++++++++++++++++++--------------
 drivers/pci/pci-driver.c   | 17 ++++++--
 include/linux/device/bus.h | 10 +++++
 include/linux/pci.h        |  2 +
 7 files changed, 144 insertions(+), 40 deletions(-)

-- 
2.35.1.1021.g381101b075-goog


