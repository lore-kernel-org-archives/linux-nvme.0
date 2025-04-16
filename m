Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569ADC369BD
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Apr 2025 10:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:
	References:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Subject:Date:From:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BYNwA3IKATr9KDKMMoZIcRuvQ4Bo26F1xEhgHlTtkVU=; b=hLShBvq9rYt+EQbEaIRU5D90kF
	85pRXPeG+sqD5FtIkXQdcMpU73ZNFJ37pHwfVMpfLE+ogpM7iX8TxbQSGJvQUy25Heky3Vz/Q+Iw6
	fz2KUCE8XiGW4SclDE8Q6aqXibB0Ha8ctwgHb1pt/rWwkMpVnFDqPLMUE2TK1/+5Hr2DLH2rludCI
	ie+P+rhKa9IUN1NAtW32JT6o+JnxwX0EmRHZQLVx/jaGPB6FGFE3oMLREzir4DGn65+L9HD7kDYxZ
	KqDQLef9zNFVXsrvmhx2/OU5QwlkLgvDrjs45SFKg5UN1ZDOm0/fAUAQycCjnn/xZsl2IFzRmMVB4
	B0h6Yuww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u504K-00000009BQe-1uUR;
	Wed, 16 Apr 2025 10:32:36 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4zKI-000000091V7-3sWS
	for linux-nvme@lists.infradead.org;
	Wed, 16 Apr 2025 09:45:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 185694A287;
	Wed, 16 Apr 2025 09:45:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF0A4C4CEF6;
	Wed, 16 Apr 2025 09:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744796700;
	bh=y6sNLqLklzVcWeo9kuxbWWkQNColAUNOTv6uOnth8tc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HH1A403b+hjSeYH0fFnCcyVe3XGHSUQPNkSJexeBqDpRrGhcBviUoIMSx55nUSPHc
	 7E2bOgl3XRblTUkvQiIH3j+Oe8tYXl5itG/R260Ckf+vjYlbDGm9wnykwHav/jGvKd
	 HKOmMs2makfVltunNUFav5U7lB3/aGHP2iQg+tG8XV9j8NVptMijlodBYp274h10Cm
	 BUhJ8Awo0UtY3JBapaSwGpz7v9nob885b8E6Z8m8POQmCnCiNWmTs7kYV44HgkQ8DK
	 rSelb4535t5KDJhZldmuN2v5BTflT4lwrpvUUjKvvz/eihiQ1oVQQkCbAeza8o1QKM
	 AvZp8tmlNMiLA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE19C369C7;
	Wed, 16 Apr 2025 09:45:00 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+chenlinxuan.uniontech.com@kernel.org>
Date: Wed, 16 Apr 2025 17:44:51 +0800
Subject: [PATCH RFC v2 5/5] lib/Kconfig.debug: introduce
 CONFIG_NO_AUTO_INLINE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250416-noautoinline-v2-5-e69a2717530f@uniontech.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3064;
 i=chenlinxuan@uniontech.com; h=from:subject:message-id;
 bh=F+1qLaqiauypU+BRTQYkrjZEyIF0AG4hvaXQhsgJYk8=;
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBn/3wZT3NWiI2S8hRz1pjrEUmLoC/gt8RZUtPaC
 lubpf4A4hyJAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCZ/98GQAKCRB2HuYUOZmu
 izAIEACY38ESmIVOjDr7Iwh8UUrW7TzIcDjdsV2Gz25pzxNRYt2UN7F1ih++IU0mVKuCRE8VqsZ
 COqv1koPLnaC5FnVtv40PZwIiMbk1JDsa2ErGt5FBgb7ada1ai8OVfO05xZmtLjDLu0LBYqJs20
 54Nx0HAjECSeFJB7FsRxoyck9coB80nqWw4d6BRS0UG3/nsZJYJ5zvs3iEpL5BtNePBanOqbBao
 ey+EM2gyLwiAvD/x7pkIaPnvF9Y35X4eRaTm8+SYc48zK0Q/+9L5Vg2bmyyF9Up8vdoPVfNYD49
 zE1q9RpL992v3uSn4Uh+/XGggbgTV+nw1SXRZH1NcwML9S5Tk7czniyVD1h4KFXKUZpvkZvhQi/
 eU5K9FTQedxVsK+gma+7I3bWAbm0Yn5SZ9gUzZHGIHWSMNM6aByhX3QVbVGcrvz9uBgzJLA6G2v
 blyyctLKffNf5k3i4oGfEufOigeC2JeVcreJ8YcvZos9m3zQ9f+SWCKtvtlFdNpgcm8q7SgYEOi
 Vs4lmIBCBb2MgxZbCKfiz5qnt49ANDdBLL+6jGfnsSCdSR9yiHKDzItW4XHG62rQaZ/UgtnvTqP
 guR1IhGM9mQRv0qGS8ujapIi7oqfU995Jy3XGAG6t4uHwd0t7yItMqwthqHQwNxtgOzeuuclW/d
 ThVxVEEuZANNvYg==
