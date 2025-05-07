Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5B5C3ABBC
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 03:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xKpMhveG3McjKP1gZe4ReNJ/lPxnR+ZjwbZBUMSLjDo=; b=MNMwPMwKiZHHX8deKbmKRC4j92
	TWQLJoAfUlyvGsu+mYt8V7PeMMkcMR/Zu9yflmhTrw4416sXyFpDb+jJQnqTOgOYA+PYXV4ksTwm5
	yqOqN64jLelNJFIrEJx1BrtCQsCIjdbj9dH/aV9jI4sx38o+kCwStnO1va5oH4VHCaQRsvYQokfty
	njitNsI8cLt+FfwgtHIXW6SyINL49FEhJpCdkStzvJWAYl4ji5Q4RnrKtaABMg/G/P7DGvE+jetsY
	+9bFs4MdK7LzUcwSlgOfi4SKNwZxj3D2XKgucpKn7Bk6gvLKlwRo/YHGuDD1WVtzQ4BKAwP8knitw
	q4IyrDMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCVZU-0000000E55T-1hUG;
	Wed, 07 May 2025 03:35:48 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCVZS-0000000E554-1bjO
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 03:35:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 86312A4D1DA;
	Wed,  7 May 2025 03:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 057AFC4CEE4;
	Wed,  7 May 2025 03:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746588945;
	bh=uZoSquFI+a0xjog8hTbmiXK+g9d2dTlbWp8mPmCNMg8=;
	h=From:To:Cc:Subject:Date:From;
	b=WFeVxxYz++1KH1jMeZt2VBUw5kpf+6c/ySp5CfVMv4iCU3ZWQibte5PhfHWgtgjws
	 Nvio6rv1O2Jji611UlfMd9ZMTwxKGmNqmok2Da3yhf8rErrla+xXpORsA15KS+tdNg
	 vsr42ivVYWMkvomyp9/OQLBHTUFCYUqKIvU63sJu+QFdqF31noo9tnOJsU47LhAkM7
	 E+jZnY+xNacPPTuT7yWT4jM2sYvF19TlVqCQdiUc+NWoIl0zpiuY/cixe5rTgNnt3x
	 iplCeWSqXYggJNjkS7dIw8Zh8pjW7SH0CrEgkeeRprCJwbrf87UMgHrLpn4R4aFbun
	 dY3TL0bO1dqXg==
From: Kees Cook <kees@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] nvme-pci: Make nvme_pci_npages_prp() __always_inline
Date: Tue,  6 May 2025 20:35:40 -0700
Message-Id: <20250507033536.work.088-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3008; i=kees@kernel.org; h=from:subject:message-id; bh=uZoSquFI+a0xjog8hTbmiXK+g9d2dTlbWp8mPmCNMg8=; b=owGbwMvMwCVmps19z/KJym7G02pJDBlSV3k+Hf24wEbxTuuVerVrbi/vK3wvT9t9rNXLSsvpx I//LEFTOkpZGMS4GGTFFFmC7NzjXDzetoe7z1WEmcPKBDKEgYtTACayQI6RoevuTseXEua71zzN XcWesHZppYjqn6DCDxdecVy8tWJ5/h5GhtcRZpnrFiWfZ+aJZtLZxKBsY1v2/uEmkQd5RuxOzMx ijAA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_203546_561216_B8695BEB 
X-CRM114-Status: GOOD (  15.99  )
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

The only reason nvme_pci_npages_prp() could be used as a compile-time
known result in BUILD_BUG_ON() is because the compiler was always choosing
to inline the function. Under special circumstances (sanitizer coverage
functions disabled for __init functions on ARCH=um), the compiler decided
to stop inlining it:

   drivers/nvme/host/pci.c: In function 'nvme_init':
   include/linux/compiler_types.h:557:45: error: call to '__compiletime_assert_678' declared with attribute error: BUILD_BUG_ON failed: nvme_pci_npages_prp() > NVME_MAX_NR_ALLOCATIONS
     557 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:538:25: note: in definition of macro '__compiletime_assert'
     538 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:557:9: note: in expansion of macro '_compiletime_assert'
     557 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   drivers/nvme/host/pci.c:3804:9: note: in expansion of macro 'BUILD_BUG_ON'
    3804 |         BUILD_BUG_ON(nvme_pci_npages_prp() > NVME_MAX_NR_ALLOCATIONS);
         |         ^~~~~~~~~~~~

Force it to be __always_inline to make sure it is always available for
use with BUILD_BUG_ON().

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202505061846.12FMyRjj-lkp@intel.com/
Fixes: c372cdd1efdf ("nvme-pci: iod npages fits in s8")
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: <linux-nvme@lists.infradead.org>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b178d52eac1b..9ab070a9f037 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -390,7 +390,7 @@ static bool nvme_dbbuf_update_and_check_event(u16 value, __le32 *dbbuf_db,
  * as it only leads to a small amount of wasted memory for the lifetime of
  * the I/O.
  */
-static int nvme_pci_npages_prp(void)
+static __always_inline int nvme_pci_npages_prp(void)
 {
 	unsigned max_bytes = (NVME_MAX_KB_SZ * 1024) + NVME_CTRL_PAGE_SIZE;
 	unsigned nprps = DIV_ROUND_UP(max_bytes, NVME_CTRL_PAGE_SIZE);
-- 
2.34.1


