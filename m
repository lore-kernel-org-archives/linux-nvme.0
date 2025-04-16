Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F5FC369C2
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Apr 2025 10:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:
	References:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Subject:Date:From:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wvB+keRFVzVh1DJYGIb8LucwQ+6rtbU+9S6gxZ2xZTA=; b=hPDY19b1K/bpWFpt7JK1QYXppb
	hXnUo99LwcL1XLyQFnngY0lR8UwHiQjerKNFjdnqOhjxoq7suWrU+4Lsv3nMfNtLCUZlXbP5sh97X
	Hc4fSlJmQIc2eQ9+Qwpo1WEsImB/BMBHj8Q/kAYQMgkO6/ce+e7KDS0dhnXgN3K+rQFC3FGvJM5xx
	V1C25DrtuAYwQNQnFbNFUOu0X/VdYh5KP1PJ016Bni7t2o1A0NJB6YadgqQ92wmywl40a23uRxg0K
	mxqRnDuybSR1rfAW6YjTnYUIpgnFL03nd3JEAOymSB3MbqH7FLXuxxdF14ky7qOK7kinnDqBb9rRB
	4M37IGFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u504C-00000009BFq-1soG;
	Wed, 16 Apr 2025 10:32:28 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4zKI-000000091V6-3sPS
	for linux-nvme@lists.infradead.org;
	Wed, 16 Apr 2025 09:45:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id ED4044A26E;
	Wed, 16 Apr 2025 09:44:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9C51C4AF0C;
	Wed, 16 Apr 2025 09:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744796700;
	bh=GjcjBI58OgkVj8A5MLEXwdxEl+hceaKdCujeEc2HSq8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HpeeedmwxModiIUGwGODlYHdZ5Ouui4lrihbjt5fwrYe1597/V78+LnWA5mkeCTZR
	 yYWR/bI5vYw5OTg+APj7OOunCrZ0+KiD1AziH2HhopWV/3/3kYz/j8VDF8mjvKZgJ0
	 bWS2lBz/6K8LzgX/DRzlbN7IrXUzZP+Ndnd0A6QeduGQFdXj1cRRvygc7fH46VvN6g
	 NR8bXb9VlE1fhkapaO/1mzub3KaJ6u8Ddqeo5IQj9uHkP9HLJ0783ZMLVV4SLrHfpZ
	 IZnt2hxhV4YuTZ0a4owR7onUEWfN2tBfeGHRAdZFAE63b3ZNNwdxv67/Yubkt0pnya
	 ExIwjPbPhRTvg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE6AC369C5;
	Wed, 16 Apr 2025 09:45:00 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+chenlinxuan.uniontech.com@kernel.org>
Date: Wed, 16 Apr 2025 17:44:49 +0800
Subject: [PATCH RFC v2 3/5] vfio/virtio: add __always_inline for
 virtiovf_get_device_config_size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250416-noautoinline-v2-3-e69a2717530f@uniontech.com>
References: <20250416-noautoinline-v2-0-e69a2717530f@uniontech.com>
In-Reply-To: <20250416-noautoinline-v2-0-e69a2717530f@uniontech.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3264;
 i=chenlinxuan@uniontech.com; h=from:subject:message-id;
 bh=PuGcJxOd8DayapVsQ7YIhWxmF6aRHfRlTC8JQBmNN9k=;
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBn/3wXtW1weup2hT4Z+Yi7yoKEwnZs3b7CyORfq
 Xvvrwno7P2JAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCZ/98FwAKCRB2HuYUOZmu
 i1tpD/9a1TgfBtJrQZp06BwLsq7szJqErUQ8zTs0NqXhMPs3oGvshKi5/TpP/fH2XNZsqCCmTrz
 EtRpJ6f358wwfWUO6ys8nznwN7yNLcVVL8/qeEfHcZNbaRmoB1xRQ6GKvyJG7BAWR8uH4oub3GH
 bpSELAUuBC3xjihAlngAnlycH8/MAHxYjAXaQKGfcFsHCmx8GsshG2zAyRxH1CwrPxy5cfE4plC
 Zv3YiC8Ee4UmznjWnqVs31WWKs//iFnwfYHrFvo97dOU4PNCv/ZWRp+HoExOd5x863v/jYnOH9B
 F1c0lU4TGvUiOghX8v6ULJ1QofhSuWfJq5oYZSRc0o94MVpVjkfbuJqrfLHtF/6MgvoN0ne1h/T
 yx3KItyQEYvUgfT/sQ+bbN2s8pTQL4MI0qI9F/p04Tgp9N4R58vkOYKqdP6Dqet6tIhX3SdxrgX
 BY4XhL0HxUUfpgPjp3pykTxv03TG+ETBHlrNzbYrz5iaIFt3XUqFkDT3hCXVj16IDA4ilqjHn5R
 KaBpzLHTr5Q80Ao7V14YGMflufW3NFQXMu+pw22boy/8lsiFcKKmdzoM+giVIGfVUXS5ObqO3+i
 EktURcgQB8LRFDMgM7DfcJEzzT9XXuThlEfmJQ33+OMZ0B9S+kEvpXTSBUSiLuOA/4AtnAZNhse
 DjYNXNAakI/Vl6A==
