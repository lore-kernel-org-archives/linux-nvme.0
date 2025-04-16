Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE04C369C2
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Apr 2025 10:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:
	References:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Subject:Date:From:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VrUPhWgrEBqpeVY7+8yQXzECtz/p8RZZmfxLhhjQW44=; b=EOelaJaa8G1YxlUD4FPUpL4WH7
	i0bpibKdGDkjmFMXuVrUr8vRULeHlNrkC7b8E3IzWUA8iVcxDEw0pcIcVFC3im5uCLojcu1ntbzyd
	M4HG+hfY6Rf7nHz0bi+EfzbeTwdxeUD4+ghd4r4802oHNqYaMbj+bMS9IICKk4xB4vPicdh2kW1WK
	zj3gw4o+Zoyc6OM9O/pn0dz01tW5X/Ygme7p1k6byGy4Hsws4LBvPLLDqP3/BpLHa8C5S46GZs8XK
	drhZSHF99KTj3yniioG4js5MXn7Dmpazeqz9tk/PdAJrAye/xhaNB9oSnvr1sUVRvwugmtvG7EbOc
	WWQrmQCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5046-00000009B50-3lwI;
	Wed, 16 Apr 2025 10:32:22 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4zKI-000000091Ur-0Kmp
	for linux-nvme@lists.infradead.org;
	Wed, 16 Apr 2025 09:45:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A6EE7615EB;
	Wed, 16 Apr 2025 09:44:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2A3BC4CEF3;
	Wed, 16 Apr 2025 09:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744796700;
	bh=pRU6wLgxXnLL1nq6ekG3r0pNLgbdqaE3J4O9xny8g9g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ekqj+Gu/0hKmxeU3sm6q1f2ryuXtUFna6ArZ7i8VRK8suIQwaNNKThLw6ImaKsr5K
	 t0mZIWV5XLpX6VHLck+gcTnsQVTrinH9PM7QVd9oguTIrn7SNyEEyk6GhQt2eCE+Xq
	 58clWQAoWoEdCiRa24pVL33ZaWLNOUUCVE8PHQl6gKwS4H+pAlXWIgRnzBmqWeoxZ+
	 STzsWCztCoWIdguL6ckBQtCF9551uC+sBRoMfvnJNK5FFrkWClkz563175vEhlF9nU
	 B+hfAzBO8AkYTDIbAad2roMX8GONH0N9cvXRru8OFUGmGo3obvCkayvcukwGaF4p/D
	 zk8QiATZhVaGQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12E6C369C1;
	Wed, 16 Apr 2025 09:45:00 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+chenlinxuan.uniontech.com@kernel.org>
Date: Wed, 16 Apr 2025 17:44:50 +0800
Subject: [PATCH RFC v2 4/5] tpm: add __always_inline for
 tpm_is_hwrng_enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250416-noautoinline-v2-4-e69a2717530f@uniontech.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3892;
 i=chenlinxuan@uniontech.com; h=from:subject:message-id;
 bh=eVMGMErwkSKVlhFsRXd5VgFhkcLZ6sQRGgY0l5PVv8Q=;
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBn/3wYTeAxxXYaBDNq6MoKT5/qwja5tvQJEZiWQ
 VjsA0MmYHeJAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCZ/98GAAKCRB2HuYUOZmu
 i72UEAD2OIFAhd0YqHWxRgTYgam80CB7jU1JXtFVmnHuEVb2fZKwu3HLJvvNPTdU488rihW29Gv
 a7Mp25dYGsmpP7Y94+fu8UZ4WFHadCc8hD/JMAHf9TYKA/QHF305zxqKfWDFsh45+9l/9GyxUGx
 pn9FPSvodZ2un0zqttouu2KSsIVrqiSaWsJ/CJMWPUymTUQtgjhjTQYRpNgPD1Hgzy1NLg7qFn2
 xXZ8H66IWPbH/UYx8FYT4u1nexNR8phuoDm1tbZgVG2reCPwbE7aqnvbp4nvOni6Ry75bTal19f
 1ph+O4sFDpacQ3l/zIvqqWbja+D5nbtDyeljbPTOLtO9BiUunxTtWzxx1jP9pZ+AfthSYLHtP6i
 Fw0i6kS/FCH2vL86HtHiWMVhZLa2TB0sXTxz8IG1a5F+Ws6KUU8ATsuG7kYv/CVgO4uMR3caLvt
 9ZmjawH5WNd8M6YqYA9gX4OzOGn9BJL5MYTQQNg6vbx6UpzwWXxG1m/96VBePk+auO80b2gyVcW
 kLoKOHVePJDYSgmqibXWCc2BQIEjkqDF1/bZgB/tuqmreGPUjrxR2RtT0xRLlh2K1fSFHUjMV26
 wpWwKRlygPJbqNOMeoSfRl7qf5jn3XSxZvex19Soc7LaN/0iI+vfTTCYk/j6PbihEFAmhkJ92r1
 +J10jZUB46Z8qgg==
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

