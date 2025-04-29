Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC09C3ABA5
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Apr 2025 18:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:
	References:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Subject:Date:From:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=myVfGyM4QWerr4szyQd4EaWR6WV2JkWhStZMnwWd3T4=; b=10phdzUau9YmBtox1qDQPdR3qU
	GZ+m5HTrapZUslXWiqjb2XYige5qi3xGhEj/ZG9E/Wdc0s+LFBcwTpwfBklyqadE7Hn7dIBjQtdC3
	wRI4CJVwCmA/2na93b8YtEI/S3y9StdBNQsT4df8SwB/Mdcj7BhShOtimUJu+nwj/CuBOTi5Y8LsA
	p2h9Uszrppt5fxtnFbE2B2ymE2cMZaD2iassIw9sRRP/AhV7G9s8EILDFfI7twql0mUiBuDMICWdE
	Xdlihkulxwdt8kCIFU2R0es1loupoUK4nnF7Nc5qMTx4Cv2u6087hc+lzmCVhtUtHvnVk7Z5NpvKv
	cjMZt/Gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9pbd-0000000AWBG-1yLb;
	Tue, 29 Apr 2025 18:22:57 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9cEd-00000008G4K-03Qi
	for linux-nvme@lists.infradead.org;
	Tue, 29 Apr 2025 04:06:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3DF6D4A286;
	Tue, 29 Apr 2025 04:06:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B92EC113CF;
	Tue, 29 Apr 2025 04:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745899577;
	bh=3PdF33JBq1nyxsd62zvfFmuPbfAnSnsdpa3r3ouJFOo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ImSxOhegHftYhReRG8oW+oM6LY5yoKLWrzrGW2V//kVusiY4KJ6C0HKApYqiV/umZ
	 jZDui8NpjNYOGK5MqF5aClgT+4pvtjZWMb3AgQxuqqCOAz00C0Lpow4dLS8fVmD8AE
	 Ew5h7vn3uiwE1AvsN5M2//c/5JyZpQKKbX7Q2uuKJzjHODfOAkvLYlkfv/lDyfol63
	 jo+QK5Rd1p+0TMQoBTMEsNJWU3r3jcXOzCGrBtNYQaJBhwRFYH8Og+3Yvb56e+MIWk
	 lrqdTOn18f4raKMikcfbZmVYGUzYJPzipTeU+RQml6v6GlEpxvCZhUZyn6fyKdVLbn
	 3BOR5syl/U+lg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4210C369D1;
	Tue, 29 Apr 2025 04:06:16 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+chenlinxuan.uniontech.com@kernel.org>
Date: Tue, 29 Apr 2025 12:06:08 +0800
Subject: [PATCH RFC v3 4/8] tpm: add __always_inline for
 tpm_is_hwrng_enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-noautoinline-v3-4-4c49f28ea5b5@uniontech.com>
References: <20250429-noautoinline-v3-0-4c49f28ea5b5@uniontech.com>
In-Reply-To: <20250429-noautoinline-v3-0-4c49f28ea5b5@uniontech.com>
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
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Peter Zijlstra <peterz@infradead.org>, 
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Dmitry Vyukov <dvyukov@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
 Juergen Gross <jgross@suse.com>, 
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
 linux-integrity@vger.kernel.org, linux-kbuild@vger.kernel.org, 
 llvm@lists.linux.dev, Winston Wen <wentao@uniontech.com>, 
 kasan-dev@googlegroups.com, xen-devel@lists.xenproject.org, 
 Chen Linxuan <chenlinxuan@uniontech.com>, 
 Changbin Du <changbin.du@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3942;
 i=chenlinxuan@uniontech.com; h=from:subject:message-id;
 bh=kxFAxUbcgxKFCXw3/ErTxJwPqpRyvp2FJuqCBA7VzuY=;
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBoEFAxPbGcLXiOi/dV/SoVEXm3HRnbi5/8nSvZh
 +e82+25uS6JAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCaBBQMQAKCRB2HuYUOZmu
 i+71D/9hbbS4WFdBy9iBvtGFu5uSk9QxvEUgVVEszHz05+5HiG4ksE8wbutqqbHRzodOZ4fTRqw
 FBgWQudMTfmZ9Fzj2OyQSpBDCrM8FsKFEp555qc9ICcP/+NEGCSsRMIq6JHxaZziOrAUiqsMpl7
 PDahCNl1FroL8m5qLyTgyojpMOANxIr1af/VNJ8bPL6C+kt3UbvxE1BQxJaGaFWwu4tuA6W2H6P
 99dM27ARBneT1Ci6a8VKJuN083PUS0DxYveGnH1FdDIjWVzoNOuccgzNF0F8v4/nl2tP84KxlLQ
 oPDVasKXAZJN0tEcMKQIwEAC+r1bcpKYHpMRVEYDYmBa264Q5nFxMISnjvLEJCKf83yqHDECcUe
 tggtJisUCNA23s3fRH1vFO5aVh1wasktvWFK0rezqWKiiSOynNsUWjQButCpUZofWo4wTHmJihb
 Ia2GiI8yLBpkdorp4xsf4SL4zvcLOzgirApNORHtHhkb9txKJ20L2WHS1VhiW7xpl3ejCcR9CpP
 YW9L2nkVmlDG0qngRaNtWv3EZCV/wN9/811wqZzwMQLNekcn/t8lq9fv9RB/bPjq7aCVZESyGER
 OBAzAGQDg3kym5GaVrbjje99pIap2zj0QwO9eZHif/0av9uHNFusDMAZGbKPHCqaEevUMehhBGq
 Eom+AMw7eNH7lTQ==
X-Developer-Key: i=chenlinxuan@uniontech.com; a=openpgp;
 fpr=D818ACDD385CAE92D4BAC01A6269794D24791D21
X-Endpoint-Received: by B4 Relay for chenlinxuan@uniontech.com/default with
 auth_id=380
X-Original-From: Chen Linxuan <chenlinxuan@uniontech.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250428_210619_131203_F18CAEEE 
X-CRM114-Status: GOOD (  20.08  )
X-Mailman-Approved-At: Tue, 29 Apr 2025 11:22:51 -0700
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
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
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
2.43.0



