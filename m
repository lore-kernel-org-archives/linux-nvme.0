Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F7C9C36014
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Apr 2025 10:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Date:Subject:Cc:To:From:Message-ID:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dlneKC/ndU61i/vPL9mVRRu3chChSKIVHzfvKbs7t8A=; b=fvYb57eOQFCbbhh1ruXJfpHq+1
	qSvAppaUUnsZFQcMB7VD28foqye6fFBtoP1GjAED71tBni4w6xzuylhYAsZpfQi/WkwMPRho0WtvU
	EWHuCcXJlf5oBO3Pz9vifT6Se1jEZ4PHXxJwM9lrH8guIoLn4R53rJe8Kuy3jr9Ln2VWTmwimt6tL
	CK+drn0ssfaUCBhKSeimOtOKXbn4qkdJ6UrtPdrmKDjNZAJ/H7yLxfqttS6maKAsq20QHvsmP5juF
	CN5aVqo/Dnf1lmAPShAX6NKINvTFKwj5JnTgLn2NdLQLu9WpDlGY4xlLUWNLR6YDthDJ4dESOgEb/
	zVEUp/Wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzYTn-00000002YmX-3BRg;
	Tue, 01 Apr 2025 10:04:23 +0000
Received: from out162-62-58-216.mail.qq.com ([162.62.58.216])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzXpA-00000002SqO-3bzm
	for linux-nvme@lists.infradead.org;
	Tue, 01 Apr 2025 09:22:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1743499329; bh=dlneKC/ndU61i/vPL9mVRRu3chChSKIVHzfvKbs7t8A=;
	h=From:To:Cc:Subject:Date;
	b=PJ58PYPkErGbjcKCVnmM25eZ7jVInrX8QTwGFgDiM8pLByHlz52NVsl+OZGirC1g5
	 bJvfwFXf4sK/0Q9BIVfUPFQTGYdKuFE3zRl0/HDfHIfvXxBQX4qC4Be3mLE2FL/v87
	 R9Y6ZJd14h8T0/VPjxo10hiaGj8f+iFyr2AKU9ZM=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id 58789A4C; Tue, 01 Apr 2025 17:22:07 +0800
X-QQ-mid: xmsmtpt1743499327ta9d3odcd
Message-ID: <tencent_4612952C8C5109058CD8E688D81276A2FD0A@qq.com>
X-QQ-XMAILINFO: OATpkVjS499uBTf0thpdaQtwQw+psHU6CMRV3bJoz671wedWm4NBKI0+89TFUP
	 34w0fHIr4V4aypPuB/y1i3lhRi1vq4jDnBbi9wYMGyu+MV/tlO2VPSLHJuNwgwpCZcz+e4MF5Lw5
	 0VlAUMba7YjDAnk0qBHOYh0GQx2kPtBsfbCX4RbisjJk5WVGrHIDJFjwkIQTgLXb11t2qsFQ9qzF
	 iYehbgdhi2mb2Tyo+PsAIy5wHYXcpON10vJb/ZzEIvdsdiDNjk8h4lDRDPQdSHD0+R5uvcbEkgz4
	 Hf8JEcS0GJEIBHXGEXCQKfgajE7v+bWXgA+3oIQflxmPK/qGcQ7PplAnjbGEuO1yeEV3S0bdFPHr
	 TlXIomiEvPmhF0mDso84izHEuqchxLR2C4O/oDEwM3V6o2Q8YfgrvoRUjhuhm4W+qRGiDxYkkoy6
	 tOxvXYPatkxvPg2XKis9i0jV+rLv1HOqEJXpHO7v+QOOWS56bjY4XIeW8cxxFTfSe/HOa2yTvEFq
	 qmM7lRgCGvSjsmD/NRKBjSch6HMxx9ml296sU1vq/VptZhaTcDR47EOO0QbMqaUI7NqljYfNemuS
	 RKbvNCOw76K2yWxfM6XYe6zgRSUiPTPe7MOOyHmEwlavoGvdGPOVaWauwc48jfM4jKXdPgBdpYbb
	 VQBBf/ZH5F6xjth0zHboXRCgp1bmDAcKQjeNmjS639Zi/dFmTT0yG3y46fZJkNSFgKr71HRP5keV
	 PhLfUNcHhMvHesEYy1kVwg/fL/ZTeygO0FaB9Uytr9qPaIgROys99Lb1ksyRiO7ar9uOxAsIY3/p
	 y0juuugnpAK6oks0BaEBZQS1I1bgbUTcEtqEquB/lAUsv4nE3xcfeaPwvW3Mw6Gj5+6C/VIy1y/r
	 q1MhLCNyS/nkW66LV4ul51nczaR6d1VfOYi6ISgNrysjoTwfG9cY1g8WGspB9lL5uCX8yh4t48CM
	 uyLvuH+LiKg9rj3w2NLhmmygIETImS7qdDV43xhGM=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Yaxiong Tian <iambestgod@qq.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	chaitanyak@nvidia.com
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH v3 0/3] nvme: Add sysfs interface for APST configuration management
Date: Tue,  1 Apr 2025 17:22:06 +0800
X-OQ-MSGID: <20250401092206.1542479-1-iambestgod@qq.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250401_022225_554846_9AC75FCB 
X-CRM114-Status: UNSURE (   9.05  )
X-CRM114-Notice: Please train this message.
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

From: Yaxiong Tian <tianyaxiong@kylinos.cn>

This series enhances NVMe APST (Autonomous Power State Transition) support by:
1. Adding warnings for PST table allocation failures
2. Exposing APST tables via sysfs for runtime inspection
3. Providing per-controller sysfs interface for APST configuration

The changes allow better visibility and control of power management settings
through userspace tools while maintaining the existing functionality.

Yaxiong Tian (3):
  nvme: Add warning for PST table memory allocation failure in
    nvme_configure_apst
  nvme: add sysfs interface for APST table updates
  nvme: add per-controller sysfs interface for APST configuration

Changes in v2

Add mutex_lock in nvme_set_latency_tolerance() for Potential competition 
between nvme_set_latency_tolerance() and apst_update_store().

Changes in v3
In  PACH nvme: add sysfs interface for APST table updates,Add why dynamic APST 
updates are needed in the commit message, fix code formatting issues. 

 drivers/nvme/host/core.c  | 24 ++++++++++------
 drivers/nvme/host/nvme.h  |  6 ++++
 drivers/nvme/host/sysfs.c | 59 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+), 8 deletions(-)

-- 
2.25.1


