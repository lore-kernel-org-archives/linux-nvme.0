Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F05C369DC
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Apr 2025 18:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:
	References:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Subject:Date:From:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wdxfb83sz64pVXY/N1P48YSO3Ovk6I4U3rA1Q3+Ucd8=; b=G/ls5q1bQjH6IEcLoasrRH2S/t
	GZRovyl6hE8CkZE6GPXVgc9IFgEq2piyVLgQgTeoR7IwZuNqgRhsbYz+GFiYrA18kul3l/8VCZD3R
	yUyUzkNhAX6MNplkTdyzHQ1YUvvF0lZPCfHh0RX5zpyJCxRCIEMjrKHKq+ZWTTLxYQNiU2XbO2H8D
	DL7/XeIukwahW5UX8EEg1GoVW+uoEtKLwCuqYIU8Pl8aDOr/g/O0j/JaXPr5SEFvbBOs08VLag5qf
	QpVUn5R/4XtCd8TvAulmk95VcBGY4aiWoJnMTsLjKmAdvbiiYI/nvkYZTJbFIs04ZFXSVbdXRa4Kg
	Tqu3tKjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9pbf-0000000AWDz-17zs;
	Tue, 29 Apr 2025 18:22:59 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9cEk-00000008GAy-3YZd
	for linux-nvme@bombadil.infradead.org;
	Tue, 29 Apr 2025 04:06:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Reply-To:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Content-ID:Content-Description;
	bh=wdxfb83sz64pVXY/N1P48YSO3Ovk6I4U3rA1Q3+Ucd8=; b=Ntc6IfaydQDRvENYXphoXqApku
	74cavT2Wjd79EY6fiyLglq9GZDhu+AxaOjPKuhY7OqAGxEZWXlqmNwJ/W5r5RN2n4bQyqapyWt/5c
	2jzARsxywys/qCaK2LM6Qkdr6cugn48hgHU42ao4bkUAOGhzXmdWOMhi96YTVIq5lbwei6AmKzmRI
	m6tsjm3sUxLl4CCqsGkbDN9+RApT2V+4no9/VUztjxrAHgtBsWni6I4fzZhbMpgDH7aWOcnomOPmp
	u7ESelFKRntfRFPaNfhqJp2kT2866JE6eVWo6DxP6g04BxRkgu+vc2W/+DB40ZZGY3Pruiz8I/I35
	l9fbCr4Q==;
Received: from nyc.source.kernel.org ([147.75.193.91])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u9cEg-0000000DBYf-1fK8
	for linux-nvme@lists.infradead.org;
	Tue, 29 Apr 2025 04:06:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id CDFCCA4BB08;
	Tue, 29 Apr 2025 04:00:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58FE1C4CEFF;
	Tue, 29 Apr 2025 04:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745899577;
	bh=I3qZ450wr0Q9CAPbI9DMJdfFZ5c1+02YMYdsGYpKCO4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JE0vEjoKdI3aoLXySgz46sIqLxGHS10+ctvdryhzIzUS4HhXuF3Tl298hubpjKFM/
	 w6TK/WAFgLyiSvmTT0C7btzFR8/sJwuEVJ7dvhLp/FopZjfp4F38JZxjFbjWToxx+2
	 ZOs3hbeOeMzuD9W/l6w5BjAZ2TP8rnJk5mpj6qfsfebVTmp5WeguGbLar2dJg+54Ta
	 BQeBNnkwOGxnWBYdRi+L77qoR8Ib+Sgt4uGR4FMtkCWkIFE7JcS9361sDdnaf8uzpI
	 5PpYZSpLvvidhBYF+z1LHu2vN47VszMgmkxuY95ZwPxZ0LohS1hnrc8xtucx7pzmvs
	 64lF44iLXmi+w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8CFC3ABA8;
	Tue, 29 Apr 2025 04:06:17 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+chenlinxuan.uniontech.com@kernel.org>
Date: Tue, 29 Apr 2025 12:06:12 +0800
Subject: [PATCH RFC v3 8/8] lib/Kconfig.debug: introduce
 CONFIG_NO_AUTO_INLINE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-noautoinline-v3-8-4c49f28ea5b5@uniontech.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4279;
 i=chenlinxuan@uniontech.com; h=from:subject:message-id;
 bh=Bd93x7WuEFeV0iOsS3dMjqDGQS+n9awf6aimsKD9UOk=;
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBoEFA1dN0rUHGv15CSgUAacYmKqLp9Xxxon6yon
 c7TiGmprM+JAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCaBBQNQAKCRB2HuYUOZmu
 i55nD/9Z3vTJGmV0EjUhmeI4qXKmcdAMAq1X/bMvCKKqJb8nDqxr3XzOsrgtlGbWtGbSRpAcMRC
 kIBZwz/EFrXdSky2mgTEfswE2JzuHKo+Mt434POfvbTmTZzfhinHk2rveNLn14K6QQxOZNTHzoq
 DY3XtiBsr5/6XiSk58sFs0UB2do+v1RDxbRgPVRbwakBRf2EpGtYK+ZkSVPourJzkqG7PrIvHKY
 FyKSLRcxh2ehQ+zdjfMyhxbXKMW3rLF6KyReLohSbuPnAZH9vBG07d85cT+hlqayZ2VFrTJWayX
 ogvHBmQbs0jd6kEOOcqxulI9+HLWeFHpLWXkscXCbtKYFnN3of88CFc5dM1NBfTsa2bE/5c69eS
 TXaS9CEvSaJLZP2bguKxeYXuKMcX7aCIEmkb5ywt+zXQ2sBHHXVo62B2vH+ZEPTvJ0JBvREoDHA
 Z07bh3e0yi+U/gCk96uDLgnOmSkQUjen6r/WDp03CqP8r46lIU2aWAN8mPN0/bL6Leb+yx3Y5Gf
 MfHerWdPEqYeBh6stf8GRI22HdoAjnaigM4iGlYaLrvgjiuVjR2tHFFGtnPEviP7O+74W7AnPTn
 n9vHmKNe5H9AurNLXL/K7j5eRYSPpaBVROMuUUngVLHw7qljfnSQMwRNYonB6pGCO3WTd5AnIHj
 tq2/DJ+5MgngDcg==
