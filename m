Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 352E4C3ABCB
	for <linux-nvme@archiver.kernel.org>; Sun, 11 May 2025 17:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xKpMhveG3McjKP1gZe4ReNJ/lPxnR+ZjwbZBUMSLjDo=; b=w0h/sjR9v4Fi1JCwe9nmlLpodn
	80lFCI0aA5X6+a62oUOMF++y2SG9txvTG9oQ5ZK34wrr2PhhUc5Kz8Nkk3dcOiKVpMXn3F77VqjaN
	fZiPZd3J4c9uEe/5SMul4spsbagMulY4xNZusQG95gU0/YyShAZM+Js9c2rF3Av64ZxH2Upi8vtsM
	bFTQzsNS5yAnqLE0p9IvOyX+NPzcNK6sfvdJk+lQzfWnBIPpzNjEFa8AmAaBbJE+8t5Dm00thg+0l
	F7xWsyNlI61UFUpkmvDl5txapHXbSXshFOPeu1V9KIfufuZ5bzBPjSRFXBjsns1Y3vHJVEexFuIxK
	PS8OSMEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEAQ7-00000007arX-139T;
	Sun, 11 May 2025 17:24:59 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCjJb-0000000GRpL-2ZfD;
	Wed, 07 May 2025 18:16:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7A1D55C5F2D;
	Wed,  7 May 2025 18:14:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40AD0C4AF0B;
	Wed,  7 May 2025 18:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746641778;
	bh=uZoSquFI+a0xjog8hTbmiXK+g9d2dTlbWp8mPmCNMg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZKDyZKo6hU1ylbBsdsHg1+TcItf4hyCXIgidkN1u2V9fur6qzfPt9My5I4G87b2mv
	 C0iv+fpbYKoG/WRMdgQEqtDPLt0RScOiStbUnSAhnGGgH9+LJav2250DqmwGRtCUtu
	 ekf17Eo9dvF2f4vx89HXarRvLmKzr3vEL0Pyd7+hJaZjfzmWtA6rYi29OuttcwbqTV
	 opJjhkZm0OJWQJgkedFtMMqg1/cr1qvDYKzuHquIW9jmyBcYM08yCAdIxJFmfyOxso
	 T+0rFoXuRWn/1G0f2ZKo4jverumkQrGB33GPc+XebGJAkft1J+OQfYavNOTElIwOMh
	 t+4MEIl7+jZ6Q==
From: Kees Cook <kees@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <kees@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	kasan-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	sparclinux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 1/8] nvme-pci: Make nvme_pci_npages_prp() __always_inline
Date: Wed,  7 May 2025 11:16:07 -0700
Message-Id: <20250507181615.1947159-1-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250507180852.work.231-kees@kernel.org>
References: <20250507180852.work.231-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3008; i=kees@kernel.org; h=from:subject; bh=uZoSquFI+a0xjog8hTbmiXK+g9d2dTlbWp8mPmCNMg8=; b=owGbwMvMwCVmps19z/KJym7G02pJDBnSi7Mj7qrfMsrM3fhoRaxL/rrABq9OocY766qs5dPZ6 ivypuR2lLIwiHExyIopsgTZuce5eLxtD3efqwgzh5UJZAgDF6cATMTQmuEPr7/VeusGR6sbc7It buppOJvwuvS7Pi3w0kt/kCT1t3wZI8NiFv+2ExmaiusX9TdKhKnkSqd63uoME9wpk/HmxNo9Tuw A
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_111619_728913_9A3E6850 
X-CRM114-Status: GOOD (  16.07  )
X-Mailman-Approved-At: Sun, 11 May 2025 10:24:57 -0700
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


