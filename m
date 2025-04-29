Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E09C369DC
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Apr 2025 18:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:
	References:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Subject:Date:From:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n64EcHyNmqHMLJKJSLA0Q7usfRnpDI7HNDPkyY0l/1A=; b=wEDrCeN1gllnb3SIPp0xv0zEMU
	IScWjK9s7Nxs0Zuq6micEZ7n+Trj5vbb2VZGN1Jtz1W1GeuS4pFeKeJ0fly1DaokjznImgFADCzsx
	8LJKYPrUuoiBQ3XVD23XBgJMDEIZciHBceigERDqCX7WSw0gujntfztATX3R4Aypx2XLnJAFjjNPK
	Bbd60e4cP3N6zqSCL/PUgg0IAHPBt5VCGI9OQZWI06sbDnrEM0LtchyNxaKo8DCQpl+5nPbAsLgSR
	VrVcnCAJgD6DHPstW3wr+pSKkrsLvnMNdsiIXYAuzNOs6Q0EHj0oaaxbfATz/hpf3LjXkGMqM2yoN
	Ld9eNbBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9pbb-0000000AW9Z-3l67;
	Tue, 29 Apr 2025 18:22:55 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9cEd-00000008G4Q-0rIz
	for linux-nvme@lists.infradead.org;
	Tue, 29 Apr 2025 04:06:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 557A94A2B1;
	Tue, 29 Apr 2025 04:06:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D9C1C4CEF4;
	Tue, 29 Apr 2025 04:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745899577;
	bh=xaBPg6MMzZtyI5BynxGLu2CWzfYAh0y0igpwIukNl4w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rRQ75lu00znvBITjVyrAMVKtCn2AtPLSrSuYcoZf125A63zHSdMhkAi/HFUGNCNeK
	 J7X1yl7r0rN29gdmq5SsHcGn/T7CmDF/ID2Uvi7mvr0PFwvdGJmCpdOIysf5LfRnjC
	 1w21Gx6IhBsNzjDnYjd6ko75qTravedUuRFoDbjzIS1z9I6hCFuD3mi0z2GXS1i4t6
	 27AUHJ9cCIxoiAkllQIMQpLiz/s3c9V6KCvxFG9I9FzO5D6fpDGPZSi6DGeJKkmgmX
	 LtIjdVeuyd+wIT4KgskYvFdzQ7diMBplESrWTHBJv/Ah47o30uQF/CA+9DkHa7pT6h
	 70djD7BzAwDPA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BE0C3ABA8;
	Tue, 29 Apr 2025 04:06:17 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+chenlinxuan.uniontech.com@kernel.org>
Date: Tue, 29 Apr 2025 12:06:09 +0800
Subject: [PATCH RFC v3 5/8] rseq: add __always_inline for
 rseq_kernel_fields
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-noautoinline-v3-5-4c49f28ea5b5@uniontech.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1064;
 i=chenlinxuan@uniontech.com; h=from:subject:message-id;
 bh=yuauFI3DVy8k9g1XQ1OrB7eESWm7f+B3/2pt9syGKzM=;
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBoEFAyanc3Cwc7HAg/63YHY6NNSEBN2RhZfPBtP
 dtxoPOqXNeJAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCaBBQMgAKCRB2HuYUOZmu
 i7aID/44sv/mzy4WT2GTGw2LDhzFHfM+7rL13wS9xt+G7CMG4l6A0rduPv9Kj1+aTi8eOVMJft5
 5TiNxVdcrGKSr3zwVOY/PNRlc66oIZlthPkrupbFv0SD5r0m5xlYv9Q9WAMMOLU1a+CKw7KXlIK
 zUkQ0dGZaFEhfFS3giTzwyMqJS6nvmjb5iRc4Zz/XOtdtIIBsD6qlLRwQDdV4KuiKgfabOvMbeX
 C/d2ZrlzN8bw8uBY9bJS4LF4cptR+kay58eEnIn86mc9en18eq/l2Y01BEqmDWaad6N+FJDodwI
 pMr/+GVr6bsXlGZJ+sULeKleGffl4G1zIhAoz7H8I0oNmr/nSGd3Wn6BKIxuLhtVppnLY1KsvGa
 yf2RsSmPzJHLCXkfpLhDD/oicoxFl43gpHqaND1YU47v6537LXhTaUC1wslQX7j/d1+ujI4YwtF
 vOr8GQoQM+gOCkSVJLMdhN73NjDBDQByqvsYdot/uoc2GscYToCLN6G8w6S/yE1iwgbv9J0upsK
 hCjXyMYy0yLyfeIMCV/s3OTjYIs2fkUTwhR/5ByE/gU+4GGrFSrBbZP1FArrKKo834SUQ98QfUi
 V+gTyYTxvmL/HMhC3LP7oMkp9BWNsUvbCEi3F0KTEm/YPo52etQ+1LPa6z6VqhkHXnGwZSJcPtW
 crGc2BctRQzKvsw==
X-Developer-Key: i=chenlinxuan@uniontech.com; a=openpgp;
 fpr=D818ACDD385CAE92D4BAC01A6269794D24791D21
X-Endpoint-Received: by B4 Relay for chenlinxuan@uniontech.com/default with
 auth_id=380
X-Original-From: Chen Linxuan <chenlinxuan@uniontech.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250428_210619_293597_0251C250 
X-CRM114-Status: GOOD (  12.90  )
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

Presume that kernel is compiled for x86_64 with gcc version 13.3.0:

  make allmodconfig
  make KCFLAGS="-fno-inline-small-functions -fno-inline-functions-called-once"

This results some objtool warnings:

  vmlinux.o: warning: objtool: rseq_update_cpu_node_id+0x14c: call to rseq_kernel_fields() with UACCESS enabled
  vmlinux.o: warning: objtool: rseq_reset_rseq_cpu_node_id+0xef: call to rseq_kernel_fields() with UACCESS enabled

Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
---
 kernel/rseq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rseq.c b/kernel/rseq.c
index b7a1ec327e8117b47e353cab92d62111dd261520..7a4b6c211359714087a753047581bc8ff0c6c76b 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -27,7 +27,7 @@
 				  RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE)
 
 #ifdef CONFIG_DEBUG_RSEQ
-static struct rseq *rseq_kernel_fields(struct task_struct *t)
+static __always_inline struct rseq *rseq_kernel_fields(struct task_struct *t)
 {
 	return (struct rseq *) t->rseq_fields;
 }

-- 
2.43.0