X-Developer-Key: i=chenlinxuan@uniontech.com; a=openpgp;
 fpr=D818ACDD385CAE92D4BAC01A6269794D24791D21
X-Endpoint-Received: by B4 Relay for chenlinxuan@uniontech.com/default with
 auth_id=380
X-Original-From: Chen Linxuan <chenlinxuan@uniontech.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250416_024503_037678_39F54DD4 
X-CRM114-Status: GOOD (  13.29  )
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

From: Winston Wen <wentao@uniontech.com>

Presume that kernel is compiled for x86_64 with gcc version 13.3.0:

  make defconfig
  ./scripts/kconfig/merge_config.sh .config <(
    echo CONFIG_VFIO=m
    echo CONFIG_VIRTIO_PCI=y
    echo CONFIG_VIRTIO_PCI_LIB_LEGACY=y
    echo CONFIG_VIRTIO_VFIO_PCI=m
    echo CONFIG_VIRTIO_VFIO_PCI_ADMIN_LEGACY=y
  )
  make KCFLAGS="-fno-inline-small-functions -fno-inline-functions-called-once" \
    drivers/vfio/pci/virtio/legacy_io.o

This results a compile error:

    CALL    scripts/checksyscalls.sh
    DESCEND objtool
    INSTALL libsubcmd_headers
    CC      drivers/vfio/pci/virtio/legacy_io.o
  In file included from <command-line>:
  drivers/vfio/pci/virtio/legacy_io.c: In function 'virtiovf_init_legacy_io':
  ././include/linux/compiler_types.h:557:45: error: call to '__compiletime_assert_889' declared with attribute error: BUILD_BUG_ON failed: !is_power_of_2(virtvdev->bar0_virtual_buf_size)
    557 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
        |                                             ^
  ././include/linux/compiler_types.h:538:25: note: in definition of macro '__compiletime_assert'
    538 |                         prefix ## suffix();                             \
        |                         ^~~~~~
  ././include/linux/compiler_types.h:557:9: note: in expansion of macro '_compiletime_assert'
    557 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
        |         ^~~~~~~~~~~~~~~~~~~
  ./include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
     39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
        |                                     ^~~~~~~~~~~~~~~~~~
  ./include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
        |         ^~~~~~~~~~~~~~~~
  drivers/vfio/pci/virtio/legacy_io.c:401:9: note: in expansion of macro 'BUILD_BUG_ON'
    401 |         BUILD_BUG_ON(!is_power_of_2(virtvdev->bar0_virtual_buf_size));
        |         ^~~~~~~~~~~~

BUILD_BUG_ON needs virtvdev->bar0_virtual_buf_size to be computed at
compile time. So we should mark virtiovf_get_device_config_size() with
__always_inline here.

Co-developed-by: Chen Linxuan <chenlinxuan@uniontech.com>
Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
Signed-off-by: Winston Wen <wentao@uniontech.com>
---
 drivers/vfio/pci/virtio/legacy_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/virtio/legacy_io.c b/drivers/vfio/pci/virtio/legacy_io.c
index 832af5ba267c49a079009cfe0fa93c15ba7a490f..b6871d50b9f9e278ef3c49a9cb2baf474b8271c6 100644
--- a/drivers/vfio/pci/virtio/legacy_io.c
+++ b/drivers/vfio/pci/virtio/legacy_io.c
@@ -350,7 +350,7 @@ int virtiovf_open_legacy_io(struct virtiovf_pci_core_device *virtvdev)
 	return virtiovf_set_notify_addr(virtvdev);
 }
 
-static int virtiovf_get_device_config_size(unsigned short device)
+static __always_inline int virtiovf_get_device_config_size(unsigned short device)
 {
 	/* Network card */
 	return offsetofend(struct virtio_net_config, status);

-- 
2.48.1



