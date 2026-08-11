Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B34C5B572
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2026 15:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b3ArJhoaqsFvEuZHlfyWAtV6SGaCuVy7Av0qaKtOt1k=; b=unp7N7UUtncWldrPpmd9Y1s324
	+H5QU10KcsL5N7SGyKah2V3aYdxntDWM2D7VC7BtJ1K15o2NZr+DwURwIFTWU9eWNYYTQ/tBcR3kf
	qQE2ZG8YhMYlZ9oSCXUsGEsLnbdIpAhUAr4SXnJh+oDpzo4rdEfMDGESfDrEv1kSJv27Y6i0WaZFu
	kE+9Vv3EG6rGy1LLjnJswkc1GhyyjJfyMRgYgeC5FfahA/N4AdrExFwMwtrpUorRHfFlAV4CidQov
	4XI8NklRrQJ7ykzsondXHUqfM3lZGmpjHf/C7MVFgM1Gay635dyq9brv5FWA0/pVJ7B2l4KTjKe/8
	vPReXh+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuWvY-00000000tBx-3hYC;
	Thu, 13 Aug 2026 15:01:04 +0000
Received: from flow-b7-smtp.messagingengine.com ([202.12.124.142])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtqfM-0000000EhVN-19xg;
	Tue, 11 Aug 2026 17:53:33 +0000
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 2036D1300386;
	Tue, 11 Aug 2026 13:53:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 11 Aug 2026 13:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaseg.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786470809;
	 x=1786478009; bh=b3ArJhoaqsFvEuZHlfyWAtV6SGaCuVy7Av0qaKtOt1k=; b=
	ijtaT8kDvWYfd3yO7OtyiAlRE0ZIplb3TPK1W2M6BA10SuK0UgAtjcGX0oE3nhdJ
	PiZWC22o8wcjvWRNS/zjkaIimr0n9LVRM0tvbIy4UML1hZWjtYDZl+CiJ/g69qP2
	ha+ZWvdrDWeVRbtW49NmTxjxwlmhD+g2G718CyihW1245v+yYuBiLqm81Xi8pn+i
	lDW/+3bli1cJsp4GgqYBlW2dnGvdRyH5uazX0dA0QPmBy4llq+Ru3JmXd4W3Bfs1
	ON6eS3YwR6pclmES5s264NOV2erZgIAUuR+AxbOS0JUZEPv1qD5oKKpQj6wQnekz
	zP7bJ3Ky1wfC9BUlGo7URw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786470809; x=
	1786478009; bh=b3ArJhoaqsFvEuZHlfyWAtV6SGaCuVy7Av0qaKtOt1k=; b=F
	7n+tHYSFuWlN4o4SYZgF6PerK9cXZHzNOIbAIrxvG/Jw3R42BCKEUWgzv74DtCyw
	rUcgXzQbXuFLrIutTWJ1kejWT9+CRwoJUT9aiVCyOBR/uPiZRKpdwLiSB7PM5+/H
	BfnYe93/namBn1D+o63fBYUwZC/UaAvT2VSMRQLwopNnnawgjZ0iSlRNOa8tZqwO
	RR2uHPELbcTiJi77bnhtXa5CfyUJ8inB8K20y/BcPQe9YbbLeDiFu9vS1GRwTVts
	krh7NortTp/iCcQXgux/TCCZV620afOa+8s30z4mKCT0g8nwlQGQln4AY19Q6hjs
	GQdHtxAcicxAkr+1jlmwQ==
X-ME-Sender: <xms:mWF7ahBvdgF8epZoerAsdMmQKRY9NCiHXLY-iobD4PC7qsqhsgN0sA>
    <xme:mWF7amGXHNobEqvw6CXL66lse6ZIj-mUZTYnUwZsc4tt2a8LmkkPi0ScpExFULbgl
    Wf4JNbHgYmNYFzV7AmvfZn_wASXB3tZ8wNe-Zs5Yi0b-2rD7t2r>
