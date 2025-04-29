Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5193C3ABAB
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Apr 2025 18:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:
	References:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Subject:Date:From:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=32GUHxOnJ3+ew70SHa0f65jKdkmGy6tQFDGoZR2Kj/Q=; b=42xJVDW8gNrfYICS2CHtSBbSFh
	O85Jsp6Ak5Rs8Vdgfq0AFunAcc35RRNHrfDjCHb4f4vyO0yG9vYO4Wab2HUoj4lQ+aD3NvXb/pElG
	uAVqXX2Bdnok08xwPdAW79i18LloqsqbR7D9kxtT6oKjDE9xTENUObeTACPvp99TZ0Kqf4BgXupXt
	DVJYB70XO0leF8mW2NjXTtG+K8kl8Nw0QSf0kEDDLPWxadHfPltL5tokdzxaiBKpnrwo8faoU/i/1
	Abc/vSf/t1ppNe3/qNiaxT5HDnF7sPyz+AG947iDn7pvM2ReuXXHJ8m+rMZVt0ck8fiKhYpVy2VI9
	VlvpMjSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9pbZ-0000000AW7h-2ZbO;
	Tue, 29 Apr 2025 18:22:53 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9cEd-00000008G4d-3Rcd
	for linux-nvme@lists.infradead.org;
	Tue, 29 Apr 2025 04:06:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D24B068429;
	Tue, 29 Apr 2025 04:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD555C4CEF1;
	Tue, 29 Apr 2025 04:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745899576;
	bh=pJ9VpLz2vL2PDt7J0K2cXMYeDKnStbQajileR/wxzK8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FyUVqYls/+KqU5DpInz9ZWqZ/4CAAzIPkLtTAq2+9vTbtkfDvRR2CjebexTY9QBGl
	 a18CtmbbDxF0tvb3AcYhTkIyRG0rGmIkJvOQyXGZmREvsxGc9clSCgXVDMI44bfCOB
	 RwUBZ5vLAptbw96/QZcz10zYj2Ww1cjxiuhaCIV1kmi57bliowHPSI7urlxZe9vKEG
	 oDldZTQDIsI86OtD5RmJoGS5Kqw98y9Y2hrIZWtmhbDW+Op3bNrJJxNcoQ6l/9xD1A
	 sZMVPjVE+TJH9Zf+qU8izf83pAhbghYD3h20CeX6p7lBgVhUV7G4DchS76qQNbjUfj
	 iEE1ouz0ZXZDA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4A1C3ABA6;
	Tue, 29 Apr 2025 04:06:16 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+chenlinxuan.uniontech.com@kernel.org>
Date: Tue, 29 Apr 2025 12:06:06 +0800
Subject: [PATCH RFC v3 2/8] mm: add __always_inline for
 page_contains_unaccepted
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-noautoinline-v3-2-4c49f28ea5b5@uniontech.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2614;
 i=chenlinxuan@uniontech.com; h=from:subject:message-id;
 bh=+y8wKlsn55GLtsirs4Essnozl8lVGDb1RUHKRb3UGRw=;
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBoEFAvQHTkSNXJxyOgEHVD9PhzBBGToDo54ToKB
 JTzQ3Bt13uJAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCaBBQLwAKCRB2HuYUOZmu
 i2wDD/94Tikof0KqTbmGNltSJN0BkZfS5swTBN23SRIvCigAsJMsSAEE8+hsOfF5ug0IHuwNOI/
 1Qnd48PesFnCihU7hm3JfucE304u3ikq3JpHS8byjD3Iq2171RsPQwl30uxz+vEZ8hzs0TpTQBL
 tbOgvO5HS5tVi2N8UEoiRrD/AIGE1AKJx646BKh7BWEfqlVn8Piwh3FS7UZcthV+4LqoV/TILJ5
 CqwIUJDj8ZerV5DorB5SDBkZEPqwYLdujwzVjj9cp8vZwKMj+w/cFPS+07AzMtQNZybB8QumHsU
 DHQmASWQEn05ggN/6NnlkKJvxaDxaREGdoSN4rVPnwenoh7XG44AwW+NWt2oRVUae7CdZaTJ02f
 UozQggCd6pQA5H1c2SG9aalj7diOg0zrkq7srXqL9aVnJGeGkbSHAIxpmoG3bA+uXmBJSKWtr2+
 7DF6eO6UhF2ql4ur4skO7HIRADaqOFdEcIXMoQ8iutz4ml3kKwVIMhsOOAXwoXgNTZw6dPFvTUK
 oOGrXVNKLy/fJX/0x7AiWVUMQSMsG/Kuios2R+atYaJYgzNmP+h2IF2Il+UfCg1zti1vGWy17fO
 jFSai1Av+dm6o4iuFeMJx4Tgo52MAnqfyksIfcNlB+/tDcM4IwZn3C7WTQp9uxdiHyZV0edPtRS
 Z2AKjqx+hU/5gsw==
X-Developer-Key: i=chenlinxuan@uniontech.com; a=openpgp;
 fpr=D818ACDD385CAE92D4BAC01A6269794D24791D21
X-Endpoint-Received: by B4 Relay for chenlinxuan@uniontech.com/default with
 auth_id=380
X-Original-From: Chen Linxuan <chenlinxuan@uniontech.com>
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

On x86_64 with gcc version 13.3.0, I compile mm/page_alloc.c with:

  make defconfig
  make KCFLAGS="-fno-inline-small-functions -fno-inline-functions-called-once" \
    mm/page_alloc.o

Then I get a compile error:

    CALL    scripts/checksyscalls.sh
    DESCEND objtool
    INSTALL libsubcmd_headers
    CC      mm/page_alloc.o
  In file included from <command-line>:
  mm/page_alloc.c: In function '__free_unaccepted.isra':
  ././include/linux/compiler_types.h:557:45: error: call to '__compiletime_assert_1013' declared with attribute error: BUILD_BUG failed
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
  ./include/linux/build_bug.h:59:21: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
        |                     ^~~~~~~~~~~~~~~~
  mm/page_alloc.c:7301:9: note: in expansion of macro 'BUILD_BUG'
   7301 |         BUILD_BUG();
        |         ^~~~~~~~~

Marking page_contains_unaccepted with __always_inline and let dead code
elimination remove reference to __free_unaccepted() here.

Co-developed-by: Chen Linxuan <chenlinxuan@uniontech.com>
Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
Signed-off-by: Winston Wen <wentao@uniontech.com>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5669baf2a6fea75c17b2be426443a6cf29051f52..433dc1936114469a323c8f3659730747965b2c3d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7346,7 +7346,7 @@ static bool __free_unaccepted(struct page *page)
 
 #else
 
-static bool page_contains_unaccepted(struct page *page, unsigned int order)
+static __always_inline bool page_contains_unaccepted(struct page *page, unsigned int order)
 {
 	return false;
 }

-- 
2.43.0



