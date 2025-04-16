Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE2CC369BD
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Apr 2025 10:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mH/jru/GUNDd/hwrYhtFYLe0ZK0dU71jJkKPV+emCP4=; b=bST59H+SqBPFz5Zn1TOggNyIAb
	uyja2y5akjoj0v6yOL+K3vLL1Fce+aC/yWih12XakT28ErzrovK0/e0Lu9//Eubb6KNIxYzevmesl
	6iaVwSE5uOUs7WFgSLGsm79TLYr1W9hGvCQbfMxrfXC2qunTr1ERcA2lS6woG9tm3iRruQcmbgfPT
	w/uNvrrRidDIcHHoRJ9NfWRpgk+IfOSIjA92Bwtjlw8M793i2+8co20n2pT18RN5wNJN9Djtl8bpz
	iglob7Y+FWdGmnDoGP+IrfiFzrUyycLd8621lTKqbgjzVnBvV63Y858FlkCFSSxZh21DARg3B5I4U
	zz67FgoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5045-00000009B2V-2LZr;
	Wed, 16 Apr 2025 10:32:21 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4zKH-000000091Uk-2Yna
	for linux-nvme@lists.infradead.org;
	Wed, 16 Apr 2025 09:45:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 537A161569;
	Wed, 16 Apr 2025 09:44:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83E44C4CEE9;
	Wed, 16 Apr 2025 09:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744796700;
	bh=eILsz6Mvrmj8Hn9PGeOEedbRB8s5mmbt0mI6LYUa9jc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=eqlxv3VVX/gz8dtqFH0K3dvSfr8pt/GS18Zs9YOgIVyMDZmzt+L7KmBU9HvyCVW6y
	 uPxec1qXJCxN+16s5pQ3Yfh8/ysMylUF3FHC7xifXlRy2vypv6Y7N/8ggmmMC0BUrw
	 f0D0N8ZN8IQFbRgKeBn+nOSt4nJWKjtX0kE3TbbmKP1xXDGNbRNI5wsN+PBDOuDPkQ
	 EXgDIA0xjlBAzYDXc8m+KPHw9pdNUsXS3Vm8Ls91K9JK+65bfDmjq8dIAsvlv4rtl3
	 euHR88AdOgcNq4b6QgOQmrKnDmKOMKbji9zqncimVbq30YHk4s8QVBsLLaS7/30i+6
	 x/7wpAV3fr3+w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6FEC369B1;
	Wed, 16 Apr 2025 09:45:00 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+chenlinxuan.uniontech.com@kernel.org>
Subject: [PATCH RFC v2 0/5] kernel-hacking: introduce CONFIG_NO_AUTO_INLINE
Date: Wed, 16 Apr 2025 17:44:46 +0800
Message-Id: <20250416-noautoinline-v2-0-e69a2717530f@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA58/2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDI1MDE0Mz3bz8xNKS/My8nMy8VF2LVMsky1RTY1MTUyMloJaCotS0zAqwcdF
 KQW7OSrG1tQDz/agbYwAAAA==