From: Winston Wen <wentao@uniontech.com>

Presume that kernel is compiled for x86_64 with gcc version 13.3.0:

  make defconfig
  ./scripts/kconfig/merge_config.sh .config <(
    echo CONFIG_TCG_TPM=y
    echo CONFIG_HW_RANDOM=m
  )
  make KCFLAGS="-fno-inline-small-functions -fno-inline-functions-called-once"

This results a link error:

  ld: vmlinux.o: in function `tpm_add_hwrng':
  tpm-chip.c:(.text+0x6c5924): undefined reference to `hwrng_register'
  ld: vmlinux.o: in function `tpm_chip_unregister':
  (.text+0x6c5bc9): undefined reference to `hwrng_unregister'
  ld: vmlinux.o: in function `tpm_chip_register':
  (.text+0x6c5c9b): undefined reference to `hwrng_unregister'

With `CONFIG_TCG_TPM=y` and `CONFIG_HW_RANDOM=m`,
the functions `tpm_add_hwrng`, `tpm_chip_unregister`, and
`tpm_chip_register` are compiled into `vmlinux.o`
and reference the symbols `hwrng_register` and `hwrng_unregister`.
These symbols, however, are compiled into `rng-core.ko`, which results
in the linking error.

I am not sure but I think this weird linking error only arises when
auto inlining is disabled because of some dead code elimination.

`CONFIG_TCG_TPM=y` and `CONFIG_HW_RANDOM=m` set `CONFIG_HW_RANDOM_TPM=n`.
This causes the function `tpm_is_hwrng_enabled` to always return
`false`, as shown below:

  static bool tpm_is_hwrng_enabled(struct tpm_chip *chip)
  {
      if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM))
          return false;
      if (tpm_is_firmware_upgrade(chip))
          return false;
      if (chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED)
          return false;
      return true;
  }

When `tpm_is_hwrng_enabled` is inlined, dead code elimination
optimizations are applied and the reference to the `hwrng_*` functions
will been removed.
For instance, in the `tpm_chip_unregister` function:

  void tpm_chip_unregister(struct tpm_chip *chip)
  {
  #ifdef CONFIG_TCG_TPM2_HMAC
      int rc;

      rc = tpm_try_get_ops(chip);
      if (!rc) {
          tpm2_end_auth_session(chip);
          tpm_put_ops(chip);
      }
  #endif

      tpm_del_legacy_sysfs(chip);
      if (tpm_is_hwrng_enabled(chip))
          hwrng_unregister(&chip->hwrng);
      tpm_bios_log_teardown(chip);
      if (chip->flags & TPM_CHIP_FLAG_TPM2 && !tpm_is_firmware_upgrade(chip))
          tpm_devs_remove(chip);
      tpm_del_char_device(chip);
  }

When `tpm_is_hwrng_enabled` is inlined and always returns `false`,
the call to `hwrng_unregister` is effectively part of a `if (false)`
block, which I guess that will be then optimized out.

However, when the `-fno-inline-small-functions` and
`-fno-inline-functions-called-once` flags are used,
tpm_is_hwrng_enabled is not inline.

And this optimization some how cannot occur,
leading to the undefined reference errors during linking.

Adding the `__always_inline` attribute ensures that
`tpm_is_hwrng_enabled` is inlined regardless of the compiler flags.
This allows the dead code elimination to proceed as expected,
resolving the linking issue.

Co-developed-by: Chen Linxuan <chenlinxuan@uniontech.com>
Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
Signed-off-by: Winston Wen <wentao@uniontech.com>
---
 drivers/char/tpm/tpm-chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index e25daf2396d37bcaeae8a96267764df0861ad1be..48cc74d84247e258a39f2118e03aa10d0cbb066a 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -534,7 +534,7 @@ static int tpm_hwrng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 	return tpm_get_random(chip, data, max);
 }
 
-static bool tpm_is_hwrng_enabled(struct tpm_chip *chip)
+static __always_inline bool tpm_is_hwrng_enabled(struct tpm_chip *chip)
 {
 	if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM))
 		return false;

-- 
2.48.1