X-Developer-Key: i=chenlinxuan@uniontech.com; a=openpgp;
 fpr=D818ACDD385CAE92D4BAC01A6269794D24791D21
X-Endpoint-Received: by B4 Relay for chenlinxuan@uniontech.com/default with
 auth_id=380
X-Original-From: Chen Linxuan <chenlinxuan@uniontech.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_050623_093757_9A1CECAB 
X-CRM114-Status: GOOD (  16.74  )
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

From: Chen Linxuan <chenlinxuan@uniontech.com>

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

Cc: Changbin Du <changbin.du@gmail.com>
Co-developed-by: Winston Wen <wentao@uniontech.com>
Signed-off-by: Winston Wen <wentao@uniontech.com>
Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
---
 Makefile          | 16 ++++++++++++++++
 lib/Kconfig.debug | 21 +++++++++++++++++++++
 lib/Makefile      |  3 +++
 3 files changed, 40 insertions(+)

diff --git a/Makefile b/Makefile
index 5aa9ee52a765b7aed27f44028cdcc34a90979acb..60dec6c123543150a3332a9a819fa6933e94db4f 100644
--- a/Makefile
+++ b/Makefile
@@ -1073,6 +1073,22 @@ endif
 # Ensure compilers do not transform certain loops into calls to wcslen()
 KBUILD_CFLAGS += -fno-builtin-wcslen
 
+ifdef CONFIG_NO_AUTO_INLINE
+# -fno-inline-functions behaves differently between gcc and clang.
+# With gcc, it prevents auto-inlining of functions but still considers functions
+# explicitly marked with "inline" for inlining. However, with clang, the flag
+# prevents inlining of all functions, including those explicitly marked with
+# inline. Clang provides the "-finline-hint-functions" option, which
+# specifically allows inlining of functions marked with "inline".
+#
+# In summary, to achieve equivalent behavior across compilers:
+# -fno-inline-functions (gcc) = -fno-inline-functions + -finline-hint-functions (clang)
+KBUILD_CFLAGS   += -fno-inline-functions \
+		   $(call cc-option, -finline-hint-functions) \
+		   $(call cc-option, -fno-inline-small-functions) \
+		   $(call cc-option, -fno-inline-functions-called-once)
+endif
+
 # change __FILE__ to the relative path to the source directory
 ifdef building_out_of_srctree
 KBUILD_CPPFLAGS += $(call cc-option,-ffile-prefix-map=$(srcroot)/=)
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index f9051ab610d54358b21d61c141b737bb345b4cee..56530f0145c885e9846dae1d2f8c6125c610d25b 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -436,8 +436,29 @@ config GDB_SCRIPTS
 	  instance. See Documentation/process/debugging/gdb-kernel-debugging.rst
 	  for further details.
 
+
 endif # DEBUG_INFO
 
+config NO_AUTO_INLINE
+	bool "Disable compiler auto-inline optimizations (EXPERIMENTAL)"
+	default n
+	help
+	  This will prevent the compiler from optimizing the kernel by
+	  auto-inlining functions not marked with the inline keyword.
+	  With this option, only functions explicitly marked with
+	  "inline" will be inlined. This will allow the function tracer
+	  to trace more functions because it only traces functions that
+	  the compiler has not inlined.
+
+	  Note that Clang with -O2 optimization does not fully support
+	  disabling all inline-related optimizations,
+	  as Clang does not support options like
+	  -fno-inline-small-functions and -fno-inline-functions-called-once
+	  that gcc does.
+	  Some functions without the inline keyword may still be inlined.
+
+	  If unsure, select N.
+
 config FRAME_WARN
 	int "Warn for stack frames larger than"
 	range 0 8192
diff --git a/lib/Makefile b/lib/Makefile
index f07b24ce1b3f8db28796e461db1324d97133fdd5..2ac97f0856a12f66e6c3825af6aabafa61869262 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -87,6 +87,9 @@ obj-$(CONFIG_TEST_BITMAP) += test_bitmap.o
 ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_KASAN),yy)
 # FIXME: Clang breaks test_bitmap_const_eval when KASAN and GCOV are enabled
 GCOV_PROFILE_test_bitmap.o := n
+# FIXME:
+# Clang breaks test_bitmap_const_eval when NO_AUTO_INLINE and KASAN are enabled
+CFLAGS_test_bitmap.o += -finline-functions
 endif
 
 obj-$(CONFIG_TEST_UUID) += test_uuid.o

-- 
2.43.0



