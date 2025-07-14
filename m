Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97DA4C83F1B
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jul 2025 09:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=YfV+3zDB9plK22Msda2B8kLko2FPZ6mNPQQuyB5SQgQ=; b=srLEFtfjMQFKem
	4k6YVLlHtfeB2URnQe/eIxhHzFXLmJiHeOUIOgPKTUPVwbhjQ7AR209QCxwM3POH2VSZdI3e7Gjff
	kiYBsJdcTtOwPPZ2lhtP6c9DwXnv4kD1mKRD15ay0AjnwCefnO/Xx1z7lF5ENF7oMsloBDv3x2M1H
	8AaVrabPpQs3ynXJW3G3z15ano04RI6ji/ZjuZ3oECTfFHr6YyRM4OTTtY9KopVDlUVxicdjoyM4+
	hXAOunBckV5ZZ8Iz2LGX42gVZgKd0p8OS1KMGJXtDXwADQd01K4iZhT1rPHUZoJpBFd20GTQ+F9c4
	Cmqqiz9mHWMrhuJiFHoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubFIg-00000001kdl-1rHD;
	Mon, 14 Jul 2025 09:16:42 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubFIW-00000001kXm-3oe5
	for linux-nvme@lists.infradead.org;
	Mon, 14 Jul 2025 09:16:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id CD7FEA56F14;
	Mon, 14 Jul 2025 09:16:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7937FC4CEED;
	Mon, 14 Jul 2025 09:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752484591;
	bh=zS6VbmY2/RybXP3UyojwlEvFgfhlfkfBDejeGq0mTIA=;
	h=From:Subject:Date:To:Cc:From;
	b=U/W6yw670zv/maxPAmhCMeENM/R90R/JKe+I62uFxCVg/v4Iw/WPE+QYDtOxE9yD1
	 y+1sDI2ZAtFBd7ME0SGRh3WWUS2nyb0X/BgGgneJxKv0kpASNpG+02bjzMxdaOrQvQ
	 MtawLm0otRhFwSnQDzySrpu4gE9SrGQnE82JoagprlIMZvSVLom/urekmJ1xJU1qW7
	 r0yc7cTLZQ79RfW8SS06jjG8HrDU6o0I4JsJu3Vu9NPjQPAZU2a9pFdU7xcWv0joWa
	 jNa2bOUa8P0IJlOzSJfexabPXXtj7cNdOfphUGI8Mxg2omkuG0OGkgChMN9aAhjrx1
	 rV9C+tSLXnQyg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69087C83F1B;
	Mon, 14 Jul 2025 09:16:31 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Subject: [PATCH RFC 0/8] nvme: Add Controller Data Queue to the nvme driver
Date: Mon, 14 Jul 2025 11:15:31 +0200
Message-Id: <20250714-jag-cdq-v1-0-01e027d256d5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALPKdGgC/2WMwQ7CIBAFf6XZsxgg7ZZ6MjHxA7yaHhpYKdpQB
 UM0Df8u4epx3pvMBpGCowiHZoNAyUW3+gJi14CeJ2+JOVMYJJcdR9my+2SZNi+GgyDTEyotNBT
 7GejmPrV0hcv5BGMZZxffa/jWehL1+gslwThDo1Tbox4EdscHBU/Lfg0WxpzzD1mBltGkAAAA
X-Change-ID: 20250624-jag-cdq-691ed7e68c1c
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Klaus Jensen <k.jensen@samsung.com>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4389;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=zS6VbmY2/RybXP3UyojwlEvFgfhlfkfBDejeGq0mTIA=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGh0ytGtPG+l1LweQR7iTuNvP6BUlhF5HuG67
 oagAOMaESxiOokBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJodMrRAAoJELqXzVK3
 lkFP7tEL/A4VNMYVwcrjZqZXpKzV4h+MR1GMtPQSHmdn35iSQWudMJt6TGW0+6KcFv8hzYcgsam
 NjlkJYiCSPVkopzY5xQFFLo0wkNLCAqxq4xTRtlH4z9+zO7pyOZkVVOBmFG2Qhbq7OuvTQWWlPP
 vrchIRtSV45qnJzT1+TEPlKQNFT5T/woc159rD4bQ0Un746Jmm386d7fRcwGRrSdXDrkdUFkQU1
 ZvdG3vfvaVscnUkuTnbvaf6SHTUgVjH8DIg3St53nU//P1e9e79t2FyWeR9oW8KovdQT105TwgX
 LzPd7WZJEarIVyjh6D8jrJTSBc73oKCDHnybYXeE9NGA/6lMszDjzjMGDIyUpEk6A3bp2crE2/d
 JSa4KX35awaX+3xunSDU/LFAyK8K99ziuzhxaHnWshKAPqMzBXm0AVYXbK9BRd9sghDtLJY37QG
 KFAHkZEC6aMYYSoJIGTYSU4nUlJ6P5XxFA/D9EsA8KV8d0g7K5/tIg0PFlTYBMsIc0kH1GEyMr7
 AM=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250714_021633_118520_4D7DF82F 
