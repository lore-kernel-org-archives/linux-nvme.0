Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB5FE64025
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Nov 2024 22:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mF3+KWvgLxl5U2zTG2GYl36cA4R4ZAKeJVmHOspWrlw=; b=mGeQqTN8JkqXhfifv1arixcdyl
	nEUrD7oeoJ8LFPdxln4nXumRVhMzsd2pvcIbe5wjgvAWVkDGnZx4rZCSv8Z74NNICSgW8devMcLaD
	A3M5XK8B1CGiGBlWBixVWNvzP/FomZkqsFVj7o5vBqSFXH9rKMVhxPh6qIj9zhFlq/I2s5+n5EkCV
	6uhBlTn1cfaLm/ez99kxxsSmnRcmYvwPF9r1/gOs8OIulO5tHFEZ6TGzyXqKZbtkzNEeXKxKVWC2G
	99Q06XW9784mnub6vV6ut5y7+5WoV5lP1Caay7i2kklux5iCd60EZKLaHJtrvaqg9wGfjkkqiZAEv
	7XYAA19w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEFI5-000000012Lh-1Mhs;
	Thu, 21 Nov 2024 22:04:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEFI1-000000012LB-3Spf
	for linux-nvme@lists.infradead.org;
	Thu, 21 Nov 2024 22:04:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732226679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mF3+KWvgLxl5U2zTG2GYl36cA4R4ZAKeJVmHOspWrlw=;
	b=Lk5/RladT+J6Eje8J2/uNPrErAlPQ2w8cgSs0roRbEY1eJuRNtRxRbK9oVs8iWEzPeQwZ5
	TVNyf+p61AGM648mq8O0a2s5FXp1pTJjaQlJO/I33CsxJsvlrUBxzXqxZiR4q3aA8JYXOm
	Xcyv7SIlLMLP/NCBZ8uEuNGhDMsEQy4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-5HqZUzsAP3-yRf4VSj2Lvg-1; Thu,
 21 Nov 2024 17:02:56 -0500
X-MC-Unique: 5HqZUzsAP3-yRf4VSj2Lvg-1
X-Mimecast-MFC-AGG-ID: 5HqZUzsAP3-yRf4VSj2Lvg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE30719560AF;
	Thu, 21 Nov 2024 22:02:53 +0000 (UTC)
Received: from bgurney-thinkpadp1gen5.remote.csb (unknown [10.22.65.81])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 29D21195E481;
	Thu, 21 Nov 2024 22:02:49 +0000 (UTC)
From: Bryan Gurney <bgurney@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk,
	mpe@ellerman.id.au,
	naveen@kernel.org,
	maddy@linux.ibm.com,
	kernel@xen0n.name
Cc: jmeneghi@redhat.com,
	bmarzins@redhat.com,
	Bryan Gurney <bgurney@redhat.com>
Subject: [PATCH 0/1] nvme: remove CONFIG_NVME_MULTIPATH
Date: Thu, 21 Nov 2024 17:02:35 -0500
Message-ID: <20241121220235.40576-1-bgurney@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241121_140442_050716_ED08D587 
X-CRM114-Status: UNSURE (   9.79  )
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

Device-mapper multipath will no longer be operating on NVMe devices,
so the nvme.core.multipath module parameter can be removed.  This
series also removes the CONFIG_NVME_MULTIPATH kconfig option.

This was tested on the nvme-6.13 branch (currently showing version
6.12-rc4), with particular attention to tests nvme/033-036, and
nvme/039.  These tests still passed after the removal of the
CONFIG_NVME_MULTIPATH parameter (the tests use an "rc" function,
_require_test_dev_is_not_nvme_multipath, that checks for
"nvme-subsystem" in $TEST_DEV_SYSFS, so they do not check for the
existence of CONFIG_NVME_MULTIPATH).

The blktests test nvme/005 checks for the module parameter value of
"nvme_core multipath", but this test gets skipped after this patch.

Bryan Gurney (1):
  nvme: always enable multipath

 arch/loongarch/configs/loongson3_defconfig |  1 -
 arch/powerpc/configs/skiroot_defconfig     |  1 -
 drivers/nvme/host/Kconfig                  |  9 --
 drivers/nvme/host/Makefile                 |  3 +-
 drivers/nvme/host/core.c                   | 17 +---
 drivers/nvme/host/ioctl.c                  |  3 +-
 drivers/nvme/host/multipath.c              | 10 +--
 drivers/nvme/host/nvme.h                   | 97 +---------------------
 drivers/nvme/host/sysfs.c                  |  6 --
 9 files changed, 7 insertions(+), 140 deletions(-)

-- 
2.45.2