X-Change-ID: 20250416-noautoinline-8e9b9e535452
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, 
 Kevin Tian <kevin.tian@intel.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
 Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nicolas Schier <nicolas.schier@linux.dev>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
 linux-integrity@vger.kernel.org, linux-kbuild@vger.kernel.org, 
 llvm@lists.linux.dev, Winston Wen <wentao@uniontech.com>, 
 Chen Linxuan <chenlinxuan@uniontech.com>, 
 Changbin Du <changbin.du@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1888;
 i=chenlinxuan@uniontech.com; h=from:subject:message-id;
 bh=eILsz6Mvrmj8Hn9PGeOEedbRB8s5mmbt0mI6LYUa9jc=;
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBn/3wUalbw8YXxAK7xQpV223bnIA+u37hAQ7ZbP
 31Is5clK5GJAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCZ/98FAAKCRB2HuYUOZmu
 i9AeD/4wyk7nT6JRtlKjfD/Ab1kLjJs3+99RNJxrdX+R8/G6iGoSQiWkxbQdltaqfw0oUPjwNYy
 XaGfqHhF455pzePiShPnA+iV39rxbOvn6GsFxHBVnBWlkuz00alqPc0k0wR+bnczsEtCco81lBW
 lQ5aEcBWmiza5jTuGvBmbzDhuf9P+4kzJpnpgzCzCuhYm8mlGOxuNpy/mYtB/qBpEC7HD2bOzno
 GuP2z2xSgPutEE3BfGPcn5zP/4ijt5eOLmnP+1mXNNruEcsH32NlzUGgvGTxEKp2nD7LbD61/lD
 aroqwImEljsIQLTw6B/cIDJcADaaCbizNlSvIZqypUFY2eq3R/So/PaJ9QNAvFJzFAcgQnpooco
 8GZX6ycNSfjtBDTLtJv1A+SPqrybdP2439iBePQ8VcyWdTTuruQXPyDdn2f9TP7/S8g0hcPCSAP
 ennnvjtytcTGq2596hGubcC1z4thbLcYjqfHgzdnObIft+MOWtAu2MW7Z/Lgw4P95M/Pr594l+9
 ubrfuV+7sZ3gGfh54WBaWb95+RYn7Mqj2tD6/gYAfwZX+zv79yXt/lwQgyRE0Ca6BXzADjGnUm7
 J9FRNt7+juTONUEp8tp50NLRoa6zep6L3AvlkpcCm64pIEHIl3fPmONhEmU0KFIjc6FBDyR5X+J
 eTQCOlTIbGmy3TA==
X-Developer-Key: i=chenlinxuan@uniontech.com; a=openpgp;
 fpr=D818ACDD385CAE92D4BAC01A6269794D24791D21
X-Endpoint-Received: by B4 Relay for chenlinxuan@uniontech.com/default with
 auth_id=380
X-Original-From: Chen Linxuan <chenlinxuan@uniontech.com>
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
Reply-To: chenlinxuan@uniontech.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This series introduces a new kernel configuration option NO_AUTO_INLINE,
which can be used to disable the automatic inlining of functions.

This will allow the function tracer to trace more functions
because it only traces functions that the compiler has not inlined.

Previous discussions can be found at

Link: https://lore.kernel.org/all/20181028130945.23581-3-changbin.du@gmail.com/

And v1 of this series can be found at

Link: https://lore.kernel.org/all/31F42D8141CDD2D0+20250411105142.89296-1-chenlinxuan@uniontech.com/

This patch depends on

  [PATCH] drm/i915/pxp: fix undefined reference to
          `intel_pxp_gsccs_is_ready_for_sessions'

which can be found at

  https://lore.kernel.org/all/20250415090616.2649889-1-jani.nikula@intel.com/

as well as

  [RFC PATCH 5/7] RDMA/hns: initialize db in update_srq_db()

which can be found at

  https://lore.kernel.org/all/FF922C77946229B6+20250411105459.90782-5-chenlinxuan@uniontech.com/

Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
---
Winston Wen (5):
      nvme: add __always_inline for nvme_pci_npages_prp
      mm: add __always_inline for page_contains_unaccepted
      vfio/virtio: add __always_inline for virtiovf_get_device_config_size
      tpm: add __always_inline for tpm_is_hwrng_enabled
      lib/Kconfig.debug: introduce CONFIG_NO_AUTO_INLINE

 Makefile                            |  6 ++++++
 drivers/char/tpm/tpm-chip.c         |  2 +-
 drivers/nvme/host/pci.c             |  2 +-
 drivers/vfio/pci/virtio/legacy_io.c |  2 +-
 lib/Kconfig.debug                   | 15 +++++++++++++++
 mm/page_alloc.c                     |  2 +-
 6 files changed, 25 insertions(+), 4 deletions(-)
---
base-commit: 1a1d569a75f3ab2923cb62daf356d102e4df2b86
change-id: 20250416-noautoinline-8e9b9e535452

Best regards,
-- 
Chen Linxuan <chenlinxuan@uniontech.com>