X-CRM114-Status: GOOD (  19.12  )
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

This series introduces support for Controller Data Queues (CDQs) in the
NVMe driver. CDQs allow an NVME controller to post information to the
host through a single completion queue. This series adds data structures,
helpers, and the user interface required to create, read, and delete CDQs.

Motivation
==========
The main motivation is to enable Controller Data Queues as described in
the 2.2 revision of the NVME base specification. This series places the
kernel as an intermediary between the NVME controller producing CDQ
entries and the user space process consuming them. It is general enough
to encompass different use cases that require controller initiated
communication delivered outside the regular I/O traffic streams (like
LBA tracking for example).

What is done
============
* Added nvme_admin_cdq opcode and NVME_FEAT_CDQ feature flag
* Defined a new struct nvme_cdq command for create/delete operations
* Added a cdq_nvme_queue struct that holds the CDQ state
* Added an xarray for each nvme_ctrl that holds a reference to all
  controller CDQs.
* Added a new ioctl (NVME_IOCTL_ADMIN_CDQ) and argument struct
  (nvme_cdq_cmd) for CDQ creation
* Added helpers for consuming CDQs: nvme_cdq_{next,send_feature,traverse}
* Added helpers for CDQ admin: nvme_cdq_{free,alloc,create,delete}

In summary, this series implements creation, consumption, and cleanup of
Controller Data Queues, providing a file-descriptor based interface for
user space to read CDQ entries.

CDQ life cycle
==============
To create a CDQ, user space defines the number of entries, entry size,
location of the phase tag (8.1.6.2 NVME base spec), MOS field (5.1.4
NVME base spec) and if necessary, CQS field (5.1.4.1.1 NVME base spec).
All these are passed through the NVME_IOCTL_ADMIN_CDQ ioctl which
allocates and connects the controller to CDQ memory and returns the CDQ
ID (defined by the controller) and a CDQ file descriptor (CDQ FD).

The CDQ FD is used to consume entries through read system call. For
every "read", all available (new) entries are copied from the
internal Kernel CDQ buffer to the user space buffer.

The CDQ ID, on the other hand, is meant for interactions that are
outside CDQ creation and consumption. In these cases the caller is
expected to send NVME commands down through one of the already available
mechanisms (like the NVME_IOCTL_ADMIN_CMD ioctl).

CDQ data structures and memory are cleaned up when the release file
operation is called on the FD, which usually means the close system call
or the user process gets killed.

Testing
=======
The User Data Migration Queue (5.1.4.1.1 NVME base spec) implemented in
the QEMU NVME device [1] is used for testing purposes. CDQ creation,
consumption and deletion is shown by calling a CDQ example in libvfn [2]
(a low level NVME/PCIe library) from within QEMU. For brevity, I have
*not* included any of the testing commands; but I can provide them if
needed.

Questions
=========

Here are some questions that where on my mind.

1. I have used an ioctl for the CDQ creation. Any better alternatives?
2. The deletion is handled by closing the file descriptor. Should this
   be handled by the ioctl?

Any feedback, questions or comments is greatly appreciated

Best

[1] https://github.com/SamsungDS/qemu/tree/nvme.tp4159
[2] https://github.com/Joelgranados/libvfn/blob/jag/cdq/examples/cdq.c

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
Joel Granados (8):
      nvme: Add CDQ command definitions for contiguous PRPs
      nvme: Add cdq data structure to nvme_ctrl
      nvme: Add file descriptor to read CDQs
      nvme: Add function to create a CDQ
      nvme: Add function to delete CDQ
      nvme: Add a release ops to cdq file ops
      nvme: Add Controller Data Queue (CDQ) ioctl command
      nvme: Connect CDQ ioctl to nvme driver

 drivers/nvme/host/core.c        | 253 ++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/ioctl.c       |  47 +++++++-
 drivers/nvme/host/nvme.h        |  20 ++++
 include/linux/nvme.h            |  30 +++++
 include/uapi/linux/nvme_ioctl.h |  12 ++
 5 files changed, 361 insertions(+), 1 deletion(-)
---
base-commit: 0ff41df1cb268fc69e703a08a57ee14ae967d0ca
change-id: 20250624-jag-cdq-691ed7e68c1c

Best regards,
-- 
Joel Granados <joel.granados@kernel.org>