X-ME-Received: <xmr:mWF7apUvnSnecSShUC5ABb58WPvKqOgvN6WDuAu48TYhsYwpXuTFlyHSdxt0uIjyD3MLG5iU0GKAHEjItUvhCCw>
X-ME-Proxy-Cause: dmFkZTFP5tmiXRyqpvhao8uWnDWsuVG58E3QcpY8nNF+TN3d4+2z3XaWQJ1+2uEKcUq9Jg
    +xH/KDfBOi31TfxVE5vy2aZ5W5Eono+bvv7mBiiNvVW/C9tjIvrxCLzv7Tz6GJOSvAG1cd
    t11+FzpQNbill+yp1ZC7JKPVzEaxQ4CH2HewKTU1gYEn0mNFldMXWgoBvZ/c5OhwLZogLW
    sZeOMCUfQY9vOvCjGHA0ivpYn+5HBy3sK6RswFREIaUm9jlhbU7pV5ZXGDLpJAMlUAJ/Lo
    y1vjaaTNNEiBF07QqH8YbZg0fsVTsE2lSAku2XiqZRlB3GAWdGnDFC/NxQNHJZjZwh0bAL
    NFU+sk1NjKbEiriHkWskXNqpRyiqngUiDobuBKM0QHx4IectPTiNVC0LAnkIil116cieth
    zlAJFqSExn0DMecmyqjTsWkD2ngU3mch+rJhp5ghpPvHYcUsU6CHEmiNL5gcm7pKojpoO8
    fUnDVi8q2D+tB3RNg8+bAG4knndc4v8UKvQON5b1dgXr5OKaBku6F7yXG1GPPJwkfrL7jQ
    EGcTagLVCnPlAjtfXZXy0P8J7sS0XyACESJHYYDdJ2OUni4Z+skjWf20Xpwr+zWL1ubmDC
    Ll6gwazrEjfo6CiwO2x+aWpiJNWOBFsNaCTo8jTyf1t3R3yZMgHWANJia/Qw
X-ME-Proxy: <xmx:mWF7akYLbKa4Ldqion9AVypKRG2td0FOiQT0IMdx4BEp4s2wNEAIiQ>
    <xmx:mWF7arB2K5jQ7vH9tLL3KCSU8nMwn0AZVF2DZWl1CPCuZItwReOsKA>
    <xmx:mWF7ahFAC4F5KSyCw9RpCBXNmmg4CQcvBQvPsk2Ct6QZdcB42lOoFw>
    <xmx:mWF7atDdhYqdhtincgzKdDhXKGMZ16JSVedWEWvxbhg-Z7VjwfQr3g>
    <xmx:mWF7arIkBDKrbmh1nTENBMBX06Dyq0TxrsND73UjyTyhqXlTGHTyLPQL>
Feedback-ID: i60a14417:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 13:53:23 -0400 (EDT)
From: =?utf-8?q?Jan_Sebastian_G=C3=B6tte?= <linux@jaseg.de>
Date: Tue, 11 Aug 2026 19:52:52 +0200
Subject: [PATCH v2 03/13] arm64/mm: add set_direct_map_default_nosplit()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260811-crash-zeroize-rework-v2-3-9561d13c2340@jaseg.de>
References: <20260811-crash-zeroize-rework-v2-0-9561d13c2340@jaseg.de>
In-Reply-To: <20260811-crash-zeroize-rework-v2-0-9561d13c2340@jaseg.de>
To: Andrew Morton <akpm@linux-foundation.org>,
  Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,
  Pratyush Yadav <pratyush@kernel.org>,
 Dave Young <ruirui.yang@linux.dev>,
  Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,  David Howells <dhowells@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>,  Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
  Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
  "Serge E. Hallyn" <serge@hallyn.com>, Lukas Wunner <lukas@wunner.de>,
  Ignat Korchagin <ignat@linux.win>,
 Herbert Xu <herbert@gondor.apana.org.au>,
  "David S. Miller" <davem@davemloft.net>,
 Keith Busch <kbusch@kernel.org>,  Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>,  Sagi Grimberg <sagi@grimberg.me>,
 Trond Myklebust <trondmy@kernel.org>,  Anna Schumaker <anna@kernel.org>,
 Mimi Zohar <zohar@linux.ibm.com>,
  James Bottomley <James.Bottomley@HansenPartnership.com>,
  Marc Dionne <marc.dionne@auristor.com>,
 Eric Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,
 Eric Biggers <ebiggers@kernel.org>,  "Theodore Y. Ts'o" <tytso@mit.edu>,
 Jaegeuk Kim <jaegeuk@kernel.org>,
  Alexander Viro <viro@zeniv.linux.org.uk>,
  Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
  Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
  Mikulas Patocka <mpatocka@redhat.com>,
  Benjamin Marzinski <bmarzins@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, 
 keyrings@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-crypto@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org, 
 linux-integrity@vger.kernel.org, linux-afs@lists.infradead.org, 
 netdev@vger.kernel.org, linux-fscrypt@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, dm-devel@lists.linux.dev, 
 =?utf-8?q?Jan_Sebastian_G=C3=B6tte?= <linux@jaseg.de>
