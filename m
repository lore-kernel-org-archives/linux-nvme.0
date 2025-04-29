Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1610C3ABAB
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Apr 2025 18:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:
	References:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Subject:Date:From:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g7sk4q6Sp0j7WMJWmbDXr1gH90ymfRktmXXkTzZ9J5o=; b=3t2j1FBaX63/UZdGV1dZdFU/xY
	Ak9gvTCcMtX4jwKymJIRa6XRqv1sarlZVZaV7K3tEOcUZomH4KypFH7Z/BFI0HvvtNjR4fhlcxNIP
	K9eNIsj+ZbYDNle1aQaTs1MpxQYnTUfIYU7h6tGqKjJSfRcoKYuIjZiqIz0VS7IQ2lRtbzOm4sCna
	JBrCiXnhd6NDihtW1UFto+kQR7riABdBPARECqxv99pTrdBTVYdk8wA4g078dILPnKILuuAGsWEQc
	1ageRh9U2pf+pqxYTd8YkYxUVfWsaxxZnyiyuI4/qsf6ltByy0jdGsg82N9mAspWQjAAdH8rHLmqd
	j0vg0Atg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9pbe-0000000AWCi-1grh;
	Tue, 29 Apr 2025 18:22:58 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9cEk-00000008GAx-0lZp
	for linux-nvme@bombadil.infradead.org;
	Tue, 29 Apr 2025 04:06:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Reply-To:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Content-ID:Content-Description;
	bh=g7sk4q6Sp0j7WMJWmbDXr1gH90ymfRktmXXkTzZ9J5o=; b=RE5ndlUy+gkg0/nyDJcwlHICnQ
	LS56FaPD5e9YUE2g80gnytNbMYzEoDU3WZwLC4hMMSFwmSHneDiUJYhR97TXGHQkz5yWrQDilaq9s
	BM/jsSkDSbsnfq70uf3bFpYLKENSPJGukIXC11La2X/ZjMgntYdyyq/C4Yk1ZgGMK5zQN3DaY+HkV
	vplO2I3uMtAM5YWy3vloAj9uZ8gnFBlvh3AulwinwmDoHKVtDA2T+AYptiSwGwDijGw/ooQOFH929
	Z1SMHWEfg9439aPe9kLSYws6vWsgx3woMfvP2oz70YJWpg5UUBuiMssimxXPt0kFrwxPoo/1/JEmh
	c4hrKRxQ==;
Received: from sea.source.kernel.org ([172.234.252.31])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u9cEg-0000000DBYh-30VM
	for linux-nvme@lists.infradead.org;
	Tue, 29 Apr 2025 04:06:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 637724A2F1;
	Tue, 29 Apr 2025 04:06:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 469C7C4CEF3;
	Tue, 29 Apr 2025 04:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745899577;
	bh=puwaWg0YW0DjsEBEYIoY8x/bLms2MxI/ob3ZfklRDPw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=c0NlFGD/nhB9z6/D4xtydBdI9lJs5L3xbB+eo5cTRMg4n9RpEdjaAhdvc2frC/XoC
	 5Lj5jHazpgfih7eU9Ip8zL87n2W5/Y7Xl7J5MUrNvUFI2sb3RB4BqU5pWTALmAZxrL
	 regj0Ag6HkRUHS3xBvMdE2pb2vrLgesn1qt2AbGY8HXFnjIdmTVcNrNrmloKS1de70
	 gu28EB9CLlaP68ai4PHXtKJqNUO/eYwYJM4vU8DspesAceo2GgBqak5RBzqxLyJenI
	 KBmESNyXPRuCOOdoZcRlGFtuk67AXj0qsy35tYZK+DJvG69bCPTNEcNR9Ad1mpMaJl
	 Y5LlZLpxc/FHA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A16FC369CB;
	Tue, 29 Apr 2025 04:06:17 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+chenlinxuan.uniontech.com@kernel.org>
Date: Tue, 29 Apr 2025 12:06:11 +0800
Subject: [PATCH RFC v3 7/8] x86/xen: add __init for xen_pgd_walk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-noautoinline-v3-7-4c49f28ea5b5@uniontech.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1213;
 i=chenlinxuan@uniontech.com; h=from:subject:message-id;
 bh=lLv+eC36iR+BfXD2pJvuB8T7k1wRLfuYuYg6Rtr4yeI=;
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBoEFA0cu56sCmDMkf/pntxUHuMuekP/XRkxukwU
 9g4TyNMqLaJAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCaBBQNAAKCRB2HuYUOZmu
 i6oqEACNTdOu+wT9VWzDqaJxYPJzTDzhyaDgOrIaxGP72CExKq84a645B1Jl3TWZN1v4YEQN+Ex
 U4BBfSuuQ9Yh0TKak7F0oJPgeJp4PeTVBP15tbocmZJmYUHXdJX5kcB6+MgIe90/7/tlKRXQlN5
 uY8GMIazOdRrWgafA6k6G+0lJvn3E3R5v7129rFXvHWCYC7Nvp2Vr8gyxE2IYJVHEfZx/+ua0oe
 z4a0WQgFS0t6W9PacgGnUTntuj/TGKVYb500Jwut0dBDJITdWXpackuvyCzviwumgxcGnbW66J/
 sPOW9GIhrql6r3JIF1vU1iTJ1wxWyv8Al2Yy2Y7j9ypL0F07+xTB5euDs2A9h8HHd2x+0MwnqRD
 4T62VOpuvuHAy1CMHBv75g1GHhwTGMN1KwfuI0Pf0TXrf9JM01deVHQ7vjI5kZhyeYMl537pJVJ
 0itemi/gfnvcGViZ8usYXjp9yKtWO3JsSCn31sNT7BwsAtjyIUQl+DeQyQADc9wUchfIkTRw2AT
 nXmGd9l2kspY+Bd3KtnokiL1Gm1q49EmDFnwJw+FvsjxRdcZ56x9pI1MXcoOzCJNGSxYn35Witw
 vt49LNms8G/08qnrm3qBl6k+q0+gMBVS+JCmJst68knEU97MDg5chkLEEiEkEAzZLrlhGHN4eU8
 gFY2uFKRqDDEdqA==
X-Developer-Key: i=chenlinxuan@uniontech.com; a=openpgp;
 fpr=D818ACDD385CAE92D4BAC01A6269794D24791D21
X-Endpoint-Received: by B4 Relay for chenlinxuan@uniontech.com/default with
 auth_id=380
X-Original-From: Chen Linxuan <chenlinxuan@uniontech.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_050623_245779_7FBD9942 
X-CRM114-Status: GOOD (  14.59  )
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

This results a modpost warning:

  WARNING: modpost: vmlinux: section mismatch in reference: xen_pgd_walk+0x42 (section: .text) -> xen_mark_pinned (section: .init.text)

As xen_pgd_walk is only referenced in xen_after_bootmem(void) which is
also in .init.text, I add __init for xen_pgd_walk to fix this issue.

Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
---
 arch/x86/xen/mmu_pv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 38971c6dcd4b78b6b14f51bc69c4bf6b70ebd622..53650888be0a7b1dba170a5b7ba9c654244b5125 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -696,7 +696,7 @@ static void __xen_pgd_walk(struct mm_struct *mm, pgd_t *pgd,
 	(*func)(mm, virt_to_page(pgd), PT_PGD);
 }
 
-static void xen_pgd_walk(struct mm_struct *mm,
+static void __init xen_pgd_walk(struct mm_struct *mm,
 			 void (*func)(struct mm_struct *mm, struct page *,
 				      enum pt_level),
 			 unsigned long limit)

-- 
2.43.0



