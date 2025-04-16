Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC3DC369C4
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Apr 2025 10:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:
	References:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Subject:Date:From:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vtR7de6ZkGyq9yJzKUe14nrPwafGmRVXY/kdN91XIm8=; b=XYABk7rIcEaUW7p3/XfHtVqG4b
	kVamT4eYdFz3B8HuUMPd9WPc5Ow5fSV++pmbUbaoXrRHBnwxViLDE/TWzAzcF/+MMgdT994YHHJGU
	ZgTe7Py+OvbyL3UhAA5spnazyV1XOKOqnw80/PUsD4PXlRu3OtHlSvhxz4Pesnf+qbQjVWNpBQf/b
	IgKthWVSUYexc0ruFJkO/RNlmSzycRRspdjQoZGSinmUMJ/Tt6y1manLTAuZnUxKwwCryXovHzO/g
	dENZiJ8Wo3C0xUqV9laf7/cDyN6YQs+xljet2oXkR3yHgz3Rcgg2XWjHQrpELYucy9pp8YIaYlHMt
	5rkgsptQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5049-00000009BAV-2bfK;
	Wed, 16 Apr 2025 10:32:25 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4zKI-000000091Uq-2Vkl
	for linux-nvme@lists.infradead.org;
	Wed, 16 Apr 2025 09:45:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 182FD5C571C;
	Wed, 16 Apr 2025 09:42:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94480C4CEEF;
	Wed, 16 Apr 2025 09:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744796700;
	bh=Yv+kifpgtaJLLbyR4rAn27RlbXnINX7O4xl+RP8J8Ps=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Lach4qKYDtR1r2uJIArcYnjlMTOKDb0ehkvd5UN0MlTPQ66miK+ydvERbEHHi1kFA
	 tBpf9tUwVubeot9VKKHdObFIhyHr/l51RlJxsTRZ8oj+g4/BdRuPjSBNuldgQBVM+9
	 UvX2qv3N66+SaIbevmpj0dgd+m8BxLNLtkxxA8hz1nsdQQLysQx6/OlU0DrTjpN/i1
	 pfOB/R/QsgyA7x4qHvwXeyAh6EW9/Zr4yPpm4MGoXjLe/CsH00SkVm2vlbMhQ71VT6
	 zbEXJXdUkgPzB0m6KeyasjYLeU/Lt3gTqLYOSq30P+a2Ew9wGYWT/leA7ITiHM3RxA
	 LyZSn/JD5X2vw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C67C369BD;
	Wed, 16 Apr 2025 09:45:00 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+chenlinxuan.uniontech.com@kernel.org>
Date: Wed, 16 Apr 2025 17:44:47 +0800
Subject: [PATCH RFC v2 1/5] nvme: add __always_inline for
 nvme_pci_npages_prp
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250416-noautoinline-v2-1-e69a2717530f@uniontech.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2975;
 i=chenlinxuan@uniontech.com; h=from:subject:message-id;
 bh=sGDh7M1GW9E/6Y/0K/CCKXvss9WxUze9tBDMdqLrW6k=;
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBn/3wVG003JQmokzL+qRyfJcdxP60RFA0LrONcP
 OK5orjrbTuJAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCZ/98FQAKCRB2HuYUOZmu
 i8TED/0fmsPVnspcWh0W6L0ZSZOLbCvbFNwkSR8ln0sclXUOPtKwmyiPlZa4zJmx7OcofjIaLD/
 r/WJyI8YJpl735QY3QIBTbrps+iGTDVaqLw8NMv1GsgSn5r61K4TxGHIfCjlSFoamR3OMWdNCrS
 WgKkuDC2E6ay6dA0WfzSP78maBTAvxztzt0mrFpxZQijD5Ky6gSFVQAeztouTp6ootKC9gvMeO5
 +gtRmuu9R5kMvmwGyagr3VY9mc0otVIg2xlYhJiaVOu4CfRoc0oOpQcaFGlds7Ffe9vB6Apy562
 0ADyZ/DVMUzU4vli0sb0ABqeWUWJvQn0/PvNjTUSDE7ohfpIGMasSJ4U4pGTk2h2Uup4lO1Qk5Y
 itpYWcQQWcxZirZzGnfIAEsscrdlIW1hfEPHbAAmbwUCKwM4mYIvIvT4jVx7V8WAsDJybp72ugL
 sSHbcb/PohzAsREiVXj+ctQfKvFssyCqeC4QmvrsOAIySwTmvnVd/kmriXFtFBV32jCCFt1yrzy
 DHcdVAGXK0AEbs+63WGWuWrlpIqyutFQpNNkxOFaL3DlLSgZdNLg8Z6TeBEpltgoSrnRHWSN6KK
 2We5DBjR8F7GIDWR3F/H9QRYE/Z0BaE7a9oEZKSwd3QL13ItpXVkjs4ZYIJ497+OIimgPtSzbF9
 Tn7aHUXUKD2PLjg==
X-Developer-Key: i=chenlinxuan@uniontech.com; a=openpgp;
 fpr=D818ACDD385CAE92D4BAC01A6269794D24791D21
X-Endpoint-Received: by B4 Relay for chenlinxuan@uniontech.com/default with
 auth_id=380
X-Original-From: Chen Linxuan <chenlinxuan@uniontech.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250416_024502_756304_024401D5 
X-CRM114-Status: GOOD (  14.26  )
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

On x86_64 with gcc version 13.3.0, I build drivers/nvme/host/pci.c
with:

  make defconfig
  ./scripts/kconfig/merge_config.sh .config <(
    echo CONFIG_BLK_DEV_NVME=m
  )
  make KCFLAGS="-fno-inline-small-functions -fno-inline-functions-called-once" \
    drivers/nvme/host/pci.o

Then I get a compile error:

    CALL    scripts/checksyscalls.sh
    DESCEND objtool
    INSTALL libsubcmd_headers
    CC      drivers/nvme/host/pci.o
  In file included from <command-line>:
  drivers/nvme/host/pci.c: In function 'nvme_init':
  ././include/linux/compiler_types.h:557:45: error: call to '__compiletime_assert_878' declared with attribute error: BUILD_BUG_ON failed: nvme_pci_npages_prp() > NVME_MAX_NR_ALLOCATIONS
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
  drivers/nvme/host/pci.c:3804:9: note: in expansion of macro 'BUILD_BUG_ON'
   3804 |         BUILD_BUG_ON(nvme_pci_npages_prp() > NVME_MAX_NR_ALLOCATIONS);
        |         ^~~~~~~~~~~~

Mark nvme_pci_npages_prp() with __always_inline make it can be computed
at compile time.

Co-developed-by: Chen Linxuan <chenlinxuan@uniontech.com>
Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
Signed-off-by: Winston Wen <wentao@uniontech.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b178d52eac1b7f7286e217226b9b3686d07b7b6c..9ab070a9f0372bc6595c29a884ee9f2ffe5ae8e9 100644
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
2.48.1