X-Mailer: b4 0.15.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260811_105332_368642_8B273F49 
X-CRM114-Status: GOOD (  16.74  )
X-Mailman-Approved-At: Thu, 13 Aug 2026 08:01:01 -0700
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

set_direct_map_default_noflush() goes through split_kernel_leaf_mapping(),
which takes pgtable_split_lock and may sleep. That makes it unusable from
atomic contexts such as the panic path.

Add set_direct_map_default_nosplit(), which skips the split and only walks
the page tables to apply the permission change. Callers must guarantee the
page is already mapped at page granularity. This holds for any page that
had set_direct_map_invalid_noflush() applied to it, as that call performed
the split.

Architectures that do not need to split the linear map get a generic
fallback to set_direct_map_default_noflush().

Signed-off-by: Jan Sebastian Götte <linux@jaseg.de>
---
 arch/arm64/include/asm/set_memory.h |  2 ++
 arch/arm64/mm/pageattr.c            | 21 +++++++++++++++++++++
 include/linux/set_memory.h          | 17 ++++++++++++++++-
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/set_memory.h b/arch/arm64/include/asm/set_memory.h
index 90f61b17275e..cb5f44bb5a94 100644
--- a/arch/arm64/include/asm/set_memory.h
+++ b/arch/arm64/include/asm/set_memory.h
@@ -13,6 +13,8 @@ int set_memory_valid(unsigned long addr, int numpages, int enable);
 
 int set_direct_map_invalid_noflush(struct page *page);
 int set_direct_map_default_noflush(struct page *page);
+int set_direct_map_default_nosplit(struct page *page);
+#define set_direct_map_default_nosplit set_direct_map_default_nosplit
 int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid);
 bool kernel_page_present(struct page *page);
 
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index bbe98ac9ad8c..a7bb6bfa12ed 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -275,6 +275,27 @@ int set_direct_map_default_noflush(struct page *page)
 				 PAGE_SIZE, set_mask, clear_mask);
 }
 
+/* Caller must guarantee @page is already mapped at page granularity. */
+int set_direct_map_default_nosplit(struct page *page)
+{
+	struct page_change_data data = {
+		.set_mask = __pgprot(PTE_PRESENT_VALID_KERNEL | PTE_WRITE),
+		.clear_mask = __pgprot(PTE_PRESENT_INVALID | PTE_RDONLY),
+	};
+	unsigned long addr = (unsigned long)page_address(page);
+	int ret;
+
+	if (!can_set_direct_map())
+		return 0;
+
+	lazy_mmu_mode_enable();
+	ret = walk_kernel_page_table_range_lockless(addr, addr + PAGE_SIZE,
+						    &pageattr_ops, NULL, &data);
+	lazy_mmu_mode_disable();
+
+	return ret;
+}
+
 static int __set_memory_enc_dec(unsigned long addr,
 				int numpages,
 				bool encrypt)
diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
index 3030d9245f5a..65d0fa010368 100644
--- a/include/linux/set_memory.h
+++ b/include/linux/set_memory.h
@@ -44,7 +44,22 @@ static inline bool kernel_page_present(struct page *page)
 {
 	return true;
 }
-#else /* CONFIG_ARCH_HAS_SET_DIRECT_MAP */
+#endif /* !CONFIG_ARCH_HAS_SET_DIRECT_MAP */
+
+/*
+ * Variant of set_direct_map_default_noflush() that is safe to call from atomic
+ * context, for pages the caller knows are already mapped at page granularity.
+ * Architectures that need to split the linear map, and can therefore sleep,
+ * override this.
+ */
+#ifndef set_direct_map_default_nosplit
+static inline int set_direct_map_default_nosplit(struct page *page)
+{
+	return set_direct_map_default_noflush(page);
+}
+#endif
+
+#ifdef CONFIG_ARCH_HAS_SET_DIRECT_MAP
 /*
  * Some architectures, e.g. ARM64 can disable direct map modifications at
  * boot time. Let them overrive this query.

-- 
2.53.0