X-Developer-Key: i=chenlinxuan@uniontech.com; a=openpgp;
 fpr=D818ACDD385CAE92D4BAC01A6269794D24791D21
X-Endpoint-Received: by B4 Relay for chenlinxuan@uniontech.com/default with
 auth_id=380
X-Original-From: Chen Linxuan <chenlinxuan@uniontech.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250416_024503_044714_CCD7E68F 
X-CRM114-Status: GOOD (  13.85  )
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

Add a new kernel hacking option CONFIG_NO_AUTO_INLINE that prevents the
compiler from auto-inlining functions not explicitly marked with the
'inline' keyword.

This enhancement improves function tracer capabilities as it can only
trace functions that haven't been inlined by the compiler.

Previous discussions:

Link: https://lore.kernel.org/all/20181028130945.23581-3-changbin.du@gmail.com/

This patch is modified from commit 917fad29febd ("kernel hacking: add a
config option to disable compiler auto-inlining") which can be founded
in linux-next-history:

Link: https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next-history.git/commit/?id=917fad29febd

Unlike the original implementation, this patch:

1. Make it depends on CC_IS_GCC,
   as Clang 18.1.3 break test_bitmap_const_eval() in lib/test_bitmap.c

2. Make it depends on X86 and LOONGARCH,
   as I haven't test other architectures

3. Removes unnecessary cc-option checks per commit 7d73c3e9c514
   ("Makefile: remove stale cc-option checks").

4. Update help information.

Cc: Changbin Du <changbin.du@gmail.com>
Co-developed-by: Chen Linxuan <chenlinxuan@uniontech.com>
Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
Signed-off-by: Winston Wen <wentao@uniontech.com>
---
 Makefile          |  6 ++++++
 lib/Kconfig.debug | 15 +++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/Makefile b/Makefile
index c91afd55099ea6bc7ed89bc3ef9cf58a498596d4..52da2c27f94167d2d2892a67c065e5df15efbde0 100644
--- a/Makefile
+++ b/Makefile
@@ -1071,6 +1071,12 @@ endif
 # Ensure compilers do not transform certain loops into calls to wcslen()
 KBUILD_CFLAGS += -fno-builtin-wcslen
 
+ifdef CONFIG_NO_AUTO_INLINE
+KBUILD_CFLAGS   += -fno-inline-functions \
+		   -fno-inline-small-functions \
+		   -fno-inline-functions-called-once
+endif
+
 # change __FILE__ to the relative path to the source directory
 ifdef building_out_of_srctree
 KBUILD_CPPFLAGS += $(call cc-option,-ffile-prefix-map=$(srcroot)/=)
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 9fe4d8dfe5782981cc0b2b6614106aac570bd229..2ebb4802886ab4a48841dbdd8973b7d9883548b9 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -436,8 +436,23 @@ config GDB_SCRIPTS
 	  instance. See Documentation/process/debugging/gdb-kernel-debugging.rst
 	  for further details.
 
+
 endif # DEBUG_INFO
 
+config NO_AUTO_INLINE
+	bool "Disable compiler auto-inline optimizations (EXPERIMENTAL)"
+	default n
+	depends on CC_IS_GCC && (X86 || LOONGARCH)
+	help
+	  This will prevent the compiler from optimizing the kernel by
+	  auto-inlining functions not marked with the inline keyword.
+	  With this option, only functions explicitly marked with
+	  "inline" will be inlined. This will allow the function tracer
+	  to trace more functions because it only traces functions that
+	  the compiler has not inlined.
+
+	  If unsure, select N.
+
 config FRAME_WARN
 	int "Warn for stack frames larger than"
 	range 0 8192

-- 
2.48.1



